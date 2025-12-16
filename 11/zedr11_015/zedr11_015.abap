
*&---------------------------------------------------------------------*

*& Report ZEDR11_015

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR11_015 MESSAGE-ID ZMED11.



include
ZDOCKING_CONTAINER11_TOP
.

include
ZDOCKING_CONTAINER11_SCR
.

include
ZDOCKING_CONTAINER11_F01
.

include
ZDOCKING_CONTAINER11_O01
.

include
ZDOCKING_CONTAINER11_I01
.



INITIALIZATION.

  PERFORM SET_INIT.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



START-OF-SELECTION.

  PERFORM GET_DATA.



 START-OF-SELECTION.

  IF S_zPERNR IS INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I000.

    EXIT.

  ENDIF.