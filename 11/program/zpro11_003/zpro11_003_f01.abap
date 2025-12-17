
*&---------------------------------------------------------------------*

*&  Include           ZPRO11_003_F01

*&---------------------------------------------------------------------*

*& #### ###

*&---------------------------------------------------------------------*



*&---------------------------------------------------------------------*

*&      Form  INIT_DEFAULT_VALUES

*&---------------------------------------------------------------------*




FORM init_default_values.

  p_grdat = sy-datum.

  txt_prc = '####'.

  txt_dsp = '####'.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CONTROL_SCREEN_FIELDS

*&---------------------------------------------------------------------*




FORM control_screen_fields.

  LOOP AT SCREEN.

    CASE screen-group1.

      WHEN 'PRC'.

        IF p_proc = 'X'.

          screen-active = 1.

        ELSE.

          screen-active = 0.

        ENDIF.

    ENDCASE.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CHECK_PO_VALIDITY

*&---------------------------------------------------------------------*




FORM check_po_validity.

  DATA lv_cnt TYPE i.



  SELECT COUNT(*)

    INTO lv_cnt

    FROM zpro11_005

    WHERE ebeln = p_ponum

      AND werks = p_plant.



  IF lv_cnt = 0.

    MESSAGE '## ##### ### ### #### ####.' TYPE 'I'.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  LOAD_PO_DATA

*&---------------------------------------------------------------------*




FORM load_po_data.

  DATA: lt_gr_items TYPE TABLE OF zpro11_007.



  SELECT a~ebeln a~lifnr a~bedat a~waers a~bukrs

         b~ebelp b~matnr b~maktx b~menge b~meins b~bprme b~prdat b~werks b~lgort

    INTO CORRESPONDING FIELDS OF TABLE gt_po_items

    FROM zpro11_004 AS a

    INNER JOIN zpro11_005 AS b

      ON a~ebeln = b~ebeln

    WHERE b~werks = p_plant

      AND a~ebeln = p_ponum.



  LOOP AT gt_po_items ASSIGNING FIELD-SYMBOL(<fs_po>).

    SELECT *

      INTO TABLE lt_gr_items

      FROM zpro11_007

      WHERE ebeln = <fs_po>-ebeln

        AND zeile = <fs_po>-ebelp.



    LOOP AT lt_gr_items INTO gs_dtl_007.

      <fs_po>-menge = <fs_po>-menge - gs_dtl_007-menge.

    ENDLOOP.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  LOAD_GR_HISTORY

*&---------------------------------------------------------------------*




FORM load_gr_history.

  SELECT * FROM zpro11_007

    INTO CORRESPONDING FIELDS OF TABLE gt_gr_hist

    WHERE ebeln = p_ponum

      AND werks = p_plant.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  BUILD_ALV_CONTAINER

*&---------------------------------------------------------------------*




FORM build_alv_container.

  CREATE OBJECT go_dock

    EXPORTING

      repid     = sy-repid

      dynnr     = sy-dynnr

      extension = 2000.



  CREATE OBJECT go_alv

    EXPORTING

      i_parent = go_dock.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  BUILD_FCAT_PROCESS

*&---------------------------------------------------------------------*




