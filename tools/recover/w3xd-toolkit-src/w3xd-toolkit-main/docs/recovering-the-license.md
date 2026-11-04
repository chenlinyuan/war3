# Recovering the license

The AES key is derived from a 64-bit **license** value that is account bound,
so it cannot be published: each user's containers are encrypted for their own
license.  This document explains how `w3xd` recovers it **from the container
alone**, with no key, no debugger and no game running.

## Where the license is

It is stored in the container trailer, in the clear *after* layer 1:

```
+0x0e  u64 = license
```

and the game compares it against the session license (`0x1511501`), which is
why a container only opens for its owner.

## Why it can be recovered

Two facts combine:

1. **Known plaintext.**  The trailer has 22 bytes at `+0x16` that must all be
   zero (`sub_1511F40` verifies them one by one).
2. **The layer-1 stream is linear over GF(2).**  xorshift32 uses only XOR and
   shifts, and one state step happens per byte.

Therefore, at those 22 positions, the keystream **equals the ciphertext**:

```
keystream[p] = ciphertext[p] XOR plaintext[p] = ciphertext[p]     (plaintext is 0)
```

and since `keystream[p] = low8(S[p+1])`, each of those bytes gives 8 linear
equations in the 32 unknown bits of the initial state `S[0]`:

```
22 bytes x 8 bits = 176 equations, 32 unknowns
```

The system is enormously over-determined.  Gaussian elimination over GF(2)
yields `S[0]` uniquely, the seed formula is then re-checked against
`(size, license)` as a consistency test, and the rest of the trailer — the
license — decrypts with the same stream.

A file that is not a `.w3xd` fails the consistency check essentially always:
the probability that random data satisfies 176 equations in 32 unknowns is
about `2**-144`.  This is what makes blind scanning for containers practical
(see the CASC scanner note in the README).

### Why it is not a brute force

The naive framing would be "guess the license"; the license is 64 bits, and
only `license >> 32 ^ (uint32)license` reaches the seed, so even the seed is a
32-bit unknown.  The known-plaintext trick removes the search entirely: it is
one Gaussian elimination, a few milliseconds.

## Usage

```console
$ w3xd license map.w3xd
0x0123456789abcdef

$ w3xd license map.w3xd --key
0d8020a8b4bb2074c00c9d7e98fa787abbd59e421eb3507d6a2d8aa975ba29ad

$ w3xd info map.w3xd --key-material
...
license       : 0x0123456789abcdef
AES-256 key   : 0d8020a8b4bb2074c00c9d7e98fa787abbd59e421eb3507d6a2d8aa975ba29ad
  buffer A    : efcdab896745230157334d4541455330
  buffer B    : efcdab896745230157334d4541455330
  SHA1(A)     : 0d8020a8b4bb2074c00c9d7e98fa787abbd59e42
  SHA1(B)     : 1eb3507d6a2d8aa975ba29ad010dfe2c436f7a4c
```

`--key-material` prints the exact bytes fed to SHA-1 so the derivation can be
reproduced by hand.

## Where the value comes from in the game

The game receives the license from the platform layer at startup and keeps it
for the session; `sub_15113C0` reads it out of a context object:

```asm
0x015113f2  mov  rsi, [rcx]        ; ctx->0   stream/buffer
0x015113f8  mov  r14, [rcx+8]      ; ctx->8   size
0x015113fc  mov  r13, [rcx+0x10]   ; ctx->16  license
```

It is not read from any file on disk that ships with the game, which is why
recovering it from a container is the practical route — and why it is *not* a
constant you could hard-code for everyone.

## Checking your work

`tests/test_container.py` rebuilds a container around a synthetic MPQ for a
chosen license and asserts that the license comes back, including for
`0x0000000000000000`, `0xFFFFFFFFFFFFFFFF` and values with the high bit set.

Because the derived key is only ever used through AES-CCM with tag
verification, a wrong license fails loudly: `w3xd decrypt` reports
`CCM tag verification failed` rather than writing garbage.
