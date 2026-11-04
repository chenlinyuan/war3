#!/usr/bin/env python3
"""Harden Forest darkhound and broodmother task-item drops."""

import os
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
INJECTOR = os.path.join(ROOT, "tools", "war3map-injector")
sys.path.insert(0, INJECTOR)

import mpq_patch  # noqa: E402
import war3mpq  # noqa: E402

MARKER = b"ALAS_TASK_ITEM_DROPS_V2"


def replace_once(data, old, new):
    old_bytes = old.encode("utf-8")
    count = data.count(old_bytes)
    if count != 1:
        raise RuntimeError(f"expected exactly one match, found {count}")
    return data.replace(old_bytes, new.encode("utf-8"), 1)


def patch_lua(data):
    if MARKER in data:
        raise RuntimeError("task-item drop hardening already present")
    for required in (
        b"ALAS_DARKHOUND_SEARCH_V1",
        b"ALAS_BROODMOTHER_SOURCE_FIX_V1",
        b"ALAS_SELECTED_UNPAUSE_V1",
        b"ALAS_MQ_QT_ALL_MAPS_V1",
    ):
        if required not in data:
            raise RuntimeError("required prior patch is missing: " + required.decode())
    if b"broodfix" in data:
        raise RuntimeError("refusing to patch a map containing broodfix")

    state_old = """function Trig_Map_Load_Supplies_Determine_State_Func001C()
  if not (udg_Int_CurrentDHBloodCount >= udg_Int_TargetDHBloodCount) then
    return false
  end
  return true
end
"""
    state_new = """function Trig_Map_Load_Supplies_Determine_State_Func001C()
  -- ALAS_TASK_ITEM_DROPS_V2
  if udg_Bool_MQApotSupplyDarkhoundDone ~= true then
    return false
  end
  if not (udg_Int_CurrentDHBloodCount >= udg_Int_TargetDHBloodCount) then
    return false
  end
  return true
end
"""
    data = replace_once(data, state_old, state_new)

    darkhound_old = """function InitTrig_Darkhound_Blood_Drop()
  gg_trg_Darkhound_Blood_Drop = CreateTrigger()
  -- ALAS_DARKHOUND_SEARCH_V1
  TriggerRegisterPlayerUnitEvent(gg_trg_Darkhound_Blood_Drop, Player(PLAYER_NEUTRAL_AGGRESSIVE), EVENT_PLAYER_UNIT_DEATH, nil)
"""
    darkhound_new = """function InitTrig_Darkhound_Blood_Drop()
  gg_trg_Darkhound_Blood_Drop = CreateTrigger()
  -- ALAS_DARKHOUND_SEARCH_V1
  TriggerRegisterAnyUnitEventBJ(gg_trg_Darkhound_Blood_Drop, EVENT_PLAYER_UNIT_DEATH)
  TriggerRegisterPlayerUnitEvent(gg_trg_Darkhound_Blood_Drop, Player(PLAYER_NEUTRAL_AGGRESSIVE), EVENT_PLAYER_UNIT_DEATH, nil)
"""
    data = replace_once(data, darkhound_old, darkhound_new)

    brood_old = """  if udg_BossBroodMotherWebUnit ~= nil then
    PauseUnitBJ(false, udg_BossBroodMotherWebUnit)
    SetUnitTimeScalePercent(udg_BossBroodMotherWebUnit, 100.0)
    udg_BossBroodMotherWebUnit = nil
  end
  ConditionalTriggerExecute(gg_trg_Brood_Mother_Reset)
  DestroyEffectBJ(udg_SEHeroGlowBroodMother)
  RemoveLocation(udg_BossBroodMotherAttackLocation)
  udg_TempPoint = GetUnitLoc(GetDyingUnit())
  CreateItemLoc(FourCC("cbmv"), udg_TempPoint)
  SetItemInvulnerableBJ(GetLastCreatedItem(), true)
  RemoveLocation(udg_TempPoint)
  CreateItemLoc(FourCC("rspd"), GetRectCenter(gg_rct_RuneOfSpeedSpider))
end
"""
    brood_new = """  if udg_BossBroodMotherWebUnit ~= nil then
    PauseUnitBJ(false, udg_BossBroodMotherWebUnit)
    SetUnitTimeScalePercent(udg_BossBroodMotherWebUnit, 100.0)
    udg_BossBroodMotherWebUnit = nil
  end
  udg_TempPoint = GetUnitLoc(GetDyingUnit())
  CreateItemLoc(FourCC("cbmv"), udg_TempPoint)
  if GetLastCreatedItem() ~= nil then
    SetItemInvulnerableBJ(GetLastCreatedItem(), true)
    SetItemVisible(GetLastCreatedItem(), true)
  end
  RemoveLocation(udg_TempPoint)
  CreateItemLoc(FourCC("rspd"), GetRectCenter(gg_rct_RuneOfSpeedSpider))
  ConditionalTriggerExecute(gg_trg_Brood_Mother_Reset)
  DestroyEffectBJ(udg_SEHeroGlowBroodMother)
  RemoveLocation(udg_BossBroodMotherAttackLocation)
end
"""
    data = replace_once(data, brood_old, brood_new)
    return data


def main():
    if len(sys.argv) != 3:
        raise SystemExit(
            "usage: patch_forsaken_task_item_drops_v2.py INPUT_MAP OUTPUT_MAP"
        )
    source, destination = sys.argv[1:]
    if os.path.exists(destination):
        raise SystemExit("output already exists: " + destination)

    archive = war3mpq.MPQArchive(source)
    try:
        lua = archive.read_file("war3map.lua")
    finally:
        archive.close()
    if not lua:
        raise SystemExit("war3map.lua is missing")

    updated = patch_lua(lua)
    mpq_patch.patch(
        source,
        [("war3map.lua", updated)],
        out_path=destination,
        backup=False,
    )
    check = war3mpq.MPQArchive(destination)
    try:
        result = check.read_file("war3map.lua")
    finally:
        check.close()
    if result != updated:
        raise SystemExit("war3map.lua read-back mismatch")
    print("built", destination, "lua", len(lua), "->", len(updated))


if __name__ == "__main__":
    main()
