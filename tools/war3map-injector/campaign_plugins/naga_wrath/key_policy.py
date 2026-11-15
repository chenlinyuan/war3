# -*- coding: utf-8 -*-
"""Explicit platform-key policy for Naga Wrath."""
from __future__ import annotations

import json
from pathlib import Path


MANIFEST = json.loads(
    Path(__file__).with_name("manifest.json").read_text(encoding="utf-8")
)
POLICY = dict(MANIFEST["key_policy"])
MALL_TRUE = frozenset(str(value) for value in POLICY["true"])
MALL_FALSE = frozenset(str(value) for value in POLICY["false"])
MALL_DEFAULT_TRUE = bool(POLICY["default"])

if MALL_TRUE & MALL_FALSE:
    raise RuntimeError("naga-wrath mall key policy overlaps")
