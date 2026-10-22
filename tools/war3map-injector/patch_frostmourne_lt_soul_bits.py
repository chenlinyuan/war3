# -*- coding: utf-8 -*-
"""Apply Frostmourne soul drain with distinct bitmask life-bonus abilities."""
import argparse
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)

import objparse as O  # noqa: E402
import war3mpq as W  # noqa: E402
from patch_frostmourne_lt_soul_drain import (  # noqa: E402
    SPELL_ID, find_entry, patch_item, replace_once, set_mod,
)


ICON = r"ReplaceableTextures\CommandButtons\BTNFrostMourne.blp"
SOUL_BASE_ID = 130
SOUL_BIT_COUNT = 12
SOUL_DRAIN_PER_PROC = 50


def soul_entry(bit):
    new_id = "A%03d" % (SOUL_BASE_ID + bit)
    return {
        "old": "AIl2",
        "new": new_id,
        "mods": [
            ["anam", O.T_STRING, 0, 0, "霜之哀伤·灵魂负担"],
            ["aart", O.T_STRING, 0, 0, ICON],
            ["arar", O.T_STRING, 0, 0, ICON],
            ["alev", O.T_INT, 0, 0, 1],
            ["aite", O.T_INT, 0, 0, 1],
            ["aher", O.T_INT, 0, 0, 0],
            ["Ilif", O.T_INT, 1, 1,
             -SOUL_DRAIN_PER_PROC * (1 << bit)],
        ],
    }


def patch_abilities(entries):
    existing = {entry["new"] for entry in entries}
    for bit in range(SOUL_BIT_COUNT):
        entry = soul_entry(bit)
        if entry["new"] in existing:
            raise SystemExit("object id already exists: %s" % entry["new"])
        entries.append(entry)

    spell = find_entry(entries, SPELL_ID)
    set_mod(spell, "acdn", O.T_UNREAL, 1, 0, 10.0)
    set_mod(
        spell, "aub1", O.T_STRING, 1, 0,
        "释放霜之哀伤的力量，冰封并伤害四周敌人。|n"
        "对范围内敌人造成 100+最高属性×4 的伤害。|n"
        "普通单位冰冻 5 秒，英雄冰冻 3 秒；地面与空中均有效。|n"
        "冷却 10 秒，耗魔 100。|n"
        "|cff9d5cff灵魂代价：每次成功释放有 25% 概率永久失去 "
        "50 最大生命。|r")


def soul_ability_offset():
    lines = []
    for bit in range(SOUL_BIT_COUNT):
        ability_id = "A%03d" % (SOUL_BASE_ID + bit)
        if bit == 0:
            lines.append("    if bit == 0 then")
        else:
            lines.append("    elseif bit == %d then" % bit)
        lines.append("        return '%s'" % ability_id)
    return "\n".join(lines)


def soul_functions():
    return (
        "function FR_SoulAbility takes integer bit returns integer\n"
        + soul_ability_offset()
        + "\n    endif\n    return 0\nendfunction\n\n"
        + "function FR_SetSoulBurden takes unit u, integer value returns nothing\n"
        + "    local integer bit = 0\n"
        + "    local integer abil\n"
        + "    loop\n"
        + "        exitwhen bit >= 12\n"
        + "        set abil = FR_SoulAbility(bit)\n"
        + "        if ModuloInteger(value, 2) == 1 then\n"
        + "            if GetUnitAbilityLevel(u, abil) == 0 then\n"
        + "                call UnitAddAbility(u, abil)\n"
        + "                call UnitMakeAbilityPermanent(u, true, abil)\n"
        + "            endif\n"
        + "        elseif GetUnitAbilityLevel(u, abil) > 0 then\n"
        + "            call UnitRemoveAbility(u, abil)\n"
        + "        endif\n"
        + "        set value = value / 2\n"
        + "        set bit = bit + 1\n"
        + "    endloop\n"
        + "endfunction\n\n"
        + "function FR_ShowSoulDrain takes unit u returns nothing\n"
        + "    local texttag tt = CreateTextTag()\n"
        + '    call SetTextTagText(tt, "灵魂被吞噬 -50 最大生命", 0.024)\n'
        + "    call SetTextTagPosUnit(tt, u, 110.0)\n"
        + "    call SetTextTagColor(tt, 190, 100, 255, 255)\n"
        + "    call SetTextTagVelocity(tt, 0.0, 0.035)\n"
        + "    call SetTextTagPermanent(tt, false)\n"
        + "    call SetTextTagLifespan(tt, 1.8)\n"
        + "    call SetTextTagFadepoint(tt, 1.2)\n"
        + "    call SetTextTagVisibility(tt, GetLocalPlayer() == GetOwningPlayer(u))\n"
        + "    set tt = null\n"
        + "endfunction\n\n"
        + "function FR_TrySoulDrain takes unit u returns nothing\n"
        + "    local integer key\n"
        + "    local integer total\n"
        + "    local real oldMax\n"
        + "    local real newMax\n"
        + "    if u == null or not UnitHasItemOfTypeBJ(u, FR_ITEM_ID) then\n"
        + "        return\n"
        + "    endif\n"
        + "    if GetRandomReal(0.0, 1.0) >= FR_SOUL_CHANCE then\n"
        + "        return\n"
        + "    endif\n"
        + "    set oldMax = GetUnitState(u, UNIT_STATE_MAX_LIFE)\n"
        + "    if oldMax <= I2R(FR_SOUL_DRAIN) then\n"
        + "        return\n"
        + "    endif\n"
        + "    set key = GetHandleId(u)\n"
        + "    set total = LoadInteger(fr_soul_table, key, 0) + 1\n"
        + "    if total >= 4096 then\n"
        + "        return\n"
        + "    endif\n"
        + "    call FR_SetSoulBurden(u, total)\n"
        + "    set newMax = GetUnitState(u, UNIT_STATE_MAX_LIFE)\n"
        + "    if oldMax - newMax < 49.0 then\n"
        + "        return\n"
        + "    endif\n"
        + "    call SaveInteger(fr_soul_table, key, 0, total)\n"
        + "    call FR_ShowSoulDrain(u)\n"
        + "endfunction\n\n"
        + "function FR_FreezeAir takes unit u, real duration returns nothing\n"
        + "    local integer key\n"
        + "    if u == null or not IsUnitType(u, UNIT_TYPE_FLYING) then\n"
        + "        return\n"
        + "    endif\n"
        + "    set key = GetHandleId(u)\n"
        + "    if not IsUnitInGroup(u, fr_freeze_group) then\n"
        + "        call GroupAddUnit(fr_freeze_group, u)\n"
        + "        call PauseUnit(u, true)\n"
        + "    endif\n"
        + "    call SaveReal(fr_freeze_table, key, 0, TimerGetElapsed(fr_freeze_timer) + duration)\n"
        + "endfunction\n\n"
        + "function FR_FreezeAirStep takes nothing returns nothing\n"
        + "    local group work = CreateGroup()\n"
        + "    local unit u\n"
        + "    local integer key\n"
        + "    call GroupAddGroup(fr_freeze_group, work)\n"
        + "    loop\n"
        + "        set u = FirstOfGroup(work)\n"
        + "        exitwhen u == null\n"
        + "        set key = GetHandleId(u)\n"
        + "        if GetUnitTypeId(u) == 0 or not IsUnitAliveBJ(u) or TimerGetElapsed(fr_freeze_timer) >= LoadReal(fr_freeze_table, key, 0) then\n"
        + "            call PauseUnit(u, false)\n"
        + "            call FlushChildHashtable(fr_freeze_table, key)\n"
        + "            call GroupRemoveUnit(fr_freeze_group, u)\n"
        + "        endif\n"
        + "        call GroupRemoveUnit(work, u)\n"
        + "    endloop\n"
        + "    call DestroyGroup(work)\n"
        + "    set work = null\n"
        + "    set u = null\n"
        + "endfunction\n\n"
    )


