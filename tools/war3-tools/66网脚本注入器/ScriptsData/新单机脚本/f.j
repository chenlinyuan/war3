function danjidanji_1 takes nothing returns nothing
local integer i=0
set i=0
loop
exitwhen(i>1)
set udg_danjidanji1[i]=0
set i=i+1
endloop
set udg_danjidanji2=0
set udg_danjidanji0=0
endfunction
function Trig_danjidanji1_Conditions takes nothing returns boolean
if(not(IsUnitEnemy(GetTriggerUnit(),Player(0))==true))then
return false
endif
return true
endfunction
function Trig_danjidanji1_Func005Func001C takes nothing returns boolean
if(not(udg_danjidanji1[udg_danjidanji0]<=udg_danjidanji2))then
return false
endif
return true
endfunction
function Trig_danjidanji1_Func006Func001C takes nothing returns boolean
if(not(GetPlayerSlotState(ConvertedPlayer(udg_danjidanji0))!=PLAYER_SLOT_STATE_PLAYING))then
return false
endif
if(not(udg_danjidanji2==udg_danjidanji1[udg_danjidanji0]))then
return false
endif
return true
endfunction
function Trig_danjidanji1_Actions takes nothing returns nothing
set udg_danjidanji3=GetUnitLoc(GetTriggerUnit())
call SetUnitScalePercent(GetTriggerUnit(),70.00,70.00,70.00)
set udg_danjidanji0=1
loop
exitwhen udg_danjidanji0>10
set udg_danjidanji4=GetPlayerStartLocationLoc(ConvertedPlayer(udg_danjidanji0))
set udg_danjidanji1[udg_danjidanji0]=DistanceBetweenPoints(udg_danjidanji3,udg_danjidanji4)
set udg_danjidanji2=udg_danjidanji1[udg_danjidanji0]
call RemoveLocation(udg_danjidanji4)
set udg_danjidanji0=udg_danjidanji0+1
endloop
call RemoveLocation(udg_danjidanji3)
set udg_danjidanji0=1
loop
exitwhen udg_danjidanji0>10
if(Trig_danjidanji1_Func005Func001C())then
set udg_danjidanji2=udg_danjidanji1[udg_danjidanji0]
call SetUnitUserData(GetTriggerUnit(),udg_danjidanji0)
else
endif
set udg_danjidanji0=udg_danjidanji0+1
endloop
set udg_danjidanji0=1
loop
exitwhen udg_danjidanji0>10
if(Trig_danjidanji1_Func006Func001C())then
call RemoveUnit(GetTriggerUnit())
else
endif
set udg_danjidanji0=udg_danjidanji0+1
endloop
endfunction
function InitTrig_danjidanji1 takes nothing returns nothing
set gg_trg_danjidanji1=CreateTrigger()
call TriggerRegisterEnterRectSimple(gg_trg_danjidanji1,GetPlayableMapRect())
call TriggerAddCondition(gg_trg_danjidanji1,Condition(function Trig_danjidanji1_Conditions))
call TriggerAddAction(gg_trg_danjidanji1,function Trig_danjidanji1_Actions)
endfunction
function Trig_danjidanji2_Func002A takes nothing returns nothing
call RemoveUnit(GetEnumUnit())
endfunction
function Trig_danjidanji2_Func003001002 takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),Player(0))==true)
endfunction
function Trig_danjidanji2_Func003Func001C takes nothing returns boolean
if(not(GetUnitUserData(GetEnumUnit())==GetConvertedPlayerId(GetTriggerPlayer())))then
return false
endif
return true
endfunction
function Trig_danjidanji2_Func003A takes nothing returns nothing
if(Trig_danjidanji2_Func003Func001C())then
call ExplodeUnitBJ(GetEnumUnit())
else
endif
endfunction
function Trig_danjidanji2_Actions takes nothing returns nothing
call DisplayTimedTextToForce(GetPlayersAll(),10.00,(GetPlayerName(GetTriggerPlayer())+"  离开了游戏！已删除区域内单位和敌人。"))
call ForGroupBJ(GetUnitsOfPlayerAll(GetTriggerPlayer()),function Trig_danjidanji2_Func002A)
call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_danjidanji2_Func003001002)),function Trig_danjidanji2_Func003A)
endfunction
function InitTrig_danjidanji2 takes nothing returns nothing
set gg_trg_danjidanji2=CreateTrigger()
call TriggerRegisterPlayerEventLeave(gg_trg_danjidanji2,Player(0))
call TriggerRegisterPlayerEventLeave(gg_trg_danjidanji2,Player(1))
call TriggerRegisterPlayerEventLeave(gg_trg_danjidanji2,Player(2))
call TriggerRegisterPlayerEventLeave(gg_trg_danjidanji2,Player(3))
call TriggerRegisterPlayerEventLeave(gg_trg_danjidanji2,Player(4))
call TriggerRegisterPlayerEventLeave(gg_trg_danjidanji2,Player(5))
call TriggerRegisterPlayerEventLeave(gg_trg_danjidanji2,Player(6))
call TriggerRegisterPlayerEventLeave(gg_trg_danjidanji2,Player(7))
call TriggerRegisterPlayerEventLeave(gg_trg_danjidanji2,Player(8))
call TriggerRegisterPlayerEventLeave(gg_trg_danjidanji2,Player(9))
call TriggerAddAction(gg_trg_danjidanji2,function Trig_danjidanji2_Actions)
endfunction
function danjidanji_2 takes nothing returns nothing
call InitTrig_danjidanji1()
call InitTrig_danjidanji2()
endfunction
