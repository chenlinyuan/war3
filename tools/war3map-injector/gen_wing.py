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
# 技能 ID 规划 (W 前缀避免冲突)
#   翅膀本体 (挂翅膀模型):
WING_MAIN = "W000"      # 堕落天使之翼 (WingOfTheLucifer)
WING_SERAPH = "W020"    # 炽天使之翼 (FWIND)
WING_DEMON = "W021"     # 恶魔之翼 (DoomgGuardWings)
#   翅膀"基础加速" (三件共有; 物品版移速加成, 固定值)
WING_SPEED = "W002"          # 移动速度 +100                     (AIms + Imvb)
#   翅膀光环 / 被动 —— 全部是**单位版**技能(不能用物品版: 物品技能放进魔法书里不生效),
#   它们被塞进下面每件翅膀的"隐藏魔法书"(脚本添加并 SetPlayerAbilityAvailable 隐藏),
#   所以既生效又**不占英雄技能栏**:
WING_AURA_UNHOLY = "W070"    # 邪恶光环: 友军 移速+20%、每秒回血+30  (AUau + Uau1/Uau2)
WING_AURA_VAMP = "W071"      # 吸血光环: 友军 吸血+40%               (AUav + Uav1)
WING_EVASION = "W072"        # 闪避 30%                             (AEev + Eev1)
WING_AURA_BRILL = "W073"     # 辉煌光环: 友军 魔法恢复+300%          (AHab + Hab1)
WING_AURA_HEAL = "W074"      # 治疗光环(真正回血): 每秒按最大生命的 3%   (Aoar + Oar1)
#   = 巫医"治疗守卫"的再生光环: 数值是"按最大生命百分比/秒", 换地图也通用。
WING_AURA_SHOW = "W079"      # 治疗光环(展示专用, 0 效果): 只为挂 buff 图标  (AOae)
#   = 耐久光环做底, 两个数值都 0(移速/攻速), **不碰生命恢复机制**;
#     buff 用本图没人用的原版 `Babr`(由 war3map.w3h 改名"治疗光环"+图标) —— 见 W074 说明。
WING_REBIRTH = "W075"        # 重生(原版 Reincarnation)              (AOre + Ore1/acdn)
WING_AURA_COMMAND = "W076"   # 命令光环: 友军 攻击力+50%             (ACac + Cac1/Ear2/Ear3)
WING_AURA_ENDUR = "W077"     # 耐久光环: 友军 攻击速度+40%           (AOae + Oae1/Oae2)
WING_CRIT = "W078"           # 致命一击: 35% 概率 3 倍伤害            (AOcr + Ocr1/Ocr2)
#   三本"隐藏魔法书" (脚本按需给英雄加上并隐藏; 一本书装一件翅膀的全部光环/被动)
WING_BOOK_FALLEN = "W080"    # 堕落天使之书: W070,W071,W072
WING_BOOK_SERAPH = "W081"    # 炽天使之书:   W073,W074,W079        (3 个)
WING_BOOK_SERAPH2 = "W084"   # 炽天使之书2:  W075(重生)             (另开一本)
#   ⚠ 2026-10-10 第十一轮: 重生(AOre) 在 W081 里排第 4 个之后就**不生效了**
#     (玩家实测: 加了"展示光环"当第 3 个, 重生被挤到第 4 → 重生失效)。
#     实测证据指向"一本魔法书里只有前 3 个技能会真正挂到单位上"这个上限 ——
#     所以把重生单独放进第二本小书, 两本都 ≤3 个。
WING_BOOK_DEMON = "W082"     # 恶魔之书:     W076,W077,W078
#   翅膀主动技能 (都用游戏自带"物品版"技能, 任何地图都能用; 必须是物品 iabi 的第一项):
WING_ACT_INVUL = "W022"      # 暗影庇护: 6 秒无敌                    (AIvu + adur/ahdu)
WING_ACT_TELE = "W023"       # 群体传送: 自身 + 700 内友军一起传送     (AHmt + aare)
WING_ACT_BLINK = "W024"      # 闪烁: 最远 1300                       (AIbk + Ebl1)
#   坐骑挂载技能 (被动 AIlf + 模型, 放在"骑乘中物品"的 iabi 里 → 模型挂到持有者, 且不占技能栏):
MOUNT_PHOENIX = "W040"  # 火凤凰
MOUNT_BLUE = "W041"     # 蓝龙
MOUNT_BLACK = "W042"    # 黑龙
MOUNT_RED = "W043"      # 红龙
#   蛋使用技能 (主动 AIha, 无模型, 放在"蛋"的 iabi 里 → 可点击使用):
EGG_USE_PHOENIX = "W060"
EGG_USE_BLUE = "W061"
EGG_USE_BLACK = "W062"
EGG_USE_RED = "W063"
EGG_USE_BRONZE = "W064"
#   取消骑乘技能 (主动 AIha, 无模型, 放在"骑乘中物品"的 iabi 里):
MOUNT_DISMOUNT = "W050"      # 取消骑乘 (放在"骑乘中物品"的 iabi, 点击使用)

