
*&---------------------------------------------------------------------*

*& Report ZEDR06_PRACTICE008

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR06_PRACTICE008 MESSAGE-ID ZMED06.



include
ZEDR06_PRACTICE008_TOP
.

include
ZEDR06_PRACTICE008_SCR
.

include
ZEDR06_PRACTICE008_F01
.

include
ZEDR06_PRACTICE008_PBO
.

include
ZEDR06_PRACTICE008_PAI
.



INITIALIZATION.

  PERFORM DATA_INIT.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SCREEN_SETTING.



AT SELECTION-SCREEN.

  PERFORM DATA_VAILD_CHECK.



START-OF-SELECTION.

  IF P_R1 = C_X.

    PERFORM GET_ORDER_DATA.

    PERFORM MODIFY_ORDER_DATE.



    IF GT_ORDER[] IS NOT INITIAL.

      CALL SCREEN 100.

    ELSE.

      MESSAGE I001.

      EXIT.

    ENDIF.

  ELSEIF P_R2 = C_X.

    PERFORM GET_DELIVERY_DATA.

    PERFORM MODIFY_DELIVERY_DATA.



    IF GT_DELIVERY[] IS NOT INITIAL.

      CALL SCREEN 200.

    ELSE.

      MESSAGE I001.

    ENDIF.



  ENDIF.