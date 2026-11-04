#!/usr/bin/env python3
"""Fix the Forsaken Act Two sapper-tunnel quest without changing other deaths."""

import hashlib
import sys
import zlib
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
INJECTOR = ROOT / "tools" / "war3map-injector"
sys.path.insert(0, str(INJECTOR))

import mpq_patch  # noqa: E402
import war3mpq  # noqa: E402

MAP_NAME = "UndeadRE02.w3x"
MARKER = "-- ALAS_SAPPER_TUNNEL_TRIGGER_FIX_V1"
HELPERS = (ROOT / "tools" / "recover" / "forsaken_sapper_tunnel_fix.lua").read_text(
    encoding="utf-8"
).replace("\r\n", "\n").rstrip()


def replace_once(data, old, new, label):
    old_bytes = old.encode("utf-8")
    count = data.count(old_bytes)
    if count != 1:
        raise RuntimeError(f"expected one {label}, found {count}")
    return data.replace(old_bytes, new.encode("utf-8"), 1)


DEATH_OLD = """function Trig_Sapper_Tunnels_Explosive_Barrels_Actions()
  if Trig_Sapper_Tunnels_Explosive_Barrels_Func001C() then
    SetDoodadAnimationRectBJ("show", FourCC("D00D"), gg_rct_CaveDebrisRegion01)
    QueuedTriggerAddBJ(gg_trg_Minimap_Icon_and_TTM_Destroy_Closing_the_Breach_Entrance_01, true)
  elseif Trig_Sapper_Tunnels_Explosive_Barrels_Func001Func003C() then
    SetDoodadAnimationRectBJ("show", FourCC("D00D"), gg_rct_CaveDebrisRegion02)
    QueuedTriggerAddBJ(gg_trg_Minimap_Icon_and_TTM_Destroy_Closing_the_Breach_Entrance_02, true)
  else
    if Trig_Sapper_Tunnels_Explosive_Barrels_Func001Func003Func003C() then
      SetDoodadAnimationRectBJ("show", FourCC("D00D"), gg_rct_CaveDebrisRegion03)
      QueuedTriggerAddBJ(gg_trg_Minimap_Icon_and_TTM_Destroy_Closing_the_Breach_Entrance_03, true)
    else
    end
  end
  udg_TempLoc[1] = GetUnitLoc(GetTriggerUnit())
  AddSpecialEffectLocBJ(udg_TempLoc[1], "Objects\\\\Spawnmodels\\\\Human\\\\FragmentationShards\\\\FragBoomSpawn.mdl")
  BlzSetSpecialEffectScale(GetLastCreatedEffectBJ(), 3.0)
  DestroyEffectBJ(GetLastCreatedEffectBJ())
  udg_TempGroup[1] = GetUnitsInRangeOfLocMatching(300.0, udg_TempLoc[1], Condition(Trig_Sapper_Tunnels_Explosive_Barrels_Func006002003))
  ForGroupBJ(udg_TempGroup[1], Trig_Sapper_Tunnels_Explosive_Barrels_Func007A)
  DestroyGroup(udg_TempGroup[1])
  RemoveLocation(udg_TempLoc[1])
  CameraSetEQNoiseForPlayer(udg_PlayerUser, 15.0)
  udg_QJ_ReqNumberedCurrent_01[4] = udg_QJ_ReqNumberedCurrent_01[4] + 1
  QueuedTriggerAddBJ(udg_QM_PushIndexTriggers[4], false)
  if Trig_Sapper_Tunnels_Explosive_Barrels_Func014C() then
    QueuedTriggerAddBJ(gg_trg_Minimap_Icon_and_TTM_Create_Closing_the_Breach_Turn_In_01, false)
    QueuedTriggerAddBJ(gg_trg_Minimap_Icon_and_TTM_Create_Closing_the_Breach_Turn_In_02, false)
    QueuedTriggerAddBJ(gg_trg_Minimap_Icon_and_TTM_Hide_Cave_Entrance_UC, false)
    QueuedTriggerAddBJ(udg_QM_PushReqTriggers[1], false)
    QueuedTriggerAddBJ(udg_QM_PushReqTriggers[2], false)
  else
    QueuedTriggerAddBJ(udg_QM_PushReqTriggers[1], false)
    if Trig_Sapper_Tunnels_Explosive_Barrels_Func014Func007C() then
      QueuedTriggerAddBJ(gg_trg_Transmissions_Dialogue_43_One_Breach_Down, true)
    else
    end
  end
  QueuedTriggerAddBJ(gg_trg_Quest_Message_and_Completion_Handler_Run_Trigger, true)
  TriggerSleepAction(0.3)
  CameraClearNoiseForPlayer(udg_PlayerUser)
  TriggerSleepAction(1.0)
  if Trig_Sapper_Tunnels_Explosive_Barrels_Func019C() then
    QueuedTriggerAddBJ(gg_trg_Transmissions_Dialogue_43_One_Breach_Down, true)
  else
  end
end"""

