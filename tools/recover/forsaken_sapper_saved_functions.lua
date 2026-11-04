function Trig_Sapper_Tunnels_Blow_Entrance_01_Actions()
  local barrel
  local barrelId
  local count
  DisableTrigger(GetTriggeringTrigger())
  SetItemCharges(udg_ST_Explosives_Item, GetItemCharges(udg_ST_Explosives_Item) - 1)
  if GetItemCharges(udg_ST_Explosives_Item) == 0 then
    RemoveItem(udg_ST_Explosives_Item)
  end
  udg_TempLoc[1] = GetRectCenter(gg_rct_STExplosivesRegion01)
  CreateNUnitsAtLoc(1, FourCC("h00G"), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempLoc[1], bj_UNIT_FACING)
  barrel = GetLastCreatedUnit()
  if barrel ~= nil then
    barrelId = GetHandleId(barrel)
  end
  SetDoodadAnimationBJ("hide", FourCC("DFcP"), 500.0, udg_TempLoc[1])
  RemoveLocation(udg_TempLoc[1])
  count = 0
  if IsTriggerEnabled(gg_trg_Sapper_Tunnels_Blow_Entrance_01) == false then
    count = count + 1
  end
  if IsTriggerEnabled(gg_trg_Sapper_Tunnels_Blow_Entrance_02) == false then
    count = count + 1
  end
  if IsTriggerEnabled(gg_trg_Sapper_Tunnels_Blow_Entrance_03) == false then
    count = count + 1
  end
  udg_QJ_ReqNumberedCurrent_01[4] = count
  udg_QJ_ReqCompleted_01[4] = (count >= 3)
  if count >= 3 then
    udg_QJ_ReqCompleted_02[4] = true
  end
  if udg_MI_ClosingBreach_Entrance01 ~= nil then
    SetMinimapIconVisible(udg_MI_ClosingBreach_Entrance01, false)
    DestroyMinimapIcon(udg_MI_ClosingBreach_Entrance01)
  end
  if count == 1 then
    TriggerExecute(gg_trg_Transmissions_Dialogue_43_One_Breach_Down)
  elseif count >= 3 then
    TriggerExecute(gg_trg_Minimap_Icon_and_TTM_Hide_Cave_Entrance_UC)
    TriggerExecute(gg_trg_Minimap_Icon_and_TTM_Create_Closing_the_Breach_Turn_In_01)
    TriggerExecute(gg_trg_Minimap_Icon_and_TTM_Create_Closing_the_Breach_Turn_In_02)
  end
  udg_QM_Index = 4
  if QM_RunQuestMessageAndCompletionHandler ~= nil then
    QM_RunQuestMessageAndCompletionHandler()
  end
  TriggerSleepAction(1.5)
  if barrel ~= nil and GetHandleId(barrel) == barrelId and IsUnitAliveBJ(barrel) then
    KillUnit(barrel)
  end
  udg_TempLoc[1] = GetRectCenter(gg_rct_STExplosivesRegion01)
  AddSpecialEffectLocBJ(udg_TempLoc[1], "Objects\\Spawnmodels\\Human\\FragmentationShards\\FragBoomSpawn.mdl")
  BlzSetSpecialEffectScale(GetLastCreatedEffectBJ(), 3.0)
  DestroyEffectBJ(GetLastCreatedEffectBJ())
  udg_TempGroup[1] = GetUnitsInRangeOfLocMatching(300.0, udg_TempLoc[1], Condition(Trig_Sapper_Tunnels_Explosive_Barrels_Func006002003))
  ForGroupBJ(udg_TempGroup[1], Trig_Sapper_Tunnels_Explosive_Barrels_Func007A)
  DestroyGroup(udg_TempGroup[1])
  RemoveLocation(udg_TempLoc[1])
  CameraSetEQNoiseForPlayer(udg_PlayerUser, 15.0)
  TriggerSleepAction(0.3)
  CameraClearNoiseForPlayer(udg_PlayerUser)
