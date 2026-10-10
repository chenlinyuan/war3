"""Manually inject item-browser script into a map whose war3map.j contains
multiple 'endglobals' substrings (YDWE comment markers), which breaks HKE's
naive 注入脚本 (it inserts f.j once per 'endglobals' occurrence -> 15 copies).

Approach:
  1. Extract the map's war3map.j (via HKE 分析文件 -> 解压文件)
  2. Insert g.j content into the globals block (after the map's constant decls,
     before endglobals)
  3. Insert f.j content right after the REAL 'endglobals' line
  4. Insert 'call IB_Init()' at the start of function main
  5. Replace war3map.j via HKE 添加/替换文件, then recompress

Usage:
    python inject_script_manual.py <map> <script_dir>
"""
import ctypes, os, sys, time, re
from ctypes import wintypes
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import inject_map as im

user32 = ctypes.windll.user32
WM_CLOSE = 0x0010
LB_GETCOUNT = 0x018B
LB_GETTEXT = 0x0189
LB_SETCURSEL = 0x0186

HERE = os.path.dirname(os.path.abspath(__file__))


def get_lb_item(lb, idx):
    buf = ctypes.create_unicode_buffer(512)
    user32.SendMessageW(lb, LB_GETTEXT, idx, buf)
    return buf.value


def find_main():
    return im.find_window(im.MAIN_TITLE)


def extract_script(main, base_dir):
    b = im.find_child(main, "TButton", "分析文件")
    im.click_real(b[0]); time.sleep(10); im.handle_popups()
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
    im.click_real(b[0]); time.sleep(4); im.handle_popups(); time.sleep(2)
    found = None
    for root, dirs, files in os.walk(base_dir):
        for fn in files:
            if fn.lower() == "war3map.j":
                p = os.path.join(root, fn)
                if os.path.getmtime(p) > time.time() - 180:
                    found = p
    return found


def replace_file(main, script_path):
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


def build_script(orig_bytes, gj_bytes, fj_bytes, mj_bytes):
    """Insert g.j/f.j/m.j into orig (bytes) exactly once each. Returns bytes."""
    text = orig_bytes.decode("latin-1")
    lines = text.split("\n")
    # find the real endglobals line (first line that is exactly 'endglobals')
    eg_idx = None
    for i, ln in enumerate(lines):
        if ln.strip() == "endglobals":
            eg_idx = i
            break
    if eg_idx is None:
        raise RuntimeError("找不到 endglobals")

    g_block = gj_bytes.decode("latin-1").rstrip("\n").split("\n")
    f_block = fj_bytes.decode("latin-1").rstrip("\n").split("\n")
    m_block = mj_bytes.decode("latin-1").rstrip("\n").split("\n")

    # insert g.j before endglobals
    new_lines = lines[:eg_idx] + g_block + lines[eg_idx:]
    eg_idx2 = None
    for i, ln in enumerate(new_lines):
        if ln.strip() == "endglobals":
            eg_idx2 = i
            break
    # insert f.j after endglobals
    new_lines = new_lines[:eg_idx2 + 1] + [""] + f_block + new_lines[eg_idx2 + 1:]

    out = "\n".join(new_lines)
    mm = re.search(r"(function main takes nothing returns nothing\r?\n)", out)
    if mm:
        out = out[:mm.end()] + "".join("    " + l.strip() + "\n" for l in m_block if l.strip()) + out[mm.end():]
    else:
        raise RuntimeError("找不到 function main")
    return out.encode("latin-1")


def main():
    map_path = os.path.abspath(sys.argv[1])
    script_dir = os.path.abspath(sys.argv[2]) if len(sys.argv) > 2 else \
        os.path.join(HERE, "..", "..", "scripts", "item-browser")
    gj = open(os.path.join(script_dir, "g.j"), "rb").read()
    fj = open(os.path.join(script_dir, "f.j"), "rb").read()
    mj = open(os.path.join(script_dir, "m.j"), "rb").read()

    # backup
    if not os.path.exists(map_path + ".bak"):
        im.shutil.copy2(map_path, map_path + ".bak")

    im.subprocess.Popen([im.TOOL], cwd=im.TOOL_DIR)
    for _ in range(20):
        time.sleep(0.5)
        if find_main():
            break
    h = find_main()
    im.open_map_via_button(h, map_path)
    print("标题:", im.get_text(h), flush=True)

    base_dir = os.path.dirname(map_path)
    extracted = extract_script(h, base_dir)
    if not extracted:
        print("未找到解压脚本"); return 1
    print("解压:", extracted, os.path.getsize(extracted), flush=True)

    orig = open(extracted, "rb").read()
    new = build_script(orig, gj, fj, mj)
    rep = os.path.join(HERE, "_rep")
    os.makedirs(rep, exist_ok=True)
    rp = os.path.join(rep, "war3map.j")
    open(rp, "wb").write(new)
    print("写出:", rp, len(new), flush=True)

    replace_file(h, rp)
    print("已替换", flush=True)

    b = im.find_child(h, "TButton", "重压缩")
    im.click_real(b[0]); time.sleep(8); im.handle_popups()
    user32.PostMessageW(h, WM_CLOSE, 0, 0); time.sleep(1)
    im.subprocess.run(["taskkill", "/IM", "HkeW3mModifier2.0.exe", "/F"], capture_output=True)
    print("完成", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
