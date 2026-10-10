"""SLK reader that also captures unquoted numeric cells (C;X8;Y5;K0.75)."""
import re


def parse_slk_num(path, encoding="latin-1"):
    t = open(path, encoding=encoding).read()
    rows = {}
    cx = cy = None
    pat = re.compile(r'C;((?:[XY]\d+;)*)K(?:"((?:[^"]|"")*)"|([^;\r\n]*))')
    for m in pat.finditer(t):
        for c in m.group(1).split(";"):
            if not c:
                continue
            if c[0] == "Y":
                cy = int(c[1:])
            elif c[0] == "X":
                cx = int(c[1:])
        if m.group(2) is not None:
            val = m.group(2).replace('""', '"')
        else:
            val = m.group(3)
        rows.setdefault(cy, {})[cx] = val
    return rows


def header_rows(rows):
    return rows.get(1, {})
