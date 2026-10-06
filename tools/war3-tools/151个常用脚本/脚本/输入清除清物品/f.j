function fy1 takes nothing returns nothing
call RemoveItem(GetEnumItem())
endfunction
function Fy1 takes nothing returns nothing
call EnumItemsInRect(GetWorldBounds(),null,function fy1)
endfunction
function FY1 takes nothing returns nothing
local integer i=0
local trigger t=CreateTrigger()
loop
exitwhen i>11
call TriggerRegisterPlayerChatEvent(t,Player(i),"清除",true)
set i=i+1
endloop
call TriggerAddAction(t,function Fy1)
endfunction
