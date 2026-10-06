function k_C takes nothing returns boolean
return GetPlayerController(GetOwningPlayer(GetTriggerUnit()))==MAP_CONTROL_USER and GetPlayerSlotState(GetOwningPlayer(GetTriggerUnit()))==PLAYER_SLOT_STATE_PLAYING and IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)
endfunction
function k_A takes nothing returns nothing
local boolean hl=false
call TriggerSleepAction(0.1)
call UnitResetCooldown(GetTriggerUnit())
if hl then
call SetUnitState(GetTriggerUnit(),UNIT_STATE_MANA,GetUnitState(GetTriggerUnit(),UNIT_STATE_MAX_MANA))
endif
endfunction
function k_qcd takes nothing returns nothing
local integer i=0
local trigger t=CreateTrigger()
loop
exitwhen i>11
call TriggerRegisterPlayerUnitEvent(t,Player(i),ConvertPlayerUnitEvent(274),null)
set i=i+1
endloop
call TriggerAddCondition(t,Condition(function k_C ))
call TriggerAddAction(t,function k_A )
endfunction
