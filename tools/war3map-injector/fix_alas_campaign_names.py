#!/usr/bin/env python3
"""Make the in-game campaign title match each alas*.w3n filename.

The title is written as a literal UTF-8 string in war3campaign.w3f, avoiding
the fragile campaign WTS table.  HM3W header names are synchronized as well.
"""

from __future__ import annotations

import argparse
import hashlib
import os
import re
import shutil
import struct
import subprocess
import sys
import tempfile
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
DOCTOR = ROOT / "tools" / "_devos-map-doctor" / "devos-map-doctor-main"
sys.path.insert(0, str(HERE))
sys.path.insert(0, str(DOCTOR))

import mpq_patch  # noqa: E402
import war3mpq as W  # noqa: E402

DEFAULT_DIR = Path(
    r"C:\Users\Administrator\Documents\Warcraft III\Campaigns"
)
PS32 = Path(
    r"C:\Windows\SysWOW64\WindowsPowerShell\v1.0\powershell.exe"
)
SF_ADD = HERE / "sfmpq_add_file.ps1"

# Explicit names prevent old abbreviations and colour tags from leaking back
# into the campaign list.
TITLES = {
    "alas兽族大逃亡": "alas 兽族大逃亡",
    "alas洛丹伦大陆的灾难": "alas 洛丹伦大陆的灾难",
    "alas洛丹伦的终焉之日": "alas 洛丹伦的终焉之日",
    "alas第三章 入侵卡利姆多": "alas 第三章 入侵卡利姆多",
    "alas第二章 诅咒之路": "alas 第二章 诅咒之路",
    "alas第五章 恐怖之潮": "alas 第五章 恐怖之潮",
    "alas血色使命（淬火试炼）2.07": "alas 血色使命（淬火试炼）2.07",
    "alas被遗忘的王国-3.0.1-物品技能翅膀版":
        "alas 被遗忘的王国-3.0.1-物品技能翅膀版",
    "alas被遗忘者的诅咒 v4.0a（全配音·装备翅膀版）":
        "alas 被遗忘者的诅咒 v4.0a（全配音·装备翅膀版）",
}


def strip_colours(value: str) -> str:
    value = re.sub(r"\|c[0-9a-fA-F]{8}", "", value)
    return value.replace("|r", "").replace("|R", "").strip()


def wts_strings(data: bytes) -> dict[int, str]:
    text = data.decode("utf-8-sig", "replace")
    pattern = re.compile(
        r"STRING\s+(\d+)\s*\r?\n(?:[^\r\n{}]*\r?\n)*"
        r"\{(?:\r?\n)?(.*?)\r?\n\}",
        re.S,
    )
    return {int(m.group(1)): m.group(2).strip()
            for m in pattern.finditer(text)}


def read_campaign_title(path: Path) -> tuple[str | None, str | None]:
    try:
        from doctor.mpq import mpqread

        archive = mpqread.Archive(str(path))
        w3f = archive.read("war3campaign.w3f") or b""
        wts = archive.read("war3campaign.wts") or b""
    except Exception:
        archive = W.MPQArchive(str(path))
        try:
            w3f = archive.read_file("war3campaign.w3f") or b""
            wts = archive.read_file("war3campaign.wts") or b""
        finally:
            archive.close()
    if len(w3f) < 12:
        raise SystemExit("%s has no valid war3campaign.w3f" % path.name)
    end = w3f.find(b"\0", 12)
    if end < 0:
        raise SystemExit("%s campaign name is not terminated" % path.name)
    ref = w3f[12:end].decode("utf-8", "replace")
    match = re.fullmatch(r"\s*TRIGSTR_0*(\d+)\s*", ref, re.I)
    resolved = ref
    if match:
        resolved = wts_strings(wts).get(int(match.group(1)), ref)
    header = read_hm3w(path)
    return strip_colours(resolved), strip_colours(header) if header else None


def read_hm3w(path: Path) -> str | None:
    with path.open("rb") as stream:
        block = stream.read(512)
    if block[:4] != b"HM3W":
        return None
    end = block.find(b"\0", 8)
    if end < 0:
        raise SystemExit("%s HM3W name is not terminated" % path.name)
    return block[8:end].decode("utf-8", "replace")


def patch_hm3w(path: Path, title: str) -> None:
    with path.open("r+b") as stream:
        block = bytearray(stream.read(512))
        if block[:4] != b"HM3W":
            return
        end = block.find(b"\0", 8)
        tail_end = max(
            (i + 1 for i, value in enumerate(block[end + 1:], end + 1)
             if value),
            default=end + 1,
        )
        tail = bytes(block[end + 1:tail_end])
        out = (
            b"HM3W" + bytes(block[4:8]) + title.encode("utf-8")
            + b"\0" + tail
        )
        if len(out) > 512:
            raise SystemExit("%s HM3W title is too long" % path.name)
        out += b"\0" * (512 - len(out))
        stream.seek(0)
        stream.write(out)


