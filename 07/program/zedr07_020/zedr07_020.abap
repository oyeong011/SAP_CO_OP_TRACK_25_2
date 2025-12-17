
*&---------------------------------------------------------------------*

*& Report ZEDR07_020

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR07_020 MESSAGE-ID zmed07.



include
zedr07_020_top
.

include
zedr07_020_scr
.

include
zedr07_020_f01
.

include
zedr07_020_o01
.

include
zedr07_020_i01
.



INITIALIZATION.

  PERFORM set_init. "## ##



AT SELECTION-SCREEN OUTPUT.

  PERFORM set_screen.



START-OF-SELECTION.

  PERFORM get_data.



START-OF-SELECTION.

  IF s_zcode IS INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I000.

    EXIT.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####