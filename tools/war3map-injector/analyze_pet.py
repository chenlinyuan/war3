"""Extract 伏魔战记 Pet (mount) trigger functions and item ids."""
import re, os, sys

BASE = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
SJ = os.path.join(BASE, "maps", "伏魔战记.w3x.orig")


def read_text(p):
    return open(p, encoding="utf-8", errors="replace").read()


def main():
    j = read_text(os.path.join(SJ, "war3map.j"))
    lines = j.split("\n")

    # print full body of Trig_PetA1_Actions .. Trig_PetJ_Actions
    for name in ["Trig_PetA1_Actions", "Trig_PetB1_Actions", "Trig_PetC1_Actions",
                 "Trig_PetD1_Actions", "Trig_PetE1_Actions", "Trig_PetF1_Actions",
                 "Trig_PetG1_Actions", "Trig_PetH1_Actions", "Trig_PetI_Actions",
                 "Trig_PetJ_Actions"]:
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
            continue
        for ln in lines[start:start + 80]:
            print(ln)
            if ln.strip() == "endfunction":
                break


if __name__ == "__main__":
    main()
