"""Dump a map's internal file list (via HKE 分析文件) to a text file.

Usage:
    python dump_filelist.py <map> <out.txt>
"""
import ctypes, os, sys, time
from ctypes import wintypes
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import inject_map as im

user32 = ctypes.windll.user32
LB_GETCOUNT = 0x018B
LB_GETTEXT = 0x0189
WM_CLOSE = 0x0010


def main():
    map_path = os.path.abspath(sys.argv[1])
    out_path = os.path.abspath(sys.argv[2])
    im.subprocess.Popen([im.TOOL], cwd=im.TOOL_DIR)
    h = None
    for _ in range(40):
        time.sleep(0.5)
        h = im.find_window(im.MAIN_TITLE)
        if h:
            break
    if not h:
        print("HKE 主窗口未出现")
        return 1
    print("HKE 窗口:", hex(h), flush=True)

    # 用「打开地图」按钮（比拖放可靠；454MB 大图拖放常不触发）
    im.open_map_via_button(h, map_path)
    print("地图已打开，等待分析...", flush=True)
    time.sleep(10)
    im.handle_popups()
    time.sleep(5)

    b = im.find_child(h, "TButton", "分析文件")
    if not b:
        print("未找到 分析文件 按钮")
        im.close_tool()
        return 1
    im.click_real(b[0])
    print("点击 分析文件，等待...", flush=True)
    time.sleep(30)
    im.handle_popups()
    time.sleep(10)

    lbs = im.find_child(h, "TListBox")
    if not lbs:
        print("未找到列表")
        im.close_tool()
        return 1
    lb = lbs[0]
    count = user32.SendMessageW(lb, LB_GETCOUNT, 0, 0)
    out = []
    for i in range(count):
        buf = ctypes.create_unicode_buffer(1024)
        user32.SendMessageW(lb, LB_GETTEXT, i, buf)
        out.append(buf.value)
    open(out_path, "w", encoding="utf-8").write("\n".join(out))
    print("wrote %d files -> %s" % (len(out), out_path), flush=True)

    user32.PostMessageW(h, WM_CLOSE, 0, 0)
    time.sleep(1)
    im.close_tool()
    return 0


if __name__ == "__main__":
    sys.exit(main())
