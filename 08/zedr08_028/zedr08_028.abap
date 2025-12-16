
*&---------------------------------------------------------------------*

*& Report ZEDR08_028

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR08_028.



include
ZDOCKING_CONTAINER08_01_TOP
.

include
ZDOCKING_CONTAINER08_01_SCR
.

include
ZDOCKING_CONTAINER08_01_F01
.

include
ZDOCKING_CONTAINER08_01_PBO01
.

include
ZDOCKING_CONTAINER08_01_PAI01
.



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

  IF S_ZCODE IS INITIAL.

    EXIT.

  ENDIF.



  PERFORM GET_DATA.



  IF GT_STUDENT[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    EXIT.

  ENDIF.