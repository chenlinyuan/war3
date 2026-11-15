# -*- coding: utf-8 -*-
"""Stop the "barrier" damage-over-time from killing the player's own units.

194213 ch3 (复灭的征途) installs a 1-second timer that drains everything inside a
large region:

    function Trig____007Func001Func002002 takes nothing returns nothing
        call SetUnitLifeBJ(GetEnumUnit(),
             GetUnitStateSwap(UNIT_STATE_LIFE, GetEnumUnit())
             - GetUnitStateSwap(UNIT_STATE_MAX_LIFE, GetEnumUnit()) * 0.1)
    endfunction

The filter only exempts a few unit types ('n651' / 'nsts' / 'nsat' - the 赛特斯),
so the player's hero (a demon) loses 10% max life per second and dies in ~10
seconds -> "hero died" -> 判负 + wipe.  The chapter becomes unplayable offline.

Fix: wrap the drain call in `if GetOwningPlayer(GetEnumUnit()) != Player(0)`, so
the mechanic stays for everything else but no longer eats the player's units.
"""
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import _patch_critical_props as CP  # noqa: E402

RX_FUNC = re.compile(r"(?m)^function\s+(\w+)\s+takes\s")
RX_DRAIN = re.compile(
    r"(?m)^([ \t]*)call SetUnitLifeBJ\(GetEnumUnit\(\), GetUnitStateSwap\(UNIT_STATE_LIFE, GetEnumUnit\(\)\)"
    r" - GetUnitStateSwap\(UNIT_STATE_MAX_LIFE, GetEnumUnit\(\)\) \* [\d.]+\)[ \t]*\r?$")


def patch(text):
    marks = [(m.start(), m.group(1)) for m in RX_FUNC.finditer(text)]
    new, n = text, 0
    props = CP.critical_props(text)
    guard = "GetOwningPlayer(GetEnumUnit()) != Player(0)"
    for p in props:
        guard += " and GetEnumUnit() != %s" % p
    # 从后往前改，避免偏移失效
    hits = list(RX_DRAIN.finditer(text))
    for m in reversed(hits):
        ind = m.group(1)
        line = m.group(0).strip()
        rep = ("%sif %s then // IB: don't drain player units / critical props\n"
               "%s    %s\n%sendif" % (ind, guard, ind, line, ind))
        new = new[:m.start()] + rep + new[m.end():]
        n += 1
    return new, n


def main():
    for p in sys.argv[1:]:
        raw = open(p, "rb").read()
        new, n = patch(raw.decode("utf-8", "surrogateescape"))
        print("%-20s region drains scoped to non-player units: %d"
              % (p.replace("\\", "/").split("/")[-1], n))
        if n:
            with open(p, "wb") as f:
                f.write(new.encode("utf-8", "surrogateescape"))


if __name__ == "__main__":
    main()
