"""Dump abilities (id, name, icon, effect model) from a war3map.w3a."""
import re, os, sys, struct
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from parse_w3a import parse

BASE = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
SJ = os.path.join(BASE, "maps", "伏魔战记.w3x.orig")


def main():
    path = sys.argv[1] if len(sys.argv) > 1 else os.path.join(SJ, "war3map.w3a")
    version, orig, cust = parse(path, verbose=False)

    def get(mods, mid):
        for m in mods:
            if m[0] == mid:
                return m[4]
        return None

    print("=== CUSTOM ABILITIES ===")
    for old, new, mods in cust:
        name = get(mods, "anam")
        icon = get(mods, "aart")
        eff = get(mods, "aeff")
        tgt = get(mods, "amat")
        modlist = ",".join(m[0] for m in mods)
        print("%s <- %s | name=%s | icon=%s | eff=%s | tgt=%s" % (
            new, old, name, icon, eff, tgt))
        print("    mods:", modlist)

    print()
    print("=== ORIGINAL ABILITIES (modified) ===")
    for old, new, mods in orig:
        name = get(mods, "anam")
        icon = get(mods, "aart")
        eff = get(mods, "aeff")
        print("%s <- %s | name=%s | icon=%s | eff=%s" % (new, old, name, icon, eff))


if __name__ == "__main__":
    main()
