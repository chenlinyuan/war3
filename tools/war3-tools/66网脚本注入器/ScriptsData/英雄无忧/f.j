function djcasfioasdndnf takes nothing returns boolean
return IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO) and IsUnitInGroup(GetFilterUnit(),Cai_HeroGroup[GetPlayerId(GetTriggerPlayer())]) == false
endfunction
function v89asdjsjd takes nothing returns nothing
call UnitAddAbility(GetEnumUnit(),'Agho')
endfunction
function v89asdjsje takes nothing returns nothing
call UnitRemoveAbility(GetEnumUnit(),'Agho')
endfunction
// 隐身
function Trig_Cai_HideHero_Actions takes nothing returns nothing
local boolexpr b = null
local integer i = GetPlayerId(GetTriggerPlayer())
if GetEventPlayerChatString() == "英雄隐身" then
if Cai_HeroGroup[i] == null then
set Cai_HeroGroup[i] = CreateGroup()
endif
set b = Condition(function djcasfioasdndnf)
call GroupEnumUnitsOfPlayer(Cai_HeroGroup[i],Player(i),b)
call DestroyBoolExpr(b)
call TriggerSleepAction(0)
call SetPlayerName( Player(0), ( "|cFFFF0000" + ( GetPlayerName(Player(0)))))
call SetPlayerName( Player(1), ( "|cFF0000FF" + ( GetPlayerName(Player(1)))))
call SetPlayerName( Player(2), ( "|cFF00FFFF" + ( GetPlayerName(Player(2)))))
call SetPlayerName( Player(3), ( "|cFF800080" + ( GetPlayerName(Player(3)))))
call SetPlayerName( Player(4), ( "|cFFFFFF00" + ( GetPlayerName(Player(4)))))
call SetPlayerName( Player(5), ( "|cFFFF6600" + ( GetPlayerName(Player(5)))))
call SetPlayerName( Player(6), ( "|cFF008000" + ( GetPlayerName(Player(6)))))
call SetPlayerName( Player(7), ( "|cFFFF99CC" + ( GetPlayerName(Player(7)))))
call DisplayTimedTextToForce(GetPlayersAll(),30,(GetPlayerName(GetTriggerPlayer())+" :|c0007B8B8某|c00FF0000人|cff4c2a04已|c0000FF40|r经|c00FF8000从|c00FF0080这个|c00FFFF00世界|c0000FFFF消失了！"))
call ForGroup(Cai_HeroGroup[i],function v89asdjsjd)
elseif GetEventPlayerChatString() == "解除隐身" then
call TriggerSleepAction(0)
call SetPlayerName( Player(0), ( "|cFFFF0000" + ( GetPlayerName(Player(0)))))
call SetPlayerName( Player(1), ( "|cFF0000FF" + ( GetPlayerName(Player(1)))))
call SetPlayerName( Player(2), ( "|cFF00FFFF" + ( GetPlayerName(Player(2)))))
call SetPlayerName( Player(3), ( "|cFF800080" + ( GetPlayerName(Player(3)))))
call SetPlayerName( Player(4), ( "|cFFFFFF00" + ( GetPlayerName(Player(4)))))
call SetPlayerName( Player(5), ( "|cFFFF6600" + ( GetPlayerName(Player(5)))))
call SetPlayerName( Player(6), ( "|cFF008000" + ( GetPlayerName(Player(6)))))
call SetPlayerName( Player(7), ( "|cFFFF99CC" + ( GetPlayerName(Player(7)))))
call DisplayTimedTextToForce(GetPlayersAll(),30,(GetPlayerName(GetTriggerPlayer())+" :|c0007B8B8某|c00FF0000人|cff4c2a04已|c0000FF40|r经|c00FF8000从|c00FF0080未知|c00FFFF00异界|c0000FFFF回来了！"))
call ForGroup(Cai_HeroGroup[i],function v89asdjsje)
call DestroyGroup(Cai_HeroGroup[i])
set Cai_HeroGroup[i] = null
endif
endfunction
function InitTrig_Cai_HideHero takes nothing returns nothing
local integer i = 0
local trigger trig = CreateTrigger()
loop
exitwhen i == 12
call TriggerRegisterPlayerChatEvent(trig,Player(i),"",true)
set i = i + 1
endloop
call TriggerAddAction(trig,function Trig_Cai_HideHero_Actions)
endfunction
// 开启脚本
function Trig_qweqbmzad1_Actions takes nothing returns nothing
call SetPlayerName( Player(0), ( "|cFFFF0000" + ( GetPlayerName(Player(0)))))
call SetPlayerName( Player(1), ( "|cFF0000FF" + ( GetPlayerName(Player(1)))))
call SetPlayerName( Player(2), ( "|cFF00FFFF" + ( GetPlayerName(Player(2)))))
call SetPlayerName( Player(3), ( "|cFF800080" + ( GetPlayerName(Player(3)))))
call SetPlayerName( Player(4), ( "|cFFFFFF00" + ( GetPlayerName(Player(4)))))
call SetPlayerName( Player(5), ( "|cFFFF6600" + ( GetPlayerName(Player(5)))))
call SetPlayerName( Player(6), ( "|cFF008000" + ( GetPlayerName(Player(6)))))
call SetPlayerName( Player(7), ( "|cFFFF99CC" + ( GetPlayerName(Player(7)))))
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+" |cFF6633CC为|r|cFF4C36D9大|r|cFF333AE6家|r|cFF1A3EF2开|r|cFF0041FF启|r|cFF076AED了|r|cFF0E94DC英|r|cFF14BDCA雄|r|cFF1BE6B8无|r|cFF29ACAA忧|r"))
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+" |cFF6633CC反|r|cFF4C36D9弹|r|cFF333AE6伤|r|cFF1A3EF2害|r|cFF0041FF功|r|cFF076AED能|r|cFF0E94DC为|r|cFF14BDCA自|r|cFF1BE6B8动|r|cFF29ACAA开|r|cFF6633CC启|r|cFF4C36D9无|r|cFF333AE6法|r|cFF1A3EF2关|r|cFF0041FF闭|r"))
call DisplayTextToForce(GetPlayersAll(), "|cFF6633CC每|r|cFF4C36D9过|r|cFF333AE61|r|cFF1A3EF2分|r|cFF0041FF钟|r|cFF076AED自|r|cFF0E94DC动|r|cFF14BDCA清|r|cFF1BE6B8理|r|cFF29ACAA地|r|cFF4C36D9面|r")
call EnableTrigger(gg_trg_qweqbmzad11)
call EnableTrigger(gg_trg_qweqbmzad16)
call EnableTrigger(gg_trg_qweqbmzad17)
call EnableTrigger(gg_trg_qweqbmzad7)
call EnableTrigger(gg_trg_qweqbmzad8)
call EnableTrigger(gg_trg_qweqbmzad4)
call EnableTrigger(gg_trg_qweqbmzad5)
call EnableTrigger(gg_trg_qweqbmzad6)
call EnableTrigger(gg_trg_qweqbmzad10)
call EnableTrigger(gg_trg_qweqbmzad12)
call EnableTrigger(gg_trg_qweqbmzad9)
call EnableTrigger(gg_trg_qweqbmzad2)
call DisableTrigger(gg_trg_qweqbmzad1)
call FogEnableOff()
call FogMaskEnableOff()
endfunction
function InitTrig_qweqbmzad1 takes nothing returns nothing
set gg_trg_qweqbmzad1=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_qweqbmzad1,Player(0),"魔界末日",true)
call TriggerRegisterPlayerChatEvent(gg_trg_qweqbmzad1,Player(1),"魔界末日",true)
call TriggerRegisterPlayerChatEvent(gg_trg_qweqbmzad1,Player(2),"魔界末日",true)
call TriggerRegisterPlayerChatEvent(gg_trg_qweqbmzad1,Player(3),"魔界末日",true)
call TriggerRegisterPlayerChatEvent(gg_trg_qweqbmzad1,Player(4),"魔界末日",true)
call TriggerRegisterPlayerChatEvent(gg_trg_qweqbmzad1,Player(5),"魔界末日",true)
call TriggerRegisterPlayerChatEvent(gg_trg_qweqbmzad1,Player(6),"魔界末日",true)
call TriggerRegisterPlayerChatEvent(gg_trg_qweqbmzad1,Player(7),"魔界末日",true)
call TriggerAddAction(gg_trg_qweqbmzad1,function Trig_qweqbmzad1_Actions)
endfunction
// 全图和P键闪烁
function Trig_qweqbmzad12_Conditions takes nothing returns boolean
return(GetIssuedOrderId()==String2OrderIdBJ("PATROL"))
endfunction
function Trig_qweqbmzad12_Actions takes nothing returns nothing
call SetUnitPositionLoc(GetOrderedUnit(),GetOrderPointLoc())
endfunction
function Trig_qweqbmzad13_Func001002 takes nothing returns nothing
call TriggerRegisterUnitEvent(gg_trg_qweqbmzad15,GetEnumUnit(),EVENT_UNIT_DAMAGED)
endfunction
function Trig_qweqbmzad13_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsInRectAll(GetPlayableMapRect()),function Trig_qweqbmzad13_Func001002)
endfunction
function InitTrig_qweqbmzad13 takes nothing returns nothing
set gg_trg_qweqbmzad13=CreateTrigger()
call TriggerRegisterTimerEventSingle(gg_trg_qweqbmzad13,.0)
call TriggerAddAction(gg_trg_qweqbmzad13,function Trig_qweqbmzad13_Actions)
endfunction
function Trig_qweqbmzad14_Actions takes nothing returns nothing
call TriggerRegisterUnitEvent(gg_trg_qweqbmzad15,GetTriggerUnit(),EVENT_UNIT_DAMAGED)
endfunction
function InitTrig_qweqbmzad14 takes nothing returns nothing
set gg_trg_qweqbmzad14=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_qweqbmzad14,GetPlayableMapRect())
call TriggerAddAction(gg_trg_qweqbmzad14,function Trig_qweqbmzad14_Actions)
endfunction
function Trig_qweqbmzad15_Conditions takes nothing returns boolean
return((IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetPlayerController(GetOwningPlayer(GetTriggerUnit()))==MAP_CONTROL_USER)and(IsUnitEnemy(GetEventDamageSource(),GetOwningPlayer(GetTriggerUnit()))))!=null
endfunction
function Trig_qweqbmzad15_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call UnitDamageTarget(GetTriggerUnit(),GetEventDamageSource(),(GetEventDamage()*5.00),true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL,WEAPON_TYPE_WHOKNOWS)
call EnableTrigger(GetTriggeringTrigger())
endfunction
function InitTrig_qweqbmzad15 takes nothing returns nothing
set gg_trg_qweqbmzad15=CreateTrigger()
call TriggerAddCondition(gg_trg_qweqbmzad15,Condition(function Trig_qweqbmzad15_Conditions))
call TriggerAddAction(gg_trg_qweqbmzad15,function Trig_qweqbmzad15_Actions)
endfunction
// 英雄被杀死瞬间自动复活
function Trig_qweqbmzad16_Conditions takes nothing returns boolean
return((IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetPlayerController(GetOwningPlayer(GetTriggerUnit()))==MAP_CONTROL_USER))!=null
endfunction
function Trig_qweqbmzad16_Actions takes nothing returns nothing
set udg_dliubo=GetTriggerUnit()
set udg_pliubo=GetUnitLoc(GetTriggerUnit())
set udg_jliubo=GetLastCreatedTimerDialogBJ()
call PolledWait(0.00)
call ReviveHeroLoc(udg_dliubo,udg_pliubo,false) // 立即复活
call RemoveLocation(udg_pliubo)
call DestroyTimerDialog(udg_jliubo)
endfunction
function InitTrig_qweqbmzad16 takes nothing returns nothing
set gg_trg_qweqbmzad16=CreateTrigger()
call DisableTrigger(gg_trg_qweqbmzad16)
call TriggerRegisterAnyUnitEventBJ(gg_trg_qweqbmzad16,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddCondition(gg_trg_qweqbmzad16,Condition(function Trig_qweqbmzad16_Conditions))
call TriggerAddAction(gg_trg_qweqbmzad16,function Trig_qweqbmzad16_Actions)
endfunction
// 自杀
function Trig_qweqbmzad17_Func001001002 takes nothing returns boolean
return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO))!=null
endfunction
function Trig_qweqbmzad17_Func001A takes nothing returns nothing
call KillUnit(GetEnumUnit())
endfunction
function Trig_qweqbmzad17_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsOfPlayerMatching(GetTriggerPlayer(),Condition(function Trig_qweqbmzad17_Func001001002)),function Trig_qweqbmzad17_Func001A)
endfunction
function InitTrig_qweqbmzad17 takes nothing returns nothing
set gg_trg_qweqbmzad17=CreateTrigger()
call DisableTrigger(gg_trg_qweqbmzad17)
call TriggerRegisterPlayerChatEvent(gg_trg_qweqbmzad17,Player(0),"我要自杀",true)
call TriggerRegisterPlayerChatEvent(gg_trg_qweqbmzad17,Player(1),"我要自杀",true)
call TriggerRegisterPlayerChatEvent(gg_trg_qweqbmzad17,Player(2),"我要自杀",true)
call TriggerRegisterPlayerChatEvent(gg_trg_qweqbmzad17,Player(3),"我要自杀",true)
call TriggerRegisterPlayerChatEvent(gg_trg_qweqbmzad17,Player(4),"我要自杀",true)
call TriggerRegisterPlayerChatEvent(gg_trg_qweqbmzad17,Player(5),"我要自杀",true)
call TriggerRegisterPlayerChatEvent(gg_trg_qweqbmzad17,Player(6),"我要自杀",true)
call TriggerRegisterPlayerChatEvent(gg_trg_qweqbmzad17,Player(7),"我要自杀",true)
call TriggerAddAction(gg_trg_qweqbmzad17,function Trig_qweqbmzad17_Actions)
endfunction
// 施放技能时自动清CD 自动恢复满生命魔法并自动除去负面BUF
function Trig_qweqbmzad11_Conditions takes nothing returns boolean
if(not(GetPlayerController(GetTriggerPlayer())==MAP_CONTROL_USER))then
return false
endif
return true
endfunction
function Trig_qweqbmzad11_Actions takes nothing returns nothing
call PolledWait(0.01)
call UnitResetCooldown(GetTriggerUnit())
call UnitRemoveBuffs(GetTriggerUnit(),false,true)
call SetUnitManaBJ(GetTriggerUnit(),GetUnitState(GetTriggerUnit(),UNIT_STATE_MAX_MANA))
call SetUnitLifeBJ(GetTriggerUnit(),GetUnitState(GetTriggerUnit(),UNIT_STATE_MAX_LIFE))
call SetUnitMoveSpeed(GetTriggerUnit(),622.)
call SetUnitPathing(GetTriggerUnit(),false)
endfunction
function InitTrig_qweqbmzad11 takes nothing returns nothing
set gg_trg_qweqbmzad11=CreateTrigger()
call DisableTrigger(gg_trg_qweqbmzad11)
call TriggerRegisterAnyUnitEventBJ(gg_trg_qweqbmzad11,EVENT_PLAYER_UNIT_SPELL_EFFECT)
call TriggerAddCondition(gg_trg_qweqbmzad11, Condition(function Trig_qweqbmzad11_Conditions))
call TriggerAddAction(gg_trg_qweqbmzad11, function Trig_qweqbmzad11_Actions)
endfunction
// 杀死怪物时100%获得的经验
function Trig_qweqbmzad7_Conditions takes nothing returns boolean
return((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO))and(GetPlayerController(GetOwningPlayer(GetKillingUnitBJ()))==MAP_CONTROL_USER))!=null
endfunction
function Trig_qweqbmzad7_Func001C takes nothing returns boolean
return(GetRandomInt(1,10)==5)
endfunction
function Trig_qweqbmzad7_Actions takes nothing returns nothing
if(Trig_qweqbmzad7_Func001C())then
call PolledWait(0.)
call AddHeroXP(GetKillingUnitBJ(),(100*GetUnitLevel(GetTriggerUnit())),false) // 经验是100乘于怪物的等级（但是有延时4秒）
endif
endfunction
function InitTrig_qweqbmzad7 takes nothing returns nothing
set gg_trg_qweqbmzad7=CreateTrigger()
call DisableTrigger(gg_trg_qweqbmzad7)
call TriggerRegisterAnyUnitEventBJ(gg_trg_qweqbmzad7,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddCondition(gg_trg_qweqbmzad7,Condition(function Trig_qweqbmzad7_Conditions))
call TriggerAddAction(gg_trg_qweqbmzad7,function Trig_qweqbmzad7_Actions)
endfunction
// 杀死怪物时随机获得怪物的三围
function Trig_qweqbmzad8_Conditions takes nothing returns boolean
return((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO))and(GetPlayerController(GetOwningPlayer(GetKillingUnitBJ()))==MAP_CONTROL_USER))!=null
endfunction
function Trig_qweqbmzad8_Func003C takes nothing returns boolean
return(GetRandomInt(1,10)==5)  // >=1 为百分百
endfunction
function Trig_qweqbmzad8_Actions takes nothing returns nothing
if(Trig_qweqbmzad8_Func003C())then
call PolledWait(0.)
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,GetUnitLevel(GetTriggerUnit()))
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,GetUnitLevel(GetTriggerUnit()))
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,GetUnitLevel(GetTriggerUnit()))
endif
endfunction
function InitTrig_qweqbmzad8 takes nothing returns nothing
set gg_trg_qweqbmzad8=CreateTrigger()
call DisableTrigger(gg_trg_qweqbmzad8)
call TriggerRegisterAnyUnitEventBJ(gg_trg_qweqbmzad8,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddCondition(gg_trg_qweqbmzad8,Condition(function Trig_qweqbmzad8_Conditions))
call TriggerAddAction(gg_trg_qweqbmzad8,function Trig_qweqbmzad8_Actions)
endfunction
function Trig_qweqbmzad9_Func002C takes nothing returns boolean
return(GetPlayerController(Player(0))==MAP_CONTROL_USER)or(GetPlayerController(Player(1))==MAP_CONTROL_USER)or(GetPlayerController(Player(2))==MAP_CONTROL_USER)or(GetPlayerController(Player(3))==MAP_CONTROL_USER)
endfunction
function Trig_qweqbmzad9_Func005C takes nothing returns boolean
return(IsUnitAlly(GetTriggerUnit(),Player(0)))or(IsUnitAlly(GetTriggerUnit(),Player(1)))or(IsUnitAlly(GetTriggerUnit(),Player(2)))or(IsUnitAlly(GetTriggerUnit(),Player(3)))
endfunction
function Trig_qweqbmzad9_Func006C takes nothing returns boolean
return(GetPlayerController(GetOwningPlayer(GetAttacker()))==MAP_CONTROL_COMPUTER)or(GetPlayerController(GetOwningPlayer(GetAttacker()))==MAP_CONTROL_CREEP)
endfunction
function Trig_qweqbmzad9_Conditions takes nothing returns boolean
return(Trig_qweqbmzad9_Func002C())and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_STRUCTURE))and(GetPlayerController(GetOwningPlayer(GetTriggerUnit()))==MAP_CONTROL_COMPUTER)and(Trig_qweqbmzad9_Func005C())and(Trig_qweqbmzad9_Func006C())
endfunction
function Trig_qweqbmzad9_Actions takes nothing returns nothing
set udg_uliubo[1]=GetTriggerUnit()
call SetUnitInvulnerable(udg_uliubo[1],true)
endfunction
function Trig_qweqbmzad20_Func002C takes nothing returns boolean
return(GetPlayerController(Player(0))==MAP_CONTROL_USER)or(GetPlayerController(Player(1))==MAP_CONTROL_USER)or(GetPlayerController(Player(2))==MAP_CONTROL_USER)or(GetPlayerController(Player(3))==MAP_CONTROL_USER)
endfunction
function Trig_qweqbmzad20_Func005C takes nothing returns boolean
return(IsUnitAlly(GetAttacker(),Player(0)))or(IsUnitAlly(GetAttacker(),Player(1)))or(IsUnitAlly(GetAttacker(),Player(2)))or(IsUnitAlly(GetAttacker(),Player(3)))
endfunction
function Trig_qweqbmzad20_Func006C takes nothing returns boolean
return(GetPlayerController(GetOwningPlayer(GetAttackedUnitBJ()))==MAP_CONTROL_COMPUTER)or(GetPlayerController(GetOwningPlayer(GetAttackedUnitBJ()))==MAP_CONTROL_CREEP)
endfunction
function Trig_qweqbmzad20_Conditions takes nothing returns boolean
return(Trig_qweqbmzad20_Func002C())and(IsUnitType(GetAttacker(),UNIT_TYPE_STRUCTURE))and(GetPlayerController(GetOwningPlayer(GetAttacker()))==MAP_CONTROL_COMPUTER)and(Trig_qweqbmzad20_Func005C())and(Trig_qweqbmzad20_Func006C())
endfunction
function Trig_qweqbmzad20_Actions takes nothing returns nothing
set udg_uliubo[1]=GetAttacker()
call SetUnitInvulnerable(udg_uliubo[1],false)
endfunction
// 英雄升级额外增加10木头
function Trig_qweqbmzad4_Conditions takes nothing returns boolean
return(GetRandomInt(1,20)==10)  // >=1 为百分百
endfunction
function Trig_qweqbmzad4_Actions takes nothing returns nothing
call PolledWait(0.00)
call AdjustPlayerStateBJ(10,GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_LUMBER)
endfunction
function InitTrig_qweqbmzad4 takes nothing returns nothing
set gg_trg_qweqbmzad4=CreateTrigger()
call DisableTrigger(gg_trg_qweqbmzad4)
call TriggerRegisterAnyUnitEventBJ(gg_trg_qweqbmzad4,EVENT_PLAYER_HERO_LEVEL)
call TriggerAddCondition(gg_trg_qweqbmzad4,Condition(function Trig_qweqbmzad4_Conditions))
call TriggerAddAction(gg_trg_qweqbmzad4,function Trig_qweqbmzad4_Actions)
endfunction
// 释放技能时随机增加50-1000金钱
function Trig_qweqbmzad5_Func003C takes nothing returns boolean
return(GetRandomInt(1,100)==35)  // >=1 为百分百
endfunction
function Trig_qweqbmzad5_Actions takes nothing returns nothing
set udg_qmzada=GetUnitAbilityLevel(GetTriggerUnit(),GetSpellAbilityId())
set udg_qmzadb=GetRandomInt(50,1000)
if(Trig_qweqbmzad5_Func003C())then
call PolledWait(0.00)
call AdjustPlayerStateBJ((udg_qmzada*udg_qmzadb),GetOwningPlayer(GetSpellAbilityUnit()),PLAYER_STATE_RESOURCE_GOLD)
endif
endfunction
function InitTrig_qweqbmzad5 takes nothing returns nothing
set gg_trg_qweqbmzad5=CreateTrigger()
call DisableTrigger(gg_trg_qweqbmzad5)
call TriggerRegisterAnyUnitEventBJ(gg_trg_qweqbmzad5,EVENT_PLAYER_UNIT_SPELL_EFFECT)
call TriggerAddAction(gg_trg_qweqbmzad5,function Trig_qweqbmzad5_Actions)
endfunction
// 爆随机物品
function Trig_qweqbmzad6_Func001C takes nothing returns boolean
return(GetRandomInt(1,100)==65)   // >=1 为百分百
endfunction
function Trig_qweqbmzad6_Actions takes nothing returns nothing
if(Trig_qweqbmzad6_Func001C())then
call PolledWait(0.00)
call UnitAddItemByIdSwapped(ChooseRandomItemBJ(-1),GetTriggerUnit())
call UnitAddItemByIdSwapped(ChooseRandomItemBJ(-1),GetTriggerUnit())
call UnitAddItemByIdSwapped(ChooseRandomItemBJ(-1),GetTriggerUnit())
call UnitAddItemByIdSwapped(ChooseRandomItemBJ(-1),GetTriggerUnit())
call UnitAddItemByIdSwapped(ChooseRandomItemBJ(-1),GetTriggerUnit())
call UnitAddItemByIdSwapped(ChooseRandomItemBJ(-1),GetTriggerUnit())
call UnitAddItemByIdSwapped(ChooseRandomItemBJ(-1),GetTriggerUnit())
call UnitAddItemByIdSwapped(ChooseRandomItemBJ(-1),GetTriggerUnit())
call UnitAddItemByIdSwapped(ChooseRandomItemBJ(-1),GetTriggerUnit())
call UnitAddItemByIdSwapped(ChooseRandomItemBJ(-1),GetTriggerUnit())
endif
endfunction
function InitTrig_qweqbmzad6 takes nothing returns nothing
set gg_trg_qweqbmzad6=CreateTrigger()
call DisableTrigger(gg_trg_qweqbmzad6)
call TriggerRegisterAnyUnitEventBJ(gg_trg_qweqbmzad6,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddAction(gg_trg_qweqbmzad6,function Trig_qweqbmzad6_Actions)
endfunction
// 清除物品
function Trig_qweqbmzad10_Func002A takes nothing returns nothing
call RemoveItem(GetEnumItem())
endfunction
function Trig_qweqbmzad10_Actions takes nothing returns nothing
call EnumItemsInRectBJ(GetPlayableMapRect(),function Trig_qweqbmzad10_Func002A)
call DisplayTextToForce(GetPlayersAll(), "|cFF6633CC每|r|cFF4C36D9过|r|cFF333AE31|r|cFF1A3EF2分|r|cFF0041FF钟|r|cFF076AED自|r|cFF0E94DC动|r|cFF14BDCA清|r|cFF1BE6B8理|r|cFF29ACAA地|r|cFF4C36D9面|r")
endfunction
function InitTrig_qweqbmzad10 takes nothing returns nothing
set gg_trg_qweqbmzad10=CreateTrigger()
call DisableTrigger(gg_trg_qweqbmzad10)
call TriggerRegisterTimerEventPeriodic(gg_trg_qweqbmzad10,60.00)
call TriggerAddAction(gg_trg_qweqbmzad10,function Trig_qweqbmzad10_Actions)
endfunction
// 移速、碰撞、生命、魔法
function Trig_qweqbmzad2_Func002001002 takes nothing returns boolean
return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO))!=null
endfunction
function Trig_qweqbmzad2_Func002A takes nothing returns nothing
call SetUnitLifeBJ(GetEnumUnit(),GetUnitState(GetEnumUnit(),UNIT_STATE_LIFE))
call SetUnitManaBJ(GetEnumUnit(),GetUnitState(GetEnumUnit(),UNIT_STATE_MANA))
call SetUnitMoveSpeed(GetEnumUnit(),GetUnitDefaultMoveSpeed(GetEnumUnit()))
call SetUnitPathing(GetEnumUnit(),true)
endfunction
// 关闭脚本
function Trig_qweqbmzad2_Actions takes nothing returns nothing
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+" |cFF6633CC为|r|cFF4C36D9大|r|cFF333AE6家|r|cFF1A3EF2关|r|cFF0041FF闭|r|cFF076AED了|r|cFF0E94DC单|r|cFF14BDCA位|r|cFF1BE6B8无|r|cFF29ACAA忧|r"))
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+" |cFF6633CC关|r|cFF4C36D9闭|r|cFF333AE6了|r|cFF076AED自|r|cFF0E94DC动|r|cFF14BDCA清|r|cFF1BE6B8理|r"))
call DisplayTextToForce(GetPlayersAll(), "|cFF6633CC基|r|cFF4C36D9地|r|cFF333AE6无|r|cFF1A3EF2敌|r|cFF0041FF功|r|cFF076AED能|r|cFF4C36D9已|r|cFF14BDCA关|r|cFF1BE6B8闭|r|cFF29ACAA！|r|cFF4C36D9注|r|cFF6633CC意|r|cFF4C36D9只|r|cFF333AE6能|r|cFF1A3EF2关|r|cFF0041FF闭|r|cFF6633CC能|r|cFF4C36D9攻|r|cFF333AE6击|r|cFF1A3EF2怪|r|cFF4C36D9物|r|cFF333AE6的|r|cFF1A3EF2基|r|cFF0041FF地|r")
call DisableTrigger(gg_trg_qweqbmzad11)
call DisableTrigger(gg_trg_qweqbmzad7)
call DisableTrigger(gg_trg_qweqbmzad16)
call DisableTrigger(gg_trg_qweqbmzad17)
call DisableTrigger(gg_trg_qweqbmzad8)
call DisableTrigger(gg_trg_qweqbmzad4)
call DisableTrigger(gg_trg_qweqbmzad5)
call DisableTrigger(gg_trg_qweqbmzad6)
call DisableTrigger(gg_trg_qweqbmzad10)
call DisableTrigger(gg_trg_qweqbmzad12)
call DisableTrigger(gg_trg_qweqbmzad9)
call EnableTrigger(gg_trg_qweqbmzad20)
call DisableTrigger(gg_trg_qweqbmzad2)
call EnableTrigger(gg_trg_qweqbmzad1)
call FogEnableOn()
call FogMaskEnableOn()
call ForGroupBJ(GetUnitsOfPlayerMatching(Player(0),Condition(function Trig_qweqbmzad2_Func002001002)),function Trig_qweqbmzad2_Func002A)
call ForGroupBJ(GetUnitsOfPlayerMatching(Player(1),Condition(function Trig_qweqbmzad2_Func002001002)),function Trig_qweqbmzad2_Func002A)
call ForGroupBJ(GetUnitsOfPlayerMatching(Player(2),Condition(function Trig_qweqbmzad2_Func002001002)),function Trig_qweqbmzad2_Func002A)
call ForGroupBJ(GetUnitsOfPlayerMatching(Player(3),Condition(function Trig_qweqbmzad2_Func002001002)),function Trig_qweqbmzad2_Func002A)
call ForGroupBJ(GetUnitsOfPlayerMatching(Player(4),Condition(function Trig_qweqbmzad2_Func002001002)),function Trig_qweqbmzad2_Func002A)
call ForGroupBJ(GetUnitsOfPlayerMatching(Player(5),Condition(function Trig_qweqbmzad2_Func002001002)),function Trig_qweqbmzad2_Func002A)
call ForGroupBJ(GetUnitsOfPlayerMatching(Player(6),Condition(function Trig_qweqbmzad2_Func002001002)),function Trig_qweqbmzad2_Func002A)
call ForGroupBJ(GetUnitsOfPlayerMatching(Player(7),Condition(function Trig_qweqbmzad2_Func002001002)),function Trig_qweqbmzad2_Func002A)
endfunction
function InitTrig_qweqbmzad2 takes nothing returns nothing
set gg_trg_qweqbmzad2=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_qweqbmzad2,Player(0),"魔界重生",true)
call TriggerRegisterPlayerChatEvent(gg_trg_qweqbmzad2,Player(1),"魔界重生",true)
call TriggerRegisterPlayerChatEvent(gg_trg_qweqbmzad2,Player(2),"魔界重生",true)
call TriggerRegisterPlayerChatEvent(gg_trg_qweqbmzad2,Player(3),"魔界重生",true)
call TriggerRegisterPlayerChatEvent(gg_trg_qweqbmzad2,Player(4),"魔界重生",true)
call TriggerRegisterPlayerChatEvent(gg_trg_qweqbmzad2,Player(5),"魔界重生",true)
call TriggerRegisterPlayerChatEvent(gg_trg_qweqbmzad2,Player(6),"魔界重生",true)
call TriggerRegisterPlayerChatEvent(gg_trg_qweqbmzad2,Player(7),"魔界重生",true)
call TriggerAddAction(gg_trg_qweqbmzad2,function Trig_qweqbmzad2_Actions)
endfunction