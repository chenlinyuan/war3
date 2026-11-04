import os
import struct
import sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from merge_w3obj import read_all

def entries(path):
    ver, orig, cust = read_all(path)
    out = {}
    for e in orig + cust:
        nid = e[4:8].decode("latin-1")
        n = struct.unpack_from("<i", e, 8)[0]
        off = 12
        mods = []
        for _ in range(n):
            mid = e[off:off+4].decode("latin-1")
            t, lv, col = struct.unpack_from("<iii", e, off+4)
            off += 16
            if t == 0:
                val = struct.unpack_from("<i", e, off)[0]; off += 4
            elif t in (1, 2):
                val = struct.unpack_from("<f", e, off)[0]; off += 4
            elif t == 3:
                end = e.index(b"\x00", off); val = e[off:end].decode("utf-8", "replace"); off = end+1
            off += 4
            mods.append((mid, lv, col, val))
        out[nid] = (e[0:4].decode("latin-1"), mods)
    return out

a = entries(sys.argv[1])
b = entries(sys.argv[2])
for k in sorted(set(a) | set(b)):
    if k not in a:
        print("只在新文件:", k); continue
    if k not in b:
        print("只在旧文件:", k); continue
    ba, ma = a[k]; bb, mb = b[k]
    if ba != bb:
        print("%s 基础技能变了: %s -> %s" % (k, bb, ba))
    da = {m[0]: m[3] for m in ma}
    db = {m[0]: m[3] for m in mb}
    for mid in sorted(set(da) | set(db)):
        if da.get(mid) != db.get(mid):
            print("%s.%s: 旧=%r 新=%r" % (k, mid, db.get(mid), da.get(mid)))
    if [m[0] for m in ma] != [m[0] for m in mb]:
        print("%s: mod 顺序不同: 旧=%s 新=%s" % (k, [m[0] for m in mb], [m[0] for m in ma]))
