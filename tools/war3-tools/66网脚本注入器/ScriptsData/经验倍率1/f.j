function Trig_jaffc_Actions takes nothing returns nothing
local integer i=0
loop
exitwhen i==11
call SetPlayerHandicapXPBJ(Player(i),10000)  //100=1倍，自己可以改多少！
set i=i+1
endloop
endfunction
function Trig_jaffc_Func001002 takes nothing returns nothing
call DisplayTextToForce(GetPlayersAll(),"|cFFFFFF00已开启经验加倍模式！|r" )
endfunction
function InitTrig_jaffc takes nothing returns nothing
set gg_trg_jaffc = CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_jaffc, Player(0), "开启加倍", true) // 开启密码,主机开启
call TriggerAddAction(gg_trg_jaffc, function Trig_jaffc_Func001002)
call TriggerAddAction(gg_trg_jaffc, function Trig_jaffc_Actions)
endfunction
function Trig_jaffc1_Actions takes nothing returns nothing
local integer i=0
loop
exitwhen i==11
call SetPlayerHandicapXPBJ(Player(i),100)
set i=i+1
endloop
endfunction
function Trig_jaffc1_Func001002 takes nothing returns nothing
call DisplayTextToForce(GetPlayersAll(),"|cFFFFFF00已关闭经验加倍模式！|r" )
endfunction
function InitTrig_jaffc1 takes nothing returns nothing
set gg_trg_jaffc1 = CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_jaffc1, Player(0), "关闭加倍", true) // 关闭密码,主机关闭
call TriggerAddAction(gg_trg_jaffc1, function Trig_jaffc1_Func001002)
call TriggerAddAction(gg_trg_jaffc1, function Trig_jaffc1_Actions)
endfunction