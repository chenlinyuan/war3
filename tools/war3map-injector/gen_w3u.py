"""生成 war3map.w3u，新增 5 个自定义飞行坐骑单位（完全照抄伏魔战记）。

伏魔战记的自定义坐骑单位 (unitdata.slk / unitui.slk 等):
  n02L 青铜龙  file=units\\creeps\\BronzeDragon\\BronzeDragon   sound=AzureDragon  defType=large  abil=Alit
  n02M 黑龙    file=units\\creeps\\BlackDragon\\BlackDragon     sound=AzureDragon  defType=large  abil=-
  n02N 蓝龙    file=units\\creeps\\AzureDragon\\AzureDragon     sound=AzureDragon  defType=large  abil=Afrb
  n02P 红龙    file=units\\creeps\\RedDragon\\RedDragon         sound=AzureDragon  defType=large  abil=-
  h01D 凤凰    file=units\\human\\phoenix\\phoenix              sound=Phoenix      defType=small  abil=Apxf

关键差异 (相对游戏自带单位):
  - 单位类别 race=orc, 移动类型 movetp=foot (地面寻路 + 抬升), moveHeight=325(龙)/240(凤凰)
  - turnRate=.1(龙)/.4(凤凰), targType=air, armor=Flesh, unitShadow=ShadowFlyer

本工程用游戏自带单位作为基础 (oldId), 覆盖上述字段生成自定义单位 (newId)。
基础单位与模型一一对应:
  nbzd(BronzeDragon) -> 青铜龙, nbwm(BlackDragon) -> 黑龙, nadr(AzureDragon) -> 蓝龙,
  nrwm(RedDragon) -> 红龙, hphx(phoenix) -> 凤凰

用法:
    python gen_w3u.py [输出w3u]
"""
import struct
import sys
import os

HERE = os.path.dirname(os.path.abspath(__file__))

# 字段类型: 0=int, 1=real, 2=unreal, 3=string
# 单位字段 ID (来自 unitmetadata.slk, useUnit=1):
#   umdl=模型 usca=模型缩放 ussc=缩放 uble=混合
#   umvt=移动类型 umvh=移动高度 umvf=移动地板 umvr=转向速率 uprw=推进窗口
#   uori=朝向插值 ufor=阵型 utar=目标类型 upoi=点数 ufle=可逃跑 upri=优先级
#   udtm=死亡时间 urac=种族 usnd=单位音效 unam=名称 uarm=护甲类型 ushu=单位阴影
#   uabi=技能列表 udty=护甲类型(防御) uhrt=回复类型 ubdg=建筑 ucol=碰撞 umvs=速度
#   uhpm=生命值 usid=视野
MODS = {
    "umdl": 3, "usca": 1, "ussc": 1, "uble": 1, "ushw": 1, "ushh": 1,
    "umvt": 3, "umvh": 2, "umvf": 2, "umvr": 2, "uprw": 2,
    "uori": 0, "ufor": 0, "utar": 3, "upoi": 0, "ufle": 0, "upri": 0,
    "udtm": 2, "urac": 3, "usnd": 3, "unam": 3, "uarm": 3, "ushu": 3,
    "uabi": 3, "udty": 3, "uhrt": 3,
    # 本次修复新增:
    #   ufoo = "Stats - Food Used"(人口), 不写就继承基础单位(4 条龙 = 8 人口/只)
    #   ua1p = "Combat - Attack 1 - Area of Effect Targets"(溅射目标类型)
    #          不写就继承基础单位(只有 ground, 不含 enemy -> 溅射会打到友军/骑乘英雄)
    #   ua1b = "Combat - Attack 1 - Damage Base"(基础攻击力), 伏魔战记所有坐骑 = 350
    #   ua1t = "Combat - Attack 1 - Attack Type"(攻击类型), 伏魔战记所有坐骑 = chaos
    #   uhpr = "Stats - Hit Point Regeneration"(每秒回血), 不写就继承基础单位
    #          —— 凤凰 hphx 的 regenHP = **-25**(每秒掉 25 血!), 1250 血约 50 秒掉死;
    #          而且 SetUnitInvulnerable 挡不住掉血, 所以坐骑会"过一会儿自己死"。
    "ufoo": 0, "ua1p": 3, "ua1b": 0, "ua1t": 3, "uhpr": 2,
}


def write_mod(mid, t, v):
    """w3u mod: modId(4) + type(4) + value + endMarker(4=0)。无 level/column。"""
    out = mid.encode("latin-1") + struct.pack("<i", t)
    if t == 0:
        out += struct.pack("<i", v)
    elif t in (1, 2):
        out += struct.pack("<f", v)
    elif t == 3:
        out += v.encode("utf-8") + b"\x00"
    else:
        raise ValueError("bad type %d" % t)
    out += struct.pack("<i", 0)
    return out


def write_entry(old, new, mods):
    out = old.encode("latin-1") + new.encode("latin-1") + struct.pack("<i", len(mods))
    for mid, t, v in mods:
        out += write_mod(mid, t, v)
    return out


def m(mid, v):
    return (mid, MODS[mid], v)


