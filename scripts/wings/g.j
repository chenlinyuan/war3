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

// --- 骑手槽位: **按英雄**记坐骑状态, 不是按玩家 ---
//   ⚠ 以前这些状态是"每玩家一份"(`wg_playerMount[pid]` ...)。战役里一个玩家常常
//     同时控制多个英雄（主角 + 副英雄/宠物），于是第二个英雄一用坐骑蛋就被判
//     "你已经在骑乘中"，两边互相顶掉。现在**每个骑乘中的英雄各占一个槽位**。
//   槽位映射: `wg_slotTable` (GetHandleId(英雄) -> 槽位+1)，槽位占用标记 = (槽位, 1)。
integer WG_MAX_RIDERS = 12
unit array wg_riderHero          // 槽位 -> 英雄
unit array wg_riderMount         // 槽位 -> 坐骑单位
integer array wg_riderEgg        // 槽位 -> 蛋索引 (-1 = 没在骑)
boolean array wg_riderRiding     // 槽位 -> 是否骑乘中
real array wg_riderCd            // 槽位 -> 召唤冷却(游戏时间戳)
unit array wg_riderSum1          // 槽位 -> 召唤物 1
unit array wg_riderSum2          // 槽位 -> 召唤物 2
hashtable wg_slotTable = null
// --- 召唤小龙的参数 ---
//   ⚠ 下面这段由 tools/war3map-injector/gen_jass_tables.py 从 wings_config.py 生成
//      （summon_count / summon_cd / summon_life）。**战役里把 summon_count 设 0 就关掉召唤。**
// >>> GENERATED:BEGIN g_summon (wings_config.py) >>>
// 每次英雄攻击最多召唤几只小龙（0 = 关掉召唤）
integer WG_SUMMON_COUNT = 0
// 召唤冷却（秒）
real WG_SUMMON_CD = 15.0
// 召唤物存活时间（秒）；0 = 不自动消失，只在下次召唤/卸下时替换
real wg_summonLife = 0.0
// >>> GENERATED:END g_summon <<<

// --- 坐骑自愈 / 诊断 (按槽位) ---
// 坐骑是否死于"死亡事件"(区分"被击杀"与"被引擎替换/移除")
boolean array wg_riderDied
// 单位死亡事件触发器 (坐骑 + 召唤物都注册进来)
trigger wg_deathTrig = null
// 自愈次数 (用于限制提示刷屏)
integer array wg_riderHeal

// --- 骑乘高度 ---
// 下面这两行由 tools/war3map-injector/gen_jass_tables.py 从 wings_config.py 生成，
// 改数值请改配置文件（或直接跑 build_wings.py 重新生成），不要手改生成段。
// 两段高度都由 WG_MountSync 每帧重设，所以英雄位置是动态跟上的。
// >>> GENERATED:BEGIN g_heights (wings_config.py) >>>
real WG_MOUNT_H = 156.0
real WG_HERO_H = 144.0
// >>> GENERATED:END g_heights <<<

// --- 阿克蒙德之手 / 掠夺（脚本被动）---
//   掠夺 = **击杀**敌方单位时按目标等级掠夺金币（数值与判定照抄《西方世界的劫难6》）：
//     非英雄 (base + 等级*per_lv + 随机*rand) / div；英雄另有 hero_* 三个数。
//   全部数值来自配置：plunder_enable（0 = 关掉）、plunder_min_hp（生命门槛）等。
// >>> GENERATED:BEGIN g_hand (wings_config.py) >>>
// 阿克蒙德之手的物品 ID（掠夺挂在它身上）
// 1 = equipment skills are owned by the item; 0 = hero command card.
boolean WG_ITEM_ACTIVE = false
integer WG_HAND_ITEM = 'I103'
// 掠夺总开关（0 = 关掉这个被动）
integer WG_PLUNDER_ENABLE = 1
// 只掠夺最大生命 >= 这个值的单位（0 = 不限）
real WG_PLUNDER_MIN_HP = 300.0
// 非英雄：基础值 / 每级 / 随机系数
integer WG_PLUNDER_BASE = 15
integer WG_PLUNDER_PER_LV = 2
integer WG_PLUNDER_RAND = 2
// 英雄：基础值 / 每级 / 随机系数
integer WG_PLUNDER_HERO_BASE = 150
integer WG_PLUNDER_HERO_PER_LV = 10
integer WG_PLUNDER_HERO_RAND = 5
// 最后除以这个数（照抄原图的 /3）
integer WG_PLUNDER_DIV = 3
// 夺魂：1 = 死亡之指击杀英雄/强敌时永久增加 1 点智力
integer WG_HAND_SOUL_GAIN = 1
integer WG_HAND_SOUL_HERO_CHANCE = 100
integer WG_HAND_SOUL_ELITE_CHANCE = 25
integer WG_HAND_SOUL_MIN_LEVEL = 8
real WG_HAND_SOUL_MIN_HP = 2000.0
// --- 死亡之指（阿克蒙德之手的主动）---
integer WG_FINGER_ABILITY = 'A100'
// 对英雄/非英雄的伤害倍率（非英雄=翻倍）
real WG_FINGER_HERO_MULT = 25.0
real WG_FINGER_OTHER_MULT = 50.0
// 冷却/耗魔分档：最高属性每 WG_FINGER_STEP 点升一档，最多 WG_FINGER_MAXLVL 档
integer WG_FINGER_STEP = 25
integer WG_FINGER_MAXLVL = 7
// Cooldown formula for the item-owned Death Finger instance.
real WG_FINGER_CD_BASE = 12.0
real WG_FINGER_CD_DIV = 25.0
real WG_FINGER_CD_MIN = 6.0
// 施法时画的闪电（原图技能 alig = AFOD）
string WG_FINGER_LIGHTNING = "AFOD"
// 耗魔公式（点错目标时按当前档退魔）
integer WG_FINGER_MANA_BASE = 100
real WG_FINGER_MANA_DIV = 2.0
integer WG_FINGER_MANA_MIN = 40
integer WG_FINGER_SCRIPT_BOLT = 0
// >>> GENERATED:END g_hand <<<
// （掠夺不再需要冷却表：它是击杀制，天然按"战果"限流）

