#!/usr/bin/env python3
"""Port only the item/skill browser and three custom weapons to Forsaken 3.0.1.

The target is a Reforged Lua campaign with per-chapter object data.  This tool
does not copy wings, mounts, task fixes, save repair, pet fixes, or other
iteration artifacts from the older campaign build.
"""

from __future__ import annotations

import argparse
import io
import os
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

from PIL import Image, ImageOps

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
DOCTOR = ROOT / "tools" / "_devos-map-doctor" / "devos-map-doctor-main"
sys.path.insert(0, str(HERE))
sys.path.insert(0, str(DOCTOR))

import add_warglaive_lt30 as WGL  # noqa: E402
import alas_item_rules as ITEM_RULES  # noqa: E402
import merge_w3obj as M  # noqa: E402
import port_wings as P  # noqa: E402
import port_lua_campaign_systems as LUA_PORT  # noqa: E402
import war3mpq as W  # noqa: E402
from doctor.data import objects as OBJ  # noqa: E402
from doctor.data import w3i as W3I  # noqa: E402
from doctor.models import blpwrite  # noqa: E402
from doctor.script import lua_ast  # noqa: E402

MARKER = b"-- ALAS_FORSaken_301_ITEM_SKILL_V1\n"
DEFAULT_SOURCE = Path(
    r"C:\Users\Administrator\Documents\Warcraft III\Campaigns"
    r"\被遗忘的王国-3.0.1.24371-缓存修复.w3n"
)
DEFAULT_WORK = ROOT / "maps" / "port" / "forsaken_undead_301"
DEFAULT_OUTPUT = Path(
    r"C:\Users\Administrator\Documents\Warcraft III\Campaigns"
    r"\alas被遗忘的王国-3.0.1-物品技能版.w3n"
)
DEFAULT_OBJECT_SOURCE = (
    ROOT / "maps" / "port" / "lost_temple_30"
    / "LostTempleLV_BladeMaster30.w3x"
)
# Legacy 1.27 MPQ dump. Reforged's CASC catalog is the primary source; this
# table remains as a compatibility fallback/union for old-only IDs.
STANDARD_ITEM_TABLE = ROOT / "maps" / "port" / "forsaken_undead" / "_itemids.txt"
STANDARD_SKILL_TABLE = ROOT / "maps" / "port" / "forsaken_undead" / "_skillids.txt"
OFFLINE_ITEM_CATALOG = (
    ROOT / "tools" / "alas-offline" / "assets" / "game_item_catalog.tsv"
)
OFFLINE_ICON_DIR = ROOT / "tools" / "alas-offline" / "assets" / "generated"
BROWSER_DIR = ROOT / "scripts" / "item-browser"
WING_DIR = ROOT / "scripts" / "wings"
FR_DIR = ROOT / "scripts" / "frostmourne"
WING_CONFIG = "wings_config_forsaken_301"

WEAPON_ITEM_IDS = {"I105", "I106"}
SOURCE_WEAPON_ABILITY_IDS = {
    "A105", "A106", "A107", "A108", "A109",
    "A110", "A111", "A113", "A116", "A170",
}
WEAPON_ABILITY_IDS = SOURCE_WEAPON_ABILITY_IDS | {"A117", "A118"}
ITEM_NAMES = {
    "I103": "阿克蒙德之手",
    "I105": "霜之哀伤",
    "I106": "埃辛诺斯战刃",
}
FR_ASSETS = (
    ("Frostmourne.mdx", r"war3campImported\Frostmourne.mdx"),
    ("Frostmourne10.blp", "Frostmourne10.blp"),
    ("Frostmourne100.blp", "Frostmourne100.blp"),
    ("IceStompRaised.mdx", r"war3campImported\IceStompRaised.mdx"),
    (
        "Rune-Blue-Aura_Raised20.mdx",
        r"war3campImported\Rune-Blue-Aura_Raised20.mdx",
    ),
)
ICON_ASSETS = (
    (
        ROOT / "heroes" / "item_icons" / "BTNArchimondeHand_30HD.blp",
        r"ReplaceableTextures\CommandButtons\BTNArchimondeHand_30HD.blp",
    ),
    (
        ROOT / "heroes" / "item_icons" / "DISBTNArchimondeHand_30HD.blp",
        r"ReplaceableTextures\CommandButtonsDisabled\DISBTNArchimondeHand_30HD.blp",
    ),
    (
        ROOT / "heroes" / "item_icons" / "BTNFrostmourne_30HD.blp",
        r"ReplaceableTextures\CommandButtons\BTNFrostmourne_30HD.blp",
    ),
    (
        ROOT / "heroes" / "item_icons" / "DISBTNFrostmourne_30HD.blp",
        r"ReplaceableTextures\CommandButtonsDisabled\DISBTNFrostmourne_30HD.blp",
    ),
)
DEMON_WARGLAIVE_ICON = (
    r"ReplaceableTextures\CommandButtons\BTNDemonicWarglaives.blp"
)
DEMON_WARGLAIVE_DISABLED = (
    r"ReplaceableTextures\CommandButtonsDisabled"
    r"\DISBTNDemonicWarglaives.blp"
)
GARREK_CHARGE_ICON = (
    r"ReplaceableTextures\CommandButtons\BTNGarrekCharge.blp"
)
GARREK_CHARGE_DISABLED = (
    r"ReplaceableTextures\CommandButtonsDisabled"
    r"\DISBTNGarrekCharge.blp"
)
GARREK_CHARGE_SOURCE = (
    r"war3.w3mod:_de.w3mod:replaceabletextures\commandbuttons"
    r"\btnbatteringram.dds"
)
SILENT_HIT_IMPACT_SOURCE = (
    r"war3.w3mod:abilities\spells\demon\demonboltimpact"
    r"\demonboltimpact.mdx"
)
SILENT_HIT_IMPACT_PATH = (
    r"war3campImported\DemonBoltImpactSilent.mdx"
)
WARGLAIVE_ITEM_TOOLTIP = (
    "|cffff8c00神器|r|n|n"
    "+15 敏捷|n"
    "|cff5ddf26攻击速度随敏捷提升：敏捷×0.5%，最低 15%，最高 200%。|r|n"
    "|cff5ddf26顺劈：你的近战基础攻击会造成顺劈效果，"
    "将造成伤害的 15% 转嫁给附近敌方单位。|r|n"
    "|cff5ddf26邪魂淬炼：基础攻击有 2% 几率永久提升 1 点敏捷。"
    "不设上限。|r|n"
    "|cff66ccff装备后获得技能：雷霆冲锋（C）。|r|n|n"
    "|cffffcc00这是卡多雷强大而可怖的恶魔猎手的标志性武器。"
    "刃锋经过邪能锻造，至今仍燃烧着永不熄灭的邪焰。|r"
)
WARGLAIVE_ITEM_DESCRIPTION = (
    "敏捷 +15。|n"
    "|cff5ddf26攻击速度随敏捷提升：敏捷×0.5%，最低 15%，最高 200%。|r|n"
    "|cff5ddf26顺劈：近战基础攻击会把 15% 伤害转嫁给附近敌人。|r|n"
    "|cff5ddf26邪魂淬炼：基础攻击有 2% 概率永久提升 1 点敏捷。|r|n"
    "|cff66ccff装备后获得技能：雷霆冲锋（C）。|r"
)
WARGLAIVE_CHARGE_DESCRIPTION = (
    "向目标方向雷霆冲锋，对沿途命中的敌人造成 3×敏捷 的伤害。|n"
    "冲锋距离：100 + 敏捷×10，最高 2000。|n"
    "每命中 1 个不同敌人，攻击力 +15，最多 20 层，持续 7 秒。"
)

FROSTMOURNE_ACTIVE_ICON = (
    r"ReplaceableTextures\CommandButtons\BTNBreathOfFrost.blp"
)
FROSTMOURNE_ITEM_TOOLTIP = (
    "|cffff8c00神器|r|n|n"
    "+30 攻击力|n"
    "+50% 攻击速度|n"
    "+100% 魔法恢复|n"
    "|cff5ddf26霜冻新星：普通攻击有 30% 概率触发，"
    "对 250 范围内敌人造成 100 点伤害，"
    "主目标额外受到 50 点伤害并减速 4 秒。|r|n"
    "|cff5ddf26噬魂：击杀敌人有 5% 概率永久 +1 力量，击杀英雄时为 50%。|r|n"
    "|cff66ccff装备后获得技能：冰封践踏（D）。|r|n|n"
    "|cffffcc00巫妖王的低语凝成寒霜。凡被剑锋吞噬的灵魂，"
    "都将在永恒的冰狱中继续哀嚎。|r"
)
FROSTMOURNE_ITEM_DESCRIPTION = (
    "攻击力 +30，攻击速度 +50%，魔法恢复 +100%。|n"
    "|cff5ddf26霜冻新星：普通攻击有 30% 概率造成范围伤害与减速。|r|n"
    "|cff5ddf26噬魂：击杀敌人有 5% 概率永久 +1 力量，击杀英雄时为 50%。|r|n"
    "|cff66ccff装备后获得技能：冰封践踏（D）。|r"
)
FROSTMOURNE_ACTIVE_TOOLTIP = (
    "消耗当前生命 20%（不会致死）。|n"
    "对 550 范围内地面与空中敌人造成 100 + 4×力量 的伤害。|n"
    "普通单位冰冻 5 秒，英雄冰冻 3 秒。|n"
    "魔法免疫单位会被冻结，但不会受到伤害。"
)


def run(args: list[object], env: dict[str, str] | None = None) -> None:
    text = [str(x) for x in args]
    print(">>>", " ".join(text), flush=True)
    result = subprocess.run(text, env=env)
    if result.returncode:
        raise SystemExit("command failed (%d): %s" % (result.returncode, text))


def parse_wts(data: bytes | None) -> dict[str, str]:
    if not data:
        return {}
    text = data.decode("utf-8-sig", "replace")
    pattern = re.compile(
        r"STRING\s+(\d+)\s*\r?\n(?:[^\r\n{}]*\r?\n)*"
        r"\{(?:\r?\n)?(.*?)\r?\n\}",
        re.S,
    )
    return {"TRIGSTR_" + m.group(1): m.group(2).strip()
            for m in pattern.finditer(text)}


def decode_value(value: object) -> str:
    if isinstance(value, bytes):
        return value.decode("utf-8", "replace").replace("\0", "")
    return str(value).replace("\0", "")


def field_values(mods: list[tuple], field_id: str) -> list[str]:
    return [decode_value(m[4]) for m in mods if m[0] == field_id]


