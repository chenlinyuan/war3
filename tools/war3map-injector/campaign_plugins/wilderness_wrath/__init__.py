# -*- coding: utf-8 -*-
"""Independent repair bundle for 209521 荒野之怒."""
from .object_patch import patch_objects, verify_objects
from .patch import patch, verify


__all__ = ("patch", "patch_objects", "verify", "verify_objects")
