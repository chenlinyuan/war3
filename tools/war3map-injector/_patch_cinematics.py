# -*- coding: utf-8 -*-
"""让过场电影看得见：过场期间临时关掉战争迷雾，过场结束后恢复。

背景（燃烧之怒第2章实测）：过场 = 引擎内镜头动画，作者的镜头会切到玩家**没探索过**
的区域（万神殿内部），单机下那片区域是纯黑（战争迷雾的未探索遮罩），于是"一直黑屏"。
过场里的对白/字幕照常播，只是画面全黑。

处理：
  * 在"可跳过电影"提示那一行后面插入
        call FogMaskEnable(false)
        call FogEnable(false)
  * 在该过场函数结尾插入
        call FogMaskEnable(true)
        call FogEnable(true)
  * 按 ESC 跳过走的是另一个触发器动作，也在它结尾补上恢复迷雾，
    保证跳过之后不会一直是"全图点亮"。
"""
import re
import sys

RX_FUNC = re.compile(r"(?m)^function\s+(\w+)\s+takes\s")
RX_INIT = re.compile(r"TriggerAddCondition\(\s*(gg_trg_\w+)\s*,\s*Condition\(function\s+(\w+)\)")
RX_ACT = re.compile(r"TriggerAddAction\(\s*(gg_trg_\w+)\s*,\s*function\s+(\w+)\)")
RX_FLAG = re.compile(r"udg_(dianyingtiaoguo\d+)\s*==\s*10")
HINT = "可跳过电影"
OFF = ("call FogMaskEnable(false)", "call FogEnable(false)")
ON = ("call FogMaskEnable(true)", "call FogEnable(true)")


