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
//   - 物品 ID 列表在注入时预先扫描并硬编码，进游戏立即可用（无需枚举）
//   - 支持中文名称匹配（不区分大小写）
//============================================================================

//---------------------------------------------------------------------------
// [工具] ASCII 转小写（仅处理 A-Z，不动中文等多字节字符）
// 注意：不能用 StringCase，它会把 GBK 中文字节也改写导致乱码
//---------------------------------------------------------------------------
function IB_LowerAscii takes string s returns string
    local integer len = StringLength(s)
    local integer i = 0
    local string result = ""
    local string ch
    loop
        exitwhen i >= len
        set ch = SubString(s, i, i + 1)
        if ch == "A" then
            set ch = "a"
        elseif ch == "B" then
            set ch = "b"
        elseif ch == "C" then
            set ch = "c"
        elseif ch == "D" then
            set ch = "d"
        elseif ch == "E" then
            set ch = "e"
        elseif ch == "F" then
            set ch = "f"
        elseif ch == "G" then
            set ch = "g"
        elseif ch == "H" then
            set ch = "h"
        elseif ch == "I" then
            set ch = "i"
        elseif ch == "J" then
            set ch = "j"
        elseif ch == "K" then
            set ch = "k"
        elseif ch == "L" then
            set ch = "l"
        elseif ch == "M" then
            set ch = "m"
        elseif ch == "N" then
            set ch = "n"
        elseif ch == "O" then
            set ch = "o"
        elseif ch == "P" then
            set ch = "p"
        elseif ch == "Q" then
            set ch = "q"
        elseif ch == "R" then
            set ch = "r"
        elseif ch == "S" then
            set ch = "s"
        elseif ch == "T" then
            set ch = "t"
        elseif ch == "U" then
            set ch = "u"
        elseif ch == "V" then
            set ch = "v"
        elseif ch == "W" then
            set ch = "w"
        elseif ch == "X" then
            set ch = "x"
        elseif ch == "Y" then
            set ch = "y"
        elseif ch == "Z" then
            set ch = "z"
        endif
        set result = result + ch
        set i = i + 1
    endloop
    return result
endfunction

//---------------------------------------------------------------------------
// [工具] 字符串不区分大小写比较（仅 ASCII 转小写，不动中文）
//---------------------------------------------------------------------------
function IB_StrEqCI takes string a, string b returns boolean
    return IB_LowerAscii(a) == IB_LowerAscii(b)
endfunction

//---------------------------------------------------------------------------
// [工具] 发送消息给玩家
//---------------------------------------------------------------------------
function IB_Message takes player p, string msg returns nothing
    call DisplayTimedTextToPlayer(p, 0, 0, 15.0, "|cff00ff00[装备]|r " + msg)
endfunction

//---------------------------------------------------------------------------
// [工具] 布尔转字符串（诊断用）
//---------------------------------------------------------------------------
function IB_BoolStr takes boolean b returns string
    if b then
        return "true"
    endif
    return "false"
endfunction

//---------------------------------------------------------------------------
// [工具] 获取物品显示名：直接返回预扫描名称（已去颜色码）
//---------------------------------------------------------------------------
function IB_ItemName takes integer index returns string
    return ib_itemName[index]
endfunction

//---------------------------------------------------------------------------
// [工具] 单个字节 -> 字符（可打印 ASCII 原样，否则 .）
//---------------------------------------------------------------------------
function IB_Char takes integer c returns string
    if c >= 32 and c <= 126 then
        return SubString(" !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~", c - 32, c - 31)
    endif
    return "."
endfunction

//---------------------------------------------------------------------------
// [工具] 把物品 ID（FourCC 整数）转成 4 字符字符串，用于区分同名物品
//---------------------------------------------------------------------------
function IB_IdStr takes integer id returns string
    local integer b0 = id - (id / 256) * 256
    local integer b1 = (id / 256) - (id / 65536) * 256
    local integer b2 = (id / 65536) - (id / 16777216) * 256
    local integer b3 = id / 16777216
    return IB_Char(b3) + IB_Char(b2) + IB_Char(b1) + IB_Char(b0)
endfunction

//---------------------------------------------------------------------------
// [工具] 判断名称是否包含关键词（逐字节直接比较，不做任何字符串重建）
// 预扫描时名称已去颜色码并转小写；此处只对 keyword 做 ASCII 转小写。
//---------------------------------------------------------------------------
function IB_NameMatch takes string name, string keyword returns boolean
    local string key = IB_LowerAscii(keyword)
    local integer nameLen = StringLength(name)
    local integer keyLen = StringLength(key)
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
            if SubString(name, i + j, i + j + 1) != SubString(key, j, j + 1) then
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
// 搜索装备（分帧扫描：每帧处理 40 项，原版/自定义分开显示）
//---------------------------------------------------------------------------
function IB_SearchStep takes nothing returns nothing
    local integer n = 0
    local string name
    loop
        exitwhen ib_searchIdx >= ib_itemCount or n >= 40
        if IB_NameMatch(IB_ItemName(ib_searchIdx), ib_searchKey) then
            set ib_searchFound = ib_searchFound + 1
            set name = IB_ItemName(ib_searchIdx) + "[" + IB_IdStr(ib_itemList[ib_searchIdx]) + "]"
            if ib_itemCustom[ib_searchIdx] == 1 then
                set ib_searchCusN = ib_searchCusN + 1
                if ib_searchCusN <= 15 then
                    set ib_searchCus = ib_searchCus + name + "  "
                endif
            else
                set ib_searchStdN = ib_searchStdN + 1
                if ib_searchStdN <= 15 then
                    set ib_searchStd = ib_searchStd + name + "  "
                endif
            endif
        endif
        set ib_searchIdx = ib_searchIdx + 1
        set n = n + 1
    endloop

    if ib_searchIdx >= ib_itemCount then
        call PauseTimer(ib_searchTimer)
        call DestroyTimer(ib_searchTimer)
        set ib_searchTimer = null
        if ib_searchFound == 0 then
            call IB_Message(ib_searchPlayer, "未找到包含 \"" + ib_searchKey + "\" 的装备")
        else
            call DisplayTextToPlayer(ib_searchPlayer, 0, 0, "|cff00ff00[装备]|r 共找到 " + I2S(ib_searchFound) + " 件")
            if ib_searchStdN > 0 then
                call DisplayTextToPlayer(ib_searchPlayer, 0, 0, "|cffaaaaaa原版(" + I2S(ib_searchStdN) + "):|r " + ib_searchStd)
            endif
            if ib_searchCusN > 0 then
                call DisplayTextToPlayer(ib_searchPlayer, 0, 0, "|cff00ff00自定义(" + I2S(ib_searchCusN) + "):|r " + ib_searchCus)
            endif
        endif
        set ib_searchPlayer = null
    endif
endfunction

function IB_Search takes player p, string keyword returns nothing
    call IB_Message(p, "搜索 \"" + keyword + "\" ...")
    set ib_searchIdx = 0
    set ib_searchFound = 0
    set ib_searchKey = keyword
    set ib_searchStd = ""
    set ib_searchCus = ""
    set ib_searchStdN = 0
    set ib_searchCusN = 0
    set ib_searchPlayer = p
    if ib_searchTimer != null then
        call PauseTimer(ib_searchTimer)
        call DestroyTimer(ib_searchTimer)
    endif
    set ib_searchTimer = CreateTimer()
    call TimerStart(ib_searchTimer, 0.01, true, function IB_SearchStep)
endfunction

//---------------------------------------------------------------------------
// 添加装备（分帧扫描：先精确/ID匹配，再包含匹配；避免超操作数上限）
//---------------------------------------------------------------------------
function IB_AddGive takes player p, integer itemId, integer count returns nothing
    local unit u = IB_GetSelectedUnit(p)
    local item it
    local real x
    local real y
    local integer added = 0
    if u == null then
        call IB_Message(p, "请先选中一个英雄/单位")
        return
    endif
    set x = GetUnitX(u)
    set y = GetUnitY(u)
    loop
        exitwhen added >= count
        set it = CreateItem(itemId, x, y)
        if it != null then
            if not UnitAddItem(u, it) then
                call SetItemPosition(it, x, y)
            endif
            set added = added + 1
        endif
        set it = null
    endloop
    call IB_Message(p, "已添加 " + I2S(added) + " 个 \"" + IB_ItemName(ib_addFoundIdx) + "\"")
    set u = null
endfunction

function IB_AddStep takes nothing returns nothing
    local integer n = 0
    local string name
    loop
        exitwhen ib_addIdx >= ib_itemCount or n >= 40
        set name = IB_ItemName(ib_addIdx)
        // 精确匹配 或 ID 匹配（ID 需不区分大小写，因为 ib_addName 已被转小写）
        if name == ib_addName or IB_StrEqCI(IB_IdStr(ib_itemList[ib_addIdx]), ib_addName) then
            set ib_addFoundId = ib_itemList[ib_addIdx]
            set ib_addFoundIdx = ib_addIdx
            set ib_addIdx = ib_itemCount
        elseif ib_addFoundId == 0 then
            // 记录第一个包含匹配（继续扫描以优先找精确匹配）
            if IB_NameMatch(name, ib_addName) then
                set ib_addFoundId = ib_itemList[ib_addIdx]
                set ib_addFoundIdx = ib_addIdx
            endif
        endif
        set ib_addIdx = ib_addIdx + 1
        set n = n + 1
    endloop

    if ib_addIdx >= ib_itemCount then
        call PauseTimer(ib_addTimer)
        call DestroyTimer(ib_addTimer)
        set ib_addTimer = null
        if ib_addFoundId == 0 then
            call IB_Message(ib_addPlayer, "未找到装备 \"" + ib_addName + "\"")
        else
            call IB_AddGive(ib_addPlayer, ib_addFoundId, ib_addCount)
        endif
        set ib_addPlayer = null
    endif
