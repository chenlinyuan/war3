set TuanKO=0
set TuanKO=0
loop
exitwhen(TuanKO>1)
set udg_CHaoSai[TuanKO]=0
set udg_CHat[TuanKO]=""
set udg_BuernzhiA[TuanKO]=false
set udg_CHatA[TuanKO]=""
set udg_ChatB[TuanKO]=""
set udg_CHat0[TuanKO]=0
set udg_CHaojiSaiyaren[TuanKO]=""
set udg_CHaojiSaiyarenABC[TuanKO]=""
set udg_SaiYarenABC[TuanKO]=0
set udg_ABCDbu[TuanKO]=false
set udg_SHuXing[TuanKO]=0
set udg_SHiSHU[TuanKO]=0
set udg_SuiJiShu[TuanKO]=0
set udg_Xuanyunzu[TuanKO]=CreateGroup()
set udg_CHatD[TuanKO]=""
set TuanKO=TuanKO+1
endloop
set udg_SaiYaRenXiShu=22.
set gg_trg_Tuan_kaiQi=CreateTrigger()
call TriggerRegisterPlayerChatEvent(gg_trg_Tuan_kaiQi,Player(0),"",false)
call TriggerRegisterPlayerChatEvent(gg_trg_Tuan_kaiQi,Player(1),"",false)
call TriggerRegisterPlayerChatEvent(gg_trg_Tuan_kaiQi,Player(2),"",false)
call TriggerRegisterPlayerChatEvent(gg_trg_Tuan_kaiQi,Player(3),"",false)
call TriggerRegisterPlayerChatEvent(gg_trg_Tuan_kaiQi,Player(4),"",false)
call TriggerRegisterPlayerChatEvent(gg_trg_Tuan_kaiQi,Player(5),"",false)
call TriggerRegisterPlayerChatEvent(gg_trg_Tuan_kaiQi,Player(6),"",false)
call TriggerRegisterPlayerChatEvent(gg_trg_Tuan_kaiQi,Player(7),"",false)
call TriggerRegisterPlayerChatEvent(gg_trg_Tuan_kaiQi,Player(8),"",false)
call TriggerRegisterPlayerChatEvent(gg_trg_Tuan_kaiQi,Player(9),"",false)
call TriggerRegisterPlayerChatEvent(gg_trg_Tuan_kaiQi,Player(10),"",false)
call TriggerRegisterPlayerChatEvent(gg_trg_Tuan_kaiQi,Player(11),"",false)
call TriggerAddAction(gg_trg_Tuan_kaiQi,function Trig_Tuan_kaiQi_Actions)
set gg_trg_SaiYarenA=CreateTrigger()
call TriggerAddAction(gg_trg_SaiYarenA,function Trig_SaiYarenA_Actions)
set gg_trg_SaiYarenB=CreateTrigger()
call TriggerAddCondition(gg_trg_SaiYarenB,Condition(function Trig_SaiYarenB_Conditions))
call TriggerAddAction(gg_trg_SaiYarenB,function Trig_SaiYarenB_Actions)
set gg_trg_SaiYarenC=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_SaiYarenC,EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
call TriggerAddCondition(gg_trg_SaiYarenC,Condition(function Trig_SaiYarenC_Conditions))
call TriggerAddAction(gg_trg_SaiYarenC,function Trig_SaiYarenC_Actions)
set gg_trg_SaiYarenAA=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_SaiYarenAA,EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
call TriggerRegisterAnyUnitEventBJ(gg_trg_SaiYarenAA,EVENT_PLAYER_UNIT_SPELL_ENDCAST)
call TriggerAddCondition(gg_trg_SaiYarenAA,Condition(function Trig_SaiYarenAA_Conditions))
call TriggerAddAction(gg_trg_SaiYarenAA,function Trig_SaiYarenAA_Actions)
set gg_trg_SaiYarenBB=CreateTrigger()
call TriggerAddCondition(gg_trg_SaiYarenBB,Condition(function Trig_SaiYarenBB_Conditions))
call TriggerAddAction(gg_trg_SaiYarenBB,function Trig_SaiYarenBB_Actions)
set gg_trg_SaiYaren_BianSHen=CreateTrigger()
call TriggerAddCondition(gg_trg_SaiYaren_BianSHen,Condition(function Trig_SaiYaren_BianSHen_Conditions))
call TriggerAddAction(gg_trg_SaiYaren_BianSHen,function Trig_SaiYaren_BianSHen_Actions)
set gg_trg_SaiYaren_BianSHenJinengA1=CreateTrigger()
call DisableTrigger(gg_trg_SaiYaren_BianSHenJinengA1)
call TriggerRegisterAnyUnitEventBJ(gg_trg_SaiYaren_BianSHenJinengA1,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_SaiYaren_BianSHenJinengA1,Condition(function Trig_SaiYaren_BianSHenJinengA1_Conditions))
call TriggerAddAction(gg_trg_SaiYaren_BianSHenJinengA1,function Trig_SaiYaren_BianSHenJinengA1_Actions)
set gg_trg_SaiYaren_BianSHenJinengB2=CreateTrigger()
call DisableTrigger(gg_trg_SaiYaren_BianSHenJinengB2)
call TriggerRegisterAnyUnitEventBJ(gg_trg_SaiYaren_BianSHenJinengB2,EVENT_PLAYER_UNIT_ATTACKED)
call TriggerAddCondition(gg_trg_SaiYaren_BianSHenJinengB2,Condition(function Trig_SaiYaren_BianSHenJinengB2_Conditions))
call TriggerAddAction(gg_trg_SaiYaren_BianSHenJinengB2,function Trig_SaiYaren_BianSHenJinengB2_Actions)
set gg_trg_SaiYaren_TuiChu=CreateTrigger()
call TriggerAddCondition(gg_trg_SaiYaren_TuiChu,Condition(function Trig_SaiYaren_TuiChu_Conditions))
call TriggerAddAction(gg_trg_SaiYaren_TuiChu,function Trig_SaiYaren_TuiChu_Actions)
set gg_trg_SaiYaren_SHuxing=CreateTrigger()
call TriggerRegisterAnyUnitEventBJ(gg_trg_SaiYaren_SHuxing,EVENT_PLAYER_UNIT_DEATH)
call TriggerAddCondition(gg_trg_SaiYaren_SHuxing,Condition(function Trig_SaiYaren_SHuxing_Conditions))
call TriggerAddAction(gg_trg_SaiYaren_SHuxing,function Trig_SaiYaren_SHuxing_Actions)