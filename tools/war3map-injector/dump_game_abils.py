"""Dump base abilities from the game's abilitydata.slk."""
import re, os, sys

GAME = r"H:\Games\War3\ojzrqpjb\share\mpq\units\units"


def parse_slk(path):
    t = open(path, encoding="latin-1").read()
    rows = {}
    cx = cy = None
    for m in re.finditer(r'C;((?:[XY]\d+;)*)K"((?:[^"]|"")*)"', t):
        coords = m.group(1)
        val = m.group(2).replace('""', '"')
        for c in coords.split(";"):
            if not c:
                continue
            if c[0] == "Y":
                cy = int(c[1:])
            elif c[0] == "X":
                cx = int(c[1:])
        rows.setdefault(cy, {})[cx] = val
    return rows


def main():
    rows = parse_slk(os.path.join(GAME, "abilitydata.slk"))
    hdr = rows.get(1, {})
    byid = {}
    for y in sorted(rows):
        r = rows[y]
        iid = r.get(1, "")
        if iid:
            byid[iid] = r
    targets = sys.argv[1:] if len(sys.argv) > 1 else [
        "AIml", "AIsr", "Aspb", "AIrm", "AIms", "AIad", "Arel", "AIde", "AIat", "AIar"]
    for t in targets:
        r = byid.get(t)
        print("=== %s ===" % t)
        if r:
            for x, v in sorted(r.items()):
                if v:
                    print("   %s = %s" % (hdr.get(x, x), v))
        else:
            print("   not found")


if __name__ == "__main__":
    main()
