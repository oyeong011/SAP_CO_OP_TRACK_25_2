
*&---------------------------------------------------------------------*

*& Report ZMM02_003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM02_003 MESSAGE-ID ZMED02.



include
ZMM02_003_CLS
.

include
ZMM02_003_TOP
.

include
ZMM02_003_SCR
.

include
ZMM02_003_F01
.

include
ZMM02_003_PBO
.

include
ZMM02_003_PAI
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

    PERFORM GET_EKKO_DATA.

    CALL SCREEN 100.

  ELSEIF P_VIEW = 'X'. "##

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

*   #### ## #######.