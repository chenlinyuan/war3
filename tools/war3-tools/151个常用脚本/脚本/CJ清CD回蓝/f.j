function ljqcd takes nothing returns nothing
if(IsUnitAlly(GetTriggerUnit(),Player(0))==true)then
call UnitResetCooldown(GetTriggerUnit())
call SetUnitState(GetTriggerUnit(),UNIT_STATE_MANA,GetUnitState(GetTriggerUnit(),UNIT_STATE_MAX_MANA))
endif
endfunction
function ljzc takes nothing returns nothing
local trigger t=CreateTrigger()
local integer i=0
loop
call TriggerRegisterPlayerUnitEvent(t,Player(i),EVENT_PLAYER_UNIT_SPELL_ENDCAST,null)
call TriggerRegisterPlayerUnitEvent(t,Player(i),EVENT_PLAYER_UNIT_SPELL_FINISH,null)
exitwhen i==15
set i=i+1
endloop
call TriggerAddCondition(t,Condition(function ljqcd))
set t=null
endfunction
