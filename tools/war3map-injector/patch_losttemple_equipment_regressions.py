#!/usr/bin/env python3
"""Patch LostTemple Frostmourne and Warglaive regressions in place.

The source map must already contain the managed ALAS equipment runtime.
This tool:

* removes Frostmourne's fixed 9.5-second cast guard and uses one spell event;
* keeps Warglaive A111 as a one-level passive whose Isx1 field is written at
  runtime as total agility * 2%, with no Warglaive-specific cap;
* adds the historical 0.05-second equipment resync so A111 exists before
  WGL_SyncAttackSpeed writes the field;
* removes the stale "no upper limit" text from Warglaive's item tooltip.
"""

from __future__ import annotations

import argparse
import os
import re
import shutil
import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path[:0] = [
    str(HERE),
    str(ROOT / "tools" / "_devos-map-doctor" / "devos-map-doctor-main"),
]

import war3mpq as W  # noqa: E402
from doctor.data import objects as OBJ  # noqa: E402
from jass_gate import check as jass_check  # noqa: E402
from port_item_skill_campaign import (  # noqa: E402
    read_objects_from_path,
    set_object_mod_value,
)


SYNC_ATTACK_SPEED = """function WGL_ClearAttackSpeedAbility takes unit u returns nothing
    if u == null or GetUnitTypeId(u) == 0 then
        return
    endif
    if GetUnitAbilityLevel(u, 'A111') > 0 then
        call UnitMakeAbilityPermanent(u, false, 'A111')
        call UnitRemoveAbility(u, 'A111')
    endif
endfunction

function WGL_SyncAttackSpeed takes unit u returns nothing
    local integer level
    if u == null or GetUnitTypeId(u) == 0 then
        return
    endif
    if not IsUnitType(u, UNIT_TYPE_HERO) then
        return
    endif
    if not WGL_HasWarglaive(u) then
        call WGL_ClearAttackSpeedAbility(u)
        return
    endif
    set level = GetHeroAgi(u, true) + 1
    if level < 1 then
        set level = 1
    elseif level > WGL_ATTACK_SPEED_MAX_LEVEL then
        set level = WGL_ATTACK_SPEED_MAX_LEVEL
    endif
    if GetUnitAbilityLevel(u, 'A111') == 0 then
        call UnitAddAbility(u, 'A111')
        call UnitMakeAbilityPermanent(u, true, 'A111')
    endif
    if GetUnitAbilityLevel(u, 'A111') != level then
        call SetUnitAbilityLevel(u, 'A111', level)
    endif
    call BlzUnitHideAbility(u, 'A111', true)
endfunction"""


ON_ITEM_EVENT = """function WGL_OnItemEvent takes nothing returns nothing
    local unit u
    local item it
    local integer unitId
    local real cooldownRemaining
    set u = GetTriggerUnit()
    set it = GetManipulatedItem()
    if u == null or GetUnitTypeId(u) == 0 then
        set it = null
        set u = null
        return
    endif
    if GetTriggerEventId() == EVENT_PLAYER_UNIT_DROP_ITEM and it != null and GetItemTypeId(it) == 'I106' then
        call WGL_ClearAttackSpeedAbility(u)
        if GetUnitAbilityLevel(u, 'A113') > 0 then
            set unitId = GetHandleId(u)
            set cooldownRemaining = BlzGetUnitAbilityCooldownRemaining(u, 'A113')
            if cooldownRemaining > 0.0 then
                call SaveReal(WGL_COOLDOWN_HT, unitId, 0, TimerGetElapsed(WGL_COOLDOWN_CLOCK) + cooldownRemaining)
            else
                call FlushChildHashtable(WGL_COOLDOWN_HT, unitId)
            endif
            call UnitRemoveAbility(u, 'A113')
        endif
        set it = null
        set u = null
        return
    endif
    call WGL_SyncUnit(u)
    call WGL_ScheduleSync(u)
    set it = null
    set u = null
endfunction"""


