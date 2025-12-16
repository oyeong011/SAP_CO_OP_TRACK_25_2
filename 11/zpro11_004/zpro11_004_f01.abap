
*&---------------------------------------------------------------------*

*&  Include           ZPRO11_004_F01

*&---------------------------------------------------------------------*

*& #### ##

*&---------------------------------------------------------------------*



*&---------------------------------------------------------------------*

*&      Form  INIT_DEFAULT_DATE

*&---------------------------------------------------------------------*

*       ### # ## ## ##

*----------------------------------------------------------------------*




FORM init_default_date.

  p_docdt = sy-datum.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CHECK_PO_VALIDITY

*&---------------------------------------------------------------------*

*       ##### ### ## ### ##

*----------------------------------------------------------------------*




FORM check_po_validity.

  DATA lv_rec_count TYPE i.



  SELECT COUNT(*)

    INTO lv_rec_count

    FROM zpro11_005

    WHERE ebeln = p_ponum

      AND werks = p_plant.



  IF lv_rec_count = 0.

    MESSAGE '### ##### ### ### #### ####.' TYPE 'I'.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CONTROL_SCREEN_FIELDS

*&---------------------------------------------------------------------*

*       ###### ## ## ## ##

*----------------------------------------------------------------------*




FORM control_screen_fields.

  LOOP AT SCREEN.

    IF screen-group1 = 'PRC'.

      IF p_proc = abap_true.

        screen-active = 1.

      ELSE.

        screen-active = 0.

      ENDIF.

      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  FETCH_INVOICE_DATA

*&---------------------------------------------------------------------*

*       ## ### ## ### ##

*----------------------------------------------------------------------*




FORM fetch_invoice_data.

  DATA : lv_line_no TYPE c LENGTH 6 VALUE '10'.

  DATA : lv_cnt TYPE i.



  " ##### ###

  CLEAR : gt_inv_item, gt_inv_itm, gt_itm_007.



  " ## ## ## ### ##

  SELECT * INTO TABLE gt_inv_itm

    FROM zpro11_009.



  " #### ## ### ##

  SELECT * INTO TABLE gt_itm_007

    FROM zpro11_007.



  " # ###: ### ## ## ##

  DESCRIBE TABLE gt_itm_007 LINES lv_cnt.

  IF lv_cnt = 0.

    MESSAGE |ZPRO11_007 #### #### ####.| TYPE 'I'.

    RETURN.

  ENDIF.



  " ## ####/#### ## ##

  LOOP AT gt_itm_007 INTO gw_itm_007

    WHERE ebeln = p_ponum

      AND werks = p_plant.



    CLEAR gs_inv_item.



    " ## ## ##

    gs_inv_item-vendor   = gw_itm_007-lifnr.

    gs_inv_item-po_num   = gw_itm_007-ebeln.

    gs_inv_item-po_item  = gw_itm_007-zeile.

    gs_inv_item-mat_num  = gw_itm_007-matnr.

    gs_inv_item-qty      = gw_itm_007-menge.

    gs_inv_item-base_uom = gw_itm_007-meins.

    gs_inv_item-net_amt  = gw_itm_007-dmbtr.

    gs_inv_item-comp_cd  = gw_itm_007-bukrs.

    gs_inv_item-doc_item = lv_line_no.

    lv_line_no = lv_line_no + 10.



    " ####/## ##

    SELECT SINGLE mwskz waers

      INTO ( gs_inv_item-tax_cd, gs_inv_item-curr_key )

      FROM zpro11_003

      WHERE lifnr = gw_itm_007-lifnr.



    " ## ## ##

    PERFORM calculate_tax USING    gs_inv_item-tax_cd

                                   gs_inv_item-net_amt

                          CHANGING gs_inv_item-tax_amt.



    " ### ##

    gs_inv_item-tot_amt = gs_inv_item-net_amt + gs_inv_item-tax_amt.



    " #### ## ### ##

    PERFORM set_invoice_status_text USING    gs_inv_item-po_num

                                             gs_inv_item-po_item

                                             gs_inv_item-doc_item

                                    CHANGING gs_inv_item-desc_txt.



    APPEND gs_inv_item TO gt_inv_item.

  ENDLOOP.



  " # ###: ### ## ### ## ##

  DESCRIBE TABLE gt_inv_item LINES lv_cnt.

  IF lv_cnt = 0.

    MESSAGE |##(EBELN={ p_ponum }, WERKS={ p_plant })# ## #### ####.| TYPE 'I'.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CALCULATE_TAX

