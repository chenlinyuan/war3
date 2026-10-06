  //全屏P闪 有的地图不能按P的请把 patrol 改成 move 就是M闪
function qpfcf takes nothing returns boolean
return(panding==1)and(GetIssuedOrderId()==String2OrderIdBJ("patrol"))and(GetPlayerController(GetOwningPlayer(GetTriggerUnit()))==MAP_CONTROL_USER)
endfunction
function qpf takes nothing returns nothing
call SetUnitPositionLoc(GetTriggerUnit(),GetOrderPointLoc())
call RemoveLocation(GetOrderPointLoc())
endfunction

  //隐藏技能 
function jncf takes nothing returns boolean
return(panding==1)and(GetPlayerController(GetOwningPlayer(GetAttacker()))==MAP_CONTROL_USER)
endfunction
function jnpd takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))and(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function jnsh takes nothing returns nothing
local unit u=GetAttacker()
local real a=I2R(GetHeroStr(u,true))  //力量
local real b=I2R(GetHeroAgi(u,true))  //敏捷
local real c=I2R(GetHeroInt(u,true))  //智力
local real d=I2R(GetHeroLevel(u))  //等级
local real e=100
local real sh=SquareRoot(a+b+c)*e+d*e  //技能伤害
if(GetRandomInt(1,100)<=50)then  //技能概率
call UnitDamageTargetBJ(GetAttacker(),GetEnumUnit(),sh,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_UNIVERSAL)
endif
endfunction
function jnfw takes nothing returns nothing
local real fw=1000  //技能范围
call ForGroupBJ(GetUnitsInRangeOfLocMatching(fw,GetUnitLoc(GetTriggerUnit()),Condition(function jnpd)),function jnsh)
endfunction

  //杀怪加全属性 金钱 木头
function sxcf takes nothing returns boolean
return(panding==1)and(IsUnitType(GetKillingUnit(),UNIT_TYPE_HERO))and(GetPlayerController(GetOwningPlayer(GetKillingUnit()))==MAP_CONTROL_USER)
endfunction
function zjsx takes nothing returns nothing
local integer i
local integer a=1000  //金钱
local integer b=10  //木材
if(GetRandomInt(1,100)<=5)then  //概率
set i=GetRandomInt(1,10)  //增加属性值
call AdjustPlayerStateBJ(a,GetOwningPlayer(GetKillingUnit()),PLAYER_STATE_RESOURCE_GOLD)
call AdjustPlayerStateBJ(b,GetOwningPlayer(GetKillingUnit()),PLAYER_STATE_RESOURCE_LUMBER)
call ModifyHeroStat(0,GetKillingUnit(),0,i)
call ModifyHeroStat(1,GetKillingUnit(),0,i)
call ModifyHeroStat(2,GetKillingUnit(),0,i)
endif
endfunction

  //被攻击回血
function hfcf takes nothing returns boolean
return(panding==1)and(GetPlayerController(GetOwningPlayer(GetTriggerUnit()))==MAP_CONTROL_USER)
endfunction
function hfsm takes nothing returns nothing
if(GetRandomInt(1,100)<=10)then  //回血概率
call SetUnitLifePercentBJ(GetTriggerUnit(),100)  //回血百分比
endif
endfunction

  //脚本开关
function fzpd takes nothing returns nothing
if((GetEventPlayerChatString()=="+kq"))then  //开
set panding=1
call FogEnableOff()     // 禁用战争迷雾
call FogMaskEnableOff() // 禁用黑色阴影
endif
if((GetEventPlayerChatString()=="+gb"))then  //关
set panding=0
call FogMaskEnableOn()  // 启用黑色阴影
call FogEnableOn()      // 启用战争迷雾 
endif
endfunction


 //触发
function jurui takes nothing returns nothing
local trigger t=null
local integer i=0
set t=CreateTrigger()
loop
exitwhen(i>15)
call TriggerRegisterPlayerChatEvent(t,Player(i),"",true)
call TriggerAddAction(t,function fzpd)
set i=i+1
endloop
set t=null
set t=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(t,EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
call TriggerAddCondition(t,Condition(function qpfcf))
call TriggerAddAction(t,function qpf)
set t=null
set t=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(t,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(t,Condition(function jncf))
call TriggerAddAction(t,function jnfw)
set t=null
set t=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(t,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddCondition(t,Condition(function sxcf))
call TriggerAddAction(t,function zjsx)
set t=null
set t=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(t,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(t,Condition(function hfcf))
call TriggerAddAction(t,function hfsm)
set t=null
endfunction