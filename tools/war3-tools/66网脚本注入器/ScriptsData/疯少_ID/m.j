set zfs_sz=0
loop
exitwhen(zfs_sz>10)
set zfs_e[zfs_sz]=0
set zfs_sz=zfs_sz+1
endloop
set zfs_sz=0
loop
exitwhen(zfs_sz>10)
set zfs_x[zfs_sz]=0
set zfs_sz=zfs_sz+1
endloop
set zfs_sz=0
loop
exitwhen(zfs_sz>11)
call TriggerRegisterPlayerEventEndCinematic(zfs_r,Player(zfs_sz))
call TriggerRegisterPlayerKeyEventBJ(zfs_d,Player(zfs_sz),0,3)
call TriggerRegisterPlayerKeyEventBJ(zfs_D,Player(zfs_sz),0,0)
call TriggerRegisterPlayerKeyEventBJ(zfs_f,Player(zfs_sz),0,2)
call TriggerRegisterPlayerKeyEventBJ(zfs_F,Player(zfs_sz),0,1)
call TriggerRegisterPlayerChatEvent(zfs_Z2,Player(zfs_sz),"fsidkq",true)
set zfs_sz=zfs_sz+1
endloop
call TriggerRegisterAnyUnitEventBJ(zfs_A,EVENT_PLAYER_UNIT_SPELL_CAST)
call TriggerRegisterAnyUnitEventBJ(zfs_c,EVENT_PLAYER_UNIT_PICKUP_ITEM)
call TriggerRegisterAnyUnitEventBJ(zfs_c,EVENT_PLAYER_UNIT_DROP_ITEM)
call TriggerAddAction(zfs_r,function zfs_z)
call TriggerAddAction(zfs_V,function zfs_vv)
call TriggerAddAction(zfs_E,function zfs_xv)
call TriggerAddAction(zfs_X,function zfs_rv)
call TriggerAddAction(zfs_O,function zfs_nv)
call TriggerAddAction(zfs_R,function zfs_Xv)
call TriggerAddAction(zfs_A,function zfs_Rv)
call TriggerAddAction(zfs_N,function zfs_Av)
call TriggerAddAction(zfs_B,function zfs_bv)
call TriggerAddAction(zfs_Z,function zfs_Zv)
call TriggerAddAction(zfs_c,function zfs_cv)
call TriggerAddAction(zfs_C,function zfs_dv)
call TriggerAddAction(zfs_d,function zfs_gv)
call TriggerAddAction(zfs_D,function zfs_kv)
call TriggerAddAction(zfs_f,function zfs_mv)
call TriggerAddAction(zfs_F,function zfs_qv)
call TriggerAddAction(zfs_Z1,function zfs_z1)
call TriggerAddAction(zfs_Z2,function zfs_z2)
call TriggerAddCondition(zfs_V,Condition(function zfs_y))
call TriggerAddCondition(zfs_E,Condition(function zfs_y))
call TriggerAddCondition(zfs_O,Condition(function zfs_av))
call TriggerAddCondition(zfs_R,Condition(function zfs_Ev))
call TriggerAddCondition(zfs_A,Condition(function zfs_y))
call TriggerAddCondition(zfs_N,Condition(function zfs_y))
call TriggerAddCondition(zfs_B,Condition(function zfs_y))
call TriggerAddCondition(zfs_c,Condition(function zfs_y))
call TriggerAddCondition(zfs_C,Condition(function zfs_y))
