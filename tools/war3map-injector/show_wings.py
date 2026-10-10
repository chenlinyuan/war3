"""把翅膀相关技能(war3map.w3a)的字段全部打印出来，用来核对/排查。"""
import os
import struct
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from merge_w3obj import read_all  # noqa: E402

HERE = os.path.dirname(os.path.abspath(__file__))
IDS = ["W000", "W020", "W021", "W002", "W070", "W071", "W072", "W073", "W074", "W075",
       "W076", "W077", "W078", "W079", "W080", "W081", "W082", "W084"]


def dump(path):
    ver, orig, cust = read_all(path)
    for e in orig + cust:
        nid = e[4:8].decode("latin-1")
        if nid not in IDS:
            continue
        n = struct.unpack_from("<i", e, 8)[0]
        off = 12
        mods = []
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
                val = "?"
            off += 4
            mods.append("%s=%s" % (mid, val))
        print("%-5s (base %-5s) %s" % (nid, e[0:4].decode("latin-1"), "; ".join(mods)))


if __name__ == "__main__":
    p = sys.argv[1] if len(sys.argv) > 1 else os.path.join(HERE, "_wing.w3a")
    dump(p)
