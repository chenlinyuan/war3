//function Trig_XHCDXzb2Func001Func003002002 takes nothing returns boolean
//return((IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true))
//endfunction
function Trig_XHCDXzb2Actions takes nothing returns nothing
if(((GetEventPlayerChatString()=="支持www.war3.xin")and(IsPlayerInForce(GetTriggerPlayer(),udg_SZBwjz)==false)))then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10.00,"|cFF33FF66RG淘宝：恭喜你获得赠送的赞助礼包|r")
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10.00,"|cFF33FF66金币*10000 木材*100|r")
//call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10.00,"|cFFFFFF00随机物品|r")
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
if(((GetEventPlayerChatString()=="开启全图")and(IsPlayerInForce(GetTriggerPlayer(),udg_KQTwjz)==false)))then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10.00,"|cFF33FF66成功开启全图|r")
call CreateFogModifierRectBJ(true,GetTriggerPlayer(),FOG_OF_WAR_VISIBLE,GetPlayableMapRect())
set udg_QTXZQ[GetPlayerId(GetTriggerPlayer())]=GetLastCreatedFogModifier()
call FogModifierStart(udg_QTXZQ[GetPlayerId(GetTriggerPlayer())])
call ForceAddPlayer(udg_KQTwjz,GetTriggerPlayer())
else
if(((GetEventPlayerChatString()=="关闭全图")and(IsPlayerInForce(GetTriggerPlayer(),udg_KQTwjz)==true)))then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10.00,"|cFF33FF66成功关闭全图|r")
call FogModifierStop(udg_QTXZQ[GetPlayerId(GetTriggerPlayer())])
call DestroyFogModifier(udg_QTXZQ[GetPlayerId(GetTriggerPlayer())])
call ForceRemovePlayer(udg_KQTwjz,GetTriggerPlayer())
else
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
set udg_CJZBdhk1=DialogCreate()
set udg_YXWYwjz1=CreateForce()
set udg_JQzfc=""
set udg_SLzfc=""
set i=0
loop
exitwhen(i>11)
set udg_YXWYshss[i]=0
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
set udg_SGjsxss[i]=0
set i=i+1
endloop
set i=0
loop
exitwhen(i>11)
set udg_YDSDdwz[i]=CreateGroup()
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
if((GetEventPlayerChatString()=="www.war3.xin")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==false))then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10.00,"|cFF1FBF00开启作弊|r")
call ForceAddPlayer(udg_Zhjikqwjz1,GetTriggerPlayer())
set udg_CJZBwj[GetPlayerId(GetTriggerPlayer())]=GetTriggerPlayer()
else
if((GetEventPlayerChatString()=="关闭作弊")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10.00,"|cFF1FBF00关闭作弊|r")
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
set udg_CJZBdhk1=DialogCreate()
call DialogSetMessage(udg_CJZBdhk1,"|cFF1FBF00魔兽地图www.war3.xin|r")
if((IsPlayerInForce(GetTriggerPlayer(),udg_Qtwjz1)==true))then
set udg_CJZBdhkNn1[0]=DialogAddButton(udg_CJZBdhk1,"|cFFFF0033关闭全图|r",0)
else
set udg_CJZBdhkNn1[0]=DialogAddButton(udg_CJZBdhk1,"|cFFFF0033开启全图|r",0)
endif
if((IsPlayerInForce(GetTriggerPlayer(),udg_Wucdwjz1)==true))then
set udg_CJZBdhkNn1[1]=DialogAddButton(udg_CJZBdhk1,"|cFFFF0033关闭无CD|r",0)
else
set udg_CJZBdhkNn1[1]=DialogAddButton(udg_CJZBdhk1,"|cFFFF0033开启无CD|r",0)
endif
if((IsPlayerInForce(GetTriggerPlayer(),udg_Pswjz1)==true))then
set udg_CJZBdhkNn1[2]=DialogAddButton(udg_CJZBdhk1,"|cFFFF0033关闭PM闪|r",0)
else
set udg_CJZBdhkNn1[2]=DialogAddButton(udg_CJZBdhk1,"|cFFFF0033开启PM闪|r",0)
endif
if((IsPlayerInForce(GetTriggerPlayer(),udg_YXWYwjz1)==true))then
set udg_CJZBdhkNn1[3]=DialogAddButton(udg_CJZBdhk1,"|cFFFF0033关闭英雄无忧|r",0)
else
set udg_CJZBdhkNn1[3]=DialogAddButton(udg_CJZBdhk1,"|cFFFF0033开启英雄无忧|r",0)
endif
if((IsUnitInGroup(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],udg_DWWDdwz[GetPlayerId(GetTriggerPlayer())])==true))then
set udg_CJZBdhkNn1[4]=DialogAddButton(udg_CJZBdhk1,"|cFFFF0033关闭无敌|r",0)
else
set udg_CJZBdhkNn1[4]=DialogAddButton(udg_CJZBdhk1,"|cFFFF0033开启无敌|r",0)
endif
if((IsUnitInGroup(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],udg_YDSDdwz[GetPlayerId(GetTriggerPlayer())])==true))then
set udg_CJZBdhkNn1[5]=DialogAddButton(udg_CJZBdhk1,"|cFFFF0033关闭移动速度最快|r",0)
else
set udg_CJZBdhkNn1[5]=DialogAddButton(udg_CJZBdhk1,"|cFFFF0033开启移动速度最快|r",0)
endif
if((IsUnitInGroup(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],udg_HuiXuedwz[GetPlayerId(GetTriggerPlayer())])==true))then
set udg_CJZBdhkNn1[6]=DialogAddButton(udg_CJZBdhk1,"|cFFFF0033关闭被攻击回血100%|r",0)
else
set udg_CJZBdhkNn1[6]=DialogAddButton(udg_CJZBdhk1,"|cFFFF0033开启被攻击回血100%|r",0)
endif
set udg_CJZBdhkNn1[7]=DialogAddButton(udg_CJZBdhk1,"|cFFFF0033退出菜单|r",0)
call DialogDisplay(GetTriggerPlayer(),udg_CJZBdhk1,true)
call TriggerRegisterDialogEvent(gg_trg_HKYJ2,udg_CJZBdhk1)
else
endif
set udg_JQzfc=SubStringBJ(GetEventPlayerChatString(),1,3)
set udg_SLzfc=SubStringBJ(GetEventPlayerChatString(),5,16)
if((udg_JQzfc=="+jb")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
call AdjustPlayerStateBJ(S2I(udg_SLzfc),GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD)
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10.00,("|cFFFFFF00已增加"+(udg_SLzfc+"金币|r")))
else
if((udg_JQzfc=="+mc")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
call AdjustPlayerStateBJ(S2I(udg_SLzfc),GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER)
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10.00,("|cFF1FBF00已增加"+(udg_SLzfc+"木材|r")))
else
if((udg_JQzfc=="+li")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
call ModifyHeroStat(bj_HEROSTAT_STR,udg_JSXdw[GetPlayerId(GetTriggerPlayer())],bj_MODIFYMETHOD_ADD,S2I(udg_SLzfc))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10.00,("|cFF1FBF00已增加"+(udg_SLzfc+"力量|r")))
else
if((udg_JQzfc=="+mj")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
call ModifyHeroStat(bj_HEROSTAT_AGI,udg_JSXdw[GetPlayerId(GetTriggerPlayer())],bj_MODIFYMETHOD_ADD,S2I(udg_SLzfc))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10.00,("|cFF1FBF00已增加"+(udg_SLzfc+"敏捷|r")))
else
if((udg_JQzfc=="+zl")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
call ModifyHeroStat(bj_HEROSTAT_INT,udg_JSXdw[GetPlayerId(GetTriggerPlayer())],bj_MODIFYMETHOD_ADD,S2I(udg_SLzfc))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10.00,("|cFF1FBF00已增加"+(udg_SLzfc+"智力|r")))
else
if((udg_JQzfc=="+sw")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
call ModifyHeroStat(bj_HEROSTAT_STR,udg_JSXdw[GetPlayerId(GetTriggerPlayer())],bj_MODIFYMETHOD_ADD,S2I(udg_SLzfc))
call ModifyHeroStat(bj_HEROSTAT_AGI,udg_JSXdw[GetPlayerId(GetTriggerPlayer())],bj_MODIFYMETHOD_ADD,S2I(udg_SLzfc))
call ModifyHeroStat(bj_HEROSTAT_INT,udg_JSXdw[GetPlayerId(GetTriggerPlayer())],bj_MODIFYMETHOD_ADD,S2I(udg_SLzfc))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10.00,("|cFF1FBF00已增加"+(udg_SLzfc+"三围|r")))
else
if((udg_JQzfc=="+dj")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
call SetHeroLevelBJ(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],S2I(udg_SLzfc),false)
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10.00,("|cFF1FBF00已调整等级为"+(udg_SLzfc+"级|r")))
else
if((udg_JQzfc=="-sh")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true)and(IsPlayerInForce(GetTriggerPlayer(),udg_YXWYwjz1)==true))then
set udg_YXWYshss[GetPlayerId(GetTriggerPlayer())]=S2R(udg_SLzfc)
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10.00,"|cFF1FBF00已调整伤害倍率|r")
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10.00,("|cFF1FBF00目前的属性伤害倍率为"+(udg_SLzfc+"倍|r")))
else
if((udg_JQzfc=="-cs")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10.00,("|cFF1FBF00已设置物品使用次数为"+(udg_SLzfc+"次|r")))
call SetItemCharges(UnitItemInSlot(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],0),S2I(udg_SLzfc))
else
if((udg_JQzfc=="-ql")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10.00,"|cFF1FBF0015秒后清理地面所有物品|r")
call TriggerSleepAction(15.00)
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10.00,"|cFF1FBF00清理地面所有物品|r")
call EnumItemsInRectBJ(GetPlayableMapRect(),function Trig_HKYJ1Func005Func001Func001Func001Func001Func001Func001Func001Func001Func001Func005A)
else
if((udg_JQzfc=="-sx")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
set udg_SGjsxss[GetPlayerId(GetTriggerPlayer())]=S2R(udg_SLzfc)
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10.00,"|cFF1FBF00已设置杀怪加属性的增加数值|r")
else
if((udg_JQzfc=="-rk")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
call SetPlayerStateBJ(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_FOOD_USED,S2I(udg_SLzfc))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10.00,("|cFF1FBF00已设置当前的人口数量为"+(udg_SLzfc+"|r")))
else
endif
if((udg_JQzfc=="-jy")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
call SetPlayerHandicapXP(GetTriggerPlayer(),S2R(udg_SLzfc))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10.00,("|cFF1FBF00已设置当前的经验倍率为"+(udg_SLzfc+"|r")))
else
endif
if((udg_JQzfc=="-fz")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10.00,"|cFF1FBF00复制当前单位的所有物品|r")
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
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF1FBF00已关闭全图模式|r")
call FogModifierStop(udg_QtXzq1[GetPlayerId(GetTriggerPlayer())])
call DestroyFogModifier(udg_QtXzq1[GetPlayerId(GetTriggerPlayer())])
call ForceRemovePlayer(udg_Qtwjz1,udg_CJZBwj[GetPlayerId(GetTriggerPlayer())])
else
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF1FBF00已开启全图模式|r")
call CreateFogModifierRectBJ(true,udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],FOG_OF_WAR_VISIBLE,GetPlayableMapRect())
set udg_QtXzq1[GetPlayerId(GetTriggerPlayer())]=bj_lastCreatedFogModifier
call FogModifierStart(udg_QtXzq1[GetPlayerId(GetTriggerPlayer())])
call ForceAddPlayer(udg_Qtwjz1,udg_CJZBwj[GetPlayerId(GetTriggerPlayer())])
endif
else
endif
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[1]))then
if((IsPlayerInForce(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],udg_Wucdwjz1)==true))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF1FBF00已关闭无CD|r")
call ForceRemovePlayer(udg_Wucdwjz1,udg_CJZBwj[GetPlayerId(GetTriggerPlayer())])
else
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF1FBF00已开启无CD|r")
call ForceAddPlayer(udg_Wucdwjz1,udg_CJZBwj[GetPlayerId(GetTriggerPlayer())])
endif
else
endif
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[2]))then
if((IsPlayerInForce(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],udg_Pswjz1)==true))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF1FBF00已关闭P闪|r")
call ForceRemovePlayer(udg_Pswjz1,udg_CJZBwj[GetPlayerId(GetTriggerPlayer())])
else
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF1FBF00已开启P闪|r")
call ForceAddPlayer(udg_Pswjz1,udg_CJZBwj[GetPlayerId(GetTriggerPlayer())])
endif
else
endif
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[3]))then
if((IsPlayerInForce(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],udg_YXWYwjz1)==true))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF1FBF00已关闭英雄无忧|r")
call ForceRemovePlayer(udg_YXWYwjz1,udg_CJZBwj[GetPlayerId(GetTriggerPlayer())])
else
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF1FBF00已开启英雄无忧|r")
call ForceAddPlayer(udg_YXWYwjz1,udg_CJZBwj[GetPlayerId(GetTriggerPlayer())])
endif
else
endif
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[4]))then
if((IsUnitInGroup(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],udg_DWWDdwz[GetPlayerId(GetTriggerPlayer())])==true))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF1FBF00已关闭无敌|r")
call SetUnitInvulnerable(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],false)
call GroupRemoveUnit(udg_DWWDdwz[GetPlayerId(GetTriggerPlayer())],udg_JSXdw[GetPlayerId(GetTriggerPlayer())])
else
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF1FBF00已开启无敌|r")
call SetUnitInvulnerable(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],true)
call GroupAddUnit(udg_DWWDdwz[GetPlayerId(GetTriggerPlayer())],udg_JSXdw[GetPlayerId(GetTriggerPlayer())])
endif
else
endif
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[5]))then
if((IsUnitInGroup(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],udg_YDSDdwz[GetPlayerId(GetTriggerPlayer())])==true))then
call SetUnitMoveSpeed(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],GetUnitDefaultMoveSpeed(udg_JSXdw[GetPlayerId(GetTriggerPlayer())]))
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF1FBF00已关闭移动速度最快|r")
call GroupRemoveUnit(udg_YDSDdwz[GetPlayerId(GetTriggerPlayer())],udg_JSXdw[GetPlayerId(GetTriggerPlayer())])
else
call SetUnitMoveSpeed(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],522.00)
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF1FBF00已开启移动速度最快|r")
call GroupAddUnitSimple(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],udg_YDSDdwz[GetPlayerId(GetTriggerPlayer())])
endif
else
endif
if((GetClickedButtonBJ()==udg_CJZBdhkNn1[6]))then
if((IsUnitInGroup(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],udg_HuiXuedwz[GetPlayerId(GetTriggerPlayer())])==true))then
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF1FBF00已关闭被攻击回血100%|r")
call GroupRemoveUnit(udg_HuiXuedwz[GetPlayerId(GetTriggerPlayer())],udg_JSXdw[GetPlayerId(GetTriggerPlayer())])
else
call DisplayTimedTextToPlayer(udg_CJZBwj[GetPlayerId(GetTriggerPlayer())],0,0,10.00,"|cFF1FBF00已开启被攻击回血100%|r")
call GroupAddUnitSimple(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],udg_HuiXuedwz[GetPlayerId(GetTriggerPlayer())])
endif
else
endif
endfunction
function InitTrig_HKYJ2 takes nothing returns nothing
set gg_trg_HKYJ2=CreateTrigger()
call TriggerAddAction(gg_trg_HKYJ2,function Trig_HKYJ2Actions)
endfunction
function Trig_HKYJ3Conditions takes nothing returns boolean
return((IsUnitInForce(GetTriggerUnit(),udg_Wucdwjz1)==true))
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
if((IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
set udg_CJZBdhk1=DialogCreate()
call DialogSetMessage(udg_CJZBdhk1,"|cFF1FBF00魔兽地图www.war3.xin|r")
if((IsPlayerInForce(GetTriggerPlayer(),udg_Qtwjz1)==true))then
set udg_CJZBdhkNn1[0]=DialogAddButton(udg_CJZBdhk1,"|cFFFF0033关闭全图|r",0)
else
set udg_CJZBdhkNn1[0]=DialogAddButton(udg_CJZBdhk1,"|cFFFF0033开启全图|r",0)
endif
if((IsPlayerInForce(GetTriggerPlayer(),udg_Wucdwjz1)==true))then
set udg_CJZBdhkNn1[1]=DialogAddButton(udg_CJZBdhk1,"|cFFFF0033关闭无CD|r",0)
else
set udg_CJZBdhkNn1[1]=DialogAddButton(udg_CJZBdhk1,"|cFFFF0033开启无CD|r",0)
endif
if((IsPlayerInForce(GetTriggerPlayer(),udg_Pswjz1)==true))then
set udg_CJZBdhkNn1[2]=DialogAddButton(udg_CJZBdhk1,"|cFFFF0033关闭PM闪|r",0)
else
set udg_CJZBdhkNn1[2]=DialogAddButton(udg_CJZBdhk1,"|cFFFF0033开启PM闪|r",0)
endif
if((IsPlayerInForce(GetTriggerPlayer(),udg_YXWYwjz1)==true))then
set udg_CJZBdhkNn1[3]=DialogAddButton(udg_CJZBdhk1,"|cFFFF0033关闭英雄无忧|r",0)
else
set udg_CJZBdhkNn1[3]=DialogAddButton(udg_CJZBdhk1,"|cFFFF0033开启英雄无忧|r",0)
endif
if((IsUnitInGroup(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],udg_DWWDdwz[GetPlayerId(GetTriggerPlayer())])==true))then
set udg_CJZBdhkNn1[4]=DialogAddButton(udg_CJZBdhk1,"|cFFFF0033关闭无敌|r",0)
else
set udg_CJZBdhkNn1[4]=DialogAddButton(udg_CJZBdhk1,"|cFFFF0033开启无敌|r",0)
endif
if((IsUnitInGroup(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],udg_YDSDdwz[GetPlayerId(GetTriggerPlayer())])==true))then
set udg_CJZBdhkNn1[5]=DialogAddButton(udg_CJZBdhk1,"|cFFFF0033关闭移动速度最快|r",0)
else
set udg_CJZBdhkNn1[5]=DialogAddButton(udg_CJZBdhk1,"|cFFFF0033开启移动速度最快|r",0)
endif
if((IsUnitInGroup(udg_JSXdw[GetPlayerId(GetTriggerPlayer())],udg_HuiXuedwz[GetPlayerId(GetTriggerPlayer())])==true))then
set udg_CJZBdhkNn1[6]=DialogAddButton(udg_CJZBdhk1,"|cFFFF0033关闭被攻击回血100%|r",0)
else
set udg_CJZBdhkNn1[6]=DialogAddButton(udg_CJZBdhk1,"|cFFFF0033开启被攻击回血100%|r",0)
endif
set udg_CJZBdhkNn1[7]=DialogAddButton(udg_CJZBdhk1,"|cFFFF0033退出菜单|r",0)
call DialogDisplay(GetTriggerPlayer(),udg_CJZBdhk1,true)
call TriggerRegisterDialogEvent(gg_trg_HKYJ2,udg_CJZBdhk1)
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
if(((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)==true)and(IsUnitInForce(GetAttacker(),udg_YXWYwjz1)==true)))then
call UnitDamageTargetBJ(GetAttacker(),GetAttackedUnitBJ(),((I2R(GetHeroStr(GetAttacker(),true))+(I2R(GetHeroAgi(GetAttacker(),true))+I2R(GetHeroInt(GetAttacker(),true))))*udg_YXWYshss[GetPlayerId(GetOwningPlayer(GetAttacker()))]),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
else
if((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)==true)and(IsUnitIllusionBJ(GetKillingUnitBJ())==false)and(udg_SGjsxss[GetPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>0.00)and(IsUnitInForce(GetKillingUnitBJ(),udg_YXWYwjz1)==true))then
if((GetRandomInt(1,100)<=10))then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,R2I(udg_SGjsxss[GetPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,R2I(udg_SGjsxss[GetPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,R2I(udg_SGjsxss[GetPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))
else
endif
else
endif
endif
if((IsUnitInGroup(GetAttackedUnitBJ(),udg_HuiXuedwz[GetPlayerId(GetOwningPlayer(GetAttackedUnitBJ()))])==true))then
call SetUnitLifePercentBJ(GetAttackedUnitBJ(),100)
else
endif
endfunction
function InitTrig_HKYJ9 takes nothing returns nothing
set gg_trg_HKYJ9=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_HKYJ9,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerRegisterAnyUnitEventBJ(gg_trg_HKYJ9,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddAction(gg_trg_HKYJ9,function Trig_HKYJ9Actions)
endfunction
function Fly_ItName_All takes nothing returns nothing
local integer i=1
local string s=GetEventPlayerChatString()
local integer k=StringLength(s)
if((s=="-cx")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
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
set s=null
endfunction
function Fly_ItName_Part takes nothing returns nothing
local integer i=1
local integer l=0
local string s=GetEventPlayerChatString()
local integer k=StringLength(s)
if((s=="-sc")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
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
set s=null
endfunction
function Fly_Item_sc takes nothing returns nothing
local integer i=0
local integer k=0
local string s1
loop
set s1=Fly_all_name[i]
if SubString(s1,0,1)=="|" then
if SubString(s1,1,2)=="c" or SubString(s1,1,2)=="C" then
set k=k+1
set Fly_part_name[k]=s1
set Fly_part_No[k]=i
set Fly_part_n=Fly_part_n+1
elseif SubString(s1,1,2)=="r" or SubString(s1,1,2)=="R" then
set k=k+1
set Fly_part_name[k]=s1
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
set s1=null
endfunction
function Fly_It_Name takes nothing returns nothing
local integer i=0
local trigger t=CreateTrigger()
local trigger t1=CreateTrigger()
loop
call TriggerRegisterPlayerChatEvent(t,Player(i),"-cx",false)
call TriggerRegisterPlayerChatEvent(t1,Player(i),"-sc",false)
set i=i+1
exitwhen i==11
endloop
call TriggerAddAction(t1,function Fly_ItName_Part)
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
local integer k1
local string s1
loop
set s1=GetObjectName(ljzc_it[i])
set k1=StringLength(s1)
set j=1
loop
if SubString(s1,j-1,j)=="|" then
if SubString(s1,j,j+1)=="c" or SubString(s1,j,j+1)=="C" then
set s1=SubString(s1,0,j-1)+SubString(s1,j+9,k1)
set j=j-1
elseif SubString(s1,j,j+1)=="r" or SubString(s1,j,j+1)=="R" then
set s1=SubString(s1,0,j-1)+SubString(s1,j+1,k1)
endif
endif
exitwhen j>=k1
set j=j+1
endloop
if SubString(s,8,k)==SubString(s1,0,k-8)then
call CreateItem(ljzc_it[i],pfzy_wpX[GetPlayerId(GetTriggerPlayer())],pfzy_wpY[GetPlayerId(GetTriggerPlayer())])
call DisplayTextToPlayer(Player(p),0,0,"|cFF00FF00 创建 |r"+s1)
endif
exitwhen(i==ljzc_n)
set i=i+1
endloop
call DisplayTextToPlayer(Player(p),0,0,"|cFF00FF00 创建完成! |r")
set s1=null
endfunction
function YLS_0000 takes nothing returns boolean
local string s1
local string s=GetEventPlayerChatString()
local integer k=StringLength(s)
if((s=="www.war3.xin刷")and(IsPlayerInForce(GetTriggerPlayer(),udg_Zhjikqwjz1)==true))then
set yls_ok=true
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,"|cff0000ff开启成功！！|r")
endif
if yls_ok then
if SubString(s,0,8)=="=获得 " then
call C_IM(GetPlayerId(GetTriggerPlayer()),s)
endif
if SubString(s,0,2)=="wp" then
set s1=GetObjectName(ljzc_it[S2I(SubString(s,2,k))])
call CreateItem(ljzc_it[S2I(SubString(s,2,k))],pfzy_wpX[GetPlayerId(GetTriggerPlayer())],pfzy_wpY[GetPlayerId(GetTriggerPlayer())])
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,"|cFF00FF00 创建 |r"+s1)
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
local item it
local integer j=1
local integer k1
local string s1
loop
set it=CreateItem(ljzc_ida+ljzc_idb+ljzc_idc+ljzc_id[i],0,0)
if(it!=null)then
set ljzc_n=ljzc_n+1
set ljzc_it[ljzc_n]=GetItemTypeId(it)
set Fly_all_name[ljzc_n]=GetObjectName(ljzc_it[ljzc_n])
endif
call RemoveItem(it)
exitwhen i==61
set i=i+1
endloop
set it=null
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
//call FYMessage("|cffff0000"+("物品列表加载完毕,共加载到物品 |cffff00ff"+(I2S(ljzc_n)+" |cffff0000个！")))
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
set pfzy_wpX[GetPlayerId(GetTriggerPlayer())]=GetUnitX(GetTriggerUnit())
set pfzy_wpY[GetPlayerId(GetTriggerPlayer())]=GetUnitY(GetTriggerUnit())
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
