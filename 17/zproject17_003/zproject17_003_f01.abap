
*&---------------------------------------------------------------------*

*&  Include           ZPROJECT17_003_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  INIT_SELECTION

*&---------------------------------------------------------------------*




FORM init_selection.



  " ## ##: ####

  p_r_cre = 'X'.

  p_r_dis = ''.



  " ## ###

  gv_recv_active_flag = '1'.

  gv_disp_active_flag = '1'.   " ## ##### ## 1



  " ##### #### ##

  p_budat = sy-datum.



  " ######/### ###

  p_ebeln = '4500000001'.

  p_werks = '1000'.



ENDFORM.                    " INIT_SELECTION








*&---------------------------------------------------------------------*

*&      Form  MODIFY_SCREEN

*&---------------------------------------------------------------------*




FORM modify_screen.



  " ###### ## MODIF ID C1(#####) on/off

  LOOP AT SCREEN.

    " ###### MODIF ID 'C1'# ##

    IF screen-group1 = 'C1'.

      IF p_r_cre = 'X'.

        screen-active = '1'.   " #### ## # ##

      ELSE.

        screen-active = '0'.   " #### ## # ##

      ENDIF.

      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.



ENDFORM.                    " MODIFY_SCREEN






*---------------------------------------------------------------------*

* ## ##

*---------------------------------------------------------------------*




FORM determine_mode.



  IF p_r_cre = 'X'.

    gv_mode = c_mode_recv.

  ELSEIF p_r_dis = 'X'.

    gv_mode = c_mode_disp.

  ELSE.

    gv_mode = c_mode_recv.

  ENDIF.



ENDFORM.                    " DETERMINE_MODE




*&---------------------------------------------------------------------*

*&      Form  CHECK_SELECTION

*&---------------------------------------------------------------------*




FORM check_selection .

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

  IF gv_mode = c_mode_recv.

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

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT_0100

*&---------------------------------------------------------------------*




FORM create_object_0100 .



  IF go_container IS INITIAL.



    CREATE OBJECT go_container

      EXPORTING

        container_name = 'CC_ALV'.   " ## 0100 # Custom Control ##



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



ENDFORM.                    " CREATE_OBJECT_0100






*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY_0100

*&---------------------------------------------------------------------*




FORM alv_display_0100 .



  IF gt_fcat IS INITIAL.

    PERFORM build_fcat_0100.

  ENDIF.



  CLEAR gs_layout.

  gs_layout-zebra      = 'X'.




*  gs_layout-cwidth_opt = 'X'.   " ### ####






  CALL METHOD go_alv->set_table_for_first_display

    EXPORTING

      is_layout       = gs_layout

    CHANGING

      it_fieldcatalog = gt_fcat

      it_outtab       = gt_gr_alv.



ENDFORM.                    " ALV_DISPLAY_0100






*&---------------------------------------------------------------------*

*&      Form  REFRESH_ALV_0100

*&---------------------------------------------------------------------*




FORM refresh_alv_0100 .



  IF go_alv IS BOUND.

    CALL METHOD go_alv->refresh_table_display( ).

  ENDIF.



ENDFORM.                    " REFRESH_ALV_0100






*---------------------------------------------------------------------*

*      Form  GET_DATA_FOR_RECEIPT

*---------------------------------------------------------------------*

*  ### ####/#### #### #### ALV #### ##

*  - PO##(PO_QTY)

*  - #####(GR_QTY_SUM) : ZEDT17_MSEG ##

*  - ####(OPEN_QTY)     : PO_QTY - GR_QTY_SUM

*  - ######(RECV_QTY): ### = #### (### ## 0## ### #)

*---------------------------------------------------------------------*