endfunction

function IB_AddItem takes player p, string itemName, integer count returns nothing
    if count < 1 then
        set count = 1
    endif
    set ib_addIdx = 0
    set ib_addCount = count
    set ib_addName = IB_LowerAscii(itemName)
    set ib_addFoundId = 0
    set ib_addFoundIdx = -1
    set ib_addPlayer = p
    if ib_addTimer != null then
        call PauseTimer(ib_addTimer)
        call DestroyTimer(ib_addTimer)
    endif
    set ib_addTimer = CreateTimer()
    call TimerStart(ib_addTimer, 0.01, true, function IB_AddStep)
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
// 诊断：统计匹配数（限制扫描数量，测试是否触发操作数上限）
//---------------------------------------------------------------------------
function IB_CountMatch takes player p, string keyword returns nothing
    local integer i = 0
    local integer found = 0
    local integer limit = 50
    local string out = ""
    loop
        exitwhen i >= ib_itemCount or i >= limit
        if IB_NameMatch(IB_ItemName(i), keyword) then
            set found = found + 1
            if found <= 5 then
                set out = out + I2S(i) + ":" + IB_ItemName(i) + "  "
            endif
        endif
        set i = i + 1
    endloop
    call DisplayTextToPlayer(p, 0, 0, "|cff00ff00[诊断]|r 扫描前" + I2S(limit) + "项 匹配数=" + I2S(found) + " 前5: " + out)
endfunction

//---------------------------------------------------------------------------
// 解析聊天命令
//---------------------------------------------------------------------------
function IB_OnChat takes nothing returns nothing
    local string s = GetEventPlayerChatString()
    local player p = GetTriggerPlayer()
    local integer len = StringLength(s)
    local string cmd
    local string arg
    local integer spacePos = -1
    local integer i = 0

    call DisplayTextToPlayer(p, 0, 0, "|cff00ff00[装备]|r OnChat 触发: [" + s + "]")

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
        call IB_Message(p, "search <关键词>  搜索装备（原版/自定义分开显示）")
        call IB_Message(p, "additem <名称> [数量]  添加装备")
        call IB_Message(p, "additem <物品ID>  按ID添加（区分同名，如 additem I000）")
    elseif IB_StrEqCI(cmd, "ibtest") then
        call IB_Message(p, "诊断: ib_itemCount=" + I2S(ib_itemCount))
        call IB_Message(p, "name[0]=" + IB_ItemName(0))
        call IB_Message(p, "name[273]=" + IB_ItemName(273))
        call IB_Message(p, "len(arg)=" + I2S(StringLength(arg)) + " arg=" + arg)
        call IB_Message(p, "match(arg,name273)=" + IB_BoolStr(IB_NameMatch(IB_ItemName(273), arg)))
        call IB_Message(p, "match(arg,name0)=" + IB_BoolStr(IB_NameMatch(IB_ItemName(0), arg)))
    elseif IB_StrEqCI(cmd, "ibcount") then
        call IB_Message(p, "统计 \"" + arg + "\" 匹配数...")
        call IB_CountMatch(p, arg)
    endif
endfunction

//---------------------------------------------------------------------------
// 注册聊天事件
// 用 TriggerAddAction（而非 Condition）注册：部分地图/版本下仅含 condition
// 的聊天触发器不会触发；用 action 更可靠。
//---------------------------------------------------------------------------
function IB_RegisterChat takes nothing returns nothing
    local integer i = 0
    local trigger t = CreateTrigger()
    call DisplayTextToPlayer(Player(0), 0, 0, "|cff00ff00[装备]|r RC-1 开始")
    loop
        exitwhen i > 11
        call TriggerRegisterPlayerChatEvent(t, Player(i), "test", false)
        set i = i + 1
    endloop
    call DisplayTextToPlayer(Player(0), 0, 0, "|cff00ff00[装备]|r RC-2 循环完成")
    call TriggerAddAction(t, function IB_OnChat)
    call DisplayTextToPlayer(Player(0), 0, 0, "|cff00ff00[装备]|r RC-3 AddAction完成")
    set t = null
endfunction

