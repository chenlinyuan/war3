# KK / KKWE 平台图"单机能进图"修复手册

> 2026-10-13 记录。起因：`1BB520914688B25CA8222FF5D32B58D0.w3x`（侏罗纪公园-轮回3，454MB）
> 放进 `Maps\mod` 后，游戏在地图选择界面**能看到地图名字，但玩家列表是空的、进不去**。

## 症状 → 真正的病因

症状很容易被误判成 w3i（地图信息）写坏了。其实 **w3i 是好的**，坏的是 MPQ 哈希表里的
一个字段：**`wPlatform`**。

### 证据链

1. `w3i` 用 Doctor 的解析器读出来完全正常：7 个玩家、2 个阵营、372×148、tileset W。
2. 用**游戏自带的 Storm.dll**（`sfmpq_probe.ps1`，和游戏走同一条 MPQ 代码路径）挨个开门：

   | 文件 | 平台原图 | 我们注入过脚本的版本 |
   |------|---------|--------------------|
   | `war3map.w3i` | **OPEN FAIL** | **OPEN FAIL** |
   | `war3map.w3e` | OPEN FAIL | OPEN FAIL |
   | `war3map.j`   | ok (136B 存根) | ok |

   → 引擎**根本打不开这张图的任何原始文件**，所以地图列表里只有个名字（来自文件开头的
   `HM3W` 头），一进设置页需要 `w3i/w3e` 时就全空。
3. 逐字节看哈希表：2736 条里 **2734 条的 `wPlatform = 0xFF00`**，只有 `war3map.j`
   （KK 打包器后来补写的）是 `0x0000`。标准 Storm 的 `SFileOpenFileEx` 只接受
   **platform == 0** 的条目；开源读取器（StormLib / 我们的 `war3mpq.py`）**忽略**这个字段，
   所以"我们的工具能读、游戏读不到"。
4. 把 2734 条的 platform 清零后，游戏自带 Storm 立刻能读出 `w3i / w3e / w3a / doo /
   shd / wpm / mmp / wts / war3map.j` —— 全部 ok，尺寸正确。

这就是 KK 的"壳图"保护里最实在的一道：**平台端用打过补丁的引擎（`game.4dll` /
`jass_loader.*.dll`）忽略 platform 字段，单机用原版 Storm 就被挡住**。
脚本换成 `kkmap.jc` 字节码是另一道，两道都绕过后才能单机跑。

## 修复配方（三步，全部可脚本化）

```powershell
# 0) 先备份
Copy-Item <平台原图.w3x> <工作副本.w3x>

# 1) 真脚本：KK 图里 war3map.j 只有 136 字节存根，真代码在 kkmap.jc
#    用 Devo's Map Doctor 还原成 JASS（editor 动作），见 §脚本还原

# 2) 平台原生函数改成同名 JASS 存根（就地替换！见下）
python tools\war3map-injector\_stub_inplace.py real.j fixed.j "Dz,EX,RequestExtra,LBK,Blz,JAPI"

# 3) 注入 + 解除 platform 屏蔽
python tools\war3map-injector\inject_native.py <工作副本.w3x> --file fixed.j=war3map.j --out <产物.w3x>
python tools\war3map-injector\fix_hash_platform.py <产物.w3x>

# 4) 用游戏自己的 Storm 验一遍（必须全 ok）
& "$env:SystemRoot\SysWOW64\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -File `
   tools\war3map-injector\sfmpq_probe.ps1 -Map <产物.w3x>
