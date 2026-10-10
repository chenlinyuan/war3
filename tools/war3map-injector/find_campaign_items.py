"""在战役地图里找物品及其图标（用于挑"火焰手套/神秘手套"这类战役图标）。

用法:
    python find_campaign_items.py [关键词...]
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import war3mpq as W  # noqa: E402
from merge_w3obj import read_all  # noqa: E402

BASE = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))


def read_mods_item(e):
    """w3t/w3u/w3h 的 mod 格式是 modId(4)+type(4)+value+end(4)。"""
    import struct

    n = struct.unpack_from("<i", e, 8)[0]
    off = 12
    out = {}
    for _ in range(n):
        mid = e[off:off + 4].decode("latin-1")
        t = struct.unpack_from("<i", e, off + 4)[0]
        off += 8
        if t == 0:
            val = struct.unpack_from("<i", e, off)[0]
            off += 4
        elif t in (1, 2):
            val = struct.unpack_from("<f", e, off)[0]
            off += 4
        elif t == 3:
            end = e.index(b"\x00", off)
            raw = e[off:end]
            val = raw.decode("utf-8", "replace")
            off = end + 1
        else:
            break
        off += 4
        out[mid] = val
    return out


def wts_map(data):
    out = {}
    if not data:
        return out
    text = data.decode("utf-8", "replace")
    cur = None
    for line in text.splitlines():
        line = line.strip()
        if line.startswith("STRING "):
            cur = line.split(" ", 1)[1]
        elif line.startswith("{") and cur:
            pass
        elif line.startswith("}") and cur:
            cur = None
        elif cur and line:
            if cur not in out:
                out[cur] = line
    return out


def dump_map(path, keywords):
    a = W.MPQArchive(path)
    try:
        w3t = a.read_file("war3map.w3t")
        wts = wts_map(a.read_file("war3map.wts"))
    finally:
        a.close()
    if not w3t:
        return 0
    tmp = os.path.join(BASE, "tools", "war3map-injector", "_tmp_camp.w3t")
    open(tmp, "wb").write(w3t)
    ver, orig, cust = read_all(tmp)
    os.remove(tmp)
    hits = 0
    for e in cust + orig:
        mods = read_mods_item(e)
        name = str(mods.get("unam", ""))
        if name.startswith("TRIGSTR_"):
            name = wts.get(name.split("_", 1)[1], name)
        icon = str(mods.get("iico", ""))
        blob = (name + " " + icon)
        if not keywords or any(k in blob for k in keywords):
            hits += 1
            print("  %-6s %-24s %s" % (e[4:8].decode("latin-1"), name, icon))
    return hits


def main():
    kws = sys.argv[1:]
    roots = [os.path.join(BASE, "maps", "campaign"),
             os.path.join(BASE, "maps")]
    total = 0
    for root in roots:
        if not os.path.isdir(root):
            continue
        for dirpath, _d, files in os.walk(root):
            for fn in sorted(files):
                if not fn.lower().endswith((".w3x", ".w3m", ".w3n")):
                    continue
                p = os.path.join(dirpath, fn)
                try:
                    n = dump_map(p, kws)
                except Exception as ex:
                    continue
                if n:
                    print("== %s (%d 命中)" % (os.path.relpath(p, BASE), n))
                    total += n
    print("总命中", total)
    return 0


if __name__ == "__main__":
    sys.exit(main())
