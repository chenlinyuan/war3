# -*- coding: utf-8 -*-
"""Un-invulnerable quest objects without relying on a possibly-dead anchor unit.

Pattern: the author gates scenery behind

    call TriggerRegisterUnitInRangeSimple(trg, 500.0, gg_unit_E62M_0254)
    // action: SetDestructableInvulnerable(gg_dest_DTg5_3332, false) + SetUnitInvulnerable(...)

If that anchor unit dies (e.g. it is the 海妖兽 you killed in the side quest), the
event can never fire again and the gate lever / barrier generator stay invulnerable
forever -> the chapter dead-ends.

Fix: add a 1-second periodic trigger that applies the very same
un-invulnerable calls as soon as the quest gate found in those triggers'
conditions (e.g. `IsQuestItemCompleted(udg_zhuyaorenwu101)`) is satisfied.
"""
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

RX_FUNC = re.compile(r"(?m)^function\s+(\w+)\s+takes\s")
RX_INIT = re.compile(r"TriggerAddCondition\(\s*(gg_trg_\w+)\s*,\s*Condition\(function\s+(\w+)\)")
RX_ACT = re.compile(r"TriggerAddAction\(\s*(gg_trg_\w+)\s*,\s*function\s+(\w+)\)")
RX_GATED = re.compile(r"TriggerRegister(?:UnitInRangeSimple|EnterRectSimpleNull)")
RX_OFF_U = re.compile(r"SetUnitInvulnerable\(\s*(gg_unit_\w+)\s*,\s*false\s*\)")
RX_OFF_D = re.compile(r"SetDestructableInvulnerable\(\s*(gg_dest_\w+)\s*,\s*false\s*\)")
RX_GOAL = re.compile(r"IsQuestItemCompleted\(\s*(udg_\w+)\s*\)")

BLOCK_TMPL = """
function IB_Unlock_Cond takes nothing returns boolean
    return IsQuestItemCompleted(%(q)s) == true
endfunction

function IB_Unlock_Act takes nothing returns nothing
%(calls)s
    call DisableTrigger(GetTriggeringTrigger())
endfunction

function IB_Unlock_Init takes nothing returns nothing
    local trigger t = CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(t, 1.0)
    call TriggerAddCondition(t, Condition(function IB_Unlock_Cond))
    call TriggerAddAction(t, function IB_Unlock_Act)
endfunction
"""


def patch(text):
    marks = [(m.start(), m.group(1)) for m in RX_FUNC.finditer(text)]
    spans = {}
    for i, (pos, name) in enumerate(marks):
        end = marks[i + 1][0] if i + 1 < len(marks) else len(text)
        spans[name] = text[pos:end]
    cond_of = {m.group(1): m.group(2) for m in RX_INIT.finditer(text)}
    act_of = {m.group(1): m.group(2) for m in RX_ACT.finditer(text)}
    units, dests, goals = [], [], []
    for trg, act in act_of.items():
        init = spans.get("InitTrig_" + trg.replace("gg_trg_", ""), "")
        if not RX_GATED.search(init):
            continue
        body = spans.get(act, "")
        for u in RX_OFF_U.findall(body):
            if u not in units:
                units.append(u)
        for d in RX_OFF_D.findall(body):
            if d not in dests:
                dests.append(d)
        for g in RX_GOAL.findall(spans.get(cond_of.get(trg, ""), "")):
            if g not in goals:
                goals.append(g)
    if not goals or not (units or dests):
        return text, 0
    calls = "".join("    call SetDestructableInvulnerable(%s, false)\n" % d for d in dests)
    calls += "".join("    call SetUnitInvulnerable(%s, false)\n" % u for u in units)
    block = BLOCK_TMPL % {"q": goals[0], "calls": calls}
    out = text
    m = re.search(r"(?m)^([ \t]*)call InitCustomTriggers\(\)[ \t]*\r?\n", out)
    if m:
        out = out[:m.end(0)] + "%scall IB_Unlock_Init()\n" % m.group(1) + out[m.end(0):]
    anchor = re.search(r"(?m)^function[ \t]+main[ \t]+takes[ \t]", out)
    if anchor:
        out = out[:anchor.start()] + block + "\n" + out[anchor.start():]
    else:
        first = re.search(r"(?m)^function[ \t]", out)
        pos = first.start() if first else 0
        out = out[:pos] + block + "\n" + out[pos:]
    return out, 1 + len(units) + len(dests)


def main():
    for p in sys.argv[1:]:
        raw = open(p, "rb").read()
        new, n = patch(raw.decode("utf-8", "surrogateescape"))
        print("%-20s unlock helper added: %d" % (p.replace("\\", "/").split("/")[-1], n))
        if n:
            with open(p, "wb") as f:
                f.write(new.encode("utf-8", "surrogateescape"))


if __name__ == "__main__":
    main()
