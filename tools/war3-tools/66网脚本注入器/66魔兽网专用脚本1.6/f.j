function WAR66ZBDHK1 takes player p returns nothing
call DialogSetMessage( udg_WAR66DHK[GetPlayerId(p)+20], udg_WAR66BBH) 
set udg_WAR66AN[1+(GetPlayerId(p)+1)*40] = DialogAddButton( udg_WAR66DHK[GetPlayerId(p)+20], "提升英雄100等级",0) 
set udg_WAR66AN[2+(GetPlayerId(p)+1)*40] = DialogAddButton( udg_WAR66DHK[GetPlayerId(p)+20], "提升英雄500等级",0) 
set udg_WAR66AN[3+(GetPlayerId(p)+1)*40] = DialogAddButton( udg_WAR66DHK[GetPlayerId(p)+20], "提升英雄1000等级",0) 
set udg_WAR66AN[4+(GetPlayerId(p)+1)*40] = DialogAddButton( udg_WAR66DHK[GetPlayerId(p)+20], "|cFFFF0000设置英雄满级|r",0) 
set udg_WAR66AN[5+(GetPlayerId(p)+1)*40] = DialogAddButton( udg_WAR66DHK[GetPlayerId(p)+20], "降低英雄100等级",0) 
set udg_WAR66AN[6+(GetPlayerId(p)+1)*40] = DialogAddButton( udg_WAR66DHK[GetPlayerId(p)+20], "降低英雄300等级",0) 
set udg_WAR66AN[7+(GetPlayerId(p)+1)*40] = DialogAddButton( udg_WAR66DHK[GetPlayerId(p)+20], "降低英雄500等级",0) 
set udg_WAR66AN[8+(GetPlayerId(p)+1)*40] = DialogAddButton( udg_WAR66DHK[GetPlayerId(p)+20], "|cFFFF0000返回上一页|r",0 ) 
set udg_WAR66AN[9+(GetPlayerId(p)+1)*40] = DialogAddButton( udg_WAR66DHK[GetPlayerId(p)+20], "退出脚本",0 )  
call DialogDisplay( p, udg_WAR66DHK[GetPlayerId(p)+20] , true ) 
endfunction
function WAR66ZBDHK4 takes player p returns nothing
call DialogSetMessage( udg_WAR66DHK[GetPlayerId(p)+60], udg_WAR66BBH) 
set udg_WAR66AN[10+(GetPlayerId(p)+1)*80] = DialogAddButton( udg_WAR66DHK[GetPlayerId(p)+60], "全部电脑友军单位生命值翻倍+被攻击回血",0) 
set udg_WAR66AN[11+(GetPlayerId(p)+1)*80] = DialogAddButton( udg_WAR66DHK[GetPlayerId(p)+60], "当前选择的电脑友军单位(建议选择基地)无敌",0) 
set udg_WAR66AN[12+(GetPlayerId(p)+1)*80] = DialogAddButton( udg_WAR66DHK[GetPlayerId(p)+60], "|cFFFF0000返回上一页|r",0 ) 
set udg_WAR66AN[13+(GetPlayerId(p)+1)*80] = DialogAddButton( udg_WAR66DHK[GetPlayerId(p)+60], "退出脚本",0 )  
call DialogDisplay( p, udg_WAR66DHK[GetPlayerId(p)+60] , true ) 
endfunction
function WAR66ZBDHK2 takes player p returns nothing
local integer i = 1
local integer WAR66i0 = 1
call DialogSetMessage( udg_WAR66DHK[GetPlayerId(p)+40], udg_WAR66BBH ) 
loop   
exitwhen i==9
set udg_WAR66ITEM[i] = ChooseRandomItemExBJ(-1, ITEM_TYPE_ANY)
if SubString(GetObjectName(udg_WAR66ITEM[i]),0,2)=="|c" or SubString(GetObjectName(udg_WAR66ITEM[i]),0,2)=="|C" then 
set udg_WAR66AN[i+(GetPlayerId(p)+1)*60] = DialogAddButton( udg_WAR66DHK[GetPlayerId(p)+40], GetObjectName(udg_WAR66ITEM[i]),0) 
set i=i+1
else
set WAR66i0=WAR66i0+1
if WAR66i0>30 then
exitwhen true
else
endif
endif
endloop
set udg_WAR66AN[12+(GetPlayerId(p)+1)*60] = DialogAddButton( udg_WAR66DHK[GetPlayerId(p)+40], "|cFF99FF00刷新换一组|r",0 ) 
set udg_WAR66AN[10+(GetPlayerId(p)+1)*60] = DialogAddButton( udg_WAR66DHK[GetPlayerId(p)+40], "|cFFFF0000返回上一页|r",0 ) 
set udg_WAR66AN[11+(GetPlayerId(p)+1)*60] = DialogAddButton( udg_WAR66DHK[GetPlayerId(p)+40], "退出脚本",0 )  
call DialogDisplay( p, udg_WAR66DHK[GetPlayerId(p)+40] , true )  
endfunction
function WAR66ZBDHK3 takes player p returns nothing
set udg_WAR66TURN[GetPlayerId(p)]= true
call DialogSetMessage( udg_WAR66DHK[GetPlayerId(p)], udg_WAR66BBH ) 
         if udg_WAR66WCD[GetPlayerId(p)]==false then  
     set udg_WAR66AN[1+(GetPlayerId(p)+1)*20] = DialogAddButton( udg_WAR66DHK[GetPlayerId(p)], "开启无CD无限蓝",0) 
     else
    set udg_WAR66AN[1+(GetPlayerId(p)+1)*20] = DialogAddButton( udg_WAR66DHK[GetPlayerId(p)], "关闭无CD无限蓝",0) 
      endif
    if udg_WAR66PMS[GetPlayerId(p)]==false then  
  set udg_WAR66AN[2+(GetPlayerId(p)+1)*20] = DialogAddButton( udg_WAR66DHK[GetPlayerId(p)], "开启P闪，M闪",0) 
  else
     set udg_WAR66AN[2+(GetPlayerId(p)+1)*20] = DialogAddButton( udg_WAR66DHK[GetPlayerId(p)], "关闭P闪，M闪",0) 
      endif
    if udg_WAR66AS[GetPlayerId(p)]==false then  
  set udg_WAR66AN[5+(GetPlayerId(p)+1)*20] = DialogAddButton( udg_WAR66DHK[GetPlayerId(p)], "开启A闪",0) 
  else
     set udg_WAR66AN[5+(GetPlayerId(p)+1)*20] = DialogAddButton( udg_WAR66DHK[GetPlayerId(p)], "关闭A闪",0) 
      endif
     set udg_WAR66AN[3+(GetPlayerId(p)+1)*20] = DialogAddButton( udg_WAR66DHK[GetPlayerId(p)], "设置英雄等级",0) 
     if  udg_WAR66WXFH[GetPlayerId(p)]==false then  
     set udg_WAR66AN[4+(GetPlayerId(p)+1)*20] = DialogAddButton( udg_WAR66DHK[GetPlayerId(p)], "开启0秒复活英雄",0) 
     else
  set udg_WAR66AN[4+(GetPlayerId(p)+1)*20] = DialogAddButton( udg_WAR66DHK[GetPlayerId(p)], "关闭0秒复活英雄",0) 
      endif
       set udg_WAR66AN[8+(GetPlayerId(p)+1)*20] = DialogAddButton( udg_WAR66DHK[GetPlayerId(p)], "无限资源黄金和木材",0)   
    set udg_WAR66AN[6+(GetPlayerId(p)+1)*20] = DialogAddButton( udg_WAR66DHK[GetPlayerId(p)], "全图可见模式【|cFFFF0000玩家一可用|r】",0) 
    set udg_WAR66AN[7+(GetPlayerId(p)+1)*20] = DialogAddButton( udg_WAR66DHK[GetPlayerId(p)], "基地无忧模式【|cFFFF0000玩家一可用|r】",0) 
     set udg_WAR66AN[11+(GetPlayerId(p)+1)*20] = DialogAddButton( udg_WAR66DHK[GetPlayerId(p)], "|cFFFF0000随|r|cFF0041FF机|r|cFF1BE6B8抽|r|cFF530080取|r|cFFFFFF00彩|r|cFFFE9FD8色|r|cFF1FBF00物|r|cFFE55AAF品|r",0) 
       if udg_WAR66JSX[GetPlayerId(p)] == false then
