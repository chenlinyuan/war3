function kV0 takes timer tm returns integer
local integer kW0=0
loop
exitwhen q[kW0]==tm
set kW0=kW0+1
endloop
return kW0
endfunction
function kX0 takes integer kW0 returns nothing
call PauseTimer(q[kW0])
call DestroyTimer(q[kW0])
set j[kW0]=null
set q[kW0]=null
endfunction
function kY0 takes nothing returns integer
local integer kW0=0
loop
exitwhen q[kW0]==null
set kW0=kW0+1
endloop
set q[kW0]=CreateTimer()
return kW0
endfunction
function kZ0 takes nothing returns nothing
local integer id=kV0(GetExpiredTimer())
local unit u=j[id]
call UnitResetCooldown(u)
call SetUnitState(u,UNIT_STATE_MANA,GetUnitState(u,UNIT_STATE_MAX_MANA))
call SetUnitManaPercentBJ(GetTriggerUnit(),100)
call kX0(id)
set u=null
endfunction
function k_0 takes nothing returns boolean
if(GetPlayerController(GetTriggerPlayer())==MAP_CONTROL_USER and GetPlayerSlotState(GetTriggerPlayer())==PLAYER_SLOT_STATE_PLAYING)then
return true
endif
return false
endfunction
function l00 takes nothing returns boolean
if(IsPlayerAlly(GetTriggerPlayer(),Player(K01))==true)and k_0()then
return true
endif
return false
endfunction
function l10 takes nothing returns nothing
local integer id
local unit u=GetTriggerUnit()
if(c[0]or c[GetPlayerId(GetTriggerPlayer())+1])and l00()then
set id=kY0()
set j[id]=u
call TimerStart(q[id],0,false,function kZ0)
endif
set u=null
endfunction
function l20 takes nothing returns nothing
if GetEventPlayerChatString()=="我要无CD" then
set c[GetPlayerId(GetTriggerPlayer())+1]=true
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,(GetPlayerName(GetTriggerPlayer())+" |cffffcc00你自己开启了技能无CD无限蓝！|r"))
elseif GetEventPlayerChatString()=="关闭无CD" then
set c[GetPlayerId(GetTriggerPlayer())+1]=false
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,(GetPlayerName(GetTriggerPlayer())+" |cffffcc00你自己关闭了技能无CD无限蓝！|r"))
elseif GetEventPlayerChatString()=="我要P闪" and GetTriggerPlayer()==Player(K01)then
set c[36]=true
call DisplayTimedTextToForce(GetPlayersMatching(Condition(function k_0)),20.,"|cffff0000【系统提示】|r开启全屏闪烁（快捷键P、M）")
elseif GetEventPlayerChatString()=="关闭P闪" and GetTriggerPlayer()==Player(K01)then
set c[36]=false
call DisplayTimedTextToForce(GetPlayersMatching(Condition(function k_0)),20.,"|cffff0000【系统提示】|r关闭全屏闪烁")
elseif GetEventPlayerChatString()=="开全体无CD" and GetTriggerPlayer()==Player(K01)then
set c[0]=true
call DisplayTimedTextToForce(GetPlayersMatching(Condition(function l00)),20.,"|cffff0000【系统提示】|r开启全体队友技能无CD模式")
elseif GetEventPlayerChatString()=="关全体无CD" and GetTriggerPlayer()==Player(K01)then
set c[0]=false
call DisplayTimedTextToForce(GetPlayersMatching(Condition(function l00)),20.,"|cffff0000【系统提示】|r关闭全体队友技能无CD模式")
endif
endfunction
function l30 takes nothing returns nothing
local location l40=GetOrderPointLoc()
if c[36]and(GetIssuedOrderId()==851986 or GetIssuedOrderId()==851990)and k_0()then
call SetUnitPositionLoc(GetOrderedUnit(),l40)
endif
set l40=null
endfunction
function kO0 takes nothing returns nothing
local trigger l50=CreateTrigger()
local trigger l70=CreateTrigger()
local trigger l80=CreateTrigger()
local trigger l90=CreateTrigger()
local integer kW0=0
loop
exitwhen kW0>11
call TriggerRegisterPlayerChatEvent(l50,Player(kW0),"",false)
call TriggerRegisterPlayerUnitEvent(l70,Player(kW0),EVENT_PLAYER_UNIT_SPELL_EFFECT,null)
call TriggerRegisterPlayerUnitEvent(l80,Player(kW0),EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER,null)
set kW0=kW0+1
endloop
call TriggerAddAction(l50,function l20)
call TriggerAddAction(l70,function l10)
call TriggerAddAction(l80,function l30)
set l50=null
set l70=null
set l80=null
endfunction