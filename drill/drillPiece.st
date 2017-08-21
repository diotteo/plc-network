 (*Subsection drillPiece
 *Description: Drills pieces if needed.
 *Author: Olivier Diotte
 *Creation date: 2010/12/09
 *Last update: 2010/12/10
 *)
 (*Don't drill*)
 if (
 b_isPieceDrilled OR
 b_isPiecePainted OR
 (*If one the following is true, trolley infos
 *are seriously broken, don't drill*)
 b_isTrolleyInMainLoop OR
 b_isTrolleyInPaintLoop OR
 (NOT b_isTrolleyInDrillLoop)
 ) then
 unblockTrolley();
 cleanUp();
 (*Not drilling, back to initStep*)
 reset(b_drillStep);
 reset(b_drillStepInit);
 set(b_initStep);
 (*Do drill*)
 else
 if (b_drillStep and b_drillStepInit) then
 nbTimesDrilled := 0;
 reset(b_drillStepInit);
 end_if;
 (*Manage different drilling types*)
 case drillType of
 (*cases 0 and 1 are both handled here, but the case structure
 *allows for greater flexibility*)
 0..1:
 drillTimer(TRUE, DRILL_DELAY[drillType][nbTimesDrilled+1], b_drillDone);
 set(o_b_drillPiece);
 (*Done drilling*)
 if (b_drillDone) then
 reset(o_b_drillPiece);
 (*Reset timer instance*)
 drillTimer(IN:=FALSE);
 nbTimesDrilled:= nbTimesDrilled + 1;
 (*Once we've done enough drilling cycles,
 *move on to next step*)
 if (nbTimesDrilled >= DRILL_TYPE_MAX_CYCLE_NB[drillType]) then
 (*Set the "is drilled" bit*)
 txData[1] := WORD_TO_INT(INT_TO_WORD(txData[1]) OR
 INT_TO_WORD(1 * WORD_TO_INT(MASK_IS_DRILLED)));
 reset(b_drillStep);
 end_if;
 end_if; (*b_drillDone*)
 end_case; (*drillType*)
 end_if; (*Do drill*)
