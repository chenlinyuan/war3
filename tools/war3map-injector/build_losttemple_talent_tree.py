#!/usr/bin/env python3
"""Build the six-tier LostTemple talent tree with complete ALAS equipment."""

from __future__ import annotations

import argparse
import os
import shutil
import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
DOCTOR = ROOT / "tools" / "_devos-map-doctor" / "devos-map-doctor-main"
sys.path.insert(0, str(HERE))
sys.path.insert(0, str(DOCTOR))

import objparse as O  # noqa: E402
import war3mpq as W  # noqa: E402
from doctor.data import objects as DOBJ  # noqa: E402

OPENER_ID = "ATal"
MARKER_ID = "T405"
ARTIFACT_MARKER_ID = "T480"
HERO_POOL_SIZE = 64
TALENT_ID_BASE = "Q000"
BACKPACK_ID_BASE = "Z000"
EQUIPMENT_IDS = (
    "I100", "I101", "I102", "I103", "I104", "I105", "I106",
)
TIER_COUNT = 6
CHOICES_PER_TIER = 3
CHOICE_START = 100
CHILD_START = 200
FULL_PORT = HERE / "port_alas_jass_map.py"
TALENT_SCRIPT = ROOT / "scripts" / "talent-test"
WING_CONFIG = "wings_config_forsaken_301"
OBJECT_TEMPLATE = (
    ROOT / "maps" / "LostTemple"
    / "alasLostTempleLV_Clean_UniversalBackpack_Fix_v16.w3x"
)

DEFAULT_SOURCE = Path(
    r"C:\Users\Administrator\Desktop"
    r"\LostTempleLV_Clean_UniversalBackpack.w3x"
)
DEFAULT_OUTPUT = (
    ROOT / "maps" / "alas LostTempleLV_TalentTree.w3x"
)
DEFAULT_WORK = (
    ROOT / "maps" / "port" / "lost_temple_talent_tree"
)

ICON_STR = r"ReplaceableTextures\CommandButtons\BTNBelt.blp"
ICON_AGI = (
    r"ReplaceableTextures\CommandButtons\BTNSlippersOfAgility.blp"
)
ICON_INT = r"ReplaceableTextures\CommandButtons\BTNBrilliance.dds"
ICON_LIFE = r"ReplaceableTextures\CommandButtons\BTNRejuvenation.dds"
ICON_MANA = r"ReplaceableTextures\CommandButtons\BTNWellSpring.dds"
ICON_BALANCE = r"ReplaceableTextures\CommandButtons\BTNSpiritLink.dds"
ICON_MOVEMENT = r"ReplaceableTextures\CommandButtons\BTNBlink.dds"
ICON_TALENT = r"ReplaceableTextures\CommandButtons\BTNTomeRed.blp"
ICON_HAND = (
    r"ReplaceableTextures\CommandButtons"
    r"\BTNArchimondeHand_30HD.blp"
)
ICON_GLAIVE = (
    r"ReplaceableTextures\CommandButtons"
    r"\BTNDemonicWarglaives.blp"
)
ICON_FROST = (
    r"ReplaceableTextures\CommandButtons"
    r"\BTNFrostmourne_30HD.blp"
)
ICON_BACKPACK = (
    r"ReplaceableTextures\CommandButtons\BTNbackpack.blp"
)
BACKPACK_TOOLTIP = (
    "打开后可查看 30 格背包、装备栏、属性面板和天赋面板。"
)


def mod(
    field_id: str,
    value: object,
    kind: int | None = None,
    *,
    level: int = 0,
    column: int = 0,
) -> tuple[str, int, int, int, object]:
    if kind is None:
        if isinstance(value, str):
            kind = O.T_STRING
        elif isinstance(value, float):
            kind = O.T_UNREAL
        else:
            kind = O.T_INT
    return field_id, kind, level, column, value


def node_id(tier: int, choice: int) -> str:
    return "T%03d" % (CHOICE_START + tier * CHOICES_PER_TIER + choice)


def child_id(index: int) -> str:
    return "T%03d" % (CHILD_START + index)


def talent_pool_id(index: int) -> str:
    return "Q%03d" % index


def backpack_pool_id(index: int) -> str:
    return "Z%03d" % index


