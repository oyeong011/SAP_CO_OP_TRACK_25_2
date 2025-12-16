
*&---------------------------------------------------------------------*

*&  Include           ZPROJECT17_002_F01

*&---------------------------------------------------------------------*



*---------------------------------------------------------------------*

* ### ##

*---------------------------------------------------------------------*




FORM init_selection.



  " ## ### '#### ##'

  p_cre  = 'X'.

  p_disp = ''.



  gv_cre_active_flag  = '1'.  " ## ## ## on

  gv_disp_active_flag = '0'.  " ## ## ## off



  " ### ### (#### / ### / ###)

  p_bukrs = '1000'.          " ####

  p_lifnr = '1000000005'.    " ###

  p_bedat = '20251001'.      " ### (DATS: YYYYMMDD)



  " ### ###

  p_bukr_q = p_bukrs.

  p_lif_q  = p_lifnr.

  p_ebeln  = '4500000001'.           " #### ### ###



ENDFORM.






*---------------------------------------------------------------------*

* SELECTION-SCREEN OUTPUT ##

*---------------------------------------------------------------------*




FORM selection_screen_control.



  " ###### ## ## ### ##

  IF p_cre = 'X'.

    gv_cre_active_flag  = '1'.

    gv_disp_active_flag = '0'.

  ELSEIF p_disp = 'X'.

    gv_cre_active_flag  = '0'.

    gv_disp_active_flag = '1'.

  ENDIF.



  " MODIF ID# ## on/off

  LOOP AT SCREEN.

    IF screen-group1 = 'C1'.

      screen-active = gv_cre_active_flag.  " ## ##

    ELSEIF screen-group1 = 'C2'.

      screen-active = gv_disp_active_flag. " ## ##

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



ENDFORM.






*---------------------------------------------------------------------*

* ## ##

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




*&---------------------------------------------------------------------*

*&      Form  CHECK_SELECTION

*&---------------------------------------------------------------------*




FORM check_selection .



  DATA: lv_dummy TYPE c.



  " ## ## : #### ##

  IF gv_mode = c_mode_create.



    " #### ##

    IF p_bukrs IS INITIAL.

      MESSAGE '##### #####.' TYPE 'S' DISPLAY LIKE 'E'.

      STOP.

    ENDIF.



    " #### ## ## ## (EKKO ##)

    SELECT SINGLE bukrs

      INTO lv_dummy

      FROM zedt17_ekko

      WHERE bukrs = p_bukrs.



    IF sy-subrc <> 0.

      MESSAGE '#### ## #######.' TYPE 'S' DISPLAY LIKE 'E'.

      STOP.

    ENDIF.





    " ### ##

    IF p_lifnr IS INITIAL.

      MESSAGE '#### #####.' TYPE 'S' DISPLAY LIKE 'E'.

      STOP.

    ENDIF.



    " ### ## ## ## (LFA1)

    SELECT SINGLE lifnr

      INTO lv_dummy

      FROM zedt17_lfa1

      WHERE lifnr = p_lifnr.



    IF sy-subrc <> 0.

      MESSAGE '#### ## ######.' TYPE 'S' DISPLAY LIKE 'E'.

      STOP.

    ENDIF.



    " ## ## : #### ##

  ELSEIF gv_mode = c_mode_disp.



    " #### ##

    IF p_bukr_q IS INITIAL.

      MESSAGE '##### #####.' TYPE 'S' DISPLAY LIKE 'E'.

      STOP.

    ENDIF.



    " ### ##

    IF p_lif_q IS INITIAL.

      MESSAGE '#### #####.' TYPE 'S' DISPLAY LIKE 'E'.

      STOP.

    ENDIF.



    " #### ##

    IF p_ebeln IS INITIAL.

      MESSAGE '##### #####.' TYPE 'S' DISPLAY LIKE 'E'.

      STOP.

    ENDIF.



    " #### ## ## ## (EKKO)

    SELECT SINGLE ebeln

      INTO lv_dummy

      FROM zedt17_ekko

      WHERE ebeln = p_ebeln

        AND bukrs = p_bukr_q

        AND lifnr = p_lif_q.



    IF sy-subrc <> 0.

      MESSAGE '### ### #### ##### ####.' TYPE 'S' DISPLAY LIKE 'E'.

      STOP.

    ENDIF.



  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  RUN_DISPLAY_MODE

