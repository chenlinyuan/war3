# -*- coding: utf-8 -*-
"""校验注入结果：开一次 HKE，解压并检查地图内的脚本与数据文件。

用法:
    python verify_inject.py <地图> [源文件=内部名 ...]

示例:
    python verify_inject.py maps/LostTemple/LostTemple_ft_hand.w3x
    python verify_inject.py maps/x.w3x tools/war3map-injector/_hand.w3t=war3map.w3t

检查内容:
  * war3map.j 里 IB_Init 是否存在、call IB_Init() 是否恰好 1 处
  * 自定义全局变量是否排在 endglobals 之后（否则 JASS 编译失败、脚本不执行）
  * 指定文件是否与源文件逐字节一致
"""
import hashlib
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

import hke_session as hk   # noqa: E402

ANCHOR = "integer array ib_itemList"


def globals_order_ok(text):
    """我们的非 constant 变量是否排在所有 constant 声明之后。

    JASS 要求 constant 声明在前，否则整张图编译失败（表现：脚本不执行）。
    这里按行判断，避免被 YDWE 的 `//endglobals from XXX` 注释干扰。
    """
    lines = text.split("\n")
    g_start = g_end = None
    for i, ln in enumerate(lines):
        s = ln.strip()
        if s == "globals" and g_start is None:
            g_start = i
        elif s == "endglobals" and g_start is not None:
            g_end = i
            break
    if g_start is None or g_end is None:
        return None, "找不到 globals 块"
    last_const = -1
    anchor = -1
    for i in range(g_start, g_end):
        s = lines[i].strip()
        if s.startswith("constant "):
            last_const = i
        if ANCHOR in lines[i]:
            anchor = i
    if anchor < 0:
        return None, "globals 块里没有 %s" % ANCHOR
    return anchor > last_const, "变量在第 %d 行, 最后 constant 在第 %d 行" % (anchor, last_const)


def main():
    if len(sys.argv) < 2:
        print(__doc__)
        return 1
    map_path = os.path.abspath(sys.argv[1])
    pairs = [tuple(a.split("=", 1)) for a in sys.argv[2:]]
    if not os.path.isfile(map_path):
        print("地图不存在: %s" % map_path)
        return 1

    ok = True
    sess = hk.HkeSession()
    try:
        sess.start()
        sess.open(map_path)
        files = sess.analyze()
        print("内部文件 %d 个" % len(files))

        data = sess.extract("war3map.j")
        text = data.decode("latin-1")
        has_def = "IB_Init" in text
        calls = data.count(b"call IB_Init()")
        ordered, detail = globals_order_ok(text)
        print("war3map.j %d 字节: IB_Init 定义=%s, call IB_Init()=%d 处, 变量顺序正确=%s (%s)"
              % (len(data), has_def, calls, ordered, detail))
        if not has_def or calls != 1 or ordered is False:
            ok = False

        for src, name in pairs:
            got = sess.extract(name)
            ref = open(src, "rb").read()
            same = hashlib.sha256(got).hexdigest() == hashlib.sha256(ref).hexdigest()
            print("%-16s %7d 字节, 与源文件一致=%s" % (name, len(got), same))
            if not same:
                ok = False
    except hk.HkeError as e:
        print("校验失败: %s" % e)
        ok = False
    finally:
        sess.close()

    print("=== %s ===" % ("校验通过" if ok else "校验未通过"))
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
