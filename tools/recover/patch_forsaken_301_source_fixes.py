#!/usr/bin/env python3
"""Apply the five known Forsaken 3.0.1 gameplay fixes to extracted chapters.

Run this against ``<work>/base`` after extracting the WCT-repaired campaign
with ``port_wings_campaign.py extract`` and before running the ALAS injector.
The campaign archive itself is not modified.
"""

from __future__ import annotations

import argparse
import os
import shutil
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
INJECTOR = ROOT / "tools" / "war3map-injector"
RECOVER = ROOT / "tools" / "recover"
sys.path.insert(0, str(INJECTOR))
sys.path.insert(0, str(RECOVER))

import mpq_patch  # noqa: E402
import war3mpq as W  # noqa: E402
import patch_forsaken_pest_bug as PEST  # noqa: E402
import patch_forsaken_sapper_tunnel as SAPPER  # noqa: E402


SOURCE_MARKER = "-- ALAS_FORSaken_301_KNOWN_GAMEPLAY_FIXES_V1"
BANSHEE_MARKER = "-- ALAS_BANSHEE_UNPAUSE_V2"
DARKHOUND_MARKER = "-- ALAS_DARKHOUND_NEUTRAL_DROP_V2"
BROOD_MARKER = "-- ALAS_BROODMOTHER_DEATH_FIX_V2"

UNPAUSE = """  PauseUnitBJ(false, udg_Hero_Anya)
  PauseUnitBJ(false, udg_Hero_Garek)
  SetUserControlForceOn(GetPlayersAll())
"""


def replace_once(data: str, old: str, new: str, label: str) -> str:
    count = data.count(old)
    if count != 1:
        raise RuntimeError(f"{label}: expected one match, found {count}")
    return data.replace(old, new, 1)


def replace_optional(data: str, old: str, new: str, label: str) -> str:
    count = data.count(old)
    if count > 1:
        raise RuntimeError(f"{label}: expected at most one match, found {count}")
    return data.replace(old, new, 1)


def patch_pest(data: str) -> str:
    if PEST.MARKER in data:
        raise RuntimeError("pest fix is already present")

    data = replace_once(
        data,
        PEST.OLD,
        PEST.SIZE_FIX,
        "rat-nest size action",
    )
    data = replace_once(
        data,
        PEST.AUTO_BURN_OLD,
        PEST.AUTO_BURN_NEW,
        "rat-nest automatic spawn condition",
    )
    data = replace_once(
        data,
        PEST.NEST_DEATH_OLD,
        PEST.NEST_DEATH_NEW,
        "rat-nest death cleanup",
    )
    data = replace_once(
        data,
        PEST.EXTERMINATED_OLD,
        PEST.EXTERMINATED_NEW,
        "rat-nest completion condition",
    )
    data = replace_once(
        data,
        PEST.REGISTER_OLD,
        PEST.REGISTER_NEW,
        "rat-nest periodic completion registration",
    )
    if data.count(PEST.MARKER) != 1:
        raise RuntimeError("pest fix marker count is not one")
    return data


def patch_sapper(data: str) -> str:
    if SAPPER.MARKER in data:
        raise RuntimeError("sapper-tunnel fix is already present")

    data = replace_once(
        data,
        "udg_ST_Explosives_Item = nil\n",
        (
            "udg_ST_Explosives_Item = nil\n"
            "udg_ST_TunnelDone = __jarray(false)\n"
            "udg_ST_TunnelExploded = __jarray(false)\n"
        ),
        "sapper state globals",
    )
    data = replace_once(
        data,
        "function Trig_Sapper_Tunnels_Explosive_Barrels_Conditions()\n",
        (
            SAPPER.HELPERS
            + "\n\nfunction Trig_Sapper_Tunnels_Explosive_Barrels_Conditions()\n"
        ),
        "sapper helpers",
    )
    data = replace_once(
        data,
        SAPPER.DEATH_OLD,
        SAPPER.DEATH_NEW,
        "sapper barrel death action",
    )
    for site in (1, 2, 3):
        data = patch_sapper_entrance(data, site)
    data = replace_once(
        data,
        SAPPER.INIT_OLD,
        SAPPER.INIT_NEW,
        "sapper load repair",
    )
    if data.count(SAPPER.MARKER) != 1:
        raise RuntimeError("sapper fix marker count is not one")
    return data


