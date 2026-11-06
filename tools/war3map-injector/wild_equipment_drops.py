"""Prepare and verify neutral-hostile wild equipment drops."""

from __future__ import annotations

import json
import re
import sys
import tempfile
from dataclasses import dataclass
from pathlib import Path


HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
DOCTOR = ROOT / "tools" / "_devos-map-doctor" / "devos-map-doctor-main"
CATALOG = ROOT / "tools" / "alas-offline" / "assets" / "game_item_equipment.tsv"
UNIT_CATALOG = ROOT / "tools" / "alas-offline" / "assets" / "game_unit_stats.tsv"
sys.path.insert(0, str(HERE))
sys.path.insert(0, str(DOCTOR))

import war3mpq as W  # noqa: E402
from doctor.data import objects as DOBJ  # noqa: E402
from doctor.fix import inflated_counts as INFLATED  # noqa: E402


POOL_NAMES = {
    "white": ("WED_POOL_WHITE", 1, 2),
    "green": ("WED_POOL_GREEN", 3, 4),
    "blue": ("WED_POOL_BLUE", 5, 6),
    "purple": ("WED_POOL_PURPLE", 7, 7),
    "orange": ("WED_POOL_ORANGE", 8, 8),
}

# The candle is an orange-coloured joke item with no gameplay ability.
# ALAS artifacts and wings are talent rewards and must never enter this pool.
EXCLUDED_IDS = {
    "I100", "I101", "I102", "I103", "I104", "I105", "I106",
}


@dataclass(frozen=True)
class WildDropBundle:
    script_dir: Path
    counts: dict[str, int]
    level_cap: int


@dataclass(frozen=True)
class CampaignDropProfile:
    chapter: str
    chapter_index: int
    chapter_count: int
    level_cap: int
    hero_level_cap: int
    chapter_progress: int
    counts: dict[str, int]
    script_dir: Path


@dataclass(frozen=True)
class CampaignDropBundle:
    root: Path
    manifest: Path
    profiles: tuple[CampaignDropProfile, ...]

    def profile_for(self, chapter: str) -> CampaignDropProfile | None:
        return next(
            (
                profile
                for profile in self.profiles
                if profile.chapter == chapter
            ),
            None,
        )


def _text(value: object) -> str:
    if isinstance(value, bytes):
        return value.decode("utf-8", "replace")
    return str(value)


def _read_catalog() -> dict[str, dict[str, object]]:
    if not CATALOG.is_file():
        raise ValueError("wild drops: game equipment catalog is missing")
    rows: dict[str, dict[str, object]] = {}
    for line in CATALOG.read_text(encoding="utf-8").splitlines():
        if not line or line.startswith("#"):
            continue
        parts = line.split("\t")
        if len(parts) != 5:
            raise ValueError("wild drops: malformed game equipment catalog")
        ident, item_class, level, droppable, abilities = parts
        rows[ident] = {
            "class": item_class,
            "level": level,
            "droppable": droppable,
            "abilities": abilities,
        }
    if not rows:
        raise ValueError("wild drops: game equipment catalog is empty")
    return rows


def _overlay_map_items(
    rows: dict[str, dict[str, object]],
    source: Path,
) -> None:
    archive = W.MPQArchive(str(source))
    try:
        item_data = archive.read_file("war3map.w3t") or b""
    finally:
        archive.close()
    if not item_data:
        return
    _version, entries, _consumed = DOBJ.read_objects_bytes(
        item_data,
        False,
        fname="war3map.w3t",
        with_end=True,
    )
    for _table, old, new, mods in entries:
        old_id = old.replace("\0", "")
        new_id = new.replace("\0", "") or old_id
        base = rows.get(old_id) or rows.get(new_id)
        if base is None:
            continue
        row = dict(base)
        for mod in mods:
            field = mod[0]
            value = _text(mod[4])
            if field == "icla":
                row["class"] = value
            elif field == "ilev":
                row["level"] = str(mod[4])
            elif field == "idro":
                row["droppable"] = str(mod[4])
            elif field == "iabi":
                row["abilities"] = value
        rows[new_id] = row


