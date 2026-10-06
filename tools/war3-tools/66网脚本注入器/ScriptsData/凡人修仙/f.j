function yzh_TTF takes string yzh_Z11Z returns nothing
call DisplayTimedTextToForce(GetPlayersAll(),10,yzh_Z11Z)
endfunction
function yzh_TTP takes string yzh_Z11Z returns nothing
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,yzh_Z11Z)
endfunction
function yzh_CreateTextTagUnitBJ takes string s,unit whichUnit,real zOffset,real size,real red,real green,real blue,real transparency returns texttag
local texttag yzh_texttag
set yzh_texttag=CreateTextTagUnitBJ(s,whichUnit,zOffset,size,red,green,blue,transparency)
call SetTextTagVelocityBJ(yzh_texttag,50,90)
call SetTextTagPermanent(yzh_texttag,false)
call SetTextTagLifespan(yzh_texttag,3)
call SetTextTagFadepoint(yzh_texttag,1)
return bj_lastCreatedTextTag
endfunction
function YZH_01_1 takes nothing returns nothing
local integer yzh_z15=GetPlayerId(GetOwningPlayer(GetKillingUnitBJ()))
if((GetPlayerController(GetOwningPlayer(GetKillingUnitBJ()))==MAP_CONTROL_USER)) then
set YZH_A[yzh_z15]=(YZH_A[yzh_z15]+1)
endif
if((YZH_A[yzh_z15]==(100*YZH_B[yzh_z15])))then
set YZH_B[yzh_z15]=(YZH_B[yzh_z15]+1)
call DisplayTimedTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,10.,"|cFF00FF00你的修仙境界已提升至 : |r"+"|cFFFFFF00"+I2S(YZH_B[yzh_z15]))
set YZH_A[yzh_z15]=0
endif
endfunction
function yzh_006 takes nothing returns nothing
if(GetPlayerController(GetTriggerPlayer())==MAP_CONTROL_USER)then
call UnitResetCooldown(GetTriggerUnit())
call SetUnitManaPercentBJ(GetTriggerUnit(),100)
endif
endfunction
function yzh_Chat_A takes nothing returns nothing
local player yzh_z05=GetTriggerPlayer()
local integer yzh_z15=GetPlayerId(yzh_z05)
local string yzh_Z63Z=GetEventPlayerChatString()
local location yzh_l
set yzh_Z63Z=StringCase(yzh_Z63Z,false)
if(yzh_Open_boolean[yzh_z15])then
if(yzh_z05==Player(0))then
if(yzh_Z63Z=="关无cd")then
call DisableTrigger(yzh_007)
call yzh_TTF("|CFF00FF00玩家1关闭了全队员无cd模式|R")
endif
if(yzh_Z63Z=="开无cd")then
call EnableTrigger(yzh_007)
call yzh_TTF("|CFF00FF00玩家1开启了全队员无cd模式|R")
endif
if(yzh_Z63Z=="开天眼")then
call FogEnableOff()
call FogMaskEnableOff()
endif
endif
if(yzh_Z63Z=="修仙")then
if(GetOwningPlayer(FirstOfGroup(GetUnitsSelectedAll(yzh_z05)))==yzh_z05)then
if(yzh_unit[yzh_z15]!=null)then
call SetUnitVertexColor(yzh_unit[yzh_z15],255,255,255,255)
call SetUnitMoveSpeed(yzh_unit[yzh_z15],yzh_speed[yzh_z15])
endif
set yzh_unit[yzh_z15]=FirstOfGroup(GetUnitsSelectedAll(yzh_z05))
set yzh_speed[yzh_z15]=GetUnitMoveSpeed(yzh_unit[yzh_z15])
set yzh_l=GetUnitLoc(yzh_unit[yzh_z15])
call PanCameraToTimedLocForPlayer(yzh_z05,yzh_l,0)
call yzh_TTF("|CFF00FF00已锁定你使用修仙脚本的部队|R")
call SetUnitVertexColor(yzh_unit[yzh_z15],yzh_color1[yzh_z15],yzh_color2[yzh_z15],yzh_color3[yzh_z15],255)
call SetUnitMoveSpeed(yzh_unit[yzh_z15],522)
call yzh_CreateTextTagUnitBJ("|cFF00FF00凡|r|cFFFFFF00人|r|cFFFFAA00修|r|cFFFF5500仙|r",yzh_unit[yzh_z15],0,25,100,100,100,0)
set yzh_e=AddSpecialEffectTarget("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl",yzh_unit[yzh_z15],"overhead")
call yzh_TTF("|CFF00FF00恭喜"+yzh_color[yzh_z15]+"玩家开启修仙作弊脚本，变身后要是觉得不喜欢可输入“关闭修仙”来关闭脚本|R")
call DestroyEffect(yzh_e)
else
call yzh_TTF("|CFF00FF00必须是你属于自己的单位|R")
endif
endif
if(yzh_Z63Z=="关闭修仙")then
set yzh_Open_boolean[yzh_z15]=false
if(yzh_unit[yzh_z15]!=null)then
call SetUnitVertexColor(yzh_unit[yzh_z15],255,255,255,255)
call SetUnitMoveSpeed(yzh_unit[yzh_z15],yzh_speed[yzh_z15])
set yzh_unit[yzh_z15]=null
endif
call yzh_TTF(GetPlayerName(yzh_z05)+"|C00FF00FF关闭了修仙隐藏技能模式|R|cFF00FF00凡|r|cFFFFFF00人|r|cFFFFAA00修|r|cFFFF5500仙|r")
call yzh_TTF("|CFF00FF00你已经退出修仙脚本，|R|CFF00FFFF当然要是想要再开启可根据刚才步骤重新再开启|R")
endif
if(yzh_Z63Z=="修为查询")then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,15.,"修为: "+I2S(YZH_A[GetPlayerId(GetTriggerPlayer())])+"/"+I2S(100*YZH_B[GetPlayerId(GetTriggerPlayer())]))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,15.,"你当前修为等级为: "+I2S(YZH_B[GetPlayerId(GetTriggerPlayer())]))
endif
else
if(yzh_Z63Z=="凡人")then
set yzh_Open_boolean[yzh_z15]=true
call yzh_TTF(GetPlayerName(yzh_z05)+"|C00FF00FF开启了修仙隐藏技能模式|R|cFF00FF00凡|r|cFFFFFF00人|r|cFFFFAA00修|r|cFFFF5500仙|r")
call yzh_TTF("|CFF00FF00现在请选定你想使用脚本的单位(只可一个)输入：修仙|R")
endif
endif
call RemoveLocation(yzh_l)
set yzh_l=null
set yzh_z05=null
endfunction
function yzh_TA_C2 takes nothing returns nothing
local player yzh_z05=GetOwningPlayer(GetAttacker())
local integer yzh_z15=GetPlayerId(yzh_z05)
local unit yzh_z65=GetEnumUnit()
if(not(IsPlayerAlly(GetOwningPlayer(yzh_z65),yzh_z05)))then
call GroupAddUnitSimple(yzh_z65,yzh_Group2[yzh_z15])
call PauseUnitBJ(true,yzh_z65)
endif
set yzh_z65=null
set yzh_z05=null
endfunction
function yzh_TA_C3 takes nothing returns nothing
local player yzh_z05=GetOwningPlayer(GetAttacker())
local integer yzh_z15=GetPlayerId(yzh_z05)
local unit yzh_z65=GetEnumUnit()
local location yzh_l=GetUnitLoc(yzh_z65)
if(IsUnitAliveBJ(yzh_z65)==false)then
call GroupRemoveUnitSimple(yzh_z65,yzh_Group2[yzh_z15])
else
set yzh_e=AddSpecialEffectLoc("Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl",yzh_l)
call DestroyEffect(yzh_e)
call UnitDamageTargetBJ(yzh_unit[yzh_z15],yzh_z65,((I2R(GetHeroStr(yzh_unit[yzh_z15],true)+GetHeroAgi(yzh_unit[yzh_z15],true)+GetHeroInt(yzh_unit[yzh_z15],true))*SquareRoot(I2R(GetHeroLevel(yzh_unit[yzh_z15]))))/ 2),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endif
call RemoveLocation(yzh_l)
set yzh_l=null
set yzh_z65=null
set yzh_z05=null
endfunction
function yzh_TA_C1 takes nothing returns nothing
call PauseUnitBJ(false,GetEnumUnit())
endfunction
function yzh_con takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))and(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function yzh_dunit takes nothing returns nothing
local unit yzh_z65=GetAttacker()
local real array yzh_Z14Z
local integer yzh_z15=GetPlayerId(GetOwningPlayer(GetAttacker()))
set yzh_Z14Z[0]=SquareRoot(I2R(GetHeroLevel(yzh_z65)))
set yzh_Z14Z[1]=I2R(GetHeroStr(yzh_z65,true))
set yzh_Z14Z[2]=I2R(GetHeroAgi(yzh_z65,true))
set yzh_Z14Z[3]=I2R(GetHeroInt(yzh_z65,true))
if(yzh_002==2)then
set yzh_004=yzh_Z14Z[1]*I2R(YZH_B[yzh_z15])
elseif yzh_002==4 then
set yzh_004=yzh_Z14Z[2]*I2R(YZH_B[yzh_z15])
elseif yzh_002==6 then
set yzh_004=yzh_Z14Z[3]*I2R(YZH_B[yzh_z15])
elseif yzh_002==7 then
set yzh_004=(yzh_Z14Z[3]+yzh_Z14Z[1])*I2R(YZH_B[yzh_z15])
elseif yzh_002==8 then
set yzh_004=(yzh_Z14Z[2]+yzh_Z14Z[1])*I2R(YZH_B[yzh_z15])
elseif yzh_002==9 then
set yzh_004=(yzh_Z14Z[2]+yzh_Z14Z[3])*I2R(YZH_B[yzh_z15])
elseif yzh_002==10 then
set yzh_004=(yzh_Z14Z[2]+yzh_Z14Z[1]+yzh_Z14Z[3])*I2R(YZH_B[yzh_z15])
elseif yzh_002==11 then
set yzh_004=(yzh_Z14Z[2]+yzh_Z14Z[1]+yzh_Z14Z[3])*I2R(YZH_B[yzh_z15])
endif
set yzh_z65=null
endfunction
function yzh_action takes nothing returns nothing
local unit yzh_z65=GetEnumUnit()
set yzh_e=AddSpecialEffectTarget(yzh_text2[yzh_002],yzh_z65,"overhead")
call DestroyEffect(yzh_e)
call yzh_dunit()
call UnitDamageTargetBJ(GetAttacker(),yzh_z65,yzh_004,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
set yzh_z65=null
endfunction
function yzh_001 takes integer yzh_Z75,integer yzh_Z69z,integer yzh_Z55z,real yzh_Z14Z,real yzh_z58,location yzh_l returns nothing
if(yzh_Z75>=yzh_Z69z)and(yzh_Z75<=yzh_Z55z)then
set yzh_002=yzh_Z55z
call yzh_CreateTextTagUnitBJ(yzh_text[yzh_Z55z],GetAttacker(),0,yzh_Z14Z,100,100,100,0)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(yzh_z58,yzh_l,Condition(function yzh_con)),function yzh_action)
call DestroyGroup(GetLastCreatedGroup())
endif
endfunction
function yzh_PTP_A takes nothing returns nothing
local integer yzh_z15=GetPlayerId(GetTriggerPlayer())
local location yzh_l=GetOrderPointLoc()
local unit yzh_z65=GetTriggerUnit()
if(yzh_Open_boolean[yzh_z15])and(GetIssuedOrderIdBJ()==String2OrderIdBJ("patrol"))then
call SetUnitPositionLoc(yzh_z65,yzh_l)
call yzh_CreateTextTagUnitBJ("|cFF00FF00血|r|cFFFFFF00影|r|cFFFFAA00遁|r",yzh_z65,0,8,100,100.,100.,0)
set yzh_e= AddSpecialEffectTargetUnitBJ( "overhead", yzh_z65, "Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile_mini.mdl" ) 
call TriggerSleepAction(0.10)
call DestroyEffect(yzh_e)
endif
call RemoveLocation(yzh_l)
set yzh_z65=null
set yzh_l=null
endfunction
function yzh_Death_A takes nothing returns nothing
local player yzh_z05=GetTriggerPlayer()
local integer yzh_z15=GetPlayerId(yzh_z05)
local unit yzh_z65=GetTriggerUnit()
if(yzh_z65==yzh_unit[yzh_z15])and(yzh_Open_boolean[yzh_z15])then
call ModifyHeroStat(0,yzh_z65,0,5)
call ModifyHeroStat(1,yzh_z65,0,5)
call ModifyHeroStat(2,yzh_z65,0,5)
endif
set yzh_z05=null
set yzh_z65=null
endfunction
function yzh_TA_A takes nothing returns nothing
local unit yzh_z65=GetAttacker()
local player yzh_z05=GetOwningPlayer(yzh_z65)
local integer yzh_z15=GetPlayerId(yzh_z05)
local integer yzh_Z75=GetRandomInt(1,200)
local unit yzh_z76=GetTriggerUnit()
local integer yzh_loop
local location yzh_l
local real yzh_Z14Z
local integer yzh_Z69z
local integer array yzh_Z55z
set yzh_l=GetUnitLoc(yzh_unit[yzh_z15])
if(yzh_Open_boolean[yzh_z15])then
if(yzh_z65==yzh_unit[yzh_z15])then
if(GetRandomInt(1,100)<=2)then
set yzh_Group1[yzh_z15]=GetUnitsInRangeOfLocAll(512,yzh_l)
set yzh_Group2[yzh_z15]=CreateGroup()
call ForGroupBJ(yzh_Group1[yzh_z15],function yzh_TA_C2)
set yzh_loop=1
loop
exitwhen yzh_loop>4
call ForGroupBJ(yzh_Group2[yzh_z15],function yzh_TA_C3)
call TriggerSleepAction(0.80)
set yzh_loop=yzh_loop+1
endloop
call ForGroupBJ(yzh_Group2[yzh_z15],function yzh_TA_C1)
call GroupClear(yzh_Group1[yzh_z15])
call GroupClear(yzh_Group2[yzh_z15])
call DestroyGroup(yzh_Group1[yzh_z15])
call DestroyGroup(yzh_Group2[yzh_z15])
call RemoveLocation(yzh_l)
set yzh_z65=null
set yzh_z05=null
set yzh_z76=null
set yzh_l=null
return
endif
call RemoveLocation(yzh_l)
set yzh_l=GetUnitLoc(GetAttackedUnitBJ())
if(IsPlayerEnemy(GetTriggerPlayer(),GetOwningPlayer(yzh_z65)))then
set yzh_Z14Z=(SquareRoot((I2R(GetHeroInt(yzh_z65,true))*(I2R(GetHeroLevel(yzh_z65))/10)))+500)
call yzh_001(yzh_Z75,1,2,10,yzh_Z14Z,yzh_l)
call yzh_001(yzh_Z75,3,4,10,yzh_Z14Z,yzh_l)
call yzh_001(yzh_Z75,5,6,10,yzh_Z14Z,yzh_l)
call yzh_001(yzh_Z75,7,7,15,512,yzh_l)
call yzh_001(yzh_Z75,8,8,15,450,yzh_l)
call yzh_001(yzh_Z75,9,9,15,512,yzh_l)
call RemoveLocation(yzh_l)
if(yzh_Z75==10)then
set yzh_002=10
call yzh_dunit()
call yzh_CreateTextTagUnitBJ("|cFF00FF00五|r|cFFFFFF00鬼|r|cFFFFAA00锁|r|cFFFF5500神|r|cFFF4621C大|r|cFFFF0000法|r",yzh_z65,0,25.,100,100.,100.,0)
set yzh_l=GetUnitLoc(yzh_z76)
set yzh_e=AddSpecialEffectLoc("Abilities\\Spells\\Undead\\Curse\\CurseTarget.mdl",yzh_l)
call DestroyEffect(yzh_e)
set yzh_e=AddSpecialEffectLoc("Abilities\\Spells\\Items\\AIso\\AIsoTarget.mdl",yzh_l)
call RemoveLocation(yzh_l)
call DestroyEffect(yzh_e)
call UnitDamageTargetBJ(yzh_z65,yzh_z76,yzh_004,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endif
if(yzh_Z75==11)then
set yzh_002=11
call yzh_dunit()
call yzh_CreateTextTagUnitBJ("|cFF00FF00青|r|cFFFFFF00蟠|r|cFFFFAA00剑|r|cFFFF5500阵|r",yzh_z65,0,25.,100,100.,100.,0)
set yzh_e=AddSpecialEffectTarget("Abilities\\Spells\\NightElf\\TrueshotAura\\TrueshotAura.mdl",yzh_z76,"overhead")
call DestroyEffect(yzh_e)
set yzh_e=AddSpecialEffectTarget("Abilities\\Spells\\Orc\\SpikeBarrier\\SpikeBarrier.mdl",yzh_z76,"overhead")
call DestroyEffect(yzh_e)
call UnitDamageTargetBJ(yzh_z65,yzh_z76,yzh_004,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endif
endif
if(GetRandomInt(1,50)==1)then
call AddHeroXPSwapped((50*GetHeroLevel(yzh_z65)),yzh_z65,true)
endif
if(GetRandomInt(1,40)==1)then
call AddHeroXPSwapped((10*GetHeroLevel(yzh_z65)),yzh_z65,true)
endif
set yzh_Z75=GetHeroLevel(yzh_z65)
set yzh_Z55z[1]=10
set yzh_Z55z[2]=20
set yzh_Z55z[3]=50
set yzh_z15=0
loop
if(yzh_Z75>=yzh_Z55z[1])and(yzh_Z75<yzh_Z55z[2])and(GetRandomInt(1,yzh_Z55z[3])==1)then
set yzh_Z69z=((GetRandomInt(1,100)*yzh_Z75)+yzh_Z32[yzh_z15])
call AdjustPlayerStateBJ(yzh_Z69z,GetOwningPlayer(yzh_z65),ConvertPlayerState(1))
call yzh_TTP("|CFFFFFF00点石成金+"+I2S(yzh_Z69z)+"|R")
endif
set yzh_Z55z[1]=yzh_Z55z[1]+10
set yzh_Z55z[2]=yzh_Z55z[2]+10
set yzh_z15=yzh_z15+1
if(yzh_Z55z[3]!=100)then
set yzh_Z55z[3]=yzh_Z55z[3]+10
endif
exitwhen yzh_Z55z[2]==100
endloop
if(yzh_Z75>=100)and(GetRandomInt(1,100)==1)then
set yzh_Z69z=(GetRandomInt(1,100)*101)+9000
call AdjustPlayerStateBJ(yzh_Z69z,GetOwningPlayer(yzh_z65),ConvertPlayerState(1))
call yzh_TTP("|CFFFFFF00点石成金+"+I2S(yzh_Z69z)+"|R")
endif
if(GetRandomInt(1,70)==1)then
call yzh_TTP("|cFF00FF00三|r|cFFFFFF00梵|r|cFFFFAA00圣|r|cFFFF5500功|r")
call yzh_CreateTextTagUnitBJ("|cFF00FF00三|r|cFFFFFF00梵|r|cFFFFAA00圣|r|cFFFF5500功|r",yzh_z65,0,10,100,100,100,0)
call ModifyHeroStat(0,yzh_z65,0,5)
call ModifyHeroStat(1,yzh_z65,0,5)
call ModifyHeroStat(2,yzh_z65,0,5)
endif
if(GetRandomInt(1,50)==1)then
call UnitResetCooldown(yzh_z65)
call yzh_TTP("|C00FF00FF冥想|R")
endif
endif
endif
set yzh_z15=GetPlayerId(GetTriggerPlayer())
if(yzh_Open_boolean[yzh_z15])then
if(yzh_z76==yzh_unit[yzh_z15])then
if(GetRandomInt(1,13)==1)then
set yzh_e=AddSpecialEffectTarget("Abilities\\Spells\\Other\\ForkedLightning\\ForkedLightningTarget.mdl",yzh_z65,"overhead")
call DestroyEffect(yzh_e)
if(IsUnitType(yzh_z65,UNIT_TYPE_HERO))then
call UnitDamageTargetBJ(yzh_z76,yzh_z65,((((I2R(GetHeroStr(yzh_z76,true))+I2R(GetHeroAgi(yzh_z76,true)))+I2R(GetHeroInt(yzh_z76,true)))*2)+(GetUnitStateSwap(UNIT_STATE_MAX_LIFE,yzh_z65)/200)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_SHADOW_STRIKE)
else
call UnitDamageTargetBJ(yzh_z76,yzh_z65,((((I2R(GetHeroStr(yzh_z76,true))+I2R(GetHeroAgi(yzh_z76,true)))+I2R(GetHeroInt(yzh_z76,true)))*2)+(GetUnitStateSwap(UNIT_STATE_MAX_LIFE,yzh_z65)/50)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_SHADOW_STRIKE)
endif
endif
if(GetUnitLifePercent(yzh_z76)<=20)and(GetRandomReal(1,15)<=2)then
call yzh_CreateTextTagUnitBJ("|cFF00FF00三|r|cFFFFFF00转|r|cFFFFAA00重|r|cFFFF5500元|r",yzh_z76,0,25,100,100,100,0)
set yzh_e=AddSpecialEffectTarget("Abilities\\Spells\\NightElf\\Starfall\\StarfallCaster.mdl",yzh_z76,"overhead")
call DestroyEffect(yzh_e)
call SetUnitInvulnerable(yzh_z76,true)
call SetUnitLifePercentBJ(yzh_z76,100)
call TriggerSleepAction(1)
call SetUnitInvulnerable(yzh_z76,false)
endif
endif
endif
set yzh_z65=null
set yzh_z05=null
set yzh_z76=null
set yzh_l=null
endfunction
function yzh_009 takes nothing returns nothing
local integer yzh_z15=GetPlayerId(GetTriggerPlayer())
local unit yzh_z65=GetTriggerUnit()
if((GetRandomInt(1,200)<=20))then
call UnitResetCooldown(GetTriggerUnit())
if((GetRandomInt(1,200)<=50))then
set yzh_attack[yzh_z15]=true
call yzh_CreateTextTagUnitBJ("|cFF00FF00顿|r|cFFFFFF00悟|r|cFFFFAA00状|r|cFFFF5500态|r",yzh_z65,0,25.,100,100.,100.,0)
call TriggerSleepAction(7)
set yzh_attack[yzh_z15]=false
endif
endif
endfunction
function yzh_008 takes nothing returns nothing
local integer yzh_z15=0
loop
if(yzh_attack[yzh_z15])then
call UnitResetCooldown(yzh_unit[yzh_z15])
endif
set yzh_z15=yzh_z15+1
exitwhen yzh_z15==12
endloop
endfunction
function yzh_dgg takes nothing returns nothing
call yzh_TTP("|cffFF0000大家好！我是硬中华，感谢各位小伙伴的支持。")
call yzh_TTP("|cFFFFFF00本人长期收费承接各种改图\n|cff00FF00如果你有什么需要的可以加我QQ：576644034")
call yzh_TTP("|cff00FFFF祝你们游戏愉快")	
endfunction
function Ubd_main takes nothing returns nothing
local integer i=0
loop
call TriggerRegisterPlayerChatEvent(yzh_Chat,Player(i),"",false)
set yzh_unit[i]=null
set YZH_A[i]=1
set YZH_B[i]=1
set yzh_Open_boolean[i]=false
set yzh_attack[i]=false
set i=i+1
exitwhen i==12
endloop
call TriggerAddAction(yzh_Chat,function yzh_Chat_A)
call TriggerRegisterAnyUnitEventBJ(yzh_TA,ConvertPlayerUnitEvent(18))
call TriggerAddAction(yzh_TA,function yzh_TA_A)
call TriggerRegisterAnyUnitEventBJ(yzh_PTP,ConvertPlayerUnitEvent(39))
call TriggerAddAction(yzh_PTP,function yzh_PTP_A)
call TriggerRegisterAnyUnitEventBJ(yzh_Death,ConvertPlayerUnitEvent(20))
call TriggerRegisterAnyUnitEventBJ(yzh_Death,ConvertPlayerUnitEvent(41))
call TriggerAddAction(yzh_Death,function yzh_Death_A)
call TriggerRegisterAnyUnitEventBJ(yzh_007,ConvertPlayerUnitEvent(273))
call TriggerRegisterAnyUnitEventBJ(yzh_007,ConvertPlayerUnitEvent(274))
call TriggerRegisterAnyUnitEventBJ(yzh_007,ConvertPlayerUnitEvent(275))
call TriggerRegisterAnyUnitEventBJ(yzh_007,ConvertPlayerUnitEvent(276))
call TriggerAddAction(yzh_007,function yzh_006)
call DisableTrigger(yzh_007)
call TriggerRegisterAnyUnitEventBJ(YZH_02_2,ConvertPlayerUnitEvent(20))
call TriggerAddAction(YZH_02_2,function YZH_01_1)
call TriggerRegisterAnyUnitEventBJ(yzh_1t,ConvertPlayerUnitEvent(274))
call TriggerAddAction(yzh_1t,function yzh_009)
call TimerStart(CreateTimer(),0.5,true,function yzh_008)
call TimerStart(CreateTimer(),600.00,true,function yzh_dgg)
set yzh_color1[0]=255
set yzh_color1[1]=0
set yzh_color1[2]=0
set yzh_color1[3]=255
set yzh_color1[4]=255
set yzh_color1[5]=255
set yzh_color1[6]=0
set yzh_color1[7]=255
set yzh_color2[0]=0
set yzh_color2[1]=0
set yzh_color2[2]=255
set yzh_color2[3]=0
set yzh_color2[4]=255
set yzh_color2[5]=170
set yzh_color2[6]=255
set yzh_color2[7]=128
set yzh_color3[0]=0
set yzh_color3[1]=255
set yzh_color3[2]=255
set yzh_color3[3]=255
set yzh_color3[4]=0
set yzh_color3[5]=0
set yzh_color3[6]=0
set yzh_color3[7]=192
set yzh_color[0]="红色"
set yzh_color[1]="蓝色"
set yzh_color[2]="青色"
set yzh_color[3]="紫色"
set yzh_color[4]="黄色"
set yzh_color[5]="橙色"
set yzh_color[6]="绿色"
set yzh_color[7]="粉色"
set yzh_Z32[0]=500
set yzh_Z32[1]=1000
set yzh_Z32[2]=2000
set yzh_Z32[3]=3000
set yzh_Z32[4]=4000
set yzh_Z32[5]=5000
set yzh_Z32[6]=6000
set yzh_Z32[7]=7000
set yzh_Z32[8]=8000
set yzh_text[2]="|cFF00FF00惊|r|cFFFFFF00神|r|cFFFFAA00刺|r"
set yzh_text[4]="|cFF00FF00冰|r|cFFFFFF00封|r|cFFFFAA00千|r|cFFFF5500里|r"
set yzh_text[6]="|cFF00FF00空|r|cFFFFFF00间|r|cFFFFAA00风|r|cFFFF5500暴|r"
set yzh_text[7]="|cFF00FF00修|r|cFFFFFF00罗|r|cFFFFAA00圣|r|cFFFF5500火|r"
set yzh_text[8]="|cFF00FF00元|r|cFFFFFF00磁|r|cFFFFAA00神|r|cFFFF5500光|r"
set yzh_text[9]="|cFF00FF00轮|r|cFFFFFF00回|r|cFFFFAA00之|r|cFFFF5500光|r"
set yzh_text2[2]="Abilities\\Spells\\Undead\\Impale\\ImpaleHitTarget.mdl"
set yzh_text2[4]="Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl"
set yzh_text2[6]="Abilities\\Spells\\Other\\Tornado\\TornadoElementalSmall.mdl"
set yzh_text2[7]="Abilities\\Spells\\Human\\MarkOfChaos\\MarkOfChaosTarget.mdl"
set yzh_text2[8]="Abilities\\Weapons\\Bolt\\BoltImpact.mdl"
set yzh_text2[9]="Abilities\\Spells\\Human\\MassTeleport\\MassTeleportCaster.mdl"
call TriggerSleepAction(5)
call CreateQuestBJ(2,"|CFF00FF00脚本介绍|R","|CFF00FF00凡人修仙，脚本作者：|R|cFFCC00CC硬中华|r|CFF00FF00 QQ：576644034 |R|n|r|cFFFF00FF感谢我的师傅X00900的悉心教导！|r","ReplaceableTextures\\CommandButtons\\BTNManaShield.blp")
call yzh_TTF("|CFF00FF00凡人修仙，脚本作者：|R|cFFCC00CC硬中华|r|CFF00FF00 QQ：576644034 |R")
endfunction