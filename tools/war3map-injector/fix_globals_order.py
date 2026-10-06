# -*- coding: utf-8 -*-
"""修复 HKE 注入后 globals 块中"我们的非 constant 变量插在图自带 constant 之前"
导致的 JASS 编译失败(表现为脚本不执行、search 无反应)。

原理: HKE 把 g.j 插到 globals 块最前面。若地图 globals 以 constant 声明开头,
我们的非 constant 变量就排在 constant 之前,War3 编译失败。
本工具:提取地图脚本 -> 把我们的变量块移到 endglobals 之前 -> 用「添加/替换文件」写回。

用法:
    python fix_globals_order.py <地图路径>

注意: 需要在已注入(IB_Init 等标记存在)的地图上运行。
"""
import ctypes, os, sys, time, re
from ctypes import wintypes

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import inject_map as im

user32 = ctypes.windll.user32
WM_CLOSE = 0x0010
WM_DROPFILES = im.WM_DROPFILES
LB_GETCOUNT = 0x018B
LB_GETTEXT = 0x0189
LB_SETCURSEL = 0x0186


def find_main():
    return im.find_window(im.MAIN_TITLE)


def get_lb_item(lb, idx):
    buf = ctypes.create_unicode_buffer(512)
    user32.SendMessageW(lb, LB_GETTEXT, idx, buf)
    return buf.value


def extract_script(main, out_path):
    """分析文件 -> 选 war3map.j -> 解压文件,返回解压出的路径。"""
    b = im.find_child(main, "TButton", "分析文件")
    im.click_real(b[0]); time.sleep(8); im.handle_popups()
    lbs = im.find_child(main, "TListBox")
    lb = lbs[0]
    cnt = user32.SendMessageW(lb, LB_GETCOUNT, 0, 0)
    idx = -1
    for i in range(cnt):
        if "war3map.j" in get_lb_item(lb, i).lower():
            idx = i; break
    if idx < 0:
        raise RuntimeError("列表中没有 war3map.j")
    user32.SendMessageW(lb, LB_SETCURSEL, idx, 0); time.sleep(0.5)
    b = im.find_child(main, "TButton", "解压文件")
    im.click_real(b[0]); time.sleep(3); im.handle_popups(); time.sleep(2)
    # 找最近解压出的 war3map.j
    base = os.path.dirname(out_path)
    found = None
    for root, dirs, files in os.walk(base):
        for fn in files:
            if fn.lower() == "war3map.j":
                p = os.path.join(root, fn)
                if os.path.getmtime(p) > time.time() - 120:
                    found = p
    return found


def fix_order(text):
    """把我们的变量块移到 endglobals 之前。返回(新文本, 是否修改)。"""
    anchor = "integer array ib_itemList"
    p = text.find(anchor)
    if p < 0:
        return text, False
    # 若已在 endglobals 之后,无需修复
    eg = text.find("endglobals")
    if p > eg:
        return text, False
    start = text.rfind("\n", 0, p) + 1
    m = re.search(r"\r?\n(constant |hashtable |endglobals)", text[start:])
    if not m:
        return text, False
    end = start + m.start() + 1
    block = text[start:end]
    d2 = text[:start] + text[end:]
    eg2 = d2.find("endglobals")
    d3 = d2[:eg2] + block + "\r\n" + d2[eg2:]
    return d3, True


def replace_file(main, script_path):
    """用「添加/替换文件」把 script_path(须命名为 war3map.j)写回地图。"""
    b = im.find_child(main, "TButton", "添加/替换文件")
    im.click_real(b[0]); time.sleep(2); im.handle_popups()
    dlg = None
    for _ in range(20):
        for dh, dt in im.list_dialogs():
            dlg = dh; break
        if dlg:
            break
        time.sleep(0.5)
    if not dlg:
        raise RuntimeError("未出现文件选择对话框")
    edit = im.find_child(dlg, "Edit")
    user32.SendMessageW(edit[0], 0x000C, 0, ctypes.c_wchar_p(script_path))
    time.sleep(0.5)
    ob = im.find_child(dlg, "Button", "打开(&O)") or im.find_child(dlg, "Button", "打开")
    im.click_real(ob[0]); time.sleep(2); im.handle_popups(); time.sleep(1)


def main():
    map_path = os.path.abspath(sys.argv[1])
    im.subprocess.Popen([im.TOOL], cwd=im.TOOL_DIR)
    for _ in range(20):
        time.sleep(0.5)
        if find_main():
            break
    h = find_main()
    im.open_map_via_button(h, map_path)
    print("标题:", im.get_text(h))

    extracted = extract_script(h, map_path)
    if not extracted:
        print("未找到解压脚本")
        return 1
    print("解压:", extracted, os.path.getsize(extracted))
    text = open(extracted, "rb").read().decode("latin-1")
    new_text, changed = fix_order(text)
    if not changed:
        print("无需修复(变量已在 endglobals 之后,或未找到变量块)")
    else:
        # 写到 _rep/war3map.j
        rep = os.path.join(im.TOOL_DIR, "..", "_rep_tmp")
        rep = os.path.abspath(os.path.join(os.path.dirname(__file__), "_rep"))
        os.makedirs(rep, exist_ok=True)
        rp = os.path.join(rep, "war3map.j")
        open(rp, "wb").write(new_text.encode("latin-1"))
        print("修复版:", rp, len(new_text))
        replace_file(h, rp)
        print("已替换")

    b = im.find_child(h, "TButton", "重压缩")
    im.click_real(b[0]); time.sleep(6); im.handle_popups()
    user32.PostMessageW(h, WM_CLOSE, 0, 0); time.sleep(1)
    im.subprocess.run(["taskkill", "/IM", "HkeW3mModifier2.0.exe", "/F"], capture_output=True)
    print("完成")
    return 0


if __name__ == "__main__":
    sys.exit(main())
