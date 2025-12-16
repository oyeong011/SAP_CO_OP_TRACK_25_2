
*&---------------------------------------------------------------------*

*&  Include           ZPROJECT17_004_F01

*&---------------------------------------------------------------------*



*&---------------------------------------------------------------------*

*&      Form  INIT_SELECTION

*&---------------------------------------------------------------------*




FORM init_selection.



  " ## ##: ####

  p_r_cre = 'X'.

  p_r_dis = ''.



  " ##### ###: ## (## ##### ##)

  p_budat  = sy-datum.

  gv_budat = p_budat.



  " #### ###(### ##)

  IF p_ebeln IS INITIAL.

    p_ebeln = '4500000001'.

  ENDIF.



  IF p_werks IS INITIAL.

    p_werks = '1000'.

  ENDIF.



ENDFORM.                    " INIT_SELECTION








*&---------------------------------------------------------------------*

*&      Form  MODIFY_SCREEN

*&---------------------------------------------------------------------*




FORM modify_screen.



  " ###### ## MODIF ID C1(#####) on/off

  LOOP AT SCREEN.



    IF screen-group1 = 'C1'.



      IF p_r_cre = 'X'.

        screen-active = '1'.  " ####: ##### ##



        " ##### ##### ### ##### ### ##

        IF p_budat IS INITIAL AND gv_budat IS NOT INITIAL.

          p_budat = gv_budat.

        ENDIF.



      ELSE.

        screen-active = '0'.  " ####: ##### ##



        " ##### ## # ### ## ## # ##

        IF p_budat IS NOT INITIAL.

          gv_budat = p_budat.

          CLEAR p_budat.

        ENDIF.



      ENDIF.



      MODIFY SCREEN.

    ENDIF.



  ENDLOOP.



ENDFORM.                    " MODIFY_SCREEN








*&---------------------------------------------------------------------*

*&      Form  DETERMINE_MODE

*&---------------------------------------------------------------------*




FORM determine_mode.



  IF p_r_cre = 'X'.

    gv_mode = c_mode_cre.

  ELSEIF p_r_dis = 'X'.

    gv_mode = c_mode_disp.

  ELSE.

    gv_mode = c_mode_cre.

  ENDIF.



ENDFORM.                    " DETERMINE_MODE








*&---------------------------------------------------------------------*

*&      Form  CHECK_SELECTION

*&---------------------------------------------------------------------*




FORM check_selection.

  DATA: lv_dummy TYPE c.

  DATA: lv_cnt TYPE i.



  " ## ##: #### / ###

  IF p_ebeln IS INITIAL.

    MESSAGE '##### #####.' TYPE 'S' DISPLAY LIKE 'E'.

    STOP.

  ENDIF.



  IF p_werks IS INITIAL.

    MESSAGE '#### #####.' TYPE 'S' DISPLAY LIKE 'E'.

    STOP.

  ENDIF.



  " #### ## ##: #####(#####/###)

  IF gv_mode = c_mode_cre.

    IF p_budat IS INITIAL.

      MESSAGE '#####(###)# #####.' TYPE 'S' DISPLAY LIKE 'E'.

      STOP.

    ENDIF.

  ENDIF.



  " #### ## ### ## (ZEDT17_EKKO ##)

  SELECT SINGLE ebeln

    INTO lv_dummy

    FROM zedt17_ekko

    WHERE ebeln = p_ebeln.



  IF sy-subrc <> 0.

    MESSAGE '#### ## #######.' TYPE 'S' DISPLAY LIKE 'E'.

    STOP.

  ENDIF.



  " PO-### ## ##: ## PO# ### ### #### #### #

  CLEAR lv_cnt.

  SELECT COUNT( * ) INTO lv_cnt

    FROM zedt17_ekpo

    WHERE ebeln  = p_ebeln

      AND zwerks = p_werks.



  IF lv_cnt = 0.

    MESSAGE '## ##### ### ### ### ### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    STOP.

  ENDIF.



ENDFORM.                    " CHECK_SELECTION



FORM create_object_0100 .



  IF go_container IS INITIAL.



    CREATE OBJECT go_container

      EXPORTING

        container_name = 'CC_ALV'.



    CREATE OBJECT go_alv

      EXPORTING

        i_parent = go_container.



    " ### ### ##/##

    IF go_evt_rcv IS INITIAL.

      CREATE OBJECT go_evt_rcv.

    ENDIF.

    SET HANDLER go_evt_rcv->handle_data_changed FOR go_alv.



    " ## # DATA_CHANGED ##

    CALL METHOD go_alv->register_edit_event

      EXPORTING

        i_event_id = cl_gui_alv_grid=>mc_evt_enter.



  ENDIF.





ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  DISABLE_HEADER_FIELDS

