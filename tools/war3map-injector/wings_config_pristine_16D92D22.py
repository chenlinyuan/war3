"""翅膀 / 坐骑系统 —— **唯一的配置源**（移植到新图只改这个文件）。

谁读它：
  * gen_wing.py        —— 技能 (w3a) 的 ID
  * gen_wing_item.py   —— 物品 (w3t) 的 ID
  * gen_w3u.py         —— 坐骑单位 (w3u) 的 ID 与数值
  * gen_w3h.py         —— buff (w3h) 的 ID
  * gen_jass_tables.py —— 生成 scripts/wings 里的"表"（生成的段落不要手改）

移植流程：
    python pick_ids.py <目标图> --write     # 扫目标图已用 ID -> 自动挑空闲 ID 写回本文件
    python build_wings.py                   # 生成对象数据 + JASS 表
    python validate_dir.py scripts/wings    # pjass 校验
    python rebuild_wings.py                 # 注入 + 部署（或改用 port_wings.py）

⚠ 注意：下面这些 4 字符 ID 只要"目标图里没被占用"就行；全部集中在这里，
   用 pick_ids.py 可以自动避让，不要再把 ID 散写到生成器或脚本里。
"""

# ---------------------------------------------------------------------------
# 1) 技能 ID（w3a）
# ---------------------------------------------------------------------------
ABIL = {
    # 翅膀模型（挂在物品 iabi 里，把翅膀模型贴到英雄 chest 上）
    "wing_model_fallen": "W000",
    "wing_model_seraph": "W020",
    "wing_model_demon": "W021",
    # 基础加速（三件共用）
    "wing_speed": "W002",
    # 隐藏魔法书
    "book_fallen": "W080",
    "book_seraph": "W081",
    "book_seraph2": "W084",     # 第二本小书（只放重生，避开"一本最多 3 个"的上限）
    "book_demon": "W082",
    # 书里的光环 / 被动
    "aura_unholy": "W070",      # 邪恶光环：移速 +20%、回血 +30
    "aura_vamp": "W071",        # 吸血 +40%
    "evasion": "W072",          # 闪避 30%
    "aura_brill": "W073",       # 辉煌光环：魔回 ×3
    "aura_heal": "W074",        # 治疗光环：每秒按最大生命 3%（Aoar，真正回血）
    "rebirth": "W075",          # 重生（AOre）
    "aura_command": "W076",     # 命令光环：攻击力 +50%
    "aura_endur": "W077",       # 耐久光环：攻速 +40%
    "crit": "W078",             # 致命一击 35% ×3
    "aura_show": "W079",        # 展示专用光环（数值 0，只为挂状态栏图标）
    # 主动技能（放在物品 iabi 的第一位，物品图标才会显示冷却转圈）
    "act_invul": "W022",        # 暗影庇护：6 秒无敌
    "act_tele": "W023",         # 群体传送
    "act_blink": "W024",        # 闪烁
    # 「试穿」专用（只挂模型 + 移速，没有光环/被动/主动）
    "wing_model_awing": "W030",
    "wing_model_angel": "W031",
    "wing_model_fairy": "W032",
    "wing_model_ewing": "W033",
    "wing_model_demon2": "W034",
    "wing_speed_test": "W035",
    # 「装备挂件」演示（挂在原版物品 / 试穿物品上，用来给装备加外观）
    "art_helmet": "W036",
    "art_shield": "W037",
    "art_equipfx": "W038",
    # 坐骑：模型挂载技能（放在"骑乘中物品"的 iabi）
    "mount_model_phoenix": "W040",
    "mount_model_blue": "W041",
    "mount_model_black": "W042",
    "mount_model_red": "W043",
    # 坐骑：蛋的使用技能（放在"蛋"的 iabi，可点击）
    "egg_use_phoenix": "W060",
    "egg_use_blue": "W061",
    "egg_use_black": "W062",
    "egg_use_red": "W063",
    "egg_use_bronze": "W064",
    # 取消骑乘（备用；现方案里蛋本身是开关）
    "dismount": "W050",
}

