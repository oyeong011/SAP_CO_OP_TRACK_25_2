
*&---------------------------------------------------------------------*

*& Report ZMM15_003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM15_003.



include
ZMM15_003_CLS
.

include
ZMM15_003_TOP
.

include
ZMM15_003_SCR
.

include
ZMM15_003_F01
. "####

include
ZMM15_003_F02
. "####

include
ZMM15_003_O01
.

include
ZMM15_003_I01
.



INITIALIZATION.

  P_BUDAT = SY-DATUM. "##### ### ### ####



AT SELECTION-SCREEN OUTPUT.

  PERFORM SCREEN_CONTROL. "##/## #####



AT SELECTION-SCREEN ON P_EBELN.

  PERFORM CHECK_EBELN.



START-OF-SELECTION.

  PERFORM CHECK_INPUT. "#### ## ##



  IF P_R1 = 'X'.

    PERFORM GET_PO. "##### ##### ## ## ####

    CALL SCREEN 100.

  ELSEIF P_R2 = 'X'.

    PERFORM GET_MBLNR. "#### ### #### ##

    CALL SCREEN 200.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T200 --> ####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ## ## ## #####