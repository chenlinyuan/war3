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
// [工具] 去除颜色代码 |cXXXXXXXX 和 |r，并去除首尾空格
//---------------------------------------------------------------------------
function IB_StripColorCodes takes string s returns string
    local integer len = StringLength(s)
    local integer i = 0
    local string result = ""
    local string ch
    local integer start = 0
    local integer stop = 0

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

    // 去除首尾空格
    set len = StringLength(result)
    set i = 0
    set start = 0
    loop
        exitwhen i >= len
        if SubString(result, i, i + 1) == " " then
            set i = i + 1
        else
            set start = i
            set i = len
        endif
    endloop
    set stop = len
    set i = len - 1
    loop
        exitwhen i < 0
        if SubString(result, i, i + 1) == " " then
            set i = i - 1
        else
            set stop = i + 1
            set i = -1
        endif
    endloop
    if start >= stop then
        return ""
    endif
    return SubString(result, start, stop)
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
// [工具] 判断物品名称是否包含关键词（不区分大小写）
//---------------------------------------------------------------------------
function IB_IsItemMatch takes integer itemId, string keyword returns boolean
    local string name = StringCase(IB_StripColorCodes(GetObjectName(itemId)), false)
    local string key = StringCase(keyword, false)
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
// 添加装备（不区分大小写精确匹配，找不到则取第一个包含关键词的）
//---------------------------------------------------------------------------
function IB_AddItem takes player p, string itemName, integer count returns nothing
    local integer i = 0
    local integer added = 0
    local unit u
    local item it
    local real x
    local real y
    local string name
    local string target = StringCase(IB_StripColorCodes(itemName), false)
    local integer exactId = 0
    local integer partialId = 0

    if count < 1 then
        set count = 1
    endif

    set u = IB_GetSelectedUnit(p)
    if u == null then
        call IB_Message(p, "请先选中一个英雄/单位")
        return
    endif

    // 第一遍：精确匹配
    loop
        exitwhen i >= ib_itemCount or exactId != 0
        set name = StringCase(IB_StripColorCodes(GetObjectName(ib_itemList[i])), false)
        if name == target then
            set exactId = ib_itemList[i]
        endif
        set i = i + 1
    endloop

    // 第二遍：包含匹配（取第一个）
    if exactId == 0 then
        set i = 0
        loop
            exitwhen i >= ib_itemCount or partialId != 0
            if IB_IsItemMatch(ib_itemList[i], itemName) then
                set partialId = ib_itemList[i]
            endif
            set i = i + 1
        endloop
    endif

    if exactId != 0 then
        set partialId = exactId
    endif

    if partialId == 0 then
        call IB_Message(p, "未找到装备 \"" + itemName + "\"")
        set u = null
        return
    endif

    set x = GetUnitX(u)
    set y = GetUnitY(u)

    loop
        exitwhen added >= count
        set it = CreateItem(partialId, x, y)
        if it != null then
            if not UnitAddItem(u, it) then
                call SetItemPosition(it, x, y)
            endif
            set added = added + 1
        endif
        set it = null
    endloop

    call IB_Message(p, "已添加 " + I2S(added) + " 个 \"" + IB_StripColorCodes(GetObjectName(partialId)) + "\"")
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
// 入口：直接填充预扫描的物品 ID 列表，立即注册聊天事件（无需枚举）
//---------------------------------------------------------------------------
function IB_Init takes nothing returns nothing
    set ib_itemCount = 0
    set ib_itemList[0] = 'ckng'
    set ib_itemList[1] = 'modt'
    set ib_itemList[2] = 'tkno'
    set ib_itemList[3] = 'ratf'
    set ib_itemList[4] = 'rde4'
    set ib_itemList[5] = 'ofro'
    set ib_itemList[6] = 'desc'
    set ib_itemList[7] = 'fgdg'
    set ib_itemList[8] = 'infs'
    set ib_itemList[9] = 'shar'
    set ib_itemList[10] = 'sand'
    set ib_itemList[11] = 'wild'
    set ib_itemList[12] = 'srrc'
    set ib_itemList[13] = 'odef'
    set ib_itemList[14] = 'rde3'
    set ib_itemList[15] = 'pmna'
    set ib_itemList[16] = 'rhth'
    set ib_itemList[17] = 'ssil'
    set ib_itemList[18] = 'spsh'
    set ib_itemList[19] = 'sres'
    set ib_itemList[20] = 'pdiv'
    set ib_itemList[21] = 'pres'
    set ib_itemList[22] = 'totw'
    set ib_itemList[23] = 'fgfh'
    set ib_itemList[24] = 'fgrd'
    set ib_itemList[25] = 'fgrg'
    set ib_itemList[26] = 'hcun'
    set ib_itemList[27] = 'hval'
    set ib_itemList[28] = 'mcou'
    set ib_itemList[29] = 'ajen'
    set ib_itemList[30] = 'clfm'
    set ib_itemList[31] = 'ratc'
    set ib_itemList[32] = 'ward'
    set ib_itemList[33] = 'kpin'
    set ib_itemList[34] = 'crys'
    set ib_itemList[35] = 'lgdh'
    set ib_itemList[36] = 'ankh'
    set ib_itemList[37] = 'whwd'
    set ib_itemList[38] = 'fgsk'
    set ib_itemList[39] = 'wcyc'
    set ib_itemList[40] = 'hlst'
    set ib_itemList[41] = 'mnst'
    set ib_itemList[42] = 'belv'
    set ib_itemList[43] = 'bgst'
    set ib_itemList[44] = 'ciri'
    set ib_itemList[45] = 'lhst'
    set ib_itemList[46] = 'afac'
    set ib_itemList[47] = 'sbch'
    set ib_itemList[48] = 'brac'
    set ib_itemList[49] = 'rwiz'
    set ib_itemList[50] = 'pghe'
    set ib_itemList[51] = 'pgma'
    set ib_itemList[52] = 'pnvu'
    set ib_itemList[53] = 'sror'
    set ib_itemList[54] = 'woms'
    set ib_itemList[55] = 'evtl'
    set ib_itemList[56] = 'penr'
    set ib_itemList[57] = 'prvt'
    set ib_itemList[58] = 'rat9'
    set ib_itemList[59] = 'rde2'
    set ib_itemList[60] = 'rlif'
    set ib_itemList[61] = 'bspd'
    set ib_itemList[62] = 'rej3'
    set ib_itemList[63] = 'will'
    set ib_itemList[64] = 'wlsd'
    set ib_itemList[65] = 'wswd'
    set ib_itemList[66] = 'cnob'
    set ib_itemList[67] = 'gcel'
    set ib_itemList[68] = 'rat6'
    set ib_itemList[69] = 'rde1'
    set ib_itemList[70] = 'tdx2'
    set ib_itemList[71] = 'texp'
    set ib_itemList[72] = 'tin2'
    set ib_itemList[73] = 'tpow'
    set ib_itemList[74] = 'tst2'
    set ib_itemList[75] = 'pnvl'
    set ib_itemList[76] = 'clsd'
    set ib_itemList[77] = 'rag1'
    set ib_itemList[78] = 'rin1'
    set ib_itemList[79] = 'rst1'
    set ib_itemList[80] = 'manh'
    set ib_itemList[81] = 'tdex'
    set ib_itemList[82] = 'tint'
    set ib_itemList[83] = 'tstr'
    set ib_itemList[84] = 'pomn'
    set ib_itemList[85] = 'wshs'
    set ib_itemList[86] = 'rej6'
    set ib_itemList[87] = 'rej5'
    set ib_itemList[88] = 'rej4'
    set ib_itemList[89] = 'ram4'
    set ib_itemList[90] = 'dsum'
    set ib_itemList[91] = 'ofir'
    set ib_itemList[92] = 'ocor'
    set ib_itemList[93] = 'oli2'
    set ib_itemList[94] = 'oven'
    set ib_itemList[95] = 'ram3'
    set ib_itemList[96] = 'tret'
    set ib_itemList[97] = 'tgrh'
    set ib_itemList[98] = 'rej2'
    set ib_itemList[99] = 'gemt'
    set ib_itemList[100] = 'ram2'
    set ib_itemList[101] = 'stel'
    set ib_itemList[102] = 'stwp'
    set ib_itemList[103] = 'wneg'
    set ib_itemList[104] = 'sneg'
    set ib_itemList[105] = 'wneu'
    set ib_itemList[106] = 'shea'
    set ib_itemList[107] = 'sman'
    set ib_itemList[108] = 'rej1'
    set ib_itemList[109] = 'pspd'
    set ib_itemList[110] = 'dust'
    set ib_itemList[111] = 'ram1'
    set ib_itemList[112] = 'pinv'
    set ib_itemList[113] = 'phea'
    set ib_itemList[114] = 'pman'
    set ib_itemList[115] = 'spro'
    set ib_itemList[116] = 'hslv'
    set ib_itemList[117] = 'moon'
    set ib_itemList[118] = 'shas'
    set ib_itemList[119] = 'skul'
    set ib_itemList[120] = 'mcri'
    set ib_itemList[121] = 'rnec'
    set ib_itemList[122] = 'tsct'
    set ib_itemList[123] = 'azhr'
    set ib_itemList[124] = 'bzbe'
    set ib_itemList[125] = 'bzbf'
    set ib_itemList[126] = 'ches'
    set ib_itemList[127] = 'cnhn'
    set ib_itemList[128] = 'glsk'
    set ib_itemList[129] = 'gopr'
    set ib_itemList[130] = 'k3m1'
    set ib_itemList[131] = 'k3m2'
    set ib_itemList[132] = 'k3m3'
    set ib_itemList[133] = 'ktrm'
    set ib_itemList[134] = 'kybl'
    set ib_itemList[135] = 'kygh'
    set ib_itemList[136] = 'kymn'
    set ib_itemList[137] = 'kysn'
    set ib_itemList[138] = 'ledg'
    set ib_itemList[139] = 'phlt'
    set ib_itemList[140] = 'sehr'
    set ib_itemList[141] = 'engs'
    set ib_itemList[142] = 'sorf'
    set ib_itemList[143] = 'gmfr'
    set ib_itemList[144] = 'jpnt'
    set ib_itemList[145] = 'shwd'
    set ib_itemList[146] = 'skrt'
    set ib_itemList[147] = 'thle'
    set ib_itemList[148] = 'sclp'
    set ib_itemList[149] = 'wtlg'
    set ib_itemList[150] = 'wolg'
    set ib_itemList[151] = 'mgtk'
    set ib_itemList[152] = 'mort'
    set ib_itemList[153] = 'dphe'
    set ib_itemList[154] = 'dkfw'
    set ib_itemList[155] = 'dthb'
    set ib_itemList[156] = 'fgun'
    set ib_itemList[157] = 'lure'
    set ib_itemList[158] = 'olig'
    set ib_itemList[159] = 'amrc'
    set ib_itemList[160] = 'ccmd'
    set ib_itemList[161] = 'flag'
    set ib_itemList[162] = 'gobm'
    set ib_itemList[163] = 'gsou'
    set ib_itemList[164] = 'nflg'
    set ib_itemList[165] = 'nspi'
    set ib_itemList[166] = 'oflg'
    set ib_itemList[167] = 'pams'
    set ib_itemList[168] = 'pgin'
    set ib_itemList[169] = 'rat3'
    set ib_itemList[170] = 'rde0'
    set ib_itemList[171] = 'rnsp'
    set ib_itemList[172] = 'soul'
    set ib_itemList[173] = 'tels'
    set ib_itemList[174] = 'tgxp'
    set ib_itemList[175] = 'uflg'
    set ib_itemList[176] = 'anfg'
    set ib_itemList[177] = 'brag'
    set ib_itemList[178] = 'drph'
    set ib_itemList[179] = 'iwbr'
    set ib_itemList[180] = 'jdrn'
    set ib_itemList[181] = 'lnrn'
    set ib_itemList[182] = 'mlst'
    set ib_itemList[183] = 'oslo'
    set ib_itemList[184] = 'sbok'
    set ib_itemList[185] = 'sksh'
    set ib_itemList[186] = 'sprn'
    set ib_itemList[187] = 'tmmt'
    set ib_itemList[188] = 'vddl'
    set ib_itemList[189] = 'spre'
    set ib_itemList[190] = 'sfog'
    set ib_itemList[191] = 'sor1'
    set ib_itemList[192] = 'sor2'
    set ib_itemList[193] = 'sor3'
    set ib_itemList[194] = 'sor4'
    set ib_itemList[195] = 'sor5'
    set ib_itemList[196] = 'sor6'
    set ib_itemList[197] = 'sor7'
    set ib_itemList[198] = 'sor8'
    set ib_itemList[199] = 'sor9'
    set ib_itemList[200] = 'sora'
    set ib_itemList[201] = 'fwss'
    set ib_itemList[202] = 'shtm'
    set ib_itemList[203] = 'esaz'
    set ib_itemList[204] = 'btst'
    set ib_itemList[205] = 'tbsm'
    set ib_itemList[206] = 'tfar'
    set ib_itemList[207] = 'tlum'
    set ib_itemList[208] = 'tbar'
    set ib_itemList[209] = 'tbak'
    set ib_itemList[210] = 'gldo'
    set ib_itemList[211] = 'stre'
    set ib_itemList[212] = 'horl'
    set ib_itemList[213] = 'hbth'
    set ib_itemList[214] = 'blba'
    set ib_itemList[215] = 'rugt'
    set ib_itemList[216] = 'frhg'
    set ib_itemList[217] = 'gvsm'
    set ib_itemList[218] = 'crdt'
    set ib_itemList[219] = 'arsc'
    set ib_itemList[220] = 'scul'
    set ib_itemList[221] = 'tmsc'
    set ib_itemList[222] = 'dtsb'
    set ib_itemList[223] = 'grsl'
    set ib_itemList[224] = 'arsh'
    set ib_itemList[225] = 'shdt'
    set ib_itemList[226] = 'shhn'
    set ib_itemList[227] = 'shen'
    set ib_itemList[228] = 'thdm'
    set ib_itemList[229] = 'stpg'
    set ib_itemList[230] = 'shrs'
    set ib_itemList[231] = 'bfhr'
    set ib_itemList[232] = 'cosl'
    set ib_itemList[233] = 'shcw'
    set ib_itemList[234] = 'srbd'
    set ib_itemList[235] = 'frgd'
    set ib_itemList[236] = 'envl'
    set ib_itemList[237] = 'rump'
    set ib_itemList[238] = 'srtl'
    set ib_itemList[239] = 'stwa'
    set ib_itemList[240] = 'klmm'
    set ib_itemList[241] = 'rots'
    set ib_itemList[242] = 'axas'
    set ib_itemList[243] = 'mnsf'
    set ib_itemList[244] = 'schl'
    set ib_itemList[245] = 'asbl'
    set ib_itemList[246] = 'kgal'
    set ib_itemList[247] = 'gold'
    set ib_itemList[248] = 'lmbr'
    set ib_itemList[249] = 'gfor'
    set ib_itemList[250] = 'guvi'
    set ib_itemList[251] = 'rspl'
    set ib_itemList[252] = 'rre1'
    set ib_itemList[253] = 'rre2'
    set ib_itemList[254] = 'gomn'
    set ib_itemList[255] = 'rsps'
    set ib_itemList[256] = 'rspd'
    set ib_itemList[257] = 'rman'
    set ib_itemList[258] = 'rma2'
    set ib_itemList[259] = 'rres'
    set ib_itemList[260] = 'rreb'
    set ib_itemList[261] = 'rhe1'
    set ib_itemList[262] = 'rhe2'
    set ib_itemList[263] = 'rhe3'
    set ib_itemList[264] = 'rdis'
    set ib_itemList[265] = 'rwat'
    set ib_itemList[266] = 'pclr'
    set ib_itemList[267] = 'plcl'
    set ib_itemList[268] = 'silk'
    set ib_itemList[269] = 'vamp'
    set ib_itemList[270] = 'sreg'
    set ib_itemList[271] = 'ssan'
    set ib_itemList[272] = 'tcas'
    set ib_itemCount = 273
    call IB_Message(GetLocalPlayer(), "装备系统就绪，共 " + I2S(ib_itemCount) + " 件装备")
    call IB_RegisterChat()
endfunction
