# -*- coding: utf-8 -*-
"""Remove a KK campaign's authored backpack-switch ability before ALAS edits."""
from __future__ import annotations

import argparse
import json
import shutil
import sys
import tempfile
from pathlib import Path


HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))

import _patch_backpack_switch as BACKPACK  # noqa: E402
import mpq_patch as MP  # noqa: E402
import war3mpq as W  # noqa: E402


SCRIPT_NAMES = (
    "war3map.j",
    r"scripts\war3map.j",
    r"Scripts\war3map.j",
    "war3map.lua",
    r"scripts\war3map.lua",
    r"Scripts\war3map.lua",
)
OBJECT_SUFFIXES = ("w3a", "w3t", "w3u", "w3h", "w3d", "w3q", "w3b")
MAP_OBJECT_NAMES = tuple(
    prefix + suffix
    for prefix in ("war3map.", "war3mapSkin.")
    for suffix in OBJECT_SUFFIXES
)
CAMPAIGN_OBJECT_NAMES = tuple(
    prefix + suffix
    for prefix in ("war3campaign.", "war3campaignSkin.")
    for suffix in OBJECT_SUFFIXES
)


def plan_archive(
    archive: W.MPQArchive,
    ability_ids: set[str],
    *,
    campaign_level: bool,
) -> tuple[list[tuple[str, bytes]], list[dict[str, object]]]:
    """Return complete replacement files and machine-readable records."""
    patches: list[tuple[str, bytes]] = []
    records: list[dict[str, object]] = []
    for name in SCRIPT_NAMES:
        data = archive.read_file(name)
        if not data:
            continue
        text = data.decode("utf-8", "surrogateescape")
        updated, script_records = BACKPACK.patch_script(text, ability_ids)
        encoded = updated.encode("utf-8", "surrogateescape")
        if encoded == data:
            continue
        patches.append((name, encoded))
        records.append(
            {
                "file": name,
                "kind": "script",
                "records": script_records,
            }
        )

    object_names = (
        CAMPAIGN_OBJECT_NAMES if campaign_level else MAP_OBJECT_NAMES
    )
    for name in object_names:
        data = archive.read_file(name)
        if not data:
            continue
        extension = name.rsplit(".", 1)[-1]
        updated, object_record = BACKPACK.patch_objects(
            data,
            extension,
            ability_ids,
        )
        if updated == data:
            continue
        patches.append((name, updated))
        records.append(
            {
                "file": name,
                "kind": "objects",
                "records": object_record,
            }
        )
    return patches, records


def _verify_archive(
    path: Path,
    ability_ids: set[str],
    *,
    campaign_level: bool,
) -> list[str]:
    archive = W.MPQArchive(str(path))
    try:
        patches, _records = plan_archive(
            archive,
            ability_ids,
            campaign_level=campaign_level,
        )
        problems = ["remaining:" + name for name, _data in patches]
        for name in SCRIPT_NAMES:
            data = archive.read_file(name)
            if not data:
                continue
            problems.extend(
                name + ":" + item
                for item in BACKPACK.verify_script(
                    data.decode("utf-8", "surrogateescape"),
                    ability_ids,
                )
            )
        return sorted(set(problems))
    finally:
        archive.close()


def patch_map(
    source: Path,
    output: Path,
    ability_ids: set[str],
) -> dict[str, object]:
    archive = W.MPQArchive(str(source))
    try:
        patches, records = plan_archive(
            archive,
            ability_ids,
            campaign_level=False,
        )
    finally:
        archive.close()
    if patches:
        MP.patch(
            str(source),
            patches,
            out_path=str(output),
            backup=False,
        )
    else:
        shutil.copy2(source, output)
    problems = _verify_archive(
        output,
        ability_ids,
        campaign_level=False,
    )
    if problems:
        raise RuntimeError(
            "source backpack removal verification failed: "
            + "; ".join(problems[:8])
        )
    return {
        "source": str(source),
        "output": str(output),
        "source_kind": "map",
        "ability_ids": sorted(ability_ids),
        "changed": bool(patches),
        "patched_files": len(patches),
        "details": records,
    }


