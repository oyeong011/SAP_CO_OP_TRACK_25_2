
*&---------------------------------------------------------------------*

*& Report ZPRO11_003

*&---------------------------------------------------------------------*

*& ## ## # ## ####

*&---------------------------------------------------------------------*




REPORT ZPRO11_003.



include
zpro11_003_top
.

include
zpro11_003_cls
.

include
zpro11_003_scr
.

include
zpro11_003_pbo
.

include
zpro11_003_pai
.

include
zpro11_003_f01
.



INITIALIZATION.

  PERFORM init_default_values.



AT SELECTION-SCREEN OUTPUT.

  PERFORM control_screen_fields.



AT SELECTION-SCREEN.

  PERFORM check_po_validity.



START-OF-SELECTION.

  IF p_proc = 'X'.

    PERFORM load_po_data.

    CALL SCREEN 100.

  ELSE.

    PERFORM load_gr_history.

    CALL SCREEN 200.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* TTL_100 --> ######

* TTL_200 --> ######





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ## ##### ### ### #### ####.