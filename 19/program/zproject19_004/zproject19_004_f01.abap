
*&---------------------------------------------------------------------*

*&  Include           ZPROJECT19_004_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_INIT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_INIT .

  p_date = SY-DATUM.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_SCREEN .

  LOOP AT SCREEN.

    CASE screen-group1.

      WHEN 'CR1'.

        IF rb_cr = c_x. "##

          screen-active = 1.

        ELSE.

          screen-active = 0.

        ENDIF.



      WHEN 'ALL'.

        screen-active = 1.



    ENDCASE.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT .

  CREATE OBJECT GC_DOCKING

    EXPORTING

        REPID = SY-REPID

        DYNNR = SY-DYNNR

        EXTENSION = 2000.



  CREATE OBJECT gc_grid1

    EXPORTING

      i_parent = gc_docking.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER1_FIELD

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CONTAINER1_FIELD.

  CLEAR : GS_FIELDCAT, GT_FIELDCAT1.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'L_CHECK'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-CHECKBOX = 'X'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'BUKRS'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'EBELN'.

  GS_FIELDCAT-SCRTEXT_M = '######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'DMBTR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'MWSTS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZMWSKZ'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'SGTXT'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT2 .

  CREATE OBJECT gc_docking

    EXPORTING

      repid     = sy-repid

      dynnr     = sy-dynnr

      extension = 2000.



  CREATE OBJECT gc_grid2

    EXPORTING

      i_parent = gc_docking.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG2 .

  PERFORM CONTAINER2_FIELD.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER2_FIELD

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*



*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CALL_ALV .

  PERFORM ALV_DISPLAY.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY .

  CALL METHOD GC_GRID1->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_LAYOUT = GS_LAYOUT

    CHANGING

      IT_OUTTAB = GT_001

      IT_FIELDCATALOG = GT_FIELDCAT1

      IT_SORT = GT_SORT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CALL_ALV2 .

  PERFORM ALV_DISPLAY2.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY2 .

  CALL METHOD GC_GRID2->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

        IS_VARIANT = GS_VARIANT

        I_SAVE = C_A

        IS_LAYOUT = GS_LAYOUT

    CHANGING

        IT_OUTTAB = GT_002

        IT_FIELDCATALOG = GT_FIELDCAT2

        IT_SORT = GT_SORT.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM get_data .  " #### ## ## (ZMSEG19 ##)



  DATA: lt_mseg TYPE STANDARD TABLE OF zmseg19,

        ls_mseg TYPE zmseg19,

        lv_rate TYPE p DECIMALS 2.



  "----------------------------------------

  " 0## ### (##)

  "----------------------------------------

  CLEAR gs_001.

  REFRESH gt_001.



  IF p_ebeln IS INITIAL OR p_werks IS INITIAL.

    RETURN.

  ENDIF.



  "----------------------------------------

  " 1## ## ## ## (## ##)

  "----------------------------------------



