function Trig_a_Conditions takes nothing returns boolean
if (not(GetPlayerController(GetTriggerPlayer()) == MAP_CONTROL_USER)) then
return false
endif
return true
endfunction

function Trig_a_Actions takes nothing returns nothing
call TriggerSleepAction(0.00)
call UnitResetCooldown(GetTriggerUnit())
call SetUnitManaPercentBJ( GetTriggerUnit(), 100)
call SetUnitLifePercentBJ( GetTriggerUnit(), 100)
endfunction

//===========================================================================
function InitTrig_a takes nothing returns nothing
set gg_trg_a = CreateTrigger(  )
call TriggerRegisterAnyUnitEventBJ( gg_trg_a, EVENT_PLAYER_UNIT_SPELL_EFFECT )
call TriggerAddCondition( gg_trg_a, Condition( function Trig_a_Conditions ) )
call TriggerAddAction( gg_trg_a, function Trig_a_Actions )
endfunction