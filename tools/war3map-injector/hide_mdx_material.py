# -*- coding: utf-8 -*-
"""Set every layer alpha of one MDX material to zero."""
import os
import struct
import sys

sys.path.insert(0, os.path.join(
    os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
    "_devos-map-doctor", "devos-map-doctor-main"))
from doctor.models import mdxnodes as MN


def hide_material(source, output, material_index=0):
    chunks = MN.parse_chunks(open(source, "rb").read())
    mtls_i = next(i for i, chunk in enumerate(chunks) if chunk[0] == b"MTLS")
    body = bytearray(chunks[mtls_i][1])
    q = 0
    index = 0
    while q + 4 <= len(body):
        material_size = struct.unpack_from("<I", body, q)[0]
        if material_size < 16 or q + material_size > len(body):
            raise RuntimeError("invalid material size")
        if index == material_index:
            p = q + 12
            if body[p:p + 4] != b"LAYS":
                raise RuntimeError("material has no LAYS chunk")
            layer_count = struct.unpack_from("<I", body, p + 4)[0]
            p += 8
            for _ in range(layer_count):
                layer_size = struct.unpack_from("<I", body, p)[0]
                if layer_size < 28 or p + layer_size > q + material_size:
                    raise RuntimeError("invalid layer size")
                struct.pack_into("<f", body, p + layer_size - 4, 0.0)
                p += layer_size
            chunks[mtls_i][1] = bytes(body)
            break
        q += material_size
        index += 1
    else:
        raise RuntimeError("material index not found")

    rebuilt = b"MDLX" + b"".join(
        tag + struct.pack("<I", len(chunk)) + bytes(chunk)
        for tag, chunk in chunks
    )
    open(output, "wb").write(rebuilt)
    print("wrote %s: %d bytes, material %d hidden" %
          (output, len(rebuilt), material_index))


if __name__ == "__main__":
    if len(sys.argv) < 3:
        raise SystemExit("usage: hide_mdx_material.py SOURCE OUTPUT [INDEX]")
    hide_material(sys.argv[1], sys.argv[2],
                  int(sys.argv[3]) if len(sys.argv) > 3 else 0)