```

### 脚本还原（步骤 1）

```powershell
python tools\_devos-map-doctor\devos-map-doctor-main\DevosMapDoctor.py --cli editor <地图> --out <输出>
# 产物里的 war3map.j 就是真脚本（14MB）
```

### ⚠ 坑一：native 存根必须**就地**替换

JASS 是**先定义后使用**（Doctor 还原出的脚本里 83 个 `native` 全都排在第一个 `function` 之前，
就是为了这个）。把存根**追加到文件末尾**会让 8 千多行之外的调用点找不到函数 → 编译失败 →
地图进不去。`stub_platform_natives.py` 旧行为是追加（错），现在有 `--in-place`；
`_stub_inplace.py` 默认就地。

### ⚠ 坑二：pjass 要用对的 common.j

JassCraft 自带的 `common.j` 是 1.07 时代的，缺 `agent`/`hashtable`/`GetHandleId`，
拿它验 1.24+ 图会报**二十万条假错**。用 Doctor 自带的参考脚本：

```
tools\_devos-map-doctor\devos-map-doctor-main\doctor\ref\1.24\{common.j,blizzard.j}
```

验过 clean（`Parse successful`）才算脚本没问题。

## 本地判据（不用进游戏）

| 判据 | 工具 | 说明 |
|------|------|------|
| 引擎能不能读到文件 | `sfmpq_probe.ps1` | **最关键**。只要 `w3i/w3e/doo/shd/wpm/mmp/wts/war3map.j` 有 OPEN FAIL，地图就进不去 |
| 哈希条目 platform | `fix_hash_platform.py --dry` | 非 0 的条目数 > 0 就要跑一次 |
| 脚本能不能编译 | pjass + Doctor 的 1.24 参考脚本 | `Parse successful` |
| 单机锁 | `DevosMapDoctor --cli qol` / `single_player.find()` | 脚本里有没有"单机就 EndGame"的分支 |

## 关于 platform 字段的补充

- 别去改 `wLocale`：这几张图 locale 本来就是 0，要清的只有高 16 位的 platform。
- 只改哈希表 4 个字节里的 2 个（每条的 `bytes[14:16]`），**块表、文件数据一律不动** ——
  改完的产物和原图逐条比对，只有 `war3map.j` 那一条块表不同。
- 哈希表本身是**标准密钥加密**的（`hash("(hash table)", FILE_KEY) = 0xC3AF3770`），
  所以改完要重新加密写回。

## 第三道锁：作者埋的"防盗版失败判定"

单机能进图之后，开图 1 秒就会出现 `游戏失败 请弊佬 关掉软件尝试！！！` 的失败对话框
（就是 `CustomDefeatBJ` 的默认四按钮：重新开始 / 降低难度 / 装载游戏 / 退出战役）。

`侏罗纪公园-轮回3` 里的原话（`war3map.j` 第 19629 行那个触发器，`TriggerRegisterTimerEventSingle(..., 1.0)`）：

```jass
if (DzAPI_Map_HasMallItem(p, "JDJ001") == true or DzAPI_Map_HasMallItem(p, "CJVVVVVIP") == true)
   and DzAPI_Map_IsMapTest() == false then
    // 1..6 号玩家全部 CustomDefeatBJ("游戏失败 请弊佬 关掉软件尝试！！！")
```

`JDJ001` / `CJVVVVVIP` 是**卖破解版的人才会塞进存档里的商城道具标记**。作者的算盘是：
破解版必然"商城道具全解锁"，一开图就判死。而我们的存根为了给玩家开商城道具，
`DzAPI_Map_HasMallItem` 一律返回 `true` —— 于是正好踩中。

**修法**：让 `DzAPI_Map_IsMapTest()` 返回 `true`。
这个函数在全图**只有这一处用途**（就这个陷阱），所以等于只拆这一个判定，
商城道具照旧全开。注意它不一定是 native：

```jass
// 这张图里它是脚本自己的包装函数，转调平台 native —— 存根替换不到，得直接改函数体
function DzAPI_Map_IsMapTest takes nothing returns boolean
    return RequestExtraBooleanData(74, null, null, null, false, 0, 0, 0)   // 平台 id 74
endfunction
```

`tools/war3map-injector/_stub_inplace.py` 现在会自动做这件事（`--no-map-test` 可关）。
**通用规律**：跑通平台图后如果立刻弹失败框，先搜 `CustomDefeatBJ` 和
`BJDebugMsg("...作弊...")`，看它的条件是不是依赖某个"平台才为真"的返回值——
我们的存根（全 mall=true / 其余 false）最容易踩的就是"破解版标记 + 非测试模式"这一类。

### 这张图里其余 9 处失败判定（先没动）

| 行 | 提示 | 判定依据 |
|----|------|---------|
| 16937 | `你们坚持了X秒…` | 正常玩法（守塔计时结束），保留 |
| 19442 | `请勿作弊 弊佬` | `udg_WJRS` 与单位上某计数比较，图内数据自校验 |
| 41012 | `请勿作弊 如有疑问 请截图 找作者` | 由 42675 触发：存档序号 `0xBEC6909A != udg_SJZGXH001` 时清光玩家单位 |
| 138693 等 ×6 | `请勿作弊！` | 输入存档码校验失败（`深渊·暗灭` 等存档） |

前两类都是**图内 hashtable/global 自校验**，不依赖平台数据，正常打不会误触；
第三类只在用存档码时才会走到。真遇到再按提示文案定位即可。

## 战役（.w3n）：`Campaigns\dz\194213.w3n`

### 先看它是什么

| 检查 | 结果 |
|------|------|
| 外层 .w3n 哈希表 platform | 全 0（**没有** platform 屏蔽） |
| 章节 | 25 个：`ransao01..09`（2 位）+ `ransao010..025`（3 位），13 个 `.w3x` + 12 个 `.w3m` |
| 章节存储 | `flags=0x80000000`，`csize==fsize` —— **全部未压缩**（游戏把章节当子归档打开的前提，本来就满足） |
| 每章脚本 | `war3map.j` = 118 字节 `// *** GENERATED WITH KKWE...` 存根，真代码在 `kkmap.jc`（136KB~900KB） |
| 引擎能不能读 | 游戏自带 Storm 逐文件开门：`w3i/w3e/w3u/w3a/doo/…` 全 ok —— 只有脚本是缺的 |
| 防盗版判定 | 没有（不像轮回3 有 `IsMapTest` 陷阱），只有 15~16 个平台原生要存根 |

