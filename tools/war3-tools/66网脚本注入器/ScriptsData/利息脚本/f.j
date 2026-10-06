function ljlx takes nothing returns nothing
local integer i=0
loop
call SetPlayerState(Player(i),PLAYER_STATE_RESOURCE_GOLD,GetPlayerState(Player(i),PLAYER_STATE_RESOURCE_GOLD)+GetPlayerState(Player(i),PLAYER_STATE_RESOURCE_GOLD)/20)
call SetPlayerState(Player(i),PLAYER_STATE_RESOURCE_LUMBER,GetPlayerState(Player(i),PLAYER_STATE_RESOURCE_LUMBER)+GetPlayerState(Player(i),PLAYER_STATE_RESOURCE_LUMBER)/20)
exitwhen i==11
set i=i+1
endloop
endfunction
function ljzc takes nothing returns nothing
local timer tm=CreateTimer()
call TimerStart(tm,10.00,true,function ljlx)
set tm=null
endfunction
