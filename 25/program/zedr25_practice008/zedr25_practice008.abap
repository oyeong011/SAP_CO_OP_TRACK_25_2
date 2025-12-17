
*&---------------------------------------------------------------------*

*& Report ZEDR25_PRACTICE008

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR25_PRACTICE008 MESSAGE-ID ZMED25.



include
ZEDR25_PRACTICE008_TOP
.

include
ZEDR25_PRACTICE008_SCR
.

include
ZEDR25_PRACTICE008_F01
.

include
ZEDR25_PRACTICE008_PBO
.

include
ZEDR25_PRACTICE008_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



START-OF-SELECTION.

  PERFORM CHECK_DATA.

  PERFORM PROGRESS_DISPLAY USING '## #...'.



  IF P_R1 = C_X.

    PERFORM SELECT_DATA_R1.

    PERFORM MODIFY_DATA_R1.

    IF GT_0100[] IS NOT INITIAL.

      CALL SCREEN 100.

    ELSE.

      MESSAGE I001 WITH '## ### ##'.

      EXIT.

    ENDIF.

  ELSEIF P_R2 = C_X.

    PERFORM SELECT_DATA_R2.

    PERFORM MODIFY_DATA_R2.

    IF GT_0200[] IS NOT INITIAL.

      CALL SCREEN 200.

    ELSE.

      MESSAGE I001 WITH '## ### ##'.

      EXIT.

    ENDIF.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ######

* T200 --> ######

* T100 --> ######

* T200 --> ######