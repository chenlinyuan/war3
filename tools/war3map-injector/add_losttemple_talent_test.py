#!/usr/bin/env python3
"""Build a LostTempleLV talent-option capacity test for Reforged 3.0."""

from __future__ import annotations

import argparse
import os
import re
import shutil
import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
DOCTOR = (
    ROOT / "tools" / "_devos-map-doctor" / "devos-map-doctor-main"
)
sys.path.insert(0, str(HERE))
sys.path.insert(0, str(DOCTOR))

import objparse as O  # noqa: E402
import war3mpq as W  # noqa: E402
from doctor.data import objects as DOBJ  # noqa: E402

BACKPACK_ID = "B30B"
TALENT_ID = "T1AL"
OPENER_ID = "ATal"
TIER_COUNT = 7
CHOICES_PER_TIER = 3
CHOICE_START = 100
MARKER_ID = "T405"
TALENT_SCRIPT = ROOT / "scripts" / "talent-test"
INJECTOR = HERE / "inject_native.py"

DEFAULT_SOURCE = Path(
    r"C:\Users\Administrator\Desktop"
    r"\LostTempleLV_Clean_UniversalBackpack.w3x"
)
DEFAULT_OUTPUT = Path(
    ROOT / "maps" / "alasLostTempleLV_TalentTest.w3x"
)
DEFAULT_WORK = (
    ROOT / "maps" / "port" / "lost_temple_talent_test_v3"
)
DEFAULT_TITLE = "alasLostTempleLV_TalentTest"

ICON_STR = r"ReplaceableTextures\CommandButtons\BTNBelt.blp"
ICON_AGI = r"ReplaceableTextures\CommandButtons\BTNGlove.blp"
ICON_INT = r"ReplaceableTextures\CommandButtons\BTNTomeRed.blp"
ICON_TALENT = r"ReplaceableTextures\CommandButtons\BTNTomeRed.blp"


def mod(
    field_id: str,
    value: object,
    kind: int | None = None,
    *,
    level: int = 0,
    column: int = 0,
) -> tuple[str, int, int, int, object]:
    if kind is None:
        if isinstance(value, str):
            kind = O.T_STRING
        elif isinstance(value, float):
            kind = O.T_REAL
        else:
            kind = O.T_INT
    return field_id, kind, level, column, value


def choice_id(tier: int, choice: int) -> str:
    return "T%03d" % (
        CHOICE_START + tier * CHOICES_PER_TIER + choice
    )


def attribute_values(choice: int) -> tuple[int, int, int]:
    return (
        (1, 0, 0),
        (0, 1, 0),
        (0, 0, 1),
    )[choice]


def attribute_mods(
    strength: int,
    agility: int,
    intelligence: int,
) -> list[tuple[str, int, int, int, object]]:
    return [
        mod("Istr", strength, level=1, column=3),
        mod("Iagi", agility, level=1, column=1),
        mod("Iint", intelligence, level=1, column=2),
    ]


def attribute_entry(
    ident: str,
    name: str,
    icon: str,
    values: tuple[int, int, int],
) -> dict[str, object]:
    return {
        "old": "AIst",
        "new": ident,
        "mods": [
            mod("anam", name),
            mod("aart", icon),
            mod("arar", icon),
            mod("atp1", name, level=1),
            mod("aub1", name, level=1),
            mod("alev", 1),
            mod("aite", 1),
            mod("aher", 0),
            *attribute_mods(*values),
        ],
    }


def choice_entry(tier: int, choice: int) -> dict[str, object]:
    names = ("力量", "敏捷", "智力")
    icons = (ICON_STR, ICON_AGI, ICON_INT)
    ident = choice_id(tier, choice)
    label = "第%d层·%s+1" % (tier + 1, names[choice])
    tooltip = "%s永久 +1。" % names[choice]
    return {
        "old": "AIst",
        "new": ident,
        "mods": [
            mod("anam", label),
            mod("aart", icons[choice]),
            mod("arar", icons[choice]),
            mod("atp1", label, level=1),
            mod("aub1", tooltip, level=1),
            mod("alev", 1),
            mod("aite", 1),
            mod("aher", 0),
            *attribute_mods(*attribute_values(choice)),
        ],
    }


