"""Localize and brand official Reforged campaign metadata."""

from __future__ import annotations

from pathlib import Path

from doctor.data import campaign_info


ALAS_DESCRIPTION = (
    "由 ALAS 改图工具基于《魔兽争霸 III：重制版》"
    "3.0.1.24371 官方 CASC 原版章节地图整合制作。"
)

HUMAN_BUTTON_TITLES = {
    "human01.w3x": "第一章：斯坦恩布莱德的防守",
    "human02.w3x": "第二章：黑石与摇滚",
    "human02interlude.w3x": "过场：吉安娜的会面",
    "human03.w3x": "第三章：瘟疫的蹂躏",
    "human04.w3x": "第四章：诅咒教派",
    "human05.w3x": "第五章：天灾进军",
    "human05interlude.w3x": "过场：王子与先知",
    "human06.w3x": "第六章：屠城",
    "human06interlude.w3x": "过场：分道扬镳",
    "human07.w3x": "第七章：诺森德海岸",
    "human08.w3x": "第八章：决裂",
    "human09.w3x": "第九章：霜之哀伤",
}


def _map_name(value: bytes) -> str:
    return Path(value.decode("utf-8", "replace").replace("/", "\\")).name.lower()


def localized_chapter_title(internal: str, fallback: str) -> str:
    return HUMAN_BUTTON_TITLES.get(
        Path(internal.replace("/", "\\")).name.lower(),
        fallback,
    )


def _is_official(model: dict) -> bool:
    return any(
        "campaign\\reforged\\" in button.get("map", b"")
        .decode("utf-8", "replace")
        .replace("/", "\\")
        .lower()
        for button in model.get("buttons", [])
    )


def patch_w3f_bytes(data: bytes) -> bytes:
    """Patch literal chapter titles and ALAS authoring credit."""
    model = campaign_info.parse(data)
    buttons = model.get("buttons", [])
    if not _is_official(model):
        return data

    changed = False
    for button in buttons:
        title = HUMAN_BUTTON_TITLES.get(_map_name(button["map"]))
        if title is None:
            continue
        encoded = title.encode("utf-8")
        if button["title"] != encoded:
            button["title"] = encoded
            changed = True

    description = ALAS_DESCRIPTION.encode("utf-8")
    if model.get("description") != description:
        model["description"] = description
        changed = True

    if not changed:
        return data
    return campaign_info.write(model)


def verify_w3f_bytes(data: bytes) -> None:
    model = campaign_info.parse(data)
    if not _is_official(model):
        return
    for button in model.get("buttons", []):
        expected = HUMAN_BUTTON_TITLES.get(_map_name(button["map"]))
        if expected is not None and button["title"] != expected.encode("utf-8"):
            raise RuntimeError(
                "%s chapter title is not localized"
                % _map_name(button["map"])
            )
    if model.get("description") != ALAS_DESCRIPTION.encode("utf-8"):
        raise RuntimeError("ALAS campaign description was not written")