FORM build_fcat_process.

  CLEAR : gs_fcat, gt_fcat.



  gs_fcat-col_pos = 1.

  gs_fcat-coltext = '##'.

  gs_fcat-fieldname = 'CHECK'.

  gs_fcat-checkbox = 'X'.

  gs_fcat-edit = 'X'.

  APPEND gs_fcat TO gt_fcat.



  CLEAR gs_fcat.

  gs_fcat-col_pos = 2.

  gs_fcat-coltext = '####'.

  gs_fcat-fieldname = 'EBELN'.

  APPEND gs_fcat TO gt_fcat.



  CLEAR gs_fcat.

  gs_fcat-col_pos = 3.

  gs_fcat-coltext = '##'.

  gs_fcat-fieldname = 'EBELP'.

  gs_fcat-outputlen = 5.

  APPEND gs_fcat TO gt_fcat.



  CLEAR gs_fcat.

  gs_fcat-col_pos = 4.

  gs_fcat-coltext = '#####'.

  gs_fcat-fieldname = 'LIFNR'.

  APPEND gs_fcat TO gt_fcat.



  CLEAR gs_fcat.

  gs_fcat-col_pos = 5.

  gs_fcat-coltext = '###'.

  gs_fcat-fieldname = 'BEDAT'.

  gs_fcat-outputlen = 10.

  APPEND gs_fcat TO gt_fcat.



  CLEAR gs_fcat.

  gs_fcat-col_pos = 6.

  gs_fcat-coltext = '####'.

  gs_fcat-fieldname = 'MATNR'.

  gs_fcat-outputlen = 7.

  APPEND gs_fcat TO gt_fcat.



  CLEAR gs_fcat.

  gs_fcat-col_pos = 7.

  gs_fcat-coltext = '###'.

  gs_fcat-fieldname = 'MAKTX'.

  gs_fcat-outputlen = 7.

  APPEND gs_fcat TO gt_fcat.



  CLEAR gs_fcat.

  gs_fcat-col_pos = 8.

  gs_fcat-coltext = '##'.

  gs_fcat-fieldname = 'MENGE'.

  gs_fcat-decimals = 3.

  gs_fcat-edit = 'X'.

  APPEND gs_fcat TO gt_fcat.



  CLEAR gs_fcat.

  gs_fcat-col_pos = 9.

  gs_fcat-coltext = '##'.

  gs_fcat-fieldname = 'MEINS'.

  gs_fcat-outputlen = 5.

  APPEND gs_fcat TO gt_fcat.



  CLEAR gs_fcat.

  gs_fcat-col_pos = 10.

  gs_fcat-coltext = '##'.

  gs_fcat-fieldname = 'BPRME'.

  APPEND gs_fcat TO gt_fcat.



  CLEAR gs_fcat.

  gs_fcat-col_pos = 11.

  gs_fcat-coltext = '##'.

  gs_fcat-fieldname = 'WAERS'.

  gs_fcat-outputlen = 7.

  APPEND gs_fcat TO gt_fcat.



  CLEAR gs_fcat.

  gs_fcat-col_pos = 12.

  gs_fcat-coltext = '###'.

  gs_fcat-fieldname = 'PRDAT'.

  gs_fcat-outputlen = 10.

  APPEND gs_fcat TO gt_fcat.



  CLEAR gs_fcat.

  gs_fcat-col_pos = 13.

  gs_fcat-coltext = '###'.

  gs_fcat-fieldname = 'WERKS'.

  gs_fcat-outputlen = 7.

  APPEND gs_fcat TO gt_fcat.



  CLEAR gs_fcat.

  gs_fcat-col_pos = 14.

  gs_fcat-coltext = '####'.

  gs_fcat-fieldname = 'LGORT'.

  gs_fcat-outputlen = 7.

  APPEND gs_fcat TO gt_fcat.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  BUILD_FCAT_HISTORY

*&---------------------------------------------------------------------*




