"""Prepare, render, and verify the reusable universal talent bundle."""

from __future__ import annotations

import os
import re
import shutil
import sys
import tempfile
from dataclasses import dataclass
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
DOCTOR = ROOT / "tools" / "_devos-map-doctor" / "devos-map-doctor-main"
sys.path.insert(0, str(HERE))
sys.path.insert(0, str(DOCTOR))

import build_losttemple_talent_tree as TALENT  # noqa: E402
import war3mpq as W  # noqa: E402
import wild_equipment_drops as WILD_DROPS  # noqa: E402
from doctor.data import objects as DOBJ  # noqa: E402


@dataclass(frozen=True)
class TalentBundle:
    ability_object: Path
    item_object: Path
    source_script_dir: Path
    chapter_levels: dict[str, int]
    scripts: dict[int, Path]

    def level_for(self, chapter: str | None = None) -> int:
        if chapter is None:
            return next(iter(self.chapter_levels.values()))
        return self.chapter_levels[chapter]

    def script_for(self, chapter: str | None = None) -> Path:
        return self.scripts[self.level_for(chapter)]


def _object_ids(
    archive: W.MPQArchive,
    *,
    campaign_prefix: bool = False,
) -> set[str]:
    prefix = "war3campaign." if campaign_prefix else "war3map."
    ability_data = archive.read_file(prefix + "w3a") or b""
    item_data = archive.read_file(prefix + "w3t") or b""
    found: set[str] = set()
    if ability_data:
        _version, entries, _consumed = DOBJ.read_objects_bytes(
            ability_data,
            True,
            fname=prefix + "w3a",
            with_end=True,
        )
        found.update(
            new.replace("\0", "")
            for _table, _old, new, _mods in entries
            if new.replace("\0", "")
        )
    if item_data:
        _version, entries, _consumed = DOBJ.read_objects_bytes(
            item_data,
            False,
            fname=prefix + "w3t",
            with_end=True,
        )
        found.update(
            new.replace("\0", "")
            for _table, _old, new, _mods in entries
            if new.replace("\0", "")
        )
    return found


def _campaign_chapters(source: Path) -> list[str]:
    archive = W.MPQArchive(str(source))
    try:
        chapters = sorted(
            name
            for name in archive.listfile
            if name.lower().endswith((".w3x", ".w3m"))
        )
    finally:
        archive.close()
    if not chapters:
        raise ValueError("campaign has no listed chapters")
    return chapters


def _read_chapter(path: Path) -> tuple[set[str], int]:
    archive = W.MPQArchive(str(path))
    try:
        return _object_ids(archive), WILD_DROPS.hero_level_cap(path)
    finally:
        archive.close()


def _scan_campaign(source: Path) -> tuple[set[str], dict[str, int]]:
    outer = W.MPQArchive(str(source))
    existing = _object_ids(outer, campaign_prefix=True)
    chapters = sorted(
        name
        for name in outer.listfile
        if name.lower().endswith((".w3x", ".w3m"))
    )
    if not chapters:
        outer.close()
        raise ValueError("campaign has no listed chapters")
    levels: dict[str, int] = {}
    try:
        for name in chapters:
            data = outer.read_file(name)
            if not data:
                raise ValueError("campaign chapter cannot be read: " + name)
            fd, temp_name = tempfile.mkstemp(suffix=Path(name).suffix)
            os.close(fd)
            temp = Path(temp_name)
            try:
                temp.write_bytes(data)
                chapter_ids, level_cap = _read_chapter(temp)
                existing.update(chapter_ids)
                levels[name] = level_cap
            finally:
                temp.unlink(missing_ok=True)
    finally:
        outer.close()
    return existing, levels


def _generated_ids() -> tuple[set[str], set[str]]:
    abilities = {
        str(entry["new"])
        for entry in TALENT.build_entries()
    }
    items = {
        str(entry["new"])
        for entry in TALENT.build_item_entries()
    }
    return abilities, items


def _render_script(work: Path, level_cap: int) -> Path:
    target = work / "scripts" / ("level-%d" % level_cap)
    if target.is_dir():
        return target
    shutil.copytree(TALENT.TALENT_SCRIPT, target)
    globals_path = target / "g.j"
    text = globals_path.read_text(encoding="utf-8")
    updated, count = re.subn(
        r"(?m)^integer TT_MAX_LEVEL = \d+$",
        "integer TT_MAX_LEVEL = %d" % level_cap,
        text,
    )
    if count != 1:
        raise ValueError("talent global TT_MAX_LEVEL anchor is not unique")
    globals_path.write_text(updated, encoding="utf-8", newline="\n")
    return target


def prepare_bundle(
    source: Path,
    work: Path,
    chapters: list[str] | None = None,
) -> TalentBundle:
    work.mkdir(parents=True, exist_ok=True)
    if source.suffix.lower() == ".w3n":
        expected_chapters = (
            sorted(chapters) if chapters is not None
            else _campaign_chapters(source)
        )
        existing, levels = _scan_campaign(source)
        missing = set(expected_chapters) - set(levels)
        if missing:
            raise ValueError(
                "talent chapter scan is missing: "
                + ", ".join(sorted(missing))
            )
        levels = {
            name: levels[name]
            for name in expected_chapters
        }
    else:
        chapter_name = source.name
        existing, level_cap = _read_chapter(source)
        levels = {chapter_name: level_cap}

    generated_abilities, generated_items = _generated_ids()
    collisions = sorted(
        ((generated_abilities | generated_items) & existing)
    )
    if collisions:
        raise ValueError(
            "universal talents require free generated object IDs; "
            "source already uses: " + ", ".join(collisions[:16])
        )

    ability_object = work / "talent.w3a"
    item_object = work / "talent.w3t"
    TALENT.write_talent_objects(ability_object, item_object)
    unique_levels = sorted(set(levels.values()))
    scripts = {
        level_cap: _render_script(work, level_cap)
        for level_cap in unique_levels
    }
    return TalentBundle(
        ability_object=ability_object,
        item_object=item_object,
        source_script_dir=TALENT.TALENT_SCRIPT,
        chapter_levels=levels,
        scripts=scripts,
    )


