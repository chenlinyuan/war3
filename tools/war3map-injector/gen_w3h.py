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
                    icon="BTNCorpseExplode.blp"):
    mods = [
        mod("fnam", 3, name),
        mod("ftip", 3, tip),
        mod("fube", 3, ubertip),
        mod("fart", 3, icon),
    ]
    return (BASE_BUFF, new_id, mods)


def build(out_path, name="阿克蒙德之力", tip="阿克蒙德之力",
          ubertip="增加周围友军 50% 攻击力（近战/远程均生效）。",
          icon="BTNCorpseExplode.blp"):
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
                   icon="BTNCorpseExplode.blp"):
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


if __name__ == "__main__":
    out = sys.argv[1] if len(sys.argv) > 1 else os.path.join(
        os.path.dirname(os.path.abspath(__file__)), "_hand_buff.w3h")
    nm = sys.argv[2] if len(sys.argv) > 2 else "阿克蒙德之力"
    tp = sys.argv[3] if len(sys.argv) > 3 else nm
    ub = sys.argv[4] if len(sys.argv) > 4 else "增加周围友军 50% 攻击力（近战/远程均生效）。"
    ic = sys.argv[5] if len(sys.argv) > 5 else "BTNCorpseExplode.blp"
    # 输出覆盖版（同时改原版 BEar，最可靠）
    build_override(out, nm, tp, ub, ic)