def resolve_string(value: str, strings: dict[str, str]) -> str:
    if not value.startswith("TRIGSTR_"):
        return value
    if value in strings:
        return strings[value]
    match = re.fullmatch(r"TRIGSTR_0*(\d+)", value)
    if match:
        return strings.get("TRIGSTR_" + match.group(1), value)
    return value


def read_objects(archive: W.MPQArchive, name: str, with_levels: bool):
    data = archive.read_file(name)
    if not data:
        return 3, []
    version, entries, consumed = OBJ.read_objects_bytes(
        data, with_levels, fname=name, with_end=True
    )
    if consumed != len(data):
        raise SystemExit("%s: object parser consumed %d of %d bytes" %
                         (name, consumed, len(data)))
    return version, entries


def target_custom_names(archive: W.MPQArchive, ext: str) -> dict[str, str]:
    with_levels = ext == "w3a"
    _version, normal = read_objects(archive, "war3map." + ext, with_levels)
    _version, skin = read_objects(archive, "war3mapSkin." + ext, with_levels)
    strings = parse_wts(
        archive.read_file(r"_Locales\zhCN.w3mod\war3map.wts")
        or archive.read_file("war3map.wts")
    )
    by_key = {}
    for _table, old, new, mods in normal + skin:
        name_field = "unam" if ext == "w3t" else "anam"
        values = field_values(mods, name_field)
        name = resolve_string(values[-1], strings) if values else ""
        if name:
            by_key[(old, new)] = name
    result = {}
    for _table, old, new, mods in normal + skin:
        # Reforged stores many campaign-specific renames as original-table
        # overrides (newId == 0). They still replace the displayed name of the
        # standard object and must be included in the browser.
        ident = (new or old).replace("\0", "")
        if len(ident) != 4:
            continue
        name_field = "unam" if ext == "w3t" else "anam"
        values = field_values(mods, name_field)
        name = by_key.get((old, new), "")
        if not name and values:
            name = resolve_string(values[-1], strings)
        result[ident] = name or ident
    return result


def clean_name(value: str) -> str:
    value = re.sub(r"\|c[0-9a-fA-F]{8}", "", value)
    value = value.replace("|r", "").replace("\r", " ").replace("\n", " ")
    return " ".join(value.split())


def read_table(path: Path) -> list[tuple[str, str, str]]:
    rows = []
    for line in path.read_text(encoding="utf-8").splitlines():
        parts = line.split("\t")
        if len(parts) >= 3 and len(parts[1]) == 4:
            rows.append((parts[0].strip(), parts[1].strip(), clean_name(parts[2])))
        elif len(parts) >= 2 and len(parts[0]) == 4:
            rows.append(("S", parts[0].strip(), clean_name(parts[1])))
    return rows


def casc_item_rows() -> list[tuple[str, str, str]]:
    """Read every Reforged item, including localized campaign item names.

    The old classic MPQ table stopped at 273 entries and omitted most
    campaign-only equipment. The custom-balance item table is intentionally
    bypassed because it is another reduced subset.
    """
    try:
        game = OBJ.GameBase(locale="zhcn", balance=None)
        table = game.table("item")
        rows = []
        for ident, fields in table.items():
            name = fields.get("name") or fields.get("comment") or ident
            rows.append(("S", ident, clean_name(name)))
        return rows
    except Exception as exc:
        if not OFFLINE_ITEM_CATALOG.is_file():
            raise
        print(
            "CASC unavailable; using bundled item catalog:",
            exc,
            flush=True,
        )
        rows = []
        for line in OFFLINE_ITEM_CATALOG.read_text(
            encoding="utf-8"
        ).splitlines():
            parts = line.split("\t", 2)
            if len(parts) == 3:
                rows.append((parts[0], parts[1], parts[2]))
        return rows


def prepare_wings(work: Path, config: str = WING_CONFIG) -> dict[str, Path]:
    wing_dir = work / "wing"
    wing_dir.mkdir(parents=True, exist_ok=True)
    env = dict(os.environ)
    env["PYTHONIOENCODING"] = "utf-8"
    env["WINGS_CONFIG"] = config
    run([sys.executable, HERE / "gen_jass_tables.py"], env=env)
    run(
        [sys.executable, HERE / "gen_wing.py", wing_dir / "wing.w3a"],
        env=env,
    )
    run(
        [sys.executable, HERE / "gen_wing_item.py", wing_dir / "wing.w3t"],
        env=env,
    )
    run(
        [sys.executable, HERE / "gen_w3u.py", wing_dir / "wing.w3u"],
        env=env,
    )
    run(
        [
            sys.executable,
            "-c",
            (
                "import sys;"
                "sys.path.insert(0, r'%s');"
                "import gen_w3h;"
                "gen_w3h.build_project_buffs(sys.argv[1])"
            ) % str(HERE),
            wing_dir / "wing.w3h",
        ],
        env=env,
    )
    run(
        [
            sys.executable,
            "-c",
            (
                "import sys;"
                "sys.path.insert(0, r'%s');"
                "import hand_data;"
                "hand_data.build(sys.argv[1], sys.argv[2])"
            ) % str(HERE),
            wing_dir / "hand.w3t",
            wing_dir / "hand.w3a",
        ],
        env=env,
    )
    result = {
        "w3a": wing_dir / "wing.w3a",
        "w3t": wing_dir / "wing.w3t",
        "w3u": wing_dir / "wing.w3u",
        "w3h": wing_dir / "wing.w3h",
        "hand_w3t": wing_dir / "hand.w3t",
        "hand_w3a": wing_dir / "hand.w3a",
    }
    for path in result.values():
        if not path.is_file() or path.stat().st_size < 12:
            raise SystemExit("wing object generation failed: " + str(path))
    return result


def object_names(path: Path, ext: str) -> dict[str, str]:
    version, entries = read_objects_from_path(path, ext)
    result = {}
    for _table, old, new, mods in entries:
        ident = new.replace("\0", "")
        if not ident:
            continue
        fields = ("unam",) if ext == "w3t" else ("anam", "unam")
        name = ""
        for field_id in fields:
            values = field_values(mods, field_id)
            if values and values[-1]:
                name = values[-1]
        result[ident] = clean_name(name or ident)
    return result


def read_objects_from_path(path: Path, ext: str):
    with path.open("rb") as stream:
        data = stream.read()
    version, entries, consumed = OBJ.read_objects_bytes(
        data, ext in ("w3a", "w3q"), fname=path.name, with_end=True
    )
    if consumed != len(data):
        raise SystemExit("%s: trailing object bytes" % path)
    return version, entries


def object_ids(path: Path, ext: str) -> set[str]:
    _version, entries = read_objects_from_path(path, ext)
    return {
        new.replace("\0", "")
        for _table, _old, new, _mods in entries
        if new.replace("\0", "")
    }


def selected_equipment_mode() -> str:
    mode = os.environ.get(
        "ALAS_EQUIPMENT_MODE", "command"
    ).strip().lower()
    if mode not in ("item", "command"):
        raise SystemExit(
            "ALAS_EQUIPMENT_MODE must be item or command"
        )
    return mode


def chapter_uses_item_actives(chapter: Path) -> bool:
    """Return the user-selected artifact skill ownership."""
    return selected_equipment_mode() == "item"


def configure_equipment_ownership(
    object_dir: Path, item_active: bool
) -> None:
    """Select one skill owner per item, never both."""
    item_path = object_dir / "merged.w3t"
    ability_path = object_dir / "merged.w3a"
    if item_active:
        item_fields = {
            "I103": ("A100,A101,A102,W091", "A100"),
            "I105": ("A105,A106,A108,A109", "A105"),
            "I106": ("A113,A110,A111,Aclq", "A113"),
        }
    else:
        item_fields = {
            "I103": ("A101,A102,W091", ""),
            "I105": ("A106,A108,A109", ""),
            "I106": ("A110,A111,Aclq", ""),
        }
    for ident, (abilities, cooldown) in item_fields.items():
        set_object_mod_value(
            item_path, "w3t", ident, "iabi", 0, 0, abilities
        )
        set_object_mod_value(
            item_path, "w3t", ident, "icid", 0, 0, cooldown
        )
        if item_active:
            set_object_mod_value(
                item_path, "w3t", ident, "icla", 0, 0, "Equipment"
            )
            set_object_mod_value(
                item_path, "w3t", ident, "iequ", 0, 0, "Trinket"
            )
            set_object_mod_value(
                item_path, "w3t", ident, "iusa", 0, 0, 0
            )
    for ident in ("A100", "A105", "A113"):
        set_object_mod_value(
            ability_path, "w3a", ident, "aite", 0, 0, 0
        )
        set_object_mod_value(
            ability_path, "w3a", ident, "abpx", 0, 0, 2
        )
        set_object_mod_value(
            ability_path, "w3a", ident, "abpy", 0, 0, 1
        )
    for ident in (
        "A101", "A102", "W091",
        "A106", "A108", "A109",
        "A110", "A111",
    ):
        set_object_mod_value(
            ability_path, "w3a", ident, "aite", 0, 0, 1
        )


def prepare_alas_startup(work: Path) -> Path:
    """Copy startup scripts and install the manual qt full-map command."""
    source = ROOT / "scripts" / "alas-startup"
    target = work / "_startup"
    if target.exists():
        shutil.rmtree(target)
    shutil.copytree(source, target)
    globals_path = target / "g.j"
    globals_path.write_text(
        "boolean ALAS_QT_ACTIVE = false\n",
        encoding="utf-8",
    )
    functions = target / "f.j"
    text = functions.read_text(encoding="utf-8")
    if "function ALAS_InitQtCommand takes" not in text:
        text += (
            "\nfunction ALAS_KeepFullMap takes nothing returns nothing\n"
            "    call FogEnable(false)\n"
            "    call FogMaskEnable(false)\n"
            "endfunction\n"
            "\n"
            "\nfunction ALAS_EnableFullMap takes nothing returns nothing\n"
            "    if ALAS_QT_ACTIVE then\n"
            "        return\n"
            "    endif\n"
            "    set ALAS_QT_ACTIVE = true\n"
            "    call FogEnableOff()\n"
            "    call FogMaskEnableOff()\n"
            "    call TimerStart(CreateTimer(), 0.50, true, "
            "function ALAS_KeepFullMap)\n"
            "endfunction\n"
            "\n"
            "function ALAS_OnQtCommand takes nothing returns nothing\n"
            "    call ALAS_EnableFullMap()\n"
            "endfunction\n"
            "\n"
            "function ALAS_InitQtCommand takes nothing returns nothing\n"
            "    local trigger t = CreateTrigger()\n"
            "    local integer i = 0\n"
            "    loop\n"
            "        exitwhen i >= 12\n"
            "        call TriggerRegisterPlayerChatEvent(t, Player(i), "
            "\"qt\", true)\n"
            "        call TriggerRegisterPlayerChatEvent(t, Player(i), "
            "\"QT\", true)\n"
            "        set i = i + 1\n"
            "    endloop\n"
            "    call TriggerAddAction(t, function ALAS_OnQtCommand)\n"
            "    set t = null\n"
            "endfunction\n"
        )
        functions.write_text(text, encoding="utf-8")
    (target / "m.j").write_text(
        "call ALAS_StartupMessage()\n"
        "call ALAS_InitQtCommand()\n",
        encoding="utf-8",
    )
    return target


