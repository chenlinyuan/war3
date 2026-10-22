"""生成翅膀/坐骑系统的 war3map.w3a（技能对象数据）。

机制（源自伏魔战记，改进版）:
  翅膀 = 物品 + 技能(TargetArt=模型, Targetattach=chest)
  坐骑 = 物品 + 技能(TargetArt=坐骑模型, Targetattach=origin)
        —— 把坐骑模型挂在英雄身上, 英雄保持可见/可控 (不用隐藏英雄!)

CRITICAL 要点:
  1. 基础技能必须用真实存在的技能 ID!
     code=AIml 的真实 ID: AIlf/AIl1/AIl2/AIlz (AIml 本身不是 ID)
     code=AImi 的真实 ID: AImh/AIpx
     用不存在的 ID → 游戏 ACCESS_VIOLATION 崩溃。
  2. 数据字段必须 level=1 + column=1 (DataA1), 否则属性不生效。
  3. 物品技能列表(iabi)里的技能必须直接列出, 不要用魔法书(Aspb)包裹
     —— 魔法书里的物品技能不会被动生效。

用法:
    python gen_wing.py <输出w3a>
"""
import struct, sys, os

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
CFG = __import__(os.environ.get("WINGS_CONFIG", "wings_config"))   # 移植到别的图时可用 WINGS_CONFIG=<别的配置模块名>
C = CFG.COMMON                      # 通用数值

# ---------------------------------------------------------------------------
# 图标
BTN_LIFE = "ReplaceableTextures\\CommandButtons\\BTNPeriapt1.blp"
BTN_BOOTS = "ReplaceableTextures\\CommandButtons\\BTNBootsOfSpeed.blp"
BTN_REGEN = "ReplaceableTextures\\CommandButtons\\BTNRingSkull.blp"
BTN_MANA = "ReplaceableTextures\\CommandButtons\\BTNSobiMask.blp"
BTN_BRACER = "ReplaceableTextures\\CommandButtons\\BTNRunedBracers.blp"
BTN_EGG = "ReplaceableTextures\\CommandButtons\\BTNThunderLizardEgg.blp"
BTN_PHOENIX = "ReplaceableTextures\\CommandButtons\\BTNMarkOfFire.blp"
BTN_DRAGON_B = "ReplaceableTextures\\CommandButtons\\BTNAzureDragon.blp"
BTN_DRAGON_K = "ReplaceableTextures\\CommandButtons\\BTNBlackDragon.blp"
BTN_DRAGON_R = "ReplaceableTextures\\CommandButtons\\BTNRedDragon.blp"

# ---------------------------------------------------------------------------
# 技能 ID —— 全部从 wings_config.py 取（移植时用 pick_ids.py 自动挑空闲 ID）
WING_MAIN = CFG.ABIL["wing_model_fallen"]
WING_SERAPH = CFG.ABIL["wing_model_seraph"]
WING_DEMON = CFG.ABIL["wing_model_demon"]
WING_SPEED = CFG.ABIL["wing_speed"]
WING_AURA_UNHOLY = CFG.ABIL["aura_unholy"]
WING_AURA_VAMP = CFG.ABIL["aura_vamp"]
WING_EVASION = CFG.ABIL["evasion"]
WING_AURA_BRILL = CFG.ABIL["aura_brill"]
WING_AURA_HEAL = CFG.ABIL["aura_heal"]
WING_AURA_SHOW = CFG.ABIL["aura_show"]
WING_REBIRTH = CFG.ABIL["rebirth"]
WING_AURA_COMMAND = CFG.ABIL["aura_command"]
WING_AURA_ENDUR = CFG.ABIL["aura_endur"]
WING_CRIT = CFG.ABIL["crit"]
WING_BOOK_FALLEN = CFG.ABIL["book_fallen"]
WING_BOOK_SERAPH = CFG.ABIL["book_seraph"]
WING_BOOK_SERAPH2 = CFG.ABIL["book_seraph2"]
WING_BOOK_DEMON = CFG.ABIL["book_demon"]
WING_ACT_INVUL = CFG.ABIL["act_invul"]
WING_ACT_TELE = CFG.ABIL["act_tele"]
WING_ACT_BLINK = CFG.ABIL["act_blink"]
WING_BOOK_STAR = CFG.ABIL["book_star"]
STAR_SPEED = CFG.ABIL["star_speed"]
WING_ACT_ASHFALL = CFG.ABIL["act_ashfall"]
WING_SPELL_SHIELD = CFG.ABIL["spell_shield"]
MOUNT_PHOENIX = CFG.ABIL["mount_model_phoenix"]
MOUNT_BLUE = CFG.ABIL["mount_model_blue"]
MOUNT_BLACK = CFG.ABIL["mount_model_black"]
MOUNT_RED = CFG.ABIL["mount_model_red"]
EGG_USE_PHOENIX = CFG.ABIL["egg_use_phoenix"]
EGG_USE_BLUE = CFG.ABIL["egg_use_blue"]
EGG_USE_BLACK = CFG.ABIL["egg_use_black"]
EGG_USE_RED = CFG.ABIL["egg_use_red"]
EGG_USE_BRONZE = CFG.ABIL["egg_use_bronze"]
MOUNT_DISMOUNT = CFG.ABIL["dismount"]

