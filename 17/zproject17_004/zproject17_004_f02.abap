
*&---------------------------------------------------------------------*

*&  Include           ZPROJECT17_004_F02

*&---------------------------------------------------------------------*






FORM create_object_0200 .



  IF go_container_200 IS INITIAL.



    CREATE OBJECT go_container_200

      EXPORTING

        container_name = 'CC_ALV_200'.  " Screen 0200 Custom Control



    CREATE OBJECT go_alv_200

      EXPORTING

        i_parent = go_container_200.



  ENDIF.



ENDFORM.



FORM get_data_for_display_0200 .



  CLEAR gt_iv_disp.

  REFRESH gt_iv_disp.



  IF p_ebeln IS INITIAL OR p_werks IS INITIAL.

    RETURN.

  ENDIF.



  SELECT

    a~belnr

    a~gjahr

    b~buzei



    b~ebeln

    b~ebelp



    a~lifnr

    a~waers

    a~budat

    a~bktxt



    b~zmatnr

    b~maktx

    b~zwerks



    b~menge

    b~meins



    b~wrbtr

    b~wmwst

    b~mwskz

    b~shkzg

    INTO CORRESPONDING FIELDS OF TABLE gt_iv_disp

    FROM zedt17_rbkp AS a

    INNER JOIN zedt17_rseg AS b

      ON b~belnr = a~belnr

     AND b~gjahr = a~gjahr

    WHERE b~ebeln  = p_ebeln

      AND b~zwerks = p_werks.

  LOOP AT gt_iv_disp INTO gs_iv_disp.

    gs_iv_disp-tot_amt = gs_iv_disp-wrbtr + gs_iv_disp-wmwst.

    MODIFY gt_iv_disp FROM gs_iv_disp INDEX sy-tabix.

  ENDLOOP.



ENDFORM.

FORM build_fcat_0200 .



  CLEAR gt_fcat_200.

  REFRESH gt_fcat_200.



  PERFORM add_fcat_0200 USING 'L_CHECK' '##'     'X'.

  PERFORM add_fcat_0200 USING 'BELNR'   '####' ''.

  PERFORM add_fcat_0200 USING 'GJAHR'   '##'     ''.

  PERFORM add_fcat_0200 USING 'BUZEI'   '##'     ''.



  PERFORM add_fcat_0200 USING 'BUDAT'   '###'   ''.

  PERFORM add_fcat_0200 USING 'EBELN'   '####' ''.

  PERFORM add_fcat_0200 USING 'EBELP'   '##'     ''.

  PERFORM add_fcat_0200 USING 'LIFNR'   '###'   ''.



  PERFORM add_fcat_0200 USING 'ZMATNR'  '##'     ''.

  PERFORM add_fcat_0200 USING 'MAKTX'   '###'   ''.

  PERFORM add_fcat_0200 USING 'ZWERKS'  '###'   ''.



  PERFORM add_fcat_0200 USING 'MENGE'   '##'     ''.

  PERFORM add_fcat_0200 USING 'MEINS'   '##'     ''.



  PERFORM add_fcat_0200 USING 'WAERS'   '##'     ''.

  PERFORM add_fcat_0200 USING 'WRBTR'   '####' ''.

  PERFORM add_fcat_0200 USING 'WMWST'   '##'     ''.

  PERFORM add_fcat_0200 USING 'TOT_AMT' '###'   ''.

  PERFORM add_fcat_0200 USING 'MWSKZ'   '####' ''.

  PERFORM add_fcat_0200 USING 'BKTXT'   '###'   ''.



ENDFORM.





FORM add_fcat_0200 USING    p_fieldname TYPE lvc_fname

                            p_coltext   TYPE scrtext_l

                            p_edit      TYPE c.



  CLEAR gs_fcat_200.

  gs_fcat_200-fieldname = p_fieldname.

  gs_fcat_200-coltext   = p_coltext.



  CASE p_fieldname.

    WHEN 'L_CHECK'.

      gs_fcat_200-checkbox  = 'X'.

      gs_fcat_200-edit      = 'X'.

      gs_fcat_200-outputlen = 3.



    WHEN 'BELNR'.

      gs_fcat_200-outputlen = 10.

    WHEN 'GJAHR' OR 'BUZEI'.

      gs_fcat_200-outputlen = 4.



    WHEN 'BUDAT'.

      gs_fcat_200-outputlen = 10.



    WHEN 'EBELN' OR 'LIFNR' OR 'ZMATNR'.

      gs_fcat_200-outputlen = 10.

    WHEN 'EBELP'.

      gs_fcat_200-outputlen = 4.



    WHEN 'MAKTX' OR 'BKTXT'.

      gs_fcat_200-outputlen = 20.



    WHEN 'ZWERKS'.

      gs_fcat_200-outputlen = 6.



    WHEN 'MENGE'.

      gs_fcat_200-ref_table  = 'ZEDT17_RSEG'.

      gs_fcat_200-ref_field  = 'MENGE'.

      gs_fcat_200-qfieldname = 'MEINS'.

      gs_fcat_200-outputlen  = 8.



    WHEN 'MEINS' OR 'WAERS'.

      gs_fcat_200-outputlen = 4.



    WHEN 'WRBTR' OR 'WMWST'.

      gs_fcat_200-ref_table  = 'ZEDT17_RSEG'.

      gs_fcat_200-ref_field  = 'WRBTR'.

      gs_fcat_200-cfieldname = 'WAERS'.

      gs_fcat_200-outputlen  = 12.



    WHEN 'TOT_AMT'.

      gs_fcat_200-outputlen  = 12.



    WHEN 'MWSKZ'.

      gs_fcat_200-outputlen = 6.



  ENDCASE.



  APPEND gs_fcat_200 TO gt_fcat_200.



