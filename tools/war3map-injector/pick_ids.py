"""扫描目标地图已占用的 4 字符 ID，检查冲突 / 自动挑空闲 ID 写回 wings_config.py。

用法:
    python pick_ids.py <地图> --check     # 只报告：本系统用的 ID 有没有和目标图撞车
    python pick_ids.py <地图> --write     # 自动挑空闲 ID，并写回 wings_config.py

    # 战役：对象数据 = 战役级一份 + 每章各一份，两边都要算（--chapters）
    python pick_ids.py <战役.w3n> --campaign --chapters --check
    python pick_ids.py <战役.w3n> --campaign --chapters --write

说明:
  * 扫的是地图自己的对象数据（w3a 技能 / w3t 物品 / w3u 单位 / w3h buff / w3q 升级 /
    w3b 可破坏物 / w3d 装饰物）里出现过的 ID。
  * **游戏自带**的 ID 被我们的自定义对象"遮盖"是安全的（地图里的定义优先），
    所以这里只关心"目标图自己用过"的 ID。
  * 如果你扫的就是本系统自己改出来的图，那当然会报一堆"冲突"—— 这是正常的。
"""
import os
import re
import struct
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import war3mpq as W  # noqa: E402
from merge_w3obj import read_all  # noqa: E402
CFG = __import__(os.environ.get("WINGS_CONFIG", "wings_config"))   # 移植到别的图时可用 WINGS_CONFIG=<别的配置模块名>

CFG_PATH = getattr(CFG, "__file__", os.path.join(HERE, "wings_config.py"))
SCAN_FILES = ["war3map.w3a", "war3map.w3t", "war3map.w3u", "war3map.w3h",
              "war3map.w3q", "war3map.w3b", "war3map.w3d"]
# 有些图（W3x2lni "SLK 化"）把自定义物品/单位**内联进 slk/txt**，war3map.w3t 之类是空的。
#   这些文件里的对象 ID 也必须算进"已占用"，否则会撞车查不出来。
SLK_FILES = ["units\\itemdata.slk", "units\\unitui.slk", "units\\unitdata.slk",
             "units\\unitbalance.slk", "units\\unitweapons.slk",
             "units\\unitabilities.slk", "units\\abilitydata.slk",
             "units\\abilitybuffdata.slk", "units\\upgradedata.slk",
             "units\\destructabledata.slk"]
FUNC_FILES = ["units\\itemfunc.txt", "units\\humanunitfunc.txt", "units\\orcunitfunc.txt",
              "units\\undeadunitfunc.txt", "units\\nightelfunitfunc.txt",
              "units\\neutralunitfunc.txt", "units\\campaignunitfunc.txt",
              "units\\commonabilityfunc.txt", "units\\humanabilityfunc.txt",
              "units\\orcabilityfunc.txt", "units\\undeadabilityfunc.txt",
              "units\\nightelfabilityfunc.txt", "units\\neutralabilityfunc.txt",
              "units\\campaignabilityfunc.txt", "units\\itemabilityfunc.txt"]
ID_RE = re.compile(r"^[0-9A-Za-z]{4}$")


def slk_ids(data):
    """SLK 里第 1 列（X1）就是对象 ID。"""
    t = data.decode("latin-1", "replace")
    ids = set()
    cx = cy = 1
    for m in re.finditer(r'C;((?:[XY]\d+;)*)K"((?:[^"]|"")*)"', t):
        for c in m.group(1).split(";"):
            if c[:1] == "Y":
                cy = int(c[1:])
            elif c[:1] == "X":
                cx = int(c[1:])
        if cx == 1 and ID_RE.match(m.group(2)):
            ids.add(m.group(2))
    return ids


def func_ids(data):
    """func.txt 里的 [xxxx] 段头就是被改写的对象 ID。"""
    out = set()
    for m in re.finditer(rb"^\[([0-9A-Za-z]{4})\]", data, re.M):
        out.add(m.group(1).decode("latin-1"))
    return out


