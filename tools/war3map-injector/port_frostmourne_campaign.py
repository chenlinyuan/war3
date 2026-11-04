# -*- coding: utf-8 -*-
"""Add Frostmourne runtime, object data, assets and item-browser entry to a campaign."""
import argparse
import os
import re
import shutil
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
BASE = os.path.dirname(os.path.dirname(HERE))
PY = sys.executable or r"C:\Python313\python.exe"
sys.path.insert(0, HERE)

import merge_w3obj as M  # noqa: E402
import objparse as O  # noqa: E402
import war3mpq as W  # noqa: E402

FR_DIR = os.path.join(BASE, "heroes", "frostmourne")
FR_SCRIPT = os.path.join(BASE, "scripts", "frostmourne")
OLD_ICON = r"ReplaceableTextures\CommandButtons\BTNFrostMourne.blp"
FR_IDS = {
    "w3t": {"I105"},
    "w3a": {"A105", "A106", "A107", "A108", "A109", "A170"},
}
FR_ASSETS = [
    ("Frostmourne.mdx", r"war3campImported\Frostmourne.mdx"),
    ("Frostmourne10.blp", "Frostmourne10.blp"),
    ("Frostmourne100.blp", "Frostmourne100.blp"),
    ("IceStompRaised.mdx", r"war3campImported\IceStompRaised.mdx"),
    ("Rune-Blue-Aura_Raised20.mdx",
     r"war3campImported\Rune-Blue-Aura_Raised20.mdx"),
]


def replace_once(data, old, new, label):
    count = data.count(old)
    if count != 1:
        raise SystemExit("%s: expected 1 occurrence, found %d" % (label, count))
    return data.replace(old, new, 1)


def staged_objects(out_dir):
    os.makedirs(out_dir, exist_ok=True)
    result = {}
    for ext, filename in (("w3t", "item.w3t"), ("w3a", "ability.w3a")):
        source = os.path.join(FR_DIR, filename)
        version, original, custom = O.read_bytes(open(source, "rb").read(), ext)
        for entry in custom:
            for mod in entry["mods"]:
                if mod[0] in ("iico", "aart", "arar") and mod[4]:
                    mod[4] = OLD_ICON
        target = os.path.join(out_dir, filename)
        open(target, "wb").write(O.build_bytes(version, original, custom, ext))
        result[ext] = target
    return result


def entry_ids(path):
    _version, original, custom = M.read_all(path)
    return {entry[4:8].decode("latin-1") for entry in original + custom}


def merge_missing(target, source, ext):
    ids = entry_ids(target)
    wanted = FR_IDS[ext]
    if wanted <= ids:
        return False
    tmp = target + ".frostmourne.tmp"
    M.merge_files(tmp, [target, source])
    os.replace(tmp, target)
    return True


def patch_browser(data):
    nl = b"\r\n" if b"\r\n" in data[:4096] else b"\n"
    item_match = re.search(rb"set ib_itemList\[(\d+)\] = 'I105'", data)
    if item_match:
        item_idx = int(item_match.group(1))
    else:
        indices = [int(x) for x in re.findall(rb"set ib_itemList\[(\d+)\]", data)]
        counts = [int(x) for x in re.findall(rb"set ib_itemCount = (\d+)", data)]
        if not indices or not counts:
            raise SystemExit("campaign item-list anchor not found")
        item_count = max(counts)
        last_idx = max(indices)
        if last_idx + 1 != item_count:
            raise SystemExit(
                "campaign item-list is inconsistent: last=%d count=%d"
                % (last_idx, item_count)
            )
        item_idx = item_count
        lines = data.splitlines(keepends=True)
        start = end = None
        for i, line in enumerate(lines):
            if re.search(rb"set ib_itemList\[%d\]" % last_idx, line):
                start = i
            if start is not None and re.search(
                rb"set ib_itemNameGbk\[%d\]" % last_idx, line
            ):
                end = i + 1
                break
        if start is None:
            raise SystemExit("campaign item-list last row not found")
        if end is None:
            end = start + 1
        lines[end:end] = [
            ("    set ib_itemList[%d] = 'I105'" % item_idx).encode("ascii") + nl,
            ('    set ib_itemName[%d] = "霜之哀伤"' % item_idx).encode("utf-8") + nl,
            ("    set ib_itemCustom[%d] = 1" % item_idx).encode("ascii") + nl,
            ('    set ib_itemNameGbk[%d] = "' % item_idx).encode("ascii")
            + "霜之哀伤".encode("gbk") + b'"' + nl,
        ]
        data = b"".join(lines)
        data, changed = re.subn(
            rb"(set ib_itemCount = )%d\b" % item_count,
            rb"\g<1>" + str(item_count + 1).encode("ascii"),
            data,
            count=1,
        )
        if changed != 1:
            raise SystemExit("campaign item count update failed")

    if b'ib_addName == "frostmourne"' not in data:
        alias_match = re.search(
            rb"(?m)^([ \t]*)if name == ib_addName or IB_StrEqCI\("
            rb"IB_IdStr\(ib_itemList\[ib_addIdx\]\), ib_addName\) then(\r?\n)",
            data,
        )
        if not alias_match:
            raise SystemExit("campaign additem alias anchor not found")
        indent, alias_nl = alias_match.group(1), alias_match.group(2)
        alias = alias_nl.join([
            indent + b'if ib_addName == "frostmourne" or ib_addName == "frost" then',
            indent + b"    set ib_addFoundId = 'I105'",
            indent + ("    set ib_addFoundIdx = %d" % item_idx).encode("ascii"),
            indent + b"    set ib_addIdx = ib_itemCount",
            indent + b"elseif name == ib_addName or IB_StrEqCI("
            b"IB_IdStr(ib_itemList[ib_addIdx]), ib_addName) then",
        ]) + alias_nl
        data = data[:alias_match.start()] + alias + data[alias_match.end():]

    if b"abilId == 'A105'" not in data:
        ability_match = re.search(
            rb"(?m)^function IB_IsItemAbility takes integer abilId returns boolean(\r?\n)",
            data,
        )
        if not ability_match:
            raise SystemExit("campaign item ability anchor not found")
        ability_nl = ability_match.group(1)
        ability = ability_nl.join([
            b"function IB_IsItemAbility takes integer abilId returns boolean",
            b"    if abilId == 'A105' or abilId == 'A106' or abilId == 'A107' or "
            b"abilId == 'A108' or abilId == 'A109' or abilId == 'A170' then",
            b"        return true",
            b"    endif",
        ]) + ability_nl
        data = data[:ability_match.start()] + ability + data[ability_match.end():]
    return data


