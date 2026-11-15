# -*- coding: utf-8 -*-
"""Merge already-rebuilt chapters into a deployed campaign.

This is intended for incremental single-player repairs:

  1. Rebuild one chapter from the clean platform source.
  2. Merge only that chapter into the current working campaign.
  3. Validate read-back, platform flags, Map Doctor, and Storm subarchives.

No other campaign entries are rewritten except the MPQ container tables.
"""
from __future__ import annotations

import argparse
import json
import os
import shutil
import tempfile
import time
from pathlib import Path

import campaign_singleplayer as CS
import war3mpq as W


def parse_chapter(value: str) -> tuple[str, Path]:
    name, separator, path = value.partition("=")
    if not separator or not name or not path:
        raise argparse.ArgumentTypeError("chapter must be NAME=PATH")
    return name, Path(path).resolve()


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("campaign", type=Path)
    parser.add_argument(
        "--chapter",
        action="append",
        type=parse_chapter,
        required=True,
        metavar="NAME=PATH",
    )
    parser.add_argument("--out", type=Path)
    parser.add_argument(
        "--replace",
        action="store_true",
        help="replace the campaign after validation; old file is kept under _replaced",
    )
    args = parser.parse_args()

    campaign = args.campaign.resolve()
    if not campaign.is_file():
        parser.error("campaign does not exist: %s" % campaign)
    if args.replace and args.out is not None:
        parser.error("--replace cannot be combined with --out")

    archive = W.MPQArchive(str(campaign))
    try:
        existing = set(archive.files())
        all_chapters = sorted(
            name for name in existing if name.lower().endswith((".w3x", ".w3m"))
        )
        patches = []
        for name, path in args.chapter:
            if name not in existing:
                parser.error("chapter is not present in campaign: %s" % name)
            if not path.is_file():
                parser.error("rebuilt chapter does not exist: %s" % path)
            patches.append((name, path.read_bytes()))
    finally:
        archive.close()

    if args.replace:
        output_dir = campaign.parent
    else:
        output = (args.out or campaign.with_name(campaign.stem + ".patched.w3n")).resolve()
        output_dir = output.parent
    output_dir.mkdir(parents=True, exist_ok=True)
    handle, temporary_name = tempfile.mkstemp(
        prefix=".chapter-merge-", suffix=".w3n", dir=output_dir
    )
    os.close(handle)
    temporary = Path(temporary_name)
    try:
        CS.MP.patch(
            str(campaign),
            patches,
            out_path=str(temporary),
            backup=False,
            store=[name for name, _data in patches],
            compact=False,
        )
        CS.clear_platform_flags(temporary)
        platform = CS.platform_entry_stats(temporary)
        if platform["nonzero"]:
            raise RuntimeError(
                "merged campaign still has %d non-zero platform entries"
                % platform["nonzero"]
            )

        verify = W.MPQArchive(str(temporary))
        try:
            for name, data in patches:
                if verify.read_file(name) != data:
                    raise RuntimeError("chapter read-back mismatch: " + name)
        finally:
            verify.close()

        checks = {}
        patch_paths = dict(args.chapter)
        for name, _data in patches:
            chapter_path = patch_paths[name]
            checks[name] = {
                "doctor_1_27": CS.doctor_check(chapter_path, "1.27"),
                "doctor_reforged": CS.doctor_check(chapter_path, ""),
            }
            for check_name, result in checks[name].items():
                if not result["ok"]:
                    raise RuntimeError(
                        "%s %s failed: %s"
                        % (name, check_name, result["output_tail"])
                    )
        storm = CS.storm_subarchive_check(temporary, all_chapters)
        if not storm["ok"]:
            raise RuntimeError(
                "Storm opened %d/%d chapters"
                % (storm["opened"], storm["expected"])
            )

        report = {
            "campaign": str(campaign),
            "chapters": [name for name, _data in patches],
            "platform": platform,
            "checks": checks,
            "storm_subarchives": storm,
            "output_sha256": CS.sha256_file(temporary),
            "output_bytes": temporary.stat().st_size,
        }

        if args.replace:
            stamp = time.strftime("%Y%m%d-%H%M%S")
            backup = (
                campaign.parent
                / "_replaced"
                / stamp
                / campaign.name
            )
            backup.parent.mkdir(parents=True, exist_ok=True)
            shutil.move(str(campaign), str(backup))
            try:
                os.replace(temporary, campaign)
            except Exception:
                shutil.move(str(backup), str(campaign))
                raise
            report["backup"] = str(backup)
            report["output"] = str(campaign)
            final = campaign
        else:
            os.replace(temporary, output)
            report["output"] = str(output)
            final = output

        report_path = final.with_suffix(final.suffix + ".patch-report.json")
        report_path.write_text(
            json.dumps(report, ensure_ascii=False, indent=2) + "\n",
            encoding="utf-8",
        )
        print("Merged: %s" % final)
        print("Report: %s" % report_path)
        print("SHA-256: %s" % report["output_sha256"])
        return 0
    finally:
        if temporary.exists():
            temporary.unlink()


if __name__ == "__main__":
    raise SystemExit(main())
