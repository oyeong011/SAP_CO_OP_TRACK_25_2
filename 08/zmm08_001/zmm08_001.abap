
*&---------------------------------------------------------------------*

*& Report ZMM08_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM08_001.



" INCLUDE ##

include
ZMM08_001_TOP
.

include
ZMM08_001_SCR
.

include
ZMM08_001_F01
.

include
ZMM08_001_PBO
.

include
ZMM08_001_PAI
.



" #### ## # ## ## ###

INITIALIZATION.

  PERFORM SET_DEFAULTS.



" ### ## ##, ## ### ### ##

AT SELECTION-SCREEN OUTPUT.

  PERFORM MODIFY_SELECTION_SCREEN.



" ## ## ##

AT SELECTION-SCREEN.

  PERFORM SET_SELECTION_SCREEN.



" F8 ## ##

START-OF-SELECTION.

  PERFORM START_SCREEN.






*GUI Texts

*----------------------------------------------------------

* T01 --> #### ##

* T02 --> T02





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ###### ##### ## #####.