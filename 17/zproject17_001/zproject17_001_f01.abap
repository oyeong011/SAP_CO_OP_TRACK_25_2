
*&---------------------------------------------------------------------*

*&  Include           ZPROJECT17_001_F01

*&---------------------------------------------------------------------*



*---------------------------------------------------------------------*

* ### ##

*---------------------------------------------------------------------*




FORM init_selection.



  " ## ### '### ##'

  p_cre  = 'X'.

  p_disp = ''.



  gv_cre_active_flag  = '1'.

  gv_disp_active_flag = '0'.



  " ### ### ###

  p_bukrs = '1000'.

  p_ktokk = '1000000000'.



  " ### ### ###

  p_lifnr = '1000000000'.

  p_qbuk = '1000'.



ENDFORM.




*---------------------------------------------------------------------*

* selection-screen ## ## ## (### 2# ##)

*---------------------------------------------------------------------*




FORM check_selection.



  " ## ## : #### / ##### ##

  IF gv_mode = c_mode_create.



    IF p_bukrs IS INITIAL OR p_ktokk IS INITIAL.

      MESSAGE '## ##: ####/###### ## #####.' TYPE 'E'.

    ENDIF.



  " ## ## : ##### / ####(###) ##

  ELSEIF gv_mode = c_mode_disp.



    IF p_lifnr IS INITIAL OR p_qbuk IS INITIAL.

      MESSAGE '## ##: #####/##### ## #####.' TYPE 'E'.

    ENDIF.



  ENDIF.



ENDFORM.






*---------------------------------------------------------------------*

* SELECTION-SCREEN OUTPUT ##

*---------------------------------------------------------------------*




FORM selection_screen_control.



  " ###### ## ## ###

  IF p_cre = 'X'.

    gv_cre_active_flag  = '1'.

    gv_disp_active_flag = '0'.

  ELSEIF p_disp = 'X'.

    gv_cre_active_flag  = '0'.

    gv_disp_active_flag = '1'.

  ENDIF.



  " MODIF ID# ## ##/###

  LOOP AT SCREEN.

    IF screen-group1 = 'C1'.

      screen-active = gv_cre_active_flag.

    ELSEIF screen-group1 = 'C2'.

      screen-active = gv_disp_active_flag.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



ENDFORM.






*---------------------------------------------------------------------*

* ## ## (## / ##)

*---------------------------------------------------------------------*




FORM determine_mode.



  IF p_cre = 'X'.

    gv_mode = c_mode_create.

  ELSEIF p_disp = 'X'.

    gv_mode = c_mode_disp.

  ELSE.

    gv_mode = c_mode_create.

  ENDIF.



ENDFORM.






*---------------------------------------------------------------------*

* ## ## ## (## ##)

*---------------------------------------------------------------------*




FORM run_display_mode.



  PERFORM get_data_display.



  IF gt_vend_cre IS INITIAL.

    MESSAGE '## ### #### ####.' TYPE 'S'.

    EXIT.

  ENDIF.



  CALL SCREEN 0100.



ENDFORM.




*---------------------------------------------------------------------*

* ## ### ### ##

*---------------------------------------------------------------------*




FORM get_data_display.



  CLEAR gt_vend_cre.

  CLEAR gs_vend_cre.



  SELECT a~lifnr

         b~bukrs

         a~ktokk

         a~name1

         a~land1

         a~stcd1

         a~stcd2

         a~stras

         b~akont

         b~zterm

         c~ekorg

         c~ekgrp

         c~waers

         c~mwskz

    INTO TABLE gt_vend_cre

    FROM zedt17_lfa1 AS a

    INNER JOIN zedt17_lfb1 AS b

      ON a~lifnr = b~lifnr

    INNER JOIN zedt17_lfm1 AS c

      ON a~lifnr = c~lifnr

   WHERE a~lifnr = p_lifnr

     AND b~bukrs = p_qbuk.



  "#### #### ## ## ## (KTOKK=2000## ##)

  CLEAR gv_disp_hide_save.



  READ TABLE gt_vend_cre INTO gs_vend_cre INDEX 1.

  IF sy-subrc = 0.

    IF gs_vend_cre-ktokk = '2000'.

      gv_disp_hide_save = 'X'.

    ENDIF.

  ENDIF.





