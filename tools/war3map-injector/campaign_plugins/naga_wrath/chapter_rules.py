# -*- coding: utf-8 -*-
"""Normalized chapter and object rules for Naga Wrath."""
from __future__ import annotations

import json
from pathlib import Path


MANIFEST = json.loads(
    Path(__file__).with_name("manifest.json").read_text(encoding="utf-8")
)


def chapter_key(chapter: str) -> str:
    return chapter.replace("\\", "/").rsplit("/", 1)[-1].casefold()


CHAPTERS = frozenset(chapter_key(value) for value in MANIFEST["chapters"])
MAIN_UNITS = tuple(
    str(value) for value in MANIFEST["rules"]["main_hero_death"]["main_units"]
)
ARTIFACT_RULE = dict(
    MANIFEST["object_rules"]["permanent_artifact_charges"]
)
ARTIFACT_ITEM_IDS = frozenset(
    str(value) for value in ARTIFACT_RULE["item_ids"]
)
ARTIFACT_CHARGE_FIELD = str(ARTIFACT_RULE["field"])
ARTIFACT_CHARGE_VALUE = int(ARTIFACT_RULE["value"])
