
*&---------------------------------------------------------------------*

*& Report ZEDR07_PRACTICE009

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR07_PRACTICE009 MESSAGE-ID zmed07.



include
zedr07_practice009_top
.

include
zedr07_practice009_scr
.

include
zedr07_practice009_f01
.

include
zedr07_practice009_pbo
.

include
zedr07_practice009_pai
.



INITIALIZATION.

  PERFORM set_date.



START-OF-SELECTION.

  PERFORM check_data.

  PERFORM progress_data USING 'Data ## #...'.



  PERFORM select_data.

  PERFORM modify_data.



  IF gt_emp[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I001.

    EXIT.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> #######

* T100 --> #######