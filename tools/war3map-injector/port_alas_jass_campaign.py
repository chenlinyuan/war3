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
import json
import os
import re
import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(HERE))

import fix_alas_campaign_names as NAMES  # noqa: E402
import alas_item_rules as ITEM_RULES  # noqa: E402
import campaign_paths as CAMP  # noqa: E402
import merge_w3obj as M  # noqa: E402
import official_campaign_metadata as OFFICIAL  # noqa: E402
import port_item_skill_campaign as ITEM  # noqa: E402
import port_weapon_campaign as WPN  # noqa: E402
import port_wings_campaign as PC  # noqa: E402
import wild_equipment_drops as WILD_DROPS  # noqa: E402
import war3mpq as W  # noqa: E402

PY = sys.executable
WING_DIR = ROOT / "scripts" / "wings"
KNOWN_GARITHOS_SKIP_FIX = b"ALAS_GARITHOS_DWARF_SKIP_FIX"
TALENT_CACHE_MARKER = b"ALAS_TALENT_CACHE_V2"
OLD_TALENT_CACHE_MARKER = b"ALAS_TALENT_CACHE_V1"
CAMPAIGN_CACHE_AUDIT_MARKER = b"ALAS_CAMPAIGN_CACHE_AUDIT_V2"
PREVIOUS_NATIVE_CAMPAIGN_STATE_MARKER = b"ALAS_NATIVE_CAMPAIGN_STATE_V1"
NATIVE_CAMPAIGN_STATE_MARKER = b"ALAS_NATIVE_TALENT_SNAPSHOT_V1"


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


def chapter_script(path: Path) -> tuple[str, bytes]:
    archive = W.MPQArchive(str(path))
    try:
        for internal in (
            "war3map.j",
            r"scripts\war3map.j",
            r"Scripts\war3map.j",
        ):
            data = archive.read_file(internal) or b""
            if data:
                return internal, data
    finally:
        archive.close()
    raise SystemExit(str(path) + " has no JASS script")


def _find_jass_call(
    line: bytes,
    function_name: bytes,
) -> tuple[list[bytes], bytes] | None:
    pattern = re.compile(
        rb"(?<![A-Za-z0-9_])" + re.escape(function_name) + rb"\s*\("
    )
    for match in pattern.finditer(line):
        prefix = line[: match.start()]
        quoted = False
        comment = False
        index = 0
        while index < len(prefix):
            char = prefix[index]
            if char == 0x22:
                quoted = not quoted
            elif (
                not quoted
                and char == 0x2F
                and index + 1 < len(prefix)
                and prefix[index + 1] == 0x2F
            ):
                comment = True
                break
            index += 1
        if quoted or comment:
            continue
        opening = line.find(b"(", match.start())
        depth = 1
        quoted = False
        escaped = False
        index = opening + 1
        while index < len(line):
            char = line[index]
            if quoted:
                if escaped:
                    escaped = False
                elif char == 0x5C:
                    escaped = True
                elif char == 0x22:
                    quoted = False
            elif char == 0x22:
                quoted = True
            elif char == 0x28:
                depth += 1
            elif char == 0x29:
                depth -= 1
                if depth == 0:
                    args = _split_jass_args(line[opening + 1:index])
                    return args, line[index + 1:]
            index += 1
        return None
    return None


def _split_jass_args(data: bytes) -> list[bytes]:
    args = []
    start = 0
    depth = 0
    quoted = False
    escaped = False
    for index, char in enumerate(data):
        if quoted:
            if escaped:
                escaped = False
            elif char == 0x5C:
                escaped = True
            elif char == 0x22:
                quoted = False
            continue
        if char == 0x22:
            quoted = True
        elif char == 0x28:
            depth += 1
        elif char == 0x29:
            depth -= 1
        elif char == 0x2C and depth == 0:
            args.append(data[start:index].strip())
            start = index + 1
    args.append(data[start:].strip())
    return args


