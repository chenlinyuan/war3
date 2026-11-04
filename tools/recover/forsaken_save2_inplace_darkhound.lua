function Trig_Darkhound_Blood_Drop_Conditions()
  if IsTriggerEnabled(GetTriggeringTrigger()) ~= true then
    return false
  end
  return true
end