def patch_sapper_entrance(data: str, site: int) -> str:
    """Support both the direct-item and udg-item Forsaken variants."""
    candidates = (
        (sapper_entrance_old(site), sapper_entrance_new(site), "direct-item"),
        (SAPPER.entrance_old(site), SAPPER.entrance_new(site), "udg-item"),
    )
    matches = [
        (old, new, label)
        for old, new, label in candidates
        if data.count(old) == 1
    ]
    if len(matches) != 1:
        counts = ", ".join(
            f"{label}={data.count(old)}"
            for old, _new, label in candidates
        )
        raise RuntimeError(
            f"sapper entrance {site:02d}: expected one supported variant, "
            f"found {counts}"
        )
    old, new, _label = matches[0]
    return data.replace(old, new, 1)


def sapper_entrance_old(site: int) -> str:
    suffix = f"{site:02d}"
    guard = "Func004C" if site == 1 else "Func003C"
    nested_bag = "Func004Func002C" if site == 1 else "Func003Func002C"
    nested_direct = "Func004Func004C" if site == 1 else "Func003Func004C"
    return f"""function Trig_Sapper_Tunnels_Blow_Entrance_{suffix}_Actions()
  DisableTrigger(GetTriggeringTrigger())
  if Trig_Sapper_Tunnels_Blow_Entrance_{suffix}_{guard}() then
    SetItemCharges(GetItemOfTypeFromUnitBagBJ(GetTriggerUnit(), FourCC("cexp")), GetItemCharges(GetItemOfTypeFromUnitBagBJ(GetTriggerUnit(), FourCC("cexp"))) - 1)
    if Trig_Sapper_Tunnels_Blow_Entrance_{suffix}_{nested_bag}() then
      RemoveItem(GetItemOfTypeFromUnitBagBJ(GetTriggerUnit(), FourCC("cexp")))
    else
    end
  else
    SetItemCharges(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), FourCC("cexp")), GetItemCharges(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), FourCC("cexp"))) - 1)
    if Trig_Sapper_Tunnels_Blow_Entrance_{suffix}_{nested_direct}() then
      RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), FourCC("cexp")))
    else
    end
  end
  udg_TempLoc[1] = GetRectCenter(gg_rct_STExplosivesRegion{suffix})
  CreateNUnitsAtLoc(1, FourCC("h00G"), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempLoc[1], bj_UNIT_FACING)
  SetDoodadAnimationBJ("hide", FourCC("DFcP"), 500.0, udg_TempLoc[1])
  RemoveLocation(udg_TempLoc[1])
end"""


