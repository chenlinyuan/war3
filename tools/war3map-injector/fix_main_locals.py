# -*- coding: utf-8 -*-
"""Move `local` declarations to the top of function main.

JASS requires every `local` declaration to precede all statements in a function.
Older builds inserted the entry call ("call IB_Init()") directly after the
`function main ...` header; in maps whose main declares locals this is a syntax
error and the map refuses to load ("map not found or corrupted").

This tool repairs such a script in place (declaration order only, statement
order is preserved). Usage:

    python fix_main_locals.py <war3map.j> [--out <file>]
"""
import sys


def is_header(s):
    return s.startswith("function main takes nothing returns nothing")


def fix(text):
    lines = text.split("\n")
    head = None
    for i, l in enumerate(lines):
        if is_header(l.strip()):
            head = i
            break
    if head is None:
        return text, 0
    end = len(lines)
    for j in range(head + 1, len(lines)):
        if lines[j].strip() == "endfunction":
            end = j
            break
    body = lines[head + 1:end]
    first_stmt = None
    locals_pos = []
    for k, l in enumerate(body):
        s = l.strip()
        if s == "" or s.startswith("//"):
            continue
        if s.startswith("local ") or s.startswith("local\t"):
            locals_pos.append(k)
            continue
        if first_stmt is None:
            first_stmt = k
    if first_stmt is None or not any(k > first_stmt for k in locals_pos):
        return text, 0
    moved = [k for k in locals_pos if k > first_stmt]
    moved_lines = [body[k] for k in moved]
    rest = [l for k, l in enumerate(body) if k not in set(moved)]
    # 插到第一条语句之前
    ins = 0
    while ins < len(rest):
        s = rest[ins].strip()
        if s == "" or s.startswith("//"):
            ins += 1
            continue
        break
    new_body = rest[:ins] + moved_lines + rest[ins:]
    return "\n".join(lines[:head + 1] + new_body + lines[end:]), len(moved_lines)


def main():
    sys.stdout.reconfigure(encoding="utf-8")
    if len(sys.argv) < 2:
        print(__doc__)
        return 1
    src = sys.argv[1]
    out = src
    if "--out" in sys.argv:
        out = sys.argv[sys.argv.index("--out") + 1]
    data = open(src, "rb").read()
    text = data.decode("latin-1")
    fixed, n = fix(text)
    if n == 0:
        print("main 里没有需要搬动的 local（或找不到 main）")
        return 0
    open(out, "wb").write(fixed.encode("latin-1"))
    print("搬动 %d 行 local 到 main 头部 -> %s (%d -> %d 字节)"
          % (n, out, len(data), len(fixed)))
    return 0


if __name__ == "__main__":
    sys.exit(main())
