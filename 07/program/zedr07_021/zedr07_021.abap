
*&---------------------------------------------------------------------*

*& Report ZEDR07_021

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR07_021 MESSAGE-ID zmed07.



  include
zedr07_021_top
.

  include
zedr07_021_scr
.

  include
zedr07_021_f01
.

  include
zedr07_021_o01
.

  include
zedt07_020_i01
.



  INITIALIZATION.

    PERFORM set_init.



  AT SELECTION-SCREEN OUTPUT.

    PERFORM set_screen.



  START-OF-SELECTION.

    PERFORM get_data.



  IF gt_student[] IS NOT INITIAL.

    CALL SCREEN 100.



  ELSE.

    MESSAGE I000.

    EXIT.

  ENDIF.