#!/usr/bin/env python3
"""Losslessly compact a campaign's chapter archives and outer MPQ."""

from __future__ import annotations

import argparse
import shutil
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
INJECTOR = ROOT / "tools" / "war3map-injector"
DOCTOR = ROOT / "tools" / "_devos-map-doctor" / "devos-map-doctor-main"
sys.path.insert(0, str(INJECTOR))
sys.path.insert(0, str(DOCTOR))

import mpq_patch  # noqa: E402
import war3mpq as W  # noqa: E402
import fix_alas_campaign_names as CAMPAIGN_NAMES  # noqa: E402
from doctor.fix import shrink  # noqa: E402
from doctor.mpq import mpqread  # noqa: E402
from doctor.triggers import wtg  # noqa: E402


def read_w3f_title(archive: W.MPQArchive) -> str:
    data = archive.read_file("war3campaign.w3f") or b""
    end = data.find(b"\0", 12)
    if end < 0:
        raise RuntimeError("war3campaign.w3f has no valid title")
    return data[12:end].decode("utf-8")


def verify_chapter_contents(source: Path, compact: Path) -> None:
    old_names_archive = W.MPQArchive(str(source))
    new_names_archive = W.MPQArchive(str(compact))
    try:
        old_names = sorted(old_names_archive.listfile)
        new_names = sorted(new_names_archive.listfile)
        if old_names != new_names:
            raise RuntimeError(
                f"{source.name}: entry list changed during compaction"
            )
    finally:
        old_names_archive.close()
        new_names_archive.close()

    # Chapter entries can be encrypted. Use the same reader as the map doctor,
    # which derives the sector key from the entry name correctly.
    old = mpqread.Archive(str(source))
    new = mpqread.Archive(str(compact))
    for name in old_names:
        if old.read(name) != new.read(name):
            raise RuntimeError(
                f"{source.name}: {name} changed during compaction"
            )


def verify_wct(path: Path) -> None:
    archive = W.MPQArchive(str(path))
    try:
        wct_data = archive.read_file("war3map.wct")
        wtg_data = archive.read_file("war3map.wtg")
        if not wct_data and not wtg_data:
            return
        if not wct_data or not wtg_data:
            raise RuntimeError(f"{path.name}: incomplete WCT/WTG pair")
        custom_text = wtg.read_wct(wct_data)
        trigger_data, _ = wtg.load_td(None)
        map_triggers = wtg.read_wtg(wtg_data, trigger_data)
        wtg.trigger_texts(map_triggers, custom_text)
    except wtg.UnknownFunction as exc:
        print(
            f"{path.name}: WCT/WTG verification skipped, "
            f"unknown trigger function: {exc}",
            flush=True,
        )
    finally:
        archive.close()


def preserve_source_bytes(
    source: Path,
    destination: Path,
    reason: str,
) -> dict[str, object]:
    destination.unlink(missing_ok=True)
    shutil.copy2(source, destination)
    verify_chapter_contents(source, destination)
    verify_wct(destination)
    print(
        f"{source.name}: compaction skipped, preserving source bytes: "
        f"{reason}",
        flush=True,
    )
    return {
        "state": "fallback",
        "error": reason,
        "size_before": source.stat().st_size,
        "size_after": destination.stat().st_size,
    }


