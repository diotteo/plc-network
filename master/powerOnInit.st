(*Subsection powerOnInit
 *Description: Inits the trolley database on power up
 *Author: Olivier Diotte
 *Creation date: 2010/12/08
 *Last update: 2010/12/09
 *)
a_address[PLC_MASTER]         := addm('Eth1{84.3.178.102}');
a_address[PLC_DRILL]          := addm('Eth1{84.3.177.128}');
a_address[PLC_DRILL_TRANSFER] := addm('Eth1{84.3.176.247}');
a_address[PLC_PAINT]          := addm('Eth1{84.3.168.43}');
a_address[PLC_PAINT_TRANSFER] := addm('Eth1{84.3.168.60}');
(*Boucle initialisant les 255 automates adressables*)
for i:=1 to 255 do
 if (B_DEBUG_TEST) then
 a_trolleyData[i]:=
 INT_TO_WORD(256 * WORD_TO_INT(INT_TO_WORD(i) & MASK_TROLLEY_INDEX))
 OR
 INT_TO_WORD(i) & MASK_TROLLEY_INDEX;
 else
 a_trolleyData[i]:=
 (*La structure est la suivante:
 *INT_TO_WORD(A * WORD_TO_INT(B))
 * ou:
 * A est la valeur booleenne a appliquer au parametre
 * B est le masque utilise pour "placer" le
 * parametre dans le WORD
 * Exemple: INT_TO_WORD(1 * WORD_TO_INT(8))
 * place la valeur 1 dans le 4e bit en partant de la
 * droite (LSB). 4e bit = 2#1000 = 8 en base 10.*)
 (*Is PLC_PAINT in emergency exit(AU) state?*)
 (
 (a_trolleyData[i] & MASK_ESTOP_PLC_PAINT)
 OR
 INT_TO_WORD(0 * WORD_TO_INT(MASK_ESTOP_PLC_PAINT))
 )
 OR
 (*Is PLC_DRILL in emergency exit(AU) state?*)
 (
 (a_trolleyData[i] & MASK_ESTOP_PLC_DRILL)
 OR
 INT_TO_WORD(0 * WORD_TO_INT(MASK_ESTOP_PLC_DRILL))
 )
 OR
 (*Type of drilling to do*)
 (
 (a_trolleyData[i] & MASK_DRILL_PAINT_TYPE)
 OR
 INT_TO_WORD(0 * WORD_TO_INT(MASK_DRILL_PAINT_TYPE))
 )
 OR
 (*Is trolley in the main loop?*)
 (
 (a_trolleyData[i] & MASK_MAIN_LOOP)
 OR
 INT_TO_WORD(1 * WORD_TO_INT(MASK_MAIN_LOOP))
 )
 OR
 (*Is trolley in the paint loop?*)
 (
 (a_trolleyData[i] & MASK_PAINT_LOOP)
 OR
 INT_TO_WORD(0 * WORD_TO_INT(MASK_PAINT_LOOP))
 )
 OR
 (*Is trolley in the drill loop?*)
 (
 (a_trolleyData[i] & MASK_DRILL_LOOP)
 OR
 INT_TO_WORD(0 * WORD_TO_INT(MASK_DRILL_LOOP))
 )
 OR
 (*Is trolley painted?*)
 (
 (a_trolleyData[i] & MASK_IS_PAINTED)
 OR
 INT_TO_WORD(0 * WORD_TO_INT(MASK_IS_PAINTED))
 )
 OR
 (*Is trolley drilled?*)
 (
 (a_trolleyData[i] & MASK_IS_DRILLED)
 OR
 INT_TO_WORD(0 * WORD_TO_INT(MASK_IS_DRILLED))
 )
 OR
 (*Index of the trolley*)
 INT_TO_WORD(i) & MASK_TROLLEY_INDEX;
 end_if; (*NOT B_DEBUG_TEST*)
end_for;
