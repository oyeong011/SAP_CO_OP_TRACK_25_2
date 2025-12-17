
*&---------------------------------------------------------------------*

*& Report ZEDR06_031

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR06_031.



include
ZEDR06_031_TOP
. " ###.

include
ZEDR06_031_SCR
. " ###

include
ZEDR06_031_F01
. " ###

include
ZEDR06_031_PBO
. "

include
ZEDR06_031_PAI
. "





INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

  PERFORM GET_DATA.



  IF GT_STUDENT[] IS NOT INITIAL.

    CALL SCREEN 100.

  ENDIF.