### ⚠ 坑三：Doctor 的 kk 签名表可能缺条目

`--cli editor` 会报
`the signature of the native DzAPI_Map_GetPlatformVIP is not known (it is not in kk_natives.j)`。
这版 KKWE（Generator 1.0.0.266）用了 6 个 Doctor 没收录的签名：

```
DzAPI_Map_GetPlatformVIP / GetServerValue / GetServerValueErrorCode
DzAPI_Map_Ladder_SetStat / Ladder_SetPlayerStat / SaveServerValue
```

前五个签名照抄 `doctor/port/compat/nat_dzapi.j`（同一套平台 API），
`GetPlatformVIP` 取自 轮回3 还原脚本里的同名包装函数。追加进
`doctor/script/kk_natives.j`（原文件备份为 `kk_natives.j.orig`）后，
**25 章一次性全部可反编译**，不需要再补别的。

### 配方（`tools/war3map-injector/_camp_build.py`）

```powershell
python tools\war3map-injector\_camp_build.py "<战役.w3n>" <工作目录> `
       [--only ransao01.w3x] [--limit N] [--repack <输出.w3n>]
```

每章：取出 → Doctor `editor` 还原 JASS → `_stub_inplace.py` 就地存根
（15~16 个 `DzAPI_*/Dz*/RequestExtra*`）→ pjass（Doctor 的 1.24 参考脚本）→ 写回章节。
`--repack` 时用 `inject_native.py ... --store <章节名>` 把 25 章**原样存储**写回 .w3n。

**不要**整个用 Doctor 的 editor 产物覆盖章节：那会连带塞进
`war3map.wtg/wct/w3r/w3c/w3s/imp` 等编辑器专用文件、还会删掉"未知 ID"的装饰物。
只取它还原出来的 `war3map.j` 注入回原章节，才是最小改动。

### 验证（改完 .w3n 必跑）

```powershell
$ps32 = "$env:SystemRoot\SysWOW64\WindowsPowerShell\v1.0\powershell.exe"
# 章节能不能被当内嵌归档打开（战役能不能玩的关键；必须每章都 OK）
& $ps32 -NoProfile -File tools\war3map-injector\sfmpq_subarchive.ps1 -Map <新.w3n> -Names "<章节名,逗号分隔>"
# 外层战役文件能不能读
& $ps32 -NoProfile -File tools\war3map-injector\sfmpq_probe.ps1 -Map <新.w3n> `
    -Names "war3campaign.w3f,war3campaign.wts,war3campaign.w3a,war3campaign.w3u,(listfile)"
```

本次结果：25/25 章 `open-as-archive: OK`，每章 `war3map.j` 还原后 49KB~3.5MB，
pjass 全部 `rc=0`（0 错误）。产物 542MB（比原 488MB 大：真脚本比字节码大），
显示名在 `war3campaign.wts` 里改成了 `燃烧之怒v烈焰降临（单机版）`。

### ⚠ 坑四：**绝对不要改 `war3campaign.wts`**（改了必崩）

2026-10-13 实测：只把 wts 里的战役名 `（更新）`→`（单机版）`（3 字节的等值替换），
进游戏点开战役立刻致命错误：

```
This application has encountered a critical error:
The file data is corrupt.
File:   war3campaign.wts
-> Errors\*.txt 里 Stack Trace 是 Storm.dll +0x2177A / 0x216AA ← Game.dll
```

**但这个 wts 的数据本身是完好、可读的**：本地读取器和 SFmpq→游戏自带 Storm.dll
读出来一模一样，md5 恰好等于 `原版.replace('（更新）','（单机版）')`。
所以引擎报的不是"读不出来"，而是**校验不通过**——平台的战网/反作弊层会核对
战役级文件（`war3campaign.*`），改了长度/哈希就判 corrupt。

