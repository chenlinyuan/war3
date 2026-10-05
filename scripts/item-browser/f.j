//============================================================================
// ITEM BROWSER - 装备搜索与添加系统
// 作者: chenlinyuan (war3 mod 项目)
// 功能:
//   输入 "search <关键词>"  搜索名称包含关键词的装备
//   输入 "additem <名称>"   添加装备给当前选中的英雄（背包满则掉地上）
//   输入 "additem <名称> n" 添加 n 个
//   输入 "itembrowser"      显示帮助
//
// 说明:
//   - 地图启动后自动枚举所有物品类型（约 2-3 分钟，视电脑性能）
//   - 枚举完成后屏幕提示 "装备列表加载完成"
//   - 支持中文名称匹配
//============================================================================

//---------------------------------------------------------------------------
// [工具] 去除颜色代码 |cXXXXXXXX 和 |r
//---------------------------------------------------------------------------
function IB_StripColorCodes takes string s returns string
    local integer len = StringLength(s)
    local integer i = 0
    local string result = ""
    local string ch
    loop
        exitwhen i >= len
        set ch = SubString(s, i, i + 1)
        if ch == "|" then
            if SubString(s, i + 1, i + 2) == "c" or SubString(s, i + 1, i + 2) == "C" then
                set i = i + 9
            elseif SubString(s, i + 1, i + 2) == "r" or SubString(s, i + 1, i + 2) == "R" then
                set i = i + 1
            else
                set result = result + ch
                set i = i + 1
            endif
        else
            set result = result + ch
            set i = i + 1
        endif
    endloop
    return result
endfunction

//---------------------------------------------------------------------------
// [工具] 字符串不区分大小写比较
//---------------------------------------------------------------------------
function IB_StrEqCI takes string a, string b returns boolean
    return StringCase(a, false) == StringCase(b, false)
endfunction

//---------------------------------------------------------------------------
// [工具] 发送消息给玩家
//---------------------------------------------------------------------------
function IB_Message takes player p, string msg returns nothing
    call DisplayTimedTextToPlayer(p, 0, 0, 15.0, "|cff00ff00[装备]|r " + msg)
endfunction

//---------------------------------------------------------------------------
// [工具] 判断物品名称是否包含关键词
//---------------------------------------------------------------------------
function IB_IsItemMatch takes integer itemId, string keyword returns boolean
    local string name = IB_StripColorCodes(GetObjectName(itemId))
    local integer nameLen = StringLength(name)
    local integer keyLen = StringLength(keyword)
    local integer i = 0
    local integer j
    local boolean matched

    if keyLen == 0 then
        return true
    endif
    if keyLen > nameLen then
        return false
    endif

    loop
        exitwhen i + keyLen > nameLen
        set j = 0
        set matched = true
        loop
            exitwhen j >= keyLen
            if SubString(name, i + j, i + j + 1) != SubString(keyword, j, j + 1) then
                set matched = false
                set j = keyLen
            endif
            set j = j + 1
        endloop
        if matched then
            return true
        endif
        set i = i + 1
    endloop
    return false
endfunction

//---------------------------------------------------------------------------
// [工具] 获取玩家当前选中的第一个单位
//---------------------------------------------------------------------------
function IB_GetSelectedUnit takes player p returns unit
    local group g = CreateGroup()
    local unit u
    call GroupEnumUnitsSelected(g, p, null)
    set u = FirstOfGroup(g)
    call DestroyGroup(g)
    set g = null
    return u
endfunction

