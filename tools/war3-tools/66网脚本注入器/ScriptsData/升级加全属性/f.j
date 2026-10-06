function Trig_asdfghj_Conditions takes nothing returns boolean
return(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)!=null)
endfunction
function Trig_asdfghj_Actions takes nothing returns nothing
call ModifyHeroStat(0,GetTriggerUnit(),0,30) //30可以自己改
call ModifyHeroStat(1,GetTriggerUnit(),0,30)
call ModifyHeroStat(2,GetTriggerUnit(),0,30)
endfunction