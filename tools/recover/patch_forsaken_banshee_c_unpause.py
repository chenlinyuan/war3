#!/usr/bin/env python3
"""Restore Anya and Garek after Kaelystia's third-banshee dialogue."""

import os
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
INJECTOR = os.path.join(ROOT, "tools", "war3map-injector")
sys.path.insert(0, INJECTOR)

import mpq_patch  # noqa: E402
import war3mpq  # noqa: E402

MARKER = b"ALAS_BANSHEE_C_RESTORE_V1"


def replace_once(data, old, new):
    old_bytes = old.encode("utf-8")
    if data.count(old_bytes) != 1:
        raise RuntimeError(
            f"expected exactly one match, found {data.count(old_bytes)}"
        )
    return data.replace(old_bytes, new.encode("utf-8"), 1)


def patch_lua(data):
    if MARKER in data:
        raise RuntimeError("Kaelystia unpause patch already present")

    enter_old = """  PlayDialogueFromSpeakerEx(udg_PlayerGroup_User, udg_Banshee_CHero, FourCC("Nb03"), gg_snd_BCEnterBanshee, bj_TIMETYPE_ADD, 0, true)
  VolumeGroupResetBJ()
  QueuedTriggerRemoveBJ(GetTriggeringTrigger())
"""
    enter_new = """  PlayDialogueFromSpeakerEx(udg_PlayerGroup_User, udg_Banshee_CHero, FourCC("Nb03"), gg_snd_BCEnterBanshee, bj_TIMETYPE_ADD, 0, true)
  VolumeGroupResetBJ()
  -- ALAS_BANSHEE_C_RESTORE_V1
  PauseUnitBJ(false, udg_Hero_Anya)
  PauseUnitBJ(false, udg_Hero_Garek)
  QueuedTriggerRemoveBJ(GetTriggeringTrigger())
"""
    data = replace_once(data, enter_old, enter_new)

    end_old = """  ForGroupBJ(udg_CS_PauseUGroup, Trig_Banshee_C_Enter_Camera_Steal_End_Q_Func008A)
  GroupClear(udg_CS_PauseUGroup)
  QueuedTriggerRemoveBJ(GetTriggeringTrigger())
"""
    end_new = """  ForGroupBJ(udg_CS_PauseUGroup, Trig_Banshee_C_Enter_Camera_Steal_End_Q_Func008A)
  PauseUnitBJ(false, udg_Hero_Anya)
  PauseUnitBJ(false, udg_Hero_Garek)
  GroupClear(udg_CS_PauseUGroup)
  QueuedTriggerRemoveBJ(GetTriggeringTrigger())
"""
    data = replace_once(data, end_old, end_new)

    fight_old = """  udg_Music_Current = udg_Music_Boss
  PlayMusic(udg_Music_Current)
  PauseUnitBJ(false, udg_Banshee_CHero)
"""
    fight_new = """  udg_Music_Current = udg_Music_Boss
  PlayMusic(udg_Music_Current)
  PauseUnitBJ(false, udg_Hero_Anya)
  PauseUnitBJ(false, udg_Hero_Garek)
  PauseUnitBJ(false, udg_Banshee_CHero)
"""
    data = replace_once(data, fight_old, fight_new)
    return data


def main():
    if len(sys.argv) != 3:
        raise SystemExit(
            "usage: patch_forsaken_banshee_c_unpause.py INPUT_MAP OUTPUT_MAP"
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
