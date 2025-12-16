
*&---------------------------------------------------------------------*

*& Report ZEDR07_018

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR07_018.



include
zedr07_018_top
.

include
zedr07_018_scr
.

include
zedr07_018_f01
.

include
zedr07_018_pbo
.

include
zedr07_018_pai
.



INITIALIZATION.

  PERFORM set_init.



START-OF-SELECTION.

  PERFORM get_data.



  CALL SCREEN 100.



  BREAK-POINT.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####