FORM build_fcat_history.

  CLEAR : gs_fcat, gt_fcat.



  gs_fcat-col_pos = 1.

  gs_fcat-coltext = '##'.

  gs_fcat-fieldname = 'CHECK'.

  gs_fcat-edit = 'X'.

  gs_fcat-checkbox = 'X'.

  gs_fcat-outputlen = 5.

  APPEND gs_fcat TO gt_fcat.



  CLEAR gs_fcat.

  gs_fcat-col_pos = 2.

  gs_fcat-coltext = '####'.

  gs_fcat-fieldname = 'MBLNR'.

  APPEND gs_fcat TO gt_fcat.



  CLEAR gs_fcat.

  gs_fcat-col_pos = 3.

  gs_fcat-coltext = '####'.

  gs_fcat-fieldname = 'MJAHR'.

  gs_fcat-outputlen = 6.

  APPEND gs_fcat TO gt_fcat.



  CLEAR gs_fcat.

  gs_fcat-col_pos = 4.

  gs_fcat-coltext = '#####'.

  gs_fcat-fieldname = 'ZEILE'.

  gs_fcat-outputlen = 8.

  APPEND gs_fcat TO gt_fcat.



  CLEAR gs_fcat.

  gs_fcat-col_pos = 5.

  gs_fcat-coltext = '####'.

  gs_fcat-fieldname = 'MATNR'.

  gs_fcat-outputlen = 6.

  APPEND gs_fcat TO gt_fcat.



  CLEAR gs_fcat.

  gs_fcat-col_pos = 6.

  gs_fcat-coltext = '###'.

  gs_fcat-fieldname = 'WERKS'.

  gs_fcat-outputlen = 6.

  APPEND gs_fcat TO gt_fcat.



  CLEAR gs_fcat.

  gs_fcat-col_pos = 7.

  gs_fcat-coltext = '####'.

  gs_fcat-fieldname = 'LGORT'.

  gs_fcat-outputlen = 7.

  APPEND gs_fcat TO gt_fcat.



  CLEAR gs_fcat.

  gs_fcat-col_pos = 8.

  gs_fcat-coltext = '#####'.

  gs_fcat-fieldname = 'LIFNR'.

  APPEND gs_fcat TO gt_fcat.



  CLEAR gs_fcat.

  gs_fcat-col_pos = 9.

  gs_fcat-coltext = '###'.

  gs_fcat-fieldname = 'WAERS'.

  gs_fcat-outputlen = 6.

  APPEND gs_fcat TO gt_fcat.



  CLEAR gs_fcat.

  gs_fcat-col_pos = 10.

  gs_fcat-coltext = '##'.

  gs_fcat-fieldname = 'MENGE'.

  gs_fcat-outputlen = 7.

  APPEND gs_fcat TO gt_fcat.



  CLEAR gs_fcat.

  gs_fcat-col_pos = 11.

  gs_fcat-coltext = '##'.

  gs_fcat-fieldname = 'MEINS'.

  gs_fcat-outputlen = 5.

  APPEND gs_fcat TO gt_fcat.



  CLEAR gs_fcat.

  gs_fcat-col_pos = 12.

  gs_fcat-coltext = '######'.

  gs_fcat-fieldname = 'EBELN'.

  APPEND gs_fcat TO gt_fcat.



  CLEAR gs_fcat.

  gs_fcat-col_pos = 13.

  gs_fcat-coltext = '####'.

  gs_fcat-fieldname = 'BUKRS'.

  gs_fcat-outputlen = 7.

  APPEND gs_fcat TO gt_fcat.



  CLEAR gs_fcat.

  gs_fcat-col_pos = 14.

  gs_fcat-coltext = '####'.

  gs_fcat-fieldname = 'GJAHR'.

  gs_fcat-outputlen = 7.

  APPEND gs_fcat TO gt_fcat.



  CLEAR gs_fcat.

  gs_fcat-col_pos = 15.

  gs_fcat-coltext = '####'.

  gs_fcat-fieldname = 'BELNR'.

  gs_fcat-outputlen = 6.

  APPEND gs_fcat TO gt_fcat.



  CLEAR gs_fcat.

  gs_fcat-col_pos = 16.

  gs_fcat-coltext = '###'.

  gs_fcat-fieldname = 'SHKZG'.

  gs_fcat-outputlen = 6.

  APPEND gs_fcat TO gt_fcat.



  CLEAR gs_fcat.

  gs_fcat-col_pos = 17.

  gs_fcat-coltext = '##'.

  gs_fcat-fieldname = 'DMBTR'.

  APPEND gs_fcat TO gt_fcat.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SET_ALV_VARIANT

*&---------------------------------------------------------------------*




FORM set_alv_variant.

  CLEAR gs_vari.

  gs_vari-report = sy-repid.

  gs_vari-username = sy-uname.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SET_ALV_SORT

*&---------------------------------------------------------------------*




