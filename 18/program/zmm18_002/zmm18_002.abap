
*&---------------------------------------------------------------------*

*& Report ZMM18_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM18_002.



include
ZMM18_002_CLS
.

include
ZMM18_002_TOP
.

include
ZMM18_002_SCR
.

include
ZMM18_002_F01
.

include
ZMM18_002_PBO
.

include
ZMM18_002_PAI
.



AT SELECTION-SCREEN OUTPUT. " 1. ## ## ##

  PERFORM SET_SCREEN_OUTPUT.



AT SELECTION-SCREEN. " 2. ### ##

  PERFORM CHECK_SCREEN_INPUT.



START-OF-SELECTION. " 3. ##

  PERFORM INITIALIZE_DATA.

  CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> #### ##

* T200 --> #### ##





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##### ## ## #####.