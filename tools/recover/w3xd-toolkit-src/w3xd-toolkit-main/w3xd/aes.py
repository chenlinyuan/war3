"""
AES-256 block encryption with two interchangeable backends.

* :class:`CngAes`  -- Windows CNG (``bcrypt.dll``), used automatically on
  Windows because it does the whole 12 MB payload natively.
* :class:`PureAes` -- dependency-free Python fallback so the tool works
  anywhere (Linux, macOS, CI).

Only single-block ECB encryption is needed: AES-CCM is built from it in
:mod:`w3xd.ccm`.

The S-box is generated from the GF(2^8) definition rather than pasted as a
256-entry table, which keeps the file short and easy to audit.
"""

import os
import struct

__all__ = ["new_aes", "PureAes", "CngAes", "AES_BLOCK"]

AES_BLOCK = 16


# --------------------------------------------------------------------------
# pure Python implementation
# --------------------------------------------------------------------------
def _gmul(a, b):
    r = 0
    for _ in range(8):
        if b & 1:
            r ^= a
        hi = a & 0x80
        a = (a << 1) & 0xFF
        if hi:
            a ^= 0x1B
        b >>= 1
    return r


def _build_sbox():
    inv = [0] * 256
    for x in range(1, 256):
        for y in range(1, 256):
            if _gmul(x, y) == 1:
                inv[x] = y
                break
    box = []
    for x in range(256):
        s = inv[x]
        v = s
        for _ in range(4):
            v = ((v << 1) | (v >> 7)) & 0xFF
            s ^= v
        box.append(s ^ 0x63)
    return box


SBOX = _build_sbox()
RCON = [0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x1B, 0x36,
        0x6C, 0xD8, 0xAB, 0x4D]


class PureAes:
    """AES-256 (14 rounds), single block encryption."""

    def __init__(self, key):
        if len(key) != 32:
            raise ValueError("AES-256 needs a 32-byte key, got %d" % len(key))
        self.round_keys = self._expand(key)

    @staticmethod
    def _expand(key):
        nk, nr = 8, 14
        w = [list(key[4 * i:4 * i + 4]) for i in range(nk)]
        for i in range(nk, 4 * (nr + 1)):
            t = list(w[i - 1])
            if i % nk == 0:
                t = t[1:] + t[:1]
                t = [SBOX[b] for b in t]
                t[0] ^= RCON[i // nk - 1]
            elif i % nk == 4:
                t = [SBOX[b] for b in t]
            w.append([w[i - nk][j] ^ t[j] for j in range(4)])
        return [bytes(b for word in w[4 * r:4 * r + 4] for b in word)
                for r in range(nr + 1)]

    def encrypt_block(self, block):
        if len(block) != 16:
            raise ValueError("block must be 16 bytes")
        s = list(block)
        self._add_round_key(s, self.round_keys[0])
        for r in range(1, 14):
            self._sub_bytes(s)
            self._shift_rows(s)
            self._mix_columns(s)
            self._add_round_key(s, self.round_keys[r])
        self._sub_bytes(s)
        self._shift_rows(s)
        self._add_round_key(s, self.round_keys[14])
        return bytes(s)

    @staticmethod
    def _add_round_key(s, rk):
        for i in range(16):
            s[i] ^= rk[i]

    @staticmethod
    def _sub_bytes(s):
        for i in range(16):
            s[i] = SBOX[s[i]]

    @staticmethod
    def _shift_rows(s):
        # state is column-major: s[c*4 + r]
        for r in range(1, 4):
            row = [s[c * 4 + r] for c in range(4)]
            row = row[r:] + row[:r]
            for c in range(4):
                s[c * 4 + r] = row[c]

    @staticmethod
    def _mix_columns(s):
        for c in range(4):
            a = s[c * 4:c * 4 + 4]
            s[c * 4 + 0] = _gmul(a[0], 2) ^ _gmul(a[1], 3) ^ a[2] ^ a[3]
            s[c * 4 + 1] = a[0] ^ _gmul(a[1], 2) ^ _gmul(a[2], 3) ^ a[3]
            s[c * 4 + 2] = a[0] ^ a[1] ^ _gmul(a[2], 2) ^ _gmul(a[3], 3)
            s[c * 4 + 3] = _gmul(a[0], 3) ^ a[1] ^ a[2] ^ _gmul(a[3], 2)


# --------------------------------------------------------------------------
# Windows CNG implementation
# --------------------------------------------------------------------------
class CngAes:
    """BCrypt AES-256 in ECB mode (Windows only)."""

    BCRYPT_AES_ALGORITHM = "AES"
    BCRYPT_CHAINING_MODE = "ChainingMode"
    BCRYPT_CHAIN_MODE_ECB = "ChainingModeECB"

    def __init__(self, key):
        import ctypes
        import ctypes.wintypes as wt
        self._ctypes = ctypes
        self._wt = wt
        self._b = ctypes.WinDLL("bcrypt", use_last_error=True)

        h = wt.HANDLE()
        if self._b.BCryptOpenAlgorithmProvider(
                ctypes.byref(h), self.BCRYPT_AES_ALGORITHM, None, 0) != 0:
            raise OSError("BCryptOpenAlgorithmProvider failed")
        val = (self.BCRYPT_CHAIN_MODE_ECB + "\x00").encode("utf-16-le")
        if self._b.BCryptSetProperty(
                h, self.BCRYPT_CHAINING_MODE,
                ctypes.cast(ctypes.c_char_p(val), ctypes.c_void_p),
                len(val), 0) != 0:
            raise OSError("BCryptSetProperty(ECB) failed")
        self._hAlg = h
        self._hKey = wt.HANDLE()
        kb = (ctypes.c_ubyte * len(key)).from_buffer_copy(key)
        if self._b.BCryptGenerateSymmetricKey(
                h, ctypes.byref(self._hKey), None, 0, kb, len(key), 0) != 0:
            raise OSError("BCryptGenerateSymmetricKey failed")

    def encrypt_block(self, block):
        ctypes = self._ctypes
        wt = self._wt
        out = (ctypes.c_ubyte * 16)()
        n = wt.ULONG()
        src = (ctypes.c_ubyte * 16).from_buffer_copy(block)
        rc = self._b.BCryptEncrypt(self._hKey, src, 16, None, None, 0,
                                   out, 16, ctypes.byref(n), 0)
        if rc != 0:
            raise OSError("BCryptEncrypt failed %#x" % rc)
        return bytes(out)

    def __del__(self):
        try:
            self._b.BCryptDestroyKey(self._hKey)
            self._b.BCryptCloseAlgorithmProvider(self._hAlg, 0)
        except Exception:
            pass


def new_aes(key, prefer_cng=True):
    """Return the fastest available AES-256 single-block encryptor."""
    if prefer_cng and os.name == "nt":
        try:
            return CngAes(key)
        except Exception:
            pass
    return PureAes(key)


def xor_bytes(a, b):
    return bytes(x ^ y for x, y in zip(a, b))


def test_vector_ok(cls=PureAes):
    """FIPS-197 C.3 AES-256 vector -- cheap self check."""
    key = bytes(range(32))
    plain = bytes.fromhex("00112233445566778899aabbccddeeff")
    want = bytes.fromhex("8ea2b7ca516745bfeafc49904b496089")
    return cls(key).encrypt_block(plain) == want


if __name__ == "__main__":
    print("pure python AES-256 FIPS-197 vector:", test_vector_ok(PureAes))
    if os.name == "nt":
        print("CNG AES-256 FIPS-197 vector:      ", test_vector_ok(CngAes))
