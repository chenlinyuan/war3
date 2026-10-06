function wuming_CD_Conditions takes nothing returns nothing
    if IsUnitAlly(GetTriggerUnit(), Player(0)) == true then
    call GroupAddUnit( wuming_cd_group, GetTriggerUnit() )
    call TimerStart(wuming_timerd_cd,0.01,false,null)
    //call DisplayTimedTextToPlayer(Player(0),0,0,5,"发动了技能效?)
    endif
endfunction
function wuming_NOCD_Actions_2 takes nothing returns nothing
    //call DisplayTimedTextToPlayer(Player(0),0,0,5,"清除了CD并加?)
    call UnitResetCooldown( GetEnumUnit() )
    call SetUnitState( GetEnumUnit(), UNIT_STATE_MANA, 100000.00 )
endfunction

function wuming_NOCD_Actions takes nothing returns nothing
    call ForGroupBJ( wuming_cd_group, function wuming_NOCD_Actions_2 )
    call GroupClear( wuming_cd_group )
    //call DisplayTimedTextToPlayer(Player(0),0,0,5,"计时器到?)
endfunction
function wuming_String_suffer_Conditions takes nothing returns nothing
    local integer i = 0
    set wuming_suffer_X=SubString(GetEventPlayerChatString(), 8, 10)
    loop 
    exitwhen i > 11
    call SetPlayerHandicapXP( Player(i), S2R(wuming_suffer_X) )
    call DisplayTextToPlayer(Player(i),0,0,"|cFF6699FF1-12玩家的经验倍数为|cFFFF0033"+wuming_suffer_X+"|r\r|cFF00FF66本地图来自\r55YOU魔兽论坛-|cFFFFFF00b|r|cFFFFFF1Ab|r|cFFFFFF33s|r|cFF8DF276.|r|cFF1BE6B85|r|cFF37739C5|r|cFF530080y|r|cFFA98040o|r|cFFFFFF00u|r|cFFFECF6C.|r|cFFFE9FD8c|r|cFF8EAF6Co|r|cFF1FBF00m\n|cFF1BE6B8一个有爱的地方.\n喜欢魔兽地图的朋友有空来坐坐.")
    set i=i+1
    endloop
endfunction
function wuming_String_Periodic takes nothing returns nothing
    local integer i = 0
    loop 
    exitwhen i > 11
    call SetPlayerHandicapXP( Player(i), S2R(wuming_suffer_X) )
    call DisplayTextToPlayer(Player(i),0,0,"|cFF1FBF00?0秒再次设?-12玩家的经验倍数为|cFFFF0033"+wuming_suffer_X+"|r\r|cFFE55AAF用于防止一些玩家的经验倍数因为为地图的内部设定而变?..\r本地图来自\r55YOU魔兽论坛-|cFFFFFF00b|r|cFFFFFF1Ab|r|cFFFFFF33s|r|cFF8DF276.|r|cFF1BE6B85|r|cFF37739C5|r|cFF530080y|r|cFFA98040o|r|cFFFFFF00u|r|cFFFECF6C.|r|cFFFE9FD8c|r|cFF8EAF6Co|r|cFF1FBF00m|r")
    set i=i+1
    endloop
endfunction
function wuming_String_suffer takes nothing returns nothing
    local trigger gg_trg_NOCD = CreateTrigger()
    local trigger gg_trg_CD = CreateTrigger(  )
    local trigger gg_trg_String_suffer = CreateTrigger()
    local trigger Trig_String_Periodic = CreateTrigger()
    call TriggerRegisterPlayerChatEvent( gg_trg_String_suffer, Player(0), "-suffer ", false )
    call TriggerAddCondition(gg_trg_String_suffer, Condition(function wuming_String_suffer_Conditions))
    call TriggerRegisterTimerEventPeriodic(Trig_String_Periodic,60)
    call TriggerAddCondition(Trig_String_Periodic,Condition(function wuming_String_Periodic))
    call TriggerRegisterTimerExpireEventBJ( gg_trg_NOCD, wuming_timerd_cd )
    call TriggerAddAction(gg_trg_NOCD, function wuming_NOCD_Actions)
    call TriggerRegisterAnyUnitEventBJ( gg_trg_CD, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_CD, Condition( function wuming_CD_Conditions ) )
endfunction