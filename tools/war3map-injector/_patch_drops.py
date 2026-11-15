# -*- coding: utf-8 -*-
"""修掉落：把"单位掉落注册"里的 EVENT_UNIT_CHANGE_OWNER 去掉，只留死亡事件。

WE 生成的掉落注册长这样（`UnitNNNNNN_DropItems` 是掉落表函数）：
    set t = CreateTrigger()
    call TriggerRegisterUnitEvent(t, <单位>, EVENT_UNIT_DEATH)
    call TriggerRegisterUnitEvent(t, <单位>, EVENT_UNIT_CHANGE_OWNER)
    call TriggerAddAction(t, function UnitNNNNNN_DropItems)
而掉落表函数的结尾是 `call DestroyTrigger(GetTriggeringTrigger())`（一次性）。

问题：只要单位在死亡前发生过 owner 变化（唤醒/易主/被抓），
CHANGE_OWNER 就会先触发一次；此时若单位是隐藏状态，模板里 `canDrop = not IsUnitHidden`
会判为不掉落 —— 但触发器已经被 DestroyTrigger 销毁，**死亡时的掉落就永远丢了**。
实测：燃烧之怒第 2 章 Boss「邪能之体」不掉任务物品「邪能能源」就是这个原因。

处理：删掉掉落注册里的 CHANGE_OWNER 行（注释掉），只保留 DEATH。
"""
import re
import sys

RX_REG = re.compile(r"(?m)^([ \t]*)call TriggerRegisterUnitEvent\((\w+), (\w+), EVENT_UNIT_CHANGE_OWNER\)[ \t]*$")
RX_ADD = re.compile(r"call TriggerAddAction\((\w+), function \w*DropItems\)")


def patch(text):
    lines = text.split("\n")
    out, changed = [], 0
    for i, ln in enumerate(lines):
        m = RX_REG.match(ln)
        if m and any(RX_ADD.search(lines[j]) and "TriggerAddAction(%s," % m.group(2) in lines[j]
                     for j in range(i + 1, min(len(lines), i + 3))):
            out.append("%s// IB: 去掉 CHANGE_OWNER，避免掉落触发器被提前销毁" % m.group(1))
            changed += 1
            continue
        out.append(ln)
    return "\n".join(out), changed


def main():
    for p in sys.argv[1:]:
        text = open(p, "rb").read().decode("utf-8", "surrogateescape")
        new, n = patch(text)
        print("%-18s 去掉 CHANGE_OWNER %d 处" % (p.split("\\")[-1], n))
        if n:
            with open(p, "wb") as f:
                f.write(new.encode("utf-8", "surrogateescape"))


if __name__ == "__main__":
    main()
