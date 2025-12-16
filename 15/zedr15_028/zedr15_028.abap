
*&---------------------------------------------------------------------*

*& Report ZEDR15_028

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR15_028.



include
ZEDR15_028_TOP
.

include
ZEDR15_028_SCR
.

include
ZEDR15_028_F01
.

"### ## logic

include
ZEDR15_028_PBO
. "#### ### #### ## ##

include
ZEDR15_028_PAI
. "### ### user### ### # ##



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

  PERFORM GET_DATA.





  CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####