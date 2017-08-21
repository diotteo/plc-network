 (*S_3_3 = GMMA auto mode normal operation step*)
 if S_3_3.x and S_3_2.x then
 abandonStep := 0;
 elsif Abandon_OUT.x then
 o_init := INITCHART(OperationalPart, false);
 o_freeze := FREEZECHART(OperationalPart, false);
 abandonStep := 0;
 elsif Abandon.x then
 if Abandon_IN.x then
 o_freeze := FREEZECHART(OperationalPart, true);
 openClawDelay(false, T#0s, clawOpened);
 fanDelay(false, T#0s, fanDone);
 abandonStep := 0;
 reset(abandonDone);
 if S_1_1.x or S_1_6.x then
 (*It is safe to resume from here*)
 set(abandonDone);
 elsif S_1_4.x or S_1_5.x then
 (*move LS1*)
 abandonStep := 1;
 elsif S_1_9.x then
 (*raise + open claw, abandonStep := 1*)
 abandonStep := 2;
 elsif S_1_2.x or S_1_3.x or S_1_10.x or S_1_28.x then
 (*fully open claw, abandonStep := 2*)
 abandonStep := 3;
 elsif S_1_27.x then
 (*lower claw, abandonStep := 3*)
 abandonStep := 4;
 elsif S_1_11.x then
 (*raise claw, move LS3 (right), abandonStep := 4*)
 abandonStep := 5;
 elsif S_1_12.x then
 (*move LS1, abandonStep := 5*)
 abandonStep := 6;
 elsif S_1_13.x or S_1_26.x then
 (*move LS3(left), abandonStep := 4*)
 abandonStep := 7;
 elsif S_1_16.x or S_1_25.x then
 (*raise claw, abandonStep := 7*)
 abandonStep := 8;
 elsif S_1_17.x or S_1_24.x then
 (*close claw, abandonStep := 8*)
 abandonStep := 9;
 elsif S_1_18.x or S_1_23.x then
 (*lower and open claw, abandonStep := 9*)
 abandonStep := 10;
 elsif S_1_22.x then
 (*open claw, abandonStep := 10*)
 abandonStep := 11;
 elsif S_1_19.x or S_1_21.x then
 (*open oven, abandonStep := 11*)
 abandonStep := 12;
 elsif Recipe.x then
 (*fan for 1 min, abandonStep := 12*)
 abandonStep := 13;
 elsif S_1_7.x or S_1_8.x or S_1_15.x or S_1_30.x then
 (*These steps have no associated action, but further action
 *needs to be taken since other steps are active at the same time*)
 ;
 else
 (*No step can be left unhandled*)
 halt();
 end_if;
(*This must be dealt with separately for they are executed in parallel
*with other steps*)
if S_1_14.x or S_1_29.x then
(*close oven door*)
abandonStep := abandonStep + 100;
end_if;
else
o_init := INITCHART(OperationalPart, true);
(*If oven door must be closed*)
if abandonStep > 100 then
set(closeOvenDoor);
if ovenDoorClosed then
abandonStep := abandonStep - 100;
reset(closeOvenDoor);
end_if;
else
case abandonStep of
1:
if not ls1_On then
set(mvTrolleyL);
else
reset(mvTrolleyL);
set(abandonDone);
end_if;
2:
if not clawRaised then
set(raiseClaw);
set(openClaw);
else
reset(raiseClaw);
reset(openClaw);
abandonStep := 1;
end_if;
3:
if not clawOpened then
openClawDelay(true, T#2s, clawOpened);
set(openClaw);
else
openClawDelay(false, T#0s, clawOpened);
(*abandonStep := 2 also opens the claw, but
*we're resetting for the sake of safety (shall we change the
*execution flow)*)
reset(openClaw);
abandonStep := 2;
end_if;
4:
lowerClaw := not clawLowered;
if clawLowered then
abandonStep := 3;
end_if;
5:
if not clawRaised then
set(raiseClaw);
elsif not ls3_On then
reset(raiseClaw);
set(mvTrolleyR);
else
reset(mvTrolleyR);
abandonStep := 4;
end_if;
6:
mvTrolleyL := not ls1_On;
if ls1_On then
abandonStep := 5;
end_if;
7:
mvTrolleyL := not ls3_On;
if ls3_On then
abandonStep := 4;
end_if;
8:
raiseClaw := not clawRaised;
if clawRaised then
abandonStep := 7;
end_if;
9:
if not objectInClaw then
(*Wait for the claw to close*)
;
else
abandonStep := 8;
end_if;
10:
lowerClaw := not clawLowered;
openClaw := not clawLowered;
if clawLowered then
abandonStep := 9;
end_if;
11:
(*activate openClawDelay as long as clawOpened is false
*(openClawDelay still counting) and openClaw as long as
*clawOpened is false*)
openClawDelay(not clawOpened, T#2s, clawOpened);
openClaw := not clawOpened;
if clawOpened then
abandonStep := 10;
end_if;
12:
openOvenDoor := not ovenDoorOpened;
if ovenDoorOpened then
abandonStep := 11;
end_if;
13:
(*activate fanDelay as long as fanDone is false (fanDelay not done)
*and startOvenFan as long as fanDone is false*)
fanDelay(not fanDone, T#2s, fanDone);
startOvenFan := not fanDone;
abandonStep := 12;
else
if not abandonDone then
(*Should never happen*)
halt();
end_if;
end_case;
end_if;
end_if;
end_if;