**结论**：战役级文件（`war3campaign.wts/w3f/w3u/w3t/w3a/w3h/w3b/w3d/w3q/imp`）
一个都别动，只改章节里的东西。想区分"改过的"和平台原版，改**文件头的 HM3W 名字**
（前 512 字节里那个 NUL 结尾字符串，就地改、不动 MPQ、不动任何条目）：

```powershell
python tools\war3map-injector\_patch_hm3w_name.py <战役.w3n> "|cFFFFFF00你的名字（单机版）"
```

依据：游戏"自定义战役"列表显示的就是 HM3W 里的名字，不是文件名。
例：`血色II 3.2.0.w3n` 的 HM3W 是 `|CFFFF0000血色使命 II|r 正式版 3.2.0`，
列表里显示"血色使命 II 正式版 3.2.0"。
（注意 HM3W 头块固定 512 字节，名字后面到 0x200 之间全是 0 填充，所以新名字
比旧名字长几个字节是安全的——从尾部补零处拿长度即可。）

### ⚠ 坑五：平台的"试玩/商城"门禁（`194213` / `205273` 实测）

战役级 `(attributes)` 只是第一道坎。真正让"玩不到一分钟就退回选章节页/立刻失败"的是
**脚本里的平台门禁**，每章 20~30 处：

| 形态 | 条件 | 动作 |
|------|------|------|
| 试玩到期 | `HasMallItem(p,"0000GS0006") != true`（没买正式版） | `你的体验时间已到期！` + 清光玩家单位 + `CustomDefeatBJ` |
| 试玩标记 | `HasMallItem(p,"00S0M06") == true`（命中试玩标记） | 同样判负 |
| 付费内容守护 | `HasMallItem(p,"AKPF85") != true and 你有单位'U647'` | `CustomDefeatBJ("失败!")` |
| **商城领奖里藏判胜** | `HasMallItem(p,"ELQSM5") == true` → 创建宠物 → `HasMallItem(p,"ELSM5") == true` | **`CustomVictoryBJ`**（= 本章提前结束、退回选章节页） |

处理两件事（都在 `_camp_build.py` 里自动跑）：

1. `DzAPI_Map_HasMallItem` 的存根**按 key 返回**（`_gate_scan.py` 扫描全部门禁后决定）：
   `== true` 形态的 key（试玩标记）→ `false`；`!= true` 形态的 key（正式版/守护）→ `true`；
   其余 → `true`（福利全开）。
2. **平台相关的"结束游戏"调用就地改成 `call DoNothing()`**（`_neutralize_ends.py`）：
   只动"触发器条件或动作里出现 `Dz*/EX*/RequestExtra*`"的那些
   `CustomDefeatBJ/CustomVictoryBJ/EndGame/RemovePlayerPreserveUnitsBJ`；
   剧情的判负/判胜（英雄阵亡、任务完成）原样保留。

> 只改条件不够：领奖触发里的判胜是**藏在动作里**的，条件只检查"你拾取了物品 I672"。

### ⚠ 坑六：商城"领取宠物"触发器会删掉主角（`194213` 第 2/8 章实测）

模式（一张图里重复十几次，外圈发福利、内圈清场）：

```jass
if DzAPI_Map_HasMallItem(Player(0), "QMJJ1") == true then       // 外圈：发宠物
    call DisableTrigger(GetTriggeringTrigger())
    call CreateNUnitsAtLoc(1, 'H67M', Player(PLAYER_NEUTRAL_PASSIVE), ...)
    call QuestMessageBJ(..., "恭喜你领取成功！请使用宠物精灵占据你领取的宠物哦")
    if DzAPI_Map_HasMallItem(Player(0), "RRT55") == true then   // 内圈：清场
        call RemoveUnit(udg_ak)          // ← 主角
        call RemoveUnit(udg_chongwu02)   // ← 宠物
        call RemoveUnit(udg_chongwu01)
        call RemoveUnit(gg_unit_e60P_0433)
        call RemoveUnit(gg_unit_e60P_0434)
    endif
else
    call QuestMessageBJ(..., "你尚未购买本道具，请在战魂商城购买！")
endif
```

福利全开（存根默认 `return true`）时内外圈都会跑 → **主角被 `RemoveUnit` 删掉、左上角英雄
图标消失**，而且这里没有任何"造新单位顶替"的动作，所以是彻底消失、不是阵亡。

处理：`_patch_pet_delete.py` 只把
`call RemoveUnit(udg_ak)` + 紧随其后的 `RemoveUnit(udg_chongwuNN)`（± `gg_unit_*`）这一整块
换成 `call DoNothing()`。

