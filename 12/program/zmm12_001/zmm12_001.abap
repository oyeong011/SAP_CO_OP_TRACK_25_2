
*&---------------------------------------------------------------------*

*& Report ZMM12_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM12_001.



include
ZMM12_001_CLS
.

include
ZMM12_001_TOP
.

include
ZMM12_001_SCR
.

include
ZMM12_001_F01
.

include
ZMM12_001_PBO
.

include
ZMM12_001_PAI
.



INITIALIZATION.





AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



AT SELECTION-SCREEN.



START-OF-SELECTION. "####

  PERFORM IS_VALID_INPUT. "#### ###### ### ####

  "#######

  IF P_RD1 = 'X'.

    CALL SCREEN 100.

  "#######

  ELSE. "P_RD2 = 'X'.

    PERFORM SEARCH_VENDOR. "####.

    CALL SCREEN 200.       "##### ##.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####

* T100 --> #####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ## ### ## ####.