# -*- coding: utf-8 -*-
"""Add Frostmourne's 25% soul-drain curse to the Lost Temple map."""
import argparse
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)

import objparse as O  # noqa: E402
import war3mpq as W  # noqa: E402


ITEM_ID = "I105"
SPELL_ID = "A105"
ICON = r"ReplaceableTextures\CommandButtons\BTNFrostMourne.blp"
SOUL_BASE_ID = 110
SOUL_BLOCK_COUNT = 20
SOUL_LEVEL_COUNT = 100
SOUL_DRAIN_PER_PROC = 50


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


def soul_entry(block):
    new_id = "A%03d" % (SOUL_BASE_ID + block)
    mods = [
        ["anam", O.T_STRING, 0, 0, "霜之哀伤·灵魂负担"],
        ["aart", O.T_STRING, 0, 0, ICON],
        ["arar", O.T_STRING, 0, 0, ICON],
        ["alev", O.T_INT, 0, 0, SOUL_LEVEL_COUNT],
        ["aite", O.T_INT, 0, 0, 1],
        ["aher", O.T_INT, 0, 0, 0],
    ]
    for level in range(1, SOUL_LEVEL_COUNT + 1):
        mods.append(["Ilif", O.T_INT, level, 1,
                     -SOUL_DRAIN_PER_PROC * level])
    return {"old": "AIl2", "new": new_id, "mods": mods}


def patch_abilities(entries):
    existing = {entry["new"] for entry in entries}
    for block in range(SOUL_BLOCK_COUNT):
        entry = soul_entry(block)
        if entry["new"] in existing:
            raise SystemExit("object id already exists: %s" % entry["new"])
        entries.append(entry)

    spell = find_entry(entries, SPELL_ID)
    set_mod(
        spell, "aub1", O.T_STRING, 1, 0,
        "释放霜之哀伤的力量，冰封并伤害四周敌人。|n"
        "对范围内敌人造成 100+最高属性×4 的伤害。|n"
        "普通单位冰冻 5 秒，英雄冰冻 3 秒。|n"
        "冷却 10 秒，耗魔 100。|n"
        "|cff9d5cff灵魂代价：每次成功释放有 25% 概率永久失去 "
        "50 最大生命。|r")


def patch_item(entries):
    item = find_entry(entries, ITEM_ID)
    lore = "巫妖王的低语。这是一柄萦绕着哀伤的长剑，它会窃取你的灵魂。"
    set_mod(
        item, "utub", O.T_STRING, 0, 0,
        lore
        + "|n|n攻速 +50%｜攻击力 +30｜魔法恢复 +200%"
        + "|n攻击减速 65%（普通 4 秒 / 英雄 2 秒）"
        + "|n|n|cffffcc00主动：冰封践踏|r"
        + "|n耗魔 100，冷却 10 秒；550 范围，地面与空中均有效。"
        + "|n造成 100+最高属性×4 伤害，冰冻普通 5 秒 / 英雄 3 秒。"
        + "|n|cff9d5cff灵魂代价：成功释放时 25% 概率永久失去 "
        + "50 最大生命。|r")
    set_mod(
        item, "ides", O.T_STRING, 0, 0,
        "巫妖王的低语。攻击速度 +50%，攻击力 +30，魔法恢复 +2 倍，"
        "攻击减速；主动：冰封践踏，地面与空中均有效。每次成功释放有 "
        "25% 概率永久失去 50 最大生命。")
    set_mod(item, "idro", O.T_INT, 0, 0, 1)
    set_mod(item, "ipaw", O.T_INT, 0, 0, 0)


def replace_once(data, old, new, label):
    old = old.replace(b"\r\n", b"\n")
    new = new.replace(b"\r\n", b"\n")
    count = data.count(old)
    if count != 1:
        raise SystemExit("%s: expected 1 occurrence, found %d" % (label, count))
    return data.replace(old, new, 1)