*&---------------------------------------------------------------------*

* ## ##

*----------------------------------------------------------------------*




FORM run_display_mode .



  " 1) #### ## (#### / ### / ######)

  IF p_bukr_q IS INITIAL

    OR p_lif_q  IS INITIAL

    OR p_ebeln  IS INITIAL.

    MESSAGE e014(zmed17). " '####/###/##### ## #####.'

  ENDIF.



  " 2) ## ### ###

  PERFORM clear_po_data.



  " 3) ## ##

  PERFORM get_po_header USING p_ebeln p_bukr_q p_lif_q.

  IF gt_ekko IS INITIAL.

    MESSAGE e015(zmed17).   " '## ##### #### ####.'

  ENDIF.



  " 4) ### ##

  PERFORM get_po_item USING p_ebeln.



  " 5) ALV# #### 1# ### ##

  PERFORM convert_item_to_alv.



  " 6-1) ## ##: LFM1 #### ##/#### ###

  DATA: ls_lfm1 TYPE zedt17_lfm1.



  CLEAR ls_lfm1.

  SELECT SINGLE waers

                mwskz

    INTO (ls_lfm1-waers,

          ls_lfm1-mwskz)

    FROM zedt17_lfm1

    WHERE lifnr = gs_ekko-lifnr

      AND ekorg = gs_ekko-ekorg.



  IF sy-subrc = 0.

    LOOP AT gt_ekpo_alv INTO gs_ekpo_alv.

      " ALV ### ## ## ## ## ### ##

      IF gs_ekpo_alv-waers IS INITIAL.

        gs_ekpo_alv-waers = ls_lfm1-waers.

      ENDIF.

      IF gs_ekpo_alv-mwskz IS INITIAL.

        gs_ekpo_alv-mwskz = ls_lfm1-mwskz.

      ENDIF.

      MODIFY gt_ekpo_alv FROM gs_ekpo_alv INDEX sy-tabix.

    ENDLOOP.

  ENDIF.



  " 6) ## ## ## ###

  PERFORM display_header_to_screen USING p_ebeln.



  " 7) ALV ####

  PERFORM refresh_alv_0100.



ENDFORM.






*---------------------------------------------------------------------*

* #### / ALV ## ##

*---------------------------------------------------------------------*




FORM create_object_0100 .



  " 1) ### #### ##

  CREATE OBJECT go_container

    EXPORTING

      container_name = 'CC_ALV'.



  " 2) ALV GRID ##

  CREATE OBJECT go_alv

    EXPORTING

      i_parent = go_container.



  " 3) # ## ### ## ##

  CALL METHOD go_alv->register_edit_event

    EXPORTING

      i_event_id = cl_gui_alv_grid=>mc_evt_modified.



ENDFORM.








*---------------------------------------------------------------------*

* ALV ## ##

*---------------------------------------------------------------------*




FORM alv_display_0100 .



  " ###### ## 1# ##

  IF gt_fcat IS INITIAL.

    PERFORM build_fcat_0100.

  ENDIF.



  CLEAR gs_layout.

  gs_layout-zebra = 'X'.



  CALL METHOD go_alv->set_table_for_first_display

    EXPORTING

      is_layout       = gs_layout

    CHANGING

      it_fieldcatalog = gt_fcat

      it_outtab       = gt_ekpo_alv.   " ALV# ###



ENDFORM.








*---------------------------------------------------------------------*

* ALV ###### ## (ZEDT17_EKPO ##)

*---------------------------------------------------------------------*




