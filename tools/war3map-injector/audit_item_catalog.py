#!/usr/bin/env python3
"""Audit a generated ALAS item catalog and browser script.

Checks that every custom campaign item ID reached the browser table, reports
search-term hits, and verifies that generated JASS string literals close on
their own lines. This catches stale base-item catalogs and broken chat text.
"""

from __future__ import annotations

import argparse
import os
import re
import sys
import tempfile
from collections import defaultdict
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))

import port_item_skill_campaign as PORT  # noqa: E402
import war3mpq as W  # noqa: E402


def read_item_rows(path: Path) -> list[tuple[str, str, str]]:
    rows = []
    for line in path.read_text(encoding="utf-8").splitlines():
        parts = line.split("\t", 2)
        if len(parts) == 3 and len(parts[1]) == 4:
            rows.append((parts[0], parts[1], parts[2]))
    return rows


def unclosed_string_lines(path: Path) -> list[int]:
    bad = []
    for line_number, line in enumerate(path.read_bytes().splitlines(), 1):
        in_string = False
        escaped = False
        for char in line:
            if char == 0x22 and not escaped:
                in_string = not in_string
            if char == 0x5C and not escaped:
                escaped = True
            else:
                escaped = False
        if in_string:
            bad.append(line_number)
    return bad


def invalid_gbk_name_lines(path: Path) -> list[int]:
    """GBK compatibility names must contain one escaped JASS string literal."""
    bad = []
    for line_number, line in enumerate(path.read_bytes().splitlines(), 1):
        if not re.match(
            rb'^\s*set\s+ib_(?:item|unit)NameGbk\[[0-9]+\]\s*=\s*"',
            line,
        ):
            continue
        quotes = 0
        escaped = False
        for char in line:
            if char == 0x22 and not escaped:
                quotes += 1
            if char == 0x5C and not escaped:
                escaped = True
            else:
                escaped = False
        if quotes != 2:
            bad.append(line_number)
    return bad


def campaign_name_variants(
    campaign: Path,
) -> tuple[dict[str, set[str]], set[str]]:
    variants: dict[str, set[str]] = defaultdict(set)
    all_ids = set()
    archive = W.MPQArchive(str(campaign))
    try:
        chapters = sorted(
            name for name in archive.listfile
            if name.lower().endswith((".w3x", ".w3m"))
        )
        for chapter_name in chapters:
            data = archive.read_file(chapter_name)
            if not data:
                raise RuntimeError("cannot read chapter " + chapter_name)
            fd, temp_name = tempfile.mkstemp(suffix=".w3x")
            os.close(fd)
            temp = Path(temp_name)
            try:
                temp.write_bytes(data)
                chapter = W.MPQArchive(str(temp))
                try:
                    names = PORT.target_custom_names(chapter, "w3t")
                finally:
                    chapter.close()
                all_ids.update(names)
                for ident, name in names.items():
                    variants[ident].add(name)
            finally:
                temp.unlink(missing_ok=True)
    finally:
        archive.close()
    return variants, all_ids


def map_name_variants(
    map_path: Path,
) -> tuple[dict[str, set[str]], set[str]]:
    archive = W.MPQArchive(str(map_path))
    try:
        names = PORT.target_custom_names(archive, "w3t")
    finally:
        archive.close()
    variants: dict[str, set[str]] = defaultdict(set)
    for ident, name in names.items():
        variants[ident].add(name)
    return variants, set(names)


def main() -> int:
    parser = argparse.ArgumentParser()
    source = parser.add_mutually_exclusive_group(required=True)
    source.add_argument("--campaign", type=Path)
    source.add_argument("--map", type=Path)
    parser.add_argument("--work", type=Path, required=True)
    parser.add_argument("--term", action="append", default=[])
    args = parser.parse_args()

    rows = read_item_rows(args.work / "_itemids.txt")
    extra = args.work / "_itemids_extra.txt"
    if extra.is_file():
        known_pairs = {(row[1], row[2]) for row in rows}
        rows.extend(
            row for row in read_item_rows(extra)
            if (row[1], row[2]) not in known_pairs
        )
    if not rows:
        raise SystemExit("item catalog is empty")
    ids = {row[1] for row in rows}
    names = {(row[1], row[2]) for row in rows}
    if len(names) != len(rows):
        raise SystemExit("item catalog contains duplicate ID/name pairs")

    if args.campaign:
        variants, source_ids = campaign_name_variants(args.campaign)
    else:
        variants, source_ids = map_name_variants(args.map)
    missing = source_ids - ids
    if missing:
        raise SystemExit(
            "source item IDs missing: " + ", ".join(sorted(missing))
        )

    for ident, names in sorted(variants.items()):
        if len(names) > 1:
            print("chapter name variants %s: %s" %
                  (ident, " / ".join(sorted(names))))

    for term in args.term:
        matches = [row for row in rows if term.lower() in row[2].lower()]
        print("search %s: %d" % (term, len(matches)))
        for flag, ident, name in matches:
            print("  %s %s %s" % (flag, ident, name))
        if not matches:
            raise SystemExit("search term has no catalog hits: " + term)

    browser = args.work / "item-browser" / "f.j"
    bad_lines = unclosed_string_lines(browser)
    if bad_lines:
        raise SystemExit("unclosed JASS string on browser lines: %s" %
                         ", ".join(str(n) for n in bad_lines[:20]))
    bad_gbk_lines = invalid_gbk_name_lines(browser)
    if bad_gbk_lines:
        raise SystemExit(
            "invalid quoted GBK name on browser lines: %s"
            % ", ".join(str(n) for n in bad_gbk_lines[:20])
        )

    module = args.work / "item-skill-wings-301.lua"
    if module.is_file():
        script = module.read_text(encoding="utf-8")
        if "local function __cat(a, b)" in script:
            raise SystemExit("runtime __cat drops arguments after the second")
        if "local function __cat(...)" not in script:
            raise SystemExit("generated runtime has no variadic __cat")

    print("items: %d" % len(rows))
    print("%s item IDs: %d" % (
        "campaign" if args.campaign else "map",
        len(source_ids),
    ))
    print("unclosed JASS strings: 0")
    print("invalid quoted GBK names: 0")
    print("PASS: complete catalog, searchable items, paired generated strings")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
