(*Subsection powerOnInit
*Description: Inits things on power on.
*Author: Olivier Diotte
*Creation date: 2010/12/08
*Last update: 2010/12/09
*)
a_address[PLC_MASTER]         := addm('Eth1{84.3.178.102}');
a_address[PLC_DRILL]          := addm('Eth1{84.3.177.128}');
a_address[PLC_DRILL_TRANSFER] := addm('Eth1{84.3.176.247}');
a_address[PLC_PAINT]          := addm('Eth1{84.3.168.43}');
a_address[PLC_PAINT_TRANSFER] := addm('Eth1{84.3.168.60}');
