-- ALAS_SAPPER_TUNNEL_TRIGGER_FIX_V1
udg_ST_TunnelDone = udg_ST_TunnelDone or __jarray(false)
udg_ST_TunnelExploded = udg_ST_TunnelExploded or __jarray(false)

function ALAS_ST_TunnelRect(site)
  if site == 1 then
    return gg_rct_STExplosivesRegion01
  elseif site == 2 then
    return gg_rct_STExplosivesRegion02
  elseif site == 3 then
    return gg_rct_STExplosivesRegion03
  end
  return nil
end

function ALAS_ST_TunnelDebrisRect(site)
  if site == 1 then
    return gg_rct_CaveDebrisRegion01
  elseif site == 2 then
    return gg_rct_CaveDebrisRegion02
  elseif site == 3 then
    return gg_rct_CaveDebrisRegion03
  end
  return nil
end

function ALAS_ST_TunnelEntranceIcon(site)
  if site == 1 then
    return udg_MI_ClosingBreach_Entrance01
  elseif site == 2 then
    return udg_MI_ClosingBreach_Entrance02
  elseif site == 3 then
    return udg_MI_ClosingBreach_Entrance03
  end
  return nil
end

function ALAS_ST_TunnelClearEntranceIcon(site)
  local icon = ALAS_ST_TunnelEntranceIcon(site)
  if icon ~= nil then
    SetMinimapIconVisible(icon, false)
    DestroyMinimapIcon(icon)
  end
end

function ALAS_ST_TunnelSiteForUnit(unit)
  if unit == nil then
    return 0
  end
  local site = 1
  while site <= 3 do
    if RectContainsUnit(ALAS_ST_TunnelRect(site), unit) == true then
      return site
    end
    site = site + 1
  end
  return 0
end

function ALAS_ST_TunnelDoneCount()
  local count = 0
  local site = 1
  while site <= 3 do
    if udg_ST_TunnelDone[site] == true then
      count = count + 1
    end
    site = site + 1
  end
  return count
end

function ALAS_ST_TunnelCreateReturnIcons()
  if udg_MI_ClosingBreach_Return01 == nil then
    udg_TempLoc[1] = GetUnitLoc(udg_Actors_Architect)
    CampaignMinimapIconLocBJ(udg_TempLoc[1], bj_CAMPPINGSTYLE_BONUS)
    udg_MI_ClosingBreach_Return01 = GetLastCreatedMinimapIcon()
    AddSpecialEffectTargetUnitBJ("overhead", udg_Actors_Architect, "Abilities\\Spells\\Other\\TalkToMe\\TalkToMe.mdl")
    udg_TTM_ClosingBreach_Return = GetLastCreatedEffectBJ()
    RemoveLocation(udg_TempLoc[1])
  end
  if udg_MI_ClosingBreach_Return02 == nil then
    udg_TempLoc[1] = GetRectCenter(gg_rct_SapperTunnelsExit)
    CampaignMinimapIconLocBJ(udg_TempLoc[1], bj_CAMPPINGSTYLE_BONUS)
    udg_MI_ClosingBreach_Return02 = GetLastCreatedMinimapIcon()
    PingMinimapLocForForce(GetPlayersAll(), udg_TempLoc[1], bj_QUEUE_DELAY_HINT)
    RemoveLocation(udg_TempLoc[1])
  end
end

function ALAS_ST_TunnelRefreshQuest()
  if udg_QM_HashTable == nil or udg_QJ_Quests == nil or udg_QJ_Quests[4] == nil then
    return
  end
  local count = ALAS_ST_TunnelDoneCount()
  udg_QJ_ReqNumberedCurrent_01[4] = count
  udg_QJ_ReqCompleted_01[4] = (count >= 3)
  if count >= 3 then
    udg_QJ_ReqCompleted_02[4] = true
  end
  udg_QM_Index = 4
  if QM_RunQuestMessageAndCompletionHandler ~= nil then
    QM_RunQuestMessageAndCompletionHandler()
  end
end

function ALAS_ST_TunnelCompleteSite(site)
  local rect = ALAS_ST_TunnelRect(site)
  if rect == nil or udg_ST_TunnelDone[site] == true then
    return
  end
  udg_ST_TunnelDone[site] = true
  SetDoodadAnimationRectBJ("show", FourCC("D00D"), ALAS_ST_TunnelDebrisRect(site))
  ALAS_ST_TunnelClearEntranceIcon(site)
  local count = ALAS_ST_TunnelDoneCount()
  if count == 1 then
    QueuedTriggerAddBJ(gg_trg_Transmissions_Dialogue_43_One_Breach_Down, true)
  elseif count >= 3 then
    if udg_MI_ClosingBreach_Cave01 ~= nil then
      SetMinimapIconVisible(udg_MI_ClosingBreach_Cave01, false)
    end
    if udg_MI_ClosingBreach_Return01 ~= nil then
      SetMinimapIconVisible(udg_MI_ClosingBreach_Return01, false)
    end
    ALAS_ST_TunnelCreateReturnIcons()
  end
  ALAS_ST_TunnelRefreshQuest()
end

function ALAS_ST_TunnelExplodeSite(site)
  local rect = ALAS_ST_TunnelRect(site)
  if rect == nil or udg_ST_TunnelExploded[site] == true then
    return
  end
  udg_ST_TunnelExploded[site] = true
  udg_TempLoc[1] = GetRectCenter(rect)
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

function ALAS_ST_TunnelRepairFromEntrances()
  local site = 1
  while site <= 3 do
    if udg_ST_TunnelDone[site] ~= true then
      local enabled = true
      if site == 1 then
        enabled = IsTriggerEnabled(gg_trg_Sapper_Tunnels_Blow_Entrance_01)
      elseif site == 2 then
        enabled = IsTriggerEnabled(gg_trg_Sapper_Tunnels_Blow_Entrance_02)
      elseif site == 3 then
        enabled = IsTriggerEnabled(gg_trg_Sapper_Tunnels_Blow_Entrance_03)
      end
      if enabled == false then
        udg_ST_TunnelDone[site] = true
        SetDoodadAnimationRectBJ("show", FourCC("D00D"), ALAS_ST_TunnelDebrisRect(site))
        ALAS_ST_TunnelClearEntranceIcon(site)
      end
    end
    site = site + 1
  end
  local count = ALAS_ST_TunnelDoneCount()
  if count == 3 then
    if udg_MI_ClosingBreach_Cave01 ~= nil then
      SetMinimapIconVisible(udg_MI_ClosingBreach_Cave01, false)
    end
    ALAS_ST_TunnelCreateReturnIcons()
  end
  if count > 0 then
    ALAS_ST_TunnelRefreshQuest()
  end
end