FORM build_fcat_0100 .



  CLEAR gt_fcat.



  " ## ## #### ## ##

  PERFORM add_fcat_0100 USING 'EBELP' '##' ''. " ZEDT17_EKPO-EBELP

  PERFORM add_fcat_0100 USING 'ZMATNR' '####' 'X'. " ZEDT17_EKPO-MATNR

  PERFORM add_fcat_0100 USING 'MAKTX' '###' ''. " ZEDT17_MAKT-MAKTX

  PERFORM add_fcat_0100 USING 'MENGE' 'PO##' 'X'. " ZEDT17_EKPO-MENGE

  PERFORM add_fcat_0100 USING 'STPRS' '##' 'X'.  " ZEDT17_EKPO-STPRS

  PERFORM add_fcat_0100 USING 'MEINS' '##' 'X'. " ZEDT17_EKPO-MEINS

  PERFORM add_fcat_0100 USING 'WAERS' '##' ''. " ZMARA17-WAERS

  PERFORM add_fcat_0100 USING 'MWSKZ' '####' ''. " ZEDT17_LFM1-MWSKZ (###: ZEDT17_LFM1-MWSKZ## ###)

  PERFORM add_fcat_0100 USING 'PRDAT' '###' 'X'. " ZEDT17_EKPO-PRDAT

  PERFORM add_fcat_0100 USING 'ZWERKS' '###' 'X'. " ZEDT17_EKPO-ZWERKS

  PERFORM add_fcat_0100 USING 'ZLGORT' '####' 'X'. " ZEDT17_EKPO-ZLGORT



  " ZEDT17_EKPO # ##/#### ### ####

  "* PERFORM add_fcat_0100 USING 'WAERS' '##'.

  "* PERFORM add_fcat_0100 USING 'MWSKZ' '####'.



ENDFORM.






*---------------------------------------------------------------------*

* ###### 1# ## ##

*---------------------------------------------------------------------*




FORM add_fcat_0100 USING    p_fieldname  TYPE lvc_fname

                             p_coltext    TYPE scrtext_l

                             p_edit       TYPE c. " 'X' ## ##, '' ## ##



  CLEAR gs_fcat.

  gs_fcat-fieldname = p_fieldname.

  gs_fcat-coltext   = p_coltext.



  " ##/## ### ## ## ## ##

  IF gv_mode = c_mode_disp.        " ## ##(D)

    gs_fcat-edit = ''.             " ### ## ##

  ELSE.                            " ## ##(C)

    IF p_edit = 'X'.

      gs_fcat-edit = 'X'.    " ## ##

    ELSE.

      gs_fcat-edit = ''.     " ## ## (display only)

    ENDIF.

  ENDIF.



  " ### ## ## ##

  CASE p_fieldname.

    WHEN 'MENGE'.          " PO##

      " ## ## ### 1000 #### 1.000## ###.

      gs_fcat-ref_table  = 'ZEDT17_EKPO'.   " ####

      gs_fcat-ref_field  = 'MENGE'.  " ###

      gs_fcat-qfieldname = 'MEINS'. " ALV outtab# ## ###



      gs_fcat-no_zero    = 'X'. " ## 0## ### #### ## (#### ###)



    WHEN 'PRDAT'.                 " ###

      gs_fcat-outputlen = 10.     " ## # 10##



    WHEN 'MAKTX'.

      gs_fcat-outputlen = 20. " ### ## # ###



  ENDCASE.



  APPEND gs_fcat TO gt_fcat.



ENDFORM.








*---------------------------------------------------------------------*

* ALV ####

*---------------------------------------------------------------------*




FORM refresh_alv_0100 .



  IF go_alv IS BOUND.

    CALL METHOD go_alv->refresh_table_display( ).

  ENDIF.



ENDFORM.






*---------------------------------------------------------------------*

* PO ### ###

*---------------------------------------------------------------------*




FORM clear_po_data.



  CLEAR: gt_ekko,

         gs_ekko,

         gt_ekpo,

         gs_ekpo.



ENDFORM.






*---------------------------------------------------------------------*

* PO ## ##

