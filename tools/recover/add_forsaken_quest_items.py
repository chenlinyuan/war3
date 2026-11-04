#!/usr/bin/env python3
"""Append the two missing Forsaken quest-item definitions to a v3 .w3t."""

import os
import struct
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
INJECTOR = os.path.join(ROOT, "tools", "war3map-injector")
sys.path.insert(0, INJECTOR)

import mpq_patch  # noqa: E402
import war3mpq  # noqa: E402


def read_i32(data, offset):
    return struct.unpack_from("<i", data, offset)[0]


def read_u32(data, offset):
    return struct.unpack_from("<I", data, offset)[0]


def skip_entry(data, offset, version):
    offset += 8
    if version >= 3:
        offset += 8
    modifications = read_u32(data, offset)
    offset += 4
    for _ in range(modifications):
        offset += 4
        type_id = read_u32(data, offset)
        offset += 4
        if type_id == 0:
            offset += 4
        elif type_id in (1, 2):
            offset += 4
        elif type_id == 3:
            offset = data.index(b"\0", offset) + 1
        else:
            raise ValueError(f"unsupported type {type_id} at {offset - 4}")
        offset += 4
    return offset


def table_layout(data):
    version = read_i32(data, 0)
    if version != 3:
        raise ValueError(f"expected object-data version 3, got {version}")
    offset = 4
    original_count = read_u32(data, offset)
    offset += 4
    for _ in range(original_count):
        offset = skip_entry(data, offset, version)
    custom_count_offset = offset
    custom_count = read_u32(data, offset)
    offset += 4
    for _ in range(custom_count):
        offset = skip_entry(data, offset, version)
    if offset != len(data):
        raise ValueError(f"parsed {offset} of {len(data)} bytes")
    return custom_count_offset, custom_count


def write_mod(field, type_id, value):
    output = bytearray(field.encode("latin-1"))
    output += struct.pack("<I", type_id)
    if type_id == 0:
        output += struct.pack("<i", int(value))
    elif type_id in (1, 2):
        output += struct.pack("<f", float(value))
    elif type_id == 3:
        output += str(value).encode("utf-8") + b"\0"
    else:
        raise ValueError(type_id)
    output += struct.pack("<I", 0)
    return bytes(output)


def write_entry(base_id, item_id, mods):
    output = bytearray()
    output += base_id.encode("latin-1")
    output += item_id.encode("latin-1")
    output += struct.pack("<I", 1)  # set count
    output += struct.pack("<I", 0)  # set flags
    output += struct.pack("<I", len(mods))
    for mod in mods:
        output += write_mod(*mod)
    return bytes(output)


QUEST_ITEMS = (
    (
        "cdhb",
        "黑暗犬之血",
        "ReplaceableTextures\\CommandButtons\\BTNPotionRed.blp",
        "Objects\\InventoryItems\\PotionRed\\PotionRed.mdx",
    ),
    (
        "cbmv",
        "巢母毒液",
        "ReplaceableTextures\\CommandButtons\\BTNPotionGreen.blp",
        "Objects\\InventoryItems\\PotionGreen\\PotionGreen.mdx",
    ),
)


def add_items(data):
    custom_count_offset, custom_count = table_layout(data)
    present = {
        data[index:index + 4]
        for index in range(len(data) - 3)
    }
    additions = bytearray()
    for item_id, name, icon, model in QUEST_ITEMS:
        if item_id.encode("latin-1") in present:
            raise ValueError(f"{item_id} is already present")
        mods = [
            ("unam", 3, name),
            ("utip", 3, name),
            ("ides", 3, "任务物品"),
            ("iico", 3, icon),
            ("icla", 3, "Miscellaneous"),
            ("ilev", 0, 1),
            ("igol", 0, 0),
            ("ihtp", 0, 0),
            ("iabi", 3, ""),
            ("iusa", 0, 0),
            ("ifil", 3, model),
            ("ipaw", 0, 0),
        ]
        additions += write_entry("phea" if item_id == "cdhb" else "pman", item_id, mods)
    output = bytearray(data)
    struct.pack_into("<I", output, custom_count_offset, custom_count + 2)
    output += additions
    return bytes(output)


def main():
    if len(sys.argv) != 4:
        raise SystemExit(
            "usage: add_forsaken_quest_items.py INPUT_MAP OUTPUT_MAP ITEM_DATA_W3T"
        )
    source_map, output_map, item_path = sys.argv[1:]
    if os.path.exists(output_map):
        raise SystemExit("output already exists: " + output_map)
    item_data = open(item_path, "rb").read()
    updated = add_items(item_data)
    mpq_patch.patch(
        source_map,
        [("war3map.w3t", updated)],
        out_path=output_map,
        backup=False,
    )
    archive = war3mpq.MPQArchive(output_map)
    try:
        result = archive.read_file("war3map.w3t")
    finally:
        archive.close()
    if result != updated:
        raise SystemExit("war3map.w3t read-back mismatch")
    if b"cdhb" not in result or b"cbmv" not in result:
        raise SystemExit("quest item IDs missing after patch")
    print("built", output_map, "w3t", len(item_data), "->", len(updated))


if __name__ == "__main__":
    main()
