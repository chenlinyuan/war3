# -*- coding: utf-8 -*-
"""Clean-source-derived rules that are not loaded from historical bundles."""
from __future__ import annotations

import re


BURNING_WRATH_SHA256 = (
    "1ccd780a0c151921a62be3f458de9aa6"
    "cb722b77c1d4fd25ae844c2b904212ae"
)
BURNING_GENERATOR = "gg_unit_npgr_0732"
RX_CREATE_GENERATOR = re.compile(
    r"(?m)^(?P<line>[ \t]*set\s+"
    + re.escape(BURNING_GENERATOR)
    + r"\s*=\s*CreateUnit\([^\r\n]*\)[ \t]*(?P<eol>\r\n|\n|\r|$))"
)


def _protect_burning_generator(
    text: str,
    chapter: str,
) -> tuple[str, list[dict[str, object]]]:
    if chapter.replace("/", "\\").rsplit("\\", 1)[-1].casefold() != "ransao03.w3m":
        return text, []
    marker = "call SetUnitInvulnerable(%s, true)" % BURNING_GENERATOR
    if marker in text:
        return text, []

    def replace(match: re.Match[str]) -> str:
        return (
            match.group("line")
            + "    %s // IB: clean-source protected objective\n" % marker
            + (match.group("eol") or "\n")
        )

    output, count = RX_CREATE_GENERATOR.subn(replace, text)
    records = (
        [
            {
                "rule": "burning-clean-protected-generator",
                "unit": BURNING_GENERATOR,
                "count": count,
            }
        ]
        if count
        else []
    )
    return output, records


def patch(
    source_sha256: str,
    text: str,
    chapter: str,
) -> tuple[str, list[dict[str, object]]]:
    if source_sha256.casefold() == BURNING_WRATH_SHA256:
        return _protect_burning_generator(text, chapter)
    return text, []


def verify(
    source_sha256: str,
    text: str,
    chapter: str,
    records: list[dict[str, object]],
) -> list[str]:
    del records
    if (
        source_sha256.casefold() == BURNING_WRATH_SHA256
        and chapter.replace("/", "\\").rsplit("\\", 1)[-1].casefold()
        == "ransao03.w3m"
        and BURNING_GENERATOR in text
        and "call SetUnitInvulnerable(%s, true)" % BURNING_GENERATOR not in text
    ):
        return ["protected-generator-not-invulnerable"]
    return []
