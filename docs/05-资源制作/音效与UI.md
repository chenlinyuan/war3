# 音效与 UI

## 一、音效（Sound）

### 1.1 格式

| 格式 | 说明 | 用途 |
| --- | --- | --- |
| `.wav` | 未压缩 PCM | 短音效 |
| `.mp3` | 压缩 | 音乐、长音效 |

### 1.2 声音类型

| 类型 | 说明 |
| --- | --- |
| 2D 声音 | 不随距离衰减 |
| 3D 声音 | 随距离衰减 |
| 循环声音 | 循环播放 |
| 环境声音 | 区域环境音 |

### 1.3 声音编辑器

**模块 → 声音编辑器**（F5）：

| 字段 | 说明 |
| --- | --- |
| 变量名 | 声音变量名（`gg_snd_xxx`） |
| 声音文件 | 文件路径 |
| 音量 | 0-127 |
| 音调 | 播放速度/音高 |
| 3D 声音 | 是否 3D |
| 循环 | 是否循环 |
| 最小距离 | 3D 最小距离 |
| 最大距离 | 3D 最大距离 |
| 衰减 | 衰减模型 |
| 淡入率 | 淡入速度 |
| 淡出率 | 淡出速度 |

### 1.4 脚本播放声音

```lua
-- 创建声音
local snd = CreateSound("war3mapImported\\mysound.wav", false, false, false, 12700, 12700, "")

-- 播放
StartSound(snd)
PlaySound(snd)

-- 停止
StopSound(snd, true, false)

-- 销毁
DestroySound(snd)
```

### 1.5 播放音乐

```lua
PlayMusic("war3mapImported\\mymusic.mp3")
StopMusic(true)
SetMusicVolume(100)
PlayThematicMusic("war3mapImported\\theme.mp3")
EndThematicMusic()
```

### 1.6 单位音效集

单位音效通过 **Sound Set** 组织，定义在 `Units\UnitAckSounds.slk` 等文件中。

| 音效类型 | 说明 |
| --- | --- |
| What | 选中时 |
| Yes | 接受命令 |
| YesAttack | 攻击命令 |
| Attack | 攻击时 |
| Death | 死亡 |
| Pissed | 连续点击 |

### 1.7 音效路径

```
Sound\Units\Human\Footman\FootmanWhat1.wav
Sound\Buildings\...
Sound\Abilities\...
Sound\Interface\...
Music\...
```

## 二、UI 定制

### 2.1 UI 文件类型

| 文件 | 说明 |
| --- | --- |
| `.fdf` | 框架定义文件 |
| `.toc` | 表目录（加载列表） |
| `.blp` | UI 贴图 |
| `.mdx` | UI 模型 |

### 2.2 框架定义（FDF）

FDF 是文本格式，定义 UI 元素：

```
// 简单背景
Frame "BACKDROP" "MyBackdrop" {
    Width 0.2,
    Height 0.1,
    BackdropBlendAll,
    Texture "MyTexture.blp",
    BackdropTileBackground,
}

// 文本
Frame "TEXT" "MyText" {
    Font "MasterFont",
    FontSize 0.012,
    Text "Hello",
}
```

### 2.3 TOC 文件

TOC 列出要加载的 FDF 文件：

```
MyUI.fdf
MyFrames.fdf
```

### 2.4 加载自定义 UI

```lua
-- 加载 TOC
BlzLoadTOCFile("war3mapImported\\MyUI.toc")

-- 创建框架
local frame = BlzCreateFrame("MyBackdrop", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
BlzFrameSetSize(frame, 0.2, 0.1)
BlzFrameSetAbsPoint(frame, FRAMEPOINT_CENTER, 0.4, 0.3)
BlzFrameSetVisible(frame, true)
```

### 2.5 Frame API 常用函数

