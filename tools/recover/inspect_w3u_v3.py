#!/usr/bin/env python3
"""Inspect Warcraft III v3 unit object data without rewriting it."""

import struct
import sys


def parse(data):
    offset = 0

    def i32():
        nonlocal offset
        value = struct.unpack_from("<i", data, offset)[0]
        offset += 4
        return value

    def u32():
        nonlocal offset
        value = struct.unpack_from("<I", data, offset)[0]
        offset += 4
        return value

    def raw4():
        nonlocal offset
        value = data[offset:offset + 4]
        offset += 4
        return value.decode("latin-1")

    def value(type_id):
        nonlocal offset
        if type_id == 0:
            return i32()
        if type_id in (1, 2):
            value = struct.unpack_from("<f", data, offset)[0]
            offset += 4
            return value
        if type_id == 3:
            end = data.index(b"\0", offset)
            value = data[offset:end].decode("utf-8", "replace")
            offset = end + 1
            return value
        raise ValueError(f"unsupported type {type_id} at {offset - 4}")

    version = i32()
    tables = []
    for table_index in range(2):
        count = i32()
        entries = []
        for _ in range(count):
            old_id = raw4()
            new_id = raw4()
            set_count = i32() if version >= 3 else 1
            set_flag = i32() if version >= 3 else 0
            mod_count = i32()
            mods = []
            for _ in range(mod_count):
                field = raw4()
                type_id = i32()
                field_value = value(type_id)
                # Version 3 stores one opaque dword after every value.
                offset += 4
                mods.append((field, type_id, field_value))
            entries.append({
                "old": old_id,
                "new": new_id,
                "set_count": set_count,
                "set_flag": set_flag,
                "mods": mods,
            })
        tables.append(entries)
    if offset != len(data):
        raise ValueError(f"parsed {offset} of {len(data)} bytes")
    return version, tables


def main():
    path = sys.argv[1]
    wanted = set(sys.argv[2:])
    version, tables = parse(open(path, "rb").read())
    print("version", version)
    for table_name, entries in zip(("original", "custom"), tables):
        for entry in entries:
            if (
                wanted and
                entry["old"] not in wanted and
                entry["new"] not in wanted
            ):
                continue
            print(
                f"== {table_name}: old={entry['old']} new={entry['new']} "
                f"sets={entry['set_count']} flags={entry['set_flag']} "
                f"mods={len(entry['mods'])}"
            )
            for field, type_id, value in entry["mods"]:
                print(f"   {field} type={type_id} value={value!r}")


if __name__ == "__main__":
    main()