**别**把整条链的 key 都设成 `mall_false`：那些**外圈** key 同时出现在
`HasMallItem(key) != true and …` 的"付费内容守护"条件里（见坑五），设成 false 会反过来
**打开**守护触发器、清光玩家单位。真正的"换英雄皮肤"块（先造替身 → 复制物品/等级 →
`RemoveUnit(udg_ak)` → `set udg_ak = 新单位`）不匹配该模式，保持原样。

### ⚠ 坑七：`I67N` 是"本地通关"标记，被免费发放就立刻判胜

```jass
// 拾取 I67N 的触发器
set udg_gaoshi = 10
call InitGameCacheBJ("zui")  /  StoreInteger(..., "gao", "gao", 10)  /  SaveGameCache
...
// 主角走进出口区域
if udg_gaoshi == 0 and udg_jilao == 0 then
    call ShowUnit(udg_ak, false)                    // 正常：进下一章
else
    call CustomVictoryBJ(Player(0), false, false)   // 直接本章通关
endif
```

`I67N` 只有两个来源，都挂在商城 key 上：

* `YUTUSZ`（"军团的无畏"）——**10 秒周期触发器**，开局就往主角身上 `UnitAddItemByIdSwapped('I67N', ...)`；
* `RSOX255`——某个单位死亡时 `CreateItemLoc('I67N', ...)`。

所以这两个 key 必须 `return false`，否则开局十几秒就拿到通关道具。
`_camp_build.py` 用 `GS.keys_of_triggers_containing(text, "'I67N'")` 自动把这类 key 找出来。

> `_neutralize_ends.py` **拦不住**这个 `CustomVictoryBJ`：它的条件/动作里没有平台接口，
> 被当成"剧情判胜"保留了。必须从"别把 I67N 发出去"这一头堵。

### 重跑单章：不要在"已处理过的章节"上二次加工

`_patch_cinematics.py` 等补丁**不幂等**（实测二次运行又匹配到 4 处并重复改写）。
补丁要分两步做：

1. 以**平台原版 .w3n** 为源，`--only <章>` 重跑，得到干净的 `*.fixed`；
2. 用 `inject_native.py` 把这些 `*.fixed` 合并进**当前已部署的单机版 .w3n**（其余章节保持不动）。

```powershell
python tools\war3map-injector\_camp_build.py "H:\Games\War3\Campaigns\dz\194213.w3n" `
    "_work\m4" --only "ransao02.w3x,ransao08.w3m"
python tools\war3map-injector\inject_native.py "<已部署的单机版>.w3n" `
    --file "_work\m4\ransao02.fixed=ransao02.w3x" --store "ransao02.w3x" `
    --file "_work\m4\ransao08.fixed=ransao08.w3m" --store "ransao08.w3m" `
    --out "_work\new.w3n" --no-backup
python tools\war3map-injector\_patch_hm3w_name.py "_work\new.w3n" "|cFFFFFF00…（单机版）"
python tools\war3map-injector\fix_campaign_attributes.py "_work\new.w3n"
```

辅助工具：`_jctx.py <file> <regex> [before] [after]` 打印匹配点上下文（大脚本里定位
某段逻辑用，行号用 Python 自己的 `splitlines()`，不受 PowerShell 行尾差异影响）。

### ⚠ 坑八：商城福利白送的道具，拾取时会删掉关卡 BOSS（`194213` 第 2 章实测）

```jass
// 商城“征战之怒” key = TU66B，注册在 10 秒（单次 + 周期）定时器上
function Trig...uConditions takes nothing returns boolean
    return DzAPI_Map_HasMallItem(Player(0), "TU66B") == true
endfunction
function Trig...uActions takes nothing returns nothing
    call DisableTrigger(GetTriggeringTrigger())
    call QuestMessageBJ(..., "（已激活-征战之怒 -效果！…200点征战值…）")
    call UnitAddItemByIdSwapped('I67I', udg_ak)   // ← 白送 I67I
endfunction

// 任何单位拾取 I67I
function Trig...uActions takes nothing returns nothing
    if GetItemTypeId(GetManipulatedItem()) == 'I67I' then
        call RemoveUnit(gg_unit_H64Z_0401)        // ← 本关 BOSS“邪能之体”被删掉
    endif
endfunction
```

`gg_unit_H64Z_0401`（邪能之体）开局 `CreateUnit` 出来，随后
`ShowUnit(false)` + `PauseUnitBJ(true)` + `SetUnitInvulnerable(true)` “封印”；
打掉封印单位 `npgr_0460` 后 `ShowUnit(true)` + `PauseUnitBJ(false)` 解封。
**一旦它先被 `RemoveUnit`，解封调用就变成空操作 → BOSS 永远不出现**，
而主线任务物品“邪能能源”`I600` 只有它 100% 掉落 → 主线永久卡死。