def prepare_jass_command_scripts(
    work: Path,
    wing_dir: Path,
    frostmourne_dir: Path,
    warglaive_dir: Path,
) -> tuple[Path, Path, Path]:
    """Return JASS sources that contain no Reforged loadout natives.

    JASS resolves every called function even when it is behind a false boolean.
    Legacy maps therefore fail pjass on BlzUnitItemInEquipmentSlot and
    ConvertLoadoutSlot unless those branches are removed from their generated
    source copy.  The command-card fallback checks only the normal backpack.
    """
    target_root = work / "_jass_command_scripts"
    if target_root.exists():
        shutil.rmtree(target_root)
    wing_target = target_root / "wings"
    frost_target = target_root / "frostmourne"
    warglaive_target = target_root / "warglaive"
    shutil.copytree(wing_dir, wing_target)
    shutil.copytree(frostmourne_dir, frost_target)
    shutil.copytree(warglaive_dir, warglaive_target)

    replacements = (
        (
            wing_target / "f.j",
            "WG_ITEM_ACTIVE",
            "WG_HAND_ITEM",
        ),
        (
            frost_target / "f.j",
            "FR_ITEM_ACTIVE",
            "FR_ITEM_ID",
        ),
    )
    for path, flag, item_id in replacements:
        text = path.read_text(encoding="utf-8")
        branch = (
            "    if %s then\n"
            "        set it = BlzUnitItemInEquipmentSlot"
            "(u, ConvertLoadoutSlot(8))\n"
            "        if it != null and GetItemTypeId(it) == %s then\n"
            "            return it\n"
            "        endif\n"
            "        return null\n"
            "    endif\n"
        ) % (flag, item_id)
        if text.count(branch) != 1:
            raise SystemExit(
                "%s: command-card equipment branch is not unique" % path
            )
        text = text.replace(branch, "", 1)
        if (
            "BlzUnitItemInEquipmentSlot" in text
            or "ConvertLoadoutSlot" in text
        ):
            raise SystemExit(
                "%s: Reforged loadout native remains in command mode" % path
            )
        path.write_text(text, encoding="utf-8")

    wing_script = (wing_target / "f.j").read_text(encoding="utf-8")
    finger_item_branch = (
        "    if WG_ITEM_ACTIVE then\n"
        "        set it = WG_GetHandItem(u)\n"
        "        if it != null then\n"
        "            if BlzGetItemAbility(it, WG_FINGER_ABILITY) != null then\n"
        "                call BlzSetAbilityRealLevelField"
        "(BlzGetItemAbility(it, WG_FINGER_ABILITY), "
        "ConvertAbilityRealLevelField('acdn'), 1, "
        "WG_FingerCooldown(u))\n"
        "                call BlzSetAbilityIntegerLevelField"
        "(BlzGetItemAbility(it, WG_FINGER_ABILITY), "
        "ConvertAbilityIntegerLevelField('amcs'), 1, "
        "WG_FingerMana(u))\n"
        "            endif\n"
        "        endif\n"
        "        set it = null\n"
        "        return\n"
        "    endif\n"
    )
    if wing_script.count(finger_item_branch) != 1:
        raise SystemExit(
            "wings/f.j: item-owned Death Finger branch is not unique"
        )
    wing_script = wing_script.replace(finger_item_branch, "", 1)
    if "BlzGetItemAbility" in wing_script:
        raise SystemExit(
            "wings/f.j: item ability API remains in command mode"
        )
    (wing_target / "f.j").write_text(wing_script, encoding="utf-8")

    warglaive_script = (warglaive_target / "f.j").read_text(
        encoding="utf-8"
    )
    has_item_start = warglaive_script.find(
        "function WGL_HasWarglaive takes unit u returns boolean"
    )
    has_item_end = warglaive_script.find(
        "function WGL_CooldownClockTick", has_item_start
    )
    if has_item_start < 0 or has_item_end < 0:
        raise SystemExit("warglaive/f.j: ownership function not found")
    warglaive_script = (
        warglaive_script[:has_item_start]
        + "function WGL_HasWarglaive takes unit u returns boolean\n"
        + "    if u == null or GetUnitTypeId(u) == 0 then\n"
        + "        return false\n"
        + "    endif\n"
        + "    return UnitHasItemOfTypeBJ(u, 'I106')\n"
        + "endfunction\n\n"
        + warglaive_script[has_item_end:]
    )
    warglaive_active_branch = (
        "    if WGL_ITEM_ACTIVE then\n"
        "        if GetUnitAbilityLevel(u, 'A116') > 0 then\n"
        "            call UnitRemoveAbility(u, 'A116')\n"
        "        endif\n"
        "        call WGL_SyncAttackSpeed(u)\n"
        "        return\n"
        "    endif\n"
    )
    if warglaive_script.count(warglaive_active_branch) != 1:
        raise SystemExit(
            "warglaive/f.j: item-owned sync branch is not unique"
        )
    warglaive_script = warglaive_script.replace(
        warglaive_active_branch, "", 1
    )
    if (
        "BlzUnitItemInEquipmentSlot" in warglaive_script
        or "ConvertLoadoutSlot" in warglaive_script
    ):
        raise SystemExit(
            "warglaive/f.j: loadout API remains in command mode"
        )
    (warglaive_target / "f.j").write_text(
        warglaive_script, encoding="utf-8"
    )
    return wing_target, frost_target, warglaive_target


def prepare_jass_item_scripts(
    work: Path,
    wing_dir: Path,
    frostmourne_dir: Path,
    warglaive_dir: Path,
) -> tuple[Path, Path, Path]:
    """Return JASS sources that use item/loadout skill ownership."""
    target_root = work / "_jass_item_scripts"
    if target_root.exists():
        shutil.rmtree(target_root)
    wing_target = target_root / "wings"
    frost_target = target_root / "frostmourne"
    warglaive_target = target_root / "warglaive"
    shutil.copytree(wing_dir, wing_target)
    shutil.copytree(frostmourne_dir, frost_target)
    shutil.copytree(warglaive_dir, warglaive_target)

    flags = (
        (wing_target / "g.j", "WG_ITEM_ACTIVE"),
        (frost_target / "g.j", "FR_ITEM_ACTIVE"),
        (warglaive_target / "g.j", "WGL_ITEM_ACTIVE"),
    )
    for path, flag in flags:
        text = path.read_text(encoding="utf-8")
        old = "boolean %s = false" % flag
        if text.count(old) != 1:
            raise SystemExit(
                "%s: %s flag is not unique" % (path, flag)
            )
        path.write_text(
            text.replace(
                old,
                "boolean %s = true" % flag,
                1,
            ),
            encoding="utf-8",
        )

    for path in (
        wing_target / "f.j",
        frost_target / "f.j",
        warglaive_target / "f.j",
    ):
        text = path.read_text(encoding="utf-8")
        if (
            "BlzUnitItemInEquipmentSlot" not in text
            or "ConvertLoadoutSlot" not in text
        ):
            raise SystemExit(
                "%s: loadout ownership branch is missing" % path
            )
    return wing_target, frost_target, warglaive_target


def build_tables(
    work: Path, campaign: Path, wing_sources: dict[str, Path]
) -> tuple[int, int]:
    try:
        items = casc_item_rows()
    except Exception as exc:
        print("CASC item catalog unavailable; using legacy table: %s" % exc,
              file=sys.stderr)
        items = []
    if not items:
        items = (
            read_table(STANDARD_ITEM_TABLE)
            if STANDARD_ITEM_TABLE.is_file()
            else []
        )
    else:
        # Keep any classic-only IDs while preferring current CASC names.
        known_item_ids = {ident for _flag, ident, _name in items}
        if STANDARD_ITEM_TABLE.is_file():
            items.extend(
                row for row in read_table(STANDARD_ITEM_TABLE)
                if row[1] not in known_item_ids
            )
    skills = [
        (ident, name)
        for _flag, ident, name in (
            read_table(STANDARD_SKILL_TABLE)
            if STANDARD_SKILL_TABLE.is_file()
            else []
        )
    ]
    standard_items = {ident for _flag, ident, _name in items}
    standard_skills = {ident for ident, _name in skills}
    custom_items: dict[str, str] = {}
    custom_item_aliases: set[tuple[str, str]] = set()
    custom_skills: dict[str, str] = {}

    archive = W.MPQArchive(str(campaign))
    try:
        chapter_names = sorted(
            name for name in archive.listfile
            if name.lower().endswith((".w3x", ".w3m"))
        )
        for chapter_name in chapter_names:
            data = archive.read_file(chapter_name)
            if not data:
                raise SystemExit("cannot read campaign chapter " + chapter_name)
            fd, temp_name = tempfile.mkstemp(suffix=".w3x")
            os.close(fd)
            temp = Path(temp_name)
            try:
                temp.write_bytes(data)
                chapter = W.MPQArchive(str(temp))
                try:
                    chapter_items = target_custom_names(chapter, "w3t")
                    custom_items.update(chapter_items)
                    custom_item_aliases.update(
                        (ident, clean_name(name))
                        for ident, name in chapter_items.items()
                        if name
                    )
                    custom_skills.update(target_custom_names(chapter, "w3a"))
                finally:
                    chapter.close()
            finally:
                temp.unlink(missing_ok=True)
    finally:
        archive.close()

    custom_items.update(ITEM_NAMES)
    custom_item_aliases.update(
        (ident, clean_name(name)) for ident, name in ITEM_NAMES.items()
    )
    item_by_id = {ident: (flag, ident, name) for flag, ident, name in items}
    for ident, name in sorted(custom_items.items()):
        if ident in standard_items:
            if name and name != ident:
                flag, _, _ = item_by_id[ident]
                item_by_id[ident] = (flag, ident, clean_name(name))
        else:
            item_by_id[ident] = ("C", ident, clean_name(name or ident))
    items = list(item_by_id.values())
    existing_item_names = {(flag, ident, name) for flag, ident, name in items}
    for ident, name in sorted(custom_item_aliases):
        flag = item_by_id.get(ident, ("C", ident, ""))[0]
        alias = (flag, ident, name)
        if alias not in existing_item_names:
            items.append(alias)
            existing_item_names.add(alias)

    skill_by_id = {ident: (ident, name) for ident, name in skills}
    for ident, name in sorted(custom_skills.items()):
        if name:
            skill_by_id[ident] = (ident, clean_name(name))
    skills = list(skill_by_id.values())

    # Add generated wing items/abilities and the three weapon objects.
    src = W.MPQArchive(str(DEFAULT_OBJECT_SOURCE))
    try:
        _version, entries = read_objects(src, "war3map.w3a", True)
        for _table, _old, new, mods in entries:
            ident = new.replace("\0", "")
            if ident not in WEAPON_ABILITY_IDS:
                continue
            values = field_values(mods, "anam")
            if values and values[-1]:
                skills.append((ident, clean_name(values[-1])))
    finally:
        src.close()
    for ext, extra_key in (("w3t", None), ("w3a", "hand_w3a")):
        generated_sources = [wing_sources[ext]]
        if extra_key:
            generated_sources.append(wing_sources[extra_key])
        for source in generated_sources:
            for ident, name in object_names(source, ext).items():
                if ext == "w3t":
                    if ident not in standard_items:
                        items.append(("C", ident, name))
                elif ident not in standard_skills:
                    skills.append((ident, name))

    item_dedup = {}
    for flag, ident, name in items:
        item_dedup.setdefault(
            (flag, ident, name or ident), (flag, ident, name or ident)
        )
    item_rows = list(item_dedup.values())
    skill_dedup = {}
    for ident, name in skills:
        skill_dedup.setdefault(ident, (ident, name or ident))
    skill_rows = list(skill_dedup.values())

    (work / "_itemids.txt").write_text(
        "".join("%s\t%s\t%s\n" % row for row in item_rows),
        encoding="utf-8",
    )
    (work / "_skillids.txt").write_text(
        "".join("%s\t%s\n" % row for row in skill_rows),
        encoding="utf-8",
    )
    (work / "_unitids.txt").write_text("", encoding="utf-8")
    return len(item_rows), len(skill_rows)


