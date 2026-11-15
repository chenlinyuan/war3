# -*- coding: utf-8 -*-
"""Restrict Naga Wrath defeats to the authored campaign heroes."""
from __future__ import annotations

import re

from .chapter_rules import MAIN_UNITS
from .program import JassProgram


RX_UNIT_GLOBAL = re.compile(
    r"(?m)^[ \t]*unit[ \t]+(udg_[A-Za-z0-9_]+)"
)
RX_HERO_DEATH = re.compile(
    r"IsUnitType\(\s*GetDyingUnit\(\)\s*,\s*UNIT_TYPE_HERO\s*\)"
    r"\s*==\s*true"
)
RX_RETURN = re.compile(
    r"(?m)^(?P<indent>[ \t]*)return(?P<expr>[^\r\n]*)"
    r"(?P<eol>\r\n|\n|\r|$)"
)


def _main_check(units: tuple[str, ...]) -> str:
    return " or ".join(
        "GetDyingUnit() == " + unit for unit in units
    )


def patch(text: str) -> tuple[str, list[dict[str, object]]]:
    declared = set(RX_UNIT_GLOBAL.findall(text))
    units = tuple(unit for unit in MAIN_UNITS if unit in declared)
    if not units:
        return text, []

    program = JassProgram.parse(text)
    edits: list[tuple[int, int, str]] = []
    records: list[dict[str, object]] = []
    for trigger, events in program.events_of.items():
        if "EVENT_PLAYER_UNIT_DEATH" not in events:
            continue
        condition_name = program.cond_of.get(trigger, "")
        action_name = program.act_of.get(trigger, "")
        condition = program.body(condition_name)
        action = program.body(action_name)
        if (
            not condition_name
            or not RX_HERO_DEATH.search(condition)
            or "Player(0)" not in condition
            or "CustomDefeatBJ(" not in action
            or "GetDyingUnit() ==" in condition
        ):
            continue
        match = RX_RETURN.search(condition)
        if match is None:
            continue
        start, _end = program.spans[condition_name]
        newline = match.group("eol") or "\n"
        replacement = (
            match.group("indent")
            + "return ( "
            + match.group("expr").strip()
            + " ) and ( "
            + _main_check(units)
            + " ) // IB: only campaign heroes may trigger defeat"
            + newline
        )
        edits.append(
            (
                start + match.start(),
                start + match.end(),
                replacement,
            )
        )
        records.append(
            {
                "rule": "naga-main-hero-death",
                "trigger": trigger,
                "condition": condition_name,
                "action": action_name,
                "main_units": list(units),
            }
        )

    output = text
    for start, end, replacement in sorted(edits, reverse=True):
        output = output[:start] + replacement + output[end:]
    return output, records


def verify(text: str) -> list[str]:
    program = JassProgram.parse(text)
    problems: list[str] = []
    for trigger, events in program.events_of.items():
        if "EVENT_PLAYER_UNIT_DEATH" not in events:
            continue
        condition = program.body(program.cond_of.get(trigger, ""))
        action = program.body(program.act_of.get(trigger, ""))
        if (
            RX_HERO_DEATH.search(condition)
            and "Player(0)" in condition
            and "CustomDefeatBJ(" in action
            and "GetDyingUnit() ==" not in condition
        ):
            problems.append("generic-hero-defeat:" + trigger)
    return problems
