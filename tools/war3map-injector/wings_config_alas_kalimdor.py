"""战役专用配置（port_wings_campaign.py --mounts none 生成）。

档位 = **不带坐骑系统**（2026-10-15 玩家要求：以后移植默认不加坐骑）：

  * `MOUNTS` 已清空 → 坐骑单位 / 坐骑蛋 / 骑乘中物品 / 挂载技能 **一条都不生成**；

  * JASS 里 `wg_eggCount = 0`，坐骑相关代码全部空转（循环不进，也不会有坐骑内容）；

  * 翅膀（含星魂之力·灰烬雷暴） / 阿克蒙德之手 / 物品浏览器 照常；

  * HAND 用战役里**已有**的阿克蒙德之手 ID（移植时不重复添加这件装备）。

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
    # --- 星魂之力（燃烧之怒 194213 的神器，2026-10-15 移植成第 4 件翅膀）---
    #   本体 wing_model_star：AIlf —— 模型挂件 + 生命上限 +1000（同一个技能，
    #     见 gen_wing.build_wing_mods 的 hp_bonus 参数）
    #   书 book_star：全属性 +20 / 魔法上限 +500（书里最多 3 个，这里 2 个）
    #   主动 act_ashfall：灰烬雷暴（照抄 194213 里阿克蒙德的 A6V0，见下面注释）
    "wing_model_star": "W085",
    "book_star": "W086",
    #   2026-10-15 玩家改需求：原来的 star_stat(W087 全属性+20) /
    #     star_mana(W088 魔法上限+500) / +1000 生命 全部去掉，改成"移动速度顶满"。
    #     所以那两个键连同 ID 一起释放了（另有 W095 新的移速技能，见下）。
    # 星魂之力的移速技能：**顶满**（AIms 底子 + Imvb 数值）。
    #   别的三件翅膀共用 W002（+100），这件单独一条、数值写满 = 引擎速度上限 522。
    "star_speed": "W095",
    # 星魂之力的主动 = 阿克蒙德的「灰烬雷暴」（照抄 194213 的 A6V0）。
    #   底子 ANcl = 游戏自带的"通道/Channel"假技能（本身没有任何原生效果，全靠脚本演），
    #   这也是作者的做法 —— 数据值（Ncl1~Ncl6）照抄他的：
    #     Ncl1=1.0 吟唱/持续、Ncl2=2 点目标、Ncl3=3 可见+目标指示圈、
    #     Ncl4=1.0 施法动作时长、Ncl5=0 不锁其他技能、Ncl6='parasiteon' 基础命令 ID
    "act_ashfall": "W089",
    # 灰烬雷暴的两件"马甲技能"（由假单位施放，数值照抄战役里的 A6V1 / A617）
    "ash_thunder": "W092",      # 雷霆一击（减速/眩晕的那一下）
    "ash_rockets": "W093",      # 集群火箭（二阶的视觉）
    # 法术护盾：游戏原生 Spell Shield (ANss) —— 每 N 秒抵挡一次指向性法术。
    #   原生默认 40 秒冷却，这里改成 COMMON["star_shield_cd"]（4 秒）。
    "spell_shield": "W090",
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
    # 星魂之力（第 4 件翅膀）
    "wing_star": "I104",
}

# ---------------------------------------------------------------------------
# 3) buff ID（w3h 覆盖用）
# ---------------------------------------------------------------------------
BUFFS = {
    # ⚠⚠ 2026-10-15 玩家要求：**我们的 buff 一个都不许覆盖原版**。
    #   原来"阿克蒙德之手的光环"是去覆盖原版强击光环的 buff（BEar）—— 那会让**别人**
    #   的强击光环也跟着改名/换图标（玩家实测发现）。现在全部改成
    #   **以原版 buff 为底子的自定义 buff**（custom 段），技能侧用 abuf 指过来：
    #   原版 BEar / Boar / Babr / BNss 一个都不碰 → gen_w3h 的"覆盖段"留空。
    #   机制上没问题：自定义 buff 的状态栏图标来自它自己的 fart（燃烧之怒作者那
    #   几十条自定义 buff 就是这么用的），而"光环数值"始终来自挂它的那个技能本身。
    #   ⚠ ID 要是本图没被占用的（LT 是原版图，B64x 空着；别的图由 pick_ids 自动换）。
    # 阿克蒙德之手的光环（底子 BEar；+50% 攻击力是 A001 自己的 Ear1 给的）
    "akmond": "B641",
    # 灰烬雷暴一阶的减速 buff（底子 BHtc = 原版雷霆一击的 buff，照抄战役里 B642「灰烬之电」）
    "ash_slow": "B642",
    # 治疗光环（W074：按最大生命百分比回血的那个光环）的 buff（底子 Boar）
    "heal_native": "B643",
    # 展示光环（W079：只为把图标挂到状态栏）的 buff（底子 Babr）
    "heal_show": "B644",
    # 法术护盾（W090）的 buff（底子 BNss；护盾本身是引擎行为，buff 只管图标/说明）
    "spell_shield": "B645",
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
    "aura": "A001",     # 阿克蒙德之力（AIar 强击光环）
    "speed": "A002",    # 攻击速度加成（AIsx）
    "crit": "Azcr",     # 致命一击（物品浏览器 criton 用的图标技能）
    # 重击：**我们自己生成的**（不在模板里）。燃烧之怒里有现成的"物品版重击"
    #   （A64I「重击v15%300伤害（物品）」/ A6AE「重击600 8%」等，基对象 AHbh = 山丘之王-重击），
    #   我们照它给阿克蒙德之手补一条：概率触发额外伤害 + 眩晕。
    #   概率/伤害在 COMMON["hand_bash_chance"] / ["hand_bash_damage"]（0 = 不加这条）。
    "bash": "W091",
}
# buff 覆盖时用的统一文案
HEAL_BUFF_TEXT = "持续回复生命：每秒回复最大生命的 3%（自身与 700 范围内友军）。"
# 法术护盾的 buff 说明（⚠ 数字要和 COMMON["star_shield_cd"] 保持一致）
SHIELD_BUFF_TEXT = "每 4 秒抵挡一次指向性法术。"
AKMOND_BUFF_TEXT = "增加周围友军 50% 攻击力（近战/远程均生效）。"

# 「灰烬雷暴」一阶减速用的自定义 buff：文案/特效照抄战役里的 B642「灰烬之电」
#   （底子 BHtc = 原版雷霆一击的 buff；三个挂点特效挂在 origin 上）
ASH_SLOW_BUFF_NAME = "灰烬之电"
ASH_SLOW_BUFF_TIP = "|cff00ff00灰烬之电|r"
ASH_SLOW_BUFF_TEXT = "|cff00ff00该单位受到了灰烬之电的影响，因此降低了速度！|r"
ASH_SLOW_BUFF_FX = (r"Abilities\Spells\Orc\StasisTrap\StasisTotemTarget.mdl,"
                    r"Abilities\Spells\Human\Thunderclap\ThunderClapCaster.mdl,"
                    r"StormfallRed.mdx")

# ---------------------------------------------------------------------------
# 4) 坐骑单位 ID（w3u）
# ---------------------------------------------------------------------------
UNITS = {
    "phoenix": "h01D",
    "blue": "n02N",
    "black": "n02M",
    "red": "n02P",
    "bronze": "n02L",
    # 灰烬雷暴用的两个"马甲单位"（隐身假单位，照抄战役里的 e60C / e641：
    #   底子是 wisp `ewsp`，模型设成非法名 '.mdl' = 不可见，Aloc+Avul = 无碰撞+无敌）。
    "dummy_thunder": "n100",
    "dummy_rockets": "n101",
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
MOUNTS = []   # --mounts none：本图不要坐骑系统

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
        # 2026-10-15：Min/Max Spells 写满后一本书能装 4 条，重生并回主书，
        #   不再需要第二本小书（book_seraph2 的定义保留，其它图的旧配置可能还在用）。
        item_key="wing_seraph", book_key="book_seraph", book2_key=None,
         model_abil_key="wing_model_seraph", active_key="act_tele",
         iabi_keys=["act_tele", "wing_speed", "wing_model_seraph"],
         model=r"FWIND.MDX",
         book_abil_keys=["aura_brill", "aura_heal", "aura_show", "rebirth"],
         book2_abil_keys=[]),
    dict(key="demon", name="恶魔之翼", short="恶魔",
         hotkey="B",
         item_key="wing_demon", book_key="book_demon", book2_key=None,
         model_abil_key="wing_model_demon", active_key="act_blink",
         iabi_keys=["act_blink", "wing_speed", "wing_model_demon"],
         model=r"DoomgGuardWings.mdx",
         book_abil_keys=["aura_command", "aura_endur", "crit"], book2_abil_keys=[]),
    # 星魂之力：从燃烧之怒（194213）的「星魂之力（神器）」移植，模型挂件
    #   （war3campImported\anchibang0100.mdx，挂 chest）+ 4 张贴图随模块一起注入。
    #   2026-10-15 玩家验收后的改动：
    #     * 去掉原物品的 +1000 生命 / +20 全属性 / +500 魔法（以及移植时就已去掉的
    #       +40 攻击 / +40% 攻速）—— 让这件翅膀和别的一样走"特色"而不是"纯数值"；
    #     * 改成 **移动速度顶满**（star_speed / W095，Imvb=522）；
    #     * 保留 法术护盾 与 主动·灰烬雷暴。
    #   ＊原物品的"混沌：强化阿克蒙德全技能 20%"是**战役脚本**按"是否持有 I60N"判定的，
    #     我们这件新物品没有那条脚本判定，所以不含该效果（要的话得另做脚本）。
    dict(key="star", name="星魂之力", short="星魂",
         hotkey="S",
         # book_key=None = 这件翅膀**没有隐藏魔法书**（原来装全属性/魔法上限，已删）。
         #   脚本遇到 book=0 直接跳过（"试穿"翅膀走的就是同一套，已实测）。
         item_key="wing_star", book_key=None, book2_key=None,
           model_abil_key="wing_model_star", active_key="act_ashfall",
         # 物品技能列表上限 4 个：主动 + 移速顶满 + 本体(只挂模型) + 法术护盾 = 正好 4 ✓
           #   2026-10-17：献祭底子换成 **`AIcf`（火焰风衣）** —— 这是**被动**（不会抢"点物品"），
           #   负责"英雄被火焰包围"的观感；伤害仍由脚本按 300 码 / 0.5 秒 / 最高属性×0.5 结算。
           iabi_keys=["act_ashfall", "star_speed", "wing_model_star", "spell_shield"],
         model=r"anchibang0100.mdx", attach="chest", hp_bonus=0,
         book_abil_keys=[], book2_abil_keys=[]),
]


# --- 把"键名"解析成真正的 4 字符 ID（生成器统一读下面这些解析后的字段）---
for _m in MOUNTS:
    _m["egg"] = ITEMS[_m["item_key"]]
    _m["off"] = ITEMS[_m["off_key"]]
    _m["unit"] = UNITS[_m["unit_key"]]
for _w in WINGS:
    _w["item"] = ITEMS[_w["item_key"]]
    # book_key = None 表示这件翅膀没有隐藏魔法书 -> 0（脚本遇到 0 跳过）
    _w["book"] = ABIL[_w["book_key"]] if _w.get("book_key") else 0
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
    # 星魂之力（第 4 件翅膀）：2026-10-15 玩家改需求 —— 原来的 +1000 生命 /
    #   +20 全属性 / +500 魔法 全部去掉，改成"移动速度顶满"。
    #   （引擎的速度上限是 522，所以写 522 就等于"全满"，多少基础速度都到顶。）
    star_speed_bonus=522,              # W095：移动速度 522 = 顶满
    # --- 星魂之力的主动 = 「灰烬雷暴」（照抄 194213 里阿克蒙德那套 A6V0）---
    #   数值全部取自它的 6 级那档：一阶 AoE 400 + 智力*4（混沌/通用伤害）、自身回血
    #   200 + 智力*4、9 点雷击环（中心 + 半径 300 的 8 个方向）、500 范围雷霆一击（减速）；
    #   隔 ash_combo_window 秒**自动**接二阶（假单位引导集群火箭，每下 300 + 智力，最多 3 下）。
    #   ★ 玩家要求：参与计算的主属性改成**佩戴英雄的最高属性**（含装备加成），
    #     所以原码里所有"智力*N"都按"最高属性*N"算。
    ash_damage=200,                # 一阶 AoE 伤害基数（2026-10-16 玩家要求 400 → 200：突出主属性）
    ash_stat_mult=4.0,             # 一阶伤害的属性倍率
    ash_radius=500.0,              # 一阶 AoE 半径（照抄 A6V0）
    ash_ring=300.0,                # 9 点雷击环半径（照抄）
    ash_range=900.0,               # 施法距离（照抄 A6V0 的 aran = 900）
    ash_cd=25.0,                   # 冷却
    ash_mana=50,                   # 魔法消耗
    ash_heal=200,                  # 一阶自身回血基数
    ash_heal_stat_mult=4.0,        # 一阶自身回血属性倍率
    ash_wave_damage=200,           # 二阶每次落点伤害基数（2026-10-16 玩家要求 300 → 200）
    ash_wave_stat_mult=1.0,        # 二阶每次落点伤害属性倍率（原码 300 + 智力）
    ash_wave_count=3,              # 二阶伤害次数（原技能"最多 3 次"）
    ash_wave_interval=0.5,         # 二阶每次之间间隔（秒）
    ash_combo_window=1.0,          # 一阶放完多久自动接二阶（原码时序 1 秒）
    ash_fx=r"StormfallRed.mdx",    # 雷击特效（从战役取出，随模块注入地图根目录）
    ash_fx_caster=r"ssw1.mdx",     # 施法者起手特效
    ash_fx_missile=r"StormfallRed.mdx",  # 二阶集群火箭的弹道模型（照抄 A617 的 amat）
    ash_shake=3.0,                 # 屏幕震动强度（原码 3）
    ash_stat="max",                # 主属性 = 最高属性
    star_shield_cd=4.0,                # 法术护盾：每 N 秒抵挡一次指向性法术（原生 Spell Shield）
    # 隐藏魔法书的 Min/Max Spells（spb3/spb4）。
    #   ⚠ Aspb 基对象默认是 3/3 —— 引擎只把技能表里前 3 个授予单位（项目里那条
    #     "一本魔法书最多 3 个"的旧记录就是这么来的）。燃烧之怒 194213 里作者的书
    #     写的是 12/12，6 条技能全部生效。这里统一写满，别再被悄悄截断。
    book_min_spells=12,
    book_max_spells=12,
    # --- 掠夺（阿克蒙德之手的被动，脚本实现）---
    #   数值与判定**照抄《西方世界的劫难6》**里的「掠夺」脚本（玩家指定的参考）：
    #     * 触发：**击杀**敌方单位（不是"每打一下"——第一版是攻击制，玩家反馈体感不好）
    #     * 门槛：敌人、非幻象、非召唤物、最大生命 ≥ plunder_min_hp
    #     * 金币（整数除法，和原图一样）：
    #         非英雄: (plunder_base       + 等级*plunder_per_lv
    #                  + 随机(1..等级)*plunder_rand)             / plunder_div
    #         英雄:   (plunder_hero_base  + 等级*plunder_hero_per_lv
    #                  + 随机(1..等级)*plunder_hero_rand)        / plunder_div
    #       （原图就是 /3；5 级小兵 ≈ 9~11 金，10 级英雄 ≈ 85~100 金）
    #   plunder_enable = 0 时整个被动关闭（默认关，只在指定图里打开）。
    plunder_enable=1,          # 0 = 关闭这个被动；1 = 打开
    plunder_min_hp=300,        # 只掠夺"最大生命 ≥ 这个值"的单位（0 = 不限）
    plunder_base=15,           # 非英雄：基础值
    plunder_per_lv=2,          # 非英雄：每级加成
    plunder_rand=2,            # 非英雄：随机(1..等级) 的系数
    plunder_hero_base=150,     # 英雄：基础值
    plunder_hero_per_lv=10,    # 英雄：每级加成
    plunder_hero_rand=5,       # 英雄：随机(1..等级) 的系数
    plunder_div=3,             # 最后除以这个数（照抄原图的 /3）
    # --- 阿克蒙德之手的「重击」（概率触发额外伤害 + 眩晕）---
    #   照抄燃烧之怒里现成的物品版重击（`A6AE`「重击600 8%」，基对象 AHbh = 山丘之王-重击）：
    #   alev=1 / aher=0 / Hbh1 = 概率(%) / Hbh3 = 额外伤害。
    #   眩晕时长用原生值（非英雄 2 秒、英雄 1 秒）。
    #   hand_bash_chance = 0 时不生成这条技能、也不写进物品的技能列表（默认关）。
    hand_bash_chance=8,        # 触发概率（%）；0 = 关闭
    hand_bash_damage=600,      # 额外伤害（照抄"重击600 8%"那档）
    # --- 死亡之指（阿克蒙德之手的主动，脚本实现；2026-10-15 玩家定的数值）---
    #   伤害：对**英雄** = 最高属性 × finger_dmg_hero_mult
    #         非英雄（含建筑）= 翻倍 → × finger_dmg_other_mult
    #         混沌攻击 + 万能伤害类型 = 无视护甲与魔法免疫（照原图"对魔免也生效"）
    #   冷却 = max(finger_cd_min,   finger_cd_base   - 最高属性 / finger_cd_div)
    #   耗魔 = max(finger_mana_min, finger_mana_base - 最高属性 / finger_mana_div)
    #   ⚠ 冷却/耗魔要"随属性变"，技能就必须做成多档：最高属性每 finger_stat_step 点升一档，
    #     脚本每秒按佩戴者的最高属性给技能调等级（见 f.j 的 WG_FingerSync）。
    finger_dmg_hero_mult=25.0,     # 对英雄的伤害倍率
    finger_dmg_other_mult=50.0,    # 非英雄（含建筑）：翻倍
    finger_cd_base=12.0,           # 冷却基数（秒）
    finger_cd_div=25.0,            # 每多少点最高属性减 1 秒
    finger_cd_min=6.0,             # 冷却下限（秒）
    finger_mana_base=100,          # 耗魔基数
    finger_mana_div=2.0,           # 每多少点最高属性减 1 点魔
    finger_mana_min=40,            # 耗魔下限
    finger_stat_step=25,           # 最高属性每 +N 升一档
    finger_levels=7,               # 档数（0/25/50/75/100/125/150+ → 12/11/10/9/8/7/6 秒）
    finger_range=800.0,            # 施法距离（照原图）
    finger_lightning="AFOD",       # 施法时画的闪电（原图技能的 alig 就是 AFOD）
    #   Art - Effect Sound 用的 **engine sound label**（不是文件路径）。
    #   官方 ANfd（阿克蒙德的死亡之指）本身没有声音字段，这条是玩家要求加的。
    #   可换的候选（都来自 UI\SoundInfo\AbilitySounds.slk）：
    #     SoulPreservation(恶魔系，默认) / BanishCaster / ImpaleCast /
    #     StormEarthFireSound / StampedeCast / SpiritTouch
    finger_sound_label="SoulPreservation",
    # 闪电由**引擎**画（底子 ANfd 自带 LightningEffect = AFOD，引擎会把闪电锚在单位身上）。
    #   1 = 保留脚本自己画的那条（AddLightningEx）当作兜底/对照；默认 0 = 只让引擎画。
    finger_script_bolt=0,
)

# ---------------------------------------------------------------------------
# 6) 物品的**地面模型**（掉在地上时显示的那个模型）
# ---------------------------------------------------------------------------
#   燃烧之怒 194213 里的神器掉在地上会发光、很绚丽（作者用的是一整套自制宝箱模型
#   `Chest_*.mdx`，16 种颜色 + `Chest_Beam`）；玩家反馈"这才符合神器的名头"。
#   所以给翅膀/手也换上对应的颜色。贴图全是**游戏自带**的，只有 Legendary 还要两张
#   符文图（ChestOrangeRunes1/2.blp），已一起放进 `maps/_wing_src`，随注入写进地图根目录。
GROUND = {
    "fallen":  r"Chest_Purple.mdx",      # 堕落天使之翼：紫
    "seraph":  r"Chest_Yellow.mdx",      # 炽天使之翼：金
    "demon":   r"Chest_Black.mdx",       # 恶魔之翼：黑
    "star":    r"Chest_LightBlue.mdx",   # 星魂之力：浅蓝
    "hand":    r"Chest_Legendary.mdx",   # 阿克蒙德之手：传说款（神话感最强）
    # 坐骑蛋保持原版宝箱（和上面几件区分开）
    "default": r"Objects\InventoryItems\TreasureChest\treasurechest.mdl",
}


ICONS = dict(
    fallen=r"ReplaceableTextures\CommandButtons\BTNEnchantedCrows.blp",
    seraph=r"ReplaceableTextures\CommandButtons\BTNSirenMaster.blp",
    demon=r"ReplaceableTextures\CommandButtons\BTNStoneForm.blp",
    star=r"ReplaceableTextures\CommandButtons\BTNMoonstone.blp",
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
def finger_level_table(common=None):
    """死亡之指每档的 (冷却, 耗魔)。

    档位 i 对应"最高属性 = i * finger_stat_step"，越靠后越短/越省：
      CD   = max(finger_cd_min,   finger_cd_base   - 属性 / finger_cd_div)
      mana = max(finger_mana_min, finger_mana_base - 属性 / finger_mana_div)
    默认参数下 7 档 = 12/11/10/9/8/7/6 秒、100/88/75/63/50/40/40 魔。
    """
    C = common or COMMON
    step = int(C.get("finger_stat_step", 25))
    n = int(C.get("finger_levels", 7))
    rows = []
    for i in range(n):
        stat = i * step
        cd = max(float(C.get("finger_cd_min", 6.0)),
                 float(C.get("finger_cd_base", 12.0)) - stat / float(C.get("finger_cd_div", 25.0)))
        mana = max(int(C.get("finger_mana_min", 40)),
                   int(round(float(C.get("finger_mana_base", 100))
                             - stat / float(C.get("finger_mana_div", 2.0)))))
        rows.append((round(cd, 2), mana))
    return rows


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


# --- 战役移植: 不带试穿款 ---
TEST_WINGS = []
TEST_ARTS = []
ITEM_OVERRIDES = []
