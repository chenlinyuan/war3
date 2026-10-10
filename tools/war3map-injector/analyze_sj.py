"""Analyze 伏魔战记 (sj) map: find wing/mount items and abilities."""
import re, os, sys

BASE = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
SJ = os.path.join(BASE, "maps", "sj.original")


def read_text(p):
    return open(p, encoding="utf-8", errors="replace").read()


def main():
    j = read_text(os.path.join(SJ, "war3map.j"))
    print("script len", len(j))

    # all quoted strings
    strs = re.findall(r'"([^"]{1,60})"', j)
    cn = []
    for s in strs:
        if any(ord(c) > 127 for c in s) and s not in cn:
            cn.append(s)
    print("unique chinese strings:", len(cn))
    for s in cn:
        print(repr(s))


if __name__ == "__main__":
    main()