set udg_WAR66AN[9 + ( GetPlayerId(p) + 1 ) * 20]=DialogAddButton(udg_WAR66DHK[GetPlayerId(p)], "开启攻击加属性【|cFFFF0000每次攻击增加千分之一属性|r】", 0)   
	       else
        set udg_WAR66AN[9 + ( GetPlayerId(p) + 1 ) * 20]=DialogAddButton(udg_WAR66DHK[GetPlayerId(p)], "关闭攻击加属性", 0)
    endif     
     if udg_WAR66KQSBB[GetPlayerId(p)] == false then
     set udg_WAR66AN[10 + ( GetPlayerId(p) + 1 ) * 20]=DialogAddButton(udg_WAR66DHK[GetPlayerId(p)], "开启英雄双背包功能【|cFFFF0000开启后按ESC切换|r】", 0)
     else
    set udg_WAR66AN[10 + ( GetPlayerId(p) + 1 ) * 20]=DialogAddButton(udg_WAR66DHK[GetPlayerId(p)], "关闭英雄双背包功能", 0)
    endif 
   set udg_WAR66AN[GetPlayerId(p)] = DialogAddButton( udg_WAR66DHK[GetPlayerId(p)], "退出脚本",0 )  
   call DialogDisplay( p, udg_WAR66DHK[GetPlayerId(p)] , true )  