end

function Trig_Sapper_Tunnels_Blow_Entrance_02_Actions()
  local barrel
  local barrelId
  local count
  DisableTrigger(GetTriggeringTrigger())
  SetItemCharges(udg_ST_Explosives_Item, GetItemCharges(udg_ST_Explosives_Item) - 1)
  if GetItemCharges(udg_ST_Explosives_Item) == 0 then
    RemoveItem(udg_ST_Explosives_Item)
  end
  udg_TempLoc[1] = GetRectCenter(gg_rct_STExplosivesRegion02)
  CreateNUnitsAtLoc(1, FourCC("h00G"), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempLoc[1], bj_UNIT_FACING)
  barrel = GetLastCreatedUnit()
  if barrel ~= nil then
    barrelId = GetHandleId(barrel)
  end
  SetDoodadAnimationBJ("hide", FourCC("DFcP"), 500.0, udg_TempLoc[1])
  RemoveLocation(udg_TempLoc[1])
  count = 0
  if IsTriggerEnabled(gg_trg_Sapper_Tunnels_Blow_Entrance_01) == false then
    count = count + 1
  end
  if IsTriggerEnabled(gg_trg_Sapper_Tunnels_Blow_Entrance_02) == false then
    count = count + 1
  end
  if IsTriggerEnabled(gg_trg_Sapper_Tunnels_Blow_Entrance_03) == false then
    count = count + 1
  end
  udg_QJ_ReqNumberedCurrent_01[4] = count
  udg_QJ_ReqCompleted_01[4] = (count >= 3)
  if count >= 3 then
    udg_QJ_ReqCompleted_02[4] = true
  end
  if udg_MI_ClosingBreach_Entrance02 ~= nil then
    SetMinimapIconVisible(udg_MI_ClosingBreach_Entrance02, false)
    DestroyMinimapIcon(udg_MI_ClosingBreach_Entrance02)
  end
  if count == 1 then
    TriggerExecute(gg_trg_Transmissions_Dialogue_43_One_Breach_Down)
  elseif count >= 3 then
    TriggerExecute(gg_trg_Minimap_Icon_and_TTM_Hide_Cave_Entrance_UC)
    TriggerExecute(gg_trg_Minimap_Icon_and_TTM_Create_Closing_the_Breach_Turn_In_01)
    TriggerExecute(gg_trg_Minimap_Icon_and_TTM_Create_Closing_the_Breach_Turn_In_02)
  end
  udg_QM_Index = 4
  if QM_RunQuestMessageAndCompletionHandler ~= nil then
    QM_RunQuestMessageAndCompletionHandler()
  end
  TriggerSleepAction(1.5)
  if barrel ~= nil and GetHandleId(barrel) == barrelId and IsUnitAliveBJ(barrel) then
    KillUnit(barrel)
  end
  udg_TempLoc[1] = GetRectCenter(gg_rct_STExplosivesRegion02)
  AddSpecialEffectLocBJ(udg_TempLoc[1], "Objects\\Spawnmodels\\Human\\FragmentationShards\\FragBoomSpawn.mdl")
  BlzSetSpecialEffectScale(GetLastCreatedEffectBJ(), 3.0)
  DestroyEffectBJ(GetLastCreatedEffectBJ())
  udg_TempGroup[1] = GetUnitsInRangeOfLocMatching(300.0, udg_TempLoc[1], Condition(Trig_Sapper_Tunnels_Explosive_Barrels_Func006002003))
  ForGroupBJ(udg_TempGroup[1], Trig_Sapper_Tunnels_Explosive_Barrels_Func007A)
  DestroyGroup(udg_TempGroup[1])
  RemoveLocation(udg_TempLoc[1])
  CameraSetEQNoiseForPlayer(udg_PlayerUser, 15.0)
  TriggerSleepAction(0.3)
  CameraClearNoiseForPlayer(udg_PlayerUser)
end

