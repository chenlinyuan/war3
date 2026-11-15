# -*- coding: utf-8 -*-
"""Make "mission-critical scenery" invulnerable.

Pattern found in this campaign: a pre-placed unit is registered as

    call TriggerRegisterUnitEvent(gg_trg_xxx, gg_unit_npgr_0732, EVENT_UNIT_DEATH)
    // action: CustomDefeatBJ(Player(0), "失败!") + 清光玩家单位

and the quest log says e.g. 「能量产生器不能被摧毁」 (194213 第 3 章).  The unit is
destroyed by whoever is attacking the base, which instant-fails the chapter while
the player is still in the opening dialogue.

Fix: for every `gg_unit_*` (a static pre-placed prop, never the hero variable
`udg_ak`) whose death trigger calls `CustomDefeatBJ`, insert
`call SetUnitInvulnerable(<unit>, true)` right after the `CreateUnit` line that
creates it.  Bosses are not affected: their death triggers call `CustomVictoryBJ`,
not `CustomDefeatBJ`.
"""
import re
import sys

RX_FUNC = re.compile(r"(?m)^function\s+(\w+)\s+takes\s")
RX_ACT = re.compile(r"TriggerAddAction\(\s*(gg_trg_\w+)\s*,\s*function\s+(\w+)\)")
RX_REG = re.compile(r"TriggerRegisterUnitEvent\(\s*(gg_trg_\w+)\s*,\s*(gg_unit_\w+)\s*,\s*EVENT_UNIT_DEATH\)")
RX_CREATE = r"(?m)^([ \t]*)set\s+%s\s*=\s*CreateUnit\([^\n]*\n"


def patch(text):
    props = critical_props(text)
    new, n = text, 0
    for unit in props:
        m = re.search(RX_CREATE % re.escape(unit), new)
        if not m:
            continue
        ins = "%scall SetUnitInvulnerable(%s, true) // IB: critical prop must not die\n" % (m.group(1), unit)
        new = new[:m.end()] + ins + new[m.end():]
        n += 1
    # 2) 把"机关死亡 -> 判负 + 清光玩家单位"的触发器动作里那两行改成空操作
    marks = [(m.start(), m.group(1)) for m in RX_FUNC.finditer(new)]
    spans = {}
    for i, (pos, name) in enumerate(marks):
        end = marks[i + 1][0] if i + 1 < len(marks) else len(new)
        spans[name] = new[pos:end]
    act_of = {m.group(1): m.group(2) for m in RX_ACT.finditer(new)}
    for trg, unit in RX_REG.findall(new):
        if unit not in props:
            continue
        act = act_of.get(trg, "")
        if not act or act not in spans:
            continue
        body = spans[act]
        if "CustomDefeatBJ" not in body:
            continue
        nb = re.sub(r"(?m)^([ \t]*)call[ \t]+CustomDefeatBJ\([^\n]*$",
                    r"\1call DoNothing() // IB: critical prop death is no longer fatal", body)
        nb = re.sub(r"(?m)^([ \t]*)call[ \t]+ForGroupBJ\([^\n]*Func\d+002[^\n]*$",
                    r"\1call DoNothing() // IB: no wipe on critical prop death", nb)
        if nb != body:
            new = new.replace(body, nb, 1)
            n += 1
    return new, n


def critical_props(text):
    """返回"死亡会导致判负"的预置单位列表（供其它补丁复用）。"""
    marks = [(m.start(), m.group(1)) for m in RX_FUNC.finditer(text)]
    spans = {}
    for i, (pos, name) in enumerate(marks):
        end = marks[i + 1][0] if i + 1 < len(marks) else len(text)
        spans[name] = text[pos:end]
    act_of = {m.group(1): m.group(2) for m in RX_ACT.finditer(text)}
    props = []
    for trg, unit in RX_REG.findall(text):
        body = spans.get(act_of.get(trg, ""), "")
        tree = body + "".join(spans.get(c, "") for c in re.findall(r"function\s+(\w+)\)", body))
        if "CustomDefeatBJ" in tree and unit not in props:
            props.append(unit)
    return props


def main():
    for p in sys.argv[1:]:
        raw = open(p, "rb").read()
        new, n = patch(raw.decode("utf-8", "surrogateescape"))
        print("%-20s critical props made invulnerable: %d"
              % (p.replace("\\", "/").split("/")[-1], n))
        if n:
            with open(p, "wb") as f:
                f.write(new.encode("utf-8", "surrogateescape"))


if __name__ == "__main__":
    main()