*  - p_ebeln # ##### ## ##

*  - p_ebeln # ### ## PO# ##

*---------------------------------------------------------------------*




FORM get_po_header

  USING    p_ebeln TYPE ebeln

           p_bukrs TYPE bukrs

           p_lifnr TYPE lifnr.



  CLEAR: gt_ekko, gs_ekko.



  IF p_ebeln IS INITIAL.

    EXIT.

  ENDIF.



  SELECT SINGLE *

    INTO gs_ekko

    FROM zedt17_ekko

    WHERE ebeln = p_ebeln

      AND bukrs = p_bukrs

      AND lifnr = p_lifnr.



  IF sy-subrc = 0.

    APPEND gs_ekko TO gt_ekko.

  ENDIF.



ENDFORM.






*---------------------------------------------------------------------*

* PO ### ##

*  - p_ebeln # ##### ## ##

*  - p_ebeln # ### ## PO# #### ##

*---------------------------------------------------------------------*




FORM get_po_item

  USING    p_ebeln TYPE ebeln.



  CLEAR gt_ekpo.



  SELECT *

    INTO TABLE gt_ekpo

    FROM zedt17_ekpo

    WHERE ebeln = p_ebeln

    ORDER BY ebelp.





ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ADD_ITEM_LINE

*---------------------------------------------------------------------*

* #### ## ##

*---------------------------------------------------------------------*




FORM add_item_line .



  DATA: lv_ebelp TYPE ebelp,

        ls_lfm1  TYPE zedt17_lfm1,   " #######(####/##)

        lv_max   TYPE ebelp.



  CLEAR: lv_ebelp, lv_max.



  " 1) ## EBELP ##

  "    gt_ekpo # ## # EBELP ### +10

  LOOP AT gt_ekpo_alv INTO gs_ekpo_alv.

    IF gs_ekpo_alv-ebelp > lv_max.

      lv_max = gs_ekpo_alv-ebelp.

    ENDIF.

  ENDLOOP.





  IF lv_max IS INITIAL.

    lv_ebelp = '00010'.

  ELSE.

    lv_ebelp = lv_max + 10.

  ENDIF.



  " 2) ## #### ###/##### ####(##/####) ####

  CLEAR ls_lfm1.



  IF gs_ekko-lifnr IS NOT INITIAL AND gs_ekko-ekorg IS NOT INITIAL.

    SELECT SINGLE *

      INTO ls_lfm1

      FROM zedt17_lfm1

      WHERE lifnr = gs_ekko-lifnr

        AND ekorg = gs_ekko-ekorg.

  ENDIF.



  " 3) ## ### ### ##

  CLEAR gs_ekpo_alv.

  gs_ekpo_alv-ebelp = lv_ebelp.             " ## ####




*  gs_ekpo_alv-menge = 0.                    " ## PO##




  gs_ekpo_alv-stprs = '1'.                  " ## ####

  gs_ekpo_alv-meins = ''.                   " ### ## ## # ##

  gs_ekpo_alv-zmatnr = ''.                  " #### ####

  gs_ekpo_alv-maktx  = ''.                  " ### (#### MAKTX ## ##)

  gs_ekpo_alv-zwerks = ''.                  " ###

  gs_ekpo_alv-zlgort = ''.                  " ####

  gs_ekpo_alv-prdat  = sy-datum.            " ## ### = ##



  " ## Default (ZWAERS ##)

  IF ls_lfm1-waers IS NOT INITIAL.

    gs_ekpo_alv-waers = ls_lfm1-waers.

  ENDIF.



  " #### ###

  IF ls_lfm1-mwskz IS NOT INITIAL.

    gs_ekpo_alv-mwskz = ls_lfm1-mwskz.

  ENDIF.



  " 4) ###### ##

  APPEND gs_ekpo_alv TO gt_ekpo_alv.



  " 5) ALV ####

  PERFORM refresh_alv_0100.



ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  DELETE_ITEM_LINE

*&---------------------------------------------------------------------*

