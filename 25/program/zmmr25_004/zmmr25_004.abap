
*&---------------------------------------------------------------------*

*& Report ZMMR25_004

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMMR25_004.



include
ZMMR25_004_CLS
.

include
ZMMR25_004_TOP
.

include
ZMMR25_004_SCR
.

include
ZMMR25_004_F01
.

include
ZMMR25_004_PBO
.

include
ZMMR25_004_PAI
.



INITIALIZATION.

  PERFORM SCREEN_INIT.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SCREEN_MODIFY.



 AT SELECTION-SCREEN.

  IF SY-UCOMM = 'ONLI'.

    PERFORM CHECK_PO_EXISTS.

 ENDIF.



START-OF-SELECTION.



  IF P_R1 = 'X'.

    PERFORM VALIDATE_INPUT_DATA.

    PERFORM SELECT_PO_HEADER_DATA.

    PERFORM SELECT_PO_ITEM_DATA.

    PERFORM CALCULATE_INVOICE_AMOUNT.

    CALL SCREEN 100.



  ELSE.

    PERFORM VALIDATE_QUERY_INPUT.

    PERFORM SELECT_INVOICE_HEADER.

    PERFORM SELECT_INVOICE_ITEMS.

    PERFORM CALCULATE_TOTAL_AMOUNT.

    CALL SCREEN 200.



  ENDIF.






*GUI Texts

*----------------------------------------------------------

* TITLE_100 --> ###

* TITLE_200 --> ###





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ## #### ######.