
*&---------------------------------------------------------------------*

*& Report ZEDR20_026

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR20_026.



include
ZEDR20_026_TOP
.

include
ZEDR20_026_SCR
.

include
ZEDR20_026_F01
.

include
ZEDR20_026_PBO
.

include
ZEDR20_026_PAI
.



INITIALIZATION.

  PERFORM SET_DEFAULT.



START-OF-SELECTION.

  PERFORM GET_DATA.



  CALL SCREEN 100.