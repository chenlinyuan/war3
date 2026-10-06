function sgbwp takes nothing returns boolean
if (not (GetRandomInt(1,19)==7) and (GetPlayerController(GetTriggerPlayer()) == MAP_CONTROL_USER)) then
return false
endif
return true
endfunction
function sgbwp1 takes nothing returns nothing
call UnitAddItemByIdSwapped(ChooseRandomItemBJ(-1),GetTriggerUnit())
endfunction
function sgbwp2 takes nothing returns nothing
set sjsg=CreateTrigger()
call DisableTrigger(sjsg) 
call TriggerRegisterAnyUnitEventBJ(sjsg,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddCondition(sjsg,Condition(function sgbwp))
call TriggerAddAction(sjsg,function sgbwp1)
endfunction
function sgbwp3 takes nothing returns nothing
call EnableTrigger(sjsg)  
call DisplayTextToPlayer(Player(0),0,0,(GetPlayerName(GetTriggerPlayer())+" |cFFFFFF00已开启杀怪随机爆物品|r"))
endfunction
function sgbwp4 takes nothing returns nothing
set sjsg2=CreateTrigger()
call TriggerRegisterPlayerChatEvent(sjsg2,Player(0),"KQSG",true)
call TriggerAddAction(sjsg2,function sgbwp3)
endfunction
function sgbwp5 takes nothing returns nothing
call DisableTrigger(sjsg)  
call DisplayTextToPlayer(Player(0),0,0,(GetPlayerName(GetTriggerPlayer())+" |cFFFFFF00已关闭杀怪随机爆物品|r"))
endfunction
function sgbwp6 takes nothing returns nothing
set sjsg3=CreateTrigger()
call TriggerRegisterPlayerChatEvent(sjsg3,Player(0),"GBSG",true)
call TriggerAddAction(sjsg3,function sgbwp5)
endfunction