# -*- coding: utf-8 -*-
"""Remove authored backpack-switch abilities from scripts and object data."""
from __future__ import annotations

import re
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
DOCTOR = ROOT / "tools" / "_devos-map-doctor" / "devos-map-doctor-main"

try:
    from doctor.data import objects as OBJ
except ModuleNotFoundError:
    import sys

    sys.path.insert(0, str(DOCTOR))
    from doctor.data import objects as OBJ


LEVEL_EXTENSIONS = frozenset(("w3a", "w3d", "w3q"))


def _ability_patterns(ability_ids: set[str]) -> list[tuple[str, re.Pattern[str]]]:
    patterns = []
    for ability_id in sorted(ability_ids):
        quoted = re.escape(ability_id)
        patterns.append(
            (
                ability_id,
                re.compile(
                    r"(?i)(GetSpellAbilityId\(\s*\)\s*==\s*'"
                    + quoted
                    + r"')"
                ),
            )
        )
    return patterns


def patch_script(
    text: str,
    ability_ids: set[str],
) -> tuple[str, list[dict[str, object]]]:
    """Disable grants and spell-id conditions for the declared abilities."""
    records: list[dict[str, object]] = []
    output = text
    for ability_id in sorted(ability_ids):
        quoted = re.escape(ability_id)
        call_pattern = re.compile(
            r"(?m)^(?P<indent>[ \t]*)call[ \t]+"
            r"(?:UnitMakeAbilityPermanent|SetPlayerAbilityAvailable|"
            r"UnitAddAbilityBJ|UnitRemoveAbilityBJ|"
            r"UnitAddAbility|UnitRemoveAbility)"
            r"\([^\r\n]*'" + quoted + r"'[^\r\n]*\)"
            r"[ \t]*(?://[^\r\n]*)?(?P<eol>\r\n|\n|\r|$)"
        )

        def patch_call(match: re.Match[str]) -> str:
            records.append(
                {
                    "rule": "backpack-switch-script-call",
                    "ability": ability_id,
                }
            )
            return (
                match.group("indent")
                + "call DoNothing() // IB: backpack switch ability removed"
                + (match.group("eol") or "\n")
            )

        output = call_pattern.sub(patch_call, output)
        condition_pattern = re.compile(
            r"GetSpellAbilityId\(\s*\)\s*==\s*'" + quoted + r"'",
            re.I,
        )
        output, condition_count = condition_pattern.subn(
            "false",
            output,
        )
        if condition_count:
            records.append(
                {
                    "rule": "backpack-switch-trigger-condition",
                    "ability": ability_id,
                    "count": condition_count,
                }
            )
    return output, records


def verify_script(text: str, ability_ids: set[str]) -> list[str]:
    problems: list[str] = []
    for ability_id in sorted(ability_ids):
        quoted = re.escape(ability_id)
        if re.search(
            r"(?:UnitMakeAbilityPermanent|SetPlayerAbilityAvailable|"
            r"UnitAddAbilityBJ|UnitRemoveAbilityBJ|"
            r"UnitAddAbility|UnitRemoveAbility)"
            r"\([^\r\n]*'" + quoted + r"'",
            text,
            re.I,
        ):
            problems.append("grant:" + ability_id)
        if re.search(
            r"GetSpellAbilityId\(\s*\)\s*==\s*'" + quoted + r"'",
            text,
            re.I,
        ):
            problems.append("condition:" + ability_id)
    return problems


def patch_objects(
    data: bytes,
    extension: str,
    ability_ids: set[str],
) -> tuple[bytes, dict[str, object]]:
    """Remove switch entries and exact ability IDs from object string lists."""
    extension = extension.lower().lstrip(".")
    with_levels = extension in LEVEL_EXTENSIONS
    version, entries, consumed = OBJ.read_objects_bytes(
        data,
        with_levels,
        fname="war3map." + extension,
        with_end=True,
    )
    objects = []
    removed_objects = 0
    removed_tokens = 0
    touched_fields: list[str] = []
    for table, original, new, mods in entries:
        object_id = new.replace("\0", "") or original.replace("\0", "")
        if object_id in ability_ids:
            removed_objects += 1
            continue
        changed = False
        new_mods = OBJ.Mods()
        for mod in mods:
            updated = tuple(mod)
            if updated[1] == 3 and isinstance(updated[4], (bytes, bytearray)):
                values = bytes(updated[4]).split(b",")
                kept = [
                    token
                    for token in values
                    if token.decode("latin-1") not in ability_ids
                ]
                if len(kept) != len(values):
                    updated = updated[:4] + (b",".join(kept),) + updated[5:]
                    removed_tokens += len(values) - len(kept)
                    touched_fields.append(updated[0])
                    changed = True
            new_mods.append(updated)
        if changed:
            new_mods = OBJ.with_item_sets(new_mods, mods)
        objects.append((table, original, new, new_mods))
    if removed_objects or removed_tokens:
        output = OBJ.write_objects_bytes(version, objects, with_levels)
        if consumed != len(data) and data[consumed:].strip(b"\0"):
            output += data[consumed:]
    else:
        output = data
    return output, {
        "rule": "backpack-switch-objects",
        "extension": extension,
        "ability_ids": sorted(ability_ids),
        "removed_objects": removed_objects,
        "removed_tokens": removed_tokens,
        "fields": sorted(set(touched_fields)),
    }


def verify_objects(
    data: bytes,
    extension: str,
    ability_ids: set[str],
) -> list[str]:
    extension = extension.lower().lstrip(".")
    version, entries, _consumed = OBJ.read_objects_bytes(
        data,
        extension in LEVEL_EXTENSIONS,
        fname="war3map." + extension,
        with_end=True,
    )
    del version
    problems: list[str] = []
    for _table, original, new, mods in entries:
        object_id = new.replace("\0", "") or original.replace("\0", "")
        if object_id in ability_ids:
            problems.append("object:" + object_id)
        for mod in mods:
            if mod[1] != 3 or not isinstance(mod[4], (bytes, bytearray)):
                continue
            for token in bytes(mod[4]).split(b","):
                ability_id = token.decode("latin-1")
                if ability_id in ability_ids:
                    problems.append(
                        "field:%s:%s:%s"
                        % (object_id, mod[0], ability_id)
                    )
    return problems
