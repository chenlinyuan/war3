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
    extra_sources: dict[str, list[Path]] | None = None,
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
    for extension, sources in (extra_sources or {}).items():
        object_sources.setdefault(extension, []).extend(sources)
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


def combine_extra_script(work: Path, script_dirs: list[str]) -> Path | None:
    if not script_dirs:
        return None
    target = work / "_extra_lua_script"
    target.mkdir(parents=True, exist_ok=True)
    globals_text = []
    functions_text = []
    for raw_dir in script_dirs:
        script_dir = Path(raw_dir).resolve()
        for name in ("g.j", "f.j"):
            if not (script_dir / name).is_file():
                raise SystemExit(
                    "extra Lua script directory is incomplete: "
                    + str(script_dir)
                )
        globals_text.append(
            (script_dir / "g.j").read_text(encoding="utf-8")
        )
        functions_text.append(
            (script_dir / "f.j").read_text(encoding="utf-8")
        )
    (target / "g.j").write_text(
        "\n\n".join(globals_text),
        encoding="utf-8",
    )
    (target / "f.j").write_text(
        "\n\n".join(functions_text),
        encoding="utf-8",
    )
    return target


def build_lua_map(
    source: Path,
    output: Path,
    work: Path,
    config_name: str,
    object_source: Path,
    extra_scripts: list[str],
    extra_objects: list[str],
) -> int:
    if output.suffix.lower() != source.suffix.lower():
        raise SystemExit("output extension must match the source map")
    config = importlib.import_module(config_name)
    weapon_ids = getattr(
        config,
        "WEAPONS",
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
    ITEM.patch_frostmourne_source(weapon_sources)
    ITEM.patch_warglaive_sources(weapon_sources)
    sources: dict[str, list[Path]] = {
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
    for spec in extra_objects:
        extension, separator, source_text = spec.partition("=")
        if not separator or extension not in ("w3a", "w3t", "w3h"):
            raise SystemExit(
                "--extra-object must be w3a=PATH, w3t=PATH, or w3h=PATH"
            )
        path = Path(source_text).resolve()
        if not path.is_file():
            raise SystemExit("extra object file missing: " + str(path))
        sources[extension].append(path)
    expected_objects = {
        ext: set().union(
            *(ITEM.object_ids(path, ext) for path in paths)
        )
        for ext, paths in sources.items()
    }
    item_count, skill_count = ITEM.build_tables(
        work,
        source,
        wing_sources,
    )
    print("tables: %d items, %d skills" % (item_count, skill_count))
    browser_dir = ITEM.prepare_browser(
        work,
        expected_objects["w3a"],
    )
    assets = ITEM.make_assets(work)
    asset_names = [internal for _path, internal in assets]
    item_active = ITEM.selected_equipment_mode() == "item"
    merged = ITEM.merge_chapter_objects(
        source,
        work / "_obj_item_skill_map",
        sources,
        asset_names,
        item_active,
    )
    extra_script = combine_extra_script(work, extra_scripts)
    module = ITEM.build_lua_module(
        work,
        browser_dir,
        item_active,
        output_suffix=source.stem,
        extra_script=extra_script,
    )
    if extra_script is not None:
        extra_functions = (
            extra_script / "f.j"
        ).read_text(encoding="utf-8")
        if "function TT_Init takes" in extra_functions:
            if b"function TT_Init()" not in module:
                raise SystemExit("universal talent Lua init is missing")
            if b'__alasRunInit("TALENT", TT_Init)' not in module:
                raise SystemExit(
                    "universal talent Lua init is not guarded"
                )
        if "function WED_Init takes" in extra_functions:
            if b"function WED_Init()" not in module:
                raise SystemExit("wild drop Lua init is missing")
            if b'__alasRunInit("WED", WED_Init)' not in module:
                raise SystemExit("wild drop Lua init is not guarded")
    ITEM.inject_chapter(source, output, module, merged, assets)
    ITEM.validate_chapter(
        output,
        expected_objects,
        item_active,
    )
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
        if b"WG_Init" in lua or b"IB_Init" in lua:
            raise SystemExit(
                "source map already contains the ALAS runtime"
            )
        return build_lua_map(
            source,
            output,
            work,
            args.config,
            object_source,
            args.extra_script,
            args.extra_object,
        )
    if not jass:
        raise SystemExit("map has no war3map.j")
    if b"WG_Init" in jass or b"IB_Init" in jass:
        raise SystemExit("source map already contains the ALAS runtime")

    work.mkdir(parents=True, exist_ok=True)
    base_script: Path | None = None
    if args.suppress_source_backpack_auto:
        source_call = b"call UnitAddItemByIdSwapped('B30B', u)"
        source_count = jass.count(source_call)
        if source_count > 1:
            raise SystemExit(
                "expected at most one source B30B autogrant call, found %d"
                % source_count
            )
        if source_count == 1:
            base_script = work / "_base_no_source_backpack.j"
            base_script.write_bytes(jass.replace(source_call, b""))
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
    extra_sources: dict[str, list[Path]] = {}
    for spec in args.extra_object:
        extension, separator, source_text = spec.partition("=")
        if not separator or extension not in ("w3a", "w3t", "w3h"):
            raise SystemExit(
                "--extra-object must be w3a=PATH, w3t=PATH, or w3h=PATH"
            )
        path = Path(source_text).resolve()
        if not path.is_file():
            raise SystemExit("extra object file missing: " + str(path))
        extra_sources.setdefault(extension, []).append(path)
    objects = merge_objects(
        source, work, wing_sources, weapon_sources, extra_sources
    )
    ITEM.configure_equipment_ownership(
        work / "_obj_final", item_active
    )
    if args.backpack_talent:
        ITEM.set_object_mod_value(
            work / "_obj_final" / "merged.w3t",
            "w3t",
            "B30B",
            "iabi",
            0,
            0,
            "AIni,AEqu,ASde," + args.backpack_talent_id,
        )

    script_dirs = [
        Path(browser),
        equipment_wings,
        equipment_frostmourne,
        equipment_warglaive,
        startup,
    ]
    script_dirs.extend(Path(path).resolve() for path in args.extra_script)
    P.check_script_clash(str(source), [str(path) for path in script_dirs])
    output.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(source, output)
    inject = [
        PY, HERE / "inject_native.py", output, "--no-backup",
        "--script-internal", script_internal,
    ]
    if base_script is not None:
        inject += ["--base-script", str(base_script)]
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
    parser.add_argument("--extra-script", action="append", default=[])
    parser.add_argument("--extra-object", action="append", default=[])
    parser.add_argument("--backpack-talent", action="store_true")
    parser.add_argument("--backpack-talent-id", default="ATal")
    parser.add_argument("--suppress-source-backpack-auto", action="store_true")
    return build(parser.parse_args())


if __name__ == "__main__":
    raise SystemExit(main())