* ALV## ### ## ##

*----------------------------------------------------------------------*




FORM delete_item_line .



  DATA: lt_rows TYPE lvc_t_row,

        ls_row  TYPE lvc_s_row,

        lv_idx  TYPE sy-tabix.



  " ALV ### ### ##

  IF go_alv IS NOT BOUND.

    RETURN.

  ENDIF.



  " 1) ### # ### ####

  CALL METHOD go_alv->get_selected_rows

    IMPORTING

      et_index_rows = lt_rows.



  " 2) ### ### ### # ##

  IF lt_rows IS INITIAL.

    MESSAGE i011(zmed17).   " ###: '### ### #####.'

    RETURN.

  ENDIF.



  " 3) #### ### ### ###### ## # ##

  SORT lt_rows BY index DESCENDING.



  LOOP AT lt_rows INTO ls_row.

    lv_idx = ls_row-index.

    IF lv_idx > 0.

      DELETE gt_ekpo_alv INDEX lv_idx.

    ENDIF.

  ENDLOOP.



  " 4) ALV ####

  PERFORM refresh_alv_0100.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SAVE_PO

*&---------------------------------------------------------------------*

*  - ALV #### ##

*  - #### ## ## ##

*  - ##(ZEDT17_EKKO) ##

*  - ###(ZEDT17_EKPO) ##

*----------------------------------------------------------------------*




FORM save_po .



  DATA: ls_ekko   TYPE zedt17_ekko,          " ## ### ##

        ls_ekpo   TYPE zedt17_ekpo,          " ### ### ##

        lt_ekpo   TYPE STANDARD TABLE OF zedt17_ekpo,

        lv_ebeln  TYPE ebeln,                " PO ##

        lv_answer TYPE c LENGTH 1.



  " 0. ALV## ### ### ###### ##

  IF go_alv IS BOUND.

    CALL METHOD go_alv->check_changed_data.

  ENDIF.



  " 1. ### ### ## ##

  IF gt_ekpo_alv IS INITIAL.

    MESSAGE '### ### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    EXIT.

  ENDIF.



  " 2. ## ## ##

  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      titlebar              = '## ##'

      text_question         = '##### ########?'

      text_button_1         = '#'

      text_button_2         = '###'

      display_cancel_button = ' '

    IMPORTING

      answer                = lv_answer.



  IF lv_answer <> '1'.

    EXIT.

  ENDIF.



  " ## # PO### 0# ### ### ## - po ## ##### #### ### ##

  LOOP AT gt_ekpo_alv INTO gs_ekpo_alv.

    IF gs_ekpo_alv-menge <= 0.

      MESSAGE e013(zmed17). " PO### 0### #### ### ####.

      EXIT.

    ENDIF.

  ENDLOOP.





  " 3. #### ## ## ## (## ### ##)

  "   - gv_mode = c_mode_create / c_mode_disp # TOP ## ### ## ##

  IF gv_mode = c_mode_create.



    " ## ### # ## # EBELN ##

    SELECT SINGLE MAX( ebeln )

      INTO lv_ebeln

      FROM zedt17_ekko.



    IF lv_ebeln IS INITIAL.

      lv_ebeln = '4500000001'. " SAP### ## ## ## 45# ##### ##

    ELSE.

      lv_ebeln = lv_ebeln + 1.

    ENDIF.



    gs_ekko-ebeln = lv_ebeln.



  ELSE.

    " ## #### #####, gs_ekko-ebeln # ##### ##

    IF gs_ekko-ebeln IS INITIAL.

      MESSAGE '## #### ### ####.' TYPE 'S' DISPLAY LIKE 'E'.

      EXIT.

    ENDIF.

  ENDIF.



  " 4. ## ## ## # ## (ZEDT17_EKKO)

  CLEAR ls_ekko.

  MOVE-CORRESPONDING gs_ekko TO ls_ekko.



  " ## MOVE-CORRESPONDING ## EBELN # # #### # # # ##

  ls_ekko-ebeln = gs_ekko-ebeln.



  " ##/## ## ## UPSERT #### MODIFY ##

  MODIFY zedt17_ekko FROM ls_ekko.



  IF sy-subrc <> 0.

    MESSAGE '## ## # ### ######.' TYPE 'S' DISPLAY LIKE 'E'.

    ROLLBACK WORK.

    EXIT.

  ENDIF.



  " 5. ### ## ## # ## (ZEDT17_EKPO)

  "    - gt_ekpo_alv #### LOOP

  CLEAR lt_ekpo.



  LOOP AT gt_ekpo_alv INTO gs_ekpo_alv.



    " ####/## ## #### ## (## ## ## ##)

    IF gs_ekpo_alv-zmatnr IS INITIAL AND

       gs_ekpo_alv-menge  IS INITIAL.

      CONTINUE.

    ENDIF.



    CLEAR ls_ekpo.

    MOVE-CORRESPONDING gs_ekpo_alv TO ls_ekpo.



    " ### ### ### ##

    ls_ekpo-ebeln = gs_ekko-ebeln.



    APPEND ls_ekpo TO lt_ekpo.



  ENDLOOP.



  IF lt_ekpo IS INITIAL.

    MESSAGE '### ### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    ROLLBACK WORK.

    EXIT.

  ENDIF.



  " ## ### ## # ### (## EBELN ## #####)

  DELETE FROM zedt17_ekpo WHERE ebeln = gs_ekko-ebeln.



  INSERT zedt17_ekpo FROM TABLE lt_ekpo.



  IF sy-subrc = 0.

    COMMIT WORK AND WAIT.

    MESSAGE |#### { gs_ekko-ebeln } #(#) #######.| TYPE 'S'.

  ELSE.

    ROLLBACK WORK.

    MESSAGE '## ## # ### ######.' TYPE 'S' DISPLAY LIKE 'E'.

  ENDIF.



