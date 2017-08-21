 (*
 *Encoders
 *Description: Cette section simule tous les encodeurs et
 * autres mécanismes qui permettraient de connaître l'état de
 * la machine afin de faire fonctionner l'interface homme-machine
 *)
 (*Cette partie simule la partie relative au convoyeur*)
 if (startConveyor) then
 conveyorPosTimer(TRUE, CONVEYOR_POS_TICK, b_conveyorMoved);
 if (b_conveyorMoved) then
 conveyorPosTimer(FALSE, T#0s, b_conveyorMoved);
 if (m_conveyorPos < 100) then
 m_conveyorPos := m_conveyorPos + 1;
 if (m_conveyorPos = 100) then
 set(b_objectOnConveyor);
 reset(m_b_objectDoneOnConveyor);
 end_if;
 end_if;
 end_if;
 end_if;
 (*Cette partie simule la partie relative à la hauteur du bras de la pince*)
 if (raiseClaw or lowerClaw) then
 clawHeightTimer(TRUE, CLAW_HEIGHT_TICK, b_clawArmMoved);
 if (b_clawArmMoved) then
 clawHeightTimer(FALSE, T#0s, b_clawArmMoved);
 reset(b_clawRaised);
 if (b_clawLowered) then
 set(b_clawWasLowered);
 reset(b_clawLowered);
 end_if;
 if (raiseClaw) then
 if (m_clawHeight = 100) then
 set(b_clawRaised);
 else
 m_clawHeight := m_clawHeight + 1;
 end_if;
 if (b_ls2 AND m_clawOpening = MAX_CLAW_CLOSE_WITH_OBJECT AND
 b_clawWasLowered AND b_objectInOven) then
 reset(b_objectInOven);
 reset(b_clawWasLowered);
 end_if;
 elsif (lowerClaw) then
 if (m_clawHeight = 0) then
 set(b_clawLowered);
 else
 m_clawHeight := m_clawHeight - 1;
 end_if;
 if (b_ls2 AND b_clawLowered AND b_objectInClaw) then
 set(b_objectInOven);
 end_if;
 if (b_ls3 AND b_clawLowered AND b_objectInClaw) then
 set(m_b_objectDoneOnConveyor);
 end_if;
 end_if;
 end_if;
 end_if;
 (*Cette partie simule la position du chariot de la pince*)
 if (mvTrolleyL or mvTrolleyR) then
 trolleyPosTimer(TRUE, TROLLEY_POS_TICK, b_trolleyMoved);
 if (b_trolleyMoved) then
 trolleyPosTimer(FALSE, T#0s, b_trolleyMoved);
 reset(b_ls1);
 reset(b_ls2);
 reset(b_ls3);

 if (mvTrolleyL) then
 if (m_trolleyPos = 0) then
 ;
 else
 m_trolleyPos := m_trolleyPos - 1;
 end_if;
 elsif (mvTrolleyR) then
 if (m_trolleyPos = 100) then
 ;
 else
 m_trolleyPos := m_trolleyPos + 1;
 end_if;
 end_if;
 if (m_trolleyPos = 0) then
 set(b_ls1);
 elsif (m_trolleyPos = LS2_POS) then
 set(b_ls2);
 elsif (m_trolleyPos = LS3_POS) then
 set(b_ls3);
 end_if;
 end_if;
 end_if;
 (*Cette partie simule l'ouverture et la fermeture de la pince*)
 if (m_s_openClaw) then
 (*Reset timer if state changed from closing to opening*)
 if (NOT b_clawWasOpening) then
 clawOpeningTimer(FALSE, T#0s, b_clawOpeningChanged);
 end_if;
 set(b_clawWasOpening);
 clawOpeningTimer(TRUE, CLAW_OPENING_TICK, b_clawOpeningChanged);
 if (b_clawOpeningChanged) then
 clawOpeningTimer(FALSE, T#0s, b_clawOpeningChanged);
 if (m_clawOpening >= 100) then
 m_clawOpening := 100;
 elsif (b_objectInClaw AND m_clawOpening > MAX_CLAW_CLOSE_WITH_OBJECT) then
 reset(b_objectInClaw);
 else
 m_clawOpening := m_clawOpening + 1;
 end_if;
 end_if;
 elsif (NOT m_s_openClaw) then
 (*Reset timer if state changed from opening to closing*)
 if (b_clawWasOpening) then
 clawOpeningTimer(FALSE, T#0s, b_clawOpeningChanged);
 end_if;
 reset(b_clawWasOpening);
 clawOpeningTimer(TRUE, CLAW_OPENING_TICK, b_clawOpeningChanged);
 if (b_clawOpeningChanged) then
 clawOpeningTimer(FALSE, T#0s, b_clawOpeningChanged);
 if (m_clawOpening = 0) then
 ;(*m_clawOpening := 0;*)
 elsif (m_clawOpening <= MAX_CLAW_CLOSE_WITH_OBJECT AND b_objectInClaw) m_clawOpening := MAX_CLAW_CLOSE_WITH_OBJECT;
 else
 m_clawOpening := m_clawOpening - 1;
 end_if;
 if (m_clawOpening <= MAX_CLAW_CLOSE_WITH_OBJECT) then
 if (b_ls1 AND b_clawLowered AND b_objectOnConveyor) then
 set(b_objectInClaw);
 reset(b_objectOnConveyor);
 m_conveyorPos := 0;
 elsif (b_ls2 AND b_clawLowered AND b_objectInOven) then
 set(b_objectInClaw);
 end_if;
 end_if;
 end_if;
 end_if;
 (*Cette partie simule l'ouverture et la fermeture de la porte du four*)
 if (openOvenDoor) then
 if (NOT b_ovenDoorWasOpening) then
 ovenDoorTimer(FALSE, T#0s, b_ovenDoorMoved);
 end_if;
 set(b_ovenDoorWasOpening);
 ovenDoorTimer(TRUE, OVEN_DOOR_TICK, b_ovenDoorMoved);
