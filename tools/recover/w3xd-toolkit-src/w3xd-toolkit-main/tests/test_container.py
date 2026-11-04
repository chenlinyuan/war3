"""End-to-end container test on synthetic data -- no game files needed."""

import os
import struct
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from w3xd import ccm, kdf, xorshift                      # noqa: E402
from w3xd.aes import PureAes, test_vector_ok             # noqa: E402
from w3xd.container import Container, W3xdError, build   # noqa: E402


def fake_mpq(payload_len=4096):
    """Bytes that look like an MPQ header, so the nonce oracle accepts them."""
    body = bytearray(payload_len)
    body[0:4] = b"MPQ\x1a"
    struct.pack_into("<IIHHIIII", body, 4, 0x20, payload_len, 0, 3,
                     0x1000, 0x2000, 16, 1)
    for i in range(0x20, payload_len):
        body[i] = (i * 37) & 0xFF
    return bytes(body)


class TestAes(unittest.TestCase):
    def test_fips197_aes256(self):
        self.assertTrue(test_vector_ok(PureAes))


class TestCcm(unittest.TestCase):
    def setUp(self):
        self.aes = PureAes(bytes(range(32)))
        self.nonce = bytes(range(10))

    def test_roundtrip(self):
        for n in (0, 1, 15, 16, 17, 1000, 4096):
            msg = bytes((i * 7) & 0xFF for i in range(n))
            ct, tag = ccm.encrypt(self.aes, self.nonce, msg)
            self.assertEqual(ccm.decrypt(self.aes, self.nonce, ct, tag), msg)

    def test_known_answer(self):
        # RFC 3610-style check: the first keystream block is E(flags||nonce||1)
        ct, tag = ccm.encrypt(self.aes, self.nonce, b"\x00" * 16)
        ks = self.aes.encrypt_block(bytes([ccm.L_PARAM - 1]) + self.nonce
                                    + (1).to_bytes(ccm.L_PARAM, "big"))
        self.assertEqual(ct, ks)
        self.assertEqual(len(tag), 16)

    def test_tag_is_over_the_plaintext(self):
        msg = b"hello world, this is a message"
        ct, tag = ccm.encrypt(self.aes, self.nonce, msg)
        self.assertEqual(ccm.tag_of(self.aes, self.nonce, msg), tag)
        # authenticating the ciphertext instead must not match
        self.assertNotEqual(ccm.tag_of(self.aes, self.nonce, ct), tag)

    def test_tampering_is_detected(self):
        ct, tag = ccm.encrypt(self.aes, self.nonce, b"A" * 64)
        bad = bytearray(ct)
        bad[10] ^= 0x40
        with self.assertRaises(ValueError):
            ccm.decrypt(self.aes, self.nonce, bytes(bad), tag)

    def test_wrong_nonce_is_detected(self):
        ct, tag = ccm.encrypt(self.aes, self.nonce, b"A" * 64)
        with self.assertRaises(ValueError):
            ccm.decrypt(self.aes, bytes(10), ct, tag)


class TestKdf(unittest.TestCase):
    def test_key_is_sha1_based(self):
        import hashlib
        lic = 0x0123456789ABCDEF
        le = struct.pack("<Q", lic)
        a = hashlib.sha1(le + b"W3MEAES0").digest()
        b = hashlib.sha1(le + b"W3MEAES1").digest()
        self.assertEqual(kdf.derive_key(lic), a[:20] + b[:12])
        self.assertEqual(len(kdf.derive_key(lic)), 32)

    def test_key_changes_with_license(self):
        self.assertNotEqual(kdf.derive_key(1), kdf.derive_key(2))


class TestContainer(unittest.TestCase):
    LICENSE = 0x0123456789ABCDEF

    def test_roundtrip(self):
        mpq = fake_mpq()
        raw = build(self.LICENSE, mpq)
        c = Container(raw)
        self.assertEqual(c.license, self.LICENSE)
        self.assertTrue(c.seed_matches_formula)
        self.assertEqual(c.trailer["version"], 1)
        self.assertEqual(c.trailer["block_size"], 0x40)
        self.assertEqual(c.payload_size, len(mpq))
        self.assertEqual(c.hdr_size + c.payload_size + 64, len(raw))
        self.assertEqual(c.decrypt_payload(), mpq)

    def test_license_is_recovered_not_supplied(self):
        # the license only appears inside the encrypted trailer, so the tool
        # must recover it from the 22 known zero bytes
        raw = build(self.LICENSE, fake_mpq())
        self.assertNotIn(struct.pack("<Q", self.LICENSE), raw[:len(raw) - 64])
        self.assertEqual(Container(raw).license, self.LICENSE)

    def test_other_licenses(self):
        for lic in (0, 1, 0xFFFFFFFFFFFFFFFF, 0x0123456789ABCDEF, 0x8000000000000000):
            raw = build(lic, fake_mpq(2048))
            c = Container(raw)
            self.assertEqual(c.license, lic)
            self.assertEqual(len(c.decrypt_payload()), 2048)

    def test_random_data_is_rejected(self):
        self.assertRaises(W3xdError, Container, os.urandom(4096))

    def test_truncated_data_is_rejected(self):
        self.assertRaises(W3xdError, Container, os.urandom(64))

    def test_wrong_size_is_rejected(self):
        # flipping the recorded payload length must break the size check
        raw = bytearray(build(self.LICENSE, fake_mpq()))
        plain = bytearray(xorshift.xor(bytes(raw), xorshift.seed_from(len(raw), self.LICENSE)))
        struct.pack_into("<Q", plain, len(raw) - 64 + 6, 12345)
        broken = xorshift.xor(bytes(plain), xorshift.seed_from(len(raw), self.LICENSE))
        self.assertRaises(W3xdError, Container, broken)

    def test_payload_tampering_is_detected(self):
        raw = bytearray(build(self.LICENSE, fake_mpq()))
        raw[len(raw) - 200] ^= 0x01
        c = Container(bytes(raw))
        self.assertRaises(W3xdError, c.decrypt_payload)


if __name__ == "__main__":
    unittest.main()
