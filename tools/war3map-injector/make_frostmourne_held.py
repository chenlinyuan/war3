# -*- coding: utf-8 -*-
"""Wrap a rigid MDX model in a root bone with a fixed Z rotation."""
import math
import os
import struct
import sys

sys.path.insert(0, os.path.join(
    os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
    "_devos-map-doctor", "devos-map-doctor-main"))
from doctor.models import mdxnodes as MN


def make_held(source, output, degrees=90.0):
    data = open(source, "rb").read()
    chunks = MN.parse_chunks(data)
    bone_index = next(i for i, chunk in enumerate(chunks) if chunk[0] == b"BONE")
    bone_body = chunks[bone_index][1]
    entries = list(MN.iter_entries(b"BONE", bone_body))
    root_id = max(
        struct.unpack_from("<I", body, noff + 84)[0]
        for tag, body in chunks if tag in MN.NODE_CHUNKS
        for _off, _tot, noff in MN.iter_entries(tag, body)
    ) + 1

    # Reparent every top-level node under one common root at the origin.
    for index, (tag, body) in enumerate(chunks):
        if tag not in MN.NODE_CHUNKS:
            continue
        rebuilt = bytearray()
        for off, total, noff in MN.iter_entries(tag, body):
            entry = bytearray(body[off:off + total])
            parent_offset = noff - off + 88
            parent = struct.unpack_from("<I", entry, parent_offset)[0]
            if parent == 0xFFFFFFFF:
                struct.pack_into("<I", entry, parent_offset, root_id)
            rebuilt += entry
        chunks[index][1] = rebuilt

    angle = math.radians(float(degrees)) * 0.5
    quat = struct.pack("<4f", 0.0, 0.0, math.sin(angle), math.cos(angle))
    name = b"root_frostmourne"
    node = (
        struct.pack("<I", 96)
        + name.ljust(80, b"\0")
        + struct.pack("<III", root_id, 0xFFFFFFFF, 0x100)
        + struct.pack("<ii", -1, -1)
        + b"KGRT"
        + struct.pack("<I", 1)
        + struct.pack("<I", 0)
        + struct.pack("<i", -1)
        + struct.pack("<I", 0)
        + quat
    )
    chunks[bone_index][1] = bytes(chunks[bone_index][1]) + node

    pivt_index = next(i for i, chunk in enumerate(chunks) if chunk[0] == b"PIVT")
    chunks[pivt_index][1] = bytes(chunks[pivt_index][1]) + struct.pack("<3f", 0.0, 0.0, 0.0)

    rebuilt = b"MDLX" + b"".join(
        tag + struct.pack("<I", len(body)) + bytes(body)
        for tag, body in chunks
    )
    open(output, "wb").write(rebuilt)
    print("wrote %s: %d bytes, root=%d, Z rotation=%.1fdeg" %
          (output, len(rebuilt), root_id, float(degrees)))


if __name__ == "__main__":
    if len(sys.argv) < 3:
        raise SystemExit("usage: make_frostmourne_held.py SOURCE OUTPUT [DEGREES]")
    make_held(sys.argv[1], sys.argv[2],
              float(sys.argv[3]) if len(sys.argv) > 3 else 90.0)
