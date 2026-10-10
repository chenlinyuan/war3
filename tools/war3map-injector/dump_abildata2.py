"""Dump specific abilities with all fields."""
import re, os, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from dump_abildata import parse_slk

BASE = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
SJ = os.path.join(BASE, "maps", "伏魔战记.w3x.orig")


def main():
    p = os.path.join(SJ, "units", "abilitydata.slk")
    rows = parse_slk(p)
    hdr = rows.get(1, {})
    targets = sys.argv[1:] if len(sys.argv) > 1 else [
        "A006", "A008", "A007", "A003", "A0CT", "A0CV", "A001", "AIad", "A08O",
        "Arll", "A00D", "AId3", "A005", "A004"]
    by_id = {}
    for y in sorted(rows):
        r = rows[y]
        iid = r.get(1, "")
        if iid:
            by_id[iid] = r
    for t in targets:
        r = by_id.get(t)
        if not r:
            print("=== %s (not found) ===" % t)
            continue
        print("=== %s ===" % t)
        for x, v in sorted(r.items()):
            print("   %s = %s" % (hdr.get(x, x), v))


if __name__ == "__main__":
    main()
