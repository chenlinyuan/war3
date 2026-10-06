globals
integer array udg_shu
unit udg_putongdanwei=null
player udg_yexwanjia=null
boolean array udg_yex
button array udg_anniu
dialog udg_caidan
string array udg_zifu
unit array udg_danwei
group udg_danweizu1=CreateGroup()
group udg_danweizu2=CreateGroup()
group udg_danweizu3=CreateGroup()
group udg_danweizu=CreateGroup()
trigger gg_trg_yex_1=CreateTrigger()
trigger gg_trg_yex_2=CreateTrigger()
trigger gg_trg_yex_3=CreateTrigger()
trigger gg_trg_yex_4=CreateTrigger()
trigger gg_trg_yex_6=CreateTrigger()
trigger gg_trg_yex_7=CreateTrigger()
trigger gg_trg_yex_zhu=CreateTrigger()
trigger gg_trg_yex_fu=CreateTrigger()
trigger gg_trg_yex_10=CreateTrigger()
trigger gg_trg_yex_11=CreateTrigger()
trigger gg_trg_yex_12=CreateTrigger()
trigger gg_trg_yex_13=CreateTrigger()
trigger gg_trg_yex_14=CreateTrigger()
trigger gg_trg_yex_15=CreateTrigger()
trigger gg_trg_yex_16=CreateTrigger()
trigger gg_trg_yex_17=CreateTrigger()
trigger gg_trg_yex_18=CreateTrigger()
trigger gg_trg_yex_CMD=CreateTrigger()
endglobals


