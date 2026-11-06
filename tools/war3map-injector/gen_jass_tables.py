"""从 wings_config.py 生成 scripts/wings 里的"表"（生成段）。

用法:
    python gen_jass_tables.py          # 就地更新 f.j / g.j 的生成段

生成段用标记包起来：
    // >>> GENERATED:BEGIN <名字> (wings_config.py) >>>
    ...
    // >>> GENERATED:END <名字> <<<
标记之间**不要手改**（会被覆盖）；标记外随便改。

build_wings.py 会自动调用本脚本，所以正常流程不用单独跑。
"""
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
BASE = os.path.dirname(os.path.dirname(HERE))
sys.path.insert(0, HERE)
CFG = __import__(os.environ.get("WINGS_CONFIG", "wings_config"))   # 移植到别的图时可用 WINGS_CONFIG=<别的配置模块名>

FJ = os.path.join(BASE, "scripts", "wings", "f.j")
GJ = os.path.join(BASE, "scripts", "wings", "g.j")
C = CFG.COMMON


def num(v):
    """JASS 里的实数写法：整数也带 .0（156 -> 156.0），保持和原文件一致。"""
    f = float(v)
    return ("%f" % f).rstrip("0") + "0" if f == int(f) else str(f)


def q(idstr):
    return "'%s'" % idstr


def jstr(value):
    return '"%s"' % str(value).replace("\\", "\\\\").replace('"', '\\"')


def rebuild(text, name, body):
    """把 <name> 生成段替换成 body（body 是去掉缩进的文本行列表）。"""
    pat = re.compile(
        r"([ \t]*)// >>> GENERATED:BEGIN %s \(wings_config\.py\) >>>\r?\n.*?"
        r"[ \t]*// >>> GENERATED:END %s <<<\r?\n" % (name, name), re.S)
    m = pat.search(text)
    if not m:
        raise SystemExit("找不到生成段标记: %s" % name)
    ind = m.group(1)
    out = ind + "// >>> GENERATED:BEGIN %s (wings_config.py) >>>\n" % name
    for ln in body:
        out += (ind + ln if ln else "") + "\n"
    out += ind + "// >>> GENERATED:END %s <<<\n" % name
    return text[:m.start()] + out + text[m.end():]


def body_g_heights():
    return ["real WG_MOUNT_H = " + num(C["mount_h"]),
            "real WG_HERO_H = " + num(C["hero_h"])]


def body_g_summon():
    """召唤小龙的参数（战役里把 summon_count 设 0 = 关掉）。

    以前这三个数值**写死在 f.j 里**（15 秒 / 2 只 / 不自动消失），配置里的
    `summon_count` / `summon_cd` 其实是摆设 —— 这次一并改成配置驱动。
    """
    return ["// 每次英雄攻击最多召唤几只小龙（0 = 关掉召唤）",
            "integer WG_SUMMON_COUNT = %d" % int(C.get("summon_count", 0)),
            "// 召唤冷却（秒）",
            "real WG_SUMMON_CD = " + num(C.get("summon_cd", 0.0)),
            "// 召唤物存活时间（秒）；0 = 不自动消失，只在下次召唤/卸下时替换",
            "real wg_summonLife = " + num(C.get("summon_life", 0.0))]


