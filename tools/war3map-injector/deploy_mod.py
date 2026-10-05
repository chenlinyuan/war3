"""Deploy an injected map to H:\\Games\\War3\\Maps\\mod, removing previous versions.

Usage:
    python deploy_mod.py <map_path> <dest_name>

Removes any existing files in the mod dir whose name starts with the same
base (before "_vN" / "_item" suffix) so only the newest is present.
"""
import os
import re
import shutil
import sys

MOD_DIR = r"H:\Games\War3\Maps\mod"


def main():
    if len(sys.argv) < 3:
        print(__doc__)
        return 1
    src = os.path.abspath(sys.argv[1])
    dest_name = sys.argv[2]
    if not os.path.isfile(src):
        print("map not found:", src)
        return 1

    os.makedirs(MOD_DIR, exist_ok=True)

    # Base name = dest without version suffix like _v3 / _item / _item_v3
    base = re.sub(r"(_item)?(_v\d+)?(\.[^.]+)$", "", dest_name)
    ext = os.path.splitext(dest_name)[1]

    # Remove existing files with the same base
    removed = []
    for fn in os.listdir(MOD_DIR):
        if fn == dest_name:
            continue
        stem = os.path.splitext(fn)[0]
        if stem == base or stem.startswith(base + "_"):
            try:
                os.remove(os.path.join(MOD_DIR, fn))
                removed.append(fn)
            except Exception as e:
                print("  could not remove %s: %s" % (fn, e))

    dest = os.path.join(MOD_DIR, dest_name)
    shutil.copy2(src, dest)
    print("deployed:", dest, os.path.getsize(dest))
    for r in removed:
        print("removed old:", r)
    return 0


if __name__ == "__main__":
    sys.exit(main())
