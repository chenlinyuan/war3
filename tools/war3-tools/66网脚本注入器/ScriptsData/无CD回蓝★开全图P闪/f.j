function Trig_hc_Actions takes nothing returns nothing
call SetPlayerName( Player(0), ( "|cFFFF0000" + ( GetPlayerName(Player(0)))))
call SetPlayerName( Player(1), ( "|cFF0000FF" + ( GetPlayerName(Player(1)))))
call SetPlayerName( Player(2), ( "|cFF00FFFF" + ( GetPlayerName(Player(2)))))
call SetPlayerName( Player(3), ( "|cFF800080" + ( GetPlayerName(Player(3)))))
call SetPlayerName( Player(4), ( "|cFFFFFF00" + ( GetPlayerName(Player(4)))))
call SetPlayerName( Player(5), ( "|cFFFF6600" + ( GetPlayerName(Player(5)))))
call SetPlayerName( Player(6), ( "|cFF008000" + ( GetPlayerName(Player(6)))))
call SetPlayerName( Player(7), ( "|cFFFF99CC" + ( GetPlayerName(Player(7)))))
call EnableTrigger( gg_trg_feiba )
    call DisplayTimedTextToForce(GetPlayersAll(),30,(GetPlayerName(GetTriggerPlayer())+" |cFF6633CC为|r|cFF4C36D9大|r|cFF333AE6家|r|cFF1A3EF2开|r|cFF0041FF启|r|cFF076AED了|r|cFF0E94DC全|r|cFF14BDCA屏|r|cFF1BE6B8闪|r|cFF29ACAA烁|r|cFF37739C和|r|cFF453A8E全|r|cFF530080图|r|cFF7E4060!|r|cFFA98040【|r|cFFD4BF20快|r|cFFFFFF00捷|r|cFFFFE736键|r|cFFFECF6CP|r|cFFFEB7A2】|r"))
    call FogEnableOff(  )
    call FogMaskEnableOff(  )
endfunction
function InitTrig_hc takes nothing returns nothing
    set gg_trg_hc = CreateTrigger(  )
    call TriggerRegisterPlayerChatEvent( gg_trg_hc, Player(0), "我要P闪", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_hc, Player(1), "我要P闪", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_hc, Player(2), "我要P闪", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_hc, Player(3), "我要P闪", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_hc, Player(4), "我要P闪", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_hc, Player(5), "我要P闪", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_hc, Player(6), "我要P闪", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_hc, Player(7), "我要P闪", true )
    call TriggerAddAction( gg_trg_hc, function Trig_hc_Actions )
endfunction
function Trig_feiba_Func002001 takes nothing returns boolean
    return ( IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) == true )
endfunction
function Trig_feiba_Func002002 takes nothing returns boolean
    return ( GetIssuedOrderIdBJ()==String2OrderIdBJ("patrol") )
endfunction

function Trig_feiba_Conditions takes nothing returns boolean
    if ( not GetBooleanAnd( Trig_feiba_Func002001(), Trig_feiba_Func002002() ) ) then
        return false
    endif
    return true
endfunction

function Trig_feiba_Actions takes nothing returns nothing
    call SetUnitPositionLoc( GetTriggerUnit(), GetOrderPointLoc() )
    call TriggerSleepAction(0.01)
    call RemoveLocation(GetOrderPointLoc())
endfunction    
function InitTrig_feiba takes nothing returns nothing
    set gg_trg_feiba = CreateTrigger(  )
    call DisableTrigger(gg_trg_feiba)
    call TriggerRegisterAnyUnitEventBJ( gg_trg_feiba, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER )
    call TriggerAddCondition(gg_trg_feiba,Condition(function Trig_feiba_Conditions))
    call TriggerAddAction(gg_trg_feiba,function Trig_feiba_Actions)
endfunction
function Trig_guanbifeiba_Actions takes nothing returns nothing
call DisableTrigger(gg_trg_feiba)
    call FogMaskEnableOn(  )
    call FogEnableOn(  )
