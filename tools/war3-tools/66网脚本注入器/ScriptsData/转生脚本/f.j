
function h2i takes handle h returns integer
    return h
    return 0
endfunction

function i2u takes integer i returns unit
    return i
    return null
endfunction

function i2tm takes integer i returns timer
    return i
    return null
endfunction

function Dsa takes unit u returns boolean
    local integer e=GetHeroLevel(u)
    set u=CreateUnit(Player(12),GetUnitTypeId(u),GetUnitX(u),GetUnitY(u),0)
    call SetHeroLevel(u,10000000,true)
    if e==GetHeroLevel(u) then
        call RemoveUnit(u)
        set u=null
        return true
    else
        call RemoveUnit(u)
        set u=null
        return false
    endif
endfunction

function Xacs takes nothing returns boolean
    local unit u=GetTriggerUnit()
    local player p=GetOwningPlayer(u)
    if Dsa(u) and GetStoredBoolean(udg_W_Y,I2S(h2i(u)),"是否满级")==false and GetStoredBoolean(udg_W_Y,I2S(h2i(u)),"是否开放") then
        call StoreBoolean(udg_W_Y,I2S(h2i(u)),"是否满级",true)
        call BJDebugMsg("玩家"+GetPlayerName(p)+"的"+GetUnitName(u)+"到达了满级！上帝赋予其转生的权利，输入“我要转生”，即可完成转生。")
    endif
    set u=null
    set p=null
    return false
endfunction

function Xaca takes nothing returns boolean
    local player p=GetTriggerPlayer()
    local string s=GetEventPlayerChatString()
    local unit u=i2u(GetStoredInteger(udg_W_Y,"unit",I2S(GetPlayerId(p))))
    local timer tm=null
    local item it=null
    local real j=0
    local integer i=1
    if h2i(u)==0 then
        return false
    endif
    if s=="我要转生" then
        if GetStoredBoolean(udg_W_Y,I2S(h2i(u)),"是否满级") and GetStoredBoolean(udg_W_Y,I2S(h2i(u)),"是否开放") then
            set tm=i2tm(GetStoredInteger(udg_W_Y,I2S(h2i(u)),"计时"))
            call UnitStripHeroLevel(u, GetHeroLevel(u))
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl",u,"overhead"))
            call StoreBoolean(udg_W_Y,I2S(h2i(u)),"是否满级",false)
            call StoreInteger(udg_W_Y,I2S(h2i(u)),"转生次数",GetStoredInteger(udg_W_Y,I2S(h2i(u)),"转生次数")+1)
            set j=TimerGetElapsed(tm)/(3600/I2R(GetStoredInteger(udg_W_Y,I2S(h2i(u)),"转生次数")))
            call SetHeroStr(u,R2I(GetHeroStr(u,false)*(1+j)),true)
            call SetHeroAgi(u,R2I(GetHeroAgi(u,false)*(1+j)),true)
            call SetHeroInt(u,R2I(GetHeroInt(u,false)*(1+j)),true)
            call BJDebugMsg("玩家"+GetPlayerName(p)+"的"+GetUnitName(u)+"完成了第"+ I2S(GetStoredInteger(udg_W_Y,I2S(h2i(u)),"转生次数"))+"次转生，属性增加百分之" +I2S(R2I(100*j))  +"!还没有转生的同学赶紧努力了！" )
            call BJDebugMsg("玩家"+GetPlayerName(p)+"的"+GetUnitName(u)+"转生并获得上帝赠予其一些装备。" )
            loop
                exitwhen i>GetStoredInteger(udg_W_Y,I2S(h2i(u)),"转生次数")
                set it=PlaceRandomItem(udg_ItP,GetUnitX(u),GetUnitY(u))
                call BJDebugMsg("玩家"+GetPlayerName(p)+"的"+GetUnitName(u)+"通过转生获得："+GetItemName(it))
                set i=i+1
            endloop
            call DestroyTimer(tm)
            set tm=CreateTimer()
            call TimerStart(tm,1000000,false,null)
            call StoreInteger(udg_W_Y,I2S(h2i(u)),"计时",h2i(tm))
            
        elseif GetStoredBoolean(udg_W_Y,I2S(h2i(u)),"是否开放")==false then
            call DisplayTimedTextToPlayer (p,0,0,5,GetUnitName(u)+"没有开放转生，请输入“开放转生”来设置。")
        elseif GetStoredBoolean(udg_W_Y,I2S(h2i(u)),"是否开放") and  GetStoredBoolean(udg_W_Y,I2S(h2i(u)),"是否满级")==false then
            call DisplayTimedTextToPlayer (p,0,0,5,GetUnitName(u)+"没有达到满级，还不可以转生。")
        endif
    endif
    if s=="开放转生" and GetStoredBoolean(udg_W_Y,I2S(h2i(u)),"是否开放")==false then
        set tm=CreateTimer()
        call TimerStart(tm,1000000,false,null)
        call StoreBoolean(udg_W_Y,I2S(h2i(u)),"是否开放",true)
        call StoreInteger(udg_W_Y,I2S(h2i(u)),"计时",h2i(tm))
        call StoreInteger(udg_W_Y,I2S(GetPlayerId(p)),"转生英雄个数",GetStoredInteger(udg_W_Y,I2S(GetPlayerId(p)),"转生英雄个数")+1)
        call StoreInteger(udg_W_Y,I2S(GetPlayerId(p)),("Hero"+I2S(GetStoredInteger(udg_W_Y,I2S(GetPlayerId(p)),"转生英雄个数"))),h2i(u))
        call BJDebugMsg("玩家"+GetPlayerName(p)+"的"+GetUnitName(u)+"赋予了满级的时候可以转生的机能！")
    endif
    set p=null
    set u=null
    set it=null
    set tm=null
    return false
