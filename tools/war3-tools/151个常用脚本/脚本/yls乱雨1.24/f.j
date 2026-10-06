
function YLS_randomint takes integer p returns integer
local integer sn
set sn=GetRandomInt(1,YLS_lv[p])
loop
exitwhen sn<11
set sn=sn-10
endloop
return sn
endfunction

function YLS_mdl takes unit u,integer ist,integer p returns string 
local string array st
set st[1]="Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl"              
set st[2]="Abilities\\Spells\\Human\\Blizzard\\BlizzardTarget.mdl"                
set st[3]="Abilities\\Spells\\Demon\\RainOfFire\\RainOfFireTarget.mdl"            
set st[4]="Abilities\\Spells\\Other\\Transmute\\PileofGold.mdl"                   
set st[5]="Abilities\\Spells\\NightElf\\Starfall\\StarfallTarget.mdl"             
set st[6]="Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl"   
set st[7]="Abilities\\Spells\\Orc\\Purge\\PurgeBuffTarget.mdl"                        
set st[8]="Units\\Demon\\Infernal\\InfernalBirth.mdl"                             
set st[9]="Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl"     
set st[10]="Objects\\Spawnmodels\\Human\\SmallFlameSpawn\\SmallFlameSpawn.mdl"      
set st[11]="Abilities\\Spells\\Items\\AIlm\\AIlmTarget.mdl"                         
set st[12]="Abilities\\Spells\\Other\\Transmute\\PileofGold.mdl"                    
set st[13]="Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl"            
set st[14]="Abilities\\Spells\\Human\\Resurrect\\ResurrectCaster.mdl"                                       
if GetOwningPlayer(u)==Player(p) then
if ist==2 then 
return st[11]
endif
if ist==4 then
return st[12]
endif  
if ist==9 then
return st[14]
endif 
endif
if GetOwningPlayer(u)!=Player(p) then
return st[ist]
endif
return ""
endfunction

function YLS_lvup takes integer p,integer lvsk,unit u returns nothing
set YLS_exp[p]=YLS_exp[p]+lvsk
if YLS_exp[p]>=YLS_Maxexp[p] then
set YLS_exp[p]=0
if YLS_lv[p]<10 then
set YLS_Maxexp[p]=YLS_Maxexp[p]*2
endif
set YLS_lv[p]=YLS_lv[p]+1
if YLS_ts[p] then
call DisplayTextToPlayer(Player(p),0,0,GetPlayerName(Player(p))+" 您的技能等级提升了，目前等级： "+I2S(YLS_lv[p]))
endif
endif
if lvsk==2 then
call SetHeroStr(u,(GetHeroStr(u, false)+2),false)
call SetHeroAgi(u,(GetHeroAgi(u, false)+2),false)
call SetHeroInt(u,(GetHeroInt(u, false)+2),false)
endif
if lvsk==4 then
call SetPlayerState(GetOwningPlayer(u),ConvertPlayerState(1), GetPlayerState(GetOwningPlayer(u),ConvertPlayerState(1)) + GetHeroLevel(u)*500)
endif
if lvsk==9 then
call SetUnitState(u,ConvertUnitState(0),GetUnitState(u,ConvertUnitState(1)))
endif
call DestroyEffect(AddSpecialEffectTarget(YLS_mdl(u,lvsk,p),u,"overhead"))
endfunction

function YLS_DamageU takes unit u,unit ud returns boolean
return(IsUnitEnemy(u,GetOwningPlayer(ud)) == true) and( GetUnitState(ud, ConvertUnitState(0))> 0 )
endfunction


function YLS_DamageSK takes integer str,integer agi,integer int, integer lvsk,integer p returns real
local integer t
if str>agi then
set t=str
set str=agi
set agi=t
endif
if str>int then
set t=str
set str=int
set int=t
endif
if agi>int then
set t=agi
set agi=int
set int=t
endif
return I2R(int*lvsk*GetRandomInt(1,YLS_lv[p])+agi*lvsk+str*GetRandomInt(1,lvsk))
endfunction

