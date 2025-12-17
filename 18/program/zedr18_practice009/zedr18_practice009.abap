
*&---------------------------------------------------------------------*

*& Report ZEDR18_PRACTICE009

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR18_PRACTICE009 MESSAGE-ID ZMED18.



include
ZPRACTICE009_CONTAINER18_TOP
.

include
ZPRACTICE009_CONTAINER18_SCR
.

include
ZPRACTICE009_CONTAINER18_F01
.

include
ZPRACTICE009_CONTAINER18_PBO
.

include
ZPRACTICE009_CONTAINER18_PAI
.



INITIALIZATION.

  PERFORM INIT_DATE.



START-OF-SELECTION.

  PERFORM CHECK_DATA.

  PERFORM MAKE_RANGES.

  PERFORM GET_DATA.

  PERFORM MODIFY_DATA.



  CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> ## ## ###

* T100 --> ## ## ###