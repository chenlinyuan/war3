#!/usr/bin/env python3
"""Replace a .w3z map identity checksum with explicitly supplied stored bytes."""

import os
import shutil
import struct
import sys
import zlib

HERE = os.path.dirname(os.path.abspath(__file__))
REPAIR_DIR = os.path.join(HERE, "w3z_map_checksum_repair")
sys.path.insert(0, REPAIR_DIR)

from statstring import decode, encode, find_stat  # noqa: E402
from w3z import block_cksum, decompress, header_crc, parse  # noqa: E402

BLOCK_SIZE = 1 << 20


def fail(message):
    raise SystemExit("ERROR: " + message)


def compress_block(data):
    compressor = zlib.compressobj(
        1,
        zlib.DEFLATED,
        15,
        8,
        zlib.Z_DEFAULT_STRATEGY,
    )
    return compressor.compress(data) + compressor.flush(zlib.Z_SYNC_FLUSH)


def main():
    if len(sys.argv) not in (4, 5, 6):
        fail(
            "usage: repair_w3z_checksum_bytes.py INPUT.w3z "
            "OUTPUT.w3z NEW_CHECKSUM_HEX [NEW_MAP_SHA1_HEX] "
            "[EXPECTED_CHECKSUM_REFS]"
        )
    source, destination, checksum_hex = sys.argv[1:4]
    new_sha1 = bytes.fromhex(sys.argv[4]) if len(sys.argv) >= 5 else None
    expected_checksum_refs = int(sys.argv[5]) if len(sys.argv) == 6 else 2
    if new_sha1 is not None and len(new_sha1) != 20:
        fail("NEW_MAP_SHA1_HEX must contain exactly 20 bytes")
    checksum = bytes.fromhex(checksum_hex)
    if len(checksum) != 4:
        fail("NEW_CHECKSUM_HEX must contain exactly four stored bytes")
    if os.path.exists(destination):
        fail("output already exists: " + destination)
    if os.path.abspath(source) == os.path.abspath(destination):
        fail("output must differ from input")

    archive, info, blocks = parse(source)
    if info["hcrc"] != info["hcrc_calc"] or info["csize"] != info["filelen"]:
        fail("input header CRC/size is invalid")
    bad = [index for index, block in enumerate(blocks)
           if block["ck"] != block["ck_calc"]]
    if bad:
        fail("input block checksum mismatch at " + repr(bad))

    raw, _ = decompress(blocks)
    try:
        start, end = find_stat(raw)
    except ValueError as exc:
        fail(str(exc))
    decoded, _ = decode(raw[start:end])
    if encode(decoded) != raw[start:end]:
        fail("statstring does not round-trip")
    map_name = raw[:raw.index(b"\0")]
    if not decoded[13:].startswith(map_name):
        fail("decoded statstring does not contain the save's map name")

    old_checksum = decoded[9:13]
    # A map may change only data not covered by the chapter checksum
    # (for example war3map.w3t) while its SHA-1 still changes. Keep the
    # checksum rewrite path usable so the SHA-1 can be updated independently.
    hits = []
    offset = raw.find(old_checksum)
    while offset >= 0:
        hits.append(offset)
        offset = raw.find(old_checksum, offset + 1)
    if len(hits) != expected_checksum_refs:
        fail(
            f"expected exactly {expected_checksum_refs} plain checksum references, found "
            f"{len(hits)} at {hits[:10]}"
        )

    patched = bytearray(raw)
    updated_settings = decoded[:9] + checksum + decoded[13:]
    sha1_hits = []
    if new_sha1 is not None:
        encoded_sha1_offset = updated_settings.find(decoded[-20:])
        if encoded_sha1_offset < 0:
            fail("could not locate map SHA-1 inside the statstring")
        old_sha1 = updated_settings[
            encoded_sha1_offset:encoded_sha1_offset + 20
        ]
        updated_settings = updated_settings.replace(old_sha1, new_sha1)
        offset = raw.find(old_sha1)
        while offset >= 0:
            sha1_hits.append(offset)
            offset = raw.find(old_sha1, offset + 1)
        if len(sha1_hits) != 2:
            fail(
                "expected exactly two plain SHA-1 references, found "
                f"{len(sha1_hits)} at {sha1_hits[:10]}"
            )
    encoded = encode(updated_settings)
    if len(encoded) != end - start:
        fail("encoded statstring changed length")
    patched[start:end] = encoded
    for offset in hits:
        patched[offset:offset + 4] = checksum
    for offset in sha1_hits:
        patched[offset:offset + 20] = new_sha1

    changed_offsets = [
        index
        for index, (before, after) in enumerate(zip(raw, patched))
        if before != after
    ]
    affected = sorted({index // BLOCK_SIZE for index in changed_offsets})

    output = bytearray(archive[:info["hsize"]])
    for index, block in enumerate(blocks):
        block_start = index * BLOCK_SIZE
        block_end = block_start + block["d"]
        original_plain = raw[block_start:block_end]
        if index not in affected:
            output += archive[
                block["off"]:block["off"] + 12 + block["c"]
            ]
            continue
        if compress_block(original_plain) != block["data"]:
            fail(
                f"compressor does not reproduce original block {index}; "
                "refusing to rewrite"
            )
        compressed = compress_block(patched[block_start:block_end])
        block_header = bytearray(struct.pack("<III", len(compressed), block["d"], 0))
        struct.pack_into(
            "<I",
            block_header,
            8,
            block_cksum(bytes(block_header), compressed),
        )
        output += block_header + compressed
        print(
            f"block {index}: compressed {block['c']} -> "
            f"{len(compressed)} bytes"
        )
    output += archive[info["end"]:]
    struct.pack_into("<I", output, 0x20, len(output))
    struct.pack_into("<I", output, 0x40, header_crc(bytes(output[:0x44])))

    temporary = destination + ".tmp"
    with open(temporary, "wb") as handle:
        handle.write(output)

    _, output_info, output_blocks = parse(temporary)
    output_raw, _ = decompress(output_blocks)
    problems = []
    if output_info["hcrc"] != output_info["hcrc_calc"]:
        problems.append("header CRC")
    if output_info["csize"] != output_info["filelen"]:
        problems.append("file size")
    if any(block["ck"] != block["ck_calc"] for block in output_blocks):
        problems.append("block checksum")
    if output_raw != patched:
        problems.append("decompressed content")
    if len(output_raw) != len(raw):
        problems.append("payload length")
    if output_info["dsize"] != info["dsize"]:
        problems.append("declared payload size")
    if output_info["build"] != info["build"]:
        problems.append("save build")
    if problems:
        os.remove(temporary)
        fail("verification failed: " + ", ".join(problems))
    os.replace(temporary, destination)

    backup = destination + ".orig.bak"
    if not os.path.exists(backup):
        shutil.copy2(source, backup)
    print("map name:", map_name.decode("utf-8", "replace"))
    print(
        "checksum:",
        old_checksum.hex(),
        "->",
        checksum.hex(),
        "at",
        hits,
    )
    if new_sha1 is not None:
        print("map SHA-1:", old_sha1.hex(), "->", new_sha1.hex(), "at", sha1_hits)
    print("affected blocks:", affected)
    print("verified:", destination, len(output), "bytes")


if __name__ == "__main__":
    main()
