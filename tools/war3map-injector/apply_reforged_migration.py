#!/usr/bin/env python3
"""Migrate legacy TFT map-info data to the Reforged data baseline."""

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
DOCTOR = ROOT / "tools" / "_devos-map-doctor" / "devos-map-doctor-main"
sys.path[:0] = [str(HERE), str(DOCTOR)]
sys.stdout.reconfigure(errors="replace")
sys.stderr.reconfigure(errors="replace")

import mpq_patch  # noqa: E402
import war3mpq as W  # noqa: E402
from doctor.data import w3i as W3I  # noqa: E402


TARGET_MAP_INFO_VERSION = 31
TARGET_GAME_DATA_SET = 2
TARGET_GAME_DATA_VERSION = 2


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
            "command failed (%d): %s"
            % (result.returncode, " ".join(args))
        )


def migrated_map_info(data: bytes, label: str) -> tuple[bytes, str]:
    if not data:
        raise SystemExit(label + ": missing war3map.w3i")
    model = W3I.parse(data)
    version = int(model.get("version", 0))
    if version < 25:
        raise SystemExit(
            "%s: map-info v%d is too old for automatic migration "
            "(minimum v25)" % (label, version)
        )
    current = (
        int(model.get("game_data_set", 0)),
        int(model.get("game_data_version", 0)),
    )
    if version >= TARGET_MAP_INFO_VERSION and current == (
        TARGET_GAME_DATA_SET,
        TARGET_GAME_DATA_VERSION,
    ):
        return data, "already v%d, data %d/%d" % (
            version,
            TARGET_GAME_DATA_SET,
            TARGET_GAME_DATA_VERSION,
        )
    if version < TARGET_MAP_INFO_VERSION:
        model["version"] = TARGET_MAP_INFO_VERSION
        model["supported_modes"] = int(model.get("supported_modes", 3))
    model["game_data_set"] = TARGET_GAME_DATA_SET
    model["game_data_version"] = TARGET_GAME_DATA_VERSION
    updated = W3I.write(model)
    checked = W3I.parse(updated)
    if int(checked.get("version", 0)) < TARGET_MAP_INFO_VERSION:
        raise SystemExit(label + ": migrated map-info version read-back failed")
    if (
        int(checked.get("game_data_set", 0)),
        int(checked.get("game_data_version", 0)),
    ) != (TARGET_GAME_DATA_SET, TARGET_GAME_DATA_VERSION):
        raise SystemExit(label + ": migrated game-data read-back failed")
    return updated, "v%d, data %d/%d -> v%d, data %d/%d" % (
        version,
        current[0],
        current[1],
        int(checked["version"]),
        TARGET_GAME_DATA_SET,
        TARGET_GAME_DATA_VERSION,
    )


def patch_map(map_path: Path) -> None:
    archive = W.MPQArchive(str(map_path))
    try:
        source = archive.read_file("war3map.w3i")
    finally:
        archive.close()
    if not source:
        raise SystemExit(str(map_path) + ": missing war3map.w3i")
    updated, status = migrated_map_info(source, str(map_path))
    if updated == source:
        print("%s: %s" % (map_path.name, status))
        return
    mpq_patch.patch(
        str(map_path),
        [("war3map.w3i", updated)],
        out_path=str(map_path),
        backup=False,
        compact=False,
    )
    check = W.MPQArchive(str(map_path))
    try:
        written = check.read_file("war3map.w3i")
    finally:
        check.close()
    if written != updated:
        raise SystemExit(str(map_path) + ": war3map.w3i write-back failed")
    print("%s: %s" % (map_path.name, status))


def extract_campaign(source: Path, work: Path) -> Path:
    if work.exists() and any(work.iterdir()):
        raise SystemExit("migration work directory is not empty: " + str(work))
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
    base = work / "base"
    if not base.is_dir():
        raise SystemExit("campaign extraction did not create base directory")
    return base


def campaign_chapters(base: Path) -> list[Path]:
    chapters = sorted(
        path
        for path in base.iterdir()
        if path.suffix.lower() in (".w3x", ".w3m")
    )
    if not chapters:
        raise SystemExit("campaign has no chapter maps")
    return chapters


def verify_map(map_path: Path) -> str:
    archive = W.MPQArchive(str(map_path))
    try:
        data = archive.read_file("war3map.w3i")
    finally:
        archive.close()
    if not data:
        raise SystemExit(str(map_path) + ": missing war3map.w3i")
    model = W3I.parse(data)
    version = int(model.get("version", 0))
    data_version = (
        int(model.get("game_data_set", 0)),
        int(model.get("game_data_version", 0)),
    )
    if version < TARGET_MAP_INFO_VERSION:
        raise SystemExit("%s: map-info is still v%d" % (map_path.name, version))
    if data_version != (
        TARGET_GAME_DATA_SET,
        TARGET_GAME_DATA_VERSION,
    ):
        raise SystemExit(
            "%s: game data is still %d/%d"
            % (map_path.name, data_version[0], data_version[1])
        )
    return "v%d, data %d/%d" % (
        version,
        data_version[0],
        data_version[1],
    )


def verify_campaign(path: Path) -> int:
    outer = W.MPQArchive(str(path))
    checked = 0
    try:
        chapters = sorted(
            name
            for name in outer.listfile
            if name.lower().endswith((".w3x", ".w3m"))
        )
        if not chapters:
            raise SystemExit("campaign has no chapter maps: " + str(path))
        with tempfile.TemporaryDirectory() as temp_dir:
            for name in chapters:
                data = outer.read_file(name)
                if not data:
                    raise SystemExit("cannot read chapter: " + name)
                temp = Path(temp_dir) / Path(name).name
                temp.write_bytes(data)
                status = verify_map(temp)
                print("verify %s: %s" % (name, status))
                checked += 1
    finally:
        outer.close()
    return checked


def migrate(source: Path, output: Path, work: Path) -> None:
    suffix = source.suffix.lower()
    if suffix in (".w3x", ".w3m"):
        shutil.copy2(source, output)
        patch_map(output)
        print("verify:", verify_map(output))
        return
    if suffix != ".w3n":
        raise SystemExit("unsupported source: " + str(source))
    base = extract_campaign(source, work)
    for chapter in campaign_chapters(base):
        patch_map(chapter)
    run(
        [
            sys.executable,
            str(HERE / "port_wings_campaign.py"),
            "pack",
            str(source),
            "--work",
            str(work),
            "--out",
            str(output),
            "--chapters-only",
        ]
    )
    checked = verify_campaign(output)
    print("verified campaign chapters:", checked)


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("source")
    parser.add_argument("--output", required=True)
    parser.add_argument("--work", required=True)
    args = parser.parse_args()
    source = Path(args.source).resolve()
    output = Path(args.output).resolve()
    work = Path(args.work).resolve()
    if not source.is_file():
        raise SystemExit("source not found: " + str(source))
    if output.exists():
        raise SystemExit("output already exists: " + str(output))
    output.parent.mkdir(parents=True, exist_ok=True)
    migrate(source, output, work)
    print("output:", output)
    print("bytes:", output.stat().st_size)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
