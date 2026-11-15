# -*- coding: utf-8 -*-
"""Restore UI, cinematic, and fog state before campaign victory.

Some campaign finales call ``CinematicModeBJ(true)`` and disable fog, then
invoke ``CustomVictoryBJ`` without restoring the normal state.  The engine can
return to the campaign chapter screen with a black or unusable frame.

The skip path is often a separate ``EVENT_PLAYER_EVENT_END_CINEMATIC`` action
that calls victory directly, so it needs the same cleanup independently.
"""
from __future__ import annotations

import re


RX_FUNC = re.compile(r"(?m)^function\s+(\w+)\s+takes\s")
RX_VICTORY = re.compile(
    r"(?m)^(?P<indent>[ \t]*)call[ \t]+CustomVictoryBJ\("
    r"[^\r\n]*\)[ \t]*(?://[^\r\n]*)?\r?$"
)
RX_END_TRIGGER_ACTION = re.compile(
    r"TriggerRegisterPlayerEventEndCinematic\([^\r\n]*\)"
    r"[\s\S]*?"
    r"TriggerAddAction\([^,]+,\s*function\s+(\w+)\)"
)
MARKER = "IB: restore campaign UI before final victory"


def _spans(text: str) -> dict[str, tuple[int, int]]:
    marks = [(match.start(), match.group(1)) for match in RX_FUNC.finditer(text)]
    return {
        name: (start, marks[index + 1][0] if index + 1 < len(marks) else len(text))
        for index, (start, name) in enumerate(marks)
    }


def _cleanup(indent: str, newline: str) -> str:
    return (
        indent
        + "call CinematicModeBJ(false, GetPlayersAll()) // "
        + MARKER
        + newline
        + indent
        + "call DisplayCineFilter(false)"
        + newline
        + indent
        + "call FogMaskEnable(true)"
        + newline
        + indent
        + "call FogEnable(true)"
        + newline
    )


def _target_functions(text: str, spans: dict[str, tuple[int, int]]) -> set[str]:
    targets = {
        name
        for name, (start, end) in spans.items()
        if "CinematicModeBJ(true" in text[start:end]
    }
    targets.update(RX_END_TRIGGER_ACTION.findall(text))
    return targets


def patch(text: str) -> tuple[str, list[dict[str, object]]]:
    """Insert final-state cleanup before victory in cinematic/end actions."""
    spans = _spans(text)
    targets = _target_functions(text, spans)
    edits: list[tuple[int, int, str]] = []
    records: list[dict[str, object]] = []
    for function in sorted(targets):
        start, end = spans.get(function, (0, 0))
        body = text[start:end]
        for match in RX_VICTORY.finditer(body):
            prefix = body[max(0, match.start() - 500):match.start()]
            if MARKER in prefix:
                continue
            absolute = start + match.start()
            newline = "\r\n" if "\r\n" in match.group(0) else "\n"
            edits.append((absolute, absolute, _cleanup(match.group("indent"), newline)))
            records.append(
                {
                    "function": function,
                    "line": text.count("\n", 0, absolute) + 1,
                }
            )
    output = text
    for start, end, replacement in sorted(edits, reverse=True):
        output = output[:start] + replacement + output[end:]
    return output, records


def verify(text: str, records: list[dict[str, object]]) -> list[str]:
    """Return victory functions whose final-state cleanup is missing."""
    spans = _spans(text)
    targets = _target_functions(text, spans)
    problems: list[str] = []
    for function in sorted(targets):
        start, end = spans.get(function, (0, 0))
        body = text[start:end]
        for match in RX_VICTORY.finditer(body):
            prefix = body[max(0, match.start() - 500):match.start()]
            if MARKER not in prefix:
                problems.append(function)
                break
    return problems