DEATH_NEW = """function Trig_Sapper_Tunnels_Explosive_Barrels_Actions()
  local site = ALAS_ST_TunnelSiteForUnit(GetTriggerUnit())
  if site == 0 then
    return
  end
  ALAS_ST_TunnelExplodeSite(site)
  ALAS_ST_TunnelCompleteSite(site)
end"""


def entrance_old(site):
    suffix = f"{site:02d}"
    charges_guard = {
        1: "Func005C",
        2: "Func004C",
        3: "Func004C",
    }[site]
    return f"""function Trig_Sapper_Tunnels_Blow_Entrance_{suffix}_Actions()
  DisableTrigger(GetTriggeringTrigger())
  SetItemCharges(udg_ST_Explosives_Item, GetItemCharges(udg_ST_Explosives_Item) - 1)
  if Trig_Sapper_Tunnels_Blow_Entrance_{suffix}_{charges_guard}() then
    RemoveItem(udg_ST_Explosives_Item)
  else
  end
  udg_TempLoc[1] = GetRectCenter(gg_rct_STExplosivesRegion{suffix})
  CreateNUnitsAtLoc(1, FourCC("h00G"), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempLoc[1], bj_UNIT_FACING)
  SetDoodadAnimationBJ("hide", FourCC("DFcP"), 500.0, udg_TempLoc[1])
  RemoveLocation(udg_TempLoc[1])
end"""


def entrance_new(site):
    suffix = f"{site:02d}"
    charges_guard = {
        1: "Func005C",
        2: "Func004C",
        3: "Func004C",
    }[site]
    return f"""function Trig_Sapper_Tunnels_Blow_Entrance_{suffix}_Actions()
  local barrel
  local barrelId
  DisableTrigger(GetTriggeringTrigger())
  SetItemCharges(udg_ST_Explosives_Item, GetItemCharges(udg_ST_Explosives_Item) - 1)
  if Trig_Sapper_Tunnels_Blow_Entrance_{suffix}_{charges_guard}() then
    RemoveItem(udg_ST_Explosives_Item)
  else
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
end"""


INIT_OLD = """function Trig_Sapper_Tunnels_Init_Actions()
  SetDoodadAnimationRectBJ("hide", FourCC("DFcP"), gg_rct_BrokenCaveRegion03)
  SetDoodadAnimationRectBJ("hide", FourCC("D00D"), gg_rct_CaveDebrisRegion01)
  SetDoodadAnimationRectBJ("hide", FourCC("D00D"), gg_rct_CaveDebrisRegion02)
  SetDoodadAnimationRectBJ("hide", FourCC("D00D"), gg_rct_CaveDebrisRegion03)
end

function InitTrig_Sapper_Tunnels_Init()
  gg_trg_Sapper_Tunnels_Init = CreateTrigger()
  TriggerAddAction(gg_trg_Sapper_Tunnels_Init, Trig_Sapper_Tunnels_Init_Actions)
end"""

INIT_NEW = """function Trig_Sapper_Tunnels_Init_Actions()
  SetDoodadAnimationRectBJ("hide", FourCC("DFcP"), gg_rct_BrokenCaveRegion03)
  SetDoodadAnimationRectBJ("hide", FourCC("D00D"), gg_rct_CaveDebrisRegion01)
  SetDoodadAnimationRectBJ("hide", FourCC("D00D"), gg_rct_CaveDebrisRegion02)
  SetDoodadAnimationRectBJ("hide", FourCC("D00D"), gg_rct_CaveDebrisRegion03)
  ALAS_ST_TunnelRepairFromEntrances()
end

function InitTrig_Sapper_Tunnels_Init()
  gg_trg_Sapper_Tunnels_Init = CreateTrigger()
  TriggerRegisterGameLoadedEventBJ(gg_trg_Sapper_Tunnels_Init)
  TriggerAddAction(gg_trg_Sapper_Tunnels_Init, Trig_Sapper_Tunnels_Init_Actions)
end"""


