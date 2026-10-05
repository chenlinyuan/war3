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
    """Return list of item IDs from an itemdata.slk."""
    txt, _ = detect_decode(path)
    cells = {}
    for m in re.finditer(r'C;X(\d+);(?:Y(\d+);)?K"((?:[^"]|"")*)"', txt):
        x = int(m.group(1))
        y = int(m.group(2)) if m.group(2) else 1
        cells[(x, y)] = m.group(3).replace('""', '"')
    maxy = max((y for (x, y) in cells), default=1)
    ids = []
    for y in range(2, maxy + 1):
        iid = cells.get((1, y))
        if iid and len(iid) == 4:
            ids.append(iid)
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

    ids = {}  # id -> name

    # 1. standard items
    if os.path.isfile(GAME_SLK):
        for iid in parse_slk(GAME_SLK):
            ids[iid] = ""
        print("standard items:", len(ids))

    # 2. custom items from map
    if map_dir:
        func = os.path.join(map_dir, "units", "itemfunc.txt")
        if os.path.isfile(func):
            for iid, nm in parse_itemfunc(func):
                ids[iid] = nm
            print("after custom itemfunc:", len(ids))
        slk = os.path.join(map_dir, "units", "itemdata.slk")
        if os.path.isfile(slk):
            for iid in parse_slk(slk):
                ids.setdefault(iid, "")
            print("after custom itemdata.slk:", len(ids))

    # write
    out = os.path.join(HERE, "_itemids.txt")
    with open(out, "w", encoding="utf-8") as fh:
        for iid in ids:
            fh.write("%s\t%s\n" % (iid, ids[iid]))
    print("wrote %s with %d items" % (out, len(ids)))


if __name__ == "__main__":
    main()
