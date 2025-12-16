
*&---------------------------------------------------------------------*

*& Report ZMM15_004

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM15_004.



include
ZMM15_004_CLS
.

include
ZMM15_004_TOP
.

include
ZMM15_004_SCR
.

include
ZMM15_004_F01
. "####

include
ZMM15_004_F02
. "####

include
ZMM15_004_O01
.

include
ZMM15_004_I01
.



INITIALIZATION.

  P_BLDAT = SY-DATUM.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SCREEN_CONTROL.



AT SELECTION-SCREEN ON P_EBELN.

  PERFORM CHECK_EBELN.



START-OF-SELECTION.

  PERFORM CHECK_INPUT.



  IF P_R1 = 'X'.

    PERFORM GET_DATA.

    CALL SCREEN 100.

  ELSEIF P_R2 = 'X'.

    PERFORM GET_BELNR.

    CALL SCREEN 200.

  ENDIF.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ## ## ## #####