FORM get_data_for_receipt .



  CLEAR gt_gr_alv.

  REFRESH gt_gr_alv.



  IF p_ebeln IS INITIAL OR p_werks IS INITIAL.

    RETURN.

  ENDIF.



  " 1) PO ## + ### #### ## ### ## (PO## = MENGE)

  SELECT

    a~ebeln

    b~ebelp

    a~lifnr

    a~bedat

    b~zmatnr

    b~maktx

    b~menge          " PO##

    b~meins




*    b~bprme




    b~stprs

    a~waers

    b~prdat

    b~zwerks

    b~zlgort

    INTO CORRESPONDING FIELDS OF TABLE gt_gr_alv

    FROM zedt17_ekko AS a

    INNER JOIN zedt17_ekpo AS b

      ON a~ebeln = b~ebeln

    WHERE a~ebeln = p_ebeln

      AND b~zwerks = p_werks.



  IF gt_gr_alv IS INITIAL.

    EXIT.

  ENDIF.



  " 2) # #### #####/#### ##

  DATA: lv_prev_qty TYPE zedt17_mseg-menge.



  LOOP AT gt_gr_alv INTO gs_gr_alv.



    CLEAR lv_prev_qty.



    " ZEDT17_MSEG ## EBELP ### #### EBELN + MATNR + WERKS + LGORT #### ##### ##

    SELECT SUM( menge )

      INTO lv_prev_qty

      FROM zedt17_mseg

      WHERE ebeln = gs_gr_alv-ebeln

        AND matnr = gs_gr_alv-zmatnr

        AND werks = gs_gr_alv-zwerks

        AND lgort = gs_gr_alv-zlgort.



    IF sy-subrc <> 0 OR lv_prev_qty IS INITIAL.

      lv_prev_qty = 0.

    ENDIF.



    " #####

    gs_gr_alv-gr_menge = lv_prev_qty.



    " #### = PO## - #####

    gs_gr_alv-open_menge = gs_gr_alv-menge - lv_prev_qty.

    IF gs_gr_alv-open_menge < 0.

      gs_gr_alv-open_menge = 0.

    ENDIF.



    " ###### ### : #### ### ##

    " (### 0## ##### #)

    gs_gr_alv-recv_menge = gs_gr_alv-open_menge.



    MODIFY gt_gr_alv FROM gs_gr_alv INDEX sy-tabix.



  ENDLOOP.



  " 3) ##### 0# ### # ## ##### #### ALV## ##

  DELETE gt_gr_alv WHERE open_menge <= 0.



ENDFORM.                    " GET_DATA_FOR_RECEIPT






*---------------------------------------------------------------------*

*      Form  CREATE_GR_DOCUMENT

*---------------------------------------------------------------------*

*  ALV## ### ### ## ####(ZEDT17_MKPF / ZEDT17_MSEG) ##

*---------------------------------------------------------------------*




FORM create_gr_document .



  DATA: lt_sel    TYPE STANDARD TABLE OF ty_gr_alv,

        ls_sel    TYPE ty_gr_alv,

        lt_mseg   TYPE STANDARD TABLE OF zedt17_mseg,

        ls_mseg   TYPE zedt17_mseg,

        ls_mkpf   TYPE zedt17_mkpf,

        lv_mblnr  TYPE zedt17_mkpf-mblnr,

        lv_mjahr  TYPE zedt17_mkpf-mjahr,

        lv_zeile  TYPE zedt17_mseg-zeile,

        lv_answer TYPE c LENGTH 1,

        lv_bukrs  TYPE zedt17_ekko-bukrs,

        lv_msg    TYPE char80.



  " 1) ALV #### ##

  IF go_alv IS BOUND.

    CALL METHOD go_alv->check_changed_data.

  ENDIF.





  " 2) ## ## ## (### + #### > 0)

  LOOP AT gt_gr_alv INTO gs_gr_alv

         WHERE l_check    = 'X'

           AND recv_menge > 0.

    APPEND gs_gr_alv TO lt_sel.

  ENDLOOP.



  IF lt_sel IS INITIAL.

    MESSAGE e016.   " '### ### ##### ##### #####.'

    RETURN.

  ENDIF.



  " 3) ### ### ##

  "    - #### > 0

  "    - ####(RECV_MENGE) > 0

  "    - #### <= ####

  " 3) ### ### ##

  LOOP AT lt_sel INTO ls_sel.



    " #### ### 0 ##

    IF ls_sel-open_menge <= 0.

      MESSAGE e017. "'##### 0# ### ### # ####.'

      RETURN.

    ENDIF.



    " ##### ### 1 ##

    IF ls_sel-recv_menge < 1.

      MESSAGE e018. " '##### 1 ##### ###.'

      RETURN.

    ENDIF.



    " #### <= ####

    IF ls_sel-recv_menge > ls_sel-open_menge.

      MESSAGE e019. " '##### ##### ######.'

      RETURN.

    ENDIF.



  ENDLOOP.








