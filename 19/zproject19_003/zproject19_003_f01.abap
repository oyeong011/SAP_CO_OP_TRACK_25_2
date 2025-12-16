
*&---------------------------------------------------------------------*

*&  Include           ZPROJECT19_003_F01

*&---------------------------------------------------------------------*

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

        IF rb_cr = c_x.

          screen-active = 0.

        ELSE.

          screen-active = 1.

        ENDIF.



      WHEN 'ALL'.

        screen-active = 1.



    ENDCASE.

    MODIFY SCREEN.



  ENDLOOP.

ENDFORM.




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

  GS_FIELDCAT-CHECKBOX = 'X'. "#### ##

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'EBELN'.

  GS_FIELDCAT-SCRTEXT_M = '######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZMATNAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'BEDAT'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-OUTPUTLEN = 10. "## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZMATNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-DECIMALS      = 0.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'STPRS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'PRDAT'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZWERKS'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'ZLGORT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = 4.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT .

  gs_layout-sel_mode = 'A'.   "## ## ##

  gs_layout-smalltitle = 'X'.

  gs_layout-no_rowins = ''.



ENDFORM.




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

*&      Form  CREATE_OBJECT2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT2 .

  " ## Docking Container

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

        IT_OUTTAB = GT_004

        IT_FIELDCATALOG = GT_FIELDCAT2

        IT_SORT = GT_SORT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM get_data2 .



  CLEAR gs_001.

  CLEAR gt_001.



  gs_001-zwerks = p_werks.

  gs_001-ebeln  = p_ebeln.



  "------------------------------------------------------------

  " 1) #### ###(ZPDT19_005) ### ## ####

  "------------------------------------------------------------

  SELECT *

    FROM zpdt19_005

    WHERE ebeln = @p_ebeln

      AND zwerks = @p_werks

    INTO TABLE @DATA(lt_item).



  LOOP AT lt_item INTO DATA(ls_item).



    "------------------------------------------------------------

    " 2) ## ### ##(ZMSEG19) ##

    "------------------------------------------------------------

    SELECT SUM( menge )

      FROM zmseg19

      WHERE ebeln = @ls_item-ebeln

        AND zwerks = @ls_item-zwerks

      INTO @DATA(lv_in_qty).



    IF sy-subrc <> 0 OR lv_in_qty IS INITIAL.

      lv_in_qty = 0.

    ENDIF.



    "------------------------------------------------------------

    " 3) ## ## ##

    "------------------------------------------------------------

    DATA(lv_remain) = ls_item-menge - lv_in_qty.



    IF lv_remain <= 0.

      MESSAGE '## ## ### #######.' TYPE 'S'.

      CONTINUE. " ## ## ### ### ##

    ENDIF.



    "------------------------------------------------------------

    " 4) #### ##(ZPDT19_004)## ## ## ####

    "------------------------------------------------------------

    SELECT SINGLE lifnr, bedat, waers

      FROM zpdt19_004

      WHERE ebeln = @ls_item-ebeln

      INTO @DATA(ls_head).



    SELECT SINGLE bukrs

      FROM zpdt19_002

      WHERE lifnr = @ls_head-lifnr

      INTO @DATA(lv_bukrs).

    "------------------------------------------------------------

    " 5) GT_001 ##

    "------------------------------------------------------------

    CLEAR gs_001.

    gs_001-ebeln   = ls_item-ebeln.

    gs_001-ebelp   = ls_item-ebelp.

    gs_001-zmatnr  = ls_item-zmatnr.

    gs_001-zmatname = ls_item-zmatname.

    gs_001-menge   = lv_remain.          " # ## #### ##

    gs_001-meins   = ls_item-meins.

    gs_001-stprs   = ls_item-stprs.

    gs_001-prdat   = ls_item-prdat.

    gs_001-zwerks  = ls_item-zwerks.

    gs_001-zlgort  = ls_item-zlgort.

    gs_001-lifnr   = ls_head-lifnr.

    gs_001-bedat   = ls_head-bedat.

    gs_001-waers   = ls_head-waers.

    gs_001-l_check = abap_false.

    gs_001-bukrs = lv_bukrs.

    gs_001-remain_menge = lv_remain.  " ###

    gs_001-menge        = lv_remain.  " ###



    APPEND gs_001 TO gt_001.



  ENDLOOP.



ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM get_data .



  CLEAR gt_004.



  SELECT *

    FROM zmseg19

    WHERE ebeln  = @p_ebeln

      AND zwerks = @p_werks

    INTO TABLE @DATA(lt_seg).



  LOOP AT lt_seg INTO DATA(ls_seg).



    CLEAR gs_004.

    MOVE-CORRESPONDING ls_seg TO gs_004.



    " ### (PO ##)

    SELECT SINGLE zmatname

      FROM zpdt19_005

      WHERE ebeln = @ls_seg-ebeln

      INTO @gs_004-zmatname.



    gs_004-bedat = p_date.   " ###

    gs_004-prdat = p_date.



    APPEND gs_004 TO gt_004.



  ENDLOOP.



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



  DATA: lv_mblnr TYPE mblnr,     "######

        lv_mjahr TYPE mjahr,     "####

        lv_zeile TYPE numc4,     "#####

        lv_belnr like zmseg19-belnr.

  DATA: lv_ok TYPE abap_bool.



  " ALV ## ##

  IF gc_grid1 IS BOUND.

    CALL METHOD gc_grid1->check_changed_data.

  ENDIF.



  " ### ## ###

  DATA lt_checked TYPE TABLE OF ty_001.

  LOOP AT gt_001 INTO gs_001 WHERE l_check = abap_true.

    APPEND gs_001 TO lt_checked.

  ENDLOOP.



  IF lt_checked IS INITIAL.

    MESSAGE '## ### ## #### #####.' TYPE 'S'.

    RETURN.

  ENDIF.



  " ###### ## ##(ZMKPF19)

  SELECT MAX( mblnr ) FROM zmkpf19 INTO @lv_mblnr.

  IF lv_mblnr IS INITIAL.

    lv_mblnr = '5000000000'.

  ELSE.

    lv_mblnr = lv_mblnr + 1.

  ENDIF.