// --- 星魂之力的主动「灰烬雷暴」（照抄 194213 里阿克蒙德的 A6V0）---
//   技能本体是自带的「通道(Channel)」假技能（ANcl），一点原生效果都没有：
//   伤害/回血/减速/二阶全在脚本里演（f.j 的 WG_OnAshFall）。
//   主属性取法 WG_ASH_STAT：0 = 佩戴者的**最高属性**（含装备加成）、1/2/3 = 力量/敏捷/智力。
// >>> GENERATED:BEGIN g_starfall (wings_config.py) >>>
// 灰烬雷暴（星魂之力的主动）：技能 ID / 马甲技能与马甲单位 / 数值 / 主属性取法
integer WG_ASH_ABILITY = 'W089'
integer WG_ASH_THUNDER = 'W092'
integer WG_ASH_ROCKETS = 'W093'
integer WG_ASH_DUMMY_THUNDER = 'n100'
integer WG_ASH_DUMMY_ROCKETS = 'n101'
// 一阶：AoE 伤害 / 属性倍率 / 半径 / 雷击环半径 / 自身回血
integer WG_ASH_DAMAGE = 200
real WG_ASH_STAT_MULT = 4.0
real WG_ASH_RADIUS = 500.0
real WG_ASH_RING = 300.0
integer WG_ASH_HEAL = 200
real WG_ASH_HEAL_MULT = 4.0
// 二阶：每次落点伤害 / 次数 / 间隔 / 进入二阶的等待时间
integer WG_ASH_WAVE_DAMAGE = 200
real WG_ASH_WAVE_MULT = 1.0
integer WG_ASH_WAVE_COUNT = 3
real WG_ASH_WAVE_INT = 0.5
real WG_ASH_COMBO = 1.0
// 观感：屏幕震动强度 / 两个特效模型
real WG_ASH_SHAKE = 3.0
string WG_ASH_FX = "StormfallRed.mdx"
string WG_ASH_FX_CASTER = "ssw1.mdx"
// 主属性取法：0 = 最高属性（含加成）；1/2/3 = 力量/敏捷/智力
integer WG_ASH_STAT = 0
// >>> GENERATED:END g_starfall <<<
// >>> GENERATED:BEGIN g_aura_runtime (wings_config.py) >>>
integer WG_FALLEN_ITEM = 'I100'
integer WG_TELEPORT_ABILITY = 'W023'
real WG_VAMP_RADIUS = 700.0
real WG_VAMP_PERCENT = 0.4
real WG_TELEPORT_RADIUS = 700.0
// >>> GENERATED:END g_aura_runtime <<<
// 灰烬雷暴用的表（键都是句柄 id，天然支持多人同时放）：
//   [计时器 id] -> [0]=单位, [1]=x, [2]=y, [3]=剩余次数（二阶落雷排程）
//                  [4]=玩家（"一阶→二阶"的排程与屏幕震动清除用）
hashtable wg_ashTable = null

// 死亡之指诊断用：最近一次施法读到的目标名 / 距离 / 两端坐标（`wginfo` 里会打出来）
string wg_fingerLastTarget = "-"
real wg_fingerLastDist = 0.0
real wg_fingerLastX1 = 0.0
real wg_fingerLastY1 = 0.0
real wg_fingerLastX2 = 0.0
real wg_fingerLastY2 = 0.0
real wg_fingerLastTX = 0.0
real wg_fingerLastTY = 0.0
hashtable wg_handCooldownTable = null

// --- 翅膀附带效果表 (移植到别的图只改这张表) ---
//   物品技能列表有 4 个上限(超出不生效), 所以物品里只放 主动+加速+模型;
//   光环/被动装在"隐藏魔法书"里, 由脚本按需加到英雄身上并隐藏 ——
//   既生效, 又**不占英雄技能栏**。
integer array wg_wingItem        // 翅膀物品 ID
integer array wg_wingBook        // 对应的隐藏魔法书技能 ID
string array wg_wingName         // 翅膀名字（诊断命令 wghp 打印用）
// 第二本隐藏魔法书 (0 = 没有)。
//   ⚠ 一本魔法书实测只有**前 3 个**技能会真正挂到单位上(玩家实测: 重生被排到第 4 个就失效),
//     所以炽天使之翼的重生单独放第二本小书里, 两本都 ≤3 个。
integer array wg_wingBook2
integer wg_wingCount = 0


// --- 注册计时器 ---
timer wg_regTimer = null
// 游戏时间基准计时器 (用于召唤冷却计时)
timer wg_gameTimer = null

// --- 回血量实测 (wghp 命令) ---
real array wg_hpBase
real array wg_hpTime

// 重生(炽天使之翼 I101)没有脚本实现: 完全交给隐藏魔法书 W081 里的原版 AOre
//   (曾加过"脚本兜底复活", 但与原版重生叠加成"连续复活两次", 已删除)。
