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
ATTACK_ID = "A108"
REGEN_ID = "A109"
ICON = r"ReplaceableTextures\CommandButtons\BTNFrostMourne.blp"
SPELL_ICON = r"ReplaceableTextures\CommandButtons\BTNBreathOfFrost.blp"


def item_entry():
    name = "|cffff8c00霜之哀伤|r"
    lore = "巫妖王的低语。这是一柄萦绕着哀伤的长剑，它会窃取你的灵魂。"
    ubertip = (
        "|cffff8c00神器|r|n|n"
        "攻击力 +30，攻击速度 +50%，魔法恢复 +100%。|n"
        "|cff5ddf26霜冻新星：普通攻击有 30% 概率触发，250 范围内造成 100 点伤害，"
        "主目标额外受到 50 点伤害，并减速 4 秒。|n"
        "|cff5ddf26噬魂：击杀敌人有 5% 概率永久 +1 力量，击杀英雄时为 50%。|r|n"
        "|cff66ccff装备后获得技能：冰封践踏（D）。|r|n|n"
        + lore
    )
    entry = {
        "old": "gcel",
        "new": ITEM_ID,
        "mods": [
            ["unam", O.T_STRING, 0, 0, name],
            ["utip", O.T_STRING, 0, 0, "霜之哀伤"],
            ["utub", O.T_STRING, 0, 0, ubertip],
            ["ides", O.T_STRING, 0, 0, (
                "攻击力 +30，攻击速度 +50%，魔法恢复 +100%。|n"
                "|cff5ddf26霜冻新星：普通攻击有 30% 概率造成范围伤害与减速。|r|n"
                "|cff5ddf26噬魂：击杀敌人有 5% 概率永久 +1 力量，击杀英雄时为 50%。|r|n"
                "|cff66ccff装备后获得技能：冰封践踏（D）。|r|n|n"
                + lore
            )],
            ["iico", O.T_STRING, 0, 0, ICON],
            ["icla", O.T_STRING, 0, 0, "Artifact"],
            ["ilev", O.T_INT, 0, 0, 8],
            ["igol", O.T_INT, 0, 0, 1000],
            ["iabi", O.T_STRING, 0, 0,
             ",".join((SPEED_ID, ATTACK_ID, REGEN_ID))],
            ["iusa", O.T_INT, 0, 0, 0],
            ["idro", O.T_INT, 0, 0, 1],
            ["ipaw", O.T_INT, 0, 0, 0],
            ["ifil", O.T_STRING, 0, 0,
             r"war3campImported\Frostmourne.mdx"],
        ],
    }
    return entry


def spell_entry():
    tip = "冰封践踏"
    ubertip = (
        "对 550 范围内地面与空中敌人造成 100 + 4×力量 的伤害。|n"
        "普通单位冰冻 5 秒，英雄冰冻 3 秒。|n"
        "魔法免疫单位会被冻结，但不会受到伤害。|n"
        "|cff9d5cff消耗当前生命 20%，不会致死。|r"
    )
    return {
        "old": "ANcl",
        "new": SPELL_ID,
        "mods": [
            ["anam", O.T_STRING, 0, 0, "冰封践踏"],
            ["aart", O.T_STRING, 0, 0, SPELL_ICON],
            ["arar", O.T_STRING, 0, 0, SPELL_ICON],
            ["aret", O.T_STRING, 0, 0, tip],
            ["arhk", O.T_STRING, 0, 0, "D"],
            ["ahky", O.T_STRING, 0, 0, "D"],
            ["aani", O.T_STRING, 0, 0, "stand"],
            ["aord", O.T_STRING, 0, 0, "froststomp"],
            ["atp1", O.T_STRING, 1, 0, tip],
            ["aub1", O.T_STRING, 1, 0, ubertip],
            ["alev", O.T_INT, 0, 0, 1],
            ["aite", O.T_INT, 0, 0, 0],
            ["aher", O.T_INT, 0, 0, 0],
            ["Ncl1", O.T_UNREAL, 1, 1, 0.0],
            ["Ncl2", O.T_INT, 1, 2, 0],
            ["Ncl3", O.T_INT, 1, 3, 1],
            ["Ncl4", O.T_UNREAL, 1, 4, 0.0],
            ["Ncl5", O.T_INT, 1, 5, 0],
            ["Ncl6", O.T_STRING, 1, 6, "froststomp"],
            ["acdn", O.T_UNREAL, 1, 0, 10.0],
            ["amcs", O.T_INT, 1, 0, 100],
            ["acat", O.T_STRING, 0, 0, ""],
            ["arpx", O.T_INT, 0, 0, 2],
            ["aubx", O.T_INT, 0, 0, 1],
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
            ["Idam", O.T_UNREAL, 1, 1, 0.0],
            ["adur", O.T_UNREAL, 1, 0, 0.1],
            ["ahdu", O.T_UNREAL, 1, 0, 0.1],
        ],
    }


def attack_entry():
    return {
        "old": "AIat",
        "new": ATTACK_ID,
        "mods": [
            ["anam", O.T_STRING, 0, 0, "霜之哀伤·攻击力"],
            ["aart", O.T_STRING, 0, 0, ICON],
            ["arar", O.T_STRING, 0, 0, ICON],
            ["alev", O.T_INT, 0, 0, 1],
            ["aite", O.T_INT, 0, 0, 1],
            ["aher", O.T_INT, 0, 0, 0],
            ["Iatt", O.T_INT, 1, 1, 30],
        ],
    }


def regen_entry():
    return {
        "old": "AIrm",
        "new": REGEN_ID,
        "mods": [
            ["anam", O.T_STRING, 0, 0, "霜之哀伤·魔法恢复"],
            ["aart", O.T_STRING, 0, 0, ICON],
            ["arar", O.T_STRING, 0, 0, ICON],
            ["alev", O.T_INT, 0, 0, 1],
            ["aite", O.T_INT, 0, 0, 1],
            ["aher", O.T_INT, 0, 0, 0],
            ["Imrp", O.T_UNREAL, 1, 1, 1.0],
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
                 [spell_entry(), speed_entry(), frost_entry(),
                  attack_entry(), regen_entry()],
                 os.path.join(out, "war3map.w3a"), "w3a")
    return 0


if __name__ == "__main__":
    sys.exit(main())
