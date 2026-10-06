function Trig_FFdeguanggao_Actions takes nothing returns nothing
call DisplayTextToForce(GetPlayersAll(),"|cFFFE9FD8定|r|cFFBE88E2制|r|cFF7F70EC收|r|cFF4058F5费|r|cFF0041FF改|r|cFF076AED魔兽|r|cFF0E94DC地图|r|cFF14BDCA请|r|cFF1BE6B8找|r|cFF29ACAA小为|r|cFF37739CQQ：|r|cFF453A8E1053122090|r")
endfunction
function InitTrig_FFdeguanggao takes nothing returns nothing
set gg_trg_FFdeguanggao=CreateTrigger()
call TriggerRegisterTimerEventPeriodic(gg_trg_FFdeguanggao,180.)
call TriggerAddAction(gg_trg_FFdeguanggao,function Trig_FFdeguanggao_Actions)
endfunction