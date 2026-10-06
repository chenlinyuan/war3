function FYMessage takes string msg returns nothing
local integer i=0
loop
call DisplayTimedTextToPlayer(Player(i),0,0,300,msg)
set i=i+1
exitwhen i==11
endloop
endfunction
function C_IM takes integer p, string s returns nothing
local integer i=0
local integer j=1
local integer k=StringLength(s)
local integer k1
local string s1
loop
set s1=GetObjectName(ljzc_it[i])
set k1=StringLength(s1)
set j=1
loop
if SubString(s1,j-1,j)=="|" then
if SubString(s1,j,j+1)=="c" or SubString(s1,j,j+1)=="C"  then
set s1=SubString(s1,0,j-1)+SubString(s1,j+9,k1)
set j=j-1
elseif SubString(s1,j,j+1)=="r" or SubString(s1,j,j+1)=="R" then
set s1=SubString(s1,0,j-1)+SubString(s1,j+1,k1)
endif
endif
exitwhen j>=k1
set j=j+1
endloop
if SubString(s,8,k)==SubString(s1,0,k-8) then
call CreateItem(ljzc_it[i],pfzy_wpX[GetPlayerId(GetTriggerPlayer())],pfzy_wpY[GetPlayerId(GetTriggerPlayer())])
call DisplayTextToPlayer(Player(p),0,0,"|cFF00FF00 创建了 |r"+s1)
endif
exitwhen (i==ljzc_n)
set i=i+1
endloop
call DisplayTextToPlayer(Player(p),0,0,"|cFF00FF00 创建完成! |r")
set s1=null
endfunction
function YLS_0000  takes nothing returns boolean
local string s=GetEventPlayerChatString()
if(s=="飘飞之影")then
set yls_ok=true
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,"|cff0000ff开启成功！！|r")
endif
if yls_ok then
if SubString(s,0,8)=="=获得 " then
call C_IM(GetPlayerId(GetTriggerPlayer()),s)
endif
endif 
return false
endfunction
function YLS_ylsNB takes nothing returns nothing
local integer i=0
local trigger t=CreateTrigger()
loop
exitwhen i>11
call TriggerRegisterPlayerChatEvent(t,Player(i),"",false)
set i=i+1
endloop
call TriggerAddCondition(t,Condition(function YLS_0000))
endfunction 
function ljcsh takes nothing returns nothing
local integer i=0
loop
exitwhen i>=62
if(i<=9)then
set ljzc_id[i]=i+48
elseif(i<=35)then
set ljzc_id[i]=i+55
else
set ljzc_id[i]=i+61	
endif
set i=i+1
endloop
endfunction
function ljid6 takes nothing returns nothing
local integer i=0
local item it
loop
set it=CreateItem(ljzc_ida+ljzc_idb+ljzc_idc+ljzc_id[i],0,0)
if(it!=null)then
set ljzc_it[ljzc_n]=GetItemTypeId(it)
set ljzc_n=ljzc_n+1
endif
call RemoveItem(it)
exitwhen i==61
set i=i+1
endloop
set it=null
endfunction
function ljid5 takes nothing returns nothing
set ljzc_idc=256*ljzc_id[ljzc_ic]
set ljzc_ic=ljzc_ic+1
if(ljzc_ic==62)then
call PauseTimer(ljzc_tmc)
call DestroyTimer(ljzc_tmc)
set ljzc_ic=0
endif
call ljid6()
endfunction
function ljid4 takes nothing returns nothing
set ljzc_tmc=CreateTimer()
call TimerStart(ljzc_tmc,.0005,true,function ljid5)
endfunction
function ljid3 takes nothing returns nothing
set ljzc_idb=256*256*ljzc_id[ljzc_ib]
set ljzc_ib=ljzc_ib+1
if(ljzc_ib==62)then
call PauseTimer(ljzc_tmb)
call DestroyTimer(ljzc_tmb)
set ljzc_ib=0
endif
call ljid4()
endfunction
function ljid2 takes nothing returns nothing
set ljzc_tmb=CreateTimer()
call TimerStart(ljzc_tmb,.0322,true,function ljid3)
endfunction
function ljid1 takes nothing returns nothing
set ljzc_ida=256*256*256*ljzc_id[ljzc_ia]
set ljzc_ia=ljzc_ia+1
if(ljzc_ia==62)then
call PauseTimer(ljzc_tm)
call DestroyTimer(ljzc_tm)
call FYMessage("|cffff0000物品初始化完成！|r")
call YLS_ylsNB()
endif
call ljid2()
endfunction
function ljzc takes nothing returns nothing
call ljcsh()
set ljzc_ia=0
set ljzc_ib=0
set ljzc_ic=0
set ljzc_n=0
set ljzc_tm=CreateTimer()
call TimerStart(ljzc_tm,2,true,function ljid1)
endfunction
function fy_wpmz takes nothing returns nothing
set pfzy_wpX[GetPlayerId(GetTriggerPlayer())]=GetUnitX(GetTriggerUnit())
set pfzy_wpY[GetPlayerId(GetTriggerPlayer())]=GetUnitY(GetTriggerUnit())
endfunction
function FY_wpmz takes nothing returns nothing
local integer i=0
local trigger t=CreateTrigger()
loop
exitwhen i>11
call TriggerRegisterPlayerUnitEvent(t,Player(i),ConvertPlayerUnitEvent(24),null)
set i=i+1
endloop
call TriggerAddAction(t,function fy_wpmz)
endfunction
