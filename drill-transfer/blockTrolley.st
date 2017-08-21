(*Subsection blockTrolley
 *Description: Maintains blocking cylinders set for an incoming transfer.
 *Author: Olivier Diotte
 *Creation date: 2010/12/08
 *Last update: 2010/12/09
 *)
if (curLS = TROLLEY_OUT) then
set(o_blockingCylinder[TROLLEY_OUT]);
(*Engage the blocking "IN" cylinder to prevent collisions
*while transferring out*)
set(o_blockingCylinder[TROLLEY_IN]);
elsif (curLS = TROLLEY_IN) then
set(o_blockingCylinder[TROLLEY_IN]);
end_if;
