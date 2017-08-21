 (*Section GAU
 *Description: GAU section. Manages emergencies.
 *Author: Olivier Diotte
 *Creation date: 2010/12/09
 *Last update: 2010/12/10
 *)
 if (NOT b_onPowerOnWasInit) then
 powerOnInit();
 set(b_onPowerOnWasInit);
 elsif (i_b_emergencyStopButton) then
 reset(b_startGMMA);
 reset(o_b_paintPiece);
 blockTrolley();
 (*Code executed only once (re-executed only if
 *start button was pressed)*)
 if (NOT b_emergencyStopWasInit) then
 set(b_emergencyStopWasInit);
 reset(b_startWasInit);
 gauIterator:= 1;
 (*Reset getTrolleyInfos()' and updateTrolleyInfos()' internal vars
 *to a clean state*)
 reset(b_wait4reception);
 reset(b_updateSent);
 reset(b_receiveDone);
 reset(b_sendDone);
 end_if;
 (*Set the emergency exit bit on every trolley (on the master)*)
 if (gauIterator <= TROLLEY_MAX_INDEX) then
 curTrolley := gauIterator;
 if (NOT b_receiveDone) then
 getTrolleyInfos();
 elsif (b_receiveDone) then
 txData[1] := WORD_TO_INT(INT_TO_WORD(txData[1]) OR
 INT_TO_WORD(1 * WORD_TO_INT(MASK_ESTOP_PLC_PAINT)));
 updateTrolleyInfos();
 if (b_sendDone) then
 reset(b_receiveDone);
 reset(b_sendDone);
 reset(b_wait4reception);
 reset(b_updateSent);
 gauIterator:= gauIterator + 1;
 end_if;
 end_if;
 end_if;
 elsif (i_b_startButton) then
 reset(b_stopOPStep);
 (*Code executed only once (re-executed only if
 *emergency button was pressed)*)
 if (NOT b_startWasInit) then
 reset(b_emergencyStopWasInit);
 set(b_startWasInit);
 unblockTrolley();
 gauIterator:= 1;
 (*Reset getTrolleyInfos()' and updateTrolleyInfos()' internal vars
 *to a clean state*)
 reset(b_wait4reception);
 reset(b_updateSent);
 reset(b_receiveDone);
 reset(b_sendDone);
 end_if;
 (*Reset the emergency exit bit on every trolley (on the master)*)
 if (gauIterator <= TROLLEY_MAX_INDEX) then
 curTrolley := gauIterator;
 if (NOT b_receiveDone) then
 getTrolleyInfos();
 elsif (b_receiveDone) then
 txData[1] := WORD_TO_INT(INT_TO_WORD(txData[1]) AND
 (NOT MASK_ESTOP_PLC_PAINT));
 updateTrolleyInfos();

 if (b_sendDone) then
 reset(b_receiveDone);
 reset(b_sendDone);
 gauIterator:= gauIterator + 1;
 end_if;
 end_if;
 (*All trolleys' emergency stop bit are reset, it is now safe to
 *allow GMMA to run*)
 else
 set(b_startGMMA);
 end_if;
 end_if;