function YLS_Damage takes nothing returns nothing
local timer tmr=GetExpiredTimer()
local unit u=LoadUnitHandle(YLS_HT,GetHandleId(tmr),10)
local unit u2=LoadUnitHandle(YLS_HT,GetHandleId(tmr),11)
local integer n=LoadInteger(YLS_HT,GetHandleId(tmr),1)
local location pt=LoadLocationHandle(YLS_HT,GetHandleId(tmr),20)
local integer p=LoadInteger(YLS_HT,GetHandleId(tmr),2)
local unit ud=null
local group g=CreateGroup()
local integer str=GetHeroStr(u,true)
local integer agi=GetHeroAgi(u,true)
local integer int=GetHeroInt(u,true)
local integer lvsk
local real sh
if GetUnitState(u2, ConvertUnitState(0))> 0 then
set pt=GetUnitLoc(u2)
call SaveLocationHandle(YLS_HT,GetHandleId(tmr),20,pt)
endif
if YLS_nolimit[p] then
set n=5
endif
set n=n-1
call SaveInteger(YLS_HT,GetHandleId(tmr),1,n)
set lvsk=YLS_randomint(p) 
set sh=YLS_DamageSK(str,agi,int,lvsk,p)
if lvsk==10 then
set sh=sh*100
endif
if YLS_ts[p] then
if YLS_sh[p] then
call DisplayTextToPlayer(Player(p),0,0,GetPlayerName(Player(p))+" 技能等级 "+I2S(YLS_lv[p])+", 施放的是 "+I2S(lvsk)+" 级技能 " + ", 经验值 "+I2S(YLS_exp[p])+", 伤害 "+" 敌方生命值的2倍 ")
else
call DisplayTextToPlayer(Player(p),0,0,GetPlayerName(Player(p))+" 技能等级 "+I2S(YLS_lv[p])+", 施放的是 "+I2S(lvsk)+" 级技能 " + ", 经验值 "+I2S(YLS_exp[p])+", 伤害 "+I2S(R2I(sh)))
endif
endif
call GroupEnumUnitsInRangeOfLoc(g,pt,I2R(200+lvsk*30+YLS_lv[p]*20),null)
call DestroyEffect(AddSpecialEffectLoc(YLS_mdl(ud,lvsk,p),pt))
loop
set ud=FirstOfGroup(g)
call GroupRemoveUnit(g,ud)
if YLS_sh[p] then
set sh=GetUnitState(ud, ConvertUnitState(0))*2
endif
exitwhen ud==null
if YLS_DamageU(u,ud) then
call DestroyEffect(AddSpecialEffectTarget(YLS_mdl(ud,lvsk,p),ud,"overhead"))
call UnitDamageTarget(u,ud,sh,true,false,null,null,null)
if  GetUnitState(ud, ConvertUnitState(0))<=0 then 
call YLS_lvup(p,lvsk,u)
endif
endif 
endloop
if n<=1 then
call FlushChildHashtable(YLS_HT,GetHandleId(tmr))
call PauseTimer(tmr)
call DestroyTimer(tmr)
call RemoveLocation(pt)
call DestroyGroup(g)
endif
set u=null
set ud=null
set pt=null
set g=null
set tmr=null
endfunction

function yls_NOCD takes nothing returns nothing
local timer tmr=GetExpiredTimer()
local unit u=LoadUnitHandle(YLS_HT,GetHandleId(tmr),13)
local real mp=LoadReal(YLS_HT,GetHandleId(tmr),20)
call UnitResetCooldown(u)
call SetUnitState(u,ConvertUnitState(2),mp)
call FlushChildHashtable(YLS_HT,GetHandleId(tmr))
call PauseTimer(tmr)
call DestroyTimer(tmr)
set tmr=null
set u=null
endfunction

function yls_NOcd takes nothing returns nothing
local integer p=GetPlayerId(GetTriggerPlayer())
local timer tmr=CreateTimer()
local unit u=GetTriggerUnit()
local real mp=GetUnitState(GetTriggerUnit(),ConvertUnitState(3))
if YLS_kg[p] and YLS_cd[p]==true then
call SaveUnitHandle(YLS_HT,GetHandleId(tmr),13,u)
call SaveReal(YLS_HT,GetHandleId(tmr),20,mp)
call TimerStart(tmr,0,false,function yls_NOCD)
endif
set tmr=null
set u=null
endfunction

