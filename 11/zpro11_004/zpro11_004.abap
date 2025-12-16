
*&---------------------------------------------------------------------*

*& Report ZPRO11_004

*&---------------------------------------------------------------------*

*& ## ## # ## ####

*&---------------------------------------------------------------------*




REPORT ZPRO11_004.



include
zpro11_004_top
.

include
zpro11_004_scr
.

include
zpro11_004_f01
.

include
zpro11_004_pbo
.

include
zpro11_004_pai
.



INITIALIZATION.

  lbl_proc = '####'.

  lbl_disp = '####'.

  PERFORM init_default_date.



AT SELECTION-SCREEN OUTPUT.

  PERFORM control_screen_fields.



AT SELECTION-SCREEN.

  PERFORM check_po_validity.



START-OF-SELECTION.

  CASE abap_true.

    WHEN p_proc.

      PERFORM fetch_invoice_data.

      CALL SCREEN 100.

    WHEN p_disp.

      PERFORM load_search_data.

      CALL SCREEN 200.

  ENDCASE.






*GUI Texts

*----------------------------------------------------------

* TITLE_100 --> ######





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ### ##### ### ### #### ####.