"""收集地图中可添加的技能 ID + 名称。

来源:
  1. 地图 war3map.w3a (自定义技能, 对象编辑器)
  2. 游戏标准技能 AbilityData.slk (可选)

输出 _skillids.txt: id<TAB>name
"""
import re, os, sys

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.abspath(os.path.join(HERE, "..", ".."))

GAME_ABILITY_SLK = r"H:\Games\War3\ojzrqpjb\share\mpq\units\units\abilitydata.slk"
# 游戏技能名(分种族)
GAME_ABILITYSTRINGS = [
    r"H:\Games\War3\ojzrqpjb\share\mpq\units\units\humanabilitystrings.txt",
    r"H:\Games\War3\ojzrqpjb\share\mpq\units\units\orcabilitystrings.txt",
    r"H:\Games\War3\ojzrqpjb\share\mpq\units\units\undeadabilitystrings.txt",
    r"H:\Games\War3\ojzrqpjb\share\mpq\units\units\nightelfabilitystrings.txt",
    r"H:\Games\War3\ojzrqpjb\share\mpq\units\units\neutralabilitystrings.txt",
    r"H:\Games\War3\ojzrqpjb\share\mpq\units\units\commonabilitystrings.txt",
    r"H:\Games\War3\ojzrqpjb\share\mpq\units\units\campaignabilitystrings.txt",
    r"H:\Games\War3\ojzrqpjb\share\mpq\units\units\itemabilitystrings.txt",
]


def parse_w3a(path):
    """从 war3map.w3a 提取 (技能ID, 名称)。

    锚定技能名称修改 anam: <skillId>anam\\x03\\x00\\x00\\x00\\x00*8<name>\\x00
    名称是 UTF-8。
    """
    raw = open(path, "rb").read()
    d = raw.decode("latin-1")
    skills = {}
    for m in re.finditer(r"anam\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00", d):
        p = m.start()
        seg = d[max(0, p - 16):p]
        mm = re.findall(r"[A-Z][0-9A-Za-z]{3}", seg)
        if not mm:
            continue
        sid = mm[-1]
        e = d.find("\x00", m.end())
        name = d[m.end():e]
        try:
            name = name.encode("latin-1").decode("utf-8")
        except Exception:
            pass
        if sid not in skills or not skills[sid]:
            skills[sid] = name
    return skills


def parse_slk_ids(path):
    """从 AbilityData.slk 提取技能 ID (X1 列)。"""
    txt = open(path, "rb").read().decode("utf-8", "replace")
    cur_x = 1
    cur_y = 1
    ids = []
    for m in re.finditer(r'C;([^K]*);K"((?:[^"]|"")*)"', txt):
        coords = m.group(1)
        val = m.group(2).replace('""', '"')
        xm = re.search(r"X(\d+)", coords)
        ym = re.search(r"Y(\d+)", coords)
        if xm:
            cur_x = int(xm.group(1))
        if ym:
            cur_y = int(ym.group(1))
        if cur_x == 1 and cur_y >= 2 and len(val) == 4:
            ids.append(val)
    return ids


def parse_abil_strings(path):
    """从 AbilityStrings.txt 提取 (id, name)。格式: [id] Name=..."""
    txt = open(path, "rb").read()
    for enc in ("utf-8", "gbk"):
        try:
            txt = txt.decode(enc)
            break
        except Exception:
            continue
    else:
        txt = txt.decode("latin-1")
    items = []
    cur = None
    for line in txt.splitlines():
        s = line.strip()
        m = re.match(r"^\[([0-9A-Za-z]{4})\]$", s)
        if m:
            cur = m.group(1)
            continue
        if cur and s.lower().startswith("name="):
            items.append((cur, s.split("=", 1)[1]))
            cur = None
    return items


def main():
    map_dir = sys.argv[1] if len(sys.argv) > 1 else None
    names = {}

    # 游戏标准技能名
    for p in GAME_ABILITYSTRINGS:
        if os.path.isfile(p):
            for iid, nm in parse_abil_strings(p):
                names[iid] = nm
    print("游戏技能名:", len(names))

    # 地图自定义技能
    w3a = os.path.join(map_dir, "war3map.w3a") if map_dir else None
    if w3a and os.path.isfile(w3a):
        for sid, nm in parse_w3a(w3a).items():
            if nm:
                names[sid] = nm
        print("地图 w3a 技能:", len(names))

    # 输出
    out = os.path.join(HERE, "_skillids.txt")
    with open(out, "w", encoding="utf-8") as fh:
        for sid in sorted(names):
            fh.write("%s\t%s\n" % (sid, names[sid]))
    print("wrote %s: %d 技能" % (out, len(names)))


if __name__ == "__main__":
    main()
