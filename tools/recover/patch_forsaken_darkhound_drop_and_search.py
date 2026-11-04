#!/usr/bin/env python3
"""Fix neutral darkhound drops and make item search results readable."""

import os
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
INJECTOR = os.path.join(ROOT, "tools", "war3map-injector")
sys.path.insert(0, INJECTOR)

import mpq_patch  # noqa: E402
import war3mpq  # noqa: E402

MARKER = b"ALAS_DARKHOUND_SEARCH_V1"


def replace_once(data, old, new):
    old_bytes = old.encode("utf-8")
    if data.count(old_bytes) != 1:
        raise RuntimeError(
            f"expected exactly one match, found {data.count(old_bytes)}"
        )
    return data.replace(old_bytes, new.encode("utf-8"), 1)


def patch_lua(data):
    if MARKER in data:
        raise RuntimeError("darkhound/search patch already present")

    registration_old = """function InitTrig_Darkhound_Blood_Drop()
  gg_trg_Darkhound_Blood_Drop = CreateTrigger()
  TriggerRegisterAnyUnitEventBJ(gg_trg_Darkhound_Blood_Drop, EVENT_PLAYER_UNIT_DEATH)
"""
    registration_new = """function InitTrig_Darkhound_Blood_Drop()
  gg_trg_Darkhound_Blood_Drop = CreateTrigger()
  -- ALAS_DARKHOUND_SEARCH_V1
  TriggerRegisterPlayerUnitEvent(gg_trg_Darkhound_Blood_Drop, Player(PLAYER_NEUTRAL_AGGRESSIVE), EVENT_PLAYER_UNIT_DEATH, nil)
"""
    data = replace_once(data, registration_old, registration_new)

    search_old = """      if (ib_itemCustom[ib_searchIdx] == 1) then
        ib_searchCusN = (ib_searchCusN + 1)
        if (ib_searchCusN <= 15) then
          ib_searchCus = __cat(ib_searchCus, name, "  ")
        end
      else
        ib_searchStdN = (ib_searchStdN + 1)
        if (ib_searchStdN <= 15) then
          ib_searchStd = __cat(ib_searchStd, name, "  ")
        end
      end
"""
    search_new = """      if (ib_itemCustom[ib_searchIdx] == 1) then
        ib_searchCusN = (ib_searchCusN + 1)
        if (ib_searchCusN <= 30) then
          IB_Message(ib_searchPlayer, __cat("自定义 ", name))
        end
      else
        ib_searchStdN = (ib_searchStdN + 1)
        if (ib_searchStdN <= 30) then
          IB_Message(ib_searchPlayer, __cat("原版 ", name))
        end
      end
"""
    data = replace_once(data, search_old, search_new)

    result_old = """      DisplayTextToPlayer(ib_searchPlayer, 0, 0, __cat("|cff00ff00[装备]|r 共找到 ", I2S(ib_searchFound), " 件"))
      if (ib_searchStdN > 0) then
        DisplayTextToPlayer(ib_searchPlayer, 0, 0, __cat("|cffaaaaaa原版(", I2S(ib_searchStdN), "):|r ", ib_searchStd))
      end
      if (ib_searchCusN > 0) then
        DisplayTextToPlayer(ib_searchPlayer, 0, 0, __cat("|cff00ff00自定义(", I2S(ib_searchCusN), "):|r ", ib_searchCus))
      end
"""
    result_new = """      IB_Message(ib_searchPlayer, __cat("共找到 ", I2S(ib_searchFound), " 件（原版 ", I2S(ib_searchStdN), "，自定义 ", I2S(ib_searchCusN), "）"))
      if ((ib_searchStdN > 30) or (ib_searchCusN > 30)) then
        IB_Message(ib_searchPlayer, "结果过多，每类最多显示 30 件，请使用更精确的关键词")
      end
"""
    data = replace_once(data, result_old, result_new)
    return data


def main():
    if len(sys.argv) != 3:
        raise SystemExit(
            "usage: patch_forsaken_darkhound_drop_and_search.py INPUT_MAP OUTPUT_MAP"
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
