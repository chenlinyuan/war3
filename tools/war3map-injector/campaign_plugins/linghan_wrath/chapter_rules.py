# -*- coding: utf-8 -*-
"""Normalized chapter and repair rules for Linghan Wrath."""
from __future__ import annotations

import json
from pathlib import Path


MANIFEST = json.loads(
    Path(__file__).with_name("manifest.json").read_text(encoding="utf-8")
)


def chapter_key(chapter: str) -> str:
    return chapter.replace("\\", "/").rsplit("/", 1)[-1].casefold()


CHAPTERS = frozenset(chapter_key(value) for value in MANIFEST["chapters"])
WIPE_RULE = dict(MANIFEST["rules"]["wu01_anti_cheat_player_wipe"])
WIPE_CHAPTER = chapter_key(str(WIPE_RULE["chapter"]))
WIPE_KEY = str(WIPE_RULE["key"])
WIPE_TRIGGER = str(WIPE_RULE["trigger"])
WIPE_EXPECTED_COUNT = int(WIPE_RULE["expected_count"])
SKIP_RULE = dict(MANIFEST["rules"]["wu02_cinematic_skip_window"])
SKIP_CHAPTER = chapter_key(str(SKIP_RULE["chapter"]))
SKIP_TRIGGER = str(SKIP_RULE["trigger"])
SKIP_CONDITION = str(SKIP_RULE["condition_function"])
SKIP_FLAG = str(SKIP_RULE["flag"])
SKIP_AUTHORED_VALUE = int(SKIP_RULE["authored_value"])
SKIP_BROKEN_VALUE = int(SKIP_RULE["broken_value"])
SKIP_EXPECTED_COUNT = int(SKIP_RULE["expected_count"])