def prepare_browser(work: Path, protect_ids: set[str]) -> Path:
    out_dir = work / "item-browser"
    out_dir.mkdir(parents=True, exist_ok=True)
    shutil.copy2(BROWSER_DIR / "g.j", out_dir / "g.j")
    shutil.copy2(BROWSER_DIR / "f.j", out_dir / "f.j")
    env = dict(os.environ)
    env["PYTHONIOENCODING"] = "utf-8"
    env["IB_BASE_DIR"] = str(work.resolve())
    env["IB_OUT_DIR"] = str(out_dir.resolve())
    env["IB_EXTRA_DIR"] = str(work.resolve())
    env["IB_FINGER_ABILITY"] = "A100"
    run([sys.executable, HERE / "build_fj.py"], env=env)

    text = (out_dir / "f.j").read_text(encoding="utf-8", errors="surrogateescape")
    alias_pattern = re.compile(
        r"(?m)^([ \t]*)if name == ib_addName or IB_StrEqCI\("
        r"IB_IdStr\(ib_itemList\[ib_addIdx\]\), ib_addName\) then$"
    )
    match = alias_pattern.search(text)
    if not match:
        raise SystemExit("item browser additem alias anchor not found")
    indent = match.group(1)
    alias = (
        indent + "if name == ib_addName or IB_StrEqCI("
        "IB_IdStr(ib_itemList[ib_addIdx]), ib_addName) "
        "or (ib_itemList[ib_addIdx] == 'I103' and "
        "(IB_StrEqCI(ib_addName, \"hand\") or "
        "IB_StrEqCI(ib_addName, \"akhand\"))) "
        "or (ib_itemList[ib_addIdx] == 'I105' and "
        "(IB_StrEqCI(ib_addName, \"frost\") or "
        "IB_StrEqCI(ib_addName, \"frostmourne\"))) "
        "or (ib_itemList[ib_addIdx] == 'I106' and "
        "(IB_StrEqCI(ib_addName, \"warglaive\") or "
        "IB_StrEqCI(ib_addName, \"glaive\") or "
        "IB_StrEqCI(ib_addName, \"eggblade\") or "
        "IB_StrEqCI(ib_addName, \"azzinoth\"))) then"
    )
    text = text[:match.start()] + alias + text[match.end():]

    protect_marker = "function IB_IsItemAbility takes integer abilId returns boolean\n"
    if text.count(protect_marker) != 1:
        raise SystemExit("item ability protection anchor not found")
    protect_lines = [protect_marker]
    ordered = sorted(protect_ids)
    for offset in range(0, len(ordered), 8):
        chunk = ordered[offset:offset + 8]
        keyword = "if" if offset == 0 else "elseif"
        condition = " or ".join("abilId == '%s'" % ident for ident in chunk)
        protect_lines.append("    %s %s then\n" % (keyword, condition))
        protect_lines.append("        return true\n")
    if ordered:
        protect_lines.append("    endif\n")
    protect = "".join(protect_lines)
    text = text.replace(protect_marker, protect, 1)

    add_give_start = (
        "function IB_AddGive takes player p, integer itemId, integer count returns nothing\n"
        "    local unit u = IB_GetSelectedUnit(p)\n"
        "    local item it\n"
        "    local real x\n"
        "    local real y\n"
        "    local integer added = 0\n"
    )
    if "function IB_IsExclusiveArtifact takes integer itemId returns boolean" in text:
        current_add_give = re.search(
            r"function IB_AddGive takes player p, integer itemId, integer count returns nothing"
            r"\n(?:    local [^\n]+\n)+",
            text,
        )
        if current_add_give:
            add_give_start = current_add_give.group(0)
    if text.count(add_give_start) != 1:
        raise SystemExit("item browser add-give message anchor not found")
    add_give_new = add_give_start
    missing_locals = ""
    if "local integer inBag = 0" not in text:
        missing_locals += "    local integer inBag = 0\n"
    if "local integer onGround = 0" not in text:
        missing_locals += "    local integer onGround = 0\n"
    if 'local string itemName = ""' not in text:
        missing_locals += '    local string itemName = ""\n'
    if missing_locals:
        local_anchor = "    local integer added = 0\n"
        add_give_new = add_give_new.replace(
            local_anchor,
            local_anchor + missing_locals,
            1,
        )
    text = text.replace(add_give_start, add_give_new, 1)

    add_body_anchor = (
        "        set it = CreateItem(itemId, x, y)\n"
        "        if it != null then\n"
        "            if not UnitAddItem(u, it) then\n"
        "                call SetItemPosition(it, x, y)\n"
        "            endif\n"
        "            set added = added + 1\n"
        "        endif\n"
        "        set it = null\n"
        "    endloop\n"
        '    call IB_Message(p, "已添加 " + I2S(added) + " 个 \\"" + IB_ItemName(ib_addFoundIdx) + "\\"")\n'
    )
    if "function IB_IsExclusiveArtifact takes integer itemId returns boolean" in text:
        add_body_anchor = (
            "        if IB_IsExclusiveArtifact(itemId) and IB_HasExclusiveArtifact(u) then\n"
        )
    if text.count(add_body_anchor) != 1:
        raise SystemExit("item browser add-give body anchor not found")
    add_body = (
        "        set it = CreateItem(itemId, x, y)\n"
        "        if it != null then\n"
        '            if itemName == "" then\n'
        "                set itemName = GetItemName(it)\n"
        "            endif\n"
        "            if UnitAddItem(u, it) then\n"
        "                set inBag = inBag + 1\n"
        "            else\n"
        "                call SetItemPosition(it, x, y)\n"
        "                set onGround = onGround + 1\n"
        "            endif\n"
        "            if inBag > 0 and (GetItemTypeId(it) == 'I103' or GetItemTypeId(it) == 'I105' or GetItemTypeId(it) == 'I106') then\n"
        "                call ALAS_GrantArtifact(u, GetItemTypeId(it))\n"
        "            endif\n"
        "            set added = added + 1\n"
        "        endif\n"
        "        set it = null\n"
        "    endloop\n"
        "    if added == 0 then\n"
        '        call IB_Message(p, "物品创建失败：" + itemName)\n'
        "    elseif onGround > 0 and inBag == 0 then\n"
        '        call IB_Message(p, "背包已满：" + itemName + " ×" + I2S(onGround) + " 掉在脚下")\n'
        "    elseif onGround > 0 then\n"
        '        call IB_Message(p, "放入背包：" + itemName + " ×" + I2S(inBag) + "；掉在脚下 ×" + I2S(onGround))\n'
        "    else\n"
        '        call IB_Message(p, "已添加：" + itemName + " ×" + I2S(inBag))\n'
        "    endif\n"
    )
    if "function IB_IsExclusiveArtifact takes integer itemId returns boolean" in text:
        add_body = add_body_anchor
    text = text.replace(add_body_anchor, add_body, 1)
    bag_sync_anchor = (
        "            elseif UnitAddItem(u, it) then\n"
        "                set added = added + 1\n"
    )
    if text.count(bag_sync_anchor) == 1:
        text = text.replace(
            bag_sync_anchor,
            bag_sync_anchor
            + "                if GetItemTypeId(it) == 'I103' or GetItemTypeId(it) == 'I105' or GetItemTypeId(it) == 'I106' then\n"
            + "                    call ALAS_GrantArtifact(u, GetItemTypeId(it))\n"
            + "                endif\n",
            1,
        )
    elif "ALAS_GrantArtifact(u, GetItemTypeId(it))" not in text:
        raise SystemExit("item browser artifact grant anchor not found")
    item_match_anchor = (
        "            if ib_itemCustom[ib_searchIdx] == 1 then\n"
        "                set ib_searchCusN = ib_searchCusN + 1\n"
        "                if ib_searchCusN <= 15 then\n"
        '                    set ib_searchCus = ib_searchCus + name + "  "\n'
        "                endif\n"
        "            else\n"
        "                set ib_searchStdN = ib_searchStdN + 1\n"
        "                if ib_searchStdN <= 15 then\n"
        '                    set ib_searchStd = ib_searchStd + name + "  "\n'
        "                endif\n"
        "            endif\n"
    )
    if text.count(item_match_anchor) != 1:
        raise SystemExit("item browser search-result anchor not found")
    item_match = (
        "            if ib_itemCustom[ib_searchIdx] == 1 then\n"
        "                set ib_searchCusN = ib_searchCusN + 1\n"
        "                if ib_searchCusN <= 30 then\n"
        '                    call DisplayTextToPlayer(ib_searchPlayer, 0, 0, "|cff00ff00自定义|r " + name)\n'
        "                endif\n"
        "            else\n"
        "                set ib_searchStdN = ib_searchStdN + 1\n"
        "                if ib_searchStdN <= 30 then\n"
        '                    call DisplayTextToPlayer(ib_searchPlayer, 0, 0, "|cffaaaaaa原版|r " + name)\n'
        "                endif\n"
        "            endif\n"
    )
    text = text.replace(item_match_anchor, item_match, 1)

    search_found_anchor = (
        '        if ib_searchFound == 0 then\n'
        '            call IB_Message(ib_searchPlayer, "未找到包含 \\"" + ib_searchKey + "\\" 的装备")\n'
        "        else\n"
        '            call DisplayTextToPlayer(ib_searchPlayer, 0, 0, "|cff00ff00[装备]|r 共找到 " + I2S(ib_searchFound) + " 件")\n'
        "            if ib_searchStdN > 0 then\n"
        '                call DisplayTextToPlayer(ib_searchPlayer, 0, 0, "|cffaaaaaa原版(" + I2S(ib_searchStdN) + "):|r " + ib_searchStd)\n'
        "            endif\n"
        "            if ib_searchCusN > 0 then\n"
        '                call DisplayTextToPlayer(ib_searchPlayer, 0, 0, "|cff00ff00自定义(" + I2S(ib_searchCusN) + "):|r " + ib_searchCus)\n'
        "            endif\n"
        "        endif\n"
    )
    if text.count(search_found_anchor) != 1:
        raise SystemExit("item browser search-summary anchor not found")
    search_found = (
        '        if ib_searchFound == 0 then\n'
        '            call IB_Message(ib_searchPlayer, "未找到：" + ib_searchKey)\n'
        "        else\n"
        '            call DisplayTextToPlayer(ib_searchPlayer, 0, 0, "|cff00ff00[装备]|r 找到 " + I2S(ib_searchFound) + " 件（原版" + I2S(ib_searchStdN) + " / 自定义" + I2S(ib_searchCusN) + "）")\n'
        "        endif\n"
    )
    text = text.replace(search_found_anchor, search_found, 1)

    search_start_anchor = (
        '    call IB_Message(p, "搜索 \\"" + keyword + "\\" ...")\n'
    )
    if text.count(search_start_anchor) != 1:
        raise SystemExit("item browser search-start anchor not found")
    text = text.replace(
        search_start_anchor,
        '    call IB_Message(p, "搜索：" + keyword)\n',
        1,
    )
    add_not_found_anchor = (
        '            call IB_Message(ib_addPlayer, "未找到装备 \\"" + ib_addName + "\\"")\n'
    )
    if text.count(add_not_found_anchor) != 1:
        raise SystemExit("item browser add-not-found anchor not found")
    text = text.replace(
        add_not_found_anchor,
        '            call IB_Message(ib_addPlayer, "未找到：" + ib_addName)\n',
        1,
    )

    (out_dir / "f.j").write_text(text, encoding="utf-8", errors="surrogateescape")
    return out_dir


