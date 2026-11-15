# -*- coding: utf-8 -*-
"""Make the chapter-ending chat command fire automatically.

Every chapter of this campaign ends through a chat trigger:

    call TriggerRegisterPlayerChatEvent(gg_trg____02555, Player(0), "GO", true)
    // condition: e.g. `udg_qianghua == 0 and udg_panduan520 >= 3.0`
    // action   : finale cinematic -> save hero into cache "xinran01.w3v"
    //            -> CustomVictoryBJ -> SetNextLevelBJ("<next chapter>")

On the KK platform the "过关" button sends that chat message.  Offline nobody
sends it, so the chapter never runs its real ending: the hero is never stored in
the carry-over cache, and the *next* chapter (which restores the hero with
`RestoreUnitLocFacingAngleBJ("zhu","jue", cache "xinran01.w3v")`) starts with no
hero at all -> the player owns nothing -> instant defeat.

`194213` 第 3 章就是这么"进去看不到英雄"的。

Fix: add a periodic timer registration to every "GO" chat trigger, so it fires by
itself once its own completion condition passes (the action starts with
`DisableTrigger`, so it still runs exactly once).
"""
import re
import sys

RX_GO = re.compile(
    r'(?m)^([ \t]*)call[ \t]+TriggerRegisterPlayerChatEvent\([ \t]*(gg_trg_\w+)[ \t]*,'
    r'[ \t]*Player\(0\)[ \t]*,[ \t]*"GO"[ \t]*,[^\n]*\n')
RX_FUNC = re.compile(r"(?m)^function\s+(\w+)\s+takes\s")
RX_COND = re.compile(r"TriggerAddCondition\(\s*(gg_trg_\w+)\s*,\s*Condition\(function\s+(\w+)\)")
RX_QUEST = re.compile(r"IsQuest(?:Item)?Completed\(\s*(udg_\w+)\s*\)")


def patch(text):
    marks = [(m.start(), m.group(1)) for m in RX_FUNC.finditer(text)]
    spans = {}
    for i, (pos, name) in enumerate(marks):
        end = marks[i + 1][0] if i + 1 < len(marks) else len(text)
        spans[name] = text[pos:end]
    cond_of = {m.group(1): m.group(2) for m in RX_COND.finditer(text)}

    n = [0]

    # 按作者原设计：结局由玩家在聊天框输入 GO 触发，**不**加自动定时器
    # （自动检查会在"任务对象还没创建"时误判成本章已完成，直接把结局清场跑了）。
    new = text
    # 关掉"任务 handle 为空时 IsQuestItemCompleted 返回真"的坑：
    # 给每个 GO 条件里用到的任务变量补上 `!= null`（否则开局 2 秒就会误触发结局清场）。
    guards = {}
    for trg in RX_GO.findall(text):
        cname = cond_of.get(trg[1])
        if not cname:
            continue
        for v in RX_QUEST.findall(spans.get(cname, "")):
            guards.setdefault(cname, set()).add(v)
    fixed = 0
    for cname, vs in guards.items():
        base = new.find("function " + cname + " takes")
        if base < 0:
            continue
        seg = new[base:base + 4000]
        m = re.search(r"(?m)^([ \t]*)return[ \t]+(.+?)[ \t]*\r?$", seg)
        if not m:
            continue
        extra = "".join(" and %s != null" % v for v in sorted(vs))
        ls, le = base + m.start(), base + m.end()
        new = (new[:ls] + m.group(1) + "return ( " + m.group(2) + " )" + extra
               + " // IB: quest handle must exist" + new[le:])
        fixed += 1
    return new, n[0], fixed


def main():
    for p in sys.argv[1:]:
        raw = open(p, "rb").read()
        new, n, g = patch(raw.decode("utf-8", "surrogateescape"))
        print("%-20s GO auto-fire=%d quest-null-guards=%d"
              % (p.replace("\\", "/").split("/")[-1], n, g))
        if n or g:
            with open(p, "wb") as f:
                f.write(new.encode("utf-8", "surrogateescape"))


if __name__ == "__main__":
    main()
