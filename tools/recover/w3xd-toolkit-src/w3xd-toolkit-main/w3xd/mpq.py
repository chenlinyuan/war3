"""
A minimal MPQ reader, tuned for the archives inside Reforged 3.0 ``.w3xd``
containers.

Three things these archives do that trip up a stock MPQ reader
--------------------------------------------------------------

1. **The hash table index uses hash type 0.**  Type 3 is ``MPQ_HASH_FILE_KEY``,
   used for decrypting file data.  Using type 3 for the lookup makes every name
   lookup fail even though the names are present.

2. **Every sector-based member carries a sector offset table**, even when the
   member is not encrypted.  It can be detected because
   ``offset[0] == (nsectors + 1) * 4``.  A stock reader only expects the table
   for encrypted members and will misparse the rest.

3. **The zlib streams have a wrong trailing Adler-32.**  The deflate data
   itself is intact (the inflated length equals the declared size), so
   inflating with raw deflate after skipping the 2-byte zlib header works.
   ``(listfile)`` and ``(attributes)`` are additionally encrypted with
   FIX_KEY, whose key is recovered from known plaintext below.
"""

import os
import struct
import zlib

MPQ_MAGIC = b"MPQ\x1a"

FLAG_EXISTS = 0x80000000
FLAG_SINGLE_UNIT = 0x01000000
FLAG_COMPRESS = 0x00000200
FLAG_ENCRYPTED = 0x00010000
FLAG_FIX_KEY = 0x00020000

HASH_TABLE_INDEX, HASH_NAME_A, HASH_NAME_B, HASH_FILE_KEY = 0, 1, 2, 3

FIXKEY_NAMES = ("(listfile)", "(attributes)", "(signature)", "(patch_metadata)")

#: Standard Warcraft III map members, used to name blocks when the archive has
#: no readable ``(listfile)``.
STANDARD_NAMES = (
    "war3map.w3i", "war3map.w3e", "war3map.wts", "war3map.j", "war3map.lua",
    "war3map.luac", "war3map.doo", "war3mapUnits.doo", "war3map.shd",
    "war3map.mmp", "war3map.wpm", "war3map.wtg", "war3map.wct", "war3map.imp",
    "war3map.w3s", "war3map.w3r", "war3map.w3c", "war3map.w3d", "war3map.w3q",
    "war3map.w3a", "war3map.w3b", "war3map.w3u", "war3map.w3t", "war3map.w3h",
    "war3map.w3o", "war3map.w3f", "war3map.w3v", "war3map.w3p", "war3map.w3l",
    "war3map.w3grp", "war3mapMap.blp", "war3mapMap.tga", "war3mapPreview.tga",
    "war3mapPreview.blp", "war3mapPath.tga", "war3mapExtra.txt",
    "war3mapMisc.txt", "war3mapSkin.txt", "war3mapSkin.w3a", "war3mapSkin.w3b",
    "war3mapSkin.w3d", "war3mapSkin.w3h", "war3mapSkin.w3q", "war3mapSkin.w3t",
    "war3mapSkin.w3u", "conversation.json", "Scripts\\war3map.lua",
) + FIXKEY_NAMES


def _build_crypt_table():
    table = [0] * 0x500
    seed = 0x00100001
    for i in range(0x100):
        for j in range(5):
            seed = (seed * 125 + 3) % 0x2AAAAB
            temp = (seed & 0xFFFF) << 16
            seed = (seed * 125 + 3) % 0x2AAAAB
            temp |= seed & 0xFFFF
            table[i + j * 0x100] = temp & 0xFFFFFFFF
    return table


CRYPT = _build_crypt_table()


def hashes(name, htype):
    """One of the four MPQ hashes of a member name."""
    if isinstance(name, bytes):
        name = name.decode("latin1")
    seed1, seed2 = 0x7FED7FED, 0xEEEEEEEE
    for ch in name.upper():
        c = ord(ch)
        seed1 = (CRYPT[htype * 0x100 + c] ^ (seed1 + seed2)) & 0xFFFFFFFF
        seed2 = (c + seed1 + seed2 + (seed2 << 5) + 3) & 0xFFFFFFFF
    return seed1