//---------------------------------------------------------------------------
// 入口：直接填充预扫描的物品 ID 列表，立即注册聊天事件（无需枚举）
//---------------------------------------------------------------------------
function IB_Fill0 takes nothing returns nothing
    set ib_itemList[0] = 'ckng'
    set ib_itemName[0] = "金币"
    set ib_itemCustom[0] = 0
    set ib_itemList[1] = 'modt'
    set ib_itemName[1] = "发臭了的章鱼尸体"
    set ib_itemCustom[1] = 0
    set ib_itemList[2] = 'tkno'
    set ib_itemName[2] = "修炼之书"
    set ib_itemCustom[2] = 0
    set ib_itemList[3] = 'shar'
    set ib_itemName[3] = "破箱子"
    set ib_itemCustom[3] = 0
    set ib_itemList[4] = 'sres'
    set ib_itemName[4] = "变异卷轴"
    set ib_itemCustom[4] = 0
    set ib_itemList[5] = 'rde3'
    set ib_itemName[5] = "|cff00ffff风影勋章"
    set ib_itemCustom[5] = 0
    set ib_itemList[6] = 'pmna'
    set ib_itemName[6] = "魔法垂饰"
    set ib_itemCustom[6] = 0
    set ib_itemList[7] = 'rhth'
    set ib_itemName[7] = "生命宝石"
    set ib_itemCustom[7] = 0
    set ib_itemList[8] = 'ankh'
    set ib_itemName[8] = "替身术"
    set ib_itemCustom[8] = 0
    set ib_itemList[9] = 'whwd'
    set ib_itemName[9] = "治疗守卫"
    set ib_itemCustom[9] = 0
    set ib_itemList[10] = 'mcou'
    set ib_itemName[10] = "[未开封]开天斧"
    set ib_itemCustom[10] = 0
    set ib_itemList[11] = 'ciri'
    set ib_itemName[11] = "水晶球碎片"
    set ib_itemCustom[11] = 0
    set ib_itemList[12] = 'ratc'
    set ib_itemName[12] = "藏宝图"
    set ib_itemCustom[12] = 0
    set ib_itemList[13] = 'kpin'
    set ib_itemName[13] = "[未开封]太虚神甲"
    set ib_itemCustom[13] = 0
    set ib_itemList[14] = 'hlst'
    set ib_itemName[14] = "白色的鱼"
    set ib_itemCustom[14] = 0
    set ib_itemList[15] = 'brac'
    set ib_itemName[15] = "|cff00ffff主宰"
    set ib_itemCustom[15] = 0
    set ib_itemList[16] = 'ofir'
    set ib_itemName[16] = "火焰之球"
    set ib_itemCustom[16] = 0
    set ib_itemList[17] = 'ocor'
    set ib_itemName[17] = "腐蚀之球"
    set ib_itemCustom[17] = 0
    set ib_itemList[18] = 'oli2'
    set ib_itemName[18] = "闪电之球"
    set ib_itemCustom[18] = 0
    set ib_itemList[19] = 'oven'
    set ib_itemName[19] = "毒液之球"
    set ib_itemCustom[19] = 0
    set ib_itemList[20] = 'rde2'
    set ib_itemName[20] = "|cff00ffff水影勋章"
    set ib_itemCustom[20] = 0
    set ib_itemList[21] = 'tgrh'
    set ib_itemName[21] = "小型的大厅"
    set ib_itemCustom[21] = 0
    set ib_itemList[22] = 'wswd'
    set ib_itemName[22] = "岗哨守卫"
    set ib_itemCustom[22] = 0
    set ib_itemList[23] = 'stel'
    set ib_itemName[23] = "传送权杖"
    set ib_itemCustom[23] = 0
    set ib_itemList[24] = 'cnob'
    set ib_itemName[24] = "幸运护身符"
    set ib_itemCustom[24] = 0
    set ib_itemList[25] = 'gcel'
    set ib_itemName[25] = "|cff00ffff王者之戒"
    set ib_itemCustom[25] = 0
    set ib_itemList[26] = 'rde1'
    set ib_itemName[26] = "|cff00ffff火影勋章"
    set ib_itemCustom[26] = 0
    set ib_itemList[27] = 'bspd'
    set ib_itemName[27] = "速度之靴"
    set ib_itemCustom[27] = 0
    set ib_itemList[28] = 'texp'
    set ib_itemName[28] = "经验之书"
    set ib_itemCustom[28] = 0
    set ib_itemList[29] = 'stwp'
    set ib_itemName[29] = "回城卷轴"
    set ib_itemCustom[29] = 0
    set ib_itemList[30] = 'shea'
    set ib_itemName[30] = "医疗卷轴"
    set ib_itemCustom[30] = 0
    set ib_itemList[31] = 'dust'
    set ib_itemName[31] = "尘土之影"
    set ib_itemCustom[31] = 0
    set ib_itemList[32] = 'rin1'
    set ib_itemName[32] = "仙人之魂"
    set ib_itemCustom[32] = 0
    set ib_itemList[33] = 'manh'
    set ib_itemName[33] = "生命手册"
    set ib_itemCustom[33] = 0
    set ib_itemList[34] = 'tdex'
    set ib_itemName[34] = "敏捷之书"
    set ib_itemCustom[34] = 0
    set ib_itemList[35] = 'tint'
    set ib_itemName[35] = "智力之书"
    set ib_itemCustom[35] = 0
    set ib_itemList[36] = 'tstr'
    set ib_itemName[36] = "力量之书"
    set ib_itemCustom[36] = 0
    set ib_itemList[37] = 'phea'
    set ib_itemName[37] = "生命药水"
    set ib_itemCustom[37] = 0
    set ib_itemList[38] = 'pman'
    set ib_itemName[38] = "魔法药水"
    set ib_itemCustom[38] = 0
    set ib_itemList[39] = 'hslv'
    set ib_itemName[39] = "医疗剂"
    set ib_itemCustom[39] = 0
    set ib_itemList[40] = 'moon'
    set ib_itemName[40] = "月亮石"
    set ib_itemCustom[40] = 0
    set ib_itemList[41] = 'shas'
    set ib_itemName[41] = "速度卷轴"
    set ib_itemCustom[41] = 0
    set ib_itemList[42] = 'skul'
    set ib_itemName[42] = "献祭头骨"
    set ib_itemCustom[42] = 0
    set ib_itemList[43] = 'mcri'
    set ib_itemName[43] = "机械类的小玩艺"
    set ib_itemCustom[43] = 0
    set ib_itemList[44] = 'rnec'
    set ib_itemName[44] = "巫术妖棍"
    set ib_itemCustom[44] = 0
    set ib_itemList[45] = 'tsct'
    set ib_itemName[45] = "象牙塔"
    set ib_itemCustom[45] = 0
    set ib_itemList[46] = 'bzbe'
    set ib_itemName[46] = "空瓶"
    set ib_itemCustom[46] = 0
    set ib_itemList[47] = 'bzbf'
    set ib_itemName[47] = "盛满泉水的瓶子"
    set ib_itemCustom[47] = 0
    set ib_itemList[48] = 'pomn'
    set ib_itemName[48] = "白鱼"
    set ib_itemCustom[48] = 0
    set ib_itemList[49] = 'pams'
    set ib_itemName[49] = "抗体药水"
    set ib_itemCustom[49] = 0
    set ib_itemList[50] = 'spre'
    set ib_itemName[50] = "保存权杖"
    set ib_itemCustom[50] = 0
    set ib_itemList[51] = 'gold'
    set ib_itemName[51] = "金币"
    set ib_itemCustom[51] = 0
    set ib_itemList[52] = 'lmbr'
    set ib_itemName[52] = "木材堆"
    set ib_itemCustom[52] = 0
    set ib_itemList[53] = 'gomn'
    set ib_itemName[53] = "进入钓鱼场"
    set ib_itemCustom[53] = 0
    set ib_itemList[54] = 'plcl'
    set ib_itemName[54] = "小净化药水"
    set ib_itemCustom[54] = 0
    set ib_itemList[55] = 'sreg'
    set ib_itemName[55] = "恢复卷轴"
    set ib_itemCustom[55] = 0
    set ib_itemList[56] = 'ssan'
    set ib_itemName[56] = "避难权杖"
    set ib_itemCustom[56] = 0
    set ib_itemList[57] = 'I001'
    set ib_itemName[57] = "金创药水"
    set ib_itemCustom[57] = 1
    set ib_itemList[58] = 'I005'
    set ib_itemName[58] = "查克拉药水"
    set ib_itemCustom[58] = 1
    set ib_itemList[59] = 'I00A'
    set ib_itemName[59] = "邀请决斗"
    set ib_itemCustom[59] = 1
    set ib_itemList[60] = 'I00C'
    set ib_itemName[60] = "[中忍]护靴"
    set ib_itemCustom[60] = 1
    set ib_itemList[61] = 'I00D'
    set ib_itemName[61] = "[上忍]护靴"
    set ib_itemCustom[61] = 1
    set ib_itemList[62] = 'I00E'
    set ib_itemName[62] = "[影级]护靴"
    set ib_itemCustom[62] = 1
    set ib_itemList[63] = 'I00F'
    set ib_itemName[63] = "[暗部]护靴"
    set ib_itemCustom[63] = 1
    set ib_itemList[64] = 'I00G'
    set ib_itemName[64] = "[上忍]护腕"
    set ib_itemCustom[64] = 1
    set ib_itemList[65] = 'I00J'
    set ib_itemName[65] = "[下忍]护靴"
    set ib_itemCustom[65] = 1
    set ib_itemList[66] = 'I00B'
    set ib_itemName[66] = "[暗部]护腕"
    set ib_itemCustom[66] = 1
    set ib_itemList[67] = 'I00H'
    set ib_itemName[67] = "[中忍]护腕"
    set ib_itemCustom[67] = 1
    set ib_itemList[68] = 'I00I'
    set ib_itemName[68] = "[下忍]护腕"
    set ib_itemCustom[68] = 1
    set ib_itemList[69] = 'I00K'
    set ib_itemName[69] = "[影级]护腕"
    set ib_itemCustom[69] = 1
    set ib_itemList[70] = 'I00L'
    set ib_itemName[70] = "[影级]护额"
    set ib_itemCustom[70] = 1
    set ib_itemList[71] = 'I00M'
    set ib_itemName[71] = "[中忍]护额"
    set ib_itemCustom[71] = 1
    set ib_itemList[72] = 'I00N'
    set ib_itemName[72] = "[上忍]护额"
    set ib_itemCustom[72] = 1
    set ib_itemList[73] = 'I00O'
    set ib_itemName[73] = "[暗部]护额"
    set ib_itemCustom[73] = 1
    set ib_itemList[74] = 'I00P'
    set ib_itemName[74] = "[下忍]护额"
    set ib_itemCustom[74] = 1
    set ib_itemList[75] = 'I00Q'
    set ib_itemName[75] = "影之玉 +0"
    set ib_itemCustom[75] = 1
    set ib_itemList[76] = 'I00R'
    set ib_itemName[76] = "忍者铠甲"
    set ib_itemCustom[76] = 1
    set ib_itemList[77] = 'I00S'
    set ib_itemName[77] = "忍者铠甲-lv2"
    set ib_itemCustom[77] = 1
    set ib_itemList[78] = 'I00T'
    set ib_itemName[78] = "忍者铠甲-lv3"
    set ib_itemCustom[78] = 1
    set ib_itemList[79] = 'I00U'
    set ib_itemName[79] = "忍者铠甲-lv4"
    set ib_itemCustom[79] = 1
