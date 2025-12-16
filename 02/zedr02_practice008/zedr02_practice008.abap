
*&---------------------------------------------------------------------*

*& Report ZEDR02_PRACTICE008

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR02_PRACTICE008 MESSAGE-ID ZMED02.



include
ZEDR02_PRACTICE008_TOP
.

include
ZEDR02_PRACTICE008_SCR
.

include
ZEDR02_PRACTICE008_F01
.

include
ZEDR02_PRACTICE008_PBO
.

include
ZEDR02_PRACTICE008_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



AT SELECTION-SCREEN.

  PERFORM VALIDATE_INPUT.



START-OF-SELECTION.

  PERFORM SET_GET_DATA.

  IF P_ORDER = 'X'. "####

    PERFORM GET_ORDER_DATA.

    PERFORM APPEND_ORDER_DATA.

    CALL SCREEN 100.

  ELSEIF P_SHIP = 'X'. "####

    PERFORM GET_SHIP_DATA.

    PERFORM APPEND_SHIP_DATA.

    CALL SCREEN 200.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> R1 ######

* T200 --> R2 ######

* T100 --> R1 ######

* T200 --> R2 ######