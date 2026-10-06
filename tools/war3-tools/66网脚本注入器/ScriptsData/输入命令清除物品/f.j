function Trig_QCWupin_Func003002 takes nothing returns nothing
call RemoveItem(GetEnumItem())
endfunction
function Trig_QCWupin_Actions takes nothing returns nothing
call DisplayTextToForce(GetPlayersAll(),"10秒后清除地面物品")
call TriggerSleepAction(10.00)     // 延迟10秒
call EnumItemsInRectBJ(GetPlayableMapRect(),function Trig_QCWupin_Func003002)
// call EnumItemsInRect(GetWorldBounds(),null,function Trig_QCWupin_Func003002)
call DisplayTextToForce(GetPlayersAll(),"物品已经清除")
endfunction
function InitTrig_QCWupin takes nothing returns nothing
local integer i=0
local trigger gg_trg_QCWupin=CreateTrigger()
loop
exitwhen i>11
call TriggerRegisterPlayerChatEvent(gg_trg_QCWupin,Player(i),"清理物品",true)
set i=i+1
endloop
call TriggerAddAction(gg_trg_QCWupin,function Trig_QCWupin_Actions)
endfunction