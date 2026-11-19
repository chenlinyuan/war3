# -*- coding: utf-8 -*-
"""Neutralize Linghan chapter 1's recurring platform-licence army wipe."""
from __future__ import annotations

import re

from .chapter_rules import WIPE_KEY


DISABLED_MARKER = "// IB: linghan platform licence wipe disabled"
RX_FUNCTION = re.compile(r"(?m)^function\s+(?P<name>\w+)\s+takes\b")
RX_REMOVE_ENUM = re.compile(
    r"\bcall\s+RemoveUnit\(\s*GetEnumUnit\(\)\s*\)"
)
RX_GATE = re.compile(
    r"DzAPI_Map_HasMallItem\(\s*Player\(0\)\s*,\s*"
    + re.escape('"' + WIPE_KEY + '"')
    + r"\s*\)\s*!=\s*true",
    re.I,
)
RX_PLAYER_ZERO_GROUP = (
    r"YDWEGetUnitsOfPlayerMatchingNull\(\s*Player\(0\)\s*,\s*null\s*\)"
)
RX_SAVE_PLAYER_ZERO_GROUP = re.compile(
    r"\bcall[ \t]+SaveGroupHandle\([^\r\n]*?"
    r"(?P<handle>0x[0-9A-Fa-f]+)[^\r\n]*?"
    + RX_PLAYER_ZERO_GROUP
)
RX_WIPE_CALL = re.compile(
    r"(?m)^(?P<indent>[ \t]*)call[ \t]+ForGroupBJ\("
    r"[^\r\n]*?LoadGroupHandle\([^\r\n]*?"
    r"(?P<handle>0x[0-9A-Fa-f]+)\)[^\r\n]*?"
    r"function[ \t]+(?P<callback>\w+)\)[^\r\n]*"
    r"(?P<eol>\r\n|\n|\r|$)"
)


def _function_bodies(text: str) -> dict[str, tuple[int, int]]:
    marks = [
        (match.start(), match.group("name"))
        for match in RX_FUNCTION.finditer(text)
    ]
    return {
        name: (
            start,
            marks[index + 1][0] if index + 1 < len(marks) else len(text),
        )
        for index, (start, name) in enumerate(marks)
    }


def _body(text: str, spans: dict[str, tuple[int, int]], name: str) -> str:
    start, end = spans.get(name, (0, 0))
    return text[start:end]


def has_disabled_marker(text: str) -> bool:
    return DISABLED_MARKER in text


def find_player_wipes(text: str) -> list[dict[str, object]]:
    spans = _function_bodies(text)
    player_zero_handles = {
        match.group("handle").casefold()
        for match in RX_SAVE_PLAYER_ZERO_GROUP.finditer(text)
    }
    records: list[dict[str, object]] = []
    for match in RX_WIPE_CALL.finditer(text):
        if match.group("handle").casefold() not in player_zero_handles:
            continue
        callback = match.group("callback")
        if not RX_REMOVE_ENUM.search(_body(text, spans, callback)):
            continue
        records.append(
            {
                "rule": "linghan-platform-player-wipe",
                "key": WIPE_KEY,
                "group_handle": match.group("handle"),
                "callback": callback,
                "start": match.start(),
                "end": match.end(),
                "indent": match.group("indent"),
                "eol": match.group("eol") or "\n",
            }
        )
    return records


def patch(text: str) -> tuple[str, list[dict[str, object]]]:
    if has_disabled_marker(text):
        return text, []
    if not RX_GATE.search(text):
        raise RuntimeError(
            "linghan chapter 1 license gate was not found; refusing a silent no-op"
        )

    records = find_player_wipes(text)
    if len(records) != 1:
        raise RuntimeError(
            "linghan chapter 1 expected one platform player wipe, found %d"
            % len(records)
        )

    record = records[0]
    replacement = (
        str(record["indent"])
        + "call DisableTrigger(GetTriggeringTrigger()) "
        + DISABLED_MARKER
        + str(record["eol"])
    )
    start = int(record["start"])
    end = int(record["end"])
    output = text[:start] + replacement + text[end:]
    return output, [
        {
            "rule": "linghan-platform-player-wipe-disabled",
            "key": WIPE_KEY,
            "group_handle": record["group_handle"],
            "callback": record["callback"],
            "safe_action": "DisableTrigger(GetTriggeringTrigger())",
        }
    ]


def verify(text: str) -> list[str]:
    problems: list[str] = []
    if not has_disabled_marker(text):
        problems.append("chapter1-platform-player-wipe-not-disabled")
    if find_player_wipes(text):
        problems.append("chapter1-platform-player-wipe-still-active")
    return problems