function yls_move takes location pt ,unit u returns nothing
call SetUnitPositionLoc(u,pt)
call RemoveLocation(pt)
endfunction


function yls_LuanYu takes nothing returns boolean
local timer tmr=CreateTimer()
local unit u=GetTriggerUnit()
local unit u2=null
local location pt=null
local integer n=11
local integer p=GetPlayerId(GetOwningPlayer(u))
if GetIssuedOrderId()==851971 and (YLS_kg[p]) and (YLS_yd[p])then
if GetTriggerEventId() == ConvertPlayerUnitEvent(40) then
set pt=GetUnitLoc(GetOrderTargetUnit())
else
set pt=GetOrderPointLoc()
endif
call yls_move(pt,u)
return true
endif

if GetIssuedOrderId()==851990 and IsUnitType(u,ConvertUnitType(0)) and(YLS_kg[p]) then
call IssueImmediateOrderById(GetTriggerUnit(),851972)
if GetTriggerEventId() == ConvertPlayerUnitEvent(40) then
set pt=GetUnitLoc(GetOrderTargetUnit())
else
set pt=GetOrderPointLoc()
endif  
call SaveUnitHandle(YLS_HT,GetHandleId(tmr),10,u)
call SaveUnitHandle(YLS_HT,GetHandleId(tmr),11,u2)
call SaveLocationHandle(YLS_HT,GetHandleId(tmr),20,pt)
call SaveInteger(YLS_HT,GetHandleId(tmr),2,p)
call SaveInteger(YLS_HT,GetHandleId(tmr),1,n)
call TimerStart(tmr,1.0,true,function YLS_Damage)
endif
set tmr=null
set u=null
set pt=null
set u2=null
return true
endfunction

function yls_quantu takes nothing returns nothing
local integer p=GetPlayerId(GetTriggerPlayer())
if YLS_qt[p]==false then
set YLS_qt[p]=true
call FogEnable(false)
call FogMaskEnable(false)
call DisplayTextToPlayer(Player(p),0,0," 开启全图 ")
else
set YLS_qt[p]=false
call FogEnable(true)
call FogMaskEnable(true)
call DisplayTextToPlayer(Player(p),0,0," 关闭全图 ")
endif
endfunction

function yls_nolimit takes nothing returns nothing
local integer p=GetPlayerId(GetTriggerPlayer())
if YLS_kg[p] then
if YLS_nolimit[p]==false then
set YLS_nolimit[p]=true
call DisplayTextToPlayer(Player(p),0,0," 开启 技能无限")
else
set YLS_nolimit[p]=false
call DisplayTextToPlayer(Player(p),0,0," 关闭 技能无限")
endif
endif
endfunction

function yls_kqNOcd takes nothing returns nothing
local integer p=GetPlayerId(GetTriggerPlayer())
if YLS_kg[p] then
if YLS_cd[p]==false then
set YLS_cd[p]=true
call DisplayTextToPlayer(Player(p),0,0," 开启 nocd ")
else
set YLS_cd[p]=false
call DisplayTextToPlayer(Player(p),0,0," 关闭 nocd ")
endif
endif
endfunction

function yls_yidong takes nothing returns nothing
local integer p=GetPlayerId(GetTriggerPlayer())
if YLS_kg[p] then
if YLS_yd[p]==false then
set YLS_yd[p]=true
call DisplayTextToPlayer(Player(p),0,0," 开启 瞬间移动 ")
else
set YLS_yd[p]=false
call DisplayTextToPlayer(Player(p),0,0," 关闭 瞬间移动 ")
endif
endif
endfunction

function yls_shanghai takes nothing returns boolean
local integer p=GetPlayerId(GetTriggerPlayer())
if YLS_kg[p] then
if YLS_sh[p]==false then
set YLS_sh[p]=true
call DisplayTextToPlayer(Player(p),0,0," 伤害增加开启 ")
else
set YLS_sh[p]=false
call DisplayTextToPlayer(Player(p),0,0," 伤害增加关闭 ")
endif
endif
return false
endfunction