def mpq_decrypt(data, key):
    seed1, seed2 = key & 0xFFFFFFFF, 0xEEEEEEEE
    out = bytearray(len(data))
    for i in range(0, len(data) - 3, 4):
        seed2 = (seed2 + CRYPT[0x400 + (seed1 & 0xFF)]) & 0xFFFFFFFF
        ch = struct.unpack_from("<I", data, i)[0]
        plain = (ch ^ (seed1 + seed2)) & 0xFFFFFFFF
        seed1 = (((~seed1 << 21) + 0x11111111) | (seed1 >> 11)) & 0xFFFFFFFF
        seed2 = (plain + seed2 + (seed2 << 5) + 3) & 0xFFFFFFFF
        struct.pack_into("<I", out, i, plain)
    return bytes(out)


def mpq_encrypt(data, key):
    """Inverse of :func:`mpq_decrypt`.

    It is *not* an involution: ``seed2`` evolves from the plaintext, so
    encrypting needs its own routine.  Provided so archives can be written
    back and so the reader can be round-trip tested.
    """
    seed1, seed2 = key & 0xFFFFFFFF, 0xEEEEEEEE
    out = bytearray(len(data))
    for i in range(0, len(data) - 3, 4):
        seed2 = (seed2 + CRYPT[0x400 + (seed1 & 0xFF)]) & 0xFFFFFFFF
        plain = struct.unpack_from("<I", data, i)[0]
        ch = (plain ^ (seed1 + seed2)) & 0xFFFFFFFF
        seed1 = (((~seed1 << 21) + 0x11111111) | (seed1 >> 11)) & 0xFFFFFFFF
        seed2 = (plain + seed2 + (seed2 << 5) + 3) & 0xFFFFFFFF
        struct.pack_into("<I", out, i, ch)
    return bytes(out)


def norm_name(name):
    """MPQ stores names with backslashes; war3map.imp often uses slashes."""
    return name.replace("/", "\\")


def inflate(body):
    """zlib / raw deflate, tolerating a bad trailing checksum."""
    if not body:
        return None
    if body[0] == 0x78 and len(body) > 2 and ((body[0] << 8) | body[1]) % 31 == 0:
        try:
            return zlib.decompressobj(-15).decompress(body[2:])
        except zlib.error:
            pass
    try:
        return zlib.decompress(body)
    except zlib.error:
        return None


def _decompress_unit(data):
    if not data:
        return None
    mask, body = data[0], data[1:]
    if mask == 0:
        return data
    if mask & 0x02:
        got = inflate(body)
        return got if got is not None else data
    return data


