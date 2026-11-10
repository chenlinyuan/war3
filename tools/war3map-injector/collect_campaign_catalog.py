"""Build a campaign-wide item/skill catalog from every chapter.

The generic campaign pipeline used to stage only ``war3campaign.w3t``.
Campaigns that define most equipment inside their chapter maps then produced
an incomplete item browser.  This collector scans the campaign-level files
plus every chapter once and preserves distinct ``(ID, name)`` aliases.

Usage:
    python collect_campaign_catalog.py --work maps/port/<campaign>
"""

from __future__ import annotations

import argparse
import tempfile
from pathlib import Path

import port_item_skill_campaign as PORT
import campaign_paths as CAMP


def valid_rawcode(value: str) -> bool:
    return len(value) == 4 and value.isascii()


def read_rows(path: Path) -> list[tuple[str, ...]]:
    if not path.is_file():
        return []
    rows = []
    for line in path.read_text(encoding="utf-8").splitlines():
        parts = tuple(part.strip() for part in line.split("\t"))
        if parts:
            rows.append(parts)
    return rows


def dedupe(rows: list[tuple[str, ...]]) -> list[tuple[str, ...]]:
    seen = set()
    result = []
    for row in rows:
        if row in seen:
            continue
        seen.add(row)
        result.append(row)
    return result


def parse_object_file(
    object_path: Path,
    extension: str,
    strings_path: Path,
    fallback_names: dict[str, str],
) -> list[tuple[str, str]]:
    if not object_path.is_file():
        return []
    _version, entries = PORT.read_objects_from_path(object_path, extension)
    strings = PORT.parse_wts(
        strings_path.read_bytes() if strings_path.is_file() else None
    )
    name_field = "unam" if extension == "w3t" else "anam"
    rows = []
    for _table, old, new, mods in entries:
        ident = (new or old).replace("\0", "")
        if not valid_rawcode(ident):
            continue
        values = PORT.field_values(mods, name_field)
        resolved = (
            PORT.resolve_string(values[-1], strings) if values else ""
        ).strip()
        if not resolved:
            resolved = (
                fallback_names.get(ident)
                or fallback_names.get(old.replace("\0", ""))
                or ident
            )
        rows.append((ident, resolved))
    return rows


def parse_item_files(
    item_paths: list[Path],
    strings_path: Path,
    fallback_names: dict[str, str],
) -> list[tuple[str, str, str]]:
    rows = []
    for item_path in item_paths:
        for ident, name in parse_object_file(
            item_path, "w3t", strings_path, fallback_names
        ):
            rows.append(("C", ident, name))
    return rows


def parse_skill_files(
    ability_paths: list[Path],
    strings_path: Path,
    fallback_names: dict[str, str],
) -> list[tuple[str, str]]:
    rows = []
    for ability_path in ability_paths:
        rows.extend(
            parse_object_file(
                ability_path, "w3a", strings_path, fallback_names
            )
        )
    return rows


def chapter_files(
    chapter: Path, temp: Path
) -> tuple[list[Path], list[Path], Path]:
    import war3mpq as W

    archive = W.MPQArchive(str(chapter))
    try:
        item_files = [
            ("war3map.w3t", archive.read_file("war3map.w3t") or b""),
            ("war3mapSkin.w3t", archive.read_file("war3mapSkin.w3t") or b""),
        ]
        ability_files = [
            ("war3map.w3a", archive.read_file("war3map.w3a") or b""),
            ("war3mapSkin.w3a", archive.read_file("war3mapSkin.w3a") or b""),
        ]
        strings_data = archive.read_file("war3map.wts") or b""
    finally:
        archive.close()

    stem = temp / (chapter.stem + "_catalog")
    strings_path = stem.with_suffix(".wts")
    if strings_data:
        strings_path.write_bytes(strings_data)
    item_paths = []
    ability_paths = []
    for index, (name, data) in enumerate(item_files):
        if data:
            path = temp / ("%s_item_%d.w3t" % (chapter.stem, index))
            path.write_bytes(data)
            item_paths.append(path)
    for index, (name, data) in enumerate(ability_files):
        if data:
            path = temp / ("%s_ability_%d.w3a" % (chapter.stem, index))
            path.write_bytes(data)
            ability_paths.append(path)
    return item_paths, ability_paths, strings_path


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--work", type=Path, required=True)
    args = parser.parse_args()

    work = args.work.resolve()
    base = work / "base"
    if not base.is_dir():
        raise SystemExit("campaign base directory not found: " + str(base))

    item_path = work / "_itemids.txt"
    skill_path = work / "_skillids.txt"
    item_rows = read_rows(item_path)
    skill_rows = read_rows(skill_path)

    item_names = {
        row[1]: row[2]
        for row in item_rows
        if len(row) >= 3 and valid_rawcode(row[1])
    }
    skill_names = {
        row[0]: row[1]
        for row in skill_rows
        if len(row) >= 2 and valid_rawcode(row[0])
    }

    campaign_items_files = [
        base / "war3campaign.w3t",
        base / "war3campaignSkin.w3t",
    ]
    campaign_abilities_files = [
        base / "war3campaign.w3a",
        base / "war3campaignSkin.w3a",
    ]
    campaign_strings = base / "war3campaign.wts"
    campaign_items = parse_item_files(
        campaign_items_files, campaign_strings, item_names
    )
    campaign_skills = parse_skill_files(
        campaign_abilities_files, campaign_strings, skill_names
    )

    chapters = CAMP.chapter_paths(base)
    chapter_items = []
    chapter_skills = []
    with tempfile.TemporaryDirectory(prefix="alas_catalog_") as temp_name:
        temp = Path(temp_name)
        for chapter in chapters:
            item_files, ability_files, strings_file = chapter_files(
                chapter, temp
            )
            chapter_items.extend(
                parse_item_files(item_files, strings_file, item_names)
            )
            chapter_skills.extend(
                parse_skill_files(ability_files, strings_file, skill_names)
            )

    item_rows = dedupe(
        item_rows + campaign_items + chapter_items
    )
    skill_rows = dedupe(
        skill_rows + campaign_skills + chapter_skills
    )
    item_rows = [
        row for row in item_rows
        if len(row) >= 3 and valid_rawcode(row[1])
    ]
    # The same standard item can also appear as a map-level override. Keep
    # one row per ``(ID, name)`` pair; standard rows are already first.
    item_pair_seen = set()
    filtered_items = []
    for row in item_rows:
        pair = (row[1], row[2])
        if pair in item_pair_seen:
            continue
        item_pair_seen.add(pair)
        filtered_items.append(row)
    item_rows = filtered_items
    skill_rows = [
        row for row in skill_rows
        if len(row) >= 2 and valid_rawcode(row[0])
    ]

    item_path.write_text(
        "".join("\t".join(row[:3]) + "\n" for row in item_rows),
        encoding="utf-8",
    )
    skill_path.write_text(
        "".join("\t".join(row[:2]) + "\n" for row in skill_rows),
        encoding="utf-8",
    )
    print(
        "campaign catalog: %d chapters, %d item aliases, %d skills"
        % (len(chapters), len(item_rows), len(skill_rows))
    )
    unique_ids = len({row[1] for row in item_rows})
    print("campaign catalog item IDs: %d" % unique_ids)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
