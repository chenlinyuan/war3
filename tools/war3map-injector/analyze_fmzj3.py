"""Analyze 伏魔战记 (fmzj) map: model paths, item ids, pet/wing triggers."""
import re, os, sys

BASE = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
SJ = os.path.join(BASE, "maps", "伏魔战记.w3x.orig")


def read_text(p):
    return open(p, encoding="utf-8", errors="replace").read()


def main():
    j = read_text(os.path.join(SJ, "war3map.j"))

    # model paths / effect strings
    print("=== .mdx / .blp references in script ===")
    for m in re.finditer(r'"[^"]*\.(mdx|mdl|blp)"', j, re.I):
        print(m.group(0))

    print()
    print("=== AddSpecialEffect / SetUnitModel / SetUnitAnimation variants ===")
    for fn in ["AddSpecialEffect", "SetUnitModel", "SetUnitAnimation", "SetUnitScale",
               "ReplaceUnit", "TransformUnit", "SetUnitPathing", "UnitAddAbility",
               "GetUnitTypeId", "SetUnitTypeId", "SetUnitMoveSpeed", "SetUnitTurnSpeed"]:
        idxs = [m.start() for m in re.finditer(re.escape(fn), j)]
        print(fn, len(idxs))

    print()
    print("=== PetB / wing related trigger funcs ===")
    for m in re.finditer(r'function (Trig_\w*(?:Pet|Wing|ItemUp|Mount)\w*)', j):
        print(m.group(1))


if __name__ == "__main__":
    main()