SYNC_UNIT = """function WGL_SyncUnit takes unit u returns nothing
    local integer unitId
    local real cooldownRemaining
    local real cooldownExpires
    if u == null or GetUnitTypeId(u) == 0 then
        return
    endif
    if not IsUnitType(u, UNIT_TYPE_HERO) then
        return
    endif
    if WGL_HasWarglaive(u) then
        call WGL_SyncAttackSpeed(u)
        if GetUnitAbilityLevel(u, 'A113') == 0 then
            call UnitAddAbility(u, 'A113')
            call UnitMakeAbilityPermanent(u, true, 'A113')
            set unitId = GetHandleId(u)
            set cooldownExpires = LoadReal(WGL_COOLDOWN_HT, unitId, 0)
            set cooldownRemaining = cooldownExpires - TimerGetElapsed(WGL_COOLDOWN_CLOCK)
            if cooldownRemaining > 0.0 then
                call BlzStartUnitAbilityCooldown(u, 'A113', cooldownRemaining)
            endif
            call FlushChildHashtable(WGL_COOLDOWN_HT, unitId)
        endif
    else
        call WGL_ClearAttackSpeedAbility(u)
        if GetUnitAbilityLevel(u, 'A113') > 0 then
            set unitId = GetHandleId(u)
            set cooldownRemaining = BlzGetUnitAbilityCooldownRemaining(u, 'A113')
            if cooldownRemaining > 0.0 then
                call SaveReal(WGL_COOLDOWN_HT, unitId, 0, TimerGetElapsed(WGL_COOLDOWN_CLOCK) + cooldownRemaining)
            else
                call FlushChildHashtable(WGL_COOLDOWN_HT, unitId)
            endif
            call UnitRemoveAbility(u, 'A113')
        endif
    endif
endfunction"""


FROST_SINGLE_EVENT = """function FR_OnStompCast takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    if GetSpellAbilityId() != FR_SPELL_ID then
        return
    endif
    if caster == null or not FR_HasItem(caster) then
        set caster = null
        return
    endif
    call FR_CastStomp(caster)
    set caster = null
endfunction"""


HAS_WARGLAIVE = """function WGL_HasWarglaive takes unit u returns boolean
    local integer slot = 0
    local item it
    if u == null or GetUnitTypeId(u) == 0 then
        return false
    endif
    if WGL_ITEM_ACTIVE then
        loop
            exitwhen slot >= 9
            set it = BlzUnitItemInEquipmentSlot(u, ConvertLoadoutSlot(slot))
            if it != null and GetItemTypeId(it) == 'I106' then
                set it = null
                return true
            endif
            set slot = slot + 1
        endloop
    endif
    set it = null
    return UnitHasItemOfTypeBJ(u, 'I106')
endfunction"""


DEFERRED_SYNC = """function WGL_DeferredSync takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer timerId = GetHandleId(t)
    local unit u = LoadUnitHandle(WGL_DEFERRED_HT, timerId, 0)
    if u != null and GetUnitTypeId(u) != 0 then
        call WGL_SyncUnit(u)
    endif
    call FlushChildHashtable(WGL_DEFERRED_HT, timerId)
    call DestroyTimer(t)
    set u = null
    set t = null
endfunction

function WGL_ScheduleSync takes unit u returns nothing
    local timer t = CreateTimer()
    call SaveUnitHandle(WGL_DEFERRED_HT, GetHandleId(t), 0, u)
    call TimerStart(t, 0.05, false, function WGL_DeferredSync)
    set t = null
endfunction

"""


def run(args: list[str]) -> None:
    print(">>>", " ".join(args), flush=True)
    result = subprocess.run(
        args,
        cwd=str(HERE),
        capture_output=True,
        text=True,
        encoding="utf-8",
        errors="replace",
        env={
            **os.environ,
            "PYTHONUTF8": "1",
            "PYTHONIOENCODING": "utf-8",
        },
    )
    if result.stdout:
        print(result.stdout, end="" if result.stdout.endswith("\n") else "\n")
    if result.stderr:
        print(result.stderr, end="" if result.stderr.endswith("\n") else "\n")
    if result.returncode:
        raise SystemExit(
            "command failed (%d): %s" % (result.returncode, " ".join(args))
        )