def _read_unit_catalog() -> dict[str, dict[str, object]]:
    if not UNIT_CATALOG.is_file():
        raise ValueError("wild drops: game unit catalog is missing")
    rows: dict[str, dict[str, object]] = {}
    for line in UNIT_CATALOG.read_text(encoding="utf-8").splitlines():
        if not line or line.startswith("#"):
            continue
        parts = line.split("\t")
        if len(parts) != 5:
            raise ValueError("wild drops: malformed game unit catalog")
        ident, level, race, is_building, unit_type = parts
        rows[ident] = {
            "level": level,
            "race": race,
            "building": is_building,
            "type": unit_type,
        }
    if not rows:
        raise ValueError("wild drops: game unit catalog is empty")
    return rows


def _overlay_map_units(
    rows: dict[str, dict[str, object]],
    source: Path,
) -> set[str]:
    archive = W.MPQArchive(str(source))
    try:
        unit_data = archive.read_file("war3map.w3u") or b""
    finally:
        archive.close()
    if not unit_data:
        return set()
    _version, entries, _consumed = DOBJ.read_objects_bytes(
        unit_data,
        False,
        fname="war3map.w3u",
        with_end=True,
    )
    changed: set[str] = set()
    for _table, old, new, mods in entries:
        old_id = old.replace("\0", "")
        new_id = new.replace("\0", "") or old_id
        base = rows.get(old_id) or rows.get(new_id)
        if base is None:
            continue
        row = dict(base)
        for mod in mods:
            field = mod[0]
            value = _text(mod[4])
            if field == "ulev":
                row["level"] = value
            elif field == "urac":
                row["race"] = value
            elif field == "ubdg":
                row["building"] = value
        rows[new_id] = row
        changed.add(new_id)
    return changed


def _misc_level_cap(source: Path) -> int:
    archive = W.MPQArchive(str(source))
    try:
        data = archive.read_file("war3mapMisc.txt") or b""
    finally:
        archive.close()
    if not data:
        return 10
    text = None
    for encoding in ("utf-8-sig", "gbk", "latin-1"):
        try:
            text = data.decode(encoding)
            break
        except UnicodeDecodeError:
            continue
    if text is None:
        return 10
    section = ""
    for line in text.splitlines():
        stripped = line.strip()
        if stripped.startswith("[") and stripped.endswith("]"):
            section = stripped[1:-1].strip().lower()
            continue
        if section == "misc" and "=" in stripped:
            key, value = stripped.split("=", 1)
            if key.strip().lower() == "maxherolevel":
                try:
                    return max(1, int(float(value.strip())))
                except ValueError:
                    return 10
    return 10


def _neutral_level_cap(source: Path) -> int:
    units = _read_unit_catalog()
    custom_ids = _overlay_map_units(units, source)
    archive = W.MPQArchive(str(source))
    try:
        placed_data = archive.read_file("war3mapUnits.doo") or b""
    finally:
        archive.close()
    placed_levels: list[int] = []
    if placed_data:
        parsed = INFLATED.read_units_doo(placed_data)
        if parsed.get("on_close"):
            records = parsed["regs"]
            owners = {int(record.get("owner", -1)) for record in records}
            hostile_owner = 24 if any(owner >= 24 for owner in owners) else 12
            for record in records:
                if int(record.get("owner", -1)) != hostile_owner:
                    continue
                ident = bytes(record.get("ident", b"")).decode(
                    "latin-1",
                    "replace",
                )
                if len(ident) != 4 or ident[0].isupper():
                    continue
                row = units.get(ident)
                if row is None or _text(row.get("building", "0")) == "1":
                    continue
                try:
                    level = int(_text(row.get("level", "0")))
                except ValueError:
                    continue
                if level > 0:
                    placed_levels.append(level)
    custom_levels: list[int] = []
    for ident in custom_ids:
        row = units.get(ident, {})
        if _text(row.get("race", "")) != "creeps":
            continue
        if _text(row.get("building", "0")) == "1":
            continue
        try:
            level = int(_text(row.get("level", "0")))
        except ValueError:
            continue
        if level > 0:
            custom_levels.append(level)
    candidates = placed_levels + custom_levels
    if candidates:
        return max(candidates)
    return _misc_level_cap(source)


