"""
The ``.w3xd`` container: layout, license recovery and decryption.

Layout, *after* the layer-1 XOR has been undone
-----------------------------------------------

::

    offset 0x00                  prefix
    offset 0x47   10 bytes       CCM nonce
    offset 0x51    2 bytes
    offset 0x53   16 bytes       CCM tag
    offset 0x63 .. hdr_size      rest of the header
    offset hdr_size              payload_size bytes of AES-256-CCM ciphertext
    offset size-0x40  64 bytes   trailer

Trailer (validated field by field by the game, RVA ``0x1511F40``)::

    +0x00  u8  = 1
    +0x01  u8  = 6
    +0x02  u16 = 0x40                size of this block
    +0x04  u16 = hdr_size            >= 0x6c, and hdr+payload+0x40 == file size
    +0x06  u64 = payload_size
    +0x0e  u64 = license             64-bit product license
    +0x16  22 zero bytes             <-- known plaintext
    +0x2c  20 byte digest

Recovering the license without knowing it
-----------------------------------------

The 22 zero bytes at ``+0x16`` are known plaintext, so for those positions the
XOR keystream equals the ciphertext.  A keystream byte is ``low8(S[p+1])`` and
``S`` is produced by a linear recurrence, so those 22 bytes give 176 equations
over GF(2) in the 32 unknown bits of the state.  Solving them yields the state,
and hence the whole keystream and the license in the trailer.  A random file
satisfies the system with probability about ``2**-144``.
"""

import struct

from . import ccm, kdf, xorshift
from .aes import new_aes

MPQ_MAGIC = b"MPQ\x1a"
HM3W_MAGIC = b"HM3W"
TRAILER_LEN = 0x40
MIN_HDR = 0x6C
ZERO_OFF, ZERO_LEN = 0x16, 22
NONCE_OFF, TAG_OFF = 0x47, 0x53

_MAT_CACHE = {}


class W3xdError(Exception):
    pass


# ---------------------------------------------------------------- GF(2) solve
def _mat_pow(n, nb):
    """Powers of the xorshift step as 32x32 bit matrices over GF(2)."""
    key = (n, nb)
    if key in _MAT_CACHE:
        return _MAT_CACHE[key]
    ident = [1 << i for i in range(32)]
    step = xorshift.step
    base = [0] * 32
    for j in range(32):
        v = step(1 << j)
        for i in range(32):
            if (v >> i) & 1:
                base[i] |= 1 << j

    def mul(A, B):
        out = [0] * 32
        for i in range(32):
            m, r = B[i], 0
            while m:
                b = m & -m
                r ^= A[b.bit_length() - 1]
                m ^= b
            out[i] = r
        return out

    R, e, base_e = ident, n, base
    while e:
        if e & 1:
            R = mul(base_e, R)
        base_e = mul(base_e, base_e)
        e >>= 1
    if len(_MAT_CACHE) < 4096:
        _MAT_CACHE[key] = R
    return R


def _solve_gf2(eqs):
    """Gaussian elimination; returns a particular solution or None."""
    piv = {}
    for row, rhs in eqs:
        while row:
            p = row.bit_length() - 1
            if p in piv:
                pr, pv = piv[p]
                row ^= pr
                rhs ^= pv
            else:
                piv[p] = (row, rhs)
                break
        else:
            if rhs:
                return None
    sol = 0
    for p in sorted(piv):
        row, rhs = piv[p]
        if rhs ^ (bin(sol & (row & ~(1 << p))).count("1") & 1):
            sol |= 1 << p
    return sol


def recover_state(data):
    """Initial xorshift state, from the trailer's 22 known zero bytes.

    Returns ``None`` if the constraints are inconsistent, which means ``data``
    is not a .w3xd container.
    """
    n = len(data)
    if n < MIN_HDR + TRAILER_LEN:
        return None
    T = n - TRAILER_LEN
    eqs = []
    for j in range(ZERO_LEN):
        pos = T + ZERO_OFF + j
        rows = _mat_pow(pos + 1, 32)[:8]      # low byte of S[pos+1]
        ct = data[pos]
        for bit in range(8):
            eqs.append((rows[bit], (ct >> bit) & 1))
    return _solve_gf2(eqs)


# ---------------------------------------------------------------- container
def parse_trailer(plain):
    tr = plain[len(plain) - TRAILER_LEN:]
    return {
        "version": tr[0],
        "flags": tr[1],
        "block_size": struct.unpack_from("<H", tr, 2)[0],
        "hdr_size": struct.unpack_from("<H", tr, 4)[0],
        "payload_size": struct.unpack_from("<Q", tr, 6)[0],
        "license": struct.unpack_from("<Q", tr, 0x0E)[0],
        "digest": tr[0x2C:0x40],
        "zeros_ok": all(tr[ZERO_OFF + j] == 0 for j in range(ZERO_LEN)),
    }


def looks_like_mpq(block):
    if len(block) < 16 or block[:4] != MPQ_MAGIC:
        return False
    hdr_size, arch_size = struct.unpack_from("<II", block, 4)
    return hdr_size == 0x20 and 512 < arch_size <= 512 * 1024 * 1024


