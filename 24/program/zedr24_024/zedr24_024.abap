
*&---------------------------------------------------------------------*

*& Report ZEDR24_024

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR24_024 MESSAGE-ID ZEDM24.



include
ZEDR24_024_TOP
.

include
ZEDR24_024_SCR
.

include
ZEDR24_024_F01
.

include
ZEDR24_024_PBO
.

include
ZEDR24_024_PAI
.



INITIALIZATION.

  "PERFORM SET_INIT.



START-OF-SELECTION.




*  IF S_ZCODE IS INITIAL.

*    MESSAGE I100.

*    EXIT.

*  ENDIF.




  PERFORM GET_DATA.



  IF GT_STUDENT[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I000.

    EXIT.

  ENDIF.