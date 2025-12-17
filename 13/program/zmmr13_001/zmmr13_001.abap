
*&---------------------------------------------------------------------*

*& Report ZMMR13_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMMR13_001 MESSAGE-ID ZMED13.



include
ZMMR13_001_CLS
.

include
ZMMR13_001_TOP
.

include
ZMMR13_001_SCR
.

include
ZMMR13_001_F01
.

include
ZMMR13_001_O01
.

include
ZMMR13_001_I01
.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SCREEN_CHANGE.



START-OF-SELECTION.

  PERFORM CHECK_MANDATORY.

  IF P_R1 = 'X'.

    PERFORM POPUP_MESSAGE.

    CALL SCREEN 100.

  ELSEIF P_R2 = 'X'.

    PERFORM INIT_DATA.

    CALL SCREEN 200.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####

* T200 --> #####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   #######