def ability_entry(
    ident: str,
    old: str,
    name: str,
    tip: str,
    *,
    extra: list[tuple[str, int, int, int, object]] | None = None,
    icon: str | None = None,
) -> dict[str, object]:
    mods = [
        mod("anam", name),
        mod("atp1", name, level=1),
        mod("aub1", tip, level=1),
        mod("alev", 1),
        mod("aite", 1),
        mod("aher", 0),
    ]
    if icon:
        mods.extend([mod("aart", icon), mod("arar", icon)])
    if extra:
        mods.extend(extra)
    return {"old": old, "new": ident, "mods": mods}


def attribute_entry(
    ident: str,
    name: str,
    icon: str,
    values: tuple[int, int, int],
    tip: str | None = None,
) -> dict[str, object]:
    return ability_entry(
        ident,
        "AIst",
        name,
        tip or name,
        icon=icon,
        extra=[
            mod("Istr", values[0], level=1, column=3),
            mod("Iagi", values[1], level=1, column=1),
            mod("Iint", values[2], level=1, column=2),
        ],
    )


def book_entry(
    ident: str,
    name: str,
    tip: str,
    children: list[str],
    icon: str = ICON_TALENT,
) -> dict[str, object]:
    return ability_entry(
        ident,
        "Aspb",
        name,
        tip,
        icon=icon,
        extra=[
            mod("spb1", ",".join(children), level=1, column=1),
            mod("spb3", len(children), level=1, column=3),
            mod("spb4", len(children), level=1, column=4),
            mod("spb5", "spellbook", level=1, column=5),
            mod("abpx", 0),
            mod("abpy", -11),
        ],
    )


def talent_entry(ident: str) -> dict[str, object]:
    mods = [
        mod("anam", "通用天赋"),
        mod("aart", ICON_TALENT),
        mod("arar", ICON_TALENT),
        mod("atp1", "通用天赋", level=1),
        mod("aub1", "六层天赋，每层选择一个。", level=1),
        mod("alev", TIER_COUNT),
        mod("aite", 0),
        mod("aher", 0),
        mod("abpx", 0),
        mod("abpy", -11),
    ]
    for tier in range(TIER_COUNT):
        mods.append(mod(
            "aabi",
            ",".join(node_id(tier, choice) for choice in range(3)),
            level=tier + 1,
        ))
    return {"old": OPENER_ID, "new": ident, "mods": mods}


def backpack_entry(ident: str, talent: str) -> dict[str, object]:
    return {
        "old": "ratc",
        "new": ident,
        "mods": [
            mod("unam", "\u82f1\u96c4\u88c5\u5907\u80cc\u5305"),
            mod("utip", "\u82f1\u96c4\u88c5\u5907\u80cc\u5305"),
            mod("utub", BACKPACK_TOOLTIP),
            mod("iabi", "AIni,AEqu,ASde," + talent),
            mod("icid", "AIni"),
            mod("iico", ICON_BACKPACK),
            mod("icla", "Campaign"),
            mod("ilev", 0),
            mod("igol", 0),
            mod("ihtp", 75),
            mod("iusa", 1),
            mod("idro", 0),
            mod("ipaw", 0),
        ],
    }


