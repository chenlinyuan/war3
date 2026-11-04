"""
Key derivation for the .w3xd AES-256-CCM layer.

Reversed from ``DeriveKey`` at RVA ``0x1511980`` (``rcx`` = license,
``rdx`` = output buffer, ``r8d`` = 0x20)::

    buffer1 = le64(license) || b"W3MEAES0"      # 16 bytes
    buffer2 = le64(license) || b"W3MEAES1"      # byte 15 patched to '1'
    hash1   = SHA1(buffer1)                     # 20 bytes
    hash2   = SHA1(buffer2)                     # 20 bytes

    key[0:16]  = hash1[0:16]
    key[16:20] = hash1[16:20]
    key[20:28] = hash2[0:8]
    key[28:32] = hash2[8:12]

i.e. ``key = SHA1(le64(license) + b"W3MEAES0")[0:20]
             + SHA1(le64(license) + b"W3MEAES1")[0:12]``.

Note the hash is **SHA-1** (20-byte digest), not SHA-256: the game reads
20 bytes out of each digest.
"""

import hashlib
import struct

TAG_A = b"W3MEAES0"
TAG_B = b"W3MEAES1"


def derive_key(license_id):
    """32-byte AES-256 key for a 64-bit license value."""
    le = struct.pack("<Q", license_id & 0xFFFFFFFFFFFFFFFF)
    a = hashlib.sha1(le + TAG_A).digest()
    b = hashlib.sha1(le + TAG_B).digest()
    if len(a) != 20 or len(b) != 20:
        raise RuntimeError("SHA-1 unavailable")
    return a[0:20] + b[0:12]


def check_key(license_id):
    """Human readable key material, handy for debugging."""
    le = struct.pack("<Q", license_id & 0xFFFFFFFFFFFFFFFF)
    return {
        "license": license_id,
        "buffer_a": le + TAG_A,
        "buffer_b": le + TAG_B,
        "sha1_a": hashlib.sha1(le + TAG_A).hexdigest(),
        "sha1_b": hashlib.sha1(le + TAG_B).hexdigest(),
        "key": derive_key(license_id).hex(),
    }
