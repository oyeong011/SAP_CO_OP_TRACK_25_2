
*&---------------------------------------------------------------------*

*& Report ZEDR022_PRACTICE008

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR022_PRACTICE008 MESSAGE-ID ZMED22_1.



include
ZEDR022_PRACTICE008_TOP
.

include
ZEDR022_PRACTICE008_SCR
.

include
ZEDR022_PRACTICE008_F01
.

include
ZEDR022_PRACTICE008_PBO
.

include
ZEDR022_PRACTICE008_PAI
.



INITIALIZATION.

  PERFORM SET_DATE.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SCREEN_CONTROL.



START-OF-SELECTION.

  PERFORM CHECK_DATA.

  PERFORM PROGRESS_DISPLAY USING 'Data ## #...'.



IF P_R1 = C_X.

  PERFORM GET_ORDER.

  PERFORM MODIFY_ORDER.



  IF GT_ORDER IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I001.

    EXIT.

  ENDIF.



ELSEIF P_R2 = C_X.

  PERFORM GET_DELIVERY.

  PERFORM MODIFY_DELIVERY.



  IF GT_DELIVERY IS NOT INITIAL.

    CALL SCREEN 200.

  ELSE.

    MESSAGE I001.

    EXIT.

  ENDIF.

ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ######

* T200 --> ######

* T100 --> ######

* T200 --> ######