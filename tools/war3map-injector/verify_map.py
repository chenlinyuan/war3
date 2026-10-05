"""用 HkeW3mModifier2.0 的「分析文件 -> 选择 war3map.j -> 解压文件」验证地图内脚本。

用法:
    python verify_map.py <地图路径> [输出目录]
"""
import ctypes
import os
import sys
import time
from ctypes import wintypes

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import inject_map as im

user32 = ctypes.windll.user32
LB_GETCOUNT = 0x018B
LB_GETTEXT = 0x0189
LB_SETCURSEL = 0x0186
WM_CLOSE = 0x0010


def enum_top_visible():
    out = []
    cb = ctypes.WINFUNCTYPE(ctypes.c_bool, wintypes.HWND, wintypes.LPARAM)
    def f(h, l):
        t = ctypes.create_unicode_buffer(256)
        user32.GetWindowTextW(h, t, 256)
        c = ctypes.create_unicode_buffer(256)
        user32.GetClassNameW(h, c, 256)
        if user32.IsWindowVisible(h):
            out.append((h, c.value, t.value))
        return True
    user32.EnumWindows(cb(f), 0)
    return out


def find_main():
    for h, c, t in enum_top_visible():
        if c == "THkeForm":
            return h
    return None


def get_lb_item(lb, idx):
    buf = ctypes.create_unicode_buffer(512)
    user32.SendMessageW(lb, LB_GETTEXT, idx, buf)
    return buf.value


def main():
    if len(sys.argv) < 2:
        print(__doc__)
        return 1
    map_path = os.path.abspath(sys.argv[1])

    im.subprocess.Popen([im.TOOL], cwd=im.TOOL_DIR)
    for _ in range(20):
        time.sleep(0.5)
        if find_main():
            break
    mainw = find_main()
    if not mainw:
        print("工具未启动")
        return 1
    print("主窗口: %#x" % mainw)

    hdrop = im.make_dropfiles([map_path])
    user32.PostMessageW.argtypes = [wintypes.HWND, wintypes.UINT, ctypes.c_void_p, ctypes.c_void_p]
    user32.PostMessageW(mainw, im.WM_DROPFILES, ctypes.c_void_p(hdrop), None)
    time.sleep(4)
    print("标题:", im.get_text(mainw))

    b = im.find_child(mainw, "TButton", "分析文件")
    if not b:
        print("未找到『分析文件』按钮")
        return 1
    im.click_real(b[0])
    print("已点击分析文件，等待分析...")
    time.sleep(8)
    im.handle_popups()

    lbs = im.find_child(mainw, "TListBox")
    if not lbs:
        print("未找到文件列表")
        return 1
    lb = lbs[0]
    count = user32.SendMessageW(lb, LB_GETCOUNT, 0, 0)
    print("列表项数:", count)

    target_idx = -1
    for i in range(count):
        txt = get_lb_item(lb, i)
        if "war3map.j" in txt.lower():
            target_idx = i
            print("找到:", i, txt)
    if target_idx < 0:
        print("列表中未找到 war3map.j")
        for i in range(min(count, 30)):
            print("  ", i, get_lb_item(lb, i))
        return 1

    user32.SendMessageW(lb, LB_SETCURSEL, target_idx, 0)
    time.sleep(0.5)

    b = im.find_child(mainw, "TButton", "解压文件")
    if not b:
        print("未找到『解压文件』按钮")
        return 1
    im.click_real(b[0])
    time.sleep(3)
    im.handle_popups()
    time.sleep(2)

    print("查找解压文件...")
    found = None
    search_dirs = [os.path.dirname(map_path), im.TOOL_DIR]
    for d in search_dirs:
        for root, dirs, files in os.walk(d):
            for fn in files:
                if fn.lower() == "war3map.j":
                    p = os.path.join(root, fn)
                    if os.path.getmtime(p) > time.time() - 120:
                        found = p

    if not found:
        print("未找到解压出的 war3map.j")
        user32.PostMessageW(mainw, WM_CLOSE, 0, 0)
        return 1

    print("解压文件:", found, os.path.getsize(found), "bytes")
    with open(found, "r", encoding="utf-8", errors="replace") as fh:
        txt = fh.read()
    ok = True
    for marker in ("IB_Init", "IB_Search", "IB_AddItem", "IB_AddByIndex",
                   "PY_Convert", "PY_Matches", "PY_InitTable", "ib_lastResult"):
        present = marker in txt
        ok = ok and present
        print("  marker %-16s -> %s" % (marker, present))
    user32.PostMessageW(mainw, WM_CLOSE, 0, 0)
    print("结果:", "全部存在" if ok else "缺少标记")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
