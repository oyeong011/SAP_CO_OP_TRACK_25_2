
*&---------------------------------------------------------------------*

*& Report ZMM21_003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM21_003.



include
ZMM21_003_TOP
.

include
ZMM21_003_SCR
.

include
ZMM21_003_F01
.

include
ZMM21_003_PBO
.

include
ZMM21_003_PAI
.



INITIALIZATION.

  PERFORM SET_DATE.



AT SELECTION-SCREEN.

    PERFORM EBELN_CHECK.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



START-OF-SELECTION.

  IF P_RAD1 = 'X'.

    PERFORM GET_DATA.

    CALL SCREEN 100.

  ELSE.

    PERFORM GET_DATA2.

    CALL SCREEN 200.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* 100 --> 100

* 200 --> 200





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   NO DATA AVAILABLE.