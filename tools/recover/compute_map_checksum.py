#!/usr/bin/env python3
"""Compute the Warcraft III 3.x map checksum from a .w3x/.w3m archive."""

import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)

from research_map_checksum import (  # noqa: E402
    FILE_ORDER,
    SCRIPT_NAMES,
    read_members,
    rol32,
    xor_rotate_left,
)


def map_checksum(path):
    members = read_members(path)
    script_name = next(
        (name for name in SCRIPT_NAMES if members.get(name)),
        None,
    )
    if script_name is None:
        raise ValueError("war3map.lua or war3map.j is missing")
    script = members[script_name]
    value = xor_rotate_left(script)
    used = [script_name]
    for name in FILE_ORDER:
        data = members.get(name)
        if data:
            value = rol32(value ^ xor_rotate_left(data), 3)
            used.append(name)
    return value, used


def main():
    for path in sys.argv[1:]:
        value, used = map_checksum(path)
        stored = value.to_bytes(4, "little")
        print(path)
        print("  stored bytes:", stored.hex())
        print("  numeric:", f"0x{value:08x}")
        print("  members:", ", ".join(used))


if __name__ == "__main__":
    main()
