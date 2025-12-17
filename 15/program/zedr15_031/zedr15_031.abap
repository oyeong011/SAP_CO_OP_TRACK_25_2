
*&---------------------------------------------------------------------*

*& Report ZEDR15_031

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR15_031 MESSAGE-ID ZMED15.



include
ZEDR15_031_TOP
.

include
ZEDR15_031_SCR
.

include
ZEDR15_031_F01
.

include
ZEDR15_031_PBO
.

include
ZEDR15_031_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

  IF S_ZCODE IS INITIAL.

   MESSAGE I100.

   EXIT.

  ENDIF.

  PERFORM GET_DATA.



  IF GT_STUDENT[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I100.

    EXIT.

  ENDIF.