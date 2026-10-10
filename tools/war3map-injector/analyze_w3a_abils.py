"""Check if wing abilities A006/A008/A007/A003 exist in war3map.w3a, and dump them."""
import os, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from parse_w3obj2 import parse

BASE = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
SJ = os.path.join(BASE, "maps", "伏魔战记.w3x.orig")

path = os.path.join(SJ, "war3map.w3a")
v, orig, cust = parse(path)
print("orig", len(orig), "custom", len(cust))

# all ids present
allids = [e[0] for e in orig] + [e[0] for e in cust]
print("all ids:", " ".join(allids))

targets = ["A006", "A008", "A007", "A003", "A0CT", "A0CV", "A001", "A00D", "AId3", "A005", "A004", "A08O", "Arll", "AIad", "A0CZ", "A0CD", "A0CF", "A0CY", "A0CE"]
for e in orig + cust:
    if e[0] in targets:
        print("=== %s -> %r ===" % (e[0], e[1]))
        for mid, vt, lv, col, val, em in e[2]:
            print("   %s vt=%d lv=%d col=%d val=%r" % (mid, vt, lv, col, val))
