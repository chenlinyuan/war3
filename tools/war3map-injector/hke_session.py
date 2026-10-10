# -*- coding: utf-8 -*-
"""HKE 会话层：一次启动、一次打开地图、批量注入、干净关闭。

为什么需要它
------------
旧脚本 inject_map.py / inject_file.py 每次调用都是“开工具 -> 开地图 -> 干活 ->
关工具”的完整循环，且收尾用固定 sleep + taskkill。结果是：

  * 一次部署（脚本 + w3a + w3t + w3h）要开关 4 次 HKE；
  * 大图重压缩没做完就被强杀，容易写坏地图；
  * taskkill /IM 会顺手杀掉用户自己开着的 HKE。

本模块把上述过程收进一个会话对象：启动一次、打开一次，之后可以连续
解压/替换任意多个内部文件，最后正常关闭（只结束自己启动的进程）。

实测要点（见 tools/war3map-injector/_probe3_report.txt）
------------------------------------------------------
  * 拖放打开地图即可，约 0.5s，标题会变成 “... 当前文件:xxx.w3x”；
  * 「分析文件(&F)」约 1s；
  * 「解压文件(&U)」把文件写到**地图所在目录**，文件名取内部名的最后一段；
  * 「添加/替换文件(&A)」**当场写入地图文件**，无需再点「重压缩」；
  * 「重压缩(&C)」在该工具上实测没有任何可见效果（30s 内文件不变），
    且工具自带提示「重压缩卡死可试试」——默认不调用它。
"""

import ctypes
import os
import shutil
import time
from ctypes import wintypes

import inject_map as im

user32 = ctypes.windll.user32
WM_DROPFILES = im.WM_DROPFILES
WM_CLOSE = 0x0010
LB_GETCOUNT = 0x018B
LB_GETTEXT = 0x0189
LB_SETCURSEL = 0x0186

MAIN_CLASS = "THkeForm"
INJECT_FORM_CLASS = "TInjectForm"

OK_TEXTS = ("确定", "OK", "是", "Yes")


class HkeError(RuntimeError):
    """HKE 会话出错。"""


def _enum_top():
    out = []
    cb = ctypes.WINFUNCTYPE(ctypes.c_bool, wintypes.HWND, wintypes.LPARAM)

    def f(h, l):
        out.append(h)
        return True

    user32.EnumWindows(cb(f), 0)
    return out


def enum_children(parent):
    result = []
    cb = ctypes.WINFUNCTYPE(ctypes.c_bool, wintypes.HWND, wintypes.LPARAM)

    def cb_fn(h, l):
        c = ctypes.create_unicode_buffer(256)
        user32.GetClassNameW(h, c, 256)
        t = ctypes.create_unicode_buffer(256)
        user32.GetWindowTextW(h, t, 256)
        result.append((h, c.value, t.value))
        return True

    user32.EnumChildWindows(parent, cb(cb_fn), 0)
    return result


def find_child(parent, cls=None, text=None):
    return [h for h, c, t in enum_children(parent)
            if (cls is None or c == cls) and (text is None or text in t)]


def get_text(hwnd):
    buf = ctypes.create_unicode_buffer(512)
    user32.GetWindowTextW(hwnd, buf, 512)
    return buf.value


def find_main_windows():
    """所有可见的 HKE 主窗口。"""
    out = []
    for h in _enum_top():
        if not user32.IsWindowVisible(h):
            continue
        c = ctypes.create_unicode_buffer(64)
        user32.GetClassNameW(h, c, 64)
        if c.value == MAIN_CLASS:
            out.append(h)
    return out


def pid_of(hwnd):
    pid = wintypes.DWORD(0)
    user32.GetWindowThreadProcessId(hwnd, ctypes.byref(pid))
    return pid.value


def is_responsive(hwnd, timeout_ms=400):
    res = ctypes.c_ulonglong(0)
    return bool(user32.SendMessageTimeoutW(hwnd, 0, 0, 0, 0x0002,
                                           timeout_ms, ctypes.byref(res)))


def wait_until(pred, timeout, interval=0.2, desc=""):
    t0 = time.time()
    while time.time() - t0 < timeout:
        val = pred()
        if val:
            return val
        time.sleep(interval)
    raise HkeError("等待超时: %s (%.0fs)" % (desc or "条件", timeout))


