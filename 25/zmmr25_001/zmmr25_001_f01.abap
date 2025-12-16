
*&---------------------------------------------------------------------*

*&  Include           ZMMR25_001_F01

*&---------------------------------------------------------------------*



*&---------------------------------------------------------------------*

*&      Form  INIT_DEFAULT_VALUES

*&---------------------------------------------------------------------*

*       Selection Screen ### ##

*----------------------------------------------------------------------*




FORM init_default_values .

  " ### ##

  p_bukrs = '1000'.       " ####

  p_ktokk = '1000'.       " ####

  p_lifnr = '1000000000'. " ###

ENDFORM.



FORM selection_screen .

  LOOP AT SCREEN.

    IF p_cre = c_x.

      IF screen-group1 = 'M2'.

        screen-active = 0.

      ENDIF.

    ELSEIF p_view = c_x.

      IF screen-group1 = 'M1'.

        screen-active = 0.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  PREPARE_CREATE_MODE

*&---------------------------------------------------------------------*

*       ## ## # ## LIFNR ## ##

*----------------------------------------------------------------------*




FORM prepare_create_mode .

  CLEAR : gv_lifnr, gv_name1, gv_land1, gv_stcd1, gv_stcd2, gv_stras,

          gv_akont, gv_zterm, gv_ekorg, gv_ekgrp, gv_waers, gv_mwskz.

  CLEAR : gt_alv.



  DATA : lv_max_lifnr TYPE zedt25_lfa1-lifnr.



  gv_ktokk = p_ktokk.

  gv_bukrs = p_bukrs.



  SELECT MAX( lifnr ) INTO lv_max_lifnr

    FROM zedt25_lfa1.



  IF lv_max_lifnr IS INITIAL.

    gv_lifnr = '1000000000'.

  ELSE.

    gv_lifnr = lv_max_lifnr + 1.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       ## ## ### ##

*----------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  CHECK_VENDOR_EXISTS

*&---------------------------------------------------------------------*




FORM CHECK_VENDOR_EXISTS.

  DATA: LV_LIFNR TYPE LIFNR.



  " #### ## #### ##### ##

  SELECT SINGLE LIFNR

    INTO LV_LIFNR

    FROM ZEDT25_LFA1

    WHERE LIFNR = P_LIFNR.



  IF SY-SUBRC <> 0.

    MESSAGE '## #### #### ####.' TYPE 'E'.

    RETURN.

  ENDIF.



  " #### ### ##### ##

  SELECT SINGLE LIFNR

    INTO LV_LIFNR

    FROM ZEDT25_LFB1

    WHERE LIFNR = P_LIFNR

      AND BUKRS = P_BUKRS.



  IF SY-SUBRC <> 0.

    MESSAGE '## #### #### ### #### ####.' TYPE 'E'.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*




FORM GET_DATA .

  " ## ## ###

  CLEAR : GT_ALV, GS_ALV.

  CLEAR : GV_LIFNR, GV_BUKRS, GV_KTOKK.

  CLEAR : GV_NAME1, GV_LAND1, GV_STCD1, GV_STCD2, GV_STRAS.

  CLEAR : GV_AKONT, GV_ZTERM, GV_EKORG, GV_EKGRP, GV_WAERS, GV_MWSKZ.



  SELECT SINGLE NAME1 LAND1 KTOKK STCD1 STCD2 STRAS

    INTO (GV_NAME1, GV_LAND1, GV_KTOKK, GV_STCD1, GV_STCD2, GV_STRAS)

    FROM ZEDT25_LFA1

  WHERE LIFNR = P_LIFNR.



  IF SY-SUBRC = 0.

    GV_LIFNR = P_LIFNR.

    GV_BUKRS = P_BUKRS.



    SELECT SINGLE AKONT ZTERM

      INTO (GV_AKONT, GV_ZTERM)

      FROM ZEDT25_LFB1

      WHERE LIFNR = P_LIFNR

      AND BUKRS = P_BUKRS.



    SELECT SINGLE EKORG EKGRP WAERS MWSKZ

      INTO (GV_EKORG, GV_EKGRP, GV_WAERS, GV_MWSKZ)

      FROM ZEDT25_LFM1

     WHERE LIFNR = P_LIFNR.



    " ALV ##### ## ## (####)

    GS_ALV-LIFNR = GV_LIFNR.

    GS_ALV-BUKRS = GV_BUKRS.

    GS_ALV-KTOKK = GV_KTOKK.

    GS_ALV-NAME1 = GV_NAME1.

    GS_ALV-LAND1 = GV_LAND1.

    GS_ALV-STCD1 = GV_STCD1.

    GS_ALV-STCD2 = GV_STCD2.

    GS_ALV-STRAS = GV_STRAS.

    GS_ALV-AKONT = GV_AKONT.

    GS_ALV-ZTERM = GV_ZTERM.

    GS_ALV-EKORG = GV_EKORG.

    GS_ALV-EKGRP = GV_EKGRP.

    GS_ALV-WAERS = GV_WAERS.

    GS_ALV-MWSKZ = GV_MWSKZ.

    APPEND GS_ALV TO GT_ALV.



  ELSE.

    MESSAGE '## #### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CHECK_PARAM

