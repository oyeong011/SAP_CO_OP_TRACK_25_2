
*&---------------------------------------------------------------------*

*&  Include           ZPROJECT17_003_F02

*&---------------------------------------------------------------------*






FORM create_object_0200 .



  IF go_container_200 IS INITIAL.



    CREATE OBJECT go_container_200

      EXPORTING

        container_name = 'CC_ALV_200'.  " SCREEN 200 Custom Control



    CREATE OBJECT go_alv_200

      EXPORTING

        i_parent = go_container_200.



  ENDIF.



ENDFORM.





" ### ##(### ###)

FORM get_data_for_display_0200 .



  CLEAR gt_gr_disp.

  REFRESH gt_gr_disp.



  IF p_ebeln IS INITIAL OR p_werks IS INITIAL.

    RETURN.

  ENDIF.



  SELECT

    a~mblnr

    a~mjahr

    a~zeile

    b~budat

    a~ebeln

    a~lifnr

    a~matnr

    c~maktx

    a~menge

    a~meins

    a~werks

    a~lgort

    a~waers

    INTO CORRESPONDING FIELDS OF TABLE gt_gr_disp

    FROM zedt17_mseg AS a

    INNER JOIN zedt17_mkpf AS b

      ON b~mblnr = a~mblnr

     AND b~mjahr = a~mjahr

    LEFT JOIN zedt17_ekpo AS c

      ON c~ebeln  = a~ebeln

     AND c~zmatnr = a~matnr

    WHERE a~ebeln = p_ebeln

      AND a~werks = p_werks.



ENDFORM.



" 0200 ######/##/####

FORM build_fcat_0200 .



  CLEAR gt_fcat_200.

  REFRESH gt_fcat_200.



  PERFORM add_fcat_0200 USING 'L_CHECK' '##'     'X'.

  PERFORM add_fcat_0200 USING 'MBLNR'   '####' ''.

  PERFORM add_fcat_0200 USING 'MJAHR'   '##'     ''.

  PERFORM add_fcat_0200 USING 'ZEILE'   '##'     ''.

  PERFORM add_fcat_0200 USING 'BUDAT'   '###'   ''.

  PERFORM add_fcat_0200 USING 'EBELN'   '####' ''.

  PERFORM add_fcat_0200 USING 'LIFNR'   '###'   ''.

  PERFORM add_fcat_0200 USING 'MATNR'   '##'     ''.

  PERFORM add_fcat_0200 USING 'MAKTX'   '###'   ''.

  PERFORM add_fcat_0200 USING 'MENGE'   '####' ''.

  PERFORM add_fcat_0200 USING 'MEINS'   '##'     ''.

  PERFORM add_fcat_0200 USING 'WERKS'   '###'   ''.

  PERFORM add_fcat_0200 USING 'LGORT'   '####' ''.



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

    WHEN 'MBLNR'.

      gs_fcat_200-outputlen = 10.

    WHEN 'MJAHR' OR 'ZEILE'.

      gs_fcat_200-outputlen = 4.

    WHEN 'BUDAT'.

      gs_fcat_200-outputlen = 10.

    WHEN 'EBELN' OR 'LIFNR' OR 'MATNR'.

      gs_fcat_200-outputlen = 10.

    WHEN 'MAKTX'.

      gs_fcat_200-outputlen = 20.

    WHEN 'MENGE'.

      gs_fcat_200-ref_table  = 'ZEDT17_MSEG'.

      gs_fcat_200-ref_field  = 'MENGE'.

      gs_fcat_200-qfieldname = 'MEINS'.

      gs_fcat_200-outputlen  = 8.

    WHEN 'MEINS'.

      gs_fcat_200-outputlen = 4.

    WHEN 'WERKS' OR 'LGORT'.

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

      it_outtab       = gt_gr_disp.



ENDFORM.



FORM refresh_alv_0200 .



  IF go_alv_200 IS BOUND.

    CALL METHOD go_alv_200->refresh_table_display( ).

  ENDIF.



ENDFORM.



" ## ##(## ## ## # ## # ## ##)




*### ##: L_CHECK = 'X'

*## #: MSEG (MBLNR, MJAHR, ZEILE)

*## ### # ## ### ### MKPF# ##(MBLNR, MJAHR)




FORM cancel_gr_document .



  DATA: lt_sel     TYPE STANDARD TABLE OF ty_gr_disp,

        ls_sel     TYPE ty_gr_disp,

        lv_answer  TYPE c LENGTH 1,

        lv_cnt     TYPE i,

        lv_msg     TYPE char80.



  " ALV #### ##

  IF go_alv_200 IS BOUND.

    CALL METHOD go_alv_200->check_changed_data.

  ENDIF.



  " ## ## ##

  LOOP AT gt_gr_disp INTO gs_gr_disp WHERE l_check = 'X'.

    APPEND gs_gr_disp TO lt_sel.

  ENDLOOP.



  IF lt_sel IS INITIAL.

    MESSAGE '### ### #####.' TYPE 'S' DISPLAY LIKE 'E'.

    EXIT.

  ENDIF.



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

    EXIT.

  ENDIF.



  " ### ##

  LOOP AT lt_sel INTO ls_sel.



    DELETE FROM zedt17_mseg

      WHERE mblnr = ls_sel-mblnr

        AND mjahr = ls_sel-mjahr

        AND zeile = ls_sel-zeile.



    IF sy-subrc <> 0.

      ROLLBACK WORK.

      MESSAGE '## ### ## # ### ######.' TYPE 'S' DISPLAY LIKE 'E'.

      EXIT.

    ENDIF.



    " ### ## #### ### MKPF ### ##

    CLEAR lv_cnt.

    SELECT COUNT( * ) INTO lv_cnt

      FROM zedt17_mseg

      WHERE mblnr = ls_sel-mblnr

        AND mjahr = ls_sel-mjahr.



    IF lv_cnt = 0.

      DELETE FROM zedt17_mkpf

        WHERE mblnr = ls_sel-mblnr

          AND mjahr = ls_sel-mjahr.



      IF sy-subrc <> 0.

        ROLLBACK WORK.

        MESSAGE '## ## ## # ### ######.' TYPE 'S' DISPLAY LIKE 'E'.

        EXIT.

      ENDIF.

    ENDIF.



  ENDLOOP.



  COMMIT WORK AND WAIT.



  " ## ###/####

  PERFORM get_data_for_display_0200.

  PERFORM refresh_alv_0200.



  CLEAR lv_msg.

  CONCATENATE '####' ls_sel-mblnr '# #######.' INTO lv_msg SEPARATED BY space.

  MESSAGE lv_msg TYPE 'S'.



ENDFORM.