def build_entries() -> list[dict[str, object]]:
    entries = [
        *[
            talent_entry(talent_pool_id(index))
            for index in range(HERO_POOL_SIZE)
        ],
        attribute_entry(MARKER_ID, "天赋初始化标记", ICON_TALENT, (0, 0, 0)),
        attribute_entry(
            ARTIFACT_MARKER_ID,
            "神器领取标记",
            ICON_TALENT,
            (0, 0, 0),
        ),
        *[
            attribute_entry(
                "T%03d" % (410 + index),
                "天赋点标记%d" % (index + 1),
                ICON_TALENT,
                (0, 0, 0),
            )
            for index in range(TIER_COUNT)
        ],
        book_entry(
            node_id(0, 0),
            "生生不息",
            "最大生命 +200，生命恢复 +6/秒。",
            [child_id(0), child_id(1)],
            icon=ICON_LIFE,
        ),
        book_entry(
            node_id(0, 1),
            "灵泉不竭",
            "最大魔法 +100，魔法恢复 +2/秒。",
            [child_id(2), child_id(3)],
            icon=ICON_MANA,
        ),
        book_entry(
            node_id(0, 2),
            "阴阳调和",
            "最大生命 +100，最大魔法 +50，生命恢复 +3/秒，魔法恢复 +1/秒。",
            [child_id(i) for i in range(4, 8)],
            icon=ICON_BALANCE,
        ),
        ability_entry(
            node_id(1, 0), "AIsx", "疾风骤雨", "攻击速度 +20%。",
            extra=[mod("Isx1", 0.20, O.T_UNREAL, level=1, column=1)],
        ),
        ability_entry(
            node_id(1, 1), "AIms", "踏雪无痕", "移动速度 +40。",
            extra=[mod("Imvb", 40, level=1, column=1)],
        ),
        book_entry(
            node_id(1, 2),
            "身法兼备",
            "攻击速度 +10%，移动速度 +20。",
            [child_id(8), child_id(9)],
            icon=ICON_MOVEMENT,
        ),
        attribute_entry(
            node_id(2, 0),
            "天生神力",
            ICON_STR,
            (10, 0, 0),
            tip="力量 +10。",
        ),
        attribute_entry(
            node_id(2, 1),
            "动如脱兔",
            ICON_AGI,
            (0, 10, 0),
            tip="敏捷 +10。",
        ),
        attribute_entry(
            node_id(2, 2),
            "灵台清明",
            ICON_INT,
            (0, 0, 10),
            tip="智力 +10。",
        ),
        ability_entry(
            node_id(3, 0),
            "ATcr",
            "心随意动",
            "主动技能冷却时间 -20%。",
            extra=[mod("Icr1", 0.20, O.T_UNREAL, level=1, column=1)],
        ),
        ability_entry(
            node_id(3, 1),
            "ATme",
            "灵犀一点",
            "主动技能魔法消耗 -30%。",
            extra=[mod("Ime1", 0.30, O.T_UNREAL, level=1, column=1)],
        ),
        ability_entry(
            node_id(3, 2),
            "AAPp",
            "奥术澎湃",
            "主动技能伤害 +20%。",
            extra=[mod("Isa1", 0.20, O.T_UNREAL, level=1, column=1)],
        ),
        ability_entry(
            node_id(4, 0),
            "AHss",
            "金刚不坏",
            "受到的所有伤害 -20%。",
            extra=[
                mod("Ssk1", 0.20, O.T_UNREAL, level=1, column=1),
                mod("Ssk2", 0.0, O.T_UNREAL, level=1, column=2),
                mod("Ssk3", 0.0, O.T_UNREAL, level=1, column=3),
                mod("Ssk4", 0, level=1, column=4),
                mod("Ssk5", 0, level=1, column=5),
            ],
        ),
        ability_entry(
            node_id(4, 1),
            "AOcr",
            "致命锋芒",
            "普通攻击有 20% 概率造成 2 倍伤害。",
            extra=[
                mod("Ocr1", 20.0, O.T_UNREAL, level=1, column=1),
                mod("Ocr2", 2.0, O.T_UNREAL, level=1, column=2),
            ],
        ),
        ability_entry(
            node_id(4, 2),
            "AEev",
            "鬼影迷踪",
            "普通攻击有 20% 概率被闪避。",
            extra=[mod("Eev1", 0.20, O.T_UNREAL, level=1, column=1)],
        ),
        attribute_entry(
            node_id(5, 0),
            "魔神之握",
            ICON_HAND,
            (0, 0, 0),
            tip="获得神器：阿克蒙德之手。",
        ),
        attribute_entry(
            node_id(5, 1),
            "邪刃契约",
            ICON_GLAIVE,
            (0, 0, 0),
            tip="获得神器：埃辛诺斯战刃。",
        ),
        attribute_entry(
            node_id(5, 2),
            "霜冠王座",
            ICON_FROST,
            (0, 0, 0),
            tip="获得神器：霜之哀伤。",
        ),
        ability_entry(
            child_id(0), "AIl3", "生命 +200", "最大生命 +200。",
            extra=[mod("Ilif", 200, level=1, column=1)],
        ),
        ability_entry(
            child_id(1), "Arel", "生命恢复 +6", "生命恢复 +6/秒。",
            extra=[mod("Ihpr", 6, level=1, column=1)],
        ),
        ability_entry(
            child_id(2), "AMMq", "魔法 +100", "最大魔法 +100。",
            extra=[mod("Iman", 100, level=1, column=1)],
        ),
        ability_entry(
            child_id(3), "AIrm", "魔法恢复 +2", "魔法恢复 +2/秒。",
            extra=[mod("Imrp", 2.0, O.T_UNREAL, level=1, column=1)],
        ),
        ability_entry(
            child_id(4), "AIl3", "生命 +100", "最大生命 +100。",
            extra=[mod("Ilif", 100, level=1, column=1)],
        ),
        ability_entry(
            child_id(5), "AMMq", "魔法 +50", "最大魔法 +50。",
            extra=[mod("Iman", 50, level=1, column=1)],
        ),
        ability_entry(
            child_id(6), "Arel", "生命恢复 +3", "生命恢复 +3/秒。",
            extra=[mod("Ihpr", 3, level=1, column=1)],
        ),
        ability_entry(
            child_id(7), "AIrm", "魔法恢复 +1", "魔法恢复 +1/秒。",
            extra=[mod("Imrp", 1.0, O.T_UNREAL, level=1, column=1)],
        ),
        ability_entry(
            child_id(8), "AIsx", "攻击速度 +10%", "攻击速度 +10%。",
            extra=[mod("Isx1", 0.10, O.T_UNREAL, level=1, column=1)],
        ),
        ability_entry(
            child_id(9), "AIms", "移动速度 +20", "移动速度 +20。",
            extra=[mod("Imvb", 20, level=1, column=1)],
        ),
    ]
    return entries


