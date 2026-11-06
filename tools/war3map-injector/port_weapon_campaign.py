#!/usr/bin/env python3
"""Add Frostmourne and the Warglaive to a JASS campaign.

This is the JASS counterpart of the Lua item/skill pipeline.  It merges
``I105`` and ``I106`` plus their abilities into the campaign and every chapter,
injects their runtime modules, and patches the item browser with stable ASCII
aliases.  Use it before the campaign's normal item-browser build and chapter
injection steps.

This module provides the weapon object/script/asset helpers used by
``port_alas_jass_campaign.py``. Its CLI only patches an already built browser:

    python port_weapon_campaign.py browser --work maps/port/<campaign>
"""

from __future__ import annotations

import argparse
import os
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(HERE))

import merge_w3obj as M  # noqa: E402
import port_item_skill_campaign as ITEM  # noqa: E402
import war3mpq as W  # noqa: E402

PY = sys.executable
FROST_DIR = ROOT / "scripts" / "frostmourne"
WGL_DIR = ROOT / "scripts" / "warglaive"
DEFAULT_OBJECT_SOURCE = (
    ROOT / "maps" / "port" / "lost_temple_30"
    / "LostTempleLV_BladeMaster30.w3x"
)

WEAPON_ABILITIES = (
    "A105", "A106", "A107", "A108", "A109", "A110",
    "A111", "A113", "A116", "A117", "A118", "A170", "A171",
)
WEAPON_ASSETS = (
    ITEM.DEMON_WARGLAIVE_ICON,
    ITEM.DEMON_WARGLAIVE_DISABLED,
    ITEM.GARREK_CHARGE_ICON,
    ITEM.GARREK_CHARGE_DISABLED,
)


def run(args: list[object], env: dict[str, str] | None = None) -> None:
    text = [str(value) for value in args]
    print(">>>", " ".join(text), flush=True)
    if subprocess.run(text, env=env).returncode:
        raise SystemExit("command failed: " + " ".join(text))


def replace_rawcode(text: str, old_id: str, new_id: str) -> str:
    return text.replace("'%s'" % old_id, "'%s'" % new_id)


def build_warglaive_module(work: Path, item_id: str) -> Path:
    output = work / "warglaive"
    output.mkdir(parents=True, exist_ok=True)
    (output / "g.j").write_text(
        replace_rawcode(ITEM.WGL.WGL_V3_GLOBALS, "I106", item_id),
        encoding="ascii",
    )
    (output / "f.j").write_text(
        replace_rawcode(ITEM.WGL.WGL_V3_FUNCTIONS, "I106", item_id),
        encoding="utf-8",
    )
    (output / "m.j").write_text("call WGL_Init()\n", encoding="ascii")
    return output


def build_frostmourne_module(work: Path, item_id: str) -> Path:
    output = work / "frostmourne"
    output.mkdir(parents=True, exist_ok=True)
    old = b"'I105'"
    new = ("'%s'" % item_id).encode("ascii")
    for filename in ("f.j", "g.j", "m.j"):
        data = (FROST_DIR / filename).read_bytes()
        (output / filename).write_bytes(data.replace(old, new))
    return output


def rename_object_id(
    path: Path,
    extension: str,
    old_id: str,
    new_id: str,
) -> None:
    if old_id == new_id:
        return
    with_levels = extension == "w3a"
    version, entries = ITEM.read_objects_from_path(path, extension)
    if any(entry[2].replace("\0", "") == new_id for entry in entries):
        raise SystemExit(
            "%s already contains object ID %s" % (path.name, new_id)
        )
    output = []
    found = False
    for table, old_base, ident, mods in entries:
        if ident.replace("\0", "") == old_id:
            ident = new_id
            found = True
        output.append((table, old_base, ident, mods))
    if not found:
        raise SystemExit("%s object not found: %s" % (path.name, old_id))
    path.write_bytes(
        ITEM.OBJ.write_objects_bytes(version, output, with_levels)
    )


def merge_object(target: Path, source: Path, extension: str) -> None:
    if not target.is_file():
        raise SystemExit("missing campaign object file: " + str(target))
    fd, temp_name = tempfile.mkstemp(
        suffix="." + extension, dir=str(target.parent)
    )
    os.close(fd)
    temp = Path(temp_name)
    try:
        M.merge_files(str(temp), [str(target), str(source)])
        os.replace(temp, target)
    finally:
        temp.unlink(missing_ok=True)


def build_sources(
    work: Path,
    object_source: Path,
    item_ids: dict[str, str] | None = None,
    charge_buff_id: str = "B64B",
) -> dict[str, Path]:
    if not object_source.is_file():
        raise SystemExit("weapon object source not found: " + str(object_source))
    ITEM.DEFAULT_OBJECT_SOURCE = object_source.resolve()
    source_dir = work / "_weapon_objects"
    source_dir.mkdir(parents=True, exist_ok=True)
    sources = ITEM.extract_object_sources(source_dir)
    ITEM.patch_warglaive_sources(sources)
    ITEM.set_object_mod_value(
        sources["w3a"], "w3a", "A118", "abuf",
        level=1, column=0, value=charge_buff_id,
    )
    ITEM.patch_frostmourne_source(sources)
    item_ids = item_ids or {
        "frostmourne": "I105",
        "warglaive": "I106",
    }
    rename_object_id(
        sources["w3t"], "w3t", "I105", item_ids["frostmourne"]
    )
    rename_object_id(
        sources["w3t"], "w3t", "I106", item_ids["warglaive"]
    )
    return sources


