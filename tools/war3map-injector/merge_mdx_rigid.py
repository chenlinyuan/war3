# -*- coding: utf-8 -*-
"""Merge the static geometry of one MDX model into another model."""
import os
import struct
import sys

sys.path.insert(0, os.path.join(
    os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
    "_devos-map-doctor", "devos-map-doctor-main"))
from doctor.models import mdxnodes as MN


def chunk_index(chunks, tag):
    return next(i for i, chunk in enumerate(chunks) if chunk[0] == tag)


def node_count(chunks):
    ids = [
        struct.unpack_from("<I", body, noff + 84)[0]
        for tag, body in chunks if tag in MN.NODE_CHUNKS
        for _off, _tot, noff in MN.iter_entries(tag, body)
    ]
    return max(ids) + 1 if ids else 0


def entry_count(body):
    count = 0
    pos = 0
    while pos + 4 <= len(body):
        size = struct.unpack_from("<I", body, pos)[0]
        if size < 4 or pos + size > len(body):
            break
        count += 1
        pos += size
    return count


def remap_materials(body, texture_offset):
    out = bytearray()
    pos = 0
    while pos + 4 <= len(body):
        size = struct.unpack_from("<I", body, pos)[0]
        if size < 16 or pos + size > len(body):
            raise RuntimeError("invalid material")
        entry = bytearray(body[pos:pos + size])
        if entry[12:16] != b"LAYS":
            raise RuntimeError("material without LAYS")
        layers = struct.unpack_from("<I", entry, 16)[0]
        layer_pos = 20
        for _ in range(layers):
            layer_size = struct.unpack_from("<I", entry, layer_pos)[0]
            texture_id = struct.unpack_from("<I", entry, layer_pos + 12)[0]
            struct.pack_into("<I", entry, layer_pos + 12, texture_id + texture_offset)
            layer_pos += layer_size
        out += entry
        pos += size
    return bytes(out)


def remap_geoa(body, geoset_offset):
    out = bytearray()
    pos = 0
    while pos + 4 <= len(body):
        size = struct.unpack_from("<I", body, pos)[0]
        if size < 28 or pos + size > len(body):
            raise RuntimeError("invalid geoset animation")
        entry = bytearray(body[pos:pos + size])
        gid = struct.unpack_from("<I", entry, 24)[0]
        struct.pack_into("<I", entry, 24, gid + geoset_offset)
        out += entry
        pos += size
    return bytes(out)


def remap_bones(body, node_offset, geoset_offset, geoa_offset):
    out = bytearray()
    for off, total, noff in MN.iter_entries(b"BONE", body):
        entry = bytearray(body[off:off + total])
        node_size = struct.unpack_from("<I", entry, 0)[0]
        object_id, parent = struct.unpack_from("<II", entry, 84)
        struct.pack_into("<I", entry, 84, object_id + node_offset)
        if parent != 0xFFFFFFFF:
            struct.pack_into("<I", entry, 88, parent + node_offset)
        geoset_id, geoa_id = struct.unpack_from("<II", entry, node_size)
        if geoset_id != 0xFFFFFFFF:
            struct.pack_into("<I", entry, node_size, geoset_id + geoset_offset)
        if geoa_id != 0xFFFFFFFF:
            struct.pack_into("<I", entry, node_size + 4, geoa_id + geoa_offset)
        out += entry
    return bytes(out)


def remap_geosets(body, material_offset, node_offset):
    out = bytearray()
    for geoset in MN.split_geosets(body):
        parts, after = MN.geoset_parts(geoset)
        material_id = struct.unpack_from("<I", geoset, after)[0]
        struct.pack_into("<I", geoset, after, material_id + material_offset)
        _start, count, pos, _size = parts[b"MATS"]
        for index in range(count):
            bone = struct.unpack_from("<I", geoset, pos + index * 4)[0]
            struct.pack_into("<I", geoset, pos + index * 4, bone + node_offset)
        out += struct.pack("<I", len(geoset) + 4) + bytes(geoset)
    return bytes(out)


def merge(base_path, add_path, output):
    base = MN.parse_chunks(open(base_path, "rb").read())
    add = MN.parse_chunks(open(add_path, "rb").read())

    base_tex = chunk_index(base, b"TEXS")
    add_tex = chunk_index(add, b"TEXS")
    tex_count = len(base[base_tex][1]) // 268

    base_mat = chunk_index(base, b"MTLS")
    add_mat = chunk_index(add, b"MTLS")
    mat_count = entry_count(base[base_mat][1])

    base_geo = chunk_index(base, b"GEOS")
    add_geo = chunk_index(add, b"GEOS")
    geo_count = len(MN.split_geosets(base[base_geo][1]))
    base[base_geo][1] += remap_geosets(add[add_geo][1], mat_count, node_count(base))

    base_geoa = chunk_index(base, b"GEOA")
    add_geoa = chunk_index(add, b"GEOA")
    geoa_count = entry_count(base[base_geoa][1])
    base[base_geoa][1] += remap_geoa(add[add_geoa][1], geo_count)

    base_bone = chunk_index(base, b"BONE")
    add_bone = chunk_index(add, b"BONE")
    base[base_bone][1] += remap_bones(
        add[add_bone][1], node_count(base), geo_count, geoa_count)

    base_pivt = chunk_index(base, b"PIVT")
    add_pivt = chunk_index(add, b"PIVT")
    bone_total = sum(1 for _ in MN.iter_entries(b"BONE", add[add_bone][1]))
    base[base_pivt][1] += bytes(add[add_pivt][1][:bone_total * 12])

    base[base_tex][1] += bytes(add[add_tex][1])
    base[base_mat][1] += remap_materials(add[add_mat][1], tex_count)

    if any(tag == b"GLBS" for tag, _body in add):
        if not any(tag == b"GLBS" for tag, _body in base):
            seq = chunk_index(base, b"SEQS")
            add_glbs = chunk_index(add, b"GLBS")
            base.insert(seq + 1, [b"GLBS", bytes(add[add_glbs][1])])

    rebuilt = b"MDLX" + b"".join(
        tag + struct.pack("<I", len(body)) + bytes(body)
        for tag, body in base
    )
    open(output, "wb").write(rebuilt)
    print("wrote %s: %d bytes" % (output, len(rebuilt)))


if __name__ == "__main__":
    if len(sys.argv) != 4:
        raise SystemExit("usage: merge_mdx_rigid.py BASE ADD OUTPUT")
    merge(sys.argv[1], sys.argv[2], sys.argv[3])
