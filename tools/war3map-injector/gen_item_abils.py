"""生成 war3map.w3a，包含自定义物品技能（攻击力百分比光环 + 攻击速度加成）。

基于标准物品技能：
  AIar = ItemAuraTrueshot (物品版强击光环)  数据字段 Ear1 (unreal, 0.5 = +50%)
  AIsx = Attack Speed Increase              数据字段 Isx1 (unreal, 1.0 = +100%)

强击光环是 War3 标准的**百分比攻击力光环**，装备时被动生效（无需脚本）。

用法:
    python gen_item_abils.py <输出w3a> [攻击力百分比] [攻速]
示例:
    python gen_item_abils.py _hand_abil.w3a 0.5 1.0
"""
import struct
import sys
import os

# 基础技能
BASE_ATTACK = "AIar"   # 物品版强击光环 (百分比攻击力)
BASE_SPEED = "AIsx"    # 攻击速度加成

# 自定义 ID
NEW_ATTACK = "A001"
NEW_SPEED = "A002"

# 图标
ICON_ATTACK = "ReplaceableTextures\\CommandButtons\\BTNCorpseExplode.blp"
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


def build_attack_entry(new_id, percent, name="阿克蒙德之力",
                       tooltip="阿克蒙德之力",
                       ubertip="增加周围友军 50% 攻击力（近战/远程均生效）。",
                       icon=ICON_ATTACK):
    """攻击力百分比光环技能（基于 AIar ItemAuraTrueshot）。percent: 0.5 = +50%。

    强击光环字段 (AEar 默认值): Ear1=攻击力%(0.1), Ear2=近战开关(0), Ear3=远程开关(1)。
    原版只对远程生效(Ear2=0,Ear3=1)。这里显式开启近战(Ear2=1)与远程(Ear3=1)，
    使近战英雄装备时也享受加成。
    """
    mods = [
        mod("anam", 3, 0, 0, name),
        mod("atp1", 3, 1, 0, tooltip),
        mod("aub1", 3, 1, 0, ubertip),
        mod("aart", 3, 0, 0, icon),
        mod("arar", 3, 0, 0, icon),
        mod("alev", 0, 0, 0, 1),
        # 关联自定义 buff B000（光环的提示/名称来自 buff）
        mod("abuf", 3, 0, 0, "B000"),
        # 数据字段: Ear1 = 攻击力加成百分比 (unreal, 0.5 = +50%)
        mod("Ear1", 2, 1, 1, float(percent)),
        # Ear2 = 近战加成开关 (bool, 1=开启)
        mod("Ear2", 0, 1, 2, 1),
        # Ear3 = 远程加成开关 (bool, 1=开启)
        mod("Ear3", 0, 1, 3, 1),
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


def build(out_path, attack=0.5, speed=1.0):
    entries = [
        build_attack_entry(NEW_ATTACK, float(attack)),
        build_speed_entry(NEW_SPEED, float(speed)),
    ]
    data = struct.pack("<ii", 2, 0) + struct.pack("<i", len(entries))
    for (base, new, mods) in entries:
        data += base.encode("latin-1") + new.encode("latin-1") + struct.pack("<i", len(mods))
        for m in mods:
            data += write_mod(m)
    open(out_path, "wb").write(data)
    print("wrote %s: %d bytes (attack=%s +%.0f%%, speed=%s +%.0f%%)" % (
        out_path, len(data), NEW_ATTACK, attack * 100, NEW_SPEED, speed * 100))


if __name__ == "__main__":
    out = sys.argv[1] if len(sys.argv) > 1 else os.path.join(
        os.path.dirname(os.path.abspath(__file__)), "_hand_abil.w3a")
    atk = float(sys.argv[2]) if len(sys.argv) > 2 else 0.5
    spd = float(sys.argv[3]) if len(sys.argv) > 3 else 1.0
    build(out, atk, spd)
