# -*- coding: utf-8 -*-
"""Repair invalid units restored from a stale campaign game cache.

The wilderness-wrath chapter 4 anti-cheat branch can overwrite the real
``shouwang02`` hero record with a non-hero ``hkni`` placeholder.  Chapter 5
then restores that unit, triggering downstream null/death behavior and
dropping the cached inventory.

This module adds a narrow post-restore validator to chapter 5:

* replace a missing/non-hero main unit with the campaign's ``O60W`` hero;
* preserve the invalid placeholder's inventory before removing it;
* restore a missing companion ``O60M``;
* restore missing ``n609`` pets.

The hook is inserted only after the exact chapter-5 restore sequence.  Valid
cached heroes and pets are left unchanged.
"""
from __future__ import annotations


ANCHOR = "    set udg_chongwu02 = bj_lastLoadedUnit"
MARKER = "// IB: validate restored campaign units"

RESTORE_GUARD = r"""
    // IB: validate restored campaign units
    if udg_zhujue == null or IsUnitType(udg_zhujue, UNIT_TYPE_HERO) != true then
        set bj_lastCreatedUnit = CreateUnit(Player(0), 'O60W', GetRectCenterX(gg_rct______________000), GetRectCenterY(gg_rct______________000), 266.0)
        if udg_zhujue != null then
            if UnitItemInSlot(udg_zhujue, 0) != null then
                call UnitAddItem(bj_lastCreatedUnit, UnitRemoveItemFromSlot(udg_zhujue, 0))
            endif
            if UnitItemInSlot(udg_zhujue, 1) != null then
                call UnitAddItem(bj_lastCreatedUnit, UnitRemoveItemFromSlot(udg_zhujue, 1))
            endif
            if UnitItemInSlot(udg_zhujue, 2) != null then
                call UnitAddItem(bj_lastCreatedUnit, UnitRemoveItemFromSlot(udg_zhujue, 2))
            endif
            if UnitItemInSlot(udg_zhujue, 3) != null then
                call UnitAddItem(bj_lastCreatedUnit, UnitRemoveItemFromSlot(udg_zhujue, 3))
            endif
            if UnitItemInSlot(udg_zhujue, 4) != null then
                call UnitAddItem(bj_lastCreatedUnit, UnitRemoveItemFromSlot(udg_zhujue, 4))
            endif
            if UnitItemInSlot(udg_zhujue, 5) != null then
                call UnitAddItem(bj_lastCreatedUnit, UnitRemoveItemFromSlot(udg_zhujue, 5))
            endif
            call RemoveUnit(udg_zhujue)
        endif
        set udg_zhujue = bj_lastCreatedUnit
        call SetHeroLevel(udg_zhujue, 7, false)
    endif
    if udg_fujue == null or IsUnitType(udg_fujue, UNIT_TYPE_HERO) != true then
        set bj_lastCreatedUnit = CreateUnit(Player(0), 'O60M', GetRectCenterX(gg_rct______________001), GetRectCenterY(gg_rct______________001), 266.0)
        set udg_fujue = bj_lastCreatedUnit
        call SetHeroLevel(udg_fujue, 7, false)
    endif
    if udg_chongwu01 == null then
        set bj_lastCreatedUnit = CreateUnit(Player(0), 'n609', GetRectCenterX(gg_rct______________000), GetRectCenterY(gg_rct______________000), 180.0)
        set udg_chongwu01 = bj_lastCreatedUnit
    endif
    if udg_chongwu02 == null then
        set bj_lastCreatedUnit = CreateUnit(Player(0), 'n609', GetRectCenterX(gg_rct______________000), GetRectCenterY(gg_rct______________000), 180.0)
        set udg_chongwu02 = bj_lastCreatedUnit
    endif
""".replace("\n", "\r\n")


def _newline(text: str) -> str:
    return "\r\n" if "\r\n" in text else "\n"


def patch(text: str) -> tuple[str, dict[str, object]]:
    """Insert the chapter-5 restore validator once."""
    stats: dict[str, object] = {
        "restore_guards": 0,
        "restore_guard_reason": "not-applicable",
    }
    required = (
        'InitGameCacheBJ("shouwang02")',
        'RestoreUnitLocFacingAngleBJ("zhu", "jue"',
        "gg_rct______________000",
        "'O60W'",
        "'O60M'",
        "'n609'",
    )
    if not all(value in text for value in required):
        return text, stats
    if MARKER in text:
        stats["restore_guard_reason"] = "already-present"
        return text, stats
    if text.count(ANCHOR) != 1:
        stats["restore_guard_reason"] = "anchor-count-%d" % text.count(ANCHOR)
        return text, stats

    newline = _newline(text)
    guard = RESTORE_GUARD
    if newline == "\n":
        guard = guard.replace("\r\n", "\n")
    replacement = ANCHOR + newline + guard.rstrip("\r\n")
    output = text.replace(ANCHOR, replacement, 1)
    stats["restore_guards"] = 1
    stats["restore_guard_reason"] = "inserted"
    return output, stats


def verify(text: str) -> list[str]:
    """Return reasons the chapter-5 restore validator is absent or broken."""
    problems: list[str] = []
    if MARKER not in text:
        return ["missing restore validator"]
    for token in (
        "CreateUnit(Player(0), 'O60W'",
        "CreateUnit(Player(0), 'O60M'",
        "CreateUnit(Player(0), 'n609'",
        "UnitRemoveItemFromSlot(udg_zhujue, 5)",
    ):
        if token not in text:
            problems.append("missing " + token)
    return problems
