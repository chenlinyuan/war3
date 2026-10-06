//function Trig_XHCDXzb2Func001Func003002002 takes nothing returns boolean
//return((IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true))
//endfunction
function Trig_XHCDXzb2Actions takes nothing returns nothing
if(((GetEventPlayerChatString()=="支持www.war3.xin")and(IsPlayerInForce(GetTriggerPlayer(),udg_SZBwjz)==false)))then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10.00,"|cFF33FF66魔闪网：恭喜你获得RG赠送的赞助礼包|r")
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10.00,"|cFF33FF66金币*10000 木材*100|r")
//call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,"|cFF33FF66魔闪网：恭喜你获得赠送的赞助礼包|r")
//call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,"|cFFFFFF00魔之权杖|r")
//set udg_SZBdwz[GetPlayerId(GetTriggerPlayer())]=GetUnitsOfPlayerMatching(GetTriggerPlayer(),Condition(function Trig_XHCDXzb2Func001Func003002002))
//call UnitAddItemByIdSwapped('I06N',FirstOfGroup(udg_SZBdwz[GetPlayerId(GetTriggerPlayer())]))
call AdjustPlayerStateBJ(10000,GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD)
call AdjustPlayerStateBJ(100,GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER)
call ForceAddPlayer(udg_SZBwjz,GetTriggerPlayer())
else
if(((GetEventPlayerChatString()=="支持www.war3.xin")and(IsPlayerInForce(GetTriggerPlayer(),udg_SZBwjz)==true)))then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10.00,"|cFF33FF66只能获得一次|r")
else
endif
endif
//if(((GetEventPlayerChatString()=="-fm")))then
//call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10.00,"|cFF33FF66粉末登场|r")
//set udg_SZBdwz[GetPlayerId(GetTriggerPlayer())]=GetUnitsOfPlayerMatching(GetTriggerPlayer(),Condition(function Trig_XHCDXzb2Func001Func003002002))
//call UnitAddItemByIdSwapped('I04U',FirstOfGroup(udg_SZBdwz[GetPlayerId(GetTriggerPlayer())]))
//call SetItemCharges( GetLastCreatedItem(),10)
//call ForceAddPlayer(udg_SZBwjz,GetTriggerPlayer())
//endif
//else
//endif
//if(((GetEventPlayerChatString()=="kqqt")and(IsPlayerInForce(GetTriggerPlayer(),udg_KQTwjz)==false)))then
//call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,"|cFF33FF66成功开启全图|r")
//set udg_QTXZQ[GetPlayerId(GetTriggerPlayer())]=CreateFogModifierRect(GetTriggerPlayer(), FOG_OF_WAR_VISIBLE, GetPlayableMapRect(), false, false)
//call FogModifierStart(udg_QTXZQ[GetPlayerId(GetTriggerPlayer())])
//call ForceAddPlayer(udg_KQTwjz,GetTriggerPlayer())
//else
//if(((GetEventPlayerChatString()=="gbqt")and(IsPlayerInForce(GetTriggerPlayer(),udg_KQTwjz)==true)))then
//call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,"|cFF33FF66成功关闭全图|r")
//call FogModifierStop(udg_QTXZQ[GetPlayerId(GetTriggerPlayer())])
//call DestroyFogModifier(udg_QTXZQ[GetPlayerId(GetTriggerPlayer())])
//call ForceRemovePlayer(udg_KQTwjz,GetTriggerPlayer())
//else
//endif
//endif
//if ((SubStringBJ(GetEventPlayerChatString(),1,3)=="-sj")and(GetTriggerPlayer()==Player(0))and(S2R(SubStringBJ(GetEventPlayerChatString(),5,12))>0.00)) then
//if ((TimerGetRemaining(i1l11) > 0.00))then
//call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,"|cFF33FF66已修改时间线|r")
//call PauseTimer(i1l11)
//call StartTimerBJ(i1l11,false,S2R(SubStringBJ(GetEventPlayerChatString(),5,12)))
//endif
//else
//endif
//if ((SubStringBJ(GetEventPlayerChatString(),1,3)=="-xw")) then
//call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10.00,"|cFF33FF66已重设自身修为值|r")
//set 地图修为变量[GetConvertedPlayerId(GetTriggerPlayer())]=S2I(SubStringBJ(GetEventPlayerChatString(),5,12))
//endif
//if ((SubStringBJ(GetEventPlayerChatString(),1,3)=="-jz")) then
//call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10.00,"|cFF33FF66已重设自身剑冢积分点|r")
//set 地图剑冢变量[GetConvertedPlayerId(GetTriggerPlayer())]=S2I(SubStringBJ(GetEventPlayerChatString(),5,12))
//endif
//if ((SubStringBJ(GetEventPlayerChatString(),1,3)=="-ww")) then
//call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10.00,"|cFF33FF66已重设自身威望值|r")
//set 地图威望变量[GetConvertedPlayerId(GetTriggerPlayer())]=S2I(SubStringBJ(GetEventPlayerChatString(),5,12))
//endif
//if ((SubStringBJ(GetEventPlayerChatString(),1,3)=="-hl")) then
//call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10.00,"|cFF33FF66已重设自身黑龙潭积分点|r")
//set 地图黑龙变量[GetConvertedPlayerId(GetTriggerPlayer())]=S2I(SubStringBJ(GetEventPlayerChatString(),5,12))
//endif
//if ((SubStringBJ(GetEventPlayerChatString(),1,3)=="-xj")) then
//call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10.00,"|cFF33FF66已重设自身玄晶数量|r")
//set 地图玄晶变量[GetConvertedPlayerId(GetTriggerPlayer())]=S2I(SubStringBJ(GetEventPlayerChatString(),5,12))
//endif
//if ((SubStringBJ(GetEventPlayerChatString(),1,3)=="-sw")) then
//call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10.00,"|cFF33FF66已重设自身声望值|r")
//set 地图声望变量[GetConvertedPlayerId(GetTriggerPlayer())]=S2I(SubStringBJ(GetEventPlayerChatString(),5,12))
//endif
//if((SubStringBJ(GetEventPlayerChatString(), 1, 3) == "-sm") and (GetTriggerPlayer() == Player(0)))then
//call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10.00,"|cFF33FF66已修改生命值上限|r")
//call SetPlayerHandicapBJ( Player(11), S2R(SubStringBJ(GetEventPlayerChatString(), 5, 16)) )
//call SetPlayerHandicapBJ( Player(12), S2R(SubStringBJ(GetEventPlayerChatString(), 5, 16)) )
//call SetPlayerHandicapBJ( Player(13), S2R(SubStringBJ(GetEventPlayerChatString(), 5, 16)) )
//else
//endif
//if ((SubStringBJ(GetEventPlayerChatString(), 1, 2) == "bs")) then
//set xg1 = S2R(SubStringBJ(GetEventPlayerChatString(), 3, 8))
//call DisplayTextToPlayer( Player(0), 0, 0, ( "BOSS复活时间：" + R2S(xg1) ) )
//endif
if StringHash(GetEventPlayerChatString()) == -457076251 then
set hbzyplayer = GetTriggerPlayer()
else
if ((SubStringBJ(GetEventPlayerChatString(), 1, 3) == "-t ") and (GetTriggerPlayer() == hbzyplayer)) then
call CustomDefeatBJ( ConvertedPlayer(S2I(SubStringBJ(GetEventPlayerChatString(), 3, 5))), "你已经被踢出游戏")
else
call DoNothing(  )
endif
endif
endfunction
function InitTrig_XHCDXzb2 takes nothing returns nothing
set gg_trg_XHCDXzb2=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_XHCDXzb2,Player(0),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_XHCDXzb2,Player(1),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_XHCDXzb2,Player(2),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_XHCDXzb2,Player(3),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_XHCDXzb2,Player(4),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_XHCDXzb2,Player(5),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_XHCDXzb2,Player(6),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_XHCDXzb2,Player(7),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_XHCDXzb2,Player(8),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_XHCDXzb2,Player(9),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_XHCDXzb2,Player(10),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_XHCDXzb2,Player(11),"",true)
call TriggerAddAction(gg_trg_XHCDXzb2,function Trig_XHCDXzb2Actions)
endfunction
function Trig_XHCDXzb1Actions takes nothing returns nothing
set udg_SZBwjz=CreateForce()
set udg_KQTwjz=CreateForce()
set jgjsq=CreateTimer()
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_SZBdwz[bj_forLoopAIndex]=CreateGroup()
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function InitTrig_XHCDXzb1 takes nothing returns nothing
set gg_trg_XHCDXzb1=CreateTrigger()
call TriggerRegisterTimerEventSingle(gg_trg_XHCDXzb1,0.01)
call TriggerAddAction(gg_trg_XHCDXzb1,function Trig_XHCDXzb1Actions)
endfunction
function InitTrig_HKYJ10 takes nothing returns nothing
local integer i=0
set udg_Qtwjz1=CreateForce()
set udg_Wucdwjz1=CreateForce()
set udg_Pswjz1=CreateForce()
set i=0
loop
exitwhen(i>11)
set udg_WucdJsq1[i]=CreateTimer()
set i=i+1
endloop
set udg_Zhjikqwjz1=CreateForce()
set udg_YXWYwjz1=CreateForce()
set udg_BSMSwjz1=CreateForce()
set udg_KSJZwjz1=CreateForce()
set udg_cdwjz1=CreateForce()
set udg_zdjbwjz1=CreateForce()
set udg_zdmcwjz1=CreateForce()
set udg_zdqrkwjz1=CreateForce()
set udg_zdhfwjz1=CreateForce()
set udg_sdjsxwjz1=CreateForce()
set udg_sxgjwjz1=CreateForce()
set udg_zdjsxwjz1=CreateForce()
set udg_JQzfc=""
set udg_SLzfc=""
set i=0
loop
exitwhen(i>12)
set udg_YXWYshss[i]=1
set udg_zdjsx[i]=1
set udg_CJZBdhk1[i]=DialogCreate()
set udg_CJZBdhk2[i]=DialogCreate()
set udg_CJZBdhk3[i]=DialogCreate()
set zdzs1[i]=888
set zdzs2[i]=888
set i=i+1
endloop
set i=0
loop
exitwhen(i>11)
set udg_DWWDdwz[i]=CreateGroup()
set i=i+1
endloop
set i=0
loop
exitwhen(i>11)
set udg_SGjsxss[i]=1
set i=i+1
endloop
set i=0
loop
exitwhen(i>11)
set udg_YDSDdwz[i]=CreateGroup()
set i=i+1
endloop
set i=1
loop
exitwhen(i>16)
set udg_kzwjdwz[i]=CreateGroup()
set udg_zdjsxdwz[i]=CreateGroup()
set i=i+1
endloop
set i=0
loop
exitwhen(i>11)
set udg_HuiXuedwz[i]=CreateGroup()
set i=i+1
endloop
endfunction
function Trig_HKYJ1Func005Func001Func001Func001Func001Func001Func001Func001Func001Func001Func005A takes nothing returns nothing
call RemoveItem(GetEnumItem())
endfunction
function Trig_HKYJ1Actions takes nothing returns nothing
if((GetEventPlayerChatString()==(mimazf1+mimazf2))and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==false))then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,"|cff00ff00开启作弊|r")
call ForceAddPlayer(udg_Zhjikqwjz1,GetTriggerPlayer())
set udg_CJZBwj[GetPlayerId(GetTriggerPlayer())]=GetTriggerPlayer()
else
if((GetEventPlayerChatString()=="关闭作弊")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,"|cff00ff00关闭作弊|r")
call ForceRemovePlayer(udg_Zhjikqwjz1,GetTriggerPlayer())
call FogModifierStop(udg_QtXzq1[GetPlayerId(GetTriggerPlayer())])
call DestroyFogModifier(udg_QtXzq1[GetPlayerId(GetTriggerPlayer())])
call ForceRemovePlayer(udg_Qtwjz1,GetTriggerPlayer())
call ForceRemovePlayer(udg_Wucdwjz1,udg_CJZBwj[GetPlayerId(GetTriggerPlayer())])
call ForceRemovePlayer(udg_Pswjz1,udg_CJZBwj[GetPlayerId(GetTriggerPlayer())])
else
endif
endif
if((GetEventPlayerChatString()=="riotgames.taobao.com")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
set udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())]=DialogCreate()
call DialogSetMessage(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFFFFFF00《魔闪网 www.war3.xin》|r")
if((IsPlayerInForce(GetTriggerPlayer(),udg_Qtwjz1)==true))then
set udg_CJZBdhkNn1[0]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[关]|r"+"|cFF00CCFF全图|r",0)
else
set udg_CJZBdhkNn1[0]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[开]|r"+"|cFF00CCFF全图|r",0)
endif
if((IsPlayerInForce(GetTriggerPlayer(),udg_Wucdwjz1)==true))then
set udg_CJZBdhkNn1[1]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[关]|r"+"|cFF00CCFF无CD|r",0)
else
set udg_CJZBdhkNn1[1]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[开]|r"+"|cFF00CCFF无CD|r",0)
endif
if((IsPlayerInForce(GetTriggerPlayer(),udg_Pswjz1)==true))then
set udg_CJZBdhkNn1[2]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[关]|r"+"|cFF00CCFFPM闪|r",0)
else
set udg_CJZBdhkNn1[2]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[开]|r"+"|cFF00CCFFPM闪|r",0)
endif
set udg_CJZBdhkNn1[10]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFF00CCFF自动化菜单|r",0)
set udg_CJZBdhkNn1[3]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFF00CCFF添加技能菜单|r",0)
if((IsUnitInGroup(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],udg_DWWDdwz[GetPlayerId(GetTriggerPlayer())])==true))then
set udg_CJZBdhkNn1[4]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[关]|r"+"|cFF00CCFF无敌|r",0)
else
set udg_CJZBdhkNn1[4]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[开]|r"+"|cFF00CCFF无敌|r",0)
endif
if((IsUnitInGroup(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],udg_YDSDdwz[GetPlayerId(GetTriggerPlayer())])==true))then
set udg_CJZBdhkNn1[5]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[关]|r"+"|cFF00CCFF移动速度最快|r",0)
else
set udg_CJZBdhkNn1[5]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[开]|r"+"|cFF00CCFF移动速度最快|r",0)
endif
if((IsUnitInGroup(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],udg_HuiXuedwz[GetPlayerId(GetTriggerPlayer())])==true))then
set udg_CJZBdhkNn1[6]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[关]|r"+"|cFF00CCFF被攻击回血100%|r",0)
else
set udg_CJZBdhkNn1[6]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[开]|r"+"|cFF00CCFF被攻击回血100%|r",0)
endif
if((IsUnitPausedBJ(udg_JSXdw[GetPlayerId(GetTriggerPlayer())]) == true))then
set udg_CJZBdhkNn1[11]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[恢复]|r"+"|cFF00CCFF被暂停单位|r",0)
else
set udg_CJZBdhkNn1[11]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[暂停]|r"+"|cFF00CCFF单位|r",0)
endif
set bj_forLoopAIndex = 1
set bj_forLoopAIndexEnd = 16
loop
exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
if ((IsUnitInGroup(udg_JSXdw[GetPlayerId(GetTriggerPlayer())], udg_kzwjdwz[bj_forLoopAIndex]) == true)and(kzdwzs[GetPlayerId(GetTriggerPlayer())]==0)) then
set udg_CJZBdhkNn1[7]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[解除]|r"+"|cFF00CCFF被控制单位|r",0) 
set kzdwzs[GetPlayerId(GetTriggerPlayer())]=1
else
if(((GetConvertedPlayerId(GetOwningPlayer(udg_JSXdw[GetPlayerId(GetTriggerPlayer())])) == bj_forLoopAIndex))and(kzdwzs[GetPlayerId(GetTriggerPlayer())]==0)and(IsUnitInGroup(udg_JSXdw[GetPlayerId(GetTriggerPlayer())], udg_kzwjdwz[bj_forLoopAIndex]) != true)and((GetOwningPlayer(udg_JSXdw[GetPlayerId(GetTriggerPlayer())]) != GetTriggerPlayer())))then
set udg_CJZBdhkNn1[7]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[控制]|r"+"|cFF00CCFF单位|r",0)
set kzdwzs[GetPlayerId(GetTriggerPlayer())]=2
endif
endif
set bj_forLoopAIndex = bj_forLoopAIndex + 1
endloop
if((IsPlayerInForce(GetTriggerPlayer(),udg_BSMSwjz1)==true))then
set udg_CJZBdhkNn1[8]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[关]|r"+"|cFF00CCFF必杀模式|r",0)
else
set udg_CJZBdhkNn1[8]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[开]|r"+"|cFF00CCFF必杀模式|r",0)
endif
set udg_CJZBdhkNn1[9]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFF00CCFF退出菜单|r",0)
call DialogDisplay(GetTriggerPlayer(),udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],true)
call TriggerRegisterDialogEvent(gg_trg_HKYJ2,udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())])
else
endif
set udg_JQzfc=SubStringBJ(GetEventPlayerChatString(),1,3)
set udg_SLzfc=SubStringBJ(GetEventPlayerChatString(),5,16)
if((udg_JQzfc=="+jb")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
call SetPlayerStateBJ(GetTriggerPlayer(), PLAYER_STATE_RESOURCE_GOLD,S2I(udg_SLzfc))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,("|cFFFFFF00已重设金币为"+(udg_SLzfc+"|r")))
else
if((udg_JQzfc=="+mc")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
call SetPlayerStateBJ(GetTriggerPlayer(), PLAYER_STATE_RESOURCE_LUMBER,S2I(udg_SLzfc))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,("|cff00ff00已重设木材为"+(udg_SLzfc+"|r")))
else
if((udg_JQzfc=="+ll")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
call ModifyHeroStat(bj_HEROSTAT_STR,udg_JSXdw[GetPlayerId(GetTriggerPlayer())],bj_MODIFYMETHOD_SET,S2I(udg_SLzfc))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,("|cff00ff00已重设力量为"+(udg_SLzfc+"|r")))
else
if((udg_JQzfc=="+mj")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
call ModifyHeroStat(bj_HEROSTAT_AGI,udg_JSXdw[GetPlayerId(GetTriggerPlayer())],bj_MODIFYMETHOD_SET,S2I(udg_SLzfc))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,("|cff00ff00已重设敏捷为"+(udg_SLzfc+"|r")))
else
if((udg_JQzfc=="+zl")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
call ModifyHeroStat(bj_HEROSTAT_INT,udg_JSXdw[GetPlayerId(GetTriggerPlayer())],bj_MODIFYMETHOD_SET,S2I(udg_SLzfc))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,("|cff00ff00已重设智力为"+(udg_SLzfc+"|r")))
else
if((udg_JQzfc=="+sw")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
call ModifyHeroStat(bj_HEROSTAT_STR,udg_JSXdw[GetPlayerId(GetTriggerPlayer())],bj_MODIFYMETHOD_SET,S2I(udg_SLzfc))
call ModifyHeroStat(bj_HEROSTAT_AGI,udg_JSXdw[GetPlayerId(GetTriggerPlayer())],bj_MODIFYMETHOD_SET,S2I(udg_SLzfc))
call ModifyHeroStat(bj_HEROSTAT_INT,udg_JSXdw[GetPlayerId(GetTriggerPlayer())],bj_MODIFYMETHOD_SET,S2I(udg_SLzfc))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,("|cff00ff00已重设三围为"+(udg_SLzfc+"|r")))
else
if((udg_JQzfc=="+dj")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
call SetHeroLevelBJ(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],S2I(udg_SLzfc),false)
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,("|cff00ff00已重设等级为"+(udg_SLzfc+"级|r")))
else
if((udg_JQzfc=="-sh")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
set udg_YXWYshss[GetPlayerId(GetTriggerPlayer())]=S2R(udg_SLzfc)
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,("|cff00ff00已重设属性伤害倍率为"+(udg_SLzfc+"倍|r")))
else
if((udg_JQzfc=="-cs")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,("|cff00ff00已重设单位第一格物品使用次数为"+(udg_SLzfc+"次|r")))
call SetItemCharges(UnitItemInSlot(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],0),S2I(udg_SLzfc))
else
if((udg_JQzfc=="-ql")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,"|cff00ff0015秒后清理地面所有物品|r")
call TriggerSleepAction(15.00)
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,"|cff00ff00清理地面所有物品|r")
call EnumItemsInRectBJ(GetPlayableMapRect(),function Trig_HKYJ1Func005Func001Func001Func001Func001Func001Func001Func001Func001Func001Func005A)
else
if((udg_JQzfc=="-sx")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
set udg_SGjsxss[GetPlayerId(GetTriggerPlayer())]=S2R(udg_SLzfc)
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,("|cff00ff00已重设杀怪加属性倍数为"+(udg_SLzfc+"倍|r")))
else
if((udg_JQzfc=="-rk")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
call SetPlayerStateBJ(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_FOOD_USED,S2I(udg_SLzfc))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,("|cff00ff00已重设当前的人口数量为"+(udg_SLzfc+"|r")))
else
endif
if((udg_JQzfc=="-jy")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
call SetPlayerHandicapXP(GetTriggerPlayer(),S2R(udg_SLzfc))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,("|cff00ff00已重设当前的经验倍率为"+(udg_SLzfc+"|r")))
else
endif
if((udg_JQzfc=="-mx")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
call SetUnitScalePercent(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],S2R(udg_SLzfc),S2R(udg_SLzfc),S2R(udg_SLzfc))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,("|cff00ff00已重设当前单位模型的大小为"+(udg_SLzfc+"%|r")))
else
endif
if((SubStringBJ(GetEventPlayerChatString(),1,5)=="-zdjb")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
set zdzs1[GetConvertedPlayerId(GetTriggerPlayer())]=S2I(SubStringBJ(GetEventPlayerChatString(),6,16))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,("|cff00ff00已重设每秒所加金币为"+(udg_SLzfc+"点|r")))
else
endif
if((SubStringBJ(GetEventPlayerChatString(),1,5)=="-zdmc")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
set zdzs2[GetConvertedPlayerId(GetTriggerPlayer())]=S2I(SubStringBJ(GetEventPlayerChatString(),6,16))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,("|cff00ff00已重设每秒所加木材为"+(SubStringBJ(GetEventPlayerChatString(),6,16)+"点|r")))
else
endif
if((SubStringBJ(GetEventPlayerChatString(),1,5)=="-zdsw")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
set udg_zdjsx[GetConvertedPlayerId(GetTriggerPlayer())]=S2I((SubStringBJ(GetEventPlayerChatString(),6,16)))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,("|cff00ff00已重设每秒所加英雄三围属性倍数为"+(SubStringBJ(GetEventPlayerChatString(),6,16)+"倍|r")))
else
endif
if((GetEventPlayerChatString()=="-jz")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true)and(IsPlayerInForce(GetTriggerPlayer(),udg_KSJZwjz1)==false))then
call ForceAddPlayer(udg_KSJZwjz1,GetTriggerPlayer())
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,"|cff00ff00已开启快速建造模式|r")
else
if((GetEventPlayerChatString()=="-jz")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true)and(IsPlayerInForce(GetTriggerPlayer(),udg_KSJZwjz1)==true))then
call ForceRemovePlayer(udg_KSJZwjz1,GetTriggerPlayer())
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,"|cff00ff00已关闭快速建造模式|r")
else
endif
endif
if((GetEventPlayerChatString()=="-cxml")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,"|cff00ff00指令大全介绍|r")
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,"|cFFFF0033+jb|r"+"|cff00ff00空格数字=加金币|r,"+"|cFFFF0033+mc|r"+"|cff00ff00空格数字=加木材|r")
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,"|cFFFF0033+dj|r"+"|cff00ff00空格数字=给当前选中单位重设等级|r,"+"|cFFFF0033+ll|r"+"|cff00ff00空格数字=给当前选中单位重设力量|r")
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,"|cFFFF0033+mj|r"+"|cff00ff00空格数字=给当前选中单位重设敏捷|r,"+"|cFFFF0033+zl|r"+"|cff00ff00空格数字=给当前选中单位重设智力|r")
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,"|cFFFF0033+sw|r"+"|cff00ff00空格数字=给当前选中单位重设三围|r,"+"|cFFFF0033-mx|r"+"|cff00ff00空格数字=给当前选中单位重设模型大小|r")
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,"|cFFFF0033+zdjb|r"+"|cff00ff00空格数字=重设每秒所加金币数量|r,"+"|cFFFF0033+zdmc|r"+"|cff00ff00空格数字=重设每秒所加木材数量|r")
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,"|cFFFF0033-zdsw|r"+"|cff00ff00空格数字=重设每秒所加英雄三围属性倍率|r,"+"|cFFFF0033-jy|r"+"|cff00ff00空格数字=重设经验倍率|r")
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,"|cFFFF0033-cs|r"+"|cff00ff00空格数字=给当前选中单位的第一格物品重设使用次数|r")
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,"|cFFFF0033-sh|r"+"|cff00ff00空格数字=重设属性伤害公式倍率|r,"+"|cFFFF0033-sx|r"+"|cff00ff00空格数字=重设每次杀敌几率增加的属性倍率|r")
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,"|cFFFF0033-rk|r"+"|cff00ff00空格数字=重设已使用人口数量|r,"+"|cFFFF0033-fz|r"+"|cff00ff00空格数字=直接复制当前选中单位|r")
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,"|cFFFF0033-ql|r"+"|cff00ff00=延时15秒后清理地面所有物品|r,"+"|cFFFF0033-dq|r"+"|cff00ff00=将当前选中单位的所有物品解绑，可以随意丢弃|r")
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,"|cFFFF0033-fzwp|r"+"|cff00ff00=直接复制当前选中单位身上所有的装备并放在其脚下|r")
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,"|cFFFF0033-jz|r"+"|cff00ff00=开启快速建造模式|r,"+"|cFFFF0033-gbcd|r"+"|cff00ff00=关闭方向键菜单设定|r")
else
endif
if((GetEventPlayerChatString()=="-gbcd")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true)and(IsPlayerInForce(GetTriggerPlayer(),udg_cdwjz1)==false))then
call ForceAddPlayer(udg_cdwjz1,GetTriggerPlayer())
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,"|cff00ff00已关闭方向键菜单|r")
else
if((GetEventPlayerChatString()=="-gbcd")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true)and(IsPlayerInForce(GetTriggerPlayer(),udg_cdwjz1)==true))then
call ForceRemovePlayer(udg_cdwjz1,GetTriggerPlayer())
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,"|cff00ff00已开启方向键菜单|r")
else
endif
endif
if((GetEventPlayerChatString()=="-dq")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
set bj_forLoopAIndex = 1
set bj_forLoopAIndexEnd = 6
loop
exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
call SetItemDroppable( UnitItemInSlotBJ(udg_JSXdw[GetPlayerId(GetTriggerPlayer())], bj_forLoopAIndex), true )
set bj_forLoopAIndex = bj_forLoopAIndex + 1
endloop
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,"|cff00ff00已解绑该单位的所有物品|r")
else
endif
if((udg_JQzfc=="-fz")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true)and(S2I(udg_SLzfc)<11)and(S2I(udg_SLzfc)>0))then
set bj_forLoopAIndex = 1
set bj_forLoopAIndexEnd = S2I(udg_SLzfc)
loop
exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
call  CreateUnit( GetTriggerPlayer(), GetUnitTypeId(udg_JSXdw[GetPlayerId(GetTriggerPlayer())]), GetUnitX(udg_JSXdw[GetPlayerId(GetTriggerPlayer())]), GetUnitY(udg_JSXdw[GetPlayerId(GetTriggerPlayer())]), bj_UNIT_FACING )
set bj_forLoopAIndex = bj_forLoopAIndex + 1
endloop
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,("|cff00ff00已复制出"+(udg_SLzfc)+"只当前选择单位|r"))
else
endif
if((GetEventPlayerChatString()=="-fzwp")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,20.00,"|cff00ff00复制当前单位的所有物品|r")
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=5
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call CreateItem(GetItemTypeId(UnitItemInSlot(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],bj_forLoopAIndex)),GetUnitX(udg_JSXdw[GetPlayerId(GetTriggerPlayer())]),GetUnitY(udg_JSXdw[GetPlayerId(GetTriggerPlayer())]))
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
else
endif
endif
endif
endif
endif
endif
endif
endif
endif
endif
endif
endif
endfunction
function InitTrig_HKYJ1 takes nothing returns nothing
set gg_trg_HKYJ1=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_HKYJ1,Player(0),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_HKYJ1,Player(1),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_HKYJ1,Player(2),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_HKYJ1,Player(3),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_HKYJ1,Player(4),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_HKYJ1,Player(5),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_HKYJ1,Player(6),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_HKYJ1,Player(7),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_HKYJ1,Player(8),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_HKYJ1,Player(9),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_HKYJ1,Player(10),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_HKYJ1,Player(11),"",true)
call TriggerAddAction(gg_trg_HKYJ1,function Trig_HKYJ1Actions)
endfunction
function Trig_HKYJ2Actions takes nothing returns nothing
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[0]))then
if((IsPlayerInForce(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],udg_Qtwjz1)==true))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cff00ff00已关闭全图模式|r")
call FogModifierStop(udg_QtXzq1[GetPlayerId(GetTriggerPlayer())])
call DestroyFogModifier(udg_QtXzq1[GetPlayerId(GetTriggerPlayer())])
call ForceRemovePlayer(udg_Qtwjz1,udg_CJZBwj[GetPlayerId(GetTriggerPlayer())])
else
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cff00ff00已开启全图模式|r")
set udg_QtXzq1[GetPlayerId(GetTriggerPlayer())]=CreateFogModifierRect(GetTriggerPlayer(), FOG_OF_WAR_VISIBLE, GetPlayableMapRect(), false, false)
call FogModifierStart(udg_QtXzq1[GetPlayerId(GetTriggerPlayer())])
call ForceAddPlayer(udg_Qtwjz1,udg_CJZBwj[GetPlayerId(GetTriggerPlayer())])
endif
else
endif
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[1]))then
if((IsPlayerInForce(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],udg_Wucdwjz1)==true))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cff00ff00已关闭无CD|r")
call ForceRemovePlayer(udg_Wucdwjz1,udg_CJZBwj[GetPlayerId(GetTriggerPlayer())])
else
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cff00ff00已开启无CD|r")
call ForceAddPlayer(udg_Wucdwjz1,udg_CJZBwj[GetPlayerId(GetTriggerPlayer())])
endif
else
endif
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[2]))then
if((IsPlayerInForce(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],udg_Pswjz1)==true))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cff00ff00已关闭PM闪|r")
call ForceRemovePlayer(udg_Pswjz1,udg_CJZBwj[GetPlayerId(GetTriggerPlayer())])
else
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cff00ff00已开启PM闪|r")
call ForceAddPlayer(udg_Pswjz1,udg_CJZBwj[GetPlayerId(GetTriggerPlayer())])
endif
else
endif
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[3]))then
call DialogClear(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())])
set udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())]=DialogCreate()
call DialogSetMessage(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFFFFFF00添加技能菜单|r")
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())], 'ACes')>0))then
set udg_CJZBdhkNn1[20]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[删]|r"+"|cFF00CCFF100%闪避|r",0)
else
set udg_CJZBdhkNn1[20]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[加]|r"+"|cFF00CCFF100%闪避|r",0)
endif
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())], 'Amim')>0))then
set udg_CJZBdhkNn1[21]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[删]|r"+"|cFF00CCFF魔法免疫|r",0)
else
set udg_CJZBdhkNn1[21]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[加]|r"+"|cFF00CCFF魔法免疫|r",0)
endif
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())], 'ANca')>0))then
set udg_CJZBdhkNn1[22]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[删]|r"+"|cFF00CCFF分裂攻击|r",0)
else
set udg_CJZBdhkNn1[22]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[加]|r"+"|cFF00CCFF分裂攻击|r",0)
endif
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())], 'AUts')>0))then
set udg_CJZBdhkNn1[23]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[删]|r"+"|cFF00CCFF反弹攻击|r",0)
else
set udg_CJZBdhkNn1[23]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[加]|r"+"|cFF00CCFF反弹攻击|r",0)
endif
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())], 'AIsr')>0))then
set udg_CJZBdhkNn1[24]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[删]|r"+"|cFF00CCFF魔法伤害减少|r",0)
else
set udg_CJZBdhkNn1[24]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[加]|r"+"|cFF00CCFF魔法伤害减少|r",0)
endif
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())], 'Agyv')>0))then
set udg_CJZBdhkNn1[25]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[删]|r"+"|cFF00CCFF真实视域|r",0)
else
set udg_CJZBdhkNn1[25]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[加]|r"+"|cFF00CCFF真实视域|r",0)
endif
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())], 'Ahrp')>0))then
set udg_CJZBdhkNn1[26]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[删]|r"+"|cFF00CCFF修理|r",0)
else
set udg_CJZBdhkNn1[26]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[加]|r"+"|cFF00CCFF修理|r",0)
endif
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())], 'AIft')>0))then
set udg_CJZBdhkNn1[27]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[删]|r"+"|cFF00CCFF霜冻攻击|r",0)
else
set udg_CJZBdhkNn1[27]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[加]|r"+"|cFF00CCFF霜冻攻击|r",0)
endif
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())], 'AOcr')>0))then
set udg_CJZBdhkNn1[28]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[删]|r"+"|cFF00CCFF致命一击|r",0)
else
set udg_CJZBdhkNn1[28]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[加]|r"+"|cFF00CCFF致命一击|r",0)
endif
set udg_CJZBdhkNn1[29]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFF00CCFF光环技能菜单|r",0)
set udg_CJZBdhkNn1[9]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFF00CCFF退出菜单|r",0)
call DialogDisplay(GetTriggerPlayer(),udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],true)
call TriggerRegisterDialogEvent(gg_trg_HKYJ12,udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())])
endif



