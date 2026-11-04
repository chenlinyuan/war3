#!/usr/bin/env python3
"""Build a complete ALAS item/wing/weapon release for a JASS campaign.

The release includes the complete per-chapter item and skill browser,
Archimonde Hand (``I103``), four wings (``I100/I101/I102/I104``),
Frostmourne (``I105``), and the Warglaive of Azzinoth (``I106``).

Objects, scripts, and all assets are injected into each chapter in one MPQ
write.  This avoids a second hash-table expansion after chapter-local assets
have made protected archive entries unaddressable.
"""

from __future__ import annotations

import argparse
import hashlib
import importlib
import os
import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(HERE))

import fix_alas_campaign_names as NAMES  # noqa: E402
import alas_item_rules as ITEM_RULES  # noqa: E402
import merge_w3obj as M  # noqa: E402
import port_item_skill_campaign as ITEM  # noqa: E402
import port_weapon_campaign as WPN  # noqa: E402
import port_wings_campaign as PC  # noqa: E402
import war3mpq as W  # noqa: E402

PY = sys.executable
WING_DIR = ROOT / "scripts" / "wings"


def run(args: list[object], env: dict[str, str] | None = None) -> None:
    text = [str(value) for value in args]
    print(">>>", " ".join(text), flush=True)
    if subprocess.run(text, env=env).returncode:
        raise SystemExit("command failed: " + " ".join(text))


def campaign_object_ids(path: Path) -> set[str]:
    archive = W.MPQArchive(str(path))
    try:
        found = set()
        for extension in ("w3a", "w3t", "w3u", "w3h"):
            if not archive.read_file("war3map." + extension):
                continue
            _version, entries = ITEM.read_objects(
                archive, "war3map." + extension,
                extension in ("w3a", "w3q"),
            )
            for _table, _old, new, _mods in entries:
                ident = new.replace("\0", "")
                if ident:
                    found.add(ident)
        return found
    finally:
        archive.close()


def merge_chapter_objects(
    chapter: Path,
    work: Path,
    sources: dict[str, Path],
) -> list[tuple[Path, str]]:
    output = []
    archive = W.MPQArchive(str(chapter))
    try:
        for extension in ("w3a", "w3t", "w3u", "w3h"):
            internal = "war3map." + extension
            target = archive.read_file(internal)
            source = sources.get(extension)
            if not target and not source:
                continue
            directory = work / "_obj_final" / chapter.stem
            directory.mkdir(parents=True, exist_ok=True)
            local = directory / ("merged." + extension)
            if target and source:
                raw_target = directory / ("target." + extension)
                raw_target.write_bytes(target)
                M.merge_files(str(local), [str(raw_target), str(source)])
            elif target:
                local.write_bytes(target)
            else:
                local.write_bytes(source.read_bytes())
            if extension in ("w3a", "w3t"):
                ITEM_RULES.patch_file(local, extension)
            output.append((local, internal))
    finally:
        archive.close()
    return output


def required_item_ids(config) -> set[str]:
    weapon_ids = getattr(
        config, "WEAPONS", {"frostmourne": "I105", "warglaive": "I106"}
    )
    ids = set(weapon_ids.values())
    ids.add(config.HAND["item"])
    ids.update(wing["item"] for wing in config.WINGS)
    return ids


def required_ability_ids(config) -> set[str]:
    ids = {"A113", "A117", "A118"}
    ids.update(
        config.HAND[key]
        for key in ("finger", "aura", "speed", "bash")
        if config.HAND.get(key)
    )
    for wing in config.WINGS:
        for key in ("book", "book2", "model_abil", "active"):
            if wing.get(key):
                ids.add(wing[key])
        ids.update(wing.get("book_abils", ()))
        ids.update(wing.get("book2_abils", ()))
    return ids