def sapper_entrance_new(site: int) -> str:
    suffix = f"{site:02d}"
    guard = "Func004C" if site == 1 else "Func003C"
    nested_bag = "Func004Func002C" if site == 1 else "Func003Func002C"
    nested_direct = "Func004Func004C" if site == 1 else "Func003Func004C"
    return f"""function Trig_Sapper_Tunnels_Blow_Entrance_{suffix}_Actions()
  local barrel
  local barrelId
  DisableTrigger(GetTriggeringTrigger())
  if Trig_Sapper_Tunnels_Blow_Entrance_{suffix}_{guard}() then
    SetItemCharges(GetItemOfTypeFromUnitBagBJ(GetTriggerUnit(), FourCC("cexp")), GetItemCharges(GetItemOfTypeFromUnitBagBJ(GetTriggerUnit(), FourCC("cexp"))) - 1)
    if Trig_Sapper_Tunnels_Blow_Entrance_{suffix}_{nested_bag}() then
      RemoveItem(GetItemOfTypeFromUnitBagBJ(GetTriggerUnit(), FourCC("cexp")))
    else
    end
  else
    SetItemCharges(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), FourCC("cexp")), GetItemCharges(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), FourCC("cexp"))) - 1)
    if Trig_Sapper_Tunnels_Blow_Entrance_{suffix}_{nested_direct}() then
      RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), FourCC("cexp")))
    else
    end
  end
  udg_TempLoc[1] = GetRectCenter(gg_rct_STExplosivesRegion{suffix})
  CreateNUnitsAtLoc(1, FourCC("h00G"), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempLoc[1], bj_UNIT_FACING)
  barrel = GetLastCreatedUnit()
  SetDoodadAnimationBJ("hide", FourCC("DFcP"), 500.0, udg_TempLoc[1])
  RemoveLocation(udg_TempLoc[1])
  ALAS_ST_TunnelCompleteSite({site})
  if barrel ~= nil then
    barrelId = GetHandleId(barrel)
    TriggerRegisterUnitEvent(gg_trg_Sapper_Tunnels_Explosive_Barrels, barrel, EVENT_UNIT_DEATH)
  end
  TriggerSleepAction(1.5)
  if barrel ~= nil and GetHandleId(barrel) == barrelId and IsUnitAliveBJ(barrel) then
    KillUnit(barrel)
  end
  ALAS_ST_TunnelExplodeSite({site})
  barrel = nil
end"""


def patch_broodmother(data: str) -> str:
    if BROOD_MARKER in data:
        raise RuntimeError("broodmother fix is already present")

    death_old = """function InitTrig_Brood_Mother_Death()
  gg_trg_Brood_Mother_Death = CreateTrigger()
  TriggerRegisterAnyUnitEventBJ(gg_trg_Brood_Mother_Death, EVENT_PLAYER_UNIT_DEATH)
"""
    death_new = """function InitTrig_Brood_Mother_Death()
  gg_trg_Brood_Mother_Death = CreateTrigger()
  TriggerRegisterAnyUnitEventBJ(gg_trg_Brood_Mother_Death, EVENT_PLAYER_UNIT_DEATH)
  TriggerRegisterPlayerUnitEvent(gg_trg_Brood_Mother_Death, Player(PLAYER_NEUTRAL_AGGRESSIVE), EVENT_PLAYER_UNIT_DEATH, nil)
"""
    data = replace_once(data, death_old, death_new, "broodmother neutral death event")

    web_death_old = """function InitTrig_Brood_Mother_Web_Dies()
  gg_trg_Brood_Mother_Web_Dies = CreateTrigger()
  TriggerRegisterAnyUnitEventBJ(gg_trg_Brood_Mother_Web_Dies, EVENT_PLAYER_UNIT_DEATH)
"""
    web_death_new = """function InitTrig_Brood_Mother_Web_Dies()
  gg_trg_Brood_Mother_Web_Dies = CreateTrigger()
  TriggerRegisterAnyUnitEventBJ(gg_trg_Brood_Mother_Web_Dies, EVENT_PLAYER_UNIT_DEATH)
  TriggerRegisterPlayerUnitEvent(gg_trg_Brood_Mother_Web_Dies, Player(PLAYER_NEUTRAL_AGGRESSIVE), EVENT_PLAYER_UNIT_DEATH, nil)
"""
    data = replace_once(
        data,
        web_death_old,
        web_death_new,
        "broodmother neutral web-death event",
    )

    wall_old = """function Trig_Brood_Mother_Destroy_Wall_Actions()
  KillDestructable(gg_dest_BSG3_1304)
end
"""
    wall_new = """function Trig_Brood_Mother_Destroy_Wall_Actions()
  SetDestructableInvulnerableBJ(gg_dest_BSG3_1304, false)
  KillDestructable(gg_dest_BSG3_1304)
end
"""
    data = replace_once(data, wall_old, wall_new, "broodmother web wall")

    web_pause_old = """  PauseUnitBJ(true, udg_BossBroodMotherWebUnit)
  SetUnitTimeScalePercent(udg_BossBroodMotherWebUnit, 25.0)
"""
    web_pause_new = """  SetUnitTimeScalePercent(udg_BossBroodMotherWebUnit, 100.0)
"""
    data = replace_once(
        data,
        web_pause_old,
        web_pause_new,
        "broodmother web pause",
    )

    group_old = """function Trig_Brood_Mother_Group_Remove_From_Group_Actions()
  if Trig_Brood_Mother_Group_Remove_From_Group_Func001C() then
    GroupRemoveUnitSimple(GetDyingUnit(), udg_BossBroodMotherGroup)
  else
    DoNothing()
  end
end
"""
    group_new = """function Trig_Brood_Mother_Group_Remove_From_Group_Actions()
  GroupRemoveUnitSimple(GetDyingUnit(), udg_BossBroodMotherGroup)
  if IsTriggerEnabled(gg_trg_Brood_Mother_Death) == true then
    ConditionalTriggerExecute(gg_trg_Brood_Mother_Death)
  end
end
"""
    data = replace_once(
        data,
        group_old,
        group_new,
        "broodmother fallback death execution",
    )

    death_actions_old = """function Trig_Brood_Mother_Death_Actions()
  DisableTrigger(GetTriggeringTrigger())
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
    death_actions_new = """function Trig_Brood_Mother_Death_Actions()
  DisableTrigger(GetTriggeringTrigger())
  if udg_BossBroodMotherWebUnit ~= nil then
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
-- ALAS_BROODMOTHER_DEATH_FIX_V2
"""
    data = replace_once(
        data,
        death_actions_old,
        death_actions_new,
        "broodmother reward and web-release order",
    )
    if data.count(BROOD_MARKER) != 1:
        raise RuntimeError("broodmother marker count is not one")
    return data


def patch_darkhound(data: str) -> str:
    if DARKHOUND_MARKER in data:
        raise RuntimeError("darkhound fix is already present")

    registration_old = """function InitTrig_Darkhound_Blood_Drop()
  gg_trg_Darkhound_Blood_Drop = CreateTrigger()
  TriggerRegisterAnyUnitEventBJ(gg_trg_Darkhound_Blood_Drop, EVENT_PLAYER_UNIT_DEATH)
