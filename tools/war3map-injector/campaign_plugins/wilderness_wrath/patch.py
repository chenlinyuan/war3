# -*- coding: utf-8 -*-
"""Source-specific patch entry for 荒野之怒.

The campaign's anti-cheat and platform repairs are composed from the shared
primitives in ``campaign_singleplayer.py``.  This bundle pins the exact source,
chapter inventory, key policy, and backpack-switch ability so no rules leak
between Xiao Jia campaigns.
"""
from __future__ import annotations

from .chapter_rules import CHAPTERS, chapter_key


def patch(text: str, chapter: str) -> tuple[str, dict[str, object]]:
    key = chapter_key(chapter)
    return text, {
        "campaign_patch": "wilderness-wrath",
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
