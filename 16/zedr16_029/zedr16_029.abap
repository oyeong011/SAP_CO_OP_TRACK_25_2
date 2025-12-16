
*&---------------------------------------------------------------------*

*& Report ZEDR16_029

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR16_029.



include
ZEDR16_029_TOP
.

include
ZEDR16_029_SCR
.

include
ZEDR16_029_F01
.

include
ZEDR16_029_PBO
.

include
ZEDR16_029_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

  PERFORM GET_DATA.



  CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####