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

TEST_WINGS = []
TEST_ARTS = []
ITEM_OVERRIDES = []
