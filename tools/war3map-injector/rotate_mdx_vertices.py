# -*- coding: utf-8 -*-
"""Bake a fixed Z-axis rotation into MDX vertices, normals and pivots."""
import math
import os
import struct
import sys

sys.path.insert(0, os.path.join(
    os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
    "_devos-map-doctor", "devos-map-doctor-main"))
from doctor.models import mdxnodes as MN


def apply_matrix(xyz, matrix):
    x, y, z = xyz
    return (
        x * matrix[0] + y * matrix[1] + z * matrix[2],
        x * matrix[3] + y * matrix[4] + z * matrix[5],
        x * matrix[6] + y * matrix[7] + z * matrix[8],
    )


def rotate_bounds(raw, matrix, offset):
    values = list(struct.unpack("<7f", raw))
    lo = values[1:4]
    hi = values[4:7]
    points = [
        (lo[0] if x else hi[0], lo[1] if y else hi[1], lo[2] if z else hi[2])
        for x in range(2) for y in range(2) for z in range(2)
    ]
    points = [apply_matrix(point, matrix) for point in points]
    points = [(p[0] + offset[0], p[1] + offset[1], p[2] + offset[2])
              for p in points]
    new_lo = tuple(min(p[i] for p in points) for i in range(3))
    new_hi = tuple(max(p[i] for p in points) for i in range(3))
    new_center = tuple((new_lo[i] + new_hi[i]) * 0.5 for i in range(3))
    new_radius = max(math.sqrt(sum((p[i] - new_center[i]) ** 2 for i in range(3)))
                     for p in points)
    values[0] = new_radius
    values[1:4] = new_lo
    values[4:7] = new_hi
    return struct.pack("<7f", *values)


def patch_geosets(body, matrix, offset):
    geosets = [bytearray(g) for g in MN.split_geosets(body)]
    for geoset in geosets:
        parts, after = MN.geoset_parts(geoset)
        for tag in (b"VRTX", b"NRMS"):
            if tag not in parts:
                continue
            start, count, data_pos, _size = parts[tag]
            for index in range(count):
                pos = data_pos + index * 12
                xyz = struct.unpack_from("<3f", geoset, pos)
                xyz = apply_matrix(xyz, matrix)
                if tag == b"VRTX":
                    xyz = (xyz[0] + offset[0], xyz[1] + offset[1],
                           xyz[2] + offset[2])
                struct.pack_into("<3f", geoset, pos, *xyz)
        bounds_pos = after + 12
        geoset[bounds_pos:bounds_pos + 28] = rotate_bounds(
            bytes(geoset[bounds_pos:bounds_pos + 28]), matrix, offset)
    return b"".join(struct.pack("<I", len(g) + 4) + bytes(g) for g in geosets)


def patch_sequences(body, matrix, offset):
    out = bytearray(body)
    for index in range(len(out) // 132):
        base = index * 132
        lo = struct.unpack_from("<3f", out, base + 108)
        hi = struct.unpack_from("<3f", out, base + 120)
        points = [
            (lo[0] if x else hi[0], lo[1] if y else hi[1], lo[2] if z else hi[2])
            for x in range(2) for y in range(2) for z in range(2)
        ]
        points = [apply_matrix(point, matrix) for point in points]
        points = [(p[0] + offset[0], p[1] + offset[1], p[2] + offset[2])
                  for p in points]
        new_lo = tuple(min(p[i] for p in points) for i in range(3))
        new_hi = tuple(max(p[i] for p in points) for i in range(3))
        center = tuple((new_lo[i] + new_hi[i]) * 0.5 for i in range(3))
        radius = max(math.sqrt(sum((point[i] - center[i]) ** 2 for i in range(3)))
                     for point in points)
        struct.pack_into("<f", out, base + 104, radius)
        struct.pack_into("<3f", out, base + 108, *new_lo)
        struct.pack_into("<3f", out, base + 120, *new_hi)
    return bytes(out)


def rotate(source, output, degrees=90.0, axis="Z", offset=(0.0, 0.0, 0.0)):
    data = open(source, "rb").read()
    chunks = MN.parse_chunks(data)
    angle = math.radians(float(degrees))
    c, s = math.cos(angle), math.sin(angle)
    axis = axis.upper()
    if axis == "X":
        matrix = (1.0, 0.0, 0.0, 0.0, c, -s, 0.0, s, c)
    elif axis == "Y":
        matrix = (c, 0.0, s, 0.0, 1.0, 0.0, -s, 0.0, c)
    elif axis == "Z":
        matrix = (c, -s, 0.0, s, c, 0.0, 0.0, 0.0, 1.0)
    else:
        raise SystemExit("axis must be X, Y or Z")

    for chunk in chunks:
        tag, body = chunk
        if tag == b"GEOS":
            chunk[1] = patch_geosets(body, matrix, offset)
        elif tag == b"PIVT":
            piv = bytearray(body)
            for pos in range(0, len(piv) - 11, 12):
                xyz = struct.unpack_from("<3f", piv, pos)
                xyz = apply_matrix(xyz, matrix)
                struct.pack_into("<3f", piv, pos,
                                 xyz[0] + offset[0], xyz[1] + offset[1],
                                 xyz[2] + offset[2])
            chunk[1] = bytes(piv)
        elif tag == b"SEQS":
            chunk[1] = patch_sequences(body, matrix, offset)

    rebuilt = b"MDLX" + b"".join(
        tag + struct.pack("<I", len(body)) + bytes(body)
        for tag, body in chunks
    )
    open(output, "wb").write(rebuilt)
    print("wrote %s: %d bytes, baked %s rotation %.1fdeg" %
          (output, len(rebuilt), axis, float(degrees)))


if __name__ == "__main__":
    if len(sys.argv) < 3:
        raise SystemExit(
            "usage: rotate_mdx_vertices.py SOURCE OUTPUT [DEGREES] [X|Y|Z]")
    rotate(sys.argv[1], sys.argv[2],
           float(sys.argv[3]) if len(sys.argv) > 3 else 90.0,
           sys.argv[4] if len(sys.argv) > 4 else "Z",
           tuple(float(sys.argv[i]) if len(sys.argv) > i else 0.0
                 for i in (5, 6, 7)))
