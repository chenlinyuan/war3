"""Build the complete ALAS equipment set into one Reforged JASS map."""

from __future__ import annotations

import argparse
import importlib
import shutil
import subprocess
import sys
from pathlib import Path


HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(HERE))

import alas_item_rules as ITEM_RULES  # noqa: E402
import merge_w3obj as M  # noqa: E402
import port_item_skill_campaign as ITEM  # noqa: E402
import port_weapon_campaign as WPN  # noqa: E402
import port_wings as P  # noqa: E402
import war3mpq as W  # noqa: E402


PY = sys.executable
DEFAULT_OBJECT_SOURCE = (
    ROOT / "maps" / "port" / "lost_temple_30"
    / "LostTempleLV_BladeMaster30.w3x"
)


def read_script(archive) -> tuple[str, bytes, bytes]:
    for internal in (
        "war3map.j",
        "scripts\\war3map.j",
        "Scripts\\war3map.j",
    ):
        data = archive.read_file(internal) or b""
        if data:
            lua = (
                archive.read_file("war3map.lua")
                or archive.read_file("scripts\\war3map.lua")
                or archive.read_file("Scripts\\war3map.lua")
                or b""
            )
            return internal, data, lua
    lua = (
        archive.read_file("war3map.lua")
        or archive.read_file("scripts\\war3map.lua")
        or archive.read_file("Scripts\\war3map.lua")
        or b""
    )
    return "war3map.j", b"", lua


def run(args: list[object], env: dict[str, str] | None = None) -> None:
    text = [str(value) for value in args]
    print(">>>", " ".join(text), flush=True)
    if subprocess.run(text, env=env).returncode:
        raise SystemExit("command failed: " + " ".join(text))


def target_object_files(source: Path) -> dict[str, bytes]:
    archive = W.MPQArchive(str(source))
    try:
        return {
            extension: archive.read_file("war3map." + extension) or b""
            for extension in ("w3a", "w3t", "w3u", "w3h")
        }
    finally:
        archive.close()


def merge_objects(
    source: Path,
    work: Path,
    wing_sources: dict[str, Path],
    weapon_sources: dict[str, Path],
) -> list[tuple[Path, str]]:
    originals = target_object_files(source)
    object_sources = {
        "w3a": [
            wing_sources["hand_w3a"],
            weapon_sources["w3a"],
            wing_sources["w3a"],
        ],
        "w3t": [
            wing_sources["hand_w3t"],
            weapon_sources["w3t"],
            wing_sources["w3t"],
        ],
        "w3u": [wing_sources["w3u"]],
        "w3h": [wing_sources["w3h"]],
    }
    output_dir = work / "_obj_final"
    output_dir.mkdir(parents=True, exist_ok=True)
    merged_files = []
    for extension, sources in object_sources.items():
        target = output_dir / ("base." + extension)
        with_levels = extension in ("w3a", "w3q")
        original = originals.get(extension) or b""
        target.write_bytes(
            original
            if original
            else ITEM.OBJ.write_objects_bytes(3, [], with_levels)
        )
        merged = output_dir / ("merged." + extension)
        M.merge_files(
            str(merged),
            [str(target)] + [str(path) for path in sources],
        )
        if extension in ("w3a", "w3t"):
            ITEM_RULES.patch_file(merged, extension)
        merged_files.append((merged, "war3map." + extension))
    return merged_files


