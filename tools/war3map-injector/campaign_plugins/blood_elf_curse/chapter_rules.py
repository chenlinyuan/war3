# -*- coding: utf-8 -*-
"""Pinned chapter inventory and key policy for the campaign bundle."""
from __future__ import annotations

import json
from pathlib import Path


MANIFEST = json.loads(
    (Path(__file__).with_name("manifest.json")).read_text(encoding="utf-8")
)
CHAPTERS = frozenset(str(value).casefold() for value in MANIFEST["chapters"])


def chapter_key(chapter: str) -> str:
    return chapter.replace("\\", "/").rsplit("/", 1)[-1].casefold()
