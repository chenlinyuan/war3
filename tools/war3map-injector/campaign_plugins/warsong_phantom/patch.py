# -*- coding: utf-8 -*-
"""Map-specific anti-cheat repairs for 战歌魅影-斧王之怒.

The plugin is selected only by the source SHA-256 in ``manifest.json``.  It
neutralizes destructive anti-cheat actions while preserving the surrounding
story and entitlement conditions.
"""
from __future__ import annotations

import re

from .audit import scan
from .chapter_rules import (
    CHAPTERS,
    EXTRA_PET_FOOD_UNIT,
    EXTRA_PET_UNIT_TYPE,
    LICENSE_CLEANUP_KEYS,
    MAIN_HERO,
    chapter_key,
    expected_extra_pet_food,
    expected_fangshou_deathwing,
    expected_license_cleanup,
    expected_main_hero_death,
)
from . import fangshou_deathwing
from .key_policy import MALL_DEFAULT_TRUE, MALL_TRUE
from .program import JassProgram


RX_MALL_NOT_TRUE = re.compile(
    r'HasMallItem\(\s*[^,]+,\s*"([^"]+)"\s*\)\s*!=\s*true',
    re.I,
)
RX_FORGROUP_PLAYER = re.compile(
    r"(?m)^(?P<indent>[ \t]*)call[ \t]+ForGroupBJ\("
    r"YDWEGetUnitsOfPlayerAllNull\(Player\(0\)\)[^\r\n]*"
    r",[ \t]*function[ \t]+(?P<callback>\w+)\)"
    r"[ \t]*(?://[^\r\n]*)?(?P<eol>\r\n|\n|\r|$)"
)
RX_WARNING = re.compile(
    r"(?m)^(?P<indent>[ \t]*)call[ \t]+QuestMessageBJ\([^\r\n]*"
    r"bj_QUESTMESSAGE_WARNING[^\r\n]*\)"
    r"[ \t]*(?://[^\r\n]*)?(?P<eol>\r\n|\n|\r|$)"
)
RX_DEFEAT = re.compile(
    r"(?m)^(?P<indent>[ \t]*)call[ \t]+CustomDefeatBJ\("
    r"[^\r\n]*\)[ \t]*(?://[^\r\n]*)?(?P<eol>\r\n|\n|\r|$)"
)
RX_RETURN = re.compile(
    r"(?m)^(?P<indent>[ \t]*)return[ \t]*"
    r"(?P<expr>.+?)[ \t]*(?P<comment>//[^\r\n]*)?"
    r"(?P<eol>\r\n|\n|\r|$)"
)
RX_HERO_DYING = re.compile(
    r"IsUnitType\(\s*GetDyingUnit\(\)\s*,\s*UNIT_TYPE_HERO\s*\)"
    r"\s*==\s*true"
)
RX_MAIN_HERO_ONLY = re.compile(
    r"GetDyingUnit\(\)\s*==\s*" + re.escape(MAIN_HERO)
)
RX_SPECIFIC_DEATH = re.compile(
    r"GetDyingUnit\(\)\s*==\s*(?:gg_unit_\w+|udg_\w+)"
)


def _line_replacement(
    pattern: re.Pattern[str],
    body: str,
    comment: str,
) -> list[tuple[int, int, str]]:
    edits: list[tuple[int, int, str]] = []
    for match in pattern.finditer(body):
        newline = match.group("eol") or "\n"
        edits.append(
            (
                match.start(),
                match.end(),
                match.group("indent")
                + "call DoNothing() // "
                + comment
                + newline,
            )
        )
    return edits


def _patch_license_cleanup(
    text: str,
) -> tuple[str, list[dict[str, object]]]:
    program = JassProgram.parse(text)
    edits: list[tuple[int, int, str]] = []
    records: list[dict[str, object]] = []
    seen_actions: set[str] = set()
    for trigger, condition_name in program.cond_of.items():
        condition = program.body(condition_name)
        keys = (
            set(RX_MALL_NOT_TRUE.findall(condition))
            & LICENSE_CLEANUP_KEYS
        )
        if not keys:
            continue
        action_name = program.act_of.get(trigger, "")
        if not action_name or action_name in seen_actions:
            continue
        action_start, action_end = program.spans.get(
            action_name,
            (0, 0),
        )
        action = program.body(action_name)
        if (
            "YDWEGetUnitsOfPlayerAllNull(Player(0))" not in action
            or "bj_QUESTMESSAGE_WARNING" not in action
        ):
            continue
        callbacks = [
            match.group("callback")
            for match in RX_FORGROUP_PLAYER.finditer(action)
        ]
        if not callbacks or not any(
            "RemoveUnit(GetEnumUnit())" in program.body(callback)
            for callback in callbacks
        ):
            continue
        local_edits = _line_replacement(
            RX_FORGROUP_PLAYER,
            action,
            "IB: mall license cleanup disabled",
        )
        local_edits += _line_replacement(
            RX_WARNING,
            action,
            "IB: mall license warning disabled",
        )
        for start, end, replacement in local_edits:
            edits.append(
                (action_start + start, action_start + end, replacement)
            )
        seen_actions.add(action_name)
        records.append(
            {
                "rule": "warsong-license-cleanup",
                "trigger": trigger,
                "action": action_name,
                "keys": sorted(keys),
            }
        )
    output = text
    for start, end, replacement in sorted(edits, reverse=True):
        output = output[:start] + replacement + output[end:]
    return output, records


