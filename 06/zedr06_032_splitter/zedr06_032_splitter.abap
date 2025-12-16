
*&---------------------------------------------------------------------*

*& Report ZEDR06_032_SPLITTER

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR06_032_SPLITTER MESSAGE-ID ZMED06_001.



include
ZEDR06_032_TOP
.

include
ZEDR06_032_SCR
.

include
ZEDR06_032_F01
.

include
ZEDR06_032_PBO
.

include
ZEDR06_032_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

  IF S_ZCODE IS INITIAL.

    MESSAGE I000.

    EXIT.

  ENDIF.

  PERFORM GET_DATA.



  IF GT_STUDENT[] IS NOT INITIAL.

   CALL SCREEN 100.

  ELSE.

    MESSAGE I001.

  ENDIF.