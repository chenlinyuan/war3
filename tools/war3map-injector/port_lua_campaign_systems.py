# -*- coding: utf-8 -*-
"""Add the item, skill, wing and Frostmourne systems to Lua campaigns."""

import argparse
import importlib
import os
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

HERE = os.path.dirname(os.path.abspath(__file__))
BASE = os.path.dirname(os.path.dirname(HERE))
DOCTOR = os.path.join(BASE, "tools", "_devos-map-doctor", "devos-map-doctor-main")
sys.path.insert(0, HERE)
sys.path.insert(0, DOCTOR)

import war3mpq as W  # noqa: E402
import port_wings as P  # noqa: E402
from doctor.data import objects as OBJ  # noqa: E402
from doctor.script import jass2lua, lua_ast  # noqa: E402

PY = sys.executable
MARKER = "-- ALAS_LUA_SYSTEMS_V1"
FR_SOURCE = os.path.join(BASE, "heroes", "frostmourne")
FR_SCRIPT = os.path.join(BASE, "scripts", "frostmourne")
ITEM_ICON_DIR = os.path.join(BASE, "heroes", "item_icons")
FR_ASSETS = (
    ("Frostmourne.mdx", r"war3campImported\Frostmourne.mdx"),
    ("Frostmourne10.blp", "Frostmourne10.blp"),
    ("Frostmourne100.blp", "Frostmourne100.blp"),
    ("IceStompRaised.mdx", r"war3campImported\IceStompRaised.mdx"),
    ("Rune-Blue-Aura_Raised20.mdx", r"war3campImported\Rune-Blue-Aura_Raised20.mdx"),
)
ICONS = (
    ("BTNArchimondeHand_30HD.blp",
     r"ReplaceableTextures\CommandButtons\BTNArchimondeHand_30HD.blp"),
    ("DISBTNArchimondeHand_30HD.blp",
     r"ReplaceableTextures\CommandButtonsDisabled\DISBTNArchimondeHand_30HD.blp"),
    ("BTNFrostmourne_30HD.blp",
     r"ReplaceableTextures\CommandButtons\BTNFrostmourne_30HD.blp"),
    ("DISBTNFrostmourne_30HD.blp",
     r"ReplaceableTextures\CommandButtonsDisabled\DISBTNFrostmourne_30HD.blp"),
)
OBJ_FILES = {
    "w3a": (True, ("_wing.w3a", "ability.w3a")),
    "w3t": (False, ("_wing_item.w3t", "item.w3t")),
    "w3u": (False, ("_wing_unit.w3u",)),
    "w3h": (False, ("_wing_buff.w3h",)),
}

