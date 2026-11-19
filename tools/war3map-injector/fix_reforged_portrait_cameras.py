# -*- coding: utf-8 -*-
"""Remove legacy portrait cameras that are unsafe in Reforged 3.0."""
from __future__ import annotations

import os
import tempfile
from pathlib import Path


def patch(map_path: Path) -> list[dict[str, object]]:
    """Fix portrait cameras in-place and return one record per changed model."""
    from doctor.models import model_check

    handle, temporary_name = tempfile.mkstemp(
        prefix=map_path.stem + "-portraits-",
        suffix=map_path.suffix,
        dir=map_path.parent,
    )
    os.close(handle)
    temporary = Path(temporary_name)
    temporary.unlink(missing_ok=True)
    try:
        result = model_check.fix(
            str(map_path),
            str(temporary),
            what=("portrait_camera",),
        )
        if result.get("state") == "failed":
            raise RuntimeError(
                "portrait-camera repair failed: "
                + str(result.get("error") or "unknown error")
            )
        if result.get("state") != "done":
            return []
        fixed = list(result.get("fixed") or ())
        if not fixed:
            return []
        os.replace(temporary, map_path)
        return [
            {
                "rule": "reforged-portrait-camera-removed",
                "file": str(item.get("file") or ""),
                "method": str(item.get("method") or ""),
            }
            for item in fixed
        ]
    finally:
        temporary.unlink(missing_ok=True)
