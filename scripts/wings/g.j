//============================================================================
// WINGS / MOUNT SYSTEM - 全局变量
// 翅膀: 物品(技能挂模型) —— `wing <名称>` 添加
// 坐骑: 蛋物品 —— 使用后创建坐骑单位(英雄骑在上面, 英雄不隐藏) + 蛋变"取消骑乘"物品
//============================================================================

// --- 坐骑蛋 -> (坐骑单位类型, 取消骑乘物品) ---
integer array wg_eggItem          // 蛋物品 ID
integer array wg_eggUnit          // 蛋对应的坐骑单位类型 ID
integer array wg_eggOffItem       // 使用后变成的"取消骑乘"物品 ID
string array wg_eggName           // 坐骑名称
real array wg_eggHeight           // 坐骑单位飞行高度 (让英雄骑在背上)
real array wg_eggHeroHeight       // 英雄飞行高度 (骑乘时抬高)
real array wg_eggScale            // 坐骑单位缩放 (SetUnitScale, 同伏魔战记)
integer wg_eggCount = 0

// 玩家当前坐骑单位
unit array wg_playerMount
// 玩家骑乘时记下的英雄句柄 (同步循环用它, 不再每帧重新查找)
//   WG_GetHero 会优先返回"当前选中单位", 玩家一换选择/换英雄就会变,
//   会导致坐骑瞬移到别的英雄、甚至误判"英雄死亡"而把坐骑卸掉。
unit array wg_rideHero
// 玩家当前坐骑的蛋索引 (缓存, 避免同步时每帧线性查找)
integer array wg_mountIdx
// 玩家是否骑乘中
boolean array wg_isRiding
// 坐骑召唤冷却 (游戏时间戳, 每玩家)
real array wg_summonCd
// 坐骑召唤物 (每玩家最多 2 只, 超出移除最旧的 -> "先知狼"行为)
unit array wg_summon1
unit array wg_summon2
// 召唤物存活时间(秒)。0 = 不自动消失(默认), 改成 20.0 即恢复伏魔战记的定时消失
real wg_summonLife = 0.0

// --- 坐骑自愈 / 诊断 ---
// 坐骑是否死于"死亡事件"(区分"被击杀"与"被引擎替换/移除")
boolean array wg_mountDied
// 单位死亡事件触发器 (坐骑 + 召唤物都注册进来)
trigger wg_deathTrig = null
// 自愈次数 (用于限制提示刷屏)
integer array wg_mountHealCount

// --- 骑乘高度 ---
// 伏魔战记原值: 坐骑 260, 英雄 240/250(红龙)/270(凤凰)。
// 本工程整体下调 50% (玩家反馈坐骑飞太高, 英雄的脚印都悬在天上),
// 2026-10-10 又按玩家要求上调 20%:
//   坐骑 156 (130*1.2), 英雄 144 (120*1.2) / 红龙 149 / 凤凰 159。
// 两段高度都由 WG_MountSync 每帧重设, 所以英雄位置是动态跟上的。
real WG_MOUNT_H = 156.0
real WG_HERO_H = 144.0

// --- 翅膀附带效果表 (移植到别的图只改这张表) ---
//   物品技能列表有 4 个上限(超出不生效), 所以物品里只放 主动+加速+模型;
//   光环/被动装在"隐藏魔法书"里, 由脚本按需加到英雄身上并隐藏 ——
//   既生效, 又**不占英雄技能栏**。
integer array wg_wingItem        // 翅膀物品 ID
integer array wg_wingBook        // 对应的隐藏魔法书技能 ID
// 第二本隐藏魔法书 (0 = 没有)。
//   ⚠ 一本魔法书实测只有**前 3 个**技能会真正挂到单位上(玩家实测: 重生被排到第 4 个就失效),
//     所以炽天使之翼的重生单独放第二本小书里, 两本都 ≤3 个。
integer array wg_wingBook2
integer wg_wingCount = 0


// --- 注册计时器 ---
timer wg_regTimer = null
// 游戏时间基准计时器 (用于召唤冷却计时)
timer wg_gameTimer = null

// 重生(炽天使之翼 I101)没有脚本实现: 完全交给隐藏魔法书 W081 里的原版 AOre
//   (曾加过"脚本兜底复活", 但与原版重生叠加成"连续复活两次", 已删除)。