# ---------------------------------------------------------------------------
# 2) 物品 ID（w3t）
# ---------------------------------------------------------------------------
ITEMS = {
    "wing_fallen": "I100",
    "wing_seraph": "I101",
    "wing_demon": "I102",
    "egg_phoenix": "I110",
    "egg_blue": "I111",
    "egg_black": "I112",
    "egg_red": "I113",
    "egg_bronze": "I114",
    # 取消骑乘物品（现方案里被"蛋当开关"取代，仅保留定义）
    "off_phoenix": "I120",
    "off_blue": "I121",
    "off_black": "I122",
    "off_red": "I123",
    "off_bronze": "I124",
    # 「试穿」用品（挑翅膀模型用，只有模型 + 移速）
    "wing_test_awing": "I130",
    "wing_test_angel": "I131",
    "wing_test_fairy": "I132",
    "wing_test_ewing": "I133",
    "wing_test_demon2": "I134",
    # 「装备挂件」试穿用品（只挂模型）
    "demo_helmet": "I140",
    "demo_shield": "I141",
    "demo_equipfx": "I142",
}

# ---------------------------------------------------------------------------
# 3) buff ID（w3h 覆盖用）
# ---------------------------------------------------------------------------
BUFFS = {
    # 阿克蒙德之手那件装备的光环 buff（原版强击光环 buff）—— 改名的对象
    "akmond": "B100",
    # 治疗光环的"展示"光环使用的 buff（本图没人用的原版 buff：黑曜石雕像的枯萎再生）
    "heal_show": "Babr",
}

# ---------------------------------------------------------------------------
# 3b) 阿克蒙德之手（战役装备：物品 + 4 个技能）
# ---------------------------------------------------------------------------
#   物品：+50% 攻击力光环 / +100% 攻击速度 / 主动"死亡之指"（秒杀）
#   数据本身是从战役地图提取的模板（`_hand.w3t` / `_lt_hand.w3a`），
#   这里只声明它用掉的 ID —— 换图时 `pick_ids.py` 会自动换成空闲的
#   （实测：侏罗纪公园1.5 里 I000 是"瓦斯"、A000/A001/A002 都被占）。
HAND = {
    "item": "I103",     # 物品
    "finger": "A100",   # 死亡之指（主动技能，也当物品冷却组 icid）
    "aura": "A101",     # 阿克蒙德之力（AIar 强击光环）
    "speed": "A102",    # 攻击速度加成（AIsx）
    "crit": "Azcr",     # 致命一击（物品浏览器 criton 用的图标技能）
}
# 真正回血的 Aoar 自带原版 buff（我们只覆盖它的名称/图标，不改 ID）
BUFF_HEAL_NATIVE = "Boar"

# buff 覆盖时用的统一文案
HEAL_BUFF_TEXT = "持续回复生命：每秒回复最大生命的 3%（自身与 700 范围内友军）。"
AKMOND_BUFF_TEXT = "增加周围友军 50% 攻击力（近战/远程均生效）。"

# ---------------------------------------------------------------------------
# 4) 坐骑单位 ID（w3u）
# ---------------------------------------------------------------------------
UNITS = {
    "phoenix": "n100",
    "blue": "n02N",
    "black": "n02M",
    "red": "n02P",
    "bronze": "n02L",
}

