function Trig_lfhuiyuanaijingyanlv_Func001002 takes nothing returns nothing
call SetPlayerHandicapXP(GetEnumPlayer(),S2R(SubStringBJ(GetEventPlayerChatString(),8,'d')))
endfunction
function Trig_lfhuiyuanaijingyanlv_Actions takes nothing returns nothing
call ForForce(GetPlayersAllies(GetTriggerPlayer()),function Trig_lfhuiyuanaijingyanlv_Func001002)
call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,5.,(("|cFF00FF00你们目前的经验获得率为"+SubStringBJ(GetEventPlayerChatString(),8,'d'))+"倍"))
endfunction