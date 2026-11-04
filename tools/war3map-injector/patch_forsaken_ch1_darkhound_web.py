"""Fix chapter-zone UndeadRE01_03 darkhound drops and broodmother web lockout."""

from pathlib import Path
import sys

import mpq_patch
import war3mpq


ROOT = Path(__file__).resolve().parents[2]
SOURCE = ROOT / "maps" / "port" / "forsaken_undead" / "base" / "UndeadRE01_03.systems.w3x"
OUTPUT = ROOT / "maps" / "port" / "forsaken_undead" / "_spiderfix" / "UndeadRE01_03.w3x"
ITEM_BROWSER = ROOT / "maps" / "port" / "forsaken_undead" / "item-browser" / "f.j"


def replace_once(data, old, new, label):
    count = data.count(old)
    if count != 1:
        raise RuntimeError("%s expected once, found %d" % (label, count))
    return data.replace(old, new, 1)


def patch_lua(data):
    nl = b"\r\n" if b"\r\n" in data[:10000] else b"\n"

    old_condition = (
        b"function Trig_Darkhound_Blood_Drop_Conditions()" + nl
        + b'  if GetUnitTypeId(GetDyingUnit()) ~= FourCC("n004") then' + nl
        + b"    return false" + nl
        + b"  end" + nl
    )
    new_condition = (
        b"function Trig_Darkhound_Blood_Drop_Conditions()" + nl
        + b"  local dyingType = GetUnitTypeId(GetDyingUnit())" + nl
        + b'  if dyingType ~= FourCC("n004") and dyingType ~= FourCC("n005") then' + nl
        + b"    return false" + nl
        + b"  end" + nl
    )
    data = replace_once(data, old_condition, new_condition, "darkhound drop unit types")

    web_pause = (
        b"  PauseUnitBJ(true, udg_BossBroodMotherWebUnit)" + nl
        + b"  SetUnitTimeScalePercent(udg_BossBroodMotherWebUnit, 25.0)" + nl
    )
    web_safe = (
        b"  SetUnitTimeScalePercent(udg_BossBroodMotherWebUnit, 100.0)" + nl
    )
    data = replace_once(data, web_pause, web_safe, "broodmother web pause")

    boss_death = (
        b"function Trig_Brood_Mother_Death_Actions()" + nl
        + b"  DisableTrigger(GetTriggeringTrigger())" + nl
    )
    boss_death_fixed = (
        boss_death
        + b"  if udg_BossBroodMotherWebUnit ~= nil then" + nl
        + b"    PauseUnitBJ(false, udg_BossBroodMotherWebUnit)" + nl
        + b"    SetUnitTimeScalePercent(udg_BossBroodMotherWebUnit, 100.0)" + nl
        + b"    udg_BossBroodMotherWebUnit = nil" + nl
        + b"  end" + nl
    )
    data = replace_once(data, boss_death, boss_death_fixed, "broodmother death web release")

    init_start = (
        b"function RunInitializationTriggers()" + nl
        + b"  ConditionalTriggerExecute(gg_trg_Quest_Initialization)" + nl
    )
    init_start_fixed = (
        init_start
        + b"  if udg_Bool_MQApotSupplyDarkhoundDone ~= true then" + nl
        + b"    EnableTrigger(gg_trg_Darkhound_Blood_Drop)" + nl
        + b"    EnableTrigger(gg_trg_Darkhound_Blood_Obtained)" + nl
        + b"  end" + nl
    )
    data = replace_once(data, init_start, init_start_fixed, "darkhound trigger enable")

    item_count = b"    ib_itemCount = 280" + nl
    quest_items = nl.join((
        b"    ib_itemList[280] = 1651008611",
        b'    ib_itemName[280] = "\xe9\xbb\x91\xe6\x9a\x97\xe7\x8a\xac\xe4\xb9\x8b\xe8\xa1\x80"',
        b"    ib_itemCustom[280] = 0",
        b"    ib_itemNameGbk[280] = ib_itemName[280]",
        b"    ib_itemList[281] = 1986880099",
        b'    ib_itemName[281] = "\xe5\xb7\xa2\xe6\xaf\x8d\xe6\xaf\x92\xe6\xb6\xb2"',
        b"    ib_itemCustom[281] = 0",
        b"    ib_itemNameGbk[281] = ib_itemName[281]",
        b"    ib_itemCount = 282",
        b"",
    ))
    data = replace_once(data, item_count, quest_items, "quest item browser entries")

    add_match = (
        b"    if ((name == ib_addName) or "
        b"IB_StrEqCI(IB_IdStr(ib_itemList[ib_addIdx]), ib_addName)) then" + nl
    )
    add_match_fixed = (
        b"    if ((name == ib_addName) or "
        b"IB_StrEqCI(IB_IdStr(ib_itemList[ib_addIdx]), ib_addName) "
        b"or ((ib_addIdx == 280) and "
        b"(IB_StrEqCI(ib_addName, \"blood\") or IB_StrEqCI(ib_addName, \"dogblood\") "
        b"or IB_StrEqCI(ib_addName, \"darkhound\"))) "
        b"or ((ib_addIdx == 281) and "
        b"(IB_StrEqCI(ib_addName, \"venom\") or IB_StrEqCI(ib_addName, \"broodmother\")))) then" + nl
    )
    data = replace_once(data, add_match, add_match_fixed, "quest item aliases")

    add_item_start = (
        b"function IB_AddItem(p, itemName, count)" + nl
        + b"  if (count < 1) then" + nl
        + b"    count = 1" + nl
        + b"  end" + nl
    )
    add_item_fixed = (
        add_item_start
        + b"  if StringLength(itemName) == 4 then" + nl
        + b"    IB_AddGive(p, FourCC(itemName), count)" + nl
        + b"    return" + nl
        + b"  end" + nl
    )
    data = replace_once(data, add_item_start, add_item_fixed, "arbitrary item id spawn")
    return data