*&---------------------------------------------------------------------*

*       Selection Screen #### ##

*----------------------------------------------------------------------*




FORM check_param .

  IF p_bukrs IS INITIAL.

    MESSAGE '##### #####.' TYPE 'I'.

    STOP.

  ELSEIF p_ktokk IS INITIAL AND p_lifnr IS INITIAL.

    MESSAGE '#### ## #### #####.' TYPE 'I'.

    STOP.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CREATE_ALV_OBJECT

*&---------------------------------------------------------------------*

*       ALV ### # #### ## ##

*----------------------------------------------------------------------*




FORM create_alv_object .

  IF go_container IS INITIAL.

    CREATE OBJECT go_container

      EXPORTING

        container_name = 'CC_ALV'.



    CREATE OBJECT go_alv

      EXPORTING

        i_parent = go_container.



    " ### ### ##

    CREATE OBJECT go_handler.

    SET HANDLER go_handler->handler_data_changed FOR go_alv.



    " ## ##### ## ## (## ####)

    IF p_cre = c_x.

      CALL METHOD go_alv->register_edit_event

        EXPORTING

          i_event_id = cl_gui_alv_grid=>mc_evt_modified.

    ENDIF.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  BUILD_FIELDCATALOG

*&---------------------------------------------------------------------*

*       ALV ###### ##

*----------------------------------------------------------------------*




FORM build_fieldcatalog .

  CLEAR gt_fieldcat.



  " ## ##: ## ##, ## ##: ## ##

  DATA : lv_edit TYPE c.

  IF p_cre = c_x.

    lv_edit = 'X'.

  ELSE.

    lv_edit = ''.

  ENDIF.



  " # ## (## ## # ###)

  PERFORM add_fieldcat USING 'LIFNR' '###'   '10' 'X' ''.

  PERFORM add_fieldcat USING 'BUKRS' '####'     '6'  'X' ''.

  PERFORM add_fieldcat USING 'KTOKK' '####'   '8'  'X' ''.



  " #####

  PERFORM add_fieldcat USING 'NAME1' '####'     '15' ''  lv_edit.

  PERFORM add_fieldcat USING 'LAND1' '###'       '5'  ''  lv_edit.

  PERFORM add_fieldcat USING 'STRAS' '##'         '30' ''  lv_edit.

  PERFORM add_fieldcat USING 'STCD1' '####'     '16' ''  lv_edit.

  PERFORM add_fieldcat USING 'STCD2' '#####' '11' ''  lv_edit.



  " #####

  PERFORM add_fieldcat USING 'AKONT' '####'         '10' ''  lv_edit.

  PERFORM add_fieldcat USING 'ZTERM' '####'     '4'  ''  lv_edit.



  " #####

  PERFORM add_fieldcat USING 'EKORG' '####'     '4'  ''  lv_edit.

  PERFORM add_fieldcat USING 'EKGRP' '####'     '3'  ''  lv_edit.

  PERFORM add_fieldcat USING 'WAERS' '####' '5'  ''  lv_edit.

  PERFORM add_fieldcat USING 'MWSKZ' '####'     '2'  ''  lv_edit.



  " ##### ## STCD1/STCD2 ## ## ## ##

  LOOP AT GT_FIELDCAT INTO GS_FIELDCAT.

    " STCD1: 3000(##)## ##

    IF GS_FIELDCAT-FIELDNAME = 'STCD1'.

      IF GV_KTOKK = '3000'.

        GS_FIELDCAT-NO_OUT = ''.    " ##

      ELSE.

        GS_FIELDCAT-NO_OUT = 'X'.   " ##

      ENDIF.

      MODIFY GT_FIELDCAT FROM GS_FIELDCAT.

    ENDIF.



    " STCD2: 1000(##) ## 3000(##) # # ##

    IF GS_FIELDCAT-FIELDNAME = 'STCD2'.

      IF GV_KTOKK = '1000' OR GV_KTOKK = '3000'.

        GS_FIELDCAT-NO_OUT = ''.    " ##

      ELSE.

        GS_FIELDCAT-NO_OUT = 'X'.   " ##

      ENDIF.

      MODIFY GT_FIELDCAT FROM GS_FIELDCAT.

    ENDIF.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ADD_FIELDCAT

