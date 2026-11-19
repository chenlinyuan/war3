# -*- coding: utf-8 -*-
"""Source-specific patch entry for 血精灵之诅咒：AI 副官.

The campaign's mall keys only control optional cosmetics, pets, and bonus
resources.  No key is required for campaign progression, so every entitlement
defaults to false instead of exposing paid content to offline players.
"""
from __future__ import annotations

from .chapter_rules import CHAPTERS, chapter_key


def patch(text: str, chapter: str) -> tuple[str, dict[str, object]]:
    key = chapter_key(chapter)
    return text, {
        "campaign_patch": "blood-elf-curse",
        "campaign_patch_chapter": key,
        "campaign_patch_unknown_chapter": key not in CHAPTERS,
        "campaign_patch_records": [],
        "campaign_patch_count": 0,
    }


def verify(text: str, stats: dict[str, object]) -> list[str]:
    del text
    if stats.get("campaign_patch_unknown_chapter"):
        return ["unknown-chapter"]
    return []
