#!/usr/bin/env python3
"""Fix Broodmother death handling and add a recovery chat command."""

import os
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
INJECTOR = os.path.join(ROOT, "tools", "war3map-injector")
sys.path.insert(0, INJECTOR)

import mpq_patch  # noqa: E402
import war3mpq  # noqa: E402

MARKER = b"ALAS_BROODMOTHER_RECOVERY_V1"


def replace_once(data, old, new):
    old_bytes = old.encode("utf-8")
    if data.count(old_bytes) != 1:
        raise RuntimeError(
            f"expected exactly one match, found {data.count(old_bytes)}"
        )
    return data.replace(old_bytes, new.encode("utf-8"), 1)


def patch_lua(data):
    if MARKER in data:
        raise RuntimeError("Broodmother recovery patch already present")

    death_old = """function InitTrig_Brood_Mother_Death()
  gg_trg_Brood_Mother_Death = CreateTrigger()
  TriggerRegisterAnyUnitEventBJ(gg_trg_Brood_Mother_Death, EVENT_PLAYER_UNIT_DEATH)
"""
    death_new = """function InitTrig_Brood_Mother_Death()
  gg_trg_Brood_Mother_Death = CreateTrigger()
  -- ALAS_BROODMOTHER_RECOVERY_V1
  TriggerRegisterAnyUnitEventBJ(gg_trg_Brood_Mother_Death, EVENT_PLAYER_UNIT_DEATH)
  TriggerRegisterPlayerUnitEvent(gg_trg_Brood_Mother_Death, Player(PLAYER_NEUTRAL_AGGRESSIVE), EVENT_PLAYER_UNIT_DEATH, nil)
"""
    data = replace_once(data, death_old, death_new)

    web_death_old = """function InitTrig_Brood_Mother_Web_Dies()
  gg_trg_Brood_Mother_Web_Dies = CreateTrigger()
  TriggerRegisterAnyUnitEventBJ(gg_trg_Brood_Mother_Web_Dies, EVENT_PLAYER_UNIT_DEATH)
"""
    web_death_new = """function InitTrig_Brood_Mother_Web_Dies()
  gg_trg_Brood_Mother_Web_Dies = CreateTrigger()
  TriggerRegisterAnyUnitEventBJ(gg_trg_Brood_Mother_Web_Dies, EVENT_PLAYER_UNIT_DEATH)
  TriggerRegisterPlayerUnitEvent(gg_trg_Brood_Mother_Web_Dies, Player(PLAYER_NEUTRAL_AGGRESSIVE), EVENT_PLAYER_UNIT_DEATH, nil)
"""
    data = replace_once(data, web_death_old, web_death_new)

    wall_old = """function Trig_Brood_Mother_Destroy_Wall_Actions()
  KillDestructable(gg_dest_BSG3_1304)
end
"""
    wall_new = """function Trig_Brood_Mother_Destroy_Wall_Actions()
  SetDestructableInvulnerableBJ(gg_dest_BSG3_1304, false)
  KillDestructable(gg_dest_BSG3_1304)
end
"""
    data = replace_once(data, wall_old, wall_new)

    neutral_old = """function Trig_Brood_Mother_Group_Remove_From_Group_Actions()
  if Trig_Brood_Mother_Group_Remove_From_Group_Func001C() then
    GroupRemoveUnitSimple(GetDyingUnit(), udg_BossBroodMotherGroup)
  else
    DoNothing()
  end
end
"""
    neutral_new = """function Trig_Brood_Mother_Group_Remove_From_Group_Actions()
  GroupRemoveUnitSimple(GetDyingUnit(), udg_BossBroodMotherGroup)
  ConditionalTriggerExecute(gg_trg_Brood_Mother_Death)
end
"""
    data = replace_once(data, neutral_old, neutral_new)

    command_old = """  elseif IB_StrEqCI(cmd, "unpause") then
    -- ALAS_SELECTED_UNPAUSE_V1
    local u = IB_GetSelectedUnit(p)
    if (u == nil) then
      IB_Message(p, "请先选中需要恢复暂停的单位")
    else
      PauseUnitBJ(false, u)
      SetUnitTimeScale(u, 1.0)
      SetUserControlForceOn(udg_PlayerGroup_User)
      IB_Message(p, __cat("已解除 ", GetUnitName(u), " 的暂停"))
      u = nil
    end
  end
end
"""
    command_new = """  elseif IB_StrEqCI(cmd, "unpause") then
    -- ALAS_SELECTED_UNPAUSE_V1
    local u = IB_GetSelectedUnit(p)
    if (u == nil) then
      IB_Message(p, "请先选中需要恢复暂停的单位")
    else
      PauseUnitBJ(false, u)
      SetUnitTimeScale(u, 1.0)
      SetUserControlForceOn(udg_PlayerGroup_User)
      IB_Message(p, __cat("已解除 ", GetUnitName(u), " 的暂停"))
      u = nil
    end
  elseif IB_StrEqCI(cmd, "broodfix") then
    -- ALAS_BROODMOTHER_RECOVERY_V1
    local u = IB_GetSelectedUnit(p)
    local loc
    if (u == nil) then
      u = udg_Hero_Anya
    end
    if (u == nil) then
      IB_Message(p, "请先选中需要补发巢母毒液的英雄")
    else
      loc = GetUnitLoc(u)
      if (udg_SuppliesBroodmotherVenomOwned ~= true) then
        CreateItemLoc(FourCC("cbmv"), loc)
        SetItemInvulnerableBJ(GetLastCreatedItem(), true)
      end
      RemoveLocation(loc)
      if (gg_dest_BSG3_1304 ~= nil) then
        SetDestructableInvulnerableBJ(gg_dest_BSG3_1304, false)
        KillDestructable(gg_dest_BSG3_1304)
      end
      if (udg_BossBroodMotherWebUnit ~= nil) then
        PauseUnitBJ(false, udg_BossBroodMotherWebUnit)
        SetUnitTimeScale(udg_BossBroodMotherWebUnit, 1.0)
        udg_BossBroodMotherWebUnit = nil
      end
      udg_BossBroodMotherFightInProgress = false
      PauseUnitBJ(false, u)
      SetUnitTimeScale(u, 1.0)
      SetUserControlForceOn(udg_PlayerGroup_User)
      IB_Message(p, "已补发巢母毒液并打开蜘蛛网门")
      u = nil
      loc = nil
    end
  end
end
"""
    data = replace_once(data, command_old, command_new)

    registration_old = """    TriggerRegisterPlayerChatEvent(t, Player(i), "unpause", false)
    i = (i + 1)
"""
    registration_new = """    TriggerRegisterPlayerChatEvent(t, Player(i), "unpause", false)
    TriggerRegisterPlayerChatEvent(t, Player(i), "broodfix", false)
    i = (i + 1)
"""
    data = replace_once(data, registration_old, registration_new)
    return data


def main():
    if len(sys.argv) != 3:
        raise SystemExit(
            "usage: patch_forsaken_broodmother_recovery.py INPUT_MAP OUTPUT_MAP"
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
