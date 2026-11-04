# -*- coding: utf-8 -*-
"""Inject the maintained hero system into a standalone map."""

import argparse
import os
import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
BASE = HERE.parent.parent
sys.path.insert(0, str(HERE))
sys.path.insert(0, str(BASE / "tools" / "_devos-map-doctor" / "devos-map-doctor-main"))

import merge_w3obj as M  # noqa: E402
import war3mpq as W  # noqa: E402
from doctor.data import objects as OBJ  # noqa: E402
from port_frostmourne_campaign import patch_browser  # noqa: E402

PY = sys.executable
HEROES = ("light_ranger", "demon_hunter", "shadow_shaman", "blade_master", "firelord")
HERO_IDS = ("H0L1", "H0D1", "H0S1", "H0B1", "H0F1")
ABIL_IDS = (
    "A0L1", "A0D1", "A0S1", "A0B1", "A0F1",
    "A105", "A100",
)
ICON_ASSETS = (
    (HERE / "_hero_BTNLS15.blp",
     r"ReplaceableTextures\CommandButtons\BTNLS15.blp"),
    (HERE / "_hero_DISBTNLS15.blp",
     r"ReplaceableTextures\CommandButtonsDisabled\DISBTNLS15.blp"),
    (HERE / "_hero_BTNSH30.blp",
     r"ReplaceableTextures\CommandButtons\BTNSH30.blp"),
    (HERE / "_hero_DISBTNSH30.blp",
     r"ReplaceableTextures\CommandButtonsDisabled\DISBTNSH30.blp"),
    (HERE / "_hero_BTNBM30.blp",
     r"ReplaceableTextures\CommandButtons\BTNBM30.blp"),
    (HERE / "_hero_DISBTNBM30.blp",
     r"ReplaceableTextures\CommandButtonsDisabled\DISBTNBM30.blp"),
    (BASE / "heroes" / "item_icons" / "BTNFirelordAvatar_30HD.blp",
     r"ReplaceableTextures\CommandButtons\BTNFirelordAvatar_30HD.blp"),
    (BASE / "heroes" / "item_icons" / "DISBTNFirelordAvatar_30HD.blp",
     r"ReplaceableTextures\CommandButtonsDisabled\DISBTNFirelordAvatar_30HD.blp"),
)
FROST_DIR = BASE / "heroes" / "frostmourne"
FROST_ASSETS = (
    (FROST_DIR / "assets" / "Frostmourne.mdx",
     r"war3campImported\Frostmourne.mdx"),
    (FROST_DIR / "assets" / "Frostmourne10.blp", "Frostmourne10.blp"),
    (FROST_DIR / "assets" / "Frostmourne100.blp", "Frostmourne100.blp"),
    (FROST_DIR / "assets" / "IceStompRaised.mdx",
     r"war3campImported\IceStompRaised.mdx"),
    (FROST_DIR / "assets" / "Rune-Blue-Aura_Raised20.mdx",
     r"war3campImported\Rune-Blue-Aura_Raised20.mdx"),
)


def run(args):
    print(">>>", " ".join(str(x) for x in args), flush=True)
    result = subprocess.run(args)
    if result.returncode:
        raise SystemExit("command failed: %s" % args)


def extract_file(map_path, internal, output):
    archive = W.MPQArchive(str(map_path))
    try:
        data = archive.read_file(internal)
    finally:
        archive.close()
    if data:
        Path(output).write_bytes(data)
    return data


def merge_inputs(output, inputs):
    existing = [str(p) for p in inputs if Path(p).exists()]
    if not existing:
        raise SystemExit("nothing to merge for " + str(output))
    M.merge_files(str(output), existing)