ENDFORM.






*---------------------------------------------------------------------*

* ### ### + ## ## ##

*---------------------------------------------------------------------*




FORM check_vendor_valid .

  DATA: ls_lfa1 TYPE zedt17_lfa1,

        ls_lfm1 TYPE zedt17_lfm1.



  " 1) ### ## ## ##

  CLEAR ls_lfa1.



  SELECT SINGLE lifnr

    INTO ls_lfa1-lifnr

    FROM zedt17_lfa1

    WHERE lifnr = p_lifnr.



  IF sy-subrc <> 0.

    MESSAGE e007(zmed). " '#### #### ####.'

    STOP.               " ## ## ##

  ENDIF.



  " 2) ## ## GS_EKKO ### ##

  CLEAR gs_ekko.



  gs_ekko-bukrs = p_bukrs.   " ####

  gs_ekko-lifnr = p_lifnr.   " ###

  gs_ekko-bedat = p_bedat.   " ###



  " 3) LFM1## ####/##/## ####

  CLEAR ls_lfm1.



  SELECT SINGLE ekorg

                ekgrp

                waers

    INTO (ls_lfm1-ekorg,

          ls_lfm1-ekgrp,

          ls_lfm1-waers)

    FROM zedt17_lfm1

    WHERE lifnr = p_lifnr.



  IF sy-subrc = 0.

    gs_ekko-ekorg = ls_lfm1-ekorg.

    gs_ekko-ekgrp = ls_lfm1-ekgrp.

    gs_ekko-waers = ls_lfm1-waers.

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  DISABLE_HEADER_FIELDS

*&---------------------------------------------------------------------*

*       ## ## ####

*----------------------------------------------------------------------*




FORM disable_header_fields .



  LOOP AT SCREEN.

    IF screen-group1 = 'H1'.   " ## ### ##

      screen-input = '0'.      " ## ##

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLE_DATA_CHANGED

*&---------------------------------------------------------------------*

*       ALV # ## # ### ##

*----------------------------------------------------------------------*

*      --> ER_DATA_CHANGED  ## ## ## (EVENT IMPORTING)

