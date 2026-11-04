#!/usr/bin/env python3
"""Repair malformed sized-text lengths in extracted Forsaken campaign chapters.

The Reforged ``war3map.wct`` format uses a four-byte length that includes the
terminating NUL.  The current campaign has six chapters where the TS 01 Config
text length is one byte too large.  That causes the next length prefix to be
swallowed as part of the text and makes the World Editor/trigger parser report
``bad text``.

The repair only changes the affected four-byte length fields.  It does not
shift, remove, or rewrite trigger text.
"""

from __future__ import annotations

import argparse
import shutil
import struct
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
INJECTOR = ROOT / "tools" / "war3map-injector"
DOCTOR = ROOT / "tools" / "_devos-map-doctor" / "devos-map-doctor-main"
sys.path.insert(0, str(INJECTOR))
sys.path.insert(0, str(DOCTOR))

import mpq_patch  # noqa: E402
import war3mpq as W  # noqa: E402
from doctor.triggers import wtg  # noqa: E402


WCT_VERSION = 0x80000004


def _u32(data: bytes, offset: int) -> int:
    return struct.unpack_from("<I", data, offset)[0]


def repair_wct(data: bytes, label: str) -> tuple[bytes, list[tuple[int, int, int]]]:
    if len(data) < 12 or _u32(data, 0) != WCT_VERSION or _u32(data, 4) != 1:
        raise ValueError(f"{label}: unsupported WCT header")

    output = bytearray(data)
    repairs: list[tuple[int, int, int]] = []

    # Version-1 header: C string comment followed by one sized script header.
    comment_end = output.find(b"\0", 8)
    if comment_end < 0:
        raise ValueError(f"{label}: unterminated WCT comment")
    pos = comment_end + 1
    if pos + 4 > len(output):
        raise ValueError(f"{label}: missing script-header length")
    header_size = _u32(output, pos)
    pos += 4
    if header_size > len(output) - pos:
        raise ValueError(f"{label}: script header exceeds archive")
    if header_size and output[pos + header_size - 1] != 0:
        raise ValueError(f"{label}: script header lacks NUL")
    pos += header_size

    # Version 0x80000004 stores one sized text per non-comment trigger with no
    # final count.  A zero length is a valid empty text.
    while pos < len(output):
        field_offset = pos
        declared = _u32(output, field_offset)
        pos += 4
        if declared > len(output) - pos:
            raise ValueError(
                f"{label}: text at {field_offset:#x} exceeds archive"
            )
        if declared and output[pos + declared - 1] != 0:
            corrected = declared - 1
            if corrected <= 0 or output[pos + corrected - 1] != 0:
                raise ValueError(
                    f"{label}: text at {field_offset:#x} is not NUL-terminated"
                )
            struct.pack_into("<I", output, field_offset, corrected)
            repairs.append((field_offset, declared, corrected))
            declared = corrected
        pos += declared

    if pos != len(output):
        raise ValueError(f"{label}: WCT did not consume the final byte")

    try:
        text = wtg.read_wct(bytes(output))
    except Exception as exc:
        raise ValueError(f"{label}: WCT still does not parse: {exc}") from exc
    if text.version != 1 or not text.is_new_format:
        raise ValueError(f"{label}: unexpected WCT layout after repair")
    return bytes(output), repairs


def validate_pair(archive: W.MPQArchive, label: str) -> int:
    text_data = archive.read_file("war3map.wct")
    trigger_data = archive.read_file("war3map.wtg")
    if not text_data or not trigger_data:
        raise ValueError(f"{label}: missing WCT/WTG")
    custom_text = wtg.read_wct(text_data)
    trigger_data_obj, _ = wtg.load_td(None)
    map_triggers = wtg.read_wtg(trigger_data, trigger_data_obj)
    texts = wtg.trigger_texts(map_triggers, custom_text)
    return len(texts)


def patch_map(path: Path) -> list[tuple[int, int, int]]:
    archive = W.MPQArchive(str(path))
    try:
        data = archive.read_file("war3map.wct")
    finally:
        archive.close()
    if not data:
        raise ValueError(f"{path.name}: missing war3map.wct")

    updated, repairs = repair_wct(data, path.name)
    if not repairs:
        archive = W.MPQArchive(str(path))
        try:
            validate_pair(archive, path.name)
        finally:
            archive.close()
        return []

    temp = path.with_suffix(".wct-fixed.w3x")
    temp.unlink(missing_ok=True)
    try:
        mpq_patch.patch(
            str(path),
            [("war3map.wct", updated)],
            out_path=str(temp),
            backup=False,
        )
        check = W.MPQArchive(str(temp))
        try:
            if check.read_file("war3map.wct") != updated:
                raise ValueError(f"{path.name}: WCT read-back mismatch")
            count = validate_pair(check, path.name)
        finally:
            check.close()
        shutil.move(str(temp), str(path))
        print(f"{path.name}: {len(repairs)} length repair(s), {count} texts")
    finally:
        temp.unlink(missing_ok=True)
    return repairs


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--work", required=True, type=Path)
    args = parser.parse_args()

    base = args.work.resolve() / "base"
    if not base.is_dir():
        raise SystemExit(f"missing extracted base directory: {base}")

    patched = {}
    for path in sorted(base.glob("*.w3x")):
        repairs = patch_map(path)
        if repairs:
            patched[path.name] = repairs

    expected = {
        "UndeadRE02.w3x",
        "UndeadRE02_01.w3x",
        "UndeadRE02_02.w3x",
        "UndeadRE02_03.w3x",
        "UndeadRE02_04.w3x",
        "UndeadRE02_06.w3x",
    }
    if patched and set(patched) != expected:
        raise SystemExit(
            "unexpected repaired chapter set: "
            + ", ".join(sorted(patched))
        )
    for name, repairs in patched.items():
        if len(repairs) != 1:
            raise SystemExit(f"{name}: expected one WCT length repair")
        if repairs[0][1] - repairs[0][2] != 1:
            raise SystemExit(f"{name}: WCT repair was not a one-byte correction")

    if patched:
        print("WCT repair complete:", ", ".join(sorted(patched)))
    else:
        print("WCT files already valid; no repair needed")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