def talent_entry(master_id: str) -> dict[str, object]:
    mods = [
        mod("anam", "通用天赋测试"),
        mod("aart", ICON_TALENT),
        mod("arar", ICON_TALENT),
        mod("atp1", "通用天赋", level=1),
        mod(
            "aub1",
            "每层从三项属性天赋中选择一项。",
            level=1,
        ),
        mod("alev", TIER_COUNT),
        mod("aite", 0),
        mod("aher", 0),
        mod("abpx", 0),
        mod("abpy", -11),
    ]
    for tier in range(TIER_COUNT):
        ids = ",".join(
            choice_id(tier, choice)
            for choice in range(CHOICES_PER_TIER)
        )
        mods.append(mod("aabi", ids, level=tier + 1))
    return {
        "old": OPENER_ID,
        "new": master_id,
        "mods": mods,
    }


def read_archive_file(path: Path, internal: str) -> bytes:
    archive = W.MPQArchive(str(path))
    try:
        data = archive.read_file(internal)
    finally:
        archive.close()
    if data is None:
        raise SystemExit("missing map file: " + internal)
    return data


def build_item_data(source: Path) -> bytes:
    version, original, custom = O.read_bytes(
        read_archive_file(source, "war3map.w3t"), "w3t"
    )
    backpack = next(
        (entry for entry in custom if entry["new"] == BACKPACK_ID),
        None,
    )
    if backpack is None:
        raise SystemExit("B30B backpack item is missing")
    abilities = next(
        (item for item in backpack["mods"] if item[0] == "iabi"),
        None,
    )
    if abilities is None:
        raise SystemExit("B30B.iabi is missing")
    abilities[4] = "AIni,AEqu,ASde," + OPENER_ID
    return O.build_bytes(version, original, custom, "w3t")


def build_ability_data() -> bytes:
    original_entries = []
    custom_entries = [
        talent_entry(TALENT_ID),
        attribute_entry(
            MARKER_ID,
            "天赋测试标记",
            ICON_TALENT,
            (0, 0, 0),
        ),
    ]
    for tier in range(TIER_COUNT):
        for choice in range(CHOICES_PER_TIER):
            custom_entries.append(choice_entry(tier, choice))
    objects = []
    for entry in original_entries:
        objects.append(doctor_object(0, entry))
    for entry in custom_entries:
        objects.append(doctor_object(1, entry))
    return DOBJ.write_objects_bytes(3, objects, True)


def doctor_object(table: int, entry: dict[str, object]) -> tuple:
    mods = []
    for field_id, kind, level, column, value in entry["mods"]:
        if isinstance(value, str):
            value = value.encode("utf-8")
        mods.append((field_id, kind, level, column, value))
    return (table, entry["old"], entry["new"], mods)


def patch_title(data: bytes, title: str) -> bytes:
    text = data.decode("utf-8-sig")
    pattern = re.compile(
        r"(STRING\s+10\s*\r?\n\s*\{\s*\r?\n)"
        r"(.*?)"
        r"(\r?\n\s*\})",
        re.S,
    )
    updated, count = pattern.subn(
        lambda match: match.group(1) + title + match.group(3),
        text,
        count=1,
    )
    if count != 1:
        raise SystemExit("war3map.wts STRING 10 title was not found")
    return updated.encode("utf-8")


