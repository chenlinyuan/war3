# -*- coding: utf-8 -*-
"""Remove node/geoset animation tracks and global sequence/event chunks."""
import os
import struct
import sys

sys.path.insert(0, os.path.join(
    os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
    "_devos-map-doctor", "devos-map-doctor-main"))
from doctor.models import mdxnodes as MN


def first_tag(entry, tags, start):
    positions = [entry.find(tag, start) for tag in tags]
    positions = [pos for pos in positions if pos >= 0]
    return min(positions) if positions else len(entry)


def freeze(source, output):
    chunks = MN.parse_chunks(open(source, "rb").read())
    out_chunks = []
    for tag, body in chunks:
        if tag in (b"GLBS", b"EVTS"):
            continue
        if tag == b"BONE":
            body_out = bytearray()
            for off, total, _noff in MN.iter_entries(tag, body):
                entry = bytearray(body[off:off + total])
                node_size = struct.unpack_from("<I", entry, 0)[0]
                cut = first_tag(entry, (b"KGTR", b"KGRT", b"KGSC"),
                                4 + node_size + 8)
                body_out += entry[:cut]
            body = bytes(body_out)
        elif tag == b"GEOA":
            body_out = bytearray()
            pos = 0
            while pos + 4 <= len(body):
                size = struct.unpack_from("<I", body, pos)[0]
                if size < 28 or pos + size > len(body):
                    raise RuntimeError("invalid geoset animation")
                entry = body[pos:pos + size]
                cut = first_tag(entry, (b"KGAO", b"KGAC"), 28)
                body_out += entry[:cut]
                pos += size
            body = bytes(body_out)
        out_chunks.append([tag, body])

    rebuilt = b"MDLX" + b"".join(
        tag + struct.pack("<I", len(body)) + bytes(body)
        for tag, body in out_chunks
    )
    open(output, "wb").write(rebuilt)
    print("wrote %s: %d bytes" % (output, len(rebuilt)))


if __name__ == "__main__":
    if len(sys.argv) != 3:
        raise SystemExit("usage: freeze_mdx_animation.py SOURCE OUTPUT")
    freeze(sys.argv[1], sys.argv[2])
