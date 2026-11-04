# -*- coding: utf-8 -*-
"""把地图脚本里"平台原生函数"（DzAPI_* 等）的 native 声明换成同名普通函数存根。

背景（2026-10-12）：网易/KK 平台图常声明并调用 `native DzAPI_Map_*`（地图等级/商城/
平台存档）。这些原生函数只在"平台启动游戏 + 注入 JASS 加载器"时存在；单机直接开
War3.exe 没有这一层 -> 脚本初始化失败 -> 进不去（原版也一样）。把声明换成存根函数后，
图自带实现，单机/平台都能编译。

存根返回值按函数名给合理值：地图等级/排名 = --level（默认 100）、商城道具 = true
（全解锁，--no-mall 可关），其余 0/false/空串。

用法:
    python stub_platform_natives.py <地图> [--prefix DzAPI] [--level 100] [--no-mall] [--dry-run]
"""
import argparse
import os
import re
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import war3mpq as W  # noqa: E402

NATIVE_RE = re.compile(
    r"^[ \t]*native[ \t]+(?P<name>[A-Za-z_][A-Za-z0-9_]*)[ \t]+takes[ \t]+"
    r"(?P<args>[^\r\n]*?)[ \t]+returns[ \t]+(?P<ret>[A-Za-z_][A-Za-z0-9_]*)"
    r"[ \t]*(?://[^\r\n]*)?\r?$",
    re.M)


def mall_stub_body(args, mall_false, mall_true):
    """给 DzAPI_Map_HasMallItem 生成"按 key 判断"的存根体。

    试玩版门禁：`HasMallItem(p,"0000GS0006") != true` → 没买正式版 → 判负；
    `HasMallItem(p,"00S0M06") == true` → 命中试玩标记 → 也判负。
    所以正式版/守护类的 key 返回 true，试玩标记类的 key 返回 false。

    ⚠ 其余 key 一律 false（福利全关）。2026-10-13 实测教训：把商城福利全开时，
    有些福利触发器会**把"通关道具"塞给玩家**（例：燃烧之怒第2章
    `HasMallItem(p,"YUTUSZ")` → `UnitAddItemByIdSwapped('I67N', 主角)`），
    玩家一用它就 set gaoshi=10 → 下次单位死亡判胜 → 本章提前结束。
    需要某个福利时再单独加进 mall_true 白名单。
    """
    lines = []
    for k in sorted(set(mall_false)):
        lines.append('    if key == "%s" then' % k)
        lines.append("        return false")
        lines.append("    endif")
    for k in sorted(set(mall_true)):
        lines.append('    if key == "%s" then' % k)
        lines.append("        return true")
        lines.append("    endif")
    lines.append("    return true")
    return lines


def default_value(name, ret, level, mall, map_test=True):
    low = name.lower()
    if ret == "nothing":
        return None
    if ret == "boolean":
        # DzAPI_Map_IsMapTest()：作者的防盗版陷阱全靠它——
        #   if (HasMallItem(p,"JDJ001") or HasMallItem(p,"CJVVVVVIP")) and IsMapTest() == false then 全员失败
        # 破解版（商城道具全开）必然踩中；这个函数全图只有这一处用途，
        # 让它返回 true 就等于只拆这一个陷阱，商城道具照旧全开。
        if low.endswith("ismaptest"):
            return "true" if map_test else "false"
        if "mall" in low:
            return "true" if mall else "false"
        return "false"
    if ret == "integer":
        if "level" in low or "rank" in low:
            return str(level)
        return "0"
    if ret == "real":
        if "level" in low or "rank" in low:
            return "%d.0" % level
        return "0.0"
    if ret == "string":
        return '""'
    return "null"


