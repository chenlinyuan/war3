# -*- coding: utf-8 -*-
"""把"平台相关"的结束游戏调用（判负/判胜/清空玩家）改成空操作。

背景：平台的战役/地图会用商城道具、存档、平台接口做门禁，条件满足就
CustomDefeatBJ（失败）或 CustomVictoryBJ（提前判胜、退回选章节页）。
实测两例：
  * 试玩到期：`if HasMallItem(p,"0000GS0006") != true then ... CustomDefeatBJ`
  * 领取宠物：`if HasMallItem(p,"ELQSM5") == true then ... CustomVictoryBJ`

处理方式：只动"触发器条件或动作里出现平台接口（Dz*/EX*/RequestExtra*）"的结束调用，
把那一行换成 `call DoNothing()`，其余（剧情判负/判胜）保持原样。
"""
import re
import sys

ENDS = ("CustomDefeatBJ", "CustomVictoryBJ", "EndGame", "RemovePlayerPreserveUnitsBJ",
        "CustomDefeatDialogBJ", "MeleeDoDefeat", "RestartGame", "CustomRestartBJ")
PLATFORM = re.compile(r"\b(Dz\w+|EX\w+|RequestExtra\w+|Cheat|ReloadGameCachesFromDisk)\s*\(")
RX_TRANSITION_VICTORY = re.compile(
    r"(?m)^[ \t]*call[ \t]+CustomVictoryBJ\([^\r\n]*\)[ \t]*\r?\n"
    r"[ \t]*call[ \t]+SetNextLevelBJ\("
)
RX_FUNC = re.compile(r"(?m)^function\s+(\w+)\s+takes\s")
RX_INIT = re.compile(r"TriggerAddCondition\(\s*(gg_trg_\w+)\s*,\s*Condition\(function\s+(\w+)\)")
RX_ACT = re.compile(r"TriggerAddAction\(\s*(gg_trg_\w+)\s*,\s*function\s+(\w+)\)")


def neutralize(text):
    """返回 (新文本, [(触发器, 调用, 行号)])"""
    marks = [(m.start(), m.group(1)) for m in RX_FUNC.finditer(text)]
    funcs, pos_of = {}, {}
    for i, (pos, name) in enumerate(marks):
        end = marks[i + 1][0] if i + 1 < len(marks) else len(text)
        funcs[name] = text[pos:end]
        pos_of[name] = pos
    cond_of, act_of = {}, {}
    for m in RX_INIT.finditer(text):
        cond_of[m.group(1)] = m.group(2)
    for m in RX_ACT.finditer(text):
        act_of[m.group(1)] = m.group(2)

    # 动作函数 -> 是否平台相关
    plat_act = {}
    for trg, act in act_of.items():
        body = funcs.get(act, "")
        plat_act[act] = bool(PLATFORM.search(funcs.get(cond_of.get(trg, ""), "")) or
                             PLATFORM.search(body))

    lines = text.split("\n")
    hits = []
    for name, body in funcs.items():
        if not plat_act.get(name, False):
            continue
        for e in ENDS:
            for m in re.finditer(r"(?m)^([ \t]*)call\s+%s\s*\(" % e, body):
                if e == "CustomVictoryBJ":
                    tail = body[m.start():]
                    if RX_TRANSITION_VICTORY.match(tail):
                        continue
                off = pos_of[name] + m.start() + len(m.group(1))
                hits.append((name, e, off, body.count("\n", 0, m.start())))
    # 需要按偏移量改文本：从后往前替换
    def line_no(off):
        return text.count("\n", 0, off) + 1
    out = text
    records = []
    for name, e, off, _ln in sorted(hits, key=lambda x: -x[2]):
        # 找到这一行的起止
        ls = out.rfind("\n", 0, off) + 1
        le = out.find("\n", off)
        le = len(out) if le < 0 else le
        indent = re.match(r"[ \t]*", out[ls:]).group(0)
        old = out[ls:le].strip()
        records.append((name, e, line_no(off), old))
        out = out[:ls] + indent + "call DoNothing()" + out[le:]
    return out, records


def main():
    for p in sys.argv[1:]:
        text = open(p, "rb").read().decode("utf-8", "surrogateescape")
        new, recs = neutralize(text)
        if not recs:
            continue
        print("=== %s  改掉 %d 处平台结束调用" % (p.split("\\")[-1], len(recs)))
        for name, e, ln, old in recs[:12]:
            print("   行%-7d %-16s %s" % (ln, e, old[:90]))
        with open(p + ".neutralized", "wb") as f:
            f.write(new.encode("utf-8", "surrogateescape"))


if __name__ == "__main__":
    main()
