# -*- coding: utf-8 -*-
"""Source-specific verification entry for Burning Wrath."""
from __future__ import annotations

import re

from . import sentinel
from .chapter_rules import CHAPTERS, MAIN_HERO, SENTINEL_ITEMS, chapter_key
from .key_policy import MALL_FALSE, MALL_TRUE
from .program import JassProgram


RX_MALL_KEY = re.compile(
    r'HasMallItem\(\s*[^,]+,\s*"([^"]+)"\s*\)',
    re.I,
)
RX_HERO_DEATH = re.compile(
    r"IsUnitType\(\s*GetDyingUnit\(\)\s*,\s*UNIT_TYPE_HERO\s*\)"
    r"\s*==\s*true"
)


def patch(text: str, chapter: str) -> tuple[str, dict[str, object]]:
    key = chapter_key(chapter)
    text, sentinel_records = sentinel.patch(text)
    return text, {
        "campaign_patch": "burning-wrath",
        "campaign_patch_chapter": key,
        "campaign_patch_unknown_chapter": key not in CHAPTERS,
        "campaign_patch_records": sentinel_records,
        "campaign_patch_count": len(sentinel_records),
        "mall_keys": sorted(set(RX_MALL_KEY.findall(text))),
    }


def verify(text: str, stats: dict[str, object]) -> list[str]:
    problems: list[str] = []
    if stats.get("campaign_patch_unknown_chapter"):
        problems.append("unknown-chapter")

    unexpected = (
        set(RX_MALL_KEY.findall(text))
        - MALL_TRUE
        - MALL_FALSE
    )
    if unexpected:
        problems.append("unexpected-mall-keys:" + ",".join(sorted(unexpected)))
    problems.extend(sentinel.verify(text))

    program = JassProgram.parse(text)
    for trigger, events in program.events_of.items():
        if "EVENT_PLAYER_UNIT_DEATH" not in events:
            continue
        condition = program.body(program.cond_of.get(trigger, ""))
        action = program.body(program.act_of.get(trigger, ""))
        if (
            RX_HERO_DEATH.search(condition)
            and "Player(0)" in condition
            and "CustomDefeatBJ(" in action
            and "GetDyingUnit() == " + MAIN_HERO not in condition
        ):
            problems.append("generic-hero-defeat:" + trigger)

    for item in SENTINEL_ITEMS:
        if (
            "GetItemTypeId(GetManipulatedItem()) == '" + item + "'"
            in text
            and "RemoveUnit(gg_unit_H64Z_0401)" in text
        ):
            # The item pickup remains defined, but TU66B is blacklisted.
            if 'HasMallItem(Player(0), "TU66B")' not in text:
                problems.append("sentinel-key-missing:" + item)
    return problems
