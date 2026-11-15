# -*- coding: utf-8 -*-
"""中和"跨关卡存档标记"对主线的控制。

实测（194213 第 2 章）：

    // 商城福利「敌人弱化」(key JDOLS5)，注册在 5 秒（单次 + 周期 + 单位死亡 + 读档）上
    set udg_ruohua = 10

    // 另一个 2 秒周期触发器：把这个状态**写进玩家的战役存档**
    function Trig____036Actions ...
        set udg_qianghua = 10
        call InitGameCacheBJ("qianghua")
        call StoreInteger(GetLastCreatedGameCacheBJ(), "qiang", "hua", udg_qianghua)
        call SaveGameCache(GetLastCreatedGameCacheBJ())

存档落在 `H:\\Games\\War3\\Save\\ProfileN\\Campaigns.w3v`（跨关卡、跨存档）。第 2 章
开局又把它读回来：

    set udg_bobo = GetStoredInteger(GetLastCreatedGameCacheBJ(), "qiang", "hua")

而这个标记一旦非 0：

  * 博拉尔过场的自然分支条件 `udg_bobo == 0 and ...` 不成立 —— 只有这一支才会
    `SetUnitInvulnerable(gg_unit_npgr_0460, false)` +
    `SetDestructableInvulnerable(gg_dest_B60P_4539, false)`（把封印改成可攻击）；
  * BOSS「邪能之体」的解封触发器条件也是 `udg_bobo == 0`。

结果就是主线「获得邪能能源」永远做不完：封印打不动、BOSS 不出现。

处理：
  * 读取那一行改成常量 0（第 2 章里 `udg_bobo` 只用于上面这两个判断）；
  * 写入那一行改成 DoNothing，避免再把标记写进玩家存档。

配合 `_gate_scan.cache_poison_keys()`（把这类"会写存档的商城福利"强制 mall_false），
就不会再被自动激活。
"""
import re
import sys

# 跨关卡"进度标记"：(cache, key)。这些只服务"你已经通关过/开过强化"这类捷径，
# 离线版里会让章节走跳过分支（不触发任务、过不了关），所以一律读作 0、且不再写入。
# 注意：akmd/minjie、chongwu/minjie01 等是"属性继承"，属于设计，**不要动**。
PROGRESS_KEYS = [
    ("qiang", "hua"), ("gao", "gao"), ("p", "p"),
    ("ben", "di"), ("o", "o"), ("g", "g"), ("mao", "tou"),
    ("r", "r"), ("hui", "hui"), ("du", "yao"), ("sao", "01"),
    ("ransao", "cishu"),
]
RX_READ_ANY = re.compile(
    r'(?m)^([ \t]*)set\s+(\w+)\s*=\s*GetStored(?:Integer|Boolean|Real)\('
    r'\s*[^,]*,\s*"([^"]*)"\s*,\s*"([^"]*)"\s*\)[ \t]*$')
RX_WRITE_ANY = re.compile(
    r'(?m)^([ \t]*)call\s+Store(?:Integer|Boolean|Real)\(\s*[^,]*,\s*"([^"]*)"\s*,\s*"([^"]*)"')
RX_TYPO = re.compile(r'"xiran01\.w3v"')


def patch(text):
    keys = set(PROGRESS_KEYS)
    n = [0, 0, 0]  # reads, writes, typo

    def rd(m):
        if (m.group(3), m.group(4)) not in keys:
            return m.group(0)
        n[0] += 1
        return ("%sset %s = 0 // IB: progress flag %s/%s ignored "
                "(it would skip quests / block chapter completion)"
                % (m.group(1), m.group(2), m.group(3), m.group(4)))

    def wr(m):
        if (m.group(2), m.group(3)) not in keys:
            return m.group(0)
        n[1] += 1
        return "%scall DoNothing() // IB: never persist progress flag %s/%s" % (
            m.group(1), m.group(2), m.group(3))

    def fix_typo(m):
        n[2] += 1
        return '"xinran01.w3v"'

    new = RX_READ_ANY.sub(rd, text)
    new = RX_WRITE_ANY.sub(wr, new)
    new = RX_TYPO.sub(fix_typo, new)
    return new, n[0], n[1], n[2]


def main():
    for p in sys.argv[1:]:
        raw = open(p, "rb").read()
        new, nr, nw, nt = patch(raw.decode("utf-8", "surrogateescape"))
        print("%-20s progress reads zeroed=%d, writes cut=%d, typo=%d"
              % (p.replace("\\", "/").split("/")[-1], nr, nw, nt))
        if nr or nw or nt:
            with open(p, "wb") as f:
                f.write(new.encode("utf-8", "surrogateescape"))


if __name__ == "__main__":
    main()
