# -*- coding: utf-8 -*-
"""Add a top-level Origin Ref attachment at the MDX model origin."""
import os
import struct
import sys

sys.path.insert(0, os.path.join(
    os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
    "_devos-map-doctor", "devos-map-doctor-main"))
from doctor.models import mdxnodes as MN


def add_origin(source, output):
    chunks = MN.parse_chunks(open(source, "rb").read())
    object_id = max(
        struct.unpack_from("<I", body, noff + 84)[0]
        for tag, body in chunks if tag in MN.NODE_CHUNKS
        for _off, _tot, noff in MN.iter_entries(tag, body)
    ) + 1
    name = b"Origin Ref"
    entry = (
        struct.pack("<I", 364)
        + struct.pack("<I", 96)
        + name.ljust(80, b"\0")
        + struct.pack("<III", object_id, 0xFFFFFFFF, 0x800)
        + b"".ljust(260, b"\0")
        + struct.pack("<I", 0)
    )
    chunks.append([b"ATCH", entry])
    pivt_index = next(i for i, chunk in enumerate(chunks) if chunk[0] == b"PIVT")
    chunks[pivt_index][1] = bytes(chunks[pivt_index][1]) + struct.pack("<3f", 0.0, 0.0, 0.0)
    rebuilt = b"MDLX" + b"".join(
        tag + struct.pack("<I", len(body)) + bytes(body)
        for tag, body in chunks
    )
    open(output, "wb").write(rebuilt)
    print("wrote %s: %d bytes, Origin Ref id=%d" %
          (output, len(rebuilt), object_id))


if __name__ == "__main__":
    if len(sys.argv) != 3:
        raise SystemExit("usage: add_mdx_origin_attachment.py SOURCE OUTPUT")
    add_origin(sys.argv[1], sys.argv[2])
