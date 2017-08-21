 (*
 *button_mapping
 *Description: Cette section fait la correspondance entre
 * l'interface homme-machine et l'automate: principalement
 * des entrées (boutons).
 *)
 b_emergencyStop := i_emergencyStopBtnOn or m_b_emergencyStop;
 b_abandonStop := i_abandonBtnOn or m_b_abandonStop;
 if (i_startBtnOn) then
 m_b_start := true;
 end_if;
 b_start := i_startBtnOn or m_b_start;
 (*modeManual AND modeAuto*)
 b_modeManual := m_b_modeManual;
 b_modeAuto := NOT b_modeManual;
 (*ironRecipe AND aluminiumRecipe*)
 b_ironRecipe := m_b_ironRecipe;
 b_aluminiumRecipe := NOT b_ironRecipe;
 (*Inputs for the UI to read*)
 (*b_ovenDoorClosed := i_ovenDoorClosed;*)
 m_i_b_ovenDoorClosed := b_ovenDoorClosed;
 (*b_ovenDoorOpened := i_ovenDoorOpened;*)
 m_i_b_ovenDoorOpened := b_ovenDoorOpened;
 (*b_objectOnConveyor := i_objectOnConveyor;*)
 m_i_b_objectOnConveyor := b_objectOnConveyor;
 (*b_objectInOven := i_objectInOven;*)
 m_i_b_objectInOven := b_objectInOven;
 (*b_objectInClaw := i_objectInClaw;*)
 m_i_b_objectInClaw := b_objectInClaw;
 (*b_ls3 := i_ls3_On;*)
 m_i_b_ls3 := b_ls3;
 (*b_ls2 := i_ls2_On;*)
 m_i_b_ls2 := b_ls2;
 (*b_ls1 := i_ls1_On;*)
 m_i_b_ls1 := b_ls1;
 (*b_clawLowered := i_clawLowered;*)
 m_i_b_clawLowered := b_clawLowered;
 (*b_clawRaised := i_clawRaised;*)
 m_i_b_clawRaised := b_clawRaised;
 (*Outputs for the UI to read*)
 m_s_applyPaint := applyPaint;
 m_s_applyStainlessPaint := applyStainlessPaint;
 m_s_applyPreprocessingPaint := applyPreprocessingPaint;
 m_s_startFan := startOvenFan;
 m_s_startConveyor := startConveyor;
 m_s_raiseClaw := raiseClaw;
 m_s_lowerClaw := lowerClaw;
 m_s_openClaw := openClaw;
 m_s_openOvenDoor := openOvenDoor;
 m_s_closeOvenDoor := closeOvenDoor;
 m_s_bake := bakePiece;
 m_s_mvTrolleyR := mvTrolleyR;
 m_s_mvTrolleyL := mvTrolleyL;
 (*Delays for the recipes*)
 if (0 >= m_fanDelay1) then
 m_fanDelay1 := INT_TO_WORD(TIME_TO_INT(FAN_DELAY1_DEFAULT) / 1000);
 else
 fanDelay1 := INT_TO_TIME(1000 * WORD_TO_INT(m_fanDelay1));
 end_if;
 if (0 >= m_dryDelay) then
 m_dryDelay := INT_TO_WORD(TIME_TO_INT(DRY_DELAY_DEFAULT) / 1000);
 else
 dryDelay := INT_TO_TIME(1000 * WORD_TO_INT(m_dryDelay));
 end_if;
 if (0 >= m_paintDelay) then
 m_paintDelay := INT_TO_WORD(TIME_TO_INT(PAINT_DELAY_DEFAULT) / 1000);
 else
 paintDelay := INT_TO_TIME(1000 * WORD_TO_INT(m_paintDelay));
 end_if;
 if (0 >= m_bakeDelay) then
 m_bakeDelay := INT_TO_WORD(TIME_TO_INT(BAKE_DELAY_DEFAULT) / 1000);
 else
 bakeDelay := INT_TO_TIME(1000 * WORD_TO_INT(m_bakeDelay));
 end_if;
 if (0 >= m_fanDelay2) then
 m_fanDelay2 := INT_TO_WORD(TIME_TO_INT(FAN_DELAY2_DEFAULT) / 1000);
 else
 fanDelay2 := INT_TO_TIME(1000 * WORD_TO_INT(m_fanDelay2));
 end_if;
