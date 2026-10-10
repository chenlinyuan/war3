"""从零生成 war3map.w3a，新增一个自定义主动技能（死亡之指）。

不依赖参考 w3a —— 直接构造最小条目，oldId 为基础标准技能（游戏自带），
newId 为自定义 ID。游戏会用标准技能数据补全未指定的字段。

用法:
    python gen_w3a_finger.py <输出w3a>
"""
import struct, sys, os

# 基础技能: 连锁闪电 (ACcl) —— 单位技能(X8=unit), 主动、目标敌方单位、可点击。
# 关键: 必须用"单位技能"(X8=unit)而非"英雄技能"(X8=hero), 否则 UnitAddAbility 后
#       不会出现在技能栏(英雄技能需 SelectHeroSkill 学习)。
# 用 ACcl (连锁闪电) 保留红色闪电效果 (alig=AFOD)。
# 注: ACcl 是"单位技能", 物品栏图标不显示冷却动画 (这是 War3 限制)。
BASE = "ACcl"
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


def build_new_entry(new_id, cooldown=12.0, mana=100, cast_range=800.0, name="死亡之指",
                    tooltip="死亡之指(|cffffcc00F|r)",
                    ubertip="秒杀目标单位（对魔法免疫也生效）。"):
    """返回 (baseId, newId, mods)，供其他脚本复用。"""
    # 字段类型: 0=int, 1=real, 2=unreal, 3=string
    # A = 等级(0=全局), B = 数据列索引
    # 参考真实自定义主动技能(ANcl->A00O)的字段结构
    mods = [
        # 名称 / 提示 / 图标
        mod("anam", 3, 0, 0, name),
        mod("atp1", 3, 1, 0, tooltip),
        mod("aub1", 3, 1, 0, ubertip),
        mod("aart", 3, 0, 0, ICON),
        mod("arar", 3, 0, 0, ICON),
        mod("arac", 3, 0, 0, "creeps"),
        mod("aord", 3, 0, 0, ""),
        # 快捷键 F（同阿克蒙德死亡之指）
        mod("ahky", 3, 0, 0, "F"),
        # 闪电效果 AFOD（红色闪电，同阿克蒙德死亡之指）
        mod("alig", 3, 0, 0, "AFOD"),
        # 目标类型（关键: Ncl2 是 int，不是字符串！）
        mod("Ncl2", 0, 1, 2, 1),          # 目标类型 = 单位
        mod("Ncl1", 2, 1, 1, 0.0),        # 数据列1
        mod("Ncl3", 0, 1, 3, 1),          # 数据列3
        mod("Ncl4", 2, 1, 4, 1.0),        # 数据列4
        mod("Ncl6", 3, 1, 6, ""),         # 目标允许(空=用 atar)
        mod("atar", 3, 1, 0, "air,ground,structure,enemy,neutral"),
        # 等级 1
        mod("alev", 0, 0, 0, 1),
        # 物品技能标志 (aite=1)
        mod("aite", 0, 0, 0, 1),
        mod("aher", 0, 0, 0, 0),
        # 按钮位置
        mod("abpx", 0, 0, 0, 0),
        mod("abpy", 0, 0, 0, 2),
        # 冷却 / 魔法 / 距离
        mod("acdn", 2, 1, 0, cooldown),
        mod("amcs", 0, 1, 0, mana),
        mod("aran", 2, 1, 0, cast_range),
        # 连锁闪电自带效果清零（伤害/目标数，实际秒杀由 JASS 执行）
        mod("Ocl1", 2, 1, 1, 0.0),
        mod("Ocl2", 0, 1, 2, 0),
        mod("Ocl3", 2, 1, 3, 0.0),
    ]
    return (BASE, new_id, mods)


def build(out_path, cooldown=12.0, mana=100, cast_range=800.0, name="死亡之指",
          tooltip="死亡之指(|cffffcc00D|r)", ubertip="秒杀目标单位（对魔法免疫也生效）。"):
    entry = build_new_entry(NEW, cooldown, mana, cast_range, name, tooltip, ubertip)
    mods = entry[2]
    data = struct.pack("<ii", 2, 0) + struct.pack("<i", 1)
    data += entry[0].encode("latin-1") + entry[1].encode("latin-1") + struct.pack("<i", len(mods))
    for m in mods:
        data += write_mod(m)
    open(out_path, "wb").write(data)
    print("wrote %s: %d bytes (base=%s new=%s mods=%d cd=%.1f mana=%d range=%.0f)" % (
        out_path, len(data), BASE, NEW, len(mods), cooldown, mana, cast_range))


if __name__ == "__main__":
    out = sys.argv[1] if len(sys.argv) > 1 else os.path.join(os.path.dirname(os.path.abspath(__file__)), "_finger.w3a")
    cd = float(sys.argv[2]) if len(sys.argv) > 2 else 12.0
    mana = int(sys.argv[3]) if len(sys.argv) > 3 else 100
    rng = float(sys.argv[4]) if len(sys.argv) > 4 else 800.0
    build(out, cooldown=cd, mana=mana, cast_range=rng)