# ---------------------------------------------------------------------------
# 5) 坐骑表（顺序 = 蛋在背包里的顺序，脚本里的 wg_eggItem[0..N-1]）
# ---------------------------------------------------------------------------
# ID 全部用"键名"引用（真正的 4 字符 ID 只在上面 ABIL/ITEMS/UNITS 里写一次）
# 每项字段说明：
#   key/name        内部键 / 中文名（中文名同时用于 `mount <名字>` 命令）
#   item_key/off_key/unit_key   引用 ITEMS / UNITS 里的键
#   base            抄哪个单位（★换图时改 base 就能换坐骑来源）
#   model/sound     模型路径 / 单位音效
#   def_type        护甲类型（large/small…）
#   abil            单位自带技能列表（uabi；空字符串也要写）
#   move_height     移动高度 umvh
#   turn_rate/death_time   转向速率 / 尸体停留
#   usca/ussc       w3u 里的模型缩放字段
#   splash          溅射目标（ua1p）；必须含 enemy，否则会溅到骑手
#   egg_scale       脚本运行时的 SetUnitScale（仅 X 轴）
#   hero_h_off      英雄抬高相对 WG_HERO_H 的偏移（凤凰 +15、红龙 +5）
#   regen_hp        每秒回血（覆盖凤凰自带的 -25，否则凤凰约 50 秒自己掉血死）
MOUNTS = [
    dict(key="phoenix", name="火凤凰", item_key="egg_phoenix", off_key="off_phoenix",
         unit_key="phoenix", base="hphx", color="|cffFF8800",
         model=r"units\human\phoenix\phoenix", sound="Phoenix", def_type="small",
         abil="Apxf", move_height=None, turn_rate=0.4, death_time=0.7,
         usca=1.0, ussc=1.5, egg_scale=0.936, hero_h_off=15.0, hp_regen=2.0),
    dict(key="blue", name="蓝龙", item_key="egg_blue", off_key="off_blue",
         unit_key="blue", base="nadr", color="|cff00CCFF",
         model=r"units\creeps\AzureDragon\AzureDragon", sound="AzureDragon", def_type="large",
         abil="Afrb", move_height=None, turn_rate=0.1, death_time=3.0,
         usca=1.75, ussc=2.25, egg_scale=1.008, hero_h_off=0.0),
    dict(key="black", name="黑龙", item_key="egg_black", off_key="off_black",
         unit_key="black", base="nbwm", color="|cff808080",
         model=r"units\creeps\BlackDragon\BlackDragon", sound="AzureDragon", def_type="large",
         abil="", move_height=None, turn_rate=0.1, death_time=3.0,
         usca=1.75, ussc=2.25, egg_scale=1.008, hero_h_off=0.0),
    dict(key="red", name="红龙", item_key="egg_red", off_key="off_red",
         unit_key="red", base="nrwm", color="|cffFF3333",
         model=r"units\creeps\RedDragon\RedDragon", sound="AzureDragon", def_type="large",
         abil="", move_height=None, turn_rate=0.1, death_time=3.0,
         usca=1.75, ussc=2.25, egg_scale=1.008, hero_h_off=5.0),
    dict(key="bronze", name="青铜龙", item_key="egg_bronze", off_key="off_bronze",
         unit_key="bronze", base="nbzd", color="|cffCD7F32",
         model=r"units\creeps\BronzeDragon\BronzeDragon", sound="AzureDragon", def_type="large",
         abil="Alit", move_height=None, turn_rate=0.1, death_time=3.0,
         usca=1.75, ussc=2.25, egg_scale=1.008, hero_h_off=0.0),
]

# 坐骑单位的公共数值（所有坐骑一样；想按坐骑区分就把对应项写进 MOUNTS 里）
MOUNT_COMMON = dict(
    food=0,                     # ufoo：不占人口
    hp_regen=None,               # uhpr：每秒回血
    speed=300.0,                # umvs（坐骑自己移动时用；跟随英雄时只作参考）
    dmg_base=None,               # ua1b：伤害基数（★按目标图平衡调整）
    atk_type=None,           # ua1t：攻击类型
    splash="ground,structure,debris,air,enemy",   # ua1p
    armor=None,              # uarm
    shadow=None,       # ushu
    regen_type=None,        # uhrt
    race=None,                 # urac
    targets=None,              # utar
    move_type="foot",           # umvt（foot=地面；fly=飞行）
)

