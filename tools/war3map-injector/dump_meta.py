"""从 abilitymetadata.slk 查字段默认值（acdn/amcs/aran/adur 等）。"""
import re, sys

SLK = r"H:\Games\War3\ojzrqpjb\share\mpq\units\units\abilitymetadata.slk"


def main():
    raw = open(SLK, "rb").read().decode("utf-8", "replace")
    fields = sys.argv[1:] if len(sys.argv) > 1 else ["acdn", "amcs", "aran", "adur", "alev"]
    for f in fields:
        idx = raw.find('X1;K"%s"' % f)
        if idx < 0:
            print("%s: not found" % f)
            continue
        seg = raw[idx:idx + 500]
        # 打印该字段块
        print("=== %s ===" % f)
        print(seg[:400].replace("\r\n", " | "))
        print()


if __name__ == "__main__":
    main()
