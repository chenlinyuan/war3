function Trig_yedfsadgsdg_Func005C takes nothing returns boolean
return(IsUnitDeadBJ(FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))))and(GetEventPlayerChatString()=="我要复活")
endfunction
function Trig_yedfsadgsdg_Conditions takes nothing returns boolean
return(Trig_yedfsadgsdg_Func005C())
endfunction
function Trig_yedfsadgsdg_Actions takes nothing returns nothing
set udg_ssd=FirstOfGroup(GetUnitsOfPlayerAll(GetTriggerPlayer()))
set udg_sd=GetUnitLoc(udg_ssd)
set udg_fuhuojishi857=GetLastCreatedTimerDialogBJ()
call ReviveHeroLoc(udg_ssd,udg_sd,false)
call RemoveLocation(udg_sd)
call TriggerSleepAction(1.)
call DestroyTimerDialog(udg_fuhuojishi857)
call DisplayTextToForce(GetPlayersAll(), (GetPlayerName(GetTriggerPlayer())+ "|cFFFFFF00得到了上帝的救赎已复活！|r" ))
endfunction
function Trig_zisha_Func001001002 takes nothing returns boolean
return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO))!=null
endfunction
function Trig_zisha_Func001A takes nothing returns nothing
call KillUnit(GetEnumUnit())
call DisplayTextToForce(GetPlayersAll(), (GetPlayerName(GetTriggerPlayer())+ "|cFFFFFF00感到生无可恋， 已自杀身亡！|r"))
endfunction
function Trig_zisha_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsOfPlayerMatching(Player(0),Condition(function Trig_zisha_Func001001002)),function Trig_zisha_Func001A)
call ForGroupBJ(GetUnitsOfPlayerMatching(Player(1),Condition(function Trig_zisha_Func001001002)),function Trig_zisha_Func001A)
call ForGroupBJ(GetUnitsOfPlayerMatching(Player(2),Condition(function Trig_zisha_Func001001002)),function Trig_zisha_Func001A)
call ForGroupBJ(GetUnitsOfPlayerMatching(Player(3),Condition(function Trig_zisha_Func001001002)),function Trig_zisha_Func001A)
call ForGroupBJ(GetUnitsOfPlayerMatching(Player(4),Condition(function Trig_zisha_Func001001002)),function Trig_zisha_Func001A)
call ForGroupBJ(GetUnitsOfPlayerMatching(Player(5),Condition(function Trig_zisha_Func001001002)),function Trig_zisha_Func001A)
call ForGroupBJ(GetUnitsOfPlayerMatching(Player(6),Condition(function Trig_zisha_Func001001002)),function Trig_zisha_Func001A)
call ForGroupBJ(GetUnitsOfPlayerMatching(Player(7),Condition(function Trig_zisha_Func001001002)),function Trig_zisha_Func001A)
endfunction
function InitTrig_zisha takes nothing returns nothing
set gg_trg_zisha=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_zisha,Player(0),"我要自杀",true)
call TriggerRegisterPlayerChatEvent(gg_trg_zisha,Player(1),"我要自杀",true)
call TriggerRegisterPlayerChatEvent(gg_trg_zisha,Player(2),"我要自杀",true)
call TriggerRegisterPlayerChatEvent(gg_trg_zisha,Player(3),"我要自杀",true)
call TriggerRegisterPlayerChatEvent(gg_trg_zisha,Player(4),"我要自杀",true)
call TriggerRegisterPlayerChatEvent(gg_trg_zisha,Player(5),"我要自杀",true)
call TriggerRegisterPlayerChatEvent(gg_trg_zisha,Player(6),"我要自杀",true)
call TriggerRegisterPlayerChatEvent(gg_trg_zisha,Player(7),"我要自杀",true)
call TriggerAddAction(gg_trg_zisha,function Trig_zisha_Actions)
endfunction
