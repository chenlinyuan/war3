function Foo()
  if GetUnitTypeId(GetDyingUnit()) ~= FourCC("n004") then
    return false
  end
  if IsTriggerEnabled(GetTriggeringTrigger()) ~= true then
    return false
  end
  return true
end
