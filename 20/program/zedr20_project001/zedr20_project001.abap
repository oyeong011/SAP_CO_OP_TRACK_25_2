
*&---------------------------------------------------------------------*

*& Report ZEDR20_PROJECT001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR20_PROJECT001 MESSAGE-ID ZMED20.



include
ZEDR20_PROJECT001_TOP
.

include
ZEDR20_PROJECT001_SCR
.

include
ZEDR20_PROJECT001_F01
.

include
ZEDR20_PROJECT001_PBO
.

include
ZEDR20_PROJECT001_PAI
.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



AT SELECTION-SCREEN.



INITIALIZATION.



START-OF-SELECTION.

  PERFORM CHECK_INPUT.

  IF P_R2 = 'X'.

    PERFORM GET_DATA.

    PERFORM CHECK_INITIAL.

    PERFORM SET_DATA.

  ELSE.

    PERFORM NEW_DATA.

  ENDIF.

  CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####

* T200 --> #####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ### ######.