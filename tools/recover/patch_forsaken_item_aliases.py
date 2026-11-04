#!/usr/bin/env python3
"""Fix item creation hangs and add direct Chinese aliases for quest items."""

import os
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
INJECTOR = os.path.join(ROOT, "tools", "war3map-injector")
sys.path.insert(0, INJECTOR)

import mpq_patch  # noqa: E402
import war3mpq  # noqa: E402


OLD_GIVE = """  while true do
    if (added >= count) then break end
    it = CreateItem(itemId, x, y)
    if (it ~= nil) then
      if (not UnitAddItem(u, it)) then
        SetItemPosition(it, x, y)
      end
      added = (added + 1)
    end
    it = nil
  end
"""

NEW_GIVE = """  while true do
    if (added >= count) then break end
    it = CreateItem(itemId, x, y)
    if (it == nil) then
      break
    end
    if (not UnitAddItem(u, it)) then
      SetItemPosition(it, x, y)
    end
    added = (added + 1)
    it = nil
  end
"""

OLD_ADD_START = """function IB_AddItem(p, itemName, count)
  if (count < 1) then
    count = 1
  end
  if StringLength(itemName) == 4 then
    IB_AddGive(p, FourCC(itemName), count)
    return
  end
"""

NEW_ADD_START = """function IB_AddItem(p, itemName, count)
  if (count < 1) then
    count = 1
  end
  if ((itemName == "cdhb") or (itemName == "黑暗犬之血") or IB_StrEqCI(itemName, "dogblood") or IB_StrEqCI(itemName, "blood")) then
    IB_AddGive(p, FourCC("cdhb"), count)
    return
  end
  if ((itemName == "cbmv") or (itemName == "巢母毒液") or IB_StrEqCI(itemName, "broodmother") or IB_StrEqCI(itemName, "venom")) then
    IB_AddGive(p, FourCC("cbmv"), count)
    return
  end
  if StringLength(itemName) == 4 then
    IB_AddGive(p, FourCC(itemName), count)
    return
  end
"""


def replace_once(data, old, new):
    for newline in ("\n", "\r\n"):
        old_bytes = old.replace("\n", newline).encode("utf-8")
        new_bytes = new.replace("\n", newline).encode("utf-8")
        count = data.count(old_bytes)
        if count == 1:
            return data.replace(old_bytes, new_bytes, 1)
    raise RuntimeError("expected exactly one match")


def patch_lua(data):
    data = replace_once(data, OLD_GIVE, NEW_GIVE)
    data = replace_once(data, OLD_ADD_START, NEW_ADD_START)
    for marker in (
        b'FourCC("cdhb")',
        b'FourCC("cbmv")',
        "黑暗犬之血".encode("utf-8"),
        "巢母毒液".encode("utf-8"),
        b"if (it == nil) then",
    ):
        if marker not in data:
            raise RuntimeError(f"missing marker {marker!r}")
    return data


def main():
    if len(sys.argv) != 3:
        raise SystemExit(
            "usage: patch_forsaken_item_aliases.py INPUT_MAP OUTPUT_MAP"
        )
    source, destination = sys.argv[1:]
    if os.path.exists(destination):
        raise SystemExit("output already exists: " + destination)
    archive = war3mpq.MPQArchive(source)
    try:
        lua = archive.read_file("war3map.lua")
    finally:
        archive.close()
    if not lua:
        raise SystemExit("war3map.lua is missing")
    updated = patch_lua(lua)
    mpq_patch.patch(
        source,
        [("war3map.lua", updated)],
        out_path=destination,
        backup=False,
    )
    check = war3mpq.MPQArchive(destination)
    try:
        result = check.read_file("war3map.lua")
    finally:
        check.close()
    if result != updated:
        raise SystemExit("war3map.lua read-back mismatch")
    print("built", destination, "lua", len(lua), "->", len(updated))


if __name__ == "__main__":
    main()