def _entries(data: bytes, with_levels: bool) -> dict[str, tuple[str, object]]:
    _version, entries, consumed = DOBJ.read_objects_bytes(
        data,
        with_levels,
        fname="talent objects",
        with_end=True,
    )
    if consumed != len(data):
        raise ValueError("talent object data has trailing bytes")
    return {
        new.replace("\0", ""): (old.replace("\0", ""), mods)
        for _table, old, new, mods in entries
        if new.replace("\0", "")
    }


def _field_map(mods: object) -> dict[object, object]:
    fields: dict[object, object] = {}
    for mod in mods:
        value = (
            mod[4].decode("utf-8", "replace")
            if isinstance(mod[4], bytes)
            else mod[4]
        )
        fields[mod[0]] = value
        fields[(mod[0], mod[2])] = value
    return fields


def _verify_script(script: bytes, level_cap: int, label: str) -> None:
    text = script.decode("utf-8", "replace")
    if not re.search(
        r"\bTT_MAX_LEVEL\s*=\s*%d\b" % level_cap,
        text,
    ):
        raise ValueError(
            "%s has the wrong universal talent level cap" % label
        )
    for marker in (
        "TT_SavedBackpackIndex",
        "TT_GrantEarnedPoints",
        "TT_ClearTalentMilestones",
        "TT_ResetTalents",
        "TT_Init",
        "BlzResetUnitTalents",
        "talentreset",
    ):
        if marker not in text:
            raise ValueError(
                "%s is missing universal talent marker %s"
                % (label, marker)
            )


def _verify_archive(
    path: Path,
    level_cap: int,
    display_name: str,
) -> None:
    archive = W.MPQArchive(str(path))
    try:
        ability_data = archive.read_file("war3map.w3a") or b""
        item_data = archive.read_file("war3map.w3t") or b""
        script = (
            archive.read_file("war3map.lua")
            or archive.read_file("war3map.j")
            or archive.read_file(r"scripts\war3map.j")
            or archive.read_file(r"Scripts\war3map.j")
            or b""
        )
    finally:
        archive.close()
    if not ability_data or not item_data or not script:
        raise ValueError(
            display_name + " is missing talent objects or script"
        )
    abilities = _entries(ability_data, True)
    items = _entries(item_data, False)
    for ident in ("I103", "I105", "I106"):
        if ident not in items:
            raise ValueError(
                display_name + " is missing artifact " + ident
            )
    for index in range(TALENT.HERO_POOL_SIZE):
        talent = TALENT.talent_pool_id(index)
        backpack = TALENT.backpack_pool_id(index)
        if talent not in abilities or backpack not in items:
            raise ValueError(
                display_name + " is missing talent pair " + talent
            )
        master = _field_map(abilities[talent][1])
        if master.get("alev") != TALENT.TIER_COUNT:
            raise ValueError(
                display_name + ": " + talent + " has the wrong tier count"
            )
        for tier in range(TALENT.TIER_COUNT):
            expected = ",".join(
                TALENT.node_id(tier, choice)
                for choice in range(TALENT.CHOICES_PER_TIER)
            )
            if master.get(("aabi", tier + 1)) != expected:
                raise ValueError(
                    display_name + ": " + talent
                    + " has an invalid tier mapping"
                )
        bag = _field_map(items[backpack][1])
        if bag.get("iabi") != "AIni,AEqu,ASde," + talent:
            raise ValueError(
                display_name + ": " + backpack
                + " is linked to the wrong talent tree"
            )
    _verify_script(script, level_cap, display_name)


def verify_bundle(output: Path, bundle: TalentBundle) -> None:
    if output.suffix.lower() == ".w3n":
        outer = W.MPQArchive(str(output))
        try:
            present = {
                name
                for name in outer.listfile
                if name.lower().endswith((".w3x", ".w3m"))
            }
            missing = set(bundle.chapter_levels) - present
            if missing:
                raise ValueError(
                    "talent campaign is missing chapters: "
                    + ", ".join(sorted(missing))
                )
            for name, level_cap in bundle.chapter_levels.items():
                data = outer.read_file(name)
                if not data:
                    raise ValueError(
                        "talent campaign chapter cannot be read: " + name
                    )
                fd, temp_name = tempfile.mkstemp(suffix=Path(name).suffix)
                os.close(fd)
                temp = Path(temp_name)
                try:
                    temp.write_bytes(data)
                    _verify_archive(
                        temp,
                        level_cap,
                        name,
                    )
                finally:
                    temp.unlink(missing_ok=True)
        finally:
            outer.close()
        return
    level_cap = next(iter(bundle.chapter_levels.values()))
    _verify_archive(output, level_cap, output.name)
