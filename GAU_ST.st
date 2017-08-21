 if S_5_4.x then
 reset(emergencyDone);
 openClawDelay(false, T#0s, clawOpened);
 fanDelay(false, T#0s, fanDone);
 o_init := INITCHART(GMMA, true);
 o_init := INITCHART(OperationalPart, true);
 o_freeze := FREEZECHART(GMMA, false);
 o_freeze := FREEZECHART(OperationalPart, false);
 o_init := INITCHART(GMMA, false);
 o_init := INITCHART(OperationalPart, false);
 end_if;
 if S_5_3.x then
 o_freeze := FREEZECHART(GMMA, true);
 o_freeze := FREEZECHART(OperationalPart, true);
 (*raise and open claw*)
 if abandonStep = 2 or abandonStep = 10 or (abandonStep = 0 and
 (S_1_3.x or S_1_4.x or S_1_9.x or S_1_10.x or S_1_17.x or S_1_22.x
 or S_1_23.x or S_1_24.x)) then
 raiseClaw := not clawRaised;
 openClaw := not clawRaised;
 if clawRaised then
 (*It is safe to restart normal operation by now*)
 set(emergencyDone);
 end_if;
 (*raise claw*)
 elsif abandonStep = 4 or abandonStep = 5 or abandonStep = 8 or
 (abandonStep = 0 and (S_1_11.x or S_1_16.x or S_1_18.x or S_1_25.x
 or S_1_27.x)) then
 raiseClaw := not clawRaised;
 if clawRaised then
 (*It is safe to restart normal operation by now*)
 set(emergencyDone);
 end_if;
 (*Activate fan for 1 min*)
 elsif abandonStep = 13 or (abandonStep = 0 and Recipe.x) then
 if S_5_3.x then
 fanDelay(true, T#1m, fanDone);
 startOvenFan := fanDone;
 (*It is safe to restart normal operation once the oven fan is done*)
 emergencyDone := fanDone;
 end_if;
 (*open claw until fully opened, then raise claw*)
 elsif abandonStep = 3 or abandonStep = 9 or
 (abandonStep = 0 and S_1_28.x) then
 openClawDelay(TRUE, T#60s, clawOpened);
 set(openClaw);
 if clawOpened then
 raiseClaw := not clawRaised;
 end_if;
 if clawOpened and clawRaised then
 reset(raiseClaw);
 reset(openClaw);
 (*It is safe to restart normal operation once the claw
 *is fully raised and opened*)
 set(emergencyDone);
 end_if;
 else
 set(emergencyDone);
 end_if;
 end_if;