def patch_browser_source(path):
    data = open(path, "rb").read()
    patched = patch_browser(data)
    if patched != data:
        open(path, "wb").write(patched)
        print("patched item browser source:", path)


def run(args):
    print(">>>", " ".join(args), flush=True)
    result = subprocess.run(args)
    if result.returncode:
        raise SystemExit("command failed: %s" % args)


def inject_chapter(path, objects, work, campaign_assets=False):
    chapter = os.path.splitext(os.path.basename(path))[0]
    object_dir = os.path.join(work, "_obj", chapter)
    os.makedirs(object_dir, exist_ok=True)
    archive = W.MPQArchive(path)
    try:
        script = archive.read_file("war3map.j") or b""
        present = {
            internal.lower()
            for _filename, internal in FR_ASSETS
            if archive.read_file(internal)
        }
    finally:
        archive.close()

    has_runtime = b"function FR_Init" in script
    browser_patched = patch_browser(script)
    browser_changed = browser_patched != script
    changed_objects = {}
    for ext, source in objects.items():
        target = os.path.join(object_dir, "merged." + ext)
        if not os.path.exists(target):
            chapter_archive = W.MPQArchive(path)
            try:
                data = chapter_archive.read_file("war3map." + ext)
            finally:
                chapter_archive.close()
            if not data:
                shutil.copy2(source, target)
                changed_objects[ext] = target
                continue
            open(target, "wb").write(data)
        if merge_missing(target, source, ext):
            changed_objects[ext] = target
    assets_complete = all(
        internal.lower() in present for _filename, internal in FR_ASSETS
    )
    if has_runtime and not browser_changed and (
        campaign_assets or assets_complete
    ) and not changed_objects:
        print("skip already complete:", path)
        return False

    tmp_script = None
    args = [PY, os.path.join(HERE, "inject_native.py"), path, "--no-backup"]
    if not has_runtime:
        args += ["--script", FR_SCRIPT]
    if browser_changed:
        fd, tmp_script = tempfile.mkstemp(suffix=".j")
        os.close(fd)
        open(tmp_script, "wb").write(browser_patched)
        if has_runtime:
            args += ["--file", tmp_script + "=war3map.j"]
        else:
            args += ["--base-script", tmp_script]
    for ext, source in changed_objects.items():
        args += ["--file", source + "=war3map." + ext]
    if not campaign_assets:
        for filename, internal in FR_ASSETS:
            if internal.lower() not in present:
                args += [
                    "--file", os.path.join(FR_DIR, "assets", filename) + "=" + internal,
                    "--store", internal,
                ]
    try:
        run(args)
    finally:
        if tmp_script and os.path.exists(tmp_script):
            os.remove(tmp_script)
    return True


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--campaign", required=True)
    parser.add_argument("--work", required=True)
    parser.add_argument("--output", required=True)
    parser.add_argument("--no-deploy", action="store_true")
    parser.add_argument("--campaign-assets", action="store_true")
    args = parser.parse_args()

    work = os.path.abspath(args.work)
    base = os.path.join(work, "base")
    staged = staged_objects(os.path.join(work, "_frostmourne"))

    for ext, source in staged.items():
        target = os.path.join(base, "war3campaign." + ext)
        if merge_missing(target, source, ext):
            print("merged campaign object data:", ext)

    browser_source = os.path.join(work, "item-browser", "f.j")
    if os.path.exists(browser_source):
        patch_browser_source(browser_source)

    chapters = sorted(
        name for name in os.listdir(base)
        if name.lower().endswith((".w3m", ".w3x"))
    )
    for name in chapters:
        print("\n==", name, "==")
        inject_chapter(os.path.join(base, name), staged, work, args.campaign_assets)

    run([
        PY, os.path.join(HERE, "port_wings_campaign.py"), "pack",
        os.path.abspath(args.campaign), "--work", work,
        "--out", os.path.abspath(args.output),
    ])

    if args.campaign_assets:
        args_assets = [
            PY, os.path.join(HERE, "inject_native.py"),
            os.path.abspath(args.output), "--no-backup",
        ]
        for filename, internal in FR_ASSETS:
            args_assets += [
                "--file", os.path.join(FR_DIR, "assets", filename) + "=" + internal,
                "--store", internal,
            ]
        run(args_assets)

    if not args.no_deploy:
        backup = os.path.abspath(args.campaign) + ".before_frostmourne"
        if not os.path.exists(backup):
            shutil.copy2(os.path.abspath(args.campaign), backup)
            print("backup:", backup)
        shutil.copy2(os.path.abspath(args.output), os.path.abspath(args.campaign))
        print("deployed:", os.path.abspath(args.campaign))
    return 0


if __name__ == "__main__":
    sys.exit(main())
