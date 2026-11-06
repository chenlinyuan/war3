#!/usr/bin/env python3
"""Add the configurable Reforged new-backpack UI to a map or campaign."""

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

import merge_w3obj as M  # noqa: E402
import objparse as O  # noqa: E402
import war3mpq as W  # noqa: E402
from doctor.data import objects as OBJ  # noqa: E402
from doctor.data import w3i as W3I  # noqa: E402
from port_item_skill_campaign import set_object_mod_value  # noqa: E402


BACKPACK_ID = "B30B"
PANEL_ABILITIES = {
    "inventory": "AIni",
    "equipment": "AEqu",
    "stats": "ASde",
    "talents": "ATal",
}
PANEL_LABELS = {
    "inventory": "30 格背包",
    "equipment": "装备栏",
    "stats": "属性面板",
    "talents": "天赋栏",
}
DEFAULT_PANELS = ("inventory", "stats")

JASS_GLOBALS = """group ALAS_B30B_SCAN_GROUP = null
region ALAS_B30B_REGION = null
rect ALAS_B30B_RECT = null
trigger ALAS_B30B_ENTER_TRIGGER = null
boolean ALAS_B30B_INITED = false
"""

JASS_FUNCTIONS = """function ALAS_B30B_HasBackpack takes unit u returns boolean
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

function ALAS_B30B_EnsureHero takes unit u returns nothing
    if u == null or GetUnitTypeId(u) == 0 then
        return
    endif
    if not IsUnitType(u, UNIT_TYPE_HERO) then
        return
    endif
    if not ALAS_B30B_HasBackpack(u) then
        call UnitAddItemByIdSwapped('B30B', u)
    endif
endfunction

function ALAS_B30B_ScanInitial takes nothing returns nothing
    local unit u
    call GroupEnumUnitsInRect(ALAS_B30B_SCAN_GROUP, bj_mapInitialPlayableArea, null)
    loop
        set u = FirstOfGroup(ALAS_B30B_SCAN_GROUP)
        exitwhen u == null
        call GroupRemoveUnit(ALAS_B30B_SCAN_GROUP, u)
        call ALAS_B30B_EnsureHero(u)
    endloop
    set u = null
endfunction

function ALAS_B30B_OnEnter takes nothing returns nothing
    local unit u = GetTriggerUnit()
    call ALAS_B30B_EnsureHero(u)
    set u = null
endfunction

function ALAS_B30B_Init takes nothing returns nothing
    if ALAS_B30B_INITED then
        return
    endif
    set ALAS_B30B_INITED = true
    set ALAS_B30B_SCAN_GROUP = CreateGroup()
    set ALAS_B30B_RECT = Rect(GetRectMinX(bj_mapInitialPlayableArea), GetRectMinY(bj_mapInitialPlayableArea), GetRectMaxX(bj_mapInitialPlayableArea), GetRectMaxY(bj_mapInitialPlayableArea))
    set ALAS_B30B_REGION = CreateRegion()
    call RegionAddRect(ALAS_B30B_REGION, ALAS_B30B_RECT)
    set ALAS_B30B_ENTER_TRIGGER = CreateTrigger()
    call TriggerRegisterEnterRegion(ALAS_B30B_ENTER_TRIGGER, ALAS_B30B_REGION, null)
    call TriggerAddAction(ALAS_B30B_ENTER_TRIGGER, function ALAS_B30B_OnEnter)
    call TimerStart(CreateTimer(), 0.25, false, function ALAS_B30B_ScanInitial)
endfunction
"""

JASS_ENTRY = "call ALAS_B30B_Init()\n"

