#!/usr/bin/env python3
"""Move Warglaive A111 from item ownership to a hidden item-class hero ability."""

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
sys.path[:0] = [str(HERE), str(ROOT / "tools" / "_devos-map-doctor" / "devos-map-doctor-main")]
sys.stdout.reconfigure(errors="replace")
sys.stderr.reconfigure(errors="replace")

import war3mpq as W  # noqa: E402
from doctor.data import objects as OBJ  # noqa: E402
from jass_gate import check as jass_check  # noqa: E402
from port_item_skill_campaign import (  # noqa: E402
    add_custom_ability,
    ability_mod,
    read_objects_from_path,
    set_object_mod_value,
)


SOUL_CHASE_ABILITY_ID = "A133"
SOUL_CHASE_BASE_ID = "AUdb"
WARGLAIVE_ICON = (
    r"ReplaceableTextures\CommandButtons\BTNWarglaiveOfAzzinoth.blp"
)
SOUL_CHASE_ITEM_TEXT = (
    "|cff5ddf26追魂：每次攻击同一目标提高 10% 攻击速度，"
    "最多 20 层；切换目标或 5 秒内未继续攻击时清空。|r"
)


SYNC_ATTACK_SPEED = """function WGL_ClearAttackSpeedAbilities takes unit u returns nothing
    if GetUnitAbilityLevel(u, 'A111') > 0 then
        call UnitRemoveAbility(u, 'A111')
    endif
    if GetUnitAbilityLevel(u, 'A133') > 0 then
        call UnitRemoveAbility(u, 'A133')
    endif
endfunction

function WGL_SyncAttackSpeed takes unit u returns nothing
    if u == null or GetUnitTypeId(u) == 0 then
        return
    endif
    if not IsUnitType(u, UNIT_TYPE_HERO) then
        return
    endif
    if not WGL_HasWarglaive(u) then
        call WGL_ClearAttackSpeedAbilities(u)
        return
    endif
    if GetUnitAbilityLevel(u, 'A111') > 0 then
        call UnitRemoveAbility(u, 'A111')
    endif
    if GetUnitAbilityLevel(u, 'A133') == 0 then
        call UnitAddAbility(u, 'A133')
        call UnitMakeAbilityPermanent(u, true, 'A133')
    endif
    call BlzUnitHideAbility(u, 'A133', true)
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
        call WGL_ClearAttackSpeedAbilities(u)
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
    if not WGL_ITEM_ACTIVE and GetTriggerEventId() == EVENT_PLAYER_UNIT_DROP_ITEM and it != null and GetItemTypeId(it) == 'I106' then
        call WGL_ClearAttackSpeedAbilities(u)
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
    call TriggerSleepAction(0.05)
    if u != null and GetUnitTypeId(u) != 0 then
        call WGL_SyncUnit(u)
    endif
    set it = null
    set u = null
endfunction"""


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
            path = work / internal.rsplit(".", 1)[-1]
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
    return pattern.sub(lambda _m: body, script, count=1)


def patch_script(script: bytes) -> bytes:
    script = replace_function(script, "WGL_SyncAttackSpeed", SYNC_ATTACK_SPEED)
    script = replace_function(script, "WGL_SyncUnit", SYNC_UNIT)
    script = replace_function(script, "WGL_OnItemEvent", ON_ITEM_EVENT)
    return script


def object_mods(data: bytes, ext: str, ident: str) -> list[tuple]:
    _version, entries, consumed = OBJ.read_objects_bytes(
        data, ext in ("w3a", "w3q", "w3d"), fname="." + ext, with_end=True
    )
    if consumed != len(data):
        raise SystemExit(ext + " has trailing bytes")
    for _table, _old, new, mods in entries:
        if new.replace("\0", "") == ident:
            return mods
    raise SystemExit("%s not found in %s" % (ident, ext))


def object_fields(data: bytes, ext: str, ident: str) -> dict[str, object]:
    return {
        mod[0]: (
            mod[4].decode("utf-8", "replace")
            if isinstance(mod[4], bytes)
            else mod[4]
        )
        for mod in object_mods(data, ext, ident)
    }


