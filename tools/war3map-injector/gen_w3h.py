"""生成 war3map.w3h（自定义 Buff 对象数据），用于给光环改名。

基于标准 buff BEar（强击光环 buff），新建 B000，修改名称/提示/图标。

w3h 格式同 w3t（物品）: version(4)=2 + origCount(4) + [entries] + customCount(4) + [entries]
  entry = oldId(4) + newId(4) + modCount(4) + [mods]
  mod   = modId(4) + type(4) + value + endMarker(4)   ← 1 字段 (同 w3t)

Buff 字段: fnam=名称 fnsf=后缀 ftip=提示 fube=扩展提示 fart=图标

用法:
    python gen_w3h.py <输出w3h> [名称] [提示] [扩展提示] [图标]
示例:
    python gen_w3h.py _hand_buff.w3h 阿克蒙德之力 阿克蒙德之力 "增加周围友军50%攻击力" BTNCorpseExplode.blp
"""
import struct
import sys
import os

BASE_BUFF = "BEar"   # 强击光环 buff
NEW_BUFF = "B000"


def mod(mid, t, v):
    return (mid, t, v)


def write_mod(m):
    """w3h mod: modId(4) + type(4) + value + endMarker(4)。"""
    mid, t, v = m
    out = mid.encode("latin-1") + struct.pack("<i", t)
    if t == 0:
        out += struct.pack("<i", v)
    elif t in (1, 2):
        out += struct.pack("<f", v)
    elif t == 3:
        out += v.encode("utf-8") + b"\x00"
    out += struct.pack("<i", 0)
    return out


def build_new_entry(new_id, name="阿克蒙德之力", tip="阿克蒙德之力",
                    ubertip="增加周围友军 50% 攻击力（近战/远程均生效）。",
                    icon="ReplaceableTextures\\CommandButtons\\BTNCorpseExplode.blp"):
    mods = [
        mod("fnam", 3, name),
        mod("ftip", 3, tip),
        mod("fube", 3, ubertip),
        mod("fart", 3, icon),
    ]
    return (BASE_BUFF, new_id, mods)


def build(out_path, name="阿克蒙德之力", tip="阿克蒙德之力",
          ubertip="增加周围友军 50% 攻击力（近战/远程均生效）。",
          icon="ReplaceableTextures\\CommandButtons\\BTNCorpseExplode.blp"):
    """同时输出两种方式:
      1) 自定义 buff B000 (customCount=1) —— 供光环 abuf 引用
      2) 覆盖原版 BEar (origCount=1) —— 直接改原版强击光环 buff 字符串
    这样无论游戏用哪种机制都能生效。
    """
    base, new, mods = build_new_entry(NEW_BUFF, name, tip, ubertip, icon)
    # 自定义 B000
    data = struct.pack("<ii", 2, 0) + struct.pack("<i", 1)
    data += base.encode("latin-1") + new.encode("latin-1") + struct.pack("<i", len(mods))
    for m in mods:
        data += write_mod(m)
    open(out_path, "wb").write(data)
    print("wrote %s: %d bytes (custom %s->%s mods=%d)" % (
        out_path, len(data), base, new, len(mods)))


def build_override(out_path, name="阿克蒙德之力", tip="阿克蒙德之力",
                   ubertip="增加周围友军 50% 攻击力（近战/远程均生效）。",
                   icon="ReplaceableTextures\\CommandButtons\\BTNCorpseExplode.blp"):
    """覆盖原版 BEar buff（origCount=1, oldId=newId=BEar）。"""
    _, _, mods = build_new_entry(BASE_BUFF, name, tip, ubertip, icon)
    data = struct.pack("<ii", 2, 1)  # version=2, origCount=1
    data += BASE_BUFF.encode("latin-1") + BASE_BUFF.encode("latin-1") + struct.pack("<i", len(mods))
    for m in mods:
        data += write_mod(m)
    data += struct.pack("<i", 0)  # customCount=0
    open(out_path, "wb").write(data)
    print("wrote %s: %d bytes (override %s mods=%d)" % (
        out_path, len(data), BASE_BUFF, len(mods)))


