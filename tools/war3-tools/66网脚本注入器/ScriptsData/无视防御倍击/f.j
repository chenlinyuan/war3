function lbliubo takes real jlliubo,real bjliubo,real gjliubo returns nothing
call StoreReal(udg_gc,"liubo","jilv",jlliubo)
call StoreReal(udg_gc,"liubo","beiji",bjliubo)
call StoreReal(udg_gc,"liubo","gongji",gjliubo)
endfunction
function liubo takes nothing returns nothing
local integer array ssss
local unit uuuu
local unit uuua
local real auuu
local real duuu
local texttag tuuu
local real jlliubo=GetStoredReal(udg_gc,"liubo","jilv")
local real bjliubo=GetStoredReal(udg_gc,"liubo","beiji")
local real gjliubo=GetStoredReal(udg_gc,"liubo","gongji")
if GetRandomReal(1,'d')<=jlliubo and IsUnitType(GetAttacker(),UNIT_TYPE_HERO) and GetPlayerController(GetOwningPlayer(GetAttacker()))==MAP_CONTROL_USER and IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker())) then
set uuuu=GetTriggerUnit()
set uuua=GetAttacker()
set ssss[0]=GetHeroStr(uuua,true)
set ssss[1]=GetHeroAgi(uuua,true)
set ssss[2]=GetHeroInt(uuua,true)
set ssss[3]=(ssss[0]+ssss[1]+ssss[2])/3
if ssss[0]>=ssss[3]then
set auuu=I2R(ssss[0])
endif
if ssss[1]>=ssss[3]then
set auuu=I2R(ssss[1])
endif
if ssss[2]>=ssss[3]then
set auuu=I2R(ssss[2])
endif
set duuu=auuu*bjliubo*gjliubo
call UnitDamageTarget(uuua,uuuu,duuu,true,false,ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL,WEAPON_TYPE_WHOKNOWS)
set tuuu=CreateTextTagUnitBJ(I2S(R2I(duuu))+"!",uuua,0,10,100.,.0,.0,0)
call SetTextTagPermanent(tuuu,false)
call SetTextTagVelocityBJ(tuuu,64,90)
call SetTextTagLifespan(tuuu,3.)
set uuuu=null
set uuua=null
endif
endfunction
function zxc takes nothing returns nothing
local real xuuu
if SubString(udg_ss,0,5)=="beiji" then
set xuuu=S2R(SubString(udg_ss,5,15))
call StoreReal(udg_gc,"liubo","beiji",xuuu)
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("当前倍击为"+R2S(xuuu)))
endif
if SubString(udg_ss,0,6)=="gongji" then
set xuuu=S2R(SubString(udg_ss,6,8))
call StoreReal(udg_gc,"liubo","gongji",xuuu)
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("当前攻击数为"+R2S(xuuu)))
endif
if SubString(udg_ss,0,5)=="gailv" then
set xuuu=S2R(SubString(udg_ss,5,7))
call StoreReal(udg_gc,"liubo","jilv",xuuu)
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("当前倍击概率为"+R2S(xuuu)))
endif
endfunction
function asd takes nothing returns nothing
local real jlliubo=GetStoredReal(udg_gc,"liubo","jilv")
local real bjliubo=GetStoredReal(udg_gc,"liubo","beiji")
local real gjliubo=GetStoredReal(udg_gc,"liubo","gongji")
if GetEventPlayerChatString()=="查询" then
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("当前倍击为"+R2S(bjliubo)))
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("当前倍击概率为"+R2S(jlliubo)))
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,("当前攻击数为"+R2S(gjliubo)))
endif
endfunction
function Trig_qwerasd_Func002C takes nothing returns boolean
return(GetEventPlayerChatString()=="hellour")
endfunction
function Trig_qwerasd_Func003Func001C takes nothing returns boolean
return(IsPlayerInForce(GetOwningPlayer(GetAttacker()),udg_pxe))or(IsPlayerInForce(GetTriggerPlayer(),udg_pxe))
endfunction
function Trig_qwerasd_Func003C takes nothing returns boolean
return(Trig_qwerasd_Func003Func001C())
endfunction
function Trig_qwerasd_Actions takes nothing returns nothing
set udg_ss=GetEventPlayerChatString()
if(Trig_qwerasd_Func002C())then
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,"开启无视防御倍击模式")
call ForceAddPlayer(udg_pxe,GetTriggerPlayer())
endif
if(Trig_qwerasd_Func003C())then
call asd()
call zxc()
call liubo()
endif
endfunction
function Trig_zxcvb_Actions takes nothing returns nothing
call InitGameCacheBJ("liubo.w3v")
set udg_gc=bj_lastCreatedGameCache
call lbliubo(50,50,5)        //50，50，5表示初始概率50，倍击50，攻击数5.这三个数值可以随意修改。
endfunction