顺带一个必须记住的引擎行为：脚本用 `UnitAddItemByIdSwapped` 塞道具**同样会触发**
`EVENT_PLAYER_UNIT_PICKUP_ITEM`（作者正是靠这个事件给自己加 200 征战值）。

处理：`_gate_scan.risky_item_keys()` —— “若拾取物品 X 会 `RemoveUnit(gg_unit_*)` 掉一个
**预置单位**，则所有白送 X 的商城 key 一律强制 `mall_false`”。必须在
`_patch_pet_delete.patch()` **之后**调用，否则宠物领取触发会被误判。第 2 章命中
`I67I → TU66B`，其余 24 章 0 命中。

### 地形范围：不要再按 16 / 32 单位每格折算

旧 `_terrain_check.py` 按 16 / 32 单位每格算，得出“只有 11% 的单位在地形内”，**是错的**。

* `war3map.w3e` 头部最后两个 float 不是“格数偏移”，而是
  `-(width-1)/2*128`、`-(height-1)/2*128`（世界坐标原点在地图正中心）；
* **1 格 = 128 世界单位**，所以
  `x ∈ [off_x, off_x + (width-1)*128]`、`y ∈ [off_y, off_y + (height-1)*128]`；
* 旁证：`war3map.wpm` / `war3map.shd` 的格子是 32 单位，格子数 =
  `(width-1)*4 × (height-1)*4`（第 2 章 = 640×768，与 161×193 吻合）。

`_terrain_check2.py` 复核 `194213` 全部 25 章：**11871 个预置单位、805 个 Rect，越界 0 个**。

> 这张图的预置单位**不在 `war3mapUnits.doo` 里**——它没有这个文件，单位全部由
> `war3map.j` 里的 `CreateUnit(p, 'xxxx', x, y, angle)` 生成。所以查单位坐标要扫脚本。

### ⚠ 坑九：别把过场跳过条件从 `== 10` 改成 `!= 20`（会凭空传送主角）

过场标志（`udg_dianyingtiaoguo` / `dianyingtiaoguo20` / `dianyingtiaoguo30`）取值：

* `0` = 该段电影**还没开始**
* `10` = 该段电影**正在放**（作者的可跳过窗口，"10秒内按下ESC可跳过电影"）
* `20` = 已播完 / 已跳过

跳过触发器注册在 `TriggerRegisterPlayerEventEndCinematic(Player(0))`（= 玩家按 ESC），
条件原版是 `udg_<flag> == 10`。

早期为了"整段过场随时可跳"，把条件改写成 `udg_<flag> != 20`。后果：
**该段电影还没开始时（flag = 0）条件也成立**。于是玩家在"开局电影"里按 ESC，
会命中"迪洛戈过场"的跳过触发器 —— 主角被直接传送到舞池 `gg_rct_024`，
而且"命令迪洛戈-狂怒之煞"被顺手判为完成。症状就是"开局动画一结束，阿克蒙德站在
3 个舞女那里，而不是万神殿门口"。

正确做法：条件**保持 `== 10` 不要动**。需要"自动走跳过分支"时，在过场函数里
（`set udg_<flag> = 10` 之后）直接 `EnableTrigger` + `TriggerExecute(<跳过触发器>)` + `return`，
此时 flag 正好是 10，条件成立，不依赖放宽条件。

> 顺带记下第 2 章的关键坐标，便于核对主角站位：
> 主角出生点 `(7428,-11830)`；开局结束/跳过后的落点 `rect003 = (7856,-10416)`（万神殿大门一带）；
> 宠物传送门 `nwgt_0066 = (7360,-7744)`；舞池 `rect024 = (-3824,-10640)`，
> 3 个舞女 `n64V_0292 (-4385,-11673)` / `n64X_0404 (-4064,-11574)` / `n64W_0403 (-3707,-11770)`；
> 迪洛戈 `O618_0080 = (-4095,-10694)`（走进 450 范围才触发舞会过场）。

### ⚠ 坑十：商城福利会写"跨关卡存档标记"，把主线永久锁死

第 2 章实测：

