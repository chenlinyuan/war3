# -*- coding: utf-8 -*-
"""Disable paid-content license cleanup that deletes the player's army.

The campaign contains periodic and event-driven triggers shaped like:

    if HasMallItem(Player(0), "KEY") != true
       and <the associated unit, item, or tech exists> then
        ForGroupBJ(all player units, remove_callback)
    endif

These are not gameplay cleanup.  They punish a missing platform entitlement by
removing every player unit.  In offline mode the key policy may intentionally
return false, so the license cleanup must be neutralized independently.

Only the ``ForGroupBJ`` call itself is changed.  The surrounding condition and
all normal quest/branch actions must remain intact: replacing the outer
condition can accidentally select the anti-cheat ``else`` branch.
"""
from __future__ import annotations

import re


RX_FUNC = re.compile(r"(?m)^function\s+(\w+)\s+takes\s")
RX_MALL_IF = re.compile(
    r'(?m)^(?P<indent>[ \t]*)if[^\r\n]*HasMallItem\('
    r'[^,]+,\s*"(?P<key>[^"]+)"\s*\)\s*(?:==|!=)\s*true'
    r'[^\r\n]*then[^\r\n]*$',
    re.I,
)
RX_FORGROUP = re.compile(
    r"(?m)^(?P<indent>[ \t]*)call[ \t]+ForGroupBJ\([^\r\n]*?"
    r",[ \t]*function[ \t]+(?P<callback>\w+)\)[ \t]*(?://[^\r\n]*)?\r?$"
)
PLAYER_GROUP = "YDWEGetUnitsOfPlayerMatchingNull(Player(0), null)"


def _function_spans(text: str) -> dict[str, tuple[int, int]]:
    marks = [(match.start(), match.group(1)) for match in RX_FUNC.finditer(text)]
    return {
        name: (start, marks[index + 1][0] if index + 1 < len(marks) else len(text))
        for index, (start, name) in enumerate(marks)
    }


def _same_indent_endif_end(text: str, start: int, indent: str) -> int | None:
    pattern = re.compile(
        r"(?m)^" + re.escape(indent) + r"endif[ \t]*(?://[^\r\n]*)?\r?$"
    )
    match = pattern.search(text, start)
    return match.end() if match else None


def patch(text: str) -> tuple[str, list[dict[str, object]]]:
    """Neutralize entitlement cleanup blocks and return change records."""
    spans = _function_spans(text)
    edits: list[tuple[int, int, str]] = []
    records: list[dict[str, object]] = []
    for function, (func_start, func_end) in spans.items():
        body = text[func_start:func_end]
        for match in RX_MALL_IF.finditer(body):
            block_end = _same_indent_endif_end(body, match.end(), match.group("indent"))
            if block_end is None:
                continue
            block = body[match.end():block_end]
            if PLAYER_GROUP not in block:
                continue
            for call in RX_FORGROUP.finditer(block):
                callback = call.group("callback")
                start, end = spans.get(callback, (0, 0))
                if "RemoveUnit(GetEnumUnit())" not in text[start:end]:
                    continue
                absolute_start = func_start + match.end() + call.start()
                absolute_end = func_start + match.end() + call.end()
                newline = "\r\n" if "\r\n" in call.group(0) else "\n"
                replacement = (
                    call.group("indent")
                    + "call DoNothing() // IB: mall license cleanup disabled ("
                    + match.group("key")
                    + ")"
                    + newline
                )
                edits.append((absolute_start, absolute_end, replacement))
                records.append(
                    {
                        "function": function,
                        "key": match.group("key"),
                        "callback": callback,
                        "line": text.count("\n", 0, absolute_start) + 1,
                    }
                )
    output = text
    for start, end, replacement in sorted(edits, reverse=True):
        output = output[:start] + replacement + output[end:]
    return output, records


def verify(text: str, records: list[dict[str, object]]) -> list[str]:
    """Return keys whose player-army entitlement cleanup is still active."""
    spans = _function_spans(text)
    remaining: list[str] = []
    for record in records:
        function = str(record["function"])
        key = str(record["key"])
        start, end = spans.get(function, (0, 0))
        body = text[start:end]
        guard = re.search(
            r'if[^\r\n]*HasMallItem\([^,]+,\s*"'
            + re.escape(key)
            + r'"\s*\)\s*(?:==|!=)\s*true[^\r\n]*then',
            body,
            re.I,
        )
        if not guard or PLAYER_GROUP not in body:
            continue
        for call in RX_FORGROUP.finditer(body[guard.start():]):
            callback = call.group("callback")
            start, end = spans.get(callback, (0, 0))
            if "RemoveUnit(GetEnumUnit())" in text[start:end]:
                remaining.append(key)
    return sorted(set(remaining))