def extract(source: Path, work: Path) -> tuple[Path, Path, Path]:
    work.mkdir(parents=True, exist_ok=True)
    archive = W.MPQArchive(str(source))
    try:
        paths = []
        for internal in ("war3map.w3t", "war3map.w3a", "war3map.j"):
            data = archive.read_file(internal)
            if not data:
                raise SystemExit("source is missing " + internal)
            path = work / ("war3map." + internal.rsplit(".", 1)[-1])
            path.write_bytes(data)
            paths.append(path)
    finally:
        archive.close()
    return paths[0], paths[1], paths[2]


def replace_function(script: bytes, name: str, replacement: str) -> bytes:
    newline = b"\r\n" if b"\r\n" in script else b"\n"
    pattern = re.compile(
        rb"function " + name.encode("ascii") + rb" takes .*?\r?\nendfunction",
        re.S,
    )
    if len(pattern.findall(script)) != 1:
        raise SystemExit("expected exactly one " + name)
    body = replacement.replace("\n", newline.decode("ascii")).encode("utf-8")
    return pattern.sub(lambda _match: body, script, count=1)


def patch_script(script: bytes) -> bytes:
    newline = b"\r\n" if b"\r\n" in script else b"\n"
    speed_globals = re.compile(
        rb"    real WGL_ATTACK_SPEED_AGI_MULT = 0\.005\r?\n"
        rb"    real WGL_ATTACK_SPEED_MIN = 0\.15\r?\n"
        rb"    real WGL_ATTACK_SPEED_MAX = 2\.0\r?\n"
        rb"    real WGL_ATTACK_SPEED_STEP = 0\.05\r?\n"
        rb"    integer WGL_ATTACK_SPEED_LEVELS = 38\r?\n"
    )
    script, count = speed_globals.subn(
        b"    integer WGL_ATTACK_SPEED_MAX_LEVEL = 201" + newline,
        script,
        count=1,
    )
    if count != 1 and b"integer WGL_ATTACK_SPEED_MAX_LEVEL = 201" not in script:
        raise SystemExit("expected one Warglaive attack-speed globals block")
    if b"hashtable WGL_DEFERRED_HT = null" not in script:
        marker = b"    hashtable WGL_GROWTH_HT = null" + newline
        if script.count(marker) != 1:
            raise SystemExit("WGL_GROWTH_HT globals marker not found")
        script = script.replace(
            marker,
            marker + b"    hashtable WGL_DEFERRED_HT = null" + newline,
            1,
        )
    if b"set WGL_DEFERRED_HT = InitHashtable()" not in script:
        marker = b"    set WGL_GROWTH_HT = InitHashtable()" + newline
        if script.count(marker) != 1:
            raise SystemExit("WGL_GROWTH_HT init marker not found")
        script = script.replace(
            marker,
            marker + b"    set WGL_DEFERRED_HT = InitHashtable()" + newline,
            1,
        )
    if b"function WGL_DeferredSync takes" not in script:
        marker = b"function WGL_OnItemEvent takes"
        if script.count(marker) != 1:
            raise SystemExit("WGL_OnItemEvent insertion marker not found")
        deferred = DEFERRED_SYNC.replace(
            "\n", newline.decode("ascii")
        ).encode("utf-8")
        script = script.replace(marker, deferred + marker, 1)
    if b"function WGL_ClearAttackSpeedAbility takes" in script:
        sync_only = SYNC_ATTACK_SPEED[
            SYNC_ATTACK_SPEED.index("function WGL_SyncAttackSpeed"):
        ]
        script = replace_function(
            script, "WGL_SyncAttackSpeed", sync_only
        )
    else:
        script = replace_function(
            script, "WGL_SyncAttackSpeed", SYNC_ATTACK_SPEED
        )
    script = replace_function(
        script, "WGL_HasWarglaive", HAS_WARGLAIVE
    )
    script = replace_function(script, "WGL_SyncUnit", SYNC_UNIT)
    script = replace_function(script, "WGL_OnItemEvent", ON_ITEM_EVENT)
    script = replace_function(
        script, "FR_OnStompCast", FROST_SINGLE_EVENT
    )
    for pattern in (
        rb"hashtable fr_cast_guard_table = null\r?\n",
        rb"real FR_CAST_GUARD_SECONDS = 9\.5\r?\n",
        rb"[ \t]*set fr_cast_guard_table = InitHashtable\(\)\r?\n",
        rb"[ \t]*call TriggerRegisterAnyUnitEventBJ\(fr_spell_trigger, EVENT_PLAYER_UNIT_SPELL_CAST\)\r?\n",
    ):
        script, count = re.subn(pattern, b"", script, count=1)
        if count > 1:
            raise SystemExit("multiple Frostmourne guard markers: %r" % pattern)
    return script