```jass
// 商城福利「敌人弱化」(key JDOLS5)，注册在 5 秒（单次+周期+单位死亡+读档）
set udg_ruohua = 10

// 另一个 2 秒周期触发器把它**写进玩家的战役存档**
function Trig____036Actions ...
    set udg_qianghua = 10
    call InitGameCacheBJ("qianghua")
    call StoreInteger(GetLastCreatedGameCacheBJ(), "qiang", "hua", udg_qianghua)
    call SaveGameCache(GetLastCreatedGameCacheBJ())

// 第 2 章开局读回来
set udg_bobo = GetStoredInteger(GetLastCreatedGameCacheBJ(), "qiang", "hua")
```

存档落在 `H:\Games\War3\Save\ProfileN\Campaigns.w3v`（**跨关卡、跨存档**）。而这个标记
一旦非 0：

* 博拉尔过场的自然分支条件 `udg_bobo == 0 and ...` 不成立 —— 只有这一支才会
  `SetUnitInvulnerable(gg_unit_npgr_0460,false)` +
  `SetDestructableInvulnerable(gg_dest_B60P_4539,false)`（把封印改成可攻击）；
* BOSS「邪能之体」解封触发器条件也是 `udg_bobo == 0`。

于是主线「获得邪能能源」永远做不完：封印打不动、BOSS 不出现。而"福利全开"会在开局
第 5 秒自动激活 JDOLS5，**第一次游玩就把存档写脏**。

处理（两件都要做，因为存档可能已经脏了）：

1. `_gate_scan.cache_poison_keys()`：凡"商城福利 `== true` → `set udg_X = 10` →
   另一个以 `udg_X == 10` 为条件、动作含 `SaveGameCache` 的触发器"这条链上的 key，
   一律强制 `mall_false`（第 2 章命中 `JDOLS5`，第 7 章命中 `TU66B`）。
2. `_patch_cache_flags.py`：把 `GetStoredInteger(..., "qiang","hua")` 的读取改成 `0`，
   并把 `StoreInteger(..., "qiang","hua", ...)` 改成 `DoNothing`。
   这样**不需要删玩家的战役存档**也能恢复主线。

### 第 2 章 BOSS「邪能之体」的完整前置链（照这个顺序走）

1. 走近「博拉尔-腐朽者」`gg_unit_H64R_0017 = (-7547,-11036)` 触发剧情过场（450 范围）——
   这一步才会把封印改成可攻击、任务更新为「获得邪能能源」；
2. 去神殿外的陨石坑（北侧）：打掉封印破坏物 `gg_dest_B60P_4539 = (-7488,8192)`
   与封印单位 `gg_unit_npgr_0460 = (-7744,9344)`；
3. 封印单位死亡 → 毒雾特效 ×3 + 「邪能之体」出现 `gg_unit_H64Z_0401 = (-7830,10597)` 并冲过来；
4. 击杀 → 100% 掉落 `I600`（邪能能源）→ 拾取后主线完成
   （`Trig____018` 条件就是 `GetItemTypeId(GetManipulatedItem()) == 'I600'`）。

注意 BOSS 是**开局 `CreateUnit` 出来后被 `ShowUnit(false)`+暂停+无敌"封印"**的，
所以"直接闪过去"看到的永远是空的 —— 必须按上面顺序解封。

### ⚠ 坑十一：`UNIT_TYPE_HERO` 死亡判定会把"敌人 BOSS"也算进去

```jass
function Trig____033..._2_______uConditions takes nothing returns boolean
    return DzAPI_Map_HasMallItem(Player(0), "00GS00006") == true
           and IsUnitType(GetDyingUnit(), UNIT_TYPE_HERO) == true   // ← 不看归属！
endfunction
// 动作：ForGroupBJ(Player(0) 的全部单位, RemoveUnit)  ← 只清场，不判负
```

BOSS「邪能之体」本身就是英雄类单位 → **打死它的瞬间这条触发器就成立**，
把玩家所有单位（主角、宠物、全部）`RemoveUnit` 掉。表现就是"打完 BOSS 主角和宠物
都没了"，而且**没有判负弹窗**（这条只清场）。

同一章还有 `Trig____022________3`：

```jass
return IsUnitType(GetDyingUnit(), UNIT_TYPE_HERO) == true
       and IsUnitIllusionBJ(GetDyingUnit()) != true
       and GetOwningPlayer(GetDyingUnit()) == Player(0)     // 宠物也满足！
// 动作：CustomDefeatBJ("失败!") + 清光玩家单位
```

它把**宠物**也算成英雄（商城宠物、`udg_chongwu01/02` 都是英雄类单位），宠物阵亡
同样清空全队。

处理：`_patch_hero_death.py` 给这两类条件追加 `and GetDyingUnit() == udg_ak`
—— 只有主角 `udg_ak` 阵亡才算失败/清场（作者"英雄不能死亡"的主线判负照旧生效）。