def pre_add_assets(map_path, assets):
    powershell = Path(r"C:\Windows\SysWOW64\WindowsPowerShell\v1.0\powershell.exe")
    helper = HERE / "sfmpq_add_file.ps1"
    if not powershell.exists():
        raise SystemExit("32-bit PowerShell is required for legacy MPQ updates")
    for source, internal in assets:
        result = subprocess.run([
            str(powershell), "-NoProfile", "-ExecutionPolicy", "Bypass",
            "-File", str(helper),
            "-Map", str(map_path),
            "-Source", str(source),
            "-Internal", internal,
            "-Replace",
        ], capture_output=True, text=True, encoding="utf-8", errors="replace")
        if result.returncode:
            raise SystemExit(
                "SFmpq add failed for %s:\n%s\n%s"
                % (internal, result.stdout, result.stderr)
            )


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", required=True)
    parser.add_argument("--output", required=True)
    parser.add_argument("--work")
    parser.add_argument("--with-frostmourne", action="store_true")
    args = parser.parse_args()

    source = Path(args.input).resolve()
    output = Path(args.output).resolve()
    work = Path(args.work).resolve() if args.work else output.with_name(output.stem + "_hero_work")
    work.mkdir(parents=True, exist_ok=True)

    archive = W.MPQArchive(str(source))
    try:
        script = archive.read_file("war3map.j") or b""
    finally:
        archive.close()
    if b"HB_Init" in script or b"addhero" in script:
        raise SystemExit("input already contains the hero system")

    base_a = work / "base.w3a"
    base_t = work / "base.w3t"
    base_u = work / "base.w3u"
    base_h = work / "base.w3h"
    for ext, target in (("w3a", base_a), ("w3t", base_t),
                        ("w3u", base_u), ("w3h", base_h)):
        if not extract_file(source, "war3map." + ext, target):
            if target.exists():
                target.unlink()

    ward = work / "hero_ward.w3h"
    run([PY, "-c",
         "import sys; sys.path.insert(0, %r); import rebuild_heroes as R; "
         "R.write_ward_buff(%r)" % (str(HERE), str(ward))])

    hero_dirs = [BASE / "heroes" / name for name in HEROES]
    merged_a = work / "merged.w3a"
    merged_t = work / "merged.w3t"
    merged_u = work / "merged.w3u"
    merged_h = work / "merged.w3h"
    ability_inputs = [base_a] + [d / "hero.w3a" for d in hero_dirs]
    item_inputs = [base_t]
    if args.with_frostmourne:
        ability_inputs.append(FROST_DIR / "ability.w3a")
        item_inputs.append(FROST_DIR / "item.w3t")
    merge_inputs(merged_a, ability_inputs)
    merge_inputs(merged_t, item_inputs)
    merge_inputs(merged_u, [base_u] + [d / "hero.w3u" for d in hero_dirs])
    merge_inputs(merged_h, [base_h, ward])

    assets = list(ICON_ASSETS)
    script_dirs = [BASE / "scripts" / "heroes"]
    patched_script = None
    if args.with_frostmourne:
        assets += list(FROST_ASSETS)
        script_dirs.append(BASE / "scripts" / "frostmourne")
        patched_script = work / "patched.j"
        patched = patch_browser(script)
        patched_script.write_bytes(patched)
    pre_add_assets(source, assets)

    inject = [
        PY, str(HERE / "inject_native.py"), str(source),
    ]
    if patched_script:
        inject += ["--base-script", str(patched_script)]
    for script_dir in script_dirs:
        inject += ["--script", str(script_dir)]
    inject += [
        "--no-verify",
        "--file", str(merged_a) + "=war3map.w3a",
        "--file", str(merged_t) + "=war3map.w3t",
        "--file", str(merged_u) + "=war3map.w3u",
        "--file", str(merged_h) + "=war3map.w3h",
        "--out", str(output),
    ]
    run(inject)

    archive = W.MPQArchive(str(output))
    try:
        final_script = archive.read_file("war3map.j") or b""
        unit_data = archive.read_file("war3map.w3u")
        ability_data = archive.read_file("war3map.w3a")
        item_data = archive.read_file("war3map.w3t")
    finally:
        archive.close()
    if b"HB_Init" not in final_script or b"addhero" not in final_script:
        raise SystemExit("hero command entry point is missing")
    if not unit_data or not ability_data or not item_data:
        raise SystemExit("hero object data is missing")
    _, units, _ = OBJ.read_objects_bytes(
        unit_data, False, fname="w3u", with_end=True
    )
    unit_ids = {(e[2].replace("\0", "") or e[1].replace("\0", "")) for e in units}
    missing_units = set(HERO_IDS) - unit_ids
    if missing_units:
        raise SystemExit("missing hero units: %s" % sorted(missing_units))
    _, abilities, _ = OBJ.read_objects_bytes(
        ability_data, True, fname="w3a", with_end=True
    )
    ability_ids = {(e[2].replace("\0", "") or e[1].replace("\0", ""))
                   for e in abilities}
    missing_abilities = set(ABIL_IDS) - ability_ids
    if missing_abilities:
        raise SystemExit("missing hero abilities: %s" % sorted(missing_abilities))
    _, items, _ = OBJ.read_objects_bytes(
        item_data, False, fname="w3t", with_end=True
    )
    item_art = {(e[2].replace("\0", "") or e[1].replace("\0", "")):
                {m[0]: m[4] for m in e[3]} for e in items}
    if args.with_frostmourne and item_art["I105"].get("iico") != (
        b"ReplaceableTextures\\CommandButtons\\BTNFrostMourne.blp"
    ):
        raise SystemExit("Frostmourne must keep the engine-switched base icon")
    print("hero injection OK:", output)
    return 0


if __name__ == "__main__":
    sys.exit(main())
