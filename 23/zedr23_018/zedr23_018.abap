
*&---------------------------------------------------------------------*

*& Report ZEDR23_018

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR23_018.



include
ZEDR23_018_CLS
.

include
ZEDR23_018_TOP
.

include
ZEDR23_018_SCR
.

include
ZEDR23_018_F01
.

include
ZEDR23_018_PBO
.

include
ZEDR23_018_PAI
.



INITIALIZATION.

PERFORM SET_INIT.



START-OF-SELECTION.

PERFORM GET_DATA.



CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ## ### ##