def stub_block(text, prefix, level, mall, in_place=False, map_test=True,
               mall_false=(), mall_true=()):
    """返回 (新文本, [(name, args, ret)], 其它未替换的 native 名)。

    in_place=True 时把存根**写在 native 声明原来的位置**。
    JASS 是"先定义后使用"（Doctor 反编译出的脚本也是 natives 全部排在
    function 之前），所以追加到文件末尾会让调用点找不到函数 → 编译失败
    → 地图进不去。默认 in_place=False 只是保持旧行为。
    """
    found = []
    others = []

    def repl(m):
        name, args, ret = m.group("name"), m.group("args").strip(), m.group("ret")
        if not name.startswith(prefix):
            others.append(name)
            return m.group(0)
        found.append((name, args, ret))
        body = None
        if "hasmallitem" in name.lower() and mall:
            body = mall_stub_body(args, mall_false, mall_true)
        if in_place:
            out = ["function %s takes %s returns %s" % (name, args or "nothing", ret)]
            if body is not None:
                out += body
            else:
                val = default_value(name, ret, level, mall, map_test)
                if val is not None:
                    out.append("    return %s" % val)
            out.append("endfunction")
            return "\n".join(out)
        return ""

    text = NATIVE_RE.sub(repl, text)
    if not found:
        return text, [], others
    if in_place:
        return text, found, others
    lines = ["", "// ===== platform-native stubs (single-player capable; by stub_platform_natives.py) ====="]
    for name, args, ret in found:
        lines.append("function %s takes %s returns %s" % (name, args or "nothing", ret))
        val = default_value(name, ret, level, mall, map_test)
        if val is not None:
            lines.append("    return %s" % val)
        lines += ["endfunction", ""]
    return text + "\n".join(lines) + "\n", found, others


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("map")
    ap.add_argument("--prefix", default="Dz,EX",
                    help="要替换的原生函数名前缀，逗号分隔（默认 Dz,EX —— 平台 API 与 JAPI 扩展）")
    ap.add_argument("--level", type=int, default=100)
    ap.add_argument("--no-mall", action="store_true")
    ap.add_argument("--no-map-test", action="store_true",
                    help="DzAPI_Map_IsMapTest() 返回 false（默认 true：拆掉作者的防盗版失败陷阱）")
    ap.add_argument("--in-place", action="store_true",
                    help="存根写在原 native 声明处（保持『先定义后使用』，默认追加到文件末尾）")
    ap.add_argument("--out")
    ap.add_argument("--dry-run", action="store_true")
    a = ap.parse_args()
    map_path = os.path.abspath(a.map)
    ar = W.MPQArchive(map_path)
    try:
        orig = ar.read_file("war3map.j")
    finally:
        ar.close()
    if not orig:
        raise SystemExit("读不到 war3map.j")
    text = orig.decode("latin-1")
    prefixes = tuple(p for p in a.prefix.split(",") if p)
    new_text, found, others = stub_block(text, prefixes, a.level, not a.no_mall, a.in_place,
                                         not a.no_map_test)
    print("替换成存根的原生函数 %d 个：" % len(found))
    for n, args, ret in found:
        print("   %-34s (%s) -> %s" % (n, args or "nothing",
                                       default_value(n, ret, a.level, not a.no_mall,
                                                     not a.no_map_test) or "void"))
    if others:
        uniq = sorted(set(others))
        print("其它 native 声明（未动，%d 种）: %s" % (len(uniq), ", ".join(uniq[:60])))
    if not found:
        import re as _re
        dash = [l for l in text.split("\n") if "native" in l][:3]
        print("（诊断）脚本里含 native 的行样例：")
        for l in dash:
            print("   %r" % l[:120])
        print("没有可替换的声明，退出。")
        return 0
    new = new_text.encode("latin-1")
    print("脚本 %d -> %d 字节" % (len(orig), len(new)))
    if a.dry_run:
        return 0
    outp = os.path.join(HERE, "_rep", "war3map.j")
    os.makedirs(os.path.dirname(outp), exist_ok=True)
    open(outp, "wb").write(new)
    target = os.path.abspath(a.out) if a.out else map_path
    if target != map_path:
        import shutil
        shutil.copy2(map_path, target)
    cmd = [sys.executable, os.path.join(HERE, "inject_native.py"), target,
           "--file", outp + "=war3map.j"]
    print(">>>", " ".join(cmd))
    r = subprocess.run(cmd, capture_output=True)
    sys.stdout.buffer.write(r.stdout + r.stderr)
    return r.returncode


if __name__ == "__main__":
    sys.exit(main())