function Trig_yex_1_Func001Func001002 takes nothing returns nothing
call SetUnitLifePercentBJ(GetEnumUnit(),100)
endfunction
function Trig_yex_1_Func001Func002002 takes nothing returns nothing
call SetUnitManaPercentBJ(GetEnumUnit(),100)
endfunction
function Trig_yex_1_Func001C takes nothing returns boolean
return(GetTriggerPlayer()==udg_yexwanjia)
endfunction
function Trig_yex_1_Actions takes nothing returns nothing
if(Trig_yex_1_Func001C())then
call ForGroupBJ(GetUnitsOfPlayerAll(udg_yexwanjia),function Trig_yex_1_Func001Func001002)
call ForGroupBJ(GetUnitsOfPlayerAll(udg_yexwanjia),function Trig_yex_1_Func001Func002002)
return
endif
set udg_shu[(1+GetPlayerId(GetTriggerPlayer()))]=1
endfunction
function Trig_yex_2_Func001C takes nothing returns boolean
return(GetTriggerPlayer()==udg_yexwanjia)
endfunction
function Trig_yex_2_Actions takes nothing returns nothing
if(Trig_yex_2_Func001C())then
set udg_shu[15]=GetPlayerScore(Player(0),PLAYER_SCORE_GOLD_MINED_TOTAL)
call AdjustPlayerStateBJ(GetPlayerState(udg_yexwanjia,PLAYER_STATE_RESOURCE_GOLD),udg_yexwanjia,PLAYER_STATE_RESOURCE_GOLD)
call SetPlayerStateBJ(udg_yexwanjia,PLAYER_STATE_GOLD_GATHERED,udg_shu[15])
set udg_shu[16]=GetPlayerScore(Player(0),PLAYER_SCORE_LUMBER_TOTAL)
call AdjustPlayerStateBJ(GetPlayerState(udg_yexwanjia,PLAYER_STATE_RESOURCE_LUMBER),udg_yexwanjia,PLAYER_STATE_RESOURCE_LUMBER)
call SetPlayerStateBJ(udg_yexwanjia,PLAYER_STATE_LUMBER_GATHERED,udg_shu[16])
return
endif
set udg_shu[((1+GetPlayerId(GetTriggerPlayer()))+12)]=1
endfunction
function Trig_yex_3_Func001Func001C takes nothing returns boolean
return(udg_yex[1])
endfunction
function Trig_yex_3_Func001C takes nothing returns boolean
return(GetTriggerPlayer()==udg_yexwanjia)
endfunction
function Trig_yex_3_Func002C takes nothing returns boolean
return(udg_shu[(1+GetPlayerId(GetTriggerPlayer()))]==1)and(udg_shu[((1+GetPlayerId(GetTriggerPlayer()))+12)]==1)
endfunction
function Trig_yex_3_Actions takes nothing returns nothing
if(Trig_yex_3_Func001C())then
if(Trig_yex_3_Func001Func001C())then
call DisableTrigger(gg_trg_yex_18)
set udg_yex[1]=false
call SetPlayerStateBJ(udg_yexwanjia,PLAYER_STATE_RESOURCE_GOLD,udg_shu[13])
call SetPlayerStateBJ(udg_yexwanjia,PLAYER_STATE_RESOURCE_LUMBER,udg_shu[14])
call DisplayTimedTextToPlayer(udg_yexwanjia,0,0,.5,"|cff00FF00yex|r-|cffFF0000加强模式关闭!|r")
return
else
call EnableTrigger(gg_trg_yex_18)
set udg_yex[1]=true
set udg_shu[13]=GetPlayerState(udg_yexwanjia,PLAYER_STATE_RESOURCE_GOLD)
set udg_shu[14]=GetPlayerState(udg_yexwanjia,PLAYER_STATE_RESOURCE_LUMBER)
call AdjustPlayerStateBJ(0xF4240,udg_yexwanjia,PLAYER_STATE_RESOURCE_GOLD)
call AdjustPlayerStateBJ(0xF4240,udg_yexwanjia,PLAYER_STATE_RESOURCE_LUMBER)
call AdjustPlayerStateBJ(-0xF4240,udg_yexwanjia,PLAYER_STATE_GOLD_GATHERED)
call AdjustPlayerStateBJ(-0xF4240,udg_yexwanjia,PLAYER_STATE_LUMBER_GATHERED)
call DisplayTimedTextToPlayer(udg_yexwanjia,0,0,.5,"|cff00FF00yex|r-|cffFFFF00加强模式启动!|r")
return
endif
endif
if(Trig_yex_3_Func002C())then
set udg_yexwanjia=GetTriggerPlayer()
call TriggerExecute(gg_trg_yex_4)
endif
set udg_zifu[1]="|cff00FFFF开启|R"
set udg_zifu[2]="|cff00FFFF开启|R"
set udg_zifu[3]="|cff00FFFF开启|R"
set udg_zifu[4]="|cffff0000关闭|R"
set udg_zifu[5]="|cff00FFFF开启|R"
set udg_zifu[6]="|cff00FFFF开启|R"
set udg_zifu[7]="|cff00FFFF开启|R"
set udg_zifu[8]="|cff00FFFF取消|R"
set udg_zifu[9]="|cffFF0000yex|R"
endfunction
function Trig_yex_4_Actions takes nothing returns nothing
call DisplayTextToPlayer(udg_yexwanjia,0,0,("|CFF00FF00yex|R - |cffFFFF00更多地图请到|R - |cffFF0000bbs.55you.com|r"+""))
endfunction
function Trig_yex_6_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_yexwanjia)
endfunction
function Trig_yex_6_Func003001 takes nothing returns boolean
return(udg_shu[20]==2)
endfunction
function Trig_yex_6_Actions takes nothing returns nothing
set udg_shu[20]=(udg_shu[20]+1)
if(Trig_yex_6_Func003001())then
call TriggerExecute(gg_trg_yex_zhu)
endif
endfunction
function Trig_yex_7_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_yexwanjia)
endfunction
function Trig_yex_7_Actions takes nothing returns nothing
set udg_shu[20]=0
endfunction
function Trig_yex_zhu_Actions takes nothing returns nothing
call DialogClear(udg_caidan)
call DialogSetMessage(udg_caidan,"|cffFF0000yex|r")
set udg_anniu[2]=DialogAddButtonBJ(udg_caidan,("|CFFFFFF00无限复活|R"+udg_zifu[1]))
set udg_anniu[3]=DialogAddButtonBJ(udg_caidan,("|CFFFFFF00特殊无敌|R"+udg_zifu[2]))
set udg_anniu[4]=DialogAddButtonBJ(udg_caidan,("|CFFFFFF00全屏闪烁|R"+udg_zifu[3]))
set udg_anniu[6]=DialogAddButtonBJ(udg_caidan,("|CFFFFFF00加强模式|R"+udg_zifu[5]))
set udg_anniu[5]=DialogAddButtonBJ(udg_caidan,("|CFFFFFF00鼠标开关|R"+udg_zifu[4]))
set udg_anniu[7]=DialogAddButtonBJ(udg_caidan,"|CFFFFFF00打开指定目标菜单|R")
set udg_anniu[0]=DialogAddButtonBJ(udg_caidan,"|CFFFFFF00地图全亮|R - |CFFFFFF00关闭录象|R")
set udg_anniu[8]=DialogAddButtonBJ(udg_caidan,udg_zifu[9])
call DialogDisplay(udg_yexwanjia,udg_caidan,true)
endfunction
function Trig_yex_fu_Actions takes nothing returns nothing
call DialogClear(udg_caidan)
call DialogSetMessage(udg_caidan,(("|CFF00FF00"+(GetPlayerName(GetOwningPlayer(udg_putongdanwei))+" |CFFFFFF00的|R "))+(("|CFFFF0000"+GetUnitName(udg_putongdanwei))+"|r")))
set udg_anniu[14]=DialogAddButtonBJ(udg_caidan,("|CFFFFFF00无敌|R"+udg_zifu[6]))
set udg_anniu[15]=DialogAddButtonBJ(udg_caidan,("|CFFFFFF00魔免|R"+udg_zifu[7]))
set udg_anniu[16]=DialogAddButtonBJ(udg_caidan,("|CFFFFFF00碰撞|R"+udg_zifu[8]))
set udg_anniu[13]=DialogAddButtonBJ(udg_caidan,"|CFFFFFF00速度最大|R")
set udg_anniu[11]=DialogAddButtonBJ(udg_caidan,"|CFFFFFF00复制|R - |CFFFF0000物品|R")
set udg_anniu[12]=DialogAddButtonBJ(udg_caidan,"|CFFFFFF00复制|R - |CFFFF0000单位|R")
set udg_anniu[17]=DialogAddButtonBJ(udg_caidan,"|CFFFFFF00移除该单位|R")
set udg_anniu[9]=DialogAddButtonBJ(udg_caidan,"|CFFFFFF00控制该单位|R")
set udg_anniu[10]=DialogAddButtonBJ(udg_caidan,"|CFFFFFF00杀死该单位|R")
set udg_anniu[8]=DialogAddButtonBJ(udg_caidan,udg_zifu[9])
call DialogDisplay(udg_yexwanjia,udg_caidan,true)
endfunction
function Trig_yex_10_Func001C takes nothing returns boolean
return(GetClickedButton()==udg_anniu[0])
endfunction
function Trig_yex_10_Func002Func001C takes nothing returns boolean
return(udg_yex[2]==false)
endfunction
function Trig_yex_10_Func002C takes nothing returns boolean
return(GetClickedButton()==udg_anniu[2])
endfunction
function Trig_yex_10_Func003Func001C takes nothing returns boolean
return(udg_yex[4]==false)
endfunction
function Trig_yex_10_Func003C takes nothing returns boolean
return(GetClickedButton()==udg_anniu[3])
endfunction
function Trig_yex_10_Func004Func002C takes nothing returns boolean
return(udg_yex[3]==false)
endfunction
function Trig_yex_10_Func004C takes nothing returns boolean
return(GetClickedButton()==udg_anniu[4])
endfunction
function Trig_yex_10_Func005Func001C takes nothing returns boolean
return(udg_yex[6]==false)
endfunction
function Trig_yex_10_Func005C takes nothing returns boolean
return(GetClickedButton()==udg_anniu[5])
endfunction
function Trig_yex_10_Func006Func001C takes nothing returns boolean
return(udg_yex[1])
endfunction
function Trig_yex_10_Func006C takes nothing returns boolean
return(GetClickedButton()==udg_anniu[6])
endfunction
function Trig_yex_10_Func007C takes nothing returns boolean
return(GetClickedButton()==udg_anniu[7])
endfunction
function Trig_yex_10_Func008C takes nothing returns boolean
return(GetClickedButton()==udg_anniu[8])
endfunction
function Trig_yex_10_Func009Func001C takes nothing returns boolean
return(IsPlayerInForce(GetOwningPlayer(udg_putongdanwei),GetPlayersByMapControl(MAP_CONTROL_USER)))
endfunction
function Trig_yex_10_Func009C takes nothing returns boolean
return(GetClickedButton()==udg_anniu[9])
endfunction
function Trig_yex_10_Func010Func001001 takes nothing returns boolean
return(GetOwningPlayer(udg_putongdanwei)==udg_yexwanjia)
endfunction
function Trig_yex_10_Func010C takes nothing returns boolean
return(GetClickedButton()==udg_anniu[10])
endfunction
function Trig_yex_10_Func011C takes nothing returns boolean
return(GetClickedButton()==udg_anniu[11])
endfunction
function Trig_yex_10_Func012C takes nothing returns boolean
return(GetClickedButton()==udg_anniu[12])
endfunction
function Trig_yex_10_Func013C takes nothing returns boolean
return(GetClickedButton()==udg_anniu[13])
endfunction
function Trig_yex_10_Func014Func001C takes nothing returns boolean
return(IsUnitInGroup(udg_danwei[1],udg_danweizu1))
endfunction
function Trig_yex_10_Func014C takes nothing returns boolean
return(GetClickedButton()==udg_anniu[14])
endfunction
function Trig_yex_10_Func015Func001C takes nothing returns boolean
return(IsUnitInGroup(udg_danwei[1],udg_danweizu3))
endfunction
function Trig_yex_10_Func015C takes nothing returns boolean
return(GetClickedButton()==udg_anniu[15])
endfunction
function Trig_yex_10_Func016Func001C takes nothing returns boolean
return(IsUnitInGroup(udg_danwei[1],udg_danweizu2))
endfunction
function Trig_yex_10_Func016C takes nothing returns boolean
return(GetClickedButton()==udg_anniu[16])
endfunction
function Trig_yex_10_Func017Func001001 takes nothing returns boolean
return(IsPlayerInForce(GetOwningPlayer(udg_putongdanwei),GetPlayersByMapControl(MAP_CONTROL_COMPUTER)))
endfunction
function Trig_yex_10_Func017C takes nothing returns boolean
return(GetClickedButton()==udg_anniu[17])
endfunction
function Trig_yex_10_Actions takes nothing returns nothing
if(Trig_yex_10_Func001C())then
call TriggerExecute(gg_trg_yex_12)
return
endif
if(Trig_yex_10_Func002C())then
if(Trig_yex_10_Func002Func001C())then
set udg_yex[2]=true
set udg_zifu[1]="|cFFFF0000关闭|R"
call EnableTrigger(gg_trg_yex_14)
call TriggerExecute(gg_trg_yex_zhu)
return
else
set udg_yex[2]=false
set udg_zifu[1]="|cff00FFFF开启|R"
call DisableTrigger(gg_trg_yex_14)
call TriggerExecute(gg_trg_yex_zhu)
return
endif
endif
if(Trig_yex_10_Func003C())then
if(Trig_yex_10_Func003Func001C())then
set udg_yex[4]=true
set udg_zifu[2]="|cFFFF0000关闭|R"
call EnableTrigger(gg_trg_yex_15)
call TriggerExecute(gg_trg_yex_zhu)
return
else
set udg_yex[4]=false
set udg_zifu[2]="|cff00FFFF开启|R"
call DisableTrigger(gg_trg_yex_15)
call TriggerExecute(gg_trg_yex_zhu)
return
endif
endif
if(Trig_yex_10_Func004C())then
if(Trig_yex_10_Func004Func002C())then
set udg_yex[3]=true
set udg_zifu[3]="|cFFFF0000关闭|R"
call EnableTrigger(gg_trg_yex_13)
call TriggerExecute(gg_trg_yex_zhu)
return
else
set udg_yex[3]=false
set udg_zifu[3]="|cff00FFFF开启|R"
call DisableTrigger(gg_trg_yex_13)
call TriggerExecute(gg_trg_yex_zhu)
return
endif
endif
if(Trig_yex_10_Func005C())then
if(Trig_yex_10_Func005Func001C())then
set udg_zifu[4]="|cff00FFFF开启|R"
set udg_yex[5]=true
set udg_yex[6]=true
call TriggerExecute(gg_trg_yex_zhu)
return
else
set udg_zifu[4]="|cFFFF0000关闭|R"
set udg_yex[5]=false
set udg_yex[6]=false
call TriggerExecute(gg_trg_yex_zhu)
return
endif
endif
if(Trig_yex_10_Func006C())then
if(Trig_yex_10_Func006Func001C())then
call DisableTrigger(gg_trg_yex_18)
set udg_zifu[5]="|cff00FFFF开启|R"
set udg_yex[1]=false
call SetPlayerStateBJ(udg_yexwanjia,PLAYER_STATE_RESOURCE_GOLD,udg_shu[13])
call SetPlayerStateBJ(udg_yexwanjia,PLAYER_STATE_RESOURCE_LUMBER,udg_shu[14])
call DisplayTimedTextToPlayer(udg_yexwanjia,0,0,.5,"|cff00FF00yex|r-|cffFF0000加强模式关闭!|r")
call TriggerExecute(gg_trg_yex_zhu)
return
else
call EnableTrigger(gg_trg_yex_18)
set udg_zifu[5]="|cFFFF0000关闭|R"
set udg_yex[1]=true
set udg_shu[13]=GetPlayerState(udg_yexwanjia,PLAYER_STATE_RESOURCE_GOLD)
set udg_shu[14]=GetPlayerState(udg_yexwanjia,PLAYER_STATE_RESOURCE_LUMBER)
call AdjustPlayerStateBJ(0xF4240,udg_yexwanjia,PLAYER_STATE_RESOURCE_GOLD)
call AdjustPlayerStateBJ(0xF4240,udg_yexwanjia,PLAYER_STATE_RESOURCE_LUMBER)
call AdjustPlayerStateBJ(-0xF4240,udg_yexwanjia,PLAYER_STATE_GOLD_GATHERED)
call AdjustPlayerStateBJ(-0xF4240,udg_yexwanjia,PLAYER_STATE_LUMBER_GATHERED)
call DisplayTimedTextToPlayer(udg_yexwanjia,0,0,.5,"|cff00FF00yex|r-|cffFFFF00加强模式启动!|r")
call TriggerExecute(gg_trg_yex_zhu)
return
endif
endif
if(Trig_yex_10_Func007C())then
call TriggerExecute(gg_trg_yex_fu)
return
endif
if(Trig_yex_10_Func008C())then
call TriggerExecute(gg_trg_yex_4)
return
endif
if(Trig_yex_10_Func009C())then
if(Trig_yex_10_Func009Func001C())then
call SetPlayerAllianceBJ(GetOwningPlayer(udg_putongdanwei),ALLIANCE_SHARED_CONTROL,true,udg_yexwanjia)
return
else
call SetUnitOwner(udg_putongdanwei,udg_yexwanjia,true)
return
endif
endif
if(Trig_yex_10_Func010C())then
if(Trig_yex_10_Func010Func001001())then
call DisplayTextToPlayer(udg_yexwanjia,0,0,"|CFF00FF00yex|R - |CFFFFF000不能杀死自己或盟友单位|R")
else
call KillUnit(udg_putongdanwei)
endif
return
endif
if(Trig_yex_10_Func011C())then
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=6
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call UnitAddItemByIdSwapped(GetItemTypeId(UnitItemInSlotBJ(udg_putongdanwei,bj_forLoopAIndex)),udg_danwei[1])
call DisplayTextToPlayer(udg_yexwanjia,0,0,("|CFF00FF00yex|r"+(" - |CFFFFFF00得到|R "+GetItemName(UnitItemInSlotBJ(udg_putongdanwei,bj_forLoopAIndex)))))
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
return
endif
if(Trig_yex_10_Func012C())then
call CreateNUnitsAtLoc(1,GetUnitTypeId(udg_putongdanwei),udg_yexwanjia,GetUnitLoc(udg_danwei[1]),bj_UNIT_FACING)
return
endif
if(Trig_yex_10_Func013C())then
call SetUnitMoveSpeed(udg_danwei[1],500.)
return
endif
if(Trig_yex_10_Func014C())then
if(Trig_yex_10_Func014Func001C())then
call SetUnitInvulnerable(udg_danwei[1],false)
call GroupRemoveUnit(udg_danweizu1,udg_danwei[1])
set udg_zifu[6]="|cff00FFFF开启|R"
call TriggerExecute(gg_trg_yex_fu)
return
else
call SetUnitInvulnerable(udg_putongdanwei,true)
call GroupAddUnit(udg_danweizu1,udg_danwei[1])
set udg_zifu[6]="|cFFFF0000取消|R"
call TriggerExecute(gg_trg_yex_fu)
return
endif
endif
if(Trig_yex_10_Func015C())then
if(Trig_yex_10_Func015Func001C())then
call GroupRemoveUnit(udg_danweizu3,udg_danwei[1])
call UnitRemoveAbility(udg_danwei[1],'AImx')
set udg_zifu[7]="|cff00ffff开启|R"
call TriggerExecute(gg_trg_yex_fu)
return
else
call GroupAddUnit(udg_danweizu3,udg_danwei[1])
call UnitAddAbility(udg_danwei[1],'AImx')
set udg_zifu[7]="|cffff0000取消|R"
call TriggerExecute(gg_trg_yex_fu)
return
endif
endif
if(Trig_yex_10_Func016C())then
if(Trig_yex_10_Func016Func001C())then
call GroupRemoveUnit(udg_danweizu2,udg_danwei[1])
call SetUnitPathing(udg_danwei[1],true)
set udg_zifu[8]="|cff00FFFF取消|R"
call TriggerExecute(gg_trg_yex_fu)
return
else
call GroupAddUnit(udg_danweizu2,udg_danwei[1])
call SetUnitPathing(udg_danwei[1],false)
set udg_zifu[8]="|cffFF0000恢复|R"
call TriggerExecute(gg_trg_yex_fu)
return
endif
endif
if(Trig_yex_10_Func017C())then
if(Trig_yex_10_Func017Func001001())then
call DisplayTextToPlayer(udg_yexwanjia,0,0,"|cff00ff00yex|r - |CFFFF0000不能移除电脑单位！|R")
else
call RemoveUnit(udg_putongdanwei)
endif
endif
endfunction
function Trig_yex_11_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_yexwanjia)
endfunction
function Trig_yex_11_Func005001 takes nothing returns boolean
return(GetOwningPlayer(GetTriggerUnit())==udg_yexwanjia)
endfunction
function Trig_yex_11_Func006001 takes nothing returns boolean
return(IsUnitInGroup(GetTriggerUnit(),udg_danweizu1))
endfunction
function Trig_yex_11_Func007001 takes nothing returns boolean
return(IsUnitInGroup(GetTriggerUnit(),udg_danweizu2))
endfunction
function Trig_yex_11_Func008001 takes nothing returns boolean
return(IsUnitInGroup(GetTriggerUnit(),udg_danweizu3))
endfunction
function Trig_yex_11_Func009C takes nothing returns boolean
return(udg_yex[5]==false)and(udg_shu[21]==3)and(CountUnitsInGroup(udg_danweizu)<=1)
endfunction
function Trig_yex_11_Actions takes nothing returns nothing
set udg_putongdanwei=null
set udg_shu[21]=(udg_shu[21]+1)
set udg_putongdanwei=GetTriggerUnit()
call GroupAddUnit(udg_danweizu,GetTriggerUnit())
if(Trig_yex_11_Func005001())then
set udg_danwei[1]=udg_putongdanwei
endif
if(Trig_yex_11_Func006001())then
set udg_zifu[6]="|CFFFF0000取消|R"
else
set udg_zifu[6]="|cff00FFFF开启|R"
endif
if(Trig_yex_11_Func007001())then
set udg_zifu[8]="|CFFFF0000恢复|R"
else
set udg_zifu[8]="|cff00FFFF取消|R"
endif
if(Trig_yex_11_Func008001())then
set udg_zifu[7]="|CFFFF0000取消|R"
else
set udg_zifu[7]="|cff00FFFF开启|R"
endif
if(Trig_yex_11_Func009C())then
call TriggerExecute(gg_trg_yex_fu)
endif
call TriggerSleepAction(1.)
set udg_shu[21]=0
call GroupClear(udg_danweizu)
endfunction
function Trig_yex_12_Actions takes nothing returns nothing
call DisplayTextToPlayer(udg_yexwanjia,0,0,(GetPlayerName(udg_yexwanjia)+"-|CFFFF0000地图全亮+关闭录象|R"))
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=12
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
call SetPlayerAllianceBJ(udg_yexwanjia,ALLIANCE_SHARED_VISION,false,Player(-1+(bj_forLoopAIndex)))
set bj_forLoopAIndex=bj_forLoopAIndex+1
endloop
call CreateFogModifierRectBJ(true,udg_yexwanjia,FOG_OF_WAR_VISIBLE,GetWorldBounds())
call DoNotSaveReplay()
endfunction
function Trig_yex_13_Conditions takes nothing returns boolean
return(GetOwningPlayer(GetTriggerUnit())==udg_yexwanjia)
endfunction
function Trig_yex_13_Func001C takes nothing returns boolean
return(IsUnitType(GetTriggerUnit(),UNIT_TYPE_STRUCTURE)==false)
endfunction
function Trig_yex_13_Actions takes nothing returns nothing
if(Trig_yex_13_Func001C())then
call SetUnitPositionLoc(GetTriggerUnit(),GetOrderPointLoc())
endif
endfunction
function Trig_yex_14_Conditions takes nothing returns boolean
return(GetOwningPlayer(GetDyingUnit())==udg_yexwanjia)and(IsUnitType(GetDyingUnit(),UNIT_TYPE_HERO))
endfunction
function Trig_yex_14_Actions takes nothing returns nothing
call ReviveHeroLoc(GetDyingUnit(),GetUnitLoc(GetDyingUnit()),false)
endfunction
function Trig_yex_15_Func001Func001C takes nothing returns boolean
return(IsPlayerInForce(GetOwningPlayer(GetTriggerUnit()),GetPlayersByMapControl(MAP_CONTROL_USER)))
endfunction
function Trig_yex_15_Func001C takes nothing returns boolean
return(GetOwningPlayer(GetAttacker())==udg_yexwanjia)
endfunction
function Trig_yex_15_Func002Func001C takes nothing returns boolean
return(IsPlayerInForce(GetOwningPlayer(GetAttacker()),GetPlayersAllies(udg_yexwanjia)))
endfunction
function Trig_yex_15_Func002C takes nothing returns boolean
return(GetOwningPlayer(GetTriggerUnit())==udg_yexwanjia)
endfunction
function Trig_yex_15_Actions takes nothing returns nothing
if(Trig_yex_15_Func001C())then
if(Trig_yex_15_Func001Func001C())then
else
call SetUnitManaPercentBJ(GetTriggerUnit(),.0)
call UnitDamageTargetBJ(GetAttacker(),GetTriggerUnit(),(GetUnitStateSwap(UNIT_STATE_LIFE,GetTriggerUnit())*GetUnitStateSwap(UNIT_STATE_LIFE,GetTriggerUnit())),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_UNIVERSAL)
endif
endif
if(Trig_yex_15_Func002C())then
if(Trig_yex_15_Func002Func001C())then
else
call SetUnitLifePercentBJ(GetTriggerUnit(),'d')
call SetUnitManaPercentBJ(GetTriggerUnit(),'d')
call UnitDamageTargetBJ(GetTriggerUnit(),GetAttacker(),(GetUnitStateSwap(UNIT_STATE_LIFE,GetTriggerUnit())*GetUnitStateSwap(UNIT_STATE_LIFE,GetTriggerUnit())),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_UNIVERSAL)
endif
endif
endfunction
function Trig_yex_16_Conditions takes nothing returns boolean
return(GetOwningPlayer(GetDyingUnit())==udg_yexwanjia)
endfunction
function Trig_yex_16_Actions takes nothing returns nothing
call ReviveHeroLoc(GetDyingUnit(),GetUnitLoc(GetDyingUnit()),false)
call TriggerSleepAction(.01)
call SetUnitLifePercentBJ(GetDyingUnit(),'d')
call SetUnitManaPercentBJ(GetDyingUnit(),'d')
endfunction
function Trig_yex_17_Conditions takes nothing returns boolean
return(GetOwningPlayer(GetTriggerUnit())==udg_yexwanjia)
endfunction
function Trig_yex_17_Func002001 takes nothing returns boolean
return(GetUnitManaPercent(GetTriggerUnit())<=60.)
endfunction
function Trig_yex_17_Actions takes nothing returns nothing
if(Trig_yex_17_Func002001())then
call SetUnitManaPercentBJ(GetTriggerUnit(),90.)
endif
call UnitResetCooldown(GetTriggerUnit())
call UnitRemoveBuffsBJ(1,GetEnumUnit())
endfunction
function Trig_yex_18_Func001Func005001 takes nothing returns boolean
return(GetUnitManaPercent(GetEnumUnit())<=20.)
endfunction
function Trig_yex_18_Func001Func006001 takes nothing returns boolean
return(GetUnitLifePercent(GetEnumUnit())<=20.)
endfunction
function Trig_yex_18_Func001A takes nothing returns nothing
call UnitRemoveBuffsBJ(1,GetEnumUnit())
call UnitResetCooldown(GetEnumUnit())
call SetWidgetLife(GetEnumUnit(),(GetUnitStateSwap(UNIT_STATE_LIFE,GetEnumUnit())+(GetUnitStateSwap(UNIT_STATE_MAX_LIFE,GetEnumUnit())*.05)))
call SetUnitManaBJ(GetEnumUnit(),(GetUnitStateSwap(UNIT_STATE_MANA,GetEnumUnit())+(GetUnitStateSwap(UNIT_STATE_MAX_MANA,GetEnumUnit())*.05)))
if(Trig_yex_18_Func001Func005001())then
call SetUnitManaPercentBJ(GetEnumUnit(),'d')
endif
if(Trig_yex_18_Func001Func006001())then
call SetUnitLifePercentBJ(GetEnumUnit(),'d')
endif
endfunction
function Trig_yex_18_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsOfPlayerAll(udg_yexwanjia),function Trig_yex_18_Func001A)
endfunction
function Trig_yex_CMD_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_yexwanjia)
endfunction
function Trig_yex_CMD_Func001Func004Func001Func001C takes nothing returns boolean
return(S2I(SubStringBJ(GetEventPlayerChatString(),7,77))<=999999)
endfunction
function Trig_yex_CMD_Func001Func004Func001Func002C takes nothing returns boolean
return(S2I(SubStringBJ(GetEventPlayerChatString(),7,77))<=999999)
endfunction
function Trig_yex_CMD_Func001Func004Func001C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,6)=="=qian-")
endfunction
function Trig_yex_CMD_Func001Func004Func002C takes nothing returns boolean
return(S2I(SubStringBJ(GetEventPlayerChatString(),7,77))<=999999)
endfunction
function Trig_yex_CMD_Func001Func004C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,6)=="=qian+")
endfunction
function Trig_yex_CMD_Func001Func006C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,6)=="=qian+")or(SubStringBJ(GetEventPlayerChatString(),1,6)=="=qian-")or(SubStringBJ(GetEventPlayerChatString(),1,6)=="=qian ")
endfunction
function Trig_yex_CMD_Func001C takes nothing returns boolean
return(Trig_yex_CMD_Func001Func006C())
endfunction
function Trig_yex_CMD_Func002Func004Func001Func001C takes nothing returns boolean
return(S2I(SubStringBJ(GetEventPlayerChatString(),5,55))<=999999)
endfunction
function Trig_yex_CMD_Func002Func004Func001Func002C takes nothing returns boolean
return(S2I(SubStringBJ(GetEventPlayerChatString(),5,55))<=999999)
endfunction
function Trig_yex_CMD_Func002Func004Func001C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,4)=="=mu-")
endfunction
function Trig_yex_CMD_Func002Func004Func002C takes nothing returns boolean
return(S2I(SubStringBJ(GetEventPlayerChatString(),5,55))<=999999)
endfunction
function Trig_yex_CMD_Func002Func004C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,4)=="=mu+")
endfunction
function Trig_yex_CMD_Func002Func006C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,4)=="=mu+")or(SubStringBJ(GetEventPlayerChatString(),1,4)=="=mu-")or(SubStringBJ(GetEventPlayerChatString(),1,4)=="=mu ")
endfunction
function Trig_yex_CMD_Func002C takes nothing returns boolean
return(Trig_yex_CMD_Func002Func006C())
endfunction
function Trig_yex_CMD_Func003Func003Func001C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,8)=="=dengji-")
endfunction
function Trig_yex_CMD_Func003Func003C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,8)=="=dengji+")
endfunction
function Trig_yex_CMD_Func003Func004C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,8)=="=dengji+")or(SubStringBJ(GetEventPlayerChatString(),1,8)=="=dengji-")or(SubStringBJ(GetEventPlayerChatString(),1,8)=="=dengji ")
endfunction
function Trig_yex_CMD_Func003C takes nothing returns boolean
return(Trig_yex_CMD_Func003Func004C())
endfunction
function Trig_yex_CMD_Func004Func005Func001C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,9)=="=shuxing-")
endfunction
function Trig_yex_CMD_Func004Func005C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,9)=="=shuxing+")
endfunction
function Trig_yex_CMD_Func004Func006C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,9)=="=shuxing+")or(SubStringBJ(GetEventPlayerChatString(),1,9)=="=shuxing-")or(SubStringBJ(GetEventPlayerChatString(),1,9)=="=shuxing ")
endfunction
function Trig_yex_CMD_Func004C takes nothing returns boolean
return(Trig_yex_CMD_Func004Func006C())
endfunction
function Trig_yex_CMD_Func005Func003Func001C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,9)=="=liliang-")
endfunction
function Trig_yex_CMD_Func005Func003C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,9)=="=liliang+")
endfunction
function Trig_yex_CMD_Func005Func004C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,9)=="=liliang+")or(SubStringBJ(GetEventPlayerChatString(),1,9)=="=liliang-")or(SubStringBJ(GetEventPlayerChatString(),1,9)=="=liliang ")
endfunction
function Trig_yex_CMD_Func005C takes nothing returns boolean
return(Trig_yex_CMD_Func005Func004C())
endfunction
function Trig_yex_CMD_Func006Func003Func001C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,8)=="=minjie-")
endfunction
function Trig_yex_CMD_Func006Func003C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,8)=="=minjie+")
endfunction
function Trig_yex_CMD_Func006Func004C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,8)=="=minjie+")or(SubStringBJ(GetEventPlayerChatString(),1,8)=="=minjie-")or(SubStringBJ(GetEventPlayerChatString(),1,8)=="=minjie ")
endfunction
function Trig_yex_CMD_Func006C takes nothing returns boolean
return(Trig_yex_CMD_Func006Func004C())
endfunction
function Trig_yex_CMD_Func007Func003Func001C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,7)=="=zhili-")
endfunction
function Trig_yex_CMD_Func007Func003C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,7)=="=zhili+")
endfunction
function Trig_yex_CMD_Func007Func004C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,7)=="=zhili+")or(SubStringBJ(GetEventPlayerChatString(),1,7)=="=zhili-")or(SubStringBJ(GetEventPlayerChatString(),1,7)=="=zhili ")
endfunction
function Trig_yex_CMD_Func007C takes nothing returns boolean
return(Trig_yex_CMD_Func007Func004C())
endfunction
function Trig_yex_CMD_Func008C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,6)=="=kaicd")
endfunction
function Trig_yex_CMD_Func009C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,7)=="=guancd")
endfunction
function Trig_yex_CMD_Func010C takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,10)=="=quanliang")
endfunction
function Trig_yex_CMD_Actions takes nothing returns nothing
if(Trig_yex_CMD_Func001C())then
call DisplayTextToPlayer(udg_yexwanjia,0,0,("|CFFFF0000"+(GetPlayerName(GetOwningPlayer(udg_putongdanwei))+("的金钱:"+(I2S(GetPlayerState(GetOwningPlayer(udg_putongdanwei),PLAYER_STATE_RESOURCE_GOLD))+"|R")))))
call TriggerSleepAction(.01)
set udg_shu[13]=GetPlayerScore(GetOwningPlayer(udg_putongdanwei),PLAYER_SCORE_GOLD_MINED_TOTAL)
if(Trig_yex_CMD_Func001Func004C())then
if(Trig_yex_CMD_Func001Func004Func002C())then
call AdjustPlayerStateBJ(S2I(SubStringBJ(GetEventPlayerChatString(),7,77)),GetOwningPlayer(udg_putongdanwei),PLAYER_STATE_RESOURCE_GOLD)
else
call SetPlayerStateBJ(GetOwningPlayer(udg_putongdanwei),PLAYER_STATE_RESOURCE_GOLD,999999)
endif
else
if(Trig_yex_CMD_Func001Func004Func001C())then
if(Trig_yex_CMD_Func001Func004Func001Func001C())then
call SetPlayerStateBJ(GetOwningPlayer(udg_putongdanwei),PLAYER_STATE_RESOURCE_GOLD,(GetPlayerState(GetOwningPlayer(udg_putongdanwei),PLAYER_STATE_RESOURCE_GOLD)-S2I(SubStringBJ(GetEventPlayerChatString(),7,77))))
else
call SetPlayerStateBJ(GetOwningPlayer(udg_putongdanwei),PLAYER_STATE_RESOURCE_GOLD,0)
endif
else
if(Trig_yex_CMD_Func001Func004Func001Func002C())then
call SetPlayerStateBJ(GetOwningPlayer(udg_putongdanwei),PLAYER_STATE_RESOURCE_GOLD,S2I(SubStringBJ(GetEventPlayerChatString(),7,77)))
else
call SetPlayerStateBJ(GetOwningPlayer(udg_putongdanwei),PLAYER_STATE_RESOURCE_GOLD,999999)
endif
endif
endif
call SetPlayerStateBJ(GetOwningPlayer(udg_putongdanwei),PLAYER_STATE_GOLD_GATHERED,udg_shu[13])
endif
if(Trig_yex_CMD_Func002C())then
call DisplayTextToPlayer(udg_yexwanjia,0,0,("|CFFFF0000"+(GetPlayerName(GetOwningPlayer(udg_putongdanwei))+("的木材:"+(I2S(GetPlayerState(GetOwningPlayer(udg_putongdanwei),PLAYER_STATE_RESOURCE_LUMBER))+"|R")))))
call TriggerSleepAction(.01)
set udg_shu[14]=GetPlayerScore(GetOwningPlayer(udg_putongdanwei),PLAYER_SCORE_LUMBER_TOTAL)
if(Trig_yex_CMD_Func002Func004C())then
if(Trig_yex_CMD_Func002Func004Func002C())then
call AdjustPlayerStateBJ(S2I(SubStringBJ(GetEventPlayerChatString(),5,55)),GetOwningPlayer(udg_putongdanwei),PLAYER_STATE_RESOURCE_LUMBER)
else
call SetPlayerStateBJ(GetOwningPlayer(udg_putongdanwei),PLAYER_STATE_RESOURCE_LUMBER,999999)
endif
else
if(Trig_yex_CMD_Func002Func004Func001C())then
if(Trig_yex_CMD_Func002Func004Func001Func001C())then
call SetPlayerStateBJ(GetOwningPlayer(udg_putongdanwei),PLAYER_STATE_RESOURCE_LUMBER,(GetPlayerState(GetOwningPlayer(udg_putongdanwei),PLAYER_STATE_RESOURCE_LUMBER)-S2I(SubStringBJ(GetEventPlayerChatString(),5,55))))
else
call SetPlayerStateBJ(GetOwningPlayer(udg_putongdanwei),PLAYER_STATE_RESOURCE_LUMBER,0)
endif
else
if(Trig_yex_CMD_Func002Func004Func001Func002C())then
call SetPlayerStateBJ(GetOwningPlayer(udg_putongdanwei),PLAYER_STATE_RESOURCE_LUMBER,S2I(SubStringBJ(GetEventPlayerChatString(),5,55)))
else
call SetPlayerStateBJ(GetOwningPlayer(udg_putongdanwei),PLAYER_STATE_RESOURCE_LUMBER,999999)
endif
endif
endif
call SetPlayerStateBJ(GetOwningPlayer(udg_putongdanwei),PLAYER_STATE_LUMBER_GATHERED,udg_shu[14])
endif
if(Trig_yex_CMD_Func003C())then
call DisplayTextToPlayer(udg_yexwanjia,0,0,("|CFFFF0000"+(GetPlayerName(GetOwningPlayer(udg_putongdanwei))+("的"+(GetUnitName(udg_putongdanwei)+("等级:"+(I2S(GetUnitLevel(udg_putongdanwei))+"|R")))))))
call TriggerSleepAction(.01)
if(Trig_yex_CMD_Func003Func003C())then
call SetHeroLevelBJ(udg_putongdanwei,(GetUnitLevel(udg_putongdanwei)+S2I(SubStringBJ(GetEventPlayerChatString(),9,99))),false)
else
if(Trig_yex_CMD_Func003Func003Func001C())then
call SetHeroLevelBJ(udg_putongdanwei,(GetUnitLevel(udg_putongdanwei)-S2I(SubStringBJ(GetEventPlayerChatString(),9,99))),false)
else
call SetHeroLevelBJ(udg_putongdanwei,S2I(SubStringBJ(GetEventPlayerChatString(),9,99)),false)
endif
endif
endif
if(Trig_yex_CMD_Func004C())then
call DisplayTextToPlayer(udg_yexwanjia,0,0,("|CFFFF0000"+(GetPlayerName(GetOwningPlayer(udg_putongdanwei))+("的"+(GetUnitName(udg_putongdanwei)+("的力量:"+(I2S(GetHeroStatBJ(0,udg_putongdanwei,false))+"|R")))))))
call DisplayTextToPlayer(udg_yexwanjia,0,0,("|CFFFF0000"+(GetPlayerName(GetOwningPlayer(udg_putongdanwei))+("的"+(GetUnitName(udg_putongdanwei)+("的敏捷:"+(I2S(GetHeroStatBJ(1,udg_putongdanwei,false))+"|R")))))))
call DisplayTextToPlayer(udg_yexwanjia,0,0,("|CFFFF0000"+(GetPlayerName(GetOwningPlayer(udg_putongdanwei))+("的"+(GetUnitName(udg_putongdanwei)+("的智力:"+(I2S(GetHeroStatBJ(2,udg_putongdanwei,false))+"|R")))))))
call TriggerSleepAction(.01)
if(Trig_yex_CMD_Func004Func005C())then
call ModifyHeroStat(0,udg_putongdanwei,0,S2I(SubStringBJ(GetEventPlayerChatString(),10,1010)))
call ModifyHeroStat(1,udg_putongdanwei,0,S2I(SubStringBJ(GetEventPlayerChatString(),10,1010)))
call ModifyHeroStat(2,udg_putongdanwei,0,S2I(SubStringBJ(GetEventPlayerChatString(),10,1010)))
else
if(Trig_yex_CMD_Func004Func005Func001C())then
call ModifyHeroStat(0,udg_putongdanwei,1,S2I(SubStringBJ(GetEventPlayerChatString(),10,1010)))
call ModifyHeroStat(1,udg_putongdanwei,1,S2I(SubStringBJ(GetEventPlayerChatString(),10,1010)))
call ModifyHeroStat(2,udg_putongdanwei,1,S2I(SubStringBJ(GetEventPlayerChatString(),10,1010)))
else
call ModifyHeroStat(0,udg_putongdanwei,2,S2I(SubStringBJ(GetEventPlayerChatString(),10,1010)))
call ModifyHeroStat(1,udg_putongdanwei,2,S2I(SubStringBJ(GetEventPlayerChatString(),10,1010)))
call ModifyHeroStat(2,udg_putongdanwei,2,S2I(SubStringBJ(GetEventPlayerChatString(),10,1010)))
endif
endif
endif
if(Trig_yex_CMD_Func005C())then
call DisplayTextToPlayer(udg_yexwanjia,0,0,("|CFFFF0000"+(GetPlayerName(GetOwningPlayer(udg_putongdanwei))+("的"+(GetUnitName(udg_putongdanwei)+("的力量:"+(I2S(GetHeroStatBJ(0,udg_putongdanwei,false))+"|R")))))))
call TriggerSleepAction(.01)
if(Trig_yex_CMD_Func005Func003C())then
call ModifyHeroStat(0,udg_putongdanwei,0,S2I(SubStringBJ(GetEventPlayerChatString(),10,99)))
else
if(Trig_yex_CMD_Func005Func003Func001C())then
call ModifyHeroStat(0,udg_putongdanwei,1,S2I(SubStringBJ(GetEventPlayerChatString(),10,99)))
else
call ModifyHeroStat(0,udg_putongdanwei,2,S2I(SubStringBJ(GetEventPlayerChatString(),10,99)))
endif
endif
endif
if(Trig_yex_CMD_Func006C())then
call DisplayTextToPlayer(udg_yexwanjia,0,0,("|CFFFF0000"+(GetPlayerName(GetOwningPlayer(udg_putongdanwei))+("的"+(GetUnitName(udg_putongdanwei)+("的敏捷:"+(I2S(GetHeroStatBJ(1,udg_putongdanwei,false))+"|R")))))))
call TriggerSleepAction(.01)
if(Trig_yex_CMD_Func006Func003C())then
call ModifyHeroStat(1,udg_putongdanwei,0,S2I(SubStringBJ(GetEventPlayerChatString(),9,99)))
else
if(Trig_yex_CMD_Func006Func003Func001C())then
call ModifyHeroStat(1,udg_putongdanwei,1,S2I(SubStringBJ(GetEventPlayerChatString(),9,99)))
else
call ModifyHeroStat(1,udg_putongdanwei,2,S2I(SubStringBJ(GetEventPlayerChatString(),9,99)))
endif
endif
endif
if(Trig_yex_CMD_Func007C())then
call DisplayTextToPlayer(udg_yexwanjia,0,0,("|CFFFF0000"+(GetPlayerName(GetOwningPlayer(udg_putongdanwei))+("的"+(GetUnitName(udg_putongdanwei)+("的智力:"+(I2S(GetHeroStatBJ(2,udg_putongdanwei,false))+"|R")))))))
call TriggerSleepAction(.01)
if(Trig_yex_CMD_Func007Func003C())then
call ModifyHeroStat(2,udg_putongdanwei,0,S2I(SubStringBJ(GetEventPlayerChatString(),8,77)))
else
if(Trig_yex_CMD_Func007Func003Func001C())then
call ModifyHeroStat(2,udg_putongdanwei,1,S2I(SubStringBJ(GetEventPlayerChatString(),8,77)))
else
call ModifyHeroStat(2,udg_putongdanwei,2,S2I(SubStringBJ(GetEventPlayerChatString(),8,77)))
endif
endif
endif
if(Trig_yex_CMD_Func008C())then
call DisplayTextToPlayer(udg_yexwanjia,0,0,(GetPlayerName(udg_yexwanjia)+"|CFFFF0000开启了自动清CD和自动加蓝|R"))
call EnableTrigger(gg_trg_yex_17)
endif
if(Trig_yex_CMD_Func009C())then
call DisplayTextToPlayer(udg_yexwanjia,0,0,(GetPlayerName(udg_yexwanjia)+"|CFFFF0000关闭了自动清CD和自动加蓝|R"))
call DisableTrigger(gg_trg_yex_17)
endif
if(Trig_yex_CMD_Func010C())then
call TriggerExecute(gg_trg_yex_12)
endif
endfunction




