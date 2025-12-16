
*&---------------------------------------------------------------------*

*& Report ZEDR18_PRACTICE008

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR18_PRACTICE008 MESSAGE-ID ZMED18.





include
ZPRACTICE008_CONTAINER18_TOP
.

include
ZPRACTICE008_CONTAINER18_SCR
.

include
ZPRACTICE008_CONTAINER18_F01
.

include
ZPRACTICE008_CONTAINER18_O01
.

include
ZPRACTICE008_CONTAINER18_I01
.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



INITIALIZATION.

  PERFORM INIT_DATE.



START-OF-SELECTION.

  PERFORM MAKE_RANGES.

  PERFORM GET_DATA.



  IF GT_ORDER[] IS NOT INITIAL.

    PERFORM MODIFY_TABLE_FOR_PRINT USING GT_ORDER.

    CALL SCREEN 100.

  ELSEIF GT_DELIVERY[] IS NOT INITIAL.

    PERFORM MODIFY_TABLE_FOR_PRINT USING GT_DELIVERY.

    CALL SCREEN 200.

  ELSE.

    MESSAGE I000.

    EXIT.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ######

* T200 --> ######