*  IF sy-subrc <> 0.

*    EXIT.

*  ENDIF.






  " 4) ### ## ##

  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      titlebar              = '####'

      text_question         = '### ### ## ##### ########?'

      text_button_1         = '#'

      text_button_2         = '###'

      display_cancel_button = ' '

    IMPORTING

      answer                = lv_answer.



  IF lv_answer <> '1'.

    EXIT.

  ENDIF.



  " 5) ## ###### ##

  "    - ZEDT17_MKPF # ### + 1

  "    - ### ##### ### gc_mblnr_start ## ##

  SELECT SINGLE MAX( mblnr )

    INTO lv_mblnr

    FROM zedt17_mkpf.



  IF sy-subrc <> 0 OR lv_mblnr IS INITIAL OR lv_mblnr < gc_mblnr_start.

    lv_mblnr = gc_mblnr_start.

  ELSE.

    lv_mblnr = lv_mblnr + 1.

  ENDIF.



  " ####: ##### ##(YYYY)

  lv_mjahr = p_budat+0(4).



  " ####: ## PO ## ## (## ## ##### ##)

  CLEAR lv_bukrs.

  SELECT SINGLE bukrs

    INTO lv_bukrs

    FROM zedt17_ekko

    WHERE ebeln = p_ebeln.



  " 6) ##(MKPF) ##

  CLEAR ls_mkpf.

  ls_mkpf-mblnr = lv_mblnr.

  ls_mkpf-mjahr = lv_mjahr.

  ls_mkpf-blart = 'WE'.      " ####(##)

  ls_mkpf-bldat = p_budat.   " ###

  ls_mkpf-budat = p_budat.   " ###



  INSERT zedt17_mkpf FROM ls_mkpf.



  IF sy-subrc <> 0.

    ROLLBACK WORK.

    MESSAGE e020. " '#### ## # ### ######.'

    EXIT.

  ENDIF.



  " 7) ###(MSEG) ##

  CLEAR: lt_mseg, lv_zeile.



  LOOP AT lt_sel INTO ls_sel.



    CLEAR ls_mseg.

    lv_zeile = lv_zeile + 1.



    ls_mseg-mblnr = lv_mblnr.

    ls_mseg-mjahr = lv_mjahr.

    ls_mseg-zeile = lv_zeile.



    ls_mseg-matnr = ls_sel-zmatnr.

    ls_mseg-werks = ls_sel-zwerks.

    ls_mseg-lgort = ls_sel-zlgort.

    ls_mseg-lifnr = ls_sel-lifnr.

    ls_mseg-waers = ls_sel-waers.



    ls_mseg-menge = ls_sel-recv_menge.  " ## ####

    ls_mseg-meins = ls_sel-meins.



    ls_mseg-ebeln = ls_sel-ebeln.

    ls_mseg-bukrs = lv_bukrs.



    APPEND ls_mseg TO lt_mseg.



  ENDLOOP.



  IF lt_mseg IS INITIAL.

    MESSAGE e023. " '### ### ####.'

    ROLLBACK WORK.

    EXIT.

  ENDIF.



  INSERT zedt17_mseg FROM TABLE lt_mseg.



  IF sy-subrc = 0.

    COMMIT WORK AND WAIT.



    " 8) ## ## ## ### ### ####/##/### ##

    zedt17_mkpf-mblnr = lv_mblnr.

    zedt17_mkpf-mjahr = lv_mjahr.

    zedt17_mkpf-budat = p_budat.



    " 9) ## ## # #### ## #### ##### ALV ####

    PERFORM get_data_for_receipt.

    PERFORM refresh_alv_0100.



    MESSAGE s022 WITH lv_mblnr.  " ZMED17-022 (&1=####): #### &1 # #######.





  ELSE.

    ROLLBACK WORK.

    MESSAGE e021. " '##### ## # ### ######.'

  ENDIF.