ENDFORM.

FORM alv_display_0200 .



  IF gt_fcat_200 IS INITIAL.

    PERFORM build_fcat_0200.

  ENDIF.



  CLEAR gs_layout_200.

  gs_layout_200-zebra = 'X'.



  CALL METHOD go_alv_200->set_table_for_first_display

    EXPORTING

      is_layout       = gs_layout_200

    CHANGING

      it_fieldcatalog = gt_fcat_200

      it_outtab       = gt_iv_disp.



ENDFORM.





FORM refresh_alv_0200 .



  IF go_alv_200 IS BOUND.

    CALL METHOD go_alv_200->refresh_table_display( ).

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CANCEL_INVOICE_DOCUMENT_0200

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

* ## ## X ####, delete## ## (#### # form ### ## #### insert)

*&---------------------------------------------------------------------*




FORM cancel_invoice_document_0200 .



  DATA: lt_sel    TYPE STANDARD TABLE OF ty_iv_disp,

        ls_sel    TYPE ty_iv_disp,

        lv_answer TYPE c LENGTH 1,

        lv_cnt    TYPE i,

        lv_msg    TYPE char80.



  " 1) ALV #### ##

  IF go_alv_200 IS BOUND.

    CALL METHOD go_alv_200->check_changed_data.

  ENDIF.



  " 2) ## ## ##

  CLEAR lt_sel.

  REFRESH lt_sel.



  LOOP AT gt_iv_disp INTO gs_iv_disp WHERE l_check = 'X'.

    APPEND gs_iv_disp TO lt_sel.

  ENDLOOP.



  IF lt_sel IS INITIAL.

    MESSAGE '### ### #####.' TYPE 'S' DISPLAY LIKE 'E'.

    RETURN.

  ENDIF.



  " 3) ### ##

  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      titlebar              = '####'

      text_question         = '### ##### ##(##)######?'

      text_button_1         = '#'

      text_button_2         = '###'

      display_cancel_button = ' '

    IMPORTING

      answer                = lv_answer.



  IF lv_answer <> '1'.

    RETURN.

  ENDIF.



  " 4) ### ##(RSEG) + ## # ##(RBKP) ##

  LOOP AT lt_sel INTO ls_sel.



    " 4-1) ### ##

    DELETE FROM zedt17_rseg

      WHERE belnr = ls_sel-belnr

        AND gjahr = ls_sel-gjahr

        AND buzei = ls_sel-buzei.



    IF sy-subrc <> 0.

      ROLLBACK WORK.

      MESSAGE '## ### ## # ### ######.' TYPE 'S' DISPLAY LIKE 'E'.

      RETURN.

    ENDIF.



    " 4-2) ## ### ## #### ### ### ##

    CLEAR lv_cnt.

    SELECT COUNT( * ) INTO lv_cnt

      FROM zedt17_rseg

      WHERE belnr = ls_sel-belnr

        AND gjahr = ls_sel-gjahr.



    IF lv_cnt = 0.

      DELETE FROM zedt17_rbkp

        WHERE belnr = ls_sel-belnr

          AND gjahr = ls_sel-gjahr.



      IF sy-subrc <> 0.

        ROLLBACK WORK.

        MESSAGE '## ## ## # ### ######.' TYPE 'S' DISPLAY LIKE 'E'.

        RETURN.

      ENDIF.

    ENDIF.



  ENDLOOP.



  COMMIT WORK AND WAIT.



  " 5) ###/####

  PERFORM get_data_for_display_0200.

  PERFORM refresh_alv_0200.



  " 6) ## ###(### ## #### ##)

  CLEAR lv_msg.

  CONCATENATE '##' ls_sel-belnr '# #######.' INTO lv_msg SEPARATED BY space.

  MESSAGE lv_msg TYPE 'S'.



ENDFORM.