def _hero_level_cap(source: Path) -> int:
    units = _read_unit_catalog()
    _overlay_map_units(units, source)
    archive = W.MPQArchive(str(source))
    try:
        placed_data = archive.read_file("war3mapUnits.doo") or b""
    finally:
        archive.close()
    levels = [_misc_level_cap(source)]
    if placed_data:
        parsed = INFLATED.read_units_doo(placed_data)
        if parsed.get("on_close"):
            for record in parsed["regs"]:
                ident = bytes(record.get("ident", b"")).decode(
                    "latin-1",
                    "replace",
                )
                if len(ident) != 4 or not ident[0].isupper():
                    continue
                row = units.get(ident)
                if row is None or _text(row.get("building", "0")) == "1":
                    continue
                try:
                    level = int(_text(row.get("level", "0")))
                except ValueError:
                    continue
                if level > 0:
                    levels.append(level)
    return max(levels)


def hero_level_cap(source: Path) -> int:
    """Return the effective map hero-level ceiling used by optional systems."""
    return _hero_level_cap(source)


def collect_pools(source: Path) -> dict[str, list[str]]:
    rows = _read_catalog()
    _overlay_map_items(rows, source)
    pools = {name: [] for name in POOL_NAMES}
    for ident, row in rows.items():
        if not re.fullmatch(r"[0-9A-Za-z]{4}", ident):
            continue
        if ident in EXCLUDED_IDS:
            continue
        if _text(row.get("class", "")) != "Equipment":
            continue
        if _text(row.get("droppable", "1")) == "0":
            continue
        abilities = _text(row.get("abilities", "")).strip()
        if not abilities or abilities == "_":
            continue
        try:
            level = int(_text(row.get("level", "0")))
        except ValueError:
            continue
        for name, (_array_name, minimum, maximum) in POOL_NAMES.items():
            if minimum <= level <= maximum:
                pools[name].append(ident)
                break
    for pool in pools.values():
        pool.sort()
    expected = {
        "white": 53,
        "green": 102,
        "blue": 98,
        "purple": 64,
        "orange": 7,
    }
    for name, pool in pools.items():
        if pool != sorted(pool):
            raise ValueError(
                "wild drops: %s pool is not deterministically sorted" % name
            )
    for name, minimum in expected.items():
        if len(pools[name]) < minimum:
            raise ValueError(
                "wild drops: %s pool has %d items, expected at least %d"
                % (name, len(pools[name]), minimum)
            )
    if "eauc" in {ident for pool in pools.values() for ident in pool}:
        raise ValueError("wild drops: joke candle must not enter a pool")
    return pools


def _pool_globals(
    counts: dict[str, int],
    level_cap: int,
    campaign: CampaignDropProfile | None = None,
) -> str:
    lines = [
        "integer array WED_POOL_WHITE",
        "integer array WED_POOL_GREEN",
        "integer array WED_POOL_BLUE",
        "integer array WED_POOL_PURPLE",
        "integer array WED_POOL_ORANGE",
    ]
    for name, (array_name, _minimum, _maximum) in POOL_NAMES.items():
        lines.append("integer %s_COUNT = %d" % (array_name, counts[name]))
    lines.extend([
        "integer WED_LEVEL_CAP = %d" % level_cap,
        "boolean WED_CAMPAIGN_MODE = %s"
        % ("true" if campaign is not None else "false"),
        "boolean WED_INITED = false",
        "trigger WED_DROP_TRIGGER = null",
    ])
    if campaign is not None:
        lines.extend([
            "integer WED_HERO_LEVEL_CAP = %d" % campaign.hero_level_cap,
            "integer WED_CHAPTER_PROGRESS = %d"
            % campaign.chapter_progress,
            "hashtable WED_HERO_DROPS = null",
        ])
    return "\n".join(lines) + "\n"


def _pool_assignments(text: str, pools: dict[str, list[str]]) -> str:
    for name, (array_name, _minimum, _maximum) in POOL_NAMES.items():
        for index, ident in enumerate(pools[name]):
            text += "    set %s[%d] = '%s'\n" % (
                array_name,
                index,
                ident,
            )
    return text


