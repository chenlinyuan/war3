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
        // 精确匹配 或 ID 匹配
        if name == ib_addName or IB_IdStr(ib_itemList[ib_addIdx]) == ib_addName then
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
// 入口：直接填充预扫描的物品 ID 列表，立即注册聊天事件（无需枚举）
//---------------------------------------------------------------------------
function IB_Fill0 takes nothing returns nothing
    set ib_itemList[0] = 'ckng'
    set ib_itemName[0] = "国王之冠 +5"
    set ib_itemCustom[0] = 0
    set ib_itemList[1] = 'modt'
    set ib_itemName[1] = "死亡面罩"
    set ib_itemCustom[1] = 0
    set ib_itemList[2] = 'tkno'
    set ib_itemName[2] = "能量之书"
    set ib_itemCustom[2] = 0
    set ib_itemList[3] = 'ratf'
    set ib_itemName[3] = "攻击之爪 +15"
    set ib_itemCustom[3] = 0
    set ib_itemList[4] = 'rde4'
    set ib_itemName[4] = "守护指环 +5"
    set ib_itemCustom[4] = 0
    set ib_itemList[5] = 'ofro'
    set ib_itemName[5] = "霜冻之球"
    set ib_itemCustom[5] = 0
    set ib_itemList[6] = 'desc'
    set ib_itemName[6] = "科勒恩的逃脱匕首"
    set ib_itemCustom[6] = 0
    set ib_itemList[7] = 'fgdg'
    set ib_itemName[7] = "恶魔雕像"
    set ib_itemCustom[7] = 0
    set ib_itemList[8] = 'infs'
    set ib_itemName[8] = "恶魔岩石"
    set ib_itemCustom[8] = 0
    set ib_itemList[9] = 'shar'
    set ib_itemName[9] = "冰冻碎片"
    set ib_itemCustom[9] = 0
    set ib_itemList[10] = 'sand'
    set ib_itemName[10] = "操作死尸卷轴"
    set ib_itemCustom[10] = 0
    set ib_itemList[11] = 'wild'
    set ib_itemName[11] = "野性护身符"
    set ib_itemCustom[11] = 0
    set ib_itemList[12] = 'srrc'
    set ib_itemName[12] = "复活卷轴"
    set ib_itemCustom[12] = 0
    set ib_itemList[13] = 'odef'
    set ib_itemName[13] = "黑暗之球"
    set ib_itemCustom[13] = 0
    set ib_itemList[14] = 'rde3'
    set ib_itemName[14] = "守护指环 +4"
    set ib_itemCustom[14] = 0
    set ib_itemList[15] = 'pmna'
    set ib_itemName[15] = "魔法垂饰"
    set ib_itemCustom[15] = 0
    set ib_itemList[16] = 'rhth'
    set ib_itemName[16] = "卡嘉医疗宝石"
    set ib_itemCustom[16] = 0
    set ib_itemList[17] = 'ssil'
    set ib_itemName[17] = "沉默权杖"
    set ib_itemCustom[17] = 0
    set ib_itemList[18] = 'spsh'
    set ib_itemName[18] = "魔法护盾护身符"
    set ib_itemCustom[18] = 0
    set ib_itemList[19] = 'sres'
    set ib_itemName[19] = "恢复卷轴"
    set ib_itemCustom[19] = 0
    set ib_itemList[20] = 'pdiv'
    set ib_itemName[20] = "神圣药水"
    set ib_itemCustom[20] = 0
    set ib_itemList[21] = 'pres'
    set ib_itemName[21] = "恢复药水"
    set ib_itemCustom[21] = 0
    set ib_itemList[22] = 'totw'
    set ib_itemName[22] = "野性护符"
    set ib_itemCustom[22] = 0
    set ib_itemList[23] = 'fgfh'
    set ib_itemName[23] = "长钉衣领"
    set ib_itemCustom[23] = 0
    set ib_itemList[24] = 'fgrd'
    set ib_itemName[24] = "红龙之卵"
    set ib_itemCustom[24] = 0
    set ib_itemList[25] = 'fgrg'
    set ib_itemName[25] = "岩石印记"
    set ib_itemCustom[25] = 0
    set ib_itemList[26] = 'hcun'
    set ib_itemName[26] = "灵巧头巾"
    set ib_itemCustom[26] = 0
    set ib_itemList[27] = 'hval'
    set ib_itemName[27] = "英勇面具"
    set ib_itemCustom[27] = 0
    set ib_itemList[28] = 'mcou'
    set ib_itemName[28] = "勇气勋章"
    set ib_itemCustom[28] = 0
    set ib_itemList[29] = 'ajen'
    set ib_itemName[29] = "古之忍耐姜歌"
    set ib_itemCustom[29] = 0
    set ib_itemList[30] = 'clfm'
    set ib_itemName[30] = "火焰风衣"
    set ib_itemCustom[30] = 0
    set ib_itemList[31] = 'ratc'
    set ib_itemName[31] = "攻击之爪 +12"
    set ib_itemCustom[31] = 0
    set ib_itemList[32] = 'ward'
    set ib_itemName[32] = "战歌之鼓"
    set ib_itemCustom[32] = 0
    set ib_itemList[33] = 'kpin'
    set ib_itemName[33] = "卡嘉长萧"
    set ib_itemCustom[33] = 0
    set ib_itemList[34] = 'crys'
    set ib_itemName[34] = "水晶球"
    set ib_itemCustom[34] = 0
    set ib_itemList[35] = 'lgdh'
    set ib_itemName[35] = "毁灭之角"
    set ib_itemCustom[35] = 0
    set ib_itemList[36] = 'ankh'
    set ib_itemName[36] = "重生十字章"
    set ib_itemCustom[36] = 0
    set ib_itemList[37] = 'whwd'
    set ib_itemName[37] = "风少爷(qq171246484)"
    set ib_itemCustom[37] = 0
    set ib_itemList[38] = 'fgsk'
    set ib_itemName[38] = "死亡之书"
    set ib_itemCustom[38] = 0
    set ib_itemList[39] = 'wcyc'
    set ib_itemName[39] = "飓风权杖"
    set ib_itemCustom[39] = 0
    set ib_itemList[40] = 'hlst'
    set ib_itemName[40] = "医疗石"
    set ib_itemCustom[40] = 0
    set ib_itemList[41] = 'mnst'
    set ib_itemName[41] = "魔法石"
    set ib_itemCustom[41] = 0
    set ib_itemList[42] = 'belv'
    set ib_itemName[42] = "奎尔萨拉斯之靴 +6"
    set ib_itemCustom[42] = 0
    set ib_itemList[43] = 'bgst'
    set ib_itemName[43] = "巨人力量腰带+6"
    set ib_itemCustom[43] = 0
    set ib_itemList[44] = 'ciri'
    set ib_itemName[44] = "法师长袍 +6"
    set ib_itemCustom[44] = 0
    set ib_itemList[45] = 'lhst'
    set ib_itemName[45] = "风暴狮角"
    set ib_itemCustom[45] = 0
    set ib_itemList[46] = 'afac'
    set ib_itemName[46] = "阿利亚之笛"
    set ib_itemCustom[46] = 0
    set ib_itemList[47] = 'sbch'
    set ib_itemName[47] = "天灾骨钟"
    set ib_itemCustom[47] = 0
    set ib_itemList[48] = 'brac'
    set ib_itemName[48] = "神秘腰带"
    set ib_itemCustom[48] = 0
    set ib_itemList[49] = 'rwiz'
    set ib_itemName[49] = "艺人面罩"
    set ib_itemCustom[49] = 0
    set ib_itemList[50] = 'pghe'
    set ib_itemName[50] = "大生命药水"
    set ib_itemCustom[50] = 0
    set ib_itemList[51] = 'pgma'
    set ib_itemName[51] = "大魔法药水"
    set ib_itemCustom[51] = 0
    set ib_itemList[52] = 'pnvu'
    set ib_itemName[52] = "无敌药水"
    set ib_itemCustom[52] = 0
    set ib_itemList[53] = 'sror'
    set ib_itemName[53] = "野兽卷轴"
    set ib_itemCustom[53] = 0
    set ib_itemList[54] = 'woms'
    set ib_itemName[54] = "魔法盗取权杖"
    set ib_itemCustom[54] = 0
    set ib_itemList[55] = 'evtl'
    set ib_itemName[55] = "闪避护符"
    set ib_itemCustom[55] = 0
    set ib_itemList[56] = 'penr'
    set ib_itemName[56] = "能量垂饰"
    set ib_itemCustom[56] = 0
    set ib_itemList[57] = 'prvt'
    set ib_itemName[57] = "生命护身符"
    set ib_itemCustom[57] = 0
    set ib_itemList[58] = 'rat9'
    set ib_itemName[58] = "攻击之爪 +9"
    set ib_itemCustom[58] = 0
    set ib_itemList[59] = 'rde2'
    set ib_itemName[59] = "守护指环 +3"
    set ib_itemCustom[59] = 0
    set ib_itemList[60] = 'rlif'
    set ib_itemName[60] = "恢复指环"
    set ib_itemCustom[60] = 0
    set ib_itemList[61] = 'bspd'
    set ib_itemName[61] = "速度之靴"
    set ib_itemCustom[61] = 0
    set ib_itemList[62] = 'rej3'
    set ib_itemName[62] = "恢复药水"
    set ib_itemCustom[62] = 0
    set ib_itemList[63] = 'will'
    set ib_itemName[63] = "幻象权杖"
    set ib_itemCustom[63] = 0
    set ib_itemList[64] = 'wlsd'
    set ib_itemName[64] = "闪电护盾权杖"
    set ib_itemCustom[64] = 0
    set ib_itemList[65] = 'wswd'
    set ib_itemName[65] = "岗哨守卫"
    set ib_itemCustom[65] = 0
    set ib_itemList[66] = 'cnob'
    set ib_itemName[66] = "贵族圆环"
    set ib_itemCustom[66] = 0
    set ib_itemList[67] = 'gcel'
    set ib_itemName[67] = "加速手套"
    set ib_itemCustom[67] = 0
    set ib_itemList[68] = 'rat6'
    set ib_itemName[68] = "攻击之爪 +6"
    set ib_itemCustom[68] = 0
    set ib_itemList[69] = 'rde1'
    set ib_itemName[69] = "守护指环 +2"
    set ib_itemCustom[69] = 0
    set ib_itemList[70] = 'tdx2'
    set ib_itemName[70] = "敏捷之书 +10000"
    set ib_itemCustom[70] = 0
    set ib_itemList[71] = 'texp'
    set ib_itemName[71] = "超级经验之书"
    set ib_itemCustom[71] = 0
    set ib_itemList[72] = 'tin2'
    set ib_itemName[72] = "智力之书 +10000"
    set ib_itemCustom[72] = 0
    set ib_itemList[73] = 'tpow'
    set ib_itemName[73] = "知识之书+100"
    set ib_itemCustom[73] = 0
    set ib_itemList[74] = 'tst2'
    set ib_itemName[74] = "力量之书 +10000"
    set ib_itemCustom[74] = 0
    set ib_itemList[75] = 'pnvl'
    set ib_itemName[75] = "较小的无敌药水"
    set ib_itemCustom[75] = 0
    set ib_itemList[76] = 'clsd'
    set ib_itemName[76] = "影子风衣"
    set ib_itemCustom[76] = 0
    set ib_itemList[77] = 'rag1'
    set ib_itemName[77] = "敏捷便鞋  +3"
    set ib_itemCustom[77] = 0
    set ib_itemList[78] = 'rin1'
    set ib_itemName[78] = "智力斗篷 +3"
    set ib_itemCustom[78] = 0
    set ib_itemList[79] = 'rst1'
    set ib_itemName[79] = "食人鬼手套 +3"
    set ib_itemCustom[79] = 0