endfunction
function IB_Fill1 takes nothing returns nothing
    set ib_itemList[80] = 'I00V'
    set ib_itemName[80] = "龙鳞铠甲"
    set ib_itemCustom[80] = 1
    set ib_itemList[81] = 'I00W'
    set ib_itemName[81] = "忍者铠甲-lv1"
    set ib_itemCustom[81] = 1
    set ib_itemList[82] = 'I00X'
    set ib_itemName[82] = "不动冥王宝石"
    set ib_itemCustom[82] = 1
    set ib_itemList[83] = 'I00Y'
    set ib_itemName[83] = "命运宝石"
    set ib_itemCustom[83] = 1
    set ib_itemList[84] = 'I01B'
    set ib_itemName[84] = "雷神之剑"
    set ib_itemCustom[84] = 1
    set ib_itemList[85] = 'I01C'
    set ib_itemName[85] = "雷神之剑-lv3"
    set ib_itemCustom[85] = 1
    set ib_itemList[86] = 'I01D'
    set ib_itemName[86] = "雷神之剑-lv1"
    set ib_itemCustom[86] = 1
    set ib_itemList[87] = 'I01E'
    set ib_itemName[87] = "雷神之剑-lv2"
    set ib_itemCustom[87] = 1
    set ib_itemList[88] = 'I01F'
    set ib_itemName[88] = "真.雷神剑"
    set ib_itemCustom[88] = 1
    set ib_itemList[89] = 'I01G'
    set ib_itemName[89] = "疾风履"
    set ib_itemCustom[89] = 1
    set ib_itemList[90] = 'I01H'
    set ib_itemName[90] = "升级护腕"
    set ib_itemCustom[90] = 1
    set ib_itemList[91] = 'I01I'
    set ib_itemName[91] = "升级护靴"
    set ib_itemCustom[91] = 1
    set ib_itemList[92] = 'I01J'
    set ib_itemName[92] = "升级护额"
    set ib_itemCustom[92] = 1
    set ib_itemList[93] = 'I01K'
    set ib_itemName[93] = "升级忍者铠甲"
    set ib_itemCustom[93] = 1
    set ib_itemList[94] = 'I01L'
    set ib_itemName[94] = "升级雷神之剑"
    set ib_itemCustom[94] = 1
    set ib_itemList[95] = 'I01M'
    set ib_itemName[95] = "[命运]打造"
    set ib_itemCustom[95] = 1
    set ib_itemList[96] = 'I01N'
    set ib_itemName[96] = "[合成]影之玉"
    set ib_itemCustom[96] = 1
    set ib_itemList[97] = 'I01O'
    set ib_itemName[97] = "替身术(大)"
    set ib_itemCustom[97] = 1
    set ib_itemList[98] = 'I01P'
    set ib_itemName[98] = "分解[命运象征影之玉]"
    set ib_itemCustom[98] = 1
    set ib_itemList[99] = 'I01U'
    set ib_itemName[99] = "建筑升级"
    set ib_itemCustom[99] = 1
    set ib_itemList[100] = 'I01V'
    set ib_itemName[100] = "练功房001"
    set ib_itemCustom[100] = 1
    set ib_itemList[101] = 'I01Y'
    set ib_itemName[101] = "幻影宝石"
    set ib_itemCustom[101] = 1
    set ib_itemList[102] = 'I01Z'
    set ib_itemName[102] = "天怒宝石"
    set ib_itemCustom[102] = 1
    set ib_itemList[103] = 'I020'
    set ib_itemName[103] = "混元宝石"
    set ib_itemCustom[103] = 1
    set ib_itemList[104] = 'I021'
    set ib_itemName[104] = "天幻宝石"
    set ib_itemCustom[104] = 1
    set ib_itemList[105] = 'I022'
    set ib_itemName[105] = "神武宝石"
    set ib_itemCustom[105] = 1
    set ib_itemList[106] = 'I023'
    set ib_itemName[106] = "火之意志"
    set ib_itemCustom[106] = 1
    set ib_itemList[107] = 'I024'
    set ib_itemName[107] = "力量宝石"
    set ib_itemCustom[107] = 1
    set ib_itemList[108] = 'I025'
    set ib_itemName[108] = "不动冥王甲"
    set ib_itemCustom[108] = 1
    set ib_itemList[109] = 'I026'
    set ib_itemName[109] = "火影铠甲"
    set ib_itemCustom[109] = 1
    set ib_itemList[110] = 'I027'
    set ib_itemName[110] = "天幻宝甲"
    set ib_itemCustom[110] = 1
    set ib_itemList[111] = 'I028'
    set ib_itemName[111] = "天怒宝甲"
    set ib_itemCustom[111] = 1
    set ib_itemList[112] = 'I029'
    set ib_itemName[112] = "幻影神甲"
    set ib_itemCustom[112] = 1
    set ib_itemList[113] = 'I02A'
    set ib_itemName[113] = "混元战甲"
    set ib_itemCustom[113] = 1
    set ib_itemList[114] = 'I02B'
    set ib_itemName[114] = "神武战甲"
    set ib_itemCustom[114] = 1
    set ib_itemList[115] = 'I02C'
    set ib_itemName[115] = "勇者铠甲"
    set ib_itemCustom[115] = 1
    set ib_itemList[116] = 'I02D'
    set ib_itemName[116] = "神武之枪"
    set ib_itemCustom[116] = 1
    set ib_itemList[117] = 'I02E'
    set ib_itemName[117] = "混元斩龙戬"
    set ib_itemCustom[117] = 1
    set ib_itemList[118] = 'I02F'
    set ib_itemName[118] = "幻影霸刀"
    set ib_itemCustom[118] = 1
    set ib_itemList[119] = 'I02G'
    set ib_itemName[119] = "天怒法杖"
    set ib_itemCustom[119] = 1
    set ib_itemList[120] = 'I02H'
    set ib_itemName[120] = "天幻法仗"
    set ib_itemCustom[120] = 1
    set ib_itemList[121] = 'I02I'
    set ib_itemName[121] = "勇者之剑"
    set ib_itemCustom[121] = 1
    set ib_itemList[122] = 'I02J'
    set ib_itemName[122] = "火影之剑"
    set ib_itemCustom[122] = 1
    set ib_itemList[123] = 'I02K'
    set ib_itemName[123] = "不动冥王刀"
    set ib_itemCustom[123] = 1
    set ib_itemList[124] = 'I02L'
    set ib_itemName[124] = "幻影战靴"
    set ib_itemCustom[124] = 1
    set ib_itemList[125] = 'I02M'
    set ib_itemName[125] = "天怒战靴"
    set ib_itemCustom[125] = 1
    set ib_itemList[126] = 'I02N'
    set ib_itemName[126] = "天幻战靴"
    set ib_itemCustom[126] = 1
    set ib_itemList[127] = 'I02O'
    set ib_itemName[127] = "勇者战靴"
    set ib_itemCustom[127] = 1
    set ib_itemList[128] = 'I02P'
    set ib_itemName[128] = "不动冥王靴"
    set ib_itemCustom[128] = 1
    set ib_itemList[129] = 'I02Q'
    set ib_itemName[129] = "混元战靴"
    set ib_itemCustom[129] = 1
    set ib_itemList[130] = 'I02R'
    set ib_itemName[130] = "火影战靴"
    set ib_itemCustom[130] = 1
    set ib_itemList[131] = 'I02S'
    set ib_itemName[131] = "神武战靴"
    set ib_itemCustom[131] = 1
    set ib_itemList[132] = 'I02T'
    set ib_itemName[132] = "亲热天堂"
    set ib_itemCustom[132] = 1
    set ib_itemList[133] = 'I02U'
    set ib_itemName[133] = "力量之书+10"
    set ib_itemCustom[133] = 1
    set ib_itemList[134] = 'I02V'
    set ib_itemName[134] = "敏捷之书 +10"
    set ib_itemCustom[134] = 1
    set ib_itemList[135] = 'I02W'
    set ib_itemName[135] = "智力之书 +10"
    set ib_itemCustom[135] = 1
    set ib_itemList[136] = 'I02X'
    set ib_itemName[136] = "挑战初代火影"
    set ib_itemCustom[136] = 1
    set ib_itemList[137] = 'I02Y'
    set ib_itemName[137] = "挑战二代目火影"
    set ib_itemCustom[137] = 1
    set ib_itemList[138] = 'I02Z'
    set ib_itemName[138] = "挑战三代目火影"
    set ib_itemCustom[138] = 1
    set ib_itemList[139] = 'I030'
    set ib_itemName[139] = "挑战四代目火影"
    set ib_itemCustom[139] = 1
    set ib_itemList[140] = 'I032'
    set ib_itemName[140] = "[打造套装]不动冥王套装"
    set ib_itemCustom[140] = 1
    set ib_itemList[141] = 'I033'
    set ib_itemName[141] = "[打造套装]天怒套装"
    set ib_itemCustom[141] = 1
    set ib_itemList[142] = 'I034'
    set ib_itemName[142] = "[打造套装]混元套装"
    set ib_itemCustom[142] = 1
    set ib_itemList[143] = 'I035'
    set ib_itemName[143] = "[打造套装]天幻套装"
    set ib_itemCustom[143] = 1
    set ib_itemList[144] = 'I036'
    set ib_itemName[144] = "[打造套装]幻影套装"
    set ib_itemCustom[144] = 1
    set ib_itemList[145] = 'I037'
    set ib_itemName[145] = "[打造套装]神武套装"
    set ib_itemCustom[145] = 1
    set ib_itemList[146] = 'I038'
    set ib_itemName[146] = "[打造套装]勇者套装"
    set ib_itemCustom[146] = 1
    set ib_itemList[147] = 'I039'
    set ib_itemName[147] = "[打造套装]火影套装"
    set ib_itemCustom[147] = 1
    set ib_itemList[148] = 'I03N'
    set ib_itemName[148] = "开启神器-神力"
    set ib_itemCustom[148] = 1
    set ib_itemList[149] = 'I03O'
    set ib_itemName[149] = "女娲石"
    set ib_itemCustom[149] = 1
    set ib_itemList[150] = 'I03P'
    set ib_itemName[150] = "十拳灵剑"
    set ib_itemCustom[150] = 1
    set ib_itemList[151] = 'I03Q'
    set ib_itemName[151] = "八尺镜"
    set ib_itemCustom[151] = 1
    set ib_itemList[152] = 'I03R'
    set ib_itemName[152] = "a级情报"
    set ib_itemCustom[152] = 1
    set ib_itemList[153] = 'I03S'
    set ib_itemName[153] = "b级情报"
    set ib_itemCustom[153] = 1
    set ib_itemList[154] = 'I03T'
    set ib_itemName[154] = "情报收集"
    set ib_itemCustom[154] = 1
    set ib_itemList[155] = 'I03W'
    set ib_itemName[155] = "治疗神水"
    set ib_itemCustom[155] = 1
    set ib_itemList[156] = 'I03Y'
    set ib_itemName[156] = "接受/提交寻找水源任务"
    set ib_itemCustom[156] = 1
    set ib_itemList[157] = 'I03Z'
    set ib_itemName[157] = "幻境通行证"
    set ib_itemCustom[157] = 1
    set ib_itemList[158] = 'I042'
    set ib_itemName[158] = "遗物项链"
    set ib_itemCustom[158] = 1
    set ib_itemList[159] = 'I043'
    set ib_itemName[159] = "基地无敌50秒"
    set ib_itemCustom[159] = 1
