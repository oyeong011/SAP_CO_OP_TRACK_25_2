
*&---------------------------------------------------------------------*

*& Report ZMMR25_003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMMR25_003.



include
ZMMR25_003_CLS
.

include
ZMMR25_003_TOP
.

include
ZMMR25_003_SCR
.

include
ZMMR25_003_F01
.

include
ZMMR25_003_PBO
.

include
ZMMR25_003_PAI
.



INITIALIZATION.

  PERFORM SCREEN_INIT.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SCREEN_MODIFY.



START-OF-SELECTION.



  IF RB_CR = 'X'.

    PERFORM VALIDATE_INPUT_DATA.

    PERFORM SELECT_PURCHASE_ORDER_DATA.

    PERFORM CALCULATE_OPEN_QUANTITY.

    PERFORM SET_DOCUMENT_HEADER.

    CALL SCREEN 100.



  ELSE.

    PERFORM VALIDATE_DISPLAY_INPUT.

    PERFORM SELECT_RECEIPT_DATA.

    PERFORM PREPARE_DISPLAY_DATA.

    CALL SCREEN 200.



  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ###

* T100 --> ###