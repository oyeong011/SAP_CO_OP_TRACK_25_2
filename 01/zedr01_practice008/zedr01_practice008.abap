
*&---------------------------------------------------------------------*

*& Report ZEDR01_PRACTICE008

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR01_PRACTICE008 MESSAGE-ID ZMED01.



include
ZEDR01_PRACTICE008_TOP
.

include
ZEDR01_PRACTICE008_SCR
.

include
ZEDR01_PRACTICE008_F01
.

include
ZEDR01_PRACTICE008_PBO
.

include
ZEDR01_PRACTICE008_PAI
.



INITIALIZATION.

  PERFORM INIT_DATA.

AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.

START-OF-SELECTION.

  PERFORM MAIN.






*GUI Texts

*----------------------------------------------------------

* T100 --> ######

* T200 --> ######

* T100 --> ######

* T200 --> ######