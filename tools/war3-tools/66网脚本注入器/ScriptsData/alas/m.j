set t = CreateTrigger()
call TriggerRegisterTimerEvent(t, 10.00, false)
call TriggerAddAction(t,function MyMap_Test10sActions)