def validate_chapter(
    path: Path,
    assets: list[tuple[Path, str]],
    config,
) -> None:
    archive = W.MPQArchive(str(path))
    try:
        script = archive.read_file("war3map.j") or b""
        for marker in (
            b"function IB_Init takes",
            b"function WG_Init takes",
            b"function FR_Init takes",
            b"function WGL_Init takes",
        ):
            if marker not in script:
                raise SystemExit(
                    "%s missing runtime marker %r" % (path.name, marker)
                )
        item_active = ITEM.selected_equipment_mode() == "item"
        mode_value = b"true" if item_active else b"false"
        for mode_name in (
            b"WG_ITEM_ACTIVE",
            b"FR_ITEM_ACTIVE",
            b"WGL_ITEM_ACTIVE",
        ):
            expected = mode_name + b" = " + mode_value
            if script.count(expected) != 1:
                raise SystemExit(
                    "%s has the wrong %s ownership mode"
                    % (path.name, mode_name.decode("ascii"))
                )
        if item_active and b"BlzUnitItemInEquipmentSlot" not in script:
            raise SystemExit(
                "%s is missing loadout ownership checks" % path.name
            )
        ids = campaign_object_ids(path)
        missing_items = required_item_ids(config) - ids
        missing_abilities = required_ability_ids(config) - ids
        if missing_items or missing_abilities:
            raise SystemExit(
                "%s missing item IDs: %s; missing ability IDs: %s"
                % (
                    path.name,
                    ", ".join(sorted(missing_items)) or "-",
                    ", ".join(sorted(missing_abilities)) or "-",
                )
            )
        missing_assets = [
            internal for _source, internal in assets
            if not archive.read_file(internal)
        ]
        if missing_assets:
            raise SystemExit(
                "%s missing imported assets: %s"
                % (path.name, ", ".join(missing_assets[:8]))
            )
    finally:
        archive.close()


def patch_title(path: Path, recover: Path) -> str:
    archive = W.MPQArchive(str(path))
    try:
        old_w3f = archive.read_file("war3campaign.w3f") or b""
    finally:
        archive.close()
    title = NAMES.desired_title(path)
    NAMES.patch_with_mpq(path, NAMES.make_w3f(old_w3f, title), recover)
    NAMES.patch_hm3w(path, title)
    actual_w3f, actual_hm3w = NAMES.read_campaign_title(path)
    if actual_w3f != title or (
        actual_hm3w is not None and actual_hm3w != title
    ):
        raise SystemExit("campaign title verification failed")
    return title