*&---------------------------------------------------------------------*

*       ##### ## ## ##

*----------------------------------------------------------------------*




FORM calculate_tax USING    iv_tax_code TYPE bsik-mwskz

                            iv_net_amt  TYPE bsik-dmbtr

                   CHANGING cv_tax_amt  TYPE bsik-mwsts.



  CASE iv_tax_code.

    WHEN 'V1' OR 'V5'.

      cv_tax_amt = iv_net_amt * '0.1'.

    WHEN OTHERS.

      cv_tax_amt = 0.

  ENDCASE.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SET_INVOICE_STATUS_TEXT

*&---------------------------------------------------------------------*

*       #### ## ### ##

*----------------------------------------------------------------------*




FORM set_invoice_status_text USING    iv_po_num   TYPE zpro11_009-ebeln

                                      iv_po_item  TYPE zpro11_009-ebelp

                                      iv_doc_item TYPE zpro11_009-buzei

                             CHANGING cv_desc_txt TYPE bsik-sgtxt.



  READ TABLE gt_inv_itm INTO gw_inv_itm

    WITH KEY ebeln = iv_po_num

             ebelp = iv_po_item

             buzei = iv_doc_item.



  IF sy-subrc = 0.

    cv_desc_txt = |{ iv_po_num } O|.

  ELSE.

    cv_desc_txt = |{ iv_po_num } X|.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  LOAD_SEARCH_DATA

*&---------------------------------------------------------------------*

*       ## ## ### ##

*----------------------------------------------------------------------*




FORM load_search_data.

  SELECT * FROM zpro11_009

    INTO CORRESPONDING FIELDS OF TABLE gt_search_009

    WHERE ebeln = p_ponum

      AND werks = p_plant.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  PROCESS_INVOICE_CREATE

*&---------------------------------------------------------------------*

*       ## ## ## ##

*----------------------------------------------------------------------*




FORM process_invoice_create.

  DATA : lv_inv_num  TYPE zpro11_008-belnr,

         lv_processed TYPE c LENGTH 1 VALUE space,

         lv_status_flag TYPE c LENGTH 1,

         lv_item_seq TYPE n LENGTH 6 VALUE '10'.



  CLEAR gt_inv_itm.



  " ALV ### ###

  IF go_alv_grid IS BOUND.

    CALL METHOD go_alv_grid->check_changed_data.

  ENDIF.



  " ### ## ## # #### ##

  LOOP AT gt_inv_item INTO gs_inv_item WHERE sel_flag = 'X'.

    lv_status_flag = gs_inv_item-desc_txt+11(1).



    IF lv_status_flag = 'X'.

      IF lv_processed = space.

        PERFORM generate_invoice_number CHANGING lv_inv_num.

        lv_processed = 'X'.

      ENDIF.

    ELSE.

      MESSAGE '## ## ### ### #####.' TYPE 'E'.

    ENDIF.

  ENDLOOP.



  " ## ### ##

  IF lv_processed = 'X'.

    " ## ### ##

    CLEAR gw_inv_hdr.

    gw_inv_hdr-belnr = lv_inv_num.

    gw_inv_hdr-bldat = p_docdt.

    gw_inv_hdr-budat = p_docdt.

    gw_inv_hdr-gjahr = p_docdt(4).

    gw_inv_hdr-blart = 'RE'.

    APPEND gw_inv_hdr TO gt_inv_hdr.



    " ## ### ##

    LOOP AT gt_inv_item INTO gs_inv_item WHERE sel_flag = 'X'.

      CLEAR gw_inv_itm.



      gw_inv_itm-belnr = lv_inv_num.

      gw_inv_itm-gjahr = p_docdt(4).

      gw_inv_itm-buzei = lv_item_seq.

      gw_inv_itm-ebeln = gs_inv_item-po_num.

      gw_inv_itm-ebelp = gs_inv_item-po_item.

      gw_inv_itm-matnr = gs_inv_item-mat_num.

      gw_inv_itm-bukrs = gs_inv_item-comp_cd.

      gw_inv_itm-menge = gs_inv_item-qty.

      gw_inv_itm-werks = p_plant.

      gw_inv_itm-wrbtr = gs_inv_item-tot_amt.

      gw_inv_itm-shkzg = 'S'.

      gw_inv_itm-mwskz = gs_inv_item-tax_cd.

      gw_inv_itm-bstme = gs_inv_item-base_uom.

      gw_inv_itm-meins = gs_inv_item-base_uom.



      lv_item_seq = lv_item_seq + 10.

      APPEND gw_inv_itm TO gt_inv_itm.

    ENDLOOP.



    " DB ##

    INSERT zpro11_008 FROM TABLE gt_inv_hdr.

    INSERT zpro11_009 FROM TABLE gt_inv_itm.



    MESSAGE '### ##### #######!' TYPE 'S'.

  ELSE.

    MESSAGE '## ### ### ######.' TYPE 'I'.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GENERATE_INVOICE_NUMBER

