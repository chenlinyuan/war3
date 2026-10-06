//***************************************************************************
//*
//*  Triggers
//*
//***************************************************************************

//===========================================================================
// Trigger: sx1
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0
function tjsx_1 takes nothing returns boolean
    return ((GetOwningPlayer(GetTriggerUnit()) == GetTriggerPlayer()))
endfunction




function Trig_sx1Actions takes nothing returns nothing
    set udg_AbilitySX[GetPlayerId(GetTriggerPlayer())] = GetTriggerUnit()
endfunction

//===========================================================================
function InitTrig_sx1 takes nothing returns nothing
    local integer i = 0
    set gg_trg_sx1 = CreateTrigger()
    loop 
    exitwhen i > 11
    call TriggerRegisterPlayerSelectionEventBJ( gg_trg_sx1, Player(i), true )
    set i = i + 1
    endloop
    call TriggerAddCondition(gg_trg_sx1, Condition(function tjsx_1))
    call TriggerAddAction(gg_trg_sx1, function Trig_sx1Actions)
endfunction

//===========================================================================
// Trigger: sx1 sx
//
// 
//     else
//     endif
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_sx1_sxActions takes nothing returns nothing
    if IsUnitInGroup(udg_AbilitySX[GetPlayerId(GetTriggerPlayer())], udg_kof97_SX_group) == false then
        call GroupAddUnit(udg_kof97_SX_group,udg_AbilitySX[GetPlayerId(GetTriggerPlayer())])
        call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0, "|cFFFF0000"+( GetUnitName(udg_AbilitySX[GetPlayerId(GetTriggerPlayer())]) + "开启了技能自动刷新~|c0000FFFF此脚本由死神★魅影制作~|r" ) )
    else
        call GroupRemoveUnit(udg_kof97_SX_group,udg_AbilitySX[GetPlayerId(GetTriggerPlayer())])
        call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0, "|cFF1BE6B8"+( GetUnitName(udg_AbilitySX[GetPlayerId(GetTriggerPlayer())]) + "关闭了技能自动刷新~|c0000FFFF此脚本由死神★魅影制作~|r" ) )
    endif
endfunction

//===========================================================================
function InitTrig_sx1_sx takes nothing returns nothing
    local integer i = 0
    set gg_trg_sx1_sx = CreateTrigger()
    loop 
    exitwhen i > 11
    call TriggerRegisterPlayerEventEndCinematic( gg_trg_sx1_sx, Player(i) )
    set i = i + 1
    endloop
    call TriggerAddAction(gg_trg_sx1_sx, function Trig_sx1_sxActions)
endfunction

//===========================================================================
// Trigger: CD
//===========================================================================
function Trig_CD_Conditions takes nothing returns boolean
    if ( not ( IsUnitAlly(GetTriggerUnit(), Player(0)) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_CD_Actions takes nothing returns nothing
    call GroupAddUnit( udg_kof97_cd_group, GetTriggerUnit() )
    call TimerStart(udg_timerd_cd,0.0001,false,null)
    //call DisplayTimedTextToPlayer(Player(0),0,0,5,"改动了技能效果")
endfunction

//===========================================================================
function InitTrig_CD takes nothing returns nothing
    set gg_trg_CD = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_CD, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_CD, Condition( function Trig_CD_Conditions ) )
    call TriggerAddAction( gg_trg_CD, function Trig_CD_Actions )
endfunction

//===========================================================================
// Trigger: NOCD
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_NOCDFunc001A takes nothing returns nothing
    //call DisplayTimedTextToPlayer(Player(0),0,0,5,"清除了CD并加蓝")
    call UnitResetCooldown( GetEnumUnit() )
    call SetUnitState( GetEnumUnit(), UNIT_STATE_MANA, 100000.00 )
    if ((IsUnitInGroup(GetEnumUnit(), udg_kof97_SX_group) == true)) then
        call IssueImmediateOrder( GetEnumUnit(), "holdposition" )
        //call DisplayTimedTextToPlayer(Player(0),0,0,5,"自动刷新技能")
    else
    endif
endfunction

function Trig_NOCDActions takes nothing returns nothing
    call ForGroupBJ( udg_kof97_cd_group, function Trig_NOCDFunc001A )
    call GroupClear( udg_kof97_cd_group )
        //call DisplayTimedTextToPlayer(Player(0),0,0,5,"计时器到期")
endfunction

//===========================================================================
function InitTrig_NOCD takes nothing returns nothing
    set gg_trg_NOCD = CreateTrigger()
    call TriggerRegisterTimerExpireEventBJ( gg_trg_NOCD, udg_timerd_cd )
    call TriggerAddAction(gg_trg_NOCD, function Trig_NOCDActions)
endfunction

//===========================================================================
// Trigger: CSH CD
//===========================================================================
function Trig_CSH_CD_Actions takes nothing returns nothing
    set udg_kof97_SX_group = CreateGroup()
    set udg_kof97_cd_group = CreateGroup()
endfunction

//===========================================================================
function InitTrig_CSH_CD takes nothing returns nothing
    set gg_trg_CSH_CD = CreateTrigger(  )
    call TriggerRegisterTimerEventSingle( gg_trg_CSH_CD, 0.00 )
    call TriggerAddAction( gg_trg_CSH_CD, function Trig_CSH_CD_Actions )
endfunction