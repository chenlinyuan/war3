"""Analyze 伏魔战记 (fmzj) map: find wing/mount items and abilities."""
import re, os, sys

BASE = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
SJ = os.path.join(BASE, "maps", "伏魔战记.w3x.orig")


def read_text(p):
    return open(p, encoding="utf-8", errors="replace").read()


def main():
    j = read_text(os.path.join(SJ, "war3map.j"))
    print("script len", len(j))

    kws = ["翅膀", "坐骑", "堕落", "天使", "凤凰", "骑", "翼",
           "AddSpecialEffectTarget", "SetUnitModel", "变身", "变形",
           "wing", "Wing", "mount", "Mount", "phoenix", "Phoenix",
           "lucifer", "Lucifer", "angel", "Angel", "wingofthelucifer",
           "doomgguardwings", "fwind", "fwing", "wingblack4"]
    for kw in kws:
        idxs = [m.start() for m in re.finditer(re.escape(kw), j)]
        print(repr(kw), len(idxs), idxs[:8])

    print("=== all quoted strings containing 翅膀/坐骑/天使/凤凰/翼 ===")
    strs = re.findall(r'"([^"]{1,80})"', j)
    seen = []
    for s in strs:
        if any(k in s for k in ["翅膀", "坐骑", "天使", "凤凰", "翼", "堕落"]):
            if s not in seen:
                seen.append(s)
    for s in seen:
        print(repr(s))


if __name__ == "__main__":
    main()