*&---------------------------------------------------------------------*




FORM disable_header_fields .



  LOOP AT SCREEN.

    IF screen-group1 = 'H1'.   " ## ### ##

      screen-input = '0'.      " ## ##

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



ENDFORM.



FORM get_data_for_invoice_0100 .



  DATA: lv_mwskz    TYPE zedt17_lfm1-mwskz,

        lv_gr_qty   TYPE zedt17_mseg-menge,

        lv_iv_qty   TYPE zedt17_rseg-menge,

        lv_open_qty TYPE zedt17_ekpo-menge.



  CLEAR gt_iv_alv.

  REFRESH gt_iv_alv.



  IF p_ebeln IS INITIAL OR p_werks IS INITIAL.

    RETURN.

  ENDIF.



  " 1) PO ##+### ## (PO ### PO_MENGE# ##)

  SELECT

    a~ebeln

    b~ebelp

    a~lifnr

    a~waers

    b~zmatnr

    b~maktx

    b~zwerks

    b~zlgort

    b~menge  AS po_menge

    b~meins

    b~stprs

    INTO CORRESPONDING FIELDS OF TABLE gt_iv_alv

    FROM zedt17_ekko AS a

    INNER JOIN zedt17_ekpo AS b

      ON a~ebeln = b~ebeln

    WHERE a~ebeln  = p_ebeln

      AND b~zwerks = p_werks.



  IF gt_iv_alv IS INITIAL.

    RETURN.

  ENDIF.



  " 2) ###: #### ## + GR/### ## + ###### ##

  LOOP AT gt_iv_alv INTO gs_iv_alv.



    " (A) PO ### SELECT## PO_MENGE# ## ### (## ## ###)



    " (B) ####(LFM1) ##

    CLEAR lv_mwskz.

    SELECT SINGLE mwskz

      INTO lv_mwskz

      FROM zedt17_lfm1

      WHERE lifnr = gs_iv_alv-lifnr.



    IF sy-subrc = 0 AND lv_mwskz IS NOT INITIAL.

      gs_iv_alv-mwskz = lv_mwskz.

    ENDIF.



    " (C) ### ###

    IF gs_iv_alv-shkzg IS INITIAL.

      gs_iv_alv-shkzg = 'S'.

    ENDIF.



    " (D) #####(GR) ##

    CLEAR lv_gr_qty.

    SELECT SUM( menge )

      INTO lv_gr_qty

      FROM zedt17_mseg

      WHERE ebeln = gs_iv_alv-ebeln

        AND matnr = gs_iv_alv-zmatnr

        AND werks = gs_iv_alv-zwerks

        AND lgort = gs_iv_alv-zlgort.



    IF sy-subrc <> 0 OR lv_gr_qty IS INITIAL.

      lv_gr_qty = 0.

    ENDIF.

    gs_iv_alv-gr_menge = lv_gr_qty.



    " (E) #####(IV) ##

    CLEAR lv_iv_qty.

    SELECT SUM( menge )

      INTO lv_iv_qty

      FROM zedt17_rseg

      WHERE ebeln = gs_iv_alv-ebeln

        AND ebelp = gs_iv_alv-ebelp.



    IF sy-subrc <> 0 OR lv_iv_qty IS INITIAL.

      lv_iv_qty = 0.

    ENDIF.

    gs_iv_alv-iv_menge = lv_iv_qty.



    " (F) ###### ##

    CLEAR lv_open_qty.

    IF gs_iv_alv-gr_menge > 0.

      lv_open_qty = gs_iv_alv-gr_menge - gs_iv_alv-iv_menge.

    ELSE.

      lv_open_qty = gs_iv_alv-po_menge - gs_iv_alv-iv_menge.

    ENDIF.



    IF lv_open_qty < 0.

      lv_open_qty = 0.

    ENDIF.



    gs_iv_alv-open_menge = lv_open_qty.



    " ## #### ###: ####

    gs_iv_alv-inv_menge = gs_iv_alv-open_menge.



    MODIFY gt_iv_alv FROM gs_iv_alv INDEX sy-tabix.



  ENDLOOP.



  " 3) #### 0## #### ##

  DELETE gt_iv_alv WHERE open_menge <= 0.



  " 4) ##/## ## (inv_menge ##)

  PERFORM calc_amounts_0100.



