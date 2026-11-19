# -*- coding: utf-8 -*-
"""Campaign-specific script repairs for Blood Mission 2.07."""
from __future__ import annotations

import re


CHAPTER_3 = "c3.w3x"
CHAPTER_18 = "c18.w3x"
MOVESWORD_CHAPTERS = frozenset(
    {
        "c3.w3x",
        "c4.w3x",
        "c6.w3x",
        "c7.w3x",
        "c8.w3x",
        "c10.w3x",
        "c11.w3x",
        "c12.w3x",
        "c13.w3x",
        "c14.w3x",
        "c15.w3x",
        "c18.w3x",
    }
)
REMOVE_ITEM = "BM_RemoveCampaignTaskItem"
DROP_ITEM = "BM_DropCampaignItemByType"
TASK_ACTIONS_HEADER = (
    "function Trig_orginsetActions takes nothing returns nothing"
)
MOVESWORD_ACTIONS_HEADER = (
    "function Trig_moveswordActions takes nothing returns nothing"
)
RX_SLOT_REMOVE = re.compile(
    r"(?m)^(?P<indent>[ \t]*)call[ \t]+"
    r"RemoveItem\(UnitItemInSlot\(udg_Jere,\s*(?P<slot>[01])\)\)"
    r"[^\r\n]*(?P<eol>\r\n|\n|\r|$)"
)
RX_MOVESWORD_DROP = re.compile(
    r"(?m)^(?P<indent>[ \t]*)call[ \t]+"
    r"UnitDropItemSlot\(udg_Jere,\s*"
    r"UnitItemInSlot\(udg_Jere,\s*1\),\s*0\)"
    r"[^\r\n]*(?P<eol>\r\n|\n|\r|$)"
)
RX_FINAL_AMULET_SLOT_REMOVE = re.compile(
    r"(?m)^(?P<indent>[ \t]*)call[ \t]+"
    r"RemoveItem\(UnitItemInSlot\(udg_Jere,\s*0\)\)"
    r"[^\r\n]*(?P<eol>\r\n|\n|\r|$)"
)
TASK_ITEM_BY_SLOT = {
    "0": "I62A",
    "1": "I629",
}
REMOVE_HELPER = """function BM_RemoveCampaignTaskItem takes unit u, integer itemId returns nothing
    local integer i = 0
    local integer bagSize = 0
    local item it
    if u == null or itemId == 0 then
        return
    endif
    loop
        exitwhen i > 5
        set it = UnitItemInSlot(u, i)
        if it != null and GetItemTypeId(it) == itemId then
            call RemoveItem(it)
            set it = null
        endif
        set i = i + 1
    endloop
    set bagSize = UnitExtendedInventorySize(u)
    set i = 0
    loop
        exitwhen i >= bagSize or i >= 30
        set it = UnitItemInBagSlot(u, i)
        if it != null and GetItemTypeId(it) == itemId then
            call RemoveItem(it)
            set it = null
        endif
        set i = i + 1
    endloop
    set i = 0
    loop
        exitwhen i >= 9
        set it = BlzUnitItemInEquipmentSlot(u, ConvertLoadoutSlot(i))
        if it != null and GetItemTypeId(it) == itemId then
            call RemoveItem(it)
            set it = null
        endif
        set i = i + 1
    endloop
    set it = null
endfunction

"""
DROP_HELPER = """function BM_DropCampaignItemByType takes unit u, integer itemId returns nothing
    local integer i = 0
    local integer bagSize = 0
    local item it
    if u == null or itemId == 0 then
        return
    endif
    loop
        exitwhen i > 5
        set it = UnitItemInSlot(u, i)
        if it != null and GetItemTypeId(it) == itemId then
            call UnitDropItemPoint(u, it, GetUnitX(u), GetUnitY(u))
            set it = null
            return
        endif
        set i = i + 1
    endloop
    set bagSize = UnitExtendedInventorySize(u)
    set i = 0
    loop
        exitwhen i >= bagSize or i >= 30
        set it = UnitItemInBagSlot(u, i)
        if it != null and GetItemTypeId(it) == itemId then
            call UnitDropItemPoint(u, it, GetUnitX(u), GetUnitY(u))
            set it = null
            return
        endif
        set i = i + 1
    endloop
    set i = 0
    loop
        exitwhen i >= 9
        set it = BlzUnitItemInEquipmentSlot(u, ConvertLoadoutSlot(i))
        if it != null and GetItemTypeId(it) == itemId then
            call UnitDropItemPoint(u, it, GetUnitX(u), GetUnitY(u))
            set it = null
            return
        endif
        set i = i + 1
    endloop
    set it = null
endfunction

"""


def _chapter_key(chapter: str) -> str:
    return chapter.replace("\\", "/").rsplit("/", 1)[-1].casefold()


