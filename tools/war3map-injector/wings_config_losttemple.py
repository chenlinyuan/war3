"""Lost Temple 配置（薄封装）：掠夺/重击现在也是通用默认值，这里保留显式覆盖。

为什么用"薄封装"而不是拷贝一份：默认配置以后加翅膀、改数值，LT 会自动跟上，
不会像复制品那样过期。要调掠夺的数值，改下面三行即可。

掠夺（阿克蒙德之手的脚本被动）：**击杀**敌方单位时按目标等级掠夺金币
（数值与判定照抄《西方世界的劫难6》里的「掠夺」脚本，见 scripts/wings/f.j）。
其他地图默认同样启用；需要关闭时可在对应配置中显式设为 0。
"""
from wings_config import *  # noqa: F401,F403

COMMON = dict(COMMON)              # noqa: F405
COMMON["plunder_enable"] = 1       # 打开掠夺（0 = 关闭）
COMMON["plunder_min_hp"] = 300     # 掠夺的门槛：只掠夺最大生命 ≥ 300 的单位
# 阿克蒙德之手的「重击」：概率触发额外伤害 + 眩晕（照抄燃烧里的"重击600 8%"那档）
COMMON["hand_bash_chance"] = 8     # 触发概率（%）；0 = 不带这条
COMMON["hand_bash_damage"] = 600   # 额外伤害

# The core config now uses a reduced five-buffer set.  Keep the Lost Temple
# compatibility build self-contained by mapping the legacy aura keys onto
# those generated buffers.
BUFFS = dict(BUFFS)
BUFFS.update({
    "aura_unholy": BUFFS["akmond"],
    "aura_vamp": BUFFS["ash_slow"],
    "aura_brill": BUFFS["spell_shield"],
    "aura_heal": BUFFS["heal_native"],
    "aura_show": BUFFS["heal_show"],
    "aura_command": BUFFS["akmond"],
    "aura_endur": BUFFS["ash_slow"],
    "warglaive_charge": BUFFS["spell_shield"],
})

UNHOLY_BUFF_TEXT = "移动速度与生命恢复提高。"
VAMP_BUFF_TEXT = "攻击时吸取生命。"
BRILL_BUFF_TEXT = "提高魔法恢复速度。"
COMMAND_BUFF_TEXT = "提高周围友军攻击力。"
ENDUR_BUFF_TEXT = "提高周围友军攻击与移动速度。"
WARGLAIVE_CHARGE_BUFF_TEXT = "邪能冲锋命中目标。"
# 其余数值都跟着默认配置走，要调就照上面这样写一行覆盖。
