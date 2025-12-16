
*&---------------------------------------------------------------------*

*& Report ZMM11_002

*&---------------------------------------------------------------------*




REPORT zmm11_002 MESSAGE-ID zm00.



include
zmm11_002_top
.    " ## ##

include
zmm11_002_cls
.    " ###

include
zmm11_002_scr
.    " ###

include
zmm11_002_pbo
.    " PBO

include
zmm11_002_pai
.    " PAI

include
zmm11_002_f01
.    " FORM



" [###] #### ## # ### ## ##

INITIALIZATION.

  gv_title = '## ##'.

  gv_text1 = '##'.

  gv_text2 = '##'.



AT SELECTION-SCREEN.

  CASE abap_true.

    WHEN rb_new.

      PERFORM check_master_data.

      PERFORM check_date_validity.

    WHEN rb_inq.

      PERFORM check_po_existence.

  ENDCASE.



AT SELECTION-SCREEN OUTPUT.

  PERFORM modify_screen_attributes.



START-OF-SELECTION.

  IF rb_new = abap_true.

    CALL SCREEN 100.

  ELSE.

    PERFORM select_po_data.

    CALL SCREEN 200.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ######





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##### ### ### #### ####.