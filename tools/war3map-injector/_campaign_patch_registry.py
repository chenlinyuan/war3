# -*- coding: utf-8 -*-
"""Dispatch source-SHA-selected campaign plugin patches."""
from __future__ import annotations

import hashlib
import importlib
from pathlib import Path
from typing import Callable

import campaign_plugins as CAMPAIGN_PLUGINS


def apply(profile_name: str | None, text: str, chapter: str) -> tuple[str, dict[str, object]]:
    plugin = CAMPAIGN_PLUGINS.for_name(profile_name)
    if plugin is None:
        return text, {
            "campaign_patch": None,
            "campaign_patch_count": 0,
            "campaign_patch_records": [],
        }
    return plugin.patch(text, chapter)


def verify(
    profile_name: str | None,
    text: str,
    stats: dict[str, object],
) -> list[str]:
    plugin = CAMPAIGN_PLUGINS.for_name(profile_name)
    return plugin.verify(text, stats) if plugin is not None else []


def container_pipeline(
    profile_name: str | None,
) -> tuple[Path, Callable[[bytes, bytes], bytes]] | None:
    """Resolve a source-specific Reforged chapter container adapter."""
    plugin = CAMPAIGN_PLUGINS.for_name(profile_name)
    if plugin is None:
        return None
    config = plugin.manifest.get("compatibility_container")
    if not isinstance(config, dict):
        return None
    expected = str(config.get("donor_sha256") or "").casefold()
    donor = next(
        (
            Path(value)
            for value in config.get("search_paths", ())
            if Path(value).is_file()
        ),
        None,
    )
    if donor is None:
        raise RuntimeError(
            "compatibility container donor is missing for %s" % plugin.name
        )
    digest = hashlib.sha256()
    with donor.open("rb") as stream:
        for block in iter(lambda: stream.read(4 * 1024 * 1024), b""):
            digest.update(block)
    if digest.hexdigest().casefold() != expected:
        raise RuntimeError(
            "compatibility container donor SHA-256 mismatch: %s" % donor
        )
    container_module = importlib.import_module(
        plugin.module.__name__ + ".container_repair"
    )
    adapter = getattr(container_module, "containerize_chapter", None)
    if not callable(adapter):
        raise RuntimeError(
            "campaign plugin does not expose containerize_chapter(): %s"
            % plugin.name
        )
    return donor, adapter


def backpack_switch_ids(profile_name: str | None) -> set[str]:
    """Return the source-specific backpack-switch ability IDs."""
    plugin = CAMPAIGN_PLUGINS.for_name(profile_name)
    if plugin is None:
        return set()
    config = plugin.manifest.get("backpack_switch")
    if not isinstance(config, dict):
        return set()
    values = config.get("ability_ids", ())
    if isinstance(values, str):
        values = (values,)
    return {str(value) for value in values if str(value)}


def patch_objects(
    profile_name: str | None,
    data: bytes,
    extension: str,
    chapter: str,
) -> tuple[bytes, list[dict[str, object]]]:
    """Apply a source-specific object-data repair hook when declared."""
    plugin = CAMPAIGN_PLUGINS.for_name(profile_name)
    if plugin is None:
        return data, []
    patcher = getattr(plugin.module, "patch_objects", None)
    if not callable(patcher):
        return data, []
    return patcher(data, extension, chapter)


def verify_objects(
    profile_name: str | None,
    data: bytes,
    extension: str,
    chapter: str,
    stats: list[dict[str, object]],
) -> list[str]:
    """Verify a source-specific object-data repair hook when declared."""
    plugin = CAMPAIGN_PLUGINS.for_name(profile_name)
    if plugin is None:
        return []
    verifier = getattr(plugin.module, "verify_objects", None)
    if not callable(verifier):
        return []
    return verifier(data, extension, chapter, stats)
