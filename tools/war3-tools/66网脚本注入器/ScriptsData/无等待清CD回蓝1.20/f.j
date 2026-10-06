function FY_U2I takes handle h returns integer
return h
return 0
endfunction
function FY_I2U takes integer i returns unit
return i
return null
endfunction
function fy_qcdc takes nothing returns boolean
if(GetPlayerController(GetTriggerPlayer())==ConvertMapControl(0))then
return true
endif
return false	
endfunction
function fy_sjd takes nothing returns nothing
local timer t=GetExpiredTimer()
local unit u=FY_I2U(GetStoredInteger(fy_gc,"fy","unit"))
local real m=GetStoredReal(fy_gc,"fy","mana")
call UnitResetCooldown(u)
call SetUnitState(u,ConvertUnitState(2),m)
call FlushStoredMission(fy_gc,"fy")
call DestroyTimer(t)
set t=null
set u=null
endfunction
function fy_qcd takes nothing returns nothing
local timer t=CreateTimer()
local unit u=GetTriggerUnit()
local real m=GetUnitState(GetTriggerUnit(),ConvertUnitState(3))
call StoreInteger(fy_gc,"fy","unit",FY_U2I(u))
call StoreReal(fy_gc,"fy","mana",m)
call TimerStart(t,0,false,function fy_sjd)
set t=null
set u=null
endfunction
function FY_qcd takes nothing returns nothing
local integer i=0
local trigger t=CreateTrigger()
loop
exitwhen i>11
call TriggerRegisterPlayerUnitEvent(t,Player(i),ConvertPlayerUnitEvent(274),null)
set i=i+1
endloop
call TriggerAddCondition(t,Condition(function fy_qcdc))
call TriggerAddAction(t,function fy_qcd)	
endfunction