*&---------------------------------------------------------------------*

*       ###### ## ##

*----------------------------------------------------------------------*




FORM generate_invoice_number CHANGING cv_inv_num TYPE zpro11_008-belnr.

  DATA lv_max_num TYPE zpro11_008-belnr.



  SELECT MAX( belnr )

    INTO lv_max_num

    FROM zpro11_008.



  IF lv_max_num IS INITIAL.

    cv_inv_num = '5000000000'.

  ELSE.

    cv_inv_num = lv_max_num + 1.

    cv_inv_num = |{ cv_inv_num ALPHA = IN }|.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  REVERSE_INVOICE

*&---------------------------------------------------------------------*

*       ## ## ##

*----------------------------------------------------------------------*




FORM reverse_invoice.

  DATA : lt_del_items TYPE TABLE OF zpro11_009,

         ls_del_item  TYPE zpro11_009,

         lv_remaining TYPE i.



  FIELD-SYMBOLS : <fs_row> LIKE gs_search_009.



  " ALV ### ###

  IF go_alv_grid IS BOUND.

    CALL METHOD go_alv_grid->check_changed_data.

  ENDIF.



  " ### ## ##

  LOOP AT gt_search_009 ASSIGNING <fs_row> WHERE sel_flag = 'X'.

    CLEAR ls_del_item.

    ls_del_item-belnr = <fs_row>-belnr.

    ls_del_item-gjahr = <fs_row>-gjahr.

    ls_del_item-buzei = <fs_row>-buzei.

    APPEND ls_del_item TO lt_del_items.

  ENDLOOP.



  IF lt_del_items IS INITIAL.

    MESSAGE '### ### ######.' TYPE 'I'.

    RETURN.

  ENDIF.



  " ## ## ##

  LOOP AT lt_del_items INTO ls_del_item.

    DELETE FROM zpro11_009

      WHERE belnr = @ls_del_item-belnr

        AND gjahr = @ls_del_item-gjahr

        AND buzei = @ls_del_item-buzei.

  ENDLOOP.



  " ## ## ## ## # ##

  LOOP AT lt_del_items INTO ls_del_item.

    SELECT COUNT(*)

      INTO @lv_remaining

      FROM zpro11_009

      WHERE belnr = @ls_del_item-belnr

        AND gjahr = @ls_del_item-gjahr.



    IF lv_remaining = 0.

      DELETE FROM zpro11_008

        WHERE belnr = @ls_del_item-belnr

          AND gjahr = @ls_del_item-gjahr.

    ENDIF.

  ENDLOOP.



  COMMIT WORK.



  " ## ##

  PERFORM load_search_data.

  PERFORM refresh_alv_display.



  MESSAGE '### #######.' TYPE 'S'.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  INIT_ALV_CONTAINER

*&---------------------------------------------------------------------*

*       ALV #### # ### ## ##

*----------------------------------------------------------------------*




FORM init_alv_container.

  CREATE OBJECT go_dock_cont

    EXPORTING

      repid     = sy-repid

      dynnr     = sy-dynnr

      extension = 2000.



  CREATE OBJECT go_alv_grid

    EXPORTING

      i_parent = go_dock_cont.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  BUILD_FIELDCAT_PROCESS

*&---------------------------------------------------------------------*

*       ## ## ### ###### ##

*----------------------------------------------------------------------*




FORM build_fieldcat_process.

  CLEAR : gs_fcat, gt_fcat.



  PERFORM add_field_to_catalog USING:

    '1'  'SEL_FLAG' '##'     '5'  'X' 'X',

    '2'  'COMP_CD'  '####'  '7'  ' ' ' ',

    '3'  'NET_AMT'  '####'  ' '  ' ' ' ',

    '4'  'TAX_AMT'  '##'     ' '  ' ' ' ',

    '5'  'TOT_AMT'  '##'     ' '  ' ' ' ',

    '6'  'CURR_KEY' '##'     '5'  ' ' ' ',

    '7'  'TAX_CD'   '####'  '7'  ' ' ' ',

    '8'  'DESC_TXT' '###'   '13' ' ' ' ',

    '9'  'VENDOR'   '###'   ' '  ' ' ' '.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ADD_FIELD_TO_CATALOG

