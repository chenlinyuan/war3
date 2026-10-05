"""通过 WM_DROPFILES 拖放打开地图，绕过文件对话框。

HkeW3mModifier 支持拖放打开地图（文档："未打开地图是支持拖放进窗口打开了"）。
"""
import ctypes
import sys
import time
from ctypes import wintypes

user32 = ctypes.windll.user32
shell32 = ctypes.windll.shell32
kernel32 = ctypes.windll.kernel32

WM_DROPFILES = 0x0233
GMEM_MOVEABLE = 0x0002
GMEM_ZEROINIT = 0x0040

WINDOW_TITLE = "hkeW3MModifier 2.05(071224平安夜特别版)"


class DROPFILES(ctypes.Structure):
    _fields_ = [
        ("pFiles", wintypes.DWORD),
        ("pt", wintypes.POINT),
        ("fNC", wintypes.BOOL),
        ("fWide", wintypes.BOOL),
    ]


def make_dropfiles(files):
    """构造 HDROP 全局内存。"""
    names = "\0".join(files) + "\0\0"
    data = names.encode("utf-16-le")
    header = DROPFILES()
    header.pFiles = ctypes.sizeof(DROPFILES)
    header.fWide = True
    hdr_bytes = bytes(header)
    buf = hdr_bytes + data

    kernel32.GlobalAlloc.restype = ctypes.c_void_p
    kernel32.GlobalAlloc.argtypes = [wintypes.UINT, ctypes.c_size_t]
    kernel32.GlobalLock.restype = ctypes.c_void_p
    kernel32.GlobalLock.argtypes = [ctypes.c_void_p]
    kernel32.GlobalUnlock.argtypes = [ctypes.c_void_p]

    hglobal = kernel32.GlobalAlloc(GMEM_MOVEABLE | GMEM_ZEROINIT, len(buf))
    if not hglobal:
        raise MemoryError("GlobalAlloc 失败")
    ptr = kernel32.GlobalLock(hglobal)
    if not ptr:
        raise MemoryError("GlobalLock 失败")
    ctypes.memmove(ptr, buf, len(buf))
    kernel32.GlobalUnlock(hglobal)
    return hglobal


def find_window(title, cls=None):
    return user32.FindWindowW(cls, title)


def enum_children(parent):
    result = []
    cb_type = ctypes.WINFUNCTYPE(ctypes.c_bool, wintypes.HWND, wintypes.LPARAM)

    def cb(h, l):
        c = ctypes.create_unicode_buffer(256)
        user32.GetClassNameW(h, c, 256)
        t = ctypes.create_unicode_buffer(256)
        user32.GetWindowTextW(h, t, 256)
        result.append((h, c.value, t.value))
        return True

    user32.EnumChildWindows(parent, cb_type(cb), 0)
    return result


def find_child(parent, cls=None, text=None):
    return [h for h, c, t in enum_children(parent)
            if (cls is None or c == cls) and (text is None or text in t)]


def get_text(hwnd):
    buf = ctypes.create_unicode_buffer(512)
    user32.GetWindowTextW(hwnd, buf, 512)
    return buf.value


def click_real(hwnd):
    rect = wintypes.RECT()
    user32.GetWindowRect(hwnd, ctypes.byref(rect))
    x = (rect.left + rect.right) // 2
    y = (rect.top + rect.bottom) // 2
    user32.SetForegroundWindow(hwnd)
    time.sleep(0.2)
    user32.SetCursorPos(x, y)
    time.sleep(0.15)
    user32.mouse_event(0x0002, 0, 0, 0, 0)
    time.sleep(0.05)
    user32.mouse_event(0x0004, 0, 0, 0, 0)
    time.sleep(0.3)


def list_dialogs():
    out = []
    cb_type = ctypes.WINFUNCTYPE(ctypes.c_bool, wintypes.HWND, wintypes.LPARAM)

    def cb(h, l):
        c = ctypes.create_unicode_buffer(256)
        user32.GetClassNameW(h, c, 256)
        if c.value == "#32770" and user32.IsWindowVisible(h):
            t = ctypes.create_unicode_buffer(256)
            user32.GetWindowTextW(h, t, 256)
            out.append((h, t.value))
        return True

    user32.EnumWindows(cb_type(cb), 0)
    return out


def handle_popups():
    for dh, dt in list_dialogs():
        print("  弹窗: %r" % dt)
        for btn in find_child(dh, "Button"):
            lbl = get_text(btn)
            print("    按钮: %r" % lbl)
            if any(k in lbl for k in ("确定", "OK", "是", "Yes", "保存")):
                click_real(btn)
                print("    已点击")
                time.sleep(1)
                break


def main():
    map_path = sys.argv[1]
    hwnd = find_window(WINDOW_TITLE)
    if not hwnd:
        print("未找到工具窗口")
        return 1
    print("主窗口: %#x" % hwnd)

    # 通过拖放打开地图
    print("[1] 拖放打开地图")
    hdrop = make_dropfiles([map_path])
    user32.PostMessageW.argtypes = [wintypes.HWND, wintypes.UINT, ctypes.c_void_p, ctypes.c_void_p]
    user32.PostMessageW.restype = wintypes.BOOL
    user32.PostMessageW(hwnd, WM_DROPFILES, ctypes.c_void_p(hdrop), None)
    time.sleep(4)
    handle_popups()

    lb = find_child(hwnd, "TListBox")
    if lb:
        cnt = user32.SendMessageW(lb[0], 0x018B, 0, 0)
        print("  文件列表项数: %d" % cnt)

    print("[2] 注入脚本")
    b = find_child(hwnd, "TButton", "注入脚本")
    if b:
        click_real(b[0])
        print("  已点击")
    time.sleep(3)
    handle_popups()

    print("[3] 重压缩")
    b = find_child(hwnd, "TButton", "重压缩")
    if b:
        click_real(b[0])
        print("  已点击")
    time.sleep(3)
    handle_popups()

    time.sleep(3)
    print("完成")
    return 0


if __name__ == "__main__":
    sys.exit(main())