ENDFORM.                    " CREATE_GR_DOCUMENT






*---------------------------------------------------------------------*

* ALV ###### ##

*---------------------------------------------------------------------*




FORM build_fcat_0100 .



  CLEAR gt_fcat.

  REFRESH gt_fcat.



  PERFORM add_fcat_0100 USING 'L_CHECK' '##'      'X'.

  PERFORM add_fcat_0100 USING 'EBELN'   '####'  ''.

  PERFORM add_fcat_0100 USING 'EBELP'   '##'      ''.

  PERFORM add_fcat_0100 USING 'LIFNR'   '###'    ''.

  PERFORM add_fcat_0100 USING 'BEDAT'   '###'    ''.

  PERFORM add_fcat_0100 USING 'ZMATNR'  '####'  ''.

  PERFORM add_fcat_0100 USING 'MAKTX'   '###'    ''.




*  PERFORM add_fcat_0100 USING 'MENGE'   '##'      'X'.






  PERFORM add_fcat_0100 USING 'MENGE'      'PO##'     ''.   " ##

  PERFORM add_fcat_0100 USING 'GR_MENGE'   '#####' ''.   "

  PERFORM add_fcat_0100 USING 'OPEN_MENGE' '####'   ''.   "

  PERFORM add_fcat_0100 USING 'RECV_MENGE' '####'   'X'.  " (### ##)



  PERFORM add_fcat_0100 USING 'MEINS'   '##'      ''.




*  PERFORM add_fcat_0100 USING 'BPRME'   '####'  ''.




  PERFORM add_fcat_0100 USING 'STPRS'   '####'  ''.

  PERFORM add_fcat_0100 USING 'WAERS'   '##'      ''.

  PERFORM add_fcat_0100 USING 'PRDAT'   '###'    ''.

  PERFORM add_fcat_0100 USING 'ZWERKS'  '###'    ''.

  PERFORM add_fcat_0100 USING 'ZLGORT'  '####'  ''.







ENDFORM.                    " BUILD_FCAT_0100








*---------------------------------------------------------------------*

* ###### 1 ## ##

*---------------------------------------------------------------------*




FORM add_fcat_0100 USING    p_fieldname TYPE lvc_fname

                             p_coltext   TYPE scrtext_l

                             p_edit      TYPE c.



  CLEAR gs_fcat.



  gs_fcat-fieldname = p_fieldname.

  gs_fcat-coltext   = p_coltext.



  IF p_edit = 'X'.

    gs_fcat-edit = 'X'.

  ENDIF.




*  " '#### ##'# ## -> ## ## ##

*  IF p_edit = 'X' AND gv_mode = c_mode_recv.

*    gs_fcat-edit = 'X'.

*  ENDIF.








  CASE p_fieldname.






*    WHEN 'L_CHECK'.                      " ##(####)

*      gs_fcat-checkbox  = 'X'.

*      gs_fcat-edit      = 'X'.

