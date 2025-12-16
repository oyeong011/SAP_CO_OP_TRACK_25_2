
*&---------------------------------------------------------------------*

*& Report ZEDR04_PRACTICE009

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_PRACTICE009 MESSAGE-ID ZMED04.



include
ZEDR04_PRACTICE009_TOP
.

include
ZEDR04_PRACTICE009_SCR
.

include
ZEDR04_PRACTICE009_F01
.

include
ZEDR04_PRACTICE009_PBO
.

include
ZEDR04_PRACTICE009_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

  PERFORM CHECK_DATA.



  PERFORM SELECT_DATA.

  IF GT_INFO[] IS INITIAL.

    MESSAGE I001.

    EXIT.

  ENDIF.



  PERFORM MODIFY_DATA.

  CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> ## ## ###

* T100 --> ## ## ###