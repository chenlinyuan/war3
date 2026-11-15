# -*- coding: utf-8 -*-
"""Repair KK/KKWE campaign chapters for standalone play.

The tool intentionally stops after single-player compatibility and known
author-side game blockers.  It does not add items, wings, heroes, or other
ALAS content.  Its `.w3n` output is meant to be used as the clean source for
the ALAS offline builder.

Usage:
    python campaign_singleplayer.py <campaign.w3n|directory>
    python campaign_singleplayer.py <directory> --output-dir <dir>
    python campaign_singleplayer.py <campaign.w3n> --extract-only
    python campaign_singleplayer.py <campaign.w3n> --remove-backpack-switch
    python campaign_singleplayer.py <campaign.w3n> --target classic
    python campaign_singleplayer.py <campaign.w3n> --target reforged
    python campaign_singleplayer.py <directory> --campaign 194213

For every campaign the tool:
  1. extracts every chapter from the clean source archive;
  2. recovers `kkmap.jc` to JASS with Devo's Map Doctor when necessary;
  3. replaces KK/platform native declarations with in-place stubs;
  4. applies the maintained set of anti-softlock/script fixes;
  5. optionally removes the campaign-specific authored backpack-switch ability;
  6. runs pjass and writes the repaired chapter back to its archive;
  7. clears the chapter MPQ hash-table platform flags;
  8. repacks chapters as uncompressed entries and validates the result with
     the game's Storm.dll (static archive validation only).

The game/editor is never launched.
"""
from __future__ import annotations

import argparse
import contextlib
import hashlib
import io
import json
import os
import re
import shutil
import struct
import subprocess
import sys
import tempfile
import time
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any


HERE = Path(__file__).resolve().parent
BASE = HERE.parents[1]
DOCTOR_DIR = BASE / "tools" / "_devos-map-doctor" / "devos-map-doctor-main"
DOCTOR = DOCTOR_DIR / "DevosMapDoctor.py"
PJASS_DIR = BASE / "tools" / "war3-tools" / "偶久改图一条龙工具包" / "tools" / "JassCraft"
REF124 = DOCTOR_DIR / "doctor" / "ref" / "1.24"
SFMPQ_PROBE = HERE / "sfmpq_probe.ps1"
SFMPQ_SUBARCHIVE = HERE / "sfmpq_subarchive.ps1"
PS32 = Path(os.environ.get("SystemRoot", r"C:\Windows")) / "SysWOW64" / "WindowsPowerShell" / "v1.0" / "powershell.exe"

sys.path.insert(0, str(HERE))
sys.path.insert(0, str(DOCTOR_DIR))

import war3mpq as W  # noqa: E402
import mpq_patch as MP  # noqa: E402
import merge_w3obj as MO  # noqa: E402
import apply_reforged_migration as RM  # noqa: E402
import _patch_backpack_switch as BACKPACK  # noqa: E402
import fix_campaign_object_icons as DISABLED_ICONS  # noqa: E402
import _patch_anticheat_markers as AC  # noqa: E402
import _campaign_profiles as PROFILES  # noqa: E402
import _campaign_patch_registry as CAMPAIGN_PATCHES  # noqa: E402
import _patch_chat_registration as CR  # noqa: E402
import _patch_command_mall_guards as CM  # noqa: E402
import _gate_scan as GS  # noqa: E402
import _neutralize_ends as NE  # noqa: E402
import _patch_cache_flags as CF  # noqa: E402
import _patch_cache_handoff as CH  # noqa: E402
import _patch_chat_gate as CG  # noqa: E402
import _patch_cinematics as PC  # noqa: E402
import _patch_critical_props as CP  # noqa: E402
import _patch_drops as PD  # noqa: E402
import _patch_final_cinematic_cleanup as FC  # noqa: E402
import _patch_hero_death as HD  # noqa: E402
import _patch_mall_wipe as MW  # noqa: E402
import _patch_mall_cleanup as MC  # noqa: E402
import _patch_pet_delete as PP  # noqa: E402
import _patch_region_drain as RD  # noqa: E402
import _patch_restore_guards as RG  # noqa: E402
import _patch_sentinel_exits as SE  # noqa: E402
import _patch_unlock as UK  # noqa: E402
import _stub_inplace as SI  # noqa: E402
import fix_hash_platform as HP  # noqa: E402
import jass_gate  # noqa: E402
from doctor.data import campaign_info  # noqa: E402
from doctor.viewers import map_card  # noqa: E402


MAP_SUFFIXES = (".w3x", ".w3m")
SCRIPT_NAMES = ("war3map.j", "scripts\\war3map.j", "Scripts\\war3map.j")
CAMPAIGN_OBJECT_FILES = (
    ("war3campaign.w3a", "war3map.w3a"),
    ("war3campaign.w3t", "war3map.w3t"),
    ("war3campaign.w3u", "war3map.w3u"),
    ("war3campaign.w3h", "war3map.w3h"),
    ("war3campaign.w3d", "war3map.w3d"),
    ("war3campaign.w3b", "war3map.w3b"),
    ("war3campaign.w3q", "war3map.w3q"),
)
TITLE_SUFFIX = "（单机修复版）"
CLASSIC_TITLE_SUFFIX = "（单机修复版·经典版）"
TARGET_CLASSIC = "classic"
TARGET_REFORGED = "reforged"
TARGET_CHOICES = (TARGET_CLASSIC, TARGET_REFORGED)
PLATFORM_PREFIXES = ("Dz", "EX", "RequestExtra", "LBK", "Blz", "JAPI")
INVALID_FILENAME = re.compile(r'[<>:"/\\|?*\x00-\x1f]')
COLOR_TAG = re.compile(r"\|c[0-9a-fA-F]{8}|\|r", re.I)


class BuildError(RuntimeError):
    pass


@dataclass
class CampaignIdentity:
    title: str
    author: str
    description: str
    hm3w_title: str
    chapters: list[str]
    source_sha256: str


@dataclass
class BuildResult:
    source: Path
    output: Path | None = None
    work: Path | None = None
    target: str = TARGET_REFORGED
    ok: bool = False
    error: str = ""
    chapters: list[dict[str, Any]] = field(default_factory=list)
    validation: dict[str, Any] = field(default_factory=dict)


