"""从零生成 war3map.w3a，新增一个自定义主动技能（死亡之指）。

不依赖参考 w3a —— 直接构造最小条目，oldId 为基础标准技能（游戏自带），
newId 为自定义 ID。游戏会用标准技能数据补全未指定的字段。

用法:
    python gen_w3a_finger.py <输出w3a>
"""
import struct, sys, os

# 基础技能: 死亡之指 (ANfd) —— 中立单位技能(非英雄), 主动、目标单位、可点击。
# 关键: 必须用"单位技能"(AN/A+小写)而非"英雄技能"(AH), 否则 UnitAddAbility 后
#       不会出现在技能栏(英雄技能需 SelectHeroSkill 学习)。
BASE = "ANfd"
NEW = "A000"

# 图标（标准死亡之指图标，游戏自带）
ICON = "ReplaceableTextures\\CommandButtons\\BTNCorpseExplode.blp"


def mod(mid, t, a, b, v):
    """构造一个 mod 元组 (mid, type, level, fieldIndex, value, 0)。"""
    return (mid, t, a, b, v, 0)


def write_mod(m):
    mid, t, a, b, v, c = m
    out = mid.encode("latin-1") + struct.pack("<iii", t, a, b)
    if t == 0:
        out += struct.pack("<i", v)
    elif t in (1, 2):
        out += struct.pack("<f", v)
    elif t == 3:
        # 字符串按 UTF-8 存储（w3a 规范）
        out += v.encode("utf-8") + b"\x00"
    out += struct.pack("<i", c)
    return out


def build(out_path):
    # 字符串字段用 A=0（全局）；数值字段用 A=1（等级1）
    mods = [
        # 名称 / 提示 / 图标
        mod("anam", 3, 0, 0, "死亡之指"),
        mod("atp1", 3, 0, 0, "死亡之指(|cffffcc00D|r)"),
        mod("aub1", 3, 0, 0, "秒杀目标单位（对魔法免疫也生效）。"),
        mod("aart", 3, 0, 0, ICON),
        mod("arar", 3, 0, 0, ICON),
        mod("arac", 3, 0, 0, "human"),
        mod("aord", 3, 0, 0, "fingerofdeath"),
        # 目标：敌方单位（含建筑/中立）
        mod("atar", 3, 0, 0, "air,ground,structure,enemy,neutral"),
        mod("Ncl2", 3, 0, 0, ""),
        # 等级 1
        mod("alev", 0, 0, 0, 1),
        # 按钮位置（放在技能栏空位，避免与已有技能重叠）
        mod("abpx", 0, 0, 0, 0),
        mod("abpy", 0, 0, 0, 0),
        # 冷却 / 魔法 / 距离
        mod("acdn", 2, 1, 0, 1.0),
        mod("amcs", 0, 1, 0, 0),
        mod("aran", 2, 1, 0, 800.0),
        # 死亡之指自带效果清零（伤害，实际秒杀由 JASS 执行）
        mod("Nfd3", 2, 1, 3, 0.0),
    ]

    entry = BASE.encode("latin-1") + NEW.encode("latin-1") + struct.pack("<i", len(mods))
    for m in mods:
        entry += write_mod(m)

    # version=2, originalCount=0, customCount=1
    data = struct.pack("<ii", 2, 0) + struct.pack("<i", 1) + entry
    open(out_path, "wb").write(data)
    print("wrote %s: %d bytes (base=%s new=%s mods=%d)" % (out_path, len(data), BASE, NEW, len(mods)))


if __name__ == "__main__":
    out = sys.argv[1] if len(sys.argv) > 1 else os.path.join(os.path.dirname(os.path.abspath(__file__)), "_finger.w3a")
    build(out)
