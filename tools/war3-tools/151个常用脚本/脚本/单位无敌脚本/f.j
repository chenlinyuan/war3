function FY takes nothing returns nothing
set fY=GetTriggerPlayer()
call DisableTrigger(GetTriggeringTrigger())
endfunction
function fy takes nothing returns nothing
if GetTriggerPlayer()==fY then
set Fy=GetTriggerUnit()
endif
endfunction
function pfzy0 takes nothing returns nothing
if GetTriggerPlayer()==fY then
call SetUnitInvulnerable(Fy,true)
call TriggerSleepAction(WDtime)
call SetUnitInvulnerable(Fy,false)
endif
endfunction
function pfzy1 takes nothing returns nothing
if GetTriggerPlayer()==fY then
call SetUnitInvulnerable(Fy,true)
endif
endfunction
function pfzy2 takes nothing returns nothing
if GetTriggerPlayer()==fY then
call SetUnitInvulnerable(Fy,false)
endif
endfunction
function Pfzy takes nothing returns nothing
if (GetTriggerPlayer()==fY)and(SubString(GetEventPlayerChatString(),0,7)=="-settm ")and(S2I(SubString(GetEventPlayerChatString(),7,10))>=0) then
set WDtime=S2I(SubString(GetEventPlayerChatString(),7,10))
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,"当前无敌时间设置为：|cFFFF0000"+I2S(WDtime)+"|r秒")
endif
endfunction
function PFJZ takes nothing returns nothing
local trigger t=null
local integer i=0
local player p=null
loop
exitwhen i>=11
set p=Player(i)
set t=CreateTrigger()
call TriggerRegisterPlayerChatEvent(t,p,"飘飞之影",true)
call TriggerAddAction(t,function FY)
set t=CreateTrigger()
call TriggerRegisterPlayerUnitEvent(t,p,ConvertPlayerUnitEvent(24),null)
call TriggerAddAction(t,function fy)
set t=CreateTrigger()
call TriggerRegisterPlayerEvent(t,p,ConvertPlayerEvent(267)) 
call TriggerAddAction(t,function pfzy0)
set t=CreateTrigger()
call TriggerRegisterPlayerEvent(t,p,ConvertPlayerEvent(261)) 
call TriggerAddAction(t,function pfzy1)
set t=CreateTrigger()
call TriggerRegisterPlayerEvent(t,p,ConvertPlayerEvent(263)) 
call TriggerAddAction(t,function pfzy2)
set t=CreateTrigger()
call TriggerRegisterPlayerChatEvent(t,p,"-set",false)
call TriggerAddAction(t,function Pfzy)
set i=i+1
endloop
set t=null
endfunction
