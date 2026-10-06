function GJQM001 takes nothing returns boolean
return (((IsPlayerEnemy(GetOwningPlayer(GetKillingUnitBJ()), GetOwningPlayer(GetDyingUnit())) == true) and (GetPlayerController(GetOwningPlayer(GetKillingUnitBJ())) == MAP_CONTROL_USER)))
endfunction
function GJQM0012 takes nothing returns nothing
local integer jiaqian=0
local integer jiamu=0
local integer sjmu=0
local integer jiark=0
local integer jiaren=0
if (GetRandomInt(1,100)>=85) then   //这里改金钱几率
set jiaqian=R2I(I2R(GetPlayerState(GetOwningPlayer(GetKillingUnitBJ()), PLAYER_STATE_RESOURCE_GOLD)))      
if (jiaqian<=20000) then   //这里改金钱增加的上限
call AdjustPlayerStateBJ((jiaqian/20),GetOwningPlayer(GetKillingUnitBJ()), PLAYER_STATE_RESOURCE_GOLD)    // 这里改金钱增加的几率
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()), 0, 0, "|cFFFFFF00金钱增加5%")
else
endif
endif
if (GetRandomInt(1,200)>=199) then  //这里改木头几率
set jiamu=R2I(I2R(GetPlayerState(GetOwningPlayer(GetKillingUnitBJ()), PLAYER_STATE_RESOURCE_LUMBER)))   
if (jiamu<=20) then   //这里改木头增加的上限  
set sjmu=GetRandomInt(1,3) //这里改木头随机数  
call AdjustPlayerStateBJ(sjmu,GetOwningPlayer(GetKillingUnitBJ()),PLAYER_STATE_RESOURCE_LUMBER )  
call DisplayTextToPlayer(GetOwningPlayer(GetKillingUnitBJ()), 0, 0, "|cFFFFFF00木头+"+I2S(sjmu))
else
endif
endif
if((GetRandomInt(1,1000)==767)and(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==false))then
call UnitAddItemByIdSwapped(ChooseRandomItemBJ(-1),GetTriggerUnit())  // 爆物品
endif
endfunction
function sgsjjsx takes nothing returns nothing
local trigger SGJQM=null
set SGJQM=CreateTrigger()   
call TriggerRegisterAnyUnitEventBJ(SGJQM,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddCondition(SGJQM, Condition(function GJQM001))
call TriggerAddAction(SGJQM,function GJQM0012)
endfunction