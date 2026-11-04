# -*- coding: utf-8 -*-
"""Remove illegal return values from JASS functions that return nothing."""
import re
import sys

import war3mpq as W
import mpq_patch as MP


FUNCTION_VOID = re.compile(r"^\s*function\s+\w+\s+takes\b.*\breturns nothing\s*$")
ANY_FUNCTION = re.compile(r"^\s*function\b")
END_FUNCTION = re.compile(r"^\s*endfunction\s*$")
RETURN_VALUE = re.compile(r"^(\s*)return\s+[^\r\n]+([\r\n]*)$")


def fix_script(script):
    lines = script.decode("utf-8", "surrogateescape").splitlines(True)
    inside_void = False
    changed = 0
    for index, line in enumerate(lines):
        bare = line.rstrip("\r\n")
        if ANY_FUNCTION.match(bare):
            inside_void = bool(FUNCTION_VOID.match(bare))
            continue
        if inside_void and END_FUNCTION.match(bare):
            inside_void = False
            continue
        if inside_void:
            match = RETURN_VALUE.match(line)
            if match:
                lines[index] = match.group(1) + "return" + match.group(2)
                changed += 1
    return "".join(lines).encode("utf-8", "surrogateescape"), changed


def patch_map(path):
    archive = W.MPQArchive(path)
    try:
        script = archive.read_file("war3map.j")
    finally:
        archive.close()
    if not script:
        raise RuntimeError("war3map.j not found: %s" % path)
    updated, changed = fix_script(script)
    if not changed:
        print("%s: no invalid void returns" % path)
        return
    MP.patch(path, [("war3map.j", updated)], out_path=None, backup=False)
    check = W.MPQArchive(path)
    try:
        if check.read_file("war3map.j") != updated:
            raise RuntimeError("read-back mismatch: %s" % path)
    finally:
        check.close()
    print("%s: fixed %d invalid return(s)" % (path, changed))


def main():
    if len(sys.argv) < 2:
        raise SystemExit("usage: fix_jass_void_returns.py MAP [...]")
    for path in sys.argv[1:]:
        patch_map(path)
    return 0


if __name__ == "__main__":
    sys.exit(main())
