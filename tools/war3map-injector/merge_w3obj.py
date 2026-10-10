"""合并多个 war3map.w3t / w3a 文件（保留所有原版+自定义条目，按 newId 去重）。

用法:
    python merge_w3obj.py <输出> <输入1> <输入2> [...]

自动探测格式:
  w3a/w3q: modId(4)+type(4)+level(4)+column(4)+value+endMarker(4)
  w3t/w3u/w3h/w3b/w3d: modId(4)+type(4)+value+endMarker(4)
"""
import struct, sys, os

HAS_LEVEL_COLUMN = {"w3a", "w3q"}


def read_all(path):
    d = open(path, "rb").read()
    ext = path.rsplit(".", 1)[-1].lower()
    has_lc = ext in HAS_LEVEL_COLUMN
    off = 0
    ver = struct.unpack_from("<i", d, off)[0]; off += 4
    orig_n = struct.unpack_from("<i", d, off)[0]; off += 4

    def read_entry(off):
        start = off
        off += 4  # old
        off += 4  # new
        n = struct.unpack_from("<i", d, off)[0]; off += 4
        for _ in range(n):
            off += 4  # mid
            t = struct.unpack_from("<i", d, off)[0]; off += 4
            if has_lc:
                off += 8  # level, column
            if t == 0:
                off += 4
            elif t in (1, 2):
                off += 4
            elif t == 3:
                e = d.find(b"\x00", off); off = e + 1
            else:
                raise ValueError("bad type %d at off %d" % (t, off))
            off += 4  # endMarker
        return d[start:off], off

    orig = []
    for _ in range(orig_n):
        e, off = read_entry(off)
        orig.append(e)
    cust_n = struct.unpack_from("<i", d, off)[0]; off += 4
    cust = []
    for _ in range(cust_n):
        e, off = read_entry(off)
        cust.append(e)
    return ver, orig, cust


def main():
    if len(sys.argv) < 3:
        print(__doc__)
        return 1
    out = sys.argv[1]
    inputs = sys.argv[2:]

    all_orig = []
    all_cust = []
    seen = set()
    for p in inputs:
        ver, orig, cust = read_all(p)
        for e in orig + cust:
            new_id = e[4:8]
            if new_id in seen:
                continue
            seen.add(new_id)
            all_cust.append(e)

    # 输出: version=2, origCount=0, customCount=N
    data = struct.pack("<ii", 2, 0) + struct.pack("<i", len(all_cust))
    for e in all_cust:
        data += e
    open(out, "wb").write(data)
    print("merged %d entries -> %s (%d bytes)" % (len(all_cust), out, len(data)))
    for e in all_cust:
        print("   %s -> %s" % (e[:4].decode("latin-1"), e[4:8].decode("latin-1")))
    return 0


if __name__ == "__main__":
    sys.exit(main())
