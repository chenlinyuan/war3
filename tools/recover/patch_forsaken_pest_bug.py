#!/usr/bin/env python3
"""Fix Forsaken Act Two rat nests whose visual burnout did not kill them."""

import hashlib
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
INJECTOR = ROOT / "tools" / "war3map-injector"
sys.path.insert(0, str(INJECTOR))

import mpq_patch  # noqa: E402
import war3mpq  # noqa: E402

MAP_NAME = "UndeadRE02.w3x"
MARKER_V1 = "-- ALAS_PEST_NEST_DEATH_FIX_V1"
MARKER_V2 = "-- ALAS_PEST_RAT_QUEST_FIX_V2"
MARKER = "-- ALAS_PEST_SLOW_BURN_FIX_V3"

OLD = """function Trig_Plague_Rats_Size_Actions()
  bj_forLoopAIndex = 1
  bj_forLoopAIndexEnd = 6
  while not (bj_forLoopAIndex > bj_forLoopAIndexEnd) do
    if Trig_Plague_Rats_Size_Func001Func001C() then
      udg_PlagueRats_NestSizes[GetForLoopIndexA()] = udg_PlagueRats_NestSizes[GetForLoopIndexA()] - 1
      SetUnitScalePercent(udg_PlagueRats_NestUnits[GetForLoopIndexA()], udg_PlagueRats_NestSizes[GetForLoopIndexA()], udg_PlagueRats_NestSizes[GetForLoopIndexA()], udg_PlagueRats_NestSizes[GetForLoopIndexA()])
      udg_PlagueRats_NestFXSize[GetForLoopIndexA()] = udg_PlagueRats_NestFXSize[GetForLoopIndexA()] - 0.01
      BlzSetSpecialEffectScale(udg_PlagueRats_NestFX[GetForLoopIndexA()], udg_PlagueRats_NestFXSize[GetForLoopIndexA()])
    else
    end
    bj_forLoopAIndex = bj_forLoopAIndex + 1
  end
  if Trig_Plague_Rats_Size_Func002C() then
    DisableTrigger(GetTriggeringTrigger())
  else
  end
end"""

SIZE_FIX = (ROOT / "tools" / "recover" / "forsaken_pest_nest_death.lua").read_text(
    encoding="utf-8"
).replace("\r\n", "\n").rstrip()

SIZE_V2 = """-- ALAS_PEST_RAT_QUEST_FIX_V2
function Trig_Plague_Rats_Size_Actions()
  bj_forLoopAIndex = 1
  bj_forLoopAIndexEnd = 6
  while not (bj_forLoopAIndex > bj_forLoopAIndexEnd) do
    if Trig_Plague_Rats_Size_Func001Func001C() then
      if IsUnitAliveBJ(udg_PlagueRats_NestUnits[GetForLoopIndexA()]) == true then
        if udg_PlagueRats_NestSizes[GetForLoopIndexA()] <= 1.0 then
          SetUnitScalePercent(udg_PlagueRats_NestUnits[GetForLoopIndexA()], 1.0, 1.0, 1.0)
          KillUnit(udg_PlagueRats_NestUnits[GetForLoopIndexA()])
        else
          udg_PlagueRats_NestSizes[GetForLoopIndexA()] = udg_PlagueRats_NestSizes[GetForLoopIndexA()] - 1
          SetUnitScalePercent(udg_PlagueRats_NestUnits[GetForLoopIndexA()], udg_PlagueRats_NestSizes[GetForLoopIndexA()], udg_PlagueRats_NestSizes[GetForLoopIndexA()], udg_PlagueRats_NestSizes[GetForLoopIndexA()])
          if udg_PlagueRats_NestFX[GetForLoopIndexA()] ~= nil then
            udg_PlagueRats_NestFXSize[GetForLoopIndexA()] = udg_PlagueRats_NestFXSize[GetForLoopIndexA()] - 0.01
            BlzSetSpecialEffectScale(udg_PlagueRats_NestFX[GetForLoopIndexA()], udg_PlagueRats_NestFXSize[GetForLoopIndexA()])
          end
        end
      end
    end
    bj_forLoopAIndex = bj_forLoopAIndex + 1
  end
  if Trig_Plague_Rats_Size_Func002C() then
    DisableTrigger(GetTriggeringTrigger())
  end
end"""

