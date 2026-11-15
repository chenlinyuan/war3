# -*- coding: utf-8 -*-
"""把"任意英雄单位死亡 → 判负/清光玩家单位"限定为"只有主角阵亡"。

实测（194213 第 2 章）有两处挂在 `EVENT_PLAYER_UNIT_DEATH` 上的触发器：

    function Trig____022________3Conditions
        return IsUnitType(GetDyingUnit(), UNIT_TYPE_HERO) == true
               and IsUnitIllusionBJ(GetDyingUnit()) != true
               and GetOwningPlayer(GetDyingUnit()) == Player(0)
    function Trig____022________3Actions
        call CustomDefeatBJ(Player(0), "失败!")
        call ForGroupBJ(YDWEGetUnitsOfPlayerMatchingNull(Player(0), null), <删光玩家单位>)

    function Trig____033..._2_______uConditions
        return DzAPI_Map_HasMallItem(Player(0), "00GS00006") == true
               and IsUnitType(GetDyingUnit(), UNIT_TYPE_HERO) == true
    ...Actions -> <删光玩家单位>

条件里的 `UNIT_TYPE_HERO` 不区分"主角"和"宠物"——而**商城宠物以及作者自带的
`udg_chongwu01/02` 都是英雄类单位**。于是宠物阵亡（玩家可能根本没注意）就会：
判负 + 把主角、宠物、身上单位全部 `RemoveUnit`。实测表现就是"打完 BOSS 之后主角和
宠物一起消失了"。

处理：给这些条件追加 `and GetDyingUnit() == udg_ak`（只有主角阵亡才算失败/清场）。
`udg_ak` 就是玩家控制的主角，所以作者原本的"英雄不能死亡"主线判负照旧生效。
"""
import re
import sys

RX_FUNC = re.compile(r"(?m)^function\s+(\w+)\s+takes\s")
RX_INIT = re.compile(r"TriggerAddCondition\(\s*(gg_trg_\w+)\s*,\s*Condition\(function\s+(\w+)\)")
RX_ACT = re.compile(r"TriggerAddAction\(\s*(gg_trg_\w+)\s*,\s*function\s+(\w+)\)")
RX_RET = re.compile(r"(?m)^([ \t]*)return[ \t]+(.+?)[ \t]*\r?$")
HERO_DYING = "IsUnitType(GetDyingUnit(), UNIT_TYPE_HERO) == true"
WIPE = "RemoveUnit(GetEnumUnit())"
RX_GLOBAL = re.compile(
    r"(?m)^[ \t]*(?:unit|integer|real|boolean|string|handle|timer|group|"
    r"trigger|location|region|rect|sound|effect)[ \t]+(udg_[A-Za-z0-9_]+)"
)
MAIN_HERO_GLOBALS = ("udg_zhujue", "udg_ak")


def patch(text):
    declared = set(RX_GLOBAL.findall(text))
    main_hero = next((name for name in MAIN_HERO_GLOBALS if name in declared), None)
    if main_hero is None:
        return text, 0
    marks = [(m.start(), m.group(1)) for m in RX_FUNC.finditer(text)]
    spans = {}
    for i, (pos, name) in enumerate(marks):
        end = marks[i + 1][0] if i + 1 < len(marks) else len(text)
        spans[name] = text[pos:end]
    cond_of, act_of = {}, {}
    for m in RX_INIT.finditer(text):
        cond_of[m.group(1)] = m.group(2)
    for m in RX_ACT.finditer(text):
        act_of[m.group(1)] = m.group(2)
    targets = []
    for trg, cname in cond_of.items():
        init = spans.get("InitTrig_" + trg.replace("gg_trg_", ""), "")
        if "EVENT_PLAYER_UNIT_DEATH" not in init:
            continue
        cbody = spans.get(cname, "")
        if HERO_DYING not in cbody or main_hero in cbody:
            continue
        abody = spans.get(act_of.get(trg, ""), "")
        wipes = WIPE in abody
        if not wipes:
            wipes = any(WIPE in spans.get(c, "") for c in re.findall(r"function\s+(\w+)\)", abody))
        if wipes:
            targets.append(cname)

    new = text
    n = 0
    for name in sorted(set(targets), key=lambda x: -text.find("function " + x)):
        base = new.find("function " + name)
        if base < 0:
            continue
        seg = new[base:base + 4000]
        m = RX_RET.search(seg)
        if not m or main_hero in m.group(2):
            continue
        ls, le = base + m.start(), base + m.end()
        new = (new[:ls] + m.group(1) + "return ( " + m.group(2)
               + " ) and GetDyingUnit() == " + main_hero
               + " // IB: only the main hero may trigger a defeat" + new[le:])
        n += 1
    return new, n


def main():
    for p in sys.argv[1:]:
        raw = open(p, "rb").read()
        new, n = patch(raw.decode("utf-8", "surrogateescape"))
        print("%-20s hero-death conditions narrowed: %d"
              % (p.replace("\\", "/").split("/")[-1], n))
        if n:
            with open(p, "wb") as f:
                f.write(new.encode("utf-8", "surrogateescape"))


if __name__ == "__main__":
    main()