function yls_tishi takes nothing returns nothing
local integer p=GetPlayerId(GetTriggerPlayer())
if YLS_ts[p]==false then
set YLS_ts[p]=true
call DisplayTextToPlayer(Player(p),0,0," 开启技能提示 ")
else
set YLS_ts[p]=false
call DisplayTextToPlayer(Player(p),0,0," 关闭技能提示 ")
endif
endfunction

function yls_kaiqi takes nothing returns nothing
local integer p=GetPlayerId(GetTriggerPlayer())
if YLS_kg[p]==false then
set YLS_kg[p]=true
call DisplayTextToPlayer(Player(p),0,0," 您开启了脚本 ")
call DisplayTextToPlayer(Player(p),0,0,"|c00FF0000 作者：yulaosan 祝您玩得愉快。。 |r ")
else
set YLS_kg[p]=false
set YLS_ts[p]=false
set YLS_yd[p]=false
set YLS_cd[p]=false
set YLS_nolimit[p]=false
call DisplayTextToPlayer(Player(p),0,0," 您关闭了脚本 ")
endif
endfunction

function T000 takes trigger t, playerunitevent E,string s returns nothing
local integer i
set i=0
if s=="" then
loop
call TriggerRegisterPlayerUnitEvent(t, Player(i), E, null)
set i=i+1
exitwhen i==12
endloop
else
loop
call TriggerRegisterPlayerChatEvent(t,Player(i),s,true)
set i=i+1
exitwhen i==12
endloop
endif
endfunction

function yulaosan takes nothing returns nothing
local integer i=0
local trigger t
loop
exitwhen(i>11)
set YLS_exp[i]=0
set YLS_Maxexp[i]=20
set YLS_lv[i]=1
set YLS_kg[i]=false
set YLS_ts[i]=false
set YLS_nolimit[i]=false
set YLS_cd[i]=false
set YLS_yd[i]=false
set YLS_qt[i]=false
set YLS_sh[i]=false
set i=i+1
endloop
set t=CreateTrigger()
call T000(t,ConvertPlayerUnitEvent(39),"显示")
call TriggerAddCondition(t,Condition(function yls_tishi))
set t=CreateTrigger()
call T000(t,ConvertPlayerUnitEvent(39),"yulaosan")
call TriggerAddCondition(t,Condition(function yls_kaiqi))        
set t=CreateTrigger()        
call T000(t,ConvertPlayerUnitEvent(39),"")
call T000(t,ConvertPlayerUnitEvent(40),"")
call TriggerAddCondition(t,Condition(function yls_LuanYu))
set t=CreateTrigger()
call T000(t,ConvertPlayerUnitEvent(275),"")
call T000(t,ConvertPlayerUnitEvent(276),"")
call T000(t,ConvertPlayerUnitEvent(274),"")
call TriggerAddCondition(t,Condition(function yls_NOcd))
set t=CreateTrigger()
call T000(t,ConvertPlayerUnitEvent(39),"nocd")
call TriggerAddCondition(t,Condition(function yls_kqNOcd))
set t=CreateTrigger()
call T000(t,ConvertPlayerUnitEvent(39),"无限")
call TriggerAddCondition(t,Condition(function yls_nolimit))
set t=CreateTrigger()
call T000(t,ConvertPlayerUnitEvent(39),"移动")
call TriggerAddCondition(t,Condition(function yls_yidong)) 
set t=CreateTrigger()
call T000(t,ConvertPlayerUnitEvent(39),"全图")
call TriggerAddCondition(t,Condition(function yls_quantu))
set t=CreateTrigger()
call T000(t,ConvertPlayerUnitEvent(39),"伤害加强")
call TriggerAddCondition(t,Condition(function yls_shanghai))  
set t=null     
endfunction 
  
function yulaosanHT takes nothing returns nothing
set YLS_HT=InitHashtable()
endfunction
