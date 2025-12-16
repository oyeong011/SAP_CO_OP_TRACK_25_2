
*&---------------------------------------------------------------------*

*& Report ZMM03_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM03_001 MESSAGE-ID ZME03.



include
ZMM03_001_TOP
.

include
ZMM03_001_SCR
.

include
ZMM03_001_F01
.

include
ZMM03_001_PBO
.

include
ZMM03_001_PAI
.



AT SELECTION-SCREEN OUTPUT.

  PERFORM CONTROL_SCREEN.



START-OF-SELECTION.

  PERFORM CHECK_INIT.

  IF P_CRE = 'X'.

    PERFORM POPUP_CONFIRM.

    PERFORM CREATE_DATA CHANGING GV_LIFNR.

  ELSE.

    PERFORM GET_DATA.

    PERFORM CHECK_DATA.

    PERFORM SET_DATA.

  ENDIF.

  CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> ### ##

* T200 --> ### ##





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   #######