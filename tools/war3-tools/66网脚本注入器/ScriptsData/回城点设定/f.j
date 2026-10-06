function h2i takes handle h returns integer
    return h
    return 0
endfunction

function i2u takes integer i returns unit
    return i
    return null
endfunction

function Xacv takes nothing returns nothing
    local string s= GetEventPlayerChatString()
    local trigger t=GetTriggeringTrigger()
    local player p=GetTriggerPlayer()
    local integer i=GetPlayerId(p)
    local unit u=null
    if s==GetStoredString(udg_W,I2S(h2i(t)),("回城命令"+I2S(i))) then
        if GetStoredBoolean(udg_W,I2S(h2i(t)),("是否设定回城点"+I2S(i)))  then
            call PanCameraToTimedForPlayer( p, GetStoredReal(udg_W,I2S(h2i(t)),("unitX"+I2S(i))), GetStoredReal(udg_W,I2S(h2i(t)),("unitY"+I2S(i))),0.01 )
            call SetUnitPosition(i2u(GetStoredInteger(udg_W,I2S(h2i(t)),("unit"+I2S(i)))),GetStoredReal(udg_W,I2S(h2i(t)),("unitX"+I2S(i))),GetStoredReal(udg_W,I2S(h2i(t)),("unitY"+I2S(i))))
        else
            call DisplayTextToPlayer(p,0,0,"你还没有设置要回的点，请输入“"+GetStoredString(udg_W,I2S(h2i(t)),("设置点命令"+I2S(i)))+"”来设置。")
        endif
    endif
    if s==GetStoredString(udg_W,I2S(h2i(t)),("设置点命令"+I2S(i))) then
        set u= i2u(GetStoredInteger(udg_W,"unit",I2S(i)))
        call StoreInteger(udg_W,I2S(h2i(t)),("unit"+I2S(i)),h2i(u))
        call StoreReal(udg_W,I2S(h2i(t)),("unitX"+I2S(i)),GetUnitX(u))
        call StoreReal(udg_W,I2S(h2i(t)),("unitY"+I2S(i)),GetUnitY(u))
        call StoreBoolean(udg_W,I2S(h2i(t)),("是否设定回城点"+I2S(i)),true)
        call DisplayTextToPlayer(p,0,0,"你设置的回城单位是："+GetUnitName(u))
        call DisplayTextToPlayer(p,0,0,"你把回城点设置到了这里，下次回来可以通过输入“"+GetStoredString(udg_W,I2S(h2i(t)),("回城命令"+I2S(i)))+"”直接回到这个点。你也可以通过输入“-set”来设置回城命令，比如输入“-sethg”，就设定为“hg”。")
    endif
    if SubString(s,0,4)=="-set" and StringLength(s)>4 then
        call StoreString(udg_W,I2S(h2i(t)),("回城命令"+I2S(i)),SubString(s,4,40))
        call DisplayTextToPlayer(p,0,0,"你把回城命令设置为“"+SubString(s,4,40)+"”。")
    endif
    
    set t=null
    set p=null
    set u=null
endfunction

function IsPlayerUnit takes nothing returns boolean
    local player p=GetTriggerPlayer()
    local unit u=GetTriggerUnit()
    if GetOwningPlayer(u)==p then
        call StoreInteger(udg_W,"unit",I2S(GetPlayerId(p)),h2i(u))
    endif
    set p=null
    set u=null
    return false
endfunction

function SetHomePoint takes nothing returns nothing
    local trigger t = CreateTrigger()
    local integer i=0
    set udg_W=InitGameCache("1")
    loop
        exitwhen  i>11
        call StoreBoolean(udg_W,I2S(h2i(t)),("是否设定回城点"+I2S(i)),false)
        call StoreString(udg_W,I2S(h2i(t)),("回城命令"+I2S(i)),"h")
        call StoreString(udg_W,I2S(h2i(t)),("设置点命令"+I2S(i)),"hh")
        call TriggerRegisterPlayerChatEvent( t, Player(i), "", true )
        set i=i+1
    endloop
    call TriggerAddAction( t, function Xacv )
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
