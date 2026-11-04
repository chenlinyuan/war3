# -*- coding: utf-8 -*-
"""Extract or replace HM3W maps stored as unnamed MPQ blocks.

The official campaign ``C_兽族大逃亡.w3n`` has encrypted/unnamed chapter
names in its listfile, but its block table still contains three nested HM3W
map blocks.  This helper extracts those blocks by block index and writes
replacement blocks back without touching the archive hash table.
"""
import argparse
import os
import struct
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)

import mpq_patch as MP  # noqa: E402
import war3mpq as W  # noqa: E402


def hm3w_name(data):
    if not data or data[:4] != b"HM3W":
        return None
    end = data.index(0, 8)
    return data[8:end].decode("utf-8", "replace")


def extract(campaign, outdir):
    os.makedirs(outdir, exist_ok=True)
    archive = W.MPQArchive(campaign)
    found = []
    try:
        for idx in range(len(archive.block_table)):
            data = MP.read_block(archive, idx)
            name = hm3w_name(data)
            if not name:
                continue
            safe = "".join(ch if ch not in '\\/:*?"<>|' else "_" for ch in name)
            path = os.path.join(outdir, safe + ".w3x")
            with open(path, "wb") as fh:
                fh.write(data)
            found.append((idx, path, name))
    finally:
        archive.close()
    for idx, path, name in found:
        print("block %d -> %s (%s)" % (idx, os.path.basename(path), name))
    print("extracted maps:", len(found))
    return found


def patch_blocks(source, output, replacements, store=True):
    archive = W.MPQArchive(source)
    try:
        header_offset = archive.header_offset
        fmt = archive.format_version
        block_size = archive.block_size
        hash_size = archive.hash_table_size
        hash_tbl = list(archive.hash_table)
        block_tbl = list(archive.block_table)
        archive.file.seek(header_offset + archive.hash_table_pos)
        raw_ht = archive.file.read(hash_size * 16)
        ht_enc = MP.table_encrypted(raw_ht, hash_size, "(hash table)")
        archive.file.seek(header_offset + archive.block_table_pos)
        raw_bt = archive.file.read(len(block_tbl) * 16)
        bt_enc = MP.table_encrypted(
            raw_bt, len(block_tbl), "(block table)", os.path.getsize(source))
    finally:
        archive.close()

    body = bytearray(open(source, "rb").read())
    sector_size = 512 << block_size
    for idx, data in replacements.items():
        if idx < 0 or idx >= len(block_tbl):
            raise ValueError("bad block index %d" % idx)
        if len(body) % MP.ALIGN:
            body += b"\x00" * (MP.ALIGN - len(body) % MP.ALIGN)
        off = len(body) - header_offset
        if store:
            fdata = data
            flags = W.MPQ_FILE_EXISTS
        else:
            fdata = MP.compress_sectors(data, sector_size)
            flags = MP.WRITE_FLAGS
        body += fdata
        block_tbl[idx] = (off, len(fdata), len(data), flags)
        print("replace block %-3d <- %d bytes%s" %
              (idx, len(data), " (stored)" if store else ""))

    def write_table(table, name, encrypted):
        if len(body) % MP.ALIGN:
            body.extend(b"\x00" * (MP.ALIGN - len(body) % MP.ALIGN))
        pos = len(body) - header_offset
        raw = b"".join(struct.pack("<IIII", *entry) for entry in table)
        if encrypted:
            raw = W._encrypt(raw, W._hash_string(name, W.MPQ_HASH_FILE_KEY))
        body.extend(raw)
        return pos

    pos_bt = write_table(block_tbl, "(block table)", bt_enc)
    pos_ht = write_table(hash_tbl, "(hash table)", ht_enc)
    header = bytearray(body[header_offset:header_offset + 32])
    struct.pack_into("<I", header, 4, 32)
    struct.pack_into("<I", header, 8, len(body) - header_offset)
    struct.pack_into("<H", header, 12, fmt)
    struct.pack_into("<H", header, 14, block_size)
    struct.pack_into("<I", header, 16, pos_ht)
    struct.pack_into("<I", header, 20, pos_bt)
    struct.pack_into("<I", header, 24, hash_size)
    struct.pack_into("<I", header, 28, len(block_tbl))
    body[header_offset:header_offset + 32] = header
    with open(output, "wb") as fh:
        fh.write(body)

    check = W.MPQArchive(output)
    try:
        bad = []
        for idx, data in replacements.items():
            got = MP.read_block(check, idx)
            if got != data:
                bad.append(idx)
    finally:
        check.close()
    if bad:
        raise RuntimeError("replacement verification failed: %s" % bad)
    print("block-table verification: OK")


def main():
    parser = argparse.ArgumentParser()
    sub = parser.add_subparsers(dest="cmd", required=True)
    extract_parser = sub.add_parser("extract")
    extract_parser.add_argument("campaign")
    extract_parser.add_argument("outdir")
    patch_parser = sub.add_parser("patch")
    patch_parser.add_argument("source")
    patch_parser.add_argument("output")
    patch_parser.add_argument("map", nargs="+")
    args = parser.parse_args()

    if args.cmd == "extract":
        extract(args.campaign, args.outdir)
        return 0
    if args.cmd == "patch":
        replacements = {}
        for spec in args.map:
            if "=" not in spec:
                raise SystemExit("map must be INDEX=FILE")
            idx, path = spec.split("=", 1)
            replacements[int(idx)] = open(path, "rb").read()
        patch_blocks(args.source, args.output, replacements, store=True)
        return 0
    return 1


if __name__ == "__main__":
    sys.exit(main())
