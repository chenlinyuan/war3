# -*- coding: utf-8 -*-
"""Source-specific script repair entry for Naga Wrath."""
from __future__ import annotations

import re

from . import hero_death
from .chapter_rules import CHAPTERS, chapter_key
from .key_policy import MALL_FALSE, MALL_TRUE


RX_MALL_KEY = re.compile(
    r'HasMallItem\(\s*[^,]+,\s*"([^"]+)"\s*\)',
    re.I,
)


def patch(text: str, chapter: str) -> tuple[str, dict[str, object]]:
    key = chapter_key(chapter)
    text, hero_records = hero_death.patch(text)
    return text, {
        "campaign_patch": "naga-wrath",
        "campaign_patch_chapter": key,
        "campaign_patch_unknown_chapter": key not in CHAPTERS,
        "campaign_patch_records": hero_records,
        "campaign_patch_count": len(hero_records),
        "mall_keys": sorted(set(RX_MALL_KEY.findall(text))),
    }


def verify(text: str, stats: dict[str, object]) -> list[str]:
    problems: list[str] = []
    if stats.get("campaign_patch_unknown_chapter"):
        problems.append("unknown-chapter")
    problems.extend(hero_death.verify(text))
    unexpected = (
        set(RX_MALL_KEY.findall(text))
        - MALL_TRUE
        - MALL_FALSE
    )
    if unexpected:
        problems.append("unexpected-mall-keys:" + ",".join(sorted(unexpected)))
    return problems
