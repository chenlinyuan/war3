# -*- coding: utf-8 -*-
"""Keep the platform-only sentinel item from deleting a mainline boss."""
from __future__ import annotations

import re


SENTINEL_ITEM = "I67I"
SENTINEL_BOSS = "gg_unit_H64Z_0401"
RX_REMOVE_BOSS = re.compile(
    r"(?m)^(?P<indent>[ \t]*)call[ \t]+RemoveUnit\("
    + re.escape(SENTINEL_BOSS)
    + r"\)[ \t]*(?://[^\r\n]*)?(?P<eol>\r\n|\n|\r|$)"
)


def patch(text: str) -> tuple[str, list[dict[str, object]]]:
    records: list[dict[str, object]] = []

    def replace(match: re.Match[str]) -> str:
        records.append(
            {
                "rule": "burning-sentinel-boss-preserved",
                "item": SENTINEL_ITEM,
                "boss": SENTINEL_BOSS,
            }
        )
        return (
            match.group("indent")
            + "call DoNothing() // IB: platform sentinel boss removal disabled"
            + (match.group("eol") or "\n")
        )

    return RX_REMOVE_BOSS.sub(replace, text), records


def verify(text: str) -> list[str]:
    if RX_REMOVE_BOSS.search(text):
        return ["sentinel-boss-removal-active"]
    return []
