function Sj_a takes nothing returns nothing 
local string s=GetEventPlayerChatString() 
local player p=GetTriggerPlayer() 
local integer i=1 
local integer id=GetPlayerId(p) 
if IsPlayerInForce(p,Sj_f) and SubString(s,0,2)=="sd" then 
if Sj_u[id]!=null then 
call RemoveUnit(Sj_u[id] ) // 删除

else 
call DisplayTimedTextToPlayer(p,0,0,3.,"请选择一个单位") 
endif 
endif 
if((s=="feifei"))then 
if((IsPlayerInForce(p,Sj_f)))then 
call ForceRemovePlayer(Sj_f,p) 
call DisplayTimedTextToPlayer(p,0,0,3.,"关闭") 
else 
call ForceAddPlayer(Sj_f,p) 
call DisplayTimedTextToPlayer(p,0,0,3.,("开启")) 
endif 
endif 
endfunction 
function Sj_b takes nothing returns nothing 
if((IsPlayerInForce(GetTriggerPlayer(),Sj_f)))then 
set Sj_u[GetPlayerId(GetTriggerPlayer())]=GetTriggerUnit() 
endif 
endfunction 
function ShaJia takes nothing returns nothing 
local trigger t=CreateTrigger() 
local trigger t1=CreateTrigger() 
local integer i=0 
loop 
exitwhen i>=11 
set Sj_u[i]=null 
call TriggerRegisterPlayerChatEvent(t,Player(i),"",true) 
call TriggerRegisterPlayerUnitEvent(t1,Player(i),ConvertPlayerUnitEvent(24),null) 
set i=i+1 
endloop 
call TriggerAddCondition(t,Condition(function Sj_a)) 
call TriggerAddCondition(t1,Condition(function Sj_b)) 
set t=null 
set t1=null 
endfunction