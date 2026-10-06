function fy_qcdc takes nothing returns boolean
if(GetPlayerController(GetTriggerPlayer())==ConvertMapControl(0))then
return true
endif
return false	
endfunction
function fy_sjd takes nothing returns nothing
local timer t=GetExpiredTimer()
local unit u=LoadUnitHandle(fy_ht,1,1)
local real m=LoadReal(fy_ht,1,2)
call UnitResetCooldown(u)
call SetUnitState(u,ConvertUnitState(2),m)
call FlushChildHashtable(fy_ht,1)
call DestroyTimer(t)
set t=null
set u=null
endfunction
function fy_qcd takes nothing returns nothing
local timer t=CreateTimer()
local unit u=GetTriggerUnit()
local real m=GetUnitState(GetTriggerUnit(),ConvertUnitState(3))
call SaveUnitHandle(fy_ht,1,1,u)
call SaveReal(fy_ht,1,2,m)
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