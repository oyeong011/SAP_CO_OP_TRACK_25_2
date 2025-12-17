
*&---------------------------------------------------------------------*

*& Report ZEDR19_052

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR19_052.



include
ZEDR19_052_TOP
.

include
ZEDR19_052_SCR
.

include
ZEDR19_052_F01
.

include
ZEDR19_052_PB0
.

include
ZEDR19_052_PAI
.



INITIALIZATION.

  PERFORM SET_INIT. "####



START-OF-SELECTION.

  PERFORM GET_DATA.



  CALL SCREEN 100. "###### ### ##






*GUI Texts

*----------------------------------------------------------

* T100 --> #####