RUNTIME_HEAD = r"""
do
local function __alas_i32(v)
  v = v & 0xffffffff
  if v >= 0x80000000 then v = v - 0x100000000 end
  return v
end
local function __iadd(a, b) return __alas_i32(a + b) end
local function __isub(a, b) return __alas_i32(a - b) end
local function __imul(a, b) return __alas_i32(a * b) end
local function __idiv(a, b)
  if b == 0 then return 0 end
  local q = a / b
  return q >= 0 and math.floor(q) or math.ceil(q)
end
local function __cat(...)
  local parts = {...}
  for i = 1, #parts do parts[i] = tostring(parts[i]) end
  return table.concat(parts)
end
local function __arr_i() return setmetatable({}, {__index = function() return 0 end}) end
local function __arr_r() return setmetatable({}, {__index = function() return 0.0 end}) end
local function __arr_b() return setmetatable({}, {__index = function() return false end}) end
local function __arr_s() return setmetatable({}, {__index = function() return "" end}) end

if bj_lastCreatedGroup == nil then bj_lastCreatedGroup = CreateGroup() end
function RMaxBJ(a, b) if a < b then return b else return a end end
function ModuloInteger(a, b)
  if b == 0 then return 0 end
  local r = __idiv(a, b)
  local v = a - r * b
  if v < 0 then v = v + b end
  return v
end
function GetKillingUnitBJ() return GetKillingUnit() end
function IsUnitIllusionBJ(u) return IsUnitIllusion(u) end
function IsUnitAliveBJ(u) return GetUnitTypeId(u) ~= 0 and GetUnitState(u, UNIT_STATE_LIFE) > 0 end
function SetUnitLifeBJ(u, value) SetUnitState(u, UNIT_STATE_LIFE, RMaxBJ(0.0, value)) end
function SetUnitScalePercent(u, x, y, z) SetUnitScale(u, x * 0.01, y * 0.01, z * 0.01) end
function UnitHasItemOfTypeBJ(u, itemId)
  for slot = 0, 5 do
    local it = UnitItemInSlot(u, slot)
    if it ~= nil and GetItemTypeId(it) == itemId then return true end
  end
  return false
end
function TriggerRegisterAnyUnitEventBJ(trig, whichEvent)
  for i = 0, 23 do TriggerRegisterPlayerUnitEvent(trig, Player(i), whichEvent, nil) end
end
function GroupAddGroup(sourceGroup, destGroup)
  local copy = CreateGroup()
  local u = FirstOfGroup(sourceGroup)
  while u ~= nil do
    GroupAddUnit(destGroup, u)
    GroupAddUnit(copy, u)
    GroupRemoveUnit(sourceGroup, u)
    u = FirstOfGroup(sourceGroup)
  end
  u = FirstOfGroup(copy)
  while u ~= nil do
    GroupRemoveUnit(copy, u)
    GroupAddUnit(sourceGroup, u)
    u = FirstOfGroup(copy)
  end
  DestroyGroup(copy)
end
function AdjustPlayerStateBJ(delta, p, state)
  if delta > 0 then
    if state == PLAYER_STATE_RESOURCE_GOLD then
      SetPlayerState(p, PLAYER_STATE_GOLD_GATHERED, GetPlayerState(p, PLAYER_STATE_GOLD_GATHERED) + delta)
    elseif state == PLAYER_STATE_RESOURCE_LUMBER then
      SetPlayerState(p, PLAYER_STATE_LUMBER_GATHERED, GetPlayerState(p, PLAYER_STATE_LUMBER_GATHERED) + delta)
    end
  end
  SetPlayerState(p, state, GetPlayerState(p, state) + delta)
end
function CameraSetEQNoiseForPlayer(p, magnitude)
  if GetLocalPlayer() == p then
    local richter = math.max(2.0, math.min(5.0, magnitude))
    CameraSetTargetNoiseEx(magnitude * 2.0, magnitude * (10 ^ richter), true)
    CameraSetSourceNoiseEx(magnitude * 2.0, magnitude * (10 ^ richter), true)
  end
end
function CameraClearNoiseForPlayer(p)
  if GetLocalPlayer() == p then
    CameraSetSourceNoise(0.0, 0.0)
    CameraSetTargetNoise(0.0, 0.0)
  end
end
function TerrainDeformationRippleBJ(duration, limitNeg, where, startRadius, endRadius, depth, wavePeriod, waveWidth)
  if endRadius <= 0 or waveWidth <= 0 or wavePeriod <= 0 then return nil end
  local timeWave = 2.0 * duration / wavePeriod
  local spaceWave = 2.0 * endRadius / waveWidth
  local radiusRatio = startRadius / endRadius
  return TerrainDeformRipple(GetLocationX(where), GetLocationY(where), endRadius, depth,
    R2I(duration * 1000), 1, spaceWave, timeWave, radiusRatio, limitNeg)
end
"""


def run(args, env=None):
    print(">>>", " ".join(str(x) for x in args), flush=True)
    result = subprocess.run(args, env=env)
    if result.returncode:
        raise SystemExit("command failed (%d): %s" % (result.returncode, args))


def decode_name(value):
    if isinstance(value, bytes):
        value = value.decode("utf-8", "replace")
    return value


def scan_objects(data, with_levels):
    _version, entries, _used = OBJ.read_objects_bytes(
        data, with_levels, fname="(campaign object data)", with_end=True
    )
    return entries


def object_name(mods):
    values = {m[0]: decode_name(m[4]) for m in mods if m[1] == 3}
    return values.get("unam") or values.get("anam") or values.get("utip") or ""


def collect_extra_objects(campaign, chapters):
    items, skills = {}, {}
    archives = [(str(campaign), None)]
    for chapter in chapters:
        archives.append((chapter, chapter))

    for path, _label in archives:
        archive = W.MPQArchive(path)
        try:
            if path == str(campaign):
                prefixes = ("war3campaign.",)
            else:
                prefixes = ("war3map.",)
            for ext, custom_items in (("w3t", items), ("w3a", skills)):
                for prefix in prefixes:
                    data = archive.read_file(prefix + ext)
                    if not data:
                        continue
                    for _table, old, new, mods in scan_objects(data, ext == "w3a"):
                        ident = new.replace("\0", "") or old.replace("\0", "")
                        if not ident:
                            continue
                        name = object_name(mods)
                        if name and not name.startswith("TRIGSTR_"):
                            custom_items.setdefault(ident, name)
        finally:
            archive.close()
    return items, skills


