
*&---------------------------------------------------------------------*

*& Report ZMM02_004

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM02_004 MESSAGE-ID ZMED02.



include
ZMM02_004_CLS
.

include
ZMM02_004_TOP
.

include
ZMM02_004_SCR
.

include
ZMM02_004_F01
.

include
ZMM02_004_PBO
.

include
ZMM02_004_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



AT SELECTION-SCREEN.

  IF SY-UCOMM = 'ONLI'. "## ## ##

    PERFORM VALIDATE_INPUT.

  ENDIF.



START-OF-SELECTION.

  IF P_CRE = 'X'. "##

    PERFORM GET_PO.

    CALL SCREEN 100.

  ELSEIF P_VIEW = 'X'. "##

    CALL SCREEN 200.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ## ##

* T200 --> ## ## ##

* T300 --> ## ### ##





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   #### ## #### #####.