def _with_calls_around(
    line: bytes,
    before_calls: tuple[bytes, ...],
    after_calls: tuple[bytes, ...],
) -> bytes:
    if line.endswith(b"\r\n"):
        body, ending = line[:-2], b"\r\n"
    elif line.endswith((b"\n", b"\r")):
        body, ending = line[:-1], line[-1:]
    else:
        body, ending = line, b"\r\n"
    indent = re.match(rb"[ \t]*", body).group(0)
    output = bytearray()
    for call in before_calls:
        output.extend(indent + call + ending)
    output.extend(body + ending)
    for call in after_calls:
        output.extend(indent + call + ending)
    return bytes(output)


def _append_talent_cache_call(line: bytes, call: bytes) -> bytes:
    return _with_calls_around(line, (), (call,))


def _replace_call_result(
    line: bytes,
    function_name: bytes,
    result_global: bytes,
) -> bytes:
    pattern = re.compile(
        rb"(?<![A-Za-z0-9_])call(\s+)"
        + re.escape(function_name)
        + rb"\s*\("
    )
    replacement = (
        b"set "
        + result_global
        + b" =\\1"
        + function_name
        + b"("
    )
    replaced, count = pattern.subn(replacement, line, count=1)
    if count != 1:
        raise ValueError(
            "cannot capture result of "
            + function_name.decode("ascii", "replace")
        )
    return replaced


def _is_call_suffix(suffix: bytes) -> bool:
    remainder = suffix.strip()
    return not remainder or remainder.startswith(b"//")


def patch_campaign_talent_cache(
    script: bytes,
) -> tuple[bytes, dict[str, int]]:
    """Normalize talent abilities before native campaign unit storage."""
    if NATIVE_CAMPAIGN_STATE_MARKER in script:
        return script, {
            "normalize": script.count(
                b"call TT_CampaignNormalizeUnitForStore("
            ),
            "snapshot_store": script.count(
                b"call TT_CampaignStoreTalentSnapshot("
            ),
            "snapshot_restore": script.count(
                b"call TT_CampaignRestoreTalentSnapshot("
            ),
            "audit_store": script.count(b"call TT_CampaignAuditStore("),
            "restore_probe": script.count(
                b"call TT_CampaignAuditRestoreProbe("
            ),
            "save": script.count(b"call TT_CampaignAuditSave("),
        }
    if (
        OLD_TALENT_CACHE_MARKER in script
        or CAMPAIGN_CACHE_AUDIT_MARKER in script
        or PREVIOUS_NATIVE_CAMPAIGN_STATE_MARKER in script
    ):
        raise ValueError(
            "campaign already uses an older campaign-state injection; "
            "rebuild from a clean source"
        )
    output = []
    counts = {
        "normalize": 0,
        "snapshot_store": 0,
        "snapshot_restore": 0,
        "audit_store": 0,
        "restore_probe": 0,
        "save": 0,
    }
    restore_names = (
        b"RestoreUnitLocFacingAngleBJ",
        b"RestoreUnitLocFacingPointBJ",
        b"RestoreUnitBJ",
    )
    for line in script.splitlines(keepends=True):
        output.append(line)
        store = _find_jass_call(line, b"StoreUnitBJ")
        if store is not None:
            args, suffix = store
            if args and len(args) >= 4 and _is_call_suffix(suffix):
                unit = args[0]
                key = args[1]
                mission = args[2]
                cache = args[3]
                result_line = _replace_call_result(
                    line,
                    b"StoreUnitBJ",
                    b"TT_CAMPAIGN_STORE_RESULT",
                )
                output[-1:] = [
                    _with_calls_around(
                        result_line,
                        (),
                        (
                            b"call TT_CampaignStoreTalentSnapshot("
                            + unit
                            + b", "
                            + cache
                            + b", "
                            + mission
                            + b", "
                            + key
                            + b") // "
                            + NATIVE_CAMPAIGN_STATE_MARKER,
                            b"call TT_CampaignAuditStore("
                            + unit
                            + b", "
                            + cache
                            + b", "
                            + key
                            + b", "
                            + mission
                            + b", TT_CAMPAIGN_STORE_RESULT) // "
                            + CAMPAIGN_CACHE_AUDIT_MARKER,
                        ),
                    )
                ]
                counts["snapshot_store"] += 1
                counts["audit_store"] += 1
                continue
        for name in restore_names:
            restore = _find_jass_call(line, name)
            if restore is None:
                continue
            args, suffix = restore
            if args and len(args) >= 3 and _is_call_suffix(suffix):
                key = args[0]
                mission = args[1]
                cache = args[2]
                output[-1:] = [
                    _with_calls_around(
                        line,
                        (
                            b"call TT_CampaignAuditRestoreProbe("
                            + cache
                            + b", "
                            + mission
                            + b", "
                            + key
                            + b") // "
                            + CAMPAIGN_CACHE_AUDIT_MARKER,
                        ),
                        (
                            b"call TT_CampaignRestoreTalentSnapshot("
                            b"GetLastRestoredUnitBJ(), "
                            + cache
                            + b", "
                            + mission
                            + b", "
                            + key
                            + b") // "
                            + NATIVE_CAMPAIGN_STATE_MARKER,
                        ),
                    )
                ]
                counts["restore_probe"] += 1
                counts["snapshot_restore"] += 1
            break
        save = _find_jass_call(line, b"SaveGameCacheBJ")
        if save is not None:
            args, suffix = save
            if args and len(args) == 1 and _is_call_suffix(suffix):
                cache = args[0]
                result_line = _replace_call_result(
                    line,
                    b"SaveGameCacheBJ",
                    b"TT_CAMPAIGN_SAVE_RESULT",
                )
                output[-1:] = [
                    _append_talent_cache_call(
                        result_line,
                        b"call TT_CampaignAuditSave("
                        + cache
                        + b", TT_CAMPAIGN_SAVE_RESULT) // "
                        + CAMPAIGN_CACHE_AUDIT_MARKER,
                    )
                ]
                counts["save"] += 1
    return b"".join(output), counts


