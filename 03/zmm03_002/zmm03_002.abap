
*&---------------------------------------------------------------------*

*& Report ZMM03_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM03_002 MESSAGE-ID ZME03.



include
ZMM03_002_TOP
.

include
ZMM03_002_CLS
.

include
ZMM03_002_SCR
.

include
ZMM03_002_F01
.

include
ZMM03_002_PBO
.

include
ZMM03_002_PAI
.



INITIALIZATION.



AT SELECTION-SCREEN OUTPUT. "### ## ### ## ## ###

  PERFORM SELECTION-SCREEN_OUTPUT.



AT SELECTION-SCREEN.

  PERFORM SELECTION_SCREEN_CHECK.



START-OF-SELECTION.

  "##### # #### DB## ####

  IF GV_MODE = GC_MODE_D.

    PERFORM GET_DATA.

  ENDIF.

  "#### ##

  CALL SCREEN 100.



END-OF-SELECTION.






*GUI Texts

*----------------------------------------------------------

* T100 --> #### ## # #### ##





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ### #### ####.