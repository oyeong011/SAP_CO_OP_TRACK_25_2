
*&---------------------------------------------------------------------*

*& Report ZEDR20_025

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR20_025.



include
ZEDR20_025_TOP
.

include
ZEDR20_025_SCR
.

include
ZEDR20_025_F01
.

include
ZEDR20_025_PBO
.

include
ZEDR20_025_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

  PERFORM GET_DATA.



  CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####