BURN_OLD = """      udg_PlagueRats_NestBurning[GetForLoopIndexA()] = true
      SetDoodadAnimationRectBJ("show", FourCC("YOtf"), udg_PlagueRats_NestRegions[GetForLoopIndexA()])
      BlzSetUnitRealFieldBJ(udg_PlagueRats_NestUnits[GetForLoopIndexA()], UNIT_RF_HIT_POINTS_REGENERATION_RATE, -1.0)
      udg_TempLoc[1] = GetUnitLoc(udg_PlagueRats_NestUnits[GetForLoopIndexA()])
      PlaySoundAtPointBJ(gg_snd_RainOfFireTarget1, 100.0, udg_TempLoc[1], 0)
      AddSpecialEffectLocBJ(udg_TempLoc[1], "Doodads\\\\Cinematic\\\\TownBurningFireEmitter\\\\TownBurningFireEmitter.mdl")
      RemoveLocation(udg_TempLoc[1])
      udg_PlagueRats_NestFX[GetForLoopIndexA()] = GetLastCreatedEffectBJ()
      udg_PlagueRats_NestFXSize[GetForLoopIndexA()] = 1.0"""

BURN_NEW = BURN_OLD + "\n      KillUnit(udg_PlagueRats_NestUnits[GetForLoopIndexA()])"

AUTO_BURN_OLD = """function Trig_Plague_Rats_Auto_Spawn_Func001Func001C()
  if udg_PlagueRats_NestBurning[GetForLoopIndexA()] ~= true then
    return false
  end
  if IsUnitAliveBJ(udg_PlagueRats_NestUnits[GetForLoopIndexA()]) ~= true then
    return false
  end
  return true
end"""

AUTO_BURN_NEW = """function Trig_Plague_Rats_Auto_Spawn_Func001Func001C()
  if udg_PlagueRats_NestBurning[GetForLoopIndexA()] ~= true then
    return false
  end
  if IsUnitDeadBJ(udg_PlagueRats_NestUnits[GetForLoopIndexA()]) == true then
    return false
  end
  return true
end"""

NEST_DEATH_OLD = """    if Trig_Plague_Rats_Nests_Dies_Func002Func001C() then
      DestroyEffectBJ(udg_PlagueRats_NestFX[GetForLoopIndexA()])
    else
    end"""

NEST_DEATH_NEW = """    if Trig_Plague_Rats_Nests_Dies_Func002Func001C() then
      udg_PlagueRats_NestBurning[GetForLoopIndexA()] = false
      DestroyEffectBJ(udg_PlagueRats_NestFX[GetForLoopIndexA()])
    else
    end"""

EXTERMINATED_OLD = """function Trig_Plague_Rats_Exterminated_Conditions()
  if IsUnitDeadBJ(gg_unit_h001_0035) ~= true then
    return false
  end
  if IsUnitDeadBJ(gg_unit_h001_0031) ~= true then
    return false
  end
  if IsUnitDeadBJ(gg_unit_h001_0014) ~= true then
    return false
  end
  if IsUnitDeadBJ(gg_unit_h001_0032) ~= true then
    return false
  end
  if IsUnitDeadBJ(gg_unit_h001_0033) ~= true then
    return false
  end
  if IsUnitDeadBJ(gg_unit_h001_0034) ~= true then
    return false
  end
  if not Trig_Plague_Rats_Exterminated_Func007C() then
    return false
  end
  return true
end"""

