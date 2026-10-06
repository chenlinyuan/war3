function Trig_sssdda_Conditions takes nothing returns boolean
return(GetIssuedOrderId()==String2OrderIdBJ("PATROL"))
endfunction
function Trig_sssdda_Actions takes nothing returns nothing
call SetUnitPositionLoc(GetOrderedUnit(),GetOrderPointLoc())
endfunction