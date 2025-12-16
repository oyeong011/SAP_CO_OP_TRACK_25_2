
*&---------------------------------------------------------------------*

*& Report ZMM15_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM15_002.



include
ZMM15_002_CLS
.

include
ZMM15_002_TOP
.

include
ZMM15_002_SCR
.

include
ZMM15_002_F01
.

include
ZMM15_002_O01
.

include
ZMM15_002_I01
.



INITIALIZATION.

  P_BEDAT = SY-DATUM. "### ### ### ####



AT SELECTION-SCREEN OUTPUT.

  PERFORM SCREEN_CONTROL. "##/## #####



AT SELECTION-SCREEN ON P_LIFNR1.

  PERFORM CHECK_LIFNR. "### ### ### ##





START-OF-SELECTION.

  PERFORM CHECK_INPUT. "#### ## ##



  IF P_R1 = 'X'.

    CALL SCREEN 100.

  ELSEIF P_R2 = 'X'.

    PERFORM GET_DATA.

    CALL SCREEN 100.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> #### ##





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ## ## ## #####