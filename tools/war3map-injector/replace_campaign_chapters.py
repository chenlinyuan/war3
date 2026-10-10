"""Replace all modified chapter maps inside the campaign .w3n.

Usage:
    python replace_campaign_chapters.py <campaign.w3n> <chapters_dir>
"""
import os, sys, subprocess

HERE = os.path.dirname(os.path.abspath(__file__))
PY = sys.executable or "c:/python313/python.exe"


def main():
    camp = os.path.abspath(sys.argv[1])
    chdir = os.path.abspath(sys.argv[2])
    chapters = sorted(f for f in os.listdir(chdir)
                      if f.lower().endswith(".w3x") and not f.startswith("_"))
    print("replacing %d chapters" % len(chapters), flush=True)
    for ch in chapters:
        src = os.path.join(chdir, ch)
        print(">>> %s (%d bytes)" % (ch, os.path.getsize(src)), flush=True)
        r = subprocess.run([PY, os.path.join(HERE, "inject_file.py"),
                            camp, src, ch], capture_output=True)
        out = (r.stdout + r.stderr).decode("utf-8", "replace")
        sys.stdout.buffer.write(out.encode("utf-8", "replace"))
        sys.stdout.buffer.write(b"\n")
        sys.stdout.flush()
    print("=== all replaced ===", flush=True)


if __name__ == "__main__":
    main()
