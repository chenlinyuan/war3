function Trig_kqzb_Actions takes nothing returns nothing
set udg_kqzb=GetTriggerPlayer()
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10,"|cFFFFFF00已开启作弊脚本  |r|cFF00FF00脚本修改：|r  hellour|R")
call DisableTrigger(GetTriggeringTrigger())
endfunction
function Trig_cmdwudi_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_kqzb)
endfunction
function Trig_cmdwudi_Func001002 takes nothing returns nothing
call SetUnitInvulnerable(GetEnumUnit(),true)
endfunction
function Trig_cmdwudi_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_cmdwudi_Func001002)
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+" |cFFFFFF00已开启无敌脚本|r"))
call DestroyGroup(bj_lastCreatedGroup)
endfunction
function Trig_cmdbuwudi_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_kqzb)
endfunction
function Trig_cmdbuwudi_Func001002 takes nothing returns nothing
call SetUnitInvulnerable(GetEnumUnit(),false)
endfunction
function Trig_cmdbuwudi_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_cmdbuwudi_Func001002)
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+" |cFFFFFF00已关闭无敌脚本|r"))
call DestroyGroup(bj_lastCreatedGroup)
endfunction
function Trig_cmdtssw_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_kqzb)
endfunction
function Trig_cmdtssw_Func001002 takes nothing returns nothing
call SetHeroLevelBJ(GetEnumUnit(),(GetHeroLevel(GetEnumUnit())+1),false)
call ModifyHeroStat(0,GetEnumUnit(),0,100)
call ModifyHeroStat(1,GetEnumUnit(),0,100)
call ModifyHeroStat(2,GetEnumUnit(),0,100)
endfunction
function Trig_cmdtssw_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_cmdtssw_Func001002)
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+" |cFFFFFF00 飞升仙界！ |r提升等级1级，力、敏、智各加100点"))
call DestroyGroup(bj_lastCreatedGroup)
endfunction
function Trig_cmdjssw_Conditions takes nothing returns boolean
return(GetTriggerPlayer()==udg_kqzb)
endfunction
function Trig_cmdjssw_Func001A takes nothing returns nothing
call SetHeroLevelBJ(GetEnumUnit(),(GetHeroLevel(GetEnumUnit())-1),false)
call ModifyHeroStat(0,GetEnumUnit(),1,100)
call ModifyHeroStat(1,GetEnumUnit(),1,100)
call ModifyHeroStat(2,GetEnumUnit(),1,100)
endfunction
function Trig_cmdjssw_Actions takes nothing returns nothing
call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()),function Trig_cmdjssw_Func001A)
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,(GetPlayerName(GetTriggerPlayer())+" |cFFFFFF00 坠落凡间！ |r降低等级1级，力、敏、智各减100点"))
call DestroyGroup(bj_lastCreatedGroup)
endfunction