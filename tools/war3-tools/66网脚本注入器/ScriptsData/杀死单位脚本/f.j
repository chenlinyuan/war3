function hbzy_a takes nothing returns nothing 
local string s=GetEventPlayerChatString() 
local player p=GetTriggerPlayer() 
local integer i=1 
local integer id=GetPlayerId(p) 
if IsPlayerInForce(p,hbzy_f) and SubString(s,0,2)=="ss" then 
if hbzy_u[id]!=null then 
call KillUnit(hbzy_u[id] ) // 杀死

else 
call DisplayTimedTextToPlayer(p,0,0,3.,"请选择一个单位") 
endif 
endif 
if((s=="SSDWEI"))then 
if((IsPlayerInForce(p,hbzy_f)))then 
call ForceRemovePlayer(hbzy_f,p) 
call DisplayTimedTextToPlayer(p,0,0,3.,"关闭") 
else 
call ForceAddPlayer(hbzy_f,p) 
call DisplayTimedTextToPlayer(p,0,0,3.,("开启")) 
endif 
endif 
endfunction 
function hbzy_b takes nothing returns nothing 
if((IsPlayerInForce(GetTriggerPlayer(),hbzy_f)))then 
set hbzy_u[GetPlayerId(GetTriggerPlayer())]=GetTriggerUnit() 
endif 
endfunction 
function hbzy_ss takes nothing returns nothing 
local trigger t=CreateTrigger() 
local trigger t1=CreateTrigger() 
local integer i=0 
loop 
exitwhen i>=11 
set hbzy_u[i]=null 
call TriggerRegisterPlayerChatEvent(t,Player(i),"",true) 
call TriggerRegisterPlayerUnitEvent(t1,Player(i),ConvertPlayerUnitEvent(24),null) 
set i=i+1 
endloop 
call TriggerAddCondition(t,Condition(function hbzy_a)) 
call TriggerAddCondition(t1,Condition(function hbzy_b)) 
set t=null 
set t1=null 
endfunction