SELECT m~*

  FROM zmseg19 AS m

  LEFT JOIN zrseg19 AS r

    ON r~ebeln = m~ebeln

  INTO TABLE @lt_mseg

  WHERE m~ebeln  = @p_ebeln

    AND m~zwerks = @p_werks

    AND r~ebeln IS NULL.





  "----------------------------------------

  " 2## ### ##

  "----------------------------------------

  LOOP AT lt_mseg INTO ls_mseg.



    CLEAR gs_001.

    MOVE-CORRESPONDING ls_mseg TO gs_001.



    " #### (### ##)

    SELECT SINGLE bukrs

      FROM zpdt19_002

      WHERE lifnr = @gs_001-lifnr

      INTO @gs_001-bukrs.



    " #### (### ##)

    SELECT SINGLE zmwskz

      FROM zpdt19_003

      WHERE lifnr = @gs_001-lifnr

      INTO @gs_001-zmwskz.



    "----------------------------------------

    " 3## ## ##

    "----------------------------------------

    CLEAR lv_rate.

    CASE gs_001-zmwskz.

      WHEN 'V1' OR 'V5'.

        lv_rate = 10.

      WHEN OTHERS.

        lv_rate = 0.

    ENDCASE.



    gs_001-mwsts = ( gs_001-dmbtr * lv_rate ) / 100.

    gs_001-sgtxt = |{ gs_001-ebeln } ####|.



    "----------------------------------------

    " 4## ## ###

    "----------------------------------------

    gs_001-l_check = abap_false.



    APPEND gs_001 TO gt_001.



  ENDLOOP.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_DATA2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM get_data2.



  CLEAR: gt_003, gt_002.



  "----------------------------------------

  " 1## ## ## ## ## (####)

  "----------------------------------------

  SELECT belnr, gjahr

    FROM zbkpf19

    WHERE ebeln = @p_ebeln

    INTO TABLE @DATA(lt_key).



  IF lt_key IS INITIAL.

    RETURN.

  ENDIF.



  "----------------------------------------

  " 2## ## ### (##)

  "----------------------------------------

  SELECT *

    FROM zrseg19

    FOR ALL ENTRIES IN @lt_key

    WHERE belnr = @lt_key-belnr

      AND gjahr = @lt_key-gjahr

    INTO CORRESPONDING FIELDS OF TABLE @gt_003.



  "----------------------------------------

  " 3## ## ### (##)

  "----------------------------------------

  SELECT *

    FROM zbseg19

    FOR ALL ENTRIES IN @lt_key

    WHERE belnr = @lt_key-belnr

      AND gjahr = @lt_key-gjahr

    INTO CORRESPONDING FIELDS OF TABLE @gt_002.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG .

  PERFORM CONTAINER1_FIELD.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER2_FIELD

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CONTAINER2_FIELD .

  CLEAR : GS_FIELDCAT , GT_FIELDCAT2.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'BUKRS'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'EBELN'.

  GS_FIELDCAT-SCRTEXT_M = '######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'DMBTR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'MWSTS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZMWSKZ'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'SGTXT'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT-SCRTEXT_M = '#####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ADD_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM add_data .



  DATA : lv_belnr TYPE belnr_d,

         lv_gjahr TYPE mjahr,

         ls_head  TYPE ty_001,  "## ###

         lv_buzei TYPE buzei.



  lv_buzei = 0.



  "==========================================

  " ALV #### ##

  "==========================================

  IF gc_grid1 IS BOUND.

    CALL METHOD gc_grid1->check_changed_data.

  ENDIF.



  "==========================================

  " ### # ##

  "==========================================

  DATA lt_checked TYPE TABLE OF ty_001.

  LOOP AT gt_001 INTO gs_001 WHERE l_check = abap_true.

    APPEND gs_001 TO lt_checked.

  ENDLOOP.



  IF lt_checked IS INITIAL.

    MESSAGE '## ### ## #### #####.' TYPE 'S'.

    RETURN.

  ENDIF.



  "==========================================

  " ## ## # ## (# ## #)

  "==========================================

  READ TABLE lt_checked INTO ls_head INDEX 1.

  IF sy-subrc <> 0.

    MESSAGE '## ## #### ####.' TYPE 'E'.

  ENDIF.



  "==========================================

  " #### ##

  "==========================================

  SELECT MAX( belnr )

    FROM zbkpf19

    INTO @lv_belnr.



  IF lv_belnr IS INITIAL.

    lv_belnr = '5000000000'.

  ELSE.

    lv_belnr = lv_belnr + 1.

  ENDIF.



  lv_gjahr = p_date(4).



  " #####

  CALL FUNCTION 'LAST_DAY_OF_MONTHS'

    EXPORTING

      day_in            = p_date

    IMPORTING

      last_day_of_month = gv_last_day.



  "==========================================

  " 1## ## ## (ZRBKP19 / ZBKPF19)

  "==========================================

  CLEAR: gs_003, gs_005.



  " ZRBKP19

  gs_003-belnr = lv_belnr.

  gs_003-gjahr = lv_gjahr.

  gs_003-bukrs = ls_head-bukrs.

  gs_003-lifnr = ls_head-lifnr.

  gs_003-waers = ls_head-waers.

  gs_003-bldat = p_date.

  gs_003-budat = p_date.

  gs_003-blart = 'RE'.



  " ZBKPF19

  MOVE-CORRESPONDING gs_003 TO gs_005.

  gs_005-ebeln = ls_head-ebeln.

  gs_005-sgtxt = ls_head-sgtxt.

  gs_005-zfbdt = gv_last_day.

  gs_005-waers = ls_head-waers.

  gs_005-zmwskz = ls_head-zmwskz.



  INSERT zrbkp19 FROM gs_003.

  IF sy-subrc <> 0.

    MESSAGE '## ##(ZRBKP19) ## ##' TYPE 'E'.

  ENDIF.



  INSERT zbkpf19 FROM gs_005.

  IF sy-subrc <> 0.

    MESSAGE '## ##(ZBKPF19) ## ##' TYPE 'E'.

  ENDIF.



  APPEND gs_003 TO gt_003.

  APPEND gs_005 TO gt_005.



  "==========================================

  " 2## ### ## (ZRSEG19 / ZBSEG19)

  "==========================================



  LOOP AT lt_checked INTO gs_001.



    lv_buzei = lv_buzei + 1.



    CLEAR: gs_004, gs_006.



    " ##/ALV ## #

    MOVE-CORRESPONDING gs_001 TO gs_004.

    MOVE-CORRESPONDING gs_001 TO gs_006.



    " ## ## Key

    gs_004-belnr = lv_belnr.

    gs_004-gjahr = lv_gjahr.

    gs_004-gsber = gs_001-zwerks.

    gs_004-zfdbt = gv_last_day.

    gs_004-buzei = lv_buzei.



    gs_006-mwsts = gs_001-mwsts.

    gs_006-belnr = lv_belnr.

    gs_006-gjahr = lv_gjahr.

    gs_006-zfbdt = gv_last_day.

    gs_006-shkzg = gs_001-shkzg.

    gs_006-budat = p_date.

    gs_006-bldat = p_date.

    gs_006-blart = 'RE'.

    gs_006-gsber = gs_001-zwerks.



    "## + ####

    gs_004-sgtxt = gs_001-sgtxt.

    gs_006-sgtxt = gs_001-sgtxt.



    INSERT zrseg19 FROM gs_004.

    IF sy-subrc <> 0.

      MESSAGE '## ###(ZRSEG19) ## ##' TYPE 'E'.

    ENDIF.



    INSERT zbseg19 FROM gs_006.

    IF sy-subrc <> 0.

      MESSAGE '## ###(ZBSEG19) ## ##' TYPE 'E'.

    ENDIF.



    APPEND gs_004 TO gt_004.

    APPEND gs_006 TO gt_006.



    READ TABLE gt_001 TRANSPORTING NO FIELDS

      WITH KEY ebeln = gs_001-ebeln

               zwerks = gs_001-zwerks.



    IF sy-subrc = 0.

      DELETE gt_001 INDEX sy-tabix.

    ENDIF.



  ENDLOOP.



  COMMIT WORK.



  DATA ls_stable TYPE lvc_s_stbl.

  ls_stable-row = 'X'.

  ls_stable-col = 'X'.



  CALL METHOD gc_grid1->refresh_table_display

    EXPORTING

      is_stable = ls_stable.



  MESSAGE '## ## ##.' TYPE 'S'.



  CALL METHOD gc_grid1->refresh_table_display.