def soul_functions():
    lines = []
    for block in range(SOUL_BLOCK_COUNT):
        ability_id = "A%03d" % (SOUL_BASE_ID + block)
        if block == 0:
            lines.append("    if block == 0 then")
        else:
            lines.append("    elseif block == %d then" % block)
        lines.append("        return '%s'" % ability_id)
    return (
        "function FR_SoulAbility takes integer block returns integer\r\n"
        + "\r\n".join(lines)
        + "\r\n    endif\r\n    return 0\r\nendfunction\r\n\r\n"
        + "function FR_ShowSoulDrain takes unit u returns nothing\r\n"
        + "    local texttag tt = CreateTextTag()\r\n"
        + '    call SetTextTagText(tt, "灵魂被吞噬 -50 最大生命", 0.024)\r\n'
        + "    call SetTextTagPosUnit(tt, u, 110.0)\r\n"
        + "    call SetTextTagColor(tt, 190, 100, 255, 255)\r\n"
        + "    call SetTextTagVelocity(tt, 0.0, 0.035)\r\n"
        + "    call SetTextTagPermanent(tt, false)\r\n"
        + "    call SetTextTagLifespan(tt, 1.8)\r\n"
        + "    call SetTextTagFadepoint(tt, 1.2)\r\n"
        + "    call SetTextTagVisibility(tt, GetLocalPlayer() == GetOwningPlayer(u))\r\n"
        + "    set tt = null\r\n"
        + "endfunction\r\n\r\n"
        + "function FR_TrySoulDrain takes unit u returns nothing\r\n"
        + "    local integer key\r\n"
        + "    local integer total\r\n"
        + "    local integer block\r\n"
        + "    local integer level\r\n"
        + "    local integer abil\r\n"
        + "    if u == null or not UnitHasItemOfTypeBJ(u, FR_ITEM_ID) then\r\n"
        + "        return\r\n"
        + "    endif\r\n"
        + "    if GetRandomReal(0.0, 1.0) >= FR_SOUL_CHANCE then\r\n"
        + "        return\r\n"
        + "    endif\r\n"
        + "    if GetUnitState(u, UNIT_STATE_MAX_LIFE) <= I2R(FR_SOUL_DRAIN) then\r\n"
        + "        return\r\n"
        + "    endif\r\n"
        + "    set key = GetHandleId(u)\r\n"
        + "    set total = LoadInteger(fr_soul_table, key, 0) + 1\r\n"
        + "    set block = (total - 1) / 100\r\n"
        + "    set level = ModuloInteger(total - 1, 100) + 1\r\n"
        + "    set abil = FR_SoulAbility(block)\r\n"
        + "    if abil == 0 then\r\n"
        + "        return\r\n"
        + "    endif\r\n"
        + "    if GetUnitAbilityLevel(u, abil) == 0 then\r\n"
        + "        call UnitAddAbility(u, abil)\r\n"
        + "        call UnitMakeAbilityPermanent(u, true, abil)\r\n"
        + "    endif\r\n"
        + "    call SetUnitAbilityLevel(u, abil, level)\r\n"
        + "    call SaveInteger(fr_soul_table, key, 0, total)\r\n"
        + "    call FR_ShowSoulDrain(u)\r\n"
        + "endfunction\r\n\r\n"
    )


def patch_script(data):
    data = data.replace(b"\r\n", b"\n")
    if b"function FR_TrySoulDrain" in data:
        raise SystemExit("soul-drain script already exists")

    data = replace_once(
        data,
        b"hashtable fr_slow_table = null\r\n",
        b"hashtable fr_slow_table = null\r\nhashtable fr_soul_table = null\r\n",
        "soul table declaration")
    data = replace_once(
        data,
        b"real FR_SLOW_HERO_DURATION = 2.0\r\n",
        b"real FR_SLOW_HERO_DURATION = 2.0\r\n"
        b"real FR_SOUL_CHANCE = 0.25\r\n"
        b"integer FR_SOUL_DRAIN = 50\r\n",
        "soul constants")
    data = replace_once(
        data,
        b"    set fr_slow_table = InitHashtable()\r\n",
        b"    set fr_slow_table = InitHashtable()\r\n"
        b"    set fr_soul_table = InitHashtable()\r\n",
        "soul table init")
    data = replace_once(
        data,
        b"function FR_OnSpell takes nothing returns nothing\r\n",
        soul_functions().encode("gbk") + b"function FR_OnSpell takes nothing returns nothing\r\n",
        "soul functions")
    data = replace_once(
        data,
        b"    if bonus <= 0.0 then\r\n"
        b"        set caster = null\r\n"
        b"        return\r\n"
        b"    endif\r\n"
        b"    call TriggerSleepAction(0.05)\r\n",
        b"    if bonus <= 0.0 then\r\n"
        b"        set caster = null\r\n"
        b"        return\r\n"
        b"    endif\r\n"
        b"    call FR_TrySoulDrain(caster)\r\n"
        b"    call TriggerSleepAction(0.05)\r\n",
        "soul drain trigger")
    return data


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
    with open(os.path.join(outdir, "war3map.j"), "wb") as handle:
        handle.write(script_data)
    print("added soul drain: 25%, -50 max life per proc, floating text")
    print("soul abilities: A110-A129, 100 levels each")
    print("staging:", outdir)
    return 0


if __name__ == "__main__":
    sys.exit(main())