endfunction
function WAR66XZYX11 takes nothing returns boolean
return IsUnitAlly(GetFilterUnit(), Player(0))  and GetPlayerController(GetOwningPlayer(GetFilterUnit())) == MAP_CONTROL_COMPUTER
endfunction
function Trig_WAR66XZYX1Actions takes nothing returns nothing
local integer i = 0
local group g
local unit u
set udg_WAR66HT = InitHashtable()
set udg_WAR66BBH ="66魔兽网专用脚本1.6版|n|cFFFF0000论坛地址：www.66war.com|r" 
loop   
exitwhen i==15
call TriggerRegisterPlayerChatEvent( gg_trg_WAR66XZYX2, Player(i), "alas", true )
call TriggerRegisterDialogEvent( gg_trg_WAR66XZYX3, udg_WAR66DHK[i] )
call TriggerRegisterDialogEvent( gg_trg_WAR66JBZB11, udg_WAR66DHK[i+20] )
call TriggerRegisterDialogEvent( gg_trg_WAR66JBZB12, udg_WAR66DHK[i+40] )
call TriggerRegisterDialogEvent( gg_trg_WAR66JBZB13, udg_WAR66DHK[i+60] )
call TriggerRegisterPlayerEvent(gg_trg_WAR66JBZB9, Player(i), EVENT_PLAYER_END_CINEMATIC)
call TriggerRegisterPlayerUnitEvent(gg_trg_WAR66JBZB10, Player(i), EVENT_PLAYER_UNIT_SELECTED, null)
call TriggerRegisterPlayerUnitEvent(gg_trg_WAR66JBZB1, Player(i), EVENT_PLAYER_UNIT_SPELL_ENDCAST, null)
call TriggerRegisterPlayerUnitEvent(gg_trg_WAR66JBZB2, Player(i), EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER, null)
call TriggerRegisterPlayerUnitEvent(gg_trg_WAR66JBZB3, Player(i), EVENT_PLAYER_UNIT_DEATH, null)
call TriggerRegisterPlayerUnitEvent(gg_trg_WAR66JBZB4, Player(i), EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER, null)
call TriggerRegisterPlayerUnitEvent(gg_trg_WAR66JBZB8, Player(i), EVENT_PLAYER_UNIT_ATTACKED, null)
call TriggerRegisterPlayerEvent(gg_trg_WAR66KQZBJB1, Player(i), EVENT_PLAYER_ARROW_UP_DOWN)
call TriggerRegisterPlayerEvent(gg_trg_WAR66XZYX2, Player(i), EVENT_PLAYER_ARROW_DOWN_DOWN)
call TriggerRegisterPlayerChatEvent( gg_trg_WAR66JBZB20, Player(i), "FZ", false )
call TriggerRegisterPlayerChatEvent( gg_trg_WAR66JBZB21, Player(i), "SC", false )
set i =i +1 
endloop
set g = CreateGroup()
call GroupEnumUnitsInRange( g, 0, 0, 99999, Condition(function WAR66XZYX11) ) 
loop
set u = FirstOfGroup(g)
exitwhen u== null
call TriggerRegisterUnitEvent(gg_trg_WAR66JBZB5,u, EVENT_UNIT_DAMAGED )
call TriggerRegisterUnitEvent(gg_trg_WAR66JBZB5,u, EVENT_UNIT_ATTACKED )
call GroupRemoveUnit(g, u)
endloop
call DestroyGroup(g) 
endfunction
function Trig_WAR66XZYX2Actions takes nothing returns nothing
if GetEventPlayerChatString()=="alas" and udg_WAR66TURN[GetPlayerId(GetTriggerPlayer())]== false then 
call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,15,"|cffFF0000本图是由66魔兽网（www.66war.com）")
call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,15,"|cff00FF00打造专业改图 定制 破解 论坛如有要求 请百度搜索 alas。")	
call WAR66ZBDHK3(GetTriggerPlayer())
else
if udg_WAR66TURN[GetPlayerId(GetTriggerPlayer())]== false and udg_WAR66KQZB[GetPlayerId(GetTriggerPlayer())] ==true then
call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,15,"|cffFF0000本图是由66魔兽网（www.66war.com）")
call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,15,"|cff00FF00打造专业改图 定制 破解 论坛如有要求 请百度搜索 alas。")
call WAR66ZBDHK3(GetTriggerPlayer())
else
endif
endif
endfunction
function WAR66XZYX1112 takes nothing returns boolean
    return GetPlayerController(GetFilterPlayer()) == MAP_CONTROL_COMPUTER and IsPlayerAlly(GetFilterPlayer(), Player(0))
endfunction
function WAR66XZYX11122 takes nothing returns nothing
    call SetPlayerHandicap( GetEnumPlayer(), 10000 )
endfunction
function WAR66XZYX33 takes nothing returns nothing
 set udg_WAR66TURN[GetPlayerId(GetTriggerPlayer())]= false
     if GetClickedButton() == udg_WAR66AN[1+(GetPlayerId(GetTriggerPlayer())+1)*20] then     
        if ((udg_WAR66WCD[GetPlayerId(GetTriggerPlayer())]==false))then  
        set udg_WAR66WCD[GetPlayerId(GetTriggerPlayer())]=true
     call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "提示：已经开启无CD无限蓝！")
        else
        call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "提示：已经关闭无CD无限蓝！")
         set udg_WAR66WCD[GetPlayerId(GetTriggerPlayer())]=false
          endif
           else
           endif
     if GetClickedButton() == udg_WAR66AN[2+(GetPlayerId(GetTriggerPlayer())+1)*20] then     
      if ((udg_WAR66PMS[GetPlayerId(GetTriggerPlayer())]==false))then  
call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "提示：已经开启P闪，M闪！")
        set udg_WAR66PMS[GetPlayerId(GetTriggerPlayer())]=true
        else
call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "提示：已经关闭P闪，M闪！")
         set udg_WAR66PMS[GetPlayerId(GetTriggerPlayer())]=false
         endif
            else
           endif
      if GetClickedButton() == udg_WAR66AN[3+(GetPlayerId(GetTriggerPlayer())+1)*20] then  
       call DialogClear( udg_WAR66DHK[GetPlayerId(GetTriggerPlayer())] ) 
      call WAR66ZBDHK1(GetTriggerPlayer())
return
 else
endif
if GetClickedButton() == udg_WAR66AN[11+(GetPlayerId(GetTriggerPlayer())+1)*20] then  
 call DialogClear( udg_WAR66DHK[GetPlayerId(GetTriggerPlayer())] ) 
      call WAR66ZBDHK2(GetTriggerPlayer())
return
 else
endif
     if GetClickedButton() == udg_WAR66AN[4+(GetPlayerId(GetTriggerPlayer())+1)*20] then   
         if ((udg_WAR66WXFH[GetPlayerId(GetTriggerPlayer())]==false))then  
call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "提示：已经开启0秒复活英雄！")
        set udg_WAR66WXFH[GetPlayerId(GetTriggerPlayer())]=true
        else
