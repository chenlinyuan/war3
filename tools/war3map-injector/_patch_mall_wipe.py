# -*- coding: utf-8 -*-
"""别让"商城福利"触发器把玩家的单位删光。

作者原码（`194213` 燃烧之怒，全战役同一套模板）：

    function Trig...033...uConditions takes nothing returns boolean
        return DzAPI_Map_HasMallItem(Player(0), "URIZZ4") == true   // 福利：攻击强化
    endfunction
    function Trig...033...uActions takes nothing returns nothing
        ...
        call QuestMessageBJ(..., "（已激活-攻击强化-效果！…额外获得初始50点攻击力…）")
        call YDWEGeneralBounsSystemUnitSetBonus(udg_ak, 3, 0, 50)
        ... 加钱/加征战值的福利 ...
        call SaveGroupHandle(YDLOC, ..., YDWEGetUnitsOfPlayerMatchingNull(Player(0), null))
        call ForGroupBJ(..., function Trig...uFunc008002)   // ← 把玩家**所有**单位 RemoveUnit
        call DestroyGroup(...)
    endfunction

平台版里这些触发器只对"买了该商城道具"的玩家成立，所以正常玩家碰不到；而单机版把
`DzAPI_Map_HasMallItem` 存根成"一律 true"（福利全开）→ 进图 5~10 秒后它们全部成立，
英雄、宠物、全部单位被删光，且**没有任何判负调用**（所以只看到单位消失、没有失败弹窗）。
`194213` 实测：第 15 章 `URIZZ4`（攻击强化，10 秒定时器）、第 22 章 `XHLLL7`（任意单位
受伤/施法/拾取时触发）都是这种。

处理：条件**只有**一条 `HasMallItem(..., KEY) == true` 的触发器，把它动作里那句
`call ForGroupBJ(..., function <删单位> )` 换成 `call DoNothing()` —— 福利照给（加攻、
加钱、提示），只是不再清场。条件里还有别的子句（例如"英雄阵亡"）的触发器不动，
那些是作者的正常流程/判负逻辑。
"""
import os
import re
import sys

RX_FUNC = re.compile(r"(?m)^function\s+(\w+)\s+takes\s")
RX_INIT = re.compile(r"TriggerAddCondition\(\s*(gg_trg_\w+)\s*,\s*Condition\(function\s+(\w+)\)")
RX_ACT = re.compile(r"TriggerAddAction\(\s*(gg_trg_\w+)\s*,\s*function\s+(\w+)\)")
RX_BARE_MALL = re.compile(
    r'^[ \t]*return[ \t]+DzAPI_Map_HasMallItem\([ \t]*Player\(0\)[ \t]*,[ \t]*"([^"]+)"[ \t]*\)[ \t]*==[ \t]*true[ \t]*$')
RX_FORGROUP = re.compile(
    r"(?m)^([ \t]*)call ForGroupBJ\([^\r\n]*?,\s*function\s+(\w+)\)[ \t]*\r?$")
RX_WIPE = "RemoveUnit(GetEnumUnit())"
MARK = "// IB: mall welfare must not wipe player units"


def split_funcs(text):
    """-> (名字 -> (函数体, 在 text 里的起始偏移))"""
    marks = [(m.start(), m.group(1)) for m in RX_FUNC.finditer(text)]
    out = {}
    for i, (pos, name) in enumerate(marks):
        end = marks[i + 1][0] if i + 1 < len(marks) else len(text)
        out[name] = (text[pos:end], pos)
    return out


def patch(text):
    funcs = split_funcs(text)
    cond_of, act_of = {}, {}
    for m in RX_INIT.finditer(text):
        cond_of[m.group(1)] = m.group(2)
    for m in RX_ACT.finditer(text):
        act_of[m.group(1)] = m.group(2)
    reps = []
    for trg, cond_name in sorted(cond_of.items()):
        act_name = act_of.get(trg)
        cbody = funcs.get(cond_name, ("", 0))[0]
        lines = [l for l in cbody.split("\n")[1:] if l.strip() and l.strip() != "endfunction"]
        if len(lines) != 1:
            continue
        if not RX_BARE_MALL.match(lines[0]):
            continue
        ent = funcs.get(act_name)
        if not ent:
            continue
        abody, astart = ent
        hits = [m for m in RX_FORGROUP.finditer(abody)
                if RX_WIPE in funcs.get(m.group(2), ("", 0))[0]
                and MARK not in m.group(0)]
        for m in hits:
            ind = m.group(1)
            reps.append((astart + m.start(), astart + m.end(),
                         "%scall DoNothing() %s" % (ind, MARK)))
    new = text
    for s, e, rep in sorted(reps, key=lambda x: -x[0]):
        new = new[:s] + rep + new[e:]
    return new, len(reps)


def main():
    for p in sys.argv[1:]:
        raw = open(p, "rb").read()
        new, n = patch(raw.decode("utf-8", "surrogateescape"))
        print("%-20s mall-welfare wipes neutralized: %d" % (p.replace("\\", "/").split("/")[-1], n))
        if n:
            with open(p, "wb") as f:
                f.write(new.encode("utf-8", "surrogateescape"))


if __name__ == "__main__":
    main()
