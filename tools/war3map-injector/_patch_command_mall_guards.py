# -*- coding: utf-8 -*-
"""Remove unrelated mall checks from campaign command conditions.

Wilderness-wrath chapter 5 gates its ``GO`` command on
``HasMallItem(Player(0), "SWLY65") != true``.  With the legacy single-player
stub returning true for unknown keys, the main quest can be complete while the
command remains permanently inert.

Only the command condition itself is edited.  Quest state and unit-handle
guards remain intact.
"""
from __future__ import annotations

import re


RX_FUNC = re.compile(r"(?m)^function\s+(\w+)\s+takes\s")
RX_GO = re.compile(r'GetEventPlayerChatString\(\)\s*==\s*"GO"')
RX_MALL_CALL = (
    r'DzAPI_Map_HasMallItem\([^\r\n]*?"[^"]+"\s*\)'
    r'\s*(?:==|!=)\s*(?:true|false)'
)
RX_TRAILING = re.compile(r"\s+(?:and|or)\s+" + RX_MALL_CALL, re.I)
RX_LEADING = re.compile(r"\(?\s*" + RX_MALL_CALL + r"\s+(?:and|or)\s+", re.I)


def patch(text: str) -> tuple[str, list[dict[str, object]]]:
    """Strip mall clauses from the GO condition and return edit details."""
    records: list[dict[str, object]] = []
    marks = [(match.start(), match.group(1)) for match in RX_FUNC.finditer(text)]
    edits: list[tuple[int, int, str]] = []
    for index, (start, name) in enumerate(marks):
        end = marks[index + 1][0] if index + 1 < len(marks) else len(text)
        body = text[start:end]
        if not RX_GO.search(body) or "DzAPI_Map_HasMallItem(" not in body:
            continue
        fixed, trailing = RX_TRAILING.subn("", body)
        fixed, leading = RX_LEADING.subn("", fixed)
        if trailing + leading == 0:
            continue
        edits.append((start, end, fixed))
        records.append(
            {
                "function": name,
                "command": "GO",
                "removed_mall_clauses": trailing + leading,
                "line": text.count("\n", 0, start) + 1,
            }
        )
    output = text
    for start, end, replacement in sorted(edits, reverse=True):
        output = output[:start] + replacement + output[end:]
    return output, records


def verify(text: str) -> list[str]:
    """Return GO condition functions that still contain a mall call."""
    problems: list[str] = []
    marks = [(match.start(), match.group(1)) for match in RX_FUNC.finditer(text)]
    for index, (start, name) in enumerate(marks):
        end = marks[index + 1][0] if index + 1 < len(marks) else len(text)
        body = text[start:end]
        if RX_GO.search(body) and "DzAPI_Map_HasMallItem(" in body:
            problems.append(name)
    return problems