endfunction
function IB_Fill1 takes nothing returns nothing
    set ib_itemList[80] = 'manh'
    set ib_itemName[80] = "生命手册"
    set ib_itemCustom[80] = 0
    set ib_itemList[81] = 'tdex'
    set ib_itemName[81] = "敏捷之书+100"
    set ib_itemCustom[81] = 0
    set ib_itemList[82] = 'tint'
    set ib_itemName[82] = "智力之书+100"
    set ib_itemCustom[82] = 0
    set ib_itemList[83] = 'tstr'
    set ib_itemName[83] = "力量之书+100"
    set ib_itemCustom[83] = 0
    set ib_itemList[84] = 'pomn'
    set ib_itemName[84] = "全知药水"
    set ib_itemCustom[84] = 0
    set ib_itemList[85] = 'wshs'
    set ib_itemName[85] = "影子权杖"
    set ib_itemCustom[85] = 0
    set ib_itemList[86] = 'rej6'
    set ib_itemName[86] = "大型恢复卷轴"
    set ib_itemCustom[86] = 0
    set ib_itemList[87] = 'rej5'
    set ib_itemName[87] = "小型恢复卷轴"
    set ib_itemCustom[87] = 0
    set ib_itemList[88] = 'rej4'
    set ib_itemName[88] = "大型恢复药水"
    set ib_itemCustom[88] = 0
    set ib_itemList[89] = 'ram4'
    set ib_itemName[89] = "大魔法师指环"
    set ib_itemCustom[89] = 0
    set ib_itemList[90] = 'dsum'
    set ib_itemName[90] = "召唤钻石"
    set ib_itemCustom[90] = 0
    set ib_itemList[91] = 'ofir'
    set ib_itemName[91] = "火焰之球"
    set ib_itemCustom[91] = 0
    set ib_itemList[92] = 'ocor'
    set ib_itemName[92] = "腐蚀之球"
    set ib_itemCustom[92] = 0
    set ib_itemList[93] = 'oli2'
    set ib_itemName[93] = "闪电之球"
    set ib_itemCustom[93] = 0
    set ib_itemList[94] = 'oven'
    set ib_itemName[94] = "毒液之球"
    set ib_itemCustom[94] = 0
    set ib_itemList[95] = 'ram3'
    set ib_itemName[95] = "大魔法师指环"
    set ib_itemCustom[95] = 0
    set ib_itemList[96] = 'tret'
    set ib_itemName[96] = "再训练之书"
    set ib_itemCustom[96] = 0
    set ib_itemList[97] = 'tgrh'
    set ib_itemName[97] = "小型的大厅"
    set ib_itemCustom[97] = 0
    set ib_itemList[98] = 'rej2'
    set ib_itemName[98] = "小型恢复药水"
    set ib_itemCustom[98] = 0
    set ib_itemList[99] = 'gemt'
    set ib_itemName[99] = "显形宝石"
    set ib_itemCustom[99] = 0
    set ib_itemList[100] = 'ram2'
    set ib_itemName[100] = "大魔法师指环"
    set ib_itemCustom[100] = 0
    set ib_itemList[101] = 'stel'
    set ib_itemName[101] = "星辰权杖"
    set ib_itemCustom[101] = 0
    set ib_itemList[102] = 'stwp'
    set ib_itemName[102] = "回城卷轴"
    set ib_itemCustom[102] = 0
    set ib_itemList[103] = 'wneg'
    set ib_itemName[103] = "否决权杖"
    set ib_itemCustom[103] = 0
    set ib_itemList[104] = 'sneg'
    set ib_itemName[104] = "否决权杖"
    set ib_itemCustom[104] = 0
    set ib_itemList[105] = 'wneu'
    set ib_itemName[105] = "中和权杖"
    set ib_itemCustom[105] = 0
    set ib_itemList[106] = 'shea'
    set ib_itemName[106] = "医疗卷轴"
    set ib_itemCustom[106] = 0
    set ib_itemList[107] = 'sman'
    set ib_itemName[107] = "魔法卷轴"
    set ib_itemCustom[107] = 0
    set ib_itemList[108] = 'rej1'
    set ib_itemName[108] = "小型恢复药水"
    set ib_itemCustom[108] = 0
    set ib_itemList[109] = 'pspd'
    set ib_itemName[109] = "速度药水"
    set ib_itemCustom[109] = 0
    set ib_itemList[110] = 'dust'
    set ib_itemName[110] = "尘土之影"
    set ib_itemCustom[110] = 0
    set ib_itemList[111] = 'ram1'
    set ib_itemName[111] = "大魔法师指环"
    set ib_itemCustom[111] = 0
    set ib_itemList[112] = 'pinv'
    set ib_itemName[112] = "隐形药水"
    set ib_itemCustom[112] = 0
    set ib_itemList[113] = 'phea'
    set ib_itemName[113] = "生命药水"
    set ib_itemCustom[113] = 0
    set ib_itemList[114] = 'pman'
    set ib_itemName[114] = "魔法药水"
    set ib_itemCustom[114] = 0
    set ib_itemList[115] = 'spro'
    set ib_itemName[115] = "守护卷轴"
    set ib_itemCustom[115] = 0
    set ib_itemList[116] = 'hslv'
    set ib_itemName[116] = "医疗剂"
    set ib_itemCustom[116] = 0
    set ib_itemList[117] = 'moon'
    set ib_itemName[117] = "月亮石"
    set ib_itemCustom[117] = 0
    set ib_itemList[118] = 'shas'
    set ib_itemName[118] = "速度卷轴"
    set ib_itemCustom[118] = 0
    set ib_itemList[119] = 'skul'
    set ib_itemName[119] = "献祭头骨"
    set ib_itemCustom[119] = 0
    set ib_itemList[120] = 'mcri'
    set ib_itemName[120] = "机械类的小玩艺"
    set ib_itemCustom[120] = 0
    set ib_itemList[121] = 'rnec'
    set ib_itemName[121] = "巫术妖棍"
    set ib_itemCustom[121] = 0
    set ib_itemList[122] = 'tsct'
    set ib_itemName[122] = "象牙塔"
    set ib_itemCustom[122] = 0
    set ib_itemList[123] = 'azhr'
    set ib_itemName[123] = "埃苏尼之心"
    set ib_itemCustom[123] = 0
    set ib_itemList[124] = 'bzbe'
    set ib_itemName[124] = "空瓶"
    set ib_itemCustom[124] = 0
    set ib_itemList[125] = 'bzbf'
    set ib_itemName[125] = "盛满泉水的瓶子"
    set ib_itemCustom[125] = 0
    set ib_itemList[126] = 'ches'
    set ib_itemName[126] = "奶酪"
    set ib_itemCustom[126] = 0
    set ib_itemList[127] = 'cnhn'
    set ib_itemName[127] = "赛纳留斯的号角"
    set ib_itemCustom[127] = 0
    set ib_itemList[128] = 'glsk'
    set ib_itemName[128] = "古尔丹之颅"
    set ib_itemCustom[128] = 0
    set ib_itemList[129] = 'gopr'
    set ib_itemName[129] = "净化浮雕"
    set ib_itemCustom[129] = 0
    set ib_itemList[130] = 'k3m1'
    set ib_itemName[130] = "月亮水晶"
    set ib_itemCustom[130] = 0
    set ib_itemList[131] = 'k3m2'
    set ib_itemName[131] = "三月之钥的另外一个部分"
    set ib_itemCustom[131] = 0
    set ib_itemList[132] = 'k3m3'
    set ib_itemName[132] = "三月之钥"
    set ib_itemCustom[132] = 0
    set ib_itemList[133] = 'ktrm'
    set ib_itemName[133] = "泰瑞纳斯国王的骨灰瓮"
    set ib_itemCustom[133] = 0
    set ib_itemList[134] = 'kybl'
    set ib_itemName[134] = "鲜血钥匙"
    set ib_itemCustom[134] = 0
    set ib_itemList[135] = 'kygh'
    set ib_itemName[135] = "魔鬼钥匙"
    set ib_itemCustom[135] = 0
    set ib_itemList[136] = 'kymn'
    set ib_itemName[136] = "月之钥匙"
    set ib_itemCustom[136] = 0
    set ib_itemList[137] = 'kysn'
    set ib_itemName[137] = "太阳钥匙"
    set ib_itemCustom[137] = 0
    set ib_itemList[138] = 'ledg'
    set ib_itemName[138] = "吉拉德的帐本"
    set ib_itemCustom[138] = 0
    set ib_itemList[139] = 'phlt'
    set ib_itemName[139] = "李维特"
    set ib_itemCustom[139] = 0
    set ib_itemList[140] = 'sehr'
    set ib_itemName[140] = "赛瑞诺克斯之心"
    set ib_itemCustom[140] = 0
    set ib_itemList[141] = 'engs'
    set ib_itemName[141] = "魔法宝石"
    set ib_itemCustom[141] = 0
    set ib_itemList[142] = 'sorf'
    set ib_itemName[142] = "影子之球碎片"
    set ib_itemCustom[142] = 0
    set ib_itemList[143] = 'gmfr'
    set ib_itemName[143] = "宝石碎片"
    set ib_itemCustom[143] = 0
    set ib_itemList[144] = 'jpnt'
    set ib_itemName[144] = "给吉安娜?普罗德摩尔的便条"
    set ib_itemCustom[144] = 0
    set ib_itemList[145] = 'shwd'
    set ib_itemName[145] = "荧光草"
    set ib_itemCustom[145] = 0
    set ib_itemList[146] = 'skrt'
    set ib_itemName[146] = "骸骨宝物"
    set ib_itemCustom[146] = 0
    set ib_itemList[147] = 'thle'
    set ib_itemName[147] = "雷霆蜥蜴之蛋"
    set ib_itemCustom[147] = 0
    set ib_itemList[148] = 'sclp'
    set ib_itemName[148] = "秘密关卡激活"
    set ib_itemCustom[148] = 0
    set ib_itemList[149] = 'wtlg'
    set ib_itemName[149] = "怀特之腿"
    set ib_itemCustom[149] = 0
    set ib_itemList[150] = 'wolg'
    set ib_itemName[150] = "怀特的另一条腿"
    set ib_itemCustom[150] = 0
    set ib_itemList[151] = 'mgtk'
    set ib_itemName[151] = "魔法钥匙串"
    set ib_itemCustom[151] = 0
    set ib_itemList[152] = 'mort'
    set ib_itemName[152] = "莫哥林的报告"
    set ib_itemCustom[152] = 0
    set ib_itemList[153] = 'dphe'
    set ib_itemName[153] = "雷霆凤凰蛋"
    set ib_itemCustom[153] = 0
    set ib_itemList[154] = 'dkfw'
    set ib_itemName[154] = "雷霆水桶"
    set ib_itemCustom[154] = 0
    set ib_itemList[155] = 'dthb'
    set ib_itemName[155] = "雷电花芯"
    set ib_itemCustom[155] = 0
    set ib_itemList[156] = 'fgun'
    set ib_itemName[156] = "信号枪"
    set ib_itemCustom[156] = 0
    set ib_itemList[157] = 'lure'
    set ib_itemName[157] = "怪兽诱捕守卫"
    set ib_itemCustom[157] = 0
    set ib_itemList[158] = 'olig'
    set ib_itemName[158] = "闪电之球"
    set ib_itemCustom[158] = 0
    set ib_itemList[159] = 'amrc'
    set ib_itemName[159] = "召唤护身符"
    set ib_itemCustom[159] = 0
