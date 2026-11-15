# -*- coding: utf-8 -*-
"""Repair author-side campaign cache handoffs.

Some KK campaigns use a mall marker as an anti-cheat sentinel around a
``SaveGameCache`` block.  When the marker is true, the branch writes
placeholder units into the cache consumed by the next chapter.  In the
wilderness-wrath campaign this replaces the real hero cache with ``hkni``
units on ``shouwang02``.

Conversely, several later chapters gate legitimate hero cache saves on a paid
skin key.  With a strict mall whitelist those blocks would not run, leaving the
next chapter without a hero.

Only marker-gated blocks that store units into a ``shouwang`` cache are
touched: placeholder writes are disabled and legitimate handoffs are made
unconditional.
"""
from __future__ import annotations

import re
from dataclasses import dataclass


@dataclass(frozen=True)
class CacheHandoffBlock:
    key: str
    placeholder: str
    cache_name: str


RULES = (
    CacheHandoffBlock(
        key="WS6S6S",
        placeholder="set udg_zhujue = gg_unit_hkni_",
        cache_name="shouwang02",
    ),
)

SAFE_CACHE_CALLS = frozenset(
    (
        "InitGameCacheBJ",
        "StoreUnitBJ",
        "StoreInteger",
        "SaveGameCache",
        "DoNothing",
    )
)


def _calls_are_cache_only(body: str) -> bool:
    calls = re.findall(
        r"(?m)^[ \t]*call[ \t]+([A-Za-z_][A-Za-z0-9_]*)\s*\(",
        body,
    )
    return all(call in SAFE_CACHE_CALLS for call in calls)

RX_MARKER_IF = re.compile(
    r'(?m)^(?P<indent>[ \t]*)if[ \t]+DzAPI_Map_HasMallItem\('
    r'[^,\r\n]+,[ \t]*"(?P<key>[^"]+)"[ \t]*\)[ \t]*==[ \t]*true'
    r'[ \t]+then[ \t]*\r?\n'
)
RX_ENDIF = re.compile(r"(?m)^(?P<indent>[ \t]*)endif[ \t]*(?://[^\r\n]*)?\r?$")


def _block_end(text: str, start: int, indent: str) -> int | None:
    """Return the end offset of the first same-indent ``endif`` line."""
    for match in RX_ENDIF.finditer(text, start):
        if match.group("indent") == indent:
            return match.end()
    return None


def patch(text: str) -> tuple[str, list[dict[str, object]]]:
    """Repair campaign handoff cache blocks and return change records."""
    records: list[dict[str, object]] = []
    edits: list[tuple[int, int, str]] = []
    for match in RX_MARKER_IF.finditer(text):
        key = match.group("key")
        end = _block_end(text, match.end(), match.group("indent"))
        if end is None:
            continue
        body = text[match.end():end]
        if (
            'InitGameCacheBJ("shouwang' not in body
            or "StoreUnitBJ(" not in body
            or "call SaveGameCache(" not in body
        ):
            continue
        matched_rules = [
            rule
            for rule in RULES
            if key == rule.key
            and 'InitGameCacheBJ("%s")' % rule.cache_name in body
            and rule.placeholder in body
        ]
        if matched_rules:
            rule = matched_rules[0]
            mode = "disable-placeholder"
            value = "false"
            comment = "IB: cache placeholder write disabled (%s)" % rule.key
            record = {
                "rule": "placeholder-cache-handoff",
                "key": rule.key,
                "cache": rule.cache_name,
                "placeholder": rule.placeholder,
                "mode": mode,
                "line": text.count("\n", 0, match.start()) + 1,
            }
        else:
            if not _calls_are_cache_only(body):
                continue
            mode = "force-real-handoff"
            value = "true"
            comment = "IB: preserve campaign unit cache handoff (%s)" % key
            record = {
                "rule": "real-unit-cache-handoff",
                "key": key,
                "stores": body.count("StoreUnitBJ("),
                "mode": mode,
                "line": text.count("\n", 0, match.start()) + 1,
            }
        replacement = (
            match.group("indent")
            + "if "
            + value
            + " then // "
            + comment
            + ("\r\n" if "\r\n" in match.group(0) else "\n")
        )
        edits.append((match.start(), match.end(), replacement))
        records.append(record)

    output = text
    for start, end, replacement in sorted(edits, reverse=True):
        output = output[:start] + replacement + output[end:]
    return output, records


def verify(text: str, records: list[dict[str, object]]) -> list[str]:
    """Return keys whose cache handoff has the wrong guard direction."""
    remaining: list[str] = []
    for match in RX_MARKER_IF.finditer(text):
        end = _block_end(text, match.end(), match.group("indent"))
        if end is None:
            continue
        key = match.group("key")
        body = text[match.end():end]
        for record in records:
            if str(record["key"]) != key:
                continue
            mode = str(record["mode"])
            if mode == "force-real-handoff":
                # Real handoffs deliberately leave side-effect-bearing blocks
                # under their original guard.  Later end-call neutralization
                # can make such a block look cache-only to a second pass, so
                # verification is limited to the placeholder safety rule.
                continue
            elif mode == "disable-placeholder":
                cache_name = str(record["cache"])
                placeholder = str(record["placeholder"])
                if (
                    'InitGameCacheBJ("%s")' % cache_name in body
                    and placeholder in body
                ):
                    remaining.append(key)
    return sorted(set(remaining))