"""
    registration_new = """function InitTrig_Darkhound_Blood_Drop()
  gg_trg_Darkhound_Blood_Drop = CreateTrigger()
  -- ALAS_DARKHOUND_NEUTRAL_DROP_V2
  TriggerRegisterAnyUnitEventBJ(gg_trg_Darkhound_Blood_Drop, EVENT_PLAYER_UNIT_DEATH)
  TriggerRegisterPlayerUnitEvent(gg_trg_Darkhound_Blood_Drop, Player(PLAYER_NEUTRAL_AGGRESSIVE), EVENT_PLAYER_UNIT_DEATH, nil)
"""
    data = replace_once(
        data,
        registration_old,
        registration_new,
        "darkhound neutral death event",
    )

    action_old = """  udg_TempPoint = GetUnitLoc(GetDyingUnit())
  CreateItemLoc(FourCC("cdhb"), udg_TempPoint)
  SetItemInvulnerableBJ(GetLastCreatedItem(), true)
  RemoveLocation(udg_TempPoint)
"""
    action_new = """  udg_TempPoint = GetUnitLoc(GetDyingUnit())
  CreateItemLoc(FourCC("cdhb"), udg_TempPoint)
  if GetLastCreatedItem() ~= nil then
    SetItemInvulnerableBJ(GetLastCreatedItem(), true)
    SetItemVisible(GetLastCreatedItem(), true)
  end
  RemoveLocation(udg_TempPoint)
