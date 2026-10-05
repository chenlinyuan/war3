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
    set ib_itemList[0] = 'fgdg'
    set ib_itemName[0] = "恶魔雕像"
    set ib_itemCustom[0] = 0
    set ib_itemList[1] = 'infs'
    set ib_itemName[1] = "恶魔岩石"
    set ib_itemCustom[1] = 0
    set ib_itemList[2] = 'ankh'
    set ib_itemName[2] = "重生十字章"
    set ib_itemCustom[2] = 0
    set ib_itemList[3] = 'whwd'
    set ib_itemName[3] = "风少爷(qq171246484)"
    set ib_itemCustom[3] = 0
    set ib_itemList[4] = 'fgrg'
    set ib_itemName[4] = "岩石印记"
    set ib_itemCustom[4] = 0
    set ib_itemList[5] = 'pghe'
    set ib_itemName[5] = "大生命药水"
    set ib_itemCustom[5] = 0
    set ib_itemList[6] = 'pgma'
    set ib_itemName[6] = "大魔法药水"
    set ib_itemCustom[6] = 0
    set ib_itemList[7] = 'rej3'
    set ib_itemName[7] = "恢复药水"
    set ib_itemCustom[7] = 0
    set ib_itemList[8] = 'ofir'
    set ib_itemName[8] = "火焰之球"
    set ib_itemCustom[8] = 0
    set ib_itemList[9] = 'ocor'
    set ib_itemName[9] = "腐蚀之球"
    set ib_itemCustom[9] = 0
    set ib_itemList[10] = 'oli2'
    set ib_itemName[10] = "闪电之球"
    set ib_itemCustom[10] = 0
    set ib_itemList[11] = 'oven'
    set ib_itemName[11] = "毒液之球"
    set ib_itemCustom[11] = 0
    set ib_itemList[12] = 'tgrh'
    set ib_itemName[12] = "小型的大厅"
    set ib_itemCustom[12] = 0
    set ib_itemList[13] = 'stel'
    set ib_itemName[13] = "星辰权杖"
    set ib_itemCustom[13] = 0
    set ib_itemList[14] = 'tdx2'
    set ib_itemName[14] = "敏捷之书 +10000"
    set ib_itemCustom[14] = 0
    set ib_itemList[15] = 'texp'
    set ib_itemName[15] = "超级经验之书"
    set ib_itemCustom[15] = 0
    set ib_itemList[16] = 'tin2'
    set ib_itemName[16] = "智力之书 +10000"
    set ib_itemCustom[16] = 0
    set ib_itemList[17] = 'tpow'
    set ib_itemName[17] = "知识之书+100"
    set ib_itemCustom[17] = 0
    set ib_itemList[18] = 'tst2'
    set ib_itemName[18] = "力量之书 +10000"
    set ib_itemCustom[18] = 0
    set ib_itemList[19] = 'stwp'
    set ib_itemName[19] = "回城卷轴"
    set ib_itemCustom[19] = 0
    set ib_itemList[20] = 'shea'
    set ib_itemName[20] = "医疗卷轴"
    set ib_itemCustom[20] = 0
    set ib_itemList[21] = 'dust'
    set ib_itemName[21] = "尘土之影"
    set ib_itemCustom[21] = 0
    set ib_itemList[22] = 'manh'
    set ib_itemName[22] = "生命手册"
    set ib_itemCustom[22] = 0
    set ib_itemList[23] = 'tdex'
    set ib_itemName[23] = "敏捷之书+100"
    set ib_itemCustom[23] = 0
    set ib_itemList[24] = 'tint'
    set ib_itemName[24] = "智力之书+100"
    set ib_itemCustom[24] = 0
    set ib_itemList[25] = 'tstr'
    set ib_itemName[25] = "力量之书+100"
    set ib_itemCustom[25] = 0
    set ib_itemList[26] = 'phea'
    set ib_itemName[26] = "生命药水"
    set ib_itemCustom[26] = 0
    set ib_itemList[27] = 'pman'
    set ib_itemName[27] = "魔法药水"
    set ib_itemCustom[27] = 0
    set ib_itemList[28] = 'hslv'
    set ib_itemName[28] = "医疗剂"
    set ib_itemCustom[28] = 0
    set ib_itemList[29] = 'moon'
    set ib_itemName[29] = "月亮石"
    set ib_itemCustom[29] = 0
    set ib_itemList[30] = 'shas'
    set ib_itemName[30] = "速度卷轴"
    set ib_itemCustom[30] = 0
    set ib_itemList[31] = 'skul'
    set ib_itemName[31] = "献祭头骨"
    set ib_itemCustom[31] = 0
    set ib_itemList[32] = 'mcri'
    set ib_itemName[32] = "机械类的小玩艺"
    set ib_itemCustom[32] = 0
    set ib_itemList[33] = 'rnec'
    set ib_itemName[33] = "巫术妖棍"
    set ib_itemCustom[33] = 0
    set ib_itemList[34] = 'tsct'
    set ib_itemName[34] = "象牙塔"
    set ib_itemCustom[34] = 0
    set ib_itemList[35] = 'pams'
    set ib_itemName[35] = "抗体药水"
    set ib_itemCustom[35] = 0
    set ib_itemList[36] = 'spre'
    set ib_itemName[36] = "保存权杖"
    set ib_itemCustom[36] = 0
    set ib_itemList[37] = 'plcl'
    set ib_itemName[37] = "小净化药水"
    set ib_itemCustom[37] = 0
    set ib_itemList[38] = 'sreg'
    set ib_itemName[38] = "恢复卷轴"
    set ib_itemCustom[38] = 0
    set ib_itemList[39] = 'ssan'
    set ib_itemName[39] = "避难权杖"
    set ib_itemCustom[39] = 0
    set ib_itemList[40] = 'I000'
    set ib_itemName[40] = "风痕之刃"
    set ib_itemCustom[40] = 1
    set ib_itemList[41] = 'I001'
    set ib_itemName[41] = "知识之书+10000"
    set ib_itemCustom[41] = 1
    set ib_itemList[42] = 'I002'
    set ib_itemName[42] = "1点木材换10000金币"
    set ib_itemCustom[42] = 1
    set ib_itemList[43] = 'I003'
    set ib_itemName[43] = "10000金币换1点木材"
    set ib_itemCustom[43] = 1
    set ib_itemList[44] = 'I006'
    set ib_itemName[44] = "远古战斧(四级)"
    set ib_itemCustom[44] = 1
    set ib_itemList[45] = 'I007'
    set ib_itemName[45] = "国王之冠(二级)"
    set ib_itemCustom[45] = 1
    set ib_itemList[46] = 'I00A'
    set ib_itemName[46] = "攻击之爪(二级)"
    set ib_itemCustom[46] = 1
    set ib_itemList[47] = 'I00B'
    set ib_itemName[47] = "霹雳手套(一级)"
    set ib_itemCustom[47] = 1
    set ib_itemList[48] = 'I00C'
    set ib_itemName[48] = "重生十字章(极品)"
    set ib_itemCustom[48] = 1
    set ib_itemList[49] = 'I00H'
    set ib_itemName[49] = "火焰手套(四级)"
    set ib_itemCustom[49] = 1
    set ib_itemList[50] = 'I00I'
    set ib_itemName[50] = "神圣之冠(一级)"
    set ib_itemCustom[50] = 1
    set ib_itemList[51] = 'I00J'
    set ib_itemName[51] = "烈火战刀(一级)"
    set ib_itemCustom[51] = 1
    set ib_itemList[52] = 'I005'
    set ib_itemName[52] = "火焰手套(一级)"
    set ib_itemCustom[52] = 1
    set ib_itemList[53] = 'I00E'
    set ib_itemName[53] = "火焰手套(三级)"
    set ib_itemCustom[53] = 1
    set ib_itemList[54] = 'I00F'
    set ib_itemName[54] = "火焰手套(二级)"
    set ib_itemCustom[54] = 1
    set ib_itemList[55] = 'I00O'
    set ib_itemName[55] = "灼热之刀(一级)"
    set ib_itemCustom[55] = 1
    set ib_itemList[56] = 'I004'
    set ib_itemName[56] = "灼热之刀(二级)"
    set ib_itemCustom[56] = 1
    set ib_itemList[57] = 'I00L'
    set ib_itemName[57] = "灼热之刀(三级)"
    set ib_itemCustom[57] = 1
    set ib_itemList[58] = 'I00M'
    set ib_itemName[58] = "灼热之刀(四级)"
    set ib_itemCustom[58] = 1
    set ib_itemList[59] = 'I00S'
    set ib_itemName[59] = "远古战斧(一级)"
    set ib_itemCustom[59] = 1
    set ib_itemList[60] = 'I00T'
    set ib_itemName[60] = "远古战斧(二级)"
    set ib_itemCustom[60] = 1
    set ib_itemList[61] = 'I00U'
    set ib_itemName[61] = "远古战斧(三级)"
    set ib_itemCustom[61] = 1
    set ib_itemList[62] = 'I00V'
    set ib_itemName[62] = "国王之冠(三级)"
    set ib_itemCustom[62] = 1
    set ib_itemList[63] = 'I00W'
    set ib_itemName[63] = "国王之冠(一级)"
    set ib_itemCustom[63] = 1
    set ib_itemList[64] = 'I00X'
    set ib_itemName[64] = "国王之冠(四级)"
    set ib_itemCustom[64] = 1
    set ib_itemList[65] = 'I00Z'
    set ib_itemName[65] = "攻击之爪(四级)"
    set ib_itemCustom[65] = 1
    set ib_itemList[66] = 'I010'
    set ib_itemName[66] = "攻击之爪(一级)"
    set ib_itemCustom[66] = 1
    set ib_itemList[67] = 'I011'
    set ib_itemName[67] = "攻击之爪(三级)"
    set ib_itemCustom[67] = 1
    set ib_itemList[68] = 'I00Y'
    set ib_itemName[68] = "邪神战斧(一级)"
    set ib_itemCustom[68] = 1
    set ib_itemList[69] = 'I013'
    set ib_itemName[69] = "疯魔之爪(一级)"
    set ib_itemCustom[69] = 1
    set ib_itemList[70] = 'I014'
    set ib_itemName[70] = "合成宝石"
    set ib_itemCustom[70] = 1
    set ib_itemList[71] = 'I015'
    set ib_itemName[71] = "风痕之甲"
    set ib_itemCustom[71] = 1
    set ib_itemList[72] = 'I016'
    set ib_itemName[72] = "霹雳手套(二级)"
    set ib_itemCustom[72] = 1
    set ib_itemList[73] = 'I017'
    set ib_itemName[73] = "霹雳手套(三级)"
    set ib_itemCustom[73] = 1
    set ib_itemList[74] = 'I018'
    set ib_itemName[74] = "霹雳手套(四级)"
    set ib_itemCustom[74] = 1
    set ib_itemList[75] = 'I00D'
    set ib_itemName[75] = "邪神战斧(二级)"
    set ib_itemCustom[75] = 1
    set ib_itemList[76] = 'I019'
    set ib_itemName[76] = "邪神战斧(三级)"
    set ib_itemCustom[76] = 1
    set ib_itemList[77] = 'I01A'
    set ib_itemName[77] = "邪神战斧(四级)"
    set ib_itemCustom[77] = 1
    set ib_itemList[78] = 'I01B'
    set ib_itemName[78] = "烈火战刀(二级)"
    set ib_itemCustom[78] = 1
    set ib_itemList[79] = 'I01C'
    set ib_itemName[79] = "烈火战刀(三级)"
    set ib_itemCustom[79] = 1