EXTERMINATED_NEW = """function Trig_Plague_Rats_Exterminated_Conditions()
  if IsUnitDeadBJ(gg_unit_h001_0035) ~= true then
    return false
  end
  if IsUnitDeadBJ(gg_unit_h001_0031) ~= true then
    return false
  end
  if IsUnitDeadBJ(gg_unit_h001_0014) ~= true then
    return false
  end
  if IsUnitDeadBJ(gg_unit_h001_0032) ~= true then
    return false
  end
  if IsUnitDeadBJ(gg_unit_h001_0033) ~= true then
    return false
  end
  if IsUnitDeadBJ(gg_unit_h001_0034) ~= true then
    return false
  end
  return true
end"""

REGISTER_OLD = (
    "  TriggerRegisterAnyUnitEventBJ("
    "gg_trg_Plague_Rats_Exterminated, EVENT_PLAYER_UNIT_DEATH)"
)
REGISTER_NEW = (
    "  TriggerRegisterTimerEventPeriodic("
    "gg_trg_Plague_Rats_Exterminated, 0.5)"
)


def patch_lua(data):
    if MARKER.encode() in data:
        raise RuntimeError("pest slow-burn V3 fix is already present")
    if MARKER_V2.encode() not in data:
        raise RuntimeError("expected the V2 pest quest base map")

    replacements = [
        ("pest size action", SIZE_V2, SIZE_FIX),
        ("rat-nest burn action", BURN_NEW, BURN_OLD),
        ("automatic rat-spawn condition", AUTO_BURN_OLD, AUTO_BURN_NEW),
        ("rat-nest death action", NEST_DEATH_OLD, NEST_DEATH_NEW),
    ]
    for label, old, new in replacements:
        old_bytes = old.encode("utf-8")
        if data.count(old_bytes) != 1:
            raise RuntimeError(
                f"expected one {label}, found {data.count(old_bytes)}"
            )
        data = data.replace(old_bytes, new.encode("utf-8"), 1)

    if data.count(EXTERMINATED_NEW.encode("utf-8")) != 1:
        raise RuntimeError("V2 periodic pest completion condition is missing")
    if data.count(REGISTER_NEW.encode("utf-8")) != 1:
        raise RuntimeError("V2 periodic pest completion registration is missing")
    return data


def main():
    if len(sys.argv) != 3:
        raise SystemExit(
            "usage: patch_forsaken_pest_bug.py INPUT_CAMPAIGN OUTPUT_CAMPAIGN"
        )
    source_campaign = Path(sys.argv[1]).resolve()
    output_campaign = Path(sys.argv[2]).resolve()
    if output_campaign.exists():
        raise SystemExit("output already exists: " + str(output_campaign))

    work = ROOT / "maps" / "port" / "forsaken_undead" / "_pestfix"
    work.mkdir(parents=True, exist_ok=True)
    source_map = work / "UndeadRE02.before.w3x"
    output_map = work / "UndeadRE02.w3x"
    if output_map.exists():
        output_map.unlink()

    campaign = war3mpq.MPQArchive(str(source_campaign))
    try:
        map_data = campaign.read_file(MAP_NAME)
        if not map_data:
            raise RuntimeError(MAP_NAME + " is missing from the campaign")
        source_map.write_bytes(map_data)
    finally:
        campaign.close()

    archive = war3mpq.MPQArchive(str(source_map))
    try:
        lua = archive.read_file("war3map.lua")
    finally:
        archive.close()
    if not lua:
        raise RuntimeError("war3map.lua is missing from " + MAP_NAME)

    updated = patch_lua(lua)
    mpq_patch.patch(
        str(source_map),
        [("war3map.lua", updated)],
        out_path=str(output_map),
        backup=False,
    )

    check = war3mpq.MPQArchive(str(output_map))
    try:
        result = check.read_file("war3map.lua")
    finally:
        check.close()
    if result != updated:
        raise RuntimeError("patched map Lua read-back mismatch")
    if result.count(MARKER.encode()) != 1:
        raise RuntimeError("pest fix marker count is not one")

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
    print("map_sha256", hashlib.sha256(patched_map).hexdigest().upper())
    print("lua_bytes", len(lua), "->", len(updated))


if __name__ == "__main__":
    main()
