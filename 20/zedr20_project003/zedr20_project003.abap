
*&---------------------------------------------------------------------*

*& Report ZEDR20_PROJECT003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR20_PROJECT003 MESSAGE-ID ZMED20.



include
ZEDR20_PROJECT003_CLS
.

include
ZEDR20_PROJECT003_TOP
.

include
ZEDR20_PROJECT003_SCR
.

include
ZEDR20_PROJECT003_F01
.

include
ZEDR20_PROJECT003_PBO
.

include
ZEDR20_PROJECT003_PAI
.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SELECTION_SCREEN_OUTPUT.



INITIALIZATION.

  PERFORM SET_DEFAULT.



START-OF-SELECTION.

  PERFORM CHECK_INPUT.

  PERFORM GET_DATA_HEADER.



  IF P_R1 = 'X'.

    PERFORM GET_DATA.

    PERFORM MODIFY_DATA.

    CALL SCREEN 100.

  ELSE.

    PERFORM GET_DATA_WAREHOUSED.

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

*   #### #### ### #### ####.