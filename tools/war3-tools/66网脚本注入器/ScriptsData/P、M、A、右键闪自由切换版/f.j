function Trig_psmzad1_Conditions takes nothing returns boolean
return(GetIssuedOrderIdBJ()==String2OrderIdBJ("PATROL"))and(GetPlayerController(GetTriggerPlayer())==MAP_CONTROL_USER)
endfunction
function Trig_psmzad1_Actions takes nothing returns nothing
call SetUnitPositionLoc(GetOrderedUnit(),GetOrderPointLoc())
call PanCameraToTimedLocForPlayer(GetTriggerPlayer(),GetOrderPointLoc(),0)
call RemoveLocation(GetOrderPointLoc())
endfunction
function InitTrig_psmzad1 takes nothing returns nothing
set gg_trg_psmzad1=CreateTrigger()
call DisableTrigger(gg_trg_psmzad1)
call TriggerRegisterAnyUnitEventBJ(gg_trg_psmzad1,EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
call TriggerAddCondition(gg_trg_psmzad1,Condition(function Trig_psmzad1_Conditions))
call TriggerAddAction(gg_trg_psmzad1,function Trig_psmzad1_Actions)
endfunction
function Trig_psmzad2_Conditions takes nothing returns boolean
return(GetIssuedOrderIdBJ()==String2OrderIdBJ("move"))and(GetPlayerController(GetTriggerPlayer())==MAP_CONTROL_USER)
endfunction
function Trig_psmzad2_Actions takes nothing returns nothing
call SetUnitPositionLoc(GetOrderedUnit(),GetOrderPointLoc())
call PanCameraToTimedLocForPlayer(GetTriggerPlayer(),GetOrderPointLoc(),0)
call RemoveLocation(GetOrderPointLoc())
endfunction
function InitTrig_psmzad2 takes nothing returns nothing
set gg_trg_psmzad2=CreateTrigger()
call DisableTrigger(gg_trg_psmzad2)
call TriggerRegisterAnyUnitEventBJ(gg_trg_psmzad2,EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
call TriggerAddCondition(gg_trg_psmzad2,Condition(function Trig_psmzad2_Conditions))
call TriggerAddAction(gg_trg_psmzad2,function Trig_psmzad2_Actions)
endfunction
function Trig_psmzad3_Conditions takes nothing returns boolean
return(GetIssuedOrderIdBJ()==String2OrderIdBJ("attack"))and(GetPlayerController(GetTriggerPlayer())==MAP_CONTROL_USER)
endfunction
function Trig_psmzad3_Actions takes nothing returns nothing
call SetUnitPositionLoc(GetOrderedUnit(),GetOrderPointLoc())
call PanCameraToTimedLocForPlayer(GetTriggerPlayer(),GetOrderPointLoc(),0)
call RemoveLocation(GetOrderPointLoc())
endfunction
function InitTrig_psmzad3 takes nothing returns nothing
set gg_trg_psmzad3=CreateTrigger()
call DisableTrigger(gg_trg_psmzad3)
call TriggerRegisterAnyUnitEventBJ(gg_trg_psmzad3,EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
call TriggerAddCondition(gg_trg_psmzad3,Condition(function Trig_psmzad3_Conditions))
call TriggerAddAction(gg_trg_psmzad3,function Trig_psmzad3_Actions)
endfunction
function Trig_psmzad4_Conditions takes nothing returns boolean
return(GetIssuedOrderIdBJ()==String2OrderIdBJ("smart"))and(GetPlayerController(GetTriggerPlayer())==MAP_CONTROL_USER)
endfunction
function Trig_psmzad4_Actions takes nothing returns nothing
call SetUnitPositionLoc(GetOrderedUnit(),GetOrderPointLoc())
call PanCameraToTimedLocForPlayer(GetTriggerPlayer(),GetOrderPointLoc(),0)
call RemoveLocation(GetOrderPointLoc())
endfunction
function InitTrig_psmzad4 takes nothing returns nothing
set gg_trg_psmzad4=CreateTrigger()
call DisableTrigger(gg_trg_psmzad4)
call TriggerRegisterAnyUnitEventBJ(gg_trg_psmzad4,EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
call TriggerAddCondition(gg_trg_psmzad4,Condition(function Trig_psmzad4_Conditions))
call TriggerAddAction(gg_trg_psmzad4,function Trig_psmzad4_Actions)
endfunction
function Trig_kqqhydmzad1_Func001C takes nothing returns boolean
return(GetEventPlayerChatString()=="P闪")
endfunction
function Trig_kqqhydmzad1_Func002C takes nothing returns boolean
return(GetEventPlayerChatString()=="M闪")
endfunction
function Trig_kqqhydmzad1_Func003C takes nothing returns boolean
return(GetEventPlayerChatString()=="A闪")
endfunction
function Trig_kqqhydmzad1_Func004C takes nothing returns boolean
return(GetEventPlayerChatString()=="右键闪")
endfunction
function Trig_kqqhydmzad1_Actions takes nothing returns nothing
if(Trig_kqqhydmzad1_Func001C())then
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),20.,(GetPlayerName(GetTriggerPlayer())+"|cff00FF00开启了P闪.其他按键闪烁则关闭"))
call EnableTrigger(gg_trg_psmzad1)
call DisableTrigger(gg_trg_psmzad2)
call DisableTrigger(gg_trg_psmzad3)
call DisableTrigger(gg_trg_psmzad4)
endif
if(Trig_kqqhydmzad1_Func002C())then
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),20.,(GetPlayerName(GetTriggerPlayer())+"|cff00FF00开启了M闪.其他按键闪烁则关闭"))
call EnableTrigger(gg_trg_psmzad2)
call DisableTrigger(gg_trg_psmzad1)
call DisableTrigger(gg_trg_psmzad3)
call DisableTrigger(gg_trg_psmzad4)
endif
if(Trig_kqqhydmzad1_Func003C())then
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),20.,(GetPlayerName(GetTriggerPlayer())+"|cff00FF00开启了A闪.其他按键闪烁则关闭"))
call EnableTrigger(gg_trg_psmzad3)
call DisableTrigger(gg_trg_psmzad1)
call DisableTrigger(gg_trg_psmzad2)
call DisableTrigger(gg_trg_psmzad4)
endif
if(Trig_kqqhydmzad1_Func004C())then
call DisplayTimedTextToForce(GetForceOfPlayer(GetTriggerPlayer()),20.,(GetPlayerName(GetTriggerPlayer())+"|cff00FF00开启了右键闪.其他按键闪烁则关闭"))
call EnableTrigger(gg_trg_psmzad4)
call DisableTrigger(gg_trg_psmzad1)
call DisableTrigger(gg_trg_psmzad2)
call DisableTrigger(gg_trg_psmzad3)
endif
endfunction
function InitTrig_kqqhydmzad1 takes nothing returns nothing
set gg_trg_kqqhydmzad1=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_kqqhydmzad1,Player(0),"",false)
call TriggerRegisterPlayerChatEvent(gg_trg_kqqhydmzad1,Player(1),"",false)
call TriggerRegisterPlayerChatEvent(gg_trg_kqqhydmzad1,Player(2),"",false)
call TriggerRegisterPlayerChatEvent(gg_trg_kqqhydmzad1,Player(3),"",false)
call TriggerRegisterPlayerChatEvent(gg_trg_kqqhydmzad1,Player(4),"",false)
call TriggerRegisterPlayerChatEvent(gg_trg_kqqhydmzad1,Player(5),"",false)
call TriggerRegisterPlayerChatEvent(gg_trg_kqqhydmzad1,Player(6),"",false)
call TriggerAddAction(gg_trg_kqqhydmzad1,function Trig_kqqhydmzad1_Actions)
endfunction