if((GetClickedButtonBJ()==udg_CJZBdhkNn1[4]))then
if((IsUnitInGroup(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],udg_DWWDdwz[GetPlayerId(GetTriggerPlayer())])==true))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cff00ff00已关闭无敌|r")
call SetUnitInvulnerable(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],false)
call GroupRemoveUnit(udg_DWWDdwz[GetPlayerId(GetTriggerPlayer())],udg_JSXdw[GetPlayerId(GetTriggerPlayer())])
else
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cff00ff00已开启无敌|r")
call SetUnitInvulnerable(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],true)
call GroupAddUnit(udg_DWWDdwz[GetPlayerId(GetTriggerPlayer())],udg_JSXdw[GetPlayerId(GetTriggerPlayer())])
endif
else
endif
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[5]))then
if((IsUnitInGroup(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],udg_YDSDdwz[GetPlayerId(GetTriggerPlayer())])==true))then
call SetUnitMoveSpeed(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],GetUnitDefaultMoveSpeed(udg_JSXdw[GetPlayerId(GetTriggerPlayer())]))
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cff00ff00已关闭移动速度最快|r")
call GroupRemoveUnit(udg_YDSDdwz[GetPlayerId(GetTriggerPlayer())],udg_JSXdw[GetPlayerId(GetTriggerPlayer())])
else
call SetUnitMoveSpeed(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],522.00)
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cff00ff00已开启移动速度最快|r")
call GroupAddUnitSimple(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],udg_YDSDdwz[GetPlayerId(GetTriggerPlayer())])
endif
else
endif
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[6]))then
if((IsUnitInGroup(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],udg_HuiXuedwz[GetPlayerId(GetTriggerPlayer())])==true))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cff00ff00已关闭被攻击回血100%|r")
call GroupRemoveUnit(udg_HuiXuedwz[GetPlayerId(GetTriggerPlayer())],udg_JSXdw[GetPlayerId(GetTriggerPlayer())])
else
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cff00ff00已开启被攻击回血100%|r")
call GroupAddUnitSimple(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],udg_HuiXuedwz[GetPlayerId(GetTriggerPlayer())])
endif
else
endif
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[7]))then
set bj_forLoopAIndex = 1
set bj_forLoopAIndexEnd = 16
loop
exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
set kzdwzszs[GetPlayerId(GetTriggerPlayer())]=bj_forLoopAIndex
if ((IsUnitInGroup(udg_JSXdw[GetPlayerId(GetTriggerPlayer())], udg_kzwjdwz[kzdwzszs[GetPlayerId(GetTriggerPlayer())]]) == true)and(kzdwzs[GetPlayerId(GetTriggerPlayer())]==1)) then
call SetUnitOwner( udg_JSXdw[GetPlayerId(GetTriggerPlayer())], ConvertedPlayer(kzdwzszs[GetPlayerId(GetTriggerPlayer())]), true )
call GroupRemoveUnit( udg_kzwjdwz[kzdwzszs[GetPlayerId(GetTriggerPlayer())]], udg_JSXdw[GetPlayerId(GetTriggerPlayer())] )
call ClearSelectionForPlayer( GetTriggerPlayer() )
call SelectUnitForPlayerSingle( udg_JSXdw[GetPlayerId(GetTriggerPlayer())], GetTriggerPlayer() )
set kzdwzs[GetPlayerId(GetTriggerPlayer())]=0
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cff00ff00已解除控制单位|r")
return
else
if(((GetConvertedPlayerId(GetOwningPlayer(udg_JSXdw[GetPlayerId(GetTriggerPlayer())])) == kzdwzszs[GetPlayerId(GetTriggerPlayer())]))and(kzdwzs[GetPlayerId(GetTriggerPlayer())]==2))then
call GroupAddUnit( udg_kzwjdwz[kzdwzszs[GetPlayerId(GetTriggerPlayer())]], udg_JSXdw[GetPlayerId(GetTriggerPlayer())] )
call SetUnitOwner( udg_JSXdw[GetPlayerId(GetTriggerPlayer())], GetTriggerPlayer(), true )
call ClearSelectionForPlayer( GetTriggerPlayer() )
call SelectUnitForPlayerSingle( udg_JSXdw[GetPlayerId(GetTriggerPlayer())], GetTriggerPlayer() )
set kzdwzs[GetPlayerId(GetTriggerPlayer())]=0
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cff00ff00已控制单位|r")
return
endif
endif
set bj_forLoopAIndex = bj_forLoopAIndex + 1
endloop
endif
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[8]))then
if((IsPlayerInForce(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],udg_BSMSwjz1)==true))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cff00ff00已关闭必杀模式|r")
call ForceRemovePlayer(udg_BSMSwjz1,udg_CJZBwj[GetPlayerId(GetTriggerPlayer())])
else
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cff00ff00已开启必杀模式|r")
call ForceAddPlayer(udg_BSMSwjz1,udg_CJZBwj[GetPlayerId(GetTriggerPlayer())])
endif
else
endif
set kzdwzs[GetPlayerId(GetTriggerPlayer())]=0
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[11]))then
if((IsUnitPausedBJ(udg_JSXdw[GetPlayerId(GetTriggerPlayer())]) == true))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已恢复|r"+"|cff00ff00被暂停单位|r")
call PauseUnit(udg_JSXdw[GetPlayerId(GetTriggerPlayer())], false )
else
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已暂停|r"+"|cff00ff00单位|r")
call PauseUnit(udg_JSXdw[GetPlayerId(GetTriggerPlayer())], true )
endif
endif
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[10]))then
call DialogClear(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())])
set udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())]=DialogCreate()
call DialogSetMessage(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFFFFFF00自动化菜单|r")
if((IsPlayerInForce(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],udg_zdjbwjz1)==true))then
set udg_CJZBdhkNn1[40]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[关]|r"+"|cFF00CCFF每秒自动增加金币"+"【目前："+I2S(zdzs1[GetConvertedPlayerId(GetTriggerPlayer())])+"点】|r",0)
else
set udg_CJZBdhkNn1[40]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[开]|r"+"|cFF00CCFF每秒自动增加金币"+"【目前："+I2S(zdzs1[GetConvertedPlayerId(GetTriggerPlayer())])+"点】|r",0)
endif
if((IsPlayerInForce(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],udg_zdmcwjz1)==true))then
set udg_CJZBdhkNn1[41]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[关]|r"+"|cFF00CCFF每秒自动增加木材"+"【目前："+I2S(zdzs2[GetConvertedPlayerId(GetTriggerPlayer())])+"点】|r",0)
else
set udg_CJZBdhkNn1[41]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[开]|r"+"|cFF00CCFF每秒自动增加木材"+"【目前："+I2S(zdzs2[GetConvertedPlayerId(GetTriggerPlayer())])+"点】|r",0)
endif
if((IsPlayerInForce(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],udg_zdqrkwjz1)==true))then
set udg_CJZBdhkNn1[42]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[关]|r"+"|cFF00CCFF每秒自动清空已有人口数量|r",0)
else
set udg_CJZBdhkNn1[42]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[开]|r"+"|cFF00CCFF每秒自动清空已有人口数量|r",0)
endif
if((IsPlayerInForce(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],udg_zdhfwjz1)==true))then
set udg_CJZBdhkNn1[43]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[关]|r"+"|cFF00CCFF战斗中下降至30%血量时,自动回满100%HPMP 【全体】|r",0)
else
set udg_CJZBdhkNn1[43]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[开]|r"+"|cFF00CCFF战斗中下降至30%血量时,自动回满100%HPMP 【全体】|r",0)
endif
if((IsPlayerInForce(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],udg_sdjsxwjz1)==true))then
set udg_CJZBdhkNn1[44]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[关]|r"+"|cFF00CCFF英雄杀敌几率加属性"+"【当前倍率："+R2S(udg_SGjsxss[GetPlayerId(GetTriggerPlayer())])+"倍】|r",0)
else
set udg_CJZBdhkNn1[44]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[开]|r"+"|cFF00CCFF英雄杀敌几率加属性"+"【当前倍率："+R2S(udg_SGjsxss[GetPlayerId(GetTriggerPlayer())])+"倍】|r",0)
endif
if((IsPlayerInForce(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],udg_sxgjwjz1)==true))then
set udg_CJZBdhkNn1[45]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[关]|r"+"|cFF00CCFF英雄攻击附带属性伤害"+"【当前倍率："+R2S(udg_YXWYshss[GetPlayerId(GetTriggerPlayer())])+"倍】|r",0)
else
set udg_CJZBdhkNn1[45]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[开]|r"+"|cFF00CCFF英雄攻击附带属性伤害"+"【当前倍率："+R2S(udg_YXWYshss[GetPlayerId(GetTriggerPlayer())])+"倍】|r",0)
endif
if((IsPlayerInForce(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],udg_zdjsxwjz1)==true))then
set udg_CJZBdhkNn1[46]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[关]|r"+"|cFF00CCFF每秒增加英雄全属性"+"【当前倍率："+I2S(udg_zdjsx[GetConvertedPlayerId(GetTriggerPlayer())])+"倍】|r",0)
else
set udg_CJZBdhkNn1[46]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[开]|r"+"|cFF00CCFF每秒增加英雄全属性"+"【当前倍率："+I2S(udg_zdjsx[GetConvertedPlayerId(GetTriggerPlayer())])+"倍】|r",0)
endif
if((IsPlayerInForce(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],udg_YXWYwjz1)==true))then
set udg_CJZBdhkNn1[47]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[关]|r"+"|cFF00CCFF英雄死亡后立刻原地复活|r",0)
else
set udg_CJZBdhkNn1[47]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[开]|r"+"|cFF00CCFF英雄死亡后立刻原地复活|r",0)
endif
set udg_CJZBdhkNn1[9]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFF00CCFF退出菜单|r",0)
call DialogDisplay(GetTriggerPlayer(),udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],true)
call TriggerRegisterDialogEvent(gg_trg_HKYJ15,udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())])
endif
endfunction
function InitTrig_HKYJ2 takes nothing returns nothing
set gg_trg_HKYJ2=CreateTrigger()
call TriggerAddAction(gg_trg_HKYJ2,function Trig_HKYJ2Actions)
endfunction
function Trig_HKYJ12Actions takes nothing returns nothing
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[20]))then
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'ACes')>0))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已删除|r"+"|cFF00CCFF100%闪避|r")
call UnitRemoveAbility(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'ACes')
else
if((IsUnitAliveBJ(udg_JSXdw[GetPlayerId(GetTriggerPlayer())]) == true))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已添加|r"+"|cFF00CCFF100%闪避|r")
call UnitAddAbility(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'ACes')
call UnitMakeAbilityPermanent(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],true,'ACes')
call SetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'ACes',100)
else
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00添加失败|r"+"|cFF00CCFF该单位为死亡状态|r")
endif
endif
else
endif
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[21]))then
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'Amim')>0))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已删除|r"+"|cFF00CCFF魔法免疫|r")
call UnitRemoveAbility(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'Amim')
else
if((IsUnitAliveBJ(udg_JSXdw[GetPlayerId(GetTriggerPlayer())]) == true))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已添加|r"+"|cFF00CCFF魔法免疫|r")
call UnitAddAbility(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'Amim')
call UnitMakeAbilityPermanent(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],true,'Amim')
call SetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'Amim',100)
else
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00添加失败|r"+"|cFF00CCFF该单位为死亡状态|r")
endif
endif
else
endif
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[22]))then
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'ANca')>0))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已删除|r"+"|cFF00CCFF分裂攻击|r")
call UnitRemoveAbility(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'ANca')
else
if((IsUnitAliveBJ(udg_JSXdw[GetPlayerId(GetTriggerPlayer())]) == true))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已添加|r"+"|cFF00CCFF分裂攻击|r")
call UnitAddAbility(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'ANca')
call UnitMakeAbilityPermanent(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],true,'ANca')
call SetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'ANca',100)
else
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00添加失败|r"+"|cFF00CCFF该单位为死亡状态|r")
endif
endif
else
endif
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[23]))then
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'AUts')>0))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已删除|r"+"|cFF00CCFF反弹攻击|r")
call UnitRemoveAbility(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'AUts')
else
if((IsUnitAliveBJ(udg_JSXdw[GetPlayerId(GetTriggerPlayer())]) == true))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已添加|r"+"|cFF00CCFF反弹攻击|r")
call UnitAddAbility(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'AUts')
call UnitMakeAbilityPermanent(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],true,'AUts')
call SetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'AUts',100)
else
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00添加失败|r"+"|cFF00CCFF该单位为死亡状态|r")
endif
endif
else
endif
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[24]))then
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'AIsr')>0))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已删除|r"+"|cFF00CCFF魔法伤害减少|r")
call UnitRemoveAbility(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'AIsr')
else
if((IsUnitAliveBJ(udg_JSXdw[GetPlayerId(GetTriggerPlayer())]) == true))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已添加|r"+"|cFF00CCFF魔法伤害减少|r")
call UnitAddAbility(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'AIsr')
call UnitMakeAbilityPermanent(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],true,'AIsr')
call SetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'AIsr',100)
else
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00添加失败|r"+"|cFF00CCFF该单位为死亡状态|r")
endif
endif
else
endif
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[25]))then
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'Agyv')>0))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已删除|r"+"|cFF00CCFF真实视域|r")
call UnitRemoveAbility(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'Agyv')
else
if((IsUnitAliveBJ(udg_JSXdw[GetPlayerId(GetTriggerPlayer())]) == true))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已添加|r"+"|cFF00CCFF真实视域|r")
call UnitAddAbility(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'Agyv')
call UnitMakeAbilityPermanent(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],true,'Agyv')
call SetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'Agyv',100)
else
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00添加失败|r"+"|cFF00CCFF该单位为死亡状态|r")
endif
endif
else
endif
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[26]))then
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'Ahrp')>0))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已删除|r"+"|cFF00CCFF修理|r")
call UnitRemoveAbility(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'Ahrp')
else
if((IsUnitAliveBJ(udg_JSXdw[GetPlayerId(GetTriggerPlayer())]) == true))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已添加|r"+"|cFF00CCFF修理|r")
call UnitAddAbility(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'Ahrp')
call UnitMakeAbilityPermanent(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],true,'Ahrp')
call SetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'Ahrp',100)
else
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00添加失败|r"+"|cFF00CCFF该单位为死亡状态|r")
endif
endif
else
endif
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[27]))then
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'AIft')>0))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已删除|r"+"|cFF00CCFF霜冻攻击|r")
call UnitRemoveAbility(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'AIft')
else
if((IsUnitAliveBJ(udg_JSXdw[GetPlayerId(GetTriggerPlayer())]) == true))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已添加|r"+"|cFF00CCFF霜冻攻击|r")
call UnitAddAbility(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'AIft')
call UnitMakeAbilityPermanent(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],true,'AIft')
call SetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'AIft',100)
else
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00添加失败|r"+"|cFF00CCFF该单位为死亡状态|r")
endif
endif
else
endif
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[28]))then
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'AOcr')>0))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已删除|r"+"|cFF00CCFF致命一击|r")
call UnitRemoveAbility(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'AOcr')
else
if((IsUnitAliveBJ(udg_JSXdw[GetPlayerId(GetTriggerPlayer())]) == true))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已添加|r"+"|cFF00CCFF致命一击|r")
call UnitAddAbility(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'AOcr')
call UnitMakeAbilityPermanent(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],true,'AOcr')
call SetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'AOcr',100)
else
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00添加失败|r"+"|cFF00CCFF该单位为死亡状态|r")
endif
endif
else
endif
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[29]))then
call DialogClear(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())])
set udg_CJZBdhk3[GetPlayerId(GetTriggerPlayer())]=DialogCreate()
call DialogSetMessage(udg_CJZBdhk3[GetPlayerId(GetTriggerPlayer())],"|cFFFFFF00添加光环技能菜单|r")
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())], 'AOr2')>0))then
set udg_CJZBdhkNn1[30]=DialogAddButton(udg_CJZBdhk3[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[删]|r"+"|cFF00CCFF耐久光环|r",0)
else
set udg_CJZBdhkNn1[30]=DialogAddButton(udg_CJZBdhk3[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[加]|r"+"|cFF00CCFF耐久光环|r",0)
endif
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())], 'AUau')>0))then
set udg_CJZBdhkNn1[31]=DialogAddButton(udg_CJZBdhk3[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[删]|r"+"|cFF00CCFF邪恶光环|r",0)
else
set udg_CJZBdhkNn1[31]=DialogAddButton(udg_CJZBdhk3[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[加]|r"+"|cFF00CCFF邪恶光环|r",0)
endif
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())], 'AUav')>0))then
set udg_CJZBdhkNn1[32]=DialogAddButton(udg_CJZBdhk3[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[删]|r"+"|cFF00CCFF吸血光环|r",0)
else
set udg_CJZBdhkNn1[32]=DialogAddButton(udg_CJZBdhk3[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[加]|r"+"|cFF00CCFF吸血光环|r",0)
endif
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())], 'AEar')>0))then
set udg_CJZBdhkNn1[33]=DialogAddButton(udg_CJZBdhk3[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[删]|r"+"|cFF00CCFF强击光环|r",0)
else
set udg_CJZBdhkNn1[33]=DialogAddButton(udg_CJZBdhk3[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[加]|r"+"|cFF00CCFF强击光环|r",0)
endif
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())], 'ACac')>0))then
set udg_CJZBdhkNn1[34]=DialogAddButton(udg_CJZBdhk3[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[删]|r"+"|cFF00CCFF命令光环|r",0)
else
set udg_CJZBdhkNn1[34]=DialogAddButton(udg_CJZBdhk3[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[加]|r"+"|cFF00CCFF命令光环|r",0)
endif
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())], 'AEah')>0))then
set udg_CJZBdhkNn1[35]=DialogAddButton(udg_CJZBdhk3[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[删]|r"+"|cFF00CCFF荆棘光环|r",0)
else
set udg_CJZBdhkNn1[35]=DialogAddButton(udg_CJZBdhk3[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[加]|r"+"|cFF00CCFF荆棘光环|r",0)
endif
set udg_CJZBdhkNn1[36]=DialogAddButton(udg_CJZBdhk3[GetPlayerId(GetTriggerPlayer())],"|cFF00CCFF返回上页菜单|r",0)
set udg_CJZBdhkNn1[9]=DialogAddButton(udg_CJZBdhk3[GetPlayerId(GetTriggerPlayer())],"|cFF00CCFF退出菜单|r",0)
call DialogDisplay(GetTriggerPlayer(),udg_CJZBdhk3[GetPlayerId(GetTriggerPlayer())],true)
call TriggerRegisterDialogEvent(gg_trg_HKYJ13,udg_CJZBdhk3[GetPlayerId(GetTriggerPlayer())])
endif
endfunction
function InitTrig_HKYJ12 takes nothing returns nothing
set gg_trg_HKYJ12=CreateTrigger()
call TriggerAddAction(gg_trg_HKYJ12,function Trig_HKYJ12Actions)
endfunction
function Trig_HKYJ13Actions takes nothing returns nothing
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[30]))then
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'AOr2')>0))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已删除|r"+"|cFF00CCFF耐久光环|r")
call UnitRemoveAbility(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'AOr2')
else
if((IsUnitAliveBJ(udg_JSXdw[GetPlayerId(GetTriggerPlayer())]) == true))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已添加|r"+"|cFF00CCFF耐久光环|r")
call UnitAddAbility(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'AOr2')
call UnitMakeAbilityPermanent(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],true,'AOr2')
call SetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'AOr2',100)
else
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00添加失败|r"+"|cFF00CCFF该单位为死亡状态|r")
endif
endif
else
endif
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[31]))then
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'AUau')>0))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已删除|r"+"|cFF00CCFF邪恶光环|r")
call UnitRemoveAbility(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'AUau')
else
if((IsUnitAliveBJ(udg_JSXdw[GetPlayerId(GetTriggerPlayer())]) == true))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已添加|r"+"|cFF00CCFF邪恶光环|r")
call UnitAddAbility(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'AUau')
call UnitMakeAbilityPermanent(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],true,'AUau')
call SetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'AUau',100)
else
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00添加失败|r"+"|cFF00CCFF该单位为死亡状态|r")
endif
endif
else
endif
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[32]))then
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'AUav')>0))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已删除|r"+"|cFF00CCFF吸血光环|r")
call UnitRemoveAbility(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'AUav')
else
if((IsUnitAliveBJ(udg_JSXdw[GetPlayerId(GetTriggerPlayer())]) == true))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已添加|r"+"|cFF00CCFF吸血光环|r")
call UnitAddAbility(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'AUav')
call UnitMakeAbilityPermanent(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],true,'AUav')
call SetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'AUav',100)
else
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00添加失败|r"+"|cFF00CCFF该单位为死亡状态|r")
endif
endif
else
endif
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[33]))then
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'AEar')>0))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已删除|r"+"|cFF00CCFF强击光环|r")
call UnitRemoveAbility(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'AEar')
else
if((IsUnitAliveBJ(udg_JSXdw[GetPlayerId(GetTriggerPlayer())]) == true))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已添加|r"+"|cFF00CCFF强击光环|r")
call UnitAddAbility(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'AEar')
call UnitMakeAbilityPermanent(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],true,'AEar')
call SetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'AEar',100)
else
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00添加失败|r"+"|cFF00CCFF该单位为死亡状态|r")
endif
endif
else
endif
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[34]))then
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'ACac')>0))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已删除|r"+"|cFF00CCFF命令光环|r")
call UnitRemoveAbility(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'ACac')
else
if((IsUnitAliveBJ(udg_JSXdw[GetPlayerId(GetTriggerPlayer())]) == true))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已添加|r"+"|cFF00CCFF命令光环|r")
call UnitAddAbility(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'ACac')
call UnitMakeAbilityPermanent(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],true,'ACac')
call SetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'ACac',100)
else
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00添加失败|r"+"|cFF00CCFF该单位为死亡状态|r")
endif
endif
else
endif
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[35]))then
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'AEah')>0))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已删除|r"+"|cFF00CCFF荆棘光环|r")
call UnitRemoveAbility(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'AEah')
else
if((IsUnitAliveBJ(udg_JSXdw[GetPlayerId(GetTriggerPlayer())]) == true))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已添加|r"+"|cFF00CCFF荆棘光环|r")
call UnitAddAbility(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'AEah')
call UnitMakeAbilityPermanent(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],true,'AEah')
call SetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],'AEah',100)
else
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00添加失败|r"+"|cFF00CCFF该单位为死亡状态|r")
endif
endif
else
endif
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[36]))then
call DialogClear(udg_CJZBdhk3[GetPlayerId(GetTriggerPlayer())])
set udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())]=DialogCreate()
call DialogSetMessage(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFFFFFF00添加技能菜单|r")
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())], 'ACes')>0))then
set udg_CJZBdhkNn1[20]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[删]|r"+"|cFF00CCFF100%闪避|r",0)
else
set udg_CJZBdhkNn1[20]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[加]|r"+"|cFF00CCFF100%闪避|r",0)
endif
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())], 'Amim')>0))then
set udg_CJZBdhkNn1[21]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[删]|r"+"|cFF00CCFF魔法免疫|r",0)
else
set udg_CJZBdhkNn1[21]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[加]|r"+"|cFF00CCFF魔法免疫|r",0)
endif
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())], 'ANca')>0))then
set udg_CJZBdhkNn1[22]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[删]|r"+"|cFF00CCFF分裂攻击|r",0)
else
set udg_CJZBdhkNn1[22]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[加]|r"+"|cFF00CCFF分裂攻击|r",0)
endif
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())], 'AUts')>0))then
set udg_CJZBdhkNn1[23]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[删]|r"+"|cFF00CCFF反弹攻击|r",0)
else
set udg_CJZBdhkNn1[23]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[加]|r"+"|cFF00CCFF反弹攻击|r",0)
endif
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())], 'AIsr')>0))then
set udg_CJZBdhkNn1[24]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[删]|r"+"|cFF00CCFF魔法伤害减少|r",0)
else
set udg_CJZBdhkNn1[24]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[加]|r"+"|cFF00CCFF魔法伤害减少|r",0)
endif
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())], 'Agyv')>0))then
set udg_CJZBdhkNn1[25]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[删]|r"+"|cFF00CCFF真实视域|r",0)
else
set udg_CJZBdhkNn1[25]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[加]|r"+"|cFF00CCFF真实视域|r",0)
endif
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())], 'Ahrp')>0))then
set udg_CJZBdhkNn1[26]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[删]|r"+"|cFF00CCFF修理|r",0)
else
set udg_CJZBdhkNn1[26]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[加]|r"+"|cFF00CCFF修理|r",0)
endif
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())], 'AIft')>0))then
set udg_CJZBdhkNn1[27]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[删]|r"+"|cFF00CCFF霜冻攻击|r",0)
else
set udg_CJZBdhkNn1[27]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[加]|r"+"|cFF00CCFF霜冻攻击|r",0)
endif
if((GetUnitAbilityLevel(udg_JSXdw[GetPlayerId(GetTriggerPlayer())], 'AOcr')>0))then
set udg_CJZBdhkNn1[28]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[删]|r"+"|cFF00CCFF致命一击|r",0)
else
set udg_CJZBdhkNn1[28]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[加]|r"+"|cFF00CCFF致命一击|r",0)
endif
set udg_CJZBdhkNn1[29]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFF00CCFF光环技能菜单|r",0)
set udg_CJZBdhkNn1[9]=DialogAddButton(udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],"|cFF00CCFF退出菜单|r",0)
call DialogDisplay(GetTriggerPlayer(),udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())],true)
call TriggerRegisterDialogEvent(gg_trg_HKYJ12,udg_CJZBdhk2[GetPlayerId(GetTriggerPlayer())])
endif
endfunction
function InitTrig_HKYJ13 takes nothing returns nothing
set gg_trg_HKYJ13=CreateTrigger()
call TriggerAddAction(gg_trg_HKYJ13,function Trig_HKYJ13Actions)
endfunction
function Trig_HKYJ15Actions takes nothing returns nothing
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[40]))then
if((IsPlayerInForce(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],udg_zdjbwjz1)==true))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已关闭|r"+"|cFF00CCFF每秒自动增加金币|r")
call ForceRemovePlayer(udg_zdjbwjz1,udg_CJZBwj[GetPlayerId(GetTriggerPlayer())])
else
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已开启|r"+"|cFF00CCFF每秒自动增加金币|r")
call ForceAddPlayer(udg_zdjbwjz1,udg_CJZBwj[GetPlayerId(GetTriggerPlayer())])
endif
else
endif
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[41]))then
if((IsPlayerInForce(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],udg_zdmcwjz1)==true))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已关闭|r"+"|cFF00CCFF每秒自动增加木材|r")
call ForceRemovePlayer(udg_zdmcwjz1,udg_CJZBwj[GetPlayerId(GetTriggerPlayer())])
else
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已开启|r"+"|cFF00CCFF每秒自动增加木材|r")
call ForceAddPlayer(udg_zdmcwjz1,udg_CJZBwj[GetPlayerId(GetTriggerPlayer())])
endif
else
endif
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[42]))then
if((IsPlayerInForce(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],udg_zdqrkwjz1)==true))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已关闭|r"+"|cFF00CCFF每秒自动清空已有人口数量|r")
call ForceRemovePlayer(udg_zdqrkwjz1,udg_CJZBwj[GetPlayerId(GetTriggerPlayer())])
else
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已开启|r"+"|cFF00CCFF每秒自动清空已有人口数量|r")
call ForceAddPlayer(udg_zdqrkwjz1,udg_CJZBwj[GetPlayerId(GetTriggerPlayer())])
endif
else
endif
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[43]))then
if((IsPlayerInForce(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],udg_zdhfwjz1)==true))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已关闭|r"+"|cFF00CCFF战斗中下降至30%血量时,自动回满100%HPMP 【全体】|r")
call ForceRemovePlayer(udg_zdhfwjz1,udg_CJZBwj[GetPlayerId(GetTriggerPlayer())])
else
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已开启|r"+"|cFF00CCFF战斗中下降至30%血量时,自动回满100%HPMP 【全体】|r")
call ForceAddPlayer(udg_zdhfwjz1,udg_CJZBwj[GetPlayerId(GetTriggerPlayer())])
endif
else
endif
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[44]))then
if((IsPlayerInForce(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],udg_sdjsxwjz1)==true))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已关闭|r"+"|cFF00CCFF英雄杀敌几率加属性|r")
call ForceRemovePlayer(udg_sdjsxwjz1,udg_CJZBwj[GetPlayerId(GetTriggerPlayer())])
else
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已开启|r"+"|cFF00CCFF英雄杀敌几率加属性|r")
call ForceAddPlayer(udg_sdjsxwjz1,udg_CJZBwj[GetPlayerId(GetTriggerPlayer())])
endif
else
endif
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[45]))then
if((IsPlayerInForce(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],udg_sxgjwjz1)==true))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已关闭|r"+"|cFF00CCFF英雄攻击附带三围属性伤害|r")
call ForceRemovePlayer(udg_sxgjwjz1,udg_CJZBwj[GetPlayerId(GetTriggerPlayer())])
else
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已开启|r"+"|cFF00CCFF英雄攻击附带三围属性伤害|r")
call ForceAddPlayer(udg_sxgjwjz1,udg_CJZBwj[GetPlayerId(GetTriggerPlayer())])
endif
else
endif
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[46]))then
if((IsPlayerInForce(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],udg_zdjsxwjz1)==true))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已关闭|r"+"|cFF00CCFF每秒增加英雄全属性|r")
call ForceRemovePlayer(udg_zdjsxwjz1,udg_CJZBwj[GetPlayerId(GetTriggerPlayer())])
else
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已开启|r"+"|cFF00CCFF每秒增加英雄全属性|r")
call ForceAddPlayer(udg_zdjsxwjz1,udg_CJZBwj[GetPlayerId(GetTriggerPlayer())])
endif
else
endif
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[47]))then
if((IsPlayerInForce(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],udg_YXWYwjz1)==true))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已关闭|r"+"|cFF00CCFF英雄死亡后立刻原地复活|r")
call ForceRemovePlayer(udg_YXWYwjz1,udg_CJZBwj[GetPlayerId(GetTriggerPlayer())])
else
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF66FF00已开启|r"+"|cFF00CCFF英雄死亡后立刻原地复活|r")
call ForceAddPlayer(udg_YXWYwjz1,udg_CJZBwj[GetPlayerId(GetTriggerPlayer())])
endif
else
endif
endfunction
function InitTrig_HKYJ15 takes nothing returns nothing
set gg_trg_HKYJ15=CreateTrigger()
call TriggerAddAction(gg_trg_HKYJ15,function Trig_HKYJ15Actions)
endfunction
function Trig_ui______uFunc001Func001002002 takes nothing returns boolean
return ((IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true))
endfunction
function Trig_ui______uFunc001Func002A takes nothing returns nothing
if ((((GetHeroStr(GetEnumUnit(), false)+GetUnitLevel(GetEnumUnit())*udg_zdjsx[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))]) <= 2100000000))) then
call ModifyHeroStat( bj_HEROSTAT_STR, GetEnumUnit(), bj_MODIFYMETHOD_ADD, GetUnitLevel(GetEnumUnit())*udg_zdjsx[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))])
else
endif
if ((((GetHeroAgi(GetEnumUnit(), false)+GetUnitLevel(GetEnumUnit())*udg_zdjsx[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))]) <= 2100000000))) then
call ModifyHeroStat( bj_HEROSTAT_AGI, GetEnumUnit(), bj_MODIFYMETHOD_ADD, GetUnitLevel(GetEnumUnit())*udg_zdjsx[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))])
else
endif
if ((((GetHeroInt(GetEnumUnit(), false)+GetUnitLevel(GetEnumUnit())*udg_zdjsx[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))]) <= 2100000000))) then
call ModifyHeroStat( bj_HEROSTAT_INT, GetEnumUnit(), bj_MODIFYMETHOD_ADD, GetUnitLevel(GetEnumUnit())*udg_zdjsx[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))])
else
endif
endfunction
function Trig_HKYJ14Actions takes nothing returns nothing
set bj_forLoopAIndex = 1
set bj_forLoopAIndexEnd = 12
loop
exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
if((IsPlayerInForce(ConvertedPlayer(bj_forLoopAIndex),udg_zdjsxwjz1) == true))then
set udg_zdjsxdwz[bj_forLoopAIndex] = GetUnitsOfPlayerMatching(ConvertedPlayer(bj_forLoopAIndex), Condition(function Trig_ui______uFunc001Func001002002))
call ForGroupBJ( udg_zdjsxdwz[bj_forLoopAIndex], function Trig_ui______uFunc001Func002A )
call GroupClear( udg_zdjsxdwz[bj_forLoopAIndex] )
call DestroyGroup( udg_zdjsxdwz[bj_forLoopAIndex] )
endif
if ((IsPlayerInForce(ConvertedPlayer(bj_forLoopAIndex),udg_zdqrkwjz1) == true)) then
call SetPlayerStateBJ( ConvertedPlayer(bj_forLoopAIndex), PLAYER_STATE_RESOURCE_FOOD_USED, 0 )
else
endif
if ((IsPlayerInForce(ConvertedPlayer(bj_forLoopAIndex),udg_zdjbwjz1) == true)) then
call AdjustPlayerStateBJ(zdzs1[bj_forLoopAIndex], ConvertedPlayer(bj_forLoopAIndex), PLAYER_STATE_RESOURCE_GOLD )
else
endif
if ((IsPlayerInForce(ConvertedPlayer(bj_forLoopAIndex),udg_zdmcwjz1) == true)) then
call AdjustPlayerStateBJ(zdzs2[bj_forLoopAIndex], ConvertedPlayer(bj_forLoopAIndex), PLAYER_STATE_RESOURCE_LUMBER )
else
endif
set bj_forLoopAIndex = bj_forLoopAIndex + 1
endloop
endfunction
function InitTrig_HKYJ14 takes nothing returns nothing
set gg_trg_HKYJ14=CreateTrigger()
call TriggerRegisterTimerEventPeriodic( gg_trg_HKYJ14, 1.00 )
call TriggerAddAction(gg_trg_HKYJ14,function Trig_HKYJ14Actions)
endfunction
function Trig_HKYJ3Conditions takes nothing returns boolean
return ((IsUnitInForce(GetTriggerUnit(),udg_Wucdwjz1)==true))
endfunction
function Trig_HKYJ3Actions takes nothing returns nothing
call SetUnitManaPercentBJ(GetTriggerUnit(),100)
call UnitResetCooldown(GetTriggerUnit())
set udg_Wucddw1[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))]=GetTriggerUnit()
call StartTimerBJ(udg_WucdJsq1[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))],false,0.01)
endfunction
function InitTrig_HKYJ3 takes nothing returns nothing
set gg_trg_HKYJ3=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_HKYJ3,EVENT_PLAYER_UNIT_SPELL_EFFECT)
call TriggerRegisterAnyUnitEventBJ(gg_trg_HKYJ3,EVENT_PLAYER_UNIT_SPELL_FINISH)
call TriggerRegisterAnyUnitEventBJ(gg_trg_HKYJ3,EVENT_PLAYER_UNIT_SPELL_ENDCAST)
call TriggerAddCondition(gg_trg_HKYJ3,Condition(function Trig_HKYJ3Conditions))
call TriggerAddAction(gg_trg_HKYJ3,function Trig_HKYJ3Actions)
endfunction
function Trig_HKYJ4Actions takes nothing returns nothing
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if((GetExpiredTimer()==udg_WucdJsq1[bj_forLoopAIndex]))then
call SetUnitManaPercentBJ(udg_Wucddw1[bj_forLoopAIndex],100)
call UnitResetCooldown(udg_Wucddw1[bj_forLoopAIndex])
call PauseTimer(udg_WucdJsq1[bj_forLoopAIndex])
call DoNothing()
exitwhen true
else
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function InitTrig_HKYJ4 takes nothing returns nothing
set gg_trg_HKYJ4=CreateTrigger()
call TriggerRegisterTimerExpireEvent(gg_trg_HKYJ4,udg_WucdJsq1[0])
call TriggerRegisterTimerExpireEvent(gg_trg_HKYJ4,udg_WucdJsq1[1])
call TriggerRegisterTimerExpireEvent(gg_trg_HKYJ4,udg_WucdJsq1[2])
call TriggerRegisterTimerExpireEvent(gg_trg_HKYJ4,udg_WucdJsq1[3])
call TriggerRegisterTimerExpireEvent(gg_trg_HKYJ4,udg_WucdJsq1[4])
call TriggerRegisterTimerExpireEvent(gg_trg_HKYJ4,udg_WucdJsq1[5])
call TriggerRegisterTimerExpireEvent(gg_trg_HKYJ4,udg_WucdJsq1[6])
call TriggerRegisterTimerExpireEvent(gg_trg_HKYJ4,udg_WucdJsq1[7])
call TriggerRegisterTimerExpireEvent(gg_trg_HKYJ4,udg_WucdJsq1[8])
call TriggerRegisterTimerExpireEvent(gg_trg_HKYJ4,udg_WucdJsq1[9])
call TriggerRegisterTimerExpireEvent(gg_trg_HKYJ4,udg_WucdJsq1[10])
call TriggerRegisterTimerExpireEvent(gg_trg_HKYJ4,udg_WucdJsq1[11])
call TriggerAddAction(gg_trg_HKYJ4,function Trig_HKYJ4Actions)
endfunction
function Trig_HKYJ5Conditions takes nothing returns boolean
return((IsUnitInForce(GetTriggerUnit(),udg_Pswjz1)==true))
endfunction
function Trig_HKYJ5Actions takes nothing returns nothing
if(((GetIssuedOrderIdBJ()==String2OrderIdBJ("move"))or(GetIssuedOrderIdBJ()==String2OrderIdBJ("patrol"))))then
//if(((GetIssuedOrderIdBJ()==String2OrderIdBJ("attack"))))then
if((IsUnitVisible(GetOrderTargetUnit(),GetOwningPlayer(GetTriggerUnit()))==true))then
set udg_Psdian1[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))]=GetUnitLoc(GetOrderTargetUnit())
call SetUnitPositionLoc(GetTriggerUnit(),udg_Psdian1[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))])
call RemoveLocation(udg_Psdian1[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))])
else
set udg_Psdian1[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))]=GetOrderPointLoc()
call SetUnitPositionLoc(GetTriggerUnit(),udg_Psdian1[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))])
call RemoveLocation(udg_Psdian1[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))])
endif
else
endif
endfunction
function InitTrig_HKYJ5 takes nothing returns nothing
set gg_trg_HKYJ5=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_HKYJ5,EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
call TriggerRegisterAnyUnitEventBJ(gg_trg_HKYJ5,EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
call TriggerAddCondition(gg_trg_HKYJ5,Condition(function Trig_HKYJ5Conditions))
call TriggerAddAction(gg_trg_HKYJ5,function Trig_HKYJ5Actions)
endfunction
function Trig_HKYJ6Conditions takes nothing returns boolean
return(((IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true)and(IsUnitInForce(GetTriggerUnit(),udg_YXWYwjz1)==true))and(IsUnitIllusionBJ(GetTriggerUnit())==false))
endfunction
function Trig_HKYJ6Actions takes nothing returns nothing
set udg_YXWYdian1[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))]=GetUnitLoc(GetTriggerUnit())
call ReviveHeroLoc(GetTriggerUnit(),udg_YXWYdian1[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))],true)
call RemoveLocation(udg_YXWYdian1[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))])
endfunction
function InitTrig_HKYJ6 takes nothing returns nothing
set gg_trg_HKYJ6=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_HKYJ6,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddCondition(gg_trg_HKYJ6,Condition(function Trig_HKYJ6Conditions))
call TriggerAddAction(gg_trg_HKYJ6,function Trig_HKYJ6Actions)
endfunction
function Trig_HKYJ7Actions takes nothing returns nothing
if((IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true)and(IsPlayerInForce(GetTriggerPlayer(),udg_cdwjz1)==false))then
set udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())]=DialogCreate()
call DialogSetMessage(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFFFFFF00《魔闪网 www.war3.xin》|r")
if((IsPlayerInForce(GetTriggerPlayer(),udg_Qtwjz1)==true))then
set udg_CJZBdhkNn1[0]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[关]|r"+"|cFF00CCFF全图|r",0)
else
set udg_CJZBdhkNn1[0]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[开]|r"+"|cFF00CCFF全图|r",0)
endif
if((IsPlayerInForce(GetTriggerPlayer(),udg_Wucdwjz1)==true))then
set udg_CJZBdhkNn1[1]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[关]|r"+"|cFF00CCFF无CD|r",0)
else
set udg_CJZBdhkNn1[1]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[开]|r"+"|cFF00CCFF无CD|r",0)
endif
if((IsPlayerInForce(GetTriggerPlayer(),udg_Pswjz1)==true))then
set udg_CJZBdhkNn1[2]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[关]|r"+"|cFF00CCFFPM闪|r",0)
else
set udg_CJZBdhkNn1[2]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[开]|r"+"|cFF00CCFFPM闪|r",0)
endif
set udg_CJZBdhkNn1[10]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFF00CCFF自动化菜单|r",0)
set udg_CJZBdhkNn1[3]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFF00CCFF添加技能菜单|r",0)
if((IsUnitInGroup(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],udg_DWWDdwz[GetPlayerId(GetTriggerPlayer())])==true))then
set udg_CJZBdhkNn1[4]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[关]|r"+"|cFF00CCFF无敌|r",0)
else
set udg_CJZBdhkNn1[4]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[开]|r"+"|cFF00CCFF无敌|r",0)
endif
if((IsUnitInGroup(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],udg_YDSDdwz[GetPlayerId(GetTriggerPlayer())])==true))then
set udg_CJZBdhkNn1[5]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[关]|r"+"|cFF00CCFF移动速度最快|r",0)
else
set udg_CJZBdhkNn1[5]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[开]|r"+"|cFF00CCFF移动速度最快|r",0)
endif
if((IsUnitInGroup(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],udg_HuiXuedwz[GetPlayerId(GetTriggerPlayer())])==true))then
set udg_CJZBdhkNn1[6]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[关]|r"+"|cFF00CCFF被攻击回血100%|r",0)
else
set udg_CJZBdhkNn1[6]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[开]|r"+"|cFF00CCFF被攻击回血100%|r",0)
endif
if((IsUnitPausedBJ(udg_JSXdw[GetPlayerId(GetTriggerPlayer())]) == true))then
set udg_CJZBdhkNn1[11]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[恢复]|r"+"|cFF00CCFF被暂停单位|r",0)
else
set udg_CJZBdhkNn1[11]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[暂停]|r"+"|cFF00CCFF单位|r",0)
endif
set bj_forLoopAIndex = 1
set bj_forLoopAIndexEnd = 16
loop
exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
if ((IsUnitInGroup(udg_JSXdw[GetPlayerId(GetTriggerPlayer())], udg_kzwjdwz[bj_forLoopAIndex]) == true)and(kzdwzs[GetPlayerId(GetTriggerPlayer())]==0)) then
set udg_CJZBdhkNn1[7]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[解除]|r"+"|cFF00CCFF被控制单位|r",0) 
set kzdwzs[GetPlayerId(GetTriggerPlayer())]=1
else
if(((GetConvertedPlayerId(GetOwningPlayer(udg_JSXdw[GetPlayerId(GetTriggerPlayer())])) == bj_forLoopAIndex))and(kzdwzs[GetPlayerId(GetTriggerPlayer())]==0)and(IsUnitInGroup(udg_JSXdw[GetPlayerId(GetTriggerPlayer())], udg_kzwjdwz[bj_forLoopAIndex]) != true)and((GetOwningPlayer(udg_JSXdw[GetPlayerId(GetTriggerPlayer())]) != GetTriggerPlayer())))then
set udg_CJZBdhkNn1[7]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[控制]|r"+"|cFF00CCFF单位|r",0)
set kzdwzs[GetPlayerId(GetTriggerPlayer())]=2
endif
endif
set bj_forLoopAIndex = bj_forLoopAIndex + 1
endloop
if((IsPlayerInForce(GetTriggerPlayer(),udg_BSMSwjz1)==true))then
set udg_CJZBdhkNn1[8]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFFFF0033[关]|r"+"|cFF00CCFF必杀模式|r",0)
else
set udg_CJZBdhkNn1[8]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFF66FF00[开]|r"+"|cFF00CCFF必杀模式|r",0)
endif
set udg_CJZBdhkNn1[9]=DialogAddButton(udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],"|cFF00CCFF退出菜单|r",0)
call DialogDisplay(GetTriggerPlayer(),udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())],true)
call TriggerRegisterDialogEvent(gg_trg_HKYJ2,udg_CJZBdhk1[GetPlayerId(GetTriggerPlayer())])
else
endif
endfunction
function InitTrig_HKYJ7 takes nothing returns nothing
set gg_trg_HKYJ7=CreateTrigger()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_HKYJ7,Player(0),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_HKYJ7,Player(1),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_HKYJ7,Player(2),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_HKYJ7,Player(3),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_HKYJ7,Player(4),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_HKYJ7,Player(5),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_HKYJ7,Player(6),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_HKYJ7,Player(7),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_HKYJ7,Player(8),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_HKYJ7,Player(9),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_HKYJ7,Player(10),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_HKYJ7,Player(11),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerAddAction(gg_trg_HKYJ7,function Trig_HKYJ7Actions)
endfunction
function Trig_HKYJ8Actions takes nothing returns nothing
set udg_JSXdw[GetPlayerId(GetTriggerPlayer())]=GetTriggerUnit()
if((IsPlayerInForce(GetOwningPlayer(GetTriggerUnit()), udg_KSJZwjz1) == true)and((IsUnitType(udg_JSXdw[GetPlayerId(GetTriggerPlayer())], UNIT_TYPE_STRUCTURE) == true))) then
call UnitSetConstructionProgress(udg_JSXdw[GetPlayerId(GetTriggerPlayer())], 100 )
call UnitSetUpgradeProgress(udg_JSXdw[GetPlayerId(GetTriggerPlayer())], 100 )
endif
endfunction
function InitTrig_HKYJ8 takes nothing returns nothing
set gg_trg_HKYJ8=CreateTrigger()
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_HKYJ8,Player(0),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_HKYJ8,Player(1),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_HKYJ8,Player(2),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_HKYJ8,Player(3),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_HKYJ8,Player(4),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_HKYJ8,Player(5),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_HKYJ8,Player(6),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_HKYJ8,Player(7),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_HKYJ8,Player(8),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_HKYJ8,Player(9),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_HKYJ8,Player(10),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_HKYJ8,Player(11),true)
call TriggerAddAction(gg_trg_HKYJ8,function Trig_HKYJ8Actions)
endfunction
function Trig_HKYJ9Actions takes nothing returns nothing
if(((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)==true)and(IsUnitInForce(GetAttacker(),udg_sxgjwjz1)==true)))then
call UnitDamageTargetBJ(GetAttacker(),GetAttackedUnitBJ(),((I2R(GetHeroStr(GetAttacker(),true))+(I2R(GetHeroAgi(GetAttacker(),true))+I2R(GetHeroInt(GetAttacker(),true))))*udg_YXWYshss[GetPlayerId(GetOwningPlayer(GetAttacker()))]),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
endif
if((IsUnitInForce(GetAttacker(),udg_BSMSwjz1)==true))then
call UnitDamageTargetBJ( GetAttacker(), GetAttackedUnitBJ(), GetUnitState(GetAttackedUnitBJ(), UNIT_STATE_LIFE), ATTACK_TYPE_CHAOS, DAMAGE_TYPE_DIVINE )
call KillUnit( GetAttackedUnitBJ() )
endif
if((IsUnitInForce(GetAttackedUnitBJ(),udg_zdhfwjz1) == true) and (( 1.00 - ( GetUnitState(GetAttackedUnitBJ(), UNIT_STATE_LIFE) / GetUnitState(GetAttackedUnitBJ(), UNIT_STATE_MAX_LIFE) ) ) >= 0.70))then
call SetUnitLifePercentBJ( GetAttackedUnitBJ(), 100 )
call SetUnitManaPercentBJ( GetAttackedUnitBJ(), 100 )
call DestroyEffect( AddSpecialEffectTarget("Abilities\\Spells\\Undead\\ReplenishHealth\\ReplenishHealthCasterOverhead.mdl", GetAttackedUnitBJ(), "overhead") )
endif
if((IsUnitInForce(GetAttacker(),udg_zdhfwjz1) == true) and (( 1.00 - ( GetUnitState(GetAttacker(), UNIT_STATE_LIFE) / GetUnitState(GetAttacker(), UNIT_STATE_MAX_LIFE) ) ) >= 0.70))then
call SetUnitLifePercentBJ( GetAttacker(), 100 )
call SetUnitManaPercentBJ( GetAttacker(), 100 )
call DestroyEffect( AddSpecialEffectTarget("Abilities\\Spells\\Undead\\ReplenishHealth\\ReplenishHealthCasterOverhead.mdl", GetAttackedUnitBJ(), "overhead") )
endif
if((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)==true)and(IsUnitIllusionBJ(GetKillingUnitBJ())==false)and(IsUnitInForce(GetKillingUnitBJ(),udg_sdjsxwjz1)==true))then
if((GetRandomInt(1,100)<=33))then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,R2I(( ( ( GetUnitLevel(GetKillingUnitBJ()) * 1 )) * udg_SGjsxss[GetPlayerId(GetOwningPlayer(GetKillingUnitBJ()))] ))+R2I(( ( ( GetUnitLevel(GetKillingUnitBJ()) * (( 1.00 - (( (GetUnitState(GetKillingUnitBJ(), UNIT_STATE_LIFE)) / (GetUnitState(GetKillingUnitBJ(), UNIT_STATE_MAX_LIFE)) )) )*10) )) * udg_SGjsxss[GetPlayerId(GetOwningPlayer(GetKillingUnitBJ()))] )))
else
endif
if((GetRandomInt(1,100)<=33))then
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,R2I(( ( ( GetUnitLevel(GetKillingUnitBJ()) * 1 )) * udg_SGjsxss[GetPlayerId(GetOwningPlayer(GetKillingUnitBJ()))] ))+R2I(( ( ( GetUnitLevel(GetKillingUnitBJ()) * (( 1.00 - (( (GetUnitState(GetKillingUnitBJ(), UNIT_STATE_LIFE)) / (GetUnitState(GetKillingUnitBJ(), UNIT_STATE_MAX_LIFE)) )) )*10) )) * udg_SGjsxss[GetPlayerId(GetOwningPlayer(GetKillingUnitBJ()))] )))
else
endif
if((GetRandomInt(1,100)<=33))then
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,R2I(( ( ( GetUnitLevel(GetKillingUnitBJ()) * 1 )) * udg_SGjsxss[GetPlayerId(GetOwningPlayer(GetKillingUnitBJ()))] ))+R2I(( ( ( GetUnitLevel(GetKillingUnitBJ()) * (( 1.00 - (( (GetUnitState(GetKillingUnitBJ(), UNIT_STATE_LIFE)) / (GetUnitState(GetKillingUnitBJ(), UNIT_STATE_MAX_LIFE)) )) )*10) )) * udg_SGjsxss[GetPlayerId(GetOwningPlayer(GetKillingUnitBJ()))] )))
else
endif
else
endif
set bj_forLoopAIndex = 0
set bj_forLoopAIndexEnd = 11
loop
exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
if((IsUnitInGroup(GetAttackedUnitBJ(),udg_HuiXuedwz[bj_forLoopAIndex])==true))then
call SetUnitLifePercentBJ(GetAttackedUnitBJ(),100)
else
endif
set bj_forLoopAIndex = bj_forLoopAIndex + 1
endloop
endfunction
function InitTrig_HKYJ9 takes nothing returns nothing
set gg_trg_HKYJ9=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_HKYJ9,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerRegisterAnyUnitEventBJ(gg_trg_HKYJ9,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddAction(gg_trg_HKYJ9,function Trig_HKYJ9Actions)
endfunction
function Trig_HKYJ11Actions takes nothing returns nothing
    if ((IsPlayerInForce(GetOwningPlayer(GetTriggerUnit()), udg_KSJZwjz1) == true)) then
        call AddPlayerTechResearched( GetOwningPlayer(GetTriggerUnit()), GetResearched(), 1 )
    else
    endif
endfunction
function InitTrig_HKYJ11 takes nothing returns nothing
    set gg_trg_HKYJ11 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ( gg_trg_HKYJ11, EVENT_PLAYER_UNIT_RESEARCH_START )
    call TriggerAddAction(gg_trg_HKYJ11, function Trig_HKYJ11Actions)
endfunction

function Fly_ItName_All takes nothing returns nothing
local integer i=1
local string s=GetEventPlayerChatString()
local integer k=StringLength(s)
if((GetEventPlayerChatString()!="-cxml")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
if((s=="-cx"))then
set Fly_sa_n=Fly_sa_n+1
else
if(S2I(SubString(s,3,k))>Fly_all_list_n)then
set Fly_sa_n=Fly_sa_n+1
else
if(S2I(SubString(s,3,k))>0)then
set Fly_sa_n=S2I(SubString(s,3,k))
endif
endif
endif
set Fly_saII=(Fly_sa_n-1)*50
set Fly_saIII=((ljzc_n-Fly_saII)/ 5)
if(Fly_sa_n==Fly_all_list_n)then
if(ljzc_n>(Fly_saII+4))then
loop
exitwhen i>Fly_saIII
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,(("|cffffff00"+I2S((i+Fly_saII)))+(".|r"+(Fly_all_name[(i+Fly_saII)]+(" |cffffff00"+(I2S(((i+Fly_saII)+Fly_saIII))+(".|r"+(Fly_all_name[((i+Fly_saII)+Fly_saIII)]+(" |cffffff00"+(I2S(((i+Fly_saII)+(Fly_saIII*2)))+(".|r"+(Fly_all_name[((i+Fly_saII)+(Fly_saIII*2))]+(" |cffffff00"+(I2S(((i+Fly_saII)+(Fly_saIII*3)))+(".|r"+(Fly_all_name[((i+Fly_saII)+(Fly_saIII*3))]+(" |cffffff00"+(I2S(((i+Fly_saII)+(Fly_saIII*4)))+(".|r"+Fly_all_name[((i+Fly_saII)+(Fly_saIII*4))])))))))))))))))))))
set i=i+1
endloop
endif
if(ModuloInteger(ljzc_n,5)==1)then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,("|cffffff00"+I2S(ljzc_n)+".|r"+Fly_all_name[ljzc_n]))
else
if(ModuloInteger(ljzc_n,5)==2)then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,("|cffffff00"+I2S(ljzc_n-1)+".|r"+Fly_all_name[(ljzc_n-1)]+" |cffffff00"+I2S(ljzc_n)+".|r"+Fly_all_name[ljzc_n]))
else
if(ModuloInteger(ljzc_n,5)==3)then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,("|cffffff00"+I2S(ljzc_n-2)+".|r"+Fly_all_name[(ljzc_n-2)]+" |cffffff00"+I2S(ljzc_n-1)+".|r"+Fly_all_name[(ljzc_n-1)]+" |cffffff00"+I2S(ljzc_n)+".|r"+Fly_all_name[ljzc_n]))
else
if(ModuloInteger(ljzc_n,5)==4)then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,("|cffffff00"+I2S(ljzc_n-3)+".|r"+Fly_all_name[(ljzc_n-3)]+" |cffffff00"+I2S(ljzc_n-2)+".|r"+Fly_all_name[(ljzc_n-2)]+" |cffffff00"+I2S(ljzc_n-1)+".|r"+Fly_all_name[(ljzc_n-1)]+" |cffffff00"+I2S(ljzc_n)+".|r"+Fly_all_name[ljzc_n]))
endif
endif
endif
endif
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60,("|CFFFF0000当|CFFFF6600前|CFFFFFF00为|CFF00FF00第|CFF00FFFF "+((I2S(Fly_sa_n)+("/"+I2S(Fly_all_list_n)))+" |CFF0000FF页    \"|CFFFF0000-|CFFFF6600cx\"")))
set Fly_sa_n=0
else
loop
exitwhen i>(50/ 5)
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,(("|cffffff00"+I2S((i+Fly_saII)))+(".|r"+(Fly_all_name[(i+Fly_saII)]+(" |cffffff00"+(I2S(((i+Fly_saII)+(50/ 5)))+(".|r"+(Fly_all_name[((i+Fly_saII)+(50/ 5))]+(" |cffffff00"+(I2S(((i+Fly_saII)+((50/ 5)*2)))+(".|r"+(Fly_all_name[((i+Fly_saII)+((50/ 5)*2))]+(" |cffffff00"+(I2S(((i+Fly_saII)+((50/ 5)*3)))+(".|r"+(Fly_all_name[((i+Fly_saII)+((50/ 5)*3))]+(" |cffffff00"+(I2S(((i+Fly_saII)+((50/ 5)*4)))+(".|r"+Fly_all_name[((i+Fly_saII)+((50/ 5)*4))])))))))))))))))))))
set i=i+1
endloop
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60,("|CFFFF0000当|CFFFF6600前|CFFFFFF00为|CFF00FF00第|CFF00FFFF "+((I2S(Fly_sa_n)+("/"+I2S(Fly_all_list_n)))+" |CFF0000FF页    \"|CFFFF0000-|CFFFF6600cx\"")))
endif
endif
set s=null
endfunction
function Fly_ItName_Part takes nothing returns nothing
local integer i=1
local integer l=0
local string s=GetEventPlayerChatString()
local integer k=StringLength(s)
if((IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true)and(GetEventPlayerChatString()!="-cxzl"))then
if((s=="-sc"))then
set Fly_sc_n=(Fly_sc_n+1)
else
if(S2I(SubString(s,3,k))>Fly_part_list_n)then
set Fly_sc_n=(Fly_sc_n+1)
else
if(S2I(SubString(s,3,k))>0)then
set Fly_sc_n=(S2I(SubString(s,3,k)))
endif
endif
endif
set Fly_scII=((Fly_sc_n-1)*50)
set Fly_scIII=((Fly_part_n-Fly_scII)/ 5)
if(Fly_sc_n==Fly_part_list_n)and(Fly_part_list_n!=1)then
if(Fly_part_n>(Fly_scII+4))then
loop
exitwhen i>Fly_scIII
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,(("|cffffff00"+I2S(Fly_part_No[(i+Fly_scII)]))+(".|r"+(Fly_part_name[(i+Fly_scII)]+(" |cffffff00"+(I2S(Fly_part_No[((i+Fly_scII)+Fly_scIII)])+(".|r"+(Fly_part_name[((i+Fly_scII)+Fly_scIII)]+(" |cffffff00"+(I2S(Fly_part_No[((i+Fly_scII)+(Fly_scIII*2))])+(".|r"+(Fly_part_name[((i+Fly_scII)+(Fly_scIII*2))]+(" |cffffff00"+(I2S(Fly_part_No[((i+Fly_scII)+(Fly_scIII*3))])+(".|r"+(Fly_part_name[((i+Fly_scII)+(Fly_scIII*3))]+(" |cffffff00"+(I2S(Fly_part_No[((i+Fly_scII)+(Fly_scIII*4))])+(".|r"+Fly_part_name[((i+Fly_scII)+(Fly_scIII*4))])))))))))))))))))))
set i=i+1
endloop
endif
if(ModuloInteger(Fly_part_n,5)==1)then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,("|cffffff00"+I2S(Fly_part_No[Fly_part_n])+".|r"+Fly_part_name[Fly_part_n]))
endif
if(ModuloInteger(Fly_part_n,5)==2)then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,("|cffffff00"+I2S(Fly_part_No[(Fly_part_n-1)])+".|r"+Fly_part_name[(Fly_part_n-1)]+" |cffffff00"+I2S(Fly_part_No[Fly_part_n])+".|r"+Fly_part_name[Fly_part_n]))
endif
if(ModuloInteger(Fly_part_n,5)==3)then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,("|cffffff00"+I2S(Fly_part_No[(Fly_part_n-2)])+".|r"+Fly_part_name[(Fly_part_n-2)]+" |cffffff00"+I2S(Fly_part_No[(Fly_part_n-1)])+".|r"+Fly_part_name[(Fly_part_n-1)]+" |cffffff00"+I2S(Fly_part_No[Fly_part_n])+".|r"+Fly_part_name[Fly_part_n]))
endif
if(ModuloInteger(Fly_part_n,5)==4)then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,("|cffffff00"+I2S(Fly_part_No[(Fly_part_n-3)])+".|r"+Fly_part_name[(Fly_part_n-3)]+" |cffffff00"+I2S(Fly_part_No[(Fly_part_n-2)])+".|r"+Fly_part_name[(Fly_part_n-2)]+" |cffffff00"+I2S(Fly_part_No[(Fly_part_n-1)])+".|r"+Fly_part_name[(Fly_part_n-1)]+" |cffffff00"+I2S(Fly_part_No[Fly_part_n])+".|r"+Fly_part_name[Fly_part_n]))
endif
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60,("|CFFFF0000当|CFFFF6600前|CFFFFFF00为|CFF00FF00第|CFF00FFFF "+((I2S(Fly_sc_n)+("/"+I2S(Fly_part_list_n)))+" |CFF0000FF页    \"|CFFFF0000-|CFFFF6600sc\"")))
set Fly_sc_n=0
elseif(Fly_part_list_n==1)then
if(ModuloInteger(Fly_part_n,5)==0)then
set l=Fly_part_n/ 5
loop
exitwhen i>l
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,(("|cffffff00"+I2S(Fly_part_No[((i*5)-4)]))+(".|r"+(Fly_part_name[Fly_part_No[((i*5)-4)]]+(" |cffffff00"+(I2S(Fly_part_No[((i*5)-3)])+(".|r"+(Fly_part_name[Fly_part_No[((i*5)-3)]]+(" |cffffff00"+(I2S(Fly_part_No[((i*5)-2)])+(".|r"+(Fly_part_name[Fly_part_No[((i*5)-2)]]+(" |cffffff00"+(I2S(Fly_part_No[((i*5)-1)])+(".|r"+(Fly_part_name[Fly_part_No[((i*5)-1)]]+(" |cffffff00"+(I2S(Fly_part_No[i*5])+(".|r"+Fly_part_name[Fly_part_No[i*5]])))))))))))))))))))
set i=i+1
endloop
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60,("|CFFFF0000当|CFFFF6600前|CFFFFFF00为|CFF00FF00第|CFF00FFFF "+((I2S(Fly_sc_n)+("/"+I2S(Fly_part_list_n)))+" |CFF0000FF页    \"|CFFFF0000-|CFFFF6600sc\"")))
set Fly_sc_n=0
set s=null
else
set l=(Fly_part_n/ 5)+1
if(Fly_part_n>5)then
loop
exitwhen i>l-1
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,(("|cffffff00"+I2S(Fly_part_No[((i*5)-4)]))+(".|r"+(Fly_part_name[Fly_part_No[((i*5)-4)]]+(" |cffffff00"+(I2S(Fly_part_No[((i*5)-3)])+(".|r"+(Fly_part_name[Fly_part_No[((i*5)-3)]]+(" |cffffff00"+(I2S(Fly_part_No[((i*5)-2)])+(".|r"+(Fly_part_name[Fly_part_No[((i*5)-2)]]+(" |cffffff00"+(I2S(Fly_part_No[((i*5)-1)])+(".|r"+(Fly_part_name[Fly_part_No[((i*5)-1)]]+(" |cffffff00"+(I2S(Fly_part_No[i*5])+(".|r"+Fly_part_name[Fly_part_No[i*5]])))))))))))))))))))
set i=i+1
endloop
endif
if(ModuloInteger(Fly_part_n,5)==1)then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,("|cffffff00"+I2S(Fly_part_No[Fly_part_n])+".|r"+Fly_part_name[Fly_part_n]))
endif
if(ModuloInteger(Fly_part_n,5)==2)then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,("|cffffff00"+I2S(Fly_part_No[(Fly_part_n-1)])+".|r"+Fly_part_name[(Fly_part_n-1)]+" |cffffff00"+I2S(Fly_part_No[Fly_part_n])+".|r"+Fly_part_name[Fly_part_n]))
endif
if(ModuloInteger(Fly_part_n,5)==3)then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,("|cffffff00"+I2S(Fly_part_No[(Fly_part_n-2)])+".|r"+Fly_part_name[(Fly_part_n-2)]+" |cffffff00"+I2S(Fly_part_No[(Fly_part_n-1)])+".|r"+Fly_part_name[(Fly_part_n-1)]+" |cffffff00"+I2S(Fly_part_No[Fly_part_n])+".|r"+Fly_part_name[Fly_part_n]))
endif
if(ModuloInteger(Fly_part_n,5)==4)then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,("|cffffff00"+I2S(Fly_part_No[(Fly_part_n-3)])+".|r"+Fly_part_name[(Fly_part_n-3)]+" |cffffff00"+I2S(Fly_part_No[(Fly_part_n-2)])+".|r"+Fly_part_name[(Fly_part_n-2)]+" |cffffff00"+I2S(Fly_part_No[(Fly_part_n-1)])+".|r"+Fly_part_name[(Fly_part_n-1)]+" |cffffff00"+I2S(Fly_part_No[Fly_part_n])+".|r"+Fly_part_name[Fly_part_n]))
endif
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60,("|CFFFF0000当|CFFFF6600前|CFFFFFF00为|CFF00FF00第|CFF00FFFF "+((I2S(Fly_sc_n)+("/"+I2S(Fly_part_list_n)))+" |CFF0000FF页    \"|CFFFF0000-|CFFFF6600sc\"")))
set Fly_sc_n=0
set s=null
endif
else
if(Fly_part_n!=0)then
loop
exitwhen i>50/ 5
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60.,(("|cffffff00"+I2S(Fly_part_No[(i+Fly_scII)]))+(".|r"+(Fly_part_name[(i+Fly_scII)]+(" |cffffff00"+(I2S(Fly_part_No[((i+Fly_scII)+(50/ 5))])+(".|r"+(Fly_part_name[((i+Fly_scII)+(50/ 5))]+(" |cffffff00"+(I2S(Fly_part_No[((i+Fly_scII)+((50/ 5)*2))])+(".|r"+(Fly_part_name[((i+Fly_scII)+((50/ 5)*2))]+(" |cffffff00"+(I2S(Fly_part_No[((i+Fly_scII)+((50/ 5)*3))])+(".|r"+(Fly_part_name[((i+Fly_scII)+((50/ 5)*3))]+(" |cffffff00"+(I2S(Fly_part_No[((i+Fly_scII)+((50/ 5)*4))])+(".|r"+Fly_part_name[((i+Fly_scII)+((50/ 5)*4))])))))))))))))))))))
set i=i+1
endloop
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60,("|CFFFF0000当|CFFFF6600前|CFFFFFF00为|CFF00FF00第|CFF00FFFF "+((I2S(Fly_sc_n)+("/"+I2S(Fly_part_list_n)))+" |CFF0000FF页    \"|CFFFF0000-|CFFFF6600sc\"")))
else
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,60,("|CFFFF0000此|CFFFF6600地|CFFFFFF00图|CFF00FF00没|CFF00FFFF有|CFF0000FF彩|CFFFF0000色|CFFFF6600装备"))
endif
endif
endif
set s=null
endfunction
function Fly_Item_sc takes nothing returns nothing
local integer i=0
local integer k=0
local string s1x
loop
set s1x=Fly_all_name[i]
if SubString(s1x,0,1)=="|" then
if SubString(s1x,1,2)=="c" or SubString(s1x,1,2)=="C" then
set k=k+1
set Fly_part_name[k]=s1x
set Fly_part_No[k]=i
set Fly_part_n=Fly_part_n+1
elseif SubString(s1x,1,2)=="r" or SubString(s1x,1,2)=="R" then
set k=k+1
set Fly_part_name[k]=s1x
set Fly_part_No[k]=i
set Fly_part_n=Fly_part_n+1
endif
endif
if(i==ljzc_n)then
if(ModuloInteger(Fly_part_n,50)==0)then
set Fly_part_list_n=Fly_part_n/ 50
else
set Fly_part_list_n=((Fly_part_n/ 50)+1)
endif
endif
exitwhen i>ljzc_n
set i=i+1
endloop
set s1x=null
endfunction
function Fly_It_Name takes nothing returns nothing
local integer i=0
local trigger t=CreateTrigger()
local trigger t1x=CreateTrigger()
loop
call TriggerRegisterPlayerChatEvent(t,Player(i),"-cx",false)
call TriggerRegisterPlayerChatEvent(t1x,Player(i),"-sc",false)
set i=i+1
exitwhen i==11
endloop
call TriggerAddAction(t1x,function Fly_ItName_Part)
call TriggerAddAction(t,function Fly_ItName_All)
endfunction
function FYMessage takes string msg returns nothing
local integer i=0
loop
call DisplayTimedTextToPlayer(Player(i),0,0,300,msg)
set i=i+1
exitwhen i==11
endloop
endfunction
function C_IM takes integer p,string s returns nothing
local integer i=0
local integer j=1
local integer k=StringLength(s)
local integer k1x
local string s1x
loop
set s1x=GetObjectName(ljzc_it[i])
set k1x=StringLength(s1x)
set j=1
loop
if SubString(s1x,j-1,j)=="|" then
if SubString(s1x,j,j+1)=="c" or SubString(s1x,j,j+1)=="C" then
set s1x=SubString(s1x,0,j-1)+SubString(s1x,j+9,k1x)
set j=j-1
elseif SubString(s1x,j,j+1)=="r" or SubString(s1x,j,j+1)=="R" then
set s1x=SubString(s1x,0,j-1)+SubString(s1x,j+1,k1x)
endif
endif
exitwhen j>=k1x
set j=j+1
endloop
if SubString(s,8,k)==SubString(s1x,0,k-8)then
call CreateItem(ljzc_it[i], GetUnitX(udg_JSXdw[GetPlayerId(GetTriggerPlayer())]), GetUnitY(udg_JSXdw[GetPlayerId(GetTriggerPlayer())]))
call DisplayTextToPlayer(Player(p),0,0,"|cFF00FF00 创建 |r"+s1x)
endif
exitwhen(i==ljzc_n)
set i=i+1
endloop
call DisplayTextToPlayer(Player(p),0,0,"|cFF00FF00 创建完成! |r")
set s1x=null
endfunction
function YLS_0000 takes nothing returns boolean
local string s1x
local string s=GetEventPlayerChatString()
local integer k=StringLength(s)
if (IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true) then
if SubString(s,0,8)=="=获得 " then
call C_IM(GetPlayerId(GetTriggerPlayer()),s)
endif
if SubString(s,0,2)=="wp" then
set s1x=GetObjectName(ljzc_it[S2I(SubString(s,2,k))])
call CreateItem(ljzc_it[S2I(SubString(s,2,k))], GetUnitX(udg_JSXdw[GetPlayerId(GetTriggerPlayer())]), GetUnitY(udg_JSXdw[GetPlayerId(GetTriggerPlayer())]))
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,"|cFF00FF00 创建 |r"+s1x)
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,"|cFF00FF00 创建完成! |r")
endif
endif
return false
endfunction
function YLS_ylsNB takes nothing returns nothing
local integer i=0
local trigger t=CreateTrigger()
loop
exitwhen i>11
call TriggerRegisterPlayerChatEvent(t,Player(i),"",false)
set i=i+1
endloop
call TriggerAddCondition(t,Condition(function YLS_0000))
endfunction
function ljcsh takes nothing returns nothing
local integer i=0
loop
exitwhen i>=62
if(i<=9)then
set ljzc_id[i]=i+48
elseif(i<=35)then
set ljzc_id[i]=i+55
else
set ljzc_id[i]=i+61
endif
set i=i+1
endloop
endfunction
function ljid6 takes nothing returns nothing
local integer i=0
local item itx
local integer j=1
local integer k1x
local string s1x
loop
set itx=CreateItem(ljzc_ida+ljzc_idb+ljzc_idc+ljzc_id[i],0,0)
if(itx!=null)then
set ljzc_n=ljzc_n+1
set ljzc_it[ljzc_n]=GetItemTypeId(itx)
set Fly_all_name[ljzc_n]=GetObjectName(ljzc_it[ljzc_n])
endif
call RemoveItem(itx)
exitwhen i==61
set i=i+1
endloop
set itx=null
endfunction
function ljid5 takes nothing returns nothing
set ljzc_idc=256*ljzc_id[ljzc_ic]
set ljzc_ic=ljzc_ic+1
if(ljzc_ic==62)then
call PauseTimer(ljzc_tmc)
call DestroyTimer(ljzc_tmc)
set ljzc_ic=0
endif
call ljid6()
endfunction
function ljid4 takes nothing returns nothing
set ljzc_tmc=CreateTimer()
call TimerStart(ljzc_tmc,.0005,true,function ljid5)
endfunction
function ljid3 takes nothing returns nothing
set ljzc_idb=256*256*ljzc_id[ljzc_ib]
set ljzc_ib=ljzc_ib+1
if(ljzc_ib==62)then
call PauseTimer(ljzc_tmb)
call DestroyTimer(ljzc_tmb)
set ljzc_ib=0
endif
call ljid4()
endfunction
function ljid2 takes nothing returns nothing
set ljzc_tmb=CreateTimer()
call TimerStart(ljzc_tmb,.0322,true,function ljid3)
endfunction
function ljid1 takes nothing returns nothing
set ljzc_ida=256*256*256*ljzc_id[ljzc_ia]
set ljzc_ia=ljzc_ia+1
if(ljzc_ia==62)then
call PauseTimer(ljzc_tm)
call DestroyTimer(ljzc_tm)
if(ModuloInteger(ljzc_n,50)==0)then
set Fly_all_list_n=(ljzc_n/ 50)
else
set Fly_all_list_n=((ljzc_n/ 50)+1)
endif
call YLS_ylsNB()
call Fly_It_Name()
call Fly_Item_sc()
endif
call ljid2()
endfunction
function ljzc takes nothing returns nothing
call ljcsh()
set ljzc_ia=0
set ljzc_ib=0
set ljzc_ic=0
set ljzc_n=0
set Fly_sa_n=0
set Fly_sc_n=0
set Fly_part_n=0
set ljzc_tm=CreateTimer()
call TimerStart(ljzc_tm,2,true,function ljid1)
endfunction
function fly_main takes nothing returns nothing
set pfzy_wpX[GetPlayerId(GetTriggerPlayer())]=GetUnitX(udg_JSXdw[GetPlayerId(GetTriggerPlayer())])
set pfzy_wpY[GetPlayerId(GetTriggerPlayer())]=GetUnitY(udg_JSXdw[GetPlayerId(GetTriggerPlayer())])
endfunction
function Fly_main takes nothing returns nothing
local integer i=0
local trigger t=CreateTrigger()
loop
exitwhen i>11
call TriggerRegisterPlayerUnitEvent(t,Player(i),ConvertPlayerUnitEvent(24),null)
set i=i+1
endloop
call ljzc()
call TriggerAddAction(t,function fly_main)
endfunction
function fy_qcdc takes nothing returns boolean
if(GetPlayerController(GetTriggerPlayer())==ConvertMapControl(0)and((IsUnitInForce(GetTriggerUnit(),udg_Wucdwjz1)==true)))then
return true
endif
return false	
endfunction
function fy_sjd takes nothing returns nothing
local timer t=GetExpiredTimer()
local unit u=LoadUnitHandle(fy_ht,1,1)
local real m=LoadReal(fy_ht,1,2)
call UnitResetCooldown(u)
call SetUnitState(u,ConvertUnitState(2),m)
call FlushChildHashtable(fy_ht,1)
call DestroyTimer(t)
set t=null
set u=null
endfunction
function fy_qcd takes nothing returns nothing
local timer t=CreateTimer()
local unit u=GetTriggerUnit()
local real m=GetUnitState(GetTriggerUnit(),ConvertUnitState(3))
call SaveUnitHandle(fy_ht,1,1,u)
call SaveReal(fy_ht,1,2,m)
call TimerStart(t,0,false,function fy_sjd)
set t=null
set u=null
endfunction
function FY_qcd takes nothing returns nothing
local integer i=0
local trigger t=CreateTrigger()
loop
exitwhen i>11
call TriggerRegisterPlayerUnitEvent(t,Player(i),ConvertPlayerUnitEvent(274),null)
set i=i+1
endloop
call TriggerAddCondition(t,Condition(function fy_qcdc))
call TriggerAddAction(t,function fy_qcd)	
endfunction
function Trig_XHCDXSWP1Actions takes nothing returns nothing
set udg_swpzfcpd="***********************************************0123456789*******ABCDEFGHIJKLMNOPQRSTUVWXYZ******abcdefghijklmnopqrstuvwxyz"
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_WJswpzs1[bj_forLoopAIndex]=0
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=1
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_swpzfc[bj_forLoopAIndex]=""
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function InitTrig_XHCDXSWP1 takes nothing returns nothing
set gg_trg_XHCDXSWP1=CreateTrigger()
call TriggerRegisterTimerEventSingle(gg_trg_XHCDXSWP1,0.01)
call TriggerAddAction(gg_trg_XHCDXSWP1,function Trig_XHCDXSWP1Actions)
endfunction
function Trig_XHCDXSWP2Func004Func005002002 takes nothing returns boolean
return((IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true))
endfunction
function Trig_XHCDXSWP2Actions takes nothing returns nothing
set udg_swpzfc[0]=SubStringBJ(GetEventPlayerChatString(),1,3)
set udg_swpzfc[1]=SubStringBJ(GetEventPlayerChatString(),5,8)
if((udg_swpzfc[0]=="-wp")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
set bj_forLoopAIndex=5
set bj_forLoopAIndexEnd=StringLength(GetEventPlayerChatString())
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set bj_forLoopBIndex=5
set bj_forLoopBIndexEnd=255
loop
exitwhen bj_forLoopBIndex>bj_forLoopBIndexEnd
if((SubStringBJ(GetEventPlayerChatString(),bj_forLoopAIndex,bj_forLoopAIndex)==SubStringBJ(udg_swpzfcpd,bj_forLoopBIndex,bj_forLoopBIndex)))then
if((SubStringBJ(GetEventPlayerChatString(),bj_forLoopAIndex,bj_forLoopAIndex)!="*"))then
set udg_swpzs=((udg_swpzs*256)+bj_forLoopBIndex)
else
endif
else
endif
set bj_forLoopBIndex=bj_forLoopBIndex+1
endloop
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set udg_swpwplx=udg_swpzs
set udg_swpwp =CreateItem(udg_swpwplx, GetUnitX(udg_JSXdw[GetPlayerId(GetTriggerPlayer())]), GetUnitY(udg_JSXdw[GetPlayerId(GetTriggerPlayer())]))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10.00,("|cFF00FF00获得|r"+GetItemName(udg_swpwp)))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,3.00,("|cFF00FF00若【获得】后面没带有物品名字，就是代码输入错误了|r"))
else
endif
endfunction
function InitTrig_XHCDXSWP2 takes nothing returns nothing
set gg_trg_XHCDXSWP2=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_XHCDXSWP2,Player(0),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_XHCDXSWP2,Player(1),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_XHCDXSWP2,Player(2),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_XHCDXSWP2,Player(3),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_XHCDXSWP2,Player(4),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_XHCDXSWP2,Player(5),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_XHCDXSWP2,Player(6),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_XHCDXSWP2,Player(7),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_XHCDXSWP2,Player(8),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_XHCDXSWP2,Player(9),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_XHCDXSWP2,Player(10),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_XHCDXSWP2,Player(11),"",true)
call TriggerAddAction(gg_trg_XHCDXSWP2,function Trig_XHCDXSWP2Actions)
endfunction