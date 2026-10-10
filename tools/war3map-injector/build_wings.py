"""一键构建翅膀/坐骑系统数据文件 (w3a + w3t)。

用法:
    python build_wings.py
输出:
    tools/war3map-injector/_wing.w3a       (翅膀/坐骑技能)
    tools/war3map-injector/_wing_item.w3t  (翅膀/坐骑物品 + 阿克蒙德之手, 合并后)

注意: 必须把 _hand.w3t (阿克蒙德之手 I000) 合并进来, 否则注入时会覆盖掉它!
"""
import os, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import gen_wing
import gen_wing_item
import gen_w3u
from merge_w3obj import read_all
import struct

HERE = os.path.dirname(os.path.abspath(__file__))


def merge_w3t(inputs, out):
    """合并多个 w3t (按 newId 去重), 输出 origCount=0 + customCount=N。"""
    all_cust = []
    seen = set()
    for p in inputs:
        if not os.path.exists(p):
            continue
        ver, orig, cust = read_all(p)
        for e in orig + cust:
            new_id = e[4:8]
            if new_id in seen:
                continue
            seen.add(new_id)
            all_cust.append(e)
    data = struct.pack("<ii", 2, 0) + struct.pack("<i", len(all_cust))
    for e in all_cust:
        data += e
    open(out, "wb").write(data)
    print("merged %d items -> %s" % (len(all_cust), out))
    for e in all_cust:
        print("   %s" % e[4:8].decode("latin-1"))


def merge_w3a(inputs, out):
    """合并多个 w3a (按 newId 去重)。"""
    all_cust = []
    seen = set()
    for p in inputs:
        if not os.path.exists(p):
            continue
        ver, orig, cust = read_all(p)
        for e in orig + cust:
            new_id = e[4:8]
            if new_id in seen:
                continue
            seen.add(new_id)
            all_cust.append(e)
    data = struct.pack("<ii", 2, 0) + struct.pack("<i", len(all_cust))
    for e in all_cust:
        data += e
    open(out, "wb").write(data)
    print("merged %d abilities -> %s" % (len(all_cust), out))
    for e in all_cust:
        print("   %s" % e[4:8].decode("latin-1"))


def main():
    gen_wing.build(os.path.join(HERE, "_wing.w3a"))
    gen_wing_item.build(os.path.join(HERE, "_wing_item.w3t"))
    # CRITICAL: 必须合并原有技能/物品, 否则注入时会覆盖掉它们!
    # 合并阿克蒙德之手技能 (A000/A001/A002/Azcr) + 翅膀/坐骑技能
    merge_w3a([
        os.path.join(HERE, "_lt_hand.w3a"),
        os.path.join(HERE, "_wing.w3a"),
    ], os.path.join(HERE, "_wing.w3a"))
    # 合并阿克蒙德之手物品 (I000) + 翅膀/坐骑物品
    merge_w3t([
        os.path.join(HERE, "_hand.w3t"),
        os.path.join(HERE, "_wing_item.w3t"),
    ], os.path.join(HERE, "_wing_item.w3t"))
    # 自定义坐骑单位 (w3u, 完全照抄伏魔战记: n02L/n02M/n02N/n02P/h01D)
    gen_w3u.build(os.path.join(HERE, "_wing_unit.w3u"))
    print("done")


if __name__ == "__main__":
    main()
