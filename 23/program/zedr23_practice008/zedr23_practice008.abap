
*&---------------------------------------------------------------------*

*& Report ZEDR23_PRACTICE008

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR23_PRACTICE008.



include
ZED23_PRACTICE008_TOP
.

include
ZED23_PRACTICE008_SCR
.

include
ZED23_PRACTICE008_F01
.

include
ZED23_PRACTICE008_PBO
.

include
ZED23_PRACTICE008_PAI
.



INITIALIZATION.

  PERFORM GET_DATE.

  PERFORM SET_INIT.



AT SELECTION-SCREEN OUTPUT.

  PERFORM ASSO.



START-OF-SELECTION.

  PERFORM GET_DATA.

  PERFORM REMOVE_REFUND.

  PERFORM VAL_TO_DESC.



  IF P_R1 EQ TRUE.

    CALL SCREEN 100.

  ELSEIF P_R2 EQ TRUE.

    CALL SCREEN 200.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ####

* T100 --> ####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   #### ## ## ID ###.