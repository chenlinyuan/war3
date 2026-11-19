# -*- coding: utf-8 -*-
"""Campaign-level compatibility profiles shared by all chapter builds."""
from __future__ import annotations

from dataclasses import dataclass

import campaign_plugins as CAMPAIGN_PLUGINS


@dataclass(frozen=True)
class CampaignProfile:
    name: str
    source_sha256: str
    mall_false: tuple[str, ...] = ()
    mall_true: tuple[str, ...] = ()
    mall_default_true: bool = True


def _plugin_profiles() -> tuple[CampaignProfile, ...]:
    profiles: list[CampaignProfile] = []
    for plugin in CAMPAIGN_PLUGINS.all_plugins():
        policy = plugin.key_policy
        if not policy:
            continue
        for source_sha256 in plugin.source_sha256s:
            profiles.append(
                CampaignProfile(
                    name=plugin.name,
                    source_sha256=source_sha256,
                    mall_false=tuple(str(value) for value in policy.get("false", ())),
                    mall_true=tuple(str(value) for value in policy.get("true", ())),
                    mall_default_true=bool(policy.get("default", False)),
                )
            )
    return tuple(profiles)


PROFILES = _plugin_profiles()


def for_source(source_sha256: str) -> CampaignProfile | None:
    digest = source_sha256.casefold()
    return next(
        (profile for profile in PROFILES if profile.source_sha256.casefold() == digest),
        None,
    )
