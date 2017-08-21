 (*Subsection paintPiece
 *Description: Paints and dries pieces if needed.
 *Author: Olivier Diotte
 *Creation date: 2010/12/09
 *Last update: 2010/12/10
 *)
 (*Don't paint*)
 if (
 (NOT b_isPieceDrilled) OR
 b_isPiecePainted OR
 (*If one of the following is true,
 *trolley infos are seriously broken, don't paint*)
 b_isTrolleyInMainLoop OR
 b_isTrolleyInDrillLoop OR
 (NOT b_isTrolleyInPaintLoop) OR
 b_isPaintLoopInEStop
 ) then
 unblockTrolley();
 cleanUp();
 (*Not painting, back to initStep*)
 reset(b_paintStep);
 reset(b_paintStepInit);
 set(b_initStep);
 (*Do paint*)
 else
 if (b_paintStep and b_paintStepInit) then
 set(b_paintSubStep);
 nbTimesPainted := 0;
 reset(b_paintStepInit);
 end_if;
 (*Manage different painting types*)
 case paintType of
 (*cases 0 and 1 are both handled here, but the case structure
 *allows for greater flexibility*)
 0..1:
 if (b_paintSubStep) then
 paintTimer(TRUE, PAINT_DELAY[paintType][nbTimesPainted+1], b_paintDone);
 set(o_b_paintPiece);
 (*Done painting*)
 if (b_paintDone) then
 reset(o_b_paintPiece);
 (*Done painting, start drying*)
 reset(b_paintSubStep);
 set(b_drySubStep);
 (*Reset timer instance*)
 paintTimer(IN:=FALSE);
 end_if;
 elsif (b_drySubStep) then
 dryTimer(TRUE, DRY_DELAY[paintType][nbTimesPainted+1], b_dryDone);
 set(b_dryPiece);
 (*Done drying*)
 if (b_dryDone) then
 reset(b_dryPiece);
 (*done drying, paint again*)
 reset(b_drySubStep);
 set(b_paintSubStep);
 (*Reset timer instance*)
 dryTimer(IN:=FALSE);
 nbTimesPainted:= nbTimesPainted + 1;
 (*Once we've done enough painting + drying cycles,
 *move on to next step*)
 if (nbTimesPainted >= PAINT_TYPE_MAX_CYCLE_NB[paintType]) then
 (*Set the "is painted" bit*)
 txData[1] := WORD_TO_INT(INT_TO_WORD(txData[1]) OR
 INT_TO_WORD(1 * WORD_TO_INT(MASK_IS_PAINTED)));
 reset(b_paintSubStep);
 reset(b_drySubStep);
 reset(b_paintStep);
 end_if;
 end_if; (*b_dryDone*)
 end_if; (*b_drySubStep*)
 end_case; (*paintType*)
 end_if; (*Do paint*)
