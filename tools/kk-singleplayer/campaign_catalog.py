# -*- coding: utf-8 -*-
"""Filesystem and cache helpers for the campaign picker."""
from __future__ import annotations

import os
import re
from dataclasses import dataclass
from datetime import datetime
from pathlib import Path
from typing import Mapping


CAMPAIGN_SUFFIX = ".w3n"
COLOR_TAG = re.compile(r"\|c[0-9a-fA-F]{8}|\|r", re.I)


@dataclass(frozen=True)
class CampaignFile:
    path: Path
    size: int
    mtime_ns: int

    @property
    def filename(self) -> str:
        return self.path.name

    @property
    def modified_text(self) -> str:
        return datetime.fromtimestamp(self.mtime_ns / 1_000_000_000).strftime(
            "%Y-%m-%d %H:%M"
        )


def discover_campaign_files(
    source: Path,
    *,
    recursive: bool = True,
    excluded_directories: set[str] | frozenset[str] = frozenset(),
) -> list[CampaignFile]:
    source = Path(source).resolve()
    if source.is_file():
        candidates = [source] if source.suffix.casefold() == CAMPAIGN_SUFFIX else []
    elif source.is_dir():
        candidates = []
        if recursive:
            excluded = {name.casefold() for name in excluded_directories}
            for root, directories, filenames in os.walk(source):
                directories[:] = [
                    name
                    for name in directories
                    if name.casefold() not in excluded and not name.startswith(".")
                ]
                for filename in filenames:
                    path = Path(root) / filename
                    if path.suffix.casefold() == CAMPAIGN_SUFFIX:
                        candidates.append(path)
        else:
            candidates = [
                path
                for path in source.iterdir()
                if path.is_file() and path.suffix.casefold() == CAMPAIGN_SUFFIX
            ]
    else:
        return []

    result: list[CampaignFile] = []
    for path in sorted(candidates, key=lambda value: str(value).casefold()):
        try:
            stat = path.stat()
        except OSError:
            continue
        result.append(
            CampaignFile(
                path=path.resolve(),
                size=stat.st_size,
                mtime_ns=stat.st_mtime_ns,
            )
        )
    return result


def cache_record(
    info: CampaignFile,
    payload: Mapping[str, object],
) -> dict[str, object]:
    return {
        "mtime_ns": info.mtime_ns,
        "size": info.size,
        "payload": dict(payload),
    }


def cached_payload(
    cache: Mapping[str, object],
    info: CampaignFile,
) -> dict[str, object] | None:
    entry = cache.get(str(info.path))
    if not isinstance(entry, dict):
        return None
    if entry.get("mtime_ns") != info.mtime_ns or entry.get("size") != info.size:
        return None
    payload = entry.get("payload")
    return dict(payload) if isinstance(payload, dict) else None


def campaign_title(
    payload: Mapping[str, object] | None,
    fallback: str,
) -> str:
    title = str((payload or {}).get("title") or "").strip()
    title = COLOR_TAG.sub("", title).strip()
    return title or fallback


def row_values(
    info: CampaignFile,
    payload: Mapping[str, object] | None,
    status: str,
    source_root: Path,
) -> tuple[str, str, str, str, str, str]:
    try:
        display_path = str(info.path.relative_to(source_root))
    except ValueError:
        display_path = info.path.name
    chapters = payload.get("chapter_count", "") if payload else ""
    return (
        campaign_title(payload, info.path.stem),
        str(chapters) if chapters != "" else "—",
        format_size(info.size),
        info.modified_text,
        status,
        display_path,
    )


def format_size(value: int) -> str:
    size = float(max(0, value))
    if size >= 1024 ** 3:
        return "%.2f GiB" % (size / 1024 ** 3)
    if size >= 1024 ** 2:
        return "%.1f MiB" % (size / 1024 ** 2)
    if size >= 1024:
        return "%.1f KiB" % (size / 1024)
    return "%d B" % int(size)
