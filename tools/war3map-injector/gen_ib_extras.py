# -*- coding: utf-8 -*-
"""给"物品浏览器"（scripts/item-browser）生成**本系统自己那几件东西**的补充表。

为什么要它：
  * 物品浏览器里的 物品/技能/单位 表是**按图预先扫描并硬编码**进 f.j 的；
  * 我们的翅膀、蛋、阿克蒙德之手是**注入时才加进地图**的，那张表里当然没有
    于是 `additem 阿克蒙德之手` 会找不到（这次玩家反馈的就是这个）。
  * 所以移植时按当前配置生成 `_itemids_extra.txt` 之类，交给 `build_fj.py`
    一起并进 f.j。名字直接从生成好的对象数据里读（不另维护一份文案）。

用法:
    python gen_ib_extras.py <输出目录> [配置模块名]
输出:
    <输出目录>/_itemids_extra.txt     flag<TAB>id<TAB>name
"""
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import hand_data  # noqa: E402


def item_names(w3t_path):
    """从 w3t 里读 {itemId: 名称}（名称取 unam）。"""
    _v, orig, cust = hand_data.read_entries(w3t_path)
    out = {}
    for group in (orig, cust):
        for old, new, mods in group:
            d = {m[0]: m[4] for m in mods}
            nm = d.get("unam") or d.get("utip") or new
            out[new] = str(nm)
    return out


def strip_color(s):
    """去掉 |cffXXXXXX / |r 之类的颜色代码（物品浏览器里名字是按纯文本搜索的）。"""
    out = []
    i = 0
    while i < len(s):
        if s[i] == "|" and i + 1 < len(s) and s[i + 1] in "cCrR":
            if s[i + 1] in "cC":
                i += 10
            else:
                i += 2
            continue
        out.append(s[i])
        i += 1
    return "".join(out)


def our_item_ids(cfg):
    """本系统要出现在物品表里的物品：(ID, 别名列表)。

    别名列表 = 配置里的名字（`wing 炽天使` 那种叫法）+ 物品数据里的名字（unam）。
    两个都可能被玩家敲（`additem 炽天使之翼` / `additem 天使之翼`），所以都收进表里。
    """
    out = [(cfg.HAND["item"], ["阿克蒙德之手"])]
    for w in cfg.WINGS:
        out.append((w["item"], [w["name"]]))
    for m in cfg.MOUNTS:
        out.append((m["egg"], [m["name"] + "蛋"]))
    return out


def build(out_dir, cfg=None):
    if cfg is None:
        cfg = __import__(os.environ.get("WINGS_CONFIG", "wings_config"))
    names = item_names(os.path.join(HERE, "_wing_item.w3t"))
    lines, seen = [], set()
    for iid, aliases in our_item_ids(cfg):
        got = [strip_color(n).strip() for n in aliases if n]
        actual = strip_color(names.get(iid, "")).strip()
        if actual and actual not in got:
            got.append(actual)
        for nm in got:
            if not nm or (iid, nm) in seen:
                continue
            seen.add((iid, nm))
            lines.append("C\t%s\t%s" % (iid, nm))
    os.makedirs(out_dir, exist_ok=True)
    out = os.path.join(out_dir, "_itemids_extra.txt")
    with open(out, "w", encoding="utf-8") as fh:
        fh.write("\n".join(lines) + "\n")
    print("写出 %s: %d 条（%s）" % (out, len(lines),
                                   ", ".join(l.split("\t")[1] for l in lines)))
    return out


def main():
    if len(sys.argv) < 2:
        print(__doc__)
        return 1
    build(sys.argv[1])
    return 0


if __name__ == "__main__":
    sys.exit(main())
