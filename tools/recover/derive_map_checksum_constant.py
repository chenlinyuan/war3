#!/usr/bin/env python3
"""Recover the fixed constant in the modern Warcraft map checksum mix."""

import os
import struct
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)

from research_map_checksum import (  # noqa: E402
    FILE_ORDER,
    read_members,
    ror32,
    rol32,
    xor_rotate_left,
)


def main():
    for spec in sys.argv[1:]:
        parts = spec.split("=")
        path, expected_text = parts[:2]
        script_override = parts[2] if len(parts) == 3 else None
        expected = int.from_bytes(bytes.fromhex(expected_text), "little")
        members = read_members(path)
        script = (
            open(script_override, "rb").read()
            if script_override
            else members["war3map.lua"]
        )

        state = xor_rotate_left(script)
        initial = state
        state = expected
        for name in reversed(FILE_ORDER):
            data = members.get(name)
            if data:
                state = ror32(state, 3) ^ xor_rotate_left(data)

        # Model A: mix = ROTL(script_hash ^ C, 3).
        constant_a = initial ^ ror32(state, 3)

        # Model B: mix = ROTL(ROTL(script_hash, 3) ^ C, 3).
        constant_b = rol32(initial, 3) ^ ror32(state, 3)

        print(path)
        if script_override:
            print("  script", script_override, len(script))
        print(f"  script_hash            {initial:08x}")
        print(f"  pre-file state          {state:08x}")
        print(f"  required constant A     {constant_a:08x}")
        print(f"  required constant B     {constant_b:08x}")
        print(f"  expected                {expected:08x}")


if __name__ == "__main__":
    main()