ENDFORM.











FORM build_fcat_0100 .



  CLEAR gt_fcat.

  REFRESH gt_fcat.



  PERFORM add_fcat_0100 USING 'L_CHECK' '##'     'X'.

  PERFORM add_fcat_0100 USING 'EBELN'   '####' ''.

  PERFORM add_fcat_0100 USING 'EBELP'   '##'     ''.

  PERFORM add_fcat_0100 USING 'LIFNR'   '###'   ''.

  PERFORM add_fcat_0100 USING 'ZMATNR'  '##'     ''.

  PERFORM add_fcat_0100 USING 'MAKTX'   '###'   ''.






*  PERFORM add_fcat_0100 USING 'ZWERKS'  '###'   ''.

*  PERFORM add_fcat_0100 USING 'MENGE'   '##'     ''.








  " ===== ## ## =====

  PERFORM add_fcat_0100 USING 'PO_MENGE'   'PO##'      ''.

  PERFORM add_fcat_0100 USING 'GR_MENGE'   '#####'  ''.

  PERFORM add_fcat_0100 USING 'IV_MENGE'   '#####'  ''.

  PERFORM add_fcat_0100 USING 'OPEN_MENGE' '####'    ''.

  PERFORM add_fcat_0100 USING 'INV_MENGE'  '####'    'X'.







  PERFORM add_fcat_0100 USING 'MEINS'   '##'     ''.

  PERFORM add_fcat_0100 USING 'STPRS'   '##'     ''.

  PERFORM add_fcat_0100 USING 'WAERS'   '##'     ''.

  PERFORM add_fcat_0100 USING 'WRBTR'   '####' ''.

  PERFORM add_fcat_0100 USING 'WMWST'   '##'     ''.

  PERFORM add_fcat_0100 USING 'TOT_AMT' '###'   ''.

  PERFORM add_fcat_0100 USING 'MWSKZ'   '####' 'X'.

  PERFORM add_fcat_0100 USING 'SHKZG'   '#/#'    ''.



ENDFORM.





FORM add_fcat_0100 USING    p_fieldname TYPE lvc_fname

                            p_coltext   TYPE scrtext_l

                            p_edit      TYPE c.



  CLEAR gs_fcat.



  gs_fcat-fieldname = p_fieldname.

  gs_fcat-coltext   = p_coltext.



  IF p_edit = 'X'.

    gs_fcat-edit = 'X'.

  ENDIF.





  CASE p_fieldname.



    WHEN 'L_CHECK'.

      gs_fcat-checkbox  = 'X'.

      gs_fcat-edit      = 'X'.

      gs_fcat-outputlen = 3.

    WHEN 'SHKZG'.

      gs_fcat-no_out = 'X'. " SHKZG(#/#) ## ##

    WHEN 'EBELN'.

      gs_fcat-outputlen = 10.

    WHEN 'EBELP'.

      gs_fcat-outputlen = 4.

    WHEN 'LIFNR' OR 'ZMATNR'.

      gs_fcat-outputlen = 10.

    WHEN 'MAKTX'.

      gs_fcat-outputlen = 20.

    WHEN 'ZWERKS'.

      gs_fcat-outputlen = 6.



    WHEN 'MENGE'.

      gs_fcat-ref_table  = 'ZEDT17_EKPO'.

      gs_fcat-ref_field  = 'MENGE'.

      gs_fcat-qfieldname = 'MEINS'.

      gs_fcat-outputlen  = 8.



    WHEN 'MEINS' OR 'WAERS'.

      gs_fcat-outputlen = 4.



    WHEN 'STPRS'.

      gs_fcat-outputlen = 10.



    WHEN 'WRBTR' OR 'WMWST'.

      gs_fcat-ref_table  = 'ZEDT17_RSEG'.

      gs_fcat-ref_field  = 'WRBTR'.

      gs_fcat-cfieldname = 'WAERS'.

      gs_fcat-outputlen  = 12.



    WHEN 'TOT_AMT'.

      gs_fcat-outputlen  = 12.



    WHEN 'MWSKZ'.

      gs_fcat-outputlen = 6.



    WHEN 'SHKZG'.

      gs_fcat-outputlen = 3.





    WHEN 'PO_MENGE' OR 'GR_MENGE'

  OR 'IV_MENGE' OR 'OPEN_MENGE'

  OR 'INV_MENGE'.



      gs_fcat-ref_table  = 'ZEDT17_EKPO'.

      gs_fcat-ref_field  = 'MENGE'.

      gs_fcat-qfieldname = 'MEINS'.

      gs_fcat-outputlen  = 8.



      " ## ##### ## ##

      IF p_fieldname = 'INV_MENGE'.

        gs_fcat-edit = 'X'.

      ENDIF.





  ENDCASE.



  APPEND gs_fcat TO gt_fcat.