def build(args: argparse.Namespace) -> int:
    source = args.map.resolve()
    work = args.work.resolve()
    output = args.output.resolve()
    object_source = args.object_source.resolve()
    if source.suffix.lower() not in (".w3x", ".w3m"):
        raise SystemExit("single-map mode requires .w3x or .w3m")
    if output.suffix.lower() != source.suffix.lower():
        raise SystemExit("output extension must match the source map")
    if output == source:
        raise SystemExit("output must not overwrite the clean source map")
    if work.exists() and any(work.iterdir()):
        raise SystemExit("work directory must be empty")
    if not source.is_file() or not object_source.is_file():
        raise SystemExit("source map or weapon object source missing")

    archive = W.MPQArchive(str(source))
    try:
        script_internal, jass, lua = read_script(archive)
    finally:
        archive.close()
    if lua:
        raise SystemExit(
            "Lua single-map mode is not enabled yet; use a JASS .w3x/.w3m."
        )
    if not jass:
        raise SystemExit("map has no war3map.j")
    if b"WG_Init" in jass or b"IB_Init" in jass:
        raise SystemExit("source map already contains the ALAS runtime")

    work.mkdir(parents=True, exist_ok=True)
    config_name = args.config
    if not (HERE / (config_name + ".py")).is_file():
        raise SystemExit("map wing config not found: " + config_name)
    config = importlib.import_module(config_name)
    weapon_ids = getattr(
        config, "WEAPONS",
        {"frostmourne": "I105", "warglaive": "I106"},
    )
    env = dict(__import__("os").environ)
    env["WINGS_CONFIG"] = config_name
    env["PYTHONUTF8"] = "1"
    env["PYTHONIOENCODING"] = "utf-8"

    wing_sources = ITEM.prepare_wings(work, config_name)
    weapon_sources = WPN.build_sources(
        work,
        object_source,
        weapon_ids,
        config.BUFFS["warglaive_charge"],
    )
    browser = P.prepare_item_browser(
        str(work), config_name, config, str(source)
    )
    WPN.patch_browser(
        Path(browser) / "f.j",
        config.HAND["item"],
        weapon_ids["frostmourne"],
        weapon_ids["warglaive"],
    )
    frostmourne = WPN.build_frostmourne_module(
        work, weapon_ids["frostmourne"]
    )
    warglaive = WPN.build_warglaive_module(
        work, weapon_ids["warglaive"]
    )
    item_active = ITEM.selected_equipment_mode() == "item"
    prepare_scripts = (
        ITEM.prepare_jass_item_scripts
        if item_active
        else ITEM.prepare_jass_command_scripts
    )
    equipment_wings, equipment_frostmourne, equipment_warglaive = (
        prepare_scripts(
            work,
            ROOT / "scripts" / "wings",
            frostmourne,
            warglaive,
        )
    )
    startup = ITEM.prepare_alas_startup(work)
    assets = ITEM.make_assets(work)
    objects = merge_objects(source, work, wing_sources, weapon_sources)
    ITEM.configure_equipment_ownership(
        work / "_obj_final", item_active
    )

    script_dirs = [
        Path(browser),
        equipment_wings,
        equipment_frostmourne,
        equipment_warglaive,
        startup,
    ]
    P.check_script_clash(str(source), [str(path) for path in script_dirs])
    output.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(source, output)
    inject = [
        PY, HERE / "inject_native.py", output, "--no-backup",
        "--script-internal", script_internal,
    ]
    for script_dir in script_dirs:
        inject += ["--script", script_dir]
    for local, internal in objects:
        inject += ["--file", "%s=%s" % (local, internal)]
    for local, internal in assets:
        inject += [
            "--file", "%s=%s" % (local, internal),
            "--store", internal,
        ]
    run(inject, env)

    title = "alas " + (
        output.stem[4:].lstrip()
        if output.stem.lower().startswith("alas")
        else output.stem
    )
    run([PY, HERE / "_patch_hm3w_name.py", output, title])
    print("chapters: 1")
    print("display title:", title)
    print("output:", output)
    print("bytes:", output.stat().st_size)
    print(
        "sha256:",
        __import__("hashlib").sha256(output.read_bytes()).hexdigest().upper(),
    )
    return 0


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--map", type=Path, required=True)
    parser.add_argument("--work", type=Path, required=True)
    parser.add_argument("--config", required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument(
        "--object-source", type=Path, default=DEFAULT_OBJECT_SOURCE
    )
    return build(parser.parse_args())


if __name__ == "__main__":
    raise SystemExit(main())
