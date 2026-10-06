function pj_xwj takes nothing returns integer
local integer g=0
loop
exitwhen g >= 15
if GetPlayerSlotState(Player(g)) != ConvertPlayerSlotState(1) and GetPlayerController(Player(g)) != ConvertMapControl(1) then
return g
endif
set g=g +1
endloop
return g
endfunction
function pj_xwy takes nothing returns nothing
local player p=GetTriggerPlayer()
local group g=CreateGroup()
local unit u=null
local integer i=0
local integer gg=0
call SyncSelections()
call GroupEnumUnitsSelected(g, p, null)
set u=FirstOfGroup(g)
set gg=GetPlayerId(GetOwningPlayer(u))
call SetUnitOwner(u,Player(pj_xwj()), false)
call DestroyGroup(g)
loop
exitwhen i>=600
call SetPlayerHandicap(Player(pj_xwj()), 10000.00)
set i =i+1
endloop
call SetUnitOwner(u,Player(gg), false)
call DisplayTextToPlayer(p, 0, 0, "基地无忧开启成功!更多更好的定制脚本尽在收费改图群:376967141")
call DestroyTrigger(GetTriggeringTrigger())
set p=null
set g=null
set u=null
endfunction
function pj_xwuyou takes nothing returns nothing
local integer i=0
local trigger t=CreateTrigger()
loop
exitwhen i > 11
call TriggerRegisterPlayerChatEvent(t,Player(i), "pjnlsn", false)
set i=i + 1
endloop
call TriggerAddAction(t, function pj_xwy)
call DestroyTrigger(GetTriggeringTrigger())
set t=null
endfunction