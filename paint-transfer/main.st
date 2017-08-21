 (*Section main
 *Description: Main section. Transfers trolleys from the main loop into
 * the paint loop and vice-versa.
 *Author: Olivier Diotte
 *Creation date: 2010/12/08
 *Last update: 2010/12/10
 *)
 if (NOT b_onPowerOnWasInit) then
 powerOnInit();
 set(b_onPowerOnWasInit);
 set(b_initStep);
 (*If startButton is off, do nothing.*)
 elsif (NOT i_b_startButton) then
 ;
 elsif (curTrolley = 0) then
 (*Wait until curTrolley is set*)
 ;
 else
 if (b_trolleyInLoop) then
 curLS := TROLLEY_OUT;
 else
 curLS := TROLLEY_IN;
 end_if;
 (*Init vars, reset timers, etc.*)
 if (b_initStep) then
 (*Do nothing unless limitSwitch[curLS] is set*)
 if (i_limitSwitch[curLS]) then
 resetTimers();
 blockTrolley();
 (*We're done, next step*)
 reset(b_initStep);
 set(b_receiveStep);
 end_if;
 (*fetch infos on the current trolley from the master*)
 elsif (b_receiveStep) then
 blockTrolley();
 getTrolleyInfos();
 (*Once done, move on to the next step*)
 if (b_receiveDone) then
 reset(b_receiveDone);
 reset(b_receiveStep);
 set(b_transferStep);
 end_if;
 (*Wait for limit switch to go off*)
 elsif (b_transferStep and i_limitSwitch[curLS]) then
 blockTrolley();
 (*Subsections only need to reset b_workingStep to move on.
 *Reset b_workingStep and set b_initStep to stop processing*)
 elsif (b_transferStep) then
 blockTrolley();
 if (curLS = TROLLEY_OUT) then
 transferOut();
 elsif (curLS = TROLLEY_IN) then
 transferIn();
 end_if;
 (*Done, move on, unless we are aborting*)
 if (NOT b_transferStep and NOT b_initStep) then
 set(b_sendStep);
 end_if;
 (*Once transfer is done, tell the master*)
 elsif (b_sendStep) then
 updateTrolleyInfos();
 (*Once done sending, clean up*)
 if (b_sendDone) then
 reset(b_sendDone);
 reset(b_sendStep);
 cleanUp();
 set(b_initStep);
 end_if;
 end_if; (*b_sendStep*)
 end_if; (*b_start*)
