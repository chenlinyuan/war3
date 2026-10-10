"""Merge a map's custom items (war3map.w3t) into _itemids.txt using the robust
verify_w3obj-style parser (handles the stray-field drift that collect_items'
parse_w3t can hit).

Usage:
    python collect_map_items.py <map_dir>
"""
import os, sys, struct, re
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import collect_items as ci

HERE = os.path.dirname(os.path.abspath(__file__))


def parse_wts(path):
    txt = open(path, "rb").read().decode("utf-8", "replace")
    trig = {}
    for m in re.finditer(r"STRING (\d+)\s*\r?\n\{\r?\n(.*?)\r?\n\}", txt, re.S):
        trig["TRIGSTR_" + m.group(1)] = m.group(2).strip()
    return trig


def parse_w3t(path, wts_path):
    d = open(path, "rb").read()
    trig = parse_wts(wts_path) if os.path.isfile(wts_path) else {}
    off = 0
    struct.unpack_from("<i", d, off)[0]; off += 4
    orig = struct.unpack_from("<i", d, off)[0]; off += 4

    def read_value(off, t):
        if t == 0:
            return struct.unpack_from("<i", d, off)[0], off + 4
        elif t in (1, 2):
            return struct.unpack_from("<f", d, off)[0], off + 4
        elif t == 3:
            e = d.find(b"\x00", off)
            return d[off:e].decode("utf-8", "replace"), e + 1
        raise ValueError("type %d" % t)

    def read_entry(off, nfields):
        old = d[off:off + 4].decode("latin-1"); off += 4
        new = d[off:off + 4].decode("latin-1"); off += 4
        n = struct.unpack_from("<i", d, off)[0]; off += 4
        mods = []
        for _ in range(n):
            mid = d[off:off + 4].decode("latin-1"); off += 4
            t = struct.unpack_from("<i", d, off)[0]; off += 4
            for _ in range(nfields - 1):
                off += 4
            v, off = read_value(off, t)
            off += 4
            mods.append((mid, t, v))
        return (old, new, mods), off

    def try_parse(nfields):
        o = 8
        res = []
        try:
            for _ in range(orig):
                e, o = read_entry(o, nfields)
                res.append(("orig", e))
            cust = struct.unpack_from("<i", d, o)[0]; o += 4
            for _ in range(cust):
                e, o = read_entry(o, nfields)
                res.append(("cust", e))
            if o != len(d):
                return None
            return res, cust
        except Exception:
            return None

    parsed = try_parse(3) or try_parse(1)
    if not parsed:
        return []
    result, cust = parsed
    items = []
    for kind, (old, new, mods) in result:
        if kind != "cust":
            continue
        name = ""
        for mid, t, v in mods:
            if mid in ("unam", "inam") and isinstance(v, str):
                name = trig.get(v, v) if v.startswith("TRIGSTR_") else v
        items.append((new, name))
    return items


def main():
    map_dir = sys.argv[1]
    w3t = os.path.join(map_dir, "war3map.w3t")
    wts = os.path.join(map_dir, "war3map.wts")
    items = parse_w3t(w3t, wts) if os.path.isfile(w3t) else []
    print("map custom items:", len(items))

    p = os.path.join(HERE, "_itemids.txt")
    lines = open(p, encoding="utf-8").read().splitlines()
    existing = set()
    for ln in lines:
        parts = ln.split("\t")
        if len(parts) >= 2:
            existing.add(parts[1])
    added = 0
    for iid, nm in items:
        if iid and iid not in existing:
            lines.append("C\t%s\t%s" % (iid, nm))
            existing.add(iid)
            added += 1
    print("added:", added)
    open(p, "w", encoding="utf-8").write("\n".join(lines) + "\n")
    print("total:", len(lines))


if __name__ == "__main__":
    main()
