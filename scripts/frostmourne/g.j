// Frostmourne item behavior
boolean FR_ITEM_ACTIVE = false
integer FR_ITEM_ID = 'I105'
integer FR_SPELL_ID = 'A105'
integer FR_NOVA_ABILITY = 'A170'
integer FR_NOVA_DUMMY = 'hfoo'
integer FR_NOVA_LIFE = 'BTLF'

trigger fr_spell_trigger = null
trigger fr_attack_trigger = null
trigger fr_pickup_trigger = null
trigger fr_drop_trigger = null
trigger fr_revive_trigger = null
trigger fr_soul_trigger = null
hashtable fr_freeze_table = null
hashtable fr_freeze_timer_table = null
hashtable fr_soul_source_table = null
hashtable fr_soul_timer_table = null
hashtable fr_cooldown_table = null
hashtable fr_active_fx_table = null
hashtable fr_cast_guard_table = null
integer fr_ground_count = 0
item array fr_ground_items
integer array fr_ground_keys
effect array fr_ground_effects
real array fr_ground_x
real array fr_ground_y
hashtable fr_ground_table = null
rect fr_world = null
timer fr_ground_timer = null
timer fr_clock = null

boolean fr_inited = false

real FR_SPELL_RADIUS = 550.0
real FR_SPELL_STAT_MULT = 4.0
real FR_NOVA_CHANCE = 0.30
real FR_ACTIVE_LIFE_COST = 0.20
real FR_ACTIVE_MANA_COST = 100.0
real FR_ACTIVE_COOLDOWN = 10.0
real FR_CAST_GUARD_SECONDS = 9.5
real FR_SOUL_NORMAL_CHANCE = 0.05
real FR_SOUL_HERO_CHANCE = 0.50