# ---------------------------------------------------------------------------
# 5) 翅膀表（顺序 = 脚本里的 wg_wingItem[0..N-1]）
# ---------------------------------------------------------------------------
#   item/book/book2  物品 ID / 隐藏魔法书 / 第二本小书（0 = 没有）
#   model_abil       挂在物品 iabi 上的"模型"技能
#   active           主动技能（必须在 iabi 第一位）
#   iabi             物品技能列表（⚠ 物品最多 4 个，超出的不生效）
#   debug            自检命令 wginfo 里打印"这个技能挂上没挂上"
WINGS = [
    dict(key="fallen", name="堕落天使之翼", short="堕落",
         hotkey="D",
         item_key="wing_fallen", book_key="book_fallen", book2_key=None,
         model_abil_key="wing_model_fallen", active_key="act_invul",
         iabi_keys=["act_invul", "wing_speed", "wing_model_fallen"],
         model=r"WingOfTheLucifer.MDX",
         book_abil_keys=["aura_unholy", "aura_vamp", "evasion"], book2_abil_keys=[]),
    dict(key="seraph", name="炽天使之翼", short="炽天使",
         hotkey="T",
         item_key="wing_seraph", book_key="book_seraph", book2_key="book_seraph2",
         model_abil_key="wing_model_seraph", active_key="act_tele",
         iabi_keys=["act_tele", "wing_speed", "wing_model_seraph"],
         model=r"FWIND.MDX",
         book_abil_keys=["aura_brill", "aura_heal", "aura_show"], book2_abil_keys=["rebirth"]),
    dict(key="demon", name="恶魔之翼", short="恶魔",
         hotkey="B",
         item_key="wing_demon", book_key="book_demon", book2_key=None,
         model_abil_key="wing_model_demon", active_key="act_blink",
         iabi_keys=["act_blink", "wing_speed", "wing_model_demon"],
         model=r"DoomgGuardWings.mdx",
         book_abil_keys=["aura_command", "aura_endur", "crit"], book2_abil_keys=[]),
]


# --- 把"键名"解析成真正的 4 字符 ID（生成器统一读下面这些解析后的字段）---
for _m in MOUNTS:
    _m["egg"] = ITEMS[_m["item_key"]]
    _m["off"] = ITEMS[_m["off_key"]]
    _m["unit"] = UNITS[_m["unit_key"]]
for _w in WINGS:
    _w["item"] = ITEMS[_w["item_key"]]
    _w["book"] = ABIL[_w["book_key"]]
    _w["book2"] = ABIL[_w["book2_key"]] if _w["book2_key"] else 0
    _w["model_abil"] = ABIL[_w["model_abil_key"]]
    _w["active"] = ABIL[_w["active_key"]]
    _w["iabi"] = [ABIL[k] for k in _w["iabi_keys"]]
    _w["book_abils"] = [ABIL[k] for k in _w["book_abil_keys"]]
    _w["book2_abils"] = [ABIL[k] for k in _w["book2_abil_keys"]]

# wginfo 自检命令里用的短标签（技能**键名** -> 中文短名，键名来自 ABIL）。
#   用键名而不是 ID，这样 pick_ids 改 ID 后这里不用动。
LABELS = {
    "aura_unholy": "邪恶", "aura_vamp": "吸血", "evasion": "闪避",
    "aura_brill": "辉煌", "aura_heal": "治疗", "aura_show": "展示", "rebirth": "重生",
    "aura_command": "命令", "aura_endur": "耐久", "crit": "暴击",
}

# wginfo 的 buff 探针（BUFFS 里的键名，或原版 buff 的固定 ID -> 显示名）。
#   用来确认"光环到底有没有挂到单位身上"。
#   ⚠ 一个 buff 只能有一个来源技能；治疗光环真正回血的是 Aoar(它的 buff 引擎不挂)，
#     状态栏图标由"展示光环"挂 BUFFS['heal_show'] 提供 —— 这里两个都列出来便于对照。
BUFF_PROBES = [
    ("heal_show", "治疗图标"),      # BUFFS 键名
    ("akmond", "阿克蒙德"),         # BUFFS 键名
    ("BUau", "邪恶"),               # 以下都是游戏自带 buff，固定 ID，不参与重新分配
    ("BUav", "吸血"),
    ("BHab", "辉煌"),
    ("BOac", "命令"),
    ("BOae", "耐久"),
]


