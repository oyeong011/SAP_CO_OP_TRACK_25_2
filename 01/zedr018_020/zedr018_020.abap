
*&---------------------------------------------------------------------*

*& Report ZEDR018_020

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR018_020.



include
ZEDR018_024_TOP
.

include
ZEDR018_024_SCR
.

include
ZEDR018_024_F01
.

include
ZEDR018_024_PBO
.

include
ZEDR018_024_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

  PERFORM GET_DATA.



  CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####