def _patch_extra_pet_food(
    text: str,
) -> tuple[str, list[dict[str, object]]]:
    program = JassProgram.parse(text)
    edits: list[tuple[int, int, str]] = []
    records: list[dict[str, object]] = []
    unit_type_pattern = re.compile(
        r"YDWECountLivingPlayerUnitsOfTypeIdNull\("
        r"\s*'"
        + re.escape(EXTRA_PET_UNIT_TYPE)
        + r"'\s*,\s*Player\(0\)\s*\)"
    )
    food_pattern = re.compile(
        r"GetFoodUsed\('" + re.escape(EXTRA_PET_FOOD_UNIT) + r"'\)"
    )
    for function, (start, end) in program.spans.items():
        body = text[start:end]
        if (
            not unit_type_pattern.search(body)
            or not food_pattern.search(body)
            or "CustomDefeatBJ(" not in body
        ):
            continue
        local_edits = _line_replacement(
            RX_FORGROUP_PLAYER,
            body,
            "IB: extra-pet anti-cheat cleanup disabled",
        )
        local_edits += _line_replacement(
            RX_WARNING,
            body,
            "IB: extra-pet anti-cheat warning disabled",
        )
        local_edits += _line_replacement(
            RX_DEFEAT,
            body,
            "IB: extra-pet food false defeat disabled",
        )
        for call_start, call_end, replacement in local_edits:
            edits.append(
                (start + call_start, start + call_end, replacement)
            )
        if local_edits:
            records.append(
                {
                    "rule": "warsong-extra-pet-food",
                    "function": function,
                }
            )
    output = text
    for start, end, replacement in sorted(edits, reverse=True):
        output = output[:start] + replacement + output[end:]
    return output, records


def _patch_main_hero_death(
    text: str,
) -> tuple[str, list[dict[str, object]]]:
    program = JassProgram.parse(text)
    edits: list[tuple[int, int, str]] = []
    records: list[dict[str, object]] = []
    for trigger, condition_name in program.cond_of.items():
        if "EVENT_PLAYER_UNIT_DEATH" not in program.events_of.get(
            trigger,
            frozenset(),
        ):
            continue
        action_name = program.act_of.get(trigger, "")
        condition = program.body(condition_name)
        action = program.body(action_name)
        if (
            not RX_HERO_DYING.search(condition)
            or "Player(0)" not in condition
            or RX_MAIN_HERO_ONLY.search(condition)
            or RX_SPECIFIC_DEATH.search(condition)
            or "CustomDefeatBJ(" not in action
        ):
            continue
        condition_start, _condition_end = program.spans.get(
            condition_name,
            (0, 0),
        )
        match = RX_RETURN.search(condition)
        if not match or "GetDyingUnit()" not in match.group("expr"):
            continue
        newline = match.group("eol") or "\n"
        replacement = (
            match.group("indent")
            + "return ( "
            + match.group("expr")
            + " ) and GetDyingUnit() == "
            + MAIN_HERO
            + " // IB: only the main hero may trigger defeat"
            + newline
        )
        edits.append(
            (
                condition_start + match.start(),
                condition_start + match.end(),
                replacement,
            )
        )
        records.append(
            {
                "rule": "warsong-main-hero-death",
                "trigger": trigger,
                "condition": condition_name,
                "action": action_name,
            }
        )
    output = text
    for start, end, replacement in sorted(edits, reverse=True):
        output = output[:start] + replacement + output[end:]
    return output, records


