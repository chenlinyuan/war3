# -*- coding: utf-8 -*-
"""列出（并可选恢复）回收站里的文件 —— 直接解析 $I 元数据，拿到原始路径与删除时间。

用法:
    python scan_recycle_bin.py                      # 列出所有盘（按删除时间倒序）
    python scan_recycle_bin.py --grep 分辨率         # 只看文件名/路径里含关键词的
    python scan_recycle_bin.py --limit 200
    python scan_recycle_bin.py --recover 12 --to "C:\\Users\\Administrator\\Desktop"

回收站结构：每个盘 `<盘>:\$Recycle.Bin\<用户SID>\` 下成对出现
    $R<id><后缀>  = 文件内容（目录型删除时是目录）
    $I<id><后缀>  = 元数据：版本(8) 大小(8) 删除时间FILETIME(8) 之后是原始路径
"""
import argparse
import datetime
import os
import shutil
import struct
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")


def drives():
    out = []
    for letter in "CDEFGHIJKLMNOPQRSTUVWXYZ":
        root = "%s:\\" % letter
        if os.path.exists(root):
            out.append(root)
    return out


def filetime_to_dt(ft):
    if not ft:
        return None
    try:
        return datetime.datetime(1601, 1, 1) + datetime.timedelta(microseconds=ft // 10)
    except Exception:  # noqa: BLE001
        return None


def parse_i(path):
    try:
        with open(path, "rb") as f:
            data = f.read()
    except OSError:
        return None
    if len(data) < 24:
        return None
    ver, size, ft = struct.unpack_from("<QQQ", data, 0)
    if ver == 2 and len(data) >= 28:
        (plen,) = struct.unpack_from("<I", data, 24)
        raw = data[28:28 + plen * 2]
    else:
        raw = data[24:24 + 520]
    orig = raw.decode("utf-16-le", "replace").split("\x00")[0]
    return size, ft, orig, ver


def scan(verbose=False):
    items = []
    for root in drives():
        bin_root = os.path.join(root, "$Recycle.Bin")
        if not os.path.isdir(bin_root):
            continue
        for sid in os.listdir(bin_root):
            sid_dir = os.path.join(bin_root, sid)
            if not os.path.isdir(sid_dir):
                continue
            try:
                names = os.listdir(sid_dir)
            except OSError:
                continue
            for name in names:
                if not name.startswith("$I"):
                    continue
                i_path = os.path.join(sid_dir, name)
                info = parse_i(i_path)
                if not info:
                    continue
                size, ft, orig, ver = info
                r_path = os.path.join(sid_dir, "$R" + name[2:])
                items.append({
                    "drive": root,
                    "i": i_path,
                    "r": r_path,
                    "exists": os.path.exists(r_path),
                    "is_dir": os.path.isdir(r_path),
                    "size": size,
                    "deleted": filetime_to_dt(ft),
                    "orig": orig,
                })
    items.sort(key=lambda x: (x["deleted"] or datetime.datetime.min), reverse=True)
    return items


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--grep", default="", help="按原始文件名过滤（不区分大小写，逗号分隔多个）")
    ap.add_argument("--in-path", action="store_true", help="改按完整原始路径过滤")
    ap.add_argument("--limit", type=int, default=400)
    ap.add_argument("--recover", type=int, default=0, help="恢复第 N 号条目（见列表序号）")
    ap.add_argument("--to", default="", help="恢复到哪个目录（默认回到原始位置）")
    ap.add_argument("--all-dirs", action="store_true", help="连目录型删除也列出来")
    a = ap.parse_args()

    items = scan()
    keys = [k.strip().lower() for k in a.grep.split(",") if k.strip()]
    shown = []
    for it in items:
        hay = it["orig"].lower() if a.in_path else os.path.basename(it["orig"]).lower()
        if keys and not any(k in hay for k in keys):
            continue
        if it["is_dir"] and not a.all_dirs and not keys:
            continue
        shown.append(it)

    print("回收站条目共 %d，符合条件 %d（按删除时间倒序）\n" % (len(items), len(shown)))
    for n, it in enumerate(shown[:a.limit], 1):
        mark = "目录" if it["is_dir"] else "文件"
        dt = it["deleted"].strftime("%Y-%m-%d %H:%M") if it["deleted"] else "?"
        print("[%3d] %s  %-8s %10s  %s" % (
            n, dt, mark,
            ("%d MB" % (it["size"] // 1048576)) if it["size"] > 1048576 else ("%d KB" % (it["size"] // 1024)),
            it["orig"]))
        print("      内容: %s %s" % (it["r"], "" if it["exists"] else "（内容已不在！）"))

    if a.recover:
        if a.recover < 1 or a.recover > len(shown):
            raise SystemExit("序号超出范围")
        it = shown[a.recover - 1]
        if not it["exists"]:
            raise SystemExit("该条目的 $R 内容文件不在，无法恢复")
        src = it["r"]
        if a.to:
            dst = os.path.join(a.to, os.path.basename(it["orig"]) or os.path.basename(src))
        else:
            dst = it["orig"]
        if os.path.exists(dst):
            raise SystemExit("目标已存在，先手动处理: %s" % dst)
        os.makedirs(os.path.dirname(dst), exist_ok=True)
        if it["is_dir"]:
            shutil.copytree(src, dst)
        else:
            shutil.copy2(src, dst)
        print("\n已恢复 -> %s （%d 字节%s）" % (
            dst, it["size"], "，目录" if it["is_dir"] else ""))
    return 0


if __name__ == "__main__":
    sys.exit(main())