def extract_object_sources(work: Path) -> dict[str, Path]:
    selected = {
        "w3t": WEAPON_ITEM_IDS,
        "w3a": SOURCE_WEAPON_ABILITY_IDS,
    }
    source = W.MPQArchive(str(DEFAULT_OBJECT_SOURCE))
    result = {}
    try:
        for ext, wanted in selected.items():
            with_levels = ext in ("w3a", "w3q")
            _version, entries = read_objects(
                source, "war3map." + ext, with_levels
            )
            chosen = []
            for entry in entries:
                ident = entry[2].replace("\0", "")
                if ident in wanted:
                    chosen.append(entry)
            missing = wanted - {entry[2].replace("\0", "") for entry in chosen}
            if missing:
                raise SystemExit("%s source objects missing: %s" %
                                 (ext, ", ".join(sorted(missing))))
            path = work / ("objects." + ext)
            path.write_bytes(OBJ.write_objects_bytes(2, chosen, with_levels))
            result[ext] = path
    finally:
        source.close()
    return result


def replace_string_mods(
    path: Path, ext: str, ident: str, updates: dict[str, str]
) -> None:
    with_levels = ext == "w3a"
    version, entries = read_objects_from_path(path, ext)
    output = []
    found = False
    for table, old, new, mods in entries:
        if new.replace("\0", "") != ident:
            output.append((table, old, new, mods))
            continue
        found = True
        mods = list(mods)
        for field_id, value in updates.items():
            replacement = (
                field_id, 3, 0, 0, value.encode("utf-8"), b"\0\0\0\0"
            )
            for index, mod in enumerate(mods):
                if mod[0] == field_id and mod[2] == 0:
                    mods[index] = replacement
                    break
            else:
                mods.append(replacement)
        output.append((table, old, new, tuple(mods)))
    if not found:
        raise SystemExit("%s object not found: %s" % (ext, ident))
    path.write_bytes(OBJ.write_objects_bytes(version, output, with_levels))


def replace_object_mod_values(
    path: Path,
    ext: str,
    ident: str,
    replacements: list[tuple[str, int, int, str | int | float]],
) -> None:
    with_levels = ext == "w3a"
    version, entries = read_objects_from_path(path, ext)
    output = []
    found = False
    for table, old, new, mods in entries:
        if new.replace("\0", "") != ident:
            output.append((table, old, new, mods))
            continue
        found = True
        mods = list(mods)
        for field_id, level, column, value in replacements:
            for index, mod in enumerate(mods):
                if (mod[0], mod[2], mod[3]) != (field_id, level, column):
                    continue
                encoded = value.encode("utf-8") if isinstance(value, str) else value
                mods[index] = (
                    mod[0], mod[1], mod[2], mod[3], encoded, mod[5]
                )
                break
            else:
                raise SystemExit(
                    "%s.%s level %d column %d not found" %
                    (ident, field_id, level, column)
                )
        output.append((table, old, new, tuple(mods)))
    if not found:
        raise SystemExit("%s object not found: %s" % (ext, ident))
    path.write_bytes(OBJ.write_objects_bytes(version, output, with_levels))


def set_object_mod_value(
    path: Path,
    ext: str,
    ident: str,
    field_id: str,
    level: int,
    column: int,
    value: str | int | float,
    replace_levels: bool = False,
) -> None:
    with_levels = ext in ("w3a", "w3q")
    version, entries = read_objects_from_path(path, ext)
    output = []
    found = False
    for table, old, new, mods in entries:
        if new.replace("\0", "") != ident:
            output.append((table, old, new, mods))
            continue
        found = True
        updated = [
            mod for mod in mods
            if not (replace_levels and mod[0] == field_id)
        ]
        value_type = 3 if isinstance(value, str) else (
            2 if isinstance(value, float) else 0
        )
        encoded = value.encode("utf-8") if isinstance(value, str) else value
        replacement = (
            field_id, value_type, level, column, encoded, b"\0\0\0\0"
        )
        for index, mod in enumerate(updated):
            if (mod[0], mod[2], mod[3]) == (field_id, level, column):
                updated[index] = replacement
                break
        else:
            updated.append(replacement)
        output.append((table, old, new, tuple(updated)))
    if not found:
        raise SystemExit("%s object not found: %s" % (ext, ident))
    path.write_bytes(OBJ.write_objects_bytes(version, output, with_levels))


def ability_mod(
    field_id: str,
    value_type: int,
    value: str | int | float,
    level: int = 0,
    column: int = 0,
) -> tuple:
    encoded = value.encode("utf-8") if isinstance(value, str) else value
    return (field_id, value_type, level, column, encoded, b"\0\0\0\0")


def add_custom_ability(
    path: Path,
    ident: str,
    base_id: str,
    mods: list[tuple],
) -> None:
    version, entries = read_objects_from_path(path, "w3a")
    output = [
        entry for entry in entries
        if entry[2].replace("\0", "") != ident
    ]
    output.append((1, base_id, ident, tuple(mods)))
    path.write_bytes(OBJ.write_objects_bytes(version, output, True))


def remove_custom_ability(path: Path, ident: str) -> None:
    version, entries = read_objects_from_path(path, "w3a")
    output = [
        entry for entry in entries
        if entry[2].replace("\0", "") != ident
    ]
    path.write_bytes(OBJ.write_objects_bytes(version, output, True))


def patch_warglaive_sources(sources: dict[str, Path]) -> None:
    replace_string_mods(
        sources["w3t"],
        "w3t",
        "I106",
        {
            "unam": "|cffff8c00埃辛诺斯战刃|r",
            "utip": "埃辛诺斯战刃",
            "utub": WARGLAIVE_ITEM_TOOLTIP,
            "ides": WARGLAIVE_ITEM_DESCRIPTION,
            "iabi": f"{WGL.SPELLBOOK_ID},Aclq",
            "icid": WGL.SPELLBOOK_ID,
            "iico": DEMON_WARGLAIVE_ICON,
            "ifil": "Chest_Legendary.mdx",
        },
    )
    for base_id, ident, raw_mods in WGL.warglaive_ability_specs():
        converted = [
            ability_mod(field, value_type, value, level, column)
            for field, value_type, level, column, value in raw_mods
        ]
        add_custom_ability(sources["w3a"], ident, base_id, converted)
    remove_custom_ability(sources["w3a"], "A112")
    replace_object_mod_values(
        sources["w3a"],
        "w3a",
        "A110",
        [
            ("aub1", 0, 0, "永久提高 15 点敏捷。"),
            ("Iagi", 1, 1, 15),
        ],
    )
    add_custom_ability(
        sources["w3a"],
        "A111",
        "AIsx",
        [
            ability_mod(field, value_type, value, level, column)
            for field, value_type, level, column, value
            in WGL.warglaive_attack_speed_mods()
        ],
    )
    set_object_mod_value(
        sources["w3a"], "w3a", "A116", "aite", 0, 0, 1
    )
    replace_object_mod_values(
        sources["w3a"],
        "w3a",
        "A113",
        [
            ("aart", 0, 0, GARREK_CHARGE_ICON),
            ("arar", 0, 0, GARREK_CHARGE_ICON),
            ("atp1", 1, 0, "雷霆冲锋"),
            ("aub1", 1, 0, WARGLAIVE_CHARGE_DESCRIPTION),
        ],
    )
    _version, item_entries = read_objects_from_path(sources["w3t"], "w3t")
    item = next(
        entry for entry in item_entries
        if entry[2].replace("\0", "") == "I106"
    )
    item_fields = {mod[0]: mod[4] for mod in item[3]}
    expected_item = {
        "iabi": f"{WGL.SPELLBOOK_ID},Aclq",
        "icid": WGL.SPELLBOOK_ID,
        "iico": DEMON_WARGLAIVE_ICON,
        "ifil": "Chest_Legendary.mdx",
        "ides": WARGLAIVE_ITEM_DESCRIPTION,
    }
    for field_id, expected in expected_item.items():
        actual = decode_value(item_fields.get(field_id, b""))
        if actual != expected:
            raise SystemExit(
                "I106.%s mismatch: %r" %
                (field_id, actual)
            )
    _version, ability_entries = read_objects_from_path(sources["w3a"], "w3a")
    charge = next(
        entry for entry in ability_entries
        if entry[2].replace("\0", "") == "A113"
    )
    charge_fields = {mod[0]: mod[4] for mod in charge[3]}
    for field_id in ("aart", "arar"):
        actual = decode_value(charge_fields.get(field_id, b""))
        if actual != GARREK_CHARGE_ICON:
            raise SystemExit(
                "A113.%s mismatch: %r" %
                (field_id, actual)
            )
    if charge[1] != "ANcl":
        raise SystemExit("A113 base must be ANcl, got %r" % charge[1])
    if "abuf" in charge_fields:
        raise SystemExit("A113 must not reference native charge buffs")


