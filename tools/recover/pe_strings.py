# -*- coding: utf-8 -*-
"""从一个 exe/dll 里抓可读字符串（ASCII + UTF-16LE），用来判断它改注册表还是改配置文件。

用法: python pe_strings.py <文件> [关键词...]
"""
import re
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")


def strings(path, minlen=5, cjk=False):
    data = open(path, "rb").read()
    out = []
    if cjk:
        # UTF-8 里的中文（含 ASCII 混排）：连续的可打印/多字节序列
        for m in re.finditer(rb"[\x20-\x7e\xc2-\xf4][\x20-\x7e\x80-\xbf]*", data):
            s = m.group()
            if len(s) < minlen:
                continue
            try:
                v = s.decode("utf-8")
            except UnicodeDecodeError:
                continue
            if re.search(r"[\u4e00-\u9fff]{2,}", v):
                out.append(v)
        # GBK 里的中文（KKWE 编译脚本常用）
        try:
            g = data.decode("gbk", "ignore")
        except Exception:  # noqa: BLE001
            g = ""
        for m in re.finditer(r"[\u4e00-\u9fff\x20-\x7e]{3,}", g):
            v = m.group().strip()
            if re.search(r"[\u4e00-\u9fff]{2,}", v):
                out.append(v)
        return out
    for m in re.finditer(rb"[\x20-\x7e]{%d,}" % minlen, data):
        out.append(m.group().decode("latin-1"))
    for m in re.finditer(rb"(?:[\x20-\x7e]\x00){%d,}" % minlen, data):
        out.append(m.group().decode("utf-16-le"))
    return out


def main():
    path = sys.argv[1]
    args = sys.argv[2:]
    cjk = "--cjk" in args
    keys = [k.lower() for k in args if not k.startswith("--")]
    seen = set()
    for s in strings(path, cjk=cjk):
        if s in seen:
            continue
        seen.add(s)
        if keys and not any(k in s.lower() for k in keys):
            continue
        print(s[:160])
    return 0


if __name__ == "__main__":
    sys.exit(main())