ENDFORM.










*---------------------------------------------------------------------*

* ## ### ### ###

*---------------------------------------------------------------------*




FORM init_data_create.



  CLEAR gt_vend_cre.

  CLEAR gs_vend_cre.



  gs_vend_cre-bukrs = p_bukrs.

  gs_vend_cre-ktokk = p_ktokk.



  APPEND gs_vend_cre TO gt_vend_cre.



ENDFORM.






*---------------------------------------------------------------------*

* #### + ALV #### ##

*---------------------------------------------------------------------*




FORM create_object.



  IF go_container IS INITIAL.



    CREATE OBJECT go_container

      EXPORTING

        container_name = 'CC_ALV'.



    CREATE OBJECT go_alv

      EXPORTING

        i_parent = go_container.



  ENDIF.



ENDFORM.






*---------------------------------------------------------------------*

* ###### Wrapper

*---------------------------------------------------------------------*




FORM field_catalog_create.



  PERFORM build_fieldcatalog_create.



ENDFORM.






*---------------------------------------------------------------------*

* #### Wrapper

*---------------------------------------------------------------------*




FORM alv_layout_create.



  PERFORM build_layout_create.



ENDFORM.






*---------------------------------------------------------------------*

* ### ### ##

*---------------------------------------------------------------------*




FORM class_event_create.



  IF go_handler IS INITIAL.

    CREATE OBJECT go_handler.

    SET HANDLER go_handler->handler_data_changed FOR go_alv.

    SET HANDLER go_handler->on_toolbar          FOR go_alv.

    SET HANDLER go_handler->on_user_command     FOR go_alv.



  ENDIF.



ENDFORM.






*---------------------------------------------------------------------*

* ALV ## #####

*---------------------------------------------------------------------*




FORM alv_display_create.



  CALL METHOD go_alv->set_table_for_first_display

    EXPORTING

      is_layout       = gs_layout

    CHANGING

      it_outtab       = gt_vend_cre

      it_fieldcatalog = gt_fieldcat.



ENDFORM.






*---------------------------------------------------------------------*

* ALV ####

*---------------------------------------------------------------------*




FORM refresh_alv_create.



  IF go_alv IS NOT INITIAL.

    gs_stbl-row = 'X'.

    gs_stbl-col = 'X'.

    CALL METHOD go_alv->refresh_table_display

      EXPORTING

        is_stable = gs_stbl.

  ENDIF.



ENDFORM.






*---------------------------------------------------------------------*

* ###### ## (## ##)

*---------------------------------------------------------------------*