def _script_functions(pools: dict[str, list[str]]) -> str:
    assignments = ""
    for name, (array_name, _minimum, _maximum) in POOL_NAMES.items():
        assignments += "    set %s_COUNT = %d\n" % (
            array_name,
            len(pools[name]),
        )
    assignments = _pool_assignments(assignments, pools)
    return r"""function WED_InitPools takes nothing returns nothing
%s
endfunction

function WED_Tier takes unit victim returns integer
    local integer level = IMaxBJ(GetUnitLevel(victim), 1)
    local integer band
    if WED_LEVEL_CAP <= 1 then
        return 5
    endif
    set band = ((level - 1) * 5) / WED_LEVEL_CAP
    if band < 0 then
        set band = 0
    elseif band > 4 then
        set band = 4
    endif
    return band + 1
endfunction

function WED_OrangeChance takes integer level returns integer
    local real progress
    local integer chance
    if WED_LEVEL_CAP <= 1 then
        return 20
    endif
    set progress = I2R(level - 1) / I2R(WED_LEVEL_CAP - 1)
    set chance = R2I((progress - 0.8) * 100.0 + 0.5)
    if chance < 5 then
        return 5
    endif
    if chance > 20 then
        return 20
    endif
    return chance
endfunction

function WED_ValidKiller takes unit killer returns boolean
    local player owner
    if killer == null then
        return false
    endif
    set owner = GetOwningPlayer(killer)
    return GetPlayerController(owner) == MAP_CONTROL_USER and GetPlayerSlotState(owner) == PLAYER_SLOT_STATE_PLAYING
endfunction

function WED_CreateDrop takes integer tier, real x, real y returns nothing
    local integer ident = 0
    if tier == 1 then
        set ident = WED_POOL_WHITE[GetRandomInt(0, WED_POOL_WHITE_COUNT - 1)]
    elseif tier == 2 then
        set ident = WED_POOL_GREEN[GetRandomInt(0, WED_POOL_GREEN_COUNT - 1)]
    elseif tier == 3 then
        set ident = WED_POOL_BLUE[GetRandomInt(0, WED_POOL_BLUE_COUNT - 1)]
    elseif tier == 4 then
        set ident = WED_POOL_PURPLE[GetRandomInt(0, WED_POOL_PURPLE_COUNT - 1)]
    else
        set ident = WED_POOL_ORANGE[GetRandomInt(0, WED_POOL_ORANGE_COUNT - 1)]
    endif
    if ident != 0 then
        call CreateItem(ident, x, y)
    endif
endfunction

function WED_OnDeath takes nothing returns nothing
    local unit victim = GetTriggerUnit()
    local unit killer = GetKillingUnit()
    local integer tier
    local integer chance
    local real x
    local real y
    if victim != null and GetUnitTypeId(victim) != 0 and GetOwningPlayer(victim) == Player(PLAYER_NEUTRAL_AGGRESSIVE) then
        if not IsUnitType(victim, UNIT_TYPE_HERO) and not IsUnitType(victim, UNIT_TYPE_STRUCTURE) and not IsUnitType(victim, UNIT_TYPE_SUMMONED) and not IsUnitIllusion(victim) and WED_ValidKiller(killer) then
            set tier = WED_Tier(victim)
            set x = GetUnitX(victim) + GetRandomReal(32.0, 64.0) * Cos(GetRandomReal(0.0, 360.0) * bj_DEGTORAD)
            set y = GetUnitY(victim) + GetRandomReal(32.0, 64.0) * Sin(GetRandomReal(0.0, 360.0) * bj_DEGTORAD)
            if tier == 5 then
                call WED_CreateDrop(4, x, y)
                if GetRandomInt(1, 100) <= WED_OrangeChance(GetUnitLevel(victim)) then
                    call WED_CreateDrop(5, x + 48.0, y)
                endif
            else
                if tier == 1 then
                    set chance = 5
                elseif tier == 2 then
                    set chance = 12
                elseif tier == 3 then
                    set chance = 35
                else
                    set chance = 65
                endif
                if GetRandomInt(1, 100) <= chance then
                    call WED_CreateDrop(tier, x, y)
                endif
            endif
        endif
    endif
    set victim = null
    set killer = null
endfunction

function WED_Init takes nothing returns nothing
    if WED_INITED then
        return
    endif
    set WED_INITED = true
    call WED_InitPools()
    set WED_DROP_TRIGGER = CreateTrigger()
    call TriggerRegisterPlayerUnitEvent(WED_DROP_TRIGGER, Player(PLAYER_NEUTRAL_AGGRESSIVE), EVENT_PLAYER_UNIT_DEATH, null)
    call TriggerAddAction(WED_DROP_TRIGGER, function WED_OnDeath)
    call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "|cff32cd32[野怪掉落]|r 已启用：仅中立敌对野怪掉落装备，等级上限 " + I2S(WED_LEVEL_CAP) + "，首领可追加橙装。")
    set WED_DROP_TRIGGER = null
endfunction
""" % assignments


