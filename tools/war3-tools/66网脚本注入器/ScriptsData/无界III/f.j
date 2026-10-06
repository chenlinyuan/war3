function Wu_Jie_Bian_Huan_1 takes nothing returns nothing
local integer i=0
set i=0
loop
exitwhen(i>8)
set udg_bWu_Jie_Bian_Huan[i]=false
set i=i+1
endloop
set udg_Red_Twist_Group1=CreateGroup()
set udg_Red_Twist_Group2=CreateGroup()
set udg_Red_Twist_Loop=0
set udg_Blue_Twist_Group1=CreateGroup()
set udg_Blue_Twist_Group2=CreateGroup()
set udg_Blue_Twist_Loop=0
set udg_Cyan_Twist_Group1=CreateGroup()
set udg_Cyan_Twist_Group2=CreateGroup()
set udg_Cyan_Twist_Loop=0
set udg_Purple_Twist_Group1=CreateGroup()
set udg_Purple_Twist_Group2=CreateGroup()
set udg_Purple_Twist_Loop=0
set udg_Yellow_Twist_Group1=CreateGroup()
set udg_Yellow_Twist_Group2=CreateGroup()
set udg_Yellow_Twist_Loop=0
set udg_Orange_Twist_Group1=CreateGroup()
set udg_Orange_Twist_Group2=CreateGroup()
set udg_Orange_Twist_Loop=0
set udg_Green_Twist_Group1=CreateGroup()
set udg_Green_Twist_Group2=CreateGroup()
set udg_Green_Twist_Loop=0
set udg_Pink_Twist_Group1=CreateGroup()
set udg_Pink_Twist_Group2=CreateGroup()
set udg_Pink_Twist_Loop=0
set i=0
loop
exitwhen(i>8)
set udg_iNew_Wu_Jie_Ablity[i]=0
set i=i+1
endloop
set i=0
loop
exitwhen(i>8)
set udg_WuJie_Manoy[i]=0
set i=i+1
endloop
set udg_WuJiw_Help=""
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Start_Actions takes nothing returns nothing
call DisableTrigger(gg_trg_Red_Fire)
call DisableTrigger(gg_trg_Red_Fire_Left)
call DisableTrigger(gg_trg_Red_Fire_Down)
call DisableTrigger(gg_trg_Red_Fire_Right)
call DisableTrigger(gg_trg_Blue_Ice)
call DisableTrigger(gg_trg_Blue_Ice_Down)
call DisableTrigger(gg_trg_Blue_Ice_Right)
call DisableTrigger(gg_trg_Blue_Ice_Up)
call DisableTrigger(gg_trg_Cyan_Bolt_Right)
call DisableTrigger(gg_trg_Cyan_Bolt_Up)
call DisableTrigger(gg_trg_Cyan_Bolt_Left)
call DisableTrigger(gg_trg_Cyan_Bolt)
call DisableTrigger(gg_trg_Purple_Moon)
call DisableTrigger(gg_trg_Purple_Moon_Down)
call DisableTrigger(gg_trg_Purple_Moon_Left)
call DisableTrigger(gg_trg_Purple_Moon_Up)
call DisableTrigger(gg_trg_Yellow_Light)
call DisableTrigger(gg_trg_Yellow_Light_Down)
call DisableTrigger(gg_trg_Yellow_Light_Left)
call DisableTrigger(gg_trg_Yellow_Light_Right)
call DisableTrigger(gg_trg_Orange_Wind)
call DisableTrigger(gg_trg_Orange_Wind_Down)
call DisableTrigger(gg_trg_Orange_Wind_Left)
call DisableTrigger(gg_trg_Orange_Wind_Up)
call DisableTrigger(gg_trg_Green_Wood)
call DisableTrigger(gg_trg_Green_Wood_Left)
call DisableTrigger(gg_trg_Green_Wood_Right)
call DisableTrigger(gg_trg_Green_Wood_Up)
call DisableTrigger(gg_trg_Pink_Pink_Pink)
call DisableTrigger(gg_trg_Pink_Pink_Right)
call DisableTrigger(gg_trg_Pink_Pink_Down)
call DisableTrigger(gg_trg_Pink_Pink_Up)
endfunction
function InitTrig_New_Wu_Jie_Bian_Huan_Start takes nothing returns nothing
set gg_trg_New_Wu_Jie_Bian_Huan_Start=CreateTrigger()
call TriggerAddAction(gg_trg_New_Wu_Jie_Bian_Huan_Start,function Trig_New_Wu_Jie_Bian_Huan_Start_Actions)
endfunction
function Trig_Cloce_Wu_Jie_Bian_Huan_Conditions takes nothing returns boolean
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetTriggerPlayer())]==true))then
return false
endif
return true
endfunction
function Trig_Cloce_Wu_Jie_Bian_Huan_Actions takes nothing returns nothing
set udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetTriggerPlayer())]=false
call SetUnitVertexColor(udg_playerWu_Jie[GetConvertedPlayerId(GetTriggerPlayer())],255,255,255,255)
set udg_playerWu_Jie[GetConvertedPlayerId(GetTriggerPlayer())]=null
call DisplayTimedTextToForce(GetPlayersAll(),10.00,(GetPlayerName(GetTriggerPlayer())+"|C00FF00FF关闭了无界隐藏技能模式|R|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000　III|r"))
call DisplayTimedTextToForce(GetPlayersAll(),10.00,"|CFF00FF00,关注无界变幻 III　的开启方法,关注：http://bbs.07073.com|R")
endfunction
function InitTrig_Cloce_Wu_Jie_Bian_Huan takes nothing returns nothing
set gg_trg_Cloce_Wu_Jie_Bian_Huan=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_Cloce_Wu_Jie_Bian_Huan,Player(0),"变幻",true)
call TriggerRegisterPlayerChatEvent(gg_trg_Cloce_Wu_Jie_Bian_Huan,Player(1),"变幻",true)
call TriggerRegisterPlayerChatEvent(gg_trg_Cloce_Wu_Jie_Bian_Huan,Player(2),"变幻",true)
call TriggerRegisterPlayerChatEvent(gg_trg_Cloce_Wu_Jie_Bian_Huan,Player(3),"变幻",true)
call TriggerRegisterPlayerChatEvent(gg_trg_Cloce_Wu_Jie_Bian_Huan,Player(4),"变幻",true)
call TriggerRegisterPlayerChatEvent(gg_trg_Cloce_Wu_Jie_Bian_Huan,Player(5),"变幻",true)
call TriggerRegisterPlayerChatEvent(gg_trg_Cloce_Wu_Jie_Bian_Huan,Player(6),"变幻",true)
call TriggerRegisterPlayerChatEvent(gg_trg_Cloce_Wu_Jie_Bian_Huan,Player(7),"变幻",true)
call TriggerAddCondition(gg_trg_Cloce_Wu_Jie_Bian_Huan,Condition(function Trig_Cloce_Wu_Jie_Bian_Huan_Conditions))
call TriggerAddAction(gg_trg_Cloce_Wu_Jie_Bian_Huan,function Trig_Cloce_Wu_Jie_Bian_Huan_Actions)
endfunction
function Trig_Wu_Jie_Help_Actions takes nothing returns nothing
call CreateQuestBJ(bj_QUESTTYPE_OPT_DISCOVERED,"|CFF00FF00无界QQ群|R","|CFF00FF00无界16群：69595123|R","ReplaceableTextures\\CommandButtons\\BTNManaShield.blp")
call DisplayTimedTextToForce(GetPlayersAll(),10.00,"|CFF00FF00,关注无界变幻 III　的开启方法,关注：|R|CFF00FFFFhttp://bbs.07073.com|R")
endfunction
function InitTrig_Wu_Jie_Help takes nothing returns nothing
set gg_trg_Wu_Jie_Help=CreateTrigger()
call TriggerRegisterTimerEventSingle(gg_trg_Wu_Jie_Help,5)
call TriggerAddAction(gg_trg_Wu_Jie_Help,function Trig_Wu_Jie_Help_Actions)
endfunction
function Trig_Red_Fire_Up_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_Red_Fire_Left)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Red_Fire_Left)
endfunction
function InitTrig_Red_Fire_Up takes nothing returns nothing
set gg_trg_Red_Fire_Up=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Red_Fire_Up,Player(0),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerAddAction(gg_trg_Red_Fire_Up,function Trig_Red_Fire_Up_Actions)
endfunction
function Trig_Red_Fire_Left_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Red_Fire_Down)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Red_Fire_Down)
endfunction
function InitTrig_Red_Fire_Left takes nothing returns nothing
set gg_trg_Red_Fire_Left=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Red_Fire_Left,Player(0),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_LEFT)
call TriggerAddAction(gg_trg_Red_Fire_Left,function Trig_Red_Fire_Left_Actions)
endfunction
function Trig_Red_Fire_Down_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Red_Fire_Right)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Red_Fire_Right)
endfunction
function InitTrig_Red_Fire_Down takes nothing returns nothing
set gg_trg_Red_Fire_Down=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Red_Fire_Down,Player(0),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerAddAction(gg_trg_Red_Fire_Down,function Trig_Red_Fire_Down_Actions)
endfunction
function Trig_Red_Fire_Right_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Red_Fire)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Red_Fire)
endfunction
function InitTrig_Red_Fire_Right takes nothing returns nothing
set gg_trg_Red_Fire_Right=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Red_Fire_Right,Player(0),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_RIGHT)
call TriggerAddAction(gg_trg_Red_Fire_Right,function Trig_Red_Fire_Right_Actions)
endfunction
function Trig_Red_Fire_Conditions takes nothing returns boolean
if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetOwningPlayer(GetTriggerUnit())==Player(0)))then
return false
endif
return true
endfunction
function Trig_Red_Fire_Actions takes nothing returns nothing
set udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetTriggerPlayer())]=true
set udg_playerWu_Jie[GetConvertedPlayerId(GetTriggerPlayer())]=GetTriggerUnit()
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Ablity_1)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Life)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Anywhere)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Death)
call EnableTrigger(gg_trg_Red_New_Wu_Jie_Bian_Huan_Twist)
call PanCameraToTimedLocForPlayer(Player(0),GetUnitLoc(GetTriggerUnit()),0)
call DisplayTimedTextToForce(GetPlayersAll(),10.00,(GetPlayerName(GetTriggerPlayer())+"|C00FF00FF开启了无界隐藏技能模式|R|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r"))
call DisplayTimedTextToForce(GetPlayersAll(),10.00,"|CFF00FF00,关注无界变幻 III　的开启方法,关注：http://bbs.07073.com|R")
call SetUnitVertexColor(GetTriggerUnit(),255,0,0,255)
call SetUnitMoveSpeed(GetTriggerUnit(),522.00)
call CreateTextTagUnitBJ("|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r",GetTriggerUnit(),0,30.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),50.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call DisableTrigger(GetTriggeringTrigger())
endfunction
function InitTrig_Red_Fire takes nothing returns nothing
set gg_trg_Red_Fire=CreateTrigger()
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_Red_Fire,Player(0),true)
call TriggerAddCondition(gg_trg_Red_Fire,Condition(function Trig_Red_Fire_Conditions))
call TriggerAddAction(gg_trg_Red_Fire,function Trig_Red_Fire_Actions)
endfunction
function Trig_Red_New_Wu_Jie_Bian_Huan_Twist_Conditions takes nothing returns boolean
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==true))then
return false
endif
if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetRandomInt(1,100)<=2))then
return false
endif
return true
endfunction
function Trig_Red_New_Wu_Jie_Bian_Huan_Twist_Func002002003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_Red_New_Wu_Jie_Bian_Huan_Twist_Func002002003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))==true)
endfunction
function Trig_Red_New_Wu_Jie_Bian_Huan_Twist_Func002002003 takes nothing returns boolean
return GetBooleanAnd(Trig_Red_New_Wu_Jie_Bian_Huan_Twist_Func002002003001(),Trig_Red_New_Wu_Jie_Bian_Huan_Twist_Func002002003002())
endfunction
function Trig_Red_New_Wu_Jie_Bian_Huan_Twist_Func003A takes nothing returns nothing
call GroupAddUnitSimple(GetEnumUnit(),udg_Red_Twist_Group2)
call PauseUnitBJ(true,GetEnumUnit())
endfunction
function Trig_Red_New_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C takes nothing returns boolean
if(not(IsUnitAliveBJ(GetEnumUnit())==false))then
return false
endif
return true
endfunction
function Trig_Red_New_Wu_Jie_Bian_Huan_Twist_Func004Func001A takes nothing returns nothing
if(Trig_Red_New_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C())then
call GroupRemoveUnitSimple(GetEnumUnit(),udg_Red_Twist_Group2)
else
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetTriggerUnit(),GetEnumUnit(),((((I2R(GetHeroStr(GetTriggerUnit(),true))+I2R(GetHeroAgi(GetTriggerUnit(),true)))+I2R(GetHeroInt(GetTriggerUnit(),true)))*SquareRoot(I2R(GetHeroLevel(GetTriggerUnit()))))/ 2.00),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endif
endfunction
function Trig_Red_New_Wu_Jie_Bian_Huan_Twist_Func005A takes nothing returns nothing
call PauseUnitBJ(false,GetEnumUnit())
endfunction
function Trig_Red_New_Wu_Jie_Bian_Huan_Twist_Actions takes nothing returns nothing
set udg_Red_Twist_Group1=GetUnitsInRangeOfLocMatching(512,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_Red_New_Wu_Jie_Bian_Huan_Twist_Func002002003))
call ForGroupBJ(udg_Red_Twist_Group1,function Trig_Red_New_Wu_Jie_Bian_Huan_Twist_Func003A)
set udg_Red_Twist_Loop=1
loop
exitwhen udg_Red_Twist_Loop>4
call ForGroupBJ(udg_Red_Twist_Group2,function Trig_Red_New_Wu_Jie_Bian_Huan_Twist_Func004Func001A)
call TriggerSleepAction(0.80)
set udg_Red_Twist_Loop=udg_Red_Twist_Loop+1
endloop
call ForGroupBJ(udg_Red_Twist_Group2,function Trig_Red_New_Wu_Jie_Bian_Huan_Twist_Func005A)
call GroupClear(udg_Red_Twist_Group1)
call GroupClear(udg_Red_Twist_Group2)
endfunction
function InitTrig_Red_New_Wu_Jie_Bian_Huan_Twist takes nothing returns nothing
set gg_trg_Red_New_Wu_Jie_Bian_Huan_Twist=CreateTrigger()
call TriggerRegisterPlayerUnitEventSimple(gg_trg_Red_New_Wu_Jie_Bian_Huan_Twist,Player(0),EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_Red_New_Wu_Jie_Bian_Huan_Twist,Condition(function Trig_Red_New_Wu_Jie_Bian_Huan_Twist_Conditions))
call TriggerAddAction(gg_trg_Red_New_Wu_Jie_Bian_Huan_Twist,function Trig_Red_New_Wu_Jie_Bian_Huan_Twist_Actions)
endfunction
function Trig_Blue_Ice_Left_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_Blue_Ice_Down)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Blue_Ice_Down)
endfunction
function InitTrig_Blue_Ice_Left takes nothing returns nothing
set gg_trg_Blue_Ice_Left=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Blue_Ice_Left,Player(1),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_LEFT)
call TriggerAddAction(gg_trg_Blue_Ice_Left,function Trig_Blue_Ice_Left_Actions)
endfunction
function Trig_Blue_Ice_Down_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Blue_Ice_Right)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Blue_Ice_Right)
endfunction
function InitTrig_Blue_Ice_Down takes nothing returns nothing
set gg_trg_Blue_Ice_Down=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Blue_Ice_Down,Player(1),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerAddAction(gg_trg_Blue_Ice_Down,function Trig_Blue_Ice_Down_Actions)
endfunction
function Trig_Blue_Ice_Right_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Blue_Ice_Up)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Blue_Ice_Up)
endfunction
function InitTrig_Blue_Ice_Right takes nothing returns nothing
set gg_trg_Blue_Ice_Right=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Blue_Ice_Right,Player(1),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_RIGHT)
call TriggerAddAction(gg_trg_Blue_Ice_Right,function Trig_Blue_Ice_Right_Actions)
endfunction
function Trig_Blue_Ice_Up_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Blue_Ice)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Blue_Ice)
endfunction
function InitTrig_Blue_Ice_Up takes nothing returns nothing
set gg_trg_Blue_Ice_Up=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Blue_Ice_Up,Player(1),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerAddAction(gg_trg_Blue_Ice_Up,function Trig_Blue_Ice_Up_Actions)
endfunction
function Trig_Blue_Ice_Conditions takes nothing returns boolean
if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetOwningPlayer(GetTriggerUnit())==Player(1)))then
return false
endif
return true
endfunction
function Trig_Blue_Ice_Actions takes nothing returns nothing
set udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetTriggerPlayer())]=true
set udg_playerWu_Jie[GetConvertedPlayerId(GetTriggerPlayer())]=GetTriggerUnit()
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Ablity_1)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Life)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Anywhere)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Death)
call EnableTrigger(gg_trg_Blue_New_Wu_Jie_Bian_Huan_Twist)
call PanCameraToTimedLocForPlayer(Player(1),GetUnitLoc(GetTriggerUnit()),0)
call DisplayTimedTextToForce(GetPlayersAll(),10.00,(GetPlayerName(GetTriggerPlayer())+"|C00FF00FF开启了无界隐藏技能模式|R|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r"))
call DisplayTimedTextToForce(GetPlayersAll(),10.00,"|CFF00FF00,关注无界变幻 III　的开启方法,关注：http://bbs.07073.com|R")
call SetUnitVertexColor(GetTriggerUnit(),0,0,255,255)
call SetUnitMoveSpeed(GetTriggerUnit(),522.00)
call CreateTextTagUnitBJ("|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r",GetTriggerUnit(),0,30.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),50.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call DisableTrigger(GetTriggeringTrigger())
endfunction
function InitTrig_Blue_Ice takes nothing returns nothing
set gg_trg_Blue_Ice=CreateTrigger()
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_Blue_Ice,Player(1),true)
call TriggerAddCondition(gg_trg_Blue_Ice,Condition(function Trig_Blue_Ice_Conditions))
call TriggerAddAction(gg_trg_Blue_Ice,function Trig_Blue_Ice_Actions)
endfunction
function Trig_Blue_New_Wu_Jie_Bian_Huan_Twist_Conditions takes nothing returns boolean
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==true))then
return false
endif
if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetRandomInt(1,100)<=2))then
return false
endif
return true
endfunction
function Trig_Blue_New_Wu_Jie_Bian_Huan_Twist_Func002002003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_Blue_New_Wu_Jie_Bian_Huan_Twist_Func002002003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))==true)
endfunction
function Trig_Blue_New_Wu_Jie_Bian_Huan_Twist_Func002002003 takes nothing returns boolean
return GetBooleanAnd(Trig_Blue_New_Wu_Jie_Bian_Huan_Twist_Func002002003001(),Trig_Blue_New_Wu_Jie_Bian_Huan_Twist_Func002002003002())
endfunction
function Trig_Blue_New_Wu_Jie_Bian_Huan_Twist_Func003A takes nothing returns nothing
call GroupAddUnitSimple(GetEnumUnit(),udg_Blue_Twist_Group2)
call PauseUnitBJ(true,GetEnumUnit())
endfunction
function Trig_Blue_New_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C takes nothing returns boolean
if(not(IsUnitAliveBJ(GetEnumUnit())==false))then
return false
endif
return true
endfunction
function Trig_Blue_New_Wu_Jie_Bian_Huan_Twist_Func004Func001A takes nothing returns nothing
if(Trig_Blue_New_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C())then
call GroupRemoveUnitSimple(GetEnumUnit(),udg_Blue_Twist_Group2)
else
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetTriggerUnit(),GetEnumUnit(),((((I2R(GetHeroStr(GetTriggerUnit(),true))+I2R(GetHeroAgi(GetTriggerUnit(),true)))+I2R(GetHeroInt(GetTriggerUnit(),true)))*SquareRoot(I2R(GetHeroLevel(GetTriggerUnit()))))/ 2.00),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endif
endfunction
function Trig_Blue_New_Wu_Jie_Bian_Huan_Twist_Func005A takes nothing returns nothing
call PauseUnitBJ(false,GetEnumUnit())
endfunction
function Trig_Blue_New_Wu_Jie_Bian_Huan_Twist_Actions takes nothing returns nothing
set udg_Blue_Twist_Group1=GetUnitsInRangeOfLocMatching(512,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_Blue_New_Wu_Jie_Bian_Huan_Twist_Func002002003))
call ForGroupBJ(udg_Blue_Twist_Group1,function Trig_Blue_New_Wu_Jie_Bian_Huan_Twist_Func003A)
set udg_Blue_Twist_Loop=1
loop
exitwhen udg_Blue_Twist_Loop>4
call ForGroupBJ(udg_Blue_Twist_Group2,function Trig_Blue_New_Wu_Jie_Bian_Huan_Twist_Func004Func001A)
call TriggerSleepAction(0.80)
set udg_Blue_Twist_Loop=udg_Blue_Twist_Loop+1
endloop
call ForGroupBJ(udg_Blue_Twist_Group2,function Trig_Blue_New_Wu_Jie_Bian_Huan_Twist_Func005A)
call GroupClear(udg_Blue_Twist_Group1)
call GroupClear(udg_Blue_Twist_Group2)
endfunction
function InitTrig_Blue_New_Wu_Jie_Bian_Huan_Twist takes nothing returns nothing
set gg_trg_Blue_New_Wu_Jie_Bian_Huan_Twist=CreateTrigger()
call TriggerRegisterPlayerUnitEventSimple(gg_trg_Blue_New_Wu_Jie_Bian_Huan_Twist,Player(1),EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_Blue_New_Wu_Jie_Bian_Huan_Twist,Condition(function Trig_Blue_New_Wu_Jie_Bian_Huan_Twist_Conditions))
call TriggerAddAction(gg_trg_Blue_New_Wu_Jie_Bian_Huan_Twist,function Trig_Blue_New_Wu_Jie_Bian_Huan_Twist_Actions)
endfunction
function Trig_Cyan_Bolt_Down_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_Cyan_Bolt_Right)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Cyan_Bolt_Right)
endfunction
function InitTrig_Cyan_Bolt_Down takes nothing returns nothing
set gg_trg_Cyan_Bolt_Down=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Cyan_Bolt_Down,Player(2),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerAddAction(gg_trg_Cyan_Bolt_Down,function Trig_Cyan_Bolt_Down_Actions)
endfunction
function Trig_Cyan_Bolt_Right_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Cyan_Bolt_Up)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Cyan_Bolt_Up)
endfunction
function InitTrig_Cyan_Bolt_Right takes nothing returns nothing
set gg_trg_Cyan_Bolt_Right=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Cyan_Bolt_Right,Player(2),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_RIGHT)
call TriggerAddAction(gg_trg_Cyan_Bolt_Right,function Trig_Cyan_Bolt_Right_Actions)
endfunction
function Trig_Cyan_Bolt_Up_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Cyan_Bolt_Left)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Cyan_Bolt_Left)
endfunction
function InitTrig_Cyan_Bolt_Up takes nothing returns nothing
set gg_trg_Cyan_Bolt_Up=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Cyan_Bolt_Up,Player(2),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerAddAction(gg_trg_Cyan_Bolt_Up,function Trig_Cyan_Bolt_Up_Actions)
endfunction
function Trig_Cyan_Bolt_Left_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Cyan_Bolt)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Cyan_Bolt)
endfunction
function InitTrig_Cyan_Bolt_Left takes nothing returns nothing
set gg_trg_Cyan_Bolt_Left=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Cyan_Bolt_Left,Player(2),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_LEFT)
call TriggerAddAction(gg_trg_Cyan_Bolt_Left,function Trig_Cyan_Bolt_Left_Actions)
endfunction
function Trig_Cyan_Bolt_Conditions takes nothing returns boolean
if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetOwningPlayer(GetTriggerUnit())==Player(2)))then
return false
endif
return true
endfunction
function Trig_Cyan_Bolt_Actions takes nothing returns nothing
set udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetTriggerPlayer())]=true
set udg_playerWu_Jie[GetConvertedPlayerId(GetTriggerPlayer())]=GetTriggerUnit()
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Ablity_1)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Life)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Anywhere)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Death)
call EnableTrigger(gg_trg_Cyan_New_Wu_Jie_Bian_Huan_Twist)
call PanCameraToTimedLocForPlayer(Player(2),GetUnitLoc(GetTriggerUnit()),0)
call DisplayTimedTextToForce(GetPlayersAll(),10.00,(GetPlayerName(GetTriggerPlayer())+"|C00FF00FF开启了无界隐藏技能模式|R|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r"))
call DisplayTimedTextToForce(GetPlayersAll(),10.00,"|CFF00FF00,关注无界变幻 III　的开启方法,关注：http://bbs.07073.com|R")
call SetUnitVertexColor(GetTriggerUnit(),0,255,255,255)
call SetUnitMoveSpeed(GetTriggerUnit(),522.00)
call CreateTextTagUnitBJ("|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r",GetTriggerUnit(),0,30.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),50.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call DisableTrigger(GetTriggeringTrigger())
endfunction
function InitTrig_Cyan_Bolt takes nothing returns nothing
set gg_trg_Cyan_Bolt=CreateTrigger()
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_Cyan_Bolt,Player(2),true)
call TriggerAddCondition(gg_trg_Cyan_Bolt,Condition(function Trig_Cyan_Bolt_Conditions))
call TriggerAddAction(gg_trg_Cyan_Bolt,function Trig_Cyan_Bolt_Actions)
endfunction
function Trig_Cyan_New_Wu_Jie_Bian_Huan_Twist_Conditions takes nothing returns boolean
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==true))then
return false
endif
if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetRandomInt(1,100)<=2))then
return false
endif
return true
endfunction
function Trig_Cyan_New_Wu_Jie_Bian_Huan_Twist_Func002002003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_Cyan_New_Wu_Jie_Bian_Huan_Twist_Func002002003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))==true)
endfunction
function Trig_Cyan_New_Wu_Jie_Bian_Huan_Twist_Func002002003 takes nothing returns boolean
return GetBooleanAnd(Trig_Cyan_New_Wu_Jie_Bian_Huan_Twist_Func002002003001(),Trig_Cyan_New_Wu_Jie_Bian_Huan_Twist_Func002002003002())
endfunction
function Trig_Cyan_New_Wu_Jie_Bian_Huan_Twist_Func003A takes nothing returns nothing
call GroupAddUnitSimple(GetEnumUnit(),udg_Cyan_Twist_Group2)
call PauseUnitBJ(true,GetEnumUnit())
endfunction
function Trig_Cyan_New_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C takes nothing returns boolean
if(not(IsUnitAliveBJ(GetEnumUnit())==false))then
return false
endif
return true
endfunction
function Trig_Cyan_New_Wu_Jie_Bian_Huan_Twist_Func004Func001A takes nothing returns nothing
if(Trig_Cyan_New_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C())then
call GroupRemoveUnitSimple(GetEnumUnit(),udg_Cyan_Twist_Group2)
else
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetTriggerUnit(),GetEnumUnit(),((((I2R(GetHeroStr(GetTriggerUnit(),true))+I2R(GetHeroAgi(GetTriggerUnit(),true)))+I2R(GetHeroInt(GetTriggerUnit(),true)))*SquareRoot(I2R(GetHeroLevel(GetTriggerUnit()))))/ 2.00),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endif
endfunction
function Trig_Cyan_New_Wu_Jie_Bian_Huan_Twist_Func005A takes nothing returns nothing
call PauseUnitBJ(false,GetEnumUnit())
endfunction
function Trig_Cyan_New_Wu_Jie_Bian_Huan_Twist_Actions takes nothing returns nothing
set udg_Cyan_Twist_Group1=GetUnitsInRangeOfLocMatching(512,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_Cyan_New_Wu_Jie_Bian_Huan_Twist_Func002002003))
call ForGroupBJ(udg_Cyan_Twist_Group1,function Trig_Cyan_New_Wu_Jie_Bian_Huan_Twist_Func003A)
set udg_Cyan_Twist_Loop=1
loop
exitwhen udg_Cyan_Twist_Loop>4
call ForGroupBJ(udg_Cyan_Twist_Group2,function Trig_Cyan_New_Wu_Jie_Bian_Huan_Twist_Func004Func001A)
call TriggerSleepAction(0.80)
set udg_Cyan_Twist_Loop=udg_Cyan_Twist_Loop+1
endloop
call ForGroupBJ(udg_Cyan_Twist_Group2,function Trig_Cyan_New_Wu_Jie_Bian_Huan_Twist_Func005A)
call GroupClear(udg_Cyan_Twist_Group1)
call GroupClear(udg_Cyan_Twist_Group2)
endfunction
function InitTrig_Cyan_New_Wu_Jie_Bian_Huan_Twist takes nothing returns nothing
set gg_trg_Cyan_New_Wu_Jie_Bian_Huan_Twist=CreateTrigger()
call TriggerRegisterPlayerUnitEventSimple(gg_trg_Cyan_New_Wu_Jie_Bian_Huan_Twist,Player(2),EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_Cyan_New_Wu_Jie_Bian_Huan_Twist,Condition(function Trig_Cyan_New_Wu_Jie_Bian_Huan_Twist_Conditions))
call TriggerAddAction(gg_trg_Cyan_New_Wu_Jie_Bian_Huan_Twist,function Trig_Cyan_New_Wu_Jie_Bian_Huan_Twist_Actions)
endfunction
function Trig_Purple_Moon_Right_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_Purple_Moon_Up)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Purple_Moon_Up)
endfunction
function InitTrig_Purple_Moon_Right takes nothing returns nothing
set gg_trg_Purple_Moon_Right=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Purple_Moon_Right,Player(3),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_RIGHT)
call TriggerAddAction(gg_trg_Purple_Moon_Right,function Trig_Purple_Moon_Right_Actions)
endfunction
function Trig_Purple_Moon_Up_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Purple_Moon_Left)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Purple_Moon_Left)
endfunction
function InitTrig_Purple_Moon_Up takes nothing returns nothing
set gg_trg_Purple_Moon_Up=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Purple_Moon_Up,Player(3),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerAddAction(gg_trg_Purple_Moon_Up,function Trig_Purple_Moon_Up_Actions)
endfunction
function Trig_Purple_Moon_Left_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Purple_Moon_Down)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Purple_Moon_Down)
endfunction
function InitTrig_Purple_Moon_Left takes nothing returns nothing
set gg_trg_Purple_Moon_Left=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Purple_Moon_Left,Player(3),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_LEFT)
call TriggerAddAction(gg_trg_Purple_Moon_Left,function Trig_Purple_Moon_Left_Actions)
endfunction
function Trig_Purple_Moon_Down_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Purple_Moon)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Purple_Moon)
endfunction
function InitTrig_Purple_Moon_Down takes nothing returns nothing
set gg_trg_Purple_Moon_Down=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Purple_Moon_Down,Player(3),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerAddAction(gg_trg_Purple_Moon_Down,function Trig_Purple_Moon_Down_Actions)
endfunction
function Trig_Purple_Moon_Conditions takes nothing returns boolean
if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetOwningPlayer(GetTriggerUnit())==Player(3)))then
return false
endif
return true
endfunction
function Trig_Purple_Moon_Actions takes nothing returns nothing
set udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetTriggerPlayer())]=true
set udg_playerWu_Jie[GetConvertedPlayerId(GetTriggerPlayer())]=GetTriggerUnit()
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Ablity_1)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Life)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Anywhere)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Death)
call EnableTrigger(gg_trg_Purple_New_Wu_Jie_Bian_Huan_Twist)
call PanCameraToTimedLocForPlayer(Player(3),GetUnitLoc(GetTriggerUnit()),0)
call DisplayTimedTextToForce(GetPlayersAll(),10.00,(GetPlayerName(GetTriggerPlayer())+"|C00FF00FF开启了无界隐藏技能模式|R|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r"))
call DisplayTimedTextToForce(GetPlayersAll(),10.00,"|CFF00FF00,关注无界变幻 III　的开启方法,关注：http://bbs.07073.com|R")
call SetUnitVertexColor(GetTriggerUnit(),255,0,255,255)
call SetUnitMoveSpeed(GetTriggerUnit(),522.00)
call CreateTextTagUnitBJ("|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r",GetTriggerUnit(),0,30.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),50.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call DisableTrigger(GetTriggeringTrigger())
endfunction
function InitTrig_Purple_Moon takes nothing returns nothing
set gg_trg_Purple_Moon=CreateTrigger()
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_Purple_Moon,Player(3),true)
call TriggerAddCondition(gg_trg_Purple_Moon,Condition(function Trig_Purple_Moon_Conditions))
call TriggerAddAction(gg_trg_Purple_Moon,function Trig_Purple_Moon_Actions)
endfunction
function Trig_Purple_New_Wu_Jie_Bian_Huan_Twist_Conditions takes nothing returns boolean
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==true))then
return false
endif
if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetRandomInt(1,100)<=2))then
return false
endif
return true
endfunction
function Trig_Purple_New_Wu_Jie_Bian_Huan_Twist_Func002002003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_Purple_New_Wu_Jie_Bian_Huan_Twist_Func002002003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))==true)
endfunction
function Trig_Purple_New_Wu_Jie_Bian_Huan_Twist_Func002002003 takes nothing returns boolean
return GetBooleanAnd(Trig_Purple_New_Wu_Jie_Bian_Huan_Twist_Func002002003001(),Trig_Purple_New_Wu_Jie_Bian_Huan_Twist_Func002002003002())
endfunction
function Trig_Purple_New_Wu_Jie_Bian_Huan_Twist_Func003A takes nothing returns nothing
call GroupAddUnitSimple(GetEnumUnit(),udg_Purple_Twist_Group2)
call PauseUnitBJ(true,GetEnumUnit())
endfunction
function Trig_Purple_New_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C takes nothing returns boolean
if(not(IsUnitAliveBJ(GetEnumUnit())==false))then
return false
endif
return true
endfunction
function Trig_Purple_New_Wu_Jie_Bian_Huan_Twist_Func004Func001A takes nothing returns nothing
if(Trig_Purple_New_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C())then
call GroupRemoveUnitSimple(GetEnumUnit(),udg_Purple_Twist_Group2)
else
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetTriggerUnit(),GetEnumUnit(),((((I2R(GetHeroStr(GetTriggerUnit(),true))+I2R(GetHeroAgi(GetTriggerUnit(),true)))+I2R(GetHeroInt(GetTriggerUnit(),true)))*SquareRoot(I2R(GetHeroLevel(GetTriggerUnit()))))/ 2.00),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endif
endfunction
function Trig_Purple_New_Wu_Jie_Bian_Huan_Twist_Func005A takes nothing returns nothing
call PauseUnitBJ(false,GetEnumUnit())
endfunction
function Trig_Purple_New_Wu_Jie_Bian_Huan_Twist_Actions takes nothing returns nothing
set udg_Purple_Twist_Group1=GetUnitsInRangeOfLocMatching(512,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_Purple_New_Wu_Jie_Bian_Huan_Twist_Func002002003))
call ForGroupBJ(udg_Purple_Twist_Group1,function Trig_Purple_New_Wu_Jie_Bian_Huan_Twist_Func003A)
set udg_Purple_Twist_Loop=1
loop
exitwhen udg_Purple_Twist_Loop>4
call ForGroupBJ(udg_Purple_Twist_Group2,function Trig_Purple_New_Wu_Jie_Bian_Huan_Twist_Func004Func001A)
call TriggerSleepAction(0.80)
set udg_Purple_Twist_Loop=udg_Purple_Twist_Loop+1
endloop
call ForGroupBJ(udg_Purple_Twist_Group2,function Trig_Purple_New_Wu_Jie_Bian_Huan_Twist_Func005A)
call GroupClear(udg_Purple_Twist_Group1)
call GroupClear(udg_Purple_Twist_Group2)
endfunction
function InitTrig_Purple_New_Wu_Jie_Bian_Huan_Twist takes nothing returns nothing
set gg_trg_Purple_New_Wu_Jie_Bian_Huan_Twist=CreateTrigger()
call TriggerRegisterPlayerUnitEventSimple(gg_trg_Purple_New_Wu_Jie_Bian_Huan_Twist,Player(3),EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_Purple_New_Wu_Jie_Bian_Huan_Twist,Condition(function Trig_Purple_New_Wu_Jie_Bian_Huan_Twist_Conditions))
call TriggerAddAction(gg_trg_Purple_New_Wu_Jie_Bian_Huan_Twist,function Trig_Purple_New_Wu_Jie_Bian_Huan_Twist_Actions)
endfunction
function Trig_Yellow_Light_Up_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_Yellow_Light_Right)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Yellow_Light_Right)
endfunction
function InitTrig_Yellow_Light_Up takes nothing returns nothing
set gg_trg_Yellow_Light_Up=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Yellow_Light_Up,Player(4),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerAddAction(gg_trg_Yellow_Light_Up,function Trig_Yellow_Light_Up_Actions)
endfunction
function Trig_Yellow_Light_Right_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Yellow_Light_Down)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Yellow_Light_Down)
endfunction
function InitTrig_Yellow_Light_Right takes nothing returns nothing
set gg_trg_Yellow_Light_Right=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Yellow_Light_Right,Player(4),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_RIGHT)
call TriggerAddAction(gg_trg_Yellow_Light_Right,function Trig_Yellow_Light_Right_Actions)
endfunction
function Trig_Yellow_Light_Down_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Yellow_Light_Left)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Yellow_Light_Left)
endfunction
function InitTrig_Yellow_Light_Down takes nothing returns nothing
set gg_trg_Yellow_Light_Down=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Yellow_Light_Down,Player(4),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerAddAction(gg_trg_Yellow_Light_Down,function Trig_Yellow_Light_Down_Actions)
endfunction
function Trig_Yellow_Light_Left_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Yellow_Light)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Yellow_Light)
endfunction
function InitTrig_Yellow_Light_Left takes nothing returns nothing
set gg_trg_Yellow_Light_Left=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Yellow_Light_Left,Player(4),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_LEFT)
call TriggerAddAction(gg_trg_Yellow_Light_Left,function Trig_Yellow_Light_Left_Actions)
endfunction
function Trig_Yellow_Light_Conditions takes nothing returns boolean
if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetOwningPlayer(GetTriggerUnit())==Player(4)))then
return false
endif
return true
endfunction
function Trig_Yellow_Light_Actions takes nothing returns nothing
set udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetTriggerPlayer())]=true
set udg_playerWu_Jie[GetConvertedPlayerId(GetTriggerPlayer())]=GetTriggerUnit()
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Ablity_1)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Life)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Anywhere)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Death)
call EnableTrigger(gg_trg_Yellow_New_Wu_Jie_Bian_Huan_Twist)
call PanCameraToTimedLocForPlayer(Player(4),GetUnitLoc(GetTriggerUnit()),0)
call DisplayTimedTextToForce(GetPlayersAll(),10.00,(GetPlayerName(GetTriggerPlayer())+"|C00FF00FF开启了无界隐藏技能模式|R|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r"))
call DisplayTimedTextToForce(GetPlayersAll(),10.00,"|CFF00FF00,关注无界变幻 III　的开启方法,关注：http://bbs.07073.com|R")
call SetUnitVertexColor(GetTriggerUnit(),255,255,0,255)
call SetUnitMoveSpeed(GetTriggerUnit(),522.00)
call CreateTextTagUnitBJ("|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r",GetTriggerUnit(),0,30.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),50.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call DisableTrigger(GetTriggeringTrigger())
endfunction
function InitTrig_Yellow_Light takes nothing returns nothing
set gg_trg_Yellow_Light=CreateTrigger()
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_Yellow_Light,Player(4),true)
call TriggerAddCondition(gg_trg_Yellow_Light,Condition(function Trig_Yellow_Light_Conditions))
call TriggerAddAction(gg_trg_Yellow_Light,function Trig_Yellow_Light_Actions)
endfunction
function Trig_Yellow_New_Wu_Jie_Bian_Huan_Twist_Conditions takes nothing returns boolean
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==true))then
return false
endif
if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetRandomInt(1,100)<=2))then
return false
endif
return true
endfunction
function Trig_Yellow_New_Wu_Jie_Bian_Huan_Twist_Func002002003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_Yellow_New_Wu_Jie_Bian_Huan_Twist_Func002002003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))==true)
endfunction
function Trig_Yellow_New_Wu_Jie_Bian_Huan_Twist_Func002002003 takes nothing returns boolean
return GetBooleanAnd(Trig_Yellow_New_Wu_Jie_Bian_Huan_Twist_Func002002003001(),Trig_Yellow_New_Wu_Jie_Bian_Huan_Twist_Func002002003002())
endfunction
function Trig_Yellow_New_Wu_Jie_Bian_Huan_Twist_Func003A takes nothing returns nothing
call GroupAddUnitSimple(GetEnumUnit(),udg_Yellow_Twist_Group2)
call PauseUnitBJ(true,GetEnumUnit())
endfunction
function Trig_Yellow_New_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C takes nothing returns boolean
if(not(IsUnitAliveBJ(GetEnumUnit())==false))then
return false
endif
return true
endfunction
function Trig_Yellow_New_Wu_Jie_Bian_Huan_Twist_Func004Func001A takes nothing returns nothing
if(Trig_Yellow_New_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C())then
call GroupRemoveUnitSimple(GetEnumUnit(),udg_Yellow_Twist_Group2)
else
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetTriggerUnit(),GetEnumUnit(),((((I2R(GetHeroStr(GetTriggerUnit(),true))+I2R(GetHeroAgi(GetTriggerUnit(),true)))+I2R(GetHeroInt(GetTriggerUnit(),true)))*SquareRoot(I2R(GetHeroLevel(GetTriggerUnit()))))/ 2.00),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endif
endfunction
function Trig_Yellow_New_Wu_Jie_Bian_Huan_Twist_Func005A takes nothing returns nothing
call PauseUnitBJ(false,GetEnumUnit())
endfunction
function Trig_Yellow_New_Wu_Jie_Bian_Huan_Twist_Actions takes nothing returns nothing
set udg_Yellow_Twist_Group1=GetUnitsInRangeOfLocMatching(512,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_Yellow_New_Wu_Jie_Bian_Huan_Twist_Func002002003))
call ForGroupBJ(udg_Yellow_Twist_Group1,function Trig_Yellow_New_Wu_Jie_Bian_Huan_Twist_Func003A)
set udg_Yellow_Twist_Loop=1
loop
exitwhen udg_Yellow_Twist_Loop>4
call ForGroupBJ(udg_Yellow_Twist_Group2,function Trig_Yellow_New_Wu_Jie_Bian_Huan_Twist_Func004Func001A)
call TriggerSleepAction(0.80)
set udg_Yellow_Twist_Loop=udg_Yellow_Twist_Loop+1
endloop
call ForGroupBJ(udg_Yellow_Twist_Group2,function Trig_Yellow_New_Wu_Jie_Bian_Huan_Twist_Func005A)
call GroupClear(udg_Yellow_Twist_Group1)
call GroupClear(udg_Yellow_Twist_Group2)
endfunction
function InitTrig_Yellow_New_Wu_Jie_Bian_Huan_Twist takes nothing returns nothing
set gg_trg_Yellow_New_Wu_Jie_Bian_Huan_Twist=CreateTrigger()
call TriggerRegisterPlayerUnitEventSimple(gg_trg_Yellow_New_Wu_Jie_Bian_Huan_Twist,Player(4),EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_Yellow_New_Wu_Jie_Bian_Huan_Twist,Condition(function Trig_Yellow_New_Wu_Jie_Bian_Huan_Twist_Conditions))
call TriggerAddAction(gg_trg_Yellow_New_Wu_Jie_Bian_Huan_Twist,function Trig_Yellow_New_Wu_Jie_Bian_Huan_Twist_Actions)
endfunction
function Trig_Orange_Wind_Right_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_Orange_Wind_Down)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Orange_Wind_Down)
endfunction
function InitTrig_Orange_Wind_Right takes nothing returns nothing
set gg_trg_Orange_Wind_Right=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Orange_Wind_Right,Player(5),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_RIGHT)
call TriggerAddAction(gg_trg_Orange_Wind_Right,function Trig_Orange_Wind_Right_Actions)
endfunction
function Trig_Orange_Wind_Down_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Orange_Wind_Left)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Orange_Wind_Left)
endfunction
function InitTrig_Orange_Wind_Down takes nothing returns nothing
set gg_trg_Orange_Wind_Down=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Orange_Wind_Down,Player(5),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerAddAction(gg_trg_Orange_Wind_Down,function Trig_Orange_Wind_Down_Actions)
endfunction
function Trig_Orange_Wind_Left_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Orange_Wind_Up)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Orange_Wind_Up)
endfunction
function InitTrig_Orange_Wind_Left takes nothing returns nothing
set gg_trg_Orange_Wind_Left=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Orange_Wind_Left,Player(5),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_LEFT)
call TriggerAddAction(gg_trg_Orange_Wind_Left,function Trig_Orange_Wind_Left_Actions)
endfunction
function Trig_Orange_Wind_Up_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Orange_Wind)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Orange_Wind)
endfunction
function InitTrig_Orange_Wind_Up takes nothing returns nothing
set gg_trg_Orange_Wind_Up=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Orange_Wind_Up,Player(5),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerAddAction(gg_trg_Orange_Wind_Up,function Trig_Orange_Wind_Up_Actions)
endfunction
function Trig_Orange_Wind_Conditions takes nothing returns boolean
if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetOwningPlayer(GetTriggerUnit())==Player(5)))then
return false
endif
return true
endfunction
function Trig_Orange_Wind_Actions takes nothing returns nothing
set udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetTriggerPlayer())]=true
set udg_playerWu_Jie[GetConvertedPlayerId(GetTriggerPlayer())]=GetTriggerUnit()
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Ablity_1)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Life)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Anywhere)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Death)
call EnableTrigger(gg_trg_Orange_New_Wu_Jie_Bian_Huan_Twist)
call PanCameraToTimedLocForPlayer(Player(5),GetUnitLoc(GetTriggerUnit()),0)
call DisplayTimedTextToForce(GetPlayersAll(),10.00,(GetPlayerName(GetTriggerPlayer())+"|C00FF00FF开启了无界隐藏技能模式|R|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r"))
call DisplayTimedTextToForce(GetPlayersAll(),10.00,"|CFF00FF00,关注无界变幻 III　的开启方法,关注：http://bbs.07073.com|R")
call SetUnitVertexColor(GetTriggerUnit(),255,170,0,255)
call SetUnitMoveSpeed(GetTriggerUnit(),522.00)
call CreateTextTagUnitBJ("|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r",GetTriggerUnit(),0,30.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),50.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call DisableTrigger(GetTriggeringTrigger())
endfunction
function InitTrig_Orange_Wind takes nothing returns nothing
set gg_trg_Orange_Wind=CreateTrigger()
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_Orange_Wind,Player(5),true)
call TriggerAddCondition(gg_trg_Orange_Wind,Condition(function Trig_Orange_Wind_Conditions))
call TriggerAddAction(gg_trg_Orange_Wind,function Trig_Orange_Wind_Actions)
endfunction
function Trig_Orange_New_Wu_Jie_Bian_Huan_Twist_Conditions takes nothing returns boolean
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==true))then
return false
endif
if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetRandomInt(1,100)<=2))then
return false
endif
return true
endfunction
function Trig_Orange_New_Wu_Jie_Bian_Huan_Twist_Func002002003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_Orange_New_Wu_Jie_Bian_Huan_Twist_Func002002003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))==true)
endfunction
function Trig_Orange_New_Wu_Jie_Bian_Huan_Twist_Func002002003 takes nothing returns boolean
return GetBooleanAnd(Trig_Orange_New_Wu_Jie_Bian_Huan_Twist_Func002002003001(),Trig_Orange_New_Wu_Jie_Bian_Huan_Twist_Func002002003002())
endfunction
function Trig_Orange_New_Wu_Jie_Bian_Huan_Twist_Func003A takes nothing returns nothing
call GroupAddUnitSimple(GetEnumUnit(),udg_Orange_Twist_Group2)
call PauseUnitBJ(true,GetEnumUnit())
endfunction
function Trig_Orange_New_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C takes nothing returns boolean
if(not(IsUnitAliveBJ(GetEnumUnit())==false))then
return false
endif
return true
endfunction
function Trig_Orange_New_Wu_Jie_Bian_Huan_Twist_Func004Func001A takes nothing returns nothing
if(Trig_Orange_New_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C())then
call GroupRemoveUnitSimple(GetEnumUnit(),udg_Orange_Twist_Group2)
else
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetTriggerUnit(),GetEnumUnit(),((((I2R(GetHeroStr(GetTriggerUnit(),true))+I2R(GetHeroAgi(GetTriggerUnit(),true)))+I2R(GetHeroInt(GetTriggerUnit(),true)))*SquareRoot(I2R(GetHeroLevel(GetTriggerUnit()))))/ 2.00),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endif
endfunction
function Trig_Orange_New_Wu_Jie_Bian_Huan_Twist_Func005A takes nothing returns nothing
call PauseUnitBJ(false,GetEnumUnit())
endfunction
function Trig_Orange_New_Wu_Jie_Bian_Huan_Twist_Actions takes nothing returns nothing
set udg_Orange_Twist_Group1=GetUnitsInRangeOfLocMatching(512,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_Orange_New_Wu_Jie_Bian_Huan_Twist_Func002002003))
call ForGroupBJ(udg_Orange_Twist_Group1,function Trig_Orange_New_Wu_Jie_Bian_Huan_Twist_Func003A)
set udg_Orange_Twist_Loop=1
loop
exitwhen udg_Orange_Twist_Loop>4
call ForGroupBJ(udg_Orange_Twist_Group2,function Trig_Orange_New_Wu_Jie_Bian_Huan_Twist_Func004Func001A)
call TriggerSleepAction(0.80)
set udg_Orange_Twist_Loop=udg_Orange_Twist_Loop+1
endloop
call ForGroupBJ(udg_Orange_Twist_Group2,function Trig_Orange_New_Wu_Jie_Bian_Huan_Twist_Func005A)
call GroupClear(udg_Orange_Twist_Group1)
call GroupClear(udg_Orange_Twist_Group2)
endfunction
function InitTrig_Orange_New_Wu_Jie_Bian_Huan_Twist takes nothing returns nothing
set gg_trg_Orange_New_Wu_Jie_Bian_Huan_Twist=CreateTrigger()
call TriggerRegisterPlayerUnitEventSimple(gg_trg_Orange_New_Wu_Jie_Bian_Huan_Twist,Player(5),EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_Orange_New_Wu_Jie_Bian_Huan_Twist,Condition(function Trig_Orange_New_Wu_Jie_Bian_Huan_Twist_Conditions))
call TriggerAddAction(gg_trg_Orange_New_Wu_Jie_Bian_Huan_Twist,function Trig_Orange_New_Wu_Jie_Bian_Huan_Twist_Actions)
endfunction
function Trig_Green_Wood_Down_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_Green_Wood_Left)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Green_Wood_Left)
endfunction
function InitTrig_Green_Wood_Down takes nothing returns nothing
set gg_trg_Green_Wood_Down=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Green_Wood_Down,Player(6),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerAddAction(gg_trg_Green_Wood_Down,function Trig_Green_Wood_Down_Actions)
endfunction
function Trig_Green_Wood_Left_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Green_Wood_Up)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Green_Wood_Up)
endfunction
function InitTrig_Green_Wood_Left takes nothing returns nothing
set gg_trg_Green_Wood_Left=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Green_Wood_Left,Player(6),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_LEFT)
call TriggerAddAction(gg_trg_Green_Wood_Left,function Trig_Green_Wood_Left_Actions)
endfunction
function Trig_Green_Wood_Up_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Green_Wood_Right)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Green_Wood_Right)
endfunction
function InitTrig_Green_Wood_Up takes nothing returns nothing
set gg_trg_Green_Wood_Up=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Green_Wood_Up,Player(6),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerAddAction(gg_trg_Green_Wood_Up,function Trig_Green_Wood_Up_Actions)
endfunction
function Trig_Green_Wood_Right_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Green_Wood)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Green_Wood)
endfunction
function InitTrig_Green_Wood_Right takes nothing returns nothing
set gg_trg_Green_Wood_Right=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Green_Wood_Right,Player(6),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_RIGHT)
call TriggerAddAction(gg_trg_Green_Wood_Right,function Trig_Green_Wood_Right_Actions)
endfunction
function Trig_Green_Wood_Conditions takes nothing returns boolean
if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetOwningPlayer(GetTriggerUnit())==Player(6)))then
return false
endif
return true
endfunction
function Trig_Green_Wood_Actions takes nothing returns nothing
set udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetTriggerPlayer())]=true
set udg_playerWu_Jie[GetConvertedPlayerId(GetTriggerPlayer())]=GetTriggerUnit()
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Ablity_1)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Life)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Anywhere)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Death)
call EnableTrigger(gg_trg_Green_New_Wu_Jie_Bian_Huan_Twist)
call PanCameraToTimedLocForPlayer(Player(6),GetUnitLoc(GetTriggerUnit()),0)
call DisplayTimedTextToForce(GetPlayersAll(),10.00,(GetPlayerName(GetTriggerPlayer())+"|C00FF00FF开启了无界隐藏技能模式|R|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r"))
call DisplayTimedTextToForce(GetPlayersAll(),10.00,"|CFF00FF00,关注无界变幻 III　的开启方法,关注：http://bbs.07073.com|R")
call SetUnitVertexColor(GetTriggerUnit(),0,255,0,255)
call SetUnitMoveSpeed(GetTriggerUnit(),522.00)
call CreateTextTagUnitBJ("|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r",GetTriggerUnit(),0,30.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),50.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call DisableTrigger(GetTriggeringTrigger())
endfunction
function InitTrig_Green_Wood takes nothing returns nothing
set gg_trg_Green_Wood=CreateTrigger()
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_Green_Wood,Player(6),true)
call TriggerAddCondition(gg_trg_Green_Wood,Condition(function Trig_Green_Wood_Conditions))
call TriggerAddAction(gg_trg_Green_Wood,function Trig_Green_Wood_Actions)
endfunction
function Trig_Green_New_Wu_Jie_Bian_Huan_Twist_Conditions takes nothing returns boolean
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==true))then
return false
endif
if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetRandomInt(1,100)<=2))then
return false
endif
return true
endfunction
function Trig_Green_New_Wu_Jie_Bian_Huan_Twist_Func002002003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_Green_New_Wu_Jie_Bian_Huan_Twist_Func002002003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))==true)
endfunction
function Trig_Green_New_Wu_Jie_Bian_Huan_Twist_Func002002003 takes nothing returns boolean
return GetBooleanAnd(Trig_Green_New_Wu_Jie_Bian_Huan_Twist_Func002002003001(),Trig_Green_New_Wu_Jie_Bian_Huan_Twist_Func002002003002())
endfunction
function Trig_Green_New_Wu_Jie_Bian_Huan_Twist_Func003A takes nothing returns nothing
call GroupAddUnitSimple(GetEnumUnit(),udg_Green_Twist_Group2)
call PauseUnitBJ(true,GetEnumUnit())
endfunction
function Trig_Green_New_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C takes nothing returns boolean
if(not(IsUnitAliveBJ(GetEnumUnit())==false))then
return false
endif
return true
endfunction
function Trig_Green_New_Wu_Jie_Bian_Huan_Twist_Func004Func001A takes nothing returns nothing
if(Trig_Green_New_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C())then
call GroupRemoveUnitSimple(GetEnumUnit(),udg_Green_Twist_Group2)
else
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetTriggerUnit(),GetEnumUnit(),((((I2R(GetHeroStr(GetTriggerUnit(),true))+I2R(GetHeroAgi(GetTriggerUnit(),true)))+I2R(GetHeroInt(GetTriggerUnit(),true)))*SquareRoot(I2R(GetHeroLevel(GetTriggerUnit()))))/ 2.00),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endif
endfunction
function Trig_Green_New_Wu_Jie_Bian_Huan_Twist_Func005A takes nothing returns nothing
call PauseUnitBJ(false,GetEnumUnit())
endfunction
function Trig_Green_New_Wu_Jie_Bian_Huan_Twist_Actions takes nothing returns nothing
set udg_Green_Twist_Group1=GetUnitsInRangeOfLocMatching(512,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_Green_New_Wu_Jie_Bian_Huan_Twist_Func002002003))
call ForGroupBJ(udg_Green_Twist_Group1,function Trig_Green_New_Wu_Jie_Bian_Huan_Twist_Func003A)
set udg_Green_Twist_Loop=1
loop
exitwhen udg_Green_Twist_Loop>4
call ForGroupBJ(udg_Green_Twist_Group2,function Trig_Green_New_Wu_Jie_Bian_Huan_Twist_Func004Func001A)
call TriggerSleepAction(0.80)
set udg_Green_Twist_Loop=udg_Green_Twist_Loop+1
endloop
call ForGroupBJ(udg_Green_Twist_Group2,function Trig_Green_New_Wu_Jie_Bian_Huan_Twist_Func005A)
call GroupClear(udg_Green_Twist_Group1)
call GroupClear(udg_Green_Twist_Group2)
endfunction
function InitTrig_Green_New_Wu_Jie_Bian_Huan_Twist takes nothing returns nothing
set gg_trg_Green_New_Wu_Jie_Bian_Huan_Twist=CreateTrigger()
call TriggerRegisterPlayerUnitEventSimple(gg_trg_Green_New_Wu_Jie_Bian_Huan_Twist,Player(6),EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_Green_New_Wu_Jie_Bian_Huan_Twist,Condition(function Trig_Green_New_Wu_Jie_Bian_Huan_Twist_Conditions))
call TriggerAddAction(gg_trg_Green_New_Wu_Jie_Bian_Huan_Twist,function Trig_Green_New_Wu_Jie_Bian_Huan_Twist_Actions)
endfunction
function Trig_Pink_Pink_Left_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_Pink_Pink_Up)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Pink_Pink_Up)
endfunction
function InitTrig_Pink_Pink_Left takes nothing returns nothing
set gg_trg_Pink_Pink_Left=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Pink_Pink_Left,Player(7),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_LEFT)
call TriggerAddAction(gg_trg_Pink_Pink_Left,function Trig_Pink_Pink_Left_Actions)
endfunction
function Trig_Pink_Pink_Up_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Pink_Pink_Right)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Pink_Pink_Right)
endfunction
function InitTrig_Pink_Pink_Up takes nothing returns nothing
set gg_trg_Pink_Pink_Up=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Pink_Pink_Up,Player(7),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerAddAction(gg_trg_Pink_Pink_Up,function Trig_Pink_Pink_Up_Actions)
endfunction
function Trig_Pink_Pink_Right_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Pink_Pink_Down)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Pink_Pink_Down)
endfunction
function InitTrig_Pink_Pink_Right takes nothing returns nothing
set gg_trg_Pink_Pink_Right=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Pink_Pink_Right,Player(7),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_RIGHT)
call TriggerAddAction(gg_trg_Pink_Pink_Right,function Trig_Pink_Pink_Right_Actions)
endfunction
function Trig_Pink_Pink_Down_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_Pink_Pink_Pink)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_Pink_Pink_Pink)
endfunction
function InitTrig_Pink_Pink_Down takes nothing returns nothing
set gg_trg_Pink_Pink_Down=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_Pink_Pink_Down,Player(7),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerAddAction(gg_trg_Pink_Pink_Down,function Trig_Pink_Pink_Down_Actions)
endfunction
function Trig_Pink_Pink_Pink_Conditions takes nothing returns boolean
if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetOwningPlayer(GetTriggerUnit())==Player(7)))then
return false
endif
return true
endfunction
function Trig_Pink_Pink_Pink_Actions takes nothing returns nothing
set udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetTriggerPlayer())]=true
set udg_playerWu_Jie[GetConvertedPlayerId(GetTriggerPlayer())]=GetTriggerUnit()
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Ablity_1)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Life)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Anywhere)
call EnableTrigger(gg_trg_New_Wu_Jie_Bian_Huan_Death)
call EnableTrigger(gg_trg_Pink_New_Wu_Jie_Bian_Huan_Twist)
call PanCameraToTimedLocForPlayer(Player(7),GetUnitLoc(GetTriggerUnit()),0)
call DisplayTimedTextToForce(GetPlayersAll(),10.00,(GetPlayerName(GetTriggerPlayer())+"|C00FF00FF开启了无界隐藏技能模式|R|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r"))
call DisplayTimedTextToForce(GetPlayersAll(),10.00,"|CFF00FF00,关注无界变幻 III　的开启方法,关注：http://bbs.07073.com|R")
call SetUnitVertexColor(GetTriggerUnit(),255,128,192,255)
call SetUnitMoveSpeed(GetTriggerUnit(),522.00)
call CreateTextTagUnitBJ("|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r",GetTriggerUnit(),0,30.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),50.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call DisableTrigger(GetTriggeringTrigger())
endfunction
function InitTrig_Pink_Pink_Pink takes nothing returns nothing
set gg_trg_Pink_Pink_Pink=CreateTrigger()
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_Pink_Pink_Pink,Player(7),true)
call TriggerAddCondition(gg_trg_Pink_Pink_Pink,Condition(function Trig_Pink_Pink_Pink_Conditions))
call TriggerAddAction(gg_trg_Pink_Pink_Pink,function Trig_Pink_Pink_Pink_Actions)
endfunction
function Trig_Pink_New_Wu_Jie_Bian_Huan_Twist_Conditions takes nothing returns boolean
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==true))then
return false
endif
if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetRandomInt(1,100)<=2))then
return false
endif
return true
endfunction
function Trig_Pink_New_Wu_Jie_Bian_Huan_Twist_Func002002003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_Pink_New_Wu_Jie_Bian_Huan_Twist_Func002002003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))==true)
endfunction
function Trig_Pink_New_Wu_Jie_Bian_Huan_Twist_Func002002003 takes nothing returns boolean
return GetBooleanAnd(Trig_Pink_New_Wu_Jie_Bian_Huan_Twist_Func002002003001(),Trig_Pink_New_Wu_Jie_Bian_Huan_Twist_Func002002003002())
endfunction
function Trig_Pink_New_Wu_Jie_Bian_Huan_Twist_Func003A takes nothing returns nothing
call GroupAddUnitSimple(GetEnumUnit(),udg_Pink_Twist_Group2)
call PauseUnitBJ(true,GetEnumUnit())
endfunction
function Trig_Pink_New_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C takes nothing returns boolean
if(not(IsUnitAliveBJ(GetEnumUnit())==false))then
return false
endif
return true
endfunction
function Trig_Pink_New_Wu_Jie_Bian_Huan_Twist_Func004Func001A takes nothing returns nothing
if(Trig_Pink_New_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C())then
call GroupRemoveUnitSimple(GetEnumUnit(),udg_Pink_Twist_Group2)
else
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetTriggerUnit(),GetEnumUnit(),((((I2R(GetHeroStr(GetTriggerUnit(),true))+I2R(GetHeroAgi(GetTriggerUnit(),true)))+I2R(GetHeroInt(GetTriggerUnit(),true)))*SquareRoot(I2R(GetHeroLevel(GetTriggerUnit()))))/ 2.00),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endif
endfunction
function Trig_Pink_New_Wu_Jie_Bian_Huan_Twist_Func005A takes nothing returns nothing
call PauseUnitBJ(false,GetEnumUnit())
endfunction
function Trig_Pink_New_Wu_Jie_Bian_Huan_Twist_Actions takes nothing returns nothing
set udg_Pink_Twist_Group1=GetUnitsInRangeOfLocMatching(512,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_Pink_New_Wu_Jie_Bian_Huan_Twist_Func002002003))
call ForGroupBJ(udg_Pink_Twist_Group1,function Trig_Pink_New_Wu_Jie_Bian_Huan_Twist_Func003A)
set udg_Pink_Twist_Loop=1
loop
exitwhen udg_Pink_Twist_Loop>4
call ForGroupBJ(udg_Pink_Twist_Group2,function Trig_Pink_New_Wu_Jie_Bian_Huan_Twist_Func004Func001A)
call TriggerSleepAction(0.80)
set udg_Pink_Twist_Loop=udg_Pink_Twist_Loop+1
endloop
call ForGroupBJ(udg_Pink_Twist_Group2,function Trig_Pink_New_Wu_Jie_Bian_Huan_Twist_Func005A)
call GroupClear(udg_Pink_Twist_Group1)
call GroupClear(udg_Pink_Twist_Group2)
endfunction
function InitTrig_Pink_New_Wu_Jie_Bian_Huan_Twist takes nothing returns nothing
set gg_trg_Pink_New_Wu_Jie_Bian_Huan_Twist=CreateTrigger()
call TriggerRegisterPlayerUnitEventSimple(gg_trg_Pink_New_Wu_Jie_Bian_Huan_Twist,Player(7),EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_Pink_New_Wu_Jie_Bian_Huan_Twist,Condition(function Trig_Pink_New_Wu_Jie_Bian_Huan_Twist_Conditions))
call TriggerAddAction(gg_trg_Pink_New_Wu_Jie_Bian_Huan_Twist,function Trig_Pink_New_Wu_Jie_Bian_Huan_Twist_Actions)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Conditions takes nothing returns boolean
if(not(GetAttacker()==udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))then
return false
endif
if(not(IsPlayerEnemy(GetOwningPlayer(GetTriggerUnit()),GetOwningPlayer(GetAttacker()))==true))then
return false
endif
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==true))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func002Func007001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func002Func007001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func002Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func002Func007001003001(),Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func002Func007001003002())
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func002Func007A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\Starfall\\StarfallTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((I2R(GetHeroStr(GetAttacker(),true))*SquareRoot(I2R(GetHeroLevel(GetAttacker()))))*GetRandomReal(2.00,5.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func002C takes nothing returns boolean
if(not(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]<=2))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func007Func001001 takes nothing returns boolean
return(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==3)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func007Func001002 takes nothing returns boolean
return(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==4)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func007Func007001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func007Func007001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func007Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func007Func007001003001(),Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func007Func007001003002())
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func007Func007A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\Blizzard\\BlizzardTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((I2R(GetHeroAgi(GetAttacker(),true))*SquareRoot(I2R(GetHeroLevel(GetAttacker()))))*GetRandomReal(2.00,5.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func007C takes nothing returns boolean
if(not GetBooleanOr(Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func007Func001001(),Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func007Func001002()))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func008Func001001 takes nothing returns boolean
return(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==5)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func008Func001002 takes nothing returns boolean
return(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==6)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func008Func007001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func008Func007001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func008Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func008Func007001003001(),Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func008Func007001003002())
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func008Func007A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((I2R(GetHeroInt(GetAttacker(),true))*SquareRoot(I2R(GetHeroLevel(GetAttacker()))))*GetRandomReal(2.00,5.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func008C takes nothing returns boolean
if(not GetBooleanOr(Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func008Func001001(),Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func008Func001002()))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func009Func007001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func009Func007001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func009Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func009Func007001003001(),Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func009Func007001003002())
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func009Func007A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),(((I2R(GetHeroInt(GetAttacker(),true))+I2R(GetHeroStr(GetAttacker(),true)))*SquareRoot(I2R(GetHeroLevel(GetAttacker()))))*GetRandomReal(2.00,5.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func009C takes nothing returns boolean
if(not(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==7))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func010Func006001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func010Func006001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func010Func006001003 takes nothing returns boolean
return GetBooleanAnd(Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func010Func006001003001(),Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func010Func006001003002())
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func010Func006A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetAttacker()),"Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),(((I2R(GetHeroAgi(GetAttacker(),true))+I2R(GetHeroStr(GetAttacker(),true)))*SquareRoot(I2R(GetHeroLevel(GetAttacker()))))*GetRandomReal(2.00,5.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func010C takes nothing returns boolean
if(not(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==8))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func011Func006001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func011Func006001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func011Func006001003 takes nothing returns boolean
return GetBooleanAnd(Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func011Func006001003001(),Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func011Func006001003002())
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func011Func006A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),(((I2R(GetHeroAgi(GetAttacker(),true))+I2R(GetHeroInt(GetAttacker(),true)))*SquareRoot(I2R(GetHeroLevel(GetAttacker()))))*GetRandomReal(2.00,5.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func011C takes nothing returns boolean
if(not(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==9))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func012C takes nothing returns boolean
if(not(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==10))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func013C takes nothing returns boolean
if(not(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==11))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Actions takes nothing returns nothing
set udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]=GetRandomInt(1,200)
if(Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func002C())then
call CreateTextTagUnitBJ("|cFF00FF00北|r|cFFFFFF00斗|r|cFFFFAA00伏|r|cFFFF5500魔|r",GetAttacker(),0,15.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching((SquareRoot((I2R(GetHeroInt(GetAttacker(),true))*(I2R(GetHeroLevel(GetAttacker()))/ 3.00)))+500.00),GetUnitLoc(GetAttackedUnitBJ()),Condition(function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func002Func007001003)),function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func002Func007A)
call DestroyGroup(GetLastCreatedGroup())
else
endif
if(Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func007C())then
call CreateTextTagUnitBJ("|cFF00FF00风|r|cFFFFFF00雪|r|cFFFFAA00冰|r|cFFFF5500天|r",GetAttacker(),0,15.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching((SquareRoot((I2R(GetHeroInt(GetAttacker(),true))*(I2R(GetHeroLevel(GetAttacker()))/ 3.00)))+500.00),GetUnitLoc(GetAttackedUnitBJ()),Condition(function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func007Func007001003)),function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func007Func007A)
call DestroyGroup(GetLastCreatedGroup())
else
endif
if(Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func008C())then
call CreateTextTagUnitBJ("|cFF00FF00雷|r|cFFFFFF00荧|r|cFFFFAA00万|r|cFFFF5500钧|r",GetAttacker(),0,15.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching((SquareRoot((I2R(GetHeroInt(GetAttacker(),true))*(I2R(GetHeroLevel(GetAttacker()))/ 3.00)))+500.00),GetUnitLoc(GetAttackedUnitBJ()),Condition(function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func008Func007001003)),function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func008Func007A)
call DestroyGroup(GetLastCreatedGroup())
else
endif
if(Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func009C())then
call CreateTextTagUnitBJ("|cFF00FF00末|r|cFFFFFF00日|r|cFFFFAA00审|r|cFFFF5500判|r",GetAttacker(),0,20.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(512.00,GetUnitLoc(GetAttackedUnitBJ()),Condition(function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func009Func007001003)),function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func009Func007A)
call DestroyGroup(GetLastCreatedGroup())
else
endif
if(Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func010C())then
call CreateTextTagUnitBJ("|cFF00FF00雷|r|cFFFFFF00霆|r|cFFFFAA00一|r|cFFFF5500击|r",GetAttacker(),0,20.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(450.00,GetUnitLoc(GetAttackedUnitBJ()),Condition(function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func010Func006001003)),function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func010Func006A)
call DestroyGroup(GetLastCreatedGroup())
else
endif
if(Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func011C())then
call CreateTextTagUnitBJ("|cFF00FF00神|r|cFFFFFF00罚|r|cFFFFAA00时|r|cFFFF5500刻|r",GetAttacker(),0,20.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(512.00,GetUnitLoc(GetAttackedUnitBJ()),Condition(function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func011Func006001003)),function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func011Func006A)
call DestroyGroup(GetLastCreatedGroup())
else
endif
if(Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func012C())then
call CreateTextTagUnitBJ("|cFF00FF00死|r|cFFFFFF00亡|r|cFFFFAA00一|r|cFFFF5500击|r",GetAttacker(),0,25.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call AddSpecialEffectLocBJ(GetUnitLoc(GetTriggerUnit()),"Abilities\\Spells\\Undead\\DeathCoil\\DeathCoilSpecialArt.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetTriggerUnit(),(((I2R(GetHeroAgi(GetAttacker(),true))+(I2R(GetHeroStr(GetAttacker(),true))+I2R(GetHeroInt(GetAttacker(),true))))*SquareRoot(I2R(GetHeroLevel(GetAttacker()))))*GetRandomReal(2.00,4.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
else
endif
if(Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Func013C())then
call CreateTextTagUnitBJ("|cFF00FF00毁|r|cFFFFFF00灭|r|cFFFFAA00一|r|cFFFF5500击|r",GetAttacker(),0,25.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\Demon\\DarkPortal\\DarkPortalTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetTriggerUnit(),(((I2R(GetHeroAgi(GetAttacker(),true))+(I2R(GetHeroStr(GetAttacker(),true))+I2R(GetHeroInt(GetAttacker(),true))))*SquareRoot(I2R(GetHeroLevel(GetAttacker()))))*GetRandomReal(4.00,6.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
else
endif
endfunction
function InitTrig_New_Wu_Jie_Bian_Huan_Ablity_1 takes nothing returns nothing
set gg_trg_New_Wu_Jie_Bian_Huan_Ablity_1=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_New_Wu_Jie_Bian_Huan_Ablity_1,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_New_Wu_Jie_Bian_Huan_Ablity_1,Condition(function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Conditions))
call TriggerAddAction(gg_trg_New_Wu_Jie_Bian_Huan_Ablity_1,function Trig_New_Wu_Jie_Bian_Huan_Ablity_1_Actions)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Conditions takes nothing returns boolean
if(not(IsUnitIllusionBJ(GetAttacker())==true))then
return false
endif
if(not(IsPlayerEnemy(GetOwningPlayer(GetTriggerUnit()),GetOwningPlayer(GetAttacker()))==true))then
return false
endif
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==true))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func002Func007001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func002Func007001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func002Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func002Func007001003001(),Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func002Func007001003002())
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func002Func007A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\Starfall\\StarfallTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetEnumUnit(),((I2R(GetHeroStr(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))*SquareRoot(I2R(GetHeroLevel(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))))*GetRandomReal(1.00,3.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func002C takes nothing returns boolean
if(not(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]<=2))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func007Func001001 takes nothing returns boolean
return(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==3)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func007Func001002 takes nothing returns boolean
return(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==4)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func007Func007001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func007Func007001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func007Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func007Func007001003001(),Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func007Func007001003002())
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func007Func007A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\Blizzard\\BlizzardTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetEnumUnit(),((I2R(GetHeroAgi(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))*SquareRoot(I2R(GetHeroLevel(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))))*GetRandomReal(1.00,3.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func007C takes nothing returns boolean
if(not GetBooleanOr(Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func007Func001001(),Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func007Func001002()))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func008Func001001 takes nothing returns boolean
return(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==5)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func008Func001002 takes nothing returns boolean
return(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==6)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func008Func007001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func008Func007001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func008Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func008Func007001003001(),Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func008Func007001003002())
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func008Func007A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetEnumUnit(),((I2R(GetHeroInt(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))*SquareRoot(I2R(GetHeroLevel(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))))*GetRandomReal(1.00,3.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func008C takes nothing returns boolean
if(not GetBooleanOr(Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func008Func001001(),Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func008Func001002()))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func009Func007001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func009Func007001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func009Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func009Func007001003001(),Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func009Func007001003002())
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func009Func007A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetEnumUnit(),(((I2R(GetHeroInt(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))+I2R(GetHeroStr(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true)))*SquareRoot(I2R(GetHeroLevel(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))))*GetRandomReal(2.00,4.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func009C takes nothing returns boolean
if(not(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==7))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func010Func006001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func010Func006001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func010Func006001003 takes nothing returns boolean
return GetBooleanAnd(Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func010Func006001003001(),Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func010Func006001003002())
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func010Func006A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetAttacker()),"Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetEnumUnit(),(((I2R(GetHeroAgi(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))+I2R(GetHeroStr(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true)))*SquareRoot(I2R(GetHeroLevel(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))))*GetRandomReal(2.00,4.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func010C takes nothing returns boolean
if(not(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==8))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func011Func006001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func011Func006001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))==true)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func011Func006001003 takes nothing returns boolean
return GetBooleanAnd(Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func011Func006001003001(),Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func011Func006001003002())
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func011Func006A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetEnumUnit(),(((I2R(GetHeroAgi(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))+I2R(GetHeroInt(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true)))*SquareRoot(I2R(GetHeroLevel(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))))*GetRandomReal(2.00,4.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func011C takes nothing returns boolean
if(not(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==9))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func012C takes nothing returns boolean
if(not(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==10))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func013C takes nothing returns boolean
if(not(udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==11))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Actions takes nothing returns nothing
set udg_iNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]=GetRandomInt(1,200)
if(Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func002C())then
call CreateTextTagUnitBJ("|cFF00FF00北|r|cFFFFFF00斗|r|cFFFFAA00伏|r|cFFFF5500魔|r",GetAttacker(),0,15.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching((SquareRoot((I2R(GetHeroInt(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))*(I2R(GetHeroLevel(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))/ 3.00)))+500.00),GetUnitLoc(GetAttackedUnitBJ()),Condition(function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func002Func007001003)),function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func002Func007A)
call DestroyGroup(GetLastCreatedGroup())
else
endif
if(Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func007C())then
call CreateTextTagUnitBJ("|cFF00FF00风|r|cFFFFFF00雪|r|cFFFFAA00冰|r|cFFFF5500天|r",GetAttacker(),0,15.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching((SquareRoot((I2R(GetHeroInt(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))*(I2R(GetHeroLevel(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))/ 3.00)))+500.00),GetUnitLoc(GetAttackedUnitBJ()),Condition(function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func007Func007001003)),function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func007Func007A)
call DestroyGroup(GetLastCreatedGroup())
else
endif
if(Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func008C())then
call CreateTextTagUnitBJ("|cFF00FF00雷|r|cFFFFFF00荧|r|cFFFFAA00万|r|cFFFF5500钧|r",GetAttacker(),0,15.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching((SquareRoot((I2R(GetHeroInt(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))*(I2R(GetHeroLevel(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))/ 3.00)))+500.00),GetUnitLoc(GetAttackedUnitBJ()),Condition(function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func008Func007001003)),function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func008Func007A)
call DestroyGroup(GetLastCreatedGroup())
else
endif
if(Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func009C())then
call CreateTextTagUnitBJ("|cFF00FF00末|r|cFFFFFF00日|r|cFFFFAA00审|r|cFFFF5500判|r",GetAttacker(),0,20.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(512.00,GetUnitLoc(GetAttackedUnitBJ()),Condition(function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func009Func007001003)),function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func009Func007A)
call DestroyGroup(GetLastCreatedGroup())
else
endif
if(Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func010C())then
call CreateTextTagUnitBJ("|cFF00FF00雷|r|cFFFFFF00霆|r|cFFFFAA00一|r|cFFFF5500击|r",GetAttacker(),0,20.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(450.00,GetUnitLoc(GetAttackedUnitBJ()),Condition(function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func010Func006001003)),function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func010Func006A)
call DestroyGroup(GetLastCreatedGroup())
else
endif
if(Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func011C())then
call CreateTextTagUnitBJ("|cFF00FF00神|r|cFFFFFF00罚|r|cFFFFAA00时|r|cFFFF5500刻|r",GetAttacker(),0,20.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(512.00,GetUnitLoc(GetAttackedUnitBJ()),Condition(function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func011Func006001003)),function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func011Func006A)
call DestroyGroup(GetLastCreatedGroup())
else
endif
if(Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func012C())then
call CreateTextTagUnitBJ("|cFF00FF00死|r|cFFFFFF00亡|r|cFFFFAA00一|r|cFFFF5500击|r",GetAttacker(),0,25.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call AddSpecialEffectLocBJ(GetUnitLoc(GetTriggerUnit()),"Abilities\\Spells\\Undead\\DeathCoil\\DeathCoilSpecialArt.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetTriggerUnit(),(((I2R(GetHeroAgi(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))+(I2R(GetHeroStr(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))+I2R(GetHeroInt(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))))*SquareRoot(I2R(GetHeroLevel(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))))*GetRandomReal(1.00,3.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
else
endif
if(Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Func013C())then
call CreateTextTagUnitBJ("|cFF00FF00毁|r|cFFFFFF00灭|r|cFFFFAA00一|r|cFFFF5500击|r",GetAttacker(),0,25.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\Demon\\DarkPortal\\DarkPortalTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetTriggerUnit(),(((I2R(GetHeroAgi(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))+(I2R(GetHeroStr(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))+I2R(GetHeroInt(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))))*SquareRoot(I2R(GetHeroLevel(udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))))*GetRandomReal(4.00,6.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
else
endif
endfunction
function InitTrig_New_Wu_Jie_Bian_Huan_Ablity_2 takes nothing returns nothing
set gg_trg_New_Wu_Jie_Bian_Huan_Ablity_2=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_New_Wu_Jie_Bian_Huan_Ablity_2,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_New_Wu_Jie_Bian_Huan_Ablity_2,Condition(function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Conditions))
call TriggerAddAction(gg_trg_New_Wu_Jie_Bian_Huan_Ablity_2,function Trig_New_Wu_Jie_Bian_Huan_Ablity_2_Actions)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Life_Conditions takes nothing returns boolean
if(not(GetTriggerUnit()==udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))then
return false
endif
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==true))then
return false
endif
if(not(GetUnitLifePercent(GetTriggerUnit())<=20.00))then
return false
endif
if(not(GetRandomReal(1.00,10.00)<=2.00))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Life_Actions takes nothing returns nothing
call CreateTextTagUnitBJ("|cFF00FF00天|r|cFFFFFF00使|r|cFFFFAA00降|r|cFFFF5500临|r",GetTriggerUnit(),0,25.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\Human\\Resurrect\\ResurrectCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitInvulnerable(GetTriggerUnit(),true)
call SetUnitLifePercentBJ(GetTriggerUnit(),100)
call TriggerSleepAction(1.00)
call SetUnitInvulnerable(GetTriggerUnit(),false)
endfunction
function InitTrig_New_Wu_Jie_Bian_Huan_Life takes nothing returns nothing
set gg_trg_New_Wu_Jie_Bian_Huan_Life=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_New_Wu_Jie_Bian_Huan_Life,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_New_Wu_Jie_Bian_Huan_Life,Condition(function Trig_New_Wu_Jie_Bian_Huan_Life_Conditions))
call TriggerAddAction(gg_trg_New_Wu_Jie_Bian_Huan_Life,function Trig_New_Wu_Jie_Bian_Huan_Life_Actions)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Anywhere_Conditions takes nothing returns boolean
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==true))then
return false
endif
if(not(GetIssuedOrderIdBJ()==String2OrderIdBJ("patrol")))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Anywhere_Actions takes nothing returns nothing
call SetUnitPositionLoc(GetTriggerUnit(),GetOrderPointLoc())
call CreateTextTagUnitBJ("|cFF00FF00空|r|cFFFFFF00间|r|cFFFFAA00闪|r|cFFFF5500烁|r",GetTriggerUnit(),0,25.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
endfunction
function InitTrig_New_Wu_Jie_Bian_Huan_Anywhere takes nothing returns nothing
set gg_trg_New_Wu_Jie_Bian_Huan_Anywhere=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_New_Wu_Jie_Bian_Huan_Anywhere,EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
call TriggerAddCondition(gg_trg_New_Wu_Jie_Bian_Huan_Anywhere,Condition(function Trig_New_Wu_Jie_Bian_Huan_Anywhere_Conditions))
call TriggerAddAction(gg_trg_New_Wu_Jie_Bian_Huan_Anywhere,function Trig_New_Wu_Jie_Bian_Huan_Anywhere_Actions)
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Death_Conditions takes nothing returns boolean
if(not(GetTriggerUnit()==udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))then
return false
endif
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==true))then
return false
endif
return true
endfunction
function Trig_New_Wu_Jie_Bian_Huan_Death_Actions takes nothing returns nothing
call ModifyHeroStat(bj_HEROSTAT_STR,GetTriggerUnit(),bj_MODIFYMETHOD_ADD,10)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetTriggerUnit(),bj_MODIFYMETHOD_ADD,10)
call ModifyHeroStat(bj_HEROSTAT_INT,GetTriggerUnit(),bj_MODIFYMETHOD_ADD,10)
endfunction
function InitTrig_New_Wu_Jie_Bian_Huan_Death takes nothing returns nothing
set gg_trg_New_Wu_Jie_Bian_Huan_Death=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_New_Wu_Jie_Bian_Huan_Death,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddCondition(gg_trg_New_Wu_Jie_Bian_Huan_Death,Condition(function Trig_New_Wu_Jie_Bian_Huan_Death_Conditions))
call TriggerAddAction(gg_trg_New_Wu_Jie_Bian_Huan_Death,function Trig_New_Wu_Jie_Bian_Huan_Death_Actions)
endfunction
function Trig_WuJie_Lv_Up_Conditions takes nothing returns boolean
if(not(GetTriggerUnit()==udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))then
return false
endif
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==true))then
return false
endif
return true
endfunction
function Trig_WuJie_Lv_Up_Actions takes nothing returns nothing
call ModifyHeroStat(bj_HEROSTAT_STR,GetTriggerUnit(),bj_MODIFYMETHOD_ADD,6)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetTriggerUnit(),bj_MODIFYMETHOD_ADD,5)
call ModifyHeroStat(bj_HEROSTAT_INT,GetTriggerUnit(),bj_MODIFYMETHOD_ADD,4)
endfunction
function InitTrig_WuJie_Lv_Up takes nothing returns nothing
set gg_trg_WuJie_Lv_Up=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_WuJie_Lv_Up,EVENT_PLAYER_HERO_LEVEL)
call TriggerAddCondition(gg_trg_WuJie_Lv_Up,Condition(function Trig_WuJie_Lv_Up_Conditions))
call TriggerAddAction(gg_trg_WuJie_Lv_Up,function Trig_WuJie_Lv_Up_Actions)
endfunction
function Trig_WuJie_EXE_Conditions takes nothing returns boolean
if(not(GetAttacker()==udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))then
return false
endif
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==true))then
return false
endif
return true
endfunction
function Trig_WuJie_EXE_Func001C takes nothing returns boolean
if(not(GetRandomInt(1,30)==1))then
return false
endif
return true
endfunction
function Trig_WuJie_EXE_Func002C takes nothing returns boolean
if(not(GetRandomInt(1,20)==1))then
return false
endif
return true
endfunction
function Trig_WuJie_EXE_Actions takes nothing returns nothing
if(Trig_WuJie_EXE_Func001C())then
call AddHeroXPSwapped((50*GetHeroLevel(GetAttacker())),GetAttacker(),true)
else
endif
if(Trig_WuJie_EXE_Func002C())then
call AddHeroXPSwapped((10*GetHeroLevel(GetAttacker())),GetAttacker(),true)
else
endif
endfunction
function InitTrig_WuJie_EXE takes nothing returns nothing
set gg_trg_WuJie_EXE=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_WuJie_EXE,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_WuJie_EXE,Condition(function Trig_WuJie_EXE_Conditions))
call TriggerAddAction(gg_trg_WuJie_EXE,function Trig_WuJie_EXE_Actions)
endfunction
function Trig_WuJie_Lv_Up_10_Conditions takes nothing returns boolean
if(not(GetTriggerUnit()==udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))then
return false
endif
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==true))then
return false
endif
return true
endfunction
function Trig_WuJie_Lv_Up_10_Func003C takes nothing returns boolean
if(not(GetHeroLevel(GetTriggerUnit())==10))then
return false
endif
return true
endfunction
function Trig_WuJie_Lv_Up_10_Actions takes nothing returns nothing
if(Trig_WuJie_Lv_Up_10_Func003C())then
call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()),0,0,10.00,"|CFF00FF00英雄等级达到10级，领悟妙手空空技能|R")
else
endif
endfunction
function InitTrig_WuJie_Lv_Up_10 takes nothing returns nothing
set gg_trg_WuJie_Lv_Up_10=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_WuJie_Lv_Up_10,EVENT_PLAYER_HERO_LEVEL)
call TriggerAddCondition(gg_trg_WuJie_Lv_Up_10,Condition(function Trig_WuJie_Lv_Up_10_Conditions))
call TriggerAddAction(gg_trg_WuJie_Lv_Up_10,function Trig_WuJie_Lv_Up_10_Actions)
endfunction
function Trig_WuJie_KongKong_Conditions takes nothing returns boolean
if(not(GetAttacker()==udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))then
return false
endif
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==true))then
return false
endif
return true
endfunction
function Trig_WuJie_KongKong_Func003Func004001 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())>=10)
endfunction
function Trig_WuJie_KongKong_Func003Func004002 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())<20)
endfunction
function Trig_WuJie_KongKong_Func003C takes nothing returns boolean
if(not GetBooleanAnd(Trig_WuJie_KongKong_Func003Func004001(),Trig_WuJie_KongKong_Func003Func004002()))then
return false
endif
if(not(GetRandomInt(1,30)==1))then
return false
endif
return true
endfunction
function Trig_WuJie_KongKong_Func004Func004001 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())>=20)
endfunction
function Trig_WuJie_KongKong_Func004Func004002 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())<30)
endfunction
function Trig_WuJie_KongKong_Func004C takes nothing returns boolean
if(not GetBooleanAnd(Trig_WuJie_KongKong_Func004Func004001(),Trig_WuJie_KongKong_Func004Func004002()))then
return false
endif
if(not(GetRandomInt(1,40)==1))then
return false
endif
return true
endfunction
function Trig_WuJie_KongKong_Func005Func004001 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())>=30)
endfunction
function Trig_WuJie_KongKong_Func005Func004002 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())<40)
endfunction
function Trig_WuJie_KongKong_Func005C takes nothing returns boolean
if(not GetBooleanAnd(Trig_WuJie_KongKong_Func005Func004001(),Trig_WuJie_KongKong_Func005Func004002()))then
return false
endif
if(not(GetRandomInt(1,50)==1))then
return false
endif
return true
endfunction
function Trig_WuJie_KongKong_Func006Func004001 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())>=40)
endfunction
function Trig_WuJie_KongKong_Func006Func004002 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())<50)
endfunction
function Trig_WuJie_KongKong_Func006C takes nothing returns boolean
if(not GetBooleanAnd(Trig_WuJie_KongKong_Func006Func004001(),Trig_WuJie_KongKong_Func006Func004002()))then
return false
endif
if(not(GetRandomInt(1,60)==1))then
return false
endif
return true
endfunction
function Trig_WuJie_KongKong_Func007Func004001 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())>=50)
endfunction
function Trig_WuJie_KongKong_Func007Func004002 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())<60)
endfunction
function Trig_WuJie_KongKong_Func007C takes nothing returns boolean
if(not GetBooleanAnd(Trig_WuJie_KongKong_Func007Func004001(),Trig_WuJie_KongKong_Func007Func004002()))then
return false
endif
if(not(GetRandomInt(1,70)==1))then
return false
endif
return true
endfunction
function Trig_WuJie_KongKong_Func008Func004001 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())>=60)
endfunction
function Trig_WuJie_KongKong_Func008Func004002 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())<70)
endfunction
function Trig_WuJie_KongKong_Func008C takes nothing returns boolean
if(not GetBooleanAnd(Trig_WuJie_KongKong_Func008Func004001(),Trig_WuJie_KongKong_Func008Func004002()))then
return false
endif
if(not(GetRandomInt(1,80)==1))then
return false
endif
return true
endfunction
function Trig_WuJie_KongKong_Func009Func004001 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())>=70)
endfunction
function Trig_WuJie_KongKong_Func009Func004002 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())<80)
endfunction
function Trig_WuJie_KongKong_Func009C takes nothing returns boolean
if(not GetBooleanAnd(Trig_WuJie_KongKong_Func009Func004001(),Trig_WuJie_KongKong_Func009Func004002()))then
return false
endif
if(not(GetRandomInt(1,85)==1))then
return false
endif
return true
endfunction
function Trig_WuJie_KongKong_Func010Func004001 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())>=80)
endfunction
function Trig_WuJie_KongKong_Func010Func004002 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())<90)
endfunction
function Trig_WuJie_KongKong_Func010C takes nothing returns boolean
if(not GetBooleanAnd(Trig_WuJie_KongKong_Func010Func004001(),Trig_WuJie_KongKong_Func010Func004002()))then
return false
endif
if(not(GetRandomInt(1,90)==1))then
return false
endif
return true
endfunction
function Trig_WuJie_KongKong_Func011Func004001 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())>=90)
endfunction
function Trig_WuJie_KongKong_Func011Func004002 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())<100)
endfunction
function Trig_WuJie_KongKong_Func011C takes nothing returns boolean
if(not GetBooleanAnd(Trig_WuJie_KongKong_Func011Func004001(),Trig_WuJie_KongKong_Func011Func004002()))then
return false
endif
if(not(GetRandomInt(1,95)==1))then
return false
endif
return true
endfunction
function Trig_WuJie_KongKong_Func012C takes nothing returns boolean
if(not(GetHeroLevel(GetAttacker())>=100))then
return false
endif
if(not(GetRandomInt(1,100)==1))then
return false
endif
return true
endfunction
function Trig_WuJie_KongKong_Actions takes nothing returns nothing
if(Trig_WuJie_KongKong_Func003C())then
set udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]=((GetRandomInt(1,100)*GetHeroLevel(GetAttacker()))+500)
call AdjustPlayerStateBJ(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetOwningPlayer(GetAttacker()),PLAYER_STATE_RESOURCE_GOLD)
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,("|CFFFFFF00金钱+"+(I2S(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])+"|R")))
else
endif
if(Trig_WuJie_KongKong_Func004C())then
set udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]=((GetRandomInt(1,100)*GetHeroLevel(GetAttacker()))+2000)
call AdjustPlayerStateBJ(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetOwningPlayer(GetAttacker()),PLAYER_STATE_RESOURCE_GOLD)
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,("|CFFFFFF00金钱+"+(I2S(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])+"|R")))
else
endif
if(Trig_WuJie_KongKong_Func005C())then
set udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]=((GetRandomInt(1,100)*GetHeroLevel(GetAttacker()))+3000)
call AdjustPlayerStateBJ(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetOwningPlayer(GetAttacker()),PLAYER_STATE_RESOURCE_GOLD)
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,("|CFFFFFF00金钱+"+(I2S(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])+"|R")))
else
endif
if(Trig_WuJie_KongKong_Func006C())then
set udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]=((GetRandomInt(1,100)*GetHeroLevel(GetAttacker()))+5000)
call AdjustPlayerStateBJ(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetOwningPlayer(GetAttacker()),PLAYER_STATE_RESOURCE_GOLD)
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,("|CFFFFFF00金钱+"+(I2S(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])+"|R")))
else
endif
if(Trig_WuJie_KongKong_Func007C())then
set udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]=((GetRandomInt(1,100)*GetHeroLevel(GetAttacker()))+7500)
call AdjustPlayerStateBJ(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetOwningPlayer(GetAttacker()),PLAYER_STATE_RESOURCE_GOLD)
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,("|CFFFFFF00金钱+"+(I2S(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])+"|R")))
else
endif
if(Trig_WuJie_KongKong_Func008C())then
set udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]=((GetRandomInt(1,100)*GetHeroLevel(GetAttacker()))+10000)
call AdjustPlayerStateBJ(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetOwningPlayer(GetAttacker()),PLAYER_STATE_RESOURCE_GOLD)
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,("|CFFFFFF00金钱+"+(I2S(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])+"|R")))
else
endif
if(Trig_WuJie_KongKong_Func009C())then
set udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]=((GetRandomInt(1,100)*GetHeroLevel(GetAttacker()))+15000)
call AdjustPlayerStateBJ(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetOwningPlayer(GetAttacker()),PLAYER_STATE_RESOURCE_GOLD)
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,("|CFFFFFF00金钱+"+(I2S(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])+"|R")))
else
endif
if(Trig_WuJie_KongKong_Func010C())then
set udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]=((GetRandomInt(1,100)*GetHeroLevel(GetAttacker()))+20000)
call AdjustPlayerStateBJ(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetOwningPlayer(GetAttacker()),PLAYER_STATE_RESOURCE_GOLD)
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,("|CFFFFFF00金钱+"+(I2S(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])+"|R")))
else
endif
if(Trig_WuJie_KongKong_Func011C())then
set udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]=((GetRandomInt(1,100)*GetHeroLevel(GetAttacker()))+30000)
call AdjustPlayerStateBJ(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetOwningPlayer(GetAttacker()),PLAYER_STATE_RESOURCE_GOLD)
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,("|CFFFFFF00金钱+"+(I2S(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])+"|R")))
else
endif
if(Trig_WuJie_KongKong_Func012C())then
set udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]=((GetRandomInt(1,100)*101)+30000)
call AdjustPlayerStateBJ(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetOwningPlayer(GetAttacker()),PLAYER_STATE_RESOURCE_GOLD)
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,("|CFFFFFF00金钱+"+(I2S(udg_WuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])+"|R")))
else
endif
endfunction
function InitTrig_WuJie_KongKong takes nothing returns nothing
set gg_trg_WuJie_KongKong=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_WuJie_KongKong,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_WuJie_KongKong,Condition(function Trig_WuJie_KongKong_Conditions))
call TriggerAddAction(gg_trg_WuJie_KongKong,function Trig_WuJie_KongKong_Actions)
endfunction
function Trig_WuJie_ShuXing_Conditions takes nothing returns boolean
if(not(GetAttacker()==udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))then
return false
endif
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==true))then
return false
endif
if(not(GetRandomInt(1,50)==1))then
return false
endif
return true
endfunction
function Trig_WuJie_ShuXing_Actions takes nothing returns nothing
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,"|cFF00FF00属|r|cFFFFFF00性|r|cFFFFAA00提|r|cFFFF5500升|r")
call CreateTextTagUnitBJ("|cFF00FF00属|r|cFFFFFF00性|r|cFFFFAA00提|r|cFFFF5500升|r",GetAttacker(),0,10.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call ModifyHeroStat(bj_HEROSTAT_STR,GetAttacker(),bj_MODIFYMETHOD_ADD,5)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetAttacker(),bj_MODIFYMETHOD_ADD,4)
call ModifyHeroStat(bj_HEROSTAT_INT,GetAttacker(),bj_MODIFYMETHOD_ADD,3)
endfunction
function InitTrig_WuJie_ShuXing takes nothing returns nothing
set gg_trg_WuJie_ShuXing=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_WuJie_ShuXing,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_WuJie_ShuXing,Condition(function Trig_WuJie_ShuXing_Conditions))
call TriggerAddAction(gg_trg_WuJie_ShuXing,function Trig_WuJie_ShuXing_Actions)
endfunction
function Trig_WuJie_ReAblity_Conditions takes nothing returns boolean
if(not(GetAttacker()==udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))then
return false
endif
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==true))then
return false
endif
if(not(GetRandomInt(1,30)==1))then
return false
endif
return true
endfunction
function Trig_WuJie_ReAblity_Actions takes nothing returns nothing
call UnitResetCooldown(GetAttacker())
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,"|C00FF00FF重置技能CD|R")
endfunction
function InitTrig_WuJie_ReAblity takes nothing returns nothing
set gg_trg_WuJie_ReAblity=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_WuJie_ReAblity,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_WuJie_ReAblity,Condition(function Trig_WuJie_ReAblity_Conditions))
call TriggerAddAction(gg_trg_WuJie_ReAblity,function Trig_WuJie_ReAblity_Actions)
endfunction
function Trig_WuJie_FanDan_Conditions takes nothing returns boolean
if(not(GetTriggerUnit()==udg_playerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))then
return false
endif
if(not(udg_bWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==true))then
return false
endif
if(not(GetRandomInt(1,3)==1))then
return false
endif
return true
endfunction
function Trig_WuJie_FanDan_Func003C takes nothing returns boolean
if(not(IsUnitType(GetAttacker(),UNIT_TYPE_HERO)==true))then
return false
endif
return true
endfunction
function Trig_WuJie_FanDan_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetAttacker(),"Abilities\\Spells\\Other\\ForkedLightning\\ForkedLightningTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
if(Trig_WuJie_FanDan_Func003C())then
call UnitDamageTargetBJ(GetTriggerUnit(),GetAttacker(),((((I2R(GetHeroStr(GetTriggerUnit(),true))+I2R(GetHeroAgi(GetTriggerUnit(),true)))+I2R(GetHeroInt(GetTriggerUnit(),true)))*2.00)+(GetUnitStateSwap(UNIT_STATE_MAX_LIFE,GetAttacker())/ 200.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_SHADOW_STRIKE)
else
call UnitDamageTargetBJ(GetTriggerUnit(),GetAttacker(),((((I2R(GetHeroStr(GetTriggerUnit(),true))+I2R(GetHeroAgi(GetTriggerUnit(),true)))+I2R(GetHeroInt(GetTriggerUnit(),true)))*2.00)+(GetUnitStateSwap(UNIT_STATE_MAX_LIFE,GetAttacker())/ 50.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_SHADOW_STRIKE)
endif
endfunction
function InitTrig_WuJie_FanDan takes nothing returns nothing
set gg_trg_WuJie_FanDan=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_WuJie_FanDan,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_WuJie_FanDan,Condition(function Trig_WuJie_FanDan_Conditions))
call TriggerAddAction(gg_trg_WuJie_FanDan,function Trig_WuJie_FanDan_Actions)
endfunction
function Wu_Jie_Bian_Huan_2 takes nothing returns nothing
call InitTrig_New_Wu_Jie_Bian_Huan_Start()
call InitTrig_Cloce_Wu_Jie_Bian_Huan()
call InitTrig_Wu_Jie_Help()
call InitTrig_Red_Fire_Up()
call InitTrig_Red_Fire_Left()
call InitTrig_Red_Fire_Down()
call InitTrig_Red_Fire_Right()
call InitTrig_Red_Fire()
call InitTrig_Red_New_Wu_Jie_Bian_Huan_Twist()
call InitTrig_Blue_Ice_Left()
call InitTrig_Blue_Ice_Down()
call InitTrig_Blue_Ice_Right()
call InitTrig_Blue_Ice_Up()
call InitTrig_Blue_Ice()
call InitTrig_Blue_New_Wu_Jie_Bian_Huan_Twist()
call InitTrig_Cyan_Bolt_Down()
call InitTrig_Cyan_Bolt_Right()
call InitTrig_Cyan_Bolt_Up()
call InitTrig_Cyan_Bolt_Left()
call InitTrig_Cyan_Bolt()
call InitTrig_Cyan_New_Wu_Jie_Bian_Huan_Twist()
call InitTrig_Purple_Moon_Right()
call InitTrig_Purple_Moon_Up()
call InitTrig_Purple_Moon_Left()
call InitTrig_Purple_Moon_Down()
call InitTrig_Purple_Moon()
call InitTrig_Purple_New_Wu_Jie_Bian_Huan_Twist()
call InitTrig_Yellow_Light_Up()
call InitTrig_Yellow_Light_Right()
call InitTrig_Yellow_Light_Down()
call InitTrig_Yellow_Light_Left()
call InitTrig_Yellow_Light()
call InitTrig_Yellow_New_Wu_Jie_Bian_Huan_Twist()
call InitTrig_Orange_Wind_Right()
call InitTrig_Orange_Wind_Down()
call InitTrig_Orange_Wind_Left()
call InitTrig_Orange_Wind_Up()
call InitTrig_Orange_Wind()
call InitTrig_Orange_New_Wu_Jie_Bian_Huan_Twist()
call InitTrig_Green_Wood_Down()
call InitTrig_Green_Wood_Left()
call InitTrig_Green_Wood_Up()
call InitTrig_Green_Wood_Right()
call InitTrig_Green_Wood()
call InitTrig_Green_New_Wu_Jie_Bian_Huan_Twist()
call InitTrig_Pink_Pink_Left()
call InitTrig_Pink_Pink_Up()
call InitTrig_Pink_Pink_Right()
call InitTrig_Pink_Pink_Down()
call InitTrig_Pink_Pink_Pink()
call InitTrig_Pink_New_Wu_Jie_Bian_Huan_Twist()
call InitTrig_New_Wu_Jie_Bian_Huan_Ablity_1()
call InitTrig_New_Wu_Jie_Bian_Huan_Ablity_2()
call InitTrig_New_Wu_Jie_Bian_Huan_Life()
call InitTrig_New_Wu_Jie_Bian_Huan_Anywhere()
call InitTrig_New_Wu_Jie_Bian_Huan_Death()
call InitTrig_WuJie_Lv_Up()
call InitTrig_WuJie_EXE()
call InitTrig_WuJie_Lv_Up_10()
call InitTrig_WuJie_KongKong()
call InitTrig_WuJie_ShuXing()
call InitTrig_WuJie_ReAblity()
call InitTrig_WuJie_FanDan()
endfunction
function Wu_Jie_Bian_Huan_3 takes nothing returns nothing
call ConditionalTriggerExecute(gg_trg_New_Wu_Jie_Bian_Huan_Start)
endfunction