| 函数 | 说明 |
| --- | --- |
| `BlzCreateFrame` | 创建框架 |
| `BlzCreateSimpleFrame` | 创建简单框架 |
| `BlzDestroyFrame` | 销毁框架 |
| `BlzFrameSetSize` | 设置大小 |
| `BlzFrameSetPoint` | 设置相对位置 |
| `BlzFrameSetAbsPoint` | 设置绝对位置 |
| `BlzFrameClearAllPoints` | 清除所有锚点 |
| `BlzFrameSetVisible` | 设置可见 |
| `BlzFrameSetText` | 设置文本 |
| `BlzFrameGetText` | 获取文本 |
| `BlzFrameSetTexture` | 设置贴图 |
| `BlzFrameSetAlpha` | 设置透明度 |
| `BlzFrameSetScale` | 设置缩放 |
| `BlzFrameSetEnable` | 设置启用 |
| `BlzFrameSetTooltip` | 设置提示 |
| `BlzFrameSetParent` | 设置父框架 |
| `BlzFrameSetLevel` | 设置层级 |
| `BlzFrameSetFont` | 设置字体 |
| `BlzFrameSetTextColor` | 设置文本颜色 |
| `BlzFrameSetTextAlignment` | 设置对齐 |
| `BlzFrameClick` | 模拟点击 |
| `BlzFrameSetFocus` | 设置焦点 |
| `BlzFrameSetModel` | 设置模型 |
| `BlzFrameSetSpriteAnimate` | 精灵动画 |
| `BlzFrameSetValue` | 设置值 |
| `BlzFrameSetMinMaxValue` | 设置值范围 |
| `BlzFrameSetStepSize` | 设置步长 |
| `BlzGetOriginFrame` | 获取原始框架 |
| `BlzGetFrameByName` | 按名称获取框架 |
| `BlzGetFrameByName` | 按名称获取 |
| `BlzFrameGetChildrenCount` | 子框架数 |
| `BlzFrameGetChild` | 获取子框架 |
| `BlzTriggerRegisterFrameEvent` | 注册框架事件 |
| `BlzGetTriggerFrame` | 触发框架 |
| `BlzGetTriggerFrameEvent` | 触发框架事件 |
| `BlzGetTriggerFrameValue` | 触发框架值 |
| `BlzGetTriggerFrameText` | 触发框架文本 |
| `BlzHideOriginFrames` | 隐藏原始框架 |
| `BlzEnableUIAutoPosition` | 启用自动定位 |
| `BlzFrameSetTextSizeLimit` | 文本长度限制 |
| `BlzConvertColor` | 颜色转换 |

### 2.6 原始框架类型（Origin Frame）

| 常量 | 说明 |
| --- | --- |
| `ORIGIN_FRAME_GAME_UI` | 游戏 UI |
| `ORIGIN_FRAME_COMMAND_BUTTON` | 命令按钮 |
| `ORIGIN_FRAME_HERO_BAR` | 英雄栏 |
| `ORIGIN_FRAME_HERO_BUTTON` | 英雄按钮 |
| `ORIGIN_FRAME_HERO_HP_BAR` | 英雄血条 |
| `ORIGIN_FRAME_HERO_MANA_BAR` | 英雄魔法条 |
| `ORIGIN_FRAME_HERO_BUTTON_INDICATOR` | 英雄按钮指示器 |
| `ORIGIN_FRAME_ITEM_BUTTON` | 物品按钮 |
| `ORIGIN_FRAME_MINIMAP` | 小地图 |
| `ORIGIN_FRAME_MINIMAP_BUTTON` | 小地图按钮 |
| `ORIGIN_FRAME_SYSTEM_BUTTON` | 系统按钮 |
| `ORIGIN_FRAME_TOOLTIP` | 提示 |
| `ORIGIN_FRAME_UBERTOOLTIP` | 超级提示 |
| `ORIGIN_FRAME_CHAT_MSG` | 聊天消息 |
| `ORIGIN_FRAME_UNIT_MSG` | 单位消息 |
| `ORIGIN_FRAME_TOP_MSG` | 顶部消息 |
| `ORIGIN_FRAME_PORTRAIT` | 头像 |
| `ORIGIN_FRAME_WORLD_FRAME` | 世界框架 |
| `ORIGIN_FRAME_SIMPLE_UI_PARENT` | 简单 UI 父级 |
| `ORIGIN_FRAME_PORTRAIT_HP_TEXT` | 头像血条文字 |
| `ORIGIN_FRAME_PORTRAIT_MANA_TEXT` | 头像魔法文字 |
| `ORIGIN_FRAME_UNIT_PANEL_BUFF_BAR` | 单位面板增益栏 |
| `ORIGIN_FRAME_UNIT_PANEL_BUFF_BAR_LABEL` | 增益栏标签 |

