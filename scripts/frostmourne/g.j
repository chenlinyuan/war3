// Frostmourne item behavior
integer FR_ITEM_ID = 'I105'
integer FR_SPELL_ID = 'A105'

trigger fr_spell_trigger = null
trigger fr_attack_trigger = null
trigger fr_pickup_trigger = null
group fr_slow_group = null
hashtable fr_slow_table = null
timer fr_slow_timer = null
integer fr_ground_count = 0
item array fr_ground_items
integer array fr_ground_keys
effect array fr_ground_effects
real array fr_ground_x
real array fr_ground_y
hashtable fr_ground_table = null
rect fr_world = null
timer fr_ground_timer = null

boolean fr_inited = false

real FR_SPELL_RADIUS = 550.0
real FR_SPELL_STAT_MULT = 4.0
real FR_SLOW_FACTOR = 0.35
real FR_SLOW_DURATION = 4.0
real FR_SLOW_HERO_DURATION = 2.0
