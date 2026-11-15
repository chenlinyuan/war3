# -*- coding: utf-8 -*-
"""Small JASS function/trigger index used by repair and audit rules."""
from __future__ import annotations

import re
from dataclasses import dataclass


RX_FUNC = re.compile(r"(?m)^function\s+(\w+)\s+takes\s")
RX_INIT_COND = re.compile(
    r"TriggerAddCondition\(\s*(gg_trg_\w+)\s*,\s*"
    r"Condition\(function\s+(\w+)\)\)"
)
RX_INIT_ACT = re.compile(
    r"TriggerAddAction\(\s*(gg_trg_\w+)\s*,\s*function\s+(\w+)\)"
)
RX_REGISTER_EVENT = re.compile(
    r"TriggerRegister\w*\(\s*(gg_trg_\w+)\s*,\s*"
    r"(EVENT_[A-Z0-9_]+)"
)


@dataclass(frozen=True)
class JassProgram:
    """Function spans and trigger-to-handler maps for one JASS snapshot."""

    text: str
    spans: dict[str, tuple[int, int]]
    cond_of: dict[str, str]
    act_of: dict[str, str]
    events_of: dict[str, frozenset[str]]

    @classmethod
    def parse(cls, text: str) -> "JassProgram":
        marks = [
            (match.start(), match.group(1))
            for match in RX_FUNC.finditer(text)
        ]
        spans = {
            name: (
                start,
                marks[index + 1][0] if index + 1 < len(marks) else len(text),
            )
            for index, (start, name) in enumerate(marks)
        }
        events: dict[str, set[str]] = {}
        for match in RX_REGISTER_EVENT.finditer(text):
            events.setdefault(match.group(1), set()).add(match.group(2))
        return cls(
            text=text,
            spans=spans,
            cond_of={
                match.group(1): match.group(2)
                for match in RX_INIT_COND.finditer(text)
            },
            act_of={
                match.group(1): match.group(2)
                for match in RX_INIT_ACT.finditer(text)
            },
            events_of={
                trigger: frozenset(values)
                for trigger, values in events.items()
            },
        )

    def body(self, function: str) -> str:
        start, end = self.spans.get(function, (0, 0))
        return self.text[start:end]