def has_campaign_talent_cache(script_dir: Path) -> bool:
    for name in ("f.j", "g.j"):
        path = script_dir / name
        if not path.is_file():
            continue
        text = path.read_text(encoding="utf-8", errors="replace")
        if "function TT_CampaignNormalizeUnitForStore takes unit u" in text:
            return True
    return False


def patch_known_source_script(name: str, script: bytes) -> bytes:
    """Repair source-map bugs that are safe to identify by exact script text."""
    if name.lower() != "human02.w3m":
        return script
    if KNOWN_GARITHOS_SKIP_FIX in script:
        return script
    anchor = (
        b"    call ForGroupBJ( GetUnitsInRectAll(GetPlayableMapRect()), "
        b"function Trig_Dwarf_Sacrifice_Cinematic_Cancel_Func014002 )"
    )
    count = script.count(anchor)
    if count != 1:
        raise SystemExit(
            "human02.w3m has %d Garithos dwarf-skip reset anchors"
            % count
        )
    replacement = (
        b"    // " + KNOWN_GARITHOS_SKIP_FIX + b": skipping this cinematic "
        b"must leave units vulnerable."
    )
    return script.replace(anchor, replacement, 1)


def validate_extra_script(path: Path, script_dir: Path | None) -> None:
    if script_dir is None:
        return
    _internal, script = chapter_script(path)
    if b"function TT_Init takes nothing returns nothing" not in script:
        raise SystemExit(
            "%s is missing the universal talent entry" % path.name
        )
    if b"function TT_SavedBackpackIndex takes unit u returns integer" not in script:
        raise SystemExit(
            "%s is missing campaign-safe talent registration" % path.name
        )


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
    ids = {"A113", "A117", "A118", "A171"}
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
    campaign_loot: bool = False,
    talent_cache_counts: dict[str, int] | None = None,
) -> None:
    archive = W.MPQArchive(str(path))
    try:
        script = archive.read_file("war3map.j") or b""
        if (
            path.name.lower() == "human02.w3m"
            and KNOWN_GARITHOS_SKIP_FIX not in script
        ):
            raise SystemExit(
                "%s is missing the Garithos cinematic-skip fix"
                % path.name
            )
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
        if campaign_loot and b"function WED_Init takes" not in script:
            raise SystemExit(
                "%s missing campaign equipment drops" % path.name
            )
        if talent_cache_counts is not None:
            for marker in (
                b"function TT_CampaignNormalizeUnitForStore takes unit u",
                b"function TT_CampaignStoreTalentSnapshot takes unit u, gamecache cache,",
                b"function TT_CampaignRestoreTalentSnapshot takes unit u, gamecache cache,",
                b"function TT_CampaignAuditAbilities takes unit u, string phase",
                b"function TT_CampaignAuditStore takes unit u,",
                b"function TT_CampaignAuditRestoreProbe takes gamecache cache,",
                b"function TT_CampaignAuditSave takes gamecache cache,",
                b"event=CAMPAIGN_NATIVE_NORMALIZE",
                b"event=CAMPAIGN_TALENT_SNAPSHOT_STORE",
                b"event=CAMPAIGN_TALENT_SNAPSHOT_RESTORE",
                b"event=CAMPAIGN_TALENT_SNAPSHOT_MISSING",
                b"event=CAMPAIGN_STORE_AUDIT",
                b"event=CAMPAIGN_STORE_ABILITY",
                b"event=CAMPAIGN_RESTORE_PROBE",
                b"event=CAMPAIGN_CACHE_SAVE",
            ):
                if marker not in script:
                    raise SystemExit(
                        "%s missing campaign talent state marker %r"
                        % (path.name, marker)
                    )
            for marker, expected in (
                (
                    b"call TT_CampaignNormalizeUnitForStore(",
                    talent_cache_counts["normalize"],
                ),
                (
                    b"call TT_CampaignStoreTalentSnapshot(",
                    talent_cache_counts["snapshot_store"],
                ),
                (
                    b"call TT_CampaignRestoreTalentSnapshot(",
                    talent_cache_counts["snapshot_restore"],
                ),
                (
                    b"call TT_CampaignAuditStore(",
                    talent_cache_counts["audit_store"],
                ),
                (
                    b"call TT_CampaignAuditRestoreProbe(",
                    talent_cache_counts["restore_probe"],
                ),
                (
                    b"call TT_CampaignAuditSave(",
                    talent_cache_counts["save"],
                ),
            ):
                actual = script.count(marker)
                if actual < expected:
                    raise SystemExit(
                        "%s has %d native campaign state calls; expected %d"
                        % (path.name, actual, expected)
                    )
            if b"call TT_CampaignStore(" in script:
                raise SystemExit(
                    "%s still calls the legacy TT_CampaignStore" % path.name
                )
            if b"call TT_CampaignRestore(" in script:
                raise SystemExit(
                    "%s still calls the legacy TT_CampaignRestore" % path.name
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
    metadata = OFFICIAL.patch_w3f_bytes(
        NAMES.make_w3f(old_w3f, title)
    )
    NAMES.patch_with_mpq(path, metadata, recover)
    NAMES.patch_hm3w(path, title)
    actual_w3f, actual_hm3w = NAMES.read_campaign_title(path)
    if actual_w3f != title or (
        actual_hm3w is not None and actual_hm3w != title
    ):
        raise SystemExit("campaign title verification failed")
    archive = W.MPQArchive(str(path))
    try:
        OFFICIAL.verify_w3f_bytes(
            archive.read_file("war3campaign.w3f") or b""
        )
    finally:
        archive.close()
    return title


def build(args: argparse.Namespace) -> int:
    source = args.campaign.resolve()
    preserve_source = (args.preserve_source or source).resolve()
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
    extra_objects: dict[str, list[Path]] = {}
    for spec in args.extra_object:
        extension, separator, source_text = spec.partition("=")
        if not separator or extension not in ("w3a", "w3t", "w3h", "w3u"):
            raise SystemExit(
                "--extra-object must be w3a=PATH, w3t=PATH, w3h=PATH, "
                "or w3u=PATH"
            )
        path = Path(source_text).resolve()
        if not path.is_file():
            raise SystemExit("extra object file missing: " + str(path))
        extra_objects.setdefault(extension, []).append(path)
    extra_scripts: dict[str, Path] = {}
    if args.extra_script_manifest:
        raw_manifest = json.loads(
            args.extra_script_manifest.resolve().read_text(
                encoding="utf-8"
            )
        )
        if not isinstance(raw_manifest, dict):
            raise SystemExit("extra JASS script manifest must be an object")
        for key, value in raw_manifest.items():
            script_dir = Path(str(value)).resolve()
            if not all(
                (script_dir / name).is_file()
                for name in ("g.j", "f.j", "m.j")
            ):
                raise SystemExit(
                    "extra JASS script directory is incomplete: "
                    + str(script_dir)
                )
            extra_scripts[CAMP.normalize_chapter_name(str(key))] = script_dir

    if not source.is_file():
        raise SystemExit("campaign not found: " + str(source))
    if not preserve_source.is_file():
        raise SystemExit(
            "preserve source not found: " + str(preserve_source)
        )
    config_dir = Path(
        __import__("os").environ.get("ALAS_UNITIDS_DIR", str(HERE))
    )
    config_path = config_dir / (config + ".py")
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

    chapters, skipped_cinematics = CAMP.select_campaign_chapters(
        base,
        preserve_source,
        include_cinematic=args.include_cinematic_chapters,
    )
    chapter_keys = {
        CAMP.chapter_key(base, chapter): chapter
        for chapter in chapters
    }
    if not chapters:
        raise SystemExit(
            "no ALAS target chapters remain after cinematic filtering"
        )
    if skipped_cinematics:
        print("skipped cinematic chapters:", flush=True)
        for key, reason in skipped_cinematics.items():
            print("  %s (%s)" % (key, reason), flush=True)
    if extra_scripts:
        missing_scripts = (
            set(chapter_keys)
            - set(extra_scripts)
        )
        if "*" in extra_scripts:
            missing_scripts = set()
        if missing_scripts:
            raise SystemExit(
                "extra JASS script manifest is missing chapters: "
                + ", ".join(sorted(missing_scripts))
            )
    campaign_talent_cache = any(
        has_campaign_talent_cache(script_dir)
        for script_dir in extra_scripts.values()
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
    campaign_loot = None
    if args.campaign_loot_manifest:
        campaign_loot = WILD_DROPS.load_campaign_manifest(
            args.campaign_loot_manifest.resolve()
        )
        missing_profiles = (
            set(chapter_keys)
            - {
                CAMP.normalize_chapter_name(profile.chapter)
                for profile in campaign_loot.profiles
            }
        )
        if missing_profiles:
            raise SystemExit(
                "campaign loot profiles missing chapters: "
                + ", ".join(sorted(missing_profiles))
            )
        assets.extend(campaign_loot.assets)
    loot_asset_names = (
        {
            internal.casefold()
            for _local, internal in campaign_loot.assets
        }
        if campaign_loot is not None
        else set()
    )
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
        if extension in extra_objects:
            inputs.extend(extra_objects[extension])
        if (
            campaign_loot is not None
            and extension in campaign_loot.object_sources
        ):
            inputs.append(campaign_loot.object_sources[extension])
        combined = combined_dir / ("combined." + extension)
        M.merge_files(
            str(combined), [str(path) for path in inputs]
        )
        combined_sources[extension] = combined
    for index, chapter in enumerate(chapters, 1):
        chapter_key = CAMP.chapter_key(base, chapter)
        print("\n[%d/%d] one-pass ALAS injection: %s"
              % (index, len(chapters), chapter_key), flush=True)
        object_payloads = merge_chapter_objects(
            chapter, work, combined_sources
        )
        ITEM.configure_equipment_ownership(
            work / "_obj_final" / chapter.stem, item_active
        )
        archive = W.MPQArchive(str(chapter))
        try:
            present = {}
            for _path, internal in assets:
                data = archive.read_file(internal)
                if data:
                    present[internal.casefold()] = data
        finally:
            archive.close()

        chapter_loot = (
            campaign_loot.profile_for(chapter_key)
            if campaign_loot is not None
            else None
        )
        inject = [PY, HERE / "inject_native.py", chapter, "--no-backup"]
        chapter_scripts = list(script_dirs)
        if chapter_loot is not None:
            chapter_scripts.append(chapter_loot.script_dir)
        extra_script = extra_scripts.get(
            chapter_key,
            extra_scripts.get("*"),
        )
        if extra_script is not None:
            chapter_scripts.append(extra_script)
        for script_dir in chapter_scripts:
            inject += ["--script", script_dir]
        script_internal, source_script = chapter_script(chapter)
        base_script = patch_known_source_script(
            chapter.name, source_script
        )
        talent_cache_counts = None
        if campaign_talent_cache:
            base_script, talent_cache_counts = (
                patch_campaign_talent_cache(base_script)
            )
            expected_store = source_script.count(b"StoreUnitBJ")
            expected_restore = sum(
                source_script.count(name)
                for name in (
                    b"RestoreUnitLocFacingAngleBJ",
                    b"RestoreUnitLocFacingPointBJ",
                    b"RestoreUnitBJ",
                )
            )
            expected_save = source_script.count(b"SaveGameCacheBJ")
            if (
                expected_store != talent_cache_counts["snapshot_store"]
                or expected_store != talent_cache_counts["audit_store"]
                or expected_restore
                != talent_cache_counts["restore_probe"]
                or expected_save != talent_cache_counts["save"]
            ):
                raise SystemExit(
                    "%s campaign talent cache calls were not patched "
                    "exactly: expected snapshot/store-probe/save %d/%d/%d, "
                    "got %d/%d/%d; audit store/probe %d/%d"
                    % (
                        chapter.name,
                        expected_store,
                        expected_restore,
                        expected_save,
                        talent_cache_counts["snapshot_store"],
                        talent_cache_counts["restore_probe"],
                        talent_cache_counts["save"],
                        talent_cache_counts["audit_store"],
                        talent_cache_counts["restore_probe"],
                    )
                )
            if expected_store or expected_restore:
                print(
                    "native campaign state %s: snapshot-store=%d restore-probe=%d"
                    % (
                        chapter.name,
                        talent_cache_counts["snapshot_store"],
                        talent_cache_counts["restore_probe"],
                    ),
                    flush=True,
                )
        if args.suppress_source_backpack_auto:
            source_call = (
                b"call UnitAddItemByIdSwapped('B30B', u)"
            )
            call_count = base_script.count(source_call)
            if call_count > 1:
                raise SystemExit(
                    "%s has %d source B30B autogrant calls"
                    % (chapter.name, call_count)
                )
            if call_count == 1:
                base_script = base_script.replace(source_call, b"", 1)
        if base_script != source_script:
            base_script_path = (
                work / "_base_patched" / (chapter.stem + ".j")
            )
            base_script_path.parent.mkdir(parents=True, exist_ok=True)
            base_script_path.write_bytes(base_script)
            inject += [
                "--base-script",
                str(base_script_path),
                "--script-internal",
                script_internal,
            ]
        for local, internal in object_payloads:
            inject += ["--file", "%s=%s" % (local, internal)]
        for local, internal in assets:
            if internal.lower() in present:
                if (
                    internal.casefold() in loot_asset_names
                    and present[internal.casefold()] != local.read_bytes()
                ):
                    print(
                        "%s preserves chapter-local asset variant: %s"
                        % (chapter.name, internal),
                        flush=True,
                    )
                continue
            inject += [
                "--file", "%s=%s" % (local, internal),
                "--store", internal,
            ]
        run(inject)
        validate_chapter(
            chapter,
            assets,
            config_module,
            campaign_loot=chapter_loot is not None,
            talent_cache_counts=talent_cache_counts,
        )
        validate_extra_script(chapter, extra_script)

    CAMP.restore_campaign_chapters(
        preserve_source,
        base,
        set(skipped_cinematics),
    )
    run([PY, HERE / "port_wings_campaign.py", "pack", source,
         "--work", work, "--out", output])
    title = patch_title(output, work / "recover" / "alas_campaign_names")
    CAMP.verify_campaign_chapters(
        preserve_source,
        output,
        set(skipped_cinematics),
    )
    digest = hashlib.sha256(output.read_bytes()).hexdigest().upper()
    print("injected chapters:", len(chapters))
    print("skipped cinematic chapters:", len(skipped_cinematics))
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
    parser.add_argument(
        "--campaign-loot-manifest",
        type=Path,
    )
    parser.add_argument("--extra-object", action="append", default=[])
    parser.add_argument("--extra-script-manifest", type=Path)
    parser.add_argument("--preserve-source", type=Path)
    parser.add_argument(
        "--include-cinematic-chapters",
        action="store_true",
    )
    parser.add_argument(
        "--suppress-source-backpack-auto",
        action="store_true",
    )
    return build(parser.parse_args())


if __name__ == "__main__":
    raise SystemExit(main())
