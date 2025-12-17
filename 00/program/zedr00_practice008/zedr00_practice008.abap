
*&---------------------------------------------------------------------*

*& Report ZEDR00_PRACTICE008

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR00_PRACTICE008 MESSAGE-ID ZMED00.



include
ZEDR00_PRACTICE008_TOP
.

include
ZEDR00_PRACTICE008_SCR
.

include
ZEDR00_PRACTICE008_F01
.

include
ZEDR00_PRACTICE008_PBO
.

include
ZEDR00_PRACTICE008_PAI
.



INITIALIZATION.

  PERFORM SET_DATE.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



START-OF-SELECTION.

  PERFORM CHECK_DATA.

  PERFORM PROGRESS_DISPLAY USING 'Data ## #...'. "### ### ##



  CASE C_X.

    WHEN P_R1. "####

      PERFORM SELECT_DATA_R1.

      PERFORM MODIFY_DATA_R1.

      IF GT_ORDER[] IS NOT INITIAL.

        CALL SCREEN 100.

      ELSE.

        MESSAGE I001.

        EXIT.

      ENDIF.

    WHEN P_R2. "####

      PERFORM SELECT_DATA_R2.

      PERFORM MODIFY_DATA_R2.

      IF GT_DELIVERY[] IS NOT INITIAL.

        CALL SCREEN 200.

      ELSE.

        MESSAGE I001.

        EXIT.

      ENDIF.

  ENDCASE.






*GUI Texts

*----------------------------------------------------------

* T100 --> ######

* T200 --> ######