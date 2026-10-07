"""生成 war3map.w3t，新增一个自定义物品（装备）。

从零构造最小条目：oldId 为基础标准物品（游戏自带），newId 为自定义 ID。
游戏会用基础物品数据补全未指定的字段。

用法:
    python gen_w3t.py <输出w3t> [--base gcel] [--new I000] [--name 阿克蒙德之手]

字段 ID 参考 docs/03-对象数据/物品与升级.md：
    inam=名称  ides=描述  itip=基础提示  iutb=扩展提示
    icla=分类  ilev=等级  igol=金币  ihtp=生命
    iabi=技能列表(逗号分隔)  iico=图标  ifil=模型
    iusa=主动使用  iuse=使用次数  idro=可丢弃  ipaw=可出售
"""
import struct
import sys
import os

# 基础物品: gcel = Gloves of Haste (加速手套), abilList=AIsx
DEFAULT_BASE = "gcel"
DEFAULT_NEW = "I000"

# 图标
ICON = "ReplaceableTextures\\CommandButtons\\BTNCorpseExplode.blp"

# 技能: A001=攻击力加成(+500), A002=攻击速度加成(+100%), A000=自定义死亡之指(1M伤害)
# 注意: 物品技能必须用逗号分隔。A000/A001/A002 需在 w3a 中定义(本工程注入 _lt_hand.w3a)。
ABILITY_LIST = "A001,A002,A000"


def mod(mid, t, a, b, v):
    """构造一个 mod 元组 (mid, type, level, fieldIndex, value, 0)。

    注意: w3t (物品) 的 mod 格式与 w3a (技能) 不同!
      w3a: modId(4) + type(4) + variation(4) + dataPointer(4) + value + endMarker(4)
      w3t: modId(4) + type(4) + value + endMarker(4)   ← 只有 1 个字段
    本函数保留 (mid,t,a,b,v,c) 签名以便复用, 但 write_mod 只写 type。
    """
    return (mid, t, a, b, v, 0)


def write_mod(m):
    """w3t mod: modId(4) + type(4) + value + endMarker(4)。"""
    mid, t, a, b, v, c = m
    out = mid.encode("latin-1") + struct.pack("<i", t)
    if t == 0:
        out += struct.pack("<i", v)
    elif t in (1, 2):
        out += struct.pack("<f", v)
    elif t == 3:
        # 字符串按 UTF-8 存储（w3t 规范）
        out += v.encode("utf-8") + b"\x00"
    out += struct.pack("<i", c)
    return out


def build_new_entry(new_id, name="阿克蒙德之手",
                    tip="阿克蒙德之手",
                    ubertip="增加英雄 50% 攻击力与 100% 攻击速度。|n主动使用：死亡之指（秒杀目标单位）。",
                    desc="增加英雄 50% 攻击力与 100% 攻击速度，可主动释放死亡之指。",
                    icon=ICON, abilities=ABILITY_LIST,
                    base_id=DEFAULT_BASE, level=8, gold=1000, hp=75,
                    class_="Artifact", hotkey="F"):
    """返回 (baseId, newId, mods)，供其他脚本复用。"""
    # 字段类型: 0=int, 1=real, 2=unreal, 3=string
    # A = 等级(0=全局), B = 数据列索引
    # 注意: WC3 物品对象数据的名称/提示字段 ID 与单位共用 unam/utip/utub
    #       (文档里的 inam/itip/iutb 是错的, 实测游戏读 unam)。
    mods = [
        mod("unam", 3, 0, 0, name),
        mod("utip", 3, 0, 0, tip),
        mod("utub", 3, 0, 0, ubertip),
        mod("ides", 3, 0, 0, desc),
        mod("ihot", 3, 0, 0, hotkey),
        mod("iico", 3, 0, 0, icon),
        mod("icla", 3, 0, 0, class_),
        mod("ilev", 0, 0, 0, level),
        mod("igol", 0, 0, 0, gold),
        mod("ihtp", 0, 0, 0, hp),
        # 技能列表（关键）
        mod("iabi", 3, 0, 0, abilities),
        # 可主动使用（死亡之指）
        mod("iusa", 0, 0, 0, 1),
    ]
    return (base_id, new_id, mods)


def build(out_path, base_id=DEFAULT_BASE, new_id=DEFAULT_NEW, **kw):
    entry = build_new_entry(new_id, base_id=base_id, **kw)
    mods = entry[2]
    data = struct.pack("<ii", 2, 0) + struct.pack("<i", 1)
    data += entry[0].encode("latin-1") + entry[1].encode("latin-1") + struct.pack("<i", len(mods))
    for m in mods:
        data += write_mod(m)
    open(out_path, "wb").write(data)
    print("wrote %s: %d bytes (base=%s new=%s mods=%d abil=%s)" % (
        out_path, len(data), base_id, new_id, len(mods), ABILITY_LIST))


if __name__ == "__main__":
    out = os.path.join(os.path.dirname(os.path.abspath(__file__)), "_hand.w3t")
    args = sys.argv[1:]
    if args and not args[0].startswith("--"):
        out = args[0]
        args = args[1:]
    kw = {}
    i = 0
    while i < len(args):
        if args[i] == "--base":
            kw["base_id"] = args[i + 1]; i += 2
        elif args[i] == "--new":
            kw["new_id"] = args[i + 1]; i += 2
        elif args[i] == "--name":
            kw["name"] = args[i + 1]; i += 2
        else:
            i += 1
    build(out, **kw)
