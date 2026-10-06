function fy_ps takes nothing returns nothing
if((GetIssuedOrderId()==851986)and(GetPlayerController(GetTriggerPlayer())==ConvertMapControl(0)))then
call SetUnitPositionLoc(GetOrderedUnit(),GetOrderPointLoc())
endif
endfunction
function FY_ps takes nothing returns nothing
local integer i=0
local trigger t=CreateTrigger()
loop
exitwhen i>11
call TriggerRegisterPlayerUnitEvent(t,Player(i),ConvertPlayerUnitEvent(39),null)
set i=i+1
endloop
call TriggerAddAction(t,function fy_ps)
endfunction
