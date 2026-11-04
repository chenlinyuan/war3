# -*- coding: utf-8 -*-
"""Patch Lost Temple Frostmourne stats from +50 frost damage to +30 attack
and +200% mana regeneration.

The script writes the changed object data and war3map.j into a staging
directory.  inject_native.py then writes those files into the map.
"""
import argparse
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)

import objparse as O  # noqa: E402
import war3mpq as W  # noqa: E402


ITEM_ID = "I105"
SPELL_ID = "A105"
SPEED_ID = "A106"
FROST_ID = "A107"
ATTACK_ID = "A108"
REGEN_ID = "A109"
ICON = r"ReplaceableTextures\CommandButtons\BTNFrostMourne.blp"


def find_entry(entries, entry_id):
    for entry in entries:
        if entry["new"] == entry_id:
            return entry
    raise SystemExit("object not found: %s" % entry_id)


def set_mod(entry, mod_id, mod_type, level, column, value):
    for i, mod in enumerate(entry["mods"]):
        if mod[0] == mod_id:
            entry["mods"][i] = [mod_id, mod_type, level, column, value]
            return
    entry["mods"].append([mod_id, mod_type, level, column, value])


def add_entry(entries, entry):
    for current in entries:
        if current["new"] == entry["new"]:
            raise SystemExit("object id already exists: %s" % entry["new"])
    entries.append(entry)


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
            ["Imrp", O.T_UNREAL, 1, 1, 2.0],
        ],
    }


def patch_item(items):
    item = find_entry(items, ITEM_ID)
    lore = "巫妖王的低语。这是一柄萦绕着哀伤的长剑，它会窃取你的灵魂。"
    set_mod(item, "unam", O.T_STRING, 0, 0,
            "|cffff8c00霜之哀伤|r")
    set_mod(item, "utip", O.T_STRING, 0, 0, "霜之哀伤")
    set_mod(
        item, "utub", O.T_STRING, 0, 0,
        "|cffff8c00霜之哀伤|r|n"
        + lore
        + "|n|n攻击速度 +50%|n"
        + "攻击力 +30|n"
        + "魔法恢复 +2 倍|n"
        + "攻击使目标移动速度降低 65%，持续 4 秒（英雄 2 秒）。"
        + "|n|n|cffffcc00主动：冰封践踏|r"
        + "|n耗魔 100，冷却 6 秒。冰封周围 550 范围内的敌人并造成 "
        + "100+最高属性×4 的伤害。普通单位冰冻 5 秒，英雄冰冻 3 秒。")
    set_mod(
        item, "ides", O.T_STRING, 0, 0,
        "巫妖王的低语。攻击速度 +50%，攻击力 +30，魔法恢复 +2 倍，"
        "攻击减速；主动：冰封践踏。")
    set_mod(item, "iabi", O.T_STRING, 0, 0,
            ",".join((SPELL_ID, SPEED_ID, ATTACK_ID, REGEN_ID)))


def patch_abilities(abilities):
    frost = find_entry(abilities, FROST_ID)
    set_mod(frost, "Idam", O.T_UNREAL, 1, 1, 0.0)
    if not any(entry["new"] == ATTACK_ID for entry in abilities):
        add_entry(abilities, attack_entry())
    if not any(entry["new"] == REGEN_ID for entry in abilities):
        add_entry(abilities, regen_entry())


def patch_script(data):
    pattern = re.compile(
        rb"if abilId == 'A105'[^\r\n]*A107[^\r\n]*then")
    matches = pattern.findall(data)
    if len(matches) != 1:
        raise SystemExit("A105-A107 item ability guard: expected 1, found %d"
                         % len(matches))
    replacement = (
        b"if abilId == 'A105' or abilId == 'A106' or abilId == 'A107' or "
        b"abilId == 'A108' or abilId == 'A109' then")
    return pattern.sub(replacement, data, count=1)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("map")
    parser.add_argument("outdir")
    args = parser.parse_args()

    archive = W.MPQArchive(os.path.abspath(args.map))
    try:
        w3a_data = archive.read_file("war3map.w3a")
        w3t_data = archive.read_file("war3map.w3t")
        script_data = archive.read_file("war3map.j")
    finally:
        archive.close()
    if not w3a_data or not w3t_data or not script_data:
        raise SystemExit("map is missing war3map.w3a/w3t/j")

    ability_version, ability_orig, ability_custom = O.read_bytes(w3a_data, "w3a")
    item_version, item_orig, item_custom = O.read_bytes(w3t_data, "w3t")
    patch_abilities(ability_custom)
    patch_item(item_custom)
    script_data = patch_script(script_data)

    outdir = os.path.abspath(args.outdir)
    os.makedirs(outdir, exist_ok=True)
    O.write_file(os.path.join(outdir, "war3map.w3a"),
                 ability_version, ability_orig, ability_custom)
    O.write_file(os.path.join(outdir, "war3map.w3t"),
                 item_version, item_orig, item_custom)
    script_path = os.path.join(outdir, "war3map.j")
    with open(script_path, "wb") as handle:
        handle.write(script_data)

    print("patched Frostmourne: attack +30, mana regen +200%, frost hit damage 0")
    print("abilities:", ATTACK_ID, REGEN_ID)
    print("staging:", outdir)
    return 0


if __name__ == "__main__":
    sys.exit(main())