### 2.7 框架点（Frame Point）

| 常量 | 说明 |
| --- | --- |
| `FRAMEPOINT_TOPLEFT` | 左上 |
| `FRAMEPOINT_TOP` | 上 |
| `FRAMEPOINT_TOPRIGHT` | 右上 |
| `FRAMEPOINT_LEFT` | 左 |
| `FRAMEPOINT_CENTER` | 中心 |
| `FRAMEPOINT_RIGHT` | 右 |
| `FRAMEPOINT_BOTTOMLEFT` | 左下 |
| `FRAMEPOINT_BOTTOM` | 下 |
| `FRAMEPOINT_BOTTOMRIGHT` | 右下 |

### 2.8 框架事件类型

| 常量 | 说明 |
| --- | --- |
| `FRAMEEVENT_CONTROL_CLICK` | 点击 |
| `FRAMEEVENT_MOUSE_ENTER` | 鼠标进入 |
| `FRAMEEVENT_MOUSE_LEAVE` | 鼠标离开 |
| `FRAMEEVENT_MOUSE_UP` | 鼠标抬起 |
| `FRAMEEVENT_MOUSE_DOWN` | 鼠标按下 |
| `FRAMEEVENT_MOUSE_WHEEL` | 滚轮 |
| `FRAMEEVENT_CHECKBOX_CHECKED` | 复选框选中 |
| `FRAMEEVENT_CHECKBOX_UNCHECKED` | 复选框取消 |
| `FRAMEEVENT_EDITBOX_TEXT_CHANGED` | 编辑框文本改变 |
| `FRAMEEVENT_POPUPMENU_ITEM_CHANGED` | 弹出菜单项改变 |
| `FRAMEEVENT_SLIDER_VALUE_CHANGED` | 滑块值改变 |
| `FRAMEEVENT_DIALOG_CANCEL` | 对话框取消 |
| `FRAMEEVENT_DIALOG_ACCEPT` | 对话框接受 |
| `FRAMEEVENT_EDITBOX_ENTER` | 编辑框回车 |

## 三、多面板与排行榜

### 3.1 多面板（Multiboard）

```lua
local mb = CreateMultiboard()
MultiboardSetColumnCount(mb, 3)
MultiboardSetRowCount(mb, 5)
MultiboardSetTitleText(mb, "计分板")
MultiboardSetItemValue(MultiboardGetItem(mb, 0, 0), "玩家")
MultiboardDisplay(mb, true)
```

### 3.2 排行榜（Leaderboard）

```lua
local lb = CreateLeaderboard()
LeaderboardSetLabel(lb, "击杀数")
LeaderboardAddItem(lb, GetPlayerName(Player(0)), 0, Player(0))
LeaderboardDisplay(lb, true)
```

### 3.3 计时器对话框

```lua
local t = CreateTimer()
local td = CreateTimerDialog(t)
TimerDialogSetTitle(td, "剩余时间")
TimerDialogDisplay(td, true)
TimerStart(t, 60.0, false, null)
```

## 参考

- Hive Workshop UI 教程：https://www.hiveworkshop.com/forums/
- Tasyen 的 UI 教程：https://www.hiveworkshop.com/threads/the-big-ui-frame-tutorial.316610/
- JassDoc Frame API：https://github.com/lep/jassdoc