def patch_campaign(
    source: Path,
    output: Path,
    ability_ids: set[str],
) -> dict[str, object]:
    outer = W.MPQArchive(str(source))
    chapter_names = sorted(
        name
        for name in outer.listfile
        if name.lower().endswith((".w3x", ".w3m"))
    )
    outer_patches: list[tuple[str, bytes]] = []
    details: list[dict[str, object]] = []
    try:
        campaign_patches, campaign_records = plan_archive(
            outer,
            ability_ids,
            campaign_level=True,
        )
        outer_patches.extend(campaign_patches)
        if campaign_records:
            details.append(
                {
                    "scope": "campaign",
                    "records": campaign_records,
                }
            )
        with tempfile.TemporaryDirectory(
            prefix="source-backpack-"
        ) as temporary:
            work = Path(temporary)
            for chapter_name in chapter_names:
                chapter_data = outer.read_file(chapter_name)
                if not chapter_data:
                    raise RuntimeError(
                        "campaign chapter is unreadable: " + chapter_name
                    )
                chapter_source = work / "source.map"
                chapter_source.write_bytes(chapter_data)
                chapter_archive = W.MPQArchive(str(chapter_source))
                try:
                    patches, records = plan_archive(
                        chapter_archive,
                        ability_ids,
                        campaign_level=False,
                    )
                finally:
                    chapter_archive.close()
                if not patches:
                    continue
                chapter_output = work / "patched.map"
                MP.patch(
                    str(chapter_source),
                    patches,
                    out_path=str(chapter_output),
                    backup=False,
                )
                outer_patches.append(
                    (chapter_name, chapter_output.read_bytes())
                )
                details.append(
                    {
                        "scope": "chapter",
                        "chapter": chapter_name,
                        "records": records,
                    }
                )
    finally:
        outer.close()

    if outer_patches:
        MP.patch(
            str(source),
            outer_patches,
            out_path=str(output),
            backup=False,
            store=[
                name
                for name, _data in outer_patches
                if name.lower().endswith((".w3x", ".w3m"))
            ],
        )
    else:
        shutil.copy2(source, output)

    verified = W.MPQArchive(str(output))
    try:
        campaign_remaining, _records = plan_archive(
            verified,
            ability_ids,
            campaign_level=True,
        )
        if campaign_remaining:
            raise RuntimeError(
                "campaign-level backpack switch remains: "
                + ", ".join(name for name, _data in campaign_remaining)
            )
        with tempfile.TemporaryDirectory(
            prefix="source-backpack-verify-"
        ) as temporary:
            work = Path(temporary)
            for index, chapter_name in enumerate(chapter_names, 1):
                data = verified.read_file(chapter_name)
                if not data:
                    raise RuntimeError(
                        "patched chapter is unreadable: " + chapter_name
                    )
                path = work / ("verify-%04d.map" % index)
                path.write_bytes(data)
                remaining = _verify_archive(
                    path,
                    ability_ids,
                    campaign_level=False,
                )
                if remaining:
                    raise RuntimeError(
                        chapter_name
                        + ": source backpack switch remains: "
                        + "; ".join(remaining[:8])
                    )
    finally:
        verified.close()

    return {
        "source": str(source),
        "output": str(output),
        "source_kind": "campaign",
        "ability_ids": sorted(ability_ids),
        "changed": bool(outer_patches),
        "patched_files": len(outer_patches),
        "chapters": len(chapter_names),
        "details": details,
    }


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--source", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument(
        "--ability-id",
        action="append",
        default=[],
        required=True,
    )
    args = parser.parse_args(argv)
    source = args.source.resolve()
    output = args.output.resolve()
    if output.exists():
        raise RuntimeError("output already exists: " + str(output))
    ability_ids = {
        value.strip()
        for value in args.ability_id
        if value.strip()
    }
    if source.suffix.lower() == ".w3n":
        report = patch_campaign(source, output, ability_ids)
    else:
        report = patch_map(source, output, ability_ids)
    print(json.dumps(report, ensure_ascii=False, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
