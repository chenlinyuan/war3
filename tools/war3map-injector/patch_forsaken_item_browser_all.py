"""Add all-item ID spawning and quest-item aliases to every Forsaken Kingdom zone."""

from pathlib import Path

import mpq_patch
import war3mpq


ROOT = Path(__file__).resolve().parents[2]
BASE = ROOT / "maps" / "port" / "forsaken_undead" / "base"
OUT = ROOT / "maps" / "port" / "forsaken_undead" / "_itemfix"
SKIP = {"UndeadRE01_03.systems.w3x"}  # Preserve its chapter-specific boss/drop fixes.


def replace_once(data, old, new, label):
    count = data.count(old)
    if count != 1:
        raise RuntimeError("%s: %s expected once, found %d" % (label, label, count))
    return data.replace(old, new, 1)


def patch_lua(data, label):
    nl = b"\r\n" if b"\r\n" in data[:10000] else b"\n"
    if b"ib_itemList[280]" not in data:
        item_count = b"    ib_itemCount = 280" + nl
        quest_items = nl.join((
            b"    ib_itemList[280] = 1651008611",
            b'    ib_itemName[280] = "\xe9\xbb\x91\xe6\x9a\x97\xe7\x8a\xac\xe4\xb9\x8b\xe8\xa1\x80"',
            b"    ib_itemCustom[280] = 0",
            b"    ib_itemNameGbk[280] = ib_itemName[280]",
            b"    ib_itemList[281] = 1986880099",
            b'    ib_itemName[281] = "\xe5\xb7\xa2\xe6\xaf\x8d\xe6\xaf\x92\xe6\xb6\xb2"',
            b"    ib_itemCustom[281] = 0",
            b"    ib_itemNameGbk[281] = ib_itemName[281]",
            b"    ib_itemCount = 282",
            b"",
        ))
        data = replace_once(data, item_count, quest_items, label + " item entries")

        add_match = (
            b"    if ((name == ib_addName) or "
            b"IB_StrEqCI(IB_IdStr(ib_itemList[ib_addIdx]), ib_addName)) then" + nl
        )
        add_match_fixed = (
            b"    if ((name == ib_addName) or "
            b"IB_StrEqCI(IB_IdStr(ib_itemList[ib_addIdx]), ib_addName) "
            b"or ((ib_addIdx == 280) and "
            b"(IB_StrEqCI(ib_addName, \"blood\") or IB_StrEqCI(ib_addName, \"dogblood\") "
            b"or IB_StrEqCI(ib_addName, \"darkhound\"))) "
            b"or ((ib_addIdx == 281) and "
            b"(IB_StrEqCI(ib_addName, \"venom\") or IB_StrEqCI(ib_addName, \"broodmother\")))) then" + nl
        )
        data = replace_once(data, add_match, add_match_fixed, label + " aliases")

    if b"FourCC(itemName)" not in data:
        add_item_start = (
            b"function IB_AddItem(p, itemName, count)" + nl
            + b"  if (count < 1) then" + nl
            + b"    count = 1" + nl
            + b"  end" + nl
        )
        add_item_fixed = (
            add_item_start
            + b"  if StringLength(itemName) == 4 then" + nl
            + b"    IB_AddGive(p, FourCC(itemName), count)" + nl
            + b"    return" + nl
            + b"  end" + nl
        )
        data = replace_once(data, add_item_start, add_item_fixed, label + " direct id")
    return data


def main():
    OUT.mkdir(parents=True, exist_ok=True)
    outputs = []
    for source in sorted(BASE.glob("*.systems.w3x")):
        if source.name in SKIP:
            continue
        archive = war3mpq.MPQArchive(str(source))
        try:
            data = archive.read_file("war3map.lua")
        finally:
            archive.close()
        if not data:
            raise RuntimeError("war3map.lua not found: %s" % source)
        updated = patch_lua(data, source.name)
        target_name = source.name.replace(".systems.w3x", ".w3x")
        target = OUT / target_name
        mpq_patch.patch(str(source), [("war3map.lua", updated)],
                        out_path=str(target), backup=False)
        check = war3mpq.MPQArchive(str(target))
        try:
            result = check.read_file("war3map.lua")
        finally:
            check.close()
        if result != updated:
            raise RuntimeError("read-back mismatch: %s" % target)
        for needle in (b"ib_itemCount = 282", b"ib_addIdx == 280", b"FourCC(itemName)"):
            if result.count(needle) < 1:
                raise RuntimeError("%s missing marker %r" % (target.name, needle))
        outputs.append(target)
        print("patched", target.name)
    print("total", len(outputs))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