function Trig_Sapper_Tunnels_Blow_Entrance_03_Actions()
  local barrel
  local barrelId
  local count
  DisableTrigger(GetTriggeringTrigger())
  SetItemCharges(udg_ST_Explosives_Item, GetItemCharges(udg_ST_Explosives_Item) - 1)
  if GetItemCharges(udg_ST_Explosives_Item) == 0 then
    RemoveItem(udg_ST_Explosives_Item)
  end
  udg_TempLoc[1] = GetRectCenter(gg_rct_STExplosivesRegion03)
  CreateNUnitsAtLoc(1, FourCC("h00G"), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempLoc[1], bj_UNIT_FACING)
  barrel = GetLastCreatedUnit()
  if barrel ~= nil then
    barrelId = GetHandleId(barrel)
  end
  SetDoodadAnimationBJ("hide", FourCC("DFcP"), 500.0, udg_TempLoc[1])
  RemoveLocation(udg_TempLoc[1])
  count = 0
  if IsTriggerEnabled(gg_trg_Sapper_Tunnels_Blow_Entrance_01) == false then
    count = count + 1
  end
  if IsTriggerEnabled(gg_trg_Sapper_Tunnels_Blow_Entrance_02) == false then
    count = count + 1
  end
  if IsTriggerEnabled(gg_trg_Sapper_Tunnels_Blow_Entrance_03) == false then
    count = count + 1
  end
  udg_QJ_ReqNumberedCurrent_01[4] = count
  udg_QJ_ReqCompleted_01[4] = (count >= 3)
  if count >= 3 then
    udg_QJ_ReqCompleted_02[4] = true
  end
  if udg_MI_ClosingBreach_Entrance03 ~= nil then
    SetMinimapIconVisible(udg_MI_ClosingBreach_Entrance03, false)
    DestroyMinimapIcon(udg_MI_ClosingBreach_Entrance03)
  end
  if count == 1 then
    TriggerExecute(gg_trg_Transmissions_Dialogue_43_One_Breach_Down)
  elseif count >= 3 then
    TriggerExecute(gg_trg_Minimap_Icon_and_TTM_Hide_Cave_Entrance_UC)
    TriggerExecute(gg_trg_Minimap_Icon_and_TTM_Create_Closing_the_Breach_Turn_In_01)
    TriggerExecute(gg_trg_Minimap_Icon_and_TTM_Create_Closing_the_Breach_Turn_In_02)
  end
  udg_QM_Index = 4
  if QM_RunQuestMessageAndCompletionHandler ~= nil then
    QM_RunQuestMessageAndCompletionHandler()
  end
  TriggerSleepAction(1.5)
  if barrel ~= nil and GetHandleId(barrel) == barrelId and IsUnitAliveBJ(barrel) then
    KillUnit(barrel)
  end
  udg_TempLoc[1] = GetRectCenter(gg_rct_STExplosivesRegion03)
  AddSpecialEffectLocBJ(udg_TempLoc[1], "Objects\\Spawnmodels\\Human\\FragmentationShards\\FragBoomSpawn.mdl")
  BlzSetSpecialEffectScale(GetLastCreatedEffectBJ(), 3.0)
  DestroyEffectBJ(GetLastCreatedEffectBJ())
  udg_TempGroup[1] = GetUnitsInRangeOfLocMatching(300.0, udg_TempLoc[1], Condition(Trig_Sapper_Tunnels_Explosive_Barrels_Func006002003))
  ForGroupBJ(udg_TempGroup[1], Trig_Sapper_Tunnels_Explosive_Barrels_Func007A)
  DestroyGroup(udg_TempGroup[1])
  RemoveLocation(udg_TempLoc[1])
  CameraSetEQNoiseForPlayer(udg_PlayerUser, 15.0)
  TriggerSleepAction(0.3)
  CameraClearNoiseForPlayer(udg_PlayerUser)
end

function Trig_Sapper_Tunnels_Explosive_Barrels_Conditions()
  return false
end
