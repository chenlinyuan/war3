# -*- coding: utf-8 -*-
"""用 HKE 的『添加/替换文件』直接替换地图内的 war3map.j。
用于把 IB_Init() 调用移到 main 开头,或注入诊断代码。
"""
import ctypes, os, sys, time
from ctypes import wintypes

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import inject_map as im

user32 = ctypes.windll.user32
WM_CLOSE = 0x0010
WM_DROPFILES = im.WM_DROPFILES


def find_main():
    return im.find_window(im.MAIN_TITLE)


def main():
    map_path = os.path.abspath(sys.argv[1])
    script_path = os.path.abspath(sys.argv[2])
    im.subprocess.Popen([im.TOOL], cwd=im.TOOL_DIR)
    for _ in range(20):
        time.sleep(0.5)
        if find_main():
            break
    h = find_main()
    print("main:", hex(h) if h else None)
    # 打开地图
    hdrop = im.make_dropfiles([map_path])
    user32.PostMessageW.argtypes = [wintypes.HWND, wintypes.UINT, ctypes.c_void_p, ctypes.c_void_p]
    user32.PostMessageW(h, WM_DROPFILES, ctypes.c_void_p(hdrop), None)
    time.sleep(4)
    print("标题:", im.get_text(h))

    # 点击『添加/替换文件』
    b = im.find_child(h, "TButton", "添加/替换文件")
    if not b:
        print("未找到『添加/替换文件』按钮")
        return 1
    print("点击 添加/替换文件")
    im.click_real(b[0])
    time.sleep(2)
    im.handle_popups()
    # 列出当前所有可见窗口,帮助诊断
    def enum_vis():
        out = []
        def cb(hh, l):
            c = ctypes.create_unicode_buffer(256)
            user32.GetClassNameW(hh, c, 256)
            t = ctypes.create_unicode_buffer(256)
            user32.GetWindowTextW(hh, t, 256)
            if user32.IsWindowVisible(hh):
                out.append((hh, c.value, t.value))
            return True
        cbk = ctypes.WINFUNCTYPE(ctypes.c_bool, wintypes.HWND, wintypes.LPARAM)
        user32.EnumWindows(cbk(cb), 0)
        return out
    for hh, c, t in enum_vis():
        print("  窗口: %#x cls=%s title=%r" % (hh, c, t))


    # 会弹出文件选择框,需要输入脚本路径
    # 找打开对话框
    print("等待文件对话框...")
    time.sleep(2)
    # 找 #32770 对话框
    dlg = None
    for _ in range(20):
        def cb(hh, l):
            nonlocal dlg
            c = ctypes.create_unicode_buffer(256)
            user32.GetClassNameW(hh, c, 256)
            if c.value == "#32770" and user32.IsWindowVisible(hh):
                dlg = hh
            return True
        cbk = ctypes.WINFUNCTYPE(ctypes.c_bool, wintypes.HWND, wintypes.LPARAM)
        user32.EnumWindows(cbk(cb), 0)
        if dlg:
            break
        time.sleep(0.5)
    print("对话框:", hex(dlg) if dlg else None)
    if dlg:
        # 找文件名编辑框 (ComboBoxEx32 -> ComboBox -> Edit)
        edit = im.find_child(dlg, "Edit")
        print("edit:", edit)
        if edit:
            user32.SendMessageW(edit[0], 0x000C, 0, ctypes.c_wchar_p(script_path))  # WM_SETTEXT
            time.sleep(0.5)
            # 点打开
            ob = im.find_child(dlg, "Button", "打开")
            if not ob:
                ob = im.find_child(dlg, "Button", "Open")
            if ob:
                im.click_real(ob[0])
                time.sleep(2)
    im.handle_popups()
    time.sleep(2)
    print("替换后标题:", im.get_text(h))

    # 检查是否弹出"是否替换"确认框
    im.handle_popups()
    time.sleep(1)

    # 重压缩保存
    b = im.find_child(h, "TButton", "重压缩")
    if b:
        print("点击 重压缩")
        im.click_real(b[0])
        time.sleep(6)
        im.handle_popups()
    user32.PostMessageW(h, WM_CLOSE, 0, 0)
    time.sleep(1)
    im.subprocess.run(["taskkill", "/IM", "HkeW3mModifier2.0.exe", "/F"], capture_output=True)
    print("完成")
    return 0


if __name__ == "__main__":
    sys.exit(main())