FORM build_fieldcatalog_create. " fieldcat ## # #### ## ### perform# ## using## ####~



  CLEAR gt_fieldcat.

  " ###, #####, ###, key##, ######

  PERFORM add_fcat USING 'LIFNR' '#####' '10' 'X' ''.

  PERFORM add_fcat USING 'BUKRS' '####' '6' 'X' ''.

  PERFORM add_fcat USING 'KTOKK' '#####' '8' 'X' ''. " ### (## X)

  PERFORM add_fcat USING 'NAME1' '####' '15' '' 'X'.

  PERFORM add_fcat USING 'LAND1' '###' '5' '' 'X'.

  PERFORM add_fcat USING 'STCD1' '####' '6' '' 'X'.

  PERFORM add_fcat USING 'STCD2' '#####' '10' '' 'X'.

  PERFORM add_fcat USING 'STRAS' '##' '30' '' 'X'.

  PERFORM add_fcat USING 'AKONT' '##' '10' '' 'X'.

  PERFORM add_fcat USING 'ZTERM' '####' '6'  '' 'X'.

  PERFORM add_fcat USING 'EKORG' '####' '6' '' 'X'.

  PERFORM add_fcat USING 'EKGRP' '####' '6' '' 'X'.

  PERFORM add_fcat USING 'WAERS' '##' '5' '' 'X'.

  PERFORM add_fcat USING 'MWSKZ' '####' '6' ''  'X'.



  " ## ### # #####(LIFNR) ## ##

  IF gv_mode = c_mode_create.



    LOOP AT gt_fieldcat INTO gs_fieldcat.

      IF gs_fieldcat-fieldname = 'LIFNR'.

        gs_fieldcat-no_out = 'X'.

        MODIFY gt_fieldcat FROM gs_fieldcat.

        EXIT.

      ENDIF.

    ENDLOOP.



  ENDIF.



  " ##### STCD1 / STCD2 ## ##

  " #### ## -> LFA1-STCD1(##),

  " LFA1-STCD2(##) #### 3000 -> LFA1-STCD1(##)

  " LFA1-STCD2(##) #### 2000 -> LFA1-STCD1(##) , LFA1-STCD2(##)

  LOOP AT gt_fieldcat INTO gs_fieldcat.



    " ####(STCD1)

    IF gs_fieldcat-fieldname = 'STCD1'.



      IF p_ktokk = '3000'.

        gs_fieldcat-no_out = ''.     " 3000 -> ##

      ELSE.

        gs_fieldcat-no_out = 'X'.    " ##, 2000 -> ##

      ENDIF.



      MODIFY gt_fieldcat FROM gs_fieldcat.

      CONTINUE.

    ENDIF.



    " #####(STCD2)

    IF gs_fieldcat-fieldname = 'STCD2'.



      IF p_ktokk = '2000'.

        gs_fieldcat-no_out = 'X'.    " 2000 -> ##

      ELSE.

        gs_fieldcat-no_out = ''.     " ##, 3000 -> ##

      ENDIF.



      MODIFY gt_fieldcat FROM gs_fieldcat.

      CONTINUE.

    ENDIF.



  ENDLOOP.



  DATA: lv_ktokk TYPE zedt17_lfa1-ktokk.



  CLEAR lv_ktokk.

  READ TABLE gt_vend_cre INTO gs_vend_cre INDEX 1.

  IF sy-subrc = 0.

    lv_ktokk = gs_vend_cre-ktokk.

  ENDIF.





  " ## ### ## #####(STCD2)# ## #### ##

  IF gv_mode = c_mode_disp.



    LOOP AT gt_fieldcat INTO gs_fieldcat.



      IF gs_fieldcat-fieldname = 'STCD2'.




*        gs_fieldcat-edit = 'X'.    " ###### ## ##




        IF lv_ktokk = '2000'.

          gs_fieldcat-no_out = 'X'.  "2000## ##### ## ##

          gs_fieldcat-edit   = ''.   "## ## ### OFF

        ELSE.

          gs_fieldcat-no_out = ''.   "# ### ##

          gs_fieldcat-edit   = 'X'.  "#### STCD2# ## ##

        ENDIF.



      ELSE.

        gs_fieldcat-edit = ''.     " ### ### ## ##

      ENDIF.



      MODIFY gt_fieldcat FROM gs_fieldcat.



    ENDLOOP.



  ENDIF.





ENDFORM.






*---------------------------------------------------------------------*

* ###### # # ## ## FORM

*---------------------------------------------------------------------*




FORM add_fcat  USING    pv_field    TYPE lvc_fname

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






*---------------------------------------------------------------------*

* #### ##

*---------------------------------------------------------------------*




FORM build_layout_create.



  CLEAR gs_layout.

  gs_layout-zebra      = 'X'.




*  gs_layout-cwidth_opt = 'X'.






ENDFORM.






*---------------------------------------------------------------------*

* #### : # ##

*---------------------------------------------------------------------*




FORM alv_add_row_create.



  CLEAR gs_vend_cre.

  gs_vend_cre-bukrs = p_bukrs.

  gs_vend_cre-ktokk = p_ktokk.



  APPEND gs_vend_cre TO gt_vend_cre.



  PERFORM refresh_alv_create.



ENDFORM.






*---------------------------------------------------------------------*

* ## ##### ##

*---------------------------------------------------------------------*




FORM get_next_lifnr  CHANGING cv_lifnr TYPE zedt17_lfa1-lifnr.



  DATA: lv_max TYPE zedt17_lfa1-lifnr.



  CLEAR lv_max.



  SELECT MAX( lifnr )

    INTO lv_max

    FROM zedt17_lfa1.



  IF sy-subrc <> 0 OR lv_max IS INITIAL.

    cv_lifnr = '1000000000'. " ##### ###

  ELSE.

    cv_lifnr = lv_max + 1. " #### ####

  ENDIF.



