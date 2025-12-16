
*&---------------------------------------------------------------------*

*& Report ZMM15_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM15_001.



include
ZMM15_001_CLS
.

include
ZMM15_001_TOP
.

include
ZMM15_001_SCR
.

include
ZMM15_001_F01
.

include
ZMM15_001_O01
.

include
ZMM15_001_I01
.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SCREEN_CONTROL. "##/## #####



START-OF-SELECTION.

  PERFORM CHECK_INPUT. "#### ## ##



  IF P_R1 = C_X.

    CALL SCREEN 100.

  ELSEIF P_R2 = C_X.

    PERFORM SELECT_DATA.

    CALL SCREEN 200.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ### ##

* T200 --> ### ##





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ## ## ## #####