class MPQ:
    """Read-only MPQ archive."""

    def __init__(self, path):
        self.path = path
        with open(path, "rb") as fh:
            self.d = fh.read()
        if self.d[:4] != MPQ_MAGIC:
            raise ValueError("not an MPQ archive")
        (self.hdr_size, self.arch_size, self.fmt, self.block_shift, self.ht_pos,
         self.bt_pos, self.ht_count, self.bt_count) = struct.unpack_from("<IIHHIIII", self.d, 4)
        if self.block_shift > 20:
            raise ValueError("implausible sector size")
        self.sector_size = 512 << self.block_shift
        self._read_tables()

    @classmethod
    def from_bytes(cls, path, data):
        import io
        obj = cls.__new__(cls)
        obj.path = path
        obj.d = data
        if data[:4] != MPQ_MAGIC:
            raise ValueError("not an MPQ archive")
        (obj.hdr_size, obj.arch_size, obj.fmt, obj.block_shift, obj.ht_pos,
         obj.bt_pos, obj.ht_count, obj.bt_count) = struct.unpack_from("<IIHHIIII", data, 4)
        obj.sector_size = 512 << obj.block_shift
        obj._read_tables()
        return obj

    def _read_tables(self):
        raw = self.d[self.ht_pos:self.ht_pos + self.ht_count * 16]
        ht = mpq_decrypt(raw, hashes("(hash table)", HASH_FILE_KEY))
        self.hash_table = [struct.unpack_from("<IIHHI", ht, i * 16)
                           for i in range(self.ht_count)]
        raw = self.d[self.bt_pos:self.bt_pos + self.bt_count * 16]
        bt = mpq_decrypt(raw, hashes("(block table)", HASH_FILE_KEY))
        self.block_table = [struct.unpack_from("<IIII", bt, i * 16)
                            for i in range(self.bt_count)]

    # ------------------------------------------------------------------ names
    def find(self, name):
        """Block index for ``name``, or ``None``.

        Uses hash type 0 for the table index -- see the module docstring.
        """
        name = norm_name(name)
        ha, hb = hashes(name, HASH_NAME_A), hashes(name, HASH_NAME_B)
        idx = hashes(name, HASH_TABLE_INDEX) & (self.ht_count - 1)
        for probe in range(self.ht_count):
            i = (idx + probe) & (self.ht_count - 1)
            a, b, _loc, _plat, blk = self.hash_table[i]
            if blk == 0xFFFFFFFF:
                return None
            if a == ha and b == hb:
                return blk
        return None

    def name_of(self, block):
        """Best-effort name for a block, from a dictionary of standard members."""
        by_hash = {(e[0], e[1]): e[4] for e in self.hash_table if e[4] != 0xFFFFFFFF}
        for n in STANDARD_NAMES:
            if by_hash.get((hashes(n, HASH_NAME_A), hashes(n, HASH_NAME_B))) == block:
                return n
        return None

    # ------------------------------------------------------------------- read
    def recover_fixkey(self, block):
        """Key recovery for FIX_KEY members, from the known offset table head.

        The offset table must start with ``(nsectors+1)*4`` and MPQ's first
        decrypted word is ``plain0 = ct0 ^ (key + 0xEEEEEEEE
        + CRYPT[0x400 + (key & 0xFF)])``, so trying the 256 possible low bytes
        of the key yields the key directly.
        """
        pos, csize, fsize, flags = self.block_table[block]
        ns = max(1, (fsize + self.sector_size - 1) // self.sector_size)
        tsz = (ns + 1) * 4
        blob = self.d[pos:pos + csize]
        if len(blob) < tsz:
            return None
        ct0 = struct.unpack_from("<I", blob, 0)[0]
        for klo in range(256):
            seed2 = (0xEEEEEEEE + CRYPT[0x400 + klo]) & 0xFFFFFFFF
            key = ((ct0 ^ tsz) - seed2) & 0xFFFFFFFF
            if (key & 0xFF) != klo:
                continue
            offs = list(struct.unpack_from(
                "<%dI" % (ns + 1), mpq_decrypt(blob[:tsz], key), 0))
            if (offs[0] == tsz and offs[ns] == csize
                    and all(offs[i] <= offs[i + 1] for i in range(ns))):
                return key, offs, ns
        return None

    def read_block(self, block, name=None):
        pos, csize, fsize, flags = self.block_table[block]
        if not (flags & FLAG_EXISTS):
            return None
        blob = self.d[pos:pos + csize]

        if flags & FLAG_SINGLE_UNIT:
            if flags & FLAG_ENCRYPTED:
                base = 0xFFFFFFFF if (flags & FLAG_FIX_KEY) else (
                    hashes(os.path.basename(norm_name(name or "")), HASH_FILE_KEY)
                    if name else 0xFFFFFFFF)
                blob = mpq_decrypt(blob, (base + block) & 0xFFFFFFFF)
            return _decompress_unit(blob) if (flags & FLAG_COMPRESS and csize < fsize) else blob

        ns = max(1, (fsize + self.sector_size - 1) // self.sector_size)
        if flags & FLAG_ENCRYPTED and (flags & FLAG_FIX_KEY):
            got = self.recover_fixkey(block)
            if got is None:
                return None
            key, offs, ns = got
        else:
            key = None
            if flags & FLAG_ENCRYPTED:
                base = (hashes(os.path.basename(norm_name(name or "")), HASH_FILE_KEY)
                        if name else 0xFFFFFFFF)
                key = (base + block) & 0xFFFFFFFF
            tsz = (ns + 1) * 4
            raw = blob[:tsz]
            if struct.unpack_from("<I", blob, 0)[0] == tsz:
                if key is not None:
                    raw = mpq_decrypt(raw, (key - 1) & 0xFFFFFFFF)
                offs = list(struct.unpack_from("<%dI" % (ns + 1), raw, 0))
            elif key is not None:
                offs = list(struct.unpack_from(
                    "<%dI" % (ns + 1),
                    mpq_decrypt(raw, (key - 1) & 0xFFFFFFFF), 0))
            else:
                offs = None

        out = bytearray()
        for i in range(ns):
            if offs is not None and i + 1 < len(offs):
                start, end = offs[i], offs[i + 1]
            else:
                start = i * self.sector_size + ((ns + 1) * 4 if offs is None else 0)
                end = start + self.sector_size
            sec = blob[start:end]
            if key is not None:
                sec = mpq_decrypt(sec, (key + (1 if flags & FLAG_FIX_KEY else 0) + i) & 0xFFFFFFFF)
            if flags & FLAG_COMPRESS and len(sec) < self.sector_size:
                got = _decompress_unit(sec)
                if got is not None:
                    sec = got
            out += sec
            if len(out) >= fsize:
                break
        return bytes(out[:fsize])

    def read(self, name):
        blk = self.find(name)
        if blk is None:
            return None
        return self.read_block(blk, norm_name(name))

    # ------------------------------------------------------------------ names
    def list_names(self):
        """Names from ``(listfile)``; ``[]`` if it is absent or unreadable."""
        blk = self.find("(listfile)")
        if blk is None:
            return []
        raw = self.read_block(blk, "(listfile)")
        if not raw:
            return []
        txt = raw.decode("latin1").replace("\r\n", "\n").replace("\r", "\n")
        return [norm_name(x.strip()) for x in txt.split("\n") if x.strip()]

    def members(self):
        """Yield ``(name, bytes)`` for every member.

        Names come from ``(listfile)`` when available, else from a small set of
        standard names, else ``_unknown_blkNNN``.
        """
        by_hash = {(e[0], e[1]): e[4] for e in self.hash_table if e[4] != 0xFFFFFFFF}
        block_name = {}
        for n in self.list_names():
            blk = by_hash.get((hashes(n, HASH_NAME_A), hashes(n, HASH_NAME_B)))
            if blk is not None:
                block_name.setdefault(blk, n)
        for blk in range(self.bt_count):
            pos, csize, fsize, flags = self.block_table[blk]
            if not (flags & FLAG_EXISTS):
                continue
            name = block_name.get(blk) or self.name_of(blk) or "_unknown_blk%03d" % blk
            data = self.read_block(blk, name)
            if data is None:
                continue
            yield name, data

    def extract(self, outdir, verbose=False):
        """Write every member under ``outdir``, keeping the original paths."""
        os.makedirs(outdir, exist_ok=True)
        written = []
        for name, data in self.members():
            safe = norm_name(name).replace("\\", os.sep).lstrip("\\/")
            if safe.startswith(".."):
                safe = "_" + safe
            dest = os.path.join(outdir, safe)
            os.makedirs(os.path.dirname(dest) or outdir, exist_ok=True)
            with open(dest, "wb") as fh:
                fh.write(data)
            written.append((name, len(data)))
            if verbose:
                print("  %-46s %9d" % (name, len(data)))
        return written
