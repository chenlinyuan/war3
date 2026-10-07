"""提取地图内指定文件到指定输出路径（用 HKE）。"""
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
    map_dir = os.path.dirname(map_path)

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
    lbs = im.find_child(h, "TListBox")
    lb = lbs[0]
    count = user32.SendMessageW(lb, LB_GETCOUNT, 0, 0)
    idx = -1
    for i in range(count):
        buf = ctypes.create_unicode_buffer(512)
        user32.SendMessageW(lb, LB_GETTEXT, i, buf)
        if buf.value.lower() == target.lower():
            idx = i
    if idx < 0:
        print("未找到", target)
        user32.PostMessageW(h, WM_CLOSE, 0, 0)
        return 1
    user32.SendMessageW(lb, LB_SETCURSEL, idx, 0)
    time.sleep(0.5)
    b = im.find_child(h, "TButton", "解压文件")
    im.click_real(b[0])
    time.sleep(3)
    im.handle_popups()
    time.sleep(2)
    user32.PostMessageW(h, WM_CLOSE, 0, 0)
    time.sleep(1)
    im.subprocess.run(["taskkill", "/IM", "HkeW3mModifier2.0.exe", "/F"], capture_output=True)

    # 查找解压出的文件
    for d in [map_dir, im.TOOL_DIR]:
        for root, dirs, files in os.walk(d):
            for fn in files:
                if fn.lower() == target.lower():
                    p = os.path.join(root, fn)
                    if os.path.getmtime(p) > time.time() - 120:
                        shutil.copy2(p, out_path)
                        print("saved", out_path, os.path.getsize(p))
                        return 0
    print("未找到解压文件")
    return 1


if __name__ == "__main__":
    sys.exit(main())
