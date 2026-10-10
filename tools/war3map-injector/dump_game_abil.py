import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from _slk_num import parse_slk_num  # noqa: E402

GAME = r"H:\Games\War3\ojzrqpjb\share\mpq\units\units"


def main():
    rows = parse_slk_num(os.path.join(GAME, "abilitydata.slk"))
    hdr = rows.get(1, {})
    want = sys.argv[1:] or ["AOcr", "AEev", "AOre", "AIar", "AHab"]
    for y in sorted(rows):
        r = rows[y]
        if r.get(1) in want:
            print("=== %s (%s) ===" % (r.get(1), r.get(3)))
            for x, v in sorted(r.items()):
                if v not in ("", None, "-"):
                    print("   %-12s = %s" % (hdr.get(x, x), v))


if __name__ == "__main__":
    main()
