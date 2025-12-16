
*&---------------------------------------------------------------------*

*& Report ZEDR08_026

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR08_026.



include
ZEDR08_026_TOP
.

include
ZEDR08_026_SCR
.

include
ZEDR08_026_F01
.

include
ZEDR08_026_PBO
.

include
ZEDR08_026_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

  PERFORM GET_DATA.



  CALL SCREEN 100.

  CALL SCREEN 200.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####