*  SELECT MAX( belnr ) FROM zmseg19 INTO @lv_belnr.

*  IF lv_belnr IS INITIAL.

*    lv_belnr '0000000001'.

*  ELSE.

*    lv_belnr = lv_belnr + 1.






  lv_mjahr = p_date(4).



  "-------------------------------------------

  " 1) ## ##

  "-------------------------------------------

  CLEAR gs_002.

  gs_002-mblnr = lv_mblnr.

  gs_002-mjahr = lv_mjahr.

  gs_002-bldat = p_date.

  gs_002-budat = p_date.

  gs_002-blart = 'WE'.



  INSERT zmkpf19 FROM gs_002.

  APPEND gs_002 TO gt_002.



  "-------------------------------------------

  " 2) ### ##

  "-------------------------------------------

  lv_zeile = 10.



  LOOP AT lt_checked INTO gs_001.



    PERFORM validate_line USING gs_001 CHANGING lv_ok.

    IF lv_ok = abap_false.

      ROLLBACK WORK.

      RETURN.   " #### ### ## ##

    ENDIF.



    CLEAR gs_003.

    MOVE-CORRESPONDING gs_001 TO gs_003.



    gs_003-mblnr = lv_mblnr.

    gs_003-mjahr = lv_mjahr.

    gs_003-zeile = lv_zeile.

    gs_003-gjahr = p_date(4).

    gs_003-shkzg = 'S'.

    gs_003-belnr = 0000000001.



    gs_003-bukrs = gs_001-bukrs.



    gs_001-dmbtr = gs_001-menge * gs_001-stprs.

    gs_003-dmbtr = gs_001-dmbtr.



    INSERT zmseg19 FROM gs_003.



  IF sy-subrc <> 0.

    MESSAGE '### ######. ## ######.' TYPE 'E'.

  ENDIF.





    APPEND gs_003 TO gt_003.



    CLEAR gs_004.



    MOVE-CORRESPONDING gs_003 TO gs_004.



    gs_004-zmatname = gs_001-zmatname.

    gs_004-dmbtr = gs_001-dmbtr.

    gs_004-bedat = gs_001-bedat.

    gs_004-prdat = gs_001-prdat.



    APPEND gs_004 TO gt_004.



  DATA lv_idx TYPE sy-tabix.



  READ TABLE gt_001 ASSIGNING FIELD-SYMBOL(<fs>)

  WITH KEY ebeln  = gs_001-ebeln

           ebelp  = gs_001-ebelp

           zmatnr = gs_001-zmatnr

           zwerks = gs_001-zwerks

           zlgort = gs_001-zlgort.



  IF sy-subrc = 0.



    " ## ## = ## ## ## - ## ## ##

    <fs>-remain_menge = <fs>-remain_menge - gs_001-menge.



    IF <fs>-remain_menge <= 0.

      DELETE gt_001 INDEX sy-tabix.

    ELSE.

      <fs>-menge   = <fs>-remain_menge.   " ### ##

      <fs>-l_check = abap_false.

    ENDIF.



  ENDIF.



    lv_zeile = lv_zeile + 10.



  ENDLOOP.



  COMMIT WORK.



  MESSAGE '## ## ##.' TYPE 'S'.



  CALL METHOD gc_grid1->refresh_table_display.