*&---------------------------------------------------------------------*

*       ###### ## ##

*----------------------------------------------------------------------*




FORM add_fieldcat USING pv_field    TYPE lvc_fname

                        pv_text     TYPE scrtext_l

                        pv_outputln TYPE char10

                        pv_key      TYPE c

                        pv_edit     TYPE c.



  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = pv_field.

  gs_fieldcat-coltext   = pv_text.

  gs_fieldcat-outputlen = pv_outputln.

  gs_fieldcat-key       = pv_key.

  gs_fieldcat-edit      = pv_edit.



  APPEND gs_fieldcat TO gt_fieldcat.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  BUILD_LAYOUT

*&---------------------------------------------------------------------*

*       ALV #### ##

*----------------------------------------------------------------------*




FORM build_layout .

  CLEAR gs_layout.

  gs_layout-zebra = 'X'.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  DISPLAY_ALV

*&---------------------------------------------------------------------*

*       ALV ### ##

*----------------------------------------------------------------------*




FORM display_alv .

  CALL METHOD go_alv->set_table_for_first_display

    EXPORTING

      is_layout       = gs_layout

    CHANGING

      it_outtab       = gt_alv

      it_fieldcatalog = gt_fieldcat.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  REFRESH_ALV

*&---------------------------------------------------------------------*

*       ALV ### ####

*----------------------------------------------------------------------*




FORM refresh_alv .

  IF go_alv IS NOT INITIAL.

    gs_stbl-row = 'X'.

    gs_stbl-col = 'X'.

    CALL METHOD go_alv->refresh_table_display

      EXPORTING

        is_stable = gs_stbl.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  REBUILD_ALV_LAYOUT

*&---------------------------------------------------------------------*

*       #### ## # ALV #### ###

*----------------------------------------------------------------------*




FORM REBUILD_ALV_LAYOUT .

  " ## #### ###

  PERFORM BUILD_FIELDCATALOG.



  " ALV# ## #### #### ###

  IF GO_ALV IS NOT INITIAL.

    CALL METHOD GO_ALV->SET_TABLE_FOR_FIRST_DISPLAY

      EXPORTING

        IS_LAYOUT       = GS_LAYOUT

      CHANGING

        IT_OUTTAB       = GT_ALV

        IT_FIELDCATALOG = GT_FIELDCAT.



    " ### ## ### ### ###

    IF GO_HANDLER IS NOT INITIAL.

      SET HANDLER GO_HANDLER->HANDLER_DATA_CHANGED FOR GO_ALV.

    ENDIF.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ADD_ROW_TO_ALV

*&---------------------------------------------------------------------*

*       ## #### ### #### ALV# ### ##

*----------------------------------------------------------------------*




FORM add_row_to_alv .

  DATA : lv_next_lifnr TYPE zedt25_lfa1-lifnr.



  IF gv_name1 IS INITIAL.

    MESSAGE '##### #####.' TYPE 'E'.

    EXIT.

  ENDIF.



  IF go_alv IS NOT INITIAL.

    CALL METHOD go_alv->check_changed_data.

  ENDIF.



  PERFORM get_next_lifnr CHANGING lv_next_lifnr.



  CLEAR gs_alv.

  gs_alv-lifnr = lv_next_lifnr.

  gs_alv-bukrs = gv_bukrs.

  gs_alv-ktokk = gv_ktokk.

  gs_alv-name1 = gv_name1.

  gs_alv-land1 = gv_land1.

  gs_alv-stcd1 = gv_stcd1.

  gs_alv-stcd2 = gv_stcd2.

  gs_alv-stras = gv_stras.

  gs_alv-akont = gv_akont.

  gs_alv-zterm = gv_zterm.

  gs_alv-ekorg = gv_ekorg.

  gs_alv-ekgrp = gv_ekgrp.

  gs_alv-waers = gv_waers.

  gs_alv-mwskz = gv_mwskz.



  APPEND gs_alv TO gt_alv.



  CLEAR : gv_name1, gv_land1, gv_stcd1, gv_stcd2, gv_stras,

          gv_akont, gv_zterm, gv_ekorg, gv_ekgrp, gv_waers, gv_mwskz.



  PERFORM refresh_alv.



  MESSAGE '## #######.' TYPE 'S'.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_NEXT_LIFNR

