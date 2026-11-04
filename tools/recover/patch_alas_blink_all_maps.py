#!/usr/bin/env python3
"""Set Demon Wings blink range to 3000 on every Alas chapter map."""

import os
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
INJECTOR = ROOT / "tools" / "war3map-injector"
sys.path.insert(0, str(INJECTOR))
sys.path.insert(0, str(Path(__file__).resolve().parent))

import mpq_patch  # noqa: E402
import war3mpq  # noqa: E402
from patch_alas_original_quest_items_and_blink import (  # noqa: E402
    replace_1300,
    rewrite_entry_values,
    set_blink_distance,
)

MARKER = b"ALAS_DEMON_WINGS_BLINK3000_V1"


def patch_metadata(w3t, w3a):
    updated_w3a, changed_abilities = rewrite_entry_values(
        w3a,
        True,
        {"W024"},
        {b"Ebl1": set_blink_distance, b"aub1": replace_1300},
    )
    updated_w3t, changed_items = rewrite_entry_values(
        w3t,
        False,
        {"I102"},
        {b"utub": replace_1300, b"ides": replace_1300},
    )
    if ("W024", "Ebl1") not in changed_abilities:
        raise RuntimeError("W024.Ebl1 was not changed")
    if not changed_items:
        raise RuntimeError("Demon Wings tooltips were not changed")
    return updated_w3t, updated_w3a


def main():
    if len(sys.argv) != 4:
        raise SystemExit(
            "usage: patch_alas_blink_all_maps.py "
            "INPUT_CAMPAIGN FOREST_FINAL_MAP OUTPUT_DIR"
        )
    input_campaign = Path(sys.argv[1]).resolve()
    forest_map = Path(sys.argv[2]).resolve()
    output_dir = Path(sys.argv[3]).resolve()
    output_campaign = output_dir / "alas-blink3000.w3n"
    maps_dir = output_dir / "maps"
    if output_dir.exists() and any(output_dir.iterdir()):
        raise SystemExit("output directory is not empty: " + str(output_dir))
    maps_dir.mkdir(parents=True, exist_ok=True)

    source = war3mpq.MPQArchive(str(input_campaign))
    replacements = []
    report = []
    try:
        map_names = sorted(
            name
            for name in source.files()
            if name.lower().endswith((".w3x", ".w3m"))
        )
        if len(map_names) != 15:
            raise RuntimeError(f"expected 15 maps, found {len(map_names)}")
        for name in map_names:
            if name == "UndeadRE01_03.w3x":
                data = forest_map.read_bytes()
                archive = war3mpq.MPQArchive(str(forest_map))
                try:
                    lua = archive.read_file("war3map.lua")
                finally:
                    archive.close()
                if (
                    MARKER not in lua
                    and b"ALAS_ORIGINAL_ITEMS_BLINK3000_V1" not in lua
                ):
                    raise RuntimeError("forest blink marker is missing")
                replacements.append((name, data))
                report.append((name, "forest-final"))
                continue

            original = source.read_file(name)
            input_path = maps_dir / (name + ".input.w3x")
            output_path = maps_dir / name
            input_path.write_bytes(original)
            archive = war3mpq.MPQArchive(str(input_path))
            try:
                lua = archive.read_file("war3map.lua")
                w3t = archive.read_file("war3map.w3t")
                w3a = archive.read_file("war3map.w3a")
            finally:
                archive.close()
            if not lua or not w3t or not w3a:
                raise RuntimeError("required map files are missing: " + name)
            if MARKER in lua:
                raise RuntimeError("blink patch already present: " + name)

            updated_w3t, updated_w3a = patch_metadata(w3t, w3a)
            anchor = b"function main()\n"
            if lua.count(anchor) != 1:
                raise RuntimeError("main anchor is not unique: " + name)
            updated_lua = lua.replace(
                anchor,
                b"-- " + MARKER + b"\n" + anchor,
                1,
            )
            mpq_patch.patch(
                str(input_path),
                [
                    ("war3map.w3t", updated_w3t),
                    ("war3map.w3a", updated_w3a),
                    ("war3map.lua", updated_lua),
                ],
                out_path=str(output_path),
                backup=False,
            )
            check = war3mpq.MPQArchive(str(output_path))
            try:
                if check.read_file("war3map.w3t") != updated_w3t:
                    raise RuntimeError("W3T read-back mismatch: " + name)
                if check.read_file("war3map.w3a") != updated_w3a:
                    raise RuntimeError("W3A read-back mismatch: " + name)
                if check.read_file("war3map.lua") != updated_lua:
                    raise RuntimeError("Lua read-back mismatch: " + name)
            finally:
                check.close()
            replacements.append((name, output_path.read_bytes()))
            report.append((name, "patched"))
    finally:
        source.close()

    mpq_patch.patch(
        str(input_campaign),
        replacements,
        out_path=str(output_campaign),
        backup=False,
        store=tuple(name for name, _ in replacements),
    )
    check = war3mpq.MPQArchive(str(output_campaign))
    try:
        for name, data in replacements:
            if check.read_file(name) != data:
                raise RuntimeError("campaign read-back mismatch: " + name)
    finally:
        check.close()
    print("built", output_campaign)
    for name, state in report:
        print(name, state)


if __name__ == "__main__":
    main()
