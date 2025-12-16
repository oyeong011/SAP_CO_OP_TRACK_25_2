
*&---------------------------------------------------------------------*

*& Report ZPRO11_002

*&---------------------------------------------------------------------*

*& #### ##/## ####

*&---------------------------------------------------------------------*




REPORT ZPRO11_002.



include
zpro11_002_cls
.

include
zpro11_002_top
.

include
zpro11_002_scr
.

include
zpro11_002_f01
.

include
zpro11_002_pbo
.

include
zpro11_002_pai
.



AT SELECTION-SCREEN.

  IF p_rad1 = 'X'.

    PERFORM check_bukrs.

    PERFORM check_bedat.

  ELSEIF p_rad2 = 'X'.

    PERFORM check_ebeln.

  ENDIF.



AT SELECTION-SCREEN OUTPUT.

  PERFORM control_screen.



START-OF-SELECTION.

  IF p_rad1 = 'X'.

    CALL SCREEN 100.

  ELSE.

    PERFORM select_data.

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