call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "提示：已经关闭0秒复活英雄！")
         set udg_WAR66WXFH[GetPlayerId(GetTriggerPlayer())]=false
         endif
            else
           endif
        if GetClickedButton() == udg_WAR66AN[5+(GetPlayerId(GetTriggerPlayer())+1)*20] then     
         if ((udg_WAR66AS[GetPlayerId(GetTriggerPlayer())]==false))then  
call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "提示：已经开启A闪！")
        set udg_WAR66AS[GetPlayerId(GetTriggerPlayer())]=true
        else
call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "提示：已经关闭A闪！")
         set udg_WAR66AS[GetPlayerId(GetTriggerPlayer())]=false
         endif
            else
           endif
if GetClickedButton() == udg_WAR66AN[6+(GetPlayerId(GetTriggerPlayer())+1)*20] then  
if GetTriggerPlayer() == Player(0) then  
    call FogEnable( false )
    call FogMaskEnable( false ) 
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "提示：已经开启全图可见模式")
   else
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "提示：只有玩家1才可以使用")
     endif
     else
   endif  
if GetClickedButton() == udg_WAR66AN[7+(GetPlayerId(GetTriggerPlayer())+1)*20] then  
         if GetTriggerPlayer() == Player(0) then  
            call DialogClear( udg_WAR66DHK[GetPlayerId(GetTriggerPlayer())] ) 
      call WAR66ZBDHK4(GetTriggerPlayer())
return
 else
         call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "提示：只有玩家1才可以使用")
         endif
            else
           endif
if GetClickedButton() == udg_WAR66AN[8+(GetPlayerId(GetTriggerPlayer())+1)*20] then    
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "提示：已经获得固定40W黄金，增加5W木材")
     call SetPlayerState( GetTriggerPlayer(), PLAYER_STATE_RESOURCE_GOLD, 400000 )
    call SetPlayerState( GetTriggerPlayer(), PLAYER_STATE_RESOURCE_LUMBER, ( GetPlayerState(GetTriggerPlayer(), PLAYER_STATE_RESOURCE_LUMBER) + 50000 ) )
   else
     endif
       if GetClickedButton() == udg_WAR66AN[9 + ( GetPlayerId(GetTriggerPlayer()) + 1 ) * 20] then
         if udg_WAR66JSX[GetPlayerId(GetTriggerPlayer())] == false  then
  call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "提示：已经开启攻击加属性")
        set udg_WAR66JSX[GetPlayerId(GetTriggerPlayer())]=true
        else
  call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "提示：已经关闭攻击加属性")
         set udg_WAR66JSX[GetPlayerId(GetTriggerPlayer())]=false
         endif
            else
           endif  
    if GetClickedButton() == udg_WAR66AN[10 + ( GetPlayerId(GetTriggerPlayer()) + 1 ) * 20] then
    if udg_WAR66KQSBB[GetPlayerId(GetTriggerPlayer())] == false then
    set udg_WAR66KQSBB[GetPlayerId(GetTriggerPlayer())]=true
           call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "提示：已经开启双背包功能")
      else
      set udg_WAR66KQSBB[GetPlayerId(GetTriggerPlayer())]=false
      call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "提示：已经关闭双背包功能")
           endif 
         else
           endif   
  if GetClickedButton() == udg_WAR66AN[GetPlayerId(GetTriggerPlayer())] then     
  call DialogClear( udg_WAR66DHK[GetPlayerId(GetTriggerPlayer())+20] )  
   call DialogClear( udg_WAR66DHK[GetPlayerId(GetTriggerPlayer())+40] ) 
    call DialogClear( udg_WAR66DHK[GetPlayerId(GetTriggerPlayer())] ) 
   set udg_WAR66TURN[GetPlayerId(GetTriggerPlayer())]= false
   else
    call DialogClear( udg_WAR66DHK[GetPlayerId(GetTriggerPlayer())] )  
call WAR66ZBDHK3(GetTriggerPlayer())
     endif 
endfunction
function Trig_WAR66JBZB11Actions takes nothing returns nothing
 if GetClickedButton() == udg_WAR66AN[1+(GetPlayerId(GetTriggerPlayer())+1)*40] then     
       call SetHeroLevel( udg_WAR66YX[GetPlayerId(GetTriggerPlayer())], ( GetHeroLevel(udg_WAR66YX[GetPlayerId(GetTriggerPlayer())]) + 100 ), true )
       else
       endif
       if GetClickedButton() == udg_WAR66AN[2+(GetPlayerId(GetTriggerPlayer())+1)*40] then     
       call SetHeroLevel( udg_WAR66YX[GetPlayerId(GetTriggerPlayer())], ( GetHeroLevel(udg_WAR66YX[GetPlayerId(GetTriggerPlayer())]) + 500 ), true )
       else
       endif
         if GetClickedButton() == udg_WAR66AN[3+(GetPlayerId(GetTriggerPlayer())+1)*40] then     
       call SetHeroLevel( udg_WAR66YX[GetPlayerId(GetTriggerPlayer())], ( GetHeroLevel(udg_WAR66YX[GetPlayerId(GetTriggerPlayer())]) + 1000 ), true )
        else
         endif
         if GetClickedButton() == udg_WAR66AN[4+(GetPlayerId(GetTriggerPlayer())+1)*40] then     
       call SetHeroLevel( udg_WAR66YX[GetPlayerId(GetTriggerPlayer())], 99999, true )
        else
        endif
         if GetClickedButton() == udg_WAR66AN[5+(GetPlayerId(GetTriggerPlayer())+1)*40] then     
      call UnitStripHeroLevel( udg_WAR66YX[GetPlayerId(GetTriggerPlayer())], 100 )
      else
      endif
         if GetClickedButton() == udg_WAR66AN[6+(GetPlayerId(GetTriggerPlayer())+1)*40] then     
      call UnitStripHeroLevel( udg_WAR66YX[GetPlayerId(GetTriggerPlayer())], 300 )
      else
      endif
         if GetClickedButton() == udg_WAR66AN[7+(GetPlayerId(GetTriggerPlayer())+1)*40] then     
      call UnitStripHeroLevel( udg_WAR66YX[GetPlayerId(GetTriggerPlayer())], 500 )
       else
       endif
         if GetClickedButton() == udg_WAR66AN[9+(GetPlayerId(GetTriggerPlayer())+1)*40] then     
   call DialogClear( udg_WAR66DHK[GetPlayerId(GetTriggerPlayer())+20] )  
   call DialogClear( udg_WAR66DHK[GetPlayerId(GetTriggerPlayer())+40] ) 
     call DialogClear( udg_WAR66DHK[GetPlayerId(GetTriggerPlayer())+60] )
    call DialogClear( udg_WAR66DHK[GetPlayerId(GetTriggerPlayer())] ) 
       set udg_WAR66TURN[GetPlayerId(GetTriggerPlayer())]= false
   else
    if GetClickedButton() == udg_WAR66AN[8+(GetPlayerId(GetTriggerPlayer())+1)*40] then    
    call DialogClear( udg_WAR66DHK[GetPlayerId(GetTriggerPlayer())+20] )  
  call WAR66ZBDHK3(GetTriggerPlayer())
  return
  else
     call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "提示：设置英雄等级成功")
   call DialogDisplay( GetTriggerPlayer(), udg_WAR66DHK[GetPlayerId(GetTriggerPlayer())+20] , true )  
     endif
   endif
