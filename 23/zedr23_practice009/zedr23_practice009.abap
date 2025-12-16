
*&---------------------------------------------------------------------*

*& Report ZEDR23_PRACTICE009

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR23_PRACTICE009.



include
ZEDR23_PRACTICE009_TOP
.

include
ZEDR23_PRACTICE009_SCR
.

include
ZEDR23_PRACTICE009_F01
.

include
ZEDR23_PRACTICE009_PBO
.

include
ZEDR23_PRACTICE009_PAI
.



INITIALIZATION.

  PERFORM GET_DATE USING SY-DATUM CHANGING Z_LASTDAY.

  PERFORM SET_INIT.





START-OF-SELECTION.

  PERFORM CHECK.

  PERFORM GET_DATA.

  PERFORM REMOVE_QUIT.

  PERFORM VAL_TO_DESC.



CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> ## ## ###

* T100 --> ## ## ###





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##### ### ##### ###.