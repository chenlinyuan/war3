local function array(default)
  return setmetatable({}, { __index = function() return default end })
end

function __jarray(default)
  return array(default)
end

local destroyed = 0
local returnIcons = 0
local questRefreshes = 0

gg_rct_STExplosivesRegion01 = 1
gg_rct_STExplosivesRegion02 = 2
gg_rct_STExplosivesRegion03 = 3
gg_rct_CaveDebrisRegion01 = 4
gg_rct_CaveDebrisRegion02 = 5
gg_rct_CaveDebrisRegion03 = 6
gg_rct_SapperTunnelsExit = 7

udg_MI_ClosingBreach_Entrance01 = 11
udg_MI_ClosingBreach_Entrance02 = 12
udg_MI_ClosingBreach_Entrance03 = 13
udg_MI_ClosingBreach_Cave01 = 14
udg_MI_ClosingBreach_Return01 = nil
udg_MI_ClosingBreach_Return02 = nil
udg_TTM_ClosingBreach_Return = nil
udg_Actors_Architect = 21
udg_TempLoc = array(nil)
udg_TempGroup = array(nil)
udg_PlayerUser = 0
udg_PlayerUnits = {22, 23, 24}
udg_QM_HashTable = {}
udg_QJ_Quests = { [4] = {} }
udg_QJ_ReqNumberedCurrent_01 = array(0)
udg_QJ_ReqCompleted_01 = array(false)
udg_QJ_ReqCompleted_02 = array(false)
udg_QM_Index = 0

gg_trg_Transmissions_Dialogue_43_One_Breach_Down = {}
gg_trg_Sapper_Tunnels_Blow_Entrance_01 = {}
gg_trg_Sapper_Tunnels_Blow_Entrance_02 = {}
gg_trg_Sapper_Tunnels_Blow_Entrance_03 = {}

function RectContainsUnit(rect, unit)
  return rect == unit
end

function SetDoodadAnimationRectBJ()
end

function SetMinimapIconVisible(icon, visible)
  assert(type(visible) == "boolean")
end

function DestroyMinimapIcon(icon)
  assert(icon ~= nil)
  destroyed = destroyed + 1
end

function QueuedTriggerAddBJ()
end

function GetUnitLoc()
  return {}
end

function CampaignMinimapIconLocBJ()
end

function GetLastCreatedMinimapIcon()
  return { kind = "return-icon" }
end

function AddSpecialEffectTargetUnitBJ()
end

function GetLastCreatedEffectBJ()
  return {}
end

function RemoveLocation()
end

function GetRectCenter()
  return {}
end

function PingMinimapLocForForce()
end

function QM_RunQuestMessageAndCompletionHandler()
  questRefreshes = questRefreshes + 1
end

function IsTriggerEnabled(trigger)
  return true
end

function AddSpecialEffectLocBJ()
end

function BlzSetSpecialEffectScale()
end

function DestroyEffectBJ()
end

function GetUnitsInRangeOfLocMatching()
  return {}
end

function Condition(callback)
  return callback
end

function Trig_Sapper_Tunnels_Explosive_Barrels_Func006002003()
  return false
end

function ForGroupBJ()
end

function Trig_Sapper_Tunnels_Explosive_Barrels_Func007A()
end

function DestroyGroup()
end

function CameraSetEQNoiseForPlayer()
end

function TriggerSleepAction()
end

function CameraClearNoiseForPlayer()
end

dofile("tools/recover/forsaken_sapper_tunnel_fix.lua")

assert(ALAS_ST_TunnelDoneCount() == 0)
ALAS_ST_TunnelCompleteSite(1)
assert(udg_QJ_ReqNumberedCurrent_01[4] == 1)
assert(udg_QJ_ReqCompleted_01[4] == false)
assert(destroyed == 1)
ALAS_ST_TunnelCompleteSite(1)
assert(ALAS_ST_TunnelDoneCount() == 1)
assert(destroyed == 1)

ALAS_ST_TunnelCompleteSite(2)
assert(udg_QJ_ReqNumberedCurrent_01[4] == 2)
assert(udg_QJ_ReqCompleted_01[4] == false)
assert(destroyed == 2)

ALAS_ST_TunnelCompleteSite(3)
assert(udg_QJ_ReqNumberedCurrent_01[4] == 3)
assert(udg_QJ_ReqCompleted_01[4] == true)
assert(udg_QJ_ReqCompleted_02[4] == true)
assert(destroyed == 3)
assert(udg_MI_ClosingBreach_Return01 ~= nil)
assert(udg_MI_ClosingBreach_Return02 ~= nil)
assert(questRefreshes >= 3)

ALAS_ST_TunnelCompleteSite(3)
assert(destroyed == 3)
print("sapper tunnel state-machine test OK")