def buff_probe_id(ref):
    """探针里写的可能是 BUFFS 的键名，也可能是原版 buff 的固定 ID。"""
    return BUFFS.get(ref, ref)

# 翅膀/坐骑共用的通用参数
COMMON = dict(
    aura_radius=700.0,          # 光环半径（aare）
    summon_count=0,             # 每次攻击召唤的小龙数量
    summon_scale=48.0,          # 召唤物缩放（仅 X 轴）
    summon_acquire=700.0,       # 召唤物索敌范围
    summon_cd=15.0,             # 召唤冷却（秒）
    summon_life=0.0,            # 召唤物存活时间（0 = 不自动消失）
    mount_h=156.0,              # WG_MOUNT_H：坐骑抬高
    hero_h=144.0,               # WG_HERO_H：英雄抬高
    wing_speed_bonus=100,       # W002：移动速度 +100（Imvb）
    aura_heal_pct=0.03,         # Oar1：每秒按最大生命的比例
    # 「试穿」用翅膀的移速加成（只挂模型，不带光环）
    wing_speed_test_bonus=90,
    # 再生光环的"目标表"（atar）——照抄正版**物品版**再生光环 `AIgx`：
    #   ground,air,organic,vuln,invu,friend,neutral,self
    #   再多一个伏魔战记用的 `allies`（同盟玩家的单位）。
    #   ⚠ 正版里有 **neutral**（中立单位，例如"待救援的幸存者"），我们之前漏了它 ——
    #     玩家实测"剑圣（自己的单位）会按百分比回血，幸存者（中立）不回血"就是这个原因。
    #     正版数据：AIgx = ground,air,organic,vuln,invu,friend,neutral,self
    #                Aoar = ground,air,organic,vuln,invu,friend,neutral（治疗守卫，连自己都不奶）
    aura_targets="air,ground,organic,vuln,invu,friend,allies,neutral,self",
    aura_unholy_speed=0.20,     # Uau1
    aura_unholy_regen=30.0,     # Uau2（点/秒 —— 实测确认是点数不是百分比）
    aura_vamp=0.40,             # Uav1
    evasion=0.30,               # Eev1
    aura_brill=3.0,             # Hab1
    aura_command=0.50,          # Cac1
    aura_endur_speed=0.0,       # Oae1（0 = 不重复加移速）
    aura_endur_attack=0.40,     # Oae2
    crit_chance=35.0,           # Ocr1：⚠ 原版是**整数百分数**（15 = 15%），不是 0.15
    crit_multiplier=3.0,        # Ocr2
    rebirth_delay=3.0,          # Ore1：复活延迟（秒）
    rebirth_cd=150.0,           # acdn
    # 主动技能
    act_invul_dur=6.0,          # 暗影庇护：无敌时长（adur/ahdu）
    act_invul_cd=50.0,          # 暗影庇护：冷却
    act_tele_cd=60.0,           # 群体传送：冷却
    act_blink_cd=12.0,          # 闪烁：冷却
    act_blink_range=1300.0,     # 闪烁：最远距离
)

ICONS = dict(
    fallen=r"ReplaceableTextures\CommandButtons\BTNEnchantedCrows.blp",
    seraph=r"ReplaceableTextures\CommandButtons\BTNSirenMaster.blp",
    demon=r"ReplaceableTextures\CommandButtons\BTNStoneForm.blp",
    egg=r"ReplaceableTextures\CommandButtons\BTNThunderLizardEgg.blp",
    heal=r"ReplaceableTextures\CommandButtons\BTNHeal.blp",
    akmond=r"ReplaceableTextures\CommandButtons\BTNCorpseExplode.blp",
    # 翅膀"模型挂载"技能自己的图标（物品技能，界面上不显示，保持原样不折腾）
    wing_abil=r"ReplaceableTextures\CommandButtons\BTNPeriapt1.blp",
    # 「试穿」用品借用的现成图标（都在这份"**已逐个验证存在**"的路径里）
    test_awing=r"ReplaceableTextures\CommandButtons\BTNRedDragon.blp",
    test_angel=r"ReplaceableTextures\CommandButtons\BTNSobiMask.blp",
    test_fairy=r"ReplaceableTextures\CommandButtons\BTNBootsOfSpeed.blp",
    test_ewing=r"ReplaceableTextures\CommandButtons\BTNRingSkull.blp",
    test_demon2=r"ReplaceableTextures\CommandButtons\BTNRunedBracers.blp",
    # 装备挂件演示借用的图标
    test_helmet=r"ReplaceableTextures\CommandButtons\BTNGlove.blp",
    test_shield=r"ReplaceableTextures\CommandButtons\BTNThunderLizardEgg.blp",
    test_equipfx=r"ReplaceableTextures\CommandButtons\BTNEnchantedCrows.blp",
)

