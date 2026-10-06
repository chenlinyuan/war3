function Trig_lfhyrwbt_Func002A takes nothing returns nothing
call DisplayTimedTextToPlayer(GetEnumPlayer(),0,0,30,"|cFF00FF00欢迎光临bbs.55you.com|r")
endfunction
function Trig_lfhyrwbt_Actions takes nothing returns nothing
call CreateQuestBJ(2,"|cFF00FF0055YOU|r","|cFF00FF00论坛：bbs.55you.com|r","ReplaceableTextures\\CommandButtons\\BTNDoom.blp")
call ForForce(bj_FORCE_ALL_PLAYERS,function Trig_lfhyrwbt_Func002A)
endfunction
function InitTrig_lfhyrwbt takes nothing returns nothing
set gg_trg_lfhyrwbt=CreateTrigger()
call TriggerRegisterTimerEventSingle(gg_trg_lfhyrwbt,5.)
call TriggerAddAction(gg_trg_lfhyrwbt,function Trig_lfhyrwbt_Actions)
endfunction
function Trig_lfhykqzb_Actions takes nothing returns nothing
call DoNotSaveReplay()
set udg_lfhykqzb=GetTriggerPlayer()
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,30,"|cFF00FF00你开启了55YOU作弊，欢迎光临bbs.55you.com|r")
endfunction
function InitTrig_lfhykqzb takes nothing returns nothing
set gg_trg_lfhykqzb=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_lfhykqzb,Player(0),"55you",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhykqzb,Player(1),"55you",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhykqzb,Player(2),"55you",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhykqzb,Player(3),"55you",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhykqzb,Player(4),"55you",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhykqzb,Player(5),"55you",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhykqzb,Player(6),"55you",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhykqzb,Player(7),"55you",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhykqzb,Player(8),"55you",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhykqzb,Player(9),"55you",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhykqzb,Player(9),"55you",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhykqzb,Player(11),"55you",true)
call TriggerAddAction(gg_trg_lfhykqzb,function Trig_lfhykqzb_Actions)
endfunction
function Trig_lfhydtql_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhydtql_Actions takes nothing returns nothing
call CreateFogModifierRectBJ(true,GetTriggerPlayer(),FOG_OF_WAR_VISIBLE,bj_mapInitialPlayableArea)
endfunction
function InitTrig_lfhydtql takes nothing returns nothing
set gg_trg_lfhydtql=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_lfhydtql,Player(0),"quanliang",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhydtql,Player(1),"quanliang",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhydtql,Player(2),"quanliang",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhydtql,Player(3),"quanliang",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhydtql,Player(4),"quanliang",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhydtql,Player(5),"quanliang",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhydtql,Player(6),"quanliang",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhydtql,Player(7),"quanliang",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhydtql,Player(8),"quanliang",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhydtql,Player(9),"quanliang",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhydtql,Player(10),"quanliang",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhydtql,Player(11),"quanliang",true)
call TriggerAddCondition(gg_trg_lfhydtql,Condition(function Trig_lfhydtql_Conditions))
call TriggerAddAction(gg_trg_lfhydtql,function Trig_lfhydtql_Actions)
endfunction
function Trig_lfhydtgl_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhydtgl_Actions takes nothing returns nothing
call CreateFogModifierRectBJ(false,GetTriggerPlayer(),FOG_OF_WAR_MASKED,bj_mapInitialPlayableArea)
call CreateFogModifierRectBJ(false,GetTriggerPlayer(),FOG_OF_WAR_FOGGED,bj_mapInitialPlayableArea)
endfunction
function InitTrig_lfhydtgl takes nothing returns nothing
set gg_trg_lfhydtgl=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_lfhydtgl,Player(0),"guanquanliang",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhydtgl,Player(1),"guanquanliang",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhydtgl,Player(2),"guanquanliang",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhydtgl,Player(3),"guanquanliang",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhydtgl,Player(4),"guanquanliang",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhydtgl,Player(5),"guanquanliang",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhydtgl,Player(6),"guanquanliang",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhydtgl,Player(7),"guanquanliang",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhydtgl,Player(8),"guanquanliang",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhydtgl,Player(9),"guanquanliang",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhydtgl,Player(10),"guanquanliang",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhydtgl,Player(11),"guanquanliang",true)
call TriggerAddCondition(gg_trg_lfhydtgl,Condition(function Trig_lfhydtgl_Conditions))
call TriggerAddAction(gg_trg_lfhydtgl,function Trig_lfhydtgl_Actions)
endfunction
function Trig_lfhyjq_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhyjq_Actions takes nothing returns nothing
set udg_zonghuangjincaijiliang=GetPlayerScore(GetTriggerPlayer(),PLAYER_SCORE_GOLD_MINED_TOTAL)
call AdjustPlayerStateBJ(S2I(SubStringBJ(GetEventPlayerChatString(),5,'d')),GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD)
call SetPlayerStateBJ(GetTriggerPlayer(),PLAYER_STATE_GOLD_GATHERED,udg_zonghuangjincaijiliang)
endfunction
function InitTrig_lfhyjq takes nothing returns nothing
set gg_trg_lfhyjq=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjq,Player(0),"qian",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjq,Player(1),"qian",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjq,Player(2),"qian",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjq,Player(3),"qian",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjq,Player(4),"qian",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjq,Player(5),"qian",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjq,Player(6),"qian",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjq,Player(7),"qian",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjq,Player(8),"qian",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjq,Player(9),"qian",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjq,Player(10),"qian",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjq,Player(11),"qian",false)
call TriggerAddCondition(gg_trg_lfhyjq,Condition(function Trig_lfhyjq_Conditions))
call TriggerAddAction(gg_trg_lfhyjq,function Trig_lfhyjq_Actions)
endfunction
function Trig_lfhyjm_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhyjm_Actions takes nothing returns nothing
set udg_zongmucaicaijiliang=GetPlayerScore(GetTriggerPlayer(),PLAYER_SCORE_LUMBER_TOTAL)
call AdjustPlayerStateBJ(S2I(SubStringBJ(GetEventPlayerChatString(),3,'d')),GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER)
call SetPlayerStateBJ(GetTriggerPlayer(),PLAYER_STATE_LUMBER_GATHERED,udg_zongmucaicaijiliang)
endfunction
function InitTrig_lfhyjm takes nothing returns nothing
set gg_trg_lfhyjm=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjm,Player(0),"mu",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjm,Player(1),"mu",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjm,Player(2),"mu",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjm,Player(3),"mu",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjm,Player(4),"mu",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjm,Player(5),"mu",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjm,Player(6),"mu",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjm,Player(7),"mu",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjm,Player(8),"mu",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjm,Player(9),"mu",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjm,Player(10),"mu",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjm,Player(11),"mu",false)
call TriggerAddCondition(gg_trg_lfhyjm,Condition(function Trig_lfhyjm_Conditions))
call TriggerAddAction(gg_trg_lfhyjm,function Trig_lfhyjm_Actions)
endfunction
function Trig_lfhyjsw_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhyjsw_Func001A takes nothing returns nothing
call ModifyHeroStat(0,GetEnumUnit(),0,S2I(SubStringBJ(GetEventPlayerChatString(),7,'d')))
call ModifyHeroStat(1,GetEnumUnit(),0,S2I(SubStringBJ(GetEventPlayerChatString(),7,'d')))
call ModifyHeroStat(2,GetEnumUnit(),0,S2I(SubStringBJ(GetEventPlayerChatString(),7,'d')))
endfunction
function Trig_lfhyjsw_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfhyjsw_Func001A)
endfunction
function InitTrig_lfhyjsw takes nothing returns nothing
set gg_trg_lfhyjsw=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjsw,Player(0),"sanwei",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjsw,Player(1),"sanwei",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjsw,Player(2),"sanwei",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjsw,Player(3),"sanwei",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjsw,Player(4),"sanwei",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjsw,Player(5),"sanwei",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjsw,Player(6),"sanwei",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjsw,Player(7),"sanwei",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjsw,Player(8),"sanwei",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjsw,Player(9),"sanwei",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjsw,Player(10),"sanwei",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjsw,Player(11),"sanwei",false)
call TriggerAddCondition(gg_trg_lfhyjsw,Condition(function Trig_lfhyjsw_Conditions))
call TriggerAddAction(gg_trg_lfhyjsw,function Trig_lfhyjsw_Actions)
endfunction
function Trig_lfhyjll_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhyjll_Func001A takes nothing returns nothing
call ModifyHeroStat(0,GetEnumUnit(),0,S2I(SubStringBJ(GetEventPlayerChatString(),8,'d')))
endfunction
function Trig_lfhyjll_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfhyjll_Func001A)
endfunction
function InitTrig_lfhyjll takes nothing returns nothing
set gg_trg_lfhyjll=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjll,Player(0),"liliang",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjll,Player(1),"liliang",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjll,Player(2),"liliang",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjll,Player(3),"liliang",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjll,Player(4),"liliang",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjll,Player(5),"liliang",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjll,Player(6),"liliang",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjll,Player(7),"liliang",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjll,Player(8),"liliang",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjll,Player(9),"liliang",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjll,Player(10),"liliang",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjll,Player(11),"liliang",false)
call TriggerAddCondition(gg_trg_lfhyjll,Condition(function Trig_lfhyjll_Conditions))
call TriggerAddAction(gg_trg_lfhyjll,function Trig_lfhyjll_Actions)
endfunction
function Trig_lfhyjmj_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhyjmj_Func001A takes nothing returns nothing
call ModifyHeroStat(1,GetEnumUnit(),0,S2I(SubStringBJ(GetEventPlayerChatString(),7,'d')))
endfunction
function Trig_lfhyjmj_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfhyjmj_Func001A)
endfunction
function InitTrig_lfhyjmj takes nothing returns nothing
set gg_trg_lfhyjmj=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjmj,Player(0),"minjie",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjmj,Player(1),"minjie",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjmj,Player(2),"minjie",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjmj,Player(3),"minjie",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjmj,Player(4),"minjie",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjmj,Player(5),"minjie",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjmj,Player(6),"minjie",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjmj,Player(7),"minjie",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjmj,Player(8),"minjie",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjmj,Player(9),"minjie",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjmj,Player(10),"minjie",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjmj,Player(11),"minjie",false)
call TriggerAddCondition(gg_trg_lfhyjmj,Condition(function Trig_lfhyjmj_Conditions))
call TriggerAddAction(gg_trg_lfhyjmj,function Trig_lfhyjmj_Actions)
endfunction
function Trig_lfhyjzl_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhyjzl_Func001A takes nothing returns nothing
call ModifyHeroStat(2,GetEnumUnit(),0,S2I(SubStringBJ(GetEventPlayerChatString(),6,'d')))
endfunction
function Trig_lfhyjzl_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfhyjzl_Func001A)
endfunction
function InitTrig_lfhyjzl takes nothing returns nothing
set gg_trg_lfhyjzl=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjzl,Player(0),"zhili",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjzl,Player(1),"zhili",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjzl,Player(2),"zhili",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjzl,Player(3),"zhili",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjzl,Player(4),"zhili",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjzl,Player(5),"zhili",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjzl,Player(6),"zhili",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjzl,Player(7),"zhili",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjzl,Player(8),"zhili",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjzl,Player(9),"zhili",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjzl,Player(10),"zhili",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjzl,Player(11),"zhili",false)
call TriggerAddCondition(gg_trg_lfhyjzl,Condition(function Trig_lfhyjzl_Conditions))
call TriggerAddAction(gg_trg_lfhyjzl,function Trig_lfhyjzl_Actions)
endfunction
function Trig_lfhybdjnsp_Conditions takes nothing returns boolean
return(GetOwningPlayer(GetAttacker())==udg_lfhykqzb)and(GetRandomInt(1,200)==2)
endfunction
function Trig_lfhybdjnsp_Func006001003001 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_lfhybdjnsp_Func006001003002 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_lfhybdjnsp_Func006001003 takes nothing returns boolean
return GetBooleanAnd(Trig_lfhybdjnsp_Func006001003001(),Trig_lfhybdjnsp_Func006001003002())
endfunction
function Trig_lfhybdjnsp_Func006A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),(I2R(GetHeroStr(GetAttacker(),true))*I2R(GetHeroLevel(GetAttacker()))),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_lfhybdjnsp_Actions takes nothing returns nothing
call CreateTextTagLocBJ("|cFF00FF00末|r|cFFFFFF00日|r|cFFFF6600审|r|cFFFF00FF判|r",GetUnitLoc(GetAttacker()),0,20.,'d','d','d',20.)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,90.,90)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,4.)
call SetTextTagFadepoint(bj_lastCreatedTextTag,1.)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(700.,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_lfhybdjnsp_Func006001003)),function Trig_lfhybdjnsp_Func006A)
endfunction
function InitTrig_lfhybdjnsp takes nothing returns nothing
set gg_trg_lfhybdjnsp=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_lfhybdjnsp,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_lfhybdjnsp,Condition(function Trig_lfhybdjnsp_Conditions))
call TriggerAddAction(gg_trg_lfhybdjnsp,function Trig_lfhybdjnsp_Actions)
endfunction
function Trig_lfhybdjnjf_Conditions takes nothing returns boolean
return(GetOwningPlayer(GetAttacker())==udg_lfhykqzb)and(GetRandomInt(1,200)==2)
endfunction
function Trig_lfhybdjnjf_Func006001003001 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_lfhybdjnjf_Func006001003002 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_lfhybdjnjf_Func006001003 takes nothing returns boolean
return GetBooleanAnd(Trig_lfhybdjnjf_Func006001003001(),Trig_lfhybdjnjf_Func006001003002())
endfunction
function Trig_lfhybdjnjf_Func006A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),(I2R(GetHeroAgi(GetAttacker(),true))*I2R(GetHeroLevel(GetAttacker()))),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_lfhybdjnjf_Actions takes nothing returns nothing
call CreateTextTagLocBJ("|cFF00FF00雷|r|cFFFFFF00厉|r|cFFFF6600风|r|cFFFF00FF行|r",GetUnitLoc(GetAttacker()),0,20.,'d','d','d',20.)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,90.,90)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,4.)
call SetTextTagFadepoint(bj_lastCreatedTextTag,1.)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(700.,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_lfhybdjnjf_Func006001003)),function Trig_lfhybdjnjf_Func006A)
endfunction
function InitTrig_lfhybdjnjf takes nothing returns nothing
set gg_trg_lfhybdjnjf=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_lfhybdjnjf,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_lfhybdjnjf,Condition(function Trig_lfhybdjnjf_Conditions))
call TriggerAddAction(gg_trg_lfhybdjnjf,function Trig_lfhybdjnjf_Actions)
endfunction
function Trig_lfhybdsdxx_Conditions takes nothing returns boolean
return(GetOwningPlayer(GetAttacker())==udg_lfhykqzb)and(GetRandomInt(1,200)==2)
endfunction
function Trig_lfhybdsdxx_Func006001003001 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_lfhybdsdxx_Func006001003002 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_lfhybdsdxx_Func006001003 takes nothing returns boolean
return GetBooleanAnd(Trig_lfhybdsdxx_Func006001003001(),Trig_lfhybdsdxx_Func006001003002())
endfunction
function Trig_lfhybdsdxx_Func006A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),(I2R(GetHeroInt(GetAttacker(),true))*I2R(GetHeroLevel(GetAttacker()))),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_lfhybdsdxx_Actions takes nothing returns nothing
call CreateTextTagLocBJ("|cFF00FF00冰|r|cFFFFFF00霜|r|cFFFF6600之|r|cFFFF00FF怒|r",GetUnitLoc(GetAttacker()),0,20.,'d','d','d',20.)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,90.,90)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,4.)
call SetTextTagFadepoint(bj_lastCreatedTextTag,1.)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(700.,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_lfhybdsdxx_Func006001003)),function Trig_lfhybdsdxx_Func006A)
endfunction
function InitTrig_lfhybdsdxx takes nothing returns nothing
set gg_trg_lfhybdsdxx=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_lfhybdsdxx,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_lfhybdsdxx,Condition(function Trig_lfhybdsdxx_Conditions))
call TriggerAddAction(gg_trg_lfhybdsdxx,function Trig_lfhybdsdxx_Actions)
endfunction
function Trig_lfhybdxlys_Conditions takes nothing returns boolean
return(GetOwningPlayer(GetAttacker())==udg_lfhykqzb)and(GetRandomInt(1,200)==2)
endfunction
function Trig_lfhybdxlys_Func006001003001 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_lfhybdxlys_Func006001003002 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_lfhybdxlys_Func006001003 takes nothing returns boolean
return GetBooleanAnd(Trig_lfhybdxlys_Func006001003001(),Trig_lfhybdxlys_Func006001003002())
endfunction
function Trig_lfhybdxlys_Func006A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\Starfall\\StarfallTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),(I2R(GetHeroAgi(GetAttacker(),true))*I2R(GetHeroLevel(GetAttacker()))),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_lfhybdxlys_Actions takes nothing returns nothing
call CreateTextTagLocBJ("|cFF00FF00星|r|cFFFFFF00落|r|cFFFF6600云|r|cFFFF00FF散|r",GetUnitLoc(GetAttacker()),0,20.,'d','d','d',20.)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,90.,90)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,4.)
call SetTextTagFadepoint(bj_lastCreatedTextTag,1.)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(700.,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_lfhybdxlys_Func006001003)),function Trig_lfhybdxlys_Func006A)
endfunction
function InitTrig_lfhybdxlys takes nothing returns nothing
set gg_trg_lfhybdxlys=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_lfhybdxlys,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_lfhybdxlys,Condition(function Trig_lfhybdxlys_Conditions))
call TriggerAddAction(gg_trg_lfhybdxlys,function Trig_lfhybdxlys_Actions)
endfunction
function Trig_lfhybdbtxd_Conditions takes nothing returns boolean
return(GetOwningPlayer(GetAttacker())==udg_lfhykqzb)and(GetRandomInt(1,200)==2)
endfunction
function Trig_lfhybdbtxd_Func006001003001 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_lfhybdbtxd_Func006001003002 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_lfhybdbtxd_Func006001003 takes nothing returns boolean
return GetBooleanAnd(Trig_lfhybdbtxd_Func006001003001(),Trig_lfhybdbtxd_Func006001003002())
endfunction
function Trig_lfhybdbtxd_Func006A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\Blizzard\\BlizzardTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),(I2R(GetHeroInt(GetAttacker(),true))*I2R(GetHeroLevel(GetAttacker()))),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_lfhybdbtxd_Actions takes nothing returns nothing
call CreateTextTagLocBJ("|cFF00FF00冰|r|cFFFFFF00天|r|cFFFF6600雪|r|cFFFF00FF地|r",GetUnitLoc(GetAttacker()),0,20.,'d','d','d',20.)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,90.,90)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,4.)
call SetTextTagFadepoint(bj_lastCreatedTextTag,1.)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(700.,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_lfhybdbtxd_Func006001003)),function Trig_lfhybdbtxd_Func006A)
endfunction
function InitTrig_lfhybdbtxd takes nothing returns nothing
set gg_trg_lfhybdbtxd=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_lfhybdbtxd,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_lfhybdbtxd,Condition(function Trig_lfhybdbtxd_Conditions))
call TriggerAddAction(gg_trg_lfhybdbtxd,function Trig_lfhybdbtxd_Actions)
endfunction
function Trig_lfhybdswjl_Conditions takes nothing returns boolean
return(GetOwningPlayer(GetAttacker())==udg_lfhykqzb)and(GetRandomInt(1,200)==2)
endfunction
function Trig_lfhybdswjl_Func006001003001 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_lfhybdswjl_Func006001003002 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_lfhybdswjl_Func006001003 takes nothing returns boolean
return GetBooleanAnd(Trig_lfhybdswjl_Func006001003001(),Trig_lfhybdswjl_Func006001003002())
endfunction
function Trig_lfhybdswjl_Func006A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),(I2R(GetHeroStr(GetAttacker(),true))*I2R(GetHeroLevel(GetAttacker()))),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_lfhybdswjl_Actions takes nothing returns nothing
call CreateTextTagLocBJ("|cFF00FF00死|r|cFFFFFF00亡|r|cFFFF6600降|r|cFFFF00FF临|r",GetUnitLoc(GetAttacker()),0,20.,'d','d','d',20.)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,90.,90)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,4.)
call SetTextTagFadepoint(bj_lastCreatedTextTag,1.)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(700.,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_lfhybdswjl_Func006001003)),function Trig_lfhybdswjl_Func006A)
endfunction
function InitTrig_lfhybdswjl takes nothing returns nothing
set gg_trg_lfhybdswjl=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_lfhybdswjl,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_lfhybdswjl,Condition(function Trig_lfhybdswjl_Conditions))
call TriggerAddAction(gg_trg_lfhybdswjl,function Trig_lfhybdswjl_Actions)
endfunction
function Trig_lfhydgjq_Conditions takes nothing returns boolean
return(GetOwningPlayer(GetAttacker())==udg_lfhykqzb)and(GetRandomInt(1,200)==2)
endfunction
function Trig_lfhydgjq_Actions takes nothing returns nothing
call CreateTextTagLocBJ("|cFF00FF00偷|r|cFFFFFF00取|r|cFFFF6600金|r|cFFFF00FF钱|r",GetUnitLoc(GetAttacker()),0,20.,'d','d','d',20.)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,90.,90)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,4.)
call SetTextTagFadepoint(bj_lastCreatedTextTag,1.)
call AdjustPlayerStateBJ(GetHeroLevel(GetAttacker()),GetOwningPlayer(GetAttacker()),PLAYER_STATE_RESOURCE_GOLD)
endfunction
function InitTrig_lfhydgjq takes nothing returns nothing
set gg_trg_lfhydgjq=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_lfhydgjq,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_lfhydgjq,Condition(function Trig_lfhydgjq_Conditions))
call TriggerAddAction(gg_trg_lfhydgjq,function Trig_lfhydgjq_Actions)
endfunction
function Trig_lfhydgmt_Conditions takes nothing returns boolean
return(GetOwningPlayer(GetAttacker())==udg_lfhykqzb)and(GetRandomInt(1,500)==1)
endfunction
function Trig_lfhydgmt_Actions takes nothing returns nothing
call CreateTextTagLocBJ("|cFF00FF00偷|r|cFFFFFF00取|r|cFFFF6600木|r|cFFFF00FF材|r",GetUnitLoc(GetAttacker()),0,20.,'d','d','d',20.)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,90.,90)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,4.)
call SetTextTagFadepoint(bj_lastCreatedTextTag,1.)
call AdjustPlayerStateBJ(GetHeroLevel(GetAttacker()),GetOwningPlayer(GetAttacker()),PLAYER_STATE_RESOURCE_LUMBER)
endfunction
function InitTrig_lfhydgmt takes nothing returns nothing
set gg_trg_lfhydgmt=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_lfhydgmt,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_lfhydgmt,Condition(function Trig_lfhydgmt_Conditions))
call TriggerAddAction(gg_trg_lfhydgmt,function Trig_lfhydgmt_Actions)
endfunction
function Trig_lfhysjewjsx_Conditions takes nothing returns boolean
return(GetOwningPlayer(GetTriggerUnit())==udg_lfhykqzb)
endfunction
function Trig_lfhysjewjsx_Actions takes nothing returns nothing
call ModifyHeroStat(0,GetTriggerUnit(),0,5)
call ModifyHeroStat(1,GetTriggerUnit(),0,5)
call ModifyHeroStat(2,GetTriggerUnit(),0,5)
endfunction
function InitTrig_lfhysjewjsx takes nothing returns nothing
set gg_trg_lfhysjewjsx=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_lfhysjewjsx,EVENT_PLAYER_HERO_LEVEL)
call TriggerAddCondition(gg_trg_lfhysjewjsx,Condition(function Trig_lfhysjewjsx_Conditions))
call TriggerAddAction(gg_trg_lfhysjewjsx,function Trig_lfhysjewjsx_Actions)
endfunction
function Trig_lfhyxmjm_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhyxmjm_Func001A takes nothing returns nothing
call SetUnitLifePercentBJ(GetEnumUnit(),'d')
call SetUnitManaPercentBJ(GetEnumUnit(),'d')
call UnitRemoveBuffs(GetEnumUnit(),false,true)
call UnitResetCooldown(GetEnumUnit())
endfunction
function Trig_lfhyxmjm_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfhyxmjm_Func001A)
endfunction
function InitTrig_lfhyxmjm takes nothing returns nothing
set gg_trg_lfhyxmjm=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_lfhyxmjm,Player(0),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_lfhyxmjm,Player(1),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_lfhyxmjm,Player(2),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_lfhyxmjm,Player(3),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_lfhyxmjm,Player(4),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_lfhyxmjm,Player(5),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_lfhyxmjm,Player(6),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_lfhyxmjm,Player(7),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_lfhyxmjm,Player(8),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_lfhyxmjm,Player(9),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_lfhyxmjm,Player(10),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_lfhyxmjm,Player(11),0,0)
call TriggerAddCondition(gg_trg_lfhyxmjm,Condition(function Trig_lfhyxmjm_Conditions))
call TriggerAddAction(gg_trg_lfhyxmjm,function Trig_lfhyxmjm_Actions)
endfunction
function Trig_lfhyqpss_Conditions takes nothing returns boolean
return(GetOwningPlayer(GetTriggerUnit())==udg_lfhykqzb)and(GetIssuedOrderId()==851990)
endfunction
function Trig_lfhyqpss_Actions takes nothing returns nothing
call CreateTextTagLocBJ("|cFF00FF00瞬|r|cFFFFFF00间|r|cFFFF6600移|r|cFFFF00FF动|r",GetOrderPointLoc(),0,20.,'d','d','d',20.)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,90.,90)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,4.)
call SetTextTagFadepoint(bj_lastCreatedTextTag,1.)
call SetUnitPositionLoc(GetTriggerUnit(),GetOrderPointLoc())
endfunction
function InitTrig_lfhyqpss takes nothing returns nothing
set gg_trg_lfhyqpss=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_lfhyqpss,EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
call TriggerAddCondition(gg_trg_lfhyqpss,Condition(function Trig_lfhyqpss_Conditions))
call TriggerAddAction(gg_trg_lfhyqpss,function Trig_lfhyqpss_Actions)
endfunction
function Trig_lfhywudi_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhywudi_Func001A takes nothing returns nothing
call SetUnitInvulnerable(GetEnumUnit(),true)
endfunction
function Trig_lfhywudi_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfhywudi_Func001A)
endfunction
function InitTrig_lfhywudi takes nothing returns nothing
set gg_trg_lfhywudi=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_lfhywudi,Player(0),"wudi",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhywudi,Player(1),"wudi",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhywudi,Player(2),"wudi",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhywudi,Player(3),"wudi",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhywudi,Player(4),"wudi",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhywudi,Player(5),"wudi",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhywudi,Player(6),"wudi",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhywudi,Player(7),"wudi",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhywudi,Player(8),"wudi",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhywudi,Player(9),"wudi",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhywudi,Player(9),"wudi",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhywudi,Player(11),"wudi",true)
call TriggerAddCondition(gg_trg_lfhywudi,Condition(function Trig_lfhywudi_Conditions))
call TriggerAddAction(gg_trg_lfhywudi,function Trig_lfhywudi_Actions)
endfunction
function Trig_lfhyqxwd_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhyqxwd_Func001A takes nothing returns nothing
call SetUnitInvulnerable(GetEnumUnit(),false)
endfunction
function Trig_lfhyqxwd_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfhyqxwd_Func001A)
endfunction
function InitTrig_lfhyqxwd takes nothing returns nothing
set gg_trg_lfhyqxwd=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyqxwd,Player(0),"buwudi",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyqxwd,Player(1),"buwudi",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyqxwd,Player(2),"buwudi",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyqxwd,Player(3),"buwudi",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyqxwd,Player(4),"buwudi",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyqxwd,Player(5),"buwudi",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyqxwd,Player(6),"buwudi",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyqxwd,Player(7),"buwudi",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyqxwd,Player(8),"buwudi",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyqxwd,Player(9),"buwudi",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyqxwd,Player(9),"buwudi",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyqxwd,Player(11),"buwudi",true)
call TriggerAddCondition(gg_trg_lfhyqxwd,Condition(function Trig_lfhyqxwd_Conditions))
call TriggerAddAction(gg_trg_lfhyqxwd,function Trig_lfhyqxwd_Actions)
endfunction
function Trig_lfhyswjsx_Conditions takes nothing returns boolean
return(GetOwningPlayer(GetTriggerUnit())==udg_lfhykqzb)
endfunction
function Trig_lfhyswjsx_Actions takes nothing returns nothing
call ReviveHeroLoc(GetDyingUnit(),GetUnitLoc(GetDyingUnit()),false)
call ModifyHeroStat(0,GetTriggerUnit(),0,5)
call ModifyHeroStat(1,GetTriggerUnit(),0,5)
call ModifyHeroStat(2,GetTriggerUnit(),0,5)
endfunction
function InitTrig_lfhyswjsx takes nothing returns nothing
set gg_trg_lfhyswjsx=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_lfhyswjsx,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddCondition(gg_trg_lfhyswjsx,Condition(function Trig_lfhyswjsx_Conditions))
call TriggerAddAction(gg_trg_lfhyswjsx,function Trig_lfhyswjsx_Actions)
endfunction
function Trig_lfhyswjsxgb_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhyswjsxgb_Actions takes nothing returns nothing
call DisableTrigger(gg_trg_lfhyswjsx)
endfunction
function InitTrig_lfhyswjsxgb takes nothing returns nothing
set gg_trg_lfhyswjsxgb=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyswjsxgb,Player(0),"guanfuhuo",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyswjsxgb,Player(1),"guanfuhuo",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyswjsxgb,Player(2),"guanfuhuo",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyswjsxgb,Player(3),"guanfuhuo",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyswjsxgb,Player(4),"guanfuhuo",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyswjsxgb,Player(5),"guanfuhuo",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyswjsxgb,Player(6),"guanfuhuo",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyswjsxgb,Player(7),"guanfuhuo",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyswjsxgb,Player(8),"guanfuhuo",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyswjsxgb,Player(9),"guanfuhuo",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyswjsxgb,Player(10),"guanfuhuo",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyswjsxgb,Player(11),"guanfuhuo",true)
call TriggerAddCondition(gg_trg_lfhyswjsxgb,Condition(function Trig_lfhyswjsxgb_Conditions))
call TriggerAddAction(gg_trg_lfhyswjsxgb,function Trig_lfhyswjsxgb_Actions)
endfunction
function Trig_lfhyswjsxkq_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhyswjsxkq_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_lfhyswjsx)
endfunction
function InitTrig_lfhyswjsxkq takes nothing returns nothing
set gg_trg_lfhyswjsxkq=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyswjsxkq,Player(0),"kaifuhuo",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyswjsxkq,Player(1),"kaifuhuo",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyswjsxkq,Player(2),"kaifuhuo",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyswjsxkq,Player(3),"kaifuhuo",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyswjsxkq,Player(4),"kaifuhuo",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyswjsxkq,Player(5),"kaifuhuo",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyswjsxkq,Player(6),"kaifuhuo",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyswjsxkq,Player(7),"kaifuhuo",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyswjsxkq,Player(8),"kaifuhuo",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyswjsxkq,Player(9),"kaifuhuo",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyswjsxkq,Player(10),"kaifuhuo",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyswjsxkq,Player(11),"kaifuhuo",true)
call TriggerAddCondition(gg_trg_lfhyswjsxkq,Condition(function Trig_lfhyswjsxkq_Conditions))
call TriggerAddAction(gg_trg_lfhyswjsxkq,function Trig_lfhyswjsxkq_Actions)
endfunction
function Trig_lfhyfyx_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhyfyx_Func001A takes nothing returns nothing
call UnitAddAbility(GetEnumUnit(),'Agyv')
endfunction
function Trig_lfhyfyx_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfhyfyx_Func001A)
endfunction
function InitTrig_lfhyfyx takes nothing returns nothing
set gg_trg_lfhyfyx=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyfyx,Player(0),"fanyinxing",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyfyx,Player(1),"fanyinxing",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyfyx,Player(2),"fanyinxing",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyfyx,Player(3),"fanyinxing",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyfyx,Player(4),"fanyinxing",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyfyx,Player(5),"fanyinxing",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyfyx,Player(6),"fanyinxing",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyfyx,Player(7),"fanyinxing",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyfyx,Player(8),"fanyinxing",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyfyx,Player(9),"fanyinxing",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyfyx,Player(9),"fanyinxing",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyfyx,Player(11),"fanyinxing",true)
call TriggerAddCondition(gg_trg_lfhyfyx,Condition(function Trig_lfhyfyx_Conditions))
call TriggerAddAction(gg_trg_lfhyfyx,function Trig_lfhyfyx_Actions)
endfunction
function Trig_lfhyyjydsd_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhyyjydsd_Func001A takes nothing returns nothing
call SetUnitMoveSpeed(GetEnumUnit(),522.)
endfunction
function Trig_lfhyyjydsd_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfhyyjydsd_Func001A)
endfunction
function InitTrig_lfhyyjydsd takes nothing returns nothing
set gg_trg_lfhyyjydsd=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_lfhyyjydsd,Player(0),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_lfhyyjydsd,Player(1),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_lfhyyjydsd,Player(2),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_lfhyyjydsd,Player(3),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_lfhyyjydsd,Player(4),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_lfhyyjydsd,Player(5),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_lfhyyjydsd,Player(6),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_lfhyyjydsd,Player(7),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_lfhyyjydsd,Player(8),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_lfhyyjydsd,Player(9),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_lfhyyjydsd,Player(10),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_lfhyyjydsd,Player(11),0,1)
call TriggerAddCondition(gg_trg_lfhyyjydsd,Condition(function Trig_lfhyyjydsd_Conditions))
call TriggerAddAction(gg_trg_lfhyyjydsd,function Trig_lfhyyjydsd_Actions)
endfunction
function Trig_lfhybfyx_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhybfyx_Func001A takes nothing returns nothing
call UnitRemoveAbility(GetEnumUnit(),'Agyv')
endfunction
function Trig_lfhybfyx_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfhybfyx_Func001A)
endfunction
function InitTrig_lfhybfyx takes nothing returns nothing
set gg_trg_lfhybfyx=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_lfhybfyx,Player(0),"yinxing",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhybfyx,Player(1),"yinxing",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhybfyx,Player(2),"yinxing",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhybfyx,Player(3),"yinxing",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhybfyx,Player(4),"yinxing",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhybfyx,Player(5),"yinxing",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhybfyx,Player(6),"yinxing",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhybfyx,Player(7),"yinxing",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhybfyx,Player(8),"yinxing",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhybfyx,Player(9),"yinxing",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhybfyx,Player(9),"yinxing",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhybfyx,Player(11),"yinxing",true)
call TriggerAddCondition(gg_trg_lfhybfyx,Condition(function Trig_lfhybfyx_Conditions))
call TriggerAddAction(gg_trg_lfhybfyx,function Trig_lfhybfyx_Actions)
endfunction
function Trig_lfhyqlwp_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhyqlwp_Func001002 takes nothing returns nothing
call RemoveItem(GetEnumItem())
endfunction
function Trig_lfhyqlwp_Actions takes nothing returns nothing
call EnumItemsInRectBJ(bj_mapInitialPlayableArea,function Trig_lfhyqlwp_Func001002)
endfunction
function InitTrig_lfhyqlwp takes nothing returns nothing
set gg_trg_lfhyqlwp=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyqlwp,Player(0),"qingli",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyqlwp,Player(1),"qingli",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyqlwp,Player(2),"qingli",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyqlwp,Player(3),"qingli",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyqlwp,Player(4),"qingli",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyqlwp,Player(5),"qingli",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyqlwp,Player(6),"qingli",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyqlwp,Player(7),"qingli",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyqlwp,Player(8),"qingli",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyqlwp,Player(9),"qingli",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyqlwp,Player(9),"qingli",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyqlwp,Player(11),"qingli",true)
call TriggerAddCondition(gg_trg_lfhyqlwp,Condition(function Trig_lfhyqlwp_Conditions))
call TriggerAddAction(gg_trg_lfhyqlwp,function Trig_lfhyqlwp_Actions)
endfunction
function Trig_lfhytiren_Func001Func001C takes nothing returns boolean
return(GetEventPlayerChatString()=="tiren3")
endfunction
function Trig_lfhytiren_Func001Func002C takes nothing returns boolean
return(GetEventPlayerChatString()=="tiren4")
endfunction
function Trig_lfhytiren_Func001Func003C takes nothing returns boolean
return(GetEventPlayerChatString()=="tiren5")
endfunction
function Trig_lfhytiren_Func001Func004C takes nothing returns boolean
return(GetEventPlayerChatString()=="tiren6")
endfunction
function Trig_lfhytiren_Func001Func005C takes nothing returns boolean
return(GetEventPlayerChatString()=="tiren7")
endfunction
function Trig_lfhytiren_Func001Func006C takes nothing returns boolean
return(GetEventPlayerChatString()=="tiren8")
endfunction
function Trig_lfhytiren_Func001Func007C takes nothing returns boolean
return(GetEventPlayerChatString()=="tiren9")
endfunction
function Trig_lfhytiren_Func001Func008C takes nothing returns boolean
return(GetEventPlayerChatString()=="tiren10")
endfunction
function Trig_lfhytiren_Func001Func009C takes nothing returns boolean
return(GetEventPlayerChatString()=="tiren11")
endfunction
function Trig_lfhytiren_Func001Func010C takes nothing returns boolean
return(GetEventPlayerChatString()=="tiren12")
endfunction
function Trig_lfhytiren_Func001C takes nothing returns boolean
return(GetEventPlayerChatString()=="tiren2")
endfunction
function Trig_lfhytiren_Actions takes nothing returns nothing
if(Trig_lfhytiren_Func001C())then
call CustomDefeatBJ(Player(1),"失败!")
else
if(Trig_lfhytiren_Func001Func001C())then
call CustomDefeatBJ(Player(2),"失败!")
endif
if(Trig_lfhytiren_Func001Func002C())then
call CustomDefeatBJ(Player(3),"失败!")
endif
if(Trig_lfhytiren_Func001Func003C())then
call CustomDefeatBJ(Player(4),"失败!")
endif
if(Trig_lfhytiren_Func001Func004C())then
call CustomDefeatBJ(Player(5),"失败!")
endif
if(Trig_lfhytiren_Func001Func005C())then
call CustomDefeatBJ(Player(6),"失败!")
endif
if(Trig_lfhytiren_Func001Func006C())then
call CustomDefeatBJ(Player(7),"失败!")
endif
if(Trig_lfhytiren_Func001Func007C())then
call CustomDefeatBJ(Player(8),"失败!")
endif
if(Trig_lfhytiren_Func001Func008C())then
call CustomDefeatBJ(Player(9),"失败!")
endif
if(Trig_lfhytiren_Func001Func009C())then
call CustomDefeatBJ(Player(10),"失败!")
endif
if(Trig_lfhytiren_Func001Func010C())then
call CustomDefeatBJ(Player(11),"失败!")
endif
endif
endfunction
function InitTrig_lfhytiren takes nothing returns nothing
set gg_trg_lfhytiren=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_lfhytiren,Player(0),"tiren2",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhytiren,Player(0),"tiren3",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhytiren,Player(0),"tiren4",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhytiren,Player(0),"tiren5",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhytiren,Player(0),"tiren6",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhytiren,Player(0),"tiren7",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhytiren,Player(0),"tiren8",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhytiren,Player(0),"tiren9",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhytiren,Player(0),"tiren10",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhytiren,Player(0),"tiren11",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhytiren,Player(0),"tiren12",true)
call TriggerAddAction(gg_trg_lfhytiren,function Trig_lfhytiren_Actions)
endfunction
function Trig_lfhyjbjy_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhyjbjy_Actions takes nothing returns nothing
call SetPlayerHandicapXPBJ(GetTriggerPlayer(),S2R(SubStringBJ(GetEventPlayerChatString(),8,'d')))
endfunction
function InitTrig_lfhyjbjy takes nothing returns nothing
set gg_trg_lfhyjbjy=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjbjy,Player(0),"jingyan",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjbjy,Player(1),"jingyan",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjbjy,Player(2),"jingyan",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjbjy,Player(3),"jingyan",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjbjy,Player(4),"jingyan",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjbjy,Player(5),"jingyan",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjbjy,Player(6),"jingyan",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjbjy,Player(7),"jingyan",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjbjy,Player(8),"jingyan",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjbjy,Player(9),"jingyan",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjbjy,Player(10),"jingyan",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjbjy,Player(11),"jingyan",false)
call TriggerAddCondition(gg_trg_lfhyjbjy,Condition(function Trig_lfhyjbjy_Conditions))
call TriggerAddAction(gg_trg_lfhyjbjy,function Trig_lfhyjbjy_Actions)
endfunction
function Trig_lfhydengji_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhydengji_Func001A takes nothing returns nothing
call SetHeroLevel(GetEnumUnit(),(R2I(I2R(GetHeroLevel(GetEnumUnit())))+S2I(SubStringBJ(GetEventPlayerChatString(),7,'d'))),false)
endfunction
function Trig_lfhydengji_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfhydengji_Func001A)
endfunction
function InitTrig_lfhydengji takes nothing returns nothing
set gg_trg_lfhydengji=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_lfhydengji,Player(0),"dengji",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhydengji,Player(1),"dengji",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhydengji,Player(2),"dengji",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhydengji,Player(3),"dengji",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhydengji,Player(4),"dengji",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhydengji,Player(5),"dengji",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhydengji,Player(6),"dengji",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhydengji,Player(7),"dengji",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhydengji,Player(8),"dengji",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhydengji,Player(9),"dengji",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhydengji,Player(10),"dengji",false)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhydengji,Player(11),"dengji",false)
call TriggerAddCondition(gg_trg_lfhydengji,Condition(function Trig_lfhydengji_Conditions))
call TriggerAddAction(gg_trg_lfhydengji,function Trig_lfhydengji_Actions)
endfunction
function Trig_lfhyjiangji_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhyjiangji_Func001A takes nothing returns nothing
call SetHeroLevelBJ(GetEnumUnit(),1,true)
endfunction
function Trig_lfhyjiangji_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfhyjiangji_Func001A)
endfunction
function InitTrig_lfhyjiangji takes nothing returns nothing
set gg_trg_lfhyjiangji=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjiangji,Player(0),"jiangji",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjiangji,Player(1),"jiangji",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjiangji,Player(2),"jiangji",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjiangji,Player(3),"jiangji",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjiangji,Player(4),"jiangji",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjiangji,Player(5),"jiangji",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjiangji,Player(6),"jiangji",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjiangji,Player(7),"jiangji",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjiangji,Player(8),"jiangji",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjiangji,Player(9),"jiangji",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjiangji,Player(9),"jiangji",true)
call TriggerRegisterPlayerChatEvent(gg_trg_lfhyjiangji,Player(11),"jiangji",true)
call TriggerAddCondition(gg_trg_lfhyjiangji,Condition(function Trig_lfhyjiangji_Conditions))
call TriggerAddAction(gg_trg_lfhyjiangji,function Trig_lfhyjiangji_Actions)
endfunction
function Trig_lfhydhk_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhydhk_Actions takes nothing returns nothing
call DialogSetMessage(udg_dhk,"|cFF00FF0055YOU作弊菜单，by：冷锋|r|cFFFFFF00。。|r|n|cFFFFFF00QQ：453081202，|r|n|cFFFF6600欢迎光临|r|cFFFF00FFbbs.55you.com|r")
call DialogAddButtonWithHotkeyBJ(udg_dhk,"无敌【A】",'A')
set udg_lfhywudi=bj_lastCreatedButton
call DialogAddButtonWithHotkeyBJ(udg_dhk,"加钱【B】",'B')
set udg_lfhyjiaqian=bj_lastCreatedButton
call DialogAddButtonWithHotkeyBJ(udg_dhk,"加木【C】",'C')
set udg_lfhyjiamu=bj_lastCreatedButton
call DialogAddButtonWithHotkeyBJ(udg_dhk,"加三围【D】",'D')
set udg_lfhyjiasanwei=bj_lastCreatedButton
call DialogAddButtonWithHotkeyBJ(udg_dhk,"移动速度【E】",'E')
set udg_lfhyydsd=bj_lastCreatedButton
call DialogAddButtonWithHotkeyBJ(udg_dhk,"提升200级【F】",'F')
set udg_lfhytisdj=bj_lastCreatedButton
call DialogAddButtonWithHotkeyBJ(udg_dhk,"取消无敌【G】",'G')
set udg_lfhydhkqxwd=bj_lastCreatedButton
call DialogAddButtonWithHotkeyBJ(udg_dhk,"清理物品【H】",'H')
set udg_lfhyqlwp=bj_lastCreatedButton
call DialogAddButtonWithHotkeyBJ(udg_dhk,"丢弃物品【I】",'I')
set udg_lfhydiuqwp=bj_lastCreatedButton
call DialogAddButtonWithHotkeyBJ(udg_dhk,"退化【J】",'J')
set udg_lfhytuihua=bj_lastCreatedButton
call DialogAddButtonWithHotkeyBJ(udg_dhk,"复制物品【K】",'K')
set udg_lfhyfzwp=bj_lastCreatedButton
call DialogAddButtonWithHotkeyBJ(udg_dhk,"退出【Q】",'Q')
set udg_lfhytcdhk=bj_lastCreatedButton
call DialogDisplayBJ(true,udg_dhk,GetTriggerPlayer())
endfunction
function InitTrig_lfhydhk takes nothing returns nothing
set gg_trg_lfhydhk=CreateTrigger()
call TriggerRegisterPlayerEventEndCinematic(gg_trg_lfhydhk,Player(0))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_lfhydhk,Player(1))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_lfhydhk,Player(2))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_lfhydhk,Player(3))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_lfhydhk,Player(4))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_lfhydhk,Player(5))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_lfhydhk,Player(6))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_lfhydhk,Player(7))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_lfhydhk,Player(8))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_lfhydhk,Player(9))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_lfhydhk,Player(10))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_lfhydhk,Player(11))
call TriggerAddCondition(gg_trg_lfhydhk,Condition(function Trig_lfhydhk_Conditions))
call TriggerAddAction(gg_trg_lfhydhk,function Trig_lfhydhk_Actions)
endfunction
function Trig_lfhydhkfzwp_Conditions takes nothing returns boolean
return(GetClickedButton()==udg_lfhyfzwp)and(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhydhkfzwp_Func002A takes nothing returns nothing
call CreateItemLoc(GetItemTypeId(UnitItemInSlotBJ(GetEnumUnit(),1)),GetUnitLoc(GetEnumUnit()))
call CreateItemLoc(GetItemTypeId(UnitItemInSlotBJ(GetEnumUnit(),2)),GetUnitLoc(GetEnumUnit()))
call CreateItemLoc(GetItemTypeId(UnitItemInSlotBJ(GetEnumUnit(),3)),GetUnitLoc(GetEnumUnit()))
call CreateItemLoc(GetItemTypeId(UnitItemInSlotBJ(GetEnumUnit(),4)),GetUnitLoc(GetEnumUnit()))
call CreateItemLoc(GetItemTypeId(UnitItemInSlotBJ(GetEnumUnit(),5)),GetUnitLoc(GetEnumUnit()))
call CreateItemLoc(GetItemTypeId(UnitItemInSlotBJ(GetEnumUnit(),6)),GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_lfhydhkfzwp_Actions takes nothing returns nothing
call DialogClear(udg_dhk)
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfhydhkfzwp_Func002A)
call TriggerExecute(gg_trg_lfhydhk)
endfunction
function InitTrig_lfhydhkfzwp takes nothing returns nothing
set gg_trg_lfhydhkfzwp=CreateTrigger()
call TriggerRegisterDialogEvent(gg_trg_lfhydhkfzwp,udg_dhk)
call TriggerAddCondition(gg_trg_lfhydhkfzwp,Condition(function Trig_lfhydhkfzwp_Conditions))
call TriggerAddAction(gg_trg_lfhydhkfzwp,function Trig_lfhydhkfzwp_Actions)
endfunction
function Trig_lfhywddhk_Conditions takes nothing returns boolean
return(GetClickedButton()==udg_lfhywudi)and(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhywddhk_Func002A takes nothing returns nothing
call SetUnitInvulnerable(GetEnumUnit(),true)
endfunction
function Trig_lfhywddhk_Actions takes nothing returns nothing
call DialogClear(udg_dhk)
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfhywddhk_Func002A)
call TriggerExecute(gg_trg_lfhydhk)
endfunction
function InitTrig_lfhywddhk takes nothing returns nothing
set gg_trg_lfhywddhk=CreateTrigger()
call TriggerRegisterDialogEvent(gg_trg_lfhywddhk,udg_dhk)
call TriggerAddCondition(gg_trg_lfhywddhk,Condition(function Trig_lfhywddhk_Conditions))
call TriggerAddAction(gg_trg_lfhywddhk,function Trig_lfhywddhk_Actions)
endfunction
function Trig_lfhyjqdhk_Conditions takes nothing returns boolean
return(GetClickedButton()==udg_lfhyjiaqian)and(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhyjqdhk_Actions takes nothing returns nothing
call DialogClear(udg_dhk)
call AdjustPlayerStateBJ(10000,GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD)
call SetPlayerStateBJ(GetTriggerPlayer(),PLAYER_STATE_GOLD_GATHERED,udg_zonghuangjincaijiliang)
call TriggerExecute(gg_trg_lfhydhk)
endfunction
function InitTrig_lfhyjqdhk takes nothing returns nothing
set gg_trg_lfhyjqdhk=CreateTrigger()
call TriggerRegisterDialogEvent(gg_trg_lfhyjqdhk,udg_dhk)
call TriggerAddCondition(gg_trg_lfhyjqdhk,Condition(function Trig_lfhyjqdhk_Conditions))
call TriggerAddAction(gg_trg_lfhyjqdhk,function Trig_lfhyjqdhk_Actions)
endfunction
function Trig_lfhyjmdhk_Conditions takes nothing returns boolean
return(GetClickedButton()==udg_lfhyjiamu)and(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhyjmdhk_Actions takes nothing returns nothing
call DialogClear(udg_dhk)
call AdjustPlayerStateBJ(1000,GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER)
call SetPlayerStateBJ(GetTriggerPlayer(),PLAYER_STATE_LUMBER_GATHERED,udg_zongmucaicaijiliang)
call TriggerExecute(gg_trg_lfhydhk)
endfunction
function InitTrig_lfhyjmdhk takes nothing returns nothing
set gg_trg_lfhyjmdhk=CreateTrigger()
call TriggerRegisterDialogEvent(gg_trg_lfhyjmdhk,udg_dhk)
call TriggerAddCondition(gg_trg_lfhyjmdhk,Condition(function Trig_lfhyjmdhk_Conditions))
call TriggerAddAction(gg_trg_lfhyjmdhk,function Trig_lfhyjmdhk_Actions)
endfunction
function Trig_lfhyjswdhk_Conditions takes nothing returns boolean
return(GetClickedButton()==udg_lfhyjiasanwei)and(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhyjswdhk_Func002A takes nothing returns nothing
call ModifyHeroStat(0,GetEnumUnit(),0,'d')
call ModifyHeroStat(1,GetEnumUnit(),0,'d')
call ModifyHeroStat(2,GetEnumUnit(),0,'d')
endfunction
function Trig_lfhyjswdhk_Actions takes nothing returns nothing
call DialogClear(udg_dhk)
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfhyjswdhk_Func002A)
call TriggerExecute(gg_trg_lfhydhk)
endfunction
function InitTrig_lfhyjswdhk takes nothing returns nothing
set gg_trg_lfhyjswdhk=CreateTrigger()
call TriggerRegisterDialogEvent(gg_trg_lfhyjswdhk,udg_dhk)
call TriggerAddCondition(gg_trg_lfhyjswdhk,Condition(function Trig_lfhyjswdhk_Conditions))
call TriggerAddAction(gg_trg_lfhyjswdhk,function Trig_lfhyjswdhk_Actions)
endfunction
function Trig_lfhyscdw_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfhykqzb)and(GetClickedButton()==udg_lfhyydsd)
endfunction
function Trig_lfhyscdw_Func002A takes nothing returns nothing
call SetUnitMoveSpeed(GetEnumUnit(),522.)
endfunction
function Trig_lfhyscdw_Actions takes nothing returns nothing
call DialogClear(udg_dhk)
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfhyscdw_Func002A)
call TriggerExecute(gg_trg_lfhydhk)
endfunction
function InitTrig_lfhyscdw takes nothing returns nothing
set gg_trg_lfhyscdw=CreateTrigger()
call TriggerRegisterDialogEvent(gg_trg_lfhyscdw,udg_dhk)
call TriggerAddCondition(gg_trg_lfhyscdw,Condition(function Trig_lfhyscdw_Conditions))
call TriggerAddAction(gg_trg_lfhyscdw,function Trig_lfhyscdw_Actions)
endfunction
function Trig_lfhydhkdj_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_lfhykqzb)and(GetClickedButton()==udg_lfhytisdj)
endfunction
function Trig_lfhydhkdj_Func003A takes nothing returns nothing
call SetHeroLevel(GetEnumUnit(),(GetHeroLevel(GetEnumUnit())+200),false)
endfunction
function Trig_lfhydhkdj_Actions takes nothing returns nothing
call DialogClear(udg_dhk)
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfhydhkdj_Func003A)
call TriggerExecute(gg_trg_lfhydhk)
endfunction
function InitTrig_lfhydhkdj takes nothing returns nothing
set gg_trg_lfhydhkdj=CreateTrigger()
call TriggerRegisterDialogEvent(gg_trg_lfhydhkdj,udg_dhk)
call TriggerAddCondition(gg_trg_lfhydhkdj,Condition(function Trig_lfhydhkdj_Conditions))
call TriggerAddAction(gg_trg_lfhydhkdj,function Trig_lfhydhkdj_Actions)
endfunction
function Trig_lfhydhkqxwd_Conditions takes nothing returns boolean
return(GetClickedButton()==udg_lfhydhkqxwd)and(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhydhkqxwd_Func002A takes nothing returns nothing
call SetUnitInvulnerable(GetEnumUnit(),false)
endfunction
function Trig_lfhydhkqxwd_Actions takes nothing returns nothing
call DialogClear(udg_dhk)
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfhydhkqxwd_Func002A)
call TriggerExecute(gg_trg_lfhydhk)
endfunction
function InitTrig_lfhydhkqxwd takes nothing returns nothing
set gg_trg_lfhydhkqxwd=CreateTrigger()
call TriggerRegisterDialogEvent(gg_trg_lfhydhkqxwd,udg_dhk)
call TriggerAddCondition(gg_trg_lfhydhkqxwd,Condition(function Trig_lfhydhkqxwd_Conditions))
call TriggerAddAction(gg_trg_lfhydhkqxwd,function Trig_lfhydhkqxwd_Actions)
endfunction
function Trig_lfhydhkscwp_Conditions takes nothing returns boolean
return(GetClickedButton()==udg_lfhyqlwp)and(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhydhkscwp_Func002002 takes nothing returns nothing
call RemoveItem(GetEnumItem())
endfunction
function Trig_lfhydhkscwp_Actions takes nothing returns nothing
call DialogClear(udg_dhk)
call EnumItemsInRectBJ(bj_mapInitialPlayableArea,function Trig_lfhydhkscwp_Func002002)
call TriggerExecute(gg_trg_lfhydhk)
endfunction
function InitTrig_lfhydhkscwp takes nothing returns nothing
set gg_trg_lfhydhkscwp=CreateTrigger()
call TriggerRegisterDialogEvent(gg_trg_lfhydhkscwp,udg_dhk)
call TriggerAddCondition(gg_trg_lfhydhkscwp,Condition(function Trig_lfhydhkscwp_Conditions))
call TriggerAddAction(gg_trg_lfhydhkscwp,function Trig_lfhydhkscwp_Actions)
endfunction
function Trig_lfhydhkqlwp_Conditions takes nothing returns boolean
return(GetClickedButton()==udg_lfhydiuqwp)and(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhydhkqlwp_Actions takes nothing returns nothing
call DialogClear(udg_dhk)
call DialogSetMessage(udg_dqwpdhk,"|cFF00FF00丢|r|cFFFFFF00弃|r|cFFFF6600物|r|cFFFF00FF品|r")
call DialogDisplayBJ(true,udg_dqwpdhk,GetTriggerPlayer())
call DialogAddButtonWithHotkeyBJ(udg_dqwpdhk,"丢弃第一格物品【A】",'A')
set udg_lfhydqdygwp=bj_lastCreatedButton
call DialogAddButtonWithHotkeyBJ(udg_dqwpdhk,"丢弃第二格物品【B】",'B')
set udg_lfhydqdergwp=bj_lastCreatedButton
call DialogAddButtonWithHotkeyBJ(udg_dqwpdhk,"丢弃第三格物品【C】",'C')
set udg_lfhydqdsangwp=bj_lastCreatedButton
call DialogAddButtonWithHotkeyBJ(udg_dqwpdhk,"丢弃第四格物品【D】",'D')
set udg_lfhydqdsigwp=bj_lastCreatedButton
call DialogAddButtonWithHotkeyBJ(udg_dqwpdhk,"丢弃第五格物品【E】",'E')
set udg_lfhydqdwugwp=bj_lastCreatedButton
call DialogAddButtonWithHotkeyBJ(udg_dqwpdhk,"丢弃第六格物品【F】",'F')
set udg_lfhydqdlgwp=bj_lastCreatedButton
call DialogAddButtonWithHotkeyBJ(udg_dqwpdhk,"丢弃所有物品【G】",'G')
set udg_lfhydqsuoyouwp=bj_lastCreatedButton
call DialogAddButtonWithHotkeyBJ(udg_dqwpdhk,"返回【I】",'H')
set udg_lfhyfhzqdhk=bj_lastCreatedButton
call DialogAddButtonWithHotkeyBJ(udg_dqwpdhk,"退出【Q】",'Q')
set udg_lfhytcdqdhk=bj_lastCreatedButton
call DialogDisplayBJ(true,udg_dqwpdhk,GetTriggerPlayer())
endfunction
function InitTrig_lfhydhkqlwp takes nothing returns nothing
set gg_trg_lfhydhkqlwp=CreateTrigger()
call TriggerRegisterDialogEvent(gg_trg_lfhydhkqlwp,udg_dhk)
call TriggerAddCondition(gg_trg_lfhydhkqlwp,Condition(function Trig_lfhydhkqlwp_Conditions))
call TriggerAddAction(gg_trg_lfhydhkqlwp,function Trig_lfhydhkqlwp_Actions)
endfunction
function Trig_lfhydqdyygwp_Conditions takes nothing returns boolean
return(GetClickedButton()==udg_lfhydqdygwp)and(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhydqdyygwp_Func003A takes nothing returns nothing
call UnitRemoveItemFromSlotSwapped(1,GetEnumUnit())
endfunction
function Trig_lfhydqdyygwp_Actions takes nothing returns nothing
call DialogClear(udg_dhk)
call DialogClear(udg_dqwpdhk)
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfhydqdyygwp_Func003A)
call TriggerExecute(gg_trg_lfhydhkqlwp)
endfunction
function InitTrig_lfhydqdyygwp takes nothing returns nothing
set gg_trg_lfhydqdyygwp=CreateTrigger()
call TriggerRegisterDialogEvent(gg_trg_lfhydqdyygwp,udg_dqwpdhk)
call TriggerAddCondition(gg_trg_lfhydqdyygwp,Condition(function Trig_lfhydqdyygwp_Conditions))
call TriggerAddAction(gg_trg_lfhydqdyygwp,function Trig_lfhydqdyygwp_Actions)
endfunction
function Trig_lfhydqdeegwp_Conditions takes nothing returns boolean
return(GetClickedButton()==udg_lfhydqdergwp)and(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhydqdeegwp_Func002A takes nothing returns nothing
call UnitRemoveItemFromSlotSwapped(2,GetEnumUnit())
endfunction
function Trig_lfhydqdeegwp_Actions takes nothing returns nothing
call DialogClear(udg_dqwpdhk)
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfhydqdeegwp_Func002A)
call TriggerExecute(gg_trg_lfhydhkqlwp)
endfunction
function InitTrig_lfhydqdeegwp takes nothing returns nothing
set gg_trg_lfhydqdeegwp=CreateTrigger()
call TriggerRegisterDialogEvent(gg_trg_lfhydqdeegwp,udg_dqwpdhk)
call TriggerAddCondition(gg_trg_lfhydqdeegwp,Condition(function Trig_lfhydqdeegwp_Conditions))
call TriggerAddAction(gg_trg_lfhydqdeegwp,function Trig_lfhydqdeegwp_Actions)
endfunction
function Trig_lfhydqdsasgwp_Conditions takes nothing returns boolean
return(GetClickedButton()==udg_lfhydqdsangwp)and(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhydqdsasgwp_Func003A takes nothing returns nothing
call UnitRemoveItemFromSlotSwapped(3,GetEnumUnit())
endfunction
function Trig_lfhydqdsasgwp_Actions takes nothing returns nothing
call DialogClear(udg_dhk)
call DialogClear(udg_dqwpdhk)
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfhydqdsasgwp_Func003A)
call TriggerExecute(gg_trg_lfhydhkqlwp)
endfunction
function InitTrig_lfhydqdsasgwp takes nothing returns nothing
set gg_trg_lfhydqdsasgwp=CreateTrigger()
call TriggerRegisterDialogEvent(gg_trg_lfhydqdsasgwp,udg_dqwpdhk)
call TriggerAddCondition(gg_trg_lfhydqdsasgwp,Condition(function Trig_lfhydqdsasgwp_Conditions))
call TriggerAddAction(gg_trg_lfhydqdsasgwp,function Trig_lfhydqdsasgwp_Actions)
endfunction
function Trig_lfhydqdsgwp_Conditions takes nothing returns boolean
return(GetClickedButton()==udg_lfhydqdsigwp)and(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhydqdsgwp_Func003A takes nothing returns nothing
call UnitRemoveItemFromSlotSwapped(4,GetEnumUnit())
endfunction
function Trig_lfhydqdsgwp_Actions takes nothing returns nothing
call DialogClear(udg_dhk)
call DialogClear(udg_dqwpdhk)
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfhydqdsgwp_Func003A)
call TriggerExecute(gg_trg_lfhydhkqlwp)
endfunction
function InitTrig_lfhydqdsgwp takes nothing returns nothing
set gg_trg_lfhydqdsgwp=CreateTrigger()
call TriggerRegisterDialogEvent(gg_trg_lfhydqdsgwp,udg_dqwpdhk)
call TriggerAddCondition(gg_trg_lfhydqdsgwp,Condition(function Trig_lfhydqdsgwp_Conditions))
call TriggerAddAction(gg_trg_lfhydqdsgwp,function Trig_lfhydqdsgwp_Actions)
endfunction
function Trig_lfhydqdwgwp_Conditions takes nothing returns boolean
return(GetClickedButton()==udg_lfhydqdwugwp)and(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhydqdwgwp_Func003A takes nothing returns nothing
call UnitRemoveItemFromSlotSwapped(5,GetEnumUnit())
endfunction
function Trig_lfhydqdwgwp_Actions takes nothing returns nothing
call DialogClear(udg_dhk)
call DialogClear(udg_dqwpdhk)
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfhydqdwgwp_Func003A)
call TriggerExecute(gg_trg_lfhydhkqlwp)
endfunction
function InitTrig_lfhydqdwgwp takes nothing returns nothing
set gg_trg_lfhydqdwgwp=CreateTrigger()
call TriggerRegisterDialogEvent(gg_trg_lfhydqdwgwp,udg_dqwpdhk)
call TriggerAddCondition(gg_trg_lfhydqdwgwp,Condition(function Trig_lfhydqdwgwp_Conditions))
call TriggerAddAction(gg_trg_lfhydqdwgwp,function Trig_lfhydqdwgwp_Actions)
endfunction
function Trig_lfhydqdlgwp_Conditions takes nothing returns boolean
return(GetClickedButton()==udg_lfhydqdlgwp)and(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhydqdlgwp_Func003A takes nothing returns nothing
call UnitRemoveItemFromSlotSwapped(6,GetEnumUnit())
endfunction
function Trig_lfhydqdlgwp_Actions takes nothing returns nothing
call DialogClear(udg_dhk)
call DialogClear(udg_dqwpdhk)
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfhydqdlgwp_Func003A)
call TriggerExecute(gg_trg_lfhydhkqlwp)
endfunction
function InitTrig_lfhydqdlgwp takes nothing returns nothing
set gg_trg_lfhydqdlgwp=CreateTrigger()
call TriggerRegisterDialogEvent(gg_trg_lfhydqdlgwp,udg_dqwpdhk)
call TriggerAddCondition(gg_trg_lfhydqdlgwp,Condition(function Trig_lfhydqdlgwp_Conditions))
call TriggerAddAction(gg_trg_lfhydqdlgwp,function Trig_lfhydqdlgwp_Actions)
endfunction
function Trig_lfhydqsywp_Conditions takes nothing returns boolean
return(GetClickedButton()==udg_lfhydqsuoyouwp)and(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhydqsywp_Func003A takes nothing returns nothing
call UnitRemoveItemFromSlotSwapped(1,GetEnumUnit())
call UnitRemoveItemFromSlotSwapped(2,GetEnumUnit())
call UnitRemoveItemFromSlotSwapped(3,GetEnumUnit())
call UnitRemoveItemFromSlotSwapped(4,GetEnumUnit())
call UnitRemoveItemFromSlotSwapped(5,GetEnumUnit())
call UnitRemoveItemFromSlotSwapped(6,GetEnumUnit())
endfunction
function Trig_lfhydqsywp_Actions takes nothing returns nothing
call DialogClear(udg_dhk)
call DialogClear(udg_dqwpdhk)
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfhydqsywp_Func003A)
call TriggerExecute(gg_trg_lfhydhkqlwp)
endfunction
function InitTrig_lfhydqsywp takes nothing returns nothing
set gg_trg_lfhydqsywp=CreateTrigger()
call TriggerRegisterDialogEvent(gg_trg_lfhydqsywp,udg_dqwpdhk)
call TriggerAddCondition(gg_trg_lfhydqsywp,Condition(function Trig_lfhydqsywp_Conditions))
call TriggerAddAction(gg_trg_lfhydqsywp,function Trig_lfhydqsywp_Actions)
endfunction
function Trig_lfhytcdqdhk_Conditions takes nothing returns boolean
return(GetClickedButton()==udg_lfhytcdqdhk)and(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhytcdqdhk_Actions takes nothing returns nothing
call DialogClear(udg_dhk)
call DialogClear(udg_dqwpdhk)
endfunction
function InitTrig_lfhytcdqdhk takes nothing returns nothing
set gg_trg_lfhytcdqdhk=CreateTrigger()
call TriggerRegisterDialogEvent(gg_trg_lfhytcdqdhk,udg_dqwpdhk)
call TriggerAddCondition(gg_trg_lfhytcdqdhk,Condition(function Trig_lfhytcdqdhk_Conditions))
call TriggerAddAction(gg_trg_lfhytcdqdhk,function Trig_lfhytcdqdhk_Actions)
endfunction
function Trig_lfhydhktuihua_Conditions takes nothing returns boolean
return(GetClickedButton()==udg_lfhytuihua)and(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhydhktuihua_Func002A takes nothing returns nothing
call ModifyHeroStat(0,GetEnumUnit(),2,1)
call ModifyHeroStat(1,GetEnumUnit(),2,1)
call ModifyHeroStat(2,GetEnumUnit(),2,1)
endfunction
function Trig_lfhydhktuihua_Actions takes nothing returns nothing
call DialogClear(udg_dhk)
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_lfhydhktuihua_Func002A)
call TriggerExecute(gg_trg_lfhydhk)
endfunction
function InitTrig_lfhydhktuihua takes nothing returns nothing
set gg_trg_lfhydhktuihua=CreateTrigger()
call TriggerRegisterDialogEvent(gg_trg_lfhydhktuihua,udg_dhk)
call TriggerAddCondition(gg_trg_lfhydhktuihua,Condition(function Trig_lfhydhktuihua_Conditions))
call TriggerAddAction(gg_trg_lfhydhktuihua,function Trig_lfhydhktuihua_Actions)
endfunction
function Trig_lfhyfhzqddhk_Conditions takes nothing returns boolean
return(GetClickedButton()==udg_lfhyfhzqdhk)and(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhyfhzqddhk_Actions takes nothing returns nothing
call DialogClear(udg_dqwpdhk)
call TriggerExecute(gg_trg_lfhydhk)
endfunction
function InitTrig_lfhyfhzqddhk takes nothing returns nothing
set gg_trg_lfhyfhzqddhk=CreateTrigger()
call TriggerRegisterDialogEvent(gg_trg_lfhyfhzqddhk,udg_dqwpdhk)
call TriggerAddCondition(gg_trg_lfhyfhzqddhk,Condition(function Trig_lfhyfhzqddhk_Conditions))
call TriggerAddAction(gg_trg_lfhyfhzqddhk,function Trig_lfhyfhzqddhk_Actions)
endfunction
function Trig_lfhytcdhk_Conditions takes nothing returns boolean
return(GetClickedButton()==udg_lfhytcdhk)and(GetTriggerPlayer()==udg_lfhykqzb)
endfunction
function Trig_lfhytcdhk_Actions takes nothing returns nothing
call DialogClear(udg_dhk)
call DialogClear(udg_dqwpdhk)
endfunction
function InitTrig_lfhytcdhk takes nothing returns nothing
set gg_trg_lfhytcdhk=CreateTrigger()
call TriggerRegisterDialogEvent(gg_trg_lfhytcdhk,udg_dhk)
call TriggerAddCondition(gg_trg_lfhytcdhk,Condition(function Trig_lfhytcdhk_Conditions))
call TriggerAddAction(gg_trg_lfhytcdhk,function Trig_lfhytcdhk_Actions)
endfunction