def prepare_files(source: Path, work: Path, title: str) -> dict[str, Path]:
    work.mkdir(parents=True, exist_ok=True)
    if any(work.iterdir()):
        raise SystemExit("work directory is not empty: " + str(work))
    files = {
        "w3a": work / "war3map.w3a",
        "w3t": work / "war3map.w3t",
        "wts": work / "war3map.wts",
    }
    files["w3a"].write_bytes(build_ability_data())
    files["w3t"].write_bytes(build_item_data(source))
    files["wts"].write_bytes(
        patch_title(
            read_archive_file(source, "war3map.wts"),
            title,
        )
    )
    return files


def inject(
    source: Path,
    output: Path,
    files: dict[str, Path],
) -> None:
    command = [
        sys.executable,
        str(INJECTOR),
        str(source),
        "--script",
        str(TALENT_SCRIPT),
        "--file",
        str(files["w3a"]) + "=war3map.w3a",
        "--file",
        str(files["w3t"]) + "=war3map.w3t",
        "--file",
        str(files["wts"]) + "=war3map.wts",
        "--out",
        str(output),
        "--no-backup",
    ]
    env = dict(os.environ)
    env.update(
        {
            "PYTHONUTF8": "1",
            "PYTHONIOENCODING": "utf-8",
            "JASS_REF_VERSION": "1.24",
        }
    )
    result = subprocess.run(
        command,
        cwd=str(ROOT),
        env=env,
        text=True,
        encoding="utf-8",
        errors="replace",
    )
    if result.returncode:
        raise SystemExit(
            "injection failed with exit code %d" % result.returncode
        )


def fields(entry: tuple | dict[str, object]) -> dict[str, object]:
    result: dict[str, object] = {}
    mods = entry["mods"] if isinstance(entry, dict) else entry[3]
    for item in mods:
        value = item[4]
        if isinstance(value, bytes):
            value = value.decode("utf-8", "replace")
        result[item[0]] = value
        result[(item[0], item[2])] = value
    return result