"""
    data = replace_once(
        data,
        action_old,
        action_new,
        "darkhound task-item visible drop",
    )

    state_old = """function Trig_Map_Load_Supplies_Determine_State_Func001C()
  if not (udg_Int_CurrentDHBloodCount >= udg_Int_TargetDHBloodCount) then
    return false
  end
  return true
end
"""
    state_new = """function Trig_Map_Load_Supplies_Determine_State_Func001C()
  if udg_Bool_MQApotSupplyDarkhoundDone ~= true then
    return false
  end
  if not (udg_Int_CurrentDHBloodCount >= udg_Int_TargetDHBloodCount) then
    return false
  end
  return true
end
"""
    data = replace_once(
        data,
        state_old,
        state_new,
        "darkhound saved task state",
    )

    init_old = """function RunInitializationTriggers()
  ConditionalTriggerExecute(gg_trg_Quest_Initialization)
"""
    init_new = """function RunInitializationTriggers()
  ConditionalTriggerExecute(gg_trg_Quest_Initialization)
  if udg_Bool_MQApotSupplyDarkhoundDone ~= true then
    EnableTrigger(gg_trg_Darkhound_Blood_Drop)
    EnableTrigger(gg_trg_Darkhound_Blood_Obtained)
  end
"""
    data = replace_once(
        data,
        init_old,
        init_new,
        "darkhound trigger restoration",
    )
    if data.count(DARKHOUND_MARKER) != 1:
        raise RuntimeError("darkhound marker count is not one")
    return data


def patch_banshee(data: str) -> str:
    if BANSHEE_MARKER in data:
        raise RuntimeError("banshee fix is already present")

    data = replace_once(
        data,
        """function Trig_OQ_05_Banshee_Complete_Actions()
  DisableTrigger(GetTriggeringTrigger())
""",
        """function Trig_OQ_05_Banshee_Complete_Actions()
  DisableTrigger(GetTriggeringTrigger())
"""
        + UNPAUSE,
        "banshee completion unpause",
    )
    data = replace_once(
        data,
        """function Trig_OQ_05_Banshee_Create_Actions()
  DisableTrigger(GetTriggeringTrigger())
""",
        """function Trig_OQ_05_Banshee_Create_Actions()
  DisableTrigger(GetTriggeringTrigger())
"""
        + UNPAUSE,
        "banshee creation unpause",
    )
    data = replace_once(
        data,
        """  if Trig_OQ_05_Banshee_Sync_Func016C() then
    return
  else
  end
  QuestItemSetCompletedBJ(udg_OQReq_SootheBanshees01, true)
""",
        """  if Trig_OQ_05_Banshee_Sync_Func016C() then
    return
  else
  end
"""
        + UNPAUSE
        + "  QuestItemSetCompletedBJ(udg_OQReq_SootheBanshees01, true)\n",
        "banshee synchronization unpause",
    )

    watchdog = f"""
{BANSHEE_MARKER}
do
  local trigger = CreateTrigger()
  TriggerRegisterAnyUnitEventBJ(trigger, EVENT_PLAYER_UNIT_DEATH)
  TriggerAddAction(trigger, function()
    if GetUnitTypeId(GetDyingUnit()) == FourCC("uban") and udg_OQBansheeProgression >= 1 and udg_OQBansheeProgression < 3 then
      PauseUnitBJ(false, udg_Hero_Anya)
      PauseUnitBJ(false, udg_Hero_Garek)
      SetUserControlForceOn(GetPlayersAll())
    end
  end)