def patch_frostmourne_source(sources: dict[str, Path]) -> None:
    replace_string_mods(
        sources["w3t"],
        "w3t",
        "I105",
        {
            "unam": "|cffff8c00霜之哀伤|r",
            "utip": "霜之哀伤",
            "utub": FROSTMOURNE_ITEM_TOOLTIP,
            "ides": FROSTMOURNE_ITEM_DESCRIPTION,
        },
    )
    set_object_mod_value(
        sources["w3t"], "w3t", "I105", "iabi",
        level=0, column=0, value="A106,A108,A109",
    )
    set_object_mod_value(
        sources["w3t"], "w3t", "I105", "iusa",
        level=0, column=0, value=0,
    )
    set_object_mod_value(
        sources["w3t"], "w3t", "I105", "icid",
        level=0, column=0, value="",
    )
    set_object_mod_value(
        sources["w3t"], "w3t", "I105", "ihot",
        level=0, column=0, value="",
    )
    add_custom_ability(
        sources["w3a"],
        "A105",
        "ANcl",
        [
            ability_mod("anam", 3, "冰封践踏"),
            ability_mod("aart", 3, FROSTMOURNE_ACTIVE_ICON),
            ability_mod("arar", 3, FROSTMOURNE_ACTIVE_ICON),
            ability_mod("aret", 3, "冰封践踏"),
            ability_mod("arhk", 3, "D"),
            ability_mod("ahky", 3, "D"),
            ability_mod("aani", 3, "stand"),
            ability_mod("aord", 3, "froststomp"),
            ability_mod("atp1", 3, "冰封践踏", level=1),
            ability_mod("aub1", 3, FROSTMOURNE_ACTIVE_TOOLTIP, level=1),
            ability_mod("alev", 0, 1),
            ability_mod("aite", 0, 0),
            ability_mod("aher", 0, 0),
            ability_mod("Ncl1", 2, 0.0, level=1, column=1),
            ability_mod("Ncl2", 0, 0, level=1, column=2),
            ability_mod("Ncl3", 0, 1, level=1, column=3),
            ability_mod("Ncl4", 2, 0.0, level=1, column=4),
            ability_mod("Ncl5", 0, 0, level=1, column=5),
            ability_mod("Ncl6", 3, "froststomp", level=1, column=6),
            ability_mod("acdn", 2, 10.0, level=1),
            ability_mod("amcs", 0, 100, level=1),
            ability_mod("acat", 3, ""),
            ability_mod("arpx", 0, 2),
            ability_mod("aubx", 0, 1),
        ],
    )


def strip_mdx_chunks(data: bytes, removed_tags: set[bytes]) -> bytes:
    if not data.startswith(b"MDLX"):
        raise SystemExit("not an MDX file")
    output = bytearray(data[:4])
    position = 4
    while position + 8 <= len(data):
        tag = data[position:position + 4]
        size = int.from_bytes(data[position + 4:position + 8], "little")
        end = position + 8 + size
        if size < 0 or end > len(data):
            raise SystemExit("truncated MDX chunk " + tag.decode("latin-1"))
        if tag not in removed_tags:
            output.extend(data[position:end])
        position = end
    if position != len(data):
        raise SystemExit("trailing bytes in MDX")
    return bytes(output)


def make_assets(work: Path) -> list[tuple[Path, str]]:
    assets_dir = work / "assets"
    assets_dir.mkdir(parents=True, exist_ok=True)
    assets: list[tuple[Path, str]] = []
    for filename, internal in FR_ASSETS:
        source = ROOT / "heroes" / "frostmourne" / "assets" / filename
        assets.append((source, internal))
    assets.extend(ICON_ASSETS)
    for filename, internal in P.WING_MODELS:
        source = Path(P.model_src(filename))
        if filename.lower() == "stormfallred.mdx":
            cleaned = assets_dir / filename
            cleaned.write_bytes(
                strip_mdx_chunks(source.read_bytes(), {b"EVTS"})
            )
            if b"EVTS" in cleaned.read_bytes():
                raise SystemExit("StormfallRed.mdx sound events remain")
            source = cleaned
        assets.append((source, internal))

    game = None
    game = OBJ.GameBase(locale="zhcn", balance=None)
    impact_data = game.casc.read_data(SILENT_HIT_IMPACT_SOURCE)
    if not impact_data.startswith(b"MDLX"):
        raise SystemExit("DemonBoltImpact source is not an MDX")
    silent_impact = assets_dir / "DemonBoltImpactSilent.mdx"
    silent_impact.write_bytes(
        strip_mdx_chunks(impact_data, {b"EVTS"})
    )
    if b"EVTS" in silent_impact.read_bytes():
        raise SystemExit("DemonBoltImpactSilent.mdx sound events remain")
    assets.append((silent_impact, SILENT_HIT_IMPACT_PATH))

    for internal in (DEMON_WARGLAIVE_ICON, DEMON_WARGLAIVE_DISABLED):
        cached = OFFLINE_ICON_DIR / Path(internal).name
        if cached.is_file():
            assets.append((cached, internal))
            continue
        if game is None:
            game = OBJ.GameBase(locale="zhcn", balance=None)
        data = game.casc.read_data("war3.w3mod:" + internal.lower())
        if not data or not data.startswith(b"BLP"):
            raise SystemExit("CASC icon missing: " + internal)
        local = assets_dir / Path(internal).name
        local.write_bytes(data)
        assets.append((local, internal))

    cached_charge = OFFLINE_ICON_DIR / "BTNGarrekCharge.blp"
    cached_disabled = OFFLINE_ICON_DIR / "DISBTNGarrekCharge.blp"
    if cached_charge.is_file() and cached_disabled.is_file():
        assets.append((cached_charge, GARREK_CHARGE_ICON))
        assets.append((cached_disabled, GARREK_CHARGE_DISABLED))
    else:
        if game is None:
            game = OBJ.GameBase(locale="zhcn", balance=None)
        charge_data = game.casc.read_data(GARREK_CHARGE_SOURCE)
        charge_icon = Image.open(io.BytesIO(charge_data)).convert("RGBA")
        charge_icon = charge_icon.resize((64, 64), Image.Resampling.LANCZOS)
        charge_local = assets_dir / "BTNGarrekCharge.blp"
        blpwrite.save_blp(charge_icon, str(charge_local), mipmaps=False)
        disabled_icon = ImageOps.grayscale(charge_icon)
        disabled_icon = disabled_icon.point(lambda px: int(px * 0.35))
        disabled_icon = disabled_icon.convert("RGBA")
        disabled_icon.putalpha(charge_icon.getchannel("A"))
        disabled_local = assets_dir / "DISBTNGarrekCharge.blp"
        blpwrite.save_blp(disabled_icon, str(disabled_local), mipmaps=False)
        assets.append((charge_local, GARREK_CHARGE_ICON))
        assets.append((disabled_local, GARREK_CHARGE_DISABLED))
    deduped: dict[str, tuple[Path, str]] = {}
    for path, internal in assets:
        deduped.setdefault(internal.lower(), (path, internal))
    assets = list(deduped.values())
    for path, _internal in assets:
        if not path.is_file():
            raise SystemExit("missing asset: " + str(path))
        if path.suffix.lower() == ".mdx" and not path.read_bytes().startswith(b"MDLX"):
            raise SystemExit("not an MDX asset: " + str(path))
        if path.suffix.lower() == ".blp" and not path.read_bytes().startswith(b"BLP"):
            raise SystemExit("not a BLP asset: " + str(path))
    return assets


ALAS_LOAD_SYNC = r"""
function ALAS_GrantArtifact takes unit u, integer itemId returns nothing
    if u == null or GetUnitTypeId(u) == 0 then
        return
    endif
    if itemId == 'I103' then
        if not WG_ITEM_ACTIVE then
            if GetUnitAbilityLevel(u, 'A100') == 0 then
                call UnitAddAbility(u, 'A100')
                call UnitMakeAbilityPermanent(u, true, 'A100')
            endif
            call WG_FingerSync(u)
        else
            call WG_HandSyncUnit(u)
        endif
    elseif itemId == 'I105' then
        if not FR_ITEM_ACTIVE then
            if GetUnitAbilityLevel(u, 'A105') == 0 then
                call UnitAddAbility(u, 'A105')
                call UnitMakeAbilityPermanent(u, true, 'A105')
            endif
            call FR_SyncAbility(u)
        endif
    elseif itemId == 'I106' then
        if not WGL_ITEM_ACTIVE then
            if GetUnitAbilityLevel(u, 'A113') == 0 then
                call UnitAddAbility(u, 'A113')
                call UnitMakeAbilityPermanent(u, true, 'A113')
            endif
            call WGL_SyncUnit(u)
        endif
    endif
endfunction

function ALAS_SyncLoadedEquipment takes nothing returns nothing
    local group g = CreateGroup()
    local unit u
    call GroupEnumUnitsInRect(g, bj_mapInitialPlayableArea, null)
    loop
        set u = FirstOfGroup(g)
        exitwhen u == null
        call GroupRemoveUnit(g, u)
        if IsUnitType(u, UNIT_TYPE_HERO) then
            call WG_HandSyncUnit(u)
            call FR_SyncAbility(u)
            call WGL_SyncUnit(u)
        endif
    endloop
    call DestroyGroup(g)
    set g = null
    set u = null
endfunction

function ALAS_InitLoadSync takes nothing returns nothing
    local trigger t = CreateTrigger()
    call TriggerRegisterGameLoadedEventBJ(t)
    call TriggerAddAction(t, function ALAS_SyncLoadedEquipment)
    call TimerStart(CreateTimer(), 0.45, false, function ALAS_SyncLoadedEquipment)
    call TimerStart(CreateTimer(), 1.25, false, function ALAS_SyncLoadedEquipment)
    call TimerStart(CreateTimer(), 2.50, false, function ALAS_SyncLoadedEquipment)
    set t = null
endfunction
"""


