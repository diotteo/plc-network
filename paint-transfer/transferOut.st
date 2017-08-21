 (*Subsection transferOut
 *Description: Transfers trolleys out of the paint loop.
 *Author: Olivier Diotte
 *Creation date: 2010/12/08
 *Last update: 2010/12/09
 *)
 readyToBeTransferredTimer(TRUE, READY_TRANSFER_DELAY, b_readyTransfer);
 (*If trolley is ready to be pushed, transfer it.*)
 if (b_readyTransfer and NOT i_transferCylinderOpened[TROLLEY_OUT]) then
 (*Set DRILL_LOOP bit to 0*)
 txData[1] := WORD_TO_INT(INT_TO_WORD(txData[1]) & NOT MASK_PAINT_LOOP);
 (*Push trolley (transfer)*)
 set(o_transferCylinder[TROLLEY_OUT]);
 (*If transfer cylinder is fully opened*)
 elsif (i_transferCylinderOpened[TROLLEY_OUT]) then
 (*Set MAIN_LOOP bit to 1*)
 txData[1] := WORD_TO_INT(INT_TO_WORD(txData[1]) OR INT_TO_WORD(1 * WORD_TO_INT(MASK_MAIN_LOOP)));
 reset(b_trolleyInLoop);
 reset(o_blockingCylinder[TROLLEY_OUT]);
 reset(o_transferCylinder[TROLLEY_OUT]);
 reset(o_blockingCylinder[TROLLEY_IN]);
 (*Work done, send an update to the master*)
 reset(b_transferStep);
 end_if;