def patch_script(data):
    data = data.replace(b"\r\n", b"\n")
    if b"function FR_TrySoulDrain" in data:
        raise SystemExit("soul-drain script already exists")
    data = replace_once(
        data,
        b"hashtable fr_slow_table = null\n",
        b"hashtable fr_slow_table = null\n"
        b"hashtable fr_soul_table = null\n"
        b"group fr_freeze_group = null\n"
        b"hashtable fr_freeze_table = null\n"
        b"timer fr_freeze_timer = null\n",
        "soul table declaration")
    data = replace_once(
        data,
        b"real FR_SLOW_HERO_DURATION = 2.0\n",
        b"real FR_SLOW_HERO_DURATION = 2.0\n"
        b"real FR_SOUL_CHANCE = 0.25\n"
        b"integer FR_SOUL_DRAIN = 50\n",
        "soul constants")
    data = replace_once(
        data,
        b"    set fr_slow_table = InitHashtable()\n",
        b"    set fr_slow_table = InitHashtable()\n"
        b"    set fr_soul_table = InitHashtable()\n"
        b"    set fr_freeze_group = CreateGroup()\n"
        b"    set fr_freeze_table = InitHashtable()\n"
        b"    set fr_freeze_timer = CreateTimer()\n"
        b"    call TimerStart(fr_freeze_timer, 0.10, true, function FR_FreezeAirStep)\n",
        "soul table init")
    data = replace_once(
        data,
        b"function FR_OnSpell takes nothing returns nothing\n",
        soul_functions().encode("gbk")
        + b"function FR_OnSpell takes nothing returns nothing\n",
        "soul functions")
    data = replace_once(
        data,
        b"    if bonus <= 0.0 then\n"
        b"        set caster = null\n"
        b"        return\n"
        b"    endif\n"
        b"    call TriggerSleepAction(0.05)\n",
        b"    if bonus <= 0.0 then\n"
        b"        set caster = null\n"
        b"        return\n"
        b"    endif\n"
        b"    call FR_TrySoulDrain(caster)\n"
        b"    call TriggerSleepAction(0.05)\n",
        "soul drain trigger")
    data = replace_once(
        data,
        b"    local real y\n"
        b"    local real bonus\n",
        b"    local real y\n"
        b"    local real bonus\n"
        b"    local real freeze_duration\n",
        "freeze local")
    data = replace_once(
        data,
        b"                call UnitDamageTarget(caster, target, bonus, true, false, ATTACK_TYPE_MAGIC, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)\n"
        b"            endif\n",
        b"                call UnitDamageTarget(caster, target, bonus, true, false, ATTACK_TYPE_MAGIC, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)\n"
        b"                if IsUnitType(target, UNIT_TYPE_FLYING) then\n"
        b"                    if IsUnitType(target, UNIT_TYPE_HERO) then\n"
        b"                        set freeze_duration = 3.0\n"
        b"                    else\n"
        b"                        set freeze_duration = 5.0\n"
        b"                    endif\n"
        b"                    call FR_FreezeAir(target, freeze_duration)\n"
        b"                endif\n"
        b"            endif\n",
        "air freeze in spell")
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
    print("added bitmask soul burden: A130-A141")
    print("25% chance, -50 max life, text only after confirmed decrease")
    print("staging:", outdir)
    return 0


if __name__ == "__main__":
    sys.exit(main())
