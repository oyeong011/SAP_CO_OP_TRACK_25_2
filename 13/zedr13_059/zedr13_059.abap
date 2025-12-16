
*&---------------------------------------------------------------------*

*& Report ZEDR13_059

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR13_059 MESSAGE-ID ZMED13.



include
ZEDR13_059_CLS
.

include
ZEDR13_059_TOP
.

include
ZEDR13_059_SCR
.

include
ZEDR13_059_F01
.

include
ZEDR13_059_O01
.

include
ZEDR13_059_I01
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





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##########