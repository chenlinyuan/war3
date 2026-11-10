#!/usr/bin/env python3
"""Select TFT game data on maps that support the explicit version field.

Legacy ROC and TFT map-info formats have no separate game-data version field.
Changing their GameDataSet value would switch their object-data layout instead
of selecting TFT, so those maps are left byte-for-byte unchanged.
"""

from __future__ import annotations

import argparse
import sys
from pathlib import Path


HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
DOCTOR = ROOT / "tools" / "_devos-map-doctor" / "devos-map-doctor-main"
sys.path.insert(0, str(HERE))
sys.path.insert(0, str(DOCTOR))

import mpq_patch  # noqa: E402
import war3mpq as W  # noqa: E402
import campaign_paths as CAMP  # noqa: E402
from doctor.data import w3i as W3I  # noqa: E402


def patch_w3i(data: bytes, label: str) -> tuple[bytes | None, int, str]:
    model = W3I.parse(data)
    version = int(model["version"])
    if version < 25:
        return None, version, "ROC"
    if version < 30:
        return None, version, "legacy TFT"
    if int(model.get("game_data_version", -1)) == 1:
        return None, version, "already TFT"
    if W3I.write(model) != data:
        raise RuntimeError(
            "%s war3map.w3i does not round-trip byte-for-byte" % label
        )
    model["game_data_version"] = 1
    updated = W3I.write(model)
    if int(W3I.parse(updated).get("game_data_version", -1)) != 1:
        raise RuntimeError("%s game data version read-back failed" % label)
    return updated, version, "patched"


def patch_map(source: Path, output: Path) -> str:
    archive = W.MPQArchive(str(source))
    try:
        data = archive.read_file("war3map.w3i")
    finally:
        archive.close()
    if not data:
        raise RuntimeError("%s has no war3map.w3i" % source.name)
    updated, version, reason = patch_w3i(data, source.name)
    if updated is None:
        print(
            "FT game data skipped (%s, map-info v%d): %s"
            % (reason, version, source.name)
        )
        return "skipped"
    mpq_patch.patch(
        str(source),
        [("war3map.w3i", updated)],
        out_path=str(output),
        backup=False,
    )
    check = W.MPQArchive(str(output))
    try:
        if check.read_file("war3map.w3i") != updated:
            raise RuntimeError("%s GameDataSet write-back failed" % output.name)
    finally:
        check.close()
    print("FT game data: %s" % output)
    return "patched"


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", type=Path, required=True)
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    source = args.input.resolve()
    if source.is_dir():
        chapters = CAMP.chapter_paths(source)
        if not chapters:
            raise SystemExit("no chapter maps found in " + str(source))
        results = []
        for chapter in chapters:
            results.append(patch_map(chapter, chapter))
        print(
            "FT game data summary: %d patched, %d safely skipped"
            % (results.count("patched"), results.count("skipped"))
        )
        return 0
    if not source.is_file():
        raise SystemExit("input not found: " + str(source))
    output = (args.output or source).resolve()
    output.parent.mkdir(parents=True, exist_ok=True)
    patch_map(source, output)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
