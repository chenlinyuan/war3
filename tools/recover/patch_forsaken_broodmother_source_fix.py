#!/usr/bin/env python3
"""Fix broodmother drops and web-gate handling in a clean Forest chapter.

This patch intentionally does not add a broodmother recovery chat command.
New saves use the corrected neutral-hostile death events and the gate is made
vulnerable immediately before it is destroyed. The separately requested
selected-unit ``unpause`` command may be present on the source map.
"""

import os
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
INJECTOR = os.path.join(ROOT, "tools", "war3map-injector")
sys.path.insert(0, INJECTOR)

import mpq_patch  # noqa: E402
import war3mpq  # noqa: E402

MARKER = b"ALAS_BROODMOTHER_SOURCE_FIX_V1"
FORBIDDEN_COMMANDS = (b"broodfix",)


def replace_once(data, old, new):
    old_bytes = old.encode("utf-8")
    count = data.count(old_bytes)
    if count != 1:
        raise RuntimeError(f"expected exactly one match, found {count}")
    return data.replace(old_bytes, new.encode("utf-8"), 1)


def patch_lua(data):
    if MARKER in data:
        raise RuntimeError("broodmother source fix already present")
    for command in FORBIDDEN_COMMANDS:
        if command in data:
            raise RuntimeError(
                "refusing to patch a map containing recovery command: "
                + command.decode("ascii")
            )

    death_old = """function InitTrig_Brood_Mother_Death()
  gg_trg_Brood_Mother_Death = CreateTrigger()
  TriggerRegisterAnyUnitEventBJ(gg_trg_Brood_Mother_Death, EVENT_PLAYER_UNIT_DEATH)
"""
    death_new = """function InitTrig_Brood_Mother_Death()
  gg_trg_Brood_Mother_Death = CreateTrigger()
  -- ALAS_BROODMOTHER_SOURCE_FIX_V1
  TriggerRegisterAnyUnitEventBJ(gg_trg_Brood_Mother_Death, EVENT_PLAYER_UNIT_DEATH)
  TriggerRegisterPlayerUnitEvent(gg_trg_Brood_Mother_Death, Player(PLAYER_NEUTRAL_AGGRESSIVE), EVENT_PLAYER_UNIT_DEATH, nil)
"""
    data = replace_once(data, death_old, death_new)

    web_death_old = """function InitTrig_Brood_Mother_Web_Dies()
  gg_trg_Brood_Mother_Web_Dies = CreateTrigger()
  TriggerRegisterAnyUnitEventBJ(gg_trg_Brood_Mother_Web_Dies, EVENT_PLAYER_UNIT_DEATH)
"""
    web_death_new = """function InitTrig_Brood_Mother_Web_Dies()
  gg_trg_Brood_Mother_Web_Dies = CreateTrigger()
  TriggerRegisterAnyUnitEventBJ(gg_trg_Brood_Mother_Web_Dies, EVENT_PLAYER_UNIT_DEATH)
  TriggerRegisterPlayerUnitEvent(gg_trg_Brood_Mother_Web_Dies, Player(PLAYER_NEUTRAL_AGGRESSIVE), EVENT_PLAYER_UNIT_DEATH, nil)
"""
    data = replace_once(data, web_death_old, web_death_new)

    wall_old = """function Trig_Brood_Mother_Destroy_Wall_Actions()
  KillDestructable(gg_dest_BSG3_1304)
end
"""
    wall_new = """function Trig_Brood_Mother_Destroy_Wall_Actions()
  SetDestructableInvulnerableBJ(gg_dest_BSG3_1304, false)
  KillDestructable(gg_dest_BSG3_1304)
end
"""
    data = replace_once(data, wall_old, wall_new)
    return data


def main():
    if len(sys.argv) != 3:
        raise SystemExit(
            "usage: patch_forsaken_broodmother_source_fix.py INPUT_MAP OUTPUT_MAP"
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
