function Fy takes nothing returns nothing
local real sh=I2R((GetHeroLevel(GetAttacker())*((GetHeroStr(GetAttacker(),true)+GetHeroAgi(GetAttacker(),true))+GetHeroInt(GetAttacker(),true))))
call UnitDamageTarget(GetAttacker(),GetEnumUnit(),sh,true,false,ConvertAttackType(6),ConvertDamageType(26),ConvertWeaponType(0))
call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Demon\\RainOfFire\\RainOfFireTarget.mdl",GetEnumUnit(),"overhead"))
endfunction
function fY takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),pfzy))
endfunction
function fy takes nothing returns nothing
local boolexpr be=Condition(function fY)
local group g=CreateGroup()
if((pfzy!=null)and(GetRandomInt(1,10)==1)and(IsUnitType(GetAttacker(),ConvertUnitType(0)))and(GetOwningPlayer(GetAttacker())==pfzy))then
call GroupEnumUnitsInRangeOfLoc(g,GetUnitLoc(GetTriggerUnit()),500,be)
call ForGroup(g,function Fy)
call DestroyGroup(g)
call DestroyBoolExpr(be)
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
set t=null
endfunction
