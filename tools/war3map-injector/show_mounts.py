"""打印 5 个坐骑的攻击数据：游戏自带基础单位的武器数据 + 我们 w3u 里的覆盖。

用法: python show_mounts.py
"""
import os
import struct
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from _slk_num import parse_slk_num  # noqa: E402
from merge_w3obj import read_all  # noqa: E402
from patch_hand_item_icon import read_mods  # noqa: E402

GAME = r"H:\Games\War3\ojzrqpjb\share\mpq\units\units"
HERE = os.path.dirname(os.path.abspath(__file__))

# (新ID, 名字, 基础单位ID)
MOUNTS = [("n02L", "青铜龙", "nbzd"), ("n02M", "黑龙", "nbwm"), ("n02N", "蓝龙", "nadr"),
          ("n02P", "红龙", "nrwm"), ("h01D", "凤凰", "hphx")]

WANT = ["atkType1", "dmgType1", "dmgplus1", "dice1", "sides1", "cool1", "rangeN1",
        "targCount1", "splashTargs1", "splashType1", "splashRadius1", "splashTargs2",
        "splashType2", "splashRadius2", "weapTp1", "missileArc", "dmgpt1", "backSw1",
        "farea1", "hsplatArt", "ua1d", "fullDmg1", "halfDmg1"]


def slk_rows(fname):
    p = os.path.join(GAME, fname)
    rows = parse_slk_num(p)
    hdr = rows.get(1, {})
    return rows, hdr, {v: k for k, v in hdr.items()}


def main():
    wrows, whdr, wcols = slk_rows("unitweapons.slk")
    brows, bhdr, bcols = slk_rows("unitbalance.slk")
    idcol = wcols.get("unitWeaponID") or 1

    print("=== 游戏自带基础单位的武器数据 (unitweapons.slk) ===")
    base = {}
    for y in sorted(wrows):
        r = wrows[y]
        if r.get(idcol) in [m[2] for m in MOUNTS]:
            base[r[idcol]] = r
            print("--", r[idcol])
            for k in WANT:
                if k in wcols and r.get(wcols[k]) not in (None, "", "-"):
                    print("     %-14s = %s" % (k, r[wcols[k]]))

    print("\n=== 平衡数据 (unitbalance.slk) ===")
    bidcol = bcols.get("unitBalanceID") or 1
    for y in sorted(brows):
        r = brows[y]
        if r.get(bidcol) in [m[2] for m in MOUNTS]:
            print("--", r[bidcol], {k: r[bcols[k]] for k in
                                    ("HP", "def", "defType", "spd", "regenHP")
                                    if k in bcols and r.get(bcols[k]) not in (None, "", "-")})

    print("\n=== 我们 w3u 里对坐骑的覆盖 (_wing_unit.w3u) ===")
    ver, orig, cust = read_all(os.path.join(HERE, "_wing_unit.w3u"))
    for e in orig + cust:
        nid = e[4:8].decode("latin-1")
        name = dict((m[2], m[0]) for m in MOUNTS).get(nid, "")
        d = {m[0].decode("latin-1"): m[2] for m in read_mods(e)[0]}
        keys = [k for k in ("umdl", "ua1b", "ua1t", "ua1p", "ua1c", "ua1d", "ua1s", "ua1r",
                            "umvs", "uhpr", "ufoo", "ussc", "usca", "uabi", "uble")
                if k in d]
        print("--", nid, name)
        for k in keys:
            print("     %-6s = %r" % (k, d[k]))
    return 0


if __name__ == "__main__":
    sys.exit(main())
