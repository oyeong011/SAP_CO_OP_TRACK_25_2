
*&---------------------------------------------------------------------*

*& Report ZMM08_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM08_002.



include
ZMM08_002_TOP
.

include
ZMM08_002_CLS
.

include
ZMM08_002_SCR
.

include
ZMM08_002_F01
.

include
ZMM08_002_PBO
.

include
ZMM08_002_PAI
.





INITIALIZATION.

  PERFORM SET_DEFAULTS.



AT SELECTION-SCREEN OUTPUT.

  PERFORM MODIFY_SELECTION_SCREEN.



AT SELECTION-SCREEN.

  PERFORM SET_SELECTION_SCREEN.



START-OF-SELECTION.

  PERFORM START_SCREEN.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ### ### #####.