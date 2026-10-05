"""一键注入 War3 地图脚本（使用 HkeW3mModifier2.0）。

完整流程：
  1. 复制 f.j/g.j/m.j 到 HkeData
  2. 启动 HkeW3mModifier2.0
  3. 拖放打开地图
  4. 点击「注入脚本」->「注入到本图」-> 确定
  5. 点击「重压缩」保存

用法:
    python inject_map.py <地图路径> [脚本目录]

示例:
    python inject_map.py "maps/LostTemple/LostTemple.w3m" scripts/item-browser
"""
import ctypes
import os
import shutil
import subprocess
import sys
import time
from ctypes import wintypes

user32 = ctypes.windll.user32
kernel32 = ctypes.windll.kernel32

WM_DROPFILES = 0x0233
GMEM_MOVEABLE = 0x0002
GMEM_ZEROINIT = 0x0040
WM_CLOSE = 0x0010

TOOL = r"H:\Games\War3\Tools\151个常用脚本\脚本\HKE1.25(5.17美化版）\HKE1.25(5.17美化版）\HkeW3mModifier2.0.exe"
TOOL_DIR = os.path.dirname(TOOL)
HKE_DATA = os.path.join(TOOL_DIR, "HkeData")
MAIN_TITLE = "hkeW3MModifier 2.05(071224平安夜特别版)"


# ---------------------------------------------------------------------------
# Win32 辅助
# ---------------------------------------------------------------------------
class DROPFILES(ctypes.Structure):
    _fields_ = [
        ("pFiles", wintypes.DWORD),
        ("pt", wintypes.POINT),
        ("fNC", wintypes.BOOL),
        ("fWide", wintypes.BOOL),
    ]


def make_dropfiles(files):
    names = "\0".join(files) + "\0\0"
    data = names.encode("utf-16-le")
    header = DROPFILES()
    header.pFiles = ctypes.sizeof(DROPFILES)
    header.fWide = True
    buf = bytes(header) + data

    kernel32.GlobalAlloc.restype = ctypes.c_void_p
    kernel32.GlobalAlloc.argtypes = [wintypes.UINT, ctypes.c_size_t]
    kernel32.GlobalLock.restype = ctypes.c_void_p
    kernel32.GlobalLock.argtypes = [ctypes.c_void_p]
    kernel32.GlobalUnlock.argtypes = [ctypes.c_void_p]

    h = kernel32.GlobalAlloc(GMEM_MOVEABLE | GMEM_ZEROINIT, len(buf))
    ptr = kernel32.GlobalLock(h)
    ctypes.memmove(ptr, buf, len(buf))
    kernel32.GlobalUnlock(h)
    return h


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


def find_window(title, cls=None):
    return user32.FindWindowW(cls, title)


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


def handle_popups(verbose=True):
    """处理所有弹窗，点击确定。返回处理数量。"""
    n = 0
    for dh, dt in list_dialogs():
        for btn in find_child(dh, "Button"):
            lbl = get_text(btn)
            if any(k in lbl for k in ("确定", "OK", "是", "Yes")):
                if verbose:
                    print("    弹窗 %r -> 点击 %r" % (dt, lbl))
                click_real(btn)
                n += 1
                time.sleep(1)
                break
    return n


# ---------------------------------------------------------------------------
# 主流程
# ---------------------------------------------------------------------------
def stage_scripts(script_dir):
    print("[1] 复制脚本到 HkeData")
    for f in ("f.j", "g.j", "m.j"):
        src = os.path.join(script_dir, f)
        if not os.path.isfile(src):
            raise FileNotFoundError("缺少 %s" % src)
        shutil.copy2(src, os.path.join(HKE_DATA, f))
        print("    %s -> %s" % (f, HKE_DATA))


def launch_tool():
    print("[2] 启动 HkeW3mModifier2.0")
    subprocess.Popen([TOOL], cwd=TOOL_DIR)
    for _ in range(20):
        time.sleep(0.5)
        if find_window(MAIN_TITLE):
            break
    main = find_window(MAIN_TITLE)
    if not main:
        raise RuntimeError("工具未启动")
    print("    主窗口: %#x" % main)
    return main


def open_map_via_drop(main, map_path):
    print("[3] 拖放打开地图")
    hdrop = make_dropfiles([map_path])
    user32.PostMessageW.argtypes = [wintypes.HWND, wintypes.UINT, ctypes.c_void_p, ctypes.c_void_p]
    user32.PostMessageW(main, WM_DROPFILES, ctypes.c_void_p(hdrop), None)
    time.sleep(4)
    title = get_text(main)
    print("    标题: %s" % title)
    if os.path.basename(map_path) not in title:
        print("    警告: 地图可能未打开")


def inject(main):
    print("[4] 注入脚本")
    # 点击「注入脚本」打开插件窗口
    b = find_child(main, "TButton", "注入脚本")
    if not b:
        raise RuntimeError("未找到『注入脚本』按钮")
    click_real(b[0])
    time.sleep(2)

    # 插件窗口
    inj = find_window("脚本注入插件", "TInjectForm")
    if not inj:
        raise RuntimeError("未打开脚本注入插件窗口")
    print("    插件窗口: %#x" % inj)

    # 点击「注入到本图」
    b = find_child(inj, "TButton", "注入到本图")
    if not b:
        raise RuntimeError("未找到『注入到本图』按钮")
    click_real(b[0])
    time.sleep(2)

    # 处理「注入成功」弹窗
    ok = False
    for dh, dt in list_dialogs():
        for st in find_child(dh, "Static"):
            if "注入成功" in get_text(st):
                ok = True
        handle_popups()
    if ok:
        print("    ✓ 注入成功")
    else:
        print("    ? 未检测到注入成功提示")
        handle_popups()

    # 关闭插件窗口
    user32.PostMessageW(inj, WM_CLOSE, 0, 0)
    time.sleep(1)
    return ok


def recompress(main):
    print("[5] 重压缩保存")
    b = find_child(main, "TButton", "重压缩")
    if not b:
        raise RuntimeError("未找到『重压缩』按钮")
    click_real(b[0])
    time.sleep(6)
    handle_popups()
    print("    ✓ 已保存")


def main():
    if len(sys.argv) < 2:
        print(__doc__)
        return 1
    map_path = os.path.abspath(sys.argv[1])
    script_dir = os.path.abspath(sys.argv[2]) if len(sys.argv) > 2 else os.path.join(
        os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "..", "scripts", "item-browser"
    )
    script_dir = os.path.normpath(script_dir)

    if not os.path.isfile(map_path):
        print("地图不存在: %s" % map_path)
        return 1
    if not os.path.isfile(TOOL):
        print("工具不存在: %s" % TOOL)
        return 1

    # 备份
    backup = map_path + ".bak"
    if not os.path.exists(backup):
        shutil.copy2(map_path, backup)
        print("已备份: %s" % backup)

    size_before = os.path.getsize(map_path)

    stage_scripts(script_dir)
    main_wnd = launch_tool()
    open_map_via_drop(main_wnd, map_path)
    ok = inject(main_wnd)
    recompress(main_wnd)

    size_after = os.path.getsize(map_path)
    print("")
    print("=== 完成 ===")
    print("地图: %s" % map_path)
    print("大小: %d -> %d (%+d)" % (size_before, size_after, size_after - size_before))
    print("注入: %s" % ("成功" if ok else "请手动确认"))
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
