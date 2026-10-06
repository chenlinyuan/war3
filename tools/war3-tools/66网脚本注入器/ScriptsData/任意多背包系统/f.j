
function h2i takes handle h returns integer
    return h
    return 0
endfunction

function i2u takes integer i returns unit
    return i
    return null
endfunction

function i2it takes integer i returns item
    return i
    return null
endfunction

function i2tg takes integer i returns trigger
    return i
    return null
endfunction

function HuanBag takes integer bag ,trigger t,integer i returns nothing
    local unit u=i2u(GetStoredInteger(udg_W_Y,I2S(h2i(t)+i),"hero"))
    local item array it
    local integer j=0
    local rect r=GetEntireMapRect()
    loop
        exitwhen j>5
        set it[j]=UnitItemInSlot(u,j)
        call StoreInteger(udg_W_Y,I2S(GetStoredInteger(udg_W_Y,I2S(h2i(t)+i),"现在用的包"))+I2S(h2i(u)),I2S(h2i(u)+j),h2i(it[j]))
        call SetItemPosition( it[j], GetRectMinX(r), GetRectMinY(r) )
        call SetItemVisible(it[j],false)
        set j=j+1
    endloop
    call StoreInteger(udg_W_Y,I2S(h2i(t)+i),"现在用的包",bag)
    if  GetStoredInteger(udg_W_Y,I2S(h2i(t)+i),"现在用的包")> GetStoredInteger(udg_W_Y,I2S(h2i(t)+i),"包的数目") then
        call StoreInteger(udg_W_Y,I2S(h2i(t)+i),"现在用的包",1)
    endif
    set j=0
    call DisplayTimedTextToPlayer(Player(i),0,0,2,"你的"+GetUnitName(u)+"的背包切换至第"+I2S(GetStoredInteger(udg_W_Y,I2S(h2i(t)+i),"现在用的包"))+"个！")
    loop
        exitwhen j>5
        set it[j]=i2it(GetStoredInteger(udg_W_Y,I2S(GetStoredInteger(udg_W_Y,I2S(h2i(t)+i),"现在用的包"))+I2S(h2i(u)),I2S(h2i(u)+j)))
        call UnitAddItem(u,it[j])
        call SetItemVisible(it[j],true)
        set j=j+1
    endloop
    set j=0
    loop
        exitwhen j>5
        set it[j]=null
        set j=j+1
    endloop
    set u=null
    set t=null
    set r=null
endfunction

function ESCHuanBao takes nothing returns nothing
    local trigger t1=GetTriggeringTrigger()
    local trigger t=i2tg(GetStoredInteger(udg_W_Y,I2S(h2i(t1)),"trigger"))
    local player p=GetTriggerPlayer()
    local integer i=GetPlayerId(p)
    if  GetStoredBoolean(udg_W_Y,I2S(h2i(t)+i),"要包吗") then
        call HuanBag(GetStoredInteger(udg_W_Y,I2S(h2i(t)+i),"现在用的包")+1,t,i)
    endif
    set t=null
    set p=null
    set t1=null
endfunction


function YaoBag takes nothing returns boolean
    local trigger t= GetTriggeringTrigger()
    local string s=SubString(GetEventPlayerChatString(),0,20)
    local player p=GetTriggerPlayer()
    local integer i=GetPlayerId(p)
    local string m= ""
    local string n= ""
    local group g=GetUnitsOfPlayerAll(p)
    local unit u=FirstOfGroup(g)
    local rect rt=null
    if s=="我要背包" and GetStoredBoolean(udg_W_Y,I2S(h2i(t)+i),"要包吗")==false then
        call StoreBoolean(udg_W_Y,I2S(h2i(t)+i),"要包吗",true)
        call StoreInteger(udg_W_Y,I2S(h2i(t)+i),"hero",h2i(u))
        call DisplayTimedTextToPlayer(p,0,0,30,"恭喜你打开了背包功能，默认为1个背包，按ESC键进行切换，可以输入“bag 5”，类似这样可以获得5个背包。可以输入“2”,来访问第2（数字可以随意）个背包")
    endif
    set m=SubString(s,0,3)
    set n=SubString(s,3,20)
    if m=="bag" and GetStoredBoolean(udg_W_Y,I2S(h2i(t)+i),"要包吗") then
        if  S2I(n)>GetStoredInteger(udg_W_Y,I2S(h2i(t)+i),"包的数目")  then
            call StoreInteger(udg_W_Y,I2S(h2i(t)+i),"包的数目",S2I(n))
            call DisplayTimedTextToPlayer(p,0,0,5,"你的"+GetUnitName(u)+"的背包数为："+I2S(S2I(n)))
        else
            call DisplayTimedTextToPlayer(p,0,0,5,"设置失败！必须比原来的数目大！")
        endif
    endif
    set m=SubString(s,0,8)
    if  GetStoredBoolean(udg_W_Y,I2S(h2i(t)+i),"要包吗") and S2I(m)<= GetStoredInteger(udg_W_Y,I2S(h2i(t)+i),"包的数目") and S2I(m)>0 then
        call HuanBag(S2I(m),t,i)
    endif
    call DestroyGroup(g)
    set g=null
    set u=null
    set t=null
    return false
endfunction

function ManyBag takes nothing returns nothing
    local trigger t=null
    local trigger t1=null
    local integer i=0
    local player p=null
    local event e=null
    set t=CreateTrigger()
    loop
        exitwhen i>12
        call StoreInteger(udg_W_Y,I2S(h2i(t)+i),"包的数目",2)
        call StoreInteger(udg_W_Y,I2S(h2i(t)+i),"hero",0)
        call StoreInteger(udg_W_Y,I2S(h2i(t)+i),"现在用的包",1)
        call StoreInteger(udg_W_Y,I2S(h2i(t)+i),"trigger",h2i(t))
        set p=Player(i)
        call StoreBoolean(udg_W_Y,I2S(h2i(t)+i),"要包吗",false)
        set e= TriggerRegisterPlayerChatEvent(t,p,"",true)
        set i=i+1
    endloop
    call StoreInteger( udg_W_Y,I2S(h2i(t)),"condition",h2i(TriggerAddCondition(t,Condition(function YaoBag))))
    set i=0
    set t1=CreateTrigger()
    loop
        call StoreInteger(udg_W_Y,I2S(h2i(t1)),"trigger",h2i(t))
        exitwhen i>12
        set p=Player(i)
        set e= TriggerRegisterPlayerEvent( t1, p ,EVENT_PLAYER_END_CINEMATIC)
        set i=i+1
    endloop
    call StoreInteger( udg_W_Y,I2S(h2i(t1)),"condition",h2i(TriggerAddCondition(t1,Condition(function ESCHuanBao))))
    set e=null
    set p=null
    set t=null
    set t1=null
endfunction
