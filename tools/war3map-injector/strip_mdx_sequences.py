# -*- coding: utf-8 -*-
"""Keep only named MDX animation sequences."""
import os
import struct
import sys

sys.path.insert(0, os.path.join(
    os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
    "_devos-map-doctor", "devos-map-doctor-main"))
from doctor.models import mdxnodes as MN


def strip(source, output, keep=("Stand",)):
    chunks = MN.parse_chunks(open(source, "rb").read())
    seq_index = next(i for i, chunk in enumerate(chunks) if chunk[0] == b"SEQS")
    body = chunks[seq_index][1]
    kept = bytearray()
    names = []
    for pos in range(0, len(body) - 131, 132):
        entry = body[pos:pos + 132]
        name = entry[:80].split(b"\0")[0].decode("latin-1", "replace")
        if name in keep:
            kept += entry
            names.append(name)
    if not names:
        raise SystemExit("none of the requested sequences found")
    chunks[seq_index][1] = bytes(kept)
    rebuilt = b"MDLX" + b"".join(
        tag + struct.pack("<I", len(chunk)) + bytes(chunk)
        for tag, chunk in chunks
    )
    open(output, "wb").write(rebuilt)
    print("wrote %s: %d bytes, kept %s" %
          (output, len(rebuilt), ", ".join(names)))


if __name__ == "__main__":
    if len(sys.argv) < 3:
        raise SystemExit(
            "usage: strip_mdx_sequences.py SOURCE OUTPUT [SEQUENCE ...]")
    strip(sys.argv[1], sys.argv[2],
          tuple(sys.argv[3:]) if len(sys.argv) > 3 else ("Stand",))