def _campaign_script_functions(
    pools: dict[str, list[str]],
    profile: CampaignDropProfile,
) -> str:
    common = _script_functions(pools).split(
        "function WED_OnDeath",
        1,
    )[0]
    return common + r"""function WED_HeroTier takes unit victim returns integer
    local integer level = IMaxBJ(GetUnitLevel(victim), 1)
    local integer band
    local integer floorTier
    if WED_HERO_LEVEL_CAP <= 1 then
        return 4
    endif
    set band = ((level - 1) * 5) / WED_HERO_LEVEL_CAP
    if band < 0 then
        set band = 0
    elseif band > 4 then
        set band = 4
    endif
    set floorTier = 2 + (WED_CHAPTER_PROGRESS * 3) / 100
    if floorTier > 4 then
        set floorTier = 4
    endif
    if band + 1 < floorTier then
        return floorTier
    endif
    if band + 1 > 4 then
        return 4
    endif
    return band + 1
endfunction

function WED_HeroOrangeChance takes nothing returns integer
    return IMinBJ(20, 5 + (WED_CHAPTER_PROGRESS * 15 + 50) / 100)
endfunction

function WED_IsEnemyHeroTarget takes unit victim, unit killer returns boolean
    local player victimOwner
    local player killerOwner
    if victim == null or killer == null then
        return false
    endif
    if not IsUnitType(victim, UNIT_TYPE_HERO) or IsUnitType(victim, UNIT_TYPE_STRUCTURE) or IsUnitType(victim, UNIT_TYPE_SUMMONED) or IsUnitIllusion(victim) then
        return false
    endif
    if not WED_ValidKiller(killer) then
        return false
    endif
    set victimOwner = GetOwningPlayer(victim)
    set killerOwner = GetOwningPlayer(killer)
    if GetPlayerId(victimOwner) == GetPlayerId(killerOwner) then
        return false
    endif
    if not IsUnitEnemy(victim, killerOwner) then
        return false
    endif
    if GetPlayerId(victimOwner) == PLAYER_NEUTRAL_AGGRESSIVE then
        return true
    endif
    return GetPlayerController(victimOwner) == MAP_CONTROL_COMPUTER
endfunction

function WED_OnDeath takes nothing returns nothing
    local unit victim = GetTriggerUnit()
    local unit killer = GetKillingUnit()
    local player victimOwner
    local integer heroId
    local integer tier
    local integer chance
    local real x
    local real y
    if victim == null or GetUnitTypeId(victim) == 0 then
        set victim = null
        set killer = null
        return
    endif
    set victimOwner = GetOwningPlayer(victim)
    if IsUnitType(victim, UNIT_TYPE_HERO) then
        if WED_IsEnemyHeroTarget(victim, killer) then
            set heroId = GetUnitTypeId(victim)
            if not HaveSavedInteger(WED_HERO_DROPS, 0, heroId) then
                call SaveInteger(WED_HERO_DROPS, 0, heroId, 1)
                set tier = WED_HeroTier(victim)
                set x = GetUnitX(victim) + GetRandomReal(32.0, 64.0) * Cos(GetRandomReal(0.0, 360.0) * bj_DEGTORAD)
                set y = GetUnitY(victim) + GetRandomReal(32.0, 64.0) * Sin(GetRandomReal(0.0, 360.0) * bj_DEGTORAD)
                call WED_CreateDrop(tier, x, y)
                if GetRandomInt(1, 100) <= WED_HeroOrangeChance() then
                    call WED_CreateDrop(5, x + 48.0, y)
                endif
            endif
        endif
    elseif victimOwner == Player(PLAYER_NEUTRAL_AGGRESSIVE) then
        if not IsUnitType(victim, UNIT_TYPE_STRUCTURE) and not IsUnitType(victim, UNIT_TYPE_SUMMONED) and not IsUnitIllusion(victim) and WED_ValidKiller(killer) then
            set tier = WED_Tier(victim)
            set x = GetUnitX(victim) + GetRandomReal(32.0, 64.0) * Cos(GetRandomReal(0.0, 360.0) * bj_DEGTORAD)
            set y = GetUnitY(victim) + GetRandomReal(32.0, 64.0) * Sin(GetRandomReal(0.0, 360.0) * bj_DEGTORAD)
            if tier == 5 then
                call WED_CreateDrop(4, x, y)
                if GetRandomInt(1, 100) <= WED_OrangeChance(GetUnitLevel(victim)) then
                    call WED_CreateDrop(5, x + 48.0, y)
                endif
            else
                if tier == 1 then
                    set chance = 5
                elseif tier == 2 then
                    set chance = 12
                elseif tier == 3 then
                    set chance = 35
                else
                    set chance = 65
                endif
                if GetRandomInt(1, 100) <= chance then
                    call WED_CreateDrop(tier, x, y)
                endif
            endif
        endif
    endif
    set victim = null
    set killer = null
endfunction

function WED_Init takes nothing returns nothing
    if WED_INITED then
        return
    endif
    set WED_INITED = true
    call WED_InitPools()
    set WED_HERO_DROPS = InitHashtable()
    set WED_DROP_TRIGGER = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(WED_DROP_TRIGGER, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddAction(WED_DROP_TRIGGER, function WED_OnDeath)
    call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "|cff32cd32[战役掉落]|r 已启用：野怪最高 " + I2S(WED_LEVEL_CAP) + " 级，敌英雄最高 " + I2S(WED_HERO_LEVEL_CAP) + " 级，章节进度 " + I2S(WED_CHAPTER_PROGRESS) + "%。")
    set WED_DROP_TRIGGER = null
endfunction
"""