def body_g_hand():
    """阿克蒙德之手 / 掠夺（脚本被动）的常量。

    掠夺 = **击杀**敌方单位时按目标等级掠夺金币，数值与判定照抄《西方世界的劫难6》
    里的「掠夺」脚本（见 f.j 的 WG_OnPlunder）。
    """
    return ["// 阿克蒙德之手的物品 ID（掠夺挂在它身上）",
            "// 1 = equipment skills are owned by the item; 0 = hero command card.",
            "boolean WG_ITEM_ACTIVE = false",
            "integer WG_HAND_ITEM = " + q(CFG.HAND["item"]),
            "// 掠夺总开关（0 = 关掉这个被动）",
            "integer WG_PLUNDER_ENABLE = %d" % int(C.get("plunder_enable", 0)),
            "// 只掠夺最大生命 >= 这个值的单位（0 = 不限）",
            "real WG_PLUNDER_MIN_HP = " + num(C.get("plunder_min_hp", 500)),
            "// 非英雄：基础值 / 每级 / 随机系数",
            "integer WG_PLUNDER_BASE = %d" % int(C.get("plunder_base", 15)),
            "integer WG_PLUNDER_PER_LV = %d" % int(C.get("plunder_per_lv", 2)),
            "integer WG_PLUNDER_RAND = %d" % int(C.get("plunder_rand", 2)),
            "// 英雄：基础值 / 每级 / 随机系数",
            "integer WG_PLUNDER_HERO_BASE = %d" % int(C.get("plunder_hero_base", 150)),
            "integer WG_PLUNDER_HERO_PER_LV = %d" % int(C.get("plunder_hero_per_lv", 10)),
            "integer WG_PLUNDER_HERO_RAND = %d" % int(C.get("plunder_hero_rand", 5)),
            "// 最后除以这个数（照抄原图的 /3）",
            "integer WG_PLUNDER_DIV = %d" % int(C.get("plunder_div", 3)),
            "// 夺魂：1 = 死亡之指击杀英雄/强敌时永久增加 1 点智力",
            "integer WG_HAND_SOUL_GAIN = %d" % int(C.get("hand_soul_gain", 1)),
            "integer WG_HAND_SOUL_HERO_CHANCE = %d" % int(C.get("hand_soul_hero_chance", 100)),
            "integer WG_HAND_SOUL_ELITE_CHANCE = %d" % int(C.get("hand_soul_elite_chance", 25)),
            "integer WG_HAND_SOUL_MIN_LEVEL = %d" % int(C.get("hand_soul_min_level", 8)),
            "real WG_HAND_SOUL_MIN_HP = " + num(C.get("hand_soul_min_hp", 2000)),
            # 2026-10-15 死亡之指改成按智力计算的混沌伤害：
            "// --- 死亡之指（阿克蒙德之手的主动）---",
            "integer WG_FINGER_ABILITY = " + q(CFG.HAND["finger"]),
            "// 对英雄/非英雄的伤害倍率（非英雄=翻倍）",
            "real WG_FINGER_HERO_MULT = " + num(C.get("finger_dmg_hero_mult", 25.0)),
            "real WG_FINGER_OTHER_MULT = " + num(C.get("finger_dmg_other_mult", 50.0)),
            "// 冷却/耗魔分档：最高属性每 WG_FINGER_STEP 点升一档，最多 WG_FINGER_MAXLVL 档",
            "integer WG_FINGER_STEP = %d" % int(C.get("finger_stat_step", 25)),
            "integer WG_FINGER_MAXLVL = %d" % int(C.get("finger_levels", 7)),
            "// Cooldown formula for the item-owned Death Finger instance.",
            "real WG_FINGER_CD_BASE = " + num(C.get("finger_cd_base", 12.0)),
            "real WG_FINGER_CD_DIV = " + num(C.get("finger_cd_div", 25.0)),
            "real WG_FINGER_CD_MIN = " + num(C.get("finger_cd_min", 6.0)),
            "// 施法时画的闪电（原图技能 alig = AFOD）",
            "string WG_FINGER_LIGHTNING = " + '"' + str(C.get("finger_lightning", "AFOD")) + '"',
            # 脚本在"点错目标"时要把魔退回给玩家，所以耗魔公式也生成一份
            #   （按**当前档位**算，与技能本体的 amcs 一致）
            "// 耗魔公式（点错目标时按当前档退魔）",
            "integer WG_FINGER_MANA_BASE = %d" % int(C.get("finger_mana_base", 100)),
            "real WG_FINGER_MANA_DIV = " + num(C.get("finger_mana_div", 2.0)),
            "integer WG_FINGER_MANA_MIN = %d" % int(C.get("finger_mana_min", 40)),
            # 1 = 脚本再画一条闪电（兜底）；默认 0 = 只让引擎按技能的 LightningEffect 画
            "integer WG_FINGER_SCRIPT_BOLT = %d" % int(C.get("finger_script_bolt", 0))]