# 坐骑模型路径（来自 wings_config 的 MOUNTS 表；.mdx 是 unitui.slk 的模型路径 + 扩展名）
#   ⚠ 不能直接 CFG.mount_by_key("phoenix")：配置里 `MOUNTS = []`（--mounts none）时会抛
#     KeyError —— 而"不带坐骑"是现在移植的默认档位。这里查不到就返回空串，
#     下面用到它们的地方只在 `if CFG.MOUNTS:` 里。
def _mount_model(key):
    for _m in CFG.MOUNTS:
        if _m["key"] == key:
            return _m["model"] + ".mdx"
    return ""


MOUNT_MODEL_PHOENIX = _mount_model("phoenix")
MOUNT_MODEL_BLUE = _mount_model("blue")
MOUNT_MODEL_BLACK = _mount_model("black")
MOUNT_MODEL_RED = _mount_model("red")
MOUNT_MODEL_BRONZE = _mount_model("bronze")


def mod(mid, t, level, col, val):
    """构造 w3a mod 元组 (modId, type, level, column, value, endMarker)。

    w3a mod 格式: modId(4) + type(4) + level(4) + column(4) + value + endMarker(4)
    type: 0=int, 1=real, 2=unreal, 3=string
    level: 技能等级 (数据字段用 1); column: 数据列索引 (DataA1=1)
    """
    return (mid, t, level, col, val, 0)


def write_mod(m):
    mid, t, level, col, val, end = m
    out = mid.encode("latin-1") + struct.pack("<iii", t, level, col)
    if t == 0:
        out += struct.pack("<i", val)
    elif t in (1, 2):
        out += struct.pack("<f", val)
    elif t == 3:
        out += val.encode("utf-8") + b"\x00"
    else:
        raise ValueError("bad type %d" % t)
    out += struct.pack("<i", end)
    return out


def write_entry(old_id, new_id, mods):
    out = old_id.encode("latin-1") + new_id.encode("latin-1") + struct.pack("<i", len(mods))
    for m in mods:
        out += write_mod(m)
    return out


def ability_entry(new_id, base_id, name, icon, extra_mods=None, levels=1, tip=None,
                  ubertip=None, item_ability=True):
    """构造一个技能条目。base_id 为游戏自带基础技能 ID (如 AIlf/AIms)。

    item_ability=False 用于英雄技能(如"取消骑乘"): 物品技能(aite=1)英雄是点不出来的。
    """
    mods = [
        mod("anam", 3, 0, 0, name),
        mod("aart", 3, 0, 0, icon),
        mod("arar", 3, 0, 0, icon),
        mod("alev", 0, 0, 0, levels),
        mod("aite", 0, 0, 0, 1 if item_ability else 0),
        mod("aher", 0, 0, 0, 0),
    ]
    if tip:
        mods.append(mod("atp1", 3, 0, 0, tip))
    if ubertip:
        mods.append(mod("aub1", 3, 0, 0, ubertip))
    if extra_mods:
        mods.extend(extra_mods)
    return (base_id, new_id, mods)


def model_mods(model_path, attach):
    """挂载模型到单位的 mod (全局字段, level=0)。"""
    return [
        mod("atat", 3, 0, 0, model_path),
        mod("atac", 0, 0, 0, 1),
        mod("ata0", 3, 0, 0, attach),
    ]


def build_wing_mods(model_path, hp_bonus, attach="chest"):
    """翅膀本体技能 (AIlf, code=AIml): 生命加成 + 模型挂载。

    CRITICAL: 数据字段必须 lv=1 col=1 (DataA1), 否则属性不生效。
    """
    return [mod("Ilif", 0, 1, 1, hp_bonus)] + model_mods(model_path, attach)


def build_mount_mods(model_path):
    """坐骑挂载技能 (AIlf, 被动): 把坐骑模型挂到持有者身上。

    CRITICAL: 必须用**被动**技能 (AIlf, 同翅膀), 放在物品 iabi 里,
              模型才会挂到持有者身上, 且**不占技能栏**。
              用主动技能(AIha)通过 UnitAddAbility 添加会出现在技能栏且模型挂不上。
    """
    return model_mods(model_path, "origin")


def build_use_mods():
    """蛋使用技能 / 取消骑乘技能 (AIha, 主动, 无模型, 仅用于触发使用事件)。"""
    return [
        mod("Ihpg", 0, 1, 1, 0),
        mod("atar", 3, 1, 0, "ground,air,friend,self,invu,vuln"),
        mod("aare", 2, 1, 0, 1.0),
        mod("acdn", 2, 1, 0, 1.0),
        mod("amcs", 0, 1, 0, 0),
    ]


def book_mods(key, which="book"):
    """隐藏魔法书的 mod：技能表 + order id + **Min/Max Spells**。

    ⚠ 2026-10-15 查明的坑：`Aspb`（魔法书）基对象的 **Min/Max Spells 默认是 3/3**
      （DataC1 / DataD1 = 3），引擎只把技能表里**前 3 个**授予单位 —— 项目里那条
      "一本魔法书最多 3 个"的旧记录就是这个默认值造成的，**不是引擎硬上限**。
      燃烧之怒 194213 里作者的书（A6FF）显式写了 **12/12**，6 条技能全部生效
      （玩家实测 6 条属性都在）。这里统一按配置写满，
      以后书里想装几条都不会再被悄悄截断。
    """
    field = "book_abils" if which == "book" else "book2_abils"
    return [
        mod("spb1", 3, 1, 1, ",".join(CFG.wing_by_key(key)[field])),
        mod("spb5", 3, 1, 5, "spellbook"),
        mod("spb3", 0, 1, 3, C["book_min_spells"]),
        mod("spb4", 0, 1, 4, C["book_max_spells"]),
    ]