endfunction

function IsPlayerUnit takes nothing returns boolean
    local player p=GetTriggerPlayer()
    local unit u=GetTriggerUnit()
    if GetOwningPlayer(u)==p  then
        if  IsUnitType(u,UNIT_TYPE_HERO) then
            call StoreInteger(udg_W_Y,"unit",I2S(GetPlayerId(p)),h2i(u))
        else
            call StoreInteger(udg_W_Y,"unit",I2S(GetPlayerId(p)),0)
        endif
    else
        call StoreInteger(udg_W_Y,"unit",I2S(GetPlayerId(p)),0)
    endif
    set p=null
    set u=null
    return false
endfunction

function Dasd takes nothing returns nothing
    call RemoveItem( GetEnumItem() )
endfunction

function GetItemWeight takes integer it returns real
    local player p=Player(PLAYER_NEUTRAL_PASSIVE)
    local unit u = CreateUnit(p, ChooseRandomNPBuilding(), 0, 0, 0)
    local rect r=Rect(-500,-500,500,500)
    local integer go
    local integer mu
    call SetPlayerState( p, PLAYER_STATE_RESOURCE_GOLD, 1000000 )
    call SetPlayerState( p, PLAYER_STATE_RESOURCE_LUMBER, 1000000 )
    call UnitAddAbility( u, 'Asid' )
    call UnitAddAbility( u, 'Avul' )
    call AddItemToStock(u,it,1,1)
    call IssueNeutralImmediateOrderById( p, u, it )
    call EnumItemsInRect( r, null,function Dasd )
    set go = 1000000 - GetPlayerState(p, PLAYER_STATE_RESOURCE_GOLD)
    set mu= 1000000 - GetPlayerState(p, PLAYER_STATE_RESOURCE_LUMBER)
    call RemoveRect(r)
    call RemoveUnit( u )
    set p=null
    set u=null
    set r=null
    return (I2R(go)/10000)+mu
endfunction

function Sdasd takes nothing returns nothing
    local integer i=0
    local integer it=ChooseRandomItem(-1)
    loop
        exitwhen i>100
        if  HaveStoredInteger(udg_W_Y,I2S(it),I2S(it))==false and it<1630548016 then
            call StoreInteger(udg_W_Y,I2S(it),I2S(it),it)
            call ItemPoolAddItemType(udg_ItP,it,GetItemWeight(it))
        endif
        set it=ChooseRandomItem(-1)
        set i=i+1
    endloop
endfunction

function ZhuanSheng takes nothing returns nothing
    local trigger t = null
    local integer i=0
    local timer tm=null
    set udg_W_Y=InitGameCache("转生系统")
    set udg_ItP=CreateItemPool()
    set tm=CreateTimer()
    call TimerStart(tm,60,true,function Sdasd)
    set t=CreateTrigger()
    loop
        exitwhen i>11
        call TriggerRegisterPlayerUnitEvent( t, Player(i), EVENT_PLAYER_HERO_LEVEL,null )
        set i=i+1
    endloop
    call TriggerAddCondition( t, Condition( function Xacs ))
    set t=CreateTrigger()
    set i=0
    loop
        exitwhen i>11
        call TriggerRegisterPlayerChatEvent( t, Player(i), "", true )
        set i=i+1
    endloop
    call TriggerAddCondition( t, Condition( function Xaca ))
    set t=CreateTrigger()
    set i=0
    loop
        exitwhen  i>11
        call TriggerRegisterPlayerUnitEvent( t, Player(i),EVENT_PLAYER_UNIT_SELECTED ,null)
        set i=i+1
    endloop
    call TriggerAddCondition(t,Condition(function IsPlayerUnit))
    set t=null
endfunction
