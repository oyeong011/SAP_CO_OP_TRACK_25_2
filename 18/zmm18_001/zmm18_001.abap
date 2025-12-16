
*&---------------------------------------------------------------------*

*& Report ZMM18_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM18_001 MESSAGE-ID ZMMED18_001.



include
ZMM18_001_TOP
.

include
ZMM18_001_SCR
.

include
ZMM18_001_F01
.

include
ZMM18_001_PBO
.

include
ZMM18_001_PAI
.



INITIALIZATION.



AT SELECTION-SCREEN.

  IF SY-UCOMM = 'ONLI'.

    PERFORM VALIDATE_SCR_INPUT.

  ENDIF.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.





START-OF-SELECTION.

  IF P_CR = 'X'.

    CALL SCREEN 100. " ## ### ##

  ELSE.

    PERFORM GET_DATA.

    CALL SCREEN 200. " ## ### ##

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T0100 --> ### ##

* T0200 --> ### ##





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ### #### ####.