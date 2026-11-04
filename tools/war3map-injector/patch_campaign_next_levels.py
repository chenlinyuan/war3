# -*- coding: utf-8 -*-
"""Point campaign chapter scripts at maps embedded in the current .w3n.

Official campaign maps contain absolute next-level paths such as
``Maps\\\\Campaign\\\\Human02.w3m``.  If those maps are repackaged under new
names, the game silently falls back to the unmodified maps shipped in
War3.mpq, taking the injected systems out of the next chapter.
"""
import re
import sys

import war3mpq as W
import mpq_patch as MP


NEXT_LEVEL = re.compile(
    rb"Maps\\\\Campaign\\\\(Human[0-9]+(?:Interlude)?)\.w3m")


def patch_map(path):
    archive = W.MPQArchive(path)
    try:
        script = archive.read_file("war3map.j")
    finally:
        archive.close()
    if not script:
        raise RuntimeError("war3map.j not found: %s" % path)
    updated, count = NEXT_LEVEL.subn(
        lambda match: b"D" + match.group(1) + b".w3m", script)
    if not count:
        raise RuntimeError("no external Human campaign links found: %s" % path)
    if NEXT_LEVEL.search(updated):
        raise RuntimeError("external Human campaign links remain: %s" % path)
    MP.patch(path, [("war3map.j", updated)], out_path=None, backup=False)
    check = W.MPQArchive(path)
    try:
        if check.read_file("war3map.j") != updated:
            raise RuntimeError("read-back mismatch: %s" % path)
    finally:
        check.close()
    print("%s: %d chapter link(s) redirected" % (path, count))


def main():
    if len(sys.argv) < 2:
        raise SystemExit("usage: patch_campaign_next_levels.py MAP [...]")
    for path in sys.argv[1:]:
        patch_map(path)
    return 0


if __name__ == "__main__":
    sys.exit(main())
