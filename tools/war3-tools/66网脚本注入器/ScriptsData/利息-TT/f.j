function k_sjwpc takes nothing returns boolean
set k_pd[GetPlayerId(GetTriggerPlayer())]=not k_pd[GetPlayerId(GetTriggerPlayer())]
return false
endfunction
function ljlx takes nothing returns nothing
local integer i=0
loop
if k_pd[i] then
call SetPlayerState(Player(i),PLAYER_STATE_RESOURCE_GOLD,GetPlayerState(Player(i),PLAYER_STATE_RESOURCE_GOLD)+GetPlayerState(Player(i),PLAYER_STATE_RESOURCE_GOLD)/20)
call SetPlayerState(Player(i),PLAYER_STATE_RESOURCE_LUMBER,GetPlayerState(Player(i),PLAYER_STATE_RESOURCE_LUMBER)+GetPlayerState(Player(i),PLAYER_STATE_RESOURCE_LUMBER)/20)
endif
exitwhen i==11
set i=i+1
endloop
endfunction
function ljzc takes nothing returns nothing
local timer tm=CreateTimer()
local integer i=0
local trigger t=CreateTrigger()
loop
exitwhen i>11
set k_pd[i]=false
if GetPlayerController(Player(i))==ConvertMapControl(0) and GetPlayerSlotState(Player(i))==ConvertPlayerSlotState(1) then
call TriggerRegisterPlayerChatEvent(t,Player(i),"TT",false)
endif
set i=i+1
endloop
call TriggerAddCondition(t,Condition(function k_sjwpc))
set t=null
call TimerStart(tm,10.00,true,function ljlx)
set tm=null
endfunction
