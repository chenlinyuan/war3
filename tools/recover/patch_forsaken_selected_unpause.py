#!/usr/bin/env python3
"""Add an ASCII chat command that unpauses the currently selected unit."""

import os
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
INJECTOR = os.path.join(ROOT, "tools", "war3map-injector")
sys.path.insert(0, INJECTOR)

import mpq_patch  # noqa: E402
import war3mpq  # noqa: E402

MARKER = b"ALAS_SELECTED_UNPAUSE_V1"


def replace_once(data, old, new):
    old_bytes = old.encode("utf-8")
    if data.count(old_bytes) != 1:
        raise RuntimeError(
            f"expected exactly one match, found {data.count(old_bytes)}"
        )
    return data.replace(old_bytes, new.encode("utf-8"), 1)


def patch_lua(data):
    if MARKER in data:
        raise RuntimeError("selected-unit unpause command already present")

    command_old = """  elseif IB_StrEqCI(cmd, "fingertest2") then
    IB_FingerAddTest2(p)
  end
end
"""
    command_new = """  elseif IB_StrEqCI(cmd, "fingertest2") then
    IB_FingerAddTest2(p)
  elseif IB_StrEqCI(cmd, "unpause") then
    -- ALAS_SELECTED_UNPAUSE_V1
    local u = IB_GetSelectedUnit(p)
    if (u == nil) then
      IB_Message(p, "请先选中需要恢复暂停的单位")
    else
      PauseUnitBJ(false, u)
      SetUnitTimeScale(u, 1.0)
      SetUserControlForceOn(udg_PlayerGroup_User)
      IB_Message(p, __cat("已解除 ", GetUnitName(u), " 的暂停"))
      u = nil
    end
  end
end
"""
    data = replace_once(data, command_old, command_new)

    registration_old = """    TriggerRegisterPlayerChatEvent(t, Player(i), "ibcount", false)
    i = (i + 1)
"""
    registration_new = """    TriggerRegisterPlayerChatEvent(t, Player(i), "ibcount", false)
    TriggerRegisterPlayerChatEvent(t, Player(i), "unpause", false)
    i = (i + 1)
"""
    data = replace_once(data, registration_old, registration_new)
    return data


def main():
    if len(sys.argv) != 3:
        raise SystemExit(
            "usage: patch_forsaken_selected_unpause.py INPUT_MAP OUTPUT_MAP"
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