def build_item_entries() -> list[dict[str, object]]:
    return [
        backpack_entry(
            backpack_pool_id(index),
            talent_pool_id(index),
        )
        for index in range(HERO_POOL_SIZE)
    ]


def doctor_object(entry: dict[str, object]) -> tuple:
    mods = []
    for field_id, kind, level, column, value in entry["mods"]:
        if isinstance(value, str):
            value = value.encode("utf-8")
        mods.append((field_id, kind, level, column, value))
    return (1, entry["old"], entry["new"], mods)


def write_talent_objects(
    ability_path: Path,
    item_path: Path,
) -> None:
    data = DOBJ.write_objects_bytes(
        3,
        [doctor_object(entry) for entry in build_entries()],
        True,
    )
    ability_path.write_bytes(data)
    item_data = DOBJ.write_objects_bytes(
        2,
        [doctor_object(entry) for entry in build_item_entries()],
        False,
    )
    item_path.write_bytes(item_data)


def run_full_port(
    source: Path,
    output: Path,
    work: Path,
    talent_ability: Path,
    talent_item: Path,
) -> None:
    env = dict(os.environ)
    env.update({
        "PYTHONUTF8": "1",
        "PYTHONIOENCODING": "utf-8",
        "ALAS_EQUIPMENT_MODE": "command",
    })
    command = [
        sys.executable,
        str(FULL_PORT),
        "--map",
        str(source),
        "--work",
        str(work),
        "--config",
        WING_CONFIG,
        "--object-source",
        str(OBJECT_TEMPLATE),
        "--output",
        str(output),
        "--extra-script",
        str(TALENT_SCRIPT),
        "--extra-object",
        "w3a=" + str(talent_ability),
        "--extra-object",
        "w3t=" + str(talent_item),
        "--suppress-source-backpack-auto",
    ]
    result = subprocess.run(
        command,
        cwd=str(ROOT),
        env=env,
        text=True,
        encoding="utf-8",
        errors="replace",
    )
    if result.returncode:
        raise SystemExit("full ALAS talent build failed")


