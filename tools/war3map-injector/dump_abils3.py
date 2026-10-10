"""Dump w3a raw: show oldId, and all mod ids/values for each entry."""
import os, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from parse_w3obj2 import parse

BASE = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
SJ = os.path.join(BASE, "maps", "伏魔战记.w3x.orig")

path = sys.argv[1] if len(sys.argv) > 1 else os.path.join(SJ, "war3map.w3a")
v, orig, cust = parse(path)
print("version", v, "orig", len(orig), "custom", len(cust))
for old, new, mods, off in orig[:20]:
    print("=== %s -> %r ===" % (old, new))
    for mid, vt, lv, col, val, em in mods:
        print("   %s vt=%d lv=%d col=%d val=%r end=%r" % (mid, vt, lv, col, val, em))
