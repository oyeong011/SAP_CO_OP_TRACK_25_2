
*&---------------------------------------------------------------------*

*& Report ZEDR20_030

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR20_030.



include
ZEDT20_030_CLS
.

include
ZEDT20_030_TOP
.

include
ZEDT20_030_SCR
.

include
ZEDT20_030_F01
.

include
ZEDT20_030_PBO
.

include
ZEDT20_030_PAI
.



INITIALIZATION.

  PERFORM SET_DEFAULT.



START-OF-SELECTION.

  PERFORM GET_DATA.



  CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   #######