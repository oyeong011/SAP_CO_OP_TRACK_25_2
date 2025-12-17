
*&---------------------------------------------------------------------*

*& Report ZEDR12_PRACTICE009

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_PRACTICE009 MESSAGE-ID ZMED12.

include
ZEDR12_PRACTICE009_TOP
.

include
ZEDR12_PRACTICE009_SCR
.

include
ZEDR12_PRACTICE009_F01
.

include
ZEDR12_PRACTICE009_PBO
.

include
ZEDR12_PRACTICE009_PAI
.





INITIALIZATION.

PERFORM SET_DATE. "$



START-OF-SELECTION.

PERFORM CHECK_DATA. "$



PERFORM SELECT_DATA. "$

PERFORM MODIFY_DATA. "$



IF GT_WORKER[] IS INITIAL.

  MESSAGE I001.

  EXIT.

ELSE.

  CALL SCREEN 100.

ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ####### (SPLITTER#)

* T100 --> ####### (SPLITTER#)