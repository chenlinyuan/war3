# -*- coding: utf-8 -*-
"""Verified commerce whitelist for the Linghan repair bundle."""
from __future__ import annotations

from .chapter_rules import MANIFEST


POLICY = dict(MANIFEST["key_policy"])
MALL_DEFAULT_TRUE = bool(POLICY.get("default", False))
MALL_TRUE = frozenset(str(value) for value in POLICY.get("true", ()))
MALL_FALSE = frozenset(str(value) for value in POLICY.get("false", ()))
