"""生成 war3map.w3a，包含自定义物品技能（攻击力加成 + 攻击速度加成）。

基于标准物品技能：
  AIat = AttackBonus        数据字段 Iatt (int)
  AIsx = Attack Speed Increase  数据字段 Isx1 (unreal)

用法:
    python gen_item_abils.py <输出w3a> [攻击力] [攻速]
示例:
    python gen_item_abils.py _hand_abil.w3a 500 1.0
"""
import struct
import sys
import os

# 基础技能
BASE_ATTACK = "AIat"   # 攻击力加成
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


def build_attack_entry(new_id, amount, name="攻击力加成", icon=ICON_ATTACK):
    """攻击力加成技能（基于 AIat）。"""
    mods = [
        mod("anam", 3, 0, 0, name),
        mod("aart", 3, 0, 0, icon),
        mod("alev", 0, 0, 0, 1),
        # 数据字段: Iatt = 攻击力加成值 (int)
        mod("Iatt", 0, 1, 1, amount),
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


def build(out_path, attack=500, speed=1.0):
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
    print("wrote %s: %d bytes (attack=%s+%d, speed=%s+%.2f)" % (
        out_path, len(data), NEW_ATTACK, attack, NEW_SPEED, speed))


if __name__ == "__main__":
    out = sys.argv[1] if len(sys.argv) > 1 else os.path.join(
        os.path.dirname(os.path.abspath(__file__)), "_hand_abil.w3a")
    atk = int(sys.argv[2]) if len(sys.argv) > 2 else 500
    spd = float(sys.argv[3]) if len(sys.argv) > 3 else 1.0
    build(out, atk, spd)
