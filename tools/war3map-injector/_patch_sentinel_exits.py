# -*- coding: utf-8 -*-
"""Neutralize known anti-single-player "sentinel exit" branches.

These branches are not story outcomes.  They are platform-side sentinels that
wipe the player's units and then call CustomVictoryBJ:

  * R60E: set when DzAPI_Map_GetMapLevel() reaches 50.  The old 100-level stub
    immediately enabled this hidden "map escape" path.
  * I67C charges >= 2: duplicate/clear-item protection used by the author.

Only branches whose surrounding action can still end the chapter are changed.
The rest of the trigger and unrelated R60E gameplay branches stay intact.
"""
from __future__ import annotations

import re
from dataclasses import dataclass


@dataclass(frozen=True)
class SentinelRule:
    name: str
    needle: str
    branch: re.Pattern[str]
    requires_end: bool = True
    requires: tuple[str, ...] = ()


RULES = (
    SentinelRule(
        "platform-map-level",
        "GetPlayerTechCountSimple('R60E'",
        re.compile(
            r"^[ \t]*if[ \t]+GetPlayerTechCountSimple\('R60E',[^\r\n]*"
            r"[ \t]+then[ \t]*$",
            re.M,
        ),
    ),
    SentinelRule(
        "platform-map-level-1000",
        "GetPlayerTechCountSimple('R60F'",
        re.compile(
            r"^[ \t]*if[ \t]+GetPlayerTechCountSimple\('R60F',[^\r\n]*"
            r"[ \t]+then[ \t]*$",
            re.M,
        ),
        requires_end=False,
        requires=("SetPlayerHandicap(Player(PLAYER_NEUTRAL_AGGRESSIVE), 1000.0)",),
    ),
    SentinelRule(
        "duplicate-clear-item",
        "GetItemCharges(",
        re.compile(
            r"^[ \t]*if[ \t]+GetItemCharges\([^\r\n]*'I67C'[^\r\n]*\)"
            r"[ \t]*>=[ \t]*2[ \t]+then[ \t]*$",
            re.M,
        ),
    ),
)

RX_FUNC = re.compile(r"(?m)^function\s+(\w+)\s+takes\s")
END_CALL = re.compile(r"\bCustomVictoryBJ\s*\(")


def _function_spans(text: str) -> list[tuple[str, int, int]]:
    marks = [(match.start(), match.group(1)) for match in RX_FUNC.finditer(text)]
    spans = []
    for index, (start, name) in enumerate(marks):
        end = marks[index + 1][0] if index + 1 < len(marks) else len(text)
        spans.append((name, start, end))
    return spans


def patch(text: str) -> tuple[str, dict[str, object]]:
    """Return patched text and machine-readable change details."""
    records: list[dict[str, object]] = []
    edits: list[tuple[int, int, str]] = []
    for function, start, end in _function_spans(text):
        body = text[start:end]
        for rule in RULES:
            if rule.requires_end and not END_CALL.search(body):
                continue
            if any(required not in body for required in rule.requires):
                continue
            if rule.needle not in body:
                continue
            match = rule.branch.search(body)
            if not match:
                continue
            line_start = start + match.start()
            line_end = start + match.end()
            indent = re.match(r"[ \t]*", match.group(0)).group(0)
            replacement = (
                indent
                + "if false then // IB: neutralized "
                + rule.name
                + " sentinel exit"
            )
            edits.append((line_start, line_end, replacement))
            records.append(
                {
                    "rule": rule.name,
                    "function": function,
                    "line": text.count("\n", 0, line_start) + 1,
                    "guard": match.group(0).strip(),
                }
            )

    output = text
    for start, end, replacement in sorted(edits, reverse=True):
        output = output[:start] + replacement + output[end:]
    return output, {
        "sentinel_exits": records,
        "sentinel_exit_count": len(records),
    }


def verify(text: str, records: list[dict[str, object]]) -> list[str]:
    """Return rule names that still match a victory-bearing action."""
    remaining: list[str] = []
    for function, start, end in _function_spans(text):
        body = text[start:end]
        for rule in RULES:
            if rule.requires_end and not END_CALL.search(body):
                continue
            if any(required not in body for required in rule.requires):
                continue
            if rule.needle in body and rule.branch.search(body):
                remaining.append(rule.name)
    return sorted(set(remaining))


def main() -> None:
    import sys
    from pathlib import Path

    for argument in sys.argv[1:]:
        path = Path(argument)
        text = path.read_text(encoding="utf-8", errors="surrogateescape")
        output, stats = patch(text)
        print(
            "%-20s sentinel exits neutralized: %d"
            % (path.name, stats["sentinel_exit_count"])
        )
        for record in stats["sentinel_exits"]:
            print(
                "    line %-7d %-22s %s"
                % (record["line"], record["rule"], record["function"])
            )
        if output != text:
            path.write_text(output, encoding="utf-8", errors="surrogateescape")


if __name__ == "__main__":
    main()
