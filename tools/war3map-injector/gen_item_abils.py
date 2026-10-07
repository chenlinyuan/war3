"""生成 war3map.w3a，包含自定义物品技能（攻击力标记 + 攻击速度加成）。

基于标准物品技能：
  AIat = AttackBonus            数据字段 Iatt (int, 固定攻击力加成)
  AIsx = Attack Speed Increase  数据字段 Isx1 (unreal, 1.0 = +100%)

注意: War3 没有"被动百分比攻击力"技能。AIaa(AttackMod) 是"使用后永久加攻"，
      不是被动。故 +50% 攻击力由 JASS 脚本(IB_CritOnDamage)在普攻时追加伤害实现，
      A001 仅作为"携带手套"的标记技能(Iatt=0, 无固定加成)。

用法:
    python gen_item_abils.py <输出w3a> [标记攻击力] [攻速]
示例:
    python gen_item_abils.py _hand_abil.w3a 0 1.0
"""
import struct
import sys
import os

# 基础技能
BASE_ATTACK = "AIat"   # 攻击力加成(此处作为标记, Iatt=0)
BASE_SPEED = "AIsx"    # 攻击速度加成

# 自定义 ID
NEW_ATTACK = "A001"
NEW_SPEED = "A002"

# 图标
ICON_ATTACK = "ReplaceableTextures\\CommandButtons\\BTNSteelMelee.blp"
ICON_SPEED = "ReplaceableTextures\\CommandButtons\\BTNGlove.blp"


def mod(mid, t, a, b, v):
    return (mid, t, a, b, v, 0)


def write_mod(m):
    """w3a mod: modId(4) + type(4) + variation(4) + dataPointer(4) + value + endMarker(4)。"""
    mid, t, a, b, v, c = m
    out = mid.encode("latin-1") + struct.pack("<iii", t, a, b)
    if t == 0:
        out += struct.pack("<i", v)
    elif t in (1, 2):
        out += struct.pack("<f", v)
    elif t == 3:
        out += v.encode("utf-8") + b"\x00"
    out += struct.pack("<i", c)
    return out


def build_attack_entry(new_id, flat, name="攻击力加成", icon=ICON_ATTACK):
    """攻击力标记技能（基于 AIat）。flat: 固定加成值(0=纯标记, 百分比由脚本处理)。"""
    mods = [
        mod("anam", 3, 0, 0, name),
        mod("aart", 3, 0, 0, icon),
        mod("alev", 0, 0, 0, 1),
        # 数据字段: Iatt = 固定攻击力加成 (int)
        mod("Iatt", 0, 1, 1, int(flat)),
    ]
    return (BASE_ATTACK, new_id, mods)


def build_speed_entry(new_id, amount, name="攻击速度加成", icon=ICON_SPEED):
    """攻击速度加成技能（基于 AIsx）。"""
    mods = [
        mod("anam", 3, 0, 0, name),
        mod("aart", 3, 0, 0, icon),
        mod("alev", 0, 0, 0, 1),
        # 数据字段: Isx1 = 攻速加成比例 (unreal, 1.0 = +100%)
        mod("Isx1", 2, 1, 1, amount),
    ]
    return (BASE_SPEED, new_id, mods)


def build(out_path, attack=0, speed=1.0):
    entries = [
        build_attack_entry(NEW_ATTACK, int(attack)),
        build_speed_entry(NEW_SPEED, float(speed)),
    ]
    data = struct.pack("<ii", 2, 0) + struct.pack("<i", len(entries))
    for (base, new, mods) in entries:
        data += base.encode("latin-1") + new.encode("latin-1") + struct.pack("<i", len(mods))
        for m in mods:
            data += write_mod(m)
    open(out_path, "wb").write(data)
    print("wrote %s: %d bytes (attack=%s marker=%d, speed=%s +%.0f%%)" % (
        out_path, len(data), NEW_ATTACK, attack, NEW_SPEED, speed * 100))


if __name__ == "__main__":
    out = sys.argv[1] if len(sys.argv) > 1 else os.path.join(
        os.path.dirname(os.path.abspath(__file__)), "_hand_abil.w3a")
    atk = int(sys.argv[2]) if len(sys.argv) > 2 else 0
    spd = float(sys.argv[3]) if len(sys.argv) > 3 else 1.0
    build(out, atk, spd)