def prepare_bundle(source: Path, work: Path) -> WildDropBundle:
    pools = collect_pools(source)
    level_cap = _neutral_level_cap(source)
    counts = {name: len(pool) for name, pool in pools.items()}
    script_dir = work / "script"
    script_dir.mkdir(parents=True, exist_ok=True)
    (script_dir / "g.j").write_text(
        _pool_globals(counts, level_cap),
        encoding="utf-8",
    )
    (script_dir / "f.j").write_text(
        _script_functions(pools),
        encoding="utf-8",
    )
    (script_dir / "m.j").write_text(
        "call WED_Init()\n",
        encoding="utf-8",
    )
    return WildDropBundle(
        script_dir=script_dir,
        counts=counts,
        level_cap=level_cap,
    )


def prepare_campaign_bundle(
    source: Path,
    work: Path,
    chapters: list[str],
) -> CampaignDropBundle:
    if not chapters:
        raise ValueError("campaign drops: campaign has no chapters")
    root = work
    root.mkdir(parents=True, exist_ok=True)
    archive = W.MPQArchive(str(source))
    profiles: list[CampaignDropProfile] = []
    try:
        with tempfile.TemporaryDirectory() as temp_name:
            temp_root = Path(temp_name)
            for index, chapter in enumerate(chapters):
                data = archive.read_file(chapter)
                if not data:
                    raise ValueError(
                        "campaign drops: cannot read chapter " + chapter
                    )
                chapter_path = temp_root / (
                    "%02d-%s" % (index + 1, Path(chapter).name)
                )
                chapter_path.write_bytes(data)
                pools = collect_pools(chapter_path)
                level_cap = _neutral_level_cap(chapter_path)
                hero_level_cap = _hero_level_cap(chapter_path)
                progress = (
                    0
                    if len(chapters) == 1
                    else round(index * 100 / (len(chapters) - 1))
                )
                counts = {
                    name: len(pool)
                    for name, pool in pools.items()
                }
                safe_name = re.sub(
                    r"[^0-9A-Za-z._-]+",
                    "_",
                    Path(chapter).stem,
                )
                script_dir = root / ("%02d-%s" % (index + 1, safe_name))
                script_dir.mkdir(parents=True, exist_ok=True)
                profile = CampaignDropProfile(
                    chapter=chapter,
                    chapter_index=index + 1,
                    chapter_count=len(chapters),
                    level_cap=level_cap,
                    hero_level_cap=hero_level_cap,
                    chapter_progress=progress,
                    counts=counts,
                    script_dir=script_dir,
                )
                (script_dir / "g.j").write_text(
                    _pool_globals(counts, level_cap, profile),
                    encoding="utf-8",
                )
                (script_dir / "f.j").write_text(
                    _campaign_script_functions(pools, profile),
                    encoding="utf-8",
                )
                (script_dir / "m.j").write_text(
                    "call WED_Init()\n",
                    encoding="utf-8",
                )
                profiles.append(profile)
    finally:
        archive.close()
    manifest = root / "manifest.json"
    manifest.write_text(
        json.dumps(
            {
                "source": str(source),
                "chapters": [
                    {
                        "chapter": profile.chapter,
                        "chapter_index": profile.chapter_index,
                        "chapter_count": profile.chapter_count,
                        "level_cap": profile.level_cap,
                        "hero_level_cap": profile.hero_level_cap,
                        "chapter_progress": profile.chapter_progress,
                        "counts": profile.counts,
                        "script_dir": str(profile.script_dir),
                    }
                    for profile in profiles
                ],
            },
            ensure_ascii=False,
            indent=2,
        )
        + "\n",
        encoding="utf-8",
    )
    return CampaignDropBundle(
        root=root,
        manifest=manifest,
        profiles=tuple(profiles),
    )


