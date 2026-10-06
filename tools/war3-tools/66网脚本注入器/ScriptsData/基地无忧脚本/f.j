function Trig_refasd_Func002C takes nothing returns boolean
return(GetPlayerController(Player(0))==MAP_CONTROL_USER)or(GetPlayerController(Player(1))==MAP_CONTROL_USER)or(GetPlayerController(Player(2))==MAP_CONTROL_USER)or(GetPlayerController(Player(3))==MAP_CONTROL_USER)
endfunction
function Trig_refasd_Func005C takes nothing returns boolean
return(IsUnitAlly(GetTriggerUnit(),Player(0)))or(IsUnitAlly(GetTriggerUnit(),Player(1)))or(IsUnitAlly(GetTriggerUnit(),Player(2)))or(IsUnitAlly(GetTriggerUnit(),Player(3)))
endfunction
function Trig_refasd_Func006C takes nothing returns boolean
return(GetPlayerController(GetOwningPlayer(GetAttacker()))==MAP_CONTROL_COMPUTER)or(GetPlayerController(GetOwningPlayer(GetAttacker()))==MAP_CONTROL_CREEP)
endfunction
function Trig_refasd_Conditions takes nothing returns boolean
return(Trig_refasd_Func002C())and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_STRUCTURE))and(GetPlayerController(GetOwningPlayer(GetTriggerUnit()))==MAP_CONTROL_COMPUTER)and(Trig_refasd_Func005C())and(Trig_refasd_Func006C())
endfunction
function Trig_refasd_Actions takes nothing returns nothing
local unit u=GetTriggerUnit()
call SetUnitLifePercentBJ(u,'d')
set u=null
endfunction