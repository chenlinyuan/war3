"""Extract a non-script file (w3a/w3t/etc) from a map, handling the save dialog."""
import ctypes, os, sys, time, shutil
from ctypes import wintypes

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import inject_map as im

user32 = ctypes.windll.user32
LB_GETCOUNT = 0x018B
LB_GETTEXT = 0x0189
LB_SETCURSEL = 0x0186
WM_CLOSE = 0x0010


def main():
    map_path = os.path.abspath(sys.argv[1])
    target = sys.argv[2]
    out_path = os.path.abspath(sys.argv[3])

    im.subprocess.Popen([im.TOOL], cwd=im.TOOL_DIR)
    for _ in range(20):
        time.sleep(0.5)
        if im.find_window(im.MAIN_TITLE):
            break
    h = im.find_window(im.MAIN_TITLE)
    hdrop = im.make_dropfiles([map_path])
    user32.PostMessageW.argtypes = [wintypes.HWND, wintypes.UINT, ctypes.c_void_p, ctypes.c_void_p]
    user32.PostMessageW(h, im.WM_DROPFILES, ctypes.c_void_p(hdrop), None)
    time.sleep(4)
    b = im.find_child(h, "TButton", "分析文件")
    im.click_real(b[0])
    time.sleep(8)
    im.handle_popups()

    lb = im.find_child(h, "TListBox")[0]
    count = user32.SendMessageW(lb, LB_GETCOUNT, 0, 0)
    idx = -1
    for i in range(count):
        buf = ctypes.create_unicode_buffer(512)
        user32.SendMessageW(lb, LB_GETTEXT, i, buf)
        if buf.value.lower() == target.lower():
            idx = i
    if idx < 0:
        print("未找到", target)
        return 1
    user32.SendMessageW(lb, LB_SETCURSEL, idx, 0)
    time.sleep(0.5)
    b = im.find_child(h, "TButton", "解压文件")
    im.click_real(b[0])
    time.sleep(3)

    # 处理可能出现的保存对话框
    for _ in range(10):
        handled = False
        for dh, dt in im.list_dialogs():
            edits = im.find_child(dh, "Edit")
            if edits:
                user32.SendMessageW(edits[0], 0x000C, 0, ctypes.c_wchar_p(out_path))
                time.sleep(0.3)
            sb = im.find_child(dh, "Button", "保存(&S)") or im.find_child(dh, "Button", "保存") \
                or im.find_child(dh, "Button", "确定")
            if sb:
                im.click_real(sb[0])
                handled = True
                time.sleep(1)
                break
        if not handled:
            break
    im.handle_popups()
    time.sleep(2)
    user32.PostMessageW(h, WM_CLOSE, 0, 0)
    time.sleep(1)
    im.subprocess.run(["taskkill", "/IM", "HkeW3mModifier2.0.exe", "/F"], capture_output=True)

    if os.path.exists(out_path):
        print("saved", out_path, os.path.getsize(out_path))
        return 0
    # 搜索最近文件
    map_dir = os.path.dirname(map_path)
    for d in [map_dir, im.TOOL_DIR]:
        for root, dirs, files in os.walk(d):
            for fn in files:
                if fn.lower() == target.lower():
                    p = os.path.join(root, fn)
                    if os.path.getmtime(p) > time.time() - 120:
                        shutil.copy2(p, out_path)
                        print("saved(recent)", out_path, os.path.getsize(p))
                        return 0
    print("未找到解压文件")
    return 1


if __name__ == "__main__":
    sys.exit(main())