def patch_lua(data):
    if MARKER.encode() in data:
        raise RuntimeError("sapper tunnel fix is already present")
    if b"-- ALAS_PEST_SLOW_BURN_FIX_V3" not in data:
        raise RuntimeError("expected the current pestfix map as baseline")

    data = replace_once(
        data,
        "udg_ST_Explosives_Item = nil\n",
        "udg_ST_Explosives_Item = nil\nudg_ST_TunnelDone = __jarray(false)\nudg_ST_TunnelExploded = __jarray(false)\n",
        "sapper state globals",
    )
    data = replace_once(
        data,
        "function Trig_Sapper_Tunnels_Explosive_Barrels_Conditions()\n",
        HELPERS + "\n\nfunction Trig_Sapper_Tunnels_Explosive_Barrels_Conditions()\n",
        "sapper helper insertion point",
    )
    data = replace_once(data, DEATH_OLD, DEATH_NEW, "sapper death action")
    for site in (1, 2, 3):
        data = replace_once(
            data,
            entrance_old(site),
            entrance_new(site),
            f"sapper entrance {site:02d} action",
        )
    data = replace_once(data, INIT_OLD, INIT_NEW, "sapper load repair init")

    if data.count(MARKER.encode()) != 1:
        raise RuntimeError("sapper fix marker count is not one")
    if data.count(b"ALAS_ST_TunnelCompleteSite(1)") != 1:
        raise RuntimeError("sapper site 1 call count is not one")
    if data.count(b"ALAS_ST_TunnelCompleteSite(2)") != 1:
        raise RuntimeError("sapper site 2 call count is not one")
    if data.count(b"ALAS_ST_TunnelCompleteSite(3)") != 1:
        raise RuntimeError("sapper site 3 call count is not one")
    return data


def main():
    if len(sys.argv) != 4:
        raise SystemExit(
            "usage: patch_forsaken_sapper_tunnel.py "
            "INPUT_CAMPAIGN INPUT_MAP OUTPUT_DIR"
        )
    source_campaign = Path(sys.argv[1]).resolve()
    source_map = Path(sys.argv[2]).resolve()
    output_dir = Path(sys.argv[3]).resolve()
    output_dir.mkdir(parents=True, exist_ok=True)
    output_map = output_dir / MAP_NAME
    output_lua = output_dir / "UndeadRE02.lua"
    output_campaign = output_dir / "alas被遗忘的王国-封堵缺口修复-v1.w3n"
    for output in (output_map, output_lua, output_campaign):
        if output.exists():
            raise SystemExit("output already exists: " + str(output))

    source_archive = war3mpq.MPQArchive(str(source_map))
    try:
        lua = source_archive.read_file("war3map.lua")
    finally:
        source_archive.close()
    if not lua:
        raise RuntimeError("war3map.lua is missing from " + MAP_NAME)

    updated = patch_lua(lua)
    mpq_patch.patch(
        str(source_map),
        [("war3map.lua", updated)],
        out_path=str(output_map),
        backup=False,
    )
    output_lua.write_bytes(updated)

    check = war3mpq.MPQArchive(str(output_map))
    try:
        if check.read_file("war3map.lua") != updated:
            raise RuntimeError("patched map Lua read-back mismatch")
    finally:
        check.close()

    patched_map = output_map.read_bytes()
    mpq_patch.patch(
        str(source_campaign),
        [(MAP_NAME, patched_map)],
        out_path=str(output_campaign),
        backup=False,
        store=(MAP_NAME,),
    )
    final_check = war3mpq.MPQArchive(str(output_campaign))
    try:
        if final_check.read_file(MAP_NAME) != patched_map:
            raise RuntimeError("patched campaign map read-back mismatch")
    finally:
        final_check.close()

    print("campaign", output_campaign)
    print("map", output_map)
    print("lua", output_lua)
    print("lua_bytes", len(lua), "->", len(updated))
    print("map_sha256", hashlib.sha256(patched_map).hexdigest().upper())
    print("map_sha1", hashlib.sha1(patched_map).hexdigest().upper())
    print("map_crc32", f"{zlib.crc32(patched_map) & 0xffffffff:08X}")


if __name__ == "__main__":
    main()