def build(args: argparse.Namespace) -> int:
    source = args.campaign.resolve()
    work = args.work.resolve()
    output = args.output.resolve()
    config = args.config
    config_module = importlib.import_module(config)
    weapon_ids = getattr(
        config_module,
        "WEAPONS",
        {"frostmourne": "I105", "warglaive": "I106"},
    )
    env = dict(os.environ)
    env["PYTHONUTF8"] = "1"
    env["PYTHONIOENCODING"] = "utf-8"
    env["WINGS_CONFIG"] = config

    if not source.is_file():
        raise SystemExit("campaign not found: " + str(source))
    config_path = HERE / (config + ".py")
    if not config_path.is_file():
        raise SystemExit("campaign wing config not found: " + str(config_path))
    if work.exists() and any(work.iterdir()):
        raise SystemExit("work directory must be empty: " + str(work))

    run([PY, HERE / "port_wings_campaign.py", "extract", source,
         "--work", work])
    if os.environ.get("ALAS_FT_DATA", "0").strip() == "1":
        run([
            PY, HERE / "apply_ft_data.py",
            "--input", work / "base",
        ])
    run([PY, HERE / "port_wings_campaign.py", "objects",
         "--work", work, "--config", config, "--mounts", "none"], env)

    weapon_sources = WPN.build_sources(
        work,
        args.object_source,
        weapon_ids,
        config_module.BUFFS["warglaive_charge"],
    )
    base = work / "base"
    for extension in ("w3a", "w3t"):
        target = base / ("war3campaign." + extension)
        if not target.is_file():
            target.write_bytes(
                ITEM.OBJ.write_objects_bytes(
                    3, [], extension == "w3a"
                )
            )
            print(
                "created empty campaign object file:",
                target,
                flush=True,
            )
        WPN.merge_object(
            target,
            weapon_sources[extension],
            extension,
        )
    ITEM_RULES.patch_object_tree(base)

    chapters = sorted(
        path for path in base.iterdir()
        if path.suffix.lower() in (".w3x", ".w3m")
    )

    run([PY, HERE / "port_wings_campaign.py", "ib",
         "--work", work, "--config", config, "--mounts", "none"], env)
    warglaive_dir = WPN.build_warglaive_module(
        work, weapon_ids["warglaive"]
    )
    frostmourne_dir = WPN.build_frostmourne_module(
        work, weapon_ids["frostmourne"]
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
            WING_DIR,
            frostmourne_dir,
            warglaive_dir,
        )
    )
    startup_dir = ITEM.prepare_alas_startup(work)
    browser = work / "item-browser" / "f.j"
    WPN.patch_browser(
        browser,
        config_module.HAND["item"],
        weapon_ids["frostmourne"],
        weapon_ids["warglaive"],
    )

    assets = ITEM.make_assets(work)
    for local, internal in assets:
        if internal.lower() not in {
            "stormfallred.mdx",
            "war3campimported\\demonboltimpactsilent.mdx",
        }:
            continue
        target = base / internal.replace("\\", os.sep).replace("/", os.sep)
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_bytes(local.read_bytes())
    script_dirs = [
        work / "item-browser",
        equipment_wings,
        equipment_frostmourne,
        equipment_warglaive,
        startup_dir,
    ]
    combined_dir = work / "_combined_objects"
    combined_dir.mkdir(parents=True, exist_ok=True)
    combined_sources = {}
    for extension in ("w3a", "w3t", "w3u", "w3h"):
        inputs = []
        if extension in ("w3a", "w3t"):
            inputs.append(weapon_sources[extension])
        wing_name = {
            "w3a": "_wing.w3a",
            "w3t": "_wing_item.w3t",
            "w3u": "_wing_unit.w3u",
            "w3h": "_wing_buff.w3h",
        }[extension]
        inputs.append(HERE / wing_name)
        combined = combined_dir / ("combined." + extension)
        M.merge_files(
            str(combined), [str(path) for path in inputs]
        )
        combined_sources[extension] = combined
    for index, chapter in enumerate(chapters, 1):
        print("\n[%d/%d] one-pass ALAS injection: %s"
              % (index, len(chapters), chapter.name), flush=True)
        object_payloads = merge_chapter_objects(
            chapter, work, combined_sources
        )
        ITEM.configure_equipment_ownership(
            work / "_obj_final" / chapter.stem, item_active
        )
        archive = W.MPQArchive(str(chapter))
        try:
            present = {
                internal.lower()
                for _path, internal in assets
                if archive.read_file(internal)
            }
        finally:
            archive.close()

        inject = [PY, HERE / "inject_native.py", chapter, "--no-backup"]
        for script_dir in script_dirs:
            inject += ["--script", script_dir]
        for local, internal in object_payloads:
            inject += ["--file", "%s=%s" % (local, internal)]
        for local, internal in assets:
            if internal.lower() in present:
                continue
            inject += [
                "--file", "%s=%s" % (local, internal),
                "--store", internal,
            ]
        run(inject)
        validate_chapter(chapter, assets, config_module)

    run([PY, HERE / "port_wings_campaign.py", "pack", source,
         "--work", work, "--out", output])
    title = patch_title(output, work / "recover" / "alas_campaign_names")
    digest = hashlib.sha256(output.read_bytes()).hexdigest().upper()
    print("chapters:", len(chapters))
    print("display title:", title)
    print("output:", output)
    print("bytes:", output.stat().st_size)
    print("sha256:", digest)
    return 0


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--campaign", type=Path, required=True)
    parser.add_argument("--work", type=Path, required=True)
    parser.add_argument("--config", required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument(
        "--object-source", type=Path, default=WPN.DEFAULT_OBJECT_SOURCE
    )
    return build(parser.parse_args())


if __name__ == "__main__":
    raise SystemExit(main())
