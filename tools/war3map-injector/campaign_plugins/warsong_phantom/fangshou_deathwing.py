# -*- coding: utf-8 -*-
"""Keep the Deathwing retreat scene from reusing a removed unit handle."""
from __future__ import annotations

import re

from .program import JassProgram


ACTION = "Trig_faafxfcxActions"
UNIT = "gg_unit_U60H_0127"
DEPENDENT_TRIGGERS = (
    "gg_trg_dafanwe______________u",
    "gg_trg_xiaznasog",
)

RX_REMOVE = re.compile(
    r"^(?P<indent>[ \t]*)call[ \t]+RemoveUnit\("
    + re.escape(UNIT)
    + r"\)[ \t]*(?://[^\r\n]*)?(?P<eol>\r\n|\n|\r|$)"
)
RX_TRANSMISSION = re.compile(
    r"^(?P<indent>[ \t]*)call[ \t]+"
    r"TransmissionFromUnitWithNameBJ\([^\r\n]*"
    + re.escape(UNIT)
    + r"[^\r\n]*\)[ \t]*(?://[^\r\n]*)?(?P<eol>\r\n|\n|\r|$)"
)


def _reordered_cleanup(remove: re.Match[str], transmission: str) -> str:
    indent = remove.group("indent")
    newline = remove.group("eol") or "\n"
    lines = [transmission]
    lines.extend(
        indent + "call DisableTrigger(" + trigger + ")" + newline
        for trigger in DEPENDENT_TRIGGERS
    )
    lines.append(remove.group(0))
    lines.append(indent + "set " + UNIT + "=null" + newline)
    return "".join(lines)


def patch(text: str) -> tuple[str, list[dict[str, object]]]:
    """Move the dialogue before cleanup and stop stale periodic references."""
    program = JassProgram.parse(text)
    span = program.spans.get(ACTION)
    if span is None:
        return text, []

    start, end = span
    body = text[start:end]
    lines = body.splitlines(keepends=True)
    edits: list[tuple[int, int, str]] = []
    for index, line in enumerate(lines[:-1]):
        remove = RX_REMOVE.match(line)
        if remove is None:
            continue
        transmission_match = RX_TRANSMISSION.match(lines[index + 1])
        if transmission_match is None:
            continue
        if transmission_match.group("indent") != remove.group("indent"):
            continue
        replacement = _reordered_cleanup(
            remove,
            lines[index + 1],
        )
        offset = sum(len(item) for item in lines[:index])
        edits.append(
            (
                offset,
                offset + len(line) + len(lines[index + 1]),
                replacement,
            )
        )
        break

    if not edits:
        return text, []

    local_start, local_end, replacement = edits[0]
    output = (
        text[:start]
        + body[:local_start]
        + replacement
        + body[local_end:]
        + text[end:]
    )
    return output, [
        {
            "rule": "warsong-fangshou-deathwing-cleanup",
            "function": ACTION,
            "unit": UNIT,
            "dependent_triggers": list(DEPENDENT_TRIGGERS),
        }
    ]


def verify(text: str, expected_count: int) -> list[str]:
    """Check the exact cleanup order and dependent-trigger shutdown."""
    if expected_count == 0:
        return []
    program = JassProgram.parse(text)
    body = program.body(ACTION)
    if not body:
        return ["missing-function:" + ACTION]

    transmission = body.find("TransmissionFromUnitWithNameBJ")
    removal = body.find("call RemoveUnit(" + UNIT + ")")
    if transmission < 0:
        return ["missing-deathwing-dialogue"]
    if removal < 0:
        return ["missing-deathwing-removal"]
    if removal < transmission:
        return ["removal-before-dialogue"]

    problems: list[str] = []
    if "set " + UNIT + "=null" not in body:
        problems.append("unit-handle-not-cleared")
    for trigger in DEPENDENT_TRIGGERS:
        if "call DisableTrigger(" + trigger + ")" not in body:
            problems.append("dependent-trigger-active:" + trigger)
    return problems
