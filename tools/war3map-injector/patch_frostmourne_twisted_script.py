# -*- coding: utf-8 -*-
"""Register Frostmourne in Twisted Meadows' item browser."""
import argparse
import os
import sys


def replace_once(data, old, new, label):
    count = data.count(old)
    if count != 1:
        raise SystemExit("%s: expected 1 occurrence, found %d" % (label, count))
    return data.replace(old, new, 1)


def patch(path):
    data = open(path, "rb").read()
    data = data.replace(b"\r\n", b"\n")
    nl = b"\n"
    if b"ib_itemList[284]" in data:
        raise SystemExit("Frostmourne item-browser entry already exists")

    last_item = data.find(b"    set ib_itemList[283] = 'I114'")
    if last_item < 0:
        raise SystemExit("Twisted item table ending at 283 was not found")
    fill_end = data.find(b"endfunction", last_item)
    if fill_end < 0:
        raise SystemExit("item fill function end was not found")

    entry = nl.join((
        b"    set ib_itemList[284] = 'I105'",
        b'    set ib_itemName[284] = "' + "霜之哀伤".encode("utf-8") + b'"',
        b"    set ib_itemCustom[284] = 1",
        b'    set ib_itemNameGbk[284] = "' + "霜之哀伤".encode("gbk") + b'"',
        b"",
    ))
    data = data[:fill_end] + entry + data[fill_end:]
    data = replace_once(
        data,
        b"        set ib_itemCount = 284" + nl,
        b"        set ib_itemCount = 285" + nl,
        "item count")

    function_name = b"function IB_IsItemAbility takes integer abilId returns boolean" + nl
    function_pos = data.find(function_name)
    if function_pos < 0:
        raise SystemExit("IB_IsItemAbility was not found")
    insertion = function_pos + len(function_name)
    guard = (
        b"    if abilId == 'A105' or abilId == 'A106' or abilId == 'A107' or "
        b"abilId == 'A108' or abilId == 'A109' then" + nl
        + b"        return true" + nl
        + b"    elseif abilId == 'AI2m'")
    old_guard = b"    if abilId == 'AI2m'"
    if data[insertion:insertion + len(old_guard)] != old_guard:
        raise SystemExit("IB_IsItemAbility first branch has changed")
    data = data[:insertion] + guard + data[insertion + len(old_guard):]

    old_match = (
        b"        if name == ib_addName or "
        b"IB_StrEqCI(IB_IdStr(ib_itemList[ib_addIdx]), ib_addName) then" + nl)
    new_match = (
        b'        if ib_addName == "frostmourne" or ib_addName == "frost" then' + nl
        + b"            set ib_addFoundId = 'I105'" + nl
        + b"            set ib_addFoundIdx = 284" + nl
        + b"            set ib_addIdx = ib_itemCount" + nl
        + b"        elseif name == ib_addName or "
        + b"IB_StrEqCI(IB_IdStr(ib_itemList[ib_addIdx]), ib_addName) then" + nl)
    data = replace_once(data, old_match, new_match, "additem alias")

    with open(path, "wb") as handle:
        handle.write(data)
    print("patched %s (%d bytes)" % (path, len(data)))


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("map_script")
    args = parser.parse_args()
    patch(args.map_script)
