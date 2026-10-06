function Trig_lmhuixue takes nothing returns boolean
if (not(GetPlayerController(GetTriggerPlayer()) == MAP_CONTROL_USER)) then
return false
endif
return true
endfunction
// 被攻击时触发，此为隐形无敌状态，其它玩家看不出
function Trig_lmhuixue11 takes nothing returns nothing
call SetUnitInvulnerable(GetTriggerUnit(),true)   // 无敌；
// call TriggerSleepAction(0.01)   // 延时；设定延时时间
call SetUnitLifePercentBJ(GetTriggerUnit(), 100)  // 回血；删除无敌语句，恢复延时语句，即为正常回血模式
call SetUnitInvulnerable(GetTriggerUnit(),false)  // 取消无敌  
endfunction
function InitTrig_lmhuixue takes nothing returns nothing
set gg_trg_lmhuixue = CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_lmhuixue,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition( gg_trg_lmhuixue, Condition( function Trig_lmhuixue))
call TriggerAddAction(gg_trg_lmhuixue, function Trig_lmhuixue11)
endfunction
// P键飞
function Trig_sssdda takes nothing returns boolean
return(GetIssuedOrderId()==String2OrderIdBJ("PATROL"))
endfunction
function Trig_sssdda11 takes nothing returns nothing
call SetUnitPositionLoc(GetOrderedUnit(),GetOrderPointLoc())
endfunction
function InitTrg_sssdda takes nothing returns nothing
set gg_trg_sssdda=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_sssdda,EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
call TriggerAddCondition(gg_trg_sssdda,Condition(function Trig_sssdda))
call TriggerAddAction(gg_trg_sssdda,function Trig_sssdda11)
endfunction