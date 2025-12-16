
*&---------------------------------------------------------------------*

*& Report ZMM12_003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM12_003 MESSAGE-ID ZMED12.

include
ZMM12_003_CLS
.

include
ZMM12_003_TOP
.

include
ZMM12_003_SCR
.

include
ZMM12_003_F01
.

include
ZMM12_003_PBO
.

include
ZMM12_003_PAI
.



INITIALIZATION.

  PERFORM INITIALIZATION.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



START-OF-SELECTION. "####

PERFORM CHECK_MANDATORY.

PERFORM EXIST_PO.



IF P_RD1 = 'X'.     "#### ###

  PERFORM GET_PO_DATA.

  CALL SCREEN 100.

ELSEIF P_RD2 = 'X'. "#######

  PERFORM GET_MSEG_DATA.

  CALL SCREEN 200.

ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ####

* T200 --> ####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##### #### ####.