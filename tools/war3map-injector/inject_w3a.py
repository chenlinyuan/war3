"""把 war3map.w3a 注入到地图（用 HKE「添加/替换文件」）。

用法:
    python inject_w3a.py <地图路径> <w3a文件>

注意: 文件选择对话框要求文件名匹配地图内路径，故先复制为名为 war3map.w3a 的临时文件。
"""
import ctypes, os, shutil, sys, time
from ctypes import wintypes

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import inject_map as im

user32 = ctypes.windll.user32
WM_CLOSE = 0x0010


def find_main():
    return im.find_window(im.MAIN_TITLE)


def replace_file(main, file_path, target_name):
    """用「添加/替换文件」把 file_path 以 target_name 写回地图。

    HKE 主窗口有两个区域:
      - 『文件选择』组: 『自定义文件』/『Jass脚本』单选 + 一个 Edit(填内部名)
      - 『文件添加选项』组: 『采用自定义路径+文件名』/『采用上方文件选择中的完整文件名』
    正确做法: 选『自定义文件』, 在『文件选择』的 Edit 里填内部名(war3map.w3a)。
    """
    # 1) 选『自定义文件』单选
    rb = im.find_child(main, "TRadioButton", "自定义文件")
    if rb:
        im.click_real(rb[0])
        time.sleep(0.5)

    # 2) 找『文件选择』组里的 Edit（用 Y 坐标区分: 文件选择组在文件添加选项组上方）
    edits = im.find_child(main, "TEdit")
    target_edit = None
    for e in edits:
        r = wintypes.RECT()
        user32.GetWindowRect(e, ctypes.byref(r))
        # 『文件选择』的 Edit 在 y≈567, 『文件添加选项』的 Edit 在 y≈663
        if 500 < r.top < 620:
            target_edit = e
            break
    if target_edit is None and edits:
        target_edit = edits[0]
    if target_edit:
        user32.SendMessageW(target_edit, 0x000C, 0, ctypes.c_wchar_p(target_name))
        time.sleep(0.5)

    # 3) 点击「添加/替换文件」
    b = im.find_child(main, "TButton", "添加/替换文件")
    if not b:
        raise RuntimeError("未找到『添加/替换文件』按钮")
    im.click_real(b[0])
    time.sleep(2)
    im.handle_popups()
    dlg = None
    for _ in range(20):
        for dh, dt in im.list_dialogs():
            dlg = dh
            break
        if dlg:
            break
        time.sleep(0.5)
    if not dlg:
        raise RuntimeError("未出现文件选择对话框")
    edit = im.find_child(dlg, "Edit")
    user32.SendMessageW(edit[0], 0x000C, 0, ctypes.c_wchar_p(file_path))
    time.sleep(0.5)
    ob = im.find_child(dlg, "Button", "打开(&O)") or im.find_child(dlg, "Button", "打开")
    im.click_real(ob[0])
    time.sleep(2)
    im.handle_popups()
    time.sleep(1)


def main():
    if len(sys.argv) < 3:
        print(__doc__)
        return 1
    map_path = os.path.abspath(sys.argv[1])
    w3a_src = os.path.abspath(sys.argv[2])

    # 复制为名为 war3map.w3a 的临时文件（对话框按文件名匹配地图内路径）
    tmpdir = os.path.join(os.path.dirname(os.path.abspath(__file__)), "_rep")
    os.makedirs(tmpdir, exist_ok=True)
    tmp = os.path.join(tmpdir, "war3map.w3a")
    shutil.copy2(w3a_src, tmp)
    print("临时文件: %s (%d bytes)" % (tmp, os.path.getsize(tmp)))

    im.subprocess.Popen([im.TOOL], cwd=im.TOOL_DIR)
    for _ in range(20):
        time.sleep(0.5)
        if find_main():
            break
    h = find_main()
    im.open_map_via_button(h, map_path)
    print("标题:", im.get_text(h))

    replace_file(h, tmp, "war3map.w3a")
    print("已替换 war3map.w3a")

    b = im.find_child(h, "TButton", "重压缩")
    if b:
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
