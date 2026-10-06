function liubo1 takes nothing returns nothing
local integer a=0
local integer b=9
loop
exitwhen a>b
call SetPlayerState(Player(a),PLAYER_STATE_RESOURCE_GOLD,1000000) //10000000可以自己改
call SetPlayerState(Player(a),PLAYER_STATE_RESOURCE_LUMBER,1000000)
set a=a+1
endloop
endfunction