endfunction
function IB_Fill2 takes nothing returns nothing
    set ib_itemList[160] = 'ccmd'
    set ib_itemName[160] = "统治权杖"
    set ib_itemCustom[160] = 0
    set ib_itemList[161] = 'flag'
    set ib_itemName[161] = "人族旗帜"
    set ib_itemCustom[161] = 0
    set ib_itemList[162] = 'gobm'
    set ib_itemName[162] = "地精地雷"
    set ib_itemCustom[162] = 0
    set ib_itemList[163] = 'gsou'
    set ib_itemName[163] = "灵魂宝石"
    set ib_itemCustom[163] = 0
    set ib_itemList[164] = 'nflg'
    set ib_itemName[164] = "暗夜精灵族旗帜"
    set ib_itemCustom[164] = 0
    set ib_itemList[165] = 'nspi'
    set ib_itemName[165] = "魔法免疫项链"
    set ib_itemCustom[165] = 0
    set ib_itemList[166] = 'oflg'
    set ib_itemName[166] = "兽族旗帜"
    set ib_itemCustom[166] = 0
    set ib_itemList[167] = 'pams'
    set ib_itemName[167] = "抗体药水"
    set ib_itemCustom[167] = 0
    set ib_itemList[168] = 'pgin'
    set ib_itemName[168] = "大隐形药水"
    set ib_itemCustom[168] = 0
    set ib_itemList[169] = 'rat3'
    set ib_itemName[169] = "攻击之爪 +3"
    set ib_itemCustom[169] = 0
    set ib_itemList[170] = 'rde0'
    set ib_itemName[170] = "守护指环 +1"
    set ib_itemCustom[170] = 0
    set ib_itemList[171] = 'rnsp'
    set ib_itemName[171] = "优越之戒"
    set ib_itemCustom[171] = 0
    set ib_itemList[172] = 'soul'
    set ib_itemName[172] = "灵魂"
    set ib_itemCustom[172] = 0
    set ib_itemList[173] = 'tels'
    set ib_itemName[173] = "地精夜视镜"
    set ib_itemCustom[173] = 0
    set ib_itemList[174] = 'tgxp'
    set ib_itemName[174] = "超级经验之书"
    set ib_itemCustom[174] = 0
    set ib_itemList[175] = 'uflg'
    set ib_itemName[175] = "不死族旗帜"
    set ib_itemCustom[175] = 0
    set ib_itemList[176] = 'anfg'
    set ib_itemName[176] = "远古雕像"
    set ib_itemCustom[176] = 0
    set ib_itemList[177] = 'brag'
    set ib_itemName[177] = "敏捷腰带"
    set ib_itemCustom[177] = 0
    set ib_itemList[178] = 'drph'
    set ib_itemName[178] = "德鲁伊布袋"
    set ib_itemCustom[178] = 0
    set ib_itemList[179] = 'iwbr'
    set ib_itemName[179] = "铁树枝干"
    set ib_itemCustom[179] = 0
    set ib_itemList[180] = 'jdrn'
    set ib_itemName[180] = "灵巧指环"
    set ib_itemCustom[180] = 0
    set ib_itemList[181] = 'lnrn'
    set ib_itemName[181] = "雄狮之戒"
    set ib_itemCustom[181] = 0
    set ib_itemList[182] = 'mlst'
    set ib_itemName[182] = "力量之锤"
    set ib_itemCustom[182] = 0
    set ib_itemList[183] = 'oslo'
    set ib_itemName[183] = "减速之球"
    set ib_itemCustom[183] = 0
    set ib_itemList[184] = 'sbok'
    set ib_itemName[184] = "魔法书"
    set ib_itemCustom[184] = 0
    set ib_itemList[185] = 'sksh'
    set ib_itemName[185] = "防护面具"
    set ib_itemCustom[185] = 0
    set ib_itemList[186] = 'sprn'
    set ib_itemName[186] = "蜘蛛戒指"
    set ib_itemCustom[186] = 0
    set ib_itemList[187] = 'tmmt'
    set ib_itemName[187] = "力量图腾"
    set ib_itemCustom[187] = 0
    set ib_itemList[188] = 'vddl'
    set ib_itemName[188] = "巫毒玩偶"
    set ib_itemCustom[188] = 0
    set ib_itemList[189] = 'spre'
    set ib_itemName[189] = "保存权杖"
    set ib_itemCustom[189] = 0
    set ib_itemList[190] = 'sfog'
    set ib_itemName[190] = "乌云号角"
    set ib_itemCustom[190] = 0
    set ib_itemList[191] = 'sor1'
    set ib_itemName[191] = "影子之球 +1"
    set ib_itemCustom[191] = 0
    set ib_itemList[192] = 'sor2'
    set ib_itemName[192] = "影子之球 +2"
    set ib_itemCustom[192] = 0
    set ib_itemList[193] = 'sor3'
    set ib_itemName[193] = "影子之球 +3"
    set ib_itemCustom[193] = 0
    set ib_itemList[194] = 'sor4'
    set ib_itemName[194] = "影子之球 +4"
    set ib_itemCustom[194] = 0
    set ib_itemList[195] = 'sor5'
    set ib_itemName[195] = "影子之球 +5"
    set ib_itemCustom[195] = 0
    set ib_itemList[196] = 'sor6'
    set ib_itemName[196] = "影子之球 +6"
    set ib_itemCustom[196] = 0
    set ib_itemList[197] = 'sor7'
    set ib_itemName[197] = "影子之球 +7"
    set ib_itemCustom[197] = 0
    set ib_itemList[198] = 'sor8'
    set ib_itemName[198] = "影子之球 +8"
    set ib_itemCustom[198] = 0
    set ib_itemList[199] = 'sor9'
    set ib_itemName[199] = "影子之球 +9"
    set ib_itemCustom[199] = 0
    set ib_itemList[200] = 'sora'
    set ib_itemName[200] = "影子之球 +10"
    set ib_itemCustom[200] = 0
    set ib_itemList[201] = 'fwss'
    set ib_itemName[201] = "冰霜巨龙头骨护盾"
    set ib_itemCustom[201] = 0
    set ib_itemList[202] = 'shtm'
    set ib_itemName[202] = "萨满图腾"
    set ib_itemCustom[202] = 0
    set ib_itemList[203] = 'esaz'
    set ib_itemName[203] = "埃苏尼之精髓"
    set ib_itemCustom[203] = 0
    set ib_itemList[204] = 'btst'
    set ib_itemName[204] = "战斗标准"
    set ib_itemCustom[204] = 0
    set ib_itemList[205] = 'tbsm'
    set ib_itemName[205] = "微型铁匠铺"
    set ib_itemCustom[205] = 0
    set ib_itemList[206] = 'tfar'
    set ib_itemName[206] = "微型农场"
    set ib_itemCustom[206] = 0
    set ib_itemList[207] = 'tlum'
    set ib_itemName[207] = "微型伐木场"
    set ib_itemCustom[207] = 0
    set ib_itemList[208] = 'tbar'
    set ib_itemName[208] = "微型兵营"
    set ib_itemCustom[208] = 0
    set ib_itemList[209] = 'tbak'
    set ib_itemName[209] = "微型国王祭坛"
    set ib_itemCustom[209] = 0
    set ib_itemList[210] = 'gldo'
    set ib_itemName[210] = "基尔加丹之球"
    set ib_itemCustom[210] = 0
    set ib_itemList[211] = 'stre'
    set ib_itemName[211] = "鼓舞权杖"
    set ib_itemCustom[211] = 0
    set ib_itemList[212] = 'horl'
    set ib_itemName[212] = "稀有神器"
    set ib_itemCustom[212] = 0
    set ib_itemList[213] = 'hbth'
    set ib_itemName[213] = "战舰之舵"
    set ib_itemCustom[213] = 0
    set ib_itemList[214] = 'blba'
    set ib_itemName[214] = "剑刃护甲"
    set ib_itemCustom[214] = 0
    set ib_itemList[215] = 'rugt'
    set ib_itemName[215] = "神秘手套"
    set ib_itemCustom[215] = 0
    set ib_itemList[216] = 'frhg'
    set ib_itemName[216] = "火焰手套"
    set ib_itemCustom[216] = 0
    set ib_itemList[217] = 'gvsm'
    set ib_itemName[217] = "法术大师手套"
    set ib_itemCustom[217] = 0
    set ib_itemList[218] = 'crdt'
    set ib_itemName[218] = "死亡领主皇冠"
    set ib_itemCustom[218] = 0
    set ib_itemList[219] = 'arsc'
    set ib_itemName[219] = "神秘卷轴"
    set ib_itemCustom[219] = 0
    set ib_itemList[220] = 'scul'
    set ib_itemName[220] = "邪恶军团卷轴"
    set ib_itemCustom[220] = 0
    set ib_itemList[221] = 'tmsc'
    set ib_itemName[221] = "牺牲之书"
    set ib_itemCustom[221] = 0
    set ib_itemList[222] = 'dtsb'
    set ib_itemName[222] = "德雷克萨尔魔法书"
    set ib_itemCustom[222] = 0
    set ib_itemList[223] = 'grsl'
    set ib_itemName[223] = "灵魂宝物"
    set ib_itemCustom[223] = 0
    set ib_itemList[224] = 'arsh'
    set ib_itemName[224] = "芒硝护盾"
    set ib_itemCustom[224] = 0
    set ib_itemList[225] = 'shdt'
    set ib_itemName[225] = "死亡领主护盾"
    set ib_itemCustom[225] = 0
    set ib_itemList[226] = 'shhn'
    set ib_itemName[226] = "荣誉护盾"
    set ib_itemCustom[226] = 0
    set ib_itemList[227] = 'shen'
    set ib_itemName[227] = "施魔护盾"
    set ib_itemCustom[227] = 0
    set ib_itemList[228] = 'thdm'
    set ib_itemName[228] = "雷霆蜥蜴钻石"
    set ib_itemCustom[228] = 0
    set ib_itemList[229] = 'stpg'
    set ib_itemName[229] = "时钟企鹅"
    set ib_itemCustom[229] = 0
    set ib_itemList[230] = 'shrs'
    set ib_itemName[230] = "烤肉"
    set ib_itemCustom[230] = 0
    set ib_itemList[231] = 'bfhr'
    set ib_itemName[231] = "血羽之心"
    set ib_itemCustom[231] = 0
    set ib_itemList[232] = 'cosl'
    set ib_itemName[232] = "灵魂之球"
    set ib_itemCustom[232] = 0
    set ib_itemList[233] = 'shcw'
    set ib_itemName[233] = "萨满利爪"
    set ib_itemCustom[233] = 0
    set ib_itemList[234] = 'srbd'
    set ib_itemName[234] = "灼热之刀"
    set ib_itemCustom[234] = 0
    set ib_itemList[235] = 'frgd'
    set ib_itemName[235] = "霜冻守卫"
    set ib_itemCustom[235] = 0
    set ib_itemList[236] = 'envl'
    set ib_itemName[236] = "魔法小瓶"
    set ib_itemCustom[236] = 0
    set ib_itemList[237] = 'rump'
    set ib_itemName[237] = "生锈的矿铲"
    set ib_itemCustom[237] = 0
    set ib_itemList[238] = 'srtl'
    set ib_itemName[238] = "瑟拉思尔"
    set ib_itemCustom[238] = 0
    set ib_itemList[239] = 'stwa'
    set ib_itemName[239] = "战斧"
    set ib_itemCustom[239] = 0
