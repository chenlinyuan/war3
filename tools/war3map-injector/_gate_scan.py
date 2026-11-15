# -*- coding: utf-8 -*-
"""扫描章节脚本里的"平台门禁"：条件是平台接口、动作是判负的触发器。"""
import os
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
RX_FUNC = re.compile(r"(?m)^function\s+(\w+)\s+takes\s")
RX_INIT = re.compile(r"TriggerAddCondition\(\s*(gg_trg_\w+)\s*,\s*Condition\(function\s+(\w+)\)")
RX_ACT = re.compile(r"TriggerAddAction\(\s*(gg_trg_\w+)\s*,\s*function\s+(\w+)\)")
RX_MALL = re.compile(r'HasMallItem\(\s*[^,]+,\s*"([^"]+)"\s*\)\s*(==|!=)?\s*(true|false)?')
RX_PICK = re.compile(r"GetItemTypeId\(GetManipulatedItem\(\)\)\s*==\s*'([^']+)'")
DEADLY = ("CustomDefeatBJ", "RemoveUnit", "EndGame")


def split_funcs(text):
    marks = [(m.start(), m.group(1)) for m in RX_FUNC.finditer(text)]
    out = {}
    for i, (pos, name) in enumerate(marks):
        end = marks[i + 1][0] if i + 1 < len(marks) else len(text)
        out[name] = text[pos:end]
    return out


def analyze(path):
    return analyze_text(open(path, "rb").read().decode("utf-8", "surrogateescape"))


def analyze_text(text):
    funcs = split_funcs(text)
    cond_of, act_of = {}, {}
    for m in RX_INIT.finditer(text):
        cond_of[m.group(1)] = m.group(2)
    for m in RX_ACT.finditer(text):
        act_of[m.group(1)] = m.group(2)
    gates = []
    for trg, cond_name in cond_of.items():
        act_name = act_of.get(trg)
        body = funcs.get(cond_name, "")
        act = funcs.get(act_name, "")
        if not any(d in act for d in DEADLY):
            continue
        keys = []
        for m in RX_MALL.finditer(body):
            op = m.group(2) or ""
            val = m.group(3) or ""
            keys.append((m.group(1), ("%s %s" % (op, val)).strip()))
        others = sorted(set(re.findall(
            r"\b(Dz\w+|EX\w+|RequestExtra\w+)\s*\(", body)))
        lines = [ln.strip() for ln in body.split("\n") if ln.strip()]
        gates.append({"trig": trg, "cond": cond_name, "act": act_name, "keys": keys,
                      "others": others, "expr": " ".join(lines[1:])[:200],
                      "msg": " ".join(re.findall(r'"([^"]{2,60})"', act))[:120]})
    return gates


def keys_of_triggers_containing(text, needle):
    """返回"条件或动作里含 needle"的触发器用到的商城 key（条件和动作都扫）。"""
    funcs = split_funcs(text)
    cond_of, act_of = {}, {}
    for m in RX_INIT.finditer(text):
        cond_of[m.group(1)] = m.group(2)
    for m in RX_ACT.finditer(text):
        act_of[m.group(1)] = m.group(2)
    keys = set()
    for trg, act in act_of.items():
        cbody = funcs.get(cond_of.get(trg, ""), "")
        abody = funcs.get(act, "")
        if needle not in abody and needle not in cbody:
            continue
        for m in RX_MALL.finditer(cbody + "\n" + abody):
            keys.add(m.group(1))
    return keys


def risky_item_keys(text, unit_marker="RemoveUnit(gg_unit_"):
    """“福利白送的道具 = 一键跳过 / 一键清场”这一类福利要关掉，返回它们的商城 key。

    判据：存在触发器“拾取物品 X”时会 `RemoveUnit(gg_unit_*)` 掉一个**预置单位**
    （典型就是关卡 BOSS）。`194213` 第 2 章的实例：商城“征战之怒”(`TU66B`) 在开局 10 秒
    把 `I67I` 塞给主角，而拾取 `I67I` 的触发器里就是 `RemoveUnit(gg_unit_H64Z_0401)`
    —— 本关 BOSS“邪能之体”被直接删掉，主线任务物品“邪能能源”再也拿不到。

    必须在 `_patch_pet_delete.patch()` **之后**调用：宠物领取触发同样是“拾取物品 → 删预置单位”，
    但那个功能要保留（删块已被中和）。

    返回 (被标记的物品 id 列表, 需要强制 mall_false 的 key 集合)。
    """
    funcs = split_funcs(text)
    cond_of, act_of = {}, {}
    for m in RX_INIT.finditer(text):
        cond_of[m.group(1)] = m.group(2)
    for m in RX_ACT.finditer(text):
        act_of[m.group(1)] = m.group(2)
    risky = set()
    for trg, act in act_of.items():
        abody = funcs.get(act, "")
        if unit_marker not in abody:
            continue
        cbody = funcs.get(cond_of.get(trg, ""), "")
        risky.update(RX_PICK.findall(cbody))
        risky.update(RX_PICK.findall(abody))
    keys = set()
    for it in sorted(risky):
        keys |= keys_of_triggers_containing(text, "'%s'" % it)
    return sorted(risky), keys