def object_mods(data: bytes, extension: str, ident: str) -> list[tuple]:
    _version, entries, consumed = OBJ.read_objects_bytes(
        data,
        extension == "w3a",
        fname="." + extension,
        with_end=True,
    )
    if consumed != len(data):
        raise SystemExit(extension + " has trailing bytes")
    for _table, _old, new, mods in entries:
        if new.replace("\0", "") == ident:
            return mods
    raise SystemExit("%s not found in %s" % (ident, extension))


def object_fields(data: bytes, extension: str, ident: str) -> dict[str, object]:
    return {
        mod[0]: (
            mod[4].decode("utf-8", "replace")
            if isinstance(mod[4], bytes)
            else mod[4]
        )
        for mod in object_mods(data, extension, ident)
    }


def patch_warglaive_objects(ability_path: Path, item_path: Path) -> None:
    existing_fields = object_fields(
        item_path.read_bytes(), "w3t", "I106"
    )
    existing_iabi = str(existing_fields.get("iabi", ""))
    kept_abilities = [
        ident
        for ident in existing_iabi.split(",")
        if ident and ident != "A111"
    ]
    if "A110" not in kept_abilities:
        kept_abilities.insert(0, "A110")
    if "Aclq" not in kept_abilities:
        kept_abilities.append("Aclq")
    set_object_mod_value(
        item_path, "w3t", "I106", "iabi", 0, 0, ",".join(kept_abilities)
    )

    version, item_entries = read_objects_from_path(item_path, "w3t")
    updated_items = []
    for table, old, new, mods in item_entries:
        if new.replace("\0", "") != "I106":
            updated_items.append((table, old, new, mods))
            continue
        updated_mods = []
        for mod in mods:
            if mod[0] in ("utub", "ides"):
                text = mod[4].decode("utf-8", "replace")
                text = text.replace("不设上限。", "")
                text = text.replace("不设上限", "")
                text = text.replace(
                    "攻击速度随敏捷提升：敏捷×0.5%，最低 15%，最高 200%。",
                    "每点敏捷提高 2% 攻击速度。",
                )
                updated_mods.append(
                    (mod[0], 3, mod[2], mod[3], text.encode("utf-8"), mod[5])
                )
            else:
                updated_mods.append(mod)
        updated_items.append(
            (table, old, new, OBJ.with_item_sets(updated_mods, mods))
        )
    item_path.write_bytes(
        OBJ.write_objects_bytes(version, updated_items, False)
    )

    set_object_mod_value(ability_path, "w3a", "A111", "aite", 0, 0, 0)
    set_object_mod_value(ability_path, "w3a", "A111", "alev", 0, 0, 201)
    version, ability_entries = read_objects_from_path(ability_path, "w3a")
    updated_abilities = []
    for table, old, new, mods in ability_entries:
        if new.replace("\0", "") != "A111":
            updated_abilities.append((table, old, new, mods))
            continue
        updated_mods = []
        speed_level = 0
        for mod in mods:
            if mod[0] == "Isx1":
                speed_level += 1
                updated_mods.append(
                    (
                        mod[0],
                        2,
                        speed_level,
                        1,
                        round((speed_level - 1) * 0.02, 2),
                        b"\x00\x00\x00\x00",
                    )
                )
            else:
                updated_mods.append(mod)
        while speed_level < 201:
            speed_level += 1
            updated_mods.append(
                (
                    "Isx1",
                    2,
                    speed_level,
                    1,
                    round((speed_level - 1) * 0.02, 2),
                    b"\x00\x00\x00\x00",
                )
            )
        updated_abilities.append(
            (table, old, new, OBJ.with_item_sets(updated_mods, mods))
        )
    ability_path.write_bytes(
        OBJ.write_objects_bytes(version, updated_abilities, True)
    )