def build_lua_module(
    work: Path, browser_dir: Path, item_active: bool
) -> bytes:
    wing_globals = (WING_DIR / "g.j").read_text(encoding="utf-8")
    wing_functions = (WING_DIR / "f.j").read_text(encoding="utf-8")
    fr_globals = (FR_DIR / "g.j").read_text(encoding="utf-8")
    fr_functions = (FR_DIR / "f.j").read_text(encoding="utf-8")
    browser_globals = (browser_dir / "g.j").read_text(
        encoding="utf-8", errors="surrogateescape"
    )
    browser_functions = (browser_dir / "f.j").read_text(
        encoding="utf-8", errors="surrogateescape"
    )
    wing_globals = wing_globals.replace(
        "boolean WG_ITEM_ACTIVE = false",
        "boolean WG_ITEM_ACTIVE = " + ("true" if item_active else "false"),
        1,
    )
    fr_globals = fr_globals.replace(
        "boolean FR_ITEM_ACTIVE = false",
        "boolean FR_ITEM_ACTIVE = " + ("true" if item_active else "false"),
        1,
    )
    wgl_globals = WGL.WGL_V3_GLOBALS.replace(
        "boolean WGL_ITEM_ACTIVE = false",
        "boolean WGL_ITEM_ACTIVE = " + ("true" if item_active else "false"),
        1,
    )

    source = (
        "globals\n"
        + wing_globals + "\n"
        + fr_globals + "\n"
        + wgl_globals + "\n"
        + browser_globals + "\n"
        + "endglobals\n"
        + wing_functions + "\n"
        + fr_functions + "\n"
        + WGL.WGL_V3_FUNCTIONS + "\n"
        + browser_functions + "\n"
        + ALAS_LOAD_SYNC + "\n"
    )
    lua = LUA_PORT.transpile(source, "forsaken-301-item-skill")
    lua = re.sub(
        r"\bib_(itemNameGbk|unitNameGbk)\[(\d+)\] = \"[^\"]*\"",
        lambda m: "ib_%s[%s] = ib_%s[%s]" % (
            m.group(1),
            m.group(2),
            "itemName" if m.group(1) == "itemNameGbk" else "unitName",
            m.group(2),
        ),
        lua,
    )
    tail = r"""
local __alasQtActive = false
local function __alasKeepFullMap()
  FogEnable(false)
  FogMaskEnable(false)
end
local function __alasEnableFullMap()
  if __alasQtActive then
    return
  end
  __alasQtActive = true
  __alasKeepFullMap()
  TimerStart(CreateTimer(), 0.50, true, __alasKeepFullMap)
end
local function __alasOnQtCommand()
  __alasEnableFullMap()
end
local __alasInitTimer = CreateTimer()
TimerStart(__alasInitTimer, 0.20, false, function()
  local function __alasRunInit(name, init)
    local ok = pcall(init)
    if not ok then
      DisplayTextToPlayer(Player(0), 0, 0, "|cffff0000[ALAS] " .. name .. "初始化失败|r")
    end
  end
  __alasRunInit("WG", WG_Init)
  __alasRunInit("IB", IB_Init)
  __alasRunInit("FR", FR_Init)
  __alasRunInit("WGL", WGL_Init)
  __alasRunInit("LOAD", ALAS_InitLoadSync)
  local __alasQtTrigger = CreateTrigger()
  for __alasQtPlayer = 0, 11 do
    TriggerRegisterPlayerChatEvent(__alasQtTrigger, Player(__alasQtPlayer), "qt", true)
    TriggerRegisterPlayerChatEvent(__alasQtTrigger, Player(__alasQtPlayer), "QT", true)
  end
  TriggerAddAction(__alasQtTrigger, __alasOnQtCommand)
  DisplayTextToPlayer(Player(0), 0, 0, "输入 qt 开全图")
  DisplayTextToPlayer(Player(0), 0, 0, "|cff00ff00[物品/技能/翅膀]|r 已加载")
end)
end
"""
    runtime = LUA_PORT.RUNTIME_HEAD.replace(
        "if bj_lastCreatedGroup == nil then bj_lastCreatedGroup = CreateGroup() end\n",
        "",
        1,
    )
    if "local function __cat(a, b)" in runtime:
        raise SystemExit("runtime __cat still drops arguments after the second")
    module = (runtime + "\n" + lua + "\n" + tail).encode("utf-8")
    lua_ast.parse(module.decode("utf-8"))
    suffix = "item" if item_active else "command"
    (work / ("item-skill-wings-301-" + suffix + ".lua")).write_bytes(module)
    return MARKER + module


def patch_imports(data: bytes | None, internal_names: list[str]) -> bytes:
    if data:
        version, count = __import__("struct").unpack_from("<ii", data, 0)
        if version not in (1, 2):
            raise SystemExit("unsupported war3map.imp version %d" % version)
        out = bytearray(data)
    else:
        version = 2
        count = 0
        out = bytearray(__import__("struct").pack("<ii", version, 0))
    added = []
    for internal in internal_names:
        encoded = internal.replace("/", "\\").encode("ascii")
        if encoded + b"\0" not in out:
            added.append(encoded)
    if added:
        __import__("struct").pack_into(
            "<i", out, 4, count + len(added)
        )
        for encoded in added:
            out += b"\x0d" + encoded + b"\0"
    return bytes(out)


def merge_chapter_objects(
    chapter: Path,
    object_dir: Path,
    sources: dict[str, list[Path]],
    asset_names: list[str],
    item_active: bool,
) -> dict[str, bytes]:
    object_dir.mkdir(parents=True, exist_ok=True)
    archive = W.MPQArchive(str(chapter))
    try:
        original = {
            ext: archive.read_file("war3map." + ext)
            for ext in ("w3a", "w3t", "w3u", "w3h")
        }
        imp = archive.read_file("war3map.imp")
    finally:
        archive.close()
    output = {}
    for ext, source_paths in sources.items():
        with_levels = ext == "w3a"
        target = object_dir / ("base." + ext)
        if original.get(ext):
            target.write_bytes(original[ext])
        else:
            target.write_bytes(OBJ.write_objects_bytes(3, [], with_levels))
        merged = object_dir / ("merged." + ext)
        M.merge_files(
            str(merged),
            [str(target)] + [str(path) for path in source_paths],
            override_ids=set().union(
                *(object_ids(path, ext) for path in source_paths)
            ),
        )
        if ext in ("w3a", "w3t"):
            ITEM_RULES.patch_file(merged, ext)
        output["war3map." + ext] = merged.read_bytes()
    configure_equipment_ownership(object_dir, item_active)
    for ext in ("w3a", "w3t"):
        output["war3map." + ext] = (
            object_dir / ("merged." + ext)
        ).read_bytes()
    validate_managed_chapter_objects(object_dir, item_active)
    output["war3map.imp"] = patch_imports(imp, asset_names)
    return output


def validate_managed_chapter_objects(
    object_dir: Path, item_active: bool
) -> None:
    _, item_entries = read_objects_from_path(object_dir / "merged.w3t", "w3t")
    _, ability_entries = read_objects_from_path(object_dir / "merged.w3a", "w3a")

    def mapped(entries):
        result = {}
        for _table, old, new, mods in entries:
            ident = new.replace("\0", "")
            if ident:
                if ident in result:
                    raise SystemExit("duplicate managed object " + ident)
                result[ident] = (old.replace("\0", ""), mods)
        return result

    items = mapped(item_entries)
    abilities = mapped(ability_entries)
    if item_active:
        expected_items = {
            "I103": ("A100,A101,A102,W091", "A100"),
            "I105": ("A105,A106,A108,A109", "A105"),
            "I106": ("A113,A110,A111,Aclq", "A113"),
        }
    else:
        expected_items = {
            "I103": ("A101,A102,W091", ""),
            "I105": ("A106,A108,A109", ""),
            "I106": ("A110,A111,Aclq", ""),
        }
    for ident, (ability_list, cooldown_id) in expected_items.items():
        if ident not in items:
            raise SystemExit("missing managed item " + ident)
        mods = items[ident][1]
        if field_values(mods, "iabi")[-1] != ability_list:
            raise SystemExit(ident + " has stale item abilities")
        if field_values(mods, "icid")[-1] != cooldown_id:
            raise SystemExit(ident + " has stale cooldown ownership")
        if item_active:
            if field_values(mods, "icla")[-1] != "Equipment":
                raise SystemExit(ident + " is not classed as Equipment")
            if field_values(mods, "iequ")[-1] != "Trinket":
                raise SystemExit(ident + " does not use the Trinket slot")
            if field_values(mods, "iusa")[-1] != "0":
                raise SystemExit(ident + " must not be right-click usable")
    for ident in ("A105", "A113"):
        if ident not in abilities:
            raise SystemExit("missing managed ability " + ident)
    if abilities["A105"][0] != "ANcl":
        raise SystemExit("A105 does not use the managed instant base")
    if abilities["A113"][0] != "ANcl":
        raise SystemExit("A113 does not use the managed charge base")
    expected_aite = 0
    for ident in ("A100", "A105", "A113"):
        fields = {
            mod[0]: mod[4] for mod in abilities[ident][1]
        }
        if int(fields.get("aite", -1)) != expected_aite:
            raise SystemExit(
                "%s.aite=%r, expected %d"
                % (ident, fields.get("aite"), expected_aite)
            )
    spellbook_fields = {
        mod[0]: mod[4] for mod in abilities["A116"][1]
    }
    if int(spellbook_fields.get("aite", -1)) != 1:
        raise SystemExit("A116 must remain an internal item spellbook")
    for ident in (
        "A101", "A102", "W091",
        "A106", "A108", "A109",
        "A110", "A111",
    ):
        fields = {
            mod[0]: mod[4] for mod in abilities[ident][1]
        }
        if int(fields.get("aite", -1)) != 1:
            raise SystemExit(ident + " must remain an item passive")
    for ident in ("A100", "A105", "A113"):
        fields = {mod[0]: mod[4] for mod in abilities[ident][1]}
        if fields.get("abpx") != 2 or fields.get("abpy") != 1:
            raise SystemExit(ident + " command-card position is not 2,1")