end
"""
    data = data.rstrip() + "\n" + watchdog
    if data.count(BANSHEE_MARKER) != 1:
        raise RuntimeError("banshee marker count is not one")
    return data


def patch_lua(name: str, data: bytes) -> bytes:
    text = data.decode("utf-8")
    if "\r\n" in text:
        raise RuntimeError(f"{name}: expected normalized LF line endings")

    changed = False
    if name == "UndeadRE02.w3x":
        text = patch_pest(text)
        text = patch_sapper(text)
        changed = True
    if name == "UndeadRE01_03.w3x":
        text = patch_broodmother(text)
        text = patch_darkhound(text)
        changed = True
    if "function Trig_OQ_05_Banshee_Complete_Actions()" in text:
        text = patch_banshee(text)
        changed = True
    if changed and SOURCE_MARKER not in text:
        text = text.rstrip() + "\n" + SOURCE_MARKER + "\n"
    return text.encode("utf-8")


def patch_map(path: Path) -> bytes:
    archive = W.MPQArchive(str(path))
    try:
        lua = archive.read_file("war3map.lua")
    finally:
        archive.close()
    if not lua:
        raise RuntimeError(f"{path.name}: war3map.lua is missing")
    if SOURCE_MARKER.encode("utf-8") in lua:
        verify_lua(path.name, lua)
        return lua

    updated = patch_lua(path.name, lua)
    temp = path.with_suffix(".source-fixed.w3x")
    temp.unlink(missing_ok=True)
    try:
        mpq_patch.patch(
            str(path),
            [("war3map.lua", updated)],
            out_path=str(temp),
            backup=False,
        )
        check = W.MPQArchive(str(temp))
        try:
            if check.read_file("war3map.lua") != updated:
                raise RuntimeError(f"{path.name}: Lua read-back mismatch")
            if check.read_file("war3map.wct") is None:
                raise RuntimeError(f"{path.name}: WCT was lost")
        finally:
            check.close()
        shutil.move(str(temp), str(path))
    finally:
        temp.unlink(missing_ok=True)
    return updated


def verify_lua(name: str, data: bytes) -> None:
    text = data.decode("utf-8")
    required = [SOURCE_MARKER]
    if name == "UndeadRE02.w3x":
        required += [
            PEST.MARKER,
            SAPPER.MARKER,
            "TriggerRegisterTimerEventPeriodic(gg_trg_Plague_Rats_Exterminated, 0.5)",
            "TriggerRegisterGameLoadedEventBJ(gg_trg_Sapper_Tunnels_Init)",
        ]
    if name == "UndeadRE01_03.w3x":
        required += [
            BROOD_MARKER,
            DARKHOUND_MARKER,
            "TriggerRegisterPlayerUnitEvent(gg_trg_Darkhound_Blood_Drop, Player(PLAYER_NEUTRAL_AGGRESSIVE)",
            "TriggerRegisterPlayerUnitEvent(gg_trg_Brood_Mother_Death, Player(PLAYER_NEUTRAL_AGGRESSIVE)",
            "SetDestructableInvulnerableBJ(gg_dest_BSG3_1304, false)",
        ]
    if "function Trig_OQ_05_Banshee_Complete_Actions()" in text:
        required.append(BANSHEE_MARKER)
    for marker in required:
        count = text.count(marker)
        expected = 1
        if count != expected:
            raise RuntimeError(
                f"{name}: marker {marker!r} count {count}, expected {expected}"
            )


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--work", required=True, type=Path)
    args = parser.parse_args()

    base = args.work.resolve() / "base"
    if not base.is_dir():
        raise SystemExit(f"missing extracted base directory: {base}")

    expected = {
        "UndeadRE02.w3x",
        "UndeadRE01_03.w3x",
        "UndeadRE01.w3x",
        "UndeadRE01_02.w3x",
        "UndeadRE01_05.w3x",
        "UndeadRE01_06.w3x",
    }
    found = {path.name for path in base.glob("*.w3x")}
    missing = expected - found
    if missing:
        raise SystemExit("missing chapters: " + ", ".join(sorted(missing)))

    patched = []
    for name in sorted(expected):
        path = base / name
        lua = patch_map(path)
        if SOURCE_MARKER in lua.decode("utf-8"):
            verify_lua(path.name, lua)
            patched.append(path.name)

    missing_patches = expected - set(patched)
    if missing_patches:
        raise SystemExit("expected fixes missing from: " + ", ".join(sorted(missing_patches)))
    print("patched chapters:", ", ".join(patched))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