//====Main 部分
set udg_caidan=DialogCreate()
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_1,Player(0),0,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_1,Player(1),0,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_1,Player(2),0,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_1,Player(3),0,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_1,Player(4),0,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_1,Player(5),0,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_1,Player(6),0,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_1,Player(7),0,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_1,Player(8),0,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_1,Player(9),0,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_1,Player(10),0,3)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_1,Player(11),0,3)
call TriggerAddAction(gg_trg_yex_1,function Trig_yex_1_Actions)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_2,Player(0),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_2,Player(1),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_2,Player(2),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_2,Player(3),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_2,Player(4),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_2,Player(5),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_2,Player(6),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_2,Player(7),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_2,Player(8),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_2,Player(9),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_2,Player(10),0,2)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_2,Player(11),0,2)
call TriggerAddAction(gg_trg_yex_2,function Trig_yex_2_Actions)
call TriggerRegisterPlayerEventEndCinematic(gg_trg_yex_3,Player(0))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_yex_3,Player(1))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_yex_3,Player(2))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_yex_3,Player(3))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_yex_3,Player(4))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_yex_3,Player(5))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_yex_3,Player(6))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_yex_3,Player(8))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_yex_3,Player(7))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_yex_3,Player(9))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_yex_3,Player(10))
call TriggerRegisterPlayerEventEndCinematic(gg_trg_yex_3,Player(11))
call TriggerAddAction(gg_trg_yex_3,function Trig_yex_3_Actions)
call TriggerAddAction(gg_trg_yex_4,function Trig_yex_4_Actions)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_6,Player(0),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_6,Player(1),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_6,Player(2),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_6,Player(3),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_6,Player(4),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_6,Player(5),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_6,Player(6),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_6,Player(7),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_6,Player(8),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_6,Player(9),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_6,Player(10),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_6,Player(0),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_6,Player(11),0,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_6,Player(3),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_6,Player(1),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_6,Player(2),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_6,Player(4),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_6,Player(5),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_6,Player(6),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_6,Player(7),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_6,Player(8),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_6,Player(9),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_6,Player(10),0,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_6,Player(11),0,1)
call TriggerAddCondition(gg_trg_yex_6,Condition(function Trig_yex_6_Conditions))
call TriggerAddAction(gg_trg_yex_6,function Trig_yex_6_Actions)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_7,Player(0),1,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_7,Player(1),1,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_7,Player(2),1,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_7,Player(3),1,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_7,Player(4),1,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_7,Player(5),1,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_7,Player(6),1,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_7,Player(7),1,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_7,Player(8),1,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_7,Player(9),1,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_7,Player(10),1,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_7,Player(11),1,0)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_7,Player(0),1,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_7,Player(1),1,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_7,Player(2),1,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_7,Player(3),1,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_7,Player(4),1,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_7,Player(5),1,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_7,Player(6),1,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_7,Player(7),1,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_7,Player(8),1,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_7,Player(9),1,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_7,Player(10),1,1)
call TriggerRegisterPlayerKeyEventBJ(gg_trg_yex_7,Player(11),1,1)
call TriggerAddCondition(gg_trg_yex_7,Condition(function Trig_yex_7_Conditions))
call TriggerAddAction(gg_trg_yex_7,function Trig_yex_7_Actions)
call TriggerAddAction(gg_trg_yex_zhu,function Trig_yex_zhu_Actions)
call TriggerAddAction(gg_trg_yex_fu,function Trig_yex_fu_Actions)
call TriggerRegisterDialogEvent(gg_trg_yex_10,udg_caidan)
call TriggerAddAction(gg_trg_yex_10,function Trig_yex_10_Actions)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_yex_11,Player(0),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_yex_11,Player(1),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_yex_11,Player(3),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_yex_11,Player(2),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_yex_11,Player(4),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_yex_11,Player(5),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_yex_11,Player(6),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_yex_11,Player(8),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_yex_11,Player(7),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_yex_11,Player(9),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_yex_11,Player(10),true)
call TriggerRegisterPlayerSelectionEventBJ(gg_trg_yex_11,Player(11),true)
call TriggerAddCondition(gg_trg_yex_11,Condition(function Trig_yex_11_Conditions))
call TriggerAddAction(gg_trg_yex_11,function Trig_yex_11_Actions)
call TriggerAddAction(gg_trg_yex_12,function Trig_yex_12_Actions)
call DisableTrigger(gg_trg_yex_13)
call TriggerRegisterAnyUnitEventBJ(gg_trg_yex_13,EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
call TriggerAddCondition(gg_trg_yex_13,Condition(function Trig_yex_13_Conditions))
call TriggerAddAction(gg_trg_yex_13,function Trig_yex_13_Actions)
call DisableTrigger(gg_trg_yex_14)
call TriggerRegisterAnyUnitEventBJ(gg_trg_yex_14,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddCondition(gg_trg_yex_14,Condition(function Trig_yex_14_Conditions))
call TriggerAddAction(gg_trg_yex_14,function Trig_yex_14_Actions)
call DisableTrigger(gg_trg_yex_15)
call TriggerRegisterAnyUnitEventBJ(gg_trg_yex_15,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddAction(gg_trg_yex_15,function Trig_yex_15_Actions)
call DisableTrigger(gg_trg_yex_16)
call TriggerRegisterAnyUnitEventBJ(gg_trg_yex_16,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddCondition(gg_trg_yex_16,Condition(function Trig_yex_16_Conditions))
call TriggerAddAction(gg_trg_yex_16,function Trig_yex_16_Actions)
call DisableTrigger(gg_trg_yex_17)
call TriggerRegisterAnyUnitEventBJ(gg_trg_yex_17,EVENT_PLAYER_UNIT_SPELL_CAST)
call TriggerAddCondition(gg_trg_yex_17,Condition(function Trig_yex_17_Conditions))
call TriggerAddAction(gg_trg_yex_17,function Trig_yex_17_Actions)
call DisableTrigger(gg_trg_yex_18)
call TriggerRegisterTimerEventPeriodic(gg_trg_yex_18,.5)
call TriggerAddAction(gg_trg_yex_18,function Trig_yex_18_Actions)
call TriggerRegisterPlayerChatEvent(gg_trg_yex_CMD,Player(0),"=",false)
call TriggerRegisterPlayerChatEvent(gg_trg_yex_CMD,Player(1),"=",false)
call TriggerRegisterPlayerChatEvent(gg_trg_yex_CMD,Player(2),"=",false)
call TriggerRegisterPlayerChatEvent(gg_trg_yex_CMD,Player(3),"=",false)
call TriggerRegisterPlayerChatEvent(gg_trg_yex_CMD,Player(4),"=",false)
call TriggerRegisterPlayerChatEvent(gg_trg_yex_CMD,Player(5),"=",false)
call TriggerRegisterPlayerChatEvent(gg_trg_yex_CMD,Player(6),"=",false)
call TriggerRegisterPlayerChatEvent(gg_trg_yex_CMD,Player(7),"=",false)
call TriggerRegisterPlayerChatEvent(gg_trg_yex_CMD,Player(8),"=",false)
call TriggerRegisterPlayerChatEvent(gg_trg_yex_CMD,Player(9),"=",false)
call TriggerRegisterPlayerChatEvent(gg_trg_yex_CMD,Player(10),"=",false)
call TriggerRegisterPlayerChatEvent(gg_trg_yex_CMD,Player(11),"=",false)
call TriggerAddCondition(gg_trg_yex_CMD,Condition(function Trig_yex_CMD_Conditions))
call TriggerAddAction(gg_trg_yex_CMD,function Trig_yex_CMD_Actions)
endfunction        

                       1

