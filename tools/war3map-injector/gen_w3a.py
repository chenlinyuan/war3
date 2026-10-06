"""生成 war3map.w3a，新增一个自定义主动技能（用于"死亡之指"技能栏图标）。

基础技能: 从参考 w3a 中复制一个完整的主动技能条目，改 ID/名称/图标。

用法:
    python gen_w3a.py <参考w3a> <输出w3a> <基础技能ID> <新技能ID> <名称> <提示> <图标>
"""
import struct, sys, os

HERE = os.path.dirname(os.path.abspath(__file__))


def parse_w3a(path):
    """返回 (version, original_entries, custom_entries)。"""
    d = open(path, "rb").read()
    off = 0
    version = struct.unpack_from("<i", d, off)[0]; off += 4
    orig_n = struct.unpack_from("<i", d, off)[0]; off += 4

    def read_entry(off):
        old = d[off:off + 4].decode("latin-1"); off += 4
        new = d[off:off + 4].decode("latin-1"); off += 4
        n = struct.unpack_from("<i", d, off)[0]; off += 4
        mods = []
        for _ in range(n):
            mid = d[off:off + 4].decode("latin-1"); off += 4
            t = struct.unpack_from("<i", d, off)[0]; off += 4
            a = struct.unpack_from("<i", d, off)[0]; off += 4
            b = struct.unpack_from("<i", d, off)[0]; off += 4
            if t == 0:
                v = struct.unpack_from("<i", d, off)[0]; off += 4
            elif t in (1, 2):
                v = struct.unpack_from("<f", d, off)[0]; off += 4
            elif t == 3:
                e = d.find(b"\x00", off); v = d[off:e].decode("latin-1"); off = e + 1
            else:
                raise ValueError("type %d" % t)
            c = struct.unpack_from("<i", d, off)[0]; off += 4
            mods.append((mid, t, a, b, v, c))
        return (old, new, mods), off

    orig = []
    for _ in range(orig_n):
        e, off = read_entry(off)
        orig.append(e)
    cust_n = struct.unpack_from("<i", d, off)[0]; off += 4
    cust = []
    for _ in range(cust_n):
        e, off = read_entry(off)
        cust.append(e)
    return version, orig, cust


def write_mod(mid, t, a, b, v, c):
    out = mid.encode("latin-1")
    out += struct.pack("<iii", t, a, b)
    if t == 0:
        out += struct.pack("<i", v)
    elif t in (1, 2):
        out += struct.pack("<f", v)
    elif t == 3:
        out += v.encode("latin-1") + b"\x00"
    out += struct.pack("<i", c)
    return out


def write_entry(old, new, mods):
    out = old.encode("latin-1") + new.encode("latin-1") + struct.pack("<i", len(mods))
    for m in mods:
        out += write_mod(*m)
    return out


def build(reference_w3a, base_id, new_id, name, tooltip, icon, out_path,
          mana=0, cooldown=1.0, cast_range=800.0, order="fingerofdeath"):
    """从参考 w3a 复制 base_id 条目，生成只含 new_id 的 w3a。"""
    version, orig, cust = parse_w3a(reference_w3a)

    # 找基础技能条目
    base_mods = None
    for old, new, mods in orig + cust:
        if old == base_id:
            base_mods = mods
            break
    if base_mods is None:
        raise SystemExit("参考 w3a 中未找到基础技能 %s" % base_id)

    # 复制 mods，覆盖关键字段
    mods = list(base_mods)

    def set_mod(mid, t, a, b, v):
        """替换或追加一个 mod（同 mid+a 视为同一条）。"""
        for i, m in enumerate(mods):
            if m[0] == mid and m[2] == a:
                mods[i] = (mid, t, a, b, v, 0)
                return
        mods.append((mid, t, a, b, v, 0))

    # 名称/提示/图标（字符串，A=0 表示全局）
    set_mod("anam", 3, 0, 0, name)
    set_mod("atp1", 3, 0, 0, tooltip)
    set_mod("aub1", 3, 0, 0, tooltip)
    set_mod("aart", 3, 0, 0, icon)
    set_mod("arar", 3, 0, 0, icon)
    # 等级 1
    set_mod("alev", 0, 0, 0, 1)
    # 魔法/冷却/距离
    set_mod("amcs", 0, 1, 0, mana)
    set_mod("acdn", 2, 1, 0, cooldown)
    set_mod("aran", 2, 1, 0, cast_range)
    set_mod("aord", 3, 0, 0, order)
    # 目标允许: 敌方单位（含魔免）
    set_mod("atar", 3, 1, 0, "air,ground,structure,enemy,neutral")

    entry = write_entry(base_id, new_id, mods)

    # 输出: version=2, originalCount=0, customCount=1
    data = struct.pack("<ii", 2, 0) + struct.pack("<i", 1) + entry
    open(out_path, "wb").write(data)
    print("wrote %s: %d bytes, base=%s new=%s mods=%d" % (
        out_path, len(data), base_id, new_id, len(mods)))


if __name__ == "__main__":
    if len(sys.argv) < 8:
        print(__doc__)
        sys.exit(1)
    build(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4],
          sys.argv[5], sys.argv[6], sys.argv[7])