ENDFORM.






*---------------------------------------------------------------------*

* #### : ALV #### ### ##

*---------------------------------------------------------------------*




FORM alv_save_vendor_create.



  DATA: lv_next_lifnr TYPE zedt17_lfa1-lifnr.



  PERFORM get_next_lifnr CHANGING lv_next_lifnr.



  LOOP AT gt_vend_cre INTO gs_vend_cre.



    " ### ### ### ##

    IF gs_vend_cre-name1 IS INITIAL.

      CONTINUE.

    ENDIF.



    IF gs_vend_cre-lifnr IS INITIAL.

      gs_vend_cre-lifnr = lv_next_lifnr.

      lv_next_lifnr     = lv_next_lifnr + 1.

    ENDIF.



    " LFA1 ##

    CLEAR zedt17_lfa1.

    zedt17_lfa1-lifnr = gs_vend_cre-lifnr.

    zedt17_lfa1-name1 = gs_vend_cre-name1.

    zedt17_lfa1-land1 = gs_vend_cre-land1.

    zedt17_lfa1-ktokk = gs_vend_cre-ktokk.

    zedt17_lfa1-stcd1 = gs_vend_cre-stcd1.

    zedt17_lfa1-stcd2 = gs_vend_cre-stcd2.

    zedt17_lfa1-stras = gs_vend_cre-stras.



    MODIFY zedt17_lfa1 FROM zedt17_lfa1.

    IF sy-subrc <> 0.

      INSERT zedt17_lfa1 FROM zedt17_lfa1.

    ENDIF.



    " LFB1 ##

    CLEAR zedt17_lfb1.

    zedt17_lfb1-lifnr = gs_vend_cre-lifnr.

    zedt17_lfb1-bukrs = gs_vend_cre-bukrs.

    zedt17_lfb1-akont = gs_vend_cre-akont.

    zedt17_lfb1-zterm = gs_vend_cre-zterm.



    MODIFY zedt17_lfb1 FROM zedt17_lfb1.

    IF sy-subrc <> 0.

      INSERT zedt17_lfb1 FROM zedt17_lfb1.

    ENDIF.



    " LFM1 ##

    CLEAR zedt17_lfm1.

    zedt17_lfm1-lifnr = gs_vend_cre-lifnr.

    zedt17_lfm1-ekorg = gs_vend_cre-ekorg.

    zedt17_lfm1-ekgrp = gs_vend_cre-ekgrp.

    zedt17_lfm1-waers = gs_vend_cre-waers.

    zedt17_lfm1-mwskz = gs_vend_cre-mwskz.



    MODIFY zedt17_lfm1 FROM zedt17_lfm1.

    IF sy-subrc <> 0.

      INSERT zedt17_lfm1 FROM zedt17_lfm1.

    ENDIF.



  ENDLOOP.



  COMMIT WORK.



  MESSAGE '#### #######.' TYPE 'S'.



ENDFORM.






*---------------------------------------------------------------------*

* ALV ### ## ### ## (FIELD-SYMBOL ### ##)

*---------------------------------------------------------------------*




