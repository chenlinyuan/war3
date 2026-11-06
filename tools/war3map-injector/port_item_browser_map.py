#!/usr/bin/env python3
"""Inject only the item browser into a clean JASS map.

This build intentionally does not inject wings, the Archimonde Hand,
Frostmourne, Warglaive, or any other custom equipment object.
"""

from __future__ import annotations

import argparse
import os
import shutil
import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(HERE))

import war3mpq as W  # noqa: E402
import port_wings as PW  # noqa: E402


def run(args: list[str], *, env: dict[str, str] | None = None) -> None:
    merged_env = dict(os.environ)
    merged_env.setdefault("PYTHONUTF8", "1")
    merged_env.setdefault("PYTHONIOENCODING", "utf-8")
    if env:
        merged_env.update(env)
    print(">>>", " ".join(args), flush=True)
    result = subprocess.run(
        args,
        cwd=str(HERE),
        env=merged_env,
        capture_output=True,
        text=True,
        encoding="utf-8",
        errors="replace",
    )
    if result.stdout:
        print(result.stdout, end="" if result.stdout.endswith("\n") else "\n")
    if result.stderr:
        print(result.stderr, end="" if result.stderr.endswith("\n") else "\n")
    if result.returncode:
        raise SystemExit(
            "command failed (%d): %s" % (result.returncode, " ".join(args))
        )


def stage_target_data(source: Path, stage: Path) -> None:
    wanted = (
        "war3map.w3t",
        "war3map.w3a",
        "war3map.w3u",
        "war3map.w3h",
        "war3map.wts",
        r"units\itemdata.slk",
        r"units\abilitydata.slk",
        r"units\itemstrings.txt",
        r"units\itemfunc.txt",
    )
    archive = W.MPQArchive(str(source))
    try:
        for internal in wanted:
            data = archive.read_file(internal)
            if not data:
                continue
            output = stage / internal.replace("\\", os.sep)
            output.parent.mkdir(parents=True, exist_ok=True)
            output.write_bytes(data)
    finally:
        archive.close()


def build_browser(source: Path, work: Path, browser_dir: Path) -> None:
    browser_dir.mkdir(parents=True, exist_ok=True)
    source_scripts = ROOT / "scripts" / "item-browser"
    for filename in ("f.j", "g.j", "m.j"):
        shutil.copy2(source_scripts / filename, browser_dir / filename)

    stage = work / "_ibsrc"
    stage.mkdir(parents=True, exist_ok=True)
    stage_target_data(source, stage)
    env = {
        "IB_OUT_DIR": str(browser_dir),
        "IB_EXTRA_DIR": str(work),
        "IB_BASE_DIR": str(work),
        "IB_FINGER_ABILITY": "A000",
        "IB_CRIT_ABILITY": "Azcr",
    }
    run([sys.executable, str(HERE / "collect_items.py"), str(stage)], env=env)
    run([sys.executable, str(HERE / "collect_map_items.py"), str(stage)], env=env)
    run([sys.executable, str(HERE / "collect_skills.py"), str(stage)], env=env)
    run([sys.executable, str(HERE / "gen_slk_tables.py"), str(stage)], env=env)

    unit_table = work / "_unitids.txt"
    bundled_units = HERE / "_unitids.txt"
    if not bundled_units.is_file():
        raise SystemExit("missing bundled unit table: %s" % bundled_units)
    shutil.copy2(bundled_units, unit_table)
    run([sys.executable, str(HERE / "build_fj.py")], env=env)


def verify_output(
    source: Path, output: Path, object_names: tuple[str, ...]
) -> None:
    source_archive = W.MPQArchive(str(source))
    output_archive = W.MPQArchive(str(output))
    try:
        script = (output_archive.read_file("war3map.j") or b"").decode(
            "utf-8", "replace"
        )
        required = (
            "function IB_Init takes nothing returns nothing",
            "function IB_AddItem takes ",
            "TimerStart(CreateTimer(), 0.0, false, function IB_Init)",
            'call TriggerRegisterPlayerChatEvent',
        )
        for token in required:
            if token not in script:
                raise SystemExit("missing item-browser token: %r" % token)
        for token in ("function WGL_Init", "function FR_Init", "'A111'"):
            if token in script:
                raise SystemExit("unexpected old equipment token: %r" % token)
        for internal in object_names:
            before = source_archive.read_file(internal)
            after = output_archive.read_file(internal)
            if before != after:
                raise SystemExit("object data changed unexpectedly: " + internal)
    finally:
        source_archive.close()
        output_archive.close()


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
    browser_dir = work / "item-browser"
    build_browser(source, work, browser_dir)

    output.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(source, output)
    PW.check_script_clash(str(source), [str(browser_dir)])
    run(
        [
            sys.executable,
            str(HERE / "inject_native.py"),
            str(output),
            "--script",
            str(browser_dir),
            "--no-backup",
        ]
    )
    verify_output(
        source,
        output,
        (
            "war3map.w3a",
            "war3map.w3t",
            "war3map.w3u",
            "war3map.w3h",
        ),
    )
    print("output:", output)
    print("size:", output.stat().st_size)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