*&---------------------------------------------------------------------*

*       ####### ## ##

*----------------------------------------------------------------------*




FORM add_field_to_catalog USING iv_pos      TYPE any

                                iv_fname    TYPE any

                                iv_text     TYPE any

                                iv_len      TYPE any

                                iv_edit     TYPE any

                                iv_checkbox TYPE any.

  CLEAR gs_fcat.

  gs_fcat-col_pos   = iv_pos.

  gs_fcat-fieldname = iv_fname.

  gs_fcat-coltext   = iv_text.



  IF iv_len IS NOT INITIAL AND iv_len <> ' '.

    gs_fcat-outputlen = iv_len.

  ENDIF.



  IF iv_edit = 'X'.

    gs_fcat-edit = 'X'.

  ENDIF.



  IF iv_checkbox = 'X'.

    gs_fcat-checkbox = 'X'.

  ENDIF.



  APPEND gs_fcat TO gt_fcat.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  BUILD_FIELDCAT_SEARCH

*&---------------------------------------------------------------------*

*       ## ## ### ###### ##

*----------------------------------------------------------------------*




FORM build_fieldcat_search.

  CLEAR : gs_fcat, gt_fcat.



  PERFORM add_field_to_catalog USING:

    '1'  'SEL_FLAG' '##'         '5'  'X' 'X',

    '2'  'BELNR'    '####'      ' '  ' ' ' ',

    '3'  'GJAHR'    '####'      '6'  ' ' ' ',

    '4'  'BUZEI'    '######'   '10' ' ' ' ',

    '5'  'EBELN'    '######'   '12' ' ' ' ',

    '6'  'EBELP'    '######'   '12' ' ' ' ',

    '7'  'MATNR'    '####'      '7'  ' ' ' ',

    '8'  'BUKRS'    '####'      ' '  ' ' ' ',

    '9'  'WERKS'    '###'       '6'  ' ' ' ',

    '10' 'WRBTR'    '##'         ' '  ' ' ' ',

    '11' 'SHKZG'    '###'       '6'  ' ' ' ',

    '12' 'MWSKZ'    '####'      ' '  ' ' ' ',

    '13' 'MENGE'    '##'         '7'  ' ' ' ',

    '14' 'BSTME'    '##'         '6'  ' ' ' '.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SET_ALV_LAYOUT

*&---------------------------------------------------------------------*

*       ALV #### ##

*----------------------------------------------------------------------*




FORM set_alv_layout.

  CLEAR gs_vari.

  gs_vari-report   = sy-repid.

  gs_vari-username = sy-uname.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SET_ALV_SORT

*&---------------------------------------------------------------------*

*       ALV ## ##

*----------------------------------------------------------------------*




FORM set_alv_sort.

  " ## ## ### ##

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SHOW_ALV_PROCESS

*&---------------------------------------------------------------------*

*       ## ## ALV ##

*----------------------------------------------------------------------*




FORM show_alv_process.

  CALL METHOD go_alv_grid->set_table_for_first_display

    EXPORTING

      is_variant  = gs_vari

      i_save      = 'A'

      is_layout   = gs_layo

    CHANGING

      it_outtab   = gt_inv_item

      it_fieldcatalog = gt_fcat

      it_sort     = gt_sorting.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SHOW_ALV_SEARCH

*&---------------------------------------------------------------------*

*       ## ## ALV ##

*----------------------------------------------------------------------*




FORM show_alv_search.

  CALL METHOD go_alv_grid->set_table_for_first_display

    EXPORTING

      is_variant  = gs_vari

      i_save      = 'A'

      is_layout   = gs_layo

    CHANGING

      it_outtab   = gt_search_009

      it_fieldcatalog = gt_fcat

      it_sort     = gt_sorting.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  REFRESH_ALV_DISPLAY

*&---------------------------------------------------------------------*

*       ALV ## ##

*----------------------------------------------------------------------*




FORM refresh_alv_display.

  DATA ls_stable TYPE lvc_s_stbl.



  ls_stable-row = 'X'.

  ls_stable-col = 'X'.



  CALL METHOD go_alv_grid->refresh_table_display

    EXPORTING

      is_stable = ls_stable.

ENDFORM.