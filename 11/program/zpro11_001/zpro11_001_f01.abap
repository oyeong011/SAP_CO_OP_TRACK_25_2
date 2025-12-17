
*&---------------------------------------------------------------------*

*&  Include           ZPRO11_001_F01

*&---------------------------------------------------------------------*

*& #### ##

*&---------------------------------------------------------------------*



*&---------------------------------------------------------------------*

*&      Form  CONTROL_SCREEN_FIELDS

*&---------------------------------------------------------------------*

*       ## ## ## ###/#### ##

*----------------------------------------------------------------------*




FORM control_screen_fields.

  LOOP AT SCREEN.

    CASE screen-group1.

      WHEN 'MD1'.  "#####

        IF pa_rad1 EQ abap_true.  "## ##

          screen-active = 0.

        ELSE.  "## ##

          screen-active = 1.

        ENDIF.



      WHEN 'MD2'.  "#####

        IF pa_rad1 EQ abap_true.  "## ##

          screen-active = 1.

        ELSE.  "## ##

          screen-active = 0.

        ENDIF.



      WHEN 'ALL'.  "####

        screen-active = 1.  "## ##

    ENDCASE.



    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SAVE_VENDOR_DATA

*&---------------------------------------------------------------------*

*       ### ### ##

*----------------------------------------------------------------------*




FORM save_vendor_data.

  DATA: lv_error TYPE abap_bool.



  CLEAR: gs_general, gs_company, gs_purchase.

  lv_error = abap_false.



  "## ### ##

  PERFORM validate_required_fields CHANGING lv_error.



  IF lv_error EQ abap_true.

    MESSAGE '## #### #### #####.' TYPE 'E'.

  ENDIF.



  "ZPRO11_001 ### ### ##

  gs_general-lifnr = gv_lifnr.

  gs_general-name1 = gv_name1.

  gs_general-land1 = gv_land1.

  gs_general-ktokk = gv_ktokk.

  gs_general-stcd1 = gv_stcd1.

  gs_general-stcd2 = gv_stcd2.

  gs_general-stras = gv_stras.



  "## #### ##

  APPEND gs_general TO gt_general.



  "DB ##

  MODIFY zpro11_001 FROM gs_general.

  IF sy-subrc NE 0.

    INSERT zpro11_001 FROM gs_general.

  ENDIF.



  "ZPRO11_002 ### ### ##

  gs_company-lifnr = gv_lifnr.

  gs_company-bukrs = gv_bukrs.

  gs_company-akont = gv_akont.

  gs_company-zterm = gv_zterm.



  "## #### ##

  APPEND gs_company TO gt_company.



  "DB ##

  MODIFY zpro11_002 FROM gs_company.

  IF sy-subrc NE 0.

    INSERT zpro11_002 FROM gs_company.

  ENDIF.



  "ZPRO11_003 ### ### ##

  gs_purchase-lifnr = gv_lifnr.

  gs_purchase-ekorg = gv_ekorg.

  gs_purchase-ekgrp = gv_ekgrp.

  gs_purchase-waers = gv_waers.

  gs_purchase-mwskz = gv_mwskz.



  "## #### ##

  APPEND gs_purchase TO gt_purchase.



  "DB ##

  MODIFY zpro11_003 FROM gs_purchase.

  IF sy-subrc NE 0.

    INSERT zpro11_003 FROM gs_purchase.

  ENDIF.



  MESSAGE '#### ##### #######.' TYPE 'S'.



  LEAVE TO SCREEN 0.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  VALIDATE_REQUIRED_FIELDS

*&---------------------------------------------------------------------*

*       ## ### ##

*----------------------------------------------------------------------*




FORM validate_required_fields CHANGING cv_error TYPE abap_bool.

  "###### ## ### ##

  CASE gv_ktokk.

    WHEN '2000'.

      "####, ##### ###

      IF gv_lifnr IS INITIAL OR gv_name1 IS INITIAL OR

         gv_land1 IS INITIAL OR gv_stras IS INITIAL.

        cv_error = abap_true.

      ENDIF.



    WHEN '3000'.

      "####, ##### ## ##

      IF gv_lifnr IS INITIAL OR gv_name1 IS INITIAL OR

         gv_land1 IS INITIAL OR gv_stcd1 IS INITIAL OR

         gv_stcd2 IS INITIAL OR gv_stras IS INITIAL.

        cv_error = abap_true.

      ENDIF.



    WHEN OTHERS.

      "###### ##

      IF gv_lifnr IS INITIAL OR gv_name1 IS INITIAL OR

         gv_land1 IS INITIAL OR gv_stcd2 IS INITIAL OR

         gv_stras IS INITIAL.

        cv_error = abap_true.

      ENDIF.

  ENDCASE.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CALCULATE_NEXT_LIFNR

