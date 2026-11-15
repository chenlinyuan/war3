# -*- coding: utf-8 -*-
"""Explicit platform-key policy for 荒野之怒."""
from __future__ import annotations

from .chapter_rules import MANIFEST


POLICY = dict(MANIFEST["key_policy"])
MALL_TRUE = frozenset(str(value) for value in POLICY["true"])
MALL_FALSE = frozenset(str(value) for value in POLICY["false"])
MALL_DEFAULT_TRUE = bool(POLICY["default"])

if MALL_TRUE & MALL_FALSE:
    raise RuntimeError("wilderness-wrath mall key policy overlaps")
