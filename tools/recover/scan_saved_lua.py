#!/usr/bin/env python3
"""Find Lua 5.3 chunks embedded in an unpacked Warcraft save."""

import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
TOOLKIT = os.path.join(
    HERE,
    "w3xd-toolkit-src",
    "w3xd-toolkit-main",
)
sys.path.insert(0, TOOLKIT)

from luac53 import chunk  # noqa: E402


def main():
    data = open(sys.argv[1], "rb").read()
    offsets = []
    offset = 0
    while True:
        offset = data.find(chunk.SIGNATURE, offset)
        if offset < 0:
            break
        offsets.append(offset)
        offset += 1
    print("signature hits:", len(offsets))
    for offset in offsets:
        try:
            header, upvalues, main, stats = chunk.parse(data[offset:])
        except Exception as exc:  # noqa: BLE001
            print(f"{offset:#x} ERR {type(exc).__name__}: {exc}")
            continue
        print(
            f"{offset:#x} OK header={header} upvalues={upvalues} "
            f"stats={stats}"
        )


if __name__ == "__main__":
    main()