*&---------------------------------------------------------------------*

*       ## ##### ## ##

*----------------------------------------------------------------------*




FORM calculate_next_lifnr.

  DATA: lv_max_lifnr TYPE zpro11_001-lifnr.



  SELECT MAX( lifnr )

    INTO lv_max_lifnr

    FROM zpro11_001.



  IF lv_max_lifnr IS INITIAL.

    gv_lifnr = '1000000000'.

  ELSE.

    gv_lifnr = lv_max_lifnr + 1.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CHECK_VENDOR_GROUP

*&---------------------------------------------------------------------*

*       ##### ### ##

*----------------------------------------------------------------------*




FORM check_vendor_group.

  DATA: lv_check TYPE dd07v-domvalue_l.



  IF pa_rad1 EQ abap_true.

    SELECT SINGLE domvalue_l

      INTO lv_check

      FROM dd07v

      WHERE domname    = 'ZKTOKK11'

        AND domvalue_l = pa_ktokk.



    IF sy-subrc NE 0.

      MESSAGE '#### ## ########. ### Fixed Value# #####.' TYPE 'I'.

      LEAVE SCREEN.

    ENDIF.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Module  SET_ALV  OUTPUT

*&---------------------------------------------------------------------*

*       ALV Grid ## # ##

*----------------------------------------------------------------------*




MODULE set_alv OUTPUT.

  IF go_docking IS INITIAL.

    PERFORM init_alv_container.

    PERFORM build_fieldcatalog.

    PERFORM set_alv_layout.

    PERFORM set_alv_sort.

    PERFORM register_alv_events.

    PERFORM display_alv_grid.

  ELSE.

    PERFORM refresh_alv_display.

  ENDIF.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Form  INIT_ALV_CONTAINER

*&---------------------------------------------------------------------*

*       ALV #### # Grid #### ##

*----------------------------------------------------------------------*




FORM init_alv_container.

  CREATE OBJECT go_docking

    EXPORTING

      repid     = sy-repid

      dynnr     = sy-dynnr

      extension = 2000.



  CREATE OBJECT go_alv_grid

    EXPORTING

      i_parent = go_docking.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  BUILD_FIELDCATALOG

*&---------------------------------------------------------------------*

*       ## #### ##

*----------------------------------------------------------------------*




FORM build_fieldcatalog.

  CLEAR: gs_fcat, gt_fcat.



  "#####

  gs_fcat-col_pos   = 1.

  gs_fcat-fieldname = 'LIFNR'.

  gs_fcat-coltext   = '#####'.

  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.



  "####

  gs_fcat-col_pos   = 2.

  gs_fcat-fieldname = 'NAME1'.

  gs_fcat-coltext   = '####'.

  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.



  "####

  gs_fcat-col_pos   = 3.

  gs_fcat-fieldname = 'BUKRS'.

  gs_fcat-coltext   = '####'.

  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.



  "##### (## ##)

  gs_fcat-col_pos   = 4.

  gs_fcat-fieldname = 'STCD2'.

  gs_fcat-coltext   = '#####'.

  gs_fcat-edit      = abap_true.

  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.



  "##

  gs_fcat-col_pos   = 5.

  gs_fcat-fieldname = 'LAND1'.

  gs_fcat-coltext   = '##'.

  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.



  "##

  gs_fcat-col_pos   = 6.

  gs_fcat-fieldname = 'STRAS'.

  gs_fcat-coltext   = '##'.

  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SET_ALV_LAYOUT

*&---------------------------------------------------------------------*

*       ALV #### ##

*----------------------------------------------------------------------*




FORM set_alv_layout.

  CLEAR gs_variant.

  gs_variant-report   = sy-repid.

  gs_variant-username = sy-uname.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SET_ALV_SORT

