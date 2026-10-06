function fengLodWu_Jie_Bian_Huan_1 takes nothing returns nothing
local integer i=0
set i=0
loop
exitwhen(i>8)
set udg_fengLodbWu_Jie_Bian_Huan[i]=false
set i=i+1
endloop
set udg_fengLodRed_Twist_Group1=CreateGroup()
set udg_fengLodRed_Twist_Group2=CreateGroup()
set udg_fengLodRed_Twist_Loop=0
set udg_fengLodBlue_Twist_Group1=CreateGroup()
set udg_fengLodBlue_Twist_Group2=CreateGroup()
set udg_fengLodBlue_Twist_Loop=0
set udg_fengLodCyan_Twist_Group1=CreateGroup()
set udg_fengLodCyan_Twist_Group2=CreateGroup()
set udg_fengLodCyan_Twist_Loop=0
set udg_fengLodPurple_Twist_Group1=CreateGroup()
set udg_fengLodPurple_Twist_Group2=CreateGroup()
set udg_fengLodPurple_Twist_Loop=0
set udg_fengLodYellow_Twist_Group1=CreateGroup()
set udg_fengLodYellow_Twist_Group2=CreateGroup()
set udg_fengLodYellow_Twist_Loop=0
set udg_fengLodOrange_Twist_Group1=CreateGroup()
set udg_fengLodOrange_Twist_Group2=CreateGroup()
set udg_fengLodOrange_Twist_Loop=0
set udg_fengLodGreen_Twist_Group1=CreateGroup()
set udg_fengLodGreen_Twist_Group2=CreateGroup()
set udg_fengLodGreen_Twist_Loop=0
set udg_fengLodPink_Twist_Group1=CreateGroup()
set udg_fengLodPink_Twist_Group2=CreateGroup()
set udg_fengLodPink_Twist_Loop=0
set i=0
loop
exitwhen(i>8)
set udg_fengLodiNew_Wu_Jie_Ablity[i]=0
set i=i+1
endloop
set i=0
loop
exitwhen(i>8)
set udg_fengLodiWuJie_Manoy[i]=0
set i=i+1
endloop
set udg_fengLodWuJiw_Help=""
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Start_Actions takes nothing returns nothing

endfunction
function InitTrig_fengLodNew_Wu_Jie_Bian_Huan_Start takes nothing returns nothing
set gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Start=CreateTrigger()
call TriggerAddAction(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Start,function Trig_fengLodNew_Wu_Jie_Bian_Huan_Start_Actions)
endfunction
function Trig_fengLodCloce_Wu_Jie_Bian_Huan_Conditions takes nothing returns boolean
if(not(udg_fengLodbWu_Jie_Bian_Huan[GetConvertedPlayerId(GetTriggerPlayer())]==true))then
return false
endif
return true
endfunction
function Trig_fengLodCloce_Wu_Jie_Bian_Huan_Actions takes nothing returns nothing
set udg_fengLodbWu_Jie_Bian_Huan[GetConvertedPlayerId(GetTriggerPlayer())]=false
call SetUnitVertexColor(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetTriggerPlayer())],255,255,255,255)
set udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetTriggerPlayer())]=null
call DisplayTimedTextToForce(GetPlayersAll(),10.00,(GetPlayerName(GetTriggerPlayer())+"|C00FF00FF关闭了无界隐藏技能模式|R|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000　III|r"))
call DisplayTimedTextToForce(GetPlayersAll(),10.00,"|CFF00FF00你已经成功关闭无界作弊脚本，|R|CFF00FFFF当然要是想要再开启可根据刚才步骤重新再开启|R")
endfunction
function InitTrig_fengLodCloce_Wu_Jie_Bian_Huan takes nothing returns nothing
set gg_trg_fengLodCloce_Wu_Jie_Bian_Huan=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_fengLodCloce_Wu_Jie_Bian_Huan,Player(0),"变幻",true)
call TriggerRegisterPlayerChatEvent(gg_trg_fengLodCloce_Wu_Jie_Bian_Huan,Player(1),"变幻",true)
call TriggerRegisterPlayerChatEvent(gg_trg_fengLodCloce_Wu_Jie_Bian_Huan,Player(2),"变幻",true)
call TriggerRegisterPlayerChatEvent(gg_trg_fengLodCloce_Wu_Jie_Bian_Huan,Player(3),"变幻",true)
call TriggerRegisterPlayerChatEvent(gg_trg_fengLodCloce_Wu_Jie_Bian_Huan,Player(4),"变幻",true)
call TriggerRegisterPlayerChatEvent(gg_trg_fengLodCloce_Wu_Jie_Bian_Huan,Player(5),"变幻",true)
call TriggerRegisterPlayerChatEvent(gg_trg_fengLodCloce_Wu_Jie_Bian_Huan,Player(6),"变幻",true)
call TriggerRegisterPlayerChatEvent(gg_trg_fengLodCloce_Wu_Jie_Bian_Huan,Player(7),"变幻",true)
call TriggerAddCondition(gg_trg_fengLodCloce_Wu_Jie_Bian_Huan,Condition(function Trig_fengLodCloce_Wu_Jie_Bian_Huan_Conditions))
call TriggerAddAction(gg_trg_fengLodCloce_Wu_Jie_Bian_Huan,function Trig_fengLodCloce_Wu_Jie_Bian_Huan_Actions)
endfunction
function Trig_fengLodWu_Jie_Help_Actions takes nothing returns nothing
call CreateQuestBJ(bj_QUESTTYPE_OPT_DISCOVERED,"|CFF00FF00无界变幻III变态命令开启版|R","|CFF00FF00脚本修改|R|CFF00FFFF hellour|R","ReplaceableTextures\\CommandButtons\\BTNManaShield.blp")
call DisplayTimedTextToForce(GetPlayersAll(),10.00,"|CFF00FF00脚本修改|R|CFF00FFFF hellour|R")
endfunction
function InitTrig_fengLodWu_Jie_Help takes nothing returns nothing
set gg_trg_fengLodWu_Jie_Help=CreateTrigger()
call TriggerRegisterTimerEventSingle(gg_trg_fengLodWu_Jie_Help,5)
call TriggerAddAction(gg_trg_fengLodWu_Jie_Help,function Trig_fengLodWu_Jie_Help_Actions)
endfunction
function Trig_fengLodRed_Fire_Up_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_fengLodRed_Fire_Left)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_fengLodRed_Fire_Left)
endfunction
function InitTrig_fengLodRed_Fire_Up takes nothing returns nothing
set gg_trg_fengLodRed_Fire_Up=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_fengLodRed_Fire_Up,Player(0),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerAddAction(gg_trg_fengLodRed_Fire_Up,function Trig_fengLodRed_Fire_Up_Actions)
endfunction
function Trig_fengLodRed_Fire_Left_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_fengLodRed_Fire_Down)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_fengLodRed_Fire_Down)
endfunction
function InitTrig_fengLodRed_Fire_Left takes nothing returns nothing
set gg_trg_fengLodRed_Fire_Left=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_fengLodRed_Fire_Left,Player(0),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_LEFT)
call TriggerAddAction(gg_trg_fengLodRed_Fire_Left,function Trig_fengLodRed_Fire_Left_Actions)
endfunction
function Trig_fengLodRed_Fire_Down_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_fengLodRed_Fire_Right)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_fengLodRed_Fire_Right)
endfunction
function InitTrig_fengLodRed_Fire_Down takes nothing returns nothing
set gg_trg_fengLodRed_Fire_Down=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_fengLodRed_Fire_Down,Player(0),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerAddAction(gg_trg_fengLodRed_Fire_Down,function Trig_fengLodRed_Fire_Down_Actions)
endfunction
function Trig_fengLodRed_Fire_Right_Actions takes nothing returns nothing

