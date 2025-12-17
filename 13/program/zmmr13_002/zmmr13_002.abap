
*&---------------------------------------------------------------------*

*& Report ZMMR13_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMMR13_002 MESSAGE-ID ZMED13.



include
ZMMR13_002_CLS
.

include
ZMMR13_002_TOP
.

include
ZMMR13_002_SCR
.

include
ZMMR13_002_F01
.

include
ZMMR13_002_O01
.

include
ZMMR13_002_I01
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

* T100 --> ######

* T200 --> ########





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ### ##### ######