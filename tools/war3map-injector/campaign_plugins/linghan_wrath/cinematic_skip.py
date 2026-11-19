# -*- coding: utf-8 -*-
"""Restore Linghan chapter 2's authored cinematic skip window."""
from __future__ import annotations

import re

from .chapter_rules import (
    SKIP_AUTHORED_VALUE,
    SKIP_BROKEN_VALUE,
    SKIP_CONDITION,
    SKIP_FLAG,
)


DISABLED_MARKER = "// IB: linghan authored cinematic skip window"
RX_FUNCTION = re.compile(
    r"(?m)^function\s+(?P<name>\w+)\s+takes\b"
)
RX_BROKEN = re.compile(
    r"(?m)^(?P<indent>[ \t]*)return[ \t]+"
    + re.escape(SKIP_FLAG)
    + r"\s*!=\s*"
    + str(SKIP_BROKEN_VALUE)
    + r"[ \t]*(?://[^\r\n]*)?(?P<eol>\r\n|\n|\r|$)"
)
RX_AUTHORED = re.compile(
    r"(?m)^(?P<indent>[ \t]*)return[ \t]+"
    + re.escape(SKIP_FLAG)
    + r"\s*==\s*"
    + str(SKIP_AUTHORED_VALUE)
    + r"[ \t]*(?://[^\r\n]*)?(?P<eol>\r\n|\n|\r|$)"
)


def _function_span(text: str, name: str) -> tuple[int, int] | None:
    marks = [
        (match.start(), match.group("name"))
        for match in RX_FUNCTION.finditer(text)
    ]
    for index, (start, current) in enumerate(marks):
        if current != name:
            continue
        end = marks[index + 1][0] if index + 1 < len(marks) else len(text)
        return start, end
    return None


def _condition_body(text: str) -> str | None:
    span = _function_span(text, SKIP_CONDITION)
    if span is None:
        return None
    return text[span[0]:span[1]]


def state(text: str) -> str:
    """Return ``broken``, ``authored``, or ``missing`` for the skip gate."""
    body = _condition_body(text)
    if body is None:
        return "missing"
    if RX_BROKEN.search(body):
        return "broken"
    if RX_AUTHORED.search(body):
        return "authored"
    return "missing"


def patch(text: str) -> tuple[str, list[dict[str, object]]]:
    span = _function_span(text, SKIP_CONDITION)
    if span is None:
        raise RuntimeError(
            "linghan chapter 2 skip condition function was not found"
        )

    start, end = span
    body = text[start:end]
    broken = list(RX_BROKEN.finditer(body))
    authored = list(RX_AUTHORED.finditer(body))
    if not broken and len(authored) == 1:
        return text, []
    if len(broken) != 1:
        raise RuntimeError(
            "linghan chapter 2 expected one broken skip condition, found %d"
            % len(broken)
        )

    match = broken[0]
    replacement = (
        match.group("indent")
        + "return "
        + SKIP_FLAG
        + " == "
        + str(SKIP_AUTHORED_VALUE)
        + " "
        + DISABLED_MARKER
        + (match.group("eol") or "\n")
    )
    absolute_start = start + match.start()
    absolute_end = start + match.end()
    output = text[:absolute_start] + replacement + text[absolute_end:]
    return output, [
        {
            "rule": "linghan-authored-cinematic-skip-window-restored",
            "condition_function": SKIP_CONDITION,
            "flag": SKIP_FLAG,
            "before": "%s != %d" % (SKIP_FLAG, SKIP_BROKEN_VALUE),
            "after": "%s == %d" % (SKIP_FLAG, SKIP_AUTHORED_VALUE),
        }
    ]


def verify(text: str) -> list[str]:
    current = state(text)
    if current == "broken":
        return ["chapter2-skip-window-still-inverted"]
    if current != "authored":
        return ["chapter2-authored-skip-window-missing"]
    return []
