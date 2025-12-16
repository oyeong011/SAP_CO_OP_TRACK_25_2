
*&---------------------------------------------------------------------*

*& Report ZEDR11_PRACTICE009

*&---------------------------------------------------------------------*




REPORT zedr11_practice009 MESSAGE-ID zmed11.



include
zedr11_practice009_top
.

include
zedr11_practice009_scr
.

include
zedr11_practice009_f01
.

include
zedr11_practice009_pbo
.

include
zedr11_practice009_pai
.



INITIALIZATION.

  PERFORM init_dates. " Form ## ##



START-OF-SELECTION.

  PERFORM check_input. " ## F01# # #### ###

  PERFORM show_progress USING '### ## #...'.



  PERFORM select_data.

  PERFORM process_data. " Form ## ## (Modify -> Process)



  IF gt_emp_m[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE i001 WITH '### #### ####.'.

    EXIT.

  ENDIF.