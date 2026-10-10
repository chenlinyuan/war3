"""Dump all abilities from w3a with names/icons/effects using correct parser."""
import os, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from parse_w3obj2 import parse

BASE = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
SJ = os.path.join(BASE, "maps", "伏魔战记.w3x.orig")


def main():
    path = sys.argv[1] if len(sys.argv) > 1 else os.path.join(SJ, "war3map.w3a")
    v, orig, cust = parse(path)
    for old, new, mods, _off in (orig + cust):
        fields = {}
        for mid, vt, lv, col, val, em in mods:
            fields.setdefault(mid, []).append((lv, col, val))
        name = fields.get("anam", [("", "", "")])[0][2]
        icon = fields.get("aart", [("", "", "")])[0][2]
        eff = fields.get("aeff", [("", "", "")])[0][2]
        tgt = fields.get("amat", [("", "", "")])[0][2]
        # print if name or icon or eff mentions wing/angel/phoenix/attach
        blob = (str(name) + str(icon) + str(eff) + str(tgt)).lower()
        interesting = any(k in blob for k in ["wing", "angel", "phoenix", "lucifer", "attach", "mount"])
        marker = "***" if interesting else "   "
        print("%s %s | name=%s | icon=%s | eff=%s | tgt=%s" % (marker, new, name, icon, eff, tgt))
        if interesting:
            for mid, vt, lv, col, val, em in mods:
                print("      mod %s = %r" % (mid, val))


if __name__ == "__main__":
    main()