# 溅射目标类型: 取自游戏自带凤凰 hphx 的 unitweapons.slk 值, 只打敌方。
#   (伏魔战记写的是 "enemies"; 游戏数据里的合法标记是 "enemy")
SPLASH_ENEMY = "ground,structure,debris,air,enemy"

# 与伏魔战记一致: 所有坐骑统一 350 基础攻击 + chaos 攻击类型
#   (游戏自带龙类基础攻击只有 42~45, 不覆盖的话坐骑几乎没有伤害)
MOUNT_DMG_BASE = 350
MOUNT_ATK_TYPE = "chaos"

# 每秒回血 (与伏魔战记的龙一致: +2)。凤凰基础值是 -25, 必须覆盖, 否则坐骑会自己掉血死。
MOUNT_HP_REGEN = 2.0

# 5 个坐骑定义: (基础单位, 新单位ID, 模型, 音效, 防御类型, 技能, 移动高度, 转向速率,
#              死亡时间, modelScale, scale, 溅射目标)
#   ⚠ 技能列表保持和伏魔战记一致(Alit / 空 / Afrb / 空 / Apxf)。
#     2026-10-10 第八轮曾把治疗光环 W074 挂到坐骑上试"载体"这条路 —— 玩家指出
#     治疗光环是**翅膀的效果**, 不该依赖坐骑, 已回退(治疗光环回到英雄的魔法书里)。
MOUNTS = [
    # 青铜龙 (n02L)
    ("nbzd", "n02L", r"units\creeps\BronzeDragon\BronzeDragon", "AzureDragon",
     "large", "Alit", 325.0, 0.1, 3.0, 1.75, 2.25, SPLASH_ENEMY),
    # 黑龙 (n02M)
    ("nbwm", "n02M", r"units\creeps\BlackDragon\BlackDragon", "AzureDragon",
     "large", "", 325.0, 0.1, 3.0, 1.75, 2.25, SPLASH_ENEMY),
    # 蓝龙 (n02N)
    ("nadr", "n02N", r"units\creeps\AzureDragon\AzureDragon", "AzureDragon",
     "large", "Afrb", 325.0, 0.1, 3.0, 1.75, 2.25, SPLASH_ENEMY),
    # 红龙 (n02P)
    ("nrwm", "n02P", r"units\creeps\RedDragon\RedDragon", "AzureDragon",
     "large", "", 325.0, 0.1, 3.0, 1.75, 2.25, SPLASH_ENEMY),
    # 凤凰 (h01D)
    ("hphx", "h01D", r"units\human\phoenix\phoenix", "Phoenix",
     "small", "Apxf", 240.0, 0.4, 0.7, 1.0, 1.5, SPLASH_ENEMY),
]


def build(out_path, foot=True):
    """生成 w3u。foot=True 用 movetp=foot (完全同伏魔战记); False 用 fly。"""
    entries = []
    for (base, new, model, sound, defty, abil, mvheight, turnrate, deathtime,
         mscale, ussc, splash) in MOUNTS:
        mods = [
            m("umdl", model),
            m("usca", mscale),
            m("ussc", ussc),
            # 不占人口 (龙基础单位是一个 8 人口的爬虫单位)
            m("ufoo", 0),
            # 溅射只打敌人 (基础龙类的溅射目标表里没有 enemy -> 会溅到英雄)
            m("ua1p", splash),
            # 攻击力 / 攻击类型 (对齐伏魔战记: 350 + chaos)
            m("ua1b", MOUNT_DMG_BASE),
            m("ua1t", MOUNT_ATK_TYPE),
            # 每秒回血 (覆盖凤凰的 -25, 否则约 50 秒后坐骑自己掉血死)
            m("uhpr", MOUNT_HP_REGEN),
            # 技能列表: 空字符串也要写 (表示"没有技能"; 伏魔战记的黑龙/红龙就是空的)
            m("uabi", abil),
            m("uble", 0.15),
            m("ushw", 300.0),
            m("ushh", 300.0),
            m("usnd", sound),
            m("uarm", "Flesh"),
            m("ushu", "ShadowFlyer"),
            m("udty", defty),
            m("uhrt", "always"),
            m("urac", "orc"),
            m("utar", "air"),
            m("umvt", "foot" if foot else "fly"),
            m("umvh", mvheight),
            m("umvf", 90.0),
            m("umvr", turnrate),
            m("uprw", 61.0),
            m("uori", 3 if defty == "large" else 1),
            m("ufor", 2),
            m("upoi", 100),
            m("ufle", 1),
            m("upri", 2),
            m("udtm", deathtime),
        ]
        entries.append(write_entry(base, new, mods))

    data = struct.pack("<ii", 2, 0) + struct.pack("<i", len(entries))
    for e in entries:
        data += e
    open(out_path, "wb").write(data)
    print("wrote", out_path, len(data), "bytes,", len(entries), "mounts")


if __name__ == "__main__":
    out = sys.argv[1] if len(sys.argv) > 1 else os.path.join(HERE, "_wing_unit.w3u")
    foot = "--fly" not in sys.argv
    build(out, foot=foot)