def write_extra_tables(work, cfg, chapters):
    campaign = Path(work) / "_campaign_source.w3n"
    items, skills = collect_extra_objects(campaign, chapters)
    wing_entries = scan_objects((Path(work) / "generated" / "_wing.w3a").read_bytes(), True)
    for _table, old, new, mods in wing_entries:
        ident = new.replace("\0", "") or old.replace("\0", "")
        name = object_name(mods)
        if ident and name:
            skills.setdefault(ident, name)
    for wing in cfg.WINGS:
        items.setdefault(wing["item"], re.sub(r"\|c[0-9A-Fa-f]{8}|\|r", "", wing["name"]))
    items.setdefault(cfg.HAND["item"], "阿克蒙德之手")
    items.setdefault("I160", "霜之哀伤")
    item_lines = ["C\t%s\t%s" % (ident, name) for ident, name in sorted(items.items())]
    item_lines += ["C\tI160\tfrostmourne"]
    (Path(work) / "_itemids_extra.txt").write_text("\n".join(item_lines) + "\n", encoding="utf-8")

    fr_entries = scan_objects((Path(work) / "frostmourne" / "ability.w3a").read_bytes(), True)
    for _table, old, new, mods in fr_entries:
        ident = new.replace("\0", "") or old.replace("\0", "")
        name = object_name(mods)
        if ident and name:
            skills.setdefault(ident, name)
    skill_lines = ["%s\t%s" % (ident, name) for ident, name in sorted(skills.items())]
    (Path(work) / "_skillids_extra.txt").write_text("\n".join(skill_lines) + "\n", encoding="utf-8")


def patch_item_icon(path, item_id, icon):
    data = Path(path).read_bytes()
    version, entries, consumed = OBJ.read_objects_bytes(data, False, fname=path, with_end=True)
    if consumed != len(data):
        raise SystemExit("icon patch: trailing bytes in " + path)
    found = False
    changed = []
    for table, old, new, mods in entries:
        out_mods = []
        replaced = False
        for mod in mods:
            if new.replace("\0", "") == item_id and mod[0] == "iico":
                out_mods.append((mod[0], 3, 0, 0, icon.encode("utf-8"), b"\0\0\0\0"))
                replaced = True
            else:
                out_mods.append(mod)
        if new.replace("\0", "") == item_id and not replaced:
            out_mods.append(("iico", 3, 0, 0, icon.encode("utf-8"), b"\0\0\0\0"))
            replaced = True
        found = found or replaced
        changed.append((table, old, new, OBJ.with_item_sets(out_mods, mods)))
    if not found:
        raise SystemExit("icon patch: item %s not found in %s" % (item_id, path))
    Path(path).write_bytes(OBJ.write_objects_bytes(version, changed, False))


def merge_object_data(target, sources, with_levels):
    entries = []
    version = 3
    ids = set()
    if target.exists():
        data = target.read_bytes()
        version, entries, consumed = OBJ.read_objects_bytes(
            data, with_levels, fname=target.name, with_end=True
        )
        if consumed != len(data):
            raise SystemExit("%s: trailing object bytes" % target)
        ids = {x[1].replace("\0", "") for x in entries} | {x[2].replace("\0", "") for x in entries}
    additions = 0
    for source in sources:
        data = Path(source).read_bytes()
        _v, source_entries, consumed = OBJ.read_objects_bytes(
            data, with_levels, fname=os.path.basename(source), with_end=True
        )
        if consumed != len(data):
            raise SystemExit("%s: trailing object bytes" % source)
        for entry in source_entries:
            old, new = entry[1].replace("\0", ""), entry[2].replace("\0", "")
            key = new or old
            if key in ids:
                continue
            entries.append(entry)
            ids.add(key)
            additions += 1
    target.write_bytes(OBJ.write_objects_bytes(version, entries, with_levels))
    return additions


def transpile(source, label):
    ref = Path(DOCTOR) / "doctor" / "ref" / "1.24"
    common = ref.joinpath("common.j").read_text("utf-8", errors="surrogateescape")
    blizzard = ref.joinpath("blizzard.j").read_text("utf-8", errors="surrogateescape")
    source = re.sub(
        r"(?ms)\nfunction main takes nothing returns nothing.*?\nendfunction\s*$",
        "",
        source,
    )
    result = jass2lua.Transpiler(common, blizzard, source).run()
    if result["warnings"]:
        print("   %s transpiler warnings: %d" % (label, len(result["warnings"])))
    return result["lua_globals"] + "\n" + result["lua_functions"]