endfunction
function IB_Fill2 takes nothing returns nothing
    set ib_itemList[160] = 'I048'
    set ib_itemName[160] = "[打造套装]白虎套装"
    set ib_itemCustom[160] = 1
    set ib_itemList[161] = 'I049'
    set ib_itemName[161] = "[打造套装]青龙套装"
    set ib_itemCustom[161] = 1
    set ib_itemList[162] = 'I04A'
    set ib_itemName[162] = "[打造套装]朱雀套装"
    set ib_itemCustom[162] = 1
    set ib_itemList[163] = 'I04B'
    set ib_itemName[163] = "[打造套装]玄武套装"
    set ib_itemCustom[163] = 1
    set ib_itemList[164] = 'I04C'
    set ib_itemName[164] = "白虎宝石"
    set ib_itemCustom[164] = 1
    set ib_itemList[165] = 'I04D'
    set ib_itemName[165] = "青龙宝石"
    set ib_itemCustom[165] = 1
    set ib_itemList[166] = 'I04E'
    set ib_itemName[166] = "朱雀宝石"
    set ib_itemCustom[166] = 1
    set ib_itemList[167] = 'I04F'
    set ib_itemName[167] = "玄武宝石"
    set ib_itemCustom[167] = 1
    set ib_itemList[168] = 'I04X'
    set ib_itemName[168] = "2015年礼包"
    set ib_itemCustom[168] = 1
    set ib_itemList[169] = 'I05B'
    set ib_itemName[169] = "宝石兑换"
    set ib_itemCustom[169] = 1
    set ib_itemList[170] = 'I05C'
    set ib_itemName[170] = "再不斩的大刀"
    set ib_itemCustom[170] = 1
    set ib_itemList[171] = 'I05G'
    set ib_itemName[171] = "鲛肌"
    set ib_itemCustom[171] = 1
    set ib_itemList[172] = 'I05K'
    set ib_itemName[172] = "最强之矛"
    set ib_itemCustom[172] = 1
    set ib_itemList[173] = 'I05L'
    set ib_itemName[173] = "戒指.零"
    set ib_itemCustom[173] = 1
    set ib_itemList[174] = 'I05M'
    set ib_itemName[174] = "飞雷神.苦无-[需升级]"
    set ib_itemCustom[174] = 1
    set ib_itemList[175] = 'I05P'
    set ib_itemName[175] = "飞雷神.苦无"
    set ib_itemCustom[175] = 1
    set ib_itemList[176] = 'I05Q'
    set ib_itemName[176] = "提交寻找水源"
    set ib_itemCustom[176] = 1
    set ib_itemList[177] = 'I05R'
    set ib_itemName[177] = "龙鳞雷神剑"
    set ib_itemCustom[177] = 1
    set ib_itemList[178] = 'I05S'
    set ib_itemName[178] = "面具"
    set ib_itemCustom[178] = 1
    set ib_itemList[179] = 'I05T'
    set ib_itemName[179] = "治疗药水"
    set ib_itemCustom[179] = 1
    set ib_itemList[180] = 'I05U'
    set ib_itemName[180] = "金刚棒"
    set ib_itemCustom[180] = 1
    set ib_itemList[181] = 'I05V'
    set ib_itemName[181] = "水影斗篷"
    set ib_itemCustom[181] = 1
    set ib_itemList[182] = 'I05D'
    set ib_itemName[182] = "草雉剑"
    set ib_itemCustom[182] = 1
    set ib_itemList[183] = 'I05F'
    set ib_itemName[183] = "万花筒写轮眼"
    set ib_itemCustom[183] = 1
    set ib_itemList[184] = 'I05N'
    set ib_itemName[184] = "砂葫芦"
    set ib_itemCustom[184] = 1
    set ib_itemList[185] = 'I05O'
    set ib_itemName[185] = "火影斗篷"
    set ib_itemCustom[185] = 1
    set ib_itemList[186] = 'I05X'
    set ib_itemName[186] = "忍具.双截棍"
    set ib_itemCustom[186] = 1
    set ib_itemList[187] = 'I05Y'
    set ib_itemName[187] = "圣灵精华"
    set ib_itemCustom[187] = 1
    set ib_itemList[188] = 'I063'
    set ib_itemName[188] = "[打造圣灵套装]圣兽套装"
    set ib_itemCustom[188] = 1
    set ib_itemList[189] = 'I064'
    set ib_itemName[189] = "有奖问答"
    set ib_itemCustom[189] = 1
    set ib_itemList[190] = 'I065'
    set ib_itemName[190] = "戒指.朱"
    set ib_itemCustom[190] = 1
    set ib_itemList[191] = 'I066'
    set ib_itemName[191] = "领取 七星剑"
    set ib_itemCustom[191] = 1
    set ib_itemList[192] = 'I067'
    set ib_itemName[192] = "领取 八尺镜"
    set ib_itemCustom[192] = 1
    set ib_itemList[193] = 'I068'
    set ib_itemName[193] = "领取 六道仙杖"
    set ib_itemCustom[193] = 1
    set ib_itemList[194] = 'I069'
    set ib_itemName[194] = "领取 幌金绳"
    set ib_itemCustom[194] = 1
    set ib_itemList[195] = 'I06C'
    set ib_itemName[195] = "拳套"
    set ib_itemCustom[195] = 1
    set ib_itemList[196] = 'I06F'
    set ib_itemName[196] = "戒指.玉"
    set ib_itemCustom[196] = 1
    set ib_itemList[197] = 'I06G'
    set ib_itemName[197] = "暗部配刀"
    set ib_itemCustom[197] = 1
    set ib_itemList[198] = 'I06J'
    set ib_itemName[198] = "粘土口袋"
    set ib_itemCustom[198] = 1
    set ib_itemList[199] = 'I06K'
    set ib_itemName[199] = "零食"
    set ib_itemCustom[199] = 1
    set ib_itemList[200] = 'I06L'
    set ib_itemName[200] = "进入 羁绊专区"
    set ib_itemCustom[200] = 1
    set ib_itemList[201] = 'I06M'
    set ib_itemName[201] = "赌钱 1赔2"
    set ib_itemCustom[201] = 1
    set ib_itemList[202] = 'I06N'
    set ib_itemName[202] = "赌钱 1赔5"
    set ib_itemCustom[202] = 1
    set ib_itemList[203] = 'I06O'
    set ib_itemName[203] = "神器有木有"
    set ib_itemCustom[203] = 1
    set ib_itemList[204] = 'I06Q'
    set ib_itemName[204] = "鸡蛋"
    set ib_itemCustom[204] = 1
    set ib_itemList[205] = 'I06R'
    set ib_itemName[205] = "七星剑"
    set ib_itemCustom[205] = 1
    set ib_itemList[206] = 'I06S'
    set ib_itemName[206] = "千年精华"
    set ib_itemCustom[206] = 1
    set ib_itemList[207] = 'I06T'
    set ib_itemName[207] = "金鸡蛋"
    set ib_itemCustom[207] = 1
    set ib_itemList[208] = 'I06U'
    set ib_itemName[208] = "山茶花"
    set ib_itemCustom[208] = 1
    set ib_itemList[209] = 'I002'
    set ib_itemName[209] = "[打造套装]六道套装"
    set ib_itemCustom[209] = 1
    set ib_itemList[210] = 'I004'
    set ib_itemName[210] = "仙人遗物"
    set ib_itemCustom[210] = 1
    set ib_itemList[211] = 'I007'
    set ib_itemName[211] = "[六道] - 镇海"
    set ib_itemCustom[211] = 1
    set ib_itemList[212] = 'I009'
    set ib_itemName[212] = "[六道] - 九幽"
    set ib_itemCustom[212] = 1
    set ib_itemList[213] = 'I01W'
    set ib_itemName[213] = "[六道] - 幻雷"
    set ib_itemCustom[213] = 1
    set ib_itemList[214] = 'I01X'
    set ib_itemName[214] = "雷犁刃"
    set ib_itemCustom[214] = 1
    set ib_itemList[215] = 'I03A'
    set ib_itemName[215] = "戒指.白"
    set ib_itemCustom[215] = 1
    set ib_itemList[216] = 'I03B'
    set ib_itemName[216] = "拐杖"
    set ib_itemCustom[216] = 1
    set ib_itemList[217] = 'I03C'
    set ib_itemName[217] = "振奋手套"
    set ib_itemCustom[217] = 1
    set ib_itemList[218] = 'I03D'
    set ib_itemName[218] = "前往 秒木山"
    set ib_itemCustom[218] = 1
    set ib_itemList[219] = 'I03E'
    set ib_itemName[219] = "妙木山修炼"
    set ib_itemCustom[219] = 1
    set ib_itemList[220] = 'I03F'
    set ib_itemName[220] = "修炼仙人"
    set ib_itemCustom[220] = 1
    set ib_itemList[221] = 'I03G'
    set ib_itemName[221] = "接受/提交捕食"
    set ib_itemCustom[221] = 1
    set ib_itemList[222] = 'I03H'
    set ib_itemName[222] = "重新预言"
    set ib_itemCustom[222] = 1
    set ib_itemList[223] = 'I03I'
    set ib_itemName[223] = "前往 神秘森林"
    set ib_itemCustom[223] = 1
    set ib_itemList[224] = 'I03J'
    set ib_itemName[224] = "冬冬的考验"
    set ib_itemCustom[224] = 1
    set ib_itemList[225] = 'I03K'
    set ib_itemName[225] = "幌金绳"
    set ib_itemCustom[225] = 1
    set ib_itemList[226] = 'I03L'
    set ib_itemName[226] = "勾玉项链"
    set ib_itemCustom[226] = 1
    set ib_itemList[227] = 'I03M'
    set ib_itemName[227] = "（仙)镇海伏魔刀"
    set ib_itemCustom[227] = 1
    set ib_itemList[228] = 'I03X'
    set ib_itemName[228] = "（仙)镇海伏魔甲"
    set ib_itemCustom[228] = 1
    set ib_itemList[229] = 'I040'
    set ib_itemName[229] = "（仙)镇海伏魔靴"
    set ib_itemCustom[229] = 1
    set ib_itemList[230] = 'I04S'
    set ib_itemName[230] = "（仙)镇海伏魔刀"
    set ib_itemCustom[230] = 1
    set ib_itemList[231] = 'I056'
    set ib_itemName[231] = "（仙)镇海伏魔刀"
    set ib_itemCustom[231] = 1
    set ib_itemList[232] = 'I057'
    set ib_itemName[232] = "（仙)镇海伏魔甲"
    set ib_itemCustom[232] = 1
    set ib_itemList[233] = 'I058'
    set ib_itemName[233] = "（仙)镇海伏魔甲"
    set ib_itemCustom[233] = 1
    set ib_itemList[234] = 'I05E'
    set ib_itemName[234] = "（仙)镇海伏魔靴"
    set ib_itemCustom[234] = 1
    set ib_itemList[235] = 'I05H'
    set ib_itemName[235] = "（仙)镇海伏魔靴"
    set ib_itemCustom[235] = 1
    set ib_itemList[236] = 'I05I'
    set ib_itemName[236] = "（仙)九幽伏魔枪"
    set ib_itemCustom[236] = 1
    set ib_itemList[237] = 'I05J'
    set ib_itemName[237] = "（仙)九幽伏魔甲"
    set ib_itemCustom[237] = 1
    set ib_itemList[238] = 'I05W'
    set ib_itemName[238] = "（仙)九幽伏魔靴"
    set ib_itemCustom[238] = 1
    set ib_itemList[239] = 'I06P'
    set ib_itemName[239] = "（仙)九幽伏魔枪"
    set ib_itemCustom[239] = 1
