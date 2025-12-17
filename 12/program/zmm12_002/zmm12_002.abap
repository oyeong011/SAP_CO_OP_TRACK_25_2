
*&---------------------------------------------------------------------*

*& Report ZMM12_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM12_002.

include
ZMM12_002_CLS
.

include
ZMM12_002_TOP
.

include
ZMM12_002_SCR
.

include
ZMM12_002_F01
.

include
ZMM12_002_PBO
.

include
ZMM12_002_PAI
.



INITIALIZATION.

  PERFORM INITIALIZATION.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.






*AT SELECTION-SCREEN.

*  PERFORM GET_DATA.






START-OF-SELECTION. "####

PERFORM CHECK_MANDATORY.

IF P_RD1 = 'X'. "PO## ###

  PERFORM GET_DATA1.

  CALL SCREEN 100.

ELSEIF P_RD2 = 'X'. "#####

  PERFORM GET_DATA2.

  CALL SCREEN 200.

ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ######

* T200 --> #######

* T100 --> ######

* T200 --> #######





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ### ##### ####.