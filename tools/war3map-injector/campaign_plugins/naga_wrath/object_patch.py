# -*- coding: utf-8 -*-
"""Object-data repairs specific to Naga Wrath."""
from __future__ import annotations

import sys
from pathlib import Path

from .chapter_rules import (
    ARTIFACT_CHARGE_FIELD,
    ARTIFACT_CHARGE_VALUE,
    ARTIFACT_ITEM_IDS,
)


ROOT = Path(__file__).resolve().parents[4]
DOCTOR = ROOT / "tools" / "_devos-map-doctor" / "devos-map-doctor-main"
if str(DOCTOR) not in sys.path:
    sys.path.insert(0, str(DOCTOR))

from doctor.data import objects as OBJ  # noqa: E402


ZERO_END = b"\0\0\0\0"


def _set_permanent_charges(mods: object) -> tuple[object, bool]:
    output = OBJ.Mods()
    changed = False
    found = False
    for mod in mods:
        updated = tuple(mod)
        if updated[0] == ARTIFACT_CHARGE_FIELD:
            found = True
            if updated[4] != ARTIFACT_CHARGE_VALUE:
                updated = (
                    updated[:4] + (ARTIFACT_CHARGE_VALUE,) + updated[5:]
                )
                changed = True
        output.append(updated)
    if not found:
        output.append(
            (
                ARTIFACT_CHARGE_FIELD,
                0,
                0,
                0,
                ARTIFACT_CHARGE_VALUE,
                ZERO_END,
            )
        )
        changed = True
    output = OBJ.with_item_sets(output, mods)
    return output, changed


def patch_objects(
    data: bytes,
    extension: str,
    chapter: str,
) -> tuple[bytes, list[dict[str, object]]]:
    if extension.lower().lstrip(".") != "w3t":
        return data, []
    version, entries, consumed = OBJ.read_objects_bytes(
        data,
        False,
        fname="war3map.w3t",
        with_end=True,
    )
    records: list[dict[str, object]] = []
    objects = []
    for table, original, new, mods in entries:
        object_id = new.replace("\0", "") or original.replace("\0", "")
        if object_id not in ARTIFACT_ITEM_IDS:
            objects.append((table, original, new, mods))
            continue
        updated, changed = _set_permanent_charges(mods)
        objects.append((table, original, new, updated))
        if changed:
            records.append(
                {
                    "rule": "naga-permanent-artifact-charges",
                    "chapter": chapter,
                    "item": object_id,
                    "field": ARTIFACT_CHARGE_FIELD,
                    "value": ARTIFACT_CHARGE_VALUE,
                }
            )
    output = OBJ.write_objects_bytes(version, objects, False)
    if consumed != len(data) and data[consumed:].strip(b"\0"):
        output += data[consumed:]
    return output, records


def verify_objects(
    data: bytes,
    extension: str,
    chapter: str,
    stats: list[dict[str, object]],
) -> list[str]:
    del chapter, stats
    if extension.lower().lstrip(".") != "w3t":
        return []
    _version, entries, _consumed = OBJ.read_objects_bytes(
        data,
        False,
        fname="war3map.w3t",
        with_end=True,
    )
    problems: list[str] = []
    for _table, original, new, mods in entries:
        object_id = new.replace("\0", "") or original.replace("\0", "")
        if object_id not in ARTIFACT_ITEM_IDS:
            continue
        values = [
            mod[4]
            for mod in mods
            if mod[0] == ARTIFACT_CHARGE_FIELD
        ]
        if values != [ARTIFACT_CHARGE_VALUE]:
            problems.append(object_id + ":" + repr(values))
    return problems
