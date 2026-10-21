# -*- coding: utf-8 -*-
"""Generate the Lost Temple Frostmourne item and ability object data."""
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)

import objparse as O


ITEM_ID = "I105"
SPELL_ID = "A105"
SPEED_ID = "A106"
FROST_ID = "A107"
ICON = r"ReplaceableTextures\CommandButtons\BTNFrostMourne.blp"
SPELL_ICON = r"ReplaceableTextures\CommandButtons\BTNBreathOfFrost.blp"


def item_entry():
    name = "|cffff8c00霜之哀伤|r"
    lore = "巫妖王的低语。这是一柄萦绕着哀伤的长剑，它会窃取你的灵魂。"
    ubertip = (
        "|cffff8c00霜之哀伤|r|n"
        + lore +
        "|n|n攻击速度 +50%|n"
        "攻击附带 50 点冰霜伤害，并使目标移动速度降低 65%，持续 4 秒（英雄 2 秒）。"
        "|n|n|cffffcc00主动：冰封践踏|r"
        "|n耗魔 100，冷却 6 秒。冰封周围 550 范围内的敌人并造成 "
        "100+最高属性×4 的伤害。普通单位冰冻 5 秒，英雄冰冻 3 秒。"
    )
    entry = {
        "old": "gcel",
        "new": ITEM_ID,
        "mods": [
            ["unam", O.T_STRING, 0, 0, name],
            ["utip", O.T_STRING, 0, 0, "霜之哀伤"],
            ["utub", O.T_STRING, 0, 0, ubertip],
            ["ides", O.T_STRING, 0, 0, (
                "巫妖王的低语。攻击速度 +50%，攻击附带霜冻伤害和减速；"
                "主动：冰封践踏。"
            )],
            ["iico", O.T_STRING, 0, 0, ICON],
            ["icla", O.T_STRING, 0, 0, "Artifact"],
            ["ilev", O.T_INT, 0, 0, 8],
            ["igol", O.T_INT, 0, 0, 1000],
            ["iabi", O.T_STRING, 0, 0,
             SPELL_ID + "," + SPEED_ID + "," + FROST_ID],
            ["iusa", O.T_INT, 0, 0, 1],
            ["icid", O.T_STRING, 0, 0, SPELL_ID],
            ["ifil", O.T_STRING, 0, 0,
             r"war3campImported\Frostmourne.mdx"],
        ],
    }
    return entry


def spell_entry():
    tip = "冰封践踏(|cffffcc00R|r)"
    ubertip = (
        "释放霜之哀伤的力量，冰封并伤害四周敌人。|n"
        "对范围内敌人造成 100+最高属性×4 的伤害。|n"
        "普通单位冰冻 5 秒，英雄冰冻 3 秒。|n"
        "冷却 6 秒，耗魔 100。"
    )
    return {
        "old": "AOws",
        "new": SPELL_ID,
        "mods": [
            ["anam", O.T_STRING, 0, 0, "冰封践踏"],
            ["aart", O.T_STRING, 0, 0, SPELL_ICON],
            ["arar", O.T_STRING, 0, 0, SPELL_ICON],
            ["aret", O.T_STRING, 0, 0, tip],
            ["arhk", O.T_STRING, 0, 0, "R"],
            ["ahky", O.T_STRING, 0, 0, "R"],
            ["atp1", O.T_STRING, 1, 0, tip],
            ["aub1", O.T_STRING, 1, 0, ubertip],
            ["alev", O.T_INT, 0, 0, 1],
            ["aite", O.T_INT, 0, 0, 1],
            ["aher", O.T_INT, 0, 0, 0],
            ["Wrs1", O.T_UNREAL, 1, 1, 100.0],
            ["aare", O.T_UNREAL, 1, 0, 550.0],
            ["adur", O.T_UNREAL, 1, 0, 5.0],
            ["ahdu", O.T_UNREAL, 1, 0, 3.0],
            ["acdn", O.T_UNREAL, 1, 0, 6.0],
            ["amcs", O.T_INT, 1, 0, 100],
            ["abuf", O.T_STRING, 1, 0, "Bfrz"],
            ["acat", O.T_STRING, 0, 0,
             r"war3campImported\IceStompRaised.mdx"],
            ["arpx", O.T_INT, 0, 0, 2],
            ["aubx", O.T_INT, 0, 0, 1],
            ["atar", O.T_STRING, 1, 0,
             "neutral,ground,structure,enemies,organic,mechanical,air"],
        ],
    }


def speed_entry():
    return {
        "old": "AIsx",
        "new": SPEED_ID,
        "mods": [
            ["anam", O.T_STRING, 0, 0, "霜之哀伤·攻击速度"],
            ["alev", O.T_INT, 0, 0, 1],
            ["Isx1", O.T_UNREAL, 1, 1, 0.50],
        ],
    }


def frost_entry():
    return {
        "old": "AIob",
        "new": FROST_ID,
        "mods": [
            ["anam", O.T_STRING, 0, 0, "霜冻攻击"],
            ["alev", O.T_INT, 0, 0, 1],
            ["aite", O.T_INT, 0, 0, 1],
            ["aher", O.T_INT, 0, 0, 0],
            ["Idam", O.T_UNREAL, 1, 1, 50.0],
            ["adur", O.T_UNREAL, 1, 0, 0.1],
            ["ahdu", O.T_UNREAL, 1, 0, 0.1],
        ],
    }




def merge_object(source, extra, out, ext):
    version, original, custom = O.read_file(source)
    for entry in extra:
        if any(old["new"] == entry["new"] for old in custom):
            raise SystemExit("object id already exists in %s: %s" % (source, entry["new"]))
        custom.append(entry)
    O.write_file(out, version, original, custom)
    print("%s -> %s (%d custom entries)" % (source, out, len(custom)))


def main():
    if len(sys.argv) != 3:
        raise SystemExit("usage: gen_frostmourne_lt.py WORK_DIR OUT_DIR")
    work, out = sys.argv[1], sys.argv[2]
    os.makedirs(out, exist_ok=True)
    merge_object(os.path.join(work, "war3map.w3t"), [item_entry()],
                 os.path.join(out, "war3map.w3t"), "w3t")
    merge_object(os.path.join(work, "war3map.w3a"),
                 [spell_entry(), speed_entry(), frost_entry()],
                 os.path.join(out, "war3map.w3a"), "w3a")
    return 0


if __name__ == "__main__":
    sys.exit(main())
