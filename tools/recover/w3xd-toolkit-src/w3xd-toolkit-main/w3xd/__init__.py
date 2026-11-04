"""
w3xd-toolkit
============

Tools for Warcraft III: Reforged 3.0 campaign map containers.

Two independent pieces:

``w3xd``
    Decrypt a ``.w3xd`` container into a normal ``.w3x`` map and extract its
    members.  The container uses two layers:

    1. an xorshift32 XOR stream over the whole file, seeded from
       ``(size, license)``
    2. AES-256-CCM over the payload, keyed from the same 64-bit license

    The license is *not* required as input: it is recovered from the container
    itself, because the 64-byte trailer contains 22 known zero bytes and the
    xorshift layer is linear over GF(2).  See :mod:`w3xd.container`.

``luac53``
    Convert the Blizzard-customised Lua 5.3 bytecode found in ``war3map.luac``
    into a stock Lua 5.3 chunk, so an ordinary decompiler (unluac, luadec) can
    read it.

This package contains no game data and no keys.  Keys are account bound, so
each user recovers their own from their own copy of the game.
"""

__version__ = "1.0.0"
__all__ = ["xorshift", "aes", "ccm", "kdf", "container", "mpq"]
