#!/usr/bin/env python3
"""Losslessly recompress and deduplicate a standalone Warcraft III map."""

from __future__ import annotations

import argparse
import shutil
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
DOCTOR = ROOT / "tools" / "_devos-map-doctor" / "devos-map-doctor-main"
sys.path.insert(0, str(DOCTOR))

from doctor.fix import shrink  # noqa: E402


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--map", required=True, type=Path)
    parser.add_argument("--output", required=True, type=Path)
    args = parser.parse_args()

    source = args.map.resolve()
    output = args.output.resolve()
    if not source.is_file():
        raise SystemExit(f"map not found: {source}")
    if output == source:
        raise SystemExit("output must differ from source")
    output.parent.mkdir(parents=True, exist_ok=True)
    output.unlink(missing_ok=True)

    result = shrink.shrink(
        str(source),
        str(output),
        {
            "recompress": True,
            "blp": False,
            "dedup": True,
        },
        print,
    )
    if result.get("state") == "nothing_to_do":
        shutil.copy2(source, output)
    elif result.get("state") != "done":
        raise SystemExit(
            "map compaction failed: " + str(result.get("error"))
        )

    print(
        "map: %d -> %d bytes"
        % (source.stat().st_size, output.stat().st_size)
    )
    if output.stat().st_size >= source.stat().st_size:
        print("no net map size reduction")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