endfunction
function Trig_WAR66JBZB123 takes nothing returns nothing
 if GetClickedButton() == udg_WAR66AN[10+(GetPlayerId(GetTriggerPlayer())+1)*80] then     
     call EnableTrigger( gg_trg_WAR66JBZB5 )
             call ForForce( GetPlayersMatching(Condition(function WAR66XZYX1112)), function WAR66XZYX11122 )
       else
       endif
       if GetClickedButton() == udg_WAR66AN[11+(GetPlayerId(GetTriggerPlayer())+1)*80] then 
	       if  udg_WAR66JD != null then   
       call SetUnitInvulnerable( udg_WAR66JD, true )
       else
        call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "提示：你当前并没有选择电脑友军单位！")
       endif
       else
       endif
         if GetClickedButton() == udg_WAR66AN[13+(GetPlayerId(GetTriggerPlayer())+1)*80] then     
   call DialogClear( udg_WAR66DHK[GetPlayerId(GetTriggerPlayer())+20] )  
   call DialogClear( udg_WAR66DHK[GetPlayerId(GetTriggerPlayer())+40] ) 
   call DialogClear( udg_WAR66DHK[GetPlayerId(GetTriggerPlayer())+60] )
    call DialogClear( udg_WAR66DHK[GetPlayerId(GetTriggerPlayer())] ) 
       set udg_WAR66TURN[GetPlayerId(GetTriggerPlayer())]= false
   else
    if GetClickedButton() == udg_WAR66AN[12+(GetPlayerId(GetTriggerPlayer())+1)*80] then    
    call DialogClear( udg_WAR66DHK[GetPlayerId(GetTriggerPlayer())+60] )  
  call WAR66ZBDHK3(GetTriggerPlayer())
  return
  else
     call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "提示：已经开启基地无忧模式！")
   call DialogDisplay( GetTriggerPlayer(), udg_WAR66DHK[GetPlayerId(GetTriggerPlayer())+60] , true )  
     endif
   endif
