
*&---------------------------------------------------------------------*

*& Report ZEDR12_PRACTICE008

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_PRACTICE008 MESSAGE-ID ZMED12.



include
ZEDR12_PRACTICE008_TOP
.

include
ZEDR12_PRACTICE008_SCR
.

include
ZEDR12_PRACTICE008_F01
.

include
ZEDR12_PRACTICE008_PBO
.

include
ZEDR12_PRACTICE008_PAI
.



INITIALIZATION.

  PERFORM SET_DATE.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



START-OF-SELECTION.

PERFORM CHECK_DATA.



  IF P_R1 = 'X'.

    PERFORM GET_DATA_R1.

    PERFORM MODIFY_DATA_R1.

    IF GT_OUT_ORDER[] IS NOT INITIAL.

      CALL SCREEN 100.

    ELSE.

      MESSAGE I000.

      EXIT.

    ENDIF.



  ELSEIF P_R2 = 'X'.

    PERFORM GET_DATA_R2.

    PERFORM MODIFY_DATA_R2.

    IF GT_OUT_DELIVERY[] IS NOT INITIAL.

      CALL SCREEN 200.

    ELSE.

      MESSAGE I000.

      EXIT.

    ENDIF.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ######

* T200 --> ######

* T100 --> ######

* T200 --> ######