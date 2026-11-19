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
from doctor.data import w3i as W3I  # noqa: E402


HERO_REPLACEMENT_BEGIN_MARKER = (
    b"ALAS_TALENT_HERO_REPLACEMENT_BEGIN"
)
HERO_REPLACEMENT_END_MARKER = (
    b"ALAS_TALENT_HERO_REPLACEMENT_END"
)
HERO_YDWE_REPLACEMENT_MARKER = (
    b"ALAS_TALENT_YDWE_HERO_REPLACEMENT"
)


@dataclass(frozen=True)
class TalentBundle:
    ability_object: Path
    item_object: Path
    buff_object: Path
    breakthrough_buff_id: str
    melee_hero_talents: bool
    source_script_dir: Path
    chapter_levels: dict[str, int]
    scripts: dict[int, Path]
    chapter_scripts: dict[str, Path]

    def level_for(self, chapter: str | None = None) -> int:
        if chapter is None:
            return next(iter(self.chapter_levels.values()))
        return self.chapter_levels[chapter]

    def script_for(self, chapter: str | None = None) -> Path:
        if chapter is not None and chapter in self.chapter_scripts:
            return self.chapter_scripts[chapter]
        return self.scripts[self.level_for(chapter)]


def _object_ids(
    archive: W.MPQArchive,
    *,
    campaign_prefix: bool = False,
    include_ability_buff_refs: bool = False,
) -> set[str]:
    prefix = "war3campaign." if campaign_prefix else "war3map."
    ability_data = archive.read_file(prefix + "w3a") or b""
    item_data = archive.read_file(prefix + "w3t") or b""
    buff_data = archive.read_file(prefix + "w3h") or b""
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
        if include_ability_buff_refs:
            found.update(
                mod[4].decode("latin-1").replace("\0", "")
                for _table, _old, _new, mods in entries
                for mod in mods
                if mod[0] == "abuf"
                and mod[1] == 3
                and isinstance(mod[4], (bytes, bytearray))
                and mod[4]
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
    if buff_data:
        _version, entries, _consumed = DOBJ.read_objects_bytes(
            buff_data,
            False,
            fname=prefix + "w3h",
            with_end=True,
        )
        found.update(
            new.replace("\0", "")
            for _table, _old, new, _mods in entries
            if new.replace("\0", "")
        )
    return found


def _chapter_script_order(chapters: list[str]) -> list[str]:
    """Keep a playable epilogue/outro after the main campaign chapters."""
    def key(name: str) -> tuple[int, str]:
        stem = Path(name).stem.casefold()
        ending = "epilogue" in stem or "outro" in stem
        return (1 if ending else 0, name.casefold())

    return sorted(chapters, key=key)


def _campaign_chapters(source: Path) -> list[str]:
    archive = W.MPQArchive(str(source))
    try:
        chapters = _chapter_script_order(
            [
                name
                for name in archive.listfile
                if name.lower().endswith((".w3x", ".w3m"))
            ]
        )
    finally:
        archive.close()
    if not chapters:
        raise ValueError("campaign has no listed chapters")
    return chapters


def _read_chapter(path: Path) -> tuple[set[str], int]:
    archive = W.MPQArchive(str(path))
    try:
        return (
            _object_ids(
                archive,
                include_ability_buff_refs=True,
            ),
            WILD_DROPS.hero_level_cap(path),
        )
    finally:
        archive.close()


def _scan_campaign(source: Path) -> tuple[set[str], dict[str, int]]:
    outer = W.MPQArchive(str(source))
    existing = _object_ids(
        outer,
        campaign_prefix=True,
        include_ability_buff_refs=True,
    )
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


def _choose_breakthrough_buff_id(existing: set[str]) -> str:
    preferred = TALENT.BREAKTHROUGH_BUFF_ID_BASE
    if preferred not in existing:
        return preferred
    first_value = int(preferred[1:], 16)
    for start, stop in (
        (first_value + 1, 0x1000),
        (0x400, first_value),
    ):
        for value in range(start, stop):
            candidate = "B%03X" % value
            if candidate not in existing:
                return candidate
    raise ValueError(
        "universal talents could not find a free breakthrough buff ID"
    )


def _generated_ids(
    breakthrough_buff_id: str = TALENT.BREAKTHROUGH_BUFF_ID_BASE,
    melee_hero_talents: bool = False,
) -> tuple[set[str], set[str], set[str]]:
    abilities = {
        str(entry["new"])
        for entry in TALENT.build_entries(
            breakthrough_buff_id,
            melee_hero_talents,
        )
    }
    items = {
        str(entry["new"])
        for entry in TALENT.build_item_entries()
    }
    buffs = {
        str(entry["new"])
        for entry in TALENT.breakthrough_buff_entries(
            breakthrough_buff_id
        )
    }
    return abilities, items, buffs


def _patch_talent_script_id(target: Path, breakthrough_buff_id: str) -> None:
    old_literal = "'" + TALENT.BREAKTHROUGH_BUFF_ID_BASE + "'"
    new_literal = "'" + breakthrough_buff_id + "'"
    patched = 0
    for path in sorted(target.glob("*.j")):
        text = path.read_text(encoding="utf-8")
        count = text.count(old_literal)
        if not count:
            continue
        path.write_text(
            text.replace(old_literal, new_literal),
            encoding="utf-8",
            newline="\n",
        )
        patched += count
    if not patched:
        raise ValueError(
            "talent script has no breakthrough buff ID anchor"
        )
    runtime = (target / "f.j").read_text(encoding="utf-8")
    if runtime.count(new_literal) != 1:
        raise ValueError(
            "talent runtime must reference the breakthrough buff once"
        )
    if breakthrough_buff_id != TALENT.BREAKTHROUGH_BUFF_ID_BASE:
        if old_literal in runtime:
            raise ValueError(
                "talent runtime still references the occupied buff ID"
            )


def patch_hero_replacements(
    script: bytes,
) -> tuple[bytes, dict[str, int]]:
    """Bridge author hero-replacement triggers into talent state.

    Xiao Jia campaigns commonly save three attributes and the hero level,
    create a replacement skin unit, copy six inventory slots, remove the old
    unit, then reassign a global hero handle. Talent state is keyed by the
    registered hero slot, so the replacement must capture before removal and
    adopt the same slot after the new unit becomes player-controlled.
    """
    begin_call = b"call TT_BeginHeroReplacement("
    end_call = b"call TT_EndHeroReplacement("
    if (
        HERO_REPLACEMENT_BEGIN_MARKER in script
        or HERO_YDWE_REPLACEMENT_MARKER in script
    ):
        return script, {
            "begin": script.count(begin_call),
            "end": script.count(end_call),
            "ydwe": script.count(
                b"call TT_YDWEReplaceHeroBJNull("
            ),
        }

    begin_pattern = re.compile(
        rb"call\s+SaveInteger\([^\r\n]*?"
        rb"GetHeroStr\((udg_[A-Za-z0-9_]+),\s*false\)"
    )
    assign_pattern = re.compile(
        rb"^\s*set\s+(udg_[A-Za-z0-9_]+)\s*="
        rb"\s*LoadUnitHandle\("
    )
    created_assign_pattern = re.compile(
        rb"^\s*set\s+(udg_[A-Za-z0-9_]+)\s*="
        rb"\s*bj_lastCreatedUnit\s*$"
    )
    owner_pattern = re.compile(
        rb"call\s+SetUnitOwner\("
        rb"(udg_[A-Za-z0-9_]+),\s*Player\(0\),\s*true\)"
    )
    manual_copy_pattern = re.compile(
        rb"UnitAddItemByIdSwapped\(\s*GetItemTypeId\(\s*"
        rb"UnitItemInSlot\(\s*(udg_[A-Za-z0-9_]+)\s*,\s*\d+\s*\)"
        rb"\s*\)\s*,\s*(udg_[A-Za-z0-9_]+)\s*\)",
        re.IGNORECASE,
    )
    show_hidden_pattern = re.compile(
        rb"call\s+ShowUnit\(\s*(udg_[A-Za-z0-9_]+)\s*,"
        rb"\s*false\s*\)",
        re.IGNORECASE,
    )
    ydwe_replace_pattern = re.compile(
        rb"^([ \t]*)call\s+YDWEReplaceUnitBJNull\("
        rb"\s*(udg_[A-Za-z0-9_]*hero[A-Za-z0-9_]*)\s*,",
        re.IGNORECASE,
    )
    lines = script.splitlines(keepends=True)
    ydwe_lines: list[bytes] = []
    ydwe_count = 0
    for line in lines:
        match = ydwe_replace_pattern.search(line)
        if match is None:
            ydwe_lines.append(line)
            continue
        body = line.rstrip(b"\r\n")
        ending = line[len(body):]
        body = body.replace(
            b"YDWEReplaceUnitBJNull(",
            b"TT_YDWEReplaceHeroBJNull(",
            1,
        )
        if HERO_YDWE_REPLACEMENT_MARKER not in body:
            body += b" // " + HERO_YDWE_REPLACEMENT_MARKER
        ydwe_lines.append(body + ending)
        ydwe_count += 1
    lines = ydwe_lines

    output: list[bytes] = []
    begin_count = 0
    end_count = 0
    index = 0

    while index < len(lines):
        if not lines[index].startswith(b"function "):
            output.append(lines[index])
            index += 1
            continue
        end = index + 1
        while end < len(lines) and not lines[end].startswith(
            b"endfunction"
        ):
            end += 1
        if end >= len(lines):
            raise ValueError("unterminated JASS function")
        chunk = lines[index : end + 1]
        joined = b"".join(chunk)
        replacement_shape = (
            b"CreateNUnitsAtLoc(" in joined
            and b"UnitAddItemSwapped(" in joined
            and b"SetHeroLevelBJ(" in joined
            and b"RemoveUnit(udg_" in joined
        )
        manual_matches = list(manual_copy_pattern.finditer(joined))
        manual_sources = {
            match.group(1) for match in manual_matches
        }
        manual_targets = {
            match.group(2) for match in manual_matches
        }
        manual_copy_shape = (
            len(manual_matches) >= 2
            and len(manual_sources) == 1
            and len(manual_targets) == 1
        )
        mall_skin_shape = (
            b"DzAPI_Map_HasMallItem(" in joined
            and b"CreateNUnitsAtLoc(" in joined
            and b"ModifyHeroStat(bj_HEROSTAT_STR" in joined
            and b"UnitAddItemSwapped(" in joined
        )
        if not replacement_shape and not manual_copy_shape and not mall_skin_shape:
            output.extend(chunk)
            index = end + 1
            continue

        if mall_skin_shape:
            show_positions = [
                position
                for position, line in enumerate(chunk)
                if show_hidden_pattern.search(line) is not None
            ]
            assignment_positions = [
                position
                for position, line in enumerate(chunk)
                if created_assign_pattern.search(
                    line.rstrip(b"\r\n")
                ) is not None
            ]
            matched = None
            for show_position in show_positions:
                source = show_hidden_pattern.search(
                    chunk[show_position]
                ).group(1)
                assignment_position = next(
                    (
                        position
                        for position in assignment_positions
                        if position > show_position
                        and created_assign_pattern.search(
                            chunk[position].rstrip(b"\r\n")
                        ).group(1) == source
                    ),
                    -1,
                )
                if assignment_position >= 0:
                    matched = (show_position, assignment_position, source)
                    break
            if matched is not None:
                show_position, assignment_position, source = matched
                copy_positions = [
                    position
                    for position, line in enumerate(chunk)
                    if position > assignment_position
                    and b"UnitAddItemSwapped(" in line
                ]
                end_position = assignment_position
                if copy_positions:
                    end_position = next(
                        (
                            position
                            for position in range(
                                copy_positions[-1] + 1,
                                len(chunk),
                            )
                            if b"endloop" in chunk[position]
                        ),
                        copy_positions[-1],
                    )
                for position, line in enumerate(chunk):
                    if position == show_position:
                        output.append(
                            b"    call TT_BeginHeroReplacement("
                            + source
                            + b") // "
                            + HERO_REPLACEMENT_BEGIN_MARKER
                            + b"\n"
                        )
                        begin_count += 1
                    output.append(line)
                    if position == end_position:
                        output.append(
                            b"    call TT_EndHeroReplacement("
                            + source
                            + b") // "
                            + HERO_REPLACEMENT_END_MARKER
                            + b"\n"
                        )
                        end_count += 1
                index = end + 1
                continue

        if manual_copy_shape:
            source = next(iter(manual_sources))
            target = next(iter(manual_targets))
            copy_positions = [
                position
                for position, line in enumerate(chunk)
                if manual_copy_pattern.search(line) is not None
            ]
            first_copy = copy_positions[0]
            last_copy = copy_positions[-1]
            for position, line in enumerate(chunk):
                if position == first_copy:
                    output.append(
                        b"    call TT_BeginHeroReplacement("
                        + source
                        + b") // "
                        + HERO_REPLACEMENT_BEGIN_MARKER
                        + b"\n"
                    )
                    begin_count += 1
                output.append(line)
                if position == last_copy:
                    output.append(
                        b"    call TT_EndHeroReplacement("
                        + target
                        + b") // "
                        + HERO_REPLACEMENT_END_MARKER
                        + b"\n"
                    )
                    end_count += 1
            index = end + 1
            continue

        begin_positions = [
            position
            for position, line in enumerate(chunk)
            if begin_pattern.search(line) is not None
        ]
        replacements: dict[int, tuple[bytes, int]] = {}
        for position in begin_positions:
            active_hero = begin_pattern.search(
                chunk[position]
            ).group(1)
            next_begin = next(
                (
                    candidate
                    for candidate in begin_positions
                    if candidate > position
                ),
                len(chunk),
            )
            assigned = False
            owner_position = -1
            for candidate in range(position + 1, next_begin):
                line = chunk[candidate]
                assignment = assign_pattern.search(line)
                if (
                    assignment is not None
                    and assignment.group(1) == active_hero
                ):
                    assigned = True
                owner = owner_pattern.search(line)
                if (
                    assigned
                    and owner is not None
                    and owner.group(1) == active_hero
                ):
                    owner_position = candidate
                    break
            if owner_position >= 0:
                replacements[position] = (
                    active_hero,
                    owner_position,
                )

        end_positions = {
            owner_position: hero
            for hero, owner_position in replacements.values()
        }
        for position, line in enumerate(chunk):
            if position in replacements:
                active_hero = replacements[position][0]
                output.append(
                    b"    call TT_BeginHeroReplacement("
                    + active_hero
                    + b") // "
                    + HERO_REPLACEMENT_BEGIN_MARKER
                    + b"\n"
                )
                begin_count += 1
            output.append(line)
            if position in end_positions:
                active_hero = end_positions[position]
                output.append(
                    b"    call TT_EndHeroReplacement("
                    + active_hero
                    + b") // "
                    + HERO_REPLACEMENT_END_MARKER
                    + b"\n"
                )
                end_count += 1
        index = end + 1

    if begin_count != end_count:
        raise ValueError(
            "hero replacement patch mismatch: %d begin, %d end"
            % (begin_count, end_count)
        )
    return b"".join(output), {
        "begin": begin_count,
        "end": end_count,
        "ydwe": ydwe_count,
    }


def _render_script(
    work: Path,
    level_cap: int,
    breakthrough_buff_id: str,
    melee_hero_talents: bool,
) -> Path:
    target = work / "scripts" / ("level-%d" % level_cap)
    if target.is_dir():
        return target
    shutil.copytree(TALENT.TALENT_SCRIPT, target)
    _patch_talent_script_id(target, breakthrough_buff_id)
    globals_path = target / "g.j"
    text = globals_path.read_text(encoding="utf-8")
    updated, count = re.subn(
        r"(?m)^integer TT_MAX_LEVEL = \d+$",
        "integer TT_MAX_LEVEL = %d" % level_cap,
        text,
    )
    if count != 1:
        raise ValueError("talent global TT_MAX_LEVEL anchor is not unique")
    updated, count = re.subn(
        r"(?m)^boolean TT_MELEE_HERO_TALENTS = (?:true|false)$",
        "boolean TT_MELEE_HERO_TALENTS = "
        + ("true" if melee_hero_talents else "false"),
        updated,
    )
    if count != 1:
        raise ValueError(
            "talent global TT_MELEE_HERO_TALENTS anchor is not unique"
        )
    globals_path.write_text(updated, encoding="utf-8", newline="\n")
    return target


def _render_chapter_script(
    work: Path,
    level_cap: int,
    chapter_index: int,
    breakthrough_buff_id: str,
    melee_hero_talents: bool,
) -> Path:
    target = work / "scripts" / ("chapter-%02d" % chapter_index)
    if target.is_dir():
        return target
    shutil.copytree(
        _render_script(
            work,
            level_cap,
            breakthrough_buff_id,
            melee_hero_talents,
        ),
        target,
    )
    globals_path = target / "g.j"
    text = globals_path.read_text(encoding="utf-8")
    updated, count = re.subn(
        r"(?m)^integer TT_CAMPAIGN_CHAPTER = \d+$",
        "integer TT_CAMPAIGN_CHAPTER = %d" % chapter_index,
        text,
    )
    if count != 1:
        raise ValueError(
            "talent global TT_CAMPAIGN_CHAPTER anchor is not unique"
        )
    globals_path.write_text(updated, encoding="utf-8", newline="\n")
    return target


def prepare_bundle(
    source: Path,
    work: Path,
    chapters: list[str] | None = None,
    melee_hero_talents: bool = False,
) -> TalentBundle:
    work.mkdir(parents=True, exist_ok=True)
    if source.suffix.lower() == ".w3n":
        expected_chapters = (
            _chapter_script_order(list(chapters))
            if chapters is not None
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
        campaign_level_cap = max(levels.values())
        levels = {
            name: campaign_level_cap
            for name in expected_chapters
        }
    else:
        chapter_name = source.name
        existing, level_cap = _read_chapter(source)
        levels = {chapter_name: level_cap}

    breakthrough_buff_id = _choose_breakthrough_buff_id(existing)
    generated_abilities, generated_items, generated_buffs = (
        _generated_ids(
            breakthrough_buff_id,
            melee_hero_talents,
        )
    )
    collisions = sorted(
        (
            (generated_abilities | generated_items | generated_buffs)
            & existing
        )
    )
    if collisions:
        raise ValueError(
            "universal talents require free generated object IDs; "
            "source already uses: " + ", ".join(collisions[:16])
        )

    ability_object = work / "talent.w3a"
    item_object = work / "talent.w3t"
    buff_object = work / "talent.w3h"
    TALENT.write_talent_objects(
        ability_object,
        item_object,
        buff_object,
        breakthrough_buff_id,
        melee_hero_talents,
    )
    unique_levels = sorted(set(levels.values()))
    scripts = {
        level_cap: _render_script(
            work,
            level_cap,
            breakthrough_buff_id,
            melee_hero_talents,
        )
        for level_cap in unique_levels
    }
    chapter_scripts: dict[str, Path] = {}
    if source.suffix.lower() == ".w3n":
        chapter_scripts = {
            chapter: _render_chapter_script(
                work,
                levels[chapter],
                index,
                breakthrough_buff_id,
                melee_hero_talents,
            )
            for index, chapter in enumerate(expected_chapters, 1)
        }
    return TalentBundle(
        ability_object=ability_object,
        item_object=item_object,
        buff_object=buff_object,
        breakthrough_buff_id=breakthrough_buff_id,
        melee_hero_talents=melee_hero_talents,
        source_script_dir=TALENT.TALENT_SCRIPT,
        chapter_levels=levels,
        scripts=scripts,
        chapter_scripts=chapter_scripts,
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


def _duplicate_object_ids(data: bytes, with_levels: bool) -> dict[str, int]:
    _version, entries, consumed = DOBJ.read_objects_bytes(
        data,
        with_levels,
        fname="talent objects",
        with_end=True,
    )
    if consumed != len(data):
        raise ValueError("talent object data has trailing bytes")
    counts: dict[str, int] = {}
    for _table, _old, new, _mods in entries:
        ident = new.replace("\0", "")
        if ident:
            counts[ident] = counts.get(ident, 0) + 1
    return {
        ident: count
        for ident, count in counts.items()
        if count > 1
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


def _verify_script(
    script: bytes,
    level_cap: int,
    label: str,
    script_type: str,
    melee_hero_talents: bool,
) -> None:
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
        "TT_HasInventoryAbility",
        "TT_IsTalentHero",
        "TT_EnsureBackpack",
        "BACKPACK_FALLBACK",
        "TT_GrantEarnedPoints",
        "TT_ClearTalentMilestones",
        "TT_ResetTalents",
        "TT_RegisterHeroCore",
        "TT_EnsureHeroNow",
        "TT_EligiblePointCount",
        "TT_TrimMilestonesToCount",
        "TT_ValidateTalentPoints",
        "TT_NotifyTalentDeficit",
        "TT_NotifyTalentExcess",
        "TT_HeroDisplayName",
        " 获得 ",
        "TT_CaptureTalentState",
        "TT_ActualSelectionText",
        "TT_RestoreTalentState",
        "TT_PreserveTalentNodes",
        "TT_TierSlot",
        "TT_TierNodeCode",
        "TT_AttributeTalentLevel",
        "TT_SyncAttributeTalents",
        "TT_SyncAttributeTalent",
        "GetHeroStr(u, true)",
        "GetHeroAgi(u, true)",
        "GetHeroInt(u, true)",
        "TT_ApplyCleaveTalent",
        "TT_ApplyBreakthroughTalent",
        "TT_ApplyIncinerateTalent",
        "TT_ExplodeIncinerateTalent",
        "TT_OnAnyUnitDeath",
        "InitHashtable",
        '"talentstats"',
        "event=TALENT_ATTACK",
        "event=BREAKTHROUGH_STOMP",
        "event=INCINERATE_HIT",
        "event=INCINERATE_EXPLODE",
        "event=INCINERATE_EXPLODE_HIT",
        "event=TALENT_STATS",
        "event=TALENT_DAMAGE_EVENT",
        "TT_EarnedTalentPoints",
        "TT_TALENT_MASTER_LEVEL",
        "TT_AWARDED_MASK",
        "TT_UNSPENT_POINTS",
        "TT_SELECTED_TIER_COUNT",
        "TT_RevealSelectedTalentAbilities",
        "TT_IsAwarded",
        "TT_CampaignNormalizeUnitForStore",
        "TT_CampaignStoreTalentSnapshot",
        "TT_CampaignRestoreTalentSnapshot",
        "TT_OnTalentUiRebuildTimer",
        "TT_ScheduleTalentUiRebuild",
        "TT_BeginHeroReplacement",
        "TT_EndHeroReplacement",
        "TT_REPLACEMENT_WAS_SELECTED",
        "TT_CaptureReplacementItems",
        "TT_RestoreReplacementItems",
        "TT_RestoreReplacementEquipment",
        "TT_RestoreReplacementBag",
        "TT_RemoveForeignTalentBackpacks",
        "TT_YDWEReplaceHeroBJNull",
        "TT_FlushDeferredHeroReplacement",
        "TT_CampaignAuditStore",
        "TT_CampaignAuditAbilities",
        "TT_CampaignAuditRestoreProbe",
        "TT_CampaignAuditSave",
        "TT_CAMPAIGN_STORE_RESULT",
        "TT_CAMPAIGN_SAVE_RESULT",
        "CAMPAIGN_STORE_AUDIT",
        "CAMPAIGN_STORE_ABILITY",
        "CAMPAIGN_RESTORE_PROBE",
        "CAMPAIGN_CACHE_SAVE",
        "CAMPAIGN_SAVE_RECHECK",
        "CAMPAIGN_EXPECTED_CHECK",
        "CAMPAIGN_STORE_ITEM",
        "CAMPAIGN_NATIVE_NORMALIZE",
        "CAMPAIGN_TALENT_SNAPSHOT_STORE",
        "CAMPAIGN_TALENT_SNAPSHOT_RESTORE",
        "CAMPAIGN_TALENT_SNAPSHOT_MISSING",
        "TALENT_UI_REFRESH",
        "HERO_REPLACEMENT_BEGIN",
        "HERO_REPLACEMENT_DEFER_INIT",
        "HERO_REPLACEMENT_END",
        "HERO_REPLACEMENT_EXT_CAPTURE",
        "HERO_REPLACEMENT_EXT_RESTORE",
        "HERO_REPLACEMENT_EXT_FAIL",
        "HERO_REPLACEMENT_SKIP_SAME_TYPE",
        "HERO_REPLACEMENT_WAIT_BACKPACK",
        "TT_RegisteredHeroIndex",
        "TT_MarkStartReady",
        "TT_OnPointTimer",
        "TT_CAMPAIGN_CHAPTER",
        "START_READY",
        "POINT_ITEM_ISSUED",
        "POINT_GRANT_COMMITTED",
        "POINT_LEVEL_WAIT",
        "TALENT_POINTS_BALANCE",
        "TALENT_SELECTED_ABILITY_VISIBLE",
        "POINT_GRANT_BLOCKED",
        "UnitUseItem(u, it)",
        "HERO_WAIT_BACKPACK",
        "POINT_RECONCILE_EXCESS",
        "POINT_RECONCILE_DEFICIT",
        "POINT_RECONCILE_OK",
        "TALENT_INFER_AWARDED",
        "PANEL_ABILITY",
        "TT_LogFlush",
        "PreloadGenEnd",
        "TT_LOG_FILE",
        "talentlog",
        "TT_Init",
        "BlzResetUnitTalents",
        "talentreset",
        "EVENT_PLAYER_HERO_REVIVE_FINISH",
        "EVENT_PLAYER_HERO_SKILL",
        "TriggerRegisterPlayerChatEvent",
    ):
        if marker not in text:
            raise ValueError(
                "%s is missing universal talent marker %s"
                % (label, marker)
            )
    for forbidden in (
        "set highest = master",
        "set target = master",
        "TT_TalentAbilityId(100 + tier * 3 +",
        "call TT_CampaignStore(",
        "call TT_CampaignRestore(",
        "function TT_CampaignStore takes",
        "function TT_CampaignRestore takes",
        "TT_CAMPAIGN_STATE_PENDING",
        "TT_CAMPAIGN_RESTORE_UNITS",
        "TT_RESTORE_TABLE",
        '"ALAS_TALENT",',
        "CAMPAIGN_FALLBACK_RESTORE",
    ):
        if forbidden in text:
            raise ValueError(
                "%s still contains forbidden legacy marker %s"
                % (label, forbidden)
            )
    if melee_hero_talents:
        for marker in (
            "TT_IsDemonHunter",
            "TT_DemonHunterNodeCode",
            "TT_UnitTalentId",
            "TT_DemonHunterOnManaBurnCast",
            "TT_DemonHunterOnManaBurnEffect",
            "DH_IMMOLATION_SYNC",
            "GetUnitAbilityLevel(u, 'BEim')",
            "TT_DemonHunterSync",
            "TT_DemonHunterOnOrder",
            "TT_PreserveTalentNodes",
            "TALENT_MASTER_RAISE",
        ):
            if marker not in text:
                raise ValueError(
                    "%s is missing demon hunter marker %s"
                    % (label, marker)
                )
    flag_true = (
        "TT_MELEE_HERO_TALENTS = true"
        if script_type == "lua"
        else "boolean TT_MELEE_HERO_TALENTS = true"
    )
    flag_false = (
        "TT_MELEE_HERO_TALENTS = false"
        if script_type == "lua"
        else "boolean TT_MELEE_HERO_TALENTS = false"
    )
    if melee_hero_talents and flag_true not in text:
        raise ValueError(
            "%s did not enable melee hero talents" % label
        )
    if not melee_hero_talents and flag_false not in text:
        raise ValueError(
            "%s did not disable melee hero talents" % label
        )
    if "damage * 0.85" not in text:
        raise ValueError(
            "%s is missing the exact 15%% talent damage reduction" % label
        )
    if "damage * 0.60" in text:
        raise ValueError(
            "%s still contains the obsolete 40%% talent damage reduction"
            % label
        )
    if script_type == "lua":
        markers = (
            "TT_RegisterHeroCore(u, false)",
            "TT_RegisterHeroCore(u, true)",
            "if (not TT_EnsureBackpack(u, heroIndex)) then",
            "GetPlayerController(p) == MAP_CONTROL_USER",
            "TT_EnsureHeroNow(u)",
            "TT_StartPointTimer()",
            "UnitRemoveAbility(u, talentId)",
            "GroupEnumUnitsSelected(g, p, nil)",
        )
    else:
        markers = (
            "return TT_RegisterHeroCore(u, false)",
            "TT_RegisterHeroCore(u, true)",
            "if not TT_EnsureBackpack(u, heroIndex) then",
            "GetPlayerController(p) == MAP_CONTROL_USER",
            "call TT_EnsureHeroNow(u)",
            "call TT_StartPointTimer()",
            "call UnitRemoveAbility(u, talentId)",
            "call GroupEnumUnitsSelected(g, p, null)",
        )
    for marker in markers:
        if marker not in text:
            raise ValueError(
                "%s is missing %s talent marker %s"
                % (label, script_type.upper(), marker)
            )


def _verify_archive(
    path: Path,
    level_cap: int,
    display_name: str,
    breakthrough_buff_id: str,
    melee_hero_talents: bool,
) -> None:
    archive = W.MPQArchive(str(path))
    try:
        ability_data = archive.read_file("war3map.w3a") or b""
        item_data = archive.read_file("war3map.w3t") or b""
        buff_data = archive.read_file("war3map.w3h") or b""
        info_data = archive.read_file("war3map.w3i") or b""
        lua_script = archive.read_file("war3map.lua") or b""
        jass_script = (
            archive.read_file("war3map.j")
            or archive.read_file(r"scripts\war3map.j")
            or archive.read_file(r"Scripts\war3map.j")
            or b""
        )
        script = lua_script or jass_script
        script_type = "lua" if lua_script else "jass"
    finally:
        archive.close()
    if not ability_data or not item_data or not buff_data or not script:
        raise ValueError(
            display_name + " is missing talent objects or script"
        )
    info = W3I.parse_or_tolerant(info_data)
    if (
        info.get("game_data_set"),
        info.get("game_data_version"),
    ) != (2, 2):
        raise ValueError(
            display_name + " is not using Reforged 2/2 game data"
        )
    abilities = _entries(ability_data, True)
    items = _entries(item_data, False)
    buffs = _entries(buff_data, False)
    for ident, base in (
        (TALENT.BREAKTHROUGH_SPEED_ID, "AIsx"),
        (TALENT.BREAKTHROUGH_STUN_ID, "AOws"),
        (TALENT.BREAKTHROUGH_STATUS_ID, "AOae"),
    ):
        if ident not in abilities or abilities[ident][0] != base:
            raise ValueError(
                display_name + ": " + ident
                + " is missing or is not based on " + base
            )
    if melee_hero_talents:
        for index in range(TALENT.HERO_POOL_SIZE):
            talent = TALENT.demon_hunter_talent_id(index)
            if talent not in abilities:
                raise ValueError(
                    display_name
                    + " is missing demon hunter talent "
                    + talent
                )
            master = _field_map(abilities[talent][1])
            if master.get("alev") != TALENT.TIER_COUNT:
                raise ValueError(
                    display_name + ": " + talent
                    + " has the wrong tier count"
                )
            for tier in range(TALENT.TIER_COUNT):
                if tier < TALENT.DEMON_HUNTER_TIER_COUNT:
                    expected = ",".join(
                        TALENT.demon_hunter_node_id(tier, choice)
                        for choice in range(
                            TALENT.CHOICES_PER_TIER
                        )
                    )
                else:
                    expected = ",".join(
                        TALENT.tier_node_id(tier, choice)
                        for choice in range(
                            TALENT.CHOICES_PER_TIER
                        )
                    )
                if master.get(("aabi", tier + 1)) != expected:
                    raise ValueError(
                        display_name + ": " + talent
                        + " has an invalid tier mapping"
                    )
        for index in range(
            TALENT.DEMON_HUNTER_TIER_COUNT
            * TALENT.CHOICES_PER_TIER
        ):
            ident = "DH%02X" % index
            if ident not in abilities or abilities[ident][0] != "AIst":
                raise ValueError(
                    display_name
                    + " is missing demon hunter node "
                    + ident
                )
        if (
            TALENT.DEMON_HUNTER_SPEED_ID not in abilities
            or abilities[TALENT.DEMON_HUNTER_SPEED_ID][0] != "AIsx"
        ):
            raise ValueError(
                display_name + " is missing demon hunter attack speed"
            )
    breakthrough_buff = breakthrough_buff_id
    if (
        breakthrough_buff not in buffs
        or buffs[breakthrough_buff][0] != "BOae"
    ):
        raise ValueError(
            display_name + ": " + breakthrough_buff
            + " is missing or is not based on BOae"
        )
    duplicate_buffs = _duplicate_object_ids(buff_data, False)
    if duplicate_buffs:
        raise ValueError(
            display_name + " contains duplicate status buff "
            + ", ".join(
                "%s x%d" % item
                for item in sorted(duplicate_buffs.items())
            )
        )
    speed_fields = _field_map(
        abilities[TALENT.BREAKTHROUGH_SPEED_ID][1]
    )
    for level in range(1, 7):
        actual = speed_fields.get(("Isx1", level))
        expected = (level - 1) * 0.10
        if actual is None or abs(float(actual) - expected) > 0.000001:
            raise ValueError(
                display_name + ": breakthrough speed level "
                + str(level) + " is incorrect"
            )
    stun_fields = _field_map(
        abilities[TALENT.BREAKTHROUGH_STUN_ID][1]
    )
    for field, expected in (
        ("aare", 250.0),
        ("Wrs1", 0.0),
        ("adur", 1.5),
        ("ahdu", 1.5),
    ):
        actual = stun_fields.get((field, 1))
        if actual is None or abs(float(actual) - expected) > 0.000001:
            raise ValueError(
                display_name + ": breakthrough stomp "
                + field + " is incorrect"
            )
    status_fields = _field_map(
        abilities[TALENT.BREAKTHROUGH_STATUS_ID][1]
    )
    for level in range(1, 6):
        if status_fields.get(("abuf", level)) != breakthrough_buff:
            raise ValueError(
                display_name + ": breakthrough status level "
                + str(level) + " uses the wrong buff"
            )
    buff_fields = _field_map(buffs[breakthrough_buff][1])
    if (
        buff_fields.get("fnam") != "破势"
        or buff_fields.get("ftip") != "破势"
        or not buff_fields.get("fube")
        or not buff_fields.get("fart")
    ):
        raise ValueError(
            display_name + ": " + breakthrough_buff
            + " has incomplete status text or icon"
        )
    tier5_contracts = {
        "T112": (
            "AHss",
            {"Ssk1": 0.0, "Ssk2": 0.0, "Ssk3": 0.0},
            "\u91d1\u521a\u4e0d\u574f",
            "\u53d7\u5230\u7684\u6240\u6709\u4f24\u5bb3 -15%\u3002",
        ),
        "T113": (
            "AOcr",
            {"Ocr1": 25.0, "Ocr2": 2.0},
            "\u81f4\u547d\u950b\u8292",
            "\u666e\u901a\u653b\u51fb\u6709 25% \u6982\u7387"
            "\u9020\u6210 2 \u500d\u4f24\u5bb3\u3002",
        ),
        "T114": (
            "AEev",
            {"Eev1": 0.25},
            "\u9b3c\u5f71\u8ff7\u8e2a",
            "\u666e\u901a\u653b\u51fb\u6709 25% \u6982\u7387"
            "\u88ab\u95ea\u907f\u3002",
        ),
    }
    for ident, (base, numbers, name, description) in (
        tier5_contracts.items()
    ):
        if ident not in abilities or abilities[ident][0] != base:
            raise ValueError(
                display_name + ": " + ident
                + " is missing or is not based on " + base
            )
        fields = _field_map(abilities[ident][1])
        for field, expected in numbers.items():
            actual = fields.get((field, 1))
            if (
                actual is None
                or abs(float(actual) - expected) > 0.000001
            ):
                raise ValueError(
                    display_name + ": " + ident + "." + field
                    + " is not " + str(expected)
                )
        if fields.get("atp1") != name:
            raise ValueError(
                display_name + ": " + ident
                + " has the wrong talent name"
            )
        if fields.get("aub1") != description:
            raise ValueError(
                display_name + ": " + ident
                + " has a mismatched description"
            )
    for ident in ("I103", "I105", "I106"):
        if ident not in items:
            raise ValueError(
                display_name + " is missing artifact " + ident
            )
    for index in range(TALENT.HERO_POOL_SIZE):
        for _mode in (False,):
            talent = TALENT.talent_pool_id(index)
            backpack = TALENT.backpack_pool_id(index)
            if talent not in abilities or backpack not in items:
                raise ValueError(
                    display_name + " is missing talent pair " + talent
                )
            master = _field_map(abilities[talent][1])
            if master.get("alev") != TALENT.TIER_COUNT:
                raise ValueError(
                    display_name + ": " + talent
                    + " has the wrong tier count"
                )
            for tier in range(TALENT.TIER_COUNT):
                expected = ",".join(
                    TALENT.tier_node_id(tier, choice)
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
    _verify_script(
        script,
        level_cap,
        display_name,
        script_type,
        melee_hero_talents,
    )


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
                        bundle.breakthrough_buff_id,
                        bundle.melee_hero_talents,
                    )
                finally:
                    temp.unlink(missing_ok=True)
        finally:
            outer.close()
        return
    level_cap = next(iter(bundle.chapter_levels.values()))
    _verify_archive(
        output,
        level_cap,
        output.name,
        bundle.breakthrough_buff_id,
        bundle.melee_hero_talents,
    )