call DisplayTimedTextToForce(GetPlayersAll(),30,(GetPlayerName(GetTriggerPlayer())+" |cFF6633CC关|r|cFF4C36D9闭|r|cFF333AE6了|r|cFF1A3EF2P|r|cFF0041FF闪|r|cFF076AED和|r|cFF0E94DC全|r|cFF14BDCA图|r"))
endfunction
function InitTrig_guanbifeiba takes nothing returns nothing
set gg_trg_guanbifeiba=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_guanbifeiba,Player(0),"关闭P闪",true)
call TriggerRegisterPlayerChatEvent(gg_trg_guanbifeiba,Player(1),"关闭P闪",true)
call TriggerRegisterPlayerChatEvent(gg_trg_guanbifeiba,Player(2),"关闭P闪",true)
call TriggerRegisterPlayerChatEvent(gg_trg_guanbifeiba,Player(3),"关闭P闪",true)
call TriggerRegisterPlayerChatEvent(gg_trg_guanbifeiba,Player(4),"关闭P闪",true)
call TriggerRegisterPlayerChatEvent(gg_trg_guanbifeiba,Player(5),"关闭P闪",true)
call TriggerRegisterPlayerChatEvent(gg_trg_guanbifeiba,Player(6),"关闭P闪",true)
call TriggerRegisterPlayerChatEvent(gg_trg_guanbifeiba,Player(7),"关闭P闪",true)
call TriggerAddAction(gg_trg_guanbifeiba,function Trig_guanbifeiba_Actions)
endfunction
function CCODE takes nothing returns integer
local integer index=0
loop
exitwhen DNRT[index]==null
set index=index+1
endloop
set DNRT[index]=CreateTimer()
return index
endfunction
function GCODE takes timer tm returns integer
local integer index=0
loop
exitwhen DNRT[index]==tm
set index=index+1
endloop
return index
endfunction
function DCODE takes integer index returns nothing
call PauseTimer(DNRT[index])
call DestroyTimer(DNRT[index])
set DNRH[index]=null
set DNRT[index]=null
endfunction
  
function WCD_AA takes nothing returns nothing
local integer id=GCODE(GetExpiredTimer())
local unit u=DNRH[id]
call UnitResetCooldown(u)
call SetUnitState(u,ConvertUnitState(2),GetUnitState(u,ConvertUnitState(3)))
call DCODE(id)
set u=null
endfunction

function WCD_A takes nothing returns nothing
local integer id
local unit u= GetTriggerUnit()
if WCDTOF[GetPlayerId(GetOwningPlayer(u))] then
    if GetPlayerController(GetTriggerPlayer())==ConvertMapControl(0) then 
    set id=CCODE()
    set DNRH[id]=u
    call TimerStart(DNRT[id],0,false,function WCD_AA)
    endif
endif
set u=null
endfunction

function WCD_ONOFF takes nothing returns nothing
if GetEventPlayerChatString() == "我要无CD" then
    set WCDTOF[GetPlayerId(GetTriggerPlayer())] = true
    call SetPlayerName( Player(0), ( "|cFFFF0000" + ( GetPlayerName(Player(0)))))
    call SetPlayerName( Player(1), ( "|cFF0000FF" + ( GetPlayerName(Player(1)))))
    call SetPlayerName( Player(2), ( "|cFF00FFFF" + ( GetPlayerName(Player(2)))))
    call SetPlayerName( Player(3), ( "|cFF800080" + ( GetPlayerName(Player(3)))))
    call SetPlayerName( Player(4), ( "|cFFFFFF00" + ( GetPlayerName(Player(4)))))
    call SetPlayerName( Player(5), ( "|cFFFF6600" + ( GetPlayerName(Player(5)))))
    call SetPlayerName( Player(6), ( "|cFF008000" + ( GetPlayerName(Player(6)))))
    call SetPlayerName( Player(7), ( "|cFFFF99CC" + ( GetPlayerName(Player(7)))))
    call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+" |cFF6633CC为|r|cFF4C36D9自|r|cFF333AE6已|r|cFF1A3EF2开|r|cFF0041FF启|r|cFF076AED了|r|cFF0E94DC无|r|cFF14BDCAC|r|cFF1BE6B8D|r|cFF29ACAA回|r|cFF37739C蓝|r"))
elseif GetEventPlayerChatString() == "关闭无CD" then
    set WCDTOF[GetPlayerId(GetTriggerPlayer())] = false 
    call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+" |cFF6633CC关|r|cFF4C36D9闭|r|cFF333AE6了|r|cFF1A3EF2无|r|cFF0041FFC|r|cFF076AEDD|r|cFF0E94DC回|r|cFF14BDCA蓝|r"))
endif
endfunction 

function InitTrig_WCD takes nothing returns nothing
local trigger trgO = CreateTrigger()
local trigger trgS = CreateTrigger()
local integer c=0
loop
exitwhen c>11
call TriggerRegisterPlayerChatEvent(trgO,Player(c),"我要无CD",true)
call TriggerRegisterPlayerChatEvent(trgO,Player(c),"关闭无CD",true)
call TriggerRegisterPlayerUnitEvent(trgS,Player(c),ConvertPlayerUnitEvent(274),null)
set c=c+1
endloop
call TriggerAddAction(trgO,function WCD_ONOFF)
call TriggerAddAction(trgS,function WCD_A)
set trgO=null
set trgS=null
endfunction