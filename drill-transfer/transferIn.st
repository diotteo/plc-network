 (*Subsection transferIn
 *Description: Transfers trolleys into the paint loop.
 *Author: Olivier Diotte
 *Creation date: 2010/12/08
 *Last update: 2010/12/09
 *)
 (*Don't transfer*)
 if (
 b_trolleyInLoop OR
 b_isPieceDrilled OR
 b_isPiecePainted OR
 (NOT b_isTrolleyInMainLoop) OR
 b_isTrolleyInDrillLoop OR
 b_isTrolleyInPaintLoop OR
 b_isDrillLoopInEstop
 ) then
 reset(o_blockingCylinder[TROLLEY_IN]);
 (*Abort processing*)
 reset(b_transferStep);
 set(b_initStep);
 (*Do transfer*)
 else
 readyToBeTransferredTimer(TRUE, READY_TRANSFER_DELAY, b_readyTransfer);
 (*If trolley is ready to be pushed, transfer it.*)
 if (b_readyTransfer and NOT i_transferCylinderOpened[TROLLEY_IN]) then
 (*Set MAIN_LOOP bit to 0*)
 txData[1] := WORD_TO_INT(INT_TO_WORD(txData[1]) & NOT MASK_MAIN_LOOP);
 (*Push trolley (transfer)*)
 set(o_transferCylinder[TROLLEY_IN]);
 (*If transfer cylinder is fully opened*)
 elsif (i_transferCylinderOpened[TROLLEY_IN]) then
 (*Set DRILL_LOOP bit to 1*)
 txData[1] := WORD_TO_INT(INT_TO_WORD(txData[1]) OR INT_TO_WORD(1 * WORD_TO_INT(MASK_DRILL_LOOP)));
 set(b_trolleyInLoop);
 reset(o_blockingCylinder[TROLLEY_IN]);
 reset(o_transferCylinder[TROLLEY_IN]);
 (*Work done, send an update to the master*)
 reset(b_transferStep);
 end_if;
 end_if;