def compact_chapter(source: Path, destination: Path) -> dict[str, object]:
    destination.unlink(missing_ok=True)
    try:
        result = shrink.shrink(
            str(source),
            str(destination),
            {
                "recompress": True,
                "blp": False,
                "dedup": True,
            },
        )
    except Exception as exc:  # noqa: BLE001
        result = {
            "state": "failed",
            "error": f"{type(exc).__name__}: {exc}",
        }
    if result.get("state") == "nothing_to_do":
        shutil.copy2(source, destination)
    elif result.get("state") != "done":
        reason = result.get("error", "unknown compaction error")
        return preserve_source_bytes(
            source,
            destination,
            str(reason),
        )
    try:
        verify_chapter_contents(source, destination)
        verify_wct(destination)
    except Exception as exc:  # noqa: BLE001
        return preserve_source_bytes(
            source,
            destination,
            "verification failed: %s: %s"
            % (type(exc).__name__, exc),
        )
    return result


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--campaign", required=True, type=Path)
    parser.add_argument("--work", required=True, type=Path)
    parser.add_argument("--output", required=True, type=Path)
    args = parser.parse_args()

    source = args.campaign.resolve()
    work = args.work.resolve()
    output = args.output.resolve()
    if output == source:
        raise SystemExit("output must differ from source")
    if not source.is_file():
        raise SystemExit(f"campaign not found: {source}")

    compact_dir = work / "_compact_chapters"
    suffix = 1
    while compact_dir.exists():
        suffix += 1
        compact_dir = work / f"_compact_chapters_{suffix}"
    compact_dir.mkdir(parents=True)

    outer = W.MPQArchive(str(source))
    try:
        title = read_w3f_title(outer)
        chapters = sorted(
            name for name in outer.listfile
            if name.lower().endswith((".w3x", ".w3m"))
        )
        source_data = {name: outer.read_file(name) for name in chapters}
    finally:
        outer.close()
    if not chapters:
        raise SystemExit("campaign has no chapter maps")

    compacted: list[tuple[str, Path, dict[str, object]]] = []
    total_before = 0
    total_after = 0
    for name in chapters:
        source_chapter = compact_dir / ("source-" + name)
        source_chapter.write_bytes(source_data[name])
        compact_chapter_path = compact_dir / name
        report = compact_chapter(source_chapter, compact_chapter_path)
        before = int(report["size_before"])
        after = int(report["size_after"])
        total_before += before
        total_after += after
        compacted.append((name, compact_chapter_path, report))
        print(f"{name}: {before} -> {after}", flush=True)

    output.parent.mkdir(parents=True, exist_ok=True)
    output.unlink(missing_ok=True)
    mpq_patch.patch(
        str(source),
        [(name, path.read_bytes()) for name, path, _report in compacted],
        out_path=str(output),
        backup=False,
        store=chapters,
        compact=True,
    )

    desired_title = (
        CAMPAIGN_NAMES.desired_title(output)
        if output.stem.lower().startswith("alas")
        else title
    )
    title_archive = W.MPQArchive(str(output))
    try:
        old_w3f = title_archive.read_file("war3campaign.w3f") or b""
    finally:
        title_archive.close()
    CAMPAIGN_NAMES.patch_with_mpq(
        output,
        CAMPAIGN_NAMES.make_w3f(old_w3f, desired_title),
        work / "title_backup",
    )

    check = W.MPQArchive(str(output))
    try:
        if read_w3f_title(check) != desired_title:
            raise RuntimeError("campaign title changed during compaction")
        output_names = {
            name for name in check.listfile
            if name.lower().endswith((".w3x", ".w3m"))
        }
        if output_names != set(chapters):
            raise RuntimeError("campaign chapter list changed")
        for name, path, _report in compacted:
            if check.read_file(name) != path.read_bytes():
                raise RuntimeError(f"{name}: outer read-back mismatch")
        nonchapter = [
            name for name in check.listfile
            if name not in output_names
            and name.lower() != "war3campaign.w3f"
        ]
        source_outer = W.MPQArchive(str(source))
        try:
            for name in nonchapter:
                if check.read_file(name) != source_outer.read_file(name):
                    raise RuntimeError(
                        f"{name}: non-chapter campaign entry changed"
                    )
        finally:
            source_outer.close()
    finally:
        check.close()

    print(
        "chapter payload: "
        f"{total_before} -> {total_after}; "
        f"campaign: {source.stat().st_size} -> {output.stat().st_size}"
    )
    if output.stat().st_size >= source.stat().st_size:
        print("no net campaign size reduction")
    print("source title:", title)
    print("output title:", desired_title)
    print("output:", output)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
