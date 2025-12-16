
*&---------------------------------------------------------------------*

*& Report ZEDR07_PRACTICE008

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR07_PRACTICE008 MESSAGE-ID zmed07.



include
ZEDR07_PRACTICE008_TOP
.

include
ZEDR07_PRACTICE008_SCR
.

include
ZEDR07_PRACTICE008_F01
.

include
ZEDR07_PRACTICE008_PBO
.

include
ZEDR07_PRACTICE008_PAI
.



INITIALIZATION.

  PERFORM set_date.



AT SELECTION-SCREEN OUTPUT.

  PERFORM set_screen.



START-OF-SELECTION.

  PERFORM check_data.

  PERFORM progress_display USING 'Data ## #...'. "## # ### ##



  CASE c_x.

    WHEN p_r1.

      PERFORM select_r1.

      PERFORM modify_r1.

      IF gt_order[] IS NOT INITIAL.

        CALL SCREEN 100.

      ELSE.

        MESSAGE I001.

        EXIT.

      ENDIF.

    WHEN p_r2.

      PERFORM select_r2.

      PERFORM modify_r2.

      IF gt_deli[] IS NOT INITIAL.

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

* T100 --> ######

* T200 --> ######