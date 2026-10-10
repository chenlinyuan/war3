"""Dump all entries (orig+custom) with all mods from a w3a/w3t."""
import os, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from parse_w3obj2 import parse

path = sys.argv[1]
v, orig, cust = parse(path)
print("version", v, "orig", len(orig), "custom", len(cust))
for old, new, mods, off in (orig + cust):
    print("=== %s -> %r ===" % (old, new))
    for mid, vt, lv, col, val, em in mods:
        print("   %s vt=%d lv=%d col=%d val=%r" % (mid, vt, lv, col, val))
