#!/usr/bin/env python3
"""Clear hero pause state around the Pain Beyond Death banshee quest."""

import os
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
INJECTOR = os.path.join(ROOT, "tools", "war3map-injector")
sys.path.insert(0, INJECTOR)

import mpq_patch  # noqa: E402
import war3mpq  # noqa: E402

MARKER = b"ALAS_BANSHEE_UNPAUSE_V1"
UNPAUSE = """  PauseUnitBJ(false, udg_Hero_Anya)
  PauseUnitBJ(false, udg_Hero_Garek)
  SetUserControlForceOn(GetPlayersAll())
"""


def replace_once(data, old, new):
    old_bytes = old.encode("utf-8")
    if data.count(old_bytes) != 1:
        raise RuntimeError(f"expected exactly one match, found {data.count(old_bytes)}")
    return data.replace(old_bytes, new.encode("utf-8"), 1)


def patch_lua(data):
    if MARKER in data:
        raise RuntimeError("banshee unpause patch already present")

    complete_old = """function Trig_OQ_05_Banshee_Complete_Actions()
  DisableTrigger(GetTriggeringTrigger())
  ConditionalTriggerExecute(gg_trg_OQ_05_Banshee_Create)
"""
    complete_new = (
        "function Trig_OQ_05_Banshee_Complete_Actions()\n"
        "  DisableTrigger(GetTriggeringTrigger())\n"
        + UNPAUSE
        + "  ConditionalTriggerExecute(gg_trg_OQ_05_Banshee_Create)\n"
    )
    data = replace_once(data, complete_old, complete_new)

    sync_old = """  if Trig_OQ_05_Banshee_Sync_Func016C() then
    return
  else
  end
  QuestItemSetCompletedBJ(udg_OQReq_SootheBanshees01, true)
"""
    sync_new = (
        "  if Trig_OQ_05_Banshee_Sync_Func016C() then\n"
        "    return\n"
        "  else\n"
        "  end\n"
        + UNPAUSE
        + "  QuestItemSetCompletedBJ(udg_OQReq_SootheBanshees01, true)\n"
    )
    data = replace_once(data, sync_old, sync_new)

    created_old = """  BlzSetUnitName(GetLastCreatedUnit(), udg_LocaleNameKaelystia)
  SetUnitInvulnerable(GetLastCreatedUnit(), true)
end
"""
    created_new = (
        "  BlzSetUnitName(GetLastCreatedUnit(), udg_LocaleNameKaelystia)\n"
        "  SetUnitInvulnerable(GetLastCreatedUnit(), true)\n"
        + UNPAUSE
        + "end\n"
    )
    data = replace_once(data, created_old, created_new)

    watchdog = """
-- ALAS_BANSHEE_UNPAUSE_V1
do
  local trigger = CreateTrigger()
  TriggerRegisterAnyUnitEventBJ(trigger, EVENT_PLAYER_UNIT_DEATH)
  TriggerAddAction(trigger, function()
    if GetUnitTypeId(GetDyingUnit()) == FourCC("uban") and udg_OQBansheeProgression >= 1 and udg_OQBansheeProgression < 3 then
      PauseUnitBJ(false, udg_Hero_Anya)
      PauseUnitBJ(false, udg_Hero_Garek)
      SetUserControlForceOn(GetPlayersAll())
    end
  end)
end
"""
    data = data.rstrip() + b"\n" + watchdog.encode("utf-8")
    return data


def main():
    if len(sys.argv) != 3:
        raise SystemExit(
            "usage: patch_forsaken_banshee_unpause.py INPUT_MAP OUTPUT_MAP"
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