FORM set_alv_sort.

  CLEAR gt_sort.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SHOW_ALV_PROCESS

*&---------------------------------------------------------------------*




FORM show_alv_process.

  CALL METHOD go_alv->set_table_for_first_display

    EXPORTING

      is_variant      = gs_vari

      i_save          = 'A'

      is_layout       = gs_layo

    CHANGING

      it_outtab       = gt_po_items

      it_fieldcatalog = gt_fcat

      it_sort         = gt_sort.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SHOW_ALV_HISTORY

*&---------------------------------------------------------------------*




FORM show_alv_history.

  CALL METHOD go_alv->set_table_for_first_display

    EXPORTING

      is_variant      = gs_vari

      i_save          = 'A'

      is_layout       = gs_layo

    CHANGING

      it_outtab       = gt_gr_hist

      it_fieldcatalog = gt_fcat

      it_sort         = gt_sort.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  REFRESH_ALV

*&---------------------------------------------------------------------*




FORM refresh_alv.

  DATA : ls_stable TYPE lvc_s_stbl.



  ls_stable-row = 'X'.

  ls_stable-col = 'X'.



  CALL METHOD go_alv->refresh_table_display

    EXPORTING

      is_stable = ls_stable.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  PROCESS_GOODS_RECEIPT

*&---------------------------------------------------------------------*




FORM process_goods_receipt.

  IF go_alv IS BOUND.

    CALL METHOD go_alv->check_changed_data.

  ENDIF.



  DATA : lv_docnum TYPE zpro11_006-mblnr.

  DATA : lv_flag TYPE c VALUE 1.



  LOOP AT gt_po_items INTO gs_po_item.

    IF gs_po_item-check = 'X'.

      IF gs_po_item-menge = 0.

        MESSAGE '## ### ### ####' TYPE 'E'.

      ENDIF.



      IF lv_flag = 1.

        PERFORM generate_gr_number CHANGING lv_docnum.

        lv_flag = 2.

      ENDIF.

    ENDIF.

  ENDLOOP.



  IF lv_flag = 2.

    " ## ##

    gs_hdr_006-mblnr = lv_docnum.

    gs_hdr_006-bldat = p_grdat.

    gs_hdr_006-budat = p_grdat.

    gs_hdr_006-mjahr = p_grdat(4).

    gs_hdr_006-blart = 'WE'.

    APPEND gs_hdr_006 TO gt_hdr_006.



    " ### ##

    DATA : lv_seq TYPE c VALUE 0000000001.

    DATA : lv_qty TYPE menge_d.

    DATA : lv_po_num TYPE ebeln,

           lv_po_itm TYPE ebelp.



    LOOP AT gt_po_items INTO gs_po_item.

      CLEAR gs_dtl_007.



      IF gs_po_item-check = 'X'.

        lv_po_num = gs_po_item-ebeln.

        lv_po_itm = gs_po_item-ebelp.



        gs_dtl_007-mblnr = lv_docnum.

        gs_dtl_007-mjahr = p_grdat(4).

        gs_dtl_007-zeile = gs_po_item-ebelp.

        gs_dtl_007-matnr = gs_po_item-matnr.

        gs_dtl_007-werks = gs_po_item-werks.

        gs_dtl_007-lgort = gs_po_item-lgort.

        gs_dtl_007-lifnr = gs_po_item-lifnr.

        gs_dtl_007-waers = gs_po_item-waers.

        gs_dtl_007-menge = gs_po_item-menge.

        lv_qty = gs_dtl_007-menge.

        gs_dtl_007-meins = gs_po_item-meins.

        gs_dtl_007-ebeln = gs_po_item-ebeln.

        gs_dtl_007-bukrs = gs_po_item-bukrs.

        gs_dtl_007-gjahr = sy-datum(4).

        gs_dtl_007-belnr = lv_seq.

        lv_seq = lv_seq + 1.

        gs_dtl_007-shkzg = 'S'.

        gs_dtl_007-dmbtr = gs_po_item-menge * gs_po_item-bprme.



        APPEND gs_dtl_007 TO gt_dtl_007.



        PERFORM update_remaining_qty USING lv_po_num lv_po_itm lv_qty.



        CLEAR gs_po_item.

      ENDIF.

    ENDLOOP.



    INSERT zpro11_006 FROM TABLE gt_hdr_006.

    INSERT zpro11_007 FROM TABLE gt_dtl_007.

  ELSE.

    MESSAGE '#### ### ####' TYPE 'I'.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GENERATE_GR_NUMBER

