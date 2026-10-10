"""Analyze 伏魔战记 (fmzj) map: contexts around wing keywords + w3a abilities."""
import re, os, sys

BASE = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
SJ = os.path.join(BASE, "maps", "伏魔战记.w3x.orig")


def read_text(p):
    return open(p, encoding="utf-8", errors="replace").read()


def main():
    j = read_text(os.path.join(SJ, "war3map.j"))
    for pos in [437591, 437594, 48754, 49048, 134368, 419072, 420367, 178111]:
        print("=== pos", pos, "===")
        print(j[pos - 300:pos + 300].replace("\r", ""))
        print()

    # Dump w3a strings: find all printable ascii runs >= 4
    print("=== w3a strings ===")
    w = open(os.path.join(SJ, "war3map.w3a"), "rb").read()
    print("w3a size", len(w))
    runs = re.findall(rb"[\x20-\x7e]{4,}", w)
    seen = []
    for r in runs:
        s = r.decode("ascii")
        if s not in seen:
            seen.append(s)
    print("unique strings", len(seen))
    for s in seen:
        print(s)


if __name__ == "__main__":
    main()
