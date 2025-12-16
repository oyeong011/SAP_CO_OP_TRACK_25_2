
*&---------------------------------------------------------------------*

*& Report ZEDR13_PRACTICE009

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR13_PRACTICE009 MESSAGE-ID ZMED13.



include
ZEDR13_PRACTICE009_TOP
.

include
ZEDR13_PRACTICE009_SCR
.

include
ZEDR13_PRACTICE009_F01
.

include
ZEDR13_PRACTICE009_PBO
.

include
ZEDR13_PRACTICE009_PAI
.



INITIALIZATION.

  PERFORM SET_DATE.

START-OF-SELECTION.

  PERFORM MAIN.






*GUI Texts

*----------------------------------------------------------

* T001 --> ## ## ###

* T001 --> ## ## ###