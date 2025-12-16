
*&---------------------------------------------------------------------*

*& Report ZEDR02_PRACTICE009

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR02_PRACTICE009 MESSAGE-ID ZMED02.



include
ZEDR02_PRACTICE009_TOP
.

include
ZEDR02_PRACTICE009_SCR
.

include
ZEDR02_PRACTICE009_F01
.

include
ZEDR02_PRACTICE009_PBO
.

include
ZEDR02_PRACTICE009_PAI
.



INITIALIZATION.

  PERFORM SET_INIT. "#### ### ##



AT SELECTION-SCREEN.

  PERFORM VALIDATE_INPUT. "## ### ##



START-OF-SELECTION.

  PERFORM GET_DATA. "### ###

  PERFORM APPEND_DATA. "### ### ##

  CALL SCREEN 100. "ALV






*GUI Texts

*----------------------------------------------------------

* T100 --> EMPLOYEE INFO

* T100 --> EMPLOYEE INFO