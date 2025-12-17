
*&---------------------------------------------------------------------*

*& Report ZEDR16_PROJECT001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR16_PROJECT001 MESSAGE-ID ZMED16.



include
ZEDR16_PROJECT001_TOP
.

include
ZEDR16_PROJECT001_SCR
.

include
ZEDR16_PROJECT001_F01
.

include
ZEDR16_PROJECT001_PBO
.

include
ZEDR16_PROJECT001_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.



AT SELECTION-SCREEN.

  IF SY-UCOMM = 'ONLI'.

    IF P_CRE = 'X'.

      PERFORM GET_CREATE_DATA.

    ELSEIF P_DIS = 'X'.

      PERFORM GET_DISPLAY_DATA.

    ENDIF.

  ENDIF.





START-OF-SELECTION.

  IF P_CRE = 'X'.

    PERFORM RUN_CREATE.

  ELSEIF P_DIS = 'X'.

    PERFORM RUN_DISPLAY.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ### ##

* T101 --> ### ##





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ### ###### #### #### #### ####.