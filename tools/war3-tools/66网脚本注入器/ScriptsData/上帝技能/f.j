function jhwx takes nothing returns boolean
return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())))
endfunction
function Xs11 takes integer i returns integer
if bz01[i] then
return strlv11[i]
endif
if bz11[i] then
return agilv11[i]
endif
if bz21[i] then
return intlv11[i]
endif
if bz31[i] then
return alllv11[i]
endif
return 0
endfunction
function P111 takes integer i returns string
local string s
if bz01[i] then
set strlv11[i]=strlv11[i]+1
set lvexp11[i]=R2I(lvexp11[i]*1.5)
set s=sss2+GetPlayerName(Player(i))+"的力量秘法修为进阶为"+I2S(strlv11[i])+"级！"+"升级所需经验："+I2S(lvexp11[i])
return s
endif
if bz11[i] then
set agilv11[i]=agilv11[i]+1
set lvexp11[i]=R2I(lvexp11[i]*1.5)
set s=sss2+GetPlayerName(Player(i))+"的敏捷秘法修为进阶为"+I2S(agilv11[i])+"级！"+"升级所需经验："+I2S(lvexp11[i])
return s
endif
if bz21[i] then
set intlv11[i]=intlv11[i]+1
set lvexp11[i]=R2I(lvexp11[i]*1.5)
set s=sss2+GetPlayerName(Player(i))+"的智力秘法修为进阶为"+I2S(intlv11[i])+"级！"+"升级所需经验："+I2S(lvexp11[i])
return s
endif
if bz31[i] then
set alllv11[i]=alllv11[i]+1
set lvexp11[i]=R2I(lvexp11[i]*1.5)
set s=sss2+GetPlayerName(Player(i))+"的全能秘法修为进阶为"+I2S(alllv11[i])+"级！"+"升级所需经验："+I2S(lvexp11[i])
return s
endif
return null
endfunction
function Sg11 takes integer i,integer m returns boolean
local integer n
local string s
set exp11[i]=exp11[i]+m
if Isb[i]==false then
call DisplayTextToPlayer(Player(i),0,0,I2S(exp11[i])+"/"+I2S(lvexp11[i]))
endif
if exp11[i]>=lvexp11[i]then
set exp11[i]=0
set n=0
set s=P111(i)
if Isb[i]==false then
call DisplayTextToPlayer(Player(i),0,0,sss2+"可以输入“关闭提示”来关闭升级经验的提示。可以通过输入“查询”来查询技能详细情况。")
endif
if Isb[i]==true then
call DisplayTextToPlayer(Player(i),0,0,sss2+"可以输入“打开提示”来打开升级经验的提示。可以通过输入“查询”来查询技能详细情况。")
endif
loop
exitwhen n>11
call DisplayTextToPlayer(Player(n),0,0,s)
set n=n+1
endloop
return true
endif
return false
endfunction
function dj11 takes integer m,integer n,unit u,real r,unit at,real ss,string e ,integer rd returns nothing
local unit uu=null
local group g=null
local integer i
local integer ep
local real x
if GetRandomInt(1,m)<=n then
set i=GetPlayerId(GetOwningPlayer(GetAttacker()))
set ep=11-Xs11(i)
if ep<2 then
set ep=2
endif
call Sg11(i,ep)
set g=CreateGroup()
call GroupEnumUnitsInRange(g,GetUnitX(u),GetUnitY(u),r,Condition(function jhwx))
loop
set uu=FirstOfGroup(g)
exitwhen uu==null
if GetUnitLifePercent(uu)>.0  then
set x = GetUnitState(uu, ConvertUnitState(0))
call UnitDamageTarget(at,uu,ss,true,false,ConvertAttackType(6),ConvertDamageType(26),ConvertWeaponType(0))
set x=  (x-GetUnitState(uu, ConvertUnitState(0)))/ GetUnitState(uu, ConvertUnitState(1))
if x<0.05 and Xs11(i)>=6 and GetUnitLifePercent(uu)>.0 then
if Xs11(i)==rd or rd==7 then
set Ji11[i]=Ji11[i]*2
set Ji12[i]=Ji12[i]+1
set ep=0
loop
exitwhen ep>11
call DisplayTextToPlayer(Player(ep),0,0,sss1+GetPlayerName(Player(i))+"的隐藏技能发生了神奇的进化，技能威力加强了一倍！")
set ep=ep+1
endloop
return
endif
endif
call DestroyEffect(AddSpecialEffectTarget(e,uu,"overhead"))
call GroupRemoveUnit(g,uu)
endif
endloop
call DestroyGroup(g)
set uu=null
set g=null
endif
endfunction
function Ss11 takes integer str,integer agi,integer int,integer lv,integer m1,integer m2,integer m3,integer m4,real xs returns real
local real n
set n=(str*m1+agi*m2+int*m3)*lv*xs
if m4>1 then
set n=(str+agi+int)*lv*xs*m4
endif
return n
endfunction
function Trig_x1_Conditions takes nothing returns boolean
local integer i=0
if b11==false then
set b11=true
call DialogClear(dk11)
set an11[0]=DialogAddButton(dk11,"选择力量（力量型的会发挥最大威力）",0)
set an11[1]=DialogAddButton(dk11,"选择敏捷（敏捷型的会发挥最大威力）",0)
set an11[2]=DialogAddButton(dk11,"选择智力（智力型的会发挥最大威力）",0)
set an11[3]=DialogAddButton(dk11,"选择全能（属性平均的会发挥最大威力）",0)
call DialogSetMessage(dk11,"请选择一个")
loop
exitwhen i>12
call DialogDisplay(Player(i),dk11,true)
set i=i+1
endloop
endif
return true
endfunction
function Dk11 takes button b,integer i,string t returns boolean
if GetClickedButton()==b then
set bz123[i]=true
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,t)
return true
endif
return false
endfunction
function Trig_x2_Conditions takes nothing returns boolean
local integer i=0
local string s="-----------欢迎使用“上帝技能”，输入“打开提示”打开升级经验提示，输入“关闭提示”关闭升级经验提示，输入“查询”查询技能详细情况。"
set i=GetPlayerId(GetTriggerPlayer())
if bz123[i]==false then
if Dk11(an11[0],i,sss1+" 选择了力量型附加技能 "+s)then
set bz01[i]=true
endif
if Dk11(an11[1],i,sss1+" 选择了敏捷型附加技能 "+s)then
set bz11[i]=true
endif
if Dk11(an11[2],i,sss1+" 选择了智力型附加技能 "+s)then
set bz21[i]=true
endif
if Dk11(an11[3],i,sss1+" 选择了全能型附加技能 "+s)then
set bz31[i]=true
endif
endif
return true
endfunction
function S2O11 takes string orderIdString returns integer
local integer orderId
set orderId=OrderId(orderIdString)
if(orderId!=0)then
return orderId
endif
set orderId=UnitId(orderIdString)
if(orderId!=0)then
return orderId
endif
return 0
endfunction
function Trig_x3_Conditions takes nothing returns boolean
local location p=null
local unit u=null
if GetIssuedOrderId()==S2O11("move")and bz123[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))] then
set u=GetTriggerUnit()
set p=GetOrderPointLoc()
call SetUnitX(u,GetLocationX(p))
call SetUnitY(u,GetLocationY(p))
call RemoveLocation(p)
set u=null
endif
return true
endfunction
function Ppx takes integer i,integer n returns integer 
return Ji11[i]*n
endfunction
function Px11 takes integer i,integer m returns integer
if bz01[i] and m==0 then
return Ppx(i,4)
endif
if bz11[i] and m==1 then
return Ppx(i,4)
endif
if bz21[i] and m==2 then
return Ppx(i,6)
endif
if bz31[i] and m==3 then
return Ppx(i,2)
endif
return 1
endfunction
function Fx11 takes integer lv returns integer
local integer n
set n=R2I(SquareRoot(GetRandomReal(1,GetRandomInt(1,lv+2)*GetRandomInt(1,2+lv)))-1)
if n>lv then
set n=lv
if n>7 then
set n=7
endif
endif
if n<1 then
set n=1
endif
return n 
endfunction
function Trig_x4_Conditions takes nothing returns boolean
local integer i
local unit ua
local unit u
local integer str
local integer agi
local integer int
local integer lv
local real sh
local string array s
local integer n
set ua=GetAttacker()
set u=GetTriggerUnit()
set i=GetPlayerId(GetOwningPlayer(ua))
if bz123[i] and IsUnitType(ua,ConvertUnitType(0)) then
set s[1]="Abilities\\Spells\\Human\\Blizzard\\BlizzardTarget.mdl"
set s[2]="Abilities\\Spells\\Other\\Doom\\DoomTarget.mdl"
set s[3]="Abilities\\Spells\\Other\\Volcano\\VolcanoDeath.mdl"
set s[4]="Abilities\\Spells\\Demon\\RainOfFire\\RainOfFireTarget.mdl"
set s[5]="Abilities\\Spells\\Human\\ManaFlare\\ManaFlareBase.mdl"
set s[6]="units\\human\\phoenix\\phoenix.mdl"
set s[7]="units\\demon\\Infernal\\Infernal.mdl"
set str=GetHeroStr(ua,true)
set agi=GetHeroAgi(ua,true)
set int=GetHeroInt(ua,true)
set lv=Xs11(i)
set n=Fx11(lv)
set sh=Ss11(str,agi,int,lv,Px11(i,0),Px11(i,1),Px11(i,2),Px11(i,3),n*n)
call dj11('d',2+2*lv,u,200+50*lv+n*100,ua,sh,s[n],n)
endif
set ua=null
set u=null
return true
endfunction
function Trig_x5_Conditions takes nothing returns boolean
local integer i
set i=GetPlayerId(GetOwningPlayer(GetKillingUnit()))
if bz123[i] and IsPlayerEnemy(GetOwningPlayer(GetTriggerUnit()),GetOwningPlayer(GetKillingUnit())) then
if IsUnitType(GetTriggerUnit(),ConvertUnitType(0)) then
call Sg11(i,10)
else
call Sg11(i,1)
endif
endif
return true
endfunction
function Fj11 takes nothing returns nothing
local integer n=0
if b11==false then
loop
exitwhen n>11
call DisplayTextToPlayer(Player(n),0,0,sss1+" 任意玩家输入“上帝技能”可打开隐藏技能！，输入“打开提示”打开升级经验提示，输入“关闭提示”关闭升级经验提示，输入“查询”查询技能详细情况。")
set n=n+1
endloop
endif
endfunction
function Tt111 takes trigger trig, playerunitevent whichEvent returns nothing
local integer index
set index = 0
loop
call TriggerRegisterPlayerUnitEvent(trig, Player(index), whichEvent, null)
set index = index + 1
exitwhen index == 16
endloop
endfunction
function Trig_x7_Conditions takes nothing returns boolean
local integer i
set i=GetPlayerId(GetTriggerPlayer())
if bz123[i]==true and Isb[i]==false then
set Isb[i]=true
return true
endif
return false
endfunction
function Trig_x6_Conditions takes nothing returns boolean
local integer i
set i=GetPlayerId(GetTriggerPlayer())
if bz123[i]==true and Isb[i]==true then
set Isb[i]=false
return true
endif
return false
endfunction
function Gmu takes player whichPlayer, boolexpr filter returns group
local group g = CreateGroup()
call GroupEnumUnitsOfPlayer(g, whichPlayer, filter)
call DestroyBoolExpr(filter)
return g
endfunction
function Zho takes real m returns string
if m<= 1000000 then
return I2S(R2I(m))
endif
if m>1000000 and m<=100000000 then
return R2S(m/10000)+"万"
endif
if m>100000000 then
return R2S(m/100000000)+"亿"
endif
return null
endfunction
function Trig_x8_Conditions takes nothing returns boolean
local integer i
local integer j
local unit u
local integer str
local integer agi
local integer int
set i=GetPlayerId(GetTriggerPlayer())
set u= FirstOfGroup(Gmu(Player(i), null))
set str=GetHeroStr(u,true)
set agi=GetHeroAgi(u,true)
set int=GetHeroInt(u,true)
if bz123[i]==true then
set j=Xs11(i)
call DisplayTextToPlayer(Player(i),0,0,sss2+" 以下是您的隐藏技能的详细信息：")
call DisplayTextToPlayer(Player(i),0,0,sss1+"当前等级："+I2S(j)+"级")
call DisplayTextToPlayer(Player(i),0,0,sss1+"当前经验："+I2S(exp11[i]))
call DisplayTextToPlayer(Player(i),0,0,sss1+"进化等级："+I2S(Ji12[i])+"级")
call DisplayTextToPlayer(Player(i),0,0,sss1+"距下一级："+I2S(lvexp11[i]-exp11[i])+"的经验")
call DisplayTextToPlayer(Player(i),0,0,sss1+"发动几率："+I2S(2+2*j)+"% ")
call DisplayTextToPlayer(Player(i),0,0,sss1+"技能最小范围："+I2S(300+50*j))
if j>7 then
set j=7
endif
call DisplayTextToPlayer(Player(i),0,0,sss1+"技能最大范围："+I2S(200+50*Xs11(i)+j*100))
call DisplayTextToPlayer(Player(i),0,0,sss1+"技能最小威力："+Zho(Ss11(str,agi,int,Xs11(i),Px11(i,0),Px11(i,1),Px11(i,2),Px11(i,3),1)))
call DisplayTextToPlayer(Player(i),0,0,sss1+"技能最大威力："+Zho(Ss11(str,agi,int,Xs11(i),Px11(i,0),Px11(i,1),Px11(i,2),Px11(i,3),j*j)))
return true
endif
return false
endfunction
function Txt takes trigger t,string s returns nothing
local integer i
set i=0
loop
exitwhen i==12
call TriggerRegisterPlayerChatEvent(t,Player(i),s,true)
set i=i+1
endloop
endfunction
function SDMJ takes nothing returns nothing
local trigger t
local integer i
local timer tt
set dk11=DialogCreate()
set i=0
loop
exitwhen(i>12)
set bz01[i]=false
set bz11[i]=false
set bz21[i]=false
set bz31[i]=false
set bz123[i]=false
set exp11[i]=0
set lvexp11[i]=200
set strlv11[i]=1
set agilv11[i]=1
set intlv11[i]=1
set alllv11[i]=1
set Ji11[i]=1
set Ji12[i]=0
set Isb[i]=false
set i=i+1
endloop
set tt=CreateTimer()
call TimerStart(tt,60,true,function Fj11)
set tt=null
set t=CreateTrigger()
call Txt(t,"上帝技能")
call TriggerAddCondition(t,Condition(function Trig_x1_Conditions))
set t=CreateTrigger()
call Txt(t,"打开提示")
call TriggerAddCondition(t,Condition(function Trig_x6_Conditions))
set t=CreateTrigger()
call Txt(t,"关闭提示")
call TriggerAddCondition(t,Condition(function Trig_x7_Conditions))
set t=CreateTrigger()
call Txt(t,"查询")
call TriggerAddCondition(t,Condition(function Trig_x8_Conditions))
set t=CreateTrigger()
call TriggerRegisterDialogEvent(t,dk11)
call TriggerAddCondition(t,Condition(function Trig_x2_Conditions))
set t=CreateTrigger()
call Tt111(t,ConvertPlayerUnitEvent(39))
call TriggerAddCondition(t,Condition(function Trig_x3_Conditions))
set t=CreateTrigger()
call Tt111(t,ConvertPlayerUnitEvent(18))
call TriggerAddCondition(t,Condition(function Trig_x4_Conditions))
set t=CreateTrigger()
call Tt111(t,ConvertPlayerUnitEvent(20))
call TriggerAddCondition(t,Condition(function Trig_x5_Conditions))
set t=null
endfunction