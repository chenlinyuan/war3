"""
Layer 1 of the .w3xd container: a byte-wise xorshift32 XOR stream.

Reversed from ``Warcraft III.exe`` 3.0.0.24268, function at RVA ``0x1511910``::

    uint32_t s = (size >> 32) ^ (license >> 32)
               ^ (uint32_t)size ^ (uint32_t)license
               ^ 0xB9E37739;
    if (s == 0) s = 1;                    // cmove eax, 1
    for (i = 0; i < size; i++) {
        s ^= s << 13;                     // each of these is 32-bit
        s ^= s >> 17;
        s ^= s << 5;
        buf[i] ^= (uint8_t)s;             // low byte of the NEW state
    }

One state step per byte, so the byte at offset ``p`` is ``low8(S[p+1])`` where
``S[0]`` is the seed above.

Because the recurrence is linear over GF(2) and each step is invertible, the
whole stream is determined by a single 32-bit state, and the seed can be
recovered from known plaintext without knowing the license.
"""

MASK32 = 0xFFFFFFFF
SEED_CONST = 0xB9E37739


def step(s):
    """One xorshift32 step (13, 17, 5) with 32-bit truncation."""
    s = (s ^ ((s << 13) & MASK32)) & MASK32
    s = (s ^ (s >> 17)) & MASK32
    s = (s ^ ((s << 5) & MASK32)) & MASK32
    return s


def step_inverse(s):
    """Undo one :func:`step` (used to walk the state backwards)."""
    # forward: y = x ^ (x << 13);  y = y ^ (y >> 17);  y = y ^ (y << 5)
    # each is invertible bit by bit, so undo them in reverse order.
    s = _unxor_shl(s, 5)
    s = _unxor_shr(s, 17)
    s = _unxor_shl(s, 13)
    return s & MASK32


def _unxor_shl(y, n):
    """Recover x from y = x ^ (x << n) (bit i of (x<<n) is x[i-n])."""
    x = 0
    for i in range(32):
        bit = (y >> i) & 1
        if i >= n:
            bit ^= (x >> (i - n)) & 1
        x |= bit << i
    return x


def _unxor_shr(y, n):
    """Recover x from y = x ^ (x >> n) (bit i of (x>>n) is x[i+n])."""
    x = 0
    for i in range(31, -1, -1):
        bit = (y >> i) & 1
        if i + n < 32:
            bit ^= (x >> (i + n)) & 1
        x |= bit << i
    return x


def seed_from(size, license_id):
    """The seed the game computes from the file size and the 64-bit license."""
    s = ((size >> 32) ^ (license_id >> 32)
         ^ (size & MASK32) ^ (license_id & MASK32)
         ^ SEED_CONST) & MASK32
    return s or 1


def keystream(seed, length):
    """``length`` bytes of the XOR stream, starting from the initial state.

    The recurrence is inlined because this runs once per byte of the file.
    """
    out = bytearray(length)
    s = seed
    for i in range(length):
        s ^= (s << 13) & MASK32
        s &= MASK32
        s ^= s >> 17
        s ^= (s << 5) & MASK32
        s &= MASK32
        out[i] = s & 0xFF
    return bytes(out)


def xor(data, seed):
    """Apply (or undo -- it is symmetric) the stream cipher to ``data``."""
    ks = keystream(seed, len(data))
    return bytes(a ^ b for a, b in zip(data, ks))
