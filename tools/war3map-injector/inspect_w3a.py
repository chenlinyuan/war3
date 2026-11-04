"""详细打印一张地图 war3map.w3a 里每条改动（改原版 / 自定义）的字段与原值。

用法: python inspect_w3a.py <地图> [wts 解析]
"""
import os
import struct
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import war3mpq as W  # noqa: E402
from merge_w3obj import read_all  # noqa: E402

HERE = os.path.dirname(os.path.abspath(__file__))


def mods_of(e):
    n = struct.unpack_from("<i", e, 8)[0]
    off = 12
    out = []
    for _ in range(n):
        mid = e[off:off + 4].decode("latin-1")
        t, lv, col = struct.unpack_from("<iii", e, off + 4)
        off += 16
        if t == 0:
            val = struct.unpack_from("<i", e, off)[0]
            off += 4
        elif t in (1, 2):
            val = struct.unpack_from("<f", e, off)[0]
            off += 4
        elif t == 3:
            end = e.index(b"\x00", off)
            val = e[off:end].decode("utf-8", "replace")
            off = end + 1
        else:
            raise ValueError("bad type %d" % t)
        off += 4
        out.append((mid, lv, col, val))
    return out


def wts_map(data):
    out = {}
    if not data:
        return out
    text = data.decode("utf-8", "replace")
    cur = None
    buf = []
    for line in text.splitlines():
        s = line.strip()
        if s.startswith("STRING "):
            cur = s.split(" ", 1)[1]
            buf = []
        elif s == "}":
            if cur:
                out[cur] = "\n".join(buf)
            cur = None
        elif cur is not None and s != "{":
            buf.append(s)
    return out


def main():
    a = W.MPQArchive(sys.argv[1])
    try:
        w3a = a.read_file("war3map.w3a")
        wts = a.read_file("war3map.wts")
    finally:
        a.close()
    if not w3a:
        print("无 w3a")
        return 1
    strs = wts_map(wts)
    p = os.path.join(HERE, "_tmp_w3a.w3a")
    open(p, "wb").write(w3a)
    ver, orig, cust = read_all(p)
    os.remove(p)
    print("w3a 版本 %s；改原版 %d 条，自定义 %d 条" % (ver, len(orig), len(cust)))

    def show(tag, e):
        ms = mods_of(e)
        d = {m[0]: m[3] for m in ms}
        name = d.get("anam", "")
        tip = d.get("atp1", "")
        if isinstance(name, str) and name.startswith("TRIGSTR_"):
            name = strs.get(name.split("_", 1)[1], name)
        if isinstance(tip, str) and tip.startswith("TRIGSTR_"):
            tip = strs.get(tip.split("_", 1)[1], tip)
        print("  %-4s %s <- %-5s %s" % (tag, e[4:8].decode("latin-1"), e[0:4].decode("latin-1"),
                                        name or "(无名字)"))
        if tip:
            print("        提示:", str(tip)[:80].replace("\n", " | "))
        for mid, lv, col, val in ms:
            if mid in ("anam", "aart", "arar", "atp1", "aub1"):
                continue
            print("        %-5s lv=%d col=%d = %s" % (mid, lv, col, val))

    for e in orig:
        show("改原版", e)
    for e in cust:
        show("自定义", e)
    return 0


if __name__ == "__main__":
    sys.exit(main())