def buff_mods(name, tip, ubertip, icon):
    return [
        mod("fnam", 3, name),
        mod("ftip", 3, tip),
        mod("fube", 3, ubertip),
        mod("fart", 3, icon),
    ]


def build_multi(out_path, entries):
    """一次写多个"覆盖原版 buff"条目。

    entries: [(buffId, 名称, 提示, 扩展提示, 图标路径), ...]
    全部写进 orig 段（oldId = newId = 原版 buff ID），customCount = 0。

    注意：地图里 war3map.w3h 只有一个，**所有** buff 覆盖必须写进同一个文件，
    否则后注入的会把先前的覆盖顶掉（例如把"阿克蒙德之力"的图标弄没）。
    """
    data = struct.pack("<ii", 2, len(entries))
    for (bid, name, tip, ubertip, icon) in entries:
        mods = buff_mods(name, tip, ubertip, icon)
        data += bid.encode("latin-1") + bid.encode("latin-1") + struct.pack("<i", len(mods))
        for m in mods:
            data += write_mod(m)
    data += struct.pack("<i", 0)  # customCount
    open(out_path, "wb").write(data)
    print("wrote %s: %d bytes (%d buff overrides: %s)" % (
        out_path, len(data), len(entries), ",".join(e[0] for e in entries)))


def build_full(out_path, overrides, customs=()):
    """写 orig(覆盖原版 buff) + custom(新建 buff) 两段。

    overrides: [(buffId, 名称, 提示, 扩展提示, 图标), ...]
        ⚠ 覆盖原版 buff 时 **newId 必须写 4 个空格**！这是 WE/YDWE 的写法
        （实测 maps/sj.original、侏罗纪 的 war3map.w3h，以及伏魔战记 的 war3map.w3a
        里所有 orig 条目都是 `oldId + 四空格`）。之前写成 oldId==newId（"BoarBoar"）
        → 引擎不认，光环名称/图标都不会变。
    customs:   [(baseId, newId, 名称, 提示, 扩展提示, 图标), ...]
               也支持 (baseId, newId, mods)：需要改"挂点特效(ftat/fta1..)"这类
               额外字段时直接给字段表（灰烬雷暴的减速 buff 就是这么写的）。
        newId 用没用过的 B 打头 4 字符 ID；技能侧再用 `abuf` 指过来。
    """
    data = struct.pack("<ii", 2, len(overrides))
    for (bid, name, tip, ubertip, icon) in overrides:
        mods = buff_mods(name, tip, ubertip, icon)
        # 第二个 ID 用"和 oldId 相同"的写法 —— 这是本图**实测有效**的写法
        #   （阿克蒙德之手的光环 buff 就是这样改成功的）。
        #   真实 WE/YDWE 地图（sj.original、侏罗纪）里写的是 4 个空格；
        #   两种写法引擎都认，这里沿用在本地验证过的那种。
        data += bid.encode("latin-1") + bid.encode("latin-1") + struct.pack("<i", len(mods))
        for m in mods:
            data += write_mod(m)
    data += struct.pack("<i", len(customs))
    for ent in customs:
        if len(ent) == 3:
            # (baseId, newId, mods) —— 需要改"挂点特效"之类额外字段时用这种写法
            base, new, mods = ent
        else:
            base, new, name, tip, ubertip, icon = ent
            mods = buff_mods(name, tip, ubertip, icon)
        data += base.encode("latin-1") + new.encode("latin-1") + struct.pack("<i", len(mods))
        for m in mods:
            data += write_mod(m)
    open(out_path, "wb").write(data)
    print("wrote %s: %d bytes (orig %d: %s | custom %d: %s)" % (
        out_path, len(data), len(overrides), ",".join(e[0] for e in overrides),
        len(customs), ",".join(e[0] + ">" + e[1] for e in customs)))


