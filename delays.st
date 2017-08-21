 (*S_3_3 = GMMA auto mode normal operation
 *S_5_2 = GAU auto mode normal operation*)
 if S_3_3.x and S_5_2.x then
 if S_1_2.x or S_1_3.x or S_1_4.x or S_1_17.x or S_1_22.x then
 openClawDelay(true, T#2s, clawOpened);
 elsif clawOpened then
 openClawDelay(false, T#0s, clawOpened);
 end_if;
 if S_2_1.x then
 fanDelay(true, prePaintFanDelayTime, fanDone);
 elsif S_2_5.x then
 fanDelay(true, coolPieceDelayTime, fanDone);
 elsif fanDone then
 fanDelay(false, T#0s, fanDone);
 end_if;
 if S_2_2.x then
 dryDelay(true, dryPieceDelayTime, dryDone);
 elsif dryDone then
 dryDelay(false, T#0s, dryDone);
 end_if;
 if S_2_3.x then
 paintDelay(true, paintPieceDelayTime, paintDone);
 elsif paintDone then
 paintDelay(false, T#0s, paintDone);
 end_if;
 if S_2_4.x then
 bakeDelay(true, bakePieceDelayTime, bakeDone);
 elsif bakeDone then
 bakeDelay(false, T#0s, bakeDone);
 end_if;
 end_if;
