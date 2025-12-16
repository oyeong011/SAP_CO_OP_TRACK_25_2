
*&---------------------------------------------------------------------*

*& Report ZEDR13_PRACTICE008

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR13_PRACTICE008 MESSAGE-ID ZMED13.



include
ZEDR13_PRACTICE008_TOP
.

include
ZEDR13_PRACTICE008_SCR
.

include
ZEDR13_PRACTICE008_F01
.

include
ZEDR13_PRACTICE008_PBO
.

include
ZEDR13_PRACTICE008_PAI
.





INITIALIZATION.

  PERFORM DATE_SETTING. "### ### ## ### ##"



AT SELECTION-SCREEN OUTPUT.

  PERFORM SCREEN_CHANGING.



START-OF-SELECTION.

  PERFORM MAIN.






*GUI Texts

*----------------------------------------------------------

* T001 --> ######

* T002 --> ######

* T001 --> ######

* T002 --> ######