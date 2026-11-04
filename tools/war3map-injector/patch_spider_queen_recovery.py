"""Patch the Forsaken Kingdom chapter 1 spider queen recovery and quest drop."""

from pathlib import Path
import sys

import mpq_patch
import war3mpq


ROOT = Path(__file__).resolve().parents[2]
SOURCE = ROOT / "maps" / "port" / "forsaken_undead" / "base" / "UndeadRE01.systems.w3x"
OUTPUT = ROOT / "maps" / "port" / "forsaken_undead" / "_spiderfix" / "UndeadRE01.w3x"

def replace_once(data, old, new, label):
    count = data.count(old)
    if count != 1:
        raise RuntimeError("%s expected once, found %d" % (label, count))
    return data.replace(old, new, 1)


def patch_lua(data):
    nl = b"\r\n" if b"\r\n" in data[:10000] else b"\n"
    helper = nl.join((
        b"function SQ_Fix_ReleaseCocoonVictim()",
        b"  ShowUnitShow(GetEnumUnit())",
        b"  PauseUnitBJ(false, GetEnumUnit())",
        b"  SetUnitPathing(GetEnumUnit(), true)",
        b"end",
        b"",
        b"function SQ_Fix_LoadRecovery()",
        b"  ForGroupBJ(udg_BF_SQ_CocoonGroup, SQ_Fix_ReleaseCocoonVictim)",
        b"  GroupClear(udg_BF_SQ_CocoonGroup)",
        b"end",
        b"",
        b"",
    ))
    create_cocoon = (
        b'  CreateNUnitsAtLoc(1, FourCC("nCoc"), udg_Player23_Spiders, '
        b'udg_BF_SQ_CocoonTempPoint, GetUnitFacing(udg_BF_SQ_CocoonTempUnit))' + nl
    )
    create_cocoon_fixed = (
        create_cocoon
        + b'  UnitApplyTimedLife(GetLastCreatedUnit(), FourCC("BTLF"), 20.0)' + nl
    )
    data = replace_once(data, create_cocoon, create_cocoon_fixed, "cocoon timeout")

    completed = b"function Trig_BF_Spider_Queen_Completed_Actions()" + nl
    data = replace_once(data, completed, helper + completed, "cocoon release helper")

    completed_start = (
        b"function Trig_BF_Spider_Queen_Completed_Actions()" + nl
        + b"  DisableTrigger(GetTriggeringTrigger())" + nl
    )
    completed_start_fixed = (
        completed_start
        + b"  ForGroupBJ(udg_BF_SQ_CocoonGroup, SQ_Fix_ReleaseCocoonVictim)" + nl
        + b"  GroupClear(udg_BF_SQ_CocoonGroup)" + nl
    )
    data = replace_once(data, completed_start, completed_start_fixed, "boss-death cocoon release")

    reward_sound = (
        b"  PlaySoundBJ(gg_snd_ItemReceived)" + nl
        + b"  if Trig_BF_Spider_Queen_Completed_Func039C() then" + nl
    )
    reward_sound_fixed = (
        b"  PlaySoundBJ(gg_snd_ItemReceived)" + nl
        + b'  CreateItem(FourCC("cbmv"), GetUnitX(udg_Boss_OQ04SpiderQueen), '
        b"GetUnitY(udg_Boss_OQ04SpiderQueen))" + nl
        + b"  if Trig_BF_Spider_Queen_Completed_Func039C() then" + nl
    )
    data = replace_once(data, reward_sound, reward_sound_fixed, "broodmother venom drop")

    main_start = b"function main()" + nl + b"  SetCameraBounds("
    main_start_fixed = (
        b"function main()" + nl
        + b"  local sq_fix_recovery_trigger = CreateTrigger()" + nl
        + b"  TriggerRegisterTimerEventSingle(sq_fix_recovery_trigger, 3.0)" + nl
        + b"  TriggerAddAction(sq_fix_recovery_trigger, SQ_Fix_LoadRecovery)" + nl
        + b"  SetCameraBounds("
    )
    data = replace_once(data, main_start, main_start_fixed, "saved-game cocoon recovery")
    return data


def main():
    if len(sys.argv) > 1:
        source = Path(sys.argv[1]).resolve()
    else:
        source = SOURCE
    output = OUTPUT
    output.parent.mkdir(parents=True, exist_ok=True)

    archive = war3mpq.MPQArchive(str(source))
    try:
        data = archive.read_file("war3map.lua")
    finally:
        archive.close()
    if not data:
        raise RuntimeError("war3map.lua not found: %s" % source)
    updated = patch_lua(data)
    mpq_patch.patch(str(source), [("war3map.lua", updated)], out_path=str(output), backup=False)

    check = war3mpq.MPQArchive(str(output))
    try:
        result = check.read_file("war3map.lua")
    finally:
        check.close()
    if result != updated:
        raise RuntimeError("war3map.lua read-back mismatch")
    for needle in (b"UnitApplyTimedLife(GetLastCreatedUnit()", b'CreateItem(FourCC("cbmv")',
                   b"SQ_Fix_ReleaseCocoonVictim", b"SQ_Fix_LoadRecovery"):
        if result.count(needle) < 1:
            raise RuntimeError("missing patch marker: %r" % needle)
    print("patched", output)
    print("lua bytes", len(updated))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