def object_base(data: bytes, ext: str, ident: str) -> str:
    _version, entries, consumed = OBJ.read_objects_bytes(
        data, ext in ("w3a", "w3q", "w3d"), fname="." + ext, with_end=True
    )
    if consumed != len(data):
        raise SystemExit(ext + " has trailing bytes")
    for _table, old, new, _mods in entries:
        if new.replace("\0", "") == ident:
            return old.replace("\0", "")
    raise SystemExit("%s not found in %s" % (ident, ext))


def normalize_attack_speed_field_types(path: Path) -> None:
    """Write Isx1 as unreal (2), matching AIsx and the known-good A002."""
    version, entries = read_objects_from_path(path, "w3a")
    output = []
    changed = 0
    for table, old, new, mods in entries:
        if new.replace("\0", "") != "A111":
            output.append((table, old, new, mods))
            continue
        updated = []
        for mod in mods:
            if mod[0] == "Isx1":
                updated.append(
                    (mod[0], 2, mod[2], mod[3], mod[4], mod[5])
                )
                changed += 1
            else:
                updated.append(mod)
        output.append((table, old, new, OBJ.with_item_sets(updated, mods)))
    if changed != 38:
        raise SystemExit(
            "expected 38 A111.Isx1 levels, found %d" % changed
        )
    path.write_bytes(OBJ.write_objects_bytes(version, output, True))


def ensure_soul_chase_ability(path: Path) -> None:
    """Clone Anya's normal-attack AUdb passive with AUd2 speed values."""
    add_custom_ability(
        path,
        SOUL_CHASE_ABILITY_ID,
        SOUL_CHASE_BASE_ID,
        [
            ability_mod("anam", 3, "追魂"),
            ability_mod("aart", 3, WARGLAIVE_ICON),
            ability_mod("arar", 3, WARGLAIVE_ICON),
            ability_mod("atp1", 3, "追魂", 1, 0),
            ability_mod(
                "aub1",
                3,
                "每次攻击同一目标提高 10% 攻击速度，最多 20 层；"
                "切换目标或 5 秒内未继续攻击时清空。",
                1,
                0,
            ),
            ability_mod("alev", 0, 1),
            ability_mod("aite", 0, 0),
            ability_mod("aher", 0, 0),
            ability_mod("ahky", 3, "", 0, 0),
            ability_mod("udb1", 2, 0.0, 1, 1),
            ability_mod("udb3", 0, 4, 1, 3),
            ability_mod("udb4", 2, 0.10, 1, 4),
            ability_mod("udb5", 0, 20, 1, 5),
            ability_mod("dur1", 1, 5.0, 1, 0),
        ],
    )


def redden_passive_names(text: str) -> str:
    pattern = re.compile(r"\|cff5ddf26([^：|n]+)：")
    return pattern.sub(
        lambda match: (
            "|cffff0000" + match.group(1)
            + "：|r|cff5ddf26"
        ),
        text,
    )


