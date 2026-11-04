#!/usr/bin/env python3
"""Build the save-compatible chapter with only the requested aura fix."""

import os
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
INJECTOR = os.path.join(ROOT, "tools", "war3map-injector")
DOCTOR_ROOT = os.path.join(
    ROOT,
    "tools",
    "_devos-map-doctor",
    "devos-map-doctor-main",
)
sys.path.insert(0, INJECTOR)
sys.path.insert(0, DOCTOR_ROOT)

import mpq_patch  # noqa: E402
import war3mpq  # noqa: E402
from patch_forsaken_wing_auras import patch_w3a  # noqa: E402


def main():
    if len(sys.argv) != 3:
        raise SystemExit(
            "usage: build_save_compatible_chapter.py INPUT_MAP OUTPUT_MAP"
        )
    source, destination = sys.argv[1:]
    if os.path.exists(destination):
        raise SystemExit("output already exists: " + destination)

    archive = war3mpq.MPQArchive(source)
    try:
        old_aura = archive.read_file("war3map.w3a")
    finally:
        archive.close()
    if not old_aura:
        raise SystemExit("war3map.w3a is missing")

    fixed_aura = patch_w3a(old_aura)
    mpq_patch.patch(
        source,
        [("war3map.w3a", fixed_aura)],
        out_path=destination,
        backup=False,
    )

    before = war3mpq.MPQArchive(source)
    after = war3mpq.MPQArchive(destination)
    try:
        if after.read_file("war3map.w3a") != fixed_aura:
            raise SystemExit("w3a read-back mismatch")
        if after.read_file("war3map.lua") != before.read_file("war3map.lua"):
            raise SystemExit("war3map.lua changed unexpectedly")
    finally:
        before.close()
        after.close()
    print("built", destination, len(fixed_aura), "bytes w3a")


if __name__ == "__main__":
    main()
