#!/usr/bin/env python3
"""Replace the chapter map in the campaign as an uncompressed MPQ entry."""

import os
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
INJECTOR = os.path.join(ROOT, "tools", "war3map-injector")
sys.path.insert(0, INJECTOR)

import mpq_patch  # noqa: E402
import war3mpq  # noqa: E402

DEFAULT_INTERNAL = "UndeadRE01_03.w3x"


def main():
    if len(sys.argv) not in (4, 5):
        raise SystemExit(
            "usage: replace_forsaken_runtime_chapter.py "
            "CAMPAIGN INPUT_MAP OUTPUT_CAMPAIGN [INTERNAL_MAP_NAME]"
        )
    campaign, input_map, output = sys.argv[1:4]
    internal = sys.argv[4] if len(sys.argv) == 5 else DEFAULT_INTERNAL
    if os.path.exists(output):
        raise SystemExit("output already exists: " + output)
    data = open(input_map, "rb").read()
    mpq_patch.patch(
        campaign,
        [(internal, data)],
        out_path=output,
        backup=False,
        store=(internal,),
    )
    archive = war3mpq.MPQArchive(output)
    try:
        result = archive.read_file(internal)
    finally:
        archive.close()
    if result != data:
        raise SystemExit("chapter read-back mismatch")
    print("replaced", internal, len(data), "bytes in", output)


if __name__ == "__main__":
    main()
