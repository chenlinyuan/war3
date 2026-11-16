# -*- coding: utf-8 -*-
"""Neutralize mall-gated wipes of the player's complete unit group.

This primitive is intentionally narrower than a general group-removal patch:
the trigger condition must mention a mall key, the action tree must enumerate
all Player(0) units, and a ForGroup callback must remove ``GetEnumUnit()``.
Story failures and enemy cleanup are therefore left untouched.
"""
from __future__ import annotations

import re


RX_FUNC = re.compile(r"(?m)^function\s+(\w+)\s+takes\s")
RX_ACTION = re.compile(
    r"TriggerAddAction\(\s*(gg_trg_\w+)\s*,\s*function\s+(\w+)\)"
)
RX_CONDITION = re.compile(
    r"TriggerAddCondition\(\s*(gg_trg_\w+)\s*,\s*"
    r"Condition\(function\s+(\w+)\)\)"
)
RX_FUNCTION_REF = re.compile(r"function\s+(\w+)\)")
RX_MALL_KEY = re.compile(r'HasMallItem\(\s*[^,]+,\s*"([^"]+)"\s*\)', re.I)
RX_PLAYER_ALL = re.compile(
    r"YDWEGetUnitsOfPlayerMatchingNull\(\s*Player\(0\)\s*,\s*null\s*\)"
)
RX_REMOVE_ENUM = re.compile(
    r"\bRemoveUnit\s*\(\s*GetEnumUnit\(\)\s*\)", re.I
)
RX_FOR_GROUP = re.compile(
    r"(?m)^(?P<indent>[ \t]*)call[ \t]+ForGroupBJ\("
    r"[^\r\n]*function\s+(?P<callback>\w+)\)[^\r\n]*"
    r"(?P<eol>\r\n|\n|\r|$)"
)
RX_DEFEAT = re.compile(
    r"(?m)^(?P<indent>[ \t]*)call[ \t]+CustomDefeatBJ\("
    r"[^\r\n]*(?P<eol>\r\n|\n|\r|$)"
)


def _functions(text: str) -> dict[str, tuple[int, int]]:
    marks = [(match.start(), match.group(1)) for match in RX_FUNC.finditer(text)]
    return {
        name: (
            start,
            marks[index + 1][0] if index + 1 < len(marks) else len(text),
        )
        for index, (start, name) in enumerate(marks)
    }


def _body(text: str, spans: dict[str, tuple[int, int]], name: str) -> str:
    span = spans.get(name)
    return text[span[0]:span[1]] if span else ""


def _tree(
    text: str,
    spans: dict[str, tuple[int, int]],
    name: str,
) -> tuple[set[str], str]:
    seen: set[str] = set()
    order: list[str] = []

    def visit(function: str) -> None:
        if not function or function in seen or function not in spans:
            return
        seen.add(function)
        order.append(function)
        for child in RX_FUNCTION_REF.findall(_body(text, spans, function)):
            visit(child)

    visit(name)
    return seen, "\n".join(_body(text, spans, item) for item in order)


def patch(text: str) -> tuple[str, list[dict[str, object]]]:
    spans = _functions(text)
    action_of = {
        match.group(1): match.group(2)
        for match in RX_ACTION.finditer(text)
    }
    condition_of = {
        match.group(1): match.group(2)
        for match in RX_CONDITION.finditer(text)
    }
    records: list[dict[str, object]] = []
    targets: set[str] = set()

    for trigger, action in sorted(action_of.items()):
        condition = condition_of.get(trigger, "")
        if not condition:
            continue
        _condition_functions, condition_text = _tree(
            text,
            spans,
            condition,
        )
        keys = sorted(set(RX_MALL_KEY.findall(condition_text)))
        if not keys:
            continue
        action_functions, action_text = _tree(text, spans, action)
        if not RX_PLAYER_ALL.search(action_text) or not RX_REMOVE_ENUM.search(action_text):
            continue
        targets.update(action_functions)
        records.append(
            {
                "rule": "clean-mall-player-wipe-disabled",
                "trigger": trigger,
                "condition": condition,
                "keys": keys,
            }
        )

    output = text
    for function in sorted(targets):
        original = _body(text, spans, function)
        updated = original
        for group_call in list(RX_FOR_GROUP.finditer(original)):
            callback = group_call.group("callback")
            _callback_functions, callback_text = _tree(
                text,
                spans,
                callback,
            )
            if not RX_REMOVE_ENUM.search(callback_text):
                continue
            replacement = (
                group_call.group("indent")
                + "call DoNothing() // IB: mall-gated player-group wipe disabled"
                + (group_call.group("eol") or "\n")
            )
            updated = updated.replace(group_call.group(0), replacement, 1)
        updated = RX_DEFEAT.sub(
            lambda match: (
                match.group("indent")
                + "call DoNothing() // IB: mall-gated defeat disabled"
                + (match.group("eol") or "\n")
            ),
            updated,
        )
        if updated != original:
            output = output.replace(original, updated, 1)
    return output, records


def verify(text: str) -> list[str]:
    _output, records = patch(text)
    return [
        str(record["trigger"])
        for record in records
    ]
