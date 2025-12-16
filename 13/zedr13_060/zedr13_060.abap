
*&---------------------------------------------------------------------*

*& Report ZEDR13_060

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR13_060 MESSAGE-ID ZMED13.



include
ZEDR13_060_TOP
.

include
ZEDR13_060_SCR
.

include
ZEDR13_060_F01
.

include
ZEDR13_060_O01
.

include
ZEDR13_060_I01
.



INITIALIZATION.

  PERFORM SET_INITAL.



START-OF-SELECTION.

  IF S_ZCODE IS INITIAL.

    MESSAGE I000.

    EXIT.

  ENDIF.

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