from __future__ import annotations

import argparse
import json
import re
import sys
import tempfile
from pathlib import Path


APP_DIR = Path(__file__).resolve().parent
ROOT = APP_DIR.parents[1]
INJECTOR = ROOT / "tools" / "war3map-injector"
sys.path.insert(0, str(INJECTOR))

import mpq_patch as MPQ  # noqa: E402
import war3mpq as W  # noqa: E402


LEGACY_DECLARATIONS = (
    b"GetHandleId",
    b"GetSpellTargetX",
    b"GetSpellTargetY",
)


def remove_unused_legacy_functions(script: bytes) -> tuple[bytes, list[str], list[str]]:
    removed: list[str] = []
    skipped: list[str] = []
    for name in LEGACY_DECLARATIONS:
        count = len(re.findall(rb"\b" + re.escape(name) + rb"\b", script))
        if count == 0:
            continue
        if count != 1:
            skipped.append(name.decode("ascii") + " (referenced)")
            continue
        pattern = re.compile(
            rb"(?ims)^function\s+" + re.escape(name)
            + rb"\s+takes.*?^endfunction[ \t]*(?=\r?\n|\Z)"
        )
        script, replacements = pattern.subn(b"", script)
        if replacements == 1:
            removed.append(name.decode("ascii"))
        else:
            skipped.append(name.decode("ascii") + " (declaration not matched)")
    return script, removed, skipped


def unlink_quiet(path: Path) -> None:
    try:
        path.unlink(missing_ok=True)
    except OSError:
        pass


def prepare(source: Path, work: Path, output: Path, report_path: Path) -> Path:
    work.mkdir(parents=True, exist_ok=True)
    source_kind = (
        "campaign" if source.suffix.lower() == ".w3n" else "map"
    )
    if source_kind == "map":
        archive = W.MPQArchive(str(source))
        try:
            script_internal = next(
                (
                    internal for internal in (
                        "war3map.lua",
                        "scripts\\war3map.lua",
                        "Scripts\\war3map.lua",
                        "war3map.j",
                        "scripts\\war3map.j",
                        "Scripts\\war3map.j",
                    )
                    if archive.read_file(internal)
                ),
                "war3map.j",
            )
            script = archive.read_file(script_internal) or b""
        finally:
            archive.close()
        if not script:
            raise RuntimeError(
                "map has no war3map.j or war3map.lua: " + str(source)
            )
        if script_internal.lower().endswith(".lua"):
            updated, removed, skipped = script, [], []
        else:
            updated, removed, skipped = remove_unused_legacy_functions(
                script
            )
        chosen = source
        if removed:
            MPQ.patch(
                str(source),
                [(script_internal, updated)],
                out_path=str(output),
                backup=False,
            )
            verify = W.MPQArchive(str(output))
            try:
                if verify.read_file(script_internal) != updated:
                    raise RuntimeError("compat map read-back mismatch")
            finally:
                verify.close()
            chosen = output
        report = {
            "source": str(source),
            "source_kind": source_kind,
            "output": str(chosen),
            "changed": bool(removed),
            "details": [{
                "map": source.name,
                "script_internal": script_internal,
                "removed": removed,
                "skipped": skipped,
            }],
        }
        report_path.parent.mkdir(parents=True, exist_ok=True)
        report_path.write_text(
            json.dumps(report, ensure_ascii=False, indent=2),
            encoding="utf-8",
        )
        print(json.dumps(report, ensure_ascii=False, indent=2))
        return chosen

    outer = W.MPQArchive(str(source))
    chapters = sorted(
        name for name in outer.listfile
        if name.lower().endswith((".w3x", ".w3m"))
    )
    chapter_data = {name: outer.read_file(name) for name in chapters}
    outer.close()

    chapter_patches: list[tuple[str, bytes]] = []
    details: list[dict[str, object]] = []
    for name, data in chapter_data.items():
        if not data:
            continue
        fd, temp_name = tempfile.mkstemp(suffix=Path(name).suffix)
        temp = Path(temp_name)
        try:
            temp.write_bytes(data)
            chapter = W.MPQArchive(str(temp))
            try:
                script = chapter.read_file("war3map.j") or b""
            finally:
                chapter.close()
        finally:
            unlink_quiet(temp)
        if not script:
            continue
        updated, removed, skipped = remove_unused_legacy_functions(script)
        if not removed and not skipped:
            continue
        detail = {
            "chapter": name,
            "removed": removed,
            "skipped": skipped,
        }
        details.append(detail)
        if not removed:
            continue
        chapter_source = work / name
        chapter_source.write_bytes(data)
        chapter_output = work / ("compat-" + name)
        MPQ.patch(
            str(chapter_source),
            [("war3map.j", updated)],
            out_path=str(chapter_output),
            backup=False,
        )
        verify = W.MPQArchive(str(chapter_output))
        try:
            if verify.read_file("war3map.j") != updated:
                raise RuntimeError("compat chapter read-back mismatch: " + name)
            chapter_patches.append((name, chapter_output.read_bytes()))
        finally:
            verify.close()

    chosen = source
    if chapter_patches:
        MPQ.patch(
            str(source),
            chapter_patches,
            out_path=str(output),
            backup=False,
            store=[name for name, _data in chapter_patches],
        )
        verify = W.MPQArchive(str(output))
        try:
            for name, data in chapter_patches:
                if verify.read_file(name) != data:
                    raise RuntimeError("compat campaign read-back mismatch: " + name)
        finally:
            verify.close()
        chosen = output

    report = {
        "source": str(source),
        "source_kind": source_kind,
        "output": str(chosen),
        "changed": bool(chapter_patches),
        "chapters": details,
    }
    report_path.parent.mkdir(parents=True, exist_ok=True)
    report_path.write_text(
        json.dumps(report, ensure_ascii=False, indent=2),
        encoding="utf-8",
    )
    print(json.dumps(report, ensure_ascii=False, indent=2))
    return chosen


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--source", type=Path, required=True)
    parser.add_argument("--work", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--report", type=Path, required=True)
    args = parser.parse_args()
    prepare(
        args.source.resolve(),
        args.work.resolve(),
        args.output.resolve(),
        args.report.resolve(),
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
