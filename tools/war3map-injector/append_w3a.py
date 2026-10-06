"""把自定义技能追加到已有的 war3map.w3a（保留原有条目）。

用法:
    python append_w3a.py <原w3a> <输出w3a> <新技能ID> [冷却] [蓝耗] [距离]

新技能基于 ACcl(连锁闪电, 单位技能)，效果由 JASS 执行。
"""
import struct, sys, os

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from gen_w3a import parse_w3a, write_entry
from gen_w3a_finger import BASE, ICON, mod, write_mod


def build_new_entry(new_id, cooldown, mana, cast_range):
    mods = [
        mod("anam", 3, 0, 0, "死亡之指"),
        mod("atp1", 3, 1, 0, "死亡之指(|cffffcc00D|r)"),
        mod("aub1", 3, 1, 0, "秒杀目标单位（对魔法免疫也生效）。"),
        mod("aart", 3, 0, 0, ICON),
        mod("arar", 3, 0, 0, ICON),
        mod("arac", 3, 0, 0, "creeps"),
        mod("aord", 3, 0, 0, ""),
        mod("Ncl2", 0, 1, 2, 1),
        mod("Ncl1", 2, 1, 1, 0.0),
        mod("Ncl3", 0, 1, 3, 1),
        mod("Ncl4", 2, 1, 4, 1.0),
        mod("Ncl6", 3, 1, 6, ""),
        mod("atar", 3, 1, 0, "air,ground,structure,enemy,neutral"),
        mod("alev", 0, 0, 0, 1),
        mod("abpx", 0, 0, 0, 0),
        mod("abpy", 0, 0, 0, 2),
        mod("acdn", 2, 1, 0, cooldown),
        mod("amcs", 0, 1, 0, mana),
        mod("aran", 2, 1, 0, cast_range),
        mod("Ocl1", 2, 1, 1, 0.0),
        mod("Ocl2", 0, 1, 2, 0),
        mod("Ocl3", 2, 1, 3, 0.0),
    ]
    return (BASE, new_id, mods)


def main():
    if len(sys.argv) < 4:
        print(__doc__)
        return 1
    src = sys.argv[1]
    out = sys.argv[2]
    new_id = sys.argv[3]
    cd = float(sys.argv[4]) if len(sys.argv) > 4 else 12.0
    mana = int(sys.argv[5]) if len(sys.argv) > 5 else 100
    rng = float(sys.argv[6]) if len(sys.argv) > 6 else 800.0

    version, orig, cust = parse_w3a(src)
    # 检查 ID 冲突
    used = set(n for o, n, m in cust) | set(o for o, n, m in orig)
    if new_id in used:
        raise SystemExit("ID %s 已被占用" % new_id)

    new_entry = build_new_entry(new_id, cd, mana, rng)

    # 重建: version + origCount + orig... + customCount+1 + cust... + 新条目
    data = struct.pack("<ii", version, len(orig))
    for o, n, m in orig:
        data += write_entry(o, n, m)
    data += struct.pack("<i", len(cust) + 1)
    for o, n, m in cust:
        data += write_entry(o, n, m)
    data += write_entry(*new_entry)

    open(out, "wb").write(data)
    print("wrote %s: %d bytes (原 %d 自定义 + 新增 1 = %d)" % (
        out, len(data), len(cust), len(cust) + 1))


if __name__ == "__main__":
    sys.exit(main())