endfunction
function IB_Fill3 takes nothing returns nothing
    set ib_itemList[240] = 'klmm'
    set ib_itemName[240] = "远古战斧"
    set ib_itemCustom[240] = 0
    set ib_itemList[241] = 'rots'
    set ib_itemName[241] = "海之权杖"
    set ib_itemCustom[241] = 0
    set ib_itemList[242] = 'axas'
    set ib_itemName[242] = "先祖权杖"
    set ib_itemCustom[242] = 0
    set ib_itemList[243] = 'mnsf'
    set ib_itemName[243] = "心灵权杖"
    set ib_itemCustom[243] = 0
    set ib_itemList[244] = 'schl'
    set ib_itemName[244] = "医疗权杖"
    set ib_itemCustom[244] = 0
    set ib_itemList[245] = 'asbl'
    set ib_itemName[245] = "刺客佩刀"
    set ib_itemCustom[245] = 0
    set ib_itemList[246] = 'kgal'
    set ib_itemName[246] = "麦酒桶"
    set ib_itemCustom[246] = 0
    set ib_itemList[247] = 'gold'
    set ib_itemName[247] = "金币"
    set ib_itemCustom[247] = 0
    set ib_itemList[248] = 'lmbr'
    set ib_itemName[248] = "木材堆"
    set ib_itemCustom[248] = 0
    set ib_itemList[249] = 'gfor'
    set ib_itemName[249] = "防御浮雕"
    set ib_itemCustom[249] = 0
    set ib_itemList[250] = 'guvi'
    set ib_itemName[250] = "夜视浮雕"
    set ib_itemCustom[250] = 0
    set ib_itemList[251] = 'rspl'
    set ib_itemName[251] = "灵魂锁链神符"
    set ib_itemCustom[251] = 0
    set ib_itemList[252] = 'rre1'
    set ib_itemName[252] = "小型复活神符"
    set ib_itemCustom[252] = 0
    set ib_itemList[253] = 'rre2'
    set ib_itemName[253] = "大型复活神符"
    set ib_itemCustom[253] = 0
    set ib_itemList[254] = 'gomn'
    set ib_itemName[254] = "全知浮雕"
    set ib_itemCustom[254] = 0
    set ib_itemList[255] = 'rsps'
    set ib_itemName[255] = "护盾神符"
    set ib_itemCustom[255] = 0
    set ib_itemList[256] = 'rspd'
    set ib_itemName[256] = "速度神符"
    set ib_itemCustom[256] = 0
    set ib_itemList[257] = 'rman'
    set ib_itemName[257] = "魔法神符"
    set ib_itemCustom[257] = 0
    set ib_itemList[258] = 'rma2'
    set ib_itemName[258] = "大型魔法神符"
    set ib_itemCustom[258] = 0
    set ib_itemList[259] = 'rres'
    set ib_itemName[259] = "恢复神符"
    set ib_itemCustom[259] = 0
    set ib_itemList[260] = 'rreb'
    set ib_itemName[260] = "重生神符"
    set ib_itemCustom[260] = 0
    set ib_itemList[261] = 'rhe1'
    set ib_itemName[261] = "小型治疗神符"
    set ib_itemCustom[261] = 0
    set ib_itemList[262] = 'rhe2'
    set ib_itemName[262] = "治疗神符"
    set ib_itemCustom[262] = 0
    set ib_itemList[263] = 'rhe3'
    set ib_itemName[263] = "大型治疗神符"
    set ib_itemCustom[263] = 0
    set ib_itemList[264] = 'rdis'
    set ib_itemName[264] = "驱魔神符"
    set ib_itemCustom[264] = 0
    set ib_itemList[265] = 'rwat'
    set ib_itemName[265] = "岗哨神符"
    set ib_itemCustom[265] = 0
    set ib_itemList[266] = 'pclr'
    set ib_itemName[266] = "净化药水"
    set ib_itemCustom[266] = 0
    set ib_itemList[267] = 'plcl'
    set ib_itemName[267] = "小净化药水"
    set ib_itemCustom[267] = 0
    set ib_itemList[268] = 'silk'
    set ib_itemName[268] = "蜘蛛丝饰针"
    set ib_itemCustom[268] = 0
    set ib_itemList[269] = 'vamp'
    set ib_itemName[269] = "吸血药水"
    set ib_itemCustom[269] = 0
    set ib_itemList[270] = 'sreg'
    set ib_itemName[270] = "恢复卷轴"
    set ib_itemCustom[270] = 0
    set ib_itemList[271] = 'ssan'
    set ib_itemName[271] = "避难权杖"
    set ib_itemCustom[271] = 0
    set ib_itemList[272] = 'tcas'
    set ib_itemName[272] = "小城堡"
    set ib_itemCustom[272] = 0
    set ib_itemList[273] = 'I000'
    set ib_itemName[273] = "风痕之刃"
    set ib_itemCustom[273] = 1
    set ib_itemList[274] = 'I010'
    set ib_itemName[274] = "攻击之爪(一级)"
    set ib_itemCustom[274] = 1
    set ib_itemList[275] = 'I030'
    set ib_itemName[275] = "飞哥圣神甲<gm>"
    set ib_itemCustom[275] = 1
    set ib_itemList[276] = 'I001'
    set ib_itemName[276] = "知识之书+10000"
    set ib_itemCustom[276] = 1
    set ib_itemList[277] = 'I011'
    set ib_itemName[277] = "攻击之爪(三级)"
    set ib_itemCustom[277] = 1
    set ib_itemList[278] = 'I021'
    set ib_itemName[278] = "落叶魂盔"
    set ib_itemCustom[278] = 1
    set ib_itemList[279] = 'I031'
    set ib_itemName[279] = "三转证明"
    set ib_itemCustom[279] = 1
    set ib_itemList[280] = 'TWN1'
    set ib_itemName[280] = "城镇大厅或者大厅或者生命之树或者大墓地"
    set ib_itemCustom[280] = 1
    set ib_itemList[281] = 'I002'
    set ib_itemName[281] = "1点木材换10000金币"
    set ib_itemCustom[281] = 1
    set ib_itemList[282] = 'I012'
    set ib_itemName[282] = "四兽之盾"
    set ib_itemCustom[282] = 1
    set ib_itemList[283] = 'I022'
    set ib_itemName[283] = "落叶魂爪"
    set ib_itemCustom[283] = 1
    set ib_itemList[284] = 'I032'
    set ib_itemName[284] = "魔界通道通行证"
    set ib_itemCustom[284] = 1
    set ib_itemList[285] = 'TWN2'
    set ib_itemName[285] = "主城或者要塞或者远古之树或者亡者大厅"
    set ib_itemCustom[285] = 1
    set ib_itemList[286] = 'I003'
    set ib_itemName[286] = "10000金币换1点木材"
    set ib_itemCustom[286] = 1
    set ib_itemList[287] = 'I013'
    set ib_itemName[287] = "疯魔之爪(一级)"
    set ib_itemCustom[287] = 1
    set ib_itemList[288] = 'I023'
    set ib_itemName[288] = "落叶魂斧"
    set ib_itemCustom[288] = 1
    set ib_itemList[289] = 'I033'
    set ib_itemName[289] = "鬼龙之戒"
    set ib_itemCustom[289] = 1
    set ib_itemList[290] = 'TWN3'
    set ib_itemName[290] = "城堡或者堡垒或者永恒之树或者黑色城堡"
    set ib_itemCustom[290] = 1
    set ib_itemList[291] = 'I004'
    set ib_itemName[291] = "灼热之刀(二级)"
    set ib_itemCustom[291] = 1
    set ib_itemList[292] = 'I014'
    set ib_itemName[292] = "合成宝石"
    set ib_itemCustom[292] = 1
    set ib_itemList[293] = 'I024'
    set ib_itemName[293] = "红魔龙刀"
    set ib_itemCustom[293] = 1
    set ib_itemList[294] = 'I034'
    set ib_itemName[294] = "鬼龙封印"
    set ib_itemCustom[294] = 1
    set ib_itemList[295] = 'I005'
    set ib_itemName[295] = "火焰手套(一级)"
    set ib_itemCustom[295] = 1
    set ib_itemList[296] = 'I015'
    set ib_itemName[296] = "风痕之甲"
    set ib_itemCustom[296] = 1
    set ib_itemList[297] = 'I006'
    set ib_itemName[297] = "远古战斧(四级)"
    set ib_itemCustom[297] = 1
    set ib_itemList[298] = 'I016'
    set ib_itemName[298] = "霹雳手套(二级)"
    set ib_itemCustom[298] = 1
    set ib_itemList[299] = 'I026'
    set ib_itemName[299] = "红魔龙盔"
    set ib_itemCustom[299] = 1
    set ib_itemList[300] = 'I007'
    set ib_itemName[300] = "国王之冠(二级)"
    set ib_itemCustom[300] = 1
    set ib_itemList[301] = 'I017'
    set ib_itemName[301] = "霹雳手套(三级)"
    set ib_itemCustom[301] = 1
    set ib_itemList[302] = 'I027'
    set ib_itemName[302] = "红魔龙手"
    set ib_itemCustom[302] = 1
    set ib_itemList[303] = 'I008'
    set ib_itemName[303] = "二转证明"
    set ib_itemCustom[303] = 1
    set ib_itemList[304] = 'I018'
    set ib_itemName[304] = "霹雳手套(四级)"
    set ib_itemCustom[304] = 1
    set ib_itemList[305] = 'I028'
    set ib_itemName[305] = "红魔龙爪"
    set ib_itemCustom[305] = 1
    set ib_itemList[306] = 'I009'
    set ib_itemName[306] = "青龙盾"
    set ib_itemCustom[306] = 1
    set ib_itemList[307] = 'I019'
    set ib_itemName[307] = "邪神战斧(三级)"
    set ib_itemCustom[307] = 1
    set ib_itemList[308] = 'I029'
    set ib_itemName[308] = "红魔龙斧"
    set ib_itemCustom[308] = 1
    set ib_itemList[309] = 'I00A'
    set ib_itemName[309] = "攻击之爪(二级)"
    set ib_itemCustom[309] = 1
    set ib_itemList[310] = 'I01A'
    set ib_itemName[310] = "邪神战斧(四级)"
    set ib_itemCustom[310] = 1
    set ib_itemList[311] = 'I02A'
    set ib_itemName[311] = "生命手册(真)10000"
    set ib_itemCustom[311] = 1
    set ib_itemList[312] = 'I00B'
    set ib_itemName[312] = "霹雳手套(一级)"
    set ib_itemCustom[312] = 1
    set ib_itemList[313] = 'I01B'
    set ib_itemName[313] = "烈火战刀(二级)"
    set ib_itemCustom[313] = 1
    set ib_itemList[314] = 'I02B'
    set ib_itemName[314] = "知识之书+1000"
    set ib_itemCustom[314] = 1
    set ib_itemList[315] = 'mdpb'
    set ib_itemName[315] = "美杜莎之石"
    set ib_itemCustom[315] = 1
    set ib_itemList[316] = 'I00C'
    set ib_itemName[316] = "重生十字章(极品)"
    set ib_itemCustom[316] = 1
    set ib_itemList[317] = 'I01C'
    set ib_itemName[317] = "烈火战刀(三级)"
    set ib_itemCustom[317] = 1
    set ib_itemList[318] = 'I02C'
    set ib_itemName[318] = "力量之书+1000"
    set ib_itemCustom[318] = 1
    set ib_itemList[319] = 'I00D'
    set ib_itemName[319] = "邪神战斧(二级)"
    set ib_itemCustom[319] = 1
