
*&---------------------------------------------------------------------*

*& Report ZMM08_003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM08_003.



include
ZMM08_003_TOP
.

include
ZMM08_003_CLS
.

include
ZMM08_003_SCR
.

include
ZMM08_003_F01
.

include
ZMM08_003_PBO
.

include
ZMM08_003_PAI
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

*   #### ## #### #####.