#!/usr/bin/env python3
"""Add a save-independent compatibility timer and item command to a chapter."""

import os
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
INJECTOR = os.path.join(ROOT, "tools", "war3map-injector")
sys.path.insert(0, INJECTOR)

import mpq_patch  # noqa: E402
import war3mpq  # noqa: E402

MARKER = b"ALAS_FORSK_RUNTIME_COMPAT_V1"
BLOCK = r"""
-- ALAS_FORSK_RUNTIME_COMPAT_V1
do
  local function injectQuestItems()
    local g = GetUnitsOfPlayerAll(Player(1))
    local u = FirstOfGroup(g)
    while u ~= nil do
      if IsUnitType(u, UNIT_TYPE_HERO) == true and GetUnitState(u, UNIT_STATE_LIFE) > 0.0 then
        local x = GetUnitX(u)
        local y = GetUnitY(u)
        CreateItem(FourCC("cdhb"), x + 48.0, y)
        CreateItem(FourCC("cbmv"), x - 48.0, y)
        break
      end
      GroupRemoveUnit(g, u)
      u = FirstOfGroup(g)
    end
    DestroyGroup(g)
  end

  local function releaseWebPause()
    local all = GetUnitsInRectAll(GetPlayableMapRect())
    local u = FirstOfGroup(all)
    local hasWeb = false
    while u ~= nil do
      if GetUnitTypeId(u) == FourCC("h001") then
        hasWeb = true
        break
      end
      GroupRemoveUnit(all, u)
      u = FirstOfGroup(all)
    end
    DestroyGroup(all)
    if not hasWeb then
      return
    end

    local g = GetUnitsOfPlayerAll(Player(1))
    u = FirstOfGroup(g)
    while u ~= nil do
      if IsUnitType(u, UNIT_TYPE_HERO) == true then
        PauseUnitBJ(false, u)
        SetUnitTimeScalePercent(u, 100.0)
      end
      GroupRemoveUnit(g, u)
      u = FirstOfGroup(g)
    end
    DestroyGroup(g)
  end

  TimerStart(CreateTimer(), 6.0, false, injectQuestItems)
  TimerStart(CreateTimer(), 0.5, true, releaseWebPause)

  local trigger = CreateTrigger()
  TriggerRegisterPlayerChatEvent(trigger, Player(1), "alasfix", true)
  TriggerAddAction(trigger, function()
    injectQuestItems()
    releaseWebPause()
    DisplayTextToPlayer(Player(1), 0.0, 0.0, "|cff00ff00alasfix：任务物品已补充，蛛网暂停已解除。|r")
  end)
end
""".encode("utf-8")


def main():
    if len(sys.argv) != 3:
        raise SystemExit(
            "usage: patch_forsaken_runtime_compat.py INPUT_MAP OUTPUT_MAP"
        )
    source, destination = sys.argv[1:]
    if os.path.exists(destination):
        raise SystemExit("output already exists: " + destination)
    archive = war3mpq.MPQArchive(source)
    try:
        script = archive.read_file("war3map.lua")
    finally:
        archive.close()
    if not script:
        raise SystemExit("war3map.lua is missing")
    if MARKER in script:
        raise SystemExit("runtime compatibility block already present")
    updated = script.rstrip() + b"\r\n" + BLOCK + b"\r\n"
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
    for needle in (
        MARKER,
        b'CreateItem(FourCC("cdhb")',
        b'CreateItem(FourCC("cbmv")',
        b'GetUnitTypeId(u) == FourCC("h001")',
        b"PauseUnitBJ(false, u)",
        b'"alasfix"',
    ):
        if needle not in result:
            raise SystemExit("missing marker: %r" % (needle,))
    print("built", destination, "lua", len(updated))


if __name__ == "__main__":
    main()
