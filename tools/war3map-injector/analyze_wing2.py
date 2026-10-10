"""Find the wing item handling in 伏魔战记."""
import re, os, sys

BASE = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
SJ = os.path.join(BASE, "maps", "伏魔战记.w3x.orig")


def read_text(p):
    return open(p, encoding="utf-8", errors="replace").read()


def main():
    j = read_text(os.path.join(SJ, "war3map.j"))
    lines = j.split("\n")

    # find the wing message and dump surrounding function
    for i, ln in enumerate(lines):
        if "翅膀" in ln:
            # find enclosing function start
            s = i
            while s > 0 and not lines[s].strip().startswith("function "):
                s -= 1
            e = i
            while e < len(lines) and lines[e].strip() != "endfunction":
                e += 1
            print("=== wing msg at line", i, "function", lines[s].strip(), "===")
            for k in range(s, min(e + 1, s + 200)):
                print(lines[k])
            break

    # search for item ids I04N usage context and any "wing"/"Wing" in ability ids
    print()
    print("=== ability ids referenced (A0xx) ===")
    aids = sorted(set(re.findall(r"'(A[0-9A-Z]{3})'", j)))
    print(aids)


if __name__ == "__main__":
    main()
