
*&---------------------------------------------------------------------*

*& Report ZEDR20_PROJECT004

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR20_PROJECT004 MESSAGE-ID ZMED20.



include
ZEDR20_PROJECT004_CLS
.

include
ZEDR20_PROJECT004_TOP
.

include
ZEDR20_PROJECT004_SCR
.

include
ZEDR20_PROJECT004_F01
.

include
ZEDR20_PROJECT004_PBO
.

include
ZEDR20_PROJECT004_PAI
.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SELECTION_SCREEN_OUTPUT.



INITIALIZATION.

  PERFORM SET_DEFAULT.



START-OF-SELECTION.

  PERFORM CHECK_INPUT.

  PERFORM GET_COMMON_HEADER.



  IF P_R1 = 'X'.

    PERFORM GET_AMOUNT_HEADER.

    PERFORM GET_INVOICING_DATA.

    PERFORM MODIFY_INVOICING_DATA.

    CALL SCREEN 100.

  ELSE.

    PERFORM GET_INVOICED_DATA.

    PERFORM MODIFY_INVOICED_DATA.

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

*   ##### #### #### #### ####.