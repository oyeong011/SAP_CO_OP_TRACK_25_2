
*&---------------------------------------------------------------------*

*& Report ZEDR20_028

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR20_028.



include
ZEDR20_028_TOP
.

include
ZEDR20_028_SCR
.

include
ZEDR20_028_F01
.

include
ZEDR20_028_PBO
.

include
ZEDR20_028_PAI
.



INITIALIZATION.

  PERFORM SET_DEFAULT.



START-OF-SELECTION.

  PERFORM GET_DATA.



  CALL SCREEN 100.