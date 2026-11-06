#!/usr/bin/env python3
"""Port the Reforged B30B hero backpack to every hero in a clean map."""

from __future__ import annotations

import argparse
import os
import shutil
import struct
import subprocess
import sys
import tempfile
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path[:0] = [str(HERE), str(ROOT / "tools" / "_devos-map-doctor" / "devos-map-doctor-main")]
sys.stdout.reconfigure(errors="replace")
sys.stderr.reconfigure(errors="replace")

import war3mpq as W  # noqa: E402
from doctor.data import objects as OBJ  # noqa: E402
from doctor.data import w3i as W3I  # noqa: E402
import merge_w3obj as M  # noqa: E402


BACKPACK_ID = "B30B"
EXPECTED_IABI = "AIni,AEqu,ASde"

GLOBALS = """//============================================================================
// UNIVERSAL REFORGED HERO BACKPACK
//============================================================================
group B30B_SCAN_GROUP = null
region B30B_REGION = null
rect B30B_RECT = null
trigger B30B_ENTER_TRIGGER = null
boolean B30B_INITED = false
"""

FUNCTIONS = """//============================================================================
// UNIVERSAL REFORGED HERO BACKPACK
//============================================================================
function B30B_HasBackpack takes unit u returns boolean
    local integer i = 0
    local item it
    if u == null or GetUnitTypeId(u) == 0 then
        return false
    endif
    loop
        exitwhen i > 5
        set it = UnitItemInSlot(u, i)
        if it != null and GetItemTypeId(it) == 'B30B' then
            set it = null
            return true
        endif
        set i = i + 1
    endloop
    set it = null
    return false
endfunction

function B30B_EnsureHero takes unit u returns nothing
    if u == null or GetUnitTypeId(u) == 0 then
        return
    endif
    if not IsUnitType(u, UNIT_TYPE_HERO) then
        return
    endif
    if not B30B_HasBackpack(u) then
        call UnitAddItemByIdSwapped('B30B', u)
    endif
endfunction

function B30B_ScanInitial takes nothing returns nothing
    local unit u
    call GroupEnumUnitsInRect(B30B_SCAN_GROUP, bj_mapInitialPlayableArea, null)
    loop
        set u = FirstOfGroup(B30B_SCAN_GROUP)
        exitwhen u == null
        call GroupRemoveUnit(B30B_SCAN_GROUP, u)
        call B30B_EnsureHero(u)
    endloop
    set u = null
endfunction

function B30B_OnEnter takes nothing returns nothing
    local unit u = GetTriggerUnit()
    call B30B_EnsureHero(u)
    set u = null
endfunction

function B30B_Init takes nothing returns nothing
    if B30B_INITED then
        return
    endif
    set B30B_INITED = true
    set B30B_SCAN_GROUP = CreateGroup()
    set B30B_RECT = Rect(GetRectMinX(bj_mapInitialPlayableArea), GetRectMinY(bj_mapInitialPlayableArea), GetRectMaxX(bj_mapInitialPlayableArea), GetRectMaxY(bj_mapInitialPlayableArea))
    set B30B_REGION = CreateRegion()
    call RegionAddRect(B30B_REGION, B30B_RECT)
    set B30B_ENTER_TRIGGER = CreateTrigger()
    call TriggerRegisterEnterRegion(B30B_ENTER_TRIGGER, B30B_REGION, null)
    call TriggerAddAction(B30B_ENTER_TRIGGER, function B30B_OnEnter)
    call TimerStart(CreateTimer(), 0.25, false, function B30B_ScanInitial)
endfunction
"""