*&---------------------------------------------------------------------*

*       ## ### ## ##

*----------------------------------------------------------------------*




FORM get_next_lifnr CHANGING cv_lifnr TYPE zedt25_lfa1-lifnr.

  DATA : lv_max_db    TYPE zedt25_lfa1-lifnr,

         lv_max_alv   TYPE zedt25_lfa1-lifnr,

         lv_max_lifnr TYPE zedt25_lfa1-lifnr.



  SELECT MAX( lifnr ) INTO lv_max_db

    FROM zedt25_lfa1.



  CLEAR lv_max_alv.

  LOOP AT gt_alv INTO gs_alv.

    IF gs_alv-lifnr > lv_max_alv.

      lv_max_alv = gs_alv-lifnr.

    ENDIF.

  ENDLOOP.



  IF lv_max_db > lv_max_alv.

    lv_max_lifnr = lv_max_db.

  ELSE.

    lv_max_lifnr = lv_max_alv.

  ENDIF.



  IF lv_max_lifnr IS INITIAL.

    cv_lifnr = '1000000000'.

  ELSE.

    cv_lifnr = lv_max_lifnr + 1.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SAVE_ALL_DATA

*&---------------------------------------------------------------------*

*       ALV# ## ### ## ##

*----------------------------------------------------------------------*




FORM save_all_data .

  DATA : lv_error TYPE c.

  DATA : lt_alv_save LIKE gt_alv.



  " GT_ALV# #### (ALV ### ## ## ##)

  CLEAR lt_alv_save.

  LOOP AT gt_alv INTO gs_alv.

    APPEND gs_alv TO lt_alv_save.

  ENDLOOP.



  " ALV## ### ### ##

  IF go_alv IS NOT INITIAL.

    CALL METHOD go_alv->check_changed_data.



    " CHECK_CHANGED_DATA # ## GT_ALV# ### #### ##

    CLEAR lt_alv_save.

    LOOP AT gt_alv INTO gs_alv.

      APPEND gs_alv TO lt_alv_save.

    ENDLOOP.

  ENDIF.



  IF lt_alv_save IS INITIAL.

    MESSAGE '### #### ####.' TYPE 'E'.

    EXIT.

  ENDIF.



  CLEAR lv_error.



  LOOP AT lt_alv_save INTO gs_alv.

    DATA : lv_msg TYPE string.

    DATA : lv_row_error TYPE c.



    CLEAR lv_row_error.



    IF gs_alv-name1 IS INITIAL.

      CONCATENATE '###:' gs_alv-lifnr ': ##### #####.' INTO lv_msg SEPARATED BY space.

      MESSAGE lv_msg TYPE 'E'.

      lv_error = 'X'.

      lv_row_error = 'X'.

    ENDIF.



    IF lv_row_error = 'X'.

      CONTINUE.

    ENDIF.



    CLEAR zedt25_lfa1.

    zedt25_lfa1-mandt = sy-mandt.

    zedt25_lfa1-lifnr = gs_alv-lifnr.

    zedt25_lfa1-name1 = gs_alv-name1.

    zedt25_lfa1-land1 = gs_alv-land1.

    zedt25_lfa1-ktokk = gs_alv-ktokk.

    zedt25_lfa1-stcd1 = gs_alv-stcd1.

    zedt25_lfa1-stcd2 = gs_alv-stcd2.

    zedt25_lfa1-stras = gs_alv-stras.



    MODIFY zedt25_lfa1 FROM zedt25_lfa1.

    DATA : lv_modify_subrc TYPE i.

    DATA : lv_insert_subrc TYPE i.

    lv_modify_subrc = sy-subrc.

    IF sy-subrc <> 0.

      INSERT zedt25_lfa1 FROM zedt25_lfa1.

      lv_insert_subrc = sy-subrc.

      IF sy-subrc <> 0.

        DATA : lv_modify_subrc_str TYPE c LENGTH 10.

        DATA : lv_insert_subrc_str TYPE c LENGTH 10.

        WRITE lv_modify_subrc TO lv_modify_subrc_str.

        WRITE lv_insert_subrc TO lv_insert_subrc_str.

        CONCATENATE '###:' gs_alv-lifnr ': LFA1 ### ## ## (MODIFY:' lv_modify_subrc_str 'INSERT:' lv_insert_subrc_str ')' INTO lv_msg SEPARATED BY space.

        MESSAGE lv_msg TYPE 'E'.

        lv_error = 'X'.

        lv_row_error = 'X'.

      ENDIF.

    ENDIF.



    CLEAR zedt25_lfb1.

    zedt25_lfb1-mandt = sy-mandt.

    zedt25_lfb1-lifnr = gs_alv-lifnr.

    zedt25_lfb1-bukrs = gs_alv-bukrs.

    zedt25_lfb1-akont = gs_alv-akont.

    zedt25_lfb1-zterm = gs_alv-zterm.



    MODIFY zedt25_lfb1 FROM zedt25_lfb1.

    lv_modify_subrc = sy-subrc.

    IF sy-subrc <> 0.

      INSERT zedt25_lfb1 FROM zedt25_lfb1.

      lv_insert_subrc = sy-subrc.

      IF sy-subrc <> 0.

        WRITE lv_modify_subrc TO lv_modify_subrc_str.

        WRITE lv_insert_subrc TO lv_insert_subrc_str.

        CONCATENATE '###:' gs_alv-lifnr ': LFB1 ### ## ## (MODIFY:' lv_modify_subrc_str 'INSERT:' lv_insert_subrc_str ')' INTO lv_msg SEPARATED BY space.

        MESSAGE lv_msg TYPE 'E'.

        lv_error = 'X'.

        lv_row_error = 'X'.

      ENDIF.

    ENDIF.



    CLEAR zedt25_lfm1.

    zedt25_lfm1-mandt = sy-mandt.

    zedt25_lfm1-lifnr = gs_alv-lifnr.

    zedt25_lfm1-ekorg = gs_alv-ekorg.

    zedt25_lfm1-ekgrp = gs_alv-ekgrp.

    zedt25_lfm1-waers = gs_alv-waers.

    zedt25_lfm1-mwskz = gs_alv-mwskz.



    MODIFY zedt25_lfm1 FROM zedt25_lfm1.

    lv_modify_subrc = sy-subrc.

    IF sy-subrc <> 0.

      INSERT zedt25_lfm1 FROM zedt25_lfm1.

      lv_insert_subrc = sy-subrc.

      IF sy-subrc <> 0.

        WRITE lv_modify_subrc TO lv_modify_subrc_str.

        WRITE lv_insert_subrc TO lv_insert_subrc_str.

        CONCATENATE '###:' gs_alv-lifnr ': LFM1 ### ## ## (MODIFY:' lv_modify_subrc_str 'INSERT:' lv_insert_subrc_str ')' INTO lv_msg SEPARATED BY space.

        MESSAGE lv_msg TYPE 'E'.

        lv_error = 'X'.

        lv_row_error = 'X'.

      ENDIF.

    ENDIF.

  ENDLOOP.



  IF lv_error = 'X'.

    ROLLBACK WORK.

    MESSAGE '## ## ## ### ######. ## ### #####.' TYPE 'E'.

  ELSE.

    COMMIT WORK.

    MESSAGE '#### ##### #######.' TYPE 'S'.

    CLEAR gt_alv.

    PERFORM refresh_alv.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLE_DATA_CHANGED

