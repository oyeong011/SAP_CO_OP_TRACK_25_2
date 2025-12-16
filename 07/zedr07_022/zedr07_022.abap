
*&---------------------------------------------------------------------*

*& Report ZEDR07_022

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR07_022 MESSAGE-ID zedm07.



include
zedr07_022_cls
.

include
zedr07_022_top
.

include
zedr07_022_scr
.

include
zedr07_022_f01
.

include
zedr07_022_pbo
.

include
zedr07_022_pai
.



INITIALIZATION.

  PERFORM set_init.



START-OF-SELECTION.

  PERFORM get_data.

  PERFORM modity_data.



  IF gt_student[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I000.

    EXIT.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##########