endfunction
function IB_Fill3 takes nothing returns nothing
    set ib_itemList[240] = 'I06V'
    set ib_itemName[240] = "（仙)九幽伏魔枪"
    set ib_itemCustom[240] = 1
    set ib_itemList[241] = 'I06W'
    set ib_itemName[241] = "（仙)九幽伏魔甲"
    set ib_itemCustom[241] = 1
    set ib_itemList[242] = 'I06X'
    set ib_itemName[242] = "（仙)九幽伏魔甲"
    set ib_itemCustom[242] = 1
    set ib_itemList[243] = 'I06Y'
    set ib_itemName[243] = "（仙)九幽伏魔靴"
    set ib_itemCustom[243] = 1
    set ib_itemList[244] = 'I06Z'
    set ib_itemName[244] = "（仙)九幽伏魔靴"
    set ib_itemCustom[244] = 1
    set ib_itemList[245] = 'I070'
    set ib_itemName[245] = "（仙)幻雷伏魔杖"
    set ib_itemCustom[245] = 1
    set ib_itemList[246] = 'I071'
    set ib_itemName[246] = "（仙)幻雷伏魔甲"
    set ib_itemCustom[246] = 1
    set ib_itemList[247] = 'I072'
    set ib_itemName[247] = "（仙)幻雷伏魔靴"
    set ib_itemCustom[247] = 1
    set ib_itemList[248] = 'I073'
    set ib_itemName[248] = "（仙)幻雷伏魔杖"
    set ib_itemCustom[248] = 1
    set ib_itemList[249] = 'I074'
    set ib_itemName[249] = "（仙)幻雷伏魔杖"
    set ib_itemCustom[249] = 1
    set ib_itemList[250] = 'I075'
    set ib_itemName[250] = "（仙)幻雷伏魔甲"
    set ib_itemCustom[250] = 1
    set ib_itemList[251] = 'I076'
    set ib_itemName[251] = "（仙)幻雷伏魔甲"
    set ib_itemCustom[251] = 1
    set ib_itemList[252] = 'I077'
    set ib_itemName[252] = "（仙)幻雷伏魔靴"
    set ib_itemCustom[252] = 1
    set ib_itemList[253] = 'I078'
    set ib_itemName[253] = "（仙)幻雷伏魔靴"
    set ib_itemCustom[253] = 1
    set ib_itemList[254] = 'I079'
    set ib_itemName[254] = "（仙)炽焰伏魔刃"
    set ib_itemCustom[254] = 1
    set ib_itemList[255] = 'I07A'
    set ib_itemName[255] = "（仙)炽焰伏魔甲"
    set ib_itemCustom[255] = 1
    set ib_itemList[256] = 'I07B'
    set ib_itemName[256] = "（仙)炽焰伏魔靴"
    set ib_itemCustom[256] = 1
    set ib_itemList[257] = 'I07C'
    set ib_itemName[257] = "（仙)炽焰伏魔刃"
    set ib_itemCustom[257] = 1
    set ib_itemList[258] = 'I07D'
    set ib_itemName[258] = "（仙)炽焰伏魔刃"
    set ib_itemCustom[258] = 1
    set ib_itemList[259] = 'I07E'
    set ib_itemName[259] = "（仙)炽焰伏魔甲"
    set ib_itemCustom[259] = 1
    set ib_itemList[260] = 'I07F'
    set ib_itemName[260] = "（仙)炽焰伏魔甲"
    set ib_itemCustom[260] = 1
    set ib_itemList[261] = 'I07G'
    set ib_itemName[261] = "（仙)炽焰伏魔靴"
    set ib_itemCustom[261] = 1
    set ib_itemList[262] = 'I07H'
    set ib_itemName[262] = "（仙)炽焰伏魔靴"
    set ib_itemCustom[262] = 1
    set ib_itemList[263] = 'I07I'
    set ib_itemName[263] = "修炼石"
    set ib_itemCustom[263] = 1
    set ib_itemList[264] = 'I07J'
    set ib_itemName[264] = "强化之石"
    set ib_itemCustom[264] = 1
    set ib_itemList[265] = 'I07K'
    set ib_itemName[265] = "[打造]仙人套装"
    set ib_itemCustom[265] = 1
    set ib_itemList[266] = 'I07L'
    set ib_itemName[266] = "（仙)九幽"
    set ib_itemCustom[266] = 1
    set ib_itemList[267] = 'I07M'
    set ib_itemName[267] = "（仙)炽焰"
    set ib_itemCustom[267] = 1
    set ib_itemList[268] = 'I07N'
    set ib_itemName[268] = "（仙)镇海"
    set ib_itemCustom[268] = 1
    set ib_itemList[269] = 'I07O'
    set ib_itemName[269] = "（仙)幻雷"
    set ib_itemCustom[269] = 1
    set ib_itemList[270] = 'I07P'
    set ib_itemName[270] = "融合石"
    set ib_itemCustom[270] = 1
    set ib_itemList[271] = 'I07Q'
    set ib_itemName[271] = "仙人卷轴"
    set ib_itemCustom[271] = 1
    set ib_itemList[272] = 'I07R'
    set ib_itemName[272] = "仙人凭证"
    set ib_itemCustom[272] = 1
    set ib_itemList[273] = 'I07S'
    set ib_itemName[273] = "打火机"
    set ib_itemCustom[273] = 1
    set ib_itemList[274] = 'I07T'
    set ib_itemName[274] = "神秘面具"
    set ib_itemCustom[274] = 1
    set ib_itemList[275] = 'I07U'
    set ib_itemName[275] = "宇智波团扇"
    set ib_itemCustom[275] = 1
    set ib_itemList[276] = 'I07V'
    set ib_itemName[276] = "极限挑战"
    set ib_itemCustom[276] = 1
    set ib_itemList[277] = 'I07W'
    set ib_itemName[277] = "尾兽之力"
    set ib_itemCustom[277] = 1
    set ib_itemList[278] = 'I07X'
    set ib_itemName[278] = "兑换强化之石"
    set ib_itemCustom[278] = 1
    set ib_itemList[279] = 'I07Y'
    set ib_itemName[279] = "兑换融合石"
    set ib_itemCustom[279] = 1
    set ib_itemList[280] = 'I07Z'
    set ib_itemName[280] = "合成尾兽之力"
    set ib_itemCustom[280] = 1
    set ib_itemList[281] = 'I080'
    set ib_itemName[281] = "尾兽精华"
    set ib_itemCustom[281] = 1
    set ib_itemList[282] = 'I085'
    set ib_itemName[282] = "尾兽结晶"
    set ib_itemCustom[282] = 1
    set ib_itemList[283] = 'I086'
    set ib_itemName[283] = "仙人最终试练"
    set ib_itemCustom[283] = 1
    set ib_itemList[284] = 'I087'
    set ib_itemName[284] = "领取 上古魂石"
    set ib_itemCustom[284] = 1
    set ib_itemList[285] = 'I088'
    set ib_itemName[285] = "遗书"
    set ib_itemCustom[285] = 1
    set ib_itemList[286] = 'I089'
    set ib_itemName[286] = "土影披风"
    set ib_itemCustom[286] = 1
    set ib_itemList[287] = 'I08A'
    set ib_itemName[287] = "建筑强化"
    set ib_itemCustom[287] = 1
    set ib_itemList[288] = 'I08B'
    set ib_itemName[288] = "[六道] - 炽焰"
    set ib_itemCustom[288] = 1
    set ib_itemList[289] = 'I08C'
    set ib_itemName[289] = "禁术卷轴"
    set ib_itemCustom[289] = 1
    set ib_itemList[290] = 'I08D'
    set ib_itemName[290] = "兑换 勾玉项链"
    set ib_itemCustom[290] = 1
    set ib_itemList[291] = 'I08E'
    set ib_itemName[291] = "兑换仙人遗物"
    set ib_itemCustom[291] = 1
    set ib_itemList[292] = 'I08F'
    set ib_itemName[292] = "挑战龙兜"
    set ib_itemCustom[292] = 1
    set ib_itemList[293] = 'I08G'
    set ib_itemName[293] = "积分宝石兑换"
    set ib_itemCustom[293] = 1
    set ib_itemList[294] = 'I08H'
    set ib_itemName[294] = "任务 - 追捕逃忍"
    set ib_itemCustom[294] = 1
    set ib_itemList[295] = 'I08I'
    set ib_itemName[295] = "亲热暴力"
    set ib_itemCustom[295] = 1
    set ib_itemList[296] = 'I08K'
    set ib_itemName[296] = "红色的鱼"
    set ib_itemCustom[296] = 1
    set ib_itemList[297] = 'I08L'
    set ib_itemName[297] = "蓝色的鱼"
    set ib_itemCustom[297] = 1
    set ib_itemList[298] = 'I08M'
    set ib_itemName[298] = "黑色的鱼"
    set ib_itemCustom[298] = 1
    set ib_itemList[299] = 'I08N'
    set ib_itemName[299] = "变异的鱼"
    set ib_itemCustom[299] = 1
    set ib_itemList[300] = 'I08O'
    set ib_itemName[300] = "捕鱼者的请求"
    set ib_itemCustom[300] = 1
    set ib_itemList[301] = 'I08P'
    set ib_itemName[301] = "挑战自我 x 5"
    set ib_itemCustom[301] = 1
    set ib_itemList[302] = 'I08Q'
    set ib_itemName[302] = "挑战自我 x 10"
    set ib_itemCustom[302] = 1
    set ib_itemList[303] = 'I08R'
    set ib_itemName[303] = "查克拉守卫"
    set ib_itemCustom[303] = 1
    set ib_itemList[304] = 'I08S'
    set ib_itemName[304] = "雷影披风"
    set ib_itemCustom[304] = 1
    set ib_itemList[305] = 'I08T'
    set ib_itemName[305] = "创世仙甲"
    set ib_itemCustom[305] = 1
    set ib_itemList[306] = 'I08U'
    set ib_itemName[306] = "创世仙杖"
    set ib_itemCustom[306] = 1
    set ib_itemList[307] = 'I08V'
    set ib_itemName[307] = "创世仙靴"
    set ib_itemCustom[307] = 1
    set ib_itemList[308] = 'I08W'
    set ib_itemName[308] = "创世仙玉"
    set ib_itemCustom[308] = 1
    set ib_itemList[309] = 'I08X'
    set ib_itemName[309] = "领取奖励"
    set ib_itemCustom[309] = 1
    set ib_itemList[310] = 'I08Y'
    set ib_itemName[310] = "兑换尾兽精华"
    set ib_itemCustom[310] = 1
    set ib_itemList[311] = 'I08Z'
    set ib_itemName[311] = "合成创世仙魂"
    set ib_itemCustom[311] = 1
    set ib_itemList[312] = 'I090'
    set ib_itemName[312] = "创世仙魂"
    set ib_itemCustom[312] = 1
    set ib_itemList[313] = 'I091'
    set ib_itemName[313] = "创世仙魂"
    set ib_itemCustom[313] = 1
    set ib_itemList[314] = 'I092'
    set ib_itemName[314] = "羞涩的爱"
    set ib_itemCustom[314] = 1
    set ib_itemList[315] = 'I093'
    set ib_itemName[315] = "挑战自我 x 5秒木"
    set ib_itemCustom[315] = 1
    set ib_itemList[316] = 'I094'
    set ib_itemName[316] = "挑战自我 x 20苗木"
    set ib_itemCustom[316] = 1
    set ib_itemList[317] = 'I095'
    set ib_itemName[317] = "祥云坠饰"
    set ib_itemCustom[317] = 1
    set ib_itemList[318] = 'I096'
    set ib_itemName[318] = "前往 龙地洞"
    set ib_itemCustom[318] = 1
    set ib_itemList[319] = 'I097'
    set ib_itemName[319] = "金币2"
    set ib_itemCustom[319] = 1
