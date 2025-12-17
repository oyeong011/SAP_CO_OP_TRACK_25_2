
*&---------------------------------------------------------------------*

*& Report ZEDR10_1028

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR10_1028.



include
ZEDR10_1028_TOP
.

include
ZEDR10_1028_SCR
.

include
ZEDR10_1028_F01
.

include
ZEDR10_1028_PBO
.

include
ZEDR10_1028_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.

  PERFORM MODIFY_DATA.



START-OF-SELECTION.

  PERFORM GET_DATA.



  CALL SCREEN 100.