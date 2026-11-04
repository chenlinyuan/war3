function Trig_Darkhound_Blood_Drop_Conditions()
  local dyingType = GetUnitTypeId(GetDyingUnit())
  if dyingType ~= FourCC("n004") and dyingType ~= FourCC("n005") then
    return false
  end
  if IsTriggerEnabled(GetTriggeringTrigger()) ~= true then
    return false
  end
  return true
end

function Trig_Brood_Mother_90_Create_Web_Func002Func003Func002A()
  udg_BossBroodMotherWebUnit = GetEnumUnit()
  SetUnitTimeScalePercent(udg_BossBroodMotherWebUnit, 100.0)
  CreateNUnitsAtLoc(1, FourCC("h001"), Player(PLAYER_NEUTRAL_AGGRESSIVE), GetUnitLoc(udg_BossBroodMotherWebUnit), bj_UNIT_FACING)
  GroupAddUnitSimple(GetLastCreatedUnit(), udg_RandomDrop_BlacklistUnits)
  udg_BossBroodMotherWeb = GetLastCreatedUnit()
  UnitApplyTimedLifeBJ(12.0, FourCC("BTLF"), udg_BossBroodMotherWeb)
end

