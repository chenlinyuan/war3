# -*- coding: utf-8 -*-
"""Source-SHA-locked campaign repair plugins.

Each subdirectory is an independent campaign bundle with a ``manifest.json``
and a Python package exposing ``patch(text, chapter)`` and
``verify(text, stats)``.  Shared campaign tooling only discovers these
bundles; it does not infer one campaign's rules from another.
"""
from __future__ import annotations

import importlib
import json
from dataclasses import dataclass
from pathlib import Path
from types import ModuleType
from typing import Callable, Iterable


HERE = Path(__file__).resolve().parent


@dataclass(frozen=True)
class CampaignPlugin:
    """A loaded campaign bundle and its SHA-locked manifest."""

    name: str
    directory_name: str
    manifest: dict[str, object]
    module: ModuleType

    @property
    def source_sha256(self) -> str:
        return str(self.manifest["source_sha256"])

    @property
    def title(self) -> str:
        return str(self.manifest["title"])

    @property
    def key_policy(self) -> dict[str, object]:
        return dict(self.manifest.get("key_policy") or {})

    @property
    def patch(self) -> Callable[[str, str], tuple[str, dict[str, object]]]:
        return self.module.patch

    @property
    def verify(self) -> Callable[[str, dict[str, object]], list[str]]:
        return self.module.verify


def _load_plugin(directory: Path) -> CampaignPlugin:
    manifest_path = directory / "manifest.json"
    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    name = str(manifest.get("name") or "").strip()
    source_sha256 = str(manifest.get("source_sha256") or "").strip().casefold()
    if not name or len(source_sha256) != 64:
        raise RuntimeError("invalid campaign plugin manifest: %s" % manifest_path)
    module = importlib.import_module("%s.%s" % (__name__, directory.name))
    if not callable(getattr(module, "patch", None)):
        raise RuntimeError("%s does not expose patch()" % module.__name__)
    if not callable(getattr(module, "verify", None)):
        raise RuntimeError("%s does not expose verify()" % module.__name__)
    return CampaignPlugin(
        name=name,
        directory_name=directory.name,
        manifest=manifest,
        module=module,
    )


def _discover() -> tuple[CampaignPlugin, ...]:
    plugins = tuple(
        _load_plugin(manifest.parent)
        for manifest in sorted(HERE.glob("*/manifest.json"))
    )
    names = [plugin.name for plugin in plugins]
    hashes = [plugin.source_sha256 for plugin in plugins]
    if len(names) != len(set(names)):
        raise RuntimeError("duplicate campaign plugin names: %s" % names)
    if len(hashes) != len(set(hashes)):
        raise RuntimeError("duplicate campaign source SHA-256 values: %s" % hashes)
    return plugins


PLUGINS = _discover()
_BY_NAME = {plugin.name: plugin for plugin in PLUGINS}
_BY_SOURCE = {plugin.source_sha256: plugin for plugin in PLUGINS}


def for_name(name: str | None) -> CampaignPlugin | None:
    return _BY_NAME.get(name or "")


def for_source(source_sha256: str) -> CampaignPlugin | None:
    return _BY_SOURCE.get(source_sha256.casefold())


def all_plugins() -> Iterable[CampaignPlugin]:
    return PLUGINS