def verify(output: Path) -> None:
    archive = W.MPQArchive(str(output))
    try:
        ability = archive.read_file("war3map.w3a") or b""
        item = archive.read_file("war3map.w3t") or b""
        unit_data = archive.read_file("war3map.w3u") or b""
        script = archive.read_file("war3map.j") or b""
    finally:
        archive.close()
    version, entries, consumed = DOBJ.read_objects_bytes(
        ability, True, fname="war3map.w3a", with_end=True
    )
    if version != 3 or consumed != len(ability):
        raise SystemExit("invalid w3a")
    abilities = {
        new.replace("\0", ""): (table, old.replace("\0", ""), mods)
        for table, old, new, mods in entries
        if new.replace("\0", "")
    }
    _item_version, _item_original, item_entries = O.read_bytes(item, "w3t")
    items = {entry["new"]: entry for entry in item_entries}
    for ident in ("I103", "I105", "I106"):
        if ident not in items:
            raise SystemExit("artifact missing: " + ident)
    for index in range(HERO_POOL_SIZE):
        talent = talent_pool_id(index)
        backpack = backpack_pool_id(index)
        master = abilities.get(talent)
        if (
            master is None
            or master[0] != 1
            or master[1] != OPENER_ID
        ):
            raise SystemExit("talent master missing: " + talent)
        master_fields = {}
        for m in master[2]:
            value = (
                m[4].decode("utf-8", "replace")
                if isinstance(m[4], bytes)
                else m[4]
            )
            master_fields[m[0]] = value
            master_fields[(m[0], m[2])] = value
        if master_fields.get("alev") != TIER_COUNT:
            raise SystemExit("wrong tier count: " + talent)
        for tier in range(TIER_COUNT):
            expected = ",".join(
                node_id(tier, choice) for choice in range(3)
            )
            if master_fields.get(("aabi", tier + 1)) != expected:
                raise SystemExit(
                    "tier mapping mismatch: %s tier %d"
                    % (talent, tier + 1)
                )
        bag = items.get(backpack)
        if bag is None:
            raise SystemExit("hero backpack missing: " + backpack)
        bag_fields = {}
        for field, kind, level, column, value in bag["mods"]:
            if isinstance(value, bytes):
                value = value.decode("utf-8", "replace")
            bag_fields[field] = value
        expected_iabi = "AIni,AEqu,ASde," + talent
        if bag_fields.get("iabi") != expected_iabi:
            raise SystemExit(
                "backpack talent mismatch: %s" % backpack
            )
        if bag_fields.get("icid") != "AIni":
            raise SystemExit("backpack primary action mismatch: " + backpack)
        expected_bag_fields = {
            "unam": "\u82f1\u96c4\u88c5\u5907\u80cc\u5305",
            "utip": "\u82f1\u96c4\u88c5\u5907\u80cc\u5305",
            "utub": BACKPACK_TOOLTIP,
            "iico": ICON_BACKPACK,
            "icla": "Campaign",
            "ilev": 0,
            "igol": 0,
            "ihtp": 75,
            "iusa": 1,
            "idro": 0,
            "ipaw": 0,
        }
        for field, expected in expected_bag_fields.items():
            if bag_fields.get(field) != expected:
                raise SystemExit(
                    "%s.%s mismatch: %r != %r"
                    % (backpack, field, bag_fields.get(field), expected)
                )
    def talent_fields(ident: str) -> dict[object, object]:
        fields = {}
        for m in abilities[ident][2]:
            value = (
                m[4].decode("utf-8", "replace")
                if isinstance(m[4], bytes)
                else m[4]
            )
            fields[m[0]] = value
            fields[(m[0], m[2])] = value
        return fields

    def field_matches(actual: object, expected: object) -> bool:
        if isinstance(expected, float) and isinstance(actual, (int, float)):
            return abs(float(actual) - expected) < 0.0001
        return actual == expected

    expected_talents = {
        "T100": {
            "spb1": child_id(0) + "," + child_id(1),
            "atp1": "生生不息",
            "aub1": "最大生命 +200，生命恢复 +6/秒。",
            "aart": ICON_LIFE,
            "arar": ICON_LIFE,
        },
        "T101": {
            "spb1": child_id(2) + "," + child_id(3),
            "atp1": "灵泉不竭",
            "aub1": "最大魔法 +100，魔法恢复 +2/秒。",
            "aart": ICON_MANA,
            "arar": ICON_MANA,
        },
        "T102": {
            "spb1": ",".join(child_id(i) for i in range(4, 8)),
            "atp1": "阴阳调和",
            "aub1": "最大生命 +100，最大魔法 +50，生命恢复 +3/秒，魔法恢复 +1/秒。",
            "aart": ICON_BALANCE,
            "arar": ICON_BALANCE,
        },
        "T103": {
            ("Isx1", 1): 0.2,
            "atp1": "疾风骤雨",
            "aub1": "攻击速度 +20%。",
        },
        "T104": {
            ("Imvb", 1): 40,
            "atp1": "踏雪无痕",
            "aub1": "移动速度 +40。",
        },
        "T105": {
            "spb1": child_id(8) + "," + child_id(9),
            "atp1": "身法兼备",
            "aub1": "攻击速度 +10%，移动速度 +20。",
            "aart": ICON_MOVEMENT,
            "arar": ICON_MOVEMENT,
        },
        "T106": {
            ("Istr", 1): 10,
            "atp1": "天生神力",
            "aub1": "力量 +10。",
        },
        "T107": {
            ("Iagi", 1): 10,
            "atp1": "动如脱兔",
            "aub1": "敏捷 +10。",
            "aart": ICON_AGI,
            "arar": ICON_AGI,
        },
        "T108": {
            ("Iint", 1): 10,
            "atp1": "灵台清明",
            "aub1": "智力 +10。",
            "aart": ICON_INT,
            "arar": ICON_INT,
        },
        "T109": {
            ("Icr1", 1): 0.2,
            "atp1": "心随意动",
            "aub1": "主动技能冷却时间 -20%。",
        },
        "T110": {
            ("Ime1", 1): 0.3,
            "atp1": "灵犀一点",
            "aub1": "主动技能魔法消耗 -30%。",
        },
        "T111": {
            ("Isa1", 1): 0.2,
            "atp1": "奥术澎湃",
            "aub1": "主动技能伤害 +20%。",
        },
        "T112": {
            ("Ssk1", 1): 0.2,
            "atp1": "金刚不坏",
            "aub1": "受到的所有伤害 -20%。",
        },
        "T113": {
            ("Ocr1", 1): 20.0,
            ("Ocr2", 1): 2.0,
            "atp1": "致命锋芒",
            "aub1": "普通攻击有 20% 概率造成 2 倍伤害。",
        },
        "T114": {
            ("Eev1", 1): 0.2,
            "atp1": "鬼影迷踪",
            "aub1": "普通攻击有 20% 概率被闪避。",
        },
        "T115": {
            "atp1": "魔神之握",
            "aub1": "获得神器：阿克蒙德之手。",
        },
        "T116": {
            "atp1": "邪刃契约",
            "aub1": "获得神器：埃辛诺斯战刃。",
        },
        "T117": {
            "atp1": "霜冠王座",
            "aub1": "获得神器：霜之哀伤。",
        },
    }
    for ident, expected in expected_talents.items():
        if ident not in abilities:
            raise SystemExit("talent node missing: " + ident)
        fields = talent_fields(ident)
        for key, value in expected.items():
            if not field_matches(fields.get(key), value):
                raise SystemExit(
                    "%s field mismatch: %r != %r"
                    % (ident, fields.get(key), value)
                )
    for index, expected in (
        (0, ("Ilif", 1, 200)),
        (1, ("Ihpr", 1, 6)),
        (2, ("Iman", 1, 100)),
        (3, ("Imrp", 1, 2.0)),
        (4, ("Ilif", 1, 100)),
        (5, ("Iman", 1, 50)),
        (6, ("Ihpr", 1, 3)),
        (7, ("Imrp", 1, 1.0)),
        (8, ("Isx1", 1, 0.10)),
        (9, ("Imvb", 1, 20)),
    ):
        ident = child_id(index)
        fields = talent_fields(ident)
        field, level, value = expected
        if not field_matches(fields.get((field, level)), value):
            raise SystemExit(
                "%s field mismatch: %r != %r"
                % (
                    ident,
                    fields.get((field, level)),
                    value,
                )
            )
    avatar = abilities.get("W024")
    if avatar is None or avatar[1] != "ANcl":
        raise SystemExit("Demon Wings avatar must use inert ANcl")
    avatar_fields = {}
    for m in avatar[2]:
        value = (
            m[4].decode("utf-8", "replace")
            if isinstance(m[4], bytes)
            else m[4]
        )
        avatar_fields[m[0]] = value
        avatar_fields[(m[0], m[2])] = value
    if avatar_fields.get(("Ncl2", 1)) != 0:
        raise SystemExit("Demon Wings avatar must be a no-target active")
    if "abuf" in avatar_fields or "Hav1" in avatar_fields:
        raise SystemExit("Demon Wings avatar still contains Vampiric Aura data")
    expected_aura_buffs = {
        "W070": "BUau",
        "W071": "BUav",
        "W073": "BHab",
        "W076": "BOac",
        "W077": "BOae",
        "A101": "B641",
    }
    for ident, expected_buff in expected_aura_buffs.items():
        entry = abilities.get(ident)
        if entry is None:
            raise SystemExit("aura ability missing: " + ident)
        actual_buff = next(
            (m[4] for m in entry[2] if m[0] == "abuf"),
            None,
        )
        if isinstance(actual_buff, bytes):
            actual_buff = actual_buff.decode("utf-8", "replace")
        if actual_buff != expected_buff:
            raise SystemExit(
                "%s buff mismatch: %r != %r"
                % (ident, actual_buff, expected_buff)
            )
    base_backpack = items.get("B30B")
    if base_backpack is None:
        raise SystemExit("base B30B missing")
    base_iabi = next(
        m[4] for m in base_backpack["mods"] if m[0] == "iabi"
    )
    if not isinstance(base_iabi, str):
        base_iabi = base_iabi.decode("utf-8", "replace")
    if any(talent_pool_id(i) in base_iabi for i in range(HERO_POOL_SIZE)):
        raise SystemExit("base B30B still uses a shared talent tree")
    for ident in EQUIPMENT_IDS:
        if ident.encode("ascii") in unit_data:
            raise SystemExit(
                "equipment appears in a wild unit drop definition: " + ident
            )
    for marker in (
        b"call UnitAddAbility(u, 'T405')",
        b"function TT_IsTalentHero takes unit u returns boolean",
        b"GetPlayerController(p) == MAP_CONTROL_USER",
        b"function TT_EnsureBackpack takes unit u, integer heroIndex returns boolean",
        b"if not TT_EnsureBackpack(u, heroIndex) then",
        b"call TT_ResetNativeTalents(u)",
        b"function TT_TalentId takes integer heroIndex returns integer",
        b"function TT_BackpackId takes integer heroIndex returns integer",
        b"function TT_HideTalentBooks takes unit u returns nothing",
        b"if GetUnitAbilityLevel(u, 'T100') > 0 then",
        b"if GetUnitAbilityLevel(u, 'T101') > 0 then",
        b"if GetUnitAbilityLevel(u, 'T102') > 0 then",
        b"if GetUnitAbilityLevel(u, 'T105') > 0 then",
        b"if GetUnitAbilityLevel(u, 'T112') > 0 then",
        b"if GetUnitAbilityLevel(u, 'T113') > 0 then",
        b"if GetUnitAbilityLevel(u, 'T114') > 0 then",
        b"function TT_ResetTalents takes unit u returns nothing",
        b"function TT_TalentAbilityId takes integer abilityCode returns integer",
        b"call BlzResetUnitTalents(u)",
        b"function TT_ClearTalentMilestones takes unit u returns nothing",
        b"call TT_GrantEarnedPoints(u)",
        b"integer TT_MAX_LEVEL = 10",
        b"integer TT_CAMPAIGN_CHAPTER = 1",
        b"event=CAMPAIGN_FRESH",
        b"function TT_ClearTalentArtifact takes unit u returns nothing",
        b'"talentreset"',
        b"set it = UnitAddItemByIdSwapped(desiredId, u)",
        b"function TT_RegisterHeroCore takes unit u, boolean allowNew",
        b"function TT_IsCampaignRestoreQueued takes unit u",
        b"function TT_EnsureHeroNow takes unit u",
        b"boolean TT_START_READY = false",
        b"function TT_MarkStartReady takes nothing returns nothing",
        b"event=START_READY",
        b"function TT_EligiblePointCount takes integer level returns integer",
        b"function TT_TrimMilestonesToCount takes unit u, integer count",
        b"function TT_ValidateTalentPoints takes unit u returns nothing",
        b"function TT_NotifyTalentDeficit takes unit u, integer missing, integer eligible",
        b"function TT_NotifyTalentExcess takes unit u, integer excess, integer eligible",
        b"call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0",
        b"return TT_RegisterHeroCore(u, false)",
        b"TT_RegisterHeroCore(u, true)",
        b"if heroIndex < 0 or GetUnitAbilityLevel(u, 'T405') == 0 then",
        b"if TT_IsCampaignRestoreQueued(u) then",
        b"call TT_EnsureHeroNow(u)",
        b"if not TT_START_READY then",
        b"event=ENSURE_WAIT_BACKPACK",
        b"HERO_WAIT_BACKPACK",
        b"POINT_RECONCILE_EXCESS",
        b"POINT_RECONCILE_DEFICIT",
        b"POINT_RECONCILE_OK",
        b"TALENT_INFER_AWARDED",
        b"function TT_CaptureTalentState takes unit u returns nothing",
        b"function TT_ActualSelectionText takes unit u returns string",
        b"function TT_RestoreTalentState takes unit u returns nothing",
        b"function TT_EarnedTalentPoints takes unit u returns integer",
        b"set TT_EARNED_POINTS[heroIndex] = TT_EarnedTalentPoints(u)",
        b"function TT_SyncAwardedFromMarkers takes unit u returns integer",
        b"function TT_IsAwarded takes integer heroIndex, integer index returns boolean",
        b"function TT_CampaignStore takes unit u, gamecache cache returns nothing",
        b"function TT_CampaignRestore takes unit u, gamecache cache returns nothing",
        b"function TT_QueueCampaignRestore takes unit u, gamecache cache returns nothing",
        b"function TT_ConsumeCampaignRestore takes unit u, integer heroIndex returns boolean",
        b"function TT_RegisteredHeroIndex takes unit u returns integer",
        b"function TT_OnPointTimer takes nothing returns nothing",
        b"integer array TT_PENDING_POINTS",
        b"boolean array TT_POINT_WAIT_CLEANUP",
        b"integer array TT_POINT_WAIT_TICKS",
        b"boolean array TT_POINT_USE_ACCEPTED",
        b"boolean array TT_POINT_GRANT_FAILED",
        b"integer array TT_POINT_GRANT_FAILED_LEVEL",
        b"boolean array TT_CAMPAIGN_STATE_PENDING",
        b"boolean array TT_CAMPAIGN_VERIFY_PENDING",
        b"hashtable TT_RESTORE_TABLE = null",
        b"function TT_ScheduleCampaignVerify takes unit u, integer heroIndex returns nothing",
        b"event=CAMPAIGN_REAPPLY",
        b"event=CAMPAIGN_STORE_SAVED",
        b"string TT_LOG_FILE = \"ALAS-TalentLog.txt\"",
        b"gamecache array TT_CAMPAIGN_RESTORE_CACHES",
        b'call StoreInteger(cache, "ALAS_TALENT", key + "a"',
        b"CAMPAIGN_LEGACY_RECOVER",
        b"CAMPAIGN_RESTORE_DEFERRED",
        b"START_READY",
        b"POINT_ITEM_ISSUED",
        b"POINT_GRANT_COMMITTED",
        b"event=POINT_GRANT_BLOCKED",
        b"call UnitUseItem(u, it)",
        b"call TT_StartPointTimer()",
        b"call TT_ConsumeCampaignRestore(u, heroIndex)",
        b"call UnitRemoveAbility(u, talentId)",
        b"call GroupEnumUnitsSelected(g, p, null)",
        b"function TT_LogFlush takes nothing returns nothing",
        b"call PreloadGenEnd(\"ALAS-TalentLog.txt\")",
        b'"talentlog"',
        b"call UnitMakeAbilityPermanent(u, true, talentId)",
        b"EVENT_PLAYER_HERO_REVIVE_FINISH",
        b"EVENT_PLAYER_HERO_SKILL",
        b"damage * 0.60",
        b"EVENT_PLAYER_UNIT_DAMAGED",
        b"TT_SyncArtifacts",
    ):
        if marker not in script:
            raise SystemExit("script marker missing: %r" % marker)
    if b'"talentpoints"' in script:
        raise SystemExit("legacy talent point command still registered")
    if b"call UnitAddItemByIdSwapped('B30B', u)" in script:
        raise SystemExit("source backpack autogrant still active")
    if b"CreateItem(TT_BackpackId(heroIndex)" in script:
        raise SystemExit("talent backpack still uses detached item creation")
    print(
        "verified 64 isolated six-tier talent trees, "
        "per-hero backpack owners, and ALAS artifacts"
    )


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--source", type=Path, default=DEFAULT_SOURCE)
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    parser.add_argument("--work", type=Path, default=DEFAULT_WORK)
    args = parser.parse_args()
    source = args.source.resolve()
    output = args.output.resolve()
    work = args.work.resolve()
    if not source.is_file():
        raise SystemExit("source missing")
    if output.exists():
        raise SystemExit("output exists")
    if work.exists() and any(work.iterdir()):
        raise SystemExit("work is not empty")
    work.mkdir(parents=True, exist_ok=True)
    talent_ability = work / "talent.w3a"
    talent_item = work / "talent.w3t"
    write_talent_objects(talent_ability, talent_item)
    run_full_port(
        source,
        output,
        work / "full",
        talent_ability,
        talent_item,
    )
    verify(output)
    print("output:", output)
    print("bytes:", output.stat().st_size)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