FORM alv_handle_data_changed USING p_er TYPE REF TO cl_alv_changed_data_protocol.



  DATA: ls_mod TYPE lvc_s_modi.



  LOOP AT p_er->mt_good_cells INTO ls_mod.



    READ TABLE gt_vend_cre INTO gs_vend_cre INDEX ls_mod-row_id.

    IF sy-subrc <> 0.

      CONTINUE.

    ENDIF.



    " ##### ## ##

    IF ls_mod-fieldname = 'NAME1'.

      gs_vend_cre-name1 = ls_mod-value.

    ELSEIF ls_mod-fieldname = 'LAND1'.

      gs_vend_cre-land1 = ls_mod-value.

    ELSEIF ls_mod-fieldname = 'STCD1'.

      gs_vend_cre-stcd1 = ls_mod-value.

    ELSEIF ls_mod-fieldname = 'STCD2'.

      gs_vend_cre-stcd2 = ls_mod-value.

    ELSEIF ls_mod-fieldname = 'STRAS'.

      gs_vend_cre-stras = ls_mod-value.

    ELSEIF ls_mod-fieldname = 'AKONT'.

      gs_vend_cre-akont = ls_mod-value.

    ELSEIF ls_mod-fieldname = 'ZTERM'.

      gs_vend_cre-zterm = ls_mod-value.

    ELSEIF ls_mod-fieldname = 'EKORG'.

      gs_vend_cre-ekorg = ls_mod-value.

    ELSEIF ls_mod-fieldname = 'EKGRP'.

      gs_vend_cre-ekgrp = ls_mod-value.

    ELSEIF ls_mod-fieldname = 'WAERS'.

      gs_vend_cre-waers = ls_mod-value.

    ELSEIF ls_mod-fieldname = 'MWSKZ'.

      gs_vend_cre-mwskz = ls_mod-value.

    ENDIF.



    MODIFY gt_vend_cre FROM gs_vend_cre INDEX ls_mod-row_id.



  ENDLOOP.



  PERFORM refresh_alv_create.



ENDFORM.






*---------------------------------------------------------------------*

* ALV ## ######

*---------------------------------------------------------------------*




FORM alv_handle_toolbar

    USING    p_e_object      TYPE REF TO cl_alv_event_toolbar_set

             p_e_interactive TYPE c.



  DATA: ls_button TYPE stb_button.



  " ## ### ## [##] ## ##

  IF gv_mode = c_mode_create.



    CLEAR ls_button.

    ls_button-function  = 'ADD'.

    ls_button-icon      = icon_insert_row.

    ls_button-quickinfo = '# ##'.

    ls_button-text      = '##'.

    ls_button-butn_type = '0'.

    APPEND ls_button TO p_e_object->mt_toolbar.



  ENDIF.



  " [SAVE] ### ##/## # # ## (#, #### KTOKK=2000## ##)

  IF NOT ( gv_mode = c_mode_disp AND gv_disp_hide_save = 'X' ).



    CLEAR ls_button.

    ls_button-function  = 'SAVE'.

    ls_button-icon      = icon_system_save.

    IF gv_mode = c_mode_create.

      ls_button-quickinfo = '### ##'.

      ls_button-text      = '##'.

    ELSE.

      ls_button-quickinfo = '##### ##'.

      ls_button-text      = '##'.

    ENDIF.

    ls_button-butn_type = '0'.

    APPEND ls_button TO p_e_object->mt_toolbar.



  ENDIF.





ENDFORM.








*---------------------------------------------------------------------*

* ALV ### ### ##

*---------------------------------------------------------------------*




FORM alv_handle_user_command USING p_ucomm TYPE syucomm.



  CASE p_ucomm.



    WHEN 'ADD'.

      IF gv_mode = c_mode_create.

        PERFORM alv_add_row_create.

      ENDIF.



    WHEN 'SAVE'.

      IF gv_mode = c_mode_create.

        PERFORM alv_save_vendor_create.

      ELSEIF gv_mode = c_mode_disp.

        PERFORM alv_save_vendor_display.

      ENDIF.



  ENDCASE.



ENDFORM.






*---------------------------------------------------------------------*

* ## ## : #####(STCD2) ##

*---------------------------------------------------------------------*




FORM alv_save_vendor_display.



  LOOP AT gt_vend_cre INTO gs_vend_cre.



    " ### + #### #### LFA1/LFB1 ## ##

    CLEAR zedt17_lfa1.



    SELECT SINGLE *

      INTO zedt17_lfa1

      FROM zedt17_lfa1

     WHERE lifnr = gs_vend_cre-lifnr.



    IF sy-subrc <> 0.

      CONTINUE.

    ENDIF.



    " ALV## ### ###### ##

    zedt17_lfa1-stcd2 = gs_vend_cre-stcd2.



    MODIFY zedt17_lfa1 FROM zedt17_lfa1.



  ENDLOOP.



  COMMIT WORK.



  MESSAGE '###### #######.' TYPE 'S'.



ENDFORM.