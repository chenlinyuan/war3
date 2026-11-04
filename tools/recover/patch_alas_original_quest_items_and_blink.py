#!/usr/bin/env python3
"""Restore original Alas task items and set Demon Wings blink to 3000."""

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

MARKER = b"ALAS_ORIGINAL_ITEMS_BLINK3000_V1"
TASK_ITEMS = {b"cdhb", b"cbmv"}


def u32(data, offset):
    return struct.unpack_from("<I", data, offset)[0]


def walk_entry(data, offset, has_levels):
    item_sets = u32(data, offset + 8)
    offset += 12
    mods = []
    for _ in range(item_sets):
        offset += 4
        count = u32(data, offset)
        offset += 4
        for _ in range(count):
            field = data[offset:offset + 4]
            value_type = u32(data, offset + 4)
            offset += 8
            if has_levels:
                offset += 8
            value_start = offset
            if value_type == 3:
                offset = data.index(b"\x00", offset) + 1
            elif value_type in (0, 1, 2):
                offset += 4
            else:
                raise RuntimeError(f"unsupported object value type {value_type}")
            value_end = offset
            offset += 4
            mods.append((field, value_type, value_start, value_end))
    return offset, mods


def remove_custom_task_items(data):
    version = u32(data, 0)
    if version != 3:
        raise RuntimeError(f"expected W3T version 3, found {version}")

    output = bytearray(data[:4])
    offset = 4
    removed = []
    for table_index in range(2):
        count = u32(data, offset)
        offset += 4
        kept = bytearray()
        for _ in range(count):
            start = offset
            end, _ = walk_entry(data, offset, False)
            entry = data[start:end]
            new_id = entry[4:8]
            if table_index == 1 and new_id in TASK_ITEMS:
                removed.append(new_id.decode("ascii"))
            else:
                kept += entry
            offset = end
        retained_count = count if table_index == 0 else count - len(removed)
        output += struct.pack("<I", retained_count)
        output += kept
    output += data[offset:]
    if set(removed) != {"cdhb", "cbmv"}:
        raise RuntimeError(f"expected both task items, removed {removed}")
    return bytes(output)


def rewrite_entry_values(data, has_levels, targets, handlers):
    version = u32(data, 0)
    if version != 3:
        raise RuntimeError(f"expected object version 3, found {version}")

    output = bytearray(data[:4])
    offset = 4
    changed = []
    for _ in range(2):
        count = u32(data, offset)
        output += data[offset:offset + 4]
        offset += 4
        for _ in range(count):
            start = offset
            end, mods = walk_entry(data, offset, has_levels)
            entry = bytearray(data[start:end])
            new_id = bytes(entry[4:8]).decode("latin1")
            if new_id in targets:
                for field, value_type, value_start, value_end in mods:
                    handler = handlers.get(field)
                    if handler is None:
                        continue
                    old_value = bytes(entry[value_start - start:value_end - start])
                    new_value = handler(old_value, value_type)
                    if new_value is not None and new_value != old_value:
                        if len(new_value) != len(old_value):
                            raise RuntimeError(
                                f"{new_id}.{field} changed length "
                                f"{len(old_value)} -> {len(new_value)}"
                            )
                        entry[value_start - start:value_end - start] = new_value
                        changed.append((new_id, field.decode("latin1")))
            output += entry
            offset = end
    output += data[offset:]
    return bytes(output), changed


def replace_1300(value, value_type):
    return value.replace(b"1300", b"3000")


def set_blink_distance(value, value_type):
    if value_type != 2 or len(value) != 4:
        raise RuntimeError("W024.Ebl1 is not a real value")
    return struct.pack("<f", 3000.0)