//---------------------------------------------------------------------------
// 搜索装备
//---------------------------------------------------------------------------
function IB_Search takes player p, string keyword returns nothing
    local integer i = 0
    local integer found = 0
    local string name

    call IB_Message(p, "搜索 \"" + keyword + "\" ...")

    loop
        exitwhen i >= ib_itemCount
        if IB_IsItemMatch(ib_itemList[i], keyword) then
            set name = IB_StripColorCodes(GetObjectName(ib_itemList[i]))
            set found = found + 1
            if found <= 20 then
                call DisplayTimedTextToPlayer(p, 0, 0, 20.0, "  |cffffcc00" + I2S(found) + ".|r " + name)
            endif
        endif
        set i = i + 1
    endloop

    if found == 0 then
        call IB_Message(p, "未找到包含 \"" + keyword + "\" 的装备")
    elseif found > 20 then
        call IB_Message(p, "共找到 " + I2S(found) + " 件，仅显示前 20 件")
    else
        call IB_Message(p, "共找到 " + I2S(found) + " 件装备")
    endif
endfunction

//---------------------------------------------------------------------------
// 添加装备（精确匹配名称）
//---------------------------------------------------------------------------
function IB_AddItem takes player p, string itemName, integer count returns nothing
    local integer i = 0
    local integer added = 0
    local unit u
    local item it
    local real x
    local real y
    local string name

    if count < 1 then
        set count = 1
    endif

    set u = IB_GetSelectedUnit(p)
    if u == null then
        call IB_Message(p, "请先选中一个英雄/单位")
        return
    endif

    set x = GetUnitX(u)
    set y = GetUnitY(u)

    loop
        exitwhen i >= ib_itemCount or added >= count
        set name = IB_StripColorCodes(GetObjectName(ib_itemList[i]))
        if name == itemName then
            set it = CreateItem(ib_itemList[i], x, y)
            if it != null then
                if not UnitAddItem(u, it) then
                    call SetItemPosition(it, x, y)
                endif
                set added = added + 1
            endif
            set it = null
        endif
        set i = i + 1
    endloop

    if added == 0 then
        call IB_Message(p, "未找到装备 \"" + itemName + "\"")
    else
        call IB_Message(p, "已添加 " + I2S(added) + " 个 \"" + itemName + "\"")
    endif
    set u = null
endfunction

//---------------------------------------------------------------------------
// 解析 additem 参数："名称" 或 "名称 数量"
//---------------------------------------------------------------------------
function IB_ParseAddItem takes player p, string arg returns nothing
    local integer len = StringLength(arg)
    local integer i = len
    local integer lastSpace = -1
    local string itemName
    local string numStr
    local integer count = 1
    local boolean isNum
    local string ch

    loop
        exitwhen i <= 0
        if SubString(arg, i - 1, i) == " " then
            set lastSpace = i - 1
            set i = 0
        endif
        set i = i - 1
    endloop

    if lastSpace > 0 then
        set numStr = SubString(arg, lastSpace + 1, len)
        set isNum = StringLength(numStr) > 0
        set i = 0
        loop
            exitwhen i >= StringLength(numStr)
            set ch = SubString(numStr, i, i + 1)
            if ch == "0" or ch == "1" or ch == "2" or ch == "3" or ch == "4" or ch == "5" or ch == "6" or ch == "7" or ch == "8" or ch == "9" then
                // 数字
            else
                set isNum = false
                set i = StringLength(numStr)
            endif
            set i = i + 1
        endloop
        if isNum then
            set itemName = SubString(arg, 0, lastSpace)
            set count = S2I(numStr)
        else
            set itemName = arg
        endif
    else
        set itemName = arg
    endif

    call IB_AddItem(p, itemName, count)
endfunction