def inject_chapter(
    chapter: Path,
    work: Path,
    sources: dict[str, Path],
    assets: list[tuple[Path, str]],
) -> None:
    archive = W.MPQArchive(str(chapter))
    try:
        script = archive.read_file("war3map.j") or b""
        present = {
            internal.lower()
            for _path, internal in assets
            if archive.read_file(internal)
        }
    finally:
        archive.close()
    if not script:
        raise SystemExit("missing war3map.j: " + str(chapter))
    if b"function FR_Init" in script and b"function WGL_Init" in script:
        print("skip weapon runtime already present:", chapter.name)
        return

    object_dir = work / "_obj_weapon" / chapter.stem
    object_dir.mkdir(parents=True, exist_ok=True)
    args = [PY, HERE / "inject_native.py", chapter, "--no-backup"]
    args += ["--script", FROST_DIR, "--script", WGL_DIR]
    for extension in ("w3a", "w3t"):
        target = object_dir / ("merged." + extension)
        shutil.copy2(chapter, target)
        # Replace the copied map with its requested internal object data.
        copied = W.MPQArchive(str(target))
        try:
            data = copied.read_file("war3map." + extension)
        finally:
            copied.close()
        if not data:
            raise SystemExit("%s has no war3map.%s" % (chapter.name, extension))
        target.write_bytes(data)
        M.merge_files(str(target), [str(target), str(sources[extension])])
        args += ["--file", "%s=war3map.%s" % (target, extension)]
    for path, internal in assets:
        if internal.lower() not in present:
            args += ["--file", "%s=%s" % (path, internal), "--store", internal]
    run(args)


def patch_browser(
    path: Path,
    hand_id: str = "I103",
    frostmourne_id: str = "I105",
    warglaive_id: str = "I106",
) -> None:
    for label, ident in (
        ("Archimonde Hand", hand_id),
        ("Frostmourne", frostmourne_id),
        ("Warglaive", warglaive_id),
    ):
        if len(ident) != 4 or not ident.isascii():
            raise SystemExit("invalid %s item ID: %r" % (label, ident))
    data = path.read_bytes()
    newline = b"\r\n" if b"\r\n" in data[:4096] else b"\n"
    if b'ib_addName == "frostmourne"' not in data:
        marker = (
            b"        if name == ib_addName or IB_StrEqCI("
            b"IB_IdStr(ib_itemList[ib_addIdx]), ib_addName) then"
        )
        if data.count(marker) != 1:
            raise SystemExit("item browser add alias anchor not found")
        indent = b"        "
        block = newline.join([
            indent + b'if ib_addName == "hand" or ib_addName == "akhand" then',
            indent + b"    set ib_addFoundId = '" + hand_id.encode("ascii") + b"'",
            indent + b"    set ib_addFoundIdx = -1",
            indent + b"    set ib_addIdx = ib_itemCount",
            indent + b'elseif ib_addName == "frost" or ib_addName == "frostmourne" then',
            indent + b"    set ib_addFoundId = '"
            + frostmourne_id.encode("ascii") + b"'",
            indent + b"    set ib_addFoundIdx = -1",
            indent + b"    set ib_addIdx = ib_itemCount",
            indent + b'elseif ib_addName == "warglaive" or ib_addName == "glaive" or ib_addName == "eggblade" or ib_addName == "azzinoth" then',
            indent + b"    set ib_addFoundId = '"
            + warglaive_id.encode("ascii") + b"'",
            indent + b"    set ib_addFoundIdx = -1",
            indent + b"    set ib_addIdx = ib_itemCount",
            indent + b"elseif name == ib_addName or IB_StrEqCI("
            b"IB_IdStr(ib_itemList[ib_addIdx]), ib_addName) then",
        ])
        data = data.replace(marker, block, 1)

    if b"abilId == 'A105'" not in data:
        marker = (
            b"function IB_IsItemAbility takes integer abilId returns boolean"
            + newline
        )
        if data.count(marker) != 1:
            raise SystemExit("item browser ability anchor not found")
        conditions = " or ".join(
            "abilId == '%s'" % ident for ident in WEAPON_ABILITIES
        )
        block = (
            marker
            + b"    if " + conditions.encode("ascii") + b" then" + newline
            + b"        return true" + newline
            + b"    endif" + newline
        )
        data = data.replace(marker, block, 1)
    path.write_bytes(data)
    print("patched weapon aliases:", path)


def command_browser(args: argparse.Namespace) -> int:
    path = args.work.resolve() / "item-browser" / "f.j"
    if not path.is_file():
        raise SystemExit("item browser not built: " + str(path))
    patch_browser(
        path,
        args.hand_id,
        args.frostmourne_id,
        args.warglaive_id,
    )
    text = path.read_bytes()
    for marker in (
        ("'%s'" % args.frostmourne_id).encode("ascii"),
        ("'%s'" % args.warglaive_id).encode("ascii"),
        b"frostmourne",
        b"warglaive",
    ):
        if marker not in text:
            raise SystemExit("item browser missing marker: " + str(marker))
    return 0


def main() -> int:
    parser = argparse.ArgumentParser()
    sub = parser.add_subparsers(dest="command", required=True)
    browser_parser = sub.add_parser("browser")
    browser_parser.add_argument("--work", type=Path, required=True)
    browser_parser.add_argument("--hand-id", default="I103")
    browser_parser.add_argument("--frostmourne-id", default="I105")
    browser_parser.add_argument("--warglaive-id", default="I106")
    args = parser.parse_args()
    return command_browser(args)


if __name__ == "__main__":
    raise SystemExit(main())
