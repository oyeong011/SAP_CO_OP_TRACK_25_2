
*&---------------------------------------------------------------------*

*& Report ZEDR13_058

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR13_058 MESSAGE-ID ZMED13.



include
ZEDR13_058_TOP
.

include
ZEDR13_058_SCR
.

include
ZEDR13_058_F01
.

include
ZEDR13_058_O01
.

include
ZEDR13_058_I01
.



INITIALIZATION.

  PERFORM SET_INITAL.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



START-OF-SELECTION.

  PERFORM GET_DATA.



  IF GT_STUDENT[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I000.

    EXIT.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T001 --> #####