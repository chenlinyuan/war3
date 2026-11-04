"""Layer 1: the xorshift32 XOR stream."""

import unittest

from w3xd import xorshift


class TestXorshift(unittest.TestCase):
    def test_step_inverse_roundtrip(self):
        for s in (0, 1, 0xFFFFFFFF, 0x12345678, 0x80000000, 0xDEADBEEF):
            self.assertEqual(xorshift.step_inverse(xorshift.step(s)), s, hex(s))

    def test_inverse_over_a_run(self):
        s = xorshift.seed_from(528645, 0x0123456789ABCDEF)
        fwd = s
        for _ in range(500):
            fwd = xorshift.step(fwd)
        back = fwd
        for _ in range(500):
            back = xorshift.step_inverse(back)
        self.assertEqual(back, s)

    def test_seed_is_never_zero(self):
        # the game patches a zero seed to 1 (cmove eax, 1)
        self.assertEqual(xorshift.seed_from(0, xorshift.SEED_CONST), 1)

    def test_seed_depends_on_license_and_size(self):
        a = xorshift.seed_from(1000, 0x1122334455667788)
        b = xorshift.seed_from(1001, 0x1122334455667788)
        c = xorshift.seed_from(1000, 0x1122334455667789)
        self.assertNotEqual(a, b)
        self.assertNotEqual(a, c)

    def test_xor_is_an_involution(self):
        data = bytes(range(256)) * 4
        seed = 0x86C7DA45
        self.assertEqual(xorshift.xor(xorshift.xor(data, seed), seed), data)

    def test_keystream_matches_step(self):
        seed = 0x86C7DA45
        ks = xorshift.keystream(seed, 64)
        s = seed
        for i in range(64):
            s = xorshift.step(s)
            self.assertEqual(ks[i], s & 0xFF, i)

    def test_keystream_is_not_constant(self):
        ks = xorshift.keystream(0x12345678, 4096)
        self.assertGreater(len(set(ks)), 200)


if __name__ == "__main__":
    unittest.main()
