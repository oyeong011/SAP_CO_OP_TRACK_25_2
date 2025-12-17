
*&---------------------------------------------------------------------*

*& Report ZEDR20_PRACTICE008

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR20_PRACTICE008 MESSAGE-ID ZMED20.



include
ZEDR20_PRACTICE008_TOP
.

include
ZEDR20_PRACTICE008_SCR
.

include
ZEDR20_PRACTICE008_F01
.

include
ZEDR20_PRACTICE008_PBO
.

include
ZEDR20_PRACTICE008_PAI
.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



INITIALIZATION.

  PERFORM SET_DEFAULT.



START-OF-SELECTION.

  PERFORM CHECK_INPUT_ERROR.

  PERFORM GET_DATA.

  PERFORM MODIFY_DATA.

  PERFORM CALL_SCREEN.






*GUI Texts

*----------------------------------------------------------

* T100 --> ######

* T200 --> ######