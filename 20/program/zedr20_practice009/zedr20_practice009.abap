
*&---------------------------------------------------------------------*

*& Report ZEDR20_PRACTICE009

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR20_PRACTICE009 MESSAGE-ID ZMED20.



include
ZEDR20_PRACTICE009_TOP
.

include
ZEDR20_PRACTICE009_SCR
.

include
ZEDR20_PRACTICE009_F01
.

include
ZEDR20_PRACTICE009_PBO
.

include
ZEDR20_PRACTICE009_PAI
.



INITIALIZATION.

  PERFORM SET_DEFAULT.



START-OF-SELECTION.

  PERFORM CHECK_INPUT_ERROR.

  PERFORM GET_DATA.

  PERFORM MODIFY_DATA.



CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> #######