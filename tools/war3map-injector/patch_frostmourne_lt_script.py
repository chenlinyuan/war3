# -*- coding: utf-8 -*-
"""Add the Lost Temple Frostmourne item to the item-browser script."""
import sys


def replace_once(data, old, new, label):
    count = data.count(old)
    if count != 1:
        raise SystemExit("%s: expected 1 occurrence, found %d" % (label, count))
    return data.replace(old, new, 1)


def patch(path):
    data = open(path, "rb").read()

    data = replace_once(
        data,
        b"    local integer added = 0\r\n"
        b"    if u == null then\r\n",
        b"    local integer added = 0\r\n"
        b"    local integer attempts = 0\r\n"
        b"    if u == null then\r\n",
        "additem attempt counter")

    data = replace_once(
        data,
        b"    loop\r\n"
        b"        exitwhen added >= count\r\n"
        b"        set it = CreateItem(itemId, x, y)\r\n",
        b"    loop\r\n"
        b"        exitwhen added >= count or attempts >= count * 3\r\n"
        b"        set attempts = attempts + 1\r\n"
        b"        set it = CreateItem(itemId, x, y)\r\n",
        "additem finite creation loop")

    anchor = (
        b'    set ib_itemList[273] = \'I000\'\r\n'
        b'    set ib_itemName[273] = "\xe9\x98\xbf\xe5\x85\x8b\xe8\x92\x99'
        b'\xe5\xbe\xb7\xe4\xb9\x8b\xe6\x89\x8b"\r\n'
        b'    set ib_itemCustom[273] = 1\r\n'
        b'    set ib_itemNameGbk[273] = "\xb0\xa2\xbf\xcb\xc3\xc9\xb5\xc2'
        b'\xd6\xae\xca\xd6"\r\n'
    )
    added = anchor + (
        b'    set ib_itemList[274] = \'I105\'\r\n'
        b'    set ib_itemName[274] = "\xe9\x9c\x9c\xe4\xb9\x8b\xe5\x93\x80'
        b'\xe4\xbc\xa4"\r\n'
        b'    set ib_itemCustom[274] = 1\r\n'
        b'    set ib_itemNameGbk[274] = "\xcb\xaa\xd6\xae\xb0\xa7\xc9\xcb"\r\n'
    )
    if b'ib_itemList[274]' not in data:
        data = replace_once(data, anchor, added, "item browser entry")

    data = replace_once(
        data,
        b"        if name == ib_addName or IB_StrEqCI(IB_IdStr(ib_itemList[ib_addIdx]), ib_addName) then\r\n",
        b'        if ib_addName == "frostmourne" or ib_addName == "frost" then\r\n'
        b"            set ib_addFoundId = 'I105'\r\n"
        b"            set ib_addFoundIdx = 274\r\n"
        b"            set ib_addIdx = ib_itemCount\r\n"
        b"        elseif name == ib_addName or IB_StrEqCI(IB_IdStr(ib_itemList[ib_addIdx]), ib_addName) then\r\n",
        "additem alias")

    data = replace_once(
        data,
        b"function IB_IsItemAbility takes integer abilId returns boolean\r\n"
        b"    if abilId == 'AI2m'",
        b"function IB_IsItemAbility takes integer abilId returns boolean\r\n"
        b"    if abilId == 'A105' or abilId == 'A106' or abilId == 'A107' then\r\n"
        b"        return true\r\n"
        b"    elseif abilId == 'AI2m'",
        "item ability protection")

    data = replace_once(data, b"        set ib_itemCount = 274\r\n",
                        b"        set ib_itemCount = 275\r\n", "item count")
    open(path, "wb").write(data)
    print("patched %s (%d bytes)" % (path, len(data)))


if __name__ == "__main__":
    if len(sys.argv) != 2:
        raise SystemExit("usage: patch_frostmourne_lt_script.py MAP_SCRIPT")
    patch(sys.argv[1])
