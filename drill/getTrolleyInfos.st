(*Subsection getTrolleyInfos
*Description: Gets infos on a given trolley from the database (PLC_MASTER).
*Author: Olivier Diotte
*Creation date: 2010/12/08
*Last update: 2010/12/10
*)
if (NOT b_wait4reception) then
(*Set a timeout of 5 seconds*)
rcvMgmt[3]:= 50;
read_var(a_address[PLC_MASTER], '%MW', curTrolley, 1, rcvMgmt, rcvData);
set(b_wait4reception);
else
(*rcvMgmt activity bit will 1->0 (falling edge) when read_var is done.
*When such a thing happens, b_recvActDone will be set.*)
commTrigger(CLK:=(0 <> (INT_TO_WORD(rcvMgmt[1]) & MASK_COMM_ACT_BIT)),
FALL=>b_recvActDone);
(*If read_var is done*)
if (b_recvActDone) then
(*If communication (read_var) failed, try again*)
if (NOT (COMM_REPORT_SUCCESS =
(INT_TO_WORD(rcvMgmt[2]) & MASK_COMM_REPORT))) then
reset(b_wait4reception);
(*If communication was successful*)
else
(*txData holds "current" data*)
txData := rcvData;
b_isPaintLoopInEstop := 0 <> (INT_TO_WORD(rcvData[1]) & MASK_ESTOP_PLC_PAINT);
b_isDrillLoopInEstop := 0 <> (INT_TO_WORD(rcvData[1]) & MASK_ESTOP_PLC_DRILL);
drillType := BOOL_TO_INT(0 <> (INT_TO_WORD(rcvData[1]) & MASK_DRILL_PAINT_TYPE));
b_isTrolleyInMainLoop := 0 <> (INT_TO_WORD(rcvData[1]) & MASK_MAIN_LOOP);
b_isTrolleyInPaintLoop := 0 <> (INT_TO_WORD(rcvData[1]) & MASK_PAINT_LOOP);
b_isTrolleyInDrillLoop := 0 <> (INT_TO_WORD(rcvData[1]) & MASK_DRILL_LOOP);
b_isPiecePainted := 0 <> (INT_TO_WORD(rcvData[1]) & MASK_IS_PAINTED);
b_isPieceDrilled := 0 <> (INT_TO_WORD(rcvData[1]) & MASK_IS_DRILLED);
trolleyIndex := WORD_TO_DINT(INT_TO_WORD(rcvData[1]) & MASK_TROLLEY_INDEX);
(*Step done, move on*)
set(b_receiveDone);
reset(b_wait4reception);
end_if; (*COMM_REPORT_SUCCESS*)
end_if; (*b_recvActDone*)
end_if; (*b_receiveDone*)
