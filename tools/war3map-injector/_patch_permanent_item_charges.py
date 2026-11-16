# -*- coding: utf-8 -*-
"""Normalize charge counts on permanent active equipment.

The campaign family reuses consumable item bases for permanent artifacts.
Those items inherit finite ``iuse`` values and disappear after a few uses.
This patch classifies item objects by name/description and active ability
metadata, while keeping potions, scrolls, food and other consumables finite.
"""
from __future__ import annotations

import re

from doctor.data import objects as OBJ


ZERO_END = b"\0\0\0\0"
PERMANENT_TOKENS = (
    "神器",
    "唯一",
    "套装",
    "军团",
    "手环",
    "护腕",
    "之戒",
    "戒指",
    "项链",
    "王冠",
    "头盔",
    "胸甲",
    "战甲",
    "披风",
    "战靴",
    "法杖",
    "之眼",
    "之冠",
    "之力",
    "之心",
    "之魂",
    "之刃",
    "之弓",
    "之剑",
    "之斧",
    "之盾",
    "图腾",
    "圣物",
)
CONSUMABLE_TOKENS = (
    "药水",
    "药液",
    "药",
    "烈酒",
    "卷轴",
    "地雷",
    "月饼",
    "偷桃",
    "桃子",
    "奶液",
    "美食",
    "钱偿",
    "肉债",
    "饵料",
    "材料",
    "碎片",
    "强化石",
    "回收",
    "魔章",
    "十字章",
)
DISAPPEAR_TOKENS = (
    "使用后消失",
    "使用后消耗",
    "消耗品",
    "剩余次数",
)
COLOR_TAG = re.compile(r"\|c[0-9a-fA-F]{8}|\|r", re.I)


def _text(value: object) -> str:
    if isinstance(value, bytes):
        value = value.decode("utf-8", "replace")
    return COLOR_TAG.sub("", str(value or "")).replace("\0", "").strip()


def _field_text(mods: object, field: str) -> str:
    values = [mod[4] for mod in mods if mod[0] == field]
    return _text(values[-1]) if values else ""


def _iuse(mods: object) -> int | None:
    values = [mod[4] for mod in mods if mod[0] == "iuse"]
    return int(values[-1]) if values else None


def _set_iuse_zero(mods: object) -> tuple[object, bool]:
    output = OBJ.Mods()
    changed = False
    found = False
    for mod in mods:
        updated = tuple(mod)
        if updated[0] == "iuse":
            found = True
            if updated[4] != 0:
                updated = updated[:4] + (0,) + updated[5:]
                changed = True
        output.append(updated)
    if not found:
        output.append(("iuse", 0, 0, 0, 0, ZERO_END))
        changed = True
    output = OBJ.with_item_sets(output, mods)
    return output, changed


def _classification(mods: object) -> tuple[bool, str]:
    name = _field_text(mods, "unam")
    description = " ".join(
        _field_text(mods, field)
        for field in ("ides", "utip", "utub")
    )
    active = _field_text(mods, "iabi")
    combined = name + " " + description
    if not active:
        return False, "no-active-ability"
    if any(token in combined for token in DISAPPEAR_TOKENS):
        return False, "explicit-consumable"
    permanent = next(
        (token for token in PERMANENT_TOKENS if token in combined),
        "",
    )
    consumable = next(
        (token for token in CONSUMABLE_TOKENS if token in combined),
        "",
    )
    if permanent and (not consumable or permanent in name):
        return True, "permanent:" + permanent
    if consumable:
        return False, "consumable:" + consumable
    return False, "unclassified"


def patch(data: bytes, extension: str) -> tuple[bytes, list[dict[str, object]]]:
    if extension.lower().lstrip(".") != "w3t":
        return data, []
    version, entries, consumed = OBJ.read_objects_bytes(
        data,
        False,
        fname="war3map.w3t",
        with_end=True,
    )
    records: list[dict[str, object]] = []
    objects = []
    for table, original, new, mods in entries:
        object_id = new.replace("\0", "") or original.replace("\0", "")
        is_permanent, reason = _classification(mods)
        current = _iuse(mods)
        name = _field_text(mods, "unam")
        if current is None and "军团手环" not in name:
            objects.append((table, original, new, mods))
            continue
        if not is_permanent or current == 0:
            objects.append((table, original, new, mods))
            continue
        updated, _changed = _set_iuse_zero(mods)
        objects.append((table, original, new, updated))
        records.append(
            {
                "rule": "permanent-item-charges",
                "item": object_id,
                "name": name,
                "previous": current,
                "reason": reason,
            }
        )
    output = OBJ.write_objects_bytes(version, objects, False)
    if consumed != len(data) and data[consumed:].strip(b"\0"):
        output += data[consumed:]
    return output, records


def verify(
    data: bytes,
    extension: str,
    records: list[dict[str, object]],
) -> list[str]:
    if extension.lower().lstrip(".") != "w3t" or not records:
        return []
    _version, entries, _consumed = OBJ.read_objects_bytes(
        data,
        False,
        fname="war3map.w3t",
        with_end=True,
    )
    expected = {str(record["item"]) for record in records}
    problems = []
    for _table, original, new, mods in entries:
        object_id = new.replace("\0", "") or original.replace("\0", "")
        if object_id in expected and _iuse(mods) != 0:
            problems.append(object_id + ":" + repr(_iuse(mods)))
    return problems
