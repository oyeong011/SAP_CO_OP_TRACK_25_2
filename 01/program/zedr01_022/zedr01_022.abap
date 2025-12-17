
*&---------------------------------------------------------------------*

*& Report ZEDR01_021

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR01_022.



include
ZEDR01_022_TOP
.

include
ZEDR01_022_SCR
.

include
ZEDR01_022_F01
.

include
ZEDR01_022_PBO
.

include
ZEDR01_022_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

  PERFORM GET_DATA.



  CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> CLASS ALV