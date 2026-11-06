"""Forsaken Kingdom 3.0.1: four real wings, no mounts.

The 3.0.1 campaign already uses I000/A000-A002, so the hand is remapped to
I103/A100-A102.  Test wings and unrelated item overrides are disabled.
"""

from wings_config_forsaken_undead import *  # noqa: F401,F403

HAND = dict(HAND)
HAND.update({
    "item": "I103",
    "finger": "A100",
    "aura": "A101",
    "speed": "A102",
    "crit": "Azcr",
    "bash": "W091",
})

COMMON = dict(COMMON)
COMMON.update({
    "act_avatar_duration": 30.0,
    "act_avatar_cd": 120.0,
    "act_avatar_mana": 100,
    "act_avatar_defense_bonus": 0.0,
    "act_avatar_hp_bonus": 500.0,
    "act_avatar_damage_bonus": 20.0,
    "act_avatar_magic_reduction": 0.0,
    "act_avatar_life_cost_pct": 0.20,
    "act_avatar_attack_range": 500.0,
    "act_avatar_projectile_speed": 1200.0,
    "act_avatar_acquisition_range": 800.0,
    "act_avatar_air_target_flag": 2,
    "act_avatar_splash_full": 50.0,
    "act_avatar_splash_medium": 150.0,
    "act_avatar_splash_small": 250.0,
    "act_avatar_splash_medium_factor": 0.5,
    "act_avatar_splash_small_factor": 0.25,
    "act_avatar_missile": (
        r"Abilities\Weapons\DemonHunterMissile\DemonHunterMissile.mdx"
    ),
})

TEST_WINGS = []
TEST_ARTS = []
ITEM_OVERRIDES = []

BUFFS = dict(BUFFS)
BUFFS.update({
    "aura_unholy": "BUau",
    "aura_vamp": "BUav",
    "aura_brill": "BHab",
    "aura_heal": BUFFS["heal_native"],
    "aura_show": BUFFS["heal_show"],
    "aura_command": "BOac",
    "aura_endur": "BOae",
    "warglaive_charge": BUFFS["spell_shield"],
})

UNHOLY_BUFF_TEXT = "移动速度与生命恢复提高。"
VAMP_BUFF_TEXT = "攻击时吸取生命。"
BRILL_BUFF_TEXT = "提高魔法恢复速度。"
COMMAND_BUFF_TEXT = "提高周围友军攻击力。"
ENDUR_BUFF_TEXT = "提高周围友军攻击与移动速度。"
WARGLAIVE_CHARGE_BUFF_TEXT = "邪能冲锋命中目标。"
