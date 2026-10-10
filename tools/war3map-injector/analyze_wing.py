"""Find wing implementation in 伏魔战记: item ids, abilities, effects."""
import re, os, sys

BASE = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
SJ = os.path.join(BASE, "maps", "伏魔战记.w3x.orig")


def read_text(p):
    return open(p, encoding="utf-8", errors="replace").read()


def main():
    j = read_text(os.path.join(SJ, "war3map.j"))

    print("=== wts ===")
    print(read_text(os.path.join(SJ, "war3map.wts")))

    print("=== AddSpecialEffect contexts ===")
    for m in re.finditer(r"AddSpecialEffect\w*", j):
        i = m.start()
        print(repr(j[i - 150:i + 200]))
        print("-" * 40)

    print("=== Effect-DarkStar contexts ===")
    for m in re.finditer(r"Effect-DarkStar", j):
        i = m.start()
        print(repr(j[i - 300:i + 300]))
        print("-" * 40)


if __name__ == "__main__":
    main()