ENTRY = """call B30B_Init()
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


def object_entries(data: bytes, ext: str):
    _version, entries, consumed = OBJ.read_objects_bytes(
        data,
        ext in ("w3a", "w3q", "w3d"),
        fname="." + ext,
        with_end=True,
    )
    if consumed != len(data):
        raise SystemExit("%s object data has trailing bytes" % ext)
    return entries


def extract_backpack_entry() -> bytes:
    source = ROOT / "maps" / "port" / "lost_temple_30" / "build" / "war3map.w3t"
    version, _original, custom = M.read_all(str(source))
    entries = [
        entry
        for entry in custom
        if entry[4:8].decode("latin-1").replace("\0", "") == BACKPACK_ID
    ]
    if version != 2 or len(entries) != 1:
        raise SystemExit("expected one v2 B30B item entry")
    return entries[0]


def write_item_data(source: Path, work: Path, output: Path) -> None:
    backpack = extract_backpack_entry()
    single = work / "B30B.w3t"
    single.write_bytes(struct.pack("<ii", 2, 0) + struct.pack("<i", 1) + backpack)

    archive = W.MPQArchive(str(source))
    try:
        source_items = archive.read_file("war3map.w3t")
    finally:
        archive.close()
    if source_items:
        source_w3t = work / "source.w3t"
        source_w3t.write_bytes(source_items)
        M.merge_files(str(output), [str(source_w3t), str(single)])
    else:
        shutil.copy2(single, output)


def write_map_info(source: Path, output: Path) -> None:
    archive = W.MPQArchive(str(source))
    try:
        data = archive.read_file("war3map.w3i")
    finally:
        archive.close()
    if not data:
        raise SystemExit("source has no war3map.w3i")
    info = W3I.parse_or_tolerant(data)
    info["game_data_set"] = 2
    info["game_data_version"] = 2
    output.write_bytes(W3I.write(info))


def verify(source: Path, output: Path) -> None:
    source_map = W.MPQArchive(str(source))
    output_map = W.MPQArchive(str(output))
    try:
        item_data = output_map.read_file("war3map.w3t")
        entries = object_entries(item_data, "w3t")
        item = [
            mods
            for _table, _old, new, mods in entries
            if new.replace("\0", "") == BACKPACK_ID
        ]
        if len(item) != 1:
            raise SystemExit("output does not contain exactly one B30B item")
        fields = {
            mod[0]: (
                mod[4].decode("utf-8", "replace")
                if isinstance(mod[4], bytes)
                else mod[4]
            )
            for mod in item[0]
        }
        if fields.get("iabi") != EXPECTED_IABI:
            raise SystemExit("B30B.iabi mismatch: %r" % fields.get("iabi"))
        if fields.get("iusa") != 1 or fields.get("idro") != 0:
            raise SystemExit("B30B flags are not the known backpack flags")
        info = W3I.parse_or_tolerant(output_map.read_file("war3map.w3i"))
        if (info.get("game_data_set"), info.get("game_data_version")) != (2, 2):
            raise SystemExit("output map-info is not using Reforged data 2/2")
        script = (output_map.read_file("war3map.j") or b"").decode(
            "utf-8", "replace"
        )
        for token in (
            "function B30B_Init takes nothing returns nothing",
            "function B30B_EnsureHero takes unit u returns nothing",
            "UnitAddItemByIdSwapped('B30B', u)",
            "TimerStart(CreateTimer(), 0.0, false, function B30B_Init)",
        ):
            if token not in script:
                raise SystemExit("missing backpack script token: %r" % token)
        for token in ("function WGL_Init", "function FR_Init", "'A111'", "'I106'"):
            if token in script:
                raise SystemExit("unexpected old equipment token: %r" % token)
        for internal in ("war3map.w3a", "war3map.w3u", "war3map.w3h"):
            if source_map.read_file(internal) != output_map.read_file(internal):
                raise SystemExit("unrelated object data changed: " + internal)
    finally:
        source_map.close()
        output_map.close()


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
        raise SystemExit("source not found: %s" % source)
    if output.exists():
        raise SystemExit("output already exists: %s" % output)

    work.mkdir(parents=True, exist_ok=True)
    script_dir = work / "backpack-script"
    script_dir.mkdir(parents=True, exist_ok=True)
    (script_dir / "f.j").write_text(FUNCTIONS, encoding="utf-8", newline="\n")
    (script_dir / "m.j").write_text(ENTRY, encoding="utf-8", newline="\n")
    (script_dir / "g.j").write_text(GLOBALS, encoding="utf-8", newline="\n")

    item_file = work / "war3map.w3t"
    info_file = work / "war3map.w3i"
    write_item_data(source, work, item_file)
    write_map_info(source, info_file)

    output.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(source, output)
    run(
        [
            sys.executable,
            str(HERE / "inject_native.py"),
            str(output),
            "--script",
            str(script_dir),
            "--file",
            str(item_file) + "=war3map.w3t",
            "--file",
            str(info_file) + "=war3map.w3i",
            "--no-backup",
        ]
    )
    verify(source, output)
    print("output:", output)
    print("size:", output.stat().st_size)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