def load_campaign_manifest(manifest: Path) -> CampaignDropBundle:
    data = json.loads(manifest.read_text(encoding="utf-8"))
    profiles = tuple(
        CampaignDropProfile(
            chapter=str(item["chapter"]),
            chapter_index=int(item["chapter_index"]),
            chapter_count=int(item["chapter_count"]),
            level_cap=int(item["level_cap"]),
            hero_level_cap=int(item["hero_level_cap"]),
            chapter_progress=int(item["chapter_progress"]),
            counts={
                str(name): int(count)
                for name, count in item["counts"].items()
            },
            script_dir=Path(item["script_dir"]).resolve(),
        )
        for item in data.get("chapters", ())
    )
    if not profiles:
        raise ValueError("campaign drops: loot manifest is empty")
    return CampaignDropBundle(
        root=manifest.resolve().parent,
        manifest=manifest.resolve(),
        profiles=profiles,
    )


def _script_from_output(output: Path) -> str:
    archive = W.MPQArchive(str(output))
    try:
        data = (
            archive.read_file("war3map.j")
            or archive.read_file(r"scripts\war3map.j")
            or archive.read_file(r"Scripts\war3map.j")
            or b""
        )
    finally:
        archive.close()
    if not data:
        raise ValueError("wild drops: output map has no JASS script")
    return data.decode("utf-8", "replace")


def verify_bundle(output: Path) -> None:
    script = _script_from_output(output)
    required = (
        "function WED_Init takes",
        "call TriggerRegisterPlayerUnitEvent(WED_DROP_TRIGGER, Player(PLAYER_NEUTRAL_AGGRESSIVE), EVENT_PLAYER_UNIT_DEATH, null)",
        "GetOwningPlayer(victim) == Player(PLAYER_NEUTRAL_AGGRESSIVE)",
        "GetPlayerController(owner) == MAP_CONTROL_USER",
        "IsUnitType(victim, UNIT_TYPE_STRUCTURE)",
        "IsUnitType(victim, UNIT_TYPE_SUMMONED)",
        "IsUnitIllusion(victim)",
        "set band = ((level - 1) * 5) / WED_LEVEL_CAP",
        "function WED_OrangeChance takes integer level returns integer",
    )
    for marker in required:
        if marker not in script:
            raise ValueError("wild drops: missing runtime marker " + marker)
    if (
        "call WED_Init()" not in script
        and "function WED_Init)" not in script
    ):
        raise ValueError("wild drops: WED_Init is not entered")
    neutral_registration = (
        "TriggerRegisterPlayerUnitEvent(WED_DROP_TRIGGER, "
        "Player(PLAYER_NEUTRAL_AGGRESSIVE), "
        "EVENT_PLAYER_UNIT_DEATH, null)"
    )
    if script.count(neutral_registration) != 1:
        raise ValueError(
            "wild drops: neutral death trigger must be registered exactly once"
        )
    tier_start = script.find("function WED_Tier takes")
    tier_end = script.find("endfunction", tier_start)
    tier_body = (
        script[tier_start:tier_end]
        if tier_start >= 0 and tier_end >= 0
        else ""
    )
    if (
        "UNIT_STATE_MAX_LIFE" in tier_body
        or "GetUnitState(" in tier_body
    ):
        raise ValueError(
            "wild drops: tier selection still uses non-level state"
        )
    cap_match = re.search(r"integer WED_LEVEL_CAP = (\d+)", script)
    if cap_match is None or int(cap_match.group(1)) < 1:
        raise ValueError("wild drops: neutral level cap is missing or invalid")
    arrays = {
        name: re.findall(
            r"set %s\[\d+\] = '([0-9A-Za-z]{4})'"
            % re.escape(array_name),
            script,
        )
        for name, (array_name, _minimum, _maximum) in POOL_NAMES.items()
    }
    for name, values in arrays.items():
        if not values:
            raise ValueError("wild drops: empty " + name + " pool")
        array_name = POOL_NAMES[name][0]
        count_match = re.search(
            r"integer %s_COUNT = (\d+)" % re.escape(array_name),
            script,
        )
        if count_match is None or int(count_match.group(1)) != len(values):
            raise ValueError(
                "wild drops: %s count does not match its item array" % name
            )
    if len(arrays["orange"]) != 7:
        raise ValueError(
            "wild drops: expected exactly seven gameplay orange items"
        )
    all_ids = {ident for values in arrays.values() for ident in values}
    if all_ids & EXCLUDED_IDS or "eauc" in all_ids:
        raise ValueError("wild drops: exclusive artifact or candle leaked")