def _patch_task_item_cleanup(
    text: str,
    chapter: str,
) -> tuple[str, list[dict[str, object]]]:
    if _chapter_key(chapter) != CHAPTER_3:
        return text, []
    output, count = RX_SLOT_REMOVE.subn(
        lambda match: (
            match.group("indent")
            + "call "
            + REMOVE_ITEM
            + "(udg_Jere, '"
            + TASK_ITEM_BY_SLOT[match.group("slot")]
            + "')"
            + (match.group("eol") or "\n")
        ),
        text,
    )
    if not count:
        return output, []
    return output, [
        {
            "rule": "blood-mission-task-items-by-id",
            "chapter": CHAPTER_3,
            "replaced_slot_removals": count,
            "items": ["I62A", "I629"],
        }
    ]


def _patch_movesword_drop(
    text: str,
    chapter: str,
) -> tuple[str, list[dict[str, object]]]:
    key = _chapter_key(chapter)
    if key not in MOVESWORD_CHAPTERS:
        return text, []
    output, count = RX_MOVESWORD_DROP.subn(
        lambda match: (
            match.group("indent")
            + "call "
            + DROP_ITEM
            + "(udg_Jere, 'I627')"
            + (match.group("eol") or "\n")
        ),
        text,
    )
    if not count:
        return output, []
    return output, [
        {
            "rule": "blood-mission-movesword-by-item-id",
            "chapter": key,
            "replaced_slot_drops": count,
            "item": "I627",
        }
    ]


def _patch_final_amulet_remove(
    text: str,
    chapter: str,
) -> tuple[str, list[dict[str, object]]]:
    if _chapter_key(chapter) != CHAPTER_18:
        return text, []
    output, count = RX_FINAL_AMULET_SLOT_REMOVE.subn(
        lambda match: (
            match.group("indent")
            + "call "
            + REMOVE_ITEM
            + "(udg_Jere, 'I625')"
            + (match.group("eol") or "\n")
        ),
        text,
    )
    if not count:
        return output, []
    return output, [
        {
            "rule": "blood-mission-final-amulet-by-id",
            "chapter": CHAPTER_18,
            "replaced_slot_removals": count,
            "item": "I625",
        }
    ]


def _insert_helpers(
    text: str,
    chapter: str,
    *,
    needs_remove: bool,
    needs_drop: bool,
) -> str:
    if not needs_remove and not needs_drop:
        return text
    key = _chapter_key(chapter)
    header = (
        TASK_ACTIONS_HEADER
        if key == CHAPTER_3
        else MOVESWORD_ACTIONS_HEADER
    )
    if header not in text:
        raise ValueError(
            "Blood Mission action function is missing: " + key
        )
    helpers = ""
    if needs_remove and "function " + REMOVE_ITEM not in text:
        helpers += REMOVE_HELPER
    if needs_drop and "function " + DROP_ITEM not in text:
        helpers += DROP_HELPER
    return text.replace(header, helpers + header, 1)


def verify_campaign_item_rules(text: str, chapter: str) -> list[str]:
    key = _chapter_key(chapter)
    problems: list[str] = []
    if RX_MOVESWORD_DROP.search(text):
        problems.append("movesword-slot-based-drop")
    if key == CHAPTER_3:
        if RX_SLOT_REMOVE.search(text):
            problems.append("c3-slot-based-task-item-removal")
        if "function " + REMOVE_ITEM not in text:
            problems.append("c3-task-item-helper-missing")
        for item_id in ("I62A", "I629"):
            expected = (
                "call "
                + REMOVE_ITEM
                + "(udg_Jere, '"
                + item_id
                + "')"
            )
            if text.count(expected) < 2:
                problems.append(
                    "c3-task-item-cleanup-missing:" + item_id
                )
    if key in MOVESWORD_CHAPTERS:
        expected = "call " + DROP_ITEM + "(udg_Jere, 'I627')"
        if expected not in text:
            problems.append("movesword-item-drop-missing")
        if "function " + DROP_ITEM not in text:
            problems.append("movesword-drop-helper-missing")
    if key == CHAPTER_18:
        if RX_FINAL_AMULET_SLOT_REMOVE.search(text):
            problems.append("c18-slot-based-amulet-removal")
        expected = "call " + REMOVE_ITEM + "(udg_Jere, 'I625')"
        if expected not in text:
            problems.append("c18-amulet-remove-missing")
    return problems


def patch(
    text: str,
    chapter: str,
) -> tuple[str, dict[str, object]]:
    records: list[dict[str, object]] = []
    text, task_records = _patch_task_item_cleanup(text, chapter)
    records.extend(task_records)
    text, drop_records = _patch_movesword_drop(text, chapter)
    records.extend(drop_records)
    text, final_records = _patch_final_amulet_remove(text, chapter)
    records.extend(final_records)
    text = _insert_helpers(
        text,
        chapter,
        needs_remove=bool(task_records or final_records),
        needs_drop=bool(drop_records),
    )
    return text, {
        "campaign_patch": "blood-mission-qh-207",
        "campaign_patch_chapter": _chapter_key(chapter),
        "campaign_patch_count": len(records),
        "campaign_patch_records": records,
    }


def verify(
    text: str,
    stats: dict[str, object],
) -> list[str]:
    chapter = str(stats.get("campaign_patch_chapter") or "")
    return verify_campaign_item_rules(text, chapter)
