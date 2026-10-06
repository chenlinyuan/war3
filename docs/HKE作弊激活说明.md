# HKE 作弊系统激活与功能说明

> 分析自 `火影忍者羁绊6.8.w3x`（该图已被 HKE 注入过，含 196 个 `hke_*` 函数）。
> 适用于任何由 **HkeW3mModifier** 注入过作弊系统的地图。

## 一、激活方法

**在游戏聊天框输入：**

```
woshanwang
```

- 精确匹配（`exactMatchOnly=true`），必须完全一致
- 任何玩家输入都有效
- 激活后自动弹出**作弊菜单对话框**

### 原理（JASS 代码）

```jass
// 初始化：为 12 个玩家注册激活触发器
set HKE_Yj = CreateTrigger()
loop (HKE_yJ = 0..11)
    call TriggerRegisterPlayerChatEvent(HKE_Yj, Player(HKE_yJ), "woshanwang", true)
endloop
call TriggerAddAction(HKE_Yj, function YJYJ)

// 激活函数
function YJYJ takes nothing returns nothing
    set hke_z05 = GetTriggerPlayer()
    set hke_z15 = GetPlayerId(hke_z05)
    call hke_z37()          // 重置所有玩家
    set hke_z4 = true       // ★ 作弊总开关
    set hke_z5 = hke_z05    // ★ 设为管理员玩家
    call hke_z57(...)       // 启用触发器 + 弹出作弊菜单
endfunction
```

- `hke_z4` = 作弊总开关（默认 `false`，激活后 `true`）
- `hke_z5` = 管理员玩家
- `hke_z6[playerId]` = 该玩家是否启用作弊

## 二、作弊菜单功能

激活后弹出的对话框（`hke_Zz3`）包含以下功能：

### 主菜单
资源菜单[A] / 自动化设置[B] / 选定单位特殊属性[C] / 个人选项设置[D] /
帮助菜单[E] / 其他玩家作弊管理[F] / 其他玩家管理[G] / 游戏作弊选项[H] /
关闭录像[L] / 退出菜单[X]

### 资源菜单
自动加钱 / 自动加木头 / 自动清人口 / 自动清CD / 英雄无限重生 / 魔法释放后自动MP

### 单位作弊
无敌 / 永久隐形 / 穿越物体 / 魔免 / 反隐形 / 移动速度 / 各种光环 / 秒杀模式

### 攻击特效
永久献祭 / 闪避 / 重击 / 致命一击 / 反弹(小强的壳) / 分裂攻击 / 燃灰 /
减少魔法伤害33% / 闪避100%

### 光环
辉煌 / 荆棘 / 耐久 / 强击 / 邪恶 / 吸血 / 专注 / 命令(战鼓) / 医疗 / 减速光环 / 关所有光环

### 作弊操作
升100级 / 加三围 / 复制物品 / 复制单位 / 掉身上物品 / 共享该单位视野 /
特殊属性菜单 / 控制它 / 改变单位所有者 / 操作所有单位 / 设置背包数 /
保护CheatMaster / 瞬间造兵不占用人口 / 他人秒杀模式 / 禁止秒杀建筑 /
他人占据单位 / 禁止克隆操作农民

### 玩家管理
资源管理 / 同盟管理 / 向他收税黄金 / 停止收黄金 / 向他收税木材 / 停止收木材 /
复活死亡英雄 / 人口清5 / 总人口100

### 其他
键盘帮助 / CMD帮助 / CMD单位类帮助 / 显示玩家信息 / 显示设置信息 /
删除我的复制单位 / 克隆操作 / 组队克隆操作 / 隐藏加攻 / 隐藏加攻带溅射 / 远程沉默

## 三、聊天作弊命令（拼音缩写）

`hke_Z22Z` 函数处理以下命令（聊天框直接输入）：

```
mm, xj, zj, zm, ft, xx, sb, yx, rh, fl, bs, jg, jf, js, jm, jj, fy,
ghh, ghj, gqj, gxx, gzz, gxe, gjj, gml, gyl, gjs,
qhy, qdy, qlh, qyz, qbd, qfs, qsd, qjs, qha
```

## 四、注意事项

1. **`woshanwang` 激活是无条件的** —— 不需要密钥（HKE 的"152 字符密钥"激活逻辑因 `hke_Z0z` 只有 70 字节而永不触发，属于残留代码）。
2. **该图已被 HKE 注入**：脚本含 196 个 `hke_*` 函数，`main` 里调用 `hke_z09Z()`。
3. **脚本体积**：6.8 的 `war3map.j` 达 3.58MB，**无法再注入其他系统**（如装备浏览器），因为加上新代码后超过 War3 1.27 的脚本执行上限（约 3MB）。6.9 的 2.81MB 可以注入。
4. **HKE 也注册了聊天事件**（`"-"` 前缀等），可能与自定义命令冲突。