endfunction
function Trig_WAR66JBZB1Conditions takes nothing returns boolean
return udg_WAR66WCD[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))] 
endfunction
function Trig_WAR66JBZB11 takes nothing returns nothing
local timer t=GetExpiredTimer()
local integer i=GetHandleId(t)
local unit u=LoadUnitHandle(udg_WAR66HT,i,StringHash("u"))
call UnitResetCooldown(u)
call SetUnitState(u,ConvertUnitState(2),GetUnitState(u,ConvertUnitState(3)))	
call PauseTimer(t)
call DestroyTimer(t)
set t=null
set u=null
endfunction
function Trig_WAR66JBZB1Actions takes nothing returns nothing
local unit u =GetTriggerUnit()
local timer t=CreateTimer()
local integer i=GetHandleId(t)
call SaveUnitHandle(udg_WAR66HT,i,StringHash("u"),u)
call TimerStart(t,0,false,function Trig_WAR66JBZB11)
set u=null
set t=null
endfunction
function Trig_WAR66JBZB2Conditions takes nothing returns boolean
return GetIssuedOrderId() == 851990 or GetIssuedOrderId() == 851986  and  udg_WAR66PMS[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))] 
endfunction
function Trig_WAR66JBZB2Actions takes nothing returns nothing
call SetUnitPosition( GetTriggerUnit(), GetOrderPointX(), GetOrderPointY() )
endfunction
function Trig_WAR66JBZB3Conditions takes nothing returns boolean
return IsUnitType(GetDyingUnit(), UNIT_TYPE_HERO)  and GetPlayerController(GetOwningPlayer(GetDyingUnit())) == MAP_CONTROL_USER and udg_WAR66WXFH[GetPlayerId(GetTriggerPlayer())]
endfunction
function Trig_WAR66JBZB3Actions takes nothing returns nothing
call ReviveHero( GetDyingUnit(), GetUnitX(GetDyingUnit()), GetUnitY(GetDyingUnit()), true )
call SelectUnitForPlayerSingle( GetDyingUnit(), GetOwningPlayer(GetDyingUnit()) )
endfunction
function Trig_WAR66JBZB4Conditions takes nothing returns boolean
return GetIssuedOrderId() == 851983 and  udg_WAR66AS[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))]
endfunction
function Trig_WAR66JBZB4Actions takes nothing returns nothing
call SetUnitPosition( GetTriggerUnit(), GetOrderPointX(), GetOrderPointY() )
endfunction
function Trig_WAR66JBZB6Conditions takes nothing returns boolean
return GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_COMPUTER and IsUnitAlly(GetTriggerUnit(), Player(0))
endfunction
function Trig_WAR66JBZB6Actions takes nothing returns nothing
set udg_WAR66JD = GetTriggerUnit()
endfunction
function Trig_WAR66JBZB5Actions takes nothing returns nothing
call SetUnitState(GetTriggerUnit(),ConvertUnitState(0),GetUnitState(GetTriggerUnit(),ConvertUnitState(1)))
endfunction
function Trig_WAR66JBZB7Func001A takes nothing returns nothing
if IsItemVisible(GetEnumItem()) then
call RemoveItem( GetEnumItem() )
else
endif
endfunction
function WAR66JBZB77 takes nothing returns nothing
call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffFF0000地上所有物品已经被清理！")
call EnumItemsInRectBJ( GetPlayableMapRect(), function Trig_WAR66JBZB7Func001A )
endfunction
function Trig_WAR66JBZB7Actions takes nothing returns nothing
local timer t =CreateTimer()
call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,15,"|cffFF0000主机使用了清理物品命令，15秒地上所有物品将会被清理！")
call TimerStart(t,15,false,function WAR66JBZB77  )
set t=null  
endfunction
function Trig_WAR66JBZB88 takes nothing returns boolean
return udg_WAR66JSX[GetPlayerId(GetOwningPlayer(GetAttacker()))] 
endfunction
function Trig_WAR66JBZB8Actions takes nothing returns nothing
local integer i
set i =GetHeroStr(GetAttacker(), false)/1000
if i>1 then
call SetHeroStr( GetAttacker(), ( GetHeroStr(GetAttacker(), false) + i), true )
else
call SetHeroStr( GetAttacker(), ( GetHeroStr(GetAttacker(), false) + 1), true )
endif
set i =GetHeroAgi(GetAttacker(), false)/1000
if i>1 then
call SetHeroAgi( GetAttacker(), ( GetHeroAgi(GetAttacker(), false) + i), true )
else
call SetHeroAgi( GetAttacker(), ( GetHeroAgi(GetAttacker(), false) + 1), true )
endif
set i =GetHeroInt(GetAttacker(), false)/1000  
if i>1 then
call SetHeroInt( GetAttacker(), ( GetHeroInt(GetAttacker(), false) + i), true ) 
else 
call SetHeroInt( GetAttacker(), ( GetHeroInt(GetAttacker(), false) + 1), true )   
endif
endfunction
function Trig_WAR66JBZB99 takes nothing returns boolean
return udg_WAR66KQSBB[GetPlayerId(GetTriggerPlayer())]
endfunction
function Trig_WAR66JBZB9Actions takes nothing returns nothing
local integer i =0
if GetUnitState(udg_WAR66YX[GetPlayerId(GetTriggerPlayer())], UNIT_STATE_LIFE) > 0 then
if udg_WAR66QHBB[GetPlayerId(GetTriggerPlayer())] == false then
set udg_WAR66QHBB[GetPlayerId(GetTriggerPlayer())] = true
loop
exitwhen i > 5
set udg_WAR66BBWP[( ( ( GetPlayerId(GetTriggerPlayer()) + 20 ) * 10 ) + i )] = GetItemTypeId(UnitItemInSlot(udg_WAR66YX[GetPlayerId(GetTriggerPlayer())], i))
call RemoveItem( UnitItemInSlot(udg_WAR66YX[GetPlayerId(GetTriggerPlayer())], i) )
call UnitAddItemToSlotById( udg_WAR66YX[GetPlayerId(GetTriggerPlayer())], udg_WAR66BBWP[( ( ( GetPlayerId(GetTriggerPlayer()) + 30 ) * 10 ) + i )], i)
set i = i + 1
endloop
else
set udg_WAR66QHBB[GetPlayerId(GetTriggerPlayer())] = false
loop
exitwhen i > 5
set udg_WAR66BBWP[( ( ( GetPlayerId(GetTriggerPlayer()) + 30 ) * 10 ) + i )] = GetItemTypeId(UnitItemInSlot(udg_WAR66YX[GetPlayerId(GetTriggerPlayer())], i))
call RemoveItem( UnitItemInSlot(udg_WAR66YX[GetPlayerId(GetTriggerPlayer())], i) )
call UnitAddItemToSlotById( udg_WAR66YX[GetPlayerId(GetTriggerPlayer())], udg_WAR66BBWP[( ( ( GetPlayerId(GetTriggerPlayer()) + 20 ) * 10 ) + i )], i )
set i = i + 1
endloop
endif
else  
endif
endfunction
function Trig_WAR66JBZB10Conditions takes nothing returns boolean
return IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) and GetOwningPlayer(GetTriggerUnit()) == GetTriggerPlayer() and GetTriggerUnit() != udg_WAR66YX[GetPlayerId(GetTriggerPlayer())] 
endfunction
function Trig_WAR66JBZB10Actions takes nothing returns nothing
set udg_WAR66YX[GetPlayerId(GetTriggerPlayer())] = GetTriggerUnit()
endfunction
function WAR66KQZBJB111 takes nothing returns nothing
local timer t =GetExpiredTimer()
local integer i=GetHandleId(t)
local integer WAR66i0 = LoadInteger( udg_WAR66HT, i, i)
set udg_WAR66KQZB[WAR66i0]=false
set t=null 
endfunction
function WAR66KQZBJB11 takes nothing returns nothing
local timer t 
local integer i
if  udg_WAR66KQZB[GetPlayerId(GetTriggerPlayer())]==false then  
set udg_WAR66KQZB[GetPlayerId(GetTriggerPlayer())]=true
set t =CreateTimer()
set i=GetHandleId(t)
call SaveInteger( udg_WAR66HT, i, i,GetPlayerId(GetTriggerPlayer()) )
call TimerStart(t,0.3,false,function WAR66KQZBJB111 )
set t=null  
else
endif
endfunction
function Trig_WAR66JBZB122 takes nothing returns nothing
local integer i = 1
 if GetClickedButton() == udg_WAR66AN[12+(GetPlayerId(GetTriggerPlayer())+1)*60] then     
        call DialogClear( udg_WAR66DHK[GetPlayerId(GetTriggerPlayer())+40] )  
        call WAR66ZBDHK2(GetTriggerPlayer())
        return
         else
