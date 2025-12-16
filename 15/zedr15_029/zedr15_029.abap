
*&---------------------------------------------------------------------*

*& Report ZEDR15_029

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR15_029.



include
ZEDR15_029_TOP
.

include
ZEDR15_029_SCR
.

include
ZEDR15_029_F01
.

"### ## logic

include
ZEDR15_029_PBO
. "#### ### #### ## ##

include
ZEDR15_029_PAI
. "### ### user### ### # ##



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

  PERFORM GET_DATA.





  CALL SCREEN 100.