*&---------------------------------------------------------------------*




FORM generate_gr_number CHANGING pv_docnum TYPE zpro11_006-mblnr.

  DATA : lv_maxnum TYPE zpro11_006-mblnr.



  SELECT MAX( mblnr ) INTO lv_maxnum FROM zpro11_006.



  IF lv_maxnum IS INITIAL.

    pv_docnum = '5000000000'.

  ELSE.

    pv_docnum = lv_maxnum + 1.

    pv_docnum = |{ pv_docnum ALPHA = IN }|.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  UPDATE_REMAINING_QTY

*&---------------------------------------------------------------------*




FORM update_remaining_qty USING pv_ponum pv_poitm pv_qty.

  SELECT SINGLE *

    INTO gs_itm_005

    FROM zpro11_005

    WHERE ebeln = pv_ponum

      AND ebelp = pv_poitm.



  LOOP AT gt_po_items INTO gs_po_item.

    IF gs_po_item-ebeln = pv_ponum AND gs_po_item-ebelp = pv_poitm.

      gs_po_item-menge = gs_itm_005-menge - pv_qty.



      IF gs_po_item-menge < 0.

        MESSAGE '### ###### # #######' TYPE 'E'.

      ELSE.

        MODIFY gt_po_items FROM gs_po_item INDEX sy-tabix.

        MESSAGE '##### #######!' TYPE 'S'.

      ENDIF.

    ENDIF.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  PROCESS_GR_REVERSAL

*&---------------------------------------------------------------------*




FORM process_gr_reversal.

  IF go_alv IS BOUND.

    CALL METHOD go_alv->check_changed_data.

  ENDIF.



  DATA: lt_del_items TYPE TABLE OF zpro11_007,

        ls_del_item  TYPE zpro11_007.



  FIELD-SYMBOLS: <fs_row> LIKE gs_gr_hist.



  LOOP AT gt_gr_hist ASSIGNING <fs_row> WHERE check = 'X'.

    CLEAR ls_del_item.

    ls_del_item-mblnr = <fs_row>-mblnr.

    ls_del_item-mjahr = <fs_row>-mjahr.

    ls_del_item-zeile = <fs_row>-zeile.

    APPEND ls_del_item TO lt_del_items.

  ENDLOOP.



  IF lt_del_items IS INITIAL.

    MESSAGE '### ## ####.' TYPE 'I'.

    RETURN.

  ENDIF.



  " ### ##

  LOOP AT lt_del_items INTO ls_del_item.

    DELETE FROM zpro11_007

      WHERE mblnr = @ls_del_item-mblnr

        AND mjahr = @ls_del_item-mjahr

        AND zeile = @ls_del_item-zeile.

  ENDLOOP.



  " ## ## (### ## ### ##)

  DATA lv_cnt TYPE i.



  LOOP AT lt_del_items INTO ls_del_item.

    SELECT COUNT(*) INTO @lv_cnt

      FROM zpro11_007

      WHERE mblnr = @ls_del_item-mblnr

        AND mjahr = @ls_del_item-mjahr.



    IF lv_cnt = 0.

      DELETE FROM zpro11_006

        WHERE mblnr = @ls_del_item-mblnr

          AND mjahr = @ls_del_item-mjahr.

    ENDIF.

  ENDLOOP.



  COMMIT WORK.



  PERFORM load_gr_history.

  PERFORM refresh_alv.



  MESSAGE '## ## #####' TYPE 'S'.

ENDFORM.