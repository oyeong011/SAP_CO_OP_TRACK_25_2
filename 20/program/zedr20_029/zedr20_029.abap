
*&---------------------------------------------------------------------*

*& Report ZEDR20_029

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR20_029.



include
ZEDR20_029_CLS
.



include
ZEDR20_029_TOP
.

include
ZEDR20_029_SCR
.

include
ZEDR20_029_F01
.

include
ZEDR20_029_PBO
.

include
ZEDR20_029_PAI
.



INITIALIZATION.

  PERFORM SET_DEFAULT.



START-OF-SELECTION.

  PERFORM GET_DATA.



CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> ########





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##########.