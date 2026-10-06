function fy_dtjiaqian takes nothing returns nothing
local integer i=0
loop
exitwhen i>11
if(i>=6 or i==1)then
call SetPlayerState(Player(i),ConvertPlayerState(1),GetPlayerState(Player(i),ConvertPlayerState(1))+3)	
endif
set i=i+1
endloop	
endfunction
function FY_dtjiaqian takes nothing returns nothing
local timer tm=CreateTimer()
call TimerStart(tm,1,true,function fy_dtjiaqian)
endfunction