def verify(w3t, w3a):
    _, tables, consumed = objbin.read_data(w3t, False)
    if consumed != len(w3t):
        raise RuntimeError("W3T did not parse completely")
    custom_items = {
        new for _, new, _ in tables[1] if new in ("cdhb", "cbmv")
    }
    if custom_items:
        raise RuntimeError(f"task item overrides remain: {custom_items}")

    _, ability_tables, consumed = objbin.read_data(w3a, True)
    if consumed != len(w3a):
        raise RuntimeError("W3A did not parse completely")
    blink = None
    for _, new, mods in ability_tables[1]:
        if new == "W024":
            blink = {
                field: value
                for field, value_type, level, pointer, value in mods
            }
    if blink is None:
        raise RuntimeError("W024 is missing")
    distance = struct.unpack("<f", blink["Ebl1"])[0]
    if abs(distance - 3000.0) > 0.01:
        raise RuntimeError(f"W024 blink distance is {distance}, expected 3000")
    if b"1300" in blink.get("aub1", b""):
        raise RuntimeError("W024 blink tooltip still says 1300")


def main():
    if len(sys.argv) != 3:
        raise SystemExit(
            "usage: patch_alas_original_quest_items_and_blink.py "
            "INPUT_MAP OUTPUT_MAP"
        )
    source, destination = sys.argv[1:]
    if os.path.exists(destination):
        raise SystemExit("output already exists: " + destination)

    archive = war3mpq.MPQArchive(source)
    try:
        lua = archive.read_file("war3map.lua")
        w3t = archive.read_file("war3map.w3t")
        w3a = archive.read_file("war3map.w3a")
    finally:
        archive.close()
    if not lua or not w3t or not w3a:
        raise SystemExit("war3map.lua, w3t, or w3a is missing")
    if MARKER in lua:
        raise SystemExit("original-item/blink patch already present")
    if b"ALAS_TASK_ITEM_DROPS_V2" not in lua:
        raise SystemExit("task-item drop v2 patch is missing")

    updated_w3t = remove_custom_task_items(w3t)
    updated_w3a, changed_abilities = rewrite_entry_values(
        w3a,
        True,
        {"W024"},
        {b"Ebl1": set_blink_distance, b"aub1": replace_1300},
    )
    updated_w3t, changed_items = rewrite_entry_values(
        updated_w3t,
        False,
        {"I102"},
        {b"utub": replace_1300, b"ides": replace_1300},
    )
    verify(updated_w3t, updated_w3a)
    if ("W024", "Ebl1") not in changed_abilities:
        raise RuntimeError("W024.Ebl1 was not changed")
    if not changed_items:
        raise RuntimeError("Demon Wings tooltips were not changed")

    condition_old = """  local dyingType = GetUnitTypeId(GetDyingUnit())
  if dyingType ~= FourCC("n004") and dyingType ~= FourCC("n005") then
    return false
  end
"""
    condition_new = """  local dyingType = GetUnitTypeId(GetDyingUnit())
  -- ALAS_ORIGINAL_ITEMS_BLINK3000_V1
  if dyingType ~= FourCC("n004") then
    return false
  end
"""
    if lua.count(condition_old.encode()) != 1:
        raise RuntimeError("darkhound condition anchor is not unique")
    updated_lua = lua.replace(condition_old.encode(), condition_new.encode(), 1)

    mpq_patch.patch(
        source,
        [
            ("war3map.w3t", updated_w3t),
            ("war3map.w3a", updated_w3a),
            ("war3map.lua", updated_lua),
        ],
        out_path=destination,
        backup=False,
    )
    check = war3mpq.MPQArchive(destination)
    try:
        if check.read_file("war3map.w3t") != updated_w3t:
            raise SystemExit("war3map.w3t read-back mismatch")
        if check.read_file("war3map.w3a") != updated_w3a:
            raise SystemExit("war3map.w3a read-back mismatch")
        if check.read_file("war3map.lua") != updated_lua:
            raise SystemExit("war3map.lua read-back mismatch")
    finally:
        check.close()
    print(
        "built",
        destination,
        "w3t",
        len(w3t),
        "->",
        len(updated_w3t),
        "w3a",
        len(w3a),
        "->",
        len(updated_w3a),
    )


if __name__ == "__main__":
    main()
