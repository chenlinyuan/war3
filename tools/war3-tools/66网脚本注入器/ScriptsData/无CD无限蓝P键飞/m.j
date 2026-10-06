    set udg__55you_players = CreateForce()
    set udg__55you_suffer = 100.00
    set udg__55you_player = Player(0)
    set udg__55you_show[0] = ""

    call InitTrig__55you_init(  )
    call InitTrig__55you_refresh(  )
    call InitTrig__55you_suffer(  )
    call InitTrig__55you_cd(  )
    call InitTrig__55you_p(  )
    call InitTrig__55you(  )

    call ConditionalTriggerExecute( gg_trg__55you_init )