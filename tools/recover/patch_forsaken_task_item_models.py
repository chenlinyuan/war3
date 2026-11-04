#!/usr/bin/env python3
"""Rebase Forest task items on the working Vile Fin Scale item."""

import os
import struct
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
INJECTOR = os.path.join(ROOT, "tools", "war3map-injector")
DOCTOR = os.path.join(ROOT, "tools", "_devos-map-doctor", "devos-map-doctor-main")
sys.path.insert(0, INJECTOR)
sys.path.insert(0, DOCTOR)

import mpq_patch  # noqa: E402
import war3mpq  # noqa: E402
from doctor.data import objbin  # noqa: E402

MARKER = b"ALAS_TASK_ITEM_BASE_CVFS_V1"
TARGETS = {b"cdhb", b"cbmv"}


def u32(data, offset):
    return struct.unpack_from("<I", data, offset)[0]


def walk_mods(data, offset):
    """Return the end offset and IFIL byte ranges for one W3T object entry."""
    item_sets = u32(data, offset + 8)
    offset += 12
    ifil_ranges = []
    count_offsets = []
    for _ in range(item_sets):
        offset += 4
        count_offset = offset
        count = u32(data, offset)
        offset += 4
        removed = 0
        for _ in range(count):
            start = offset
            field = data[offset:offset + 4]
            value_type = u32(data, offset + 4)
            offset += 8
            if value_type == 3:
                offset = data.index(b"\x00", offset) + 1
            elif value_type in (0, 1, 2):
                offset += 4
            else:
                raise RuntimeError(f"unsupported object value type {value_type}")
            offset += 4
            if field == b"ifil":
                ifil_ranges.append((start, offset))
                removed += 1
        if removed:
            count_offsets.append((count_offset, count - removed))
    return offset, ifil_ranges, count_offsets


def patch_task_items(data):
    version = u32(data, 0)
    if version != 3:
        raise RuntimeError(f"expected W3T version 3, found {version}")

    output = bytearray(data[:4])
    offset = 4
    patched = []
    for table_index in range(2):
        count = u32(data, offset)
        output += data[offset:offset + 4]
        offset += 4
        for _ in range(count):
            start = offset
            end, ifil_ranges, count_offsets = walk_mods(data, offset)
            entry = bytearray(data[start:end])
            new_id = bytes(entry[4:8])
            if table_index == 1 and new_id in TARGETS:
                entry[0:4] = b"cvfs"
                for count_offset, new_count in count_offsets:
                    struct.pack_into(
                        "<I", entry, count_offset - start, new_count
                    )
                for begin, stop in reversed(ifil_ranges):
                    del entry[begin - start:stop - start]
                patched.append(new_id.decode("ascii"))
            output += entry
            offset = end
    output += data[offset:]
    if set(patched) != {"cdhb", "cbmv"}:
        raise RuntimeError(f"expected both task items, patched {patched}")
    return bytes(output)


def verify_task_items(data):
    version, tables, consumed = objbin.read_data(data, False)
    if version != 3 or consumed != len(data):
        raise RuntimeError("patched W3T did not parse completely")
    found = {}
    for old, new, mods in tables[1]:
        if new in ("cdhb", "cbmv"):
            found[new] = (old, {mod[0] for mod in mods})
    if set(found) != {"cdhb", "cbmv"}:
        raise RuntimeError(f"missing task items after patch: {found}")
    for name, (old, fields) in found.items():
        if old != "cvfs" or "ifil" in fields:
            raise RuntimeError(f"{name} still has a broken model override: {found[name]}")
    return found


def main():
    if len(sys.argv) != 3:
        raise SystemExit(
            "usage: patch_forsaken_task_item_models.py INPUT_MAP OUTPUT_MAP"
        )
    source, destination = sys.argv[1:]
    if os.path.exists(destination):
        raise SystemExit("output already exists: " + destination)

    archive = war3mpq.MPQArchive(source)
    try:
        lua = archive.read_file("war3map.lua")
        w3t = archive.read_file("war3map.w3t")
    finally:
        archive.close()
    if not lua or not w3t:
        raise SystemExit("war3map.lua or war3map.w3t is missing")
    if MARKER in lua:
        raise SystemExit("task-item base patch already present")
    if b"ALAS_TASK_ITEM_DROPS_V2" not in lua:
        raise SystemExit("task-item drop v2 patch is missing")

    updated_w3t = patch_task_items(w3t)
    verify_task_items(updated_w3t)
    updated_lua = lua.replace(
        b"function Trig_Darkhound_Blood_Drop_Actions()\n",
        b"-- " + MARKER + b"\nfunction Trig_Darkhound_Blood_Drop_Actions()\n",
        1,
    )
    if updated_lua == lua:
        raise SystemExit("could not add Lua verification marker")

    mpq_patch.patch(
        source,
        [("war3map.w3t", updated_w3t), ("war3map.lua", updated_lua)],
        out_path=destination,
        backup=False,
    )
    check = war3mpq.MPQArchive(destination)
    try:
        if check.read_file("war3map.w3t") != updated_w3t:
            raise SystemExit("war3map.w3t read-back mismatch")
        if check.read_file("war3map.lua") != updated_lua:
            raise SystemExit("war3map.lua read-back mismatch")
    finally:
        check.close()
    print("built", destination, "w3t", len(w3t), "->", len(updated_w3t))


if __name__ == "__main__":
    main()
