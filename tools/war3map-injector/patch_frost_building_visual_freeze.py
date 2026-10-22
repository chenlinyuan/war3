# -*- coding: utf-8 -*-
"""Freeze neutral structures and stop their animations while paused."""
import argparse
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)

import war3mpq as W  # noqa: E402


def replace_once(data, old, new, label):
    count = data.count(old)
    if count != 1:
        raise SystemExit("%s: expected 1 occurrence, found %d" % (label, count))
    return data.replace(old, new, 1)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("map")
    parser.add_argument("output")
    args = parser.parse_args()

    archive = W.MPQArchive(os.path.abspath(args.map))
    try:
        data = archive.read_file("war3map.j")
    finally:
        archive.close()
    if not data:
        raise SystemExit("map has no war3map.j")
    data = data.replace(b"\r\n", b"\n")
    if b"function FR_CanAffect takes" in data:
        raise SystemExit("neutral structure freeze patch already exists")

    data = replace_once(
        data,
        b"        call PauseUnit(u, false)\n"
        b"    endif\n"
        b"    call FlushChildHashtable(fr_freeze_table, unitKey)\n",
        b"        call PauseUnit(u, false)\n"
        b"        call SetUnitTimeScale(u, 1.0)\n"
        b"    endif\n"
        b"    call FlushChildHashtable(fr_freeze_table, unitKey)\n",
        "freeze restore time scale")
    data = replace_once(
        data,
        b"        call SaveInteger(fr_freeze_timer_table, timerKey, 1, unitKey)\n"
        b"        call PauseUnit(u, true)\n"
        b"    endif\n",
        b"        call SaveInteger(fr_freeze_timer_table, timerKey, 1, unitKey)\n"
        b"        call PauseUnit(u, true)\n"
        b"        call SetUnitTimeScale(u, 0.0)\n"
        b"    endif\n",
        "apply freeze time scale")

    helper = (
        b"function FR_CanAffect takes unit caster, unit target returns boolean\n"
        b"    local integer ownerId\n"
        b"    if caster == null or target == null then\n"
        b"        return false\n"
        b"    endif\n"
        b"    if IsUnitEnemy(target, GetOwningPlayer(caster)) then\n"
        b"        return true\n"
        b"    endif\n"
        b"    if not IsUnitType(target, UNIT_TYPE_STRUCTURE) then\n"
        b"        return false\n"
        b"    endif\n"
        b"    set ownerId = GetPlayerId(GetOwningPlayer(target))\n"
        b"    return ownerId == PLAYER_NEUTRAL_PASSIVE or ownerId == PLAYER_NEUTRAL_AGGRESSIVE\n"
        b"endfunction\n\n"
    )
    data = replace_once(
        data,
        b"function FR_OnSpell takes nothing returns nothing\n",
        helper + b"function FR_OnSpell takes nothing returns nothing\n",
        "neutral structure helper")
    data = replace_once(
        data,
        b"        if target != caster and IsUnitAliveBJ(target) and IsUnitEnemy(target, GetOwningPlayer(caster)) then\n",
        b"        if target != caster and IsUnitAliveBJ(target) and FR_CanAffect(caster, target) then\n",
        "neutral structure filter")

    output = os.path.abspath(args.output)
    os.makedirs(os.path.dirname(output), exist_ok=True)
    with open(output, "wb") as handle:
        handle.write(data)
    print("patched neutral structure freeze and animation time scale")
    print(output)


if __name__ == "__main__":
    sys.exit(main())