# 坐骑蛋物品的其它参数（所有蛋共用）
EGG_COMMON = dict(treasure=r"Objects\InventoryItems\TreasureChest\treasurechest.mdl")


# ---------------------------------------------------------------------------
# 5b) 「试穿」用翅膀（挑模型用：只挂模型 + 移速 +90，没有光环/被动/主动）
# ---------------------------------------------------------------------------
#   名字统一以「试穿」开头，`wing 试穿` 列表里一眼能认出来；模型来自
#   `maps/_wing_src/`（从 神界危机 里提出来的纯翅膀挂件：只有 Stand 一段动画，
#   自带贴图或直接用游戏自带贴图）。挑完把选中的模型挪进上面 WINGS，这段就能删。
TEST_WINGS = [
    dict(key="awing", name="试穿·纯白羽翼", item_key="wing_test_awing",
         model_abil_key="wing_model_awing", model=r"awing.mdx",
         icon_key="test_awing", note="纯白羽毛天使翼（最正统）"),
    dict(key="angel", name="试穿·冰蓝天使翼", item_key="wing_test_angel",
         model_abil_key="wing_model_angel", model=r"angelwing.mdx",
         icon_key="test_angel", note="冰蓝银白天使翼（神器感）"),
    dict(key="fairy", name="试穿·彩虹羽翼", item_key="wing_test_fairy",
         model_abil_key="wing_model_fairy", model=r"fairywing.mdx",
         icon_key="test_fairy", note="彩虹羽翼（精灵/蝴蝶感）"),
    dict(key="ewing", name="试穿·暗红骨翼", item_key="wing_test_ewing",
         model_abil_key="wing_model_ewing", model=r"ewing.mdx",
         icon_key="test_ewing", note="暗红骨骼脉络（恶魔/龙王感）"),
    dict(key="demon2", name="试穿·末日守卫翼", item_key="wing_test_demon2",
         model_abil_key="wing_model_demon2", model=r"demonwings2.mdx",
         icon_key="test_demon2", note="末日守卫同款（用游戏自带贴图）"),
]
for _t in TEST_WINGS:
    _t["item"] = ITEMS[_t["item_key"]]
    _t["model_abil"] = ABIL[_t["model_abil_key"]]
    _t["book"] = 0                       # 没有隐藏魔法书（脚本遇到 0 直接跳过）
    _t["book2"] = 0
    _t["speed_abil"] = ABIL["wing_speed_test"]
    _t["iabi"] = [_t["speed_abil"], _t["model_abil"]]
    _t["icon"] = ICONS[_t["icon_key"]]
    _t["hotkey"] = ""
    _t["book_abil_keys"] = []
    _t["book2_abil_keys"] = []
    _t["book_abils"] = []
    _t["book2_abils"] = []

# 生成器 / JASS 表统一用这个（真翅膀 + 试穿翅膀）
ALL_WINGS = WINGS + TEST_WINGS