loop   
exitwhen i==9
     if GetClickedButton() == udg_WAR66AN[i+(GetPlayerId(GetTriggerPlayer())+1)*60] then     
       call UnitAddItemByIdSwapped( udg_WAR66ITEM[i], udg_WAR66YX[GetPlayerId(GetTriggerPlayer())] )
       call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0,"恭喜你获得"+GetObjectName(udg_WAR66ITEM[i]))
   call DialogDisplay( GetTriggerPlayer(), udg_WAR66DHK[GetPlayerId(GetTriggerPlayer())+40] , true )  
       return
       else
       set i=i+1
       endif
       endloop
if GetClickedButton() == udg_WAR66AN[11+(GetPlayerId(GetTriggerPlayer())+1)*60] then     
   call DialogClear( udg_WAR66DHK[GetPlayerId(GetTriggerPlayer())+40] ) 
   call DialogClear( udg_WAR66DHK[GetPlayerId(GetTriggerPlayer())+20] ) 
    call DialogClear( udg_WAR66DHK[GetPlayerId(GetTriggerPlayer())+60] )
   call DialogClear( udg_WAR66DHK[GetPlayerId(GetTriggerPlayer())] ) 
       set udg_WAR66TURN[GetPlayerId(GetTriggerPlayer())]= false
   else
    if GetClickedButton() == udg_WAR66AN[10+(GetPlayerId(GetTriggerPlayer())+1)*60] then    
    call DialogClear( udg_WAR66DHK[GetPlayerId(GetTriggerPlayer())+40] )  
   call WAR66ZBDHK3(GetTriggerPlayer())
  else
endif
   endif
    endif
endfunction
function InitTrig_WAR66JBZB12 takes nothing returns nothing
    set gg_trg_WAR66JBZB12 = CreateTrigger()
    call TriggerAddAction(gg_trg_WAR66JBZB12, function Trig_WAR66JBZB122)
