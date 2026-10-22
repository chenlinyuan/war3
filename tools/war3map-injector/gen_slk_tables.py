# -*- coding: utf-8 -*-
"""把"SLK 化"地图（W3x2lni 处理过、没有 war3map.w3t/w3u/w3h）里的自定义物品/技能
并进物品浏览器的表里。

读 <stage>/units/itemdata.slk 与 <stage>/units/abilitydata.slk：
  * 第 1 列是对象 ID
  * 名字取表头为 Name 的那一列（没有就退回 Tip）
然后把"基础表里还没有的 ID"追加到：
  $IB_BASE_DIR/_itemids.txt   （C<TAB>id<TAB>name，C = 自定义）
  $IB_BASE_DIR/_skillids.txt  （id<TAB>name）
已有的条目一律不动（标准物品的中文名来自游戏数据，比图里的英文名好）。

用法: python gen_slk_tables.py <stage 目录>
"""
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
CELL_RE = re.compile(r'C;((?:[XY]\d+;)*)K(?:"((?:[^"]|"")*)"|([^;\r\n]*))')
ID_RE = re.compile(r"^[0-9A-Za-z]{4}$")


def decode(data):
    for enc in ("utf-8", "gbk"):
        try:
            return data.decode(enc), enc
        except Exception:
            continue
    return data.decode("latin-1"), "latin-1"


def slk_rows(path):
    """返回 {y: {fieldname_lower: value}}（第 1 行是表头）。"""
    data, _enc = decode(open(path, "rb").read())
    cells = {}
    cx = cy = 0
    for m in CELL_RE.finditer(data):
        for c in m.group(1).split(";"):
            if not c:
                continue
            if c[0] == "X":
                cx = int(c[1:])
            elif c[0] == "Y":
                cy = int(c[1:])
        val = m.group(2).replace('""', '"') if m.group(2) is not None else m.group(3)
        cells[(cx, cy)] = val
    if not cells:
        return {}
    max_x = max(x for x, _y in cells)
    max_y = max(y for _x, y in cells)
    header = {}
    for x in range(1, max_x + 1):
        h = (cells.get((x, 1)) or "").strip().lower()
        if h and h not in header:
            header[h] = x
    rows = {}
    for y in range(2, max_y + 1):
        rows[y] = {k: (cells.get((x, y)) or "").strip() for k, x in header.items()}
    return rows


def collect(slk_path, id_field):
    """[(id, name)]"""
    out = []
    rows = slk_rows(slk_path)
    for _y, r in sorted(rows.items()):
        oid = r.get(id_field, "")
        if not ID_RE.match(oid):
            # 有的表第 1 列名字不是 itemID/alias，兜底扫一遍值
            oid = next((v for v in r.values() if ID_RE.match(v)), "")
        if not ID_RE.match(oid):
            continue
        name = r.get("name") or r.get("tip") or ""
        out.append((oid, name))
    return out


def merge(base_path, new_rows, prefix):
    have = set()
    lines = []
    if os.path.exists(base_path):
        lines = open(base_path, encoding="utf-8").read().splitlines()
        for ln in lines:
            parts = ln.split("\t")
            for p in parts[:2]:
                if ID_RE.match(p.strip()):
                    have.add(p.strip())
                    break
    added = 0
    for oid, name in new_rows:
        if oid in have:
            continue
        have.add(oid)
        lines.append(prefix + oid + "\t" + name)
        added += 1
    open(base_path, "w", encoding="utf-8").write("\n".join(lines) + "\n")
    return added


def main():
    sys.stdout.reconfigure(encoding="utf-8")
    stage = sys.argv[1] if len(sys.argv) > 1 else "."
    base = os.environ.get("IB_BASE_DIR") or HERE
    u = os.path.join(stage, "units")
    items = os.path.join(u, "itemdata.slk")
    skills = os.path.join(u, "abilitydata.slk")
    if os.path.exists(items):
        rows = collect(items, "itemid")
        n = merge(os.path.join(base, "_itemids.txt"), rows, "C\t")
        print("  图内 units\\itemdata.slk: %d 条，新增 %d 条物品" % (len(rows), n))
    if os.path.exists(skills):
        rows = collect(skills, "alias")
        n = merge(os.path.join(base, "_skillids.txt"), rows, "")
        print("  图内 units\\abilitydata.slk: %d 条，新增 %d 条技能" % (len(rows), n))


if __name__ == "__main__":
    main()
