(*Subsection updateTrolleyInfos
*Description: Pushes infos on a given trolley into the database (PLC_MASTER).
*Author: Olivier Diotte
*Creation date: 2010/12/08
*Last update: 2010/12/09
*)
if (NOT b_updateSent) then
(*Set a timeout of 5 seconds*)
txMgmt[3]:= 50;
write_var(a_address[PLC_MASTER], '%MW', curTrolley, 1, txData, txMgmt);
set(b_updateSent);
else
(*txMgmt activity bit will 1->0 (falling edge) when write_var is done.
*When such a thing happens, b_txActDone will be set.*)
commTrigger(CLK:=(0 <> (INT_TO_WORD(txMgmt[1]) & MASK_COMM_ACT_BIT)),
FALL=>b_txActDone);
(*If write_var is done*)
if (b_txActDone) then
(*If communication (write_var) failed, try again*)
if (NOT (COMM_REPORT_SUCCESS =
(INT_TO_WORD(txMgmt[2]) & MASK_COMM_REPORT))) then
reset(b_updateSent);
(*If communication was successful*)
else
(*Step done*)
set(b_sendDone);
reset(b_updateSent);
end_if; (*COMM_REPORT_SUCCESS*)
end_if; (*b_recvActDone*)
end_if;
