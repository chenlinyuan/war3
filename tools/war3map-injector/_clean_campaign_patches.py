# -*- coding: utf-8 -*-
"""Clean-source-derived rules that are not loaded from historical bundles."""
from __future__ import annotations

import re


BURNING_WRATH_SHA256 = (
    "1ccd780a0c151921a62be3f458de9aa6"
    "cb722b77c1d4fd25ae844c2b904212ae"
)
BURNING_GENERATOR = "gg_unit_npgr_0732"
RX_FUNCTION = re.compile(
    r"(?m)^function\s+(?P<name>\w+)\s+takes\b"
)
RX_UNIT_DEATH_REGISTRATION = re.compile(
    r"TriggerRegisterUnitEvent\(\s*(?P<trigger>gg_trg_\w+)\s*,\s*"
    + re.escape(BURNING_GENERATOR)
    + r"\s*,\s*EVENT_UNIT_DEATH\s*\)"
)
RX_TRIGGER_ACTION = re.compile(
    r"TriggerAddAction\(\s*(?P<trigger>gg_trg_\w+)\s*,\s*"
    r"function\s+(?P<action>\w+)\s*\)"
)
RX_DEFEAT_LINE = re.compile(
    r"(?m)^(?P<indent>[ \t]*)call[ \t]+CustomDefeatBJ\([^\r\n]*\)"
    r"(?P<eol>\r\n|\n|\r|$)"
)
RX_PLAYER_ZERO_WIPE_LINE = re.compile(
    r"(?m)^(?P<indent>[ \t]*)call[ \t]+ForGroupBJ\([^\r\n]*"
    r"YDWEGetUnitsOfPlayerMatchingNull\(Player\(0\),\s*null\)[^\r\n]*\)"
    r"(?P<eol>\r\n|\n|\r|$)"
)
RX_OLD_INVULNERABLE = re.compile(
    r"(?m)^[ \t]*call[ \t]+SetUnitInvulnerable\("
    + re.escape(BURNING_GENERATOR)
    + r",\s*true\)[^\r\n]*(?:\r\n|\n|\r|$)"
)
RX_GENERATOR_TIMED_LIFE = re.compile(
    r"(?m)^(?P<indent>[ \t]*)call[ \t]+UnitApplyTimedLifeBJ\("
    r"[^\r\n]*,\s*udg_xxxx\s*\)[^\r\n]*(?P<eol>\r\n|\n|\r|$)"
)


def _function_bodies(text: str) -> list[tuple[str, int, int]]:
    """Return ``(name, body_start, body_end)`` for every JASS function."""
    starts = list(RX_FUNCTION.finditer(text))
    bodies = []
    for index, match in enumerate(starts):
        end = starts[index + 1].start() if index + 1 < len(starts) else len(text)
        bodies.append((match.group("name"), match.end(), end))
    return bodies


def _burning_generator_death_actions(text: str) -> set[str]:
    death_triggers = {
        match.group("trigger")
        for match in RX_UNIT_DEATH_REGISTRATION.finditer(text)
    }
    return {
        match.group("action")
        for match in RX_TRIGGER_ACTION.finditer(text)
        if match.group("trigger") in death_triggers
    }


def _neutralize_burning_generator_failure(
    text: str,
    chapter: str,
) -> tuple[str, list[dict[str, object]]]:
    if chapter.replace("/", "\\").rsplit("\\", 1)[-1].casefold() != "ransao03.w3m":
        return text, []

    output = RX_OLD_INVULNERABLE.sub("", text)
    output, timed_life_count = RX_GENERATOR_TIMED_LIFE.subn(
        lambda match: (
            match.group("indent")
            + "call DoNothing() // IB: mall-gated generator explosion disabled"
            + (match.group("eol") or "\n")
        ),
        output,
    )
    action_names = _burning_generator_death_actions(output)
    records: list[dict[str, object]] = []
    if timed_life_count:
        records.append(
            {
                "rule": "burning-clean-generator-timed-life-disabled",
                "unit": BURNING_GENERATOR,
                "count": timed_life_count,
            }
        )
    for name, body_start, body_end in reversed(_function_bodies(output)):
        if name not in action_names:
            continue
        body = output[body_start:body_end]
        changed = body

        def replace_defeat(match: re.Match[str]) -> str:
            return (
                match.group("indent")
                + "call DoNothing() // IB: generator death no longer defeats the player"
                + (match.group("eol") or "\n")
            )

        def replace_wipe(match: re.Match[str]) -> str:
            return (
                match.group("indent")
                + "call DoNothing() // IB: generator death no longer wipes the player army"
                + (match.group("eol") or "\n")
            )

        changed = RX_DEFEAT_LINE.sub(replace_defeat, changed)
        changed = RX_PLAYER_ZERO_WIPE_LINE.sub(replace_wipe, changed)
        if changed == body:
            continue
        output = output[:body_start] + changed + output[body_end:]
        records.append(
            {
                "rule": "burning-clean-generator-death-nonfatal",
                "unit": BURNING_GENERATOR,
                "action": name,
            }
        )
    if not records and action_names:
        return output, [
            {
                "rule": "burning-clean-generator-death-already-safe",
                "unit": BURNING_GENERATOR,
                "actions": sorted(action_names),
            }
        ]
    return output, records


def patch(
    source_sha256: str,
    text: str,
    chapter: str,
) -> tuple[str, list[dict[str, object]]]:
    if source_sha256.casefold() == BURNING_WRATH_SHA256:
        return _neutralize_burning_generator_failure(text, chapter)
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
    ):
        problems = []
        if RX_OLD_INVULNERABLE.search(text):
            problems.append("generator-still-invulnerable")
        if RX_GENERATOR_TIMED_LIFE.search(text):
            problems.append("generator-timed-life-explosion-still-active")
        action_names = _burning_generator_death_actions(text)
        for name, body_start, body_end in _function_bodies(text):
            if name not in action_names:
                continue
            body = text[body_start:body_end]
            if "CustomDefeatBJ" in body:
                problems.append("%s-still-defeats" % name)
            if RX_PLAYER_ZERO_WIPE_LINE.search(body):
                problems.append("%s-still-wipes-player" % name)
        if not action_names:
            problems.append("generator-death-action-not-found")
        return problems
    return []