*&---------------------------------------------------------------------*

*       ALV ## ##

*----------------------------------------------------------------------*




FORM set_alv_sort.

  "## ## ## (### ##)

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  REGISTER_ALV_EVENTS

*&---------------------------------------------------------------------*

*       ALV ### ### ##

*----------------------------------------------------------------------*




FORM register_alv_events.

  CREATE OBJECT go_handler.



  SET HANDLER go_handler->on_data_changed FOR go_alv_grid.



  CALL METHOD go_alv_grid->register_edit_event

    EXPORTING

      i_event_id = cl_gui_alv_grid=>mc_evt_modified.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  DISPLAY_ALV_GRID

*&---------------------------------------------------------------------*

*       ALV Grid ## ##

*----------------------------------------------------------------------*




FORM display_alv_grid.

  CALL METHOD go_alv_grid->set_table_for_first_display

    EXPORTING

      is_variant  = gs_variant

      i_save      = 'A'

      is_layout   = gs_layout

    CHANGING

      it_outtab       = gt_display

      it_fieldcatalog = gt_fcat

      it_sort         = gt_sort.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  REFRESH_ALV_DISPLAY

*&---------------------------------------------------------------------*

*       ALV Grid ####

*----------------------------------------------------------------------*




FORM refresh_alv_display.

  DATA: ls_stable TYPE lvc_s_stbl.



  ls_stable-row = abap_true.

  ls_stable-col = abap_true.



  CALL METHOD go_alv_grid->refresh_table_display

    EXPORTING

      is_stable = ls_stable.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SELECT_VENDOR_DATA

*&---------------------------------------------------------------------*

*       ### ### ##

*----------------------------------------------------------------------*




FORM select_vendor_data.

  CLEAR gt_display.



  SELECT a~lifnr a~name1 a~stcd2 a~stras a~land1 b~bukrs

    INTO CORRESPONDING FIELDS OF TABLE gt_display

    FROM zpro11_001 AS a

    INNER JOIN zpro11_002 AS b

      ON a~lifnr EQ b~lifnr

    WHERE a~lifnr EQ pa_lifnr

      AND b~bukrs EQ pa_bukrs.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  HANDLE_ALV_DATA_CHANGED

*&---------------------------------------------------------------------*

*       ALV ### ## ### ##

*----------------------------------------------------------------------*




FORM handle_alv_data_changed

  USING pv_data_changed TYPE REF TO cl_alv_changed_data_protocol

        pv_onf4

        pv_onf4_before

        pv_onf4_after

        pv_ucomm.



  DATA: ls_modi TYPE lvc_s_modi.



  LOOP AT pv_data_changed->mt_good_cells INTO ls_modi.

    IF ls_modi-fieldname EQ 'STCD2'.

      READ TABLE gt_display INTO gs_display INDEX ls_modi-row_id.

      IF sy-subrc EQ 0.

        MODIFY gt_display FROM gs_display INDEX ls_modi-row_id.

      ENDIF.

      CLEAR gs_display.

    ENDIF.

  ENDLOOP.



  PERFORM refresh_alv_display.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  UPDATE_VENDOR_DATA

*&---------------------------------------------------------------------*

*       ### ### ####

*----------------------------------------------------------------------*




FORM update_vendor_data.

  DATA: ls_update TYPE zpro11_001,

        lt_update TYPE TABLE OF zpro11_001.



  LOOP AT gt_display INTO gs_display.

    CLEAR ls_update.



    "## DB ### ##

    SELECT SINGLE *

      FROM zpro11_001

      INTO ls_update

      WHERE lifnr EQ gs_display-lifnr.



    IF sy-subrc EQ 0.

      "### ## ##

      MOVE-CORRESPONDING gs_display TO ls_update.

      APPEND ls_update TO lt_update.

    ENDIF.

  ENDLOOP.



  "DB ####

  IF lt_update IS NOT INITIAL.

    MODIFY zpro11_001 FROM TABLE lt_update.



    IF sy-subrc EQ 0.

      MESSAGE '### #######.' TYPE 'I'.

    ELSE.

      MESSAGE '## # ### ######.' TYPE 'I'.

    ENDIF.

  ENDIF.

ENDFORM.