LUA_RUNTIME = """
do
    local scanGroup = CreateGroup()
    local areaRect = Rect(GetRectMinX(bj_mapInitialPlayableArea), GetRectMinY(bj_mapInitialPlayableArea), GetRectMaxX(bj_mapInitialPlayableArea), GetRectMaxY(bj_mapInitialPlayableArea))
    local enterRegion = CreateRegion()
    RegionAddRect(enterRegion, areaRect)
    local function hasBackpack(u)
        local i = 0
        while i <= 5 do
            local it = UnitItemInSlot(u, i)
            if it ~= nil and GetItemTypeId(it) == FourCC("B30B") then
                return true
            end
            i = i + 1
        end
        return false
    end
    local function ensureHero(u)
        if u == nil or GetUnitTypeId(u) == 0 or not IsUnitType(u, UNIT_TYPE_HERO) then
            return
        end
        if not hasBackpack(u) then
            UnitAddItemByIdSwapped(FourCC("B30B"), u)
        end
    end
    local function scanInitial()
        GroupEnumUnitsInRect(scanGroup, bj_mapInitialPlayableArea, nil)
        while true do
            local u = FirstOfGroup(scanGroup)
            if u == nil then
                break
            end
            GroupRemoveUnit(scanGroup, u)
            ensureHero(u)
        end
    end
    local enterTrigger = CreateTrigger()
    TriggerRegisterEnterRegion(enterTrigger, enterRegion, nil)
    TriggerAddAction(enterTrigger, function()
        ensureHero(GetTriggerUnit())
    end)
    TimerStart(CreateTimer(), 0.25, false, scanInitial)
end
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


def parse_panels(value: str) -> tuple[str, ...]:
    panels = tuple(
        item.strip().lower()
        for item in value.split(",")
        if item.strip()
    )
    unknown = [item for item in panels if item not in PANEL_ABILITIES]
    if unknown:
        raise SystemExit("unknown backpack panels: " + ", ".join(unknown))
    if len(set(panels)) != len(panels):
        raise SystemExit("duplicate backpack panel")
    if not panels:
        raise SystemExit("at least one backpack panel must be selected")
    return panels


def backpack_entry(panels: tuple[str, ...]) -> bytes:
    source = HERE / "_b30b_item.w3t"
    temp = Path(tempfile.gettempdir()) / "alas_b30b_template.w3t"
    temp.write_bytes(source.read_bytes())
    version, _original, custom = O.read_file(str(temp))
    entry = next(
        (item for item in custom if item["new"] == BACKPACK_ID),
        None,
    )
    temp.unlink(missing_ok=True)
    if version != 2 or entry is None:
        raise SystemExit("missing B30B template")
    abilities = ",".join(PANEL_ABILITIES[item] for item in panels)
    labels = "、".join(PANEL_LABELS[item] for item in panels)
    for mod in entry["mods"]:
        if mod[0] == "iabi":
            mod[4] = abilities
        elif mod[0] == "icid":
            mod[4] = "AIni" if "inventory" in panels else ""
        elif mod[0] in ("utub", "ides"):
            mod[4] = "|cffff8c00神器|r|n打开后可查看：" + labels + "。"
    single = Path(tempfile.gettempdir()) / "alas_b30b_single.w3t"
    single.write_bytes(O.build_bytes(2, [], [entry], "w3t"))
    data = single.read_bytes()
    single.unlink(missing_ok=True)
    return data


def merge_item_data(source: Path | None, work: Path) -> Path:
    output = work / "war3map.w3t"
    single = work / "B30B.w3t"
    single.write_bytes(backpack_entry(CURRENT_PANELS))
    if source and source.is_file():
        M.merge_files(
            str(output),
            [str(source), str(single)],
            override_ids={BACKPACK_ID},
        )
    else:
        shutil.copy2(single, output)
    return output


def patch_map_info(source: Path, work: Path) -> Path:
    output = work / "war3map.w3i"
    if not source or not source.is_file():
        raise SystemExit("map is missing war3map.w3i")
    data = source.read_bytes()
    info = W3I.parse_or_tolerant(data)
    if int(info.get("version", 0)) < 31:
        raise SystemExit(
            "new backpack requires Reforged map-info v31 or newer"
        )
    info["game_data_set"] = 2
    info["game_data_version"] = 2
    output.write_bytes(W3I.write(info))
    return output


def prepare_jass_module(work: Path) -> Path:
    module = work / "jass-module"
    module.mkdir(parents=True, exist_ok=True)
    (module / "g.j").write_text(JASS_GLOBALS, encoding="utf-8")
    (module / "f.j").write_text(JASS_FUNCTIONS, encoding="utf-8")
    (module / "m.j").write_text(JASS_ENTRY, encoding="utf-8")
    return module


def extract_map_data(map_path: Path, work: Path) -> tuple[Path | None, Path | None, str, bytes]:
    work.mkdir(parents=True, exist_ok=True)
    archive = W.MPQArchive(str(map_path))
    try:
        item = archive.read_file("war3map.w3t")
        info = archive.read_file("war3map.w3i")
        jass = archive.read_file("war3map.j") or archive.read_file(r"scripts\war3map.j") or archive.read_file(r"Scripts\war3map.j")
        lua = archive.read_file("war3map.lua") or archive.read_file(r"scripts\war3map.lua") or archive.read_file(r"Scripts\war3map.lua")
        if lua:
            script_kind = "lua"
            script = lua
        elif jass:
            script_kind = "jass"
            script = jass
        else:
            raise SystemExit("map has no readable script: " + str(map_path))
    finally:
        archive.close()
    item_path = work / "source.w3t"
    info_path = work / "source.w3i"
    if item is not None:
        item_path.write_bytes(item)
    else:
        item_path = None
    if info is None:
        info_path = None
    else:
        info_path.write_bytes(info)
    return item_path, info_path, script_kind, script


def patch_map_in_place(
    map_path: Path,
    work: Path,
    panels: tuple[str, ...],
) -> None:
    global CURRENT_PANELS
    CURRENT_PANELS = panels
    if work.exists() and any(work.iterdir()):
        raise SystemExit("new-backpack work directory is not empty: " + str(work))
    work.mkdir(parents=True, exist_ok=True)
    item_source, info_source, script_kind, script = extract_map_data(map_path, work)
    item = merge_item_data(item_source, work)
    info = patch_map_info(info_source, work)
    files = [item, info]
    if script_kind == "jass":
        module = prepare_jass_module(work)
        run(
            [
                sys.executable,
                str(HERE / "inject_native.py"),
                str(map_path),
                "--script",
                str(module),
                "--file",
                str(item) + "=war3map.w3t",
                "--file",
                str(info) + "=war3map.w3i",
                "--no-backup",
            ]
        )
    else:
        lua = work / "war3map.lua"
        lua.write_bytes(script + LUA_RUNTIME.encode("utf-8"))
        files.append(lua)
        run(
            [
                sys.executable,
                str(HERE / "inject_native.py"),
                str(map_path),
                "--file",
                str(item) + "=war3map.w3t",
                "--file",
                str(info) + "=war3map.w3i",
                "--file",
                str(lua) + "=war3map.lua",
                "--no-backup",
            ]
        )


def campaign_work(source: Path, work: Path) -> Path:
    if work.exists() and any(work.iterdir()):
        raise SystemExit("campaign work directory is not empty: " + str(work))
    work.mkdir(parents=True, exist_ok=True)
    run(
        [
            sys.executable,
            str(HERE / "port_wings_campaign.py"),
            "extract",
            str(source),
            "--work",
            str(work),
        ]
    )
    return work / "base"


def process_campaign(source: Path, output: Path, work: Path, panels: tuple[str, ...]) -> None:
    base = campaign_work(source, work / "extract")
    global CURRENT_PANELS
    CURRENT_PANELS = panels
    campaign_dir = work / "campaign"
    campaign_dir.mkdir(parents=True, exist_ok=True)
    campaign_item = base / "war3campaign.w3t"
    merge_item_data(
        campaign_item if campaign_item.is_file() else None,
        campaign_dir,
    )
    generated_campaign_item = campaign_dir / "war3map.w3t"
    campaign_item.write_bytes(generated_campaign_item.read_bytes())
    chapters = sorted(
        path for path in base.iterdir()
        if path.suffix.lower() in (".w3x", ".w3m")
    )
    if not chapters:
        raise SystemExit(
            "campaign has no readable chapter maps: " + str(source)
        )
    for chapter in chapters:
        print("new backpack:", chapter.name)
        patch_map_in_place(
            chapter,
            work / "chapters" / chapter.stem,
            panels,
        )
    run(
        [
            sys.executable,
            str(HERE / "port_wings_campaign.py"),
            "pack",
            str(source),
            "--work",
            str(work / "extract"),
            "--out",
            str(output),
        ]
    )


def verify_map(map_path: Path, panels: tuple[str, ...]) -> None:
    archive = W.MPQArchive(str(map_path))
    try:
        item_data = archive.read_file("war3map.w3t") or b""
        info_data = archive.read_file("war3map.w3i") or b""
        jass = (archive.read_file("war3map.j") or b"").decode("utf-8", "replace")
        lua = (archive.read_file("war3map.lua") or b"").decode("utf-8", "replace")
    finally:
        archive.close()
    _version, entries, _consumed = OBJ.read_objects_bytes(
        item_data, False, "w3t", with_end=True
    )
    entry = next(
        (mods for _table, _old, new, mods in entries if new.replace("\0", "") == BACKPACK_ID),
        None,
    )
    if entry is None:
        raise SystemExit("B30B missing from " + str(map_path))
    fields = {
        mod[0]: (
            mod[4].decode("utf-8", "replace")
            if isinstance(mod[4], bytes)
            else mod[4]
        )
        for mod in entry
    }
    expected = ",".join(PANEL_ABILITIES[item] for item in panels)
    if fields.get("iabi") != expected:
        raise SystemExit("B30B.iabi mismatch: %r != %r" % (fields.get("iabi"), expected))
    info = W3I.parse_or_tolerant(info_data)
    if (info.get("game_data_set"), info.get("game_data_version")) != (2, 2):
        raise SystemExit("map-info is not Reforged 2/2")
    script = jass or lua
    if "ALAS_B30B_EnsureHero" not in script and "local function ensureHero" not in script:
        raise SystemExit("new-backpack hero runtime missing")


CURRENT_PANELS: tuple[str, ...] = DEFAULT_PANELS


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("source")
    parser.add_argument("--output", required=True)
    parser.add_argument("--work", required=True)
    parser.add_argument(
        "--panels",
        default=",".join(DEFAULT_PANELS),
        help="inventory,equipment,stats,talents",
    )
    args = parser.parse_args()
    source = Path(args.source).resolve()
    output = Path(args.output).resolve()
    work = Path(args.work).resolve()
    panels = parse_panels(args.panels)
    if not source.is_file():
        raise SystemExit("source not found: " + str(source))
    if output.exists():
        raise SystemExit("output already exists: " + str(output))
    if source.suffix.lower() == ".w3n":
        process_campaign(source, output, work, panels)
        outer = W.MPQArchive(str(output))
        try:
            chapters = [
                name for name in outer.listfile
                if name.lower().endswith((".w3x", ".w3m"))
            ]
        finally:
            outer.close()
        if not chapters:
            raise SystemExit("campaign has no chapters")
        with tempfile.TemporaryDirectory() as temp_dir:
            temp_root = Path(temp_dir)
            extract_work = temp_root / "check"
            base = campaign_work(output, extract_work)
            for chapter in sorted(
                path for path in base.iterdir()
                if path.suffix.lower() in (".w3x", ".w3m")
            ):
                verify_map(chapter, panels)
    else:
        shutil.copy2(source, output)
        patch_map_in_place(output, work / "map", panels)
        verify_map(output, panels)
    print("panels:", ",".join(panels))
    print("output:", output)
    print("bytes:", output.stat().st_size)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