# ---------------------------------------------------------------------------
# 5c) 「装备挂件」（**已撤掉**，2026-10-10：玩家试过"国王之冠长头盔"之后确认
#     通用头盔不可行——很多英雄模型自带头盔/兜帽，造型也不搭，所以这条线不做。）
# ---------------------------------------------------------------------------
#   结论与做法留档在 docs/翅膀与坐骑系统.md；要重开只要把下面两段取消注释即可。
#   `TEST_ARTS` = 独立试穿物品（只挂模型）；`ITEM_OVERRIDES` = 直接改原版物品。
TEST_ARTS = [
    # dict(key="helmet", name="试穿·步兵头盔", item_key="demo_helmet",
    #      model_abil_key="art_helmet", model=r"FootmansHelmet.mdx", attach="head",
    #      icon_key="test_helmet", note="战役里的步兵头盔挂件（游戏自带贴图）"),
    # dict(key="shield", name="试穿·死亡之盾", item_key="demo_shield",
    #      model_abil_key="art_shield", model=r"NSRPG_shield_deathshield.mdx", attach="chest",
    #      icon_key="test_shield", note="NSRPG 盾牌挂件（挂点 chest，可改 hand,left）"),
    # dict(key="equipfx", name="试穿·装备光效", item_key="demo_equipfx",
    #      model_abil_key="art_equipfx", model=r"item_equip_320_effect.mdx", attach="origin",
    #      icon_key="test_equipfx", note="通用装备光效（自带 2 张贴图）"),
]
for _a in TEST_ARTS:
    _a["item"] = ITEMS[_a["item_key"]]
    _a["model_abil"] = ABIL[_a["model_abil_key"]]
    _a["book"] = 0
    _a["book2"] = 0
    _a["iabi"] = [_a["model_abil"]]
    _a["icon"] = ICONS[_a["icon_key"]]
    _a["hotkey"] = ""
    _a["book_abil_keys"] = []
    _a["book2_abil_keys"] = []
    _a["book_abils"] = []
    _a["book2_abils"] = []

# 脚本/JASS 表统一收录（真翅膀 + 试穿翅膀 + 试穿挂件），`wing <名字>` 都能拿到
ALL_WEAR = WINGS + TEST_WINGS + TEST_ARTS

# 直接改原版物品：给它加一条挂载技能（保留原有技能），戴上去就多出外观。
#   `keep_abil` = 这件物品原本的技能列表（原版数据，照抄即可）。
ITEM_OVERRIDES = [
    # dict(old_id="ckng", keep_abil="AIx5", art_key="art_helmet",
    #      note="国王之冠：+5 属性 + 头上一顶步兵头盔（原版物品加外观的演示）"),
]
for _o in ITEM_OVERRIDES:
    _o["iabi"] = ",".join(x for x in (_o["keep_abil"], ABIL[_o["art_key"]]) if x)


# ---------------------------------------------------------------------------
# 便捷读取
# ---------------------------------------------------------------------------
def mount_by_key(key):
    for m in MOUNTS:
        if m["key"] == key:
            return m
    raise KeyError(key)


def wing_by_key(key):
    for w in WINGS:
        if w["key"] == key:
            return w
    raise KeyError(key)


def all_ids():
    """本系统占用的全部 rawcode（供 pick_ids.py 检查/避让）。"""
    out = {}
    for k, v in ABIL.items():
        out.setdefault(v, []).append("ABIL." + k)
    for k, v in ITEMS.items():
        out.setdefault(v, []).append("ITEMS." + k)
    for k, v in BUFFS.items():
        out.setdefault(v, []).append("BUFFS." + k)
    for k, v in HAND.items():
        out.setdefault(v, []).append("HAND." + k)
    for m in MOUNTS:
        out.setdefault(m["unit"], []).append("MOUNTS[" + m["key"] + "].unit")
        out.setdefault(m["egg"], []).append("MOUNTS[" + m["key"] + "].egg")
        out.setdefault(m["off"], []).append("MOUNTS[" + m["key"] + "].off")
    for w in WINGS:
        out.setdefault(w["item"], []).append("WINGS[" + w["key"] + "].item")
    return out


# --- 移植模式: 不带试穿款 ---
TEST_WINGS = []
TEST_ARTS = []
ITEM_OVERRIDES = []