*      gs_fcat-outputlen = 3.






    WHEN 'L_CHECK'.                    " ##(####)

      gs_fcat-checkbox  = 'X'.

      gs_fcat-outputlen = 3.





      gs_fcat-edit = 'X'.



    WHEN 'EBELN'.                        " ####

      gs_fcat-outputlen = 10.



    WHEN 'EBELP'.                        " ##

      gs_fcat-outputlen = 4.



    WHEN 'LIFNR'.                        " ###

      gs_fcat-outputlen = 10.



    WHEN 'ZMATNR'.                       " ####

      gs_fcat-outputlen = 10.



    WHEN 'MAKTX'.                        " ###

      gs_fcat-outputlen = 20.



    WHEN 'MENGE'.                        " PO##

      gs_fcat-ref_table  = 'ZEDT17_EKPO'.

      gs_fcat-ref_field  = 'MENGE'.

      gs_fcat-qfieldname = 'MEINS'.

      gs_fcat-outputlen  = 6.



    WHEN 'GR_MENGE'. " #####

      gs_fcat-ref_table  = 'ZEDT17_EKPO'.

      gs_fcat-ref_field  = 'MENGE'.

      gs_fcat-qfieldname = 'MEINS'.

      gs_fcat-outputlen  = 8.



    WHEN 'OPEN_MENGE' OR 'RECV_MENGE'. " ####/####

      gs_fcat-ref_table  = 'ZEDT17_EKPO'.

      gs_fcat-ref_field  = 'MENGE'.

      gs_fcat-qfieldname = 'MEINS'.

      gs_fcat-outputlen  = 6.



    WHEN 'MEINS'  OR 'WAERS'.  " ## / #### / ##

      gs_fcat-outputlen = 4.






*    WHEN 'ZWERKS' OR 'BPRME' OR 'ZLGORT'.           " #### / ### / ####




    WHEN 'ZWERKS' OR 'ZLGORT'.           "  ### / ####

      gs_fcat-outputlen = 6.



    WHEN 'BEDAT' OR 'STPRS' OR 'PRDAT'.             " #### / ### / ###

      gs_fcat-outputlen = 10.



  ENDCASE.



  APPEND gs_fcat TO gt_fcat.



ENDFORM.                    " ADD_FCAT_0100








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



FORM alv_handle_data_changed USING p_data_changed TYPE REF TO cl_alv_changed_data_protocol.



  DATA: ls_mod_cell TYPE lvc_s_modi,

        ls_alv      LIKE LINE OF gt_gr_alv.



  LOOP AT p_data_changed->mt_mod_cells INTO ls_mod_cell.



    CASE ls_mod_cell-fieldname.

      WHEN 'RECV_MENGE'.   " # ##### ####



        " ## ## ## ## (#### ###)

        READ TABLE gt_gr_alv INTO ls_alv INDEX ls_mod_cell-row_id.

        IF sy-subrc <> 0.

          CONTINUE.

        ENDIF.



        " 1) ## ## 1 ##

        IF ls_mod_cell-value < 1.



          MESSAGE i018 DISPLAY LIKE 'E'.  " ZMED17-018



          " # ##(###) ## 1# ##

          CALL METHOD p_data_changed->modify_cell

            EXPORTING

              i_row_id    = ls_mod_cell-row_id

              i_fieldname = ls_mod_cell-fieldname

              i_value     = ls_alv-recv_menge.   " ##### ##



          CONTINUE.

        ENDIF.



        " 2) #### ##

        IF ls_mod_cell-value > ls_alv-open_menge.



          MESSAGE i019 DISPLAY LIKE 'E'.  " ZMED17-019



          " ###### ##(## ### ##)

          CALL METHOD p_data_changed->modify_cell

            EXPORTING

              i_row_id    = ls_mod_cell-row_id

              i_fieldname = ls_mod_cell-fieldname

              i_value     = ls_alv-open_menge.   " ###### ##



          CONTINUE.

        ENDIF.



    ENDCASE.



  ENDLOOP.



ENDFORM.