endfunction
function InitTrig_fengLodRed_Fire_Right takes nothing returns nothing
set gg_trg_fengLodRed_Fire_Right=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_fengLodRed_Fire_Right,Player(0),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_RIGHT)
call TriggerAddAction(gg_trg_fengLodRed_Fire_Right,function Trig_fengLodRed_Fire_Right_Actions)
endfunction
function Trig_fengLodRed_Fire_Conditions takes nothing returns boolean
if(not(IsUnitType(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetOwningPlayer(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())))==Player(0)))then
return false
endif
return true
endfunction
function Trig_fengLodRed_Fire_Actions takes nothing returns nothing
set udg_fengLodbWu_Jie_Bian_Huan[GetConvertedPlayerId(GetTriggerPlayer())]=true
set udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetTriggerPlayer())]=FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))
call EnableTrigger(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1)
call EnableTrigger(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Life)
call EnableTrigger(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Anywhere)
call EnableTrigger(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Death)
call EnableTrigger(gg_trg_fengLodRed_fengLodNew_Wu_Jie_Bian_Huan_Twist)
call PanCameraToTimedLocForPlayer(Player(0),GetUnitLoc(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))),0)
call DisplayTimedTextToForce(GetPlayersAll(),10.00,(GetPlayerName(GetTriggerPlayer())+"|C00FF00FF开启了无界隐藏技能模式|R|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r"))
call DisplayTimedTextToForce(GetPlayersAll(),10.00,"|CFF00FF00恭喜红色玩家开启无界作弊脚本，变身后可输入“变幻”关闭无界作弊脚本|R")
call SetUnitVertexColor(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),255,0,0,255)
call SetUnitMoveSpeed(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),522.00)
call CreateTextTagUnitBJ("|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r",FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),0,30.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),50.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call AddSpecialEffectTargetUnitBJ("overhead",FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),"Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
endfunction
function InitTrig_fengLodRed_Fire takes nothing returns nothing
set gg_trg_fengLodRed_Fire=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_fengLodRed_Fire,Player(0),"红天使",true)
call TriggerAddCondition(gg_trg_fengLodRed_Fire,Condition(function Trig_fengLodRed_Fire_Conditions))
call TriggerAddAction(gg_trg_fengLodRed_Fire,function Trig_fengLodRed_Fire_Actions)
endfunction
function Trig_fengLodRed_fengLodNew_Wu_Jie_Bian_Huan_Twist_Conditions takes nothing returns boolean
if(not(udg_fengLodbWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))))]==true))then
return false
endif
if(not(IsUnitType(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_fengLodRed_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_fengLodRed_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))))]))==true)
endfunction
function Trig_fengLodRed_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003 takes nothing returns boolean
return GetBooleanAnd(Trig_fengLodRed_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003001(),Trig_fengLodRed_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003002())
endfunction
function Trig_fengLodRed_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func003A takes nothing returns nothing
call GroupAddUnitSimple(GetEnumUnit(),udg_fengLodRed_Twist_Group2)
call PauseUnitBJ(true,GetEnumUnit())
endfunction
function Trig_fengLodRed_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C takes nothing returns boolean
if(not(IsUnitAliveBJ(GetEnumUnit())==false))then
return false
endif
return true
endfunction
function Trig_fengLodRed_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func004Func001A takes nothing returns nothing
if(Trig_fengLodRed_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C())then
call GroupRemoveUnitSimple(GetEnumUnit(),udg_fengLodRed_Twist_Group2)
else
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),GetEnumUnit(),((((I2R(GetHeroStr(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),true))+I2R(GetHeroAgi(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),true)))+I2R(GetHeroInt(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),true)))*SquareRoot(I2R(GetHeroLevel(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))))))/ 2.00),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endif
endfunction
function Trig_fengLodRed_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func005A takes nothing returns nothing
call PauseUnitBJ(false,GetEnumUnit())
endfunction
function Trig_fengLodRed_fengLodNew_Wu_Jie_Bian_Huan_Twist_Actions takes nothing returns nothing
set udg_fengLodRed_Twist_Group1=GetUnitsInRangeOfLocMatching(512,GetUnitLoc(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))),Condition(function Trig_fengLodRed_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003))
call ForGroupBJ(udg_fengLodRed_Twist_Group1,function Trig_fengLodRed_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func003A)
set udg_fengLodRed_Twist_Loop=1
loop
exitwhen udg_fengLodRed_Twist_Loop>4
call ForGroupBJ(udg_fengLodRed_Twist_Group2,function Trig_fengLodRed_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func004Func001A)
call TriggerSleepAction(0.80)
set udg_fengLodRed_Twist_Loop=udg_fengLodRed_Twist_Loop+1
endloop
call ForGroupBJ(udg_fengLodRed_Twist_Group2,function Trig_fengLodRed_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func005A)
call GroupClear(udg_fengLodRed_Twist_Group1)
call GroupClear(udg_fengLodRed_Twist_Group2)
endfunction
function InitTrig_fengLodRed_fengLodNew_Wu_Jie_Bian_Huan_Twist takes nothing returns nothing
set gg_trg_fengLodRed_fengLodNew_Wu_Jie_Bian_Huan_Twist=CreateTrigger()
call TriggerRegisterPlayerUnitEventSimple(gg_trg_fengLodRed_fengLodNew_Wu_Jie_Bian_Huan_Twist,Player(0),EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_fengLodRed_fengLodNew_Wu_Jie_Bian_Huan_Twist,Condition(function Trig_fengLodRed_fengLodNew_Wu_Jie_Bian_Huan_Twist_Conditions))
call TriggerAddAction(gg_trg_fengLodRed_fengLodNew_Wu_Jie_Bian_Huan_Twist,function Trig_fengLodRed_fengLodNew_Wu_Jie_Bian_Huan_Twist_Actions)
endfunction
function Trig_fengLodBlue_Ice_Left_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_fengLodBlue_Ice_Down)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_fengLodBlue_Ice_Down)
endfunction
function InitTrig_fengLodBlue_Ice_Left takes nothing returns nothing
set gg_trg_fengLodBlue_Ice_Left=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_fengLodBlue_Ice_Left,Player(1),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_LEFT)
call TriggerAddAction(gg_trg_fengLodBlue_Ice_Left,function Trig_fengLodBlue_Ice_Left_Actions)
endfunction
function Trig_fengLodBlue_Ice_Down_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_fengLodBlue_Ice_Right)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_fengLodBlue_Ice_Right)
endfunction
function InitTrig_fengLodBlue_Ice_Down takes nothing returns nothing
set gg_trg_fengLodBlue_Ice_Down=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_fengLodBlue_Ice_Down,Player(1),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerAddAction(gg_trg_fengLodBlue_Ice_Down,function Trig_fengLodBlue_Ice_Down_Actions)
endfunction
function Trig_fengLodBlue_Ice_Right_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_fengLodBlue_Ice_Up)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_fengLodBlue_Ice_Up)
endfunction
function InitTrig_fengLodBlue_Ice_Right takes nothing returns nothing
set gg_trg_fengLodBlue_Ice_Right=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_fengLodBlue_Ice_Right,Player(1),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_RIGHT)
call TriggerAddAction(gg_trg_fengLodBlue_Ice_Right,function Trig_fengLodBlue_Ice_Right_Actions)
endfunction
function Trig_fengLodBlue_Ice_Up_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
endfunction
function InitTrig_fengLodBlue_Ice_Up takes nothing returns nothing
set gg_trg_fengLodBlue_Ice_Up=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_fengLodBlue_Ice_Up,Player(1),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerAddAction(gg_trg_fengLodBlue_Ice_Up,function Trig_fengLodBlue_Ice_Up_Actions)
endfunction
function Trig_fengLodBlue_Ice_Conditions takes nothing returns boolean
if(not(IsUnitType(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetOwningPlayer(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())))==Player(1)))then
return false
endif
return true
endfunction
function Trig_fengLodBlue_Ice_Actions takes nothing returns nothing
set udg_fengLodbWu_Jie_Bian_Huan[GetConvertedPlayerId(GetTriggerPlayer())]=true
set udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetTriggerPlayer())]=FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))
call EnableTrigger(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1)
call EnableTrigger(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Life)
call EnableTrigger(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Anywhere)
call EnableTrigger(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Death)
call EnableTrigger(gg_trg_fengLodBlue_fengLodNew_Wu_Jie_Bian_Huan_Twist)
call PanCameraToTimedLocForPlayer(Player(1),GetUnitLoc(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))),0)
call DisplayTimedTextToForce(GetPlayersAll(),10.00,(GetPlayerName(GetTriggerPlayer())+"|C00FF00FF开启了无界隐藏技能模式|R|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r"))
call DisplayTimedTextToForce(GetPlayersAll(),10.00,"|CFF00FF00恭喜蓝色玩家开启无界作弊脚本，变身后可输入“变幻”关闭无界作弊脚本|R")
call SetUnitVertexColor(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),0,0,255,255)
call SetUnitMoveSpeed(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),522.00)
call CreateTextTagUnitBJ("|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r",FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),0,30.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),50.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call AddSpecialEffectTargetUnitBJ("overhead",FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),"Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
endfunction
function InitTrig_fengLodBlue_Ice takes nothing returns nothing
set gg_trg_fengLodBlue_Ice=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_fengLodBlue_Ice,Player(1),"蓝天使",true)
call TriggerAddCondition(gg_trg_fengLodBlue_Ice,Condition(function Trig_fengLodBlue_Ice_Conditions))
call TriggerAddAction(gg_trg_fengLodBlue_Ice,function Trig_fengLodBlue_Ice_Actions)
endfunction
function Trig_fengLodBlue_fengLodNew_Wu_Jie_Bian_Huan_Twist_Conditions takes nothing returns boolean
if(not(udg_fengLodbWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))))]==true))then
return false
endif
if(not(IsUnitType(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_fengLodBlue_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_fengLodBlue_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))))]))==true)
endfunction
function Trig_fengLodBlue_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003 takes nothing returns boolean
return GetBooleanAnd(Trig_fengLodBlue_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003001(),Trig_fengLodBlue_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003002())
endfunction
function Trig_fengLodBlue_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func003A takes nothing returns nothing
call GroupAddUnitSimple(GetEnumUnit(),udg_fengLodBlue_Twist_Group2)
call PauseUnitBJ(true,GetEnumUnit())
endfunction
function Trig_fengLodBlue_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C takes nothing returns boolean
if(not(IsUnitAliveBJ(GetEnumUnit())==false))then
return false
endif
return true
endfunction
function Trig_fengLodBlue_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func004Func001A takes nothing returns nothing
if(Trig_fengLodBlue_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C())then
call GroupRemoveUnitSimple(GetEnumUnit(),udg_fengLodBlue_Twist_Group2)
else
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),GetEnumUnit(),((((I2R(GetHeroStr(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),true))+I2R(GetHeroAgi(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),true)))+I2R(GetHeroInt(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),true)))*SquareRoot(I2R(GetHeroLevel(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))))))/ 2.00),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endif
endfunction
function Trig_fengLodBlue_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func005A takes nothing returns nothing
call PauseUnitBJ(false,GetEnumUnit())
endfunction
function Trig_fengLodBlue_fengLodNew_Wu_Jie_Bian_Huan_Twist_Actions takes nothing returns nothing
set udg_fengLodBlue_Twist_Group1=GetUnitsInRangeOfLocMatching(512,GetUnitLoc(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))),Condition(function Trig_fengLodBlue_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003))
call ForGroupBJ(udg_fengLodBlue_Twist_Group1,function Trig_fengLodBlue_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func003A)
set udg_fengLodBlue_Twist_Loop=1
loop
exitwhen udg_fengLodBlue_Twist_Loop>4
call ForGroupBJ(udg_fengLodBlue_Twist_Group2,function Trig_fengLodBlue_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func004Func001A)
call TriggerSleepAction(0.80)
set udg_fengLodBlue_Twist_Loop=udg_fengLodBlue_Twist_Loop+1
endloop
call ForGroupBJ(udg_fengLodBlue_Twist_Group2,function Trig_fengLodBlue_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func005A)
call GroupClear(udg_fengLodBlue_Twist_Group1)
call GroupClear(udg_fengLodBlue_Twist_Group2)
endfunction
function InitTrig_fengLodBlue_fengLodNew_Wu_Jie_Bian_Huan_Twist takes nothing returns nothing
set gg_trg_fengLodBlue_fengLodNew_Wu_Jie_Bian_Huan_Twist=CreateTrigger()
call TriggerRegisterPlayerUnitEventSimple(gg_trg_fengLodBlue_fengLodNew_Wu_Jie_Bian_Huan_Twist,Player(1),EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_fengLodBlue_fengLodNew_Wu_Jie_Bian_Huan_Twist,Condition(function Trig_fengLodBlue_fengLodNew_Wu_Jie_Bian_Huan_Twist_Conditions))
call TriggerAddAction(gg_trg_fengLodBlue_fengLodNew_Wu_Jie_Bian_Huan_Twist,function Trig_fengLodBlue_fengLodNew_Wu_Jie_Bian_Huan_Twist_Actions)
endfunction
function Trig_fengLodCyan_Bolt_Down_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_fengLodCyan_Bolt_Right)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_fengLodCyan_Bolt_Right)
endfunction
function InitTrig_fengLodCyan_Bolt_Down takes nothing returns nothing
set gg_trg_fengLodCyan_Bolt_Down=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_fengLodCyan_Bolt_Down,Player(2),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerAddAction(gg_trg_fengLodCyan_Bolt_Down,function Trig_fengLodCyan_Bolt_Down_Actions)
endfunction
function Trig_fengLodCyan_Bolt_Right_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_fengLodCyan_Bolt_Up)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_fengLodCyan_Bolt_Up)
endfunction
function InitTrig_fengLodCyan_Bolt_Right takes nothing returns nothing
set gg_trg_fengLodCyan_Bolt_Right=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_fengLodCyan_Bolt_Right,Player(2),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_RIGHT)
call TriggerAddAction(gg_trg_fengLodCyan_Bolt_Right,function Trig_fengLodCyan_Bolt_Right_Actions)
endfunction
function Trig_fengLodCyan_Bolt_Up_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_fengLodCyan_Bolt_Left)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_fengLodCyan_Bolt_Left)
endfunction
function InitTrig_fengLodCyan_Bolt_Up takes nothing returns nothing
set gg_trg_fengLodCyan_Bolt_Up=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_fengLodCyan_Bolt_Up,Player(2),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerAddAction(gg_trg_fengLodCyan_Bolt_Up,function Trig_fengLodCyan_Bolt_Up_Actions)
endfunction
function Trig_fengLodCyan_Bolt_Left_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
endfunction
function InitTrig_fengLodCyan_Bolt_Left takes nothing returns nothing
set gg_trg_fengLodCyan_Bolt_Left=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_fengLodCyan_Bolt_Left,Player(2),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_LEFT)
call TriggerAddAction(gg_trg_fengLodCyan_Bolt_Left,function Trig_fengLodCyan_Bolt_Left_Actions)
endfunction
function Trig_fengLodCyan_Bolt_Conditions takes nothing returns boolean
if(not(IsUnitType(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetOwningPlayer(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())))==Player(2)))then
return false
endif
return true
endfunction
function Trig_fengLodCyan_Bolt_Actions takes nothing returns nothing
set udg_fengLodbWu_Jie_Bian_Huan[GetConvertedPlayerId(GetTriggerPlayer())]=true
set udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetTriggerPlayer())]=FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))
call EnableTrigger(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1)
call EnableTrigger(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Life)
call EnableTrigger(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Anywhere)
call EnableTrigger(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Death)
call EnableTrigger(gg_trg_fengLodCyan_fengLodNew_Wu_Jie_Bian_Huan_Twist)
call PanCameraToTimedLocForPlayer(Player(2),GetUnitLoc(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))),0)
call DisplayTimedTextToForce(GetPlayersAll(),10.00,(GetPlayerName(GetTriggerPlayer())+"|C00FF00FF开启了无界隐藏技能模式|R|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r"))
call DisplayTimedTextToForce(GetPlayersAll(),10.00,"|CFF00FF00恭喜青色玩家开启无界作弊脚本，变身后可输入“变幻”关闭无界作弊脚本|R")
call SetUnitVertexColor(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),0,255,255,255)
call SetUnitMoveSpeed(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),522.00)
call CreateTextTagUnitBJ("|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r",FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),0,30.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),50.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call AddSpecialEffectTargetUnitBJ("overhead",FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),"Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
endfunction
function InitTrig_fengLodCyan_Bolt takes nothing returns nothing
set gg_trg_fengLodCyan_Bolt=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_fengLodCyan_Bolt,Player(2),"青天使",true)
call TriggerAddCondition(gg_trg_fengLodCyan_Bolt,Condition(function Trig_fengLodCyan_Bolt_Conditions))
call TriggerAddAction(gg_trg_fengLodCyan_Bolt,function Trig_fengLodCyan_Bolt_Actions)
endfunction
function Trig_fengLodCyan_fengLodNew_Wu_Jie_Bian_Huan_Twist_Conditions takes nothing returns boolean
if(not(udg_fengLodbWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))))]==true))then
return false
endif
if(not(IsUnitType(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_fengLodCyan_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_fengLodCyan_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))))]))==true)
endfunction
function Trig_fengLodCyan_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003 takes nothing returns boolean
return GetBooleanAnd(Trig_fengLodCyan_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003001(),Trig_fengLodCyan_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003002())
endfunction
function Trig_fengLodCyan_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func003A takes nothing returns nothing
call GroupAddUnitSimple(GetEnumUnit(),udg_fengLodCyan_Twist_Group2)
call PauseUnitBJ(true,GetEnumUnit())
endfunction
function Trig_fengLodCyan_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C takes nothing returns boolean
if(not(IsUnitAliveBJ(GetEnumUnit())==false))then
return false
endif
return true
endfunction
function Trig_fengLodCyan_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func004Func001A takes nothing returns nothing
if(Trig_fengLodCyan_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C())then
call GroupRemoveUnitSimple(GetEnumUnit(),udg_fengLodCyan_Twist_Group2)
else
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),GetEnumUnit(),((((I2R(GetHeroStr(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),true))+I2R(GetHeroAgi(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),true)))+I2R(GetHeroInt(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),true)))*SquareRoot(I2R(GetHeroLevel(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))))))/ 2.00),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endif
endfunction
function Trig_fengLodCyan_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func005A takes nothing returns nothing
call PauseUnitBJ(false,GetEnumUnit())
endfunction
function Trig_fengLodCyan_fengLodNew_Wu_Jie_Bian_Huan_Twist_Actions takes nothing returns nothing
set udg_fengLodCyan_Twist_Group1=GetUnitsInRangeOfLocMatching(512,GetUnitLoc(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))),Condition(function Trig_fengLodCyan_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003))
call ForGroupBJ(udg_fengLodCyan_Twist_Group1,function Trig_fengLodCyan_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func003A)
set udg_fengLodCyan_Twist_Loop=1
loop
exitwhen udg_fengLodCyan_Twist_Loop>4
call ForGroupBJ(udg_fengLodCyan_Twist_Group2,function Trig_fengLodCyan_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func004Func001A)
call TriggerSleepAction(0.80)
set udg_fengLodCyan_Twist_Loop=udg_fengLodCyan_Twist_Loop+1
endloop
call ForGroupBJ(udg_fengLodCyan_Twist_Group2,function Trig_fengLodCyan_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func005A)
call GroupClear(udg_fengLodCyan_Twist_Group1)
call GroupClear(udg_fengLodCyan_Twist_Group2)
endfunction
function InitTrig_fengLodCyan_fengLodNew_Wu_Jie_Bian_Huan_Twist takes nothing returns nothing
set gg_trg_fengLodCyan_fengLodNew_Wu_Jie_Bian_Huan_Twist=CreateTrigger()
call TriggerRegisterPlayerUnitEventSimple(gg_trg_fengLodCyan_fengLodNew_Wu_Jie_Bian_Huan_Twist,Player(2),EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_fengLodCyan_fengLodNew_Wu_Jie_Bian_Huan_Twist,Condition(function Trig_fengLodCyan_fengLodNew_Wu_Jie_Bian_Huan_Twist_Conditions))
call TriggerAddAction(gg_trg_fengLodCyan_fengLodNew_Wu_Jie_Bian_Huan_Twist,function Trig_fengLodCyan_fengLodNew_Wu_Jie_Bian_Huan_Twist_Actions)
endfunction
function Trig_fengLodPurple_Moon_Right_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_fengLodPurple_Moon_Up)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_fengLodPurple_Moon_Up)
endfunction
function InitTrig_fengLodPurple_Moon_Right takes nothing returns nothing
set gg_trg_fengLodPurple_Moon_Right=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_fengLodPurple_Moon_Right,Player(3),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_RIGHT)
call TriggerAddAction(gg_trg_fengLodPurple_Moon_Right,function Trig_fengLodPurple_Moon_Right_Actions)
endfunction
function Trig_fengLodPurple_Moon_Up_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_fengLodPurple_Moon_Left)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_fengLodPurple_Moon_Left)
endfunction
function InitTrig_fengLodPurple_Moon_Up takes nothing returns nothing
set gg_trg_fengLodPurple_Moon_Up=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_fengLodPurple_Moon_Up,Player(3),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerAddAction(gg_trg_fengLodPurple_Moon_Up,function Trig_fengLodPurple_Moon_Up_Actions)
endfunction
function Trig_fengLodPurple_Moon_Left_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_fengLodPurple_Moon_Down)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_fengLodPurple_Moon_Down)
endfunction
function InitTrig_fengLodPurple_Moon_Left takes nothing returns nothing
set gg_trg_fengLodPurple_Moon_Left=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_fengLodPurple_Moon_Left,Player(3),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_LEFT)
call TriggerAddAction(gg_trg_fengLodPurple_Moon_Left,function Trig_fengLodPurple_Moon_Left_Actions)
endfunction
function Trig_fengLodPurple_Moon_Down_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
endfunction
function InitTrig_fengLodPurple_Moon_Down takes nothing returns nothing
set gg_trg_fengLodPurple_Moon_Down=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_fengLodPurple_Moon_Down,Player(3),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerAddAction(gg_trg_fengLodPurple_Moon_Down,function Trig_fengLodPurple_Moon_Down_Actions)
endfunction
function Trig_fengLodPurple_Moon_Conditions takes nothing returns boolean
if(not(IsUnitType(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetOwningPlayer(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())))==Player(3)))then
return false
endif
return true
endfunction
function Trig_fengLodPurple_Moon_Actions takes nothing returns nothing
set udg_fengLodbWu_Jie_Bian_Huan[GetConvertedPlayerId(GetTriggerPlayer())]=true
set udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetTriggerPlayer())]=FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))
call EnableTrigger(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1)
call EnableTrigger(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Life)
call EnableTrigger(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Anywhere)
call EnableTrigger(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Death)
call EnableTrigger(gg_trg_fengLodPurple_fengLodNew_Wu_Jie_Bian_Huan_Twist)
call PanCameraToTimedLocForPlayer(Player(3),GetUnitLoc(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))),0)
call DisplayTimedTextToForce(GetPlayersAll(),10.00,(GetPlayerName(GetTriggerPlayer())+"|C00FF00FF开启了无界隐藏技能模式|R|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r"))
call DisplayTimedTextToForce(GetPlayersAll(),10.00,"|CFF00FF00恭喜紫色玩家开启无界作弊脚本，变身后可输入“变幻”关闭无界作弊脚本|R")
call SetUnitVertexColor(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),255,0,255,255)
call SetUnitMoveSpeed(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),522.00)
call CreateTextTagUnitBJ("|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r",FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),0,30.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),50.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call AddSpecialEffectTargetUnitBJ("overhead",FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),"Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
endfunction
function InitTrig_fengLodPurple_Moon takes nothing returns nothing
set gg_trg_fengLodPurple_Moon=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_fengLodPurple_Moon,Player(3),"紫天使",true)
call TriggerAddCondition(gg_trg_fengLodPurple_Moon,Condition(function Trig_fengLodPurple_Moon_Conditions))
call TriggerAddAction(gg_trg_fengLodPurple_Moon,function Trig_fengLodPurple_Moon_Actions)
endfunction
function Trig_fengLodPurple_fengLodNew_Wu_Jie_Bian_Huan_Twist_Conditions takes nothing returns boolean
if(not(udg_fengLodbWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))))]==true))then
return false
endif
if(not(IsUnitType(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_fengLodPurple_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_fengLodPurple_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))))]))==true)
endfunction
function Trig_fengLodPurple_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003 takes nothing returns boolean
return GetBooleanAnd(Trig_fengLodPurple_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003001(),Trig_fengLodPurple_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003002())
endfunction
function Trig_fengLodPurple_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func003A takes nothing returns nothing
call GroupAddUnitSimple(GetEnumUnit(),udg_fengLodPurple_Twist_Group2)
call PauseUnitBJ(true,GetEnumUnit())
endfunction
function Trig_fengLodPurple_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C takes nothing returns boolean
if(not(IsUnitAliveBJ(GetEnumUnit())==false))then
return false
endif
return true
endfunction
function Trig_fengLodPurple_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func004Func001A takes nothing returns nothing
if(Trig_fengLodPurple_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C())then
call GroupRemoveUnitSimple(GetEnumUnit(),udg_fengLodPurple_Twist_Group2)
else
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),GetEnumUnit(),((((I2R(GetHeroStr(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),true))+I2R(GetHeroAgi(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),true)))+I2R(GetHeroInt(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),true)))*SquareRoot(I2R(GetHeroLevel(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))))))/ 2.00),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endif
endfunction
function Trig_fengLodPurple_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func005A takes nothing returns nothing
call PauseUnitBJ(false,GetEnumUnit())
endfunction
function Trig_fengLodPurple_fengLodNew_Wu_Jie_Bian_Huan_Twist_Actions takes nothing returns nothing
set udg_fengLodPurple_Twist_Group1=GetUnitsInRangeOfLocMatching(512,GetUnitLoc(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))),Condition(function Trig_fengLodPurple_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003))
call ForGroupBJ(udg_fengLodPurple_Twist_Group1,function Trig_fengLodPurple_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func003A)
set udg_fengLodPurple_Twist_Loop=1
loop
exitwhen udg_fengLodPurple_Twist_Loop>4
call ForGroupBJ(udg_fengLodPurple_Twist_Group2,function Trig_fengLodPurple_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func004Func001A)
call TriggerSleepAction(0.80)
set udg_fengLodPurple_Twist_Loop=udg_fengLodPurple_Twist_Loop+1
endloop
call ForGroupBJ(udg_fengLodPurple_Twist_Group2,function Trig_fengLodPurple_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func005A)
call GroupClear(udg_fengLodPurple_Twist_Group1)
call GroupClear(udg_fengLodPurple_Twist_Group2)
endfunction
function InitTrig_fengLodPurple_fengLodNew_Wu_Jie_Bian_Huan_Twist takes nothing returns nothing
set gg_trg_fengLodPurple_fengLodNew_Wu_Jie_Bian_Huan_Twist=CreateTrigger()
call TriggerRegisterPlayerUnitEventSimple(gg_trg_fengLodPurple_fengLodNew_Wu_Jie_Bian_Huan_Twist,Player(3),EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_fengLodPurple_fengLodNew_Wu_Jie_Bian_Huan_Twist,Condition(function Trig_fengLodPurple_fengLodNew_Wu_Jie_Bian_Huan_Twist_Conditions))
call TriggerAddAction(gg_trg_fengLodPurple_fengLodNew_Wu_Jie_Bian_Huan_Twist,function Trig_fengLodPurple_fengLodNew_Wu_Jie_Bian_Huan_Twist_Actions)
endfunction
function Trig_fengLodYellow_Light_Up_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_fengLodYellow_Light_Right)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_fengLodYellow_Light_Right)
endfunction
function InitTrig_fengLodYellow_Light_Up takes nothing returns nothing
set gg_trg_fengLodYellow_Light_Up=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_fengLodYellow_Light_Up,Player(4),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerAddAction(gg_trg_fengLodYellow_Light_Up,function Trig_fengLodYellow_Light_Up_Actions)
endfunction
function Trig_fengLodYellow_Light_Right_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_fengLodYellow_Light_Down)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_fengLodYellow_Light_Down)
endfunction
function InitTrig_fengLodYellow_Light_Right takes nothing returns nothing
set gg_trg_fengLodYellow_Light_Right=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_fengLodYellow_Light_Right,Player(4),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_RIGHT)
call TriggerAddAction(gg_trg_fengLodYellow_Light_Right,function Trig_fengLodYellow_Light_Right_Actions)
endfunction
function Trig_fengLodYellow_Light_Down_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_fengLodYellow_Light_Left)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_fengLodYellow_Light_Left)
endfunction
function InitTrig_fengLodYellow_Light_Down takes nothing returns nothing
set gg_trg_fengLodYellow_Light_Down=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_fengLodYellow_Light_Down,Player(4),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerAddAction(gg_trg_fengLodYellow_Light_Down,function Trig_fengLodYellow_Light_Down_Actions)
endfunction
function Trig_fengLodYellow_Light_Left_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
endfunction
function InitTrig_fengLodYellow_Light_Left takes nothing returns nothing
set gg_trg_fengLodYellow_Light_Left=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_fengLodYellow_Light_Left,Player(4),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_LEFT)
call TriggerAddAction(gg_trg_fengLodYellow_Light_Left,function Trig_fengLodYellow_Light_Left_Actions)
endfunction
function Trig_fengLodYellow_Light_Conditions takes nothing returns boolean
if(not(IsUnitType(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetOwningPlayer(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())))==Player(4)))then
return false
endif
return true
endfunction
function Trig_fengLodYellow_Light_Actions takes nothing returns nothing
set udg_fengLodbWu_Jie_Bian_Huan[GetConvertedPlayerId(GetTriggerPlayer())]=true
set udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetTriggerPlayer())]=FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))
call EnableTrigger(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1)
call EnableTrigger(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Life)
call EnableTrigger(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Anywhere)
call EnableTrigger(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Death)
call EnableTrigger(gg_trg_fengLodYellow_fengLodNew_Wu_Jie_Bian_Huan_Twist)
call PanCameraToTimedLocForPlayer(Player(4),GetUnitLoc(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))),0)
call DisplayTimedTextToForce(GetPlayersAll(),10.00,(GetPlayerName(GetTriggerPlayer())+"|C00FF00FF开启了无界隐藏技能模式|R|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r"))
call DisplayTimedTextToForce(GetPlayersAll(),10.00,"|CFF00FF00恭喜黄色玩家开启无界作弊脚本，变身后可输入“变幻”关闭无界作弊脚本|R")
call SetUnitVertexColor(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),255,255,0,255)
call SetUnitMoveSpeed(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),522.00)
call CreateTextTagUnitBJ("|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r",FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),0,30.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),50.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call AddSpecialEffectTargetUnitBJ("overhead",FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),"Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
endfunction
function InitTrig_fengLodYellow_Light takes nothing returns nothing
set gg_trg_fengLodYellow_Light=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_fengLodYellow_Light,Player(4),"黄天使",true)
call TriggerAddCondition(gg_trg_fengLodYellow_Light,Condition(function Trig_fengLodYellow_Light_Conditions))
call TriggerAddAction(gg_trg_fengLodYellow_Light,function Trig_fengLodYellow_Light_Actions)
endfunction
function Trig_fengLodYellow_fengLodNew_Wu_Jie_Bian_Huan_Twist_Conditions takes nothing returns boolean
if(not(udg_fengLodbWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))))]==true))then
return false
endif
if(not(IsUnitType(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_fengLodYellow_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_fengLodYellow_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))))]))==true)
endfunction
function Trig_fengLodYellow_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003 takes nothing returns boolean
return GetBooleanAnd(Trig_fengLodYellow_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003001(),Trig_fengLodYellow_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003002())
endfunction
function Trig_fengLodYellow_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func003A takes nothing returns nothing
call GroupAddUnitSimple(GetEnumUnit(),udg_fengLodYellow_Twist_Group2)
call PauseUnitBJ(true,GetEnumUnit())
endfunction
function Trig_fengLodYellow_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C takes nothing returns boolean
if(not(IsUnitAliveBJ(GetEnumUnit())==false))then
return false
endif
return true
endfunction
function Trig_fengLodYellow_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func004Func001A takes nothing returns nothing
if(Trig_fengLodYellow_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C())then
call GroupRemoveUnitSimple(GetEnumUnit(),udg_fengLodYellow_Twist_Group2)
else
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),GetEnumUnit(),((((I2R(GetHeroStr(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),true))+I2R(GetHeroAgi(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),true)))+I2R(GetHeroInt(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),true)))*SquareRoot(I2R(GetHeroLevel(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))))))/ 2.00),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endif
endfunction
function Trig_fengLodYellow_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func005A takes nothing returns nothing
call PauseUnitBJ(false,GetEnumUnit())
endfunction
function Trig_fengLodYellow_fengLodNew_Wu_Jie_Bian_Huan_Twist_Actions takes nothing returns nothing
set udg_fengLodYellow_Twist_Group1=GetUnitsInRangeOfLocMatching(512,GetUnitLoc(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))),Condition(function Trig_fengLodYellow_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003))
call ForGroupBJ(udg_fengLodYellow_Twist_Group1,function Trig_fengLodYellow_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func003A)
set udg_fengLodYellow_Twist_Loop=1
loop
exitwhen udg_fengLodYellow_Twist_Loop>4
call ForGroupBJ(udg_fengLodYellow_Twist_Group2,function Trig_fengLodYellow_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func004Func001A)
call TriggerSleepAction(0.80)
set udg_fengLodYellow_Twist_Loop=udg_fengLodYellow_Twist_Loop+1
endloop
call ForGroupBJ(udg_fengLodYellow_Twist_Group2,function Trig_fengLodYellow_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func005A)
call GroupClear(udg_fengLodYellow_Twist_Group1)
call GroupClear(udg_fengLodYellow_Twist_Group2)
endfunction
function InitTrig_fengLodYellow_fengLodNew_Wu_Jie_Bian_Huan_Twist takes nothing returns nothing
set gg_trg_fengLodYellow_fengLodNew_Wu_Jie_Bian_Huan_Twist=CreateTrigger()
call TriggerRegisterPlayerUnitEventSimple(gg_trg_fengLodYellow_fengLodNew_Wu_Jie_Bian_Huan_Twist,Player(4),EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_fengLodYellow_fengLodNew_Wu_Jie_Bian_Huan_Twist,Condition(function Trig_fengLodYellow_fengLodNew_Wu_Jie_Bian_Huan_Twist_Conditions))
call TriggerAddAction(gg_trg_fengLodYellow_fengLodNew_Wu_Jie_Bian_Huan_Twist,function Trig_fengLodYellow_fengLodNew_Wu_Jie_Bian_Huan_Twist_Actions)
endfunction
function Trig_fengLodOrange_Wind_Right_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_fengLodOrange_Wind_Down)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_fengLodOrange_Wind_Down)
endfunction
function InitTrig_fengLodOrange_Wind_Right takes nothing returns nothing
set gg_trg_fengLodOrange_Wind_Right=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_fengLodOrange_Wind_Right,Player(5),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_RIGHT)
call TriggerAddAction(gg_trg_fengLodOrange_Wind_Right,function Trig_fengLodOrange_Wind_Right_Actions)
endfunction
function Trig_fengLodOrange_Wind_Down_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_fengLodOrange_Wind_Left)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_fengLodOrange_Wind_Left)
endfunction
function InitTrig_fengLodOrange_Wind_Down takes nothing returns nothing
set gg_trg_fengLodOrange_Wind_Down=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_fengLodOrange_Wind_Down,Player(5),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerAddAction(gg_trg_fengLodOrange_Wind_Down,function Trig_fengLodOrange_Wind_Down_Actions)
endfunction
function Trig_fengLodOrange_Wind_Left_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_fengLodOrange_Wind_Up)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_fengLodOrange_Wind_Up)
endfunction
function InitTrig_fengLodOrange_Wind_Left takes nothing returns nothing
set gg_trg_fengLodOrange_Wind_Left=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_fengLodOrange_Wind_Left,Player(5),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_LEFT)
call TriggerAddAction(gg_trg_fengLodOrange_Wind_Left,function Trig_fengLodOrange_Wind_Left_Actions)
endfunction
function Trig_fengLodOrange_Wind_Up_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
endfunction
function InitTrig_fengLodOrange_Wind_Up takes nothing returns nothing
set gg_trg_fengLodOrange_Wind_Up=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_fengLodOrange_Wind_Up,Player(5),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerAddAction(gg_trg_fengLodOrange_Wind_Up,function Trig_fengLodOrange_Wind_Up_Actions)
endfunction
function Trig_fengLodOrange_Wind_Conditions takes nothing returns boolean
if(not(IsUnitType(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetOwningPlayer(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())))==Player(5)))then
return false
endif
return true
endfunction
function Trig_fengLodOrange_Wind_Actions takes nothing returns nothing
set udg_fengLodbWu_Jie_Bian_Huan[GetConvertedPlayerId(GetTriggerPlayer())]=true
set udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetTriggerPlayer())]=FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))
call EnableTrigger(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1)
call EnableTrigger(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Life)
call EnableTrigger(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Anywhere)
call EnableTrigger(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Death)
call EnableTrigger(gg_trg_fengLodOrange_fengLodNew_Wu_Jie_Bian_Huan_Twist)
call PanCameraToTimedLocForPlayer(Player(5),GetUnitLoc(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))),0)
call DisplayTimedTextToForce(GetPlayersAll(),10.00,(GetPlayerName(GetTriggerPlayer())+"|C00FF00FF开启了无界隐藏技能模式|R|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r"))
call DisplayTimedTextToForce(GetPlayersAll(),10.00,"|CFF00FF00恭喜橙色玩家开启无界作弊脚本，变身后可输入“变幻”关闭无界作弊脚本|R")
call SetUnitVertexColor(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),255,170,0,255)
call SetUnitMoveSpeed(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),522.00)
call CreateTextTagUnitBJ("|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r",FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),0,30.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),50.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call AddSpecialEffectTargetUnitBJ("overhead",FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),"Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
endfunction
function InitTrig_fengLodOrange_Wind takes nothing returns nothing
set gg_trg_fengLodOrange_Wind=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_fengLodOrange_Wind,Player(5),"橙天使",true)
call TriggerAddCondition(gg_trg_fengLodOrange_Wind,Condition(function Trig_fengLodOrange_Wind_Conditions))
call TriggerAddAction(gg_trg_fengLodOrange_Wind,function Trig_fengLodOrange_Wind_Actions)
endfunction
function Trig_fengLodOrange_fengLodNew_Wu_Jie_Bian_Huan_Twist_Conditions takes nothing returns boolean
if(not(udg_fengLodbWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))))]==true))then
return false
endif
if(not(IsUnitType(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_fengLodOrange_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_fengLodOrange_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))))]))==true)
endfunction
function Trig_fengLodOrange_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003 takes nothing returns boolean
return GetBooleanAnd(Trig_fengLodOrange_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003001(),Trig_fengLodOrange_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003002())
endfunction
function Trig_fengLodOrange_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func003A takes nothing returns nothing
call GroupAddUnitSimple(GetEnumUnit(),udg_fengLodOrange_Twist_Group2)
call PauseUnitBJ(true,GetEnumUnit())
endfunction
function Trig_fengLodOrange_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C takes nothing returns boolean
if(not(IsUnitAliveBJ(GetEnumUnit())==false))then
return false
endif
return true
endfunction
function Trig_fengLodOrange_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func004Func001A takes nothing returns nothing
if(Trig_fengLodOrange_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C())then
call GroupRemoveUnitSimple(GetEnumUnit(),udg_fengLodOrange_Twist_Group2)
else
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),GetEnumUnit(),((((I2R(GetHeroStr(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),true))+I2R(GetHeroAgi(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),true)))+I2R(GetHeroInt(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),true)))*SquareRoot(I2R(GetHeroLevel(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))))))/ 2.00),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endif
endfunction
function Trig_fengLodOrange_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func005A takes nothing returns nothing
call PauseUnitBJ(false,GetEnumUnit())
endfunction
function Trig_fengLodOrange_fengLodNew_Wu_Jie_Bian_Huan_Twist_Actions takes nothing returns nothing
set udg_fengLodOrange_Twist_Group1=GetUnitsInRangeOfLocMatching(512,GetUnitLoc(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))),Condition(function Trig_fengLodOrange_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003))
call ForGroupBJ(udg_fengLodOrange_Twist_Group1,function Trig_fengLodOrange_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func003A)
set udg_fengLodOrange_Twist_Loop=1
loop
exitwhen udg_fengLodOrange_Twist_Loop>4
call ForGroupBJ(udg_fengLodOrange_Twist_Group2,function Trig_fengLodOrange_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func004Func001A)
call TriggerSleepAction(0.80)
set udg_fengLodOrange_Twist_Loop=udg_fengLodOrange_Twist_Loop+1
endloop
call ForGroupBJ(udg_fengLodOrange_Twist_Group2,function Trig_fengLodOrange_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func005A)
call GroupClear(udg_fengLodOrange_Twist_Group1)
call GroupClear(udg_fengLodOrange_Twist_Group2)
endfunction
function InitTrig_fengLodOrange_fengLodNew_Wu_Jie_Bian_Huan_Twist takes nothing returns nothing
set gg_trg_fengLodOrange_fengLodNew_Wu_Jie_Bian_Huan_Twist=CreateTrigger()
call TriggerRegisterPlayerUnitEventSimple(gg_trg_fengLodOrange_fengLodNew_Wu_Jie_Bian_Huan_Twist,Player(5),EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_fengLodOrange_fengLodNew_Wu_Jie_Bian_Huan_Twist,Condition(function Trig_fengLodOrange_fengLodNew_Wu_Jie_Bian_Huan_Twist_Conditions))
call TriggerAddAction(gg_trg_fengLodOrange_fengLodNew_Wu_Jie_Bian_Huan_Twist,function Trig_fengLodOrange_fengLodNew_Wu_Jie_Bian_Huan_Twist_Actions)
endfunction
function Trig_fengLodWGreen_Wood_Down_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_fengLodWGreen_Wood_Left)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_fengLodWGreen_Wood_Left)
endfunction
function InitTrig_fengLodWGreen_Wood_Down takes nothing returns nothing
set gg_trg_fengLodWGreen_Wood_Down=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_fengLodWGreen_Wood_Down,Player(6),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerAddAction(gg_trg_fengLodWGreen_Wood_Down,function Trig_fengLodWGreen_Wood_Down_Actions)
endfunction
function Trig_fengLodWGreen_Wood_Left_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_fengLodWGreen_Wood_Up)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_fengLodWGreen_Wood_Up)
endfunction
function InitTrig_fengLodWGreen_Wood_Left takes nothing returns nothing
set gg_trg_fengLodWGreen_Wood_Left=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_fengLodWGreen_Wood_Left,Player(6),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_LEFT)
call TriggerAddAction(gg_trg_fengLodWGreen_Wood_Left,function Trig_fengLodWGreen_Wood_Left_Actions)
endfunction
function Trig_fengLodWGreen_Wood_Up_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_fengLodWGreen_Wood_Right)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_fengLodWGreen_Wood_Right)
endfunction
function InitTrig_fengLodWGreen_Wood_Up takes nothing returns nothing
set gg_trg_fengLodWGreen_Wood_Up=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_fengLodWGreen_Wood_Up,Player(6),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerAddAction(gg_trg_fengLodWGreen_Wood_Up,function Trig_fengLodWGreen_Wood_Up_Actions)
endfunction
function Trig_fengLodWGreen_Wood_Right_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
endfunction
function InitTrig_fengLodWGreen_Wood_Right takes nothing returns nothing
set gg_trg_fengLodWGreen_Wood_Right=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_fengLodWGreen_Wood_Right,Player(6),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_RIGHT)
call TriggerAddAction(gg_trg_fengLodWGreen_Wood_Right,function Trig_fengLodWGreen_Wood_Right_Actions)
endfunction
function Trig_fengLodWGreen_Wood_Conditions takes nothing returns boolean
if(not(IsUnitType(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetOwningPlayer(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())))==Player(6)))then
return false
endif
return true
endfunction
function Trig_fengLodWGreen_Wood_Actions takes nothing returns nothing
set udg_fengLodbWu_Jie_Bian_Huan[GetConvertedPlayerId(GetTriggerPlayer())]=true
set udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetTriggerPlayer())]=FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))
call EnableTrigger(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1)
call EnableTrigger(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Life)
call EnableTrigger(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Anywhere)
call EnableTrigger(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Death)
call EnableTrigger(gg_trg_fengLodGreen_fengLodNew_Wu_Jie_Bian_Huan_Twist)
call PanCameraToTimedLocForPlayer(Player(6),GetUnitLoc(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))),0)
call DisplayTimedTextToForce(GetPlayersAll(),10.00,(GetPlayerName(GetTriggerPlayer())+"|C00FF00FF开启了无界隐藏技能模式|R|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r"))
call DisplayTimedTextToForce(GetPlayersAll(),10.00,"|CFF00FF00恭喜绿色玩家开启无界作弊脚本，变身后可输入“变幻”关闭无界作弊脚本|R")
call SetUnitVertexColor(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),0,255,0,255)
call SetUnitMoveSpeed(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),522.00)
call CreateTextTagUnitBJ("|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r",FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),0,30.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),50.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call AddSpecialEffectTargetUnitBJ("overhead",FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),"Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
endfunction
function InitTrig_fengLodWGreen_Wood takes nothing returns nothing
set gg_trg_fengLodWGreen_Wood=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_fengLodWGreen_Wood,Player(6),"绿天使",true)
call TriggerAddCondition(gg_trg_fengLodWGreen_Wood,Condition(function Trig_fengLodWGreen_Wood_Conditions))
call TriggerAddAction(gg_trg_fengLodWGreen_Wood,function Trig_fengLodWGreen_Wood_Actions)
endfunction
function Trig_fengLodGreen_fengLodNew_Wu_Jie_Bian_Huan_Twist_Conditions takes nothing returns boolean
if(not(udg_fengLodbWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))))]==true))then
return false
endif
if(not(IsUnitType(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_fengLodGreen_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_fengLodGreen_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))))]))==true)
endfunction
function Trig_fengLodGreen_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003 takes nothing returns boolean
return GetBooleanAnd(Trig_fengLodGreen_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003001(),Trig_fengLodGreen_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003002())
endfunction
function Trig_fengLodGreen_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func003A takes nothing returns nothing
call GroupAddUnitSimple(GetEnumUnit(),udg_fengLodGreen_Twist_Group2)
call PauseUnitBJ(true,GetEnumUnit())
endfunction
function Trig_fengLodGreen_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C takes nothing returns boolean
if(not(IsUnitAliveBJ(GetEnumUnit())==false))then
return false
endif
return true
endfunction
function Trig_fengLodGreen_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func004Func001A takes nothing returns nothing
if(Trig_fengLodGreen_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C())then
call GroupRemoveUnitSimple(GetEnumUnit(),udg_fengLodGreen_Twist_Group2)
else
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),GetEnumUnit(),((((I2R(GetHeroStr(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),true))+I2R(GetHeroAgi(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),true)))+I2R(GetHeroInt(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),true)))*SquareRoot(I2R(GetHeroLevel(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))))))/ 2.00),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endif
endfunction
function Trig_fengLodGreen_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func005A takes nothing returns nothing
call PauseUnitBJ(false,GetEnumUnit())
endfunction
function Trig_fengLodGreen_fengLodNew_Wu_Jie_Bian_Huan_Twist_Actions takes nothing returns nothing
set udg_fengLodGreen_Twist_Group1=GetUnitsInRangeOfLocMatching(512,GetUnitLoc(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))),Condition(function Trig_fengLodGreen_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003))
call ForGroupBJ(udg_fengLodGreen_Twist_Group1,function Trig_fengLodGreen_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func003A)
set udg_fengLodGreen_Twist_Loop=1
loop
exitwhen udg_fengLodGreen_Twist_Loop>4
call ForGroupBJ(udg_fengLodGreen_Twist_Group2,function Trig_fengLodGreen_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func004Func001A)
call TriggerSleepAction(0.80)
set udg_fengLodGreen_Twist_Loop=udg_fengLodGreen_Twist_Loop+1
endloop
call ForGroupBJ(udg_fengLodGreen_Twist_Group2,function Trig_fengLodGreen_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func005A)
call GroupClear(udg_fengLodGreen_Twist_Group1)
call GroupClear(udg_fengLodGreen_Twist_Group2)
endfunction
function InitTrig_fengLodGreen_fengLodNew_Wu_Jie_Bian_Huan_Twist takes nothing returns nothing
set gg_trg_fengLodGreen_fengLodNew_Wu_Jie_Bian_Huan_Twist=CreateTrigger()
call TriggerRegisterPlayerUnitEventSimple(gg_trg_fengLodGreen_fengLodNew_Wu_Jie_Bian_Huan_Twist,Player(6),EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_fengLodGreen_fengLodNew_Wu_Jie_Bian_Huan_Twist,Condition(function Trig_fengLodGreen_fengLodNew_Wu_Jie_Bian_Huan_Twist_Conditions))
call TriggerAddAction(gg_trg_fengLodGreen_fengLodNew_Wu_Jie_Bian_Huan_Twist,function Trig_fengLodGreen_fengLodNew_Wu_Jie_Bian_Huan_Twist_Actions)
endfunction
function Trig_fengLodPink_Pink_Left_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_fengLodPink_Pink_Up)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_fengLodPink_Pink_Up)
endfunction
function InitTrig_fengLodPink_Pink_Left takes nothing returns nothing
set gg_trg_fengLodPink_Pink_Left=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_fengLodPink_Pink_Left,Player(7),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_LEFT)
call TriggerAddAction(gg_trg_fengLodPink_Pink_Left,function Trig_fengLodPink_Pink_Left_Actions)
endfunction
function Trig_fengLodPink_Pink_Up_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_fengLodPink_Pink_Right)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_fengLodPink_Pink_Right)
endfunction
function InitTrig_fengLodPink_Pink_Up takes nothing returns nothing
set gg_trg_fengLodPink_Pink_Up=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_fengLodPink_Pink_Up,Player(7),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerAddAction(gg_trg_fengLodPink_Pink_Up,function Trig_fengLodPink_Pink_Up_Actions)
endfunction
function Trig_fengLodPink_Pink_Right_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_fengLodPink_Pink_Down)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_fengLodPink_Pink_Down)
endfunction
function InitTrig_fengLodPink_Pink_Right takes nothing returns nothing
set gg_trg_fengLodPink_Pink_Right=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_fengLodPink_Pink_Right,Player(7),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_RIGHT)
call TriggerAddAction(gg_trg_fengLodPink_Pink_Right,function Trig_fengLodPink_Pink_Right_Actions)
endfunction
function Trig_fengLodPink_Pink_Down_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
endfunction
function InitTrig_fengLodPink_Pink_Down takes nothing returns nothing
set gg_trg_fengLodPink_Pink_Down=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_fengLodPink_Pink_Down,Player(7),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerAddAction(gg_trg_fengLodPink_Pink_Down,function Trig_fengLodPink_Pink_Down_Actions)
endfunction
function Trig_fengLodPink_Pink_Pink_Conditions takes nothing returns boolean
if(not(IsUnitType(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetOwningPlayer(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())))==Player(7)))then
return false
endif
return true
endfunction
function Trig_fengLodPink_Pink_Pink_Actions takes nothing returns nothing
set udg_fengLodbWu_Jie_Bian_Huan[GetConvertedPlayerId(GetTriggerPlayer())]=true
set udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetTriggerPlayer())]=FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))
call EnableTrigger(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1)
call EnableTrigger(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Life)
call EnableTrigger(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Anywhere)
call EnableTrigger(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Death)
call EnableTrigger(gg_trg_fengLodPink_fengLodNew_Wu_Jie_Bian_Huan_Twist)
call PanCameraToTimedLocForPlayer(Player(7),GetUnitLoc(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))),0)
call DisplayTimedTextToForce(GetPlayersAll(),10.00,(GetPlayerName(GetTriggerPlayer())+"|C00FF00FF开启了无界隐藏技能模式|R|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r"))
call DisplayTimedTextToForce(GetPlayersAll(),10.00,"|CFF00FF00恭喜粉色玩家开启无界作弊脚本，变身后可输入“变幻”关闭无界作弊脚本|R")
call SetUnitVertexColor(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),255,128,192,255)
call SetUnitMoveSpeed(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),522.00)
call CreateTextTagUnitBJ("|cFF00FF00无|r|cFFFFFF00界|r|cFFFFAA00变|r|cFFFF5500幻|r|cFFFF0000 III|r",FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),0,30.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),50.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call AddSpecialEffectTargetUnitBJ("overhead",FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer())),"Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
endfunction
function InitTrig_fengLodPink_Pink_Pink takes nothing returns nothing
set gg_trg_fengLodPink_Pink_Pink=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_fengLodPink_Pink_Pink,Player(7),"粉天使",true)
call TriggerAddCondition(gg_trg_fengLodPink_Pink_Pink,Condition(function Trig_fengLodPink_Pink_Pink_Conditions))
call TriggerAddAction(gg_trg_fengLodPink_Pink_Pink,function Trig_fengLodPink_Pink_Pink_Actions)
endfunction
function Trig_fengLodPink_fengLodNew_Wu_Jie_Bian_Huan_Twist_Conditions takes nothing returns boolean
if(not(udg_fengLodbWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==true))then
return false
endif
if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_fengLodPink_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_fengLodPink_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))==true)
endfunction
function Trig_fengLodPink_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003 takes nothing returns boolean
return GetBooleanAnd(Trig_fengLodPink_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003001(),Trig_fengLodPink_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003002())
endfunction
function Trig_fengLodPink_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func003A takes nothing returns nothing
call GroupAddUnitSimple(GetEnumUnit(),udg_fengLodPink_Twist_Group2)
call PauseUnitBJ(true,GetEnumUnit())
endfunction
function Trig_fengLodPink_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C takes nothing returns boolean
if(not(IsUnitAliveBJ(GetEnumUnit())==false))then
return false
endif
return true
endfunction
function Trig_fengLodPink_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func004Func001A takes nothing returns nothing
if(Trig_fengLodPink_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func004Func001Func001C())then
call GroupRemoveUnitSimple(GetEnumUnit(),udg_fengLodPink_Twist_Group2)
else
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetTriggerUnit(),GetEnumUnit(),((((I2R(GetHeroStr(GetTriggerUnit(),true))+I2R(GetHeroAgi(GetTriggerUnit(),true)))+I2R(GetHeroInt(GetTriggerUnit(),true)))*SquareRoot(I2R(GetHeroLevel(GetTriggerUnit()))))/ 2.00),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endif
endfunction
function Trig_fengLodPink_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func005A takes nothing returns nothing
call PauseUnitBJ(false,GetEnumUnit())
endfunction
function Trig_fengLodPink_fengLodNew_Wu_Jie_Bian_Huan_Twist_Actions takes nothing returns nothing
set udg_fengLodPink_Twist_Group1=GetUnitsInRangeOfLocMatching(512,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_fengLodPink_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func002002003))
call ForGroupBJ(udg_fengLodPink_Twist_Group1,function Trig_fengLodPink_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func003A)
set udg_fengLodPink_Twist_Loop=1
loop
exitwhen udg_fengLodPink_Twist_Loop>4
call ForGroupBJ(udg_fengLodPink_Twist_Group2,function Trig_fengLodPink_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func004Func001A)
call TriggerSleepAction(0.80)
set udg_fengLodPink_Twist_Loop=udg_fengLodPink_Twist_Loop+1
endloop
call ForGroupBJ(udg_fengLodPink_Twist_Group2,function Trig_fengLodPink_fengLodNew_Wu_Jie_Bian_Huan_Twist_Func005A)
call GroupClear(udg_fengLodPink_Twist_Group1)
call GroupClear(udg_fengLodPink_Twist_Group2)
endfunction
function InitTrig_fengLodPink_fengLodNew_Wu_Jie_Bian_Huan_Twist takes nothing returns nothing
set gg_trg_fengLodPink_fengLodNew_Wu_Jie_Bian_Huan_Twist=CreateTrigger()
call TriggerRegisterPlayerUnitEventSimple(gg_trg_fengLodPink_fengLodNew_Wu_Jie_Bian_Huan_Twist,Player(7),EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_fengLodPink_fengLodNew_Wu_Jie_Bian_Huan_Twist,Condition(function Trig_fengLodPink_fengLodNew_Wu_Jie_Bian_Huan_Twist_Conditions))
call TriggerAddAction(gg_trg_fengLodPink_fengLodNew_Wu_Jie_Bian_Huan_Twist,function Trig_fengLodPink_fengLodNew_Wu_Jie_Bian_Huan_Twist_Actions)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Conditions takes nothing returns boolean
if(not(GetAttacker()==udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))then
return false
endif
if(not(IsPlayerEnemy(GetOwningPlayer(GetTriggerUnit()),GetOwningPlayer(GetAttacker()))==true))then
return false
endif
if(not(udg_fengLodbWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==true))then
return false
endif
return true
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func002Func007001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func002Func007001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))==true)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func002Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func002Func007001003001(),Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func002Func007001003002())
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func002Func007A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\Starfall\\StarfallTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((I2R(GetHeroStr(GetAttacker(),true))*SquareRoot(I2R(GetHeroLevel(GetAttacker()))))*GetRandomReal(2.00,5.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func002C takes nothing returns boolean
if(not(udg_fengLodiNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]<=2))then
return false
endif
return true
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func007Func001001 takes nothing returns boolean
return(udg_fengLodiNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==3)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func007Func001002 takes nothing returns boolean
return(udg_fengLodiNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==4)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func007Func007001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func007Func007001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))==true)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func007Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func007Func007001003001(),Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func007Func007001003002())
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func007Func007A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\Blizzard\\BlizzardTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((I2R(GetHeroAgi(GetAttacker(),true))*SquareRoot(I2R(GetHeroLevel(GetAttacker()))))*GetRandomReal(2.00,5.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func007C takes nothing returns boolean
if(not GetBooleanOr(Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func007Func001001(),Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func007Func001002()))then
return false
endif
return true
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func008Func001001 takes nothing returns boolean
return(udg_fengLodiNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==5)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func008Func001002 takes nothing returns boolean
return(udg_fengLodiNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==6)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func008Func007001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func008Func007001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))==true)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func008Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func008Func007001003001(),Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func008Func007001003002())
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func008Func007A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((I2R(GetHeroInt(GetAttacker(),true))*SquareRoot(I2R(GetHeroLevel(GetAttacker()))))*GetRandomReal(2.00,5.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func008C takes nothing returns boolean
if(not GetBooleanOr(Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func008Func001001(),Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func008Func001002()))then
return false
endif
return true
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func009Func007001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func009Func007001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))==true)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func009Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func009Func007001003001(),Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func009Func007001003002())
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func009Func007A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),(((I2R(GetHeroInt(GetAttacker(),true))+I2R(GetHeroStr(GetAttacker(),true)))*SquareRoot(I2R(GetHeroLevel(GetAttacker()))))*GetRandomReal(2.00,5.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func009C takes nothing returns boolean
if(not(udg_fengLodiNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==7))then
return false
endif
return true
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func010Func006001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func010Func006001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))==true)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func010Func006001003 takes nothing returns boolean
return GetBooleanAnd(Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func010Func006001003001(),Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func010Func006001003002())
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func010Func006A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetAttacker()),"Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),(((I2R(GetHeroAgi(GetAttacker(),true))+I2R(GetHeroStr(GetAttacker(),true)))*SquareRoot(I2R(GetHeroLevel(GetAttacker()))))*GetRandomReal(2.00,5.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func010C takes nothing returns boolean
if(not(udg_fengLodiNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==8))then
return false
endif
return true
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func011Func006001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func011Func006001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))==true)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func011Func006001003 takes nothing returns boolean
return GetBooleanAnd(Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func011Func006001003001(),Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func011Func006001003002())
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func011Func006A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),(((I2R(GetHeroAgi(GetAttacker(),true))+I2R(GetHeroInt(GetAttacker(),true)))*SquareRoot(I2R(GetHeroLevel(GetAttacker()))))*GetRandomReal(2.00,5.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func011C takes nothing returns boolean
if(not(udg_fengLodiNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==9))then
return false
endif
return true
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func012C takes nothing returns boolean
if(not(udg_fengLodiNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==10))then
return false
endif
return true
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func013C takes nothing returns boolean
if(not(udg_fengLodiNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==11))then
return false
endif
return true
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Actions takes nothing returns nothing
set udg_fengLodiNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]=GetRandomInt(1,10)
if(Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func002C())then
call CreateTextTagUnitBJ("|cFF00FF00北|r|cFFFFFF00斗|r|cFFFFAA00伏|r|cFFFF5500魔|r",GetAttacker(),0,15.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching((SquareRoot((I2R(GetHeroInt(GetAttacker(),true))*(I2R(GetHeroLevel(GetAttacker()))/ 3.00)))+500.00),GetUnitLoc(GetAttackedUnitBJ()),Condition(function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func002Func007001003)),function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func002Func007A)
call DestroyGroup(GetLastCreatedGroup())
else
endif
if(Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func007C())then
call CreateTextTagUnitBJ("|cFF00FF00风|r|cFFFFFF00雪|r|cFFFFAA00冰|r|cFFFF5500天|r",GetAttacker(),0,15.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching((SquareRoot((I2R(GetHeroInt(GetAttacker(),true))*(I2R(GetHeroLevel(GetAttacker()))/ 3.00)))+500.00),GetUnitLoc(GetAttackedUnitBJ()),Condition(function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func007Func007001003)),function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func007Func007A)
call DestroyGroup(GetLastCreatedGroup())
else
endif
if(Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func008C())then
call CreateTextTagUnitBJ("|cFF00FF00雷|r|cFFFFFF00荧|r|cFFFFAA00万|r|cFFFF5500钧|r",GetAttacker(),0,15.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching((SquareRoot((I2R(GetHeroInt(GetAttacker(),true))*(I2R(GetHeroLevel(GetAttacker()))/ 3.00)))+500.00),GetUnitLoc(GetAttackedUnitBJ()),Condition(function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func008Func007001003)),function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func008Func007A)
call DestroyGroup(GetLastCreatedGroup())
else
endif
if(Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func009C())then
call CreateTextTagUnitBJ("|cFF00FF00末|r|cFFFFFF00日|r|cFFFFAA00审|r|cFFFF5500判|r",GetAttacker(),0,20.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(512.00,GetUnitLoc(GetAttackedUnitBJ()),Condition(function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func009Func007001003)),function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func009Func007A)
call DestroyGroup(GetLastCreatedGroup())
else
endif
if(Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func010C())then
call CreateTextTagUnitBJ("|cFF00FF00雷|r|cFFFFFF00霆|r|cFFFFAA00一|r|cFFFF5500击|r",GetAttacker(),0,20.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(450.00,GetUnitLoc(GetAttackedUnitBJ()),Condition(function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func010Func006001003)),function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func010Func006A)
call DestroyGroup(GetLastCreatedGroup())
else
endif
if(Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func011C())then
call CreateTextTagUnitBJ("|cFF00FF00神|r|cFFFFFF00罚|r|cFFFFAA00时|r|cFFFF5500刻|r",GetAttacker(),0,20.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(512.00,GetUnitLoc(GetAttackedUnitBJ()),Condition(function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func011Func006001003)),function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func011Func006A)
call DestroyGroup(GetLastCreatedGroup())
else
endif
if(Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func012C())then
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
if(Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Func013C())then
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
function InitTrig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1 takes nothing returns nothing
set gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1,Condition(function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Conditions))
call TriggerAddAction(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1,function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1_Actions)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Conditions takes nothing returns boolean
if(not(IsUnitIllusionBJ(GetAttacker())==true))then
return false
endif
if(not(IsPlayerEnemy(GetOwningPlayer(GetTriggerUnit()),GetOwningPlayer(GetAttacker()))==true))then
return false
endif
if(not(udg_fengLodbWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==true))then
return false
endif
return true
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func002Func007001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func002Func007001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))==true)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func002Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func002Func007001003001(),Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func002Func007001003002())
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func002Func007A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\Starfall\\StarfallTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetEnumUnit(),((I2R(GetHeroStr(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))*SquareRoot(I2R(GetHeroLevel(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))))*GetRandomReal(1.00,3.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func002C takes nothing returns boolean
if(not(udg_fengLodiNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]<=2))then
return false
endif
return true
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func007Func001001 takes nothing returns boolean
return(udg_fengLodiNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==3)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func007Func001002 takes nothing returns boolean
return(udg_fengLodiNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==4)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func007Func007001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func007Func007001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))==true)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func007Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func007Func007001003001(),Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func007Func007001003002())
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func007Func007A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\Blizzard\\BlizzardTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetEnumUnit(),((I2R(GetHeroAgi(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))*SquareRoot(I2R(GetHeroLevel(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))))*GetRandomReal(1.00,3.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func007C takes nothing returns boolean
if(not GetBooleanOr(Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func007Func001001(),Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func007Func001002()))then
return false
endif
return true
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func008Func001001 takes nothing returns boolean
return(udg_fengLodiNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==5)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func008Func001002 takes nothing returns boolean
return(udg_fengLodiNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==6)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func008Func007001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func008Func007001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))==true)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func008Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func008Func007001003001(),Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func008Func007001003002())
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func008Func007A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetEnumUnit(),((I2R(GetHeroInt(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))*SquareRoot(I2R(GetHeroLevel(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))))*GetRandomReal(1.00,3.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func008C takes nothing returns boolean
if(not GetBooleanOr(Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func008Func001001(),Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func008Func001002()))then
return false
endif
return true
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func009Func007001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func009Func007001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))==true)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func009Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func009Func007001003001(),Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func009Func007001003002())
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func009Func007A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetEnumUnit(),(((I2R(GetHeroInt(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))+I2R(GetHeroStr(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true)))*SquareRoot(I2R(GetHeroLevel(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))))*GetRandomReal(2.00,4.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func009C takes nothing returns boolean
if(not(udg_fengLodiNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==7))then
return false
endif
return true
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func010Func006001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func010Func006001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))==true)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func010Func006001003 takes nothing returns boolean
return GetBooleanAnd(Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func010Func006001003001(),Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func010Func006001003002())
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func010Func006A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetAttacker()),"Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetEnumUnit(),(((I2R(GetHeroAgi(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))+I2R(GetHeroStr(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true)))*SquareRoot(I2R(GetHeroLevel(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))))*GetRandomReal(2.00,4.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func010C takes nothing returns boolean
if(not(udg_fengLodiNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==8))then
return false
endif
return true
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func011Func006001003001 takes nothing returns boolean
return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func011Func006001003002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))==true)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func011Func006001003 takes nothing returns boolean
return GetBooleanAnd(Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func011Func006001003001(),Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func011Func006001003002())
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func011Func006A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetEnumUnit(),(((I2R(GetHeroAgi(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))+I2R(GetHeroInt(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true)))*SquareRoot(I2R(GetHeroLevel(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))))*GetRandomReal(2.00,4.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func011C takes nothing returns boolean
if(not(udg_fengLodiNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==9))then
return false
endif
return true
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func012C takes nothing returns boolean
if(not(udg_fengLodiNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==10))then
return false
endif
return true
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func013C takes nothing returns boolean
if(not(udg_fengLodiNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==11))then
return false
endif
return true
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Actions takes nothing returns nothing
set udg_fengLodiNew_Wu_Jie_Ablity[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]=GetRandomInt(1,10)
if(Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func002C())then
call CreateTextTagUnitBJ("|cFF00FF00北|r|cFFFFFF00斗|r|cFFFFAA00伏|r|cFFFF5500魔|r",GetAttacker(),0,15.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching((SquareRoot((I2R(GetHeroInt(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))*(I2R(GetHeroLevel(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))/ 3.00)))+500.00),GetUnitLoc(GetAttackedUnitBJ()),Condition(function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func002Func007001003)),function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func002Func007A)
call DestroyGroup(GetLastCreatedGroup())
else
endif
if(Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func007C())then
call CreateTextTagUnitBJ("|cFF00FF00风|r|cFFFFFF00雪|r|cFFFFAA00冰|r|cFFFF5500天|r",GetAttacker(),0,15.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching((SquareRoot((I2R(GetHeroInt(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))*(I2R(GetHeroLevel(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))/ 3.00)))+500.00),GetUnitLoc(GetAttackedUnitBJ()),Condition(function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func007Func007001003)),function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func007Func007A)
call DestroyGroup(GetLastCreatedGroup())
else
endif
if(Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func008C())then
call CreateTextTagUnitBJ("|cFF00FF00雷|r|cFFFFFF00荧|r|cFFFFAA00万|r|cFFFF5500钧|r",GetAttacker(),0,15.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching((SquareRoot((I2R(GetHeroInt(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))*(I2R(GetHeroLevel(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))/ 3.00)))+500.00),GetUnitLoc(GetAttackedUnitBJ()),Condition(function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func008Func007001003)),function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func008Func007A)
call DestroyGroup(GetLastCreatedGroup())
else
endif
if(Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func009C())then
call CreateTextTagUnitBJ("|cFF00FF00末|r|cFFFFFF00日|r|cFFFFAA00审|r|cFFFF5500判|r",GetAttacker(),0,20.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(512.00,GetUnitLoc(GetAttackedUnitBJ()),Condition(function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func009Func007001003)),function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func009Func007A)
call DestroyGroup(GetLastCreatedGroup())
else
endif
if(Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func010C())then
call CreateTextTagUnitBJ("|cFF00FF00雷|r|cFFFFFF00霆|r|cFFFFAA00一|r|cFFFF5500击|r",GetAttacker(),0,20.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(450.00,GetUnitLoc(GetAttackedUnitBJ()),Condition(function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func010Func006001003)),function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func010Func006A)
call DestroyGroup(GetLastCreatedGroup())
else
endif
if(Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func011C())then
call CreateTextTagUnitBJ("|cFF00FF00神|r|cFFFFFF00罚|r|cFFFFAA00时|r|cFFFF5500刻|r",GetAttacker(),0,20.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(512.00,GetUnitLoc(GetAttackedUnitBJ()),Condition(function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func011Func006001003)),function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func011Func006A)
call DestroyGroup(GetLastCreatedGroup())
else
endif
if(Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func012C())then
call CreateTextTagUnitBJ("|cFF00FF00死|r|cFFFFFF00亡|r|cFFFFAA00一|r|cFFFF5500击|r",GetAttacker(),0,25.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call AddSpecialEffectLocBJ(GetUnitLoc(GetTriggerUnit()),"Abilities\\Spells\\Undead\\DeathCoil\\DeathCoilSpecialArt.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetTriggerUnit(),(((I2R(GetHeroAgi(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))+(I2R(GetHeroStr(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))+I2R(GetHeroInt(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))))*SquareRoot(I2R(GetHeroLevel(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))))*GetRandomReal(1.00,3.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
else
endif
if(Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Func013C())then
call CreateTextTagUnitBJ("|cFF00FF00毁|r|cFFFFFF00灭|r|cFFFFAA00一|r|cFFFF5500击|r",GetAttacker(),0,25.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\Demon\\DarkPortal\\DarkPortalTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetTriggerUnit(),(((I2R(GetHeroAgi(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))+(I2R(GetHeroStr(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))+I2R(GetHeroInt(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],true))))*SquareRoot(I2R(GetHeroLevel(udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))))*GetRandomReal(4.00,6.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
else
endif
endfunction
function InitTrig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2 takes nothing returns nothing
set gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2,Condition(function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Conditions))
call TriggerAddAction(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2,function Trig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2_Actions)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Life_Conditions takes nothing returns boolean
if(not(GetTriggerUnit()==udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))then
return false
endif
if(not(udg_fengLodbWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==true))then
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
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Life_Actions takes nothing returns nothing
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
function InitTrig_fengLodNew_Wu_Jie_Bian_Huan_Life takes nothing returns nothing
set gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Life=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Life,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Life,Condition(function Trig_fengLodNew_Wu_Jie_Bian_Huan_Life_Conditions))
call TriggerAddAction(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Life,function Trig_fengLodNew_Wu_Jie_Bian_Huan_Life_Actions)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Anywhere_Conditions takes nothing returns boolean
if(not(udg_fengLodbWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==true))then
return false
endif
if(not(GetIssuedOrderIdBJ()==String2OrderIdBJ("patrol")))then
return false
endif
return true
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Anywhere_Actions takes nothing returns nothing
call SetUnitPositionLoc(GetTriggerUnit(),GetOrderPointLoc())
call CreateTextTagUnitBJ("|cFF00FF00空|r|cFFFFFF00间|r|cFFFFAA00闪|r|cFFFF5500烁|r",GetTriggerUnit(),0,25.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
endfunction
function InitTrig_fengLodNew_Wu_Jie_Bian_Huan_Anywhere takes nothing returns nothing
set gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Anywhere=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Anywhere,EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
call TriggerAddCondition(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Anywhere,Condition(function Trig_fengLodNew_Wu_Jie_Bian_Huan_Anywhere_Conditions))
call TriggerAddAction(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Anywhere,function Trig_fengLodNew_Wu_Jie_Bian_Huan_Anywhere_Actions)
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Death_Conditions takes nothing returns boolean
if(not(GetTriggerUnit()==udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))then
return false
endif
if(not(udg_fengLodbWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==true))then
return false
endif
return true
endfunction
function Trig_fengLodNew_Wu_Jie_Bian_Huan_Death_Actions takes nothing returns nothing
call ModifyHeroStat(bj_HEROSTAT_STR,GetTriggerUnit(),bj_MODIFYMETHOD_ADD,100)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetTriggerUnit(),bj_MODIFYMETHOD_ADD,100)
call ModifyHeroStat(bj_HEROSTAT_INT,GetTriggerUnit(),bj_MODIFYMETHOD_ADD,100)
endfunction
function InitTrig_fengLodNew_Wu_Jie_Bian_Huan_Death takes nothing returns nothing
set gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Death=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Death,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddCondition(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Death,Condition(function Trig_fengLodNew_Wu_Jie_Bian_Huan_Death_Conditions))
call TriggerAddAction(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Death,function Trig_fengLodNew_Wu_Jie_Bian_Huan_Death_Actions)
endfunction
function Trig_fengLodWuJie_Lv_Up_Conditions takes nothing returns boolean
if(not(GetTriggerUnit()==udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))then
return false
endif
if(not(udg_fengLodbWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==true))then
return false
endif
return true
endfunction
function Trig_fengLodWuJie_Lv_Up_Actions takes nothing returns nothing
call ModifyHeroStat(bj_HEROSTAT_STR,GetTriggerUnit(),bj_MODIFYMETHOD_ADD,30)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetTriggerUnit(),bj_MODIFYMETHOD_ADD,30)
call ModifyHeroStat(bj_HEROSTAT_INT,GetTriggerUnit(),bj_MODIFYMETHOD_ADD,30)
endfunction
function InitTrig_fengLodWuJie_Lv_Up takes nothing returns nothing
set gg_trg_fengLodWuJie_Lv_Up=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_fengLodWuJie_Lv_Up,EVENT_PLAYER_HERO_LEVEL)
call TriggerAddCondition(gg_trg_fengLodWuJie_Lv_Up,Condition(function Trig_fengLodWuJie_Lv_Up_Conditions))
call TriggerAddAction(gg_trg_fengLodWuJie_Lv_Up,function Trig_fengLodWuJie_Lv_Up_Actions)
endfunction
function Trig_fengLodWuJie_EXE_Conditions takes nothing returns boolean
if(not(GetAttacker()==udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))then
return false
endif
if(not(udg_fengLodbWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==true))then
return false
endif
return true
endfunction
function Trig_fengLodWuJie_EXE_Func001C takes nothing returns boolean
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_fengLodWuJie_EXE_Func002C takes nothing returns boolean
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_fengLodWuJie_EXE_Actions takes nothing returns nothing
if(Trig_fengLodWuJie_EXE_Func001C())then
call AddHeroXPSwapped((50*GetHeroLevel(GetAttacker())),GetAttacker(),true)
else
endif
if(Trig_fengLodWuJie_EXE_Func002C())then
call AddHeroXPSwapped((10*GetHeroLevel(GetAttacker())),GetAttacker(),true)
else
endif
endfunction
function InitTrig_fengLodWuJie_EXE takes nothing returns nothing
set gg_trg_fengLodWuJie_EXE=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_fengLodWuJie_EXE,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_fengLodWuJie_EXE,Condition(function Trig_fengLodWuJie_EXE_Conditions))
call TriggerAddAction(gg_trg_fengLodWuJie_EXE,function Trig_fengLodWuJie_EXE_Actions)
endfunction
function Trig_fengLodWuJie_Lv_Up_10_Conditions takes nothing returns boolean
if(not(GetTriggerUnit()==udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))then
return false
endif
if(not(udg_fengLodbWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==true))then
return false
endif
return true
endfunction
function Trig_fengLodWuJie_Lv_Up_10_Func003C takes nothing returns boolean
if(not(GetHeroLevel(GetTriggerUnit())==10))then
return false
endif
return true
endfunction
function Trig_fengLodWuJie_Lv_Up_10_Actions takes nothing returns nothing
if(Trig_fengLodWuJie_Lv_Up_10_Func003C())then
call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()),0,0,10.00,"|CFF00FF00英雄等级达到10级，领悟妙手空空技能|R")
else
endif
endfunction
function InitTrig_fengLodWuJie_Lv_Up_10 takes nothing returns nothing
set gg_trg_fengLodWuJie_Lv_Up_10=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_fengLodWuJie_Lv_Up_10,EVENT_PLAYER_HERO_LEVEL)
call TriggerAddCondition(gg_trg_fengLodWuJie_Lv_Up_10,Condition(function Trig_fengLodWuJie_Lv_Up_10_Conditions))
call TriggerAddAction(gg_trg_fengLodWuJie_Lv_Up_10,function Trig_fengLodWuJie_Lv_Up_10_Actions)
endfunction
function Trig_fengLodWuJie_KongKong_Conditions takes nothing returns boolean
if(not(GetAttacker()==udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))then
return false
endif
if(not(udg_fengLodbWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==true))then
return false
endif
return true
endfunction
function Trig_fengLodWuJie_KongKong_Func003Func004001 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())>=10)
endfunction
function Trig_fengLodWuJie_KongKong_Func003Func004002 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())<20)
endfunction
function Trig_fengLodWuJie_KongKong_Func003C takes nothing returns boolean
if(not GetBooleanAnd(Trig_fengLodWuJie_KongKong_Func003Func004001(),Trig_fengLodWuJie_KongKong_Func003Func004002()))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_fengLodWuJie_KongKong_Func004Func004001 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())>=20)
endfunction
function Trig_fengLodWuJie_KongKong_Func004Func004002 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())<30)
endfunction
function Trig_fengLodWuJie_KongKong_Func004C takes nothing returns boolean
if(not GetBooleanAnd(Trig_fengLodWuJie_KongKong_Func004Func004001(),Trig_fengLodWuJie_KongKong_Func004Func004002()))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_fengLodWuJie_KongKong_Func005Func004001 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())>=30)
endfunction
function Trig_fengLodWuJie_KongKong_Func005Func004002 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())<40)
endfunction
function Trig_fengLodWuJie_KongKong_Func005C takes nothing returns boolean
if(not GetBooleanAnd(Trig_fengLodWuJie_KongKong_Func005Func004001(),Trig_fengLodWuJie_KongKong_Func005Func004002()))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_fengLodWuJie_KongKong_Func006Func004001 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())>=60)
endfunction
function Trig_fengLodWuJie_KongKong_Func006Func004002 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())<70)
endfunction
function Trig_fengLodWuJie_KongKong_Func006C takes nothing returns boolean
if(not GetBooleanAnd(Trig_fengLodWuJie_KongKong_Func006Func004001(),Trig_fengLodWuJie_KongKong_Func006Func004002()))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_fengLodWuJie_KongKong_Func007Func004001 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())>=50)
endfunction
function Trig_fengLodWuJie_KongKong_Func007Func004002 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())<60)
endfunction
function Trig_fengLodWuJie_KongKong_Func007C takes nothing returns boolean
if(not GetBooleanAnd(Trig_fengLodWuJie_KongKong_Func007Func004001(),Trig_fengLodWuJie_KongKong_Func007Func004002()))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_fengLodWuJie_KongKong_Func008Func004001 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())>=60)
endfunction
function Trig_fengLodWuJie_KongKong_Func008Func004002 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())<70)
endfunction
function Trig_fengLodWuJie_KongKong_Func008C takes nothing returns boolean
if(not GetBooleanAnd(Trig_fengLodWuJie_KongKong_Func008Func004001(),Trig_fengLodWuJie_KongKong_Func008Func004002()))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_fengLodWuJie_KongKong_Func009Func004001 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())>=70)
endfunction
function Trig_fengLodWuJie_KongKong_Func009Func004002 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())<80)
endfunction
function Trig_fengLodWuJie_KongKong_Func009C takes nothing returns boolean
if(not GetBooleanAnd(Trig_fengLodWuJie_KongKong_Func009Func004001(),Trig_fengLodWuJie_KongKong_Func009Func004002()))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_fengLodWuJie_KongKong_Func010Func004001 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())>=80)
endfunction
function Trig_fengLodWuJie_KongKong_Func010Func004002 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())<90)
endfunction
function Trig_fengLodWuJie_KongKong_Func010C takes nothing returns boolean
if(not GetBooleanAnd(Trig_fengLodWuJie_KongKong_Func010Func004001(),Trig_fengLodWuJie_KongKong_Func010Func004002()))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_fengLodWuJie_KongKong_Func011Func004001 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())>=90)
endfunction
function Trig_fengLodWuJie_KongKong_Func011Func004002 takes nothing returns boolean
return(GetHeroLevel(GetAttacker())<100)
endfunction
function Trig_fengLodWuJie_KongKong_Func011C takes nothing returns boolean
if(not GetBooleanAnd(Trig_fengLodWuJie_KongKong_Func011Func004001(),Trig_fengLodWuJie_KongKong_Func011Func004002()))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_fengLodWuJie_KongKong_Func012C takes nothing returns boolean
if(not(GetHeroLevel(GetAttacker())>=100))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_fengLodWuJie_KongKong_Actions takes nothing returns nothing
if(Trig_fengLodWuJie_KongKong_Func003C())then
set udg_fengLodiWuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]=((GetRandomInt(1,100)*GetHeroLevel(GetAttacker()))+500)
call AdjustPlayerStateBJ(udg_fengLodiWuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetOwningPlayer(GetAttacker()),PLAYER_STATE_RESOURCE_GOLD)
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,("|CFFFFFF00金钱+"+(I2S(udg_fengLodiWuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])+"|R")))
else
endif
if(Trig_fengLodWuJie_KongKong_Func004C())then
set udg_fengLodiWuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]=((GetRandomInt(1,100)*GetHeroLevel(GetAttacker()))+2000)
call AdjustPlayerStateBJ(udg_fengLodiWuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetOwningPlayer(GetAttacker()),PLAYER_STATE_RESOURCE_GOLD)
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,("|CFFFFFF00金钱+"+(I2S(udg_fengLodiWuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])+"|R")))
else
endif
if(Trig_fengLodWuJie_KongKong_Func005C())then
set udg_fengLodiWuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]=((GetRandomInt(1,100)*GetHeroLevel(GetAttacker()))+3000)
call AdjustPlayerStateBJ(udg_fengLodiWuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetOwningPlayer(GetAttacker()),PLAYER_STATE_RESOURCE_GOLD)
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,("|CFFFFFF00金钱+"+(I2S(udg_fengLodiWuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])+"|R")))
else
endif
if(Trig_fengLodWuJie_KongKong_Func006C())then
set udg_fengLodiWuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]=((GetRandomInt(1,100)*GetHeroLevel(GetAttacker()))+5000)
call AdjustPlayerStateBJ(udg_fengLodiWuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetOwningPlayer(GetAttacker()),PLAYER_STATE_RESOURCE_GOLD)
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,("|CFFFFFF00金钱+"+(I2S(udg_fengLodiWuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])+"|R")))
else
endif
if(Trig_fengLodWuJie_KongKong_Func007C())then
set udg_fengLodiWuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]=((GetRandomInt(1,100)*GetHeroLevel(GetAttacker()))+7500)
call AdjustPlayerStateBJ(udg_fengLodiWuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetOwningPlayer(GetAttacker()),PLAYER_STATE_RESOURCE_GOLD)
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,("|CFFFFFF00金钱+"+(I2S(udg_fengLodiWuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])+"|R")))
else
endif
if(Trig_fengLodWuJie_KongKong_Func008C())then
set udg_fengLodiWuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]=((GetRandomInt(1,100)*GetHeroLevel(GetAttacker()))+10000)
call AdjustPlayerStateBJ(udg_fengLodiWuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetOwningPlayer(GetAttacker()),PLAYER_STATE_RESOURCE_GOLD)
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,("|CFFFFFF00金钱+"+(I2S(udg_fengLodiWuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])+"|R")))
else
endif
if(Trig_fengLodWuJie_KongKong_Func009C())then
set udg_fengLodiWuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]=((GetRandomInt(1,100)*GetHeroLevel(GetAttacker()))+15000)
call AdjustPlayerStateBJ(udg_fengLodiWuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetOwningPlayer(GetAttacker()),PLAYER_STATE_RESOURCE_GOLD)
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,("|CFFFFFF00金钱+"+(I2S(udg_fengLodiWuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])+"|R")))
else
endif
if(Trig_fengLodWuJie_KongKong_Func010C())then
set udg_fengLodiWuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]=((GetRandomInt(1,100)*GetHeroLevel(GetAttacker()))+20000)
call AdjustPlayerStateBJ(udg_fengLodiWuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetOwningPlayer(GetAttacker()),PLAYER_STATE_RESOURCE_GOLD)
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,("|CFFFFFF00金钱+"+(I2S(udg_fengLodiWuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])+"|R")))
else
endif
if(Trig_fengLodWuJie_KongKong_Func011C())then
set udg_fengLodiWuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]=((GetRandomInt(1,100)*GetHeroLevel(GetAttacker()))+30000)
call AdjustPlayerStateBJ(udg_fengLodiWuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetOwningPlayer(GetAttacker()),PLAYER_STATE_RESOURCE_GOLD)
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,("|CFFFFFF00金钱+"+(I2S(udg_fengLodiWuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])+"|R")))
else
endif
if(Trig_fengLodWuJie_KongKong_Func012C())then
set udg_fengLodiWuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]=((GetRandomInt(1,100)*101)+30000)
call AdjustPlayerStateBJ(udg_fengLodiWuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))],GetOwningPlayer(GetAttacker()),PLAYER_STATE_RESOURCE_GOLD)
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,("|CFFFFFF00金钱+"+(I2S(udg_fengLodiWuJie_Manoy[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])+"|R")))
else
endif
endfunction
function InitTrig_fengLodWuJie_KongKong takes nothing returns nothing
set gg_trg_fengLodWuJie_KongKong=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_fengLodWuJie_KongKong,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_fengLodWuJie_KongKong,Condition(function Trig_fengLodWuJie_KongKong_Conditions))
call TriggerAddAction(gg_trg_fengLodWuJie_KongKong,function Trig_fengLodWuJie_KongKong_Actions)
endfunction
function Trig_fengLodWuJie_ShuXing_Conditions takes nothing returns boolean
if(not(GetAttacker()==udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))then
return false
endif
if(not(udg_fengLodbWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==true))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_fengLodWuJie_ShuXing_Actions takes nothing returns nothing
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,"|cFF00FF00属|r|cFFFFFF00性|r|cFFFFAA00提|r|cFFFF5500升|r")
call CreateTextTagUnitBJ("|cFF00FF00属|r|cFFFFFF00性|r|cFFFFAA00提|r|cFFFF5500升|r",GetAttacker(),0,10.00,100,100.00,100.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),90.00,90.00)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
call SetTextTagFadepoint(GetLastCreatedTextTag(),1.00)
call ModifyHeroStat(bj_HEROSTAT_STR,GetAttacker(),bj_MODIFYMETHOD_ADD,30)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetAttacker(),bj_MODIFYMETHOD_ADD,30)
call ModifyHeroStat(bj_HEROSTAT_INT,GetAttacker(),bj_MODIFYMETHOD_ADD,30)
endfunction
function InitTrig_fengLodWuJie_ShuXing takes nothing returns nothing
set gg_trg_fengLodWuJie_ShuXing=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_fengLodWuJie_ShuXing,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_fengLodWuJie_ShuXing,Condition(function Trig_fengLodWuJie_ShuXing_Conditions))
call TriggerAddAction(gg_trg_fengLodWuJie_ShuXing,function Trig_fengLodWuJie_ShuXing_Actions)
endfunction
function Trig_fengLodWuJie_ReAblity_Conditions takes nothing returns boolean
if(not(GetAttacker()==udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))then
return false
endif
if(not(udg_fengLodbWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]==true))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_fengLodWuJie_ReAblity_Actions takes nothing returns nothing
call UnitResetCooldown(GetAttacker())
call DisplayTextToPlayer(GetOwningPlayer(GetAttacker()),0,0,"|C00FF00FF重置技能CD|R")
endfunction
function InitTrig_fengLodWuJie_ReAblity takes nothing returns nothing
set gg_trg_fengLodWuJie_ReAblity=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_fengLodWuJie_ReAblity,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_fengLodWuJie_ReAblity,Condition(function Trig_fengLodWuJie_ReAblity_Conditions))
call TriggerAddAction(gg_trg_fengLodWuJie_ReAblity,function Trig_fengLodWuJie_ReAblity_Actions)
endfunction
function Trig_fengLodWuJie_FanDan_Conditions takes nothing returns boolean
if(not(GetTriggerUnit()==udg_fengLodplayerWu_Jie[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))then
return false
endif
if(not(udg_fengLodbWu_Jie_Bian_Huan[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==true))then
return false
endif
if(not(GetRandomInt(1,1)==1))then
return false
endif
return true
endfunction
function Trig_fengLodWuJie_FanDan_Func003C takes nothing returns boolean
if(not(IsUnitType(GetAttacker(),UNIT_TYPE_HERO)==true))then
return false
endif
return true
endfunction
function Trig_fengLodWuJie_FanDan_Actions takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetAttacker(),"Abilities\\Spells\\Other\\ForkedLightning\\ForkedLightningTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
if(Trig_fengLodWuJie_FanDan_Func003C())then
call UnitDamageTargetBJ(GetTriggerUnit(),GetAttacker(),((((I2R(GetHeroStr(GetTriggerUnit(),true))+I2R(GetHeroAgi(GetTriggerUnit(),true)))+I2R(GetHeroInt(GetTriggerUnit(),true)))*2.00)+(GetUnitStateSwap(UNIT_STATE_MAX_LIFE,GetAttacker())/ 200.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_SHADOW_STRIKE)
else
call UnitDamageTargetBJ(GetTriggerUnit(),GetAttacker(),((((I2R(GetHeroStr(GetTriggerUnit(),true))+I2R(GetHeroAgi(GetTriggerUnit(),true)))+I2R(GetHeroInt(GetTriggerUnit(),true)))*2.00)+(GetUnitStateSwap(UNIT_STATE_MAX_LIFE,GetAttacker())/ 50.00)),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_SHADOW_STRIKE)
endif
endfunction
function InitTrig_fengLodWuJie_FanDan takes nothing returns nothing
set gg_trg_fengLodWuJie_FanDan=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_fengLodWuJie_FanDan,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_fengLodWuJie_FanDan,Condition(function Trig_fengLodWuJie_FanDan_Conditions))
call TriggerAddAction(gg_trg_fengLodWuJie_FanDan,function Trig_fengLodWuJie_FanDan_Actions)
endfunction
function fengLodWu_Jie_Bian_Huan_2 takes nothing returns nothing
call InitTrig_fengLodNew_Wu_Jie_Bian_Huan_Start()
call InitTrig_fengLodCloce_Wu_Jie_Bian_Huan()
call InitTrig_fengLodWu_Jie_Help()
call InitTrig_fengLodRed_Fire_Up()
call InitTrig_fengLodRed_Fire_Left()
call InitTrig_fengLodRed_Fire_Down()
call InitTrig_fengLodRed_Fire_Right()
call InitTrig_fengLodRed_Fire()
call InitTrig_fengLodRed_fengLodNew_Wu_Jie_Bian_Huan_Twist()
call InitTrig_fengLodBlue_Ice_Left()
call InitTrig_fengLodBlue_Ice_Down()
call InitTrig_fengLodBlue_Ice_Right()
call InitTrig_fengLodBlue_Ice_Up()
call InitTrig_fengLodBlue_Ice()
call InitTrig_fengLodBlue_fengLodNew_Wu_Jie_Bian_Huan_Twist()
call InitTrig_fengLodCyan_Bolt_Down()
call InitTrig_fengLodCyan_Bolt_Right()
call InitTrig_fengLodCyan_Bolt_Up()
call InitTrig_fengLodCyan_Bolt_Left()
call InitTrig_fengLodCyan_Bolt()
call InitTrig_fengLodCyan_fengLodNew_Wu_Jie_Bian_Huan_Twist()
call InitTrig_fengLodPurple_Moon_Right()
call InitTrig_fengLodPurple_Moon_Up()
call InitTrig_fengLodPurple_Moon_Left()
call InitTrig_fengLodPurple_Moon_Down()
call InitTrig_fengLodPurple_Moon()
call InitTrig_fengLodPurple_fengLodNew_Wu_Jie_Bian_Huan_Twist()
call InitTrig_fengLodYellow_Light_Up()
call InitTrig_fengLodYellow_Light_Right()
call InitTrig_fengLodYellow_Light_Down()
call InitTrig_fengLodYellow_Light_Left()
call InitTrig_fengLodYellow_Light()
call InitTrig_fengLodYellow_fengLodNew_Wu_Jie_Bian_Huan_Twist()
call InitTrig_fengLodOrange_Wind_Right()
call InitTrig_fengLodOrange_Wind_Down()
call InitTrig_fengLodOrange_Wind_Left()
call InitTrig_fengLodOrange_Wind_Up()
call InitTrig_fengLodOrange_Wind()
call InitTrig_fengLodOrange_fengLodNew_Wu_Jie_Bian_Huan_Twist()
call InitTrig_fengLodWGreen_Wood_Down()
call InitTrig_fengLodWGreen_Wood_Left()
call InitTrig_fengLodWGreen_Wood_Up()
call InitTrig_fengLodWGreen_Wood_Right()
call InitTrig_fengLodWGreen_Wood()
call InitTrig_fengLodGreen_fengLodNew_Wu_Jie_Bian_Huan_Twist()
call InitTrig_fengLodPink_Pink_Left()
call InitTrig_fengLodPink_Pink_Up()
call InitTrig_fengLodPink_Pink_Right()
call InitTrig_fengLodPink_Pink_Down()
call InitTrig_fengLodPink_Pink_Pink()
call InitTrig_fengLodPink_fengLodNew_Wu_Jie_Bian_Huan_Twist()
call InitTrig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_1()
call InitTrig_fengLodNew_Wu_Jie_Bian_Huan_Ablity_2()
call InitTrig_fengLodNew_Wu_Jie_Bian_Huan_Life()
call InitTrig_fengLodNew_Wu_Jie_Bian_Huan_Anywhere()
call InitTrig_fengLodNew_Wu_Jie_Bian_Huan_Death()
call InitTrig_fengLodWuJie_Lv_Up()
call InitTrig_fengLodWuJie_EXE()
call InitTrig_fengLodWuJie_Lv_Up_10()
call InitTrig_fengLodWuJie_KongKong()
call InitTrig_fengLodWuJie_ShuXing()
call InitTrig_fengLodWuJie_ReAblity()
call InitTrig_fengLodWuJie_FanDan()
endfunction
function fengLodWu_Jie_Bian_Huan_3 takes nothing returns nothing
call ConditionalTriggerExecute(gg_trg_fengLodNew_Wu_Jie_Bian_Huan_Start)
endfunction