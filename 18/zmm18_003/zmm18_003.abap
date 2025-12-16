
*&---------------------------------------------------------------------*

*& Report ZMM18_003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM18_003.



include
ZMM18_003_CLS
.

include
ZMM18_003_TOP
.

include
ZMM18_003_SCR
.

include
ZMM18_003_F01
.

include
ZMM18_003_PBO
.

include
ZMM18_003_PAI
.





INITIALIZATION. " ### ##

  PERFORM INITIALIZATION.



AT SELECTION-SCREEN OUTPUT.	" ## ## ### ## ## ##/##

  PERFORM SET_SCREEN_OUTPUT.



AT SELECTION-SCREEN.  " ## ##

  PERFORM CHECK_SCREEN_INPUT.



START-OF-SELECTION.  "#### ## ##

  IF p_r1 = 'X'.

    CALL SCREEN 100. "## ##

  ELSE.

    CALL SCREEN 200. "## ##

  ENDIF.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##### ## ## #####.