def find_nonce(aes, plain, t, scan=0x400):
    """Offsets in the header whose 10-byte window decrypts the payload to MPQ."""
    hdr, payload = t["hdr_size"], plain[t["hdr_size"]:]
    hits = []
    for off in range(0, max(0, min(hdr, scan) - ccm.NONCE_LEN + 1)):
        nonce = plain[off:off + ccm.NONCE_LEN]
        blk = ccm.first_plaintext_block(aes, nonce, payload, 16)
        if looks_like_mpq(blk) or blk[:4] == HM3W_MAGIC:
            hits.append(off)
    return hits


def find_tag(aes, plain, t, nonce_off):
    """Locate the tag and return ``(offset, plaintext)`` or ``(None, None)``."""
    hdr, pl = t["hdr_size"], t["payload_size"]
    nonce = plain[nonce_off:nonce_off + ccm.NONCE_LEN]
    ct = plain[hdr:hdr + pl]
    quick = nonce_off + 12
    order = ([quick] if quick + ccm.TAG_LEN <= hdr else [])
    order += [m for m in range(0, max(0, hdr - ccm.TAG_LEN + 1)) if m != quick]
    order.append(hdr + pl)
    for off in order:
        tag = plain[off:off + ccm.TAG_LEN]
        if len(tag) < ccm.TAG_LEN:
            continue
        try:
            return off, ccm.decrypt(aes, nonce, ct, tag)
        except ValueError:
            continue
    return None, None


class Container:
    """A decrypted .w3xd; ``plaintext`` is the payload as a normal MPQ."""

    def __init__(self, raw):
        self.raw = raw
        self.size = len(raw)
        seed = recover_state(raw)
        if seed is None:
            raise W3xdError("not a .w3xd container (trailer constraints fail)")
        self.seed = seed
        self.layer1 = xorshift.xor(raw, seed)
        self.trailer = parse_trailer(self.layer1)
        t = self.trailer
        if not (t["version"] == 1 and t["block_size"] == TRAILER_LEN
                and t["zeros_ok"]):
            raise W3xdError("trailer does not validate")
        if t["hdr_size"] + t["payload_size"] + TRAILER_LEN != self.size:
            raise W3xdError("header/payload sizes do not add up to the file size")
        # cross-check the recovered seed against the documented formula
        self.seed_matches_formula = (
            seed == xorshift.seed_from(self.size, t["license"]))
        self.key = kdf.derive_key(t["license"])
        self.aes = new_aes(self.key)
        self.nonce_off = None
        self.tag_off = None
        self.payload = None

    @classmethod
    def from_file(cls, path):
        with open(path, "rb") as fh:
            return cls(fh.read())

    @property
    def license(self):
        return self.trailer["license"]

    @property
    def hdr_size(self):
        return self.trailer["hdr_size"]

    @property
    def payload_size(self):
        return self.trailer["payload_size"]

    def decrypt_payload(self):
        """Verify the CCM tag, decrypt and return the plain MPQ bytes."""
        if self.payload is not None:
            return self.payload
        hits = find_nonce(self.aes, self.layer1, self.trailer)
        if not hits:
            raise W3xdError("no CCM nonce found (payload is not a plain MPQ?)")
        self.nonce_off = hits[0]
        off, pt = find_tag(self.aes, self.layer1, self.trailer, self.nonce_off)
        if pt is None:
            raise W3xdError("CCM tag verification failed")
        self.tag_off = off
        self.payload = pt
        return pt


# ---------------------------------------------------------------- test helper
def build(license_id, mpq_bytes, hdr_size=0x9A, nonce=None, prefix_size=0x47):
    """Build a synthetic .w3xd around ``mpq_bytes`` (used by the tests).

    Mirrors the shipped layout: prefix, nonce, 2 pad bytes, tag, header tail,
    payload, trailer.
    """
    nonce = nonce or bytes(range(10))
    aes = new_aes(kdf.derive_key(license_id))
    ct, tag = ccm.encrypt(aes, nonce, mpq_bytes)

    total = hdr_size + len(ct) + TRAILER_LEN
    hdr = bytearray(hdr_size)
    hdr[prefix_size:prefix_size + len(nonce)] = nonce
    hdr[prefix_size + len(nonce) + 2:prefix_size + len(nonce) + 2 + len(tag)] = tag

    trailer = bytearray(TRAILER_LEN)
    trailer[0] = 1
    trailer[1] = 6
    struct.pack_into("<H", trailer, 2, TRAILER_LEN)
    struct.pack_into("<H", trailer, 4, hdr_size)
    struct.pack_into("<Q", trailer, 6, len(ct))
    struct.pack_into("<Q", trailer, 0x0E, license_id)
    # +0x16 stays zero, +0x2c digest is not checked by this tool

    plain = bytes(hdr) + ct + bytes(trailer)
    if len(plain) != total:
        raise AssertionError("size mismatch")
    return xorshift.xor(plain, xorshift.seed_from(total, license_id))
