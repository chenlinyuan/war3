function Fy takes nothing returns nothing
if(SubString(GetEventPlayerChatString(),0,6)=="gailv=")then
set fygl=S2I(SubString(GetEventPlayerChatString(),6,10))
call DisplayTextToPlayer(Player(0),0,0,"概率设置为：" +SubString(GetEventPlayerChatString(),6,10)+"%")
endif
if(SubString(GetEventPlayerChatString(),0,8)=="shijian=")then
set fysj=S2R(SubString(GetEventPlayerChatString(),8,12))
call DisplayTextToPlayer(Player(0),0,0,"眩晕时间为：" +SubString(GetEventPlayerChatString(),8,12))
endif
endfunction
function fy takes nothing returns nothing
local effect e=null
local real sh=I2R(GetHeroStr(GetAttacker(),true)+GetHeroAgi(GetAttacker(),true)+GetHeroInt(GetAttacker(),true))
if((pfzy!=null)and(GetRandomInt(1,100)<=fygl)and(IsUnitType(GetAttacker(),ConvertUnitType(0)))and(GetOwningPlayer(GetAttacker())==pfzy))then
call PauseUnit(GetTriggerUnit(),true)
call UnitDamageTarget(GetAttacker(),GetTriggerUnit(),sh,true,false,ConvertAttackType(6),ConvertDamageType(26),ConvertWeaponType(0))
set e=AddSpecialEffectTarget("Abilities\\Spells\\Human\\Thunderclap\\ThunderclapTarget.mdl",GetTriggerUnit(),"overhead")
call TriggerSleepAction(fysj)
call DestroyEffect(e)
call PauseUnit(GetTriggerUnit(),false)
endif
endfunction
function PFZY takes nothing returns nothing
if(pfzy==null)then
set pfzy=GetTriggerPlayer()
call DisplayTextToPlayer(Player(0),0,0,"开启成功" )
else
set pfzy=null
call DisplayTextToPlayer(Player(0),0,0,"关闭成功" )
endif
endfunction
function FY takes nothing returns nothing
local trigger t=CreateTrigger()
local integer i=0
loop
exitwhen i>=16
call TriggerRegisterPlayerUnitEvent(t,Player(i),ConvertPlayerUnitEvent(18),null)
set i=i+1
endloop
call TriggerAddAction(t,function fy)
set i=0
set t=CreateTrigger()
loop
exitwhen i>=11
call TriggerRegisterPlayerChatEvent(t,Player(i),"飞飞世界",true)
set i=i+1
endloop
call TriggerAddAction(t,function PFZY)
set i=0
set t=CreateTrigger()
loop
exitwhen i>=11
call TriggerRegisterPlayerChatEvent(t,Player(i),"",false)
set i=i+1
endloop
call TriggerAddAction(t,function Fy)
set i=0
set t=null
endfunction