# -*- coding: utf-8 -*-
"""Copy Frostmourne object data with a destination-specific rawcode map."""

import argparse
import os
import struct
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
BASE = os.path.dirname(os.path.dirname(HERE))
DOCTOR = os.path.join(BASE, "tools", "_devos-map-doctor", "devos-map-doctor-main")
sys.path.insert(0, DOCTOR)

from doctor.data import objects  # noqa: E402


DEFAULT_MAP = {
    "I105": "I160",
    "A105": "A160",
    "A106": "A161",
    "A107": "A162",
    "A108": "A163",
    "A109": "A164",
}
DEFAULT_MAP.update({"A%d" % i: "A%d" % (i + 50) for i in range(130, 142)})


def rawcode(value):
    return struct.unpack("<i", value.encode("latin-1"))[0]


def replace_bytes(value, mapping):
    for old, new in mapping.items():
        value = value.replace(old.encode("latin-1"), new.encode("latin-1"))
    return value


def convert(source, destination, mapping, with_levels):
    data = open(source, "rb").read()
    version, entries, consumed = objects.read_objects_bytes(
        data, with_levels, fname=os.path.basename(source), with_end=True
    )
    if consumed != len(data):
        raise SystemExit("%s: %d trailing bytes" % (source, len(data) - consumed))
    inverse = {rawcode(old): rawcode(new) for old, new in mapping.items()}
    converted = []
    for table, original, new, mods in entries:
        if original in mapping:
            original = mapping[original]
        if new in mapping:
            new = mapping[new]
        changed = []
        for mod in mods:
            field, kind, level, pointer, value = mod[:5]
            end_pos = mod[5] if len(mod) > 5 else b"\0\0\0\0"
            if kind == 0 and value in inverse:
                value = inverse[value]
            elif kind == 3:
                value = replace_bytes(value, mapping)
            changed.append((field, kind, level, pointer, value, end_pos))
        converted.append((table, original, new, objects.with_item_sets(changed, mods)))
    output = objects.write_objects_bytes(version, converted, with_levels)
    os.makedirs(os.path.dirname(destination), exist_ok=True)
    with open(destination, "wb") as fh:
        fh.write(output)
    return version, len(converted), len(output)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("source_dir")
    parser.add_argument("output_dir")
    parser.add_argument("--item-id", default="I160")
    args = parser.parse_args()
    mapping = dict(DEFAULT_MAP)
    mapping["I105"] = args.item_id
    for filename, with_levels in (("item.w3t", False), ("ability.w3a", True)):
        version, count, size = convert(
            os.path.join(args.source_dir, filename),
            os.path.join(args.output_dir, filename),
            mapping,
            with_levels,
        )
        print("%s: version %d, %d objects, %d bytes" % (filename, version, count, size))
    return 0


if __name__ == "__main__":
    sys.exit(main())
