# -*- coding: utf-8 -*-
"""把一个 .j 里的平台 native 声明就地换成存根函数，输出新 .j（不动地图）。"""
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import stub_platform_natives as S  # noqa: E402

# 有的图（如侏罗纪公园-轮回3）把平台 API 写成脚本包装函数，转调 RequestExtra* native，
# 这时存根替换不到它，要直接改函数体。
RX_MAPTEST = re.compile(
    r"(?m)^(function[ \t]+DzAPI_Map_IsMapTest[ \t]+takes[ \t]+nothing[ \t]+returns[ \t]+boolean[ \t]*\r?\n)"
    r"(?:.*?\r?\n)??(endfunction)")


def force_map_test(text):
    """让 DzAPI_Map_IsMapTest() 直接 return true（拆掉防盗版失败陷阱）。"""
    new, n = RX_MAPTEST.subn(lambda m: m.group(1) + "    return true\n" + m.group(2), text, count=1)
    return new, n


def main():
    src, dst = sys.argv[1], sys.argv[2]
    prefixes = tuple(p for p in (sys.argv[3] if len(sys.argv) > 3 else "Dz,EX,RequestExtra,LBK,Blz,JAPI")
                     .split(",") if p)
    map_test = "--no-map-test" not in sys.argv
    text = open(src, "rb").read().decode("latin-1")
    new, found, others = S.stub_block(text, prefixes, 100, True, in_place=True, map_test=map_test)
    print("就地替换 %d 个 native 声明 -> %d 个函数存根" % (len(found), len(found)))
    print("DzAPI_Map_IsMapTest() -> %s（拆掉防盗版失败陷阱）" % map_test)
    if map_test:
        new, n = force_map_test(new)
        print("      其中脚本包装函数的改写: %d 处" % n)
    if others:
        print("未动的 native 声明（%d 种）: %s" % (len(set(others)), ", ".join(sorted(set(others))[:40])))
    with open(dst, "wb") as f:
        f.write(new.encode("latin-1"))
    print("%s: %d -> %d 字节" % (dst, len(text), len(new)))


if __name__ == "__main__":
    main()
