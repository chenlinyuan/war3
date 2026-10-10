"""Find item IDs and item-related triggers in 伏魔战记."""
import re, os, sys

BASE = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
SJ = os.path.join(BASE, "maps", "伏魔战记.w3x.orig")


def read_text(p):
    return open(p, encoding="utf-8", errors="replace").read()


def main():
    j = read_text(os.path.join(SJ, "war3map.j"))

    # all item ids referenced
    ids = re.findall(r"'([A-Za-z0-9]{4})'", j)
    from collections import Counter
    c = Counter(ids)
    print("total id refs", len(ids), "unique", len(c))
    # item ids usually start with I
    itemids = sorted(set(i for i in ids if i[0] in "Ii"))
    print("item-like ids:", itemids)

    # Trigger names
    print()
    print("=== all InitTrig_ names ===")
    for m in re.finditer(r"function InitTrig_(\w+) takes", j):
        print(m.group(1))


if __name__ == "__main__":
    main()
