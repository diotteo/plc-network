(*Section main
 *Description: Main section. Paints pieces on trolleys.
 *Author: Olivier Diotte
 *Creation date: 2010/12/08
 *Last update: 2010/12/09
 *)
(*If GMMA says we must not run, do nothing*)
if (NOT b_startOP) then
 ;
elsif (curTrolley = 0) then
 (*curTrolley must be set to the index of the %MW of the trolley *to work on.
 *Wait here until that is done*)
 ;
else
 if (b_initStep) then
 (*Do nothing unless limitSwitch is set*)
 if (i_limitSwitch) then
 resetTimers();
 blockTrolley();
 (*Move on to the next step*)
 reset(b_initStep);
 set(b_receiveStep);
 end_if;
 elsif (b_receiveStep) then
 blockTrolley();
 getTrolleyInfos();
 (*Once done, move on*)
 if (b_receiveDone) then
 reset(b_receiveStep);
 reset(b_receiveDone);
 set(b_paintStep);
 set(b_paintStepInit);
 end_if;
 (*Wait for limit switch to go off*)
 elsif (b_paintStep and i_limitSwitch) then
 blockTrolley();
 (*Subsections only need to reset b_workingStep to move on.
 *Reset b_workingStep and set b_initStep to stop processing*)
 elsif (b_paintStep) then
 blockTrolley();
 paintPiece();
 (*Done, move on, unless we are aborting*)
 if (NOT b_paintStep and NOT b_initStep) then
 nbPiecesPainted := nbPiecesPainted + 1;
 set(b_sendStep);
 end_if;
 (*Once done painting, tell the master*)
 elsif (b_sendStep) then
 updateTrolleyInfos();
 (*Once done sending, clean up*)
 if (b_sendDone) then
 reset(b_sendStep);
 reset(b_sendDone);
 cleanUp();
 set(b_initStep);
 end_if;
 end_if; (*b_sendStep*)
end_if; (*b_start*)