def used_ids_in(ar, scan_files, with_slk=True):
    """一个归档（地图 / 章节）里对象数据出现过的所有 4 字符 ID。"""
    used, skipped = set(), []
    for name in scan_files:
        data = ar.read_file(name)
        if not data:
            continue
            # ⚠ 临时文件必须带正确后缀: read_all 靠后缀判断"有没有 level/column 列"
            #   (w3a/w3q 有)。以前统一写成 .w3xobj, 于是 w3a/w3q/w3d 全都解析失败
            #   -> 那些文件里的 ID 根本没被算进"已占用", 冲突检查是漏的。
        tmp = os.path.join(HERE, "_tmp_pick." + name.rsplit(".", 1)[-1])
        open(tmp, "wb").write(data)
        try:
            _ver, orig, cust = read_all(tmp)
        except Exception as e:
            # 读不出来的要如实报出来（例如 HKE 写过的图，扇区加密方式不同），
            #   否则"已占用 0 个"会误导人。
            skipped.append("%s(%s)" % (name, str(e)[:40]))
            continue
        finally:
            os.remove(tmp)
        for e in orig + cust:
            old = e[0:4].decode("latin-1")
            new = e[4:8].decode("latin-1")
            if old.strip():
                used.add(old)
            if new.strip():
                used.add(new)
    # SLK/txt 里内联的对象 ID（W3x2lni "SLK 化"的图靠这个才行）
    if with_slk:
        for name in SLK_FILES:
            d = ar.read_file(name)
            if d:
                used |= slk_ids(d)
        for name in FUNC_FILES:
            d = ar.read_file(name)
            if d:
                used |= func_ids(d)
    return used, skipped


CH_SCAN_FILES = ["war3map." + ext for ext in ("w3a", "w3t", "w3u", "w3h",
                                              "w3q", "w3b", "w3d")]


def map_used_ids(path, chapters=False):
    """地图对象数据里出现过的所有 4 字符 ID。

    chapters=True（战役 .w3n）：把里面每个章节地图的**自己的**对象数据也算进来 ——
    对象数据如果逐章注入，章节自己用掉的 ID 同样会和我们撞车。
    """
    used = set()
    skipped = []
    a = W.MPQArchive(path)
    try:
        u, sk = used_ids_in(a, SCAN_FILES)
        used |= u
        skipped += sk
        if chapters:
            names = [n for n in (a.listfile or [])
                     if n.lower().endswith((".w3x", ".w3m"))]
            tmp = os.path.join(HERE, "_tmp_ch.w3x")
            for n in sorted(names):
                data = a.read_file(n)
                if not data:
                    continue
                open(tmp, "wb").write(data)
                try:
                    sub = W.MPQArchive(tmp)
                    try:
                        u2, sk2 = used_ids_in(sub, CH_SCAN_FILES, with_slk=False)
                        used |= u2
                        skipped += ["%s:%s" % (n, s) for s in sk2]
                    finally:
                        sub.close()
                finally:
                    os.remove(tmp)
    finally:
        a.close()
    if skipped:
        print("   ! 有 %d 个文件读不出来（这些文件里的 ID 没算进去）: %s"
              % (len(skipped), ", ".join(skipped)))
    return used


def our_groups():
    """返回 [(字典名, 键, 当前 ID)]，顺序稳定。"""
    out = []
    for dname, d in (("ABIL", CFG.ABIL), ("ITEMS", CFG.ITEMS), ("UNITS", CFG.UNITS),
                     ("BUFFS", CFG.BUFFS), ("HAND", CFG.HAND)):
        for k, v in d.items():
            out.append((dname, k, v))
    return out


def alloc(prefix, digits, used, n):
    """在 prefix + 数字 的空间里挑 n 个没被占用的 ID。"""
    got = []
    for i in range(100, 100 + 900):
        cand = prefix + ("%0*d" % (digits, i) if digits else str(i))
        if len(cand) != 4:
            continue
        if cand in used:
            continue
        got.append(cand)
        if len(got) >= n:
            return got
    raise SystemExit("可用 ID 不够: %s" % prefix)


