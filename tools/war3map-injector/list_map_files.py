"""List all internal files of a map via HKE 分析文件."""
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
    print("文件数:", count)
    for i in range(count):
        buf = ctypes.create_unicode_buffer(512)
        user32.SendMessageW(lb, LB_GETTEXT, i, buf)
        print("  ", buf.value)
    user32.PostMessageW(h, WM_CLOSE, 0, 0)
    time.sleep(1)
    im.subprocess.run(["taskkill", "/IM", "HkeW3mModifier2.0.exe", "/F"], capture_output=True)


if __name__ == "__main__":
    main()