ENDFORM.





FORM delete_data.



  DATA : lt_rows TYPE lvc_t_row,

         ls_row TYPE lvc_s_row,

         ls_data TYPE ty_002, "gt_002 ##

         ls_new TYPE ty_001, "gt_001 ##

         lv_cnt TYPE i.



  CALL METHOD gc_grid2->get_selected_rows

    IMPORTING

      et_index_rows = lt_rows.



  IF lt_rows IS INITIAL.

    MESSAGE '### ## ### #####.' TYPE 'S'.

    RETURN.

  ENDIF.



  LOOP AT lt_rows INTO ls_row.



    READ TABLE gt_002 INTO ls_data INDEX ls_row-index.

    IF sy-subrc <> 0.

      CONTINUE.

    ENDIF.



    DELETE FROM zrseg19

      WHERE belnr = @ls_data-belnr.



    DELETE FROM zbseg19

      WHERE belnr = @ls_data-belnr.



    DELETE gt_002 INDEX ls_row-index.



    SELECT COUNT(*) FROM zrseg19

      WHERE belnr = @ls_data-belnr

      INTO @lv_cnt.



    IF lv_cnt = 0.

      DELETE FROM zrbkp19 WHERE belnr = @ls_data-belnr.

      DELETE FROM zbkpf19 WHERE belnr = @ls_data-belnr.

    ENDIF.



  ENDLOOP.



  COMMIT WORK.



  DATA ls_stable TYPE lvc_s_stbl.

  ls_stable-row = 'X'.

  ls_stable-col = 'X'.



  CALL METHOD gc_grid2->refresh_table_display

    EXPORTING is_stable = ls_stable.



  MESSAGE '## ### #######.' TYPE 'S'.



ENDFORM.