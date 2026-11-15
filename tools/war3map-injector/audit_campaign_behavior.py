# -*- coding: utf-8 -*-
"""Inventory campaign trigger behavior without launching Warcraft III."""
from __future__ import annotations

import argparse
import json
import re
from pathlib import Path

from campaign_plugins.warsong_phantom.program import JassProgram


RX_MALL = re.compile(r'HasMallItem\(\s*[^,]+,\s*"([^"]+)"')
RX_ITEM = re.compile(r"GetItemTypeId\(\s*GetManipulatedItem\(\)\s*\)\s*==\s*'([^']+)'")
RX_CALL = re.compile(r"\bcall\s+([A-Za-z_]\w*)\s*\(")
RX_GRANT_ITEM = re.compile(r"UnitAddItemByIdSwapped\(\s*'([^']+)'")
RX_CREATE_UNIT = re.compile(r"Create(?:N)?Units?[A-Za-z]*\(\s*[^,]+,\s*'([^']+)'")
RX_CHAT = re.compile(r'TriggerRegisterPlayerChatEvent\([^\r\n]*"([^"]*)"')
DANGEROUS = (
    "CustomDefeatBJ",
    "CustomVictoryBJ",
    "EndGame",
    "RemoveUnit",
    "KillUnit",
    "SaveGameCache",
    "SetNextLevelBJ",
    "CinematicModeBJ",
    "SetPlayerTechResearched",
)
RX_HERO_DEATH = re.compile(
    r"IsUnitType\(\s*GetDyingUnit\(\)\s*,\s*UNIT_TYPE_HERO\s*\)"
    r"\s*==\s*true"
)
RX_DYING_MAIN = re.compile(
    r"GetDyingUnit\(\)\s*==\s*(udg_[A-Za-z0-9_]+)"
)


def _compact(text: str, limit: int = 500) -> str:
    return " ".join(text.strip().split())[:limit]


def _calls(body: str) -> list[str]:
    return sorted(
        {
            name
            for name in RX_CALL.findall(body)
            if name.startswith(
                (
                    "Remove",
                    "Kill",
                    "Custom",
                    "End",
                    "Save",
                    "Store",
                    "SetNext",
                    "SetPlayerTech",
                    "Quest",
                    "UnitAdd",
                    "UnitRemove",
                )
            )
        }
    )


def audit_script(path: Path) -> dict[str, object]:
    text = path.read_text(encoding="utf-8", errors="replace")
    program = JassProgram.parse(text)
    triggers: list[dict[str, object]] = []
    all_keys: set[str] = set()
    for trigger in sorted(set(program.cond_of) | set(program.act_of)):
        condition_name = program.cond_of.get(trigger, "")
        action_name = program.act_of.get(trigger, "")
        condition = program.body(condition_name)
        action = program.body(action_name)
        combined = condition + "\n" + action
        keys = sorted(set(RX_MALL.findall(combined)))
        if not keys:
            continue
        all_keys.update(keys)
        triggers.append(
            {
                "trigger": trigger,
                "events": sorted(program.events_of.get(trigger, ())),
                "condition": condition_name,
                "action": action_name,
                "keys": keys,
                "items": sorted(set(RX_ITEM.findall(combined))),
                "granted_items": sorted(set(RX_GRANT_ITEM.findall(action))),
                "created_units": sorted(set(RX_CREATE_UNIT.findall(action))),
                "condition_text": _compact(condition),
                "action_text": _compact(action),
                "calls": _calls(action),
            }
        )

    chat_triggers: list[dict[str, object]] = []
    for match in RX_CHAT.finditer(text):
        start = text.rfind("function ", 0, match.start())
        end = text.find("\nendfunction", match.start())
        body = text[start : end if end >= 0 else match.end() + 1000]
        chat_triggers.append(
            {
                "command": match.group(1),
                "function": (
                    re.search(r"function\s+(\w+)", body).group(1)
                    if re.search(r"function\s+(\w+)", body)
                    else ""
                ),
                "text": _compact(body),
            }
        )

    dangerous: list[dict[str, object]] = []
    for function, (start, end) in program.spans.items():
        body = text[start:end]
        hits = [name for name in DANGEROUS if name + "(" in body]
        if not hits:
            continue
        dangerous.append(
            {
                "function": function,
                "calls": hits,
                "text": _compact(body),
            }
        )

    death_triggers: list[dict[str, object]] = []
    for trigger, events in program.events_of.items():
        if "EVENT_PLAYER_UNIT_DEATH" not in events:
            continue
        condition = program.body(program.cond_of.get(trigger, ""))
        action = program.body(program.act_of.get(trigger, ""))
        main_matches = sorted(set(RX_DYING_MAIN.findall(condition)))
        death_triggers.append(
            {
                "trigger": trigger,
                "condition": program.cond_of.get(trigger, ""),
                "action": program.act_of.get(trigger, ""),
                "hero_rule": bool(RX_HERO_DEATH.search(condition)),
                "player_zero": "Player(0)" in condition,
                "main_units": main_matches,
                "defeat": "CustomDefeatBJ(" in action,
                "player_group_cleanup": bool(
                    re.search(
                        r"ForGroupBJ\([^\r\n]*"
                        r"YDWEGetUnitsOfPlayer(?:All|Matching)Null"
                        r"\(Player\(0\)\)",
                        action,
                    )
                ),
            }
        )

    return {
        "script": path.name,
        "mall_keys": sorted(all_keys),
        "mall_triggers": triggers,
        "chat_triggers": chat_triggers,
        "player_death_triggers": death_triggers,
        "dangerous_functions": dangerous,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("scripts", type=Path)
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    paths = sorted(args.scripts.glob("*.j"))
    report = {
        "scripts": str(args.scripts.resolve()),
        "chapters": [audit_script(path) for path in paths],
    }
    payload = json.dumps(report, ensure_ascii=False, indent=2) + "\n"
    if args.output:
        args.output.write_text(payload, encoding="utf-8")
    else:
        print(payload, end="")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
