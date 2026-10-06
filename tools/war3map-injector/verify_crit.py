"""验证地图脚本是否包含致命一击系统 + globals 顺序正确。

用法: python verify_crit.py <地图路径> [<地图路径> ...]
"""
import ctypes, os, sys, time
from ctypes import wintypes

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import inject_map as im

user32 = ctypes.windll.user32
LB_GETCOUNT = 0x018B
LB_GETTEXT = 0x0189
LB_SETCURSEL = 0x0186


def extract_j(main, workdir):
    b = im.find_child(main, "TButton", "分析文件")
    im.click_real(b[0])
    time.sleep(10)
    im.handle_popups()
    lb = im.find_child(main, "TListBox")[0]
    cnt = user32.SendMessageW(lb, LB_GETCOUNT, 0, 0)
    idx = -1
    for i in range(cnt):
        buf = ctypes.create_unicode_buffer(512)
        user32.SendMessageW(lb, LB_GETTEXT, i, buf)
        if "war3map.j" in buf.value.lower():
            idx = i
            break
    if idx < 0:
        return None
    user32.SendMessageW(lb, LB_SETCURSEL, idx, 0)
    time.sleep(0.5)
    b = im.find_child(main, "TButton", "解压文件")
    im.click_real(b[0])
    time.sleep(3)
    im.handle_popups()
    time.sleep(2)
    for root, dirs, files in os.walk(workdir):
        for fn in files:
            if fn.lower() == "war3map.j":
                p = os.path.join(root, fn)
                if os.path.getmtime(p) > time.time() - 120:
                    return p
    return None


def main():
    workdir = os.path.abspath(".")
    for map_path in sys.argv[1:]:
        map_path = os.path.abspath(map_path)
        im.subprocess.Popen([im.TOOL], cwd=im.TOOL_DIR)
        for _ in range(20):
            time.sleep(0.5)
            if im.find_window(im.MAIN_TITLE):
                break
        h = im.find_window(im.MAIN_TITLE)
        im.open_map_via_button(h, map_path)
        j = extract_j(h, workdir)
        im.subprocess.run(["taskkill", "/IM", "HkeW3mModifier2.0.exe", "/F"], capture_output=True)
        if not j:
            print("%s: 解压失败" % map_path)
            continue
        d = open(j, "rb").read().decode("latin-1")
        pi = d.find("integer array ib_itemList")
        eg = d.find("endglobals")
        print("=== %s ===" % os.path.basename(map_path))
        print("  IB_CritInit      :", "IB_CritInit" in d)
        print("  IB_CritOnDamage  :", "IB_CritOnDamage" in d)
        print("  IB_CritRoll      :", "IB_CritRoll" in d)
        print("  criton 命令      :", "criton" in d)
        print("  globals 顺序     :", "OK" if 0 < pi < eg else "错误 (pi=%d eg=%d)" % (pi, eg))
        os.remove(j)


if __name__ == "__main__":
    main()