class HkeSession:
    """一次 HKE 会话：启动 -> 打开地图 -> 若干操作 -> 关闭。"""

    def __init__(self, tool=None, tool_dir=None, verbose=True):
        self.tool = tool or im.TOOL
        self.tool_dir = tool_dir or im.TOOL_DIR
        self.hke_data = os.path.join(self.tool_dir, "HkeData")
        self.verbose = verbose
        self.proc = None
        self.main = None
        self.map_path = None
        self._last_files = []

    # ------------------------------------------------------------------
    # 日志
    # ------------------------------------------------------------------
    def log(self, *a):
        if self.verbose:
            print("   ", *a, flush=True)

    # ------------------------------------------------------------------
    # 会话
    # ------------------------------------------------------------------
    def start(self, timeout=60):
        if self.proc is not None:
            return self.main
        existing = find_main_windows()
        if existing:
            raise HkeError(
                "检测到已有 HKE 在运行（窗口 %s）。请先关闭它，"
                "否则本工具无法确保操作的是自己启动的实例。" % existing)
        if not os.path.isfile(self.tool):
            raise HkeError("找不到 HKE 工具: %s" % self.tool)
        self.proc = im.subprocess.Popen([self.tool], cwd=self.tool_dir)
        self.main = wait_until(
            lambda: (find_main_windows() or [None])[0],
            timeout, 0.3, "HKE 主窗口出现")
        self.log("已启动 HKE, pid=%d, 窗口=%#x" % (self.proc.pid, self.main))
        return self.main

    def close(self):
        """先礼后兵：WM_CLOSE，再只杀自己启动的进程。"""
        if self.main:
            try:
                user32.PostMessageW(self.main, WM_CLOSE, 0, 0)
            except Exception:
                pass
        if self.proc:
            for _ in range(20):
                if self.proc.poll() is not None:
                    break
                time.sleep(0.2)
            if self.proc.poll() is None:
                im.subprocess.run(["taskkill", "/PID", str(self.proc.pid), "/F"],
                                  capture_output=True)
        self.proc = None
        self.main = None

    def __enter__(self):
        self.start()
        return self

    def __exit__(self, *exc):
        self.close()

    # ------------------------------------------------------------------
    # 窗口操作
    # ------------------------------------------------------------------
    def click(self, hwnd):
        """Delphi 控件不响应 BM_CLICK，必须用真实鼠标。"""
        rect = wintypes.RECT()
        user32.GetWindowRect(hwnd, ctypes.byref(rect))
        x = (rect.left + rect.right) // 2
        y = (rect.top + rect.bottom) // 2
        old = wintypes.POINT()
        user32.GetCursorPos(ctypes.byref(old))
        # 必须把控件所属的窗口（可能是模态文件对话框）置前，
        # 否则主窗口会盖住对话框，点击落到错误的地方。
        user32.SetForegroundWindow(hwnd)
        time.sleep(0.2)
        user32.SetCursorPos(x, y)
        time.sleep(0.15)
        user32.mouse_event(0x0002, 0, 0, 0, 0)
        time.sleep(0.05)
        user32.mouse_event(0x0004, 0, 0, 0, 0)
        time.sleep(0.3)
        user32.SetCursorPos(old.x, old.y)
        time.sleep(0.1)

    def button(self, text):
        b = find_child(self.main, "TButton", text)
        if not b:
            raise HkeError("主窗口找不到按钮 %r" % text)
        return b[0]

    def click_button(self, text):
        self.click(self.button(text))

    def dialogs(self):
        """只属于本会话进程的可见对话框（不碰用户其它窗口）。"""
        out = []
        for h in _enum_top():
            if not user32.IsWindowVisible(h):
                continue
            c = ctypes.create_unicode_buffer(64)
            user32.GetClassNameW(h, c, 64)
            if c.value != "#32770":
                continue
            if self.proc and pid_of(h) != self.proc.pid:
                continue
            out.append(h)
        return out

    def dismiss_popups(self, collect=None):
        """点掉本进程的确认弹窗，返回被点掉的按钮文字列表。"""
        clicked = []
        for dlg in self.dialogs():
            title = get_text(dlg)
            body = " / ".join(t for t in
                              (get_text(s) for s in find_child(dlg, "Static")) if t)
            for btn in find_child(dlg, "Button"):
                lbl = get_text(btn)
                if lbl and any(k in lbl for k in OK_TEXTS):
                    self.click(btn)
                    msg = "%s | %s -> %s" % (title or "(无标题)", body, lbl)
                    clicked.append(msg)
                    time.sleep(0.4)
                    break
        if collect is not None:
            collect.extend(clicked)
        return clicked

    def wait_idle(self, timeout=60, settle=0.6):
        """等待：没有本进程弹窗 + 主窗口可响应。"""
        t0 = time.time()
        stable_since = None
        while time.time() - t0 < timeout:
            self.dismiss_popups()
            if not self.dialogs() and is_responsive(self.main):
                if stable_since is None:
                    stable_since = time.time()
                elif time.time() - stable_since >= settle:
                    return True
            else:
                stable_since = None
            time.sleep(0.15)
        raise HkeError("等待工具空闲超时（%.0fs）" % timeout)

    # ------------------------------------------------------------------
    # 打开地图
    # ------------------------------------------------------------------
    def open(self, map_path, timeout=30):
        map_path = os.path.abspath(map_path)
        if not os.path.isfile(map_path):
            raise HkeError("地图不存在: %s" % map_path)
        self.start()
        if self.map_path and os.path.normcase(self.map_path) == os.path.normcase(map_path):
            self.log("地图已打开，复用会话:", os.path.basename(map_path))
            return

        base = os.path.basename(map_path)
        hdrop = im.make_dropfiles([map_path])
        user32.PostMessageW.argtypes = [
            wintypes.HWND, wintypes.UINT, ctypes.c_void_p, ctypes.c_void_p]
        user32.PostMessageW(self.main, WM_DROPFILES, ctypes.c_void_p(hdrop), None)
        t0 = time.time()
        while time.time() - t0 < timeout:
            time.sleep(0.3)
            if base in get_text(self.main):
                self.map_path = map_path
                self.log("已打开 %s (%.1fs)" % (base, time.time() - t0))
                self.wait_idle()
                return
        raise HkeError("拖放打开地图失败（标题未出现 %s）: %r" % (base, get_text(self.main)))

    # ------------------------------------------------------------------
    # 分析 / 列表
    # ------------------------------------------------------------------
    def listbox(self):
        boxes = find_child(self.main, "TListBox")
        if not boxes:
            return None
        if len(boxes) == 1:
            return boxes[0]
        # 多个时取面积最大的那个
        best, best_area = None, -1
        for h in boxes:
            r = wintypes.RECT()
            user32.GetWindowRect(h, ctypes.byref(r))
            area = (r.right - r.left) * (r.bottom - r.top)
            if area > best_area:
                best, best_area = h, area
        return best

    def list_files(self):
        lb = self.listbox()
        if not lb:
            return []
        n = user32.SendMessageW(lb, LB_GETCOUNT, 0, 0)
        out = []
        for i in range(n):
            buf = ctypes.create_unicode_buffer(512)
            user32.SendMessageW(lb, LB_GETTEXT, i, buf)
            out.append(buf.value)
        return out

    def analyze(self, timeout=240, settle=0.8):
        """点「分析文件」，等列表出现并稳定。大图会慢，这里按条件等而不是死等。"""
        self.click_button("分析文件")
        last_count, last_change = -1, time.time()
        t0 = time.time()
        while time.time() - t0 < timeout:
            time.sleep(0.25)
            self.dismiss_popups()
            lb = self.listbox()
            n = user32.SendMessageW(lb, LB_GETCOUNT, 0, 0) if lb else 0
            if n != last_count:
                last_count, last_change = n, time.time()
            if n > 0 and time.time() - last_change >= settle:
                self._last_files = self.list_files()
                self.log("分析完成: %d 个内部文件 (%.1fs)" % (n, time.time() - t0))
                return self._last_files
        raise HkeError("分析文件超时（%ds，列表项 %d）" % (timeout, last_count))

    def ensure_analyzed(self):
        if not self._last_files:
            self.analyze()
        return self._last_files

    def _goto(self, internal):
        lb = self.listbox()
        for i, name in enumerate(self.list_files()):
            if name.lower() == internal.lower():
                user32.SendMessageW(lb, LB_SETCURSEL, i, 0)
                # 关键：LB_SETCURSEL 不产生 LBN_SELCHANGE 通知，Delphi 端的
                # “当前文件”变量不会更新，于是「解压文件」会解出上一次的文件。
                # 这里手动补一条 WM_COMMAND/LBN_SELCHANGE 通知。
                cid = user32.GetDlgCtrlID(lb)
                user32.SendMessageW(self.main, 0x0111,
                                    (1 << 16) | (cid & 0xFFFF), lb)
                time.sleep(0.2)
                return name
        return None

    # ------------------------------------------------------------------
    # 解压 / 替换
    # ------------------------------------------------------------------
    def _dir_snapshot(self):
        d = os.path.dirname(self.map_path)
        out = {}
        try:
            for fn in os.listdir(d):
                p = os.path.join(d, fn)
                if os.path.isfile(p):
                    out[p] = os.path.getmtime(p)
        except OSError:
            pass
        return out

    def extract(self, internal, timeout=25, attempts=3):
        """解压指定内部文件到地图目录，返回其字节。

        HKE 连续操作几次后会“解压文件”失灵（它自己文档也说“不稳定就重启”），
        所以这里重新分析列表并重试几次。
        """
        last = None
        for i in range(attempts):
            try:
                return self._extract_once(internal, timeout)
            except HkeError as e:
                last = e
                self.log("解压尝试 %d/%d 失败: %s" % (i + 1, attempts, e))
                time.sleep(0.4)
        raise last

    def _extract_once(self, internal, timeout):
        self.analyze()
        name = self._goto(internal)
        if name is None:
            raise HkeError("地图内没有 %r" % internal)
        target = os.path.join(os.path.dirname(self.map_path),
                              os.path.basename(name.replace("\\", "/")))
        try:
            os.remove(target)
        except OSError:
            pass
        before = self._dir_snapshot()
        self.click_button("解压文件")
        t0 = time.time()
        while time.time() - t0 < timeout:
            time.sleep(0.25)
            self.dismiss_popups()
            if os.path.isfile(target):
                self.wait_idle()
                with open(target, "rb") as fh:
                    data = fh.read()
                self.log("解压 %s -> %s (%d 字节)"
                         % (name, os.path.basename(target), len(data)))
                return data
            after = self._dir_snapshot()
            new = [os.path.basename(p) for p in after
                   if p not in before or after[p] != before.get(p)]
            if new and os.path.basename(target) not in new:
                raise HkeError("解压出来的是 %s，不是 %s" % (new, internal))
        raise HkeError("解压 %s 超时（%ds）" % (internal, timeout))

    def _set_text(self, hwnd, text):
        user32.SendMessageW(hwnd, 0x000C, 0, ctypes.c_wchar_p(text))
        time.sleep(0.15)

    def _edit_at(self, min_top, max_top=None):
        """按屏幕位置找 TEdit（HKE 的控件没有稳定 id）。"""
        for e in find_child(self.main, "TEdit"):
            r = wintypes.RECT()
            user32.GetWindowRect(e, ctypes.byref(r))
            if r.top >= min_top and (max_top is None or r.top <= max_top):
                return e
        return None

    def replace(self, src_path, internal=None, timeout=120):
        """用 src_path 的内容替换地图内的 internal 文件。

        实测：这一步当场就把地图文件写好了，不需要再点「重压缩」。

        ⚠ 关键一步：必须先点「文件选择」里的「自定义文件」。
        默认选中的是「Jass脚本」，那会把目标名强行设成 war3map.j ——
        实测未切换时连续替换 w3a/w3t/w3h 会把三个文件全部覆盖进 war3map.j，
        并弹出「发现文件名不一致,您确定要把 X 添加到 war3map.j 么？」。
        切到「自定义文件」后，目标名取所选文件名，且连续替换互不干扰。
        """
        internal = internal or os.path.basename(src_path)
        staging = os.path.join(self.tool_dir, "_rep")
        os.makedirs(staging, exist_ok=True)
        # 文件名必须恰好等于内部名，HKE 默认用文件名当内部名
        tmp = os.path.join(staging, os.path.basename(internal.replace("\\", "/")))
        if os.path.abspath(src_path) != os.path.abspath(tmp):
            shutil.copy2(src_path, tmp)

        rb = find_child(self.main, "TRadioButton", "自定义文件")
        if not rb:
            raise HkeError("主窗口找不到「自定义文件」单选钮")
        self.click(rb[0])
        time.sleep(0.2)
        # 把源文件路径写进「文件选择」框，并把「文件添加选项」切成
        # 自定义路径+文件名（名字框留空 -> 用源文件的文件名当内部名）
        src_edit = self._edit_at(550, 600)
        if src_edit:
            self._set_text(src_edit, tmp)
        name_rb = find_child(self.main, "TRadioButton", "采用自定义路径+文件名")
        if name_rb:
            self.click(name_rb[0])
            time.sleep(0.2)
        name_edit = self._edit_at(640, 700)
        if name_edit:
            self._set_text(name_edit, "")

        self.click_button("添加/替换文件")
        dlg = wait_until(lambda: (self.dialogs() or [None])[0],
                         timeout, 0.2, "文件选择对话框")
        edit = find_child(dlg, "Edit")
        if not edit:
            raise HkeError("文件对话框里没有输入框")
        self._set_text(edit[0], tmp)
        # 现代文件对话框的文件名是 ComboBoxEx32>ComboBox>Edit，两边都写更保险
        for c in find_child(dlg, "ComboBox"):
            if find_child(c, "Edit"):
                self._set_text(c, tmp)
        ob = (find_child(dlg, "Button", "打开(&O)") or
              find_child(dlg, "Button", "打开"))
        if not ob:
            raise HkeError("文件对话框里没有「打开」按钮")
        self.click(ob[0])
        # 文件名与既有条目不一致时会弹「…您确定要把 X 添加到 Y 么？」-> 点是
        notes = []
        t0 = time.time()
        while time.time() - t0 < timeout:
            time.sleep(0.2)
            self.dismiss_popups(collect=notes)
            if not self.dialogs():
                break
        else:
            raise HkeError("替换对话框未关闭（%ds）" % timeout)
        self.wait_idle()
        self._last_files = self.list_files()
        self.log("已替换 %s (%d 字节)" % (internal, os.path.getsize(tmp)))
        if notes:
            self.log("  确认弹窗: %s" % notes)
        if not any(f.lower() == internal.lower() for f in self._last_files):
            raise HkeError("替换后列表里没有 %r。当前列表: %s"
                           % (internal, self._last_files))
        return tmp

    # ------------------------------------------------------------------
    # 脚本注入（HKE 原生方式，仅用于对照）
    # ------------------------------------------------------------------
    def stage_scripts(self, script_dir):
        for f in ("f.j", "g.j", "m.j"):
            src = os.path.join(script_dir, f)
            if not os.path.isfile(src):
                raise HkeError("缺少脚本 %s" % src)
            shutil.copy2(src, os.path.join(self.hke_data, f))
        self.log("已把 f.j/g.j/m.j 复制到 HkeData")

    def inject_script_native(self, script_dir, timeout=120):
        """用 HKE 自带「注入脚本」按钮（注意：多 endglobals 的 YDWE 图会插错）。"""
        self.stage_scripts(script_dir)
        self.click_button("注入脚本")
        inj = wait_until(self._inject_form, timeout, 0.3, "脚本注入插件窗口")
        self.log("插件窗口 %#x" % inj)
        btn = find_child(inj, "TButton", "注入到本图")
        if not btn:
            raise HkeError("插件窗口找不到「注入到本图」")
        self.click(btn[0])
        notes = []
        for _ in range(40):
            time.sleep(0.4)
            self.dismiss_popups(collect=notes)
            if not self.dialogs():
                break
        user32.PostMessageW(inj, WM_CLOSE, 0, 0)
        time.sleep(0.5)
        self.wait_idle()
        self.log("脚本注入完成，弹窗: %s" % (notes or "无"))
        return notes

    @staticmethod
    def _class_of(hwnd):
        c = ctypes.create_unicode_buffer(64)
        user32.GetClassNameW(hwnd, c, 64)
        return c.value

    def _inject_form(self):
        for h in _enum_top():
            if user32.IsWindowVisible(h) and self._class_of(h) == INJECT_FORM_CLASS:
                return h
        return None

    # ------------------------------------------------------------------
    # 重压缩（默认不用，见模块说明）
    # ------------------------------------------------------------------
    def recompress(self, timeout=600, settle=3.0):
        """点「重压缩」。实测该工具此功能常无效果，甚至卡死；默认不调用。"""
        if not self.map_path:
            raise HkeError("还没打开地图")
        before = (os.path.getsize(self.map_path), os.path.getmtime(self.map_path))
        self.click_button("重压缩")
        last = before
        last_change = time.time()
        t0 = time.time()
        skipped = False
        while time.time() - t0 < timeout:
            time.sleep(0.25)
            self.dismiss_popups()
            try:
                cur = (os.path.getsize(self.map_path), os.path.getmtime(self.map_path))
            except OSError:
                cur = last
            if cur != last:
                last = cur
                last_change = time.time()
            idle = not self.dialogs() and is_responsive(self.main)
            if idle and time.time() - last_change >= settle:
                if last == before and not skipped:
                    skipped = True
                    self.log("重压缩未产生任何文件变化（该工具的常见表现）")
                break
        return before, last