def main():
    source = Path(sys.argv[1]).resolve() if len(sys.argv) > 1 else SOURCE
    output = OUTPUT
    output.parent.mkdir(parents=True, exist_ok=True)
    archive = war3mpq.MPQArchive(str(source))
    try:
        data = archive.read_file("war3map.lua")
    finally:
        archive.close()
    if not data:
        raise RuntimeError("war3map.lua not found: %s" % source)
    updated = patch_lua(data)
    mpq_patch.patch(str(source), [("war3map.lua", updated)], out_path=str(output), backup=False)
    check = war3mpq.MPQArchive(str(output))
    try:
        result = check.read_file("war3map.lua")
    finally:
        check.close()
    if result != updated:
        raise RuntimeError("war3map.lua read-back mismatch")
    for needle in (b'FourCC("n005")', b"dyingType",
                   b"EnableTrigger(gg_trg_Darkhound_Blood_Drop)",
                   b"EnableTrigger(gg_trg_Darkhound_Blood_Obtained)",
                   b"ib_itemCount = 282", b"ib_addIdx == 280",
                   b"FourCC(itemName)"):
        if result.count(needle) < 1:
            raise RuntimeError("missing patch marker: %r" % needle)

    module = ITEM_BROWSER.read_bytes()
    if b"set ib_itemList[280] = 'cdhb'" not in module:
        old_count = b"        set ib_itemCount = 280\n"
        quest_items = (
            b"        set ib_itemList[280] = 'cdhb'\n"
            b'        set ib_itemName[280] = "\xe9\xbb\x91\xe6\x9a\x97\xe7\x8a\xac\xe4\xb9\x8b\xe8\xa1\x80"\n'
            b"        set ib_itemNameGbk[280] = ib_itemName[280]\n"
            b"        set ib_itemCustom[280] = 0\n"
            b"        set ib_itemList[281] = 'cbmv'\n"
            b'        set ib_itemName[281] = "\xe5\xb7\xa2\xe6\xaf\x8d\xe6\xaf\x92\xe6\xb6\xb2"\n'
            b"        set ib_itemNameGbk[281] = ib_itemName[281]\n"
            b"        set ib_itemCustom[281] = 0\n"
            b"        set ib_itemCount = 282\n"
        )
        module = replace_once(module, old_count, quest_items, "module quest item entries")
        old_match = (
            b"        if name == ib_addName or "
            b"IB_StrEqCI(IB_IdStr(ib_itemList[ib_addIdx]), ib_addName) then\n"
        )
        new_match = (
            b"        if name == ib_addName or "
            b"IB_StrEqCI(IB_IdStr(ib_itemList[ib_addIdx]), ib_addName) "
            b"or (ib_addIdx == 280 and (IB_StrEqCI(ib_addName, \"blood\") "
            b"or IB_StrEqCI(ib_addName, \"dogblood\") or IB_StrEqCI(ib_addName, \"darkhound\"))) "
            b"or (ib_addIdx == 281 and (IB_StrEqCI(ib_addName, \"venom\") "
            b"or IB_StrEqCI(ib_addName, \"broodmother\"))) then\n"
        )
        module = replace_once(module, old_match, new_match, "module quest item aliases")
        ITEM_BROWSER.write_bytes(module)
    print("patched", output)
    print("lua bytes", len(updated))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
