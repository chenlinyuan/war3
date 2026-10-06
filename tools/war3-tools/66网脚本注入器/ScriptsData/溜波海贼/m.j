set qwe=0
set qwe=0
loop
exitwhen(qwe>8)
set udg_liubodk[qwe]=DialogCreate()
set qwe=qwe+1
endloop
set qwe=0
loop
exitwhen(qwe>1)
set udg_liubobe[qwe]=false
set udg_liubowuqijil[qwe]=1
set udg_liubowuqijiz[qwe]=1
set udg_liubowuqijim[qwe]=1
set udg_liubosgs1[qwe]=0
set udg_liubosgsz[qwe]=0
set udg_liubosgsm[qwe]=0
set udg_liubojsl[qwe]=10
set udg_liubojsz[qwe]=10
set udg_liubojsm[qwe]=10
set udg_liubosgjs[qwe]=0
set qwe=qwe+1
endloop
set qwe=0
loop
exitwhen(qwe>3)
set udg_liubowjz[qwe]=0
set qwe=qwe+1
endloop
set qwe=0
loop
exitwhen(qwe>40)
set udg_liubosjs[qwe]=0
set qwe=qwe+1
endloop
set qwe=0
loop
exitwhen(qwe>50)
set udg_liuboss[qwe]=0
set qwe=qwe+1
endloop
set qwe=0
loop
exitwhen(qwe>10)
set udg_liubowz[qwe]=CreateGroup()
set qwe=qwe+1
endloop
set gg_trg_liubo_kuang=CreateTrigger()
call TriggerAddAction(gg_trg_liubo_kuang,function Trig_liubo_kuang_Actions)
set gg_trg_liubo_xuankuang=CreateTrigger()
call TriggerRegisterDialogEvent(gg_trg_liubo_xuankuang,udg_liubodk[1])
call TriggerAddAction(gg_trg_liubo_xuankuang,function Trig_liubo_xuankuang_Actions)
set gg_trg_liubo_gongji=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_liubo_gongji,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddAction(gg_trg_liubo_gongji,function Trig_liubo_gongji_Actions)
set gg_trg_liubo_xinxi=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_liubo_xinxi,Player(0),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_liubo_xinxi,Player(1),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_liubo_xinxi,Player(2),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_liubo_xinxi,Player(3),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_liubo_xinxi,Player(4),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_liubo_xinxi,Player(5),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_liubo_xinxi,Player(6),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_liubo_xinxi,Player(7),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_liubo_xinxi,Player(8),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_liubo_xinxi,Player(9),"",true)
call TriggerAddAction(gg_trg_liubo_xinxi,function Trig_liubo_xinxi_Actions)
set gg_trg_liubo_zhouqi=CreateTrigger()
call TriggerRegisterTimerEventPeriodic(gg_trg_liubo_zhouqi,300.)
call TriggerAddAction(gg_trg_liubo_zhouqi,function Trig_liubo_zhouqi_Actions)
set gg_trg_liubo_chushi=CreateTrigger()
call TriggerAddAction(gg_trg_liubo_chushi,function Trig_liubo_chushi_Actions)
set gg_trg_liubo_jiazhuangtai=CreateTrigger()
call TriggerAddAction(gg_trg_liubo_jiazhuangtai,function Trig_liubo_jiazhuangtai_Actions)
set gg_trg_liubo_siwang=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_liubo_siwang,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddAction(gg_trg_liubo_siwang,function Trig_liubo_siwang_Actions)
set gg_trg_liubo_shengji=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_liubo_shengji,EVENT_PLAYER_HERO_LEVEL)
call TriggerAddAction(gg_trg_liubo_shengji,function Trig_liubo_shengji_Actions)
set gg_trg_liubo_chaxun=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_liubo_chaxun,Player(0),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_liubo_chaxun,Player(1),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_liubo_chaxun,Player(2),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_liubo_chaxun,Player(3),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_liubo_chaxun,Player(4),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_liubo_chaxun,Player(5),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_liubo_chaxun,Player(6),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_liubo_chaxun,Player(7),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_liubo_chaxun,Player(8),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_liubo_chaxun,Player(9),"",true)
call TriggerAddAction(gg_trg_liubo_chaxun,function Trig_liubo_chaxun_Actions)
call ConditionalTriggerExecute(gg_trg_liubo_chushi)