ENDFORM.



FORM alv_display_0100 .



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

      it_outtab       = gt_iv_alv.



ENDFORM.





FORM refresh_alv_0100 .



  IF go_alv IS BOUND.

    CALL METHOD go_alv->refresh_table_display( ).

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CALC_AMOUNTS_0100

*&---------------------------------------------------------------------*




FORM calc_amounts_0100 .



  CONSTANTS: gc_rate_10 TYPE p LENGTH 5 DECIMALS 3 VALUE '0.100',

             gc_rate_00 TYPE p LENGTH 5 DECIMALS 3 VALUE '0.000'.



  DATA: lv_net  TYPE p LENGTH 13 DECIMALS 2,

        lv_tax  TYPE p LENGTH 13 DECIMALS 2,

        lv_rate TYPE p LENGTH 5  DECIMALS 3.



  LOOP AT gt_iv_alv INTO gs_iv_alv.



    CLEAR: lv_net, lv_tax, lv_rate.



    " #### = ###### * ##

    lv_net = gs_iv_alv-inv_menge * gs_iv_alv-stprs.



    CASE gs_iv_alv-mwskz.

      WHEN 'V1' OR 'V4' OR 'V5'.

        lv_rate = gc_rate_10.

      WHEN 'V2' OR 'V3'.

        lv_rate = gc_rate_00.

      WHEN OTHERS.

        " ### 0 #### ### ###, ### # #### ##### ## ##

        lv_rate = gc_rate_00.

    ENDCASE.



    lv_tax = lv_net * lv_rate.



    gs_iv_alv-wrbtr = lv_net.

    gs_iv_alv-wmwst = lv_tax.

    gs_iv_alv-tot_amt = lv_net + lv_tax.



    MODIFY gt_iv_alv FROM gs_iv_alv INDEX sy-tabix.



  ENDLOOP.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CREATE_INVOICE_DOCUMENT

*&---------------------------------------------------------------------*