def patch(text: str, chapter: str) -> tuple[str, dict[str, object]]:
    """Apply all source-specific repairs for one chapter."""
    key = chapter_key(chapter)
    if key not in CHAPTERS:
        return text, {
            "campaign_patch": "warsong-phantom",
            "campaign_patch_chapter": key,
            "campaign_patch_unknown_chapter": True,
            "campaign_patch_records": [],
            "campaign_patch_count": 0,
            "license_cleanup_count": 0,
            "extra_pet_food_guard_count": 0,
            "main_hero_death_count": 0,
            "static_audit": scan(text, chapter),
        }

    text, license_records = _patch_license_cleanup(text)
    # Parsing is intentionally refreshed after every edit stage.  Carrying
    # function offsets across replacements is unsafe because comment lengths
    # differ from the removed calls.
    text, pet_records = _patch_extra_pet_food(text)
    text, hero_records = _patch_main_hero_death(text)
    text, deathwing_records = fangshou_deathwing.patch(text)
    records = license_records + pet_records + hero_records + deathwing_records
    stats: dict[str, object] = {
        "campaign_patch": "warsong-phantom",
        "campaign_patch_chapter": key,
        "campaign_patch_unknown_chapter": False,
        "campaign_patch_records": records,
        "campaign_patch_count": len(records),
        "license_cleanup_count": len(license_records),
        "expected_license_cleanup_count": expected_license_cleanup(chapter),
        "extra_pet_food_guard_count": len(pet_records),
        "expected_extra_pet_food_guard_count": expected_extra_pet_food(
            chapter
        ),
        "main_hero_death_count": len(hero_records),
        "expected_main_hero_death_count": expected_main_hero_death(chapter),
        "fangshou_deathwing_count": len(deathwing_records),
        "expected_fangshou_deathwing_count": expected_fangshou_deathwing(
            chapter
        ),
        "mall_true": sorted(MALL_TRUE),
        "mall_default_true": MALL_DEFAULT_TRUE,
    }
    stats["static_audit"] = scan(text, chapter)
    return text, stats


def verify(text: str, stats: dict[str, object]) -> list[str]:
    """Return campaign-specific repairs that are incomplete or ineffective."""
    problems: list[str] = []
    if stats.get("campaign_patch_unknown_chapter"):
        problems.append("unknown-chapter")
        return problems

    checks = (
        (
            "license_cleanup_count",
            "expected_license_cleanup_count",
            "license-cleanup-count-mismatch",
        ),
        (
            "main_hero_death_count",
            "expected_main_hero_death_count",
            "main-hero-death-count-mismatch",
        ),
        (
            "extra_pet_food_guard_count",
            "expected_extra_pet_food_guard_count",
            "extra-pet-food-count-mismatch",
        ),
        (
            "fangshou_deathwing_count",
            "expected_fangshou_deathwing_count",
            "fangshou-deathwing-count-mismatch",
        ),
    )
    for actual_key, expected_key, label in checks:
        if int(stats.get(actual_key, -1)) != int(
            stats.get(expected_key, -2)
        ):
            problems.append(
                "%s:%s!=%s"
                % (
                    label,
                    stats.get(actual_key),
                    stats.get(expected_key),
                )
            )

    program = JassProgram.parse(text)
    for record in stats.get("campaign_patch_records", []):
        rule = str(record.get("rule", ""))
        if rule == "warsong-license-cleanup":
            action = str(record.get("action", ""))
            body = program.body(action)
            if RX_FORGROUP_PLAYER.search(body) or RX_WARNING.search(body):
                problems.append(rule + ":" + action)
        elif rule == "warsong-main-hero-death":
            condition = str(record.get("condition", ""))
            body = program.body(condition)
            if not RX_MAIN_HERO_ONLY.search(body):
                problems.append(rule + ":" + condition)
        elif rule == "warsong-extra-pet-food":
            function = str(record.get("function", ""))
            body = program.body(function)
            if (
                RX_FORGROUP_PLAYER.search(body)
                or RX_WARNING.search(body)
                or RX_DEFEAT.search(body)
            ):
                problems.append(rule + ":" + function)

    audit = stats.get("static_audit") or {}
    if int(audit.get("generic_player_hero_death_defeats", 0)):
        problems.append("generic-player-hero-death-defeats")
    if int(audit.get("companion_delete_calls", 0)):
        problems.append("companion-delete")
    if audit.get("unexpected_mall_keys"):
        problems.append(
            "unexpected-mall-keys:"
            + ",".join(audit.get("unexpected_mall_keys", []))
        )
    problems.extend(
        fangshou_deathwing.verify(
            text,
            int(stats.get("expected_fangshou_deathwing_count", 0)),
        )
    )
    return problems
