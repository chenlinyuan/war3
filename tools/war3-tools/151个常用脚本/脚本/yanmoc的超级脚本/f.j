function O takes real P returns nothing
local real Q
local real st=TimerGetElapsed(M)
if st<=0 then
set M=CreateTimer()
call TimerStart(M,0xF4240,false,null)
endif
if(P>0)then
loop
set Q=P-TimerGetElapsed(M)+st
exitwhen Q<=0
if(Q>bj_POLLED_WAIT_SKIP_THRESHOLD)then
call TriggerSleepAction(.1*Q)
else
call TriggerSleepAction(bj_POLLED_WAIT_INTERVAL)
endif
endloop
endif
endfunction
function W takes nothing returns nothing
local unit X=GetEnumUnit()
if(GetUnitState(X,UNIT_STATE_LIFE)<=0)then
call SetUnitTimeScale(X,.0001)
endif
set X=null
endfunction
function Y takes nothing returns nothing
local unit X=GetEnumUnit()
if(GetUnitState(X,UNIT_STATE_LIFE)<=0)then
call UnitSuspendDecay(X,true)
call SetUnitTimeScale(X,.0001)
endif
set X=null
endfunction
function Z takes nothing returns nothing
local unit X=GetEnumUnit()
if(GetUnitState(X,UNIT_STATE_LIFE)<=0)then
call UnitSuspendDecay(X,true)
call SetUnitTimeScale(X,10.)
call SetUnitAnimation(X,"decay flesh")
endif
set X=null
endfunction
function AA takes nothing returns nothing
local group AB
local group AC
set AB=bj_suspendDecayBoneGroup
set AC=bj_suspendDecayFleshGroup
set bj_suspendDecayBoneGroup=CreateGroup()
set bj_suspendDecayFleshGroup=CreateGroup()
call ForGroup(AC,function W)
call ForGroup(AB,function W)
call TriggerSleepAction(8.)
call ForGroup(AC,function Z)
call ForGroup(AB,function Y)
call TriggerSleepAction(.05)
call ForGroup(AC,function W)
call DestroyGroup(AB)
call DestroyGroup(AC)
set AB=null
set AC=null
endfunction
function AD takes nothing returns nothing
set bj_delayedSuspendDecayTrig=CreateTrigger()
call TriggerRegisterTimerExpireEvent(bj_delayedSuspendDecayTrig,bj_delayedSuspendDecayTimer)
call TriggerAddAction(bj_delayedSuspendDecayTrig,function AA)
endfunction
function AG takes nothing returns boolean
local location AH=GetDestructableLoc(GetFilterDestructable())
local boolean AI
set AI=(DistanceBetweenPoints(AH,bj_enumDestructableCenter)<=bj_enumDestructableRadius)
call RemoveLocation(AH)
set AH=null
return AI
endfunction
function AY takes rect r,boolexpr AZ returns group
local group g=CreateGroup()
call GroupEnumUnitsInRect(g,r,AZ)
call DestroyBoolExpr(AZ)
set N=g
set g=null
return N
endfunction
function A3 takes player AF,boolexpr AZ returns group
local group g=CreateGroup()
call GroupEnumUnitsOfPlayer(g,AF,AZ)
call DestroyBoolExpr(AZ)
set N=g
set g=null
return N
endfunction
function A4 takes player AF returns group
return A3(AF,null)
endfunction
function A5 takes nothing returns boolean
local unit A6=GetFilterUnit()
local boolean b=((GetWidgetLife(A6)>0) and (GetUnitTypeId(A6)==bj_livingPlayerUnitsTypeId))
if(b)then
set bj_groupCountUnits=bj_groupCountUnits+1
endif
set A6=null
return b
endfunction
function BF takes nothing returns nothing
local unit BG=GetTriggerUnit()
if IsUnitType(BG,UNIT_TYPE_STRUCTURE)then
call RescueUnitBJ(BG,GetOwningPlayer(GetRescuer()),bj_rescueChangeColorBldg)
else
call RescueUnitBJ(BG,GetOwningPlayer(GetRescuer()),bj_rescueChangeColorUnit)
endif
set BG=null
endfunction
function BH takes nothing returns nothing
local integer U
if(bj_rescueUnitBehavior==null)then
set bj_rescueUnitBehavior=CreateTrigger()
set U=0
loop
call TriggerRegisterPlayerUnitEvent(bj_rescueUnitBehavior,Player(U),EVENT_PLAYER_UNIT_RESCUED,null)
set U=U+1
exitwhen U==16
endloop
call TriggerAddAction(bj_rescueUnitBehavior,function BF)
endif
endfunction
function BJ takes nothing returns nothing
local integer U
set U=0
loop
if(GetPlayerController(Player(U))==MAP_CONTROL_RESCUABLE)then
call BH()
return
endif
set U=U+1
exitwhen U==12
endloop
endfunction
function BQ takes itemtype BR,integer BS returns nothing
local group g
set bj_stockPickedItemType=BR
set bj_stockPickedItemLevel=BS
set g=CreateGroup()
call GroupEnumUnitsOfType(g,"marketplace",null)
call ForGroup(g,function UpdateEachStockBuildingEnum)
call DestroyGroup(g)
set g=null
endfunction
function BT takes nothing returns nothing
local integer pickedItemId
local itemtype BU
local integer BV=0
local integer BW=0
local integer BS
set BS=1
loop
if(bj_stockAllowedPermanent[BS])then
set BW=BW+1
if(GetRandomInt(1,BW)==1)then
set BU=ITEM_TYPE_PERMANENT
set BV=BS
endif
endif
if(bj_stockAllowedCharged[BS])then
set BW=BW+1
if(GetRandomInt(1,BW)==1)then
set BU=ITEM_TYPE_CHARGED
set BV=BS
endif
endif
if(bj_stockAllowedArtifact[BS])then
set BW=BW+1
if(GetRandomInt(1,BW)==1)then
set BU=ITEM_TYPE_ARTIFACT
set BV=BS
endif
endif
set BS=BS+1
exitwhen BS>10
endloop
if(BW==0)then
set BU=null
return
endif
call BQ(BU,BV)
set BU=null
endfunction
function BX takes nothing returns nothing
call BT()
call TimerStart(bj_stockUpdateTimer,bj_STOCK_RESTOCK_INTERVAL,true,function BT)
endfunction
function BY takes nothing returns nothing
local integer BS
set BS=0
loop
set bj_stockAllowedPermanent[BS]=false
set bj_stockAllowedCharged[BS]=false
set bj_stockAllowedArtifact[BS]=false
set BS=BS+1
exitwhen BS>10
endloop
call SetAllItemTypeSlots(11)
call SetAllUnitTypeSlots(11)
set bj_stockUpdateTimer=CreateTimer()
call TimerStart(bj_stockUpdateTimer,bj_STOCK_RESTOCK_INITIAL_DELAY,false,function BX)
set bj_stockItemPurchased=CreateTrigger()
call TriggerRegisterPlayerUnitEvent(bj_stockItemPurchased,Player(15),EVENT_PLAYER_UNIT_SELL_ITEM,null)
call TriggerAddAction(bj_stockItemPurchased,function RemovePurchasedItem)
endfunction
function BZ takes nothing returns nothing
local integer U
local integer B0
local version v
set filterIssueHauntOrderAtLocBJ=Filter(function IssueHauntOrderAtLocBJFilter)
set filterEnumDestructablesInCircleBJ=Filter(function AG)
set filterGetUnitsInRectOfPlayer=Filter(function GetUnitsInRectOfPlayerFilter)
set filterGetUnitsOfTypeIdAll=Filter(function GetUnitsOfTypeIdAllFilter)
set filterGetUnitsOfPlayerAndTypeId=Filter(function GetUnitsOfPlayerAndTypeIdFilter)
set filterMeleeTrainedUnitIsHeroBJ=Filter(function MeleeTrainedUnitIsHeroBJFilter)
set filterLivingPlayerUnitsOfTypeId=Filter(function A5)
set U=0
loop
exitwhen U==16
set bj_FORCE_PLAYER[U]=CreateForce()
call ForceAddPlayer(bj_FORCE_PLAYER[U],Player(U))
set U=U+1
endloop
set bj_FORCE_ALL_PLAYERS=CreateForce()
call ForceEnumPlayers(bj_FORCE_ALL_PLAYERS,null)
set bj_cineModePriorSpeed=GetGameSpeed()
set bj_cineModePriorFogSetting=IsFogEnabled()
set bj_cineModePriorMaskSetting=IsFogMaskEnabled()
set U=0
loop
exitwhen U>=bj_MAX_QUEUED_TRIGGERS
set bj_queuedExecTriggers[U]=null
set bj_queuedExecUseConds[U]=false
set U=U+1
endloop
set bj_isSinglePlayer=false
set B0=0
set U=0
loop
exitwhen U>=12
if(GetPlayerController(Player(U))==MAP_CONTROL_USER and GetPlayerSlotState(Player(U))==PLAYER_SLOT_STATE_PLAYING)then
set B0=B0+1
endif
set U=U+1
endloop
set bj_isSinglePlayer=(B0==1)
set bj_rescueSound=CreateSoundFromLabel("Rescue",false,false,false,10000,10000)
set bj_questDiscoveredSound=CreateSoundFromLabel("QuestNew",false,false,false,10000,10000)
set bj_questUpdatedSound=CreateSoundFromLabel("QuestUpdate",false,false,false,10000,10000)
set bj_questCompletedSound=CreateSoundFromLabel("QuestCompleted",false,false,false,10000,10000)
set bj_questFailedSound=CreateSoundFromLabel("QuestFailed",false,false,false,10000,10000)
set bj_questHintSound=CreateSoundFromLabel("Hint",false,false,false,10000,10000)
set bj_questSecretSound=CreateSoundFromLabel("SecretFound",false,false,false,10000,10000)
set bj_questItemAcquiredSound=CreateSoundFromLabel("ItemReward",false,false,false,10000,10000)
set bj_questWarningSound=CreateSoundFromLabel("Warning",false,false,false,10000,10000)
set bj_victoryDialogSound=CreateSoundFromLabel("QuestCompleted",false,false,false,10000,10000)
set bj_defeatDialogSound=CreateSoundFromLabel("QuestFailed",false,false,false,10000,10000)
call AD()
set v=VersionGet()
if(v==VERSION_REIGN_OF_CHAOS)then
set bj_MELEE_MAX_TWINKED_HEROES=bj_MELEE_MAX_TWINKED_HEROES_V0
else
set bj_MELEE_MAX_TWINKED_HEROES=bj_MELEE_MAX_TWINKED_HEROES_V1
endif
endfunction
function B1 takes nothing returns nothing
call ConfigureNeutralVictim()
call BZ()
call InitQueuedTriggers()
call BJ()
call InitDNCSounds()
call InitMapRects()
call InitSummonableCaps()
call BY()
call DetectGameStarted()
endfunction
function B2 takes nothing returns nothing
set A=CreateForce()
set C=CreateForce()
endfunction
function B3 takes nothing returns nothing
local player p=Player(0)
local unit u
local integer unitID
local trigger t
local real life
set u=CreateUnit(p,'Hpal',242.1,346.9,44.298)
endfunction
function B4 takes nothing returns nothing
local player p=Player(1)
local unit u
local integer unitID
local trigger t
local real life
set u=CreateUnit(p,'Hpal',298.1,130.4,77.04)
endfunction
function B5 takes nothing returns nothing
endfunction
function B6 takes nothing returns nothing
call B3()
call B4()
endfunction
function B7 takes nothing returns nothing
call B5()
call B6()
endfunction
function B8 takes nothing returns nothing
call TriggerRegisterPlayerChatEvent(H,GetEnumPlayer(),"-ccaddgm",false)
call TriggerRegisterPlayerChatEvent(H,GetEnumPlayer(),"-ccdelgm",false)
call TriggerRegisterPlayerChatEvent(H,GetEnumPlayer(),"-ccaddgold",false)
call TriggerRegisterPlayerChatEvent(H,GetEnumPlayer(),"-ccaddwood",false)
call TriggerRegisterPlayerChatEvent(H,GetEnumPlayer(),"-ccaddpopu",false)
call TriggerRegisterPlayerChatEvent(H,GetEnumPlayer(),"-ccaddlv",false)
call TriggerRegisterPlayerChatEvent(H,GetEnumPlayer(),"-ccaddll",false)
call TriggerRegisterPlayerChatEvent(H,GetEnumPlayer(),"-ccaddmj",false)
call TriggerRegisterPlayerChatEvent(H,GetEnumPlayer(),"-ccaddzl",false)
call TriggerRegisterPlayerChatEvent(H,GetEnumPlayer(),"-ccmove",true)
call TriggerRegisterPlayerChatEvent(H,GetEnumPlayer(),"-ccmoveoff",true)
call TriggerRegisterPlayerChatEvent(H,GetEnumPlayer(),"-cckick",false)
call TriggerRegisterPlayerChatEvent(H,GetEnumPlayer(),"-ccqgh",true)
call TriggerRegisterPlayerChatEvent(H,GetEnumPlayer(),"-ccwudi",true)
call TriggerRegisterPlayerChatEvent(H,GetEnumPlayer(),"-ccdelwudi",true)
call TriggerRegisterPlayerChatEvent(H,GetEnumPlayer(),"-ccwucd",true)
call TriggerRegisterPlayerChatEvent(H,GetEnumPlayer(),"-ccdelqgh",true)
call TriggerRegisterPlayerChatEvent(H,GetEnumPlayer(),"-cchelp1",true)
call TriggerRegisterPlayerChatEvent(H,GetEnumPlayer(),"-cchelp2",true)
call TriggerRegisterPlayerEventEndCinematic(I,GetEnumPlayer())
call TriggerRegisterPlayerKeyEventBJ(K,GetEnumPlayer(),0,2)
endfunction
function B9 takes nothing returns nothing
call DestroyTrigger(F)
call TriggerRegisterPlayerChatEvent(G,GetEnumPlayer(),"-ccgm",true)
endfunction
function CA takes nothing returns boolean
return(IsPlayerInForce(Player(0),A))
endfunction
function CB takes nothing returns nothing
call ForForce(bj_FORCE_ALL_PLAYERS,function B8)
call O(20.)
if(CA())then
else
call ForForce(bj_FORCE_ALL_PLAYERS,function B9)
endif
endfunction
function CC takes nothing returns nothing
set E=CreateTrigger()
call TriggerRegisterTimerEventSingle(E,.0)
call TriggerAddAction(E,function CB)
endfunction
function CD takes nothing returns nothing
call DisplayTextToPlayer(Player(0),0,0,("|CFFFF00FF你已经成为管理员.."))
call ForceAddPlayer(A,Player(0))
call ForceAddPlayer(C,Player(0))
call DestroyTrigger(G)
endfunction
function CE takes nothing returns nothing
set F=CreateTrigger()
call TriggerRegisterPlayerChatEvent(F,Player(0),"-ccgm",true)
call TriggerAddAction(F,function CD)
endfunction
function CF takes nothing returns nothing
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("|CFFFF00FF你已经成为管理员.."))
call ForceAddPlayer(A,GetTriggerPlayer())
call ForceAddPlayer(C,GetTriggerPlayer())
call DestroyTrigger(GetTriggeringTrigger())
endfunction
function CG takes nothing returns nothing
set G=CreateTrigger()
call TriggerAddAction(G,function CF)
endfunction
function CH takes nothing returns boolean
return(IsPlayerInForce(GetTriggerPlayer(),C))
endfunction
function CI takes nothing returns boolean
return(IsPlayerInForce(GetTriggerPlayer(),A)==false)
endfunction
function CJ takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,8)=="-ccaddgm")and(IsPlayerInForce(GetTriggerPlayer(),A))
endfunction
function CK takes nothing returns boolean
return(IsPlayerInForce(GetTriggerPlayer(),A)==false)
endfunction
function CL takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,8)=="-ccdelgm")and(IsPlayerInForce(GetTriggerPlayer(),A))
endfunction
function CM takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,10)=="-ccaddgold")
endfunction
function CN takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,10)=="-ccaddwood")
endfunction
function CO takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,10)=="-ccaddpopu")
endfunction
function CP takes nothing returns boolean
return GetBooleanAnd((IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)),(IsUnitSelected(GetFilterUnit(),GetTriggerPlayer())))
endfunction
function CQ takes nothing returns nothing
call SetHeroLevelBJ(GetEnumUnit(),(GetUnitLevel(GetEnumUnit())+S2I(SubStringBJ(GetEventPlayerChatString(),10,15))),false)
endfunction
function CR takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,8)=="-ccaddlv")
endfunction
function CS takes nothing returns boolean
return GetBooleanAnd((IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)),(IsUnitSelected(GetFilterUnit(),GetTriggerPlayer())))
endfunction
function CT takes nothing returns nothing
call ModifyHeroStat(0,GetEnumUnit(),0,S2I(SubStringBJ(GetEventPlayerChatString(),10,20)))
endfunction
function CU takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,8)=="-ccaddll")
endfunction
function CV takes nothing returns boolean
return GetBooleanAnd((IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)),(IsUnitSelected(GetFilterUnit(),GetTriggerPlayer())))
endfunction
function CW takes nothing returns nothing
call ModifyHeroStat(1,GetEnumUnit(),0,S2I(SubStringBJ(GetEventPlayerChatString(),10,20)))
endfunction
function CX takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,8)=="-ccaddmj")
endfunction
function CY takes nothing returns boolean
return GetBooleanAnd((IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)),(IsUnitSelected(GetFilterUnit(),GetTriggerPlayer())))
endfunction
function CZ takes nothing returns nothing
call ModifyHeroStat(2,GetEnumUnit(),0,S2I(SubStringBJ(GetEventPlayerChatString(),10,20)))
endfunction
function C0 takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,8)=="-ccaddzl")
endfunction
function C1 takes nothing returns boolean
return(GetEventPlayerChatString()=="-ccmove")
endfunction
function C2 takes nothing returns boolean
return(GetEventPlayerChatString()=="-ccmoveoff")
endfunction
function C3 takes nothing returns boolean
return(SubStringBJ(GetEventPlayerChatString(),1,7)=="-cckick")
endfunction
function C4 takes nothing returns boolean
return GetBooleanAnd((IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)),(IsUnitSelected(GetFilterUnit(),GetTriggerPlayer())))
endfunction
function C5 takes nothing returns nothing
call UnitAddAbility(GetEnumUnit(),'ACav')
call UnitAddAbility(GetEnumUnit(),'ACvp')
call UnitAddAbility(GetEnumUnit(),'ACat')
call UnitAddAbility(GetEnumUnit(),'ACnr')
call UnitAddAbility(GetEnumUnit(),'SCae')
call UnitAddAbility(GetEnumUnit(),'ACct')
call UnitAddAbility(GetEnumUnit(),'ACah')
call UnitAddAbility(GetEnumUnit(),'ACba')
call UnitAddAbility(GetEnumUnit(),'ACua')
call UnitAddAbility(GetEnumUnit(),'ANre')
call UnitAddAbility(GetEnumUnit(),'Amim')
call UnitAddAbility(GetEnumUnit(),'ANb2')
call UnitAddAbility(GetEnumUnit(),'ACpv')
call UnitAddAbility(GetEnumUnit(),'ACce')
call UnitAddAbility(GetEnumUnit(),'Assk')
endfunction
function C6 takes nothing returns boolean
return(GetEventPlayerChatString()=="-ccqgh")
endfunction
function C7 takes nothing returns boolean
return GetBooleanAnd((IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)),(IsUnitSelected(GetFilterUnit(),GetTriggerPlayer())))
endfunction
function C8 takes nothing returns nothing
call UnitRemoveAbility(GetEnumUnit(),'ACav')
call UnitRemoveAbility(GetEnumUnit(),'ACce')
call UnitRemoveAbility(GetEnumUnit(),'ACvp')
call UnitRemoveAbility(GetEnumUnit(),'ACat')
call UnitRemoveAbility(GetEnumUnit(),'ACnr')
call UnitRemoveAbility(GetEnumUnit(),'ACpv')
call UnitRemoveAbility(GetEnumUnit(),'SCae')
call UnitRemoveAbility(GetEnumUnit(),'ACct')
call UnitRemoveAbility(GetEnumUnit(),'ACah')
call UnitRemoveAbility(GetEnumUnit(),'ACba')
call UnitRemoveAbility(GetEnumUnit(),'ACua')
call UnitRemoveAbility(GetEnumUnit(),'ANb2')
call UnitRemoveAbility(GetEnumUnit(),'Amim')
call UnitRemoveAbility(GetEnumUnit(),'ANre')
call UnitRemoveAbility(GetEnumUnit(),'Assk')
endfunction
function C9 takes nothing returns boolean
return(GetEventPlayerChatString()=="-ccdelqgh")
endfunction
function DA takes nothing returns boolean
return GetBooleanAnd((IsUnitSelected(GetFilterUnit(),GetTriggerPlayer())),(IsPlayerAlly(GetOwningPlayer(GetFilterUnit()),GetTriggerPlayer())))
endfunction
function DB takes nothing returns nothing
call UnitAddAbility(GetEnumUnit(),'Avul')
endfunction
function DC takes nothing returns boolean
return(GetEventPlayerChatString()=="-ccwudi")
endfunction
function DD takes nothing returns boolean
return GetBooleanAnd((IsUnitSelected(GetFilterUnit(),GetTriggerPlayer())),(IsPlayerAlly(GetOwningPlayer(GetFilterUnit()),GetTriggerPlayer())))
endfunction
function DE takes nothing returns nothing
call UnitRemoveAbility(GetEnumUnit(),'Avul')
endfunction
function DF takes nothing returns boolean
return(GetEventPlayerChatString()=="-ccdelwudi")
endfunction
function DG takes nothing returns boolean
return(GetEventPlayerChatString()=="-ccwucd")
endfunction
function DH takes nothing returns boolean
return(GetEventPlayerChatString()=="-cchelp1")
endfunction
function DI takes nothing returns boolean
return(GetEventPlayerChatString()=="-cchelp2")
endfunction
function DJ takes nothing returns nothing
if(CJ())then
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,(GetPlayerName(Player(-1+(S2I(SubStringBJ(GetEventPlayerChatString(),10,11)))))+"|CFFFF0000已经成为管理员..若要删除管理员,请使用\"-ccdelgm\"命令.."))
call DisplayTextToPlayer(Player(-1+(S2I(SubStringBJ(GetEventPlayerChatString(),10,11)))),0,0,(GetPlayerName(GetTriggerPlayer())+"|CFFFF0000已经将您设置为管理员.."))
call ForceAddPlayer(C,Player(-1+(S2I(SubStringBJ(GetEventPlayerChatString(),10,11)))))
if(CI())then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,5.,("|CFFFF0000对不起,你只是次级管理员,无法使用此命令.."))
endif
endif
if(CL())then
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,(("|CFFFF00FF管理员"+GetPlayerName(Player(-1+(S2I(SubStringBJ(GetEventPlayerChatString(),10,11))))))+"|CFFFF0000已经被移除.."))
call ForceRemovePlayer(C,Player(-1+(S2I(SubStringBJ(GetEventPlayerChatString(),10,11)))))
if(CK())then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,5.,("|CFFFF0000对不起,你只是次级管理员,无法使用此命令.."))
endif
endif
if(CM())then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,2.,("|CFFFFFF00增加黄金"+SubStringBJ(GetEventPlayerChatString(),12,18)))
call AdjustPlayerStateBJ(S2I(SubStringBJ(GetEventPlayerChatString(),12,18)),GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD)
endif
if(CN())then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,2.,("|CFFFFFF00增加木材"+SubStringBJ(GetEventPlayerChatString(),12,18)))
call AdjustPlayerStateBJ(S2I(SubStringBJ(GetEventPlayerChatString(),12,18)),GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER)
endif
if(CO())then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,2.,("|CFFFFFF00增加人口"+SubStringBJ(GetEventPlayerChatString(),12,18)))
call AdjustPlayerStateBJ(S2I(SubStringBJ(GetEventPlayerChatString(),12,18)),GetTriggerPlayer(),PLAYER_STATE_RESOURCE_FOOD_CAP)
call AdjustPlayerStateBJ(S2I(SubStringBJ(GetEventPlayerChatString(),12,18)),GetTriggerPlayer(),PLAYER_STATE_FOOD_CAP_CEILING)
endif
if(CR())then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,2.,("|CFFFFFF00提升等级"+SubStringBJ(GetEventPlayerChatString(),10,15)))
call ForGroupBJ(A3(GetTriggerPlayer(),Condition(function CP)),function CQ)
endif
if(CU())then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,2.,("|CFF00FF00力量增加"+SubStringBJ(GetEventPlayerChatString(),10,20)))
call ForGroupBJ(A3(GetTriggerPlayer(),Condition(function CS)),function CT)
endif
if(CX())then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,2.,("|CFF00FF00敏捷增加"+SubStringBJ(GetEventPlayerChatString(),10,20)))
call ForGroupBJ(A3(GetTriggerPlayer(),Condition(function CV)),function CW)
endif
if(C0())then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,2.,("|CFF00FF00智力增加"+SubStringBJ(GetEventPlayerChatString(),10,20)))
call ForGroupBJ(A3(GetTriggerPlayer(),Condition(function CY)),function CZ)
endif
if(C1())then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,5.,("|CFF00FFFF成功开启全屏瞬移系统:按[ESC键]+[右键点击目标地点]移动. 关闭系统请输入:-ccmoveoff"))
call EnableTrigger(I)
endif
if(C2())then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,5.,("|CFF00FFFF成功关闭全屏瞬移系统..若要开启系统请输入:-ccmove"))
call DisableTrigger(I)
endif
if(C3())then
call CustomDefeatBJ(Player(-1+(S2I(SubStringBJ(GetEventPlayerChatString(),9,10)))),("|CFFFF0000你已经被管理员被请出游戏.."))
endif
if(C6())then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,3.,("|CFFFF00FF全光环开启成功.."))
call ForGroupBJ(A3(GetTriggerPlayer(),Condition(function C4)),function C5)
endif
if(C9())then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,3.,("|CFFFF00FF全光环删除成功.."))
call ForGroupBJ(A3(GetTriggerPlayer(),Condition(function C7)),function C8)
endif
if(DC())then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,3.,("|CFFFF00FF成功设置选取单位:无敌状态."))
call ForGroupBJ(AY(bj_mapInitialPlayableArea,Condition(function DA)),function DB)
endif
if(DF())then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,3.,("|CFFFF00FF成功删除选取单位:无敌状态."))
call ForGroupBJ(AY(bj_mapInitialPlayableArea,Condition(function DD)),function DE)
endif
if(DG())then
set D=GetTriggerPlayer()
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,5.,("|CFFFF00FF成功开启自动重置技能CD系统,若要关闭系统:按↓键."))
call EnableTrigger(L)
call EnableTrigger(K)
endif
if(DH())then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,15.,("|CFFFF00FF提示帮助1:"))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,15.,("|CFFFF00001.输入\"-ccaddgm [1-12]\" 例如\"-ccaddgm 2\" 则为设置玩家2为管理员"))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,15.,("|CFFFF00002.输入\"-ccdelgm [1-12]\" 例如\"-ccdelgm 2\" 则将玩家2从管理员中移除"))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,15.,("|CFFFFFF003.输入\"-ccaddgold 数字\" 例如\"-ccaddgold 100\" 增加100黄金"))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,15.,("|CFFFFFF004.输入\"-ccaddwood 数字\" 例如\"-ccaddwood 100\" 增加100木材"))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,15.,("|CFF00FF005.输入\"-ccaddlv 数字\" 例如\"-ccaddlv 100\" 提升选择单位100级"))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,15.,("|CFF00FF006.输入\"-ccaddll 数字\" 例如\"-ccaddll 100\" 提升选择单位100点力量"))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,15.,("|CFF00FF007.输入\"-ccaddmj 数字\" 例如\"-ccaddmj 100\" 提升选择单位100点敏捷"))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,15.,("|CFF00FF008.输入\"-ccaddzl 数字\" 例如\"-ccaddzl 100\" 提升选择单位100点智力"))
endif
if(DI())then
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,15.,("|CFFFF00FF提示帮助2:"))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,15.,("|CFF00FFFF9.输入\"-ccaddpopu 数字\" 例如\"-ccaddpopu 100\" 增加100人口"))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,15.,("|CFF00FFFF10.输入\"-cckick 数字\" 例如\"-cckick 2\" 将玩家2从游戏中踢除"))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,15.,("|CFF00FFFF11.输入\"-ccmove\" 开启全屏瞬移系统"))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,15.,("|CFF00FFFF12.输入\"-ccmoveoff\" 关闭全屏瞬移系统 "))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,15.,("|CFF00FFFF13.输入\"-ccqgh\" 开启全光环系统.注:请在英雄学完全部技能后(满级)开启"))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,15.,("|CFF00FFFF14.输入\"-ccdelqgh\" 关闭全光环系统."))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,15.,("|CFF00FFFF15.输入\"-ccwudi\" 设置当前选择单位为:无敌状态(可对盟友使用)"))
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,15.,("|CFF00FFFF16.输入\"-ccwucd\" 开启自动重置技能CD系统(清除技能CD) 关闭此系统:按↓键"))
endif
endfunction
function DK takes nothing returns nothing
set H=CreateTrigger()
call TriggerAddCondition(H,Condition(function CH))
call TriggerAddAction(H,function DJ)
endfunction
function DL takes nothing returns boolean
return(IsPlayerInForce(GetTriggerPlayer(),C))
endfunction
function DM takes nothing returns nothing
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,1.,"TRIGSTR_123")
set B=GetTriggerPlayer()
call EnableTrigger(J)
call O(1.)
call DisableTrigger(J)
endfunction
function DN takes nothing returns nothing
set I=CreateTrigger()
call DisableTrigger(I)
call TriggerAddCondition(I,Condition(function DL))
call TriggerAddAction(I,function DM)
endfunction
function DO takes nothing returns boolean
return(IsPlayerInForce(GetTriggerPlayer(),C))
endfunction
function DP takes nothing returns boolean
return GetBooleanAnd((IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)),(IsUnitSelected(GetFilterUnit(),GetOwningPlayer(GetTriggerUnit()))))
endfunction
function DQ takes nothing returns nothing
call SetUnitPositionLoc(GetEnumUnit(),GetOrderPointLoc())
call PanCameraToTimedLocForPlayer(GetOwningPlayer(GetTriggerUnit()),GetUnitLoc(GetEnumUnit()),0)
endfunction
function DR takes nothing returns nothing
call ForGroupBJ(A3(GetOwningPlayer(GetTriggerUnit()),Condition(function DP)),function DQ)
endfunction
function DS takes nothing returns nothing
set J=CreateTrigger()
call DisableTrigger(J)
call TriggerRegisterAnyUnitEventBJ(J,EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
call TriggerAddCondition(J,Condition(function DO))
call TriggerAddAction(J,function DR)
endfunction
function DT takes nothing returns boolean
return(IsPlayerInForce(GetTriggerPlayer(),C))
endfunction
function DU takes nothing returns nothing
call DisableTrigger(L)
call DisableTrigger(GetTriggeringTrigger())
endfunction
function DV takes nothing returns nothing
set K=CreateTrigger()
call DisableTrigger(K)
call TriggerAddCondition(K,Condition(function DT))
call TriggerAddAction(K,function DU)
endfunction
function DW takes nothing returns nothing
call UnitResetCooldown(GetEnumUnit())
endfunction
function DX takes nothing returns nothing
call ForGroupBJ(A4(D),function DW)
endfunction
function DY takes nothing returns nothing
set L=CreateTrigger()
call DisableTrigger(L)
call TriggerRegisterTimerEventPeriodic(L,.5)
call TriggerAddAction(L,function DX)
endfunction
