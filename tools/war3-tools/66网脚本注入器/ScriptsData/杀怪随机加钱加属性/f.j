function Trig_jiashuxing_Func001Func003Func001Func001Func001Func007C takes nothing returns boolean
return(300<udg_suijishu)and(310>=udg_suijishu)and(IsUnitType(GetKillingUnit(),UNIT_TYPE_HERO))and(IsUnitEnemy(GetDyingUnit(),Player(-1+(bj_forLoopAIndex))))
endfunction
function Trig_jiashuxing_Func001Func003Func001Func001Func001C takes nothing returns boolean
return(Trig_jiashuxing_Func001Func003Func001Func001Func001Func007C())
endfunction
function Trig_jiashuxing_Func001Func003Func001Func001Func008C takes nothing returns boolean
return(200<udg_suijishu)and(204>=udg_suijishu)and(IsUnitType(GetKillingUnit(),UNIT_TYPE_HERO))and(IsUnitEnemy(GetDyingUnit(),Player(-1+(bj_forLoopAIndex))))
endfunction
function Trig_jiashuxing_Func001Func003Func001Func001C takes nothing returns boolean
return(Trig_jiashuxing_Func001Func003Func001Func001Func008C())
endfunction
function Trig_jiashuxing_Func001Func003Func001Func008C takes nothing returns boolean
return('d'<udg_suijishu)and('h'>=udg_suijishu)and(IsUnitType(GetKillingUnit(),UNIT_TYPE_HERO))and(IsUnitEnemy(GetDyingUnit(),Player(-1+(bj_forLoopAIndex))))
endfunction
function Trig_jiashuxing_Func001Func003Func001C takes nothing returns boolean
return(Trig_jiashuxing_Func001Func003Func001Func008C())
endfunction
function Trig_jiashuxing_Func001Func003Func008C takes nothing returns boolean
return(4>=udg_suijishu)and(IsUnitType(GetKillingUnit(),UNIT_TYPE_HERO))and(IsUnitEnemy(GetDyingUnit(),Player(-1+(bj_forLoopAIndex))))
endfunction
function Trig_jiashuxing_Func001Func003C takes nothing returns boolean
return(Trig_jiashuxing_Func001Func003Func008C())
endfunction
function Trig_jiashuxing_Actions takes nothing returns nothing
set bj_forLoopAIndex=1
set bj_forLoopAIndexEnd=6
loop
exitwhen bj_forLoopAIndex>bj_forLoopAIndexEnd
set udg_shuijishuxing=GetRandomInt(10,100) //这里10和100可以自己改
set udg_suijishu=GetRandomInt(1,400)  //这里400可以自己改
if(Trig_jiashuxing_Func001Func003C())then
set udg_jialiliang111=(R2I(SquareRoot(I2R(GetHeroLevel(GetKillingUnit()))))*R2I(SquareRoot(I2R(udg_shuijishuxing))))
call ModifyHeroStat(0,GetKillingUnit(),0,udg_jialiliang111)
call CreateTextTagUnitBJ(("+力量"+I2S(udg_jialiliang111)),GetKillingUnit(),0,15.,.0,'d','d',0)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,90.,GetRandomReal(0,360))
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
else
if(Trig_jiashuxing_Func001Func003Func001C())then
set udg_jiaminjie111=(R2I(SquareRoot(I2R(GetHeroLevel(GetKillingUnit()))))*R2I(SquareRoot(I2R(udg_shuijishuxing))))
call ModifyHeroStat(1,GetKillingUnit(),0,udg_jiaminjie111)
call CreateTextTagUnitBJ(("+敏捷"+I2S(udg_jiaminjie111)),GetKillingUnit(),0,15.,100.,.0,'d',0)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,90.,GetRandomReal(0,360))
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
else
if(Trig_jiashuxing_Func001Func003Func001Func001C())then
set udg_jiazhili111=(R2I(SquareRoot(I2R(GetHeroLevel(GetKillingUnit()))))*R2I(SquareRoot(I2R(udg_shuijishuxing))))
call ModifyHeroStat(2,GetKillingUnit(),0,udg_jiazhili111)
call CreateTextTagUnitBJ(("+智力"+I2S(udg_jiazhili111)),GetKillingUnit(),0,15.,100.,100.,.0,0)
call SetTextTagVelocityBJ(bj_lastCreatedTextTag,90.,GetRandomReal(0,360))
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,3.)
else
if(Trig_jiashuxing_Func001Func003Func001Func001Func001C())then
set udg_jiaqian=(10*udg_shuijishuxing*GetHeroLevel(GetKillingUnit())) //这里10可以自己改
call AdjustPlayerStateBJ(udg_jiaqian,GetOwningPlayer(GetKillingUnit()),PLAYER_STATE_RESOURCE_GOLD)
call CreateTextTagUnitBJ(("+金钱"+I2S(udg_jiaqian)),GetKillingUnit(),0,15.,100.,33.,88.,0)
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