### ⚠ 坑十二：作者的"商城福利"触发器本身就把玩家单位删光（`194213` 第 15/22 章实测）

症状：**进图十几秒后英雄、宠物、全部单位一起消失，而且没有判负弹窗**。第 15 章
（`ransao015.w3m`）实测复现，屏幕上还能看到作者自己的福利提示：

```
（已激活-攻击强化-效果！你的英雄额外获得初始50点攻击力提升！）
```

作者原码（平台原版 `war3map.j` 里就是这样，不是我们改出来的）：

```jass
function Trig____033________3_______uConditions takes nothing returns boolean
    return DzAPI_Map_HasMallItem(Player(0), "URIZZ4") == true     // 商城「攻击强化」
endfunction
function Trig____033________3_______uActions takes nothing returns nothing
    ...
    call QuestMessageBJ(..., "…额外获得初始50点攻击力提升！")
    call YDWEGeneralBounsSystemUnitSetBonus(udg_ak, 3, 0, 50)     // 福利：加攻
    call SaveGroupHandle(YDLOC, ..., YDWEGetUnitsOfPlayerMatchingNull(Player(0), null))
    call ForGroupBJ(..., function Trig____033________3_______uFunc008002)  // ← 删光玩家所有单位
    call DestroyGroup(...)
endfunction
function InitTrig____033________3_______u takes nothing returns nothing
    ...
    call TriggerRegisterTimerEventSingle(gg_trg____033________3_______u, 10.0)
    call TriggerRegisterTimerEventPeriodic(gg_trg____033________3_______u, 10.0)
```

第 22 章 `XHLLL7` 同款，但注册在"任意单位受伤 / 施法 / 拾取 / 丢弃物品"上 —— 一动就清场。

**为什么单机必踩**：这些触发器只挂"你买了该商城道具"一个条件，平台上是"买了才发福利"；
单机存根为了福利全开把 `DzAPI_Map_HasMallItem` 一律 `return true`，于是**开局 5~10 秒
全部成立**。它们的清场动作**只清场、不判负**，所以看不到失败框，只有单位凭空消失。

这一族（作者同一套模板，每章重复十几次）共三种形态，别混：

| 条件形态 | 含义 | 处理 |
|---|---|---|
| `HasMallItem(p,KEY) == true` | 商城福利（发钱/加攻/给宠物），**动作末尾清场** | 中和清场句，福利保留（坑十二） |
| `HasMallItem(p,KEY) != true and 你有单位 X` | 归属校验：没买却拥有 → 收回/判负 | 存根对这些 KEY 一律 `true` 即可（坑五） |
| `HasMallItem(p,KEY) != true`（无附加） | 试玩到期 → 清场 + `CustomDefeatBJ` | 同上（坑五） |

**判据（本地不用进游戏）**：

```powershell
# 单文件；--campaign 扫整个 .w3n；--all 连非商城的清场触发器一起看
python tools\war3map-injector\_scan_mall_wipes.py <war3map.j>
python tools\war3map-injector\_scan_mall_wipes.py --campaign "<战役.w3n>"
```

输出里的"福利形态"计数 > 0 就要处理。

**处理**：`_patch_mall_wipe.py`（已接进 `_camp_build.py`）只对"条件里**只有**一条
`HasMallItem(..., KEY) == true`"的触发器，把它动作里那句
`call ForGroupBJ(..., function <删单位>)` 换成 `call DoNothing() // IB: mall welfare must not wipe player units`；
条件里还有别的子句的（例如"英雄阵亡"）一律不动，那是作者的正常流程/判负逻辑。
`_scan_mall_wipes.py` 必须复核：处理后该章"福利形态"应为 0。

**2026-10-14 全战役扫描结果**（25 章）：`ransao015.w3m`（`URIZZ4`）、
`ransao022.w3m`（`XHLLL7`）命中；`ransao02.w3x` 的 `00S0M06` 已被坑五关掉；
其余 22 章 0 命中。已就地改这两章并部署（备份
`H:\Games\War3\Campaigns\_备份_燃烧之怒_20261014_2355.w3n.bak`），
校验：`pjass` rc=0、25/25 章 `open-as-archive: OK`、内层 `war3map.j` 用游戏自带
Storm.dll 读回一致。

> 屏幕上的 `[IBDIAG] wipe helper run: <函数名>` 是 `_diag.py` 打的诊断（每删一个单位打一行，
> 所以"同一个函数名刷十几行"= 一次清场删了十几个单位）。元凶找到后，把 `_camp_build.py`
> 里的 `DIAG.patch` 去掉重跑即可，不必再带诊断。
