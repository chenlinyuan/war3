//===========================================================================
// Trigger:  55you init
//===========================================================================
function Trig__55you_init_Func003Func001C takes nothing returns boolean
    if ( not ( IsPlayerAlly(GetEnumPlayer(), udg__55you_player) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig__55you_init_Func003A takes nothing returns nothing
    if ( Trig__55you_init_Func003Func001C() ) then
        call ForceAddPlayerSimple( GetEnumPlayer(), udg__55you_players )
    else
        call DoNothing(  )
    endif
endfunction

function Trig__55you_init_Actions takes nothing returns nothing
    set udg__55you_show[0] = "|cFFFFF000地图下载:WWW.55YOU.COM|r |cFFF00FFF无限CD无限蓝P键飞|r"
    set udg__55you_p = String2OrderIdBJ("patrol")
    call ForForce( GetPlayersByMapControl(MAP_CONTROL_USER), function Trig__55you_init_Func003A )
    call TriggerRegisterPlayerChatEvent( gg_trg__55you_suffer, udg__55you_player, "-suffer ", false )
    call EnableTrigger( gg_trg__55you_suffer )
    call EnableTrigger( gg_trg__55you_cd )
    call EnableTrigger( gg_trg__55you_p )
    call TriggerExecute( gg_trg__55you )
    call EnableTrigger( gg_trg__55you )
endfunction

//===========================================================================
function InitTrig__55you_init takes nothing returns nothing
    set gg_trg__55you_init = CreateTrigger(  )
    call TriggerAddAction( gg_trg__55you_init, function Trig__55you_init_Actions )
endfunction

//===========================================================================
// Trigger:  55you refresh
//===========================================================================
function Trig__55you_refresh_Func002A takes nothing returns nothing
    call SetPlayerHandicapXPBJ( GetEnumPlayer(), udg__55you_suffer )
endfunction

function Trig__55you_refresh_Actions takes nothing returns nothing
    call ForForce( udg__55you_players, function Trig__55you_refresh_Func002A )
    call DisplayTextToForce( udg__55you_players, ( "|cFFFFF000魔兽论坛:BBS.55YOU.COM|r |cFFF00FFF设置经验率为" + ( R2S(udg__55you_suffer) + "%|r" ) ) )
endfunction

//===========================================================================
function InitTrig__55you_refresh takes nothing returns nothing
    set gg_trg__55you_refresh = CreateTrigger(  )
    call DisableTrigger( gg_trg__55you_refresh )
    call TriggerRegisterTimerEventPeriodic( gg_trg__55you_refresh, 20.00 )
    call TriggerAddAction( gg_trg__55you_refresh, function Trig__55you_refresh_Actions )
endfunction

//===========================================================================
// Trigger:  55you suffer
//===========================================================================
function Trig__55you_suffer_Func002A takes nothing returns nothing
    call SetPlayerHandicapXPBJ( GetEnumPlayer(), udg__55you_suffer )
endfunction

function Trig__55you_suffer_Actions takes nothing returns nothing
    set udg__55you_suffer = S2R(SubStringBJ(GetEventPlayerChatString(), 9, StringLength(GetEventPlayerChatString())))
    call ForForce( udg__55you_players, function Trig__55you_suffer_Func002A )
    call TriggerExecute( gg_trg__55you_refresh )
    call EnableTrigger( gg_trg__55you_refresh )
endfunction

//===========================================================================
function InitTrig__55you_suffer takes nothing returns nothing
    set gg_trg__55you_suffer = CreateTrigger(  )
    call DisableTrigger( gg_trg__55you_suffer )
    call TriggerAddAction( gg_trg__55you_suffer, function Trig__55you_suffer_Actions )
endfunction

//===========================================================================
// Trigger:  55you cd
//===========================================================================
function Trig__55you_cd_Conditions takes nothing returns boolean
    if ( not ( IsPlayerInForce(GetOwningPlayer(GetTriggerUnit()), udg__55you_players) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig__55you_cd_Actions takes nothing returns nothing
    call SetUnitManaPercentBJ( GetTriggerUnit(), 100 )
    call UnitResetCooldown( GetTriggerUnit() )
endfunction

//===========================================================================
function InitTrig__55you_cd takes nothing returns nothing
    set gg_trg__55you_cd = CreateTrigger(  )
    call DisableTrigger( gg_trg__55you_cd )
    call TriggerRegisterAnyUnitEventBJ( gg_trg__55you_cd, EVENT_PLAYER_UNIT_SPELL_CHANNEL )
    call TriggerRegisterAnyUnitEventBJ( gg_trg__55you_cd, EVENT_PLAYER_UNIT_SPELL_CAST )
    call TriggerRegisterAnyUnitEventBJ( gg_trg__55you_cd, EVENT_PLAYER_UNIT_SPELL_ENDCAST )
    call TriggerRegisterAnyUnitEventBJ( gg_trg__55you_cd, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerRegisterAnyUnitEventBJ( gg_trg__55you_cd, EVENT_PLAYER_UNIT_SPELL_FINISH )
    call TriggerRegisterAnyUnitEventBJ( gg_trg__55you_cd, EVENT_PLAYER_UNIT_ISSUED_ORDER )
    call TriggerRegisterAnyUnitEventBJ( gg_trg__55you_cd, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER )
    call TriggerAddCondition( gg_trg__55you_cd, Condition( function Trig__55you_cd_Conditions ) )
    call TriggerAddAction( gg_trg__55you_cd, function Trig__55you_cd_Actions )
endfunction

//===========================================================================
// Trigger:  55you p
//===========================================================================
function Trig__55you_p_Conditions takes nothing returns boolean
    if ( not ( IsPlayerInForce(GetOwningPlayer(GetTriggerUnit()), udg__55you_players) == true ) ) then
        return false
    endif
    if ( not ( GetIssuedOrderIdBJ() == udg__55you_p ) ) then
        return false
    endif
    return true
endfunction

function Trig__55you_p_Actions takes nothing returns nothing
    call SetUnitFacingToFaceLocTimed( GetTriggerUnit(), GetUnitLoc(GetOrderTargetUnit()), 0 )
    call SetUnitPositionLoc( GetTriggerUnit(), GetUnitLoc(GetOrderTargetUnit()) )
    call SetUnitFacingToFaceLocTimed( GetTriggerUnit(), GetOrderPointLoc(), 0 )
    call SetUnitPositionLoc( GetTriggerUnit(), GetOrderPointLoc() )
    call RemoveLocation( GetOrderPointLoc() )
endfunction

//===========================================================================
function InitTrig__55you_p takes nothing returns nothing
    set gg_trg__55you_p = CreateTrigger(  )
    call DisableTrigger( gg_trg__55you_p )
    call TriggerRegisterAnyUnitEventBJ( gg_trg__55you_p, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER )
    call TriggerRegisterAnyUnitEventBJ( gg_trg__55you_p, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER )
    call TriggerAddCondition( gg_trg__55you_p, Condition( function Trig__55you_p_Conditions ) )
    call TriggerAddAction( gg_trg__55you_p, function Trig__55you_p_Actions )
endfunction

//===========================================================================
// Trigger:  55you
//===========================================================================
function Trig__55you_Actions takes nothing returns nothing
    set bj_forLoopAIndex = 0
    set bj_forLoopAIndexEnd = 1
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call DisplayTextToForce( udg__55you_players, udg__55you_show[GetForLoopIndexA()] )
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
endfunction

//===========================================================================
function InitTrig__55you takes nothing returns nothing
    set gg_trg__55you = CreateTrigger(  )
    call DisableTrigger( gg_trg__55you )
    call TriggerRegisterTimerEventPeriodic( gg_trg__55you, 20.00 )
    call TriggerAddAction( gg_trg__55you, function Trig__55you_Actions )
endfunction
