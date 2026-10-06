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
return ((GetRandomInt(1,100)<=100))
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
return ((GetRandomInt(1,100)<=100))
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
return ((GetRandomInt(1,100)<=100))
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
call ForGroupBJ(GetUnitsInRangeOfLocMatching(20.00,udg_PointA,Condition(function Trig_WuJiGunA01_Func008Func005Func009001003)),function Trig_WuJiGunA01_Func008Func005Func009A)
call RemoveUnit(udg_UnitsSelectA)
call RemoveLocation(udg_PointA)
endfunction
function Trig_WuJiGunA01_Func008C takes nothing returns boolean
return ((GetRandomInt(1,100)<=100))
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
return ((GetKillingUnitBJ()==udg_MonkUnitMH[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((udg_MHPlay[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetRandomInt(1,100)<=100))
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
return ((GetRandomInt(1,100)<=100))and((udg_ZhiZunRBool1))
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
return ((GetRandomInt(1,100)<=100))and((udg_ZhiZunRBool2))
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
return ((GetEventPlayerChatString()=="魔道 关闭"))
endfunction
function Trig_MapMasterMonkOpen_Func001C takes nothing returns boolean
return ((GetEventPlayerChatString()=="魔道 打开"))
endfunction
function Trig_MapMasterMonkOpen_Actions takes nothing returns nothing
if (Trig_MapMasterMonkOpen_Func001C()) then
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" |cFFFFFF00打开了魔道 !!!!!!!!!!!!!|r"+" |cFF00FF00邪恶之气已经释放。|cFFFF33FF脚本修改与添加：|cFFFF33FF影※锋   |cFF00FF33魔兽玩家交流群:46066273...有什么问题请登陆http://www.clez.net.cn/ 一起学习研究,也可以到这里玩宠物,|cFFFF0000会员群:8847589,|cFF00FF33加时注明论坛ID,|cFFFF33FF加后把群名片改为论坛ID")))
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
return ((GetRandomInt(1,100)<=100))
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
return ((GetRandomInt(1,100)<=100))
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
return ((GetRandomInt(1,100)<=100))
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
return ((udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=5000)) // 升级杀怪数，下同
endfunction
function Trig_JinWeaponUP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=100))
endfunction
function Trig_JinWeaponUP_Actions takes nothing returns nothing
set udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_JinWeaponUP_Func003C()) then
set udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_JinWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_JinWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000金魔之斩魂刀|r熟练度为 ")+I2S(udg_JinWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000金魔之斩魂刀|r "+(I2S(udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/5000")))
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
return ((GetUnitManaPercent(GetAttacker())>=70.00))and((GetRandomInt(1,100)<=100))
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
return ((GetRandomInt(1,100)<=100))
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
return ((udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=5000))
endfunction
function Trig_BingWeaponUP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=100))
endfunction
function Trig_BingWeaponUP_Actions takes nothing returns nothing
set udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_BingWeaponUP_Func003C()) then
set udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_BingWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_BingWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000冰魔之寒冰杖|r熟练度为 ")+I2S(udg_BingWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000冰魔之寒冰杖|r "+(I2S(udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/5000")))
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
return ((GetRandomInt(1,100)<=100))
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
return ((GetRandomInt(1,100)<=100))
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
return ((GetRandomInt(1,100)<=100))
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
return ((udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=5000))
endfunction
function Trig_HuoWeaponUP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=100))
endfunction
function Trig_HuoWeaponUP_Actions takes nothing returns nothing
set udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_HuoWeaponUP_Func003C()) then
set udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_HuoWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_HuoWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000炎魔之烈火刀|r熟练度为 ")+I2S(udg_HuoWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000炎魔之烈火刀|r "+(I2S(udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/5000")))
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
return ((GetRandomInt(1,100)<=100))
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
return ((GetRandomInt(1,100)<=100))
endfunction
function Trig_LeiWeapon_Func003C takes nothing returns boolean
return ((GetRandomInt(1,100)<=100))
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
return ((GetRandomInt(1,100)<=100))
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
return ((udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=5000))
endfunction
function Trig_LeiWeaponUP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=100))
endfunction
function Trig_LeiWeaponUP_Actions takes nothing returns nothing
set udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_LeiWeaponUP_Func003C()) then
set udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_LeiWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_LeiWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000雷魔之迅雷剑|r熟练度为 ")+I2S(udg_LeiWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000雷魔之迅雷剑|r "+(I2S(udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/5000")))
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
return ((GetRandomInt(1,100)<=100))
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
return ((GetRandomInt(1,100)<=100))
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
return ((GetRandomInt(1,100)<=100))
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
return ((GetRandomInt(1,100)<=100))and((GetUnitLifePercent(GetTriggerUnit())<=20.00))and((GetUnitManaPercent(GetTriggerUnit())>=30.00))
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
return ((udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=5000)) // 杀怪升级数
endfunction
function Trig_ShuiWeaponUP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=100))
endfunction
function Trig_ShuiWeaponUP_Actions takes nothing returns nothing
set udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_ShuiWeaponUP_Func003C()) then
set udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_ShuiWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_ShuiWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000水魔之定海神针|r熟练度为 ")+I2S(udg_ShuiWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000水魔之定海神针|r "+(I2S(udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/5000")))
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
return ((GetRandomInt(1,100)<=100))
endfunction
function Trig_MuWeapon_Func001Func009C takes nothing returns boolean
return ((GetRandomInt(1,100)<=100))
endfunction
function Trig_MuWeapon_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=100))and((udg_WeaponBool[1]))
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
return ((GetUnitManaPercent(GetAttacker())>=70.00))and((GetRandomInt(1,100)<=100))
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
return ((GetRandomInt(1,100)<=100))
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
return ((udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=5000))
endfunction
function Trig_MuWeaponUP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=100))
endfunction
function Trig_MuWeaponUP_Actions takes nothing returns nothing
set udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_MuWeaponUP_Func003C()) then
set udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_MuWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_MuWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000木魔之精灵地刺|r熟练度为 ")+I2S(udg_MuWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000木魔之精灵地刺|r "+(I2S(udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/5000")))
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
return ((GetRandomInt(1,100)<=100))
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
return ((GetRandomInt(1,100)<=100))
endfunction
function Trig_WangWeapon_Func003C takes nothing returns boolean
return ((GetRandomInt(1,100)<=100))and((IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)!=true))
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
return ((udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=5000))
endfunction
function Trig_WangWeaponUP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=100))
endfunction
function Trig_WangWeaponUP_Actions takes nothing returns nothing
set udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_WangWeaponUP_Func003C()) then
set udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_WangWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_WangWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000亡魔之暗黑之刃|r熟练度为 ")+I2S(udg_WangWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000亡魔之暗黑之刃|r  "+(I2S(udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/5000")))
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
return ((GetRandomInt(1,100)<=100))and((udg_WeaponBool[2]))
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
return ((GetUnitManaPercent(GetAttacker())>=70.00))and((GetRandomInt(1,100)<=100))
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
return ((GetRandomInt(1,100)<=100))
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
return ((udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=5000))
endfunction
function Trig_YueWeaponUP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=100))
endfunction
function Trig_YueWeaponUP_Actions takes nothing returns nothing
set udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_YueWeaponUP_Func003C()) then
set udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_YueWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_YueWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000月魔之无相金轮|r熟练度为 ")+I2S(udg_YueWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000月魔之无相金轮|r "+(I2S(udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/5000")))
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
return ((GetRandomInt(1,100)<=100))
endfunction
function Trig_TuWeapon_Func002C takes nothing returns boolean
return ((GetRandomInt(1,100)<=100))
endfunction
function Trig_TuWeapon_Func003C takes nothing returns boolean
return ((GetRandomInt(1,100)<=100))
endfunction
function Trig_TuWeapon_Func004C takes nothing returns boolean
return ((GetRandomInt(1,1000)<=1000))and((GetUnitLifePercent(GetAttacker())>60.00))and((GetUnitLevel(GetAttacker())>30))
endfunction
function Trig_TuWeapon_Func005C takes nothing returns boolean
return ((GetRandomInt(1,1000)<=1000))and((GetUnitLifePercent(GetAttacker())>60.00))and((GetUnitLevel(GetAttacker())>50))
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
return ((udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=5000))
endfunction
function Trig_TuWeaponUP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=100))
endfunction
function Trig_TuWeaponUP_Actions takes nothing returns nothing
set udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_TuWeaponUP_Func003C()) then
set udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_TuWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_TuWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000土魔之邪魔尘影|r熟练度为 ")+I2S(udg_TuWeaponL[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000土魔之邪魔尘影|r  "+(I2S(udg_WeaponLevelUp[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/5000")))
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