*----------------------------------------------------------------------*




FORM alv_handle_data_changed

  USING    er_data_changed TYPE REF TO cl_alv_changed_data_protocol.



  DATA: ls_modi  TYPE lvc_s_modi,

        ls_mara  TYPE zmara17,

        lv_prdat TYPE dats.



  " ### # ## ##

  LOOP AT er_data_changed->mt_good_cells INTO ls_modi.



    CLEAR gs_ekpo_alv.

    READ TABLE gt_ekpo_alv INTO gs_ekpo_alv INDEX ls_modi-row_id.

    IF sy-subrc <> 0.

      CONTINUE.

    ENDIF.



    CASE ls_modi-fieldname.



        " 1) #### ### ## + ## ## ## ##

      WHEN 'ZMATNR'.



        gs_ekpo_alv-zmatnr = ls_modi-value.

        MODIFY gt_ekpo_alv FROM gs_ekpo_alv INDEX ls_modi-row_id.



        CLEAR ls_mara.

        SELECT SINGLE *

          INTO ls_mara

          FROM zmara17

          WHERE zmatnr = gs_ekpo_alv-zmatnr.



        IF sy-subrc <> 0.

          " ## ## ## -> ## ###

          CALL METHOD er_data_changed->add_protocol_entry

            EXPORTING

              i_msgid     = 'ZMED17'

              i_msgno     = '008'   " ##### #### ####.

              i_msgty     = 'E'

              i_msgv1     = '##### #### ####.'

              i_fieldname = ls_modi-fieldname

              i_row_id    = ls_modi-row_id.

        ELSE.

          " ### ####

          CALL METHOD er_data_changed->modify_cell

            EXPORTING

              i_row_id    = ls_modi-row_id

              i_fieldname = 'MAKTX'

              i_value     = ls_mara-zmatname. " ###



          " ## ####

          CALL METHOD er_data_changed->modify_cell

            EXPORTING

              i_row_id    = ls_modi-row_id

              i_fieldname = 'STPRS'

              i_value     = ls_mara-stprs.



          " ## ####

          CALL METHOD er_data_changed->modify_cell

            EXPORTING

              i_row_id    = ls_modi-row_id

              i_fieldname = 'MEINS'

              i_value     = ls_mara-meins.



          " ## ####

          CALL METHOD er_data_changed->modify_cell

            EXPORTING

              i_row_id    = ls_modi-row_id

              i_fieldname = 'WAERS'

              i_value     = ls_mara-waers.



          " ### ####

          CALL METHOD er_data_changed->modify_cell

            EXPORTING

              i_row_id    = ls_modi-row_id

              i_fieldname = 'ZWERKS'

              i_value     = ls_mara-zwerks.



          " #### ####

          CALL METHOD er_data_changed->modify_cell

            EXPORTING

              i_row_id    = ls_modi-row_id

              i_fieldname = 'ZLGORT'

              i_value     = ls_mara-zlgort.



          " ####### ##

          gs_ekpo_alv-maktx = ls_mara-zmatname.

          gs_ekpo_alv-meins = ls_mara-stprs.

          gs_ekpo_alv-meins = ls_mara-meins.

          gs_ekpo_alv-waers = ls_mara-waers.

          gs_ekpo_alv-zwerks = ls_mara-zwerks.

          gs_ekpo_alv-zlgort = ls_mara-zlgort.



          MODIFY gt_ekpo_alv FROM gs_ekpo_alv INDEX ls_modi-row_id.

        ENDIF.



        " 2) ### ### ## (PRDAT >= ## ### BEDAT)

      WHEN 'PRDAT'.



        lv_prdat = ls_modi-value.



        IF lv_prdat < gs_ekko-bedat.

          CALL METHOD er_data_changed->add_protocol_entry

            EXPORTING

              i_msgid     = 'ZMED17'

              i_msgno     = '009'  " #### ##### ## # ####.

              i_msgty     = 'E'

              i_msgv1     = '#### ##### ## # ####.'

              i_fieldname = ls_modi-fieldname

              i_row_id    = ls_modi-row_id.

        ELSE.

          gs_ekpo_alv-prdat = lv_prdat.

          MODIFY gt_ekpo_alv FROM gs_ekpo_alv INDEX ls_modi-row_id.

        ENDIF.



        " 3) ### / #### ### (## + ### + ####)

      WHEN 'ZWERKS' OR 'ZLGORT'.



        IF ls_modi-fieldname = 'ZWERKS'.

          gs_ekpo_alv-zwerks = ls_modi-value.

        ELSE.

          gs_ekpo_alv-zlgort = ls_modi-value.

        ENDIF.

        MODIFY gt_ekpo_alv FROM gs_ekpo_alv INDEX ls_modi-row_id.



        " # # #### #### ## #### ##

        IF gs_ekpo_alv-zwerks IS INITIAL OR

           gs_ekpo_alv-zlgort IS INITIAL.

          CONTINUE.

        ENDIF.



        " ##### ## ## ##

        IF gs_ekpo_alv-zmatnr IS NOT INITIAL.



          CLEAR ls_mara.

          SELECT SINGLE zmatnr

            INTO ls_mara-zmatnr

            FROM zmara17

            WHERE zmatnr = gs_ekpo_alv-zmatnr

              AND zwerks = gs_ekpo_alv-zwerks

              AND zlgort = gs_ekpo_alv-zlgort.



          IF sy-subrc <> 0.

            CALL METHOD er_data_changed->add_protocol_entry

              EXPORTING

                i_msgid     = 'ZMED17'

                i_msgno     = '010'  " ##/###/#### ### #### ####.

                i_msgty     = 'E'

                i_msgv1     = '##/###/#### ### ###### ####.'

                i_fieldname = ls_modi-fieldname

                i_row_id    = ls_modi-row_id.

          ENDIF.



        ENDIF.



        " 4) PO## ## ##

      WHEN 'MENGE'.



        " 1) ### #### ## #### ### ##

        DATA lv_menge TYPE zedt17_ekpo-menge.



        lv_menge = ls_modi-value.  " ## -> ### ## (## ##)



        " 2) # ### ## (###### ALV# ### ####)

        IF lv_menge <= 0.

          CALL METHOD er_data_changed->add_protocol_entry

            EXPORTING

              i_msgid     = 'ZMED17'

              i_msgno     = '012'   " 'PO### 1 ##### ###.'

              i_msgty     = 'E'

              i_msgv1     = 'PO### 1 ##### ###.'

              i_fieldname = 'MENGE'

              i_row_id    = ls_modi-row_id.

        ENDIF.





    ENDCASE.



  ENDLOOP.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CONVERT_ITEM_TO_ALV

*&---------------------------------------------------------------------*

*---------------------------------------------------------------------*

* DB## ## ZEDT17_EKPO -> ALV ###(gt_ekpo_alv) ##

*---------------------------------------------------------------------*




FORM convert_item_to_alv .



  REFRESH gt_ekpo_alv.

  CLEAR   gs_ekpo_alv.



  LOOP AT gt_ekpo INTO gs_ekpo.



    CLEAR gs_ekpo_alv.



    MOVE-CORRESPONDING gs_ekpo TO gs_ekpo_alv.



    " ## ##### ## Display Only -> edit = space ###

    " ### ALV # ## #### #### #### ### ## ## ###



    APPEND gs_ekpo_alv TO gt_ekpo_alv.



  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DISPLAY_HEADER_TO_SCREEN

*&---------------------------------------------------------------------*

*---------------------------------------------------------------------*

* ### ## -> ## ### ###

*---------------------------------------------------------------------*




FORM display_header_to_screen USING p_ebeln TYPE ebeln.



  p_bukr_q = gs_ekko-bukrs.

  p_lif_q  = gs_ekko-lifnr.

  p_ebeln  = gs_ekko-ebeln.

  p_bedat  = gs_ekko-bedat.



ENDFORM.