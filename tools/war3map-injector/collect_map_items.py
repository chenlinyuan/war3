"""Merge a map's custom items (war3map.w3t) into _itemids.txt using the robust
verify_w3obj-style parser (handles the stray-field drift that collect_items'
parse_w3t can hit).

Usage:
    python collect_map_items.py <map_dir>
"""
import os, sys, struct, re
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import collect_items as ci
from merge_w3obj import read_all

HERE = os.path.dirname(os.path.abspath(__file__))


def parse_wts(path):
    txt = open(path, "rb").read().decode("utf-8", "replace")
    trig = {}
    for m in re.finditer(r"STRING (\d+)\s*\r?\n\{\r?\n(.*?)\r?\n\}", txt, re.S):
        trig["TRIGSTR_" + m.group(1)] = m.group(2).strip()
    return trig


def parse_entry_mods(entry, version):
    """Decode the mods of one raw w3t entry, including v3 item sets."""
    off = 8
    if version >= 3:
        set_count = struct.unpack_from("<i", entry, off)[0]
        off += 4
        counts = []
        for _ in range(set_count):
            _flag, count = struct.unpack_from("<ii", entry, off)
            off += 8
            counts.append(count)
    else:
        counts = [struct.unpack_from("<i", entry, off)[0]]
        off += 4
    mods = []
    for count in counts:
        for _ in range(count):
            mid = entry[off:off + 4].decode("latin-1")
            off += 4
            kind = struct.unpack_from("<i", entry, off)[0]
            off += 4
            if kind == 0:
                value = struct.unpack_from("<i", entry, off)[0]
                off += 4
            elif kind in (1, 2):
                value = struct.unpack_from("<f", entry, off)[0]
                off += 4
            elif kind == 3:
                end = entry.index(b"\x00", off)
                value = entry[off:end].decode("utf-8", "replace")
                off = end + 1
            else:
                raise ValueError("item value type %d at byte %d" % (kind, off - 4))
            off += 4  # end marker
            mods.append((mid, kind, value))
    if off != len(entry):
        raise ValueError("item entry has %d trailing bytes" % (len(entry) - off))
    return mods


def parse_w3t(path, wts_path):
    version, _orig, custom = read_all(str(path))
    trig = parse_wts(wts_path) if os.path.isfile(wts_path) else {}
    items = []
    for entry in custom:
        old = entry[0:4].decode("latin-1")
        new = entry[4:8].decode("latin-1")
        mods = parse_entry_mods(entry, version)
        name = ""
        for mid, t, v in mods:
            if mid in ("unam", "inam") and isinstance(v, str):
                name = trig.get(v, v) if v.startswith("TRIGSTR_") else v
        items.append((old, new, name))
    return items


def main():
    map_dir = sys.argv[1]
    w3t = os.path.join(map_dir, "war3map.w3t")
    wts = os.path.join(map_dir, "war3map.wts")
    items = parse_w3t(w3t, wts) if os.path.isfile(w3t) else []
    print("map custom items:", len(items))

    base_dir = os.environ.get("IB_BASE_DIR") or HERE
    p = os.path.join(base_dir, "_itemids.txt")
    lines = open(p, encoding="utf-8").read().splitlines()
    existing = set()
    names = {}
    for ln in lines:
        parts = ln.split("\t")
        if len(parts) >= 2:
            existing.add(parts[1])
            names[parts[1]] = parts[2] if len(parts) >= 3 else ""
    added = 0
    for base_id, iid, nm in items:
        if not nm:
            nm = names.get(base_id, "")
        if iid and iid not in existing:
            lines.append("C\t%s\t%s" % (iid, nm))
            existing.add(iid)
            added += 1
    print("added:", added)
    open(p, "w", encoding="utf-8").write("\n".join(lines) + "\n")
    print("total:", len(lines))


if __name__ == "__main__":
    main()
