function Trig_sdjiasx_Func001 takes nothing returns boolean
return (IsPlayerEnemy(GetOwningPlayer(GetKillingUnitBJ()), GetOwningPlayer(GetDyingUnit()))==true)
endfunction
function Trig_sdjiasx_Conditions takes nothing returns boolean
return ((Trig_sdjiasx_Func001())and(GetPlayerController(GetOwningPlayer(GetKillingUnitBJ())) == MAP_CONTROL_USER))
endfunction
function Trig_sdjiasx_Actions takes nothing returns nothing
if ((GetRandomInt(1, 100) <= 10)) then
call SetPlayerState(GetOwningPlayer(GetKillingUnit()), PLAYER_STATE_RESOURCE_GOLD, R2I(I2R(GetPlayerState(GetOwningPlayer(GetKillingUnit()), PLAYER_STATE_RESOURCE_GOLD))+100))
call DisplayTimedTextToPlayer( GetOwningPlayer(GetKillingUnit()), 0, 0, 10, "|cFFFFFF00金钱增加100|r" )
else
endif
if ((GetRandomInt(1, 100) <= 5)) then  
call AdjustPlayerStateBJ( 5, GetOwningPlayer(GetKillingUnitBJ()), PLAYER_STATE_RESOURCE_LUMBER )  
call DisplayTextToPlayer( GetOwningPlayer(GetKillingUnitBJ()), 0, 0, "|cFFFFFF00木头加5|r" )
else
endif

if ((GetRandomInt(1, 100) <= 20)) then     // 随机加属性机率

if ((GetRandomInt(501, 504) == 501)) then
call ModifyHeroStat(0,GetKillingUnit(),0,10)
call DisplayTextToPlayer( GetOwningPlayer(GetKillingUnitBJ()), 0, 0, "|cFFFFFF00力量+10|r" )
else
endif

if ((GetRandomInt(501, 504) == 502)) then
call ModifyHeroStat(1,GetKillingUnit(),0,10)
call DisplayTextToPlayer( GetOwningPlayer(GetKillingUnitBJ()), 0, 0, "|cFFFFFF00敏捷+10|r" )
else
endif

if ((GetRandomInt(501, 504) == 503)) then
call ModifyHeroStat(2,GetKillingUnit(),0,10)
call DisplayTextToPlayer( GetOwningPlayer(GetKillingUnitBJ()), 0, 0, "|cFFFFFF00智力+10|r" )
else
endif

 if ((GetRandomInt(501, 504) == 504)) then
call ModifyHeroStat(0,GetKillingUnit(),0,100)
call ModifyHeroStat(1,GetKillingUnit(),0,100)
call ModifyHeroStat(2,GetKillingUnit(),0,100)
call DisplayTextToPlayer( GetOwningPlayer(GetKillingUnitBJ()), 0, 0, "|cFFFFFF00全属性+100|r" )
else
endif
endif
endfunction

function InitTrig_sdjiasx takes nothing returns nothing
set gg_trg_sdjiasx=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_sdjiasx, EVENT_PLAYER_UNIT_DEATH)
call TriggerAddCondition(gg_trg_sdjiasx, Condition(function Trig_sdjiasx_Conditions))
call TriggerAddAction(gg_trg_sdjiasx, function Trig_sdjiasx_Actions)
endfunction