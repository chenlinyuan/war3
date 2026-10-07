"""合并多个 war3map.w3a 文件（保留所有原版+自定义条目）。

用法:
    python merge_w3a.py <输出w3a> <输入1> <输入2> [...]
"""
import struct, sys, os

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))


def read_all(path):
    d = open(path, 'rb').read()
    off = 0
    ver = struct.unpack_from('<i', d, off)[0]; off += 4
    orig_n = struct.unpack_from('<i', d, off)[0]; off += 4

    def read_entry(off):
        start = off
        old = d[off:off + 4].decode('latin-1'); off += 4
        new = d[off:off + 4].decode('latin-1'); off += 4
        n = struct.unpack_from('<i', d, off)[0]; off += 4
        for _ in range(n):
            off += 4  # mid
            t = struct.unpack_from('<i', d, off)[0]; off += 4
            off += 8  # a, b
            if t == 0:
                off += 4
            elif t in (1, 2):
                off += 4
            elif t == 3:
                e = d.find(b'\x00', off); off = e + 1
            off += 4  # c
        return d[start:off], off

    orig = []
    for _ in range(orig_n):
        e, off = read_entry(off)
        orig.append(e)
    cust_n = struct.unpack_from('<i', d, off)[0]; off += 4
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
    seen_new = set()
    for p in inputs:
        ver, orig, cust = read_all(p)
        for e in orig:
            all_orig.append(e)
        for e in cust:
            # 去重: 按 newId (4..8 字节)
            nid = e[4:8]
            if nid in seen_new:
                print("跳过重复自定义条目", nid)
                continue
            seen_new.add(nid)
            all_cust.append(e)
        print("  %s: ver=%d orig=%d cust=%d" % (p, ver, len(orig), len(cust)))

    data = struct.pack("<ii", 2, len(all_orig))
    for e in all_orig:
        data += e
    data += struct.pack("<i", len(all_cust))
    for e in all_cust:
        data += e
    open(out, "wb").write(data)
    print("wrote %s: %d bytes (orig=%d cust=%d)" % (out, len(data), len(all_orig), len(all_cust)))


if __name__ == "__main__":
    sys.exit(main())
