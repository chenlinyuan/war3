"""生成"致命一击"被动技能的 w3a 条目（技能栏图标，被动）。

基础技能: AItx (Item Attack Bonus, 被动, X8=item) —— 单位可添加, 显示图标。
实际暴击效果由 JASS 事件执行（IB_CritOnDamage），技能本身无效果。

用法:
    python gen_w3a_crit.py <输出w3a> <技能ID> [名称]
"""
import struct, sys, os

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from gen_w3a import write_entry
from gen_w3a_finger import mod, write_mod

BASE = "AItx"
ICON = "ReplaceableTextures\\PassiveButtons\\PASBTNCriticalStrike.blp"


def build_new_entry(new_id, name="致命一击"):
    # 被动技能: 只需名称/图标/等级，无 aord/目标
    mods = [
        mod("anam", 3, 0, 0, name),
        mod("atp1", 3, 0, 0, name + "(被动)"),
        mod("aub1", 3, 0, 0, "攻击时按概率造成 2~100 倍伤害。"),
        mod("aart", 3, 0, 0, ICON),
        mod("arar", 3, 0, 0, ICON),
        mod("arac", 3, 0, 0, "creeps"),
        mod("alev", 0, 0, 0, 1),
        mod("abpx", 0, 0, 0, 1),
        mod("abpy", 0, 0, 0, 0),
    ]
    return (BASE, new_id, mods)


def build(out_path, new_id, name="致命一击"):
    entry = build_new_entry(new_id, name)
    data = struct.pack("<ii", 2, 0) + struct.pack("<i", 1)
    data += write_entry(*entry)
    open(out_path, "wb").write(data)
    print("wrote %s: %d bytes (base=%s new=%s)" % (out_path, len(data), BASE, new_id))


if __name__ == "__main__":
    if len(sys.argv) < 3:
        print(__doc__)
        sys.exit(1)
    out = sys.argv[1]
    new_id = sys.argv[2]
    name = sys.argv[3] if len(sys.argv) > 3 else "致命一击"
    build(out, new_id, name)
