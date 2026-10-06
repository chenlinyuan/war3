function Trig_liubo7_Func001Func001Func015C takes nothing returns boolean
return(IsUnitType(GetEnumUnit(),UNIT_TYPE_HERO))and(GetOwningPlayer(GetEnumUnit())==Player(0))and(GetUnitTypeId(GetEnumUnit())!='O00M')
endfunction
function Trig_liubo7_Func001Func001C takes nothing returns boolean
return(Trig_liubo7_Func001Func001Func015C())
endfunction
function Trig_liubo7_Func001A takes nothing returns nothing
if(Trig_liubo7_Func001Func001C())then
set udg_liubo1=true
call PanCameraToTimedLocForPlayer(Player(0),GetUnitLoc(GetEnumUnit()),0)
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,10.,(GetPlayerName(GetTriggerPlayer())+"|CFF00FF00开启了无界隐藏技能模式|R|CFFFF0000火神的领域|R|CFF00FF00,关注诸神的领域开启方法"))
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,10.,"|C00FF00FF关注：bbs.07073.com/wujie")
call SetUnitVertexColor(GetEnumUnit(),255,0,0,255)
call SetUnitMoveSpeed(GetEnumUnit(),522.)
call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Doodads\\Cinematic\\TownBurningliubo7Emitter\\TownBurningliubo7Emitter.mdl")
call CreateTextTagUnitBJ("诸神领域-liubo7",GetEnumUnit(),0,20.,'d',.0,.0,0)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,90.,90.)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
call SetTextTagFadepoint(bj_lastCreatedTextTag,1.)
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl")
call DestroyEffect(bj_lastCreatedEffect)
endif
endfunction
function Trig_liubo7_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(Player(0)),function Trig_liubo7_Func001A)
endfunction
function Trig_liubo71_Conditions takes nothing returns boolean
return(GetOwningPlayer(GetAttacker())==Player(0))and(IsUnitType(GetAttacker(),UNIT_TYPE_HERO))and(IsUnitEnemy(GetTriggerUnit(),Player(0)))and(udg_liubo1)
endfunction
function Trig_liubo71_Func006Func001001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_liubo71_Func006Func001001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_liubo71_Func006Func001001003 takes nothing returns boolean
return GetBooleanAnd(Trig_liubo71_Func006Func001001003001(),Trig_liubo71_Func006Func001001003002())
endfunction
function Trig_liubo71_Func006Func001A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((((I2R(GetHeroStr(GetAttacker(),true))+I2R(GetHeroAgi(GetAttacker(),true)))+I2R(GetHeroInt(GetAttacker(),true)))*SquareRoot(I2R(GetHeroLevel(GetAttacker()))))*GetRandomReal(1.,5.)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_liubo71_Func006C takes nothing returns boolean
return(GetRandomInt(1,1000)<=((R2I(SquareRoot(I2R(GetHeroInt(GetAttacker(),true))))/ 3)+'d'))
endfunction
function Trig_liubo71_Actions takes nothing returns nothing
if(Trig_liubo71_Func006C())then
call ForGroupBJ(GetUnitsInRangeOfLocMatching((SquareRoot((I2R(GetHeroInt(GetAttacker(),true))*(I2R(GetHeroLevel(GetAttacker()))/ 3.)))+500.),GetUnitLoc(GetTriggerUnit()),Condition(function Trig_liubo71_Func006Func001001003)),function Trig_liubo71_Func006Func001A)
call DestroyGroup(GetLastCreatedGroup())
endif
endfunction
function Trig_liubo72_Conditions takes nothing returns boolean
return(udg_liubo1)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetUnitLifePercent(GetTriggerUnit())<=20.)and(GetRandomReal(1.,10.)<=2.)
endfunction
function Trig_liubo72_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\Human\\Resurrect\\ResurrectCaster.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call SetUnitInvulnerable(GetTriggerUnit(),true)
call SetUnitLifePercentBJ(GetTriggerUnit(),'d')
call TriggerSleepAction(1.)
call SetUnitInvulnerable(GetTriggerUnit(),false)
endfunction
function Trig_liubo73_Conditions takes nothing returns boolean
return(udg_liubo1)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetIssuedOrderId()==851990)
endfunction
function Trig_liubo73_Actions takes nothing returns nothing
call SetUnitPositionLoc(GetTriggerUnit(),GetOrderPointLoc())
endfunction
function Trig_liubo74_Conditions takes nothing returns boolean
return(udg_liubo1)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetRandomInt(1,'d')<=2)
endfunction
function Trig_liubo74_Func001001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_liubo74_Func001001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetTriggerUnit())))
endfunction
function Trig_liubo74_Func001001003 takes nothing returns boolean
return GetBooleanAnd(Trig_liubo74_Func001001003001(),Trig_liubo74_Func001001003002())
endfunction
function Trig_liubo74_Func001A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Demon\\RainOfliubo7\\RainOfliubo7Target.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetTriggerUnit(),GetEnumUnit(),((((I2R(GetHeroStr(GetTriggerUnit(),true))+I2R(GetHeroAgi(GetTriggerUnit(),true)))+I2R(GetHeroInt(GetTriggerUnit(),true)))*SquareRoot(I2R(GetHeroLevel(GetTriggerUnit()))))/ 3.),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_liubo74_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsInRangeOfLocMatching(512.,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_liubo74_Func001001003)),function Trig_liubo74_Func001A)
call DestroyGroup(GetLastCreatedGroup())
endfunction
function Trig_liubo8_Func001Func001Func018C takes nothing returns boolean
return(IsUnitType(GetEnumUnit(),UNIT_TYPE_HERO))and(GetOwningPlayer(GetEnumUnit())==Player(1))and(GetUnitTypeId(GetEnumUnit())!='O00M')
endfunction
function Trig_liubo8_Func001Func001C takes nothing returns boolean
return(Trig_liubo8_Func001Func001Func018C())
endfunction
function Trig_liubo8_Func001A takes nothing returns nothing
if(Trig_liubo8_Func001Func001C())then
set udg_liubo2=true
call EnableTrigger(gg_trg_liubo81)
call EnableTrigger(gg_trg_liubo82)
call EnableTrigger(gg_trg_liubo83)
call PanCameraToTimedLocForPlayer(Player(1),GetUnitLoc(GetEnumUnit()),0)
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,10.,(GetPlayerName(GetTriggerPlayer())+"|CFF00FF00开启了无界隐藏技能模式|R|CFF0000FF冰神的领域|R|CFF00FF00,关注诸神的领域开启方法"))
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,10.,"|C00FF00FF关注：bbs.07073.com/wujie")
call SetUnitVertexColor(GetEnumUnit(),0,0,255,255)
call SetUnitMoveSpeed(GetEnumUnit(),522.)
call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Doodads\\Cinematic\\TownBurningliubo7EmitterBlue\\TownBurningliubo7EmitterBlue.mdl")
call CreateTextTagUnitBJ("诸神领域-liubo8",GetEnumUnit(),0,20.,.0,.0,100.,0)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,90.,90.)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
call SetTextTagFadepoint(bj_lastCreatedTextTag,1.)
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl")
call DestroyEffect(bj_lastCreatedEffect)
endif
endfunction
function Trig_liubo8_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(Player(1)),function Trig_liubo8_Func001A)
endfunction
function Trig_liubo81_Conditions takes nothing returns boolean
return(GetOwningPlayer(GetAttacker())==Player(1))and(IsUnitType(GetAttacker(),UNIT_TYPE_HERO))and(IsUnitEnemy(GetTriggerUnit(),Player(1)))and(udg_liubo2)
endfunction
function Trig_liubo81_Func006Func001001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_liubo81_Func006Func001001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_liubo81_Func006Func001001003 takes nothing returns boolean
return GetBooleanAnd(Trig_liubo81_Func006Func001001003001(),Trig_liubo81_Func006Func001001003002())
endfunction
function Trig_liubo81_Func006Func001A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((((I2R(GetHeroStr(GetAttacker(),true))+I2R(GetHeroAgi(GetAttacker(),true)))+I2R(GetHeroInt(GetAttacker(),true)))*SquareRoot(I2R(GetHeroLevel(GetAttacker()))))*GetRandomReal(1.,5.)),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_liubo81_Func006C takes nothing returns boolean
return(GetRandomInt(1,1000)<=((R2I(SquareRoot(I2R(GetHeroInt(GetAttacker(),true))))/ 3)+'d'))
endfunction
function Trig_liubo81_Actions takes nothing returns nothing
if(Trig_liubo81_Func006C())then
call ForGroupBJ(GetUnitsInRangeOfLocMatching((SquareRoot((I2R(GetHeroInt(GetAttacker(),true))*(I2R(GetHeroLevel(GetAttacker()))/ 3.)))+500.),GetUnitLoc(GetTriggerUnit()),Condition(function Trig_liubo81_Func006Func001001003)),function Trig_liubo81_Func006Func001A)
call DestroyGroup(GetLastCreatedGroup())
endif
endfunction
function Trig_liubo82_Conditions takes nothing returns boolean
return(udg_liubo2)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetUnitLifePercent(GetTriggerUnit())<=20.)and(GetRandomReal(1.,10.)<=2.)
endfunction
function Trig_liubo82_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\Human\\Resurrect\\ResurrectCaster.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call SetUnitInvulnerable(GetTriggerUnit(),true)
call SetUnitLifePercentBJ(GetTriggerUnit(),'d')
call TriggerSleepAction(1.)
call SetUnitInvulnerable(GetTriggerUnit(),false)
endfunction
function Trig_liubo83_Conditions takes nothing returns boolean
return(udg_liubo2)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetIssuedOrderId()==851990)
endfunction
function Trig_liubo83_Actions takes nothing returns nothing
call SetUnitPositionLoc(GetTriggerUnit(),GetOrderPointLoc())
endfunction
function Trig_liubo84_Conditions takes nothing returns boolean
return(udg_liubo2)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetRandomInt(1,'d')<=2)
endfunction
function Trig_liubo84_Func001001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_liubo84_Func001001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetTriggerUnit())))
endfunction
function Trig_liubo84_Func001001003 takes nothing returns boolean
return GetBooleanAnd(Trig_liubo84_Func001001003001(),Trig_liubo84_Func001001003002())
endfunction
function Trig_liubo84_Func001A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\Blizzard\\BlizzardTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetTriggerUnit(),GetEnumUnit(),((((I2R(GetHeroStr(GetTriggerUnit(),true))+I2R(GetHeroAgi(GetTriggerUnit(),true)))+I2R(GetHeroInt(GetTriggerUnit(),true)))*SquareRoot(I2R(GetHeroLevel(GetTriggerUnit()))))/ 3.),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_liubo84_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsInRangeOfLocMatching(512.,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_liubo84_Func001001003)),function Trig_liubo84_Func001A)
call DestroyGroup(GetLastCreatedGroup())
endfunction
function Trig_liubo9_Func001Func001Func018C takes nothing returns boolean
return(IsUnitType(GetEnumUnit(),UNIT_TYPE_HERO))and(GetOwningPlayer(GetEnumUnit())==Player(2))and(GetUnitTypeId(GetEnumUnit())!='O00M')
endfunction
function Trig_liubo9_Func001Func001C takes nothing returns boolean
return(Trig_liubo9_Func001Func001Func018C())
endfunction
function Trig_liubo9_Func001A takes nothing returns nothing
if(Trig_liubo9_Func001Func001C())then
set udg_liubo3=true
call EnableTrigger(gg_trg_liubo91)
call EnableTrigger(gg_trg_liubo92)
call EnableTrigger(gg_trg_liubo93)
call PanCameraToTimedLocForPlayer(Player(2),GetUnitLoc(GetEnumUnit()),0)
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,10.,(GetPlayerName(GetTriggerPlayer())+"|CFF00FF00开启了无界隐藏技能模式|R|CFF00FFFF雷神的领域|R|CFF00FF00,关注诸神的领域开启方法"))
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,10.,"|C00FF00FF关注：bbs.07073.com/wujie")
call SetUnitVertexColor(GetEnumUnit(),0,255,255,255)
call SetUnitMoveSpeed(GetEnumUnit(),522.)
call AddSpecialEffectTargetUnitBJ("chest",GetEnumUnit(),"Abilities\\Spells\\Items\\AIlb\\AIlbSpecialArt.mdl")
call CreateTextTagUnitBJ("诸神领域-liubo9",GetEnumUnit(),0,20.,.0,100.,100.,0)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,90.,90.)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
call SetTextTagFadepoint(bj_lastCreatedTextTag,1.)
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl")
call DestroyEffect(bj_lastCreatedEffect)
endif
endfunction
function Trig_liubo9_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(Player(2)),function Trig_liubo9_Func001A)
endfunction
function Trig_liubo91_Conditions takes nothing returns boolean
return(GetOwningPlayer(GetAttacker())==Player(2))and(IsUnitType(GetAttacker(),UNIT_TYPE_HERO))and(IsUnitEnemy(GetTriggerUnit(),Player(2)))and(udg_liubo3)
endfunction
function Trig_liubo91_Func006Func001001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_liubo91_Func006Func001001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_liubo91_Func006Func001001003 takes nothing returns boolean
return GetBooleanAnd(Trig_liubo91_Func006Func001001003001(),Trig_liubo91_Func006Func001001003002())
endfunction
function Trig_liubo91_Func006Func001A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\Monsoon\\Monsoonliubo9Target.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((((I2R(GetHeroStr(GetAttacker(),true))+I2R(GetHeroAgi(GetAttacker(),true)))+I2R(GetHeroInt(GetAttacker(),true)))*SquareRoot(I2R(GetHeroLevel(GetAttacker()))))*GetRandomReal(1.,5.)),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_liubo91_Func006C takes nothing returns boolean
return(GetRandomInt(1,1000)<=((R2I(SquareRoot(I2R(GetHeroInt(GetAttacker(),true))))/ 3)+'d'))
endfunction
function Trig_liubo91_Actions takes nothing returns nothing
if(Trig_liubo91_Func006C())then
call ForGroupBJ(GetUnitsInRangeOfLocMatching((SquareRoot((I2R(GetHeroInt(GetAttacker(),true))*(I2R(GetHeroLevel(GetAttacker()))/ 3.)))+500.),GetUnitLoc(GetTriggerUnit()),Condition(function Trig_liubo91_Func006Func001001003)),function Trig_liubo91_Func006Func001A)
call DestroyGroup(GetLastCreatedGroup())
endif
endfunction
function Trig_liubo92_Conditions takes nothing returns boolean
return(udg_liubo3)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetUnitLifePercent(GetTriggerUnit())<=20.)and(GetRandomReal(1.,10.)<=2.)
endfunction
function Trig_liubo92_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\Human\\Resurrect\\ResurrectCaster.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call SetUnitInvulnerable(GetTriggerUnit(),true)
call SetUnitLifePercentBJ(GetTriggerUnit(),'d')
call TriggerSleepAction(1.)
call SetUnitInvulnerable(GetTriggerUnit(),false)
endfunction
function Trig_liubo93_Conditions takes nothing returns boolean
return(udg_liubo3)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetIssuedOrderId()==851990)
endfunction
function Trig_liubo93_Actions takes nothing returns nothing
call SetUnitPositionLoc(GetTriggerUnit(),GetOrderPointLoc())
endfunction
function Trig_liubo94_Conditions takes nothing returns boolean
return(udg_liubo3)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetRandomInt(1,'d')<=2)
endfunction
function Trig_liubo94_Func001001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_liubo94_Func001001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetTriggerUnit())))
endfunction
function Trig_liubo94_Func001001003 takes nothing returns boolean
return GetBooleanAnd(Trig_liubo94_Func001001003001(),Trig_liubo94_Func001001003002())
endfunction
function Trig_liubo94_Func001A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Orc\\liubo11ningShield\\liubo11ningShieldTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetTriggerUnit(),GetEnumUnit(),((((I2R(GetHeroStr(GetTriggerUnit(),true))+I2R(GetHeroAgi(GetTriggerUnit(),true)))+I2R(GetHeroInt(GetTriggerUnit(),true)))*SquareRoot(I2R(GetHeroLevel(GetTriggerUnit()))))/ 3.),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_liubo94_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsInRangeOfLocMatching(512.,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_liubo94_Func001001003)),function Trig_liubo94_Func001A)
call DestroyGroup(GetLastCreatedGroup())
endfunction
function Trig_liubo10_Func001Func001Func016C takes nothing returns boolean
return(IsUnitType(GetEnumUnit(),UNIT_TYPE_HERO))and(GetOwningPlayer(GetEnumUnit())==Player(3))and(GetUnitTypeId(GetEnumUnit())!='O00M')
endfunction
function Trig_liubo10_Func001Func001C takes nothing returns boolean
return(Trig_liubo10_Func001Func001Func016C())
endfunction
function Trig_liubo10_Func001A takes nothing returns nothing
if(Trig_liubo10_Func001Func001C())then
set udg_liubo4=true
call EnableTrigger(gg_trg_liubo101)
call EnableTrigger(gg_trg_liubo102)
call EnableTrigger(gg_trg_liubo103)
call PanCameraToTimedLocForPlayer(Player(3),GetUnitLoc(GetEnumUnit()),0)
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,10.,(GetPlayerName(GetTriggerPlayer())+"|CFF00FF00开启了无界隐藏技能模式|R|C00FF00FF月亮女神领域|R|CFF00FF00,关注诸神的领域开启方法"))
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,10.,"|C00FF00FF关注：bbs.07073.com/wujie")
call SetUnitVertexColor(GetEnumUnit(),255,0,255,255)
call SetUnitMoveSpeed(GetEnumUnit(),522.)
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\Starfall\\StarfallCaster.mdl")
call CreateTextTagUnitBJ("诸神领域-liubo10",GetEnumUnit(),0,20.,100.,.0,100.,0)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,90.,90.)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
call SetTextTagFadepoint(bj_lastCreatedTextTag,1.)
endif
endfunction
function Trig_liubo10_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(Player(3)),function Trig_liubo10_Func001A)
endfunction
function Trig_liubo101_Conditions takes nothing returns boolean
return(GetOwningPlayer(GetAttacker())==Player(3))and(IsUnitType(GetAttacker(),UNIT_TYPE_HERO))and(IsUnitEnemy(GetTriggerUnit(),Player(3)))and(udg_liubo4)
endfunction
function Trig_liubo101_Func006Func001001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_liubo101_Func006Func001001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_liubo101_Func006Func001001003 takes nothing returns boolean
return GetBooleanAnd(Trig_liubo101_Func006Func001001003001(),Trig_liubo101_Func006Func001001003002())
endfunction
function Trig_liubo101_Func006Func001A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\Starfall\\StarfallTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((((I2R(GetHeroStr(GetAttacker(),true))+I2R(GetHeroAgi(GetAttacker(),true)))+I2R(GetHeroInt(GetAttacker(),true)))*SquareRoot(I2R(GetHeroLevel(GetAttacker()))))*GetRandomReal(1.,5.)),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_liubo101_Func006C takes nothing returns boolean
return(GetRandomInt(1,1000)<=((R2I(SquareRoot(I2R(GetHeroInt(GetAttacker(),true))))/ 3)+'d'))
endfunction
function Trig_liubo101_Actions takes nothing returns nothing
if(Trig_liubo101_Func006C())then
call ForGroupBJ(GetUnitsInRangeOfLocMatching((SquareRoot((I2R(GetHeroInt(GetAttacker(),true))*(I2R(GetHeroLevel(GetAttacker()))/ 3.)))+500.),GetUnitLoc(GetTriggerUnit()),Condition(function Trig_liubo101_Func006Func001001003)),function Trig_liubo101_Func006Func001A)
call DestroyGroup(GetLastCreatedGroup())
endif
endfunction
function Trig_liubo102_Conditions takes nothing returns boolean
return(udg_liubo4)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetUnitLifePercent(GetTriggerUnit())<=20.)and(GetRandomReal(1.,10.)<=2.)
endfunction
function Trig_liubo102_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\Human\\Resurrect\\ResurrectCaster.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call SetUnitInvulnerable(GetTriggerUnit(),true)
call SetUnitLifePercentBJ(GetTriggerUnit(),'d')
call TriggerSleepAction(1.)
call SetUnitInvulnerable(GetTriggerUnit(),false)
endfunction
function Trig_liubo103_Conditions takes nothing returns boolean
return(udg_liubo4)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetIssuedOrderId()==851990)
endfunction
function Trig_liubo103_Actions takes nothing returns nothing
call SetUnitPositionLoc(GetTriggerUnit(),GetOrderPointLoc())
endfunction
function Trig_liubo104_Conditions takes nothing returns boolean
return(udg_liubo4)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetRandomInt(1,'d')<=2)
endfunction
function Trig_liubo104_Func001001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_liubo104_Func001001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetTriggerUnit())))
endfunction
function Trig_liubo104_Func001001003 takes nothing returns boolean
return GetBooleanAnd(Trig_liubo104_Func001001003001(),Trig_liubo104_Func001001003002())
endfunction
function Trig_liubo104_Func001A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\shadowstrike\\shadowstrike.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetTriggerUnit(),GetEnumUnit(),((((I2R(GetHeroStr(GetTriggerUnit(),true))+I2R(GetHeroAgi(GetTriggerUnit(),true)))+I2R(GetHeroInt(GetTriggerUnit(),true)))*SquareRoot(I2R(GetHeroLevel(GetTriggerUnit()))))/ 3.),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_liubo104_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsInRangeOfLocMatching(512.,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_liubo104_Func001001003)),function Trig_liubo104_Func001A)
call DestroyGroup(GetLastCreatedGroup())
endfunction
function Trig_liubo11_Func001Func001Func016C takes nothing returns boolean
return(IsUnitType(GetEnumUnit(),UNIT_TYPE_HERO))and(GetOwningPlayer(GetEnumUnit())==Player(4))and(GetUnitTypeId(GetEnumUnit())!='O00M')
endfunction
function Trig_liubo11_Func001Func001C takes nothing returns boolean
return(Trig_liubo11_Func001Func001Func016C())
endfunction
function Trig_liubo11_Func001A takes nothing returns nothing
if(Trig_liubo11_Func001Func001C())then
set udg_liubo5=true
call EnableTrigger(gg_trg_liubo111)
call EnableTrigger(gg_trg_liubo112)
call EnableTrigger(gg_trg_liubo113)
call PanCameraToTimedLocForPlayer(Player(4),GetUnitLoc(GetEnumUnit()),0)
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,10.,(GetPlayerName(GetTriggerPlayer())+"|CFF00FF00开启了无界隐藏技能模式|R|CFFFFFF00光之神领域|R|CFF00FF00,关注诸神的领域开启方法"))
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,10.,"|C00FF00FF关注：bbs.07073.com/wujie")
call SetUnitVertexColor(GetEnumUnit(),255,255,0,255)
call SetUnitMoveSpeed(GetEnumUnit(),522.)
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\Monsoon\\MonsoonRain.mdl")
call CreateTextTagUnitBJ("诸神领域-liubo11",GetEnumUnit(),0,20.,100.,100.,.0,0)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,90.,90.)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
call SetTextTagFadepoint(bj_lastCreatedTextTag,1.)
endif
endfunction
function Trig_liubo11_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(Player(4)),function Trig_liubo11_Func001A)
endfunction
function Trig_liubo111_Conditions takes nothing returns boolean
return(GetOwningPlayer(GetAttacker())==Player(4))and(IsUnitType(GetAttacker(),UNIT_TYPE_HERO))and(IsUnitEnemy(GetTriggerUnit(),Player(4)))and(udg_liubo5)
endfunction
function Trig_liubo111_Func006Func001001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_liubo111_Func006Func001001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_liubo111_Func006Func001001003 takes nothing returns boolean
return GetBooleanAnd(Trig_liubo111_Func006Func001001003001(),Trig_liubo111_Func006Func001001003002())
endfunction
function Trig_liubo111_Func006Func001A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\Holyliubo9\\Holyliubo9SpecialArt.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((((I2R(GetHeroStr(GetAttacker(),true))+I2R(GetHeroAgi(GetAttacker(),true)))+I2R(GetHeroInt(GetAttacker(),true)))*SquareRoot(I2R(GetHeroLevel(GetAttacker()))))*GetRandomReal(1.,5.)),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_liubo111_Func006C takes nothing returns boolean
return(GetRandomInt(1,1000)<=((R2I(SquareRoot(I2R(GetHeroInt(GetAttacker(),true))))/ 3)+'d'))
endfunction
function Trig_liubo111_Actions takes nothing returns nothing
if(Trig_liubo111_Func006C())then
call ForGroupBJ(GetUnitsInRangeOfLocMatching((SquareRoot((I2R(GetHeroInt(GetAttacker(),true))*(I2R(GetHeroLevel(GetAttacker()))/ 3.)))+500.),GetUnitLoc(GetTriggerUnit()),Condition(function Trig_liubo111_Func006Func001001003)),function Trig_liubo111_Func006Func001A)
call DestroyGroup(GetLastCreatedGroup())
endif
endfunction
function Trig_liubo112_Conditions takes nothing returns boolean
return(udg_liubo5)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetUnitLifePercent(GetTriggerUnit())<=20.)and(GetRandomReal(1.,10.)<=2.)
endfunction
function Trig_liubo112_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\Human\\Resurrect\\ResurrectCaster.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call SetUnitInvulnerable(GetTriggerUnit(),true)
call SetUnitLifePercentBJ(GetTriggerUnit(),'d')
call TriggerSleepAction(1.)
call SetUnitInvulnerable(GetTriggerUnit(),false)
endfunction
function Trig_liubo113_Conditions takes nothing returns boolean
return(udg_liubo5)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetIssuedOrderId()==851990)
endfunction
function Trig_liubo113_Actions takes nothing returns nothing
call SetUnitPositionLoc(GetTriggerUnit(),GetOrderPointLoc())
endfunction
function Trig_liubo114_Conditions takes nothing returns boolean
return(udg_liubo5)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetRandomInt(1,'d')<=2)
endfunction
function Trig_liubo114_Func001001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_liubo114_Func001001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetTriggerUnit())))
endfunction
function Trig_liubo114_Func001001003 takes nothing returns boolean
return GetBooleanAnd(Trig_liubo114_Func001001003001(),Trig_liubo114_Func001001003002())
endfunction
function Trig_liubo114_Func001A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\Innerliubo7\\Innerliubo7Target.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetTriggerUnit(),GetEnumUnit(),((((I2R(GetHeroStr(GetTriggerUnit(),true))+I2R(GetHeroAgi(GetTriggerUnit(),true)))+I2R(GetHeroInt(GetTriggerUnit(),true)))*SquareRoot(I2R(GetHeroLevel(GetTriggerUnit()))))/ 3.),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_liubo114_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsInRangeOfLocMatching(512.,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_liubo114_Func001001003)),function Trig_liubo114_Func001A)
call DestroyGroup(GetLastCreatedGroup())
endfunction
function Trig_liubo12_Func001Func001Func016C takes nothing returns boolean
return(IsUnitType(GetEnumUnit(),UNIT_TYPE_HERO))and(GetOwningPlayer(GetEnumUnit())==Player(5))and(GetUnitTypeId(GetEnumUnit())!='O00M')
endfunction
function Trig_liubo12_Func001Func001C takes nothing returns boolean
return(Trig_liubo12_Func001Func001Func016C())
endfunction
function Trig_liubo12_Func001A takes nothing returns nothing
if(Trig_liubo12_Func001Func001C())then
set udg_liubo6=true
call EnableTrigger(gg_trg_liubo121)
call EnableTrigger(gg_trg_liubo122)
call EnableTrigger(gg_trg_liubo123)
call PanCameraToTimedLocForPlayer(Player(5),GetUnitLoc(GetEnumUnit()),0)
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,10.,(GetPlayerName(GetTriggerPlayer())+"|CFF00FF00开启了无界隐藏技能模式|R|CFFFFAA00风神的领域|R|CFF00FF00,关注诸神的领域开启方法"))
call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,10.,"|C00FF00FF关注：bbs.07073.com/wujie")
call SetUnitVertexColor(GetEnumUnit(),255,170,0,255)
call SetUnitMoveSpeed(GetEnumUnit(),522.)
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\Tornado\\Tornado_Target.mdl")
call CreateTextTagUnitBJ("|CFFFFAA00诸神领域-liubo12|R",GetEnumUnit(),0,20.,100.,100.,100.,0)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,90.,90.)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
call SetTextTagFadepoint(bj_lastCreatedTextTag,1.)
endif
endfunction
function Trig_liubo12_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(Player(5)),function Trig_liubo12_Func001A)
endfunction
function Trig_liubo121_Conditions takes nothing returns boolean
return(GetOwningPlayer(GetAttacker())==Player(5))and(IsUnitEnemy(GetTriggerUnit(),Player(5)))and(IsUnitType(GetAttacker(),UNIT_TYPE_HERO))and(udg_liubo6)
endfunction
function Trig_liubo121_Func006Func001001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_liubo121_Func006Func001001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_liubo121_Func006Func001001003 takes nothing returns boolean
return GetBooleanAnd(Trig_liubo121_Func006Func001001003001(),Trig_liubo121_Func006Func001001003002())
endfunction
function Trig_liubo121_Func006Func001A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\Tornado\\TornadoElementalSmall.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((((I2R(GetHeroStr(GetAttacker(),true))+I2R(GetHeroAgi(GetAttacker(),true)))+I2R(GetHeroInt(GetAttacker(),true)))*SquareRoot(I2R(GetHeroLevel(GetAttacker()))))*GetRandomReal(1.,5.)),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_liubo121_Func006C takes nothing returns boolean
return(GetRandomInt(1,1000)<=((R2I(SquareRoot(I2R(GetHeroInt(GetAttacker(),true))))/ 3)+'d'))
endfunction
function Trig_liubo121_Actions takes nothing returns nothing
if(Trig_liubo121_Func006C())then
call ForGroupBJ(GetUnitsInRangeOfLocMatching((SquareRoot((I2R(GetHeroInt(GetAttacker(),true))*(I2R(GetHeroLevel(GetAttacker()))/ 3.)))+500.),GetUnitLoc(GetTriggerUnit()),Condition(function Trig_liubo121_Func006Func001001003)),function Trig_liubo121_Func006Func001A)
call DestroyGroup(GetLastCreatedGroup())
endif
endfunction
function Trig_liubo122_Conditions takes nothing returns boolean
return(udg_liubo6)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetUnitLifePercent(GetTriggerUnit())<=20.)and(GetRandomReal(1.,10.)<=2.)
endfunction
function Trig_liubo122_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\Human\\Resurrect\\ResurrectCaster.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call SetUnitInvulnerable(GetTriggerUnit(),true)
call SetUnitLifePercentBJ(GetTriggerUnit(),'d')
call TriggerSleepAction(1.)
call SetUnitInvulnerable(GetTriggerUnit(),false)
endfunction
function Trig_liubo123_Conditions takes nothing returns boolean
return(udg_liubo6)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetIssuedOrderId()==851990)
endfunction
function Trig_liubo123_Actions takes nothing returns nothing
call SetUnitPositionLoc(GetTriggerUnit(),GetOrderPointLoc())
endfunction
function Trig_liubo124_Conditions takes nothing returns boolean
return(udg_liubo6)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO))and(GetRandomInt(1,'d')<=2)
endfunction
function Trig_liubo124_Func001001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_liubo124_Func001001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetTriggerUnit())))
endfunction
function Trig_liubo124_Func001001003 takes nothing returns boolean
return GetBooleanAnd(Trig_liubo124_Func001001003001(),Trig_liubo124_Func001001003002())
endfunction
function Trig_liubo124_Func001A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\Cyclone\\CycloneTarget.mdl")
call DestroyEffect(bj_lastCreatedEffect)
call UnitDamageTargetBJ(GetTriggerUnit(),GetEnumUnit(),((((I2R(GetHeroStr(GetTriggerUnit(),true))+I2R(GetHeroAgi(GetTriggerUnit(),true)))+I2R(GetHeroInt(GetTriggerUnit(),true)))*SquareRoot(I2R(GetHeroLevel(GetTriggerUnit()))))/ 3.),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_liubo124_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsInRangeOfLocMatching(512.,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_liubo124_Func001001003)),function Trig_liubo124_Func001A)
call DestroyGroup(GetLastCreatedGroup())
endfunction
