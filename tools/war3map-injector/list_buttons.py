"""列出 HkeW3mModifier 主窗口所有按钮，便于定位。"""
import ctypes
import os
import sys
import time
from ctypes import wintypes

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import inject_map as im

user32 = ctypes.windll.user32


def enum_top():
    out = []
    cb = ctypes.WINFUNCTYPE(ctypes.c_bool, wintypes.HWND, wintypes.LPARAM)
    def f(h, l):
        t = ctypes.create_unicode_buffer(256)
        user32.GetWindowTextW(h, t, 256)
        c = ctypes.create_unicode_buffer(256)
        user32.GetClassNameW(h, c, 256)
        if user32.IsWindowVisible(h) and t.value:
            out.append((h, c.value, t.value))
        return True
    user32.EnumWindows(cb(f), 0)
    return out


def main():
    # 找到已有的 HKE 主窗口
    mainw = None
    for h, c, t in enum_top():
        if c == "THkeForm":
            mainw = h
            break
    if not mainw:
        print("未找到 HKE 主窗口，请先启动工具并打开地图")
        return 1
    print("主窗口: %#x %s" % (mainw, im.get_text(mainw)))
    print("子控件:")
    for h, c, t in im.enum_children(mainw):
        print("  %#x %-16s %r" % (h, c, t))
    return 0


if __name__ == "__main__":
    sys.exit(main())
