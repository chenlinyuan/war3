"""
Layer 2 of the .w3xd container: AES-256-CCM.

Reversed from ``TryDecryptAes256Ccm`` at RVA ``0x1511AC0``::

    TryDecryptAes256Ccm(inOut, size, license, nonce /*r9*/, tag /*stack*/)
        -> DeriveKey(license, &key32, 32)
        -> CCM with L = 5  (10-byte nonce) and a 16-byte tag

The AES-CCM module the game links against is ``0x1ED6150`` / ``0x1ED94D0`` /
``0x1ED9B20`` (AES-NI, SSSE3 and software variants).

Implemented here directly from RFC 3610 so no third-party crypto package is
needed.  Only the shape the game uses is supported: no associated data,
L = 5, M = 16.
"""

from .aes import AES_BLOCK, xor_bytes

L_PARAM = 5
NONCE_LEN = 15 - L_PARAM          # 10
TAG_LEN = 16
MAX_PAYLOAD = (1 << (8 * L_PARAM)) - 1


def _ctr_block(flags, nonce, counter):
    if not 0 <= counter < (1 << (8 * L_PARAM)):
        raise ValueError("counter out of range")
    return bytes([flags]) + nonce + counter.to_bytes(L_PARAM, "big")


def _b0(nonce, length):
    flags = ((TAG_LEN - 2) // 2) << 3 | (L_PARAM - 1)     # no Adata
    return bytes([flags]) + nonce + length.to_bytes(L_PARAM, "big")


def _cbc_mac(aes, nonce, message):
    """CBC-MAC over the *plaintext* (CCM authenticates M, then encrypts it)."""
    x = aes.encrypt_block(_b0(nonce, len(message)))
    for off in range(0, len(message), AES_BLOCK):
        blk = message[off:off + AES_BLOCK]
        if len(blk) < AES_BLOCK:
            blk = blk + b"\x00" * (AES_BLOCK - len(blk))
        x = aes.encrypt_block(xor_bytes(x, blk))
    return x


def _ctr_crypt(aes, nonce, data, start=1):
    out = bytearray()
    for i, off in enumerate(range(0, len(data), AES_BLOCK)):
        ks = aes.encrypt_block(_ctr_block(L_PARAM - 1, nonce, start + i))
        chunk = data[off:off + AES_BLOCK]
        out += xor_bytes(chunk, ks[:len(chunk)])
    return bytes(out)


def tag_of(aes, nonce, plaintext):
    """The 16-byte authentication tag for ``plaintext`` under ``nonce``."""
    mac = _cbc_mac(aes, nonce, plaintext)
    s0 = aes.encrypt_block(_ctr_block(L_PARAM - 1, nonce, 0))
    return xor_bytes(mac, s0)


def decrypt(aes, nonce, ciphertext, tag, verify=True):
    """Decrypt, then verify; raises :class:`ValueError` on a tag mismatch."""
    if len(nonce) != NONCE_LEN:
        raise ValueError("nonce must be %d bytes" % NONCE_LEN)
    if len(ciphertext) > MAX_PAYLOAD:
        raise ValueError("payload too large for L=%d" % L_PARAM)
    pt = _ctr_crypt(aes, nonce, ciphertext)
    if verify and tag_of(aes, nonce, pt) != tag:
        raise ValueError("CCM tag mismatch")
    return pt


def encrypt(aes, nonce, plaintext):
    """CCM-encrypt and return ``(ciphertext, tag)``."""
    tag = tag_of(aes, nonce, plaintext)
    return _ctr_crypt(aes, nonce, plaintext), tag


def first_plaintext_block(aes, nonce, ciphertext, n=16):
    """Decrypt just the first ``n`` bytes -- used to hunt for the nonce."""
    ks = aes.encrypt_block(_ctr_block(L_PARAM - 1, nonce, 1))
    return xor_bytes(ciphertext[:n], ks[:n])
