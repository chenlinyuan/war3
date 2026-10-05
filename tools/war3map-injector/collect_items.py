"""Extract ALL item IDs usable in a map:
  1. Standard items from the game's Units\\ItemData.slk
  2. Custom items from the map's units\\itemfunc.txt (and itemdata.slk)

Outputs a combined list to _itemids.txt (tab-separated: id<TAB>name).
"""
import re, os, sys

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.abspath(os.path.join(HERE, "..", ".."))

GAME_SLK = r"H:\Games\War3\ojzrqpjb\share\mpq\units\units\itemdata.slk"


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


def main():
    map_dir = sys.argv[1] if len(sys.argv) > 1 else None

    # The map's own itemdata.slk is the AUTHORITATIVE list of items that
    # actually exist / can be created in this map. If a map has its own
    # itemdata.slk, only those IDs are creatable — standard game items NOT
    # listed there have been removed by the map author.
    map_slk_path = os.path.join(map_dir, "units", "itemdata.slk") if map_dir else None
    map_func_path = os.path.join(map_dir, "units", "itemfunc.txt") if map_dir else None

    names = {}  # id -> name (from itemfunc.txt)
    if map_func_path and os.path.isfile(map_func_path):
        for iid, nm in parse_itemfunc(map_func_path):
            names[iid] = nm

    if map_slk_path and os.path.isfile(map_slk_path):
        creatable = parse_slk(map_slk_path)
        print("map itemdata.slk (creatable):", len(creatable))
    else:
        # No map slk -> use the game's standard list
        creatable = parse_slk(GAME_SLK) if os.path.isfile(GAME_SLK) else []
        print("no map slk; using game standard:", len(creatable))

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
