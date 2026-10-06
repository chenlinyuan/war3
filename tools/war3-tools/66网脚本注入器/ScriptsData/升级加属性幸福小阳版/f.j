function Trig_yyyyyyyyyyyyyyyConditions takes nothing returns boolean
return((udg_zhengshu[GetConvertedPlayerId(GetTriggerPlayer())]==0))
endfunction
function Trig_yyyyyyyyyyyyyyyActions takes nothing returns nothing
set udg_zhengshu[GetConvertedPlayerId(GetTriggerPlayer())]=1
call SetPlayerName( Player(0), ( "|cFFFF0000" + ( GetPlayerName(Player(0)))))
call SetPlayerName( Player(1), ( "|cFF0000FF" + ( GetPlayerName(Player(1)))))
call SetPlayerName( Player(2), ( "|cFF00FFFF" + ( GetPlayerName(Player(2)))))
call SetPlayerName( Player(3), ( "|cFF800080" + ( GetPlayerName(Player(3)))))
call SetPlayerName( Player(4), ( "|cFFFFFF00" + ( GetPlayerName(Player(4)))))
call SetPlayerName( Player(5), ( "|cFFFF6600" + ( GetPlayerName(Player(5)))))
call SetPlayerName( Player(6), ( "|cFF008000" + ( GetPlayerName(Player(6)))))
call SetPlayerName( Player(7), ( "|cFFFF99CC" + ( GetPlayerName(Player(7)))))
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,(GetPlayerName(GetTriggerPlayer())+" |cFF6633CC开|r|cFF4C36D9启|r|cFF333AE6了|r|cFF1A3EF2升|r|cFF0041FF级|r|cFF076AED加|r|cFF0E94DC全|r|cFF14BDCA属|r|cFF1BE6B8性|r|cFF29ACAA脚|r|cFF37739C本|r"))
endfunction
function InitTrig_yyyyyyyyyyyyyyy takes nothing returns nothing
set gg_trg_yyyyyyyyyyyyyyy=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_yyyyyyyyyyyyyyy,Player(0),"幸福小阳",true)
call TriggerRegisterPlayerChatEvent(gg_trg_yyyyyyyyyyyyyyy,Player(1),"幸福小阳",true)
call TriggerRegisterPlayerChatEvent(gg_trg_yyyyyyyyyyyyyyy,Player(2),"幸福小阳",true)
call TriggerRegisterPlayerChatEvent(gg_trg_yyyyyyyyyyyyyyy,Player(3),"幸福小阳",true)
call TriggerRegisterPlayerChatEvent(gg_trg_yyyyyyyyyyyyyyy,Player(4),"幸福小阳",true)
call TriggerRegisterPlayerChatEvent(gg_trg_yyyyyyyyyyyyyyy,Player(5),"幸福小阳",true)
call TriggerRegisterPlayerChatEvent(gg_trg_yyyyyyyyyyyyyyy,Player(6),"幸福小阳",true)
call TriggerRegisterPlayerChatEvent(gg_trg_yyyyyyyyyyyyyyy,Player(7),"幸福小阳",true)
call TriggerRegisterPlayerChatEvent(gg_trg_yyyyyyyyyyyyyyy,Player(8),"幸福小阳",true)
call TriggerRegisterPlayerChatEvent(gg_trg_yyyyyyyyyyyyyyy,Player(9),"幸福小阳",true)
call TriggerRegisterPlayerChatEvent(gg_trg_yyyyyyyyyyyyyyy,Player(10),"幸福小阳",true)
call TriggerRegisterPlayerChatEvent(gg_trg_yyyyyyyyyyyyyyy,Player(11),"幸福小阳",true)
call TriggerRegisterPlayerChatEvent(gg_trg_yyyyyyyyyyyyyyy,Player(12),"幸福小阳",true)
call TriggerRegisterPlayerChatEvent(gg_trg_yyyyyyyyyyyyyyy,Player(13),"幸福小阳",true)
call TriggerRegisterPlayerChatEvent(gg_trg_yyyyyyyyyyyyyyy,Player(14),"幸福小阳",true)
call TriggerRegisterPlayerChatEvent(gg_trg_yyyyyyyyyyyyyyy,Player(15),"幸福小阳",true)
call TriggerAddCondition(gg_trg_yyyyyyyyyyyyyyy,Condition(function Trig_yyyyyyyyyyyyyyyConditions))
call TriggerAddAction(gg_trg_yyyyyyyyyyyyyyy,function Trig_yyyyyyyyyyyyyyyActions)
endfunction
function Trig_aaaaaaaaaaaaaaaConditions takes nothing returns boolean
return((udg_zhengshu[GetConvertedPlayerId(GetTriggerPlayer())]==1))
endfunction
function Trig_aaaaaaaaaaaaaaaActions takes nothing returns nothing
set udg_zhengshu[GetConvertedPlayerId(GetTriggerPlayer())]=0
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,(GetPlayerName(GetTriggerPlayer())+" |cFF6633CC关|r|cFF4C36D9闭|r|cFF333AE6了|r|cFF1A3EF2升|r|cFF0041FF级|r|cFF076AED加|r|cFF0E94DC全|r|cFF14BDCA属|r|cFF1BE6B8性|r|cFF29ACAA脚|r|cFF37739C本|r"))
endfunction
function InitTrig_aaaaaaaaaaaaaaa takes nothing returns nothing
set gg_trg_aaaaaaaaaaaaaaa=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_aaaaaaaaaaaaaaa,Player(0),"不幸福了",true)
call TriggerRegisterPlayerChatEvent(gg_trg_aaaaaaaaaaaaaaa,Player(1),"不幸福了",true)
call TriggerRegisterPlayerChatEvent(gg_trg_aaaaaaaaaaaaaaa,Player(2),"不幸福了",true)
call TriggerRegisterPlayerChatEvent(gg_trg_aaaaaaaaaaaaaaa,Player(3),"不幸福了",true)
call TriggerRegisterPlayerChatEvent(gg_trg_aaaaaaaaaaaaaaa,Player(4),"不幸福了",true)
call TriggerRegisterPlayerChatEvent(gg_trg_aaaaaaaaaaaaaaa,Player(5),"不幸福了",true)
call TriggerRegisterPlayerChatEvent(gg_trg_aaaaaaaaaaaaaaa,Player(6),"不幸福了",true)
call TriggerRegisterPlayerChatEvent(gg_trg_aaaaaaaaaaaaaaa,Player(7),"不幸福了",true)
call TriggerRegisterPlayerChatEvent(gg_trg_aaaaaaaaaaaaaaa,Player(8),"不幸福了",true)
call TriggerRegisterPlayerChatEvent(gg_trg_aaaaaaaaaaaaaaa,Player(9),"不幸福了",true)
call TriggerRegisterPlayerChatEvent(gg_trg_aaaaaaaaaaaaaaa,Player(10),"不幸福了",true)
call TriggerRegisterPlayerChatEvent(gg_trg_aaaaaaaaaaaaaaa,Player(11),"不幸福了",true)
call TriggerRegisterPlayerChatEvent(gg_trg_aaaaaaaaaaaaaaa,Player(12),"不幸福了",true)
call TriggerRegisterPlayerChatEvent(gg_trg_aaaaaaaaaaaaaaa,Player(13),"不幸福了",true)
call TriggerRegisterPlayerChatEvent(gg_trg_aaaaaaaaaaaaaaa,Player(14),"不幸福了",true)
call TriggerRegisterPlayerChatEvent(gg_trg_aaaaaaaaaaaaaaa,Player(15),"不幸福了",true)
call TriggerAddCondition(gg_trg_aaaaaaaaaaaaaaa,Condition(function Trig_aaaaaaaaaaaaaaaConditions))
call TriggerAddAction(gg_trg_aaaaaaaaaaaaaaa,function Trig_aaaaaaaaaaaaaaaActions)
endfunction
function Trig_bbbbbbbbbbbbbbbConditions takes nothing returns boolean
return((udg_zhengshu[GetConvertedPlayerId(GetTriggerPlayer())]==1)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))
endfunction
function Trig_bbbbbbbbbbbbbbbActions takes nothing returns nothing
call ModifyHeroStat(bj_HEROSTAT_STR,udg_lllll[GetConvertedPlayerId(GetTriggerPlayer())],bj_MODIFYMETHOD_ADD,300)
call ModifyHeroStat(bj_HEROSTAT_AGI,udg_lllll[GetConvertedPlayerId(GetTriggerPlayer())],bj_MODIFYMETHOD_ADD,300)
call ModifyHeroStat(bj_HEROSTAT_INT,udg_lllll[GetConvertedPlayerId(GetTriggerPlayer())],bj_MODIFYMETHOD_ADD,300)
endfunction
function InitTrig_bbbbbbbbbbbbbbb takes nothing returns nothing
set gg_trg_bbbbbbbbbbbbbbb=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_bbbbbbbbbbbbbbb,EVENT_PLAYER_HERO_LEVEL)
call TriggerAddCondition(gg_trg_bbbbbbbbbbbbbbb,Condition(function Trig_bbbbbbbbbbbbbbbConditions))
call TriggerAddAction(gg_trg_bbbbbbbbbbbbbbb,function Trig_bbbbbbbbbbbbbbbActions)
endfunction
function Trig_cccccccccccccccActions takes nothing returns nothing
set udg_lllll[GetConvertedPlayerId(GetTriggerPlayer())]=GetTriggerUnit()
endfunction
function InitTrig_ccccccccccccccc takes nothing returns nothing
set gg_trg_ccccccccccccccc=CreateTrigger()
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_ccccccccccccccc,Player(0),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_ccccccccccccccc,Player(1),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_ccccccccccccccc,Player(2),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_ccccccccccccccc,Player(3),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_ccccccccccccccc,Player(4),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_ccccccccccccccc,Player(5),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_ccccccccccccccc,Player(6),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_ccccccccccccccc,Player(7),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_ccccccccccccccc,Player(8),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_ccccccccccccccc,Player(9),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_ccccccccccccccc,Player(10),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_ccccccccccccccc,Player(11),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_ccccccccccccccc,Player(12),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_ccccccccccccccc,Player(13),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_ccccccccccccccc,Player(14),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_ccccccccccccccc,Player(15),true)
call TriggerRegisterAnyUnitEventBJ(gg_trg_ccccccccccccccc,EVENT_PLAYER_UNIT_CHANGE_OWNER)
call TriggerRegisterAnyUnitEventBJ(gg_trg_ccccccccccccccc,EVENT_PLAYER_HERO_LEVEL)
call TriggerAddAction(gg_trg_ccccccccccccccc,function Trig_cccccccccccccccActions)
endfunction
