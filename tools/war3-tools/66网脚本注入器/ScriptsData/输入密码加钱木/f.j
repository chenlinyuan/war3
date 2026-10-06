function Trig_qqqq_Conditions takes nothing returns boolean
return(GetEventPlayerChatString()=="hellour") // 这里的hellour可改为自己想要的密码 
endfunction
function Trig_qqqq_Actions takes nothing returns nothing
call AdjustPlayerStateBJ(500000,GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD)   // 这里改金币数量
call AdjustPlayerStateBJ(500000,GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER) // 这里改木材数量
// call AdjustPlayerStateBJ(100,GetTriggerPlayer(),PLAYER_STATE_RESOURCE_FOOD_USED) // 人口，一般注释掉
endfunction