def reflow_artifact_text(text: str) -> str:
    replacements = (
        (
            "击杀生命值不低于 300 的敌人时获得金币，目标等级越高，金币越多。",
            "击杀最大生命值 ≥300 的敌人时获得金币。|n目标等级越高，金币越多。",
        ),
        (
            "死亡之指击杀英雄时永久 +1 智力；击杀等级≥8或生命≥2000的非英雄强敌有25%概率永久 +1 智力。",
            "死亡之指击杀英雄时永久 +1 智力。|n击杀等级≥8或最大生命≥2000的非英雄强敌时，|n有25%概率永久 +1 智力。",
        ),
        (
            "普通攻击有 30% 概率触发，对 250",
            "普通攻击有 30% 概率触发。|n对 250",
        ),
        (
            "点伤害，主目标额外受到 50",
            "点伤害。|n主目标额外受到 50",
        ),
        (
            "击杀敌人有 5% 概率永久 +1 力量，击杀英雄时为 50%。",
            "击杀普通敌人有 5% 概率永久 +1 力量。|n击杀英雄时为 50%。",
        ),
        (
            "击杀英雄时为 50%。",
            "击杀英雄时为 50% 概率。",
        ),
        (
            "每次攻击同一目标提高 10% 攻击速度，最多 20 层；切换目标或 5 秒内未继续攻击时清空。",
            "每次攻击同一目标提高 10% 攻速。|n最多 20 层；切换目标或 5 秒未攻击时清空。",
        ),
        (
            "你的近战基础攻击会造成顺劈效果，将造成伤害的 15% 转嫁给附近敌方单位。",
            "近战基础攻击造成 15% 顺劈伤害。|n该伤害会传递给附近敌方单位。",
        ),
        (
            "基础攻击有 2% 概率永久提升 1 点敏捷。不设上限。",
            "基础攻击有 2% 概率永久 +1 敏捷。|n不设上限。",
        ),
        (
            "基础攻击有 2% 几率永久提升 1 点敏捷。不设上限。",
            "基础攻击有 2% 几率永久 +1 敏捷。|n不设上限。",
        ),
        (
            "基础攻击有 2% 几率永久 +1 敏捷。|n不设上限。",
            "基础攻击有 2% 几率永久 +1 敏捷。",
        ),
        (
            "基础攻击有 2% 概率永久 +1 敏捷。|n不设上限。",
            "基础攻击有 2% 概率永久 +1 敏捷。",
        ),
    )
    for old, new in replacements:
        text = text.replace(old, new)
    return text


def patch_artifact_tooltips(path: Path) -> None:
    version, entries = read_objects_from_path(path, "w3t")
    pattern = re.compile(r"\|cff5ddf26.*?\|r", re.S)
    output = []
    for table, old, new, mods in entries:
        ident = new.replace("\0", "")
        if ident not in ("I103", "I105", "I106"):
            output.append((table, old, new, mods))
            continue
        updated = []
        for mod in mods:
            if mod[0] in ("utub", "ides") and ident == "I106":
                text = mod[4].decode("utf-8", "replace")
                text, count = pattern.subn(
                    SOUL_CHASE_ITEM_TEXT, text, count=1
                )
                if count != 1:
                    raise SystemExit("I106." + mod[0] + " marker is missing")
                text = reflow_artifact_text(redden_passive_names(text))
                updated.append(
                    (mod[0], 3, mod[2], mod[3],
                     text.encode("utf-8"), mod[5])
                )
            elif mod[0] in ("utub", "ides"):
                text = mod[4].decode("utf-8", "replace")
                text = reflow_artifact_text(redden_passive_names(text))
                updated.append(
                    (mod[0], 3, mod[2], mod[3],
                     text.encode("utf-8"), mod[5])
                )
            else:
                updated.append(mod)
        output.append((table, old, new, OBJ.with_item_sets(updated, mods)))
    path.write_bytes(OBJ.write_objects_bytes(version, output, False))


