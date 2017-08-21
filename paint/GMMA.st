(*Section GMMA
 *Description: GMMA section. Manages OP's run/stop mode.
 *Author: Olivier Diotte
 *Creation date: 2010/12/09
 *Last update: 2010/12/09
 *)
(*If GAU says we must not run, also stop OP*)
if (NOT b_startGMMA) then
 set(b_GmmaOpInit);
 reset(b_startOP);
(*If an operator wants to stop the machine, wait until
 *current cycle is done, then stop OP*)
elsif (i_b_stopButton or b_stopOPStep) then
 if (NOT b_stopOPStep) then
 set(b_stopOPStep);
 end_if;
 if (b_initStep) then
 reset(b_startOP);
 reset(b_stopOPStep);
 reset(b_startGMMA);
 end_if;
(*Otherwise, let OP run as normal*)
elsif (b_startGMMA) then
 if (b_GmmaOpInit) then
 curTrolley := 0;
 set(b_initStep);
 reset(b_GmmaOpInit);
 end_if;
 set(b_startOP);
end_if;