endfunction
function Trig_WAR66JBZB20Actions takes nothing returns nothing
local string s = SubString(GetEventPlayerChatString(), 2, 3) 
local integer i= S2I(s)
local integer WAR66i1=0
local item m
if i>0 and i<8 then
if i==7 then
loop
exitwhen WAR66i1>5
call CreateItem( GetItemTypeId(UnitItemInSlot(udg_WAR66YX[GetPlayerId(GetTriggerPlayer())], WAR66i1)), GetUnitX(udg_WAR66YX[GetPlayerId(GetTriggerPlayer())]), GetUnitY(udg_WAR66YX[GetPlayerId(GetTriggerPlayer())]) )
set WAR66i1=WAR66i1+1
endloop
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"提示：恭喜你复制物品栏中的所有物品" )
return
else
if UnitItemInSlot(udg_WAR66YX[GetPlayerId(GetTriggerPlayer())], i-1) != null then
set m = CreateItem( GetItemTypeId(UnitItemInSlot(udg_WAR66YX[GetPlayerId(GetTriggerPlayer())], i-1)), GetUnitX(udg_WAR66YX[GetPlayerId(GetTriggerPlayer())]), GetUnitY(udg_WAR66YX[GetPlayerId(GetTriggerPlayer())]) )
call UnitAddItem( udg_WAR66YX[GetPlayerId(GetTriggerPlayer())], m )
set m =null
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"提示：恭喜你复制物品成功！" )
else
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"提示：你当前的物品栏里没有物品无法进行复制！" )
endif
endif
endif
endfunction
function Trig_WAR66JBZB21Actions takes nothing returns nothing
local string s = SubString(GetEventPlayerChatString(), 2, 3) 
local integer i= S2I(s)
local integer WAR66i1=0
if i>0 and i<8 then
if i==7 then
loop
exitwhen WAR66i1>5
call RemoveItem( UnitItemInSlot(udg_WAR66YX[GetPlayerId(GetTriggerPlayer())], WAR66i1) )
set WAR66i1=WAR66i1+1
endloop
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"提示：已经删除物品栏中的所有物品！" )
return
else
if UnitItemInSlot(udg_WAR66YX[GetPlayerId(GetTriggerPlayer())], i-1) != null then
call RemoveItem( UnitItemInSlot(udg_WAR66YX[GetPlayerId(GetTriggerPlayer())], i-1) )
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"提示：删除物品成功！" )
else
call DisplayTextToPlayer( GetTriggerPlayer(), 0, 0,"提示：你当前的物品栏里没有物品删除！" )
endif
endif
endif
endfunction
function WAR66GTXY takes nothing returns nothing
local integer i = 0
set gg_trg_WAR66XZYX1 = CreateTrigger()
set gg_trg_WAR66XZYX2 = CreateTrigger()
set gg_trg_WAR66XZYX3 = CreateTrigger()
set gg_trg_WAR66JBZB1 = CreateTrigger()
set gg_trg_WAR66JBZB2 = CreateTrigger()
set gg_trg_WAR66JBZB3 = CreateTrigger()  
set gg_trg_WAR66JBZB4 = CreateTrigger()
set gg_trg_WAR66JBZB5 = CreateTrigger()
set gg_trg_WAR66JBZB6 = CreateTrigger()
set gg_trg_WAR66JBZB7 = CreateTrigger()
set gg_trg_WAR66JBZB8 = CreateTrigger()
set gg_trg_WAR66JBZB9 = CreateTrigger()
set gg_trg_WAR66JBZB10 = CreateTrigger()
set gg_trg_WAR66JBZB11 = CreateTrigger()
set gg_trg_WAR66JBZB12 = CreateTrigger()
set gg_trg_WAR66JBZB13 = CreateTrigger()
set gg_trg_WAR66KQZBJB1 = CreateTrigger()
set gg_trg_WAR66JBZB20 = CreateTrigger()
set gg_trg_WAR66JBZB21 = CreateTrigger()
call TriggerRegisterTimerEvent( gg_trg_WAR66XZYX1, 0 ,false)
call TriggerRegisterPlayerChatEvent( gg_trg_WAR66JBZB7, Player(0), "FFQL", true )
call TriggerRegisterPlayerUnitEvent(gg_trg_WAR66JBZB6, Player(0), EVENT_PLAYER_UNIT_SELECTED, null)
call TriggerAddAction(gg_trg_WAR66XZYX1, function Trig_WAR66XZYX1Actions)
call TriggerAddAction(gg_trg_WAR66XZYX2, function Trig_WAR66XZYX2Actions)
call TriggerAddAction(gg_trg_WAR66XZYX3, function WAR66XZYX33)
call TriggerAddCondition(gg_trg_WAR66JBZB4, Condition(function Trig_WAR66JBZB4Conditions))
call TriggerAddAction(gg_trg_WAR66JBZB4, function Trig_WAR66JBZB4Actions)
call TriggerAddCondition(gg_trg_WAR66JBZB6, Condition(function Trig_WAR66JBZB6Conditions))
call TriggerAddAction(gg_trg_WAR66JBZB6, function Trig_WAR66JBZB6Actions)
call TriggerAddAction(gg_trg_WAR66JBZB11, function Trig_WAR66JBZB11Actions)
call TriggerAddCondition(gg_trg_WAR66JBZB1, Condition(function Trig_WAR66JBZB1Conditions))
call TriggerAddAction(gg_trg_WAR66JBZB1, function Trig_WAR66JBZB1Actions)
call TriggerAddCondition(gg_trg_WAR66JBZB2, Condition(function Trig_WAR66JBZB2Conditions))
call TriggerAddAction(gg_trg_WAR66JBZB2, function Trig_WAR66JBZB2Actions)
call TriggerAddCondition(gg_trg_WAR66JBZB3, Condition(function Trig_WAR66JBZB3Conditions))
call TriggerAddAction(gg_trg_WAR66JBZB3, function Trig_WAR66JBZB3Actions)
call DisableTrigger( gg_trg_WAR66JBZB5)
call TriggerAddAction(gg_trg_WAR66JBZB5, function Trig_WAR66JBZB5Actions)
call TriggerAddAction(gg_trg_WAR66JBZB7, function Trig_WAR66JBZB7Actions)
call TriggerAddCondition(gg_trg_WAR66JBZB8, Condition(function Trig_WAR66JBZB88))
call TriggerAddAction(gg_trg_WAR66JBZB8, function Trig_WAR66JBZB8Actions)
call TriggerAddCondition(gg_trg_WAR66JBZB9, Condition(function Trig_WAR66JBZB99))
call TriggerAddAction(gg_trg_WAR66JBZB9, function Trig_WAR66JBZB9Actions)
call TriggerAddCondition(gg_trg_WAR66JBZB10, Condition(function Trig_WAR66JBZB10Conditions))
call TriggerAddAction(gg_trg_WAR66JBZB10, function Trig_WAR66JBZB10Actions)
call TriggerAddAction(gg_trg_WAR66KQZBJB1, function WAR66KQZBJB11)
call TriggerAddAction(gg_trg_WAR66JBZB12, function Trig_WAR66JBZB122)
call TriggerAddAction(gg_trg_WAR66JBZB13, function Trig_WAR66JBZB123)
call TriggerAddAction(gg_trg_WAR66JBZB20, function Trig_WAR66JBZB20Actions)
call TriggerAddAction(gg_trg_WAR66JBZB21, function Trig_WAR66JBZB21Actions)
loop
exitwhen (i > 60)
set udg_WAR66DHK[i] = DialogCreate()
set i = i + 1
endloop
set udg_WAR66BBH = ""
set i = 0
loop
exitwhen (i > 1)
set udg_WAR66TURN[i] = false
set udg_WAR66WCD[i] = false
set udg_WAR66PMS[i] = false
set udg_WAR66WXFH[i] = false
set udg_WAR66AS[i] = false
set udg_WAR66JSX[i] = false
set udg_WAR66QHBB[i] = false
set udg_WAR66KQZB[i] = false
set udg_WAR66KQSBB[i] = false
set i = i + 1
endloop
endfunction