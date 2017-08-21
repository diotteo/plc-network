(*Section main
 *Description: Inits the trolley database on power up
 *Author: Olivier Diotte
 *Creation date: 2010/12/08
 *Last update: 2010/12/10
 *)
if (NOT b_onPowerOnWasInit) then
 powerOnInit();
 set(b_onPowerOnWasInit);
end_if;
