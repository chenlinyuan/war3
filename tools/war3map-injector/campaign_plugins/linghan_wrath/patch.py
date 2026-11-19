# -*- coding: utf-8 -*-
"""Source-specific script repair entry for Linghan Wrath."""
from __future__ import annotations

from . import cinematic_skip, player_wipe
from .chapter_rules import (
    CHAPTERS,
    SKIP_CHAPTER,
    WIPE_CHAPTER,
    chapter_key,
)


def patch(text: str, chapter: str) -> tuple[str, dict[str, object]]:
    key = chapter_key(chapter)
    records: list[dict[str, object]] = []
    if key == WIPE_CHAPTER:
        text, records = player_wipe.patch(text)
    elif key == SKIP_CHAPTER:
        text, records = cinematic_skip.patch(text)
    return text, {
        "campaign_patch": "linghan-wrath",
        "campaign_patch_chapter": key,
        "campaign_patch_unknown_chapter": key not in CHAPTERS,
        "campaign_patch_records": records,
        "campaign_patch_count": len(records),
    }


def verify(text: str, stats: dict[str, object]) -> list[str]:
    problems: list[str] = []
    if stats.get("campaign_patch_unknown_chapter"):
        problems.append("unknown-chapter")
    if chapter_key(str(stats.get("campaign_patch_chapter", ""))) == WIPE_CHAPTER:
        problems.extend(player_wipe.verify(text))
    if chapter_key(str(stats.get("campaign_patch_chapter", ""))) == SKIP_CHAPTER:
        problems.extend(cinematic_skip.verify(text))
    return problems
