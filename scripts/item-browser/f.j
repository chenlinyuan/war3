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
    local integer created = 0
    if u == null then
        call IB_Message(p, "è¯·å…ˆé€‰ä¸­ä¸€ä¸ªè‹±é›„/å•ä½")
        return
    endif
    set x = GetUnitX(u)
    set y = GetUnitY(u)
    loop
        exitwhen created >= count
        set it = CreateItem(itemId, x, y)
        if it != null then
            if not UnitAddItem(u, it) then
                call SetItemPosition(it, x, y)
            endif
            set added = added + 1
        endif
        set created = created + 1
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
    elseif abilId == 'YDm9' or abilId == 'YDma' or abilId == 'YDmb' or abilId == 'YDmc' or abilId == 'YDmd' or abilId == 'YDme' or abilId == 'YDmf' or abilId == 'Aclq' then
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
    call TimerStart(ib_regTimer, 0.02, false, function IB_RegisterChat8)
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
    set ib_itemList[3] = 'ratf'
    set ib_itemName[3] = "æ”»å‡»ä¹‹çˆª +15"
    set ib_itemCustom[3] = 0
    set ib_itemNameGbk[3] = "¹¥»÷Ö®×¦ +15"
    set ib_itemList[4] = 'rde4'
    set ib_itemName[4] = "å®ˆæŠ¤æŒ‡ç¯ +5"
    set ib_itemCustom[4] = 0
    set ib_itemNameGbk[4] = "ÊØ»¤Ö¸»· +5"
    set ib_itemList[5] = 'ofro'
    set ib_itemName[5] = "éœœå†»ä¹‹çƒ"
    set ib_itemCustom[5] = 0
    set ib_itemNameGbk[5] = "Ëª¶³Ö®Çò"
    set ib_itemList[6] = 'desc'
    set ib_itemName[6] = "ç§‘å‹’æ©çš„é€ƒè„±åŒ•é¦–"
    set ib_itemCustom[6] = 0
    set ib_itemNameGbk[6] = "¿ÆÀÕ¶÷µÄÌÓÍÑØ°Ê×"
    set ib_itemList[7] = 'fgdg'
    set ib_itemName[7] = "æ¶é­”é›•åƒ"
    set ib_itemCustom[7] = 0
    set ib_itemNameGbk[7] = "¶ñÄ§µñÏñ"
    set ib_itemList[8] = 'infs'
    set ib_itemName[8] = "æ¶é­”å²©çŸ³"
    set ib_itemCustom[8] = 0
    set ib_itemNameGbk[8] = "¶ñÄ§ÑÒÊ¯"
    set ib_itemList[9] = 'shar'
    set ib_itemName[9] = "å†°å†»ç¢ç‰‡"
    set ib_itemCustom[9] = 0
    set ib_itemNameGbk[9] = "±ù¶³ËéÆ¬"
    set ib_itemList[10] = 'sand'
    set ib_itemName[10] = "æ“ä½œæ­»å°¸å·è½´"
    set ib_itemCustom[10] = 0
    set ib_itemNameGbk[10] = "²Ù×÷ËÀÊ¬¾íÖá"
    set ib_itemList[11] = 'wild'
    set ib_itemName[11] = "é‡æ€§æŠ¤èº«ç¬¦"
    set ib_itemCustom[11] = 0
    set ib_itemNameGbk[11] = "Ò°ĞÔ»¤Éí·û"
    set ib_itemList[12] = 'srrc'
    set ib_itemName[12] = "å¤æ´»å·è½´"
    set ib_itemCustom[12] = 0
    set ib_itemNameGbk[12] = "¸´»î¾íÖá"
    set ib_itemList[13] = 'odef'
    set ib_itemName[13] = "é»‘æš—ä¹‹çƒ"
    set ib_itemCustom[13] = 0
    set ib_itemNameGbk[13] = "ºÚ°µÖ®Çò"
    set ib_itemList[14] = 'rde3'
    set ib_itemName[14] = "å®ˆæŠ¤æŒ‡ç¯ +4"
    set ib_itemCustom[14] = 0
    set ib_itemNameGbk[14] = "ÊØ»¤Ö¸»· +4"
    set ib_itemList[15] = 'pmna'
    set ib_itemName[15] = "é­”æ³•å‚é¥°"
    set ib_itemCustom[15] = 0
    set ib_itemNameGbk[15] = "Ä§·¨´¹ÊÎ"
    set ib_itemList[16] = 'rhth'
    set ib_itemName[16] = "å¡å˜‰åŒ»ç–—å®çŸ³"
    set ib_itemCustom[16] = 0
    set ib_itemNameGbk[16] = "¿¨¼ÎÒ½ÁÆ±¦Ê¯"
    set ib_itemList[17] = 'ssil'
    set ib_itemName[17] = "æ²‰é»˜æƒæ–"
    set ib_itemCustom[17] = 0
    set ib_itemNameGbk[17] = "³ÁÄ¬È¨ÕÈ"
    set ib_itemList[18] = 'spsh'
    set ib_itemName[18] = "é­”æ³•æŠ¤ç›¾æŠ¤èº«ç¬¦"
    set ib_itemCustom[18] = 0
    set ib_itemNameGbk[18] = "Ä§·¨»¤¶Ü»¤Éí·û"
    set ib_itemList[19] = 'sres'
    set ib_itemName[19] = "æ¢å¤å·è½´"
    set ib_itemCustom[19] = 0
    set ib_itemNameGbk[19] = "»Ö¸´¾íÖá"
    set ib_itemList[20] = 'pdiv'
    set ib_itemName[20] = "ç¥åœ£è¯æ°´"
    set ib_itemCustom[20] = 0
    set ib_itemNameGbk[20] = "ÉñÊ¥Ò©Ë®"
    set ib_itemList[21] = 'pres'
    set ib_itemName[21] = "æ¢å¤è¯æ°´"
    set ib_itemCustom[21] = 0
    set ib_itemNameGbk[21] = "»Ö¸´Ò©Ë®"
    set ib_itemList[22] = 'totw'
    set ib_itemName[22] = "é‡æ€§æŠ¤ç¬¦"
    set ib_itemCustom[22] = 0
    set ib_itemNameGbk[22] = "Ò°ĞÔ»¤·û"
    set ib_itemList[23] = 'fgfh'
    set ib_itemName[23] = "é•¿é’‰è¡£é¢†"
    set ib_itemCustom[23] = 0
    set ib_itemNameGbk[23] = "³¤¶¤ÒÂÁì"
    set ib_itemList[24] = 'fgrd'
    set ib_itemName[24] = "çº¢é¾™ä¹‹åµ"
    set ib_itemCustom[24] = 0
    set ib_itemNameGbk[24] = "ºìÁúÖ®ÂÑ"
    set ib_itemList[25] = 'fgrg'
    set ib_itemName[25] = "å²©çŸ³å°è®°"
    set ib_itemCustom[25] = 0
    set ib_itemNameGbk[25] = "ÑÒÊ¯Ó¡¼Ç"
    set ib_itemList[26] = 'hcun'
    set ib_itemName[26] = "çµå·§å¤´å·¾"
    set ib_itemCustom[26] = 0
    set ib_itemNameGbk[26] = "ÁéÇÉÍ·½í"
    set ib_itemList[27] = 'hval'
    set ib_itemName[27] = "è‹±å‹‡é¢å…·"
    set ib_itemCustom[27] = 0
    set ib_itemNameGbk[27] = "Ó¢ÓÂÃæ¾ß"
    set ib_itemList[28] = 'mcou'
    set ib_itemName[28] = "å‹‡æ°”å‹‹ç« "
    set ib_itemCustom[28] = 0
    set ib_itemNameGbk[28] = "ÓÂÆøÑ«ÕÂ"
    set ib_itemList[29] = 'ajen'
    set ib_itemName[29] = "å¤ä¹‹å¿è€å§œæ­Œ"
    set ib_itemCustom[29] = 0
    set ib_itemNameGbk[29] = "¹ÅÖ®ÈÌÄÍ½ª¸è"
    set ib_itemList[30] = 'clfm'
    set ib_itemName[30] = "ç«ç„°é£è¡£"
    set ib_itemCustom[30] = 0
    set ib_itemNameGbk[30] = "»ğÑæ·çÒÂ"
    set ib_itemList[31] = 'ratc'
    set ib_itemName[31] = "æ”»å‡»ä¹‹çˆª +12"
    set ib_itemCustom[31] = 0
    set ib_itemNameGbk[31] = "¹¥»÷Ö®×¦ +12"
    set ib_itemList[32] = 'ward'
    set ib_itemName[32] = "æˆ˜æ­Œä¹‹é¼“"
    set ib_itemCustom[32] = 0
    set ib_itemNameGbk[32] = "Õ½¸èÖ®¹Ä"
    set ib_itemList[33] = 'kpin'
    set ib_itemName[33] = "å¡å˜‰é•¿è§"
    set ib_itemCustom[33] = 0
    set ib_itemNameGbk[33] = "¿¨¼Î³¤Ïô"
    set ib_itemList[34] = 'crys'
    set ib_itemName[34] = "æ°´æ™¶çƒ"
    set ib_itemCustom[34] = 0
    set ib_itemNameGbk[34] = "Ë®¾§Çò"
    set ib_itemList[35] = 'lgdh'
    set ib_itemName[35] = "æ¯ç­ä¹‹è§’"
    set ib_itemCustom[35] = 0
    set ib_itemNameGbk[35] = "»ÙÃğÖ®½Ç"
    set ib_itemList[36] = 'ankh'
    set ib_itemName[36] = "é‡ç”Ÿåå­—ç« "
    set ib_itemCustom[36] = 0
    set ib_itemNameGbk[36] = "ÖØÉúÊ®×ÖÕÂ"
    set ib_itemList[37] = 'whwd'
    set ib_itemName[37] = "æ²»ç–—å®ˆå«"
    set ib_itemCustom[37] = 0
    set ib_itemNameGbk[37] = "ÖÎÁÆÊØÎÀ"
    set ib_itemList[38] = 'fgsk'
    set ib_itemName[38] = "æ­»äº¡ä¹‹ä¹¦"
    set ib_itemCustom[38] = 0
    set ib_itemNameGbk[38] = "ËÀÍöÖ®Êé"
    set ib_itemList[39] = 'wcyc'
    set ib_itemName[39] = "é£“é£æƒæ–"
    set ib_itemCustom[39] = 0
    set ib_itemNameGbk[39] = "ì«·çÈ¨ÕÈ"
    set ib_itemList[40] = 'hlst'
    set ib_itemName[40] = "åŒ»ç–—çŸ³"
    set ib_itemCustom[40] = 0
    set ib_itemNameGbk[40] = "Ò½ÁÆÊ¯"
    set ib_itemList[41] = 'mnst'
    set ib_itemName[41] = "é­”æ³•çŸ³"
    set ib_itemCustom[41] = 0
    set ib_itemNameGbk[41] = "Ä§·¨Ê¯"
    set ib_itemList[42] = 'belv'
    set ib_itemName[42] = "å¥å°”è¨æ‹‰æ–¯ä¹‹é´ +6"
    set ib_itemCustom[42] = 0
    set ib_itemNameGbk[42] = "¿ü¶ûÈøÀ­Ë¹Ö®Ñ¥ +6"
    set ib_itemList[43] = 'bgst'
    set ib_itemName[43] = "å·¨äººåŠ›é‡è…°å¸¦+6"
    set ib_itemCustom[43] = 0
    set ib_itemNameGbk[43] = "¾ŞÈËÁ¦Á¿Ñü´ø+6"
    set ib_itemList[44] = 'ciri'
    set ib_itemName[44] = "æ³•å¸ˆé•¿è¢ +6"
    set ib_itemCustom[44] = 0
    set ib_itemNameGbk[44] = "·¨Ê¦³¤ÅÛ +6"
    set ib_itemList[45] = 'lhst'
    set ib_itemName[45] = "é£æš´ç‹®è§’"
    set ib_itemCustom[45] = 0
    set ib_itemNameGbk[45] = "·ç±©Ê¨½Ç"
    set ib_itemList[46] = 'afac'
    set ib_itemName[46] = "é˜¿åˆ©äºšä¹‹ç¬›"
    set ib_itemCustom[46] = 0
    set ib_itemNameGbk[46] = "°¢ÀûÑÇÖ®µÑ"
    set ib_itemList[47] = 'sbch'
    set ib_itemName[47] = "å¤©ç¾éª¨é’Ÿ"
    set ib_itemCustom[47] = 0
    set ib_itemNameGbk[47] = "ÌìÔÖ¹ÇÖÓ"
    set ib_itemList[48] = 'brac'
    set ib_itemName[48] = "ç¥ç§˜è…°å¸¦"
    set ib_itemCustom[48] = 0
    set ib_itemNameGbk[48] = "ÉñÃØÑü´ø"
    set ib_itemList[49] = 'rwiz'
    set ib_itemName[49] = "è‰ºäººé¢ç½©"
    set ib_itemCustom[49] = 0
    set ib_itemNameGbk[49] = "ÒÕÈËÃæÕÖ"
    set ib_itemList[50] = 'pghe'
    set ib_itemName[50] = "å¤§ç”Ÿå‘½è¯æ°´"
    set ib_itemCustom[50] = 0
    set ib_itemNameGbk[50] = "´óÉúÃüÒ©Ë®"
    set ib_itemList[51] = 'pgma'
    set ib_itemName[51] = "å¤§é­”æ³•è¯æ°´"
    set ib_itemCustom[51] = 0
    set ib_itemNameGbk[51] = "´óÄ§·¨Ò©Ë®"
    set ib_itemList[52] = 'pnvu'
    set ib_itemName[52] = "æ— æ•Œè¯æ°´"
    set ib_itemCustom[52] = 0
    set ib_itemNameGbk[52] = "ÎŞµĞÒ©Ë®"
    set ib_itemList[53] = 'sror'
    set ib_itemName[53] = "é‡å…½å·è½´"
    set ib_itemCustom[53] = 0
    set ib_itemNameGbk[53] = "Ò°ÊŞ¾íÖá"
    set ib_itemList[54] = 'woms'
    set ib_itemName[54] = "é­”æ³•ç›—å–æƒæ–"
    set ib_itemCustom[54] = 0
    set ib_itemNameGbk[54] = "Ä§·¨µÁÈ¡È¨ÕÈ"
    set ib_itemList[55] = 'evtl'
    set ib_itemName[55] = "é—ªé¿æŠ¤ç¬¦"
    set ib_itemCustom[55] = 0
    set ib_itemNameGbk[55] = "ÉÁ±Ü»¤·û"
    set ib_itemList[56] = 'penr'
    set ib_itemName[56] = "èƒ½é‡å‚é¥°"
    set ib_itemCustom[56] = 0
    set ib_itemNameGbk[56] = "ÄÜÁ¿´¹ÊÎ"
    set ib_itemList[57] = 'prvt'
    set ib_itemName[57] = "ç”Ÿå‘½æŠ¤èº«ç¬¦"
    set ib_itemCustom[57] = 0
    set ib_itemNameGbk[57] = "ÉúÃü»¤Éí·û"
    set ib_itemList[58] = 'rat9'
    set ib_itemName[58] = "æ”»å‡»ä¹‹çˆª +9"
    set ib_itemCustom[58] = 0
    set ib_itemNameGbk[58] = "¹¥»÷Ö®×¦ +9"
    set ib_itemList[59] = 'rde2'
    set ib_itemName[59] = "å®ˆæŠ¤æŒ‡ç¯ +3"
    set ib_itemCustom[59] = 0
    set ib_itemNameGbk[59] = "ÊØ»¤Ö¸»· +3"
    set ib_itemList[60] = 'rlif'
    set ib_itemName[60] = "æ¢å¤æŒ‡ç¯"
    set ib_itemCustom[60] = 0
    set ib_itemNameGbk[60] = "»Ö¸´Ö¸»·"
    set ib_itemList[61] = 'bspd'
    set ib_itemName[61] = "é€Ÿåº¦ä¹‹é´"
    set ib_itemCustom[61] = 0
    set ib_itemNameGbk[61] = "ËÙ¶ÈÖ®Ñ¥"
    set ib_itemList[62] = 'rej3'
    set ib_itemName[62] = "æ¢å¤è¯æ°´"
    set ib_itemCustom[62] = 0
    set ib_itemNameGbk[62] = "»Ö¸´Ò©Ë®"
    set ib_itemList[63] = 'will'
    set ib_itemName[63] = "å¹»è±¡æƒæ–"
    set ib_itemCustom[63] = 0
    set ib_itemNameGbk[63] = "»ÃÏóÈ¨ÕÈ"
    set ib_itemList[64] = 'wlsd'
    set ib_itemName[64] = "é—ªç”µæŠ¤ç›¾æƒæ–"
    set ib_itemCustom[64] = 0
    set ib_itemNameGbk[64] = "ÉÁµç»¤¶ÜÈ¨ÕÈ"
    set ib_itemList[65] = 'wswd'
    set ib_itemName[65] = "å²—å“¨å®ˆå«"
    set ib_itemCustom[65] = 0
    set ib_itemNameGbk[65] = "¸ÚÉÚÊØÎÀ"
    set ib_itemList[66] = 'cnob'
    set ib_itemName[66] = "è´µæ—åœ†ç¯"
    set ib_itemCustom[66] = 0
    set ib_itemNameGbk[66] = "¹ó×åÔ²»·"
    set ib_itemList[67] = 'gcel'
    set ib_itemName[67] = "åŠ é€Ÿæ‰‹å¥—"
    set ib_itemCustom[67] = 0
    set ib_itemNameGbk[67] = "¼ÓËÙÊÖÌ×"
    set ib_itemList[68] = 'rat6'
    set ib_itemName[68] = "æ”»å‡»ä¹‹çˆª +6"
    set ib_itemCustom[68] = 0
    set ib_itemNameGbk[68] = "¹¥»÷Ö®×¦ +6"
    set ib_itemList[69] = 'rde1'
    set ib_itemName[69] = "å®ˆæŠ¤æŒ‡ç¯ +2"
    set ib_itemCustom[69] = 0
    set ib_itemNameGbk[69] = "ÊØ»¤Ö¸»· +2"
    set ib_itemList[70] = 'tdx2'
    set ib_itemName[70] = "æ•æ·ä¹‹ä¹¦ +2"
    set ib_itemCustom[70] = 0
    set ib_itemNameGbk[70] = "Ãô½İÖ®Êé +2"
    set ib_itemList[71] = 'texp'
    set ib_itemName[71] = "ç»éªŒä¹‹ä¹¦"
    set ib_itemCustom[71] = 0
    set ib_itemNameGbk[71] = "¾­ÑéÖ®Êé"
    set ib_itemList[72] = 'tin2'
    set ib_itemName[72] = "æ™ºåŠ›ä¹‹ä¹¦ +2"
    set ib_itemCustom[72] = 0
    set ib_itemNameGbk[72] = "ÖÇÁ¦Ö®Êé +2"
    set ib_itemList[73] = 'tpow'
    set ib_itemName[73] = "çŸ¥è¯†ä¹‹ä¹¦"
    set ib_itemCustom[73] = 0
    set ib_itemNameGbk[73] = "ÖªÊ¶Ö®Êé"
    set ib_itemList[74] = 'tst2'
    set ib_itemName[74] = "åŠ›é‡ä¹‹ä¹¦ +2"
    set ib_itemCustom[74] = 0
    set ib_itemNameGbk[74] = "Á¦Á¿Ö®Êé +2"
    set ib_itemList[75] = 'pnvl'
    set ib_itemName[75] = "è¾ƒå°çš„æ— æ•Œè¯æ°´"
    set ib_itemCustom[75] = 0
    set ib_itemNameGbk[75] = "½ÏĞ¡µÄÎŞµĞÒ©Ë®"
    set ib_itemList[76] = 'clsd'
    set ib_itemName[76] = "å½±å­é£è¡£"
    set ib_itemCustom[76] = 0
    set ib_itemNameGbk[76] = "Ó°×Ó·çÒÂ"
    set ib_itemList[77] = 'rag1'
    set ib_itemName[77] = "æ•æ·ä¾¿é‹  +3"
    set ib_itemCustom[77] = 0
    set ib_itemNameGbk[77] = "Ãô½İ±ãĞ¬  +3"
    set ib_itemList[78] = 'rin1'
    set ib_itemName[78] = "æ™ºåŠ›æ–—ç¯· +3"
    set ib_itemCustom[78] = 0
    set ib_itemNameGbk[78] = "ÖÇÁ¦¶·Åñ +3"
    set ib_itemList[79] = 'rst1'
    set ib_itemName[79] = "é£Ÿäººé¬¼æ‰‹å¥— +3"
    set ib_itemCustom[79] = 0
    set ib_itemNameGbk[79] = "Ê³ÈË¹íÊÖÌ× +3"
endfunction
function IB_Fill1 takes nothing returns nothing
    set ib_itemList[80] = 'manh'
    set ib_itemName[80] = "ç”Ÿå‘½æ‰‹å†Œ"
    set ib_itemCustom[80] = 0
    set ib_itemNameGbk[80] = "ÉúÃüÊÖ²á"
    set ib_itemList[81] = 'tdex'
    set ib_itemName[81] = "æ•æ·ä¹‹ä¹¦"
    set ib_itemCustom[81] = 0
    set ib_itemNameGbk[81] = "Ãô½İÖ®Êé"
    set ib_itemList[82] = 'tint'
    set ib_itemName[82] = "æ™ºåŠ›ä¹‹ä¹¦"
    set ib_itemCustom[82] = 0
    set ib_itemNameGbk[82] = "ÖÇÁ¦Ö®Êé"
    set ib_itemList[83] = 'tstr'
    set ib_itemName[83] = "åŠ›é‡ä¹‹ä¹¦"
    set ib_itemCustom[83] = 0
    set ib_itemNameGbk[83] = "Á¦Á¿Ö®Êé"
    set ib_itemList[84] = 'pomn'
    set ib_itemName[84] = "å…¨çŸ¥è¯æ°´"
    set ib_itemCustom[84] = 0
    set ib_itemNameGbk[84] = "È«ÖªÒ©Ë®"
    set ib_itemList[85] = 'wshs'
    set ib_itemName[85] = "å½±å­æƒæ–"
    set ib_itemCustom[85] = 0
    set ib_itemNameGbk[85] = "Ó°×ÓÈ¨ÕÈ"
    set ib_itemList[86] = 'rej6'
    set ib_itemName[86] = "å¤§å‹æ¢å¤å·è½´"
    set ib_itemCustom[86] = 0
    set ib_itemNameGbk[86] = "´óĞÍ»Ö¸´¾íÖá"
    set ib_itemList[87] = 'rej5'
    set ib_itemName[87] = "å°å‹æ¢å¤å·è½´"
    set ib_itemCustom[87] = 0
    set ib_itemNameGbk[87] = "Ğ¡ĞÍ»Ö¸´¾íÖá"
    set ib_itemList[88] = 'rej4'
    set ib_itemName[88] = "å¤§å‹æ¢å¤è¯æ°´"
    set ib_itemCustom[88] = 0
    set ib_itemNameGbk[88] = "´óĞÍ»Ö¸´Ò©Ë®"
    set ib_itemList[89] = 'ram4'
    set ib_itemName[89] = "å¤§é­”æ³•å¸ˆæŒ‡ç¯"
    set ib_itemCustom[89] = 0
    set ib_itemNameGbk[89] = "´óÄ§·¨Ê¦Ö¸»·"
    set ib_itemList[90] = 'dsum'
    set ib_itemName[90] = "å¬å”¤é’»çŸ³"
    set ib_itemCustom[90] = 0
    set ib_itemNameGbk[90] = "ÕÙ»½×êÊ¯"
    set ib_itemList[91] = 'ofir'
    set ib_itemName[91] = "ç«ç„°ä¹‹çƒ"
    set ib_itemCustom[91] = 0
    set ib_itemNameGbk[91] = "»ğÑæÖ®Çò"
    set ib_itemList[92] = 'ocor'
    set ib_itemName[92] = "è…èš€ä¹‹çƒ"
    set ib_itemCustom[92] = 0
    set ib_itemNameGbk[92] = "¸¯Ê´Ö®Çò"
    set ib_itemList[93] = 'oli2'
    set ib_itemName[93] = "é—ªç”µä¹‹çƒ"
    set ib_itemCustom[93] = 0
    set ib_itemNameGbk[93] = "ÉÁµçÖ®Çò"
    set ib_itemList[94] = 'oven'
    set ib_itemName[94] = "æ¯’æ¶²ä¹‹çƒ"
    set ib_itemCustom[94] = 0
    set ib_itemNameGbk[94] = "¶¾ÒºÖ®Çò"
    set ib_itemList[95] = 'ram3'
    set ib_itemName[95] = "å¤§é­”æ³•å¸ˆæŒ‡ç¯"
    set ib_itemCustom[95] = 0
    set ib_itemNameGbk[95] = "´óÄ§·¨Ê¦Ö¸»·"
    set ib_itemList[96] = 'tret'
    set ib_itemName[96] = "å†è®­ç»ƒä¹‹ä¹¦"
    set ib_itemCustom[96] = 0
    set ib_itemNameGbk[96] = "ÔÙÑµÁ·Ö®Êé"
    set ib_itemList[97] = 'tgrh'
    set ib_itemName[97] = "å°å‹çš„å¤§å…"
    set ib_itemCustom[97] = 0
    set ib_itemNameGbk[97] = "Ğ¡ĞÍµÄ´óÌü"
    set ib_itemList[98] = 'rej2'
    set ib_itemName[98] = "å°å‹æ¢å¤è¯æ°´"
    set ib_itemCustom[98] = 0
    set ib_itemNameGbk[98] = "Ğ¡ĞÍ»Ö¸´Ò©Ë®"
    set ib_itemList[99] = 'gemt'
    set ib_itemName[99] = "æ˜¾å½¢å®çŸ³"
    set ib_itemCustom[99] = 0
    set ib_itemNameGbk[99] = "ÏÔĞÎ±¦Ê¯"
    set ib_itemList[100] = 'ram2'
    set ib_itemName[100] = "å¤§é­”æ³•å¸ˆæŒ‡ç¯"
    set ib_itemCustom[100] = 0
    set ib_itemNameGbk[100] = "´óÄ§·¨Ê¦Ö¸»·"
    set ib_itemList[101] = 'stel'
    set ib_itemName[101] = "ä¼ é€æƒæ–"
    set ib_itemCustom[101] = 0
    set ib_itemNameGbk[101] = "´«ËÍÈ¨ÕÈ"
    set ib_itemList[102] = 'stwp'
    set ib_itemName[102] = "å›åŸå·è½´"
    set ib_itemCustom[102] = 0
    set ib_itemNameGbk[102] = "»Ø³Ç¾íÖá"
    set ib_itemList[103] = 'wneg'
    set ib_itemName[103] = "å¦å†³æƒæ–"
    set ib_itemCustom[103] = 0
    set ib_itemNameGbk[103] = "·ñ¾öÈ¨ÕÈ"
    set ib_itemList[104] = 'sneg'
    set ib_itemName[104] = "å¦å†³æƒæ–"
    set ib_itemCustom[104] = 0
    set ib_itemNameGbk[104] = "·ñ¾öÈ¨ÕÈ"
    set ib_itemList[105] = 'wneu'
    set ib_itemName[105] = "ä¸­å’Œæƒæ–"
    set ib_itemCustom[105] = 0
    set ib_itemNameGbk[105] = "ÖĞºÍÈ¨ÕÈ"
    set ib_itemList[106] = 'shea'
    set ib_itemName[106] = "åŒ»ç–—å·è½´"
    set ib_itemCustom[106] = 0
    set ib_itemNameGbk[106] = "Ò½ÁÆ¾íÖá"
    set ib_itemList[107] = 'sman'
    set ib_itemName[107] = "é­”æ³•å·è½´"
    set ib_itemCustom[107] = 0
    set ib_itemNameGbk[107] = "Ä§·¨¾íÖá"
    set ib_itemList[108] = 'rej1'
    set ib_itemName[108] = "å°å‹æ¢å¤è¯æ°´"
    set ib_itemCustom[108] = 0
    set ib_itemNameGbk[108] = "Ğ¡ĞÍ»Ö¸´Ò©Ë®"
    set ib_itemList[109] = 'pspd'
    set ib_itemName[109] = "é€Ÿåº¦è¯æ°´"
    set ib_itemCustom[109] = 0
    set ib_itemNameGbk[109] = "ËÙ¶ÈÒ©Ë®"
    set ib_itemList[110] = 'dust'
    set ib_itemName[110] = "å°˜åœŸä¹‹å½±"
    set ib_itemCustom[110] = 0
    set ib_itemNameGbk[110] = "³¾ÍÁÖ®Ó°"
    set ib_itemList[111] = 'ram1'
    set ib_itemName[111] = "å¤§é­”æ³•å¸ˆæŒ‡ç¯"
    set ib_itemCustom[111] = 0
    set ib_itemNameGbk[111] = "´óÄ§·¨Ê¦Ö¸»·"
    set ib_itemList[112] = 'pinv'
    set ib_itemName[112] = "éšå½¢è¯æ°´"
    set ib_itemCustom[112] = 0
    set ib_itemNameGbk[112] = "ÒşĞÎÒ©Ë®"
    set ib_itemList[113] = 'phea'
    set ib_itemName[113] = "ç”Ÿå‘½è¯æ°´"
    set ib_itemCustom[113] = 0
    set ib_itemNameGbk[113] = "ÉúÃüÒ©Ë®"
    set ib_itemList[114] = 'pman'
    set ib_itemName[114] = "é­”æ³•è¯æ°´"
    set ib_itemCustom[114] = 0
    set ib_itemNameGbk[114] = "Ä§·¨Ò©Ë®"
    set ib_itemList[115] = 'spro'
    set ib_itemName[115] = "å®ˆæŠ¤å·è½´"
    set ib_itemCustom[115] = 0
    set ib_itemNameGbk[115] = "ÊØ»¤¾íÖá"
    set ib_itemList[116] = 'hslv'
    set ib_itemName[116] = "åŒ»ç–—å‰‚"
    set ib_itemCustom[116] = 0
    set ib_itemNameGbk[116] = "Ò½ÁÆ¼Á"
    set ib_itemList[117] = 'moon'
    set ib_itemName[117] = "æœˆäº®çŸ³"
    set ib_itemCustom[117] = 0
    set ib_itemNameGbk[117] = "ÔÂÁÁÊ¯"
    set ib_itemList[118] = 'shas'
    set ib_itemName[118] = "é€Ÿåº¦å·è½´"
    set ib_itemCustom[118] = 0
    set ib_itemNameGbk[118] = "ËÙ¶È¾íÖá"
    set ib_itemList[119] = 'skul'
    set ib_itemName[119] = "çŒ®ç¥­å¤´éª¨"
    set ib_itemCustom[119] = 0
    set ib_itemNameGbk[119] = "Ï×¼ÀÍ·¹Ç"
    set ib_itemList[120] = 'mcri'
    set ib_itemName[120] = "æœºæ¢°ç±»çš„å°ç©è‰º"
    set ib_itemCustom[120] = 0
    set ib_itemNameGbk[120] = "»úĞµÀàµÄĞ¡ÍæÒÕ"
    set ib_itemList[121] = 'rnec'
    set ib_itemName[121] = "å·«æœ¯å¦–æ£"
    set ib_itemCustom[121] = 0
    set ib_itemNameGbk[121] = "Î×ÊõÑı¹÷"
    set ib_itemList[122] = 'tsct'
    set ib_itemName[122] = "è±¡ç‰™å¡”"
    set ib_itemCustom[122] = 0
    set ib_itemNameGbk[122] = "ÏóÑÀËş"
    set ib_itemList[123] = 'azhr'
    set ib_itemName[123] = "åŸƒè‹å°¼ä¹‹å¿ƒ"
    set ib_itemCustom[123] = 0
    set ib_itemNameGbk[123] = "°£ËÕÄáÖ®ĞÄ"
    set ib_itemList[124] = 'bzbe'
    set ib_itemName[124] = "ç©ºç“¶"
    set ib_itemCustom[124] = 0
    set ib_itemNameGbk[124] = "¿ÕÆ¿"
    set ib_itemList[125] = 'bzbf'
    set ib_itemName[125] = "ç››æ»¡æ³‰æ°´çš„ç“¶å­"
    set ib_itemCustom[125] = 0
    set ib_itemNameGbk[125] = "Ê¢ÂúÈªË®µÄÆ¿×Ó"
    set ib_itemList[126] = 'ches'
    set ib_itemName[126] = "å¥¶é…ª"
    set ib_itemCustom[126] = 0
    set ib_itemNameGbk[126] = "ÄÌÀÒ"
    set ib_itemList[127] = 'cnhn'
    set ib_itemName[127] = "èµ›çº³ç•™æ–¯çš„å·è§’"
    set ib_itemCustom[127] = 0
    set ib_itemNameGbk[127] = "ÈüÄÉÁôË¹µÄºÅ½Ç"
    set ib_itemList[128] = 'glsk'
    set ib_itemName[128] = "å¤å°”ä¸¹ä¹‹é¢…"
    set ib_itemCustom[128] = 0
    set ib_itemNameGbk[128] = "¹Å¶ûµ¤Ö®Â­"
    set ib_itemList[129] = 'gopr'
    set ib_itemName[129] = "å‡€åŒ–æµ®é›•"
    set ib_itemCustom[129] = 0
    set ib_itemNameGbk[129] = "¾»»¯¸¡µñ"
    set ib_itemList[130] = 'k3m1'
    set ib_itemName[130] = "æœˆäº®æ°´æ™¶"
    set ib_itemCustom[130] = 0
    set ib_itemNameGbk[130] = "ÔÂÁÁË®¾§"
    set ib_itemList[131] = 'k3m2'
    set ib_itemName[131] = "ä¸‰æœˆä¹‹é’¥çš„å¦å¤–ä¸€ä¸ªéƒ¨åˆ†"
    set ib_itemCustom[131] = 0
    set ib_itemNameGbk[131] = "ÈıÔÂÖ®Ô¿µÄÁíÍâÒ»¸ö²¿·Ö"
    set ib_itemList[132] = 'k3m3'
    set ib_itemName[132] = "ä¸‰æœˆä¹‹é’¥"
    set ib_itemCustom[132] = 0
    set ib_itemNameGbk[132] = "ÈıÔÂÖ®Ô¿"
    set ib_itemList[133] = 'ktrm'
    set ib_itemName[133] = "æ³°ç‘çº³æ–¯å›½ç‹çš„éª¨ç°ç“®"
    set ib_itemCustom[133] = 0
    set ib_itemNameGbk[133] = "Ì©ÈğÄÉË¹¹úÍõµÄ¹Ç»ÒÎÍ"
    set ib_itemList[134] = 'kybl'
    set ib_itemName[134] = "é²œè¡€é’¥åŒ™"
    set ib_itemCustom[134] = 0
    set ib_itemNameGbk[134] = "ÏÊÑªÔ¿³×"
    set ib_itemList[135] = 'kygh'
    set ib_itemName[135] = "é­”é¬¼é’¥åŒ™"
    set ib_itemCustom[135] = 0
    set ib_itemNameGbk[135] = "Ä§¹íÔ¿³×"
    set ib_itemList[136] = 'kymn'
    set ib_itemName[136] = "æœˆä¹‹é’¥åŒ™"
    set ib_itemCustom[136] = 0
    set ib_itemNameGbk[136] = "ÔÂÖ®Ô¿³×"
    set ib_itemList[137] = 'kysn'
    set ib_itemName[137] = "å¤ªé˜³é’¥åŒ™"
    set ib_itemCustom[137] = 0
    set ib_itemNameGbk[137] = "Ì«ÑôÔ¿³×"
    set ib_itemList[138] = 'ledg'
    set ib_itemName[138] = "å‰æ‹‰å¾·çš„å¸æœ¬"
    set ib_itemCustom[138] = 0
    set ib_itemNameGbk[138] = "¼ªÀ­µÂµÄÕÊ±¾"
    set ib_itemList[139] = 'phlt'
    set ib_itemName[139] = "æç»´ç‰¹"
    set ib_itemCustom[139] = 0
    set ib_itemNameGbk[139] = "ÀîÎ¬ÌØ"
    set ib_itemList[140] = 'sehr'
    set ib_itemName[140] = "èµ›ç‘è¯ºå…‹æ–¯ä¹‹å¿ƒ"
    set ib_itemCustom[140] = 0
    set ib_itemNameGbk[140] = "ÈüÈğÅµ¿ËË¹Ö®ĞÄ"
    set ib_itemList[141] = 'engs'
    set ib_itemName[141] = "é­”æ³•å®çŸ³"
    set ib_itemCustom[141] = 0
    set ib_itemNameGbk[141] = "Ä§·¨±¦Ê¯"
    set ib_itemList[142] = 'sorf'
    set ib_itemName[142] = "å½±å­ä¹‹çƒç¢ç‰‡"
    set ib_itemCustom[142] = 0
    set ib_itemNameGbk[142] = "Ó°×ÓÖ®ÇòËéÆ¬"
    set ib_itemList[143] = 'gmfr'
    set ib_itemName[143] = "å®çŸ³ç¢ç‰‡"
    set ib_itemCustom[143] = 0
    set ib_itemNameGbk[143] = "±¦Ê¯ËéÆ¬"
    set ib_itemList[144] = 'jpnt'
    set ib_itemName[144] = "ç»™å‰å®‰å¨œ?æ™®ç½—å¾·æ‘©å°”çš„ä¾¿æ¡"
    set ib_itemCustom[144] = 0
    set ib_itemNameGbk[144] = "¸ø¼ª°²ÄÈ?ÆÕÂŞµÂÄ¦¶ûµÄ±ãÌõ"
    set ib_itemList[145] = 'shwd'
    set ib_itemName[145] = "è§å…‰è‰"
    set ib_itemCustom[145] = 0
    set ib_itemNameGbk[145] = "Ó«¹â²İ"
    set ib_itemList[146] = 'skrt'
    set ib_itemName[146] = "éª¸éª¨å®ç‰©"
    set ib_itemCustom[146] = 0
    set ib_itemNameGbk[146] = "º¡¹Ç±¦Îï"
    set ib_itemList[147] = 'thle'
    set ib_itemName[147] = "é›·éœ†èœ¥èœ´ä¹‹è›‹"
    set ib_itemCustom[147] = 0
    set ib_itemNameGbk[147] = "À×öªòáòæÖ®µ°"
    set ib_itemList[148] = 'sclp'
    set ib_itemName[148] = "ç§˜å¯†å…³å¡æ¿€æ´»"
    set ib_itemCustom[148] = 0
    set ib_itemNameGbk[148] = "ÃØÃÜ¹Ø¿¨¼¤»î"
    set ib_itemList[149] = 'wtlg'
    set ib_itemName[149] = "æ€€ç‰¹ä¹‹è…¿"
    set ib_itemCustom[149] = 0
    set ib_itemNameGbk[149] = "»³ÌØÖ®ÍÈ"
    set ib_itemList[150] = 'wolg'
    set ib_itemName[150] = "æ€€ç‰¹çš„å¦ä¸€æ¡è…¿"
    set ib_itemCustom[150] = 0
    set ib_itemNameGbk[150] = "»³ÌØµÄÁíÒ»ÌõÍÈ"
    set ib_itemList[151] = 'mgtk'
    set ib_itemName[151] = "é­”æ³•é’¥åŒ™ä¸²"
    set ib_itemCustom[151] = 0
    set ib_itemNameGbk[151] = "Ä§·¨Ô¿³×´®"
    set ib_itemList[152] = 'mort'
    set ib_itemName[152] = "è«å“¥æ—çš„æŠ¥å‘Š"
    set ib_itemCustom[152] = 0
    set ib_itemNameGbk[152] = "Äª¸çÁÖµÄ±¨¸æ"
    set ib_itemList[153] = 'dphe'
    set ib_itemName[153] = "é›·éœ†å‡¤å‡°è›‹"
    set ib_itemCustom[153] = 0
    set ib_itemNameGbk[153] = "À×öª·ï»Ëµ°"
    set ib_itemList[154] = 'dkfw'
    set ib_itemName[154] = "é›·éœ†æ°´æ¡¶"
    set ib_itemCustom[154] = 0
    set ib_itemNameGbk[154] = "À×öªË®Í°"
    set ib_itemList[155] = 'dthb'
    set ib_itemName[155] = "é›·ç”µèŠ±èŠ¯"
    set ib_itemCustom[155] = 0
    set ib_itemNameGbk[155] = "À×µç»¨Ğ¾"
    set ib_itemList[156] = 'fgun'
    set ib_itemName[156] = "ä¿¡å·æª"
    set ib_itemCustom[156] = 0
    set ib_itemNameGbk[156] = "ĞÅºÅÇ¹"
    set ib_itemList[157] = 'lure'
    set ib_itemName[157] = "æ€ªå…½è¯±æ•å®ˆå«"
    set ib_itemCustom[157] = 0
    set ib_itemNameGbk[157] = "¹ÖÊŞÓÕ²¶ÊØÎÀ"
    set ib_itemList[158] = 'olig'
    set ib_itemName[158] = "é—ªç”µä¹‹çƒ"
    set ib_itemCustom[158] = 0
    set ib_itemNameGbk[158] = "ÉÁµçÖ®Çò"
    set ib_itemList[159] = 'amrc'
    set ib_itemName[159] = "å¬å”¤æŠ¤èº«ç¬¦"
    set ib_itemCustom[159] = 0
    set ib_itemNameGbk[159] = "ÕÙ»½»¤Éí·û"
endfunction
function IB_Fill2 takes nothing returns nothing
    set ib_itemList[160] = 'ccmd'
    set ib_itemName[160] = "ç»Ÿæ²»æƒæ–"
    set ib_itemCustom[160] = 0
    set ib_itemNameGbk[160] = "Í³ÖÎÈ¨ÕÈ"
    set ib_itemList[161] = 'flag'
    set ib_itemName[161] = "äººæ—æ——å¸œ"
    set ib_itemCustom[161] = 0
    set ib_itemNameGbk[161] = "ÈË×åÆìÖÄ"
    set ib_itemList[162] = 'gobm'
    set ib_itemName[162] = "åœ°ç²¾åœ°é›·"
    set ib_itemCustom[162] = 0
    set ib_itemNameGbk[162] = "µØ¾«µØÀ×"
    set ib_itemList[163] = 'gsou'
    set ib_itemName[163] = "çµé­‚å®çŸ³"
    set ib_itemCustom[163] = 0
    set ib_itemNameGbk[163] = "Áé»ê±¦Ê¯"
    set ib_itemList[164] = 'nflg'
    set ib_itemName[164] = "æš—å¤œç²¾çµæ—æ——å¸œ"
    set ib_itemCustom[164] = 0
    set ib_itemNameGbk[164] = "°µÒ¹¾«Áé×åÆìÖÄ"
    set ib_itemList[165] = 'nspi'
    set ib_itemName[165] = "é­”æ³•å…ç–«é¡¹é“¾"
    set ib_itemCustom[165] = 0
    set ib_itemNameGbk[165] = "Ä§·¨ÃâÒßÏîÁ´"
    set ib_itemList[166] = 'oflg'
    set ib_itemName[166] = "å…½æ—æ——å¸œ"
    set ib_itemCustom[166] = 0
    set ib_itemNameGbk[166] = "ÊŞ×åÆìÖÄ"
    set ib_itemList[167] = 'pams'
    set ib_itemName[167] = "æŠ—ä½“è¯æ°´"
    set ib_itemCustom[167] = 0
    set ib_itemNameGbk[167] = "¿¹ÌåÒ©Ë®"
    set ib_itemList[168] = 'pgin'
    set ib_itemName[168] = "å¤§éšå½¢è¯æ°´"
    set ib_itemCustom[168] = 0
    set ib_itemNameGbk[168] = "´óÒşĞÎÒ©Ë®"
    set ib_itemList[169] = 'rat3'
    set ib_itemName[169] = "æ”»å‡»ä¹‹çˆª +3"
    set ib_itemCustom[169] = 0
    set ib_itemNameGbk[169] = "¹¥»÷Ö®×¦ +3"
    set ib_itemList[170] = 'rde0'
    set ib_itemName[170] = "å®ˆæŠ¤æŒ‡ç¯ +1"
    set ib_itemCustom[170] = 0
    set ib_itemNameGbk[170] = "ÊØ»¤Ö¸»· +1"
    set ib_itemList[171] = 'rnsp'
    set ib_itemName[171] = "ä¼˜è¶Šä¹‹æˆ’"
    set ib_itemCustom[171] = 0
    set ib_itemNameGbk[171] = "ÓÅÔ½Ö®½ä"
    set ib_itemList[172] = 'soul'
    set ib_itemName[172] = "çµé­‚"
    set ib_itemCustom[172] = 0
    set ib_itemNameGbk[172] = "Áé»ê"
    set ib_itemList[173] = 'tels'
    set ib_itemName[173] = "åœ°ç²¾å¤œè§†é•œ"
    set ib_itemCustom[173] = 0
    set ib_itemNameGbk[173] = "µØ¾«Ò¹ÊÓ¾µ"
    set ib_itemList[174] = 'tgxp'
    set ib_itemName[174] = "è¶…çº§ç»éªŒä¹‹ä¹¦"
    set ib_itemCustom[174] = 0
    set ib_itemNameGbk[174] = "³¬¼¶¾­ÑéÖ®Êé"
    set ib_itemList[175] = 'uflg'
    set ib_itemName[175] = "ä¸æ­»æ—æ——å¸œ"
    set ib_itemCustom[175] = 0
    set ib_itemNameGbk[175] = "²»ËÀ×åÆìÖÄ"
    set ib_itemList[176] = 'anfg'
    set ib_itemName[176] = "è¿œå¤é›•åƒ"
    set ib_itemCustom[176] = 0
    set ib_itemNameGbk[176] = "Ô¶¹ÅµñÏñ"
    set ib_itemList[177] = 'brag'
    set ib_itemName[177] = "æ•æ·è…°å¸¦"
    set ib_itemCustom[177] = 0
    set ib_itemNameGbk[177] = "Ãô½İÑü´ø"
    set ib_itemList[178] = 'drph'
    set ib_itemName[178] = "å¾·é²ä¼Šå¸ƒè¢‹"
    set ib_itemCustom[178] = 0
    set ib_itemNameGbk[178] = "µÂÂ³ÒÁ²¼´ü"
    set ib_itemList[179] = 'iwbr'
    set ib_itemName[179] = "é“æ ‘æå¹²"
    set ib_itemCustom[179] = 0
    set ib_itemNameGbk[179] = "ÌúÊ÷Ö¦¸É"
    set ib_itemList[180] = 'jdrn'
    set ib_itemName[180] = "çµå·§æŒ‡ç¯"
    set ib_itemCustom[180] = 0
    set ib_itemNameGbk[180] = "ÁéÇÉÖ¸»·"
    set ib_itemList[181] = 'lnrn'
    set ib_itemName[181] = "é›„ç‹®ä¹‹æˆ’"
    set ib_itemCustom[181] = 0
    set ib_itemNameGbk[181] = "ĞÛÊ¨Ö®½ä"
    set ib_itemList[182] = 'mlst'
    set ib_itemName[182] = "åŠ›é‡ä¹‹é”¤"
    set ib_itemCustom[182] = 0
    set ib_itemNameGbk[182] = "Á¦Á¿Ö®´¸"
    set ib_itemList[183] = 'oslo'
    set ib_itemName[183] = "å‡é€Ÿä¹‹çƒ"
    set ib_itemCustom[183] = 0
    set ib_itemNameGbk[183] = "¼õËÙÖ®Çò"
    set ib_itemList[184] = 'sbok'
    set ib_itemName[184] = "é­”æ³•ä¹¦"
    set ib_itemCustom[184] = 0
    set ib_itemNameGbk[184] = "Ä§·¨Êé"
    set ib_itemList[185] = 'sksh'
    set ib_itemName[185] = "é˜²æŠ¤é¢å…·"
    set ib_itemCustom[185] = 0
    set ib_itemNameGbk[185] = "·À»¤Ãæ¾ß"
    set ib_itemList[186] = 'sprn'
    set ib_itemName[186] = "èœ˜è››æˆ’æŒ‡"
    set ib_itemCustom[186] = 0
    set ib_itemNameGbk[186] = "Ö©Öë½äÖ¸"
    set ib_itemList[187] = 'tmmt'
    set ib_itemName[187] = "åŠ›é‡å›¾è…¾"
    set ib_itemCustom[187] = 0
    set ib_itemNameGbk[187] = "Á¦Á¿Í¼ÌÚ"
    set ib_itemList[188] = 'vddl'
    set ib_itemName[188] = "å·«æ¯’ç©å¶"
    set ib_itemCustom[188] = 0
    set ib_itemNameGbk[188] = "Î×¶¾ÍæÅ¼"
    set ib_itemList[189] = 'spre'
    set ib_itemName[189] = "ä¿å­˜æƒæ–"
    set ib_itemCustom[189] = 0
    set ib_itemNameGbk[189] = "±£´æÈ¨ÕÈ"
    set ib_itemList[190] = 'sfog'
    set ib_itemName[190] = "ä¹Œäº‘å·è§’"
    set ib_itemCustom[190] = 0
    set ib_itemNameGbk[190] = "ÎÚÔÆºÅ½Ç"
    set ib_itemList[191] = 'sor1'
    set ib_itemName[191] = "å½±å­ä¹‹çƒ +1"
    set ib_itemCustom[191] = 0
    set ib_itemNameGbk[191] = "Ó°×ÓÖ®Çò +1"
    set ib_itemList[192] = 'sor2'
    set ib_itemName[192] = "å½±å­ä¹‹çƒ +2"
    set ib_itemCustom[192] = 0
    set ib_itemNameGbk[192] = "Ó°×ÓÖ®Çò +2"
    set ib_itemList[193] = 'sor3'
    set ib_itemName[193] = "å½±å­ä¹‹çƒ +3"
    set ib_itemCustom[193] = 0
    set ib_itemNameGbk[193] = "Ó°×ÓÖ®Çò +3"
    set ib_itemList[194] = 'sor4'
    set ib_itemName[194] = "å½±å­ä¹‹çƒ +4"
    set ib_itemCustom[194] = 0
    set ib_itemNameGbk[194] = "Ó°×ÓÖ®Çò +4"
    set ib_itemList[195] = 'sor5'
    set ib_itemName[195] = "å½±å­ä¹‹çƒ +5"
    set ib_itemCustom[195] = 0
    set ib_itemNameGbk[195] = "Ó°×ÓÖ®Çò +5"
    set ib_itemList[196] = 'sor6'
    set ib_itemName[196] = "å½±å­ä¹‹çƒ +6"
    set ib_itemCustom[196] = 0
    set ib_itemNameGbk[196] = "Ó°×ÓÖ®Çò +6"
    set ib_itemList[197] = 'sor7'
    set ib_itemName[197] = "å½±å­ä¹‹çƒ +7"
    set ib_itemCustom[197] = 0
    set ib_itemNameGbk[197] = "Ó°×ÓÖ®Çò +7"
    set ib_itemList[198] = 'sor8'
    set ib_itemName[198] = "å½±å­ä¹‹çƒ +8"
    set ib_itemCustom[198] = 0
    set ib_itemNameGbk[198] = "Ó°×ÓÖ®Çò +8"
    set ib_itemList[199] = 'sor9'
    set ib_itemName[199] = "å½±å­ä¹‹çƒ +9"
    set ib_itemCustom[199] = 0
    set ib_itemNameGbk[199] = "Ó°×ÓÖ®Çò +9"
    set ib_itemList[200] = 'sora'
    set ib_itemName[200] = "å½±å­ä¹‹çƒ +10"
    set ib_itemCustom[200] = 0
    set ib_itemNameGbk[200] = "Ó°×ÓÖ®Çò +10"
    set ib_itemList[201] = 'fwss'
    set ib_itemName[201] = "å†°éœœå·¨é¾™å¤´éª¨æŠ¤ç›¾"
    set ib_itemCustom[201] = 0
    set ib_itemNameGbk[201] = "±ùËª¾ŞÁúÍ·¹Ç»¤¶Ü"
    set ib_itemList[202] = 'shtm'
    set ib_itemName[202] = "è¨æ»¡å›¾è…¾"
    set ib_itemCustom[202] = 0
    set ib_itemNameGbk[202] = "ÈøÂúÍ¼ÌÚ"
    set ib_itemList[203] = 'esaz'
    set ib_itemName[203] = "åŸƒè‹å°¼ä¹‹ç²¾é«“"
    set ib_itemCustom[203] = 0
    set ib_itemNameGbk[203] = "°£ËÕÄáÖ®¾«Ëè"
    set ib_itemList[204] = 'btst'
    set ib_itemName[204] = "æˆ˜æ–—æ ‡å‡†"
    set ib_itemCustom[204] = 0
    set ib_itemNameGbk[204] = "Õ½¶·±ê×¼"
    set ib_itemList[205] = 'tbsm'
    set ib_itemName[205] = "å¾®å‹é“åŒ é“º"
    set ib_itemCustom[205] = 0
    set ib_itemNameGbk[205] = "Î¢ĞÍÌú½³ÆÌ"
    set ib_itemList[206] = 'tfar'
    set ib_itemName[206] = "å¾®å‹å†œåœº"
    set ib_itemCustom[206] = 0
    set ib_itemNameGbk[206] = "Î¢ĞÍÅ©³¡"
    set ib_itemList[207] = 'tlum'
    set ib_itemName[207] = "å¾®å‹ä¼æœ¨åœº"
    set ib_itemCustom[207] = 0
    set ib_itemNameGbk[207] = "Î¢ĞÍ·¥Ä¾³¡"
    set ib_itemList[208] = 'tbar'
    set ib_itemName[208] = "å¾®å‹å…µè¥"
    set ib_itemCustom[208] = 0
    set ib_itemNameGbk[208] = "Î¢ĞÍ±øÓª"
    set ib_itemList[209] = 'tbak'
    set ib_itemName[209] = "å¾®å‹å›½ç‹ç¥­å›"
    set ib_itemCustom[209] = 0
    set ib_itemNameGbk[209] = "Î¢ĞÍ¹úÍõ¼ÀÌ³"
    set ib_itemList[210] = 'gldo'
    set ib_itemName[210] = "åŸºå°”åŠ ä¸¹ä¹‹çƒ"
    set ib_itemCustom[210] = 0
    set ib_itemNameGbk[210] = "»ù¶û¼Óµ¤Ö®Çò"
    set ib_itemList[211] = 'stre'
    set ib_itemName[211] = "é¼“èˆæƒæ–"
    set ib_itemCustom[211] = 0
    set ib_itemNameGbk[211] = "¹ÄÎèÈ¨ÕÈ"
    set ib_itemList[212] = 'horl'
    set ib_itemName[212] = "ç¨€æœ‰ç¥å™¨"
    set ib_itemCustom[212] = 0
    set ib_itemNameGbk[212] = "Ï¡ÓĞÉñÆ÷"
    set ib_itemList[213] = 'hbth'
    set ib_itemName[213] = "æˆ˜èˆ°ä¹‹èˆµ"
    set ib_itemCustom[213] = 0
    set ib_itemNameGbk[213] = "Õ½½¢Ö®¶æ"
    set ib_itemList[214] = 'blba'
    set ib_itemName[214] = "å‰‘åˆƒæŠ¤ç”²"
    set ib_itemCustom[214] = 0
    set ib_itemNameGbk[214] = "½£ÈĞ»¤¼×"
    set ib_itemList[215] = 'rugt'
    set ib_itemName[215] = "ç¥ç§˜æ‰‹å¥—"
    set ib_itemCustom[215] = 0
    set ib_itemNameGbk[215] = "ÉñÃØÊÖÌ×"
    set ib_itemList[216] = 'frhg'
    set ib_itemName[216] = "ç«ç„°æ‰‹å¥—"
    set ib_itemCustom[216] = 0
    set ib_itemNameGbk[216] = "»ğÑæÊÖÌ×"
    set ib_itemList[217] = 'gvsm'
    set ib_itemName[217] = "æ³•æœ¯å¤§å¸ˆæ‰‹å¥—"
    set ib_itemCustom[217] = 0
    set ib_itemNameGbk[217] = "·¨Êõ´óÊ¦ÊÖÌ×"
    set ib_itemList[218] = 'crdt'
    set ib_itemName[218] = "æ­»äº¡é¢†ä¸»çš‡å† "
    set ib_itemCustom[218] = 0
    set ib_itemNameGbk[218] = "ËÀÍöÁìÖ÷»Ê¹Ú"
    set ib_itemList[219] = 'arsc'
    set ib_itemName[219] = "ç¥ç§˜å·è½´"
    set ib_itemCustom[219] = 0
    set ib_itemNameGbk[219] = "ÉñÃØ¾íÖá"
    set ib_itemList[220] = 'scul'
    set ib_itemName[220] = "é‚ªæ¶å†›å›¢å·è½´"
    set ib_itemCustom[220] = 0
    set ib_itemNameGbk[220] = "Ğ°¶ñ¾üÍÅ¾íÖá"
    set ib_itemList[221] = 'tmsc'
    set ib_itemName[221] = "ç‰ºç‰²ä¹‹ä¹¦"
    set ib_itemCustom[221] = 0
    set ib_itemNameGbk[221] = "ÎşÉüÖ®Êé"
    set ib_itemList[222] = 'dtsb'
    set ib_itemName[222] = "å¾·é›·å…‹è¨å°”é­”æ³•ä¹¦"
    set ib_itemCustom[222] = 0
    set ib_itemNameGbk[222] = "µÂÀ×¿ËÈø¶ûÄ§·¨Êé"
    set ib_itemList[223] = 'grsl'
    set ib_itemName[223] = "çµé­‚å®ç‰©"
    set ib_itemCustom[223] = 0
    set ib_itemNameGbk[223] = "Áé»ê±¦Îï"
    set ib_itemList[224] = 'arsh'
    set ib_itemName[224] = "èŠ’ç¡æŠ¤ç›¾"
    set ib_itemCustom[224] = 0
    set ib_itemNameGbk[224] = "Ã¢Ïõ»¤¶Ü"
    set ib_itemList[225] = 'shdt'
    set ib_itemName[225] = "æ­»äº¡é¢†ä¸»æŠ¤ç›¾"
    set ib_itemCustom[225] = 0
    set ib_itemNameGbk[225] = "ËÀÍöÁìÖ÷»¤¶Ü"
    set ib_itemList[226] = 'shhn'
    set ib_itemName[226] = "è£èª‰æŠ¤ç›¾"
    set ib_itemCustom[226] = 0
    set ib_itemNameGbk[226] = "ÈÙÓş»¤¶Ü"
    set ib_itemList[227] = 'shen'
    set ib_itemName[227] = "æ–½é­”æŠ¤ç›¾"
    set ib_itemCustom[227] = 0
    set ib_itemNameGbk[227] = "Ê©Ä§»¤¶Ü"
    set ib_itemList[228] = 'thdm'
    set ib_itemName[228] = "é›·éœ†èœ¥èœ´é’»çŸ³"
    set ib_itemCustom[228] = 0
    set ib_itemNameGbk[228] = "À×öªòáòæ×êÊ¯"
    set ib_itemList[229] = 'stpg'
    set ib_itemName[229] = "æ—¶é’Ÿä¼é¹…"
    set ib_itemCustom[229] = 0
    set ib_itemNameGbk[229] = "Ê±ÖÓÆó¶ì"
    set ib_itemList[230] = 'shrs'
    set ib_itemName[230] = "çƒ¤è‚‰"
    set ib_itemCustom[230] = 0
    set ib_itemNameGbk[230] = "¿¾Èâ"
    set ib_itemList[231] = 'bfhr'
    set ib_itemName[231] = "è¡€ç¾½ä¹‹å¿ƒ"
    set ib_itemCustom[231] = 0
    set ib_itemNameGbk[231] = "ÑªÓğÖ®ĞÄ"
    set ib_itemList[232] = 'cosl'
    set ib_itemName[232] = "çµé­‚ä¹‹çƒ"
    set ib_itemCustom[232] = 0
    set ib_itemNameGbk[232] = "Áé»êÖ®Çò"
    set ib_itemList[233] = 'shcw'
    set ib_itemName[233] = "è¨æ»¡åˆ©çˆª"
    set ib_itemCustom[233] = 0
    set ib_itemNameGbk[233] = "ÈøÂúÀû×¦"
    set ib_itemList[234] = 'srbd'
    set ib_itemName[234] = "ç¼çƒ­ä¹‹åˆ€"
    set ib_itemCustom[234] = 0
    set ib_itemNameGbk[234] = "×ÆÈÈÖ®µ¶"
    set ib_itemList[235] = 'frgd'
    set ib_itemName[235] = "éœœå†»å®ˆå«"
    set ib_itemCustom[235] = 0
    set ib_itemNameGbk[235] = "Ëª¶³ÊØÎÀ"
    set ib_itemList[236] = 'envl'
    set ib_itemName[236] = "é­”æ³•å°ç“¶"
    set ib_itemCustom[236] = 0
    set ib_itemNameGbk[236] = "Ä§·¨Ğ¡Æ¿"
    set ib_itemList[237] = 'rump'
    set ib_itemName[237] = "ç”Ÿé”ˆçš„çŸ¿é“²"
    set ib_itemCustom[237] = 0
    set ib_itemNameGbk[237] = "ÉúĞâµÄ¿ó²ù"
    set ib_itemList[238] = 'srtl'
    set ib_itemName[238] = "ç‘Ÿæ‹‰æ€å°”"
    set ib_itemCustom[238] = 0
    set ib_itemNameGbk[238] = "ÉªÀ­Ë¼¶û"
    set ib_itemList[239] = 'stwa'
    set ib_itemName[239] = "æˆ˜æ–§"
    set ib_itemCustom[239] = 0
    set ib_itemNameGbk[239] = "Õ½¸«"
endfunction
function IB_Fill3 takes nothing returns nothing
    set ib_itemList[240] = 'klmm'
    set ib_itemName[240] = "è¿œå¤æˆ˜æ–§"
    set ib_itemCustom[240] = 0
    set ib_itemNameGbk[240] = "Ô¶¹ÅÕ½¸«"
    set ib_itemList[241] = 'rots'
    set ib_itemName[241] = "æµ·ä¹‹æƒæ–"
    set ib_itemCustom[241] = 0
    set ib_itemNameGbk[241] = "º£Ö®È¨ÕÈ"
    set ib_itemList[242] = 'axas'
    set ib_itemName[242] = "å…ˆç¥–æƒæ–"
    set ib_itemCustom[242] = 0
    set ib_itemNameGbk[242] = "ÏÈ×æÈ¨ÕÈ"
    set ib_itemList[243] = 'mnsf'
    set ib_itemName[243] = "å¿ƒçµæƒæ–"
    set ib_itemCustom[243] = 0
    set ib_itemNameGbk[243] = "ĞÄÁéÈ¨ÕÈ"
    set ib_itemList[244] = 'schl'
    set ib_itemName[244] = "åŒ»ç–—æƒæ–"
    set ib_itemCustom[244] = 0
    set ib_itemNameGbk[244] = "Ò½ÁÆÈ¨ÕÈ"
    set ib_itemList[245] = 'asbl'
    set ib_itemName[245] = "åˆºå®¢ä½©åˆ€"
    set ib_itemCustom[245] = 0
    set ib_itemNameGbk[245] = "´Ì¿ÍÅåµ¶"
    set ib_itemList[246] = 'kgal'
    set ib_itemName[246] = "éº¦é…’æ¡¶"
    set ib_itemCustom[246] = 0
    set ib_itemNameGbk[246] = "Âó¾ÆÍ°"
    set ib_itemList[247] = 'gold'
    set ib_itemName[247] = "é‡‘å¸"
    set ib_itemCustom[247] = 0
    set ib_itemNameGbk[247] = "½ğ±Ò"
    set ib_itemList[248] = 'lmbr'
    set ib_itemName[248] = "æœ¨æå †"
    set ib_itemCustom[248] = 0
    set ib_itemNameGbk[248] = "Ä¾²Ä¶Ñ"
    set ib_itemList[249] = 'gfor'
    set ib_itemName[249] = "é˜²å¾¡æµ®é›•"
    set ib_itemCustom[249] = 0
    set ib_itemNameGbk[249] = "·ÀÓù¸¡µñ"
    set ib_itemList[250] = 'guvi'
    set ib_itemName[250] = "å¤œè§†æµ®é›•"
    set ib_itemCustom[250] = 0
    set ib_itemNameGbk[250] = "Ò¹ÊÓ¸¡µñ"
    set ib_itemList[251] = 'rspl'
    set ib_itemName[251] = "çµé­‚é”é“¾ç¥ç¬¦"
    set ib_itemCustom[251] = 0
    set ib_itemNameGbk[251] = "Áé»êËøÁ´Éñ·û"
    set ib_itemList[252] = 'rre1'
    set ib_itemName[252] = "å°å‹å¤æ´»ç¥ç¬¦"
    set ib_itemCustom[252] = 0
    set ib_itemNameGbk[252] = "Ğ¡ĞÍ¸´»îÉñ·û"
    set ib_itemList[253] = 'rre2'
    set ib_itemName[253] = "å¤§å‹å¤æ´»ç¥ç¬¦"
    set ib_itemCustom[253] = 0
    set ib_itemNameGbk[253] = "´óĞÍ¸´»îÉñ·û"
    set ib_itemList[254] = 'gomn'
    set ib_itemName[254] = "å…¨çŸ¥æµ®é›•"
    set ib_itemCustom[254] = 0
    set ib_itemNameGbk[254] = "È«Öª¸¡µñ"
    set ib_itemList[255] = 'rsps'
    set ib_itemName[255] = "æŠ¤ç›¾ç¥ç¬¦"
    set ib_itemCustom[255] = 0
    set ib_itemNameGbk[255] = "»¤¶ÜÉñ·û"
    set ib_itemList[256] = 'rspd'
    set ib_itemName[256] = "é€Ÿåº¦ç¥ç¬¦"
    set ib_itemCustom[256] = 0
    set ib_itemNameGbk[256] = "ËÙ¶ÈÉñ·û"
    set ib_itemList[257] = 'rman'
    set ib_itemName[257] = "é­”æ³•ç¥ç¬¦"
    set ib_itemCustom[257] = 0
    set ib_itemNameGbk[257] = "Ä§·¨Éñ·û"
    set ib_itemList[258] = 'rma2'
    set ib_itemName[258] = "å¤§å‹é­”æ³•ç¥ç¬¦"
    set ib_itemCustom[258] = 0
    set ib_itemNameGbk[258] = "´óĞÍÄ§·¨Éñ·û"
    set ib_itemList[259] = 'rres'
    set ib_itemName[259] = "æ¢å¤ç¥ç¬¦"
    set ib_itemCustom[259] = 0
    set ib_itemNameGbk[259] = "»Ö¸´Éñ·û"
    set ib_itemList[260] = 'rreb'
    set ib_itemName[260] = "é‡ç”Ÿç¥ç¬¦"
    set ib_itemCustom[260] = 0
    set ib_itemNameGbk[260] = "ÖØÉúÉñ·û"
    set ib_itemList[261] = 'rhe1'
    set ib_itemName[261] = "å°å‹æ²»ç–—ç¥ç¬¦"
    set ib_itemCustom[261] = 0
    set ib_itemNameGbk[261] = "Ğ¡ĞÍÖÎÁÆÉñ·û"
    set ib_itemList[262] = 'rhe2'
    set ib_itemName[262] = "æ²»ç–—ç¥ç¬¦"
    set ib_itemCustom[262] = 0
    set ib_itemNameGbk[262] = "ÖÎÁÆÉñ·û"
    set ib_itemList[263] = 'rhe3'
    set ib_itemName[263] = "å¤§å‹æ²»ç–—ç¥ç¬¦"
    set ib_itemCustom[263] = 0
    set ib_itemNameGbk[263] = "´óĞÍÖÎÁÆÉñ·û"
    set ib_itemList[264] = 'rdis'
    set ib_itemName[264] = "é©±é­”ç¥ç¬¦"
    set ib_itemCustom[264] = 0
    set ib_itemNameGbk[264] = "ÇıÄ§Éñ·û"
    set ib_itemList[265] = 'rwat'
    set ib_itemName[265] = "å²—å“¨ç¥ç¬¦"
    set ib_itemCustom[265] = 0
    set ib_itemNameGbk[265] = "¸ÚÉÚÉñ·û"
    set ib_itemList[266] = 'pclr'
    set ib_itemName[266] = "å‡€åŒ–è¯æ°´"
    set ib_itemCustom[266] = 0
    set ib_itemNameGbk[266] = "¾»»¯Ò©Ë®"
    set ib_itemList[267] = 'plcl'
    set ib_itemName[267] = "å°å‡€åŒ–è¯æ°´"
    set ib_itemCustom[267] = 0
    set ib_itemNameGbk[267] = "Ğ¡¾»»¯Ò©Ë®"
    set ib_itemList[268] = 'silk'
    set ib_itemName[268] = "èœ˜è››ä¸é¥°é’ˆ"
    set ib_itemCustom[268] = 0
    set ib_itemNameGbk[268] = "Ö©ÖëË¿ÊÎÕë"
    set ib_itemList[269] = 'vamp'
    set ib_itemName[269] = "å¸è¡€è¯æ°´"
    set ib_itemCustom[269] = 0
    set ib_itemNameGbk[269] = "ÎüÑªÒ©Ë®"
    set ib_itemList[270] = 'sreg'
    set ib_itemName[270] = "æ¢å¤å·è½´"
    set ib_itemCustom[270] = 0
    set ib_itemNameGbk[270] = "»Ö¸´¾íÖá"
    set ib_itemList[271] = 'ssan'
    set ib_itemName[271] = "é¿éš¾æƒæ–"
    set ib_itemCustom[271] = 0
    set ib_itemNameGbk[271] = "±ÜÄÑÈ¨ÕÈ"
    set ib_itemList[272] = 'tcas'
    set ib_itemName[272] = "å°åŸå ¡"
    set ib_itemCustom[272] = 0
    set ib_itemNameGbk[272] = "Ğ¡³Ç±¤"
    set ib_itemList[273] = 'RStl'
    set ib_itemName[273] = ""
    set ib_itemCustom[273] = 1
    set ib_itemNameGbk[273] = ""
    set ib_itemList[274] = 'RoSt'
    set ib_itemName[274] = ""
    set ib_itemCustom[274] = 1
    set ib_itemNameGbk[274] = ""
    set ib_itemList[275] = 'CStl'
    set ib_itemName[275] = ""
    set ib_itemCustom[275] = 1
    set ib_itemNameGbk[275] = ""
    set ib_itemList[276] = 'CrSt'
    set ib_itemName[276] = ""
    set ib_itemCustom[276] = 1
    set ib_itemNameGbk[276] = ""
    set ib_itemList[277] = 'Cchn'
    set ib_itemName[277] = ""
    set ib_itemCustom[277] = 1
    set ib_itemNameGbk[277] = ""
    set ib_itemList[278] = 'Cpck'
    set ib_itemName[278] = ""
    set ib_itemCustom[278] = 1
    set ib_itemNameGbk[278] = ""
    set ib_itemList[279] = 'Cgnt'
    set ib_itemName[279] = ""
    set ib_itemCustom[279] = 1
    set ib_itemNameGbk[279] = ""
    set ib_itemList[280] = 'Caxe'
    set ib_itemName[280] = ""
    set ib_itemCustom[280] = 1
    set ib_itemNameGbk[280] = ""
    set ib_itemList[281] = 'Csmb'
    set ib_itemName[281] = ""
    set ib_itemCustom[281] = 1
    set ib_itemNameGbk[281] = ""
    set ib_itemList[282] = 'Cban'
    set ib_itemName[282] = ""
    set ib_itemCustom[282] = 1
    set ib_itemNameGbk[282] = ""
    set ib_itemList[283] = 'CrnR'
    set ib_itemName[283] = ""
    set ib_itemCustom[283] = 1
    set ib_itemNameGbk[283] = ""
    set ib_itemList[284] = 'CamV'
    set ib_itemName[284] = ""
    set ib_itemCustom[284] = 1
    set ib_itemNameGbk[284] = ""
    set ib_itemList[285] = 'Cbck'
    set ib_itemName[285] = ""
    set ib_itemCustom[285] = 1
    set ib_itemNameGbk[285] = ""
    set ib_itemList[286] = 'Cshs'
    set ib_itemName[286] = ""
    set ib_itemCustom[286] = 1
    set ib_itemNameGbk[286] = ""
    set ib_itemList[287] = 'Cvst'
    set ib_itemName[287] = ""
    set ib_itemCustom[287] = 1
    set ib_itemNameGbk[287] = ""
    set ib_itemList[288] = 'Clmw'
    set ib_itemName[288] = ""
    set ib_itemCustom[288] = 1
    set ib_itemNameGbk[288] = ""
    set ib_itemList[289] = 'Urwv'
    set ib_itemName[289] = ""
    set ib_itemCustom[289] = 1
    set ib_itemNameGbk[289] = ""
    set ib_itemList[290] = 'Cwtb'
    set ib_itemName[290] = ""
    set ib_itemCustom[290] = 1
    set ib_itemNameGbk[290] = ""
    set ib_itemList[291] = 'Uwba'
    set ib_itemName[291] = ""
    set ib_itemCustom[291] = 1
    set ib_itemNameGbk[291] = ""
    set ib_itemList[292] = 'Rsst'
    set ib_itemName[292] = ""
    set ib_itemCustom[292] = 1
    set ib_itemNameGbk[292] = ""
    set ib_itemList[293] = 'Ushc'
    set ib_itemName[293] = ""
    set ib_itemCustom[293] = 1
    set ib_itemNameGbk[293] = ""
    set ib_itemList[294] = 'Ckoa'
    set ib_itemName[294] = ""
    set ib_itemCustom[294] = 1
    set ib_itemNameGbk[294] = ""
    set ib_itemList[295] = 'Ubvm'
    set ib_itemName[295] = ""
    set ib_itemCustom[295] = 1
    set ib_itemNameGbk[295] = ""
    set ib_itemList[296] = 'UpoF'
    set ib_itemName[296] = ""
    set ib_itemCustom[296] = 1
    set ib_itemNameGbk[296] = ""
    set ib_itemList[297] = 'Ucrs'
    set ib_itemName[297] = ""
    set ib_itemCustom[297] = 1
    set ib_itemNameGbk[297] = ""
    set ib_itemList[298] = 'Rsoh'
    set ib_itemName[298] = ""
    set ib_itemCustom[298] = 1
    set ib_itemNameGbk[298] = ""
    set ib_itemList[299] = 'Usng'
    set ib_itemName[299] = ""
    set ib_itemCustom[299] = 1
    set ib_itemNameGbk[299] = ""
    set ib_itemList[300] = 'Crfa'
    set ib_itemName[300] = ""
    set ib_itemCustom[300] = 1
    set ib_itemNameGbk[300] = ""
    set ib_itemList[301] = 'Uboh'
    set ib_itemName[301] = ""
    set ib_itemCustom[301] = 1
    set ib_itemNameGbk[301] = ""
    set ib_itemList[302] = 'Rars'
    set ib_itemName[302] = ""
    set ib_itemCustom[302] = 1
    set ib_itemNameGbk[302] = ""
    set ib_itemList[303] = 'Romb'
    set ib_itemName[303] = ""
    set ib_itemCustom[303] = 1
    set ib_itemNameGbk[303] = ""
    set ib_itemList[304] = 'Rfhg'
    set ib_itemName[304] = ""
    set ib_itemCustom[304] = 1
    set ib_itemNameGbk[304] = ""
    set ib_itemList[305] = 'Upol'
    set ib_itemName[305] = ""
    set ib_itemCustom[305] = 1
    set ib_itemNameGbk[305] = ""
    set ib_itemList[306] = 'Urrp'
    set ib_itemName[306] = ""
    set ib_itemCustom[306] = 1
    set ib_itemNameGbk[306] = ""
    set ib_itemList[307] = 'Umgr'
    set ib_itemName[307] = ""
    set ib_itemCustom[307] = 1
    set ib_itemNameGbk[307] = ""
    set ib_itemList[308] = 'Cptb'
    set ib_itemName[308] = ""
    set ib_itemCustom[308] = 1
    set ib_itemNameGbk[308] = ""
    set ib_itemList[309] = 'Udwt'
    set ib_itemName[309] = ""
    set ib_itemCustom[309] = 1
    set ib_itemNameGbk[309] = ""
    set ib_itemList[310] = 'Uhob'
    set ib_itemName[310] = ""
    set ib_itemCustom[310] = 1
    set ib_itemNameGbk[310] = ""
    set ib_itemList[311] = 'Usch'
    set ib_itemName[311] = ""
    set ib_itemCustom[311] = 1
    set ib_itemNameGbk[311] = ""
    set ib_itemList[312] = 'Rsag'
    set ib_itemName[312] = ""
    set ib_itemCustom[312] = 1
    set ib_itemNameGbk[312] = ""
    set ib_itemList[313] = 'Rsoa'
    set ib_itemName[313] = ""
    set ib_itemCustom[313] = 1
    set ib_itemNameGbk[313] = ""
    set ib_itemList[314] = 'Ucop'
    set ib_itemName[314] = ""
    set ib_itemCustom[314] = 1
    set ib_itemNameGbk[314] = ""
    set ib_itemList[315] = 'Upov'
    set ib_itemName[315] = ""
    set ib_itemCustom[315] = 1
    set ib_itemNameGbk[315] = ""
    set ib_itemList[316] = 'Urcg'
    set ib_itemName[316] = ""
    set ib_itemCustom[316] = 1
    set ib_itemNameGbk[316] = ""
    set ib_itemList[317] = 'Usrg'
    set ib_itemName[317] = ""
    set ib_itemCustom[317] = 1
    set ib_itemNameGbk[317] = ""
    set ib_itemList[318] = 'Uads'
    set ib_itemName[318] = ""
    set ib_itemCustom[318] = 1
    set ib_itemNameGbk[318] = ""
    set ib_itemList[319] = 'Utcv'
    set ib_itemName[319] = ""
    set ib_itemCustom[319] = 1
    set ib_itemNameGbk[319] = ""
endfunction
function IB_Fill4 takes nothing returns nothing
    set ib_itemList[320] = 'Rbtb'
    set ib_itemName[320] = ""
    set ib_itemCustom[320] = 1
    set ib_itemNameGbk[320] = ""
    set ib_itemList[321] = 'Ursf'
    set ib_itemName[321] = ""
    set ib_itemCustom[321] = 1
    set ib_itemNameGbk[321] = ""
    set ib_itemList[322] = 'Rthd'
    set ib_itemName[322] = ""
    set ib_itemCustom[322] = 1
    set ib_itemNameGbk[322] = ""
    set ib_itemList[323] = 'Rdtb'
    set ib_itemName[323] = ""
    set ib_itemCustom[323] = 1
    set ib_itemNameGbk[323] = ""
    set ib_itemList[324] = 'Upos'
    set ib_itemName[324] = ""
    set ib_itemCustom[324] = 1
    set ib_itemNameGbk[324] = ""
    set ib_itemList[325] = 'Croe'
    set ib_itemName[325] = ""
    set ib_itemCustom[325] = 1
    set ib_itemNameGbk[325] = ""
    set ib_itemList[326] = 'Urng'
    set ib_itemName[326] = ""
    set ib_itemCustom[326] = 1
    set ib_itemNameGbk[326] = ""
    set ib_itemList[327] = 'Rrom'
    set ib_itemName[327] = ""
    set ib_itemCustom[327] = 1
    set ib_itemNameGbk[327] = ""
    set ib_itemList[328] = 'Rans'
    set ib_itemName[328] = ""
    set ib_itemCustom[328] = 1
    set ib_itemNameGbk[328] = ""
    set ib_itemList[329] = 'Rcdl'
    set ib_itemName[329] = ""
    set ib_itemCustom[329] = 1
    set ib_itemNameGbk[329] = ""
    set ib_itemList[330] = 'Eklm'
    set ib_itemName[330] = ""
    set ib_itemCustom[330] = 1
    set ib_itemNameGbk[330] = ""
    set ib_itemList[331] = 'Cspg'
    set ib_itemName[331] = ""
    set ib_itemCustom[331] = 1
    set ib_itemNameGbk[331] = ""
    set ib_itemList[332] = 'Rshd'
    set ib_itemName[332] = ""
    set ib_itemCustom[332] = 1
    set ib_itemNameGbk[332] = ""
    set ib_itemList[333] = 'Ubbs'
    set ib_itemName[333] = ""
    set ib_itemCustom[333] = 1
    set ib_itemNameGbk[333] = ""
    set ib_itemList[334] = 'Ebsw'
    set ib_itemName[334] = ""
    set ib_itemCustom[334] = 1
    set ib_itemNameGbk[334] = ""
    set ib_itemList[335] = 'Lcfr'
    set ib_itemName[335] = ""
    set ib_itemCustom[335] = 1
    set ib_itemNameGbk[335] = ""
    set ib_itemList[336] = 'Ugoa'
    set ib_itemName[336] = ""
    set ib_itemCustom[336] = 1
    set ib_itemNameGbk[336] = ""
    set ib_itemList[337] = 'Rhcc'
    set ib_itemName[337] = ""
    set ib_itemCustom[337] = 1
    set ib_itemNameGbk[337] = ""
    set ib_itemList[338] = 'Rnck'
    set ib_itemName[338] = ""
    set ib_itemCustom[338] = 1
    set ib_itemNameGbk[338] = ""
    set ib_itemList[339] = 'Rwgs'
    set ib_itemName[339] = ""
    set ib_itemCustom[339] = 1
    set ib_itemNameGbk[339] = ""
    set ib_itemList[340] = 'Rfws'
    set ib_itemName[340] = ""
    set ib_itemCustom[340] = 1
    set ib_itemNameGbk[340] = ""
    set ib_itemList[341] = 'Eclt'
    set ib_itemName[341] = ""
    set ib_itemCustom[341] = 1
    set ib_itemNameGbk[341] = ""
    set ib_itemList[342] = 'Erbs'
    set ib_itemName[342] = ""
    set ib_itemCustom[342] = 1
    set ib_itemNameGbk[342] = ""
    set ib_itemList[343] = 'OgBS'
    set ib_itemName[343] = "æˆ˜æ–—æ ‡å‡†"
    set ib_itemCustom[343] = 1
    set ib_itemNameGbk[343] = "Õ½¶·±ê×¼"
    set ib_itemList[344] = 'Rdsi'
    set ib_itemName[344] = ""
    set ib_itemCustom[344] = 1
    set ib_itemNameGbk[344] = ""
    set ib_itemList[345] = 'Lkde'
    set ib_itemName[345] = ""
    set ib_itemCustom[345] = 1
    set ib_itemNameGbk[345] = ""
    set ib_itemList[346] = 'Lsrp'
    set ib_itemName[346] = ""
    set ib_itemCustom[346] = 1
    set ib_itemNameGbk[346] = ""
    set ib_itemList[347] = 'Udfs'
    set ib_itemName[347] = ""
    set ib_itemCustom[347] = 1
    set ib_itemNameGbk[347] = ""
    set ib_itemList[348] = 'Ustb'
    set ib_itemName[348] = ""
    set ib_itemCustom[348] = 1
    set ib_itemNameGbk[348] = ""
    set ib_itemList[349] = 'Uorc'
    set ib_itemName[349] = ""
    set ib_itemCustom[349] = 1
    set ib_itemNameGbk[349] = ""
    set ib_itemList[350] = 'Uwbd'
    set ib_itemName[350] = ""
    set ib_itemCustom[350] = 1
    set ib_itemNameGbk[350] = ""
    set ib_itemList[351] = 'Umbd'
    set ib_itemName[351] = ""
    set ib_itemCustom[351] = 1
    set ib_itemNameGbk[351] = ""
    set ib_itemList[352] = 'Rcol'
    set ib_itemName[352] = ""
    set ib_itemCustom[352] = 1
    set ib_itemNameGbk[352] = ""
    set ib_itemList[353] = 'Ublc'
    set ib_itemName[353] = ""
    set ib_itemCustom[353] = 1
    set ib_itemNameGbk[353] = ""
    set ib_itemList[354] = 'Umgt'
    set ib_itemName[354] = ""
    set ib_itemCustom[354] = 1
    set ib_itemNameGbk[354] = ""
    set ib_itemList[355] = 'Qbdc'
    set ib_itemName[355] = ""
    set ib_itemCustom[355] = 1
    set ib_itemNameGbk[355] = ""
    set ib_itemList[356] = 'Esrt'
    set ib_itemName[356] = ""
    set ib_itemCustom[356] = 1
    set ib_itemNameGbk[356] = ""
    set ib_itemList[357] = 'Rbog'
    set ib_itemName[357] = ""
    set ib_itemCustom[357] = 1
    set ib_itemNameGbk[357] = ""
    set ib_itemList[358] = 'Rdgm'
    set ib_itemName[358] = ""
    set ib_itemCustom[358] = 1
    set ib_itemNameGbk[358] = ""
    set ib_itemList[359] = 'Qsle'
    set ib_itemName[359] = ""
    set ib_itemCustom[359] = 1
    set ib_itemNameGbk[359] = ""
    set ib_itemList[360] = 'Qwkc'
    set ib_itemName[360] = ""
    set ib_itemCustom[360] = 1
    set ib_itemNameGbk[360] = ""
    set ib_itemList[361] = 'Rskh'
    set ib_itemName[361] = ""
    set ib_itemCustom[361] = 1
    set ib_itemNameGbk[361] = ""
    set ib_itemList[362] = 'Rssb'
    set ib_itemName[362] = ""
    set ib_itemCustom[362] = 1
    set ib_itemNameGbk[362] = ""
    set ib_itemList[363] = 'Rfgg'
    set ib_itemName[363] = ""
    set ib_itemCustom[363] = 1
    set ib_itemNameGbk[363] = ""
    set ib_itemList[364] = 'Rhap'
    set ib_itemName[364] = ""
    set ib_itemCustom[364] = 1
    set ib_itemNameGbk[364] = ""
    set ib_itemList[365] = 'Rhkt'
    set ib_itemName[365] = ""
    set ib_itemCustom[365] = 1
    set ib_itemNameGbk[365] = ""
    set ib_itemList[366] = 'Urov'
    set ib_itemName[366] = ""
    set ib_itemCustom[366] = 1
    set ib_itemNameGbk[366] = ""
    set ib_itemList[367] = 'Rwrb'
    set ib_itemName[367] = ""
    set ib_itemCustom[367] = 1
    set ib_itemNameGbk[367] = ""
    set ib_itemList[368] = 'Rswt'
    set ib_itemName[368] = ""
    set ib_itemCustom[368] = 1
    set ib_itemNameGbk[368] = ""
    set ib_itemList[369] = 'Lblr'
    set ib_itemName[369] = ""
    set ib_itemCustom[369] = 1
    set ib_itemNameGbk[369] = ""
    set ib_itemList[370] = 'Cprt'
    set ib_itemName[370] = ""
    set ib_itemCustom[370] = 1
    set ib_itemNameGbk[370] = ""
    set ib_itemList[371] = 'Rchc'
    set ib_itemName[371] = ""
    set ib_itemCustom[371] = 1
    set ib_itemNameGbk[371] = ""
    set ib_itemList[372] = 'Rpom'
    set ib_itemName[372] = ""
    set ib_itemCustom[372] = 1
    set ib_itemNameGbk[372] = ""
    set ib_itemList[373] = 'I103'
    set ib_itemName[373] = "é˜¿å…‹è’™å¾·ä¹‹æ‰‹"
    set ib_itemCustom[373] = 1
    set ib_itemNameGbk[373] = "°¢¿ËÃÉµÂÖ®ÊÖ"
    set ib_itemList[374] = 'I100'
    set ib_itemName[374] = "å •è½å¤©ä½¿ä¹‹ç¿¼"
    set ib_itemCustom[374] = 1
    set ib_itemNameGbk[374] = "¶éÂäÌìÊ¹Ö®Òí"
    set ib_itemList[375] = 'I101'
    set ib_itemName[375] = "å¤©ä½¿ä¹‹ç¿¼"
    set ib_itemCustom[375] = 1
    set ib_itemNameGbk[375] = "ÌìÊ¹Ö®Òí"
    set ib_itemList[376] = 'I102'
    set ib_itemName[376] = "æ¶é­”ä¹‹ç¿¼"
    set ib_itemCustom[376] = 1
    set ib_itemNameGbk[376] = "¶ñÄ§Ö®Òí"
    set ib_itemList[377] = 'I104'
    set ib_itemName[377] = "æ˜Ÿé­‚ä¹‹åŠ›"
    set ib_itemCustom[377] = 1
    set ib_itemNameGbk[377] = "ĞÇ»êÖ®Á¦"
    set ib_itemList[378] = 'RStl'
    set ib_itemName[378] = "rstl"
    set ib_itemCustom[378] = 1
    set ib_itemNameGbk[378] = "rstl"
    set ib_itemList[379] = 'RoSt'
    set ib_itemName[379] = "rost"
    set ib_itemCustom[379] = 1
    set ib_itemNameGbk[379] = "rost"
    set ib_itemList[380] = 'CStl'
    set ib_itemName[380] = "cstl"
    set ib_itemCustom[380] = 1
    set ib_itemNameGbk[380] = "cstl"
    set ib_itemList[381] = 'CrSt'
    set ib_itemName[381] = "crst"
    set ib_itemCustom[381] = 1
    set ib_itemNameGbk[381] = "crst"
    set ib_itemList[382] = 'Cchn'
    set ib_itemName[382] = "cchn"
    set ib_itemCustom[382] = 1
    set ib_itemNameGbk[382] = "cchn"
    set ib_itemList[383] = 'Cpck'
    set ib_itemName[383] = "cpck"
    set ib_itemCustom[383] = 1
    set ib_itemNameGbk[383] = "cpck"
    set ib_itemList[384] = 'Cgnt'
    set ib_itemName[384] = "cgnt"
    set ib_itemCustom[384] = 1
    set ib_itemNameGbk[384] = "cgnt"
    set ib_itemList[385] = 'Caxe'
    set ib_itemName[385] = "caxe"
    set ib_itemCustom[385] = 1
    set ib_itemNameGbk[385] = "caxe"
    set ib_itemList[386] = 'Csmb'
    set ib_itemName[386] = "csmb"
    set ib_itemCustom[386] = 1
    set ib_itemNameGbk[386] = "csmb"
    set ib_itemList[387] = 'Cban'
    set ib_itemName[387] = "cban"
    set ib_itemCustom[387] = 1
    set ib_itemNameGbk[387] = "cban"
    set ib_itemList[388] = 'CrnR'
    set ib_itemName[388] = "crnr"
    set ib_itemCustom[388] = 1
    set ib_itemNameGbk[388] = "crnr"
    set ib_itemList[389] = 'CamV'
    set ib_itemName[389] = "camv"
    set ib_itemCustom[389] = 1
    set ib_itemNameGbk[389] = "camv"
    set ib_itemList[390] = 'Cbck'
    set ib_itemName[390] = "cbck"
    set ib_itemCustom[390] = 1
    set ib_itemNameGbk[390] = "cbck"
    set ib_itemList[391] = 'Cshs'
    set ib_itemName[391] = "cshs"
    set ib_itemCustom[391] = 1
    set ib_itemNameGbk[391] = "cshs"
    set ib_itemList[392] = 'Cvst'
    set ib_itemName[392] = "cvst"
    set ib_itemCustom[392] = 1
    set ib_itemNameGbk[392] = "cvst"
    set ib_itemList[393] = 'Clmw'
    set ib_itemName[393] = "clmw"
    set ib_itemCustom[393] = 1
    set ib_itemNameGbk[393] = "clmw"
    set ib_itemList[394] = 'Urwv'
    set ib_itemName[394] = "urwv"
    set ib_itemCustom[394] = 1
    set ib_itemNameGbk[394] = "urwv"
    set ib_itemList[395] = 'Cwtb'
    set ib_itemName[395] = "cwtb"
    set ib_itemCustom[395] = 1
    set ib_itemNameGbk[395] = "cwtb"
    set ib_itemList[396] = 'Uwba'
    set ib_itemName[396] = "uwba"
    set ib_itemCustom[396] = 1
    set ib_itemNameGbk[396] = "uwba"
    set ib_itemList[397] = 'Rsst'
    set ib_itemName[397] = "rsst"
    set ib_itemCustom[397] = 1
    set ib_itemNameGbk[397] = "rsst"
    set ib_itemList[398] = 'Ushc'
    set ib_itemName[398] = "ushc"
    set ib_itemCustom[398] = 1
    set ib_itemNameGbk[398] = "ushc"
    set ib_itemList[399] = 'Ckoa'
    set ib_itemName[399] = "ckoa"
    set ib_itemCustom[399] = 1
    set ib_itemNameGbk[399] = "ckoa"
endfunction
function IB_Fill5 takes nothing returns nothing
    set ib_itemList[400] = 'Ubvm'
    set ib_itemName[400] = "ubvm"
    set ib_itemCustom[400] = 1
    set ib_itemNameGbk[400] = "ubvm"
    set ib_itemList[401] = 'UpoF'
    set ib_itemName[401] = "upof"
    set ib_itemCustom[401] = 1
    set ib_itemNameGbk[401] = "upof"
    set ib_itemList[402] = 'Ucrs'
    set ib_itemName[402] = "ucrs"
    set ib_itemCustom[402] = 1
    set ib_itemNameGbk[402] = "ucrs"
    set ib_itemList[403] = 'Rsoh'
    set ib_itemName[403] = "rsoh"
    set ib_itemCustom[403] = 1
    set ib_itemNameGbk[403] = "rsoh"
    set ib_itemList[404] = 'Usng'
    set ib_itemName[404] = "usng"
    set ib_itemCustom[404] = 1
    set ib_itemNameGbk[404] = "usng"
    set ib_itemList[405] = 'Crfa'
    set ib_itemName[405] = "crfa"
    set ib_itemCustom[405] = 1
    set ib_itemNameGbk[405] = "crfa"
    set ib_itemList[406] = 'Uboh'
    set ib_itemName[406] = "uboh"
    set ib_itemCustom[406] = 1
    set ib_itemNameGbk[406] = "uboh"
    set ib_itemList[407] = 'Rars'
    set ib_itemName[407] = "rars"
    set ib_itemCustom[407] = 1
    set ib_itemNameGbk[407] = "rars"
    set ib_itemList[408] = 'Romb'
    set ib_itemName[408] = "romb"
    set ib_itemCustom[408] = 1
    set ib_itemNameGbk[408] = "romb"
    set ib_itemList[409] = 'Rfhg'
    set ib_itemName[409] = "rfhg"
    set ib_itemCustom[409] = 1
    set ib_itemNameGbk[409] = "rfhg"
    set ib_itemList[410] = 'Upol'
    set ib_itemName[410] = "upol"
    set ib_itemCustom[410] = 1
    set ib_itemNameGbk[410] = "upol"
    set ib_itemList[411] = 'Urrp'
    set ib_itemName[411] = "urrp"
    set ib_itemCustom[411] = 1
    set ib_itemNameGbk[411] = "urrp"
    set ib_itemList[412] = 'Umgr'
    set ib_itemName[412] = "umgr"
    set ib_itemCustom[412] = 1
    set ib_itemNameGbk[412] = "umgr"
    set ib_itemList[413] = 'Cptb'
    set ib_itemName[413] = "cptb"
    set ib_itemCustom[413] = 1
    set ib_itemNameGbk[413] = "cptb"
    set ib_itemList[414] = 'Udwt'
    set ib_itemName[414] = "udwt"
    set ib_itemCustom[414] = 1
    set ib_itemNameGbk[414] = "udwt"
    set ib_itemList[415] = 'Uhob'
    set ib_itemName[415] = "uhob"
    set ib_itemCustom[415] = 1
    set ib_itemNameGbk[415] = "uhob"
    set ib_itemList[416] = 'Usch'
    set ib_itemName[416] = "usch"
    set ib_itemCustom[416] = 1
    set ib_itemNameGbk[416] = "usch"
    set ib_itemList[417] = 'Rsag'
    set ib_itemName[417] = "rsag"
    set ib_itemCustom[417] = 1
    set ib_itemNameGbk[417] = "rsag"
    set ib_itemList[418] = 'Rsoa'
    set ib_itemName[418] = "rsoa"
    set ib_itemCustom[418] = 1
    set ib_itemNameGbk[418] = "rsoa"
    set ib_itemList[419] = 'Ucop'
    set ib_itemName[419] = "ucop"
    set ib_itemCustom[419] = 1
    set ib_itemNameGbk[419] = "ucop"
    set ib_itemList[420] = 'Upov'
    set ib_itemName[420] = "upov"
    set ib_itemCustom[420] = 1
    set ib_itemNameGbk[420] = "upov"
    set ib_itemList[421] = 'Urcg'
    set ib_itemName[421] = "urcg"
    set ib_itemCustom[421] = 1
    set ib_itemNameGbk[421] = "urcg"
    set ib_itemList[422] = 'Usrg'
    set ib_itemName[422] = "usrg"
    set ib_itemCustom[422] = 1
    set ib_itemNameGbk[422] = "usrg"
    set ib_itemList[423] = 'Uads'
    set ib_itemName[423] = "uads"
    set ib_itemCustom[423] = 1
    set ib_itemNameGbk[423] = "uads"
    set ib_itemList[424] = 'Utcv'
    set ib_itemName[424] = "utcv"
    set ib_itemCustom[424] = 1
    set ib_itemNameGbk[424] = "utcv"
    set ib_itemList[425] = 'Rbtb'
    set ib_itemName[425] = "rbtb"
    set ib_itemCustom[425] = 1
    set ib_itemNameGbk[425] = "rbtb"
    set ib_itemList[426] = 'Ursf'
    set ib_itemName[426] = "ursf"
    set ib_itemCustom[426] = 1
    set ib_itemNameGbk[426] = "ursf"
    set ib_itemList[427] = 'Rthd'
    set ib_itemName[427] = "rthd"
    set ib_itemCustom[427] = 1
    set ib_itemNameGbk[427] = "rthd"
    set ib_itemList[428] = 'Rdtb'
    set ib_itemName[428] = "rdtb"
    set ib_itemCustom[428] = 1
    set ib_itemNameGbk[428] = "rdtb"
    set ib_itemList[429] = 'Upos'
    set ib_itemName[429] = "upos"
    set ib_itemCustom[429] = 1
    set ib_itemNameGbk[429] = "upos"
    set ib_itemList[430] = 'Croe'
    set ib_itemName[430] = "croe"
    set ib_itemCustom[430] = 1
    set ib_itemNameGbk[430] = "croe"
    set ib_itemList[431] = 'Urng'
    set ib_itemName[431] = "urng"
    set ib_itemCustom[431] = 1
    set ib_itemNameGbk[431] = "urng"
    set ib_itemList[432] = 'Rrom'
    set ib_itemName[432] = "rrom"
    set ib_itemCustom[432] = 1
    set ib_itemNameGbk[432] = "rrom"
    set ib_itemList[433] = 'Rans'
    set ib_itemName[433] = "rans"
    set ib_itemCustom[433] = 1
    set ib_itemNameGbk[433] = "rans"
    set ib_itemList[434] = 'Rcdl'
    set ib_itemName[434] = "rcdl"
    set ib_itemCustom[434] = 1
    set ib_itemNameGbk[434] = "rcdl"
    set ib_itemList[435] = 'Eklm'
    set ib_itemName[435] = "eklm"
    set ib_itemCustom[435] = 1
    set ib_itemNameGbk[435] = "eklm"
    set ib_itemList[436] = 'Cspg'
    set ib_itemName[436] = "cspg"
    set ib_itemCustom[436] = 1
    set ib_itemNameGbk[436] = "cspg"
    set ib_itemList[437] = 'Rshd'
    set ib_itemName[437] = "rshd"
    set ib_itemCustom[437] = 1
    set ib_itemNameGbk[437] = "rshd"
    set ib_itemList[438] = 'Ubbs'
    set ib_itemName[438] = "ubbs"
    set ib_itemCustom[438] = 1
    set ib_itemNameGbk[438] = "ubbs"
    set ib_itemList[439] = 'Ebsw'
    set ib_itemName[439] = "ebsw"
    set ib_itemCustom[439] = 1
    set ib_itemNameGbk[439] = "ebsw"
    set ib_itemList[440] = 'Lcfr'
    set ib_itemName[440] = "lcfr"
    set ib_itemCustom[440] = 1
    set ib_itemNameGbk[440] = "lcfr"
    set ib_itemList[441] = 'Ugoa'
    set ib_itemName[441] = "ugoa"
    set ib_itemCustom[441] = 1
    set ib_itemNameGbk[441] = "ugoa"
    set ib_itemList[442] = 'Rhcc'
    set ib_itemName[442] = "rhcc"
    set ib_itemCustom[442] = 1
    set ib_itemNameGbk[442] = "rhcc"
    set ib_itemList[443] = 'Rnck'
    set ib_itemName[443] = "rnck"
    set ib_itemCustom[443] = 1
    set ib_itemNameGbk[443] = "rnck"
    set ib_itemList[444] = 'Rwgs'
    set ib_itemName[444] = "rwgs"
    set ib_itemCustom[444] = 1
    set ib_itemNameGbk[444] = "rwgs"
    set ib_itemList[445] = 'Rfws'
    set ib_itemName[445] = "rfws"
    set ib_itemCustom[445] = 1
    set ib_itemNameGbk[445] = "rfws"
    set ib_itemList[446] = 'Eclt'
    set ib_itemName[446] = "eclt"
    set ib_itemCustom[446] = 1
    set ib_itemNameGbk[446] = "eclt"
    set ib_itemList[447] = 'Erbs'
    set ib_itemName[447] = "erbs"
    set ib_itemCustom[447] = 1
    set ib_itemNameGbk[447] = "erbs"
    set ib_itemList[448] = 'Rdsi'
    set ib_itemName[448] = "rdsi"
    set ib_itemCustom[448] = 1
    set ib_itemNameGbk[448] = "rdsi"
    set ib_itemList[449] = 'Lkde'
    set ib_itemName[449] = "lkde"
    set ib_itemCustom[449] = 1
    set ib_itemNameGbk[449] = "lkde"
    set ib_itemList[450] = 'Lsrp'
    set ib_itemName[450] = "lsrp"
    set ib_itemCustom[450] = 1
    set ib_itemNameGbk[450] = "lsrp"
    set ib_itemList[451] = 'Udfs'
    set ib_itemName[451] = "udfs"
    set ib_itemCustom[451] = 1
    set ib_itemNameGbk[451] = "udfs"
    set ib_itemList[452] = 'Ustb'
    set ib_itemName[452] = "ustb"
    set ib_itemCustom[452] = 1
    set ib_itemNameGbk[452] = "ustb"
    set ib_itemList[453] = 'Uorc'
    set ib_itemName[453] = "uorc"
    set ib_itemCustom[453] = 1
    set ib_itemNameGbk[453] = "uorc"
    set ib_itemList[454] = 'Uwbd'
    set ib_itemName[454] = "uwbd"
    set ib_itemCustom[454] = 1
    set ib_itemNameGbk[454] = "uwbd"
    set ib_itemList[455] = 'Umbd'
    set ib_itemName[455] = "umbd"
    set ib_itemCustom[455] = 1
    set ib_itemNameGbk[455] = "umbd"
    set ib_itemList[456] = 'Rcol'
    set ib_itemName[456] = "rcol"
    set ib_itemCustom[456] = 1
    set ib_itemNameGbk[456] = "rcol"
    set ib_itemList[457] = 'Ublc'
    set ib_itemName[457] = "ublc"
    set ib_itemCustom[457] = 1
    set ib_itemNameGbk[457] = "ublc"
    set ib_itemList[458] = 'Umgt'
    set ib_itemName[458] = "umgt"
    set ib_itemCustom[458] = 1
    set ib_itemNameGbk[458] = "umgt"
    set ib_itemList[459] = 'Qbdc'
    set ib_itemName[459] = "qbdc"
    set ib_itemCustom[459] = 1
    set ib_itemNameGbk[459] = "qbdc"
    set ib_itemList[460] = 'Esrt'
    set ib_itemName[460] = "esrt"
    set ib_itemCustom[460] = 1
    set ib_itemNameGbk[460] = "esrt"
    set ib_itemList[461] = 'Rbog'
    set ib_itemName[461] = "rbog"
    set ib_itemCustom[461] = 1
    set ib_itemNameGbk[461] = "rbog"
    set ib_itemList[462] = 'Rdgm'
    set ib_itemName[462] = "rdgm"
    set ib_itemCustom[462] = 1
    set ib_itemNameGbk[462] = "rdgm"
    set ib_itemList[463] = 'Qsle'
    set ib_itemName[463] = "qsle"
    set ib_itemCustom[463] = 1
    set ib_itemNameGbk[463] = "qsle"
    set ib_itemList[464] = 'Qwkc'
    set ib_itemName[464] = "qwkc"
    set ib_itemCustom[464] = 1
    set ib_itemNameGbk[464] = "qwkc"
    set ib_itemList[465] = 'Rskh'
    set ib_itemName[465] = "rskh"
    set ib_itemCustom[465] = 1
    set ib_itemNameGbk[465] = "rskh"
    set ib_itemList[466] = 'Rssb'
    set ib_itemName[466] = "rssb"
    set ib_itemCustom[466] = 1
    set ib_itemNameGbk[466] = "rssb"
    set ib_itemList[467] = 'Rfgg'
    set ib_itemName[467] = "rfgg"
    set ib_itemCustom[467] = 1
    set ib_itemNameGbk[467] = "rfgg"
    set ib_itemList[468] = 'Rhap'
    set ib_itemName[468] = "rhap"
    set ib_itemCustom[468] = 1
    set ib_itemNameGbk[468] = "rhap"
    set ib_itemList[469] = 'Rhkt'
    set ib_itemName[469] = "rhkt"
    set ib_itemCustom[469] = 1
    set ib_itemNameGbk[469] = "rhkt"
    set ib_itemList[470] = 'Urov'
    set ib_itemName[470] = "urov"
    set ib_itemCustom[470] = 1
    set ib_itemNameGbk[470] = "urov"
    set ib_itemList[471] = 'Rwrb'
    set ib_itemName[471] = "rwrb"
    set ib_itemCustom[471] = 1
    set ib_itemNameGbk[471] = "rwrb"
    set ib_itemList[472] = 'Rswt'
    set ib_itemName[472] = "rswt"
    set ib_itemCustom[472] = 1
    set ib_itemNameGbk[472] = "rswt"
    set ib_itemList[473] = 'Lblr'
    set ib_itemName[473] = "lblr"
    set ib_itemCustom[473] = 1
    set ib_itemNameGbk[473] = "lblr"
    set ib_itemList[474] = 'Cprt'
    set ib_itemName[474] = "cprt"
    set ib_itemCustom[474] = 1
    set ib_itemNameGbk[474] = "cprt"
    set ib_itemList[475] = 'Rchc'
    set ib_itemName[475] = "rchc"
    set ib_itemCustom[475] = 1
    set ib_itemNameGbk[475] = "rchc"
    set ib_itemList[476] = 'Rpom'
    set ib_itemName[476] = "rpom"
    set ib_itemCustom[476] = 1
    set ib_itemNameGbk[476] = "rpom"
    set ib_itemList[477] = 'RStl'
    set ib_itemName[477] = "é›·å…‹è¨çš„è¡Œå›Š"
    set ib_itemCustom[477] = 1
    set ib_itemNameGbk[477] = "À×¿ËÈøµÄĞĞÄÒ"
    set ib_itemList[478] = 'RoSt'
    set ib_itemName[478] = "ç½—æ±‰çš„è¡Œå›Š"
    set ib_itemCustom[478] = 1
    set ib_itemNameGbk[478] = "ÂŞººµÄĞĞÄÒ"
    set ib_itemList[479] = 'CStl'
    set ib_itemName[479] = "è€é™ˆçš„è¡Œå›Š"
    set ib_itemCustom[479] = 1
    set ib_itemNameGbk[479] = "ÀÏ³ÂµÄĞĞÄÒ"
endfunction
function IB_Fill6 takes nothing returns nothing
    set ib_itemList[480] = 'CrSt'
    set ib_itemName[480] = "å‡¯æ©çš„è¡Œå›Š"
    set ib_itemCustom[480] = 1
    set ib_itemNameGbk[480] = "¿­¶÷µÄĞĞÄÒ"
    set ib_itemList[481] = 'Cchn'
    set ib_itemName[481] = "è½»å‹é”ç”²"
    set ib_itemCustom[481] = 1
    set ib_itemNameGbk[481] = "ÇáĞÍËø¼×"
    set ib_itemList[482] = 'Cpck'
    set ib_itemName[482] = "ç”Ÿé”ˆçš„åå­—é•"
    set ib_itemCustom[482] = 1
    set ib_itemNameGbk[482] = "ÉúĞâµÄÊ®×Ö¸ä"
    set ib_itemList[483] = 'Cgnt'
    set ib_itemName[483] = "é‡çŒªçš®æ‰‹å¥—"
    set ib_itemCustom[483] = 1
    set ib_itemNameGbk[483] = "Ò°ÖíÆ¤ÊÖÌ×"
    set ib_itemList[484] = 'Caxe'
    set ib_itemName[484] = "ç£¨æŸçš„æˆ˜æ–§"
    set ib_itemCustom[484] = 1
    set ib_itemNameGbk[484] = "Ä¥ËğµÄÕ½¸«"
    set ib_itemList[485] = 'Csmb'
    set ib_itemName[485] = "é³ç”²æˆ˜é´"
    set ib_itemCustom[485] = 1
    set ib_itemNameGbk[485] = "ÁÛ¼×Õ½Ñ¥"
    set ib_itemList[486] = 'Cban'
    set ib_itemName[486] = "å­¦å¾’å¤´å·¾"
    set ib_itemCustom[486] = 1
    set ib_itemNameGbk[486] = "Ñ§Í½Í·½í"
    set ib_itemList[487] = 'CrnR'
    set ib_itemName[487] = "æ¢å¤ä¹‹æˆ’"
    set ib_itemCustom[487] = 1
    set ib_itemNameGbk[487] = "»Ö¸´Ö®½ä"
    set ib_itemList[488] = 'CamV'
    set ib_itemName[488] = "æ´»åŠ›æŠ¤èº«ç¬¦"
    set ib_itemCustom[488] = 1
    set ib_itemNameGbk[488] = "»îÁ¦»¤Éí·û"
    set ib_itemList[489] = 'Cbck'
    set ib_itemName[489] = "ç£¨æŸçš„å°åœ†ç›¾"
    set ib_itemCustom[489] = 1
    set ib_itemNameGbk[489] = "Ä¥ËğµÄĞ¡Ô²¶Ü"
    set ib_itemList[490] = 'Cshs'
    set ib_itemName[490] = "æš—å½±éª·é«…"
    set ib_itemCustom[490] = 1
    set ib_itemNameGbk[490] = "°µÓ°÷¼÷Ã"
    set ib_itemList[491] = 'Cvst'
    set ib_itemName[491] = "æ¸¸ç‰§èƒŒå¿ƒ"
    set ib_itemCustom[491] = 1
    set ib_itemNameGbk[491] = "ÓÎÄÁ±³ĞÄ"
    set ib_itemList[492] = 'Clmw'
    set ib_itemName[492] = "æ¬¡çº§é­”æ–"
    set ib_itemCustom[492] = 1
    set ib_itemNameGbk[492] = "´Î¼¶Ä§ÕÈ"
    set ib_itemList[493] = 'Urwv'
    set ib_itemName[493] = "é—ªé¿ä¹‹æˆ’"
    set ib_itemCustom[493] = 1
    set ib_itemNameGbk[493] = "ÉÁ±ÜÖ®½ä"
    set ib_itemList[494] = 'Cwtb'
    set ib_itemName[494] = "ç ´æ—§çš„ç›—è´¼ä¹‹é´"
    set ib_itemCustom[494] = 1
    set ib_itemNameGbk[494] = "ÆÆ¾ÉµÄµÁÔôÖ®Ñ¥"
    set ib_itemList[495] = 'Uwba'
    set ib_itemName[495] = "æˆ˜æ­Œæˆ˜æ–§"
    set ib_itemCustom[495] = 1
    set ib_itemNameGbk[495] = "Õ½¸èÕ½¸«"
    set ib_itemList[496] = 'Rsst'
    set ib_itemName[496] = "ç¥åœ£è¨æ»¡å›¾è…¾"
    set ib_itemCustom[496] = 1
    set ib_itemNameGbk[496] = "ÉñÊ¥ÈøÂúÍ¼ÌÚ"
    set ib_itemList[497] = 'Ushc'
    set ib_itemName[497] = "è¨æ»¡ä¹‹çˆª"
    set ib_itemCustom[497] = 1
    set ib_itemNameGbk[497] = "ÈøÂúÖ®×¦"
    set ib_itemList[498] = 'Ckoa'
    set ib_itemName[498] = "ä¸€æ¡¶éº¦èŠ½é…’"
    set ib_itemCustom[498] = 1
    set ib_itemNameGbk[498] = "Ò»Í°ÂóÑ¿¾Æ"
    set ib_itemList[499] = 'Ubvm'
    set ib_itemName[499] = "å¤§å·«æ¯’é¢å…·"
    set ib_itemCustom[499] = 1
    set ib_itemNameGbk[499] = "´óÎ×¶¾Ãæ¾ß"
    set ib_itemList[500] = 'UpoF'
    set ib_itemName[500] = "èƒ½é‡å®ç ï¼šçƒˆç«"
    set ib_itemCustom[500] = 1
    set ib_itemNameGbk[500] = "ÄÜÁ¿±¦Öé£ºÁÒ»ğ"
    set ib_itemList[501] = 'Ucrs'
    set ib_itemName[501] = "ç‰§å¸ˆä¹‹æ–"
    set ib_itemCustom[501] = 1
    set ib_itemNameGbk[501] = "ÄÁÊ¦Ö®ÕÈ"
    set ib_itemList[502] = 'Rsoh'
    set ib_itemName[502] = "è£èª‰ä¹‹ç›¾"
    set ib_itemCustom[502] = 1
    set ib_itemNameGbk[502] = "ÈÙÓşÖ®¶Ü"
    set ib_itemList[503] = 'Usng'
    set ib_itemName[503] = "å“¨å…µç›¾ç‰Œ"
    set ib_itemCustom[503] = 1
    set ib_itemNameGbk[503] = "ÉÚ±ø¶ÜÅÆ"
    set ib_itemList[504] = 'Crfa'
    set ib_itemName[504] = "å¹¸è¿å†’é™©å®¶ä¹‹æˆ’"
    set ib_itemCustom[504] = 1
    set ib_itemNameGbk[504] = "ĞÒÔËÃ°ÏÕ¼ÒÖ®½ä"
    set ib_itemList[505] = 'Uboh'
    set ib_itemName[505] = "åŠ é€Ÿæˆ˜é´"
    set ib_itemCustom[505] = 1
    set ib_itemNameGbk[505] = "¼ÓËÙÕ½Ñ¥"
    set ib_itemList[506] = 'Rars'
    set ib_itemName[506] = "å¥¥é‡‘ä¹‹ç›¾"
    set ib_itemCustom[506] = 1
    set ib_itemNameGbk[506] = "°Â½ğÖ®¶Ü"
    set ib_itemList[507] = 'Romb'
    set ib_itemName[507] = "åä¸½ç§˜é“¶èƒ¸ç”²"
    set ib_itemCustom[507] = 1
    set ib_itemNameGbk[507] = "»ªÀöÃØÒøĞØ¼×"
    set ib_itemList[508] = 'Rfhg'
    set ib_itemName[508] = "çƒˆç„°ä¹‹æ‰‹"
    set ib_itemCustom[508] = 1
    set ib_itemNameGbk[508] = "ÁÒÑæÖ®ÊÖ"
    set ib_itemList[509] = 'Upol'
    set ib_itemName[509] = "èƒ½é‡å®ç ï¼šé—ªç”µ"
    set ib_itemCustom[509] = 1
    set ib_itemNameGbk[509] = "ÄÜÁ¿±¦Öé£ºÉÁµç"
    set ib_itemList[510] = 'Urrp'
    set ib_itemName[510] = "èƒ½é‡çº¢å®çŸ³ä¹‹æˆ’"
    set ib_itemCustom[510] = 1
    set ib_itemNameGbk[510] = "ÄÜÁ¿ºì±¦Ê¯Ö®½ä"
    set ib_itemList[511] = 'Umgr'
    set ib_itemName[511] = "é­”å¯¼å¸ˆä¹‹æˆ’"
    set ib_itemCustom[511] = 1
    set ib_itemNameGbk[511] = "Ä§µ¼Ê¦Ö®½ä"
    set ib_itemList[512] = 'Cptb'
    set ib_itemName[512] = "å°å·çš„çŸ­åˆƒ"
    set ib_itemCustom[512] = 1
    set ib_itemNameGbk[512] = "Ğ¡ÍµµÄ¶ÌÈĞ"
    set ib_itemList[513] = 'Udwt'
    set ib_itemName[513] = "æš—ç»‡ä¹‹é´"
    set ib_itemCustom[513] = 1
    set ib_itemNameGbk[513] = "°µÖ¯Ö®Ñ¥"
    set ib_itemList[514] = 'Uhob'
    set ib_itemName[514] = "è¡€ç¾½ä¹‹å¿ƒ"
    set ib_itemCustom[514] = 1
    set ib_itemNameGbk[514] = "ÑªÓğÖ®ĞÄ"
    set ib_itemList[515] = 'Usch'
    set ib_itemName[515] = "å·«å¸ˆä¹‹å¸½"
    set ib_itemCustom[515] = 1
    set ib_itemNameGbk[515] = "Î×Ê¦Ö®Ã±"
    set ib_itemList[516] = 'Rsag'
    set ib_itemName[516] = "é¦–å¸­åœ°è„‰æ³•å¸ˆä¹‹æ–"
    set ib_itemCustom[516] = 1
    set ib_itemNameGbk[516] = "Ê×Ï¯µØÂö·¨Ê¦Ö®ÕÈ"
    set ib_itemList[517] = 'Rsoa'
    set ib_itemName[517] = "å¤§æ³•å¸ˆä¹‹æ–"
    set ib_itemCustom[517] = 1
    set ib_itemNameGbk[517] = "´ó·¨Ê¦Ö®ÕÈ"
    set ib_itemList[518] = 'Ucop'
    set ib_itemName[518] = "èƒ½é‡ä¹‹å† "
    set ib_itemCustom[518] = 1
    set ib_itemNameGbk[518] = "ÄÜÁ¿Ö®¹Ú"
    set ib_itemList[519] = 'Upov'
    set ib_itemName[519] = "èƒ½é‡å®ç ï¼šå‰§æ¯’"
    set ib_itemCustom[519] = 1
    set ib_itemNameGbk[519] = "ÄÜÁ¿±¦Öé£º¾ç¶¾"
    set ib_itemList[520] = 'Urcg'
    set ib_itemName[520] = "é’¢èƒŒå¬çµè€…æ‰‹å¥—"
    set ib_itemCustom[520] = 1
    set ib_itemNameGbk[520] = "¸Ö±³ÕÙÁéÕßÊÖÌ×"
    set ib_itemList[521] = 'Usrg'
    set ib_itemName[521] = "è‰åŸå·¡æ—è€…æ‰‹å¥—"
    set ib_itemCustom[521] = 1
    set ib_itemNameGbk[521] = "²İÔ­Ñ²ÁÖÕßÊÖÌ×"
    set ib_itemList[522] = 'Uads'
    set ib_itemName[522] = "å¾·é²ä¼Šå­¦å¾’æ³•æ–"
    set ib_itemCustom[522] = 1
    set ib_itemNameGbk[522] = "µÂÂ³ÒÁÑ§Í½·¨ÕÈ"
    set ib_itemList[523] = 'Utcv'
    set ib_itemName[523] = "è¿½è¸ªè€…èƒŒå¿ƒ"
    set ib_itemCustom[523] = 1
    set ib_itemNameGbk[523] = "×·×ÙÕß±³ĞÄ"
    set ib_itemList[524] = 'Rbtb'
    set ib_itemName[524] = "è¡€è¹„æˆ˜å›¾è…¾"
    set ib_itemCustom[524] = 1
    set ib_itemNameGbk[524] = "ÑªÌãÕ½Í¼ÌÚ"
    set ib_itemList[525] = 'Ursf'
    set ib_itemName[525] = "ç£çŸ³åˆšæ¯…ä¹‹æˆ’"
    set ib_itemCustom[525] = 1
    set ib_itemNameGbk[525] = "ÅÍÊ¯¸ÕÒãÖ®½ä"
    set ib_itemList[526] = 'Rthd'
    set ib_itemName[526] = "é›·éœ†èœ¥èœ´é’»çŸ³"
    set ib_itemCustom[526] = 1
    set ib_itemNameGbk[526] = "À×öªòáòæ×êÊ¯"
    set ib_itemList[527] = 'Rdtb'
    set ib_itemName[527] = "å¾·é›·å…‹å¡”å°”çš„æ³•æœ¯ä¹¦"
    set ib_itemCustom[527] = 1
    set ib_itemNameGbk[527] = "µÂÀ×¿ËËş¶ûµÄ·¨ÊõÊé"
    set ib_itemList[528] = 'Upos'
    set ib_itemName[528] = "èƒ½é‡å®ç ï¼šå‡é€Ÿ"
    set ib_itemCustom[528] = 1
    set ib_itemNameGbk[528] = "ÄÜÁ¿±¦Öé£º¼õËÙ"
    set ib_itemList[529] = 'Croe'
    set ib_itemName[529] = "èƒ½é‡ä¹‹æˆ’"
    set ib_itemCustom[529] = 1
    set ib_itemNameGbk[529] = "ÄÜÁ¿Ö®½ä"
    set ib_itemList[530] = 'Urng'
    set ib_itemName[530] = "ç¬¦æ–‡æ‰‹å¥—"
    set ib_itemCustom[530] = 1
    set ib_itemNameGbk[530] = "·ûÎÄÊÖÌ×"
    set ib_itemList[531] = 'Rrom'
    set ib_itemName[531] = "æ³•å¸ˆé•¿è¢"
    set ib_itemCustom[531] = 1
    set ib_itemNameGbk[531] = "·¨Ê¦³¤ÅÛ"
    set ib_itemList[532] = 'Rans'
    set ib_itemName[532] = "å·«åŒ»ä¹‹æ–"
    set ib_itemCustom[532] = 1
    set ib_itemNameGbk[532] = "Î×Ò½Ö®ÕÈ"
    set ib_itemList[533] = 'Rcdl'
    set ib_itemName[533] = "æ­»äº¡é¢†ä¸»ä¹‹å† "
    set ib_itemCustom[533] = 1
    set ib_itemNameGbk[533] = "ËÀÍöÁìÖ÷Ö®¹Ú"
    set ib_itemList[534] = 'Eklm'
    set ib_itemName[534] = "æ®‹æ€ä¹‹åˆƒ"
    set ib_itemCustom[534] = 1
    set ib_itemNameGbk[534] = "²ĞÉ±Ö®ÈĞ"
    set ib_itemList[535] = 'Cspg'
    set ib_itemName[535] = "æ³•æœ¯å¼ºåº¦æŠ¤ç›®é•œ"
    set ib_itemCustom[535] = 1
    set ib_itemNameGbk[535] = "·¨ÊõÇ¿¶È»¤Ä¿¾µ"
    set ib_itemList[536] = 'Rshd'
    set ib_itemName[536] = "æ­»äº¡é¢†ä¸»ä¹‹ç›¾"
    set ib_itemCustom[536] = 1
    set ib_itemNameGbk[536] = "ËÀÍöÁìÖ÷Ö®¶Ü"
    set ib_itemList[537] = 'Ubbs'
    set ib_itemName[537] = "å¼ºç›—çš„é˜”å‰‘"
    set ib_itemCustom[537] = 1
    set ib_itemNameGbk[537] = "Ç¿µÁµÄÀ«½£"
    set ib_itemList[538] = 'Ebsw'
    set ib_itemName[538] = "æµ·å¦–ä¹‹å¼“"
    set ib_itemCustom[538] = 1
    set ib_itemNameGbk[538] = "º£ÑıÖ®¹­"
    set ib_itemList[539] = 'Lcfr'
    set ib_itemName[539] = "è¾›è¥¿å¨…çš„ä¼ å®¶æˆ’æŒ‡"
    set ib_itemCustom[539] = 1
    set ib_itemNameGbk[539] = "ĞÁÎ÷æ«µÄ´«¼Ò½äÖ¸"
    set ib_itemList[540] = 'Ugoa'
    set ib_itemName[540] = "ç«æŠ€åœºæ‰‹å¥—"
    set ib_itemCustom[540] = 1
    set ib_itemNameGbk[540] = "¾º¼¼³¡ÊÖÌ×"
    set ib_itemList[541] = 'Rnck'
    set ib_itemName[541] = "æ”¾é€æ³•æœ¯é¡¹é“¾"
    set ib_itemCustom[541] = 1
    set ib_itemNameGbk[541] = "·ÅÖğ·¨ÊõÏîÁ´"
    set ib_itemList[542] = 'Rwgs'
    set ib_itemName[542] = "ç ´æ—§å·¨å‰‘"
    set ib_itemCustom[542] = 1
    set ib_itemNameGbk[542] = "ÆÆ¾É¾Ş½£"
    set ib_itemList[543] = 'Rfws'
    set ib_itemName[543] = "å†°éœœå·¨é¾™é¢…éª¨ç›¾ç‰Œ"
    set ib_itemCustom[543] = 1
    set ib_itemNameGbk[543] = "±ùËª¾ŞÁúÂ­¹Ç¶ÜÅÆ"
    set ib_itemList[544] = 'Eclt'
    set ib_itemName[544] = "å¡”ä¼¦è¾¾å°”é¢†ä¸»ä¹‹å† "
    set ib_itemCustom[544] = 1
    set ib_itemNameGbk[544] = "ËşÂ×´ï¶ûÁìÖ÷Ö®¹Ú"
    set ib_itemList[545] = 'Erbs'
    set ib_itemName[545] = "ç‡ƒé­‚ä¹‹æˆ’"
    set ib_itemCustom[545] = 1
    set ib_itemNameGbk[545] = "È¼»êÖ®½ä"
    set ib_itemList[546] = 'OgBS'
    set ib_itemName[546] = "å¥¥æ ¼ç‘ç›æˆ˜æ——"
    set ib_itemCustom[546] = 1
    set ib_itemNameGbk[546] = "°Â¸ñÈğÂêÕ½Æì"
    set ib_itemList[547] = 'Rdsi'
    set ib_itemName[547] = "æš—çŸ›å¾½è®°"
    set ib_itemCustom[547] = 1
    set ib_itemNameGbk[547] = "°µÃ¬»Õ¼Ç"
    set ib_itemList[548] = 'Lkde'
    set ib_itemName[548] = "æŸ¯å°”æ©çš„é€ƒè„±åŒ•é¦–"
    set ib_itemCustom[548] = 1
    set ib_itemNameGbk[548] = "¿Â¶û¶÷µÄÌÓÍÑØ°Ê×"
    set ib_itemList[549] = 'Lsrp'
    set ib_itemName[549] = "é˜¿æ–¯é‡Œå…‹å¸çš„èƒ½é‡ä¹‹æˆ’"
    set ib_itemCustom[549] = 1
    set ib_itemNameGbk[549] = "°¢Ë¹Àï¿ËË¾µÄÄÜÁ¿Ö®½ä"
    set ib_itemList[550] = 'Udfs'
    set ib_itemName[550] = "å‡¹é™·çš„æ­¥å…µç›¾ç‰Œ"
    set ib_itemCustom[550] = 1
    set ib_itemNameGbk[550] = "°¼ÏİµÄ²½±ø¶ÜÅÆ"
    set ib_itemList[551] = 'Ustb'
    set ib_itemName[551] = "æµ·æ´‹éœ¸ä¸»èƒ¸ç”²"
    set ib_itemCustom[551] = 1
    set ib_itemNameGbk[551] = "º£Ñó°ÔÖ÷ĞØ¼×"
    set ib_itemList[552] = 'Uorc'
    set ib_itemName[552] = "èƒ½é‡å®ç ï¼šå†°éœœ"
    set ib_itemCustom[552] = 1
    set ib_itemNameGbk[552] = "ÄÜÁ¿±¦Öé£º±ùËª"
    set ib_itemList[553] = 'Uwbd'
    set ib_itemName[553] = "æˆ˜æ­Œæˆ˜é¼“"
    set ib_itemCustom[553] = 1
    set ib_itemNameGbk[553] = "Õ½¸èÕ½¹Ä"
    set ib_itemList[554] = 'Umbd'
    set ib_itemName[554] = "é¥®è¡€è€…é¢å…·"
    set ib_itemCustom[554] = 1
    set ib_itemNameGbk[554] = "ÒûÑªÕßÃæ¾ß"
    set ib_itemList[555] = 'Rcol'
    set ib_itemName[555] = "é¾™è™¾äººä¹‹çˆª"
    set ib_itemCustom[555] = 1
    set ib_itemNameGbk[555] = "ÁúÏºÈËÖ®×¦"
    set ib_itemList[556] = 'Ublc'
    set ib_itemName[556] = "æ´›ä¸¹ä¼¦é˜Ÿé•¿èƒ¸ç”²"
    set ib_itemCustom[556] = 1
    set ib_itemNameGbk[556] = "Âåµ¤Â×¶Ó³¤ĞØ¼×"
    set ib_itemList[557] = 'Umgt'
    set ib_itemName[557] = "è«é«˜é›·å›¾è…¾"
    set ib_itemCustom[557] = 1
    set ib_itemNameGbk[557] = "Äª¸ßÀ×Í¼ÌÚ"
    set ib_itemList[558] = 'Qbdc'
    set ib_itemName[558] = "é»‘é¾™é³ç‰‡"
    set ib_itemCustom[558] = 1
    set ib_itemNameGbk[558] = "ºÚÁúÁÛÆ¬"
    set ib_itemList[559] = 'Esrt'
    set ib_itemName[559] = "å¡æ‹‰å¸Œå°”"
    set ib_itemCustom[559] = 1
    set ib_itemNameGbk[559] = "ÈûÀ­Ï£¶û"
endfunction
function IB_Fill7 takes nothing returns nothing
    set ib_itemList[560] = 'Rbog'
    set ib_itemName[560] = "ä¸¥é…·è¯•ç‚¼æˆ˜é´"
    set ib_itemCustom[560] = 1
    set ib_itemNameGbk[560] = "ÑÏ¿áÊÔÁ¶Õ½Ñ¥"
    set ib_itemList[561] = 'Rdgm'
    set ib_itemName[561] = "æ¶é­”é­”å…¸"
    set ib_itemCustom[561] = 1
    set ib_itemNameGbk[561] = "¶ñÄ§Ä§µä"
    set ib_itemList[562] = 'Qsle'
    set ib_itemName[562] = "é£æš´é¢†ä¸»ä¹‹çœ¼"
    set ib_itemCustom[562] = 1
    set ib_itemNameGbk[562] = "·ç±©ÁìÖ÷Ö®ÑÛ"
    set ib_itemList[563] = 'Qwkc'
    set ib_itemName[563] = "ç‹‚æš´æ­å…½ä¹‹çˆª"
    set ib_itemCustom[563] = 1
    set ib_itemNameGbk[563] = "¿ñ±©èÉÊŞÖ®×¦"
    set ib_itemList[564] = 'Rskh'
    set ib_itemName[564] = "ç²‰ç¢è€…çš„ç¡¬å£³"
    set ib_itemCustom[564] = 1
    set ib_itemNameGbk[564] = "·ÛËéÕßµÄÓ²¿Ç"
    set ib_itemList[565] = 'Rssb'
    set ib_itemName[565] = "å½±é’¢æŠ¤è…•"
    set ib_itemCustom[565] = 1
    set ib_itemNameGbk[565] = "Ó°¸Ö»¤Íó"
    set ib_itemList[566] = 'Rfgg'
    set ib_itemName[566] = "çƒˆç„°å®ˆå«æ‰‹å¥—"
    set ib_itemCustom[566] = 1
    set ib_itemNameGbk[566] = "ÁÒÑæÊØÎÀÊÖÌ×"
    set ib_itemList[567] = 'Rhap'
    set ib_itemName[567] = "è›®é”¤é¹°å·¢å±±æˆ˜é”¤"
    set ib_itemCustom[567] = 1
    set ib_itemNameGbk[567] = "Âù´¸Ó¥³²É½Õ½´¸"
    set ib_itemList[568] = 'Rhkt'
    set ib_itemName[568] = "è‚¯ç‘æ‰˜å…œå¸½"
    set ib_itemCustom[568] = 1
    set ib_itemNameGbk[568] = "¿ÏÈğÍĞ¶µÃ±"
    set ib_itemList[569] = 'Urov'
    set ib_itemName[569] = "æ´»åŠ›ä¹‹æˆ’"
    set ib_itemCustom[569] = 1
    set ib_itemNameGbk[569] = "»îÁ¦Ö®½ä"
    set ib_itemList[570] = 'Rwrb'
    set ib_itemName[570] = "æˆ˜äº‰ç‹¼éª‘å…µæ¿ç”²"
    set ib_itemCustom[570] = 1
    set ib_itemNameGbk[570] = "Õ½ÕùÀÇÆï±ø°å¼×"
    set ib_itemList[571] = 'Rswt'
    set ib_itemName[571] = "è¿…æ·æ–¥å€™çš®ç”²"
    set ib_itemCustom[571] = 1
    set ib_itemNameGbk[571] = "Ñ¸½İ³âºòÆ¤¼×"
    set ib_itemList[572] = 'Lblr'
    set ib_itemName[572] = "é‡‘å…‰é—ªé—ªä¹‹æˆ’"
    set ib_itemCustom[572] = 1
    set ib_itemNameGbk[572] = "½ğ¹âÉÁÉÁÖ®½ä"
    set ib_itemList[573] = 'Cprt'
    set ib_itemName[573] = "å‡€åŒ–å›¾è…¾"
    set ib_itemCustom[573] = 1
    set ib_itemNameGbk[573] = "¾»»¯Í¼ÌÚ"
    set ib_itemList[574] = 'Rchc'
    set ib_itemName[574] = "ä¸Šå°‰çš„å‹‡æ°”å¤´ç›”"
    set ib_itemCustom[574] = 1
    set ib_itemNameGbk[574] = "ÉÏÎ¾µÄÓÂÆøÍ·¿ø"
    set ib_itemList[575] = 'Rpom'
    set ib_itemName[575] = "èƒ½é‡å®ç ï¼šç¥è¯"
    set ib_itemCustom[575] = 1
    set ib_itemNameGbk[575] = "ÄÜÁ¿±¦Öé£ºÉñ»°"
    set ib_itemList[576] = 'I000'
    set ib_itemName[576] = "ç«ç„°æ‰‹å¥—"
    set ib_itemCustom[576] = 1
    set ib_itemNameGbk[576] = "»ğÑæÊÖÌ×"
    set ib_itemList[577] = 'I001'
    set ib_itemName[577] = "èŠ’ç¡æŠ¤ç›¾"
    set ib_itemCustom[577] = 1
    set ib_itemNameGbk[577] = "Ã¢Ïõ»¤¶Ü"
    set ib_itemList[578] = 'I002'
    set ib_itemName[578] = "å‰‘åˆƒæŠ¤ç”²"
    set ib_itemCustom[578] = 1
    set ib_itemNameGbk[578] = "½£ÈĞ»¤¼×"
    set ib_itemList[579] = 'I002'
    set ib_itemName[579] = "åä¸½ç§˜é“¶èƒ¸ç”²"
    set ib_itemCustom[579] = 1
    set ib_itemNameGbk[579] = "»ªÀöÃØÒøĞØ¼×"
    set ib_itemList[580] = 'I003'
    set ib_itemName[580] = "é›·éœ†æ°´æ¡¶"
    set ib_itemCustom[580] = 1
    set ib_itemNameGbk[580] = "À×öªË®Í°"
    set ib_itemList[581] = 'I004'
    set ib_itemName[581] = "é›·éœ†æ°´æ¡¶"
    set ib_itemCustom[581] = 1
    set ib_itemNameGbk[581] = "À×öªË®Í°"
    set ib_itemList[582] = 'I005'
    set ib_itemName[582] = "é›·éœ†æ°´æ¡¶"
    set ib_itemCustom[582] = 1
    set ib_itemNameGbk[582] = "À×öªË®Í°"
    set ib_itemList[583] = 'I006'
    set ib_itemName[583] = "é›·éœ†æ°´æ¡¶"
    set ib_itemCustom[583] = 1
    set ib_itemNameGbk[583] = "À×öªË®Í°"
    set ib_itemList[584] = 'I007'
    set ib_itemName[584] = "é›·éœ†æ°´æ¡¶"
    set ib_itemCustom[584] = 1
    set ib_itemNameGbk[584] = "À×öªË®Í°"
    set ib_itemList[585] = 'I003'
    set ib_itemName[585] = "ä¸ç¨³å®šè¯å‰‚"
    set ib_itemCustom[585] = 1
    set ib_itemNameGbk[585] = "²»ÎÈ¶¨Ò©¼Á"
    set ib_itemList[586] = 'I004'
    set ib_itemName[586] = "ä¸ç¨³å®šè¯å‰‚"
    set ib_itemCustom[586] = 1
    set ib_itemNameGbk[586] = "²»ÎÈ¶¨Ò©¼Á"
    set ib_itemList[587] = 'I005'
    set ib_itemName[587] = "ä¸ç¨³å®šè¯å‰‚"
    set ib_itemCustom[587] = 1
    set ib_itemNameGbk[587] = "²»ÎÈ¶¨Ò©¼Á"
    set ib_itemList[588] = 'I006'
    set ib_itemName[588] = "ä¸ç¨³å®šè¯å‰‚"
    set ib_itemCustom[588] = 1
    set ib_itemNameGbk[588] = "²»ÎÈ¶¨Ò©¼Á"
    set ib_itemList[589] = 'I007'
    set ib_itemName[589] = "ä¸ç¨³å®šè¯å‰‚"
    set ib_itemCustom[589] = 1
    set ib_itemNameGbk[589] = "²»ÎÈ¶¨Ò©¼Á"
    set ib_itemList[590] = 'Qgtk'
    set ib_itemName[590] = "qgtk"
    set ib_itemCustom[590] = 1
    set ib_itemNameGbk[590] = "qgtk"
    set ib_itemList[591] = 'Qgtk'
    set ib_itemName[591] = "å¤§é—¨é’¥åŒ™"
    set ib_itemCustom[591] = 1
    set ib_itemNameGbk[591] = "´óÃÅÔ¿³×"
    set ib_itemList[592] = 'I004'
    set ib_itemName[592] = "é‡æ€§æŠ¤ç¬¦"
    set ib_itemCustom[592] = 1
    set ib_itemNameGbk[592] = "Ò°ĞÔ»¤·û"
    set ib_itemList[593] = 'I005'
    set ib_itemName[593] = "é‡æ€§æŠ¤ç¬¦"
    set ib_itemCustom[593] = 1
    set ib_itemNameGbk[593] = "Ò°ĞÔ»¤·û"
    set ib_itemList[594] = 'I008'
    set ib_itemName[594] = "å¹»è±¡æƒæ–"
    set ib_itemCustom[594] = 1
    set ib_itemNameGbk[594] = "»ÃÏóÈ¨ÕÈ"
    set ib_itemList[595] = 'I004'
    set ib_itemName[595] = "é‡æ€§ç¬¦æ–‡"
    set ib_itemCustom[595] = 1
    set ib_itemNameGbk[595] = "Ò°ĞÔ·ûÎÄ"
    set ib_itemList[596] = 'I005'
    set ib_itemName[596] = "å²©çŸ³å‚€å„¡ç¬¦æ–‡"
    set ib_itemCustom[596] = 1
    set ib_itemNameGbk[596] = "ÑÒÊ¯¿şÀÜ·ûÎÄ"
    set ib_itemList[597] = 'I008'
    set ib_itemName[597] = "å¹»è±¡ç¬¦æ–‡"
    set ib_itemCustom[597] = 1
    set ib_itemNameGbk[597] = "»ÃÏó·ûÎÄ"
    set ib_itemList[598] = 'I003'
    set ib_itemName[598] = "é‡‘å¸"
    set ib_itemCustom[598] = 1
    set ib_itemNameGbk[598] = "½ğ±Ò"
    set ib_itemList[599] = 'I003'
    set ib_itemName[599] = "æµ·ç›—æˆ˜åˆ©å“"
    set ib_itemCustom[599] = 1
    set ib_itemNameGbk[599] = "º£µÁÕ½ÀûÆ·"
    set ib_itemList[600] = 'I003'
    set ib_itemName[600] = "å¾·é›·å…‹è¨å°”é­”æ³•ä¹¦"
    set ib_itemCustom[600] = 1
    set ib_itemNameGbk[600] = "µÂÀ×¿ËÈø¶ûÄ§·¨Êé"
    set ib_itemList[601] = 'I004'
    set ib_itemName[601] = "çŸ¥è¯†ä¹‹ä¹¦"
    set ib_itemCustom[601] = 1
    set ib_itemNameGbk[601] = "ÖªÊ¶Ö®Êé"
    set ib_itemList[602] = 'I005'
    set ib_itemName[602] = "é­”æ³•å‚é¥°"
    set ib_itemCustom[602] = 1
    set ib_itemNameGbk[602] = "Ä§·¨´¹ÊÎ"
    set ib_itemList[603] = 'I006'
    set ib_itemName[603] = "å¤§é­”æ³•å¸ˆæŒ‡ç¯"
    set ib_itemCustom[603] = 1
    set ib_itemNameGbk[603] = "´óÄ§·¨Ê¦Ö¸»·"
    set ib_itemList[604] = 'I007'
    set ib_itemName[604] = "ç»Ÿæ²»æƒæ–"
    set ib_itemCustom[604] = 1
    set ib_itemNameGbk[604] = "Í³ÖÎÈ¨ÕÈ"
    set ib_itemList[605] = 'I003'
    set ib_itemName[605] = "å›åŸä¹‹ä¹¦"
    set ib_itemCustom[605] = 1
    set ib_itemNameGbk[605] = "»Ø³ÇÖ®Êé"
    set ib_itemList[606] = 'I004'
    set ib_itemName[606] = "ç¦æ–­çŸ¥è¯†ä¹‹ä¹¦"
    set ib_itemCustom[606] = 1
    set ib_itemNameGbk[606] = "½û¶ÏÖªÊ¶Ö®Êé"
    set ib_itemList[607] = 'I005'
    set ib_itemName[607] = "æ³°å¦çŸ³é¡¹é“¾"
    set ib_itemCustom[607] = 1
    set ib_itemNameGbk[607] = "Ì©Ì¹Ê¯ÏîÁ´"
    set ib_itemList[608] = 'I006'
    set ib_itemName[608] = "é˜¿æ–¯é‡Œå…‹å¸çš„èƒ½é‡ä¹‹æˆ’"
    set ib_itemCustom[608] = 1
    set ib_itemNameGbk[608] = "°¢Ë¹Àï¿ËË¾µÄÄÜÁ¿Ö®½ä"
    set ib_itemList[609] = 'I007'
    set ib_itemName[609] = "é‡‘å…‰é—ªé—ªä¹‹æˆ’"
    set ib_itemCustom[609] = 1
    set ib_itemNameGbk[609] = "½ğ¹âÉÁÉÁÖ®½ä"
endfunction

function IB_SkillFill0 takes nothing returns nothing
    set ib_skillList[0] = 'A100'
    set ib_skillName[0] = "æ­»äº¡ä¹‹æŒ‡"
    set ib_skillCustom[0] = 1
    set ib_skillList[1] = 'A101'
    set ib_skillName[1] = "é˜¿å…‹è’™å¾·ä¹‹åŠ›"
    set ib_skillCustom[1] = 1
    set ib_skillList[2] = 'A102'
    set ib_skillName[2] = "æ”»å‡»é€Ÿåº¦åŠ æˆ"
    set ib_skillCustom[2] = 1
    set ib_skillList[3] = 'AAns'
    set ib_skillName[3] = "æ”¶è´¹"
    set ib_skillCustom[3] = 0
    set ib_skillList[4] = 'ACac'
    set ib_skillName[4] = "å‘½ä»¤å…‰ç¯"
    set ib_skillCustom[4] = 0
    set ib_skillList[5] = 'ACad'
    set ib_skillName[5] = "æ“çºµæ­»å°¸"
    set ib_skillCustom[5] = 0
    set ib_skillList[6] = 'ACah'
    set ib_skillName[6] = "è†æ£˜å…‰ç¯"
    set ib_skillCustom[6] = 0
    set ib_skillList[7] = 'ACam'
    set ib_skillName[7] = "åé­”æ³•å¤–å£³"
    set ib_skillCustom[7] = 0
    set ib_skillList[8] = 'ACat'
    set ib_skillName[8] = "å¼ºå‡»å…‰ç¯"
    set ib_skillCustom[8] = 0
    set ib_skillList[9] = 'ACav'
    set ib_skillName[9] = "ä¸“æ³¨å…‰ç¯"
    set ib_skillCustom[9] = 0
    set ib_skillList[10] = 'ACba'
    set ib_skillName[10] = "è¾‰ç…Œå…‰ç¯"
    set ib_skillCustom[10] = 0
    set ib_skillList[11] = 'ACbb'
    set ib_skillName[11] = "å—œè¡€æœ¯"
    set ib_skillCustom[11] = 0
    set ib_skillList[12] = 'ACbc'
    set ib_skillName[12] = "ç«ç„°å‘¼å¸"
    set ib_skillCustom[12] = 0
    set ib_skillList[13] = 'ACbf'
    set ib_skillName[13] = "éœœå†»é—ªç”µ"
    set ib_skillCustom[13] = 0
    set ib_skillList[14] = 'ACbh'
    set ib_skillName[14] = "é‡å‡»"
    set ib_skillCustom[14] = 0
    set ib_skillList[15] = 'ACbk'
    set ib_skillName[15] = "é»‘æš—ä¹‹ç®­"
    set ib_skillCustom[15] = 0
    set ib_skillList[16] = 'ACbl'
    set ib_skillName[16] = "å—œè¡€æœ¯"
    set ib_skillCustom[16] = 0
    set ib_skillList[17] = 'ACbn'
    set ib_skillName[17] = "é©±æ•£"
    set ib_skillCustom[17] = 0
    set ib_skillList[18] = 'ACbr'
    set ib_skillName[18] = "ç‹‚æš´æ„¤æ€’"
    set ib_skillCustom[18] = 0
    set ib_skillList[19] = 'ACbz'
    set ib_skillName[19] = "æš´é£é›ª"
    set ib_skillCustom[19] = 0
    set ib_skillList[20] = 'ACc2'
    set ib_skillName[20] = "å†²å‡»æ³¢"
    set ib_skillCustom[20] = 0
    set ib_skillList[21] = 'ACc3'
    set ib_skillName[21] = "å†²å‡»æ³¢"
    set ib_skillCustom[21] = 0
    set ib_skillList[22] = 'ACca'
    set ib_skillName[22] = "è…è‡­èœ‚ç¾¤"
    set ib_skillCustom[22] = 0
    set ib_skillList[23] = 'ACcb'
    set ib_skillName[23] = "éœœå†»é—ªç”µ"
    set ib_skillCustom[23] = 0
    set ib_skillList[24] = 'ACce'
    set ib_skillName[24] = "åˆ†è£‚æ”»å‡»"
    set ib_skillCustom[24] = 0
    set ib_skillList[25] = 'ACch'
    set ib_skillName[25] = "ç¬¦å’’"
    set ib_skillCustom[25] = 0
    set ib_skillList[26] = 'ACcl'
    set ib_skillName[26] = "é—ªç”µé“¾"
    set ib_skillCustom[26] = 0
    set ib_skillList[27] = 'ACcn'
    set ib_skillName[27] = "åé£Ÿå°¸ä½“"
    set ib_skillCustom[27] = 0
    set ib_skillList[28] = 'ACcr'
    set ib_skillName[28] = "æ®‹åºŸ"
    set ib_skillCustom[28] = 0
    set ib_skillList[29] = 'ACcs'
    set ib_skillName[29] = "è¯…å’’"
    set ib_skillCustom[29] = 0
    set ib_skillList[30] = 'ACct'
    set ib_skillName[30] = "è‡´å‘½ä¸€å‡»"
    set ib_skillCustom[30] = 0
    set ib_skillList[31] = 'ACcv'
    set ib_skillName[31] = "å†²å‡»æ³¢"
    set ib_skillCustom[31] = 0
    set ib_skillList[32] = 'ACcw'
    set ib_skillName[32] = "å†°å†»å†·ç®­"
    set ib_skillCustom[32] = 0
    set ib_skillList[33] = 'ACcy'
    set ib_skillName[33] = "é£“é£"
    set ib_skillCustom[33] = 0
    set ib_skillList[34] = 'ACd2'
    set ib_skillName[34] = "é©±é€é­”æ³•"
    set ib_skillCustom[34] = 0
    set ib_skillList[35] = 'ACdc'
    set ib_skillName[35] = "æ­»äº¡ç¼ ç»•"
    set ib_skillCustom[35] = 0
    set ib_skillList[36] = 'ACde'
    set ib_skillName[36] = "åå™¬é­”æ³•"
    set ib_skillCustom[36] = 0
    set ib_skillList[37] = 'ACdm'
    set ib_skillName[37] = "é©±é€é­”æ³•"
    set ib_skillCustom[37] = 0
    set ib_skillList[38] = 'ACdr'
    set ib_skillName[38] = "ç”Ÿå‘½æ±²å–"
    set ib_skillCustom[38] = 0
    set ib_skillList[39] = 'ACds'
    set ib_skillName[39] = "ç¥åœ£æŠ¤ç”²"
    set ib_skillCustom[39] = 0
    set ib_skillList[40] = 'ACdv'
    set ib_skillName[40] = "åå™¬"
    set ib_skillCustom[40] = 0
    set ib_skillList[41] = 'ACen'
    set ib_skillName[41] = "è¯±æ•"
    set ib_skillCustom[41] = 0
    set ib_skillList[42] = 'ACes'
    set ib_skillName[42] = "é—ªé¿"
    set ib_skillCustom[42] = 0
    set ib_skillList[43] = 'ACev'
    set ib_skillName[43] = "é—ªé¿"
    set ib_skillCustom[43] = 0
    set ib_skillList[44] = 'ACf2'
    set ib_skillName[44] = "éœœå†»æŠ¤ç”²"
    set ib_skillCustom[44] = 0
    set ib_skillList[45] = 'ACf3'
    set ib_skillName[45] = "ç—›è‹¦ä¹‹æŒ‡"
    set ib_skillCustom[45] = 0
    set ib_skillList[46] = 'ACfa'
    set ib_skillName[46] = "éœœå†»æŠ¤ç”²"
    set ib_skillCustom[46] = 0
    set ib_skillList[47] = 'ACfb'
    set ib_skillName[47] = "éœ¹é›³é—ªç”µ"
    set ib_skillCustom[47] = 0
    set ib_skillList[48] = 'ACfd'
    set ib_skillName[48] = "ç—›è‹¦ä¹‹æŒ‡"
    set ib_skillCustom[48] = 0
    set ib_skillList[49] = 'ACff'
    set ib_skillName[49] = "ç²¾çµä¹‹ç«"
    set ib_skillCustom[49] = 0
    set ib_skillList[50] = 'ACfl'
    set ib_skillName[50] = "å‰çŠ¶é—ªç”µ"
    set ib_skillCustom[50] = 0
    set ib_skillList[51] = 'ACfn'
    set ib_skillName[51] = "éœœå†»æ–°æ˜Ÿ"
    set ib_skillCustom[51] = 0
    set ib_skillList[52] = 'ACfr'
    set ib_skillName[52] = "è‡ªç„¶ä¹‹åŠ›"
    set ib_skillCustom[52] = 0
    set ib_skillList[53] = 'ACfs'
    set ib_skillName[53] = "çƒˆç„°é£æš´"
    set ib_skillCustom[53] = 0
    set ib_skillList[54] = 'ACfu'
    set ib_skillName[54] = "éœœå†»æŠ¤ç”²"
    set ib_skillCustom[54] = 0
    set ib_skillList[55] = 'AChv'
    set ib_skillName[55] = "åŒ»ç–—æ³¢"
    set ib_skillCustom[55] = 0
    set ib_skillList[56] = 'AChw'
    set ib_skillName[56] = "æ²»ç–—å®ˆå«"
    set ib_skillCustom[56] = 0
    set ib_skillList[57] = 'AChx'
    set ib_skillName[57] = "å¦–æœ¯"
    set ib_skillCustom[57] = 0
    set ib_skillList[58] = 'ACif'
    set ib_skillName[58] = "å¿ƒçµä¹‹ç«"
    set ib_skillCustom[58] = 0
    set ib_skillList[59] = 'ACim'
    set ib_skillName[59] = "çŒ®ç¥­"
    set ib_skillCustom[59] = 0
    set ib_skillList[60] = 'ACls'
    set ib_skillName[60] = "é—ªç”µæŠ¤ç›¾"
    set ib_skillCustom[60] = 0
    set ib_skillList[61] = 'ACm2'
    set ib_skillName[61] = "é­”æ³•å…ç–«"
    set ib_skillCustom[61] = 0
    set ib_skillList[62] = 'ACm3'
    set ib_skillName[62] = "é­”æ³•å…ç–«"
    set ib_skillCustom[62] = 0
    set ib_skillList[63] = 'ACmf'
    set ib_skillName[63] = "é­”æ³•æŠ¤ç›¾"
    set ib_skillCustom[63] = 0
    set ib_skillList[64] = 'ACmi'
    set ib_skillName[64] = "é­”æ³•å…ç–«"
    set ib_skillCustom[64] = 0
    set ib_skillList[65] = 'ACmo'
    set ib_skillName[65] = "å­£é£"
    set ib_skillCustom[65] = 0
    set ib_skillList[66] = 'ACmp'
    set ib_skillName[66] = "ç©¿åˆº"
    set ib_skillCustom[66] = 0
    set ib_skillList[67] = 'ACnr'
    set ib_skillName[67] = "ç”Ÿå‘½æ¢å¤å…‰ç¯"
    set ib_skillCustom[67] = 0
    set ib_skillList[68] = 'ACpa'
    set ib_skillName[68] = "å¯„ç”Ÿè™«"
    set ib_skillCustom[68] = 0
    set ib_skillList[69] = 'ACps'
    set ib_skillName[69] = "å æ®"
    set ib_skillCustom[69] = 0
    set ib_skillList[70] = 'ACpu'
    set ib_skillName[70] = "å‡€åŒ–"
    set ib_skillCustom[70] = 0
    set ib_skillList[71] = 'ACpv'
    set ib_skillName[71] = "ç²‰ç¢"
    set ib_skillCustom[71] = 0
    set ib_skillList[72] = 'ACpy'
    set ib_skillName[72] = "å˜å½¢æœ¯"
    set ib_skillCustom[72] = 0
    set ib_skillList[73] = 'ACr1'
    set ib_skillName[73] = "å’†å“®"
    set ib_skillCustom[73] = 0
    set ib_skillList[74] = 'ACr2'
    set ib_skillName[74] = "ç”Ÿå‘½æ¢å¤"
    set ib_skillCustom[74] = 0
    set ib_skillList[75] = 'ACrd'
    set ib_skillName[75] = "å¤æ´»æ­»å°¸"
    set ib_skillCustom[75] = 0
    set ib_skillList[76] = 'ACrf'
    set ib_skillName[76] = "ç«ç„°é›¨"
    set ib_skillCustom[76] = 0
    set ib_skillList[77] = 'ACrg'
    set ib_skillName[77] = "ç«ç„°é›¨"
    set ib_skillCustom[77] = 0
    set ib_skillList[78] = 'ACrj'
    set ib_skillName[78] = "ç”Ÿå‘½æ¢å¤"
    set ib_skillCustom[78] = 0
    set ib_skillList[79] = 'ACrk'
    set ib_skillName[79] = "æŠ—æ€§çš®è‚¤"
    set ib_skillCustom[79] = 0
endfunction
function IB_SkillFill1 takes nothing returns nothing
    set ib_skillList[80] = 'ACrn'
    set ib_skillName[80] = "é‡ç”Ÿ"
    set ib_skillCustom[80] = 0
    set ib_skillList[81] = 'ACro'
    set ib_skillName[81] = "å’†å“®"
    set ib_skillCustom[81] = 0
    set ib_skillList[82] = 'ACs7'
    set ib_skillName[82] = "é‡å…½å¹½é­‚"
    set ib_skillCustom[82] = 0
    set ib_skillList[83] = 'ACs8'
    set ib_skillName[83] = "çµå…½"
    set ib_skillCustom[83] = 0
    set ib_skillList[84] = 'ACs9'
    set ib_skillName[84] = "é‡å…½å¹½é­‚"
    set ib_skillCustom[84] = 0
    set ib_skillList[85] = 'ACsa'
    set ib_skillName[85] = "ç¼çƒ­ä¹‹ç®­"
    set ib_skillCustom[85] = 0
    set ib_skillList[86] = 'ACsf'
    set ib_skillName[86] = "é‡å…½å¹½é­‚"
    set ib_skillCustom[86] = 0
    set ib_skillList[87] = 'ACsh'
    set ib_skillName[87] = "éœ‡è¡æ³¢"
    set ib_skillCustom[87] = 0
    set ib_skillList[88] = 'ACsi'
    set ib_skillName[88] = "æ²‰é»˜é­”æ³•"
    set ib_skillCustom[88] = 0
    set ib_skillList[89] = 'ACsk'
    set ib_skillName[89] = "æŠ—æ€§çš®è‚¤"
    set ib_skillCustom[89] = 0
    set ib_skillList[90] = 'ACsl'
    set ib_skillName[90] = "ç¡çœ "
    set ib_skillCustom[90] = 0
    set ib_skillList[91] = 'ACsm'
    set ib_skillName[91] = "é­”æ³•å¸å®"
    set ib_skillCustom[91] = 0
    set ib_skillList[92] = 'ACsp'
    set ib_skillName[92] = "ç¡çœ "
    set ib_skillCustom[92] = 0
    set ib_skillList[93] = 'ACst'
    set ib_skillName[93] = "éœ‡è¡æ³¢"
    set ib_skillCustom[93] = 0
    set ib_skillList[94] = 'ACsw'
    set ib_skillName[94] = "å‡é€Ÿ"
    set ib_skillCustom[94] = 0
    set ib_skillList[95] = 'ACt2'
    set ib_skillName[95] = "é›·éœ†ä¸€å‡»"
    set ib_skillCustom[95] = 0
    set ib_skillList[96] = 'ACtb'
    set ib_skillName[96] = "æŠ•çŸ³"
    set ib_skillCustom[96] = 0
    set ib_skillList[97] = 'ACtc'
    set ib_skillName[97] = "é›·éœ†ä¸€å‡»"
    set ib_skillCustom[97] = 0
    set ib_skillList[98] = 'ACtn'
    set ib_skillName[98] = "äº§åµè§¦è§’"
    set ib_skillCustom[98] = 0
    set ib_skillList[99] = 'ACua'
    set ib_skillName[99] = "é‚ªæ¶å…‰ç¯"
    set ib_skillCustom[99] = 0
    set ib_skillList[100] = 'ACuf'
    set ib_skillName[100] = "é‚ªæ¶ç‹‚çƒ­"
    set ib_skillCustom[100] = 0
    set ib_skillList[101] = 'ACvp'
    set ib_skillName[101] = "å¸è¡€å…‰ç¯"
    set ib_skillCustom[101] = 0
    set ib_skillList[102] = 'ACvs'
    set ib_skillName[102] = "æµ¸æ¯’æ­¦å™¨"
    set ib_skillCustom[102] = 0
    set ib_skillList[103] = 'ACwb'
    set ib_skillName[103] = "è››ç½‘"
    set ib_skillCustom[103] = 0
    set ib_skillList[104] = 'ACwe'
    set ib_skillName[104] = "å¬å”¤æµ·å…ƒç´ "
    set ib_skillCustom[104] = 0
    set ib_skillList[105] = 'AEIl'
    set ib_skillName[105] = "å˜èº«"
    set ib_skillCustom[105] = 0
    set ib_skillList[106] = 'AEah'
    set ib_skillName[106] = "è†æ£˜å…‰ç¯"
    set ib_skillCustom[106] = 0
    set ib_skillList[107] = 'AEar'
    set ib_skillName[107] = "å¼ºå‡»å…‰ç¯"
    set ib_skillCustom[107] = 0
    set ib_skillList[108] = 'AEbl'
    set ib_skillName[108] = "é—ªçƒ"
    set ib_skillCustom[108] = 0
    set ib_skillList[109] = 'AEbu'
    set ib_skillName[109] = "å»ºé€  (æš—å¤œç²¾çµ)"
    set ib_skillCustom[109] = 0
    set ib_skillList[110] = 'AEer'
    set ib_skillName[110] = "çº ç¼ æ ¹é¡»"
    set ib_skillCustom[110] = 0
    set ib_skillList[111] = 'AEev'
    set ib_skillName[111] = "é—ªé¿"
    set ib_skillCustom[111] = 0
    set ib_skillList[112] = 'AEfk'
    set ib_skillName[112] = "åˆ€é˜µæ—‹é£"
    set ib_skillCustom[112] = 0
    set ib_skillList[113] = 'AEfn'
    set ib_skillName[113] = "è‡ªç„¶ä¹‹åŠ›"
    set ib_skillCustom[113] = 0
    set ib_skillList[114] = 'AEim'
    set ib_skillName[114] = "çŒ®ç¥­"
    set ib_skillCustom[114] = 0
    set ib_skillList[115] = 'AEmb'
    set ib_skillName[115] = "æ³•åŠ›ç‡ƒçƒ§"
    set ib_skillCustom[115] = 0
    set ib_skillList[116] = 'AEme'
    set ib_skillName[116] = "å˜èº«"
    set ib_skillCustom[116] = 0
    set ib_skillList[117] = 'AEpa'
    set ib_skillName[117] = "æ¯’ç®­"
    set ib_skillCustom[117] = 0
    set ib_skillList[118] = 'AEsb'
    set ib_skillName[118] = "ç¾¤æ˜Ÿå è½"
    set ib_skillCustom[118] = 0
    set ib_skillList[119] = 'AEsf'
    set ib_skillName[119] = "ç¾¤æ˜Ÿå è½"
    set ib_skillCustom[119] = 0
    set ib_skillList[120] = 'AEsh'
    set ib_skillName[120] = "æš—å½±çªè¢­"
    set ib_skillCustom[120] = 0
    set ib_skillList[121] = 'AEst'
    set ib_skillName[121] = "ä¾¦å¯Ÿ"
    set ib_skillCustom[121] = 0
    set ib_skillList[122] = 'AEsv'
    set ib_skillName[122] = "å¤ä»‡ä¹‹é­‚"
    set ib_skillCustom[122] = 0
    set ib_skillList[123] = 'AEtq'
    set ib_skillName[123] = "å®é™"
    set ib_skillCustom[123] = 0
    set ib_skillList[124] = 'AEvi'
    set ib_skillName[124] = "å˜èº«"
    set ib_skillCustom[124] = 0
    set ib_skillList[125] = 'AGbu'
    set ib_skillName[125] = "å»ºé€ (å¨œè¿¦)"
    set ib_skillCustom[125] = 0
    set ib_skillList[126] = 'AHab'
    set ib_skillName[126] = "è¾‰ç…Œå…‰ç¯"
    set ib_skillCustom[126] = 0
    set ib_skillList[127] = 'AHad'
    set ib_skillName[127] = "ä¸“æ³¨å…‰ç¯"
    set ib_skillCustom[127] = 0
    set ib_skillList[128] = 'AHav'
    set ib_skillName[128] = "å¤©ç¥ä¸‹å‡¡"
    set ib_skillCustom[128] = 0
    set ib_skillList[129] = 'AHbh'
    set ib_skillName[129] = "é‡å‡»"
    set ib_skillCustom[129] = 0
    set ib_skillList[130] = 'AHbn'
    set ib_skillName[130] = "é©±æ•£"
    set ib_skillCustom[130] = 0
    set ib_skillList[131] = 'AHbu'
    set ib_skillName[131] = "å»ºé€ (äººæ—)"
    set ib_skillCustom[131] = 0
    set ib_skillList[132] = 'AHbz'
    set ib_skillName[132] = "æš´é£é›ª"
    set ib_skillCustom[132] = 0
    set ib_skillList[133] = 'AHca'
    set ib_skillName[133] = "å†°å†»å†·ç®­"
    set ib_skillCustom[133] = 0
    set ib_skillList[134] = 'AHdr'
    set ib_skillName[134] = "é­”æ³•å¸å®"
    set ib_skillCustom[134] = 0
    set ib_skillList[135] = 'AHds'
    set ib_skillName[135] = "ç¥åœ£æŠ¤ç”²"
    set ib_skillCustom[135] = 0
    set ib_skillList[136] = 'AHer'
    set ib_skillName[136] = "è‹±é›„"
    set ib_skillCustom[136] = 0
    set ib_skillList[137] = 'AHfa'
    set ib_skillName[137] = "ç¼çƒ­ä¹‹ç®­"
    set ib_skillCustom[137] = 0
    set ib_skillList[138] = 'AHfs'
    set ib_skillName[138] = "çƒˆç„°é£æš´"
    set ib_skillCustom[138] = 0
    set ib_skillList[139] = 'AHhb'
    set ib_skillName[139] = "ç¥åœ£ä¹‹å…‰"
    set ib_skillCustom[139] = 0
    set ib_skillList[140] = 'AHmt'
    set ib_skillName[140] = "ç¾¤ä½“ä¼ é€"
    set ib_skillCustom[140] = 0
    set ib_skillList[141] = 'AHpx'
    set ib_skillName[141] = "ç«å‡¤å‡°"
    set ib_skillCustom[141] = 0
    set ib_skillList[142] = 'AHre'
    set ib_skillName[142] = "å¤æ´»"
    set ib_skillCustom[142] = 0
    set ib_skillList[143] = 'AHta'
    set ib_skillName[143] = "æ˜¾ç¤º"
    set ib_skillCustom[143] = 0
    set ib_skillList[144] = 'AHtb'
    set ib_skillName[144] = "é£æš´ä¹‹é”¤"
    set ib_skillCustom[144] = 0
    set ib_skillList[145] = 'AHtc'
    set ib_skillName[145] = "é›·éœ†ä¸€å‡»"
    set ib_skillCustom[145] = 0
    set ib_skillList[146] = 'AHwe'
    set ib_skillName[146] = "å¬å”¤æ°´å…ƒç´ "
    set ib_skillCustom[146] = 0
    set ib_skillList[147] = 'AI2m'
    set ib_skillName[147] = "èƒ½å¢åŠ é­”æ³•å€¼çš„ç‰©å“(200)"
    set ib_skillCustom[147] = 0
    set ib_skillList[148] = 'AIa1'
    set ib_skillName[148] = "èƒ½æé«˜è‹±é›„å±æ€§çš„ç‰©å“"
    set ib_skillCustom[148] = 0
    set ib_skillList[149] = 'AIa3'
    set ib_skillName[149] = "èƒ½æé«˜è‹±é›„å±æ€§çš„ç‰©å“"
    set ib_skillCustom[149] = 0
    set ib_skillList[150] = 'AIa4'
    set ib_skillName[150] = "èƒ½æé«˜è‹±é›„å±æ€§çš„ç‰©å“"
    set ib_skillCustom[150] = 0
    set ib_skillList[151] = 'AIa6'
    set ib_skillName[151] = "èƒ½æé«˜è‹±é›„å±æ€§çš„ç‰©å“"
    set ib_skillCustom[151] = 0
    set ib_skillList[152] = 'AIaa'
    set ib_skillName[152] = "èƒ½å¢åŠ æ”»å‡»åŠ›çš„ç‰©å“"
    set ib_skillCustom[152] = 0
    set ib_skillList[153] = 'AIab'
    set ib_skillName[153] = "èƒ½æé«˜è‹±é›„å±æ€§çš„ç‰©å“"
    set ib_skillCustom[153] = 0
    set ib_skillList[154] = 'AIam'
    set ib_skillName[154] = "èƒ½å¢åŠ æ•æ·åº¦çš„ç‰©å“"
    set ib_skillCustom[154] = 0
    set ib_skillList[155] = 'AIan'
    set ib_skillName[155] = "èƒ½æ“çºµæ­»å°¸çš„ç‰©å“"
    set ib_skillCustom[155] = 0
    set ib_skillList[156] = 'AIas'
    set ib_skillName[156] = "èƒ½æé«˜æ”»å‡»é€Ÿåº¦çš„ç‰©å“"
    set ib_skillCustom[156] = 0
    set ib_skillList[157] = 'AIat'
    set ib_skillName[157] = "å¢åŠ æ”»å‡»åŠ›çš„ç‰©å“"
    set ib_skillCustom[157] = 0
    set ib_skillList[158] = 'AIaz'
    set ib_skillName[158] = "èƒ½æé«˜è‹±é›„å±æ€§çš„ç‰©å“"
    set ib_skillCustom[158] = 0
    set ib_skillList[159] = 'AIbb'
    set ib_skillName[159] = "å»ºé€ å¾®å‹é“åŒ é“º"
    set ib_skillCustom[159] = 0
endfunction
function IB_SkillFill2 takes nothing returns nothing
    set ib_skillList[160] = 'AIbf'
    set ib_skillName[160] = "å»ºé€ å¾®å‹å†œåœº"
    set ib_skillCustom[160] = 0
    set ib_skillList[161] = 'AIbg'
    set ib_skillName[161] = "å»ºé€ å°å‹çš„å¤§å…"
    set ib_skillCustom[161] = 0
    set ib_skillList[162] = 'AIbh'
    set ib_skillName[162] = "å»ºé€ å¾®å‹å›½ç‹ç¥­å›"
    set ib_skillCustom[162] = 0
    set ib_skillList[163] = 'AIbk'
    set ib_skillName[163] = "é—ªçƒ(ç‰©å“ç­‰çº§)"
    set ib_skillCustom[163] = 0
    set ib_skillList[164] = 'AIbl'
    set ib_skillName[164] = "å»ºé€ å°å‹çš„åŸå ¡"
    set ib_skillCustom[164] = 0
    set ib_skillList[165] = 'AIbm'
    set ib_skillName[165] = "èƒ½å¢åŠ é­”æ³•å€¼çš„ç‰©å“"
    set ib_skillCustom[165] = 0
    set ib_skillList[166] = 'AIbr'
    set ib_skillName[166] = "å»ºé€ å¾®å‹ä¼æœ¨åœº"
    set ib_skillCustom[166] = 0
    set ib_skillList[167] = 'AIbs'
    set ib_skillName[167] = "å»ºé€ å¾®å‹å…µè¥"
    set ib_skillCustom[167] = 0
    set ib_skillList[168] = 'AIbt'
    set ib_skillName[168] = "å»ºé€ å°å‹çš„å“¨å¡”"
    set ib_skillCustom[168] = 0
    set ib_skillList[169] = 'AIbx'
    set ib_skillName[169] = "é‡å‡»"
    set ib_skillCustom[169] = 0
    set ib_skillList[170] = 'AIcb'
    set ib_skillName[170] = "å¸¦æœ‰è…èš€æ”»å‡»æ•ˆæœçš„ç‰©å“"
    set ib_skillCustom[170] = 0
    set ib_skillList[171] = 'AIcf'
    set ib_skillName[171] = "å…·æœ‰çŒ®ç¥­æ•ˆæœçš„ç‰©å“"
    set ib_skillCustom[171] = 0
    set ib_skillList[172] = 'AIcl'
    set ib_skillName[172] = "é—ªç”µé“¾"
    set ib_skillCustom[172] = 0
    set ib_skillList[173] = 'AIcm'
    set ib_skillName[173] = "æ§åˆ¶é­”æ³•"
    set ib_skillCustom[173] = 0
    set ib_skillList[174] = 'AIco'
    set ib_skillName[174] = "å‘½ä»¤ç‰©å“"
    set ib_skillCustom[174] = 0
    set ib_skillList[175] = 'AIcs'
    set ib_skillName[175] = "è‡´å‘½ä¸€å‡»"
    set ib_skillCustom[175] = 0
    set ib_skillList[176] = 'AIct'
    set ib_skillName[176] = "æ”¹å˜ä¸€å¤©çš„æ—¶é—´"
    set ib_skillCustom[176] = 0
    set ib_skillList[177] = 'AIcy'
    set ib_skillName[177] = "é£“é£"
    set ib_skillCustom[177] = 0
    set ib_skillList[178] = 'AId0'
    set ib_skillName[178] = "èƒ½æé«˜æŠ¤ç”²çš„ç‰©å“"
    set ib_skillCustom[178] = 0
    set ib_skillList[179] = 'AId1'
    set ib_skillName[179] = "èƒ½æé«˜æŠ¤ç”²çš„ç‰©å“"
    set ib_skillCustom[179] = 0
    set ib_skillList[180] = 'AId2'
    set ib_skillName[180] = "èƒ½æé«˜æŠ¤ç”²çš„ç‰©å“"
    set ib_skillCustom[180] = 0
    set ib_skillList[181] = 'AId3'
    set ib_skillName[181] = "èƒ½æé«˜æŠ¤ç”²çš„ç‰©å“"
    set ib_skillCustom[181] = 0
    set ib_skillList[182] = 'AId4'
    set ib_skillName[182] = "èƒ½æé«˜æŠ¤ç”²çš„ç‰©å“"
    set ib_skillCustom[182] = 0
    set ib_skillList[183] = 'AId5'
    set ib_skillName[183] = "èƒ½æé«˜æŠ¤ç”²çš„ç‰©å“"
    set ib_skillCustom[183] = 0
    set ib_skillList[184] = 'AId7'
    set ib_skillName[184] = "èƒ½åŠ å¼ºæŠ¤ç”²çš„ç‰©å“"
    set ib_skillCustom[184] = 0
    set ib_skillList[185] = 'AId8'
    set ib_skillName[185] = "èƒ½æé«˜æŠ¤ç”²çš„ç‰©å“"
    set ib_skillCustom[185] = 0
    set ib_skillList[186] = 'AIda'
    set ib_skillName[186] = "èƒ½æš‚æ—¶æé«˜ä¸€å®šèŒƒå›´å†…æ‰€æœ‰å•ä½æŠ¤ç”²çš„ç‰©å“"
    set ib_skillCustom[186] = 0
    set ib_skillList[187] = 'AIdb'
    set ib_skillName[187] = "èƒ½æš‚æ—¶åŠ å¼ºèŒƒå›´å†…æ‰€æœ‰å•ä½æŠ¤ç”²çš„ç‰©å“"
    set ib_skillCustom[187] = 0
    set ib_skillList[188] = 'AIdc'
    set ib_skillName[188] = "å¸¦æœ‰é”é“¾é©±é€æ•ˆæœçš„ç‰©å“"
    set ib_skillCustom[188] = 0
    set ib_skillList[189] = 'AIdd'
    set ib_skillName[189] = "passive defense"
    set ib_skillCustom[189] = 0
    set ib_skillList[190] = 'AIde'
    set ib_skillName[190] = "èƒ½å¢åŠ æŠ¤ç”²çš„ç‰©å“"
    set ib_skillCustom[190] = 0
    set ib_skillList[191] = 'AIdf'
    set ib_skillName[191] = "èƒ½å¸¦æœ‰é»‘ç®­æ”»å‡»ä¼¤å®³çš„ç‰©å“"
    set ib_skillCustom[191] = 0
    set ib_skillList[192] = 'AIdi'
    set ib_skillName[192] = "å…·æœ‰é©±é€é­”æ³•æ•ˆæœçš„ç‰©å“"
    set ib_skillCustom[192] = 0
    set ib_skillList[193] = 'AIdm'
    set ib_skillName[193] = "èƒ½å¯¹èŒƒå›´å†…çš„æ ‘æœ¨/å¢™å£é€ æˆä¼¤å®³çš„ç‰©å“"
    set ib_skillCustom[193] = 0
    set ib_skillList[194] = 'AIdn'
    set ib_skillName[194] = "å½±å­ä¹‹çƒ æŠ€èƒ½"
    set ib_skillCustom[194] = 0
    set ib_skillList[195] = 'AIdp'
    set ib_skillName[195] = "æ­»äº¡å¥‘çº¦"
    set ib_skillCustom[195] = 0
    set ib_skillList[196] = 'AIds'
    set ib_skillName[196] = "å…·æœ‰é©±é€é­”æ³•æ•ˆæœçš„ç‰©å“"
    set ib_skillCustom[196] = 0
    set ib_skillList[197] = 'AIdv'
    set ib_skillName[197] = "ç‰©å“ç¥åœ£æŠ¤ç”²"
    set ib_skillCustom[197] = 0
    set ib_skillList[198] = 'AIe2'
    set ib_skillName[198] = "èƒ½è·å–ç»éªŒå€¼çš„ç‰©å“"
    set ib_skillCustom[198] = 0
    set ib_skillList[199] = 'AIem'
    set ib_skillName[199] = "èƒ½è·å–ç»éªŒå€¼çš„ç‰©å“"
    set ib_skillCustom[199] = 0
    set ib_skillList[200] = 'AIev'
    set ib_skillName[200] = "é—ªé¿"
    set ib_skillCustom[200] = 0
    set ib_skillList[201] = 'AIfa'
    set ib_skillName[201] = "ä¿¡å·æª"
    set ib_skillCustom[201] = 0
    set ib_skillList[202] = 'AIfb'
    set ib_skillName[202] = "èƒ½å¸¦æœ‰ç«ç„°ä¼¤å®³çš„ç‰©å“"
    set ib_skillCustom[202] = 0
    set ib_skillList[203] = 'AIfc'
    set ib_skillName[203] = "é£è¡Œåœ°æ¯¯"
    set ib_skillCustom[203] = 0
    set ib_skillList[204] = 'AIfd'
    set ib_skillName[204] = "èƒ½å¬å”¤çº¢é¾™çš„ç‰©å“"
    set ib_skillCustom[204] = 0
    set ib_skillList[205] = 'AIfe'
    set ib_skillName[205] = "æŠ¢å¤ºæ——å¸œ"
    set ib_skillCustom[205] = 0
    set ib_skillList[206] = 'AIff'
    set ib_skillName[206] = "èƒ½å¬å”¤ç†Šæ€ªçš„ç‰©å“"
    set ib_skillCustom[206] = 0
    set ib_skillList[207] = 'AIfg'
    set ib_skillName[207] = "ä¹Œäº‘æŠ€èƒ½"
    set ib_skillCustom[207] = 0
    set ib_skillList[208] = 'AIfh'
    set ib_skillName[208] = "èƒ½å¬å”¤åœ°ç‹±çŠ¬çš„ç‰©å“"
    set ib_skillCustom[208] = 0
    set ib_skillList[209] = 'AIfi'
    set ib_skillName[209] = "éœ¹é›³é—ªç”µç‰©å“"
    set ib_skillCustom[209] = 0
    set ib_skillList[210] = 'AIfl'
    set ib_skillName[210] = "æŠ¢å¤ºæ——å¸œ"
    set ib_skillCustom[210] = 0
    set ib_skillList[211] = 'AIfm'
    set ib_skillName[211] = "æŠ¢å¤ºæ——å¸œ"
    set ib_skillCustom[211] = 0
    set ib_skillList[212] = 'AIfn'
    set ib_skillName[212] = "æŠ¢å¤ºæ——å¸œ"
    set ib_skillCustom[212] = 0
    set ib_skillList[213] = 'AIfo'
    set ib_skillName[213] = "æŠ¢å¤ºæ——å¸œ"
    set ib_skillCustom[213] = 0
    set ib_skillList[214] = 'AIfr'
    set ib_skillName[214] = "èƒ½å¬å”¤å²©çŸ³å‚€å„¡çš„ç‰©å“"
    set ib_skillCustom[214] = 0
    set ib_skillList[215] = 'AIfs'
    set ib_skillName[215] = "èƒ½å¬å”¤éª·é«…æˆ˜å£«çš„ç‰©å“"
    set ib_skillCustom[215] = 0
    set ib_skillList[216] = 'AIft'
    set ib_skillName[216] = "è¿‘æˆ˜æ”»å‡»å¸¦æœ‰å†°å†»ä¼¤å®³"
    set ib_skillCustom[216] = 0
    set ib_skillList[217] = 'AIfu'
    set ib_skillName[217] = "èƒ½å¬å”¤æ¯ç­å®ˆå«çš„ç‰©å“"
    set ib_skillCustom[217] = 0
    set ib_skillList[218] = 'AIfw'
    set ib_skillName[218] = "è¿‘æˆ˜æ”»å‡»å¸¦æœ‰ç«ç„°ä¼¤å®³"
    set ib_skillCustom[218] = 0
    set ib_skillList[219] = 'AIfx'
    set ib_skillName[219] = "ç‰©å“å…½æ—æˆ˜æ–—æ ‡å‡†"
    set ib_skillCustom[219] = 0
    set ib_skillList[220] = 'AIfz'
    set ib_skillName[220] = "æ­»äº¡ä¹‹æŒ‡"
    set ib_skillCustom[220] = 0
    set ib_skillList[221] = 'AIgd'
    set ib_skillName[221] = "èƒ½å¸¦æœ‰ç«ç„°ä¼¤å®³çš„ç‰©å“"
    set ib_skillCustom[221] = 0
    set ib_skillList[222] = 'AIgf'
    set ib_skillName[222] = "é˜²å¾¡æµ®é›•"
    set ib_skillCustom[222] = 0
    set ib_skillList[223] = 'AIgm'
    set ib_skillName[223] = "èƒ½å¢åŠ æ•æ·åº¦çš„ç‰©å“"
    set ib_skillCustom[223] = 0
    set ib_skillList[224] = 'AIgo'
    set ib_skillName[224] = "é‡‘ç®±å­"
    set ib_skillCustom[224] = 0
    set ib_skillList[225] = 'AIgu'
    set ib_skillName[225] = "é˜²å¾¡æµ®é›•"
    set ib_skillCustom[225] = 0
    set ib_skillList[226] = 'AIgx'
    set ib_skillName[226] = "æ¢å¤å…‰ç¯"
    set ib_skillCustom[226] = 0
    set ib_skillList[227] = 'AIh1'
    set ib_skillName[227] = "å…·æœ‰åŒ»ç–—æ•ˆæœçš„ç‰©å“"
    set ib_skillCustom[227] = 0
    set ib_skillList[228] = 'AIh2'
    set ib_skillName[228] = "å…·æœ‰åŒ»ç–—æ•ˆæœçš„ç‰©å“"
    set ib_skillCustom[228] = 0
    set ib_skillList[229] = 'AIh3'
    set ib_skillName[229] = "æœ€å°çš„åŒ»ç–—èƒ½åŠ›"
    set ib_skillCustom[229] = 0
    set ib_skillList[230] = 'AIha'
    set ib_skillName[230] = "èƒ½è¿›è¡ŒèŒƒå›´åŒ»ç–—çš„ç‰©å“"
    set ib_skillCustom[230] = 0
    set ib_skillList[231] = 'AIhb'
    set ib_skillName[231] = "èƒ½è¿›è¡ŒèŒƒå›´åŒ»ç–—çš„ç‰©å“"
    set ib_skillCustom[231] = 0
    set ib_skillList[232] = 'AIhe'
    set ib_skillName[232] = "å…·æœ‰åŒ»ç–—æ•ˆæœçš„ç‰©å“"
    set ib_skillCustom[232] = 0
    set ib_skillList[233] = 'AIhl'
    set ib_skillName[233] = "ç¥åœ£ä¹‹å…‰"
    set ib_skillCustom[233] = 0
    set ib_skillList[234] = 'AIhw'
    set ib_skillName[234] = "æ²»ç–—å®ˆå«"
    set ib_skillCustom[234] = 0
    set ib_skillList[235] = 'AIhx'
    set ib_skillName[235] = "å…·æœ‰åŒ»ç–—æ•ˆæœçš„ç‰©å“"
    set ib_skillCustom[235] = 0
    set ib_skillList[236] = 'AIi1'
    set ib_skillName[236] = "èƒ½æé«˜è‹±é›„å±æ€§çš„ç‰©å“"
    set ib_skillCustom[236] = 0
    set ib_skillList[237] = 'AIi3'
    set ib_skillName[237] = "èƒ½æé«˜è‹±é›„å±æ€§çš„ç‰©å“"
    set ib_skillCustom[237] = 0
    set ib_skillList[238] = 'AIi4'
    set ib_skillName[238] = "èƒ½æé«˜è‹±é›„å±æ€§çš„ç‰©å“"
    set ib_skillCustom[238] = 0
    set ib_skillList[239] = 'AIi6'
    set ib_skillName[239] = "èƒ½æé«˜è‹±é›„å±æ€§çš„ç‰©å“"
    set ib_skillCustom[239] = 0
endfunction
function IB_SkillFill3 takes nothing returns nothing
    set ib_skillList[240] = 'AIil'
    set ib_skillName[240] = "å¹»è±¡ç‰©å“"
    set ib_skillCustom[240] = 0
    set ib_skillList[241] = 'AIim'
    set ib_skillName[241] = "èƒ½æé«˜æ™ºåŠ›çš„ç‰©å“"
    set ib_skillCustom[241] = 0
    set ib_skillList[242] = 'AIir'
    set ib_skillName[242] = "èƒ½å¬å”¤å†°å†»å¹½çµçš„ç‰©å“"
    set ib_skillCustom[242] = 0
    set ib_skillList[243] = 'AIl1'
    set ib_skillName[243] = "èƒ½å¢åŠ ç”Ÿå‘½å€¼çš„ç‰©å“"
    set ib_skillCustom[243] = 0
    set ib_skillList[244] = 'AIl2'
    set ib_skillName[244] = "èƒ½å¢åŠ ç”Ÿå‘½å€¼çš„ç‰©å“"
    set ib_skillCustom[244] = 0
    set ib_skillList[245] = 'AIlb'
    set ib_skillName[245] = "èƒ½å¸¦æœ‰é—ªç”µä¼¤å®³çš„ç‰©å“"
    set ib_skillCustom[245] = 0
    set ib_skillList[246] = 'AIlf'
    set ib_skillName[246] = "èƒ½å¢åŠ ç”Ÿå‘½å€¼çš„ç‰©å“"
    set ib_skillCustom[246] = 0
    set ib_skillList[247] = 'AIll'
    set ib_skillName[247] = "é—ªç”µä¹‹çƒ(æ–°çš„)"
    set ib_skillCustom[247] = 0
    set ib_skillList[248] = 'AIlm'
    set ib_skillName[248] = "èƒ½æé«˜ç­‰çº§çš„ç‰©å“"
    set ib_skillCustom[248] = 0
    set ib_skillList[249] = 'AIlp'
    set ib_skillName[249] = "å¸¦æœ‰å‡€åŒ–æ•ˆæœçš„ç‰©å“"
    set ib_skillCustom[249] = 0
    set ib_skillList[250] = 'AIls'
    set ib_skillName[250] = "é—ªç”µæŠ¤ç›¾"
    set ib_skillCustom[250] = 0
    set ib_skillList[251] = 'AIlu'
    set ib_skillName[251] = "æœ¨æå †"
    set ib_skillCustom[251] = 0
    set ib_skillList[252] = 'AIlx'
    set ib_skillName[252] = "è¿‘æˆ˜æ”»å‡»å¸¦æœ‰é—ªç”µä¼¤å®³"
    set ib_skillCustom[252] = 0
    set ib_skillList[253] = 'AIlz'
    set ib_skillName[253] = "èƒ½å¢åŠ ç”Ÿå‘½å€¼çš„ç‰©å“"
    set ib_skillCustom[253] = 0
    set ib_skillList[254] = 'AIm1'
    set ib_skillName[254] = "èƒ½å¢åŠ é­”æ³•æ¢å¤é€Ÿåº¦çš„ç‰©å“"
    set ib_skillCustom[254] = 0
    set ib_skillList[255] = 'AIm2'
    set ib_skillName[255] = "èƒ½å¢åŠ é­”æ³•æ¢å¤é€Ÿåº¦çš„ç‰©å“"
    set ib_skillCustom[255] = 0
    set ib_skillList[256] = 'AIma'
    set ib_skillName[256] = "èƒ½å¢åŠ é­”æ³•æ¢å¤é€Ÿåº¦çš„ç‰©å“"
    set ib_skillCustom[256] = 0
    set ib_skillList[257] = 'AImb'
    set ib_skillName[257] = "èƒ½å¢åŠ é­”æ³•å€¼çš„ç‰©å“"
    set ib_skillCustom[257] = 0
    set ib_skillList[258] = 'AImh'
    set ib_skillName[258] = "èƒ½æ°¸ä¹…å¢åŠ ç”Ÿå‘½å€¼çš„ç‰©å“"
    set ib_skillCustom[258] = 0
    set ib_skillList[259] = 'AImi'
    set ib_skillName[259] = "èƒ½å¢åŠ ç”Ÿå‘½å€¼çš„ç‰©å“"
    set ib_skillCustom[259] = 0
    set ib_skillList[260] = 'AIml'
    set ib_skillName[260] = "èƒ½å¢åŠ ç”Ÿå‘½å€¼çš„ç‰©å“"
    set ib_skillCustom[260] = 0
    set ib_skillList[261] = 'AImm'
    set ib_skillName[261] = "èƒ½å¢åŠ é­”æ³•å€¼çš„ç‰©å“"
    set ib_skillCustom[261] = 0
    set ib_skillList[262] = 'AImo'
    set ib_skillName[262] = "æ€ªå…½è¯±æ•å®ˆå«"
    set ib_skillCustom[262] = 0
    set ib_skillList[263] = 'AImr'
    set ib_skillName[263] = "èƒ½æé«˜ä¸€å®šèŒƒå›´å†…æ‰€æœ‰å•ä½é­”æ³•å€¼çš„ç‰©å“"
    set ib_skillCustom[263] = 0
    set ib_skillList[264] = 'AIms'
    set ib_skillName[264] = "èƒ½æé«˜ç§»åŠ¨é€Ÿåº¦çš„ç‰©å“"
    set ib_skillCustom[264] = 0
    set ib_skillList[265] = 'AImt'
    set ib_skillName[265] = "ä¼ é€æƒæ–"
    set ib_skillCustom[265] = 0
    set ib_skillList[266] = 'AImv'
    set ib_skillName[266] = "èƒ½å¢åŠ é­”æ³•å€¼çš„ç‰©å“(75)"
    set ib_skillCustom[266] = 0
    set ib_skillList[267] = 'AImx'
    set ib_skillName[267] = "é­”æ³•å…ç–«"
    set ib_skillCustom[267] = 0
    set ib_skillList[268] = 'AImz'
    set ib_skillName[268] = "èƒ½å¢åŠ é­”æ³•å€¼çš„ç‰©å“(100)"
    set ib_skillCustom[268] = 0
    set ib_skillList[269] = 'AInd'
    set ib_skillName[269] = "é¼“èˆ"
    set ib_skillCustom[269] = 0
    set ib_skillList[270] = 'AInm'
    set ib_skillName[270] = "èƒ½å¢åŠ åŠ›é‡çš„ç‰©å“"
    set ib_skillCustom[270] = 0
    set ib_skillList[271] = 'AInv'
    set ib_skillName[271] = "ç‰©å“æ "
    set ib_skillCustom[271] = 0
    set ib_skillList[272] = 'AIob'
    set ib_skillName[272] = "å¸¦æœ‰éœœå†»æ”»å‡»æ•ˆæœçš„ç‰©å“"
    set ib_skillCustom[272] = 0
    set ib_skillList[273] = 'AIos'
    set ib_skillName[273] = "å‡é€Ÿ"
    set ib_skillCustom[273] = 0
    set ib_skillList[274] = 'AIp1'
    set ib_skillName[274] = "æ™®é€šç‰©å“-å›å¤æ•ˆæœ"
    set ib_skillCustom[274] = 0
    set ib_skillList[275] = 'AIp2'
    set ib_skillName[275] = "æ™®é€šç‰©å“-å›å¤æ•ˆæœ"
    set ib_skillCustom[275] = 0
    set ib_skillList[276] = 'AIp3'
    set ib_skillName[276] = "æ™®é€šç‰©å“-å›å¤æ•ˆæœ"
    set ib_skillCustom[276] = 0
    set ib_skillList[277] = 'AIp4'
    set ib_skillName[277] = "æ™®é€šç‰©å“-å›å¤æ•ˆæœ"
    set ib_skillCustom[277] = 0
    set ib_skillList[278] = 'AIp5'
    set ib_skillName[278] = "æ™®é€šç‰©å“-å›å¤æ•ˆæœ"
    set ib_skillCustom[278] = 0
    set ib_skillList[279] = 'AIp6'
    set ib_skillName[279] = "æ™®é€šç‰©å“-å›å¤æ•ˆæœ"
    set ib_skillCustom[279] = 0
    set ib_skillList[280] = 'AIpb'
    set ib_skillName[280] = "å¸¦æœ‰æ¯’è¯æ•ˆæœçš„ç‰©å“"
    set ib_skillCustom[280] = 0
    set ib_skillList[281] = 'AIpg'
    set ib_skillName[281] = "å¸¦æœ‰å‡€åŒ–æ•ˆæœçš„ç‰©å“"
    set ib_skillCustom[281] = 0
    set ib_skillList[282] = 'AIpl'
    set ib_skillName[282] = "å°å‡€åŒ–è¯æ°´"
    set ib_skillCustom[282] = 0
    set ib_skillList[283] = 'AIpm'
    set ib_skillName[283] = "èƒ½ç½®æ”¾åœ°ç²¾åœ°é›·çš„ç‰©å“"
    set ib_skillCustom[283] = 0
    set ib_skillList[284] = 'AIpr'
    set ib_skillName[284] = "å‡€åŒ–è¯æ°´"
    set ib_skillCustom[284] = 0
    set ib_skillList[285] = 'AIps'
    set ib_skillName[285] = "å¸¦æœ‰å‡€åŒ–æ•ˆæœçš„ç‰©å“"
    set ib_skillCustom[285] = 0
    set ib_skillList[286] = 'AIpv'
    set ib_skillName[286] = "å¸è¡€è¯æ°´"
    set ib_skillCustom[286] = 0
    set ib_skillList[287] = 'AIpx'
    set ib_skillName[287] = "èƒ½æ°¸ä¹…å¢åŠ ç”Ÿå‘½å€¼çš„ç‰©å“"
    set ib_skillCustom[287] = 0
    set ib_skillList[288] = 'AIpz'
    set ib_skillName[288] = "ä¼é¹…æ€ªå…½"
    set ib_skillCustom[288] = 0
    set ib_skillList[289] = 'AIra'
    set ib_skillName[289] = "èƒ½æé«˜ä¸€å®šèŒƒå›´å†…æ‰€æœ‰å•ä½é­”æ³•å€¼å’Œç”Ÿå‘½å€¼çš„ç‰©å“"
    set ib_skillCustom[289] = 0
    set ib_skillList[290] = 'AIrb'
    set ib_skillName[290] = "é‡ç”Ÿ"
    set ib_skillCustom[290] = 0
    set ib_skillList[291] = 'AIrc'
    set ib_skillName[291] = "å…·æœ‰é‡ç”Ÿæ•ˆæœçš„ç‰©å“"
    set ib_skillCustom[291] = 0
    set ib_skillList[292] = 'AIrd'
    set ib_skillName[292] = "å¤æ´»æ­»å°¸(ç‰©å“)"
    set ib_skillCustom[292] = 0
    set ib_skillList[293] = 'AIre'
    set ib_skillName[293] = "èƒ½è¿›è¡ŒåŒ»ç–—å’Œå¢åŠ é­”æ³•å€¼çš„å•ä½"
    set ib_skillCustom[293] = 0
    set ib_skillList[294] = 'AIri'
    set ib_skillName[294] = "éšæœºç‰©å“"
    set ib_skillCustom[294] = 0
    set ib_skillList[295] = 'AIrl'
    set ib_skillName[295] = "åŒ»ç–—å‰‚"
    set ib_skillCustom[295] = 0
    set ib_skillList[296] = 'AIrm'
    set ib_skillName[296] = "èƒ½å¢åŠ é­”æ³•æ¢å¤é€Ÿåº¦çš„ç‰©å“"
    set ib_skillCustom[296] = 0
    set ib_skillList[297] = 'AIrr'
    set ib_skillName[297] = "å’†å“®"
    set ib_skillCustom[297] = 0
    set ib_skillList[298] = 'AIrs'
    set ib_skillName[298] = "å…·æœ‰å¤æ´»æ•ˆæœçš„ç‰©å“"
    set ib_skillCustom[298] = 0
    set ib_skillList[299] = 'AIrt'
    set ib_skillName[299] = "å¬å”¤ç‰©å“"
    set ib_skillCustom[299] = 0
    set ib_skillList[300] = 'AIrv'
    set ib_skillName[300] = "èƒ½æ˜¾ç¤ºæ•´ä¸ªåœ°å›¾çš„ç‰©å“"
    set ib_skillCustom[300] = 0
    set ib_skillList[301] = 'AIrx'
    set ib_skillName[301] = "å…·æœ‰å¤æ´»æ•ˆæœçš„ç‰©å“"
    set ib_skillCustom[301] = 0
    set ib_skillList[302] = 'AIs1'
    set ib_skillName[302] = "èƒ½æé«˜è‹±é›„å±æ€§çš„ç‰©å“"
    set ib_skillCustom[302] = 0
    set ib_skillList[303] = 'AIs2'
    set ib_skillName[303] = "èƒ½æé«˜è¿›æ”»é€Ÿåº¦çš„ç‰©å“"
    set ib_skillCustom[303] = 0
    set ib_skillList[304] = 'AIs3'
    set ib_skillName[304] = "èƒ½æé«˜è‹±é›„å±æ€§çš„ç‰©å“"
    set ib_skillCustom[304] = 0
    set ib_skillList[305] = 'AIs4'
    set ib_skillName[305] = "èƒ½æé«˜è‹±é›„å±æ€§çš„ç‰©å“"
    set ib_skillCustom[305] = 0
    set ib_skillList[306] = 'AIs6'
    set ib_skillName[306] = "èƒ½æé«˜è‹±é›„å±æ€§çš„ç‰©å“"
    set ib_skillCustom[306] = 0
    set ib_skillList[307] = 'AIsa'
    set ib_skillName[307] = "åŠ é€Ÿå·è½´"
    set ib_skillCustom[307] = 0
    set ib_skillList[308] = 'AIsb'
    set ib_skillName[308] = "å‡é€Ÿä¹‹çƒ"
    set ib_skillCustom[308] = 0
    set ib_skillList[309] = 'AIse'
    set ib_skillName[309] = "ç‰©å“æ²‰é»˜"
    set ib_skillCustom[309] = 0
    set ib_skillList[310] = 'AIsh'
    set ib_skillName[310] = "å¬å”¤å·¨é­”çŒå¤´è€…"
    set ib_skillCustom[310] = 0
    set ib_skillList[311] = 'AIsi'
    set ib_skillName[311] = "èƒ½æé«˜è§†é‡èŒƒå›´çš„ç‰©å“"
    set ib_skillCustom[311] = 0
    set ib_skillList[312] = 'AIsl'
    set ib_skillName[312] = "æ¢å¤å·è½´"
    set ib_skillCustom[312] = 0
    set ib_skillList[313] = 'AIsm'
    set ib_skillName[313] = "èƒ½å¢åŠ åŠ›é‡çš„ç‰©å“"
    set ib_skillCustom[313] = 0
    set ib_skillList[314] = 'AIso'
    set ib_skillName[314] = "èƒ½ç›—å–å•ä½çµé­‚çš„ç‰©å“"
    set ib_skillCustom[314] = 0
    set ib_skillList[315] = 'AIsp'
    set ib_skillName[315] = "èƒ½æš‚æ—¶åŠ å¿«ç§»åŠ¨é€Ÿåº¦çš„ç‰©å“"
    set ib_skillCustom[315] = 0
    set ib_skillList[316] = 'AIsr'
    set ib_skillName[316] = "é­”æ³•ä¼¤å®³å‡å°‘"
    set ib_skillCustom[316] = 0
    set ib_skillList[317] = 'AIsw'
    set ib_skillName[317] = "å²—å“¨å®ˆå«"
    set ib_skillCustom[317] = 0
    set ib_skillList[318] = 'AIsx'
    set ib_skillName[318] = "èƒ½æé«˜æ”»å‡»é€Ÿåº¦çš„ç‰©å“"
    set ib_skillCustom[318] = 0
    set ib_skillList[319] = 'AIsz'
    set ib_skillName[319] = "æ…¢æ€§æ¯’è¯"
    set ib_skillCustom[319] = 0
endfunction
function IB_SkillFill4 takes nothing returns nothing
    set ib_skillList[320] = 'AIt6'
    set ib_skillName[320] = "å¢åŠ æ”»å‡»åŠ›çš„ç‰©å“"
    set ib_skillCustom[320] = 0
    set ib_skillList[321] = 'AIt9'
    set ib_skillName[321] = "å¢åŠ æ”»å‡»åŠ›çš„ç‰©å“"
    set ib_skillCustom[321] = 0
    set ib_skillList[322] = 'AIta'
    set ib_skillName[322] = "èƒ½æ¢æµ‹ä¸€å®šåŒºåŸŸçš„ç‰©å“"
    set ib_skillCustom[322] = 0
    set ib_skillList[323] = 'AItb'
    set ib_skillName[323] = "å°˜åœŸä¹‹å½±"
    set ib_skillCustom[323] = 0
    set ib_skillList[324] = 'AItc'
    set ib_skillName[324] = "å¢åŠ æ”»å‡»åŠ›çš„ç‰©å“"
    set ib_skillCustom[324] = 0
    set ib_skillList[325] = 'AItf'
    set ib_skillName[325] = "å¢åŠ æ”»å‡»åŠ›çš„ç‰©å“"
    set ib_skillCustom[325] = 0
    set ib_skillList[326] = 'AItg'
    set ib_skillName[326] = "å¢åŠ æ”»å‡»åŠ›çš„ç‰©å“"
    set ib_skillCustom[326] = 0
    set ib_skillList[327] = 'AIth'
    set ib_skillName[327] = "å¢åŠ æ”»å‡»åŠ›çš„ç‰©å“"
    set ib_skillCustom[327] = 0
    set ib_skillList[328] = 'AIti'
    set ib_skillName[328] = "å¢åŠ æ”»å‡»åŠ›çš„ç‰©å“"
    set ib_skillCustom[328] = 0
    set ib_skillList[329] = 'AItj'
    set ib_skillName[329] = "å¢åŠ æ”»å‡»åŠ›çš„ç‰©å“"
    set ib_skillCustom[329] = 0
    set ib_skillList[330] = 'AItk'
    set ib_skillName[330] = "å¢åŠ æ”»å‡»åŠ›çš„ç‰©å“"
    set ib_skillCustom[330] = 0
    set ib_skillList[331] = 'AItl'
    set ib_skillName[331] = "å¢åŠ æ”»å‡»åŠ›çš„ç‰©å“"
    set ib_skillCustom[331] = 0
    set ib_skillList[332] = 'AItm'
    set ib_skillName[332] = "èƒ½æé«˜æ™ºåŠ›çš„ç‰©å“"
    set ib_skillCustom[332] = 0
    set ib_skillList[333] = 'AItn'
    set ib_skillName[333] = "å¢åŠ æ”»å‡»åŠ›çš„ç‰©å“"
    set ib_skillCustom[333] = 0
    set ib_skillList[334] = 'AItp'
    set ib_skillName[334] = "å›åŸå·è½´ç‰©å“"
    set ib_skillCustom[334] = 0
    set ib_skillList[335] = 'AItx'
    set ib_skillName[335] = "å¢åŠ æ”»å‡»åŠ›çš„ç‰©å“"
    set ib_skillCustom[335] = 0
    set ib_skillList[336] = 'AIuf'
    set ib_skillName[336] = "é‚ªæ¶ç‹‚çƒ­"
    set ib_skillCustom[336] = 0
    set ib_skillList[337] = 'AIuv'
    set ib_skillName[337] = "å¤œè§†èƒ½åŠ›"
    set ib_skillCustom[337] = 0
    set ib_skillList[338] = 'AIuw'
    set ib_skillName[338] = "èƒ½å¬å”¤ç†Šæ€ªæˆ˜å£«çš„ç‰©å“"
    set ib_skillCustom[338] = 0
    set ib_skillList[339] = 'AIv1'
    set ib_skillName[339] = "èƒ½è®©å•ä½æš‚æ—¶éšèº«çš„ç‰©å“"
    set ib_skillCustom[339] = 0
    set ib_skillList[340] = 'AIv2'
    set ib_skillName[340] = "èƒ½è®©å•ä½æš‚æ—¶éšèº«çš„ç‰©å“"
    set ib_skillCustom[340] = 0
    set ib_skillList[341] = 'AIva'
    set ib_skillName[341] = "èƒ½ç›—å–ç”Ÿå‘½å€¼çš„ç‰©å“"
    set ib_skillCustom[341] = 0
    set ib_skillList[342] = 'AIvi'
    set ib_skillName[342] = "èƒ½è®©å•ä½æš‚æ—¶éšèº«çš„ç‰©å“"
    set ib_skillCustom[342] = 0
    set ib_skillList[343] = 'AIvl'
    set ib_skillName[343] = "èƒ½è®©å•ä½æš‚æ—¶æ— æ•Œçš„ç‰©å“"
    set ib_skillCustom[343] = 0
    set ib_skillList[344] = 'AIvu'
    set ib_skillName[344] = "èƒ½è®©å•ä½æš‚æ—¶æ— æ•Œçš„ç‰©å“"
    set ib_skillCustom[344] = 0
    set ib_skillList[345] = 'AIwb'
    set ib_skillName[345] = "å¸¦æœ‰è››ç½‘æŠ€èƒ½çš„ç‰©å“"
    set ib_skillCustom[345] = 0
    set ib_skillList[346] = 'AIwm'
    set ib_skillName[346] = "æ°´å¥´"
    set ib_skillCustom[346] = 0
    set ib_skillList[347] = 'AIx1'
    set ib_skillName[347] = "èƒ½æé«˜è‹±é›„å±æ€§çš„ç‰©å“"
    set ib_skillCustom[347] = 0
    set ib_skillList[348] = 'AIx2'
    set ib_skillName[348] = "èƒ½æé«˜è‹±é›„å±æ€§çš„ç‰©å“"
    set ib_skillCustom[348] = 0
    set ib_skillList[349] = 'AIx5'
    set ib_skillName[349] = "èƒ½æé«˜è‹±é›„å±æ€§çš„ç‰©å“"
    set ib_skillCustom[349] = 0
    set ib_skillList[350] = 'AIxk'
    set ib_skillName[350] = "ç‹‚æš´æ„¤æ€’"
    set ib_skillCustom[350] = 0
    set ib_skillList[351] = 'AIxm'
    set ib_skillName[351] = "èƒ½æé«˜è‹±é›„ä¸‰ä¸ªå±æ€§çš„ç‰©å“"
    set ib_skillCustom[351] = 0
    set ib_skillList[352] = 'AIxs'
    set ib_skillName[352] = "å…·æœ‰åé­”æ³•ç›¾çš„ç‰©å“"
    set ib_skillCustom[352] = 0
    set ib_skillList[353] = 'AIzb'
    set ib_skillName[353] = "å¸¦æœ‰å†°å†»æ”»å‡»ä¼¤å®³çš„ç‰©å“"
    set ib_skillCustom[353] = 0
    set ib_skillList[354] = 'ANab'
    set ib_skillName[354] = "é…¸æ€§ç‚¸å¼¹"
    set ib_skillCustom[354] = 0
    set ib_skillList[355] = 'ANak'
    set ib_skillName[355] = "åˆšæ¯›é£å°„"
    set ib_skillCustom[355] = 0
    set ib_skillList[356] = 'ANav'
    set ib_skillName[356] = "å¤©ç¥ä¸‹å‡¡"
    set ib_skillCustom[356] = 0
    set ib_skillList[357] = 'ANb2'
    set ib_skillName[357] = "é‡å‡»"
    set ib_skillCustom[357] = 0
    set ib_skillList[358] = 'ANba'
    set ib_skillName[358] = "é»‘æš—ä¹‹ç®­"
    set ib_skillCustom[358] = 0
    set ib_skillList[359] = 'ANbf'
    set ib_skillName[359] = "ç«ç„°å‘¼å¸"
    set ib_skillCustom[359] = 0
    set ib_skillList[360] = 'ANbh'
    set ib_skillName[360] = "é‡å‡»"
    set ib_skillCustom[360] = 0
    set ib_skillList[361] = 'ANbl'
    set ib_skillName[361] = "é—ªçƒ"
    set ib_skillCustom[361] = 0
    set ib_skillList[362] = 'ANbr'
    set ib_skillName[362] = "æˆ˜äº‰å’†å“®"
    set ib_skillCustom[362] = 0
    set ib_skillList[363] = 'ANbs'
    set ib_skillName[363] = "é»‘æš—ä¹‹çƒ"
    set ib_skillCustom[363] = 0
    set ib_skillList[364] = 'ANbu'
    set ib_skillName[364] = "å»ºé€ (ä¸­ç«‹)"
    set ib_skillCustom[364] = 0
    set ib_skillList[365] = 'ANc1'
    set ib_skillName[365] = "ç«ç®­ç¾¤"
    set ib_skillCustom[365] = 0
    set ib_skillList[366] = 'ANc2'
    set ib_skillName[366] = "ç«ç®­ç¾¤"
    set ib_skillCustom[366] = 0
    set ib_skillList[367] = 'ANc3'
    set ib_skillName[367] = "ç«ç®­ç¾¤"
    set ib_skillCustom[367] = 0
    set ib_skillList[368] = 'ANca'
    set ib_skillName[368] = "åˆ†è£‚æ”»å‡»"
    set ib_skillCustom[368] = 0
    set ib_skillList[369] = 'ANcf'
    set ib_skillName[369] = "ç«ç„°å‘¼å¸"
    set ib_skillCustom[369] = 0
    set ib_skillList[370] = 'ANch'
    set ib_skillName[370] = "ç¬¦å’’"
    set ib_skillCustom[370] = 0
    set ib_skillList[371] = 'ANcl'
    set ib_skillName[371] = "é€šé­”"
    set ib_skillCustom[371] = 0
    set ib_skillList[372] = 'ANcr'
    set ib_skillName[372] = "åŒ–å­¦é£æš´"
    set ib_skillCustom[372] = 0
    set ib_skillList[373] = 'ANcs'
    set ib_skillName[373] = "ç«ç®­ç¾¤"
    set ib_skillCustom[373] = 0
    set ib_skillList[374] = 'ANd1'
    set ib_skillName[374] = "ç²‰ç¢"
    set ib_skillCustom[374] = 0
    set ib_skillList[375] = 'ANd2'
    set ib_skillName[375] = "ç²‰ç¢"
    set ib_skillCustom[375] = 0
    set ib_skillList[376] = 'ANd3'
    set ib_skillName[376] = "ç²‰ç¢"
    set ib_skillCustom[376] = 0
    set ib_skillList[377] = 'ANdb'
    set ib_skillName[377] = "é†‰æ‹³"
    set ib_skillCustom[377] = 0
    set ib_skillList[378] = 'ANdc'
    set ib_skillName[378] = "é»‘æš—è½¬æ¢"
    set ib_skillCustom[378] = 0
    set ib_skillList[379] = 'ANde'
    set ib_skillName[379] = "ç²‰ç¢"
    set ib_skillCustom[379] = 0
    set ib_skillList[380] = 'ANdh'
    set ib_skillName[380] = "é†‰é…’äº‘é›¾"
    set ib_skillCustom[380] = 0
    set ib_skillList[381] = 'ANdo'
    set ib_skillName[381] = "æœ«æ—¥å®¡åˆ¤"
    set ib_skillCustom[381] = 0
    set ib_skillList[382] = 'ANdp'
    set ib_skillName[382] = "é»‘æš—ä¹‹é—¨"
    set ib_skillCustom[382] = 0
    set ib_skillList[383] = 'ANdr'
    set ib_skillName[383] = "ç”Ÿå‘½æ±²å–"
    set ib_skillCustom[383] = 0
    set ib_skillList[384] = 'ANef'
    set ib_skillName[384] = "\"ç«åœŸé£æš´\""
    set ib_skillCustom[384] = 0
    set ib_skillList[385] = 'ANeg'
    set ib_skillName[385] = "å·¥ç¨‹å‡çº§"
    set ib_skillCustom[385] = 0
    set ib_skillList[386] = 'ANen'
    set ib_skillName[386] = "è¯±æ•"
    set ib_skillCustom[386] = 0
    set ib_skillList[387] = 'ANf1'
    set ib_skillName[387] = "å·¥å‚"
    set ib_skillCustom[387] = 0
    set ib_skillList[388] = 'ANf2'
    set ib_skillName[388] = "å·¥å‚"
    set ib_skillCustom[388] = 0
    set ib_skillList[389] = 'ANf3'
    set ib_skillName[389] = "å·¥å‚"
    set ib_skillCustom[389] = 0
    set ib_skillList[390] = 'ANfa'
    set ib_skillName[390] = "éœœå†»ä¹‹ç®­"
    set ib_skillCustom[390] = 0
    set ib_skillList[391] = 'ANfb'
    set ib_skillName[391] = "éœ¹é›³é—ªç”µ"
    set ib_skillCustom[391] = 0
    set ib_skillList[392] = 'ANfd'
    set ib_skillName[392] = "æ­»äº¡ä¹‹æŒ‡"
    set ib_skillCustom[392] = 0
    set ib_skillList[393] = 'ANfl'
    set ib_skillName[393] = "å‰çŠ¶é—ªç”µ"
    set ib_skillCustom[393] = 0
    set ib_skillList[394] = 'ANfs'
    set ib_skillName[394] = "çƒˆç„°é£æš´"
    set ib_skillCustom[394] = 0
    set ib_skillList[395] = 'ANfy'
    set ib_skillName[395] = "å·¥å‚"
    set ib_skillCustom[395] = 0
    set ib_skillList[396] = 'ANg1'
    set ib_skillName[396] = "æœºå™¨äººåœ°ç²¾"
    set ib_skillCustom[396] = 0
    set ib_skillList[397] = 'ANg2'
    set ib_skillName[397] = "æœºå™¨äººåœ°ç²¾"
    set ib_skillCustom[397] = 0
    set ib_skillList[398] = 'ANg3'
    set ib_skillName[398] = "æœºå™¨äººåœ°ç²¾"
    set ib_skillCustom[398] = 0
    set ib_skillList[399] = 'ANgl'
    set ib_skillName[399] = "ç”¨é»„é‡‘äº¤æ¢æœ¨æ"
    set ib_skillCustom[399] = 0
endfunction
function IB_SkillFill5 takes nothing returns nothing
    set ib_skillList[400] = 'ANha'
    set ib_skillName[400] = "é‡‡é›†"
    set ib_skillCustom[400] = 0
    set ib_skillList[401] = 'ANhs'
    set ib_skillName[401] = "åŒ»ç–—æ°”é›¾"
    set ib_skillCustom[401] = 0
    set ib_skillList[402] = 'ANht'
    set ib_skillName[402] = "ææ€–åšå«"
    set ib_skillCustom[402] = 0
    set ib_skillList[403] = 'ANhw'
    set ib_skillName[403] = "åŒ»ç–—æ³¢"
    set ib_skillCustom[403] = 0
    set ib_skillList[404] = 'ANhx'
    set ib_skillName[404] = "å¦–æœ¯"
    set ib_skillCustom[404] = 0
    set ib_skillList[405] = 'ANia'
    set ib_skillName[405] = "ç‡ƒç°"
    set ib_skillCustom[405] = 0
    set ib_skillList[406] = 'ANic'
    set ib_skillName[406] = "ç‡ƒç°"
    set ib_skillCustom[406] = 0
    set ib_skillList[407] = 'ANin'
    set ib_skillName[407] = "åœ°ç‹±ç«"
    set ib_skillCustom[407] = 0
    set ib_skillList[408] = 'ANlg'
    set ib_skillName[408] = "ç”¨æœ¨æäº¤æ¢é»„é‡‘"
    set ib_skillCustom[408] = 0
    set ib_skillList[409] = 'ANlm'
    set ib_skillName[409] = "å¬å”¤ç‚é­”"
    set ib_skillCustom[409] = 0
    set ib_skillList[410] = 'ANmo'
    set ib_skillName[410] = "å­£é£"
    set ib_skillCustom[410] = 0
    set ib_skillList[411] = 'ANmr'
    set ib_skillName[411] = "å¿ƒçµè…çƒ‚"
    set ib_skillCustom[411] = 0
    set ib_skillList[412] = 'ANms'
    set ib_skillName[412] = "é­”æ³•æŠ¤ç›¾"
    set ib_skillCustom[412] = 0
    set ib_skillList[413] = 'ANpa'
    set ib_skillName[413] = "å¯„ç”Ÿè™«"
    set ib_skillCustom[413] = 0
    set ib_skillList[414] = 'ANpi'
    set ib_skillName[414] = "æ°¸ä¹…çš„çŒ®ç¥­"
    set ib_skillCustom[414] = 0
    set ib_skillList[415] = 'ANpr'
    set ib_skillName[415] = "ä¿å­˜æƒæ–"
    set ib_skillCustom[415] = 0
    set ib_skillList[416] = 'ANr2'
    set ib_skillName[416] = "é‡ç”Ÿ"
    set ib_skillCustom[416] = 0
    set ib_skillList[417] = 'ANr3'
    set ib_skillName[417] = "æ··ä¹±ä¹‹é›¨"
    set ib_skillCustom[417] = 0
    set ib_skillList[418] = 'ANrc'
    set ib_skillName[418] = "æ··ä¹±ä¹‹é›¨"
    set ib_skillCustom[418] = 0
    set ib_skillList[419] = 'ANre'
    set ib_skillName[419] = "é­”æ³•æ¢å¤å…‰ç¯"
    set ib_skillCustom[419] = 0
    set ib_skillList[420] = 'ANrf'
    set ib_skillName[420] = "ç«ç„°é›¨"
    set ib_skillCustom[420] = 0
    set ib_skillList[421] = 'ANrg'
    set ib_skillName[421] = "æœºå™¨äººåœ°ç²¾"
    set ib_skillCustom[421] = 0
    set ib_skillList[422] = 'ANrl'
    set ib_skillName[422] = "ç”Ÿå‘½å€¼æ¢å¤é€Ÿåº¦"
    set ib_skillCustom[422] = 0
    set ib_skillList[423] = 'ANrn'
    set ib_skillName[423] = "é‡ç”Ÿ"
    set ib_skillCustom[423] = 0
    set ib_skillList[424] = 'ANs1'
    set ib_skillName[424] = "å£è¢‹å·¥å‚"
    set ib_skillCustom[424] = 0
    set ib_skillList[425] = 'ANs2'
    set ib_skillName[425] = "å£è¢‹å·¥å‚"
    set ib_skillCustom[425] = 0
    set ib_skillList[426] = 'ANs3'
    set ib_skillName[426] = "å£è¢‹å·¥å‚"
    set ib_skillCustom[426] = 0
    set ib_skillList[427] = 'ANsa'
    set ib_skillName[427] = "é¿éš¾æƒæ–"
    set ib_skillCustom[427] = 0
    set ib_skillList[428] = 'ANsb'
    set ib_skillName[428] = "é£æš´ä¹‹é”¤"
    set ib_skillCustom[428] = 0
    set ib_skillList[429] = 'ANse'
    set ib_skillName[429] = "é­”æ³•æŠ¤ç›¾"
    set ib_skillCustom[429] = 0
    set ib_skillList[430] = 'ANsg'
    set ib_skillName[430] = "å¬å”¤ç†Š"
    set ib_skillCustom[430] = 0
    set ib_skillList[431] = 'ANsh'
    set ib_skillName[431] = "éœ‡è¡æ³¢"
    set ib_skillCustom[431] = 0
    set ib_skillList[432] = 'ANsi'
    set ib_skillName[432] = "æ²‰é»˜é­”æ³•"
    set ib_skillCustom[432] = 0
    set ib_skillList[433] = 'ANsl'
    set ib_skillName[433] = "çµé­‚ä¿å­˜"
    set ib_skillCustom[433] = 0
    set ib_skillList[434] = 'ANso'
    set ib_skillName[434] = "çµé­‚ç‡ƒçƒ§"
    set ib_skillCustom[434] = 0
    set ib_skillList[435] = 'ANsp'
    set ib_skillName[435] = "é—´è°"
    set ib_skillCustom[435] = 0
    set ib_skillList[436] = 'ANsq'
    set ib_skillName[436] = "å¬å”¤è±ªçŒª"
    set ib_skillCustom[436] = 0
    set ib_skillList[437] = 'ANss'
    set ib_skillName[437] = "é­”æ³•æŠ¤ç›¾"
    set ib_skillCustom[437] = 0
    set ib_skillList[438] = 'ANst'
    set ib_skillName[438] = "æƒŠå“"
    set ib_skillCustom[438] = 0
    set ib_skillList[439] = 'ANsw'
    set ib_skillName[439] = "å¬å”¤æˆ˜é¹°"
    set ib_skillCustom[439] = 0
    set ib_skillList[440] = 'ANsy'
    set ib_skillName[440] = "å£è¢‹å·¥å‚"
    set ib_skillCustom[440] = 0
    set ib_skillList[441] = 'ANt2'
    set ib_skillName[441] = "å°–åˆºå¤–å£³"
    set ib_skillCustom[441] = 0
    set ib_skillList[442] = 'ANta'
    set ib_skillName[442] = "å˜²è®½"
    set ib_skillCustom[442] = 0
    set ib_skillList[443] = 'ANth'
    set ib_skillName[443] = "å°–åˆºå¤–å£³"
    set ib_skillCustom[443] = 0
    set ib_skillList[444] = 'ANtm'
    set ib_skillName[444] = "ç‚¹é‡‘æœ¯"
    set ib_skillCustom[444] = 0
    set ib_skillList[445] = 'ANto'
    set ib_skillName[445] = "é¾™å·é£"
    set ib_skillCustom[445] = 0
    set ib_skillList[446] = 'ANtr'
    set ib_skillName[446] = "çœŸå®è§†åŸŸ"
    set ib_skillCustom[446] = 0
    set ib_skillList[447] = 'ANvc'
    set ib_skillName[447] = "ç«å±±çˆ†å‘"
    set ib_skillCustom[447] = 0
    set ib_skillList[448] = 'ANwk'
    set ib_skillName[448] = "ç–¾é£æ­¥"
    set ib_skillCustom[448] = 0
    set ib_skillList[449] = 'ANwm'
    set ib_skillName[449] = "æ°´å¥´"
    set ib_skillCustom[449] = 0
    set ib_skillList[450] = 'AOac'
    set ib_skillName[450] = "å‘½ä»¤å…‰ç¯"
    set ib_skillCustom[450] = 0
    set ib_skillList[451] = 'AOae'
    set ib_skillName[451] = "è€ä¹…å…‰ç¯"
    set ib_skillCustom[451] = 0
    set ib_skillList[452] = 'AObu'
    set ib_skillName[452] = "å»ºé€ (å…½æ—)"
    set ib_skillCustom[452] = 0
    set ib_skillList[453] = 'AOcl'
    set ib_skillName[453] = "é—ªç”µé“¾"
    set ib_skillCustom[453] = 0
    set ib_skillList[454] = 'AOcr'
    set ib_skillName[454] = "è‡´å‘½ä¸€å‡»"
    set ib_skillCustom[454] = 0
    set ib_skillList[455] = 'AOeq'
    set ib_skillName[455] = "åœ°éœ‡"
    set ib_skillCustom[455] = 0
    set ib_skillList[456] = 'AOfs'
    set ib_skillName[456] = "é€è§†"
    set ib_skillCustom[456] = 0
    set ib_skillList[457] = 'AOhw'
    set ib_skillName[457] = "åŒ»ç–—æ³¢"
    set ib_skillCustom[457] = 0
    set ib_skillList[458] = 'AOhx'
    set ib_skillName[458] = "å¦–æœ¯"
    set ib_skillCustom[458] = 0
    set ib_skillList[459] = 'AOls'
    set ib_skillName[459] = "å·«æ¯’å¹½é­‚"
    set ib_skillCustom[459] = 0
    set ib_skillList[460] = 'AOmi'
    set ib_skillName[460] = "é•œåƒ"
    set ib_skillCustom[460] = 0
    set ib_skillList[461] = 'AOr2'
    set ib_skillName[461] = "è€ä¹…å…‰ç¯"
    set ib_skillCustom[461] = 0
    set ib_skillList[462] = 'AOr3'
    set ib_skillName[462] = "é‡ç”Ÿ"
    set ib_skillCustom[462] = 0
    set ib_skillList[463] = 'AOre'
    set ib_skillName[463] = "é‡ç”Ÿ"
    set ib_skillCustom[463] = 0
    set ib_skillList[464] = 'AOs2'
    set ib_skillName[464] = "éœ‡è¡æ³¢"
    set ib_skillCustom[464] = 0
    set ib_skillList[465] = 'AOsf'
    set ib_skillName[465] = "é‡å…½å¹½é­‚"
    set ib_skillCustom[465] = 0
    set ib_skillList[466] = 'AOsh'
    set ib_skillName[466] = "éœ‡è¡æ³¢"
    set ib_skillCustom[466] = 0
    set ib_skillList[467] = 'AOsw'
    set ib_skillName[467] = "æ¯’è›‡å®ˆå«"
    set ib_skillCustom[467] = 0
    set ib_skillList[468] = 'AOvd'
    set ib_skillName[468] = "å·«æ¯’"
    set ib_skillCustom[468] = 0
    set ib_skillList[469] = 'AOw2'
    set ib_skillName[469] = "æˆ˜äº‰è·µè¸"
    set ib_skillCustom[469] = 0
    set ib_skillList[470] = 'AOwk'
    set ib_skillName[470] = "ç–¾æ­¥é£"
    set ib_skillCustom[470] = 0
    set ib_skillList[471] = 'AOws'
    set ib_skillName[471] = "æˆ˜äº‰è·µè¸"
    set ib_skillCustom[471] = 0
    set ib_skillList[472] = 'AOww'
    set ib_skillName[472] = "å‰‘åˆƒé£æš´"
    set ib_skillCustom[472] = 0
    set ib_skillList[473] = 'APdi'
    set ib_skillName[473] = "åŠ›é‡ä¸Šå‡é©±æ•£"
    set ib_skillCustom[473] = 0
    set ib_skillList[474] = 'APh1'
    set ib_skillName[474] = "åŠ›é‡ä¸Šå‡æ²»ç–—åŒºåŸŸå‡å°"
    set ib_skillCustom[474] = 0
    set ib_skillList[475] = 'APh2'
    set ib_skillName[475] = "åŠ›é‡ä¸Šå‡æ²»ç–—åŒºåŸŸ"
    set ib_skillCustom[475] = 0
    set ib_skillList[476] = 'APh3'
    set ib_skillName[476] = "åŠ›é‡ä¸Šå‡æ²»ç–—åŒºåŸŸå¢å¼º"
    set ib_skillCustom[476] = 0
    set ib_skillList[477] = 'APmg'
    set ib_skillName[477] = "ç¥ç§˜åŒºåŸŸé­”æ³•æ¢å¤å¢å¼º"
    set ib_skillCustom[477] = 0
    set ib_skillList[478] = 'APmr'
    set ib_skillName[478] = "ç¥ç§˜åŒºåŸŸé­”æ³•æ¢å¤"
    set ib_skillCustom[478] = 0
    set ib_skillList[479] = 'APra'
    set ib_skillName[479] = "ç¥ç§˜åŒºåŸŸç”Ÿå‘½/é­”æ³•æ¢å¤"
    set ib_skillCustom[479] = 0
endfunction
function IB_SkillFill6 takes nothing returns nothing
    set ib_skillList[480] = 'APrl'
    set ib_skillName[480] = "å°å‹å¤æ´»ç¥ç¬¦"
    set ib_skillCustom[480] = 0
    set ib_skillList[481] = 'APrr'
    set ib_skillName[481] = "å¤§å‹å¤æ´»ç¥ç¬¦"
    set ib_skillCustom[481] = 0
    set ib_skillList[482] = 'APsa'
    set ib_skillName[482] = "é€Ÿåº¦ç¥ç¬¦"
    set ib_skillCustom[482] = 0
    set ib_skillList[483] = 'APwt'
    set ib_skillName[483] = "å²—å“¨ç¥ç¬¦"
    set ib_skillCustom[483] = 0
    set ib_skillList[484] = 'ARal'
    set ib_skillName[484] = "é›†ç»“"
    set ib_skillCustom[484] = 0
    set ib_skillList[485] = 'AUan'
    set ib_skillName[485] = "æ“çºµæ­»å°¸"
    set ib_skillCustom[485] = 0
    set ib_skillList[486] = 'AUau'
    set ib_skillName[486] = "é‚ªæ¶å…‰ç¯"
    set ib_skillCustom[486] = 0
    set ib_skillList[487] = 'AUav'
    set ib_skillName[487] = "å¸è¡€å…‰ç¯"
    set ib_skillCustom[487] = 0
    set ib_skillList[488] = 'AUbu'
    set ib_skillName[488] = "å»ºé€ (ä¸æ­»æ—)"
    set ib_skillCustom[488] = 0
    set ib_skillList[489] = 'AUcb'
    set ib_skillName[489] = "è…å°¸ç”²è™«"
    set ib_skillCustom[489] = 0
    set ib_skillList[490] = 'AUcs'
    set ib_skillName[490] = "è…è‡­èœ‚ç¾¤"
    set ib_skillCustom[490] = 0
    set ib_skillList[491] = 'AUdc'
    set ib_skillName[491] = "æ­»äº¡ç¼ ç»•"
    set ib_skillCustom[491] = 0
    set ib_skillList[492] = 'AUdd'
    set ib_skillName[492] = "æ­»äº¡å‡‹é›¶"
    set ib_skillCustom[492] = 0
    set ib_skillList[493] = 'AUdp'
    set ib_skillName[493] = "æ­»äº¡å¥‘çº¦"
    set ib_skillCustom[493] = 0
    set ib_skillList[494] = 'AUdr'
    set ib_skillName[494] = "é»‘æš—ä»ªå¼"
    set ib_skillCustom[494] = 0
    set ib_skillList[495] = 'AUds'
    set ib_skillName[495] = "é»‘æš—å¬å”¤"
    set ib_skillCustom[495] = 0
    set ib_skillList[496] = 'AUfa'
    set ib_skillName[496] = "éœœå†»æŠ¤ç”²"
    set ib_skillCustom[496] = 0
    set ib_skillList[497] = 'AUfn'
    set ib_skillName[497] = "éœœå†»æ–°æ˜Ÿ"
    set ib_skillCustom[497] = 0
    set ib_skillList[498] = 'AUfu'
    set ib_skillName[498] = "éœœå†»æŠ¤ç”²"
    set ib_skillCustom[498] = 0
    set ib_skillList[499] = 'AUim'
    set ib_skillName[499] = "ç©¿åˆº"
    set ib_skillCustom[499] = 0
    set ib_skillList[500] = 'AUin'
    set ib_skillName[500] = "åœ°ç‹±ç«"
    set ib_skillCustom[500] = 0
    set ib_skillList[501] = 'AUls'
    set ib_skillName[501] = "è—è™«ç¾¤"
    set ib_skillCustom[501] = 0
    set ib_skillList[502] = 'AUmd'
    set ib_skillName[502] = "é»‘æš—å¬å”¤(é©¬å“¥å°¼æ–¯)"
    set ib_skillCustom[502] = 0
    set ib_skillList[503] = 'AUsl'
    set ib_skillName[503] = "ç¡çœ "
    set ib_skillCustom[503] = 0
    set ib_skillList[504] = 'AUts'
    set ib_skillName[504] = "å°–åˆºå¤–å£³"
    set ib_skillCustom[504] = 0
    set ib_skillList[505] = 'Aabr'
    set ib_skillName[505] = "è’èŠœå…‰ç¯"
    set ib_skillCustom[505] = 0
    set ib_skillList[506] = 'Aabs'
    set ib_skillName[506] = "å¸æ”¶é­”æ³•"
    set ib_skillCustom[506] = 0
    set ib_skillList[507] = 'Aadm'
    set ib_skillName[507] = "é©±é€é­”æ³•"
    set ib_skillCustom[507] = 0
    set ib_skillList[508] = 'Aaha'
    set ib_skillName[508] = "é‡‡é›†"
    set ib_skillCustom[508] = 0
    set ib_skillList[509] = 'Aakb'
    set ib_skillName[509] = "æˆ˜é¼“"
    set ib_skillCustom[509] = 0
    set ib_skillList[510] = 'Aall'
    set ib_skillName[510] = "å…±äº«å•†åº—ï¼Œè”ç›Ÿå»ºç­‘ç‰©"
    set ib_skillCustom[510] = 0
    set ib_skillList[511] = 'Aalr'
    set ib_skillName[511] = "è­¦æŠ¥"
    set ib_skillCustom[511] = 0
    set ib_skillList[512] = 'Aam2'
    set ib_skillName[512] = "åé­”æ³•å¤–å£³"
    set ib_skillCustom[512] = 0
    set ib_skillList[513] = 'Aami'
    set ib_skillName[513] = "å…·æœ‰åé­”æ³•ç›¾çš„ç‰©å“"
    set ib_skillCustom[513] = 0
    set ib_skillList[514] = 'Aamk'
    set ib_skillName[514] = "å±æ€§é™„åŠ "
    set ib_skillCustom[514] = 0
    set ib_skillList[515] = 'Aams'
    set ib_skillName[515] = "åé­”æ³•å¤–å£³"
    set ib_skillCustom[515] = 0
    set ib_skillList[516] = 'Aap1'
    set ib_skillName[516] = "ç–¾ç—…äº‘é›¾"
    set ib_skillCustom[516] = 0
    set ib_skillList[517] = 'Aap2'
    set ib_skillName[517] = "ç–¾ç—…äº‘é›¾"
    set ib_skillCustom[517] = 0
    set ib_skillList[518] = 'Aap3'
    set ib_skillName[518] = "ç–¾ç—…äº‘é›¾"
    set ib_skillCustom[518] = 0
    set ib_skillList[519] = 'Aap4'
    set ib_skillName[519] = "ç–¾ç—…äº‘é›¾"
    set ib_skillCustom[519] = 0
    set ib_skillList[520] = 'Aapl'
    set ib_skillName[520] = "ç–¾ç—…äº‘é›¾"
    set ib_skillCustom[520] = 0
    set ib_skillList[521] = 'Aarm'
    set ib_skillName[521] = "é­”æ³•æ¢å¤å…‰ç¯"
    set ib_skillCustom[521] = 0
    set ib_skillList[522] = 'Aasl'
    set ib_skillName[522] = "å‡é€Ÿå…‰ç¯"
    set ib_skillCustom[522] = 0
    set ib_skillList[523] = 'Aast'
    set ib_skillName[523] = "å…ˆç¥–å¹½çµ"
    set ib_skillCustom[523] = 0
    set ib_skillList[524] = 'Aatk'
    set ib_skillName[524] = "æ”»å‡»"
    set ib_skillCustom[524] = 0
    set ib_skillList[525] = 'Aave'
    set ib_skillName[525] = "ç ´åè€…å½¢æ€"
    set ib_skillCustom[525] = 0
    set ib_skillList[526] = 'Aawa'
    set ib_skillName[526] = "ç«‹åˆ»å¤æ´»è‹±é›„"
    set ib_skillCustom[526] = 0
    set ib_skillList[527] = 'Abdl'
    set ib_skillName[527] = "å¤§å‹è’èŠœä¹‹åœ°é©±æ•£"
    set ib_skillCustom[527] = 0
    set ib_skillList[528] = 'Abds'
    set ib_skillName[528] = "å°å‹è’èŠœä¹‹åœ°é©±æ•£"
    set ib_skillCustom[528] = 0
    set ib_skillList[529] = 'Abdt'
    set ib_skillName[529] = "é’»åœ°æ¢æµ‹"
    set ib_skillCustom[529] = 0
    set ib_skillList[530] = 'Abgl'
    set ib_skillName[530] = "å¤§å‹è’èŠœä¹‹åœ°è”“å»¶"
    set ib_skillCustom[530] = 0
    set ib_skillList[531] = 'Abgm'
    set ib_skillName[531] = "é—¹é¬¼é‡‘çŸ¿æŠ€èƒ½"
    set ib_skillCustom[531] = 0
    set ib_skillList[532] = 'Abgs'
    set ib_skillName[532] = "å°å‹è’èŠœä¹‹åœ°è”“å»¶"
    set ib_skillCustom[532] = 0
    set ib_skillList[533] = 'Abli'
    set ib_skillName[533] = "è’èŠœä¹‹åœ°"
    set ib_skillCustom[533] = 0
    set ib_skillList[534] = 'Ablo'
    set ib_skillName[534] = "å—œè¡€æœ¯"
    set ib_skillCustom[534] = 0
    set ib_skillList[535] = 'Ablp'
    set ib_skillName[535] = "è’èŠœä¹‹åœ°çš„ç½®æ”¾"
    set ib_skillCustom[535] = 0
    set ib_skillList[536] = 'Abof'
    set ib_skillName[536] = "ç‡ƒçƒ§ä¹‹æ²¹"
    set ib_skillCustom[536] = 0
    set ib_skillList[537] = 'Abrf'
    set ib_skillName[537] = "å˜ç†Š"
    set ib_skillCustom[537] = 0
    set ib_skillList[538] = 'Absk'
    set ib_skillName[538] = "ç‹‚æˆ˜å£«"
    set ib_skillCustom[538] = 0
    set ib_skillList[539] = 'Abtl'
    set ib_skillName[539] = "æˆ˜æ–—ä½ç½®"
    set ib_skillCustom[539] = 0
    set ib_skillList[540] = 'Abu2'
    set ib_skillName[540] = "é’»åœ°"
    set ib_skillCustom[540] = 0
    set ib_skillList[541] = 'Abu3'
    set ib_skillName[541] = "é’»åœ°"
    set ib_skillCustom[541] = 0
    set ib_skillList[542] = 'Abu5'
    set ib_skillName[542] = "é’»åœ°"
    set ib_skillCustom[542] = 0
    set ib_skillList[543] = 'Abun'
    set ib_skillName[543] = "è´§ç‰©ä¿æŒ (å…½æ—åœ°æ´)"
    set ib_skillCustom[543] = 0
    set ib_skillList[544] = 'Abur'
    set ib_skillName[544] = "é’»åœ°"
    set ib_skillCustom[544] = 0
    set ib_skillList[545] = 'Acan'
    set ib_skillName[545] = "åé£Ÿå°¸ä½“"
    set ib_skillCustom[545] = 0
    set ib_skillList[546] = 'Acar'
    set ib_skillName[546] = "è´§ç‰©ä¿æŒ"
    set ib_skillCustom[546] = 0
    set ib_skillList[547] = 'Acdb'
    set ib_skillName[547] = "é†‰æ‹³"
    set ib_skillCustom[547] = 0
    set ib_skillList[548] = 'Acdh'
    set ib_skillName[548] = "é†‰é…’äº‘é›¾"
    set ib_skillCustom[548] = 0
    set ib_skillList[549] = 'Acef'
    set ib_skillName[549] = "\"ç«åœŸé£æš´\""
    set ib_skillCustom[549] = 0
    set ib_skillList[550] = 'Acha'
    set ib_skillName[550] = "æ··ä¹±çš„"
    set ib_skillCustom[550] = 0
    set ib_skillList[551] = 'Achd'
    set ib_skillName[551] = "è¿è¾“èˆ¹ä¿æŒåŸä½"
    set ib_skillCustom[551] = 0
    set ib_skillList[552] = 'Ache'
    set ib_skillName[552] = "ç“¦è§£å…‰çº¿"
    set ib_skillCustom[552] = 0
    set ib_skillList[553] = 'Achl'
    set ib_skillName[553] = "è£…è½½"
    set ib_skillCustom[553] = 0
    set ib_skillList[554] = 'Acht'
    set ib_skillName[554] = "ææ€–åšå«"
    set ib_skillCustom[554] = 0
    set ib_skillList[555] = 'Aclf'
    set ib_skillName[555] = "ä¹Œäº‘æŠ€èƒ½"
    set ib_skillCustom[555] = 0
    set ib_skillList[556] = 'Acmg'
    set ib_skillName[556] = "æ§åˆ¶é­”æ³•"
    set ib_skillCustom[556] = 0
    set ib_skillList[557] = 'Acn2'
    set ib_skillName[557] = "åé£Ÿå°¸ä½“"
    set ib_skillCustom[557] = 0
    set ib_skillList[558] = 'Acny'
    set ib_skillName[558] = "é£“é£"
    set ib_skillCustom[558] = 0
    set ib_skillList[559] = 'Aco2'
    set ib_skillName[559] = "éª‘ä¹˜è§’é¹°å…½"
    set ib_skillCustom[559] = 0
endfunction
function IB_SkillFill7 takes nothing returns nothing
    set ib_skillList[560] = 'Aco3'
    set ib_skillName[560] = "æ­è½½å¼“ç®­æ‰‹"
    set ib_skillCustom[560] = 0
    set ib_skillList[561] = 'Acoa'
    set ib_skillName[561] = "éª‘ä¹˜è§’é¹°å…½"
    set ib_skillCustom[561] = 0
    set ib_skillList[562] = 'Acoh'
    set ib_skillName[562] = "æ­è½½å¼“ç®­æ‰‹"
    set ib_skillCustom[562] = 0
    set ib_skillList[563] = 'Acor'
    set ib_skillName[563] = "è…èš€å–·å"
    set ib_skillCustom[563] = 0
    set ib_skillList[564] = 'Acpf'
    set ib_skillName[564] = "çµè‚‰å½¢æ€"
    set ib_skillCustom[564] = 0
    set ib_skillList[565] = 'Acri'
    set ib_skillName[565] = "æ®‹åºŸ"
    set ib_skillCustom[565] = 0
    set ib_skillList[566] = 'Acrs'
    set ib_skillName[566] = "è¯…å’’"
    set ib_skillCustom[566] = 0
    set ib_skillList[567] = 'Acyc'
    set ib_skillName[567] = "é£“é£"
    set ib_skillCustom[567] = 0
    set ib_skillList[568] = 'Adch'
    set ib_skillName[568] = "æ¶ˆé­”"
    set ib_skillCustom[568] = 0
    set ib_skillList[569] = 'Adcn'
    set ib_skillName[569] = "æ¶ˆé­”"
    set ib_skillCustom[569] = 0
    set ib_skillList[570] = 'Adda'
    set ib_skillName[570] = "èŒƒå›´æ€§æ”»å‡»ä¼¤å®³"
    set ib_skillCustom[570] = 0
    set ib_skillList[571] = 'Adec'
    set ib_skillName[571] = "å¸è½½"
    set ib_skillCustom[571] = 0
    set ib_skillList[572] = 'Adef'
    set ib_skillName[572] = "é˜²å¾¡"
    set ib_skillCustom[572] = 0
    set ib_skillList[573] = 'Adet'
    set ib_skillName[573] = "æ¢æµ‹è€…"
    set ib_skillCustom[573] = 0
    set ib_skillList[574] = 'Adev'
    set ib_skillName[574] = "åå™¬"
    set ib_skillCustom[574] = 0
    set ib_skillList[575] = 'Adis'
    set ib_skillName[575] = "é©±é€é­”æ³•"
    set ib_skillCustom[575] = 0
    set ib_skillList[576] = 'Adri'
    set ib_skillName[576] = "ç«‹åˆ»å¸è½½"
    set ib_skillCustom[576] = 0
    set ib_skillList[577] = 'Adro'
    set ib_skillName[577] = "å¸è½½"
    set ib_skillCustom[577] = 0
    set ib_skillList[578] = 'Adsm'
    set ib_skillName[578] = "é©±é€é­”æ³•"
    set ib_skillCustom[578] = 0
    set ib_skillList[579] = 'Adt1'
    set ib_skillName[579] = "æ¢æµ‹è€…"
    set ib_skillCustom[579] = 0
    set ib_skillList[580] = 'Adta'
    set ib_skillName[580] = "æ˜¾ç¤º"
    set ib_skillCustom[580] = 0
    set ib_skillList[581] = 'Adtg'
    set ib_skillName[581] = "çœŸå®è§†åŸŸ"
    set ib_skillCustom[581] = 0
    set ib_skillList[582] = 'Adtn'
    set ib_skillName[582] = "çˆ†ç‚¸"
    set ib_skillCustom[582] = 0
    set ib_skillList[583] = 'Adts'
    set ib_skillName[583] = "é­”æ³•å²—å“¨"
    set ib_skillCustom[583] = 0
    set ib_skillList[584] = 'Advc'
    set ib_skillName[584] = "åå™¬è´§ç‰©"
    set ib_skillCustom[584] = 0
    set ib_skillList[585] = 'Advm'
    set ib_skillName[585] = "åå™¬é­”æ³•"
    set ib_skillCustom[585] = 0
    set ib_skillList[586] = 'Aeat'
    set ib_skillName[586] = "åé£Ÿæ ‘æœ¨"
    set ib_skillCustom[586] = 0
    set ib_skillList[587] = 'Aegm'
    set ib_skillName[587] = "ç¼ ç»•é‡‘çŸ¿æŠ€èƒ½"
    set ib_skillCustom[587] = 0
    set ib_skillList[588] = 'Aegr'
    set ib_skillName[588] = "è‰¾é²å°¼ä¹‹ä¼˜é›…"
    set ib_skillCustom[588] = 0
    set ib_skillList[589] = 'Aenc'
    set ib_skillName[589] = "è£…è½½"
    set ib_skillCustom[589] = 0
    set ib_skillList[590] = 'Aenr'
    set ib_skillName[590] = "çº ç¼ æ ¹é¡»"
    set ib_skillCustom[590] = 0
    set ib_skillList[591] = 'Aens'
    set ib_skillName[591] = "è¯±æ•"
    set ib_skillCustom[591] = 0
    set ib_skillList[592] = 'Aent'
    set ib_skillName[592] = "ç¼ ç»•é‡‘çŸ¿"
    set ib_skillCustom[592] = 0
    set ib_skillList[593] = 'Aenw'
    set ib_skillName[593] = "çº ç¼ æ ¹é¡»"
    set ib_skillCustom[593] = 0
    set ib_skillList[594] = 'Aesn'
    set ib_skillName[594] = "å“¨å…µ"
    set ib_skillCustom[594] = 0
    set ib_skillList[595] = 'Aesr'
    set ib_skillName[595] = "å“¨å…µ"
    set ib_skillCustom[595] = 0
    set ib_skillList[596] = 'Aetf'
    set ib_skillName[596] = "è™šæ— å½¢æ€"
    set ib_skillCustom[596] = 0
    set ib_skillList[597] = 'Aeth'
    set ib_skillName[597] = "å¹½çµ"
    set ib_skillCustom[597] = 0
    set ib_skillList[598] = 'Aetl'
    set ib_skillName[598] = "è™šæ— çŠ¶æ€"
    set ib_skillCustom[598] = 0
    set ib_skillList[599] = 'Aexh'
    set ib_skillName[599] = "æŒ–æ˜å°¸ä½“"
    set ib_skillCustom[599] = 0
    set ib_skillList[600] = 'Aeye'
    set ib_skillName[600] = "å²—å“¨å®ˆå«"
    set ib_skillCustom[600] = 0
    set ib_skillList[601] = 'Afa2'
    set ib_skillName[601] = "ç²¾çµä¹‹ç«"
    set ib_skillCustom[601] = 0
    set ib_skillList[602] = 'Afae'
    set ib_skillName[602] = "ç²¾çµä¹‹ç«"
    set ib_skillCustom[602] = 0
    set ib_skillList[603] = 'Afak'
    set ib_skillName[603] = "æ¯ç­ä¹‹çƒ"
    set ib_skillCustom[603] = 0
    set ib_skillList[604] = 'Afbb'
    set ib_skillName[604] = "åé¦ˆ"
    set ib_skillCustom[604] = 0
    set ib_skillList[605] = 'Afbk'
    set ib_skillName[605] = "é­”æ³•å›åº”"
    set ib_skillCustom[605] = 0
    set ib_skillList[606] = 'Afbt'
    set ib_skillName[606] = "é­”æ³•å›åº”"
    set ib_skillCustom[606] = 0
    set ib_skillList[607] = 'Afih'
    set ib_skillName[607] = "ç€ç«(äººæ—)"
    set ib_skillCustom[607] = 0
    set ib_skillList[608] = 'Afin'
    set ib_skillName[608] = "ç€ç«(æš—å¤œç²¾çµ)"
    set ib_skillCustom[608] = 0
    set ib_skillList[609] = 'Afio'
    set ib_skillName[609] = "ç€ç«(å…½æ—)"
    set ib_skillCustom[609] = 0
    set ib_skillList[610] = 'Afir'
    set ib_skillName[610] = "ç€ç«"
    set ib_skillCustom[610] = 0
    set ib_skillList[611] = 'Afiu'
    set ib_skillName[611] = "ç€ç«(ä¸æ­»æ—)"
    set ib_skillCustom[611] = 0
    set ib_skillList[612] = 'Afla'
    set ib_skillName[612] = "ç…§æ˜å¼¹"
    set ib_skillCustom[612] = 0
    set ib_skillList[613] = 'Aflk'
    set ib_skillName[613] = "é«˜å°„ç‚®ç«"
    set ib_skillCustom[613] = 0
    set ib_skillList[614] = 'Afod'
    set ib_skillName[614] = "æ­»äº¡ä¹‹æŒ‡"
    set ib_skillCustom[614] = 0
    set ib_skillList[615] = 'Afr2'
    set ib_skillName[615] = "éœœå†»æ”»å‡»"
    set ib_skillCustom[615] = 0
    set ib_skillList[616] = 'Afra'
    set ib_skillName[616] = "éœœä¹‹æ”»å‡»"
    set ib_skillCustom[616] = 0
    set ib_skillList[617] = 'Afrb'
    set ib_skillName[617] = "éœœå†»å‘¼å¸"
    set ib_skillCustom[617] = 0
    set ib_skillList[618] = 'Afrz'
    set ib_skillName[618] = "å†°å†»å–·å"
    set ib_skillCustom[618] = 0
    set ib_skillList[619] = 'Afsh'
    set ib_skillName[619] = "ç¢ç‰‡æ”»å‡»"
    set ib_skillCustom[619] = 0
    set ib_skillList[620] = 'Afzy'
    set ib_skillName[620] = "ç‹‚çƒ­"
    set ib_skillCustom[620] = 0
    set ib_skillList[621] = 'Agho'
    set ib_skillName[621] = "å¹½çµ"
    set ib_skillCustom[621] = 0
    set ib_skillList[622] = 'Agld'
    set ib_skillName[622] = "é‡‘çŸ¿èƒ½åŠ›"
    set ib_skillCustom[622] = 0
    set ib_skillList[623] = 'Agra'
    set ib_skillName[623] = "æˆ˜æ£"
    set ib_skillCustom[623] = 0
    set ib_skillList[624] = 'Agyb'
    set ib_skillName[624] = "é£è¡Œæœºå™¨ç‚¸å¼¹"
    set ib_skillCustom[624] = 0
    set ib_skillList[625] = 'Agyd'
    set ib_skillName[625] = "åˆ›å»ºå°¸ä½“"
    set ib_skillCustom[625] = 0
    set ib_skillList[626] = 'Agyv'
    set ib_skillName[626] = "çœŸå®è§†åŸŸ"
    set ib_skillCustom[626] = 0
    set ib_skillList[627] = 'Ahar'
    set ib_skillName[627] = "é‡‡é›†"
    set ib_skillCustom[627] = 0
    set ib_skillList[628] = 'Ahea'
    set ib_skillName[628] = "åŒ»ç–—"
    set ib_skillCustom[628] = 0
    set ib_skillList[629] = 'Ahid'
    set ib_skillName[629] = "å½±é"
    set ib_skillCustom[629] = 0
    set ib_skillList[630] = 'Ahnl'
    set ib_skillName[630] = "å¬å”¤ä»ªå¼"
    set ib_skillCustom[630] = 0
    set ib_skillList[631] = 'Ahr2'
    set ib_skillName[631] = "é‡‡é›†"
    set ib_skillCustom[631] = 0
    set ib_skillList[632] = 'Ahr3'
    set ib_skillName[632] = "é‡‡é›†"
    set ib_skillCustom[632] = 0
    set ib_skillList[633] = 'Ahrl'
    set ib_skillName[633] = "é‡‡é›†"
    set ib_skillCustom[633] = 0
    set ib_skillList[634] = 'Ahrp'
    set ib_skillName[634] = "ä¿®ç†"
    set ib_skillCustom[634] = 0
    set ib_skillList[635] = 'Ahwd'
    set ib_skillName[635] = "æ²»ç–—å®ˆå«"
    set ib_skillCustom[635] = 0
    set ib_skillList[636] = 'Aien'
    set ib_skillName[636] = "å•ä½ç‰©å“æ "
    set ib_skillCustom[636] = 0
    set ib_skillList[637] = 'Aihn'
    set ib_skillName[637] = "å•ä½ç‰©å“æ "
    set ib_skillCustom[637] = 0
    set ib_skillList[638] = 'Ainf'
    set ib_skillName[638] = "å¿ƒçµä¹‹ç«"
    set ib_skillCustom[638] = 0
    set ib_skillList[639] = 'Aion'
    set ib_skillName[639] = "å•ä½ç‰©å“æ "
    set ib_skillCustom[639] = 0
endfunction
function IB_SkillFill8 takes nothing returns nothing
    set ib_skillList[640] = 'Aiun'
    set ib_skillName[640] = "å•ä½ç‰©å“æ "
    set ib_skillCustom[640] = 0
    set ib_skillList[641] = 'Aivs'
    set ib_skillName[641] = "éšå½¢æœ¯"
    set ib_skillCustom[641] = 0
    set ib_skillList[642] = 'Alam'
    set ib_skillName[642] = "ç‰ºç‰²"
    set ib_skillCustom[642] = 0
    set ib_skillList[643] = 'Aliq'
    set ib_skillName[643] = "æ¶²ä½“ç‚¸å¼¹"
    set ib_skillCustom[643] = 0
    set ib_skillList[644] = 'Alit'
    set ib_skillName[644] = "é—ªç”µæ”»å‡»"
    set ib_skillCustom[644] = 0
    set ib_skillList[645] = 'Aloa'
    set ib_skillName[645] = "è£…è½½"
    set ib_skillCustom[645] = 0
    set ib_skillList[646] = 'Aloc'
    set ib_skillName[646] = "è—è™«"
    set ib_skillCustom[646] = 0
    set ib_skillList[647] = 'Alsh'
    set ib_skillName[647] = "é—ªç”µæŠ¤ç›¾"
    set ib_skillCustom[647] = 0
    set ib_skillList[648] = 'Amb2'
    set ib_skillName[648] = "æ¢å¤é­”æ³•"
    set ib_skillCustom[648] = 0
    set ib_skillList[649] = 'Ambb'
    set ib_skillName[649] = "æ³•åŠ›ç‡ƒçƒ§"
    set ib_skillCustom[649] = 0
    set ib_skillList[650] = 'Ambd'
    set ib_skillName[650] = "æ³•åŠ›ç‡ƒçƒ§"
    set ib_skillCustom[650] = 0
    set ib_skillList[651] = 'Ambt'
    set ib_skillName[651] = "è¡¥å……é­”æ³•å’Œç”Ÿå‘½å€¼"
    set ib_skillCustom[651] = 0
    set ib_skillList[652] = 'Amdf'
    set ib_skillName[652] = "é­”æ³•é˜²å¾¡"
    set ib_skillCustom[652] = 0
    set ib_skillList[653] = 'Amec'
    set ib_skillName[653] = "æœºæ¢°ç±»çš„å°ç©è‰º"
    set ib_skillCustom[653] = 0
    set ib_skillList[654] = 'Amed'
    set ib_skillName[654] = "å¸è½½å°¸ä½“"
    set ib_skillCustom[654] = 0
    set ib_skillList[655] = 'Amel'
    set ib_skillName[655] = "å¾—åˆ°å°¸ä½“"
    set ib_skillCustom[655] = 0
    set ib_skillList[656] = 'Amfl'
    set ib_skillName[656] = "é­”åŠ›ä¹‹ç„°"
    set ib_skillCustom[656] = 0
    set ib_skillList[657] = 'Amgl'
    set ib_skillName[657] = "æœˆåˆƒ"
    set ib_skillCustom[657] = 0
    set ib_skillList[658] = 'Amgr'
    set ib_skillName[658] = "æœˆåˆƒ"
    set ib_skillCustom[658] = 0
    set ib_skillList[659] = 'Amic'
    set ib_skillName[659] = "æˆ˜æ–—å·å¬"
    set ib_skillCustom[659] = 0
    set ib_skillList[660] = 'Amil'
    set ib_skillName[660] = "æˆ˜æ–—å·å¬"
    set ib_skillCustom[660] = 0
    set ib_skillList[661] = 'Amim'
    set ib_skillName[661] = "é­”æ³•å…ç–«"
    set ib_skillCustom[661] = 0
    set ib_skillList[662] = 'Amin'
    set ib_skillName[662] = "åœ°é›·å¼•çˆ†"
    set ib_skillCustom[662] = 0
    set ib_skillList[663] = 'Amls'
    set ib_skillName[663] = "ç©ºä¸­é”é•£"
    set ib_skillCustom[663] = 0
    set ib_skillList[664] = 'Amnb'
    set ib_skillName[664] = "æ³•åŠ›ç‡ƒçƒ§"
    set ib_skillCustom[664] = 0
    set ib_skillList[665] = 'Amnx'
    set ib_skillName[665] = "èŒƒå›´æ€§æ”»å‡»ä¼¤å®³"
    set ib_skillCustom[665] = 0
    set ib_skillList[666] = 'Amnz'
    set ib_skillName[666] = "èŒƒå›´æ€§æ”»å‡»ä¼¤å®³"
    set ib_skillCustom[666] = 0
    set ib_skillList[667] = 'Amou'
    set ib_skillName[667] = "éª‘ä¹˜"
    set ib_skillCustom[667] = 0
    set ib_skillList[668] = 'Amov'
    set ib_skillName[668] = "ç§»åŠ¨"
    set ib_skillCustom[668] = 0
    set ib_skillList[669] = 'Amrf'
    set ib_skillName[669] = "ä¹Œé¸¦å½¢æ€"
    set ib_skillCustom[669] = 0
    set ib_skillList[670] = 'Amtc'
    set ib_skillName[670] = "ä¿æŒåŸä½"
    set ib_skillCustom[670] = 0
    set ib_skillList[671] = 'Andm'
    set ib_skillName[671] = "é©±é€é­”æ³•"
    set ib_skillCustom[671] = 0
    set ib_skillList[672] = 'Andt'
    set ib_skillName[672] = "æ˜¾ç¤º"
    set ib_skillCustom[672] = 0
    set ib_skillList[673] = 'Ane2'
    set ib_skillName[673] = "é€‰æ‹©å•ä½"
    set ib_skillCustom[673] = 0
    set ib_skillList[674] = 'Anei'
    set ib_skillName[674] = "é€‰æ‹©ä½¿ç”¨è€…"
    set ib_skillCustom[674] = 0
    set ib_skillList[675] = 'Aneu'
    set ib_skillName[675] = "é€‰æ‹©è‹±é›„"
    set ib_skillCustom[675] = 0
    set ib_skillList[676] = 'Anh1'
    set ib_skillName[676] = "åŒ»ç–—"
    set ib_skillCustom[676] = 0
    set ib_skillList[677] = 'Anh2'
    set ib_skillName[677] = "åŒ»ç–—"
    set ib_skillCustom[677] = 0
    set ib_skillList[678] = 'Anhe'
    set ib_skillName[678] = "åŒ»ç–—"
    set ib_skillCustom[678] = 0
    set ib_skillList[679] = 'Anit'
    set ib_skillName[679] = "è·Ÿè¸ª"
    set ib_skillCustom[679] = 0
    set ib_skillList[680] = 'Ansk'
    set ib_skillName[680] = "ç¡¬åŒ–çš®è‚¤"
    set ib_skillCustom[680] = 0
    set ib_skillList[681] = 'Aoar'
    set ib_skillName[681] = "æ²»ç–—å®ˆå«å…‰ç¯"
    set ib_skillCustom[681] = 0
    set ib_skillList[682] = 'Apak'
    set ib_skillName[682] = "è¡Œå›ŠæŠ€èƒ½"
    set ib_skillCustom[682] = 0
    set ib_skillList[683] = 'Apg2'
    set ib_skillName[683] = "å‡€åŒ–"
    set ib_skillCustom[683] = 0
    set ib_skillList[684] = 'Aphx'
    set ib_skillName[684] = "ç«å‡¤å‡°å˜å½¢(å’Œå‡¤å‡°è›‹æœ‰å…³çš„)"
    set ib_skillCustom[684] = 0
    set ib_skillList[685] = 'Apig'
    set ib_skillName[685] = "æ°¸ä¹…çš„çŒ®ç¥­"
    set ib_skillCustom[685] = 0
    set ib_skillList[686] = 'Apit'
    set ib_skillName[686] = "å•†åº—è´­ä¹°ç‰©å“"
    set ib_skillCustom[686] = 0
    set ib_skillList[687] = 'Apiv'
    set ib_skillName[687] = "æ°¸ä¹…çš„éšå½¢"
    set ib_skillCustom[687] = 0
    set ib_skillList[688] = 'Aply'
    set ib_skillName[688] = "å˜å½¢æœ¯"
    set ib_skillCustom[688] = 0
    set ib_skillList[689] = 'Apmf'
    set ib_skillName[689] = "å‡¤å‡°ç«ç„°"
    set ib_skillCustom[689] = 0
    set ib_skillList[690] = 'Apo2'
    set ib_skillName[690] = "æ¯’åˆº"
    set ib_skillCustom[690] = 0
    set ib_skillList[691] = 'Apoi'
    set ib_skillName[691] = "æ¯’åˆº"
    set ib_skillCustom[691] = 0
    set ib_skillList[692] = 'Apos'
    set ib_skillName[692] = "å æ®"
    set ib_skillCustom[692] = 0
    set ib_skillList[693] = 'Aprg'
    set ib_skillName[693] = "å‡€åŒ–"
    set ib_skillCustom[693] = 0
    set ib_skillList[694] = 'Aps2'
    set ib_skillName[694] = "å æ®"
    set ib_skillCustom[694] = 0
    set ib_skillList[695] = 'Apsh'
    set ib_skillName[695] = "å˜ç›¸ç§»åŠ¨"
    set ib_skillCustom[695] = 0
    set ib_skillList[696] = 'Apts'
    set ib_skillName[696] = "ç–¾ç—…äº‘é›¾"
    set ib_skillCustom[696] = 0
    set ib_skillList[697] = 'Apxf'
    set ib_skillName[697] = "å‡¤å‡°ç«ç„°"
    set ib_skillCustom[697] = 0
    set ib_skillList[698] = 'Ara2'
    set ib_skillName[698] = "å’†å“®"
    set ib_skillCustom[698] = 0
    set ib_skillList[699] = 'Arai'
    set ib_skillName[699] = "å¤æ´»æ­»å°¸"
    set ib_skillCustom[699] = 0
    set ib_skillList[700] = 'Arav'
    set ib_skillName[700] = "é£æš´ä¹‹é¸¦"
    set ib_skillCustom[700] = 0
    set ib_skillList[701] = 'Arbr'
    set ib_skillName[701] = "åŠ å¼ºå‹åœ°æ´å‡çº§"
    set ib_skillCustom[701] = 0
    set ib_skillList[702] = 'Arej'
    set ib_skillName[702] = "ç”Ÿå‘½æ¢å¤"
    set ib_skillCustom[702] = 0
    set ib_skillList[703] = 'Arel'
    set ib_skillName[703] = "æé«˜è‹±é›„ç”Ÿå‘½å€¼æ¢å¤é€Ÿåº¦çš„ç‰©å“"
    set ib_skillCustom[703] = 0
    set ib_skillList[704] = 'Aren'
    set ib_skillName[704] = "æ›´æ–°"
    set ib_skillCustom[704] = 0
    set ib_skillList[705] = 'Arep'
    set ib_skillName[705] = "ä¿®ç†"
    set ib_skillCustom[705] = 0
    set ib_skillList[706] = 'Aret'
    set ib_skillName[706] = "å†è®­ç»ƒä¹‹ä¹¦"
    set ib_skillCustom[706] = 0
    set ib_skillList[707] = 'Arev'
    set ib_skillName[707] = "å¤æ´»è‹±é›„"
    set ib_skillCustom[707] = 0
    set ib_skillList[708] = 'Argd'
    set ib_skillName[708] = "é€å›é»„é‡‘"
    set ib_skillCustom[708] = 0
    set ib_skillList[709] = 'Argl'
    set ib_skillName[709] = "é€å›é»„é‡‘å’Œæœ¨æ"
    set ib_skillCustom[709] = 0
    set ib_skillList[710] = 'Arll'
    set ib_skillName[710] = "æé«˜è‹±é›„ç”Ÿå‘½å€¼æ¢å¤é€Ÿåº¦çš„ç‰©å“"
    set ib_skillCustom[710] = 0
    set ib_skillList[711] = 'Arlm'
    set ib_skillName[711] = "é€å›æœ¨æ"
    set ib_skillCustom[711] = 0
    set ib_skillList[712] = 'Arng'
    set ib_skillName[712] = "å¤ä»‡"
    set ib_skillCustom[712] = 0
    set ib_skillList[713] = 'Aro1'
    set ib_skillName[713] = "æ‰æ ¹"
    set ib_skillCustom[713] = 0
    set ib_skillList[714] = 'Aro2'
    set ib_skillName[714] = "æ‰æ ¹"
    set ib_skillCustom[714] = 0
    set ib_skillList[715] = 'Aroa'
    set ib_skillName[715] = "å’†å“®"
    set ib_skillCustom[715] = 0
    set ib_skillList[716] = 'Aroc'
    set ib_skillName[716] = "å¼¹å¹•æ”»å‡»"
    set ib_skillCustom[716] = 0
    set ib_skillList[717] = 'Aroo'
    set ib_skillName[717] = "æ‰æ ¹"
    set ib_skillCustom[717] = 0
    set ib_skillList[718] = 'Arpb'
    set ib_skillName[718] = "è¡¥å……é­”æ³•å’Œç”Ÿå‘½å€¼"
    set ib_skillCustom[718] = 0
    set ib_skillList[719] = 'Arpl'
    set ib_skillName[719] = "æ¯èç²¾é«“"
    set ib_skillCustom[719] = 0
endfunction
function IB_SkillFill9 takes nothing returns nothing
    set ib_skillList[720] = 'Arpm'
    set ib_skillName[720] = "çµé­‚è§¦æ‘¸"
    set ib_skillCustom[720] = 0
    set ib_skillList[721] = 'Arsg'
    set ib_skillName[721] = "å¬å”¤ç±³çº±"
    set ib_skillCustom[721] = 0
    set ib_skillList[722] = 'Arsk'
    set ib_skillName[722] = "æŠ—æ€§çš®è‚¤"
    set ib_skillCustom[722] = 0
    set ib_skillList[723] = 'Arsp'
    set ib_skillName[723] = "æƒŠå“"
    set ib_skillCustom[723] = 0
    set ib_skillList[724] = 'Arsq'
    set ib_skillName[724] = "å¬å”¤è±ªçŒª"
    set ib_skillCustom[724] = 0
    set ib_skillList[725] = 'Arst'
    set ib_skillName[725] = "æ¢å¤"
    set ib_skillCustom[725] = 0
    set ib_skillList[726] = 'Arsw'
    set ib_skillName[726] = "æ¯’è›‡å®ˆå«"
    set ib_skillCustom[726] = 0
    set ib_skillList[727] = 'Artn'
    set ib_skillName[727] = "è¿”å›"
    set ib_skillCustom[727] = 0
    set ib_skillList[728] = 'Asac'
    set ib_skillName[728] = "ç‰ºç‰²"
    set ib_skillCustom[728] = 0
    set ib_skillList[729] = 'Asal'
    set ib_skillName[729] = "æ å¤º"
    set ib_skillCustom[729] = 0
    set ib_skillList[730] = 'Asb1'
    set ib_skillName[730] = "æ½œæ°´"
    set ib_skillCustom[730] = 0
    set ib_skillList[731] = 'Asb2'
    set ib_skillName[731] = "æ½œæ°´"
    set ib_skillCustom[731] = 0
    set ib_skillList[732] = 'Asb3'
    set ib_skillName[732] = "æ½œæ°´"
    set ib_skillCustom[732] = 0
    set ib_skillList[733] = 'Asd2'
    set ib_skillName[733] = "å¡å¸ƒæ©"
    set ib_skillCustom[733] = 0
    set ib_skillList[734] = 'Asd3'
    set ib_skillName[734] = "å¡å¸ƒæ©"
    set ib_skillCustom[734] = 0
    set ib_skillList[735] = 'Asdg'
    set ib_skillName[735] = "å¡å¸ƒæ©"
    set ib_skillCustom[735] = 0
    set ib_skillList[736] = 'Asds'
    set ib_skillName[736] = "å¡å¸ƒæ©"
    set ib_skillCustom[736] = 0
    set ib_skillList[737] = 'Ashm'
    set ib_skillName[737] = "å½±é"
    set ib_skillCustom[737] = 0
    set ib_skillList[738] = 'Ashs'
    set ib_skillName[738] = "å½±å­æƒæ–"
    set ib_skillCustom[738] = 0
    set ib_skillList[739] = 'Asid'
    set ib_skillName[739] = "å‡ºå”®ç‰©å“"
    set ib_skillCustom[739] = 0
    set ib_skillList[740] = 'Asla'
    set ib_skillName[740] = "ä¸€ç›´ç¡çœ "
    set ib_skillCustom[740] = 0
    set ib_skillList[741] = 'Aslo'
    set ib_skillName[741] = "å‡é€Ÿ"
    set ib_skillCustom[741] = 0
    set ib_skillList[742] = 'Aslp'
    set ib_skillName[742] = "å¬å”¤å·¨è™¾"
    set ib_skillCustom[742] = 0
    set ib_skillList[743] = 'Asod'
    set ib_skillName[743] = "äº§åµä¹‹éª¨"
    set ib_skillCustom[743] = 0
    set ib_skillList[744] = 'Asou'
    set ib_skillName[744] = "èƒ½å æ®å•ä½çµé­‚çš„ç‰©å“"
    set ib_skillCustom[744] = 0
    set ib_skillList[745] = 'Asp1'
    set ib_skillName[745] = "çƒä½“"
    set ib_skillCustom[745] = 0
    set ib_skillList[746] = 'Asp2'
    set ib_skillName[746] = "çƒä½“"
    set ib_skillCustom[746] = 0
    set ib_skillList[747] = 'Asp3'
    set ib_skillName[747] = "çƒä½“"
    set ib_skillCustom[747] = 0
    set ib_skillList[748] = 'Asp4'
    set ib_skillName[748] = "çƒä½“"
    set ib_skillCustom[748] = 0
    set ib_skillList[749] = 'Asp5'
    set ib_skillName[749] = "çƒä½“"
    set ib_skillCustom[749] = 0
    set ib_skillList[750] = 'Asp6'
    set ib_skillName[750] = "çƒä½“"
    set ib_skillCustom[750] = 0
    set ib_skillList[751] = 'Aspa'
    set ib_skillName[751] = "èœ˜è››æ”»å‡»"
    set ib_skillCustom[751] = 0
    set ib_skillList[752] = 'Aspb'
    set ib_skillName[752] = "é­”æ³•ä¹¦"
    set ib_skillCustom[752] = 0
    set ib_skillList[753] = 'Aspd'
    set ib_skillName[753] = "å°èœ˜è››"
    set ib_skillCustom[753] = 0
    set ib_skillList[754] = 'Asph'
    set ib_skillName[754] = "çƒä½“"
    set ib_skillCustom[754] = 0
    set ib_skillList[755] = 'Aspi'
    set ib_skillName[755] = "å°–å½¢è·¯éšœ"
    set ib_skillCustom[755] = 0
    set ib_skillList[756] = 'Aspl'
    set ib_skillName[756] = "çµé­‚é”é“¾"
    set ib_skillCustom[756] = 0
    set ib_skillList[757] = 'Aspo'
    set ib_skillName[757] = "æ…¢æ€§æ¯’è¯"
    set ib_skillCustom[757] = 0
    set ib_skillList[758] = 'Aspp'
    set ib_skillName[758] = "çµé­‚é”é“¾"
    set ib_skillCustom[758] = 0
    set ib_skillList[759] = 'Asps'
    set ib_skillName[759] = "é­”æ³•ç›—å–"
    set ib_skillCustom[759] = 0
    set ib_skillList[760] = 'Aspt'
    set ib_skillName[760] = "è¯ç”Ÿåˆºè›‡å¹¼è™«"
    set ib_skillCustom[760] = 0
    set ib_skillList[761] = 'Aspy'
    set ib_skillName[761] = "è¯ç”Ÿåˆºè›‡"
    set ib_skillCustom[761] = 0
    set ib_skillList[762] = 'Assk'
    set ib_skillName[762] = "ç¡¬åŒ–çš®è‚¤"
    set ib_skillCustom[762] = 0
    set ib_skillList[763] = 'Assp'
    set ib_skillName[763] = "å°èœ˜è››"
    set ib_skillCustom[763] = 0
    set ib_skillList[764] = 'Asta'
    set ib_skillName[764] = "é™æ­¢é™·é˜±"
    set ib_skillCustom[764] = 0
    set ib_skillList[765] = 'Astd'
    set ib_skillName[765] = "å¸è½½è‹¦å·¥"
    set ib_skillCustom[765] = 0
    set ib_skillList[766] = 'Aste'
    set ib_skillName[766] = "ç›—å–"
    set ib_skillCustom[766] = 0
    set ib_skillList[767] = 'Asth'
    set ib_skillName[767] = "é£æš´æˆ˜é”¤"
    set ib_skillCustom[767] = 0
    set ib_skillList[768] = 'Astn'
    set ib_skillName[768] = "çŸ³åƒå½¢æ€"
    set ib_skillCustom[768] = 0
    set ib_skillList[769] = 'Asud'
    set ib_skillName[769] = "å‡ºå”®å•ä½"
    set ib_skillCustom[769] = 0
    set ib_skillList[770] = 'Atau'
    set ib_skillName[770] = "å˜²è®½"
    set ib_skillCustom[770] = 0
    set ib_skillList[771] = 'Atdg'
    set ib_skillName[771] = "å»ºç­‘ç‰©ç ´åå…‰ç¯"
    set ib_skillCustom[771] = 0
    set ib_skillList[772] = 'Atdp'
    set ib_skillName[772] = "å¸è½½é©¾é©¶å‘˜"
    set ib_skillCustom[772] = 0
    set ib_skillList[773] = 'Atlp'
    set ib_skillName[773] = "è£…è½½é©¾é©¶å‘˜"
    set ib_skillCustom[773] = 0
    set ib_skillList[774] = 'Atol'
    set ib_skillName[774] = "ç”Ÿå‘½ä¹‹æ ‘å‡çº§æŠ€èƒ½"
    set ib_skillCustom[774] = 0
    set ib_skillList[775] = 'Atru'
    set ib_skillName[775] = "çœŸå®è§†åŸŸ"
    set ib_skillCustom[775] = 0
    set ib_skillList[776] = 'Atsp'
    set ib_skillName[776] = "é¾™å·æ—‹é£"
    set ib_skillCustom[776] = 0
    set ib_skillList[777] = 'Attu'
    set ib_skillName[777] = "å¦å…‹å›´åŸ"
    set ib_skillCustom[777] = 0
    set ib_skillList[778] = 'Atwa'
    set ib_skillName[778] = "é¾™å·é£æ¼«æ­¥è€…"
    set ib_skillCustom[778] = 0
    set ib_skillList[779] = 'Auco'
    set ib_skillName[779] = "ä¸ç¨³å®šåŒ–åˆç‰©"
    set ib_skillCustom[779] = 0
    set ib_skillList[780] = 'Auhf'
    set ib_skillName[780] = "é‚ªæ¶ç‹‚çƒ­"
    set ib_skillCustom[780] = 0
    set ib_skillList[781] = 'Ault'
    set ib_skillName[781] = "å¤œè§†èƒ½åŠ›"
    set ib_skillCustom[781] = 0
    set ib_skillList[782] = 'Auns'
    set ib_skillName[782] = "åå¬å”¤å»ºç­‘"
    set ib_skillCustom[782] = 0
    set ib_skillList[783] = 'Aven'
    set ib_skillName[783] = "æµ¸æ¯’æ­¦å™¨"
    set ib_skillCustom[783] = 0
    set ib_skillList[784] = 'Avng'
    set ib_skillName[784] = "å¤ä»‡ä¹‹é­‚"
    set ib_skillCustom[784] = 0
    set ib_skillList[785] = 'Avul'
    set ib_skillName[785] = "æ— æ•Œçš„"
    set ib_skillCustom[785] = 0
    set ib_skillList[786] = 'Awan'
    set ib_skillName[786] = "æ¸¸è¡è€…"
    set ib_skillCustom[786] = 0
    set ib_skillList[787] = 'Awar'
    set ib_skillName[787] = "ç²‰ç¢"
    set ib_skillCustom[787] = 0
    set ib_skillList[788] = 'Aweb'
    set ib_skillName[788] = "è››ç½‘"
    set ib_skillCustom[788] = 0
    set ib_skillList[789] = 'Awfb'
    set ib_skillName[789] = "éœ¹é›³é—ªç”µ"
    set ib_skillCustom[789] = 0
    set ib_skillList[790] = 'Awh2'
    set ib_skillName[790] = "é‡‡é›†"
    set ib_skillCustom[790] = 0
    set ib_skillList[791] = 'Awha'
    set ib_skillName[791] = "é‡‡é›†"
    set ib_skillCustom[791] = 0
    set ib_skillList[792] = 'Awhe'
    set ib_skillName[792] = "åŒ»ç–—"
    set ib_skillCustom[792] = 0
    set ib_skillList[793] = 'Awrg'
    set ib_skillName[793] = "æˆ˜äº‰è·µè¸"
    set ib_skillCustom[793] = 0
    set ib_skillList[794] = 'Awrh'
    set ib_skillName[794] = "æˆ˜äº‰è·µè¸"
    set ib_skillCustom[794] = 0
    set ib_skillList[795] = 'Awrp'
    set ib_skillName[795] = "ä¼ é€é—¨æŠ€èƒ½"
    set ib_skillCustom[795] = 0
    set ib_skillList[796] = 'Awrs'
    set ib_skillName[796] = "æˆ˜äº‰è·µè¸"
    set ib_skillCustom[796] = 0
    set ib_skillList[797] = 'Azcr'
    set ib_skillName[797] = "è‡´å‘½ä¸€å‡»"
    set ib_skillCustom[797] = 0
    set ib_skillList[798] = 'Bdbb'
    set ib_skillName[798] = "å¸å–ç”Ÿå‘½å€¼å’Œé­”æ³•å€¼ï¼ˆé™„åŠ ï¼‰"
    set ib_skillCustom[798] = 0
    set ib_skillList[799] = 'Bdbl'
    set ib_skillName[799] = "å¸å–ç”Ÿå‘½ï¼ˆé™„åŠ ï¼‰"
    set ib_skillCustom[799] = 0
endfunction
function IB_SkillFill10 takes nothing returns nothing
    set ib_skillList[800] = 'Bdbm'
    set ib_skillName[800] = "å¸å–é­”æ³•ï¼ˆé™„åŠ ï¼‰"
    set ib_skillCustom[800] = 0
    set ib_skillList[801] = 'SCae'
    set ib_skillName[801] = "è€ä¹…å…‰ç¯"
    set ib_skillCustom[801] = 0
    set ib_skillList[802] = 'SCc1'
    set ib_skillName[802] = "é£“é£"
    set ib_skillCustom[802] = 0
    set ib_skillList[803] = 'SCva'
    set ib_skillName[803] = "çªƒå–ç”Ÿå‘½"
    set ib_skillCustom[803] = 0
    set ib_skillList[804] = 'SNdc'
    set ib_skillName[804] = "é»‘æš—è½¬æ¢"
    set ib_skillCustom[804] = 0
    set ib_skillList[805] = 'SNdd'
    set ib_skillName[805] = "æ­»äº¡å‡‹é›¶"
    set ib_skillCustom[805] = 0
    set ib_skillList[806] = 'SNeq'
    set ib_skillName[806] = "åœ°éœ‡"
    set ib_skillCustom[806] = 0
    set ib_skillList[807] = 'SNin'
    set ib_skillName[807] = "åœ°ç‹±ç«"
    set ib_skillCustom[807] = 0
    set ib_skillList[808] = 'Sbsk'
    set ib_skillName[808] = "ç‹‚æš´æ„¤æ€’å‡çº§"
    set ib_skillCustom[808] = 0
    set ib_skillList[809] = 'Sbtl'
    set ib_skillName[809] = "æˆ˜å¤‡çŠ¶æ€"
    set ib_skillCustom[809] = 0
    set ib_skillList[810] = 'Sch2'
    set ib_skillName[810] = "ä¿æŒåŸä½"
    set ib_skillCustom[810] = 0
    set ib_skillList[811] = 'Sch3'
    set ib_skillName[811] = "ä¿æŒåŸä½"
    set ib_skillCustom[811] = 0
    set ib_skillList[812] = 'Sch4'
    set ib_skillName[812] = "ä¿æŒåŸä½"
    set ib_skillCustom[812] = 0
    set ib_skillList[813] = 'Sch5'
    set ib_skillName[813] = "ä¿æŒåŸä½"
    set ib_skillCustom[813] = 0
    set ib_skillList[814] = 'Scri'
    set ib_skillName[814] = "æ®‹åºŸ"
    set ib_skillCustom[814] = 0
    set ib_skillList[815] = 'Sdro'
    set ib_skillName[815] = "å¸è½½"
    set ib_skillCustom[815] = 0
    set ib_skillList[816] = 'Slo2'
    set ib_skillName[816] = "è£…è½½å°ç²¾çµ"
    set ib_skillCustom[816] = 0
    set ib_skillList[817] = 'Slo3'
    set ib_skillName[817] = "è£…è½½"
    set ib_skillCustom[817] = 0
    set ib_skillList[818] = 'Sloa'
    set ib_skillName[818] = "è£…è½½"
    set ib_skillCustom[818] = 0
    set ib_skillList[819] = 'Sshm'
    set ib_skillName[819] = "å½±é"
    set ib_skillCustom[819] = 0
    set ib_skillList[820] = 'Suhf'
    set ib_skillName[820] = "é‚ªæ¶ç‹‚çƒ­"
    set ib_skillCustom[820] = 0
    set ib_skillList[821] = 'W000'
    set ib_skillName[821] = "[ç¿…è†€]å •è½å¤©ä½¿ä¹‹ç¿¼"
    set ib_skillCustom[821] = 0
    set ib_skillList[822] = 'W002'
    set ib_skillName[822] = "[ç¿…è†€]ç§»åŠ¨é€Ÿåº¦ +100"
    set ib_skillCustom[822] = 0
    set ib_skillList[823] = 'W020'
    set ib_skillName[823] = "[ç¿…è†€]ç‚½å¤©ä½¿ä¹‹ç¿¼"
    set ib_skillCustom[823] = 0
    set ib_skillList[824] = 'W021'
    set ib_skillName[824] = "[ç¿…è†€]æ¶é­”ä¹‹ç¿¼"
    set ib_skillCustom[824] = 0
    set ib_skillList[825] = 'W022'
    set ib_skillName[825] = "æš—å½±åº‡æŠ¤"
    set ib_skillCustom[825] = 0
    set ib_skillList[826] = 'W023'
    set ib_skillName[826] = "ç¾¤ä½“ä¼ é€"
    set ib_skillCustom[826] = 0
    set ib_skillList[827] = 'W024'
    set ib_skillName[827] = "é—ªçƒ"
    set ib_skillCustom[827] = 0
    set ib_skillList[828] = 'W070'
    set ib_skillName[828] = "[å…‰ç¯]é‚ªæ¶: ç§»é€Ÿ+20% å›è¡€+30"
    set ib_skillCustom[828] = 0
    set ib_skillList[829] = 'W071'
    set ib_skillName[829] = "[å…‰ç¯]å¸è¡€ +40%"
    set ib_skillCustom[829] = 0
    set ib_skillList[830] = 'W072'
    set ib_skillName[830] = "é—ªé¿ 30%"
    set ib_skillCustom[830] = 0
    set ib_skillList[831] = 'W073'
    set ib_skillName[831] = "[å…‰ç¯]é­”æ³•æ¢å¤ +300%"
    set ib_skillCustom[831] = 0
    set ib_skillList[832] = 'W074'
    set ib_skillName[832] = "[å…‰ç¯]æ¯ç§’å›å¤æœ€å¤§ç”Ÿå‘½ 3%"
    set ib_skillCustom[832] = 0
    set ib_skillList[833] = 'W075'
    set ib_skillName[833] = "é‡ç”Ÿ"
    set ib_skillCustom[833] = 0
    set ib_skillList[834] = 'W076'
    set ib_skillName[834] = "[å…‰ç¯]å‘½ä»¤: æ”»å‡»åŠ› +50%"
    set ib_skillCustom[834] = 0
    set ib_skillList[835] = 'W077'
    set ib_skillName[835] = "[å…‰ç¯]æ”»å‡»é€Ÿåº¦ +40%"
    set ib_skillCustom[835] = 0
    set ib_skillList[836] = 'W078'
    set ib_skillName[836] = "è‡´å‘½ä¸€å‡» 35% x3"
    set ib_skillCustom[836] = 0
    set ib_skillList[837] = 'W079'
    set ib_skillName[837] = "[å…‰ç¯]æ²»ç–—å…‰ç¯(å±•ç¤º)"
    set ib_skillCustom[837] = 0
    set ib_skillList[838] = 'W080'
    set ib_skillName[838] = "[ä¹¦]å •è½å¤©ä½¿"
    set ib_skillCustom[838] = 0
    set ib_skillList[839] = 'W081'
    set ib_skillName[839] = "[ä¹¦]ç‚½å¤©ä½¿"
    set ib_skillCustom[839] = 0
    set ib_skillList[840] = 'W082'
    set ib_skillName[840] = "[ä¹¦]æ¶é­”"
    set ib_skillCustom[840] = 0
    set ib_skillList[841] = 'W085'
    set ib_skillName[841] = "[ç¿…è†€]æ˜Ÿé­‚ä¹‹åŠ›"
    set ib_skillCustom[841] = 0
    set ib_skillList[842] = 'W089'
    set ib_skillName[842] = "ç°çƒ¬é›·æš´"
    set ib_skillCustom[842] = 0
    set ib_skillList[843] = 'W090'
    set ib_skillName[843] = "[æ˜Ÿé­‚]çŒ®ç¥­"
    set ib_skillCustom[843] = 0
    set ib_skillList[844] = 'W091'
    set ib_skillName[844] = "[æ‰‹]é‡å‡»"
    set ib_skillCustom[844] = 0
    set ib_skillList[845] = 'W092'
    set ib_skillName[845] = "é›·éœ†ä¸€å‡»-ç°çƒ¬é›·æš´"
    set ib_skillCustom[845] = 0
    set ib_skillList[846] = 'W093'
    set ib_skillName[846] = "ç«ç®­ç¾¤-ç°çƒ¬é›·æš´"
    set ib_skillCustom[846] = 0
    set ib_skillList[847] = 'W095'
    set ib_skillName[847] = "[æ˜Ÿé­‚]ç§»åŠ¨é€Ÿåº¦ é¡¶æ»¡"
    set ib_skillCustom[847] = 0
    set ib_skillList[848] = 'RStm'
    set ib_skillName[848] = "é£æš´ä¹‹é”¤"
    set ib_skillCustom[848] = 0
    set ib_skillList[849] = 'RSta'
    set ib_skillName[849] = "æƒŠå“"
    set ib_skillCustom[849] = 0
    set ib_skillList[850] = 'RHeW'
    set ib_skillName[850] = "åŒ»ç–—æ³¢"
    set ib_skillCustom[850] = 0
    set ib_skillList[851] = 'RoHx'
    set ib_skillName[851] = "å¦–æœ¯"
    set ib_skillCustom[851] = 0
    set ib_skillList[852] = 'RVdo'
    set ib_skillName[852] = "å·«æ¯’å¹½é­‚"
    set ib_skillCustom[852] = 0
    set ib_skillList[853] = 'SCmd'
    set ib_skillName[853] = "scmd"
    set ib_skillCustom[853] = 0
    set ib_skillList[854] = 'Afhg'
    set ib_skillName[854] = "afhg"
    set ib_skillCustom[854] = 0
    set ib_skillList[855] = 'Umri'
    set ib_skillName[855] = "é•œåƒ"
    set ib_skillCustom[855] = 0
    set ib_skillList[856] = 'Cbof'
    set ib_skillName[856] = "ç«ç„°å‘¼å¸"
    set ib_skillCustom[856] = 0
    set ib_skillList[857] = 'Cdrh'
    set ib_skillName[857] = "é†‰é…’äº‘é›¾"
    set ib_skillCustom[857] = 0
    set ib_skillList[858] = 'Ifrb'
    set ib_skillName[858] = "éœ¹é›³é—ªç”µ"
    set ib_skillCustom[858] = 0
    set ib_skillList[859] = 'Arcg'
    set ib_skillName[859] = "arcg"
    set ib_skillCustom[859] = 0
    set ib_skillList[860] = 'Srcg'
    set ib_skillName[860] = "srcg"
    set ib_skillCustom[860] = 0
    set ib_skillList[861] = 'Dchn'
    set ib_skillName[861] = "é—ªç”µé“¾"
    set ib_skillCustom[861] = 0
    set ib_skillList[862] = 'DTcl'
    set ib_skillName[862] = "é—ªç”µé“¾"
    set ib_skillCustom[862] = 0
    set ib_skillList[863] = 'DTfs'
    set ib_skillName[863] = "é‡å…½å¹½é­‚"
    set ib_skillCustom[863] = 0
    set ib_skillList[864] = 'HAwt'
    set ib_skillName[864] = "æ²»ç–—å®ˆå«å…‰ç¯"
    set ib_skillCustom[864] = 0
    set ib_skillList[865] = 'DTtw'
    set ib_skillName[865] = "æ²»ç–—å®ˆå«"
    set ib_skillCustom[865] = 0
    set ib_skillList[866] = 'Sbrz'
    set ib_skillName[866] = "sbrz"
    set ib_skillCustom[866] = 0
    set ib_skillList[867] = 'CrnA'
    set ib_skillName[867] = "crna"
    set ib_skillCustom[867] = 0
    set ib_skillList[868] = 'CrnH'
    set ib_skillName[868] = "crnh"
    set ib_skillCustom[868] = 0
    set ib_skillList[869] = 'Cans'
    set ib_skillName[869] = "é‡å…½å¹½é­‚"
    set ib_skillCustom[869] = 0
    set ib_skillList[870] = 'Ageo'
    set ib_skillName[870] = "ageo"
    set ib_skillCustom[870] = 0
    set ib_skillList[871] = 'Sslw'
    set ib_skillName[871] = "å‡é€Ÿ"
    set ib_skillCustom[871] = 0
    set ib_skillList[872] = 'Dbln'
    set ib_skillName[872] = "é—ªçƒ"
    set ib_skillCustom[872] = 0
    set ib_skillList[873] = 'TalR'
    set ib_skillName[873] = "talr"
    set ib_skillCustom[873] = 0
    set ib_skillList[874] = 'Mror'
    set ib_skillName[874] = "å’†å“®"
    set ib_skillCustom[874] = 0
    set ib_skillList[875] = 'Cmsh'
    set ib_skillName[875] = "cmsh"
    set ib_skillCustom[875] = 0
    set ib_skillList[876] = 'Fmsh'
    set ib_skillName[876] = "fmsh"
    set ib_skillCustom[876] = 0
    set ib_skillList[877] = 'ClvS'
    set ib_skillName[877] = "åˆ†è£‚æ”»å‡»"
    set ib_skillCustom[877] = 0
    set ib_skillList[878] = 'Tmsh'
    set ib_skillName[878] = "tmsh"
    set ib_skillCustom[878] = 0
    set ib_skillList[879] = 'RslH'
    set ib_skillName[879] = "ç¡¬åŒ–çš®è‚¤"
    set ib_skillCustom[879] = 0
endfunction
function IB_SkillFill11 takes nothing returns nothing
    set ib_skillList[880] = 'Rt11'
    set ib_skillName[880] = "rt11"
    set ib_skillCustom[880] = 0
    set ib_skillList[881] = 'TalK'
    set ib_skillName[881] = "talk"
    set ib_skillCustom[881] = 0
    set ib_skillList[882] = 'Rt12'
    set ib_skillName[882] = "rt12"
    set ib_skillCustom[882] = 0
    set ib_skillList[883] = 'RHex'
    set ib_skillName[883] = "åŒ»ç–—æ³¢"
    set ib_skillCustom[883] = 0
    set ib_skillList[884] = 'RHef'
    set ib_skillName[884] = "åŒ»ç–—æ³¢"
    set ib_skillCustom[884] = 0
    set ib_skillList[885] = 'Rt13'
    set ib_skillName[885] = "rt13"
    set ib_skillCustom[885] = 0
    set ib_skillList[886] = 'TalS'
    set ib_skillName[886] = "tals"
    set ib_skillCustom[886] = 0
    set ib_skillList[887] = 'CboR'
    set ib_skillName[887] = "ç«ç„°å‘¼å¸"
    set ib_skillCustom[887] = 0
    set ib_skillList[888] = 'SBt1'
    set ib_skillName[888] = "sbt1"
    set ib_skillCustom[888] = 0
    set ib_skillList[889] = 'CboB'
    set ib_skillName[889] = "ç«ç„°å‘¼å¸"
    set ib_skillCustom[889] = 0
    set ib_skillList[890] = 'SBt2'
    set ib_skillName[890] = "sbt2"
    set ib_skillCustom[890] = 0
    set ib_skillList[891] = 'CboQ'
    set ib_skillName[891] = "ç«ç„°å‘¼å¸"
    set ib_skillCustom[891] = 0
    set ib_skillList[892] = 'Sbt3'
    set ib_skillName[892] = "sbt3"
    set ib_skillCustom[892] = 0
    set ib_skillList[893] = 'Mtl1'
    set ib_skillName[893] = "mtl1"
    set ib_skillCustom[893] = 0
    set ib_skillList[894] = 'Mtl2'
    set ib_skillName[894] = "mtl2"
    set ib_skillCustom[894] = 0
    set ib_skillList[895] = 'Mtl3'
    set ib_skillName[895] = "mtl3"
    set ib_skillCustom[895] = 0
    set ib_skillList[896] = 'Cdh1'
    set ib_skillName[896] = "é†‰é…’äº‘é›¾"
    set ib_skillCustom[896] = 0
    set ib_skillList[897] = 'DHt1'
    set ib_skillName[897] = "dht1"
    set ib_skillCustom[897] = 0
    set ib_skillList[898] = 'DHt2'
    set ib_skillName[898] = "dht2"
    set ib_skillCustom[898] = 0
    set ib_skillList[899] = 'Cdh2'
    set ib_skillName[899] = "é†‰é…’äº‘é›¾"
    set ib_skillCustom[899] = 0
    set ib_skillList[900] = 'Cdh3'
    set ib_skillName[900] = "é†‰é…’äº‘é›¾"
    set ib_skillCustom[900] = 0
    set ib_skillList[901] = 'DHt3'
    set ib_skillName[901] = "dht3"
    set ib_skillCustom[901] = 0
    set ib_skillList[902] = 'EvmB'
    set ib_skillName[902] = "æµ¸æ¯’æ­¦å™¨"
    set ib_skillCustom[902] = 0
    set ib_skillList[903] = 'SwT1'
    set ib_skillName[903] = "æ¯’è›‡å®ˆå«"
    set ib_skillCustom[903] = 0
    set ib_skillList[904] = 'SpW1'
    set ib_skillName[904] = "spw1"
    set ib_skillCustom[904] = 0
    set ib_skillList[905] = 'SwT2'
    set ib_skillName[905] = "æ¯’è›‡å®ˆå«"
    set ib_skillCustom[905] = 0
    set ib_skillList[906] = 'SpW2'
    set ib_skillName[906] = "spw2"
    set ib_skillCustom[906] = 0
    set ib_skillList[907] = 'SwT3'
    set ib_skillName[907] = "æ¯’è›‡å®ˆå«"
    set ib_skillCustom[907] = 0
    set ib_skillList[908] = 'SpW3'
    set ib_skillName[908] = "spw3"
    set ib_skillCustom[908] = 0
    set ib_skillList[909] = 'RTs1'
    set ib_skillName[909] = "rts1"
    set ib_skillCustom[909] = 0
    set ib_skillList[910] = 'RTs2'
    set ib_skillName[910] = "rts2"
    set ib_skillCustom[910] = 0
    set ib_skillList[911] = 'RTs3'
    set ib_skillName[911] = "å¢åŠ æ”»å‡»åŠ›çš„ç‰©å“"
    set ib_skillCustom[911] = 0
    set ib_skillList[912] = 'KTs1'
    set ib_skillName[912] = "kts1"
    set ib_skillCustom[912] = 0
    set ib_skillList[913] = 'KTs2'
    set ib_skillName[913] = "kts2"
    set ib_skillCustom[913] = 0
    set ib_skillList[914] = 'KTs3'
    set ib_skillName[914] = "kts3"
    set ib_skillCustom[914] = 0
    set ib_skillList[915] = 'CTs1'
    set ib_skillName[915] = "cts1"
    set ib_skillCustom[915] = 0
    set ib_skillList[916] = 'CTs2'
    set ib_skillName[916] = "cts2"
    set ib_skillCustom[916] = 0
    set ib_skillList[917] = 'CTs3'
    set ib_skillName[917] = "cts3"
    set ib_skillCustom[917] = 0
    set ib_skillList[918] = 'DHit'
    set ib_skillName[918] = "é†‰é…’äº‘é›¾"
    set ib_skillCustom[918] = 0
    set ib_skillList[919] = 'RUt1'
    set ib_skillName[919] = "rut1"
    set ib_skillCustom[919] = 0
    set ib_skillList[920] = 'RUa1'
    set ib_skillName[920] = "æƒŠå“"
    set ib_skillCustom[920] = 0
    set ib_skillList[921] = 'RUa2'
    set ib_skillName[921] = "æƒŠå“"
    set ib_skillCustom[921] = 0
    set ib_skillList[922] = 'RUt2'
    set ib_skillName[922] = "rut2"
    set ib_skillCustom[922] = 0
    set ib_skillList[923] = 'RUa3'
    set ib_skillName[923] = "æƒŠå“"
    set ib_skillCustom[923] = 0
    set ib_skillList[924] = 'RUt3'
    set ib_skillName[924] = "rut3"
    set ib_skillCustom[924] = 0
    set ib_skillList[925] = 'VDS1'
    set ib_skillName[925] = "å·«æ¯’å¹½é­‚"
    set ib_skillCustom[925] = 0
    set ib_skillList[926] = 'VSt1'
    set ib_skillName[926] = "vst1"
    set ib_skillCustom[926] = 0
    set ib_skillList[927] = 'VDS2'
    set ib_skillName[927] = "å·«æ¯’å¹½é­‚"
    set ib_skillCustom[927] = 0
    set ib_skillList[928] = 'VSt2'
    set ib_skillName[928] = "vst2"
    set ib_skillCustom[928] = 0
    set ib_skillList[929] = 'VDS3'
    set ib_skillName[929] = "å·«æ¯’å¹½é­‚"
    set ib_skillCustom[929] = 0
    set ib_skillList[930] = 'VSt3'
    set ib_skillName[930] = "vst3"
    set ib_skillCustom[930] = 0
    set ib_skillList[931] = 'Umi1'
    set ib_skillName[931] = "é•œåƒ"
    set ib_skillCustom[931] = 0
    set ib_skillList[932] = 'CUt1'
    set ib_skillName[932] = "cut1"
    set ib_skillCustom[932] = 0
    set ib_skillList[933] = 'Umi2'
    set ib_skillName[933] = "é•œåƒ"
    set ib_skillCustom[933] = 0
    set ib_skillList[934] = 'CUt2'
    set ib_skillName[934] = "cut2"
    set ib_skillCustom[934] = 0
    set ib_skillList[935] = 'Umi3'
    set ib_skillName[935] = "é•œåƒ"
    set ib_skillCustom[935] = 0
    set ib_skillList[936] = 'CUt3'
    set ib_skillName[936] = "cut3"
    set ib_skillCustom[936] = 0
    set ib_skillList[937] = 'RHee'
    set ib_skillName[937] = "åŒ»ç–—æ³¢"
    set ib_skillCustom[937] = 0
    set ib_skillList[938] = 'Sstb'
    set ib_skillName[938] = "sstb"
    set ib_skillCustom[938] = 0
    set ib_skillList[939] = 'Pstb'
    set ib_skillName[939] = "pstb"
    set ib_skillCustom[939] = 0
    set ib_skillList[940] = 'Jcnt'
    set ib_skillName[940] = "æ§åˆ¶é­”æ³•"
    set ib_skillCustom[940] = 0
    set ib_skillList[941] = 'Mrp1'
    set ib_skillName[941] = "mrp1"
    set ib_skillCustom[941] = 0
    set ib_skillList[942] = 'Mrp2'
    set ib_skillName[942] = "mrp2"
    set ib_skillCustom[942] = 0
    set ib_skillList[943] = 'Mrp3'
    set ib_skillName[943] = "mrp3"
    set ib_skillCustom[943] = 0
    set ib_skillList[944] = 'Mrp4'
    set ib_skillName[944] = "mrp4"
    set ib_skillCustom[944] = 0
    set ib_skillList[945] = 'WrsB'
    set ib_skillName[945] = "å’†å“®"
    set ib_skillCustom[945] = 0
    set ib_skillList[946] = 'ClrD'
    set ib_skillName[946] = "é©±é€é­”æ³•"
    set ib_skillCustom[946] = 0
    set ib_skillList[947] = 'ClrP'
    set ib_skillName[947] = "clrp"
    set ib_skillCustom[947] = 0
    set ib_skillList[948] = 'AdsR'
    set ib_skillName[948] = "ç”Ÿå‘½æ¢å¤"
    set ib_skillCustom[948] = 0
    set ib_skillList[949] = 'AdsP'
    set ib_skillName[949] = "adsp"
    set ib_skillCustom[949] = 0
    set ib_skillList[950] = 'Cres'
    set ib_skillName[950] = "å¤æ´»"
    set ib_skillCustom[950] = 0
    set ib_skillList[951] = 'Cent'
    set ib_skillName[951] = "çº ç¼ æ ¹é¡»"
    set ib_skillCustom[951] = 0
    set ib_skillList[952] = 'ClwP'
    set ib_skillName[952] = "clwp"
    set ib_skillCustom[952] = 0
    set ib_skillList[953] = 'Cshb'
    set ib_skillName[953] = "éœ¹é›³é—ªç”µ"
    set ib_skillCustom[953] = 0
    set ib_skillList[954] = 'RoFF'
    set ib_skillName[954] = "ç«ç„°é›¨"
    set ib_skillCustom[954] = 0
    set ib_skillList[955] = 'Kslm'
    set ib_skillName[955] = "é›·éœ†ä¸€å‡»"
    set ib_skillCustom[955] = 0
    set ib_skillList[956] = 'Ssth'
    set ib_skillName[956] = "ssth"
    set ib_skillCustom[956] = 0
    set ib_skillList[957] = 'Krsh'
    set ib_skillName[957] = "ç¡¬åŒ–çš®è‚¤"
    set ib_skillCustom[957] = 0
    set ib_skillList[958] = 'ShdB'
    set ib_skillName[958] = "éœ¹é›³é—ªç”µ"
    set ib_skillCustom[958] = 0
    set ib_skillList[959] = 'SmFH'
    set ib_skillName[959] = "é‡å…½å¹½é­‚"
    set ib_skillCustom[959] = 0
endfunction
function IB_SkillFill12 takes nothing returns nothing
    set ib_skillList[960] = 'SmGF'
    set ib_skillName[960] = "é‡å…½å¹½é­‚"
    set ib_skillCustom[960] = 0
    set ib_skillList[961] = 'Simp'
    set ib_skillName[961] = "é‡å…½å¹½é­‚"
    set ib_skillCustom[961] = 0
    set ib_skillList[962] = 'DrnB'
    set ib_skillName[962] = "è‡´å‘½ä¸€å‡»"
    set ib_skillCustom[962] = 0
    set ib_skillList[963] = 'ThPP'
    set ib_skillName[963] = "thpp"
    set ib_skillCustom[963] = 0
    set ib_skillList[964] = 'ClTP'
    set ib_skillName[964] = "é—ªç”µé“¾"
    set ib_skillCustom[964] = 0
    set ib_skillList[965] = 'Kthn'
    set ib_skillName[965] = "è†æ£˜å…‰ç¯"
    set ib_skillCustom[965] = 0
    set ib_skillList[966] = 'Lspp'
    set ib_skillName[966] = "lspp"
    set ib_skillCustom[966] = 0
    set ib_skillList[967] = 'Mspp'
    set ib_skillName[967] = "mspp"
    set ib_skillCustom[967] = 0
    set ib_skillList[968] = 'Gspp'
    set ib_skillName[968] = "gspp"
    set ib_skillCustom[968] = 0
    set ib_skillList[969] = 'Hchp'
    set ib_skillName[969] = "hchp"
    set ib_skillCustom[969] = 0
    set ib_skillList[970] = 'Hbat'
    set ib_skillName[970] = "é—ªç”µä¹‹çƒ(æ–°çš„)"
    set ib_skillCustom[970] = 0
    set ib_skillList[971] = 'Hcr1'
    set ib_skillName[971] = "è‡´å‘½ä¸€å‡»"
    set ib_skillCustom[971] = 0
    set ib_skillList[972] = 'Hcr2'
    set ib_skillName[972] = "è‡´å‘½ä¸€å‡»"
    set ib_skillCustom[972] = 0
    set ib_skillList[973] = 'Hcr3'
    set ib_skillName[973] = "è‡´å‘½ä¸€å‡»"
    set ib_skillCustom[973] = 0
    set ib_skillList[974] = 'Hcr4'
    set ib_skillName[974] = "è‡´å‘½ä¸€å‡»"
    set ib_skillCustom[974] = 0
    set ib_skillList[975] = 'Spr0'
    set ib_skillName[975] = "spr0"
    set ib_skillCustom[975] = 0
    set ib_skillList[976] = 'SpS1'
    set ib_skillName[976] = "sps1"
    set ib_skillCustom[976] = 0
    set ib_skillList[977] = 'SpS2'
    set ib_skillName[977] = "sps2"
    set ib_skillCustom[977] = 0
    set ib_skillList[978] = 'SpS3'
    set ib_skillName[978] = "sps3"
    set ib_skillCustom[978] = 0
    set ib_skillList[979] = 'SpS4'
    set ib_skillName[979] = "sps4"
    set ib_skillCustom[979] = 0
    set ib_skillList[980] = 'SpD1'
    set ib_skillName[980] = "ç¡¬åŒ–çš®è‚¤"
    set ib_skillCustom[980] = 0
    set ib_skillList[981] = 'SpD2'
    set ib_skillName[981] = "ç¡¬åŒ–çš®è‚¤"
    set ib_skillCustom[981] = 0
    set ib_skillList[982] = 'SpD3'
    set ib_skillName[982] = "ç¡¬åŒ–çš®è‚¤"
    set ib_skillCustom[982] = 0
    set ib_skillList[983] = 'SpD4'
    set ib_skillName[983] = "ç¡¬åŒ–çš®è‚¤"
    set ib_skillCustom[983] = 0
    set ib_skillList[984] = 'Cbs0'
    set ib_skillName[984] = "é€šé­”"
    set ib_skillCustom[984] = 0
    set ib_skillList[985] = 'Cbs1'
    set ib_skillName[985] = "é€šé­”"
    set ib_skillCustom[985] = 0
    set ib_skillList[986] = 'Cbs2'
    set ib_skillName[986] = "é€šé­”"
    set ib_skillCustom[986] = 0
    set ib_skillList[987] = 'Cbs3'
    set ib_skillName[987] = "é€šé­”"
    set ib_skillCustom[987] = 0
    set ib_skillList[988] = 'Spr1'
    set ib_skillName[988] = "spr1"
    set ib_skillCustom[988] = 0
    set ib_skillList[989] = 'Spr2'
    set ib_skillName[989] = "spr2"
    set ib_skillCustom[989] = 0
    set ib_skillList[990] = 'Spr3'
    set ib_skillName[990] = "spr3"
    set ib_skillCustom[990] = 0
    set ib_skillList[991] = 'Sp20'
    set ib_skillName[991] = "sp20"
    set ib_skillCustom[991] = 0
    set ib_skillList[992] = 'Sp30'
    set ib_skillName[992] = "sp30"
    set ib_skillCustom[992] = 0
    set ib_skillList[993] = 'Sp40'
    set ib_skillName[993] = "sp40"
    set ib_skillCustom[993] = 0
    set ib_skillList[994] = 'SsT0'
    set ib_skillName[994] = "sst0"
    set ib_skillCustom[994] = 0
    set ib_skillList[995] = 'Sp21'
    set ib_skillName[995] = "sp21"
    set ib_skillCustom[995] = 0
    set ib_skillList[996] = 'Sp31'
    set ib_skillName[996] = "sp31"
    set ib_skillCustom[996] = 0
    set ib_skillList[997] = 'Sp41'
    set ib_skillName[997] = "sp41"
    set ib_skillCustom[997] = 0
    set ib_skillList[998] = 'SsT1'
    set ib_skillName[998] = "sst1"
    set ib_skillCustom[998] = 0
    set ib_skillList[999] = 'Sp22'
    set ib_skillName[999] = "sp22"
    set ib_skillCustom[999] = 0
    set ib_skillList[1000] = 'Sp32'
    set ib_skillName[1000] = "sp32"
    set ib_skillCustom[1000] = 0
    set ib_skillList[1001] = 'Sp43'
    set ib_skillName[1001] = "sp43"
    set ib_skillCustom[1001] = 0
    set ib_skillList[1002] = 'SsT2'
    set ib_skillName[1002] = "sst2"
    set ib_skillCustom[1002] = 0
    set ib_skillList[1003] = 'Sp13'
    set ib_skillName[1003] = "sp13"
    set ib_skillCustom[1003] = 0
    set ib_skillList[1004] = 'Sp33'
    set ib_skillName[1004] = "sp33"
    set ib_skillCustom[1004] = 0
    set ib_skillList[1005] = 'Sp34'
    set ib_skillName[1005] = "sp34"
    set ib_skillCustom[1005] = 0
    set ib_skillList[1006] = 'SsT3'
    set ib_skillName[1006] = "sst3"
    set ib_skillCustom[1006] = 0
    set ib_skillList[1007] = 'Rara'
    set ib_skillName[1007] = "rara"
    set ib_skillCustom[1007] = 0
    set ib_skillList[1008] = 'AMRz'
    set ib_skillName[1008] = "amrz"
    set ib_skillCustom[1008] = 0
    set ib_skillList[1009] = 'Rgld'
    set ib_skillName[1009] = "é‡‘ç®±å­"
    set ib_skillCustom[1009] = 0
    set ib_skillList[1010] = 'Ibld'
    set ib_skillName[1010] = "å—œè¡€æœ¯"
    set ib_skillCustom[1010] = 0
    set ib_skillList[1011] = 'IshP'
    set ib_skillName[1011] = "ishp"
    set ib_skillCustom[1011] = 0
    set ib_skillList[1012] = 'Omth'
    set ib_skillName[1012] = "èƒ½å¸¦æœ‰ç«ç„°ä¼¤å®³çš„ç‰©å“"
    set ib_skillCustom[1012] = 0
    set ib_skillList[1013] = 'Pmh1'
    set ib_skillName[1013] = "pmh1"
    set ib_skillCustom[1013] = 0
    set ib_skillList[1014] = 'Shrd'
    set ib_skillName[1014] = "shrd"
    set ib_skillCustom[1014] = 0
    set ib_skillList[1015] = 'Pprl'
    set ib_skillName[1015] = "æ®‹åºŸ"
    set ib_skillCustom[1015] = 0
    set ib_skillList[1016] = 'Pmh2'
    set ib_skillName[1016] = "pmh2"
    set ib_skillCustom[1016] = 0
    set ib_skillList[1017] = 'Shk0'
    set ib_skillName[1017] = "é€šé­”"
    set ib_skillCustom[1017] = 0
    set ib_skillList[1018] = 'dslw'
    set ib_skillName[1018] = "å‡é€Ÿ"
    set ib_skillCustom[1018] = 0
    set ib_skillList[1019] = 'Shk1'
    set ib_skillName[1019] = "é€šé­”"
    set ib_skillCustom[1019] = 0
    set ib_skillList[1020] = 'Tcrn'
    set ib_skillName[1020] = "tcrn"
    set ib_skillCustom[1020] = 0
    set ib_skillList[1021] = 'Shsw'
    set ib_skillName[1021] = "shsw"
    set ib_skillCustom[1021] = 0
    set ib_skillList[1022] = 'Shel'
    set ib_skillName[1022] = "shel"
    set ib_skillCustom[1022] = 0
    set ib_skillList[1023] = 'Shk2'
    set ib_skillName[1023] = "é€šé­”"
    set ib_skillCustom[1023] = 0
    set ib_skillList[1024] = 'Shk3'
    set ib_skillName[1024] = "é€šé­”"
    set ib_skillCustom[1024] = 0
    set ib_skillList[1025] = 'Shst'
    set ib_skillName[1025] = "shst"
    set ib_skillCustom[1025] = 0
    set ib_skillList[1026] = 'Wst1'
    set ib_skillName[1026] = "wst1"
    set ib_skillCustom[1026] = 0
    set ib_skillList[1027] = 'Wst2'
    set ib_skillName[1027] = "wst2"
    set ib_skillCustom[1027] = 0
    set ib_skillList[1028] = 'SR20'
    set ib_skillName[1028] = "sr20"
    set ib_skillCustom[1028] = 0
    set ib_skillList[1029] = 'SP30'
    set ib_skillName[1029] = "sp30"
    set ib_skillCustom[1029] = 0
    set ib_skillList[1030] = 'SP40'
    set ib_skillName[1030] = "sp40"
    set ib_skillCustom[1030] = 0
    set ib_skillList[1031] = 'EAS1'
    set ib_skillName[1031] = "eas1"
    set ib_skillCustom[1031] = 0
    set ib_skillList[1032] = 'EAS2'
    set ib_skillName[1032] = "eas2"
    set ib_skillCustom[1032] = 0
    set ib_skillList[1033] = 'EAS3'
    set ib_skillName[1033] = "eas3"
    set ib_skillCustom[1033] = 0
    set ib_skillList[1034] = 'EAS4'
    set ib_skillName[1034] = "eas4"
    set ib_skillCustom[1034] = 0
    set ib_skillList[1035] = 'EndA'
    set ib_skillName[1035] = "è€ä¹…å…‰ç¯"
    set ib_skillCustom[1035] = 0
    set ib_skillList[1036] = 'Wsp0'
    set ib_skillName[1036] = "é€šé­”"
    set ib_skillCustom[1036] = 0
    set ib_skillList[1037] = 'DStn'
    set ib_skillName[1037] = "éœ¹é›³é—ªç”µ"
    set ib_skillCustom[1037] = 0
    set ib_skillList[1038] = 'Wsp1'
    set ib_skillName[1038] = "é€šé­”"
    set ib_skillCustom[1038] = 0
    set ib_skillList[1039] = 'ArmB'
    set ib_skillName[1039] = "å¿ƒçµä¹‹ç«"
    set ib_skillCustom[1039] = 0
endfunction
function IB_SkillFill13 takes nothing returns nothing
    set ib_skillList[1040] = 'Wsp2'
    set ib_skillName[1040] = "é€šé­”"
    set ib_skillCustom[1040] = 0
    set ib_skillList[1041] = 'DSn2'
    set ib_skillName[1041] = "éœ¹é›³é—ªç”µ"
    set ib_skillCustom[1041] = 0
    set ib_skillList[1042] = 'Wsp3'
    set ib_skillName[1042] = "é€šé­”"
    set ib_skillCustom[1042] = 0
    set ib_skillList[1043] = 'Wst3'
    set ib_skillName[1043] = "wst3"
    set ib_skillCustom[1043] = 0
    set ib_skillList[1044] = 'Can1'
    set ib_skillName[1044] = "é‡å…½å¹½é­‚"
    set ib_skillCustom[1044] = 0
    set ib_skillList[1045] = 'Anc1'
    set ib_skillName[1045] = "anc1"
    set ib_skillCustom[1045] = 0
    set ib_skillList[1046] = 'HAn1'
    set ib_skillName[1046] = "æ²»ç–—å®ˆå«å…‰ç¯"
    set ib_skillCustom[1046] = 0
    set ib_skillList[1047] = 'HAn2'
    set ib_skillName[1047] = "æ²»ç–—å®ˆå«å…‰ç¯"
    set ib_skillCustom[1047] = 0
    set ib_skillList[1048] = 'HAn3'
    set ib_skillName[1048] = "æ²»ç–—å®ˆå«å…‰ç¯"
    set ib_skillCustom[1048] = 0
    set ib_skillList[1049] = 'Can2'
    set ib_skillName[1049] = "é‡å…½å¹½é­‚"
    set ib_skillCustom[1049] = 0
    set ib_skillList[1050] = 'Anc2'
    set ib_skillName[1050] = "anc2"
    set ib_skillCustom[1050] = 0
    set ib_skillList[1051] = 'Can3'
    set ib_skillName[1051] = "é‡å…½å¹½é­‚"
    set ib_skillCustom[1051] = 0
    set ib_skillList[1052] = 'Anc3'
    set ib_skillName[1052] = "anc3"
    set ib_skillCustom[1052] = 0
    set ib_skillList[1053] = 'Cplz'
    set ib_skillName[1053] = "ç²‰ç¢"
    set ib_skillCustom[1053] = 0
    set ib_skillList[1054] = 'CTh1'
    set ib_skillName[1054] = "cth1"
    set ib_skillCustom[1054] = 0
    set ib_skillList[1055] = 'Camp'
    set ib_skillName[1055] = "camp"
    set ib_skillCustom[1055] = 0
    set ib_skillList[1056] = 'A000'
    set ib_skillName[1056] = "é—ªé¿"
    set ib_skillCustom[1056] = 1
    set ib_skillList[1057] = 'Jsps'
    set ib_skillName[1057] = "é­”æ³•ç›—å–"
    set ib_skillCustom[1057] = 0
    set ib_skillList[1058] = 'A001'
    set ib_skillName[1058] = "èƒ½å¬å”¤ç†Šæ€ªçš„ç‰©å“"
    set ib_skillCustom[1058] = 1
    set ib_skillList[1059] = 'A002'
    set ib_skillName[1059] = "æ¯’è›‡å®ˆå«"
    set ib_skillCustom[1059] = 1
    set ib_skillList[1060] = 'A004'
    set ib_skillName[1060] = "é™æ­¢é™·é˜±"
    set ib_skillCustom[1060] = 1
    set ib_skillList[1061] = 'Kchg'
    set ib_skillName[1061] = "kchg"
    set ib_skillCustom[1061] = 0
    set ib_skillList[1062] = 'A003'
    set ib_skillName[1062] = "è™šæ— å½¢æ€"
    set ib_skillCustom[1062] = 1
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
    elseif ib_fillIdx == 6 then
        call IB_Fill6()
    elseif ib_fillIdx == 7 then
        call IB_Fill7()
    endif
    set ib_fillIdx = ib_fillIdx + 1
    if ib_fillIdx >= ib_fillTotal then
        set ib_itemCount = 610
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
    elseif ib_skFillIdx == 11 then
        call IB_SkillFill11()
    elseif ib_skFillIdx == 12 then
        call IB_SkillFill12()
    elseif ib_skFillIdx == 13 then
        call IB_SkillFill13()
    endif
    set ib_skFillIdx = ib_skFillIdx + 1
    if ib_skFillIdx >= ib_skFillTotal then
        set ib_skillCount = 1063
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
    set ib_fillTotal = 8
    set ib_fillTimer = CreateTimer()
    call TimerStart(ib_fillTimer, 0.01, true, function IB_FillStep)
    set ib_skFillIdx = 0
    set ib_skFillTotal = 14
    set ib_skFillTimer = CreateTimer()
    call TimerStart(ib_skFillTimer, 0.01, true, function IB_SkillFillStep)
    set ib_unFillIdx = 0
    set ib_unFillTotal = 11
    set ib_unFillTimer = CreateTimer()
    call TimerStart(ib_unFillTimer, 0.01, true, function IB_UnitFillStep)
    // call IB_FingerCastInit()
endfunction

//---------------------------------------------------------------------------
// åˆ†å¸§å¡«å……:æ¯å¸§è°ƒç”¨ä¸€ä¸ª IB_FillN,å…¨éƒ¨å®Œæˆåè®¾ç½® ib_itemCount
//---------------------------------------------------------------------------