endfunction
function IB_Fill4 takes nothing returns nothing
    set ib_itemList[320] = 'I01D'
    set ib_itemName[320] = "烈火战刀(四级)"
    set ib_itemCustom[320] = 1
    set ib_itemList[321] = 'I02D'
    set ib_itemName[321] = "敏捷之书+1000"
    set ib_itemCustom[321] = 1
    set ib_itemList[322] = 'I00E'
    set ib_itemName[322] = "火焰手套(三级)"
    set ib_itemCustom[322] = 1
    set ib_itemList[323] = 'I01E'
    set ib_itemName[323] = "疯魔之爪(二级)"
    set ib_itemCustom[323] = 1
    set ib_itemList[324] = 'I02E'
    set ib_itemName[324] = "智力之书+1000"
    set ib_itemCustom[324] = 1
    set ib_itemList[325] = 'I00F'
    set ib_itemName[325] = "火焰手套(二级)"
    set ib_itemCustom[325] = 1
    set ib_itemList[326] = 'I01F'
    set ib_itemName[326] = "疯魔之爪(三级)"
    set ib_itemCustom[326] = 1
    set ib_itemList[327] = 'I02F'
    set ib_itemName[327] = "生命手册(真)100000"
    set ib_itemCustom[327] = 1
    set ib_itemList[328] = 'I00G'
    set ib_itemName[328] = "重生十字章(终极)"
    set ib_itemCustom[328] = 1
    set ib_itemList[329] = 'I01G'
    set ib_itemName[329] = "疯魔之爪(四级)"
    set ib_itemCustom[329] = 1
    set ib_itemList[330] = 'I02G'
    set ib_itemName[330] = "极品生命手册"
    set ib_itemCustom[330] = 1
    set ib_itemList[331] = 'I00H'
    set ib_itemName[331] = "火焰手套(四级)"
    set ib_itemCustom[331] = 1
    set ib_itemList[332] = 'I01H'
    set ib_itemName[332] = "神圣之冠(二级)"
    set ib_itemCustom[332] = 1
    set ib_itemList[333] = 'I02H'
    set ib_itemName[333] = "蓝风月刃"
    set ib_itemCustom[333] = 1
    set ib_itemList[334] = 'I00I'
    set ib_itemName[334] = "神圣之冠(一级)"
    set ib_itemCustom[334] = 1
    set ib_itemList[335] = 'I01I'
    set ib_itemName[335] = "神圣之冠(三级)"
    set ib_itemCustom[335] = 1
    set ib_itemList[336] = 'I02I'
    set ib_itemName[336] = "终极经验之书"
    set ib_itemCustom[336] = 1
    set ib_itemList[337] = 'I00J'
    set ib_itemName[337] = "烈火战刀(一级)"
    set ib_itemCustom[337] = 1
    set ib_itemList[338] = 'I01J'
    set ib_itemName[338] = "神圣之冠(四级)"
    set ib_itemCustom[338] = 1
    set ib_itemList[339] = 'I02J'
    set ib_itemName[339] = "终极生命手册"
    set ib_itemCustom[339] = 1
    set ib_itemList[340] = 'I00K'
    set ib_itemName[340] = "超级神器"
    set ib_itemCustom[340] = 1
    set ib_itemList[341] = 'I01K'
    set ib_itemName[341] = "力量之书+10w"
    set ib_itemCustom[341] = 1
    set ib_itemList[342] = 'I02K'
    set ib_itemName[342] = "生命手册(真)1000w"
    set ib_itemCustom[342] = 1
    set ib_itemList[343] = 'I00L'
    set ib_itemName[343] = "灼热之刀(三级)"
    set ib_itemCustom[343] = 1
    set ib_itemList[344] = 'I01L'
    set ib_itemName[344] = "敏捷之书+10w"
    set ib_itemCustom[344] = 1
    set ib_itemList[345] = 'I02L'
    set ib_itemName[345] = "转生证明"
    set ib_itemCustom[345] = 1
    set ib_itemList[346] = 'I00M'
    set ib_itemName[346] = "灼热之刀(四级)"
    set ib_itemCustom[346] = 1
    set ib_itemList[347] = 'I02M'
    set ib_itemName[347] = "超级神甲"
    set ib_itemCustom[347] = 1
    set ib_itemList[348] = 'I00N'
    set ib_itemName[348] = "经验之书"
    set ib_itemCustom[348] = 1
    set ib_itemList[349] = 'I01N'
    set ib_itemName[349] = "10点木材换100000金币"
    set ib_itemCustom[349] = 1
    set ib_itemList[350] = 'I02N'
    set ib_itemName[350] = "生命手册(真)100w"
    set ib_itemCustom[350] = 1
    set ib_itemList[351] = 'I00O'
    set ib_itemName[351] = "灼热之刀(一级)"
    set ib_itemCustom[351] = 1
    set ib_itemList[352] = 'I01O'
    set ib_itemName[352] = "100000金币换10点木材"
    set ib_itemCustom[352] = 1
    set ib_itemList[353] = 'I02O'
    set ib_itemName[353] = "飞哥龙神斩"
    set ib_itemCustom[353] = 1
    set ib_itemList[354] = 'I00P'
    set ib_itemName[354] = "朱雀盾"
    set ib_itemCustom[354] = 1
    set ib_itemList[355] = 'I01P'
    set ib_itemName[355] = "秋霜战刀"
    set ib_itemCustom[355] = 1
    set ib_itemList[356] = 'I02P'
    set ib_itemName[356] = "知识之书+50w"
    set ib_itemCustom[356] = 1
    set ib_itemList[357] = 'I00Q'
    set ib_itemName[357] = "白虎盾"
    set ib_itemCustom[357] = 1
    set ib_itemList[358] = 'I01Q'
    set ib_itemName[358] = "秋霜战斧"
    set ib_itemCustom[358] = 1
    set ib_itemList[359] = 'I02Q'
    set ib_itemName[359] = "飞哥圣神甲"
    set ib_itemCustom[359] = 1
    set ib_itemList[360] = 'I00R'
    set ib_itemName[360] = "玄武盾"
    set ib_itemCustom[360] = 1
    set ib_itemList[361] = 'I01R'
    set ib_itemName[361] = "秋霜战手"
    set ib_itemCustom[361] = 1
    set ib_itemList[362] = 'I02R'
    set ib_itemName[362] = "飞飞世界"
    set ib_itemCustom[362] = 1
    set ib_itemList[363] = 'I00S'
    set ib_itemName[363] = "远古战斧(一级)"
    set ib_itemCustom[363] = 1
    set ib_itemList[364] = 'I01S'
    set ib_itemName[364] = "秋霜战盔"
    set ib_itemCustom[364] = 1
    set ib_itemList[365] = 'I02S'
    set ib_itemName[365] = "飞哥龙神斩<gm>"
    set ib_itemCustom[365] = 1
    set ib_itemList[366] = 'I00T'
    set ib_itemName[366] = "远古战斧(二级)"
    set ib_itemCustom[366] = 1
    set ib_itemList[367] = 'I01T'
    set ib_itemName[367] = "神秘宝石"
    set ib_itemCustom[367] = 1
    set ib_itemList[368] = 'I02T'
    set ib_itemName[368] = "<飞哥刀gm证明书>"
    set ib_itemCustom[368] = 1
    set ib_itemList[369] = 'TALT'
    set ib_itemName[369] = "一个祭坛"
    set ib_itemCustom[369] = 1
    set ib_itemList[370] = 'I00U'
    set ib_itemName[370] = "远古战斧(三级)"
    set ib_itemCustom[370] = 1
    set ib_itemList[371] = 'I01U'
    set ib_itemName[371] = "秋霜战爪"
    set ib_itemCustom[371] = 1
    set ib_itemList[372] = 'I02U'
    set ib_itemName[372] = "力量之书+100w"
    set ib_itemCustom[372] = 1
    set ib_itemList[373] = 'I00V'
    set ib_itemName[373] = "国王之冠(三级)"
    set ib_itemCustom[373] = 1
    set ib_itemList[374] = 'I01V'
    set ib_itemName[374] = "秋霜宝石"
    set ib_itemCustom[374] = 1
    set ib_itemList[375] = 'I02V'
    set ib_itemName[375] = "敏捷之书+100w"
    set ib_itemCustom[375] = 1
    set ib_itemList[376] = 'I00W'
    set ib_itemName[376] = "国王之冠(一级)"
    set ib_itemCustom[376] = 1
    set ib_itemList[377] = 'I01W'
    set ib_itemName[377] = "落叶宝石"
    set ib_itemCustom[377] = 1
    set ib_itemList[378] = 'I02W'
    set ib_itemName[378] = "命运宝箱"
    set ib_itemCustom[378] = 1
    set ib_itemList[379] = 'I00X'
    set ib_itemName[379] = "国王之冠(四级)"
    set ib_itemCustom[379] = 1
    set ib_itemList[380] = 'I01X'
    set ib_itemName[380] = "红魔宝石"
    set ib_itemCustom[380] = 1
    set ib_itemList[381] = 'I02X'
    set ib_itemName[381] = "智力之书+100w"
    set ib_itemCustom[381] = 1
    set ib_itemList[382] = 'I00Y'
    set ib_itemName[382] = "邪神战斧(一级)"
    set ib_itemCustom[382] = 1
    set ib_itemList[383] = 'I01Y'
    set ib_itemName[383] = "落叶魂刀"
    set ib_itemCustom[383] = 1
    set ib_itemList[384] = 'I02Y'
    set ib_itemName[384] = "知识之书+100w"
    set ib_itemCustom[384] = 1
    set ib_itemList[385] = 'I00Z'
    set ib_itemName[385] = "攻击之爪(四级)"
    set ib_itemCustom[385] = 1
    set ib_itemList[386] = 'I01Z'
    set ib_itemName[386] = "落叶魂手"
    set ib_itemCustom[386] = 1
    set ib_itemList[387] = 'I02Z'
    set ib_itemName[387] = "<飞哥甲gm证明书>"
    set ib_itemCustom[387] = 1
endfunction

function IB_Init takes nothing returns nothing
    set ib_itemCount = 0
    call IB_Fill0()
    call IB_Fill1()
    call IB_Fill2()
    call IB_Fill3()
    call IB_Fill4()
    set ib_itemCount = 388
    call IB_Message(GetLocalPlayer(), "装备系统就绪，共 " + I2S(ib_itemCount) + " 件装备")
    call IB_RegisterChat()
endfunction
