"""一键构建翅膀/坐骑系统数据文件 (w3a + w3t)。

用法:
    python build_wings.py
输出:
    tools/war3map-injector/_wing.w3a       (翅膀/坐骑技能)
    tools/war3map-injector/_wing_item.w3t  (翅膀/坐骑物品 + 阿克蒙德之手, 合并后)

注意: 必须把 _hand.w3t (阿克蒙德之手 I000) 合并进来, 否则注入时会覆盖掉它!
"""
import os, shutil, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import gen_wing
import gen_wing_item
import gen_w3u
import hand_data
from merge_w3obj import read_all, merge_files
import struct

HERE = os.path.dirname(os.path.abspath(__file__))


def merge_w3a(inputs, out):
    """合并多个 w3a —— 保留 orig/custom 分段（见 merge_w3obj.merge_files 说明）。"""
    n_orig, n_cust = merge_files(out, inputs)
    print("merge w3a: %d orig + %d custom -> %s" % (n_orig, n_cust, os.path.basename(out)))
    for p in inputs:
        if os.path.exists(p):
            _v, _o, cust = read_all(p)
            print("   %s: %s" % (os.path.basename(p), [e[4:8].decode("latin-1") for e in cust]))


def merge_w3t(inputs, out):
    """合并多个 w3t（同样保留 orig/custom 分段）。"""
    n_orig, n_cust = merge_files(out, inputs)
    print("merge w3t: %d orig + %d custom -> %s" % (n_orig, n_cust, os.path.basename(out)))
    for p in inputs:
        if os.path.exists(p):
            _v, _o, cust = read_all(p)
            print("   %s: %s" % (os.path.basename(p), [e[4:8].decode("latin-1") for e in cust]))


def main():
    # 0) 先从 wings_config.py 生成 JASS 里的表（f.j / g.j 的生成段）
    import gen_jass_tables
    gen_jass_tables.main()
    gen_wing.build(os.path.join(HERE, "_wing.w3a"))
    gen_wing_item.build(os.path.join(HERE, "_wing_item.w3t"))
    # 存一份"没合并阿克蒙德之手"的版本：移植到别的图时用它（不带 LostTemple 专属装备）
    shutil.copy2(os.path.join(HERE, "_wing.w3a"), os.path.join(HERE, "_wing_nohand.w3a"))
    shutil.copy2(os.path.join(HERE, "_wing_item.w3t"), os.path.join(HERE, "_wing_item_nohand.w3t"))
    # 阿克蒙德之手：按配置 HAND 里的 ID 重写模板（换图时 pick_ids 会自动避开占用）
    hand_data.build(os.path.join(HERE, "_hand_reid.w3t"),
                    os.path.join(HERE, "_lt_hand_reid.w3a"))
    # CRITICAL: 必须合并原有技能/物品, 否则注入时会覆盖掉它们!
    # 合并阿克蒙德之手技能 + 翅膀/坐骑技能
    merge_w3a([
        os.path.join(HERE, "_lt_hand_reid.w3a"),
        os.path.join(HERE, "_wing.w3a"),
    ], os.path.join(HERE, "_wing.w3a"))
    # 合并阿克蒙德之手物品 (I000) + 翅膀/坐骑物品
    merge_w3t([
        os.path.join(HERE, "_hand_reid.w3t"),
        os.path.join(HERE, "_wing_item.w3t"),
    ], os.path.join(HERE, "_wing_item.w3t"))
    # 自定义坐骑单位 (w3u, 完全照抄伏魔战记: n02L/n02M/n02N/n02P/h01D)
    gen_w3u.build(os.path.join(HERE, "_wing_unit.w3u"))
    print("done")


if __name__ == "__main__":
    main()
