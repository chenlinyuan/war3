# -*- coding: utf-8 -*-
"""Clean up regenerable build artifacts (only inside the given working dirs).

Usage:
    python tools/cleanup_build_artifacts.py            # 只列出，不删
    python tools/cleanup_build_artifacts.py --delete

    # 整个 scratch 目录一起删（decompile/repack 的零碎文件也清掉）
    python tools/cleanup_build_artifacts.py --rmtree --dirs "_dbg,_doctor_test,_doctor_test2" --delete
    # 按通配符删（相对 --root，仍然逐个打印再删）
    python tools/cleanup_build_artifacts.py --root "H:\\Games\\War3" --glob "_备份_*.w3n.bak" --delete
    # 清空一个目录的内容（保留目录本身，典型是 %TEMP%）
    python tools/cleanup_build_artifacts.py --root "$env:TEMP" --empty "." --delete

Rules (defaults):
  * dirs: _doctor_test, _doctor_test2   (decompile / repack scratch)
  * extensions: .w3n .w3x .w3m .origbak
  * size > 20MB

Those files are whole-campaign repacks produced by _camp_build.py / inject_native.py;
they can be rebuilt at any time from the platform originals in
H:\\Games\\War3\\Campaigns\\dz plus the scripts here.  The deployed single-player
campaigns live in H:\\Games\\War3\\Campaigns and are not touched.

Every target must resolve inside the working directory (prefix check), otherwise the
whole operation aborts.  Deletion only happens with --delete.
"""
import argparse
import glob
import os
import shutil
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
DEFAULT_DIRS = "_doctor_test,_doctor_test2"
DEFAULT_EXTS = ".origbak,.w3m,.w3n,.w3x"


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--root", default=ROOT)
    ap.add_argument("--dirs", default=DEFAULT_DIRS, help="逗号分隔；--rmtree 时整目录删除")
    ap.add_argument("--exts", default=DEFAULT_EXTS)
    ap.add_argument("--min-mb", type=float, default=20.0)
    ap.add_argument("--files", default="", help="extra explicit file list (comma separated); "
                                               "must still live under --root")
    ap.add_argument("--glob", default="", help="相对 --root 的通配符，逗号分隔；命中的文件直接删")
    ap.add_argument("--empty", default="", help="清空这些目录的内容（相对 --root，逗号分隔）")
    ap.add_argument("--rmtree", action="store_true", help="--dirs 里的目录整棵删除")
    ap.add_argument("--delete", action="store_true")
    a = ap.parse_args()

    root = os.path.abspath(a.root)
    if not os.path.isdir(root):
        print("root 不存在:", root)
        return 1
    exts = {"." + e.strip().lstrip(".").lower() for e in a.exts.split(",") if e.strip()}
    limit = a.min_mb * 1024 * 1024
    hits, total = [], 0
    dirmode = a.rmtree
    for d in [x.strip() for x in a.dirs.split(",") if x.strip()]:
        base = os.path.join(root, d)
        if not os.path.isdir(base):
            print("skip (missing):", base)
            continue
        if dirmode:
            sz = 0
            for dp, _dn, fn in os.walk(base):
                for f in fn:
                    try:
                        sz += os.path.getsize(os.path.join(dp, f))
                    except OSError:
                        pass
            hits.append((base, sz))
            total += sz
            continue
        for dp, _dn, fn in os.walk(base):
            for f in fn:
                p = os.path.join(dp, f)
                try:
                    sz = os.path.getsize(p)
                except OSError:
                    continue
                if sz > limit and os.path.splitext(f)[1].lower() in exts:
                    hits.append((p, sz))
                    total += sz
    for p in [x.strip() for x in a.files.split(",") if x.strip()]:
        if not os.path.isfile(p):
            print("skip (missing):", p)
            continue
        sz = os.path.getsize(p)
        hits.append((p, sz))
        total += sz
    for pat in [x.strip() for x in a.glob.split(",") if x.strip()]:
        found = [p for p in glob.glob(os.path.join(root, pat)) if os.path.isfile(p)]
        if not found:
            print("skip (no match):", pat)
        for p in found:
            sz = os.path.getsize(p)
            hits.append((p, sz))
            total += sz
    empties = []
    for d in [x.strip() for x in a.empty.split(",") if x.strip()]:
        base = os.path.join(root, d)
        if not os.path.isdir(base):
            print("skip (missing):", base)
            continue
        sz = 0
        for dp, _dn, fn in os.walk(base):
            for f in fn:
                try:
                    sz += os.path.getsize(os.path.join(dp, f))
                except OSError:
                    pass
        empties.append((base, sz))
        total += sz
    hits = list(dict.fromkeys(hits))
    empties = list(dict.fromkeys(empties))

    outside = [p for p, _ in hits if not os.path.abspath(p).lower().startswith(root.lower())]
    outside += [p for p, _ in empties if not os.path.abspath(p).lower().startswith(root.lower())]
    print("root:", root)
    print("matched %d files%s, %.2f GB"
          % (len(hits), (" + %d 待清空目录" % len(empties)) if empties else "", total / 1024 ** 3))
    for p, sz in sorted(hits, key=lambda x: -x[1])[:10]:
        tag = "[DIR ]" if os.path.isdir(p) else "[FILE]"
        print("   %s %8.1f MB  %s" % (tag, sz / 1024 ** 2,
                                      os.path.relpath(p, root) if p.lower().startswith(root.lower()) else p))
    if len(hits) > 10:
        print("   ... and %d more" % (len(hits) - 10))
    for p, sz in empties:
        print("   [EMPTY] %8.1f MB  %s" % (sz / 1024 ** 2, p))
    if outside:
        print("!! target outside working dir, aborting:")
        for p in outside:
            print("   ", p)
        return 1

    free_before = shutil.disk_usage(root).free
    if not a.delete:
        print("[dry-run] nothing deleted; pass --delete to really remove.")
        return 0
    n = 0
    for p, _sz in hits:
        try:
            if os.path.isdir(p):
                shutil.rmtree(p)
            else:
                os.remove(p)
            n += 1
        except OSError as e:
            print("delete failed:", p, e)
    ne = 0
    for p, _sz in empties:
        for child in os.listdir(p):
            cp = os.path.join(p, child)
            try:
                if os.path.isdir(cp):
                    shutil.rmtree(cp, ignore_errors=True)
                else:
                    os.remove(cp)
                ne += 1
            except OSError as e:
                print("delete failed:", cp, e)
    free_after = shutil.disk_usage(root).free
    print("deleted %d/%d targets (+%d temp entries); free %.2f GB -> %.2f GB"
          % (n, len(hits), ne, free_before / 1024 ** 3, free_after / 1024 ** 3))
    return 0


if __name__ == "__main__":
    sys.exit(main())