def cache_poison_keys(text):
    """找出“会把状态写进玩家跨关卡存档”的商城福利 key，返回 (标记变量, key 集合)。

    链路：

        商城福利 A 的动作里            `set udg_X = 10`
        → 另一个以 `udg_X == 10` 为条件、
          动作里带 `SaveGameCache` 的触发器  把 X 写进存档

    这类福利会永久改掉之后的流程。`194213` 第 2 章实测：JDOLS5「敌人弱化」把
    `qianghua` 标记写进 `Save/ProfileN/Campaigns.w3v`，而博拉尔过场和 BOSS
    解封的条件都是 `udg_bobo == 0`（bobo 就是读这个标记）→ 主线永久卡死。
    """
    funcs = split_funcs(text)
    cond_of, act_of = {}, {}
    for m in RX_INIT.finditer(text):
        cond_of[m.group(1)] = m.group(2)
    for m in RX_ACT.finditer(text):
        act_of[m.group(1)] = m.group(2)
    sealed = set()
    for trg, act in act_of.items():
        body = funcs.get(act, "")
        if "SaveGameCache" not in body:
            continue
        for m in re.finditer(r"udg_(\w+)\s*==\s*10", funcs.get(cond_of.get(trg, ""), "")):
            sealed.add(m.group(1))
    setters = set()
    for name, body in funcs.items():
        for v in sealed:
            if re.search(r"set\s+udg_%s\s*=\s*10" % re.escape(v), body):
                setters.add(name)
    keys = set()
    for trg, act in act_of.items():
        if act not in setters:
            continue
        for src in (funcs.get(cond_of.get(trg, ""), ""), funcs.get(act, "")):
            for m in RX_MALL.finditer(src):
                if (m.group(2) or "") == "==":
                    keys.add(m.group(1))
    return sorted(sealed), keys


def weakness_perk_keys(text, marker="UnitAddAbilityBJ('A7BD'"):
    """「敌人弱化」福利的商城 key：它给**全场敌方单位**挂持续伤害。

    第 3 章有一个任务目标「能量产生器不能被摧毁」，产生器是敌方单位 —— 被这个 DOT
    烧掉就判负 + 清光玩家单位（实测：进第 3 章几秒后英雄和宠物一起消失）。
    """
    funcs = split_funcs(text)
    cond_of, act_of = {}, {}
    for m in RX_INIT.finditer(text):
        cond_of[m.group(1)] = m.group(2)
    for m in RX_ACT.finditer(text):
        act_of[m.group(1)] = m.group(2)
    keys = set()
    for trg, act in act_of.items():
        body = funcs.get(act, "")
        tree = body + "".join(funcs.get(c, "") for c in re.findall(r"function\s+(\w+)\)", body))
        if marker not in tree:
            continue
        for src in (funcs.get(cond_of.get(trg, ""), ""), body):
            for m in RX_MALL.finditer(src):
                if (m.group(2) or "") == "==":
                    keys.add(m.group(1))
    return sorted(keys)


def main():
    args = [a for a in sys.argv[1:] if not a.startswith("--only=")]
    only = next((a.split("=", 1)[1] for a in sys.argv[1:] if a.startswith("--only=")), "")
    allkeys = {}
    for p in args:
        gates = [g for g in analyze(p) if g["keys"] or g["others"]]
        if only:
            gates = [g for g in gates if only in g["msg"] or only in g["expr"]]
        if not gates:
            continue
        print("=== %s  门禁 %d 个" % (os.path.basename(p), len(gates)))
        for g in gates:
            print("   触发器 %s" % g["trig"])
            print("     条件: %s" % g["expr"])
            if g["keys"]:
                print("     商城道具: %s" % g["keys"])
            if g["others"]:
                print("     其它接口: %s" % g["others"])
            if g["msg"]:
                print("     提示: %s" % g["msg"])
            for k, op in g["keys"]:
                allkeys.setdefault(k, set()).add(op)
    print("\n=== 汇总：门禁用到的商城道具 key ===")
    for k in sorted(allkeys):
        print("   %-16s %s" % (k, sorted(allkeys[k])))


if __name__ == "__main__":
    main()
