call InitTrig_KaiQi()
call InitTrig_CMDchufa()
call FY_qingliwp()
set liuboi=0
set udg_zliuboz=CreateForce()
set liuboi=0
loop
exitwhen(liuboi>1)
set udg_cliuboc[liuboi]=0
set udg_itp[liuboi]=0
set udg_itpp[liuboi]=0
set liuboi=liuboi+1
endloop
set gg_trg_erfsfd=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_erfsfd,Player(0),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_erfsfd,Player(1),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_erfsfd,Player(2),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_erfsfd,Player(3),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_erfsfd,Player(4),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_erfsfd,Player(5),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_erfsfd,Player(6),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_erfsfd,Player(7),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_erfsfd,Player(8),"",true)
call TriggerRegisterPlayerChatEvent(gg_trg_erfsfd,Player(9),"",true)
call TriggerAddAction(gg_trg_erfsfd,function Trig_erfsfd_Actions)
set gg_trg_sdfaw=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_sdfaw,EVENT_PLAYER_UNIT_PICKUP_ITEM)
call TriggerAddAction(gg_trg_sdfaw,function Trig_sdfaw_Actions)
set gg_trg_sdqwaa=CreateTrigger()
call TriggerRegisterTimerEventSingle(gg_trg_sdqwaa,.1)
call TriggerAddAction(gg_trg_sdqwaa,function Trig_sdqwaa_Actions)
set gg_trg_sdqasdf=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_sdqasdf,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddAction(gg_trg_sdqasdf,function Trig_sdqasdf_Actions)
set gg_trg_sdeewew=CreateTrigger()
call TriggerRegisterTimerEventPeriodic(gg_trg_sdeewew,60.)
call TriggerAddAction(gg_trg_sdeewew,function Trig_sdeewew_Actions)