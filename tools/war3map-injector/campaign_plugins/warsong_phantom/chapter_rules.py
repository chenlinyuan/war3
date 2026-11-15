# -*- coding: utf-8 -*-
"""Normalized chapter rules for the 184449 campaign plugin."""
from __future__ import annotations

import json
from pathlib import Path


MANIFEST_PATH = Path(__file__).with_name("manifest.json")
MANIFEST: dict[str, object] = json.loads(
    MANIFEST_PATH.read_text(encoding="utf-8")
)
RULES = dict(MANIFEST["rules"])


def chapter_key(chapter: str) -> str:
    return chapter.replace("\\", "/").rsplit("/", 1)[-1].casefold()


CHAPTERS = frozenset(chapter_key(value) for value in MANIFEST["chapters"])
LICENSE_RULE = dict(RULES["license_cleanup"])
LICENSE_CLEANUP_CHAPTERS = frozenset(
    chapter_key(value) for value in LICENSE_RULE["chapters"]
)
LICENSE_CLEANUP_KEYS = frozenset(LICENSE_RULE["keys"])
LICENSE_CLEANUP_COUNT = int(LICENSE_RULE["expected_count_per_chapter"])

HERO_RULE = dict(RULES["main_hero_death"])
MAIN_HERO = str(HERO_RULE["main_hero"])
MAIN_HERO_DEATH_CHAPTERS = frozenset(
    chapter_key(value) for value in HERO_RULE["chapters"]
)
MAIN_HERO_DEATH_COUNT = int(HERO_RULE["expected_count_per_chapter"])

PET_RULE = dict(RULES["extra_pet_food"])
EXTRA_PET_FOOD_CHAPTERS = frozenset(
    chapter_key(value) for value in PET_RULE["chapters"]
)
EXTRA_PET_UNIT_TYPE = str(PET_RULE["unit_type"])
EXTRA_PET_FOOD_UNIT = str(PET_RULE["food_unit"])
EXTRA_PET_FOOD_COUNT = int(PET_RULE["expected_count_per_chapter"])

FANGSHOU_DEATHWING_RULE = dict(RULES["fangshou_deathwing_cleanup"])
FANGSHOU_DEATHWING_CHAPTERS = frozenset(
    chapter_key(value)
    for value in FANGSHOU_DEATHWING_RULE["chapters"]
)
FANGSHOU_DEATHWING_COUNT = int(
    FANGSHOU_DEATHWING_RULE["expected_count_per_chapter"]
)


def expected_license_cleanup(chapter: str) -> int:
    return (
        LICENSE_CLEANUP_COUNT
        if chapter_key(chapter) in LICENSE_CLEANUP_CHAPTERS
        else 0
    )


def expected_main_hero_death(chapter: str) -> int:
    return (
        MAIN_HERO_DEATH_COUNT
        if chapter_key(chapter) in MAIN_HERO_DEATH_CHAPTERS
        else 0
    )


def expected_extra_pet_food(chapter: str) -> int:
    return (
        EXTRA_PET_FOOD_COUNT
        if chapter_key(chapter) in EXTRA_PET_FOOD_CHAPTERS
        else 0
    )


def expected_fangshou_deathwing(chapter: str) -> int:
    return (
        FANGSHOU_DEATHWING_COUNT
        if chapter_key(chapter) in FANGSHOU_DEATHWING_CHAPTERS
        else 0
    )