def build(out_path):
    entries = []

    # === 翅膀本体 (只负责"挂翅膀模型"; 物品技能, 不上技能栏) ===
    #   真翅膀 3 件 + 「试穿」用翅膀（只挂模型，玩家用来挑外观）
    for _w in (list(CFG.WINGS) + list(getattr(CFG, "TEST_WINGS", []))
               + list(getattr(CFG, "TEST_ARTS", []))):
        entries.append(ability_entry(
            _w["model_abil"], "AIlf", "[翅膀]" + _w["name"], CFG.ICONS["wing_abil"],
            # hp_bonus: 星魂之力用它把"+1000 生命"和"模型挂件"做在同一个技能里
            extra_mods=build_wing_mods(_w["model"], _w.get("hp_bonus", 0),
                                       _w.get("attach", "chest")),
        ))

    # === 基础加速 (三件共有; 物品技能) ===
    entries.append(ability_entry(
        WING_SPEED, "AIms", "[翅膀]移动速度 +100", BTN_BOOTS,
        extra_mods=[mod("Imvb", 0, 1, 1, C["wing_speed_bonus"])],
    ))
    # 「试穿」用的加速 (只有 +90，和真翅膀区分开)
    if getattr(CFG, "TEST_WINGS", None):
        entries.append(ability_entry(
            CFG.ABIL["wing_speed_test"], "AIms",
            "[试穿]移动速度 +%d" % int(C.get("wing_speed_test_bonus", 90)), BTN_BOOTS,
            extra_mods=[mod("Imvb", 0, 1, 1, C["wing_speed_test_bonus"])],
        ))

    # === 光环 / 被动: 单位版技能, 放进下面的"隐藏魔法书"里 ===
    # (用物品版 AIa* 放进魔法书不生效, 必须用单位版 AUau/AUav/AEev/AHab/Aoar/AOre/ACac/AOae/AOcr)
    # 邪恶光环: Uau1 = 移动速度%, Uau2 = 每秒回血
    entries.append(ability_entry(
        WING_AURA_UNHOLY, "AUau", "[光环]邪恶: 移速+20% 回血+30", BTN_REGEN,
        extra_mods=[
            mod("Uau1", 2, 1, 1, C["aura_unholy_speed"]),
            mod("Uau2", 2, 1, 2, C["aura_unholy_regen"]),
            mod("aare", 2, 1, 0, C["aura_radius"]),
        ],
        item_ability=False,
    ))
    # 吸血光环: Uav1 = 吸血比例
    entries.append(ability_entry(
        WING_AURA_VAMP, "AUav", "[光环]吸血 +40%", BTN_DRAGON_R,
        extra_mods=[
            mod("Uav1", 2, 1, 1, C["aura_vamp"]),
            mod("aare", 2, 1, 0, C["aura_radius"]),
        ],
        item_ability=False,
    ))
    # 闪避: Eev1 = 闪避概率
    entries.append(ability_entry(
        WING_EVASION, "AEev", "闪避 30%", BTN_BRACER,
        extra_mods=[mod("Eev1", 2, 1, 1, C["evasion"])],
        item_ability=False,
    ))
    # 辉煌光环: Hab1 = 魔法恢复倍数
    entries.append(ability_entry(
        WING_AURA_BRILL, "AHab", "[光环]魔法恢复 +300%", BTN_MANA,
        extra_mods=[
            mod("Hab1", 2, 1, 1, C["aura_brill"]),
            mod("aare", 2, 1, 0, C["aura_radius"]),
        ],
        item_ability=False,
    ))
    # ── 治疗光环 = **两个光环**配合实现（2026-10-10 第七轮，玩家实测后的方案）──
    #   ① W074 真正回血: 巫医"治疗守卫"的再生光环 (Aoar), Oar1 = 按**最大生命的百分比/秒**
    #      → 这才是"通用"的写法: 换任何地图/任何血量都合理(写死点数换个图就废了)。
    #      它自己的 buff 引擎不挂(实测), 所以它只负责"回血"这件事。
    #   ② W079 只负责**展示**: 用邪恶光环 (AUau) 做底, 两个数值都设 0
    #      → 它不产生任何实际效果, 但**会挂 buff**, 于是状态栏里能看到那个图标。
    #      两个技能都写在魔法书 W081 里(书里的光环已实测会挂 buff)。
    #   ⚠ 数值单位已实测确认: AUau 的 Uau2 是**点/秒**(不是百分比) —— 所以回血不能用它。
    entries.append(ability_entry(
        WING_AURA_HEAL, "Aoar", "[光环]每秒回复最大生命 3%", BTN_REGEN,
        extra_mods=[
            mod("Oar1", 2, 1, 1, C["aura_heal_pct"]),
            # Oar2 = "按最大生命的百分比" 开关, 原版 Aoar 就是 1 —— 显式写出来,
            #   免得自定义技能没继承到(第八轮补)。
            mod("Oar2", 0, 1, 2, 1),
            mod("aare", 2, 1, 0, C["aura_radius"]),
            mod("atar", 3, 1, 0, C["aura_targets"]),
            # 2026-10-15 起用**自定义** buff（底子 Boar）：不覆盖原版 Boar，
            #   免得地图里别的"治疗守卫"也跟着改名。
            mod("abuf", 3, 1, 0, CFG.BUFFS["heal_native"]),
        ],
        item_ability=False,
    ))
    # 展示专用光环(0 效果): 只为把 buff 挂到身上, 让状态栏有图标。
    #   ⚠ 2026-10-10 第十轮: 之前这里用**邪恶光环 AUau + 同一个 buff `Boar`**,
    #     结果"一加它, 治疗光环就不再按百分比回血了"(玩家实测)。原因几乎可以肯定
    #     就在这两点上, 所以现在同时避开:
    #     ① **不能和回血光环共用 buff**: 同一 buff 的"来源技能"只能有一个, 谁最后挂上
    #        谁说了算 —— 展示光环会把这个 buff 抢过去, 于是回血按展示光环的数值(≈0)算。
    #        → 展示光环改用一个本图没人用的**原版 buff `Babr`**(黑曜石雕像的枯萎再生),
    #          再在 war3map.w3h 里把它改名成"治疗光环"+图标。
    #     ② **不能碰"回血"这个机制**: 换用**耐久光环 `AOae`**(移速/攻速那一族),
    #        两个数值全 0, 跟生命恢复完全无关, 不可能再干扰 W074 的百分比回血。
    entries.append(ability_entry(
        WING_AURA_SHOW, "AOae", "[光环]治疗光环(展示)", BTN_REGEN,
        extra_mods=[
            mod("Oae1", 2, 1, 1, 0.0),
            mod("Oae2", 2, 1, 2, 0.0),
            mod("aare", 2, 1, 0, C["aura_radius"]),
            mod("atar", 3, 1, 0, C["aura_targets"]),
            mod("abuf", 3, 1, 0, CFG.BUFFS["heal_show"]),
        ],
        item_ability=False,
    ))
    # 重生 = 原版 Reincarnation: Ore1 = 复活延迟(秒), acdn = 冷却
    entries.append(ability_entry(
        WING_REBIRTH, "AOre", "重生", BTN_LIFE,
        extra_mods=[
            mod("Ore1", 2, 1, 1, C["rebirth_delay"]),
            mod("acdn", 2, 1, 0, C["rebirth_cd"]),
        ],
        tip="重生",
        ubertip="阵亡 %d 秒后自动复活。|n冷却 %d 秒。" % (C["rebirth_delay"], C["rebirth_cd"]),
        item_ability=False,
    ))
    # 命令光环 (原版就有): Cac1 = 攻击力%; Ear2/Ear3 = 近战/远程开关
    entries.append(ability_entry(
        WING_AURA_COMMAND, "ACac", "[光环]命令: 攻击力 +50%", BTN_BRACER,
        extra_mods=[
            mod("Cac1", 2, 1, 1, C["aura_command"]),
            mod("Ear2", 0, 1, 2, 1),
            mod("Ear3", 0, 1, 3, 1),
            mod("aare", 2, 1, 0, C["aura_radius"]),
        ],
        item_ability=False,
    ))
    # 耐久光环: Oae2 = 攻击速度%(Oae1 移动速度% 留 0, 免得与"基础加速"重复)
    entries.append(ability_entry(
        WING_AURA_ENDUR, "AOae", "[光环]攻击速度 +40%", BTN_BOOTS,
        extra_mods=[
            mod("Oae1", 2, 1, 1, C["aura_endur_speed"]),
            mod("Oae2", 2, 1, 2, C["aura_endur_attack"]),
            mod("aare", 2, 1, 0, C["aura_radius"]),
        ],
        item_ability=False,
    ))
    # 致命一击: Ocr1 = 概率, Ocr2 = 倍率
    #   ⚠⚠ 单位陷阱(2026-10-10 第十一轮查证): 原版 AOcr 的 DataA1 = **15** —— 它是
    #      **整数百分数**(15 表示 15%), 不是 0.15 那种小数! 其它光环字段
    #      (Uau1/Uav1/Eev1/Hab1/Cac1/Oae*/Oar1)全是小数, 只有这一个不一样。
    #      以前写 0.35 = **0.35% 几率** → 玩家"从没见过暴击"就是这个原因
    #      (暴击压根没触发, 自然也看不到暴击的"！")。倍率 Ocr2 是普通数字
    #      (原版 2 = ×2), 所以 3.0 是对的。
    entries.append(ability_entry(
        WING_CRIT, "AOcr", "致命一击 35% x3", BTN_DRAGON_K,
        extra_mods=[
            mod("Ocr1", 2, 1, 1, C["crit_chance"]),
            mod("Ocr2", 2, 1, 2, C["crit_multiplier"]),
        ],
        item_ability=False,
    ))

    # === 三本"隐藏魔法书" (脚本按需加到英雄身上并 SetPlayerAbilityAvailable 隐藏) ===
    #   spb1 = 书里的技能列表, spb5 = 命令字符串(必须是 "spellbook"),
    #   spb3/spb4 = Min/Max Spells（**不写满就只授予前 3 个**，见 book_mods 的说明）
    entries.append(ability_entry(
        WING_BOOK_FALLEN, "Aspb", "[书]堕落天使", BTN_MANA,
        extra_mods=book_mods("fallen"),
        item_ability=False,
    ))
    entries.append(ability_entry(
        WING_BOOK_SERAPH, "Aspb", "[书]炽天使", BTN_MANA,
        # 书里 = 辉煌光环 + 治疗光环 + 展示光环(+ 重生, 见下面 book2 的说明)
        extra_mods=book_mods("seraph"),
        item_ability=False,
    ))
    # 第二本小书只在配置里还留着 book2 时才生成。
    #   （2026-10-15 之后炽天使不再需要它：Min/Max Spells 写满后一本书就能装 4 条，
    #     重生已经并回主书；这条分支留给别的图/别的配置继续用。）
    if CFG.wing_by_key("seraph")["book2_abils"]:
        entries.append(ability_entry(
            WING_BOOK_SERAPH2, "Aspb", "[书]炽天使2", BTN_MANA,
            extra_mods=book_mods("seraph", "book2"),
            item_ability=False,
        ))
    entries.append(ability_entry(
        WING_BOOK_DEMON, "Aspb", "[书]恶魔", BTN_MANA,
        extra_mods=book_mods("demon"),
        item_ability=False,
    ))
    # 「星魂之力」的移速：**顶满**（玩家 2026-10-15 改的需求）
    #   其它三件翅膀共用 W002（+100）；这件单独一条，数值写满 = 引擎速度上限 522。
    #   ⚠ 原来的 [星魂]全属性 +20（W087）/ 魔法上限 +500（W088）已按玩家要求删除，
    #     所以那把隐藏魔法书现在是个**空书**（物品技能列表里没有它们）。
    entries.append(ability_entry(
        STAR_SPEED, "AIms", "[星魂]移动速度 顶满", BTN_BOOTS,
        extra_mods=[mod("Imvb", 0, 1, 1, C["star_speed_bonus"])],
    ))
    # 星魂之力现在**不需要**魔法书了（全属性/魔法上限那两条已删）——
    #   和"第二本小书"一样，配置里还有内容才生成这本书。
    if CFG.wing_by_key("star")["book_abils"]:
        entries.append(ability_entry(
            WING_BOOK_STAR, "Aspb", "[书]星魂之力", BTN_MANA,
            extra_mods=book_mods("star"),
            item_ability=False,
        ))

    # === 通用主动技能 (物品技能: 点物品使用, 冷却转圈显示在物品图标上) ===
    entries.append(ability_entry(
        WING_ACT_INVUL, "AIvu", "暗影庇护", BTN_LIFE,
        extra_mods=[
            mod("adur", 2, 1, 0, C["act_invul_dur"]),
            mod("ahdu", 2, 1, 0, C["act_invul_dur"]),
            mod("acdn", 2, 1, 0, C["act_invul_cd"]),
        ],
        tip="暗影庇护(|cffffcc00D|r)",
        ubertip="%d 秒内免疫所有伤害。|n冷却 %d 秒。" % (C["act_invul_dur"], C["act_invul_cd"]),
    ))
    # 群体传送: 必须用英雄版 AHmt(点地面); 物品版 AImt 是"指向友军单位"的, 点地面无效
    entries.append(ability_entry(
        WING_ACT_TELE, "AHmt", "群体传送", BTN_MANA,
        extra_mods=[
            mod("aare", 2, 1, 0, C["aura_radius"]),
            mod("acdn", 2, 1, 0, C["act_tele_cd"]),
        ],
        tip="群体传送(|cffffcc00T|r)",
        ubertip="把自身与周围 %d 范围内的友军一起传送到地图上任意可见位置。|n冷却 %d 秒。" % (
            C["aura_radius"], C["act_tele_cd"]),
    ))
    entries.append(ability_entry(
        WING_ACT_BLINK, "AIbk", "闪烁", BTN_BOOTS,
        extra_mods=[
            mod("Ebl1", 2, 1, 1, C["act_blink_range"]),
            mod("acdn", 2, 1, 0, C["act_blink_cd"]),
        ],
        tip="闪烁(|cffffcc00B|r)",
        ubertip="瞬间移动到指定地点(最远 %d)。|n冷却 %d 秒。" % (
            C["act_blink_range"], C["act_blink_cd"]),
    ))
    # 「星魂之力」的主动：灰烬雷暴（照抄 194213 里阿克蒙德的 A6V0）
    #   底子 ANcl = 游戏自带的"通道(Channel)"假技能：**本身没有任何原生效果**，
    #   全靠脚本演 —— 作者的 A6V0 就是这么做的，下面的数据照抄他那一份：
    #     Ncl1 = 1.0  Follow Through Time
    #     Ncl2 = 2    Data - Target Type（点目标）
    #     Ncl3 = 3    Data - Options（Visible 1 + Targeting Image 2）★ 少了它点不出来
    #     Ncl4 = 1.0  Art Duration
    #     Ncl5 = 0    Disable Other Abilities
    #     Ncl6 = 'parasiteon'  Base Order ID
    #   另外：施法距离 900 / AoE 指示圈 300（都照抄 A6V0 的 aran / aare）。
    #   伤害、回血、减速、二阶全部由 f.j 的 WG_OnAshFall 施加（技能本体不做事）。
    entries.append(ability_entry(
        WING_ACT_ASHFALL, "ANcl", "灰烬雷暴", CFG.ICONS["star"],
        extra_mods=[
            mod("Ncl1", 2, 1, 1, 1.0),
            mod("Ncl2", 0, 1, 2, 2),
            mod("Ncl3", 0, 1, 3, 3),
            mod("Ncl4", 2, 1, 4, 1.0),
            mod("Ncl5", 0, 1, 5, 0),
            mod("Ncl6", 3, 1, 6, "parasiteon"),
            mod("aord", 3, 0, 0, "replenish"),
            # 三处美术字段原图都清空了（Channel 本体不演任何特效，全交给脚本）
            mod("acat", 3, 0, 0, ""),
            mod("aeat", 3, 0, 0, ""),
            mod("atat", 3, 0, 0, ""),
            mod("aran", 2, 1, 0, C["ash_range"]),
            mod("aare", 2, 1, 0, 300.0),
            mod("acdn", 2, 1, 0, C["ash_cd"]),
            mod("amcs", 0, 1, 0, C["ash_mana"]),
        ],
        tip="灰烬雷暴(|cffffcc00S|r)",
        ubertip="在目标区域召来多重灰烬雷暴：%g 内的敌人受到 %d+最高属性*%g 混沌伤害、"
                "减速 8 秒，自身回复 %d+最高属性*%g 生命；1 秒后自动接二阶"
                "（火箭 %d 次 × %d+最高属性*%g）。|n冷却 %d 秒、耗魔 %d。" % (
                    C["ash_radius"], int(C["ash_damage"]), C["ash_stat_mult"],
                    int(C["ash_heal"]), C["ash_heal_stat_mult"],
                    int(C["ash_wave_count"]), int(C["ash_wave_damage"]), C["ash_wave_stat_mult"],
                    int(C["ash_cd"]), int(C["ash_mana"])),
    ))
    # 灰烬雷暴的两件"马甲技能"：由隐身假单位施放（字段/数值照抄战役里的 A6V1 / A617）
    #   ① 雷霆一击（AHtc）＝ 一阶的"减速"那一环，照抄 A6V1「雷霆一击-阿克马甲专用」：
    #      500 范围、减速 0.6（8 秒）、无耗魔、目标 organic；Htc1 的 5 点伤害是原图留的，
    #      真正的一阶伤害在脚本里给。acat='' = 马甲不可见，别放施法特效；
    #      abuf 指向**照抄 B642「灰烬之电」**的自定义 buff（三个挂点特效就是"被雷劈中"的样子）。
    entries.append(ability_entry(
        CFG.ABIL["ash_thunder"], "AHtc", "雷霆一击-灰烬雷暴", CFG.ICONS["star"],
        extra_mods=[
            mod("Htc1", 2, 1, 1, 5.0),
            mod("Htc2", 2, 1, 2, 500.0),
            mod("Htc3", 2, 1, 3, 0.6),
            mod("Htc4", 2, 1, 4, 0.6),
            mod("aare", 2, 1, 0, 500.0),
            mod("ahdu", 2, 1, 0, 8.0),
            mod("adur", 2, 1, 0, 8.0),
            mod("amcs", 0, 1, 0, 0),
            mod("acat", 3, 0, 0, ""),
            mod("abuf", 3, 1, 0, CFG.BUFFS["ash_slow"]),
            mod("arlv", 0, 0, 0, 10),
            mod("atar", 3, 1, 0, "ground,air,organic"),
        ],
        item_ability=False,
    ))
    #   ② 集群火箭（ANcs）＝ 二阶的视觉，照抄 A617「火箭群阿克马甲」：
    #      Ncs1 = 单发伤害（原图写 2，真正的伤害由脚本按"最高属性"给）、
    #      Ncs2 = 出弹间隔 0.5 秒（配合技能时长 ≈ 3 发，正好对应原图"最多 3 次伤害"）、
    #      Ncs3 = 导弹数量、Ncs4 = 伤害上限、amat = 弹道模型。
    #      ⚠ Ncs3 是**导弹数量**（不是伤害！置 0 就没有火箭了）。
    entries.append(ability_entry(
        CFG.ABIL["ash_rockets"], "ANcs", "火箭群-灰烬雷暴", CFG.ICONS["star"],
        extra_mods=[
            mod("amat", 3, 0, 0, C["ash_fx_missile"]),
            mod("Ncs1", 2, 1, 1, 2.0),
            mod("Ncs2", 2, 1, 2, 0.5),
            mod("Ncs3", 0, 1, 3, 25),
            mod("Ncs4", 2, 1, 4, 999999.0),
            mod("acdn", 2, 1, 0, 2.0),
            mod("amcs", 0, 1, 0, 0),
            mod("aran", 2, 1, 0, 99999.0),
            mod("amsp", 0, 0, 0, 1000),
            mod("amac", 2, 0, 0, 0.0),
            mod("aare", 2, 1, 0, 450.0),
            mod("atar", 3, 1, 0, "ground,enemies,structure,air"),
        ],
        item_ability=False,
    ))
    # 「星魂之力」的被动：**献祭**（原版献祭口径：只烧敌人、不烧魔免、不烧建筑）。
    #   ⚠ 2026-10-17 玩家实测的坑：原来挂的是游戏原生 Spell Shield(`ANss`)，它**带冷却**，
    #     一触发就把**物品的可用状态**占住 → 主动技能（点物品使用）点不出来。
    #     现在底子换成 `ANim`（永久献祭）+ **冷却 0** → 不会再锁物品；
    #     **伤害全部由脚本给**（按最高属性算，见 f.j 的 WG_OnImmolation），
    #     所以这里把 `aare` 压到 1.0 —— 原生那点固定伤害等于打不到人（单位中心距最小也有几十），
    #     而"脚底火焰"的观感照旧（施法者特效与 aare 无关）。
    #   它是**物品技能**（item=1），必须放在物品的 iabi 里（放魔法书里不生效）。
    entries.append(ability_entry(
        #   底子 = **`AIcf`（火焰风衣 / Cloak of Flames）**：物品 `clfm` 用的就是它，
        #   原版范围 160 / 每 1 秒一跳，效果就是"英雄被火焰包围"。范围/频率由脚本接管。
        #   ⚠ 别再写 `ANim`（1.24 不存在，会崩）或 `AImo`（那是怪兽诱捕守卫，会插一根守卫）。
        WING_SPELL_SHIELD, "AIcf", "[星魂]献祭", CFG.ICONS["star"],
        extra_mods=[
            mod("acdn", 2, 1, 0, 0.0),          # 冷却 0：没有冷却就不会锁物品
            mod("aare", 2, 1, 0, 1.0),          # 原生伤害"关掉"（脚本按 500 码自己算）
            mod("atar", 3, 1, 0, "ground,enemies,air"),
        ],
        tip="献祭(|cffffcc00被动|r)",
        ubertip="500 码内的敌人每 0.5 秒受到最高属性×0.5 的魔法伤害"
                "（不吃魔法免疫、不打建筑，伤害由装备脚本结算）。",
    ))
    # 阿克蒙德之手的「重击」：概率触发额外伤害 + 眩晕（放物品的技能列表里，被动生效）。
    #   基对象 AHbh = 山丘之王-重击；字段与数值照抄燃烧之怒里的物品版重击
    #   （A6AE「重击600 8%」：alev=1 / aher=0 / Hbh1=概率% / Hbh3=伤害），
    #   眩晕时长用原生值（非英雄 2 秒 / 英雄 1 秒，原图也没改）。
    if int(C.get("hand_bash_chance", 0)) > 0:
        entries.append(ability_entry(
            CFG.HAND["bash"], "AHbh", "[手]重击", CFG.ICONS["akmond"],
            # alev=1 / aher=0 / aite=1 由 ability_entry 统一写好了，这里只补两个数据字段
            extra_mods=[
                mod("Hbh1", 2, 1, 1, float(C["hand_bash_chance"])),
                mod("Hbh3", 2, 1, 3, float(C["hand_bash_damage"])),
            ],
            tip="重击(|cffffcc00被动|r)",
            ubertip="攻击时 %d%% 概率造成 %d 点额外伤害并眩晕。" % (
                int(C["hand_bash_chance"]), int(C["hand_bash_damage"])),
        ))

    # === 阿克蒙德之手的主动「死亡之指」（2026-10-15 晚：改用**官方那条技能**当底子）===
    #   底子 = `ANfd` = 官方「Finger of Death」，**就是战役里阿克蒙德用的那条**
    #     （游戏数据里它的 `EditorSuffix` 写着 `(Archimonde)`）。从官方数据读到的字段：
    #       Art             = ReplaceableTextures\CommandButtons\BTNCorpseExplode.blp
    #       Targetart       = Abilities\Spells\Demon\DemonBoltImpact\DemonBoltImpact.mdl
    #       LightningEffect = AFOD   ← **引擎自己画**这条红闪电，锚在单位身上（脚本画会偏）
    #       Data - Graphic Delay / Duration / Damage = Nfd1 / Nfd2 / Nfd3（官方 Damage = 500）
    #       Targets Allowed = 官方是"非英雄"（剧情用），我们加上 hero/enemy/neutral
    #   ⚠ 为什么不再用 Channel：Channel 没有真的"目标许可表"（点得到自己/友军），而且
    #     它**不画闪电**，只能脚本用 AddLightningEx 自己画 —— 一旦"单位坐标 ≠ 显示位置"
    #     闪电就会画歪（玩家实测两次）。ANfd 的闪电是引擎画的，位置永远对；
    #     目标表 `atar` 也是真字段（能限制成"只点敌人、能点英雄"）。
    #   ⚠ 官方 ANfd 的 Damage 是 500，我们**置 0**，伤害改由脚本按最高属性算（f.j 的 WG_OnFinger）。
    #   ⚠ 7 档必须**逐档**把 AbilityData 类字段写全（含 Nfd1/Nfd2/Nfd3/atar/aran），
    #     否则第 2 档往后会回退到基对象 ANfd 的默认值（Nfd3=500 → 白送一次官方伤害）；
    #     `alig`/`ahky`/`atat`/`aefs` 是 Profile 全局字段 → 写 lv=0 就够。
    finger_lv = CFG.finger_level_table(C)
    finger_atar = "air,ground,hero,nonhero,ancient,nonancient,structure,enemy,neutral"
    finger_mods = [
        mod("ahky", 3, 0, 0, "F"),      # 热键字母（官方也是 F）
        mod("alig", 3, 0, 0, str(C.get("finger_lightning", "AFOD"))),  # 引擎画这条闪电
        # Art - Target = 官方那条用的命中爆点
        mod("atat", 3, 0, 0, r"Abilities\Spells\Demon\DemonBoltImpact\DemonBoltImpact.mdl"),
        mod("acat", 3, 0, 0, ""),       # 官方没有 caster / effect art
        mod("aeat", 3, 0, 0, ""),
        # Art - Effect Sound = 引擎的 **sound label**（不是文件路径，由引擎自己解析）。
        #   官方 ANfd 没有声音字段（静音），这个是玩家要求加的。
        #   可选的 label 见 UI\SoundInfo\AbilitySounds.slk，例如
        #   SoulPreservation(恶魔系) / BanishCaster / ImpaleCast / StormEarthFireSound。
        mod("aefs", 3, 0, 0, str(C.get("finger_sound_label", "SoulPreservation"))),
    ]
    for i, (cd, mana) in enumerate(finger_lv, start=1):
        # 目标许可表（真字段）：能打英雄/建筑/敌人，能打中立（小野怪）；不含自己/友军
        finger_mods.append(mod("atar", 3, i, 0, finger_atar))
        finger_mods.append(mod("aran", 2, i, 0, C["finger_range"]))
        finger_mods.append(mod("Nfd1", 2, i, 1, 0.25))  # Graphic Delay（官方值）
        finger_mods.append(mod("Nfd2", 2, i, 2, 1.0))   # Graphic Duration（官方值）
        finger_mods.append(mod("Nfd3", 2, i, 3, 0.0))   # Damage = 0（伤害由脚本按最高属性给）
        finger_mods.append(mod("acdn", 2, i, 0, cd))
        finger_mods.append(mod("amcs", 0, i, 0, mana))
        finger_mods.append(mod("atp1", 3, i, 0, "死亡之指(|cffffcc00F|r)"))
        finger_mods.append(mod("aub1", 3, i, 0,
                               "对英雄造成 最高属性×%g 的混沌伤害，非英雄单位翻倍（×%g）；"
                               "无视护甲与魔法免疫。|n冷却 %g 秒、耗魔 %d。"
                               % (C["finger_dmg_hero_mult"], C["finger_dmg_other_mult"],
                                  cd, mana)))
    entries.append(ability_entry(
        CFG.HAND["finger"], "ANfd", "死亡之指", CFG.ICONS["akmond"],
        extra_mods=finger_mods, levels=len(finger_lv),
    ))

    # === 坐骑相关技能（挂载 / 蛋使用 / 取消骑乘）===
    #   ⚠ 2026-10-15 玩家要求：**以后移植默认不带坐骑系统**（战役配置里 `MOUNTS = []`）。
    #     所以这一整块（连同下面 gen_wing_item 的蛋/骑乘中物品、gen_w3u 的坐骑单位）
    #     都按 `CFG.MOUNTS` 是否为空来决定生成与否：坐骑表为空 -> 一条坐骑技能都不生成。
    #     JASS 那边的坐骑代码会随之变成空转（`wg_eggCount = 0`，所有循环都不进），
    #     不用改脚本。
    if CFG.MOUNTS:
        # 挂载技能 (被动 AIlf + 模型, 放在"骑乘中物品"的 iabi → 模型挂到持有者, 不占技能栏)
        entries.append(ability_entry(
            MOUNT_PHOENIX, "AIlf", "[坐骑]火凤凰", BTN_PHOENIX,
            extra_mods=build_mount_mods(MOUNT_MODEL_PHOENIX),
        ))
        entries.append(ability_entry(
            MOUNT_BLUE, "AIlf", "[坐骑]蓝龙", BTN_DRAGON_B,
            extra_mods=build_mount_mods(MOUNT_MODEL_BLUE),
        ))
        entries.append(ability_entry(
            MOUNT_BLACK, "AIlf", "[坐骑]黑龙", BTN_DRAGON_K,
            extra_mods=build_mount_mods(MOUNT_MODEL_BLACK),
        ))
        entries.append(ability_entry(
            MOUNT_RED, "AIlf", "[坐骑]红龙", BTN_DRAGON_R,
            extra_mods=build_mount_mods(MOUNT_MODEL_RED),
        ))

        # 蛋使用技能 (主动 AIha, 无模型, 放在"蛋"的 iabi → 可点击使用)
        entries.append(ability_entry(
            EGG_USE_PHOENIX, "AIha", "[蛋]使用火凤凰蛋", BTN_EGG,
            extra_mods=build_use_mods(),
        ))
        entries.append(ability_entry(
            EGG_USE_BLUE, "AIha", "[蛋]使用蓝龙蛋", BTN_EGG,
            extra_mods=build_use_mods(),
        ))
        entries.append(ability_entry(
            EGG_USE_BLACK, "AIha", "[蛋]使用黑龙蛋", BTN_EGG,
            extra_mods=build_use_mods(),
        ))
        entries.append(ability_entry(
            EGG_USE_RED, "AIha", "[蛋]使用红龙蛋", BTN_EGG,
            extra_mods=build_use_mods(),
        ))
        entries.append(ability_entry(
            EGG_USE_BRONZE, "AIha", "[蛋]使用青铜龙蛋", BTN_EGG,
            extra_mods=build_use_mods(),
        ))

        # 取消骑乘技能 (主动 AIha, 无模型, 放在"骑乘中物品"的 iabi)
        # 曾经改成"英雄技能(ANcl/Channel)"想对齐伏魔战记的 A0CD, 但 Channel 在命令栏里
        # 显示的是基础技能名"通魔", 而且 Follow Through/Disable Other Abilities 会让英雄
        # 卸下后卡住不动。改成物品方案更稳: 骑乘时给一件"骑乘中"物品, 点它卸下,
        # 丢掉它也会自动卸下 (见 WG_OnDropItem)。
        entries.append(ability_entry(
            MOUNT_DISMOUNT, "AIha", "[坐骑]取消骑乘", BTN_EGG,
            extra_mods=build_use_mods(),
        ))

    data = struct.pack("<ii", 2, 0) + struct.pack("<i", len(entries))
    for old, new, mods in entries:
        data += write_entry(old, new, mods)
    open(out_path, "wb").write(data)
    print("wrote %s: %d bytes, %d abilities" % (out_path, len(data), len(entries)))
    for old, new, mods in entries:
        print("   %s <- %s (%d mods)" % (new, old, len(mods)))


if __name__ == "__main__":
    out = os.path.join(HERE, "_wing.w3a")
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    if args:
        out = args[0]
    build(out)
