
*&---------------------------------------------------------------------*

*& Report ZEDR04_PRACTICE008

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_PRACTICE008 MESSAGE-ID ZMED04.



include
ZEDR04_PRACTICE008_TOP
.

include
ZEDR04_PRACTICE008_SCR
.

include
ZEDR04_PRACTICE008_F01
.

include
ZEDR04_PRACTICE008_PBO
.

include
ZEDR04_PRACTICE008_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



START-OF-SELECTION.

  PERFORM CHECK_DATA.



  IF P_RD1 = C_X.   " ## ## ##

    PERFORM SELECT_DATA_R1.

    PERFORM MODIFY_DATA_R1.

    IF GT_WRITE_ORD[] IS NOT INITIAL.

      CALL SCREEN 100.

    ELSE.

      MESSAGE I001.

      EXIT.

    ENDIF.

  ELSE.             " #### ##

    PERFORM SELECT_DATA_R2.

    PERFORM MODIFY_DATA_R2.

    IF GT_WRITE_DEL[] IS NOT INITIAL.

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