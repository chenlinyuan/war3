# -*- coding: utf-8 -*-
"""Build a Reforged-compatible campaign using a working chapter container.

The source campaign's chapter archives are legacy 4 KiB-sector maps that the
current Reforged campaign loader refuses to launch.  A previously working
standalone build supplies the same chapters with 64 KiB sectors and the hidden
resource blocks expected by the loader.  This module keeps that container while
replacing every gameplay-bearing map entry with data from the clean source
pipeline.  No script or object data from the donor build is retained.
"""
from __future__ import annotations

import argparse
import os
import struct
import tempfile
from pathlib import Path

import campaign_singleplayer as CS
import mpq_patch as MP
import war3mpq as W

from .chapter_rules import MANIFEST

CONTAINER_CONFIG = dict(MANIFEST["compatibility_container"])
REPLACE_INTERNALS = tuple(CONTAINER_CONFIG["replace_entries"])


def replace_from_clean(
    donor_map: bytes,
    clean_map: bytes,
    destination: Path,
) -> list[str]:
    with tempfile.TemporaryDirectory(prefix="warsong-container-") as temporary:
        root = Path(temporary)
        donor_path = root / "donor.map"
        clean_path = root / "clean.map"
        donor_path.write_bytes(donor_map)
        clean_path.write_bytes(clean_map)
        donor = W.MPQArchive(str(donor_path))
        clean = W.MPQArchive(str(clean_path))
        try:
            source_names = set(clean.listfile or ())
            patches = [
                (name, clean.read_file(name))
                for name in REPLACE_INTERNALS
                if name in source_names and clean.read_file(name) is not None
            ]
        finally:
            donor.close()
            clean.close()
        # The donor container's legacy checksums no longer match replaced data.
        if not any(name == "(attributes)" for name, _data in patches):
            patches.append(("(attributes)", struct.pack("<II", 100, 0)))
        MP.patch(
            str(donor_path),
            patches,
            out_path=str(destination),
            backup=False,
            compact=False,
        )
        CS.clear_platform_flags(destination)
        check = W.MPQArchive(str(destination))
        try:
            for name, data in patches:
                if check.read_file(name) != data:
                    raise CS.BuildError(
                        "hybrid chapter read-back mismatch: " + name
                    )
        finally:
            check.close()
        return [name for name, _data in patches]


def containerize_chapter(donor_map: bytes, clean_map: bytes) -> bytes:
    """Return one Reforged-loadable chapter container with clean data."""
    with tempfile.TemporaryDirectory(prefix="warsong-chapter-") as temporary:
        root = Path(temporary)
        destination = root / "chapter.map"
        replace_from_clean(donor_map, clean_map, destination)
        return destination.read_bytes()


def build(
    clean_campaign: Path,
    donor_campaign: Path,
    clean_work: Path,
    output: Path,
) -> None:
    clean_campaign = clean_campaign.resolve()
    donor_campaign = donor_campaign.resolve()
    clean_work = clean_work.resolve()
    output = output.resolve()
    identity = CS.campaign_identity(clean_campaign)
    clean_outer = W.MPQArchive(str(clean_campaign))
    donor_outer = W.MPQArchive(str(donor_campaign))
    hybrids: list[tuple[str, bytes]] = []
    try:
        for chapter in identity.chapters:
            clean_bytes = clean_outer.read_file(chapter)
            donor_bytes = donor_outer.read_file(chapter)
            if not clean_bytes or not donor_bytes:
                raise CS.BuildError("missing hybrid chapter: " + chapter)
            clean_fixed = clean_work / "chapters" / "fixed" / chapter
            if not clean_fixed.is_file():
                raise CS.BuildError(
                    "missing fixed clean chapter: " + str(clean_fixed)
                )
            temporary = output.parent / (".hybrid-" + Path(chapter).name)
            temporary.unlink(missing_ok=True)
            try:
                replaced = replace_from_clean(
                    donor_bytes,
                    clean_fixed.read_bytes(),
                    temporary,
                )
                hybrids.append((chapter, temporary.read_bytes()))
                print(
                    "%s: donor container + %d clean entries"
                    % (chapter, len(replaced)),
                    flush=True,
                )
            finally:
                temporary.unlink(missing_ok=True)
    finally:
        clean_outer.close()
        donor_outer.close()

    output.parent.mkdir(parents=True, exist_ok=True)
    title = identity.title + "（重制容器兼容版）"
    handle, temporary_name = tempfile.mkstemp(
        prefix=".container-campaign-",
        suffix=".w3n",
        dir=output.parent,
    )
    os.close(handle)
    temporary = Path(temporary_name)
    try:
        source = W.MPQArchive(str(clean_campaign))
        try:
            source_w3f = source.read_file("war3campaign.w3f") or b""
        finally:
            source.close()
        patches = list(hybrids)
        patches.append(
            ("war3campaign.w3f", CS.patch_w3f_title(source_w3f, title))
        )
        CS.add_attributes_patch(patches, clean_campaign)
        MP.patch(
            str(clean_campaign),
            patches,
            out_path=str(temporary),
            backup=False,
            store=[name for name, _data in hybrids],
            compact=False,
        )
        CS.clear_platform_flags(temporary)
        CS.patch_hm3w_title(temporary, title)
        storm = CS.storm_subarchive_check(
            temporary,
            [name for name, _data in hybrids],
        )
        if not storm["ok"]:
            raise CS.BuildError(
                "Storm opened %d/%d hybrid chapters"
                % (storm["opened"], storm["expected"])
            )
        os.replace(temporary, output)
    finally:
        temporary.unlink(missing_ok=True)


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--clean-campaign", type=Path, required=True)
    parser.add_argument("--donor-campaign", type=Path, required=True)
    parser.add_argument("--clean-work", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    build(
        args.clean_campaign,
        args.donor_campaign,
        args.clean_work,
        args.output,
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
