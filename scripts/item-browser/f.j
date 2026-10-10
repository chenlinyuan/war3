//============================================================================
// ITEM BROWSER - è£…å¤‡æœç´¢ä¸æ·»åŠ ç³»ç»Ÿ
// ä½œè€…: chenlinyuan (war3 mod é¡¹ç›®)
// åŠŸèƒ½:
//   è¾“å…¥ "search <å…³é”®è¯>"  æœç´¢åç§°åŒ…å«å…³é”®è¯çš„è£…å¤‡
//   è¾“å…¥ "additem <åç§°>"   æ·»åŠ è£…å¤‡ç»™å½“å‰é€‰ä¸­çš„è‹±é›„ï¼ˆèƒŒåŒ…æ»¡åˆ™æ‰åœ°ä¸Šï¼‰
//   è¾“å…¥ "additem <åç§°> n" æ·»åŠ  n ä¸ª
//   è¾“å…¥ "itembrowser"      æ˜¾ç¤ºå¸®åŠ©
//
// è¯´æ˜:
//   - ç‰©å“ ID åˆ—è¡¨åœ¨æ³¨å…¥æ—¶é¢„å…ˆæ‰«æå¹¶ç¡¬ç¼–ç ï¼Œè¿›æ¸¸æˆç«‹å³å¯ç”¨ï¼ˆæ— éœ€æšä¸¾ï¼‰
//   - æ”¯æŒä¸­æ–‡åç§°åŒ¹é…ï¼ˆä¸åŒºåˆ†å¤§å°å†™ï¼‰
//============================================================================

//---------------------------------------------------------------------------
// [å·¥å…·] ASCII è½¬å°å†™ï¼ˆä»…å¤„ç† A-Zï¼Œä¸åŠ¨ä¸­æ–‡ç­‰å¤šå­—èŠ‚å­—ç¬¦ï¼‰
// æ³¨æ„ï¼šä¸èƒ½ç”¨ StringCaseï¼Œå®ƒä¼šæŠŠ GBK ä¸­æ–‡å­—èŠ‚ä¹Ÿæ”¹å†™å¯¼è‡´ä¹±ç 
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
// [å·¥å…·] å­—ç¬¦ä¸²ä¸åŒºåˆ†å¤§å°å†™æ¯”è¾ƒï¼ˆä»… ASCII è½¬å°å†™ï¼Œä¸åŠ¨ä¸­æ–‡ï¼‰
//---------------------------------------------------------------------------
function IB_StrEqCI takes string a, string b returns boolean
    return IB_LowerAscii(a) == IB_LowerAscii(b)
endfunction

//---------------------------------------------------------------------------
// [å·¥å…·] å‘é€æ¶ˆæ¯ç»™ç©å®¶
//---------------------------------------------------------------------------
function IB_Message takes player p, string msg returns nothing
    call DisplayTimedTextToPlayer(p, 0, 0, 15.0, "|cff00ff00[è£…å¤‡]|r " + msg)
endfunction

//---------------------------------------------------------------------------
// [å·¥å…·] å‘é€æŠ€èƒ½æ¶ˆæ¯ç»™ç©å®¶
//---------------------------------------------------------------------------
function IB_SkillMessage takes player p, string msg returns nothing
    call DisplayTimedTextToPlayer(p, 0, 0, 15.0, "|cff00ffff[æŠ€èƒ½]|r " + msg)
endfunction

//---------------------------------------------------------------------------
// [å·¥å…·] å¸ƒå°”è½¬å­—ç¬¦ä¸²ï¼ˆè¯Šæ–­ç”¨ï¼‰
//---------------------------------------------------------------------------
function IB_BoolStr takes boolean b returns string
    if b then
        return "true"
    endif
    return "false"
endfunction

//---------------------------------------------------------------------------
// [å·¥å…·] è·å–ç‰©å“æ˜¾ç¤ºåï¼šç›´æ¥è¿”å›é¢„æ‰«æåç§°ï¼ˆå·²å»é¢œè‰²ç ï¼‰
//---------------------------------------------------------------------------
function IB_ItemName takes integer index returns string
    return ib_itemName[index]
endfunction

//---------------------------------------------------------------------------
// [å·¥å…·] å•ä¸ªå­—èŠ‚ -> å­—ç¬¦ï¼ˆå¯æ‰“å° ASCII åŸæ ·ï¼Œå¦åˆ™ .ï¼‰
//---------------------------------------------------------------------------
function IB_Char takes integer c returns string
    if c >= 32 and c <= 126 then
        return SubString(" !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~", c - 32, c - 31)
    endif
    return "."
endfunction

//---------------------------------------------------------------------------
// [å·¥å…·] æŠŠç‰©å“ IDï¼ˆFourCC æ•´æ•°ï¼‰è½¬æˆ 4 å­—ç¬¦å­—ç¬¦ä¸²ï¼Œç”¨äºåŒºåˆ†åŒåç‰©å“
//---------------------------------------------------------------------------
function IB_IdStr takes integer id returns string
    local integer b0 = id - (id / 256) * 256
    local integer b1 = (id / 256) - (id / 65536) * 256
    local integer b2 = (id / 65536) - (id / 16777216) * 256
    local integer b3 = id / 16777216
    return IB_Char(b3) + IB_Char(b2) + IB_Char(b1) + IB_Char(b0)
endfunction

//---------------------------------------------------------------------------
// [å·¥å…·] åˆ¤æ–­åç§°æ˜¯å¦åŒ…å«å…³é”®è¯ï¼ˆé€å­—èŠ‚ç›´æ¥æ¯”è¾ƒï¼Œä¸åšä»»ä½•å­—ç¬¦ä¸²é‡å»ºï¼‰
// é¢„æ‰«ææ—¶åç§°å·²å»é¢œè‰²ç å¹¶è½¬å°å†™ï¼›æ­¤å¤„åªå¯¹ keyword åš ASCII è½¬å°å†™ã€‚
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
// [å·¥å…·] è·å–ç©å®¶å½“å‰é€‰ä¸­çš„ç¬¬ä¸€ä¸ªå•ä½
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
// æœç´¢è£…å¤‡ï¼ˆåˆ†å¸§æ‰«æï¼šæ¯å¸§å¤„ç† 40 é¡¹ï¼ŒåŸç‰ˆ/è‡ªå®šä¹‰åˆ†å¼€æ˜¾ç¤ºï¼‰
//---------------------------------------------------------------------------
function IB_SearchStep takes nothing returns nothing
    local integer n = 0
    local string name
    local string nameGbk
    loop
        exitwhen ib_searchIdx >= ib_itemCount or n >= 40
        set nameGbk = ib_itemNameGbk[ib_searchIdx]
        if IB_NameMatch(IB_ItemName(ib_searchIdx), ib_searchKey) or (StringLength(nameGbk) > 0 and IB_NameMatch(nameGbk, ib_searchKey)) then
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
            call IB_Message(ib_searchPlayer, "æœªæ‰¾åˆ°åŒ…å« \"" + ib_searchKey + "\" çš„è£…å¤‡")
        else
            call DisplayTextToPlayer(ib_searchPlayer, 0, 0, "|cff00ff00[è£…å¤‡]|r å…±æ‰¾åˆ° " + I2S(ib_searchFound) + " ä»¶")
            if ib_searchStdN > 0 then
                call DisplayTextToPlayer(ib_searchPlayer, 0, 0, "|cffaaaaaaåŸç‰ˆ(" + I2S(ib_searchStdN) + "):|r " + ib_searchStd)
            endif
            if ib_searchCusN > 0 then
                call DisplayTextToPlayer(ib_searchPlayer, 0, 0, "|cff00ff00è‡ªå®šä¹‰(" + I2S(ib_searchCusN) + "):|r " + ib_searchCus)
            endif
        endif
        set ib_searchPlayer = null
    endif
endfunction

function IB_Search takes player p, string keyword returns nothing
    if StringLength(keyword) == 0 then
        call IB_Message(p, "è¯·è¾“å…¥å…³é”®è¯ï¼Œå¦‚: search å‰‘")
        return
    endif
    call IB_Message(p, "æœç´¢ \"" + keyword + "\" ...")
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
// æ·»åŠ è£…å¤‡ï¼ˆåˆ†å¸§æ‰«æï¼šå…ˆç²¾ç¡®/IDåŒ¹é…ï¼Œå†åŒ…å«åŒ¹é…ï¼›é¿å…è¶…æ“ä½œæ•°ä¸Šé™ï¼‰
//---------------------------------------------------------------------------
function IB_AddGive takes player p, integer itemId, integer count returns nothing
    local unit u = IB_GetSelectedUnit(p)
    local item it
    local real x
    local real y
    local integer added = 0
    if u == null then
        call IB_Message(p, "è¯·å…ˆé€‰ä¸­ä¸€ä¸ªè‹±é›„/å•ä½")
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
    call IB_Message(p, "å·²æ·»åŠ  " + I2S(added) + " ä¸ª \"" + IB_ItemName(ib_addFoundIdx) + "\"")
    set u = null
endfunction

function IB_AddStep takes nothing returns nothing
    local integer n = 0
    local string name
    local string nameGbk
    loop
        exitwhen ib_addIdx >= ib_itemCount or n >= 40
        set name = IB_ItemName(ib_addIdx)
        set nameGbk = ib_itemNameGbk[ib_addIdx]
        // ç²¾ç¡®åŒ¹é… æˆ– ID åŒ¹é…ï¼ˆID éœ€ä¸åŒºåˆ†å¤§å°å†™ï¼Œå› ä¸º ib_addName å·²è¢«è½¬å°å†™ï¼‰
        if name == ib_addName or IB_StrEqCI(IB_IdStr(ib_itemList[ib_addIdx]), ib_addName) then
            set ib_addFoundId = ib_itemList[ib_addIdx]
            set ib_addFoundIdx = ib_addIdx
            set ib_addIdx = ib_itemCount
        elseif ib_addFoundId == 0 then
            // è®°å½•ç¬¬ä¸€ä¸ªåŒ…å«åŒ¹é…ï¼ˆç»§ç»­æ‰«æä»¥ä¼˜å…ˆæ‰¾ç²¾ç¡®åŒ¹é…ï¼‰
            // åŒæ—¶åŒ¹é… UTF-8 åå’Œ GBK åï¼ˆæ¸¸æˆèŠå¤©è¾“å…¥ä¸º GBKï¼‰
            if IB_NameMatch(name, ib_addName) or (StringLength(nameGbk) > 0 and IB_NameMatch(nameGbk, ib_addName)) then
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
            call IB_Message(ib_addPlayer, "æœªæ‰¾åˆ°è£…å¤‡ \"" + ib_addName + "\"")
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
// è§£æ additem å‚æ•°ï¼š"åç§°" æˆ– "åç§° æ•°é‡"
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
                // æ•°å­—
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
// è¯Šæ–­ï¼šç»Ÿè®¡åŒ¹é…æ•°ï¼ˆé™åˆ¶æ‰«ææ•°é‡ï¼Œæµ‹è¯•æ˜¯å¦è§¦å‘æ“ä½œæ•°ä¸Šé™ï¼‰
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
    call DisplayTextToPlayer(p, 0, 0, "|cff00ff00[è¯Šæ–­]|r æ‰«æå‰" + I2S(limit) + "é¡¹ åŒ¹é…æ•°=" + I2S(found) + " å‰5: " + out)
endfunction

//---------------------------------------------------------------------------
// æŠ€èƒ½ç³»ç»Ÿ: ç»™é€‰ä¸­è‹±é›„æ·»åŠ /ç§»é™¤æŠ€èƒ½
//---------------------------------------------------------------------------
function IB_SkillName takes integer idx returns string
    return ib_skillName[idx]
endfunction

// å®é™…æ·»åŠ æŠ€èƒ½åˆ°é€‰ä¸­å•ä½
function IB_SkillGive takes player p, integer abilId, integer level returns nothing
    local unit u = IB_GetSelectedUnit(p)
    if u == null then
        call IB_SkillMessage(p, "è¯·å…ˆé€‰ä¸­ä¸€ä¸ªè‹±é›„/å•ä½")
        return
    endif
    call UnitAddAbility(u, abilId)
    call UnitMakeAbilityPermanent(u, true, abilId)
    if level > 1 then
        call SetUnitAbilityLevel(u, abilId, level)
    endif
    call IB_SkillMessage(p, "å·²æ·»åŠ æŠ€èƒ½ \"" + IB_SkillName(ib_skAddFoundIdx) + "\" [" + IB_IdStr(abilId) + "] ç­‰çº§" + I2S(level) + " åˆ° " + GetUnitName(u))
    set u = null
endfunction

// è®¾ç½®é€‰ä¸­å•ä½å·²æœ‰æŠ€èƒ½çš„ç­‰çº§
function IB_SkillSetLevel takes player p, integer abilId, integer level returns nothing
    local unit u = IB_GetSelectedUnit(p)
    local integer cur
    if u == null then
        call IB_SkillMessage(p, "è¯·å…ˆé€‰ä¸­ä¸€ä¸ªè‹±é›„/å•ä½")
        return
    endif
    set cur = GetUnitAbilityLevel(u, abilId)
    if cur == 0 then
        // æ²¡æœ‰è¯¥æŠ€èƒ½ -> ç›´æ¥æ·»åŠ 
        call UnitAddAbility(u, abilId)
        call UnitMakeAbilityPermanent(u, true, abilId)
    endif
    call SetUnitAbilityLevel(u, abilId, level)
    call IB_SkillMessage(p, "å·²è®¾ç½®æŠ€èƒ½ \"" + IB_SkillName(ib_skSetFoundIdx) + "\" [" + IB_IdStr(abilId) + "] ä¸º " + I2S(level) + " çº§ (åŸ" + I2S(cur) + "çº§)")
    set u = null
endfunction

// è®¾ç½®æŠ€èƒ½ç­‰çº§: åˆ†å¸§æ‰«ææ‰¾åŒ¹é…
function IB_SkillSetStep takes nothing returns nothing
    local integer n = 0
    local string name
    loop
        exitwhen ib_skSetIdx >= ib_skillCount or n >= 40
        set name = IB_SkillName(ib_skSetIdx)
        if name == ib_skSetName or IB_StrEqCI(IB_IdStr(ib_skillList[ib_skSetIdx]), ib_skSetName) then
            set ib_skSetFoundId = ib_skillList[ib_skSetIdx]
            set ib_skSetFoundIdx = ib_skSetIdx
            set ib_skSetIdx = ib_skillCount
        elseif ib_skSetFoundId == 0 then
            if IB_NameMatch(name, ib_skSetName) then
                set ib_skSetFoundId = ib_skillList[ib_skSetIdx]
                set ib_skSetFoundIdx = ib_skSetIdx
            endif
        endif
        set ib_skSetIdx = ib_skSetIdx + 1
        set n = n + 1
    endloop
    if ib_skSetIdx >= ib_skillCount then
        call PauseTimer(ib_skSetTimer)
        call DestroyTimer(ib_skSetTimer)
        set ib_skSetTimer = null
        if ib_skSetFoundId == 0 then
            call IB_SkillMessage(ib_skSetPlayer, "æœªæ‰¾åˆ°æŠ€èƒ½ \"" + ib_skSetName + "\"")
        else
            call IB_SkillSetLevel(ib_skSetPlayer, ib_skSetFoundId, ib_skSetLevel)
        endif
        set ib_skSetPlayer = null
    endif
endfunction

function IB_SetSkill takes player p, string skillName, integer level returns nothing
    if level < 1 then
        set level = 1
    endif
    set ib_skSetIdx = 0
    set ib_skSetName = IB_LowerAscii(skillName)
    set ib_skSetFoundId = 0
    set ib_skSetFoundIdx = -1
    set ib_skSetLevel = level
    set ib_skSetPlayer = p
    if ib_skSetTimer != null then
        call PauseTimer(ib_skSetTimer)
        call DestroyTimer(ib_skSetTimer)
    endif
    set ib_skSetTimer = CreateTimer()
    call TimerStart(ib_skSetTimer, 0.01, true, function IB_SkillSetStep)
endfunction

// è§£æ setskill å‚æ•°: "åç§° ç­‰çº§"
function IB_ParseSetSkill takes player p, string arg returns nothing
    local integer len = StringLength(arg)
    local integer i = len
    local integer lastSpace = -1
    local string skillName
    local string numStr
    local integer level = 1
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

    if lastSpace <= 0 then
        call IB_SkillMessage(p, "ç”¨æ³•: setskill <æŠ€èƒ½å> <ç­‰çº§>")
        return
    endif
    set skillName = SubString(arg, 0, lastSpace)
    set numStr = SubString(arg, lastSpace + 1, len)
    set isNum = StringLength(numStr) > 0
    set i = 0
    loop
        exitwhen i >= StringLength(numStr)
        set ch = SubString(numStr, i, i + 1)
        if ch == "0" or ch == "1" or ch == "2" or ch == "3" or ch == "4" or ch == "5" or ch == "6" or ch == "7" or ch == "8" or ch == "9" then
        else
            set isNum = false
            set i = StringLength(numStr)
        endif
        set i = i + 1
    endloop
    if not isNum then
        call IB_SkillMessage(p, "ç­‰çº§å¿…é¡»æ˜¯æ•°å­—ï¼Œç”¨æ³•: setskill <æŠ€èƒ½å> <ç­‰çº§>")
        return
    endif
    set level = S2I(numStr)
    call IB_SetSkill(p, skillName, level)
endfunction
// æ·»åŠ æŠ€èƒ½: åˆ†å¸§æ‰«ææ‰¾åŒ¹é…
function IB_SkillAddStep takes nothing returns nothing
    local integer n = 0
    local string name
    loop
        exitwhen ib_skAddIdx >= ib_skillCount or n >= 40
        set name = IB_SkillName(ib_skAddIdx)
        if name == ib_skAddName or IB_StrEqCI(IB_IdStr(ib_skillList[ib_skAddIdx]), ib_skAddName) then
            set ib_skAddFoundId = ib_skillList[ib_skAddIdx]
            set ib_skAddFoundIdx = ib_skAddIdx
            set ib_skAddIdx = ib_skillCount
        elseif ib_skAddFoundId == 0 then
            if IB_NameMatch(name, ib_skAddName) then
                set ib_skAddFoundId = ib_skillList[ib_skAddIdx]
                set ib_skAddFoundIdx = ib_skAddIdx
            endif
        endif
        set ib_skAddIdx = ib_skAddIdx + 1
        set n = n + 1
    endloop
    if ib_skAddIdx >= ib_skillCount then
        call PauseTimer(ib_skAddTimer)
        call DestroyTimer(ib_skAddTimer)
        set ib_skAddTimer = null
        if ib_skAddFoundId == 0 then
            call IB_SkillMessage(ib_skAddPlayer, "æœªæ‰¾åˆ°æŠ€èƒ½ \"" + ib_skAddName + "\"")
        else
            call IB_SkillGive(ib_skAddPlayer, ib_skAddFoundId, ib_skAddLevel)
        endif
        set ib_skAddPlayer = null
    endif
endfunction

// æ·»åŠ æŠ€èƒ½å…¥å£
function IB_AddSkill takes player p, string skillName, integer level returns nothing
    if level < 1 then
        set level = 1
    endif
    set ib_skAddIdx = 0
    set ib_skAddName = IB_LowerAscii(skillName)
    set ib_skAddFoundId = 0
    set ib_skAddFoundIdx = -1
    set ib_skAddLevel = level
    set ib_skAddPlayer = p
    if ib_skAddTimer != null then
        call PauseTimer(ib_skAddTimer)
        call DestroyTimer(ib_skAddTimer)
    endif
    set ib_skAddTimer = CreateTimer()
    call TimerStart(ib_skAddTimer, 0.01, true, function IB_SkillAddStep)
endfunction

function IB_SkillRemove takes player p, integer abilId returns nothing
    local unit u = IB_GetSelectedUnit(p)
    if u == null then
        call IB_SkillMessage(p, "è¯·å…ˆé€‰ä¸­ä¸€ä¸ªè‹±é›„/å•ä½")
        return
    endif
    call UnitRemoveAbility(u, abilId)
    call IB_SkillMessage(p, "å·²ç§»é™¤æŠ€èƒ½ [" + IB_IdStr(abilId) + "]")
    set u = null
endfunction

// åˆ¤æ–­æŠ€èƒ½æ˜¯å¦"å—ä¿æŠ¤"ï¼ˆä¸å±•ç¤ºã€ä¸ç§»é™¤ï¼‰
// å—ä¿æŠ¤: ç‰©å“æŠ€èƒ½(AI*)ã€è‹±é›„(AH*)ã€ç‰©å“æ (AInv)ã€æ”»å‡»(Aatk/Aat1-3)ã€ç§»åŠ¨(Amov)ã€
//         è—è™«(Aloc)ã€é˜²å¾¡(Adef)ã€é‡‡é›†(Ahrl) ç­‰æ ¸å¿ƒ/è¢«åŠ¨åŸºç¡€æŠ€èƒ½ã€‚
function IB_IsItemAbility takes integer abilId returns boolean
    if abilId == 'AI2m' or abilId == 'AIa1' or abilId == 'AIa3' or abilId == 'AIa4' or abilId == 'AIa6' or abilId == 'AIaa' or abilId == 'AIad' or abilId == 'AIae' then
        return true
    elseif abilId == 'AIam' or abilId == 'AIan' or abilId == 'AIar' or abilId == 'AIat' or abilId == 'AIau' or abilId == 'AIav' or abilId == 'AIaz' or abilId == 'AIba' then
        return true
    elseif abilId == 'AIbb' or abilId == 'AIbf' or abilId == 'AIbg' or abilId == 'AIbh' or abilId == 'AIbk' or abilId == 'AIbl' or abilId == 'AIbm' or abilId == 'AIbr' then
        return true
    elseif abilId == 'AIbs' or abilId == 'AIbt' or abilId == 'AIbx' or abilId == 'AIcb' or abilId == 'AIcd' or abilId == 'AIcf' or abilId == 'AIcl' or abilId == 'AIcm' then
        return true
    elseif abilId == 'AIco' or abilId == 'AIcs' or abilId == 'AIct' or abilId == 'AIcy' or abilId == 'AId0' or abilId == 'AId1' or abilId == 'AId2' or abilId == 'AId3' then
        return true
    elseif abilId == 'AId4' or abilId == 'AId5' or abilId == 'AId7' or abilId == 'AId8' or abilId == 'AIda' or abilId == 'AIdb' or abilId == 'AIdc' or abilId == 'AIdd' then
        return true
    elseif abilId == 'AIdf' or abilId == 'AIdi' or abilId == 'AIdm' or abilId == 'AIdn' or abilId == 'AIdp' or abilId == 'AIds' or abilId == 'AIdv' or abilId == 'AIe2' then
        return true
    elseif abilId == 'AIem' or abilId == 'AIev' or abilId == 'AIfa' or abilId == 'AIfb' or abilId == 'AIfd' or abilId == 'AIfe' or abilId == 'AIff' or abilId == 'AIfg' then
        return true
    elseif abilId == 'AIfh' or abilId == 'AIfl' or abilId == 'AIfm' or abilId == 'AIfn' or abilId == 'AIfo' or abilId == 'AIfr' or abilId == 'AIfs' or abilId == 'AIft' then
        return true
    elseif abilId == 'AIfu' or abilId == 'AIfw' or abilId == 'AIfx' or abilId == 'AIfz' or abilId == 'AIgd' or abilId == 'AIgf' or abilId == 'AIgm' or abilId == 'AIgo' then
        return true
    elseif abilId == 'AIgu' or abilId == 'AIgx' or abilId == 'AIh1' or abilId == 'AIh2' or abilId == 'AIh3' or abilId == 'AIha' or abilId == 'AIhb' or abilId == 'AIhl' then
        return true
    elseif abilId == 'AIhw' or abilId == 'AIhx' or abilId == 'AIi1' or abilId == 'AIi3' or abilId == 'AIi4' or abilId == 'AIi6' or abilId == 'AIil' or abilId == 'AIim' then
        return true
    elseif abilId == 'AIin' or abilId == 'AIir' or abilId == 'AIl1' or abilId == 'AIl2' or abilId == 'AIlb' or abilId == 'AIlf' or abilId == 'AIll' or abilId == 'AIlm' then
        return true
    elseif abilId == 'AIlp' or abilId == 'AIls' or abilId == 'AIlu' or abilId == 'AIlx' or abilId == 'AIlz' or abilId == 'AIm1' or abilId == 'AIm2' or abilId == 'AImb' then
        return true
    elseif abilId == 'AImh' or abilId == 'AImo' or abilId == 'AImr' or abilId == 'AIms' or abilId == 'AImt' or abilId == 'AImv' or abilId == 'AImx' or abilId == 'AImz' then
        return true
    elseif abilId == 'AInd' or abilId == 'AInm' or abilId == 'AIob' or abilId == 'AIos' or abilId == 'AIp1' or abilId == 'AIp2' or abilId == 'AIp3' or abilId == 'AIp4' then
        return true
    elseif abilId == 'AIp5' or abilId == 'AIp6' or abilId == 'AIpb' or abilId == 'AIpg' or abilId == 'AIpl' or abilId == 'AIpm' or abilId == 'AIpr' or abilId == 'AIps' then
        return true
    elseif abilId == 'AIpv' or abilId == 'AIpx' or abilId == 'AIpz' or abilId == 'AIra' or abilId == 'AIrb' or abilId == 'AIrc' or abilId == 'AIrd' or abilId == 'AIre' then
        return true
    elseif abilId == 'AIri' or abilId == 'AIrl' or abilId == 'AIrm' or abilId == 'AIrn' or abilId == 'AIrr' or abilId == 'AIrs' or abilId == 'AIrt' or abilId == 'AIrv' then
        return true
    elseif abilId == 'AIrx' or abilId == 'AIs1' or abilId == 'AIs2' or abilId == 'AIs3' or abilId == 'AIs4' or abilId == 'AIs6' or abilId == 'AIsa' or abilId == 'AIsb' then
        return true
    elseif abilId == 'AIse' or abilId == 'AIsh' or abilId == 'AIsi' or abilId == 'AIsl' or abilId == 'AIsm' or abilId == 'AIso' or abilId == 'AIsp' or abilId == 'AIsr' then
        return true
    elseif abilId == 'AIsw' or abilId == 'AIsx' or abilId == 'AIsz' or abilId == 'AIt6' or abilId == 'AIt9' or abilId == 'AIta' or abilId == 'AItb' or abilId == 'AItc' then
        return true
    elseif abilId == 'AItf' or abilId == 'AItg' or abilId == 'AIth' or abilId == 'AIti' or abilId == 'AItj' or abilId == 'AItk' or abilId == 'AItl' or abilId == 'AItm' then
        return true
    elseif abilId == 'AItn' or abilId == 'AItp' or abilId == 'AItx' or abilId == 'AIuf' or abilId == 'AIuv' or abilId == 'AIuw' or abilId == 'AIv1' or abilId == 'AIv2' then
        return true
    elseif abilId == 'AIva' or abilId == 'AIvl' or abilId == 'AIvu' or abilId == 'AIwb' or abilId == 'AIwm' or abilId == 'AIx1' or abilId == 'AIx2' or abilId == 'AIx3' then
        return true
    elseif abilId == 'AIx4' or abilId == 'AIx5' or abilId == 'AIxk' or abilId == 'AIxm' or abilId == 'AIxs' or abilId == 'AIzb' or abilId == 'ANbs' or abilId == 'ANpr' then
        return true
    elseif abilId == 'ANsa' or abilId == 'ANse' or abilId == 'ANss' or abilId == 'APdi' or abilId == 'APh1' or abilId == 'APh2' or abilId == 'APh3' or abilId == 'APmg' then
        return true
    elseif abilId == 'APmr' or abilId == 'APra' or abilId == 'APrl' or abilId == 'APrr' or abilId == 'APsa' or abilId == 'APwt' or abilId == 'AUds' or abilId == 'Ablp' then
        return true
    elseif abilId == 'Amec' or abilId == 'Apo2' or abilId == 'Arel' or abilId == 'Aret' or abilId == 'Arll' or abilId == 'Ashs' or abilId == 'Asou' or abilId == 'Aspb' then
        return true
    elseif abilId == 'Aspp' or abilId == 'Aste' or abilId == 'YDb0' or abilId == 'YDb1' or abilId == 'YDb2' or abilId == 'YDb3' or abilId == 'YDb4' or abilId == 'YDb5' then
        return true
    elseif abilId == 'YDb6' or abilId == 'YDb7' or abilId == 'YDb8' or abilId == 'YDb9' or abilId == 'YDba' or abilId == 'YDbb' or abilId == 'YDbc' or abilId == 'YDbd' then
        return true
    elseif abilId == 'YDbe' or abilId == 'YDbf' or abilId == 'YDbg' or abilId == 'YDbh' or abilId == 'YDbi' or abilId == 'YDbj' or abilId == 'YDbk' or abilId == 'YDbl' then
        return true
    elseif abilId == 'YDbm' or abilId == 'YDbn' or abilId == 'YDc0' or abilId == 'YDc1' or abilId == 'YDc2' or abilId == 'YDc3' or abilId == 'YDc4' or abilId == 'YDc5' then
        return true
    elseif abilId == 'YDc6' or abilId == 'YDc7' or abilId == 'YDc8' or abilId == 'YDc9' or abilId == 'YDca' or abilId == 'YDcb' or abilId == 'YDcc' or abilId == 'YDl0' then
        return true
    elseif abilId == 'YDl1' or abilId == 'YDl2' or abilId == 'YDl3' or abilId == 'YDl4' or abilId == 'YDl5' or abilId == 'YDl6' or abilId == 'YDl7' or abilId == 'YDl8' then
        return true
    elseif abilId == 'YDl9' or abilId == 'YDla' or abilId == 'YDlb' or abilId == 'YDlc' or abilId == 'YDld' or abilId == 'YDle' or abilId == 'YDlf' or abilId == 'YDm0' then
        return true
    elseif abilId == 'YDm1' or abilId == 'YDm2' or abilId == 'YDm3' or abilId == 'YDm4' or abilId == 'YDm5' or abilId == 'YDm6' or abilId == 'YDm7' or abilId == 'YDm8' then
        return true
    elseif abilId == 'YDm9' or abilId == 'YDma' or abilId == 'YDmb' or abilId == 'YDmc' or abilId == 'YDmd' or abilId == 'YDme' or abilId == 'YDmf' then
        return true
    endif
    return false
endfunction

function IB_SkillIsProtected takes integer abilId returns boolean
    local string id = IB_IdStr(abilId)
    local string p2 = SubString(id, 0, 2)
    // ç‰©å“æŠ€èƒ½ï¼ˆåŸºäºæ¸¸æˆæ•°æ® abilitydata.slk X8=itemï¼Œè¦†ç›– Arel/AIh1 ç­‰é AI å‰ç¼€çš„ï¼‰
    if IB_IsItemAbility(abilId) then
        return true
    endif
    // è‹±é›„ç±»æŠ€èƒ½ (AHxx)
    if p2 == "AH" then
        return true
    endif
    // å…·ä½“æ ¸å¿ƒæŠ€èƒ½
    if abilId == 'AInv' or abilId == 'AHer' or abilId == 'Aloc' then
        return true
    endif
    if abilId == 'Adef' or abilId == 'Ahrl' or abilId == 'Amov' or abilId == 'Aatk' then
        return true
    endif
    if abilId == 'Aat1' or abilId == 'Aat2' or abilId == 'Aat3' then
        return true
    endif
    return false
endfunction

// ç§»é™¤æŠ€èƒ½: åˆ†å¸§æ‰«æ
function IB_SkillRemStep takes nothing returns nothing
    local integer n = 0
    local string name
    loop
        exitwhen ib_skRemIdx >= ib_skillCount or n >= 40
        set name = IB_SkillName(ib_skRemIdx)
        if name == ib_skRemName or IB_StrEqCI(IB_IdStr(ib_skillList[ib_skRemIdx]), ib_skRemName) then
            // å—ä¿æŠ¤æŠ€èƒ½ä¸å¯ç§»é™¤
            if not IB_SkillIsProtected(ib_skillList[ib_skRemIdx]) then
                set ib_skRemFoundId = ib_skillList[ib_skRemIdx]
            endif
            set ib_skRemIdx = ib_skillCount
        elseif ib_skRemFoundId == 0 then
            if IB_NameMatch(name, ib_skRemName) and not IB_SkillIsProtected(ib_skillList[ib_skRemIdx]) then
                set ib_skRemFoundId = ib_skillList[ib_skRemIdx]
            endif
        endif
        set ib_skRemIdx = ib_skRemIdx + 1
        set n = n + 1
    endloop
    if ib_skRemIdx >= ib_skillCount then
        call PauseTimer(ib_skRemTimer)
        call DestroyTimer(ib_skRemTimer)
        set ib_skRemTimer = null
        if ib_skRemFoundId == 0 then
            call IB_SkillMessage(ib_skRemPlayer, "æœªæ‰¾åˆ°æŠ€èƒ½ \"" + ib_skRemName + "\"")
        else
            call IB_SkillRemove(ib_skRemPlayer, ib_skRemFoundId)
        endif
        set ib_skRemPlayer = null
    endif
endfunction

function IB_RemoveSkill takes player p, string skillName returns nothing
    set ib_skRemIdx = 0
    set ib_skRemName = IB_LowerAscii(skillName)
    set ib_skRemFoundId = 0
    set ib_skRemPlayer = p
    if ib_skRemTimer != null then
        call PauseTimer(ib_skRemTimer)
        call DestroyTimer(ib_skRemTimer)
    endif
    set ib_skRemTimer = CreateTimer()
    call TimerStart(ib_skRemTimer, 0.01, true, function IB_SkillRemStep)
endfunction

// æœç´¢æŠ€èƒ½: åˆ†å¸§æ‰«æ
function IB_SkillSearchStep takes nothing returns nothing
    local integer n = 0
    local string name
    loop
        exitwhen ib_skSearchIdx >= ib_skillCount or n >= 40
        if IB_NameMatch(IB_SkillName(ib_skSearchIdx), ib_skSearchKey) then
            if ib_skillCustom[ib_skSearchIdx] == 1 then
                set ib_skSearchCusN = ib_skSearchCusN + 1
                if ib_skSearchCusN <= 30 then
                    set name = IB_SkillName(ib_skSearchIdx) + "[" + IB_IdStr(ib_skillList[ib_skSearchIdx]) + "]"
                    set ib_skSearchCus = ib_skSearchCus + name + "  "
                endif
            else
                set ib_skSearchStdN = ib_skSearchStdN + 1
                if ib_skSearchStdN <= 30 then
                    set name = IB_SkillName(ib_skSearchIdx) + "[" + IB_IdStr(ib_skillList[ib_skSearchIdx]) + "]"
                    set ib_skSearchStd = ib_skSearchStd + name + "  "
                endif
            endif
        endif
        set ib_skSearchIdx = ib_skSearchIdx + 1
        set n = n + 1
    endloop
    if ib_skSearchIdx >= ib_skillCount then
        call PauseTimer(ib_skSearchTimer)
        call DestroyTimer(ib_skSearchTimer)
        set ib_skSearchTimer = null
        call IB_SkillMessage(ib_skSearchPlayer, "æœç´¢ \"" + ib_skSearchKey + "\" å…± " + I2S(ib_skSearchStdN + ib_skSearchCusN) + " ä¸ª")
        if ib_skSearchStdN > 0 then
            call IB_SkillMessage(ib_skSearchPlayer, "æ ‡å‡†(" + I2S(ib_skSearchStdN) + "): " + ib_skSearchStd)
        endif
        if ib_skSearchCusN > 0 then
            call IB_SkillMessage(ib_skSearchPlayer, "è‡ªå®šä¹‰(" + I2S(ib_skSearchCusN) + "): " + ib_skSearchCus)
        endif
        if ib_skSearchStdN > 30 or ib_skSearchCusN > 30 then
            call IB_SkillMessage(ib_skSearchPlayer, "(ç»“æœè¿‡å¤šï¼Œæ¯ç±»æœ€å¤šæ˜¾ç¤º30ä¸ªï¼Œè¯·ç”¨æ›´ç²¾ç¡®çš„å…³é”®è¯)")
        endif
        set ib_skSearchPlayer = null
    endif
endfunction

function IB_SkillSearch takes player p, string keyword returns nothing
    if StringLength(keyword) == 0 then
        call IB_SkillMessage(p, "è¯·è¾“å…¥å…³é”®è¯ï¼Œå¦‚: listskill è‡´å‘½")
        return
    endif
    set ib_skSearchIdx = 0
    set ib_skSearchKey = IB_LowerAscii(keyword)
    set ib_skSearchStd = ""
    set ib_skSearchCus = ""
    set ib_skSearchStdN = 0
    set ib_skSearchCusN = 0
    set ib_skSearchPlayer = p
    if ib_skSearchTimer != null then
        call PauseTimer(ib_skSearchTimer)
        call DestroyTimer(ib_skSearchTimer)
    endif
    set ib_skSearchTimer = CreateTimer()
    call TimerStart(ib_skSearchTimer, 0.01, true, function IB_SkillSearchStep)
endfunction

// è§£æ addskill å‚æ•°: "åç§°" æˆ– "åç§° ç­‰çº§"
function IB_ParseAddSkill takes player p, string arg returns nothing
    local integer len = StringLength(arg)
    local integer i = len
    local integer lastSpace = -1
    local string skillName
    local string numStr
    local integer level = 1
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
            else
                set isNum = false
                set i = StringLength(numStr)
            endif
            set i = i + 1
        endloop
        if isNum then
            set skillName = SubString(arg, 0, lastSpace)
            set level = S2I(numStr)
        else
            set skillName = arg
        endif
    else
        set skillName = arg
    endif
    call IB_AddSkill(p, skillName, level)
endfunction

//---------------------------------------------------------------------------
// ç§»é™¤æŠ€èƒ½å¯¹è¯æ¡†: åˆ—å‡ºé€‰ä¸­å•ä½æ‹¥æœ‰çš„æŠ€èƒ½, ç‚¹å‡»æŒ‰é’®ç§»é™¤
//---------------------------------------------------------------------------
function IB_RemoveSkillDialogClick takes nothing returns nothing
    local button b = GetClickedButton()
    local integer i = 0
    local integer aid
    loop
        exitwhen i >= ib_remDlgCount
        if b == ib_remDlgButton[i] then
            set aid = ib_remDlgAbil[i]
            if ib_remDlgUnit != null and GetUnitTypeId(ib_remDlgUnit) != 0 then
                call UnitRemoveAbility(ib_remDlgUnit, aid)
                call IB_SkillMessage(ib_remDlgPlayer, "å·²ç§»é™¤æŠ€èƒ½ [" + IB_IdStr(aid) + "]")
            endif
            set i = ib_remDlgCount
        endif
        set i = i + 1
    endloop
endfunction

function IB_ShowRemoveSkillDialog takes player p returns nothing
    local unit u = IB_GetSelectedUnit(p)
    local integer i = 0
    local integer aid
    local integer n = 0
    local string nm
    if u == null then
        call IB_SkillMessage(p, "è¯·å…ˆé€‰ä¸­ä¸€ä¸ªè‹±é›„/å•ä½")
        return
    endif
    if ib_remDialog != null then
        call DialogDestroy(ib_remDialog)
    endif
    set ib_remDialog = DialogCreate()
    set ib_remDlgUnit = u
    set ib_remDlgPlayer = p
    set ib_remDlgCount = 0
    // éå†æ ‡å‡†æŠ€èƒ½è¡¨ï¼Œæ‰¾å‡ºå•ä½æ‹¥æœ‰çš„æŠ€èƒ½ï¼ˆæœ€å¤š 12 ä¸ªï¼›è·³è¿‡å—ä¿æŠ¤æŠ€èƒ½ï¼‰
    loop
        exitwhen i >= ib_skillCount or n >= 12
        set aid = ib_skillList[i]
        if GetUnitAbilityLevel(u, aid) > 0 and not IB_SkillIsProtected(aid) then
            set ib_remDlgAbil[n] = aid
            set nm = ib_skillName[i]
            if StringLength(nm) == 0 then
                set nm = IB_IdStr(aid)
            endif
            set ib_remDlgButton[n] = DialogAddButton(ib_remDialog, nm + " [" + IB_IdStr(aid) + "]", 0)
            set n = n + 1
        endif
        set i = i + 1
    endloop
    // è‡ªå®šä¹‰æŠ€èƒ½
    if GetUnitAbilityLevel(u, ib_critAbility) > 0 and n < 12 then
        set ib_remDlgAbil[n] = ib_critAbility
        set ib_remDlgButton[n] = DialogAddButton(ib_remDialog, "è‡´å‘½ä¸€å‡» [" + IB_IdStr(ib_critAbility) + "]", 0)
        set n = n + 1
    endif
    if GetUnitAbilityLevel(u, ib_fingerAbility) > 0 and n < 12 then
        set ib_remDlgAbil[n] = ib_fingerAbility
        set ib_remDlgButton[n] = DialogAddButton(ib_remDialog, "æ­»äº¡ä¹‹æŒ‡ [" + IB_IdStr(ib_fingerAbility) + "]", 0)
        set n = n + 1
    endif
    set ib_remDlgCount = n
    if n == 0 then
        call IB_SkillMessage(p, "è¯¥å•ä½æ²¡æœ‰å¯ç§»é™¤çš„æŠ€èƒ½")
        call DialogDestroy(ib_remDialog)
        set ib_remDialog = null
        set u = null
        return
    endif
    // æ³¨å†Œç‚¹å‡»äº‹ä»¶ï¼ˆåªæ³¨å†Œä¸€æ¬¡ï¼‰
    if ib_remDlgTrig == null then
        set ib_remDlgTrig = CreateTrigger()
        call TriggerRegisterDialogEvent(ib_remDlgTrig, ib_remDialog)
        call TriggerAddAction(ib_remDlgTrig, function IB_RemoveSkillDialogClick)
    else
        call TriggerRegisterDialogEvent(ib_remDlgTrig, ib_remDialog)
    endif
    call DialogSetMessage(ib_remDialog, "é€‰æ‹©è¦ç§»é™¤çš„æŠ€èƒ½")
    call DialogDisplay(p, ib_remDialog, true)
    set u = null
endfunction

function IB_ParseRemoveSkill takes player p, string arg returns nothing
    // æ— å‚æ•° -> å¼¹å‡ºå¯¹è¯æ¡†åˆ—å‡ºå•ä½æŠ€èƒ½ä¾›ç‚¹å‡»ç§»é™¤
    if StringLength(arg) == 0 then
        call IB_ShowRemoveSkillDialog(p)
        return
    endif
    call IB_RemoveSkill(p, arg)
endfunction




//---------------------------------------------------------------------------
// ç§»é™¤é€‰ä¸­å•ä½çš„å…¨éƒ¨æŠ€èƒ½ï¼ˆåˆ†å¸§éå†æŠ€èƒ½åˆ—è¡¨ï¼Œé€ä¸ªæ£€æµ‹å¹¶ç§»é™¤ï¼‰
// JASS 1.27 æ— æ³•ç›´æ¥æšä¸¾å•ä½æŠ€èƒ½ï¼Œæ•…éå†å†…åµŒæŠ€èƒ½è¡¨ + GetUnitAbilityLevel æ£€æµ‹
//---------------------------------------------------------------------------
function IB_RemoveAllSkillStep takes nothing returns nothing
    local integer n = 0
    local integer lvl
    local integer aid
    // å•ä½å¯èƒ½å·²å¤±æ•ˆï¼ˆæ­»äº¡/ç§»é™¤ï¼‰-> ç›´æ¥ç»“æŸ
    if ib_skClrUnit == null or GetUnitTypeId(ib_skClrUnit) == 0 then
        call PauseTimer(ib_skClrTimer)
        call DestroyTimer(ib_skClrTimer)
        set ib_skClrTimer = null
        set ib_skClrPlayer = null
        set ib_skClrUnit = null
        return
    endif
    loop
        exitwhen ib_skClrIdx >= ib_skillCount or n >= 60
        set aid = ib_skillList[ib_skClrIdx]
        // è·³è¿‡å—ä¿æŠ¤æŠ€èƒ½ï¼ˆç§»é™¤ä¼šå¯¼è‡´å´©æºƒ/ç ´åå•ä½ï¼‰
        if not IB_SkillIsProtected(aid) then
            set lvl = GetUnitAbilityLevel(ib_skClrUnit, aid)
            if lvl > 0 then
                call UnitRemoveAbility(ib_skClrUnit, aid)
                set ib_skClrCount = ib_skClrCount + 1
            endif
        endif
        set ib_skClrIdx = ib_skClrIdx + 1
        set n = n + 1
    endloop
    if ib_skClrIdx >= ib_skillCount then
        // é¢å¤–ç§»é™¤æˆ‘ä»¬æ·»åŠ çš„è‡ªå®šä¹‰æŠ€èƒ½ï¼ˆä¸åœ¨æ ‡å‡†æŠ€èƒ½è¡¨ä¸­ï¼‰
        if GetUnitAbilityLevel(ib_skClrUnit, ib_critAbility) > 0 then
            call UnitRemoveAbility(ib_skClrUnit, ib_critAbility)
            set ib_skClrCount = ib_skClrCount + 1
        endif
        if GetUnitAbilityLevel(ib_skClrUnit, ib_fingerAbility) > 0 then
            call UnitRemoveAbility(ib_skClrUnit, ib_fingerAbility)
            set ib_skClrCount = ib_skClrCount + 1
        endif
        call PauseTimer(ib_skClrTimer)
        call DestroyTimer(ib_skClrTimer)
        set ib_skClrTimer = null
        call IB_SkillMessage(ib_skClrPlayer, "å·²ç§»é™¤ " + GetUnitName(ib_skClrUnit) + " çš„ " + I2S(ib_skClrCount) + " ä¸ªæŠ€èƒ½")
        set ib_skClrPlayer = null
        set ib_skClrUnit = null
    endif
endfunction

function IB_RemoveAllSkill takes player p returns nothing
    local unit u = IB_GetSelectedUnit(p)
    if u == null then
        call IB_SkillMessage(p, "è¯·å…ˆé€‰ä¸­ä¸€ä¸ªè‹±é›„/å•ä½")
        return
    endif
    set ib_skClrIdx = 0
    set ib_skClrCount = 0
    set ib_skClrPlayer = p
    set ib_skClrUnit = u
    if ib_skClrTimer != null then
        call PauseTimer(ib_skClrTimer)
        call DestroyTimer(ib_skClrTimer)
    endif
    set ib_skClrTimer = CreateTimer()
    call TimerStart(ib_skClrTimer, 0.01, true, function IB_RemoveAllSkillStep)
    set u = null
endfunction

//===========================================================================
// è‡´å‘½ä¸€å‡»ç³»ç»Ÿï¼ˆè‡ªå®šä¹‰æš´å‡»ï¼‰
//---------------------------------------------------------------------------
// æœºåˆ¶: ç”¨ unit group æ³¨å†Œ"æºå¸¦æš´å‡»"çš„å•ä½ï¼Œå…¶æ™®é€šæ”»å‡»æŒ‰åŠ æƒè¡¨éšæœºè§¦å‘æš´å‡»ï¼Œ
//       é¢å¤–é€ æˆ (å€ç‡-1) å€ä¼¤å®³ã€‚ç”¨"æ”»å‡»äº‹ä»¶æ ‡è®° + ä¼¤å®³äº‹ä»¶ç»“ç®—"é™å®šåªå¯¹æ™®æ”»ç”Ÿæ•ˆã€‚
//       ä¸ä¾èµ–ä»»ä½•è‡ªå®šä¹‰æŠ€èƒ½å¯¹è±¡æ•°æ®ï¼Œå¯åœ¨ä»»æ„åœ°å›¾ä½¿ç”¨ã€‚
//
// åŠ æƒè¡¨ï¼ˆæ¦‚ç‡åŠ å’Œ = 57%ï¼Œå…¶ä½™ 43% ä¸æš´å‡»ï¼‰:
//   30%  x2    12%  x3    8%   x4    4%   x5
//   2%   x50   1%   x100
//   â€”â€” å¦‚éœ€è°ƒæ•´æ•°å€¼ï¼Œåªæ”¹ä¸‹é¢ IB_CritRoll é‡Œçš„é˜ˆå€¼å³å¯ã€‚
//===========================================================================

// æ·éª°ï¼šè¿”å›æœ¬æ¬¡æš´å‡»å€ç‡ï¼ˆ>=2 è¡¨ç¤ºæš´å‡»ï¼‰
// æ·éª°ï¼šè¿”å›æœ¬æ¬¡æš´å‡»å€ç‡ï¼ˆ>=2 è¡¨ç¤ºæš´å‡»ï¼›0 è¡¨ç¤ºæœªæš´å‡»ï¼‰
// å•æ¬¡æ·éª°åŠ æƒè¡¨ï¼Œç´¯è®¡æ¦‚ç‡: 30/42/50/54/56/57/100
//   30% x2  12% x3  8% x4  4% x5  2% x50  1% x100  43% ä¸æš´å‡»
function IB_CritRoll takes nothing returns integer
    local integer r = GetRandomInt(1, 100)
    if r <= 30 then
        return 2
    elseif r <= 42 then
        return 3
    elseif r <= 50 then
        return 4
    elseif r <= 54 then
        return 5
    elseif r <= 56 then
        return 50
    elseif r <= 57 then
        return 100
    endif
    return 0
endfunction

// æ”»å‡»äº‹ä»¶: è®°å½•æ”»å‡»è€…/ç›®æ ‡ï¼Œæ ‡è®°"ä¸‹ä¸€æ¬¡ä¼¤å®³å¯èƒ½æ¥è‡ªæ™®æ”»"
function IB_CritOnAttack takes nothing returns nothing
    set ib_critAttacker = GetAttacker()
    set ib_critTarget = GetTriggerUnit()
    set ib_critArmed = true
endfunction

// åœ¨å•ä½ä¸Šæ–¹æ˜¾ç¤ºçº¢è‰²æ¼‚æµ®ä¼¤å®³æ•°å­— + æš´å‡»å€ç‡ï¼ˆå¦‚ "1234  x3!"ï¼‰
function IB_CritShowText takes unit u, real amount, integer mult returns nothing
    local texttag tt = CreateTextTag()
    local real x = GetUnitX(u)
    local real y = GetUnitY(u)
    call SetTextTagText(tt, I2S(R2I(amount)) + "  x" + I2S(mult) + "!", 0.024)
    call SetTextTagPos(tt, x, y, 60.0)
    call SetTextTagColor(tt, 255, 0, 0, 255)
    call SetTextTagVelocity(tt, 0.0, 0.04)
    call SetTextTagVisibility(tt, true)
    call SetTextTagFadepoint(tt, 1.5)
    call SetTextTagLifespan(tt, 2.0)
    call SetTextTagPermanent(tt, false)
    set tt = null
endfunction


// ä¼¤å®³äº‹ä»¶: è‹¥ä¸ºæ ‡è®°çš„æ™®æ”»ä¸”æ”»å‡»è€…åœ¨æš´å‡»ç»„ä¸­ï¼Œåˆ™æ·éª°å¹¶è¿½åŠ ä¼¤å®³
function IB_CritOnDamage takes nothing returns nothing
    local unit src = GetEventDamageSource()
    local unit tgt = GetTriggerUnit()
    local real dmg = GetEventDamage()
    local integer mult
    local real bonus

    // é‡å…¥ä¿æŠ¤: è¿½åŠ ä¼¤å®³ä¼šå†æ¬¡è§¦å‘æœ¬äº‹ä»¶ï¼Œç›´æ¥å¿½ç•¥
    if ib_critBusy then
        return
    endif
    // åªå¤„ç†"æ”»å‡»äº‹ä»¶åˆšæ ‡è®°è¿‡"çš„é‚£æ¬¡æ™®æ”»
    if not ib_critArmed then
        return
    endif
    if src != ib_critAttacker or tgt != ib_critTarget then
        return
    endif
    // æ¸…é™¤æ ‡è®°ï¼ˆä¸€æ¬¡æ”»å‡»åªç»“ç®—ä¸€æ¬¡ï¼‰
    set ib_critArmed = false
    if dmg <= 0.0 then
        return
    endif

    // --- è‡´å‘½ä¸€å‡» ---
    if not ib_critEnabled then
        return
    endif
    // æ”»å‡»è€…å¿…é¡»æºå¸¦è‡´å‘½ä¸€å‡»æŠ€èƒ½ï¼ˆè¢«åŠ¨å›¾æ ‡ï¼‰
    if GetUnitAbilityLevel(src, ib_critAbility) == 0 then
        return
    endif

    set mult = IB_CritRoll()
    // mult == 0 è¡¨ç¤ºæœªæš´å‡»ï¼Œä¸è¿½åŠ ä¼¤å®³
    if mult < 2 then
        return
    endif
    set bonus = dmg * I2R(mult - 1)
    set ib_critBusy = true
    call UnitDamageTarget(src, tgt, bonus, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_WHOKNOWS)
    set ib_critBusy = false

    set ib_critCount = ib_critCount + 1
    set ib_critLastMult = mult
    // åœ¨ç›®æ ‡ä¸Šæ–¹è·³å‡ºçº¢è‰²ä¼¤å®³æ•°å­— + å€ç‡ï¼ˆå¦‚ "1234  x3!"ï¼‰
    call IB_CritShowText(tgt, dmg + bonus, mult)
endfunction

// å•ä½æ­»äº¡: ä»æš´å‡»ç»„ç§»é™¤ï¼ˆé¿å…ç»„å†…ç§¯ç´¯æ— æ•ˆå•ä½ï¼‰
function IB_CritOnDeath takes nothing returns nothing
    local unit u = GetTriggerUnit()
    if IsUnitInGroup(u, ib_critGroup) then
        call GroupRemoveUnit(ib_critGroup, u)
    endif
    set u = null
endfunction

// ä¸ºå•ä¸ªå•ä½æ³¨å†Œä¼¤å®³äº‹ä»¶ï¼ˆå·²æ³¨å†Œåˆ™è·³è¿‡ï¼‰
function IB_CritRegisterUnit takes unit u returns nothing
    if u == null then
        return
    endif
    if IsUnitInGroup(u, ib_critRegGroup) then
        return
    endif
    call GroupAddUnit(ib_critRegGroup, u)
    call TriggerRegisterUnitEvent(ib_critDmgTrig, u, EVENT_UNIT_DAMAGED)
endfunction

// å•ä½è¿›å…¥åœ°å›¾ -> æ³¨å†Œä¼¤å®³äº‹ä»¶
function IB_CritOnEnter takes nothing returns nothing
    call IB_CritRegisterUnit(GetEnteringUnit())
endfunction

// ä¸ºåœ°å›¾ä¸Šæ‰€æœ‰ç°æœ‰å•ä½æ³¨å†Œä¼¤å®³äº‹ä»¶
function IB_CritRegisterAllUnits takes nothing returns nothing
    local group g = CreateGroup()
    local unit u
    call GroupEnumUnitsInRect(g, GetWorldBounds(), null)
    loop
        set u = FirstOfGroup(g)
        exitwhen u == null
        call IB_CritRegisterUnit(u)
        call GroupRemoveUnit(g, u)
    endloop
    call DestroyGroup(g)
    set g = null
endfunction

// æ³¨å†Œæš´å‡»äº‹ä»¶ï¼ˆåœ¨ IB_Init ä¸­è°ƒç”¨ä¸€æ¬¡ï¼‰
// æ³¨æ„: War3 1.27 æ²¡æœ‰ EVENT_PLAYER_UNIT_DAMAGEDï¼Œä¼¤å®³æ£€æµ‹éœ€ç”¨
//       "å•ä½è¿›å…¥åœ°å›¾ -> ä¸ºè¯¥å•ä½æ³¨å†Œ EVENT_UNIT_DAMAGED" çš„ç»å…¸ Damage Engine æ¨¡å¼ã€‚
function IB_CritInit takes nothing returns nothing
    local trigger ta = CreateTrigger()
    local trigger tt = CreateTrigger()
    local trigger te = CreateTrigger()
    local region reg = CreateRegion()
    local rect rc = GetWorldBounds()

    // å…ˆå»ºç»„ï¼ˆåç»­æ³¨å†Œ/ç»Ÿè®¡éƒ½è¦ç”¨ï¼‰
    set ib_critGroup = CreateGroup()
    set ib_critRegGroup = CreateGroup()

    // æ”»å‡»äº‹ä»¶ï¼ˆå…¨å±€ï¼‰
    call TriggerRegisterAnyUnitEventBJ(ta, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddAction(ta, function IB_CritOnAttack)

    // æ­»äº¡äº‹ä»¶ï¼ˆå…¨å±€ï¼‰
    call TriggerRegisterAnyUnitEventBJ(tt, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddAction(tt, function IB_CritOnDeath)

    // ä¼¤å®³äº‹ä»¶ï¼šä¸ºæ¯ä¸ªè¿›å…¥åœ°å›¾çš„å•ä½å•ç‹¬æ³¨å†Œ
    set ib_critDmgTrig = CreateTrigger()
    call TriggerAddAction(ib_critDmgTrig, function IB_CritOnDamage)
    call RegionAddRect(reg, rc)
    call TriggerRegisterEnterRegion(te, reg, null)
    call TriggerAddAction(te, function IB_CritOnEnter)

    // å·²åœ¨åœ°å›¾ä¸Šçš„é¢„ç½®å•ä½
    call IB_CritRegisterAllUnits()

    set ta = null
    set tt = null
    set te = null
    set rc = null
endfunction


// ç»™é€‰ä¸­å•ä½å¼€å¯æš´å‡»ï¼ˆæ·»åŠ è¢«åŠ¨æŠ€èƒ½å›¾æ ‡ï¼‰
function IB_CritEnable takes player p returns nothing
    local unit u = IB_GetSelectedUnit(p)
    if u == null then
        call IB_SkillMessage(p, "è¯·å…ˆé€‰ä¸­ä¸€ä¸ªè‹±é›„/å•ä½")
        return
    endif
    call UnitAddAbility(u, ib_critAbility)
    call UnitMakeAbilityPermanent(u, true, ib_critAbility)
    // æ·»åŠ æˆåŠŸä¸æç¤ºï¼ˆä¿æŒç•Œé¢å¹²å‡€ï¼‰
    set u = null
endfunction

// å…³é—­é€‰ä¸­å•ä½çš„æš´å‡»ï¼ˆç§»é™¤è¢«åŠ¨æŠ€èƒ½å›¾æ ‡ï¼‰
function IB_CritDisable takes player p returns nothing
    local unit u = IB_GetSelectedUnit(p)
    if u == null then
        call IB_SkillMessage(p, "è¯·å…ˆé€‰ä¸­ä¸€ä¸ªè‹±é›„/å•ä½")
        return
    endif
    call UnitRemoveAbility(u, ib_critAbility)
    call IB_SkillMessage(p, "å·²ç§»é™¤ " + GetUnitName(u) + " çš„ã€è‡´å‘½ä¸€å‡»ã€‘æŠ€èƒ½")
    set u = null
endfunction

// æ˜¾ç¤ºæš´å‡»ç³»ç»Ÿä¿¡æ¯
function IB_CritInfo takes player p returns nothing
    call IB_SkillMessage(p, "ã€è‡´å‘½ä¸€å‡»ã€‘æ¦‚ç‡è¡¨: 50%x2 30%x3 10%x4 4%x5 3%x10 2%x50 1%x100 (EV=4.8x)")
    call IB_SkillMessage(p, "æœ¬å±€å·²è§¦å‘æš´å‡» " + I2S(ib_critCount) + " æ¬¡ï¼Œæœ€è¿‘å€ç‡ x" + I2S(ib_critLastMult))
    call IB_SkillMessage(p, "å‘½ä»¤: criton/critoff(æ·»åŠ /ç§»é™¤æŠ€èƒ½) / crit(ä¿¡æ¯)")
endfunction

//===========================================================================
// å•ä½ç³»ç»Ÿï¼ˆç»™ç©å®¶æ·»åŠ /åˆ é™¤å•ä½ï¼‰
//---------------------------------------------------------------------------
// å‘½ä»¤:
//   listunit <å…³é”®è¯>   æœç´¢å•ä½åæˆ–æŠ¤ç”²ç±»å‹ï¼ˆå¦‚ listunit åœ£ æˆ– listunit divineï¼‰
//   addunit <åç§°>      åœ¨é€‰ä¸­å•ä½ä½ç½®åˆ›å»ºä¸€ä¸ªè¯¥å•ä½ï¼Œå½’å±ç©å®¶
//   addunit <å•ä½ID>    æŒ‰ ID åˆ›å»ºï¼ˆåŒºåˆ†åŒåï¼Œå¦‚ addunit hfooï¼‰
//   removeunit          åˆ é™¤å½“å‰é€‰ä¸­çš„å•ä½
//   removeunit <åç§°>   åˆ é™¤ç©å®¶æ‹¥æœ‰çš„æ‰€æœ‰è¯¥åç§°/ID çš„å•ä½
//===========================================================================

// å•ä½æ˜¾ç¤ºå
function IB_UnitName takes integer idx returns string
    return ib_unitName[idx]
endfunction

// å•ä½ååŒ¹é…ï¼šåŒæ—¶åŒ¹é… UTF-8 åå’Œ GBK åï¼ˆæ¸¸æˆèŠå¤©è¾“å…¥å¯èƒ½æ˜¯ GBKï¼‰
function IB_UnitNameMatch takes integer idx, string key returns boolean
    if IB_NameMatch(ib_unitName[idx], key) then
        return true
    endif
    if StringLength(ib_unitNameGbk[idx]) > 0 then
        if IB_NameMatch(ib_unitNameGbk[idx], key) then
            return true
        endif
    endif
    return false
endfunction


// å‘é€å•ä½æ¶ˆæ¯ç»™ç©å®¶
function IB_UnitMessage takes player p, string msg returns nothing
    call DisplayTimedTextToPlayer(p, 0, 0, 15.0, "|cffffcc00[å•ä½]|r " + msg)
endfunction

//---------------------------------------------------------------------------
// [è¯Šæ–­] ç¼–ç æ¢æµ‹: æŠ¥å‘Šè¾“å…¥å­—èŠ‚é•¿åº¦ + ä¸å­˜å‚¨å•ä½åæ¯”è¾ƒ
//---------------------------------------------------------------------------
function IB_EncProbe takes player p, string s returns nothing
    local integer len = StringLength(s)
    local integer i = 0
    local integer found = -1
    local string nm
    call IB_UnitMessage(p, "è¾“å…¥: \"" + s + "\" å­—èŠ‚é•¿åº¦=" + I2S(len))
    // æ‰¾ç¬¬ä¸€ä¸ªåå­—é‡Œå«"åœ£"çš„å•ä½ï¼ŒæŠ¥å‘Šå…¶å­—èŠ‚é•¿åº¦
    loop
        exitwhen i >= ib_unitCount
        set nm = ib_unitName[i]
        if IB_NameMatch(nm, "åœ£") then
            set found = i
            set i = ib_unitCount
        endif
        set i = i + 1
    endloop
    if found >= 0 then
        call IB_UnitMessage(p, "å•ä½[0]=\"" + ib_unitName[found] + "\" UTF8é•¿åº¦=" + I2S(StringLength(ib_unitName[found])) + " GBKé•¿åº¦=" + I2S(StringLength(ib_unitNameGbk[found])))
        call IB_UnitMessage(p, "åŒ¹é…UTF8å? " + IB_BoolStr(IB_NameMatch(ib_unitName[found], s)) + "  åŒ¹é…GBKå? " + IB_BoolStr(IB_NameMatch(ib_unitNameGbk[found], s)))
    else
        call IB_UnitMessage(p, "å­˜å‚¨åˆ—è¡¨é‡Œæ‰¾ä¸åˆ°å«\"åœ£\"çš„å•ä½(æ•°æ®é—®é¢˜)")
    endif
endfunction

//---------------------------------------------------------------------------
// æœç´¢å•ä½ï¼ˆåˆ†å¸§æ‰«æï¼šæ¯å¸§ 40 é¡¹ï¼›åŒ¹é…åç§°æˆ–æŠ¤ç”²ç±»å‹ï¼‰
//---------------------------------------------------------------------------
function IB_UnitSearchStep takes nothing returns nothing
    local integer n = 0
    local string line
    loop
        exitwhen ib_unSearchIdx >= ib_unitCount or n >= 40
        if IB_UnitNameMatch(ib_unSearchIdx, ib_unSearchKey) or IB_StrEqCI(ib_unitArmor[ib_unSearchIdx], ib_unSearchKey) then
            set ib_unSearchN = ib_unSearchN + 1
            if ib_unSearchN <= 30 then
                set line = IB_UnitName(ib_unSearchIdx) + "[" + IB_IdStr(ib_unitList[ib_unSearchIdx]) + "/" + ib_unitArmor[ib_unSearchIdx] + "]"
                set ib_unSearchOut = ib_unSearchOut + line + "  "
            endif
        endif
        set ib_unSearchIdx = ib_unSearchIdx + 1
        set n = n + 1
    endloop
    if ib_unSearchIdx >= ib_unitCount then
        call PauseTimer(ib_unSearchTimer)
        call DestroyTimer(ib_unSearchTimer)
        set ib_unSearchTimer = null
        if ib_unSearchN == 0 then
            call IB_UnitMessage(ib_unSearchPlayer, "æœªæ‰¾åˆ°å•ä½ \"" + ib_unSearchKey + "\"")
        else
            call IB_UnitMessage(ib_unSearchPlayer, "å•ä½ \"" + ib_unSearchKey + "\" å…± " + I2S(ib_unSearchN) + " ä¸ª:")
            call IB_UnitMessage(ib_unSearchPlayer, ib_unSearchOut)
        endif
        set ib_unSearchPlayer = null
    endif
endfunction

function IB_UnitSearch takes player p, string keyword returns nothing
    if StringLength(keyword) == 0 then
        call IB_UnitMessage(p, "è¯·è¾“å…¥å…³é”®è¯ï¼Œå¦‚: listunit åœ£ æˆ– listunit divine")
        return
    endif
    set ib_unSearchIdx = 0
    set ib_unSearchKey = IB_LowerAscii(keyword)
    set ib_unSearchOut = ""
    set ib_unSearchN = 0
    set ib_unSearchPlayer = p
    if ib_unSearchTimer != null then
        call PauseTimer(ib_unSearchTimer)
        call DestroyTimer(ib_unSearchTimer)
    endif
    set ib_unSearchTimer = CreateTimer()
    call TimerStart(ib_unSearchTimer, 0.01, true, function IB_UnitSearchStep)
endfunction

//---------------------------------------------------------------------------
// æ·»åŠ å•ä½: åˆ†å¸§æ‰«ææ‰¾åŒ¹é… -> åœ¨é€‰ä¸­å•ä½ä½ç½®åˆ›å»ºï¼Œå½’å±ç©å®¶
//---------------------------------------------------------------------------
// å®é™…åˆ›å»ºå•ä½
function IB_UnitGive takes player p, integer unitId returns nothing
    local unit src = IB_GetSelectedUnit(p)
    local real x
    local real y
    local unit u
    if src == null then
        call IB_UnitMessage(p, "è¯·å…ˆé€‰ä¸­ä¸€ä¸ªå•ä½ä½œä¸ºåˆ›å»ºä½ç½®")
        return
    endif
    set x = GetUnitX(src)
    set y = GetUnitY(src)
    set u = CreateUnit(p, unitId, x, y, GetUnitFacing(src))
    if u == null then
        call IB_UnitMessage(p, "åˆ›å»ºå•ä½å¤±è´¥ [" + IB_IdStr(unitId) + "]ï¼ˆè¯¥å•ä½å¯èƒ½ä¸å¯åˆ›å»ºï¼‰")
    else
        call IB_UnitMessage(p, "å·²åœ¨é€‰ä¸­ä½ç½®åˆ›å»º \"" + IB_UnitName(ib_unAddFoundIdx) + "\" [" + IB_IdStr(unitId) + "] å½’å± " + GetPlayerName(p))
    endif
    set src = null
    set u = null
endfunction

function IB_UnitAddStep takes nothing returns nothing
    local integer n = 0
    local string name
    loop
        exitwhen ib_unAddIdx >= ib_unitCount or n >= 40
        set name = IB_UnitName(ib_unAddIdx)
        if name == ib_unAddName or IB_StrEqCI(IB_IdStr(ib_unitList[ib_unAddIdx]), ib_unAddName) then
            set ib_unAddFoundId = ib_unitList[ib_unAddIdx]
            set ib_unAddFoundIdx = ib_unAddIdx
            set ib_unAddIdx = ib_unitCount
        elseif ib_unAddFoundId == 0 then
            if IB_UnitNameMatch(ib_unAddIdx, ib_unAddName) then
                set ib_unAddFoundId = ib_unitList[ib_unAddIdx]
                set ib_unAddFoundIdx = ib_unAddIdx
            endif
        endif
        set ib_unAddIdx = ib_unAddIdx + 1
        set n = n + 1
    endloop
    if ib_unAddIdx >= ib_unitCount then
        call PauseTimer(ib_unAddTimer)
        call DestroyTimer(ib_unAddTimer)
        set ib_unAddTimer = null
        if ib_unAddFoundId == 0 then
            call IB_UnitMessage(ib_unAddPlayer, "æœªæ‰¾åˆ°å•ä½ \"" + ib_unAddName + "\"")
        else
            call IB_UnitGive(ib_unAddPlayer, ib_unAddFoundId)
        endif
        set ib_unAddPlayer = null
    endif
endfunction

function IB_AddUnit takes player p, string unitName returns nothing
    set ib_unAddIdx = 0
    set ib_unAddName = unitName
    set ib_unAddFoundId = 0
    set ib_unAddFoundIdx = -1
    set ib_unAddPlayer = p
    if ib_unAddTimer != null then
        call PauseTimer(ib_unAddTimer)
        call DestroyTimer(ib_unAddTimer)
    endif
    set ib_unAddTimer = CreateTimer()
    call TimerStart(ib_unAddTimer, 0.01, true, function IB_UnitAddStep)
endfunction

//---------------------------------------------------------------------------
// åˆ é™¤å•ä½: æ— å‚æ•°åˆ é€‰ä¸­å•ä½ï¼›æœ‰å‚æ•°åˆ ç©å®¶æ‹¥æœ‰çš„è¯¥åç§°/ID å•ä½
//---------------------------------------------------------------------------
// å®é™…åˆ é™¤ï¼šéå†ç©å®¶å•ä½ï¼Œç§»é™¤åŒ¹é…çš„
function IB_UnitRemoveGive takes player p, integer unitId returns nothing
    local group g = CreateGroup()
    local unit u
    local integer cnt = 0
    if unitId == 0 then
        call IB_UnitMessage(p, "æœªæ‰¾åˆ°å•ä½ \"" + ib_unRemName + "\"")
        call DestroyGroup(g)
        set g = null
        return
    endif
    call GroupEnumUnitsOfPlayer(g, p, null)
    loop
        set u = FirstOfGroup(g)
        exitwhen u == null
        if GetUnitTypeId(u) == unitId then
            call RemoveUnit(u)
            set cnt = cnt + 1
        endif
        call GroupRemoveUnit(g, u)
    endloop
    call DestroyGroup(g)
    set g = null
    call IB_UnitMessage(p, "å·²åˆ é™¤ " + I2S(cnt) + " ä¸ª \"" + IB_UnitName(ib_unRemFoundIdx) + "\" å•ä½")
endfunction

function IB_UnitRemoveStep takes nothing returns nothing
    local integer n = 0
    local string name
    loop
        exitwhen ib_unRemIdx >= ib_unitCount or n >= 40
        set name = IB_UnitName(ib_unRemIdx)
        if name == ib_unRemName or IB_StrEqCI(IB_IdStr(ib_unitList[ib_unRemIdx]), ib_unRemName) then
            set ib_unRemFoundId = ib_unitList[ib_unRemIdx]
            set ib_unRemFoundIdx = ib_unRemIdx
            set ib_unRemIdx = ib_unitCount
        elseif ib_unRemFoundId == 0 then
            if IB_UnitNameMatch(ib_unRemIdx, ib_unRemName) then
                set ib_unRemFoundId = ib_unitList[ib_unRemIdx]
                set ib_unRemFoundIdx = ib_unRemIdx
            endif
        endif
        set ib_unRemIdx = ib_unRemIdx + 1
        set n = n + 1
    endloop
    if ib_unRemIdx >= ib_unitCount then
        call PauseTimer(ib_unRemTimer)
        call DestroyTimer(ib_unRemTimer)
        set ib_unRemTimer = null
        call IB_UnitRemoveGive(ib_unRemPlayer, ib_unRemFoundId)
        set ib_unRemPlayer = null
    endif
endfunction

// åˆ é™¤é€‰ä¸­å•ä½
function IB_RemoveSelectedUnit takes player p returns nothing
    local unit u = IB_GetSelectedUnit(p)
    if u == null then
        call IB_UnitMessage(p, "è¯·å…ˆé€‰ä¸­ä¸€ä¸ªå•ä½")
        return
    endif
    call IB_UnitMessage(p, "å·²åˆ é™¤é€‰ä¸­çš„ " + GetUnitName(u))
    call RemoveUnit(u)
    set u = null
endfunction

function IB_RemoveUnit takes player p, string arg returns nothing
    if StringLength(arg) == 0 then
        call IB_RemoveSelectedUnit(p)
        return
    endif
    set ib_unRemIdx = 0
    set ib_unRemName = arg
    set ib_unRemFoundId = 0
    set ib_unRemFoundIdx = -1
    set ib_unRemPlayer = p
    if ib_unRemTimer != null then
        call PauseTimer(ib_unRemTimer)
        call DestroyTimer(ib_unRemTimer)
    endif
    set ib_unRemTimer = CreateTimer()
    call TimerStart(ib_unRemTimer, 0.01, true, function IB_UnitRemoveStep)
endfunction

//===========================================================================
// æ­»äº¡ä¹‹æŒ‡ï¼ˆç§’æ€ä»»æ„å•ä½ï¼Œå«é­”å…ï¼‰
//---------------------------------------------------------------------------
// å‘½ä»¤:
//   deathfinger          ç§’æ€å½“å‰é€‰ä¸­çš„å•ä½ï¼ˆå¯¹é­”å…ä¹Ÿç”Ÿæ•ˆï¼‰
//   deathfinger <ä¼¤å®³>   è‡ªå®šä¹‰ç§’æ€ä¼¤å®³ï¼ˆé»˜è®¤ 1000000ï¼‰
//
// åŸç†: ç”¨ DAMAGE_TYPE_UNIVERSAL ä¼¤å®³ç±»å‹ç»•è¿‡é­”æ³•å…ç–«ä¸æŠ¤ç”²ï¼Œ
//       é€ æˆæå¤§ä¼¤å®³å®ç°"ç§’æ€"ã€‚å¯¹è‹±é›„/å»ºç­‘åŒæ ·æœ‰æ•ˆã€‚
//===========================================================================

// å‘é€æ­»äº¡ä¹‹æŒ‡æ¶ˆæ¯
function IB_FingerMessage takes player p, string msg returns nothing
    call DisplayTimedTextToPlayer(p, 0, 0, 15.0, "|cffcc00ff[æ­»äº¡ä¹‹æŒ‡]|r " + msg)
endfunction

// ç§’æ€æŒ‡å®šå•ä½ï¼ˆUNIVERSAL ä¼¤å®³ç»•è¿‡é­”å…/æŠ¤ç”²ï¼‰
function IB_FingerKillUnit takes player p, unit u, real dmg returns nothing
    call UnitDamageTarget(u, u, dmg, true, true, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_WHOKNOWS)
    // å…œåº•: è‹¥ç›®æ ‡ä»å­˜æ´»ï¼ˆå¦‚æ— æ•Œ/å…ç–«ä¼¤å®³ï¼‰ï¼Œå†ç›´æ¥ç½® 0 è¡€
    if GetUnitState(u, UNIT_STATE_LIFE) > 0.0 and not IsUnitType(u, UNIT_TYPE_DEAD) then
        call SetUnitLifeBJ(u, 1.0)
        call UnitDamageTarget(u, u, dmg, true, true, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_WHOKNOWS)
    endif
endfunction

// ç§’æ€å½“å‰é€‰ä¸­å•ä½
function IB_FingerKill takes player p, string arg returns nothing
    local unit u = IB_GetSelectedUnit(p)
    local real dmg = ib_fingerDamage
    if u == null then
        call IB_FingerMessage(p, "è¯·å…ˆé€‰ä¸­ä¸€ä¸ªç›®æ ‡å•ä½")
        return
    endif
    // è§£æå¯é€‰ä¼¤å®³å‚æ•°
    if StringLength(arg) > 0 then
        if S2I(arg) > 0 then
            set dmg = I2R(S2I(arg))
        endif
    endif
    if IsUnitType(u, UNIT_TYPE_DEAD) then
        call IB_FingerMessage(p, "ç›®æ ‡å·²æ­»äº¡")
        set u = null
        return
    endif
    call IB_FingerKillUnit(p, u, dmg)
    set ib_fingerCount = ib_fingerCount + 1
    call IB_FingerMessage(p, "å·²å¯¹ " + GetUnitName(u) + " æ–½æ”¾æ­»äº¡ä¹‹æŒ‡ï¼ˆä¼¤å®³ " + R2S(dmg) + "ï¼Œç´¯è®¡ " + I2S(ib_fingerCount) + " æ¬¡ï¼‰")
    set u = null
endfunction

//---------------------------------------------------------------------------
// æŠ€èƒ½æ ç‰ˆæœ¬: ç©å®¶ç‚¹å‡»ã€Œæ­»äº¡ä¹‹æŒ‡ã€æŠ€èƒ½å›¾æ ‡é‡Šæ”¾
// æŠ€èƒ½ ID = ib_fingerAbilityï¼ˆé»˜è®¤ A000ï¼Œç”± war3map.w3a å®šä¹‰ï¼‰
//---------------------------------------------------------------------------
function IB_FingerOnCast takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local player p = GetOwningPlayer(caster)
    if GetSpellAbilityId() != ib_fingerAbility then
        set caster = null
        set target = null
        return
    endif
    if target == null then
        call IB_FingerMessage(p, "æ­»äº¡ä¹‹æŒ‡éœ€è¦ç›®æ ‡å•ä½")
        set caster = null
        return
    endif
    call IB_FingerKillUnit(p, target, ib_fingerDamage)
    set ib_fingerCount = ib_fingerCount + 1
    // å‡»æ€åä¸æ˜¾ç¤ºæ–‡å­—æç¤ºï¼ˆä¿æŒç•Œé¢å¹²å‡€ï¼‰
    set caster = null
    set target = null
endfunction

// æ³¨å†ŒæŠ€èƒ½é‡Šæ”¾äº‹ä»¶ï¼ˆåœ¨ IB_Init ä¸­è°ƒç”¨ï¼‰
function IB_FingerCastInit takes nothing returns nothing
    local trigger t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddAction(t, function IB_FingerOnCast)
    set t = null
endfunction

// ç»™é€‰ä¸­å•ä½æ·»åŠ ã€Œæ­»äº¡ä¹‹æŒ‡ã€æŠ€èƒ½ï¼ˆæŠ€èƒ½æ å›¾æ ‡ï¼‰
function IB_FingerAddAbility takes player p returns nothing
    local unit u = IB_GetSelectedUnit(p)
    if u == null then
        call IB_FingerMessage(p, "è¯·å…ˆé€‰ä¸­ä¸€ä¸ªè‹±é›„/å•ä½")
        return
    endif
    call UnitAddAbility(u, ib_fingerAbility)
    call UnitMakeAbilityPermanent(u, true, ib_fingerAbility)
    // æ·»åŠ æˆåŠŸä¸æç¤ºï¼ˆä¿æŒç•Œé¢å¹²å‡€ï¼‰
    set u = null
endfunction

// [è¯Šæ–­] æ·»åŠ æ ‡å‡†å•ä½æŠ€èƒ½ ACcl(è¿é”é—ªç”µ) æµ‹è¯•æŠ€èƒ½æ æœºåˆ¶
function IB_FingerAddTest takes player p returns nothing
    local unit u = IB_GetSelectedUnit(p)
    local integer lvl
    if u == null then
        call IB_FingerMessage(p, "è¯·å…ˆé€‰ä¸­ä¸€ä¸ªè‹±é›„/å•ä½")
        return
    endif
    call UnitAddAbility(u, 'ACcl')
    call UnitMakeAbilityPermanent(u, true, 'ACcl')
    set lvl = GetUnitAbilityLevel(u, 'ACcl')
    call IB_FingerMessage(p, "æµ‹è¯•: å·²æ·»åŠ æ ‡å‡†æŠ€èƒ½ ACcl è¿é”é—ªç”µ, ç­‰çº§=" + I2S(lvl))
    set u = null
endfunction

// [è¯Šæ–­] æ·»åŠ è‡ªå®šä¹‰æŠ€èƒ½ A00O(æ¥è‡ª sj åœ°å›¾çš„çœŸå®è‡ªå®šä¹‰æŠ€èƒ½) æµ‹è¯• w3a æ˜¯å¦è¢«è¯»å–
function IB_FingerAddTest2 takes player p returns nothing
    local unit u = IB_GetSelectedUnit(p)
    local integer lvl
    if u == null then
        call IB_FingerMessage(p, "è¯·å…ˆé€‰ä¸­ä¸€ä¸ªè‹±é›„/å•ä½")
        return
    endif
    call UnitAddAbility(u, 'A00O')
    call UnitMakeAbilityPermanent(u, true, 'A00O')
    set lvl = GetUnitAbilityLevel(u, 'A00O')
    call IB_FingerMessage(p, "æµ‹è¯•2: å·²æ·»åŠ è‡ªå®šä¹‰æŠ€èƒ½ A00O, ç­‰çº§=" + I2S(lvl))
    set u = null
endfunction

//---------------------------------------------------------------------------
// è§£æèŠå¤©å‘½ä»¤
//---------------------------------------------------------------------------
function IB_OnChat takes nothing returns nothing
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
        call IB_Message(p, "è£…å¤‡ç³»ç»Ÿå°±ç»ªï¼Œå…± " + I2S(ib_itemCount) + " ä»¶è£…å¤‡")
        call IB_Message(p, "search <å…³é”®è¯>  æœç´¢è£…å¤‡ï¼ˆåŸç‰ˆ/è‡ªå®šä¹‰åˆ†å¼€æ˜¾ç¤ºï¼‰")
        call IB_Message(p, "additem <åç§°> [æ•°é‡]  æ·»åŠ è£…å¤‡")
        call IB_Message(p, "additem <ç‰©å“ID>  æŒ‰IDæ·»åŠ ï¼ˆåŒºåˆ†åŒåï¼Œå¦‚ additem I000ï¼‰")
    elseif IB_StrEqCI(cmd, "ibtest") then
        call IB_Message(p, "è¯Šæ–­: ib_itemCount=" + I2S(ib_itemCount))
        call IB_Message(p, "name[0]=" + IB_ItemName(0))
        call IB_Message(p, "name[273]=" + IB_ItemName(273))
        call IB_Message(p, "len(arg)=" + I2S(StringLength(arg)) + " arg=" + arg)
        call IB_Message(p, "match(arg,name273)=" + IB_BoolStr(IB_NameMatch(IB_ItemName(273), arg)))
        call IB_Message(p, "match(arg,name0)=" + IB_BoolStr(IB_NameMatch(IB_ItemName(0), arg)))
    elseif IB_StrEqCI(cmd, "ibcount") then
        call IB_Message(p, "ç»Ÿè®¡ \"" + arg + "\" åŒ¹é…æ•°...")
        call IB_CountMatch(p, arg)
    elseif IB_StrEqCI(cmd, "addskill") then
        call IB_ParseAddSkill(p, arg)
    elseif IB_StrEqCI(cmd, "removeskill") then
        call IB_ParseRemoveSkill(p, arg)
    elseif IB_StrEqCI(cmd, "listskill") then
        call IB_SkillSearch(p, arg)
    elseif IB_StrEqCI(cmd, "setskill") then
        call IB_ParseSetSkill(p, arg)
    elseif IB_StrEqCI(cmd, "listitem") then
        call IB_Search(p, arg)
    elseif IB_StrEqCI(cmd, "criton") then
        call IB_CritEnable(p)
    elseif IB_StrEqCI(cmd, "critoff") then
        call IB_CritDisable(p)
    elseif IB_StrEqCI(cmd, "crit") then
        call IB_CritInfo(p)
    elseif IB_StrEqCI(cmd, "listunit") then
        call IB_UnitSearch(p, arg)
    elseif IB_StrEqCI(cmd, "addunit") then
        call IB_AddUnit(p, arg)
    elseif IB_StrEqCI(cmd, "removeunit") then
        call IB_RemoveUnit(p, arg)
    elseif IB_StrEqCI(cmd, "unitdiag") then
        call IB_EncProbe(p, arg)
    elseif IB_StrEqCI(cmd, "deathfinger") or IB_StrEqCI(cmd, "finger") then
        call IB_FingerKill(p, arg)
    elseif IB_StrEqCI(cmd, "removeallskill") then
        call IB_RemoveAllSkill(p)
    elseif IB_StrEqCI(cmd, "fingeradd") then
        call IB_FingerAddAbility(p)
    elseif IB_StrEqCI(cmd, "fingertest") then
        call IB_FingerAddTest(p)
    elseif IB_StrEqCI(cmd, "fingertest2") then
        call IB_FingerAddTest2(p)
    endif
endfunction

//---------------------------------------------------------------------------
// æ³¨å†ŒèŠå¤©äº‹ä»¶
// ç”¨ TriggerAddActionï¼ˆè€Œé Conditionï¼‰æ³¨å†Œï¼šéƒ¨åˆ†åœ°å›¾/ç‰ˆæœ¬ä¸‹ä»…å« condition
// çš„èŠå¤©è§¦å‘å™¨ä¸ä¼šè§¦å‘ï¼›ç”¨ action æ›´å¯é ã€‚
//---------------------------------------------------------------------------
function IB_RegisterChat8 takes nothing returns nothing
    local integer i = 0
    local trigger t = CreateTrigger()
    loop
        exitwhen i > 11
        call TriggerRegisterPlayerChatEvent(t, Player(i), "listunit", false)
        call TriggerRegisterPlayerChatEvent(t, Player(i), "addunit", false)
        call TriggerRegisterPlayerChatEvent(t, Player(i), "removeunit", false)
        call TriggerRegisterPlayerChatEvent(t, Player(i), "unitdiag", false)
        call TriggerRegisterPlayerChatEvent(t, Player(i), "deathfinger", false)
        // "finger" ç”¨ç²¾ç¡®åŒ¹é…ï¼Œå¦åˆ™ä¼šè¯¯åŒ¹é… fingeradd/fingertest
        call TriggerRegisterPlayerChatEvent(t, Player(i), "finger", true)
        call TriggerRegisterPlayerChatEvent(t, Player(i), "removeallskill", false)
        call TriggerRegisterPlayerChatEvent(t, Player(i), "fingeradd", false)
        call TriggerRegisterPlayerChatEvent(t, Player(i), "fingertest", true)
        call TriggerRegisterPlayerChatEvent(t, Player(i), "fingertest2", true)
        set i = i + 1
    endloop
    call TriggerAddAction(t, function IB_OnChat)
    set t = null
    call PauseTimer(ib_regTimer)
    call DestroyTimer(ib_regTimer)
    set ib_regTimer = null
endfunction

function IB_RegisterChat7 takes nothing returns nothing
    local integer i = 0
    local trigger t = CreateTrigger()
    loop
        exitwhen i > 11
        call TriggerRegisterPlayerChatEvent(t, Player(i), "crit", false)
        set i = i + 1
    endloop
    call TriggerAddAction(t, function IB_OnChat)
    set t = null
    call TimerStart(ib_regTimer, 0.02, false, function IB_RegisterChat8)
endfunction

function IB_RegisterChat6 takes nothing returns nothing
    local integer i = 0
    local trigger t = CreateTrigger()
    loop
        exitwhen i > 11
        call TriggerRegisterPlayerChatEvent(t, Player(i), "listitem", false)
        set i = i + 1
    endloop
    call TriggerAddAction(t, function IB_OnChat)
    set t = null
    call TimerStart(ib_regTimer, 0.02, false, function IB_RegisterChat7)
endfunction

function IB_RegisterChat5 takes nothing returns nothing
    local integer i = 0
    local trigger t = CreateTrigger()
    loop
        exitwhen i > 11
        call TriggerRegisterPlayerChatEvent(t, Player(i), "listskill", false)
        call TriggerRegisterPlayerChatEvent(t, Player(i), "setskill", false)
        set i = i + 1
    endloop
    call TriggerAddAction(t, function IB_OnChat)
    set t = null
    call TimerStart(ib_regTimer, 0.02, false, function IB_RegisterChat6)
endfunction

function IB_RegisterChat4 takes nothing returns nothing
    local integer i = 0
    local trigger t = CreateTrigger()
    loop
        exitwhen i > 11
        call TriggerRegisterPlayerChatEvent(t, Player(i), "removeskill", false)
        set i = i + 1
    endloop
    call TriggerAddAction(t, function IB_OnChat)
    set t = null
    call TimerStart(ib_regTimer, 0.02, false, function IB_RegisterChat5)
endfunction

function IB_RegisterChat3 takes nothing returns nothing
    local integer i = 0
    local trigger t = CreateTrigger()
    loop
        exitwhen i > 11
        call TriggerRegisterPlayerChatEvent(t, Player(i), "addskill", false)
        set i = i + 1
    endloop
    call TriggerAddAction(t, function IB_OnChat)
    set t = null
    call TimerStart(ib_regTimer, 0.02, false, function IB_RegisterChat4)
endfunction

function IB_RegisterChat2 takes nothing returns nothing
    local integer i = 0
    local trigger t = CreateTrigger()
    loop
        exitwhen i > 11
        call TriggerRegisterPlayerChatEvent(t, Player(i), "additem", false)
        set i = i + 1
    endloop
    call TriggerAddAction(t, function IB_OnChat)
    set t = null
    // ç¬¬ä¸‰ç»„å‘½ä»¤(æŠ€èƒ½)ç»§ç»­åˆ†å¸§æ³¨å†Œ
    call TimerStart(ib_regTimer, 0.02, false, function IB_RegisterChat3)
endfunction
function IB_RegisterChat takes nothing returns nothing
    local integer i = 0
    local trigger t = CreateTrigger()
    loop
        exitwhen i > 11
        call TriggerRegisterPlayerChatEvent(t, Player(i), "search", false)
        call TriggerRegisterPlayerChatEvent(t, Player(i), "itembrowser", false)
        call TriggerRegisterPlayerChatEvent(t, Player(i), "ibtest", false)
        call TriggerRegisterPlayerChatEvent(t, Player(i), "ibcount", false)
        set i = i + 1
    endloop
    call TriggerAddAction(t, function IB_OnChat)
    set t = null
    // ç¬¬äºŒç»„å‘½ä»¤ç”¨ timer åˆ†å¸§æ³¨å†Œ,é¿å…ä¸€æ¬¡æ³¨å†Œè¿‡å¤šèŠå¤©äº‹ä»¶è€Œè¶…é™
    set ib_regTimer = CreateTimer()
    call TimerStart(ib_regTimer, 0.02, false, function IB_RegisterChat2)
endfunction

//---------------------------------------------------------------------------
// å…¥å£ï¼šç›´æ¥å¡«å……é¢„æ‰«æçš„ç‰©å“ ID åˆ—è¡¨ï¼Œç«‹å³æ³¨å†ŒèŠå¤©äº‹ä»¶ï¼ˆæ— éœ€æšä¸¾ï¼‰
//---------------------------------------------------------------------------












function IB_Fill0 takes nothing returns nothing
    set ib_itemList[0] = 'ckng'
    set ib_itemName[0] = "å›½ç‹ä¹‹å†  +5"
    set ib_itemCustom[0] = 0
    set ib_itemNameGbk[0] = "¹úÍõÖ®¹Ú +5"
    set ib_itemList[1] = 'modt'
    set ib_itemName[1] = "æ­»äº¡é¢ç½©"
    set ib_itemCustom[1] = 0
    set ib_itemNameGbk[1] = "ËÀÍöÃæÕÖ"
    set ib_itemList[2] = 'tkno'
    set ib_itemName[2] = "èƒ½é‡ä¹‹ä¹¦"
    set ib_itemCustom[2] = 0
    set ib_itemNameGbk[2] = "ÄÜÁ¿Ö®Êé"
    set ib_itemList[3] = 'infs'
    set ib_itemName[3] = "å°å‹æ ¸å¼¹"
    set ib_itemCustom[3] = 0
    set ib_itemNameGbk[3] = "Ğ¡ĞÍºËµ¯"
    set ib_itemList[4] = 'ajen'
    set ib_itemName[4] = "å¤ä¹‹å¿è€å§œæ­Œ"
    set ib_itemCustom[4] = 0
    set ib_itemNameGbk[4] = "¹ÅÖ®ÈÌÄÍ½ª¸è"
    set ib_itemList[5] = 'ward'
    set ib_itemName[5] = "æˆ˜æ­Œä¹‹é¼“"
    set ib_itemCustom[5] = 0
    set ib_itemNameGbk[5] = "Õ½¸èÖ®¹Ä"
    set ib_itemList[6] = 'crys'
    set ib_itemName[6] = "æ°´æ™¶çƒ"
    set ib_itemCustom[6] = 0
    set ib_itemNameGbk[6] = "Ë®¾§Çò"
    set ib_itemList[7] = 'lgdh'
    set ib_itemName[7] = "æ¯ç­ä¹‹è§’"
    set ib_itemCustom[7] = 0
    set ib_itemNameGbk[7] = "»ÙÃğÖ®½Ç"
    set ib_itemList[8] = 'sbch'
    set ib_itemName[8] = "å¤©ç¾éª¨é’Ÿ"
    set ib_itemCustom[8] = 0
    set ib_itemNameGbk[8] = "ÌìÔÖ¹ÇÖÓ"
    set ib_itemList[9] = 'brac'
    set ib_itemName[9] = "ç¥ç§˜è…°å¸¦"
    set ib_itemCustom[9] = 0
    set ib_itemNameGbk[9] = "ÉñÃØÑü´ø"
    set ib_itemList[10] = 'rwiz'
    set ib_itemName[10] = "è‰ºäººé¢ç½©"
    set ib_itemCustom[10] = 0
    set ib_itemNameGbk[10] = "ÒÕÈËÃæÕÖ"
    set ib_itemList[11] = 'ofir'
    set ib_itemName[11] = "ç«ç„°ä¹‹çƒ"
    set ib_itemCustom[11] = 0
    set ib_itemNameGbk[11] = "»ğÑæÖ®Çò"
    set ib_itemList[12] = 'ocor'
    set ib_itemName[12] = "è…èš€ä¹‹çƒ"
    set ib_itemCustom[12] = 0
    set ib_itemNameGbk[12] = "¸¯Ê´Ö®Çò"
    set ib_itemList[13] = 'oli2'
    set ib_itemName[13] = "é—ªç”µä¹‹çƒ"
    set ib_itemCustom[13] = 0
    set ib_itemNameGbk[13] = "ÉÁµçÖ®Çò"
    set ib_itemList[14] = 'oven'
    set ib_itemName[14] = "æ¯’æ¶²ä¹‹çƒ"
    set ib_itemCustom[14] = 0
    set ib_itemNameGbk[14] = "¶¾ÒºÖ®Çò"
    set ib_itemList[15] = 'evtl'
    set ib_itemName[15] = "å‘¼å•¦åœˆ"
    set ib_itemCustom[15] = 0
    set ib_itemNameGbk[15] = "ºôÀ²È¦"
    set ib_itemList[16] = 'tgrh'
    set ib_itemName[16] = "å°å‹çš„å¤§å…"
    set ib_itemCustom[16] = 0
    set ib_itemNameGbk[16] = "Ğ¡ĞÍµÄ´óÌü"
    set ib_itemList[17] = 'wlsd'
    set ib_itemName[17] = "é—ªç”µæŠ¤ç›¾æƒæ–"
    set ib_itemCustom[17] = 0
    set ib_itemNameGbk[17] = "ÉÁµç»¤¶ÜÈ¨ÕÈ"
    set ib_itemList[18] = 'rat6'
    set ib_itemName[18] = "æ”»å‡»ä¹‹çˆª +6"
    set ib_itemCustom[18] = 0
    set ib_itemNameGbk[18] = "¹¥»÷Ö®×¦ +6"
    set ib_itemList[19] = 'stwp'
    set ib_itemName[19] = "å›åŸå·è½´"
    set ib_itemCustom[19] = 0
    set ib_itemNameGbk[19] = "»Ø³Ç¾íÖá"
    set ib_itemList[20] = 'shea'
    set ib_itemName[20] = "åŒ»ç–—å·è½´"
    set ib_itemCustom[20] = 0
    set ib_itemNameGbk[20] = "Ò½ÁÆ¾íÖá"
    set ib_itemList[21] = 'dust'
    set ib_itemName[21] = "å°˜åœŸä¹‹å½±"
    set ib_itemCustom[21] = 0
    set ib_itemNameGbk[21] = "³¾ÍÁÖ®Ó°"
    set ib_itemList[22] = 'manh'
    set ib_itemName[22] = "ç”Ÿå‘½æ‰‹å†Œ"
    set ib_itemCustom[22] = 0
    set ib_itemNameGbk[22] = "ÉúÃüÊÖ²á"
    set ib_itemList[23] = 'phea'
    set ib_itemName[23] = "ç”Ÿå‘½è¯æ°´"
    set ib_itemCustom[23] = 0
    set ib_itemNameGbk[23] = "ÉúÃüÒ©Ë®"
    set ib_itemList[24] = 'pman'
    set ib_itemName[24] = "é­”æ³•è¯æ°´"
    set ib_itemCustom[24] = 0
    set ib_itemNameGbk[24] = "Ä§·¨Ò©Ë®"
    set ib_itemList[25] = 'hslv'
    set ib_itemName[25] = "åŒ»ç–—å‰‚"
    set ib_itemCustom[25] = 0
    set ib_itemNameGbk[25] = "Ò½ÁÆ¼Á"
    set ib_itemList[26] = 'moon'
    set ib_itemName[26] = "æœˆäº®çŸ³"
    set ib_itemCustom[26] = 0
    set ib_itemNameGbk[26] = "ÔÂÁÁÊ¯"
    set ib_itemList[27] = 'shas'
    set ib_itemName[27] = "é€Ÿåº¦å·è½´"
    set ib_itemCustom[27] = 0
    set ib_itemNameGbk[27] = "ËÙ¶È¾íÖá"
    set ib_itemList[28] = 'skul'
    set ib_itemName[28] = "çŒ®ç¥­å¤´éª¨"
    set ib_itemCustom[28] = 0
    set ib_itemNameGbk[28] = "Ï×¼ÀÍ·¹Ç"
    set ib_itemList[29] = 'mcri'
    set ib_itemName[29] = "æœºæ¢°ç±»çš„å°ç©è‰º"
    set ib_itemCustom[29] = 0
    set ib_itemNameGbk[29] = "»úĞµÀàµÄĞ¡ÍæÒÕ"
    set ib_itemList[30] = 'rnec'
    set ib_itemName[30] = "å·«æœ¯å¦–æ£"
    set ib_itemCustom[30] = 0
    set ib_itemNameGbk[30] = "Î×ÊõÑı¹÷"
    set ib_itemList[31] = 'tsct'
    set ib_itemName[31] = "è±¡ç‰™å¡”"
    set ib_itemCustom[31] = 0
    set ib_itemNameGbk[31] = "ÏóÑÀËş"
    set ib_itemList[32] = 'pams'
    set ib_itemName[32] = "æŠ—ä½“è¯æ°´"
    set ib_itemCustom[32] = 0
    set ib_itemNameGbk[32] = "¿¹ÌåÒ©Ë®"
    set ib_itemList[33] = 'spre'
    set ib_itemName[33] = "ä¿å­˜æƒæ–"
    set ib_itemCustom[33] = 0
    set ib_itemNameGbk[33] = "±£´æÈ¨ÕÈ"
    set ib_itemList[34] = 'lmbr'
    set ib_itemName[34] = "æœ¨æŸ´å †"
    set ib_itemCustom[34] = 0
    set ib_itemNameGbk[34] = "Ä¾²ñ¶Ñ"
    set ib_itemList[35] = 'plcl'
    set ib_itemName[35] = "å°å‡€åŒ–è¯æ°´"
    set ib_itemCustom[35] = 0
    set ib_itemNameGbk[35] = "Ğ¡¾»»¯Ò©Ë®"
    set ib_itemList[36] = 'sreg'
    set ib_itemName[36] = "æ¢å¤å·è½´"
    set ib_itemCustom[36] = 0
    set ib_itemNameGbk[36] = "»Ö¸´¾íÖá"
    set ib_itemList[37] = 'ssan'
    set ib_itemName[37] = "é¿éš¾æƒæ–"
    set ib_itemCustom[37] = 0
    set ib_itemNameGbk[37] = "±ÜÄÑÈ¨ÕÈ"
    set ib_itemList[38] = 'I001'
    set ib_itemName[38] = "æ•å…½ç½‘"
    set ib_itemCustom[38] = 1
    set ib_itemNameGbk[38] = "²¶ÊŞÍø"
    set ib_itemList[39] = 'I002'
    set ib_itemName[39] = "æ•£å¼¹æª (s)"
    set ib_itemCustom[39] = 1
    set ib_itemNameGbk[39] = "É¢µ¯Ç¹ (s)"
    set ib_itemList[40] = 'I003'
    set ib_itemName[40] = "éº»é†‰æª (t)"
    set ib_itemCustom[40] = 1
    set ib_itemNameGbk[40] = "Âé×íÇ¹ (t)"
    set ib_itemList[41] = 'I008'
    set ib_itemName[41] = "å¤œè§†é•œ"
    set ib_itemCustom[41] = 1
    set ib_itemNameGbk[41] = "Ò¹ÊÓ¾µ"
    set ib_itemList[42] = 'I00A'
    set ib_itemName[42] = "æ•£å¼¹æª å­å¼¹ (2 å‘)"
    set ib_itemCustom[42] = 1
    set ib_itemNameGbk[42] = "É¢µ¯Ç¹ ×Óµ¯ (2 ·¢)"
    set ib_itemList[43] = 'I00B'
    set ib_itemName[43] = "éº»é†‰é’ˆå­å¼¹"
    set ib_itemCustom[43] = 1
    set ib_itemNameGbk[43] = "Âé×íÕë×Óµ¯"
    set ib_itemList[44] = 'I00C'
    set ib_itemName[44] = "æŠ«è¨"
    set ib_itemCustom[44] = 1
    set ib_itemNameGbk[44] = "ÅûÈø"
    set ib_itemList[45] = 'I00D'
    set ib_itemName[45] = "å¯ä¹"
    set ib_itemCustom[45] = 1
    set ib_itemNameGbk[45] = "¿ÉÀÖ"
    set ib_itemList[46] = 'I00F'
    set ib_itemName[46] = "æ°”æ¯é¦™æ°´"
    set ib_itemCustom[46] = 1
    set ib_itemNameGbk[46] = "ÆøÏ¢ÏãË®"
    set ib_itemList[47] = 'I000'
    set ib_itemName[47] = "ç“¦æ–¯"
    set ib_itemCustom[47] = 1
    set ib_itemNameGbk[47] = "ÍßË¹"
    set ib_itemList[48] = 'I004'
    set ib_itemName[48] = "å°æœ¨æå †"
    set ib_itemCustom[48] = 1
    set ib_itemNameGbk[48] = "Ğ¡Ä¾²Ä¶Ñ"
    set ib_itemList[49] = 'I005'
    set ib_itemName[49] = "ç©å…· (æœ‰)"
    set ib_itemCustom[49] = 1
    set ib_itemNameGbk[49] = "Íæ¾ß (ÓĞ)"
    set ib_itemList[50] = 'I006'
    set ib_itemName[50] = "ç¯ç«è‡ªåŠ¨å»ºé€ "
    set ib_itemCustom[50] = 1
    set ib_itemNameGbk[50] = "óô»ğ×Ô¶¯½¨Ôì"
    set ib_itemList[51] = 'I007'
    set ib_itemName[51] = "è¥ç«è‡ªåŠ¨å»ºé€ "
    set ib_itemCustom[51] = 1
    set ib_itemNameGbk[51] = "Óª»ğ×Ô¶¯½¨Ôì"
    set ib_itemList[52] = 'I009'
    set ib_itemName[52] = "å¸ç¯·è‡ªåŠ¨å»ºé€ "
    set ib_itemCustom[52] = 1
    set ib_itemNameGbk[52] = "ÕÊÅñ×Ô¶¯½¨Ôì"
    set ib_itemList[53] = 'I00E'
    set ib_itemName[53] = "å‘ç”µå‚è‡ªåŠ¨å»ºé€ "
    set ib_itemCustom[53] = 1
    set ib_itemNameGbk[53] = "·¢µç³§×Ô¶¯½¨Ôì"
    set ib_itemList[54] = 'I00G'
    set ib_itemName[54] = "ç”µå¢™è‡ªåŠ¨å»ºé€ "
    set ib_itemCustom[54] = 1
    set ib_itemNameGbk[54] = "µçÇ½×Ô¶¯½¨Ôì"
    set ib_itemList[55] = 'I00H'
    set ib_itemName[55] = "é«˜æ¡£çš„éšèº«è¡£"
    set ib_itemCustom[55] = 1
    set ib_itemNameGbk[55] = "¸ßµµµÄÒşÉíÒÂ"
    set ib_itemList[56] = 'I00I'
    set ib_itemName[56] = "æ”¾å¤§é•œ"
    set ib_itemCustom[56] = 1
    set ib_itemNameGbk[56] = "·Å´ó¾µ"
    set ib_itemList[57] = 'I00J'
    set ib_itemName[57] = "æœ›è¿œé•œ"
    set ib_itemCustom[57] = 1
    set ib_itemNameGbk[57] = "ÍûÔ¶¾µ"
    set ib_itemList[58] = 'I00K'
    set ib_itemName[58] = "å°åŒ…å½©çƒ"
    set ib_itemCustom[58] = 1
    set ib_itemNameGbk[58] = "Ğ¡°ü²ÊÇò"
    set ib_itemList[59] = 'I00L'
    set ib_itemName[59] = "æ‰‹æªå­å¼¹ (7 å‘)"
    set ib_itemCustom[59] = 1
    set ib_itemNameGbk[59] = "ÊÖÇ¹×Óµ¯ (7 ·¢)"
    set ib_itemList[60] = 'I00M'
    set ib_itemName[60] = "æ‰‹æª"
    set ib_itemCustom[60] = 1
    set ib_itemNameGbk[60] = "ÊÖÇ¹"
    set ib_itemList[61] = 'I00N'
    set ib_itemName[61] = "æé¾™æ²»ç–—è¯å‰‚"
    set ib_itemCustom[61] = 1
    set ib_itemNameGbk[61] = "¿ÖÁúÖÎÁÆÒ©¼Á"
    set ib_itemList[62] = 'I00O'
    set ib_itemName[62] = "ç”Ÿç‰©ç ”ç©¶ç¬”è®°"
    set ib_itemCustom[62] = 1
    set ib_itemNameGbk[62] = "ÉúÎïÑĞ¾¿±Ê¼Ç"
    set ib_itemList[63] = 'I00P'
    set ib_itemName[63] = "ç«åŠ›ç ”ç©¶ç¬”è®°"
    set ib_itemCustom[63] = 1
    set ib_itemNameGbk[63] = "»ğÁ¦ÑĞ¾¿±Ê¼Ç"
    set ib_itemList[64] = 'I00Q'
    set ib_itemName[64] = "æœºæª"
    set ib_itemCustom[64] = 1
    set ib_itemNameGbk[64] = "»úÇ¹"
    set ib_itemList[65] = 'I00R'
    set ib_itemName[65] = "æœºæªå­å¼¹ (30 å‘)"
    set ib_itemCustom[65] = 1
    set ib_itemNameGbk[65] = "»úÇ¹×Óµ¯ (30 ·¢)"
    set ib_itemList[66] = 'I00S'
    set ib_itemName[66] = "æœºæªç‚®"
    set ib_itemCustom[66] = 1
    set ib_itemNameGbk[66] = "»úÇ¹ÅÚ"
    set ib_itemList[67] = 'I00T'
    set ib_itemName[67] = "ä¸­å‹æ¿€å…‰"
    set ib_itemCustom[67] = 1
    set ib_itemNameGbk[67] = "ÖĞĞÍ¼¤¹â"
    set ib_itemList[68] = 'I00V'
    set ib_itemName[68] = "ç«ç„°å–·å°„å™¨"
    set ib_itemCustom[68] = 1
    set ib_itemNameGbk[68] = "»ğÑæÅçÉäÆ÷"
    set ib_itemList[69] = 'I00W'
    set ib_itemName[69] = "ç«ç®­å‘å°„å™¨"
    set ib_itemCustom[69] = 1
    set ib_itemNameGbk[69] = "»ğ¼ı·¢ÉäÆ÷"
    set ib_itemList[70] = 'I00U'
    set ib_itemName[70] = "ç©å…· (æ— )"
    set ib_itemCustom[70] = 1
    set ib_itemNameGbk[70] = "Íæ¾ß (ÎŞ)"
    set ib_itemList[71] = 'I00X'
    set ib_itemName[71] = "å°æ°´å¼¹"
    set ib_itemCustom[71] = 1
    set ib_itemNameGbk[71] = "Ğ¡Ë®µ¯"
    set ib_itemList[72] = 'I00Y'
    set ib_itemName[72] = "æé¾™è›‹"
    set ib_itemCustom[72] = 1
    set ib_itemNameGbk[72] = "¿ÖÁúµ°"
    set ib_itemList[73] = 'I00Z'
    set ib_itemName[73] = "æ™®é€šçš„éšèº«è¡£"
    set ib_itemCustom[73] = 1
    set ib_itemNameGbk[73] = "ÆÕÍ¨µÄÒşÉíÒÂ"
    set ib_itemList[74] = 'I010'
    set ib_itemName[74] = "ç¯ç«è‡ªåŠ¨å»ºé€  (3 çµ„)"
    set ib_itemCustom[74] = 1
    set ib_itemNameGbk[74] = "óô»ğ×Ô¶¯½¨Ôì (3 ½M)"
    set ib_itemList[75] = 'I011'
    set ib_itemName[75] = "è¥ç«è‡ªåŠ¨å»ºé€  (2 ç»„)"
    set ib_itemCustom[75] = 1
    set ib_itemNameGbk[75] = "Óª»ğ×Ô¶¯½¨Ôì (2 ×é)"
    set ib_itemList[76] = 'I012'
    set ib_itemName[76] = "ç”µå¢™è‡ªåŠ¨å»ºé€  (3 çµ„)"
    set ib_itemCustom[76] = 1
    set ib_itemNameGbk[76] = "µçÇ½×Ô¶¯½¨Ôì (3 ½M)"
    set ib_itemList[77] = 'I013'
    set ib_itemName[77] = "å‘ç”µå‚è‡ªåŠ¨å»ºé€  (3 çµ„)"
    set ib_itemCustom[77] = 1
    set ib_itemNameGbk[77] = "·¢µç³§×Ô¶¯½¨Ôì (3 ½M)"
    set ib_itemList[78] = 'I014'
    set ib_itemName[78] = "å¸ç¯·è‡ªåŠ¨å»ºé€  (2 ç»„)"
    set ib_itemCustom[78] = 1
    set ib_itemNameGbk[78] = "ÕÊÅñ×Ô¶¯½¨Ôì (2 ×é)"
    set ib_itemList[79] = 'I015'
    set ib_itemName[79] = "å¯åŠ¨ ç«ç„°å–·å°„å™¨"
    set ib_itemCustom[79] = 1
    set ib_itemNameGbk[79] = "Æô¶¯ »ğÑæÅçÉäÆ÷"
endfunction
function IB_Fill1 takes nothing returns nothing
    set ib_itemList[80] = 'I016'
    set ib_itemName[80] = "å…³é—­ ç«ç„°å–·å°„å™¨"
    set ib_itemCustom[80] = 1
    set ib_itemNameGbk[80] = "¹Ø±Õ »ğÑæÅçÉäÆ÷"
    set ib_itemList[81] = 'I017'
    set ib_itemName[81] = "ç”µæ± "
    set ib_itemCustom[81] = 1
    set ib_itemNameGbk[81] = "µç³Ø"
    set ib_itemList[82] = 'I018'
    set ib_itemName[82] = "é¥æ§å‰æ™®è½¦ (common)"
    set ib_itemCustom[82] = 1
    set ib_itemNameGbk[82] = "Ò£¿Ø¼ªÆÕ³µ (common)"
    set ib_itemList[83] = 'I019'
    set ib_itemName[83] = "å¯åŠ¨ ç«ç®­å‘å°„å™¨"
    set ib_itemCustom[83] = 1
    set ib_itemNameGbk[83] = "Æô¶¯ »ğ¼ı·¢ÉäÆ÷"
    set ib_itemList[84] = 'I01A'
    set ib_itemName[84] = "å…³é—­ ç«ç®­å‘å°„å™¨"
    set ib_itemCustom[84] = 1
    set ib_itemNameGbk[84] = "¹Ø±Õ »ğ¼ı·¢ÉäÆ÷"
    set ib_itemList[85] = 'I01B'
    set ib_itemName[85] = "å¯åŠ¨ ä¸­å‹æ¿€å…‰"
    set ib_itemCustom[85] = 1
    set ib_itemNameGbk[85] = "Æô¶¯ ÖĞĞÍ¼¤¹â"
    set ib_itemList[86] = 'I01C'
    set ib_itemName[86] = "å…³é—­ ä¸­å‹æ¿€å…‰"
    set ib_itemCustom[86] = 1
    set ib_itemNameGbk[86] = "¹Ø±Õ ÖĞĞÍ¼¤¹â"
    set ib_itemList[87] = 'I01D'
    set ib_itemName[87] = "ç»´ä¿®å·¥å…·åŒ…"
    set ib_itemCustom[87] = 1
    set ib_itemNameGbk[87] = "Î¬ĞŞ¹¤¾ß°ü"
    set ib_itemList[88] = 'I01E'
    set ib_itemName[88] = "é‡æ–§"
    set ib_itemCustom[88] = 1
    set ib_itemNameGbk[88] = "ÖØ¸«"
    set ib_itemList[89] = 'I01F'
    set ib_itemName[89] = "æ€è™«å‰‚"
    set ib_itemCustom[89] = 1
    set ib_itemNameGbk[89] = "É±³æ¼Á"
    set ib_itemList[90] = 'I01G'
    set ib_itemName[90] = "ä¸­æœ¨æå †"
    set ib_itemCustom[90] = 1
    set ib_itemNameGbk[90] = "ÖĞÄ¾²Ä¶Ñ"
    set ib_itemList[91] = 'I01H'
    set ib_itemName[91] = "æ‰‹æªå­å¼¹ (7 å‘) x4ç»„"
    set ib_itemCustom[91] = 1
    set ib_itemNameGbk[91] = "ÊÖÇ¹×Óµ¯ (7 ·¢) x4×é"
    set ib_itemList[92] = 'I01I'
    set ib_itemName[92] = "æœºæªå­å¼¹ (30 å‘) x 4"
    set ib_itemCustom[92] = 1
    set ib_itemNameGbk[92] = "»úÇ¹×Óµ¯ (30 ·¢) x 4"
    set ib_itemList[93] = 'I01J'
    set ib_itemName[93] = "æ•£å¼¹æª å­å¼¹ (2 å‘)x 4"
    set ib_itemCustom[93] = 1
    set ib_itemNameGbk[93] = "É¢µ¯Ç¹ ×Óµ¯ (2 ·¢)x 4"
    set ib_itemList[94] = 'I01K'
    set ib_itemName[94] = "å…³é—­ åŒé‡ç«ç„°å–·å°„å™¨"
    set ib_itemCustom[94] = 1
    set ib_itemNameGbk[94] = "¹Ø±Õ Ë«ÖØ»ğÑæÅçÉäÆ÷"
    set ib_itemList[95] = 'I01L'
    set ib_itemName[95] = "å¯åŠ¨ åŒé‡ç«ç„°å–·å°„å™¨"
    set ib_itemCustom[95] = 1
    set ib_itemNameGbk[95] = "Æô¶¯ Ë«ÖØ»ğÑæÅçÉäÆ÷"
    set ib_itemList[96] = 'I01M'
    set ib_itemName[96] = "å…³é—­ ä¸­å‹å¾ªç¯æ¿€å…‰"
    set ib_itemCustom[96] = 1
    set ib_itemNameGbk[96] = "¹Ø±Õ ÖĞĞÍÑ­»·¼¤¹â"
    set ib_itemList[97] = 'I01N'
    set ib_itemName[97] = "å¯åŠ¨ ä¸­å‹å¾ªç¯æ¿€å…‰"
    set ib_itemCustom[97] = 1
    set ib_itemNameGbk[97] = "Æô¶¯ ÖĞĞÍÑ­»·¼¤¹â"
    set ib_itemList[98] = 'I01O'
    set ib_itemName[98] = "å…³é—­ å¤šç®¡ç«ç®­å‘å°„å™¨"
    set ib_itemCustom[98] = 1
    set ib_itemNameGbk[98] = "¹Ø±Õ ¶à¹Ü»ğ¼ı·¢ÉäÆ÷"
    set ib_itemList[99] = 'I01P'
    set ib_itemName[99] = "å¯åŠ¨ å¤šç®¡ç«ç®­å‘å°„å™¨"
    set ib_itemCustom[99] = 1
    set ib_itemNameGbk[99] = "Æô¶¯ ¶à¹Ü»ğ¼ı·¢ÉäÆ÷"
    set ib_itemList[100] = 'I01Q'
    set ib_itemName[100] = "é¥æ§é™†æˆ˜è½¦"
    set ib_itemCustom[100] = 1
    set ib_itemNameGbk[100] = "Ò£¿ØÂ½Õ½³µ"
    set ib_itemList[101] = 'I01R'
    set ib_itemName[101] = "å¯ä¹"
    set ib_itemCustom[101] = 1
    set ib_itemNameGbk[101] = "¿ÉÀÖ"
    set ib_itemList[102] = 'I01S'
    set ib_itemName[102] = "æ•å…½ç½‘"
    set ib_itemCustom[102] = 1
    set ib_itemNameGbk[102] = "²¶ÊŞÍø"
    set ib_itemList[103] = 'I01T'
    set ib_itemName[103] = "æ³¡æ³¡æª + è£…æ»¡æ³¡æ²«æ°´çš„ç“¶å­ (ç¨€æœ‰)"
    set ib_itemCustom[103] = 1
    set ib_itemNameGbk[103] = "ÅİÅİÇ¹ + ×°ÂúÅİÄ­Ë®µÄÆ¿×Ó (Ï¡ÓĞ)"
    set ib_itemList[104] = 'I01U'
    set ib_itemName[104] = "æœºæ¢°ç ”ç©¶ç¬”è®°"
    set ib_itemCustom[104] = 1
    set ib_itemNameGbk[104] = "»úĞµÑĞ¾¿±Ê¼Ç"
    set ib_itemList[105] = 'I01V'
    set ib_itemName[105] = "çªå‡»æœºæª"
    set ib_itemCustom[105] = 1
    set ib_itemNameGbk[105] = "Í»»÷»úÇ¹"
    set ib_itemList[106] = 'I01W'
    set ib_itemName[106] = "çªå‡»æœºæªå­å¼¹ (50 å‘)"
    set ib_itemCustom[106] = 1
    set ib_itemNameGbk[106] = "Í»»÷»úÇ¹×Óµ¯ (50 ·¢)"
    set ib_itemList[107] = 'I01X'
    set ib_itemName[107] = "gps"
    set ib_itemCustom[107] = 1
    set ib_itemNameGbk[107] = "gps"
    set ib_itemList[108] = 'I01Y'
    set ib_itemName[108] = "heartbeatsensor"
    set ib_itemCustom[108] = 1
    set ib_itemNameGbk[108] = "heartbeatsensor"
    set ib_itemList[109] = 'I01Z'
    set ib_itemName[109] = "å¤§æ°´å¼¹"
    set ib_itemCustom[109] = 1
    set ib_itemNameGbk[109] = "´óË®µ¯"
    set ib_itemList[110] = 'I020'
    set ib_itemName[110] = "å¤§åŒ…å½©çƒ"
    set ib_itemCustom[110] = 1
    set ib_itemNameGbk[110] = "´ó°ü²ÊÇò"
    set ib_itemList[111] = 'I021'
    set ib_itemName[111] = "é¥æ§é™†æˆ˜è½¦"
    set ib_itemCustom[111] = 1
    set ib_itemNameGbk[111] = "Ò£¿ØÂ½Õ½³µ"
    set ib_itemList[112] = 'I022'
    set ib_itemName[112] = "é™æ§å‰æ™®è»Š"
    set ib_itemCustom[112] = 1
    set ib_itemNameGbk[112] = "ßb¿Ø¼ªÆÕÜ‡"
    set ib_itemList[113] = 'I023'
    set ib_itemName[113] = "é™æ§å†›é™†æˆ˜è½¦"
    set ib_itemCustom[113] = 1
    set ib_itemNameGbk[113] = "ßb¿Ø¾üÂ½Õ½³µ"
    set ib_itemList[114] = 'I024'
    set ib_itemName[114] = "é™æ§é™†å†›å‰æ™®è½¦"
    set ib_itemCustom[114] = 1
    set ib_itemNameGbk[114] = "ßb¿ØÂ½¾ü¼ªÆÕ³µ"
    set ib_itemList[115] = 'I025'
    set ib_itemName[115] = "æ€¥æ•‘åŒ…"
    set ib_itemCustom[115] = 1
    set ib_itemNameGbk[115] = "¼±¾È°ü"
    set ib_itemList[116] = 'I026'
    set ib_itemName[116] = "å°æé¾™è›‹"
    set ib_itemCustom[116] = 1
    set ib_itemNameGbk[116] = "Ğ¡¿ÖÁúµ°"
    set ib_itemList[117] = 'I027'
    set ib_itemName[117] = "å¤§æé¾™è›‹"
    set ib_itemCustom[117] = 1
    set ib_itemNameGbk[117] = "´ó¿ÖÁúµ°"
    set ib_itemList[118] = 'I028'
    set ib_itemName[118] = "ç‰©ç†ç ”ç©¶ç¬”è®°"
    set ib_itemCustom[118] = 1
    set ib_itemNameGbk[118] = "ÎïÀíÑĞ¾¿±Ê¼Ç"
    set ib_itemList[119] = 'I029'
    set ib_itemName[119] = "åˆºèŠ±è‰"
    set ib_itemCustom[119] = 1
    set ib_itemNameGbk[119] = "´Ì»¨²İ"
    set ib_itemList[120] = 'I02B'
    set ib_itemName[120] = "ä½“åŠ›æœå®"
    set ib_itemCustom[120] = 1
    set ib_itemNameGbk[120] = "ÌåÁ¦¹ûÊµ"
    set ib_itemList[121] = 'I02A'
    set ib_itemName[121] = "äººå·¥å¡”å›¾çº¸"
    set ib_itemCustom[121] = 1
    set ib_itemNameGbk[121] = "ÈË¹¤ËşÍ¼Ö½"
    set ib_itemList[122] = 'I02C'
    set ib_itemName[122] = "åŠ›é‡+1"
    set ib_itemCustom[122] = 1
    set ib_itemNameGbk[122] = "Á¦Á¿+1"
    set ib_itemList[123] = 'I02D'
    set ib_itemName[123] = "æœºç”²å›¾çº¸"
    set ib_itemCustom[123] = 1
    set ib_itemNameGbk[123] = "»ú¼×Í¼Ö½"
    set ib_itemList[124] = 'I02E'
    set ib_itemName[124] = "é“å‰‘"
    set ib_itemCustom[124] = 1
    set ib_itemNameGbk[124] = "Ìú½£"
    set ib_itemList[125] = 'I02F'
    set ib_itemName[125] = "çˆªå­"
    set ib_itemCustom[125] = 1
    set ib_itemNameGbk[125] = "×¦×Ó"
    set ib_itemList[126] = 'I02G'
    set ib_itemName[126] = "æ€é¾™å‰‘lv1"
    set ib_itemCustom[126] = 1
    set ib_itemNameGbk[126] = "É±Áú½£lv1"
    set ib_itemList[127] = 'I02H'
    set ib_itemName[127] = "æ€é¾™å‰‘lv2"
    set ib_itemCustom[127] = 1
    set ib_itemNameGbk[127] = "É±Áú½£lv2"
    set ib_itemList[128] = 'I02I'
    set ib_itemName[128] = "æ€é¾™å‰‘lv3"
    set ib_itemCustom[128] = 1
    set ib_itemNameGbk[128] = "É±Áú½£lv3"
    set ib_itemList[129] = 'I02J'
    set ib_itemName[129] = "æ€é¾™å‰‘lv4"
    set ib_itemCustom[129] = 1
    set ib_itemNameGbk[129] = "É±Áú½£lv4"
    set ib_itemList[130] = 'I02K'
    set ib_itemName[130] = "æ€é¾™å‰‘lv5"
    set ib_itemCustom[130] = 1
    set ib_itemNameGbk[130] = "É±Áú½£lv5"
    set ib_itemList[131] = 'I02L'
    set ib_itemName[131] = "æ€é¾™å‰‘lv7"
    set ib_itemCustom[131] = 1
    set ib_itemNameGbk[131] = "É±Áú½£lv7"
    set ib_itemList[132] = 'I02M'
    set ib_itemName[132] = "æ€é¾™å‰‘lv6"
    set ib_itemCustom[132] = 1
    set ib_itemNameGbk[132] = "É±Áú½£lv6"
    set ib_itemList[133] = 'I02N'
    set ib_itemName[133] = "æ€é¾™å‰‘lv9"
    set ib_itemCustom[133] = 1
    set ib_itemNameGbk[133] = "É±Áú½£lv9"
    set ib_itemList[134] = 'I02O'
    set ib_itemName[134] = "æ€é¾™å‰‘lv8"
    set ib_itemCustom[134] = 1
    set ib_itemNameGbk[134] = "É±Áú½£lv8"
    set ib_itemList[135] = 'I02P'
    set ib_itemName[135] = "æ€é¾™å‰‘lv10"
    set ib_itemCustom[135] = 1
    set ib_itemNameGbk[135] = "É±Áú½£lv10"
    set ib_itemList[136] = 'I02R'
    set ib_itemName[136] = "é¾™è¡€"
    set ib_itemCustom[136] = 1
    set ib_itemNameGbk[136] = "ÁúÑª"
    set ib_itemList[137] = 'I02V'
    set ib_itemName[137] = "å‡çº§æ­¦å™¨"
    set ib_itemCustom[137] = 1
    set ib_itemNameGbk[137] = "Éı¼¶ÎäÆ÷"
    set ib_itemList[138] = 'I02U'
    set ib_itemName[138] = "åˆæˆ-äººå·¥å¡”å›¾çº¸"
    set ib_itemCustom[138] = 1
    set ib_itemNameGbk[138] = "ºÏ³É-ÈË¹¤ËşÍ¼Ö½"
    set ib_itemList[139] = 'I02S'
    set ib_itemName[139] = "åˆæˆ-æœºç”²å›¾çº¸"
    set ib_itemCustom[139] = 1
    set ib_itemNameGbk[139] = "ºÏ³É-»ú¼×Í¼Ö½"
    set ib_itemList[140] = 'I02T'
    set ib_itemName[140] = "æ­¦å™¨åˆæˆ"
    set ib_itemCustom[140] = 1
    set ib_itemNameGbk[140] = "ÎäÆ÷ºÏ³É"
    set ib_itemList[141] = 'I02Q'
    set ib_itemName[141] = "å¤§æ°”æ¯é¦™æ°´"
    set ib_itemCustom[141] = 1
    set ib_itemNameGbk[141] = "´óÆøÏ¢ÏãË®"
    set ib_itemList[142] = 'I02W'
    set ib_itemName[142] = "æ€é¾™å‰‘lvmaxï¼ˆæˆé•¿ï¼‰"
    set ib_itemCustom[142] = 1
    set ib_itemNameGbk[142] = "É±Áú½£lvmax£¨³É³¤£©"
    set ib_itemList[143] = 'I02X'
    set ib_itemName[143] = "é¾™ç”²"
    set ib_itemCustom[143] = 1
    set ib_itemNameGbk[143] = "Áú¼×"
    set ib_itemList[144] = 'I02Y'
    set ib_itemName[144] = "å¸ƒç”²"
    set ib_itemCustom[144] = 1
    set ib_itemNameGbk[144] = "²¼¼×"
    set ib_itemList[145] = 'I02Z'
    set ib_itemName[145] = "é€ƒè„±åŒ•é¦–"
    set ib_itemCustom[145] = 1
    set ib_itemNameGbk[145] = "ÌÓÍÑØ°Ê×"
    set ib_itemList[146] = 'I030'
    set ib_itemName[146] = "ä¸“å±é¾™ç”²ï¼ˆå¤§ä½¬æˆ˜ç”²ï¼‰"
    set ib_itemCustom[146] = 1
    set ib_itemNameGbk[146] = "×¨ÊôÁú¼×£¨´óÀĞÕ½¼×£©"
    set ib_itemList[147] = 'I032'
    set ib_itemName[147] = "æ€é¾™å‰‘lvmaxï¼ˆç”·çˆµï¼‰"
    set ib_itemCustom[147] = 1
    set ib_itemNameGbk[147] = "É±Áú½£lvmax£¨ÄĞ¾ô£©"
    set ib_itemList[148] = 'I033'
    set ib_itemName[148] = "ä¸“å±é¾™ç”²ï¼ˆç”·çˆµï¼‰"
    set ib_itemCustom[148] = 1
    set ib_itemNameGbk[148] = "×¨ÊôÁú¼×£¨ÄĞ¾ô£©"
    set ib_itemList[149] = 'I034'
    set ib_itemName[149] = "|cffffff00æ•Œå¯¹æˆ˜ä¹¦"
    set ib_itemCustom[149] = 1
    set ib_itemNameGbk[149] = "|cffffff00µĞ¶ÔÕ½Êé"
    set ib_itemList[150] = 'I035'
    set ib_itemName[150] = "|cffffff00åœæˆ˜åè®®ä¹¦"
    set ib_itemCustom[150] = 1
    set ib_itemNameGbk[150] = "|cffffff00Í£Õ½Ğ­ÒéÊé"
    set ib_itemList[151] = 'I036'
    set ib_itemName[151] = "å¤ä»‡ä¹‹é­‚"
    set ib_itemCustom[151] = 1
    set ib_itemNameGbk[151] = "¸´³ğÖ®»ê"
    set ib_itemList[152] = 'I037'
    set ib_itemName[152] = "è¡£æœåˆæˆ"
    set ib_itemCustom[152] = 1
    set ib_itemNameGbk[152] = "ÒÂ·şºÏ³É"
    set ib_itemList[153] = 'I038'
    set ib_itemName[153] = "ä¼˜è´¨é¾™ç”²"
    set ib_itemCustom[153] = 1
    set ib_itemNameGbk[153] = "ÓÅÖÊÁú¼×"
    set ib_itemList[154] = 'I039'
    set ib_itemName[154] = "çœŸé¾™ç”²"
    set ib_itemCustom[154] = 1
    set ib_itemNameGbk[154] = "ÕæÁú¼×"
    set ib_itemList[155] = 'I03A'
    set ib_itemName[155] = "å°åŠ é€Ÿæ‰‹å¥—"
    set ib_itemCustom[155] = 1
    set ib_itemNameGbk[155] = "Ğ¡¼ÓËÙÊÖÌ×"
    set ib_itemList[156] = 'I03B'
    set ib_itemName[156] = "å¤§åŠ é€Ÿæ‰‹å¥—"
    set ib_itemCustom[156] = 1
    set ib_itemNameGbk[156] = "´ó¼ÓËÙÊÖÌ×"
    set ib_itemList[157] = 'I03C'
    set ib_itemName[157] = "æ€é¾™å‰‘lvmax(åˆæˆ)"
    set ib_itemCustom[157] = 1
    set ib_itemNameGbk[157] = "É±Áú½£lvmax(ºÏ³É)"
    set ib_itemList[158] = 'I03D'
    set ib_itemName[158] = "ç©å®¶è£èª‰å‹‹ç« "
    set ib_itemCustom[158] = 1
    set ib_itemNameGbk[158] = "Íæ¼ÒÈÙÓşÑ«ÕÂ"
    set ib_itemList[159] = 'I03E'
    set ib_itemName[159] = "ç©å®¶è£èª‰å‹‹ç« "
    set ib_itemCustom[159] = 1
    set ib_itemNameGbk[159] = "Íæ¼ÒÈÙÓşÑ«ÕÂ"
endfunction
function IB_Fill2 takes nothing returns nothing
    set ib_itemList[160] = 'I03F'
    set ib_itemName[160] = "ç©å®¶è£èª‰å‹‹ç« "
    set ib_itemCustom[160] = 1
    set ib_itemNameGbk[160] = "Íæ¼ÒÈÙÓşÑ«ÕÂ"
    set ib_itemList[161] = 'I03G'
    set ib_itemName[161] = "ç©å®¶è£èª‰å‹‹ç« "
    set ib_itemCustom[161] = 1
    set ib_itemNameGbk[161] = "Íæ¼ÒÈÙÓşÑ«ÕÂ"
    set ib_itemList[162] = 'I03H'
    set ib_itemName[162] = "ç©å®¶è£èª‰å‹‹ç« "
    set ib_itemCustom[162] = 1
    set ib_itemNameGbk[162] = "Íæ¼ÒÈÙÓşÑ«ÕÂ"
    set ib_itemList[163] = 'I03I'
    set ib_itemName[163] = "ã€ç”·çˆµä¸“å±å‹‹ç« ã€‘"
    set ib_itemCustom[163] = 1
    set ib_itemNameGbk[163] = "¡¾ÄĞ¾ô×¨ÊôÑ«ÕÂ¡¿"
    set ib_itemList[164] = 'I03M'
    set ib_itemName[164] = "å¤§ä½¬è£èª‰å‹‹ç« "
    set ib_itemCustom[164] = 1
    set ib_itemNameGbk[164] = "´óÀĞÈÙÓşÑ«ÕÂ"
    set ib_itemList[165] = 'I03J'
    set ib_itemName[165] = "å¤§ä½¬è£èª‰å‹‹ç« "
    set ib_itemCustom[165] = 1
    set ib_itemNameGbk[165] = "´óÀĞÈÙÓşÑ«ÕÂ"
    set ib_itemList[166] = 'I03K'
    set ib_itemName[166] = "å¤§ä½¬è£èª‰å‹‹ç« "
    set ib_itemCustom[166] = 1
    set ib_itemNameGbk[166] = "´óÀĞÈÙÓşÑ«ÕÂ"
    set ib_itemList[167] = 'I03L'
    set ib_itemName[167] = "å¤§ä½¬è£èª‰å‹‹ç« "
    set ib_itemCustom[167] = 1
    set ib_itemNameGbk[167] = "´óÀĞÈÙÓşÑ«ÕÂ"
    set ib_itemList[168] = 'I03N'
    set ib_itemName[168] = "å¤§ä½¬è£èª‰å‹‹ç« "
    set ib_itemCustom[168] = 1
    set ib_itemNameGbk[168] = "´óÀĞÈÙÓşÑ«ÕÂ"
    set ib_itemList[169] = 'I03O'
    set ib_itemName[169] = "å¤§ä½¬è£èª‰å‹‹ç« "
    set ib_itemCustom[169] = 1
    set ib_itemNameGbk[169] = "´óÀĞÈÙÓşÑ«ÕÂ"
    set ib_itemList[170] = 'I03P'
    set ib_itemName[170] = "ç¥ç§˜é™¨çŸ³"
    set ib_itemCustom[170] = 1
    set ib_itemNameGbk[170] = "ÉñÃØÔÉÊ¯"
    set ib_itemList[171] = 'I03Q'
    set ib_itemName[171] = "å¤§æœ¨æå †"
    set ib_itemCustom[171] = 1
    set ib_itemNameGbk[171] = "´óÄ¾²Ä¶Ñ"
    set ib_itemList[172] = 'I03R'
    set ib_itemName[172] = "æŒ‘è¡…å·è§’"
    set ib_itemCustom[172] = 1
    set ib_itemNameGbk[172] = "ÌôĞÆºÅ½Ç"
    set ib_itemList[173] = 'I03S'
    set ib_itemName[173] = "æ€é¾™å‰‘lvmaxï¼ˆè¡€é¥®ï¼‰"
    set ib_itemCustom[173] = 1
    set ib_itemNameGbk[173] = "É±Áú½£lvmax£¨ÑªÒû£©"
    set ib_itemList[174] = 'I03T'
    set ib_itemName[174] = "è¿˜é­‚è‰"
    set ib_itemCustom[174] = 1
    set ib_itemNameGbk[174] = "»¹»ê²İ"
    set ib_itemList[175] = 'I03U'
    set ib_itemName[175] = "è§‰é†’è‰.."
    set ib_itemCustom[175] = 1
    set ib_itemNameGbk[175] = "¾õĞÑ²İ.."
    set ib_itemList[176] = 'I03V'
    set ib_itemName[176] = "å¤§ä½¬è£èª‰å‹‹ç« "
    set ib_itemCustom[176] = 1
    set ib_itemNameGbk[176] = "´óÀĞÈÙÓşÑ«ÕÂ"
    set ib_itemList[177] = 'I03W'
    set ib_itemName[177] = "ç©å®¶è£èª‰å‹‹ç« "
    set ib_itemCustom[177] = 1
    set ib_itemNameGbk[177] = "Íæ¼ÒÈÙÓşÑ«ÕÂ"
    set ib_itemList[178] = 'I03X'
    set ib_itemName[178] = "ç‡ƒçƒ§å¼¹"
    set ib_itemCustom[178] = 1
    set ib_itemNameGbk[178] = "È¼ÉÕµ¯"
    set ib_itemList[179] = 'I03Y'
    set ib_itemName[179] = "çœŸé¾™æˆ˜ç”²ï¼ˆå¤©å­ï¼‰"
    set ib_itemCustom[179] = 1
    set ib_itemNameGbk[179] = "ÕæÁúÕ½¼×£¨Ìì×Ó£©"
    set ib_itemList[180] = 'I03Z'
    set ib_itemName[180] = "gpså«æ˜Ÿé¥æ§å™¨ï¼ˆæ™®é€šï¼‰"
    set ib_itemCustom[180] = 1
    set ib_itemNameGbk[180] = "gpsÎÀĞÇÒ£¿ØÆ÷£¨ÆÕÍ¨£©"
    set ib_itemList[181] = 'I040'
    set ib_itemName[181] = "ç©å®¶è£èª‰å‹‹ç« "
    set ib_itemCustom[181] = 1
    set ib_itemNameGbk[181] = "Íæ¼ÒÈÙÓşÑ«ÕÂ"
    set ib_itemList[182] = 'I041'
    set ib_itemName[182] = "æˆå¹´ç¿¼é¾™[åéª‘è›‹]"
    set ib_itemCustom[182] = 1
    set ib_itemNameGbk[182] = "³ÉÄêÒíÁú[×øÆïµ°]"
    set ib_itemList[183] = 'I042'
    set ib_itemName[183] = "æˆå¹´æ¯’é¾™[åéª‘è›‹]"
    set ib_itemCustom[183] = 1
    set ib_itemNameGbk[183] = "³ÉÄê¶¾Áú[×øÆïµ°]"
    set ib_itemList[184] = 'I043'
    set ib_itemName[184] = "æˆå¹´ä¸‰è§’é¾™[åéª‘è›‹]"
    set ib_itemCustom[184] = 1
    set ib_itemNameGbk[184] = "³ÉÄêÈı½ÇÁú[×øÆïµ°]"
    set ib_itemList[185] = 'I044'
    set ib_itemName[185] = "ä¼Šå¡æ´›æ–¯ã®å‰‘"
    set ib_itemCustom[185] = 1
    set ib_itemNameGbk[185] = "ÒÁ¿¨ÂåË¹¤Î½£"
    set ib_itemList[186] = 'I045'
    set ib_itemName[186] = "å°éœ¸ç‹é¾™[åéª‘è›‹]"
    set ib_itemCustom[186] = 1
    set ib_itemNameGbk[186] = "Ğ¡°ÔÍõÁú[×øÆïµ°]"
    set ib_itemList[187] = 'I046'
    set ib_itemName[187] = "ç§‘å‹’æ©çš„é€ƒè„±åŒ•é¦–"
    set ib_itemCustom[187] = 1
    set ib_itemNameGbk[187] = "¿ÆÀÕ¶÷µÄÌÓÍÑØ°Ê×"
    set ib_itemList[188] = 'I047'
    set ib_itemName[188] = "ç»ç¼˜æ”»é€Ÿæ‰‹å¥—"
    set ib_itemCustom[188] = 1
    set ib_itemNameGbk[188] = "¾øÔµ¹¥ËÙÊÖÌ×"
    set ib_itemList[189] = 'I048'
    set ib_itemName[189] = "è±¹é€Ÿä¹‹é´"
    set ib_itemCustom[189] = 1
    set ib_itemNameGbk[189] = "±ªËÙÖ®Ñ¥"
    set ib_itemList[190] = 'I049'
    set ib_itemName[190] = "åƒæ‰‹ç²¾çµæ‰‹å¥—"
    set ib_itemCustom[190] = 1
    set ib_itemNameGbk[190] = "Ç§ÊÖ¾«ÁéÊÖÌ×"
    set ib_itemList[191] = 'I04A'
    set ib_itemName[191] = "é€Ÿåº¦æ‰‹å¥—"
    set ib_itemCustom[191] = 1
    set ib_itemNameGbk[191] = "ËÙ¶ÈÊÖÌ×"
    set ib_itemList[192] = 'I04B'
    set ib_itemName[192] = "æ— å½±æ‰‹ç²¾çµæ‰‹å¥—"
    set ib_itemCustom[192] = 1
    set ib_itemNameGbk[192] = "ÎŞÓ°ÊÖ¾«ÁéÊÖÌ×"
    set ib_itemList[193] = 'I04C'
    set ib_itemName[193] = "æ— å½±é¡¹é“¾"
    set ib_itemCustom[193] = 1
    set ib_itemNameGbk[193] = "ÎŞÓ°ÏîÁ´"
    set ib_itemList[194] = 'I04D'
    set ib_itemName[194] = "é¹°é€Ÿä¹‹é´"
    set ib_itemCustom[194] = 1
    set ib_itemNameGbk[194] = "Ó¥ËÙÖ®Ñ¥"
    set ib_itemList[195] = 'I04E'
    set ib_itemName[195] = "å½±å­é¡¹é“¾"
    set ib_itemCustom[195] = 1
    set ib_itemNameGbk[195] = "Ó°×ÓÏîÁ´"
    set ib_itemList[196] = 'I04F'
    set ib_itemName[196] = "åŠ é€Ÿæ‰‹å¥—"
    set ib_itemCustom[196] = 1
    set ib_itemNameGbk[196] = "¼ÓËÙÊÖÌ×"
    set ib_itemList[197] = 'I04G'
    set ib_itemName[197] = "é—ªé¿é¡¹é“¾"
    set ib_itemCustom[197] = 1
    set ib_itemNameGbk[197] = "ÉÁ±ÜÏîÁ´"
    set ib_itemList[198] = 'I04H'
    set ib_itemName[198] = "æ‰‹å¥—å‡çº§"
    set ib_itemCustom[198] = 1
    set ib_itemNameGbk[198] = "ÊÖÌ×Éı¼¶"
    set ib_itemList[199] = 'I04I'
    set ib_itemName[199] = "é€Ÿåº¦ä¹‹é´"
    set ib_itemCustom[199] = 1
    set ib_itemNameGbk[199] = "ËÙ¶ÈÖ®Ñ¥"
    set ib_itemList[200] = 'I04J'
    set ib_itemName[200] = "é¡¹é“¾å‡çº§"
    set ib_itemCustom[200] = 1
    set ib_itemNameGbk[200] = "ÏîÁ´Éı¼¶"
    set ib_itemList[201] = 'I04K'
    set ib_itemName[201] = "é´å­å‡çº§"
    set ib_itemCustom[201] = 1
    set ib_itemNameGbk[201] = "Ñ¥×ÓÉı¼¶"
    set ib_itemList[202] = 'I04L'
    set ib_itemName[202] = "å¤§é‡‘å¸"
    set ib_itemCustom[202] = 1
    set ib_itemNameGbk[202] = "´ó½ğ±Ò"
    set ib_itemList[203] = 'I04M'
    set ib_itemName[203] = "å¤§é‡‘å¸"
    set ib_itemCustom[203] = 1
    set ib_itemNameGbk[203] = "´ó½ğ±Ò"
    set ib_itemList[204] = 'I04N'
    set ib_itemName[204] = "ç»éªŒä¹‹ä¹¦"
    set ib_itemCustom[204] = 1
    set ib_itemNameGbk[204] = "¾­ÑéÖ®Êé"
    set ib_itemList[205] = 'I04O'
    set ib_itemName[205] = "åŠ›é‡ä¹‹ä¹¦ +10"
    set ib_itemCustom[205] = 1
    set ib_itemNameGbk[205] = "Á¦Á¿Ö®Êé +10"
    set ib_itemList[206] = 'I04P'
    set ib_itemName[206] = "å¤§é­”æ³•è¯æ°´"
    set ib_itemCustom[206] = 1
    set ib_itemNameGbk[206] = "´óÄ§·¨Ò©Ë®"
    set ib_itemList[207] = 'I04Q'
    set ib_itemName[207] = "å¤§ç”Ÿå‘½è¯æ°´"
    set ib_itemCustom[207] = 1
    set ib_itemNameGbk[207] = "´óÉúÃüÒ©Ë®"
    set ib_itemList[208] = 'I04R'
    set ib_itemName[208] = "æŠ—ä½“è¯æ°´"
    set ib_itemCustom[208] = 1
    set ib_itemNameGbk[208] = "¿¹ÌåÒ©Ë®"
    set ib_itemList[209] = 'I04S'
    set ib_itemName[209] = "é­”æ³•è¯æ°´"
    set ib_itemCustom[209] = 1
    set ib_itemNameGbk[209] = "Ä§·¨Ò©Ë®"
    set ib_itemList[210] = 'I04T'
    set ib_itemName[210] = "ç”Ÿå‘½è¯æ°´"
    set ib_itemCustom[210] = 1
    set ib_itemNameGbk[210] = "ÉúÃüÒ©Ë®"
    set ib_itemList[211] = 'I04U'
    set ib_itemName[211] = "ä¸­é­”æ³•è¯æ°´(100)"
    set ib_itemCustom[211] = 1
    set ib_itemNameGbk[211] = "ÖĞÄ§·¨Ò©Ë®(100)"
    set ib_itemList[212] = 'I04V'
    set ib_itemName[212] = "ä¸­ç”Ÿå‘½è¯æ°´(100)"
    set ib_itemCustom[212] = 1
    set ib_itemNameGbk[212] = "ÖĞÉúÃüÒ©Ë®(100)"
    set ib_itemList[213] = 'I04W'
    set ib_itemName[213] = "é‡ç”Ÿåå­—ç« "
    set ib_itemCustom[213] = 1
    set ib_itemNameGbk[213] = "ÖØÉúÊ®×ÖÕÂ"
    set ib_itemList[214] = 'I04X'
    set ib_itemName[214] = "æš—å¤œç²¾çµå¼“"
    set ib_itemCustom[214] = 1
    set ib_itemNameGbk[214] = "°µÒ¹¾«Áé¹­"
    set ib_itemList[215] = 'I04Y'
    set ib_itemName[215] = "æš—å¤œç²¾çµè£…"
    set ib_itemCustom[215] = 1
    set ib_itemNameGbk[215] = "°µÒ¹¾«Áé×°"
    set ib_itemList[216] = 'I04Z'
    set ib_itemName[216] = "æš—å¤œå¥³ç¥ä¹‹å¼“r"
    set ib_itemCustom[216] = 1
    set ib_itemNameGbk[216] = "°µÒ¹Å®ÉñÖ®¹­r"
    set ib_itemList[217] = 'I050'
    set ib_itemName[217] = "é’¢å¼“"
    set ib_itemCustom[217] = 1
    set ib_itemNameGbk[217] = "¸Ö¹­"
    set ib_itemList[218] = 'I051'
    set ib_itemName[218] = "é‡‘å¼“"
    set ib_itemCustom[218] = 1
    set ib_itemNameGbk[218] = "½ğ¹­"
    set ib_itemList[219] = 'I052'
    set ib_itemName[219] = "ç²¾çµå¥³ç¥è£…"
    set ib_itemCustom[219] = 1
    set ib_itemNameGbk[219] = "¾«ÁéÅ®Éñ×°"
    set ib_itemList[220] = 'I053'
    set ib_itemName[220] = "ç²¾çµçš®è£…"
    set ib_itemCustom[220] = 1
    set ib_itemNameGbk[220] = "¾«ÁéÆ¤×°"
    set ib_itemList[221] = 'I054'
    set ib_itemName[221] = "ç²¾çµè£…"
    set ib_itemCustom[221] = 1
    set ib_itemNameGbk[221] = "¾«Áé×°"
    set ib_itemList[222] = 'I055'
    set ib_itemName[222] = "é“å¼“"
    set ib_itemCustom[222] = 1
    set ib_itemNameGbk[222] = "Ìú¹­"
    set ib_itemList[223] = 'I056'
    set ib_itemName[223] = "é“œå¼“"
    set ib_itemCustom[223] = 1
    set ib_itemNameGbk[223] = "Í­¹­"
    set ib_itemList[224] = 'I058'
    set ib_itemName[224] = "ç²¾çµè—¤è£…"
    set ib_itemCustom[224] = 1
    set ib_itemNameGbk[224] = "¾«ÁéÌÙ×°"
    set ib_itemList[225] = 'I059'
    set ib_itemName[225] = "æœ¨å¼“"
    set ib_itemCustom[225] = 1
    set ib_itemNameGbk[225] = "Ä¾¹­"
    set ib_itemList[226] = 'I05K'
    set ib_itemName[226] = "ç²¾çµå¥³ç¥çš„ææ€–å‡çº§"
    set ib_itemCustom[226] = 1
    set ib_itemNameGbk[226] = "¾«ÁéÅ®ÉñµÄ¿Ö²ÀÉı¼¶"
    set ib_itemList[227] = 'I05L'
    set ib_itemName[227] = "å†è®­ç»ƒä¹‹ä¹¦"
    set ib_itemCustom[227] = 1
    set ib_itemNameGbk[227] = "ÔÙÑµÁ·Ö®Êé"
    set ib_itemList[228] = 'I05M'
    set ib_itemName[228] = "å¼ºåŒ–åŸºåœ°"
    set ib_itemCustom[228] = 1
    set ib_itemNameGbk[228] = "Ç¿»¯»ùµØ"
    set ib_itemList[229] = 'I05N'
    set ib_itemName[229] = "é«˜çº§è£…å¤‡åˆæˆ"
    set ib_itemCustom[229] = 1
    set ib_itemNameGbk[229] = "¸ß¼¶×°±¸ºÏ³É"
    set ib_itemList[230] = 'I05O'
    set ib_itemName[230] = "é«˜çº§è£…å¤‡å‡çº§"
    set ib_itemCustom[230] = 1
    set ib_itemNameGbk[230] = "¸ß¼¶×°±¸Éı¼¶"
    set ib_itemList[231] = 'I05Q'
    set ib_itemName[231] = "ç²¾çµå¼“lv1"
    set ib_itemCustom[231] = 1
    set ib_itemNameGbk[231] = "¾«Áé¹­lv1"
    set ib_itemList[232] = 'I05R'
    set ib_itemName[232] = "ç²¾çµå¼“lv2"
    set ib_itemCustom[232] = 1
    set ib_itemNameGbk[232] = "¾«Áé¹­lv2"
    set ib_itemList[233] = 'I05S'
    set ib_itemName[233] = "ç²¾çµå¼“lv3"
    set ib_itemCustom[233] = 1
    set ib_itemNameGbk[233] = "¾«Áé¹­lv3"
    set ib_itemList[234] = 'I05T'
    set ib_itemName[234] = "ç²¾çµå¼“lv4"
    set ib_itemCustom[234] = 1
    set ib_itemNameGbk[234] = "¾«Áé¹­lv4"
    set ib_itemList[235] = 'I05U'
    set ib_itemName[235] = "ç²¾çµå¼“lv5"
    set ib_itemCustom[235] = 1
    set ib_itemNameGbk[235] = "¾«Áé¹­lv5"
    set ib_itemList[236] = 'I05V'
    set ib_itemName[236] = "ç²¾çµå¼“lv6max"
    set ib_itemCustom[236] = 1
    set ib_itemNameGbk[236] = "¾«Áé¹­lv6max"
    set ib_itemList[237] = 'I05W'
    set ib_itemName[237] = "é›·é¸£å‰‘lv1"
    set ib_itemCustom[237] = 1
    set ib_itemNameGbk[237] = "À×Ãù½£lv1"
    set ib_itemList[238] = 'I05X'
    set ib_itemName[238] = "é›·é¸£å‰‘lv2"
    set ib_itemCustom[238] = 1
    set ib_itemNameGbk[238] = "À×Ãù½£lv2"
    set ib_itemList[239] = 'I05Y'
    set ib_itemName[239] = "é›·é¸£å‰‘lv3"
    set ib_itemCustom[239] = 1
    set ib_itemNameGbk[239] = "À×Ãù½£lv3"
endfunction
function IB_Fill3 takes nothing returns nothing
    set ib_itemList[240] = 'I05Z'
    set ib_itemName[240] = "é›·é¸£å‰‘lv4"
    set ib_itemCustom[240] = 1
    set ib_itemNameGbk[240] = "À×Ãù½£lv4"
    set ib_itemList[241] = 'I060'
    set ib_itemName[241] = "é›·é¸£å‰‘lv5"
    set ib_itemCustom[241] = 1
    set ib_itemNameGbk[241] = "À×Ãù½£lv5"
    set ib_itemList[242] = 'I061'
    set ib_itemName[242] = "é›·é¸£å‰‘lvmax"
    set ib_itemCustom[242] = 1
    set ib_itemNameGbk[242] = "À×Ãù½£lvmax"
    set ib_itemList[243] = 'I062'
    set ib_itemName[243] = "çœŸé¾™ç”²ï¼ˆå¤©å­ï¼‰lv1"
    set ib_itemCustom[243] = 1
    set ib_itemNameGbk[243] = "ÕæÁú¼×£¨Ìì×Ó£©lv1"
    set ib_itemList[244] = 'I063'
    set ib_itemName[244] = "çœŸé¾™ç”²ï¼ˆå¤©å­ï¼‰lv2"
    set ib_itemCustom[244] = 1
    set ib_itemNameGbk[244] = "ÕæÁú¼×£¨Ìì×Ó£©lv2"
    set ib_itemList[245] = 'I064'
    set ib_itemName[245] = "çœŸé¾™ç”²ï¼ˆå¤©å­ï¼‰lv3"
    set ib_itemCustom[245] = 1
    set ib_itemNameGbk[245] = "ÕæÁú¼×£¨Ìì×Ó£©lv3"
    set ib_itemList[246] = 'I065'
    set ib_itemName[246] = "çœŸé¾™ç”²ï¼ˆå¤©å­ï¼‰lv4"
    set ib_itemCustom[246] = 1
    set ib_itemNameGbk[246] = "ÕæÁú¼×£¨Ìì×Ó£©lv4"
    set ib_itemList[247] = 'I066'
    set ib_itemName[247] = "çœŸé¾™ç”²ï¼ˆå¤©å­ï¼‰lv5"
    set ib_itemCustom[247] = 1
    set ib_itemNameGbk[247] = "ÕæÁú¼×£¨Ìì×Ó£©lv5"
    set ib_itemList[248] = 'I067'
    set ib_itemName[248] = "çœŸé¾™ç”²ï¼ˆå¤©å­ï¼‰lvmax"
    set ib_itemCustom[248] = 1
    set ib_itemNameGbk[248] = "ÕæÁú¼×£¨Ìì×Ó£©lvmax"
    set ib_itemList[249] = 'I057'
    set ib_itemName[249] = "æŠ«è¨ï¼ˆ100ï¼‰"
    set ib_itemCustom[249] = 1
    set ib_itemNameGbk[249] = "ÅûÈø£¨100£©"
    set ib_itemList[250] = 'I05A'
    set ib_itemName[250] = "å¯ä¹ï¼ˆ100ï¼‰"
    set ib_itemCustom[250] = 1
    set ib_itemNameGbk[250] = "¿ÉÀÖ£¨100£©"
    set ib_itemList[251] = 'I05B'
    set ib_itemName[251] = "å¿…æ€å¼¹lvmax"
    set ib_itemCustom[251] = 1
    set ib_itemNameGbk[251] = "±ØÉ±µ¯lvmax"
    set ib_itemList[252] = 'I05C'
    set ib_itemName[252] = "å¿…æ€å¼¹lv5"
    set ib_itemCustom[252] = 1
    set ib_itemNameGbk[252] = "±ØÉ±µ¯lv5"
    set ib_itemList[253] = 'I05D'
    set ib_itemName[253] = "å¿…æ€å¼¹lv4"
    set ib_itemCustom[253] = 1
    set ib_itemNameGbk[253] = "±ØÉ±µ¯lv4"
    set ib_itemList[254] = 'I05E'
    set ib_itemName[254] = "å¿…æ€å¼¹lv3"
    set ib_itemCustom[254] = 1
    set ib_itemNameGbk[254] = "±ØÉ±µ¯lv3"
    set ib_itemList[255] = 'I05F'
    set ib_itemName[255] = "å¿…æ€å¼¹lv2"
    set ib_itemCustom[255] = 1
    set ib_itemNameGbk[255] = "±ØÉ±µ¯lv2"
    set ib_itemList[256] = 'I05G'
    set ib_itemName[256] = "å¿…æ€å¼¹lv1"
    set ib_itemCustom[256] = 1
    set ib_itemNameGbk[256] = "±ØÉ±µ¯lv1"
    set ib_itemList[257] = 'I05H'
    set ib_itemName[257] = "ç«é­”æ–lv1"
    set ib_itemCustom[257] = 1
    set ib_itemNameGbk[257] = "»ğÄ§ÕÈlv1"
    set ib_itemList[258] = 'I05I'
    set ib_itemName[258] = "ç«é­”æ–lv2"
    set ib_itemCustom[258] = 1
    set ib_itemNameGbk[258] = "»ğÄ§ÕÈlv2"
    set ib_itemList[259] = 'I05J'
    set ib_itemName[259] = "ç«é­”æ–lv3"
    set ib_itemCustom[259] = 1
    set ib_itemNameGbk[259] = "»ğÄ§ÕÈlv3"
    set ib_itemList[260] = 'I05P'
    set ib_itemName[260] = "ç«é­”æ–lv4"
    set ib_itemCustom[260] = 1
    set ib_itemNameGbk[260] = "»ğÄ§ÕÈlv4"
    set ib_itemList[261] = 'I068'
    set ib_itemName[261] = "ç«é­”æ–lv5"
    set ib_itemCustom[261] = 1
    set ib_itemNameGbk[261] = "»ğÄ§ÕÈlv5"
    set ib_itemList[262] = 'I069'
    set ib_itemName[262] = "ç«é­”æ–lvmax"
    set ib_itemCustom[262] = 1
    set ib_itemNameGbk[262] = "»ğÄ§ÕÈlvmax"
    set ib_itemList[263] = 'I06A'
    set ib_itemName[263] = "æªå¼¹1å·"
    set ib_itemCustom[263] = 1
    set ib_itemNameGbk[263] = "Ç¹µ¯1ºÅ"
    set ib_itemList[264] = 'I06B'
    set ib_itemName[264] = "æªå¼¹10å·"
    set ib_itemCustom[264] = 1
    set ib_itemNameGbk[264] = "Ç¹µ¯10ºÅ"
    set ib_itemList[265] = 'I06C'
    set ib_itemName[265] = "æªå¼¹6å·"
    set ib_itemCustom[265] = 1
    set ib_itemNameGbk[265] = "Ç¹µ¯6ºÅ"
    set ib_itemList[266] = 'I06E'
    set ib_itemName[266] = "é›¨é­”æ–lv1"
    set ib_itemCustom[266] = 1
    set ib_itemNameGbk[266] = "ÓêÄ§ÕÈlv1"
    set ib_itemList[267] = 'I06D'
    set ib_itemName[267] = "é›¨é­”æ–lv2"
    set ib_itemCustom[267] = 1
    set ib_itemNameGbk[267] = "ÓêÄ§ÕÈlv2"
    set ib_itemList[268] = 'I06F'
    set ib_itemName[268] = "é›¨é­”æ–lv3"
    set ib_itemCustom[268] = 1
    set ib_itemNameGbk[268] = "ÓêÄ§ÕÈlv3"
    set ib_itemList[269] = 'I06G'
    set ib_itemName[269] = "ç«ç„°å–·å°„å™¨æ”¹è‰¯å‹"
    set ib_itemCustom[269] = 1
    set ib_itemNameGbk[269] = "»ğÑæÅçÉäÆ÷¸ÄÁ¼ĞÍ"
    set ib_itemList[270] = 'I06H'
    set ib_itemName[270] = "ç‰¹å¤§åŸæœ¨å †"
    set ib_itemCustom[270] = 1
    set ib_itemNameGbk[270] = "ÌØ´óÔ­Ä¾¶Ñ"
    set ib_itemList[271] = 'I06I'
    set ib_itemName[271] = "gmä¸“å±æ­¦å™¨"
    set ib_itemCustom[271] = 1
    set ib_itemNameGbk[271] = "gm×¨ÊôÎäÆ÷"
    set ib_itemList[272] = 'I06J'
    set ib_itemName[272] = "|cfffffc00gmä¸“å±æˆ˜ç”²"
    set ib_itemCustom[272] = 1
    set ib_itemNameGbk[272] = "|cfffffc00gm×¨ÊôÕ½¼×"
    set ib_itemList[273] = 'I06K'
    set ib_itemName[273] = "ã€é¾™å“¥ä¸“å±å‹‹ç« ã€‘"
    set ib_itemCustom[273] = 1
    set ib_itemNameGbk[273] = "¡¾Áú¸ç×¨ÊôÑ«ÕÂ¡¿"
    set ib_itemList[274] = 'I06L'
    set ib_itemName[274] = "ã€è€å¸æœºä¸“å±å‹‹ç« ã€‘"
    set ib_itemCustom[274] = 1
    set ib_itemNameGbk[274] = "¡¾ÀÏË¾»ú×¨ÊôÑ«ÕÂ¡¿"
    set ib_itemList[275] = 'I06M'
    set ib_itemName[275] = "ã€ä¸ƒå“¥ä¸“å±å‹‹ç« ã€‘"
    set ib_itemCustom[275] = 1
    set ib_itemNameGbk[275] = "¡¾Æß¸ç×¨ÊôÑ«ÕÂ¡¿"
    set ib_itemList[276] = 'I06N'
    set ib_itemName[276] = "æ²æµ´æ°´æª"
    set ib_itemCustom[276] = 1
    set ib_itemNameGbk[276] = "ãåÔ¡Ë®Ç¹"
    set ib_itemList[277] = 'I06O'
    set ib_itemName[277] = "å¤§æ°´å¼¹ï¼ˆå¤§åŒ…ï¼‰"
    set ib_itemCustom[277] = 1
    set ib_itemNameGbk[277] = "´óË®µ¯£¨´ó°ü£©"
    set ib_itemList[278] = 'I06P'
    set ib_itemName[278] = "æ°´å¼¹åˆæˆ"
    set ib_itemCustom[278] = 1
    set ib_itemNameGbk[278] = "Ë®µ¯ºÏ³É"
    set ib_itemList[279] = 'I06Q'
    set ib_itemName[279] = "æ”»å‡»ä¹‹ä¹¦"
    set ib_itemCustom[279] = 1
    set ib_itemNameGbk[279] = "¹¥»÷Ö®Êé"
    set ib_itemList[280] = 'I06U'
    set ib_itemName[280] = "|cff00db31è¯é…’"
    set ib_itemCustom[280] = 1
    set ib_itemNameGbk[280] = "|cff00db31Ò©¾Æ"
    set ib_itemList[281] = 'I06W'
    set ib_itemName[281] = "|cffff0000æµ‹è¯•è¯é…’"
    set ib_itemCustom[281] = 1
    set ib_itemNameGbk[281] = "|cffff0000²âÊÔÒ©¾Æ"
    set ib_itemList[282] = 'I06S'
    set ib_itemName[282] = "|cff00db31æœé…’"
    set ib_itemCustom[282] = 1
    set ib_itemNameGbk[282] = "|cff00db31¹û¾Æ"
    set ib_itemList[283] = 'I06T'
    set ib_itemName[283] = "çº¢åŒ…"
    set ib_itemCustom[283] = 1
    set ib_itemNameGbk[283] = "ºì°ü"
    set ib_itemList[284] = 'I06V'
    set ib_itemName[284] = "æ”»å‡»ä¹‹ä¹¦+100"
    set ib_itemCustom[284] = 1
    set ib_itemNameGbk[284] = "¹¥»÷Ö®Êé+100"
    set ib_itemList[285] = 'I06X'
    set ib_itemName[285] = "æ¯ç­è€…æœºç”²"
    set ib_itemCustom[285] = 1
    set ib_itemNameGbk[285] = "»ÙÃğÕß»ú¼×"
    set ib_itemList[286] = 'I06R'
    set ib_itemName[286] = "gpså«æ˜Ÿé¥æ§å™¨ï¼ˆé«˜çº§ï¼‰"
    set ib_itemCustom[286] = 1
    set ib_itemNameGbk[286] = "gpsÎÀĞÇÒ£¿ØÆ÷£¨¸ß¼¶£©"
    set ib_itemList[287] = 'I06Y'
    set ib_itemName[287] = "|cff00db31å…‘æ¢-gpså«æ˜Ÿé¥æ§å™¨ï¼ˆé«˜çº§ï¼‰"
    set ib_itemCustom[287] = 1
    set ib_itemNameGbk[287] = "|cff00db31¶Ò»»-gpsÎÀĞÇÒ£¿ØÆ÷£¨¸ß¼¶£©"
    set ib_itemList[288] = 'I06Z'
    set ib_itemName[288] = "|cff00db31å…‘æ¢-|cffff8000æœå®"
    set ib_itemCustom[288] = 1
    set ib_itemNameGbk[288] = "|cff00db31¶Ò»»-|cffff8000¹ûÊµ"
    set ib_itemList[289] = 'I070'
    set ib_itemName[289] = "|cffffff00å…‘æ¢-çº¢åŒ…|cffff00ffï¼ˆç‰¹æ®Šï¼‰"
    set ib_itemCustom[289] = 1
    set ib_itemNameGbk[289] = "|cffffff00¶Ò»»-ºì°ü|cffff00ff£¨ÌØÊâ£©"
    set ib_itemList[290] = 'I071'
    set ib_itemName[290] = "|cffffff00å…‘æ¢-æœºç”²å›¾çº¸|cffff00ffï¼ˆç‰¹æ®Šï¼‰"
    set ib_itemCustom[290] = 1
    set ib_itemNameGbk[290] = "|cffffff00¶Ò»»-»ú¼×Í¼Ö½|cffff00ff£¨ÌØÊâ£©"
    set ib_itemList[291] = 'I072'
    set ib_itemName[291] = "å…‘æ¢å¥—é¤ï¼ˆæœªå¼€æ”¾ï¼‰"
    set ib_itemCustom[291] = 1
    set ib_itemNameGbk[291] = "¶Ò»»Ì×²Í£¨Î´¿ª·Å£©"
    set ib_itemList[292] = 'I073'
    set ib_itemName[292] = "|cff00ff00æœºæ¢°ç‰¹å·¥"
    set ib_itemCustom[292] = 1
    set ib_itemNameGbk[292] = "|cff00ff00»úĞµÌØ¹¤"
    set ib_itemList[293] = 'I074'
    set ib_itemName[293] = "|cff00db31ç§˜åˆ¶è¯å‰‚1å·"
    set ib_itemCustom[293] = 1
    set ib_itemNameGbk[293] = "|cff00db31ÃØÖÆÒ©¼Á1ºÅ"
    set ib_itemList[294] = 'I075'
    set ib_itemName[294] = "|cffff8000å†²é”‹æˆ˜ç¥"
    set ib_itemCustom[294] = 1
    set ib_itemNameGbk[294] = "|cffff8000³å·æÕ½Éñ"
    set ib_itemList[295] = 'I076'
    set ib_itemName[295] = "å†²é”‹æˆ˜ç¥"
    set ib_itemCustom[295] = 1
    set ib_itemNameGbk[295] = "³å·æÕ½Éñ"
    set ib_itemList[296] = 'I077'
    set ib_itemName[296] = "|cff00db31ç§˜åˆ¶è¯å‰‚2å·"
    set ib_itemCustom[296] = 1
    set ib_itemNameGbk[296] = "|cff00db31ÃØÖÆÒ©¼Á2ºÅ"
    set ib_itemList[297] = 'I078'
    set ib_itemName[297] = "|cff00db31ç§˜åˆ¶è¯å‰‚3å·"
    set ib_itemCustom[297] = 1
    set ib_itemNameGbk[297] = "|cff00db31ÃØÖÆÒ©¼Á3ºÅ"
    set ib_itemList[298] = 'I079'
    set ib_itemName[298] = "|cff00db31ç§˜åˆ¶è¯å‰‚4å·"
    set ib_itemCustom[298] = 1
    set ib_itemNameGbk[298] = "|cff00db31ÃØÖÆÒ©¼Á4ºÅ"
    set ib_itemList[299] = 'I07A'
    set ib_itemName[299] = "|cff00db31ç§˜åˆ¶è¯å‰‚5å·"
    set ib_itemCustom[299] = 1
    set ib_itemNameGbk[299] = "|cff00db31ÃØÖÆÒ©¼Á5ºÅ"
    set ib_itemList[300] = 'I07B'
    set ib_itemName[300] = "|cff00db31ç§˜åˆ¶è¯å‰‚6å·"
    set ib_itemCustom[300] = 1
    set ib_itemNameGbk[300] = "|cff00db31ÃØÖÆÒ©¼Á6ºÅ"
    set ib_itemList[301] = 'I07C'
    set ib_itemName[301] = "|cff00db31ç§˜åˆ¶è¯å‰‚7å·"
    set ib_itemCustom[301] = 1
    set ib_itemNameGbk[301] = "|cff00db31ÃØÖÆÒ©¼Á7ºÅ"
    set ib_itemList[302] = 'I07D'
    set ib_itemName[302] = "|cffffff00å…‘æ¢-å¤ä»‡ä¹‹é­‚|cffff00ffï¼ˆç‰¹æ®Šï¼‰"
    set ib_itemCustom[302] = 1
    set ib_itemNameGbk[302] = "|cffffff00¶Ò»»-¸´³ğÖ®»ê|cffff00ff£¨ÌØÊâ£©"
    set ib_itemList[303] = 'I07E'
    set ib_itemName[303] = "|cffffff00å…‘æ¢-æœºæ¢°ç‰¹å·¥|cffff00ffï¼ˆç‰¹æ®Šï¼‰"
    set ib_itemCustom[303] = 1
    set ib_itemNameGbk[303] = "|cffffff00¶Ò»»-»úĞµÌØ¹¤|cffff00ff£¨ÌØÊâ£©"
    set ib_itemList[304] = 'I07F'
    set ib_itemName[304] = "|cffffff00å…‘æ¢-äººå·¥å¡”å›¾çº¸|cffff00ffï¼ˆç‰¹æ®Šï¼‰"
    set ib_itemCustom[304] = 1
    set ib_itemNameGbk[304] = "|cffffff00¶Ò»»-ÈË¹¤ËşÍ¼Ö½|cffff00ff£¨ÌØÊâ£©"
    set ib_itemList[305] = 'I07G'
    set ib_itemName[305] = "|cffffff00å›¢åœ†æœˆé¥¼"
    set ib_itemCustom[305] = 1
    set ib_itemNameGbk[305] = "|cffffff00ÍÅÔ²ÔÂ±ı"
    set ib_itemList[306] = 'I07H'
    set ib_itemName[306] = "|cff00db31æœé…’ï¼ˆ1ç®±ï¼‰"
    set ib_itemCustom[306] = 1
    set ib_itemNameGbk[306] = "|cff00db31¹û¾Æ£¨1Ïä£©"
    set ib_itemList[307] = 'I07I'
    set ib_itemName[307] = "gpsè®°å½•ä»ª"
    set ib_itemCustom[307] = 1
    set ib_itemNameGbk[307] = "gps¼ÇÂ¼ÒÇ"
    set ib_itemList[308] = 'I07J'
    set ib_itemName[308] = "|cffffff00å…‘æ¢-é€Ÿåº¦å¼ºåŒ–|cffff00ffï¼ˆç‰¹æ®Šï¼‰"
    set ib_itemCustom[308] = 1
    set ib_itemNameGbk[308] = "|cffffff00¶Ò»»-ËÙ¶ÈÇ¿»¯|cffff00ff£¨ÌØÊâ£©"
    set ib_itemList[309] = 'I07K'
    set ib_itemName[309] = "|cffffff00å…‘æ¢-ç¥ç§˜é™¨çŸ³|cffff00ffï¼ˆç‰¹æ®Šï¼‰"
    set ib_itemCustom[309] = 1
    set ib_itemNameGbk[309] = "|cffffff00¶Ò»»-ÉñÃØÔÉÊ¯|cffff00ff£¨ÌØÊâ£©"
    set ib_itemList[310] = 'I07L'
    set ib_itemName[310] = "|cffffff00çƒŸèŠ±"
    set ib_itemCustom[310] = 1
    set ib_itemNameGbk[310] = "|cffffff00ÑÌ»¨"
    set ib_itemList[311] = 'I07M'
    set ib_itemName[311] = "|cffffff00å…‘æ¢-çƒŸèŠ±|cffff00ffï¼ˆç‰¹æ®Šï¼‰"
    set ib_itemCustom[311] = 1
    set ib_itemNameGbk[311] = "|cffffff00¶Ò»»-ÑÌ»¨|cffff00ff£¨ÌØÊâ£©"
    set ib_itemList[312] = 'I07N'
    set ib_itemName[312] = "çƒŸèŠ±"
    set ib_itemCustom[312] = 1
    set ib_itemNameGbk[312] = "ÑÌ»¨"
    set ib_itemList[313] = 'I07O'
    set ib_itemName[313] = "æ‰‹ç”µç­’"
    set ib_itemCustom[313] = 1
    set ib_itemNameGbk[313] = "ÊÖµçÍ²"
    set ib_itemList[314] = 'I07P'
    set ib_itemName[314] = "|cff00db31æœé…’ï¼ˆ1ç®±ï¼‰"
    set ib_itemCustom[314] = 1
    set ib_itemNameGbk[314] = "|cff00db31¹û¾Æ£¨1Ïä£©"
    set ib_itemList[315] = 'I07Q'
    set ib_itemName[315] = "|cff00db31æœé…’"
    set ib_itemCustom[315] = 1
    set ib_itemNameGbk[315] = "|cff00db31¹û¾Æ"
    set ib_itemList[316] = 'I07R'
    set ib_itemName[316] = "æ°”æ¯é¦™æ°´"
    set ib_itemCustom[316] = 1
    set ib_itemNameGbk[316] = "ÆøÏ¢ÏãË®"
    set ib_itemList[317] = 'I07S'
    set ib_itemName[317] = "æ¯ç­è€…ç‹™å‡»ç‚®"
    set ib_itemCustom[317] = 1
    set ib_itemNameGbk[317] = "»ÙÃğÕß¾Ñ»÷ÅÚ"
    set ib_itemList[318] = 'I07T'
    set ib_itemName[318] = "é«˜çº§æ ¸å­ç«ç®­ç‚®"
    set ib_itemCustom[318] = 1
    set ib_itemNameGbk[318] = "¸ß¼¶ºË×Ó»ğ¼ıÅÚ"
    set ib_itemList[319] = 'I07U'
    set ib_itemName[319] = "æ ¸å¼¹å‘å°„å¡”"
    set ib_itemCustom[319] = 1
    set ib_itemNameGbk[319] = "ºËµ¯·¢ÉäËş"
endfunction
function IB_Fill4 takes nothing returns nothing
    set ib_itemList[320] = 'I07V'
    set ib_itemName[320] = "æ¯ç­è€…mg-36ç«ç®­ç‚®"
    set ib_itemCustom[320] = 1
    set ib_itemNameGbk[320] = "»ÙÃğÕßmg-36»ğ¼ıÅÚ"
    set ib_itemList[321] = 'I07W'
    set ib_itemName[321] = "è™é¾™[åéª‘è›‹]"
    set ib_itemCustom[321] = 1
    set ib_itemNameGbk[321] = "»¢Áú[×øÆïµ°]"
    set ib_itemList[322] = 'I07X'
    set ib_itemName[322] = "æ”»å‡»ä¹‹ä¹¦+50"
    set ib_itemCustom[322] = 1
    set ib_itemNameGbk[322] = "¹¥»÷Ö®Êé+50"
    set ib_itemList[323] = 'I07Y'
    set ib_itemName[323] = "çœŸé¾™ç”²ï¼ˆå¤©å­ï¼‰lvmax"
    set ib_itemCustom[323] = 1
    set ib_itemNameGbk[323] = "ÕæÁú¼×£¨Ìì×Ó£©lvmax"
    set ib_itemList[324] = 'I07Z'
    set ib_itemName[324] = "çˆªå­"
    set ib_itemCustom[324] = 1
    set ib_itemNameGbk[324] = "×¦×Ó"
    set ib_itemList[325] = 'I080'
    set ib_itemName[325] = "ç§¯åˆ†è½¬åŒ–æˆå°±"
    set ib_itemCustom[325] = 1
    set ib_itemNameGbk[325] = "»ı·Ö×ª»¯³É¾Í"
    set ib_itemList[326] = 'I081'
    set ib_itemName[326] = "æˆå°±è½¬åŒ–ç§¯åˆ†"
    set ib_itemCustom[326] = 1
    set ib_itemNameGbk[326] = "³É¾Í×ª»¯»ı·Ö"
    set ib_itemList[327] = 'I082'
    set ib_itemName[327] = "ä¸“å±æ­¦å™¨ï¼ˆå¤§ä½¬ä½©å‰‘ï¼‰"
    set ib_itemCustom[327] = 1
    set ib_itemNameGbk[327] = "×¨ÊôÎäÆ÷£¨´óÀĞÅå½££©"
    set ib_itemList[328] = 'I083'
    set ib_itemName[328] = "ã€ç©å®¶è£èª‰å‹‹ç« ã€‘"
    set ib_itemCustom[328] = 1
    set ib_itemNameGbk[328] = "¡¾Íæ¼ÒÈÙÓşÑ«ÕÂ¡¿"
    set ib_itemList[329] = 'I084'
    set ib_itemName[329] = "æŠ¤ç›¾"
    set ib_itemCustom[329] = 1
    set ib_itemNameGbk[329] = "»¤¶Ü"
    set ib_itemList[330] = 'I085'
    set ib_itemName[330] = "è¶…å¼ºæ€è™«å‰‚"
    set ib_itemCustom[330] = 1
    set ib_itemNameGbk[330] = "³¬Ç¿É±³æ¼Á"
    set ib_itemList[331] = 'I086'
    set ib_itemName[331] = "|cff00db31æˆ˜åŠ›ä¿®å¤è¯å‰‚1å·"
    set ib_itemCustom[331] = 1
    set ib_itemNameGbk[331] = "|cff00db31Õ½Á¦ĞŞ¸´Ò©¼Á1ºÅ"
    set ib_itemList[332] = 'I087'
    set ib_itemName[332] = "|cff00db31è§‰é†’è‰"
    set ib_itemCustom[332] = 1
    set ib_itemNameGbk[332] = "|cff00db31¾õĞÑ²İ"
    set ib_itemList[333] = 'I088'
    set ib_itemName[333] = "å†°å°å¼¹"
    set ib_itemCustom[333] = 1
    set ib_itemNameGbk[333] = "±ù·âµ¯"
    set ib_itemList[334] = 'I089'
    set ib_itemName[334] = "ç”µæŸå¼¹"
    set ib_itemCustom[334] = 1
    set ib_itemNameGbk[334] = "µçÊøµ¯"
    set ib_itemList[335] = 'I08A'
    set ib_itemName[335] = "æ¯’æ°”å¼¹"
    set ib_itemCustom[335] = 1
    set ib_itemNameGbk[335] = "¶¾Æøµ¯"
    set ib_itemList[336] = 'I08B'
    set ib_itemName[336] = "è…èš€å¼¹"
    set ib_itemCustom[336] = 1
    set ib_itemNameGbk[336] = "¸¯Ê´µ¯"
    set ib_itemList[337] = 'I08C'
    set ib_itemName[337] = "é»‘æ´å¼¹"
    set ib_itemCustom[337] = 1
    set ib_itemNameGbk[337] = "ºÚ¶´µ¯"
    set ib_itemList[338] = 'I08D'
    set ib_itemName[338] = "ç¼çƒ§å¼¹"
    set ib_itemCustom[338] = 1
    set ib_itemNameGbk[338] = "×ÆÉÕµ¯"
    set ib_itemList[339] = 'I08E'
    set ib_itemName[339] = "éœ‡æ’¼å¼¹"
    set ib_itemCustom[339] = 1
    set ib_itemNameGbk[339] = "Õğº³µ¯"
    set ib_itemList[340] = 'I08F'
    set ib_itemName[340] = "è’¸æ±½å¼¹"
    set ib_itemCustom[340] = 1
    set ib_itemNameGbk[340] = "ÕôÆûµ¯"
    set ib_itemList[341] = 'I08G'
    set ib_itemName[341] = "çµé­‚å¼¹"
    set ib_itemCustom[341] = 1
    set ib_itemNameGbk[341] = "Áé»êµ¯"
    set ib_itemList[342] = 'I08I'
    set ib_itemName[342] = "é­”æ³•ç‚®å¼¹åˆæˆ"
    set ib_itemCustom[342] = 1
    set ib_itemNameGbk[342] = "Ä§·¨ÅÚµ¯ºÏ³É"
    set ib_itemList[343] = 'I08H'
    set ib_itemName[343] = "|cff00db31å…‘æ¢-å†°å°å¼¹"
    set ib_itemCustom[343] = 1
    set ib_itemNameGbk[343] = "|cff00db31¶Ò»»-±ù·âµ¯"
    set ib_itemList[344] = 'I08J'
    set ib_itemName[344] = "|cff00db31å…‘æ¢-ç”µæŸå¼¹"
    set ib_itemCustom[344] = 1
    set ib_itemNameGbk[344] = "|cff00db31¶Ò»»-µçÊøµ¯"
    set ib_itemList[345] = 'I08K'
    set ib_itemName[345] = "|cff00db31å…‘æ¢-æ¯’æ°”å¼¹"
    set ib_itemCustom[345] = 1
    set ib_itemNameGbk[345] = "|cff00db31¶Ò»»-¶¾Æøµ¯"
    set ib_itemList[346] = 'I08L'
    set ib_itemName[346] = "|cff00db31å…‘æ¢-è…èš€å¼¹"
    set ib_itemCustom[346] = 1
    set ib_itemNameGbk[346] = "|cff00db31¶Ò»»-¸¯Ê´µ¯"
    set ib_itemList[347] = 'I08M'
    set ib_itemName[347] = "|cff00db31å…‘æ¢-é»‘æ´å¼¹"
    set ib_itemCustom[347] = 1
    set ib_itemNameGbk[347] = "|cff00db31¶Ò»»-ºÚ¶´µ¯"
    set ib_itemList[348] = 'I08N'
    set ib_itemName[348] = "|cff00db31å…‘æ¢-çµé­‚å¼¹"
    set ib_itemCustom[348] = 1
    set ib_itemNameGbk[348] = "|cff00db31¶Ò»»-Áé»êµ¯"
    set ib_itemList[349] = 'I08O'
    set ib_itemName[349] = "|cff00db31å…‘æ¢-éœ‡æ’¼å¼¹"
    set ib_itemCustom[349] = 1
    set ib_itemNameGbk[349] = "|cff00db31¶Ò»»-Õğº³µ¯"
    set ib_itemList[350] = 'I08P'
    set ib_itemName[350] = "|cff00db31å…‘æ¢-è’¸æ±½å¼¹"
    set ib_itemCustom[350] = 1
    set ib_itemNameGbk[350] = "|cff00db31¶Ò»»-ÕôÆûµ¯"
    set ib_itemList[351] = 'I08Q'
    set ib_itemName[351] = "|cff00db31å…‘æ¢-ç¼çƒ§å¼¹"
    set ib_itemCustom[351] = 1
    set ib_itemNameGbk[351] = "|cff00db31¶Ò»»-×ÆÉÕµ¯"
    set ib_itemList[352] = 'I08R'
    set ib_itemName[352] = "æ”»å‡»ä¹‹ä¹¦10"
    set ib_itemCustom[352] = 1
    set ib_itemNameGbk[352] = "¹¥»÷Ö®Êé10"
    set ib_itemList[353] = 'I08S'
    set ib_itemName[353] = "ä¸“å±è£…å¤‡ï¼ˆå¤§ä½¬è…°å¸¦ï¼‰"
    set ib_itemCustom[353] = 1
    set ib_itemNameGbk[353] = "×¨Êô×°±¸£¨´óÀĞÑü´ø£©"
    set ib_itemList[354] = 'I08T'
    set ib_itemName[354] = "å†°é­„å‰‘lvmax"
    set ib_itemCustom[354] = 1
    set ib_itemNameGbk[354] = "±ùÆÇ½£lvmax"
    set ib_itemList[355] = 'I08U'
    set ib_itemName[355] = "å†°é­„å‰‘lv1"
    set ib_itemCustom[355] = 1
    set ib_itemNameGbk[355] = "±ùÆÇ½£lv1"
    set ib_itemList[356] = 'I08V'
    set ib_itemName[356] = "å†°é­„å‰‘lv2"
    set ib_itemCustom[356] = 1
    set ib_itemNameGbk[356] = "±ùÆÇ½£lv2"
    set ib_itemList[357] = 'I08W'
    set ib_itemName[357] = "å†°é­„å‰‘lv3"
    set ib_itemCustom[357] = 1
    set ib_itemNameGbk[357] = "±ùÆÇ½£lv3"
    set ib_itemList[358] = 'I08X'
    set ib_itemName[358] = "å†°é­„å‰‘lv6"
    set ib_itemCustom[358] = 1
    set ib_itemNameGbk[358] = "±ùÆÇ½£lv6"
    set ib_itemList[359] = 'I08Y'
    set ib_itemName[359] = "å†°é­„å‰‘lv4"
    set ib_itemCustom[359] = 1
    set ib_itemNameGbk[359] = "±ùÆÇ½£lv4"
    set ib_itemList[360] = 'I08Z'
    set ib_itemName[360] = "å†°é­„å‰‘lv5"
    set ib_itemCustom[360] = 1
    set ib_itemNameGbk[360] = "±ùÆÇ½£lv5"
    set ib_itemList[361] = 'I090'
    set ib_itemName[361] = "å†°é­„å‰‘lv7"
    set ib_itemCustom[361] = 1
    set ib_itemNameGbk[361] = "±ùÆÇ½£lv7"
    set ib_itemList[362] = 'I091'
    set ib_itemName[362] = "å†°é­„å‰‘lv8"
    set ib_itemCustom[362] = 1
    set ib_itemNameGbk[362] = "±ùÆÇ½£lv8"
    set ib_itemList[363] = 'I092'
    set ib_itemName[363] = "å†°é­„å‰‘lv9"
    set ib_itemCustom[363] = 1
    set ib_itemNameGbk[363] = "±ùÆÇ½£lv9"
    set ib_itemList[364] = 'I093'
    set ib_itemName[364] = "éœ‡é­‚å‰‘lvmax"
    set ib_itemCustom[364] = 1
    set ib_itemNameGbk[364] = "Õğ»ê½£lvmax"
    set ib_itemList[365] = 'I094'
    set ib_itemName[365] = "éœ‡é­‚å‰‘lv8"
    set ib_itemCustom[365] = 1
    set ib_itemNameGbk[365] = "Õğ»ê½£lv8"
    set ib_itemList[366] = 'I095'
    set ib_itemName[366] = "éœ‡é­‚å‰‘lv4"
    set ib_itemCustom[366] = 1
    set ib_itemNameGbk[366] = "Õğ»ê½£lv4"
    set ib_itemList[367] = 'I096'
    set ib_itemName[367] = "éœ‡é­‚å‰‘lv3"
    set ib_itemCustom[367] = 1
    set ib_itemNameGbk[367] = "Õğ»ê½£lv3"
    set ib_itemList[368] = 'I097'
    set ib_itemName[368] = "éœ‡é­‚å‰‘lv2"
    set ib_itemCustom[368] = 1
    set ib_itemNameGbk[368] = "Õğ»ê½£lv2"
    set ib_itemList[369] = 'I098'
    set ib_itemName[369] = "éœ‡é­‚å‰‘lv1"
    set ib_itemCustom[369] = 1
    set ib_itemNameGbk[369] = "Õğ»ê½£lv1"
    set ib_itemList[370] = 'I099'
    set ib_itemName[370] = "éœ‡é­‚å‰‘lv7"
    set ib_itemCustom[370] = 1
    set ib_itemNameGbk[370] = "Õğ»ê½£lv7"
    set ib_itemList[371] = 'I09A'
    set ib_itemName[371] = "éœ‡é­‚å‰‘lv9"
    set ib_itemCustom[371] = 1
    set ib_itemNameGbk[371] = "Õğ»ê½£lv9"
    set ib_itemList[372] = 'I09B'
    set ib_itemName[372] = "éœ‡é­‚å‰‘lv6"
    set ib_itemCustom[372] = 1
    set ib_itemNameGbk[372] = "Õğ»ê½£lv6"
    set ib_itemList[373] = 'I09C'
    set ib_itemName[373] = "éœ‡é­‚å‰‘lv5"
    set ib_itemCustom[373] = 1
    set ib_itemNameGbk[373] = "Õğ»ê½£lv5"
    set ib_itemList[374] = 'I09D'
    set ib_itemName[374] = "|cff00db31æˆ˜åŠ›ä¿®å¤è¯å‰‚2å·"
    set ib_itemCustom[374] = 1
    set ib_itemNameGbk[374] = "|cff00db31Õ½Á¦ĞŞ¸´Ò©¼Á2ºÅ"
    set ib_itemList[375] = 'I09E'
    set ib_itemName[375] = "|cff00db31ç‰¹æ•ˆæé¾™è¯æ°´"
    set ib_itemCustom[375] = 1
    set ib_itemNameGbk[375] = "|cff00db31ÌØĞ§¿ÖÁúÒ©Ë®"
    set ib_itemList[376] = 'I09F'
    set ib_itemName[376] = "|cff00db31æé¾™è¯æ°´"
    set ib_itemCustom[376] = 1
    set ib_itemNameGbk[376] = "|cff00db31¿ÖÁúÒ©Ë®"
    set ib_itemList[377] = 'I09G'
    set ib_itemName[377] = "å°é¾™é¦™æ°´"
    set ib_itemCustom[377] = 1
    set ib_itemNameGbk[377] = "Ğ¡ÁúÏãË®"
    set ib_itemList[378] = 'I09H'
    set ib_itemName[378] = "|cffff0000ç¥ç§˜é™¨çŸ³å¼ºåŒ–+1"
    set ib_itemCustom[378] = 1
    set ib_itemNameGbk[378] = "|cffff0000ÉñÃØÔÉÊ¯Ç¿»¯+1"
    set ib_itemList[379] = 'I09I'
    set ib_itemName[379] = "|cffff0000ç¥ç§˜é™¨çŸ³å¼ºåŒ–+2"
    set ib_itemCustom[379] = 1
    set ib_itemNameGbk[379] = "|cffff0000ÉñÃØÔÉÊ¯Ç¿»¯+2"
    set ib_itemList[380] = 'I09J'
    set ib_itemName[380] = "|cffff0000ç¥ç§˜é™¨çŸ³å¼ºåŒ–+3"
    set ib_itemCustom[380] = 1
    set ib_itemNameGbk[380] = "|cffff0000ÉñÃØÔÉÊ¯Ç¿»¯+3"
    set ib_itemList[381] = 'I09K'
    set ib_itemName[381] = "|cffff0000ç¥ç§˜é™¨çŸ³å¼ºåŒ–max"
    set ib_itemCustom[381] = 1
    set ib_itemNameGbk[381] = "|cffff0000ÉñÃØÔÉÊ¯Ç¿»¯max"
    set ib_itemList[382] = 'I09L'
    set ib_itemName[382] = "|cffff0000ä¸“å±æ­¦å™¨ï¼ˆå¤§ä½¬ä½©å‰‘ï¼‰å¼ºåŒ–+1"
    set ib_itemCustom[382] = 1
    set ib_itemNameGbk[382] = "|cffff0000×¨ÊôÎäÆ÷£¨´óÀĞÅå½££©Ç¿»¯+1"
    set ib_itemList[383] = 'I09M'
    set ib_itemName[383] = "|cffff0000ä¸“å±æ­¦å™¨ï¼ˆå¤§ä½¬ä½©å‰‘ï¼‰å¼ºåŒ–+2"
    set ib_itemCustom[383] = 1
    set ib_itemNameGbk[383] = "|cffff0000×¨ÊôÎäÆ÷£¨´óÀĞÅå½££©Ç¿»¯+2"
    set ib_itemList[384] = 'I09N'
    set ib_itemName[384] = "|cffff0000ä¸“å±æ­¦å™¨ï¼ˆå¤§ä½¬ä½©å‰‘ï¼‰å¼ºåŒ–+3"
    set ib_itemCustom[384] = 1
    set ib_itemNameGbk[384] = "|cffff0000×¨ÊôÎäÆ÷£¨´óÀĞÅå½££©Ç¿»¯+3"
    set ib_itemList[385] = 'I09O'
    set ib_itemName[385] = "|cffff0000ä¸“å±æ­¦å™¨ï¼ˆå¤§ä½¬ä½©å‰‘ï¼‰å¼ºåŒ–max"
    set ib_itemCustom[385] = 1
    set ib_itemNameGbk[385] = "|cffff0000×¨ÊôÎäÆ÷£¨´óÀĞÅå½££©Ç¿»¯max"
    set ib_itemList[386] = 'I09P'
    set ib_itemName[386] = "ä¸“å±é¾™ç”²ï¼ˆå¤§ä½¬æˆ˜ç”²ï¼‰å¼ºåŒ–+1"
    set ib_itemCustom[386] = 1
    set ib_itemNameGbk[386] = "×¨ÊôÁú¼×£¨´óÀĞÕ½¼×£©Ç¿»¯+1"
    set ib_itemList[387] = 'I09Q'
    set ib_itemName[387] = "ä¸“å±é¾™ç”²ï¼ˆå¤§ä½¬æˆ˜ç”²ï¼‰å¼ºåŒ–+2"
    set ib_itemCustom[387] = 1
    set ib_itemNameGbk[387] = "×¨ÊôÁú¼×£¨´óÀĞÕ½¼×£©Ç¿»¯+2"
    set ib_itemList[388] = 'I09R'
    set ib_itemName[388] = "ä¸“å±é¾™ç”²ï¼ˆå¤§ä½¬æˆ˜ç”²ï¼‰å¼ºåŒ–+3"
    set ib_itemCustom[388] = 1
    set ib_itemNameGbk[388] = "×¨ÊôÁú¼×£¨´óÀĞÕ½¼×£©Ç¿»¯+3"
    set ib_itemList[389] = 'I09S'
    set ib_itemName[389] = "|cffff0000ä¸“å±é¾™ç”²ï¼ˆå¤§ä½¬æˆ˜ç”²ï¼‰å¼ºåŒ–max"
    set ib_itemCustom[389] = 1
    set ib_itemNameGbk[389] = "|cffff0000×¨ÊôÁú¼×£¨´óÀĞÕ½¼×£©Ç¿»¯max"
    set ib_itemList[390] = 'I031'
    set ib_itemName[390] = "åˆæˆ-è®¡ç®—æœºè¿ç®—å›¾çº¸"
    set ib_itemCustom[390] = 1
    set ib_itemNameGbk[390] = "ºÏ³É-¼ÆËã»úÔËËãÍ¼Ö½"
    set ib_itemList[391] = 'I09T'
    set ib_itemName[391] = "åˆæˆ-æé¾™åŸºå› å›¾çº¸"
    set ib_itemCustom[391] = 1
    set ib_itemNameGbk[391] = "ºÏ³É-¿ÖÁú»ùÒòÍ¼Ö½"
    set ib_itemList[392] = 'I09U'
    set ib_itemName[392] = "è®¡ç®—æœºè¿ç®—å›¾çº¸"
    set ib_itemCustom[392] = 1
    set ib_itemNameGbk[392] = "¼ÆËã»úÔËËãÍ¼Ö½"
    set ib_itemList[393] = 'I09V'
    set ib_itemName[393] = "æé¾™åŸºå› å›¾çº¸"
    set ib_itemCustom[393] = 1
    set ib_itemNameGbk[393] = "¿ÖÁú»ùÒòÍ¼Ö½"
    set ib_itemList[394] = 'I09W'
    set ib_itemName[394] = "ç¥ç§˜æ ‘æœå®"
    set ib_itemCustom[394] = 1
    set ib_itemNameGbk[394] = "ÉñÃØÊ÷¹ûÊµ"
    set ib_itemList[395] = 'I09X'
    set ib_itemName[395] = "ç¥ç§˜æ ‘ç§å­"
    set ib_itemCustom[395] = 1
    set ib_itemNameGbk[395] = "ÉñÃØÊ÷ÖÖ×Ó"
    set ib_itemList[396] = 'I09Y'
    set ib_itemName[396] = "|cff00db31æ¦´å¼¹å‘å°„ç‚®"
    set ib_itemCustom[396] = 1
    set ib_itemNameGbk[396] = "|cff00db31Áñµ¯·¢ÉäÅÚ"
    set ib_itemList[397] = 'I09Z'
    set ib_itemName[397] = "æ¦´å¼¹å‘å°„ å­å¼¹(2 å‘)"
    set ib_itemCustom[397] = 1
    set ib_itemNameGbk[397] = "Áñµ¯·¢Éä ×Óµ¯(2 ·¢)"
    set ib_itemList[398] = 'I0A0'
    set ib_itemName[398] = "æ¦´å¼¹å‘å°„ å­å¼¹(2 å‘))x 4ç»„"
    set ib_itemCustom[398] = 1
    set ib_itemNameGbk[398] = "Áñµ¯·¢Éä ×Óµ¯(2 ·¢))x 4×é"
    set ib_itemList[399] = 'I0A1'
    set ib_itemName[399] = "|cff00db31åéª‘è¿›åŒ–è¯å‰‚"
    set ib_itemCustom[399] = 1
    set ib_itemNameGbk[399] = "|cff00db31×øÆï½ø»¯Ò©¼Á"
endfunction
function IB_Fill5 takes nothing returns nothing
    set ib_itemList[400] = 'I0A2'
    set ib_itemName[400] = "|cffff0000ç¥ç§˜æ ‘ç§å­ï¼ˆå¤§ä»½ï¼‰"
    set ib_itemCustom[400] = 1
    set ib_itemNameGbk[400] = "|cffff0000ÉñÃØÊ÷ÖÖ×Ó£¨´ó·İ£©"
    set ib_itemList[401] = 'I0A3'
    set ib_itemName[401] = "|cff00db31æœºæ¢°è¿›åŒ–è¯å‰‚"
    set ib_itemCustom[401] = 1
    set ib_itemNameGbk[401] = "|cff00db31»úĞµ½ø»¯Ò©¼Á"
endfunction

function IB_SkillFill0 takes nothing returns nothing
    set ib_skillList[0] = 'A00B'
    set ib_skillName[0] = "gas"
    set ib_skillCustom[0] = 1
    set ib_skillList[1] = 'A00E'
    set ib_skillName[1] = "happymeal2(mana)"
    set ib_skillCustom[1] = 1
    set ib_skillList[2] = 'A00J'
    set ib_skillName[2] = "pepsi"
    set ib_skillCustom[2] = 1
    set ib_skillList[3] = 'A011'
    set ib_skillName[3] = "weaponchangeroff"
    set ib_skillCustom[3] = 1
    set ib_skillList[4] = 'A01K'
    set ib_skillName[4] = "matter cells"
    set ib_skillCustom[4] = 1
    set ib_skillList[5] = 'A01L'
    set ib_skillName[5] = "weaponchangeron"
    set ib_skillCustom[5] = 1
    set ib_skillList[6] = 'A01S'
    set ib_skillName[6] = "pepsi(injeep)"
    set ib_skillCustom[6] = 1
    set ib_skillList[7] = 'A072'
    set ib_skillName[7] = "èƒ½å¢åŠ é­”æ³•æ¢å¤é€Ÿåº¦çš„ç‰©å“ (100)"
    set ib_skillCustom[7] = 1
    set ib_skillList[8] = 'A073'
    set ib_skillName[8] = "èƒ½å¢åŠ é­”æ³•æ¢å¤é€Ÿåº¦çš„ç‰©å“ (250)"
    set ib_skillCustom[8] = 1
    set ib_skillList[9] = 'A074'
    set ib_skillName[9] = "èƒ½å¢åŠ é­”æ³•æ¢å¤é€Ÿåº¦çš„ç‰©å“ (400)"
    set ib_skillCustom[9] = 1
    set ib_skillList[10] = 'A0BL'
    set ib_skillName[10] = "ç§¯åˆ†æ¸…0é“å…·"
    set ib_skillCustom[10] = 1
    set ib_skillList[11] = 'A0BM'
    set ib_skillName[11] = "æˆå°±æ¸…0é“å…·"
    set ib_skillCustom[11] = 1
    set ib_skillList[12] = 'AAns'
    set ib_skillName[12] = "æ”¶è´¹"
    set ib_skillCustom[12] = 0
    set ib_skillList[13] = 'ACac'
    set ib_skillName[13] = "å‘½ä»¤å…‰ç¯"
    set ib_skillCustom[13] = 0
    set ib_skillList[14] = 'ACad'
    set ib_skillName[14] = "æ“çºµæ­»å°¸"
    set ib_skillCustom[14] = 0
    set ib_skillList[15] = 'ACah'
    set ib_skillName[15] = "è†æ£˜å…‰ç¯"
    set ib_skillCustom[15] = 0
    set ib_skillList[16] = 'ACam'
    set ib_skillName[16] = "åé­”æ³•å¤–å£³"
    set ib_skillCustom[16] = 0
    set ib_skillList[17] = 'ACat'
    set ib_skillName[17] = "å¼ºå‡»å…‰ç¯"
    set ib_skillCustom[17] = 0
    set ib_skillList[18] = 'ACav'
    set ib_skillName[18] = "ä¸“æ³¨å…‰ç¯"
    set ib_skillCustom[18] = 0
    set ib_skillList[19] = 'ACba'
    set ib_skillName[19] = "è¾‰ç…Œå…‰ç¯"
    set ib_skillCustom[19] = 0
    set ib_skillList[20] = 'ACbb'
    set ib_skillName[20] = "å—œè¡€æœ¯"
    set ib_skillCustom[20] = 0
    set ib_skillList[21] = 'ACbc'
    set ib_skillName[21] = "ç«ç„°å‘¼å¸"
    set ib_skillCustom[21] = 0
    set ib_skillList[22] = 'ACbf'
    set ib_skillName[22] = "éœœå†»é—ªç”µ"
    set ib_skillCustom[22] = 0
    set ib_skillList[23] = 'ACbh'
    set ib_skillName[23] = "é‡å‡»"
    set ib_skillCustom[23] = 0
    set ib_skillList[24] = 'ACbk'
    set ib_skillName[24] = "é»‘æš—ä¹‹ç®­"
    set ib_skillCustom[24] = 0
    set ib_skillList[25] = 'ACbl'
    set ib_skillName[25] = "å—œè¡€æœ¯"
    set ib_skillCustom[25] = 0
    set ib_skillList[26] = 'ACbn'
    set ib_skillName[26] = "é©±æ•£"
    set ib_skillCustom[26] = 0
    set ib_skillList[27] = 'ACbr'
    set ib_skillName[27] = "ç‹‚æš´æ„¤æ€’"
    set ib_skillCustom[27] = 0
    set ib_skillList[28] = 'ACbz'
    set ib_skillName[28] = "æš´é£é›ª"
    set ib_skillCustom[28] = 0
    set ib_skillList[29] = 'ACc2'
    set ib_skillName[29] = "å†²å‡»æ³¢"
    set ib_skillCustom[29] = 0
    set ib_skillList[30] = 'ACc3'
    set ib_skillName[30] = "å†²å‡»æ³¢"
    set ib_skillCustom[30] = 0
    set ib_skillList[31] = 'ACca'
    set ib_skillName[31] = "è…è‡­èœ‚ç¾¤"
    set ib_skillCustom[31] = 0
    set ib_skillList[32] = 'ACcb'
    set ib_skillName[32] = "éœœå†»é—ªç”µ"
    set ib_skillCustom[32] = 0
    set ib_skillList[33] = 'ACce'
    set ib_skillName[33] = "åˆ†è£‚æ”»å‡»"
    set ib_skillCustom[33] = 0
    set ib_skillList[34] = 'ACch'
    set ib_skillName[34] = "ç¬¦å’’"
    set ib_skillCustom[34] = 0
    set ib_skillList[35] = 'ACcl'
    set ib_skillName[35] = "é—ªç”µé“¾"
    set ib_skillCustom[35] = 0
    set ib_skillList[36] = 'ACcn'
    set ib_skillName[36] = "åé£Ÿå°¸ä½“"
    set ib_skillCustom[36] = 0
    set ib_skillList[37] = 'ACcr'
    set ib_skillName[37] = "æ®‹åºŸ"
    set ib_skillCustom[37] = 0
    set ib_skillList[38] = 'ACcs'
    set ib_skillName[38] = "è¯…å’’"
    set ib_skillCustom[38] = 0
    set ib_skillList[39] = 'ACct'
    set ib_skillName[39] = "è‡´å‘½ä¸€å‡»"
    set ib_skillCustom[39] = 0
    set ib_skillList[40] = 'ACcv'
    set ib_skillName[40] = "å†²å‡»æ³¢"
    set ib_skillCustom[40] = 0
    set ib_skillList[41] = 'ACcw'
    set ib_skillName[41] = "å†°å†»å†·ç®­"
    set ib_skillCustom[41] = 0
    set ib_skillList[42] = 'ACcy'
    set ib_skillName[42] = "é£“é£"
    set ib_skillCustom[42] = 0
    set ib_skillList[43] = 'ACd2'
    set ib_skillName[43] = "é©±é€é­”æ³•"
    set ib_skillCustom[43] = 0
    set ib_skillList[44] = 'ACdc'
    set ib_skillName[44] = "æ­»äº¡ç¼ ç»•"
    set ib_skillCustom[44] = 0
    set ib_skillList[45] = 'ACde'
    set ib_skillName[45] = "åå™¬é­”æ³•"
    set ib_skillCustom[45] = 0
    set ib_skillList[46] = 'ACdm'
    set ib_skillName[46] = "é©±é€é­”æ³•"
    set ib_skillCustom[46] = 0
    set ib_skillList[47] = 'ACdr'
    set ib_skillName[47] = "ç”Ÿå‘½æ±²å–"
    set ib_skillCustom[47] = 0
    set ib_skillList[48] = 'ACds'
    set ib_skillName[48] = "ç¥åœ£æŠ¤ç”²"
    set ib_skillCustom[48] = 0
    set ib_skillList[49] = 'ACdv'
    set ib_skillName[49] = "åå™¬"
    set ib_skillCustom[49] = 0
    set ib_skillList[50] = 'ACen'
    set ib_skillName[50] = "è¯±æ•"
    set ib_skillCustom[50] = 0
    set ib_skillList[51] = 'ACes'
    set ib_skillName[51] = "é—ªé¿"
    set ib_skillCustom[51] = 0
    set ib_skillList[52] = 'ACev'
    set ib_skillName[52] = "é—ªé¿"
    set ib_skillCustom[52] = 0
    set ib_skillList[53] = 'ACf2'
    set ib_skillName[53] = "éœœå†»æŠ¤ç”²"
    set ib_skillCustom[53] = 0
    set ib_skillList[54] = 'ACf3'
    set ib_skillName[54] = "ç—›è‹¦ä¹‹æŒ‡"
    set ib_skillCustom[54] = 0
    set ib_skillList[55] = 'ACfa'
    set ib_skillName[55] = "éœœå†»æŠ¤ç”²"
    set ib_skillCustom[55] = 0
    set ib_skillList[56] = 'ACfb'
    set ib_skillName[56] = "éœ¹é›³é—ªç”µ"
    set ib_skillCustom[56] = 0
    set ib_skillList[57] = 'ACfd'
    set ib_skillName[57] = "ç—›è‹¦ä¹‹æŒ‡"
    set ib_skillCustom[57] = 0
    set ib_skillList[58] = 'ACff'
    set ib_skillName[58] = "ç²¾çµä¹‹ç«"
    set ib_skillCustom[58] = 0
    set ib_skillList[59] = 'ACfl'
    set ib_skillName[59] = "å‰çŠ¶é—ªç”µ"
    set ib_skillCustom[59] = 0
    set ib_skillList[60] = 'ACfn'
    set ib_skillName[60] = "éœœå†»æ–°æ˜Ÿ"
    set ib_skillCustom[60] = 0
    set ib_skillList[61] = 'ACfr'
    set ib_skillName[61] = "è‡ªç„¶ä¹‹åŠ›"
    set ib_skillCustom[61] = 0
    set ib_skillList[62] = 'ACfs'
    set ib_skillName[62] = "çƒˆç„°é£æš´"
    set ib_skillCustom[62] = 0
    set ib_skillList[63] = 'ACfu'
    set ib_skillName[63] = "éœœå†»æŠ¤ç”²"
    set ib_skillCustom[63] = 0
    set ib_skillList[64] = 'AChv'
    set ib_skillName[64] = "åŒ»ç–—æ³¢"
    set ib_skillCustom[64] = 0
    set ib_skillList[65] = 'AChw'
    set ib_skillName[65] = "æ²»ç–—å®ˆå«"
    set ib_skillCustom[65] = 0
    set ib_skillList[66] = 'AChx'
    set ib_skillName[66] = "å¦–æœ¯"
    set ib_skillCustom[66] = 0
    set ib_skillList[67] = 'ACif'
    set ib_skillName[67] = "å¿ƒçµä¹‹ç«"
    set ib_skillCustom[67] = 0
    set ib_skillList[68] = 'ACim'
    set ib_skillName[68] = "çŒ®ç¥­"
    set ib_skillCustom[68] = 0
    set ib_skillList[69] = 'ACls'
    set ib_skillName[69] = "é—ªç”µæŠ¤ç›¾"
    set ib_skillCustom[69] = 0
    set ib_skillList[70] = 'ACm2'
    set ib_skillName[70] = "é­”æ³•å…ç–«"
    set ib_skillCustom[70] = 0
    set ib_skillList[71] = 'ACm3'
    set ib_skillName[71] = "é­”æ³•å…ç–«"
    set ib_skillCustom[71] = 0
    set ib_skillList[72] = 'ACmf'
    set ib_skillName[72] = "é­”æ³•æŠ¤ç›¾"
    set ib_skillCustom[72] = 0
    set ib_skillList[73] = 'ACmi'
    set ib_skillName[73] = "é­”æ³•å…ç–«"
    set ib_skillCustom[73] = 0
    set ib_skillList[74] = 'ACmo'
    set ib_skillName[74] = "å­£é£"
    set ib_skillCustom[74] = 0
    set ib_skillList[75] = 'ACmp'
    set ib_skillName[75] = "ç©¿åˆº"
    set ib_skillCustom[75] = 0
    set ib_skillList[76] = 'ACnr'
    set ib_skillName[76] = "ç”Ÿå‘½æ¢å¤å…‰ç¯"
    set ib_skillCustom[76] = 0
    set ib_skillList[77] = 'ACpa'
    set ib_skillName[77] = "å¯„ç”Ÿè™«"
    set ib_skillCustom[77] = 0
    set ib_skillList[78] = 'ACps'
    set ib_skillName[78] = "å æ®"
    set ib_skillCustom[78] = 0
    set ib_skillList[79] = 'ACpu'
    set ib_skillName[79] = "å‡€åŒ–"
    set ib_skillCustom[79] = 0
endfunction
function IB_SkillFill1 takes nothing returns nothing
    set ib_skillList[80] = 'ACpv'
    set ib_skillName[80] = "ç²‰ç¢"
    set ib_skillCustom[80] = 0
    set ib_skillList[81] = 'ACpy'
    set ib_skillName[81] = "å˜å½¢æœ¯"
    set ib_skillCustom[81] = 0
    set ib_skillList[82] = 'ACr1'
    set ib_skillName[82] = "å’†å“®"
    set ib_skillCustom[82] = 0
    set ib_skillList[83] = 'ACr2'
    set ib_skillName[83] = "ç”Ÿå‘½æ¢å¤"
    set ib_skillCustom[83] = 0
    set ib_skillList[84] = 'ACrd'
    set ib_skillName[84] = "å¤æ´»æ­»å°¸"
    set ib_skillCustom[84] = 0
    set ib_skillList[85] = 'ACrf'
    set ib_skillName[85] = "ç«ç„°é›¨"
    set ib_skillCustom[85] = 0
    set ib_skillList[86] = 'ACrg'
    set ib_skillName[86] = "ç«ç„°é›¨"
    set ib_skillCustom[86] = 0
    set ib_skillList[87] = 'ACrj'
    set ib_skillName[87] = "ç”Ÿå‘½æ¢å¤"
    set ib_skillCustom[87] = 0
    set ib_skillList[88] = 'ACrk'
    set ib_skillName[88] = "æŠ—æ€§çš®è‚¤"
    set ib_skillCustom[88] = 0
    set ib_skillList[89] = 'ACrn'
    set ib_skillName[89] = "é‡ç”Ÿ"
    set ib_skillCustom[89] = 0
    set ib_skillList[90] = 'ACro'
    set ib_skillName[90] = "å’†å“®"
    set ib_skillCustom[90] = 0
    set ib_skillList[91] = 'ACs7'
    set ib_skillName[91] = "é‡å…½å¹½é­‚"
    set ib_skillCustom[91] = 0
    set ib_skillList[92] = 'ACs8'
    set ib_skillName[92] = "çµå…½"
    set ib_skillCustom[92] = 0
    set ib_skillList[93] = 'ACs9'
    set ib_skillName[93] = "é‡å…½å¹½é­‚"
    set ib_skillCustom[93] = 0
    set ib_skillList[94] = 'ACsa'
    set ib_skillName[94] = "ç¼çƒ­ä¹‹ç®­"
    set ib_skillCustom[94] = 0
    set ib_skillList[95] = 'ACsf'
    set ib_skillName[95] = "é‡å…½å¹½é­‚"
    set ib_skillCustom[95] = 0
    set ib_skillList[96] = 'ACsh'
    set ib_skillName[96] = "éœ‡è¡æ³¢"
    set ib_skillCustom[96] = 0
    set ib_skillList[97] = 'ACsi'
    set ib_skillName[97] = "æ²‰é»˜é­”æ³•"
    set ib_skillCustom[97] = 0
    set ib_skillList[98] = 'ACsk'
    set ib_skillName[98] = "æŠ—æ€§çš®è‚¤"
    set ib_skillCustom[98] = 0
    set ib_skillList[99] = 'ACsl'
    set ib_skillName[99] = "ç¡çœ "
    set ib_skillCustom[99] = 0
    set ib_skillList[100] = 'ACsm'
    set ib_skillName[100] = "é­”æ³•å¸å®"
    set ib_skillCustom[100] = 0
    set ib_skillList[101] = 'ACsp'
    set ib_skillName[101] = "ç¡çœ "
    set ib_skillCustom[101] = 0
    set ib_skillList[102] = 'ACst'
    set ib_skillName[102] = "éœ‡è¡æ³¢"
    set ib_skillCustom[102] = 0
    set ib_skillList[103] = 'ACsw'
    set ib_skillName[103] = "å‡é€Ÿ"
    set ib_skillCustom[103] = 0
    set ib_skillList[104] = 'ACt2'
    set ib_skillName[104] = "é›·éœ†ä¸€å‡»"
    set ib_skillCustom[104] = 0
    set ib_skillList[105] = 'ACtb'
    set ib_skillName[105] = "æŠ•çŸ³"
    set ib_skillCustom[105] = 0
    set ib_skillList[106] = 'ACtc'
    set ib_skillName[106] = "é›·éœ†ä¸€å‡»"
    set ib_skillCustom[106] = 0
    set ib_skillList[107] = 'ACtn'
    set ib_skillName[107] = "äº§åµè§¦è§’"
    set ib_skillCustom[107] = 0
    set ib_skillList[108] = 'ACua'
    set ib_skillName[108] = "é‚ªæ¶å…‰ç¯"
    set ib_skillCustom[108] = 0
    set ib_skillList[109] = 'ACuf'
    set ib_skillName[109] = "é‚ªæ¶ç‹‚çƒ­"
    set ib_skillCustom[109] = 0
    set ib_skillList[110] = 'ACvp'
    set ib_skillName[110] = "å¸è¡€å…‰ç¯"
    set ib_skillCustom[110] = 0
    set ib_skillList[111] = 'ACvs'
    set ib_skillName[111] = "æµ¸æ¯’æ­¦å™¨"
    set ib_skillCustom[111] = 0
    set ib_skillList[112] = 'ACwb'
    set ib_skillName[112] = "è››ç½‘"
    set ib_skillCustom[112] = 0
    set ib_skillList[113] = 'ACwe'
    set ib_skillName[113] = "å¬å”¤æµ·å…ƒç´ "
    set ib_skillCustom[113] = 0
    set ib_skillList[114] = 'AEIl'
    set ib_skillName[114] = "å˜èº«"
    set ib_skillCustom[114] = 0
    set ib_skillList[115] = 'AEah'
    set ib_skillName[115] = "è†æ£˜å…‰ç¯"
    set ib_skillCustom[115] = 0
    set ib_skillList[116] = 'AEar'
    set ib_skillName[116] = "å¼ºå‡»å…‰ç¯"
    set ib_skillCustom[116] = 0
    set ib_skillList[117] = 'AEbl'
    set ib_skillName[117] = "é—ªçƒ"
    set ib_skillCustom[117] = 0
    set ib_skillList[118] = 'AEbu'
    set ib_skillName[118] = "å»ºé€  (æš—å¤œç²¾çµ)"
    set ib_skillCustom[118] = 0
    set ib_skillList[119] = 'AEer'
    set ib_skillName[119] = "çº ç¼ æ ¹é¡»"
    set ib_skillCustom[119] = 0
    set ib_skillList[120] = 'AEev'
    set ib_skillName[120] = "é—ªé¿"
    set ib_skillCustom[120] = 0
    set ib_skillList[121] = 'AEfk'
    set ib_skillName[121] = "åˆ€é˜µæ—‹é£"
    set ib_skillCustom[121] = 0
    set ib_skillList[122] = 'AEfn'
    set ib_skillName[122] = "è‡ªç„¶ä¹‹åŠ›"
    set ib_skillCustom[122] = 0
    set ib_skillList[123] = 'AEim'
    set ib_skillName[123] = "çŒ®ç¥­"
    set ib_skillCustom[123] = 0
    set ib_skillList[124] = 'AEmb'
    set ib_skillName[124] = "æ³•åŠ›ç‡ƒçƒ§"
    set ib_skillCustom[124] = 0
    set ib_skillList[125] = 'AEme'
    set ib_skillName[125] = "å˜èº«"
    set ib_skillCustom[125] = 0
    set ib_skillList[126] = 'AEpa'
    set ib_skillName[126] = "æ¯’ç®­"
    set ib_skillCustom[126] = 0
    set ib_skillList[127] = 'AEsb'
    set ib_skillName[127] = "ç¾¤æ˜Ÿå è½"
    set ib_skillCustom[127] = 0
    set ib_skillList[128] = 'AEsf'
    set ib_skillName[128] = "ç¾¤æ˜Ÿå è½"
    set ib_skillCustom[128] = 0
    set ib_skillList[129] = 'AEsh'
    set ib_skillName[129] = "æš—å½±çªè¢­"
    set ib_skillCustom[129] = 0
    set ib_skillList[130] = 'AEst'
    set ib_skillName[130] = "ä¾¦å¯Ÿ"
    set ib_skillCustom[130] = 0
    set ib_skillList[131] = 'AEsv'
    set ib_skillName[131] = "å¤ä»‡ä¹‹é­‚"
    set ib_skillCustom[131] = 0
    set ib_skillList[132] = 'AEtq'
    set ib_skillName[132] = "å®é™"
    set ib_skillCustom[132] = 0
    set ib_skillList[133] = 'AEvi'
    set ib_skillName[133] = "å˜èº«"
    set ib_skillCustom[133] = 0
    set ib_skillList[134] = 'AGbu'
    set ib_skillName[134] = "å»ºé€ (å¨œè¿¦)"
    set ib_skillCustom[134] = 0
    set ib_skillList[135] = 'AHab'
    set ib_skillName[135] = "è¾‰ç…Œå…‰ç¯"
    set ib_skillCustom[135] = 0
    set ib_skillList[136] = 'AHad'
    set ib_skillName[136] = "ä¸“æ³¨å…‰ç¯"
    set ib_skillCustom[136] = 0
    set ib_skillList[137] = 'AHav'
    set ib_skillName[137] = "å¤©ç¥ä¸‹å‡¡"
    set ib_skillCustom[137] = 0
    set ib_skillList[138] = 'AHbh'
    set ib_skillName[138] = "é‡å‡»"
    set ib_skillCustom[138] = 0
    set ib_skillList[139] = 'AHbn'
    set ib_skillName[139] = "é©±æ•£"
    set ib_skillCustom[139] = 0
    set ib_skillList[140] = 'AHbu'
    set ib_skillName[140] = "å»ºé€ (äººæ—)"
    set ib_skillCustom[140] = 0
    set ib_skillList[141] = 'AHbz'
    set ib_skillName[141] = "æš´é£é›ª"
    set ib_skillCustom[141] = 0
    set ib_skillList[142] = 'AHca'
    set ib_skillName[142] = "å†°å†»å†·ç®­"
    set ib_skillCustom[142] = 0
    set ib_skillList[143] = 'AHdr'
    set ib_skillName[143] = "é­”æ³•å¸å®"
    set ib_skillCustom[143] = 0
    set ib_skillList[144] = 'AHds'
    set ib_skillName[144] = "ç¥åœ£æŠ¤ç”²"
    set ib_skillCustom[144] = 0
    set ib_skillList[145] = 'AHer'
    set ib_skillName[145] = "è‹±é›„"
    set ib_skillCustom[145] = 0
    set ib_skillList[146] = 'AHfa'
    set ib_skillName[146] = "ç¼çƒ­ä¹‹ç®­"
    set ib_skillCustom[146] = 0
    set ib_skillList[147] = 'AHfs'
    set ib_skillName[147] = "çƒˆç„°é£æš´"
    set ib_skillCustom[147] = 0
    set ib_skillList[148] = 'AHhb'
    set ib_skillName[148] = "ç¥åœ£ä¹‹å…‰"
    set ib_skillCustom[148] = 0
    set ib_skillList[149] = 'AHmt'
    set ib_skillName[149] = "ç¾¤ä½“ä¼ é€"
    set ib_skillCustom[149] = 0
    set ib_skillList[150] = 'AHpx'
    set ib_skillName[150] = "ç«å‡¤å‡°"
    set ib_skillCustom[150] = 0
    set ib_skillList[151] = 'AHre'
    set ib_skillName[151] = "å¤æ´»"
    set ib_skillCustom[151] = 0
    set ib_skillList[152] = 'AHta'
    set ib_skillName[152] = "æ˜¾ç¤º"
    set ib_skillCustom[152] = 0
    set ib_skillList[153] = 'AHtb'
    set ib_skillName[153] = "é£æš´ä¹‹é”¤"
    set ib_skillCustom[153] = 0
    set ib_skillList[154] = 'AHtc'
    set ib_skillName[154] = "é›·éœ†ä¸€å‡»"
    set ib_skillCustom[154] = 0
    set ib_skillList[155] = 'AHwe'
    set ib_skillName[155] = "å¬å”¤æ°´å…ƒç´ "
    set ib_skillCustom[155] = 0
    set ib_skillList[156] = 'AI2m'
    set ib_skillName[156] = "èƒ½å¢åŠ é­”æ³•å€¼çš„ç‰©å“(200)"
    set ib_skillCustom[156] = 0
    set ib_skillList[157] = 'AIa1'
    set ib_skillName[157] = "èƒ½æé«˜è‹±é›„å±æ€§çš„ç‰©å“"
    set ib_skillCustom[157] = 0
    set ib_skillList[158] = 'AIa3'
    set ib_skillName[158] = "èƒ½æé«˜è‹±é›„å±æ€§çš„ç‰©å“"
    set ib_skillCustom[158] = 0
    set ib_skillList[159] = 'AIa4'
    set ib_skillName[159] = "èƒ½æé«˜è‹±é›„å±æ€§çš„ç‰©å“"
    set ib_skillCustom[159] = 0
endfunction
function IB_SkillFill2 takes nothing returns nothing
    set ib_skillList[160] = 'AIa6'
    set ib_skillName[160] = "èƒ½æé«˜è‹±é›„å±æ€§çš„ç‰©å“"
    set ib_skillCustom[160] = 0
    set ib_skillList[161] = 'AIaa'
    set ib_skillName[161] = "èƒ½å¢åŠ æ”»å‡»åŠ›çš„ç‰©å“"
    set ib_skillCustom[161] = 0
    set ib_skillList[162] = 'AIab'
    set ib_skillName[162] = "èƒ½æé«˜è‹±é›„å±æ€§çš„ç‰©å“"
    set ib_skillCustom[162] = 0
    set ib_skillList[163] = 'AIam'
    set ib_skillName[163] = "èƒ½å¢åŠ æ•æ·åº¦çš„ç‰©å“"
    set ib_skillCustom[163] = 0
    set ib_skillList[164] = 'AIan'
    set ib_skillName[164] = "èƒ½æ“çºµæ­»å°¸çš„ç‰©å“"
    set ib_skillCustom[164] = 0
    set ib_skillList[165] = 'AIas'
    set ib_skillName[165] = "èƒ½æé«˜æ”»å‡»é€Ÿåº¦çš„ç‰©å“"
    set ib_skillCustom[165] = 0
    set ib_skillList[166] = 'AIat'
    set ib_skillName[166] = "å¢åŠ æ”»å‡»åŠ›çš„ç‰©å“"
    set ib_skillCustom[166] = 0
    set ib_skillList[167] = 'AIaz'
    set ib_skillName[167] = "èƒ½æé«˜è‹±é›„å±æ€§çš„ç‰©å“"
    set ib_skillCustom[167] = 0
    set ib_skillList[168] = 'AIbb'
    set ib_skillName[168] = "å»ºé€ å¾®å‹é“åŒ é“º"
    set ib_skillCustom[168] = 0
    set ib_skillList[169] = 'AIbf'
    set ib_skillName[169] = "å»ºé€ å¾®å‹å†œåœº"
    set ib_skillCustom[169] = 0
    set ib_skillList[170] = 'AIbg'
    set ib_skillName[170] = "å»ºé€ å°å‹çš„å¤§å…"
    set ib_skillCustom[170] = 0
    set ib_skillList[171] = 'AIbh'
    set ib_skillName[171] = "å»ºé€ å¾®å‹å›½ç‹ç¥­å›"
    set ib_skillCustom[171] = 0
    set ib_skillList[172] = 'AIbk'
    set ib_skillName[172] = "é—ªçƒ(ç‰©å“ç­‰çº§)"
    set ib_skillCustom[172] = 0
    set ib_skillList[173] = 'AIbl'
    set ib_skillName[173] = "å»ºé€ å°å‹çš„åŸå ¡"
    set ib_skillCustom[173] = 0
    set ib_skillList[174] = 'AIbm'
    set ib_skillName[174] = "èƒ½å¢åŠ é­”æ³•å€¼çš„ç‰©å“"
    set ib_skillCustom[174] = 0
    set ib_skillList[175] = 'AIbr'
    set ib_skillName[175] = "å»ºé€ å¾®å‹ä¼æœ¨åœº"
    set ib_skillCustom[175] = 0
    set ib_skillList[176] = 'AIbs'
    set ib_skillName[176] = "å»ºé€ å¾®å‹å…µè¥"
    set ib_skillCustom[176] = 0
    set ib_skillList[177] = 'AIbt'
    set ib_skillName[177] = "å»ºé€ å°å‹çš„å“¨å¡”"
    set ib_skillCustom[177] = 0
    set ib_skillList[178] = 'AIbx'
    set ib_skillName[178] = "é‡å‡»"
    set ib_skillCustom[178] = 0
    set ib_skillList[179] = 'AIcb'
    set ib_skillName[179] = "å¸¦æœ‰è…èš€æ”»å‡»æ•ˆæœçš„ç‰©å“"
    set ib_skillCustom[179] = 0
    set ib_skillList[180] = 'AIcf'
    set ib_skillName[180] = "å…·æœ‰çŒ®ç¥­æ•ˆæœçš„ç‰©å“"
    set ib_skillCustom[180] = 0
    set ib_skillList[181] = 'AIcl'
    set ib_skillName[181] = "é—ªç”µé“¾"
    set ib_skillCustom[181] = 0
    set ib_skillList[182] = 'AIcm'
    set ib_skillName[182] = "æ§åˆ¶é­”æ³•"
    set ib_skillCustom[182] = 0
    set ib_skillList[183] = 'AIco'
    set ib_skillName[183] = "å‘½ä»¤ç‰©å“"
    set ib_skillCustom[183] = 0
    set ib_skillList[184] = 'AIcs'
    set ib_skillName[184] = "è‡´å‘½ä¸€å‡»"
    set ib_skillCustom[184] = 0
    set ib_skillList[185] = 'AIct'
    set ib_skillName[185] = "æ”¹å˜ä¸€å¤©çš„æ—¶é—´"
    set ib_skillCustom[185] = 0
    set ib_skillList[186] = 'AIcy'
    set ib_skillName[186] = "é£“é£"
    set ib_skillCustom[186] = 0
    set ib_skillList[187] = 'AId0'
    set ib_skillName[187] = "èƒ½æé«˜æŠ¤ç”²çš„ç‰©å“"
    set ib_skillCustom[187] = 0
    set ib_skillList[188] = 'AId1'
    set ib_skillName[188] = "èƒ½æé«˜æŠ¤ç”²çš„ç‰©å“"
    set ib_skillCustom[188] = 0
    set ib_skillList[189] = 'AId2'
    set ib_skillName[189] = "èƒ½æé«˜æŠ¤ç”²çš„ç‰©å“"
    set ib_skillCustom[189] = 0
    set ib_skillList[190] = 'AId3'
    set ib_skillName[190] = "èƒ½æé«˜æŠ¤ç”²çš„ç‰©å“"
    set ib_skillCustom[190] = 0
    set ib_skillList[191] = 'AId4'
    set ib_skillName[191] = "èƒ½æé«˜æŠ¤ç”²çš„ç‰©å“"
    set ib_skillCustom[191] = 0
    set ib_skillList[192] = 'AId5'
    set ib_skillName[192] = "èƒ½æé«˜æŠ¤ç”²çš„ç‰©å“"
    set ib_skillCustom[192] = 0
    set ib_skillList[193] = 'AId7'
    set ib_skillName[193] = "èƒ½åŠ å¼ºæŠ¤ç”²çš„ç‰©å“"
    set ib_skillCustom[193] = 0
    set ib_skillList[194] = 'AId8'
    set ib_skillName[194] = "èƒ½æé«˜æŠ¤ç”²çš„ç‰©å“"
    set ib_skillCustom[194] = 0
    set ib_skillList[195] = 'AIda'
    set ib_skillName[195] = "èƒ½æš‚æ—¶æé«˜ä¸€å®šèŒƒå›´å†…æ‰€æœ‰å•ä½æŠ¤ç”²çš„ç‰©å“"
    set ib_skillCustom[195] = 0
    set ib_skillList[196] = 'AIdb'
    set ib_skillName[196] = "èƒ½æš‚æ—¶åŠ å¼ºèŒƒå›´å†…æ‰€æœ‰å•ä½æŠ¤ç”²çš„ç‰©å“"
    set ib_skillCustom[196] = 0
    set ib_skillList[197] = 'AIdc'
    set ib_skillName[197] = "å¸¦æœ‰é”é“¾é©±é€æ•ˆæœçš„ç‰©å“"
    set ib_skillCustom[197] = 0
    set ib_skillList[198] = 'AIdd'
    set ib_skillName[198] = "passive defense"
    set ib_skillCustom[198] = 0
    set ib_skillList[199] = 'AIde'
    set ib_skillName[199] = "èƒ½å¢åŠ æŠ¤ç”²çš„ç‰©å“"
    set ib_skillCustom[199] = 0
    set ib_skillList[200] = 'AIdf'
    set ib_skillName[200] = "èƒ½å¸¦æœ‰é»‘ç®­æ”»å‡»ä¼¤å®³çš„ç‰©å“"
    set ib_skillCustom[200] = 0
    set ib_skillList[201] = 'AIdi'
    set ib_skillName[201] = "å…·æœ‰é©±é€é­”æ³•æ•ˆæœçš„ç‰©å“"
    set ib_skillCustom[201] = 0
    set ib_skillList[202] = 'AIdm'
    set ib_skillName[202] = "èƒ½å¯¹èŒƒå›´å†…çš„æ ‘æœ¨/å¢™å£é€ æˆä¼¤å®³çš„ç‰©å“"
    set ib_skillCustom[202] = 0
    set ib_skillList[203] = 'AIdn'
    set ib_skillName[203] = "å½±å­ä¹‹çƒ æŠ€èƒ½"
    set ib_skillCustom[203] = 0
    set ib_skillList[204] = 'AIdp'
    set ib_skillName[204] = "æ­»äº¡å¥‘çº¦"
    set ib_skillCustom[204] = 0
    set ib_skillList[205] = 'AIds'
    set ib_skillName[205] = "å…·æœ‰é©±é€é­”æ³•æ•ˆæœçš„ç‰©å“"
    set ib_skillCustom[205] = 0
    set ib_skillList[206] = 'AIdv'
    set ib_skillName[206] = "ç‰©å“ç¥åœ£æŠ¤ç”²"
    set ib_skillCustom[206] = 0
    set ib_skillList[207] = 'AIe2'
    set ib_skillName[207] = "èƒ½è·å–ç»éªŒå€¼çš„ç‰©å“"
    set ib_skillCustom[207] = 0
    set ib_skillList[208] = 'AIem'
    set ib_skillName[208] = "èƒ½è·å–ç»éªŒå€¼çš„ç‰©å“"
    set ib_skillCustom[208] = 0
    set ib_skillList[209] = 'AIev'
    set ib_skillName[209] = "é—ªé¿"
    set ib_skillCustom[209] = 0
    set ib_skillList[210] = 'AIfa'
    set ib_skillName[210] = "ä¿¡å·æª"
    set ib_skillCustom[210] = 0
    set ib_skillList[211] = 'AIfb'
    set ib_skillName[211] = "èƒ½å¸¦æœ‰ç«ç„°ä¼¤å®³çš„ç‰©å“"
    set ib_skillCustom[211] = 0
    set ib_skillList[212] = 'AIfc'
    set ib_skillName[212] = "é£è¡Œåœ°æ¯¯"
    set ib_skillCustom[212] = 0
    set ib_skillList[213] = 'AIfd'
    set ib_skillName[213] = "èƒ½å¬å”¤çº¢é¾™çš„ç‰©å“"
    set ib_skillCustom[213] = 0
    set ib_skillList[214] = 'AIfe'
    set ib_skillName[214] = "æŠ¢å¤ºæ——å¸œ"
    set ib_skillCustom[214] = 0
    set ib_skillList[215] = 'AIff'
    set ib_skillName[215] = "èƒ½å¬å”¤ç†Šæ€ªçš„ç‰©å“"
    set ib_skillCustom[215] = 0
    set ib_skillList[216] = 'AIfg'
    set ib_skillName[216] = "ä¹Œäº‘æŠ€èƒ½"
    set ib_skillCustom[216] = 0
    set ib_skillList[217] = 'AIfh'
    set ib_skillName[217] = "èƒ½å¬å”¤åœ°ç‹±çŠ¬çš„ç‰©å“"
    set ib_skillCustom[217] = 0
    set ib_skillList[218] = 'AIfi'
    set ib_skillName[218] = "éœ¹é›³é—ªç”µç‰©å“"
    set ib_skillCustom[218] = 0
    set ib_skillList[219] = 'AIfl'
    set ib_skillName[219] = "æŠ¢å¤ºæ——å¸œ"
    set ib_skillCustom[219] = 0
    set ib_skillList[220] = 'AIfm'
    set ib_skillName[220] = "æŠ¢å¤ºæ——å¸œ"
    set ib_skillCustom[220] = 0
    set ib_skillList[221] = 'AIfn'
    set ib_skillName[221] = "æŠ¢å¤ºæ——å¸œ"
    set ib_skillCustom[221] = 0
    set ib_skillList[222] = 'AIfo'
    set ib_skillName[222] = "æŠ¢å¤ºæ——å¸œ"
    set ib_skillCustom[222] = 0
    set ib_skillList[223] = 'AIfr'
    set ib_skillName[223] = "èƒ½å¬å”¤å²©çŸ³å‚€å„¡çš„ç‰©å“"
    set ib_skillCustom[223] = 0
    set ib_skillList[224] = 'AIfs'
    set ib_skillName[224] = "èƒ½å¬å”¤éª·é«…æˆ˜å£«çš„ç‰©å“"
    set ib_skillCustom[224] = 0
    set ib_skillList[225] = 'AIft'
    set ib_skillName[225] = "è¿‘æˆ˜æ”»å‡»å¸¦æœ‰å†°å†»ä¼¤å®³"
    set ib_skillCustom[225] = 0
    set ib_skillList[226] = 'AIfu'
    set ib_skillName[226] = "èƒ½å¬å”¤æ¯ç­å®ˆå«çš„ç‰©å“"
    set ib_skillCustom[226] = 0
    set ib_skillList[227] = 'AIfw'
    set ib_skillName[227] = "è¿‘æˆ˜æ”»å‡»å¸¦æœ‰ç«ç„°ä¼¤å®³"
    set ib_skillCustom[227] = 0
    set ib_skillList[228] = 'AIfx'
    set ib_skillName[228] = "ç‰©å“å…½æ—æˆ˜æ–—æ ‡å‡†"
    set ib_skillCustom[228] = 0
    set ib_skillList[229] = 'AIfz'
    set ib_skillName[229] = "æ­»äº¡ä¹‹æŒ‡"
    set ib_skillCustom[229] = 0
    set ib_skillList[230] = 'AIgd'
    set ib_skillName[230] = "èƒ½å¸¦æœ‰ç«ç„°ä¼¤å®³çš„ç‰©å“"
    set ib_skillCustom[230] = 0
    set ib_skillList[231] = 'AIgf'
    set ib_skillName[231] = "é˜²å¾¡æµ®é›•"
    set ib_skillCustom[231] = 0
    set ib_skillList[232] = 'AIgm'
    set ib_skillName[232] = "èƒ½å¢åŠ æ•æ·åº¦çš„ç‰©å“"
    set ib_skillCustom[232] = 0
    set ib_skillList[233] = 'AIgo'
    set ib_skillName[233] = "é‡‘ç®±å­"
    set ib_skillCustom[233] = 0
    set ib_skillList[234] = 'AIgu'
    set ib_skillName[234] = "é˜²å¾¡æµ®é›•"
    set ib_skillCustom[234] = 0
    set ib_skillList[235] = 'AIgx'
    set ib_skillName[235] = "æ¢å¤å…‰ç¯"
    set ib_skillCustom[235] = 0
    set ib_skillList[236] = 'AIh1'
    set ib_skillName[236] = "å…·æœ‰åŒ»ç–—æ•ˆæœçš„ç‰©å“"
    set ib_skillCustom[236] = 0
    set ib_skillList[237] = 'AIh2'
    set ib_skillName[237] = "å…·æœ‰åŒ»ç–—æ•ˆæœçš„ç‰©å“"
    set ib_skillCustom[237] = 0
    set ib_skillList[238] = 'AIh3'
    set ib_skillName[238] = "æœ€å°çš„åŒ»ç–—èƒ½åŠ›"
    set ib_skillCustom[238] = 0
    set ib_skillList[239] = 'AIha'
    set ib_skillName[239] = "èƒ½è¿›è¡ŒèŒƒå›´åŒ»ç–—çš„ç‰©å“"
    set ib_skillCustom[239] = 0
endfunction
function IB_SkillFill3 takes nothing returns nothing
    set ib_skillList[240] = 'AIhb'
    set ib_skillName[240] = "èƒ½è¿›è¡ŒèŒƒå›´åŒ»ç–—çš„ç‰©å“"
    set ib_skillCustom[240] = 0
    set ib_skillList[241] = 'AIhe'
    set ib_skillName[241] = "å…·æœ‰åŒ»ç–—æ•ˆæœçš„ç‰©å“"
    set ib_skillCustom[241] = 0
    set ib_skillList[242] = 'AIhl'
    set ib_skillName[242] = "ç¥åœ£ä¹‹å…‰"
    set ib_skillCustom[242] = 0
    set ib_skillList[243] = 'AIhw'
    set ib_skillName[243] = "æ²»ç–—å®ˆå«"
    set ib_skillCustom[243] = 0
    set ib_skillList[244] = 'AIhx'
    set ib_skillName[244] = "å…·æœ‰åŒ»ç–—æ•ˆæœçš„ç‰©å“"
    set ib_skillCustom[244] = 0
    set ib_skillList[245] = 'AIi1'
    set ib_skillName[245] = "èƒ½æé«˜è‹±é›„å±æ€§çš„ç‰©å“"
    set ib_skillCustom[245] = 0
    set ib_skillList[246] = 'AIi3'
    set ib_skillName[246] = "èƒ½æé«˜è‹±é›„å±æ€§çš„ç‰©å“"
    set ib_skillCustom[246] = 0
    set ib_skillList[247] = 'AIi4'
    set ib_skillName[247] = "èƒ½æé«˜è‹±é›„å±æ€§çš„ç‰©å“"
    set ib_skillCustom[247] = 0
    set ib_skillList[248] = 'AIi6'
    set ib_skillName[248] = "èƒ½æé«˜è‹±é›„å±æ€§çš„ç‰©å“"
    set ib_skillCustom[248] = 0
    set ib_skillList[249] = 'AIil'
    set ib_skillName[249] = "å¹»è±¡ç‰©å“"
    set ib_skillCustom[249] = 0
    set ib_skillList[250] = 'AIim'
    set ib_skillName[250] = "èƒ½æé«˜æ™ºåŠ›çš„ç‰©å“"
    set ib_skillCustom[250] = 0
    set ib_skillList[251] = 'AIir'
    set ib_skillName[251] = "èƒ½å¬å”¤å†°å†»å¹½çµçš„ç‰©å“"
    set ib_skillCustom[251] = 0
    set ib_skillList[252] = 'AIl1'
    set ib_skillName[252] = "èƒ½å¢åŠ ç”Ÿå‘½å€¼çš„ç‰©å“"
    set ib_skillCustom[252] = 0
    set ib_skillList[253] = 'AIl2'
    set ib_skillName[253] = "èƒ½å¢åŠ ç”Ÿå‘½å€¼çš„ç‰©å“"
    set ib_skillCustom[253] = 0
    set ib_skillList[254] = 'AIlb'
    set ib_skillName[254] = "èƒ½å¸¦æœ‰é—ªç”µä¼¤å®³çš„ç‰©å“"
    set ib_skillCustom[254] = 0
    set ib_skillList[255] = 'AIlf'
    set ib_skillName[255] = "èƒ½å¢åŠ ç”Ÿå‘½å€¼çš„ç‰©å“"
    set ib_skillCustom[255] = 0
    set ib_skillList[256] = 'AIll'
    set ib_skillName[256] = "é—ªç”µä¹‹çƒ(æ–°çš„)"
    set ib_skillCustom[256] = 0
    set ib_skillList[257] = 'AIlm'
    set ib_skillName[257] = "èƒ½æé«˜ç­‰çº§çš„ç‰©å“"
    set ib_skillCustom[257] = 0
    set ib_skillList[258] = 'AIlp'
    set ib_skillName[258] = "å¸¦æœ‰å‡€åŒ–æ•ˆæœçš„ç‰©å“"
    set ib_skillCustom[258] = 0
    set ib_skillList[259] = 'AIls'
    set ib_skillName[259] = "é—ªç”µæŠ¤ç›¾"
    set ib_skillCustom[259] = 0
    set ib_skillList[260] = 'AIlu'
    set ib_skillName[260] = "æœ¨æå †"
    set ib_skillCustom[260] = 0
    set ib_skillList[261] = 'AIlx'
    set ib_skillName[261] = "è¿‘æˆ˜æ”»å‡»å¸¦æœ‰é—ªç”µä¼¤å®³"
    set ib_skillCustom[261] = 0
    set ib_skillList[262] = 'AIlz'
    set ib_skillName[262] = "èƒ½å¢åŠ ç”Ÿå‘½å€¼çš„ç‰©å“"
    set ib_skillCustom[262] = 0
    set ib_skillList[263] = 'AIm1'
    set ib_skillName[263] = "èƒ½å¢åŠ é­”æ³•æ¢å¤é€Ÿåº¦çš„ç‰©å“"
    set ib_skillCustom[263] = 0
    set ib_skillList[264] = 'AIm2'
    set ib_skillName[264] = "èƒ½å¢åŠ é­”æ³•æ¢å¤é€Ÿåº¦çš„ç‰©å“"
    set ib_skillCustom[264] = 0
    set ib_skillList[265] = 'AIma'
    set ib_skillName[265] = "èƒ½å¢åŠ é­”æ³•æ¢å¤é€Ÿåº¦çš„ç‰©å“"
    set ib_skillCustom[265] = 0
    set ib_skillList[266] = 'AImb'
    set ib_skillName[266] = "èƒ½å¢åŠ é­”æ³•å€¼çš„ç‰©å“"
    set ib_skillCustom[266] = 0
    set ib_skillList[267] = 'AImh'
    set ib_skillName[267] = "èƒ½æ°¸ä¹…å¢åŠ ç”Ÿå‘½å€¼çš„ç‰©å“"
    set ib_skillCustom[267] = 0
    set ib_skillList[268] = 'AImi'
    set ib_skillName[268] = "èƒ½å¢åŠ ç”Ÿå‘½å€¼çš„ç‰©å“"
    set ib_skillCustom[268] = 0
    set ib_skillList[269] = 'AIml'
    set ib_skillName[269] = "èƒ½å¢åŠ ç”Ÿå‘½å€¼çš„ç‰©å“"
    set ib_skillCustom[269] = 0
    set ib_skillList[270] = 'AImm'
    set ib_skillName[270] = "èƒ½å¢åŠ é­”æ³•å€¼çš„ç‰©å“"
    set ib_skillCustom[270] = 0
    set ib_skillList[271] = 'AImo'
    set ib_skillName[271] = "æ€ªå…½è¯±æ•å®ˆå«"
    set ib_skillCustom[271] = 0
    set ib_skillList[272] = 'AImr'
    set ib_skillName[272] = "èƒ½æé«˜ä¸€å®šèŒƒå›´å†…æ‰€æœ‰å•ä½é­”æ³•å€¼çš„ç‰©å“"
    set ib_skillCustom[272] = 0
    set ib_skillList[273] = 'AIms'
    set ib_skillName[273] = "èƒ½æé«˜ç§»åŠ¨é€Ÿåº¦çš„ç‰©å“"
    set ib_skillCustom[273] = 0
    set ib_skillList[274] = 'AImt'
    set ib_skillName[274] = "ä¼ é€æƒæ–"
    set ib_skillCustom[274] = 0
    set ib_skillList[275] = 'AImv'
    set ib_skillName[275] = "èƒ½å¢åŠ é­”æ³•å€¼çš„ç‰©å“(75)"
    set ib_skillCustom[275] = 0
    set ib_skillList[276] = 'AImx'
    set ib_skillName[276] = "é­”æ³•å…ç–«"
    set ib_skillCustom[276] = 0
    set ib_skillList[277] = 'AImz'
    set ib_skillName[277] = "èƒ½å¢åŠ é­”æ³•å€¼çš„ç‰©å“(100)"
    set ib_skillCustom[277] = 0
    set ib_skillList[278] = 'AInd'
    set ib_skillName[278] = "é¼“èˆ"
    set ib_skillCustom[278] = 0
    set ib_skillList[279] = 'AInm'
    set ib_skillName[279] = "èƒ½å¢åŠ åŠ›é‡çš„ç‰©å“"
    set ib_skillCustom[279] = 0
    set ib_skillList[280] = 'AInv'
    set ib_skillName[280] = "ç‰©å“æ "
    set ib_skillCustom[280] = 0
    set ib_skillList[281] = 'AIob'
    set ib_skillName[281] = "å¸¦æœ‰éœœå†»æ”»å‡»æ•ˆæœçš„ç‰©å“"
    set ib_skillCustom[281] = 0
    set ib_skillList[282] = 'AIos'
    set ib_skillName[282] = "å‡é€Ÿ"
    set ib_skillCustom[282] = 0
    set ib_skillList[283] = 'AIp1'
    set ib_skillName[283] = "æ™®é€šç‰©å“-å›å¤æ•ˆæœ"
    set ib_skillCustom[283] = 0
    set ib_skillList[284] = 'AIp2'
    set ib_skillName[284] = "æ™®é€šç‰©å“-å›å¤æ•ˆæœ"
    set ib_skillCustom[284] = 0
    set ib_skillList[285] = 'AIp3'
    set ib_skillName[285] = "æ™®é€šç‰©å“-å›å¤æ•ˆæœ"
    set ib_skillCustom[285] = 0
    set ib_skillList[286] = 'AIp4'
    set ib_skillName[286] = "æ™®é€šç‰©å“-å›å¤æ•ˆæœ"
    set ib_skillCustom[286] = 0
    set ib_skillList[287] = 'AIp5'
    set ib_skillName[287] = "æ™®é€šç‰©å“-å›å¤æ•ˆæœ"
    set ib_skillCustom[287] = 0
    set ib_skillList[288] = 'AIp6'
    set ib_skillName[288] = "æ™®é€šç‰©å“-å›å¤æ•ˆæœ"
    set ib_skillCustom[288] = 0
    set ib_skillList[289] = 'AIpb'
    set ib_skillName[289] = "å¸¦æœ‰æ¯’è¯æ•ˆæœçš„ç‰©å“"
    set ib_skillCustom[289] = 0
    set ib_skillList[290] = 'AIpg'
    set ib_skillName[290] = "å¸¦æœ‰å‡€åŒ–æ•ˆæœçš„ç‰©å“"
    set ib_skillCustom[290] = 0
    set ib_skillList[291] = 'AIpl'
    set ib_skillName[291] = "å°å‡€åŒ–è¯æ°´"
    set ib_skillCustom[291] = 0
    set ib_skillList[292] = 'AIpm'
    set ib_skillName[292] = "èƒ½ç½®æ”¾åœ°ç²¾åœ°é›·çš„ç‰©å“"
    set ib_skillCustom[292] = 0
    set ib_skillList[293] = 'AIpr'
    set ib_skillName[293] = "å‡€åŒ–è¯æ°´"
    set ib_skillCustom[293] = 0
    set ib_skillList[294] = 'AIps'
    set ib_skillName[294] = "å¸¦æœ‰å‡€åŒ–æ•ˆæœçš„ç‰©å“"
    set ib_skillCustom[294] = 0
    set ib_skillList[295] = 'AIpv'
    set ib_skillName[295] = "å¸è¡€è¯æ°´"
    set ib_skillCustom[295] = 0
    set ib_skillList[296] = 'AIpx'
    set ib_skillName[296] = "èƒ½æ°¸ä¹…å¢åŠ ç”Ÿå‘½å€¼çš„ç‰©å“"
    set ib_skillCustom[296] = 0
    set ib_skillList[297] = 'AIpz'
    set ib_skillName[297] = "ä¼é¹…æ€ªå…½"
    set ib_skillCustom[297] = 0
    set ib_skillList[298] = 'AIra'
    set ib_skillName[298] = "èƒ½æé«˜ä¸€å®šèŒƒå›´å†…æ‰€æœ‰å•ä½é­”æ³•å€¼å’Œç”Ÿå‘½å€¼çš„ç‰©å“"
    set ib_skillCustom[298] = 0
    set ib_skillList[299] = 'AIrb'
    set ib_skillName[299] = "é‡ç”Ÿ"
    set ib_skillCustom[299] = 0
    set ib_skillList[300] = 'AIrc'
    set ib_skillName[300] = "å…·æœ‰é‡ç”Ÿæ•ˆæœçš„ç‰©å“"
    set ib_skillCustom[300] = 0
    set ib_skillList[301] = 'AIrd'
    set ib_skillName[301] = "å¤æ´»æ­»å°¸(ç‰©å“)"
    set ib_skillCustom[301] = 0
    set ib_skillList[302] = 'AIre'
    set ib_skillName[302] = "èƒ½è¿›è¡ŒåŒ»ç–—å’Œå¢åŠ é­”æ³•å€¼çš„å•ä½"
    set ib_skillCustom[302] = 0
    set ib_skillList[303] = 'AIri'
    set ib_skillName[303] = "éšæœºç‰©å“"
    set ib_skillCustom[303] = 0
    set ib_skillList[304] = 'AIrl'
    set ib_skillName[304] = "åŒ»ç–—å‰‚"
    set ib_skillCustom[304] = 0
    set ib_skillList[305] = 'AIrm'
    set ib_skillName[305] = "èƒ½å¢åŠ é­”æ³•æ¢å¤é€Ÿåº¦çš„ç‰©å“"
    set ib_skillCustom[305] = 0
    set ib_skillList[306] = 'AIrr'
    set ib_skillName[306] = "å’†å“®"
    set ib_skillCustom[306] = 0
    set ib_skillList[307] = 'AIrs'
    set ib_skillName[307] = "å…·æœ‰å¤æ´»æ•ˆæœçš„ç‰©å“"
    set ib_skillCustom[307] = 0
    set ib_skillList[308] = 'AIrt'
    set ib_skillName[308] = "å¬å”¤ç‰©å“"
    set ib_skillCustom[308] = 0
    set ib_skillList[309] = 'AIrv'
    set ib_skillName[309] = "èƒ½æ˜¾ç¤ºæ•´ä¸ªåœ°å›¾çš„ç‰©å“"
    set ib_skillCustom[309] = 0
    set ib_skillList[310] = 'AIrx'
    set ib_skillName[310] = "å…·æœ‰å¤æ´»æ•ˆæœçš„ç‰©å“"
    set ib_skillCustom[310] = 0
    set ib_skillList[311] = 'AIs1'
    set ib_skillName[311] = "èƒ½æé«˜è‹±é›„å±æ€§çš„ç‰©å“"
    set ib_skillCustom[311] = 0
    set ib_skillList[312] = 'AIs2'
    set ib_skillName[312] = "èƒ½æé«˜è¿›æ”»é€Ÿåº¦çš„ç‰©å“"
    set ib_skillCustom[312] = 0
    set ib_skillList[313] = 'AIs3'
    set ib_skillName[313] = "èƒ½æé«˜è‹±é›„å±æ€§çš„ç‰©å“"
    set ib_skillCustom[313] = 0
    set ib_skillList[314] = 'AIs4'
    set ib_skillName[314] = "èƒ½æé«˜è‹±é›„å±æ€§çš„ç‰©å“"
    set ib_skillCustom[314] = 0
    set ib_skillList[315] = 'AIs6'
    set ib_skillName[315] = "èƒ½æé«˜è‹±é›„å±æ€§çš„ç‰©å“"
    set ib_skillCustom[315] = 0
    set ib_skillList[316] = 'AIsa'
    set ib_skillName[316] = "åŠ é€Ÿå·è½´"
    set ib_skillCustom[316] = 0
    set ib_skillList[317] = 'AIsb'
    set ib_skillName[317] = "å‡é€Ÿä¹‹çƒ"
    set ib_skillCustom[317] = 0
    set ib_skillList[318] = 'AIse'
    set ib_skillName[318] = "ç‰©å“æ²‰é»˜"
    set ib_skillCustom[318] = 0
    set ib_skillList[319] = 'AIsh'
    set ib_skillName[319] = "å¬å”¤å·¨é­”çŒå¤´è€…"
    set ib_skillCustom[319] = 0
endfunction
function IB_SkillFill4 takes nothing returns nothing
    set ib_skillList[320] = 'AIsi'
    set ib_skillName[320] = "èƒ½æé«˜è§†é‡èŒƒå›´çš„ç‰©å“"
    set ib_skillCustom[320] = 0
    set ib_skillList[321] = 'AIsl'
    set ib_skillName[321] = "æ¢å¤å·è½´"
    set ib_skillCustom[321] = 0
    set ib_skillList[322] = 'AIsm'
    set ib_skillName[322] = "èƒ½å¢åŠ åŠ›é‡çš„ç‰©å“"
    set ib_skillCustom[322] = 0
    set ib_skillList[323] = 'AIso'
    set ib_skillName[323] = "èƒ½ç›—å–å•ä½çµé­‚çš„ç‰©å“"
    set ib_skillCustom[323] = 0
    set ib_skillList[324] = 'AIsp'
    set ib_skillName[324] = "èƒ½æš‚æ—¶åŠ å¿«ç§»åŠ¨é€Ÿåº¦çš„ç‰©å“"
    set ib_skillCustom[324] = 0
    set ib_skillList[325] = 'AIsr'
    set ib_skillName[325] = "é­”æ³•ä¼¤å®³å‡å°‘"
    set ib_skillCustom[325] = 0
    set ib_skillList[326] = 'AIsw'
    set ib_skillName[326] = "å²—å“¨å®ˆå«"
    set ib_skillCustom[326] = 0
    set ib_skillList[327] = 'AIsx'
    set ib_skillName[327] = "èƒ½æé«˜æ”»å‡»é€Ÿåº¦çš„ç‰©å“"
    set ib_skillCustom[327] = 0
    set ib_skillList[328] = 'AIsz'
    set ib_skillName[328] = "æ…¢æ€§æ¯’è¯"
    set ib_skillCustom[328] = 0
    set ib_skillList[329] = 'AIt6'
    set ib_skillName[329] = "å¢åŠ æ”»å‡»åŠ›çš„ç‰©å“"
    set ib_skillCustom[329] = 0
    set ib_skillList[330] = 'AIt9'
    set ib_skillName[330] = "å¢åŠ æ”»å‡»åŠ›çš„ç‰©å“"
    set ib_skillCustom[330] = 0
    set ib_skillList[331] = 'AIta'
    set ib_skillName[331] = "èƒ½æ¢æµ‹ä¸€å®šåŒºåŸŸçš„ç‰©å“"
    set ib_skillCustom[331] = 0
    set ib_skillList[332] = 'AItb'
    set ib_skillName[332] = "å°˜åœŸä¹‹å½±"
    set ib_skillCustom[332] = 0
    set ib_skillList[333] = 'AItc'
    set ib_skillName[333] = "å¢åŠ æ”»å‡»åŠ›çš„ç‰©å“"
    set ib_skillCustom[333] = 0
    set ib_skillList[334] = 'AItf'
    set ib_skillName[334] = "å¢åŠ æ”»å‡»åŠ›çš„ç‰©å“"
    set ib_skillCustom[334] = 0
    set ib_skillList[335] = 'AItg'
    set ib_skillName[335] = "å¢åŠ æ”»å‡»åŠ›çš„ç‰©å“"
    set ib_skillCustom[335] = 0
    set ib_skillList[336] = 'AIth'
    set ib_skillName[336] = "å¢åŠ æ”»å‡»åŠ›çš„ç‰©å“"
    set ib_skillCustom[336] = 0
    set ib_skillList[337] = 'AIti'
    set ib_skillName[337] = "å¢åŠ æ”»å‡»åŠ›çš„ç‰©å“"
    set ib_skillCustom[337] = 0
    set ib_skillList[338] = 'AItj'
    set ib_skillName[338] = "å¢åŠ æ”»å‡»åŠ›çš„ç‰©å“"
    set ib_skillCustom[338] = 0
    set ib_skillList[339] = 'AItk'
    set ib_skillName[339] = "å¢åŠ æ”»å‡»åŠ›çš„ç‰©å“"
    set ib_skillCustom[339] = 0
    set ib_skillList[340] = 'AItl'
    set ib_skillName[340] = "å¢åŠ æ”»å‡»åŠ›çš„ç‰©å“"
    set ib_skillCustom[340] = 0
    set ib_skillList[341] = 'AItm'
    set ib_skillName[341] = "èƒ½æé«˜æ™ºåŠ›çš„ç‰©å“"
    set ib_skillCustom[341] = 0
    set ib_skillList[342] = 'AItn'
    set ib_skillName[342] = "å¢åŠ æ”»å‡»åŠ›çš„ç‰©å“"
    set ib_skillCustom[342] = 0
    set ib_skillList[343] = 'AItp'
    set ib_skillName[343] = "å›åŸå·è½´ç‰©å“"
    set ib_skillCustom[343] = 0
    set ib_skillList[344] = 'AItx'
    set ib_skillName[344] = "å¢åŠ æ”»å‡»åŠ›çš„ç‰©å“"
    set ib_skillCustom[344] = 0
    set ib_skillList[345] = 'AIuf'
    set ib_skillName[345] = "é‚ªæ¶ç‹‚çƒ­"
    set ib_skillCustom[345] = 0
    set ib_skillList[346] = 'AIuv'
    set ib_skillName[346] = "å¤œè§†èƒ½åŠ›"
    set ib_skillCustom[346] = 0
    set ib_skillList[347] = 'AIuw'
    set ib_skillName[347] = "èƒ½å¬å”¤ç†Šæ€ªæˆ˜å£«çš„ç‰©å“"
    set ib_skillCustom[347] = 0
    set ib_skillList[348] = 'AIv1'
    set ib_skillName[348] = "èƒ½è®©å•ä½æš‚æ—¶éšèº«çš„ç‰©å“"
    set ib_skillCustom[348] = 0
    set ib_skillList[349] = 'AIv2'
    set ib_skillName[349] = "èƒ½è®©å•ä½æš‚æ—¶éšèº«çš„ç‰©å“"
    set ib_skillCustom[349] = 0
    set ib_skillList[350] = 'AIva'
    set ib_skillName[350] = "èƒ½ç›—å–ç”Ÿå‘½å€¼çš„ç‰©å“"
    set ib_skillCustom[350] = 0
    set ib_skillList[351] = 'AIvi'
    set ib_skillName[351] = "èƒ½è®©å•ä½æš‚æ—¶éšèº«çš„ç‰©å“"
    set ib_skillCustom[351] = 0
    set ib_skillList[352] = 'AIvl'
    set ib_skillName[352] = "èƒ½è®©å•ä½æš‚æ—¶æ— æ•Œçš„ç‰©å“"
    set ib_skillCustom[352] = 0
    set ib_skillList[353] = 'AIvu'
    set ib_skillName[353] = "èƒ½è®©å•ä½æš‚æ—¶æ— æ•Œçš„ç‰©å“"
    set ib_skillCustom[353] = 0
    set ib_skillList[354] = 'AIwb'
    set ib_skillName[354] = "å¸¦æœ‰è››ç½‘æŠ€èƒ½çš„ç‰©å“"
    set ib_skillCustom[354] = 0
    set ib_skillList[355] = 'AIwm'
    set ib_skillName[355] = "æ°´å¥´"
    set ib_skillCustom[355] = 0
    set ib_skillList[356] = 'AIx1'
    set ib_skillName[356] = "èƒ½æé«˜è‹±é›„å±æ€§çš„ç‰©å“"
    set ib_skillCustom[356] = 0
    set ib_skillList[357] = 'AIx2'
    set ib_skillName[357] = "èƒ½æé«˜è‹±é›„å±æ€§çš„ç‰©å“"
    set ib_skillCustom[357] = 0
    set ib_skillList[358] = 'AIx5'
    set ib_skillName[358] = "èƒ½æé«˜è‹±é›„å±æ€§çš„ç‰©å“"
    set ib_skillCustom[358] = 0
    set ib_skillList[359] = 'AIxk'
    set ib_skillName[359] = "ç‹‚æš´æ„¤æ€’"
    set ib_skillCustom[359] = 0
    set ib_skillList[360] = 'AIxm'
    set ib_skillName[360] = "èƒ½æé«˜è‹±é›„ä¸‰ä¸ªå±æ€§çš„ç‰©å“"
    set ib_skillCustom[360] = 0
    set ib_skillList[361] = 'AIxs'
    set ib_skillName[361] = "å…·æœ‰åé­”æ³•ç›¾çš„ç‰©å“"
    set ib_skillCustom[361] = 0
    set ib_skillList[362] = 'AIzb'
    set ib_skillName[362] = "å¸¦æœ‰å†°å†»æ”»å‡»ä¼¤å®³çš„ç‰©å“"
    set ib_skillCustom[362] = 0
    set ib_skillList[363] = 'ANab'
    set ib_skillName[363] = "é…¸æ€§ç‚¸å¼¹"
    set ib_skillCustom[363] = 0
    set ib_skillList[364] = 'ANak'
    set ib_skillName[364] = "åˆšæ¯›é£å°„"
    set ib_skillCustom[364] = 0
    set ib_skillList[365] = 'ANav'
    set ib_skillName[365] = "å¤©ç¥ä¸‹å‡¡"
    set ib_skillCustom[365] = 0
    set ib_skillList[366] = 'ANb2'
    set ib_skillName[366] = "é‡å‡»"
    set ib_skillCustom[366] = 0
    set ib_skillList[367] = 'ANba'
    set ib_skillName[367] = "é»‘æš—ä¹‹ç®­"
    set ib_skillCustom[367] = 0
    set ib_skillList[368] = 'ANbf'
    set ib_skillName[368] = "ç«ç„°å‘¼å¸"
    set ib_skillCustom[368] = 0
    set ib_skillList[369] = 'ANbh'
    set ib_skillName[369] = "é‡å‡»"
    set ib_skillCustom[369] = 0
    set ib_skillList[370] = 'ANbl'
    set ib_skillName[370] = "é—ªçƒ"
    set ib_skillCustom[370] = 0
    set ib_skillList[371] = 'ANbr'
    set ib_skillName[371] = "æˆ˜äº‰å’†å“®"
    set ib_skillCustom[371] = 0
    set ib_skillList[372] = 'ANbs'
    set ib_skillName[372] = "é»‘æš—ä¹‹çƒ"
    set ib_skillCustom[372] = 0
    set ib_skillList[373] = 'ANbu'
    set ib_skillName[373] = "å»ºé€ (ä¸­ç«‹)"
    set ib_skillCustom[373] = 0
    set ib_skillList[374] = 'ANc1'
    set ib_skillName[374] = "ç«ç®­ç¾¤"
    set ib_skillCustom[374] = 0
    set ib_skillList[375] = 'ANc2'
    set ib_skillName[375] = "ç«ç®­ç¾¤"
    set ib_skillCustom[375] = 0
    set ib_skillList[376] = 'ANc3'
    set ib_skillName[376] = "ç«ç®­ç¾¤"
    set ib_skillCustom[376] = 0
    set ib_skillList[377] = 'ANca'
    set ib_skillName[377] = "åˆ†è£‚æ”»å‡»"
    set ib_skillCustom[377] = 0
    set ib_skillList[378] = 'ANcf'
    set ib_skillName[378] = "ç«ç„°å‘¼å¸"
    set ib_skillCustom[378] = 0
    set ib_skillList[379] = 'ANch'
    set ib_skillName[379] = "ç¬¦å’’"
    set ib_skillCustom[379] = 0
    set ib_skillList[380] = 'ANcl'
    set ib_skillName[380] = "é€šé­”"
    set ib_skillCustom[380] = 0
    set ib_skillList[381] = 'ANcr'
    set ib_skillName[381] = "åŒ–å­¦é£æš´"
    set ib_skillCustom[381] = 0
    set ib_skillList[382] = 'ANcs'
    set ib_skillName[382] = "ç«ç®­ç¾¤"
    set ib_skillCustom[382] = 0
    set ib_skillList[383] = 'ANd1'
    set ib_skillName[383] = "ç²‰ç¢"
    set ib_skillCustom[383] = 0
    set ib_skillList[384] = 'ANd2'
    set ib_skillName[384] = "ç²‰ç¢"
    set ib_skillCustom[384] = 0
    set ib_skillList[385] = 'ANd3'
    set ib_skillName[385] = "ç²‰ç¢"
    set ib_skillCustom[385] = 0
    set ib_skillList[386] = 'ANdb'
    set ib_skillName[386] = "é†‰æ‹³"
    set ib_skillCustom[386] = 0
    set ib_skillList[387] = 'ANdc'
    set ib_skillName[387] = "é»‘æš—è½¬æ¢"
    set ib_skillCustom[387] = 0
    set ib_skillList[388] = 'ANde'
    set ib_skillName[388] = "ç²‰ç¢"
    set ib_skillCustom[388] = 0
    set ib_skillList[389] = 'ANdh'
    set ib_skillName[389] = "é†‰é…’äº‘é›¾"
    set ib_skillCustom[389] = 0
    set ib_skillList[390] = 'ANdo'
    set ib_skillName[390] = "æœ«æ—¥å®¡åˆ¤"
    set ib_skillCustom[390] = 0
    set ib_skillList[391] = 'ANdp'
    set ib_skillName[391] = "é»‘æš—ä¹‹é—¨"
    set ib_skillCustom[391] = 0
    set ib_skillList[392] = 'ANdr'
    set ib_skillName[392] = "ç”Ÿå‘½æ±²å–"
    set ib_skillCustom[392] = 0
    set ib_skillList[393] = 'ANef'
    set ib_skillName[393] = "\"ç«åœŸé£æš´\""
    set ib_skillCustom[393] = 0
    set ib_skillList[394] = 'ANeg'
    set ib_skillName[394] = "å·¥ç¨‹å‡çº§"
    set ib_skillCustom[394] = 0
    set ib_skillList[395] = 'ANen'
    set ib_skillName[395] = "è¯±æ•"
    set ib_skillCustom[395] = 0
    set ib_skillList[396] = 'ANf1'
    set ib_skillName[396] = "å·¥å‚"
    set ib_skillCustom[396] = 0
    set ib_skillList[397] = 'ANf2'
    set ib_skillName[397] = "å·¥å‚"
    set ib_skillCustom[397] = 0
    set ib_skillList[398] = 'ANf3'
    set ib_skillName[398] = "å·¥å‚"
    set ib_skillCustom[398] = 0
    set ib_skillList[399] = 'ANfa'
    set ib_skillName[399] = "éœœå†»ä¹‹ç®­"
    set ib_skillCustom[399] = 0
endfunction
function IB_SkillFill5 takes nothing returns nothing
    set ib_skillList[400] = 'ANfb'
    set ib_skillName[400] = "éœ¹é›³é—ªç”µ"
    set ib_skillCustom[400] = 0
    set ib_skillList[401] = 'ANfd'
    set ib_skillName[401] = "æ­»äº¡ä¹‹æŒ‡"
    set ib_skillCustom[401] = 0
    set ib_skillList[402] = 'ANfl'
    set ib_skillName[402] = "å‰çŠ¶é—ªç”µ"
    set ib_skillCustom[402] = 0
    set ib_skillList[403] = 'ANfs'
    set ib_skillName[403] = "çƒˆç„°é£æš´"
    set ib_skillCustom[403] = 0
    set ib_skillList[404] = 'ANfy'
    set ib_skillName[404] = "å·¥å‚"
    set ib_skillCustom[404] = 0
    set ib_skillList[405] = 'ANg1'
    set ib_skillName[405] = "æœºå™¨äººåœ°ç²¾"
    set ib_skillCustom[405] = 0
    set ib_skillList[406] = 'ANg2'
    set ib_skillName[406] = "æœºå™¨äººåœ°ç²¾"
    set ib_skillCustom[406] = 0
    set ib_skillList[407] = 'ANg3'
    set ib_skillName[407] = "æœºå™¨äººåœ°ç²¾"
    set ib_skillCustom[407] = 0
    set ib_skillList[408] = 'ANgl'
    set ib_skillName[408] = "ç”¨é»„é‡‘äº¤æ¢æœ¨æ"
    set ib_skillCustom[408] = 0
    set ib_skillList[409] = 'ANha'
    set ib_skillName[409] = "é‡‡é›†"
    set ib_skillCustom[409] = 0
    set ib_skillList[410] = 'ANhs'
    set ib_skillName[410] = "åŒ»ç–—æ°”é›¾"
    set ib_skillCustom[410] = 0
    set ib_skillList[411] = 'ANht'
    set ib_skillName[411] = "ææ€–åšå«"
    set ib_skillCustom[411] = 0
    set ib_skillList[412] = 'ANhw'
    set ib_skillName[412] = "åŒ»ç–—æ³¢"
    set ib_skillCustom[412] = 0
    set ib_skillList[413] = 'ANhx'
    set ib_skillName[413] = "å¦–æœ¯"
    set ib_skillCustom[413] = 0
    set ib_skillList[414] = 'ANia'
    set ib_skillName[414] = "ç‡ƒç°"
    set ib_skillCustom[414] = 0
    set ib_skillList[415] = 'ANic'
    set ib_skillName[415] = "ç‡ƒç°"
    set ib_skillCustom[415] = 0
    set ib_skillList[416] = 'ANin'
    set ib_skillName[416] = "åœ°ç‹±ç«"
    set ib_skillCustom[416] = 0
    set ib_skillList[417] = 'ANlg'
    set ib_skillName[417] = "ç”¨æœ¨æäº¤æ¢é»„é‡‘"
    set ib_skillCustom[417] = 0
    set ib_skillList[418] = 'ANlm'
    set ib_skillName[418] = "å¬å”¤ç‚é­”"
    set ib_skillCustom[418] = 0
    set ib_skillList[419] = 'ANmo'
    set ib_skillName[419] = "å­£é£"
    set ib_skillCustom[419] = 0
    set ib_skillList[420] = 'ANmr'
    set ib_skillName[420] = "å¿ƒçµè…çƒ‚"
    set ib_skillCustom[420] = 0
    set ib_skillList[421] = 'ANms'
    set ib_skillName[421] = "é­”æ³•æŠ¤ç›¾"
    set ib_skillCustom[421] = 0
    set ib_skillList[422] = 'ANpa'
    set ib_skillName[422] = "å¯„ç”Ÿè™«"
    set ib_skillCustom[422] = 0
    set ib_skillList[423] = 'ANpi'
    set ib_skillName[423] = "æ°¸ä¹…çš„çŒ®ç¥­"
    set ib_skillCustom[423] = 0
    set ib_skillList[424] = 'ANpr'
    set ib_skillName[424] = "ä¿å­˜æƒæ–"
    set ib_skillCustom[424] = 0
    set ib_skillList[425] = 'ANr2'
    set ib_skillName[425] = "é‡ç”Ÿ"
    set ib_skillCustom[425] = 0
    set ib_skillList[426] = 'ANr3'
    set ib_skillName[426] = "æ··ä¹±ä¹‹é›¨"
    set ib_skillCustom[426] = 0
    set ib_skillList[427] = 'ANrc'
    set ib_skillName[427] = "æ··ä¹±ä¹‹é›¨"
    set ib_skillCustom[427] = 0
    set ib_skillList[428] = 'ANre'
    set ib_skillName[428] = "é­”æ³•æ¢å¤å…‰ç¯"
    set ib_skillCustom[428] = 0
    set ib_skillList[429] = 'ANrf'
    set ib_skillName[429] = "ç«ç„°é›¨"
    set ib_skillCustom[429] = 0
    set ib_skillList[430] = 'ANrg'
    set ib_skillName[430] = "æœºå™¨äººåœ°ç²¾"
    set ib_skillCustom[430] = 0
    set ib_skillList[431] = 'ANrl'
    set ib_skillName[431] = "ç”Ÿå‘½å€¼æ¢å¤é€Ÿåº¦"
    set ib_skillCustom[431] = 0
    set ib_skillList[432] = 'ANrn'
    set ib_skillName[432] = "é‡ç”Ÿ"
    set ib_skillCustom[432] = 0
    set ib_skillList[433] = 'ANs1'
    set ib_skillName[433] = "å£è¢‹å·¥å‚"
    set ib_skillCustom[433] = 0
    set ib_skillList[434] = 'ANs2'
    set ib_skillName[434] = "å£è¢‹å·¥å‚"
    set ib_skillCustom[434] = 0
    set ib_skillList[435] = 'ANs3'
    set ib_skillName[435] = "å£è¢‹å·¥å‚"
    set ib_skillCustom[435] = 0
    set ib_skillList[436] = 'ANsa'
    set ib_skillName[436] = "é¿éš¾æƒæ–"
    set ib_skillCustom[436] = 0
    set ib_skillList[437] = 'ANsb'
    set ib_skillName[437] = "é£æš´ä¹‹é”¤"
    set ib_skillCustom[437] = 0
    set ib_skillList[438] = 'ANse'
    set ib_skillName[438] = "é­”æ³•æŠ¤ç›¾"
    set ib_skillCustom[438] = 0
    set ib_skillList[439] = 'ANsg'
    set ib_skillName[439] = "å¬å”¤ç†Š"
    set ib_skillCustom[439] = 0
    set ib_skillList[440] = 'ANsh'
    set ib_skillName[440] = "éœ‡è¡æ³¢"
    set ib_skillCustom[440] = 0
    set ib_skillList[441] = 'ANsi'
    set ib_skillName[441] = "æ²‰é»˜é­”æ³•"
    set ib_skillCustom[441] = 0
    set ib_skillList[442] = 'ANsl'
    set ib_skillName[442] = "çµé­‚ä¿å­˜"
    set ib_skillCustom[442] = 0
    set ib_skillList[443] = 'ANso'
    set ib_skillName[443] = "çµé­‚ç‡ƒçƒ§"
    set ib_skillCustom[443] = 0
    set ib_skillList[444] = 'ANsp'
    set ib_skillName[444] = "é—´è°"
    set ib_skillCustom[444] = 0
    set ib_skillList[445] = 'ANsq'
    set ib_skillName[445] = "å¬å”¤è±ªçŒª"
    set ib_skillCustom[445] = 0
    set ib_skillList[446] = 'ANss'
    set ib_skillName[446] = "é­”æ³•æŠ¤ç›¾"
    set ib_skillCustom[446] = 0
    set ib_skillList[447] = 'ANst'
    set ib_skillName[447] = "æƒŠå“"
    set ib_skillCustom[447] = 0
    set ib_skillList[448] = 'ANsw'
    set ib_skillName[448] = "å¬å”¤æˆ˜é¹°"
    set ib_skillCustom[448] = 0
    set ib_skillList[449] = 'ANsy'
    set ib_skillName[449] = "å£è¢‹å·¥å‚"
    set ib_skillCustom[449] = 0
    set ib_skillList[450] = 'ANt2'
    set ib_skillName[450] = "å°–åˆºå¤–å£³"
    set ib_skillCustom[450] = 0
    set ib_skillList[451] = 'ANta'
    set ib_skillName[451] = "å˜²è®½"
    set ib_skillCustom[451] = 0
    set ib_skillList[452] = 'ANth'
    set ib_skillName[452] = "å°–åˆºå¤–å£³"
    set ib_skillCustom[452] = 0
    set ib_skillList[453] = 'ANtm'
    set ib_skillName[453] = "ç‚¹é‡‘æœ¯"
    set ib_skillCustom[453] = 0
    set ib_skillList[454] = 'ANto'
    set ib_skillName[454] = "é¾™å·é£"
    set ib_skillCustom[454] = 0
    set ib_skillList[455] = 'ANtr'
    set ib_skillName[455] = "çœŸå®è§†åŸŸ"
    set ib_skillCustom[455] = 0
    set ib_skillList[456] = 'ANvc'
    set ib_skillName[456] = "ç«å±±çˆ†å‘"
    set ib_skillCustom[456] = 0
    set ib_skillList[457] = 'ANwk'
    set ib_skillName[457] = "ç–¾é£æ­¥"
    set ib_skillCustom[457] = 0
    set ib_skillList[458] = 'ANwm'
    set ib_skillName[458] = "æ°´å¥´"
    set ib_skillCustom[458] = 0
    set ib_skillList[459] = 'AOac'
    set ib_skillName[459] = "å‘½ä»¤å…‰ç¯"
    set ib_skillCustom[459] = 0
    set ib_skillList[460] = 'AOae'
    set ib_skillName[460] = "è€ä¹…å…‰ç¯"
    set ib_skillCustom[460] = 0
    set ib_skillList[461] = 'AObu'
    set ib_skillName[461] = "å»ºé€ (å…½æ—)"
    set ib_skillCustom[461] = 0
    set ib_skillList[462] = 'AOcl'
    set ib_skillName[462] = "é—ªç”µé“¾"
    set ib_skillCustom[462] = 0
    set ib_skillList[463] = 'AOcr'
    set ib_skillName[463] = "è‡´å‘½ä¸€å‡»"
    set ib_skillCustom[463] = 0
    set ib_skillList[464] = 'AOeq'
    set ib_skillName[464] = "åœ°éœ‡"
    set ib_skillCustom[464] = 0
    set ib_skillList[465] = 'AOfs'
    set ib_skillName[465] = "é€è§†"
    set ib_skillCustom[465] = 0
    set ib_skillList[466] = 'AOhw'
    set ib_skillName[466] = "åŒ»ç–—æ³¢"
    set ib_skillCustom[466] = 0
    set ib_skillList[467] = 'AOhx'
    set ib_skillName[467] = "å¦–æœ¯"
    set ib_skillCustom[467] = 0
    set ib_skillList[468] = 'AOls'
    set ib_skillName[468] = "å·«æ¯’å¹½é­‚"
    set ib_skillCustom[468] = 0
    set ib_skillList[469] = 'AOmi'
    set ib_skillName[469] = "é•œåƒ"
    set ib_skillCustom[469] = 0
    set ib_skillList[470] = 'AOr2'
    set ib_skillName[470] = "è€ä¹…å…‰ç¯"
    set ib_skillCustom[470] = 0
    set ib_skillList[471] = 'AOr3'
    set ib_skillName[471] = "é‡ç”Ÿ"
    set ib_skillCustom[471] = 0
    set ib_skillList[472] = 'AOre'
    set ib_skillName[472] = "é‡ç”Ÿ"
    set ib_skillCustom[472] = 0
    set ib_skillList[473] = 'AOs2'
    set ib_skillName[473] = "éœ‡è¡æ³¢"
    set ib_skillCustom[473] = 0
    set ib_skillList[474] = 'AOsf'
    set ib_skillName[474] = "é‡å…½å¹½é­‚"
    set ib_skillCustom[474] = 0
    set ib_skillList[475] = 'AOsh'
    set ib_skillName[475] = "éœ‡è¡æ³¢"
    set ib_skillCustom[475] = 0
    set ib_skillList[476] = 'AOsw'
    set ib_skillName[476] = "æ¯’è›‡å®ˆå«"
    set ib_skillCustom[476] = 0
    set ib_skillList[477] = 'AOvd'
    set ib_skillName[477] = "å·«æ¯’"
    set ib_skillCustom[477] = 0
    set ib_skillList[478] = 'AOw2'
    set ib_skillName[478] = "æˆ˜äº‰è·µè¸"
    set ib_skillCustom[478] = 0
    set ib_skillList[479] = 'AOwk'
    set ib_skillName[479] = "ç–¾æ­¥é£"
    set ib_skillCustom[479] = 0
endfunction
function IB_SkillFill6 takes nothing returns nothing
    set ib_skillList[480] = 'AOws'
    set ib_skillName[480] = "æˆ˜äº‰è·µè¸"
    set ib_skillCustom[480] = 0
    set ib_skillList[481] = 'AOww'
    set ib_skillName[481] = "å‰‘åˆƒé£æš´"
    set ib_skillCustom[481] = 0
    set ib_skillList[482] = 'APdi'
    set ib_skillName[482] = "åŠ›é‡ä¸Šå‡é©±æ•£"
    set ib_skillCustom[482] = 0
    set ib_skillList[483] = 'APh1'
    set ib_skillName[483] = "åŠ›é‡ä¸Šå‡æ²»ç–—åŒºåŸŸå‡å°"
    set ib_skillCustom[483] = 0
    set ib_skillList[484] = 'APh2'
    set ib_skillName[484] = "åŠ›é‡ä¸Šå‡æ²»ç–—åŒºåŸŸ"
    set ib_skillCustom[484] = 0
    set ib_skillList[485] = 'APh3'
    set ib_skillName[485] = "åŠ›é‡ä¸Šå‡æ²»ç–—åŒºåŸŸå¢å¼º"
    set ib_skillCustom[485] = 0
    set ib_skillList[486] = 'APmg'
    set ib_skillName[486] = "ç¥ç§˜åŒºåŸŸé­”æ³•æ¢å¤å¢å¼º"
    set ib_skillCustom[486] = 0
    set ib_skillList[487] = 'APmr'
    set ib_skillName[487] = "ç¥ç§˜åŒºåŸŸé­”æ³•æ¢å¤"
    set ib_skillCustom[487] = 0
    set ib_skillList[488] = 'APra'
    set ib_skillName[488] = "ç¥ç§˜åŒºåŸŸç”Ÿå‘½/é­”æ³•æ¢å¤"
    set ib_skillCustom[488] = 0
    set ib_skillList[489] = 'APrl'
    set ib_skillName[489] = "å°å‹å¤æ´»ç¥ç¬¦"
    set ib_skillCustom[489] = 0
    set ib_skillList[490] = 'APrr'
    set ib_skillName[490] = "å¤§å‹å¤æ´»ç¥ç¬¦"
    set ib_skillCustom[490] = 0
    set ib_skillList[491] = 'APsa'
    set ib_skillName[491] = "é€Ÿåº¦ç¥ç¬¦"
    set ib_skillCustom[491] = 0
    set ib_skillList[492] = 'APwt'
    set ib_skillName[492] = "å²—å“¨ç¥ç¬¦"
    set ib_skillCustom[492] = 0
    set ib_skillList[493] = 'ARal'
    set ib_skillName[493] = "é›†ç»“"
    set ib_skillCustom[493] = 0
    set ib_skillList[494] = 'AUan'
    set ib_skillName[494] = "æ“çºµæ­»å°¸"
    set ib_skillCustom[494] = 0
    set ib_skillList[495] = 'AUau'
    set ib_skillName[495] = "é‚ªæ¶å…‰ç¯"
    set ib_skillCustom[495] = 0
    set ib_skillList[496] = 'AUav'
    set ib_skillName[496] = "å¸è¡€å…‰ç¯"
    set ib_skillCustom[496] = 0
    set ib_skillList[497] = 'AUbu'
    set ib_skillName[497] = "å»ºé€ (ä¸æ­»æ—)"
    set ib_skillCustom[497] = 0
    set ib_skillList[498] = 'AUcb'
    set ib_skillName[498] = "è…å°¸ç”²è™«"
    set ib_skillCustom[498] = 0
    set ib_skillList[499] = 'AUcs'
    set ib_skillName[499] = "è…è‡­èœ‚ç¾¤"
    set ib_skillCustom[499] = 0
    set ib_skillList[500] = 'AUdc'
    set ib_skillName[500] = "æ­»äº¡ç¼ ç»•"
    set ib_skillCustom[500] = 0
    set ib_skillList[501] = 'AUdd'
    set ib_skillName[501] = "æ­»äº¡å‡‹é›¶"
    set ib_skillCustom[501] = 0
    set ib_skillList[502] = 'AUdp'
    set ib_skillName[502] = "æ­»äº¡å¥‘çº¦"
    set ib_skillCustom[502] = 0
    set ib_skillList[503] = 'AUdr'
    set ib_skillName[503] = "é»‘æš—ä»ªå¼"
    set ib_skillCustom[503] = 0
    set ib_skillList[504] = 'AUds'
    set ib_skillName[504] = "é»‘æš—å¬å”¤"
    set ib_skillCustom[504] = 0
    set ib_skillList[505] = 'AUfa'
    set ib_skillName[505] = "éœœå†»æŠ¤ç”²"
    set ib_skillCustom[505] = 0
    set ib_skillList[506] = 'AUfn'
    set ib_skillName[506] = "éœœå†»æ–°æ˜Ÿ"
    set ib_skillCustom[506] = 0
    set ib_skillList[507] = 'AUfu'
    set ib_skillName[507] = "éœœå†»æŠ¤ç”²"
    set ib_skillCustom[507] = 0
    set ib_skillList[508] = 'AUim'
    set ib_skillName[508] = "ç©¿åˆº"
    set ib_skillCustom[508] = 0
    set ib_skillList[509] = 'AUin'
    set ib_skillName[509] = "åœ°ç‹±ç«"
    set ib_skillCustom[509] = 0
    set ib_skillList[510] = 'AUls'
    set ib_skillName[510] = "è—è™«ç¾¤"
    set ib_skillCustom[510] = 0
    set ib_skillList[511] = 'AUmd'
    set ib_skillName[511] = "é»‘æš—å¬å”¤(é©¬å“¥å°¼æ–¯)"
    set ib_skillCustom[511] = 0
    set ib_skillList[512] = 'AUsl'
    set ib_skillName[512] = "ç¡çœ "
    set ib_skillCustom[512] = 0
    set ib_skillList[513] = 'AUts'
    set ib_skillName[513] = "å°–åˆºå¤–å£³"
    set ib_skillCustom[513] = 0
    set ib_skillList[514] = 'Aabr'
    set ib_skillName[514] = "è’èŠœå…‰ç¯"
    set ib_skillCustom[514] = 0
    set ib_skillList[515] = 'Aabs'
    set ib_skillName[515] = "å¸æ”¶é­”æ³•"
    set ib_skillCustom[515] = 0
    set ib_skillList[516] = 'Aadm'
    set ib_skillName[516] = "é©±é€é­”æ³•"
    set ib_skillCustom[516] = 0
    set ib_skillList[517] = 'Aaha'
    set ib_skillName[517] = "é‡‡é›†"
    set ib_skillCustom[517] = 0
    set ib_skillList[518] = 'Aakb'
    set ib_skillName[518] = "æˆ˜é¼“"
    set ib_skillCustom[518] = 0
    set ib_skillList[519] = 'Aall'
    set ib_skillName[519] = "å…±äº«å•†åº—ï¼Œè”ç›Ÿå»ºç­‘ç‰©"
    set ib_skillCustom[519] = 0
    set ib_skillList[520] = 'Aalr'
    set ib_skillName[520] = "è­¦æŠ¥"
    set ib_skillCustom[520] = 0
    set ib_skillList[521] = 'Aam2'
    set ib_skillName[521] = "åé­”æ³•å¤–å£³"
    set ib_skillCustom[521] = 0
    set ib_skillList[522] = 'Aami'
    set ib_skillName[522] = "å…·æœ‰åé­”æ³•ç›¾çš„ç‰©å“"
    set ib_skillCustom[522] = 0
    set ib_skillList[523] = 'Aamk'
    set ib_skillName[523] = "å±æ€§é™„åŠ "
    set ib_skillCustom[523] = 0
    set ib_skillList[524] = 'Aams'
    set ib_skillName[524] = "åé­”æ³•å¤–å£³"
    set ib_skillCustom[524] = 0
    set ib_skillList[525] = 'Aap1'
    set ib_skillName[525] = "ç–¾ç—…äº‘é›¾"
    set ib_skillCustom[525] = 0
    set ib_skillList[526] = 'Aap2'
    set ib_skillName[526] = "ç–¾ç—…äº‘é›¾"
    set ib_skillCustom[526] = 0
    set ib_skillList[527] = 'Aap3'
    set ib_skillName[527] = "ç–¾ç—…äº‘é›¾"
    set ib_skillCustom[527] = 0
    set ib_skillList[528] = 'Aap4'
    set ib_skillName[528] = "ç–¾ç—…äº‘é›¾"
    set ib_skillCustom[528] = 0
    set ib_skillList[529] = 'Aapl'
    set ib_skillName[529] = "ç–¾ç—…äº‘é›¾"
    set ib_skillCustom[529] = 0
    set ib_skillList[530] = 'Aarm'
    set ib_skillName[530] = "é­”æ³•æ¢å¤å…‰ç¯"
    set ib_skillCustom[530] = 0
    set ib_skillList[531] = 'Aasl'
    set ib_skillName[531] = "å‡é€Ÿå…‰ç¯"
    set ib_skillCustom[531] = 0
    set ib_skillList[532] = 'Aast'
    set ib_skillName[532] = "å…ˆç¥–å¹½çµ"
    set ib_skillCustom[532] = 0
    set ib_skillList[533] = 'Aatk'
    set ib_skillName[533] = "æ”»å‡»"
    set ib_skillCustom[533] = 0
    set ib_skillList[534] = 'Aave'
    set ib_skillName[534] = "ç ´åè€…å½¢æ€"
    set ib_skillCustom[534] = 0
    set ib_skillList[535] = 'Aawa'
    set ib_skillName[535] = "ç«‹åˆ»å¤æ´»è‹±é›„"
    set ib_skillCustom[535] = 0
    set ib_skillList[536] = 'Abdl'
    set ib_skillName[536] = "å¤§å‹è’èŠœä¹‹åœ°é©±æ•£"
    set ib_skillCustom[536] = 0
    set ib_skillList[537] = 'Abds'
    set ib_skillName[537] = "å°å‹è’èŠœä¹‹åœ°é©±æ•£"
    set ib_skillCustom[537] = 0
    set ib_skillList[538] = 'Abdt'
    set ib_skillName[538] = "é’»åœ°æ¢æµ‹"
    set ib_skillCustom[538] = 0
    set ib_skillList[539] = 'Abgl'
    set ib_skillName[539] = "å¤§å‹è’èŠœä¹‹åœ°è”“å»¶"
    set ib_skillCustom[539] = 0
    set ib_skillList[540] = 'Abgm'
    set ib_skillName[540] = "é—¹é¬¼é‡‘çŸ¿æŠ€èƒ½"
    set ib_skillCustom[540] = 0
    set ib_skillList[541] = 'Abgs'
    set ib_skillName[541] = "å°å‹è’èŠœä¹‹åœ°è”“å»¶"
    set ib_skillCustom[541] = 0
    set ib_skillList[542] = 'Abli'
    set ib_skillName[542] = "è’èŠœä¹‹åœ°"
    set ib_skillCustom[542] = 0
    set ib_skillList[543] = 'Ablo'
    set ib_skillName[543] = "å—œè¡€æœ¯"
    set ib_skillCustom[543] = 0
    set ib_skillList[544] = 'Ablp'
    set ib_skillName[544] = "è’èŠœä¹‹åœ°çš„ç½®æ”¾"
    set ib_skillCustom[544] = 0
    set ib_skillList[545] = 'Abof'
    set ib_skillName[545] = "ç‡ƒçƒ§ä¹‹æ²¹"
    set ib_skillCustom[545] = 0
    set ib_skillList[546] = 'Abrf'
    set ib_skillName[546] = "å˜ç†Š"
    set ib_skillCustom[546] = 0
    set ib_skillList[547] = 'Absk'
    set ib_skillName[547] = "ç‹‚æˆ˜å£«"
    set ib_skillCustom[547] = 0
    set ib_skillList[548] = 'Abtl'
    set ib_skillName[548] = "æˆ˜æ–—ä½ç½®"
    set ib_skillCustom[548] = 0
    set ib_skillList[549] = 'Abu2'
    set ib_skillName[549] = "é’»åœ°"
    set ib_skillCustom[549] = 0
    set ib_skillList[550] = 'Abu3'
    set ib_skillName[550] = "é’»åœ°"
    set ib_skillCustom[550] = 0
    set ib_skillList[551] = 'Abu5'
    set ib_skillName[551] = "é’»åœ°"
    set ib_skillCustom[551] = 0
    set ib_skillList[552] = 'Abun'
    set ib_skillName[552] = "è´§ç‰©ä¿æŒ (å…½æ—åœ°æ´)"
    set ib_skillCustom[552] = 0
    set ib_skillList[553] = 'Abur'
    set ib_skillName[553] = "é’»åœ°"
    set ib_skillCustom[553] = 0
    set ib_skillList[554] = 'Acan'
    set ib_skillName[554] = "åé£Ÿå°¸ä½“"
    set ib_skillCustom[554] = 0
    set ib_skillList[555] = 'Acar'
    set ib_skillName[555] = "è´§ç‰©ä¿æŒ"
    set ib_skillCustom[555] = 0
    set ib_skillList[556] = 'Acdb'
    set ib_skillName[556] = "é†‰æ‹³"
    set ib_skillCustom[556] = 0
    set ib_skillList[557] = 'Acdh'
    set ib_skillName[557] = "é†‰é…’äº‘é›¾"
    set ib_skillCustom[557] = 0
    set ib_skillList[558] = 'Acef'
    set ib_skillName[558] = "\"ç«åœŸé£æš´\""
    set ib_skillCustom[558] = 0
    set ib_skillList[559] = 'Acha'
    set ib_skillName[559] = "æ··ä¹±çš„"
    set ib_skillCustom[559] = 0
endfunction
function IB_SkillFill7 takes nothing returns nothing
    set ib_skillList[560] = 'Achd'
    set ib_skillName[560] = "è¿è¾“èˆ¹ä¿æŒåŸä½"
    set ib_skillCustom[560] = 0
    set ib_skillList[561] = 'Ache'
    set ib_skillName[561] = "ç“¦è§£å…‰çº¿"
    set ib_skillCustom[561] = 0
    set ib_skillList[562] = 'Achl'
    set ib_skillName[562] = "è£…è½½"
    set ib_skillCustom[562] = 0
    set ib_skillList[563] = 'Acht'
    set ib_skillName[563] = "ææ€–åšå«"
    set ib_skillCustom[563] = 0
    set ib_skillList[564] = 'Aclf'
    set ib_skillName[564] = "ä¹Œäº‘æŠ€èƒ½"
    set ib_skillCustom[564] = 0
    set ib_skillList[565] = 'Acmg'
    set ib_skillName[565] = "æ§åˆ¶é­”æ³•"
    set ib_skillCustom[565] = 0
    set ib_skillList[566] = 'Acn2'
    set ib_skillName[566] = "åé£Ÿå°¸ä½“"
    set ib_skillCustom[566] = 0
    set ib_skillList[567] = 'Acny'
    set ib_skillName[567] = "é£“é£"
    set ib_skillCustom[567] = 0
    set ib_skillList[568] = 'Aco2'
    set ib_skillName[568] = "éª‘ä¹˜è§’é¹°å…½"
    set ib_skillCustom[568] = 0
    set ib_skillList[569] = 'Aco3'
    set ib_skillName[569] = "æ­è½½å¼“ç®­æ‰‹"
    set ib_skillCustom[569] = 0
    set ib_skillList[570] = 'Acoa'
    set ib_skillName[570] = "éª‘ä¹˜è§’é¹°å…½"
    set ib_skillCustom[570] = 0
    set ib_skillList[571] = 'Acoh'
    set ib_skillName[571] = "æ­è½½å¼“ç®­æ‰‹"
    set ib_skillCustom[571] = 0
    set ib_skillList[572] = 'Acor'
    set ib_skillName[572] = "è…èš€å–·å"
    set ib_skillCustom[572] = 0
    set ib_skillList[573] = 'Acpf'
    set ib_skillName[573] = "çµè‚‰å½¢æ€"
    set ib_skillCustom[573] = 0
    set ib_skillList[574] = 'Acri'
    set ib_skillName[574] = "æ®‹åºŸ"
    set ib_skillCustom[574] = 0
    set ib_skillList[575] = 'Acrs'
    set ib_skillName[575] = "è¯…å’’"
    set ib_skillCustom[575] = 0
    set ib_skillList[576] = 'Acyc'
    set ib_skillName[576] = "é£“é£"
    set ib_skillCustom[576] = 0
    set ib_skillList[577] = 'Adch'
    set ib_skillName[577] = "æ¶ˆé­”"
    set ib_skillCustom[577] = 0
    set ib_skillList[578] = 'Adcn'
    set ib_skillName[578] = "æ¶ˆé­”"
    set ib_skillCustom[578] = 0
    set ib_skillList[579] = 'Adda'
    set ib_skillName[579] = "èŒƒå›´æ€§æ”»å‡»ä¼¤å®³"
    set ib_skillCustom[579] = 0
    set ib_skillList[580] = 'Adec'
    set ib_skillName[580] = "å¸è½½"
    set ib_skillCustom[580] = 0
    set ib_skillList[581] = 'Adef'
    set ib_skillName[581] = "é˜²å¾¡"
    set ib_skillCustom[581] = 0
    set ib_skillList[582] = 'Adet'
    set ib_skillName[582] = "æ¢æµ‹è€…"
    set ib_skillCustom[582] = 0
    set ib_skillList[583] = 'Adev'
    set ib_skillName[583] = "åå™¬"
    set ib_skillCustom[583] = 0
    set ib_skillList[584] = 'Adis'
    set ib_skillName[584] = "é©±é€é­”æ³•"
    set ib_skillCustom[584] = 0
    set ib_skillList[585] = 'Adri'
    set ib_skillName[585] = "ç«‹åˆ»å¸è½½"
    set ib_skillCustom[585] = 0
    set ib_skillList[586] = 'Adro'
    set ib_skillName[586] = "å¸è½½"
    set ib_skillCustom[586] = 0
    set ib_skillList[587] = 'Adsm'
    set ib_skillName[587] = "é©±é€é­”æ³•"
    set ib_skillCustom[587] = 0
    set ib_skillList[588] = 'Adt1'
    set ib_skillName[588] = "æ¢æµ‹è€…"
    set ib_skillCustom[588] = 0
    set ib_skillList[589] = 'Adta'
    set ib_skillName[589] = "æ˜¾ç¤º"
    set ib_skillCustom[589] = 0
    set ib_skillList[590] = 'Adtg'
    set ib_skillName[590] = "çœŸå®è§†åŸŸ"
    set ib_skillCustom[590] = 0
    set ib_skillList[591] = 'Adtn'
    set ib_skillName[591] = "çˆ†ç‚¸"
    set ib_skillCustom[591] = 0
    set ib_skillList[592] = 'Adts'
    set ib_skillName[592] = "é­”æ³•å²—å“¨"
    set ib_skillCustom[592] = 0
    set ib_skillList[593] = 'Advc'
    set ib_skillName[593] = "åå™¬è´§ç‰©"
    set ib_skillCustom[593] = 0
    set ib_skillList[594] = 'Advm'
    set ib_skillName[594] = "åå™¬é­”æ³•"
    set ib_skillCustom[594] = 0
    set ib_skillList[595] = 'Aeat'
    set ib_skillName[595] = "åé£Ÿæ ‘æœ¨"
    set ib_skillCustom[595] = 0
    set ib_skillList[596] = 'Aegm'
    set ib_skillName[596] = "ç¼ ç»•é‡‘çŸ¿æŠ€èƒ½"
    set ib_skillCustom[596] = 0
    set ib_skillList[597] = 'Aegr'
    set ib_skillName[597] = "è‰¾é²å°¼ä¹‹ä¼˜é›…"
    set ib_skillCustom[597] = 0
    set ib_skillList[598] = 'Aenc'
    set ib_skillName[598] = "è£…è½½"
    set ib_skillCustom[598] = 0
    set ib_skillList[599] = 'Aenr'
    set ib_skillName[599] = "çº ç¼ æ ¹é¡»"
    set ib_skillCustom[599] = 0
    set ib_skillList[600] = 'Aens'
    set ib_skillName[600] = "è¯±æ•"
    set ib_skillCustom[600] = 0
    set ib_skillList[601] = 'Aent'
    set ib_skillName[601] = "ç¼ ç»•é‡‘çŸ¿"
    set ib_skillCustom[601] = 0
    set ib_skillList[602] = 'Aenw'
    set ib_skillName[602] = "çº ç¼ æ ¹é¡»"
    set ib_skillCustom[602] = 0
    set ib_skillList[603] = 'Aesn'
    set ib_skillName[603] = "å“¨å…µ"
    set ib_skillCustom[603] = 0
    set ib_skillList[604] = 'Aesr'
    set ib_skillName[604] = "å“¨å…µ"
    set ib_skillCustom[604] = 0
    set ib_skillList[605] = 'Aetf'
    set ib_skillName[605] = "è™šæ— å½¢æ€"
    set ib_skillCustom[605] = 0
    set ib_skillList[606] = 'Aeth'
    set ib_skillName[606] = "å¹½çµ"
    set ib_skillCustom[606] = 0
    set ib_skillList[607] = 'Aetl'
    set ib_skillName[607] = "è™šæ— çŠ¶æ€"
    set ib_skillCustom[607] = 0
    set ib_skillList[608] = 'Aexh'
    set ib_skillName[608] = "æŒ–æ˜å°¸ä½“"
    set ib_skillCustom[608] = 0
    set ib_skillList[609] = 'Aeye'
    set ib_skillName[609] = "å²—å“¨å®ˆå«"
    set ib_skillCustom[609] = 0
    set ib_skillList[610] = 'Afa2'
    set ib_skillName[610] = "ç²¾çµä¹‹ç«"
    set ib_skillCustom[610] = 0
    set ib_skillList[611] = 'Afae'
    set ib_skillName[611] = "ç²¾çµä¹‹ç«"
    set ib_skillCustom[611] = 0
    set ib_skillList[612] = 'Afak'
    set ib_skillName[612] = "æ¯ç­ä¹‹çƒ"
    set ib_skillCustom[612] = 0
    set ib_skillList[613] = 'Afbb'
    set ib_skillName[613] = "åé¦ˆ"
    set ib_skillCustom[613] = 0
    set ib_skillList[614] = 'Afbk'
    set ib_skillName[614] = "é­”æ³•å›åº”"
    set ib_skillCustom[614] = 0
    set ib_skillList[615] = 'Afbt'
    set ib_skillName[615] = "é­”æ³•å›åº”"
    set ib_skillCustom[615] = 0
    set ib_skillList[616] = 'Afih'
    set ib_skillName[616] = "ç€ç«(äººæ—)"
    set ib_skillCustom[616] = 0
    set ib_skillList[617] = 'Afin'
    set ib_skillName[617] = "ç€ç«(æš—å¤œç²¾çµ)"
    set ib_skillCustom[617] = 0
    set ib_skillList[618] = 'Afio'
    set ib_skillName[618] = "ç€ç«(å…½æ—)"
    set ib_skillCustom[618] = 0
    set ib_skillList[619] = 'Afir'
    set ib_skillName[619] = "ç€ç«"
    set ib_skillCustom[619] = 0
    set ib_skillList[620] = 'Afiu'
    set ib_skillName[620] = "ç€ç«(ä¸æ­»æ—)"
    set ib_skillCustom[620] = 0
    set ib_skillList[621] = 'Afla'
    set ib_skillName[621] = "ç…§æ˜å¼¹"
    set ib_skillCustom[621] = 0
    set ib_skillList[622] = 'Aflk'
    set ib_skillName[622] = "é«˜å°„ç‚®ç«"
    set ib_skillCustom[622] = 0
    set ib_skillList[623] = 'Afod'
    set ib_skillName[623] = "æ­»äº¡ä¹‹æŒ‡"
    set ib_skillCustom[623] = 0
    set ib_skillList[624] = 'Afr2'
    set ib_skillName[624] = "éœœå†»æ”»å‡»"
    set ib_skillCustom[624] = 0
    set ib_skillList[625] = 'Afra'
    set ib_skillName[625] = "éœœä¹‹æ”»å‡»"
    set ib_skillCustom[625] = 0
    set ib_skillList[626] = 'Afrb'
    set ib_skillName[626] = "éœœå†»å‘¼å¸"
    set ib_skillCustom[626] = 0
    set ib_skillList[627] = 'Afrz'
    set ib_skillName[627] = "å†°å†»å–·å"
    set ib_skillCustom[627] = 0
    set ib_skillList[628] = 'Afsh'
    set ib_skillName[628] = "ç¢ç‰‡æ”»å‡»"
    set ib_skillCustom[628] = 0
    set ib_skillList[629] = 'Afzy'
    set ib_skillName[629] = "ç‹‚çƒ­"
    set ib_skillCustom[629] = 0
    set ib_skillList[630] = 'Agho'
    set ib_skillName[630] = "å¹½çµ"
    set ib_skillCustom[630] = 0
    set ib_skillList[631] = 'Agld'
    set ib_skillName[631] = "é‡‘çŸ¿èƒ½åŠ›"
    set ib_skillCustom[631] = 0
    set ib_skillList[632] = 'Agra'
    set ib_skillName[632] = "æˆ˜æ£"
    set ib_skillCustom[632] = 0
    set ib_skillList[633] = 'Agyb'
    set ib_skillName[633] = "é£è¡Œæœºå™¨ç‚¸å¼¹"
    set ib_skillCustom[633] = 0
    set ib_skillList[634] = 'Agyd'
    set ib_skillName[634] = "åˆ›å»ºå°¸ä½“"
    set ib_skillCustom[634] = 0
    set ib_skillList[635] = 'Agyv'
    set ib_skillName[635] = "çœŸå®è§†åŸŸ"
    set ib_skillCustom[635] = 0
    set ib_skillList[636] = 'Ahar'
    set ib_skillName[636] = "é‡‡é›†"
    set ib_skillCustom[636] = 0
    set ib_skillList[637] = 'Ahea'
    set ib_skillName[637] = "åŒ»ç–—"
    set ib_skillCustom[637] = 0
    set ib_skillList[638] = 'Ahid'
    set ib_skillName[638] = "å½±é"
    set ib_skillCustom[638] = 0
    set ib_skillList[639] = 'Ahnl'
    set ib_skillName[639] = "å¬å”¤ä»ªå¼"
    set ib_skillCustom[639] = 0
endfunction
function IB_SkillFill8 takes nothing returns nothing
    set ib_skillList[640] = 'Ahr2'
    set ib_skillName[640] = "é‡‡é›†"
    set ib_skillCustom[640] = 0
    set ib_skillList[641] = 'Ahr3'
    set ib_skillName[641] = "é‡‡é›†"
    set ib_skillCustom[641] = 0
    set ib_skillList[642] = 'Ahrl'
    set ib_skillName[642] = "é‡‡é›†"
    set ib_skillCustom[642] = 0
    set ib_skillList[643] = 'Ahrp'
    set ib_skillName[643] = "ä¿®ç†"
    set ib_skillCustom[643] = 0
    set ib_skillList[644] = 'Ahwd'
    set ib_skillName[644] = "æ²»ç–—å®ˆå«"
    set ib_skillCustom[644] = 0
    set ib_skillList[645] = 'Aien'
    set ib_skillName[645] = "å•ä½ç‰©å“æ "
    set ib_skillCustom[645] = 0
    set ib_skillList[646] = 'Aihn'
    set ib_skillName[646] = "å•ä½ç‰©å“æ "
    set ib_skillCustom[646] = 0
    set ib_skillList[647] = 'Ainf'
    set ib_skillName[647] = "å¿ƒçµä¹‹ç«"
    set ib_skillCustom[647] = 0
    set ib_skillList[648] = 'Aion'
    set ib_skillName[648] = "å•ä½ç‰©å“æ "
    set ib_skillCustom[648] = 0
    set ib_skillList[649] = 'Aiun'
    set ib_skillName[649] = "å•ä½ç‰©å“æ "
    set ib_skillCustom[649] = 0
    set ib_skillList[650] = 'Aivs'
    set ib_skillName[650] = "éšå½¢æœ¯"
    set ib_skillCustom[650] = 0
    set ib_skillList[651] = 'Alam'
    set ib_skillName[651] = "ç‰ºç‰²"
    set ib_skillCustom[651] = 0
    set ib_skillList[652] = 'Aliq'
    set ib_skillName[652] = "æ¶²ä½“ç‚¸å¼¹"
    set ib_skillCustom[652] = 0
    set ib_skillList[653] = 'Alit'
    set ib_skillName[653] = "é—ªç”µæ”»å‡»"
    set ib_skillCustom[653] = 0
    set ib_skillList[654] = 'Aloa'
    set ib_skillName[654] = "è£…è½½"
    set ib_skillCustom[654] = 0
    set ib_skillList[655] = 'Aloc'
    set ib_skillName[655] = "è—è™«"
    set ib_skillCustom[655] = 0
    set ib_skillList[656] = 'Alsh'
    set ib_skillName[656] = "é—ªç”µæŠ¤ç›¾"
    set ib_skillCustom[656] = 0
    set ib_skillList[657] = 'Amb2'
    set ib_skillName[657] = "æ¢å¤é­”æ³•"
    set ib_skillCustom[657] = 0
    set ib_skillList[658] = 'Ambb'
    set ib_skillName[658] = "æ³•åŠ›ç‡ƒçƒ§"
    set ib_skillCustom[658] = 0
    set ib_skillList[659] = 'Ambd'
    set ib_skillName[659] = "æ³•åŠ›ç‡ƒçƒ§"
    set ib_skillCustom[659] = 0
    set ib_skillList[660] = 'Ambt'
    set ib_skillName[660] = "è¡¥å……é­”æ³•å’Œç”Ÿå‘½å€¼"
    set ib_skillCustom[660] = 0
    set ib_skillList[661] = 'Amdf'
    set ib_skillName[661] = "é­”æ³•é˜²å¾¡"
    set ib_skillCustom[661] = 0
    set ib_skillList[662] = 'Amec'
    set ib_skillName[662] = "æœºæ¢°ç±»çš„å°ç©è‰º"
    set ib_skillCustom[662] = 0
    set ib_skillList[663] = 'Amed'
    set ib_skillName[663] = "å¸è½½å°¸ä½“"
    set ib_skillCustom[663] = 0
    set ib_skillList[664] = 'Amel'
    set ib_skillName[664] = "å¾—åˆ°å°¸ä½“"
    set ib_skillCustom[664] = 0
    set ib_skillList[665] = 'Amfl'
    set ib_skillName[665] = "é­”åŠ›ä¹‹ç„°"
    set ib_skillCustom[665] = 0
    set ib_skillList[666] = 'Amgl'
    set ib_skillName[666] = "æœˆåˆƒ"
    set ib_skillCustom[666] = 0
    set ib_skillList[667] = 'Amgr'
    set ib_skillName[667] = "æœˆåˆƒ"
    set ib_skillCustom[667] = 0
    set ib_skillList[668] = 'Amic'
    set ib_skillName[668] = "æˆ˜æ–—å·å¬"
    set ib_skillCustom[668] = 0
    set ib_skillList[669] = 'Amil'
    set ib_skillName[669] = "æˆ˜æ–—å·å¬"
    set ib_skillCustom[669] = 0
    set ib_skillList[670] = 'Amim'
    set ib_skillName[670] = "é­”æ³•å…ç–«"
    set ib_skillCustom[670] = 0
    set ib_skillList[671] = 'Amin'
    set ib_skillName[671] = "åœ°é›·å¼•çˆ†"
    set ib_skillCustom[671] = 0
    set ib_skillList[672] = 'Amls'
    set ib_skillName[672] = "ç©ºä¸­é”é•£"
    set ib_skillCustom[672] = 0
    set ib_skillList[673] = 'Amnb'
    set ib_skillName[673] = "æ³•åŠ›ç‡ƒçƒ§"
    set ib_skillCustom[673] = 0
    set ib_skillList[674] = 'Amnx'
    set ib_skillName[674] = "èŒƒå›´æ€§æ”»å‡»ä¼¤å®³"
    set ib_skillCustom[674] = 0
    set ib_skillList[675] = 'Amnz'
    set ib_skillName[675] = "èŒƒå›´æ€§æ”»å‡»ä¼¤å®³"
    set ib_skillCustom[675] = 0
    set ib_skillList[676] = 'Amou'
    set ib_skillName[676] = "éª‘ä¹˜"
    set ib_skillCustom[676] = 0
    set ib_skillList[677] = 'Amov'
    set ib_skillName[677] = "ç§»åŠ¨"
    set ib_skillCustom[677] = 0
    set ib_skillList[678] = 'Amrf'
    set ib_skillName[678] = "ä¹Œé¸¦å½¢æ€"
    set ib_skillCustom[678] = 0
    set ib_skillList[679] = 'Amtc'
    set ib_skillName[679] = "ä¿æŒåŸä½"
    set ib_skillCustom[679] = 0
    set ib_skillList[680] = 'Andm'
    set ib_skillName[680] = "é©±é€é­”æ³•"
    set ib_skillCustom[680] = 0
    set ib_skillList[681] = 'Andt'
    set ib_skillName[681] = "æ˜¾ç¤º"
    set ib_skillCustom[681] = 0
    set ib_skillList[682] = 'Ane2'
    set ib_skillName[682] = "é€‰æ‹©å•ä½"
    set ib_skillCustom[682] = 0
    set ib_skillList[683] = 'Anei'
    set ib_skillName[683] = "é€‰æ‹©ä½¿ç”¨è€…"
    set ib_skillCustom[683] = 0
    set ib_skillList[684] = 'Aneu'
    set ib_skillName[684] = "é€‰æ‹©è‹±é›„"
    set ib_skillCustom[684] = 0
    set ib_skillList[685] = 'Anh1'
    set ib_skillName[685] = "åŒ»ç–—"
    set ib_skillCustom[685] = 0
    set ib_skillList[686] = 'Anh2'
    set ib_skillName[686] = "åŒ»ç–—"
    set ib_skillCustom[686] = 0
    set ib_skillList[687] = 'Anhe'
    set ib_skillName[687] = "åŒ»ç–—"
    set ib_skillCustom[687] = 0
    set ib_skillList[688] = 'Anit'
    set ib_skillName[688] = "è·Ÿè¸ª"
    set ib_skillCustom[688] = 0
    set ib_skillList[689] = 'Ansk'
    set ib_skillName[689] = "ç¡¬åŒ–çš®è‚¤"
    set ib_skillCustom[689] = 0
    set ib_skillList[690] = 'Aoar'
    set ib_skillName[690] = "æ²»ç–—å®ˆå«å…‰ç¯"
    set ib_skillCustom[690] = 0
    set ib_skillList[691] = 'Apak'
    set ib_skillName[691] = "è¡Œå›ŠæŠ€èƒ½"
    set ib_skillCustom[691] = 0
    set ib_skillList[692] = 'Apg2'
    set ib_skillName[692] = "å‡€åŒ–"
    set ib_skillCustom[692] = 0
    set ib_skillList[693] = 'Aphx'
    set ib_skillName[693] = "ç«å‡¤å‡°å˜å½¢(å’Œå‡¤å‡°è›‹æœ‰å…³çš„)"
    set ib_skillCustom[693] = 0
    set ib_skillList[694] = 'Apig'
    set ib_skillName[694] = "æ°¸ä¹…çš„çŒ®ç¥­"
    set ib_skillCustom[694] = 0
    set ib_skillList[695] = 'Apit'
    set ib_skillName[695] = "å•†åº—è´­ä¹°ç‰©å“"
    set ib_skillCustom[695] = 0
    set ib_skillList[696] = 'Apiv'
    set ib_skillName[696] = "æ°¸ä¹…çš„éšå½¢"
    set ib_skillCustom[696] = 0
    set ib_skillList[697] = 'Aply'
    set ib_skillName[697] = "å˜å½¢æœ¯"
    set ib_skillCustom[697] = 0
    set ib_skillList[698] = 'Apmf'
    set ib_skillName[698] = "å‡¤å‡°ç«ç„°"
    set ib_skillCustom[698] = 0
    set ib_skillList[699] = 'Apo2'
    set ib_skillName[699] = "æ¯’åˆº"
    set ib_skillCustom[699] = 0
    set ib_skillList[700] = 'Apoi'
    set ib_skillName[700] = "æ¯’åˆº"
    set ib_skillCustom[700] = 0
    set ib_skillList[701] = 'Apos'
    set ib_skillName[701] = "å æ®"
    set ib_skillCustom[701] = 0
    set ib_skillList[702] = 'Aprg'
    set ib_skillName[702] = "å‡€åŒ–"
    set ib_skillCustom[702] = 0
    set ib_skillList[703] = 'Aps2'
    set ib_skillName[703] = "å æ®"
    set ib_skillCustom[703] = 0
    set ib_skillList[704] = 'Apsh'
    set ib_skillName[704] = "å˜ç›¸ç§»åŠ¨"
    set ib_skillCustom[704] = 0
    set ib_skillList[705] = 'Apts'
    set ib_skillName[705] = "ç–¾ç—…äº‘é›¾"
    set ib_skillCustom[705] = 0
    set ib_skillList[706] = 'Apxf'
    set ib_skillName[706] = "å‡¤å‡°ç«ç„°"
    set ib_skillCustom[706] = 0
    set ib_skillList[707] = 'Ara2'
    set ib_skillName[707] = "å’†å“®"
    set ib_skillCustom[707] = 0
    set ib_skillList[708] = 'Arai'
    set ib_skillName[708] = "å¤æ´»æ­»å°¸"
    set ib_skillCustom[708] = 0
    set ib_skillList[709] = 'Arav'
    set ib_skillName[709] = "é£æš´ä¹‹é¸¦"
    set ib_skillCustom[709] = 0
    set ib_skillList[710] = 'Arbr'
    set ib_skillName[710] = "åŠ å¼ºå‹åœ°æ´å‡çº§"
    set ib_skillCustom[710] = 0
    set ib_skillList[711] = 'Arej'
    set ib_skillName[711] = "ç”Ÿå‘½æ¢å¤"
    set ib_skillCustom[711] = 0
    set ib_skillList[712] = 'Arel'
    set ib_skillName[712] = "æé«˜è‹±é›„ç”Ÿå‘½å€¼æ¢å¤é€Ÿåº¦çš„ç‰©å“"
    set ib_skillCustom[712] = 0
    set ib_skillList[713] = 'Aren'
    set ib_skillName[713] = "æ›´æ–°"
    set ib_skillCustom[713] = 0
    set ib_skillList[714] = 'Arep'
    set ib_skillName[714] = "ä¿®ç†"
    set ib_skillCustom[714] = 0
    set ib_skillList[715] = 'Aret'
    set ib_skillName[715] = "å†è®­ç»ƒä¹‹ä¹¦"
    set ib_skillCustom[715] = 0
    set ib_skillList[716] = 'Arev'
    set ib_skillName[716] = "å¤æ´»è‹±é›„"
    set ib_skillCustom[716] = 0
    set ib_skillList[717] = 'Argd'
    set ib_skillName[717] = "é€å›é»„é‡‘"
    set ib_skillCustom[717] = 0
    set ib_skillList[718] = 'Argl'
    set ib_skillName[718] = "é€å›é»„é‡‘å’Œæœ¨æ"
    set ib_skillCustom[718] = 0
    set ib_skillList[719] = 'Arll'
    set ib_skillName[719] = "æé«˜è‹±é›„ç”Ÿå‘½å€¼æ¢å¤é€Ÿåº¦çš„ç‰©å“"
    set ib_skillCustom[719] = 0
endfunction
function IB_SkillFill9 takes nothing returns nothing
    set ib_skillList[720] = 'Arlm'
    set ib_skillName[720] = "é€å›æœ¨æ"
    set ib_skillCustom[720] = 0
    set ib_skillList[721] = 'Arng'
    set ib_skillName[721] = "å¤ä»‡"
    set ib_skillCustom[721] = 0
    set ib_skillList[722] = 'Aro1'
    set ib_skillName[722] = "æ‰æ ¹"
    set ib_skillCustom[722] = 0
    set ib_skillList[723] = 'Aro2'
    set ib_skillName[723] = "æ‰æ ¹"
    set ib_skillCustom[723] = 0
    set ib_skillList[724] = 'Aroa'
    set ib_skillName[724] = "å’†å“®"
    set ib_skillCustom[724] = 0
    set ib_skillList[725] = 'Aroc'
    set ib_skillName[725] = "å¼¹å¹•æ”»å‡»"
    set ib_skillCustom[725] = 0
    set ib_skillList[726] = 'Aroo'
    set ib_skillName[726] = "æ‰æ ¹"
    set ib_skillCustom[726] = 0
    set ib_skillList[727] = 'Arpb'
    set ib_skillName[727] = "è¡¥å……é­”æ³•å’Œç”Ÿå‘½å€¼"
    set ib_skillCustom[727] = 0
    set ib_skillList[728] = 'Arpl'
    set ib_skillName[728] = "æ¯èç²¾é«“"
    set ib_skillCustom[728] = 0
    set ib_skillList[729] = 'Arpm'
    set ib_skillName[729] = "çµé­‚è§¦æ‘¸"
    set ib_skillCustom[729] = 0
    set ib_skillList[730] = 'Arsg'
    set ib_skillName[730] = "å¬å”¤ç±³çº±"
    set ib_skillCustom[730] = 0
    set ib_skillList[731] = 'Arsk'
    set ib_skillName[731] = "æŠ—æ€§çš®è‚¤"
    set ib_skillCustom[731] = 0
    set ib_skillList[732] = 'Arsp'
    set ib_skillName[732] = "æƒŠå“"
    set ib_skillCustom[732] = 0
    set ib_skillList[733] = 'Arsq'
    set ib_skillName[733] = "å¬å”¤è±ªçŒª"
    set ib_skillCustom[733] = 0
    set ib_skillList[734] = 'Arst'
    set ib_skillName[734] = "æ¢å¤"
    set ib_skillCustom[734] = 0
    set ib_skillList[735] = 'Arsw'
    set ib_skillName[735] = "æ¯’è›‡å®ˆå«"
    set ib_skillCustom[735] = 0
    set ib_skillList[736] = 'Artn'
    set ib_skillName[736] = "è¿”å›"
    set ib_skillCustom[736] = 0
    set ib_skillList[737] = 'Asac'
    set ib_skillName[737] = "ç‰ºç‰²"
    set ib_skillCustom[737] = 0
    set ib_skillList[738] = 'Asal'
    set ib_skillName[738] = "æ å¤º"
    set ib_skillCustom[738] = 0
    set ib_skillList[739] = 'Asb1'
    set ib_skillName[739] = "æ½œæ°´"
    set ib_skillCustom[739] = 0
    set ib_skillList[740] = 'Asb2'
    set ib_skillName[740] = "æ½œæ°´"
    set ib_skillCustom[740] = 0
    set ib_skillList[741] = 'Asb3'
    set ib_skillName[741] = "æ½œæ°´"
    set ib_skillCustom[741] = 0
    set ib_skillList[742] = 'Asd2'
    set ib_skillName[742] = "å¡å¸ƒæ©"
    set ib_skillCustom[742] = 0
    set ib_skillList[743] = 'Asd3'
    set ib_skillName[743] = "å¡å¸ƒæ©"
    set ib_skillCustom[743] = 0
    set ib_skillList[744] = 'Asdg'
    set ib_skillName[744] = "å¡å¸ƒæ©"
    set ib_skillCustom[744] = 0
    set ib_skillList[745] = 'Asds'
    set ib_skillName[745] = "å¡å¸ƒæ©"
    set ib_skillCustom[745] = 0
    set ib_skillList[746] = 'Ashm'
    set ib_skillName[746] = "å½±é"
    set ib_skillCustom[746] = 0
    set ib_skillList[747] = 'Ashs'
    set ib_skillName[747] = "å½±å­æƒæ–"
    set ib_skillCustom[747] = 0
    set ib_skillList[748] = 'Asid'
    set ib_skillName[748] = "å‡ºå”®ç‰©å“"
    set ib_skillCustom[748] = 0
    set ib_skillList[749] = 'Asla'
    set ib_skillName[749] = "ä¸€ç›´ç¡çœ "
    set ib_skillCustom[749] = 0
    set ib_skillList[750] = 'Aslo'
    set ib_skillName[750] = "å‡é€Ÿ"
    set ib_skillCustom[750] = 0
    set ib_skillList[751] = 'Aslp'
    set ib_skillName[751] = "å¬å”¤å·¨è™¾"
    set ib_skillCustom[751] = 0
    set ib_skillList[752] = 'Asod'
    set ib_skillName[752] = "äº§åµä¹‹éª¨"
    set ib_skillCustom[752] = 0
    set ib_skillList[753] = 'Asou'
    set ib_skillName[753] = "èƒ½å æ®å•ä½çµé­‚çš„ç‰©å“"
    set ib_skillCustom[753] = 0
    set ib_skillList[754] = 'Asp1'
    set ib_skillName[754] = "çƒä½“"
    set ib_skillCustom[754] = 0
    set ib_skillList[755] = 'Asp2'
    set ib_skillName[755] = "çƒä½“"
    set ib_skillCustom[755] = 0
    set ib_skillList[756] = 'Asp3'
    set ib_skillName[756] = "çƒä½“"
    set ib_skillCustom[756] = 0
    set ib_skillList[757] = 'Asp4'
    set ib_skillName[757] = "çƒä½“"
    set ib_skillCustom[757] = 0
    set ib_skillList[758] = 'Asp5'
    set ib_skillName[758] = "çƒä½“"
    set ib_skillCustom[758] = 0
    set ib_skillList[759] = 'Asp6'
    set ib_skillName[759] = "çƒä½“"
    set ib_skillCustom[759] = 0
    set ib_skillList[760] = 'Aspa'
    set ib_skillName[760] = "èœ˜è››æ”»å‡»"
    set ib_skillCustom[760] = 0
    set ib_skillList[761] = 'Aspb'
    set ib_skillName[761] = "é­”æ³•ä¹¦"
    set ib_skillCustom[761] = 0
    set ib_skillList[762] = 'Aspd'
    set ib_skillName[762] = "å°èœ˜è››"
    set ib_skillCustom[762] = 0
    set ib_skillList[763] = 'Asph'
    set ib_skillName[763] = "çƒä½“"
    set ib_skillCustom[763] = 0
    set ib_skillList[764] = 'Aspi'
    set ib_skillName[764] = "å°–å½¢è·¯éšœ"
    set ib_skillCustom[764] = 0
    set ib_skillList[765] = 'Aspl'
    set ib_skillName[765] = "çµé­‚é”é“¾"
    set ib_skillCustom[765] = 0
    set ib_skillList[766] = 'Aspo'
    set ib_skillName[766] = "æ…¢æ€§æ¯’è¯"
    set ib_skillCustom[766] = 0
    set ib_skillList[767] = 'Aspp'
    set ib_skillName[767] = "çµé­‚é”é“¾"
    set ib_skillCustom[767] = 0
    set ib_skillList[768] = 'Asps'
    set ib_skillName[768] = "é­”æ³•ç›—å–"
    set ib_skillCustom[768] = 0
    set ib_skillList[769] = 'Aspt'
    set ib_skillName[769] = "è¯ç”Ÿåˆºè›‡å¹¼è™«"
    set ib_skillCustom[769] = 0
    set ib_skillList[770] = 'Aspy'
    set ib_skillName[770] = "è¯ç”Ÿåˆºè›‡"
    set ib_skillCustom[770] = 0
    set ib_skillList[771] = 'Assk'
    set ib_skillName[771] = "ç¡¬åŒ–çš®è‚¤"
    set ib_skillCustom[771] = 0
    set ib_skillList[772] = 'Assp'
    set ib_skillName[772] = "å°èœ˜è››"
    set ib_skillCustom[772] = 0
    set ib_skillList[773] = 'Asta'
    set ib_skillName[773] = "é™æ­¢é™·é˜±"
    set ib_skillCustom[773] = 0
    set ib_skillList[774] = 'Astd'
    set ib_skillName[774] = "å¸è½½è‹¦å·¥"
    set ib_skillCustom[774] = 0
    set ib_skillList[775] = 'Aste'
    set ib_skillName[775] = "ç›—å–"
    set ib_skillCustom[775] = 0
    set ib_skillList[776] = 'Asth'
    set ib_skillName[776] = "é£æš´æˆ˜é”¤"
    set ib_skillCustom[776] = 0
    set ib_skillList[777] = 'Astn'
    set ib_skillName[777] = "çŸ³åƒå½¢æ€"
    set ib_skillCustom[777] = 0
    set ib_skillList[778] = 'Asud'
    set ib_skillName[778] = "å‡ºå”®å•ä½"
    set ib_skillCustom[778] = 0
    set ib_skillList[779] = 'Atau'
    set ib_skillName[779] = "å˜²è®½"
    set ib_skillCustom[779] = 0
    set ib_skillList[780] = 'Atdg'
    set ib_skillName[780] = "å»ºç­‘ç‰©ç ´åå…‰ç¯"
    set ib_skillCustom[780] = 0
    set ib_skillList[781] = 'Atdp'
    set ib_skillName[781] = "å¸è½½é©¾é©¶å‘˜"
    set ib_skillCustom[781] = 0
    set ib_skillList[782] = 'Atlp'
    set ib_skillName[782] = "è£…è½½é©¾é©¶å‘˜"
    set ib_skillCustom[782] = 0
    set ib_skillList[783] = 'Atol'
    set ib_skillName[783] = "ç”Ÿå‘½ä¹‹æ ‘å‡çº§æŠ€èƒ½"
    set ib_skillCustom[783] = 0
    set ib_skillList[784] = 'Atru'
    set ib_skillName[784] = "çœŸå®è§†åŸŸ"
    set ib_skillCustom[784] = 0
    set ib_skillList[785] = 'Atsp'
    set ib_skillName[785] = "é¾™å·æ—‹é£"
    set ib_skillCustom[785] = 0
    set ib_skillList[786] = 'Attu'
    set ib_skillName[786] = "å¦å…‹å›´åŸ"
    set ib_skillCustom[786] = 0
    set ib_skillList[787] = 'Atwa'
    set ib_skillName[787] = "é¾™å·é£æ¼«æ­¥è€…"
    set ib_skillCustom[787] = 0
    set ib_skillList[788] = 'Auco'
    set ib_skillName[788] = "ä¸ç¨³å®šåŒ–åˆç‰©"
    set ib_skillCustom[788] = 0
    set ib_skillList[789] = 'Auhf'
    set ib_skillName[789] = "é‚ªæ¶ç‹‚çƒ­"
    set ib_skillCustom[789] = 0
    set ib_skillList[790] = 'Ault'
    set ib_skillName[790] = "å¤œè§†èƒ½åŠ›"
    set ib_skillCustom[790] = 0
    set ib_skillList[791] = 'Auns'
    set ib_skillName[791] = "åå¬å”¤å»ºç­‘"
    set ib_skillCustom[791] = 0
    set ib_skillList[792] = 'Aven'
    set ib_skillName[792] = "æµ¸æ¯’æ­¦å™¨"
    set ib_skillCustom[792] = 0
    set ib_skillList[793] = 'Avng'
    set ib_skillName[793] = "å¤ä»‡ä¹‹é­‚"
    set ib_skillCustom[793] = 0
    set ib_skillList[794] = 'Avul'
    set ib_skillName[794] = "æ— æ•Œçš„"
    set ib_skillCustom[794] = 0
    set ib_skillList[795] = 'Awan'
    set ib_skillName[795] = "æ¸¸è¡è€…"
    set ib_skillCustom[795] = 0
    set ib_skillList[796] = 'Awar'
    set ib_skillName[796] = "ç²‰ç¢"
    set ib_skillCustom[796] = 0
    set ib_skillList[797] = 'Aweb'
    set ib_skillName[797] = "è››ç½‘"
    set ib_skillCustom[797] = 0
    set ib_skillList[798] = 'Awfb'
    set ib_skillName[798] = "éœ¹é›³é—ªç”µ"
    set ib_skillCustom[798] = 0
    set ib_skillList[799] = 'Awh2'
    set ib_skillName[799] = "é‡‡é›†"
    set ib_skillCustom[799] = 0
endfunction
function IB_SkillFill10 takes nothing returns nothing
    set ib_skillList[800] = 'Awha'
    set ib_skillName[800] = "é‡‡é›†"
    set ib_skillCustom[800] = 0
    set ib_skillList[801] = 'Awhe'
    set ib_skillName[801] = "åŒ»ç–—"
    set ib_skillCustom[801] = 0
    set ib_skillList[802] = 'Awrg'
    set ib_skillName[802] = "æˆ˜äº‰è·µè¸"
    set ib_skillCustom[802] = 0
    set ib_skillList[803] = 'Awrh'
    set ib_skillName[803] = "æˆ˜äº‰è·µè¸"
    set ib_skillCustom[803] = 0
    set ib_skillList[804] = 'Awrp'
    set ib_skillName[804] = "ä¼ é€é—¨æŠ€èƒ½"
    set ib_skillCustom[804] = 0
    set ib_skillList[805] = 'Awrs'
    set ib_skillName[805] = "æˆ˜äº‰è·µè¸"
    set ib_skillCustom[805] = 0
    set ib_skillList[806] = 'Bdbb'
    set ib_skillName[806] = "å¸å–ç”Ÿå‘½å€¼å’Œé­”æ³•å€¼ï¼ˆé™„åŠ ï¼‰"
    set ib_skillCustom[806] = 0
    set ib_skillList[807] = 'Bdbl'
    set ib_skillName[807] = "å¸å–ç”Ÿå‘½ï¼ˆé™„åŠ ï¼‰"
    set ib_skillCustom[807] = 0
    set ib_skillList[808] = 'Bdbm'
    set ib_skillName[808] = "å¸å–é­”æ³•ï¼ˆé™„åŠ ï¼‰"
    set ib_skillCustom[808] = 0
    set ib_skillList[809] = 'SCae'
    set ib_skillName[809] = "è€ä¹…å…‰ç¯"
    set ib_skillCustom[809] = 0
    set ib_skillList[810] = 'SCc1'
    set ib_skillName[810] = "é£“é£"
    set ib_skillCustom[810] = 0
    set ib_skillList[811] = 'SCva'
    set ib_skillName[811] = "çªƒå–ç”Ÿå‘½"
    set ib_skillCustom[811] = 0
    set ib_skillList[812] = 'SNdc'
    set ib_skillName[812] = "é»‘æš—è½¬æ¢"
    set ib_skillCustom[812] = 0
    set ib_skillList[813] = 'SNdd'
    set ib_skillName[813] = "æ­»äº¡å‡‹é›¶"
    set ib_skillCustom[813] = 0
    set ib_skillList[814] = 'SNeq'
    set ib_skillName[814] = "åœ°éœ‡"
    set ib_skillCustom[814] = 0
    set ib_skillList[815] = 'SNin'
    set ib_skillName[815] = "åœ°ç‹±ç«"
    set ib_skillCustom[815] = 0
    set ib_skillList[816] = 'Sbsk'
    set ib_skillName[816] = "ç‹‚æš´æ„¤æ€’å‡çº§"
    set ib_skillCustom[816] = 0
    set ib_skillList[817] = 'Sbtl'
    set ib_skillName[817] = "æˆ˜å¤‡çŠ¶æ€"
    set ib_skillCustom[817] = 0
    set ib_skillList[818] = 'Sch2'
    set ib_skillName[818] = "ä¿æŒåŸä½"
    set ib_skillCustom[818] = 0
    set ib_skillList[819] = 'Sch3'
    set ib_skillName[819] = "ä¿æŒåŸä½"
    set ib_skillCustom[819] = 0
    set ib_skillList[820] = 'Sch4'
    set ib_skillName[820] = "ä¿æŒåŸä½"
    set ib_skillCustom[820] = 0
    set ib_skillList[821] = 'Sch5'
    set ib_skillName[821] = "ä¿æŒåŸä½"
    set ib_skillCustom[821] = 0
    set ib_skillList[822] = 'Scri'
    set ib_skillName[822] = "æ®‹åºŸ"
    set ib_skillCustom[822] = 0
    set ib_skillList[823] = 'Sdro'
    set ib_skillName[823] = "å¸è½½"
    set ib_skillCustom[823] = 0
    set ib_skillList[824] = 'Slo2'
    set ib_skillName[824] = "è£…è½½å°ç²¾çµ"
    set ib_skillCustom[824] = 0
    set ib_skillList[825] = 'Slo3'
    set ib_skillName[825] = "è£…è½½"
    set ib_skillCustom[825] = 0
    set ib_skillList[826] = 'Sloa'
    set ib_skillName[826] = "è£…è½½"
    set ib_skillCustom[826] = 0
    set ib_skillList[827] = 'Sshm'
    set ib_skillName[827] = "å½±é"
    set ib_skillCustom[827] = 0
    set ib_skillList[828] = 'Suhf'
    set ib_skillName[828] = "é‚ªæ¶ç‹‚çƒ­"
    set ib_skillCustom[828] = 0
endfunction

function IB_UnitFill0 takes nothing returns nothing
    set ib_unitList[0] = 'Ecen'
    set ib_unitName[0] = "åŠç¥äºº"
    set ib_unitArmor[0] = "divine"
    set ib_unitNameGbk[0] = "°ëÉñÈË"
    set ib_unitList[1] = 'Edem'
    set ib_unitName[1] = "æ¶é­”çŒæ‰‹"
    set ib_unitArmor[1] = "hero"
    set ib_unitNameGbk[1] = "¶ñÄ§ÁÔÊÖ"
    set ib_unitList[2] = 'Edmm'
    set ib_unitName[2] = "æ¶é­”çŒæ‰‹"
    set ib_unitArmor[2] = "hero"
    set ib_unitNameGbk[2] = "¶ñÄ§ÁÔÊÖ"
    set ib_unitList[3] = 'Eevi'
    set ib_unitName[3] = "æ¶é­”çŒæ‰‹"
    set ib_unitArmor[3] = "hero"
    set ib_unitNameGbk[3] = "¶ñÄ§ÁÔÊÖ"
    set ib_unitList[4] = 'Eevm'
    set ib_unitName[4] = "æ¶é­”çŒæ‰‹"
    set ib_unitArmor[4] = "hero"
    set ib_unitNameGbk[4] = "¶ñÄ§ÁÔÊÖ"
    set ib_unitList[5] = 'Efur'
    set ib_unitName[5] = "ä¸›æ—å®ˆæŠ¤è€…"
    set ib_unitArmor[5] = "hero"
    set ib_unitNameGbk[5] = "´ÔÁÖÊØ»¤Õß"
    set ib_unitList[6] = 'Eidm'
    set ib_unitName[6] = "æ¶é­”çŒæ‰‹"
    set ib_unitArmor[6] = "hero"
    set ib_unitNameGbk[6] = "¶ñÄ§ÁÔÊÖ"
    set ib_unitList[7] = 'Eill'
    set ib_unitName[7] = "æ¶é­”çŒæ‰‹"
    set ib_unitArmor[7] = "hero"
    set ib_unitNameGbk[7] = "¶ñÄ§ÁÔÊÖ"
    set ib_unitList[8] = 'Eilm'
    set ib_unitName[8] = "æ¶é­”çŒæ‰‹"
    set ib_unitArmor[8] = "hero"
    set ib_unitNameGbk[8] = "¶ñÄ§ÁÔÊÖ"
    set ib_unitList[9] = 'Ekee'
    set ib_unitName[9] = "ä¸›æ—å®ˆæŠ¤è€…"
    set ib_unitArmor[9] = "hero"
    set ib_unitNameGbk[9] = "´ÔÁÖÊØ»¤Õß"
    set ib_unitList[10] = 'Ekgg'
    set ib_unitName[10] = "ä¸›æ—å®ˆæŠ¤è€…"
    set ib_unitArmor[10] = "hero"
    set ib_unitNameGbk[10] = "´ÔÁÖÊØ»¤Õß"
    set ib_unitList[11] = 'Emfr'
    set ib_unitName[11] = "ä¸›æ—å®ˆæŠ¤è€…"
    set ib_unitArmor[11] = "hero"
    set ib_unitNameGbk[11] = "´ÔÁÖÊØ»¤Õß"
    set ib_unitList[12] = 'Emns'
    set ib_unitName[12] = "ä¸›æ—å®ˆæŠ¤è€…"
    set ib_unitArmor[12] = "hero"
    set ib_unitNameGbk[12] = "´ÔÁÖÊØ»¤Õß"
    set ib_unitList[13] = 'Emoo'
    set ib_unitName[13] = "æœˆä¹‹å¥³ç¥­å¸"
    set ib_unitArmor[13] = "hero"
    set ib_unitNameGbk[13] = "ÔÂÖ®Å®¼ÀË¾"
    set ib_unitList[14] = 'Etyr'
    set ib_unitName[14] = "æœˆä¹‹å¥³ç¥­å¸"
    set ib_unitArmor[14] = "hero"
    set ib_unitNameGbk[14] = "ÔÂÖ®Å®¼ÀË¾"
    set ib_unitList[15] = 'Ewar'
    set ib_unitName[15] = "å®ˆæœ›è€…"
    set ib_unitArmor[15] = "hero"
    set ib_unitNameGbk[15] = "ÊØÍûÕß"
    set ib_unitList[16] = 'Ewrd'
    set ib_unitName[16] = "å®ˆæœ›è€…"
    set ib_unitArmor[16] = "hero"
    set ib_unitNameGbk[16] = "ÊØÍûÕß"
    set ib_unitList[17] = 'Hamg'
    set ib_unitName[17] = "å¤§é­”æ³•å¸ˆ"
    set ib_unitArmor[17] = "hero"
    set ib_unitNameGbk[17] = "´óÄ§·¨Ê¦"
    set ib_unitList[18] = 'Hant'
    set ib_unitName[18] = "å¤§é­”æ³•å¸ˆ"
    set ib_unitArmor[18] = "hero"
    set ib_unitNameGbk[18] = "´óÄ§·¨Ê¦"
    set ib_unitList[19] = 'Hapm'
    set ib_unitName[19] = "åœ£éª‘å£«"
    set ib_unitArmor[19] = "hero"
    set ib_unitNameGbk[19] = "Ê¥ÆïÊ¿"
    set ib_unitList[20] = 'Harf'
    set ib_unitName[20] = "åœ£éª‘å£«"
    set ib_unitArmor[20] = "hero"
    set ib_unitNameGbk[20] = "Ê¥ÆïÊ¿"
    set ib_unitList[21] = 'Hart'
    set ib_unitName[21] = "åœ£éª‘å£«"
    set ib_unitArmor[21] = "hero"
    set ib_unitNameGbk[21] = "Ê¥ÆïÊ¿"
    set ib_unitList[22] = 'Hblm'
    set ib_unitName[22] = ""
    set ib_unitArmor[22] = "hero"
    set ib_unitNameGbk[22] = ""
    set ib_unitList[23] = 'Hdgo'
    set ib_unitName[23] = "åœ£éª‘å£«"
    set ib_unitArmor[23] = "hero"
    set ib_unitNameGbk[23] = "Ê¥ÆïÊ¿"
    set ib_unitList[24] = 'Hgam'
    set ib_unitName[24] = "å¹½çµå¤§é­”æ³•å¸ˆ"
    set ib_unitArmor[24] = "hero"
    set ib_unitNameGbk[24] = "ÓÄÁé´óÄ§·¨Ê¦"
    set ib_unitList[25] = 'Hhkl'
    set ib_unitName[25] = "åœ£éª‘å£«"
    set ib_unitArmor[25] = "hero"
    set ib_unitNameGbk[25] = "Ê¥ÆïÊ¿"
    set ib_unitList[26] = 'Hjai'
    set ib_unitName[26] = "å¤§é­”æ³•å¸ˆ"
    set ib_unitArmor[26] = "hero"
    set ib_unitNameGbk[26] = "´óÄ§·¨Ê¦"
    set ib_unitList[27] = 'Hkal'
    set ib_unitName[27] = "è¡€é­”æ³•å¸ˆ"
    set ib_unitArmor[27] = "hero"
    set ib_unitNameGbk[27] = "ÑªÄ§·¨Ê¦"
    set ib_unitList[28] = 'Hlgr'
    set ib_unitName[28] = "é»‘æš—éª‘å£«"
    set ib_unitArmor[28] = "hero"
    set ib_unitNameGbk[28] = "ºÚ°µÆïÊ¿"
    set ib_unitList[29] = 'Hmbr'
    set ib_unitName[29] = "å±±ä¸˜ä¹‹ç‹"
    set ib_unitArmor[29] = "hero"
    set ib_unitNameGbk[29] = "É½ÇğÖ®Íõ"
    set ib_unitList[30] = 'Hmgd'
    set ib_unitName[30] = "åœ£éª‘å£«"
    set ib_unitArmor[30] = "hero"
    set ib_unitNameGbk[30] = "Ê¥ÆïÊ¿"
    set ib_unitList[31] = 'Hmkg'
    set ib_unitName[31] = "å±±ä¸˜ä¹‹ç‹"
    set ib_unitArmor[31] = "hero"
    set ib_unitNameGbk[31] = "É½ÇğÖ®Íõ"
    set ib_unitList[32] = 'Hpal'
    set ib_unitName[32] = "åœ£éª‘å£«"
    set ib_unitArmor[32] = "hero"
    set ib_unitNameGbk[32] = "Ê¥ÆïÊ¿"
    set ib_unitList[33] = 'Hpb1'
    set ib_unitName[33] = "åœ£éª‘å£«"
    set ib_unitArmor[33] = "hero"
    set ib_unitNameGbk[33] = "Ê¥ÆïÊ¿"
    set ib_unitList[34] = 'Hpb2'
    set ib_unitName[34] = "åœ£éª‘å£«"
    set ib_unitArmor[34] = "hero"
    set ib_unitNameGbk[34] = "Ê¥ÆïÊ¿"
    set ib_unitList[35] = 'Huth'
    set ib_unitName[35] = "åœ£éª‘å£«"
    set ib_unitArmor[35] = "hero"
    set ib_unitNameGbk[35] = "Ê¥ÆïÊ¿"
    set ib_unitList[36] = 'Hvsh'
    set ib_unitName[36] = "å¨œè¿¦å¥³æµ·å·«"
    set ib_unitArmor[36] = "hero"
    set ib_unitNameGbk[36] = "ÄÈåÈÅ®º£Î×"
    set ib_unitList[37] = 'Hvwd'
    set ib_unitName[37] = "æ¸¸ä¾ "
    set ib_unitArmor[37] = "hero"
    set ib_unitNameGbk[37] = "ÓÎÏÀ"
    set ib_unitList[38] = 'Naka'
    set ib_unitName[38] = "è´¤è€…"
    set ib_unitArmor[38] = "hero"
    set ib_unitNameGbk[38] = "ÏÍÕß"
    set ib_unitList[39] = 'Nal2'
    set ib_unitName[39] = "ç‚¼é‡‘æœ¯å£«"
    set ib_unitArmor[39] = "hero"
    set ib_unitNameGbk[39] = "Á¶½ğÊõÊ¿"
    set ib_unitList[40] = 'Nal3'
    set ib_unitName[40] = "ç‚¼é‡‘æœ¯å£«"
    set ib_unitArmor[40] = "hero"
    set ib_unitNameGbk[40] = "Á¶½ğÊõÊ¿"
    set ib_unitList[41] = 'Nalc'
    set ib_unitName[41] = "ç‚¼é‡‘æœ¯å£«"
    set ib_unitArmor[41] = "hero"
    set ib_unitNameGbk[41] = "Á¶½ğÊõÊ¿"
    set ib_unitList[42] = 'Nalm'
    set ib_unitName[42] = "ç‚¼é‡‘æœ¯å£«"
    set ib_unitArmor[42] = "hero"
    set ib_unitNameGbk[42] = "Á¶½ğÊõÊ¿"
    set ib_unitList[43] = 'Nbbc'
    set ib_unitName[43] = "å‰‘åœ£"
    set ib_unitArmor[43] = "hero"
    set ib_unitNameGbk[43] = "½£Ê¥"
    set ib_unitList[44] = 'Nbrn'
    set ib_unitName[44] = "é»‘æš—æ¸¸ä¾ "
    set ib_unitArmor[44] = "hero"
    set ib_unitNameGbk[44] = "ºÚ°µÓÎÏÀ"
    set ib_unitList[45] = 'Nbst'
    set ib_unitName[45] = "é©¯å…½å¸ˆ"
    set ib_unitArmor[45] = "hero"
    set ib_unitNameGbk[45] = "Ñ±ÊŞÊ¦"
    set ib_unitList[46] = 'Nfir'
    set ib_unitName[46] = "ç«ç„°å·¨é­”"
    set ib_unitArmor[46] = "hero"
    set ib_unitNameGbk[46] = "»ğÑæ¾ŞÄ§"
    set ib_unitList[47] = 'Nkjx'
    set ib_unitName[47] = "å·«å¸ˆ"
    set ib_unitArmor[47] = "hero"
    set ib_unitNameGbk[47] = "Î×Ê¦"
    set ib_unitList[48] = 'Nklj'
    set ib_unitName[48] = "å·«å¸ˆ"
    set ib_unitArmor[48] = "hero"
    set ib_unitNameGbk[48] = "Î×Ê¦"
    set ib_unitList[49] = 'Nmag'
    set ib_unitName[49] = "æ·±æ¸Šé­”ç‹"
    set ib_unitArmor[49] = "hero"
    set ib_unitNameGbk[49] = "ÉîÔ¨Ä§Íõ"
    set ib_unitList[50] = 'Nman'
    set ib_unitName[50] = "æ·±æ¸Šé­”ç‹"
    set ib_unitArmor[50] = "hero"
    set ib_unitNameGbk[50] = "ÉîÔ¨Ä§Íõ"
    set ib_unitList[51] = 'Nngs'
    set ib_unitName[51] = "å¨œè¿¦å¥³æµ·å·«"
    set ib_unitArmor[51] = "hero"
    set ib_unitNameGbk[51] = "ÄÈåÈÅ®º£Î×"
    set ib_unitList[52] = 'Npbm'
    set ib_unitName[52] = "ç†ŠçŒ«é…’ä»™"
    set ib_unitArmor[52] = "hero"
    set ib_unitNameGbk[52] = "ĞÜÃ¨¾ÆÏÉ"
    set ib_unitList[53] = 'Npld'
    set ib_unitName[53] = "æ·±æ¸Šé­”ç‹"
    set ib_unitArmor[53] = "hero"
    set ib_unitNameGbk[53] = "ÉîÔ¨Ä§Íõ"
    set ib_unitList[54] = 'Nplh'
    set ib_unitName[54] = "æ·±æ¸Šé­”ç‹"
    set ib_unitArmor[54] = "hero"
    set ib_unitNameGbk[54] = "ÉîÔ¨Ä§Íõ"
    set ib_unitList[55] = 'Nrob'
    set ib_unitName[55] = "ä¿®è¡¥åŒ "
    set ib_unitArmor[55] = "hero"
    set ib_unitNameGbk[55] = "ĞŞ²¹½³"
    set ib_unitList[56] = 'Nsjs'
    set ib_unitName[56] = "ç†ŠçŒ«é…’ä»™"
    set ib_unitArmor[56] = "hero"
    set ib_unitNameGbk[56] = "ĞÜÃ¨¾ÆÏÉ"
    set ib_unitList[57] = 'Ntin'
    set ib_unitName[57] = "ä¿®è¡¥åŒ "
    set ib_unitArmor[57] = "hero"
    set ib_unitNameGbk[57] = "ĞŞ²¹½³"
    set ib_unitList[58] = 'Obla'
    set ib_unitName[58] = "å‰‘åœ£"
    set ib_unitArmor[58] = "hero"
    set ib_unitNameGbk[58] = "½£Ê¥"
    set ib_unitList[59] = 'Ocb2'
    set ib_unitName[59] = "ç‰›å¤´äººé…‹é•¿"
    set ib_unitArmor[59] = "hero"
    set ib_unitNameGbk[59] = "Å£Í·ÈËÇõ³¤"
    set ib_unitList[60] = 'Ocbh'
    set ib_unitName[60] = "ç‰›å¤´äººé…‹é•¿"
    set ib_unitArmor[60] = "hero"
    set ib_unitNameGbk[60] = "Å£Í·ÈËÇõ³¤"
    set ib_unitList[61] = 'Odrt'
    set ib_unitName[61] = "å…ˆçŸ¥"
    set ib_unitArmor[61] = "hero"
    set ib_unitNameGbk[61] = "ÏÈÖª"
    set ib_unitList[62] = 'Ofar'
    set ib_unitName[62] = "å…ˆçŸ¥"
    set ib_unitArmor[62] = "hero"
    set ib_unitNameGbk[62] = "ÏÈÖª"
    set ib_unitList[63] = 'Ogld'
    set ib_unitName[63] = "å·«å¸ˆ"
    set ib_unitArmor[63] = "hero"
    set ib_unitNameGbk[63] = "Î×Ê¦"
    set ib_unitList[64] = 'Ogrh'
    set ib_unitName[64] = "å‰‘åœ£"
    set ib_unitArmor[64] = "hero"
    set ib_unitNameGbk[64] = "½£Ê¥"
    set ib_unitList[65] = 'Opgh'
    set ib_unitName[65] = "å‰‘åœ£"
    set ib_unitArmor[65] = "hero"
    set ib_unitNameGbk[65] = "½£Ê¥"
    set ib_unitList[66] = 'Orex'
    set ib_unitName[66] = "é©¯å…½å¸ˆ"
    set ib_unitArmor[66] = "hero"
    set ib_unitNameGbk[66] = "Ñ±ÊŞÊ¦"
    set ib_unitList[67] = 'Orkn'
    set ib_unitName[67] = "æš—å½±çŒæ‰‹"
    set ib_unitArmor[67] = "hero"
    set ib_unitNameGbk[67] = "°µÓ°ÁÔÊÖ"
    set ib_unitList[68] = 'Osam'
    set ib_unitName[68] = "å‰‘åœ£"
    set ib_unitArmor[68] = "hero"
    set ib_unitNameGbk[68] = "½£Ê¥"
    set ib_unitList[69] = 'Oshd'
    set ib_unitName[69] = "æš—å½±çŒæ‰‹"
    set ib_unitArmor[69] = "hero"
    set ib_unitNameGbk[69] = "°µÓ°ÁÔÊÖ"
    set ib_unitList[70] = 'Otcc'
    set ib_unitName[70] = "ç‰›å¤´äººé…‹é•¿"
    set ib_unitArmor[70] = "hero"
    set ib_unitNameGbk[70] = "Å£Í·ÈËÇõ³¤"
    set ib_unitList[71] = 'Otch'
    set ib_unitName[71] = "ç‰›å¤´äººé…‹é•¿"
    set ib_unitArmor[71] = "hero"
    set ib_unitNameGbk[71] = "Å£Í·ÈËÇõ³¤"
    set ib_unitList[72] = 'Othr'
    set ib_unitName[72] = "å…ˆçŸ¥"
    set ib_unitArmor[72] = "hero"
    set ib_unitNameGbk[72] = "ÏÈÖª"
    set ib_unitList[73] = 'Uanb'
    set ib_unitName[73] = "åœ°ç©´é¢†ä¸»"
    set ib_unitArmor[73] = "hero"
    set ib_unitNameGbk[73] = "µØÑ¨ÁìÖ÷"
    set ib_unitList[74] = 'Ubal'
    set ib_unitName[74] = "ææƒ§é­”ç‹"
    set ib_unitArmor[74] = "hero"
    set ib_unitNameGbk[74] = "¿Ö¾åÄ§Íõ"
    set ib_unitList[75] = 'Uclc'
    set ib_unitName[75] = "å·«å¦–"
    set ib_unitArmor[75] = "hero"
    set ib_unitNameGbk[75] = "Î×Ñı"
    set ib_unitList[76] = 'Ucrl'
    set ib_unitName[76] = ""
    set ib_unitArmor[76] = "hero"
    set ib_unitNameGbk[76] = ""
    set ib_unitList[77] = 'Udea'
    set ib_unitName[77] = "æ­»äº¡éª‘å£«"
    set ib_unitArmor[77] = "hero"
    set ib_unitNameGbk[77] = "ËÀÍöÆïÊ¿"
    set ib_unitList[78] = 'Udre'
    set ib_unitName[78] = "ææƒ§é­”ç‹"
    set ib_unitArmor[78] = "hero"
    set ib_unitNameGbk[78] = "¿Ö¾åÄ§Íõ"
    set ib_unitList[79] = 'Udth'
    set ib_unitName[79] = "ææƒ§é­”ç‹"
    set ib_unitArmor[79] = "hero"
    set ib_unitNameGbk[79] = "¿Ö¾åÄ§Íõ"
endfunction
function IB_UnitFill1 takes nothing returns nothing
    set ib_unitList[80] = 'Uear'
    set ib_unitName[80] = "æ­»äº¡éª‘å£«"
    set ib_unitArmor[80] = "hero"
    set ib_unitNameGbk[80] = "ËÀÍöÆïÊ¿"
    set ib_unitList[81] = 'Uktl'
    set ib_unitName[81] = "å·«å¦–"
    set ib_unitArmor[81] = "hero"
    set ib_unitNameGbk[81] = "Î×Ñı"
    set ib_unitList[82] = 'Ulic'
    set ib_unitName[82] = "å·«å¦–"
    set ib_unitArmor[82] = "hero"
    set ib_unitNameGbk[82] = "Î×Ñı"
    set ib_unitList[83] = 'Umal'
    set ib_unitName[83] = "ææƒ§é­”ç‹"
    set ib_unitArmor[83] = "hero"
    set ib_unitNameGbk[83] = "¿Ö¾åÄ§Íõ"
    set ib_unitList[84] = 'Usyl'
    set ib_unitName[84] = "é»‘æš—æ¸¸ä¾ "
    set ib_unitArmor[84] = "hero"
    set ib_unitNameGbk[84] = "ºÚ°µÓÎÏÀ"
    set ib_unitList[85] = 'Utic'
    set ib_unitName[85] = "ææƒ§é­”ç‹"
    set ib_unitArmor[85] = "divine"
    set ib_unitNameGbk[85] = "¿Ö¾åÄ§Íõ"
    set ib_unitList[86] = 'Uvar'
    set ib_unitName[86] = "ææƒ§é­”ç‹"
    set ib_unitArmor[86] = "hero"
    set ib_unitNameGbk[86] = "¿Ö¾åÄ§Íõ"
    set ib_unitList[87] = 'Uvng'
    set ib_unitName[87] = "ææƒ§é­”ç‹"
    set ib_unitArmor[87] = "hero"
    set ib_unitNameGbk[87] = "¿Ö¾åÄ§Íõ"
    set ib_unitList[88] = 'Uwar'
    set ib_unitName[88] = "å·«å¸ˆ"
    set ib_unitArmor[88] = "divine"
    set ib_unitNameGbk[88] = "Î×Ê¦"
    set ib_unitList[89] = 'eaoe'
    set ib_unitName[89] = "çŸ¥è¯†å¤æ ‘"
    set ib_unitArmor[89] = "fort"
    set ib_unitNameGbk[89] = "ÖªÊ¶¹ÅÊ÷"
    set ib_unitList[90] = 'eaom'
    set ib_unitName[90] = "æˆ˜äº‰å¤æ ‘"
    set ib_unitArmor[90] = "fort"
    set ib_unitNameGbk[90] = "Õ½Õù¹ÅÊ÷"
    set ib_unitList[91] = 'eaow'
    set ib_unitName[91] = "é£ä¹‹å¤æ ‘"
    set ib_unitArmor[91] = "fort"
    set ib_unitNameGbk[91] = "·çÖ®¹ÅÊ÷"
    set ib_unitList[92] = 'earc'
    set ib_unitName[92] = "å¼“ç®­æ‰‹"
    set ib_unitArmor[92] = "medium"
    set ib_unitNameGbk[92] = "¹­¼ıÊÖ"
    set ib_unitList[93] = 'eate'
    set ib_unitName[93] = "é•¿è€…ç¥­å›"
    set ib_unitArmor[93] = "fort"
    set ib_unitNameGbk[93] = "³¤Õß¼ÀÌ³"
    set ib_unitList[94] = 'ebal'
    set ib_unitName[94] = "æŠ•åˆƒè½¦"
    set ib_unitArmor[94] = "large"
    set ib_unitNameGbk[94] = "Í¶ÈĞ³µ"
    set ib_unitList[95] = 'ebsh'
    set ib_unitName[95] = "æš—å¤œç²¾çµæ—æˆ˜èˆ°"
    set ib_unitArmor[95] = "large"
    set ib_unitNameGbk[95] = "°µÒ¹¾«Áé×åÕ½½¢"
    set ib_unitList[96] = 'echm'
    set ib_unitName[96] = "å¥‡ç¾æ‹‰"
    set ib_unitArmor[96] = "small"
    set ib_unitNameGbk[96] = "ÆæÃÀÀ­"
    set ib_unitList[97] = 'edcm'
    set ib_unitName[97] = "åˆ©çˆªå¾·é²ä¼Š"
    set ib_unitArmor[97] = "large"
    set ib_unitNameGbk[97] = "Àû×¦µÂÂ³ÒÁ"
    set ib_unitList[98] = 'eden'
    set ib_unitName[98] = "å¥‡è¿¹å¤æ ‘"
    set ib_unitArmor[98] = "fort"
    set ib_unitNameGbk[98] = "Ææ¼£¹ÅÊ÷"
    set ib_unitList[99] = 'edes'
    set ib_unitName[99] = "æš—å¤œç²¾çµæ—æŠ¤å«èˆ°"
    set ib_unitArmor[99] = "small"
    set ib_unitNameGbk[99] = "°µÒ¹¾«Áé×å»¤ÎÀ½¢"
    set ib_unitList[100] = 'edob'
    set ib_unitName[100] = "çŒæ‰‹å¤§å…"
    set ib_unitArmor[100] = "fort"
    set ib_unitNameGbk[100] = "ÁÔÊÖ´óÌü"
    set ib_unitList[101] = 'edoc'
    set ib_unitName[101] = "åˆ©çˆªå¾·é²ä¼Š"
    set ib_unitArmor[101] = "large"
    set ib_unitNameGbk[101] = "Àû×¦µÂÂ³ÒÁ"
    set ib_unitList[102] = 'edos'
    set ib_unitName[102] = "å¥‡ç¾æ‹‰æ –æœ¨"
    set ib_unitArmor[102] = "fort"
    set ib_unitNameGbk[102] = "ÆæÃÀÀ­ÆÜÄ¾"
    set ib_unitList[103] = 'edot'
    set ib_unitName[103] = "çŒ›ç¦½å¾·é²ä¼Š"
    set ib_unitArmor[103] = "none"
    set ib_unitNameGbk[103] = "ÃÍÇİµÂÂ³ÒÁ"
    set ib_unitList[104] = 'edry'
    set ib_unitName[104] = "æ ‘å¦–"
    set ib_unitArmor[104] = "none"
    set ib_unitNameGbk[104] = "Ê÷Ñı"
    set ib_unitList[105] = 'edtm'
    set ib_unitName[105] = "çŒ›ç¦½å¾·é²ä¼Š"
    set ib_unitArmor[105] = "none"
    set ib_unitNameGbk[105] = "ÃÍÇİµÂÂ³ÒÁ"
    set ib_unitList[106] = 'efdr'
    set ib_unitName[106] = "ç²¾çµé¾™"
    set ib_unitArmor[106] = "small"
    set ib_unitNameGbk[106] = "¾«ÁéÁú"
    set ib_unitList[107] = 'efon'
    set ib_unitName[107] = "æ ‘äºº"
    set ib_unitArmor[107] = "large"
    set ib_unitNameGbk[107] = "Ê÷ÈË"
    set ib_unitList[108] = 'egol'
    set ib_unitName[108] = "è¢«ç¼ ç»•çš„é‡‘çŸ¿"
    set ib_unitArmor[108] = "fort"
    set ib_unitNameGbk[108] = "±»²øÈÆµÄ½ğ¿ó"
    set ib_unitList[109] = 'ehip'
    set ib_unitName[109] = "è§’é¹°å…½"
    set ib_unitArmor[109] = "none"
    set ib_unitNameGbk[109] = "½ÇÓ¥ÊŞ"
    set ib_unitList[110] = 'ehpr'
    set ib_unitName[110] = "è§’é¹°å…½éª‘å£«"
    set ib_unitArmor[110] = "small"
    set ib_unitNameGbk[110] = "½ÇÓ¥ÊŞÆïÊ¿"
    set ib_unitList[111] = 'eilw'
    set ib_unitName[111] = "å›šè½¦"
    set ib_unitArmor[111] = "large"
    set ib_unitNameGbk[111] = "Çô³µ"
    set ib_unitList[112] = 'emow'
    set ib_unitName[112] = "æœˆäº®äº•"
    set ib_unitArmor[112] = "fort"
    set ib_unitNameGbk[112] = "ÔÂÁÁ¾®"
    set ib_unitList[113] = 'emtg'
    set ib_unitName[113] = "å±±å²­å·¨äºº"
    set ib_unitArmor[113] = "medium"
    set ib_unitNameGbk[113] = "É½Áë¾ŞÈË"
    set ib_unitList[114] = 'enec'
    set ib_unitName[114] = "æš—å¤œç²¾çµä¿¡ä½¿"
    set ib_unitArmor[114] = "medium"
    set ib_unitNameGbk[114] = "°µÒ¹¾«ÁéĞÅÊ¹"
    set ib_unitList[115] = 'ensh'
    set ib_unitName[115] = "å¨œè¨"
    set ib_unitArmor[115] = "large"
    set ib_unitNameGbk[115] = "ÄÈÈø"
    set ib_unitList[116] = 'esen'
    set ib_unitName[116] = "å¥³çŒæ‰‹"
    set ib_unitArmor[116] = "none"
    set ib_unitNameGbk[116] = "Å®ÁÔÊÖ"
    set ib_unitList[117] = 'eshd'
    set ib_unitName[117] = "å¡æ©å¾·é‡Œæ–¯"
    set ib_unitArmor[117] = "medium"
    set ib_unitNameGbk[117] = "Èû¶÷µÂÀïË¹"
    set ib_unitList[118] = 'eshy'
    set ib_unitName[118] = "æš—å¤œç²¾çµæ—èˆ¹å"
    set ib_unitArmor[118] = "fort"
    set ib_unitNameGbk[118] = "°µÒ¹¾«Áé×å´¬Îë"
    set ib_unitList[119] = 'espv'
    set ib_unitName[119] = "å¤ä»‡å¤©ç¥"
    set ib_unitArmor[119] = "large"
    set ib_unitNameGbk[119] = "¸´³ğÌìÉñ"
    set ib_unitList[120] = 'etoa'
    set ib_unitName[120] = "è¿œå¤ä¹‹æ ‘"
    set ib_unitArmor[120] = "fort"
    set ib_unitNameGbk[120] = "Ô¶¹ÅÖ®Ê÷"
    set ib_unitList[121] = 'etoe'
    set ib_unitName[121] = "æ°¸æ’ä¹‹æ ‘"
    set ib_unitArmor[121] = "fort"
    set ib_unitNameGbk[121] = "ÓÀºãÖ®Ê÷"
    set ib_unitList[122] = 'etol'
    set ib_unitName[122] = "ç”Ÿå‘½ä¹‹æ ‘"
    set ib_unitArmor[122] = "fort"
    set ib_unitNameGbk[122] = "ÉúÃüÖ®Ê÷"
    set ib_unitList[123] = 'etrp'
    set ib_unitName[123] = "è¿œå¤å®ˆæŠ¤è€…"
    set ib_unitArmor[123] = "fort"
    set ib_unitNameGbk[123] = "Ô¶¹ÅÊØ»¤Õß"
    set ib_unitList[124] = 'etrs'
    set ib_unitName[124] = "æš—å¤œç²¾çµæ—è¿è¾“èˆ¹"
    set ib_unitArmor[124] = "large"
    set ib_unitNameGbk[124] = "°µÒ¹¾«Áé×åÔËÊä´¬"
    set ib_unitList[125] = 'even'
    set ib_unitName[125] = "å¤ä»‡ä¹‹é­‚"
    set ib_unitArmor[125] = "large"
    set ib_unitNameGbk[125] = "¸´³ğÖ®»ê"
    set ib_unitList[126] = 'ewsp'
    set ib_unitName[126] = "å°ç²¾çµ"
    set ib_unitArmor[126] = "medium"
    set ib_unitNameGbk[126] = "Ğ¡¾«Áé"
    set ib_unitList[127] = 'halt'
    set ib_unitName[127] = "å›½ç‹ç¥­å›"
    set ib_unitArmor[127] = "fort"
    set ib_unitNameGbk[127] = "¹úÍõ¼ÀÌ³"
    set ib_unitList[128] = 'harm'
    set ib_unitName[128] = "è½¦é—´"
    set ib_unitArmor[128] = "fort"
    set ib_unitNameGbk[128] = "³µ¼ä"
    set ib_unitList[129] = 'haro'
    set ib_unitName[129] = "ç¥ç§˜äº†æœ›å°"
    set ib_unitArmor[129] = "fort"
    set ib_unitNameGbk[129] = "ÉñÃØÁËÍûÌ¨"
    set ib_unitList[130] = 'hars'
    set ib_unitName[130] = "ç¥ç§˜åœ£åœ°"
    set ib_unitArmor[130] = "fort"
    set ib_unitNameGbk[130] = "ÉñÃØÊ¥µØ"
    set ib_unitList[131] = 'hatw'
    set ib_unitName[131] = "ç¥ç§˜ä¹‹å¡”"
    set ib_unitArmor[131] = "large"
    set ib_unitNameGbk[131] = "ÉñÃØÖ®Ëş"
    set ib_unitList[132] = 'hbar'
    set ib_unitName[132] = "å…µè¥"
    set ib_unitArmor[132] = "fort"
    set ib_unitNameGbk[132] = "±øÓª"
    set ib_unitList[133] = 'hbew'
    set ib_unitName[133] = "è½¦"
    set ib_unitArmor[133] = "large"
    set ib_unitNameGbk[133] = "³µ"
    set ib_unitList[134] = 'hbla'
    set ib_unitName[134] = "é“åŒ é“º"
    set ib_unitArmor[134] = "fort"
    set ib_unitNameGbk[134] = "Ìú½³ÆÌ"
    set ib_unitList[135] = 'hbot'
    set ib_unitName[135] = "äººæ—è¿è¾“èˆ¹"
    set ib_unitArmor[135] = "large"
    set ib_unitNameGbk[135] = "ÈË×åÔËÊä´¬"
    set ib_unitList[136] = 'hbsh'
    set ib_unitName[136] = "äººæ—æˆ˜èˆ°"
    set ib_unitArmor[136] = "large"
    set ib_unitNameGbk[136] = "ÈË×åÕ½½¢"
    set ib_unitList[137] = 'hcas'
    set ib_unitName[137] = "åŸå ¡"
    set ib_unitArmor[137] = "fort"
    set ib_unitNameGbk[137] = "³Ç±¤"
    set ib_unitList[138] = 'hcth'
    set ib_unitName[138] = "èˆ¹é•¿"
    set ib_unitArmor[138] = "large"
    set ib_unitNameGbk[138] = "´¬³¤"
    set ib_unitList[139] = 'hctw'
    set ib_unitName[139] = "ç‚®å¡”"
    set ib_unitArmor[139] = "fort"
    set ib_unitNameGbk[139] = "ÅÚËş"
    set ib_unitList[140] = 'hdes'
    set ib_unitName[140] = "äººæ—æŠ¤å«èˆ°"
    set ib_unitArmor[140] = "small"
    set ib_unitNameGbk[140] = "ÈË×å»¤ÎÀ½¢"
    set ib_unitList[141] = 'hdhw'
    set ib_unitName[141] = "é¾™é¹°éª‘å£«"
    set ib_unitArmor[141] = "small"
    set ib_unitNameGbk[141] = "ÁúÓ¥ÆïÊ¿"
    set ib_unitList[142] = 'hfoo'
    set ib_unitName[142] = "æ­¥å…µ"
    set ib_unitArmor[142] = "large"
    set ib_unitNameGbk[142] = "²½±ø"
    set ib_unitList[143] = 'hgra'
    set ib_unitName[143] = "ç‹®é¹«ç¬¼"
    set ib_unitArmor[143] = "fort"
    set ib_unitNameGbk[143] = "Ê¨ğÕÁı"
    set ib_unitList[144] = 'hgry'
    set ib_unitName[144] = "ç‹®é¹«éª‘å£«"
    set ib_unitArmor[144] = "small"
    set ib_unitNameGbk[144] = "Ê¨ğÕÆïÊ¿"
    set ib_unitList[145] = 'hgtw'
    set ib_unitName[145] = "é˜²å¾¡å¡”"
    set ib_unitArmor[145] = "large"
    set ib_unitNameGbk[145] = "·ÀÓùËş"
    set ib_unitList[146] = 'hgyr'
    set ib_unitName[146] = "é£è¡Œæœºå™¨"
    set ib_unitArmor[146] = "large"
    set ib_unitNameGbk[146] = "·ÉĞĞ»úÆ÷"
    set ib_unitList[147] = 'hhdl'
    set ib_unitName[147] = "æ— äººä¹‹é©¬"
    set ib_unitArmor[147] = "large"
    set ib_unitNameGbk[147] = "ÎŞÈËÖ®Âí"
    set ib_unitList[148] = 'hhes'
    set ib_unitName[148] = "å‰‘å£«"
    set ib_unitArmor[148] = "large"
    set ib_unitNameGbk[148] = "½£Ê¿"
    set ib_unitList[149] = 'hhou'
    set ib_unitName[149] = "å†œåœº"
    set ib_unitArmor[149] = "fort"
    set ib_unitNameGbk[149] = "Å©³¡"
    set ib_unitList[150] = 'hkee'
    set ib_unitName[150] = "ä¸»åŸ"
    set ib_unitArmor[150] = "fort"
    set ib_unitNameGbk[150] = "Ö÷³Ç"
    set ib_unitList[151] = 'hkni'
    set ib_unitName[151] = "éª‘å£«"
    set ib_unitArmor[151] = "large"
    set ib_unitNameGbk[151] = "ÆïÊ¿"
    set ib_unitList[152] = 'hlum'
    set ib_unitName[152] = "ä¼æœ¨åœº"
    set ib_unitArmor[152] = "fort"
    set ib_unitNameGbk[152] = "·¥Ä¾³¡"
    set ib_unitList[153] = 'hmil'
    set ib_unitName[153] = "æ°‘å…µ"
    set ib_unitArmor[153] = "large"
    set ib_unitNameGbk[153] = "Ãñ±ø"
    set ib_unitList[154] = 'hmpr'
    set ib_unitName[154] = "ç‰§å¸ˆ"
    set ib_unitArmor[154] = "none"
    set ib_unitNameGbk[154] = "ÄÁÊ¦"
    set ib_unitList[155] = 'hmtm'
    set ib_unitName[155] = "è¿«å‡»ç‚®å°é˜Ÿ"
    set ib_unitArmor[155] = "large"
    set ib_unitNameGbk[155] = "ÆÈ»÷ÅÚĞ¡¶Ó"
    set ib_unitList[156] = 'hmtt'
    set ib_unitName[156] = "è’¸æ±½æœºè½¦"
    set ib_unitArmor[156] = "fort"
    set ib_unitNameGbk[156] = "ÕôÆû»ú³µ"
    set ib_unitList[157] = 'hpea'
    set ib_unitName[157] = "å†œæ°‘"
    set ib_unitArmor[157] = "medium"
    set ib_unitNameGbk[157] = "Å©Ãñ"
    set ib_unitList[158] = 'hphx'
    set ib_unitName[158] = "ç«å‡¤å‡°"
    set ib_unitArmor[158] = "small"
    set ib_unitNameGbk[158] = "»ğ·ï»Ë"
    set ib_unitList[159] = 'hprt'
    set ib_unitName[159] = "ä¼ é€é—¨"
    set ib_unitArmor[159] = "fort"
    set ib_unitNameGbk[159] = "´«ËÍÃÅ"
endfunction
function IB_UnitFill2 takes nothing returns nothing
    set ib_unitList[160] = 'hpxe'
    set ib_unitName[160] = "å‡¤å‡°è›‹"
    set ib_unitArmor[160] = "large"
    set ib_unitNameGbk[160] = "·ï»Ëµ°"
    set ib_unitList[161] = 'hrdh'
    set ib_unitName[161] = "èƒŒè´ŸèƒŒåŒ…çš„é©¬"
    set ib_unitArmor[161] = "large"
    set ib_unitNameGbk[161] = "±³¸º±³°üµÄÂí"
    set ib_unitList[162] = 'hrif'
    set ib_unitName[162] = "çŸ®äººç«æªæ‰‹"
    set ib_unitArmor[162] = "medium"
    set ib_unitNameGbk[162] = "°«ÈË»ğÇ¹ÊÖ"
    set ib_unitList[163] = 'hrtt'
    set ib_unitName[163] = "è’¸æ±½æœºè½¦"
    set ib_unitArmor[163] = "fort"
    set ib_unitNameGbk[163] = "ÕôÆû»ú³µ"
    set ib_unitList[164] = 'hshy'
    set ib_unitName[164] = "äººæ—èˆ¹å"
    set ib_unitArmor[164] = "fort"
    set ib_unitNameGbk[164] = "ÈË×å´¬Îë"
    set ib_unitList[165] = 'hsor'
    set ib_unitName[165] = "å¥³å·«"
    set ib_unitArmor[165] = "none"
    set ib_unitNameGbk[165] = "Å®Î×"
    set ib_unitList[166] = 'hspt'
    set ib_unitName[166] = "é­”æ³•ç ´åè€…"
    set ib_unitArmor[166] = "medium"
    set ib_unitNameGbk[166] = "Ä§·¨ÆÆ»µÕß"
    set ib_unitList[167] = 'htow'
    set ib_unitName[167] = "åŸé•‡å¤§å…"
    set ib_unitArmor[167] = "fort"
    set ib_unitNameGbk[167] = "³ÇÕò´óÌü"
    set ib_unitList[168] = 'hvlt'
    set ib_unitName[168] = "ç¥ç§˜è—å®å®¤"
    set ib_unitArmor[168] = "fort"
    set ib_unitNameGbk[168] = "ÉñÃØ²Ø±¦ÊÒ"
    set ib_unitList[169] = 'hwat'
    set ib_unitName[169] = "æ°´å…ƒç´ "
    set ib_unitArmor[169] = "large"
    set ib_unitNameGbk[169] = "Ë®ÔªËØ"
    set ib_unitList[170] = 'hwt2'
    set ib_unitName[170] = "æ°´å…ƒç´ "
    set ib_unitArmor[170] = "large"
    set ib_unitNameGbk[170] = "Ë®ÔªËØ"
    set ib_unitList[171] = 'hwt3'
    set ib_unitName[171] = "æ°´å…ƒç´ "
    set ib_unitArmor[171] = "large"
    set ib_unitNameGbk[171] = "Ë®ÔªËØ"
    set ib_unitList[172] = 'hwtw'
    set ib_unitName[172] = "å“¨å¡”"
    set ib_unitArmor[172] = "small"
    set ib_unitNameGbk[172] = "ÉÚËş"
    set ib_unitList[173] = 'nadk'
    set ib_unitName[173] = "è“èœ‰è£"
    set ib_unitArmor[173] = "large"
    set ib_unitNameGbk[173] = "À¶òİòö"
    set ib_unitList[174] = 'nadr'
    set ib_unitName[174] = "è“é¾™"
    set ib_unitArmor[174] = "large"
    set ib_unitNameGbk[174] = "À¶Áú"
    set ib_unitList[175] = 'nadw'
    set ib_unitName[175] = "è“å¹¼é¾™"
    set ib_unitArmor[175] = "large"
    set ib_unitNameGbk[175] = "À¶Ó×Áú"
    set ib_unitList[176] = 'nahy'
    set ib_unitName[176] = "è¿œå¤ä¹å¤´æ€ªè›‡"
    set ib_unitArmor[176] = "large"
    set ib_unitNameGbk[176] = "Ô¶¹Å¾ÅÍ·¹ÖÉß"
    set ib_unitList[177] = 'nalb'
    set ib_unitName[177] = "ä¿¡å¤©ç¿"
    set ib_unitArmor[177] = "medium"
    set ib_unitNameGbk[177] = "ĞÅÌìÎÌ"
    set ib_unitList[178] = 'nanb'
    set ib_unitName[178] = "é˜¿å¡é‚£ç‘Ÿå¾·åˆºäºº"
    set ib_unitArmor[178] = "medium"
    set ib_unitNameGbk[178] = "°¢¿¨ÄÇÉªµÂ´ÌÈË"
    set ib_unitList[179] = 'nanc'
    set ib_unitName[179] = "æ°´æ™¶é˜¿å¡é‚£ç‘Ÿå¾·"
    set ib_unitArmor[179] = "large"
    set ib_unitNameGbk[179] = "Ë®¾§°¢¿¨ÄÇÉªµÂ"
    set ib_unitList[180] = 'nane'
    set ib_unitName[180] = "é˜¿å¡é‚£ç‘Ÿå¾·æ˜åœ°è€…"
    set ib_unitArmor[180] = "medium"
    set ib_unitNameGbk[180] = "°¢¿¨ÄÇÉªµÂ¾òµØÕß"
    set ib_unitList[181] = 'nanm'
    set ib_unitName[181] = "é˜¿å¡é‚£ç‘Ÿå¾·åˆºäºº"
    set ib_unitArmor[181] = "medium"
    set ib_unitNameGbk[181] = "°¢¿¨ÄÇÉªµÂ´ÌÈË"
    set ib_unitList[182] = 'nano'
    set ib_unitName[182] = "é˜¿å¡é‚£ç‘Ÿå¾·é¢†ä¸»"
    set ib_unitArmor[182] = "large"
    set ib_unitNameGbk[182] = "°¢¿¨ÄÇÉªµÂÁìÖ÷"
    set ib_unitList[183] = 'nanw'
    set ib_unitName[183] = "é˜¿å¡é‚£ç‘Ÿå¾·æˆ˜å£«"
    set ib_unitArmor[183] = "large"
    set ib_unitNameGbk[183] = "°¢¿¨ÄÇÉªµÂÕ½Ê¿"
    set ib_unitList[184] = 'narg'
    set ib_unitName[184] = "å‚€å„¡æˆ˜å£«"
    set ib_unitArmor[184] = "medium"
    set ib_unitNameGbk[184] = "¿şÀÜÕ½Ê¿"
    set ib_unitList[185] = 'nass'
    set ib_unitName[185] = "åˆºå®¢"
    set ib_unitArmor[185] = "medium"
    set ib_unitNameGbk[185] = "´Ì¿Í"
    set ib_unitList[186] = 'nba2'
    set ib_unitName[186] = "æ¯ç­å®ˆå«"
    set ib_unitArmor[186] = "large"
    set ib_unitNameGbk[186] = "»ÙÃğÊØÎÀ"
    set ib_unitList[187] = 'nbal'
    set ib_unitName[187] = "æ¯ç­å®ˆå«"
    set ib_unitArmor[187] = "large"
    set ib_unitNameGbk[187] = "»ÙÃğÊØÎÀ"
    set ib_unitList[188] = 'nban'
    set ib_unitName[188] = "å¼ºç›—"
    set ib_unitArmor[188] = "large"
    set ib_unitNameGbk[188] = "Ç¿µÁ"
    set ib_unitList[189] = 'nbda'
    set ib_unitName[189] = "é¾™åµå­¦å¾’"
    set ib_unitArmor[189] = "medium"
    set ib_unitNameGbk[189] = "ÁúÂÑÑ§Í½"
    set ib_unitList[190] = 'nbdk'
    set ib_unitName[190] = "é»‘èœ‰è£"
    set ib_unitArmor[190] = "large"
    set ib_unitNameGbk[190] = "ºÚòİòö"
    set ib_unitList[191] = 'nbdm'
    set ib_unitName[191] = "é¾™åµç›—è´¼"
    set ib_unitArmor[191] = "large"
    set ib_unitNameGbk[191] = "ÁúÂÑµÁÔô"
    set ib_unitList[192] = 'nbdo'
    set ib_unitName[192] = "é¾™åµé¢†ä¸»"
    set ib_unitArmor[192] = "large"
    set ib_unitNameGbk[192] = "ÁúÂÑÁìÖ÷"
    set ib_unitList[193] = 'nbdr'
    set ib_unitName[193] = "é»‘å¹¼é¾™"
    set ib_unitArmor[193] = "large"
    set ib_unitNameGbk[193] = "ºÚÓ×Áú"
    set ib_unitList[194] = 'nbds'
    set ib_unitName[194] = "é¾™ä¹‹ç”·å·«"
    set ib_unitArmor[194] = "medium"
    set ib_unitNameGbk[194] = "ÁúÖ®ÄĞÎ×"
    set ib_unitList[195] = 'nbdw'
    set ib_unitName[195] = "é¾™åµæˆ˜å£«"
    set ib_unitArmor[195] = "large"
    set ib_unitNameGbk[195] = "ÁúÂÑÕ½Ê¿"
    set ib_unitList[196] = 'nbee'
    set ib_unitName[196] = "è¡€ç²¾çµå·¥ç¨‹å¸ˆ"
    set ib_unitArmor[196] = "large"
    set ib_unitNameGbk[196] = "Ñª¾«Áé¹¤³ÌÊ¦"
    set ib_unitList[197] = 'nbel'
    set ib_unitName[197] = "è¡€ç²¾çµä¸­å°‰"
    set ib_unitArmor[197] = "large"
    set ib_unitNameGbk[197] = "Ñª¾«ÁéÖĞÎ¾"
    set ib_unitList[198] = 'nbfl'
    set ib_unitName[198] = "è¡€æµ´ä¹‹æ³‰"
    set ib_unitArmor[198] = "fort"
    set ib_unitNameGbk[198] = "ÑªÔ¡Ö®Èª"
    set ib_unitList[199] = 'nbld'
    set ib_unitName[199] = "å¼ºç›—é¢†ä¸»"
    set ib_unitArmor[199] = "large"
    set ib_unitNameGbk[199] = "Ç¿µÁÁìÖ÷"
    set ib_unitList[200] = 'nbnb'
    set ib_unitName[200] = "é’»åœ°çš„é˜¿å¡é‚£ç‘Ÿå¾·åˆºäºº"
    set ib_unitArmor[200] = "large"
    set ib_unitNameGbk[200] = "×êµØµÄ°¢¿¨ÄÇÉªµÂ´ÌÈË"
    set ib_unitList[201] = 'nbot'
    set ib_unitName[201] = "è¿è¾“èˆ¹"
    set ib_unitArmor[201] = "large"
    set ib_unitNameGbk[201] = "ÔËÊä´¬"
    set ib_unitList[202] = 'nbrg'
    set ib_unitName[202] = "åœŸåŒª"
    set ib_unitArmor[202] = "large"
    set ib_unitNameGbk[202] = "ÍÁ·Ë"
    set ib_unitList[203] = 'nbse'
    set ib_unitName[203] = "å¤æ´»çŸ³"
    set ib_unitArmor[203] = "fort"
    set ib_unitNameGbk[203] = "¸´»îÊ¯"
    set ib_unitList[204] = 'nbsm'
    set ib_unitName[204] = "å¬å”¤åº•åº§ä¹‹ä¹¦"
    set ib_unitArmor[204] = "fort"
    set ib_unitNameGbk[204] = "ÕÙ»½µ××ùÖ®Êé"
    set ib_unitList[205] = 'nbsp'
    set ib_unitName[205] = "èˆ¹åª"
    set ib_unitArmor[205] = "fort"
    set ib_unitNameGbk[205] = "´¬Ö»"
    set ib_unitList[206] = 'nbsw'
    set ib_unitName[206] = "å¤æ´»çŸ³"
    set ib_unitArmor[206] = "fort"
    set ib_unitNameGbk[206] = "¸´»îÊ¯"
    set ib_unitList[207] = 'nbt1'
    set ib_unitName[207] = "å·¨çŸ³ä¹‹å¡”"
    set ib_unitArmor[207] = "fort"
    set ib_unitNameGbk[207] = "¾ŞÊ¯Ö®Ëş"
    set ib_unitList[208] = 'nbt2'
    set ib_unitName[208] = "é«˜çº§å·¨çŸ³ä¹‹å¡”"
    set ib_unitArmor[208] = "fort"
    set ib_unitNameGbk[208] = "¸ß¼¶¾ŞÊ¯Ö®Ëş"
    set ib_unitList[209] = 'nbwd'
    set ib_unitName[209] = "å…½ç©´"
    set ib_unitArmor[209] = "fort"
    set ib_unitNameGbk[209] = "ÊŞÑ¨"
    set ib_unitList[210] = 'nbwm'
    set ib_unitName[210] = "é»‘é¾™"
    set ib_unitArmor[210] = "large"
    set ib_unitNameGbk[210] = "ºÚÁú"
    set ib_unitList[211] = 'nbzd'
    set ib_unitName[211] = "é’é¾™"
    set ib_unitArmor[211] = "large"
    set ib_unitNameGbk[211] = "ÇàÁú"
    set ib_unitList[212] = 'nbzk'
    set ib_unitName[212] = "é’èœ‰è£"
    set ib_unitArmor[212] = "large"
    set ib_unitNameGbk[212] = "Çàòİòö"
    set ib_unitList[213] = 'nbzw'
    set ib_unitName[213] = "é’å¹¼é¾™"
    set ib_unitArmor[213] = "large"
    set ib_unitNameGbk[213] = "ÇàÓ×Áú"
    set ib_unitList[214] = 'ncap'
    set ib_unitName[214] = "è¿œå¤å®ˆæŠ¤è€…"
    set ib_unitArmor[214] = "fort"
    set ib_unitNameGbk[214] = "Ô¶¹ÅÊØ»¤Õß"
    set ib_unitList[215] = 'ncat'
    set ib_unitName[215] = "è¾¾æ‹‰å†…å°”ç²‰ç¢è€…"
    set ib_unitArmor[215] = "large"
    set ib_unitNameGbk[215] = "´ïÀ­ÄÚ¶û·ÛËéÕß"
    set ib_unitList[216] = 'ncaw'
    set ib_unitName[216] = "æˆ˜äº‰å¤æ ‘"
    set ib_unitArmor[216] = "fort"
    set ib_unitNameGbk[216] = "Õ½Õù¹ÅÊ÷"
    set ib_unitList[217] = 'ncb0'
    set ib_unitName[217] = "åŸå¸‚å»ºç­‘ç‰©"
    set ib_unitArmor[217] = "fort"
    set ib_unitNameGbk[217] = "³ÇÊĞ½¨ÖşÎï"
    set ib_unitList[218] = 'ncb1'
    set ib_unitName[218] = "åŸå¸‚å»ºç­‘ç‰©"
    set ib_unitArmor[218] = "fort"
    set ib_unitNameGbk[218] = "³ÇÊĞ½¨ÖşÎï"
    set ib_unitList[219] = 'ncb2'
    set ib_unitName[219] = "åŸå¸‚å»ºç­‘ç‰©"
    set ib_unitArmor[219] = "fort"
    set ib_unitNameGbk[219] = "³ÇÊĞ½¨ÖşÎï"
    set ib_unitList[220] = 'ncb3'
    set ib_unitName[220] = "åŸå¸‚å»ºç­‘ç‰©"
    set ib_unitArmor[220] = "fort"
    set ib_unitNameGbk[220] = "³ÇÊĞ½¨ÖşÎï"
    set ib_unitList[221] = 'ncb4'
    set ib_unitName[221] = "åŸå¸‚å»ºç­‘ç‰©"
    set ib_unitArmor[221] = "fort"
    set ib_unitNameGbk[221] = "³ÇÊĞ½¨ÖşÎï"
    set ib_unitList[222] = 'ncb5'
    set ib_unitName[222] = "åŸå¸‚å»ºç­‘ç‰©"
    set ib_unitArmor[222] = "fort"
    set ib_unitNameGbk[222] = "³ÇÊĞ½¨ÖşÎï"
    set ib_unitList[223] = 'ncb6'
    set ib_unitName[223] = "åŸå¸‚å»ºç­‘ç‰©"
    set ib_unitArmor[223] = "fort"
    set ib_unitNameGbk[223] = "³ÇÊĞ½¨ÖşÎï"
    set ib_unitList[224] = 'ncb7'
    set ib_unitName[224] = "åŸå¸‚å»ºç­‘ç‰©"
    set ib_unitArmor[224] = "fort"
    set ib_unitNameGbk[224] = "³ÇÊĞ½¨ÖşÎï"
    set ib_unitList[225] = 'ncb8'
    set ib_unitName[225] = "åŸå¸‚å»ºç­‘ç‰©"
    set ib_unitArmor[225] = "fort"
    set ib_unitNameGbk[225] = "³ÇÊĞ½¨ÖşÎï"
    set ib_unitList[226] = 'ncb9'
    set ib_unitName[226] = "åŸå¸‚å»ºç­‘ç‰©"
    set ib_unitArmor[226] = "fort"
    set ib_unitNameGbk[226] = "³ÇÊĞ½¨ÖşÎï"
    set ib_unitList[227] = 'ncba'
    set ib_unitName[227] = "åŸå¸‚å»ºç­‘ç‰©"
    set ib_unitArmor[227] = "fort"
    set ib_unitNameGbk[227] = "³ÇÊĞ½¨ÖşÎï"
    set ib_unitList[228] = 'ncbb'
    set ib_unitName[228] = "åŸå¸‚å»ºç­‘ç‰©"
    set ib_unitArmor[228] = "fort"
    set ib_unitNameGbk[228] = "³ÇÊĞ½¨ÖşÎï"
    set ib_unitList[229] = 'ncbc'
    set ib_unitName[229] = "åŸå¸‚å»ºç­‘ç‰©"
    set ib_unitArmor[229] = "fort"
    set ib_unitNameGbk[229] = "³ÇÊĞ½¨ÖşÎï"
    set ib_unitList[230] = 'ncbd'
    set ib_unitName[230] = "åŸå¸‚å»ºç­‘ç‰©"
    set ib_unitArmor[230] = "fort"
    set ib_unitNameGbk[230] = "³ÇÊĞ½¨ÖşÎï"
    set ib_unitList[231] = 'ncbe'
    set ib_unitName[231] = "åŸå¸‚å»ºç­‘ç‰©"
    set ib_unitArmor[231] = "fort"
    set ib_unitNameGbk[231] = "³ÇÊĞ½¨ÖşÎï"
    set ib_unitList[232] = 'ncbf'
    set ib_unitName[232] = "åŸå¸‚å»ºç­‘ç‰©"
    set ib_unitArmor[232] = "fort"
    set ib_unitNameGbk[232] = "³ÇÊĞ½¨ÖşÎï"
    set ib_unitList[233] = 'ncea'
    set ib_unitName[233] = "åŠäººé©¬å¼“ç®­æ‰‹"
    set ib_unitArmor[233] = "large"
    set ib_unitNameGbk[233] = "°ëÈËÂí¹­¼ıÊÖ"
    set ib_unitList[234] = 'ncen'
    set ib_unitName[234] = "åŠäººé©¬å…ˆè¡Œè€…"
    set ib_unitArmor[234] = "large"
    set ib_unitNameGbk[234] = "°ëÈËÂíÏÈĞĞÕß"
    set ib_unitList[235] = 'ncer'
    set ib_unitName[235] = "åŠäººé©¬è‹¦å·¥"
    set ib_unitArmor[235] = "large"
    set ib_unitNameGbk[235] = "°ëÈËÂí¿à¹¤"
    set ib_unitList[236] = 'ncfs'
    set ib_unitName[236] = "æ°´å¥´"
    set ib_unitArmor[236] = "large"
    set ib_unitNameGbk[236] = "Ë®Å«"
    set ib_unitList[237] = 'ncg1'
    set ib_unitName[237] = "äººå·¥åœ°ç²¾"
    set ib_unitArmor[237] = "large"
    set ib_unitNameGbk[237] = "ÈË¹¤µØ¾«"
    set ib_unitList[238] = 'ncg2'
    set ib_unitName[238] = "äººå·¥åœ°ç²¾"
    set ib_unitArmor[238] = "large"
    set ib_unitNameGbk[238] = "ÈË¹¤µØ¾«"
    set ib_unitList[239] = 'ncg3'
    set ib_unitName[239] = "äººå·¥åœ°ç²¾"
    set ib_unitArmor[239] = "large"
    set ib_unitNameGbk[239] = "ÈË¹¤µØ¾«"
endfunction
function IB_UnitFill3 takes nothing returns nothing
    set ib_unitList[240] = 'ncgb'
    set ib_unitName[240] = "äººå·¥åœ°ç²¾"
    set ib_unitArmor[240] = "large"
    set ib_unitNameGbk[240] = "ÈË¹¤µØ¾«"
    set ib_unitList[241] = 'nchg'
    set ib_unitName[241] = "é‚ªæ¶çš„å…½æ—æ­¥å…µ"
    set ib_unitArmor[241] = "large"
    set ib_unitNameGbk[241] = "Ğ°¶ñµÄÊŞ×å²½±ø"
    set ib_unitList[242] = 'nchp'
    set ib_unitName[242] = "ç‰§å¸ˆ"
    set ib_unitArmor[242] = "none"
    set ib_unitNameGbk[242] = "ÄÁÊ¦"
    set ib_unitList[243] = 'nchr'
    set ib_unitName[243] = "é‚ªæ¶çš„æ å¤ºè€…"
    set ib_unitArmor[243] = "small"
    set ib_unitNameGbk[243] = "Ğ°¶ñµÄÂÓ¶áÕß"
    set ib_unitList[244] = 'nchw'
    set ib_unitName[244] = "é‚ªæ¶çš„å·«å¸ˆ"
    set ib_unitArmor[244] = "medium"
    set ib_unitNameGbk[244] = "Ğ°¶ñµÄÎ×Ê¦"
    set ib_unitList[245] = 'ncim'
    set ib_unitName[245] = "åŠäººé©¬åˆºå®¢"
    set ib_unitArmor[245] = "large"
    set ib_unitNameGbk[245] = "°ëÈËÂí´Ì¿Í"
    set ib_unitList[246] = 'nckb'
    set ib_unitName[246] = "é‚ªæ¶çš„ç§‘å¤šå…½"
    set ib_unitArmor[246] = "small"
    set ib_unitNameGbk[246] = "Ğ°¶ñµÄ¿Æ¶àÊŞ"
    set ib_unitList[247] = 'ncks'
    set ib_unitName[247] = "åŠäººé©¬å·«å¸ˆ"
    set ib_unitArmor[247] = "large"
    set ib_unitNameGbk[247] = "°ëÈËÂíÎ×Ê¦"
    set ib_unitList[248] = 'ncmw'
    set ib_unitName[248] = "æœˆäº®äº•"
    set ib_unitArmor[248] = "fort"
    set ib_unitNameGbk[248] = "ÔÂÁÁ¾®"
    set ib_unitList[249] = 'ncnk'
    set ib_unitName[249] = "åŠäººé©¬å¯æ±—"
    set ib_unitArmor[249] = "large"
    set ib_unitNameGbk[249] = "°ëÈËÂí¿Éº¹"
    set ib_unitList[250] = 'ncnt'
    set ib_unitName[250] = "åŠäººé©¬å¸ç¯·"
    set ib_unitArmor[250] = "fort"
    set ib_unitNameGbk[250] = "°ëÈËÂíÕÊÅñ"
    set ib_unitList[251] = 'ncop'
    set ib_unitName[251] = "èƒ½é‡åœˆ"
    set ib_unitArmor[251] = "fort"
    set ib_unitNameGbk[251] = "ÄÜÁ¿È¦"
    set ib_unitList[252] = 'ncp2'
    set ib_unitName[252] = "èƒ½é‡åœˆ"
    set ib_unitArmor[252] = "fort"
    set ib_unitNameGbk[252] = "ÄÜÁ¿È¦"
    set ib_unitList[253] = 'ncp3'
    set ib_unitName[253] = "èƒ½é‡åœˆ"
    set ib_unitArmor[253] = "fort"
    set ib_unitNameGbk[253] = "ÄÜÁ¿È¦"
    set ib_unitList[254] = 'ncpn'
    set ib_unitName[254] = "é‚ªæ¶çš„è‹¦å·¥"
    set ib_unitArmor[254] = "large"
    set ib_unitNameGbk[254] = "Ğ°¶ñµÄ¿à¹¤"
    set ib_unitList[255] = 'ncrb'
    set ib_unitName[255] = "èƒèŸ¹"
    set ib_unitArmor[255] = "medium"
    set ib_unitNameGbk[255] = "ó¦Ğ·"
    set ib_unitList[256] = 'nct1'
    set ib_unitName[256] = "åŠäººé©¬å¸ç¯·"
    set ib_unitArmor[256] = "fort"
    set ib_unitNameGbk[256] = "°ëÈËÂíÕÊÅñ"
    set ib_unitList[257] = 'nct2'
    set ib_unitName[257] = "åŠäººé©¬å¸ç¯·"
    set ib_unitArmor[257] = "fort"
    set ib_unitNameGbk[257] = "°ëÈËÂíÕÊÅñ"
    set ib_unitList[258] = 'ncta'
    set ib_unitName[258] = "è¿œå¤ä¹‹æ ‘"
    set ib_unitArmor[258] = "fort"
    set ib_unitNameGbk[258] = "Ô¶¹ÅÖ®Ê÷"
    set ib_unitList[259] = 'ncte'
    set ib_unitName[259] = "æ°¸æ’ä¹‹æ ‘"
    set ib_unitArmor[259] = "fort"
    set ib_unitNameGbk[259] = "ÓÀºãÖ®Ê÷"
    set ib_unitList[260] = 'nctl'
    set ib_unitName[260] = "ç”Ÿå‘½ä¹‹æ ‘"
    set ib_unitArmor[260] = "fort"
    set ib_unitNameGbk[260] = "ÉúÃüÖ®Ê÷"
    set ib_unitList[261] = 'ndch'
    set ib_unitName[261] = "è¾¾æ‹‰å†…å°”é…‹é•¿ä¹‹å±‹"
    set ib_unitArmor[261] = "fort"
    set ib_unitNameGbk[261] = "´ïÀ­ÄÚ¶ûÇõ³¤Ö®Îİ"
    set ib_unitList[262] = 'nder'
    set ib_unitName[262] = "é›„é¹¿"
    set ib_unitArmor[262] = "medium"
    set ib_unitNameGbk[262] = "ĞÛÂ¹"
    set ib_unitList[263] = 'ndfl'
    set ib_unitName[263] = "è¢«æ±¡æŸ“çš„ç”Ÿå‘½ä¹‹æ³‰"
    set ib_unitArmor[263] = "fort"
    set ib_unitNameGbk[263] = "±»ÎÛÈ¾µÄÉúÃüÖ®Èª"
    set ib_unitList[264] = 'ndgt'
    set ib_unitName[264] = "è¾¾æ‹‰ç„¶å®ˆå«å¡”"
    set ib_unitArmor[264] = "fort"
    set ib_unitNameGbk[264] = "´ïÀ­È»ÊØÎÀËş"
    set ib_unitList[265] = 'ndh0'
    set ib_unitName[265] = "è¾¾æ‹‰å†…å°”å°å±‹"
    set ib_unitArmor[265] = "fort"
    set ib_unitNameGbk[265] = "´ïÀ­ÄÚ¶ûĞ¡Îİ"
    set ib_unitList[266] = 'ndh1'
    set ib_unitName[266] = "è¾¾æ‹‰å†…å°”å°å±‹"
    set ib_unitArmor[266] = "fort"
    set ib_unitNameGbk[266] = "´ïÀ­ÄÚ¶ûĞ¡Îİ"
    set ib_unitList[267] = 'ndh2'
    set ib_unitName[267] = "è¾¾æ‹‰å†…å°”æ¸¯å£"
    set ib_unitArmor[267] = "fort"
    set ib_unitNameGbk[267] = "´ïÀ­ÄÚ¶û¸Û¿Ú"
    set ib_unitList[268] = 'ndh3'
    set ib_unitName[268] = "è¾¾æ‹‰å†…å°”å…µè¥"
    set ib_unitArmor[268] = "fort"
    set ib_unitNameGbk[268] = "´ïÀ­ÄÚ¶û±øÓª"
    set ib_unitList[269] = 'ndh4'
    set ib_unitName[269] = "å…ˆçŸ¥æ´ç©´"
    set ib_unitArmor[269] = "fort"
    set ib_unitNameGbk[269] = "ÏÈÖª¶´Ñ¨"
    set ib_unitList[270] = 'ndke'
    set ib_unitName[270] = "å¼‚æ¬¡å…ƒå¤§é—¨"
    set ib_unitArmor[270] = "fort"
    set ib_unitNameGbk[270] = "Òì´ÎÔª´óÃÅ"
    set ib_unitList[271] = 'ndkw'
    set ib_unitName[271] = "å¼‚æ¬¡å…ƒå¤§é—¨"
    set ib_unitArmor[271] = "fort"
    set ib_unitNameGbk[271] = "Òì´ÎÔª´óÃÅ"
    set ib_unitList[272] = 'ndmg'
    set ib_unitName[272] = "æ¶é­”ä¹‹é—¨"
    set ib_unitArmor[272] = "fort"
    set ib_unitNameGbk[272] = "¶ñÄ§Ö®ÃÅ"
    set ib_unitList[273] = 'ndmu'
    set ib_unitName[273] = "è¾¾æ‹‰ç„¶ä¹‹å˜ç§æ€ªç‰©"
    set ib_unitArmor[273] = "large"
    set ib_unitNameGbk[273] = "´ïÀ­È»Ö®±äÖÖ¹ÖÎï"
    set ib_unitList[274] = 'ndog'
    set ib_unitName[274] = "é‡ç‹—"
    set ib_unitArmor[274] = "medium"
    set ib_unitNameGbk[274] = "Ò°¹·"
    set ib_unitList[275] = 'ndqn'
    set ib_unitName[275] = "å¥³å¦–ç²¾"
    set ib_unitArmor[275] = "large"
    set ib_unitNameGbk[275] = "Å®Ñı¾«"
    set ib_unitList[276] = 'ndqp'
    set ib_unitName[276] = "ç—›è‹¦å°‘å¥³"
    set ib_unitArmor[276] = "large"
    set ib_unitNameGbk[276] = "Í´¿àÉÙÅ®"
    set ib_unitList[277] = 'ndqs'
    set ib_unitName[277] = "è‹¦éš¾å¥³ç‹"
    set ib_unitArmor[277] = "large"
    set ib_unitNameGbk[277] = "¿àÄÑÅ®Íõ"
    set ib_unitList[278] = 'ndqt'
    set ib_unitName[278] = "æ¶å¦‡"
    set ib_unitArmor[278] = "large"
    set ib_unitNameGbk[278] = "¶ñ¸¾"
    set ib_unitList[279] = 'ndqv'
    set ib_unitName[279] = "æ¶ç”·"
    set ib_unitArmor[279] = "medium"
    set ib_unitNameGbk[279] = "¶ñÄĞ"
    set ib_unitList[280] = 'ndr1'
    set ib_unitName[280] = "å°é»‘æš—ä¹‹å¥´"
    set ib_unitArmor[280] = "large"
    set ib_unitNameGbk[280] = "Ğ¡ºÚ°µÖ®Å«"
    set ib_unitList[281] = 'ndr2'
    set ib_unitName[281] = "é»‘æš—ä¹‹å¥´"
    set ib_unitArmor[281] = "large"
    set ib_unitNameGbk[281] = "ºÚ°µÖ®Å«"
    set ib_unitList[282] = 'ndr3'
    set ib_unitName[282] = "å¤§é»‘æš—ä¹‹å¥´"
    set ib_unitArmor[282] = "large"
    set ib_unitNameGbk[282] = "´óºÚ°µÖ®Å«"
    set ib_unitList[283] = 'ndrb'
    set ib_unitName[283] = "é¾™ä¹‹æ –æœ¨"
    set ib_unitArmor[283] = "fort"
    set ib_unitNameGbk[283] = "ÁúÖ®ÆÜÄ¾"
    set ib_unitList[284] = 'ndrd'
    set ib_unitName[284] = "è¾¾æ‹‰å†…å°”æš—é»‘å± æ€è€…"
    set ib_unitArmor[284] = "large"
    set ib_unitNameGbk[284] = "´ïÀ­ÄÚ¶û°µºÚÍÀÉ±Õß"
    set ib_unitList[285] = 'ndrf'
    set ib_unitName[285] = "è¾¾æ‹‰å†…å°”å®ˆå«"
    set ib_unitArmor[285] = "large"
    set ib_unitNameGbk[285] = "´ïÀ­ÄÚ¶ûÊØÎÀ"
    set ib_unitList[286] = 'ndrg'
    set ib_unitName[286] = "ç»¿é¾™å·¢ç©´"
    set ib_unitArmor[286] = "fort"
    set ib_unitNameGbk[286] = "ÂÌÁú³²Ñ¨"
    set ib_unitList[287] = 'ndrh'
    set ib_unitName[287] = "è¾¾æ‹‰å†…å°”å…ˆé©±"
    set ib_unitArmor[287] = "medium"
    set ib_unitNameGbk[287] = "´ïÀ­ÄÚ¶ûÏÈÇı"
    set ib_unitList[288] = 'ndrj'
    set ib_unitName[288] = "è¾¾æ‹‰ç„¶ä¹‹å­¤èƒ†æ€ªç‰©"
    set ib_unitArmor[288] = "medium"
    set ib_unitNameGbk[288] = "´ïÀ­È»Ö®¹Âµ¨¹ÖÎï"
    set ib_unitList[289] = 'ndrk'
    set ib_unitName[289] = "é»‘é¾™å·¢ç©´"
    set ib_unitArmor[289] = "fort"
    set ib_unitNameGbk[289] = "ºÚÁú³²Ñ¨"
    set ib_unitList[290] = 'ndrl'
    set ib_unitName[290] = "è¾¾æ‹‰å†…å°”å·¥äºº"
    set ib_unitArmor[290] = "medium"
    set ib_unitNameGbk[290] = "´ïÀ­ÄÚ¶û¹¤ÈË"
    set ib_unitList[291] = 'ndrm'
    set ib_unitName[291] = "è¾¾æ‹‰å†…å°”ä¿¡å¾’"
    set ib_unitArmor[291] = "medium"
    set ib_unitNameGbk[291] = "´ïÀ­ÄÚ¶ûĞÅÍ½"
    set ib_unitList[292] = 'ndrn'
    set ib_unitName[292] = "è¾¾æ‹‰å†…å°”è¾©æŠ¤è€…"
    set ib_unitArmor[292] = "large"
    set ib_unitNameGbk[292] = "´ïÀ­ÄÚ¶û±ç»¤Õß"
    set ib_unitList[293] = 'ndro'
    set ib_unitName[293] = "è€ç‘Ÿé¾™æ –æœ¨"
    set ib_unitArmor[293] = "fort"
    set ib_unitNameGbk[293] = "ÄÍÉªÁúÆÜÄ¾"
    set ib_unitList[294] = 'ndrp'
    set ib_unitName[294] = "è¾¾æ‹‰å†…å°”æŠ¤å«"
    set ib_unitArmor[294] = "large"
    set ib_unitNameGbk[294] = "´ïÀ­ÄÚ¶û»¤ÎÀ"
    set ib_unitList[295] = 'ndrr'
    set ib_unitName[295] = "çº¢é¾™å·¢ç©´"
    set ib_unitArmor[295] = "fort"
    set ib_unitNameGbk[295] = "ºìÁú³²Ñ¨"
    set ib_unitList[296] = 'ndrs'
    set ib_unitName[296] = "è¾¾æ‹‰å†…å°”å…ˆçŸ¥"
    set ib_unitArmor[296] = "large"
    set ib_unitNameGbk[296] = "´ïÀ­ÄÚ¶ûÏÈÖª"
    set ib_unitList[297] = 'ndrt'
    set ib_unitName[297] = "è¾¾æ‹‰å†…å°”æ¼«æ­¥è€…"
    set ib_unitArmor[297] = "large"
    set ib_unitNameGbk[297] = "´ïÀ­ÄÚ¶ûÂş²½Õß"
    set ib_unitList[298] = 'ndru'
    set ib_unitName[298] = "è“é¾™å·¢ç©´"
    set ib_unitArmor[298] = "fort"
    set ib_unitNameGbk[298] = "À¶Áú³²Ñ¨"
    set ib_unitList[299] = 'ndrv'
    set ib_unitName[299] = "æ·±æ¸Šå¹½çµ"
    set ib_unitArmor[299] = "large"
    set ib_unitNameGbk[299] = "ÉîÔ¨ÓÄÁé"
    set ib_unitList[300] = 'ndrw'
    set ib_unitName[300] = "è¾¾æ‹‰å†…å°”å“¨å…µ"
    set ib_unitArmor[300] = "large"
    set ib_unitNameGbk[300] = "´ïÀ­ÄÚ¶ûÉÚ±ø"
    set ib_unitList[301] = 'ndrz'
    set ib_unitName[301] = "é’é¾™å·¢ç©´"
    set ib_unitArmor[301] = "fort"
    set ib_unitNameGbk[301] = "ÇàÁú³²Ñ¨"
    set ib_unitList[302] = 'ndsa'
    set ib_unitName[302] = "ç«èœ¥èœ´"
    set ib_unitArmor[302] = "medium"
    set ib_unitNameGbk[302] = "»ğòáòæ"
    set ib_unitList[303] = 'ndt1'
    set ib_unitName[303] = "å†°éœœä¹‹å¡”"
    set ib_unitArmor[303] = "fort"
    set ib_unitNameGbk[303] = "±ùËªÖ®Ëş"
    set ib_unitList[304] = 'ndt2'
    set ib_unitName[304] = "é«˜çº§å†°éœœä¹‹å¡”"
    set ib_unitArmor[304] = "fort"
    set ib_unitNameGbk[304] = "¸ß¼¶±ùËªÖ®Ëş"
    set ib_unitList[305] = 'ndtb'
    set ib_unitName[305] = "é»‘é­”ç‹‚æˆ˜å£«"
    set ib_unitArmor[305] = "medium"
    set ib_unitNameGbk[305] = "ºÚÄ§¿ñÕ½Ê¿"
    set ib_unitList[306] = 'ndth'
    set ib_unitName[306] = "é»‘é­”é«˜çº§ç‰§å¸ˆ"
    set ib_unitArmor[306] = "medium"
    set ib_unitNameGbk[306] = "ºÚÄ§¸ß¼¶ÄÁÊ¦"
    set ib_unitList[307] = 'ndtp'
    set ib_unitName[307] = "é»‘é­”å½±å­ç‰§å¸ˆ"
    set ib_unitArmor[307] = "large"
    set ib_unitNameGbk[307] = "ºÚÄ§Ó°×ÓÄÁÊ¦"
    set ib_unitList[308] = 'ndtr'
    set ib_unitName[308] = "é»‘æš—å·¨é­”"
    set ib_unitArmor[308] = "large"
    set ib_unitNameGbk[308] = "ºÚ°µ¾ŞÄ§"
    set ib_unitList[309] = 'ndtt'
    set ib_unitName[309] = "é»‘é­”çŒæ‰‹"
    set ib_unitArmor[309] = "medium"
    set ib_unitNameGbk[309] = "ºÚÄ§ÁÔÊÖ"
    set ib_unitList[310] = 'ndtw'
    set ib_unitName[310] = "é»‘é­”é¦–é¢†"
    set ib_unitArmor[310] = "large"
    set ib_unitNameGbk[310] = "ºÚÄ§Ê×Áì"
    set ib_unitList[311] = 'ndwm'
    set ib_unitName[311] = "æ²™ä¸˜ä¹‹è™«"
    set ib_unitArmor[311] = "medium"
    set ib_unitNameGbk[311] = "É³ÇğÖ®³æ"
    set ib_unitList[312] = 'nech'
    set ib_unitName[312] = "å°é¸¡"
    set ib_unitArmor[312] = "medium"
    set ib_unitNameGbk[312] = "Ğ¡¼¦"
    set ib_unitList[313] = 'necr'
    set ib_unitName[313] = "å…”å­"
    set ib_unitArmor[313] = "medium"
    set ib_unitNameGbk[313] = "ÍÃ×Ó"
    set ib_unitList[314] = 'nef0'
    set ib_unitName[314] = "é«˜ç­‰ç²¾çµå†œåœº"
    set ib_unitArmor[314] = "fort"
    set ib_unitNameGbk[314] = "¸ßµÈ¾«ÁéÅ©³¡"
    set ib_unitList[315] = 'nef1'
    set ib_unitName[315] = "é«˜ç­‰ç²¾çµå†œåœº"
    set ib_unitArmor[315] = "fort"
    set ib_unitNameGbk[315] = "¸ßµÈ¾«ÁéÅ©³¡"
    set ib_unitList[316] = 'nef2'
    set ib_unitName[316] = "é«˜ç­‰ç²¾çµå†œåœº"
    set ib_unitArmor[316] = "fort"
    set ib_unitNameGbk[316] = "¸ßµÈ¾«ÁéÅ©³¡"
    set ib_unitList[317] = 'nef3'
    set ib_unitName[317] = "é«˜ç­‰ç²¾çµå†œåœº"
    set ib_unitArmor[317] = "fort"
    set ib_unitNameGbk[317] = "¸ßµÈ¾«ÁéÅ©³¡"
    set ib_unitList[318] = 'nef4'
    set ib_unitName[318] = "é«˜ç­‰ç²¾çµå†œåœº"
    set ib_unitArmor[318] = "fort"
    set ib_unitNameGbk[318] = "¸ßµÈ¾«ÁéÅ©³¡"
    set ib_unitList[319] = 'nef5'
    set ib_unitName[319] = "é«˜ç­‰ç²¾çµå†œåœº"
    set ib_unitArmor[319] = "fort"
    set ib_unitNameGbk[319] = "¸ßµÈ¾«ÁéÅ©³¡"
endfunction
function IB_UnitFill4 takes nothing returns nothing
    set ib_unitList[320] = 'nef6'
    set ib_unitName[320] = "é«˜ç­‰ç²¾çµå†œåœº"
    set ib_unitArmor[320] = "fort"
    set ib_unitNameGbk[320] = "¸ßµÈ¾«ÁéÅ©³¡"
    set ib_unitList[321] = 'nef7'
    set ib_unitName[321] = "é«˜ç­‰ç²¾çµå†œåœº"
    set ib_unitArmor[321] = "fort"
    set ib_unitNameGbk[321] = "¸ßµÈ¾«ÁéÅ©³¡"
    set ib_unitList[322] = 'nefm'
    set ib_unitName[322] = "é«˜ç­‰ç²¾çµå†œåœº"
    set ib_unitArmor[322] = "fort"
    set ib_unitNameGbk[322] = "¸ßµÈ¾«ÁéÅ©³¡"
    set ib_unitList[323] = 'negf'
    set ib_unitName[323] = "åœ°æ€’ä¹‹å¡”"
    set ib_unitArmor[323] = "fort"
    set ib_unitNameGbk[323] = "µØÅ­Ö®Ëş"
    set ib_unitList[324] = 'negm'
    set ib_unitName[324] = "å¤©æ€’ä¹‹å¡”"
    set ib_unitArmor[324] = "fort"
    set ib_unitNameGbk[324] = "ÌìÅ­Ö®Ëş"
    set ib_unitList[325] = 'negt'
    set ib_unitName[325] = "é«˜ç­‰ç²¾çµé˜²å¾¡å¡”"
    set ib_unitArmor[325] = "fort"
    set ib_unitNameGbk[325] = "¸ßµÈ¾«Áé·ÀÓùËş"
    set ib_unitList[326] = 'negz'
    set ib_unitName[326] = "å·¥ç¨‹å¸ˆåŠ å…¹åŠ³"
    set ib_unitArmor[326] = "large"
    set ib_unitNameGbk[326] = "¹¤³ÌÊ¦¼Ó×ÈÀÍ"
    set ib_unitList[327] = 'nehy'
    set ib_unitName[327] = "ä¹å¤´æ€ªè›‡é•¿è€…"
    set ib_unitArmor[327] = "large"
    set ib_unitNameGbk[327] = "¾ÅÍ·¹ÖÉß³¤Õß"
    set ib_unitList[328] = 'nelb'
    set ib_unitName[328] = "ç‹‚æš´å…ƒç´ "
    set ib_unitArmor[328] = "large"
    set ib_unitNameGbk[328] = "¿ñ±©ÔªËØ"
    set ib_unitList[329] = 'nele'
    set ib_unitName[329] = "ç‹‚æ€’å…ƒç´ "
    set ib_unitArmor[329] = "large"
    set ib_unitNameGbk[329] = "¿ñÅ­ÔªËØ"
    set ib_unitList[330] = 'nemi'
    set ib_unitName[330] = "ä½¿è€…"
    set ib_unitArmor[330] = "medium"
    set ib_unitNameGbk[330] = "Ê¹Õß"
    set ib_unitList[331] = 'nenc'
    set ib_unitName[331] = "å •è½æ ‘äºº"
    set ib_unitArmor[331] = "large"
    set ib_unitNameGbk[331] = "¶éÂäÊ÷ÈË"
    set ib_unitList[332] = 'nenf'
    set ib_unitName[332] = "å¼ºåˆ¶è€…"
    set ib_unitArmor[332] = "large"
    set ib_unitNameGbk[332] = "Ç¿ÖÆÕß"
    set ib_unitList[333] = 'nenp'
    set ib_unitName[333] = "æ¯’æ€§æ ‘äºº"
    set ib_unitArmor[333] = "large"
    set ib_unitNameGbk[333] = "¶¾ĞÔÊ÷ÈË"
    set ib_unitList[334] = 'nepl'
    set ib_unitName[334] = "ç¾ç¥¸æ ‘äºº"
    set ib_unitArmor[334] = "large"
    set ib_unitNameGbk[334] = "ÔÖ»öÊ÷ÈË"
    set ib_unitList[335] = 'nerd'
    set ib_unitName[335] = "åŸƒç‘è¾¾-ä¿¡é­”è€…"
    set ib_unitArmor[335] = "large"
    set ib_unitNameGbk[335] = "°£Èğ´ï-ĞÅÄ§Õß"
    set ib_unitList[336] = 'ners'
    set ib_unitName[336] = "åŸƒç‘è¾¾ç”·å·«"
    set ib_unitArmor[336] = "large"
    set ib_unitNameGbk[336] = "°£Èğ´ïÄĞÎ×"
    set ib_unitList[337] = 'nerw'
    set ib_unitName[337] = "åŸƒç‘è¾¾æ³•å¸ˆ"
    set ib_unitArmor[337] = "large"
    set ib_unitNameGbk[337] = "°£Èğ´ï·¨Ê¦"
    set ib_unitList[338] = 'net1'
    set ib_unitName[338] = "èƒ½é‡ä¹‹å¡”"
    set ib_unitArmor[338] = "fort"
    set ib_unitNameGbk[338] = "ÄÜÁ¿Ö®Ëş"
    set ib_unitList[339] = 'net2'
    set ib_unitName[339] = "é«˜çº§èƒ½é‡ä¹‹å¡”"
    set ib_unitArmor[339] = "fort"
    set ib_unitNameGbk[339] = "¸ß¼¶ÄÜÁ¿Ö®Ëş"
    set ib_unitList[340] = 'nfa1'
    set ib_unitName[340] = "å£è¢‹å·¥å‚"
    set ib_unitArmor[340] = "medium"
    set ib_unitNameGbk[340] = "¿Ú´ü¹¤³§"
    set ib_unitList[341] = 'nfa2'
    set ib_unitName[341] = "å£è¢‹å·¥å‚"
    set ib_unitArmor[341] = "medium"
    set ib_unitNameGbk[341] = "¿Ú´ü¹¤³§"
    set ib_unitList[342] = 'nfac'
    set ib_unitName[342] = "å£è¢‹å·¥å‚"
    set ib_unitArmor[342] = "medium"
    set ib_unitNameGbk[342] = "¿Ú´ü¹¤³§"
    set ib_unitList[343] = 'nfbr'
    set ib_unitName[343] = "é‡çŒª"
    set ib_unitArmor[343] = "medium"
    set ib_unitNameGbk[343] = "Ò°Öí"
    set ib_unitList[344] = 'nfel'
    set ib_unitName[344] = "é‚ªæ¶æ¼«æ­¥è€…"
    set ib_unitArmor[344] = "large"
    set ib_unitNameGbk[344] = "Ğ°¶ñÂş²½Õß"
    set ib_unitList[345] = 'nfgb'
    set ib_unitName[345] = "è¡€æ¶é­”"
    set ib_unitArmor[345] = "large"
    set ib_unitNameGbk[345] = "Ñª¶ñÄ§"
    set ib_unitList[346] = 'nfgl'
    set ib_unitName[346] = "çµè‚‰å‚€å„¡"
    set ib_unitArmor[346] = "medium"
    set ib_unitNameGbk[346] = "ÁéÈâ¿şÀÜ"
    set ib_unitList[347] = 'nfgo'
    set ib_unitName[347] = "é—å¿˜è€…"
    set ib_unitArmor[347] = "large"
    set ib_unitNameGbk[347] = "ÒÅÍüÕß"
    set ib_unitList[348] = 'nfgt'
    set ib_unitName[348] = "è§¦é¡»"
    set ib_unitArmor[348] = "large"
    set ib_unitNameGbk[348] = "´¥Ğë"
    set ib_unitList[349] = 'nfgu'
    set ib_unitName[349] = "ç‹‚æš´å®ˆå«"
    set ib_unitArmor[349] = "large"
    set ib_unitNameGbk[349] = "¿ñ±©ÊØÎÀ"
    set ib_unitList[350] = 'nfh0'
    set ib_unitName[350] = "æ£®æ—å·¨é­”å°å±‹"
    set ib_unitArmor[350] = "fort"
    set ib_unitNameGbk[350] = "É­ÁÖ¾ŞÄ§Ğ¡Îİ"
    set ib_unitList[351] = 'nfh1'
    set ib_unitName[351] = "æ£®æ—å·¨é­”å°å±‹"
    set ib_unitArmor[351] = "fort"
    set ib_unitNameGbk[351] = "É­ÁÖ¾ŞÄ§Ğ¡Îİ"
    set ib_unitList[352] = 'nfnp'
    set ib_unitName[352] = "å¨åŠ›ä¹‹æ³‰"
    set ib_unitArmor[352] = "fort"
    set ib_unitNameGbk[352] = "ÍşÁ¦Ö®Èª"
    set ib_unitList[353] = 'nfod'
    set ib_unitName[353] = "æ— åæ­»çµ"
    set ib_unitArmor[353] = "large"
    set ib_unitNameGbk[353] = "ÎŞÃûËÀÁé"
    set ib_unitList[354] = 'nfoh'
    set ib_unitName[354] = "ç”Ÿå‘½ä¹‹æ³‰"
    set ib_unitArmor[354] = "fort"
    set ib_unitNameGbk[354] = "ÉúÃüÖ®Èª"
    set ib_unitList[355] = 'nfor'
    set ib_unitName[355] = "æ— åéª—å£«"
    set ib_unitArmor[355] = "large"
    set ib_unitNameGbk[355] = "ÎŞÃûÆ­Ê¿"
    set ib_unitList[356] = 'nfot'
    set ib_unitName[356] = "æ— åææ€–è€…"
    set ib_unitArmor[356] = "large"
    set ib_unitNameGbk[356] = "ÎŞÃû¿Ö²ÀÕß"
    set ib_unitList[357] = 'nfov'
    set ib_unitName[357] = "é¢†ä¸»"
    set ib_unitArmor[357] = "large"
    set ib_unitNameGbk[357] = "ÁìÖ÷"
    set ib_unitList[358] = 'nfpc'
    set ib_unitName[358] = "åŒ—æç†Šæ€ªæˆ˜å£«"
    set ib_unitArmor[358] = "large"
    set ib_unitNameGbk[358] = "±±¼«ĞÜ¹ÖÕ½Ê¿"
    set ib_unitList[359] = 'nfpe'
    set ib_unitName[359] = "åŒ—æç†Šæ€ªè¨æ»¡é•¿è€…"
    set ib_unitArmor[359] = "large"
    set ib_unitNameGbk[359] = "±±¼«ĞÜ¹ÖÈøÂú³¤Õß"
    set ib_unitList[360] = 'nfpl'
    set ib_unitName[360] = "åŒ—æç†Šæ€ª"
    set ib_unitArmor[360] = "large"
    set ib_unitNameGbk[360] = "±±¼«ĞÜ¹Ö"
    set ib_unitList[361] = 'nfps'
    set ib_unitName[361] = "åŒ—æç†Šæ€ªè¨æ»¡"
    set ib_unitArmor[361] = "medium"
    set ib_unitNameGbk[361] = "±±¼«ĞÜ¹ÖÈøÂú"
    set ib_unitList[362] = 'nfpt'
    set ib_unitName[362] = "åŒ—æç†Šæ€ªè¿½è¸ªè€…"
    set ib_unitArmor[362] = "large"
    set ib_unitNameGbk[362] = "±±¼«ĞÜ¹Ö×·×ÙÕß"
    set ib_unitList[363] = 'nfpu'
    set ib_unitName[363] = "åŒ—æç†Šæ€ªä¹Œè¨æˆ˜å£«"
    set ib_unitArmor[363] = "large"
    set ib_unitNameGbk[363] = "±±¼«ĞÜ¹ÖÎÚÈøÕ½Ê¿"
    set ib_unitList[364] = 'nfr1'
    set ib_unitName[364] = "ç†Šæ€ªå°å±‹"
    set ib_unitArmor[364] = "fort"
    set ib_unitNameGbk[364] = "ĞÜ¹ÖĞ¡Îİ"
    set ib_unitList[365] = 'nfr2'
    set ib_unitName[365] = "ç†Šæ€ªå°å±‹"
    set ib_unitArmor[365] = "fort"
    set ib_unitNameGbk[365] = "ĞÜ¹ÖĞ¡Îİ"
    set ib_unitList[366] = 'nfra'
    set ib_unitName[366] = "ç†Šæ€ªä¹Œè¨æˆ˜å£«"
    set ib_unitArmor[366] = "large"
    set ib_unitNameGbk[366] = "ĞÜ¹ÖÎÚÈøÕ½Ê¿"
    set ib_unitList[367] = 'nfrb'
    set ib_unitName[367] = "ç†Šæ€ªè¿½è¸ªè€…"
    set ib_unitArmor[367] = "large"
    set ib_unitNameGbk[367] = "ĞÜ¹Ö×·×ÙÕß"
    set ib_unitList[368] = 'nfre'
    set ib_unitName[368] = "ç†Šæ€ªè¨æ»¡é•¿è€…"
    set ib_unitArmor[368] = "large"
    set ib_unitNameGbk[368] = "ĞÜ¹ÖÈøÂú³¤Õß"
    set ib_unitList[369] = 'nfrg'
    set ib_unitName[369] = "ç†Šæ€ªæˆ˜å£«"
    set ib_unitArmor[369] = "large"
    set ib_unitNameGbk[369] = "ĞÜ¹ÖÕ½Ê¿"
    set ib_unitList[370] = 'nfrl'
    set ib_unitName[370] = "ç†Šæ€ª"
    set ib_unitArmor[370] = "large"
    set ib_unitNameGbk[370] = "ĞÜ¹Ö"
    set ib_unitList[371] = 'nfrm'
    set ib_unitName[371] = "éœœä¹‹å“€ä¼¤åº•åº§"
    set ib_unitArmor[371] = "fort"
    set ib_unitNameGbk[371] = "ËªÖ®°§ÉËµ××ù"
    set ib_unitList[372] = 'nfro'
    set ib_unitName[372] = "é’è›™"
    set ib_unitArmor[372] = "medium"
    set ib_unitNameGbk[372] = "ÇàÍÜ"
    set ib_unitList[373] = 'nfrp'
    set ib_unitName[373] = "ç†ŠçŒ«"
    set ib_unitArmor[373] = "large"
    set ib_unitNameGbk[373] = "ĞÜÃ¨"
    set ib_unitList[374] = 'nfrs'
    set ib_unitName[374] = "ç†Šæ€ªè¨æ»¡"
    set ib_unitArmor[374] = "medium"
    set ib_unitNameGbk[374] = "ĞÜ¹ÖÈøÂú"
    set ib_unitList[375] = 'nfrt'
    set ib_unitName[375] = "æ°´æœåº—"
    set ib_unitArmor[375] = "fort"
    set ib_unitNameGbk[375] = "Ë®¹ûµê"
    set ib_unitList[376] = 'nfsh'
    set ib_unitName[376] = "æ ‘é­”é«˜çº§ç‰§å¸ˆ"
    set ib_unitArmor[376] = "medium"
    set ib_unitNameGbk[376] = "Ê÷Ä§¸ß¼¶ÄÁÊ¦"
    set ib_unitList[377] = 'nfsp'
    set ib_unitName[377] = "æ ‘é­”å½±å­ç‰§å¸ˆ"
    set ib_unitArmor[377] = "large"
    set ib_unitNameGbk[377] = "Ê÷Ä§Ó°×ÓÄÁÊ¦"
    set ib_unitList[378] = 'nft1'
    set ib_unitName[378] = "ç«ç„°ä¹‹å¡”"
    set ib_unitArmor[378] = "fort"
    set ib_unitNameGbk[378] = "»ğÑæÖ®Ëş"
    set ib_unitList[379] = 'nft2'
    set ib_unitName[379] = "é«˜çº§ç«ç„°ä¹‹å¡”"
    set ib_unitArmor[379] = "fort"
    set ib_unitNameGbk[379] = "¸ß¼¶»ğÑæÖ®Ëş"
    set ib_unitList[380] = 'nftb'
    set ib_unitName[380] = "æ ‘é­”ç‹‚æˆ˜å£«"
    set ib_unitArmor[380] = "medium"
    set ib_unitNameGbk[380] = "Ê÷Ä§¿ñÕ½Ê¿"
    set ib_unitList[381] = 'nftk'
    set ib_unitName[381] = "æ ‘é­”é¦–é¢†"
    set ib_unitArmor[381] = "large"
    set ib_unitNameGbk[381] = "Ê÷Ä§Ê×Áì"
    set ib_unitList[382] = 'nftr'
    set ib_unitName[382] = "æ£®æ—å·¨é­”"
    set ib_unitArmor[382] = "large"
    set ib_unitNameGbk[382] = "É­ÁÖ¾ŞÄ§"
    set ib_unitList[383] = 'nftt'
    set ib_unitName[383] = "æ ‘é­”çŒæ‰‹"
    set ib_unitArmor[383] = "medium"
    set ib_unitNameGbk[383] = "Ê÷Ä§ÁÔÊÖ"
    set ib_unitList[384] = 'nfv0'
    set ib_unitName[384] = "æš—å¤œç²¾çµæ—æ¸”æ‘"
    set ib_unitArmor[384] = "fort"
    set ib_unitNameGbk[384] = "°µÒ¹¾«Áé×åÓæ´å"
    set ib_unitList[385] = 'nfv1'
    set ib_unitName[385] = "æš—å¤œç²¾çµæ—æ¸”æ‘"
    set ib_unitArmor[385] = "fort"
    set ib_unitNameGbk[385] = "°µÒ¹¾«Áé×åÓæ´å"
    set ib_unitList[386] = 'nfv2'
    set ib_unitName[386] = "æš—å¤œç²¾çµæ—æ¸”æ‘"
    set ib_unitArmor[386] = "fort"
    set ib_unitNameGbk[386] = "°µÒ¹¾«Áé×åÓæ´å"
    set ib_unitList[387] = 'nfv3'
    set ib_unitName[387] = "æš—å¤œç²¾çµæ—æ¸”æ‘"
    set ib_unitArmor[387] = "fort"
    set ib_unitNameGbk[387] = "°µÒ¹¾«Áé×åÓæ´å"
    set ib_unitList[388] = 'nfv4'
    set ib_unitName[388] = "æš—å¤œç²¾çµæ—æ¸”æ‘"
    set ib_unitArmor[388] = "fort"
    set ib_unitNameGbk[388] = "°µÒ¹¾«Áé×åÓæ´å"
    set ib_unitList[389] = 'ngad'
    set ib_unitName[389] = "åœ°ç²¾å®éªŒå®¤"
    set ib_unitArmor[389] = "fort"
    set ib_unitNameGbk[389] = "µØ¾«ÊµÑéÊÒ"
    set ib_unitList[390] = 'ngbl'
    set ib_unitName[390] = "åœ°ç²¾çˆ†ç ´å·¥"
    set ib_unitArmor[390] = "large"
    set ib_unitNameGbk[390] = "µØ¾«±¬ÆÆ¹¤"
    set ib_unitList[391] = 'ngdk'
    set ib_unitName[391] = "ç»¿èœ‰è£"
    set ib_unitArmor[391] = "large"
    set ib_unitNameGbk[391] = "ÂÌòİòö"
    set ib_unitList[392] = 'nggr'
    set ib_unitName[392] = "èŠ±å²—å²©å‚€å„¡"
    set ib_unitArmor[392] = "large"
    set ib_unitNameGbk[392] = "»¨¸ÚÑÒ¿şÀÜ"
    set ib_unitList[393] = 'ngh1'
    set ib_unitName[393] = "å¹½çµ"
    set ib_unitArmor[393] = "medium"
    set ib_unitNameGbk[393] = "ÓÄÁé"
    set ib_unitList[394] = 'ngh2'
    set ib_unitName[394] = "å¹½é­‚"
    set ib_unitArmor[394] = "large"
    set ib_unitNameGbk[394] = "ÓÄ»ê"
    set ib_unitList[395] = 'ngir'
    set ib_unitName[395] = "åœ°ç²¾æ’•è£‚è€…"
    set ib_unitArmor[395] = "large"
    set ib_unitNameGbk[395] = "µØ¾«ËºÁÑÕß"
    set ib_unitList[396] = 'nglm'
    set ib_unitName[396] = "åœ°ç²¾åœ°é›·"
    set ib_unitArmor[396] = "medium"
    set ib_unitNameGbk[396] = "µØ¾«µØÀ×"
    set ib_unitList[397] = 'ngme'
    set ib_unitName[397] = "åœ°ç²¾å•†åº—"
    set ib_unitArmor[397] = "fort"
    set ib_unitNameGbk[397] = "µØ¾«ÉÌµê"
    set ib_unitList[398] = 'ngna'
    set ib_unitName[398] = "è±ºç‹¼å·çŒè€…"
    set ib_unitArmor[398] = "large"
    set ib_unitNameGbk[398] = "²òÀÇÍµÁÔÕß"
    set ib_unitList[399] = 'ngnb'
    set ib_unitName[399] = "è±ºç‹¼é‡å…½"
    set ib_unitArmor[399] = "large"
    set ib_unitNameGbk[399] = "²òÀÇÒ°ÊŞ"
endfunction
function IB_UnitFill5 takes nothing returns nothing
    set ib_unitList[400] = 'ngnh'
    set ib_unitName[400] = "è±ºç‹¼äººå°å±‹"
    set ib_unitArmor[400] = "fort"
    set ib_unitNameGbk[400] = "²òÀÇÈËĞ¡Îİ"
    set ib_unitList[401] = 'ngni'
    set ib_unitName[401] = "è…çƒ‚è°·ä»“"
    set ib_unitArmor[401] = "fort"
    set ib_unitNameGbk[401] = "¸¯ÀÃ¹È²Ö"
    set ib_unitList[402] = 'ngno'
    set ib_unitName[402] = "è±ºç‹¼"
    set ib_unitArmor[402] = "large"
    set ib_unitNameGbk[402] = "²òÀÇ"
    set ib_unitList[403] = 'ngns'
    set ib_unitName[403] = "è±ºç‹¼åˆºå®¢"
    set ib_unitArmor[403] = "medium"
    set ib_unitNameGbk[403] = "²òÀÇ´Ì¿Í"
    set ib_unitList[404] = 'ngnv'
    set ib_unitName[404] = "è±ºç‹¼é¦–é¢†"
    set ib_unitArmor[404] = "large"
    set ib_unitNameGbk[404] = "²òÀÇÊ×Áì"
    set ib_unitList[405] = 'ngnw'
    set ib_unitName[405] = "è±ºç‹¼å®ˆæœ›è€…"
    set ib_unitArmor[405] = "medium"
    set ib_unitNameGbk[405] = "²òÀÇÊØÍûÕß"
    set ib_unitList[406] = 'ngob'
    set ib_unitName[406] = "é­”æ³•å®çŸ³å¡”"
    set ib_unitArmor[406] = "fort"
    set ib_unitNameGbk[406] = "Ä§·¨±¦Ê¯Ëş"
    set ib_unitList[407] = 'ngol'
    set ib_unitName[407] = "é‡‘çŸ¿"
    set ib_unitArmor[407] = "fort"
    set ib_unitNameGbk[407] = "½ğ¿ó"
    set ib_unitList[408] = 'ngrd'
    set ib_unitName[408] = "ç»¿é¾™"
    set ib_unitArmor[408] = "large"
    set ib_unitNameGbk[408] = "ÂÌÁú"
    set ib_unitList[409] = 'ngrk'
    set ib_unitName[409] = "æ³¥æ½­å‚€å„¡"
    set ib_unitArmor[409] = "medium"
    set ib_unitNameGbk[409] = "ÄàÌ¶¿şÀÜ"
    set ib_unitList[410] = 'ngrw'
    set ib_unitName[410] = "ç»¿å¹¼é¾™"
    set ib_unitArmor[410] = "small"
    set ib_unitNameGbk[410] = "ÂÌÓ×Áú"
    set ib_unitList[411] = 'ngsp'
    set ib_unitName[411] = "åœ°ç²¾å·¥å…µ"
    set ib_unitArmor[411] = "large"
    set ib_unitNameGbk[411] = "µØ¾«¹¤±ø"
    set ib_unitList[412] = 'ngst'
    set ib_unitName[412] = "å²©çŸ³å‚€å„¡"
    set ib_unitArmor[412] = "large"
    set ib_unitNameGbk[412] = "ÑÒÊ¯¿şÀÜ"
    set ib_unitList[413] = 'ngt2'
    set ib_unitName[413] = "è±ºç‹¼äººå°å±‹"
    set ib_unitArmor[413] = "fort"
    set ib_unitNameGbk[413] = "²òÀÇÈËĞ¡Îİ"
    set ib_unitList[414] = 'ngwr'
    set ib_unitName[414] = "è°·ä»“"
    set ib_unitArmor[414] = "fort"
    set ib_unitNameGbk[414] = "¹È²Ö"
    set ib_unitList[415] = 'ngz1'
    set ib_unitName[415] = "ç†Š"
    set ib_unitArmor[415] = "large"
    set ib_unitNameGbk[415] = "ĞÜ"
    set ib_unitList[416] = 'ngz2'
    set ib_unitName[416] = "æ€’ç†Š"
    set ib_unitArmor[416] = "large"
    set ib_unitNameGbk[416] = "Å­ĞÜ"
    set ib_unitList[417] = 'ngz3'
    set ib_unitName[417] = "çµé­‚ä¹‹ç†Š"
    set ib_unitArmor[417] = "large"
    set ib_unitNameGbk[417] = "Áé»êÖ®ĞÜ"
    set ib_unitList[418] = 'ngz4'
    set ib_unitName[418] = "ç±³çº±"
    set ib_unitArmor[418] = "large"
    set ib_unitNameGbk[418] = "Ã×É´"
    set ib_unitList[419] = 'ngza'
    set ib_unitName[419] = "ç±³çº±"
    set ib_unitArmor[419] = "large"
    set ib_unitNameGbk[419] = "Ã×É´"
    set ib_unitList[420] = 'ngzc'
    set ib_unitName[420] = "ç±³çº±"
    set ib_unitArmor[420] = "large"
    set ib_unitNameGbk[420] = "Ã×É´"
    set ib_unitList[421] = 'ngzd'
    set ib_unitName[421] = "ç±³çº±"
    set ib_unitArmor[421] = "large"
    set ib_unitNameGbk[421] = "Ã×É´"
    set ib_unitList[422] = 'nhar'
    set ib_unitName[422] = "å¥³å¦–ä¾¦å¯Ÿè€…"
    set ib_unitArmor[422] = "large"
    set ib_unitNameGbk[422] = "Å®ÑıÕì²ìÕß"
    set ib_unitList[423] = 'nhcn'
    set ib_unitName[423] = "åŠç¥èµ›çº³ç•™æ–¯ä¹‹è§’"
    set ib_unitArmor[423] = "fort"
    set ib_unitNameGbk[423] = "°ëÉñÈüÄÉÁôË¹Ö®½Ç"
    set ib_unitList[424] = 'nhdc'
    set ib_unitName[424] = "æ¬ºéª—è€…"
    set ib_unitArmor[424] = "large"
    set ib_unitNameGbk[424] = "ÆÛÆ­Õß"
    set ib_unitList[425] = 'nhea'
    set ib_unitName[425] = "å¼“ç®­æ‰‹"
    set ib_unitArmor[425] = "medium"
    set ib_unitNameGbk[425] = "¹­¼ıÊÖ"
    set ib_unitList[426] = 'nheb'
    set ib_unitName[426] = "é«˜ç­‰ç²¾çµå…µè¥"
    set ib_unitArmor[426] = "fort"
    set ib_unitNameGbk[426] = "¸ßµÈ¾«Áé±øÓª"
    set ib_unitList[427] = 'nhef'
    set ib_unitName[427] = "é«˜ç­‰ç²¾çµ"
    set ib_unitArmor[427] = "medium"
    set ib_unitNameGbk[427] = "¸ßµÈ¾«Áé"
    set ib_unitList[428] = 'nhem'
    set ib_unitName[428] = "é«˜ç­‰ç²¾çµ"
    set ib_unitArmor[428] = "medium"
    set ib_unitNameGbk[428] = "¸ßµÈ¾«Áé"
    set ib_unitList[429] = 'nhew'
    set ib_unitName[429] = "å·¥äºº"
    set ib_unitArmor[429] = "medium"
    set ib_unitNameGbk[429] = "¹¤ÈË"
    set ib_unitList[430] = 'nhfp'
    set ib_unitName[430] = "å •è½ç‰§å¸ˆ"
    set ib_unitArmor[430] = "medium"
    set ib_unitNameGbk[430] = "¶éÂäÄÁÊ¦"
    set ib_unitList[431] = 'nhhr'
    set ib_unitName[431] = "å¼‚æ•™å¾’"
    set ib_unitArmor[431] = "large"
    set ib_unitNameGbk[431] = "Òì½ÌÍ½"
    set ib_unitList[432] = 'nhmc'
    set ib_unitName[432] = "èƒèŸ¹éšå£«"
    set ib_unitArmor[432] = "medium"
    set ib_unitNameGbk[432] = "ó¦Ğ·ÒşÊ¿"
    set ib_unitList[433] = 'nhns'
    set ib_unitName[433] = "å¥³å¦–å·¢ç©´"
    set ib_unitArmor[433] = "fort"
    set ib_unitNameGbk[433] = "Å®Ñı³²Ñ¨"
    set ib_unitList[434] = 'nhrh'
    set ib_unitName[434] = "å¥³å¦–é£æš´å·«å¸ˆ"
    set ib_unitArmor[434] = "large"
    set ib_unitNameGbk[434] = "Å®Ñı·ç±©Î×Ê¦"
    set ib_unitList[435] = 'nhrq'
    set ib_unitName[435] = "å¥³å¦–å¥³çš‡"
    set ib_unitArmor[435] = "large"
    set ib_unitNameGbk[435] = "Å®ÑıÅ®»Ê"
    set ib_unitList[436] = 'nhrr'
    set ib_unitName[436] = "é¹°èº«å¥³å¦–æµæ°“"
    set ib_unitArmor[436] = "large"
    set ib_unitNameGbk[436] = "Ó¥ÉíÅ®ÑıÁ÷Ã¥"
    set ib_unitList[437] = 'nhrw'
    set ib_unitName[437] = "é¹°èº«å¥³å¦–å·«å©†"
    set ib_unitArmor[437] = "small"
    set ib_unitNameGbk[437] = "Ó¥ÉíÅ®ÑıÎ×ÆÅ"
    set ib_unitList[438] = 'nhyc'
    set ib_unitName[438] = "é¾™é¾Ÿ"
    set ib_unitArmor[438] = "large"
    set ib_unitNameGbk[438] = "Áú¹ê"
    set ib_unitList[439] = 'nhyd'
    set ib_unitName[439] = "ä¹å¤´æ€ªè›‡"
    set ib_unitArmor[439] = "large"
    set ib_unitNameGbk[439] = "¾ÅÍ·¹ÖÉß"
    set ib_unitList[440] = 'nhyh'
    set ib_unitName[440] = "å°ä¹å¤´æ€ªè›‡"
    set ib_unitArmor[440] = "medium"
    set ib_unitNameGbk[440] = "Ğ¡¾ÅÍ·¹ÖÉß"
    set ib_unitList[441] = 'nhym'
    set ib_unitName[441] = "æœ¯å£«"
    set ib_unitArmor[441] = "none"
    set ib_unitNameGbk[441] = "ÊõÊ¿"
    set ib_unitList[442] = 'nico'
    set ib_unitName[442] = "å¯’å†°ç‹åº§æ–¹å°–å¡”"
    set ib_unitArmor[442] = "fort"
    set ib_unitNameGbk[442] = "º®±ùÍõ×ù·½¼âËş"
    set ib_unitList[443] = 'nina'
    set ib_unitName[443] = "åœ°ç‹±æˆ˜èˆ°"
    set ib_unitArmor[443] = "large"
    set ib_unitNameGbk[443] = "µØÓüÕ½½¢"
    set ib_unitList[444] = 'ninc'
    set ib_unitName[444] = "åœ°ç‹±ç«æœºå…³äºº"
    set ib_unitArmor[444] = "large"
    set ib_unitNameGbk[444] = "µØÓü»ğ»ú¹ØÈË"
    set ib_unitList[445] = 'ninf'
    set ib_unitName[445] = "åœ°ç‹±ç«"
    set ib_unitArmor[445] = "large"
    set ib_unitNameGbk[445] = "µØÓü»ğ"
    set ib_unitList[446] = 'ninm'
    set ib_unitName[446] = "åœ°ç‹±ç«æœºæ¢°äºº"
    set ib_unitArmor[446] = "large"
    set ib_unitNameGbk[446] = "µØÓü»ğ»úĞµÈË"
    set ib_unitList[447] = 'nitb'
    set ib_unitName[447] = "å†°ä¹‹å®ç›’"
    set ib_unitArmor[447] = "fort"
    set ib_unitNameGbk[447] = "±ùÖ®±¦ºĞ"
    set ib_unitList[448] = 'nith'
    set ib_unitName[448] = "å†°é­”é«˜çº§ç‰§å¸ˆ"
    set ib_unitArmor[448] = "medium"
    set ib_unitNameGbk[448] = "±ùÄ§¸ß¼¶ÄÁÊ¦"
    set ib_unitList[449] = 'nitp'
    set ib_unitName[449] = "å†°é­”ç‰§å¸ˆ"
    set ib_unitArmor[449] = "large"
    set ib_unitNameGbk[449] = "±ùÄ§ÄÁÊ¦"
    set ib_unitList[450] = 'nitr'
    set ib_unitName[450] = "å†°ä¹‹å·¨é­”"
    set ib_unitArmor[450] = "large"
    set ib_unitNameGbk[450] = "±ùÖ®¾ŞÄ§"
    set ib_unitList[451] = 'nits'
    set ib_unitName[451] = "å†°é­”ç‹‚æˆ˜å£«"
    set ib_unitArmor[451] = "medium"
    set ib_unitNameGbk[451] = "±ùÄ§¿ñÕ½Ê¿"
    set ib_unitList[452] = 'nitt'
    set ib_unitName[452] = "å†°é­”çŒæ‰‹"
    set ib_unitArmor[452] = "medium"
    set ib_unitNameGbk[452] = "±ùÄ§ÁÔÊÖ"
    set ib_unitList[453] = 'nitw'
    set ib_unitName[453] = "å†°é­”é¦–é¢†"
    set ib_unitArmor[453] = "large"
    set ib_unitNameGbk[453] = "±ùÄ§Ê×Áì"
    set ib_unitList[454] = 'njg1'
    set ib_unitName[454] = "ä¸›æ—æ¼«æ­¥è€…"
    set ib_unitArmor[454] = "large"
    set ib_unitNameGbk[454] = "´ÔÁÖÂş²½Õß"
    set ib_unitList[455] = 'njga'
    set ib_unitName[455] = "ä¸›æ—æ¼«æ­¥è€…é•¿è€"
    set ib_unitArmor[455] = "large"
    set ib_unitNameGbk[455] = "´ÔÁÖÂş²½Õß³¤ÀÏ"
    set ib_unitList[456] = 'njgb'
    set ib_unitName[456] = "æ€’ä¹‹ä¸›æ—æ¼«æ­¥è€…"
    set ib_unitArmor[456] = "large"
    set ib_unitNameGbk[456] = "Å­Ö®´ÔÁÖÂş²½Õß"
    set ib_unitList[457] = 'njks'
    set ib_unitName[457] = "ç›‘ç‹±å°å’"
    set ib_unitArmor[457] = "large"
    set ib_unitNameGbk[457] = "¼àÓüĞ¡×ä"
    set ib_unitList[458] = 'nkob'
    set ib_unitName[458] = "ç‹—å¤´äºº"
    set ib_unitArmor[458] = "large"
    set ib_unitNameGbk[458] = "¹·Í·ÈË"
    set ib_unitList[459] = 'nkog'
    set ib_unitName[459] = "ç‹—å¤´äººå åœè€…"
    set ib_unitArmor[459] = "medium"
    set ib_unitNameGbk[459] = "¹·Í·ÈËÕ¼²·Õß"
    set ib_unitList[460] = 'nkol'
    set ib_unitName[460] = "ç‹—å¤´äººé¦–é¢†"
    set ib_unitArmor[460] = "large"
    set ib_unitNameGbk[460] = "¹·Í·ÈËÊ×Áì"
    set ib_unitList[461] = 'nkot'
    set ib_unitName[461] = "åœ°ç©´ç‹—å¤´äºº"
    set ib_unitArmor[461] = "medium"
    set ib_unitNameGbk[461] = "µØÑ¨¹·Í·ÈË"
    set ib_unitList[462] = 'nlds'
    set ib_unitName[462] = "é©¬åº“æ‹‰å…ˆçŸ¥"
    set ib_unitArmor[462] = "medium"
    set ib_unitNameGbk[462] = "Âí¿âÀ­ÏÈÖª"
    set ib_unitList[463] = 'nlkl'
    set ib_unitName[463] = "é©¬åº“æ‹‰æ½®æ±é¢†ä¸»"
    set ib_unitArmor[463] = "large"
    set ib_unitNameGbk[463] = "Âí¿âÀ­³±Ï«ÁìÖ÷"
    set ib_unitList[464] = 'nlpd'
    set ib_unitName[464] = "é©¬åº“æ‹‰æ± äºº"
    set ib_unitArmor[464] = "large"
    set ib_unitNameGbk[464] = "Âí¿âÀ­³ØÈË"
    set ib_unitList[465] = 'nlpr'
    set ib_unitName[465] = "å·¨è™¾"
    set ib_unitArmor[465] = "large"
    set ib_unitNameGbk[465] = "¾ŞÏº"
    set ib_unitList[466] = 'nlps'
    set ib_unitName[466] = "å¬å”¤å‡ºæ¥çš„å·¨è™¾"
    set ib_unitArmor[466] = "large"
    set ib_unitNameGbk[466] = "ÕÙ»½³öÀ´µÄ¾ŞÏº"
    set ib_unitList[467] = 'nlrv'
    set ib_unitName[467] = "æ·±æ¸Šé¢†ä¸»å¹½çµ"
    set ib_unitArmor[467] = "large"
    set ib_unitNameGbk[467] = "ÉîÔ¨ÁìÖ÷ÓÄÁé"
    set ib_unitList[468] = 'nlsn'
    set ib_unitName[468] = "é©¬åº“æ‹‰ç”²é±¼"
    set ib_unitArmor[468] = "large"
    set ib_unitNameGbk[468] = "Âí¿âÀ­¼×Óã"
    set ib_unitList[469] = 'nltc'
    set ib_unitName[469] = "é©¬åº“æ‹‰æ½®æ±å¬å”¤è€…"
    set ib_unitArmor[469] = "medium"
    set ib_unitNameGbk[469] = "Âí¿âÀ­³±Ï«ÕÙ»½Õß"
    set ib_unitList[470] = 'nltl'
    set ib_unitName[470] = "é—ªç”µèœ¥èœ´"
    set ib_unitArmor[470] = "large"
    set ib_unitNameGbk[470] = "ÉÁµçòáòæ"
    set ib_unitList[471] = 'nlur'
    set ib_unitName[471] = "æ€ªå…½è¯±æ•å®ˆå«"
    set ib_unitArmor[471] = "medium"
    set ib_unitNameGbk[471] = "¹ÖÊŞÓÕ²¶ÊØÎÀ"
    set ib_unitList[472] = 'nlv1'
    set ib_unitName[472] = "ç‚é­”"
    set ib_unitArmor[472] = "large"
    set ib_unitNameGbk[472] = "Ñ×Ä§"
    set ib_unitList[473] = 'nlv2'
    set ib_unitName[473] = "ç‚é­”"
    set ib_unitArmor[473] = "large"
    set ib_unitNameGbk[473] = "Ñ×Ä§"
    set ib_unitList[474] = 'nlv3'
    set ib_unitName[474] = "ç‚é­”"
    set ib_unitArmor[474] = "large"
    set ib_unitNameGbk[474] = "Ñ×Ä§"
    set ib_unitList[475] = 'nmam'
    set ib_unitName[475] = "çŒ›çŠ¸"
    set ib_unitArmor[475] = "large"
    set ib_unitNameGbk[475] = "ÃÍáï"
    set ib_unitList[476] = 'nmbg'
    set ib_unitName[476] = "ç©†æ ¼å°”è¡€å¥³å·«"
    set ib_unitArmor[476] = "medium"
    set ib_unitNameGbk[476] = "ÄÂ¸ñ¶ûÑªÅ®Î×"
    set ib_unitList[477] = 'nmcf'
    set ib_unitName[477] = "ç©†æ ¼å°”å²©äºº"
    set ib_unitArmor[477] = "large"
    set ib_unitNameGbk[477] = "ÄÂ¸ñ¶ûÑÒÈË"
    set ib_unitList[478] = 'nmdm'
    set ib_unitName[478] = "éº¦è¿ªæ–‡"
    set ib_unitArmor[478] = "large"
    set ib_unitNameGbk[478] = "ÂóµÏÎÄ"
    set ib_unitList[479] = 'nmdr'
    set ib_unitName[479] = "ææ€–çŒ›çŠ¸"
    set ib_unitArmor[479] = "large"
    set ib_unitNameGbk[479] = "¿Ö²ÀÃÍáï"
endfunction
function IB_UnitFill6 takes nothing returns nothing
    set ib_unitList[480] = 'nmed'
    set ib_unitName[480] = "éº¦è¿ªæ–‡"
    set ib_unitArmor[480] = "large"
    set ib_unitNameGbk[480] = "ÂóµÏÎÄ"
    set ib_unitList[481] = 'nmer'
    set ib_unitName[481] = "é›‡ä½£å…µè¥åœ°"
    set ib_unitArmor[481] = "fort"
    set ib_unitNameGbk[481] = "¹ÍÓ¶±øÓªµØ"
    set ib_unitList[482] = 'nmfs'
    set ib_unitName[482] = "ä¸¤æ –é£Ÿè‚‰è€…"
    set ib_unitArmor[482] = "large"
    set ib_unitNameGbk[482] = "Á½ÆÜÊ³ÈâÕß"
    set ib_unitList[483] = 'nmg0'
    set ib_unitName[483] = "ç©†æ ¼å°”å°å±‹"
    set ib_unitArmor[483] = "fort"
    set ib_unitNameGbk[483] = "ÄÂ¸ñ¶ûĞ¡Îİ"
    set ib_unitList[484] = 'nmg1'
    set ib_unitName[484] = "ç©†æ ¼å°”å°å±‹"
    set ib_unitArmor[484] = "fort"
    set ib_unitNameGbk[484] = "ÄÂ¸ñ¶ûĞ¡Îİ"
    set ib_unitList[485] = 'nmgd'
    set ib_unitName[485] = "ç›æ ¼å¨œæ‰˜ç ´åè€…"
    set ib_unitArmor[485] = "large"
    set ib_unitNameGbk[485] = "Âê¸ñÄÈÍĞÆÆ»µÕß"
    set ib_unitList[486] = 'nmgr'
    set ib_unitName[486] = "ç›æ ¼å¨œæ‰˜æ’•è£‚è€…"
    set ib_unitArmor[486] = "large"
    set ib_unitNameGbk[486] = "Âê¸ñÄÈÍĞËºÁÑÕß"
    set ib_unitList[487] = 'nmgv'
    set ib_unitName[487] = "é­”æ³•å®ç®±"
    set ib_unitArmor[487] = "fort"
    set ib_unitNameGbk[487] = "Ä§·¨±¦Ïä"
    set ib_unitList[488] = 'nmgw'
    set ib_unitName[488] = "ç›æ ¼å¨œæ‰˜æˆ˜å£«"
    set ib_unitArmor[488] = "large"
    set ib_unitNameGbk[488] = "Âê¸ñÄÈÍĞÕ½Ê¿"
    set ib_unitList[489] = 'nmh0'
    set ib_unitName[489] = "ä¸¤æ –é±¼äººå°å±‹"
    set ib_unitArmor[489] = "fort"
    set ib_unitNameGbk[489] = "Á½ÆÜÓãÈËĞ¡Îİ"
    set ib_unitList[490] = 'nmh1'
    set ib_unitName[490] = "ä¸¤æ –é±¼äººå°å±‹"
    set ib_unitArmor[490] = "fort"
    set ib_unitNameGbk[490] = "Á½ÆÜÓãÈËĞ¡Îİ"
    set ib_unitList[491] = 'nmit'
    set ib_unitName[491] = "å†°ç‰™çŒ›çŠ¸"
    set ib_unitArmor[491] = "large"
    set ib_unitNameGbk[491] = "±ùÑÀÃÍáï"
    set ib_unitList[492] = 'nmmu'
    set ib_unitName[492] = "å˜å¼‚ä¸¤æ –äºº"
    set ib_unitArmor[492] = "large"
    set ib_unitNameGbk[492] = "±äÒìÁ½ÆÜÈË"
    set ib_unitList[493] = 'nmoo'
    set ib_unitName[493] = "é­”æ³•ä¹‹æ³‰"
    set ib_unitArmor[493] = "fort"
    set ib_unitNameGbk[493] = "Ä§·¨Ö®Èª"
    set ib_unitList[494] = 'nmpe'
    set ib_unitName[494] = "ç©†æ ¼å°”å¥´éš¶"
    set ib_unitArmor[494] = "none"
    set ib_unitNameGbk[494] = "ÄÂ¸ñ¶ûÅ«Á¥"
    set ib_unitList[495] = 'nmpg'
    set ib_unitName[495] = "ä¸¤æ –è‹¦éš¾è€…"
    set ib_unitArmor[495] = "large"
    set ib_unitNameGbk[495] = "Á½ÆÜ¿àÄÑÕß"
    set ib_unitList[496] = 'nmr0'
    set ib_unitName[496] = "é›‡ä½£å…µè¥åœ°"
    set ib_unitArmor[496] = "fort"
    set ib_unitNameGbk[496] = "¹ÍÓ¶±øÓªµØ"
    set ib_unitList[497] = 'nmr2'
    set ib_unitName[497] = "é›‡ä½£å…µè¥åœ°"
    set ib_unitArmor[497] = "fort"
    set ib_unitNameGbk[497] = "¹ÍÓ¶±øÓªµØ"
    set ib_unitList[498] = 'nmr3'
    set ib_unitName[498] = "é›‡ä½£å…µè¥åœ°"
    set ib_unitArmor[498] = "fort"
    set ib_unitNameGbk[498] = "¹ÍÓ¶±øÓªµØ"
    set ib_unitList[499] = 'nmr4'
    set ib_unitName[499] = "é›‡ä½£å…µè¥åœ°"
    set ib_unitArmor[499] = "fort"
    set ib_unitNameGbk[499] = "¹ÍÓ¶±øÓªµØ"
    set ib_unitList[500] = 'nmr5'
    set ib_unitName[500] = "é›‡ä½£å…µè¥åœ°"
    set ib_unitArmor[500] = "fort"
    set ib_unitNameGbk[500] = "¹ÍÓ¶±øÓªµØ"
    set ib_unitList[501] = 'nmr6'
    set ib_unitName[501] = "é›‡ä½£å…µè¥åœ°"
    set ib_unitArmor[501] = "fort"
    set ib_unitNameGbk[501] = "¹ÍÓ¶±øÓªµØ"
    set ib_unitList[502] = 'nmr7'
    set ib_unitName[502] = "é›‡ä½£å…µè¥åœ°"
    set ib_unitArmor[502] = "fort"
    set ib_unitNameGbk[502] = "¹ÍÓ¶±øÓªµØ"
    set ib_unitList[503] = 'nmr8'
    set ib_unitName[503] = "é›‡ä½£å…µè¥åœ°"
    set ib_unitArmor[503] = "fort"
    set ib_unitNameGbk[503] = "¹ÍÓ¶±øÓªµØ"
    set ib_unitList[504] = 'nmr9'
    set ib_unitName[504] = "é›‡ä½£å…µè¥åœ°"
    set ib_unitArmor[504] = "fort"
    set ib_unitNameGbk[504] = "¹ÍÓ¶±øÓªµØ"
    set ib_unitList[505] = 'nmra'
    set ib_unitName[505] = "é›‡ä½£å…µè¥åœ°"
    set ib_unitArmor[505] = "fort"
    set ib_unitNameGbk[505] = "¹ÍÓ¶±øÓªµØ"
    set ib_unitList[506] = 'nmrb'
    set ib_unitName[506] = "é›‡ä½£å…µè¥åœ°"
    set ib_unitArmor[506] = "fort"
    set ib_unitNameGbk[506] = "¹ÍÓ¶±øÓªµØ"
    set ib_unitList[507] = 'nmrc'
    set ib_unitName[507] = "é›‡ä½£å…µè¥åœ°"
    set ib_unitArmor[507] = "fort"
    set ib_unitNameGbk[507] = "¹ÍÓ¶±øÓªµØ"
    set ib_unitList[508] = 'nmrd'
    set ib_unitName[508] = "é›‡ä½£å…µè¥åœ°"
    set ib_unitArmor[508] = "fort"
    set ib_unitNameGbk[508] = "¹ÍÓ¶±øÓªµØ"
    set ib_unitList[509] = 'nmre'
    set ib_unitName[509] = "é›‡ä½£å…µè¥åœ°"
    set ib_unitArmor[509] = "fort"
    set ib_unitNameGbk[509] = "¹ÍÓ¶±øÓªµØ"
    set ib_unitList[510] = 'nmrf'
    set ib_unitName[510] = "é›‡ä½£å…µè¥åœ°"
    set ib_unitArmor[510] = "fort"
    set ib_unitNameGbk[510] = "¹ÍÓ¶±øÓªµØ"
    set ib_unitList[511] = 'nmrk'
    set ib_unitName[511] = "å¸‚åœº"
    set ib_unitArmor[511] = "fort"
    set ib_unitNameGbk[511] = "ÊĞ³¡"
    set ib_unitList[512] = 'nmrl'
    set ib_unitName[512] = "ä¸¤æ –è¿½éšè€…"
    set ib_unitArmor[512] = "large"
    set ib_unitNameGbk[512] = "Á½ÆÜ×·ËæÕß"
    set ib_unitList[513] = 'nmrm'
    set ib_unitName[513] = "ä¸¤æ –å¤œè¡Œè€…"
    set ib_unitArmor[513] = "large"
    set ib_unitNameGbk[513] = "Á½ÆÜÒ¹ĞĞÕß"
    set ib_unitList[514] = 'nmrr'
    set ib_unitName[514] = "ä¸¤æ –äººçŒæ‰‹"
    set ib_unitArmor[514] = "large"
    set ib_unitNameGbk[514] = "Á½ÆÜÈËÁÔÊÖ"
    set ib_unitList[515] = 'nmrv'
    set ib_unitName[515] = "ç©†æ ¼å°”æ å¤ºè€…"
    set ib_unitArmor[515] = "large"
    set ib_unitNameGbk[515] = "ÄÂ¸ñ¶ûÂÓ¶áÕß"
    set ib_unitList[516] = 'nmsc'
    set ib_unitName[516] = "ç©†æ ¼å°”å½±å­æ³•å¸ˆ"
    set ib_unitArmor[516] = "large"
    set ib_unitNameGbk[516] = "ÄÂ¸ñ¶ûÓ°×Ó·¨Ê¦"
    set ib_unitList[517] = 'nmsh'
    set ib_unitName[517] = "ç±³çº±"
    set ib_unitArmor[517] = "large"
    set ib_unitNameGbk[517] = "Ã×É´"
    set ib_unitList[518] = 'nmsn'
    set ib_unitName[518] = "ç©†æ ¼å°”çŒäºº"
    set ib_unitArmor[518] = "medium"
    set ib_unitNameGbk[518] = "ÄÂ¸ñ¶ûÁÔÈË"
    set ib_unitList[519] = 'nmtw'
    set ib_unitName[519] = "ç©†æ ¼å°”æ½®æ±æˆ˜å£«"
    set ib_unitArmor[519] = "large"
    set ib_unitNameGbk[519] = "ÄÂ¸ñ¶û³±Ï«Õ½Ê¿"
    set ib_unitList[520] = 'nmyr'
    set ib_unitName[520] = "å¨œè¿¦æš´å¾’"
    set ib_unitArmor[520] = "large"
    set ib_unitNameGbk[520] = "ÄÈåÈ±©Í½"
    set ib_unitList[521] = 'nmys'
    set ib_unitName[521] = "æ½œæ°´çš„å¨œè¿¦æš´å¾’"
    set ib_unitArmor[521] = "large"
    set ib_unitNameGbk[521] = "Ç±Ë®µÄÄÈåÈ±©Í½"
    set ib_unitList[522] = 'nnad'
    set ib_unitName[522] = "æ·±æ¸Šç¥­å›"
    set ib_unitArmor[522] = "fort"
    set ib_unitNameGbk[522] = "ÉîÔ¨¼ÀÌ³"
    set ib_unitList[523] = 'nndk'
    set ib_unitName[523] = "è€ç‘Ÿèœ‰è£"
    set ib_unitArmor[523] = "large"
    set ib_unitNameGbk[523] = "ÄÍÉªòİòö"
    set ib_unitList[524] = 'nndr'
    set ib_unitName[524] = "è€ç‘Ÿé¾™"
    set ib_unitArmor[524] = "large"
    set ib_unitNameGbk[524] = "ÄÍÉªÁú"
    set ib_unitList[525] = 'nnfm'
    set ib_unitName[525] = "çŠç‘šç¤"
    set ib_unitArmor[525] = "fort"
    set ib_unitNameGbk[525] = "Éºº÷½¸"
    set ib_unitList[526] = 'nnht'
    set ib_unitName[526] = "è€ç‘Ÿå¹¼é¾™"
    set ib_unitArmor[526] = "large"
    set ib_unitNameGbk[526] = "ÄÍÉªÓ×Áú"
    set ib_unitList[527] = 'nnmg'
    set ib_unitName[527] = "ç©†æ ¼å°”æ å¤ºè€…"
    set ib_unitArmor[527] = "large"
    set ib_unitNameGbk[527] = "ÄÂ¸ñ¶ûÂÓ¶áÕß"
    set ib_unitList[528] = 'nnrg'
    set ib_unitName[528] = "å¨œè¿¦çš‡å®¶å«å…µ"
    set ib_unitArmor[528] = "large"
    set ib_unitNameGbk[528] = "ÄÈåÈ»Ê¼ÒÎÀ±ø"
    set ib_unitList[529] = 'nnrs'
    set ib_unitName[529] = "æ½œæ°´çš„å¨œè¿¦çš‡å®¶å«å…µ"
    set ib_unitArmor[529] = "large"
    set ib_unitNameGbk[529] = "Ç±Ë®µÄÄÈåÈ»Ê¼ÒÎÀ±ø"
    set ib_unitList[530] = 'nnsa'
    set ib_unitName[530] = "è‰¾è¨æ‹‰å¥³ç‹ç¥æ®¿"
    set ib_unitArmor[530] = "fort"
    set ib_unitNameGbk[530] = "°¬ÈøÀ­Å®ÍõÉñµî"
    set ib_unitList[531] = 'nnsg'
    set ib_unitName[531] = "äº§åµä¹‹åœ°"
    set ib_unitArmor[531] = "fort"
    set ib_unitNameGbk[531] = "²úÂÑÖ®µØ"
    set ib_unitList[532] = 'nnsu'
    set ib_unitName[532] = "å¬å”¤è€…"
    set ib_unitArmor[532] = "none"
    set ib_unitNameGbk[532] = "ÕÙ»½Õß"
    set ib_unitList[533] = 'nnsw'
    set ib_unitName[533] = "å¨œè¿¦æµ·å¦–"
    set ib_unitArmor[533] = "none"
    set ib_unitNameGbk[533] = "ÄÈåÈº£Ñı"
    set ib_unitList[534] = 'nntg'
    set ib_unitName[534] = "å®ˆæŠ¤è€…"
    set ib_unitArmor[534] = "fort"
    set ib_unitNameGbk[534] = "ÊØ»¤Õß"
    set ib_unitList[535] = 'nntt'
    set ib_unitName[535] = "æ½®æ±ç¥åº™"
    set ib_unitArmor[535] = "fort"
    set ib_unitNameGbk[535] = "³±Ï«ÉñÃí"
    set ib_unitList[536] = 'nnwa'
    set ib_unitName[536] = "è››ç½‘æ€ªæˆ˜å£«"
    set ib_unitArmor[536] = "large"
    set ib_unitNameGbk[536] = "ÖëÍø¹ÖÕ½Ê¿"
    set ib_unitList[537] = 'nnwl'
    set ib_unitName[537] = "è››ç½‘æ€ªç»‡ç½‘è€…"
    set ib_unitArmor[537] = "large"
    set ib_unitNameGbk[537] = "ÖëÍø¹ÖÖ¯ÍøÕß"
    set ib_unitList[538] = 'nnwq'
    set ib_unitName[538] = "è››ç½‘æ€ªå¥³çš‡"
    set ib_unitArmor[538] = "large"
    set ib_unitNameGbk[538] = "ÖëÍø¹ÖÅ®»Ê"
    set ib_unitList[539] = 'nnwr'
    set ib_unitName[539] = "è››ç½‘æ€ªé¢„è¨€è€…"
    set ib_unitArmor[539] = "large"
    set ib_unitNameGbk[539] = "ÖëÍø¹ÖÔ¤ÑÔÕß"
    set ib_unitList[540] = 'nnws'
    set ib_unitName[540] = "è››ç½‘æ€ªé¦–é¢†"
    set ib_unitArmor[540] = "large"
    set ib_unitNameGbk[540] = "ÖëÍø¹ÖÊ×Áì"
    set ib_unitList[541] = 'nnzg'
    set ib_unitName[541] = "é€šçµå¡”"
    set ib_unitArmor[541] = "fort"
    set ib_unitNameGbk[541] = "Í¨ÁéËş"
    set ib_unitList[542] = 'noga'
    set ib_unitName[542] = "çŸ³æ§Œé…‹é•¿"
    set ib_unitArmor[542] = "large"
    set ib_unitNameGbk[542] = "Ê¯é³Çõ³¤"
    set ib_unitList[543] = 'nogl'
    set ib_unitName[543] = "é£Ÿäººé¬¼é¦–é¢†"
    set ib_unitArmor[543] = "large"
    set ib_unitNameGbk[543] = "Ê³ÈË¹íÊ×Áì"
    set ib_unitList[544] = 'nogm'
    set ib_unitName[544] = "é£Ÿäººé¬¼æ‹³æ‰‹"
    set ib_unitArmor[544] = "large"
    set ib_unitNameGbk[544] = "Ê³ÈË¹íÈ­ÊÖ"
    set ib_unitList[545] = 'nogn'
    set ib_unitName[545] = "çŸ³æ§Œæ³•å¸ˆ"
    set ib_unitArmor[545] = "large"
    set ib_unitNameGbk[545] = "Ê¯é³·¨Ê¦"
    set ib_unitList[546] = 'nogo'
    set ib_unitName[546] = "çŸ³æ§Œé£Ÿäººé­”"
    set ib_unitArmor[546] = "large"
    set ib_unitNameGbk[546] = "Ê¯é³Ê³ÈËÄ§"
    set ib_unitList[547] = 'nogr'
    set ib_unitName[547] = "é£Ÿäººé¬¼æˆ˜å£«"
    set ib_unitArmor[547] = "large"
    set ib_unitNameGbk[547] = "Ê³ÈË¹íÕ½Ê¿"
    set ib_unitList[548] = 'nomg'
    set ib_unitName[548] = "é£Ÿäººé¬¼é­”æ³•å¸ˆ"
    set ib_unitArmor[548] = "large"
    set ib_unitNameGbk[548] = "Ê³ÈË¹íÄ§·¨Ê¦"
    set ib_unitList[549] = 'now2'
    set ib_unitName[549] = "çŒ«å¤´é¹°ä¾¦å¯Ÿè€…"
    set ib_unitArmor[549] = "medium"
    set ib_unitNameGbk[549] = "Ã¨Í·Ó¥Õì²ìÕß"
    set ib_unitList[550] = 'now3'
    set ib_unitName[550] = "çŒ«å¤´é¹°ä¾¦å¯Ÿè€…"
    set ib_unitArmor[550] = "medium"
    set ib_unitNameGbk[550] = "Ã¨Í·Ó¥Õì²ìÕß"
    set ib_unitList[551] = 'nowb'
    set ib_unitName[551] = "è¿…çŒ›é‡å…½"
    set ib_unitArmor[551] = "large"
    set ib_unitNameGbk[551] = "Ñ¸ÃÍÒ°ÊŞ"
    set ib_unitList[552] = 'nowe'
    set ib_unitName[552] = "æš´æ€’é‡å…½"
    set ib_unitArmor[552] = "large"
    set ib_unitNameGbk[552] = "±©Å­Ò°ÊŞ"
    set ib_unitList[553] = 'nowk'
    set ib_unitName[553] = "ç‹‚æ€§é‡å…½"
    set ib_unitArmor[553] = "large"
    set ib_unitNameGbk[553] = "¿ñĞÔÒ°ÊŞ"
    set ib_unitList[554] = 'nowl'
    set ib_unitName[554] = "çŒ«å¤´é¹°ä¾¦å¯Ÿè€…"
    set ib_unitArmor[554] = "medium"
    set ib_unitNameGbk[554] = "Ã¨Í·Ó¥Õì²ìÕß"
    set ib_unitList[555] = 'npfl'
    set ib_unitName[555] = "ç‹‚æš´é‡å…½"
    set ib_unitArmor[555] = "large"
    set ib_unitNameGbk[555] = "¿ñ±©Ò°ÊŞ"
    set ib_unitList[556] = 'npfm'
    set ib_unitName[556] = "ç‹‚æš´æ´—åŠ«è€…"
    set ib_unitArmor[556] = "large"
    set ib_unitNameGbk[556] = "¿ñ±©Ï´½ÙÕß"
    set ib_unitList[557] = 'npgf'
    set ib_unitName[557] = "çŒªåœˆå†œåœº"
    set ib_unitArmor[557] = "fort"
    set ib_unitNameGbk[557] = "ÖíÈ¦Å©³¡"
    set ib_unitList[558] = 'npgr'
    set ib_unitName[558] = "èƒ½é‡äº§ç”Ÿå™¨"
    set ib_unitArmor[558] = "fort"
    set ib_unitNameGbk[558] = "ÄÜÁ¿²úÉúÆ÷"
    set ib_unitList[559] = 'npig'
    set ib_unitName[559] = "é‡çŒª"
    set ib_unitArmor[559] = "medium"
    set ib_unitNameGbk[559] = "Ò°Öí"
endfunction
function IB_UnitFill7 takes nothing returns nothing
    set ib_unitList[560] = 'nplb'
    set ib_unitName[560] = "åŒ—æç†Š"
    set ib_unitArmor[560] = "large"
    set ib_unitNameGbk[560] = "±±¼«ĞÜ"
    set ib_unitList[561] = 'nplg'
    set ib_unitName[561] = "å·¨å‹åŒ—æç†Š"
    set ib_unitArmor[561] = "large"
    set ib_unitNameGbk[561] = "¾ŞĞÍ±±¼«ĞÜ"
    set ib_unitList[562] = 'npn1'
    set ib_unitName[562] = "ç«ç„°"
    set ib_unitArmor[562] = "large"
    set ib_unitNameGbk[562] = "»ğÑæ"
    set ib_unitList[563] = 'npn2'
    set ib_unitName[563] = "é£æš´"
    set ib_unitArmor[563] = "large"
    set ib_unitNameGbk[563] = "·ç±©"
    set ib_unitList[564] = 'npn3'
    set ib_unitName[564] = "å¤§åœ°"
    set ib_unitArmor[564] = "large"
    set ib_unitNameGbk[564] = "´óµØ"
    set ib_unitList[565] = 'npn4'
    set ib_unitName[565] = "ç«ä¹‹ç†ŠçŒ«æˆ˜å£«"
    set ib_unitArmor[565] = "large"
    set ib_unitNameGbk[565] = "»ğÖ®ĞÜÃ¨Õ½Ê¿"
    set ib_unitList[566] = 'npn5'
    set ib_unitName[566] = "é£ä¹‹ç†ŠçŒ«æˆ˜å£«"
    set ib_unitArmor[566] = "large"
    set ib_unitNameGbk[566] = "·çÖ®ĞÜÃ¨Õ½Ê¿"
    set ib_unitList[567] = 'npn6'
    set ib_unitName[567] = "åœ°ä¹‹ç†ŠçŒ«æˆ˜å£«"
    set ib_unitArmor[567] = "large"
    set ib_unitNameGbk[567] = "µØÖ®ĞÜÃ¨Õ½Ê¿"
    set ib_unitList[568] = 'npng'
    set ib_unitName[568] = "ä¼é¹…"
    set ib_unitArmor[568] = "medium"
    set ib_unitNameGbk[568] = "Æó¶ì"
    set ib_unitList[569] = 'npnw'
    set ib_unitName[569] = "ä¼é¹…"
    set ib_unitArmor[569] = "medium"
    set ib_unitNameGbk[569] = "Æó¶ì"
    set ib_unitList[570] = 'nqb1'
    set ib_unitName[570] = "è±ªçŒª"
    set ib_unitArmor[570] = "medium"
    set ib_unitNameGbk[570] = "ºÀÖí"
    set ib_unitList[571] = 'nqb2'
    set ib_unitName[571] = "å‡¶æ¶è±ªçŒª"
    set ib_unitArmor[571] = "medium"
    set ib_unitNameGbk[571] = "Ğ×¶ñºÀÖí"
    set ib_unitList[572] = 'nqb3'
    set ib_unitName[572] = "å½±å­è±ªçŒª"
    set ib_unitArmor[572] = "medium"
    set ib_unitNameGbk[572] = "Ó°×ÓºÀÖí"
    set ib_unitList[573] = 'nqb4'
    set ib_unitName[573] = "ç‹‚æš´è±ªçŒª"
    set ib_unitArmor[573] = "medium"
    set ib_unitNameGbk[573] = "¿ñ±©ºÀÖí"
    set ib_unitList[574] = 'nqbh'
    set ib_unitName[574] = "è±ªçŒªçŒæ‰‹"
    set ib_unitArmor[574] = "medium"
    set ib_unitNameGbk[574] = "ºÀÖíÁÔÊÖ"
    set ib_unitList[575] = 'nrac'
    set ib_unitName[575] = "æµ£ç†Š"
    set ib_unitArmor[575] = "medium"
    set ib_unitNameGbk[575] = "ä½ĞÜ"
    set ib_unitList[576] = 'nrat'
    set ib_unitName[576] = "è€é¼ "
    set ib_unitArmor[576] = "medium"
    set ib_unitNameGbk[576] = "ÀÏÊó"
    set ib_unitList[577] = 'nrdk'
    set ib_unitName[577] = "çº¢å¹¼é¾™"
    set ib_unitArmor[577] = "small"
    set ib_unitNameGbk[577] = "ºìÓ×Áú"
    set ib_unitList[578] = 'nrdr'
    set ib_unitName[578] = "çº¢èœ‰è£"
    set ib_unitArmor[578] = "large"
    set ib_unitNameGbk[578] = "ºìòİòö"
    set ib_unitList[579] = 'nrel'
    set ib_unitName[579] = "æš—ç¤å…ƒç´ "
    set ib_unitArmor[579] = "medium"
    set ib_unitNameGbk[579] = "°µ½¸ÔªËØ"
    set ib_unitList[580] = 'nrog'
    set ib_unitName[580] = "æµæ°“"
    set ib_unitArmor[580] = "large"
    set ib_unitNameGbk[580] = "Á÷Ã¥"
    set ib_unitList[581] = 'nrvd'
    set ib_unitName[581] = "æ­»äº¡å¹½é­‚"
    set ib_unitArmor[581] = "large"
    set ib_unitNameGbk[581] = "ËÀÍöÓÄ»ê"
    set ib_unitList[582] = 'nrvf'
    set ib_unitName[582] = "ç«ç„°å¹½é­‚"
    set ib_unitArmor[582] = "large"
    set ib_unitNameGbk[582] = "»ğÑæÓÄ»ê"
    set ib_unitList[583] = 'nrvi'
    set ib_unitName[583] = "å†°ä¹‹å¹½é­‚"
    set ib_unitArmor[583] = "large"
    set ib_unitNameGbk[583] = "±ùÖ®ÓÄ»ê"
    set ib_unitList[584] = 'nrvl'
    set ib_unitName[584] = "é—ªç”µå¹½é­‚"
    set ib_unitArmor[584] = "medium"
    set ib_unitNameGbk[584] = "ÉÁµçÓÄ»ê"
    set ib_unitList[585] = 'nrvs'
    set ib_unitName[585] = "éœœå†»å¹½é­‚"
    set ib_unitArmor[585] = "large"
    set ib_unitNameGbk[585] = "Ëª¶³ÓÄ»ê"
    set ib_unitList[586] = 'nrwm'
    set ib_unitName[586] = "çº¢é¾™"
    set ib_unitArmor[586] = "large"
    set ib_unitNameGbk[586] = "ºìÁú"
    set ib_unitList[587] = 'nrzb'
    set ib_unitName[587] = "å°–æ¯›å…½é‡è›®äºº"
    set ib_unitArmor[587] = "large"
    set ib_unitNameGbk[587] = "¼âÃ«ÊŞÒ°ÂùÈË"
    set ib_unitList[588] = 'nrzg'
    set ib_unitName[588] = "å°–æ¯›å…½é…‹é•¿"
    set ib_unitArmor[588] = "large"
    set ib_unitNameGbk[588] = "¼âÃ«ÊŞÇõ³¤"
    set ib_unitList[589] = 'nrzm'
    set ib_unitName[589] = "å°–æ¯›å…½åŒ»ç”Ÿ"
    set ib_unitArmor[589] = "large"
    set ib_unitNameGbk[589] = "¼âÃ«ÊŞÒ½Éú"
    set ib_unitList[590] = 'nrzs'
    set ib_unitName[590] = "å°–æ¯›å…½ä¾¦å¯Ÿå…µ"
    set ib_unitArmor[590] = "large"
    set ib_unitNameGbk[590] = "¼âÃ«ÊŞÕì²ì±ø"
    set ib_unitList[591] = 'nrzt'
    set ib_unitName[591] = "è±ªçŒª"
    set ib_unitArmor[591] = "large"
    set ib_unitNameGbk[591] = "ºÀÖí"
    set ib_unitList[592] = 'nsat'
    set ib_unitName[592] = "èµ›ç‰¹æ–¯ä¹‹é­”æ³•å¸ˆ"
    set ib_unitArmor[592] = "large"
    set ib_unitNameGbk[592] = "ÈüÌØË¹Ö®Ä§·¨Ê¦"
    set ib_unitList[593] = 'nsbm'
    set ib_unitName[593] = "è¡€æµ´ä¹‹æ¯"
    set ib_unitArmor[593] = "large"
    set ib_unitNameGbk[593] = "ÑªÔ¡Ö®Ä¸"
    set ib_unitList[594] = 'nsbs'
    set ib_unitName[594] = "æ½œæ°´çš„é£é¾™"
    set ib_unitArmor[594] = "medium"
    set ib_unitNameGbk[594] = "Ç±Ë®µÄ·ÉÁú"
    set ib_unitList[595] = 'nsc2'
    set ib_unitName[595] = "èœ˜è››èƒèŸ¹è‚¢ä½“æ’•è£‚è€…"
    set ib_unitArmor[595] = "large"
    set ib_unitNameGbk[595] = "Ö©Öëó¦Ğ·Ö«ÌåËºÁÑÕß"
    set ib_unitList[596] = 'nsc3'
    set ib_unitName[596] = "èœ˜è››èƒèŸ¹å·¨å…½"
    set ib_unitArmor[596] = "large"
    set ib_unitNameGbk[596] = "Ö©Öëó¦Ğ·¾ŞÊŞ"
    set ib_unitList[597] = 'nsca'
    set ib_unitName[597] = "éª·é«…å¼“ç®­æ‰‹"
    set ib_unitArmor[597] = "large"
    set ib_unitNameGbk[597] = "÷¼÷Ã¹­¼ıÊÖ"
    set ib_unitList[598] = 'nscb'
    set ib_unitName[598] = "èœ˜è››èƒèŸ¹"
    set ib_unitArmor[598] = "large"
    set ib_unitNameGbk[598] = "Ö©Öëó¦Ğ·"
    set ib_unitList[599] = 'nsce'
    set ib_unitName[599] = "éª·é«…æˆ˜å£«"
    set ib_unitArmor[599] = "large"
    set ib_unitNameGbk[599] = "÷¼÷ÃÕ½Ê¿"
    set ib_unitList[600] = 'nsea'
    set ib_unitName[600] = "æµ·è±¹"
    set ib_unitArmor[600] = "medium"
    set ib_unitNameGbk[600] = "º£±ª"
    set ib_unitList[601] = 'nsel'
    set ib_unitName[601] = "æµ·å…ƒç´ "
    set ib_unitArmor[601] = "medium"
    set ib_unitNameGbk[601] = "º£ÔªËØ"
    set ib_unitList[602] = 'nser'
    set ib_unitName[602] = "è¥¿é‡Œè¯ºå…‹æ–¯"
    set ib_unitArmor[602] = "small"
    set ib_unitNameGbk[602] = "Î÷ÀïÅµ¿ËË¹"
    set ib_unitList[603] = 'nsgb'
    set ib_unitName[603] = "æ·±æµ·å·¨å…½"
    set ib_unitArmor[603] = "large"
    set ib_unitNameGbk[603] = "Éîº£¾ŞÊŞ"
    set ib_unitList[604] = 'nsgg'
    set ib_unitName[604] = "æ”»åŸå‚€å„¡"
    set ib_unitArmor[604] = "large"
    set ib_unitNameGbk[604] = "¹¥³Ç¿şÀÜ"
    set ib_unitList[605] = 'nsgh'
    set ib_unitName[605] = "æ·±æµ·å·¨çŒäºº"
    set ib_unitArmor[605] = "large"
    set ib_unitNameGbk[605] = "Éîº£¾ŞÁÔÈË"
    set ib_unitList[606] = 'nsgn'
    set ib_unitName[606] = "æµ·å·¨äºº"
    set ib_unitArmor[606] = "large"
    set ib_unitNameGbk[606] = "º£¾ŞÈË"
    set ib_unitList[607] = 'nsgt'
    set ib_unitName[607] = "å·¨å‹èœ˜è››"
    set ib_unitArmor[607] = "large"
    set ib_unitNameGbk[607] = "¾ŞĞÍÖ©Öë"
    set ib_unitList[608] = 'nsha'
    set ib_unitName[608] = "ç»µç¾Š"
    set ib_unitArmor[608] = "medium"
    set ib_unitNameGbk[608] = "ÃàÑò"
    set ib_unitList[609] = 'nshe'
    set ib_unitName[609] = "ç»µç¾Š"
    set ib_unitArmor[609] = "medium"
    set ib_unitNameGbk[609] = "ÃàÑò"
    set ib_unitList[610] = 'nshf'
    set ib_unitName[610] = "ä¹³ç¾Š"
    set ib_unitArmor[610] = "medium"
    set ib_unitNameGbk[610] = "ÈéÑò"
    set ib_unitList[611] = 'nshp'
    set ib_unitName[611] = "åœ°ç²¾èˆ¹å"
    set ib_unitArmor[611] = "fort"
    set ib_unitNameGbk[611] = "µØ¾«´¬Îë"
    set ib_unitList[612] = 'nshr'
    set ib_unitName[612] = "ç¥æ®¿"
    set ib_unitArmor[612] = "fort"
    set ib_unitNameGbk[612] = "Éñµî"
    set ib_unitList[613] = 'nshw'
    set ib_unitName[613] = "ç»µç¾Š"
    set ib_unitArmor[613] = "medium"
    set ib_unitNameGbk[613] = "ÃàÑò"
    set ib_unitList[614] = 'nska'
    set ib_unitName[614] = "éª·é«…å¼“ç®­æ‰‹"
    set ib_unitArmor[614] = "large"
    set ib_unitNameGbk[614] = "÷¼÷Ã¹­¼ıÊÖ"
    set ib_unitList[615] = 'nske'
    set ib_unitName[615] = "éª·é«…æˆ˜å£«"
    set ib_unitArmor[615] = "large"
    set ib_unitNameGbk[615] = "÷¼÷ÃÕ½Ê¿"
    set ib_unitList[616] = 'nskf'
    set ib_unitName[616] = "ç«ç„°å¼“ç®­æ‰‹"
    set ib_unitArmor[616] = "large"
    set ib_unitNameGbk[616] = "»ğÑæ¹­¼ıÊÖ"
    set ib_unitList[617] = 'nskg'
    set ib_unitName[617] = "å·¨å‹éª·é«…æˆ˜å£«"
    set ib_unitArmor[617] = "large"
    set ib_unitNameGbk[617] = "¾ŞĞÍ÷¼÷ÃÕ½Ê¿"
    set ib_unitList[618] = 'nskk'
    set ib_unitName[618] = "å°èœ¥èœ´"
    set ib_unitArmor[618] = "medium"
    set ib_unitNameGbk[618] = "Ğ¡òáòæ"
    set ib_unitList[619] = 'nskm'
    set ib_unitName[619] = "éª·é«…å°„æ‰‹"
    set ib_unitArmor[619] = "large"
    set ib_unitNameGbk[619] = "÷¼÷ÃÉäÊÖ"
    set ib_unitList[620] = 'nsko'
    set ib_unitName[620] = "å…½æ—éª·é«…"
    set ib_unitArmor[620] = "large"
    set ib_unitNameGbk[620] = "ÊŞ×å÷¼÷Ã"
    set ib_unitList[621] = 'nslf'
    set ib_unitName[621] = "æ·¤æ³¥æŠ•æ‰‹"
    set ib_unitArmor[621] = "medium"
    set ib_unitNameGbk[621] = "ÓÙÄàÍ¶ÊÖ"
    set ib_unitList[622] = 'nslh'
    set ib_unitName[622] = "å°èœ¥èœ´"
    set ib_unitArmor[622] = "large"
    set ib_unitNameGbk[622] = "Ğ¡òáòæ"
    set ib_unitList[623] = 'nsll'
    set ib_unitName[623] = "èœ¥èœ´é¢†ä¸»"
    set ib_unitArmor[623] = "large"
    set ib_unitNameGbk[623] = "òáòæÁìÖ÷"
    set ib_unitList[624] = 'nslm'
    set ib_unitName[624] = "æ·¤æ³¥æˆ˜å£«"
    set ib_unitArmor[624] = "medium"
    set ib_unitNameGbk[624] = "ÓÙÄàÕ½Ê¿"
    set ib_unitList[625] = 'nsln'
    set ib_unitName[625] = "æ·¤æ³¥æ€ªç‰©"
    set ib_unitArmor[625] = "large"
    set ib_unitNameGbk[625] = "ÓÙÄà¹ÖÎï"
    set ib_unitList[626] = 'nslr'
    set ib_unitName[626] = "èœ¥èœ´æ€ªç‰©"
    set ib_unitArmor[626] = "large"
    set ib_unitNameGbk[626] = "òáòæ¹ÖÎï"
    set ib_unitList[627] = 'nslv'
    set ib_unitName[627] = "å¤§å‹èœ¥èœ´æ€ªç‰©"
    set ib_unitArmor[627] = "large"
    set ib_unitNameGbk[627] = "´óĞÍòáòæ¹ÖÎï"
    set ib_unitList[628] = 'nsno'
    set ib_unitName[628] = "é›ªé¹°"
    set ib_unitArmor[628] = "medium"
    set ib_unitNameGbk[628] = "Ñ©Ó¥"
    set ib_unitList[629] = 'nsnp'
    set ib_unitName[629] = "é£é¾™"
    set ib_unitArmor[629] = "medium"
    set ib_unitNameGbk[629] = "·ÉÁú"
    set ib_unitList[630] = 'nsns'
    set ib_unitName[630] = "æ°´å¥´"
    set ib_unitArmor[630] = "medium"
    set ib_unitNameGbk[630] = "Ë®Å«"
    set ib_unitList[631] = 'nsoc'
    set ib_unitName[631] = "å…½æ—æˆ˜å£«éª·é«…"
    set ib_unitArmor[631] = "large"
    set ib_unitNameGbk[631] = "ÊŞ×åÕ½Ê¿÷¼÷Ã"
    set ib_unitList[632] = 'nsog'
    set ib_unitName[632] = "å…½æ—æ­¥å…µéª·é«…"
    set ib_unitArmor[632] = "large"
    set ib_unitNameGbk[632] = "ÊŞ×å²½±ø÷¼÷Ã"
    set ib_unitList[633] = 'nspb'
    set ib_unitName[633] = "é»‘èœ˜è››"
    set ib_unitArmor[633] = "large"
    set ib_unitNameGbk[633] = "ºÚÖ©Öë"
    set ib_unitList[634] = 'nspc'
    set ib_unitName[634] = "æ”¯æŸ±"
    set ib_unitArmor[634] = "fort"
    set ib_unitNameGbk[634] = "Ö§Öù"
    set ib_unitList[635] = 'nspd'
    set ib_unitName[635] = "å°èœ˜è››"
    set ib_unitArmor[635] = "medium"
    set ib_unitNameGbk[635] = "Ğ¡Ö©Öë"
    set ib_unitList[636] = 'nspg'
    set ib_unitName[636] = "æ£®æ—èœ˜è››"
    set ib_unitArmor[636] = "large"
    set ib_unitNameGbk[636] = "É­ÁÖÖ©Öë"
    set ib_unitList[637] = 'nspp'
    set ib_unitName[637] = "çµé­‚ä¹‹çŒª"
    set ib_unitArmor[637] = "large"
    set ib_unitNameGbk[637] = "Áé»êÖ®Öí"
    set ib_unitList[638] = 'nspr'
    set ib_unitName[638] = "èœ˜è››"
    set ib_unitArmor[638] = "large"
    set ib_unitNameGbk[638] = "Ö©Öë"
    set ib_unitList[639] = 'nsqa'
    set ib_unitName[639] = "å¤ä»£é‡äºº"
    set ib_unitArmor[639] = "large"
    set ib_unitNameGbk[639] = "¹Å´úÒ°ÈË"
endfunction
function IB_UnitFill8 takes nothing returns nothing
    set ib_unitList[640] = 'nsqe'
    set ib_unitName[640] = "é‡äººé•¿è€…"
    set ib_unitArmor[640] = "large"
    set ib_unitNameGbk[640] = "Ò°ÈË³¤Õß"
    set ib_unitList[641] = 'nsqo'
    set ib_unitName[641] = "é‡äººç¥ä½¿"
    set ib_unitArmor[641] = "large"
    set ib_unitNameGbk[641] = "Ò°ÈËÉñÊ¹"
    set ib_unitList[642] = 'nsqt'
    set ib_unitName[642] = "é‡äºº"
    set ib_unitArmor[642] = "large"
    set ib_unitNameGbk[642] = "Ò°ÈË"
    set ib_unitList[643] = 'nsra'
    set ib_unitName[643] = "é£æš´æ’•è£‚è€…å­¦å¾’"
    set ib_unitArmor[643] = "medium"
    set ib_unitNameGbk[643] = "·ç±©ËºÁÑÕßÑ§Í½"
    set ib_unitList[644] = 'nsrh'
    set ib_unitName[644] = "é£æš´æ’•è£‚è€…éšå£«"
    set ib_unitArmor[644] = "medium"
    set ib_unitNameGbk[644] = "·ç±©ËºÁÑÕßÒşÊ¿"
    set ib_unitList[645] = 'nsrn'
    set ib_unitName[645] = "é£æš´æ’•è£‚è€…æœ¯å£«"
    set ib_unitArmor[645] = "large"
    set ib_unitNameGbk[645] = "·ç±©ËºÁÑÕßÊõÊ¿"
    set ib_unitList[646] = 'nsrv'
    set ib_unitName[646] = "æµ·ä¹‹å¹½çµ"
    set ib_unitArmor[646] = "large"
    set ib_unitNameGbk[646] = "º£Ö®ÓÄÁé"
    set ib_unitList[647] = 'nsrw'
    set ib_unitName[647] = "é£æš´æ’•è£‚è€…å·«å¸ˆ"
    set ib_unitArmor[647] = "large"
    set ib_unitNameGbk[647] = "·ç±©ËºÁÑÕßÎ×Ê¦"
    set ib_unitList[648] = 'nssn'
    set ib_unitName[648] = "å®ˆæœ›è€…"
    set ib_unitArmor[648] = "large"
    set ib_unitNameGbk[648] = "ÊØÍûÕß"
    set ib_unitList[649] = 'nssp'
    set ib_unitName[649] = "æ¯’æ¶²èœ˜è››"
    set ib_unitArmor[649] = "large"
    set ib_unitNameGbk[649] = "¶¾ÒºÖ©Öë"
    set ib_unitList[650] = 'nsth'
    set ib_unitName[650] = "èµ›ç‰¹æ–¯ä¹‹åœ°ç‹±ä½¿è€…"
    set ib_unitArmor[650] = "large"
    set ib_unitNameGbk[650] = "ÈüÌØË¹Ö®µØÓüÊ¹Õß"
    set ib_unitList[651] = 'nstl'
    set ib_unitName[651] = "èµ›ç‰¹æ–¯ä¹‹çµé­‚ç›—è´¼"
    set ib_unitArmor[651] = "large"
    set ib_unitNameGbk[651] = "ÈüÌØË¹Ö®Áé»êµÁÔô"
    set ib_unitList[652] = 'nsts'
    set ib_unitName[652] = "èµ›ç‰¹æ–¯ä¹‹é»‘æš—èˆè€…"
    set ib_unitArmor[652] = "medium"
    set ib_unitNameGbk[652] = "ÈüÌØË¹Ö®ºÚ°µÎèÕß"
    set ib_unitList[653] = 'nstw'
    set ib_unitName[653] = "é£æš´å·¨é¾™"
    set ib_unitArmor[653] = "large"
    set ib_unitNameGbk[653] = "·ç±©¾ŞÁú"
    set ib_unitList[654] = 'nsty'
    set ib_unitName[654] = "èµ›ç‰¹æ–¯"
    set ib_unitArmor[654] = "large"
    set ib_unitNameGbk[654] = "ÈüÌØË¹"
    set ib_unitList[655] = 'nsw1'
    set ib_unitName[655] = "å°å‹çµå…½"
    set ib_unitArmor[655] = "large"
    set ib_unitNameGbk[655] = "Ğ¡ĞÍÁéÊŞ"
    set ib_unitList[656] = 'nsw2'
    set ib_unitName[656] = "çµå…½"
    set ib_unitArmor[656] = "large"
    set ib_unitNameGbk[656] = "ÁéÊŞ"
    set ib_unitList[657] = 'nsw3'
    set ib_unitName[657] = "å¤§å‹çµå…½"
    set ib_unitArmor[657] = "large"
    set ib_unitNameGbk[657] = "´óĞÍÁéÊŞ"
    set ib_unitList[658] = 'ntav'
    set ib_unitName[658] = "å°é…’é¦†"
    set ib_unitArmor[658] = "fort"
    set ib_unitNameGbk[658] = "Ğ¡¾Æ¹İ"
    set ib_unitList[659] = 'nten'
    set ib_unitName[659] = "å¸ç¯·"
    set ib_unitArmor[659] = "fort"
    set ib_unitNameGbk[659] = "ÕÊÅñ"
    set ib_unitList[660] = 'nth0'
    set ib_unitName[660] = "å†°ä¹‹å·¨é­”å°å±‹"
    set ib_unitArmor[660] = "fort"
    set ib_unitNameGbk[660] = "±ùÖ®¾ŞÄ§Ğ¡Îİ"
    set ib_unitList[661] = 'nth1'
    set ib_unitName[661] = "å†°ä¹‹å·¨é­”å°å±‹"
    set ib_unitArmor[661] = "fort"
    set ib_unitNameGbk[661] = "±ùÖ®¾ŞÄ§Ğ¡Îİ"
    set ib_unitList[662] = 'nthl'
    set ib_unitName[662] = "é›·éœ†èœ¥èœ´"
    set ib_unitArmor[662] = "large"
    set ib_unitNameGbk[662] = "À×öªòáòæ"
    set ib_unitList[663] = 'nthr'
    set ib_unitName[663] = "è¨é‡Œæ³•æ–¯"
    set ib_unitArmor[663] = "small"
    set ib_unitNameGbk[663] = "ÈøÀï·¨Ë¹"
    set ib_unitList[664] = 'ntka'
    set ib_unitName[664] = "å›¾æ–¯å¡å°”æªå…µ"
    set ib_unitArmor[664] = "large"
    set ib_unitNameGbk[664] = "Í¼Ë¹¿¨¶ûÇ¹±ø"
    set ib_unitList[665] = 'ntkc'
    set ib_unitName[665] = "å›¾æ–¯å¡å°”é…‹é•¿"
    set ib_unitArmor[665] = "large"
    set ib_unitNameGbk[665] = "Í¼Ë¹¿¨¶ûÇõ³¤"
    set ib_unitList[666] = 'ntkf'
    set ib_unitName[666] = "å›¾æ–¯å¡å°”æ ¼æ–—è€…"
    set ib_unitArmor[666] = "large"
    set ib_unitNameGbk[666] = "Í¼Ë¹¿¨¶û¸ñ¶·Õß"
    set ib_unitList[667] = 'ntkh'
    set ib_unitName[667] = "å›¾æ–¯å¡å°”å·«å¸ˆ"
    set ib_unitArmor[667] = "medium"
    set ib_unitNameGbk[667] = "Í¼Ë¹¿¨¶ûÎ×Ê¦"
    set ib_unitList[668] = 'ntks'
    set ib_unitName[668] = "å›¾æ–¯å¡å°”ç”·å·«"
    set ib_unitArmor[668] = "medium"
    set ib_unitNameGbk[668] = "Í¼Ë¹¿¨¶ûÄĞÎ×"
    set ib_unitList[669] = 'ntkt'
    set ib_unitName[669] = "å›¾æ–¯å¡å°”çŒäºº"
    set ib_unitArmor[669] = "medium"
    set ib_unitNameGbk[669] = "Í¼Ë¹¿¨¶ûÁÔÈË"
    set ib_unitList[670] = 'ntkw'
    set ib_unitName[670] = "å›¾æ–¯å¡å°”æˆ˜å£«"
    set ib_unitArmor[670] = "large"
    set ib_unitNameGbk[670] = "Í¼Ë¹¿¨¶ûÕ½Ê¿"
    set ib_unitList[671] = 'ntn2'
    set ib_unitName[671] = "å¸ç¯·"
    set ib_unitArmor[671] = "fort"
    set ib_unitNameGbk[671] = "ÕÊÅñ"
    set ib_unitList[672] = 'ntnt'
    set ib_unitName[672] = "ç‰›å¤´äººå¸ç¯·"
    set ib_unitArmor[672] = "fort"
    set ib_unitNameGbk[672] = "Å£Í·ÈËÕÊÅñ"
    set ib_unitList[673] = 'ntor'
    set ib_unitName[673] = "é¾™å·é£"
    set ib_unitArmor[673] = "large"
    set ib_unitNameGbk[673] = "Áú¾í·ç"
    set ib_unitList[674] = 'ntrd'
    set ib_unitName[674] = "é¾™é¾Ÿ"
    set ib_unitArmor[674] = "large"
    set ib_unitNameGbk[674] = "Áú¹ê"
    set ib_unitList[675] = 'ntrg'
    set ib_unitName[675] = "å¤§æµ·é¾Ÿ"
    set ib_unitArmor[675] = "large"
    set ib_unitNameGbk[675] = "´óº£¹ê"
    set ib_unitList[676] = 'ntrh'
    set ib_unitName[676] = "å°æµ·é¾Ÿ"
    set ib_unitArmor[676] = "medium"
    set ib_unitNameGbk[676] = "Ğ¡º£¹ê"
    set ib_unitList[677] = 'ntrs'
    set ib_unitName[677] = "æµ·é¾Ÿ"
    set ib_unitArmor[677] = "large"
    set ib_unitNameGbk[677] = "º£¹ê"
    set ib_unitList[678] = 'ntrt'
    set ib_unitName[678] = "å¤§æµ·é¾Ÿ"
    set ib_unitArmor[678] = "medium"
    set ib_unitNameGbk[678] = "´óº£¹ê"
    set ib_unitList[679] = 'ntrv'
    set ib_unitName[679] = "æ½®æ±å¹½çµ"
    set ib_unitArmor[679] = "large"
    set ib_unitNameGbk[679] = "³±Ï«ÓÄÁé"
    set ib_unitList[680] = 'ntt1'
    set ib_unitName[680] = "æ­»äº¡ä¹‹å¡”"
    set ib_unitArmor[680] = "fort"
    set ib_unitNameGbk[680] = "ËÀÍöÖ®Ëş"
    set ib_unitList[681] = 'ntt2'
    set ib_unitName[681] = "ç‰›å¤´äººå¸ç¯·"
    set ib_unitArmor[681] = "fort"
    set ib_unitNameGbk[681] = "Å£Í·ÈËÕÊÅñ"
    set ib_unitList[682] = 'ntws'
    set ib_unitName[682] = "æ°´å¥´"
    set ib_unitArmor[682] = "large"
    set ib_unitNameGbk[682] = "Ë®Å«"
    set ib_unitList[683] = 'ntx2'
    set ib_unitName[683] = "é«˜çº§æ­»äº¡ä¹‹å¡”"
    set ib_unitArmor[683] = "fort"
    set ib_unitNameGbk[683] = "¸ß¼¶ËÀÍöÖ®Ëş"
    set ib_unitList[684] = 'nubk'
    set ib_unitName[684] = "æ— æ•Œé»‘æš—çŒäºº"
    set ib_unitArmor[684] = "large"
    set ib_unitNameGbk[684] = "ÎŞµĞºÚ°µÁÔÈË"
    set ib_unitList[685] = 'nubr'
    set ib_unitName[685] = "æ— æ•Œç‹‚æš´è€…"
    set ib_unitArmor[685] = "large"
    set ib_unitNameGbk[685] = "ÎŞµĞ¿ñ±©Õß"
    set ib_unitList[686] = 'nubw'
    set ib_unitName[686] = "æ— æ•Œé»‘æš—èˆè€…"
    set ib_unitArmor[686] = "large"
    set ib_unitNameGbk[686] = "ÎŞµĞºÚ°µÎèÕß"
    set ib_unitList[687] = 'nvde'
    set ib_unitName[687] = "è™šæ— è¡Œè€…é•¿è€"
    set ib_unitArmor[687] = "large"
    set ib_unitNameGbk[687] = "ĞéÎŞĞĞÕß³¤ÀÏ"
    set ib_unitList[688] = 'nvdg'
    set ib_unitName[688] = "å·¨å¤§è™šæ— è¡Œè€…é•¿è€"
    set ib_unitArmor[688] = "large"
    set ib_unitNameGbk[688] = "¾Ş´óĞéÎŞĞĞÕß³¤ÀÏ"
    set ib_unitList[689] = 'nvdl'
    set ib_unitName[689] = "å°å‹è™šæ— è¡Œè€…"
    set ib_unitArmor[689] = "medium"
    set ib_unitNameGbk[689] = "Ğ¡ĞÍĞéÎŞĞĞÕß"
    set ib_unitList[690] = 'nvdw'
    set ib_unitName[690] = "è™šæ— è¡Œè€…"
    set ib_unitArmor[690] = "medium"
    set ib_unitNameGbk[690] = "ĞéÎŞĞĞÕß"
    set ib_unitList[691] = 'nvil'
    set ib_unitName[691] = "æ‘æ°‘"
    set ib_unitArmor[691] = "medium"
    set ib_unitNameGbk[691] = "´åÃñ"
    set ib_unitList[692] = 'nvk2'
    set ib_unitName[692] = "å°å­©"
    set ib_unitArmor[692] = "medium"
    set ib_unitNameGbk[692] = "Ğ¡º¢"
    set ib_unitList[693] = 'nvl2'
    set ib_unitName[693] = "æ‘æ°‘"
    set ib_unitArmor[693] = "medium"
    set ib_unitNameGbk[693] = "´åÃñ"
    set ib_unitList[694] = 'nvlk'
    set ib_unitName[694] = "å°å­©"
    set ib_unitArmor[694] = "medium"
    set ib_unitNameGbk[694] = "Ğ¡º¢"
    set ib_unitList[695] = 'nvlw'
    set ib_unitName[695] = "æ‘æ°‘"
    set ib_unitArmor[695] = "medium"
    set ib_unitNameGbk[695] = "´åÃñ"
    set ib_unitList[696] = 'nvr0'
    set ib_unitName[696] = "æš—å¤œç²¾çµæ—æ¸”æ‘"
    set ib_unitArmor[696] = "fort"
    set ib_unitNameGbk[696] = "°µÒ¹¾«Áé×åÓæ´å"
    set ib_unitList[697] = 'nvr1'
    set ib_unitName[697] = "æš—å¤œç²¾çµæ—æ¸”æ‘"
    set ib_unitArmor[697] = "fort"
    set ib_unitNameGbk[697] = "°µÒ¹¾«Áé×åÓæ´å"
    set ib_unitList[698] = 'nvr2'
    set ib_unitName[698] = "æš—å¤œç²¾çµæ—æ¸”æ‘"
    set ib_unitArmor[698] = "fort"
    set ib_unitNameGbk[698] = "°µÒ¹¾«Áé×åÓæ´å"
    set ib_unitList[699] = 'nvul'
    set ib_unitName[699] = "ç§ƒé¹°"
    set ib_unitArmor[699] = "medium"
    set ib_unitNameGbk[699] = "ÍºÓ¥"
    set ib_unitList[700] = 'nw2w'
    set ib_unitName[700] = "å…½æ—å·«å¸ˆ"
    set ib_unitArmor[700] = "large"
    set ib_unitNameGbk[700] = "ÊŞ×åÎ×Ê¦"
    set ib_unitList[701] = 'nwad'
    set ib_unitName[701] = "è§‚å¯Ÿå®ˆå«"
    set ib_unitArmor[701] = "medium"
    set ib_unitNameGbk[701] = "¹Û²ìÊØÎÀ"
    set ib_unitList[702] = 'nwat'
    set ib_unitName[702] = "å²—å“¨"
    set ib_unitArmor[702] = "large"
    set ib_unitNameGbk[702] = "¸ÚÉÚ"
    set ib_unitList[703] = 'nwc1'
    set ib_unitName[703] = "åŒè¶³é£é¾™ç‰¢ç¬¼"
    set ib_unitArmor[703] = "fort"
    set ib_unitNameGbk[703] = "Ë«×ã·ÉÁúÀÎÁı"
    set ib_unitList[704] = 'nwc2'
    set ib_unitName[704] = "åŒè¶³é£é¾™ç‰¢ç¬¼"
    set ib_unitArmor[704] = "fort"
    set ib_unitNameGbk[704] = "Ë«×ã·ÉÁúÀÎÁı"
    set ib_unitList[705] = 'nwe1'
    set ib_unitName[705] = "æˆ˜é¹°"
    set ib_unitArmor[705] = "small"
    set ib_unitNameGbk[705] = "Õ½Ó¥"
    set ib_unitList[706] = 'nwe2'
    set ib_unitName[706] = "é›·éœ†æˆ˜é¹°"
    set ib_unitArmor[706] = "small"
    set ib_unitNameGbk[706] = "À×öªÕ½Ó¥"
    set ib_unitList[707] = 'nwe3'
    set ib_unitName[707] = "å½±å­æˆ˜é¹°"
    set ib_unitArmor[707] = "small"
    set ib_unitNameGbk[707] = "Ó°×ÓÕ½Ó¥"
    set ib_unitList[708] = 'nwen'
    set ib_unitName[708] = "é›ªæ€ª"
    set ib_unitArmor[708] = "large"
    set ib_unitNameGbk[708] = "Ñ©¹Ö"
    set ib_unitList[709] = 'nwgs'
    set ib_unitName[709] = "é£è›‡"
    set ib_unitArmor[709] = "small"
    set ib_unitNameGbk[709] = "·ÉÉß"
    set ib_unitList[710] = 'nwgt'
    set ib_unitName[710] = "ä¼ é€é—¨"
    set ib_unitArmor[710] = "fort"
    set ib_unitNameGbk[710] = "´«ËÍÃÅ"
    set ib_unitList[711] = 'nwiz'
    set ib_unitName[711] = "å·«å¸ˆå­¦å¾’"
    set ib_unitArmor[711] = "medium"
    set ib_unitNameGbk[711] = "Î×Ê¦Ñ§Í½"
    set ib_unitList[712] = 'nwld'
    set ib_unitName[712] = "ææ€–ä¹‹ç‹¼"
    set ib_unitArmor[712] = "large"
    set ib_unitNameGbk[712] = "¿Ö²ÀÖ®ÀÇ"
    set ib_unitList[713] = 'nwlg'
    set ib_unitName[713] = "å·¨ç‹¼"
    set ib_unitArmor[713] = "large"
    set ib_unitNameGbk[713] = "¾ŞÀÇ"
    set ib_unitList[714] = 'nwlt'
    set ib_unitName[714] = "å¤§ç°ç‹¼"
    set ib_unitArmor[714] = "large"
    set ib_unitNameGbk[714] = "´ó»ÒÀÇ"
    set ib_unitList[715] = 'nwna'
    set ib_unitName[715] = "è¿œå¤é›ªæ€ª"
    set ib_unitArmor[715] = "large"
    set ib_unitNameGbk[715] = "Ô¶¹ÅÑ©¹Ö"
    set ib_unitList[716] = 'nwnr'
    set ib_unitName[716] = "é›ªæ€ªé•¿è€…"
    set ib_unitArmor[716] = "large"
    set ib_unitNameGbk[716] = "Ñ©¹Ö³¤Õß"
    set ib_unitList[717] = 'nwns'
    set ib_unitName[717] = "é›ªæ€ªè¨æ»¡ç¥­å¸"
    set ib_unitArmor[717] = "large"
    set ib_unitNameGbk[717] = "Ñ©¹ÖÈøÂú¼ÀË¾"
    set ib_unitList[718] = 'nwrg'
    set ib_unitName[718] = "æˆ˜äº‰å‚€å„¡"
    set ib_unitArmor[718] = "large"
    set ib_unitNameGbk[718] = "Õ½Õù¿şÀÜ"
    set ib_unitList[719] = 'nws1'
    set ib_unitName[719] = "é¾™é¹°"
    set ib_unitArmor[719] = "small"
    set ib_unitNameGbk[719] = "ÁúÓ¥"
endfunction
function IB_UnitFill9 takes nothing returns nothing
    set ib_unitList[720] = 'nwwd'
    set ib_unitName[720] = "ææ€–éœœå†»ä¹‹ç‹¼"
    set ib_unitArmor[720] = "large"
    set ib_unitNameGbk[720] = "¿Ö²ÀËª¶³Ö®ÀÇ"
    set ib_unitList[721] = 'nwwf'
    set ib_unitName[721] = "éœœå†»ä¹‹ç‹¼"
    set ib_unitArmor[721] = "large"
    set ib_unitNameGbk[721] = "Ëª¶³Ö®ÀÇ"
    set ib_unitList[722] = 'nwwg'
    set ib_unitName[722] = "å·¨å‹éœœå†»ä¹‹ç‹¼"
    set ib_unitArmor[722] = "large"
    set ib_unitNameGbk[722] = "¾ŞĞÍËª¶³Ö®ÀÇ"
    set ib_unitList[723] = 'nwzd'
    set ib_unitName[723] = "é»‘æš—å·«å¸ˆ"
    set ib_unitArmor[723] = "large"
    set ib_unitNameGbk[723] = "ºÚ°µÎ×Ê¦"
    set ib_unitList[724] = 'nwzg'
    set ib_unitName[724] = "å·«å¸ˆå˜èŠ‚è€…"
    set ib_unitArmor[724] = "medium"
    set ib_unitNameGbk[724] = "Î×Ê¦±ä½ÚÕß"
    set ib_unitList[725] = 'nwzr'
    set ib_unitName[725] = "æµæ°“å·«å¸ˆ"
    set ib_unitArmor[725] = "medium"
    set ib_unitNameGbk[725] = "Á÷Ã¥Î×Ê¦"
    set ib_unitList[726] = 'nzep'
    set ib_unitName[726] = "åœ°ç²¾é£è‰‡"
    set ib_unitArmor[726] = "small"
    set ib_unitNameGbk[726] = "µØ¾«·ÉÍ§"
    set ib_unitList[727] = 'nzin'
    set ib_unitName[727] = "åœ°åŒºæ˜¾ç¤º"
    set ib_unitArmor[727] = "fort"
    set ib_unitNameGbk[727] = "µØÇøÏÔÊ¾"
    set ib_unitList[728] = 'nzlc'
    set ib_unitName[728] = "å·«å¦–ç‹"
    set ib_unitArmor[728] = "fort"
    set ib_unitNameGbk[728] = "Î×ÑıÍõ"
    set ib_unitList[729] = 'nzom'
    set ib_unitName[729] = "åƒµå°¸"
    set ib_unitArmor[729] = "medium"
    set ib_unitNameGbk[729] = "½©Ê¬"
    set ib_unitList[730] = 'oalt'
    set ib_unitName[730] = ""
    set ib_unitArmor[730] = "fort"
    set ib_unitNameGbk[730] = ""
    set ib_unitList[731] = 'obar'
    set ib_unitName[731] = "å…µè¥"
    set ib_unitArmor[731] = "fort"
    set ib_unitNameGbk[731] = "±øÓª"
    set ib_unitList[732] = 'obea'
    set ib_unitName[732] = "å…½æ "
    set ib_unitArmor[732] = "fort"
    set ib_unitNameGbk[732] = "ÊŞÀ¸"
    set ib_unitList[733] = 'obot'
    set ib_unitName[733] = "å…½æ—è¿è¾“èˆ¹"
    set ib_unitArmor[733] = "large"
    set ib_unitNameGbk[733] = "ÊŞ×åÔËÊä´¬"
    set ib_unitList[734] = 'ocat'
    set ib_unitName[734] = "ç²‰ç¢è€…"
    set ib_unitArmor[734] = "large"
    set ib_unitNameGbk[734] = "·ÛËéÕß"
    set ib_unitList[735] = 'ocbw'
    set ib_unitName[735] = "é‚ªæ¶å…½æ—åœ°æ´"
    set ib_unitArmor[735] = "large"
    set ib_unitNameGbk[735] = "Ğ°¶ñÊŞ×åµØ¶´"
    set ib_unitList[736] = 'odes'
    set ib_unitName[736] = "å…½æ—æŠ¤å«èˆ°"
    set ib_unitArmor[736] = "small"
    set ib_unitNameGbk[736] = "ÊŞ×å»¤ÎÀ½¢"
    set ib_unitList[737] = 'odkt'
    set ib_unitName[737] = "å¾·æ‹‰å…‹è‹å°”"
    set ib_unitArmor[737] = "medium"
    set ib_unitNameGbk[737] = "µÂÀ­¿ËËÕ¶û"
    set ib_unitList[738] = 'odoc'
    set ib_unitName[738] = "å·¨é­”å·«åŒ»"
    set ib_unitArmor[738] = "none"
    set ib_unitNameGbk[738] = "¾ŞÄ§Î×Ò½"
    set ib_unitList[739] = 'oeye'
    set ib_unitName[739] = "å²—å“¨å®ˆå«"
    set ib_unitArmor[739] = "medium"
    set ib_unitNameGbk[739] = "¸ÚÉÚÊØÎÀ"
    set ib_unitList[740] = 'ofor'
    set ib_unitName[740] = "æˆ˜äº‰ç£¨åŠ"
    set ib_unitArmor[740] = "fort"
    set ib_unitNameGbk[740] = "Õ½ÕùÄ¥·»"
    set ib_unitList[741] = 'ofrt'
    set ib_unitName[741] = "å ¡å’"
    set ib_unitArmor[741] = "fort"
    set ib_unitNameGbk[741] = "±¤Àİ"
    set ib_unitList[742] = 'ogre'
    set ib_unitName[742] = "å¤§å…"
    set ib_unitArmor[742] = "fort"
    set ib_unitNameGbk[742] = "´óÌü"
    set ib_unitList[743] = 'ogrk'
    set ib_unitName[743] = "åŠ ç´¢å…‹"
    set ib_unitArmor[743] = "large"
    set ib_unitNameGbk[743] = "¼ÓË÷¿Ë"
    set ib_unitList[744] = 'ogru'
    set ib_unitName[744] = "å…½æ—æ­¥å…µ"
    set ib_unitArmor[744] = "large"
    set ib_unitNameGbk[744] = "ÊŞ×å²½±ø"
    set ib_unitList[745] = 'ohun'
    set ib_unitName[745] = "å·¨é­”çŒå¤´è€…"
    set ib_unitArmor[745] = "medium"
    set ib_unitNameGbk[745] = "¾ŞÄ§ÁÔÍ·Õß"
    set ib_unitList[746] = 'ohwd'
    set ib_unitName[746] = "æ²»ç–—å®ˆå«"
    set ib_unitArmor[746] = "medium"
    set ib_unitNameGbk[746] = "ÖÎÁÆÊØÎÀ"
    set ib_unitList[747] = 'ojgn'
    set ib_unitName[747] = "å…½æ—é­”åŠ›æˆ˜èˆ°"
    set ib_unitArmor[747] = "large"
    set ib_unitNameGbk[747] = "ÊŞ×åÄ§Á¦Õ½½¢"
    set ib_unitList[748] = 'okod'
    set ib_unitName[748] = "ç§‘å¤šå…½"
    set ib_unitArmor[748] = "none"
    set ib_unitNameGbk[748] = "¿Æ¶àÊŞ"
    set ib_unitList[749] = 'omtg'
    set ib_unitName[749] = "é©¬ç´¢æ ¼"
    set ib_unitArmor[749] = "large"
    set ib_unitNameGbk[749] = "ÂíË÷¸ñ"
    set ib_unitList[750] = 'onzg'
    set ib_unitName[750] = "é‚£æ»‹ç›–å°”"
    set ib_unitArmor[750] = "medium"
    set ib_unitNameGbk[750] = "ÄÇ×Ì¸Ç¶û"
    set ib_unitList[751] = 'oosc'
    set ib_unitName[751] = "ç§‘å¤šå…½"
    set ib_unitArmor[751] = "large"
    set ib_unitNameGbk[751] = "¿Æ¶àÊŞ"
    set ib_unitList[752] = 'opeo'
    set ib_unitName[752] = "è‹¦å·¥"
    set ib_unitArmor[752] = "medium"
    set ib_unitNameGbk[752] = "¿à¹¤"
    set ib_unitList[753] = 'orai'
    set ib_unitName[753] = "æ å¤ºè€…"
    set ib_unitArmor[753] = "medium"
    set ib_unitNameGbk[753] = "ÂÓ¶áÕß"
    set ib_unitList[754] = 'oshm'
    set ib_unitName[754] = "è¨æ»¡ç¥­å¸"
    set ib_unitArmor[754] = "none"
    set ib_unitNameGbk[754] = "ÈøÂú¼ÀË¾"
    set ib_unitList[755] = 'oshy'
    set ib_unitName[755] = "å…½æ—èˆ¹å"
    set ib_unitArmor[755] = "fort"
    set ib_unitNameGbk[755] = "ÊŞ×å´¬Îë"
    set ib_unitList[756] = 'osld'
    set ib_unitName[756] = "çµé­‚å½’å®¿"
    set ib_unitArmor[756] = "fort"
    set ib_unitNameGbk[756] = "Áé»ê¹éËŞ"
    set ib_unitList[757] = 'osp1'
    set ib_unitName[757] = "æ¯’è›‡å®ˆå«"
    set ib_unitArmor[757] = "large"
    set ib_unitNameGbk[757] = "¶¾ÉßÊØÎÀ"
    set ib_unitList[758] = 'osp2'
    set ib_unitName[758] = "æ¯’è›‡å®ˆå«"
    set ib_unitArmor[758] = "large"
    set ib_unitNameGbk[758] = "¶¾ÉßÊØÎÀ"
    set ib_unitList[759] = 'osp3'
    set ib_unitName[759] = "æ¯’è›‡å®ˆå«"
    set ib_unitArmor[759] = "large"
    set ib_unitNameGbk[759] = "¶¾ÉßÊØÎÀ"
    set ib_unitList[760] = 'osp4'
    set ib_unitName[760] = "æ¯’è›‡å®ˆå«"
    set ib_unitArmor[760] = "large"
    set ib_unitNameGbk[760] = "¶¾ÉßÊØÎÀ"
    set ib_unitList[761] = 'ospm'
    set ib_unitName[761] = "çµé­‚è¡Œè€…"
    set ib_unitArmor[761] = "none"
    set ib_unitNameGbk[761] = "Áé»êĞĞÕß"
    set ib_unitList[762] = 'ospw'
    set ib_unitName[762] = "çµé­‚è¡Œè€…"
    set ib_unitArmor[762] = "none"
    set ib_unitNameGbk[762] = "Áé»êĞĞÕß"
    set ib_unitList[763] = 'ostr'
    set ib_unitName[763] = "è¦å¡"
    set ib_unitArmor[763] = "fort"
    set ib_unitNameGbk[763] = "ÒªÈû"
    set ib_unitList[764] = 'osw1'
    set ib_unitName[764] = "å¹½é­‚ä¹‹ç‹¼"
    set ib_unitArmor[764] = "large"
    set ib_unitNameGbk[764] = "ÓÄ»êÖ®ÀÇ"
    set ib_unitList[765] = 'osw2'
    set ib_unitName[765] = "ææƒ§ä¹‹ç‹¼"
    set ib_unitArmor[765] = "large"
    set ib_unitNameGbk[765] = "¿Ö¾åÖ®ÀÇ"
    set ib_unitList[766] = 'osw3'
    set ib_unitName[766] = "é˜´å½±ä¹‹ç‹¼"
    set ib_unitArmor[766] = "large"
    set ib_unitNameGbk[766] = "ÒõÓ°Ö®ÀÇ"
    set ib_unitList[767] = 'oswy'
    set ib_unitName[767] = "çµé­‚é£é¾™"
    set ib_unitArmor[767] = "small"
    set ib_unitNameGbk[767] = "Áé»ê·ÉÁú"
    set ib_unitList[768] = 'otau'
    set ib_unitName[768] = "ç‰›å¤´äºº"
    set ib_unitArmor[768] = "large"
    set ib_unitNameGbk[768] = "Å£Í·ÈË"
    set ib_unitList[769] = 'otbk'
    set ib_unitName[769] = "å·¨é­”ç‹‚æš´æˆ˜å£«"
    set ib_unitArmor[769] = "medium"
    set ib_unitNameGbk[769] = "¾ŞÄ§¿ñ±©Õ½Ê¿"
    set ib_unitList[770] = 'otbr'
    set ib_unitName[770] = "å·¨é­”è™è éª‘å£«"
    set ib_unitArmor[770] = "small"
    set ib_unitNameGbk[770] = "¾ŞÄ§òùòğÆïÊ¿"
    set ib_unitList[771] = 'otot'
    set ib_unitName[771] = "é™æ­¢é™·é˜±"
    set ib_unitArmor[771] = "medium"
    set ib_unitNameGbk[771] = "¾²Ö¹ÏİÚå"
    set ib_unitList[772] = 'otrb'
    set ib_unitName[772] = "å…½æ—åœ°æ´"
    set ib_unitArmor[772] = "large"
    set ib_unitNameGbk[772] = "ÊŞ×åµØ¶´"
    set ib_unitList[773] = 'otto'
    set ib_unitName[773] = "ç‰›å¤´äººå›¾è…¾"
    set ib_unitArmor[773] = "fort"
    set ib_unitNameGbk[773] = "Å£Í·ÈËÍ¼ÌÚ"
    set ib_unitList[774] = 'ovlj'
    set ib_unitName[774] = "æ²ƒå°”äº¬"
    set ib_unitArmor[774] = "none"
    set ib_unitNameGbk[774] = "ÎÖ¶û¾©"
    set ib_unitList[775] = 'ovln'
    set ib_unitName[775] = "å·«æ¯’å•†åº—"
    set ib_unitArmor[775] = "fort"
    set ib_unitNameGbk[775] = "Î×¶¾ÉÌµê"
    set ib_unitList[776] = 'owar'
    set ib_unitName[776] = "å…½æ—æˆ˜äº‰é¦–é¢†"
    set ib_unitArmor[776] = "large"
    set ib_unitNameGbk[776] = "ÊŞ×åÕ½ÕùÊ×Áì"
    set ib_unitList[777] = 'ownr'
    set ib_unitName[777] = "åŒè¶³é£é¾™"
    set ib_unitArmor[777] = "small"
    set ib_unitNameGbk[777] = "Ë«×ã·ÉÁú"
    set ib_unitList[778] = 'owtw'
    set ib_unitName[778] = "äº†æœ›å¡”"
    set ib_unitArmor[778] = "large"
    set ib_unitNameGbk[778] = "ÁËÍûËş"
    set ib_unitList[779] = 'owyv'
    set ib_unitName[779] = "é£éª‘å£«"
    set ib_unitArmor[779] = "small"
    set ib_unitNameGbk[779] = "·çÆïÊ¿"
    set ib_unitList[780] = 'uabc'
    set ib_unitName[780] = "æ†æ¶"
    set ib_unitArmor[780] = "small"
    set ib_unitNameGbk[780] = "Ô÷¶ñ"
    set ib_unitList[781] = 'uabo'
    set ib_unitName[781] = "æ†æ¶"
    set ib_unitArmor[781] = "large"
    set ib_unitNameGbk[781] = "Ô÷¶ñ"
    set ib_unitList[782] = 'uaco'
    set ib_unitName[782] = "ä¾åƒ§"
    set ib_unitArmor[782] = "medium"
    set ib_unitNameGbk[782] = "ÊÌÉ®"
    set ib_unitList[783] = 'uaod'
    set ib_unitName[783] = "é»‘æš—ç¥­å›"
    set ib_unitArmor[783] = "fort"
    set ib_unitNameGbk[783] = "ºÚ°µ¼ÀÌ³"
    set ib_unitList[784] = 'uarb'
    set ib_unitName[784] = "é£è‰‡"
    set ib_unitArmor[784] = "small"
    set ib_unitNameGbk[784] = "·ÉÍ§"
    set ib_unitList[785] = 'uban'
    set ib_unitName[785] = "å¥³å¦–"
    set ib_unitArmor[785] = "none"
    set ib_unitNameGbk[785] = "Å®Ñı"
    set ib_unitList[786] = 'ubdd'
    set ib_unitName[786] = "è¨çš®æ´›æ©"
    set ib_unitArmor[786] = "small"
    set ib_unitNameGbk[786] = "ÈøÆ¤Âå¶÷"
    set ib_unitList[787] = 'ubdr'
    set ib_unitName[787] = "è¨çš®æ´›æ©"
    set ib_unitArmor[787] = "small"
    set ib_unitNameGbk[787] = "ÈøÆ¤Âå¶÷"
    set ib_unitList[788] = 'ubon'
    set ib_unitName[788] = "åŸ‹éª¨åœ°"
    set ib_unitArmor[788] = "fort"
    set ib_unitNameGbk[788] = "Âñ¹ÇµØ"
    set ib_unitList[789] = 'ubot'
    set ib_unitName[789] = "ä¸æ­»æ—è¿è¾“èˆ¹"
    set ib_unitArmor[789] = "large"
    set ib_unitNameGbk[789] = "²»ËÀ×åÔËÊä´¬"
    set ib_unitList[790] = 'ubsp'
    set ib_unitName[790] = "ç ´åè€…"
    set ib_unitArmor[790] = "small"
    set ib_unitNameGbk[790] = "ÆÆ»µÕß"
    set ib_unitList[791] = 'ucrm'
    set ib_unitName[791] = "é’»å…¥åœ°ä¸‹çš„ç©´å±…æ¶é­”"
    set ib_unitArmor[791] = "medium"
    set ib_unitNameGbk[791] = "×êÈëµØÏÂµÄÑ¨¾Ó¶ñÄ§"
    set ib_unitList[792] = 'ucry'
    set ib_unitName[792] = "ç©´å±…æ¶é­”"
    set ib_unitArmor[792] = "medium"
    set ib_unitNameGbk[792] = "Ñ¨¾Ó¶ñÄ§"
    set ib_unitList[793] = 'ucs1'
    set ib_unitName[793] = "è…å°¸ç”²è™«"
    set ib_unitArmor[793] = "large"
    set ib_unitNameGbk[793] = "¸¯Ê¬¼×³æ"
    set ib_unitList[794] = 'ucs2'
    set ib_unitName[794] = "è…å°¸ç”²è™«"
    set ib_unitArmor[794] = "large"
    set ib_unitNameGbk[794] = "¸¯Ê¬¼×³æ"
    set ib_unitList[795] = 'ucs3'
    set ib_unitName[795] = "è…å°¸ç”²è™«"
    set ib_unitArmor[795] = "large"
    set ib_unitNameGbk[795] = "¸¯Ê¬¼×³æ"
    set ib_unitList[796] = 'ucsB'
    set ib_unitName[796] = "é’»å…¥åœ°ä¸‹çš„è…å°¸ç”²è™«"
    set ib_unitArmor[796] = "large"
    set ib_unitNameGbk[796] = "×êÈëµØÏÂµÄ¸¯Ê¬¼×³æ"
    set ib_unitList[797] = 'ucsC'
    set ib_unitName[797] = "é’»å…¥åœ°ä¸‹çš„è…å°¸ç”²è™«"
    set ib_unitArmor[797] = "large"
    set ib_unitNameGbk[797] = "×êÈëµØÏÂµÄ¸¯Ê¬¼×³æ"
    set ib_unitList[798] = 'udes'
    set ib_unitName[798] = "ä¸æ­»æ—æ—æŠ¤å«èˆ°"
    set ib_unitArmor[798] = "small"
    set ib_unitNameGbk[798] = "²»ËÀ×å×å»¤ÎÀ½¢"
    set ib_unitList[799] = 'ufro'
    set ib_unitName[799] = "å†°éœœå·¨é¾™"
    set ib_unitArmor[799] = "small"
    set ib_unitNameGbk[799] = "±ùËª¾ŞÁú"
endfunction
function IB_UnitFill10 takes nothing returns nothing
    set ib_unitList[800] = 'ugar'
    set ib_unitName[800] = "çŸ³åƒé¬¼"
    set ib_unitArmor[800] = "none"
    set ib_unitNameGbk[800] = "Ê¯Ïñ¹í"
    set ib_unitList[801] = 'ugho'
    set ib_unitName[801] = "é£Ÿå°¸é¬¼"
    set ib_unitArmor[801] = "large"
    set ib_unitNameGbk[801] = "Ê³Ê¬¹í"
    set ib_unitList[802] = 'ugol'
    set ib_unitName[802] = "é—¹é¬¼é‡‘çŸ¿"
    set ib_unitArmor[802] = "fort"
    set ib_unitNameGbk[802] = "ÄÖ¹í½ğ¿ó"
    set ib_unitList[803] = 'ugrm'
    set ib_unitName[803] = "çŸ³åƒå½¢æ€ä¸‹çš„çŸ³åƒé¬¼"
    set ib_unitArmor[803] = "none"
    set ib_unitNameGbk[803] = "Ê¯ÏñĞÎÌ¬ÏÂµÄÊ¯Ïñ¹í"
    set ib_unitList[804] = 'ugrv'
    set ib_unitName[804] = "åŸåœº"
    set ib_unitArmor[804] = "fort"
    set ib_unitNameGbk[804] = "·Ø³¡"
    set ib_unitList[805] = 'uktg'
    set ib_unitName[805] = "å…‹å°”è‹åŠ å¾·"
    set ib_unitArmor[805] = "large"
    set ib_unitNameGbk[805] = "¿Ë¶ûËÕ¼ÓµÂ"
    set ib_unitList[806] = 'uktn'
    set ib_unitName[806] = "å…‹å°”è‹åŠ å¾·"
    set ib_unitArmor[806] = "large"
    set ib_unitNameGbk[806] = "¿Ë¶ûËÕ¼ÓµÂ"
    set ib_unitList[807] = 'uloc'
    set ib_unitName[807] = "è—è™«"
    set ib_unitArmor[807] = "small"
    set ib_unitNameGbk[807] = "»È³æ"
    set ib_unitList[808] = 'umtw'
    set ib_unitName[808] = "ç»è‚‰è½¦"
    set ib_unitArmor[808] = "large"
    set ib_unitNameGbk[808] = "½ÊÈâ³µ"
    set ib_unitList[809] = 'unec'
    set ib_unitName[809] = "ä¸æ­»æ—å·«å¸ˆ"
    set ib_unitArmor[809] = "none"
    set ib_unitNameGbk[809] = "²»ËÀ×åÎ×Ê¦"
    set ib_unitList[810] = 'unp1'
    set ib_unitName[810] = "äº¡è€…å¤§å…"
    set ib_unitArmor[810] = "fort"
    set ib_unitNameGbk[810] = "ÍöÕß´óÌü"
    set ib_unitList[811] = 'unp2'
    set ib_unitName[811] = "é»‘è‰²åŸå ¡"
    set ib_unitArmor[811] = "fort"
    set ib_unitNameGbk[811] = "ºÚÉ«³Ç±¤"
    set ib_unitList[812] = 'unpl'
    set ib_unitName[812] = "å¤§å¢“åœ°"
    set ib_unitArmor[812] = "fort"
    set ib_unitNameGbk[812] = "´óÄ¹µØ"
    set ib_unitList[813] = 'uobs'
    set ib_unitName[813] = "åèƒœçŸ³é›•åƒ"
    set ib_unitArmor[813] = "large"
    set ib_unitNameGbk[813] = "Ê®Ê¤Ê¯µñÏñ"
    set ib_unitList[814] = 'uplg'
    set ib_unitName[814] = "ç–¾ç—…äº‘é›¾"
    set ib_unitArmor[814] = "medium"
    set ib_unitNameGbk[814] = "¼²²¡ÔÆÎí"
    set ib_unitList[815] = 'usap'
    set ib_unitName[815] = "ç‰ºç‰²æ·±æ¸Š"
    set ib_unitArmor[815] = "fort"
    set ib_unitNameGbk[815] = "ÎşÉüÉîÔ¨"
    set ib_unitList[816] = 'usep'
    set ib_unitName[816] = "åœ°ç©´"
    set ib_unitArmor[816] = "fort"
    set ib_unitNameGbk[816] = "µØÑ¨"
    set ib_unitList[817] = 'ushd'
    set ib_unitName[817] = "é˜´å½±"
    set ib_unitArmor[817] = "medium"
    set ib_unitNameGbk[817] = "ÒõÓ°"
    set ib_unitList[818] = 'ushp'
    set ib_unitName[818] = "ä¸æ­»æ—èˆ¹å"
    set ib_unitArmor[818] = "fort"
    set ib_unitNameGbk[818] = "²»ËÀ×å´¬Îë"
    set ib_unitList[819] = 'uske'
    set ib_unitName[819] = "éª·é«…æˆ˜å£«"
    set ib_unitArmor[819] = "large"
    set ib_unitNameGbk[819] = "÷¼÷ÃÕ½Ê¿"
    set ib_unitList[820] = 'uskm'
    set ib_unitName[820] = "éª·é«…é­”æ³•å¸ˆ"
    set ib_unitArmor[820] = "medium"
    set ib_unitNameGbk[820] = "÷¼÷ÃÄ§·¨Ê¦"
    set ib_unitList[821] = 'uslh'
    set ib_unitName[821] = "å± å®°åœº"
    set ib_unitArmor[821] = "fort"
    set ib_unitNameGbk[821] = "ÍÀÔ×³¡"
    set ib_unitList[822] = 'uswb'
    set ib_unitName[822] = "è¿½é£ä¹‹è¥¿å°”ç“¦å¨œæ–¯"
    set ib_unitArmor[822] = "medium"
    set ib_unitNameGbk[822] = "×··çÖ®Î÷¶ûÍßÄÈË¹"
    set ib_unitList[823] = 'utod'
    set ib_unitName[823] = "è¯…å’’ç¥åº™"
    set ib_unitArmor[823] = "fort"
    set ib_unitNameGbk[823] = "×çÖäÉñÃí"
    set ib_unitList[824] = 'utom'
    set ib_unitName[824] = "å¤å¢“åºŸå¢Ÿ"
    set ib_unitArmor[824] = "fort"
    set ib_unitNameGbk[824] = "¹ÅÄ¹·ÏĞæ"
    set ib_unitList[825] = 'uubs'
    set ib_unitName[825] = "ä¸æ­»æ—æˆ˜èˆ°"
    set ib_unitArmor[825] = "large"
    set ib_unitNameGbk[825] = "²»ËÀ×åÕ½½¢"
    set ib_unitList[826] = 'uzg1'
    set ib_unitName[826] = "å¹½é­‚ä¹‹å¡”"
    set ib_unitArmor[826] = "fort"
    set ib_unitNameGbk[826] = "ÓÄ»êÖ®Ëş"
    set ib_unitList[827] = 'uzg2'
    set ib_unitName[827] = "è››ç½‘æ€ªå¡”"
    set ib_unitArmor[827] = "fort"
    set ib_unitNameGbk[827] = "ÖëÍø¹ÖËş"
    set ib_unitList[828] = 'uzig'
    set ib_unitName[828] = "é€šçµå¡”"
    set ib_unitArmor[828] = "fort"
    set ib_unitNameGbk[828] = "Í¨ÁéËş"
    set ib_unitList[829] = 'zcso'
    set ib_unitName[829] = "ç©ºé—´é‚ªæ¶å…½æ—"
    set ib_unitArmor[829] = "medium"
    set ib_unitNameGbk[829] = "¿Õ¼äĞ°¶ñÊŞ×å"
    set ib_unitList[830] = 'zhyd'
    set ib_unitName[830] = "åˆºè›‡"
    set ib_unitArmor[830] = "medium"
    set ib_unitNameGbk[830] = "´ÌÉß"
    set ib_unitList[831] = 'zjug'
    set ib_unitName[831] = "å…½æ—é­”åŠ›æˆ˜èˆ°"
    set ib_unitArmor[831] = "small"
    set ib_unitNameGbk[831] = "ÊŞ×åÄ§Á¦Õ½½¢"
    set ib_unitList[832] = 'zmar'
    set ib_unitName[832] = "é©¬é‡Œæ©"
    set ib_unitArmor[832] = "medium"
    set ib_unitNameGbk[832] = "ÂíÀï¶÷"
    set ib_unitList[833] = 'zshv'
    set ib_unitName[833] = "å°é¬¼æŒ–æ˜è€…"
    set ib_unitArmor[833] = "medium"
    set ib_unitNameGbk[833] = "Ğ¡¹íÍÚ¾òÕß"
    set ib_unitList[834] = 'zsmc'
    set ib_unitName[834] = "å¤§å…µ"
    set ib_unitArmor[834] = "medium"
    set ib_unitNameGbk[834] = "´ó±ø"
    set ib_unitList[835] = 'zzrg'
    set ib_unitName[835] = "å°ç‹—"
    set ib_unitArmor[835] = "medium"
    set ib_unitNameGbk[835] = "Ğ¡¹·"
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
        set ib_itemCount = 402
        call PauseTimer(ib_fillTimer)
        call DestroyTimer(ib_fillTimer)
        set ib_fillTimer = null
    endif
endfunction

function IB_SkillFillStep takes nothing returns nothing
    if ib_skFillIdx == 0 then
        call IB_SkillFill0()
    elseif ib_skFillIdx == 1 then
        call IB_SkillFill1()
    elseif ib_skFillIdx == 2 then
        call IB_SkillFill2()
    elseif ib_skFillIdx == 3 then
        call IB_SkillFill3()
    elseif ib_skFillIdx == 4 then
        call IB_SkillFill4()
    elseif ib_skFillIdx == 5 then
        call IB_SkillFill5()
    elseif ib_skFillIdx == 6 then
        call IB_SkillFill6()
    elseif ib_skFillIdx == 7 then
        call IB_SkillFill7()
    elseif ib_skFillIdx == 8 then
        call IB_SkillFill8()
    elseif ib_skFillIdx == 9 then
        call IB_SkillFill9()
    elseif ib_skFillIdx == 10 then
        call IB_SkillFill10()
    endif
    set ib_skFillIdx = ib_skFillIdx + 1
    if ib_skFillIdx >= ib_skFillTotal then
        set ib_skillCount = 829
        call PauseTimer(ib_skFillTimer)
        call DestroyTimer(ib_skFillTimer)
        set ib_skFillTimer = null
    endif
endfunction

function IB_UnitFillStep takes nothing returns nothing
    if ib_unFillIdx == 0 then
        call IB_UnitFill0()
    elseif ib_unFillIdx == 1 then
        call IB_UnitFill1()
    elseif ib_unFillIdx == 2 then
        call IB_UnitFill2()
    elseif ib_unFillIdx == 3 then
        call IB_UnitFill3()
    elseif ib_unFillIdx == 4 then
        call IB_UnitFill4()
    elseif ib_unFillIdx == 5 then
        call IB_UnitFill5()
    elseif ib_unFillIdx == 6 then
        call IB_UnitFill6()
    elseif ib_unFillIdx == 7 then
        call IB_UnitFill7()
    elseif ib_unFillIdx == 8 then
        call IB_UnitFill8()
    elseif ib_unFillIdx == 9 then
        call IB_UnitFill9()
    elseif ib_unFillIdx == 10 then
        call IB_UnitFill10()
    endif
    set ib_unFillIdx = ib_unFillIdx + 1
    if ib_unFillIdx >= ib_unFillTotal then
        set ib_unitCount = 836
        call PauseTimer(ib_unFillTimer)
        call DestroyTimer(ib_unFillTimer)
        set ib_unFillTimer = null
    endif
endfunction

function IB_Init takes nothing returns nothing
    set ib_itemCount = 0
    set ib_skillCount = 0
    set ib_unitCount = 0
    call IB_RegisterChat()
    set ib_fillIdx = 0
    set ib_fillTotal = 6
    set ib_fillTimer = CreateTimer()
    call TimerStart(ib_fillTimer, 0.01, true, function IB_FillStep)
    set ib_skFillIdx = 0
    set ib_skFillTotal = 11
    set ib_skFillTimer = CreateTimer()
    call TimerStart(ib_skFillTimer, 0.01, true, function IB_SkillFillStep)
    set ib_unFillIdx = 0
    set ib_unFillTotal = 11
    set ib_unFillTimer = CreateTimer()
    call TimerStart(ib_unFillTimer, 0.01, true, function IB_UnitFillStep)
    call IB_CritInit()
    call IB_FingerCastInit()
endfunction

//---------------------------------------------------------------------------
// åˆ†å¸§å¡«å……:æ¯å¸§è°ƒç”¨ä¸€ä¸ª IB_FillN,å…¨éƒ¨å®Œæˆåè®¾ç½® ib_itemCount
//---------------------------------------------------------------------------
