#!/usr/bin/env python3
"""Try plausible Warcraft III map-checksum hash layouts.

The public Forsaken save-repair project documents the engine routine at a high
level: start from the Lua script's XOR/rotate hash, then combine readable W3E,
WPM, DOO, W3U, W3B, W3D, W3A, W3Q and W3L members in that order. This script
tests the small family of byte/hash combinations that fit that description.
"""

import itertools
import os
import struct
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
INJECTOR = os.path.abspath(os.path.join(HERE, "..", "war3map-injector"))
sys.path.insert(0, INJECTOR)

import war3mpq  # noqa: E402


FILE_ORDER = (
    "war3map.w3e",
    "war3map.wpm",
    "war3map.doo",
    "war3map.w3u",
    "war3map.w3b",
    "war3map.w3d",
    "war3map.w3a",
    "war3map.w3q",
    "war3map.w3l",
)

SCRIPT_NAMES = (
    "war3map.lua",
    "war3map.j",
    "scripts\\war3map.lua",
    "scripts\\war3map.j",
)


def rol32(value, count):
    return ((value << count) | (value >> (32 - count))) & 0xFFFFFFFF


def ror32(value, count):
    return ((value >> count) | (value << (32 - count))) & 0xFFFFFFFF


def xor_rotate_left(data):
    value = 0
    offset = 0
    while offset + 4 <= len(data):
        word = struct.unpack_from("<I", data, offset)[0]
        value = rol32(value ^ word, 3)
        offset += 4
    while offset < len(data):
        value = rol32(value ^ data[offset], 3)
        offset += 1
    return value


def update(data, state, mode, rotate):
    for byte in data:
        if mode == "xor_rol":
            state = rol32(state ^ byte, rotate)
        elif mode == "xor_ror":
            state = ror32(state ^ byte, rotate)
        elif mode == "rol_xor":
            state = rol32(state, rotate) ^ byte
        elif mode == "ror_xor":
            state = ror32(state, rotate) ^ byte
        elif mode == "add_rol":
            state = rol32((state + byte) & 0xFFFFFFFF, rotate)
        elif mode == "add":
            state = (state + byte) & 0xFFFFFFFF
        elif mode == "shift_xor":
            state = ((state << 1) ^ byte) & 0xFFFFFFFF
        elif mode == "xor_shift":
            state = ((state ^ byte) << 1) & 0xFFFFFFFF
        else:
            raise ValueError(mode)
    return state


def read_members(path):
    archive = war3mpq.MPQArchive(path)
    result = {}
    try:
        for name in SCRIPT_NAMES + FILE_ORDER:
            try:
                data = archive.read_file(name)
            except Exception:
                data = None
            result[name] = data
    finally:
        archive.close()
    return result


def candidates(path, expected, script_override=None):
    members = read_members(path)
    script = None
    if script_override:
        with open(script_override, "rb") as handle:
            script = handle.read()
    else:
        for name in SCRIPT_NAMES:
            if members.get(name):
                script = members[name]
                break
    if not script:
        raise SystemExit("no war3map.lua or war3map.j")

    modes = ("xor_rol", "xor_ror", "rol_xor", "ror_xor", "shift_xor", "xor_shift")
    seeds = (0, 0xFFFFFFFF, len(script), (len(script) ^ 0xFFFFFFFF) & 0xFFFFFFFF)
    seen = set()
    found = []

    expected_variants = {
        expected,
        int.from_bytes(struct.pack("<I", expected), "big"),
    }

    # Warcraft III's legacy map_crc routine, adapted to the 3.x Lua script
    # seed and W3L list documented by the save-repair project.
    state = xor_rotate_left(script)
    state = rol32(state, 3)
    state = rol32(state ^ 0x03F1379E, 3)
    for name in FILE_ORDER:
        data = members.get(name)
        if data:
            state = rol32(state ^ xor_rotate_left(data), 3)
    if state in expected_variants:
        found.append(("legacy-lua-seed",))

    # Also test the old common.j/blizzard.j-style two-input preamble without
    # the historical constant, to cover engine revisions that dropped it.
    state = rol32(xor_rotate_left(script), 3)
    for name in FILE_ORDER:
        data = members.get(name)
        if data:
            state = rol32(state ^ xor_rotate_left(data), 3)
    if state in expected_variants:
        found.append(("legacy-lua-seed-no-constant",))

    # The documented engine hash uses a single-bit rotate per byte.
    for mode, rotate in itertools.product(modes, range(1, 2)):
        file_hashes = {}
        for name in FILE_ORDER:
            data = members.get(name)
            if data:
                file_hashes[name] = update(data, 0, mode, rotate)

        for seed in seeds:
            start = update(script, seed, mode, rotate)

            # The state runs continuously through script and selected members.
            state = start
            for name in FILE_ORDER:
                data = members.get(name)
                if data:
                    state = update(data, state, mode, rotate)
            if state in expected_variants:
                found.append((mode, rotate, seed, "continue"))

            # Each member is hashed independently, then folded into the state.
            for per_rotate in range(1, 32):
                for direction in ("rol", "ror"):
                    rotate_state = rol32 if direction == "rol" else ror32
                    for combine in ("xor_rotate", "rotate_xor"):
                        state = start
                        for name in FILE_ORDER:
                            file_hash = file_hashes.get(name)
                            if file_hash is None:
                                continue
                            if combine == "xor_rotate":
                                state = rotate_state(state ^ file_hash, per_rotate)
                            else:
                                state = rotate_state(state, per_rotate) ^ file_hash
                        if state in expected_variants:
                            key = (
                                mode,
                                rotate,
                                seed,
                                per_rotate,
                                direction,
                                combine,
                            )
                            if key not in seen:
                                seen.add(key)
                                found.append(key)
    return found


def main():
    for spec in sys.argv[1:]:
        parts = spec.split("=")
        if len(parts) == 2:
            path, expected_text = parts
            script_override = None
        elif len(parts) == 3:
            path, expected_text, script_override = parts
        else:
            raise SystemExit(f"bad spec: {spec}")
        expected = int(expected_text, 16)
        print(path, f"expected={expected:08x}")
        if script_override:
            print("  script override:", script_override)
        found = candidates(path, expected, script_override)
        if not found:
            print("  no candidate matched")
        for row in found:
            print("  MATCH", row)


if __name__ == "__main__":
    main()