endfunction
function IB_Fill4 takes nothing returns nothing
    set ib_itemList[320] = 'I098'
    set ib_itemName[320] = "木材堆2"
    set ib_itemCustom[320] = 1
    set ib_itemList[321] = 'I041'
    set ib_itemName[321] = "勇者宝藏"
    set ib_itemCustom[321] = 1
    set ib_itemList[322] = 'I099'
    set ib_itemName[322] = "仙人宝箱"
    set ib_itemCustom[322] = 1
    set ib_itemList[323] = 'I09A'
    set ib_itemName[323] = "血雾之乡"
    set ib_itemCustom[323] = 1
    set ib_itemList[324] = 'I09B'
    set ib_itemName[324] = "恐惧与信念"
    set ib_itemCustom[324] = 1
    set ib_itemList[325] = 'I09C'
    set ib_itemName[325] = "琼曲玉"
    set ib_itemCustom[325] = 1
    set ib_itemList[326] = 'I09D'
    set ib_itemName[326] = "合成 琼曲玉"
    set ib_itemCustom[326] = 1
    set ib_itemList[327] = 'I09E'
    set ib_itemName[327] = "火影披风"
    set ib_itemCustom[327] = 1
    set ib_itemList[328] = 'I09F'
    set ib_itemName[328] = "修行卷轴"
    set ib_itemCustom[328] = 1
    set ib_itemList[329] = 'I09K'
    set ib_itemName[329] = "草雉剑"
    set ib_itemCustom[329] = 1
    set ib_itemList[330] = 'I09L'
    set ib_itemName[330] = "影之玉 +13"
    set ib_itemCustom[330] = 1
    set ib_itemList[331] = 'I09M'
    set ib_itemName[331] = "影之玉 +6"
    set ib_itemCustom[331] = 1
    set ib_itemList[332] = 'I09N'
    set ib_itemName[332] = "影之玉 +2"
    set ib_itemCustom[332] = 1
    set ib_itemList[333] = 'I09O'
    set ib_itemName[333] = "影之玉 +14"
    set ib_itemCustom[333] = 1
    set ib_itemList[334] = 'I09P'
    set ib_itemName[334] = "影之玉 +4"
    set ib_itemCustom[334] = 1
    set ib_itemList[335] = 'I09Q'
    set ib_itemName[335] = "影之玉 +5"
    set ib_itemCustom[335] = 1
    set ib_itemList[336] = 'I09R'
    set ib_itemName[336] = "影之玉 +7"
    set ib_itemCustom[336] = 1
    set ib_itemList[337] = 'I09S'
    set ib_itemName[337] = "影之玉 +8"
    set ib_itemCustom[337] = 1
    set ib_itemList[338] = 'I09T'
    set ib_itemName[338] = "影之玉 +9"
    set ib_itemCustom[338] = 1
    set ib_itemList[339] = 'I09U'
    set ib_itemName[339] = "影之玉 +10"
    set ib_itemCustom[339] = 1
    set ib_itemList[340] = 'I09V'
    set ib_itemName[340] = "影之玉 +11"
    set ib_itemCustom[340] = 1
    set ib_itemList[341] = 'I09W'
    set ib_itemName[341] = "影之玉 +1"
    set ib_itemCustom[341] = 1
    set ib_itemList[342] = 'I09X'
    set ib_itemName[342] = "影之玉 +3"
    set ib_itemCustom[342] = 1
    set ib_itemList[343] = 'I09Y'
    set ib_itemName[343] = "影之玉 +12"
    set ib_itemCustom[343] = 1
    set ib_itemList[344] = 'I09Z'
    set ib_itemName[344] = "影之玉 +15"
    set ib_itemCustom[344] = 1
    set ib_itemList[345] = 'I0A0'
    set ib_itemName[345] = "创世仙魂"
    set ib_itemCustom[345] = 1
    set ib_itemList[346] = 'I0A1'
    set ib_itemName[346] = "创世仙魂"
    set ib_itemCustom[346] = 1
    set ib_itemList[347] = 'I0A2'
    set ib_itemName[347] = "封印卷轴"
    set ib_itemCustom[347] = 1
    set ib_itemList[348] = 'I0A3'
    set ib_itemName[348] = "兑换封印卷轴"
    set ib_itemCustom[348] = 1
    set ib_itemList[349] = 'I0A4'
    set ib_itemName[349] = "兑换影之玉 +15"
    set ib_itemCustom[349] = 1
    set ib_itemList[350] = 'I0A5'
    set ib_itemName[350] = "始祖之吻"
    set ib_itemCustom[350] = 1
    set ib_itemList[351] = 'I0A6'
    set ib_itemName[351] = "仙人宝藏"
    set ib_itemCustom[351] = 1
    set ib_itemList[352] = 'I0A7'
    set ib_itemName[352] = "惊呆小伙伴礼包"
    set ib_itemCustom[352] = 1
    set ib_itemList[353] = 'I0A8'
    set ib_itemName[353] = "[强化]影之玉"
    set ib_itemCustom[353] = 1
    set ib_itemList[354] = 'I0A9'
    set ib_itemName[354] = "[兑换]始祖之吻"
    set ib_itemCustom[354] = 1
    set ib_itemList[355] = 'I0AA'
    set ib_itemName[355] = "心之剑"
    set ib_itemCustom[355] = 1
    set ib_itemList[356] = 'I0AB'
    set ib_itemName[356] = "超级修炼之书"
    set ib_itemCustom[356] = 1
    set ib_itemList[357] = 'I0AC'
    set ib_itemName[357] = "兑换幸运护身符"
    set ib_itemCustom[357] = 1
    set ib_itemList[358] = 'I0AD'
    set ib_itemName[358] = "购买幸运护身符"
    set ib_itemCustom[358] = 1
    set ib_itemList[359] = 'I0AE'
    set ib_itemName[359] = "血腥三月镰"
    set ib_itemCustom[359] = 1
    set ib_itemList[360] = 'I0AF'
    set ib_itemName[360] = "戒指.北"
    set ib_itemCustom[360] = 1
    set ib_itemList[361] = 'I0AG'
    set ib_itemName[361] = "六道锡杖"
    set ib_itemCustom[361] = 1
    set ib_itemList[362] = 'I0AH'
    set ib_itemName[362] = "瞬身苦无"
    set ib_itemCustom[362] = 1
    set ib_itemList[363] = 'I0AI'
    set ib_itemName[363] = "小黄"
    set ib_itemCustom[363] = 1
    set ib_itemList[364] = 'I0AJ'
    set ib_itemName[364] = "食人魔的锁甲"
    set ib_itemCustom[364] = 1
    set ib_itemList[365] = 'I0AK'
    set ib_itemName[365] = "潜入 雨忍村"
    set ib_itemCustom[365] = 1
    set ib_itemList[366] = 'I0AL'
    set ib_itemName[366] = "125级团队任务 - 秽土转生"
    set ib_itemCustom[366] = 1
    set ib_itemList[367] = 'I0AM'
    set ib_itemName[367] = "25级团队任务 - 死之森林"
    set ib_itemCustom[367] = 1
    set ib_itemList[368] = 'I0AN'
    set ib_itemName[368] = "50级团队任务 - 等了好久！a级任务"
    set ib_itemCustom[368] = 1
    set ib_itemList[369] = 'I0AO'
    set ib_itemName[369] = "75级团队任务 - 晓之神秘组织"
    set ib_itemCustom[369] = 1
    set ib_itemList[370] = 'I0AP'
    set ib_itemName[370] = "100级团队任务 - 第四次忍界大战"
    set ib_itemCustom[370] = 1
    set ib_itemList[371] = 'I0AQ'
    set ib_itemName[371] = "150级团队任务 - 幕后操纵者"
    set ib_itemCustom[371] = 1
    set ib_itemList[372] = 'I0AR'
    set ib_itemName[372] = "传承 六道阳之力"
    set ib_itemCustom[372] = 1
    set ib_itemList[373] = 'I0AS'
    set ib_itemName[373] = "传承 六道阴之力"
    set ib_itemCustom[373] = 1
    set ib_itemList[374] = 'I0AT'
    set ib_itemName[374] = "进入 精神世界"
    set ib_itemCustom[374] = 1
    set ib_itemList[375] = 'I0AU'
    set ib_itemName[375] = "六道仙人箴言"
    set ib_itemCustom[375] = 1
    set ib_itemList[376] = 'I0AV'
    set ib_itemName[376] = "进入 宝藏洞"
    set ib_itemCustom[376] = 1
    set ib_itemList[377] = 'I0AW'
    set ib_itemName[377] = "琥珀净瓶"
    set ib_itemCustom[377] = 1
    set ib_itemList[378] = 'I0AX'
    set ib_itemName[378] = "红葫芦"
    set ib_itemCustom[378] = 1
    set ib_itemList[379] = 'I0AY'
    set ib_itemName[379] = "芭蕉扇"
    set ib_itemCustom[379] = 1
    set ib_itemList[380] = 'I0AZ'
    set ib_itemName[380] = "六道仙杖"
    set ib_itemCustom[380] = 1
    set ib_itemList[381] = 'I0B0'
    set ib_itemName[381] = "六道仙杖"
    set ib_itemCustom[381] = 1
    set ib_itemList[382] = 'I0B1'
    set ib_itemName[382] = "六道仙杖"
    set ib_itemCustom[382] = 1
    set ib_itemList[383] = 'I0B2'
    set ib_itemName[383] = "六道仙杖"
    set ib_itemCustom[383] = 1
    set ib_itemList[384] = 'I0B3'
    set ib_itemName[384] = "六道仙杖"
    set ib_itemCustom[384] = 1
    set ib_itemList[385] = 'I0B4'
    set ib_itemName[385] = "六道仙杖"
    set ib_itemCustom[385] = 1
    set ib_itemList[386] = 'I0B5'
    set ib_itemName[386] = "六道仙杖"
    set ib_itemCustom[386] = 1
    set ib_itemList[387] = 'I0B6'
    set ib_itemName[387] = "六道仙杖"
    set ib_itemCustom[387] = 1
    set ib_itemList[388] = 'I0B7'
    set ib_itemName[388] = "六道仙杖"
    set ib_itemCustom[388] = 1
    set ib_itemList[389] = 'I0B8'
    set ib_itemName[389] = "六道仙杖"
    set ib_itemCustom[389] = 1
    set ib_itemList[390] = 'I0B9'
    set ib_itemName[390] = "领取 琥珀净瓶"
    set ib_itemCustom[390] = 1
    set ib_itemList[391] = 'I0BA'
    set ib_itemName[391] = "传达 - (轻语)"
    set ib_itemCustom[391] = 1
    set ib_itemList[392] = 'I0BB'
    set ib_itemName[392] = "传达 - 信息(冬冬)"
    set ib_itemCustom[392] = 1
    set ib_itemList[393] = 'I0BC'
    set ib_itemName[393] = "传达 - 信息(唯恋)"
    set ib_itemCustom[393] = 1
    set ib_itemList[394] = 'I0BD'
    set ib_itemName[394] = "进入 野外训练场"
    set ib_itemCustom[394] = 1
    set ib_itemList[395] = 'I0BE'
    set ib_itemName[395] = "开启隐藏boss"
    set ib_itemCustom[395] = 1
    set ib_itemList[396] = 'I0BF'
    set ib_itemName[396] = "挑战自我 x 5大水"
    set ib_itemCustom[396] = 1
    set ib_itemList[397] = 'I0BG'
    set ib_itemName[397] = "挑战自我 x 10大水"
    set ib_itemCustom[397] = 1
    set ib_itemList[398] = 'I0BH'
    set ib_itemName[398] = "觉醒 转世力量"
    set ib_itemCustom[398] = 1
    set ib_itemList[399] = 'I0BI'
    set ib_itemName[399] = "神之语"
    set ib_itemCustom[399] = 1
