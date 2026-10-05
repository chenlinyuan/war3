"""Extract ALL item IDs usable in a map:
  1. Standard items from the game's Units\\ItemData.slk
  2. Custom items from the map's units\\itemfunc.txt (and itemdata.slk)

Outputs a combined list to _itemids.txt (tab-separated: id<TAB>name).
"""
import re, os, sys

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.abspath(os.path.join(HERE, "..", ".."))

GAME_SLK = r"H:\Games\War3\ojzrqpjb\share\mpq\units\units\itemdata.slk"
# 游戏自带的物品名称（本地化中文），用于没有地图 itemfunc.txt 的官方地图
GAME_ITEMSTRINGS = r"H:\Games\War3\ojzrqpjb\share\mpq\units\units\itemstrings.txt"
GAME_ITEMFUNC = r"H:\Games\War3\ojzrqpjb\share\mpq\units\units\itemfunc.txt"


def detect_decode(path):
    data = open(path, "rb").read()
    for enc in ("utf-8", "gbk"):
        try:
            return data.decode(enc), enc
        except Exception:
            continue
    return data.decode("latin-1"), "latin-1"


def parse_slk(path):
    """Return list of item IDs from an itemdata.slk.

    SLK cells are scanned in order. A cell may set the current row via `Y<n>`
    and/or the column via `X<n>`; if a coordinate is omitted, the previous
    value is reused (SLK semantics). The itemID column is X1.
    """
    txt, _ = detect_decode(path)
    cur_x = 1
    cur_y = 1
    ids = []
    # each cell: C;...;K"value"  (coordinates appear before K)
    for m in re.finditer(r'C;([^K]*);K"((?:[^"]|"")*)"', txt):
        coords = m.group(1)
        val = m.group(2).replace('""', '"')
        xm = re.search(r"X(\d+)", coords)
        ym = re.search(r"Y(\d+)", coords)
        if xm:
            cur_x = int(xm.group(1))
        if ym:
            cur_y = int(ym.group(1))
        # itemID column is X1, data starts at row 2
        if cur_x == 1 and cur_y >= 2 and len(val) == 4:
            ids.append(val)
    return ids


def parse_itemfunc(path):
    """Return list of (id, name) from itemfunc.txt."""
    txt, _ = detect_decode(path)
    items = []
    cur = None
    for line in txt.splitlines():
        s = line.strip()
        m = re.match(r"^\[([0-9A-Za-z]{4})\]$", s)
        if m:
            cur = m.group(1)
            continue
        if cur and s.lower().startswith("name="):
            items.append((cur, s.split("=", 1)[1]))
            cur = None
    return items


def parse_wts(path):
    """Return dict TRIGSTR_N -> string value from war3map.wts."""
    txt, _ = detect_decode(path)
    trig = {}
    for m in re.finditer(r"STRING (\d+)\s*\r?\n\{\r?\n(.*?)\r?\n\}", txt, re.S):
        trig["TRIGSTR_" + m.group(1)] = m.group(2).strip()
    return trig


def parse_w3t(path, wts_path=None):
    """Return list of (id, name) custom items from war3map.w3t.

    The w3t modification table is not reliably walkable byte-by-byte (the
    writer emits stray object-id fields between mods), so we anchor on the
    `unam` (name) modification: every custom item id is followed within a
    short window by `unam\\x03\\x00\\x00\\x00TRIGSTR_N\\x00`.
    """
    data = open(path, "rb").read()
    trig = parse_wts(wts_path) if wts_path and os.path.isfile(wts_path) else {}
    items = {}
    for m in re.finditer(rb"I[0-9A-Za-z]{3}", data):
        start = m.start()
        iid = m.group(0).decode("latin-1")
        seg = data[start:start + 120]
        um = re.search(rb"unam\x03\x00\x00\x00(TRIGSTR_\d+)\x00", seg)
        if um:
            key = um.group(1).decode("latin-1")
            items[iid] = trig.get(key, "")
    return list(items.items())


def main():
    map_dir = sys.argv[1] if len(sys.argv) > 1 else None

    # The map's own itemdata.slk is the AUTHORITATIVE list of items that
    # actually exist / can be created in this map. If a map has its own
    # itemdata.slk, only those IDs are creatable — standard game items NOT
    # listed there have been removed by the map author.
    map_slk_path = os.path.join(map_dir, "units", "itemdata.slk") if map_dir else None
    map_func_path = os.path.join(map_dir, "units", "itemfunc.txt") if map_dir else None
    map_w3t_path = os.path.join(map_dir, "war3map.w3t") if map_dir else None
    map_wts_path = os.path.join(map_dir, "war3map.wts") if map_dir else None

    names = {}  # id -> name (from itemfunc.txt)
    if map_func_path and os.path.isfile(map_func_path):
        for iid, nm in parse_itemfunc(map_func_path):
            names[iid] = nm

    # Custom items defined via the object editor (war3map.w3t) + war3map.wts.
    w3t_items = []
    if map_w3t_path and os.path.isfile(map_w3t_path):
        w3t_items = parse_w3t(map_w3t_path, map_wts_path)
        for iid, nm in w3t_items:
            if nm and (iid not in names or names[iid].strip() == ""):
                names[iid] = nm
        print("map war3map.w3t custom items:", len(w3t_items))

    # Fallback names from the game's localized itemstrings.txt (official maps
    # have no map itemfunc.txt, so names must come from the game data).
    if os.path.isfile(GAME_ITEMSTRINGS):
        for iid, nm in parse_itemfunc(GAME_ITEMSTRINGS):
            if iid not in names or names[iid].strip() == "":
                names[iid] = nm
        print("game itemstrings.txt names:", len(names))

    if map_slk_path and os.path.isfile(map_slk_path):
        creatable = parse_slk(map_slk_path)
        print("map itemdata.slk (creatable):", len(creatable))
    else:
        # No map slk -> use the game's standard list, plus any custom items
        # defined through the object editor (war3map.w3t).
        creatable = parse_slk(GAME_SLK) if os.path.isfile(GAME_SLK) else []
        print("no map slk; using game standard:", len(creatable))
        for iid, _ in w3t_items:
            if iid not in creatable:
                creatable.append(iid)
        print("after adding w3t custom:", len(creatable))

    game = set(parse_slk(GAME_SLK)) if os.path.isfile(GAME_SLK) else set()

    std_out = []
    cus_out = []
    for iid in creatable:
        nm = names.get(iid, "")
        if iid in game:
            std_out.append((iid, nm))
        else:
            cus_out.append((iid, nm))

    print("standard (creatable):", len(std_out))
    print("custom (creatable):", len(cus_out))

    out = os.path.join(HERE, "_itemids.txt")
    with open(out, "w", encoding="utf-8") as fh:
        for iid, nm in std_out:
            fh.write("S\t%s\t%s\n" % (iid, nm))
        for iid, nm in cus_out:
            fh.write("C\t%s\t%s\n" % (iid, nm))
    print("wrote %s: %d standard + %d custom = %d" % (
        out, len(std_out), len(cus_out), len(std_out) + len(cus_out)))


if __name__ == "__main__":
    main()