def body_g_starfall():
    """星魂之力的主动「灰烬雷暴」（照抄 194213 里阿克蒙德的 A6V0）的常量。

    伤害 = WG_ASH_DAMAGE + 主属性 * WG_ASH_STAT_MULT，由脚本（f.j 的 WG_OnAshFall）
    施加；技能本体是自带的「通道(Channel)」假技能，一点原生效果都没有。
    WG_ASH_STAT：0 = 最高属性（含装备加成）、1/2/3 = 力量/敏捷/智力。
    """
    stat = str(C.get("ash_stat", "max")).lower()
    mode = {"max": 0, "auto": 0, "str": 1, "agi": 2, "int": 3}.get(stat, 0)
    return ["// 灰烬雷暴（星魂之力的主动）：技能 ID / 马甲技能与马甲单位 / 数值 / 主属性取法",
            "integer WG_ASH_ABILITY = " + q(CFG.ABIL["act_ashfall"]),
            "integer WG_ASH_THUNDER = " + q(CFG.ABIL["ash_thunder"]),
            "integer WG_ASH_ROCKETS = " + q(CFG.ABIL["ash_rockets"]),
            "integer WG_ASH_DUMMY_THUNDER = " + q(CFG.UNITS["dummy_thunder"]),
            "integer WG_ASH_DUMMY_ROCKETS = " + q(CFG.UNITS["dummy_rockets"]),
            "// 一阶：AoE 伤害 / 属性倍率 / 半径 / 雷击环半径 / 自身回血",
            "integer WG_ASH_DAMAGE = %d" % int(C.get("ash_damage", 400)),
            "real WG_ASH_STAT_MULT = " + num(C.get("ash_stat_mult", 4.0)),
            "real WG_ASH_RADIUS = " + num(C.get("ash_radius", 500.0)),
            "real WG_ASH_RING = " + num(C.get("ash_ring", 300.0)),
            "integer WG_ASH_HEAL = %d" % int(C.get("ash_heal", 200)),
            "real WG_ASH_HEAL_MULT = " + num(C.get("ash_heal_stat_mult", 4.0)),
            "// 二阶：每次落点伤害 / 次数 / 间隔 / 进入二阶的等待时间",
            "integer WG_ASH_WAVE_DAMAGE = %d" % int(C.get("ash_wave_damage", 300)),
            "real WG_ASH_WAVE_MULT = " + num(C.get("ash_wave_stat_mult", 1.0)),
            "integer WG_ASH_WAVE_COUNT = %d" % int(C.get("ash_wave_count", 3)),
            "real WG_ASH_WAVE_INT = " + num(C.get("ash_wave_interval", 0.5)),
            "real WG_ASH_COMBO = " + num(C.get("ash_combo_window", 1.0)),
            "// 观感：屏幕震动强度 / 两个特效模型",
            "real WG_ASH_SHAKE = " + num(C.get("ash_shake", 3.0)),
            "string WG_ASH_FX = " + '"' + str(C.get("ash_fx", "Stormfall Red.mdl")) + '"',
            "string WG_ASH_FX_CASTER = " + '"' + str(C.get("ash_fx_caster", "ssw1.mdl")) + '"',
            "// 主属性取法：0 = 最高属性（含加成）；1/2/3 = 力量/敏捷/智力",
            "integer WG_ASH_STAT = %d" % mode]


