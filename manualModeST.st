 (*S_3_5 = GMMA manual mode step*)
 if S_3_5.x then
 startConveyor := s_startConveyor;
 mvTrolleyL := s_mvTrolleyL;
 mvTrolleyR := s_mvTrolleyR;
 raiseClaw := s_raiseClaw;
 lowerClaw := s_lowerClaw;
 openClaw := s_openClaw;
 openOvenDoor := s_openOvenDoor;
 closeOvenDoor := s_closeOvenDoor;
 s_bake := bakePiece;
 startOvenFan := s_startFan;
 applyPaint := s_applyPaint;
 applyPreprocessingPaint := s_applyPreprocessingPaint;
 applyStainlessPaint := s_applyStainlessPaint;
 end_if;