def verify(
    output: Path, before_script: bytes, after_script: bytes
) -> None:
    ok, note = jass_check(before_script, after_script)
    print("pjass:", note)
    if not ok:
        raise SystemExit("pjass introduced new diagnostics")

    archive = W.MPQArchive(str(output))
    try:
        item_data = archive.read_file("war3map.w3t") or b""
        ability_data = archive.read_file("war3map.w3a") or b""
        script = archive.read_file("war3map.j") or b""
    finally:
        archive.close()

    item = object_fields(item_data, "w3t", "I106")
    if item.get("iabi") not in ("A110,Aclq", "A113,A110,Aclq"):
        raise SystemExit("I106.iabi mismatch: %r" % item.get("iabi"))
    for field_id in ("utub", "ides"):
        if "不设上限" in str(item.get(field_id, "")):
            raise SystemExit("I106." + field_id + " still says 不设上限")
        if "每点敏捷提高 2% 攻击速度" not in str(item.get(field_id, "")):
            raise SystemExit(
                "I106." + field_id + " lost 2% per agility text"
            )

    speed_mods = object_mods(ability_data, "w3a", "A111")
    speed = object_fields(ability_data, "w3a", "A111")
    if speed.get("aite") != 0 or speed.get("alev") != 201:
        raise SystemExit("A111 ownership or level count is wrong")
    isx1 = [mod for mod in speed_mods if mod[0] == "Isx1"]
    if len(isx1) != 201 or any(mod[1] != 2 for mod in isx1):
        raise SystemExit("A111.Isx1 is not 201 unreal levels")
    if abs(float(isx1[0][4])) > 0.0001:
        raise SystemExit("A111.Isx1 level 1 is not 0%")
    if abs(float(isx1[-1][4]) - 4.0) > 0.0001:
        raise SystemExit("A111.Isx1 level 201 is not 400%")

    for token in (
        b"function WGL_DeferredSync takes",
        b"call WGL_ScheduleSync(u)",
        b"call TimerStart(t, 0.05, false, function WGL_DeferredSync)",
        b"call WGL_SyncUnit(u)",
        b"call UnitAddAbility(u, 'A111')",
        b"call WGL_ClearAttackSpeedAbility(u)",
        b"call BlzUnitHideAbility(u, 'A111', true)",
        b"call SetUnitAbilityLevel(u, 'A111', level)",
        b"EVENT_PLAYER_UNIT_SPELL_EFFECT",
    ):
        if token not in script:
            raise SystemExit("missing script token: " + token.decode("ascii"))
    for token in (
        b"fr_cast_guard_table",
        b"FR_CAST_GUARD_SECONDS",
        b"TriggerRegisterAnyUnitEventBJ(fr_spell_trigger, EVENT_PLAYER_UNIT_SPELL_CAST)",
    ):
        if token in script:
            raise SystemExit("stale script token: " + token.decode("ascii"))


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("source", type=Path)
    parser.add_argument("--work", required=True, type=Path)
    parser.add_argument("--output", required=True, type=Path)
    args = parser.parse_args()

    source = args.source.resolve()
    work = args.work.resolve()
    output = args.output.resolve()
    if not source.is_file():
        raise SystemExit("source not found: " + str(source))
    if output.exists():
        raise SystemExit("output already exists: " + str(output))

    item_path, ability_path, script_path = extract(source, work)
    patch_warglaive_objects(ability_path, item_path)
    before_script = script_path.read_bytes()
    after_script = patch_script(before_script)
    script_path.write_bytes(after_script)

    output.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(source, output)
    run(
        [
            sys.executable,
            str(HERE / "inject_native.py"),
            str(output),
            "--file",
            str(item_path) + "=war3map.w3t",
            "--file",
            str(ability_path) + "=war3map.w3a",
            "--file",
            str(script_path) + "=war3map.j",
            "--no-backup",
        ]
    )
    verify(output, before_script, after_script)
    print("output:", output)
    print("size:", output.stat().st_size)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