endfunction
function IB_Fill1 takes nothing returns nothing
    set ib_itemList[80] = 'I01D'
    set ib_itemName[80] = "烈火战刀(四级)"
    set ib_itemCustom[80] = 1
    set ib_itemList[81] = 'I01E'
    set ib_itemName[81] = "疯魔之爪(二级)"
    set ib_itemCustom[81] = 1
    set ib_itemList[82] = 'I01F'
    set ib_itemName[82] = "疯魔之爪(三级)"
    set ib_itemCustom[82] = 1
    set ib_itemList[83] = 'I01G'
    set ib_itemName[83] = "疯魔之爪(四级)"
    set ib_itemCustom[83] = 1
    set ib_itemList[84] = 'I01H'
    set ib_itemName[84] = "神圣之冠(二级)"
    set ib_itemCustom[84] = 1
    set ib_itemList[85] = 'I01I'
    set ib_itemName[85] = "神圣之冠(三级)"
    set ib_itemCustom[85] = 1
    set ib_itemList[86] = 'I01J'
    set ib_itemName[86] = "神圣之冠(四级)"
    set ib_itemCustom[86] = 1
    set ib_itemList[87] = 'I01N'
    set ib_itemName[87] = "10点木材换100000金币"
    set ib_itemCustom[87] = 1
    set ib_itemList[88] = 'I01O'
    set ib_itemName[88] = "100000金币换10点木材"
    set ib_itemCustom[88] = 1
    set ib_itemList[89] = 'I01P'
    set ib_itemName[89] = "秋霜战刀"
    set ib_itemCustom[89] = 1
    set ib_itemList[90] = 'I01Q'
    set ib_itemName[90] = "秋霜战斧"
    set ib_itemCustom[90] = 1
    set ib_itemList[91] = 'I01R'
    set ib_itemName[91] = "秋霜战手"
    set ib_itemCustom[91] = 1
    set ib_itemList[92] = 'I01S'
    set ib_itemName[92] = "秋霜战盔"
    set ib_itemCustom[92] = 1
    set ib_itemList[93] = 'I01U'
    set ib_itemName[93] = "秋霜战爪"
    set ib_itemCustom[93] = 1
    set ib_itemList[94] = 'I01V'
    set ib_itemName[94] = "秋霜宝石"
    set ib_itemCustom[94] = 1
    set ib_itemList[95] = 'I01W'
    set ib_itemName[95] = "落叶宝石"
    set ib_itemCustom[95] = 1
    set ib_itemList[96] = 'I01X'
    set ib_itemName[96] = "红魔宝石"
    set ib_itemCustom[96] = 1
    set ib_itemList[97] = 'I01Y'
    set ib_itemName[97] = "落叶魂刀"
    set ib_itemCustom[97] = 1
    set ib_itemList[98] = 'I01Z'
    set ib_itemName[98] = "落叶魂手"
    set ib_itemCustom[98] = 1
    set ib_itemList[99] = 'I021'
    set ib_itemName[99] = "落叶魂盔"
    set ib_itemCustom[99] = 1
    set ib_itemList[100] = 'I022'
    set ib_itemName[100] = "落叶魂爪"
    set ib_itemCustom[100] = 1
    set ib_itemList[101] = 'I023'
    set ib_itemName[101] = "落叶魂斧"
    set ib_itemCustom[101] = 1
    set ib_itemList[102] = 'I024'
    set ib_itemName[102] = "红魔龙刀"
    set ib_itemCustom[102] = 1
    set ib_itemList[103] = 'I026'
    set ib_itemName[103] = "红魔龙盔"
    set ib_itemCustom[103] = 1
    set ib_itemList[104] = 'I027'
    set ib_itemName[104] = "红魔龙手"
    set ib_itemCustom[104] = 1
    set ib_itemList[105] = 'I028'
    set ib_itemName[105] = "红魔龙爪"
    set ib_itemCustom[105] = 1
    set ib_itemList[106] = 'I029'
    set ib_itemName[106] = "红魔龙斧"
    set ib_itemCustom[106] = 1
    set ib_itemList[107] = 'I02A'
    set ib_itemName[107] = "生命手册(真)10000"
    set ib_itemCustom[107] = 1
    set ib_itemList[108] = 'I02B'
    set ib_itemName[108] = "知识之书+1000"
    set ib_itemCustom[108] = 1
    set ib_itemList[109] = 'I02C'
    set ib_itemName[109] = "力量之书+1000"
    set ib_itemCustom[109] = 1
    set ib_itemList[110] = 'I02D'
    set ib_itemName[110] = "敏捷之书+1000"
    set ib_itemCustom[110] = 1
    set ib_itemList[111] = 'I02E'
    set ib_itemName[111] = "智力之书+1000"
    set ib_itemCustom[111] = 1
    set ib_itemList[112] = 'I02F'
    set ib_itemName[112] = "生命手册(真)100000"
    set ib_itemCustom[112] = 1
    set ib_itemList[113] = 'I02G'
    set ib_itemName[113] = "极品生命手册"
    set ib_itemCustom[113] = 1
    set ib_itemList[114] = 'I02H'
    set ib_itemName[114] = "蓝风月刃"
    set ib_itemCustom[114] = 1
    set ib_itemList[115] = 'I02J'
    set ib_itemName[115] = "终极生命手册"
    set ib_itemCustom[115] = 1
    set ib_itemList[116] = 'I02K'
    set ib_itemName[116] = "生命手册(真)1000w"
    set ib_itemCustom[116] = 1
    set ib_itemList[117] = 'I02I'
    set ib_itemName[117] = "终极经验之书"
    set ib_itemCustom[117] = 1
    set ib_itemList[118] = 'I02L'
    set ib_itemName[118] = "转生证明"
    set ib_itemCustom[118] = 1
    set ib_itemList[119] = 'I008'
    set ib_itemName[119] = "二转证明"
    set ib_itemCustom[119] = 1
    set ib_itemList[120] = 'I00G'
    set ib_itemName[120] = "重生十字章(终极)"
    set ib_itemCustom[120] = 1
    set ib_itemList[121] = 'I00K'
    set ib_itemName[121] = "超级神器"
    set ib_itemCustom[121] = 1
    set ib_itemList[122] = 'I02M'
    set ib_itemName[122] = "超级神甲"
    set ib_itemCustom[122] = 1
    set ib_itemList[123] = 'I02W'
    set ib_itemName[123] = "命运宝箱"
    set ib_itemCustom[123] = 1
    set ib_itemList[124] = 'I02O'
    set ib_itemName[124] = "飞哥龙神斩"
    set ib_itemCustom[124] = 1
    set ib_itemList[125] = 'I031'
    set ib_itemName[125] = "三转证明"
    set ib_itemCustom[125] = 1
    set ib_itemList[126] = 'I02P'
    set ib_itemName[126] = "知识之书+50w"
    set ib_itemCustom[126] = 1
    set ib_itemList[127] = 'I02Q'
    set ib_itemName[127] = "飞哥圣神甲"
    set ib_itemCustom[127] = 1
    set ib_itemList[128] = 'I02S'
    set ib_itemName[128] = "飞哥龙神斩<gm>"
    set ib_itemCustom[128] = 1
    set ib_itemList[129] = 'I02T'
    set ib_itemName[129] = "<飞哥刀gm证明书>"
    set ib_itemCustom[129] = 1
    set ib_itemList[130] = 'I02R'
    set ib_itemName[130] = "飞飞世界"
    set ib_itemCustom[130] = 1
    set ib_itemList[131] = 'I02U'
    set ib_itemName[131] = "力量之书+100w"
    set ib_itemCustom[131] = 1
    set ib_itemList[132] = 'I02V'
    set ib_itemName[132] = "敏捷之书+100w"
    set ib_itemCustom[132] = 1
    set ib_itemList[133] = 'I02X'
    set ib_itemName[133] = "智力之书+100w"
    set ib_itemCustom[133] = 1
    set ib_itemList[134] = 'I02Y'
    set ib_itemName[134] = "知识之书+100w"
    set ib_itemCustom[134] = 1
    set ib_itemList[135] = 'I02Z'
    set ib_itemName[135] = "<飞哥甲gm证明书>"
    set ib_itemCustom[135] = 1
    set ib_itemList[136] = 'I030'
    set ib_itemName[136] = "飞哥圣神甲<gm>"
    set ib_itemCustom[136] = 1
    set ib_itemList[137] = 'I032'
    set ib_itemName[137] = "魔界通道通行证"
    set ib_itemCustom[137] = 1
    set ib_itemList[138] = 'I00N'
    set ib_itemName[138] = "经验之书"
    set ib_itemCustom[138] = 1
    set ib_itemList[139] = 'I02N'
    set ib_itemName[139] = "生命手册(真)100w"
    set ib_itemCustom[139] = 1
    set ib_itemList[140] = 'I033'
    set ib_itemName[140] = "鬼龙之戒"
    set ib_itemCustom[140] = 1
    set ib_itemList[141] = 'I034'
    set ib_itemName[141] = "鬼龙封印"
    set ib_itemCustom[141] = 1
    set ib_itemList[142] = 'I009'
    set ib_itemName[142] = "青龙盾"
    set ib_itemCustom[142] = 1
    set ib_itemList[143] = 'I00P'
    set ib_itemName[143] = "朱雀盾"
    set ib_itemCustom[143] = 1
    set ib_itemList[144] = 'I00Q'
    set ib_itemName[144] = "白虎盾"
    set ib_itemCustom[144] = 1
    set ib_itemList[145] = 'I00R'
    set ib_itemName[145] = "玄武盾"
    set ib_itemCustom[145] = 1
    set ib_itemList[146] = 'I012'
    set ib_itemName[146] = "四兽之盾"
    set ib_itemCustom[146] = 1
    set ib_itemList[147] = 'I01K'
    set ib_itemName[147] = "力量之书+10w"
    set ib_itemCustom[147] = 1
    set ib_itemList[148] = 'I01L'
    set ib_itemName[148] = "敏捷之书+10w"
    set ib_itemCustom[148] = 1
    set ib_itemList[149] = 'I01T'
    set ib_itemName[149] = "神秘宝石"
    set ib_itemCustom[149] = 1
endfunction

function IB_Init takes nothing returns nothing
    set ib_itemCount = 0
    call IB_Fill0()
    call IB_Fill1()
    set ib_itemCount = 150
    call IB_Message(GetLocalPlayer(), "装备系统就绪，共 " + I2S(ib_itemCount) + " 件装备")
    call IB_RegisterChat()
endfunction