def write_config(mapping):
    """把 {键: 新ID} 写回 wings_config.py（按 '键名": "旧ID"' 精确定位，保持顺序）。"""
    s = open(CFG_PATH, "rb").read().decode("utf-8")
    n = 0
    for key, new_id in mapping.items():
        pat = re.compile(r'("%s"\s*:\s*")([A-Za-z0-9]{4})(")' % re.escape(key))
        s, cnt = pat.subn(lambda m: m.group(1) + new_id + m.group(3), s)
        if not cnt:
            print("  !! 找不到键:", key)
        n += cnt
    open(CFG_PATH, "wb").write(s.encode("utf-8"))
    # NOTE: 必须清掉这个配置模块的 __pycache__。改名前后文件大小常常一样,
    #   而 .pyc 只按 (mtime, size) 校验、mtime 是秒级 -> 同一秒内改写会命中旧缓存,
    #   后面的生成器就会读到改名前的 ID（实测踩过：凤凰被改成 n100 但生成物还是 h01D）。
    try:
        import importlib.util
        import glob
        pyc = importlib.util.cache_from_source(CFG_PATH)
        for p in [pyc] + glob.glob(os.path.splitext(pyc)[0] + "*.pyc"):
            if os.path.exists(p):
                os.remove(p)
                print("  已清除旧缓存:", os.path.basename(p))
    except Exception as e:
        print("  ! 清缓存失败:", e)
    print("已写回 %d 处 ID -> %s" % (n, os.path.relpath(CFG_PATH, os.path.dirname(HERE))))


def main():
    if len(sys.argv) < 3:
        print(__doc__)
        return 1
    # --chapters: 目标是 .w3n，连每个章节内部的对象数据一起扫
    chapters = "--chapters" in sys.argv
    if chapters:
        sys.argv.remove("--chapters")
    # --campaign: 目标是 .w3n（对象数据在 war3campaign.w3a/.w3t/.w3u/.w3h…）
    if "--campaign" in sys.argv:
        sys.argv.remove("--campaign")
        SCAN_FILES[:] = ["war3campaign." + ext for ext in
                         ("w3a", "w3t", "w3u", "w3h", "w3q", "w3b", "w3d")]
    path = sys.argv[1]
    mode = sys.argv[2]
    used = map_used_ids(path, chapters=chapters)
    print("目标图已占用 ID: %d 个" % len(used))

    if mode == "--check":
        bad = [(d, k, v) for (d, k, v) in our_groups() if v in used]
        if not bad:
            print("没有冲突：本系统用的 %d 个 ID 在目标图里全部空闲。" % len(our_groups()))
        else:
            print("发现 %d 处冲突（这些 ID 目标图自己用了）：" % len(bad))
            for d, k, v in bad:
                print("   %s.%s = %s" % (d, k, v))
            print("\n跑 `python pick_ids.py <地图> --write` 可以自动换一批空闲 ID。")
        return 0

    if mode == "--write":
        # 只给"属于本系统、且和地图冲突"的 ID 重新分配；同时保证新 ID 不撞车
        mapping = {}
        groups = [("ABIL", "W", 0, CFG.ABIL), ("ITEMS", "I", 0, CFG.ITEMS),
                  ("UNITS", "n", 0, CFG.UNITS), ("BUFFS", "B", 0, CFG.BUFFS),
                  # 阿克蒙德之手：item 是物品，其余 4 个都是技能
                  ("HAND.item", "I", 0, {"item": CFG.HAND["item"]}),
                  ("HAND.abil", "A", 0,
                   {k: v for k, v in CFG.HAND.items() if k != "item"})]
        # 目标图用掉的 ID + **本系统自己现有的全部 ID** 都不能再用
        # （否则会把新 ID 分给一个我们自己已经占用的号，例如物品撞 I100）
        taken = set(used) | {v for _d, _k, v in our_groups()}
        for dname, prefix, digits, d in groups:
            need = [k for k, v in d.items() if v in used]
            if not need:
                continue
            new = alloc(prefix, digits, taken, len(need))
            for k, nid in zip(need, new):
                mapping[k] = nid
                taken.add(nid)
            print("  %s: %d 个冲突 ID 重新分配" % (dname, len(need)))
        if not mapping:
            print("没有冲突，不需要改动。")
            return 0
        write_config(mapping)
        print("\n接着跑: python build_wings.py && python validate_dir.py scripts/wings")
        return 0

    print("未知参数:", mode)
    return 1


if __name__ == "__main__":
    sys.exit(main())
