function Trig_MyheroSetESC_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_MyheroSetLeft)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_MyheroSetLeft)
endfunction
function Trig_MyheroSetLeft_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_MyheroSetRight)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_MyheroSetRight)
endfunction
function Trig_MyheroSetRight_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_MyheroSetUp)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_MyheroSetUp)
endfunction
function Trig_MyheroSetUp_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_MyheroSetDown)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_MyheroSetDown)
endfunction
function Trig_MyheroSetDown_Actions takes nothing returns nothing
set udg_MHPlay[GetConvertedPlayerId(GetTriggerPlayer())]=true
call EnableTrigger(gg_trg_HeroGetWeaponAblity)
call TriggerSleepAction(2.00)
call DisableTrigger(gg_trg_HeroGetWeaponAblity)
endfunction
function Trig_HeroGetWeaponAblity_Conditions takes nothing returns boolean
return ((GetOwningPlayer(GetTriggerUnit())==GetTriggerPlayer()))and((IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)))and((udg_MHPlay[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_HeroGetWeaponAblity_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
set udg_HeroCounterC=0
set udg_ZhiZunRBool2=true
set udg_ZhiZunRBool1=true
set udg_MonkUnitMH[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]=GetTriggerUnit()
call PauseUnitBJ(true,GetTriggerUnit())
call SetUnitInvulnerable(GetTriggerUnit(),true)
call AddSpecialEffectTargetUnitBJ("origin",GetTriggerUnit(),"Abilities\\Spells\\Demon\\DarkConversion\\ZombifyTarget.mdl")
call CreateTextTagUnitBJ("TRIGSTR_004",GetTriggerUnit(),0.00,50.00,100,60.00,100,30.00)
call RotateCameraAroundLocBJ(360.00,GetUnitLoc(GetTriggerUnit()),GetOwningPlayer(GetTriggerUnit()),4.70)
set udg_FloatWordM=GetLastCreatedTextTag()
set udg_StartBagO=GetLastCreatedEffectBJ()
call TriggerSleepAction(5.00)
call ResetToGameCameraForPlayer(GetOwningPlayer(GetTriggerUnit()),0)
call DestroyTextTag(udg_FloatWordM)
call DestroyEffect(udg_StartBagO)
call SetUnitVertexColorBJ(udg_MonkUnitMH[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],15.00,15.00,15.00,0)
call SetUnitScalePercent(udg_MonkUnitMH[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],110.00,110.00,110.00)
call PauseUnitBJ(false,udg_MonkUnitMH[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])
call SetUnitInvulnerable(udg_MonkUnitMH[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],false)
call EnableTrigger(gg_trg_WuJiGunA01)
call EnableTrigger(gg_trg_ZhiZunRA01)
call EnableTrigger(gg_trg_GetAnyWhereM)
call EnableTrigger(gg_trg_WuJiGunD01)
call EnableTrigger(gg_trg_ZhiZunRD01)
call EnableTrigger(gg_trg_RemoveWeaponAblity)
endfunction
function Trig_WuJiGunA01_Conditions takes nothing returns boolean
return ((GetAttacker()==udg_MonkUnitMH[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((udg_MHPlay[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))
endfunction
function Trig_WuJiGunA01_Func002Func005001002003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_WuJiGunA01_Func002Func005001002003002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_WuJiGunA01_Func002Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_WuJiGunA01_Func002Func005001002003001(),Trig_WuJiGunA01_Func002Func005001002003002())
endfunction
function Trig_WuJiGunA01_Func002Func005A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Units\\Demon\\Infernal\\InfernalBirth.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroAgi(GetAttacker(),true)))*GetRandomReal(1.00,10.00)),true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_ENHANCED,WEAPON_TYPE_WHOKNOWS)
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_WuJiGunA01_Func002C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))
endfunction
function Trig_WuJiGunA01_Func004Func005001002003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_WuJiGunA01_Func004Func005001002003002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_WuJiGunA01_Func004Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_WuJiGunA01_Func004Func005001002003001(),Trig_WuJiGunA01_Func004Func005001002003002())
endfunction
function Trig_WuJiGunA01_Func004Func005A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Undead\\RaiseSkeletonWarrior\\RaiseSkeleton.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),((I2R(GetHeroLevel(GetAttacker()))*SquareRoot((I2R(GetHeroStr(GetAttacker(),true))+(I2R(GetHeroAgi(GetAttacker(),true))+I2R(GetHeroInt(GetAttacker(),true))))))*GetRandomReal(10.00,20.00)),true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_ENHANCED,WEAPON_TYPE_WHOKNOWS)
endfunction
function Trig_WuJiGunA01_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=8))
endfunction
function Trig_WuJiGunA01_Func006Func005001002003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_WuJiGunA01_Func006Func005001002003002001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_WuJiGunA01_Func006Func005001002003002002001 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_WuJiGunA01_Func006Func005001002003002002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
endfunction
function Trig_WuJiGunA01_Func006Func005001002003002002 takes nothing returns boolean
return GetBooleanAnd(Trig_WuJiGunA01_Func006Func005001002003002002001(),Trig_WuJiGunA01_Func006Func005001002003002002002())
endfunction
function Trig_WuJiGunA01_Func006Func005001002003002 takes nothing returns boolean
return GetBooleanAnd(Trig_WuJiGunA01_Func006Func005001002003002001(),Trig_WuJiGunA01_Func006Func005001002003002002())
endfunction
function Trig_WuJiGunA01_Func006Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_WuJiGunA01_Func006Func005001002003001(),Trig_WuJiGunA01_Func006Func005001002003002())
endfunction
function Trig_WuJiGunA01_Func006Func005A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitOwner(GetEnumUnit(),GetOwningPlayer(GetAttacker()),true)
call SetUnitVertexColorBJ(GetEnumUnit(),0.00,0.00,0.00,50.00)
call SetUnitMoveSpeed(GetEnumUnit(),500.00)
endfunction
function Trig_WuJiGunA01_Func006C takes nothing returns boolean
return ((GetRandomInt(1,100)<=2))
endfunction
function Trig_WuJiGunA01_Func008Func005001002003001 takes nothing returns boolean
return (IsUnitDeadBJ(GetFilterUnit()))
endfunction
function Trig_WuJiGunA01_Func008Func005001002003002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==false)
endfunction
function Trig_WuJiGunA01_Func008Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_WuJiGunA01_Func008Func005001002003001(),Trig_WuJiGunA01_Func008Func005001002003002())
endfunction
function Trig_WuJiGunA01_Func008Func005Func009001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_WuJiGunA01_Func008Func005Func009001003002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_WuJiGunA01_Func008Func005Func009001003 takes nothing returns boolean
return GetBooleanAnd(Trig_WuJiGunA01_Func008Func005Func009001003001(),Trig_WuJiGunA01_Func008Func005Func009001003002())
endfunction
function Trig_WuJiGunA01_Func008Func005Func009A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroAgi(GetAttacker(),true)))*GetRandomReal(1.00,5.00)),true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_ENHANCED,WEAPON_TYPE_WHOKNOWS)
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_WuJiGunA01_Func008Func005A takes nothing returns nothing
set udg_UnitsSelectA=GetEnumUnit()
set udg_PointA=GetUnitLoc(udg_UnitsSelectA)
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Objects\\Spawnmodels\\Human\\HumanLargeDeathExplode\\HumanLargeDeathExplode.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Items\\AIre\\AIreTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(200.00,udg_PointA,Condition(function Trig_WuJiGunA01_Func008Func005Func009001003)),function Trig_WuJiGunA01_Func008Func005Func009A)
call RemoveUnit(udg_UnitsSelectA)
call RemoveLocation(udg_PointA)
endfunction
function Trig_WuJiGunA01_Func008C takes nothing returns boolean
return ((GetRandomInt(1,100)<=10))
endfunction
function Trig_WuJiGunA01_Actions takes nothing returns nothing
if (Trig_WuJiGunA01_Func002C()) then
call CreateTextTagUnitBJ(("|cFFFFFF00鬼魔地狱火|r"+"|cFF1FBF00发动！|r"),GetAttacker(),0,10,100,100,100,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(10,GetUnitsInRangeOfLocMatching(600.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_WuJiGunA01_Func002Func005001002003))),function Trig_WuJiGunA01_Func002Func005A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
return
endif
if (Trig_WuJiGunA01_Func004C()) then
call CreateTextTagUnitBJ(("|cFFFFFF00邪恶突袭|r"+"|cFF1FBF00发动！|r"),GetAttacker(),0,10,100,100,100,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(16,GetUnitsInRangeOfLocMatching(700.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_WuJiGunA01_Func004Func005001002003))),function Trig_WuJiGunA01_Func004Func005A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
return
endif
if (Trig_WuJiGunA01_Func006C()) then
call CreateTextTagUnitBJ(("|cFFFFFF00黑暗召唤|r"+"|cFF1FBF00发动！|r"),GetAttacker(),0,10,100,100,100,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(4,GetUnitsInRangeOfLocMatching(500.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_WuJiGunA01_Func006Func005001002003))),function Trig_WuJiGunA01_Func006Func005A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
return
endif
if (Trig_WuJiGunA01_Func008C()) then
call CreateTextTagUnitBJ(("|cFFFFFF00鬼魔尸爆|r"+"|cFF1FBF00发动！|r"),GetAttacker(),0,10,100,100,100,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(10,GetUnitsInRangeOfLocMatching(700.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_WuJiGunA01_Func008Func005001002003))),function Trig_WuJiGunA01_Func008Func005A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
return
endif
endfunction
function Trig_WuJiGunD01_Func004C takes nothing returns boolean
return ((GetKillingUnitBJ()==udg_MonkUnitMH[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((udg_MHPlay[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetRandomInt(1,100)<=4))
endfunction
function Trig_WuJiGunD01_Conditions takes nothing returns boolean
return (Trig_WuJiGunD01_Func004C())
endfunction
function Trig_WuJiGunD01_Actions takes nothing returns nothing
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,5)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,5)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,5)
endfunction
function Trig_ZhiZunRA01_Conditions takes nothing returns boolean
return ((GetTriggerUnit()==udg_MonkUnitMH[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))and((udg_MHPlay[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))
endfunction
function Trig_ZhiZunRA01_Func002Func007001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_ZhiZunRA01_Func002Func007001003002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetTriggerUnit())))
endfunction
function Trig_ZhiZunRA01_Func002Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_ZhiZunRA01_Func002Func007001003001(),Trig_ZhiZunRA01_Func002Func007001003002())
endfunction
function Trig_ZhiZunRA01_Func002Func007A takes nothing returns nothing
set udg_ZhiZunRCC1=(udg_ZhiZunRCC1+1)
set udg_ZhiZunREU1[udg_ZhiZunRCC1]=GetEnumUnit()
call PauseUnitBJ(true,GetEnumUnit())
set udg_ZhiZunRTeX1[udg_ZhiZunRCC1]=AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Undead\\Darksummoning\\DarkSummonTarget.mdl")
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_ZhiZunRA01_Func002C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))and((udg_ZhiZunRBool1))
endfunction
function Trig_ZhiZunRA01_Func004Func007001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_ZhiZunRA01_Func004Func007001003002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetTriggerUnit())))
endfunction
function Trig_ZhiZunRA01_Func004Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_ZhiZunRA01_Func004Func007001003001(),Trig_ZhiZunRA01_Func004Func007001003002())
endfunction
function Trig_ZhiZunRA01_Func004Func007A takes nothing returns nothing
set udg_ZhiZunRCC2=(udg_ZhiZunRCC2+1)
set udg_ZhiZunREU2[udg_ZhiZunRCC2]=GetEnumUnit()
call PauseUnitBJ(true,GetEnumUnit())
set udg_ZhiZunRTeX2[udg_ZhiZunRCC2]=AddLightningLoc("LEAS",GetUnitLoc(GetTriggerUnit()),GetUnitLoc(GetEnumUnit()))
call UnitDamageTarget(GetTriggerUnit(),GetEnumUnit(),((I2R(GetHeroLevel(GetTriggerUnit()))*I2R(GetHeroAgi(GetTriggerUnit(),true)))*GetRandomReal(2.00,5.00)),true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_ENHANCED,WEAPON_TYPE_WHOKNOWS)
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_ZhiZunRA01_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))and((udg_ZhiZunRBool2))
endfunction
function Trig_ZhiZunRA01_Actions takes nothing returns nothing
if (Trig_ZhiZunRA01_Func002C()) then
call CreateTextTagUnitBJ(("|cFFFFFF00鬼魔反击之封印|r"+"|cFF1FBF00发动！|r"),GetAttacker(),0,10,100,100,100,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
set udg_ZhiZunRBool1=false
set udg_ZhiZunRCC1=0
call ForGroupBJ(GetUnitsInRangeOfLocMatching(600.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_ZhiZunRA01_Func002Func007001003)),function Trig_ZhiZunRA01_Func002Func007A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
call TriggerSleepAction(5.00)
call TriggerExecute(gg_trg_ZhiZunRA11)
return
endif
if (Trig_ZhiZunRA01_Func004C()) then
call CreateTextTagUnitBJ(("|cFFFFFF00鬼魔反击之困锁|r"+"|cFF1FBF00发动！|r"),GetAttacker(),0,10,100,100,100,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
set udg_ZhiZunRBool2=false
set udg_ZhiZunRCC2=0
call ForGroupBJ(GetUnitsInRangeOfLocMatching(600.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_ZhiZunRA01_Func004Func007001003)),function Trig_ZhiZunRA01_Func004Func007A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
call TriggerSleepAction(0.30)
call TriggerExecute(gg_trg_ZhiZunRA12)
endif
endfunction
function Trig_ZhiZunRD01_Conditions takes nothing returns boolean
return ((GetTriggerUnit()==udg_MonkUnitMH[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))and((udg_MHPlay[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))
endfunction
function Trig_ZhiZunRD01_Actions takes nothing returns nothing
call ModifyHeroStat(bj_HEROSTAT_STR,GetTriggerUnit(),bj_MODIFYMETHOD_ADD,10)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetTriggerUnit(),bj_MODIFYMETHOD_ADD,10)
call ModifyHeroStat(bj_HEROSTAT_INT,GetTriggerUnit(),bj_MODIFYMETHOD_ADD,10)
endfunction
function Trig_ZhiZunRA11_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=udg_ZhiZunRCC1
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call PauseUnitBJ(false,udg_ZhiZunREU1[GetForLoopIndexA()])
call DestroyEffect(udg_ZhiZunRTeX1[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set udg_ZhiZunRBool1=true
call DisableTrigger(GetTriggeringTrigger())
endfunction
function Trig_ZhiZunRA12_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=udg_ZhiZunRCC2
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyLightning(udg_ZhiZunRTeX2[GetForLoopIndexA()])
call PauseUnitBJ(false,udg_ZhiZunREU2[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set udg_ZhiZunRBool2=true
call DisableTrigger(GetTriggeringTrigger())
endfunction
function Trig_GetAnyWhereM_Conditions takes nothing returns boolean
return ((GetTriggerUnit()==udg_MonkUnitMH[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))and((GetIssuedOrderIdBJ()==String2OrderIdBJ("patrol")))and((udg_MHPlay[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))
endfunction
function Trig_GetAnyWhereM_Actions takes nothing returns nothing
call SetUnitPositionLoc(GetTriggerUnit(),GetOrderPointLoc())
endfunction
function Trig_RemoveWeaponAblity_Conditions takes nothing returns boolean
return ((udg_MHPlay[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_RemoveWeaponAblity_Actions takes nothing returns nothing
set udg_MHPlay[GetConvertedPlayerId(GetTriggerPlayer())]=false
call DisableTrigger(gg_trg_GetAnyWhereM)
call DisableTrigger(gg_trg_WuJiGunA01)
call DisableTrigger(gg_trg_WuJiGunD01)
call DisableTrigger(gg_trg_ZhiZunRA01)
call DisableTrigger(gg_trg_ZhiZunRD01)
call SetUnitVertexColorBJ(udg_MonkUnitMH[GetConvertedPlayerId(GetTriggerPlayer())],100.00,100.00,100.00,0)
call SetUnitScalePercent(udg_MonkUnitMH[GetConvertedPlayerId(GetTriggerPlayer())],100.00,100.00,100.00)
call DisableTrigger(GetTriggeringTrigger())
endfunction
function Trig_MapMasterMonkOpen_Conditions takes nothing returns boolean
return ((GetTriggerPlayer()==Player(0)))
endfunction
function Trig_MapMasterMonkOpen_Func001Func002C takes nothing returns boolean
return ((GetEventPlayerChatString()=="退出魔道"))
endfunction
function Trig_MapMasterMonkOpen_Func001C takes nothing returns boolean
return ((GetEventPlayerChatString()=="魔道 打开"))
endfunction
function Trig_MapMasterMonkOpen_Actions takes nothing returns nothing
if (Trig_MapMasterMonkOpen_Func001C()) then
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" 邪恶之神包子已经将他邪恶之气传于你了；如果想进退输入退出魔道即可 另外两个  一.输入 邪神附体二.我要修仙    切忌先输入‘包子’才能开启以上技能")))
call TriggerExecute(gg_trg_MonkSelectDilog)
call EnableTrigger(gg_trg_FengYinMonk)
else
if (Trig_MapMasterMonkOpen_Func001Func002C()) then
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" |cFFFFFF00关闭了魔道 !!!!!!!!!!!!!|r"+" 任何人无法再进入魔道。")))
call DisableTrigger(gg_trg_NormalPlayerHack)
endif
endif
endfunction
function Trig_NormalPlayerHack_Conditions takes nothing returns boolean
return ((udg_PlayerTIDD[GetConvertedPlayerId(GetTriggerPlayer())]==false))and((udg_MonkHUnitBool[GetConvertedPlayerId(GetTriggerPlayer())]==false))
endfunction
function Trig_NormalPlayerHack_Func001Func001C takes nothing returns boolean
return ((udg_MonkSelectHackBool==false))
endfunction
function Trig_NormalPlayerHack_Func001C takes nothing returns boolean
return ((udg_MonkHackRandomBool))
endfunction
function Trig_NormalPlayerHack_Actions takes nothing returns nothing
if (Trig_NormalPlayerHack_Func001C()) then
set udg_MonkHackPlayer=GetTriggerPlayer()
set udg_Monk[GetConvertedPlayerId(udg_MonkHackPlayer)]=GetRandomInt(1,8)
call ConditionalTriggerExecute(gg_trg_NormalMoDaoHack)
else
if (Trig_NormalPlayerHack_Func001Func001C()) then
set udg_MonkSelectHackBool=true
set udg_MonkHackPlayer=GetTriggerPlayer()
call DialogClear(udg_DilogSelect)
call DialogSetMessage(udg_DilogSelect,("魔道选择"+""))
set udg_MonkButton[3]=DialogAddButtonBJ(udg_DilogSelect,("冰魔"+" 智"))
set udg_MonkButton[4]=DialogAddButtonBJ(udg_DilogSelect,("火魔"+" 智"))
set udg_MonkButton[5]=DialogAddButtonBJ(udg_DilogSelect,("金魔"+" 力"))
set udg_MonkButton[6]=DialogAddButtonBJ(udg_DilogSelect,("雷魔"+" 力"))
set udg_MonkButton[7]=DialogAddButtonBJ(udg_DilogSelect,("木魔"+" 敏"))
set udg_MonkButton[8]=DialogAddButtonBJ(udg_DilogSelect,("水魔"+" 敏智"))
set udg_MonkButton[9]=DialogAddButtonBJ(udg_DilogSelect,("亡魔"+" 敏"))
set udg_MonkButton[10]=DialogAddButtonBJ(udg_DilogSelect,("月魔"+" 敏"))
call DialogDisplay(udg_MonkHackPlayer,udg_DilogSelect,true)
else
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+" 正在选择入魔 请稍后再入魔。。。。"))
endif
endif
endfunction
function Trig_NormalMoDaoHack_Conditions takes nothing returns boolean
return ((udg_MonkHUnitBool[GetConvertedPlayerId(udg_MonkHackPlayer)]==false))and((udg_PlayerTIDD[GetConvertedPlayerId(udg_MonkHackPlayer)]==false))
endfunction
function Trig_NormalMoDaoHack_Func004Func001Func002Func002Func001Func002Func001Func001C takes nothing returns boolean
return ((udg_Monk[GetConvertedPlayerId(udg_MonkHackPlayer)]==8))
endfunction
function Trig_NormalMoDaoHack_Func004Func001Func002Func002Func001Func002Func001C takes nothing returns boolean
return ((udg_Monk[GetConvertedPlayerId(udg_MonkHackPlayer)]==7))
endfunction
function Trig_NormalMoDaoHack_Func004Func001Func002Func002Func001Func002C takes nothing returns boolean
return ((udg_Monk[GetConvertedPlayerId(udg_MonkHackPlayer)]==6))
endfunction
function Trig_NormalMoDaoHack_Func004Func001Func002Func002Func001C takes nothing returns boolean
return ((udg_Monk[GetConvertedPlayerId(udg_MonkHackPlayer)]==5))
endfunction
function Trig_NormalMoDaoHack_Func004Func001Func002Func002C takes nothing returns boolean
return ((udg_Monk[GetConvertedPlayerId(udg_MonkHackPlayer)]==4))
endfunction
function Trig_NormalMoDaoHack_Func004Func001Func002C takes nothing returns boolean
return ((udg_Monk[GetConvertedPlayerId(udg_MonkHackPlayer)]==3))
endfunction
function Trig_NormalMoDaoHack_Func004Func001C takes nothing returns boolean
return ((udg_Monk[GetConvertedPlayerId(udg_MonkHackPlayer)]==2))
endfunction
function Trig_NormalMoDaoHack_Func004C takes nothing returns boolean
return ((udg_Monk[GetConvertedPlayerId(udg_MonkHackPlayer)]==1))
endfunction
function Trig_NormalMoDaoHack_Actions takes nothing returns nothing
set udg_PlayerTIDD[GetConvertedPlayerId(udg_MonkHackPlayer)]=true
if (Trig_NormalMoDaoHack_Func004C()) then
set udg_BingMo[GetConvertedPlayerId(udg_MonkHackPlayer)]=true
set udg_BingWeaponL[GetConvertedPlayerId(udg_MonkHackPlayer)]=1
set udg_WeaponLevelUp[GetConvertedPlayerId(udg_MonkHackPlayer)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_MonkHackPlayer)+("  已经入了-<冰魔>-"+"！ 请马上选择你要进入的英雄！")))
else
if (Trig_NormalMoDaoHack_Func004Func001C()) then
set udg_HuoMo[GetConvertedPlayerId(udg_MonkHackPlayer)]=true
set udg_HuoWeaponL[GetConvertedPlayerId(udg_MonkHackPlayer)]=1
set udg_WeaponLevelUp[GetConvertedPlayerId(udg_MonkHackPlayer)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_MonkHackPlayer)+("  已经入了-<火魔>-"+"！ 请马上选择你要进入的英雄！")))
else
if (Trig_NormalMoDaoHack_Func004Func001Func002C()) then
set udg_JinMo[GetConvertedPlayerId(udg_MonkHackPlayer)]=true
set udg_JinWeaponL[GetConvertedPlayerId(udg_MonkHackPlayer)]=1
set udg_WeaponLevelUp[GetConvertedPlayerId(udg_MonkHackPlayer)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_MonkHackPlayer)+("  已经入了-<金魔>-"+"！ 请马上选择你要进入的英雄！")))
else
if (Trig_NormalMoDaoHack_Func004Func001Func002Func002C()) then
set udg_LeiMo[GetConvertedPlayerId(udg_MonkHackPlayer)]=true
set udg_LeiWeaponL[GetConvertedPlayerId(udg_MonkHackPlayer)]=1
set udg_WeaponLevelUp[GetConvertedPlayerId(udg_MonkHackPlayer)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_MonkHackPlayer)+("  已经入了-<雷魔>-"+"！ 请马上选择你要进入的英雄！")))
else
if (Trig_NormalMoDaoHack_Func004Func001Func002Func002Func001C()) then
set udg_MuMo[GetConvertedPlayerId(udg_MonkHackPlayer)]=true
set udg_MuWeaponL[GetConvertedPlayerId(udg_MonkHackPlayer)]=1
set udg_WeaponLevelUp[GetConvertedPlayerId(udg_MonkHackPlayer)]=0
set udg_WeaponBool[1]=true
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_MonkHackPlayer)+("  已经入了-<木魔>-"+"！ 请马上选择你要进入的英雄！")))
else
if (Trig_NormalMoDaoHack_Func004Func001Func002Func002Func001Func002C()) then
set udg_ShuiMo[GetConvertedPlayerId(udg_MonkHackPlayer)]=true
set udg_ShuiWeaponL[GetConvertedPlayerId(udg_MonkHackPlayer)]=1
set udg_WeaponLevelUp[GetConvertedPlayerId(udg_MonkHackPlayer)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_MonkHackPlayer)+("  已经入了-<水魔>-"+"！ 请马上选择你要进入的英雄！")))
else
if (Trig_NormalMoDaoHack_Func004Func001Func002Func002Func001Func002Func001C()) then
set udg_WangMo[GetConvertedPlayerId(udg_MonkHackPlayer)]=true
set udg_WangWeaponL[GetConvertedPlayerId(udg_MonkHackPlayer)]=1
set udg_WeaponLevelUp[GetConvertedPlayerId(udg_MonkHackPlayer)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_MonkHackPlayer)+("  已经入了-<亡魔>-"+"！ 请马上选择你要进入的英雄！")))
else
if (Trig_NormalMoDaoHack_Func004Func001Func002Func002Func001Func002Func001Func001C()) then
set udg_YueMo[GetConvertedPlayerId(udg_MonkHackPlayer)]=true
set udg_YueWeaponL[GetConvertedPlayerId(udg_MonkHackPlayer)]=1
set udg_WeaponLevelUp[GetConvertedPlayerId(udg_MonkHackPlayer)]=0
set udg_WeaponBool[2]=true
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_MonkHackPlayer)+("  已经入了-<月魔>-"+"！ 请马上选择你要进入的英雄！")))
else
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_MonkHackPlayer)+" 妄图进入魔道，但因邪恶度不够，你永久不可以入魔道！"))
endif
endif
endif
endif
endif
endif
endif
endif
endfunction
function Trig_MonkSelectDilog_Actions takes nothing returns nothing
call DialogClear(udg_DilogMain)
call DialogSetMessage(udg_DilogMain,("选择入魔方式"+""))
set udg_MonkButton[1]=DialogAddButtonBJ(udg_DilogMain,("随机模式"+""))
set udg_MonkButton[2]=DialogAddButtonBJ(udg_DilogMain,("选择模式"+""))
call DialogDisplay(Player(0),udg_DilogMain,true)
endfunction
function Trig_MonkSelectDilogClink_Func002Func001Func003Func003Func003Func003Func003Func001C takes nothing returns boolean
return ((GetClickedButtonBJ()==udg_MonkButton[10]))
endfunction
function Trig_MonkSelectDilogClink_Func002Func001Func003Func003Func003Func003Func003C takes nothing returns boolean
return ((GetClickedButtonBJ()==udg_MonkButton[9]))
endfunction
function Trig_MonkSelectDilogClink_Func002Func001Func003Func003Func003Func003C takes nothing returns boolean
return ((GetClickedButtonBJ()==udg_MonkButton[8]))
endfunction
function Trig_MonkSelectDilogClink_Func002Func001Func003Func003Func003C takes nothing returns boolean
return ((GetClickedButtonBJ()==udg_MonkButton[7]))
endfunction
function Trig_MonkSelectDilogClink_Func002Func001Func003Func003C takes nothing returns boolean
return ((GetClickedButtonBJ()==udg_MonkButton[6]))
endfunction
function Trig_MonkSelectDilogClink_Func002Func001Func003C takes nothing returns boolean
return ((GetClickedButtonBJ()==udg_MonkButton[5]))
endfunction
function Trig_MonkSelectDilogClink_Func002Func001C takes nothing returns boolean
return ((GetClickedButtonBJ()==udg_MonkButton[4]))
endfunction
function Trig_MonkSelectDilogClink_Func002C takes nothing returns boolean
return ((GetClickedButtonBJ()==udg_MonkButton[3]))
endfunction
function Trig_MonkSelectDilogClink_Actions takes nothing returns nothing
if (Trig_MonkSelectDilogClink_Func002C()) then
set udg_PlayerTIDD[GetConvertedPlayerId(udg_MonkHackPlayer)]=true
set udg_BingMo[GetConvertedPlayerId(udg_MonkHackPlayer)]=true
set udg_BingWeaponL[GetConvertedPlayerId(udg_MonkHackPlayer)]=1
set udg_WeaponLevelUp[GetConvertedPlayerId(udg_MonkHackPlayer)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_MonkHackPlayer)+("  已经入了-<冰魔>-"+"！ 请马上选择你要进入的英雄！")))
set udg_MonkSelectHackBool=false
call DialogDisplay(udg_MonkHackPlayer,udg_DilogSelect,false)
else
if (Trig_MonkSelectDilogClink_Func002Func001C()) then
set udg_PlayerTIDD[GetConvertedPlayerId(udg_MonkHackPlayer)]=true
set udg_HuoMo[GetConvertedPlayerId(udg_MonkHackPlayer)]=true
set udg_HuoWeaponL[GetConvertedPlayerId(udg_MonkHackPlayer)]=1
set udg_WeaponLevelUp[GetConvertedPlayerId(udg_MonkHackPlayer)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_MonkHackPlayer)+("  已经入了-<火魔>-"+"！ 请马上选择你要进入的英雄！")))
set udg_MonkSelectHackBool=false
call DialogDisplay(udg_MonkHackPlayer,udg_DilogSelect,false)
else
if (Trig_MonkSelectDilogClink_Func002Func001Func003C()) then
set udg_PlayerTIDD[GetConvertedPlayerId(udg_MonkHackPlayer)]=true
set udg_JinMo[GetConvertedPlayerId(udg_MonkHackPlayer)]=true
set udg_JinWeaponL[GetConvertedPlayerId(udg_MonkHackPlayer)]=1
set udg_WeaponLevelUp[GetConvertedPlayerId(udg_MonkHackPlayer)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_MonkHackPlayer)+("  已经入了-<金魔>-"+"！ 请马上选择你要进入的英雄！")))
set udg_MonkSelectHackBool=false
call DialogDisplay(udg_MonkHackPlayer,udg_DilogSelect,false)
else
if (Trig_MonkSelectDilogClink_Func002Func001Func003Func003C()) then
set udg_PlayerTIDD[GetConvertedPlayerId(udg_MonkHackPlayer)]=true
set udg_LeiMo[GetConvertedPlayerId(udg_MonkHackPlayer)]=true
set udg_LeiWeaponL[GetConvertedPlayerId(udg_MonkHackPlayer)]=1
set udg_WeaponLevelUp[GetConvertedPlayerId(udg_MonkHackPlayer)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_MonkHackPlayer)+("  已经入了-<雷魔>-"+"！ 请马上选择你要进入的英雄！")))
set udg_MonkSelectHackBool=false
call DialogDisplay(udg_MonkHackPlayer,udg_DilogSelect,false)
else
if (Trig_MonkSelectDilogClink_Func002Func001Func003Func003Func003C()) then
set udg_PlayerTIDD[GetConvertedPlayerId(udg_MonkHackPlayer)]=true
set udg_MuMo[GetConvertedPlayerId(udg_MonkHackPlayer)]=true
set udg_MuWeaponL[GetConvertedPlayerId(udg_MonkHackPlayer)]=1
set udg_WeaponLevelUp[GetConvertedPlayerId(udg_MonkHackPlayer)]=0
set udg_WeaponBool[1]=true
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_MonkHackPlayer)+("  已经入了-<木魔>-"+"！ 请马上选择你要进入的英雄！")))
set udg_MonkSelectHackBool=false
call DialogDisplay(udg_MonkHackPlayer,udg_DilogSelect,false)
else
if (Trig_MonkSelectDilogClink_Func002Func001Func003Func003Func003Func003C()) then
set udg_PlayerTIDD[GetConvertedPlayerId(udg_MonkHackPlayer)]=true
set udg_ShuiMo[GetConvertedPlayerId(udg_MonkHackPlayer)]=true
set udg_ShuiWeaponL[GetConvertedPlayerId(udg_MonkHackPlayer)]=1
set udg_WeaponLevelUp[GetConvertedPlayerId(udg_MonkHackPlayer)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_MonkHackPlayer)+("  已经入了-<水魔>-"+"！ 请马上选择你要进入的英雄！")))
set udg_MonkSelectHackBool=false
call DialogDisplay(udg_MonkHackPlayer,udg_DilogSelect,false)
else
if (Trig_MonkSelectDilogClink_Func002Func001Func003Func003Func003Func003Func003C()) then
set udg_PlayerTIDD[GetConvertedPlayerId(udg_MonkHackPlayer)]=true
set udg_WangMo[GetConvertedPlayerId(udg_MonkHackPlayer)]=true
set udg_WangWeaponL[GetConvertedPlayerId(udg_MonkHackPlayer)]=1
set udg_WeaponLevelUp[GetConvertedPlayerId(udg_MonkHackPlayer)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_MonkHackPlayer)+("  已经入了-<亡魔>-"+"！ 请马上选择你要进入的英雄！")))
set udg_MonkSelectHackBool=false
call DialogDisplay(udg_MonkHackPlayer,udg_DilogSelect,false)
else
if (Trig_MonkSelectDilogClink_Func002Func001Func003Func003Func003Func003Func003Func001C()) then
set udg_PlayerTIDD[GetConvertedPlayerId(udg_MonkHackPlayer)]=true
set udg_YueMo[GetConvertedPlayerId(udg_MonkHackPlayer)]=true
set udg_YueWeaponL[GetConvertedPlayerId(udg_MonkHackPlayer)]=1
set udg_WeaponLevelUp[GetConvertedPlayerId(udg_MonkHackPlayer)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_MonkHackPlayer)+("  已经入了-<月魔>-"+"！ 请马上选择你要进入的英雄！")))
set udg_MonkSelectHackBool=false
call DialogDisplay(udg_MonkHackPlayer,udg_DilogSelect,false)
endif
endif
endif
endif
endif
endif
endif
endif
endfunction
function Trig_MonkMainDilogClink_Func001C takes nothing returns boolean
return ((GetClickedButtonBJ()==udg_MonkButton[1]))
endfunction
function Trig_MonkMainDilogClink_Actions takes nothing returns nothing
if (Trig_MonkMainDilogClink_Func001C()) then
call DisplayTextToForce(GetPlayersAll(),("玩家1 选择了随机入魔的方式 请各玩家输入“进入魔道”入魔！"+""))
set udg_MonkHackRandomBool=true
call EnableTrigger(gg_trg_NormalPlayerHack)
call DialogDestroy(udg_DilogMain)
else
call DisplayTextToForce(GetPlayersAll(),("玩家1 选择了选择入魔的方式 请各玩家输入“进入魔道”入魔对话框选择！"+""))
set udg_MonkHackRandomBool=false
call EnableTrigger(gg_trg_NormalPlayerHack)
call DialogDestroy(udg_DilogMain)
endif
endfunction
function Trig_RemoveWeaponAblityNoralPlayer_Func001Func001Func001Func001Func001Func001Func001Func001C takes nothing returns boolean
return ((udg_YueMo[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_RemoveWeaponAblityNoralPlayer_Func001Func001Func001Func001Func001Func001Func001C takes nothing returns boolean
return ((udg_WangMo[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_RemoveWeaponAblityNoralPlayer_Func001Func001Func001Func001Func001Func001C takes nothing returns boolean
return ((udg_MuMo[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_RemoveWeaponAblityNoralPlayer_Func001Func001Func001Func001Func001C takes nothing returns boolean
return ((udg_ShuiMo[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_RemoveWeaponAblityNoralPlayer_Func001Func001Func001Func001C takes nothing returns boolean
return ((udg_LeiMo[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_RemoveWeaponAblityNoralPlayer_Func001Func001Func001C takes nothing returns boolean
return ((udg_HuoMo[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_RemoveWeaponAblityNoralPlayer_Func001Func001C takes nothing returns boolean
return ((udg_BingMo[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_RemoveWeaponAblityNoralPlayer_Func001C takes nothing returns boolean
return ((udg_JinMo[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_RemoveWeaponAblityNoralPlayer_Actions takes nothing returns nothing
if (Trig_RemoveWeaponAblityNoralPlayer_Func001C()) then
set udg_JinMo[GetConvertedPlayerId(GetTriggerPlayer())]=false
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" 的英雄 "+(GetHeroProperName(udg_MonkUnitMH[GetConvertedPlayerId(GetTriggerPlayer())])+" 退出了魔道！"))))
else
if (Trig_RemoveWeaponAblityNoralPlayer_Func001Func001C()) then
set udg_BingMo[GetConvertedPlayerId(GetTriggerPlayer())]=false
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" 的英雄 "+(GetHeroProperName(udg_MonkUnitMH[GetConvertedPlayerId(GetTriggerPlayer())])+" 退出了魔道！"))))
else
if (Trig_RemoveWeaponAblityNoralPlayer_Func001Func001Func001C()) then
set udg_HuoMo[GetConvertedPlayerId(GetTriggerPlayer())]=false
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" 的英雄 "+(GetHeroProperName(udg_MonkUnitMH[GetConvertedPlayerId(GetTriggerPlayer())])+" 退出了魔道！"))))
else
if (Trig_RemoveWeaponAblityNoralPlayer_Func001Func001Func001Func001C()) then
set udg_LeiMo[GetConvertedPlayerId(GetTriggerPlayer())]=false
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" 的英雄 "+(GetHeroProperName(udg_MonkUnitMH[GetConvertedPlayerId(GetTriggerPlayer())])+" 退出了魔道！"))))
else
if (Trig_RemoveWeaponAblityNoralPlayer_Func001Func001Func001Func001Func001C()) then
set udg_ShuiMo[GetConvertedPlayerId(GetTriggerPlayer())]=false
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" 的英雄 "+(GetHeroProperName(udg_MonkUnitMH[GetConvertedPlayerId(GetTriggerPlayer())])+" 退出了魔道！"))))
else
if (Trig_RemoveWeaponAblityNoralPlayer_Func001Func001Func001Func001Func001Func001C()) then
set udg_MuMo[GetConvertedPlayerId(GetTriggerPlayer())]=false
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" 的英雄 "+(GetHeroProperName(udg_MonkUnitMH[GetConvertedPlayerId(GetTriggerPlayer())])+" 退出了魔道！"))))
else
if (Trig_RemoveWeaponAblityNoralPlayer_Func001Func001Func001Func001Func001Func001Func001C()) then
set udg_WangMo[GetConvertedPlayerId(GetTriggerPlayer())]=false
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" 的英雄 "+(GetHeroProperName(udg_MonkUnitMH[GetConvertedPlayerId(GetTriggerPlayer())])+" 退出了魔道！"))))
else
if (Trig_RemoveWeaponAblityNoralPlayer_Func001Func001Func001Func001Func001Func001Func001Func001C()) then
set udg_YueMo[GetConvertedPlayerId(GetTriggerPlayer())]=false
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" 的英雄 "+(GetHeroProperName(udg_MonkUnitMH[GetConvertedPlayerId(GetTriggerPlayer())])+" 退出了魔道！"))))
else
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,(GetPlayerName(GetTriggerPlayer())+" 你还没有入魔！"))
endif
endif
endif
endif
endif
endif
endif
endif
endfunction
function Trig_NormalPlayerSelect_Conditions takes nothing returns boolean
return ((udg_MonkHUnitBool[GetConvertedPlayerId(GetTriggerPlayer())]==false))and((udg_PlayerTIDD[GetConvertedPlayerId(GetTriggerPlayer())]))and((GetOwningPlayer(GetTriggerUnit())==GetTriggerPlayer()))and((GetTriggerUnit()!=udg_MonkUnitMH[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_NormalPlayerSelect_Actions takes nothing returns nothing
set udg_MonkUnitMH[GetConvertedPlayerId(GetTriggerPlayer())]=GetTriggerUnit()
set udg_MonkHUnitBool[GetConvertedPlayerId(GetTriggerPlayer())]=true
call CreateTextTagUnitBJ(((("|cFFFFFF00"+GetHeroProperName(GetTriggerUnit()))+"|r ")+"|cFFFF0033入魔成功！|r"),GetTriggerUnit(),0,20.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
endfunction
function Trig_JinWeapon_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))and((udg_JinMo[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)))and((GetAttacker()==udg_MonkUnitMH[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))
endfunction
function Trig_JinWeapon_Func002C takes nothing returns boolean
return ((GetUnitLifePercent(GetAttacker())<=80.00))
endfunction
function Trig_JinWeapon_Func003C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))
endfunction
function Trig_JinWeapon_Func004Func011001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_JinWeapon_Func004Func011001003002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_JinWeapon_Func004Func011001003 takes nothing returns boolean
return GetBooleanAnd(Trig_JinWeapon_Func004Func011001003001(),Trig_JinWeapon_Func004Func011001003002())
endfunction
function Trig_JinWeapon_Func004Func011A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\Transmute\\PileofGold.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),(I2R(GetHeroStr(GetAttacker(),true))*(I2R(udg_JinWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])*(I2R(GetHeroLevel(GetAttacker()))*GetRandomReal(10.00,50.00)))),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
endfunction
function Trig_JinWeapon_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))
endfunction
function Trig_JinWeapon_Func005Func005001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_JinWeapon_Func005Func005001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_JinWeapon_Func005Func005001003002002001 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_JinWeapon_Func005Func005001003002002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
endfunction
function Trig_JinWeapon_Func005Func005001003002002 takes nothing returns boolean
return GetBooleanAnd(Trig_JinWeapon_Func005Func005001003002002001(),Trig_JinWeapon_Func005Func005001003002002002())
endfunction
function Trig_JinWeapon_Func005Func005001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_JinWeapon_Func005Func005001003002001(),Trig_JinWeapon_Func005Func005001003002002())
endfunction
function Trig_JinWeapon_Func005Func005001003 takes nothing returns boolean
return GetBooleanAnd(Trig_JinWeapon_Func005Func005001003001(),Trig_JinWeapon_Func005Func005001003002())
endfunction
function Trig_JinWeapon_Func005Func005A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\MarkOfChaos\\MarkOfChaosTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),(I2R(GetHeroStr(GetAttacker(),true))*(I2R(udg_JinWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])*(I2R(GetHeroLevel(GetAttacker()))*GetRandomReal(5.00,20.00)))),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
endfunction
function Trig_JinWeapon_Func005C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))
endfunction
function Trig_JinWeapon_Func006C takes nothing returns boolean
return ((RAbsBJ((GetUnitFacing(GetTriggerUnit())-GetUnitFacing(GetAttacker())))<=60.00))
endfunction
function Trig_JinWeapon_Actions takes nothing returns nothing
if (Trig_JinWeapon_Func002C()) then
call AddSpecialEffectTargetUnitBJ("origin",GetAttacker(),"Abilities\\Spells\\Orc\\Disenchant\\DisenchantSpecialArt.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitLifePercentBJ(GetAttacker(),(GetUnitLifePercent(GetAttacker())+3.00))
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"吸血之刃")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
endif
if (Trig_JinWeapon_Func003C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"金魔之罩")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\Orc\\Voodoo\\VoodooAuraTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitManaBJ(GetTriggerUnit(),0)
call UnitDamageTargetBJ(GetAttacker(),GetTriggerUnit(),((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroStr(GetAttacker(),true)))*I2R(udg_JinWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
call PauseUnitBJ(true,GetTriggerUnit())
call TriggerSleepAction(3.00)
call PauseUnitBJ(false,GetTriggerUnit())
endif
if (Trig_JinWeapon_Func004C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"金魔之怒")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectTargetUnitBJ("origin",GetAttacker(),"Abilities\\Spells\\Human\\DivineShield\\DivineShieldTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(GetUnitLoc(GetAttacker()),"Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("origin",GetAttacker(),"Abilities\\Spells\\NightElf\\FanOfKnives\\FanOfKnivesCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(400.00,GetUnitLoc(GetAttacker()),Condition(function Trig_JinWeapon_Func004Func011001003)),function Trig_JinWeapon_Func004Func011A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
if (Trig_JinWeapon_Func005C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"金魔妖气")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(400.00,GetUnitLoc(GetAttacker()),Condition(function Trig_JinWeapon_Func005Func005001003)),function Trig_JinWeapon_Func005Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
if (Trig_JinWeapon_Func006C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"背击噬魂")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectTargetUnitBJ("chest",GetTriggerUnit(),"Objects\\Spawnmodels\\Critters\\Albatross\\CritterBloodAlbatross.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetTriggerUnit(),(I2R(GetHeroLevel(GetAttacker()))*(SquareRoot(I2R(GetHeroAgi(GetAttacker(),true)))*(I2R(udg_JinWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])*GetRandomReal(10.00,100.00)))),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
endif
endfunction
function Trig_JinWeaponUP_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetKillingUnitBJ()))))and((udg_JinMo[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetKillingUnitBJ()==udg_MonkUnitMH[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)))
endfunction
function Trig_JinWeaponUP_Func003C takes nothing returns boolean
return ((udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=150))
endfunction
function Trig_JinWeaponUP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_JinWeaponUP_Actions takes nothing returns nothing
set udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_JinWeaponUP_Func003C()) then
set udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_JinWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_JinWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000金魔之斩魂刀|r熟练度为 ")+I2S(udg_JinWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000金魔之斩魂刀|r "+(I2S(udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/200")))
endif
if (Trig_JinWeaponUP_Func004C()) then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,5)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,3)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,2)
endif
endfunction
function Trig_BingWeapon_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))and((udg_BingMo[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)))and((GetAttacker()==udg_MonkUnitMH[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))
endfunction
function Trig_BingWeapon_Func001Func005001002003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_BingWeapon_Func001Func005001002003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_BingWeapon_Func001Func005001002003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_BingWeapon_Func001Func005001002003002 takes nothing returns boolean
return GetBooleanAnd(Trig_BingWeapon_Func001Func005001002003002001(),Trig_BingWeapon_Func001Func005001002003002002())
endfunction
function Trig_BingWeapon_Func001Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_BingWeapon_Func001Func005001002003001(),Trig_BingWeapon_Func001Func005001002003002())
endfunction
function Trig_BingWeapon_Func001Func005A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Undead\\FreezingBreath\\FreezingBreathTargetArt.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroInt(GetAttacker(),true)))*I2R(udg_BingWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
endfunction
function Trig_BingWeapon_Func001C takes nothing returns boolean
return ((GetUnitManaPercent(GetAttacker())>=70.00))and((GetRandomInt(1,100)<=8))
endfunction
function Trig_BingWeapon_Func002Func005001002003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_BingWeapon_Func002Func005001002003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_BingWeapon_Func002Func005001002003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_BingWeapon_Func002Func005001002003002 takes nothing returns boolean
return GetBooleanAnd(Trig_BingWeapon_Func002Func005001002003002001(),Trig_BingWeapon_Func002Func005001002003002002())
endfunction
function Trig_BingWeapon_Func002Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_BingWeapon_Func002Func005001002003001(),Trig_BingWeapon_Func002Func005001002003002())
endfunction
function Trig_BingWeapon_Func002Func005Func007003001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_BingWeapon_Func002Func005Func007003001003002001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_BingWeapon_Func002Func005Func007003001003002002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetEnumUnit())))
endfunction
function Trig_BingWeapon_Func002Func005Func007003001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_BingWeapon_Func002Func005Func007003001003002001(),Trig_BingWeapon_Func002Func005Func007003001003002002())
endfunction
function Trig_BingWeapon_Func002Func005Func007003001003 takes nothing returns boolean
return GetBooleanAnd(Trig_BingWeapon_Func002Func005Func007003001003001(),Trig_BingWeapon_Func002Func005Func007003001003002())
endfunction
function Trig_BingWeapon_Func002Func005A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Items\\AIso\\AIsoTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Items\\AIso\\BIsvTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitMoveSpeed(GetEnumUnit(),GetUnitDefaultMoveSpeed(GetEnumUnit()))
call SetUnitOwner(GetEnumUnit(),Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
call IssueTargetOrder(GetEnumUnit(),"attack",GroupPickRandomUnit(GetUnitsInRangeOfLocMatching(512,GetUnitLoc(GetAttacker()),Condition(function Trig_BingWeapon_Func002Func005Func007003001003))))
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_BingWeapon_Func002C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_BingWeapon_Actions takes nothing returns nothing
if (Trig_BingWeapon_Func001C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"冰魄云渺")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(16,GetUnitsInRangeOfLocMatching(1000.00,GetUnitLoc(GetAttacker()),Condition(function Trig_BingWeapon_Func001Func005001002003))),function Trig_BingWeapon_Func001Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
return
endif
if (Trig_BingWeapon_Func002C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"冰魔转魂")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(8,GetUnitsInRangeOfLocMatching(700.00,GetUnitLoc(GetAttacker()),Condition(function Trig_BingWeapon_Func002Func005001002003))),function Trig_BingWeapon_Func002Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
endfunction
function Trig_BingWeaponUP_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetKillingUnitBJ()))))and((udg_BingMo[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetKillingUnitBJ()==udg_MonkUnitMH[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)))
endfunction
function Trig_BingWeaponUP_Func003C takes nothing returns boolean
return ((udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=150))
endfunction
function Trig_BingWeaponUP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_BingWeaponUP_Actions takes nothing returns nothing
set udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_BingWeaponUP_Func003C()) then
set udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_BingWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_BingWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000冰魔之寒冰杖|r熟练度为 ")+I2S(udg_BingWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000冰魔之寒冰杖|r "+(I2S(udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/200")))
endif
if (Trig_BingWeaponUP_Func004C()) then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,2)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,3)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,7)
endif
endfunction
function Trig_HuoWeapon_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))and((udg_HuoMo[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)))and((GetAttacker()==udg_MonkUnitMH[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))
endfunction
function Trig_HuoWeapon_Func001Func005001002003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_HuoWeapon_Func001Func005001002003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_HuoWeapon_Func001Func005001002003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_HuoWeapon_Func001Func005001002003002 takes nothing returns boolean
return GetBooleanAnd(Trig_HuoWeapon_Func001Func005001002003002001(),Trig_HuoWeapon_Func001Func005001002003002002())
endfunction
function Trig_HuoWeapon_Func001Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_HuoWeapon_Func001Func005001002003001(),Trig_HuoWeapon_Func001Func005001002003002())
endfunction
function Trig_HuoWeapon_Func001Func005A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Demon\\RainOfFire\\RainOfFireTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroInt(GetAttacker(),true)))*I2R(udg_HuoWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
endfunction
function Trig_HuoWeapon_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=4))
endfunction
function Trig_HuoWeapon_Func002Func005001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_HuoWeapon_Func002Func005001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_HuoWeapon_Func002Func005001003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_HuoWeapon_Func002Func005001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_HuoWeapon_Func002Func005001003002001(),Trig_HuoWeapon_Func002Func005001003002002())
endfunction
function Trig_HuoWeapon_Func002Func005001003 takes nothing returns boolean
return GetBooleanAnd(Trig_HuoWeapon_Func002Func005001003001(),Trig_HuoWeapon_Func002Func005001003002())
endfunction
function Trig_HuoWeapon_Func002Func005A takes nothing returns nothing
set udg_HuoP=PolarProjectionBJ(GetUnitLoc(GetAttacker()),800.00,GetRandomReal(0,360.00))
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\SoulBurn\\SoulBurnbuff.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call IssuePointOrderLoc(GetEnumUnit(),"move",udg_HuoP)
call SetUnitLifePercentBJ(GetEnumUnit(),(GetUnitLifePercent(GetEnumUnit())-1))
call RemoveLocation(udg_HuoP)
endfunction
function Trig_HuoWeapon_Func002C takes nothing returns boolean
return ((GetRandomInt(1,100)<=8))
endfunction
function Trig_HuoWeapon_Func003Func011001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_HuoWeapon_Func003Func011001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_HuoWeapon_Func003Func011001003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_HuoWeapon_Func003Func011001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_HuoWeapon_Func003Func011001003002001(),Trig_HuoWeapon_Func003Func011001003002002())
endfunction
function Trig_HuoWeapon_Func003Func011001003 takes nothing returns boolean
return GetBooleanAnd(Trig_HuoWeapon_Func003Func011001003001(),Trig_HuoWeapon_Func003Func011001003002())
endfunction
function Trig_HuoWeapon_Func003Func011A takes nothing returns nothing
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),((I2R(GetHeroInt(GetAttacker(),true))*(10.00*I2R(GetHeroLevel(GetAttacker()))))*I2R(udg_HuoWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
endfunction
function Trig_HuoWeapon_Func003C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))
endfunction
function Trig_HuoWeapon_Actions takes nothing returns nothing
if (Trig_HuoWeapon_Func001C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"地狱飞炎")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(10,GetUnitsInRangeOfLocMatching(700.00,GetUnitLoc(GetAttacker()),Condition(function Trig_HuoWeapon_Func001Func005001002003))),function Trig_HuoWeapon_Func001Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
if (Trig_HuoWeapon_Func002C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"炽火焚心")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(400.00,GetUnitLoc(GetAttacker()),Condition(function Trig_HuoWeapon_Func002Func005001003)),function Trig_HuoWeapon_Func002Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
if (Trig_HuoWeapon_Func003C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"致命炎爆")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddLightningLoc("LEAS",GetUnitLoc(GetAttacker()),GetUnitLoc(GetTriggerUnit()))
call DestroyLightning(GetLastCreatedLightningBJ())
call AddSpecialEffectLocBJ(GetUnitLoc(GetTriggerUnit()),"Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(GetUnitLoc(GetTriggerUnit()),"Abilities\\Spells\\Other\\Volcano\\VolcanoDeath.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(300.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_HuoWeapon_Func003Func011001003)),function Trig_HuoWeapon_Func003Func011A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
endfunction
function Trig_HuoWeaponUP_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetKillingUnitBJ()))))and((udg_HuoMo[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetKillingUnitBJ()==udg_MonkUnitMH[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)))
endfunction
function Trig_HuoWeaponUP_Func003C takes nothing returns boolean
return ((udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=150))
endfunction
function Trig_HuoWeaponUP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_HuoWeaponUP_Actions takes nothing returns nothing
set udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_HuoWeaponUP_Func003C()) then
set udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_HuoWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_HuoWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000炎魔之烈火刀|r熟练度为 ")+I2S(udg_HuoWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000炎魔之烈火刀|r "+(I2S(udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/200")))
endif
if (Trig_HuoWeaponUP_Func004C()) then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,2)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,4)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,7)
endif
endfunction
function Trig_LeiWeapon_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))and((udg_LeiMo[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)))and((GetAttacker()==udg_MonkUnitMH[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))
endfunction
function Trig_LeiWeapon_Func001Func005001002003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_LeiWeapon_Func001Func005001002003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_LeiWeapon_Func001Func005001002003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_LeiWeapon_Func001Func005001002003002 takes nothing returns boolean
return GetBooleanAnd(Trig_LeiWeapon_Func001Func005001002003002001(),Trig_LeiWeapon_Func001Func005001002003002002())
endfunction
function Trig_LeiWeapon_Func001Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_LeiWeapon_Func001Func005001002003001(),Trig_LeiWeapon_Func001Func005001002003002())
endfunction
function Trig_LeiWeapon_Func001Func005A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroStr(GetAttacker(),true)))*I2R(udg_LeiWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
endfunction
function Trig_LeiWeapon_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=4))
endfunction
function Trig_LeiWeapon_Func002Func005001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_LeiWeapon_Func002Func005001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_LeiWeapon_Func002Func005001003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_LeiWeapon_Func002Func005001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_LeiWeapon_Func002Func005001003002001(),Trig_LeiWeapon_Func002Func005001003002002())
endfunction
function Trig_LeiWeapon_Func002Func005001003 takes nothing returns boolean
return GetBooleanAnd(Trig_LeiWeapon_Func002Func005001003001(),Trig_LeiWeapon_Func002Func005001003002())
endfunction
function Trig_LeiWeapon_Func002Func005A takes nothing returns nothing
set udg_HuoP=PolarProjectionBJ(GetUnitLoc(GetAttacker()),500.00,GetRandomReal(0,360.00))
call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Weapons\\Bolt\\BoltImpact.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("chest",GetEnumUnit(),"Abilities\\Spells\\Orc\\Purge\\PurgeBuffTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddLightningLoc("CLPB",GetUnitLoc(GetEnumUnit()),udg_HuoP)
call DestroyLightning(GetLastCreatedLightningBJ())
call SetUnitMoveSpeed(GetEnumUnit(),150.00)
call UnitRemoveBuffs(GetEnumUnit(),true,false)
call RemoveLocation(udg_HuoP)
endfunction
function Trig_LeiWeapon_Func002C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))
endfunction
function Trig_LeiWeapon_Func003C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_LeiWeapon_Func004Func007001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_LeiWeapon_Func004Func007001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_LeiWeapon_Func004Func007001003002002001 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_LeiWeapon_Func004Func007001003002002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
endfunction
function Trig_LeiWeapon_Func004Func007001003002002 takes nothing returns boolean
return GetBooleanAnd(Trig_LeiWeapon_Func004Func007001003002002001(),Trig_LeiWeapon_Func004Func007001003002002002())
endfunction
function Trig_LeiWeapon_Func004Func007001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_LeiWeapon_Func004Func007001003002001(),Trig_LeiWeapon_Func004Func007001003002002())
endfunction
function Trig_LeiWeapon_Func004Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_LeiWeapon_Func004Func007001003001(),Trig_LeiWeapon_Func004Func007001003002())
endfunction
function Trig_LeiWeapon_Func004Func007A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Items\\AIlb\\AIlbSpecialArt.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),(I2R(GetHeroStr(GetAttacker(),true))*(I2R(udg_LeiWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])*GetRandomReal(1.00,5.00))),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
endfunction
function Trig_LeiWeapon_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=10))
endfunction
function Trig_LeiWeapon_Actions takes nothing returns nothing
if (Trig_LeiWeapon_Func001C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"迅雷之击")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(10,GetUnitsInRangeOfLocMatching(700.00,GetUnitLoc(GetAttacker()),Condition(function Trig_LeiWeapon_Func001Func005001002003))),function Trig_LeiWeapon_Func001Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
return
endif
if (Trig_LeiWeapon_Func002C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"闪电净化")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(400.00,GetUnitLoc(GetAttacker()),Condition(function Trig_LeiWeapon_Func002Func005001003)),function Trig_LeiWeapon_Func002Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
return
endif
if (Trig_LeiWeapon_Func003C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"雷魔突袭")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectTargetUnitBJ("origin",GetTriggerUnit(),"Abilities\\Spells\\Orc\\LightningShield\\LightningShieldTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitMoveSpeed(GetTriggerUnit(),1.00)
call SetUnitAcquireRange(GetTriggerUnit(),150.00)
call SetUnitVertexColorBJ(GetTriggerUnit(),50.00,50.00,100,0)
call SetUnitScalePercent(GetTriggerUnit(),80.00,80.00,80.00)
return
endif
if (Trig_LeiWeapon_Func004C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"雷霆一击")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectLocBJ(GetUnitLoc(GetAttacker()),"Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(400.00,GetUnitLoc(GetAttacker()),Condition(function Trig_LeiWeapon_Func004Func007001003)),function Trig_LeiWeapon_Func004Func007A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
endfunction
function Trig_LeiWeaponUP_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetKillingUnitBJ()))))and((udg_LeiMo[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetKillingUnitBJ()==udg_MonkUnitMH[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)))
endfunction
function Trig_LeiWeaponUP_Func003C takes nothing returns boolean
return ((udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=150))
endfunction
function Trig_LeiWeaponUP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_LeiWeaponUP_Actions takes nothing returns nothing
set udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_LeiWeaponUP_Func003C()) then
set udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_LeiWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_LeiWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000雷魔之迅雷剑|r熟练度为 ")+I2S(udg_LeiWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000雷魔之迅雷剑|r "+(I2S(udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/200")))
endif
if (Trig_LeiWeaponUP_Func004C()) then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,5)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,3)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,2)
endif
endfunction
function Trig_ShuiWeapon_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))and((udg_ShuiMo[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)))and((GetAttacker()==udg_MonkUnitMH[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))
endfunction
function Trig_ShuiWeapon_Func001Func005001002003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_ShuiWeapon_Func001Func005001002003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_ShuiWeapon_Func001Func005001002003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_ShuiWeapon_Func001Func005001002003002 takes nothing returns boolean
return GetBooleanAnd(Trig_ShuiWeapon_Func001Func005001002003002001(),Trig_ShuiWeapon_Func001Func005001002003002002())
endfunction
function Trig_ShuiWeapon_Func001Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_ShuiWeapon_Func001Func005001002003001(),Trig_ShuiWeapon_Func001Func005001002003002())
endfunction
function Trig_ShuiWeapon_Func001Func005A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((GetUnitManaPercent(GetAttacker())*SquareRoot(GetUnitStateSwap(UNIT_STATE_MAX_MANA,GetAttacker())))*I2R(udg_ShuiWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_ShuiWeapon_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=6))
endfunction
function Trig_ShuiWeapon_Func002Func005001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_ShuiWeapon_Func002Func005001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_ShuiWeapon_Func002Func005001003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_ShuiWeapon_Func002Func005001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_ShuiWeapon_Func002Func005001003002001(),Trig_ShuiWeapon_Func002Func005001003002002())
endfunction
function Trig_ShuiWeapon_Func002Func005001003 takes nothing returns boolean
return GetBooleanAnd(Trig_ShuiWeapon_Func002Func005001003001(),Trig_ShuiWeapon_Func002Func005001003002())
endfunction
function Trig_ShuiWeapon_Func002Func005A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\Blizzard\\BlizzardTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),(I2R(GetHeroLevel(GetAttacker()))*(SquareRoot((I2R(GetHeroAgi(GetAttacker(),true))+(I2R(GetHeroInt(GetAttacker(),true))*3.00)))*I2R(udg_ShuiWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
endfunction
function Trig_ShuiWeapon_Func002C takes nothing returns boolean
return ((GetRandomInt(1,100)<=4))
endfunction
function Trig_ShuiWeapon_Func003Func008001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_ShuiWeapon_Func003Func008001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_ShuiWeapon_Func003Func008001003002002001 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_ShuiWeapon_Func003Func008001003002002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
endfunction
function Trig_ShuiWeapon_Func003Func008001003002002 takes nothing returns boolean
return GetBooleanAnd(Trig_ShuiWeapon_Func003Func008001003002002001(),Trig_ShuiWeapon_Func003Func008001003002002002())
endfunction
function Trig_ShuiWeapon_Func003Func008001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_ShuiWeapon_Func003Func008001003002001(),Trig_ShuiWeapon_Func003Func008001003002002())
endfunction
function Trig_ShuiWeapon_Func003Func008001003 takes nothing returns boolean
return GetBooleanAnd(Trig_ShuiWeapon_Func003Func008001003001(),Trig_ShuiWeapon_Func003Func008001003002())
endfunction
function Trig_ShuiWeapon_Func003Func008A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\DispelMagic\\DispelMagicTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitManaBJ(GetEnumUnit(),0)
call UnitRemoveBuffs(GetEnumUnit(),true,false)
endfunction
function Trig_ShuiWeapon_Func003C takes nothing returns boolean
return ((GetRandomInt(1,100)<=8))
endfunction
function Trig_ShuiWeapon_Actions takes nothing returns nothing
if (Trig_ShuiWeapon_Func001C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"水怒龙息")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(10,GetUnitsInRangeOfLocMatching(900.00,GetUnitLoc(GetAttacker()),Condition(function Trig_ShuiWeapon_Func001Func005001002003))),function Trig_ShuiWeapon_Func001Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
if (Trig_ShuiWeapon_Func002C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"暴风雨雪")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(550.00,GetUnitLoc(GetAttacker()),Condition(function Trig_ShuiWeapon_Func002Func005001003)),function Trig_ShuiWeapon_Func002Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
if (Trig_ShuiWeapon_Func003C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"邪恶水牢")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call UnitRemoveBuffs(GetAttacker(),false,true)
call AddSpecialEffectTargetUnitBJ("origin",GetAttacker(),"Abilities\\Spells\\Human\\ManaShield\\ManaShieldCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(400.00,GetUnitLoc(GetAttacker()),Condition(function Trig_ShuiWeapon_Func003Func008001003)),function Trig_ShuiWeapon_Func003Func008A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
endfunction
function Trig_ShuiWeaponHurt_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetAttacker(),GetOwningPlayer(GetTriggerUnit()))))and((udg_ShuiMo[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))and((GetTriggerUnit()==udg_MonkUnitMH[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))
endfunction
function Trig_ShuiWeaponHurt_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=20))and((GetUnitLifePercent(GetTriggerUnit())<=20.00))and((GetUnitManaPercent(GetTriggerUnit())>=30.00))
endfunction
function Trig_ShuiWeaponHurt_Actions takes nothing returns nothing
if (Trig_ShuiWeaponHurt_Func001C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"水魔重降")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\Undead\\ReplenishMana\\ReplenishManaCasterOverhead.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitLifePercentBJ(GetTriggerUnit(),100)
call SetUnitManaPercentBJ(GetTriggerUnit(),(GetUnitManaPercent(GetTriggerUnit())-30.00))
endif
endfunction
function Trig_ShuiWeaponUP_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetKillingUnitBJ()))))and((udg_ShuiMo[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetKillingUnitBJ()==udg_MonkUnitMH[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)))
endfunction
function Trig_ShuiWeaponUP_Func003C takes nothing returns boolean
return ((udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=150))
endfunction
function Trig_ShuiWeaponUP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_ShuiWeaponUP_Actions takes nothing returns nothing
set udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_ShuiWeaponUP_Func003C()) then
set udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_ShuiWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_ShuiWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000水魔之定海神针|r熟练度为 ")+I2S(udg_ShuiWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000水魔之定海神针|r "+(I2S(udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/200")))
endif
if (Trig_ShuiWeaponUP_Func004C()) then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,3)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,2)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,6)
endif
endfunction
function Trig_MuWeapon_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))and((udg_MuMo[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((GetAttacker()==udg_MonkUnitMH[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)))
endfunction
function Trig_MuWeapon_Func001Func007001002003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_MuWeapon_Func001Func007001002003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_MuWeapon_Func001Func007001002003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_MuWeapon_Func001Func007001002003002 takes nothing returns boolean
return GetBooleanAnd(Trig_MuWeapon_Func001Func007001002003002001(),Trig_MuWeapon_Func001Func007001002003002002())
endfunction
function Trig_MuWeapon_Func001Func007001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_MuWeapon_Func001Func007001002003001(),Trig_MuWeapon_Func001Func007001002003002())
endfunction
function Trig_MuWeapon_Func001Func007A takes nothing returns nothing
set udg_WeaponNum=(udg_WeaponNum+1)
set udg_WeaponUnits[udg_WeaponNum]=GetEnumUnit()
call PauseUnitBJ(true,GetEnumUnit())
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Undead\\Impale\\ImpaleMissTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
set udg_MuWeaponTEX[udg_WeaponNum]=AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\StormBolt\\StormBoltTarget.mdl")
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_MuWeapon_Func001Func009Func005001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_MuWeapon_Func001Func009Func005001003002 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_MuWeapon_Func001Func009Func005001003 takes nothing returns boolean
return GetBooleanAnd(Trig_MuWeapon_Func001Func009Func005001003001(),Trig_MuWeapon_Func001Func009Func005001003002())
endfunction
function Trig_MuWeapon_Func001Func009Func005A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Undead\\Impale\\ImpaleHitTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Undead\\Impale\\ImpaleHitTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),(((I2R(GetHeroLevel(GetAttacker()))*4.00)*I2R(GetHeroAgi(GetAttacker(),true)))*I2R(udg_MuWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_MuWeapon_Func001Func009Func006Func009001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_MuWeapon_Func001Func009Func006Func009001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_MuWeapon_Func001Func009Func006Func009001003002002001 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_MuWeapon_Func001Func009Func006Func009001003002002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
endfunction
function Trig_MuWeapon_Func001Func009Func006Func009001003002002 takes nothing returns boolean
return GetBooleanAnd(Trig_MuWeapon_Func001Func009Func006Func009001003002002001(),Trig_MuWeapon_Func001Func009Func006Func009001003002002002())
endfunction
function Trig_MuWeapon_Func001Func009Func006Func009001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_MuWeapon_Func001Func009Func006Func009001003002001(),Trig_MuWeapon_Func001Func009Func006Func009001003002002())
endfunction
function Trig_MuWeapon_Func001Func009Func006Func009001003 takes nothing returns boolean
return GetBooleanAnd(Trig_MuWeapon_Func001Func009Func006Func009001003001(),Trig_MuWeapon_Func001Func009Func006Func009001003002())
endfunction
function Trig_MuWeapon_Func001Func009Func006Func009A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Undead\\Impale\\ImpaleMissTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),(((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroAgi(GetAttacker(),true)))*8.00)*(I2R(udg_MuWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])*GetRandomReal(1.00,10.00))),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
endfunction
function Trig_MuWeapon_Func001Func009Func006C takes nothing returns boolean
return ((GetRandomInt(1,100)<=30))
endfunction
function Trig_MuWeapon_Func001Func009C takes nothing returns boolean
return ((GetRandomInt(1,100)<=15))
endfunction
function Trig_MuWeapon_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=6))and((udg_WeaponBool[1]))
endfunction
function Trig_MuWeapon_Func002Func005001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_MuWeapon_Func002Func005001003002 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_MuWeapon_Func002Func005001003 takes nothing returns boolean
return GetBooleanAnd(Trig_MuWeapon_Func002Func005001003001(),Trig_MuWeapon_Func002Func005001003002())
endfunction
function Trig_MuWeapon_Func002Func005A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Undead\\Impale\\ImpaleHitTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Undead\\Impale\\ImpaleHitTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroAgi(GetAttacker(),true)))*I2R(udg_MuWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_MuWeapon_Func002C takes nothing returns boolean
return ((GetUnitManaPercent(GetAttacker())>=70.00))and((GetRandomInt(1,100)<=4))
endfunction
function Trig_MuWeapon_Func003Func009001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_MuWeapon_Func003Func009001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_MuWeapon_Func003Func009001003002002001 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_MuWeapon_Func003Func009001003002002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
endfunction
function Trig_MuWeapon_Func003Func009001003002002 takes nothing returns boolean
return GetBooleanAnd(Trig_MuWeapon_Func003Func009001003002002001(),Trig_MuWeapon_Func003Func009001003002002002())
endfunction
function Trig_MuWeapon_Func003Func009001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_MuWeapon_Func003Func009001003002001(),Trig_MuWeapon_Func003Func009001003002002())
endfunction
function Trig_MuWeapon_Func003Func009001003 takes nothing returns boolean
return GetBooleanAnd(Trig_MuWeapon_Func003Func009001003001(),Trig_MuWeapon_Func003Func009001003002())
endfunction
function Trig_MuWeapon_Func003Func009A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Undead\\Impale\\ImpaleMissTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),(I2R(GetHeroAgi(GetAttacker(),false))*(I2R(udg_MuWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])*GetRandomReal(10.00,100.00))),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
call SetUnitMoveSpeed(GetEnumUnit(),150.00)
endfunction
function Trig_MuWeapon_Func003C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))
endfunction
function Trig_MuWeapon_Actions takes nothing returns nothing
if (Trig_MuWeapon_Func001C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"困仙刺")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
set udg_WeaponBool[1]=false
set udg_WeaponNum=0
call ForGroupBJ(GetRandomSubGroup(16,GetUnitsInRangeOfLocMatching(600.00,GetUnitLoc(GetAttacker()),Condition(function Trig_MuWeapon_Func001Func007001002003))),function Trig_MuWeapon_Func001Func007A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
if (Trig_MuWeapon_Func001Func009C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"2连刺 Hit！")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(600.00,GetUnitLoc(GetAttacker()),Condition(function Trig_MuWeapon_Func001Func009Func005001003)),function Trig_MuWeapon_Func001Func009Func005A)
if (Trig_MuWeapon_Func001Func009Func006C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"3连刺 Hit！")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectTargetUnitBJ("origin",GetAttacker(),"Abilities\\Spells\\Orc\\ReinforcedTrollBurrow\\ReinforcedTrollBurrowTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(GetUnitLoc(GetAttacker()),"Abilities\\Spells\\Orc\\EarthQuake\\EarthQuakeTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(400.00,GetUnitLoc(GetAttacker()),Condition(function Trig_MuWeapon_Func001Func009Func006Func009001003)),function Trig_MuWeapon_Func001Func009Func006Func009A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
call TriggerSleepAction(5.00)
call TriggerExecute(gg_trg_MuWeapon01)
return
endif
if (Trig_MuWeapon_Func002C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"穿心刺")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(600.00,GetUnitLoc(GetAttacker()),Condition(function Trig_MuWeapon_Func002Func005001003)),function Trig_MuWeapon_Func002Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
return
endif
if (Trig_MuWeapon_Func003C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"伤足刺")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectTargetUnitBJ("origin",GetAttacker(),"Abilities\\Spells\\Orc\\ReinforcedTrollBurrow\\ReinforcedTrollBurrowTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(GetUnitLoc(GetAttacker()),"Abilities\\Spells\\Orc\\EarthQuake\\EarthQuakeTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(500.00,GetUnitLoc(GetAttacker()),Condition(function Trig_MuWeapon_Func003Func009001003)),function Trig_MuWeapon_Func003Func009A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
endfunction
function Trig_MuWeaponUP_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetKillingUnitBJ()))))and((udg_MuMo[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetKillingUnitBJ()==udg_MonkUnitMH[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)))
endfunction
function Trig_MuWeaponUP_Func003C takes nothing returns boolean
return ((udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=150))
endfunction
function Trig_MuWeaponUP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_MuWeaponUP_Actions takes nothing returns nothing
set udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_MuWeaponUP_Func003C()) then
set udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_MuWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_MuWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000木魔之精灵地刺|r熟练度为 ")+I2S(udg_MuWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000木魔之精灵地刺|r "+(I2S(udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/200")))
endif
if (Trig_MuWeaponUP_Func004C()) then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,3)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,4)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,2)
endif
endfunction
function Trig_MuWeapon01_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=udg_WeaponNum
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call PauseUnitBJ(false,udg_WeaponUnits[GetForLoopIndexA()])
call DestroyEffect(udg_MuWeaponTEX[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set udg_WeaponBool[1]=true
call DisableTrigger(GetTriggeringTrigger())
endfunction
function Trig_WangWeapon_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))and((udg_WangMo[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)))and((GetAttacker()==udg_MonkUnitMH[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))
endfunction
function Trig_WangWeapon_Func001Func005001002003001 takes nothing returns boolean
return (IsUnitDeadBJ(GetFilterUnit()))
endfunction
function Trig_WangWeapon_Func001Func005001002003002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==false)
endfunction
function Trig_WangWeapon_Func001Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_WangWeapon_Func001Func005001002003001(),Trig_WangWeapon_Func001Func005001002003002())
endfunction
function Trig_WangWeapon_Func001Func005Func009001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_WangWeapon_Func001Func005Func009001003002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_WangWeapon_Func001Func005Func009001003 takes nothing returns boolean
return GetBooleanAnd(Trig_WangWeapon_Func001Func005Func009001003001(),Trig_WangWeapon_Func001Func005Func009001003002())
endfunction
function Trig_WangWeapon_Func001Func005Func009A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroAgi(GetAttacker(),true)))*SquareRoot(I2R(udg_WangWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))),true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_ENHANCED,WEAPON_TYPE_WHOKNOWS)
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_WangWeapon_Func001Func005A takes nothing returns nothing
set udg_UnitsSelectA=GetEnumUnit()
set udg_PointA=GetUnitLoc(udg_UnitsSelectA)
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Objects\\Spawnmodels\\Human\\HumanLargeDeathExplode\\HumanLargeDeathExplode.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Items\\AIre\\AIreTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(200.00,udg_PointA,Condition(function Trig_WangWeapon_Func001Func005Func009001003)),function Trig_WangWeapon_Func001Func005Func009A)
call RemoveUnit(udg_UnitsSelectA)
call RemoveLocation(udg_PointA)
endfunction
function Trig_WangWeapon_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=8))
endfunction
function Trig_WangWeapon_Func002Func005001002003001 takes nothing returns boolean
return (IsUnitDeadBJ(GetFilterUnit()))
endfunction
function Trig_WangWeapon_Func002Func005001002003002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
endfunction
function Trig_WangWeapon_Func002Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_WangWeapon_Func002Func005001002003001(),Trig_WangWeapon_Func002Func005001002003002())
endfunction
function Trig_WangWeapon_Func002Func005A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Undead\\AnimateDead\\AnimateDeadTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call CreateNUnitsAtLoc(1,GetUnitTypeId(GetEnumUnit()),GetOwningPlayer(GetAttacker()),GetUnitLoc(GetEnumUnit()),bj_UNIT_FACING)
call UnitApplyTimedLifeBJ(10.00,'BHwe',GetLastCreatedUnit())
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_WangWeapon_Func002C takes nothing returns boolean
return ((GetRandomInt(1,100)<=6))
endfunction
function Trig_WangWeapon_Func003C takes nothing returns boolean
return ((GetRandomInt(1,100)<=1))and((IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)!=true))
endfunction
function Trig_WangWeapon_Actions takes nothing returns nothing
if (Trig_WangWeapon_Func001C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"爆炸尸体")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(10,GetUnitsInRangeOfLocMatching(700.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_WangWeapon_Func001Func005001002003))),function Trig_WangWeapon_Func001Func005A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
return
endif
if (Trig_WangWeapon_Func002C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"亡灵复苏")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(8,GetUnitsInRangeOfLocMatching(600.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_WangWeapon_Func002Func005001002003))),function Trig_WangWeapon_Func002Func005A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
return
endif
if (Trig_WangWeapon_Func003C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"借尸还魂")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call CreateNUnitsAtLoc(1,GetUnitTypeId(GetTriggerUnit()),GetOwningPlayer(GetAttacker()),GetUnitLoc(GetTriggerUnit()),bj_UNIT_FACING)
call UnitApplyTimedLifeBJ(60,'BHwe',GetLastCreatedUnit())
call SetUnitVertexColorBJ(GetLastCreatedUnit(),10.00,10.00,10.00,0)
call AddSpecialEffectTargetUnitBJ("origin",GetTriggerUnit(),"Abilities\\Spells\\Undead\\Darksummoning\\DarkSummonTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
endif
endfunction
function Trig_WangWeaponUP_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetKillingUnitBJ()))))and((udg_WangMo[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetKillingUnitBJ()==udg_MonkUnitMH[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)))
endfunction
function Trig_WangWeaponUP_Func003C takes nothing returns boolean
return ((udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=150))
endfunction
function Trig_WangWeaponUP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_WangWeaponUP_Actions takes nothing returns nothing
set udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_WangWeaponUP_Func003C()) then
set udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_WangWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_WangWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000亡魔之暗黑之刃|r熟练度为 ")+I2S(udg_WangWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000亡魔之暗黑之刃|r  "+(I2S(udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/200")))
endif
if (Trig_WangWeaponUP_Func004C()) then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,3)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,4)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,2)
endif
endfunction
function Trig_YueWeapon_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))and((udg_YueMo[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((GetAttacker()==udg_MonkUnitMH[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)))
endfunction
function Trig_YueWeapon_Func001Func007001002003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_YueWeapon_Func001Func007001002003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_YueWeapon_Func001Func007001002003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_YueWeapon_Func001Func007001002003002 takes nothing returns boolean
return GetBooleanAnd(Trig_YueWeapon_Func001Func007001002003002001(),Trig_YueWeapon_Func001Func007001002003002002())
endfunction
function Trig_YueWeapon_Func001Func007001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_YueWeapon_Func001Func007001002003001(),Trig_YueWeapon_Func001Func007001002003002())
endfunction
function Trig_YueWeapon_Func001Func007A takes nothing returns nothing
set udg_WeaponNum=(udg_WeaponNum+1)
set udg_YueUnits[udg_WeaponNum]=GetEnumUnit()
set udg_YueMoPoint[udg_WeaponNum]=GetUnitLoc(GetEnumUnit())
call PauseUnitBJ(true,GetEnumUnit())
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\FaerieFire\\FaerieFireTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddLightningLoc("DRAM",udg_YueMoPoint[(udg_WeaponNum-1)],udg_YueMoPoint[udg_WeaponNum])
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),(I2R(GetHeroLevel(GetAttacker()))*(I2R(GetHeroAgi(GetAttacker(),true))*(I2R(udg_YueWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])+1))),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
set udg_YuMoFlash[udg_WeaponNum]=GetLastCreatedLightningBJ()
endfunction
function Trig_YueWeapon_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=2))and((udg_WeaponBool[2]))
endfunction
function Trig_YueWeapon_Func002Func007001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_YueWeapon_Func002Func007001003002 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_YueWeapon_Func002Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_YueWeapon_Func002Func007001003001(),Trig_YueWeapon_Func002Func007001003002())
endfunction
function Trig_YueWeapon_Func002Func007A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\Starfall\\StarfallTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroAgi(GetAttacker(),true)))*I2R(udg_YueWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
endfunction
function Trig_YueWeapon_Func002C takes nothing returns boolean
return ((GetUnitManaPercent(GetAttacker())>=70.00))and((GetRandomInt(1,100)<=3))
endfunction
function Trig_YueWeapon_Func003Func008001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_YueWeapon_Func003Func008001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_YueWeapon_Func003Func008001003002002001 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_YueWeapon_Func003Func008001003002002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
endfunction
function Trig_YueWeapon_Func003Func008001003002002 takes nothing returns boolean
return GetBooleanAnd(Trig_YueWeapon_Func003Func008001003002002001(),Trig_YueWeapon_Func003Func008001003002002002())
endfunction
function Trig_YueWeapon_Func003Func008001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_YueWeapon_Func003Func008001003002001(),Trig_YueWeapon_Func003Func008001003002002())
endfunction
function Trig_YueWeapon_Func003Func008001003 takes nothing returns boolean
return GetBooleanAnd(Trig_YueWeapon_Func003Func008001003001(),Trig_YueWeapon_Func003Func008001003002())
endfunction
function Trig_YueWeapon_Func003Func008A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Other\\Tornado\\TornadoElementalSmall.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),(I2R(GetHeroAgi(GetAttacker(),false))*(I2R(udg_MuWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])*GetRandomReal(1.00,5.00))),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
call SetUnitMoveSpeed(GetEnumUnit(),5.00)
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_YueWeapon_Func003C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))
endfunction
function Trig_YueWeapon_Actions takes nothing returns nothing
if (Trig_YueWeapon_Func001C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"月魔锁链")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
set udg_WeaponNum=0
set udg_YueMoPoint[0]=GetUnitLoc(GetAttacker())
call ForGroupBJ(GetRandomSubGroup(16,GetUnitsInRangeOfLocMatching(1600.00,GetUnitLoc(GetAttacker()),Condition(function Trig_YueWeapon_Func001Func007001002003))),function Trig_YueWeapon_Func001Func007A)
call RemoveLocation(udg_YueMoPoint[0])
call RemoveLocation(GetUnitLoc(GetAttacker()))
call TriggerSleepAction(0.10)
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=udg_WeaponNum
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call PauseUnitBJ(false,udg_YueUnits[GetForLoopIndexA()])
call DestroyLightning(udg_YuMoFlash[GetForLoopIndexA()])
set udg_YueUnits[GetForLoopIndexA()]=null
call RemoveLocation(udg_YueMoPoint[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
return
endif
if (Trig_YueWeapon_Func002C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"星坠月落")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\Starfall\\StarfallCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(700.00,GetUnitLoc(GetAttacker()),Condition(function Trig_YueWeapon_Func002Func007001003)),function Trig_YueWeapon_Func002Func007A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
return
endif
if (Trig_YueWeapon_Func003C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"月晕之风")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call UnitRemoveBuffs(GetAttacker(),false,true)
call AddSpecialEffectTargetUnitBJ("origin",GetAttacker(),"Abilities\\Spells\\Other\\Tornado\\Tornado_Target.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(500.00,GetUnitLoc(GetAttacker()),Condition(function Trig_YueWeapon_Func003Func008001003)),function Trig_YueWeapon_Func003Func008A)
endif
endfunction
function Trig_YueWeapon00_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetAttacker(),GetOwningPlayer(GetTriggerUnit()))))and((udg_YueMo[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))and((GetTriggerUnit()==udg_MonkUnitMH[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))and((IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)))
endfunction
function Trig_YueWeapon00_Func001Func006001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_YueWeapon00_Func001Func006001003002001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetTriggerUnit()))!=true)
endfunction
function Trig_YueWeapon00_Func001Func006001003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_YueWeapon00_Func001Func006001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_YueWeapon00_Func001Func006001003002001(),Trig_YueWeapon00_Func001Func006001003002002())
endfunction
function Trig_YueWeapon00_Func001Func006001003 takes nothing returns boolean
return GetBooleanAnd(Trig_YueWeapon00_Func001Func006001003001(),Trig_YueWeapon00_Func001Func006001003002())
endfunction
function Trig_YueWeapon00_Func001Func006A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Items\\ScrollOfRejuvenation\\ScrollManaHealth.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitLifePercentBJ(GetEnumUnit(),(GetUnitLifePercent(GetEnumUnit())+SquareRoot(I2R(udg_YueWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))))
endfunction
function Trig_YueWeapon00_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=R2I(SquareRoot(I2R((100-R2I(GetUnitLifePercent(GetTriggerUnit()))))))))
endfunction
function Trig_YueWeapon00_Actions takes nothing returns nothing
if (Trig_YueWeapon00_Func001C()) then
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("origin",GetTriggerUnit(),"Abilities\\Spells\\Items\\ScrollOfRejuvenation\\ScrollManaHealth.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitLifePercentBJ(GetTriggerUnit(),(GetUnitLifePercent(GetTriggerUnit())+SquareRoot(I2R(udg_YueWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))))
call ForGroupBJ(GetUnitsInRangeOfLocMatching(600.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_YueWeapon00_Func001Func006001003)),function Trig_YueWeapon00_Func001Func006A)
endif
endfunction
function Trig_YueWeaponUP_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetKillingUnitBJ()))))and((udg_YueMo[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetKillingUnitBJ()==udg_MonkUnitMH[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)))
endfunction
function Trig_YueWeaponUP_Func003C takes nothing returns boolean
return ((udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=150))
endfunction
function Trig_YueWeaponUP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_YueWeaponUP_Actions takes nothing returns nothing
set udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_YueWeaponUP_Func003C()) then
set udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_YueWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_YueWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000月魔之无相金轮|r熟练度为 ")+I2S(udg_YueWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000月魔之无相金轮|r "+(I2S(udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/200")))
endif
if (Trig_YueWeaponUP_Func004C()) then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,3)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,4)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,2)
endif
endfunction
function Trig_FengYinMonk_Conditions takes nothing returns boolean
return ((udg_PlayerTIDD[GetConvertedPlayerId(GetTriggerPlayer())]==false))
endfunction
function Trig_FengYinMonk_Actions takes nothing returns nothing
set udg_PlayerTIDD[GetConvertedPlayerId(GetTriggerPlayer())]=true
set udg_TuMo[GetConvertedPlayerId(GetTriggerPlayer())]=true
set udg_TuWeaponL[GetConvertedPlayerId(GetTriggerPlayer())]=1
set udg_WeaponLevelUp[GetConvertedPlayerId(GetTriggerPlayer())]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+("  已经入了被封印的-<土魔>-"+"！ 请马上选择你要进入的英雄！")))
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Trig_TuWeapon_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))and((udg_TuMo[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)))and((GetAttacker()==udg_MonkUnitMH[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetTriggerUnit(),UNIT_TYPE_STRUCTURE)!=true))
endfunction
function Trig_TuWeapon_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=2))
endfunction
function Trig_TuWeapon_Func002C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_TuWeapon_Func003C takes nothing returns boolean
return ((GetRandomInt(1,100)<=1))
endfunction
function Trig_TuWeapon_Func004C takes nothing returns boolean
return ((GetRandomInt(1,1000)<=5))and((GetUnitLifePercent(GetAttacker())>60.00))and((GetUnitLevel(GetAttacker())>30))
endfunction
function Trig_TuWeapon_Func005C takes nothing returns boolean
return ((GetRandomInt(1,1000)<=2))and((GetUnitLifePercent(GetAttacker())>60.00))and((GetUnitLevel(GetAttacker())>50))
endfunction
function Trig_TuWeapon_Actions takes nothing returns nothing
if (Trig_TuWeapon_Func001C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"疾行土封")+"|r ")+"|cFFFF00334式|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
set udg_TuMoUnit=GetAttacker()
call PauseUnitBJ(true,udg_TuMoUnit)
call SetUnitPathing(udg_TuMoUnit,false)
set udg_TuMoHurtUnit=GetTriggerUnit()
call PauseUnitBJ(true,udg_TuMoHurtUnit)
set udg_TuMoPoint[0]=GetUnitLoc(GetTriggerUnit())
set udg_TuMoNC=0
call EnableTrigger(gg_trg_TuMoF4)
return
endif
if (Trig_TuWeapon_Func002C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"地遁连击")+"|r ")+"|cFFFF003316式|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
set udg_TuMoNC=16
set udg_TuMoUnit=GetAttacker()
set udg_TuMoHurtUnit=GetTriggerUnit()
call SetUnitPathing(udg_TuMoUnit,false)
call PauseUnitBJ(true,udg_TuMoUnit)
call EnableTrigger(gg_trg_TuMoF16)
return
endif
if (Trig_TuWeapon_Func003C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"地魔怒杀")+"|r ")+"|cFFFF003332式|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
set udg_TuMoUnit=GetAttacker()
set udg_TuMoHurtUnit=GetTriggerUnit()
call PauseUnitBJ(true,udg_TuMoUnit)
call PauseUnitBJ(true,udg_TuMoHurtUnit)
call TriggerExecute(gg_trg_TuMoF32)
return
endif
if (Trig_TuWeapon_Func004C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"伤残狂击")+"|r ")+"|cFFFF003364式|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
set udg_TuMoUnit=GetAttacker()
set udg_TuMoHurtUnit=GetTriggerUnit()
set udg_TuMoNC=0
call PauseUnitBJ(true,udg_TuMoUnit)
call PauseUnitBJ(true,udg_TuMoHurtUnit)
call SetUnitLifePercentBJ(udg_TuMoUnit,(GetUnitLifePercent(udg_TuMoUnit)-50.00))
set udg_MuWeaponTEX[888]=AddSpecialEffectTargetUnitBJ("weapon",GetAttacker(),"Abilities\\Weapons\\IllidanMissile\\IllidanMissile.mdl")
set udg_MuWeaponTEX[889]=AddSpecialEffectTargetUnitBJ("weapon",GetAttacker(),"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
call EnableTrigger(gg_trg_TuMoF64)
call EnableTrigger(gg_trg_TuMoF64death)
return
endif
if (Trig_TuWeapon_Func005C()) then
set udg_TuMoUnit=GetAttacker()
call PanCameraToTimed(GetLocationX(GetUnitLoc(udg_TuMoUnit)),GetLocationY(GetUnitLoc(udg_TuMoUnit)),0.30)
call SetCameraField(CAMERA_FIELD_TARGET_DISTANCE,4000.00,0)
call ConditionalTriggerExecute(gg_trg_TuMoScrect)
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"土魔密式")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,20.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
endif
endfunction
function Trig_TuMoF4_Func009001003001001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_TuMoF4_Func009001003001002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_TuMoUnit)))
endfunction
function Trig_TuMoF4_Func009001003001 takes nothing returns boolean
return GetBooleanAnd(Trig_TuMoF4_Func009001003001001(),Trig_TuMoF4_Func009001003001002())
endfunction
function Trig_TuMoF4_Func009001003002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_TuMoF4_Func009001003 takes nothing returns boolean
return GetBooleanAnd(Trig_TuMoF4_Func009001003001(),Trig_TuMoF4_Func009001003002())
endfunction
function Trig_TuMoF4_Func009A takes nothing returns nothing
call SetUnitPositionLoc(GetEnumUnit(),udg_TuMoPoint[0])
call UnitDamageTargetBJ(udg_TuMoUnit,GetEnumUnit(),((I2R(GetHeroLevel(udg_TuMoUnit))*I2R(GetHeroAgi(udg_TuMoUnit,false)))*I2R(udg_TuWeaponL[GetConvertedPlayerId(GetOwningPlayer(udg_TuMoUnit))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
endfunction
function Trig_TuMoF4_Func011C takes nothing returns boolean
return ((udg_TuMoNC>24))
endfunction
function Trig_TuMoF4_Actions takes nothing returns nothing
set udg_TuMoNC=(udg_TuMoNC+1)
set udg_TuMoPoint[1]=PolarProjectionBJ(udg_TuMoPoint[0],500.00,(((I2R(udg_TuMoNC)-1)*15.00)+GetUnitFacing(udg_TuMoHurtUnit)))
call SetUnitPositionLocFacingBJ(udg_TuMoUnit,udg_TuMoPoint[1],(AngleBetweenPoints(udg_TuMoPoint[0],udg_TuMoPoint[1])+90.00))
call AddSpecialEffectLocBJ(udg_TuMoPoint[1],"Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitAnimation(udg_TuMoUnit,"Walk")
call AddSpecialEffectTargetUnitBJ("weapon",udg_TuMoUnit,"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(80.00,udg_TuMoPoint[1],Condition(function Trig_TuMoF4_Func009001003)),function Trig_TuMoF4_Func009A)
call RemoveLocation(udg_TuMoPoint[1])
if (Trig_TuMoF4_Func011C()) then
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_TuMoF40)
call AddSpecialEffectTargetUnitBJ("weapon",udg_TuMoUnit,"Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitTimeScalePercent(udg_TuMoUnit,200.00)
call SetUnitAnimation(udg_TuMoUnit,"Attack")
set udg_TuMoPoint[1]=PolarProjectionBJ(udg_TuMoPoint[0],100.00,0)
call SetUnitPositionLocFacingLocBJ(udg_TuMoUnit,udg_TuMoPoint[1],udg_TuMoPoint[0])
set udg_TuMoNC4=0
call RemoveLocation(udg_TuMoPoint[1])
endif
endfunction
function Trig_TuMoF40_Func006C takes nothing returns boolean
return ((udg_TuMoNC4==1))and((IsUnitAliveBJ(udg_TuMoHurtUnit)))
endfunction
function Trig_TuMoF40_Func007C takes nothing returns boolean
return ((udg_TuMoNC4==2))and((IsUnitAliveBJ(udg_TuMoHurtUnit)))
endfunction
function Trig_TuMoF40_Func008C takes nothing returns boolean
return ((udg_TuMoNC4==3))and((IsUnitAliveBJ(udg_TuMoHurtUnit)))
endfunction
function Trig_TuMoF40_Func009C takes nothing returns boolean
return ((udg_TuMoNC4==4))and((IsUnitAliveBJ(udg_TuMoHurtUnit)))
endfunction
function Trig_TuMoF40_Func010C takes nothing returns boolean
return ((udg_TuMoNC4>=4))
endfunction
function Trig_TuMoF40_Actions takes nothing returns nothing
set udg_TuMoNC4=(udg_TuMoNC4+1)
call CreateTextTagUnitBJ(((("|cFFFFFF00"+I2S(udg_TuMoNC4))+"|r ")+"|cFFFF0033式|r"),udg_TuMoHurtUnit,0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
if (Trig_TuMoF40_Func006C()) then
call SetUnitAnimation(udg_TuMoUnit,"Attack")
call SetUnitAnimation(udg_TuMoHurtUnit,"death")
call AddSpecialEffectTargetUnitBJ("weapon",udg_TuMoUnit,"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("weapon",udg_TuMoUnit,"Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
set udg_TuMoPoint[1]=PolarProjectionBJ(udg_TuMoPoint[0],100.00,180.00)
call SetUnitPositionLocFacingBJ(udg_TuMoUnit,udg_TuMoPoint[1],(AngleBetweenPoints(udg_TuMoPoint[0],udg_TuMoPoint[1])+0.00))
call UnitDamageTargetBJ(udg_TuMoUnit,udg_TuMoHurtUnit,(I2R(udg_TuMoNC4)*(I2R(GetHeroAgi(udg_TuMoUnit,false))*I2R(udg_TuWeaponL[GetConvertedPlayerId(GetOwningPlayer(udg_TuMoUnit))]))),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
call RemoveLocation(udg_TuMoPoint[1])
endif
if (Trig_TuMoF40_Func007C()) then
call SetUnitAnimation(udg_TuMoUnit,"Attack")
call AddSpecialEffectTargetUnitBJ("weapon",udg_TuMoUnit,"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("weapon",udg_TuMoUnit,"Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
set udg_TuMoPoint[1]=PolarProjectionBJ(udg_TuMoPoint[0],100.00,0.00)
call SetUnitPositionLocFacingBJ(udg_TuMoUnit,udg_TuMoPoint[1],(AngleBetweenPoints(udg_TuMoPoint[0],udg_TuMoPoint[1])+0.00))
call RemoveLocation(udg_TuMoPoint[1])
call UnitDamageTargetBJ(udg_TuMoUnit,udg_TuMoHurtUnit,(I2R(udg_TuMoNC4)*(I2R(GetHeroAgi(udg_TuMoUnit,false))*I2R(udg_TuWeaponL[GetConvertedPlayerId(GetOwningPlayer(udg_TuMoUnit))]))),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
set udg_TuMoPoint[1]=PolarProjectionBJ(udg_TuMoPoint[0],100.00,90.00)
call SetUnitPositionLocFacingBJ(udg_TuMoUnit,udg_TuMoPoint[1],(AngleBetweenPoints(udg_TuMoPoint[0],udg_TuMoPoint[1])+0.00))
call RemoveLocation(udg_TuMoPoint[1])
call SetUnitAnimation(udg_TuMoHurtUnit,"death")
endif
if (Trig_TuMoF40_Func008C()) then
call SetUnitAnimation(udg_TuMoUnit,"Attack")
call AddSpecialEffectTargetUnitBJ("weapon",udg_TuMoUnit,"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("weapon",udg_TuMoUnit,"Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
set udg_TuMoPoint[1]=PolarProjectionBJ(udg_TuMoPoint[0],100.00,270.00)
call SetUnitPositionLocFacingBJ(udg_TuMoUnit,udg_TuMoPoint[1],(AngleBetweenPoints(udg_TuMoPoint[0],udg_TuMoPoint[1])+0.00))
call UnitDamageTargetBJ(udg_TuMoUnit,udg_TuMoHurtUnit,(I2R(udg_TuMoNC4)*(I2R(GetHeroAgi(udg_TuMoUnit,false))*I2R(udg_TuWeaponL[GetConvertedPlayerId(GetOwningPlayer(udg_TuMoUnit))]))),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
call RemoveLocation(udg_TuMoPoint[1])
call SetUnitAnimation(udg_TuMoHurtUnit,"death")
endif
if (Trig_TuMoF40_Func009C()) then
call SetUnitAnimation(udg_TuMoUnit,"Attack")
call AddSpecialEffectTargetUnitBJ("weapon",udg_TuMoUnit,"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("weapon",udg_TuMoUnit,"Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
set udg_TuMoPoint[1]=PolarProjectionBJ(udg_TuMoPoint[0],100.00,90.00)
call SetUnitPositionLocFacingBJ(udg_TuMoUnit,udg_TuMoPoint[1],(AngleBetweenPoints(udg_TuMoPoint[0],udg_TuMoPoint[1])+0.00))
call UnitDamageTargetBJ(udg_TuMoUnit,udg_TuMoHurtUnit,(I2R(udg_TuMoNC4)*(I2R(GetHeroAgi(udg_TuMoUnit,false))*I2R(udg_TuWeaponL[GetConvertedPlayerId(GetOwningPlayer(udg_TuMoUnit))]))),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
call RemoveLocation(udg_TuMoPoint[1])
call SetUnitAnimation(udg_TuMoHurtUnit,"death")
endif
if (Trig_TuMoF40_Func010C()) then
call DisableTrigger(GetTriggeringTrigger())
call PauseUnitBJ(false,udg_TuMoUnit)
call PauseUnitBJ(false,udg_TuMoHurtUnit)
call SetUnitInvulnerable(udg_TuMoUnit,false)
call SetUnitPathing(udg_TuMoUnit,true)
call ResetUnitAnimation(udg_TuMoUnit)
call SetUnitTimeScalePercent(udg_TuMoUnit,100.00)
call RemoveLocation(udg_TuMoPoint[0])
call ResetUnitAnimation(udg_TuMoHurtUnit)
endif
endfunction
function Trig_TuMoF16_Func003002001003001001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_TuMoF16_Func003002001003001002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_TuMoUnit)))
endfunction
function Trig_TuMoF16_Func003002001003001 takes nothing returns boolean
return GetBooleanAnd(Trig_TuMoF16_Func003002001003001001(),Trig_TuMoF16_Func003002001003001002())
endfunction
function Trig_TuMoF16_Func003002001003002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_TuMoF16_Func003002001003 takes nothing returns boolean
return GetBooleanAnd(Trig_TuMoF16_Func003002001003001(),Trig_TuMoF16_Func003002001003002())
endfunction
function Trig_TuMoF16_Func018Func007Func002001001003001001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_TuMoF16_Func018Func007Func002001001003001002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_TuMoUnit)))
endfunction
function Trig_TuMoF16_Func018Func007Func002001001003001 takes nothing returns boolean
return GetBooleanAnd(Trig_TuMoF16_Func018Func007Func002001001003001001(),Trig_TuMoF16_Func018Func007Func002001001003001002())
endfunction
function Trig_TuMoF16_Func018Func007Func002001001003002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_TuMoF16_Func018Func007Func002001001003 takes nothing returns boolean
return GetBooleanAnd(Trig_TuMoF16_Func018Func007Func002001001003001(),Trig_TuMoF16_Func018Func007Func002001001003002())
endfunction
function Trig_TuMoF16_Func018Func007C takes nothing returns boolean
return ((udg_TuMoNC<1))or((CountUnitsInGroup(GetUnitsInRangeOfLocMatching(312.00,GetUnitLoc(udg_TuMoUnit),Condition(function Trig_TuMoF16_Func018Func007Func002001001003)))<1))
endfunction
function Trig_TuMoF16_Func018C takes nothing returns boolean
return (Trig_TuMoF16_Func018Func007C())
endfunction
function Trig_TuMoF16_Actions takes nothing returns nothing
call SetUnitVertexColorBJ(udg_TuMoUnit,0.00,0.00,0.00,70.00)
call ResetUnitAnimation(udg_TuMoUnit)
set udg_TuMo8Unit=GroupPickRandomUnit(GetUnitsInRangeOfLocMatching(300.00,GetUnitLoc(udg_TuMoHurtUnit),Condition(function Trig_TuMoF16_Func003002001003)))
call AddSpecialEffectTargetUnitBJ("weapon",udg_TuMoUnit,"units\\orc\\SpiritWyvern\\SpiritWyvern.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SelectUnitRemoveForPlayer(udg_TuMoUnit,GetOwningPlayer(udg_TuMoUnit))
call SetUnitAnimation(udg_TuMoUnit,"Attack")
call SetUnitPositionLocFacingBJ(udg_TuMoUnit,GetUnitLoc(udg_TuMo8Unit),(180.00-GetUnitFacing(udg_TuMo8Unit)))
call CreateTextTagUnitBJ((I2S(udg_TuMoNC)+" Hits"),udg_TuMo8Unit,0,10,0.00,100,0.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectLocBJ(GetUnitLoc(udg_TuMo8Unit),"Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_TuMoUnit,udg_TuMo8Unit,(((I2R(udg_TuMoNC)*I2R(GetHeroLevel(udg_TuMoUnit)))*I2R(GetHeroAgi(udg_TuMoUnit,false)))*I2R(udg_TuWeaponL[GetConvertedPlayerId(GetOwningPlayer(udg_TuMoUnit))])),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
set udg_TuMoHurtUnit=udg_TuMo8Unit
set udg_TuMoNC=(udg_TuMoNC-1)
if (Trig_TuMoF16_Func018C()) then
call DisableTrigger(GetTriggeringTrigger())
call SetUnitPathing(udg_TuMoUnit,true)
call SelectUnitForPlayerSingle(udg_TuMoUnit,GetOwningPlayer(udg_TuMoUnit))
call PauseUnitBJ(false,udg_TuMoUnit)
call SetUnitInvulnerable(udg_TuMoUnit,false)
call SetUnitVertexColorBJ(udg_TuMoUnit,100,100,100,0)
endif
endfunction
function Trig_TuMoF32_Func003Func001Func015C takes nothing returns boolean
return ((GetRandomInt(1,100)>=40))
endfunction
function Trig_TuMoF32_Func003Func001C takes nothing returns boolean
return ((IsUnitAliveBJ(udg_TuMoHurtUnit)))
endfunction
function Trig_TuMoF32_Actions takes nothing returns nothing
call SelectUnitRemoveForPlayer(udg_TuMoUnit,GetOwningPlayer(udg_TuMoUnit))
call SetUnitTimeScalePercent(udg_TuMoUnit,500.00)
set bj_forLoopBIndex=1
set bj_forLoopBIndexEnd=32
loop
exitwhen bj_forLoopBIndex>bj_forLoopBIndexEnd
if (Trig_TuMoF32_Func003Func001C()) then
call CreateTextTagUnitBJ((I2S(GetForLoopIndexB())+" Hits"),udg_TuMoHurtUnit,0,10,0.00,100,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),200.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call SetUnitAnimation(udg_TuMoUnit,"attack")
call SetUnitAnimation(udg_TuMoHurtUnit,"death")
call AddSpecialEffectTargetUnitBJ("chest",udg_TuMoHurtUnit,"Abilities\\Spells\\Other\\Volcano\\VolcanoDeath.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddLightningLoc("HWPB",GetUnitLoc(udg_TuMoHurtUnit),PolarProjectionBJ(GetUnitLoc(udg_TuMoHurtUnit),700.00,(I2R(GetForLoopIndexB())*11.25)))
call SetLightningColor(GetLastCreatedLightningBJ(),0.20,1,0.20,0.40)
set udg_ZhiZunRTeX2[(100+GetForLoopIndexB())]=GetLastCreatedLightningBJ()
call AddSpecialEffectTargetUnitBJ("origin",udg_TuMoHurtUnit,"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
if (Trig_TuMoF32_Func003Func001Func015C()) then
call AddSpecialEffectLocBJ(GetUnitLoc(udg_TuMoHurtUnit),"Objects\\Spawnmodels\\Other\\ToonBoom\\ToonBoom.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
endif
call UnitDamageTargetBJ(udg_TuMoUnit,udg_TuMoHurtUnit,(((I2R(GetForLoopIndexB())*I2R(GetHeroLevel(udg_TuMoUnit)))*I2R(GetHeroAgi(udg_TuMoUnit,false)))*I2R(udg_TuWeaponL[GetConvertedPlayerId(GetOwningPlayer(udg_TuMoUnit))])),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
call TriggerSleepAction(0.10)
else
call ResetUnitAnimation(udg_TuMoHurtUnit)
endif
set bj_forLoopBIndex=bj_forLoopBIndex+1
endloop
call SetUnitInvulnerable(udg_TuMoUnit,false)
call SetUnitTimeScalePercent(udg_TuMoUnit,100)
call PauseUnitBJ(false,udg_TuMoHurtUnit)
call IssueImmediateOrder(udg_TuMoUnit,"stop")
call PauseUnitBJ(false,udg_TuMoUnit)
set bj_forLoopAIndex=100
set bj_forLoopAIndexEnd=135
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyLightning(udg_ZhiZunRTeX2[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call DisableTrigger(GetTriggeringTrigger())
endfunction
function Trig_TuMoF64_Func002Func001C takes nothing returns boolean
return ((udg_TuMoNC>4))
endfunction
function Trig_TuMoF64_Func002C takes nothing returns boolean
return ((udg_TuMoNC==1))
endfunction
function Trig_TuMoF64_Actions takes nothing returns nothing
set udg_TuMoNC=(udg_TuMoNC+1)
if (Trig_TuMoF64_Func002C()) then
call CreateTextTagUnitBJ(("伤残狂击"+" 4连"),udg_TuMoUnit,0,20.00,0.00,100,0.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectTargetUnitBJ("weapon",udg_TuMoUnit,"Abilities\\Weapons\\IllidanMissile\\IllidanMissile.mdl")
set udg_TuMoPoint[67]=PolarProjectionBJ(udg_TuMoPoint[66],200.00,270.00)
call SetUnitPositionLocFacingBJ(udg_TuMoUnit,udg_TuMoPoint[67],AngleBetweenPoints(udg_TuMoPoint[65],udg_TuMoPoint[66]))
call DestroyEffect(GetLastCreatedEffectBJ())
else
if (Trig_TuMoF64_Func002Func001C()) then
call DisableTrigger(GetTriggeringTrigger())
set udg_TuMoNC=4
call TriggerSleepAction(0.50)
call EnableTrigger(gg_trg_TuMoF6z16)
call SetUnitTimeScalePercent(udg_TuMoUnit,200.00)
return
endif
endif
set udg_TuMoPoint[65]=GetUnitLoc(udg_TuMoUnit)
set udg_TuMoPoint[66]=GetUnitLoc(udg_TuMoHurtUnit)
set udg_TuMoPoint[67]=PolarProjectionBJ(udg_TuMoPoint[65],(DistanceBetweenPoints(udg_TuMoPoint[66],udg_TuMoPoint[65])/2.00),AngleBetweenPoints(udg_TuMoPoint[65],udg_TuMoPoint[66]))
call PanCameraToTimedLocForPlayer(GetOwningPlayer(udg_TuMoUnit),udg_TuMoPoint[67],2.00)
call RemoveLocation(udg_TuMoPoint[67])
call SetCameraFieldForPlayer(GetOwningPlayer(udg_TuMoUnit),CAMERA_FIELD_ROTATION,(AngleBetweenPoints(udg_TuMoPoint[65],udg_TuMoPoint[66])+90.00),2.00)
set udg_TuMoPoint[67]=PolarProjectionBJ(udg_TuMoPoint[66],200.00,(I2R(udg_TuMoNC)*90.00))
call PanCameraToTimedLocForPlayer(GetOwningPlayer(udg_TuMoUnit),udg_TuMoPoint[67],0.30)
call AddSpecialEffectTargetUnitBJ("weapon",udg_TuMoUnit,"Abilities\\Weapons\\IllidanMissile\\IllidanMissile.mdl")
call SetUnitAnimation(udg_TuMoUnit,"attack")
call SetUnitPositionLocFacingBJ(udg_TuMoUnit,udg_TuMoPoint[67],AngleBetweenPoints(udg_TuMoPoint[65],udg_TuMoPoint[66]))
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_TuMoUnit,udg_TuMoHurtUnit,(((I2R(udg_TuMoNC)*I2R(GetHeroLevel(udg_TuMoUnit)))*I2R(GetHeroAgi(udg_TuMoUnit,false)))*I2R(udg_TuWeaponL[GetConvertedPlayerId(GetOwningPlayer(udg_TuMoUnit))])),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
call AddSpecialEffectLocBJ(udg_TuMoPoint[66],"Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call RemoveLocation(udg_TuMoPoint[67])
call RemoveLocation(udg_TuMoPoint[65])
endfunction
function Trig_TuMoF6z16_Func002Func001C takes nothing returns boolean
return ((udg_TuMoNC>21))
endfunction
function Trig_TuMoF6z16_Func002C takes nothing returns boolean
return ((udg_TuMoNC==5))
endfunction
function Trig_TuMoF6z16_Func012C takes nothing returns boolean
return ((ModuloInteger(udg_TuMoNC,2)==1))
endfunction
function Trig_TuMoF6z16_Actions takes nothing returns nothing
set udg_TuMoNC=(udg_TuMoNC+1)
if (Trig_TuMoF6z16_Func002C()) then
call CreateTextTagUnitBJ(("伤残狂击"+" 16连"),udg_TuMoUnit,0,20.00,0.00,100,0.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
else
if (Trig_TuMoF6z16_Func002Func001C()) then
call DisableTrigger(GetTriggeringTrigger())
set udg_TuMoNC=21
call TriggerSleepAction(1.00)
call EnableTrigger(gg_trg_TuMoF6z32)
call SetUnitTimeScalePercent(udg_TuMoUnit,500.00)
return
endif
endif
set udg_TuMoPoint[65]=GetUnitLoc(udg_TuMoUnit)
set udg_TuMoPoint[66]=GetUnitLoc(udg_TuMoHurtUnit)
set udg_TuMoPoint[67]=PolarProjectionBJ(udg_TuMoPoint[65],(DistanceBetweenPoints(udg_TuMoPoint[66],udg_TuMoPoint[65])/2.00),AngleBetweenPoints(udg_TuMoPoint[65],udg_TuMoPoint[66]))
call PanCameraToTimedLocForPlayer(GetOwningPlayer(udg_TuMoUnit),udg_TuMoPoint[67],2.00)
call RemoveLocation(udg_TuMoPoint[67])
call SetCameraFieldForPlayer(GetOwningPlayer(udg_TuMoUnit),CAMERA_FIELD_ROTATION,(AngleBetweenPoints(udg_TuMoPoint[65],udg_TuMoPoint[66])+90.00),2.00)
set udg_TuMoPoint[67]=PolarProjectionBJ(udg_TuMoPoint[66],200.00,(I2R(udg_TuMoNC)*90.00))
call PanCameraToTimedLocForPlayer(GetOwningPlayer(udg_TuMoUnit),udg_TuMoPoint[67],0.30)
if (Trig_TuMoF6z16_Func012C()) then
set udg_TuMoPoint[67]=PolarProjectionBJ(udg_TuMoPoint[66],300.00,(AngleBetweenPoints(udg_TuMoPoint[66],udg_TuMoPoint[65])+180.00))
call AddSpecialEffectTargetUnitBJ("weapon",udg_TuMoUnit,"Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl")
call SetUnitAnimation(udg_TuMoUnit,"attack")
call SetUnitPositionLocFacingBJ(udg_TuMoUnit,udg_TuMoPoint[67],AngleBetweenPoints(udg_TuMoPoint[65],udg_TuMoPoint[66]))
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_TuMoUnit,udg_TuMoHurtUnit,(((I2R(udg_TuMoNC)*I2R(GetHeroLevel(udg_TuMoUnit)))*I2R(GetHeroAgi(udg_TuMoUnit,false)))*I2R(udg_TuWeaponL[GetConvertedPlayerId(GetOwningPlayer(udg_TuMoUnit))])),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
call RemoveLocation(udg_TuMoPoint[67])
else
set udg_TuMoPoint[67]=PolarProjectionBJ(udg_TuMoPoint[66],300.00,(AngleBetweenPoints(udg_TuMoPoint[66],udg_TuMoPoint[65])+22.50))
call AddSpecialEffectTargetUnitBJ("weapon",udg_TuMoUnit,"Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl")
call SetUnitAnimation(udg_TuMoUnit,"attack")
call SetUnitPositionLocFacingBJ(udg_TuMoUnit,udg_TuMoPoint[67],AngleBetweenPoints(udg_TuMoPoint[65],udg_TuMoPoint[66]))
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_TuMoUnit,udg_TuMoHurtUnit,(((I2R(udg_TuMoNC)*I2R(GetHeroLevel(udg_TuMoUnit)))*I2R(GetHeroAgi(udg_TuMoUnit,false)))*I2R(udg_TuWeaponL[GetConvertedPlayerId(GetOwningPlayer(udg_TuMoUnit))])),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
call RemoveLocation(udg_TuMoPoint[67])
endif
call AddSpecialEffectLocBJ(udg_TuMoPoint[66],"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(udg_TuMoPoint[66],"Abilities\\Spells\\Human\\Polymorph\\PolyMorphTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
set udg_TuMoPoint[80]=PolarProjectionBJ(udg_TuMoPoint[66],350.00,(AngleBetweenPoints(udg_TuMoPoint[66],udg_TuMoPoint[65])+0.00))
set udg_TuMoPoint[81]=PolarProjectionBJ(udg_TuMoPoint[66],350.00,(AngleBetweenPoints(udg_TuMoPoint[66],udg_TuMoPoint[65])+90.00))
set udg_TuMoPoint[82]=PolarProjectionBJ(udg_TuMoPoint[66],350.00,(AngleBetweenPoints(udg_TuMoPoint[66],udg_TuMoPoint[65])+180.00))
set udg_TuMoPoint[83]=PolarProjectionBJ(udg_TuMoPoint[66],350.00,(AngleBetweenPoints(udg_TuMoPoint[66],udg_TuMoPoint[65])+270.00))
call AddLightningLoc("HWPB",udg_TuMoPoint[80],udg_TuMoPoint[81])
call SetLightningColor(GetLastCreatedLightningBJ(),GetRandomReal(0,1),GetRandomReal(0,1),GetRandomReal(0,1),1)
set udg_YuMoFlash[(80+udg_TuMoNC)]=GetLastCreatedLightningBJ()
call AddLightningLoc("HWPB",udg_TuMoPoint[81],udg_TuMoPoint[82])
call SetLightningColor(GetLastCreatedLightningBJ(),GetRandomReal(0,1),GetRandomReal(0,1),GetRandomReal(0,1),1)
set udg_YuMoFlash[(110+udg_TuMoNC)]=GetLastCreatedLightningBJ()
call AddLightningLoc("HWPB",udg_TuMoPoint[82],udg_TuMoPoint[83])
call SetLightningColor(GetLastCreatedLightningBJ(),GetRandomReal(0,1),GetRandomReal(0,1),GetRandomReal(0,1),1)
set udg_YuMoFlash[(140+udg_TuMoNC)]=GetLastCreatedLightningBJ()
call AddLightningLoc("HWPB",udg_TuMoPoint[83],udg_TuMoPoint[80])
call SetLightningColor(GetLastCreatedLightningBJ(),GetRandomReal(0,1),GetRandomReal(0,1),GetRandomReal(0,1),1)
set udg_YuMoFlash[(170+udg_TuMoNC)]=GetLastCreatedLightningBJ()
call RemoveLocation(udg_TuMoPoint[67])
call RemoveLocation(udg_TuMoPoint[65])
endfunction
function Trig_TuMoF6z32_Func002Func001C takes nothing returns boolean
return ((udg_TuMoNC>54))
endfunction
function Trig_TuMoF6z32_Func002C takes nothing returns boolean
return ((udg_TuMoNC==22))
endfunction
function Trig_TuMoF6z32_Func031001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_TuMoF6z32_Func031001003002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_TuMoUnit)))
endfunction
function Trig_TuMoF6z32_Func031001003 takes nothing returns boolean
return GetBooleanAnd(Trig_TuMoF6z32_Func031001003001(),Trig_TuMoF6z32_Func031001003002())
endfunction
function Trig_TuMoF6z32_Func031A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Undead\\Impale\\ImpaleHitTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_TuMoUnit,udg_TuMoHurtUnit,(((1.00*I2R(GetHeroLevel(udg_TuMoUnit)))*I2R(GetHeroAgi(udg_TuMoUnit,false)))*I2R(udg_TuWeaponL[GetConvertedPlayerId(GetOwningPlayer(udg_TuMoUnit))])),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
endfunction
function Trig_TuMoF6z32_Actions takes nothing returns nothing
set udg_TuMoNC=(udg_TuMoNC+1)
if (Trig_TuMoF6z32_Func002C()) then
call CreateTextTagUnitBJ(("伤残狂击"+" 32连"),udg_TuMoUnit,0,20.00,0.00,100,0.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
set bj_forLoopAIndex=80
set bj_forLoopAIndexEnd=240
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyLightning(udg_YuMoFlash[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
else
if (Trig_TuMoF6z32_Func002Func001C()) then
call DisableTrigger(GetTriggeringTrigger())
set udg_TuMoNC=54
call TriggerSleepAction(1.00)
call EnableTrigger(gg_trg_TuMoF6z64)
call SetUnitTimeScalePercent(udg_TuMoUnit,800.00)
return
endif
endif
set udg_TuMoPoint[65]=GetUnitLoc(udg_TuMoUnit)
set udg_TuMoPoint[66]=GetUnitLoc(udg_TuMoHurtUnit)
set udg_TuMoPoint[67]=PolarProjectionBJ(udg_TuMoPoint[65],(DistanceBetweenPoints(udg_TuMoPoint[66],udg_TuMoPoint[65])/2.00),AngleBetweenPoints(udg_TuMoPoint[65],udg_TuMoPoint[66]))
call PanCameraToTimedLocForPlayer(GetOwningPlayer(udg_TuMoUnit),udg_TuMoPoint[67],2.00)
call RemoveLocation(udg_TuMoPoint[67])
call SetCameraFieldForPlayer(GetOwningPlayer(udg_TuMoUnit),CAMERA_FIELD_ROTATION,(AngleBetweenPoints(udg_TuMoPoint[65],udg_TuMoPoint[66])+90.00),2.00)
set udg_TuMoPoint[67]=PolarProjectionBJ(udg_TuMoPoint[66],30.00,GetRandomReal(0,360.00))
call SetUnitPositionLocFacingBJ(udg_TuMoHurtUnit,udg_TuMoPoint[67],AngleBetweenPoints(udg_TuMoPoint[66],udg_TuMoPoint[65]))
call PanCameraToTimedLocForPlayer(GetOwningPlayer(udg_TuMoUnit),udg_TuMoPoint[67],0.30)
call RemoveLocation(udg_TuMoPoint[67])
call RemoveLocation(udg_TuMoPoint[66])
set udg_TuMoPoint[66]=GetUnitLoc(udg_TuMoHurtUnit)
set udg_TuMoPoint[67]=PolarProjectionBJ(udg_TuMoPoint[66],35.00,GetRandomReal(0,360.00))
call SetUnitAnimation(udg_TuMoUnit,"attack")
call AddSpecialEffectTargetUnitBJ("weapon",udg_TuMoUnit,"Abilities\\Weapons\\ZigguratMissile\\ZigguratMissile.mdl")
call SetUnitPositionLocFacingBJ(udg_TuMoUnit,udg_TuMoPoint[67],AngleBetweenPoints(udg_TuMoPoint[66],udg_TuMoPoint[65]))
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(udg_TuMoPoint[66],"Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(udg_TuMoPoint[66],"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(udg_TuMoPoint[66],"Abilities\\Spells\\NightElf\\EntangleMine\\Roots.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_TuMoUnit,udg_TuMoHurtUnit,(((I2R(udg_TuMoNC)*I2R(GetHeroLevel(udg_TuMoUnit)))*I2R(GetHeroAgi(udg_TuMoUnit,false)))*I2R(udg_TuWeaponL[GetConvertedPlayerId(GetOwningPlayer(udg_TuMoUnit))])),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
call RemoveLocation(udg_TuMoPoint[67])
set bj_forLoopBIndex=1
set bj_forLoopBIndexEnd=20
loop
exitwhen bj_forLoopBIndex>bj_forLoopBIndexEnd
set udg_TuMoPoint[67]=PolarProjectionBJ(udg_TuMoPoint[66],500.00,(I2R(GetForLoopIndexB())*18.00))
call AddSpecialEffectLocBJ(udg_TuMoPoint[67],"Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call RemoveLocation(udg_TuMoPoint[67])
set bj_forLoopBIndex=bj_forLoopBIndex+1
endloop
call ForGroupBJ(GetUnitsInRangeOfLocMatching(500.00,udg_TuMoPoint[66],Condition(function Trig_TuMoF6z32_Func031001003)),function Trig_TuMoF6z32_Func031A)
call RemoveLocation(udg_TuMoPoint[66])
call RemoveLocation(udg_TuMoPoint[65])
endfunction
function Trig_TuMoF6z64_Func002Func001C takes nothing returns boolean
return ((udg_TuMoNC>64))
endfunction
function Trig_TuMoF6z64_Func002C takes nothing returns boolean
return ((udg_TuMoNC==55))
endfunction
function Trig_TuMoF6z64_Func012C takes nothing returns boolean
return ((ModuloInteger(udg_TuMoNC,2)==1))
endfunction
function Trig_TuMoF6z64_Actions takes nothing returns nothing
set udg_TuMoNC=(udg_TuMoNC+1)
if (Trig_TuMoF6z64_Func002C()) then
call CreateTextTagUnitBJ(("伤残狂击"+" 64连"),udg_TuMoUnit,0,20.00,0.00,100,0.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
else
if (Trig_TuMoF6z64_Func002Func001C()) then
call DisableTrigger(GetTriggeringTrigger())
set udg_TuMoNC=0
call PauseUnitBJ(false,udg_TuMoUnit)
call PauseUnitBJ(false,udg_TuMoHurtUnit)
call SetUnitInvulnerable(udg_TuMoUnit,false)
call ResetUnitAnimation(udg_TuMoUnit)
call SetUnitTimeScalePercent(udg_TuMoUnit,100)
call ResetToGameCameraForPlayer(GetOwningPlayer(udg_TuMoUnit),0.50)
call DestroyEffect(udg_MuWeaponTEX[888])
call DestroyEffect(udg_MuWeaponTEX[889])
set bj_forLoopAIndex=120
set bj_forLoopAIndexEnd=350
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyLightning(udg_YuMoFlash[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endif
endif
set udg_TuMoPoint[65]=GetUnitLoc(udg_TuMoUnit)
set udg_TuMoPoint[66]=GetUnitLoc(udg_TuMoHurtUnit)
set udg_TuMoPoint[67]=PolarProjectionBJ(udg_TuMoPoint[65],(DistanceBetweenPoints(udg_TuMoPoint[66],udg_TuMoPoint[65])/2.00),AngleBetweenPoints(udg_TuMoPoint[65],udg_TuMoPoint[66]))
call PanCameraToTimedLocForPlayer(GetOwningPlayer(udg_TuMoUnit),udg_TuMoPoint[67],2.00)
call RemoveLocation(udg_TuMoPoint[67])
call SetCameraFieldForPlayer(GetOwningPlayer(udg_TuMoUnit),CAMERA_FIELD_ROTATION,(AngleBetweenPoints(udg_TuMoPoint[65],udg_TuMoPoint[66])+90.00),2.00)
set udg_TuMoPoint[67]=PolarProjectionBJ(udg_TuMoPoint[66],200.00,(I2R(udg_TuMoNC)*90.00))
call PanCameraToTimedLocForPlayer(GetOwningPlayer(udg_TuMoUnit),udg_TuMoPoint[67],0.30)
if (Trig_TuMoF6z64_Func012C()) then
set udg_TuMoPoint[67]=PolarProjectionBJ(udg_TuMoPoint[66],300.00,(AngleBetweenPoints(udg_TuMoPoint[66],udg_TuMoPoint[65])+180.00))
call AddSpecialEffectTargetUnitBJ("weapon",udg_TuMoUnit,"Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl")
call SetUnitAnimation(udg_TuMoUnit,"attack")
call SetUnitPositionLocFacingBJ(udg_TuMoUnit,udg_TuMoPoint[67],AngleBetweenPoints(udg_TuMoPoint[65],udg_TuMoPoint[66]))
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_TuMoUnit,udg_TuMoHurtUnit,(((I2R(udg_TuMoNC)*I2R(GetHeroLevel(udg_TuMoUnit)))*I2R(GetHeroAgi(udg_TuMoUnit,false)))*I2R(udg_TuWeaponL[GetConvertedPlayerId(GetOwningPlayer(udg_TuMoUnit))])),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
call RemoveLocation(udg_TuMoPoint[67])
else
set udg_TuMoPoint[67]=PolarProjectionBJ(udg_TuMoPoint[66],300.00,(AngleBetweenPoints(udg_TuMoPoint[66],udg_TuMoPoint[65])+36.00))
call AddSpecialEffectTargetUnitBJ("weapon",udg_TuMoUnit,"Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl")
call SetUnitAnimation(udg_TuMoUnit,"attack")
call SetUnitPositionLocFacingBJ(udg_TuMoUnit,udg_TuMoPoint[67],AngleBetweenPoints(udg_TuMoPoint[65],udg_TuMoPoint[66]))
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_TuMoUnit,udg_TuMoHurtUnit,(((I2R(udg_TuMoNC)*I2R(GetHeroLevel(udg_TuMoUnit)))*I2R(GetHeroAgi(udg_TuMoUnit,false)))*I2R(udg_TuWeaponL[GetConvertedPlayerId(GetOwningPlayer(udg_TuMoUnit))])),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
call RemoveLocation(udg_TuMoPoint[67])
endif
call AddSpecialEffectLocBJ(udg_TuMoPoint[66],"Abilities\\Spells\\Items\\AIta\\CrystalBallCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(udg_TuMoPoint[66],"Abilities\\Spells\\Human\\Flare\\FlareCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(udg_TuMoPoint[66],"Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
set udg_TuMoPoint[80]=PolarProjectionBJ(udg_TuMoPoint[66],500.00,(AngleBetweenPoints(udg_TuMoPoint[66],udg_TuMoPoint[65])+0.00))
set udg_TuMoPoint[81]=PolarProjectionBJ(udg_TuMoPoint[66],500.00,(AngleBetweenPoints(udg_TuMoPoint[66],udg_TuMoPoint[65])+72.00))
set udg_TuMoPoint[82]=PolarProjectionBJ(udg_TuMoPoint[66],500.00,(AngleBetweenPoints(udg_TuMoPoint[66],udg_TuMoPoint[65])+144.00))
set udg_TuMoPoint[83]=PolarProjectionBJ(udg_TuMoPoint[66],500.00,(AngleBetweenPoints(udg_TuMoPoint[66],udg_TuMoPoint[65])+216.00))
set udg_TuMoPoint[84]=PolarProjectionBJ(udg_TuMoPoint[66],500.00,(AngleBetweenPoints(udg_TuMoPoint[66],udg_TuMoPoint[65])+288.00))
call AddLightningLoc("HWPB",udg_TuMoPoint[80],udg_TuMoPoint[82])
call SetLightningColor(GetLastCreatedLightningBJ(),GetRandomReal(0,1),GetRandomReal(0,1),GetRandomReal(0,1),1)
set udg_YuMoFlash[(80+udg_TuMoNC)]=GetLastCreatedLightningBJ()
call AddLightningLoc("HWPB",udg_TuMoPoint[81],udg_TuMoPoint[83])
call SetLightningColor(GetLastCreatedLightningBJ(),GetRandomReal(0,1),GetRandomReal(0,1),GetRandomReal(0,1),1)
set udg_YuMoFlash[(110+udg_TuMoNC)]=GetLastCreatedLightningBJ()
call AddLightningLoc("HWPB",udg_TuMoPoint[82],udg_TuMoPoint[84])
call SetLightningColor(GetLastCreatedLightningBJ(),GetRandomReal(0,1),GetRandomReal(0,1),GetRandomReal(0,1),1)
set udg_YuMoFlash[(140+udg_TuMoNC)]=GetLastCreatedLightningBJ()
call AddLightningLoc("HWPB",udg_TuMoPoint[83],udg_TuMoPoint[80])
call SetLightningColor(GetLastCreatedLightningBJ(),GetRandomReal(0,1),GetRandomReal(0,1),GetRandomReal(0,1),1)
set udg_YuMoFlash[(170+udg_TuMoNC)]=GetLastCreatedLightningBJ()
call AddLightningLoc("HWPB",udg_TuMoPoint[84],udg_TuMoPoint[81])
call SetLightningColor(GetLastCreatedLightningBJ(),GetRandomReal(0,1),GetRandomReal(0,1),GetRandomReal(0,1),1)
set udg_YuMoFlash[(200+udg_TuMoNC)]=GetLastCreatedLightningBJ()
call RemoveLocation(udg_TuMoPoint[67])
call RemoveLocation(udg_TuMoPoint[65])
endfunction
function Trig_TuMoF64death_Func001C takes nothing returns boolean
return ((IsUnitDeadBJ(udg_TuMoHurtUnit)))or((IsUnitDeadBJ(udg_TuMoUnit)))
endfunction
function Trig_TuMoF64death_Conditions takes nothing returns boolean
return (Trig_TuMoF64death_Func001C())
endfunction
function Trig_TuMoF64death_Actions takes nothing returns nothing
call DisableTrigger(gg_trg_TuMoF64)
call DisableTrigger(gg_trg_TuMoF6z16)
call DisableTrigger(gg_trg_TuMoF6z32)
call DisableTrigger(gg_trg_TuMoF6z64)
call DisableTrigger(gg_trg_TuMoF64death)
set bj_forLoopAIndex=80
set bj_forLoopAIndexEnd=240
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyLightning(udg_YuMoFlash[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=120
set bj_forLoopAIndexEnd=350
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyLightning(udg_YuMoFlash[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call PauseUnitBJ(false,udg_TuMoUnit)
call PauseUnitBJ(false,udg_TuMoHurtUnit)
call SetUnitInvulnerable(udg_TuMoUnit,false)
call DestroyEffect(udg_MuWeaponTEX[888])
call DestroyEffect(udg_MuWeaponTEX[889])
call ResetUnitAnimation(udg_TuMoUnit)
call SetUnitTimeScalePercent(udg_TuMoUnit,100)
call ResetToGameCameraForPlayer(GetOwningPlayer(udg_TuMoUnit),0.50)
call RemoveLocation(udg_TuMoPoint[65])
call RemoveLocation(udg_TuMoPoint[66])
call RemoveLocation(udg_TuMoPoint[67])
endfunction
function Trig_tjzs_Func001C takes nothing returns boolean
return ((udg_TuMo_isrun==false))and((GetUnitLevel(udg_TuMoUnit)>=50))
endfunction
function Trig_tjzs_Conditions takes nothing returns boolean
return (Trig_tjzs_Func001C())
endfunction
function Trig_tjzs_Func005Func004Func002C takes nothing returns boolean
return ((DistanceBetweenPoints(udg_TuMo_spt,OffsetLocation(udg_TuMoCEN,(0.00-(udg_TuMo_range/2.00)),0))>100.00))
endfunction
function Trig_tjzs_Func007001003001 takes nothing returns boolean
return (GetFilterUnit()!=udg_TuMoUnit)
endfunction
function Trig_tjzs_Func007001003002 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_tjzs_Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_tjzs_Func007001003001(),Trig_tjzs_Func007001003002())
endfunction
function Trig_tjzs_Func007A takes nothing returns nothing
call UnitDamageTargetBJ(udg_TuMoUnit,GetEnumUnit(),(((50.00*I2R(GetHeroLevel(udg_TuMoUnit)))*I2R(GetHeroAgi(udg_TuMoUnit,false)))*I2R(udg_TuWeaponL[GetConvertedPlayerId(GetOwningPlayer(udg_TuMoUnit))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
set udg_TuMo_tx[udg_TuMo_js]=AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Undead\\Cripple\\CrippleTarget.mdl")
set udg_TuMo_js=(udg_TuMo_js+1)
endfunction
function Trig_tjzs_Func014Func001C takes nothing returns boolean
return ((GetForLoopIndexA()>5))and((GetForLoopIndexA()<10))
endfunction
function Trig_tjzs_Func015Func001C takes nothing returns boolean
return ((GetForLoopIndexA()>3))and((GetForLoopIndexA()<8))
endfunction
function Trig_tjzs_Func016Func001C takes nothing returns boolean
return ((GetForLoopIndexA()>1))and((GetForLoopIndexA()<6))
endfunction
function Trig_tjzs_Func019Func001C takes nothing returns boolean
return ((GetForLoopIndexA()>3))and((GetForLoopIndexA()<8))
endfunction
function Trig_tjzs_Func022Func001C takes nothing returns boolean
return ((GetForLoopIndexA()>5))and((GetForLoopIndexA()<10))
endfunction
function Trig_tjzs_Func024Func001C takes nothing returns boolean
return ((GetForLoopIndexA()>1))and((GetForLoopIndexA()<6))
endfunction
function Trig_tjzs_Func026Func001C takes nothing returns boolean
return ((GetForLoopIndexA()>5))and((GetForLoopIndexA()<10))
endfunction
function Trig_tjzs_Func032Func001C takes nothing returns boolean
return ((GetForLoopIndexA()>1))and((GetForLoopIndexA()<6))
endfunction
function Trig_tjzs_Func035Func001C takes nothing returns boolean
return ((GetForLoopIndexA()>3))and((GetForLoopIndexA()<8))
endfunction
function Trig_tjzs_Func036Func001C takes nothing returns boolean
return ((GetForLoopIndexA()>1))and((GetForLoopIndexA()<6))
endfunction
function Trig_tjzs_Func038Func001C takes nothing returns boolean
return ((GetForLoopIndexA()>5))and((GetForLoopIndexA()<10))
endfunction
function Trig_tjzs_Func039Func001C takes nothing returns boolean
return ((GetForLoopIndexA()>3))and((GetForLoopIndexA()<8))
endfunction
function Trig_tjzs_Func041001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_tjzs_Func041001003002 takes nothing returns boolean
return (GetFilterUnit()!=udg_TuMoUnit)
endfunction
function Trig_tjzs_Func041001003 takes nothing returns boolean
return GetBooleanAnd(Trig_tjzs_Func041001003001(),Trig_tjzs_Func041001003002())
endfunction
function Trig_tjzs_Func041A takes nothing returns nothing
call UnitDamageTargetBJ(udg_TuMoUnit,GetEnumUnit(),(((80.00*I2R(GetHeroLevel(udg_TuMoUnit)))*I2R(GetHeroAgi(udg_TuMoUnit,false)))*I2R(udg_TuWeaponL[GetConvertedPlayerId(GetOwningPlayer(udg_TuMoUnit))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
set udg_TuMo_tx[udg_TuMo_js]=AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Undead\\FrostArmor\\FrostArmorDamage.mdl")
set udg_TuMo_js=(udg_TuMo_js+1)
endfunction
function Trig_tjzs_Func054001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_tjzs_Func054001003002 takes nothing returns boolean
return (GetFilterUnit()!=udg_TuMoUnit)
endfunction
function Trig_tjzs_Func054001003 takes nothing returns boolean
return GetBooleanAnd(Trig_tjzs_Func054001003001(),Trig_tjzs_Func054001003002())
endfunction
function Trig_tjzs_Func054A takes nothing returns nothing
call UnitDamageTargetBJ(udg_TuMoUnit,GetEnumUnit(),(((100.00*I2R(GetHeroLevel(udg_TuMoUnit)))*I2R(GetHeroAgi(udg_TuMoUnit,false)))*I2R(udg_TuWeaponL[GetConvertedPlayerId(GetOwningPlayer(udg_TuMoUnit))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
set udg_TuMo_tx[udg_TuMo_js]=AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Orc\\LightningShield\\LightningShieldTarget.mdl")
set udg_TuMo_js=(udg_TuMo_js+1)
endfunction
function Trig_tjzs_Actions takes nothing returns nothing
set udg_TuMo_isrun=true
set udg_TuMoCEN=GetUnitLoc(udg_TuMoUnit)
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=44
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_TuMo_tx[udg_TuMo_js]=AddSpecialEffectLocBJ(PolarProjectionBJ(udg_TuMoCEN,udg_TuMo_range,I2R((GetForLoopIndexA()*4))),"Doodads\\Cinematic\\FireRockSmall\\FireRockSmall.mdl")
set udg_TuMo_js=(udg_TuMo_js+1)
set udg_TuMo_tx[udg_TuMo_js]=AddSpecialEffectLocBJ(PolarProjectionBJ(udg_TuMoCEN,udg_TuMo_range,I2R(((GetForLoopIndexA()*4)+180))),"Doodads\\Cinematic\\FireRockSmall\\FireRockSmall.mdl")
set udg_TuMo_js=(udg_TuMo_js+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=19
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_TuMo_end=((GetForLoopIndexA()+1)*2)
set udg_TuMo_each=(180.00/I2R(udg_TuMo_end))
set udg_TuMo_srange=(I2R(GetForLoopIndexA())*(udg_TuMo_range/20.00))
set bj_forLoopBIndex=0
set bj_forLoopBIndexEnd=udg_TuMo_end
loop
exitwhen bj_forLoopBIndex>bj_forLoopBIndexEnd
set udg_TuMo_spt=PolarProjectionBJ(udg_TuMoCEN,udg_TuMo_srange,(AcosBJ((udg_TuMo_srange/udg_TuMo_range))+(I2R(GetForLoopIndexB())*udg_TuMo_each)))
if (Trig_tjzs_Func005Func004Func002C()) then
set udg_TuMo_tx[udg_TuMo_js]=AddSpecialEffectLocBJ(udg_TuMo_spt,"Doodads\\Cinematic\\FireRockSmall\\FireRockSmall.mdl")
set udg_TuMo_js=(udg_TuMo_js+1)
endif
set bj_forLoopBIndex=bj_forLoopBIndex+1
endloop
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=10
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set bj_forLoopBIndex=0
set bj_forLoopBIndexEnd=((GetForLoopIndexA()+1)/2)
loop
exitwhen bj_forLoopBIndex>bj_forLoopBIndexEnd
set udg_TuMo_tx[udg_TuMo_js]=AddSpecialEffectLocBJ(PolarProjectionBJ(OffsetLocation(udg_TuMoCEN,(udg_TuMo_range/2.00),0),(I2R(GetForLoopIndexA())*5.00),(I2R(GetForLoopIndexB())*(720.00/(I2R(GetForLoopIndexA())+1)))),"Doodads\\Cinematic\\FireRockSmall\\FireRockSmall.mdl")
set udg_TuMo_js=(udg_TuMo_js+1)
set bj_forLoopBIndex=bj_forLoopBIndex+1
endloop
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call ForGroupBJ(GetUnitsInRangeOfLocMatching(400.00,udg_TuMoCEN,Condition(function Trig_tjzs_Func007001003)),function Trig_tjzs_Func007A)
call TriggerSleepAction(1.00)
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=15
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_TuMo_tx[udg_TuMo_js]=AddSpecialEffectLocBJ(OffsetLocation(udg_TuMoCEN,700.00,(256.00-(I2R(GetForLoopIndexA())*32.00))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_TuMo_js=(udg_TuMo_js+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_TuMo_tx[udg_TuMo_js]=AddSpecialEffectLocBJ(OffsetLocation(udg_TuMoCEN,600.00,(218.00-(I2R(GetForLoopIndexA())*36.33))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_TuMo_js=(udg_TuMo_js+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=7
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_TuMo_tx[udg_TuMo_js]=AddSpecialEffectLocBJ(OffsetLocation(udg_TuMoCEN,500.00,(182.00-(I2R(GetForLoopIndexA())*45.50))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_TuMo_js=(udg_TuMo_js+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=15
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func014Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_TuMoCEN,-700.00,(256.00-(I2R(GetForLoopIndexA())*32.00))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_TuMo_tx[udg_TuMo_js]=GetLastCreatedEffectBJ()
set udg_TuMo_js=(udg_TuMo_js+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func015Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_TuMoCEN,-600.00,(218.00-(I2R(GetForLoopIndexA())*36.33))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_TuMo_tx[udg_TuMo_js]=GetLastCreatedEffectBJ()
set udg_TuMo_js=(udg_TuMo_js+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=7
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func016Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_TuMoCEN,-500.00,(182.00-(I2R(GetForLoopIndexA())*45.50))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_TuMo_tx[udg_TuMo_js]=GetLastCreatedEffectBJ()
set udg_TuMo_js=(udg_TuMo_js+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=15
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_TuMo_tx[udg_TuMo_js]=AddSpecialEffectLocBJ(OffsetLocation(udg_TuMoCEN,(256.00-(I2R(GetForLoopIndexA())*32.00)),700.00),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_TuMo_js=(udg_TuMo_js+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func019Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_TuMoCEN,(218.00-(I2R(GetForLoopIndexA())*36.33)),600.00),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_TuMo_tx[udg_TuMo_js]=GetLastCreatedEffectBJ()
set udg_TuMo_js=(udg_TuMo_js+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=7
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_TuMo_tx[udg_TuMo_js]=AddSpecialEffectLocBJ(OffsetLocation(udg_TuMoCEN,(182.00-(I2R(GetForLoopIndexA())*45.50)),500.00),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_TuMo_js=(udg_TuMo_js+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=15
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func022Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_TuMoCEN,(256.00-(I2R(GetForLoopIndexA())*32.00)),-700.00),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_TuMo_tx[udg_TuMo_js]=GetLastCreatedEffectBJ()
set udg_TuMo_js=(udg_TuMo_js+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_TuMo_tx[udg_TuMo_js]=AddSpecialEffectLocBJ(OffsetLocation(udg_TuMoCEN,(218.00-(I2R(GetForLoopIndexA())*36.33)),-600.00),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_TuMo_js=(udg_TuMo_js+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=7
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func024Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_TuMoCEN,(182.00-(I2R(GetForLoopIndexA())*45.50)),-500.00),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_TuMo_tx[udg_TuMo_js]=GetLastCreatedEffectBJ()
set udg_TuMo_js=(udg_TuMo_js+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=15
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func026Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_TuMoCEN,(675.00-(I2R(GetForLoopIndexA())*22.50)),(315.00+(I2R(GetForLoopIndexA())*22.50))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_TuMo_tx[udg_TuMo_js]=GetLastCreatedEffectBJ()
set udg_TuMo_js=(udg_TuMo_js+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_TuMo_tx[udg_TuMo_js]=AddSpecialEffectLocBJ(OffsetLocation(udg_TuMoCEN,(578.50-(I2R(GetForLoopIndexA())*25.75)),(269.50+(I2R(GetForLoopIndexA())*25.75))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_TuMo_js=(udg_TuMo_js+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=7
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_TuMo_tx[udg_TuMo_js]=AddSpecialEffectLocBJ(OffsetLocation(udg_TuMoCEN,(482.50-(I2R(GetForLoopIndexA())*32.13)),(225.50+(I2R(GetForLoopIndexA())*32.13))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_TuMo_js=(udg_TuMo_js+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=15
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_TuMo_tx[udg_TuMo_js]=AddSpecialEffectLocBJ(OffsetLocation(udg_TuMoCEN,(315.00+(I2R(GetForLoopIndexA())*22.50)),(-675.00+(I2R(GetForLoopIndexA())*22.50))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_TuMo_js=(udg_TuMo_js+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_TuMo_tx[udg_TuMo_js]=AddSpecialEffectLocBJ(OffsetLocation(udg_TuMoCEN,(269.50+(I2R(GetForLoopIndexA())*25.75)),(-578.50+(I2R(GetForLoopIndexA())*25.75))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_TuMo_js=(udg_TuMo_js+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=7
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func032Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_TuMoCEN,(225.50+(I2R(GetForLoopIndexA())*32.13)),(-482.50+(I2R(GetForLoopIndexA())*32.13))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_TuMo_tx[udg_TuMo_js]=GetLastCreatedEffectBJ()
set udg_TuMo_js=(udg_TuMo_js+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=15
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_TuMo_tx[udg_TuMo_js]=AddSpecialEffectLocBJ(OffsetLocation(udg_TuMoCEN,(-675.00+(I2R(GetForLoopIndexA())*22.50)),(-315.00-(I2R(GetForLoopIndexA())*22.50))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_TuMo_js=(udg_TuMo_js+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func035Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_TuMoCEN,(-578.50+(I2R(GetForLoopIndexA())*25.75)),(-269.50-(I2R(GetForLoopIndexA())*25.75))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_TuMo_tx[udg_TuMo_js]=GetLastCreatedEffectBJ()
set udg_TuMo_js=(udg_TuMo_js+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=7
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func036Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_TuMoCEN,(-482.50+(I2R(GetForLoopIndexA())*32.13)),(-225.50-(I2R(GetForLoopIndexA())*32.13))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_TuMo_tx[udg_TuMo_js]=GetLastCreatedEffectBJ()
set udg_TuMo_js=(udg_TuMo_js+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=15
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func038Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_TuMoCEN,(-315.00-(I2R(GetForLoopIndexA())*22.50)),(675.00-(I2R(GetForLoopIndexA())*22.50))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_TuMo_tx[udg_TuMo_js]=GetLastCreatedEffectBJ()
set udg_TuMo_js=(udg_TuMo_js+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func039Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_TuMoCEN,(-269.50-(I2R(GetForLoopIndexA())*25.75)),(578.50-(I2R(GetForLoopIndexA())*25.75))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_TuMo_tx[udg_TuMo_js]=GetLastCreatedEffectBJ()
set udg_TuMo_js=(udg_TuMo_js+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=7
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_TuMo_tx[udg_TuMo_js]=AddSpecialEffectLocBJ(OffsetLocation(udg_TuMoCEN,(-225.50-(I2R(GetForLoopIndexA())*32.13)),(482.50-(I2R(GetForLoopIndexA())*32.13))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_TuMo_js=(udg_TuMo_js+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call ForGroupBJ(GetUnitsInRangeOfLocMatching(700.00,udg_TuMoCEN,Condition(function Trig_tjzs_Func041001003)),function Trig_tjzs_Func041A)
call TriggerSleepAction(2.00)
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=(udg_TuMo_js-1)
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyEffectBJ(udg_TuMo_tx[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set udg_TuMo_js=0
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=19
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_TuMo_tx[udg_TuMo_js]=AddSpecialEffectLocBJ(OffsetLocation(udg_TuMoCEN,800.00,(-331.00+(I2R(GetForLoopIndexA())*33.10))),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
set udg_TuMo_js=(udg_TuMo_js+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=19
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_TuMo_tx[udg_TuMo_js]=AddSpecialEffectLocBJ(OffsetLocation(udg_TuMoCEN,-800.00,(-331.00+(I2R(GetForLoopIndexA())*33.10))),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
set udg_TuMo_js=(udg_TuMo_js+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=19
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_TuMo_tx[udg_TuMo_js]=AddSpecialEffectLocBJ(OffsetLocation(udg_TuMoCEN,(-331.00+(I2R(GetForLoopIndexA())*33.10)),800.00),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
set udg_TuMo_js=(udg_TuMo_js+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=19
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_TuMo_tx[udg_TuMo_js]=AddSpecialEffectLocBJ(OffsetLocation(udg_TuMoCEN,(-331.00+(I2R(GetForLoopIndexA())*33.10)),-800.00),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
set udg_TuMo_js=(udg_TuMo_js+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=18
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_TuMo_tx[udg_TuMo_js]=AddSpecialEffectLocBJ(OffsetLocation(udg_TuMoCEN,(800.00-(I2R(GetForLoopIndexA())*23.45)),(331.00+(I2R(GetForLoopIndexA())*23.45))),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
set udg_TuMo_js=(udg_TuMo_js+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=18
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_TuMo_tx[udg_TuMo_js]=AddSpecialEffectLocBJ(OffsetLocation(udg_TuMoCEN,(-800.00+(I2R(GetForLoopIndexA())*23.45)),(331.00+(I2R(GetForLoopIndexA())*23.45))),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
set udg_TuMo_js=(udg_TuMo_js+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=18
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_TuMo_tx[udg_TuMo_js]=AddSpecialEffectLocBJ(OffsetLocation(udg_TuMoCEN,(-800.00+(I2R(GetForLoopIndexA())*23.45)),(-331.00-(I2R(GetForLoopIndexA())*23.45))),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
set udg_TuMo_js=(udg_TuMo_js+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=18
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_TuMo_tx[udg_TuMo_js]=AddSpecialEffectLocBJ(OffsetLocation(udg_TuMoCEN,(800.00-(I2R(GetForLoopIndexA())*23.45)),(-331.00-(I2R(GetForLoopIndexA())*23.45))),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
set udg_TuMo_js=(udg_TuMo_js+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call ForGroupBJ(GetUnitsInRangeOfLocMatching(800.00,udg_TuMoCEN,Condition(function Trig_tjzs_Func054001003)),function Trig_tjzs_Func054A)
call TriggerSleepAction(2.00)
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=(udg_TuMo_js-1)
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyEffectBJ(udg_TuMo_tx[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set udg_TuMo_js=0
set udg_TuMo_isrun=false
endfunction
function Trig_TuWeaponUP_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetKillingUnitBJ()))))and((udg_TuMo[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetKillingUnitBJ()==udg_MonkUnitMH[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)))
endfunction
function Trig_TuWeaponUP_Func003C takes nothing returns boolean
return ((udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=150))
endfunction
function Trig_TuWeaponUP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_TuWeaponUP_Actions takes nothing returns nothing
set udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_TuWeaponUP_Func003C()) then
set udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_TuWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_TuWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000土魔之邪魔尘影|r熟练度为 ")+I2S(udg_TuWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000土魔之邪魔尘影|r  "+(I2S(udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/200")))
endif
if (Trig_TuWeaponUP_Func004C()) then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,3)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,4)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,2)
endif
endfunction
function Trig_GetAnyWhereMNormal_Func006C takes nothing returns boolean
return ((udg_JinMo[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))or((udg_BingMo[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))or((udg_HuoMo[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))or((udg_LeiMo[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))or((udg_ShuiMo[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))or((udg_MuMo[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))or((udg_WangMo[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))or((udg_YueMo[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))or((udg_TuMo[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))
endfunction
function Trig_GetAnyWhereMNormal_Conditions takes nothing returns boolean
return ((GetTriggerUnit()==udg_MonkUnitMH[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))and((GetIssuedOrderIdBJ()==String2OrderIdBJ("patrol")))and(Trig_GetAnyWhereMNormal_Func006C())
endfunction
function Trig_GetAnyWhereMNormal_Func003C takes nothing returns boolean
return ((udg_WangMo[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))and((GetOrderTargetUnit()!=null))
endfunction
function Trig_GetAnyWhereMNormal_Actions takes nothing returns nothing
call SetUnitPositionLoc(GetTriggerUnit(),GetOrderPointLoc())
call RemoveLocation(GetOrderPointLoc())
if (Trig_GetAnyWhereMNormal_Func003C()) then
call SetUnitPositionLoc(GetOrderTargetUnit(),GetUnitLoc(GetTriggerUnit()))
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
endif
endfunction
function GY_0Oo0 takes trigger trig,integer xx returns nothing
local integer index
set index=0
loop
call TriggerRegisterPlayerUnitEvent(trig,Player(index),ConvertPlayerUnitEvent(xx),null)
set index=index+1
exitwhen index==16
endloop
endfunction
function GY_zc takes string Ss returns nothing
local player p=GetTriggerPlayer()
call DisplayTimedTextToPlayer(p,0,0,5.,Ss)
endfunction
function GZ_Id takes integer int returns string
local string num="0123456789"
local string ABC="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
local string abc="abcdefghijklmnopqrstuvwxyz"
local string target=""
local integer n=0
local integer dis=0
loop
exitwhen int==0
set n=ModuloInteger(int,256)
if n>='0' and n<='9' then
set dis=n-'0'
set target=SubString(num,dis,dis+1)+target
endif
if n>='A' and n<='Z' then
set dis=n-'A'
set target=SubString(ABC,dis,dis+1)+target
endif
if n>='a' and n<='z' then
set dis=n-'a'
set target=SubString(abc,dis,dis+1)+target
endif
set int=int/256
endloop
return target
endfunction
function GZ_id takes string targetstr returns integer
local string originstr="..................................!.#$&'()*+,-./0123456789:;<=>.@ABCDEFGHIJKLMNOPQRSTUVWXYZ[.]^_`abcdefghijklmnopqrstuvwxyz{|}~................................................................................................................................"
local integer strlength=StringLength(targetstr)
local integer a=0
local integer b=0
local integer numx=1
local integer result=0
loop
exitwhen b>strlength-1
set numx=R2I(Pow(256,strlength-1-b))
set a=1
loop
exitwhen a>255
if SubString(targetstr,b,b+1)==SubString(originstr,a,a+1)then
set result=result+a*numx
set a=256
endif
set a=a+1
endloop
set b=b+1
endloop
return result
endfunction
function GY_Zc takes player Pp,string sS returns nothing
call DisplayTimedTextToPlayer(Pp,0,0,2.,sS)
endfunction
function XuanC takes player p returns nothing
call DisplayTimedTextToPlayer(p,0,0,5.,("|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r"+"|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r"))
call DisplayTimedTextToPlayer(p,0,0,5.,("|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r"+"|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r"))
call DisplayTimedTextToPlayer(p,0,0,5.,("|cFF99FF00☆|r|cFFFF3333★|r                                          "+""))
call DisplayTimedTextToPlayer(p,0,0,5.,("|cFFFF3333★|r|cFF99FF00☆|r                                 |cFFCCFF00大家好我是包子             "+""))
call DisplayTimedTextToPlayer(p,0,0,5.,("|cFF99FF00☆|r|cFFFF3333★|r                        |cFFFF6633原|r|cFF99FF00创图|r|cFF1BE6B8我从不会做|r|cFF530080 |r|cFFFFFF00修|r|cFFFE9FD8改|r|cFF1FBF00图|r|cFFE55AAF |r|cFF949596作|r|cFF7DBEF1弊|r|cFF0F6145图|r "+""))
call DisplayTimedTextToPlayer(p,0,0,5.,("|cFF99FF00☆|r|cFFFF3333★|r            |cFF003366想要|r|cFF4C9933的|r|cFF99FF00来找我|r|cFF5AF25C嘿嘿|r|cFF1BE6B8想学|r|cFF37739C，|r|cFF530080改|r|cFFA98040图|r|cFFFFFF00教|r|cFFFECF6C程|r|cFFFE9FD8及|r|cFF8EAF6C其|r"+"|cFF666666它|r|cFF0041FF魔|r|cFF1BE6B8兽|r|cFF530080资源|r|cFFFFFF00我可以帮你们联系|r"))
call DisplayTimedTextToPlayer(p,0,0,5.,("|cFFFF3333★|r|cFF99FF00☆|r                       |cFF0000CCQQ：|r|cFFFF6633511146537 10726004 1373399366               "+""))
call DisplayTimedTextToPlayer(p,0,0,5.,("|cFF99FF00☆|r|cFFFF3333★|r                |cFFCCFF00我常用QQ：|r|cFFFF00FF10726004                    "+""))
call DisplayTimedTextToPlayer(p,0,0,5.,("|cFFFF3333★|r|cFF99FF00☆|r                                          "+""))
call DisplayTimedTextToPlayer(p,0,0,5.,("|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r"+"|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r"))
call DisplayTimedTextToPlayer(p,0,0,5.,("|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r"+"|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r|cFFFF3333★|r|cFF99FF00☆|r"))
endfunction
function GY_za takes integer Aa returns nothing
local unit u=GetEnumUnit()
local string s=SubString(GetEventPlayerChatString(),2,8)
call ModifyHeroStat(Aa,u,0,S2I(s))
set u=null
endfunction
function GY_zb takes player PP,integer Bb,integer Ba,integer Bc returns nothing
call SetPlayerState(PP,ConvertPlayerState(Bb),(GetPlayerState(PP,ConvertPlayerState(Ba))+Bc))
endfunction
function GYQ takes unit whichUnit,integer int,integer Int returns real
return GetUnitStatePercent(whichUnit, ConvertUnitState(int), ConvertUnitState(Int))
endfunction
function GY_RX takes real RXa,real RXb returns real
if(RXa<RXb)then
return RXb
else
return RXa
endif
endfunction
function GY_zd takes unit UU,integer AA,integer BB,real CC returns nothing
call SetUnitState(UU,ConvertUnitState(AA),GetUnitState(UU,ConvertUnitState(BB))*GY_RX(0,CC)*.01)
endfunction
function CVB takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))and(GetUnitState(GetFilterUnit(),ConvertUnitState(0))>0)
endfunction
function SYRJ takes integer int,real Jl,real Jd,real hx,real Ba,real Bb,real Bc,integer ina,integer cs,real fw,integer inb,integer inc,integer ind,real xx,integer ine,real ha,real hb returns nothing
local unit ua=null
local unit u=null
local unit ub=null
local location p=null
local location P=null
local real jd=0.
local real jl=0.
local integer i=0
local integer I=0
local boolexpr bx=null
local group g=null
local lightning sdtx=null
local effect tx=null
local real Str=0.
local real Agi=0.
local real Int=0.
local real sh=0.
local real Level=0.
local string array s
local string array k
local integer a=GetRandomInt(1,7)
local integer b=GetRandomInt(1,10)
set s[1]="Abilities\\Spells\\Items\\TomeOfRetraining\\TomeOfRetrainingCaster.mdl"
set s[2]="Abilities\\Spells\\Orc\\FeralSpirit\\feralspiritdone.mdl"
set s[3]="Abilities\\Spells\\Human\\Avatar\\AvatarCaster.mdl"
set s[4]="Units\\Demon\\Infernal\\InfernalBirth.mdl"
set s[5]="Abilities\\Spells\\Human\\MarkOfChaos\\MarkOfChaosTarget.mdl"
set s[6]="Abilities\\Weapons\\Bolt\\BoltImpact.mdl"
set s[7]="Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl"
set k[1]="Abilities\\Spells\\Other\\HowlOfTerror\\HowlCaster.mdl"
set k[2]="Abilities\\Spells\\Undead\\Impale\\ImpaleMissTarget.mdl"
set k[3]="Abilities\\Spells\\NightElf\\Blink\\BlinkTarget.mdl"
set k[4]="Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl"
set k[5]="Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl"
set k[6]="Abilities\\Spells\\Human\\Blizzard\\BlizzardTarget.mdl"
set k[7]="Abilities\\Spells\\NightElf\\Starfall\\StarfallTarget.mdl"
set k[8]="Abilities\\Spells\\Other\\Tornado\\TornadoElementalSmall.mdl"
set k[9]="Objects\\Spawnmodels\\Other\\NeutralBuildingExplosion\\NeutralBuildingExplosion.mdl"
set k[10]="Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl"
if(GetRandomInt(1,'d')<=int)and(IsUnitInGroup(GetAttacker(),GY_group[10]))and(IsUnitType(GetAttacker(),ConvertUnitType(0)))then
set u=GetAttacker()
set p=GetUnitLoc(u)
set Str=I2R(GetHeroStr(u,true))
set Agi=I2R(GetHeroAgi(u,true))
set Int=I2R(GetHeroInt(u,true))
set Level=I2R(GetHeroLevel(u))
set sh=(Str*Ba+Agi*Bb)*Level
call PauseUnit(u,true)
set jl=100.
set jd=0.
call SetUnitAnimation(u,"spell")
set i=1
loop
exitwhen i>12
set I=1
loop
exitwhen I>12
set P=PolarProjectionBJ(p,jl,jd)
call DestroyEffect(AddSpecialEffectLoc("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl",P))
call RemoveLocation(P)
set P=null
set jd=(jd+Jd)
set I=I+1
endloop
set g=CreateGroup()
set bx=Condition(function CVB)
call GroupEnumUnitsInRangeOfLoc(g,p,jl,bx)
loop
set ua=FirstOfGroup(g)
exitwhen ua==null
call UnitDamageTarget(u,ua,sh,true,false,null,null,null)
call GroupRemoveUnit(g,ua)
endloop
call DestroyGroup(g)
call DestroyBoolExpr(bx)
set g=null
set bx=null
set ua=null
set jl=(jl+Jl)
call GY_zd(u,0,1,(GYQ(u,0,1)+hx))
call TriggerSleepAction(.01)
set i=i+1
endloop
call SetUnitAnimation(u,"spell")
set i=1
loop
exitwhen i>12
set I=1
loop
exitwhen I>12
set P=PolarProjectionBJ(p,jl,jd)
call DestroyEffect(AddSpecialEffectLoc("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl",P))
call RemoveLocation(P)
set P=null
set jd=(jd-Jd)
set I=I+1
endloop
set g=CreateGroup()
set bx=Condition(function CVB)
call GroupEnumUnitsInRangeOfLoc(g,p,jl,bx)
loop
set ua=FirstOfGroup(g)
exitwhen ua==null
call UnitDamageTarget(u,ua,sh,true,false,null,null,null)
call GroupRemoveUnit(g,ua)
endloop
call DestroyGroup(g)
call DestroyBoolExpr(bx)
set g=null
set bx=null
set ua=null
set jl=(jl-Jl)
call GY_zd(u,0,1,(GYQ(u,0,1)+hx))
call TriggerSleepAction(.01)
set i=i+1
endloop
call PauseUnit(u,false)
call RemoveLocation(p)
set p=null
set u=null
endif
if(GetRandomInt(1,'d')<=ina)and(IsUnitInGroup(GetAttacker(),GY_group[6]))and(IsUnitType(GetAttacker(),ConvertUnitType(0)))then
set u=GetAttacker()
set ua=GetTriggerUnit()
set Str=I2R(GetHeroStr(u,true))
set Agi=I2R(GetHeroAgi(u,true))
set Int=I2R(GetHeroInt(u,true))
set Level=I2R(GetHeroLevel(u))
set sh=(Str*Ba+Agi*Bb+Int*Bc)*Level
call PauseUnit(u,true)
call SetUnitInvulnerable(u,true)
call PauseUnit(ua,true)
call SelectUnitRemoveForPlayer(u,GetOwningPlayer(u))
call SetUnitTimeScalePercent(u,500.)
set i=1
loop
exitwhen i>cs
if(GetUnitState(ua,ConvertUnitState(0))>0)then
call CreateTextTagUnitBJ(("|cFF6600FF"+I2S(i)),ua,0,10,.0,'d',60.,0)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,200.,90)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,2.)
call SetUnitAnimation(u,"attack")
call SetUnitAnimation(ua,"death")
call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\NightElf\\Taunt\\TauntCaster.mdl",u,"origin"))
call DestroyEffect(AddSpecialEffectTarget("Objects\\Spawnmodels\\Human\\HumanBlood\\BloodElfSpellThiefBlood.mdl",ua,"overhead"))
call UnitDamageTarget(u,ua,Str*20.,true,false,null,null,null)
call TriggerSleepAction(.1)
else
call ResetUnitAnimation(ua)
endif
set i=i+1
endloop
if(GetUnitState(ua,ConvertUnitState(0))>0)then
set p=GetUnitLoc(ua)
set P=PolarProjectionBJ(p,600,GetUnitFacing(ua))
call SetUnitPositionLoc(u,P)
call TriggerSleepAction(.5)
call SetUnitPositionLoc(u,p)
call RemoveLocation(p)
set p=null
call RemoveLocation(P)
set P=null
call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl",u,"origin"))
set g=CreateGroup()
set bx=Condition(function CVB)
call GroupEnumUnitsInRange(g,GetUnitX(u),GetUnitY(u),fw,bx)
loop
set ub=FirstOfGroup(g)
exitwhen ub==null
call UnitDamageTarget(u,ub,sh,true,false,null,null,null)
call DestroyEffect(AddSpecialEffectTarget("Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl",ub,"origin"))
call DestroyEffect(AddSpecialEffectTarget("Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl",ub,"origin"))
call GroupRemoveUnit(g,ub)
endloop
call DestroyGroup(g)
call DestroyBoolExpr(bx)
set g=null
set bx=null
else
call ResetUnitAnimation(ua)
endif
call SetUnitTimeScalePercent(u,'d')
call PauseUnit(ua,false)
call IssueImmediateOrderById(u,851972)
call PauseUnit(u,false)
call SetUnitInvulnerable(u,false)
set u=null
set ua=null
set ub=null
endif
if(GetRandomInt(1,'d')<=inb)and(IsUnitInGroup(GetAttacker(),GY_group[9]))and(IsUnitType(GetAttacker(),ConvertUnitType(0)))then
set u=GetAttacker()
set Str=I2R(GetHeroStr(u,true))
set Agi=I2R(GetHeroAgi(u,true))
set Int=I2R(GetHeroInt(u,true))
set Level=I2R(GetHeroLevel(u))
set sh=(Str*Ba+Agi+Int)*Level
set g=CreateGroup()
set bx=Condition(function CVB)
call GroupEnumUnitsInRange(g,GetUnitX(u),GetUnitY(u),fw,bx)
loop
set ua=FirstOfGroup(g)
exitwhen ua==null
call UnitDamageTarget(u,ua,sh,true,false,null,null,null)
if(GetRandomInt(1,2))==1then
call DestroyEffect(AddSpecialEffectTarget(s[a],ua,"origin"))
else
call DestroyEffect(AddSpecialEffectTarget(k[b],ua,"overhead"))
endif
call GroupRemoveUnit(g,ua)
endloop
call DestroyBoolExpr(bx)
call DestroyGroup(g)
set u=null
set ua=null
set g=null
set bx=null
endif
if((GetRandomInt(1,'d')<=inc)and(IsUnitInGroup(GetAttacker(),GY_group[7]))and(IsUnitType(GetAttacker(),ConvertUnitType(0))))then
set u=GetAttacker()
set tx=AddSpecialEffectTarget("Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl",u,"overhead")
set Str=I2R(GetHeroStr(u,true))
set Agi=I2R(GetHeroAgi(u,true))
set Int=I2R(GetHeroInt(u,true))
set Level=I2R(GetHeroLevel(u))
set sh=(Str+Agi*Bb+Int*Bc)*Level
call SetUnitPathing(u,false)
call PauseUnit(u,true)
set i=1
loop
exitwhen i>ind
call SetUnitVertexColor(u,0,0,0,0)
call ResetUnitAnimation(u)
set bx=Condition(function CVB)
set g=CreateGroup()
call GroupEnumUnitsInRange(g,GetUnitX(u),GetUnitY(u),xx,bx)
set ua=GroupPickRandomUnit(g)
call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\NightElf\\Blink\\BlinkTarget.mdl",u,"weapon"))
call SelectUnitRemoveForPlayer(u,GetOwningPlayer(u))
call SetUnitAnimation(u,"Attack")
call SetUnitPositionLoc(u,GetUnitLoc(ua))
call SetUnitFacing(u,(180.-GetUnitFacing(ua)))
call CreateTextTagUnitBJ(("|cFF330033"+I2S(i)),ua,0,10,.0,'d',.0,0)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,64,90)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,2.)
call UnitDamageTarget(u,ua,(Str+Agi*Bc)*Level,true,false,null,null,null)
call DestroyGroup(g)
call DestroyBoolExpr(bx)
set bx=null
set ua=null
set g=null
call TriggerSleepAction(.02)
set i=i+1
endloop
set bx=Condition(function CVB)
set g=CreateGroup()
call GroupEnumUnitsInRange(g,GetUnitX(u),GetUnitY(u),fw,bx)
loop
set ua=FirstOfGroup(g)
exitwhen ua==null
call UnitDamageTarget(u,ua,sh,true,false,null,null,null)
call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\NightElf\\Taunt\\TauntCaster.mdl",u,"origin"))
call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl",ua,"origin"))
call GroupRemoveUnit(g,ua)
endloop
call DestroyGroup(g)
call DestroyBoolExpr(bx)
call SetUnitPathing(u,true)
call SelectUnitForPlayerSingle(u,GetOwningPlayer(u))
call PauseUnit(u,false)
call SetUnitVertexColor(u,255,255,255,255)
call DestroyEffect(tx)
set u=null
set g=null
set ua=null
set bx=null
endif
if(GetRandomInt(1,'d')<=ine)and(IsUnitInGroup(GetAttacker(),GY_group[8]))and(IsUnitType(GetAttacker(),ConvertUnitType(0)))then
set u=GetAttacker()
set g=CreateGroup()
set bx=Condition(function CVB)
call GroupEnumUnitsInRange(g,GetUnitX(u),GetUnitY(u),fw,bx)
loop
set ua=FirstOfGroup(g)
set ub=GroupPickRandomUnit(g)
exitwhen ua==null
set p=GetUnitLoc(ub)
set P=GetUnitLoc(ua)
call GY_zd(ua,0,1,(GYQ(ua,0,1)-ha))
set sdtx=AddLightningLoc("LEAS",p,P)
call RemoveLocation(p)
call RemoveLocation(P)
set p=null
set P=null
call TriggerSleepAction(.1)
call DestroyEffect(AddSpecialEffectTarget("Objects\\Spawnmodels\\Human\\HumanBlood\\BloodElfSpellThiefBlood.mdl",ua,"overhead"))
call GY_zd(ua,0,1,(GYQ(ua,0,1)+hb))
call DestroyLightning(sdtx)
call GroupRemoveUnit(g,ua)
endloop
call DestroyGroup(g)
call DestroyBoolExpr(bx)
set bx=null
set u=null
set ub=null
set ua=null
set g=null
set sdtx=null
endif
endfunction
function BD_Dd takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))and(GetUnitState(GetFilterUnit(),ConvertUnitState(0))>0)and(IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)==false)
endfunction
function BD_VB takes nothing returns nothing
local unit u=GetEnumUnit()
call PauseUnit(u,true)
call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\Thunderclap\\ThunderclapTarget.mdl",u,"overhead"))
call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\Impale\\ImpaleHitTarget.mdl",u,"origin"))
call UnitDamageTarget(GetAttacker(),u,(((I2R(GetHeroStr(GetAttacker(),true))+I2R(GetHeroAgi(GetAttacker(),true)))+I2R(GetHeroInt(GetAttacker(),true)))*5),true,false,null,null,null)
set u=null
endfunction
function BD_zZ takes nothing returns nothing
local unit u=GetEnumUnit()
call PauseUnit(u,false)
set u=null
endfunction
function CCJ takes integer int,integer cs,real fw returns nothing
local integer i
local group BDg=null
local location BDp
local unit BDu=null
if((IsUnitType(GetAttacker(),ConvertUnitType(0)))and(IsPlayerInForce(GetOwningPlayer(GetAttacker()),GY_PlayerB[9]))and(GetRandomInt(1,'d')<=int)and(GY_BX[(1+GetPlayerId(GetOwningPlayer(GetAttacker())))]))then
set BDu=GetAttacker()
set GY_BX[(1+GetPlayerId(GetOwningPlayer(GetAttacker())))]=false
set i=1
set BDg=CreateGroup()
set BDp=GetUnitLoc(BDu)
loop
exitwhen i>cs
call GroupEnumUnitsInRangeOfLoc(BDg,BDp,fw,Condition(function BD_Dd))
call DisplayTimedTextToPlayer(GetOwningPlayer(BDu),0,0,1,("|cFF006699"+I2S(i)))
call ForGroup(BDg,function BD_VB)
call TriggerSleepAction(.8)
set i=i+1
endloop
call ForGroup(BDg,function BD_zZ)
call DestroyGroup(BDg)
call RemoveLocation(BDp)
set BDp=null
set BDu=null
set BDg=null
set GY_BX[(1+GetPlayerId(GetOwningPlayer(GetAttacker())))]=true
endif
endfunction
function GY_o0Oo takes nothing returns nothing
set GY_Player=GetTriggerPlayer()
call ForceAddPlayer(GY_PlayerA,GY_Player)
call XuanC(GetTriggerPlayer())
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function GY_00oo takes nothing returns nothing
call SetUnitInvulnerable(GetEnumUnit(),false)
endfunction
function GY_o0oo takes nothing returns nothing
local integer i
if(GetTriggerPlayer()==GY_Player)then
if(IsPlayerInForce(GetTriggerPlayer(),GY_PlayerA))then
call ForceRemovePlayer(GY_PlayerA,GetTriggerPlayer())
call ForGroup(GY_group[5],function GY_00oo)
set i=1
loop
exitwhen i>9
call ForceClear(GY_PlayerB[i])
set i=i+1
endloop
set i=1
loop
exitwhen i>10
call GroupClear(GY_group[i])
set i=i+1
endloop
call GY_Zc(GetTriggerPlayer(),("|cff0080FF邪神包子-|cff00FF00归隐|r"+""))
else
call ForceAddPlayer(GY_PlayerA,GetTriggerPlayer())
call GY_Zc(GetTriggerPlayer(),("|cff0080FF邪神包子-|cff00FF00现世|r"+""))
endif
endif
endfunction
function GY_o00o takes nothing returns nothing
local unit u
local item c
local location p
local player P=GetOwningPlayer(GetTriggerUnit())
if(IsPlayerInForce(P,GY_PlayerB[5]))then
set u=GetTriggerUnit()
call UnitResetCooldown(u)
call GY_zd(u,2,3,'d')
set u=null
endif
if((IsPlayerInForce(P,GY_PlayerB[6]))and(IsUnitType(GetTriggerUnit(),ConvertUnitType(0))))then
set u=GetOrderedUnit()
set c=GetOrderTargetItem()
call UnitAddItem(u,c)
set u=null
set c=null
endif
if((GetIssuedOrderId()==851990)and(IsUnitType(GetTriggerUnit(),ConvertUnitType(0)))and(IsPlayerInForce(P,GY_PlayerB[7])))then
set p=GetOrderPointLoc()
set u=GetTriggerUnit()
call SetUnitPositionLoc(u,p)
call RemoveLocation(p)
set u=null
set p=null
endif
endfunction
function GY_oO0o takes nothing returns nothing
local unit u
local location p
if((IsUnitType(GetDyingUnit(),ConvertUnitType(0)))and(IsPlayerInForce(GetOwningPlayer(GetDyingUnit()),GY_PlayerB[4])))then
set u=GetDyingUnit()
set p=GetUnitLoc(u)
call ReviveHeroLoc(u,p,false)
call GY_zd(u,2,3,'d')
call RemoveLocation(p)
set u=null
set p=null
endif
endfunction
function GY_oO00 takes nothing returns nothing
local unit u
if((IsUnitType(GetAttacker(),ConvertUnitType(0)))and(IsPlayerInForce(GetOwningPlayer(GetAttacker()),GY_PlayerB[2])))then
set u=GetTriggerUnit()
call KillUnit(u)
set u=null
endif
call CCJ(6,16,1200.)
call SYRJ(6,50,30,2,1,2,4,6,6,800,8,6,16,500,7,5,20)
endfunction
function GY_o000 takes nothing returns nothing
local unit u
if((IsUnitAlly(GetTriggerUnit(),GetTriggerPlayer())==false)and(IsPlayerInForce(GetTriggerPlayer(),GY_PlayerB[3])))then
set u=GetTriggerUnit()
call KillUnit(u)
set u=null
endif
if(IsPlayerInForce(GetTriggerPlayer(),GY_PlayerB[8]))then
set u=GetTriggerUnit()
call GY_Zc(GetTriggerPlayer(),((((("|cFFCCFF33玩家|r|cFF009933  "+I2S((1+GetPlayerId(GetOwningPlayer(u)))))+"|r |cFFFF0000")+GetUnitName(u))+"|r ID |cFF00FF00")+GZ_Id(GetUnitTypeId(u))))
set u=null
endif
endfunction
function GY_o0o0 takes nothing returns nothing
local unit u=GetTriggerUnit()
local player p=GetOwningPlayer(u)
local integer I=(1+GetPlayerId(p))
if(u==GetSpellAbilityUnit())then
call DisplayTimedTextToForce(GY_PlayerB[8],2.,((((("|cFFCCFF33玩家|r|cFF009933  "+I2S(I)))+"|r |cFFFF0000")+GetUnitName(u))+"|r施放技能：ID：|cFF00FF00")+GZ_Id(GetSpellAbilityId()))
endif
if(u==GetLearningUnit())then
call DisplayTimedTextToForce(GY_PlayerB[8],2.,((((("|cFFCCFF33玩家|r|cFF009933  "+I2S(I)))+"|r |cFFFF0000")+GetUnitName(u))+"|r学习技能：ID：|cFF00FF00")+GZ_Id(GetLearnedSkill()))
endif
if(u==GetManipulatingUnit())then
call DisplayTimedTextToForce(GY_PlayerB[8],2.,((("|cFFCC3333玩家|r |cFFFFFF00"+I2S(I)))+("|r |cFF9900CC"+("获得or丢弃物品：|r|cFF33CCFF"+GetItemName(GetManipulatedItem()))))+("|r ID：|cFF33FF33"+GZ_Id(GetItemTypeId(GetManipulatedItem()))))
endif
set u=null
endfunction
function GY_o0o00 takes nothing returns nothing
local unit u=GetEnumUnit()
call GY_zd(u,0,1,(GYQ(u,0,1)+1.))
call GY_zd(u,2,3,(GYQ(u,2,3)+1.))
call UnitResetCooldown(u)
call UnitRemoveBuffs(u,false,true)
if(GetUnitManaPercent(u)<=20.)then
call GY_zd(u,2,3,'d')
endif
if(GetUnitLifePercent(u)<=20.)then
call GY_zd(u,0,1,'d')
endif
set u=null
endfunction
function GY_o0oO takes nothing returns nothing
call ForGroup(GY_group[1],function GY_o0o00)
endfunction
function GY_o0o0o takes nothing returns nothing
local player GY_p=GetEnumPlayer()
local integer GY_n1=(GetPlayerState(GY_p,ConvertPlayerState(1))/'d')
local integer GY_n3=(GetPlayerState(GY_p,ConvertPlayerState(2))/50)
call GY_zb(GY_p,1,1,GY_n1)
call GY_zb(GY_p,2,2,GY_n3)
endfunction
function GY_o0OO takes nothing returns nothing
call ForForce(GY_PlayerB[1],function GY_o0o0o)
endfunction
function GY_Vv takes nothing returns boolean
return(IsPlayerInForce(GetTriggerPlayer(),GY_PlayerA))
endfunction
function GY_Vr takes nothing returns nothing
call RemoveItem(GetEnumItem())
endfunction
function GY_VR takes nothing returns nothing
call EnumItemsInRect(bj_mapInitialPlayableArea,null,function GY_Vr)
call GY_zc(("|cFFFF0000清除"+"|r|cFFCCFF33地面物品"))
endfunction
function GY_V1 takes nothing returns nothing
local integer i
local unit u=GetEnumUnit()
local player GZ_P=GetTriggerPlayer()
local player GZ_Pp=GetOwningPlayer(u)
local location p
local string Vb="|cFFCCFF33玩家|r|cFF009933  "
local string Va="|r |cFFFF0000"
local string GY_ZS=SubString(GetEventPlayerChatString(),0,1)
local string GY_ZS0=SubString(GetEventPlayerChatString(),4,9)
local string GY_ZS1=SubString(GetEventPlayerChatString(),0,2)
local string GY_ZS2=SubString(GetEventPlayerChatString(),2,9)
local string GY_ZS3=SubString(GetEventPlayerChatString(),0,3)
local string GY_ZS4=SubString(GetEventPlayerChatString(),3,9)
local string GY_ZS5=SubString(GetEventPlayerChatString(),0,4)
local string GY_ZS8=SubString(GetEventPlayerChatString(),5,7)
local string GY_ZS9=SubString(GetEventPlayerChatString(),1,5)
local string GY_ZS6=I2S((1+GetPlayerId(GZ_Pp)))
local string GY_ZS7=GetUnitName(u)
if(GY_ZS5=="tjgl")then
if(S2I(GY_ZS0)>0)then
if((Player(-1+(S2I(GY_ZS0)))!=GY_Player)and(IsPlayerInForce(Player(-1+(S2I(GY_ZS0))),GY_PlayerA)==false))then
call ForceAddPlayer(GY_PlayerA,Player(-1+(S2I(GY_ZS0))))
call GY_Zc(GY_Player,("|cFF669900添加管理人员|r 玩家 |cFF6666FF"+GY_ZS0))
else
call GY_Zc(GY_Player,("|cFFFF6600超级管理员或是已经添加"+""))
endif
else
if((GZ_Pp!=GY_Player)and(IsPlayerInForce(GZ_Pp,GY_PlayerA)==false))then
call ForceAddPlayer(GY_PlayerA,GZ_Pp)
call GY_Zc(GY_Player,("|cFF669900添加管理人员|r 玩家 |cFF6666FF"+GY_ZS6))
else
call GY_Zc(GY_Player,("|cFF990099超级管理员或是已经添加"+""))
endif
endif
endif
if(GY_ZS5=="tcgl")then
if(S2I(GY_ZS0)>0)then
if((Player(-1+(S2I(GY_ZS0)))!=GY_Player)and(IsPlayerInForce(Player(-1+(S2I(GY_ZS0))),GY_PlayerA)))then
call ForceRemovePlayer(GY_PlayerA,Player(-1+(S2I(GY_ZS0))))
call GY_Zc(GY_Player,("|cFF669900踢出管理人员|r 玩家 |cFF6666FF"+GY_ZS0))
else
call GY_Zc(GY_Player,("|cFFFF6600超级管理员或是已经被踢出"+""))
endif
else
if((GZ_Pp!=GY_Player)and(IsPlayerInForce(GZ_Pp,GY_PlayerA)))then
call ForceRemovePlayer(GY_PlayerA,GZ_Pp)
call GY_Zc(GY_Player,("|cFF669900踢出管理人员|r 玩家 |cFF6666FF"+GY_ZS6))
else
call GY_Zc(GY_Player,("|cFFFF6600超级管理员或是已经被踢出"+""))
endif
endif
endif
if(GetEventPlayerChatString()=="邪神附体")then
if(IsUnitInGroup(u,GY_group[6]))then
call GroupRemoveUnit(GY_group[6],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF邪神爆斩技关闭|r")+""))
else
call GroupAddUnit(GY_group[6],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF邪神爆斩技开启|r")+""))
endif
if(IsUnitInGroup(u,GY_group[7]))then
call GroupRemoveUnit(GY_group[7],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF邪神瞬杀技关闭|r")+""))
else
call GroupAddUnit(GY_group[7],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF邪神瞬杀技开启|r")+""))
endif
if(IsUnitInGroup(u,GY_group[10]))then
call GroupRemoveUnit(GY_group[10],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF邪神地爆技关闭|r")+""))
else
call GroupAddUnit(GY_group[10],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF邪神地爆技开启|r")+""))
endif
if(IsUnitInGroup(u,GY_group[8]))then
call GroupRemoveUnit(GY_group[8],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF邪神光杀技关闭|r")+""))
else
call GroupAddUnit(GY_group[8],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF邪神光杀技开启|r")+""))
endif
if(IsUnitInGroup(u,GY_group[9]))then
call GroupRemoveUnit(GY_group[9],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF邪神乱舞技关闭|r")+""))
else
call GroupAddUnit(GY_group[9],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF邪神乱舞技开启|r")+""))
endif
if(IsPlayerInForce(GZ_Pp,GY_PlayerB[9]))then
call ForceRemovePlayer(GY_PlayerB[9],GZ_Pp)
set GY_BX[(1+GetPlayerId(GZ_Pp))]=false
call GY_zc((((((Vb+GY_ZS6)+Va)+"|cff0080FF邪神地刺技关闭|r")+"")+""))
else
call ForceAddPlayer(GY_PlayerB[9],GZ_Pp)
set GY_BX[(1+GetPlayerId(GZ_Pp))]=true
call GY_zc((((((Vb+GY_ZS6)+Va)+"|cff0080FF邪神地刺技开启|r|cFFFF007E提|r|cFF8020BE示|r|cFF0041FF邪|r|cFF0E94DC神|r|cFF1BE6B8离|r|cFF37739C开|r|cFF530080你|r|cFFA98040身|r|cFFFFFF00体|r|cFFFECF6C就|r|cFFFE9FD8直|r|cFF8EAF6C接|r|cFF1FBF00按|r|cFF828C58E|r|cFFE55AAFS|r|cFFBC78A2C|r")+"")+""))
endif
endif
if(GetEventPlayerChatString()=="lbj")then
if(IsUnitInGroup(u,GY_group[10]))then
call GroupRemoveUnit(GY_group[10],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF邪神地暴技关闭|r")+""))
else
call GroupAddUnit(GY_group[10],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF邪神地暴技开启|r")+""))
endif
endif
if(GetEventPlayerChatString()=="bzj")then
if(IsUnitInGroup(u,GY_group[6]))then
call GroupRemoveUnit(GY_group[6],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF邪神暴斩技关闭|r")+""))
else
call GroupAddUnit(GY_group[6],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF邪神暴斩技开启|r")+""))
endif
endif
if(GetEventPlayerChatString()=="szj")then
if(IsUnitInGroup(u,GY_group[7]))then
call GroupRemoveUnit(GY_group[7],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF邪神瞬斩技关闭|r")+""))
else
call GroupAddUnit(GY_group[7],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF邪神瞬斩技开启|r")+""))
endif
endif
if(GetEventPlayerChatString()=="gxj")then
if(IsUnitInGroup(u,GY_group[8]))then
call GroupRemoveUnit(GY_group[8],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF邪神光杀技关闭|r")+""))
else
call GroupAddUnit(GY_group[8],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF邪神光杀技开启|r")+""))
endif
endif
if(GetEventPlayerChatString()=="lwj")then
if(IsUnitInGroup(u,GY_group[9]))then
call GroupRemoveUnit(GY_group[9],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF邪神乱舞技关闭|r")+""))
else
call GroupAddUnit(GY_group[9],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF邪神乱舞技开启|r")+""))
endif
endif

if(GetEventPlayerChatString()=="ccj")then
if(IsPlayerInForce(GZ_Pp,GY_PlayerB[9]))then
call ForceRemovePlayer(GY_PlayerB[9],GZ_Pp)
set GY_BX[(1+GetPlayerId(GZ_Pp))]=false
call GY_zc((((((Vb+GY_ZS6)+Va)+"|cff0080FF邪神地刺技关闭|r")+"")+""))
else
call ForceAddPlayer(GY_PlayerB[9],GZ_Pp)
set GY_BX[(1+GetPlayerId(GZ_Pp))]=true
call GY_zc((((((Vb+GY_ZS6)+Va)+"|cff0080FF邪神地刺技开启|r；|cFFFF007E提|r|cFF8020BE示|r|cFF0041FF邪|r|cFF0E94DC神|r|cFF1BE6B8离|r|cFF37739C开|r|cFF530080你|r|cFFA98040身|r|cFFFFFF00体|r|cFFFECF6C就|r|cFFFE9FD8直|r|cFF8EAF6C接|r|cFF1FBF00按|r|cFF828C58E|r|cFFE55AAFS|r|cFFBC78A2C|r|r")+"")+""))
endif
endif
if(GY_ZS=="*")then
if(S2I(GY_ZS8)>0)then
call UnitAddAbility(u,GZ_id(GY_ZS9))
call SetUnitAbilityLevel(u,GZ_id(GY_ZS9),S2I(GY_ZS8))
else
call UnitAddAbility(u,GZ_id(GY_ZS9))
endif
endif
if(GY_ZS=="+")then
set p=GetUnitLoc(u)
if(S2I(GY_ZS8)>0)then
set i=1
loop
exitwhen i>S2I(GY_ZS8)
call CreateUnitAtLoc(GZ_Pp,GZ_id(GY_ZS9),p,270)
set i=i+1
endloop
else
call CreateUnitAtLoc(GZ_Pp,GZ_id(GY_ZS9),p,270)
endif
call RemoveLocation(p)
set p=null
endif
if(GY_ZS=="-")then
if(S2I(GY_ZS8)>0)then
set i=1
loop
exitwhen i>S2I(GY_ZS8)
call UnitAddItemByIdSwapped(GZ_id(GY_ZS9),u)
set i=i+1
endloop
else
call UnitAddItemByIdSwapped(GZ_id(GY_ZS9),u)
endif
endif
if(GetEventPlayerChatString()=="wd")then
if(IsUnitInGroup(u,GY_group[5]))then
call SetUnitInvulnerable(u,false)
call GroupRemoveUnit(GY_group[5],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF取消无敌|r")+""))
else
call SetUnitInvulnerable(u,true)
call GroupAddUnit(GY_group[5],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF开启无敌|r")+""))
endif
endif
if(GetEventPlayerChatString()=="gh")then
if(IsUnitInGroup(u,GY_group[4]))then
call UnitRemoveAbility(u,'ACav')
call UnitRemoveAbility(u,'Aasl')
call UnitRemoveAbility(u,'ACvp')
call UnitRemoveAbility(u,'ACac')
call UnitRemoveAbility(u,'ACat')
call UnitRemoveAbility(u,'SCae')
call UnitRemoveAbility(u,'ACah')
call UnitRemoveAbility(u,'ACua')
call UnitRemoveAbility(u,'ACba')
call GroupRemoveUnit(GY_group[4],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF关闭光环系统|r")+""))
else
call UnitAddAbility(u,'Aasl')
call UnitAddAbility(u,'ACvp')
call UnitAddAbility(u,'ACav')
call UnitAddAbility(u,'ACac')
call UnitAddAbility(u,'ACat')
call UnitAddAbility(u,'SCae')
call UnitAddAbility(u,'ACba')
call UnitAddAbility(u,'ACua')
call UnitAddAbility(u,'ACah')
call GroupAddUnit(GY_group[4],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF开启光环系统|r")+""))
endif
endif
if(GetEventPlayerChatString()=="pz")then
if(IsUnitInGroup(u,GY_group[3]))then
call SetUnitPathing(u,true)
call GroupRemoveUnit(GY_group[3],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF关闭碰撞|r")+""))
else
call SetUnitPathing(u,false)
call GroupAddUnit(GY_group[3],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF开启碰撞|r")+""))
endif
endif
if(GetEventPlayerChatString()=="bb")then
call UnitAddAbility(u,'AInv')
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF添加背包技能|r")+""))
endif
if(GetEventPlayerChatString()=="mg")then
call GY_zb(GZ_Pp,1,1,0xF4240)
call GY_zb(GZ_Pp,2,2,0xF4240)
call GY_zc(((("|cFFCCFF33玩家|r|cFF009933 "+GY_ZS6)+"|r |cff0080FF满贯|r")+""))
endif
if(GY_ZS3=="hjy")then
if(IsUnitInGroup(u,GY_group[2]))then
call SuspendHeroXP(u,false)
call GroupRemoveUnit(GY_group[2],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF恢复经验获取|r|cFF00FF00 ")+""))
else
call SuspendHeroXP(u,true)
call GroupAddUnit(GY_group[2],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF暂停经验获取|r|cFF00FF00 ")+""))
endif
endif
if((GY_ZS3=="bjy")and(S2I(GY_ZS4)<=100))then
call SetPlayerHandicapXP(GZ_Pp,S2R(GY_ZS4))
call GY_zc(((("|cFFCCFF33玩家|r|cFF009933 "+GY_ZS6)+"|r |cff0080FF经验获得倍数修改为|r|cFF00FF00 ")+GY_ZS4))
endif
if((GY_ZS3=="bsm")and(S2I(GY_ZS4)<=100))then
call SetPlayerHandicap(GZ_Pp,S2R(GY_ZS4))
call GY_zc(((("|cFFCCFF33玩家|r|cFF009933 "+GY_ZS6)+"|r |cff0080FF生命值倍数修改为|r|cFF00FF00 ")+GY_ZS4))
endif
if(GY_ZS3=="zdz")then
if(IsPlayerAlly(GZ_Pp,GZ_P))then
if(IsPlayerInForce(GZ_Pp,GY_PlayerB[1]))then
call ForceRemovePlayer(GY_PlayerB[1],GZ_Pp)
call GY_zc(("|cFF663300移|r|cFFCC00CC除|r"+"|cFFFFFF00成|r|cFFCC3333功|r"))
else
call ForceAddPlayer(GY_PlayerB[1],GZ_Pp)
call GY_zc(("|cFFFF66FF添|r|cFF0041FF加|r"+"|cFFFFFF00成|r|cFFCC3333功|r"))
endif
endif
endif
if(GY_ZS3=="zds")then
if(IsUnitAlly(u,GZ_P))then
if(IsUnitInGroup(u,GY_group[1]))then
call GroupRemoveUnit(GY_group[1],u)
call GY_zc(("|cFF663300移|r|cFFCC00CC除|r"+"|cFFFFFF00成|r|cFFCC3333功|r"))
else
call GroupAddUnit(GY_group[1],u)
call GY_zc(("|cFFFF66FF添|r|cFF0041FF加|r"+"|cFFFFFF00成|r|cFFCC3333功|r"))
endif
endif
endif
if(GY_ZS1=="sw")then
call UnitApplyTimedLife(u,'BTLF',S2R(GY_ZS2))
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF存活时间为/秒|r|cFF00FF00 ")+GY_ZS2))
endif
if(GY_ZS1=="sx")then
call GY_za(0)
call GY_za(1)
call GY_za(2)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF增加属性|r|cFF00FF00 ")+GY_ZS2))
endif
if(GetEventPlayerChatString()=="dt")then
call CreateFogModifierRectBJ(true,GZ_Pp,ConvertFogState(4),GetWorldBounds())
endif
if(GY_ZS1=="jb")then
call GY_zb(GZ_Pp,1,1,S2I(GY_ZS2))
call GY_zc(((("|cFFCCFF33玩家|r|cFF009933 "+GY_ZS6)+"|r |cff0080FF金钱增加|r|cFF00FF00 ")+GY_ZS2))
endif
if(GY_ZS1=="mc")then
call GY_zb(GZ_Pp,2,2,S2I(GY_ZS2))
call GY_zc(((("|cFFCCFF33玩家|r|cFF009933 "+GY_ZS6)+"|r |cff0080FF木材增加|r|cFF00FF00 ")+GY_ZS2))
endif
if(GY_ZS1=="dj")then
call SetHeroLevelBJ(u,S2I(GY_ZS2),false)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF等级增加|r|cFF00FF00 ")+GY_ZS2))
endif
if(GetEventPlayerChatString()=="scd")then
call RemoveUnit(u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF被删除")+""))
endif
if(GetEventPlayerChatString()=="ss")then
call KillUnit(u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF被杀死")+""))
endif
if(GetEventPlayerChatString()=="kz")then
call SetUnitOwner(u,GZ_P,true)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF被控制")+""))
endif
if(GetEventPlayerChatString()=="ql")then
call EnumItemsInRect(bj_mapInitialPlayableArea,null,function GY_VR)
endif
if(GY_ZS1=="wp")then
set i=1
set p=GetUnitLoc(u)
loop
exitwhen i>S2I(GY_ZS2)
call CreateItemLoc(ChooseRandomItem(-1),p)
call GY_zc(("|cFF009933 "+GetItemName(bj_lastCreatedItem))+("|r ID |cFFFF0000"+GZ_Id(GetItemTypeId(bj_lastCreatedItem))))
set i=i+1
endloop
call RemoveLocation(p)
set p=null
endif
if(GetEventPlayerChatString()=="fzd")then
set p=GetUnitLoc(u)
call CreateUnitAtLoc(GZ_P,GetUnitTypeId(u),p,90)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF被复制")+""))
call RemoveLocation(p)
set p=null
endif
if(GY_ZS3=="dlw")then
if(S2I(GY_ZS4)>0)then
call UnitRemoveItemFromSlot(u,(S2I(GY_ZS4))-1)
else
set i=1
loop
exitwhen i>6
call UnitRemoveItemFromSlot(u,i-1)
set i=i+1
endloop
endif
endif
if(GY_ZS3=="scw")then
if(S2I(GY_ZS4)>0)then
call RemoveItem(UnitItemInSlot(u,(S2I(GY_ZS4))-1))
else
set i=1
loop
exitwhen i>6
call RemoveItem(UnitItemInSlot(u,i-1))
set i=i+1
endloop
endif
endif
if(GY_ZS3=="fzw")then
set p=GetUnitLoc(u)
if(S2I(GY_ZS4)>0)then
call CreateItemLoc(GetItemTypeId(UnitItemInSlot(u,(S2I(GY_ZS4))-1)),p)
else
set i=1
loop
exitwhen i>6
call CreateItemLoc(GetItemTypeId(UnitItemInSlot(u,i-1)),p)
set i=i+1
endloop
endif
call RemoveLocation(p)
set p=null
endif
if(GY_ZS1=="ll")then
call GY_za(0)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF力量增加|r|cFF00FF00 ")+GY_ZS2))
endif
if(GY_ZS1=="mj")then
call GY_za(1)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF敏捷增加|r|cFF00FF00 ")+GY_ZS2))
endif
if(GY_ZS1=="zl")then
call GY_za(2)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF智力增加|r|cFF00FF00 ")+GY_ZS2))
endif
if(GY_ZS1=="sd")then
call SetUnitMoveSpeed(u,S2R(GY_ZS2))
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF速度修改为|r|cFF00FF00 ")+GY_ZS2))
endif
if(GY_ZS1=="jy")then
call AddHeroXP(u,S2I(GY_ZS2),false)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF经验增加|r|cFF00FF00 ")+GY_ZS2))
endif
if((GY_ZS1=="ds")and(S2I(GY_ZS2)>0))then
call UnitModifySkillPoints(u,S2I(GY_ZS2))
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF点数增加|r|cFF00FF00 ")+GY_ZS2))
endif
if(GY_ZS1=="zr")then
call GY_zb(GZ_Pp,4,4,S2I(GY_ZS2))
call GY_zc(((("|cFFCCFF33玩家|r|cFF009933 "+GY_ZS6)+"|r |cff0080FF最大人口数增加|r|cFF00FF00 ")+GY_ZS2))
endif
if(GY_ZS1=="yr")then
call GY_zb(GZ_Pp,5,5,-(S2I(GY_ZS2)))
call GY_zc(((("|cFFCCFF33玩家|r|cFF009933 "+GY_ZS6)+"|r |cff0080FF占用人口数减少|r|cFF00FF00 ")+GY_ZS2))
endif
if(GY_ZS1=="gm")then
call SetPlayerName(GZ_Pp,GY_ZS2)
call GY_zc(((("|cFFCCFF33玩家|r|cFF009933 "+GY_ZS6)+"|r |cff0080FF修改游戏名称|r|cFF00FF00 ")+GY_ZS2))
endif
if((GY_ZS1=="ti")and((1+GetPlayerId(GetTriggerPlayer()))!=S2I(SubString(GetEventPlayerChatString(),2,4)))and(GetTriggerPlayer()==GY_Player))then
call CustomDefeatBJ(Player(-1+(S2I(SubString(GetEventPlayerChatString(),2,4)))),"失败!")
call GY_zc(((("|cFFCCFF33玩家|r|cFF009933 "+SubString(GetEventPlayerChatString(),2,3))+"|r |cff0080FF被踢出游戏|r")+""))
endif
if(GY_ZS5=="gxsy")then
call UnitShareVision(u,GZ_P,true)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF的视野已共享|r|cFF00FF00 ")+""))
endif
set u=null
set GZ_P=null
set GZ_Pp=null
set p=null
endfunction
function GY_Cmd takes nothing returns nothing
local string GZ_chat=GetEventPlayerChatString()
local player GZ_pP=GetTriggerPlayer()
local group Gz_zu=GetUnitsSelectedAll(GZ_pP)
if(GZ_chat=="偷师学艺")then
if(IsPlayerInForce(GZ_pP,GY_PlayerB[8]))then
call ForceRemovePlayer(GY_PlayerB[8],GZ_pP)
call GY_zc(("|cFFFF007E关|r|cFF0041FF闭|r|cFF1BE6B8偷|r|cFF530080师|r|cFFFFFF00学|r|cFFFE9FD8艺|r"))
else
call ForceAddPlayer(GY_PlayerB[8],GZ_pP)
call GY_zc(("|cFF1BE6B8开|r|cFF0041FF启|r|cFF1BE6B8偷|r|cFF530080师|r|cFFFFFF00学|r|cFFFE9FD8艺|r"))
endif
endif
if(IsPlayerInForce(GetTriggerPlayer(),GY_PlayerA))then
if(GZ_chat=="lx")then
call DoNotSaveReplay()
call GY_zc(("|cFFFFFF00"+"关闭录像功能"))
endif
if(GZ_chat=="ms")then
if(IsPlayerInForce(GZ_pP,GY_PlayerB[2]))then
call ForceRemovePlayer(GY_PlayerB[2],GZ_pP)
call GY_zc(("|cff0080FF关闭-|cff00FF00秒杀模式|r"+""))
else
call ForceAddPlayer(GY_PlayerB[2],GZ_pP)
call GY_zc(("|cff0080FF开启-|cff00FF00秒杀模式|r"+""))
endif
endif
if(GZ_chat=="ds")then
if(IsPlayerInForce(GZ_pP,GY_PlayerB[3]))then
call ForceRemovePlayer(GY_PlayerB[3],GZ_pP)
call GY_zc(("|cff0080FF关闭-|cff00FF00点杀模式|r"+""))
else
call ForceAddPlayer(GY_PlayerB[3],GZ_pP)
call GY_zc(("|cff0080FF开启-|cff00FF00点杀模式|r"+""))
endif
endif
if(GZ_chat=="fh")then
if(IsPlayerInForce(GZ_pP,GY_PlayerB[4]))then
call ForceRemovePlayer(GY_PlayerB[4],GZ_pP)
call GY_zc(("|cff0080FF关闭-|cff00FF00自动无限复活|r"+""))
else
call ForceAddPlayer(GY_PlayerB[4],GZ_pP)
call GY_zc(("|cff0080FF开启-|cff00FF00自动无限复活|r"+""))
endif
endif
if(GZ_chat=="jn")then
if(IsPlayerInForce(GZ_pP,GY_PlayerB[5]))then
call ForceRemovePlayer(GY_PlayerB[5],GZ_pP)
call GY_zc(("|cff0080FF关闭-|cff00FF00自动清CD|r"+""))
else
call ForceAddPlayer(GY_PlayerB[5],GZ_pP)
call GY_zc(("|cff0080FF开启-|cff00FF00自动清CD|r"+""))
endif
endif
if(GZ_chat=="jw")then
if(IsPlayerInForce(GZ_pP,GY_PlayerB[6]))then
call ForceRemovePlayer(GY_PlayerB[6],GZ_pP)
call GY_zc(("|cff0080FF关闭-|cff00FF00全图捡取物品|r"+""))
else
call ForceAddPlayer(GY_PlayerB[6],GZ_pP)
call GY_zc(("|cff0080FF开启-|cff00FF00全图捡取物品|r"+""))
endif
endif
if(GZ_chat=="glxx")then
if(((CountPlayersInForceBJ(GY_PlayerA)-1)>0))then
call GY_Zc(GY_Player,("|cFF669900当前管理人员人数为|r|cFFFF9933"+I2S((CountPlayersInForceBJ(GY_PlayerA)-1))))
else
call GY_Zc(GY_Player,("|cFF669900暂时没有管理人员|r"+""))
endif
endif
if(GZ_chat=="p")then
if(IsPlayerInForce(GZ_pP,GY_PlayerB[7]))then
call ForceRemovePlayer(GY_PlayerB[7],GZ_pP)
call GY_zc(("|cff0080FF关闭-|cff00FF00P键全图闪烁|r"+""))
else
call ForceAddPlayer(GY_PlayerB[7],GZ_pP)
call GY_zc(("|cff0080FF开启-|cff00FF00P键全图闪烁|r"+""))
endif
endif
call ForGroup(Gz_zu,function GY_V1)
call DestroyGroup(Gz_zu)
set Gz_zu=null
endif
endfunction
function SYR_GY takes nothing returns nothing
local trigger t
local integer i
local timer tm
set i=0
set GY_PlayerA=CreateForce()
set i=0
loop
exitwhen(i>'d')
set GY_group[i]=CreateGroup()
set GY_PlayerB[i]=CreateForce()
set GY_BX[i]=false
set i=i+1
endloop
set i=0
set t=CreateTrigger()
loop
exitwhen i>11
call TriggerRegisterPlayerChatEvent(t,Player(i),"包子",true)
set i=i+1
endloop
call TriggerAddCondition(t,Condition(function GY_o0Oo))
set i=0
set t=CreateTrigger()
loop
exitwhen i>11
call TriggerRegisterPlayerEvent(t,Player(i),ConvertPlayerEvent(17))
set i=i+1
endloop
call TriggerAddCondition(t,Condition(function GY_o0oo))
set t=CreateTrigger()
call GY_0Oo0(t,39)
call GY_0Oo0(t,276)
call GY_0Oo0(t,40)
call TriggerAddCondition(t,Condition(function GY_o00o))
set t=CreateTrigger()
call GY_0Oo0(t,20)
call TriggerAddCondition(t,Condition(function GY_oO0o))
set t=CreateTrigger()
call GY_0Oo0(t,18)
call TriggerAddAction(t,function GY_oO00)
set t=CreateTrigger()
call GY_0Oo0(t,24)
call TriggerAddAction(t,function GY_o000)
set t=CreateTrigger()
call GY_0Oo0(t,42)
call GY_0Oo0(t,273)
call GY_0Oo0(t,49)
call GY_0Oo0(t,48)
call TriggerAddAction(t,function GY_o0o0)
set tm=CreateTimer()
call TimerStart(tm,.1,true,function GY_o0oO)
set tm=null
set tm=CreateTimer()
call TimerStart(tm,1,true,function GY_o0OO)
set tm=null
set i=0
set t=CreateTrigger()
loop
exitwhen i>11
call TriggerRegisterPlayerChatEvent(t,Player(i),"",true)
set i=i+1
endloop
call TriggerAddCondition(t,Condition(function GY_Vv))
call TriggerAddAction(t,function GY_Cmd)
set t=null
set i=0
endfunction
function jhwx takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Xs11 takes integer i returns integer
if bz01[i] then
return strlv11[i]
endif
if bz11[i] then
return agilv11[i]
endif
if bz21[i] then
return intlv11[i]
endif
if bz31[i] then
return alllv11[i]
endif
return 0
endfunction
function P111 takes integer i returns string
local string s
if bz01[i] then
set strlv11[i]=strlv11[i]+1
set lvexp11[i]=R2I(lvexp11[i]*1.5)
set s=sss2+GetPlayerName(Player(i))+"的力量秘法修为进阶为"+I2S(strlv11[i])+"级！"+"升级所需经验："+I2S(lvexp11[i])
return s
endif
if bz11[i] then
set agilv11[i]=agilv11[i]+1
set lvexp11[i]=R2I(lvexp11[i]*1.5)
set s=sss2+GetPlayerName(Player(i))+"的敏捷秘法修为进阶为"+I2S(agilv11[i])+"级！"+"升级所需经验："+I2S(lvexp11[i])
return s
endif
if bz21[i] then
set intlv11[i]=intlv11[i]+1
set lvexp11[i]=R2I(lvexp11[i]*1.5)
set s=sss2+GetPlayerName(Player(i))+"的智力秘法修为进阶为"+I2S(intlv11[i])+"级！"+"升级所需经验："+I2S(lvexp11[i])
return s
endif
if bz31[i] then
set alllv11[i]=alllv11[i]+1
set lvexp11[i]=R2I(lvexp11[i]*1.5)
set s=sss2+GetPlayerName(Player(i))+"的全能秘法修为进阶为"+I2S(alllv11[i])+"级！"+"升级所需经验："+I2S(lvexp11[i])
return s
endif
return null
endfunction
function Sg11 takes integer i,integer m returns boolean
local integer n
local string s
set exp11[i]=exp11[i]+m
if Isb[i]==false then
call DisplayTextToPlayer(Player(i),0,0,I2S(exp11[i])+"/"+I2S(lvexp11[i]))
endif
if exp11[i]>=lvexp11[i]then
set exp11[i]=0
set n=0
set s=P111(i)
if Isb[i]==false then
call DisplayTextToPlayer(Player(i),0,0,sss2+"可以输入“关闭提示”来关闭修仙进阶提示。可以通过输入“查询”来查询技能详细情况。")
endif
if Isb[i]==true then
call DisplayTextToPlayer(Player(i),0,0,sss2+"可以输入“打开提示”打开修仙进阶提示。可以通过输入“查询”来查询技能详细情况。")
endif
loop
exitwhen n>11
call DisplayTextToPlayer(Player(n),0,0,s)
set n=n+1
endloop
return true
endif
return false
endfunction
function dj11 takes integer m,integer n,unit u,real r,unit at,real ss,string e ,integer rd returns nothing
local unit uu=null
local group g=null
local integer i
local integer ep
local real x
if GetRandomInt(1,m)<=n then
set i=GetPlayerId(GetOwningPlayer(GetAttacker()))
set ep=11-Xs11(i)
if ep<2 then
set ep=2
endif
call Sg11(i,ep)
set g=CreateGroup()
call GroupEnumUnitsInRange(g,GetUnitX(u),GetUnitY(u),r,Condition(function jhwx))
loop
set uu=FirstOfGroup(g)
exitwhen uu==null
if GetUnitLifePercent(uu)>.0  then
set x = GetUnitState(uu, ConvertUnitState(0))
call UnitDamageTarget(at,uu,ss,true,false,ConvertAttackType(6),ConvertDamageType(26),ConvertWeaponType(0))
set x=  (x-GetUnitState(uu, ConvertUnitState(0)))/ GetUnitState(uu, ConvertUnitState(1))
if x<0.05 and Xs11(i)>=6 and GetUnitLifePercent(uu)>.0 then
if Xs11(i)==rd or rd==7 then
set Ji11[i]=Ji11[i]*2
set Ji12[i]=Ji12[i]+1
set ep=0
loop
exitwhen ep>11
call DisplayTextToPlayer(Player(ep),0,0,sss1+GetPlayerName(Player(i))+"的修仙技能发生了神奇的进化，技能威力加强了一倍！")
set ep=ep+1
endloop
return
endif
endif
call DestroyEffect(AddSpecialEffectTarget(e,uu,"overhead"))
call GroupRemoveUnit(g,uu)
endif
endloop
call DestroyGroup(g)
set uu=null
set g=null
endif
endfunction
function Ss11 takes integer str,integer agi,integer int,integer lv,integer m1,integer m2,integer m3,integer m4,real xs returns real
local real n
set n=(str*m1+agi*m2+int*m3)*lv*xs
if m4>1 then
set n=(str+agi+int)*lv*xs*m4
endif
return n
endfunction
function Trig_x1_Conditions takes nothing returns boolean
local integer i=0
if b11==false then
set b11=true
call DialogClear(dk11)
set an11[0]=DialogAddButton(dk11,"选择力量（力量型战士修仙术）",0)
set an11[1]=DialogAddButton(dk11,"选择敏捷（敏捷型战士修仙术）",0)
set an11[2]=DialogAddButton(dk11,"选择智力（智力型战士修仙术）",0)
set an11[3]=DialogAddButton(dk11,"选择全能（全能性.哥们行吗不推荐FS选择）",0)
call DialogSetMessage(dk11,"请选择一个")
loop
exitwhen i>12
call DialogDisplay(Player(i),dk11,true)
set i=i+1
endloop
endif
return true
endfunction
function Dk11 takes button b,integer i,string t returns boolean
if GetClickedButton()==b then
set bz123[i]=true
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,t)
return true
endif
return false
endfunction
function Trig_x2_Conditions takes nothing returns boolean
local integer i=0
local string s="-----------欢迎使用“包子修仙法”，输入“打开提示”打开修仙进阶提示，输入“关闭提示”关闭修仙进阶提示，输入“查询”查询技能详细情况。"
set i=GetPlayerId(GetTriggerPlayer())
if bz123[i]==false then
if Dk11(an11[0],i,sss1+" 选择了力量型附加技能 "+s)then
set bz01[i]=true
endif
if Dk11(an11[1],i,sss1+" 选择了敏捷型附加技能 "+s)then
set bz11[i]=true
endif
if Dk11(an11[2],i,sss1+" 选择了智力型附加技能 "+s)then
set bz21[i]=true
endif
if Dk11(an11[3],i,sss1+" 选择了全能型附加技能 "+s)then
set bz31[i]=true
endif
endif
return true
endfunction
function S2O11 takes string orderIdString returns integer
local integer orderId
set orderId=OrderId(orderIdString)
if(orderId!=0)then
return orderId
endif
set orderId=UnitId(orderIdString)
if(orderId!=0)then
return orderId
endif
return 0
endfunction
function Trig_x3_Conditions takes nothing returns boolean
local location p=null
local unit u=null
if GetIssuedOrderId()==S2O11("move")and bz123[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))] then
set u=GetTriggerUnit()
set p=GetOrderPointLoc()
call SetUnitX(u,GetLocationX(p))
call SetUnitY(u,GetLocationY(p))
call RemoveLocation(p)
set u=null
endif
return true
endfunction
function Ppx takes integer i,integer n returns integer 
return Ji11[i]*n
endfunction
function Px11 takes integer i,integer m returns integer
if bz01[i] and m==0 then
return Ppx(i,4)
endif
if bz11[i] and m==1 then
return Ppx(i,4)
endif
if bz21[i] and m==2 then
return Ppx(i,6)
endif
if bz31[i] and m==3 then
return Ppx(i,2)
endif
return 1
endfunction
function Fx11 takes integer lv returns integer
local integer n
set n=R2I(SquareRoot(GetRandomReal(1,GetRandomInt(1,lv+2)*GetRandomInt(1,2+lv)))-1)
if n>lv then
set n=lv
if n>7 then
set n=7
endif
endif
if n<1 then
set n=1
endif
return n 
endfunction
function Trig_x4_Conditions takes nothing returns boolean
local integer i
local unit ua
local unit u
local integer str
local integer agi
local integer int
local integer lv
local real sh
local string array s
local integer n
set ua=GetAttacker()
set u=GetTriggerUnit()
set i=GetPlayerId(GetOwningPlayer(ua))
if bz123[i] and IsUnitType(ua,ConvertUnitType(0)) then
set s[1]="Abilities\\Spells\\Human\\Blizzard\\BlizzardTarget.mdl"
set s[2]="Abilities\\Spells\\Other\\Doom\\DoomTarget.mdl"
set s[3]="Abilities\\Spells\\Other\\Volcano\\VolcanoDeath.mdl"
set s[4]="Abilities\\Spells\\Demon\\RainOfFire\\RainOfFireTarget.mdl"
set s[5]="Abilities\\Spells\\Human\\ManaFlare\\ManaFlareBase.mdl"
set s[6]="units\\human\\phoenix\\phoenix.mdl"
set s[7]="units\\demon\\Infernal\\Infernal.mdl"
set str=GetHeroStr(ua,true)
set agi=GetHeroAgi(ua,true)
set int=GetHeroInt(ua,true)
set lv=Xs11(i)
set n=Fx11(lv)
set sh=Ss11(str,agi,int,lv,Px11(i,0),Px11(i,1),Px11(i,2),Px11(i,3),n*n)
call dj11('d',2+2*lv,u,200+50*lv+n*100,ua,sh,s[n],n)
endif
set ua=null
set u=null
return true
endfunction
function Trig_x5_Conditions takes nothing returns boolean
local integer i
set i=GetPlayerId(GetOwningPlayer(GetKillingUnit()))
if bz123[i] and IsPlayerEnemy(GetOwningPlayer(GetTriggerUnit()),GetOwningPlayer(GetKillingUnit())) then
if IsUnitType(GetTriggerUnit(),ConvertUnitType(0)) then
call Sg11(i,10)
else
call Sg11(i,1)
endif
endif
return true
endfunction
function Fj11 takes nothing returns nothing
local integer n=0
if b11==false then
loop
exitwhen n>11
call DisplayTextToPlayer(Player(n),0,0,sss1+" 任意玩家输入|cFF99FF00包子|r 开启以下功能
 1.输入|cFFFF6633我要修仙|r 可开启修仙技能
 2.输入|cFF99FF00进入魔道|r可以进入魔道修行  ，前提是主机输入|cFF99FF00魔道 打开|r
3. 输入|cFF0F6145邪神附体|r 可以直接得到邪神的技能.... 还有最好玩的就是人类拥有|cFF1FBF00偷师学艺|r 这个就保留了 想要问主机 或者Q我：|cFF66FF331|r|cFF0041FF0|r|cFF1BE6B87|r|cFFCC00332|r|cFFFFFF006|r|cFFFE9FD80|r|cFF1FBF000|r|cFFE55AAF4|r")
set n=n+1
endloop
endif
endfunction
function Tt111 takes trigger trig, playerunitevent whichEvent returns nothing
local integer index
set index = 0
loop
call TriggerRegisterPlayerUnitEvent(trig, Player(index), whichEvent, null)
set index = index + 1
exitwhen index == 16
endloop
endfunction
function Trig_x7_Conditions takes nothing returns boolean
local integer i
set i=GetPlayerId(GetTriggerPlayer())
if bz123[i]==true and Isb[i]==false then
set Isb[i]=true
return true
endif
return false
endfunction
function Trig_x6_Conditions takes nothing returns boolean
local integer i
set i=GetPlayerId(GetTriggerPlayer())
if bz123[i]==true and Isb[i]==true then
set Isb[i]=false
return true
endif
return false
endfunction
function Gmu takes player whichPlayer, boolexpr filter returns group
local group g = CreateGroup()
call GroupEnumUnitsOfPlayer(g, whichPlayer, filter)
call DestroyBoolExpr(filter)
return g
endfunction
function Zho takes real m returns string
if m<= 1000000 then
return I2S(R2I(m))
endif
if m>1000000 and m<=100000000 then
return R2S(m/10000)+"万"
endif
if m>100000000 then
return R2S(m/100000000)+"亿"
endif
return null
endfunction
function Trig_x8_Conditions takes nothing returns boolean
local integer i
local integer j
local unit u
local integer str
local integer agi
local integer int
set i=GetPlayerId(GetTriggerPlayer())
set u= FirstOfGroup(Gmu(Player(i), null))
set str=GetHeroStr(u,true)
set agi=GetHeroAgi(u,true)
set int=GetHeroInt(u,true)
if bz123[i]==true then
set j=Xs11(i)
call DisplayTextToPlayer(Player(i),0,0,sss2+" 以下是您修仙技能的详细信息：")
call DisplayTextToPlayer(Player(i),0,0,sss1+"当前等级："+I2S(j)+"级")
call DisplayTextToPlayer(Player(i),0,0,sss1+"当前经验："+I2S(exp11[i]))
call DisplayTextToPlayer(Player(i),0,0,sss1+"进化等级："+I2S(Ji12[i])+"级")
call DisplayTextToPlayer(Player(i),0,0,sss1+"距下一级："+I2S(lvexp11[i]-exp11[i])+"的经验")
call DisplayTextToPlayer(Player(i),0,0,sss1+"发动几率："+I2S(2+2*j)+"% ")
call DisplayTextToPlayer(Player(i),0,0,sss1+"技能最小范围："+I2S(300+50*j))
if j>7 then
set j=7
endif
call DisplayTextToPlayer(Player(i),0,0,sss1+"技能最大范围："+I2S(200+50*Xs11(i)+j*100))
call DisplayTextToPlayer(Player(i),0,0,sss1+"技能最小威力："+Zho(Ss11(str,agi,int,Xs11(i),Px11(i,0),Px11(i,1),Px11(i,2),Px11(i,3),1)))
call DisplayTextToPlayer(Player(i),0,0,sss1+"技能最大威力："+Zho(Ss11(str,agi,int,Xs11(i),Px11(i,0),Px11(i,1),Px11(i,2),Px11(i,3),j*j)))
return true
endif
return false
endfunction
function Txt takes trigger t,string s returns nothing
local integer i
set i=0
loop
exitwhen i==12
call TriggerRegisterPlayerChatEvent(t,Player(i),s,true)
set i=i+1
endloop
endfunction
function SDMJ takes nothing returns nothing
local trigger t
local integer i
local timer tt
set dk11=DialogCreate()
set i=0
loop
exitwhen(i>12)
set bz01[i]=false
set bz11[i]=false
set bz21[i]=false
set bz31[i]=false
set bz123[i]=false
set exp11[i]=0
set lvexp11[i]=150
set strlv11[i]=1
set agilv11[i]=1
set intlv11[i]=1
set alllv11[i]=1
set Ji11[i]=1
set Ji12[i]=0
set Isb[i]=false
set i=i+1
endloop
set tt=CreateTimer()
call TimerStart(tt,60,true,function Fj11)
set tt=null
set t=CreateTrigger()
call Txt(t,"我要修仙")
call TriggerAddCondition(t,Condition(function Trig_x1_Conditions))
set t=CreateTrigger()
call Txt(t,"打开提示")
call TriggerAddCondition(t,Condition(function Trig_x6_Conditions))
set t=CreateTrigger()
call Txt(t,"关闭提示")
call TriggerAddCondition(t,Condition(function Trig_x7_Conditions))
set t=CreateTrigger()
call Txt(t,"查询")
call TriggerAddCondition(t,Condition(function Trig_x8_Conditions))
set t=CreateTrigger()
call TriggerRegisterDialogEvent(t,dk11)
call TriggerAddCondition(t,Condition(function Trig_x2_Conditions))
set t=CreateTrigger()
call Tt111(t,ConvertPlayerUnitEvent(39))
call TriggerAddCondition(t,Condition(function Trig_x3_Conditions))
set t=CreateTrigger()
call Tt111(t,ConvertPlayerUnitEvent(18))
call TriggerAddCondition(t,Condition(function Trig_x4_Conditions))
set t=CreateTrigger()
call Tt111(t,ConvertPlayerUnitEvent(20))
call TriggerAddCondition(t,Condition(function Trig_x5_Conditions))
set t=null
endfunction