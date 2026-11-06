"""Shared artifact-style copy contract for the four ALAS wings."""

from __future__ import annotations

ARTIFACT_HEADER = "|cffff8c00神器|r|n|n"
PASSIVE_COLOR = "|cff5ddf26"
ACTIVE_COLOR = "|cff66ccff"
LORE_COLOR = "|cffffcc00"

WING_COPY = {
    "fallen": {
        "passives": ("闪避", "邪恶光环", "吸血光环"),
        "active": "主动·暗影庇护",
        "lore": "堕入深渊的天使仍以残翼守望黑夜。",
    },
    "seraph": {
        "passives": ("重生", "辉煌光环", "治疗光环"),
        "active": "主动·群体传送",
        "lore": "圣光从未遗忘献身者，黎明终会召回陨落之翼。",
    },
    "demon": {
        "passives": ("致命一击", "命令光环", "耐久光环"),
        "active": "主动·天神下凡",
        "lore": "恶魔从不无偿赐力，生命正是它索取的契约。",
    },
    "star": {
        "passives": ("献祭",),
        "active": "主动·灰烬雷暴",
        "lore": "星海熄灭之后，最后一道星魂仍在燃烧。",
    },
}

DEFAULT_WING_IDS = {
    "fallen": "I100",
    "seraph": "I101",
    "demon": "I102",
    "star": "I104",
}


def _text(value: object) -> str:
    if isinstance(value, bytes):
        return value.decode("utf-8", "replace").replace("\0", "")
    return str(value or "").replace("\0", "")


def _copy_issues(text: str, key: str, label: str) -> list[str]:
    spec = WING_COPY[key]
    issues: list[str] = []
    positions: list[int] = []
    for passive in spec["passives"]:
        position = text.find(PASSIVE_COLOR + passive)
        if position < 0:
            issues.append(
                f"{label}: passive colour/order missing {passive}"
            )
        positions.append(position)
    if positions != sorted(positions):
        issues.append(f"{label}: passive order is inconsistent")
    active = text.find(ACTIVE_COLOR + spec["active"])
    if active < 0:
        issues.append(f"{label}: active description is missing or uncoloured")
    elif positions and active < positions[-1]:
        issues.append(f"{label}: active description is before passives")
    if "|n|n|n" in text:
        issues.append(f"{label}: excessive blank lines")
    return issues


def wing_copy_failures(
    item_fields: dict[str, dict[str, object]],
    wing_ids: dict[str, str] | None = None,
) -> list[str]:
    """Validate item tooltip and description hierarchy for all four wings."""
    ids = dict(DEFAULT_WING_IDS)
    ids.update(wing_ids or {})
    issues: list[str] = []
    for key in WING_COPY:
        ident = ids[key]
        fields = item_fields.get(ident)
        if not fields:
            issues.append(f"{ident}: wing item is missing")
            continue
        tooltip = _text(fields.get("utub"))
        description = _text(fields.get("ides"))
        item_class = _text(fields.get("icla"))
        if item_class != "Artifact":
            issues.append(
                f"{ident}: item class is {item_class!r}, expected 'Artifact'"
            )
        if not tooltip.startswith(ARTIFACT_HEADER):
            issues.append(f"{ident}: tooltip lacks the artifact header")
        if "魔器" in tooltip:
            issues.append(f"{ident}: tooltip still uses the relic header")
        if tooltip.count(ARTIFACT_HEADER) != 1:
            issues.append(f"{ident}: artifact header count is not 1")
        issues.extend(_copy_issues(tooltip, key, f"{ident}.utub"))
        issues.extend(_copy_issues(description, key, f"{ident}.ides"))
        lore = LORE_COLOR + WING_COPY[key]["lore"]
        if tooltip.count(lore) != 1:
            issues.append(f"{ident}: gold lore is missing or duplicated")
        elif tooltip.rfind(lore) < tooltip.rfind(ACTIVE_COLOR):
            issues.append(f"{ident}: gold lore is not after the active block")
    return issues
