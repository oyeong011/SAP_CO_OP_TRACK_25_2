
*&---------------------------------------------------------------------*

*& Report ZEDR20_PROJECT002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR20_PROJECT002 MESSAGE-ID ZMED20.



include
ZEDR20_PROJECT002_CLS
.

include
ZEDR20_PROJECT002_TOP
.

include
ZEDR20_PROJECT002_SCR
.

include
ZEDR20_PROJECT002_F01
.

include
ZEDR20_PROJECT002_PBO
.

include
ZEDR20_PROJECT002_PAI
.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SELECTION_SCREEN_OUTPUT.



AT SELECTION-SCREEN.



INITIALIZATION.



START-OF-SELECTION.

  PERFORM CHECK_INPUT.

  PERFORM GET_LIFNAME.

  IF P_R1 = 'X'.

    CALL SCREEN 100.

  ELSEIF P_R2 = 'X'.

    PERFORM GET_DATA.

    PERFORM CHECK_AVAILABLE_DATA.

    CALL SCREEN 200.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> PO##

* T200 --> PO##





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   #### ## ######.