# 坐骑模型路径 (来自 unitui.slk, 加 .mdx 扩展名)
MOUNT_MODEL_PHOENIX = "units\\human\\phoenix\\phoenix.mdx"
MOUNT_MODEL_BLUE = "units\\creeps\\AzureDragon\\AzureDragon.mdx"
MOUNT_MODEL_BLACK = "units\\creeps\\BlackDragon\\BlackDragon.mdx"
MOUNT_MODEL_RED = "units\\creeps\\RedDragon\\RedDragon.mdx"
MOUNT_MODEL_BRONZE = "units\\creeps\\BronzeDragon\\BronzeDragon.mdx"


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


def build(out_path):
    entries = []

    # === 翅膀本体 (只负责"挂翅膀模型"; 物品技能, 不上技能栏) ===
    entries.append(ability_entry(
        WING_MAIN, "AIlf", "[翅膀]堕落天使之翼", BTN_LIFE,
        extra_mods=build_wing_mods("WingOfTheLucifer.MDX", 0),
    ))
    entries.append(ability_entry(
        WING_SERAPH, "AIlf", "[翅膀]炽天使之翼", BTN_LIFE,
        extra_mods=build_wing_mods("FWIND.MDX", 0),
    ))
    entries.append(ability_entry(
        WING_DEMON, "AIlf", "[翅膀]恶魔之翼", BTN_LIFE,
        extra_mods=build_wing_mods("DoomgGuardWings.mdx", 0),
    ))

    # === 基础加速 (三件共有; 物品技能) ===
    entries.append(ability_entry(
        WING_SPEED, "AIms", "[翅膀]移动速度 +100", BTN_BOOTS,
        extra_mods=[mod("Imvb", 0, 1, 1, 100)],
    ))

    # === 光环 / 被动: 单位版技能, 放进下面的"隐藏魔法书"里 ===
    # (用物品版 AIa* 放进魔法书不生效, 必须用单位版 AUau/AUav/AEev/AHab/Aoar/AOre/ACac/AOae/AOcr)
    # 邪恶光环: Uau1 = 移动速度%, Uau2 = 每秒回血
    entries.append(ability_entry(
        WING_AURA_UNHOLY, "AUau", "[光环]邪恶: 移速+20% 回血+30", BTN_REGEN,
        extra_mods=[
            mod("Uau1", 2, 1, 1, 0.20),
            mod("Uau2", 2, 1, 2, 30.0),
            mod("aare", 2, 1, 0, 700.0),
        ],
        item_ability=False,
    ))
    # 吸血光环: Uav1 = 吸血比例
    entries.append(ability_entry(
        WING_AURA_VAMP, "AUav", "[光环]吸血 +40%", BTN_DRAGON_R,
        extra_mods=[
            mod("Uav1", 2, 1, 1, 0.40),
            mod("aare", 2, 1, 0, 700.0),
        ],
        item_ability=False,
    ))
    # 闪避: Eev1 = 闪避概率
    entries.append(ability_entry(
        WING_EVASION, "AEev", "闪避 30%", BTN_BRACER,
        extra_mods=[mod("Eev1", 2, 1, 1, 0.30)],
        item_ability=False,
    ))
    # 辉煌光环: Hab1 = 魔法恢复倍数
    entries.append(ability_entry(
        WING_AURA_BRILL, "AHab", "[光环]魔法恢复 +300%", BTN_MANA,
        extra_mods=[
            mod("Hab1", 2, 1, 1, 3.0),
            mod("aare", 2, 1, 0, 700.0),
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
            mod("Oar1", 2, 1, 1, 0.03),
            # Oar2 = "按最大生命的百分比" 开关, 原版 Aoar 就是 1 —— 显式写出来,
            #   免得自定义技能没继承到(第八轮补)。
            mod("Oar2", 0, 1, 2, 1),
            mod("aare", 2, 1, 0, 700.0),
            mod("atar", 3, 1, 0, "air,ground,organic,vuln,invu,friend,allies,self"),
            mod("abuf", 3, 1, 0, "Boar"),
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
            mod("aare", 2, 1, 0, 700.0),
            mod("atar", 3, 1, 0, "air,ground,organic,vuln,invu,friend,allies,self"),
            mod("abuf", 3, 1, 0, "Babr"),
        ],
        item_ability=False,
    ))
    # 重生 = 原版 Reincarnation: Ore1 = 复活延迟(秒), acdn = 冷却
    entries.append(ability_entry(
        WING_REBIRTH, "AOre", "重生", BTN_LIFE,
        extra_mods=[
            mod("Ore1", 2, 1, 1, 3.0),
            mod("acdn", 2, 1, 0, 150.0),
        ],
        tip="重生",
        ubertip="阵亡 3 秒后自动复活。|n冷却 150 秒。",
        item_ability=False,
    ))
    # 命令光环 (原版就有): Cac1 = 攻击力%; Ear2/Ear3 = 近战/远程开关
    entries.append(ability_entry(
        WING_AURA_COMMAND, "ACac", "[光环]命令: 攻击力 +50%", BTN_BRACER,
        extra_mods=[
            mod("Cac1", 2, 1, 1, 0.50),
            mod("Ear2", 0, 1, 2, 1),
            mod("Ear3", 0, 1, 3, 1),
            mod("aare", 2, 1, 0, 700.0),
        ],
        item_ability=False,
    ))
    # 耐久光环: Oae2 = 攻击速度%(Oae1 移动速度% 留 0, 免得与"基础加速"重复)
    entries.append(ability_entry(
        WING_AURA_ENDUR, "AOae", "[光环]攻击速度 +40%", BTN_BOOTS,
        extra_mods=[
            mod("Oae1", 2, 1, 1, 0.0),
            mod("Oae2", 2, 1, 2, 0.40),
            mod("aare", 2, 1, 0, 700.0),
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
            mod("Ocr1", 2, 1, 1, 35.0),
            mod("Ocr2", 2, 1, 2, 3.0),
        ],
        item_ability=False,
    ))

    # === 三本"隐藏魔法书" (脚本按需加到英雄身上并 SetPlayerAbilityAvailable 隐藏) ===
    #   spb1 = 书里的技能列表, spb5 = 命令字符串(必须是 "spellbook")
    entries.append(ability_entry(
        WING_BOOK_FALLEN, "Aspb", "[书]堕落天使", BTN_MANA,
        extra_mods=[
            mod("spb1", 3, 1, 1, "W070,W071,W072"),
            mod("spb5", 3, 1, 5, "spellbook"),
        ],
        item_ability=False,
    ))
    entries.append(ability_entry(
        WING_BOOK_SERAPH, "Aspb", "[书]炽天使", BTN_MANA,
        extra_mods=[
            # 两个光环都在书里(玩家定的方案):
            #   W074 = 真正按最大生命百分比/秒回血(治疗守卫那套, 玩家实测有效)
            #   W079 = 展示专用光环(数值≈0), 作用只是把 buff 挂上 → 状态栏有图标
            #   (第八轮一度把 W074 挂到坐骑单位上试"载体", 已回退: 治疗是翅膀的效果,
            #    不该依赖坐骑)
            mod("spb1", 3, 1, 1, "W073,W074,W079"),
            mod("spb5", 3, 1, 5, "spellbook"),
        ],
        item_ability=False,
    ))
    # 炽天使第二本小书: 只装重生(避免被"一本最多 3 个"的上限挤掉)
    entries.append(ability_entry(
        WING_BOOK_SERAPH2, "Aspb", "[书]炽天使2", BTN_MANA,
        extra_mods=[
            mod("spb1", 3, 1, 1, "W075"),
            mod("spb5", 3, 1, 5, "spellbook"),
        ],
        item_ability=False,
    ))
    entries.append(ability_entry(
        WING_BOOK_DEMON, "Aspb", "[书]恶魔", BTN_MANA,
        extra_mods=[
            mod("spb1", 3, 1, 1, "W076,W077,W078"),
            mod("spb5", 3, 1, 5, "spellbook"),
        ],
        item_ability=False,
    ))

    # === 通用主动技能 (物品技能: 点物品使用, 冷却转圈显示在物品图标上) ===
    entries.append(ability_entry(
        WING_ACT_INVUL, "AIvu", "暗影庇护", BTN_LIFE,
        extra_mods=[
            mod("adur", 2, 1, 0, 6.0),
            mod("ahdu", 2, 1, 0, 6.0),
            mod("acdn", 2, 1, 0, 50.0),
        ],
        tip="暗影庇护(|cffffcc00D|r)",
        ubertip="6 秒内免疫所有伤害。|n冷却 50 秒。",
    ))
    # 群体传送: 必须用英雄版 AHmt(点地面); 物品版 AImt 是"指向友军单位"的, 点地面无效
    entries.append(ability_entry(
        WING_ACT_TELE, "AHmt", "群体传送", BTN_MANA,
        extra_mods=[
            mod("aare", 2, 1, 0, 700.0),
            mod("acdn", 2, 1, 0, 60.0),
        ],
        tip="群体传送(|cffffcc00T|r)",
        ubertip="把自身与周围 700 范围内的友军一起传送到地图上任意可见位置。|n冷却 60 秒。",
    ))
    entries.append(ability_entry(
        WING_ACT_BLINK, "AIbk", "闪烁", BTN_BOOTS,
        extra_mods=[
            mod("Ebl1", 2, 1, 1, 1300.0),
            mod("acdn", 2, 1, 0, 12.0),
        ],
        tip="闪烁(|cffffcc00B|r)",
        ubertip="瞬间移动到指定地点(最远 1300)。|n冷却 12 秒。",
    ))

    # === 坐骑挂载技能 (被动 AIlf + 模型, 放在"骑乘中物品"的 iabi → 模型挂到持有者, 不占技能栏) ===
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

    # === 蛋使用技能 (主动 AIha, 无模型, 放在"蛋"的 iabi → 可点击使用) ===
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

    # === 取消骑乘技能 (主动 AIha, 无模型, 放在"骑乘中物品"的 iabi) ===
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
