# -*- coding: utf-8 -*- """Static anti-cheat and failure-path inventory."""
from __future__ import annotations

import re

from .chapter_rules import CHAPTERS, MAIN_HERO, chapter_key
from .key_policy import MALL_TRUE
from .program import JassProgram


RX_MALL = re.compile(r'HasMallItem\(\s*[^,]+,\s*"([^"]+)"\s*\)', re.I)
RX_PLAYER_GROUP = re.compile(
    r"ForGroupBJ\([^\r\n]*YDWEGetUnitsOfPlayer(?:All|Matching)Null"
    r"\(Player\(0\)\)[^\r\n]*\)"
)
RX_COMPANION_DELETE = re.compile(
    r"(?:RemoveUnit|KillUnit)\(\s*udg_(?:chongwu|chong|pet)\w*\s*\)",
    re.I,
)
RX_PLATFORM = re.compile(
    r"\b(?:DzAPI_[A-Za-z0-9_]+|RequestExtra[A-Za-z0-9_]*|"
    r"EX[A-Za-z0-9_]+|LBK[A-Za-z0-9_]+|JAPI[A-Za-z0-9_]+)\b"
)
RX_SENTINEL = re.compile(
    r"\b(?:GetFoodUsed|GetFoodMade|GetPlayerTechCountSimple)\b|"
    r"'R60[A-Za-z0-9_]{1,4}'|'I67C'"
)
RX_KILL_MAIN = re.compile(r"KillUnit\(\s*" + re.escape(MAIN_HERO) + r"\s*\)")


def scan(text: str, chapter: str) -> dict[str, object]:
    """Return a compact, machine-readable inventory for one chapter."""
    program = JassProgram.parse(text)
    death_triggers: list[dict[str, object]] = []
    for trigger, events in program.events_of.items():
        if "EVENT_PLAYER_UNIT_DEATH" not in events:
            continue
        cond_name = program.cond_of.get(trigger, "")
        action_name = program.act_of.get(trigger, "")
        condition = program.body(cond_name)
        action = program.body(action_name)
        hero_rule = bool(
            re.search(
                r"IsUnitType\(\s*GetDyingUnit\(\)\s*,\s*UNIT_TYPE_HERO\s*\)"
                r"\s*==\s*true",
                condition,
            )
        )
        player_zero = "Player(0)" in condition
        main_only = bool(
            re.search(
                r"GetDyingUnit\(\)\s*==\s*" + re.escape(MAIN_HERO),
                condition,
            )
        )
        defeat = "CustomDefeatBJ(" in action
        wipe = bool(RX_PLAYER_GROUP.search(action))
        death_triggers.append(
            {
                "trigger": trigger,
                "condition": cond_name,
                "action": action_name,
                "hero_rule": hero_rule,
                "player_zero": player_zero,
                "main_hero_only": main_only,
                "defeat": defeat,
                "player_group_cleanup": wipe,
            }
        )

    mall_keys = sorted(set(RX_MALL.findall(text)))
    return {
        "chapter": chapter_key(chapter),
        "known_chapter": chapter_key(chapter) in CHAPTERS,
        "mall_keys": mall_keys,
        "unexpected_mall_keys": sorted(set(mall_keys) - MALL_TRUE),
        "player_death_triggers": death_triggers,
        "generic_player_hero_death_defeats": sum(
            1
            for record in death_triggers
            if record["hero_rule"]
            and record["player_zero"]
            and record["defeat"]
            and not record["main_hero_only"]
        ),
        "player_group_cleanup_calls": len(RX_PLAYER_GROUP.findall(text)),
        "companion_delete_calls": len(RX_COMPANION_DELETE.findall(text)),
        "platform_apis": sorted(set(RX_PLATFORM.findall(text))),
        "food_or_tech_sentinels": sorted(set(RX_SENTINEL.findall(text))),
        "manual_main_hero_kills": len(RX_KILL_MAIN.findall(text)),
    }