def build_lua_module(work, item_browser):
    wing_globals = Path(BASE, "scripts", "wings", "g.j").read_text(
        "utf-8", errors="surrogateescape"
    )
    wing_functions = Path(BASE, "scripts", "wings", "f.j").read_text(
        "utf-8", errors="surrogateescape"
    )
    wing = transpile(
        "globals\n" + wing_globals + "\nendglobals\n" + wing_functions,
        "wings",
    )
    browser_globals = Path(item_browser, "g.j").read_text("utf-8", errors="surrogateescape")
    browser_functions = Path(item_browser, "f.j").read_text("utf-8", errors="surrogateescape")
    browser = transpile(
        "globals\n" + browser_globals + "\nendglobals\n" + browser_functions,
        "item-browser",
    )
    # The JASS build embeds a GBK mirror for 1.27 chat input.  Lua maps use
    # UTF-8, and keeping those raw GBK placeholders would make the source
    # invalid UTF-8.  Point the mirror at the already-cleaned UTF-8 name.
    browser = re.sub(
        r"\bib_(itemNameGbk|unitNameGbk)\[(\d+)\] = \"[^\"]*\"",
        lambda m: "ib_%s[%s] = ib_%s[%s]" % (
            m.group(1), m.group(2),
            "itemName" if m.group(1) == "itemNameGbk" else "unitName",
            m.group(2),
        ),
        browser,
    )
    frost_globals = Path(FR_SCRIPT, "g.j").read_text("utf-8", errors="surrogateescape")
    frost_functions = Path(FR_SCRIPT, "f.j").read_text("utf-8", errors="surrogateescape")
    for old, new in (
        ("I105", "I160"),
        ("A105", "A160"), ("A106", "A161"), ("A107", "A162"),
        ("A108", "A163"), ("A109", "A164"),
    ):
        frost_globals = frost_globals.replace("'%s'" % old, "'%s'" % new)
    for number in range(130, 142):
        frost_functions = frost_functions.replace("'A%d'" % number, "'A%d'" % (number + 50))
    frost = transpile("globals\n" + frost_globals + "\nendglobals\n" + frost_functions, "frostmourne")
    tail = r"""
local __alasInitTimer = CreateTimer()
TimerStart(__alasInitTimer, 0.20, false, function()
  WG_Init()
  IB_Init()
  FR_Init()
end)
end
"""
    module = MARKER + "\n" + RUNTIME_HEAD + "\n" + wing + "\n" + browser + "\n" + frost + "\n" + tail
    lua_ast.parse(module)
    return module


def prepare_item_browser(work, config):
    env = dict(os.environ)
    env["PYTHONIOENCODING"] = "utf-8"
    env["IB_BASE_DIR"] = str(Path(work).resolve())
    env["IB_OUT_DIR"] = str((Path(work) / "item-browser").resolve())
    env["IB_EXTRA_DIR"] = str(Path(work).resolve())
    env["WINGS_CONFIG"] = config
    env["IB_FINGER_ABILITY"] = importlib.import_module(config).HAND["finger"]
    run([PY, os.path.join(HERE, "build_fj.py")], env=env)


def prepare_wings_scripts(config):
    env = dict(os.environ)
    env["PYTHONIOENCODING"] = "utf-8"
    env["WINGS_CONFIG"] = config
    run([PY, os.path.join(HERE, "gen_jass_tables.py")], env=env)


def inject_chapter(source, output, module, object_files, assets):
    archive = W.MPQArchive(str(source))
    try:
        old = archive.read_file("war3map.lua")
    finally:
        archive.close()
    if not old:
        raise SystemExit("%s has no war3map.lua" % source)
    if MARKER.encode() in old:
        raise SystemExit("%s is already injected" % source)
    lua_path = Path(os.path.splitext(output)[0] + ".systems.lua")
    lua_path.write_bytes(old + b"\n" + module.encode("utf-8"))
    args = [PY, os.path.join(HERE, "inject_native.py"), str(source), "--no-backup",
            "--file", str(lua_path) + "=war3map.lua"]
    for path, internal in object_files:
        args += ["--file", str(path) + "=" + internal]
    for path, internal in assets:
        args += [
            "--file", str(path) + "=" + internal,
            "--store", internal,
        ]
    args += ["--out", str(output)]
    run(args)
    lua_path.unlink()


