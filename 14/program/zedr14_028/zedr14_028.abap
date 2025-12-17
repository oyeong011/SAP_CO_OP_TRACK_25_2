
*&---------------------------------------------------------------------*

*& Report ZEDR14_028

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR14_028 MESSAGE-ID ZMED14.



"MODULE POOL ##



include
ZEDR14_028_TOP
.

include
ZEDR14_028_SCR
.

include
ZEDR14_028_F01
.

include
ZEDR14_028_PBO
.

include
ZEDR14_028_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

  PERFORM GET_DATA.



  CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####