def safe_title(value: str) -> str:
    value = COLOR_TAG.sub("", value).strip()
    value = INVALID_FILENAME.sub("_", value)
    value = re.sub(r"\s+", " ", value).strip(" .")
    return value or "campaign"


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(4 * 1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def campaign_output_title(title: str, target: str) -> str:
    if target == TARGET_CLASSIC:
        return title + CLASSIC_TITLE_SUFFIX
    if target == TARGET_REFORGED:
        return title + TITLE_SUFFIX
    raise BuildError("unsupported export target: " + target)


def prepare_campaign_map_info(
    data: bytes,
    label: str,
    target: str,
) -> tuple[bytes, str]:
    """Return map-info bytes appropriate for the selected game generation."""
    if target == TARGET_CLASSIC:
        if not data:
            raise BuildError(label + ": missing war3map.w3i")
        return data, "preserved source map-info for classic"
    if target == TARGET_REFORGED:
        return RM.migrated_map_info(data, label)
    raise BuildError("unsupported export target: " + target)


def read_hm3w(path: Path) -> str:
    with path.open("rb") as stream:
        block = stream.read(512)
    if block[:4] != b"HM3W":
        return ""
    end = block.find(b"\0", 8)
    if end < 0:
        return ""
    return block[8:end].decode("utf-8", "replace")


def split_wts(data: bytes) -> dict[int, str]:
    text = data.decode("utf-8-sig", "replace")
    pattern = re.compile(
        r"STRING\s+(\d+)\s*\r?\n(?:[^\r\n{}]*\r?\n)*"
        r"\{(?:\r?\n)?(.*?)\r?\n\}",
        re.S,
    )
    return {
        int(match.group(1)): match.group(2).strip()
        for match in pattern.finditer(text)
    }


def chapter_strings(path: Path) -> dict[int, str]:
    archive = W.MPQArchive(str(path))
    try:
        data = archive.read_file("war3map.wts") or b""
    finally:
        archive.close()
    return split_wts(data)


def campaign_identity(path: Path) -> CampaignIdentity:
    archive = W.MPQArchive(str(path))
    try:
        w3f = archive.read_file("war3campaign.w3f") or b""
        wts = archive.read_file("war3campaign.wts") or b""
        chapters = sorted(
            name for name in archive.files()
            if name.lower().endswith(MAP_SUFFIXES)
        )
    finally:
        archive.close()
    if not w3f:
        raise BuildError("war3campaign.w3f is missing")
    try:
        parsed = campaign_info.parse(w3f)
    except Exception as exc:
        raise BuildError("cannot parse war3campaign.w3f: %s" % exc) from exc
    strings = split_wts(wts)

    def resolve(raw: bytes) -> str:
        value = raw.decode("utf-8", "replace")
        match = re.fullmatch(r"\s*TRIGSTR_0*(\d+)\s*", value, re.I)
        if match:
            return strings.get(int(match.group(1)), value)
        return value

    title = safe_title(resolve(parsed["name"]))
    author = safe_title(resolve(parsed["author"]))
    description = COLOR_TAG.sub("", resolve(parsed["description"])).strip()
    if not chapters:
        raise BuildError("the campaign contains no .w3x/.w3m chapters")
    return CampaignIdentity(
        title=title,
        author=author,
        description=description,
        hm3w_title=read_hm3w(path),
        chapters=chapters,
        source_sha256=sha256_file(path),
    )


def discover_campaigns(source: Path) -> list[Path]:
    if source.is_file():
        if source.suffix.lower() != ".w3n":
            raise BuildError("source must be a .w3n file or a directory: %s" % source)
        return [source.resolve()]
    if not source.is_dir():
        raise BuildError("source does not exist: %s" % source)
    campaigns = sorted(
        path.resolve()
        for path in source.iterdir()
        if path.is_file() and path.suffix.lower() == ".w3n"
    )
    if not campaigns:
        raise BuildError("no .w3n campaigns found in %s" % source)
    return campaigns


def first_script_name(archive: W.MPQArchive) -> str:
    for name in SCRIPT_NAMES:
        if archive.read_file(name) is not None:
            return name
    return SCRIPT_NAMES[0]


def doctor_editor(path: Path, scratch: Path) -> tuple[Path, str]:
    scratch.mkdir(parents=True, exist_ok=True)
    copied = scratch / path.name
    shutil.copy2(path, copied)
    result = subprocess.run(
        [sys.executable, str(DOCTOR), "--cli", "editor", str(copied), "--quiet"],
        capture_output=True,
    )
    output = (result.stdout + result.stderr).decode("utf-8", "replace")
    stem, suffix = copied.stem, copied.suffix
    candidates = [scratch / (stem + "_editor" + suffix)]
    candidates.extend(sorted(scratch.glob(stem + "_editor.*")))
    edited = next((candidate for candidate in candidates if candidate.is_file()), None)
    if result.returncode != 0 or edited is None:
        tail = "\n".join(output.strip().splitlines()[-8:])
        raise BuildError("Map Doctor could not recover the script:\n" + tail)
    return edited, output


def recover_chapter_script(raw_map: Path, scratch: Path) -> tuple[bytes, str, str]:
    archive = W.MPQArchive(str(raw_map))
    try:
        script_name = first_script_name(archive)
        script = archive.read_file(script_name) or b""
        bytecode = archive.read_file("kkmap.jc")
    finally:
        archive.close()
    if script and len(script) > 2000 and bytecode is None:
        return script, script_name, "original-jass"

    edited, _log = doctor_editor(raw_map, scratch)
    archive = W.MPQArchive(str(edited))
    try:
        recovered = archive.read_file("war3map.j")
        if not recovered:
            recovered = archive.read_file("scripts\\war3map.j")
        if not recovered:
            recovered = archive.read_file("Scripts\\war3map.j")
    finally:
        archive.close()
    if not recovered or len(recovered) < 200:
        raise BuildError("Map Doctor produced no usable JASS script")
    return recovered, "war3map.j", "doctor-decompile"


def pjass_check(path: Path, script: bytes) -> tuple[bool, str, list[str]]:
    tool = jass_gate._tool()
    if not tool:
        raise BuildError("pjass.exe was not found")
    ref = jass_gate._ref(tool, script)
    try:
        rc, kinds, samples = jass_gate._diagnostics(str(path), tool, ref)
    except Exception as exc:
        raise BuildError("pjass could not run: %s" % exc) from exc
    sample_lines = [samples[key] for key in sorted(samples)]
    ok = rc == 0
    note = "pjass rc=%d error-kinds=%d" % (rc, len(kinds))
    return ok, note, sample_lines


def platform_entry_stats(path: Path) -> dict[str, Any]:
    archive = W.MPQArchive(str(path))
    try:
        position = archive.header_offset + archive.hash_table_pos
        size = archive.hash_table_size
        archive.file.seek(position)
        raw = archive.file.read(size * 16)
    finally:
        archive.close()
    if len(raw) != size * 16:
        raise BuildError("short hash table read: %s" % path)
    key = W._hash_string("(hash table)", W.MPQ_HASH_FILE_KEY)
    plain = W._decrypt(raw, key)
    fields: dict[str, int] = {}
    nonzero = 0
    for index in range(size):
        offset = index * 16
        if struct.unpack_from("<I", plain, offset)[0] in (
            W.MPQ_HASH_ENTRY_EMPTY,
            W.MPQ_HASH_ENTRY_DELETED,
        ):
            continue
        combo = struct.unpack_from("<I", plain, offset + 8)[0]
        locale, platform = combo & 0xFFFF, combo >> 16
        label = "%d:%d" % (locale, platform)
        fields[label] = fields.get(label, 0) + 1
        if combo != 0:
            nonzero += 1
    return {"nonzero": nonzero, "fields": fields}


def clear_platform_flags(path: Path) -> int:
    stream = io.StringIO()
    with contextlib.redirect_stdout(stream):
        changed = HP.patch(str(path))
    return int(changed or 0)


def add_attributes_patch(patches: list[tuple[str, bytes]], archive_path: Path) -> None:
    archive = W.MPQArchive(str(archive_path))
    try:
        attributes = archive.read_file("(attributes)")
    finally:
        archive.close()
    if attributes is not None and len(attributes) >= 8:
        _version, flags = struct.unpack_from("<II", attributes)
        if flags and not any(name.lower() == "(attributes)" for name, _data in patches):
            patches.append(("(attributes)", struct.pack("<II", 100, 0)))


def patch_chapter_script(
    text: str,
    chapter: str,
    strings: dict[int, str] | None = None,
    profile_mall_false: set[str] | None = None,
    profile_mall_true: set[str] | None = None,
    profile_mall_default_true: bool = True,
    profile_name: str | None = None,
    remove_ability_ids: set[str] | None = None,
) -> tuple[str, dict[str, Any]]:
    gates = [gate for gate in GS.analyze_text(text) if gate["keys"]]
    mall_false: set[str] = set()
    auto_mall_true: set[str] = set()
    for gate in gates:
        for key, operation in gate["keys"]:
            if operation.startswith("=="):
                mall_false.add(key)
            else:
                auto_mall_true.add(key)

    if profile_mall_default_true:
        mall_true = set(auto_mall_true)
        mall_true |= set(profile_mall_true or ())
        mall_false -= mall_true
    else:
        mall_true = set(profile_mall_true or ())
        # The legacy gate scanner is heuristic.  An explicit campaign
        # whitelist is authoritative for positive keys, while explicit and
        # automatically detected negative markers remain blacklisted.
        mall_false -= mall_true
    mall_false |= set(profile_mall_false or ())
    overlap = mall_false & mall_true
    if overlap:
        raise BuildError(
            "%s: mall keys both enabled and disabled: %s"
            % (chapter, sorted(overlap))
        )

    scan_after_pet, _probe = PP.patch(text)
    risky_items, risky_keys = GS.risky_item_keys(scan_after_pet)
    mall_false |= risky_keys
    mall_false |= GS.keys_of_triggers_containing(text, "'I67N'")
    sealed_vars, poison_keys = GS.cache_poison_keys(text)
    mall_false |= poison_keys
    weakness_keys = GS.weakness_perk_keys(text)
    mall_false |= set(weakness_keys)
    anti_cheat = AC.classify(text, strings or {})
    mall_false |= set(anti_cheat["mall_false_keys"])

    patched, stubs, unknown_natives = SI.S.stub_block(
        text,
        PLATFORM_PREFIXES,
        SI.S.DEFAULT_LEVEL,
        True,
        in_place=True,
        map_test=True,
        mall_false=mall_false,
        mall_true=mall_true,
        mall_default=profile_mall_default_true,
    )
    patched, map_test_count = SI.force_map_test(patched)
    patched, sentinel_stats = SE.patch(patched)
    patched, chat_registration_fixes = CR.patch(patched)
    patched, command_mall_fixes = CM.patch(patched)
    patched, pet_delete_count = PP.patch(patched)
    patched, cache_handoff_records = CH.patch(patched)
    if poison_keys:
        patched, cache_reads, cache_writes, cache_typo = CF.patch(patched)
    else:
        cache_reads = cache_writes = cache_typo = 0
    patched, hero_death_count = HD.patch(patched)
    patched, mall_cleanup_records = MC.patch(patched)
    patched, mall_wipe_count = MW.patch(patched)
    patched, chat_guards, quest_guards = CG.patch(patched)
    patched, critical_prop_count = CP.patch(patched)
    patched, region_drain_count = RD.patch(patched)
    patched, unlock_count = UK.patch(patched)
    patched, platform_ends = NE.neutralize(patched)
    patched, cinematic_notes = PC.patch(patched)
    patched, drop_change_owner = PD.patch(patched)
    patched, final_cinematic_fixes = FC.patch(patched)
    patched, restore_guard_stats = RG.patch(patched)
    backpack_switch_records: list[dict[str, object]] = []
    if remove_ability_ids:
        patched, backpack_switch_records = BACKPACK.patch_script(
            patched,
            set(remove_ability_ids),
        )
        remaining_backpack_switch = BACKPACK.verify_script(
            patched,
            set(remove_ability_ids),
        )
        if remaining_backpack_switch:
            raise BuildError(
                "%s: backpack switch script remains: %s"
                % (chapter, remaining_backpack_switch)
            )
    patched, campaign_patch_stats = CAMPAIGN_PATCHES.apply(
        profile_name,
        patched,
        chapter,
    )

    remaining_platform_ends = NE.neutralize(patched)[1]
    if remaining_platform_ends:
        raise BuildError(
            "%s: platform-gated end-game calls remain after patching: %s"
            % (chapter, remaining_platform_ends[:3])
        )
    remaining_sentinels = SE.verify(
        patched, sentinel_stats["sentinel_exits"]
    )
    if remaining_sentinels:
        raise BuildError(
            "%s: sentinel exit branches remain after patching: %s"
            % (chapter, remaining_sentinels)
        )
    remaining_command_mall = CM.verify(patched)
    if remaining_command_mall:
        raise BuildError(
            "%s: command conditions still depend on mall keys: %s"
            % (chapter, remaining_command_mall)
        )
    remaining_mall_cleanup = MC.verify(patched, mall_cleanup_records)
    if remaining_mall_cleanup:
        raise BuildError(
            "%s: mall entitlement cleanup still active: %s"
            % (chapter, remaining_mall_cleanup)
        )
    remaining_cache_handoffs = CH.verify(patched, cache_handoff_records)
    if remaining_cache_handoffs:
        raise BuildError(
            "%s: placeholder cache handoffs remain active: %s"
            % (chapter, remaining_cache_handoffs)
        )
    restore_guard_problems = RG.verify(patched)
    if restore_guard_stats["restore_guard_reason"] == "inserted":
        if restore_guard_problems:
            raise BuildError(
                "%s: restored-unit guard failed: %s"
                % (chapter, restore_guard_problems)
            )
    remaining_final_cinematic = FC.verify(patched, final_cinematic_fixes)
    if remaining_final_cinematic:
        raise BuildError(
            "%s: final cinematic cleanup missing: %s"
            % (chapter, remaining_final_cinematic)
        )
    remaining_campaign_patch = CAMPAIGN_PATCHES.verify(
        profile_name,
        patched,
        campaign_patch_stats,
    )
    if remaining_campaign_patch:
        raise BuildError(
            "%s: campaign-specific repairs still active: %s"
            % (chapter, remaining_campaign_patch)
        )
    if "[IBDIAG]" in patched:
        raise BuildError("%s: diagnostic instrumentation leaked into final script" % chapter)
    remaining_natives = [
        match.group("name")
        for match in SI.S.NATIVE_RE.finditer(patched)
        if match.group("name").startswith(PLATFORM_PREFIXES)
    ]
    if remaining_natives:
        raise BuildError("%s: platform native declarations remain: %s" % (chapter, remaining_natives[:5]))

    stats = {
        "gate_count": len(gates),
        "mall_false": sorted(mall_false),
        "mall_true": sorted(mall_true),
        "mall_default_true": profile_mall_default_true,
        "risky_items": risky_items,
        "risky_keys": sorted(risky_keys),
        "cache_poison_vars": sealed_vars,
        "cache_poison_keys": sorted(poison_keys),
        "weakness_keys": weakness_keys,
        "anti_cheat_strings": anti_cheat["anti_cheat_strings"],
        "anti_cheat_mall_keys": anti_cheat["anti_cheat_mall_keys"],
        "progress_marker_keys": anti_cheat["progress_marker_keys"],
        "auto_mall_false_keys": anti_cheat["mall_false_keys"],
        "auto_mall_false_count": anti_cheat["mall_false_count"],
        "profile_mall_false": sorted(profile_mall_false or ()),
        "native_stubs": len(stubs),
        "unknown_native_count": len(set(unknown_natives)),
        "map_test_wrappers": map_test_count,
        "chat_registration_fixes": chat_registration_fixes,
        "chat_registration_fix_count": len(chat_registration_fixes),
        "command_mall_fixes": command_mall_fixes,
        "mall_cleanup_blocks": len(mall_cleanup_records),
        "mall_cleanup_keys": sorted(
            {str(record["key"]) for record in mall_cleanup_records}
        ),
        "sentinel_exit_count": sentinel_stats["sentinel_exit_count"],
        "sentinel_exits": sentinel_stats["sentinel_exits"],
        "pet_delete_blocks": pet_delete_count,
        "placeholder_cache_handoffs": len(cache_handoff_records),
        "placeholder_cache_handoff_records": cache_handoff_records,
        "restore_guards": restore_guard_stats["restore_guards"],
        "restore_guard_reason": restore_guard_stats["restore_guard_reason"],
        "cross_chapter_cache_reads_zeroed": cache_reads,
        "cross_chapter_cache_writes_cut": cache_writes,
        "cache_name_typos_fixed": cache_typo,
        "pet_death_false_defeats": hero_death_count,
        "mall_welfare_wipes": mall_wipe_count,
        "go_quest_null_guards": quest_guards,
        "critical_props": critical_prop_count,
        "region_drains_scoped": region_drain_count,
        "quest_unlock_helpers": unlock_count,
        "platform_end_calls": len(platform_ends),
        "cinematic_fixes": len(cinematic_notes),
        "final_cinematic_cleanup": len(final_cinematic_fixes),
        "final_cinematic_functions": sorted(
            {str(record["function"]) for record in final_cinematic_fixes}
        ),
        "campaign_patch_name": campaign_patch_stats.get("campaign_patch"),
        "campaign_patch_count": campaign_patch_stats.get("campaign_patch_count", 0),
        "campaign_patch_records": campaign_patch_stats.get("campaign_patch_records", []),
        "campaign_patch_static_audit": campaign_patch_stats.get("static_audit"),
        "license_cleanup_count": campaign_patch_stats.get("license_cleanup_count", 0),
        "extra_pet_food_guard_count": campaign_patch_stats.get(
            "extra_pet_food_guard_count", 0
        ),
        "main_hero_death_count": campaign_patch_stats.get("main_hero_death_count", 0),
        "backpack_switch_records": backpack_switch_records,
        "backpack_switch_removals": len(backpack_switch_records),
        "drop_change_owner_removed": drop_change_owner,
    }
    return patched, stats


def materialized_campaign_objects(
    outer: W.MPQArchive,
    raw_map: Path,
    scratch: Path,
    profile_name: str | None,
    remove_ability_ids: set[str] | None = None,
    target: str = TARGET_REFORGED,
) -> tuple[list[tuple[str, bytes]], list[dict[str, object]]]:
    """Merge campaign object data into a chapter map for standalone loading.

    Reforged custom campaigns do not reliably overlay ``war3campaign.w3*`` when
    opening the chapter package.  The working standalone builds therefore carry
    the campaign object tables inside each chapter.  Local chapter entries are
    listed first so they retain priority over campaign-wide overrides.
    """
    archive = W.MPQArchive(str(raw_map))
    patches: list[tuple[str, bytes]] = []
    records: list[dict[str, object]] = []
    scratch.mkdir(parents=True, exist_ok=True)
    campaign_strings = split_wts(
        outer.read_file("war3campaign.wts") or b""
    )
    try:
        map_info = archive.read_file("war3map.w3i") or b""
        prepared_info, migration_status = prepare_campaign_map_info(
            map_info,
            str(raw_map),
            target,
        )
        if prepared_info != map_info:
            patches.append(("war3map.w3i", prepared_info))
        records.append(
            {
                "source": "war3map.w3i",
                "target": "war3map.w3i",
                "origin": (
                    "classic-source"
                    if target == TARGET_CLASSIC
                    else "reforged-migration"
                ),
                "status": migration_status,
                "changed": prepared_info != map_info,
                "bytes": len(prepared_info),
            }
        )
        for campaign_name, map_name in CAMPAIGN_OBJECT_FILES:
            campaign_data = outer.read_file(campaign_name)
            if not campaign_data:
                continue
            local_data = archive.read_file(map_name)
            if local_data:
                local_path = scratch / ("local-" + map_name)
                campaign_path = scratch / ("campaign-" + map_name)
                merged_path = scratch / ("merged-" + map_name)
                local_path.write_bytes(local_data)
                campaign_path.write_bytes(campaign_data)
                try:
                    original_count, custom_count = MO.merge_files(
                        str(merged_path),
                        [str(local_path), str(campaign_path)],
                    )
                except Exception as exc:
                    raise BuildError(
                        "cannot merge %s into %s: %s"
                        % (campaign_name, map_name, exc)
                    ) from exc
                data = merged_path.read_bytes()
                origin = "merged"
            else:
                data = campaign_data
                original_count = custom_count = None
                origin = "campaign"
            unresolved_before = data.count(b"TRIGSTR_")
            try:
                data = MO.resolve_trigstr(
                    data,
                    map_name.rsplit(".", 1)[-1],
                    campaign_strings,
                )
            except Exception as exc:
                raise BuildError(
                    "cannot resolve strings in %s: %s" % (map_name, exc)
                ) from exc
            ability_ids = set(remove_ability_ids or ())
            object_switch_stats: dict[str, object] | None = None
            if ability_ids:
                data, object_switch_stats = BACKPACK.patch_objects(
                    data,
                    map_name.rsplit(".", 1)[-1],
                    ability_ids,
                )
                remaining = BACKPACK.verify_objects(
                    data,
                    map_name.rsplit(".", 1)[-1],
                    ability_ids,
                )
                if remaining:
                    raise BuildError(
                        "%s: backpack switch object remains: %s"
                        % (map_name, remaining[:5])
                    )
            data, campaign_object_records = CAMPAIGN_PATCHES.patch_objects(
                profile_name,
                data,
                map_name.rsplit(".", 1)[-1],
                str(raw_map.name),
            )
            remaining_campaign_objects = CAMPAIGN_PATCHES.verify_objects(
                profile_name,
                data,
                map_name.rsplit(".", 1)[-1],
                str(raw_map.name),
                campaign_object_records,
            )
            if remaining_campaign_objects:
                raise BuildError(
                    "%s: campaign object repair missing: %s"
                    % (map_name, remaining_campaign_objects[:5])
                )
            patches.append((map_name, data))
            records.append(
                {
                    "source": campaign_name,
                    "target": map_name,
                    "origin": origin,
                    "bytes": len(data),
                    "orig_count": original_count,
                    "custom_count": custom_count,
                    "trigstr_before": unresolved_before,
                    "trigstr_after": data.count(b"TRIGSTR_"),
                    "backpack_switch": object_switch_stats,
                    "campaign_object_repairs": campaign_object_records,
                }
            )
    finally:
        archive.close()
    return patches, records


def inject_script(
    raw_map: Path,
    script_name: str,
    script: bytes,
    output: Path,
    extra_patches: list[tuple[str, bytes]] | None = None,
) -> None:
    patches: list[tuple[str, bytes]] = [(script_name, script)]
    patches.extend(extra_patches or ())
    add_attributes_patch(patches, raw_map)
    MP.patch(
        str(raw_map),
        patches,
        out_path=str(output),
        backup=False,
        compact=False,
    )


def run_powershell(script: Path, arguments: list[str], timeout: int = 180) -> tuple[int, str]:
    if not PS32.is_file():
        return 127, "32-bit Windows PowerShell is unavailable"
    result = subprocess.run(
        [str(PS32), "-NoProfile", "-File", str(script), *arguments],
        capture_output=True,
        timeout=timeout,
    )
    return result.returncode, (result.stdout + result.stderr).decode("utf-8", "replace")


def storm_probe(path: Path, names: list[str]) -> dict[str, Any]:
    code, output = run_powershell(
        SFMPQ_PROBE,
        ["-Map", str(path), "-Names", ",".join(names)],
    )
    required_ok = all(
        re.search(r"%s\s+size=\d+\s+read=\d+\s+ok=True" % re.escape(name), output)
        for name in names
    )
    return {"ok": code == 0 and required_ok, "exit": code, "output": output}


def storm_subarchive_check(path: Path, chapters: list[str]) -> dict[str, Any]:
    code, output = run_powershell(
        SFMPQ_SUBARCHIVE,
        ["-Map", str(path), "-Names", ",".join(chapters)],
        timeout=max(180, len(chapters) * 3),
    )
    opened = len(re.findall(r"open-as-archive:\s+OK", output))
    return {
        "ok": code == 0 and opened == len(chapters),
        "exit": code,
        "opened": opened,
        "expected": len(chapters),
        "output": output,
    }


def doctor_check(path: Path, game: str) -> dict[str, Any]:
    command = [
        sys.executable, str(DOCTOR), "--cli", "check", str(path), "--json",
    ]
    if game:
        command.append("--game=" + game)
    result = subprocess.run(command, capture_output=True, timeout=120)
    output = (result.stdout + result.stderr).decode("utf-8", "replace")
    parsed: Any = None
    try:
        parsed = json.loads(result.stdout.decode("utf-8", "replace"))
    except Exception:
        pass
    return {
        "ok": result.returncode == 0,
        "exit": result.returncode,
        "version": game or "3.0",
        "verdict": parsed.get("verdict") if isinstance(parsed, dict) else None,
        "items": len(parsed.get("items") or []) if isinstance(parsed, dict) else None,
        "output_tail": output.strip().splitlines()[-12:],
    }


def patch_hm3w_title(path: Path, title: str) -> None:
    with path.open("r+b") as stream:
        block = bytearray(stream.read(512))
        if block[:4] != b"HM3W":
            raise BuildError("campaign has no HM3W header")
        end = block.find(b"\0", 8)
        if end < 0:
            raise BuildError("campaign HM3W title is not terminated")
        tail_end = max(
            (index + 1 for index, value in enumerate(block[end + 1:], end + 1) if value),
            default=end + 1,
        )
        tail = bytes(block[end + 1:tail_end])
        out = b"HM3W" + bytes(block[4:8]) + title.encode("utf-8") + b"\0" + tail
        if len(out) > 512:
            raise BuildError("HM3W title exceeds the 512-byte header")
        stream.seek(0)
        stream.write(out + b"\0" * (512 - len(out)))


def patch_w3f_title(data: bytes, title: str) -> bytes:
    """Replace the campaign name field with a literal UTF-8 title."""
    if len(data) < 12:
        raise BuildError("war3campaign.w3f is too short")
    end = data.find(b"\0", 12)
    if end < 0:
        raise BuildError("war3campaign.w3f name is not terminated")
    return data[:12] + title.encode("utf-8") + b"\0" + data[end + 1:]


def write_json(path: Path, data: Any) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary = path.with_suffix(path.suffix + ".tmp")
    temporary.write_text(json.dumps(data, ensure_ascii=False, indent=2), encoding="utf-8")
    os.replace(temporary, path)


def aggregate_manifests(work_root: Path) -> list[dict[str, Any]]:
    """Return the newest completed manifest for each source and export target."""
    newest: dict[tuple[str, str], tuple[float, dict[str, Any]]] = {}
    for manifest_path in work_root.glob("*/reports/manifest.json"):
        try:
            data = json.loads(manifest_path.read_text(encoding="utf-8"))
            source = str(Path(data["source"]).resolve())
            target = str(data.get("target") or TARGET_REFORGED)
        except Exception:
            continue
        modified = manifest_path.stat().st_mtime
        key = (source, target)
        if key not in newest or modified > newest[key][0]:
            validation = data.get("validation") or {}
            newest[key] = (
                modified,
                {
                    "source": source,
                    "target": target,
                    "output": data.get("output"),
                    "work": data.get("work"),
                    "status": data.get("status", "fail"),
                    "chapters": len(data.get("chapters") or []),
                    "output_sha256": validation.get("output_sha256"),
                    "output_bytes": validation.get("output_bytes"),
                    "storm_subarchives": validation.get("storm_subarchives"),
                },
            )
    return [
        newest[key][1]
        for key in sorted(newest)
    ]


def write_report(path: Path, result: BuildResult, identity: CampaignIdentity) -> None:
    lines = [
        "# " + identity.title,
        "",
        "- Export target: **%s**" % result.target,
        "- Source: `%s`" % result.source,
        "- Source SHA-256: `%s`" % identity.source_sha256,
        "- Author: %s" % (identity.author or "unknown"),
        "- Chapters: %d processed / %d total" % (len(result.chapters), len(identity.chapters)),
        "- Status: **%s**" % ("PASS" if result.ok else "FAIL"),
    ]
    if result.output:
        lines += ["- Output: `%s`" % result.output]
    if result.error:
        lines += ["", "## Error", "", "```text", result.error, "```"]
    lines += [
        "",
        "## Chapter patches",
        "",
        "| Chapter | Source | Script bytes | pjass | Stubs | Platform ends | Sentinel | "
        "Hero guard | Pet wipe | Mall wipe | Campaign patch | Cinematic |",
        "|---|---|---:|---|---:|---:|---:|---:|---:|---:|---:|---:|",
    ]
    for chapter in result.chapters:
        lines.append(
            "| {chapter} | {origin} | {script_bytes} | {pjass} | {native_stubs} | "
            "{platform_end_calls} | {sentinel_exit_count} | {pet_death_false_defeats} | "
            "{pet_delete_blocks} | {mall_welfare_wipes} | {campaign_patch_count} | "
            "{cinematic_fixes} |".format(
                **{
                    "chapter": chapter.get("chapter", ""),
                    "origin": chapter.get("origin", ""),
                    "script_bytes": chapter.get("script_bytes", 0),
                    "pjass": "PASS" if chapter.get("pjass_ok") else "FAIL",
                    "native_stubs": chapter.get("patch_stats", {}).get("native_stubs", 0),
                    "platform_end_calls": chapter.get("patch_stats", {}).get("platform_end_calls", 0),
                    "sentinel_exit_count": chapter.get("patch_stats", {}).get("sentinel_exit_count", 0),
                    "pet_death_false_defeats": chapter.get("patch_stats", {}).get(
                        "pet_death_false_defeats", 0
                    ),
                    "pet_delete_blocks": chapter.get("patch_stats", {}).get("pet_delete_blocks", 0),
                    "mall_welfare_wipes": chapter.get("patch_stats", {}).get("mall_welfare_wipes", 0),
                    "campaign_patch_count": chapter.get("patch_stats", {}).get(
                        "campaign_patch_count", 0
                    ),
                    "cinematic_fixes": chapter.get("patch_stats", {}).get("cinematic_fixes", 0),
                }
            )
        )
    if result.validation:
        lines += ["", "## Release validation", "", "```json",
                  json.dumps(result.validation, ensure_ascii=False, indent=2), "```"]
    path.write_text("\n".join(lines) + "\n", encoding="utf-8")


def build_campaign(
    source: Path,
    run_root: Path,
    output_dir: Path,
    extract_only: bool,
    overwrite: bool,
    doctor_checks: bool,
    storm_checks: bool,
    remove_backpack_switch: bool = False,
    add_disabled_icons: bool = True,
    chapter_filter: set[str] | None = None,
    limit: int = 0,
    target: str = TARGET_REFORGED,
) -> BuildResult:
    if target not in TARGET_CHOICES:
        raise BuildError("unsupported export target: " + target)
    source = source.resolve()
    identity = campaign_identity(source)
    profile = PROFILES.for_source(identity.source_sha256)
    profile_mall_false = set(profile.mall_false) if profile else set()
    profile_mall_true = set(profile.mall_true) if profile else set()
    profile_mall_default_true = profile.mall_default_true if profile else True
    container_adapter = (
        CAMPAIGN_PATCHES.container_pipeline(
            profile.name if profile else None
        )
        if target == TARGET_REFORGED
        else None
    )
    remove_ability_ids = (
        CAMPAIGN_PATCHES.backpack_switch_ids(
            profile.name if profile else None
        )
        if remove_backpack_switch
        else set()
    )
    if remove_backpack_switch and not remove_ability_ids:
        raise BuildError(
            "the selected campaign has no declared backpack-switch ability"
        )
    chapters = list(identity.chapters)
    if chapter_filter:
        chapters = [
            chapter for chapter in chapters
            if chapter.casefold() in chapter_filter
        ]
        if not chapters:
            raise BuildError("none of the requested chapters exist")
    if limit:
        chapters = chapters[:limit]
    output_name = campaign_output_title(identity.title, target) + ".w3n"
    final_output = output_dir / output_name
    result = BuildResult(
        source=source,
        output=None if extract_only else final_output,
        target=target,
    )
    if final_output.exists() and not overwrite and not extract_only:
        result.error = "output already exists; use --overwrite: %s" % final_output
        return result

    stamp = time.strftime("%Y%m%d-%H%M%S") + "-" + str(os.getpid())
    work = run_root / (safe_title(source.stem) + "-" + stamp)
    original_dir = work / "chapters" / "original"
    fixed_dir = work / "chapters" / "fixed"
    script_dir = work / "scripts"
    report_dir = work / "reports"
    for directory in (original_dir, fixed_dir, script_dir, report_dir):
        directory.mkdir(parents=True, exist_ok=True)
    result.work = work
    write_json(report_dir / "manifest.partial.json", {
        "source": str(source),
        "target": target,
        "identity": identity.__dict__,
        "status": "building",
    })

    outer = W.MPQArchive(str(source))
    container_outer = (
        W.MPQArchive(str(container_adapter[0]))
        if container_adapter is not None
        else None
    )
    fixed_chapters: dict[str, bytes] = {}
    disabled_icon_info = None
    if not extract_only and add_disabled_icons:
        disabled_icon_info = DISABLED_ICONS.build_patch(source)
    try:
        for index, chapter_name in enumerate(chapters, 1):
            print("[%s %d/%d] %s" % (source.name, index, len(chapters), chapter_name), flush=True)
            raw_bytes = outer.read_file(chapter_name)
            if not raw_bytes:
                raise BuildError("cannot extract chapter: " + chapter_name)
            raw_path = original_dir / chapter_name
            raw_path.parent.mkdir(parents=True, exist_ok=True)
            raw_path.write_bytes(raw_bytes)
            fixed_path = fixed_dir / chapter_name
            fixed_path.parent.mkdir(parents=True, exist_ok=True)

            with tempfile.TemporaryDirectory(prefix="doctor-", dir=work) as temporary:
                original_script, script_name, origin = recover_chapter_script(
                    raw_path, Path(temporary)
                )
            text = original_script.decode("utf-8", "surrogateescape")
            patched_text, stats = patch_chapter_script(
                text,
                chapter_name,
                chapter_strings(raw_path),
                profile_mall_false,
                profile_mall_true,
                profile_mall_default_true,
                profile.name if profile else None,
                remove_ability_ids,
            )
            patched_script = patched_text.encode("utf-8", "surrogateescape")
            script_path = script_dir / (Path(chapter_name).stem + ".j")
            script_path.write_bytes(patched_script)
            pjass_ok, pjass_note, pjass_samples = pjass_check(script_path, patched_script)
            if not pjass_ok:
                raise BuildError(
                    "%s: pjass failed: %s\n%s"
                    % (chapter_name, pjass_note, "\n".join(pjass_samples[:5]))
                )

            object_patches, object_records = materialized_campaign_objects(
                outer,
                raw_path,
                work / "object-merge" / Path(chapter_name).stem,
                profile.name if profile else None,
                remove_ability_ids,
                target,
            )
            inject_script(
                raw_path,
                script_name,
                patched_script,
                fixed_path,
                object_patches,
            )
            if container_outer is not None and container_adapter is not None:
                donor_map = container_outer.read_file(chapter_name)
                if not donor_map:
                    raise BuildError(
                        "%s: compatibility container has no chapter"
                        % chapter_name
                    )
                fixed_path.write_bytes(
                    container_adapter[1](
                        donor_map,
                        fixed_path.read_bytes(),
                    )
                )
            clear_platform_flags(fixed_path)
            platform = platform_entry_stats(fixed_path)
            if platform["nonzero"]:
                raise BuildError(
                    "%s: %d MPQ hash entries still have non-zero platform flags"
                    % (chapter_name, platform["nonzero"])
                )
            verify = W.MPQArchive(str(fixed_path))
            try:
                read_back = verify.read_file(script_name)
            finally:
                verify.close()
            if read_back != patched_script:
                raise BuildError("%s: repaired script read-back mismatch" % chapter_name)

            checks: dict[str, Any] = {}
            if doctor_checks:
                checks["doctor_1_27"] = doctor_check(fixed_path, "1.27")
                if target == TARGET_REFORGED:
                    checks["doctor_reforged"] = doctor_check(fixed_path, "")
                for name, check in checks.items():
                    if not check["ok"]:
                        raise BuildError("%s: %s failed: %s" % (chapter_name, name, check["output_tail"]))
            chapter_result = {
                "chapter": chapter_name,
                "origin": origin,
                "script_name": script_name,
                "script_bytes": len(patched_script),
                "script_sha256": hashlib.sha256(patched_script).hexdigest(),
                "pjass_ok": pjass_ok,
                "pjass_note": pjass_note,
                "platform_hash": platform,
                "materialized_campaign_objects": object_records,
                "patch_stats": stats,
                "doctor": checks,
            }
            result.chapters.append(chapter_result)
            fixed_chapters[chapter_name] = fixed_path.read_bytes()
            print(
                "    OK: %s, %d B, stubs=%d, platform-ends=%d, mall-wipes=%d"
                % (origin, len(patched_script), stats["native_stubs"],
                   stats["platform_end_calls"], stats["mall_welfare_wipes"]),
                flush=True,
            )
    finally:
        outer.close()
        if container_outer is not None:
            container_outer.close()

    if extract_only:
        result.ok = True
        result.validation = {
            "extract_only": True,
            "target": target,
            "chapters": len(fixed_chapters),
            "fixed_directory": str(fixed_dir),
        }
    else:
        output_dir.mkdir(parents=True, exist_ok=True)
        handle, temp_name = tempfile.mkstemp(
            prefix=".singleplayer-", suffix=".w3n", dir=output_dir
        )
        os.close(handle)
        partial = Path(temp_name)
        try:
            title = campaign_output_title(identity.title, target)
            patches = [(name, fixed_chapters[name]) for name in chapters]
            disabled_icon_validation = None
            if disabled_icon_info is not None:
                (
                    icon_refs,
                    icon_by_source,
                    icon_existing,
                    icon_patch_names,
                    icon_asset_patches,
                ) = disabled_icon_info
                known_patch_names = {
                    name.casefold() for name, _data in patches
                }
                for name, data in icon_asset_patches:
                    if name.casefold() in known_patch_names:
                        continue
                    patches.append((name, data))
                    known_patch_names.add(name.casefold())
                disabled_icon_validation = {
                    "icon_references": len(icon_refs),
                    "unique_enabled_icons": len(icon_by_source),
                    "covered_enabled_icons": sum(
                        1 for names in icon_existing.values() if names
                    ),
                    "generated_icon_files": len(icon_asset_patches),
                }
            add_attributes_patch(patches, source)
            source_archive = W.MPQArchive(str(source))
            try:
                source_w3f = source_archive.read_file("war3campaign.w3f") or b""
            finally:
                source_archive.close()
            patches.append(
                ("war3campaign.w3f", patch_w3f_title(source_w3f, title))
            )
            print("Repacking %d chapters..." % len(chapters), flush=True)
            MP.patch(
                str(source),
                patches,
                out_path=str(partial),
                backup=False,
                store=chapters,
                compact=False,
            )
            clear_platform_flags(partial)
            patch_hm3w_title(partial, title)

            verify = W.MPQArchive(str(partial))
            try:
                for chapter_name in chapters:
                    if verify.read_file(chapter_name) != fixed_chapters[chapter_name]:
                        raise BuildError("final chapter read-back mismatch: " + chapter_name)
                attributes = verify.read_file("(attributes)")
                campaign_w3f = verify.read_file("war3campaign.w3f") or b""
                campaign_files = verify.files()
            finally:
                verify.close()
            if attributes and len(attributes) >= 8:
                _version, flags = struct.unpack_from("<II", attributes)
                if flags:
                    raise BuildError("campaign (attributes) checksums were not disabled")
            if read_hm3w(partial) != title:
                raise BuildError("HM3W title read-back mismatch")
            if campaign_w3f != patches[-1][1]:
                raise BuildError("war3campaign.w3f title read-back mismatch")
            outer_platform = platform_entry_stats(partial)
            if outer_platform["nonzero"]:
                raise BuildError("campaign still has non-zero MPQ platform flags")
            if disabled_icon_info is not None:
                bad_disabled_icons = DISABLED_ICONS.verify_patch(
                    partial,
                    disabled_icon_info[1],
                    disabled_icon_info[3],
                )
                if bad_disabled_icons:
                    raise BuildError(
                        "disabled-icon validation failed: %s"
                        % bad_disabled_icons[:5]
                    )
                disabled_icon_validation["validation"] = "pass"

            validation: dict[str, Any] = {
                "target": target,
                "chapters": len(chapters),
                "outer_platform": outer_platform,
                "attributes_disabled": attributes is None or struct.unpack_from("<I", attributes, 4)[0] == 0,
                "campaign_title": title,
                "output_sha256": sha256_file(partial),
                "output_bytes": partial.stat().st_size,
            }
            if disabled_icon_validation is not None:
                validation["disabled_icons"] = disabled_icon_validation
            if storm_checks:
                campaign_names = [
                    name for name in ("war3campaign.w3f", "war3campaign.wts")
                    if any(existing.lower() == name for existing in campaign_files)
                ]
                validation["storm_campaign_probe"] = storm_probe(partial, campaign_names)
                validation["storm_subarchives"] = storm_subarchive_check(partial, chapters)
                if not validation["storm_campaign_probe"]["ok"]:
                    raise BuildError("game Storm.dll cannot read campaign-level files")
                if not validation["storm_subarchives"]["ok"]:
                    raise BuildError(
                        "game Storm.dll opened %d/%d chapters"
                        % (
                            validation["storm_subarchives"]["opened"],
                            validation["storm_subarchives"]["expected"],
                        )
                    )
            result.validation = validation
            if final_output.exists():
                replaced = run_root / "_replaced" / stamp / final_output.name
                replaced.parent.mkdir(parents=True, exist_ok=True)
                shutil.move(str(final_output), str(replaced))
                validation["replaced_previous"] = str(replaced)
            os.replace(partial, final_output)
            result.output = final_output
            result.ok = True
            print("Published: %s" % final_output, flush=True)
        finally:
            if partial.exists():
                partial.unlink()

    manifest = {
        "source": str(source),
        "target": target,
        "identity": identity.__dict__,
        "profile": {
            "name": profile.name if profile else None,
            "mall_false": sorted(profile_mall_false),
            "mall_true": sorted(profile_mall_true),
            "mall_default_true": profile_mall_default_true,
        },
        "output": str(result.output) if result.output else None,
        "work": str(work),
        "status": "pass" if result.ok else "fail",
        "chapters": result.chapters,
        "validation": result.validation,
    }
    write_json(report_dir / "manifest.json", manifest)
    write_report(report_dir / "REPORT.md", result, identity)
    return result


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(
        description="Repair KK/KKWE campaigns for standalone play, without adding ALAS systems."
    )
    parser.add_argument("source", type=Path, help=".w3n file or directory containing .w3n files")
    parser.add_argument("--output-dir", type=Path,
                        help="final .w3n directory; default: <source>/singleplayer")
    parser.add_argument("--work-dir", type=Path,
                        help="extracted sources/scripts/reports; default: <source>/_singleplayer_work")
    parser.add_argument("--campaign", action="append", default=[],
                        help="only build campaigns whose filename/title contains this text")
    parser.add_argument("--chapters", default="",
                        help="comma-separated chapter names to process")
    parser.add_argument("--limit", type=int, default=0,
                        help="process only the first N chapters in each campaign")
    parser.add_argument("--extract-only", action="store_true",
                        help="extract repaired chapter maps but do not repack a .w3n")
    parser.add_argument("--overwrite", action="store_true",
                        help="move an existing output to the work _replaced directory before publishing")
    parser.add_argument("--no-doctor-check", action="store_true",
                        help="skip Devo Map Doctor 1.27/Reforged checks")
    parser.add_argument("--no-storm-check", action="store_true",
                        help="skip game Storm.dll archive validation")
    parser.add_argument(
        "--remove-backpack-switch",
        action="store_true",
        help="remove the campaign's authored backpack-switch ability",
    )
    parser.add_argument(
        "--target",
        choices=TARGET_CHOICES,
        default=TARGET_REFORGED,
        help="export for classic 1.27 or Reforged (default: reforged)",
    )
    parser.add_argument(
        "--skip-disabled-icons",
        action="store_true",
        help="do not synthesize missing DIS/DISBTN command-button icons",
    )
    parser.add_argument(
        "--inspect-json",
        action="store_true",
        help="print campaign identity metadata as one JSON object and exit",
    )
    parser.add_argument("--dry-run", action="store_true",
                        help="print campaign/chapter inventory only")
    args = parser.parse_args(argv)

    source = args.source.resolve()
    if args.inspect_json:
        if not source.is_file():
            print("inspect-json requires a .w3n file", file=sys.stderr)
            return 2
        try:
            identity = campaign_identity(source)
        except Exception as exc:
            print("cannot inspect campaign: %s" % exc, file=sys.stderr)
            return 2
        print(json.dumps({
            "source": str(source),
            "filename": source.name,
            "title": identity.title,
            "author": identity.author,
            "hm3w_title": identity.hm3w_title,
            "chapter_count": len(identity.chapters),
            "source_sha256": identity.source_sha256,
        }, ensure_ascii=True))
        return 0

    output_dir = (args.output_dir or (source if source.is_dir() else source.parent) / "singleplayer").resolve()
    work_root = (args.work_dir or (source if source.is_dir() else source.parent) / "_singleplayer_work").resolve()
    try:
        campaigns = discover_campaigns(source)
    except BuildError as exc:
        parser.error(str(exc))
    wanted = [value.casefold() for value in args.campaign if value.strip()]
    selected: list[tuple[Path, CampaignIdentity]] = []
    for campaign in campaigns:
        try:
            identity = campaign_identity(campaign)
        except BuildError as exc:
            print("SKIP %s: %s" % (campaign, exc), file=sys.stderr)
            continue
        haystack = (campaign.stem + " " + identity.title + " " + identity.hm3w_title).casefold()
        if wanted and not any(value in haystack for value in wanted):
            continue
        selected.append((campaign, identity))
    if not selected:
        print("No matching campaigns.", file=sys.stderr)
        return 2

    print("Campaigns: %d" % len(selected))
    print("Export target: %s" % args.target)
    for campaign, identity in selected:
        print("  %-16s %-32s %d chapters" % (campaign.name, identity.title, len(identity.chapters)))
    if args.dry_run:
        return 0

    output_dir.mkdir(parents=True, exist_ok=True)
    work_root.mkdir(parents=True, exist_ok=True)
    chapter_filter = {
        value.strip().casefold()
        for value in args.chapters.split(",")
        if value.strip()
    } or None
    summary: list[dict[str, Any]] = []
    failures = 0
    for campaign, _identity in selected:
        print("\n=== %s ===" % campaign.name, flush=True)
        try:
            result = build_campaign(
                campaign,
                work_root,
                output_dir,
                args.extract_only,
                args.overwrite,
                not args.no_doctor_check,
                not args.no_storm_check,
                args.remove_backpack_switch,
                not args.skip_disabled_icons,
                chapter_filter,
                args.limit,
                args.target,
            )
            if not result.ok and result.error:
                raise BuildError(result.error)
            summary.append({
                "source": str(result.source),
                "target": result.target,
                "output": str(result.output) if result.output else None,
                "work": str(result.work) if result.work else None,
                "status": "pass",
                "chapters": len(result.chapters),
            })
            print("PASS: %s" % (result.output or result.work), flush=True)
        except Exception as exc:
            failures += 1
            summary.append({
                "source": str(campaign),
                "target": args.target,
                "status": "fail",
                "error": "%s: %s" % (type(exc).__name__, exc),
            })
            print("FAIL: %s: %s" % (type(exc).__name__, exc), file=sys.stderr, flush=True)

    summary_path = work_root / "summary.json"
    combined = aggregate_manifests(work_root)
    current_by_target = {
        (entry["source"], entry.get("target", TARGET_REFORGED)): entry
        for entry in summary
    }
    combined_by_target = {
        (entry["source"], entry.get("target", TARGET_REFORGED)): entry
        for entry in combined
    }
    combined_by_target.update(current_by_target)
    write_json(summary_path, {
        "source": str(source),
        "output_dir": str(output_dir),
        "campaigns": [
            combined_by_target[key]
            for key in sorted(combined_by_target)
        ],
    })
    print("\nSummary: %s" % summary_path)
    if failures:
        print("%d campaign(s) failed." % failures, file=sys.stderr)
        return 1
    print("All campaigns passed static validation.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