def patch_campaign_title(path, title):
    archive = W.MPQArchive(str(path))
    try:
        data = archive.read_file("war3campaign.wts")
    finally:
        archive.close()
    if not data:
        raise SystemExit("campaign has no war3campaign.wts")
    encoding = "utf-8"
    try:
        text = data.decode("utf-8-sig")
    except UnicodeDecodeError:
        encoding = "gbk"
        text = data.decode("gbk")
    pattern = re.compile(r"(STRING\s+9000\s*\r?\n\{)(.*?)(\})", re.I | re.S)
    replacement = lambda m: m.group(1) + "\r\n" + title + "\r\n" + m.group(3)
    text, count = pattern.subn(replacement, text, count=1)
    if count != 1:
        raise SystemExit("STRING 9000 was not found")
    raw = text.encode("utf-8-sig" if encoding == "utf-8" else "gbk")
    fd, temp_name = tempfile.mkstemp(suffix=".wts")
    os.close(fd)
    temp = Path(temp_name)
    temp.write_bytes(raw)
    return temp


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--campaign", required=True)
    parser.add_argument("--work", required=True)
    parser.add_argument("--config", required=True)
    parser.add_argument("--output", required=True)
    parser.add_argument("--display-name", required=True)
    args = parser.parse_args()

    work = Path(args.work).resolve()
    base = work / "base"
    generated = work / "generated"
    frost = work / "frostmourne"
    chapters = sorted(
        p for p in base.iterdir()
        if p.suffix.lower() in (".w3x", ".w3m")
        and not p.name.endswith(".systems.w3x")
    )

    shutil.copy2(args.campaign, work / "_campaign_source.w3n")
    cfg = importlib.import_module(args.config)

    patch_item_icon(generated / "_wing_item.w3t", cfg.HAND["item"],
                    r"ReplaceableTextures\CommandButtons\BTNArchimondeHand_30HD.blp")
    patch_item_icon(frost / "item.w3t", "I160",
                    r"ReplaceableTextures\CommandButtons\BTNFrostmourne_30HD.blp")
    write_extra_tables(work, cfg, chapters)
    prepare_wings_scripts(args.config)
    prepare_item_browser(work, args.config)
    module = build_lua_module(work, work / "item-browser")

    assets = []
    for source_name, internal in P.WING_MODELS:
        assets.append((P.model_src(source_name), internal))
    assets += [(os.path.join(ITEM_ICON_DIR, name), internal) for name, internal in ICONS]
    assets += [(os.path.join(FR_SOURCE, "assets", name), internal)
               for name, internal in FR_ASSETS]
    for path, _internal in assets:
        if not os.path.exists(path):
            raise SystemExit("missing asset: " + path)

    fixed = []
    for chapter in chapters:
        out = chapter.with_suffix(".systems.w3x")
        object_files = []
        for ext, (with_levels, source_names) in OBJ_FILES.items():
            target = work / "_obj" / chapter.stem / ("merged." + ext)
            target.parent.mkdir(parents=True, exist_ok=True)
            source_archive = W.MPQArchive(str(chapter))
            try:
                original = source_archive.read_file("war3map." + ext)
            finally:
                source_archive.close()
            if original:
                target.write_bytes(original)
            elif target.exists():
                target.unlink()
            sources = []
            if ext in ("w3a", "w3t", "w3u", "w3h"):
                sources.append(generated / source_names[0])
            if ext == "w3a":
                sources.append(frost / "ability.w3a")
            elif ext == "w3t":
                sources.append(frost / "item.w3t")
            additions = merge_object_data(target, sources, with_levels)
            print("   %s %s: +%d objects" % (chapter.name, ext, additions))
            object_files.append((target, "war3map." + ext))
        inject_chapter(chapter, out, module, object_files, assets)
        fixed.append((chapter.name, out))

    output = Path(args.output).resolve()
    shutil.copy2(args.campaign, output)
    title_file = patch_campaign_title(output, args.display_name)
    args_pack = [PY, os.path.join(HERE, "inject_native.py"), str(output), "--no-backup",
                 "--file", str(title_file) + "=war3campaign.wts"]
    for name, path in fixed:
        args_pack += ["--file", str(path) + "=" + name, "--store", name]
    run(args_pack)
    title_file.unlink(missing_ok=True)
    with output.open("rb") as stream:
        has_hm3w = stream.read(4) == b"HM3W"
    if has_hm3w:
        run([PY, os.path.join(HERE, "_patch_hm3w_name.py"), str(output), args.display_name])
    else:
        print("HM3W header: not present; campaign title uses war3campaign.wts")
    print("packed:", output, output.stat().st_size)
    return 0


if __name__ == "__main__":
    sys.exit(main())
