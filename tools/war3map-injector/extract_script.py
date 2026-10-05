"""Extract war3map.j from a map using the HKE tool, for encoding inspection."""
import ctypes, os, sys, time, shutil
from ctypes import wintypes

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import inject_map as im

user32 = ctypes.windll.user32
LB_GETCOUNT = 0x018B
LB_GETTEXT = 0x0189
LB_SETCURSEL = 0x0186
WM_CLOSE = 0x0010


def find_main():
    out = []
    cb = ctypes.WINFUNCTYPE(ctypes.c_bool, wintypes.HWND, wintypes.LPARAM)
    def f(h, l):
        c = ctypes.create_unicode_buffer(256)
        user32.GetClassNameW(h, c, 256)
        if c.value == "THkeForm" and user32.IsWindowVisible(h):
            out.append(h)
        return True
    user32.EnumWindows(cb(f), 0)
    return out[0] if out else None


def get_lb(lb, idx):
    buf = ctypes.create_unicode_buffer(512)
    user32.SendMessageW(lb, LB_GETTEXT, idx, buf)
    return buf.value


def main():
    map_path = os.path.abspath(sys.argv[1])
    out_copy = os.path.abspath(sys.argv[2])

    im.subprocess.Popen([im.TOOL], cwd=im.TOOL_DIR)
    for _ in range(20):
        time.sleep(0.5)
        if find_main():
            break
    mainw = find_main()
    hdrop = im.make_dropfiles([map_path])
    user32.PostMessageW.argtypes = [wintypes.HWND, wintypes.UINT, ctypes.c_void_p, ctypes.c_void_p]
    user32.PostMessageW(mainw, im.WM_DROPFILES, ctypes.c_void_p(hdrop), None)
    time.sleep(4)

    b = im.find_child(mainw, "TButton", "分析文件")
    im.click_real(b[0])
    time.sleep(8)
    im.handle_popups()

    lb = im.find_child(mainw, "TListBox")[0]
    count = user32.SendMessageW(lb, LB_GETCOUNT, 0, 0)
    idx = -1
    for i in range(count):
        if "war3map.j" in get_lb(lb, i).lower():
            idx = i
    user32.SendMessageW(lb, LB_SETCURSEL, idx, 0)
    time.sleep(0.5)
    b = im.find_child(mainw, "TButton", "解压文件")
    im.click_real(b[0])
    time.sleep(3)
    im.handle_popups()
    time.sleep(2)
    user32.PostMessageW(mainw, WM_CLOSE, 0, 0)

    # find extracted file
    for root, dirs, files in os.walk(os.path.dirname(map_path)):
        for fn in files:
            if fn.lower() == "war3map.j":
                p = os.path.join(root, fn)
                if os.path.getmtime(p) > time.time() - 120:
                    shutil.copy2(p, out_copy)
                    print("saved", out_copy, os.path.getsize(p))
                    return 0
    print("not found")
    return 1


if __name__ == "__main__":
    sys.exit(main())
