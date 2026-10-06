function War3Sucai_Globals takes nothing returns nothing
local integer i=0
set i=0
loop
exitwhen(i>1)
set udg_War3Sucaidhk[i]=DialogCreate()
set i=i+1
endloop
set i=0
loop
exitwhen(i>1)
set udg_War3Sucaianniubiaoti[i]=""
set i=i+1
endloop
set i=0
loop
exitwhen(i>1)
set udg_War3Sucaiwanjiayanse[i]=""
set i=i+1
endloop
set udg_War3Sucaijingyanbeishu=0
endfunction
function Trig_War3Sucaichushihua_Func013Func001C takes nothing returns boolean
if(not(GetPlayerController(ConvertedPlayer(bj_forLoopAIndex))==MAP_CONTROL_USER))then
return false
endif
return true
endfunction
function Trig_War3Sucaichushihua_Actions takes nothing returns nothing
set udg_War3Sucaiwanjiayanse[1]=("|cffff0000"+(GetPlayerName(Player(0))+"|r"))
set udg_War3Sucaiwanjiayanse[2]=("|cff0041ff"+(GetPlayerName(Player(1))+"|r"))
set udg_War3Sucaiwanjiayanse[3]=("|cff1be5b8"+(GetPlayerName(Player(2))+"|r"))
set udg_War3Sucaiwanjiayanse[4]=("|cff530080"+(GetPlayerName(Player(3))+"|r"))
set udg_War3Sucaiwanjiayanse[5]=("|cfffffc00"+(GetPlayerName(Player(4))+"|r"))
set udg_War3Sucaiwanjiayanse[6]=("|cfffe890d"+(GetPlayerName(Player(5))+"|r"))
set udg_War3Sucaiwanjiayanse[7]=("|cff1fbf00"+(GetPlayerName(Player(6))+"|r"))
set udg_War3Sucaiwanjiayanse[8]=("|cffe45aaf"+(GetPlayerName(Player(7))+"|r"))
set udg_War3Sucaiwanjiayanse[9]=("|cff949596"+(GetPlayerName(Player(8))+"|r"))
set udg_War3Sucaiwanjiayanse[10]=("|cff7dbef0"+(GetPlayerName(Player(9))+"|r"))
set udg_War3Sucaiwanjiayanse[11]=("|cff0f6145"+(GetPlayerName(Player(10))+"|r"))
set udg_War3Sucaiwanjiayanse[12]=("|cff4d2903"+(GetPlayerName(Player(11))+"|r"))
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(Trig_War3Sucaichushihua_Func013Func001C())then
set udg_War3Sucaiwanjia=ConvertedPlayer(bj_forLoopAIndex)
call SetForLoopIndexA(13)
else
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function InitTrig_War3Sucaichushihua takes nothing returns nothing
set gg_trg_War3Sucaichushihua=CreateTrigger()
call TriggerRegisterTimerEventSingle(gg_trg_War3Sucaichushihua,1.23)
call TriggerAddAction(gg_trg_War3Sucaichushihua,function Trig_War3Sucaichushihua_Actions)
endfunction
function Trig_War3Sucaidhk1_Conditions takes nothing returns boolean
if(not(GetOwningPlayer(GetTriggerUnit())==udg_War3Sucaiwanjia))then
return false
endif
return true
endfunction
function Trig_War3Sucaidhk1_Func002002001 takes nothing returns boolean
return(GetOwningPlayer(GetTriggerUnit())==udg_War3Sucaiwanjia)
endfunction
function Trig_War3Sucaidhk1_Actions takes nothing returns nothing
call CinematicModeBJ(true,GetPlayersAll())
call CinematicModeBJ(false,GetPlayersMatching(Condition(function Trig_War3Sucaidhk1_Func002002001)))
set udg_War3Sucaianniubiaoti[1]=("【无CD模式】"+"")
set udg_War3Sucaianniubiaoti[2]=("【无限蓝模式】"+"")
set udg_War3Sucaianniubiaoti[3]=("【杀怪涨属性模式】"+"")
set udg_War3Sucaianniubiaoti[4]=("【|cFF00FF33基地快速回血模式|r】\n（此模式不是万能的，请大家注意……）"+"")
set udg_War3Sucaianniubiaoti[5]=("【P键（或者M键）开全图模式】"+"")
set udg_War3Sucaianniubiaoti[6]=("【|cFFFF0000魔道模式|r】\n（为了游戏的平衡，建议不要开启此模式！！！）"+"")
set udg_War3Sucaianniubiaoti[7]=("【设置经验倍数模式(jingyan=(1-100))】"+"")
set udg_War3Sucaianniubiaoti[8]=""
set udg_War3Sucaianniubiaoti[9]=""
set udg_War3Sucaianniubiaoti[10]=""
set udg_War3Sucaianniubiaoti[11]=("【选择完毕】"+"")
call DisableTrigger(gg_trg_War3Sucaiwucd)
call DisableTrigger(gg_trg_War3Sucaiwucd2)
call DisableTrigger(gg_trg_War3SuCaiKusujiashuxing)
call DisableTrigger(gg_trg_War3Sucaijidiwuyou)
call DisableTrigger(gg_trg_War3Sucaimpshan)
call DisableTrigger(gg_trg_War3Sucaijingyan)
call ConditionalTriggerExecute(gg_trg_War3Sucaidhk2)
call DisableTrigger(GetTriggeringTrigger())
call DisplayTextToForce(GetPlayersAll(),(("等待 "+udg_War3Sucaiwanjiayanse[GetConvertedPlayerId(GetTriggerPlayer())])+"  选择要开启的模式，如需要其他版本的图请来【|cFFFF0000素|r|cFF0041FF菜|r|cFF1BE6B8魔|r|cFF530080兽|r】查找··下载"))
call DisplayTextToForce(GetPlayersAll(),(("如果玩家 "+udg_War3Sucaiwanjiayanse[GetConvertedPlayerId(GetTriggerPlayer())])+"  直接选择完毕，则不开启任何模式"))
endfunction
function InitTrig_War3Sucaidhk1 takes nothing returns nothing
set gg_trg_War3Sucaidhk1=CreateTrigger()
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_War3Sucaidhk1,Player(0),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_War3Sucaidhk1,Player(1),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_War3Sucaidhk1,Player(2),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_War3Sucaidhk1,Player(3),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_War3Sucaidhk1,Player(4),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_War3Sucaidhk1,Player(5),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_War3Sucaidhk1,Player(6),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_War3Sucaidhk1,Player(7),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_War3Sucaidhk1,Player(8),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_War3Sucaidhk1,Player(9),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_War3Sucaidhk1,Player(10),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_War3Sucaidhk1,Player(11),true)
call TriggerAddCondition(gg_trg_War3Sucaidhk1,Condition(function Trig_War3Sucaidhk1_Conditions))
call TriggerAddAction(gg_trg_War3Sucaidhk1,function Trig_War3Sucaidhk1_Actions)
endfunction
function Trig_War3Sucaidhk2_Func003Func001C takes nothing returns boolean
if(not(udg_War3Sucaianniubiaoti[bj_forLoopAIndex]!=""))then
return false
endif
return true
endfunction
function Trig_War3Sucaidhk2_Actions takes nothing returns nothing
call DialogClear(udg_War3Sucaidhk[1])
call DialogSetMessage(udg_War3Sucaidhk[1],("|cffff0000           【素菜娱乐版】  |cFF00FF33|r|R\n论坛地址：|Rw|cFF802080a|r|cFF0041FFr|r|cFF0E94DC3|r|cFF1BE6B8s|r|cFF37739Cu|r|cFF530080c|r|cFFA98040a|r|cFFFFFF00i|r|cFFFECF6C.|r|cFFFE9FD85|r|cFF8EAF6CD|r|cFF1FBF006|r|cFF828C58D|r|cFFE55AAF.|r|cFFBC78A2n|r|cFF949596e|r|cFF88AAC4t|r"+""))
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(Trig_War3Sucaidhk2_Func003Func001C())then
set udg_War3Sucaianniu[bj_forLoopAIndex]=DialogAddButton(udg_War3Sucaidhk[1],udg_War3Sucaianniubiaoti[bj_forLoopAIndex],0)
else
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call DialogDisplay(udg_War3Sucaiwanjia,udg_War3Sucaidhk[1],true)
endfunction
function InitTrig_War3Sucaidhk2 takes nothing returns nothing
set gg_trg_War3Sucaidhk2=CreateTrigger()
call TriggerAddAction(gg_trg_War3Sucaidhk2,function Trig_War3Sucaidhk2_Actions)
endfunction
function Trig_War3Sucaixuanz_Func001C takes nothing returns boolean
if(not(udg_War3Sucaianniu[11]==GetClickedButtonBJ()))then
return false
endif
return true
endfunction
function Trig_War3Sucaixuanz_Func002C takes nothing returns boolean
if(not(udg_War3Sucaianniu[1]==GetClickedButtonBJ()))then
return false
endif
return true
endfunction
function Trig_War3Sucaixuanz_Func003C takes nothing returns boolean
if(not(udg_War3Sucaianniu[2]==GetClickedButtonBJ()))then
return false
endif
return true
endfunction
function Trig_War3Sucaixuanz_Func004C takes nothing returns boolean
if(not(udg_War3Sucaianniu[3]==GetClickedButtonBJ()))then
return false
endif
return true
endfunction
function Trig_War3Sucaixuanz_Func005C takes nothing returns boolean
if(not(udg_War3Sucaianniu[4]==GetClickedButtonBJ()))then
return false
endif
return true
endfunction
function Trig_War3Sucaixuanz_Func006C takes nothing returns boolean
if(not(udg_War3Sucaianniu[5]==GetClickedButtonBJ()))then
return false
endif
return true
endfunction
function Trig_War3Sucaixuanz_Func007C takes nothing returns boolean
if(not(udg_War3Sucaianniu[6]==GetClickedButtonBJ()))then
return false
endif
return true
endfunction
function Trig_War3Sucaixuanz_Func008C takes nothing returns boolean
if(not(udg_War3Sucaianniu[7]==GetClickedButtonBJ()))then
return false
endif
return true
endfunction
function Trig_War3Sucaixuanz_Actions takes nothing returns nothing
if(Trig_War3Sucaixuanz_Func001C())then
call DisplayTextToForce(GetPlayersAll(),(udg_War3Sucaiwanjiayanse[GetConvertedPlayerId(GetTriggerPlayer())]+"  已选择完成\n|cFFFF0000祝大家游戏轻松愉快，欢迎有空常来【素菜魔兽】论坛下图！灌水···"))
call DialogClear(udg_War3Sucaidhk[1])
call CinematicModeBJ(false,GetPlayersAll())
else
endif
if(Trig_War3Sucaixuanz_Func002C())then
call DisplayTextToForce(GetPlayersAll(),(udg_War3Sucaiwanjiayanse[GetConvertedPlayerId(GetTriggerPlayer())]+("  开启了 |cffff0000"+(udg_War3Sucaianniubiaoti[1]+"|r"))))
set udg_War3Sucaianniubiaoti[1]=""
call EnableTrigger(gg_trg_War3Sucaiwucd)
call EnableTrigger(gg_trg_War3Sucaiwucd2)
call ConditionalTriggerExecute(gg_trg_War3Sucaidhk2)
else
endif
if(Trig_War3Sucaixuanz_Func003C())then
call DisplayTextToForce(GetPlayersAll(),(udg_War3Sucaiwanjiayanse[GetConvertedPlayerId(GetTriggerPlayer())]+("  开启了 |cffff0000"+(udg_War3Sucaianniubiaoti[2]+"|r"))))
set udg_War3Sucaianniubiaoti[2]=""
call EnableTrigger(gg_trg_War3Sucaiwucd)
call ConditionalTriggerExecute(gg_trg_War3Sucaidhk2)
else
endif
if(Trig_War3Sucaixuanz_Func004C())then
call DisplayTextToForce(GetPlayersAll(),(udg_War3Sucaiwanjiayanse[GetConvertedPlayerId(GetTriggerPlayer())]+("  开启了 |cffff0000"+(udg_War3Sucaianniubiaoti[3]+"|r"))))
set udg_War3Sucaianniubiaoti[3]=""
call EnableTrigger(gg_trg_War3SuCaiKusujiashuxing)
call ConditionalTriggerExecute(gg_trg_War3Sucaidhk2)
else
endif
if(Trig_War3Sucaixuanz_Func005C())then
call DisplayTextToForce(GetPlayersAll(),(udg_War3Sucaiwanjiayanse[GetConvertedPlayerId(GetTriggerPlayer())]+("  开启了 |cffff0000"+(udg_War3Sucaianniubiaoti[4]+"|r"))))
set udg_War3Sucaianniubiaoti[4]=""
call EnableTrigger(gg_trg_War3Sucaijidiwuyou)
call ConditionalTriggerExecute(gg_trg_War3Sucaidhk2)
else
endif
if(Trig_War3Sucaixuanz_Func006C())then
call DisplayTextToForce(GetPlayersAll(),(udg_War3Sucaiwanjiayanse[GetConvertedPlayerId(GetTriggerPlayer())]+("  开启了 |cffff0000"+(udg_War3Sucaianniubiaoti[5]+"|r"))))
set udg_War3Sucaianniubiaoti[5]=""
call EnableTrigger(gg_trg_War3Sucaimpshan)
call ConditionalTriggerExecute(gg_trg_War3Sucaidhk2)
else
endif
if(Trig_War3Sucaixuanz_Func007C())then
call DisplayTextToForce(GetPlayersAll(),(udg_War3Sucaiwanjiayanse[GetConvertedPlayerId(GetTriggerPlayer())]+("  开启了 |cffff0000"+(udg_War3Sucaianniubiaoti[6]+"|r"))))
set udg_War3Sucaianniubiaoti[6]=""
call EnableTrigger(gg_trg_xwzxwz81)
call ConditionalTriggerExecute(gg_trg_War3Sucaidhk2)
else
endif
if(Trig_War3Sucaixuanz_Func008C())then
call DisplayTextToForce(GetPlayersAll(),(udg_War3Sucaiwanjiayanse[GetConvertedPlayerId(GetTriggerPlayer())]+("  开启了 |cffff0000"+(udg_War3Sucaianniubiaoti[7]+"|r"))))
set udg_War3Sucaianniubiaoti[7]=""
call EnableTrigger(gg_trg_War3Sucaijingyan)
call ConditionalTriggerExecute(gg_trg_War3Sucaidhk2)
else
endif
endfunction
function InitTrig_War3Sucaixuanz takes nothing returns nothing
set gg_trg_War3Sucaixuanz=CreateTrigger()
call TriggerRegisterDialogEventBJ(gg_trg_War3Sucaixuanz,udg_War3Sucaidhk[1])
call TriggerAddAction(gg_trg_War3Sucaixuanz,function Trig_War3Sucaixuanz_Actions)
endfunction
function Trig_War3Sucaiwucd_Conditions takes nothing returns boolean
if(not(GetPlayerController(GetTriggerPlayer())==MAP_CONTROL_USER))then
return false
endif
return true
endfunction
function Trig_War3Sucaiwucd_Func003001 takes nothing returns boolean
return(udg_War3Sucaianniubiaoti[1]=="")
endfunction
function Trig_War3Sucaiwucd_Func004001 takes nothing returns boolean
return(udg_War3Sucaianniubiaoti[2]=="")
endfunction
function Trig_War3Sucaiwucd_Actions takes nothing returns nothing
call PolledWait(0.01)
if(Trig_War3Sucaiwucd_Func003001())then
call UnitResetCooldown(GetTriggerUnit())
else
call DoNothing()
endif
if(Trig_War3Sucaiwucd_Func004001())then
call SetUnitManaPercentBJ(GetTriggerUnit(),100)
else
call DoNothing()
endif
endfunction
function InitTrig_War3Sucaiwucd takes nothing returns nothing
set gg_trg_War3Sucaiwucd=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_War3Sucaiwucd,EVENT_PLAYER_UNIT_SPELL_CHANNEL)
call TriggerRegisterAnyUnitEventBJ(gg_trg_War3Sucaiwucd,EVENT_PLAYER_UNIT_SPELL_CAST)
call TriggerRegisterAnyUnitEventBJ(gg_trg_War3Sucaiwucd,EVENT_PLAYER_UNIT_SPELL_EFFECT)
call TriggerRegisterAnyUnitEventBJ(gg_trg_War3Sucaiwucd,EVENT_PLAYER_UNIT_SPELL_FINISH)
call TriggerAddCondition(gg_trg_War3Sucaiwucd,Condition(function Trig_War3Sucaiwucd_Conditions))
call TriggerAddAction(gg_trg_War3Sucaiwucd,function Trig_War3Sucaiwucd_Actions)
endfunction
function Trig_War3Sucaiwucd2_Conditions takes nothing returns boolean
if(not(GetPlayerController(GetTriggerPlayer())==MAP_CONTROL_USER))then
return false
endif
return true
endfunction
function Trig_War3Sucaiwucd2_Actions takes nothing returns nothing
call IssueImmediateOrder(GetTriggerUnit(),"stop")
endfunction
function InitTrig_War3Sucaiwucd2 takes nothing returns nothing
set gg_trg_War3Sucaiwucd2=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_War3Sucaiwucd2,EVENT_PLAYER_UNIT_SPELL_ENDCAST)
call TriggerAddCondition(gg_trg_War3Sucaiwucd2,Condition(function Trig_War3Sucaiwucd2_Conditions))
call TriggerAddAction(gg_trg_War3Sucaiwucd2,function Trig_War3Sucaiwucd2_Actions)
endfunction
function Trig_War3SuCaiKusujiashuxing_Func001Func003Func001Func001Func001Func007C takes nothing returns boolean
return(300<udg_War3SuCaiKususuijishu)and(310>=udg_War3SuCaiKususuijishu)and(IsUnitType(GetKillingUnit(),UNIT_TYPE_HERO))and(IsUnitEnemy(GetDyingUnit(),Player(-1+(bj_forLoopAIndex))))
endfunction
function Trig_War3SuCaiKusujiashuxing_Func001Func003Func001Func001Func001C takes nothing returns boolean
return(Trig_War3SuCaiKusujiashuxing_Func001Func003Func001Func001Func001Func007C())
endfunction
function Trig_War3SuCaiKusujiashuxing_Func001Func003Func001Func001Func008C takes nothing returns boolean
return(200<udg_War3SuCaiKususuijishu)and(204>=udg_War3SuCaiKususuijishu)and(IsUnitType(GetKillingUnit(),UNIT_TYPE_HERO))and(IsUnitEnemy(GetDyingUnit(),Player(-1+(bj_forLoopAIndex))))
endfunction
function Trig_War3SuCaiKusujiashuxing_Func001Func003Func001Func001C takes nothing returns boolean
return(Trig_War3SuCaiKusujiashuxing_Func001Func003Func001Func001Func008C())
endfunction
function Trig_War3SuCaiKusujiashuxing_Func001Func003Func001Func008C takes nothing returns boolean
return('d'<udg_War3SuCaiKususuijishu)and('h'>=udg_War3SuCaiKususuijishu)and(IsUnitType(GetKillingUnit(),UNIT_TYPE_HERO))and(IsUnitEnemy(GetDyingUnit(),Player(-1+(bj_forLoopAIndex))))
endfunction
function Trig_War3SuCaiKusujiashuxing_Func001Func003Func001C takes nothing returns boolean
return(Trig_War3SuCaiKusujiashuxing_Func001Func003Func001Func008C())
endfunction
function Trig_War3SuCaiKusujiashuxing_Func001Func003Func008C takes nothing returns boolean
return(4>=udg_War3SuCaiKususuijishu)and(IsUnitType(GetKillingUnit(),UNIT_TYPE_HERO))and(IsUnitEnemy(GetDyingUnit(),Player(-1+(bj_forLoopAIndex))))
endfunction
function Trig_War3SuCaiKusujiashuxing_Func001Func003C takes nothing returns boolean
return(Trig_War3SuCaiKusujiashuxing_Func001Func003Func008C())
endfunction
function Trig_War3SuCaiKusujiashuxing_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=6
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_War3SuCaiKusushuijishuxing=GetRandomInt(10,100) //这里10和100可以自己改
set udg_War3SuCaiKususuijishu=GetRandomInt(1,400)  //这里400可以自己改
if(Trig_War3SuCaiKusujiashuxing_Func001Func003C())then
set udg_War3SuCaiKusujialiliang111=(R2I(SquareRoot(I2R(GetHeroLevel(GetKillingUnit()))))*R2I(SquareRoot(I2R(udg_War3SuCaiKusushuijishuxing))))
call ModifyHeroStat(0,GetKillingUnit(),0,udg_War3SuCaiKusujialiliang111)
call CreateTextTagUnitBJ(("+力量"+I2S(udg_War3SuCaiKusujialiliang111)),GetKillingUnit(),0,15.,.0,'d','d',0)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,90.,GetRandomReal(0,360))
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
else
if(Trig_War3SuCaiKusujiashuxing_Func001Func003Func001C())then
set udg_War3SuCaiKusujiaminjie111=(R2I(SquareRoot(I2R(GetHeroLevel(GetKillingUnit()))))*R2I(SquareRoot(I2R(udg_War3SuCaiKusushuijishuxing))))
call ModifyHeroStat(1,GetKillingUnit(),0,udg_War3SuCaiKusujiaminjie111)
call CreateTextTagUnitBJ(("+敏捷"+I2S(udg_War3SuCaiKusujiaminjie111)),GetKillingUnit(),0,15.,100.,.0,'d',0)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,90.,GetRandomReal(0,360))
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
else
if(Trig_War3SuCaiKusujiashuxing_Func001Func003Func001Func001C())then
set udg_War3SuCaiKusujiazhili111=(R2I(SquareRoot(I2R(GetHeroLevel(GetKillingUnit()))))*R2I(SquareRoot(I2R(udg_War3SuCaiKusushuijishuxing))))
call ModifyHeroStat(2,GetKillingUnit(),0,udg_War3SuCaiKusujiazhili111)
call CreateTextTagUnitBJ(("+智力"+I2S(udg_War3SuCaiKusujiazhili111)),GetKillingUnit(),0,15.,100.,100.,.0,0)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,90.,GetRandomReal(0,360))
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
else
if(Trig_War3SuCaiKusujiashuxing_Func001Func003Func001Func001Func001C())then
set udg_War3SuCaiKusujiaqian=(2*udg_War3SuCaiKusushuijishuxing*GetHeroLevel(GetKillingUnit())) //这里10可以自己改
call AdjustPlayerStateBJ(udg_War3SuCaiKusujiaqian,GetOwningPlayer(GetKillingUnit()),PLAYER_STATE_RESOURCE_GOLD)
call CreateTextTagUnitBJ(("+金钱"+I2S(udg_War3SuCaiKusujiaqian)),GetKillingUnit(),0,15.,100.,33.,88.,0)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,90.,GetRandomReal(0,360))
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
endif
endif
endif
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endfunction
function Trig_War3Sucaijidiwuyou_Func002C takes nothing returns boolean
return(GetPlayerController(Player(0))==MAP_CONTROL_USER)or(GetPlayerController(Player(1))==MAP_CONTROL_USER)or(GetPlayerController(Player(2))==MAP_CONTROL_USER)or(GetPlayerController(Player(3))==MAP_CONTROL_USER)
endfunction
function Trig_War3Sucaijidiwuyou_Func005C takes nothing returns boolean
return(IsUnitAlly(GetTriggerUnit(),Player(0)))or(IsUnitAlly(GetTriggerUnit(),Player(1)))or(IsUnitAlly(GetTriggerUnit(),Player(2)))or(IsUnitAlly(GetTriggerUnit(),Player(3)))
endfunction
function Trig_War3Sucaijidiwuyou_Func006C takes nothing returns boolean
return(GetPlayerController(GetOwningPlayer(GetAttacker()))==MAP_CONTROL_COMPUTER)or(GetPlayerController(GetOwningPlayer(GetAttacker()))==MAP_CONTROL_CREEP)
endfunction
function Trig_War3Sucaijidiwuyou_Conditions takes nothing returns boolean
return(Trig_War3Sucaijidiwuyou_Func002C())and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_STRUCTURE))and(GetPlayerController(GetOwningPlayer(GetTriggerUnit()))==MAP_CONTROL_COMPUTER)and(Trig_War3Sucaijidiwuyou_Func005C())and(Trig_War3Sucaijidiwuyou_Func006C())
endfunction
function Trig_War3Sucaijidiwuyou_Actions takes nothing returns nothing
local unit uliubo=GetTriggerUnit()
call SetUnitLifePercentBJ(uliubo,'d')
set uliubo=null
endfunction
function Trig_War3Sucaimpshan_Func001C takes nothing returns boolean
if((GetIssuedOrderIdBJ()==String2OrderIdBJ("patrol")))then
return true
endif
if((GetIssuedOrderIdBJ()==String2OrderIdBJ("move")))then
return true
endif
return false
endfunction
function Trig_War3Sucaimpshan_Conditions takes nothing returns boolean
if(not Trig_War3Sucaimpshan_Func001C())then
return false
endif
return true
endfunction
function Trig_War3Sucaimpshan_Func002001 takes nothing returns boolean
return(GetPlayerController(GetTriggerPlayer())==MAP_CONTROL_USER)
endfunction
function Trig_War3Sucaimpshan_Actions takes nothing returns nothing
if(Trig_War3Sucaimpshan_Func002001())then
call FogEnableOff()    
call FogMaskEnableOff()
call SetUnitPositionLoc(GetTriggerUnit(),GetOrderPointLoc())
else
call DoNothing()
endif
endfunction
function InitTrig_War3Sucaimpshan takes nothing returns nothing
set gg_trg_War3Sucaimpshan=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_War3Sucaimpshan,EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
call TriggerAddCondition(gg_trg_War3Sucaimpshan,Condition(function Trig_War3Sucaimpshan_Conditions))
call TriggerAddAction(gg_trg_War3Sucaimpshan,function Trig_War3Sucaimpshan_Actions)
call DisableTrigger(gg_trg_xwzxwz81)
endfunction
function Trig_War3Sucaijingyan_Conditions takes nothing returns boolean
if(not(GetTriggerPlayer()==udg_War3Sucaiwanjia))then
return false
endif
return true
endfunction
function Trig_War3Sucaijingyan_Func002Func001Func001C takes nothing returns boolean
if(not(GetPlayerController(ConvertedPlayer(bj_forLoopAIndex))==MAP_CONTROL_USER))then
return false
endif
return true
endfunction
function Trig_War3Sucaijingyan_Func002Func004C takes nothing returns boolean
if((udg_War3Sucaijingyanbeishu<1.00))then
return true
endif
if((udg_War3Sucaijingyanbeishu>100.00))then
return true
endif
return false
endfunction
function Trig_War3Sucaijingyan_Func002C takes nothing returns boolean
if(not Trig_War3Sucaijingyan_Func002Func004C())then
return false
endif
return true
endfunction
function Trig_War3Sucaijingyan_Actions takes nothing returns nothing
set udg_War3Sucaijingyanbeishu=S2R(SubStringBJ(GetEventPlayerChatString(),9,StringLength(GetEventPlayerChatString())))
if(Trig_War3Sucaijingyan_Func002C())then
call DisplayTextToForce(GetPlayersAll(),(udg_War3Sucaiwanjiayanse[GetConvertedPlayerId(GetTriggerPlayer())]+"   经验设置失败，请设置 |cffff00ff1 - 100|r 之间的，如 |cffff00ffjingyan=100|r"))
else
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if(Trig_War3Sucaijingyan_Func002Func001Func001C())then
call SetPlayerHandicapXP(ConvertedPlayer(bj_forLoopAIndex),udg_War3Sucaijingyanbeishu)
else
endif
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call DisplayTextToForce(GetPlayersAll(),(udg_War3Sucaiwanjiayanse[GetConvertedPlayerId(GetTriggerPlayer())]+("  已成功将经验倍数设置成普通的 |cffff00ff"+(I2S(R2I(udg_War3Sucaijingyanbeishu))+" |r倍 【本功能只能设置一次】"))))
endif
endfunction
function InitTrig_War3Sucaijingyan takes nothing returns nothing
set gg_trg_War3Sucaijingyan=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_War3Sucaijingyan,Player(0),"jingyan=",false)
call TriggerRegisterPlayerChatEvent(gg_trg_War3Sucaijingyan,Player(1),"jingyan=",false)
call TriggerRegisterPlayerChatEvent(gg_trg_War3Sucaijingyan,Player(2),"jingyan=",false)
call TriggerRegisterPlayerChatEvent(gg_trg_War3Sucaijingyan,Player(3),"jingyan=",false)
call TriggerRegisterPlayerChatEvent(gg_trg_War3Sucaijingyan,Player(4),"jingyan=",false)
call TriggerRegisterPlayerChatEvent(gg_trg_War3Sucaijingyan,Player(5),"jingyan=",false)
call TriggerRegisterPlayerChatEvent(gg_trg_War3Sucaijingyan,Player(6),"jingyan=",false)
call TriggerRegisterPlayerChatEvent(gg_trg_War3Sucaijingyan,Player(7),"jingyan=",false)
call TriggerRegisterPlayerChatEvent(gg_trg_War3Sucaijingyan,Player(8),"jingyan=",false)
call TriggerRegisterPlayerChatEvent(gg_trg_War3Sucaijingyan,Player(9),"jingyan=",false)
call TriggerRegisterPlayerChatEvent(gg_trg_War3Sucaijingyan,Player(10),"jingyan=",false)
call TriggerRegisterPlayerChatEvent(gg_trg_War3Sucaijingyan,Player(11),"jingyan=",false)
call TriggerAddCondition(gg_trg_War3Sucaijingyan,Condition(function Trig_War3Sucaijingyan_Conditions))
call TriggerAddAction(gg_trg_War3Sucaijingyan,function Trig_War3Sucaijingyan_Actions)
endfunction
function Trig_xwzxwz2_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_xwzxwz3)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_xwzxwz3)
endfunction
function Trig_xwzxwz3_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_xwzxwz4)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_xwzxwz4)
endfunction
function Trig_xwzxwz4_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_xwzxwz5)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_xwzxwz5)
endfunction
function Trig_xwzxwz5_Actions takes nothing returns nothing
call EnableTrigger(gg_trg_xwzxwz6)
call TriggerSleepAction(0.30)
call DisableTrigger(gg_trg_xwzxwz6)
endfunction
function Trig_xwzxwz6_Actions takes nothing returns nothing
set udg_xwzxwz18[GetConvertedPlayerId(GetTriggerPlayer())]=true
call EnableTrigger(gg_trg_xwzxwz7)
call TriggerSleepAction(2.00)
call DisableTrigger(gg_trg_xwzxwz7)
endfunction
function Trig_xwzxwz7_Conditions takes nothing returns boolean
return ((GetOwningPlayer(GetTriggerUnit())==GetTriggerPlayer()))and((IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)))and((udg_xwzxwz18[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_xwzxwz7_Actions takes nothing returns nothing
call DisableTrigger(GetTriggeringTrigger())
set udg_xwzxwz29=0
set udg_xwzxwz25=true
set udg_xwzxwz24=true
set udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]=GetTriggerUnit()
call PauseUnitBJ(true,GetTriggerUnit())
call SetUnitInvulnerable(GetTriggerUnit(),true)
call AddSpecialEffectTargetUnitBJ("origin",GetTriggerUnit(),"Abilities\\Spells\\Demon\\DarkConversion\\ZombifyTarget.mdl")
call CreateTextTagUnitBJ("TRIGSTR_004",GetTriggerUnit(),0.00,50.00,100,60.00,100,30.00)
call RotateCameraAroundLocBJ(360.00,GetUnitLoc(GetTriggerUnit()),GetOwningPlayer(GetTriggerUnit()),4.70)
set udg_xwzxwz16=GetLastCreatedTextTag()
set udg_xwzxwz15=GetLastCreatedEffectBJ()
call TriggerSleepAction(5.00)
call ResetToGameCameraForPlayer(GetOwningPlayer(GetTriggerUnit()),0)
call DestroyTextTag(udg_xwzxwz16)
call DestroyEffect(udg_xwzxwz15)
call SetUnitVertexColorBJ(udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],15.00,15.00,15.00,0)
call SetUnitScalePercent(udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],110.00,110.00,110.00)
call PauseUnitBJ(false,udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])
call SetUnitInvulnerable(udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],false)
call EnableTrigger(gg_trg_xwzxwz8)
call EnableTrigger(gg_trg_xwzxwz10)
call EnableTrigger(gg_trg_xwzxwz14)
call EnableTrigger(gg_trg_xwzxwz9)
call EnableTrigger(gg_trg_xwzxwz11)
call EnableTrigger(gg_trg_xwzxwz1)
endfunction
function Trig_xwzxwz8_Conditions takes nothing returns boolean
return ((GetAttacker()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((udg_xwzxwz18[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))
endfunction
function Trig_xwzxwz8_Func002Func005001002003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz8_Func002Func005001002003002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz8_Func002Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz8_Func002Func005001002003001(),Trig_xwzxwz8_Func002Func005001002003002())
endfunction
function Trig_xwzxwz8_Func002Func005A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Units\\Demon\\Infernal\\InfernalBirth.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroAgi(GetAttacker(),true)))*GetRandomReal(1.00,10.00)),true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_ENHANCED,WEAPON_TYPE_WHOKNOWS)
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_xwzxwz8_Func002C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))
endfunction
function Trig_xwzxwz8_Func004Func005001002003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz8_Func004Func005001002003002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz8_Func004Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz8_Func004Func005001002003001(),Trig_xwzxwz8_Func004Func005001002003002())
endfunction
function Trig_xwzxwz8_Func004Func005A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Undead\\RaiseSkeletonWarrior\\RaiseSkeleton.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),((I2R(GetHeroLevel(GetAttacker()))*SquareRoot((I2R(GetHeroStr(GetAttacker(),true))+(I2R(GetHeroAgi(GetAttacker(),true))+I2R(GetHeroInt(GetAttacker(),true))))))*GetRandomReal(10.00,20.00)),true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_ENHANCED,WEAPON_TYPE_WHOKNOWS)
endfunction
function Trig_xwzxwz8_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=8))
endfunction
function Trig_xwzxwz8_Func006Func005001002003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz8_Func006Func005001002003002001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz8_Func006Func005001002003002002001 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz8_Func006Func005001002003002002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
endfunction
function Trig_xwzxwz8_Func006Func005001002003002002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz8_Func006Func005001002003002002001(),Trig_xwzxwz8_Func006Func005001002003002002002())
endfunction
function Trig_xwzxwz8_Func006Func005001002003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz8_Func006Func005001002003002001(),Trig_xwzxwz8_Func006Func005001002003002002())
endfunction
function Trig_xwzxwz8_Func006Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz8_Func006Func005001002003001(),Trig_xwzxwz8_Func006Func005001002003002())
endfunction
function Trig_xwzxwz8_Func006Func005A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitOwner(GetEnumUnit(),GetOwningPlayer(GetAttacker()),true)
call SetUnitVertexColorBJ(GetEnumUnit(),0.00,0.00,0.00,50.00)
call SetUnitMoveSpeed(GetEnumUnit(),500.00)
endfunction
function Trig_xwzxwz8_Func006C takes nothing returns boolean
return ((GetRandomInt(1,100)<=2))
endfunction
function Trig_xwzxwz8_Func008Func005001002003001 takes nothing returns boolean
return (IsUnitDeadBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz8_Func008Func005001002003002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==false)
endfunction
function Trig_xwzxwz8_Func008Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz8_Func008Func005001002003001(),Trig_xwzxwz8_Func008Func005001002003002())
endfunction
function Trig_xwzxwz8_Func008Func005Func009001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz8_Func008Func005Func009001003002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz8_Func008Func005Func009001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz8_Func008Func005Func009001003001(),Trig_xwzxwz8_Func008Func005Func009001003002())
endfunction
function Trig_xwzxwz8_Func008Func005Func009A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroAgi(GetAttacker(),true)))*GetRandomReal(1.00,5.00)),true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_ENHANCED,WEAPON_TYPE_WHOKNOWS)
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_xwzxwz8_Func008Func005A takes nothing returns nothing
set udg_xwzxwz20=GetEnumUnit()
set udg_xwzxwz19=GetUnitLoc(udg_xwzxwz20)
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Objects\\Spawnmodels\\Human\\HumanLargeDeathExplode\\HumanLargeDeathExplode.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Items\\AIre\\AIreTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(200.00,udg_xwzxwz19,Condition(function Trig_xwzxwz8_Func008Func005Func009001003)),function Trig_xwzxwz8_Func008Func005Func009A)
call RemoveUnit(udg_xwzxwz20)
call RemoveLocation(udg_xwzxwz19)
endfunction
function Trig_xwzxwz8_Func008C takes nothing returns boolean
return ((GetRandomInt(1,100)<=10))
endfunction
function Trig_xwzxwz8_Actions takes nothing returns nothing
if (Trig_xwzxwz8_Func002C()) then
call CreateTextTagUnitBJ(("|cFFFFFF00鬼魔地狱火|r"+"|cFF1FBF00发动！|r"),GetAttacker(),0,10,100,100,100,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(10,GetUnitsInRangeOfLocMatching(600.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_xwzxwz8_Func002Func005001002003))),function Trig_xwzxwz8_Func002Func005A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
return
endif
if (Trig_xwzxwz8_Func004C()) then
call CreateTextTagUnitBJ(("|cFFFFFF00邪恶突袭|r"+"|cFF1FBF00发动！|r"),GetAttacker(),0,10,100,100,100,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(16,GetUnitsInRangeOfLocMatching(700.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_xwzxwz8_Func004Func005001002003))),function Trig_xwzxwz8_Func004Func005A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
return
endif
if (Trig_xwzxwz8_Func006C()) then
endif
if (Trig_xwzxwz8_Func008C()) then
call CreateTextTagUnitBJ(("|cFFFFFF00鬼魔尸爆|r"+"|cFF1FBF00发动！|r"),GetAttacker(),0,10,100,100,100,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(10,GetUnitsInRangeOfLocMatching(700.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_xwzxwz8_Func008Func005001002003))),function Trig_xwzxwz8_Func008Func005A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
return
endif
endfunction
function Trig_xwzxwz9_Func004C takes nothing returns boolean
return ((GetKillingUnitBJ()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((udg_xwzxwz18[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetRandomInt(1,100)<=4))
endfunction
function Trig_xwzxwz9_Conditions takes nothing returns boolean
return (Trig_xwzxwz9_Func004C())
endfunction
function Trig_xwzxwz9_Actions takes nothing returns nothing
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,5)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,5)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,5)
endfunction
function Trig_xwzxwz10_Conditions takes nothing returns boolean
return ((GetTriggerUnit()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))and((udg_xwzxwz18[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))
endfunction
function Trig_xwzxwz10_Func002Func007001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz10_Func002Func007001003002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetTriggerUnit())))
endfunction
function Trig_xwzxwz10_Func002Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz10_Func002Func007001003001(),Trig_xwzxwz10_Func002Func007001003002())
endfunction
function Trig_xwzxwz10_Func002Func007A takes nothing returns nothing
set udg_xwzxwz22=(udg_xwzxwz22+1)
set udg_xwzxwz21[udg_xwzxwz22]=GetEnumUnit()
call PauseUnitBJ(true,GetEnumUnit())
set udg_xwzxwz23[udg_xwzxwz22]=AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Undead\\Darksummoning\\DarkSummonTarget.mdl")
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_xwzxwz10_Func002C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))and((udg_xwzxwz24))
endfunction
function Trig_xwzxwz10_Func004Func007001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz10_Func004Func007001003002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetTriggerUnit())))
endfunction
function Trig_xwzxwz10_Func004Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz10_Func004Func007001003001(),Trig_xwzxwz10_Func004Func007001003002())
endfunction
function Trig_xwzxwz10_Func004Func007A takes nothing returns nothing
set udg_xwzxwz26=(udg_xwzxwz26+1)
set udg_xwzxwz27[udg_xwzxwz26]=GetEnumUnit()
call PauseUnitBJ(true,GetEnumUnit())
set udg_xwzxwz28[udg_xwzxwz26]=AddLightningLoc("LEAS",GetUnitLoc(GetTriggerUnit()),GetUnitLoc(GetEnumUnit()))
call UnitDamageTarget(GetTriggerUnit(),GetEnumUnit(),((I2R(GetHeroLevel(GetTriggerUnit()))*I2R(GetHeroAgi(GetTriggerUnit(),true)))*GetRandomReal(2.00,5.00)),true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_ENHANCED,WEAPON_TYPE_WHOKNOWS)
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_xwzxwz10_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))and((udg_xwzxwz25))
endfunction
function Trig_xwzxwz10_Actions takes nothing returns nothing
if (Trig_xwzxwz10_Func002C()) then
call CreateTextTagUnitBJ(("|cFFFFFF00鬼魔反击之封印|r"+"|cFF1FBF00发动！|r"),GetAttacker(),0,10,100,100,100,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
set udg_xwzxwz24=false
set udg_xwzxwz22=0
call ForGroupBJ(GetUnitsInRangeOfLocMatching(600.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_xwzxwz10_Func002Func007001003)),function Trig_xwzxwz10_Func002Func007A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
call TriggerSleepAction(5.00)
call TriggerExecute(gg_trg_xwzxwz12)
return
endif
if (Trig_xwzxwz10_Func004C()) then
call CreateTextTagUnitBJ(("|cFFFFFF00鬼魔反击之困锁|r"+"|cFF1FBF00发动！|r"),GetAttacker(),0,10,100,100,100,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
set udg_xwzxwz25=false
set udg_xwzxwz26=0
call ForGroupBJ(GetUnitsInRangeOfLocMatching(600.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_xwzxwz10_Func004Func007001003)),function Trig_xwzxwz10_Func004Func007A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
call TriggerSleepAction(0.30)
call TriggerExecute(gg_trg_xwzxwz13)
endif
endfunction
function Trig_xwzxwz11_Conditions takes nothing returns boolean
return ((GetTriggerUnit()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))and((udg_xwzxwz18[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))
endfunction
function Trig_xwzxwz11_Actions takes nothing returns nothing
call ModifyHeroStat(bj_HEROSTAT_STR,GetTriggerUnit(),bj_MODIFYMETHOD_ADD,10)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetTriggerUnit(),bj_MODIFYMETHOD_ADD,10)
call ModifyHeroStat(bj_HEROSTAT_INT,GetTriggerUnit(),bj_MODIFYMETHOD_ADD,10)
endfunction
function Trig_xwzxwz12_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=udg_xwzxwz22
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call PauseUnitBJ(false,udg_xwzxwz21[GetForLoopIndexA()])
call DestroyEffect(udg_xwzxwz23[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set udg_xwzxwz24=true
call DisableTrigger(GetTriggeringTrigger())
endfunction
function Trig_xwzxwz13_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=udg_xwzxwz26
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyLightning(udg_xwzxwz28[GetForLoopIndexA()])
call PauseUnitBJ(false,udg_xwzxwz27[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set udg_xwzxwz25=true
call DisableTrigger(GetTriggeringTrigger())
endfunction
function Trig_xwzxwz14_Conditions takes nothing returns boolean
return ((GetTriggerUnit()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))and((GetIssuedOrderIdBJ()==String2OrderIdBJ("patrol")))and((udg_xwzxwz18[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))
endfunction
function Trig_xwzxwz14_Actions takes nothing returns nothing
call SetUnitPositionLoc(GetTriggerUnit(),GetOrderPointLoc())
endfunction
function Trig_xwzxwz1_Conditions takes nothing returns boolean
return ((udg_xwzxwz18[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_xwzxwz1_Actions takes nothing returns nothing
set udg_xwzxwz18[GetConvertedPlayerId(GetTriggerPlayer())]=false
call DisableTrigger(gg_trg_xwzxwz14)
call DisableTrigger(gg_trg_xwzxwz8)
call DisableTrigger(gg_trg_xwzxwz9)
call DisableTrigger(gg_trg_xwzxwz10)
call DisableTrigger(gg_trg_xwzxwz11)
call SetUnitVertexColorBJ(udg_xwzxwz17[GetConvertedPlayerId(GetTriggerPlayer())],100.00,100.00,100.00,0)
call SetUnitScalePercent(udg_xwzxwz17[GetConvertedPlayerId(GetTriggerPlayer())],100.00,100.00,100.00)
call DisableTrigger(GetTriggeringTrigger())
endfunction
function Trig_xwzxwz81_Conditions takes nothing returns boolean
return ((GetTriggerPlayer()==Player(0)))
endfunction
function Trig_xwzxwz81_Func001Func002C takes nothing returns boolean
return ((GetEventPlayerChatString()=="魔道 关闭"))
endfunction
function Trig_xwzxwz81_Func001C takes nothing returns boolean
return ((GetEventPlayerChatString()=="魔道 打开"))
endfunction
function Trig_xwzxwz81_Actions takes nothing returns nothing
if (Trig_xwzxwz81_Func001C()) then
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" |cFFFFFF00打开了魔道 !!!!!!!!!!!!!|r"+" 邪恶之气已经释放。修改者：|cFFFFFF00hellour|r 有什么问题请登陆 |cFFFF0000素|r|cFF0041FF菜|r|cFF1BE6B8魔|r|cFF530080兽|r论坛  |cFFFF0000h|r|cFFAA1655t|r|cFF552BAAt|r|cFF0041FFp|r|cFF0978E7:|r|cFF12AFD0/|r|cFF1BE6B8/|r|cFF2E99A5w|r|cFF404D93a|r|cFF530080r|r|cFF8C55553|r|cFFC6AA2Bs|r|cFFFFFF00u|r|cFFFFDF48c|r|cFFFEBF90a|r|cFFFE9FD8i|r|cFFB4AA90.|r|cFF69B4485|r|cFF1FBF00d|r|cFF619D3A6|r|cFFA37C75d|r|cFFE55AAF.|r|cFFCA6EA7c|r|cFFAF819Eo|r|cFF949596m|r一起学习研究")))
call TriggerExecute(gg_trg_xwzxwz84)
call EnableTrigger(gg_trg_xwzxwz95)
else
if (Trig_xwzxwz81_Func001Func002C()) then
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" |cFFFFFF00关闭了魔道 !!!!!!!!!!!!!|r"+" 任何人无法再进入魔道。")))
call DisableTrigger(gg_trg_xwzxwz82)
endif
endif
endfunction
function Trig_xwzxwz82_Conditions takes nothing returns boolean
return ((udg_xwzxwz36[GetConvertedPlayerId(GetTriggerPlayer())]==false))and((udg_xwzxwz58[GetConvertedPlayerId(GetTriggerPlayer())]==false))
endfunction
function Trig_xwzxwz82_Func001Func001C takes nothing returns boolean
return ((udg_xwzxwz64==false))
endfunction
function Trig_xwzxwz82_Func001C takes nothing returns boolean
return ((udg_xwzxwz63))
endfunction
function Trig_xwzxwz82_Actions takes nothing returns nothing
if (Trig_xwzxwz82_Func001C()) then
set udg_xwzxwz59=GetTriggerPlayer()
set udg_xwzxwz99[GetConvertedPlayerId(udg_xwzxwz59)]=GetRandomInt(1,8)
call ConditionalTriggerExecute(gg_trg_xwzxwz83)
else
if (Trig_xwzxwz82_Func001Func001C()) then
set udg_xwzxwz64=true
set udg_xwzxwz59=GetTriggerPlayer()
call DialogClear(udg_xwzxwz61)
call DialogSetMessage(udg_xwzxwz61,("魔道选择"+""))
set udg_xwzxwz62[3]=DialogAddButtonBJ(udg_xwzxwz61,("冰魔"+" 智"))
set udg_xwzxwz62[4]=DialogAddButtonBJ(udg_xwzxwz61,("火魔"+" 智"))
set udg_xwzxwz62[5]=DialogAddButtonBJ(udg_xwzxwz61,("金魔"+" 力"))
set udg_xwzxwz62[6]=DialogAddButtonBJ(udg_xwzxwz61,("雷魔"+" 力"))
set udg_xwzxwz62[7]=DialogAddButtonBJ(udg_xwzxwz61,("木魔"+" 敏"))
set udg_xwzxwz62[8]=DialogAddButtonBJ(udg_xwzxwz61,("水魔"+" 敏智"))
set udg_xwzxwz62[9]=DialogAddButtonBJ(udg_xwzxwz61,("亡魔"+" 敏"))
set udg_xwzxwz62[10]=DialogAddButtonBJ(udg_xwzxwz61,("月魔"+" 敏"))
call DialogDisplay(udg_xwzxwz59,udg_xwzxwz61,true)
else
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+" 正在选择入魔 请稍后再入魔。。。。"))
endif
endif
endfunction
function Trig_xwzxwz83_Conditions takes nothing returns boolean
return ((udg_xwzxwz58[GetConvertedPlayerId(udg_xwzxwz59)]==false))and((udg_xwzxwz36[GetConvertedPlayerId(udg_xwzxwz59)]==false))
endfunction
function Trig_xwzxwz83_Func004Func001Func002Func002Func001Func002Func001Func001C takes nothing returns boolean
return ((udg_xwzxwz99[GetConvertedPlayerId(udg_xwzxwz59)]==8))
endfunction
function Trig_xwzxwz83_Func004Func001Func002Func002Func001Func002Func001C takes nothing returns boolean
return ((udg_xwzxwz99[GetConvertedPlayerId(udg_xwzxwz59)]==7))
endfunction
function Trig_xwzxwz83_Func004Func001Func002Func002Func001Func002C takes nothing returns boolean
return ((udg_xwzxwz99[GetConvertedPlayerId(udg_xwzxwz59)]==6))
endfunction
function Trig_xwzxwz83_Func004Func001Func002Func002Func001C takes nothing returns boolean
return ((udg_xwzxwz99[GetConvertedPlayerId(udg_xwzxwz59)]==5))
endfunction
function Trig_xwzxwz83_Func004Func001Func002Func002C takes nothing returns boolean
return ((udg_xwzxwz99[GetConvertedPlayerId(udg_xwzxwz59)]==4))
endfunction
function Trig_xwzxwz83_Func004Func001Func002C takes nothing returns boolean
return ((udg_xwzxwz99[GetConvertedPlayerId(udg_xwzxwz59)]==3))
endfunction
function Trig_xwzxwz83_Func004Func001C takes nothing returns boolean
return ((udg_xwzxwz99[GetConvertedPlayerId(udg_xwzxwz59)]==2))
endfunction
function Trig_xwzxwz83_Func004C takes nothing returns boolean
return ((udg_xwzxwz99[GetConvertedPlayerId(udg_xwzxwz59)]==1))
endfunction
function Trig_xwzxwz83_Actions takes nothing returns nothing
set udg_xwzxwz36[GetConvertedPlayerId(udg_xwzxwz59)]=true
if (Trig_xwzxwz83_Func004C()) then
set udg_xwzxwz32[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz39[GetConvertedPlayerId(udg_xwzxwz59)]=1
set udg_xwzxwz37[GetConvertedPlayerId(udg_xwzxwz59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_xwzxwz59)+("  已经入了-<冰魔>-"+"！ 请马上选择你要进入的英雄！")))
else
if (Trig_xwzxwz83_Func004Func001C()) then
set udg_xwzxwz33[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz40[GetConvertedPlayerId(udg_xwzxwz59)]=1
set udg_xwzxwz37[GetConvertedPlayerId(udg_xwzxwz59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_xwzxwz59)+("  已经入了-<火魔>-"+"！ 请马上选择你要进入的英雄！")))
else
if (Trig_xwzxwz83_Func004Func001Func002C()) then
set udg_xwzxwz31[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz38[GetConvertedPlayerId(udg_xwzxwz59)]=1
set udg_xwzxwz37[GetConvertedPlayerId(udg_xwzxwz59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_xwzxwz59)+("  已经入了-<金魔>-"+"！ 请马上选择你要进入的英雄！")))
else
if (Trig_xwzxwz83_Func004Func001Func002Func002C()) then
set udg_xwzxwz34[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz48[GetConvertedPlayerId(udg_xwzxwz59)]=1
set udg_xwzxwz37[GetConvertedPlayerId(udg_xwzxwz59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_xwzxwz59)+("  已经入了-<雷魔>-"+"！ 请马上选择你要进入的英雄！")))
else
if (Trig_xwzxwz83_Func004Func001Func002Func002Func001C()) then
set udg_xwzxwz35[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz47[GetConvertedPlayerId(udg_xwzxwz59)]=1
set udg_xwzxwz37[GetConvertedPlayerId(udg_xwzxwz59)]=0
set udg_xwzxwz43[1]=true
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_xwzxwz59)+("  已经入了-<木魔>-"+"！ 请马上选择你要进入的英雄！")))
else
if (Trig_xwzxwz83_Func004Func001Func002Func002Func001Func002C()) then
set udg_xwzxwz49[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz50[GetConvertedPlayerId(udg_xwzxwz59)]=1
set udg_xwzxwz37[GetConvertedPlayerId(udg_xwzxwz59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_xwzxwz59)+("  已经入了-<水魔>-"+"！ 请马上选择你要进入的英雄！")))
else
if (Trig_xwzxwz83_Func004Func001Func002Func002Func001Func002Func001C()) then
set udg_xwzxwz51[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz52[GetConvertedPlayerId(udg_xwzxwz59)]=1
set udg_xwzxwz37[GetConvertedPlayerId(udg_xwzxwz59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_xwzxwz59)+("  已经入了-<亡魔>-"+"！ 请马上选择你要进入的英雄！")))
else
if (Trig_xwzxwz83_Func004Func001Func002Func002Func001Func002Func001Func001C()) then
set udg_xwzxwz100[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz56[GetConvertedPlayerId(udg_xwzxwz59)]=1
set udg_xwzxwz37[GetConvertedPlayerId(udg_xwzxwz59)]=0
set udg_xwzxwz43[2]=true
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_xwzxwz59)+("  已经入了-<月魔>-"+"！ 请马上选择你要进入的英雄！")))
else
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_xwzxwz59)+" 妄图进入魔道，但因邪恶度不够，你永久不可以入魔道！"))
endif
endif
endif
endif
endif
endif
endif
endif
endfunction
function Trig_xwzxwz84_Actions takes nothing returns nothing
call DialogClear(udg_xwzxwz60)
call DialogSetMessage(udg_xwzxwz60,("选择入魔方式"+""))
set udg_xwzxwz62[1]=DialogAddButtonBJ(udg_xwzxwz60,("随机模式"+""))
set udg_xwzxwz62[2]=DialogAddButtonBJ(udg_xwzxwz60,("选择模式"+""))
call DialogDisplay(Player(0),udg_xwzxwz60,true)
endfunction
function Trig_xwzxwz84Clink_Func002Func001Func003Func003Func003Func003Func003Func001C takes nothing returns boolean
return ((GetClickedButtonBJ()==udg_xwzxwz62[10]))
endfunction
function Trig_xwzxwz84Clink_Func002Func001Func003Func003Func003Func003Func003C takes nothing returns boolean
return ((GetClickedButtonBJ()==udg_xwzxwz62[9]))
endfunction
function Trig_xwzxwz84Clink_Func002Func001Func003Func003Func003Func003C takes nothing returns boolean
return ((GetClickedButtonBJ()==udg_xwzxwz62[8]))
endfunction
function Trig_xwzxwz84Clink_Func002Func001Func003Func003Func003C takes nothing returns boolean
return ((GetClickedButtonBJ()==udg_xwzxwz62[7]))
endfunction
function Trig_xwzxwz84Clink_Func002Func001Func003Func003C takes nothing returns boolean
return ((GetClickedButtonBJ()==udg_xwzxwz62[6]))
endfunction
function Trig_xwzxwz84Clink_Func002Func001Func003C takes nothing returns boolean
return ((GetClickedButtonBJ()==udg_xwzxwz62[5]))
endfunction
function Trig_xwzxwz84Clink_Func002Func001C takes nothing returns boolean
return ((GetClickedButtonBJ()==udg_xwzxwz62[4]))
endfunction
function Trig_xwzxwz84Clink_Func002C takes nothing returns boolean
return ((GetClickedButtonBJ()==udg_xwzxwz62[3]))
endfunction
function Trig_xwzxwz84Clink_Actions takes nothing returns nothing
if (Trig_xwzxwz84Clink_Func002C()) then
set udg_xwzxwz36[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz32[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz39[GetConvertedPlayerId(udg_xwzxwz59)]=1
set udg_xwzxwz37[GetConvertedPlayerId(udg_xwzxwz59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_xwzxwz59)+("  已经入了-<冰魔>-"+"！ 请马上选择你要进入的英雄！")))
set udg_xwzxwz64=false
call DialogDisplay(udg_xwzxwz59,udg_xwzxwz61,false)
else
if (Trig_xwzxwz84Clink_Func002Func001C()) then
set udg_xwzxwz36[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz33[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz40[GetConvertedPlayerId(udg_xwzxwz59)]=1
set udg_xwzxwz37[GetConvertedPlayerId(udg_xwzxwz59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_xwzxwz59)+("  已经入了-<火魔>-"+"！ 请马上选择你要进入的英雄！")))
set udg_xwzxwz64=false
call DialogDisplay(udg_xwzxwz59,udg_xwzxwz61,false)
else
if (Trig_xwzxwz84Clink_Func002Func001Func003C()) then
set udg_xwzxwz36[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz31[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz38[GetConvertedPlayerId(udg_xwzxwz59)]=1
set udg_xwzxwz37[GetConvertedPlayerId(udg_xwzxwz59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_xwzxwz59)+("  已经入了-<金魔>-"+"！ 请马上选择你要进入的英雄！")))
set udg_xwzxwz64=false
call DialogDisplay(udg_xwzxwz59,udg_xwzxwz61,false)
else
if (Trig_xwzxwz84Clink_Func002Func001Func003Func003C()) then
set udg_xwzxwz36[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz34[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz48[GetConvertedPlayerId(udg_xwzxwz59)]=1
set udg_xwzxwz37[GetConvertedPlayerId(udg_xwzxwz59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_xwzxwz59)+("  已经入了-<雷魔>-"+"！ 请马上选择你要进入的英雄！")))
set udg_xwzxwz64=false
call DialogDisplay(udg_xwzxwz59,udg_xwzxwz61,false)
else
if (Trig_xwzxwz84Clink_Func002Func001Func003Func003Func003C()) then
set udg_xwzxwz36[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz35[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz47[GetConvertedPlayerId(udg_xwzxwz59)]=1
set udg_xwzxwz37[GetConvertedPlayerId(udg_xwzxwz59)]=0
set udg_xwzxwz43[1]=true
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_xwzxwz59)+("  已经入了-<木魔>-"+"！ 请马上选择你要进入的英雄！")))
set udg_xwzxwz64=false
call DialogDisplay(udg_xwzxwz59,udg_xwzxwz61,false)
else
if (Trig_xwzxwz84Clink_Func002Func001Func003Func003Func003Func003C()) then
set udg_xwzxwz36[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz49[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz50[GetConvertedPlayerId(udg_xwzxwz59)]=1
set udg_xwzxwz37[GetConvertedPlayerId(udg_xwzxwz59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_xwzxwz59)+("  已经入了-<水魔>-"+"！ 请马上选择你要进入的英雄！")))
set udg_xwzxwz64=false
call DialogDisplay(udg_xwzxwz59,udg_xwzxwz61,false)
else
if (Trig_xwzxwz84Clink_Func002Func001Func003Func003Func003Func003Func003C()) then
set udg_xwzxwz36[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz51[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz52[GetConvertedPlayerId(udg_xwzxwz59)]=1
set udg_xwzxwz37[GetConvertedPlayerId(udg_xwzxwz59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_xwzxwz59)+("  已经入了-<亡魔>-"+"！ 请马上选择你要进入的英雄！")))
set udg_xwzxwz64=false
call DialogDisplay(udg_xwzxwz59,udg_xwzxwz61,false)
else
if (Trig_xwzxwz84Clink_Func002Func001Func003Func003Func003Func003Func003Func001C()) then
set udg_xwzxwz36[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz100[GetConvertedPlayerId(udg_xwzxwz59)]=true
set udg_xwzxwz56[GetConvertedPlayerId(udg_xwzxwz59)]=1
set udg_xwzxwz37[GetConvertedPlayerId(udg_xwzxwz59)]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(udg_xwzxwz59)+("  已经入了-<月魔>-"+"！ 请马上选择你要进入的英雄！")))
set udg_xwzxwz64=false
call DialogDisplay(udg_xwzxwz59,udg_xwzxwz61,false)
endif
endif
endif
endif
endif
endif
endif
endif
endfunction
function Trig_xwzxwz85_Func001C takes nothing returns boolean
return ((GetClickedButtonBJ()==udg_xwzxwz62[1]))
endfunction
function Trig_xwzxwz85_Actions takes nothing returns nothing
if (Trig_xwzxwz85_Func001C()) then
call DisplayTextToForce(GetPlayersAll(),("玩家1 选择了随机入魔的方式 请各玩家输入“进入魔道”入魔！"+""))
set udg_xwzxwz63=true
call EnableTrigger(gg_trg_xwzxwz82)
call DialogDestroy(udg_xwzxwz60)
else
call DisplayTextToForce(GetPlayersAll(),("玩家1 选择了选择入魔的方式 请各玩家输入“进入魔道”入魔对话框选择！"+""))
set udg_xwzxwz63=false
call EnableTrigger(gg_trg_xwzxwz82)
call DialogDestroy(udg_xwzxwz60)
endif
endfunction
function Trig_xwzxwz1NoralPlayer_Func001Func001Func001Func001Func001Func001Func001Func001C takes nothing returns boolean
return ((udg_xwzxwz100[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_xwzxwz1NoralPlayer_Func001Func001Func001Func001Func001Func001Func001C takes nothing returns boolean
return ((udg_xwzxwz51[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_xwzxwz1NoralPlayer_Func001Func001Func001Func001Func001Func001C takes nothing returns boolean
return ((udg_xwzxwz35[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_xwzxwz1NoralPlayer_Func001Func001Func001Func001Func001C takes nothing returns boolean
return ((udg_xwzxwz49[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_xwzxwz1NoralPlayer_Func001Func001Func001Func001C takes nothing returns boolean
return ((udg_xwzxwz34[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_xwzxwz1NoralPlayer_Func001Func001Func001C takes nothing returns boolean
return ((udg_xwzxwz33[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_xwzxwz1NoralPlayer_Func001Func001C takes nothing returns boolean
return ((udg_xwzxwz32[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_xwzxwz1NoralPlayer_Func001C takes nothing returns boolean
return ((udg_xwzxwz31[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_xwzxwz1NoralPlayer_Actions takes nothing returns nothing
if (Trig_xwzxwz1NoralPlayer_Func001C()) then
set udg_xwzxwz31[GetConvertedPlayerId(GetTriggerPlayer())]=false
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" 的英雄 "+(GetHeroProperName(udg_xwzxwz17[GetConvertedPlayerId(GetTriggerPlayer())])+" 退出了魔道！"))))
else
if (Trig_xwzxwz1NoralPlayer_Func001Func001C()) then
set udg_xwzxwz32[GetConvertedPlayerId(GetTriggerPlayer())]=false
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" 的英雄 "+(GetHeroProperName(udg_xwzxwz17[GetConvertedPlayerId(GetTriggerPlayer())])+" 退出了魔道！"))))
else
if (Trig_xwzxwz1NoralPlayer_Func001Func001Func001C()) then
set udg_xwzxwz33[GetConvertedPlayerId(GetTriggerPlayer())]=false
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" 的英雄 "+(GetHeroProperName(udg_xwzxwz17[GetConvertedPlayerId(GetTriggerPlayer())])+" 退出了魔道！"))))
else
if (Trig_xwzxwz1NoralPlayer_Func001Func001Func001Func001C()) then
set udg_xwzxwz34[GetConvertedPlayerId(GetTriggerPlayer())]=false
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" 的英雄 "+(GetHeroProperName(udg_xwzxwz17[GetConvertedPlayerId(GetTriggerPlayer())])+" 退出了魔道！"))))
else
if (Trig_xwzxwz1NoralPlayer_Func001Func001Func001Func001Func001C()) then
set udg_xwzxwz49[GetConvertedPlayerId(GetTriggerPlayer())]=false
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" 的英雄 "+(GetHeroProperName(udg_xwzxwz17[GetConvertedPlayerId(GetTriggerPlayer())])+" 退出了魔道！"))))
else
if (Trig_xwzxwz1NoralPlayer_Func001Func001Func001Func001Func001Func001C()) then
set udg_xwzxwz35[GetConvertedPlayerId(GetTriggerPlayer())]=false
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" 的英雄 "+(GetHeroProperName(udg_xwzxwz17[GetConvertedPlayerId(GetTriggerPlayer())])+" 退出了魔道！"))))
else
if (Trig_xwzxwz1NoralPlayer_Func001Func001Func001Func001Func001Func001Func001C()) then
set udg_xwzxwz51[GetConvertedPlayerId(GetTriggerPlayer())]=false
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" 的英雄 "+(GetHeroProperName(udg_xwzxwz17[GetConvertedPlayerId(GetTriggerPlayer())])+" 退出了魔道！"))))
else
if (Trig_xwzxwz1NoralPlayer_Func001Func001Func001Func001Func001Func001Func001Func001C()) then
set udg_xwzxwz100[GetConvertedPlayerId(GetTriggerPlayer())]=false
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+(" 的英雄 "+(GetHeroProperName(udg_xwzxwz17[GetConvertedPlayerId(GetTriggerPlayer())])+" 退出了魔道！"))))
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
function Trig_xwzxwz86_Conditions takes nothing returns boolean
return ((udg_xwzxwz58[GetConvertedPlayerId(GetTriggerPlayer())]==false))and((udg_xwzxwz36[GetConvertedPlayerId(GetTriggerPlayer())]))and((GetOwningPlayer(GetTriggerUnit())==GetTriggerPlayer()))and((GetTriggerUnit()!=udg_xwzxwz17[GetConvertedPlayerId(GetTriggerPlayer())]))
endfunction
function Trig_xwzxwz86_Actions takes nothing returns nothing
set udg_xwzxwz17[GetConvertedPlayerId(GetTriggerPlayer())]=GetTriggerUnit()
set udg_xwzxwz58[GetConvertedPlayerId(GetTriggerPlayer())]=true
call CreateTextTagUnitBJ(((("|cFFFFFF00"+GetHeroProperName(GetTriggerUnit()))+"|r ")+"|cFFFF0033入魔成功！|r"),GetTriggerUnit(),0,20.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),3.00)
endfunction
function Trig_xwzxwz87_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))and((udg_xwzxwz31[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)))and((GetAttacker()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))
endfunction
function Trig_xwzxwz87_Func002C takes nothing returns boolean
return ((GetUnitLifePercent(GetAttacker())<=80.00))
endfunction
function Trig_xwzxwz87_Func003C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))
endfunction
function Trig_xwzxwz87_Func004Func011001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz87_Func004Func011001003002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz87_Func004Func011001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz87_Func004Func011001003001(),Trig_xwzxwz87_Func004Func011001003002())
endfunction
function Trig_xwzxwz87_Func004Func011A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\Transmute\\PileofGold.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),(I2R(GetHeroStr(GetAttacker(),true))*(I2R(udg_xwzxwz38[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])*(I2R(GetHeroLevel(GetAttacker()))*GetRandomReal(10.00,50.00)))),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
endfunction
function Trig_xwzxwz87_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))
endfunction
function Trig_xwzxwz87_Func005Func005001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz87_Func005Func005001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz87_Func005Func005001003002002001 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz87_Func005Func005001003002002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
endfunction
function Trig_xwzxwz87_Func005Func005001003002002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz87_Func005Func005001003002002001(),Trig_xwzxwz87_Func005Func005001003002002002())
endfunction
function Trig_xwzxwz87_Func005Func005001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz87_Func005Func005001003002001(),Trig_xwzxwz87_Func005Func005001003002002())
endfunction
function Trig_xwzxwz87_Func005Func005001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz87_Func005Func005001003001(),Trig_xwzxwz87_Func005Func005001003002())
endfunction
function Trig_xwzxwz87_Func005Func005A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\MarkOfChaos\\MarkOfChaosTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),(I2R(GetHeroStr(GetAttacker(),true))*(I2R(udg_xwzxwz38[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])*(I2R(GetHeroLevel(GetAttacker()))*GetRandomReal(5.00,20.00)))),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
endfunction
function Trig_xwzxwz87_Func005C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))
endfunction
function Trig_xwzxwz87_Func006C takes nothing returns boolean
return ((RAbsBJ((GetUnitFacing(GetTriggerUnit())-GetUnitFacing(GetAttacker())))<=60.00))
endfunction
function Trig_xwzxwz87_Actions takes nothing returns nothing
if (Trig_xwzxwz87_Func002C()) then
call AddSpecialEffectTargetUnitBJ("origin",GetAttacker(),"Abilities\\Spells\\Orc\\Disenchant\\DisenchantSpecialArt.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitLifePercentBJ(GetAttacker(),(GetUnitLifePercent(GetAttacker())+3.00))
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"吸血之刃")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
endif
if (Trig_xwzxwz87_Func003C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"金魔之罩")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\Orc\\Voodoo\\VoodooAuraTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitManaBJ(GetTriggerUnit(),0)
call UnitDamageTargetBJ(GetAttacker(),GetTriggerUnit(),((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroStr(GetAttacker(),true)))*I2R(udg_xwzxwz38[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
call PauseUnitBJ(true,GetTriggerUnit())
call TriggerSleepAction(3.00)
call PauseUnitBJ(false,GetTriggerUnit())
endif
if (Trig_xwzxwz87_Func004C()) then
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
call ForGroupBJ(GetUnitsInRangeOfLocMatching(400.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz87_Func004Func011001003)),function Trig_xwzxwz87_Func004Func011A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
if (Trig_xwzxwz87_Func005C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"金魔妖气")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(400.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz87_Func005Func005001003)),function Trig_xwzxwz87_Func005Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
if (Trig_xwzxwz87_Func006C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"背击噬魂")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectTargetUnitBJ("chest",GetTriggerUnit(),"Objects\\Spawnmodels\\Critters\\Albatross\\CritterBloodAlbatross.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetTriggerUnit(),(I2R(GetHeroLevel(GetAttacker()))*(SquareRoot(I2R(GetHeroAgi(GetAttacker(),true)))*(I2R(udg_xwzxwz38[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])*GetRandomReal(10.00,100.00)))),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
endif
endfunction
function Trig_xwzxwz87UP_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetKillingUnitBJ()))))and((udg_xwzxwz31[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetKillingUnitBJ()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)))
endfunction
function Trig_xwzxwz87UP_Func003C takes nothing returns boolean
return ((udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=200))
endfunction
function Trig_xwzxwz87UP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_xwzxwz87UP_Actions takes nothing returns nothing
set udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_xwzxwz87UP_Func003C()) then
set udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_xwzxwz38[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_xwzxwz38[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000金魔之斩魂刀|r熟练度为 ")+I2S(udg_xwzxwz38[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000金魔之斩魂刀|r "+(I2S(udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/200")))
endif
if (Trig_xwzxwz87UP_Func004C()) then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,5)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,3)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,2)
endif
endfunction
function Trig_xwzxwz88_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))and((udg_xwzxwz32[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)))and((GetAttacker()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))
endfunction
function Trig_xwzxwz88_Func001Func005001002003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz88_Func001Func005001002003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz88_Func001Func005001002003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz88_Func001Func005001002003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz88_Func001Func005001002003002001(),Trig_xwzxwz88_Func001Func005001002003002002())
endfunction
function Trig_xwzxwz88_Func001Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz88_Func001Func005001002003001(),Trig_xwzxwz88_Func001Func005001002003002())
endfunction
function Trig_xwzxwz88_Func001Func005A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Undead\\FreezingBreath\\FreezingBreathTargetArt.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroInt(GetAttacker(),true)))*I2R(udg_xwzxwz39[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
endfunction
function Trig_xwzxwz88_Func001C takes nothing returns boolean
return ((GetUnitManaPercent(GetAttacker())>=70.00))and((GetRandomInt(1,100)<=8))
endfunction
function Trig_xwzxwz88_Func002Func005001002003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz88_Func002Func005001002003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz88_Func002Func005001002003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz88_Func002Func005001002003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz88_Func002Func005001002003002001(),Trig_xwzxwz88_Func002Func005001002003002002())
endfunction
function Trig_xwzxwz88_Func002Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz88_Func002Func005001002003001(),Trig_xwzxwz88_Func002Func005001002003002())
endfunction
function Trig_xwzxwz88_Func002Func005Func007003001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz88_Func002Func005Func007003001003002001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz88_Func002Func005Func007003001003002002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetEnumUnit())))
endfunction
function Trig_xwzxwz88_Func002Func005Func007003001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz88_Func002Func005Func007003001003002001(),Trig_xwzxwz88_Func002Func005Func007003001003002002())
endfunction
function Trig_xwzxwz88_Func002Func005Func007003001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz88_Func002Func005Func007003001003001(),Trig_xwzxwz88_Func002Func005Func007003001003002())
endfunction
function Trig_xwzxwz88_Func002Func005A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Items\\AIso\\AIsoTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Items\\AIso\\BIsvTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitMoveSpeed(GetEnumUnit(),GetUnitDefaultMoveSpeed(GetEnumUnit()))
call SetUnitOwner(GetEnumUnit(),Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
call IssueTargetOrder(GetEnumUnit(),"attack",GroupPickRandomUnit(GetUnitsInRangeOfLocMatching(512,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz88_Func002Func005Func007003001003))))
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_xwzxwz88_Func002C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_xwzxwz88_Actions takes nothing returns nothing
if (Trig_xwzxwz88_Func001C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"冰魄云渺")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(16,GetUnitsInRangeOfLocMatching(1000.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz88_Func001Func005001002003))),function Trig_xwzxwz88_Func001Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
return
endif
if (Trig_xwzxwz88_Func002C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"冰魔转魂")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(8,GetUnitsInRangeOfLocMatching(700.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz88_Func002Func005001002003))),function Trig_xwzxwz88_Func002Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
endfunction
function Trig_xwzxwz88UP_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetKillingUnitBJ()))))and((udg_xwzxwz32[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetKillingUnitBJ()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)))
endfunction
function Trig_xwzxwz88UP_Func003C takes nothing returns boolean
return ((udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=200))
endfunction
function Trig_xwzxwz88UP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_xwzxwz88UP_Actions takes nothing returns nothing
set udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_xwzxwz88UP_Func003C()) then
set udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_xwzxwz39[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_xwzxwz39[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000冰魔之寒冰杖|r熟练度为 ")+I2S(udg_xwzxwz39[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000冰魔之寒冰杖|r "+(I2S(udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/200")))
endif
if (Trig_xwzxwz88UP_Func004C()) then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,2)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,3)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,7)
endif
endfunction
function Trig_xwzxwz89_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))and((udg_xwzxwz33[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)))and((GetAttacker()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))
endfunction
function Trig_xwzxwz89_Func001Func005001002003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz89_Func001Func005001002003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz89_Func001Func005001002003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz89_Func001Func005001002003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz89_Func001Func005001002003002001(),Trig_xwzxwz89_Func001Func005001002003002002())
endfunction
function Trig_xwzxwz89_Func001Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz89_Func001Func005001002003001(),Trig_xwzxwz89_Func001Func005001002003002())
endfunction
function Trig_xwzxwz89_Func001Func005A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Demon\\RainOfFire\\RainOfFireTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroInt(GetAttacker(),true)))*I2R(udg_xwzxwz40[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
endfunction
function Trig_xwzxwz89_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=4))
endfunction
function Trig_xwzxwz89_Func002Func005001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz89_Func002Func005001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz89_Func002Func005001003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz89_Func002Func005001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz89_Func002Func005001003002001(),Trig_xwzxwz89_Func002Func005001003002002())
endfunction
function Trig_xwzxwz89_Func002Func005001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz89_Func002Func005001003001(),Trig_xwzxwz89_Func002Func005001003002())
endfunction
function Trig_xwzxwz89_Func002Func005A takes nothing returns nothing
set udg_xwzxwz42=PolarProjectionBJ(GetUnitLoc(GetAttacker()),800.00,GetRandomReal(0,360.00))
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\SoulBurn\\SoulBurnbuff.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call IssuePointOrderLoc(GetEnumUnit(),"move",udg_xwzxwz42)
call SetUnitLifePercentBJ(GetEnumUnit(),(GetUnitLifePercent(GetEnumUnit())-1))
call RemoveLocation(udg_xwzxwz42)
endfunction
function Trig_xwzxwz89_Func002C takes nothing returns boolean
return ((GetRandomInt(1,100)<=8))
endfunction
function Trig_xwzxwz89_Func003Func011001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz89_Func003Func011001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz89_Func003Func011001003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz89_Func003Func011001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz89_Func003Func011001003002001(),Trig_xwzxwz89_Func003Func011001003002002())
endfunction
function Trig_xwzxwz89_Func003Func011001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz89_Func003Func011001003001(),Trig_xwzxwz89_Func003Func011001003002())
endfunction
function Trig_xwzxwz89_Func003Func011A takes nothing returns nothing
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),((I2R(GetHeroInt(GetAttacker(),true))*(10.00*I2R(GetHeroLevel(GetAttacker()))))*I2R(udg_xwzxwz40[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
endfunction
function Trig_xwzxwz89_Func003C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))
endfunction
function Trig_xwzxwz89_Actions takes nothing returns nothing
if (Trig_xwzxwz89_Func001C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"地狱飞炎")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(10,GetUnitsInRangeOfLocMatching(700.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz89_Func001Func005001002003))),function Trig_xwzxwz89_Func001Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
if (Trig_xwzxwz89_Func002C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"炽火焚心")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(400.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz89_Func002Func005001003)),function Trig_xwzxwz89_Func002Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
if (Trig_xwzxwz89_Func003C()) then
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
call ForGroupBJ(GetUnitsInRangeOfLocMatching(300.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_xwzxwz89_Func003Func011001003)),function Trig_xwzxwz89_Func003Func011A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
endfunction
function Trig_xwzxwz89UP_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetKillingUnitBJ()))))and((udg_xwzxwz33[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetKillingUnitBJ()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)))
endfunction
function Trig_xwzxwz89UP_Func003C takes nothing returns boolean
return ((udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=200))
endfunction
function Trig_xwzxwz89UP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_xwzxwz89UP_Actions takes nothing returns nothing
set udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_xwzxwz89UP_Func003C()) then
set udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_xwzxwz40[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_xwzxwz40[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000炎魔之烈火刀|r熟练度为 ")+I2S(udg_xwzxwz40[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000炎魔之烈火刀|r "+(I2S(udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/200")))
endif
if (Trig_xwzxwz89UP_Func004C()) then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,2)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,4)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,7)
endif
endfunction
function Trig_xwzxwz90_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))and((udg_xwzxwz34[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)))and((GetAttacker()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))
endfunction
function Trig_xwzxwz90_Func001Func005001002003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz90_Func001Func005001002003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz90_Func001Func005001002003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz90_Func001Func005001002003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz90_Func001Func005001002003002001(),Trig_xwzxwz90_Func001Func005001002003002002())
endfunction
function Trig_xwzxwz90_Func001Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz90_Func001Func005001002003001(),Trig_xwzxwz90_Func001Func005001002003002())
endfunction
function Trig_xwzxwz90_Func001Func005A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroStr(GetAttacker(),true)))*I2R(udg_xwzxwz48[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
endfunction
function Trig_xwzxwz90_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=4))
endfunction
function Trig_xwzxwz90_Func002Func005001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz90_Func002Func005001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz90_Func002Func005001003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz90_Func002Func005001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz90_Func002Func005001003002001(),Trig_xwzxwz90_Func002Func005001003002002())
endfunction
function Trig_xwzxwz90_Func002Func005001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz90_Func002Func005001003001(),Trig_xwzxwz90_Func002Func005001003002())
endfunction
function Trig_xwzxwz90_Func002Func005A takes nothing returns nothing
set udg_xwzxwz42=PolarProjectionBJ(GetUnitLoc(GetAttacker()),500.00,GetRandomReal(0,360.00))
call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Weapons\\Bolt\\BoltImpact.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("chest",GetEnumUnit(),"Abilities\\Spells\\Orc\\Purge\\PurgeBuffTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddLightningLoc("CLPB",GetUnitLoc(GetEnumUnit()),udg_xwzxwz42)
call DestroyLightning(GetLastCreatedLightningBJ())
call SetUnitMoveSpeed(GetEnumUnit(),150.00)
call UnitRemoveBuffs(GetEnumUnit(),true,false)
call RemoveLocation(udg_xwzxwz42)
endfunction
function Trig_xwzxwz90_Func002C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))
endfunction
function Trig_xwzxwz90_Func003C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_xwzxwz90_Func004Func007001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz90_Func004Func007001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz90_Func004Func007001003002002001 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz90_Func004Func007001003002002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
endfunction
function Trig_xwzxwz90_Func004Func007001003002002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz90_Func004Func007001003002002001(),Trig_xwzxwz90_Func004Func007001003002002002())
endfunction
function Trig_xwzxwz90_Func004Func007001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz90_Func004Func007001003002001(),Trig_xwzxwz90_Func004Func007001003002002())
endfunction
function Trig_xwzxwz90_Func004Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz90_Func004Func007001003001(),Trig_xwzxwz90_Func004Func007001003002())
endfunction
function Trig_xwzxwz90_Func004Func007A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Items\\AIlb\\AIlbSpecialArt.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),(I2R(GetHeroStr(GetAttacker(),true))*(I2R(udg_xwzxwz48[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])*GetRandomReal(1.00,5.00))),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
endfunction
function Trig_xwzxwz90_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=10))
endfunction
function Trig_xwzxwz90_Actions takes nothing returns nothing
if (Trig_xwzxwz90_Func001C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"迅雷之击")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(10,GetUnitsInRangeOfLocMatching(700.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz90_Func001Func005001002003))),function Trig_xwzxwz90_Func001Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
return
endif
if (Trig_xwzxwz90_Func002C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"闪电净化")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(400.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz90_Func002Func005001003)),function Trig_xwzxwz90_Func002Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
return
endif
if (Trig_xwzxwz90_Func003C()) then
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
if (Trig_xwzxwz90_Func004C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"雷霆一击")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectLocBJ(GetUnitLoc(GetAttacker()),"Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(400.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz90_Func004Func007001003)),function Trig_xwzxwz90_Func004Func007A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
endfunction
function Trig_xwzxwz90UP_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetKillingUnitBJ()))))and((udg_xwzxwz34[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetKillingUnitBJ()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)))
endfunction
function Trig_xwzxwz90UP_Func003C takes nothing returns boolean
return ((udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=200))
endfunction
function Trig_xwzxwz90UP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_xwzxwz90UP_Actions takes nothing returns nothing
set udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_xwzxwz90UP_Func003C()) then
set udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_xwzxwz48[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_xwzxwz48[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000雷魔之迅雷剑|r熟练度为 ")+I2S(udg_xwzxwz48[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000雷魔之迅雷剑|r "+(I2S(udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/200")))
endif
if (Trig_xwzxwz90UP_Func004C()) then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,5)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,3)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,2)
endif
endfunction
function Trig_xwzxwz91_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))and((udg_xwzxwz49[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)))and((GetAttacker()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))
endfunction
function Trig_xwzxwz91_Func001Func005001002003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz91_Func001Func005001002003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz91_Func001Func005001002003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz91_Func001Func005001002003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz91_Func001Func005001002003002001(),Trig_xwzxwz91_Func001Func005001002003002002())
endfunction
function Trig_xwzxwz91_Func001Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz91_Func001Func005001002003001(),Trig_xwzxwz91_Func001Func005001002003002())
endfunction
function Trig_xwzxwz91_Func001Func005A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((GetUnitManaPercent(GetAttacker())*SquareRoot(GetUnitStateSwap(UNIT_STATE_MAX_MANA,GetAttacker())))*I2R(udg_xwzxwz50[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_xwzxwz91_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=6))
endfunction
function Trig_xwzxwz91_Func002Func005001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz91_Func002Func005001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz91_Func002Func005001003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz91_Func002Func005001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz91_Func002Func005001003002001(),Trig_xwzxwz91_Func002Func005001003002002())
endfunction
function Trig_xwzxwz91_Func002Func005001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz91_Func002Func005001003001(),Trig_xwzxwz91_Func002Func005001003002())
endfunction
function Trig_xwzxwz91_Func002Func005A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\Blizzard\\BlizzardTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),(I2R(GetHeroLevel(GetAttacker()))*(SquareRoot((I2R(GetHeroAgi(GetAttacker(),true))+(I2R(GetHeroInt(GetAttacker(),true))*3.00)))*I2R(udg_xwzxwz50[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
endfunction
function Trig_xwzxwz91_Func002C takes nothing returns boolean
return ((GetRandomInt(1,100)<=4))
endfunction
function Trig_xwzxwz91_Func003Func008001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz91_Func003Func008001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz91_Func003Func008001003002002001 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz91_Func003Func008001003002002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
endfunction
function Trig_xwzxwz91_Func003Func008001003002002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz91_Func003Func008001003002002001(),Trig_xwzxwz91_Func003Func008001003002002002())
endfunction
function Trig_xwzxwz91_Func003Func008001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz91_Func003Func008001003002001(),Trig_xwzxwz91_Func003Func008001003002002())
endfunction
function Trig_xwzxwz91_Func003Func008001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz91_Func003Func008001003001(),Trig_xwzxwz91_Func003Func008001003002())
endfunction
function Trig_xwzxwz91_Func003Func008A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\DispelMagic\\DispelMagicTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitManaBJ(GetEnumUnit(),0)
call UnitRemoveBuffs(GetEnumUnit(),true,false)
endfunction
function Trig_xwzxwz91_Func003C takes nothing returns boolean
return ((GetRandomInt(1,100)<=8))
endfunction
function Trig_xwzxwz91_Actions takes nothing returns nothing
if (Trig_xwzxwz91_Func001C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"水怒龙息")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(10,GetUnitsInRangeOfLocMatching(900.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz91_Func001Func005001002003))),function Trig_xwzxwz91_Func001Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
if (Trig_xwzxwz91_Func002C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"暴风雨雪")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(550.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz91_Func002Func005001003)),function Trig_xwzxwz91_Func002Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
if (Trig_xwzxwz91_Func003C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"邪恶水牢")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call UnitRemoveBuffs(GetAttacker(),false,true)
call AddSpecialEffectTargetUnitBJ("origin",GetAttacker(),"Abilities\\Spells\\Human\\ManaShield\\ManaShieldCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(400.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz91_Func003Func008001003)),function Trig_xwzxwz91_Func003Func008A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
endfunction
function Trig_xwzxwz91Hurt_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetAttacker(),GetOwningPlayer(GetTriggerUnit()))))and((udg_xwzxwz49[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))and((GetTriggerUnit()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))
endfunction
function Trig_xwzxwz91Hurt_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=20))and((GetUnitLifePercent(GetTriggerUnit())<=20.00))and((GetUnitManaPercent(GetTriggerUnit())>=30.00))
endfunction
function Trig_xwzxwz91Hurt_Actions takes nothing returns nothing
if (Trig_xwzxwz91Hurt_Func001C()) then
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
function Trig_xwzxwz91UP_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetKillingUnitBJ()))))and((udg_xwzxwz49[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetKillingUnitBJ()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)))
endfunction
function Trig_xwzxwz91UP_Func003C takes nothing returns boolean
return ((udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=200))
endfunction
function Trig_xwzxwz91UP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_xwzxwz91UP_Actions takes nothing returns nothing
set udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_xwzxwz91UP_Func003C()) then
set udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_xwzxwz50[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_xwzxwz50[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000水魔之定海神针|r熟练度为 ")+I2S(udg_xwzxwz50[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000水魔之定海神针|r "+(I2S(udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/200")))
endif
if (Trig_xwzxwz91UP_Func004C()) then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,3)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,2)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,6)
endif
endfunction
function Trig_xwzxwz92_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))and((udg_xwzxwz35[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((GetAttacker()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)))
endfunction
function Trig_xwzxwz92_Func001Func007001002003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz92_Func001Func007001002003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz92_Func001Func007001002003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz92_Func001Func007001002003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz92_Func001Func007001002003002001(),Trig_xwzxwz92_Func001Func007001002003002002())
endfunction
function Trig_xwzxwz92_Func001Func007001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz92_Func001Func007001002003001(),Trig_xwzxwz92_Func001Func007001002003002())
endfunction
function Trig_xwzxwz92_Func001Func007A takes nothing returns nothing
set udg_xwzxwz45=(udg_xwzxwz45+1)
set udg_xwzxwz44[udg_xwzxwz45]=GetEnumUnit()
call PauseUnitBJ(true,GetEnumUnit())
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Undead\\Impale\\ImpaleMissTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
set udg_xwzxwz46[udg_xwzxwz45]=AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\StormBolt\\StormBoltTarget.mdl")
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_xwzxwz92_Func001Func009Func005001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz92_Func001Func009Func005001003002 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz92_Func001Func009Func005001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz92_Func001Func009Func005001003001(),Trig_xwzxwz92_Func001Func009Func005001003002())
endfunction
function Trig_xwzxwz92_Func001Func009Func005A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Undead\\Impale\\ImpaleHitTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Undead\\Impale\\ImpaleHitTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),(((I2R(GetHeroLevel(GetAttacker()))*4.00)*I2R(GetHeroAgi(GetAttacker(),true)))*I2R(udg_xwzxwz47[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_xwzxwz92_Func001Func009Func006Func009001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz92_Func001Func009Func006Func009001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz92_Func001Func009Func006Func009001003002002001 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz92_Func001Func009Func006Func009001003002002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
endfunction
function Trig_xwzxwz92_Func001Func009Func006Func009001003002002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz92_Func001Func009Func006Func009001003002002001(),Trig_xwzxwz92_Func001Func009Func006Func009001003002002002())
endfunction
function Trig_xwzxwz92_Func001Func009Func006Func009001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz92_Func001Func009Func006Func009001003002001(),Trig_xwzxwz92_Func001Func009Func006Func009001003002002())
endfunction
function Trig_xwzxwz92_Func001Func009Func006Func009001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz92_Func001Func009Func006Func009001003001(),Trig_xwzxwz92_Func001Func009Func006Func009001003002())
endfunction
function Trig_xwzxwz92_Func001Func009Func006Func009A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Undead\\Impale\\ImpaleMissTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),(((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroAgi(GetAttacker(),true)))*8.00)*(I2R(udg_xwzxwz47[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])*GetRandomReal(1.00,10.00))),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
endfunction
function Trig_xwzxwz92_Func001Func009Func006C takes nothing returns boolean
return ((GetRandomInt(1,100)<=30))
endfunction
function Trig_xwzxwz92_Func001Func009C takes nothing returns boolean
return ((GetRandomInt(1,100)<=15))
endfunction
function Trig_xwzxwz92_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=6))and((udg_xwzxwz43[1]))
endfunction
function Trig_xwzxwz92_Func002Func005001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz92_Func002Func005001003002 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz92_Func002Func005001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz92_Func002Func005001003001(),Trig_xwzxwz92_Func002Func005001003002())
endfunction
function Trig_xwzxwz92_Func002Func005A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Undead\\Impale\\ImpaleHitTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Undead\\Impale\\ImpaleHitTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroAgi(GetAttacker(),true)))*I2R(udg_xwzxwz47[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_xwzxwz92_Func002C takes nothing returns boolean
return ((GetUnitManaPercent(GetAttacker())>=70.00))and((GetRandomInt(1,100)<=4))
endfunction
function Trig_xwzxwz92_Func003Func009001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz92_Func003Func009001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz92_Func003Func009001003002002001 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz92_Func003Func009001003002002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
endfunction
function Trig_xwzxwz92_Func003Func009001003002002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz92_Func003Func009001003002002001(),Trig_xwzxwz92_Func003Func009001003002002002())
endfunction
function Trig_xwzxwz92_Func003Func009001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz92_Func003Func009001003002001(),Trig_xwzxwz92_Func003Func009001003002002())
endfunction
function Trig_xwzxwz92_Func003Func009001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz92_Func003Func009001003001(),Trig_xwzxwz92_Func003Func009001003002())
endfunction
function Trig_xwzxwz92_Func003Func009A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Undead\\Impale\\ImpaleMissTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),(I2R(GetHeroAgi(GetAttacker(),false))*(I2R(udg_xwzxwz47[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])*GetRandomReal(10.00,100.00))),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
call SetUnitMoveSpeed(GetEnumUnit(),150.00)
endfunction
function Trig_xwzxwz92_Func003C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))
endfunction
function Trig_xwzxwz92_Actions takes nothing returns nothing
if (Trig_xwzxwz92_Func001C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"困仙刺")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
set udg_xwzxwz43[1]=false
set udg_xwzxwz45=0
call ForGroupBJ(GetRandomSubGroup(16,GetUnitsInRangeOfLocMatching(600.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz92_Func001Func007001002003))),function Trig_xwzxwz92_Func001Func007A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
if (Trig_xwzxwz92_Func001Func009C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"2连刺 Hit！")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(600.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz92_Func001Func009Func005001003)),function Trig_xwzxwz92_Func001Func009Func005A)
if (Trig_xwzxwz92_Func001Func009Func006C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"3连刺 Hit！")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectTargetUnitBJ("origin",GetAttacker(),"Abilities\\Spells\\Orc\\ReinforcedTrollBurrow\\ReinforcedTrollBurrowTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(GetUnitLoc(GetAttacker()),"Abilities\\Spells\\Orc\\EarthQuake\\EarthQuakeTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(400.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz92_Func001Func009Func006Func009001003)),function Trig_xwzxwz92_Func001Func009Func006Func009A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
call TriggerSleepAction(5.00)
call TriggerExecute(gg_trg_xwzxwz9201)
return
endif
if (Trig_xwzxwz92_Func002C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"穿心刺")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetUnitsInRangeOfLocMatching(600.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz92_Func002Func005001003)),function Trig_xwzxwz92_Func002Func005A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
return
endif
if (Trig_xwzxwz92_Func003C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"伤足刺")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectTargetUnitBJ("origin",GetAttacker(),"Abilities\\Spells\\Orc\\ReinforcedTrollBurrow\\ReinforcedTrollBurrowTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(GetUnitLoc(GetAttacker()),"Abilities\\Spells\\Orc\\EarthQuake\\EarthQuakeTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(500.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz92_Func003Func009001003)),function Trig_xwzxwz92_Func003Func009A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
endif
endfunction
function Trig_xwzxwz92UP_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetKillingUnitBJ()))))and((udg_xwzxwz35[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetKillingUnitBJ()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)))
endfunction
function Trig_xwzxwz92UP_Func003C takes nothing returns boolean
return ((udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=200))
endfunction
function Trig_xwzxwz92UP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_xwzxwz92UP_Actions takes nothing returns nothing
set udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_xwzxwz92UP_Func003C()) then
set udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_xwzxwz47[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_xwzxwz47[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000木魔之精灵地刺|r熟练度为 ")+I2S(udg_xwzxwz47[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000木魔之精灵地刺|r "+(I2S(udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/200")))
endif
if (Trig_xwzxwz92UP_Func004C()) then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,3)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,4)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,2)
endif
endfunction
function Trig_xwzxwz9201_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=udg_xwzxwz45
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call PauseUnitBJ(false,udg_xwzxwz44[GetForLoopIndexA()])
call DestroyEffect(udg_xwzxwz46[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set udg_xwzxwz43[1]=true
call DisableTrigger(GetTriggeringTrigger())
endfunction
function Trig_xwzxwz93_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))and((udg_xwzxwz51[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)))and((GetAttacker()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))
endfunction
function Trig_xwzxwz93_Func001Func005001002003001 takes nothing returns boolean
return (IsUnitDeadBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz93_Func001Func005001002003002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==false)
endfunction
function Trig_xwzxwz93_Func001Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz93_Func001Func005001002003001(),Trig_xwzxwz93_Func001Func005001002003002())
endfunction
function Trig_xwzxwz93_Func001Func005Func009001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz93_Func001Func005Func009001003002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz93_Func001Func005Func009001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz93_Func001Func005Func009001003001(),Trig_xwzxwz93_Func001Func005Func009001003002())
endfunction
function Trig_xwzxwz93_Func001Func005Func009A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroAgi(GetAttacker(),true)))*SquareRoot(I2R(udg_xwzxwz52[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))),true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_ENHANCED,WEAPON_TYPE_WHOKNOWS)
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_xwzxwz93_Func001Func005A takes nothing returns nothing
set udg_xwzxwz20=GetEnumUnit()
set udg_xwzxwz19=GetUnitLoc(udg_xwzxwz20)
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Objects\\Spawnmodels\\Human\\HumanLargeDeathExplode\\HumanLargeDeathExplode.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Items\\AIre\\AIreTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(200.00,udg_xwzxwz19,Condition(function Trig_xwzxwz93_Func001Func005Func009001003)),function Trig_xwzxwz93_Func001Func005Func009A)
call RemoveUnit(udg_xwzxwz20)
call RemoveLocation(udg_xwzxwz19)
endfunction
function Trig_xwzxwz93_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=8))
endfunction
function Trig_xwzxwz93_Func002Func005001002003001 takes nothing returns boolean
return (IsUnitDeadBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz93_Func002Func005001002003002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
endfunction
function Trig_xwzxwz93_Func002Func005001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz93_Func002Func005001002003001(),Trig_xwzxwz93_Func002Func005001002003002())
endfunction
function Trig_xwzxwz93_Func002Func005A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Undead\\AnimateDead\\AnimateDeadTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call CreateNUnitsAtLoc(1,GetUnitTypeId(GetEnumUnit()),GetOwningPlayer(GetAttacker()),GetUnitLoc(GetEnumUnit()),bj_UNIT_FACING)
call UnitApplyTimedLifeBJ(10.00,'BHwe',GetLastCreatedUnit())
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_xwzxwz93_Func002C takes nothing returns boolean
return ((GetRandomInt(1,100)<=6))
endfunction
function Trig_xwzxwz93_Func003C takes nothing returns boolean
return ((GetRandomInt(1,100)<=1))and((IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)!=true))
endfunction
function Trig_xwzxwz93_Actions takes nothing returns nothing
if (Trig_xwzxwz93_Func001C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"爆炸尸体")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(10,GetUnitsInRangeOfLocMatching(700.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_xwzxwz93_Func001Func005001002003))),function Trig_xwzxwz93_Func001Func005A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
return
endif
if (Trig_xwzxwz93_Func002C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"亡灵复苏")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call ForGroupBJ(GetRandomSubGroup(8,GetUnitsInRangeOfLocMatching(600.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_xwzxwz93_Func002Func005001002003))),function Trig_xwzxwz93_Func002Func005A)
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
return
endif
if (Trig_xwzxwz93_Func003C()) then
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
function Trig_xwzxwz93UP_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetKillingUnitBJ()))))and((udg_xwzxwz51[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetKillingUnitBJ()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)))
endfunction
function Trig_xwzxwz93UP_Func003C takes nothing returns boolean
return ((udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=200))
endfunction
function Trig_xwzxwz93UP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_xwzxwz93UP_Actions takes nothing returns nothing
set udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_xwzxwz93UP_Func003C()) then
set udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_xwzxwz52[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_xwzxwz52[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000亡魔之暗黑之刃|r熟练度为 ")+I2S(udg_xwzxwz52[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000亡魔之暗黑之刃|r  "+(I2S(udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/200")))
endif
if (Trig_xwzxwz93UP_Func004C()) then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,3)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,4)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,2)
endif
endfunction
function Trig_xwzxwz94_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))and((udg_xwzxwz100[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((GetAttacker()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)))
endfunction
function Trig_xwzxwz94_Func001Func007001002003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz94_Func001Func007001002003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz94_Func001Func007001002003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz94_Func001Func007001002003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz94_Func001Func007001002003002001(),Trig_xwzxwz94_Func001Func007001002003002002())
endfunction
function Trig_xwzxwz94_Func001Func007001002003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz94_Func001Func007001002003001(),Trig_xwzxwz94_Func001Func007001002003002())
endfunction
function Trig_xwzxwz94_Func001Func007A takes nothing returns nothing
set udg_xwzxwz45=(udg_xwzxwz45+1)
set udg_xwzxwz57[udg_xwzxwz45]=GetEnumUnit()
set udg_xwzxwz54[udg_xwzxwz45]=GetUnitLoc(GetEnumUnit())
call PauseUnitBJ(true,GetEnumUnit())
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\FaerieFire\\FaerieFireTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddLightningLoc("DRAM",udg_xwzxwz54[(udg_xwzxwz45-1)],udg_xwzxwz54[udg_xwzxwz45])
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),(I2R(GetHeroLevel(GetAttacker()))*(I2R(GetHeroAgi(GetAttacker(),true))*(I2R(udg_xwzxwz56[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])+1))),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
set udg_xwzxwz55[udg_xwzxwz45]=GetLastCreatedLightningBJ()
endfunction
function Trig_xwzxwz94_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=2))and((udg_xwzxwz43[2]))
endfunction
function Trig_xwzxwz94_Func002Func007001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz94_Func002Func007001003002 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz94_Func002Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz94_Func002Func007001003001(),Trig_xwzxwz94_Func002Func007001003002())
endfunction
function Trig_xwzxwz94_Func002Func007A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\Starfall\\StarfallTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),((I2R(GetHeroLevel(GetAttacker()))*I2R(GetHeroAgi(GetAttacker(),true)))*I2R(udg_xwzxwz56[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
endfunction
function Trig_xwzxwz94_Func002C takes nothing returns boolean
return ((GetUnitManaPercent(GetAttacker())>=70.00))and((GetRandomInt(1,100)<=3))
endfunction
function Trig_xwzxwz94_Func003Func008001003001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Trig_xwzxwz94_Func003Func008001003002001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz94_Func003Func008001003002002001 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz94_Func003Func008001003002002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
endfunction
function Trig_xwzxwz94_Func003Func008001003002002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz94_Func003Func008001003002002001(),Trig_xwzxwz94_Func003Func008001003002002002())
endfunction
function Trig_xwzxwz94_Func003Func008001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz94_Func003Func008001003002001(),Trig_xwzxwz94_Func003Func008001003002002())
endfunction
function Trig_xwzxwz94_Func003Func008001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz94_Func003Func008001003001(),Trig_xwzxwz94_Func003Func008001003002())
endfunction
function Trig_xwzxwz94_Func003Func008A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Other\\Tornado\\TornadoElementalSmall.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),(I2R(GetHeroAgi(GetAttacker(),false))*(I2R(udg_xwzxwz47[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))])*GetRandomReal(1.00,5.00))),true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
call SetUnitMoveSpeed(GetEnumUnit(),5.00)
call RemoveLocation(GetUnitLoc(GetEnumUnit()))
endfunction
function Trig_xwzxwz94_Func003C takes nothing returns boolean
return ((GetRandomInt(1,100)<=5))
endfunction
function Trig_xwzxwz94_Actions takes nothing returns nothing
if (Trig_xwzxwz94_Func001C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"月魔锁链")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
set udg_xwzxwz45=0
set udg_xwzxwz54[0]=GetUnitLoc(GetAttacker())
call ForGroupBJ(GetRandomSubGroup(16,GetUnitsInRangeOfLocMatching(1600.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz94_Func001Func007001002003))),function Trig_xwzxwz94_Func001Func007A)
call RemoveLocation(udg_xwzxwz54[0])
call RemoveLocation(GetUnitLoc(GetAttacker()))
call TriggerSleepAction(0.10)
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=udg_xwzxwz45
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call PauseUnitBJ(false,udg_xwzxwz57[GetForLoopIndexA()])
call DestroyLightning(udg_xwzxwz55[GetForLoopIndexA()])
set udg_xwzxwz57[GetForLoopIndexA()]=null
call RemoveLocation(udg_xwzxwz54[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
return
endif
if (Trig_xwzxwz94_Func002C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"星坠月落")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\NightElf\\Starfall\\StarfallCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(700.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz94_Func002Func007001003)),function Trig_xwzxwz94_Func002Func007A)
call RemoveLocation(GetUnitLoc(GetAttacker()))
return
endif
if (Trig_xwzxwz94_Func003C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"月晕之风")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call UnitRemoveBuffs(GetAttacker(),false,true)
call AddSpecialEffectTargetUnitBJ("origin",GetAttacker(),"Abilities\\Spells\\Other\\Tornado\\Tornado_Target.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(500.00,GetUnitLoc(GetAttacker()),Condition(function Trig_xwzxwz94_Func003Func008001003)),function Trig_xwzxwz94_Func003Func008A)
endif
endfunction
function Trig_xwzxwz9400_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetAttacker(),GetOwningPlayer(GetTriggerUnit()))))and((udg_xwzxwz100[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))and((GetTriggerUnit()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))and((IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)))
endfunction
function Trig_xwzxwz9400_Func001Func006001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz9400_Func001Func006001003002001 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetTriggerUnit()))!=true)
endfunction
function Trig_xwzxwz9400_Func001Func006001003002002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz9400_Func001Func006001003002 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz9400_Func001Func006001003002001(),Trig_xwzxwz9400_Func001Func006001003002002())
endfunction
function Trig_xwzxwz9400_Func001Func006001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz9400_Func001Func006001003001(),Trig_xwzxwz9400_Func001Func006001003002())
endfunction
function Trig_xwzxwz9400_Func001Func006A takes nothing returns nothing
call AddSpecialEffectTargetUnitBJ("overhead",GetEnumUnit(),"Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Items\\ScrollOfRejuvenation\\ScrollManaHealth.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitLifePercentBJ(GetEnumUnit(),(GetUnitLifePercent(GetEnumUnit())+SquareRoot(I2R(udg_xwzxwz56[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))))
endfunction
function Trig_xwzxwz9400_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=R2I(SquareRoot(I2R((100-R2I(GetUnitLifePercent(GetTriggerUnit()))))))))
endfunction
function Trig_xwzxwz9400_Actions takes nothing returns nothing
if (Trig_xwzxwz9400_Func001C()) then
call AddSpecialEffectTargetUnitBJ("overhead",GetTriggerUnit(),"Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("origin",GetTriggerUnit(),"Abilities\\Spells\\Items\\ScrollOfRejuvenation\\ScrollManaHealth.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitLifePercentBJ(GetTriggerUnit(),(GetUnitLifePercent(GetTriggerUnit())+SquareRoot(I2R(udg_xwzxwz56[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))))
call ForGroupBJ(GetUnitsInRangeOfLocMatching(600.00,GetUnitLoc(GetTriggerUnit()),Condition(function Trig_xwzxwz9400_Func001Func006001003)),function Trig_xwzxwz9400_Func001Func006A)
endif
endfunction
function Trig_xwzxwz94UP_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetKillingUnitBJ()))))and((udg_xwzxwz100[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetKillingUnitBJ()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)))
endfunction
function Trig_xwzxwz94UP_Func003C takes nothing returns boolean
return ((udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=200))
endfunction
function Trig_xwzxwz94UP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_xwzxwz94UP_Actions takes nothing returns nothing
set udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_xwzxwz94UP_Func003C()) then
set udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_xwzxwz56[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_xwzxwz56[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000月魔之无相金轮|r熟练度为 ")+I2S(udg_xwzxwz56[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000月魔之无相金轮|r "+(I2S(udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/200")))
endif
if (Trig_xwzxwz94UP_Func004C()) then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,3)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,4)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,2)
endif
endfunction
function Trig_xwzxwz95_Conditions takes nothing returns boolean
return ((udg_xwzxwz36[GetConvertedPlayerId(GetTriggerPlayer())]==false))
endfunction
function Trig_xwzxwz95_Actions takes nothing returns nothing
set udg_xwzxwz36[GetConvertedPlayerId(GetTriggerPlayer())]=true
set udg_xwzxwz97[GetConvertedPlayerId(GetTriggerPlayer())]=true
set udg_xwzxwz70[GetConvertedPlayerId(GetTriggerPlayer())]=1
set udg_xwzxwz37[GetConvertedPlayerId(GetTriggerPlayer())]=0
call DisplayTextToForce(GetPlayersAll(),(GetPlayerName(GetTriggerPlayer())+("  已经入了被封印的-<土魔>-"+"！ 请马上选择你要进入的英雄！")))
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function Trig_xwzxwz96_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))and((udg_xwzxwz97[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetAttacker(),UNIT_TYPE_HERO)))and((GetAttacker()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))]))and((IsUnitType(GetTriggerUnit(),UNIT_TYPE_STRUCTURE)!=true))
endfunction
function Trig_xwzxwz96_Func001C takes nothing returns boolean
return ((GetRandomInt(1,100)<=2))
endfunction
function Trig_xwzxwz96_Func002C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_xwzxwz96_Func003C takes nothing returns boolean
return ((GetRandomInt(1,100)<=1))
endfunction
function Trig_xwzxwz96_Func004C takes nothing returns boolean
return ((GetRandomInt(1,1000)<=5))and((GetUnitLifePercent(GetAttacker())>60.00))and((GetUnitLevel(GetAttacker())>30))
endfunction
function Trig_xwzxwz96_Func005C takes nothing returns boolean
return ((GetRandomInt(1,1000)<=2))and((GetUnitLifePercent(GetAttacker())>60.00))and((GetUnitLevel(GetAttacker())>50))
endfunction
function Trig_xwzxwz96_Actions takes nothing returns nothing
if (Trig_xwzxwz96_Func001C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"疾行土封")+"|r ")+"|cFFFF00334式|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
set udg_xwzxwz65=GetAttacker()
call PauseUnitBJ(true,udg_xwzxwz65)
call SetUnitPathing(udg_xwzxwz65,false)
set udg_xwzxwz69=GetTriggerUnit()
call PauseUnitBJ(true,udg_xwzxwz69)
set udg_xwzxwz67[0]=GetUnitLoc(GetTriggerUnit())
set udg_xwzxwz68=0
call EnableTrigger(gg_trg_xwzxwz97F4)
return
endif
if (Trig_xwzxwz96_Func002C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"地遁连击")+"|r ")+"|cFFFF003316式|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
set udg_xwzxwz68=16
set udg_xwzxwz65=GetAttacker()
set udg_xwzxwz69=GetTriggerUnit()
call SetUnitPathing(udg_xwzxwz65,false)
call PauseUnitBJ(true,udg_xwzxwz65)
call EnableTrigger(gg_trg_xwzxwz97F16)
return
endif
if (Trig_xwzxwz96_Func003C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"地魔怒杀")+"|r ")+"|cFFFF003332式|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
set udg_xwzxwz65=GetAttacker()
set udg_xwzxwz69=GetTriggerUnit()
call PauseUnitBJ(true,udg_xwzxwz65)
call PauseUnitBJ(true,udg_xwzxwz69)
call TriggerExecute(gg_trg_xwzxwz97F32)
return
endif
if (Trig_xwzxwz96_Func004C()) then
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"伤残狂击")+"|r ")+"|cFFFF003364式|r"),GetAttacker(),0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
set udg_xwzxwz65=GetAttacker()
set udg_xwzxwz69=GetTriggerUnit()
set udg_xwzxwz68=0
call PauseUnitBJ(true,udg_xwzxwz65)
call PauseUnitBJ(true,udg_xwzxwz69)
call SetUnitLifePercentBJ(udg_xwzxwz65,(GetUnitLifePercent(udg_xwzxwz65)-50.00))
set udg_xwzxwz46[888]=AddSpecialEffectTargetUnitBJ("weapon",GetAttacker(),"Abilities\\Weapons\\IllidanMissile\\IllidanMissile.mdl")
set udg_xwzxwz46[889]=AddSpecialEffectTargetUnitBJ("weapon",GetAttacker(),"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
call EnableTrigger(gg_trg_xwzxwz97F64)
call EnableTrigger(gg_trg_xwzxwz97F64death)
return
endif
if (Trig_xwzxwz96_Func005C()) then
set udg_xwzxwz65=GetAttacker()
call PanCameraToTimed(GetLocationX(GetUnitLoc(udg_xwzxwz65)),GetLocationY(GetUnitLoc(udg_xwzxwz65)),0.30)
call SetCameraField(CAMERA_FIELD_TARGET_DISTANCE,4000.00,0)
call ConditionalTriggerExecute(gg_trg_xwzxwz97Screct)
call CreateTextTagUnitBJ(((("|cFFFFFF00"+"土魔密式")+"|r ")+"|cFFFF0033发动|r"),GetAttacker(),0,20.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
endif
endfunction
function Trig_xwzxwz97F4_Func009001003001001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz97F4_Func009001003001002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_xwzxwz65)))
endfunction
function Trig_xwzxwz97F4_Func009001003001 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz97F4_Func009001003001001(),Trig_xwzxwz97F4_Func009001003001002())
endfunction
function Trig_xwzxwz97F4_Func009001003002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz97F4_Func009001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz97F4_Func009001003001(),Trig_xwzxwz97F4_Func009001003002())
endfunction
function Trig_xwzxwz97F4_Func009A takes nothing returns nothing
call SetUnitPositionLoc(GetEnumUnit(),udg_xwzxwz67[0])
call UnitDamageTargetBJ(udg_xwzxwz65,GetEnumUnit(),((I2R(GetHeroLevel(udg_xwzxwz65))*I2R(GetHeroAgi(udg_xwzxwz65,false)))*I2R(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(udg_xwzxwz65))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
endfunction
function Trig_xwzxwz97F4_Func011C takes nothing returns boolean
return ((udg_xwzxwz68>24))
endfunction
function Trig_xwzxwz97F4_Actions takes nothing returns nothing
set udg_xwzxwz68=(udg_xwzxwz68+1)
set udg_xwzxwz67[1]=PolarProjectionBJ(udg_xwzxwz67[0],500.00,(((I2R(udg_xwzxwz68)-1)*15.00)+GetUnitFacing(udg_xwzxwz69)))
call SetUnitPositionLocFacingBJ(udg_xwzxwz65,udg_xwzxwz67[1],(AngleBetweenPoints(udg_xwzxwz67[0],udg_xwzxwz67[1])+90.00))
call AddSpecialEffectLocBJ(udg_xwzxwz67[1],"Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitAnimation(udg_xwzxwz65,"Walk")
call AddSpecialEffectTargetUnitBJ("weapon",udg_xwzxwz65,"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call ForGroupBJ(GetUnitsInRangeOfLocMatching(80.00,udg_xwzxwz67[1],Condition(function Trig_xwzxwz97F4_Func009001003)),function Trig_xwzxwz97F4_Func009A)
call RemoveLocation(udg_xwzxwz67[1])
if (Trig_xwzxwz97F4_Func011C()) then
call DisableTrigger(GetTriggeringTrigger())
call EnableTrigger(gg_trg_xwzxwz97F40)
call AddSpecialEffectTargetUnitBJ("weapon",udg_xwzxwz65,"Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SetUnitTimeScalePercent(udg_xwzxwz65,200.00)
call SetUnitAnimation(udg_xwzxwz65,"Attack")
set udg_xwzxwz67[1]=PolarProjectionBJ(udg_xwzxwz67[0],100.00,0)
call SetUnitPositionLocFacingLocBJ(udg_xwzxwz65,udg_xwzxwz67[1],udg_xwzxwz67[0])
set udg_xwzxwz684=0
call RemoveLocation(udg_xwzxwz67[1])
endif
endfunction
function Trig_xwzxwz97F40_Func006C takes nothing returns boolean
return ((udg_xwzxwz684==1))and((IsUnitAliveBJ(udg_xwzxwz69)))
endfunction
function Trig_xwzxwz97F40_Func007C takes nothing returns boolean
return ((udg_xwzxwz684==2))and((IsUnitAliveBJ(udg_xwzxwz69)))
endfunction
function Trig_xwzxwz97F40_Func008C takes nothing returns boolean
return ((udg_xwzxwz684==3))and((IsUnitAliveBJ(udg_xwzxwz69)))
endfunction
function Trig_xwzxwz97F40_Func009C takes nothing returns boolean
return ((udg_xwzxwz684==4))and((IsUnitAliveBJ(udg_xwzxwz69)))
endfunction
function Trig_xwzxwz97F40_Func010C takes nothing returns boolean
return ((udg_xwzxwz684>=4))
endfunction
function Trig_xwzxwz97F40_Actions takes nothing returns nothing
set udg_xwzxwz684=(udg_xwzxwz684+1)
call CreateTextTagUnitBJ(((("|cFFFFFF00"+I2S(udg_xwzxwz684))+"|r ")+"|cFFFF0033式|r"),udg_xwzxwz69,0,10.00,10.00,80.00,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),70.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
if (Trig_xwzxwz97F40_Func006C()) then
call SetUnitAnimation(udg_xwzxwz65,"Attack")
call SetUnitAnimation(udg_xwzxwz69,"death")
call AddSpecialEffectTargetUnitBJ("weapon",udg_xwzxwz65,"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("weapon",udg_xwzxwz65,"Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
set udg_xwzxwz67[1]=PolarProjectionBJ(udg_xwzxwz67[0],100.00,180.00)
call SetUnitPositionLocFacingBJ(udg_xwzxwz65,udg_xwzxwz67[1],(AngleBetweenPoints(udg_xwzxwz67[0],udg_xwzxwz67[1])+0.00))
call UnitDamageTargetBJ(udg_xwzxwz65,udg_xwzxwz69,(I2R(udg_xwzxwz684)*(I2R(GetHeroAgi(udg_xwzxwz65,false))*I2R(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(udg_xwzxwz65))]))),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
call RemoveLocation(udg_xwzxwz67[1])
endif
if (Trig_xwzxwz97F40_Func007C()) then
call SetUnitAnimation(udg_xwzxwz65,"Attack")
call AddSpecialEffectTargetUnitBJ("weapon",udg_xwzxwz65,"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("weapon",udg_xwzxwz65,"Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
set udg_xwzxwz67[1]=PolarProjectionBJ(udg_xwzxwz67[0],100.00,0.00)
call SetUnitPositionLocFacingBJ(udg_xwzxwz65,udg_xwzxwz67[1],(AngleBetweenPoints(udg_xwzxwz67[0],udg_xwzxwz67[1])+0.00))
call RemoveLocation(udg_xwzxwz67[1])
call UnitDamageTargetBJ(udg_xwzxwz65,udg_xwzxwz69,(I2R(udg_xwzxwz684)*(I2R(GetHeroAgi(udg_xwzxwz65,false))*I2R(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(udg_xwzxwz65))]))),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
set udg_xwzxwz67[1]=PolarProjectionBJ(udg_xwzxwz67[0],100.00,90.00)
call SetUnitPositionLocFacingBJ(udg_xwzxwz65,udg_xwzxwz67[1],(AngleBetweenPoints(udg_xwzxwz67[0],udg_xwzxwz67[1])+0.00))
call RemoveLocation(udg_xwzxwz67[1])
call SetUnitAnimation(udg_xwzxwz69,"death")
endif
if (Trig_xwzxwz97F40_Func008C()) then
call SetUnitAnimation(udg_xwzxwz65,"Attack")
call AddSpecialEffectTargetUnitBJ("weapon",udg_xwzxwz65,"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("weapon",udg_xwzxwz65,"Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
set udg_xwzxwz67[1]=PolarProjectionBJ(udg_xwzxwz67[0],100.00,270.00)
call SetUnitPositionLocFacingBJ(udg_xwzxwz65,udg_xwzxwz67[1],(AngleBetweenPoints(udg_xwzxwz67[0],udg_xwzxwz67[1])+0.00))
call UnitDamageTargetBJ(udg_xwzxwz65,udg_xwzxwz69,(I2R(udg_xwzxwz684)*(I2R(GetHeroAgi(udg_xwzxwz65,false))*I2R(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(udg_xwzxwz65))]))),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
call RemoveLocation(udg_xwzxwz67[1])
call SetUnitAnimation(udg_xwzxwz69,"death")
endif
if (Trig_xwzxwz97F40_Func009C()) then
call SetUnitAnimation(udg_xwzxwz65,"Attack")
call AddSpecialEffectTargetUnitBJ("weapon",udg_xwzxwz65,"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectTargetUnitBJ("weapon",udg_xwzxwz65,"Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
set udg_xwzxwz67[1]=PolarProjectionBJ(udg_xwzxwz67[0],100.00,90.00)
call SetUnitPositionLocFacingBJ(udg_xwzxwz65,udg_xwzxwz67[1],(AngleBetweenPoints(udg_xwzxwz67[0],udg_xwzxwz67[1])+0.00))
call UnitDamageTargetBJ(udg_xwzxwz65,udg_xwzxwz69,(I2R(udg_xwzxwz684)*(I2R(GetHeroAgi(udg_xwzxwz65,false))*I2R(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(udg_xwzxwz65))]))),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
call RemoveLocation(udg_xwzxwz67[1])
call SetUnitAnimation(udg_xwzxwz69,"death")
endif
if (Trig_xwzxwz97F40_Func010C()) then
call DisableTrigger(GetTriggeringTrigger())
call PauseUnitBJ(false,udg_xwzxwz65)
call PauseUnitBJ(false,udg_xwzxwz69)
call SetUnitInvulnerable(udg_xwzxwz65,false)
call SetUnitPathing(udg_xwzxwz65,true)
call ResetUnitAnimation(udg_xwzxwz65)
call SetUnitTimeScalePercent(udg_xwzxwz65,100.00)
call RemoveLocation(udg_xwzxwz67[0])
call ResetUnitAnimation(udg_xwzxwz69)
endif
endfunction
function Trig_xwzxwz97F16_Func003002001003001001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz97F16_Func003002001003001002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_xwzxwz65)))
endfunction
function Trig_xwzxwz97F16_Func003002001003001 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz97F16_Func003002001003001001(),Trig_xwzxwz97F16_Func003002001003001002())
endfunction
function Trig_xwzxwz97F16_Func003002001003002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz97F16_Func003002001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz97F16_Func003002001003001(),Trig_xwzxwz97F16_Func003002001003002())
endfunction
function Trig_xwzxwz97F16_Func018Func007Func002001001003001001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz97F16_Func018Func007Func002001001003001002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_xwzxwz65)))
endfunction
function Trig_xwzxwz97F16_Func018Func007Func002001001003001 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz97F16_Func018Func007Func002001001003001001(),Trig_xwzxwz97F16_Func018Func007Func002001001003001002())
endfunction
function Trig_xwzxwz97F16_Func018Func007Func002001001003002 takes nothing returns boolean
return (IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction
function Trig_xwzxwz97F16_Func018Func007Func002001001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz97F16_Func018Func007Func002001001003001(),Trig_xwzxwz97F16_Func018Func007Func002001001003002())
endfunction
function Trig_xwzxwz97F16_Func018Func007C takes nothing returns boolean
return ((udg_xwzxwz68<1))or((CountUnitsInGroup(GetUnitsInRangeOfLocMatching(312.00,GetUnitLoc(udg_xwzxwz65),Condition(function Trig_xwzxwz97F16_Func018Func007Func002001001003)))<1))
endfunction
function Trig_xwzxwz97F16_Func018C takes nothing returns boolean
return (Trig_xwzxwz97F16_Func018Func007C())
endfunction
function Trig_xwzxwz97F16_Actions takes nothing returns nothing
call SetUnitVertexColorBJ(udg_xwzxwz65,0.00,0.00,0.00,70.00)
call ResetUnitAnimation(udg_xwzxwz65)
set udg_xwzxwz71=GroupPickRandomUnit(GetUnitsInRangeOfLocMatching(300.00,GetUnitLoc(udg_xwzxwz69),Condition(function Trig_xwzxwz97F16_Func003002001003)))
call AddSpecialEffectTargetUnitBJ("weapon",udg_xwzxwz65,"units\\orc\\SpiritWyvern\\SpiritWyvern.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call SelectUnitRemoveForPlayer(udg_xwzxwz65,GetOwningPlayer(udg_xwzxwz65))
call SetUnitAnimation(udg_xwzxwz65,"Attack")
call SetUnitPositionLocFacingBJ(udg_xwzxwz65,GetUnitLoc(udg_xwzxwz71),(180.00-GetUnitFacing(udg_xwzxwz71)))
call CreateTextTagUnitBJ((I2S(udg_xwzxwz68)+" Hits"),udg_xwzxwz71,0,10,0.00,100,0.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectLocBJ(GetUnitLoc(udg_xwzxwz71),"Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_xwzxwz65,udg_xwzxwz71,(((I2R(udg_xwzxwz68)*I2R(GetHeroLevel(udg_xwzxwz65)))*I2R(GetHeroAgi(udg_xwzxwz65,false)))*I2R(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(udg_xwzxwz65))])),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
set udg_xwzxwz69=udg_xwzxwz71
set udg_xwzxwz68=(udg_xwzxwz68-1)
if (Trig_xwzxwz97F16_Func018C()) then
call DisableTrigger(GetTriggeringTrigger())
call SetUnitPathing(udg_xwzxwz65,true)
call SelectUnitForPlayerSingle(udg_xwzxwz65,GetOwningPlayer(udg_xwzxwz65))
call PauseUnitBJ(false,udg_xwzxwz65)
call SetUnitInvulnerable(udg_xwzxwz65,false)
call SetUnitVertexColorBJ(udg_xwzxwz65,100,100,100,0)
endif
endfunction
function Trig_xwzxwz97F32_Func003Func001Func015C takes nothing returns boolean
return ((GetRandomInt(1,100)>=40))
endfunction
function Trig_xwzxwz97F32_Func003Func001C takes nothing returns boolean
return ((IsUnitAliveBJ(udg_xwzxwz69)))
endfunction
function Trig_xwzxwz97F32_Actions takes nothing returns nothing
call SelectUnitRemoveForPlayer(udg_xwzxwz65,GetOwningPlayer(udg_xwzxwz65))
call SetUnitTimeScalePercent(udg_xwzxwz65,500.00)
set bj_forLoopBIndex=1
set bj_forLoopBIndexEnd=32
loop
exitwhen bj_forLoopBIndex>bj_forLoopBIndexEnd
if (Trig_xwzxwz97F32_Func003Func001C()) then
call CreateTextTagUnitBJ((I2S(GetForLoopIndexB())+" Hits"),udg_xwzxwz69,0,10,0.00,100,60.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),200.00,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call SetUnitAnimation(udg_xwzxwz65,"attack")
call SetUnitAnimation(udg_xwzxwz69,"death")
call AddSpecialEffectTargetUnitBJ("chest",udg_xwzxwz69,"Abilities\\Spells\\Other\\Volcano\\VolcanoDeath.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddLightningLoc("HWPB",GetUnitLoc(udg_xwzxwz69),PolarProjectionBJ(GetUnitLoc(udg_xwzxwz69),700.00,(I2R(GetForLoopIndexB())*11.25)))
call SetLightningColor(GetLastCreatedLightningBJ(),0.20,1,0.20,0.40)
set udg_xwzxwz28[(100+GetForLoopIndexB())]=GetLastCreatedLightningBJ()
call AddSpecialEffectTargetUnitBJ("origin",udg_xwzxwz69,"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
if (Trig_xwzxwz97F32_Func003Func001Func015C()) then
call AddSpecialEffectLocBJ(GetUnitLoc(udg_xwzxwz69),"Objects\\Spawnmodels\\Other\\ToonBoom\\ToonBoom.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
endif
call UnitDamageTargetBJ(udg_xwzxwz65,udg_xwzxwz69,(((I2R(GetForLoopIndexB())*I2R(GetHeroLevel(udg_xwzxwz65)))*I2R(GetHeroAgi(udg_xwzxwz65,false)))*I2R(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(udg_xwzxwz65))])),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
call TriggerSleepAction(0.10)
else
call ResetUnitAnimation(udg_xwzxwz69)
endif
set bj_forLoopBIndex=bj_forLoopBIndex+1
endloop
call SetUnitInvulnerable(udg_xwzxwz65,false)
call SetUnitTimeScalePercent(udg_xwzxwz65,100)
call PauseUnitBJ(false,udg_xwzxwz69)
call IssueImmediateOrder(udg_xwzxwz65,"stop")
call PauseUnitBJ(false,udg_xwzxwz65)
set bj_forLoopAIndex=100
set bj_forLoopAIndexEnd=135
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyLightning(udg_xwzxwz28[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call DisableTrigger(GetTriggeringTrigger())
endfunction
function Trig_xwzxwz97F64_Func002Func001C takes nothing returns boolean
return ((udg_xwzxwz68>4))
endfunction
function Trig_xwzxwz97F64_Func002C takes nothing returns boolean
return ((udg_xwzxwz68==1))
endfunction
function Trig_xwzxwz97F64_Actions takes nothing returns nothing
set udg_xwzxwz68=(udg_xwzxwz68+1)
if (Trig_xwzxwz97F64_Func002C()) then
call CreateTextTagUnitBJ(("伤残狂击"+" 4连"),udg_xwzxwz65,0,20.00,0.00,100,0.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
call AddSpecialEffectTargetUnitBJ("weapon",udg_xwzxwz65,"Abilities\\Weapons\\IllidanMissile\\IllidanMissile.mdl")
set udg_xwzxwz67[67]=PolarProjectionBJ(udg_xwzxwz67[66],200.00,270.00)
call SetUnitPositionLocFacingBJ(udg_xwzxwz65,udg_xwzxwz67[67],AngleBetweenPoints(udg_xwzxwz67[65],udg_xwzxwz67[66]))
call DestroyEffect(GetLastCreatedEffectBJ())
else
if (Trig_xwzxwz97F64_Func002Func001C()) then
call DisableTrigger(GetTriggeringTrigger())
set udg_xwzxwz68=4
call TriggerSleepAction(0.50)
call EnableTrigger(gg_trg_xwzxwz97F6z16)
call SetUnitTimeScalePercent(udg_xwzxwz65,200.00)
return
endif
endif
set udg_xwzxwz67[65]=GetUnitLoc(udg_xwzxwz65)
set udg_xwzxwz67[66]=GetUnitLoc(udg_xwzxwz69)
set udg_xwzxwz67[67]=PolarProjectionBJ(udg_xwzxwz67[65],(DistanceBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65])/2.00),AngleBetweenPoints(udg_xwzxwz67[65],udg_xwzxwz67[66]))
call PanCameraToTimedLocForPlayer(GetOwningPlayer(udg_xwzxwz65),udg_xwzxwz67[67],2.00)
call RemoveLocation(udg_xwzxwz67[67])
call SetCameraFieldForPlayer(GetOwningPlayer(udg_xwzxwz65),CAMERA_FIELD_ROTATION,(AngleBetweenPoints(udg_xwzxwz67[65],udg_xwzxwz67[66])+90.00),2.00)
set udg_xwzxwz67[67]=PolarProjectionBJ(udg_xwzxwz67[66],200.00,(I2R(udg_xwzxwz68)*90.00))
call PanCameraToTimedLocForPlayer(GetOwningPlayer(udg_xwzxwz65),udg_xwzxwz67[67],0.30)
call AddSpecialEffectTargetUnitBJ("weapon",udg_xwzxwz65,"Abilities\\Weapons\\IllidanMissile\\IllidanMissile.mdl")
call SetUnitAnimation(udg_xwzxwz65,"attack")
call SetUnitPositionLocFacingBJ(udg_xwzxwz65,udg_xwzxwz67[67],AngleBetweenPoints(udg_xwzxwz67[65],udg_xwzxwz67[66]))
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_xwzxwz65,udg_xwzxwz69,(((I2R(udg_xwzxwz68)*I2R(GetHeroLevel(udg_xwzxwz65)))*I2R(GetHeroAgi(udg_xwzxwz65,false)))*I2R(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(udg_xwzxwz65))])),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
call AddSpecialEffectLocBJ(udg_xwzxwz67[66],"Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call RemoveLocation(udg_xwzxwz67[67])
call RemoveLocation(udg_xwzxwz67[65])
endfunction
function Trig_xwzxwz97F6z16_Func002Func001C takes nothing returns boolean
return ((udg_xwzxwz68>21))
endfunction
function Trig_xwzxwz97F6z16_Func002C takes nothing returns boolean
return ((udg_xwzxwz68==5))
endfunction
function Trig_xwzxwz97F6z16_Func012C takes nothing returns boolean
return ((ModuloInteger(udg_xwzxwz68,2)==1))
endfunction
function Trig_xwzxwz97F6z16_Actions takes nothing returns nothing
set udg_xwzxwz68=(udg_xwzxwz68+1)
if (Trig_xwzxwz97F6z16_Func002C()) then
call CreateTextTagUnitBJ(("伤残狂击"+" 16连"),udg_xwzxwz65,0,20.00,0.00,100,0.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
else
if (Trig_xwzxwz97F6z16_Func002Func001C()) then
call DisableTrigger(GetTriggeringTrigger())
set udg_xwzxwz68=21
call TriggerSleepAction(1.00)
call EnableTrigger(gg_trg_xwzxwz97F6z32)
call SetUnitTimeScalePercent(udg_xwzxwz65,500.00)
return
endif
endif
set udg_xwzxwz67[65]=GetUnitLoc(udg_xwzxwz65)
set udg_xwzxwz67[66]=GetUnitLoc(udg_xwzxwz69)
set udg_xwzxwz67[67]=PolarProjectionBJ(udg_xwzxwz67[65],(DistanceBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65])/2.00),AngleBetweenPoints(udg_xwzxwz67[65],udg_xwzxwz67[66]))
call PanCameraToTimedLocForPlayer(GetOwningPlayer(udg_xwzxwz65),udg_xwzxwz67[67],2.00)
call RemoveLocation(udg_xwzxwz67[67])
call SetCameraFieldForPlayer(GetOwningPlayer(udg_xwzxwz65),CAMERA_FIELD_ROTATION,(AngleBetweenPoints(udg_xwzxwz67[65],udg_xwzxwz67[66])+90.00),2.00)
set udg_xwzxwz67[67]=PolarProjectionBJ(udg_xwzxwz67[66],200.00,(I2R(udg_xwzxwz68)*90.00))
call PanCameraToTimedLocForPlayer(GetOwningPlayer(udg_xwzxwz65),udg_xwzxwz67[67],0.30)
if (Trig_xwzxwz97F6z16_Func012C()) then
set udg_xwzxwz67[67]=PolarProjectionBJ(udg_xwzxwz67[66],300.00,(AngleBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65])+180.00))
call AddSpecialEffectTargetUnitBJ("weapon",udg_xwzxwz65,"Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl")
call SetUnitAnimation(udg_xwzxwz65,"attack")
call SetUnitPositionLocFacingBJ(udg_xwzxwz65,udg_xwzxwz67[67],AngleBetweenPoints(udg_xwzxwz67[65],udg_xwzxwz67[66]))
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_xwzxwz65,udg_xwzxwz69,(((I2R(udg_xwzxwz68)*I2R(GetHeroLevel(udg_xwzxwz65)))*I2R(GetHeroAgi(udg_xwzxwz65,false)))*I2R(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(udg_xwzxwz65))])),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
call RemoveLocation(udg_xwzxwz67[67])
else
set udg_xwzxwz67[67]=PolarProjectionBJ(udg_xwzxwz67[66],300.00,(AngleBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65])+22.50))
call AddSpecialEffectTargetUnitBJ("weapon",udg_xwzxwz65,"Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl")
call SetUnitAnimation(udg_xwzxwz65,"attack")
call SetUnitPositionLocFacingBJ(udg_xwzxwz65,udg_xwzxwz67[67],AngleBetweenPoints(udg_xwzxwz67[65],udg_xwzxwz67[66]))
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_xwzxwz65,udg_xwzxwz69,(((I2R(udg_xwzxwz68)*I2R(GetHeroLevel(udg_xwzxwz65)))*I2R(GetHeroAgi(udg_xwzxwz65,false)))*I2R(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(udg_xwzxwz65))])),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
call RemoveLocation(udg_xwzxwz67[67])
endif
call AddSpecialEffectLocBJ(udg_xwzxwz67[66],"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(udg_xwzxwz67[66],"Abilities\\Spells\\Human\\Polymorph\\PolyMorphTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
set udg_xwzxwz67[80]=PolarProjectionBJ(udg_xwzxwz67[66],350.00,(AngleBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65])+0.00))
set udg_xwzxwz67[81]=PolarProjectionBJ(udg_xwzxwz67[66],350.00,(AngleBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65])+90.00))
set udg_xwzxwz67[82]=PolarProjectionBJ(udg_xwzxwz67[66],350.00,(AngleBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65])+180.00))
set udg_xwzxwz67[83]=PolarProjectionBJ(udg_xwzxwz67[66],350.00,(AngleBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65])+270.00))
call AddLightningLoc("HWPB",udg_xwzxwz67[80],udg_xwzxwz67[81])
call SetLightningColor(GetLastCreatedLightningBJ(),GetRandomReal(0,1),GetRandomReal(0,1),GetRandomReal(0,1),1)
set udg_xwzxwz55[(80+udg_xwzxwz68)]=GetLastCreatedLightningBJ()
call AddLightningLoc("HWPB",udg_xwzxwz67[81],udg_xwzxwz67[82])
call SetLightningColor(GetLastCreatedLightningBJ(),GetRandomReal(0,1),GetRandomReal(0,1),GetRandomReal(0,1),1)
set udg_xwzxwz55[(110+udg_xwzxwz68)]=GetLastCreatedLightningBJ()
call AddLightningLoc("HWPB",udg_xwzxwz67[82],udg_xwzxwz67[83])
call SetLightningColor(GetLastCreatedLightningBJ(),GetRandomReal(0,1),GetRandomReal(0,1),GetRandomReal(0,1),1)
set udg_xwzxwz55[(140+udg_xwzxwz68)]=GetLastCreatedLightningBJ()
call AddLightningLoc("HWPB",udg_xwzxwz67[83],udg_xwzxwz67[80])
call SetLightningColor(GetLastCreatedLightningBJ(),GetRandomReal(0,1),GetRandomReal(0,1),GetRandomReal(0,1),1)
set udg_xwzxwz55[(170+udg_xwzxwz68)]=GetLastCreatedLightningBJ()
call RemoveLocation(udg_xwzxwz67[67])
call RemoveLocation(udg_xwzxwz67[65])
endfunction
function Trig_xwzxwz97F6z32_Func002Func001C takes nothing returns boolean
return ((udg_xwzxwz68>54))
endfunction
function Trig_xwzxwz97F6z32_Func002C takes nothing returns boolean
return ((udg_xwzxwz68==22))
endfunction
function Trig_xwzxwz97F6z32_Func031001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_xwzxwz97F6z32_Func031001003002 takes nothing returns boolean
return (IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(udg_xwzxwz65)))
endfunction
function Trig_xwzxwz97F6z32_Func031001003 takes nothing returns boolean
return GetBooleanAnd(Trig_xwzxwz97F6z32_Func031001003001(),Trig_xwzxwz97F6z32_Func031001003002())
endfunction
function Trig_xwzxwz97F6z32_Func031A takes nothing returns nothing
call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\Undead\\Impale\\ImpaleHitTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_xwzxwz65,udg_xwzxwz69,(((1.00*I2R(GetHeroLevel(udg_xwzxwz65)))*I2R(GetHeroAgi(udg_xwzxwz65,false)))*I2R(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(udg_xwzxwz65))])),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
endfunction
function Trig_xwzxwz97F6z32_Actions takes nothing returns nothing
set udg_xwzxwz68=(udg_xwzxwz68+1)
if (Trig_xwzxwz97F6z32_Func002C()) then
call CreateTextTagUnitBJ(("伤残狂击"+" 32连"),udg_xwzxwz65,0,20.00,0.00,100,0.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
set bj_forLoopAIndex=80
set bj_forLoopAIndexEnd=240
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyLightning(udg_xwzxwz55[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
else
if (Trig_xwzxwz97F6z32_Func002Func001C()) then
call DisableTrigger(GetTriggeringTrigger())
set udg_xwzxwz68=54
call TriggerSleepAction(1.00)
call EnableTrigger(gg_trg_xwzxwz97F6z64)
call SetUnitTimeScalePercent(udg_xwzxwz65,800.00)
return
endif
endif
set udg_xwzxwz67[65]=GetUnitLoc(udg_xwzxwz65)
set udg_xwzxwz67[66]=GetUnitLoc(udg_xwzxwz69)
set udg_xwzxwz67[67]=PolarProjectionBJ(udg_xwzxwz67[65],(DistanceBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65])/2.00),AngleBetweenPoints(udg_xwzxwz67[65],udg_xwzxwz67[66]))
call PanCameraToTimedLocForPlayer(GetOwningPlayer(udg_xwzxwz65),udg_xwzxwz67[67],2.00)
call RemoveLocation(udg_xwzxwz67[67])
call SetCameraFieldForPlayer(GetOwningPlayer(udg_xwzxwz65),CAMERA_FIELD_ROTATION,(AngleBetweenPoints(udg_xwzxwz67[65],udg_xwzxwz67[66])+90.00),2.00)
set udg_xwzxwz67[67]=PolarProjectionBJ(udg_xwzxwz67[66],30.00,GetRandomReal(0,360.00))
call SetUnitPositionLocFacingBJ(udg_xwzxwz69,udg_xwzxwz67[67],AngleBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65]))
call PanCameraToTimedLocForPlayer(GetOwningPlayer(udg_xwzxwz65),udg_xwzxwz67[67],0.30)
call RemoveLocation(udg_xwzxwz67[67])
call RemoveLocation(udg_xwzxwz67[66])
set udg_xwzxwz67[66]=GetUnitLoc(udg_xwzxwz69)
set udg_xwzxwz67[67]=PolarProjectionBJ(udg_xwzxwz67[66],35.00,GetRandomReal(0,360.00))
call SetUnitAnimation(udg_xwzxwz65,"attack")
call AddSpecialEffectTargetUnitBJ("weapon",udg_xwzxwz65,"Abilities\\Weapons\\ZigguratMissile\\ZigguratMissile.mdl")
call SetUnitPositionLocFacingBJ(udg_xwzxwz65,udg_xwzxwz67[67],AngleBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65]))
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(udg_xwzxwz67[66],"Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(udg_xwzxwz67[66],"Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(udg_xwzxwz67[66],"Abilities\\Spells\\NightElf\\EntangleMine\\Roots.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_xwzxwz65,udg_xwzxwz69,(((I2R(udg_xwzxwz68)*I2R(GetHeroLevel(udg_xwzxwz65)))*I2R(GetHeroAgi(udg_xwzxwz65,false)))*I2R(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(udg_xwzxwz65))])),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
call RemoveLocation(udg_xwzxwz67[67])
set bj_forLoopBIndex=1
set bj_forLoopBIndexEnd=20
loop
exitwhen bj_forLoopBIndex>bj_forLoopBIndexEnd
set udg_xwzxwz67[67]=PolarProjectionBJ(udg_xwzxwz67[66],500.00,(I2R(GetForLoopIndexB())*18.00))
call AddSpecialEffectLocBJ(udg_xwzxwz67[67],"Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call RemoveLocation(udg_xwzxwz67[67])
set bj_forLoopBIndex=bj_forLoopBIndex+1
endloop
call ForGroupBJ(GetUnitsInRangeOfLocMatching(500.00,udg_xwzxwz67[66],Condition(function Trig_xwzxwz97F6z32_Func031001003)),function Trig_xwzxwz97F6z32_Func031A)
call RemoveLocation(udg_xwzxwz67[66])
call RemoveLocation(udg_xwzxwz67[65])
endfunction
function Trig_xwzxwz97F6z64_Func002Func001C takes nothing returns boolean
return ((udg_xwzxwz68>64))
endfunction
function Trig_xwzxwz97F6z64_Func002C takes nothing returns boolean
return ((udg_xwzxwz68==55))
endfunction
function Trig_xwzxwz97F6z64_Func012C takes nothing returns boolean
return ((ModuloInteger(udg_xwzxwz68,2)==1))
endfunction
function Trig_xwzxwz97F6z64_Actions takes nothing returns nothing
set udg_xwzxwz68=(udg_xwzxwz68+1)
if (Trig_xwzxwz97F6z64_Func002C()) then
call CreateTextTagUnitBJ(("伤残狂击"+" 64连"),udg_xwzxwz65,0,20.00,0.00,100,0.00,0)
call SetTextTagVelocityBJ(GetLastCreatedTextTag(),64,90)
call SetTextTagPermanent(GetLastCreatedTextTag(),false)
call SetTextTagLifespan(GetLastCreatedTextTag(),2.00)
else
if (Trig_xwzxwz97F6z64_Func002Func001C()) then
call DisableTrigger(GetTriggeringTrigger())
set udg_xwzxwz68=0
call PauseUnitBJ(false,udg_xwzxwz65)
call PauseUnitBJ(false,udg_xwzxwz69)
call SetUnitInvulnerable(udg_xwzxwz65,false)
call ResetUnitAnimation(udg_xwzxwz65)
call SetUnitTimeScalePercent(udg_xwzxwz65,100)
call ResetToGameCameraForPlayer(GetOwningPlayer(udg_xwzxwz65),0.50)
call DestroyEffect(udg_xwzxwz46[888])
call DestroyEffect(udg_xwzxwz46[889])
set bj_forLoopAIndex=120
set bj_forLoopAIndexEnd=350
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyLightning(udg_xwzxwz55[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
endif
endif
set udg_xwzxwz67[65]=GetUnitLoc(udg_xwzxwz65)
set udg_xwzxwz67[66]=GetUnitLoc(udg_xwzxwz69)
set udg_xwzxwz67[67]=PolarProjectionBJ(udg_xwzxwz67[65],(DistanceBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65])/2.00),AngleBetweenPoints(udg_xwzxwz67[65],udg_xwzxwz67[66]))
call PanCameraToTimedLocForPlayer(GetOwningPlayer(udg_xwzxwz65),udg_xwzxwz67[67],2.00)
call RemoveLocation(udg_xwzxwz67[67])
call SetCameraFieldForPlayer(GetOwningPlayer(udg_xwzxwz65),CAMERA_FIELD_ROTATION,(AngleBetweenPoints(udg_xwzxwz67[65],udg_xwzxwz67[66])+90.00),2.00)
set udg_xwzxwz67[67]=PolarProjectionBJ(udg_xwzxwz67[66],200.00,(I2R(udg_xwzxwz68)*90.00))
call PanCameraToTimedLocForPlayer(GetOwningPlayer(udg_xwzxwz65),udg_xwzxwz67[67],0.30)
if (Trig_xwzxwz97F6z64_Func012C()) then
set udg_xwzxwz67[67]=PolarProjectionBJ(udg_xwzxwz67[66],300.00,(AngleBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65])+180.00))
call AddSpecialEffectTargetUnitBJ("weapon",udg_xwzxwz65,"Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl")
call SetUnitAnimation(udg_xwzxwz65,"attack")
call SetUnitPositionLocFacingBJ(udg_xwzxwz65,udg_xwzxwz67[67],AngleBetweenPoints(udg_xwzxwz67[65],udg_xwzxwz67[66]))
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_xwzxwz65,udg_xwzxwz69,(((I2R(udg_xwzxwz68)*I2R(GetHeroLevel(udg_xwzxwz65)))*I2R(GetHeroAgi(udg_xwzxwz65,false)))*I2R(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(udg_xwzxwz65))])),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
call RemoveLocation(udg_xwzxwz67[67])
else
set udg_xwzxwz67[67]=PolarProjectionBJ(udg_xwzxwz67[66],300.00,(AngleBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65])+36.00))
call AddSpecialEffectTargetUnitBJ("weapon",udg_xwzxwz65,"Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl")
call SetUnitAnimation(udg_xwzxwz65,"attack")
call SetUnitPositionLocFacingBJ(udg_xwzxwz65,udg_xwzxwz67[67],AngleBetweenPoints(udg_xwzxwz67[65],udg_xwzxwz67[66]))
call DestroyEffect(GetLastCreatedEffectBJ())
call UnitDamageTargetBJ(udg_xwzxwz65,udg_xwzxwz69,(((I2R(udg_xwzxwz68)*I2R(GetHeroLevel(udg_xwzxwz65)))*I2R(GetHeroAgi(udg_xwzxwz65,false)))*I2R(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(udg_xwzxwz65))])),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_DIVINE)
call RemoveLocation(udg_xwzxwz67[67])
endif
call AddSpecialEffectLocBJ(udg_xwzxwz67[66],"Abilities\\Spells\\Items\\AIta\\CrystalBallCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(udg_xwzxwz67[66],"Abilities\\Spells\\Human\\Flare\\FlareCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
call AddSpecialEffectLocBJ(udg_xwzxwz67[66],"Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl")
call DestroyEffect(GetLastCreatedEffectBJ())
set udg_xwzxwz67[80]=PolarProjectionBJ(udg_xwzxwz67[66],500.00,(AngleBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65])+0.00))
set udg_xwzxwz67[81]=PolarProjectionBJ(udg_xwzxwz67[66],500.00,(AngleBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65])+72.00))
set udg_xwzxwz67[82]=PolarProjectionBJ(udg_xwzxwz67[66],500.00,(AngleBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65])+144.00))
set udg_xwzxwz67[83]=PolarProjectionBJ(udg_xwzxwz67[66],500.00,(AngleBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65])+216.00))
set udg_xwzxwz67[84]=PolarProjectionBJ(udg_xwzxwz67[66],500.00,(AngleBetweenPoints(udg_xwzxwz67[66],udg_xwzxwz67[65])+288.00))
call AddLightningLoc("HWPB",udg_xwzxwz67[80],udg_xwzxwz67[82])
call SetLightningColor(GetLastCreatedLightningBJ(),GetRandomReal(0,1),GetRandomReal(0,1),GetRandomReal(0,1),1)
set udg_xwzxwz55[(80+udg_xwzxwz68)]=GetLastCreatedLightningBJ()
call AddLightningLoc("HWPB",udg_xwzxwz67[81],udg_xwzxwz67[83])
call SetLightningColor(GetLastCreatedLightningBJ(),GetRandomReal(0,1),GetRandomReal(0,1),GetRandomReal(0,1),1)
set udg_xwzxwz55[(110+udg_xwzxwz68)]=GetLastCreatedLightningBJ()
call AddLightningLoc("HWPB",udg_xwzxwz67[82],udg_xwzxwz67[84])
call SetLightningColor(GetLastCreatedLightningBJ(),GetRandomReal(0,1),GetRandomReal(0,1),GetRandomReal(0,1),1)
set udg_xwzxwz55[(140+udg_xwzxwz68)]=GetLastCreatedLightningBJ()
call AddLightningLoc("HWPB",udg_xwzxwz67[83],udg_xwzxwz67[80])
call SetLightningColor(GetLastCreatedLightningBJ(),GetRandomReal(0,1),GetRandomReal(0,1),GetRandomReal(0,1),1)
set udg_xwzxwz55[(170+udg_xwzxwz68)]=GetLastCreatedLightningBJ()
call AddLightningLoc("HWPB",udg_xwzxwz67[84],udg_xwzxwz67[81])
call SetLightningColor(GetLastCreatedLightningBJ(),GetRandomReal(0,1),GetRandomReal(0,1),GetRandomReal(0,1),1)
set udg_xwzxwz55[(200+udg_xwzxwz68)]=GetLastCreatedLightningBJ()
call RemoveLocation(udg_xwzxwz67[67])
call RemoveLocation(udg_xwzxwz67[65])
endfunction
function Trig_xwzxwz97F64death_Func001C takes nothing returns boolean
return ((IsUnitDeadBJ(udg_xwzxwz69)))or((IsUnitDeadBJ(udg_xwzxwz65)))
endfunction
function Trig_xwzxwz97F64death_Conditions takes nothing returns boolean
return (Trig_xwzxwz97F64death_Func001C())
endfunction
function Trig_xwzxwz97F64death_Actions takes nothing returns nothing
call DisableTrigger(gg_trg_xwzxwz97F64)
call DisableTrigger(gg_trg_xwzxwz97F6z16)
call DisableTrigger(gg_trg_xwzxwz97F6z32)
call DisableTrigger(gg_trg_xwzxwz97F6z64)
call DisableTrigger(gg_trg_xwzxwz97F64death)
set bj_forLoopAIndex=80
set bj_forLoopAIndexEnd=240
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyLightning(udg_xwzxwz55[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=120
set bj_forLoopAIndexEnd=350
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyLightning(udg_xwzxwz55[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call PauseUnitBJ(false,udg_xwzxwz65)
call PauseUnitBJ(false,udg_xwzxwz69)
call SetUnitInvulnerable(udg_xwzxwz65,false)
call DestroyEffect(udg_xwzxwz46[888])
call DestroyEffect(udg_xwzxwz46[889])
call ResetUnitAnimation(udg_xwzxwz65)
call SetUnitTimeScalePercent(udg_xwzxwz65,100)
call ResetToGameCameraForPlayer(GetOwningPlayer(udg_xwzxwz65),0.50)
call RemoveLocation(udg_xwzxwz67[65])
call RemoveLocation(udg_xwzxwz67[66])
call RemoveLocation(udg_xwzxwz67[67])
endfunction
function Trig_tjzs_Func001C takes nothing returns boolean
return ((udg_xwzxwz74==false))and((GetUnitLevel(udg_xwzxwz65)>=50))
endfunction
function Trig_tjzs_Conditions takes nothing returns boolean
return (Trig_tjzs_Func001C())
endfunction
function Trig_tjzs_Func005Func004Func002C takes nothing returns boolean
return ((DistanceBetweenPoints(udg_xwzxwz77,OffsetLocation(udg_xwzxwz80,(0.00-(udg_xwzxwz76/2.00)),0))>100.00))
endfunction
function Trig_tjzs_Func007001003001 takes nothing returns boolean
return (GetFilterUnit()!=udg_xwzxwz65)
endfunction
function Trig_tjzs_Func007001003002 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_tjzs_Func007001003 takes nothing returns boolean
return GetBooleanAnd(Trig_tjzs_Func007001003001(),Trig_tjzs_Func007001003002())
endfunction
function Trig_tjzs_Func007A takes nothing returns nothing
call UnitDamageTargetBJ(udg_xwzxwz65,GetEnumUnit(),(((50.00*I2R(GetHeroLevel(udg_xwzxwz65)))*I2R(GetHeroAgi(udg_xwzxwz65,false)))*I2R(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(udg_xwzxwz65))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Undead\\Cripple\\CrippleTarget.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
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
return (GetFilterUnit()!=udg_xwzxwz65)
endfunction
function Trig_tjzs_Func041001003 takes nothing returns boolean
return GetBooleanAnd(Trig_tjzs_Func041001003001(),Trig_tjzs_Func041001003002())
endfunction
function Trig_tjzs_Func041A takes nothing returns nothing
call UnitDamageTargetBJ(udg_xwzxwz65,GetEnumUnit(),(((80.00*I2R(GetHeroLevel(udg_xwzxwz65)))*I2R(GetHeroAgi(udg_xwzxwz65,false)))*I2R(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(udg_xwzxwz65))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Undead\\FrostArmor\\FrostArmorDamage.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
endfunction
function Trig_tjzs_Func054001003001 takes nothing returns boolean
return (IsUnitAliveBJ(GetFilterUnit()))
endfunction
function Trig_tjzs_Func054001003002 takes nothing returns boolean
return (GetFilterUnit()!=udg_xwzxwz65)
endfunction
function Trig_tjzs_Func054001003 takes nothing returns boolean
return GetBooleanAnd(Trig_tjzs_Func054001003001(),Trig_tjzs_Func054001003002())
endfunction
function Trig_tjzs_Func054A takes nothing returns nothing
call UnitDamageTargetBJ(udg_xwzxwz65,GetEnumUnit(),(((100.00*I2R(GetHeroLevel(udg_xwzxwz65)))*I2R(GetHeroAgi(udg_xwzxwz65,false)))*I2R(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(udg_xwzxwz65))])),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Orc\\LightningShield\\LightningShieldTarget.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
endfunction
function Trig_tjzs_Actions takes nothing returns nothing
set udg_xwzxwz74=true
set udg_xwzxwz80=GetUnitLoc(udg_xwzxwz65)
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=44
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(PolarProjectionBJ(udg_xwzxwz80,udg_xwzxwz76,I2R((GetForLoopIndexA()*4))),"Doodads\\Cinematic\\FireRockSmall\\FireRockSmall.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(PolarProjectionBJ(udg_xwzxwz80,udg_xwzxwz76,I2R(((GetForLoopIndexA()*4)+180))),"Doodads\\Cinematic\\FireRockSmall\\FireRockSmall.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=19
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz73=((GetForLoopIndexA()+1)*2)
set udg_xwzxwz72=(180.00/I2R(udg_xwzxwz73))
set udg_xwzxwz78=(I2R(GetForLoopIndexA())*(udg_xwzxwz76/20.00))
set bj_forLoopBIndex=0
set bj_forLoopBIndexEnd=udg_xwzxwz73
loop
exitwhen bj_forLoopBIndex>bj_forLoopBIndexEnd
set udg_xwzxwz77=PolarProjectionBJ(udg_xwzxwz80,udg_xwzxwz78,(AcosBJ((udg_xwzxwz78/udg_xwzxwz76))+(I2R(GetForLoopIndexB())*udg_xwzxwz72)))
if (Trig_tjzs_Func005Func004Func002C()) then
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(udg_xwzxwz77,"Doodads\\Cinematic\\FireRockSmall\\FireRockSmall.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
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
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(PolarProjectionBJ(OffsetLocation(udg_xwzxwz80,(udg_xwzxwz76/2.00),0),(I2R(GetForLoopIndexA())*5.00),(I2R(GetForLoopIndexB())*(720.00/(I2R(GetForLoopIndexA())+1)))),"Doodads\\Cinematic\\FireRockSmall\\FireRockSmall.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopBIndex=bj_forLoopBIndex+1
endloop
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call ForGroupBJ(GetUnitsInRangeOfLocMatching(400.00,udg_xwzxwz80,Condition(function Trig_tjzs_Func007001003)),function Trig_tjzs_Func007A)
call TriggerSleepAction(1.00)
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=15
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,700.00,(256.00-(I2R(GetForLoopIndexA())*32.00))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,600.00,(218.00-(I2R(GetForLoopIndexA())*36.33))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=7
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,500.00,(182.00-(I2R(GetForLoopIndexA())*45.50))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=15
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func014Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,-700.00,(256.00-(I2R(GetForLoopIndexA())*32.00))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_xwzxwz79[udg_xwzxwz75]=GetLastCreatedEffectBJ()
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func015Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,-600.00,(218.00-(I2R(GetForLoopIndexA())*36.33))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_xwzxwz79[udg_xwzxwz75]=GetLastCreatedEffectBJ()
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=7
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func016Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,-500.00,(182.00-(I2R(GetForLoopIndexA())*45.50))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_xwzxwz79[udg_xwzxwz75]=GetLastCreatedEffectBJ()
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=15
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(256.00-(I2R(GetForLoopIndexA())*32.00)),700.00),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func019Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(218.00-(I2R(GetForLoopIndexA())*36.33)),600.00),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_xwzxwz79[udg_xwzxwz75]=GetLastCreatedEffectBJ()
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=7
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(182.00-(I2R(GetForLoopIndexA())*45.50)),500.00),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=15
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func022Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(256.00-(I2R(GetForLoopIndexA())*32.00)),-700.00),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_xwzxwz79[udg_xwzxwz75]=GetLastCreatedEffectBJ()
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(218.00-(I2R(GetForLoopIndexA())*36.33)),-600.00),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=7
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func024Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(182.00-(I2R(GetForLoopIndexA())*45.50)),-500.00),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_xwzxwz79[udg_xwzxwz75]=GetLastCreatedEffectBJ()
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=15
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func026Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(675.00-(I2R(GetForLoopIndexA())*22.50)),(315.00+(I2R(GetForLoopIndexA())*22.50))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_xwzxwz79[udg_xwzxwz75]=GetLastCreatedEffectBJ()
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(578.50-(I2R(GetForLoopIndexA())*25.75)),(269.50+(I2R(GetForLoopIndexA())*25.75))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=7
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(482.50-(I2R(GetForLoopIndexA())*32.13)),(225.50+(I2R(GetForLoopIndexA())*32.13))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=15
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(315.00+(I2R(GetForLoopIndexA())*22.50)),(-675.00+(I2R(GetForLoopIndexA())*22.50))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(269.50+(I2R(GetForLoopIndexA())*25.75)),(-578.50+(I2R(GetForLoopIndexA())*25.75))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=7
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func032Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(225.50+(I2R(GetForLoopIndexA())*32.13)),(-482.50+(I2R(GetForLoopIndexA())*32.13))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_xwzxwz79[udg_xwzxwz75]=GetLastCreatedEffectBJ()
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=15
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(-675.00+(I2R(GetForLoopIndexA())*22.50)),(-315.00-(I2R(GetForLoopIndexA())*22.50))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func035Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(-578.50+(I2R(GetForLoopIndexA())*25.75)),(-269.50-(I2R(GetForLoopIndexA())*25.75))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_xwzxwz79[udg_xwzxwz75]=GetLastCreatedEffectBJ()
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=7
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func036Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(-482.50+(I2R(GetForLoopIndexA())*32.13)),(-225.50-(I2R(GetForLoopIndexA())*32.13))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_xwzxwz79[udg_xwzxwz75]=GetLastCreatedEffectBJ()
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=15
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func038Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(-315.00-(I2R(GetForLoopIndexA())*22.50)),(675.00-(I2R(GetForLoopIndexA())*22.50))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_xwzxwz79[udg_xwzxwz75]=GetLastCreatedEffectBJ()
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=11
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
if (Trig_tjzs_Func039Func001C()) then
else
call AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(-269.50-(I2R(GetForLoopIndexA())*25.75)),(578.50-(I2R(GetForLoopIndexA())*25.75))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
endif
set udg_xwzxwz79[udg_xwzxwz75]=GetLastCreatedEffectBJ()
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=7
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(-225.50-(I2R(GetForLoopIndexA())*32.13)),(482.50-(I2R(GetForLoopIndexA())*32.13))),"Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call ForGroupBJ(GetUnitsInRangeOfLocMatching(700.00,udg_xwzxwz80,Condition(function Trig_tjzs_Func041001003)),function Trig_tjzs_Func041A)
call TriggerSleepAction(2.00)
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=(udg_xwzxwz75-1)
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyEffectBJ(udg_xwzxwz79[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set udg_xwzxwz75=0
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=19
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,800.00,(-331.00+(I2R(GetForLoopIndexA())*33.10))),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=19
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,-800.00,(-331.00+(I2R(GetForLoopIndexA())*33.10))),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=19
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(-331.00+(I2R(GetForLoopIndexA())*33.10)),800.00),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=19
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(-331.00+(I2R(GetForLoopIndexA())*33.10)),-800.00),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=18
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(800.00-(I2R(GetForLoopIndexA())*23.45)),(331.00+(I2R(GetForLoopIndexA())*23.45))),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=18
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(-800.00+(I2R(GetForLoopIndexA())*23.45)),(331.00+(I2R(GetForLoopIndexA())*23.45))),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=18
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(-800.00+(I2R(GetForLoopIndexA())*23.45)),(-331.00-(I2R(GetForLoopIndexA())*23.45))),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=18
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_xwzxwz79[udg_xwzxwz75]=AddSpecialEffectLocBJ(OffsetLocation(udg_xwzxwz80,(800.00-(I2R(GetForLoopIndexA())*23.45)),(-331.00-(I2R(GetForLoopIndexA())*23.45))),"Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
set udg_xwzxwz75=(udg_xwzxwz75+1)
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call ForGroupBJ(GetUnitsInRangeOfLocMatching(800.00,udg_xwzxwz80,Condition(function Trig_tjzs_Func054001003)),function Trig_tjzs_Func054A)
call TriggerSleepAction(2.00)
set bj_forLoopAIndex=0
set bj_forLoopAIndexEnd=(udg_xwzxwz75-1)
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call DestroyEffectBJ(udg_xwzxwz79[GetForLoopIndexA()])
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
set udg_xwzxwz75=0
set udg_xwzxwz74=false
endfunction
function Trig_xwzxwz96UP_Conditions takes nothing returns boolean
return ((IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetKillingUnitBJ()))))and((udg_xwzxwz97[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((GetKillingUnitBJ()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))and((IsUnitType(GetKillingUnitBJ(),UNIT_TYPE_HERO)))
endfunction
function Trig_xwzxwz96UP_Func003C takes nothing returns boolean
return ((udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]>=200))
endfunction
function Trig_xwzxwz96UP_Func004C takes nothing returns boolean
return ((GetRandomInt(1,100)<=3))
endfunction
function Trig_xwzxwz96UP_Actions takes nothing returns nothing
set udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
if (Trig_xwzxwz96UP_Func003C()) then
set udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=0
set udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]=(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]+1)
call DisplayTextToForce(GetPlayersAll(),((GetUnitName(GetKillingUnitBJ())+" 所持有的|cFFFF0000土魔之邪魔尘影|r熟练度为 ")+I2S(udg_xwzxwz70[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])))
else
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()),0,0,("|cFFFF0000土魔之邪魔尘影|r  "+(I2S(udg_xwzxwz37[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])+"/200")))
endif
if (Trig_xwzxwz96UP_Func004C()) then
call ModifyHeroStat(bj_HEROSTAT_STR,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,3)
call ModifyHeroStat(bj_HEROSTAT_AGI,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,4)
call ModifyHeroStat(bj_HEROSTAT_INT,GetKillingUnitBJ(),bj_MODIFYMETHOD_ADD,2)
endif
endfunction
function Trig_xwzxwz14Normal_Func006C takes nothing returns boolean
return ((udg_xwzxwz31[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))or((udg_xwzxwz32[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))or((udg_xwzxwz33[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))or((udg_xwzxwz34[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))or((udg_xwzxwz49[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))or((udg_xwzxwz35[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))or((udg_xwzxwz51[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))or((udg_xwzxwz100[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))or((udg_xwzxwz97[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))
endfunction
function Trig_xwzxwz14Normal_Conditions takes nothing returns boolean
return ((GetTriggerUnit()==udg_xwzxwz17[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))and((GetIssuedOrderIdBJ()==String2OrderIdBJ("patrol")))and(Trig_xwzxwz14Normal_Func006C())
endfunction
function Trig_xwzxwz14Normal_Func003C takes nothing returns boolean
return ((udg_xwzxwz51[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))and((GetOrderTargetUnit()!=null))
endfunction
function Trig_xwzxwz14Normal_Actions takes nothing returns nothing
call SetUnitPositionLoc(GetTriggerUnit(),GetOrderPointLoc())
call RemoveLocation(GetOrderPointLoc())
if (Trig_xwzxwz14Normal_Func003C()) then
call SetUnitPositionLoc(GetOrderTargetUnit(),GetUnitLoc(GetTriggerUnit()))
call RemoveLocation(GetUnitLoc(GetTriggerUnit()))
endif
endfunction

function Trig_War3sucaideguanggao_Actions takes nothing returns nothing
call DisplayTextToForce(GetPlayersAll(),"|cFFCC33FF支持素菜，素菜很给力！|r")
endfunction
function InitTrig_War3sucaideguanggao takes nothing returns nothing
set gg_trg_War3sucaideguanggao=CreateTrigger()
call TriggerRegisterTimerEventPeriodic(gg_trg_War3sucaideguanggao,180.)
call TriggerAddAction(gg_trg_War3sucaideguanggao,function Trig_War3sucaideguanggao_Actions)
endfunction

function war3sucai_iiitttggg_Func001001002 takes nothing returns boolean
    return ( IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true )
endfunction
function war3sucai_iiitttggg_Func001A takes nothing returns nothing
local item iiitem
    set iiitem = CreateItem(ChooseRandomItemBJ(3), GetUnitX(GetEnumUnit()), GetUnitY(GetEnumUnit()))
    call UnitAddItem( GetEnumUnit(), iiitem )
    call DisplayTimedTextToForce( GetPlayersAll(), 10.00, ( GetPlayerName(GetTriggerPlayer()) + ( "|cFFFF00CC你想知道|cFFFFFF00梦幻|r送装备密码吗？\n|cFF33FF33请来素菜魔兽专区查看|r\n获得了由素菜魔兽提供奖励的 " + GetItemName(iiitem) ) ) )
    set iiitem = CreateItem(ChooseRandomItemBJ(3), GetUnitX(GetEnumUnit()), GetUnitY(GetEnumUnit()))
    call UnitAddItem( GetEnumUnit(), iiitem )
    call DisplayTimedTextToForce( GetPlayersAll(), 10.00, ( GetPlayerName(GetTriggerPlayer()) + ( "|cFFFF00CC你想知道|cFFFFFF00梦幻|r送装备密码吗？\n|cFF33FF33请来素菜魔兽专区查看|r\n获得了由素菜魔兽提供奖励的 " + GetItemName(iiitem) ) ) )
    set iiitem = CreateItem(ChooseRandomItemBJ(8), GetUnitX(GetEnumUnit()), GetUnitY(GetEnumUnit()))
    call UnitAddItem( GetEnumUnit(), iiitem )
    call DisplayTimedTextToForce( GetPlayersAll(), 10.00, ( GetPlayerName(GetTriggerPlayer()) + ( "|cFFFF00CC你想知道|cFFFFFF00梦幻|r送装备密码吗？\n|cFF33FF33请来素菜魔兽专区查看|r\n获得了由素菜魔兽提供奖励的 " + GetItemName(iiitem) ) ) )
    set iiitem = CreateItem(ChooseRandomItemBJ(9), GetUnitX(GetEnumUnit()), GetUnitY(GetEnumUnit()))
    call UnitAddItem( GetEnumUnit(), iiitem )
    call DisplayTimedTextToForce( GetPlayersAll(), 10.00, ( GetPlayerName(GetTriggerPlayer()) + ( "|cFFFF00CC你想知道|cFFFFFF00梦幻|r送装备密码吗？\n|cFF33FF33请来素菜魔兽专区查看|r\n获得了由素菜魔兽提供奖励的 " + GetItemName(iiitem) ) ) )
    set iiitem = CreateItem(ChooseRandomItemBJ(9), GetUnitX(GetEnumUnit()), GetUnitY(GetEnumUnit()))
    call UnitAddItem( GetEnumUnit(), iiitem )
    call DisplayTimedTextToForce( GetPlayersAll(), 10.00, ( GetPlayerName(GetTriggerPlayer()) + ( "|cFFFF00CC你想知道|cFFFFFF00梦幻|r送装备密码吗？\n|cFF33FF33请来素菜魔兽专区查看|r\n获得了由素菜魔兽提供奖励的 " + GetItemName(iiitem) ) ) )
set iiitem=null
endfunction
function war3sucai_iiitttggg_Actions takes nothing returns nothing
    set bj_wantDestroyGroup=true
    call ForGroupBJ( GetUnitsOfPlayerMatching(GetTriggerPlayer(), Condition(function war3sucai_iiitttggg_Func001001002)), function war3sucai_iiitttggg_Func001A )
    call DestroyTrigger(GetTriggeringTrigger())
endfunction
function war3sucai_ABC takes nothing returns nothing
    local trigger array iiitttggg
    local integer i=1
    loop
    exitwhen i>12
    if GetPlayerController(ConvertedPlayer(i)) == MAP_CONTROL_USER and GetPlayerSlotState(ConvertedPlayer(i)) == PLAYER_SLOT_STATE_PLAYING then
    set iiitttggg[i]=CreateTrigger()
    set iiitttggg[i+12]=CreateTrigger()
    set iiitttggg[i+24]=CreateTrigger()
    set iiitttggg[i+36]=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(iiitttggg[i], ConvertedPlayer(i), "我爱素菜", true )
    call TriggerRegisterPlayerChatEvent(iiitttggg[i+12], ConvertedPlayer(i), "素菜我要装备", true )
    call TriggerRegisterPlayerChatEvent(iiitttggg[i+24], ConvertedPlayer(i), "梦幻星空", true )
    call TriggerRegisterPlayerChatEvent(iiitttggg[i+36], ConvertedPlayer(i), "支持素菜", true )
    call TriggerAddAction(iiitttggg[i], function war3sucai_iiitttggg_Actions )
    call TriggerAddAction(iiitttggg[i+12], function war3sucai_iiitttggg_Actions )
    call TriggerAddAction(iiitttggg[i+24], function war3sucai_iiitttggg_Actions )
    call TriggerAddAction(iiitttggg[i+36], function war3sucai_iiitttggg_Actions )
    endif
    set i=i+1
    endloop
endfunction
//
function war3sucai_main takes nothing returns nothing
set xwzxwz98=0
loop
exitwhen (xwzxwz98>1)
set udg_xwzxwz18[xwzxwz98]=false
set udg_xwzxwz36[xwzxwz98]=false
set udg_xwzxwz18[xwzxwz98]=false
set udg_xwzxwz31[xwzxwz98]=false
set udg_xwzxwz32[xwzxwz98]=false
set udg_xwzxwz33[xwzxwz98]=false
set udg_xwzxwz34[xwzxwz98]=false
set udg_xwzxwz35[xwzxwz98]=false
set udg_xwzxwz36[xwzxwz98]=false
set udg_xwzxwz37[xwzxwz98]=0
set udg_xwzxwz38[xwzxwz98]=0
set udg_xwzxwz39[xwzxwz98]=0
set udg_xwzxwz40[xwzxwz98]=0
set udg_xwzxwz41[xwzxwz98]=0
set udg_xwzxwz43[xwzxwz98]=false
set udg_xwzxwz47[xwzxwz98]=0
set udg_xwzxwz48[xwzxwz98]=0
set udg_xwzxwz49[xwzxwz98]=false
set udg_xwzxwz50[xwzxwz98]=0
set udg_xwzxwz51[xwzxwz98]=false
set udg_xwzxwz52[xwzxwz98]=0
set udg_xwzxwz99[xwzxwz98]=0
set udg_xwzxwz53[xwzxwz98]=false
set udg_xwzxwz100[xwzxwz98]=false
set udg_xwzxwz56[xwzxwz98]=0
set udg_xwzxwz58[xwzxwz98]=false
set udg_xwzxwz97[xwzxwz98]=false
set udg_xwzxwz70[xwzxwz98]=0
set xwzxwz98=xwzxwz98+1
endloop
set gg_trg_xwzxwz2=CreateTrigger()
call TriggerRegisterPlayerEventEndCinematic(gg_trg_xwzxwz2,Player(0))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_xwzxwz2,Player(1))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_xwzxwz2,Player(2))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_xwzxwz2,Player(3))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_xwzxwz2,Player(4))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_xwzxwz2,Player(5))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_xwzxwz2,Player(6))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_xwzxwz2,Player(7))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_xwzxwz2,Player(8))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_xwzxwz2,Player(9))
call TriggerAddAction(gg_trg_xwzxwz2,function Trig_xwzxwz2_Actions)
set gg_trg_xwzxwz3=CreateTrigger()
call DisableTrigger(gg_trg_xwzxwz3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz3,Player(0),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_LEFT)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz3,Player(1),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_LEFT)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz3,Player(2),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_LEFT)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz3,Player(3),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_LEFT)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz3,Player(4),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_LEFT)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz3,Player(5),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_LEFT)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz3,Player(6),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_LEFT)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz3,Player(7),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_LEFT)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz3,Player(8),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_LEFT)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz3,Player(9),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_LEFT)
call TriggerAddAction(gg_trg_xwzxwz3,function Trig_xwzxwz3_Actions)
set gg_trg_xwzxwz4=CreateTrigger()
call DisableTrigger(gg_trg_xwzxwz4)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz4,Player(0),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_RIGHT)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz4,Player(1),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_RIGHT)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz4,Player(2),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_RIGHT)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz4,Player(3),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_RIGHT)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz4,Player(4),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_RIGHT)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz4,Player(5),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_RIGHT)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz4,Player(6),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_RIGHT)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz4,Player(7),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_RIGHT)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz4,Player(8),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_RIGHT)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz4,Player(9),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_RIGHT)
call TriggerAddAction(gg_trg_xwzxwz4,function Trig_xwzxwz4_Actions)
set gg_trg_xwzxwz5=CreateTrigger()
call DisableTrigger(gg_trg_xwzxwz5)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz5,Player(0),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz5,Player(1),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz5,Player(2),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz5,Player(3),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz5,Player(4),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz5,Player(5),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz5,Player(6),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz5,Player(7),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz5,Player(8),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz5,Player(9),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_UP)
call TriggerAddAction(gg_trg_xwzxwz5,function Trig_xwzxwz5_Actions)
set gg_trg_xwzxwz6=CreateTrigger()
call DisableTrigger(gg_trg_xwzxwz6)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz6,Player(0),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz6,Player(1),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz6,Player(2),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz6,Player(3),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz6,Player(4),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz6,Player(5),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz6,Player(6),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz6,Player(7),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz6,Player(8),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_xwzxwz6,Player(9),bj_KEYEVENTTYPE_DEPRESS,bj_KEYEVENTKEY_DOWN)
call TriggerAddAction(gg_trg_xwzxwz6,function Trig_xwzxwz6_Actions)
set gg_trg_xwzxwz7=CreateTrigger()
call DisableTrigger(gg_trg_xwzxwz7)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_xwzxwz7,Player(0),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_xwzxwz7,Player(1),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_xwzxwz7,Player(2),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_xwzxwz7,Player(3),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_xwzxwz7,Player(4),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_xwzxwz7,Player(5),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_xwzxwz7,Player(6),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_xwzxwz7,Player(7),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_xwzxwz7,Player(8),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_xwzxwz7,Player(9),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_xwzxwz7,Player(10),true)
call TriggerAddCondition(gg_trg_xwzxwz7,Condition(function Trig_xwzxwz7_Conditions))
call TriggerAddAction(gg_trg_xwzxwz7,function Trig_xwzxwz7_Actions)
set gg_trg_xwzxwz8=CreateTrigger()
call DisableTrigger(gg_trg_xwzxwz8)
call TriggerRegisterAnyUnitEventBJ(gg_trg_xwzxwz8,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_xwzxwz8,Condition(function Trig_xwzxwz8_Conditions))
call TriggerAddAction(gg_trg_xwzxwz8,function Trig_xwzxwz8_Actions)
set gg_trg_xwzxwz9=CreateTrigger()
call DisableTrigger(gg_trg_xwzxwz9)
call TriggerRegisterAnyUnitEventBJ(gg_trg_xwzxwz9,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddCondition(gg_trg_xwzxwz9,Condition(function Trig_xwzxwz9_Conditions))
call TriggerAddAction(gg_trg_xwzxwz9,function Trig_xwzxwz9_Actions)
set gg_trg_xwzxwz10=CreateTrigger()
call DisableTrigger(gg_trg_xwzxwz10)
call TriggerRegisterAnyUnitEventBJ(gg_trg_xwzxwz10,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_xwzxwz10,Condition(function Trig_xwzxwz10_Conditions))
call TriggerAddAction(gg_trg_xwzxwz10,function Trig_xwzxwz10_Actions)
set gg_trg_xwzxwz11=CreateTrigger()
call DisableTrigger(gg_trg_xwzxwz11)
call TriggerRegisterAnyUnitEventBJ(gg_trg_xwzxwz11,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddCondition(gg_trg_xwzxwz11,Condition(function Trig_xwzxwz11_Conditions))
call TriggerAddAction(gg_trg_xwzxwz11,function Trig_xwzxwz11_Actions)
set gg_trg_xwzxwz12=CreateTrigger()
call DisableTrigger(gg_trg_xwzxwz12)
call TriggerAddAction(gg_trg_xwzxwz12,function Trig_xwzxwz12_Actions)
set gg_trg_xwzxwz13=CreateTrigger()
call DisableTrigger(gg_trg_xwzxwz13)
call TriggerAddAction(gg_trg_xwzxwz13,function Trig_xwzxwz13_Actions)
set gg_trg_xwzxwz14=CreateTrigger()
call DisableTrigger(gg_trg_xwzxwz14)
call TriggerRegisterAnyUnitEventBJ(gg_trg_xwzxwz14,EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
call TriggerAddCondition(gg_trg_xwzxwz14,Condition(function Trig_xwzxwz14_Conditions))
call TriggerAddAction(gg_trg_xwzxwz14,function Trig_xwzxwz14_Actions)
set gg_trg_xwzxwz1=CreateTrigger()
call DisableTrigger(gg_trg_xwzxwz1)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz1,Player(0),"removedarkweapon",true)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz1,Player(1),"removedarkweapon",true)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz1,Player(2),"removedarkweapon",true)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz1,Player(3),"removedarkweapon",true)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz1,Player(4),"removedarkweapon",true)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz1,Player(5),"removedarkweapon",true)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz1,Player(6),"removedarkweapon",true)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz1,Player(7),"removedarkweapon",true)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz1,Player(8),"removedarkweapon",true)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz1,Player(9),"removedarkweapon",true)
call TriggerAddCondition(gg_trg_xwzxwz1,Condition(function Trig_xwzxwz1_Conditions))
call TriggerAddAction(gg_trg_xwzxwz1,function Trig_xwzxwz1_Actions)
set udg_xwzxwz60=DialogCreate()
set udg_xwzxwz61=DialogCreate()
set gg_trg_xwzxwz81=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz81,Player(0),"魔道",false)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz81,Player(1),"魔道",false)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz81,Player(2),"魔道",false)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz81,Player(3),"魔道",false)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz81,Player(4),"魔道",false)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz81,Player(5),"魔道",false)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz81,Player(6),"魔道",false)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz81,Player(7),"魔道",false)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz81,Player(8),"魔道",false)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz81,Player(9),"魔道",false)
call TriggerAddCondition(gg_trg_xwzxwz81,Condition(function Trig_xwzxwz81_Conditions))
call TriggerAddAction(gg_trg_xwzxwz81,function Trig_xwzxwz81_Actions)
set gg_trg_xwzxwz82=CreateTrigger()
call DisableTrigger(gg_trg_xwzxwz82)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz82,Player(0),"进入魔道",true)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz82,Player(1),"进入魔道",true)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz82,Player(2),"进入魔道",true)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz82,Player(3),"进入魔道",true)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz82,Player(4),"进入魔道",true)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz82,Player(5),"进入魔道",true)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz82,Player(6),"进入魔道",true)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz82,Player(7),"进入魔道",true)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz82,Player(8),"进入魔道",true)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz82,Player(9),"进入魔道",true)
call TriggerAddCondition(gg_trg_xwzxwz82,Condition(function Trig_xwzxwz82_Conditions))
call TriggerAddAction(gg_trg_xwzxwz82,function Trig_xwzxwz82_Actions)
set gg_trg_xwzxwz83=CreateTrigger()
call DisableTrigger(gg_trg_xwzxwz83)
call TriggerAddCondition(gg_trg_xwzxwz83,Condition(function Trig_xwzxwz83_Conditions))
call TriggerAddAction(gg_trg_xwzxwz83,function Trig_xwzxwz83_Actions)
set gg_trg_xwzxwz84=CreateTrigger()
call DisableTrigger(gg_trg_xwzxwz84)
call TriggerAddAction(gg_trg_xwzxwz84,function Trig_xwzxwz84_Actions)
set gg_trg_xwzxwz84Clink=CreateTrigger()
call TriggerRegisterDialogEventBJ(gg_trg_xwzxwz84Clink,udg_xwzxwz61)
call TriggerAddAction(gg_trg_xwzxwz84Clink,function Trig_xwzxwz84Clink_Actions)
set gg_trg_xwzxwz85=CreateTrigger()
call TriggerRegisterDialogEventBJ(gg_trg_xwzxwz85,udg_xwzxwz60)
call TriggerAddAction(gg_trg_xwzxwz85,function Trig_xwzxwz85_Actions)
set gg_trg_xwzxwz1NoralPlayer=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz1NoralPlayer,Player(0),"退出魔道",true)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz1NoralPlayer,Player(1),"退出魔道",true)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz1NoralPlayer,Player(2),"退出魔道",true)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz1NoralPlayer,Player(3),"退出魔道",true)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz1NoralPlayer,Player(4),"退出魔道",true)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz1NoralPlayer,Player(5),"退出魔道",true)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz1NoralPlayer,Player(6),"退出魔道",true)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz1NoralPlayer,Player(7),"退出魔道",true)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz1NoralPlayer,Player(8),"退出魔道",true)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz1NoralPlayer,Player(9),"退出魔道",true)
call TriggerAddAction(gg_trg_xwzxwz1NoralPlayer,function Trig_xwzxwz1NoralPlayer_Actions)
set gg_trg_xwzxwz86=CreateTrigger()
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_xwzxwz86,Player(0),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_xwzxwz86,Player(1),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_xwzxwz86,Player(2),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_xwzxwz86,Player(3),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_xwzxwz86,Player(4),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_xwzxwz86,Player(5),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_xwzxwz86,Player(6),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_xwzxwz86,Player(7),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_xwzxwz86,Player(8),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_xwzxwz86,Player(9),true)
call TriggerAddCondition(gg_trg_xwzxwz86,Condition(function Trig_xwzxwz86_Conditions))
call TriggerAddAction(gg_trg_xwzxwz86,function Trig_xwzxwz86_Actions)
set gg_trg_xwzxwz87=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_xwzxwz87,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_xwzxwz87,Condition(function Trig_xwzxwz87_Conditions))
call TriggerAddAction(gg_trg_xwzxwz87,function Trig_xwzxwz87_Actions)
set gg_trg_xwzxwz87UP=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_xwzxwz87UP,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddCondition(gg_trg_xwzxwz87UP,Condition(function Trig_xwzxwz87UP_Conditions))
call TriggerAddAction(gg_trg_xwzxwz87UP,function Trig_xwzxwz87UP_Actions)
set gg_trg_xwzxwz88=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_xwzxwz88,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_xwzxwz88,Condition(function Trig_xwzxwz88_Conditions))
call TriggerAddAction(gg_trg_xwzxwz88,function Trig_xwzxwz88_Actions)
set gg_trg_xwzxwz88UP=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_xwzxwz88UP,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddCondition(gg_trg_xwzxwz88UP,Condition(function Trig_xwzxwz88UP_Conditions))
call TriggerAddAction(gg_trg_xwzxwz88UP,function Trig_xwzxwz88UP_Actions)
set gg_trg_xwzxwz89=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_xwzxwz89,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_xwzxwz89,Condition(function Trig_xwzxwz89_Conditions))
call TriggerAddAction(gg_trg_xwzxwz89,function Trig_xwzxwz89_Actions)
set gg_trg_xwzxwz89UP=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_xwzxwz89UP,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddCondition(gg_trg_xwzxwz89UP,Condition(function Trig_xwzxwz89UP_Conditions))
call TriggerAddAction(gg_trg_xwzxwz89UP,function Trig_xwzxwz89UP_Actions)
set gg_trg_xwzxwz90=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_xwzxwz90,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_xwzxwz90,Condition(function Trig_xwzxwz90_Conditions))
call TriggerAddAction(gg_trg_xwzxwz90,function Trig_xwzxwz90_Actions)
set gg_trg_xwzxwz90UP=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_xwzxwz90UP,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddCondition(gg_trg_xwzxwz90UP,Condition(function Trig_xwzxwz90UP_Conditions))
call TriggerAddAction(gg_trg_xwzxwz90UP,function Trig_xwzxwz90UP_Actions)
set gg_trg_xwzxwz91=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_xwzxwz91,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_xwzxwz91,Condition(function Trig_xwzxwz91_Conditions))
call TriggerAddAction(gg_trg_xwzxwz91,function Trig_xwzxwz91_Actions)
set gg_trg_xwzxwz91Hurt=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_xwzxwz91Hurt,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_xwzxwz91Hurt,Condition(function Trig_xwzxwz91Hurt_Conditions))
call TriggerAddAction(gg_trg_xwzxwz91Hurt,function Trig_xwzxwz91Hurt_Actions)
set gg_trg_xwzxwz91UP=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_xwzxwz91UP,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddCondition(gg_trg_xwzxwz91UP,Condition(function Trig_xwzxwz91UP_Conditions))
call TriggerAddAction(gg_trg_xwzxwz91UP,function Trig_xwzxwz91UP_Actions)
set gg_trg_xwzxwz92=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_xwzxwz92,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_xwzxwz92,Condition(function Trig_xwzxwz92_Conditions))
call TriggerAddAction(gg_trg_xwzxwz92,function Trig_xwzxwz92_Actions)
set gg_trg_xwzxwz92UP=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_xwzxwz92UP,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddCondition(gg_trg_xwzxwz92UP,Condition(function Trig_xwzxwz92UP_Conditions))
call TriggerAddAction(gg_trg_xwzxwz92UP,function Trig_xwzxwz92UP_Actions)
set gg_trg_xwzxwz9201=CreateTrigger()
call DisableTrigger(gg_trg_xwzxwz9201)
call TriggerAddAction(gg_trg_xwzxwz9201,function Trig_xwzxwz9201_Actions)
set gg_trg_xwzxwz93=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_xwzxwz93,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_xwzxwz93,Condition(function Trig_xwzxwz93_Conditions))
call TriggerAddAction(gg_trg_xwzxwz93,function Trig_xwzxwz93_Actions)
set gg_trg_xwzxwz93UP=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_xwzxwz93UP,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddCondition(gg_trg_xwzxwz93UP,Condition(function Trig_xwzxwz93UP_Conditions))
call TriggerAddAction(gg_trg_xwzxwz93UP,function Trig_xwzxwz93UP_Actions)
set gg_trg_xwzxwz94=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_xwzxwz94,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_xwzxwz94,Condition(function Trig_xwzxwz94_Conditions))
call TriggerAddAction(gg_trg_xwzxwz94,function Trig_xwzxwz94_Actions)
set gg_trg_xwzxwz9400=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_xwzxwz9400,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_xwzxwz9400,Condition(function Trig_xwzxwz9400_Conditions))
call TriggerAddAction(gg_trg_xwzxwz9400,function Trig_xwzxwz9400_Actions)
set gg_trg_xwzxwz94UP=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_xwzxwz94UP,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddCondition(gg_trg_xwzxwz94UP,Condition(function Trig_xwzxwz94UP_Conditions))
call TriggerAddAction(gg_trg_xwzxwz94UP,function Trig_xwzxwz94UP_Actions)
set gg_trg_xwzxwz95=CreateTrigger()
call DisableTrigger(gg_trg_xwzxwz95)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz95,Player(0),"进入土魔",true)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz95,Player(1),"进入土魔",true)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz95,Player(2),"进入土魔",true)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz95,Player(3),"进入土魔",true)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz95,Player(4),"进入土魔",true)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz95,Player(5),"进入土魔",true)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz95,Player(6),"进入土魔",true)
call TriggerRegisterPlayerChatEvent(gg_trg_xwzxwz95,Player(7),"进入土魔",true)
call TriggerAddCondition(gg_trg_xwzxwz95,Condition(function Trig_xwzxwz95_Conditions))
call TriggerAddAction(gg_trg_xwzxwz95,function Trig_xwzxwz95_Actions)
set gg_trg_xwzxwz96=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_xwzxwz96,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_xwzxwz96,Condition(function Trig_xwzxwz96_Conditions))
call TriggerAddAction(gg_trg_xwzxwz96,function Trig_xwzxwz96_Actions)
set gg_trg_xwzxwz97F4=CreateTrigger()
call DisableTrigger(gg_trg_xwzxwz97F4)
call TriggerRegisterTimerEventPeriodic(gg_trg_xwzxwz97F4,0.03)
call TriggerAddAction(gg_trg_xwzxwz97F4,function Trig_xwzxwz97F4_Actions)
set gg_trg_xwzxwz97F40=CreateTrigger()
call DisableTrigger(gg_trg_xwzxwz97F40)
call TriggerRegisterTimerEventPeriodic(gg_trg_xwzxwz97F40,0.60)
call TriggerAddAction(gg_trg_xwzxwz97F40,function Trig_xwzxwz97F40_Actions)
set gg_trg_xwzxwz97F16=CreateTrigger()
call DisableTrigger(gg_trg_xwzxwz97F16)
call TriggerRegisterTimerEventPeriodic(gg_trg_xwzxwz97F16,0.30)
call TriggerAddAction(gg_trg_xwzxwz97F16,function Trig_xwzxwz97F16_Actions)
set gg_trg_xwzxwz97F32=CreateTrigger()
call DisableTrigger(gg_trg_xwzxwz97F32)
call TriggerAddAction(gg_trg_xwzxwz97F32,function Trig_xwzxwz97F32_Actions)
set gg_trg_xwzxwz97F64=CreateTrigger()
call DisableTrigger(gg_trg_xwzxwz97F64)
call TriggerRegisterTimerEventPeriodic(gg_trg_xwzxwz97F64,0.20)
call TriggerAddAction(gg_trg_xwzxwz97F64,function Trig_xwzxwz97F64_Actions)
set gg_trg_xwzxwz97F6z16=CreateTrigger()
call DisableTrigger(gg_trg_xwzxwz97F6z16)
call TriggerRegisterTimerEventPeriodic(gg_trg_xwzxwz97F6z16,0.30)
call TriggerAddAction(gg_trg_xwzxwz97F6z16,function Trig_xwzxwz97F6z16_Actions)
set gg_trg_xwzxwz97F6z32=CreateTrigger()
call DisableTrigger(gg_trg_xwzxwz97F6z32)
call TriggerRegisterTimerEventPeriodic(gg_trg_xwzxwz97F6z32,0.20)
call TriggerAddAction(gg_trg_xwzxwz97F6z32,function Trig_xwzxwz97F6z32_Actions)
set gg_trg_xwzxwz97F6z64=CreateTrigger()
call DisableTrigger(gg_trg_xwzxwz97F6z64)
call TriggerRegisterTimerEventPeriodic(gg_trg_xwzxwz97F6z64,0.30)
call TriggerAddAction(gg_trg_xwzxwz97F6z64,function Trig_xwzxwz97F6z64_Actions)
set gg_trg_xwzxwz97F64death=CreateTrigger()
call DisableTrigger(gg_trg_xwzxwz97F64death)
call TriggerRegisterTimerEventPeriodic(gg_trg_xwzxwz97F64death,0.01)
call TriggerAddCondition(gg_trg_xwzxwz97F64death,Condition(function Trig_xwzxwz97F64death_Conditions))
call TriggerAddAction(gg_trg_xwzxwz97F64death,function Trig_xwzxwz97F64death_Actions)
set gg_trg_xwzxwz97Screct=CreateTrigger()
call TriggerAddCondition(gg_trg_xwzxwz97Screct,Condition(function Trig_tjzs_Conditions))
call TriggerAddAction(gg_trg_xwzxwz97Screct,function Trig_tjzs_Actions)
set gg_trg_xwzxwz96UP=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_xwzxwz96UP,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddCondition(gg_trg_xwzxwz96UP,Condition(function Trig_xwzxwz96UP_Conditions))
call TriggerAddAction(gg_trg_xwzxwz96UP,function Trig_xwzxwz96UP_Actions)
set gg_trg_xwzxwz14Normal=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_xwzxwz14Normal,EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
call TriggerAddCondition(gg_trg_xwzxwz14Normal,Condition(function Trig_xwzxwz14Normal_Conditions))
call TriggerAddAction(gg_trg_xwzxwz14Normal,function Trig_xwzxwz14Normal_Actions)
call War3Sucai_Globals()
call InitTrig_War3Sucaichushihua()
call InitTrig_War3Sucaidhk1()
call InitTrig_War3Sucaidhk2()
call InitTrig_War3Sucaixuanz()
call InitTrig_War3Sucaiwucd()
call InitTrig_War3Sucaiwucd2()
set gg_trg_War3SuCaiKusujiashuxing=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_War3SuCaiKusujiashuxing,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddAction(gg_trg_War3SuCaiKusujiashuxing,function Trig_War3SuCaiKusujiashuxing_Actions)
set gg_trg_War3Sucaijidiwuyou=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_War3Sucaijidiwuyou,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_War3Sucaijidiwuyou,Condition(function Trig_War3Sucaijidiwuyou_Conditions))
call TriggerAddAction(gg_trg_War3Sucaijidiwuyou,function Trig_War3Sucaijidiwuyou_Actions)
call InitTrig_War3Sucaimpshan()
call InitTrig_War3Sucaijingyan()
call InitTrig_War3sucaideguanggao()
call war3sucai_ABC()
endfunction