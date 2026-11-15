# -*- coding: utf-8 -*-
"""Neutralize the "mall pet" triggers that delete the hero.

KK platform maps register dozens of mall triggers (pickup item -> HasMallItem(key)).
Several of them end with a block that wipes the player's whole line-up:

    call RemoveUnit(udg_ak)           // player hero
    call RemoveUnit(udg_chongwu02)    // pet
    call RemoveUnit(udg_chongwu01)
    call RemoveUnit(gg_unit_e60P_0433)
    call RemoveUnit(gg_unit_e60P_0434)

With the single-player stub returning `true` for every mall key ("all perks on"),
that block runs and the hero vanishes (no hero icon top-left).  We keep the
"claim the pet" part and turn the wipe into a no-op.

Only the exact consecutive pattern is touched, so a real hero-swap
(create replacement -> copy items -> RemoveUnit(hero) -> reassign) is preserved.
"""
import re
import sys

RX = re.compile(
    r"(?m)^([ \t]*)call RemoveUnit\(udg_ak\)[ \t]*\r?\n"
    r"(?:[ \t]*call RemoveUnit\(udg_chongwu\d+\)[ \t]*\r?\n)+"
    r"(?:[ \t]*call RemoveUnit\(gg_unit_[A-Za-z0-9_]+\)[ \t]*\r?\n)*"
)


def patch(text):
    def rep(m):
        return "%scall DoNothing() // IB: keep hero (pet-delete disabled)\n" % m.group(1)
    return RX.subn(rep, text)


def main():
    for p in sys.argv[1:]:
        raw = open(p, "rb").read()
        new, n = patch(raw.decode("utf-8", "surrogateescape"))
        print("%-20s pet-delete blocks neutralized: %d" % (p.replace("\\", "/").split("/")[-1], n))
        if n:
            with open(p, "wb") as f:
                f.write(new.encode("utf-8", "surrogateescape"))


if __name__ == "__main__":
    main()
