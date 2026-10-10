"""Inject item-browser + skills into campaign chapter maps.

Workflow per chapter:
  1. copy <campaign>/<chapter>.w3x -> maps/campaign/<chapter>.w3x (work copy)
  2. inject_map.py (script injection: f.j/g.j/m.j)
  3. fix_globals_order.py (move our vars after map's constant decls)

Usage:
    python inject_campaign_chapters.py <campaign_dir> [chapter1 chapter2 ...]
    (no chapters -> all .w3x in campaign dir)
"""
import os, shutil, subprocess, sys

HERE = os.path.dirname(os.path.abspath(__file__))
BASE = os.path.dirname(os.path.dirname(HERE))
PY = sys.executable or "c:/python313/python.exe"
WORK = os.path.join(BASE, "maps", "campaign")
SCRIPTS = os.path.join(BASE, "scripts", "item-browser")


def run(args, allow_fail=False):
    print(">>>", " ".join(str(a) for a in args), flush=True)
    r = subprocess.run(args, capture_output=True)
    out = r.stdout.decode("utf-8", "replace") + r.stderr.decode("utf-8", "replace")
    sys.stdout.buffer.write(out.encode("utf-8", "replace"))
    sys.stdout.buffer.write(b"\n")
    sys.stdout.flush()
    if r.returncode != 0 and not allow_fail:
        print("!! command failed: %s" % args, flush=True)
    return r.returncode


def main():
    camp_dir = os.path.abspath(sys.argv[1])
    chapters = sys.argv[2:]
    if not chapters:
        chapters = sorted(f for f in os.listdir(camp_dir)
                          if f.lower().endswith(".w3x"))
    os.makedirs(WORK, exist_ok=True)
    print("chapters:", len(chapters), flush=True)

    for ch in chapters:
        src = os.path.join(camp_dir, ch)
        if not os.path.isfile(src):
            print("SKIP missing:", src, flush=True)
            continue
        dst = os.path.join(WORK, ch)
        print("\n===== %s =====" % ch, flush=True)
        shutil.copy2(src, dst)
        print("work copy:", dst, os.path.getsize(dst), flush=True)

        # 1. manual script injection (HKE 注入脚本 breaks on YDWE '//endglobals from'
        #    comments -> inserts f.j once per 'endglobals' substring; we assemble
        #    the script ourselves and replace war3map.j via 添加/替换文件)
        run([PY, os.path.join(HERE, "inject_script_manual.py"), dst, SCRIPTS], allow_fail=True)
        print("done:", ch, os.path.getsize(dst), flush=True)

    print("\n=== all done ===", flush=True)


if __name__ == "__main__":
    main()
