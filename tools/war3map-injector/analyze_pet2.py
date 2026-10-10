"""Dump PetA2, PetB2, PetD2, PetJ and InitTrig_Pet* to find pet/wing item ids."""
import re, os, sys

BASE = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
SJ = os.path.join(BASE, "maps", "伏魔战记.w3x.orig")


def read_text(p):
    return open(p, encoding="utf-8", errors="replace").read()


def dump_func(j, name, maxlines=120):
    lines = j.split("\n")
    print("=" * 70)
    print("FUNCTION", name)
    print("=" * 70)
    start = None
    for i, ln in enumerate(lines):
        if ln.strip().startswith("function " + name + " takes"):
            start = i
            break
    if start is None:
        print("  <not found>")
        return
    for ln in lines[start:start + maxlines]:
        print(ln)
        if ln.strip() == "endfunction":
            break


def main():
    j = read_text(os.path.join(SJ, "war3map.j"))
    for n in ["Trig_PetA2_Actions", "Trig_PetB2_Actions", "Trig_PetD2_Actions",
              "Trig_PetJ_Actions", "InitTrig_PetA1", "InitTrig_PetB1",
              "InitTrig_PetA2", "InitTrig_PetB2", "InitTrig_PetI"]:
        dump_func(j, n)


if __name__ == "__main__":
    main()
