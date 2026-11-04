#!/usr/bin/env python3
"""Try common aggregate checksums against a W3G/save map checksum.

usage: python analyze_map_checksum.py MAP EXPECTED_HEX
"""

import os
import struct
import sys
import zlib

HERE = os.path.dirname(os.path.abspath(__file__))
INJECTOR = os.path.abspath(os.path.join(HERE, "..", "war3map-injector"))
sys.path.insert(0, INJECTOR)

import war3mpq  # noqa: E402


def variants(data):
    crc = zlib.crc32(data) & 0xFFFFFFFF
    return {
        "crc32": crc,
        "crc32_not": crc ^ 0xFFFFFFFF,
        "adler32": zlib.adler32(data) & 0xFFFFFFFF,
        "sum32": sum(data) & 0xFFFFFFFF,
    }


def report(label, data, expected):
    for name, value in variants(data).items():
        if value == expected:
            print("MATCH", label, name, len(data), f"{value:08x}")


def main():
    path, expected_hex = sys.argv[1:3]
    expected = int(expected_hex, 16)
    with open(path, "rb") as handle:
        archive_bytes = handle.read()

    print(
        "file",
        len(archive_bytes),
        "expected",
        f"{expected:08x}",
        "crc32",
        f"{zlib.crc32(archive_bytes) & 0xffffffff:08x}",
    )
    report("whole_file", archive_bytes, expected)

    archive = war3mpq.MPQArchive(path)
    try:
        names = archive.files()
        payloads = []
        for name in names:
            try:
                data = archive.read_file(name)
            except Exception as exc:  # noqa: BLE001
                print("read failed", name, exc)
                continue
            if data is not None:
                payloads.append((name, data))
                report("file:" + name, data, expected)

        for order_name, entries in (
            ("listfile_order", payloads),
            ("sorted_name", sorted(payloads, key=lambda item: item[0].lower())),
        ):
            data = b"".join(item[1] for item in entries)
            report(order_name + ":concat", data, expected)
            report(
                order_name + ":name_nul_concat",
                b"".join(
                    item[0].encode("utf-8") + b"\0" + item[1]
                    for item in entries
                ),
                expected,
            )
            crc = 0
            for _, item_data in entries:
                crc = zlib.crc32(
                    struct.pack("<I", crc) + item_data
                ) & 0xFFFFFFFF
            if crc == expected:
                print("MATCH", order_name + ":rolling_crc", f"{crc:08x}")

        # Probe MPQ table/header checksums too.
        with open(path, "rb") as handle:
            header = handle.read(32)
            header_offset = archive.header_offset
            report("header", header, expected)
            handle.seek(header_offset)
            report("from_mpq_header", handle.read(), expected)
            handle.seek(header_offset + 32)
            report("after_mpq_header", handle.read(), expected)
    finally:
        archive.close()


if __name__ == "__main__":
    main()
