
*&---------------------------------------------------------------------*

*& Report ZEDR07_019

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR07_019 MESSAGE-ID zmed07.



include
zedr07_019_TOP
.

include
zedr07_019_SCR
.

include
zedr07_019_F01
.

include
zedr07_019_O01
.

include
zedr07_019_I01
.



INITIALIZATION.

  PERFORM set_initial.



AT SELECTION-SCREEN OUTPUT.

  PERFORM set_screen.



START-OF-SELECTION.

  PERFORM get_data.



"BREAK-POINT.



  IF gt_student[] IS NOT INITIAL.

    CALL SCREEN 100.



  ELSE.

    MESSAGE I000.

    EXIT.

  ENDIF.