# -*- coding: utf-8 -*-
"""Replace Frostmourne's shared freeze timer with per-unit timers."""
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
    if b"function FR_Unfreeze takes" in data:
        raise SystemExit("per-unit freeze patch already exists")

    data = replace_once(
        data,
        b"group fr_freeze_group = null\n"
        b"hashtable fr_freeze_table = null\n"
        b"timer fr_freeze_timer = null\n",
        b"hashtable fr_freeze_table = null\n"
        b"hashtable fr_freeze_timer_table = null\n",
        "freeze globals")

    start = data.index(b"function FR_FreezeAir takes")
    end = data.index(b"function FR_OnSpell takes", start)
    functions = (
        b"function FR_Unfreeze takes nothing returns nothing\n"
        b"    local timer t = GetExpiredTimer()\n"
        b"    local integer timerKey = GetHandleId(t)\n"
        b"    local integer unitKey = LoadInteger(fr_freeze_timer_table, timerKey, 1)\n"
        b"    local unit u = LoadUnitHandle(fr_freeze_timer_table, timerKey, 0)\n"
        b"    if u != null and GetUnitTypeId(u) != 0 then\n"
        b"        call PauseUnit(u, false)\n"
        b"    endif\n"
        b"    call FlushChildHashtable(fr_freeze_table, unitKey)\n"
        b"    call FlushChildHashtable(fr_freeze_timer_table, timerKey)\n"
        b"    call DestroyTimer(t)\n"
        b"    set u = null\n"
        b"    set t = null\n"
        b"endfunction\n\n"
        b"function FR_FreezeAir takes unit u, real duration returns nothing\n"
        b"    local integer unitKey\n"
        b"    local integer timerKey\n"
        b"    local timer t\n"
        b"    if u == null or (not IsUnitType(u, UNIT_TYPE_FLYING) and not IsUnitType(u, UNIT_TYPE_STRUCTURE)) then\n"
        b"        return\n"
        b"    endif\n"
        b"    set unitKey = GetHandleId(u)\n"
        b"    if HaveSavedHandle(fr_freeze_table, unitKey, 0) then\n"
        b"        set t = LoadTimerHandle(fr_freeze_table, unitKey, 0)\n"
        b"    else\n"
        b"        set t = CreateTimer()\n"
        b"        set timerKey = GetHandleId(t)\n"
        b"        call SaveTimerHandle(fr_freeze_table, unitKey, 0, t)\n"
        b"        call SaveUnitHandle(fr_freeze_timer_table, timerKey, 0, u)\n"
        b"        call SaveInteger(fr_freeze_timer_table, timerKey, 1, unitKey)\n"
        b"        call PauseUnit(u, true)\n"
        b"    endif\n"
        b"    call TimerStart(t, duration, false, function FR_Unfreeze)\n"
        b"    set t = null\n"
        b"endfunction\n\n"
    )
    data = data[:start] + functions + data[end:]

    data = replace_once(
        data,
        b"    set fr_freeze_group = CreateGroup()\n"
        b"    set fr_freeze_table = InitHashtable()\n"
        b"    set fr_freeze_timer = CreateTimer()\n"
        b"    call TimerStart(fr_freeze_timer, 0.10, true, function FR_FreezeAirStep)\n",
        b"    set fr_freeze_table = InitHashtable()\n"
        b"    set fr_freeze_timer_table = InitHashtable()\n",
        "freeze init")

    output = os.path.abspath(args.output)
    os.makedirs(os.path.dirname(output), exist_ok=True)
    with open(output, "wb") as handle:
        handle.write(data)
    print("installed per-unit Frostmourne freeze timers")
    print(output)


if __name__ == "__main__":
    sys.exit(main())
