# -*- coding: utf-8 -*-
"""Identify mall keys used as anti-cheat markers rather than purchased perks.

KK campaigns overload ``DzAPI_Map_HasMallItem``:

  * a purchased perk normally expects ``true``;
  * an anti-cheat/clear-version marker expects ``false``.

The single-player stub historically returned ``true`` for every key.  When a
negative marker is used as

    if HasMallItem(p, "YEZ500") != true then
        ...complete the main quest...
    else
        ...claim the player is cheating...
    endif

the flag silently blocks campaign progression.  This module finds action
functions containing anti-cheat WTS text and marks every mall key used by those
same functions as ``false``.
"""
from __future__ import annotations

import re


ANTI_CHEAT_TEXT = re.compile(
    r"(?:外挂|作弊|平台规定|未知软件|非法|上传[^。！\r\n]{0,12}ID)",
    re.I,
)
RX_TRIGSTR = re.compile(r"TRIGSTR_0*(\d+)", re.I)
RX_MALL = re.compile(
    r'HasMallItem\(\s*[^,]+,\s*"([^"]+)"\s*\)'
)
PROGRESS_BLOCK = re.compile(
    r'HasMallItem\(\s*[^,]+,\s*"(?P<key>[^"]+)"\s*\)\s*==\s*true'
    r'\s+then\s+call\s+(?:DoNothing|CustomVictoryBJ|CustomDefeatBJ)\s*\('
    r'[^\r\n]*\)[ \t]*\r?\n[ \t]*else\s+'
    r'call\s+QuestItemSetCompleted\(',
    re.I | re.S,
)
RX_FUNC = re.compile(r"(?m)^function\s+(\w+)\s+takes\s")


def anti_cheat_string_ids(strings: dict[int, str]) -> set[str]:
    """Return normalized TRIGSTR tokens whose text describes anti-cheat."""
    return {"TRIGSTR_%d" % number for number, text in strings.items() if ANTI_CHEAT_TEXT.search(text)}


def marker_keys(
    text: str,
    anti_cheat_tokens: set[str],
) -> tuple[list[str], list[str]]:
    """Return (anti-cheat keys, progress-blocking keys)."""
    marks = [(match.start(), match.group(1)) for match in RX_FUNC.finditer(text)]
    anti_cheat_keys: set[str] = set()
    progress_keys: set[str] = set()
    for index, (start, _name) in enumerate(marks):
        end = marks[index + 1][0] if index + 1 < len(marks) else len(text)
        function_body = text[start:end]
        progress_keys.update(
            match.group("key") for match in PROGRESS_BLOCK.finditer(function_body)
        )
        if not anti_cheat_tokens:
            continue
        referenced = {
            "TRIGSTR_%d" % int(number)
            for number in RX_TRIGSTR.findall(function_body)
        }
        if not referenced.intersection(anti_cheat_tokens):
            continue
        anti_cheat_keys.update(RX_MALL.findall(function_body))
    return sorted(anti_cheat_keys), sorted(progress_keys)


def classify(text: str, strings: dict[int, str]) -> dict[str, object]:
    tokens = anti_cheat_string_ids(strings)
    anti_cheat_keys, progress_keys = marker_keys(text, tokens)
    keys = sorted(set(anti_cheat_keys) | set(progress_keys))
    return {
        "anti_cheat_strings": sorted(tokens),
        "anti_cheat_mall_keys": anti_cheat_keys,
        "progress_marker_keys": progress_keys,
        "mall_false_keys": keys,
        "mall_false_count": len(keys),
    }
