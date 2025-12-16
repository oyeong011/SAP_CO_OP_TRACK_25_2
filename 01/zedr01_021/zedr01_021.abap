
*&---------------------------------------------------------------------*

*& Report ZEDR01_021

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR01_021.



include
ZEDR01_021_TOP
.

include
ZEDR01_021_SCR
.

include
ZEDR01_021_F01
.

include
ZEDR01_021_PBO
.

include
ZEDR01_021_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

  PERFORM GET_DATA.



  CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####