def inject_chapter(
    source: Path,
    output: Path,
    module: bytes,
    object_files: dict[str, bytes],
    assets: list[tuple[Path, str]],
) -> None:
    archive = W.MPQArchive(str(source))
    try:
        old_lua = archive.read_file("war3map.lua")
    finally:
        archive.close()
    if not old_lua:
        raise SystemExit(str(source) + " has no war3map.lua")
    if MARKER in old_lua:
        raise SystemExit(str(source) + " already contains this item/skill module")
    with tempfile.TemporaryDirectory() as temp_name:
        temp = Path(temp_name)
        lua_path = temp / "war3map.lua"
        lua_path.write_bytes(old_lua + b"\n" + module)
        args: list[object] = [
            sys.executable, HERE / "inject_native.py", source,
            "--no-backup",
            "--file", str(lua_path) + "=war3map.lua",
            "--out", output,
        ]
        for internal, data in object_files.items():
            path = temp / internal
            path.write_bytes(data)
            args += ["--file", str(path) + "=" + internal]
        for source_path, internal in assets:
            args += [
                "--file", str(source_path) + "=" + internal,
                "--store", internal,
            ]
        run(args)

    check = W.MPQArchive(str(output))
    try:
        if MARKER not in (check.read_file("war3map.lua") or b""):
            raise SystemExit("Lua marker read-back failed for " + output.name)
        for internal, expected in object_files.items():
            if check.read_file(internal) != expected:
                raise SystemExit("object read-back mismatch: %s:%s" %
                                 (output.name, internal))
        for source_path, internal in assets:
            if check.read_file(internal) != source_path.read_bytes():
                raise SystemExit("asset read-back mismatch: %s:%s" %
                                 (output.name, internal))
    finally:
        check.close()


def validate_chapter(
    chapter: Path,
    expected_objects: dict[str, set[str]],
    item_active: bool,
) -> None:
    archive = W.MPQArchive(str(chapter))
    try:
        for ext, expected_ids in expected_objects.items():
            data = archive.read_file("war3map." + ext)
            if not data:
                raise SystemExit("%s: missing war3map.%s" %
                                 (chapter.name, ext))
            _version, entries = read_objects(
                archive, "war3map." + ext, ext == "w3a"
            )
            ids = {
                new.replace("\0", "")
                for _table, _old, new, _mods in entries
                if new.replace("\0", "")
            }
            missing = expected_ids - ids
            if missing:
                raise SystemExit("%s: missing %s objects %s" %
                                 (chapter.name, ext, ", ".join(sorted(missing))))
        script = (archive.read_file("war3map.lua") or b"")
        if script.count(MARKER) != 1:
            raise SystemExit("%s: module marker count is not one" %
                             chapter.name)
        for token in (
            b"function WG_Init()",
            b"function FR_Init()",
            b"function WGL_Init()",
            b"function IB_Init()",
        ):
            if script.count(token) != 1:
                raise SystemExit("%s: expected one %r" %
                                 (chapter.name, token))
        if script.count(b"__alasInitTimer") != 2:
            raise SystemExit("%s: init timer marker count is not two" %
                             chapter.name)
        if b'__alasRunInit("WGL", WGL_Init)' not in script:
            raise SystemExit("%s: Warglaive init is not isolated" %
                             chapter.name)
        if b'__alasRunInit("LOAD", ALAS_InitLoadSync)' not in script:
            raise SystemExit("%s: equipment load recovery is missing" %
                             chapter.name)
        mode_value = b"true" if item_active else b"false"
        for mode_name in (
            b"WG_ITEM_ACTIVE", b"FR_ITEM_ACTIVE", b"WGL_ITEM_ACTIVE"
        ):
            expected_mode = mode_name + b" = " + mode_value
            if script.count(expected_mode) != 1:
                raise SystemExit(
                    "%s: %s ownership mode is not unique"
                    % (chapter.name, mode_name.decode("ascii"))
                )
        if item_active and b"BlzUnitItemInEquipmentSlot" not in script:
            raise SystemExit(
                "%s: equipped-item ownership checks are missing"
                % chapter.name
            )
        if b"TriggerAddCondition(WGL_ORDER_TRIGGER, Condition(" in script:
            raise SystemExit("%s: Warglaive order trigger depends on Condition" %
                             chapter.name)
        add_start = script.find(b"function IB_AddGive")
        add_end = script.find(b"function IB_AddStep", add_start)
        if add_start < 0 or add_end < 0:
            raise SystemExit("%s: item browser add path is missing" %
                             chapter.name)
        add_path = script[add_start:add_end]
        if b"ALAS_GrantArtifact(u, GetItemTypeId(it))" not in add_path:
            raise SystemExit(
                "%s: item browser add path does not grant the artifact skill"
                % chapter.name
            )
        if b"TriggerSleepAction(0.05)" in add_path:
            raise SystemExit(
                "%s: item browser add path still uses the ineffective delay"
                % chapter.name
            )
        pickup_start = script.find(b"function WG_OnArtifactPickup()")
        pickup_end = script.find(b"function ", pickup_start + 1)
        if pickup_start < 0 or pickup_end < 0:
            raise SystemExit(
                "%s: artifact pickup handler is missing"
                % chapter.name
            )
        if (
            not item_active
            and b"UnitAddAbility(u, 1093742899)" not in script[
                pickup_start:pickup_end
            ]
        ):
            raise SystemExit(
                "%s: artifact pickup does not add the Warglaive ability"
                % chapter.name
            )
    finally:
        archive.close()


def pack_campaign(
    source: Path, output: Path, staged: list[tuple[str, Path]]
) -> None:
    output.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(source, output)
    args: list[object] = [
        sys.executable, HERE / "inject_native.py", output,
        "--no-backup",
    ]
    for name, path in staged:
        args += ["--file", str(path) + "=" + name, "--store", name]
    run(args)

    original_archive = W.MPQArchive(str(source))
    output_archive = W.MPQArchive(str(output))
    replaced = {name for name, _path in staged}
    try:
        source_names = sorted(original_archive.listfile)
        output_names = sorted(output_archive.listfile)
        if source_names != output_names:
            raise SystemExit("campaign entry list changed")
        for name in source_names:
            source_data = original_archive.read_file(name)
            output_data = output_archive.read_file(name)
            if name in replaced:
                expected = dict(staged)[name].read_bytes()
                if output_data != expected:
                    raise SystemExit("campaign read-back mismatch: " + name)
            elif output_data != source_data:
                raise SystemExit("untouched campaign entry changed: " + name)
    finally:
        original_archive.close()
        output_archive.close()


def main() -> int:
    global DEFAULT_OBJECT_SOURCE
    parser = argparse.ArgumentParser()
    parser.add_argument("--campaign", type=Path, default=DEFAULT_SOURCE)
    parser.add_argument("--work", type=Path, default=DEFAULT_WORK)
    parser.add_argument("--object-source", type=Path,
                        default=DEFAULT_OBJECT_SOURCE)
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    parser.add_argument("--config", default=WING_CONFIG)
    parser.add_argument("--no-deploy", action="store_true")
    args = parser.parse_args()

    DEFAULT_OBJECT_SOURCE = args.object_source.resolve()
    source = args.campaign.resolve()
    work = args.work.resolve()
    output = args.output.resolve()
    base = work / "base"
    if not source.is_file():
        raise SystemExit("campaign not found: " + str(source))
    if not DEFAULT_OBJECT_SOURCE.is_file():
        raise SystemExit("object source not found: " + str(DEFAULT_OBJECT_SOURCE))
    if not base.is_dir():
        raise SystemExit("extract the campaign first with port_wings_campaign.py extract")
    work.mkdir(parents=True, exist_ok=True)

    wing_sources = prepare_wings(work, args.config)
    weapon_sources = extract_object_sources(work)
    patch_frostmourne_source(weapon_sources)
    patch_warglaive_sources(weapon_sources)
    sources = {
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
    expected_objects = {
        ext: set().union(*(object_ids(path, ext) for path in paths))
        for ext, paths in sources.items()
    }
    item_count, skill_count = build_tables(work, source, wing_sources)
    print("tables: %d items, %d skills" % (item_count, skill_count))
    browser_dir = prepare_browser(work, expected_objects["w3a"])
    assets = make_assets(work)
    module_command = build_lua_module(work, browser_dir, False)
    module_item = build_lua_module(work, browser_dir, True)
    asset_names = [internal for _path, internal in assets]

    chapters = sorted(
        path for path in base.iterdir()
        if path.suffix.lower() in (".w3x", ".w3m")
    )
    if not chapters:
        raise SystemExit("no chapters found in " + str(base))

    staged_dir = work / "_staged_item_skill_301"
    if staged_dir.exists():
        for path in staged_dir.iterdir():
            if path.is_file():
                path.unlink()
    staged_dir.mkdir(parents=True, exist_ok=True)
    staged = []
    item_active_chapters = 0
    for chapter in chapters:
        item_active = chapter_uses_item_actives(chapter)
        if item_active:
            item_active_chapters += 1
        print(
            "chapter: %s (%s skills)"
            % (chapter.name, "item-owned" if item_active else "command-card"),
            flush=True,
        )
        object_dir = work / "_obj_item_skill_301" / chapter.stem
        merged = merge_chapter_objects(
            chapter, object_dir, sources, asset_names, item_active
        )
        target = staged_dir / chapter.name
        module = module_item if item_active else module_command
        inject_chapter(chapter, target, module, merged, assets)
        validate_chapter(target, expected_objects, item_active)
        staged.append((chapter.name, target))

    pack_campaign(source, output, staged)
    import fix_alas_campaign_names as NAMES
    archive = W.MPQArchive(str(output))
    try:
        old_w3f = archive.read_file("war3campaign.w3f") or b""
    finally:
        archive.close()
    display_name = NAMES.desired_title(output)
    NAMES.patch_with_mpq(
        output,
        NAMES.make_w3f(old_w3f, display_name),
        work / "recover" / "alas_campaign_names_20261030",
    )
    print("verified chapters:", len(staged))
    print(
        "equipment ownership: %d item-owned, %d command-card"
        % (item_active_chapters, len(staged) - item_active_chapters)
    )
    print("display name:", display_name)
    print("output:", output)
    print("bytes:", output.stat().st_size)
    print("sha256:", __import__("hashlib").sha256(
        output.read_bytes()
    ).hexdigest().upper())
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