def verify(source: Path, output: Path, before_script: bytes, after_script: bytes) -> None:
    if before_script == after_script:
        print("script already contains the equipment sync")
    ok, note = jass_check(before_script, after_script)
    print("pjass:", note)
    if not ok:
        raise SystemExit("pjass introduced new diagnostics")
    archive = W.MPQArchive(str(output))
    try:
        item_data = archive.read_file("war3map.w3t") or b""
        ability_data = archive.read_file("war3map.w3a") or b""
        script = (archive.read_file("war3map.j") or b"").decode(
            "utf-8", "replace"
        )
    finally:
        archive.close()
    item = object_fields(item_data, "w3t", "I106")
    if item.get("iabi") != "A110,Aclq":
        raise SystemExit("I106 item ability list is wrong: %r" % item.get("iabi"))
    if (
        "追魂" not in str(item.get("utub", ""))
        or "10%" not in str(item.get("utub", ""))
        or "20" not in str(item.get("utub", ""))
    ):
        raise SystemExit("I106 tooltip does not describe Soul-Chase")
    for ident in ("I103", "I105", "I106"):
        fields = object_fields(item_data, "w3t", ident)
        for field_id in ("utub", "ides"):
            text = str(fields.get(field_id, ""))
            if "|cffff0000" not in text or "|cff5ddf26" not in text:
                raise SystemExit(
                    ident + "." + field_id
                    + " does not use red passive names"
                )
            if ident == "I106" and "不设上限" in text:
                raise SystemExit(
                    "I106." + field_id + " still says no upper limit"
                )
            if ident == "I105" and "50% 概率" not in text:
                raise SystemExit(
                    "I105." + field_id
                    + " does not mark hero kill chance"
                )
    speed = object_fields(ability_data, "w3a", "A111")
    # AIsx is an item passive. UnitAddAbility can grant it to a hero, but its
    # item-class bit must remain set or Reforged does not apply the attack
    # speed modifier even when GetUnitAbilityLevel reports the ability.
    if speed.get("aite") != 1:
        raise SystemExit("A111 lost its AIsx item-passive flag")
    isx1_mods = [
        mod for mod in object_mods(ability_data, "w3a", "A111")
        if mod[0] == "Isx1"
    ]
    if len(isx1_mods) != 38 or any(mod[1] != 2 for mod in isx1_mods):
        raise SystemExit("A111.Isx1 is not 38 unreal(2) levels")
    soul_chase = object_fields(
        ability_data, "w3a", SOUL_CHASE_ABILITY_ID
    )
    if object_base(ability_data, "w3a", SOUL_CHASE_ABILITY_ID) != SOUL_CHASE_BASE_ID:
        raise SystemExit("Soul-Chase must inherit from AUdb")
    if soul_chase.get("alev") != 1:
        raise SystemExit("Soul-Chase passive must be one level")
    if soul_chase.get("aite") != 0 or soul_chase.get("aher") != 0:
        raise SystemExit("Soul-Chase passive ownership is wrong")
    if abs(float(soul_chase.get("udb4", -1)) - 0.10) > 0.0001:
        raise SystemExit("Soul-Chase attack-speed step is not 10%")
    if soul_chase.get("udb5") != 20:
        raise SystemExit("Soul-Chase maximum stacks are not 20")
    for token in (
        "call UnitRemoveAbility(u, 'A111')",
        "call UnitAddAbility(u, 'A133')",
        "call UnitRemoveAbility(u, 'A133')",
        "call BlzUnitHideAbility(u, 'A133', true)",
        "call TriggerSleepAction(0.05)",
    ):
        if token not in script:
            raise SystemExit("missing script token: " + token)
    if "SetUnitAbilityLevel(u, 'A111'" in script:
        raise SystemExit("Warglaive still depends on A111 level changes")
    if "UNIT_WEAPON_RF_ATTACK_BASE_COOLDOWN" in script:
        # The map's avatar system owns this field; WGL must not.
        wgl_start = script.find("function WGL_HasWarglaive")
        wgl_end = script.find("function WGL_DestroyTimedEffect", wgl_start)
        if wgl_start < 0 or wgl_end < 0:
            raise SystemExit("cannot isolate WGL speed section")
        if "UNIT_WEAPON_RF_ATTACK_BASE_COOLDOWN" in script[wgl_start:wgl_end]:
            raise SystemExit("WGL still edits the base attack interval")
    if script.count("function WGL_SyncAttackSpeed takes") != 1:
        raise SystemExit("WGL_SyncAttackSpeed entry is not unique")


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("source")
    parser.add_argument("--work", required=True)
    parser.add_argument("--output", required=True)
    args = parser.parse_args()

    source = Path(args.source).resolve()
    work = Path(args.work).resolve()
    output = Path(args.output).resolve()
    if not source.is_file():
        raise SystemExit("source not found: " + str(source))
    if output.exists():
        raise SystemExit("output already exists: " + str(output))

    item_path, ability_path, script_path = extract(source, work)
    set_object_mod_value(
        item_path, "w3t", "I106", "iabi", 0, 0, "A110,Aclq"
    )
    patch_artifact_tooltips(item_path)
    set_object_mod_value(
        ability_path, "w3a", "A111", "aite", 0, 0, 1
    )
    normalize_attack_speed_field_types(ability_path)
    ensure_soul_chase_ability(ability_path)
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
    verify(source, output, before_script, after_script)
    print("output:", output)
    print("size:", output.stat().st_size)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