def body_g_aura_runtime():
    return [
        "integer WG_FALLEN_ITEM = " + q(CFG.ITEMS["wing_fallen"]),
        "integer WG_TELEPORT_ABILITY = " + q(CFG.ABIL["act_tele"]),
        "integer WG_AVATAR_ITEM = " + q(CFG.ITEMS["wing_demon"]),
        "integer WG_AVATAR_ABILITY = " + q(CFG.ABIL["act_blink"]),
        "integer WG_AVATAR_WING_MODEL_ABILITY = "
        + q(CFG.ABIL["wing_model_demon"]),
        "integer WG_AVATAR_SPEED_ABILITY = "
        + q(CFG.ABIL["wing_speed"]),
        "integer WG_AVATAR_WING_BOOK = " + q(CFG.ABIL["book_demon"]),
        "integer WG_AVATAR_WING_COMMAND = "
        + q(CFG.ABIL["aura_command"]),
        "integer WG_AVATAR_WING_ENDURANCE = "
        + q(CFG.ABIL["aura_endur"]),
        "integer WG_AVATAR_WING_CRIT = " + q(CFG.ABIL["crit"]),
        "integer WG_AVATAR_DIVINE_DEFENSE = 6",
        "integer WG_AVATAR_CHAOS_ATTACK = 5",
        "integer WG_AVATAR_AIR_TARGET_FLAG = %d"
        % int(C.get("act_avatar_air_target_flag", 4)),
        "integer WG_AVATAR_MAGIC_IMMUNITY = 'Amim'",
        "real WG_AVATAR_DURATION = " + num(C.get("act_avatar_duration", 30.0)),
        "real WG_AVATAR_LIFE_COST_PCT = " + num(
            C.get("act_avatar_life_cost_pct", 0.20)
        ),
        "real WG_AVATAR_ATTACK_SPEED_PCT = " + num(
            C.get("act_avatar_attack_speed_pct", 1.00)
        ),
        "real WG_AVATAR_MOVE_SPEED_PCT = " + num(
            C.get("act_avatar_move_speed_pct", 1.00)
        ),
        "real WG_AVATAR_MODEL_SCALE_MULT = " + num(
            C.get("act_avatar_model_scale_mult", 3.0)
        ),
        "real WG_AVATAR_RANGE = " + num(
            C.get("act_avatar_attack_range", 550.0)
        ),
        "real WG_AVATAR_PROJECTILE_SPEED = " + num(
            C.get("act_avatar_projectile_speed", 1200.0)
        ),
        "real WG_AVATAR_ACQUIRE_RANGE = " + num(
            C.get("act_avatar_acquisition_range", 800.0)
        ),
        "real WG_AVATAR_SPLASH_FULL = " + num(
            C.get("act_avatar_splash_full", 50.0)
        ),
        "real WG_AVATAR_SPLASH_MEDIUM = " + num(
            C.get("act_avatar_splash_medium", 150.0)
        ),
        "real WG_AVATAR_SPLASH_SMALL = " + num(
            C.get("act_avatar_splash_small", 250.0)
        ),
        "real WG_AVATAR_SPLASH_MEDIUM_FACTOR = " + num(
            C.get("act_avatar_splash_medium_factor", 0.5)
        ),
        "real WG_AVATAR_SPLASH_SMALL_FACTOR = " + num(
            C.get("act_avatar_splash_small_factor", 0.25)
        ),
        "string WG_AVATAR_MISSILE = " + jstr(
            C.get(
                "act_avatar_missile",
                r"Abilities\Weapons\DemonHunterMissile"
                r"\DemonHunterMissile.mdx",
            )
        ),
        "real WG_VAMP_RADIUS = " + num(C["aura_radius"]),
        "real WG_VAMP_PERCENT = " + num(C["aura_vamp"]),
        "real WG_TELEPORT_RADIUS = " + num(C["aura_radius"]),
    ]


def body_mount_table():
    out = ["set wg_eggCount = %d" % len(CFG.MOUNTS)]
    for i, m in enumerate(CFG.MOUNTS):
        off = float(m.get("hero_h_off", 0.0))
        hero = "WG_HERO_H" if off == 0.0 else "WG_HERO_H + " + num(off)
        out += [
            "set wg_eggItem[%d] = %s" % (i, q(m["egg"])),
            "set wg_eggUnit[%d] = %s" % (i, q(m["unit"])),
            "set wg_eggOffItem[%d] = %s" % (i, q(m["off"])),
            'set wg_eggName[%d] = "%s"' % (i, m["name"]),
            "set wg_eggHeight[%d] = WG_MOUNT_H" % i,
            "set wg_eggHeroHeight[%d] = %s" % (i, hero),
            "set wg_eggScale[%d] = %s" % (i, num(m["egg_scale"])),
        ]
    return out


def all_wings():
    """真实翅膀 + 试穿翅膀 + 试穿挂件（脚本表要一起收录，`wing 试穿·…` 才认）。"""
    return (list(CFG.WINGS) + list(getattr(CFG, "TEST_WINGS", []))
            + list(getattr(CFG, "TEST_ARTS", [])))


