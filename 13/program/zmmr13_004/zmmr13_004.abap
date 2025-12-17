
*&---------------------------------------------------------------------*

*& Report ZMMR13_004

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMMR13_004 MESSAGE-ID ZMED13.



include
ZMMR13_004_CLS
.

include
ZMMR13_004_TOP
.

include
ZMMR13_004_SCR
.

include
ZMMR13_004_F01
.

include
ZMMR13_004_O01
.

include
ZMMR13_004_I01
.



INITIALIZATION.

  PERFORM INITIALIZATION.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SCREEN_CHANGE.

START-OF-SELECTION.

  PERFORM CHECK_MANDATORY.

  IF P_R1 = 'X'.

    PERFORM INIT_DATA_0100.

    CALL SCREEN 100.

  ELSEIF P_R2 = 'X'.

    PERFORM INIT_DATA_0200.

    CALL SCREEN 200.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T001 --> ##

* T002 --> ## ##





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   #### ## #######