def verify(output: Path, title: str) -> None:
    archive = W.MPQArchive(str(output))
    try:
        item_version, item_original, item_custom = O.read_bytes(
            archive.read_file("war3map.w3t") or b"", "w3t"
        )
        ability_data = archive.read_file("war3map.w3a") or b""
        (
            ability_version,
            parsed_abilities,
            ability_consumed,
        ) = DOBJ.read_objects_bytes(
            ability_data,
            True,
            fname="war3map.w3a",
            with_end=True,
        )
        script = archive.read_file("war3map.j") or b""
        wts = archive.read_file("war3map.wts") or b""
    finally:
        archive.close()

    del item_version, item_original
    if ability_version != 3:
        raise SystemExit("war3map.w3a must use Reforged version 3")
    if ability_consumed != len(ability_data):
        raise SystemExit("war3map.w3a has trailing object data")
    ability_original = [
        {
            "table": table,
            "old": old.replace("\0", ""),
            "new": new.replace("\0", ""),
            "mods": mods,
        }
        for table, old, new, mods in parsed_abilities
        if table == 0
    ]
    ability_custom = [
        {
            "table": table,
            "old": old.replace("\0", ""),
            "new": new.replace("\0", ""),
            "mods": mods,
        }
        for table, old, new, mods in parsed_abilities
        if table == 1
    ]
    items = {
        entry["new"]: entry
        for entry in item_custom
        if entry["new"]
    }
    backpack = items.get(BACKPACK_ID)
    if backpack is None:
        raise SystemExit("deployed B30B is missing")
    backpack_fields = fields(backpack)
    expected_iabi = "AIni,AEqu,ASde," + OPENER_ID
    if backpack_fields.get("iabi") != expected_iabi:
        raise SystemExit(
            "B30B.iabi mismatch: %r" % backpack_fields.get("iabi")
        )

    abilities = {
        entry["new"]: entry
        for entry in ability_custom
        if entry["new"]
    }
    for tier in range(TIER_COUNT):
        expected = ",".join(
            choice_id(tier, choice)
            for choice in range(CHOICES_PER_TIER)
        )
        master = abilities.get(TALENT_ID)
        if master is None or master["old"] != OPENER_ID:
            raise SystemExit("T1AL master talent is missing")
        master_fields = fields(master)
        if master_fields.get("alev") != TIER_COUNT:
            raise SystemExit("T1AL must have seven levels")
        if (
            master_fields.get("abpx") != 0
            or master_fields.get("abpy") != -11
        ):
            raise SystemExit("T1AL must be hidden at (0, -11)")
        actual = master_fields.get(("aabi", tier + 1))
        if actual != expected:
            raise SystemExit(
                "T1AL tier %d option list mismatch: %r != %r"
                % (tier + 1, actual, expected)
            )
        ids = str(actual).split(",")
        if len(ids) != 3 or any(
            ident not in abilities for ident in ids
        ):
            raise SystemExit(
                "T1AL tier %d does not contain three live choices"
                % (tier + 1)
            )
    if ability_original:
        raise SystemExit("native talent masters must not be table overrides")

    for tier in range(TIER_COUNT):
        for choice in range(CHOICES_PER_TIER):
            entry = abilities.get(choice_id(tier, choice))
            if entry is None or entry["old"] != "AIst":
                raise SystemExit(
                    "attribute choice missing: %s"
                    % choice_id(tier, choice)
                )
            choice_fields = fields(entry)
            actual = (
                choice_fields.get(("Istr", 1)),
                choice_fields.get(("Iagi", 1)),
                choice_fields.get(("Iint", 1)),
            )
            if actual != attribute_values(choice):
                raise SystemExit(
                    "%s attribute mismatch: %r != %r"
                    % (
                        choice_id(tier, choice),
                        actual,
                        attribute_values(choice),
                    )
                )

    markers = (
        (b"function TT_Init takes nothing returns nothing", 1),
        (
            b"call TimerStart(CreateTimer(), 0.0, false, function TT_Init)",
            1,
        ),
        (b"set it = UnitAddItemById(u, 'ttal')", 1),
        (b'"talentpoints"', 2),
        (b"if GetUnitAbilityLevel(u, 'T405') > 0 then", 1),
        (b"call TriggerAddAction(TT_SELL_TRIGGER", 1),
        (b"call UnitRemoveAbility(u, 'ATal')", 1),
        (b"call UnitAddAbility(u, 'T1AL')", 1),
        (b"call UnitUseItem(u, it)", 1),
        (b"call RemoveItem(it)", 1),
    )
    for marker, expected in markers:
        if script.count(marker) != expected:
            raise SystemExit(
                "script marker count mismatch: %r (%d != %d)"
                % (marker, script.count(marker), expected)
            )
    if script.count(b"call TT_Init()") != 0:
        raise SystemExit("TT_Init must be timer-deferred")
    if b"BlzUnitHideAbility(u, 'T1AL', true)" in script:
        raise SystemExit("T1AL must be moved off-screen, not hidden")

    if title.encode("utf-8") not in wts:
        raise SystemExit("deployed map title was not updated")

    print(
        "verified: 7 tiers x 3 direct attribute choices, "
        "one shared custom ATal tree, auto-consumed talent tomes, "
        "B30B.iabi=%s" % expected_iabi
    )


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--source", type=Path, default=DEFAULT_SOURCE)
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    parser.add_argument("--work", type=Path, default=DEFAULT_WORK)
    parser.add_argument("--title", default=DEFAULT_TITLE)
    args = parser.parse_args()

    source = args.source.resolve()
    output = args.output.resolve()
    work = args.work.resolve()
    if not source.is_file():
        raise SystemExit("source not found: " + str(source))
    if output.exists():
        raise SystemExit("output already exists: " + str(output))
    if work.exists() and any(work.iterdir()):
        raise SystemExit("work directory is not empty: " + str(work))

    files = prepare_files(source, work, args.title)
    inject(source, output, files)
    verify(output, args.title)
    print("output:", output)
    print("bytes:", output.stat().st_size)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
