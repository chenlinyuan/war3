"""Extract ALL files from a map using the HKE tool (分析文件 -> 全部解压)."""
import ctypes, os, sys, time
from ctypes import wintypes

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import inject_map as im

user32 = ctypes.windll.user32
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


def main():
    map_path = os.path.abspath(sys.argv[1])
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

    # Click 全部解压
    b = im.find_child(mainw, "TButton", "全部解压")
    if not b:
        print("no 全部解压 button")
        return 1
    im.click_real(b[0])
    time.sleep(4)
    im.handle_popups()
    time.sleep(3)
    user32.PostMessageW(mainw, WM_CLOSE, 0, 0)
    time.sleep(1)
    # 确保工具进程退出，避免占用地图文件
    im.subprocess.run(["taskkill", "/IM", "HkeW3mModifier2.0.exe", "/F"], capture_output=True)

    # find extracted dir
    base = os.path.dirname(map_path)
    for root, dirs, files in os.walk(base):
        if files and any(f.endswith((".w3i", ".w3e", ".wts", ".w3a", ".w3u")) for f in files):
            print("extracted to:", root)
            for f in sorted(files):
                print("  ", f, os.path.getsize(os.path.join(root, f)))
            return 0
    print("not found")
    return 1


if __name__ == "__main__":
    sys.exit(main())
