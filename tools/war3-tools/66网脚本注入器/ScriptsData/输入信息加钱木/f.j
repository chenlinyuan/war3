function Trig_qqqq_Conditions takes nothing returns boolean
return(GetEventPlayerChatString()=="飞飞世界") //这里的飞飞世界可以自己改为自己想要的信息。
endfunction
function Trig_qqqq_Actions takes nothing returns nothing
call AdjustPlayerStateBJ(500000,GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD)
call AdjustPlayerStateBJ(500000,GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER)
endfunction