def patch(text):
    marks = [(m.start(), m.group(1)) for m in RX_FUNC.finditer(text)]
    spans = {}
    for i, (pos, name) in enumerate(marks):
        end = marks[i + 1][0] if i + 1 < len(marks) else len(text)
        spans[name] = (pos, end)
    cond_of, act_of = {}, {}
    for m in RX_INIT.finditer(text):
        cond_of[m.group(1)] = m.group(2)
    for m in RX_ACT.finditer(text):
        act_of[m.group(1)] = m.group(2)
    init_of = {}
    for name, (s, e) in spans.items():
        if name.startswith("InitTrig_"):
            m = re.search(r"set\s+(gg_trg_\w+)\s*=", text[s:e])
            if m:
                init_of[m.group(1)] = text[s:e]
    edits, notes = [], []
    # flag -> ESC 跳过触发器（注册了 EndCinematic，且条件里带 udg_<flag> == 10）
    skip = {}
    for trg, cond in cond_of.items():
        if "EndCinematic" not in init_of.get(trg, ""):
            continue
        c2, ce = spans.get(cond, (None, None))
        if c2 is None:
            continue
        m = RX_FLAG.search(text[c2:ce])
        if m:
            skip.setdefault(m.group(1), trg)
    # 1) 所有"进入电影模式"的函数：CinematicModeBJ(true,...) 之后关雾，函数结束前恢复
    for name, (s, e) in spans.items():
        body = text[s:e]
        starts = [m for m in re.finditer(r"CinematicModeBJ\(true", body)]
        if not starts and HINT not in body:
            continue
        indent = "    "
        for m in starts:
            line_start = s + m.start()
            real_start = text.rfind("\n", s, line_start) + 1
            indent = re.match(r"[ \t]*", text[real_start:text.find("\n", real_start)]).group(0)
            line_end = text.find("\n", line_start)
            edits.append((line_end + 1, "".join("%s%s\n" % (indent, c) for c in OFF)))
        endfn_pos = text.rfind("endfunction", s, e)
        if endfn_pos >= 0:
            edits.append((text.rfind("\n", s, endfn_pos) + 1,
                          "".join("%s%s\n" % (indent, c) for c in ON)))
        notes.append(name)
    # 2) 所有 ESC 跳过触发器：动作末尾恢复迷雾
    for trg, cond in cond_of.items():
        if "EndCinematic" not in init_of.get(trg, ""):
            continue
        act = act_of.get(trg)
        s2, e2 = spans.get(act, (None, None))
        if s2 is None:
            continue
        p2 = text.rfind("endfunction", s2, e2)
        if p2 >= 0:
            edits.append((text.rfind("\n", s2, p2) + 1,
                          "    call FogMaskEnable(true)\n    call FogEnable(true)\n"))
    # 3) 跳过窗口从"只有前 10 秒"改成"整段过场随时可跳"：
    #    条件是 `udg_<flag> == 10`，改成 `!= 20`；并在每段过场提示前重新启用跳过触发器。
    for trg, cond in cond_of.items():
        act = act_of.get(trg)
        s2, e2 = spans.get(act, (None, None))
        if s2 is None:
            continue
        c2, ce = spans.get(cond, (None, None))
        if c2 is None:
            continue
        cbody = text[c2:ce]
        m = re.search(r"udg_(dianyingtiaoguo\d+)\s*==\s*10", cbody)
        if not m:
            continue
        flag = m.group(1)
        p = c2 + m.start()
        # IB 2026-10-13: 不要再把条件改写成 "!= 20"。
        # 过场标志取值：0=该段电影还没开始，10=正在放，20=已播完/已跳过。
        # 改成 "!= 20" 会让跳过触发器在该段电影**还没开始**时也成立 → 玩家在
        # “开局电影”里按 ESC 会命中“迪洛戈过场”的跳过触发器，把主角直接传送到
        # 舞池 rect024、并把迪洛戈任务判为完成（实测：开局动画一结束主角就站在
        # 3 个舞女那里，而不是万神殿门口 rect003）。原版条件 `== 10`（仅该段电影
        # 进行中可跳）本来就是对的，保持原样。
        # 在每段该 flag 的过场提示前，重新启用跳过触发器
        for mm in re.finditer(r"set\s+udg_%s\s*=\s*10" % re.escape(flag), text):
            ls = text.rfind("\n", 0, mm.start()) + 1
            ind = re.match(r"[ \t]*", text[ls:text.find("\n", ls)]).group(0)
            edits.append((ls, "%scall EnableTrigger(%s)  // IB: 重新打开跳过\n" % (ind, trg)))
    # 4) "10 秒 ESC 电影"在单机里会黑屏卡死（镜头跑到没地形的区域，主线程卡住、ESC 无反应）。
    #    实测：让这类过场**自动走作者自己的"跳过"分支**是能跑通的做法
    #    （任务推进/阿克蒙德站位/后续 Boss 触发都正常）；"快进主线"反而会把站位和刷怪搞乱。
    for name, (s, e) in spans.items():
        body = text[s:e]
        if HINT not in body:
            continue
        flag = None
        for m in re.finditer(r"set\s+udg_(dianyingtiaoguo\d+)\s*=\s*10", body):
            flag = m.group(1)
        trg = skip.get(flag) if flag else None
        if not trg:
            continue
        hint_pos = text.find(HINT, s, e)
        line_end = text.find("\n", hint_pos)
        ls = text.rfind("\n", s, hint_pos) + 1
        indent = re.match(r"[ \t]*", text[ls:line_end]).group(0)
        ins = ("%scall EnableTrigger(%s)\n%scall TriggerExecute(%s)\n%sreturn\n"
               % (indent, trg, indent, trg, indent))
        edits.append((line_end + 1, ins))
        notes.append("auto-skip:" + (flag or "?"))
    out, prev = [], 0
    for e in sorted(edits, key=lambda x: x[0]):
        pos, ins = e[0], e[1]
        cut = e[2] if len(e) > 2 else 0
        out.append(text[prev:pos])
        out.append(ins)
        prev = pos + cut
    out.append(text[prev:])
    return "".join(out), notes


def main():
    for p in sys.argv[1:]:
        text = open(p, "rb").read().decode("utf-8", "surrogateescape")
        new, notes = patch(text)
        print("%-18s 过场可见性修复 %d 处 %s" % (p.split("\\")[-1], len(notes), notes[:4]))
        if notes:
            with open(p, "wb") as f:
                f.write(new.encode("utf-8", "surrogateescape"))


if __name__ == "__main__":
    main()
