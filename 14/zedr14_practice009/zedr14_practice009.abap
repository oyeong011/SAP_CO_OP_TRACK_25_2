
*&---------------------------------------------------------------------*

*& Report ZEDR14_PRACTICE009

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR14_PRACTICE009 MESSAGE-ID ZMED14.



"#######(SPLITTER#)

include
ZEDR14_PRACTICE009_TOP
.

include
ZEDR14_PRACTICE009_SCR
.

include
ZEDR14_PRACTICE009_F01
.

include
ZEDR14_PRACTICE009_PBO
.

include
ZEDR14_PRACTICE009_PAI
.



INITIALIZATION.

  PERFORM SET_INITIAL.



START-OF-SELECTION.

  PERFORM GET_DATA.

  PERFORM MODIFY_DATA.



  CALL SCREEN 100.