def make_w3f(old: bytes, title: str) -> bytes:
    end = old.find(b"\0", 12)
    if end < 0:
        raise SystemExit("campaign name is not terminated")
    return old[:12] + title.encode("utf-8") + b"\0" + old[end + 1:]


def backup_w3f(path: Path, data: bytes, backup_root: Path) -> None:
    safe = hashlib.sha1(path.name.encode("utf-8")).hexdigest()[:12]
    backup_root.mkdir(parents=True, exist_ok=True)
    target = backup_root / (safe + ".war3campaign.w3f")
    if not target.exists():
        target.write_bytes(data)


def patch_with_mpq(path: Path, w3f: bytes, backup_root: Path) -> None:
    old = (W.MPQArchive(str(path))).read_file("war3campaign.w3f") or b""
    backup_w3f(path, old, backup_root)
    fd, temp_name = tempfile.mkstemp(suffix=".w3n")
    os.close(fd)
    temp = Path(temp_name)
    try:
        mpq_patch.patch(
            str(path),
            [("war3campaign.w3f", w3f)],
            out_path=str(temp),
            backup=False,
        )
        check = W.MPQArchive(str(temp))
        try:
            if check.read_file("war3campaign.w3f") != w3f:
                raise SystemExit("%s title read-back failed" % path.name)
        finally:
            check.close()
        os.replace(temp, path)
    finally:
        temp.unlink(missing_ok=True)


def patch_with_sfmpq(path: Path, w3f: bytes, backup_root: Path) -> None:
    archive = W.MPQArchive(str(path))
    try:
        old = archive.read_file("war3campaign.w3f") or b""
    finally:
        archive.close()
    backup_w3f(path, old, backup_root)
    fd, temp_name = tempfile.mkstemp(suffix=".w3f")
    os.close(fd)
    temp = Path(temp_name)
    try:
        temp.write_bytes(w3f)
        subprocess.run(
            [
                str(PS32), "-NoProfile", "-ExecutionPolicy", "Bypass",
                "-File", str(SF_ADD),
                "-Map", str(path),
                "-Source", str(temp),
                "-Internal", "war3campaign.w3f",
                "-Replace", "-Compress",
            ],
            check=True,
        )
    finally:
        temp.unlink(missing_ok=True)
    check = W.MPQArchive(str(path))
    try:
        if check.read_file("war3campaign.w3f") != w3f:
            raise SystemExit("%s title read-back failed" % path.name)
    finally:
        check.close()


def desired_title(path: Path) -> str:
    # Prefer the campaign's resolved in-game name. Renaming the output file
    # must not expose an internal stem such as EOH_Reborn_CN in the campaign UI.
    try:
        from doctor.data import campaign_info

        info = campaign_info.read(str(path))
        current = info.get("name") if isinstance(info, dict) else None
    except Exception:
        current = None
    if isinstance(current, str):
        current = strip_colours(current).strip()
        if current and not re.fullmatch(
            r"\s*TRIGSTR_0*\d+\s*", current, re.I
        ):
            if re.match(r"^\s*alas(?:\s|$)", current, re.I):
                return current
            return TITLES.get(current, "alas " + current)
    return TITLES.get(path.stem, "alas " + path.stem[4:].lstrip())


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--dir", type=Path, default=DEFAULT_DIR)
    parser.add_argument("--apply", action="store_true")
    parser.add_argument(
        "--backup-root",
        type=Path,
        default=ROOT / "maps" / "recover" / "alas_campaign_names_20261030",
    )
    args = parser.parse_args()

    paths = sorted(args.dir.glob("alas*.w3n"))
    if not paths:
        raise SystemExit("no alas*.w3n in " + str(args.dir))
    changed = 0
    for path in paths:
        desired = desired_title(path)
        w3f_title, hm3w_title = read_campaign_title(path)
        needs_w3f = w3f_title != desired
        needs_hm3w = hm3w_title is not None and hm3w_title != desired
        print(
            "%s\n  file=%r\n  w3f=%r\n  hm3w=%r\n  desired=%r"
            % (path.name, path.stem, w3f_title, hm3w_title, desired)
        )
        if not (needs_w3f or needs_hm3w):
            continue
        changed += int(args.apply)
        if not args.apply:
            continue
        archive = W.MPQArchive(str(path))
        try:
            old_w3f = archive.read_file("war3campaign.w3f") or b""
        finally:
            archive.close()
        if needs_w3f:
            w3f = make_w3f(old_w3f, desired)
            # MPQArchive uses a 512-byte address window for HM3W-prefixed
            # campaigns, so the native rewriter works for both layouts.
            patch_with_mpq(path, w3f, args.backup_root)
        if needs_hm3w:
            patch_hm3w(path, desired)
        new_w3f, new_hm3w = read_campaign_title(path)
        if new_w3f != desired:
            raise SystemExit("%s W3F title still mismatched" % path.name)
        if new_hm3w is not None and new_hm3w != desired:
            raise SystemExit("%s HM3W title still mismatched" % path.name)
        print("  updated")
    print("campaigns:", len(paths), "changed:", changed)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
