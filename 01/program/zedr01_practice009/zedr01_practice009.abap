
*&---------------------------------------------------------------------*

*& Report ZEDR01_PRACTICE009

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR01_PRACTICE009 MESSAGE-ID ZMED00.



include
ZEDR01_PRACTICE009_TOP
.

include
ZEDR01_PRACTICE009_SCR
.

include
ZEDR01_PRACTICE009_F01
.

include
ZEDR01_PRACTICE009_PBO
.

include
ZEDR01_PRACTICE009_PAI
.



INITIALIZATION.

  PERFORM INIT_DATA.

START-OF-SELECTION.

  PERFORM MAIN.






*GUI Texts

*----------------------------------------------------------

* T100 --> ## ## ###

* T100 --> ## ## ###