def body_wing_table():
    wings = all_wings()
    out = ["set wg_wingCount = %d" % len(wings)]
    for i, w in enumerate(wings):
        out += [
            "set wg_wingItem[%d] = %s" % (i, q(w["item"])),
            # 试穿款没有隐藏魔法书 -> book = 0（脚本里遇到 0 会跳过）
            "set wg_wingBook[%d] = %s" % (i, q(w["book"]) if w["book"] else "0"),
            "set wg_wingBook2[%d] = %s" % (i, q(w["book2"]) if w["book2"] else "0"),
            # 名字给诊断命令用（wghp 要打印"测的是哪个翅膀"）
            'set wg_wingName[%d] = "%s"' % (i, w["name"]),
        ]
    return out


def body_wing_names():
    out = []
    for i, w in enumerate(all_wings()):
        kw = "if" if i == 0 else "elseif"
        out += ['%s WG_StrEqCI(key, "%s") or WG_StrEqCI(key, "%s") then'
                % (kw, w["name"], w["item"].lower()),
                "    call WG_AddWing(p, %s)" % q(w["item"])]
    return out


def body_wing_list():
    items = " / ".join("%s %s" % (w["item"], w["name"]) for w in all_wings())
    return ['call WG_Message(p, "翅膀: %s")' % items]


def body_wing_debug():
    out = []
    first = True
    for w in all_wings():
        ids = list(w["book_abils"]) + list(w["book2_abils"])
        if not ids:
            continue
        short = w.get("short", w["name"][:2])
        keys = list(w["book_abil_keys"]) + list(w["book2_abil_keys"])
        for j, aid in enumerate(ids):
            key = keys[j] if j < len(keys) else aid
            label = CFG.LABELS.get(key, aid)
            if first:
                head = 'set s = "技能 %s[%s" + I2S(GetUnitAbilityLevel(u, %s))' % (
                    short, label, q(aid))
                first = False
            elif j == 0:
                head = 'set s = s + " %s[%s" + I2S(GetUnitAbilityLevel(u, %s))' % (
                    short, label, q(aid))
            else:
                head = 'set s = s + " %s" + I2S(GetUnitAbilityLevel(u, %s))' % (label, q(aid))
            if j == len(ids) - 1:
                head += ' + "]"'
            out.append(head)
    return out


def body_buff_debug():
    out = []
    for i, (ref, label) in enumerate(CFG.BUFF_PROBES):
        bid = CFG.buff_probe_id(ref)
        head = 'set s = "buff %s=" + I2S(GetUnitAbilityLevel(u, %s))' % (label, q(bid)) \
            if i == 0 else 'set s = s + " %s=" + I2S(GetUnitAbilityLevel(u, %s))' % (label, q(bid))
        out.append(head)
    return out


def main():
    fj = open(FJ, "rb").read().decode("utf-8")
    gj = open(GJ, "rb").read().decode("utf-8")

    gj = rebuild(gj, "g_heights", body_g_heights())
    gj = rebuild(gj, "g_summon", body_g_summon())
    gj = rebuild(gj, "g_hand", body_g_hand())
    gj = rebuild(gj, "g_starfall", body_g_starfall())
    gj = rebuild(gj, "g_aura_runtime", body_g_aura_runtime())
    fj = rebuild(fj, "mount_table", body_mount_table())
    fj = rebuild(fj, "wing_table", body_wing_table())
    fj = rebuild(fj, "wing_names", body_wing_names())
    fj = rebuild(fj, "wing_list", body_wing_list())
    fj = rebuild(fj, "wing_debug", body_wing_debug())
    fj = rebuild(fj, "buff_debug", body_buff_debug())

    open(FJ, "wb").write(fj.encode("utf-8"))
    open(GJ, "wb").write(gj.encode("utf-8"))
    print("已生成 JASS 表: %s / %s" % (os.path.relpath(FJ, BASE), os.path.relpath(GJ, BASE)))
    return 0


if __name__ == "__main__":
    sys.exit(main())
