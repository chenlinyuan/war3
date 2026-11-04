"""Add the shared backpack and artifact items to the generated item-browser table."""

from pathlib import Path
import sys


OLD = b"        set ib_itemCount = 273\n"


def item_block(index, item_id, name):
    return (
        ("        set ib_itemList[%d] = '%s'\n" % (index, item_id)).encode("ascii")
        + ("        set ib_itemName[%d] = \"" % index).encode("ascii")
        + name.encode("utf-8")
        + b"\"\n"
        + ("        set ib_itemNameGbk[%d] = \"" % index).encode("ascii")
        + name.encode("gbk")
        + b"\"\n"
        + ("        set ib_itemCustom[%d] = 1\n" % index).encode("ascii")
    )


NEW = (
    item_block(273, "B30B", "\u82f1\u96c4\u88c5\u5907\u80cc\u5305")
    + item_block(274, "I000", "\u963f\u514b\u8499\u5fb7\u4e4b\u624b")
    + item_block(275, "I105", "\u971c\u4e4b\u54c0\u4f24")
    + b"        set ib_itemCount = 276\n"
)

CURRENT = (
    item_block(273, "B30B", "\u5251\u5723\u88c5\u5907\u80cc\u5305")
    + b"        set ib_itemCount = 274\n"
)

OLD_MATCH = (
    b"        if name == ib_addName or IB_StrEqCI(IB_IdStr(ib_itemList[ib_addIdx]), ib_addName) then\n"
)
NEW_MATCH = (
    b"        if name == ib_addName or IB_StrEqCI(IB_IdStr(ib_itemList[ib_addIdx]), ib_addName) "
    b"or (ib_addIdx == 273 and IB_StrEqCI(ib_addName, \"bag\")) "
    b"or (ib_addIdx == 274 and (IB_StrEqCI(ib_addName, \"hand\") or IB_StrEqCI(ib_addName, \"akhand\"))) "
    b"or (ib_addIdx == 275 and (IB_StrEqCI(ib_addName, \"frost\") or IB_StrEqCI(ib_addName, \"frostmourne\"))) then\n"
)


def main():
    path = Path(sys.argv[1])
    data = path.read_bytes()
    changed = False
    if data.count(OLD_MATCH) == 1:
        data = data.replace(OLD_MATCH, NEW_MATCH, 1)
        changed = True
    if data.count(CURRENT) == 1:
        data = data.replace(CURRENT, NEW, 1)
        changed = True
    elif data.count(OLD) == 1:
        data = data.replace(OLD, NEW, 1)
        changed = True
    elif data.count(NEW) != 1:
        raise SystemExit("expected one known item-browser tail")
    if not changed:
        print("already patched", path)
        return
    path.write_bytes(data)
    print("patched", path)


if __name__ == "__main__":
    main()
