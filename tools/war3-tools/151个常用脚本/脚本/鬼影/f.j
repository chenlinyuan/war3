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
local real SH=.0
local string array k
set k[1]="Abilities\\Spells\\NightElf\\Blink\\BlinkTarget.mdl"
set k[2]="Abilities\\Spells\\Items\\AIil\\AIilTarget.mdl"
set k[3]="Units\\Demon\\Infernal\\InfernalBirth.mdl"
set k[4]="Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl"
set k[5]="Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl"
set k[6]="Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl"
set k[7]="Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl"
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
if((GetRandomInt(1,4))==1)then
set g=CreateGroup()
set bx=Condition(function CVB)
call GroupEnumUnitsInRange(g,GetUnitX(u),GetUnitY(u),fw,bx)
loop
set ua=FirstOfGroup(g)
exitwhen ua==null
call UnitDamageTarget(u,ua,sh,true,false,null,null,null)
call DestroyEffect(AddSpecialEffectTarget(k[1],ua,"origin"))
call DestroyEffect(AddSpecialEffectTarget(k[2],ua,"origin"))
call GroupRemoveUnit(g,ua)
endloop
call DestroyBoolExpr(bx)
call DestroyGroup(g)
set u=null
set ua=null
set g=null
set bx=null
endif
if((GetRandomInt(1,4))==2)then
set g=CreateGroup()
set bx=Condition(function CVB)
call GroupEnumUnitsInRange(g,GetUnitX(u),GetUnitY(u),fw,bx)
loop
set ua=FirstOfGroup(g)
exitwhen ua==null
call UnitDamageTarget(u,ua,(GetUnitState(ua,UNIT_STATE_MAX_LIFE))/4,true,false,null,null,null)
call DestroyEffect(AddSpecialEffectTarget(k[3],ua,"origin"))
call DestroyEffect(AddSpecialEffectTarget(k[4],ua,"origin"))
call GroupRemoveUnit(g,ua)
endloop
call DestroyBoolExpr(bx)
call DestroyGroup(g)
set u=null
set ua=null
set g=null
set bx=null
endif
if((GetRandomInt(1,4))==4)then
set g=CreateGroup()
set bx=Condition(function CVB)
call GroupEnumUnitsInRange(g,GetUnitX(u),GetUnitY(u),fw,bx)
loop
set ua=FirstOfGroup(g)
exitwhen ua==null
call UnitDamageTarget(u,ua,sh,true,false,null,null,null)
call DestroyEffect(AddSpecialEffectTarget(k[5],ua,"origin"))
call DestroyEffect(AddSpecialEffectTarget(k[6],ua,"origin"))
call GroupRemoveUnit(g,ua)
endloop
call DestroyBoolExpr(bx)
call DestroyGroup(g)
set u=null
set ua=null
set g=null
set bx=null
endif
if((GetRandomInt(1,4))==3)then
set ua=GetTriggerUnit()
call UnitDamageTarget(u,ua,GetUnitState(ua,UNIT_STATE_MAX_LIFE),true,false,null,null,null)
call DestroyEffect(AddSpecialEffectTarget(k[7],ua,"overhead"))
call ModifyHeroStat(0,u,0,(GetHeroStr(u,false)/ 10))
call ModifyHeroStat(1,u,0,(GetHeroAgi(u,false)/ 10))
call ModifyHeroStat(2,u,0,(GetHeroInt(u,false)/ 10))
set u=null
set ua=null
endif
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
set p=GetUnitLoc(ua)
call SetUnitPositionLoc(u,p)
call RemoveLocation(p)
set p=null
call SetUnitFacing(u,(180.-GetUnitFacing(ua)))
call CreateTextTagUnitBJ(("|cFF330033"+I2S(i)),ua,0,10,.0,'d',.0,0)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,64,90)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,2.)
call UnitDamageTarget(u,ua,(Str+Agi*Bc)*Level,true,false,null,null,null)
set ub=FirstOfGroup(g)
if(ub==null)then
call SetUnitPathing(u,true)
call SelectUnitForPlayerSingle(u,GetOwningPlayer(u))
call PauseUnit(u,false)
call SetUnitVertexColor(u,255,255,255,255)
endif
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
call GY_Zc(GetTriggerPlayer(),("|cff0080FF天煞-|cff00FF00现世|r"+""))
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
call GY_Zc(GetTriggerPlayer(),("|cff0080FF天煞-|cff00FF00归隐|r"+""))
else
call ForceAddPlayer(GY_PlayerA,GetTriggerPlayer())
call GY_Zc(GetTriggerPlayer(),("|cff0080FF天煞-|cff00FF00现世|r"+""))
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
if(IsUnitType(u,ConvertUnitType(0)))then
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
if(GetEventPlayerChatString()=="qjn")then
if(IsUnitInGroup(u,GY_group[6]))then
call GroupRemoveUnit(GY_group[6],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF关闭爆斩技能|r")+""))
else
call GroupAddUnit(GY_group[6],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF开启爆斩技能|r")+""))
endif
if(IsUnitInGroup(u,GY_group[7]))then
call GroupRemoveUnit(GY_group[7],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF关闭瞬斩技能|r")+""))
else
call GroupAddUnit(GY_group[7],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF开启瞬斩技能|r")+""))
endif
if(IsUnitInGroup(u,GY_group[10]))then
call GroupRemoveUnit(GY_group[10],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF关闭连爆技能|r")+""))
else
call GroupAddUnit(GY_group[10],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF开启连爆技能|r")+""))
endif
if(IsUnitInGroup(u,GY_group[8]))then
call GroupRemoveUnit(GY_group[8],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF关闭光线技能|r")+""))
else
call GroupAddUnit(GY_group[8],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF开启光线技能|r")+""))
endif
if(IsUnitInGroup(u,GY_group[9]))then
call GroupRemoveUnit(GY_group[9],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF关闭乱舞技能|r")+""))
else
call GroupAddUnit(GY_group[9],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF开启乱舞技能|r")+""))
endif
if(IsPlayerInForce(GZ_Pp,GY_PlayerB[9]))then
call ForceRemovePlayer(GY_PlayerB[9],GZ_Pp)
set GY_BX[(1+GetPlayerId(GZ_Pp))]=false
call GY_zc((((((Vb+GY_ZS6)+Va)+"|cff0080FF关闭穿刺技能|r")+"")+""))
else
call ForceAddPlayer(GY_PlayerB[9],GZ_Pp)
set GY_BX[(1+GetPlayerId(GZ_Pp))]=true
call GY_zc((((((Vb+GY_ZS6)+Va)+"|cff0080FF开启穿刺技能|r")+"")+""))
endif
endif
if(GetEventPlayerChatString()=="lbj")then
if(IsUnitInGroup(u,GY_group[10]))then
call GroupRemoveUnit(GY_group[10],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF关闭连爆技能|r")+""))
else
call GroupAddUnit(GY_group[10],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF开启连爆技能|r")+""))
endif
endif
if(GetEventPlayerChatString()=="bzj")then
if(IsUnitInGroup(u,GY_group[6]))then
call GroupRemoveUnit(GY_group[6],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF关闭爆斩技能|r")+""))
else
call GroupAddUnit(GY_group[6],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF开启爆斩技能|r")+""))
endif
endif
if(GetEventPlayerChatString()=="szj")then
if(IsUnitInGroup(u,GY_group[7]))then
call GroupRemoveUnit(GY_group[7],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF关闭瞬斩技能|r")+""))
else
call GroupAddUnit(GY_group[7],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF开启瞬斩技能|r")+""))
endif
endif
if(GetEventPlayerChatString()=="gxj")then
if(IsUnitInGroup(u,GY_group[8]))then
call GroupRemoveUnit(GY_group[8],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF关闭光线技能|r")+""))
else
call GroupAddUnit(GY_group[8],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF开启光线技能|r")+""))
endif
endif
if(GetEventPlayerChatString()=="lwj")then
if(IsUnitInGroup(u,GY_group[9]))then
call GroupRemoveUnit(GY_group[9],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF关闭乱舞技能|r")+""))
else
call GroupAddUnit(GY_group[9],u)
call GY_zc((((((Vb+GY_ZS6)+Va)+GY_ZS7)+"|r |cff0080FF开启乱舞技能|r")+""))
endif
endif

if(GetEventPlayerChatString()=="ccj")then
if(IsPlayerInForce(GZ_Pp,GY_PlayerB[9]))then
call ForceRemovePlayer(GY_PlayerB[9],GZ_Pp)
set GY_BX[(1+GetPlayerId(GZ_Pp))]=false
call GY_zc((((((Vb+GY_ZS6)+Va)+"|cff0080FF关闭穿刺技能|r")+"")+""))
else
call ForceAddPlayer(GY_PlayerB[9],GZ_Pp)
set GY_BX[(1+GetPlayerId(GZ_Pp))]=true
call GY_zc((((((Vb+GY_ZS6)+Va)+"|cff0080FF开启穿刺技能|r")+"")+""))
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
if(GZ_chat=="ID")then
if(IsPlayerInForce(GZ_pP,GY_PlayerB[8]))then
call ForceRemovePlayer(GY_PlayerB[8],GZ_pP)
call GY_zc(("|cFF33FF66关|r|cFF0041FF闭|r|cFF1BE6B8显|r|cFF530080示|r"+"|cFFFFFF00I|r|cFFFE9FD8D|r"))
else
call ForceAddPlayer(GY_PlayerB[8],GZ_pP)
call GY_zc(("|cFF33FF66开|r|cFF0041FF启|r|cFF1BE6B8显|r|cFF530080示|r"+"|cFFFFFF00I|r|cFFFE9FD8D|r"))
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
call TriggerRegisterPlayerChatEvent(t,Player(i),"鬼影",true)
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