ENDFORM.



FORM delete_data .



  DATA: lt_rows TYPE lvc_t_row,

        ls_row  TYPE lvc_s_row,

        ls_data TYPE ty_004, "gt_004 ##

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



    READ TABLE gt_004 INTO ls_data INDEX ls_row-index.

    IF sy-subrc <> 0.

      CONTINUE.

    ENDIF.



    "DB(ZMSEG19)## ##

    DELETE FROM zmseg19

      WHERE mblnr = @ls_data-mblnr

        AND mjahr = @ls_data-mjahr

        AND zeile = @ls_data-zeile.



    "GT_004## ##

    DELETE gt_004 INDEX ls_row-index.



    "GT_001# ## ##

    CLEAR ls_new.

    MOVE-CORRESPONDING ls_data TO ls_new.



    "#### ###

    ls_new-l_check = abap_false.



    "## GT_001# append

    APPEND ls_new TO gt_001.



    "##(ZMKPF19) ## ### ### ## # ##

    SELECT COUNT(*)

      FROM zmseg19

      WHERE mblnr = @ls_data-mblnr

        AND mjahr = @ls_data-mjahr

      INTO @lv_cnt.



    IF lv_cnt = 0.

      DELETE FROM zmkpf19

        WHERE mblnr = @ls_data-mblnr

          AND mjahr = @ls_data-mjahr.

    ENDIF.



  ENDLOOP.



  COMMIT WORK.



  CALL METHOD gc_grid2->refresh_table_display.



  MESSAGE '## ### #######.' TYPE 'S'.



ENDFORM.



FORM validate_line USING p_row TYPE ty_001

                   CHANGING p_ok TYPE abap_bool.



  p_ok = abap_true.



  "--------------------------------------------------------

  " 1) ## ## ## / 0 ##

  "--------------------------------------------------------

  IF p_row-menge IS INITIAL OR p_row-menge <= 0.

    MESSAGE e398(00)

      WITH |### 0## # ### #####. (## { p_row-ebelp })|.

    p_ok = abap_false.

    RETURN.

  ENDIF.



  "--------------------------------------------------------

  " 2) PO ## ## ## ##

  "--------------------------------------------------------

  IF p_row-menge > p_row-remain_menge.

     MESSAGE e398(00)

  WITH |## ### #### ## ### ###### (##: { p_row-remain_menge }, ##: { p_row-menge })|.

    p_ok = abap_false.

    RETURN.

  ENDIF.



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

  CLEAR : GS_FIELDCAT, GT_FIELDCAT2.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'EBELN'.

  GS_FIELDCAT-SCRTEXT_M = '######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZMATNAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'BEDAT'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-OUTPUTLEN = 10. "## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZMATNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-DECIMALS      = 0.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'STPRS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'PRDAT'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZWERKS'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZLGORT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = 4.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



ENDFORM.