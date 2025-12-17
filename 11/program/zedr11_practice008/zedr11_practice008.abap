
*&---------------------------------------------------------------------*

*& Report ZEDR11_PRACTICE008

*&---------------------------------------------------------------------*




REPORT ZEDR11_PRACTICE008 MESSAGE-ID ZMED11.



include
ZEDR11_PRACTICE008_TOP
.

include
ZEDR11_PRACTICE008_SCR
.

include
ZEDR11_PRACTICE008_F01
.

include
ZEDR11_PRACTICE008_PBO
.

include
ZEDR11_PRACTICE008_PAI
.



INITIALIZATION.

  PERFORM set_date.



AT SELECTION-SCREEN OUTPUT.

  PERFORM set_screen.



START-OF-SELECTION.

  PERFORM check_data.

  PERFORM progress_display USING 'Data ## #...'.



  CASE c_x.

    WHEN p_r1. "####

      PERFORM select_r1.   " <-- ### (#: select_data_r1)

      PERFORM modify_r1.   " <-- ### (#: modify_data_r1)

      IF gt_order[] IS NOT INITIAL.

        CALL SCREEN 100.

      ELSE.

        MESSAGE I001 WITH '#### ####.'.

        EXIT.

      ENDIF.



    WHEN p_r2. "####

      PERFORM select_r2.   " <-- ### (#: select_data_r2)

      PERFORM modify_r2.   " <-- ### (#: modify_data_r2)

      " [##] #### gt_delivery -> gt_deli # ###

      IF gt_deli[] IS NOT INITIAL.

        CALL SCREEN 200.

      ELSE.

        MESSAGE I001 WITH '#### ####.'.

        EXIT.

      ENDIF.

  ENDCASE.