# 地图里只有一个 war3map.w3h，本工程目前只写翅膀的"治疗光环" buff。
#   阿克蒙德之手(AIar→buff BEar) 的清况：2026-10-10 发现它的 BEar 覆盖条目
#   newId 写成了 "BEar"（应该写 4 个空格），**一直没生效**。但若按正确格式改 BEar，
#   会连带把原版强击光环(BEar 是所有强击光环共用的 buff，月之女祭司也会用到)
#   一起改名 → 所以这里**故意不动 BEar**，要改的话应给那件装备单独建自定义 buff。
AKMOND_ICON = "ReplaceableTextures\\CommandButtons\\BTNCorpseExplode.blp"
# 自制图标: 注入时 HKE 只认文件名(会把路径压成小写裸名), 所以走地图根目录。
#   本工程的翅膀模型(WingOfTheLucifer.MDX 等)就是根目录裸名 + 字段里写裸名, 可用。
# 2026-10-10 第三轮: 先换成**确定存在**的标准图标做验证（自制 blp 一直不显示，
#   需要判断到底是"图标文件/路径不被接受"还是"buff 根本没挂到单位身上"）。
#   下面这些名字都是从本机已解包地图的对象数据里反查出来的真实路径。
#   备选（同样是真实存在的）: BTNHeartOfAszune / BTNHealingWard / BTNRejuvenation /
#   BTNScrollOfHealing / BTNPotionRed
WING_HEAL_ICON_CUSTOM = "btnwingheal.blp"   # 自制橙色十字（暂时不用，保留）

# 配置源（移植到别的图时用 WINGS_CONFIG=<别的配置模块名>）
CFG = __import__(os.environ.get("WINGS_CONFIG", "wings_config"))
WING_HEAL_ICON = CFG.ICONS["heal"]

# 我们这几个自定义 buff 各自的**底子**（base）：只决定"从哪个原版 buff 复制字段"，
#   运行时不与原版共享任何东西 —— 这正是"独立 buff、不影响原有光环"的关键。
BUFF_BASE = {
    "akmond": "BEar",        # 强击光环(Trueshot Aura)的 buff
    "heal_native": "Boar",   # 治疗守卫的再生 buff
    "heal_show": "Babr",     # 黑曜石雕像的枯萎再生 buff
    "spell_shield": "BNss",  # 原生法术护盾的 buff
    "ash_slow": "BHtc",      # 雷霆一击的 buff（战役里 B642「灰烬之电」也是拿它当底子）
    "aura_unholy": "BUau",
    "aura_vamp": "BUav",
    "aura_brill": "BHab",
    "aura_command": "BOac",
    "aura_endur": "BOae",
    "warglaive_charge": "BHab",
}