def _campaign_script_from_chapter(
    chapter_data: bytes,
    script_type: str,
) -> str:
    with tempfile.TemporaryDirectory() as temp_name:
        chapter_path = Path(temp_name) / "chapter.w3x"
        chapter_path.write_bytes(chapter_data)
        archive = W.MPQArchive(str(chapter_path))
        try:
            if script_type == "lua":
                data = (
                    archive.read_file("war3map.lua")
                    or archive.read_file(r"scripts\war3map.lua")
                    or archive.read_file(r"Scripts\war3map.lua")
                    or b""
                )
            else:
                data = (
                    archive.read_file("war3map.j")
                    or archive.read_file(r"scripts\war3map.j")
                    or archive.read_file(r"Scripts\war3map.j")
                    or b""
                )
        finally:
            archive.close()
    if not data:
        raise ValueError(
            "campaign drops: chapter has no %s script" % script_type
        )
    return data.decode("utf-8", "replace")


def verify_campaign_bundle(
    output: Path,
    bundle: CampaignDropBundle,
    script_type: str,
) -> None:
    archive = W.MPQArchive(str(output))
    try:
        for profile in bundle.profiles:
            data = archive.read_file(profile.chapter)
            if not data:
                raise ValueError(
                    "campaign drops: output chapter missing: "
                    + profile.chapter
                )
            script = _campaign_script_from_chapter(data, script_type)
            required = (
                "function WED_Init",
                "WED_CAMPAIGN_MODE = true",
                "function WED_IsEnemyHeroTarget",
                "TriggerRegisterAnyUnitEventBJ",
                "WED_HERO_DROPS",
                "HaveSavedInteger",
                "SaveInteger",
            )
            for marker in required:
                if marker not in script:
                    raise ValueError(
                        "campaign drops: %s missing %s"
                        % (profile.chapter, marker)
                    )
            if script_type == "lua":
                level_cap = re.search(
                    r"WED_LEVEL_CAP = %d\b" % profile.level_cap,
                    script,
                )
                hero_cap = re.search(
                    r"WED_HERO_LEVEL_CAP = %d\b"
                    % profile.hero_level_cap,
                    script,
                )
                progress = re.search(
                    r"WED_CHAPTER_PROGRESS = %d\b"
                    % profile.chapter_progress,
                    script,
                )
            else:
                level_cap = re.search(
                    r"integer WED_LEVEL_CAP = %d\b"
                    % profile.level_cap,
                    script,
                )
                hero_cap = re.search(
                    r"integer WED_HERO_LEVEL_CAP = %d\b"
                    % profile.hero_level_cap,
                    script,
                )
                progress = re.search(
                    r"integer WED_CHAPTER_PROGRESS = %d\b"
                    % profile.chapter_progress,
                    script,
                )
            if level_cap is None or hero_cap is None or progress is None:
                raise ValueError(
                    "campaign drops: %s profile constants mismatch"
                    % profile.chapter
                )
    finally:
        archive.close()