FORM create_invoice_document .



  DATA: lt_sel    TYPE STANDARD TABLE OF ty_iv_alv,

        ls_sel    TYPE ty_iv_alv,

        lt_rseg   TYPE STANDARD TABLE OF zedt17_rseg,

        ls_rseg   TYPE zedt17_rseg,

        ls_rbkp   TYPE zedt17_rbkp,

        lv_belnr  TYPE zedt17_rbkp-belnr,

        lv_gjahr  TYPE zedt17_rbkp-gjahr,

        lv_buzei  TYPE zedt17_rseg-buzei,

        lv_answer TYPE c LENGTH 1,

        lv_bukrs  TYPE zedt17_ekko-bukrs,

        lv_lifnr  TYPE zedt17_ekko-lifnr,

        lv_waers  TYPE zedt17_ekko-waers,

        lv_bktxt  TYPE zedt17_rbkp-bktxt.



  " 1) ALV #### ##

  IF go_alv IS BOUND.

    CALL METHOD go_alv->check_changed_data.

  ENDIF.



  " 2) ## ## ##

  CLEAR lt_sel.

  REFRESH lt_sel.



  LOOP AT gt_iv_alv INTO gs_iv_alv WHERE l_check = 'X'.

    APPEND gs_iv_alv TO lt_sel.

  ENDLOOP.



  IF lt_sel IS INITIAL.

    MESSAGE '##### ### #####.' TYPE 'S' DISPLAY LIKE 'E'.

    RETURN.

  ENDIF.



  " 3) ### ##

  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      titlebar              = '####'

      text_question         = '### ### ## ### ########?'

      text_button_1         = '#'

      text_button_2         = '###'

      display_cancel_button = ' '

    IMPORTING

      answer                = lv_answer.



  IF lv_answer <> '1'.

    RETURN.

  ENDIF.



  " 4) PO #### ####/###/## #### (##### #### #### ##)

  CLEAR: lv_bukrs, lv_lifnr, lv_waers.

  SELECT SINGLE bukrs lifnr waers

    INTO (lv_bukrs, lv_lifnr, lv_waers)

    FROM zedt17_ekko

    WHERE ebeln = p_ebeln.



  IF sy-subrc <> 0.

    MESSAGE '#### ### ## # ####.' TYPE 'S' DISPLAY LIKE 'E'.

    RETURN.

  ENDIF.



  " 5) ## ###### ## (RBKP MAX + 1)

  CLEAR lv_belnr.

  SELECT SINGLE MAX( belnr )

    INTO lv_belnr

    FROM zedt17_rbkp.



  IF sy-subrc <> 0 OR lv_belnr IS INITIAL OR lv_belnr < gc_belnr_start.

    lv_belnr = gc_belnr_start.

  ELSE.

    lv_belnr = lv_belnr + 1.

  ENDIF.



  " ####: ##### ##(YYYY)

  lv_gjahr = p_budat+0(4).



  " #####: ###### 10## + ####

  CLEAR lv_bktxt.

  CONCATENATE p_ebeln '####' INTO lv_bktxt SEPARATED BY space.



  " 6) ##(RBKP) ##

  CLEAR ls_rbkp.

  ls_rbkp-belnr = lv_belnr.

  ls_rbkp-gjahr = lv_gjahr.

  ls_rbkp-bukrs = lv_bukrs.

  ls_rbkp-lifnr = lv_lifnr.

  ls_rbkp-ebeln = p_ebeln.

  ls_rbkp-blart = 'RE'.     " ## #### (#### ##)

  ls_rbkp-bldat = p_budat.  " ###

  ls_rbkp-budat = p_budat.  " ###(### FI## # #### ### ##)

  ls_rbkp-waers = lv_waers.

  ls_rbkp-bktxt = lv_bktxt.



  INSERT zedt17_rbkp FROM ls_rbkp.

  IF sy-subrc <> 0.

    ROLLBACK WORK.

    MESSAGE '#### ## # ### ######.' TYPE 'S' DISPLAY LIKE 'E'.

    RETURN.

  ENDIF.



  " 7) ###(RSEG) ##

  CLEAR: lt_rseg, lv_buzei.

  REFRESH lt_rseg.



  LOOP AT lt_sel INTO ls_sel.



    lv_buzei = lv_buzei + 1.



    CLEAR ls_rseg.

    ls_rseg-belnr  = lv_belnr.

    ls_rseg-gjahr  = lv_gjahr.

    ls_rseg-buzei  = lv_buzei.



    ls_rseg-ebeln  = ls_sel-ebeln.

    ls_rseg-ebelp  = ls_sel-ebelp.

    ls_rseg-zmatnr = ls_sel-zmatnr.

    ls_rseg-maktx  = ls_sel-maktx.

    ls_rseg-zwerks = ls_sel-zwerks.




*    ls_rseg-menge  = ls_sel-menge.




    ls_rseg-menge = ls_sel-inv_menge.



    ls_rseg-meins  = ls_sel-meins.



    ls_rseg-wrbtr  = ls_sel-wrbtr.  " ####

    ls_rseg-wmwst  = ls_sel-wmwst.  " ##

    ls_rseg-mwskz  = ls_sel-mwskz.  " ####(V1~V5)

    ls_rseg-shkzg  = ls_sel-shkzg.



    APPEND ls_rseg TO lt_rseg.



  ENDLOOP.



  IF lt_rseg IS INITIAL.

    ROLLBACK WORK.

    MESSAGE '### ## ### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    RETURN.

  ENDIF.



  INSERT zedt17_rseg FROM TABLE lt_rseg.

  IF sy-subrc <> 0.

    ROLLBACK WORK.

    MESSAGE '##### ## # ### ######.' TYPE 'S' DISPLAY LIKE 'E'.

    RETURN.

  ENDIF.



  COMMIT WORK AND WAIT.



  MESSAGE '### #######.' TYPE 'S'.



  " 8) ## # #### ### # ## ### ### ### #

  PERFORM get_data_for_invoice_0100.

  PERFORM refresh_alv_0100.



ENDFORM.



