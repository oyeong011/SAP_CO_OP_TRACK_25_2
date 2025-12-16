
*&---------------------------------------------------------------------*

*& Report ZPRO07_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZPRO07_002.



include
zpro07_002_cls
.

include
zpro07_002_top
.

include
zpro07_002_scr
.

include
zpro07_002_f01
.

include
zpro07_002_pbo
.

include
zpro07_002_pai
.



AT SELECTION-SCREEN.

  IF p_rad1 = 'X'.

    PERFORM verify_burks.




*    PERFORM verify_bedat.






  ELSEIF p_rad2 = 'X'.

    PERFORM verify_ebeln.



  ENDIF.



AT SELECTION-SCREEN OUTPUT.

  PERFORM set_screen.



START-OF-SELECTION.

  IF p_rad1 = 'X'.

    CALL SCREEN 100.

  ELSE.

    PERFORM get_data.

    CALL SCREEN 200.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ######

* T200 --> ######





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ### ## #####.