def build_project_buffs(out_path):
    """本工程的 buff：**全部**写成"以原版 buff 为底子的自定义 buff"。

    ⚠ 2026-10-15 玩家要求：**不许覆盖原版 buff**。
      原来阿克蒙德之手的光环是去覆盖原版强击光环的 buff（BEar），副作用是
      "地图里别人的强击光环也跟着改名/换图标"（玩家实测发现）。
      现在覆盖段是**空的**：原版 BEar / Boar / Babr / BNss 一个字段都不动，
      技能侧靠 `abuf` 指向下面这些自定义 buff（状态栏图标来自自定义 buff 自己的
      `fart`；光环/护盾的**数值与行为**始终来自挂它的那个技能本身）。
    """
    charge_buff_name = getattr(
        CFG, "WARGLAIVE_CHARGE_BUFF_NAME", "邪焰冲锋"
    )
    plan = [
        ("akmond", "阿克蒙德之力", "阿克蒙德之力",
         CFG.AKMOND_BUFF_TEXT, CFG.ICONS["akmond"]),
        ("heal_native", "治疗光环", "治疗光环",
         CFG.HEAL_BUFF_TEXT, WING_HEAL_ICON),
        ("heal_show", "治疗光环", "治疗光环",
         CFG.HEAL_BUFF_TEXT, WING_HEAL_ICON),
        ("spell_shield", "法术护盾", "法术护盾",
         CFG.SHIELD_BUFF_TEXT, CFG.ICONS["star"]),
        ("aura_unholy", "邪恶光环", "邪恶光环",
         CFG.UNHOLY_BUFF_TEXT,
         r"ReplaceableTextures\CommandButtons\BTNUnholyAura.blp"),
        ("aura_vamp", "吸血光环", "吸血光环",
         CFG.VAMP_BUFF_TEXT,
         r"ReplaceableTextures\CommandButtons\BTNVampiricAura.blp"),
        ("aura_brill", "辉煌光环", "辉煌光环",
         CFG.BRILL_BUFF_TEXT,
         r"ReplaceableTextures\CommandButtons\BTNBrilliance.blp"),
        ("aura_command", "命令光环", "命令光环",
         CFG.COMMAND_BUFF_TEXT,
         r"ReplaceableTextures\CommandButtons\BTNGnollCommandAura.blp"),
        ("aura_endur", "耐久光环", "耐久光环",
         CFG.ENDUR_BUFF_TEXT,
         r"ReplaceableTextures\CommandButtons\BTNCommand.blp"),
        ("warglaive_charge", charge_buff_name, charge_buff_name,
         CFG.WARGLAIVE_CHARGE_BUFF_TEXT,
         r"ReplaceableTextures\CommandButtons\BTNGarrekCharge.blp"),
    ]
    customs = [(BUFF_BASE[key], CFG.BUFFS[key], buff_mods(nm, tp, ub, ic))
               for (key, nm, tp, ub, ic) in plan]
    # 灰烬雷暴一阶的减速 buff：**照抄战役里的 B642「灰烬之电」**
    #   （底子 BHtc = 原版雷霆一击的 buff；字段：名字/说明/图标 + ftac=3 个挂点特效）
    #   ⚠ 这里的"挂点特效"就是玩家看到的"被雷劈中"的样子：
    #     眩晕图腾 + 雷霆一击 + 我们自己注入的 StormfallRed.mdx。
    #     HKE 注入时只保留文件名并压成小写，所以第三个特效写**裸名**。
    customs.append((BUFF_BASE["ash_slow"], CFG.BUFFS["ash_slow"], [
        mod("fnam", 3, CFG.ASH_SLOW_BUFF_NAME),
        mod("ftip", 3, CFG.ASH_SLOW_BUFF_TIP),
        mod("fube", 3, CFG.ASH_SLOW_BUFF_TEXT),
        mod("ftac", 0, 3),
        mod("ftat", 3, CFG.ASH_SLOW_BUFF_FX),
        mod("fta1", 3, "origin"),
        mod("fta2", 3, "origin"),
        mod("fart", 3, CFG.ICONS["star"]),
    ]))
    build_full(out_path, [], customs)


if __name__ == "__main__":
    out = sys.argv[1] if len(sys.argv) > 1 else os.path.join(
        os.path.dirname(os.path.abspath(__file__)), "_hand_buff.w3h")
    nm = sys.argv[2] if len(sys.argv) > 2 else "阿克蒙德之力"
    tp = sys.argv[3] if len(sys.argv) > 3 else nm
    ub = sys.argv[4] if len(sys.argv) > 4 else "增加周围友军 50% 攻击力（近战/远程均生效）。"
    ic = sys.argv[5] if len(sys.argv) > 5 else "ReplaceableTextures\\CommandButtons\\BTNCorpseExplode.blp"
    # 输出覆盖版（同时改原版 BEar，最可靠）
    build_override(out, nm, tp, ub, ic)
