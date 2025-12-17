
*&---------------------------------------------------------------------*

*& Report ZMM02_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM02_002 MESSAGE-ID ZMED02.



include
ZMM02_002_CLS
.

include
ZMM02_002_TOP
.

include
ZMM02_002_SCR
.

include
ZMM02_002_F01
.

include
ZMM02_002_PBO
.

include
ZMM02_002_PAI
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

    PERFORM GET_LFM1.

    CALL SCREEN 100.

  ELSEIF P_VIEW = 'X'. "##

    PERFORM GET_EKPO.

    CALL SCREEN 200.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> #### ##

* T200 --> #### ##





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   #### ## ######.