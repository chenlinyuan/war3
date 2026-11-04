from __future__ import annotations

import sys
from pathlib import Path


HERE = Path(__file__).resolve().parent
DOCTOR = HERE.parent / "_devos-map-doctor" / "devos-map-doctor-main"
sys.path.insert(0, str(DOCTOR))

from doctor.data import objects as O  # noqa: E402


ARTIFACT_AND_WING_IDS = (
    "I100", "I101", "I102", "I103", "I104", "I105", "I106",
)
TELEPORT_ABILITY_ID = "W023"
TELEPORT_BASE_ABILITY = "AHmt"
TELEPORT_COOLDOWN = 15.0


def _replace_mods(mods, updates):
    keys = {(field, level, column) for field, _kind, level, column, _value in updates}
    kept = [
        mod for mod in mods
        if (mod[0], mod[2], mod[3]) not in keys
    ]
    kept.extend(updates)
    return kept


def _upsert(entries, old_id, new_id, updates, force_base=False):
    found = None
    output = []
    for entry in entries:
        if entry[2].strip("\0") == new_id and found is None:
            found = entry
            output.append(
                (
                    entry[0],
                    old_id if force_base else entry[1],
                    entry[2],
                    _replace_mods(entry[3], updates),
                )
            )
        else:
            output.append(entry)
    if found is None:
        output.append((1, old_id, new_id, list(updates)))
    return output


def patch_item_bytes(data: bytes, label: str = "war3map.w3t") -> bytes:
    version, entries, consumed = O.read_objects_bytes(
        data, False, fname=label, with_end=True
    )
    if consumed != len(data):
        raise ValueError(label + ": trailing object-data bytes")

    non_sellable = [
        ("ipaw", 0, 0, 0, 0),
        ("isel", 0, 0, 0, 0),
        ("igol", 0, 0, 0, 0),
    ]
    for ident in ARTIFACT_AND_WING_IDS:
        entries = _upsert(entries, ident, ident, non_sellable)

    return O.write_objects_bytes(version, entries, False)


def patch_ability_bytes(data: bytes, label: str = "war3map.w3a") -> bytes:
    version, entries, consumed = O.read_objects_bytes(
        data, True, fname=label, with_end=True
    )
    if consumed != len(data):
        raise ValueError(label + ": trailing object-data bytes")

    entries = _upsert(
        entries, TELEPORT_BASE_ABILITY, TELEPORT_ABILITY_ID,
        [
            (
                "anam", 3, 0, 0,
                "群体传送".encode("utf-8"),
            ),
            ("alev", 0, 0, 0, 1),
            ("aher", 0, 0, 0, 0),
            ("aite", 0, 0, 0, 1),
            ("acdn", 2, 1, 0, TELEPORT_COOLDOWN),
            ("amcs", 0, 1, 0, 0),
            ("aare", 2, 1, 0, 700.0),
            ("aran", 2, 1, 0, 99999.0),
            (
                "atar", 3, 1, 0,
                b"friend,vulnerable,ground,structure,invulnerable,nonsapper",
            ),
            ("Hmt1", 0, 1, 1, 24),
            ("Hmt2", 2, 1, 2, 0.2),
            ("Hmt3", 0, 1, 3, 1),
            (
                "atp1", 3, 1, 0,
                "群体传送(|cffffcc00T|r)".encode("utf-8"),
            ),
            (
                "aub1", 3, 1, 0,
                (
                    "将自身与周围 700 范围内的最多 24 个友军单位"
                    "传送到目标友军单位或建筑旁。|n冷却 15 秒，不消耗魔法。"
                ).encode("utf-8"),
            ),
        ],
        force_base=True,
    )
    return O.write_objects_bytes(version, entries, True)


def patch_file(path: Path, extension: str) -> None:
    if not path.is_file():
        return
    data = path.read_bytes()
    updated = (
        patch_item_bytes(data, path.name)
        if extension == "w3t"
        else patch_ability_bytes(data, path.name)
    )
    path.write_bytes(updated)


def patch_object_tree(root: Path) -> None:
    root = Path(root)
    for extension in ("w3t", "w3a"):
        patch_file(root / ("war3campaign." + extension), extension)
        patch_file(root / ("war3map." + extension), extension)
    for chapter in root.iterdir():
        if chapter.suffix.lower() not in (".w3x", ".w3m"):
            continue
        # Chapter archives are patched by their callers after extraction.
    for directory in root.rglob("*"):
        if not directory.is_dir():
            continue
        for extension in ("w3t", "w3a"):
            patch_file(directory / ("war3map." + extension), extension)


def validate_item_bytes(data: bytes) -> None:
    _version, entries, _consumed = O.read_objects_bytes(
        data, False, fname="validate.w3t", with_end=True
    )
    by_id = {entry[2].strip("\0"): entry for entry in entries}
    for ident in ARTIFACT_AND_WING_IDS:
        fields = {mod[0]: mod[4] for mod in by_id[ident][3]}
        if fields.get("ipaw") != 0 or fields.get("isel") != 0:
            raise ValueError(ident + " is still sellable")
        if fields.get("igol") != 0:
            raise ValueError(ident + " still has a gold value")
def validate_ability_bytes(data: bytes) -> None:
    _version, entries, _consumed = O.read_objects_bytes(
        data, True, fname="validate.w3a", with_end=True
    )
    entry = next(
        entry for entry in entries
        if entry[2].strip("\0") == TELEPORT_ABILITY_ID
    )
    if entry[1].strip("\0") != TELEPORT_BASE_ABILITY:
        raise ValueError("W023 is not based on AHmt")
    fields = {mod[0]: mod[4] for mod in entry[3]}
    if abs(float(fields["acdn"]) - TELEPORT_COOLDOWN) > 0.0001:
        raise ValueError("W023 cooldown mismatch")
    if int(fields["amcs"]) != 0:
        raise ValueError("W023 still costs mana")
    if fields["atar"] != (
        b"friend,vulnerable,ground,structure,invulnerable,nonsapper"
    ):
        raise ValueError("W023 target type mismatch")
    if int(fields["Hmt1"]) != 24:
        raise ValueError("W023 unit cap mismatch")
    if abs(float(fields["Hmt2"]) - 0.2) > 0.0001:
        raise ValueError("W023 delay mismatch")
    if int(fields["Hmt3"]) != 1:
        raise ValueError("W023 grouping flag mismatch")
    charge = next(
        (
            entry for entry in entries
            if entry[2].strip("\0") == "A113"
        ),
        None,
    )
    if charge is not None:
        charge_fields = {mod[0]: mod[4] for mod in charge[3]}
        if charge_fields.get("ahky") != b"C":
            raise ValueError("A113 hotkey is not C")
    if any(entry[2].strip("\0") == "A112" for entry in entries):
        raise ValueError("obsolete corruption orb A112 remains")
    if any(entry[2].strip("\0") == "A119" for entry in entries):
        raise ValueError("obsolete native growth ability A119 remains")