//---------------------------------------------------------------------------
// 解析聊天命令
//---------------------------------------------------------------------------
function IB_OnChat takes nothing returns boolean
    local string s = GetEventPlayerChatString()
    local player p = GetTriggerPlayer()
    local integer len = StringLength(s)
    local string cmd
    local string arg
    local integer spacePos = -1
    local integer i = 0

    loop
        exitwhen i >= len
        if SubString(s, i, i + 1) == " " then
            set spacePos = i
            set i = len
        endif
        set i = i + 1
    endloop

    if spacePos == -1 then
        set cmd = s
        set arg = ""
    else
        set cmd = SubString(s, 0, spacePos)
        set arg = SubString(s, spacePos + 1, len)
    endif

    if IB_StrEqCI(cmd, "search") then
        call IB_Search(p, arg)
    elseif IB_StrEqCI(cmd, "additem") then
        call IB_ParseAddItem(p, arg)
    elseif IB_StrEqCI(cmd, "itembrowser") then
        call IB_Message(p, "装备系统就绪，共 " + I2S(ib_itemCount) + " 件装备")
        call IB_Message(p, "search <关键词>  搜索装备")
        call IB_Message(p, "additem <名称> [数量]  添加装备")
    endif
    return false
endfunction

//---------------------------------------------------------------------------
// 注册聊天事件
//---------------------------------------------------------------------------
function IB_RegisterChat takes nothing returns nothing
    local integer i = 0
    local trigger t = CreateTrigger()
    loop
        exitwhen i > 11
        call TriggerRegisterPlayerChatEvent(t, Player(i), "", false)
        set i = i + 1
    endloop
    call TriggerAddCondition(t, Condition(function IB_OnChat))
    set t = null
endfunction

//---------------------------------------------------------------------------
// 物品列表初始化
//---------------------------------------------------------------------------
function IB_InitItemCharMap takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen i >= 62
        if i <= 9 then
            set ib_charMap[i] = i + 48
        elseif i <= 35 then
            set ib_charMap[i] = i + 55
        else
            set ib_charMap[i] = i + 61
        endif
        set i = i + 1
    endloop
endfunction

function IB_EnumD takes nothing returns nothing
    local integer i = 0
    local item it
    loop
        set it = CreateItem(ib_idA + ib_idB + ib_idC + ib_charMap[i], 0, 0)
        if it != null then
            set ib_itemList[ib_itemCount] = GetItemTypeId(it)
            set ib_itemCount = ib_itemCount + 1
        endif
        call RemoveItem(it)
        exitwhen i == 61
        set i = i + 1
    endloop
    set it = null
endfunction

function IB_EnumC takes nothing returns nothing
    set ib_idC = 256 * ib_charMap[ib_iC]
    set ib_iC = ib_iC + 1
    if ib_iC == 62 then
        call PauseTimer(ib_timerC)
        call DestroyTimer(ib_timerC)
        set ib_iC = 0
    endif
    call IB_EnumD()
endfunction

function IB_EnumB takes nothing returns nothing
    set ib_idB = 256 * 256 * ib_charMap[ib_iB]
    set ib_iB = ib_iB + 1
    if ib_iB == 62 then
        call PauseTimer(ib_timerB)
        call DestroyTimer(ib_timerB)
        set ib_iB = 0
    endif
    set ib_timerC = CreateTimer()
    call TimerStart(ib_timerC, 0.0005, true, function IB_EnumC)
endfunction

function IB_EnumA takes nothing returns nothing
    set ib_idA = 256 * 256 * 256 * ib_charMap[ib_iA]
    set ib_iA = ib_iA + 1
    if ib_iA == 62 then
        call PauseTimer(ib_timerA)
        call DestroyTimer(ib_timerA)
        set ib_iA = 0
        call IB_Message(GetLocalPlayer(), "装备列表加载完成，共 " + I2S(ib_itemCount) + " 件")
        call IB_RegisterChat()
    endif
    set ib_timerB = CreateTimer()
    call TimerStart(ib_timerB, 0.0322, true, function IB_EnumB)
endfunction

//---------------------------------------------------------------------------
// 入口
//---------------------------------------------------------------------------
function IB_Init takes nothing returns nothing
    call IB_InitItemCharMap()
    set ib_iA = 0
    set ib_iB = 0
    set ib_iC = 0
    set ib_itemCount = 0
    set ib_timerA = CreateTimer()
    call TimerStart(ib_timerA, 2.0, true, function IB_EnumA)
endfunction