FORM alv_handle_data_changed USING p_data_changed TYPE REF TO cl_alv_changed_data_protocol.



  DATA: ls_mod_cell TYPE lvc_s_modi,

        ls_line     TYPE ty_iv_alv,

        lv_rate     TYPE p LENGTH 5 DECIMALS 3,

        lv_tax      TYPE p LENGTH 13 DECIMALS 2.



  LOOP AT p_data_changed->mt_mod_cells INTO ls_mod_cell.



    CASE ls_mod_cell-fieldname.



      WHEN 'MWSKZ'.



        " ## ## ## (## # ###)

        READ TABLE gt_iv_alv INTO ls_line INDEX ls_mod_cell-row_id.

        IF sy-subrc <> 0.

          CONTINUE.

        ENDIF.



        " --- 1) #### ### ## (V1~V5# ##)

        IF ls_mod_cell-value <> 'V1'

           AND ls_mod_cell-value <> 'V2'

           AND ls_mod_cell-value <> 'V3'

           AND ls_mod_cell-value <> 'V4'

           AND ls_mod_cell-value <> 'V5'.



          MESSAGE '##### V1~V5# ## #####.' TYPE 'S' DISPLAY LIKE 'E'.



          " ## ### ##

          CALL METHOD p_data_changed->modify_cell

            EXPORTING

              i_row_id    = ls_mod_cell-row_id

              i_fieldname = 'MWSKZ'

              i_value     = ls_line-mwskz.



          CONTINUE.

        ENDIF.



        " --- 2) ### ##

        ls_line-mwskz = ls_mod_cell-value.



        " --- 3) ## ##

        PERFORM get_tax_rate USING ls_line-mwskz CHANGING lv_rate.



        " --- 4) ## ###

        lv_tax = ls_line-wrbtr * lv_rate.

        ls_line-wmwst = lv_tax.

        ls_line-tot_amt = ls_line-wrbtr + ls_line-wmwst.





        MODIFY gt_iv_alv FROM ls_line INDEX ls_mod_cell-row_id.



        " --- 5) ## ## ##

        CALL METHOD p_data_changed->modify_cell

          EXPORTING

            i_row_id    = ls_mod_cell-row_id

            i_fieldname = 'WMWST'

            i_value     = lv_tax.



        CALL METHOD p_data_changed->modify_cell

          EXPORTING

            i_row_id    = ls_mod_cell-row_id

            i_fieldname = 'TOT_AMT'

            i_value     = ls_line-tot_amt.





      WHEN 'INV_MENGE'.



        " ## ## ##

        READ TABLE gt_iv_alv INTO ls_line INDEX ls_mod_cell-row_id.

        IF sy-subrc <> 0.

          CONTINUE.

        ENDIF.



        " 1) 1 ## ## ##

        IF ls_mod_cell-value < 1.



          MESSAGE '##### 1 ##### ###.' TYPE 'S' DISPLAY LIKE 'E'.



          CALL METHOD p_data_changed->modify_cell

            EXPORTING

              i_row_id    = ls_mod_cell-row_id

              i_fieldname = 'INV_MENGE'

              i_value     = ls_line-inv_menge.



          CONTINUE.

        ENDIF.



        " 2) #### ## ##

        IF ls_mod_cell-value > ls_line-open_menge.



          MESSAGE '##### ##### ######.' TYPE 'S' DISPLAY LIKE 'E'.



          CALL METHOD p_data_changed->modify_cell

            EXPORTING

              i_row_id    = ls_mod_cell-row_id

              i_fieldname = 'INV_MENGE'

              i_value     = ls_line-open_menge.



          CONTINUE.

        ENDIF.



        " 3) ### # ## ## + ## ###

        ls_line-inv_menge = ls_mod_cell-value.



        MODIFY gt_iv_alv FROM ls_line INDEX ls_mod_cell-row_id.



        " ##/## ###

        PERFORM calc_amounts_0100.



        " ## ####

        CALL METHOD go_alv->refresh_table_display( ).



      WHEN OTHERS.

    ENDCASE.



  ENDLOOP.



ENDFORM.








*DATA: gv_rate TYPE p LENGTH 5 DECIMALS 3.






FORM get_tax_rate USING    p_mwskz TYPE zedt17_rseg-mwskz

                  CHANGING p_rate  LIKE gv_rate.





  CONSTANTS: gc_rate_10 TYPE p LENGTH 5 DECIMALS 3 VALUE '0.100',

             gc_rate_00 TYPE p LENGTH 5 DECIMALS 3 VALUE '0.000'.



  CLEAR p_rate.



  CASE p_mwskz.

    WHEN 'V1' OR 'V4' OR 'V5'.

      p_rate = gc_rate_10.

    WHEN 'V2' OR 'V3'.

      p_rate = gc_rate_00.

    WHEN OTHERS.

      p_rate = gc_rate_00.

  ENDCASE.



ENDFORM.