endfunction
function IB_Fill5 takes nothing returns nothing
    set ib_itemList[400] = 'I0BJ'
    set ib_itemName[400] = "探索.眼镜"
    set ib_itemCustom[400] = 1
    set ib_itemList[401] = 'I0BK'
    set ib_itemName[401] = "合成 神之语"
    set ib_itemCustom[401] = 1
    set ib_itemList[402] = 'I000'
    set ib_itemName[402] = "[兑换]祥云坠饰"
    set ib_itemCustom[402] = 1
    set ib_itemList[403] = 'I003'
    set ib_itemName[403] = "神之宝藏"
    set ib_itemCustom[403] = 1
    set ib_itemList[404] = 'I006'
    set ib_itemName[404] = "神之强化石"
    set ib_itemCustom[404] = 1
    set ib_itemList[405] = 'I008'
    set ib_itemName[405] = "绷带"
    set ib_itemCustom[405] = 1
    set ib_itemList[406] = 'I03U'
    set ib_itemName[406] = "戒指.玄"
    set ib_itemCustom[406] = 1
    set ib_itemList[407] = 'I03V'
    set ib_itemName[407] = "换取-祥云坠饰"
    set ib_itemCustom[407] = 1
    set ib_itemList[408] = 'I0BL'
    set ib_itemName[408] = "换取-恐惧与信念"
    set ib_itemCustom[408] = 1
    set ib_itemList[409] = 'I0BM'
    set ib_itemName[409] = "换取-血雾之乡"
    set ib_itemCustom[409] = 1
    set ib_itemList[410] = 'I0BN'
    set ib_itemName[410] = "附有划痕的护额"
    set ib_itemCustom[410] = 1
endfunction

function IB_FillStep takes nothing returns nothing
    if ib_fillIdx == 0 then
        call IB_Fill0()
    elseif ib_fillIdx == 1 then
        call IB_Fill1()
    elseif ib_fillIdx == 2 then
        call IB_Fill2()
    elseif ib_fillIdx == 3 then
        call IB_Fill3()
    elseif ib_fillIdx == 4 then
        call IB_Fill4()
    elseif ib_fillIdx == 5 then
        call IB_Fill5()
    endif
    set ib_fillIdx = ib_fillIdx + 1
    if ib_fillIdx >= ib_fillTotal then
        set ib_itemCount = 411
        call PauseTimer(ib_fillTimer)
        call DestroyTimer(ib_fillTimer)
        set ib_fillTimer = null
    endif
endfunction

function IB_Init takes nothing returns nothing
    set ib_itemCount = 0
    call IB_RegisterChat()
    call DisplayTimedTextToPlayer(Player(0), 0, 0, 60.0, "|cff00ff00[装备]|r IB_Init 已执行")
    set ib_fillIdx = 0
    set ib_fillTotal = 6
    set ib_fillTimer = CreateTimer()
    call TimerStart(ib_fillTimer, 0.01, true, function IB_FillStep)
endfunction

//---------------------------------------------------------------------------
// 分帧填充:每帧调用一个 IB_FillN,全部完成后设置 ib_itemCount
//---------------------------------------------------------------------------
