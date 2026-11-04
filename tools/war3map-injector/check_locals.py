# -*- coding: utf-8 -*-
"""Audit a JASS script for `local` declarations that come after a statement.

JASS only allows local declarations in the declaration block at the top of a
function; anything else is a syntax error and the map will not load. This check
covers every function (not just main) and is the cheapest oracle available for
maps that use post-1.24 natives (hashtable etc.) which the bundled pjass
common.j cannot parse.

Usage:  python check_locals.py <file.j> [more.j ...]
"""
import re
import sys

FUNC = re.compile(r"^\s*function\s+[A-Za-z_][A-Za-z0-9_]*\s+takes\b")


def check(text):
    lines = text.split("\n")
    problems = []
    name = None
    seen_stmt = False
    for i, l in enumerate(lines, 1):
        s = l.strip()
        if FUNC.match(l):
            name = s
            seen_stmt = False
            continue
        if name is None:
            continue
        if s == "endfunction":
            name = None
            continue
        if s == "" or s.startswith("//"):
            continue
        if s.startswith("local ") or s.startswith("local\t"):
            if seen_stmt:
                problems.append((i, name, s))
            continue
        seen_stmt = True
    return problems


def main():
    sys.stdout.reconfigure(encoding="utf-8")
    rc = 0
    for p in sys.argv[1:]:
        text = open(p, "rb").read().decode("latin-1")
        problems = check(text)
        if problems:
            rc = 1
            print("!! %s: %d 处 local 在语句之后" % (p, len(problems)))
            for line, fn, s in problems[:6]:
                print("     line %d in %s: %s" % (line, fn[:46], s[:60]))
        else:
            print("OK %s: local 全部在函数头部" % p)
    return rc


if __name__ == "__main__":
    sys.exit(main())
