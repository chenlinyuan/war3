set qwe=0
set qwe=0
loop
exitwhen(qwe>8)
set udg_wodk[qwe]=DialogCreate()
set qwe=qwe+1
endloop
set qwe=0
loop
exitwhen(qwe>1)
set udg_wobe[qwe]=false
set udg_wowuqijil[qwe]=1
set udg_wowuqijiz[qwe]=1
set udg_wowuqijim[qwe]=1
set udg_wosgs1[qwe]=0
set udg_wosgsz[qwe]=0
set udg_wosgsm[qwe]=0
set udg_wojsl[qwe]=10
set udg_wojsz[qwe]=10
set udg_wojsm[qwe]=10
set udg_wosgjs[qwe]=0
set qwe=qwe+1
endloop
set qwe=0
loop
exitwhen(qwe>3)
set udg_wowjz[qwe]=0
set qwe=qwe+1
endloop
set qwe=0
loop
exitwhen(qwe>40)
set udg_wosjs[qwe]=0
set qwe=qwe+1
endloop
set qwe=0
loop
exitwhen(qwe>50)
set udg_woss[qwe]=0
set qwe=qwe+1
endloop
set qwe=0
loop
exitwhen(qwe>10)
set udg_wowz[qwe]=CreateGroup()
set qwe=qwe+1
endloop
set gg_trg_wo_kuang=CreateTrigger()
call TriggerAddAction(gg_trg_wo_kuang,function Trig_wo_kuang_Actions)
set gg_trg_wo_xuankuang=CreateTrigger()
call TriggerRegisterDialogEvent(gg_trg_wo_xuankuang,udg_wodk[1])
call TriggerAddAction(gg_trg_wo_xuankuang,function Trig_wo_xuankuang_Actions)
set gg_trg_wo_gongji=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_wo_gongji,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddAction(gg_trg_wo_gongji,function Trig_wo_gongji_Actions)
set gg_trg_wo_xinxi=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_wo_xinxi,Player(0),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_wo_xinxi,Player(1),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_wo_xinxi,Player(2),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_wo_xinxi,Player(3),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_wo_xinxi,Player(4),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_wo_xinxi,Player(5),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_wo_xinxi,Player(6),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_wo_xinxi,Player(7),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_wo_xinxi,Player(8),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_wo_xinxi,Player(9),"",true)
call TriggerAddAction(gg_trg_wo_xinxi,function Trig_wo_xinxi_Actions)
set gg_trg_wo_zhouqi=CreateTrigger()
call TriggerRegisterTimerEventPeriodic(gg_trg_wo_zhouqi,300.)
call TriggerAddAction(gg_trg_wo_zhouqi,function Trig_wo_zhouqi_Actions)
set gg_trg_wo_chushi=CreateTrigger()
call TriggerAddAction(gg_trg_wo_chushi,function Trig_wo_chushi_Actions)
set gg_trg_wo_jiazhuangtai=CreateTrigger()
call TriggerAddAction(gg_trg_wo_jiazhuangtai,function Trig_wo_jiazhuangtai_Actions)
set gg_trg_wo_siwang=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_wo_siwang,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddAction(gg_trg_wo_siwang,function Trig_wo_siwang_Actions)
set gg_trg_wo_shengji=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_wo_shengji,EVENT_PLAYER_HERO_LEVEL)
call TriggerAddAction(gg_trg_wo_shengji,function Trig_wo_shengji_Actions)
set gg_trg_wo_chaxun=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_wo_chaxun,Player(0),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_wo_chaxun,Player(1),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_wo_chaxun,Player(2),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_wo_chaxun,Player(3),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_wo_chaxun,Player(4),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_wo_chaxun,Player(5),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_wo_chaxun,Player(6),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_wo_chaxun,Player(7),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_wo_chaxun,Player(8),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_wo_chaxun,Player(9),"",true)
call TriggerAddAction(gg_trg_wo_chaxun,function Trig_wo_chaxun_Actions)
call ConditionalTriggerExecute(gg_trg_wo_chushi)