*&---------------------------------------------------------------------*

*       ALV # ### ## ### ##

*----------------------------------------------------------------------*




FORM alv_handle_data_changed USING p_er TYPE REF TO cl_alv_changed_data_protocol.

  DATA : ls_mod TYPE lvc_s_modi.



  LOOP AT p_er->mt_good_cells INTO ls_mod.

    READ TABLE gt_alv INTO gs_alv INDEX ls_mod-row_id.

    IF sy-subrc <> 0.

      CONTINUE.

    ENDIF.



    " # ## (STRING -> CHAR)

    CASE ls_mod-fieldname.

      WHEN 'NAME1'. gs_alv-name1 = ls_mod-value.

      WHEN 'LAND1'. gs_alv-land1 = ls_mod-value.

      WHEN 'STCD1'. gs_alv-stcd1 = ls_mod-value.

      WHEN 'STCD2'. gs_alv-stcd2 = ls_mod-value.

      WHEN 'STRAS'. gs_alv-stras = ls_mod-value.

      WHEN 'AKONT'. gs_alv-akont = ls_mod-value.

      WHEN 'ZTERM'. gs_alv-zterm = ls_mod-value.

      WHEN 'EKORG'. gs_alv-ekorg = ls_mod-value.

      WHEN 'EKGRP'. gs_alv-ekgrp = ls_mod-value.

      WHEN 'WAERS'. gs_alv-waers = ls_mod-value.

      WHEN 'MWSKZ'. gs_alv-mwskz = ls_mod-value.

    ENDCASE.



    MODIFY gt_alv FROM gs_alv INDEX ls_mod-row_id.

  ENDLOOP.

ENDFORM.