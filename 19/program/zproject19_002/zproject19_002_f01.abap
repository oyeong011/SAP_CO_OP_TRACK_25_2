
*&---------------------------------------------------------------------*

*&  Include           ZPROJECT19_002_F01

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

      WHEN 'M1'.

        IF rb_cr = c_x. "##

          screen-active = 1.

        ELSE.

          screen-active = 0.

        ENDIF.



      WHEN 'M2'.

        IF rb_dsp = c_x. "##

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

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM get_data .



  DATA: ls_003 TYPE zpdt19_003,

        lv_cnt TYPE I.



  SELECT COUNT(*)

    INTO lv_cnt

    FROM zpdt19_002

  WHERE bukrs = p_bukrs

    AND lifnr = p_lifnr.



  IF lv_cnt = 0.

    MESSAGE '##### ### ### #### ####.' TYPE 'E'.

    EXIT.

  ENDIF.



  SELECT SINGLE waers zmwskz

    FROM zpdt19_003

    INTO CORRESPONDING FIELDS OF ls_003

    WHERE lifnr = p_lifnr.



  CLEAR gs_001.



  IF sy-subrc = 0.

    gv_waers  = ls_003-waers.

    gv_zmwskz = ls_003-zmwskz.

  ENDIF.



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



  CREATE OBJECT GC_GRID1

    EXPORTING

      I_PARENT = GC_DOCKING.

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



  " ## 2## Splitter

  CREATE OBJECT gc_splitter

    EXPORTING

      parent  = gc_docking

      rows    = 1

      columns = 2.



  " ## Container

  CALL METHOD gc_splitter->get_container

    EXPORTING

      row     = 1

      column  = 1

    RECEIVING

      container = gc_container2.



  " ### Container

  CALL METHOD gc_splitter->get_container

    EXPORTING

      row     = 1

      column  = 2

    RECEIVING

      container = gc_container3.



  " ## GRID

  CREATE OBJECT gc_grid2

    EXPORTING

      i_parent = gc_container2.



  " ### GRID

  CREATE OBJECT gc_grid3

    EXPORTING

      i_parent = gc_container3.

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

  CLEAR : GS_FIELDCAT, GT_FIELDCAT1.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'EBELP'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZMATNR'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-F4AVAILABL = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZMATNAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-DECIMALS = 3.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'STPRS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-DECIMALS = 0.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-OUTPUTLEN = '3'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZMWSKZ'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '4'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'PRDAT'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZWERKS'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZLGORT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

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

*&      Form  FIELD_CATALOG2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG2 .

  PERFORM CONTAINER2_FIELD.

  PERFORM CONTAINER3_FIELD.

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

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-FIELDNAME = 'EBELN'.

  GS_FIELDCAT-SCRTEXT_M = '######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'BUKRS'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'EKGRP'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'EKORG'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'BEDAT'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER3_FIELD

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CONTAINER3_FIELD .

  CLEAR : GS_FIELDCAT , GT_FIELDCAT3.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-FIELDNAME = 'EBELN'.

  GS_FIELDCAT-SCRTEXT_M = '######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'EBELP'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZMATNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZMATNAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'STPRS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'PRDAT'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZWERKS'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZLGORT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA2 .



  DATA : lv_cnt TYPE I.



  SELECT COUNT(*)

    INTO lv_cnt

    FROM zpdt19_002

  WHERE bukrs = p_bukrs

    AND lifnr = p_lifnr.



  IF lv_cnt = 0.

    MESSAGE '##### ### ### #### ####.' TYPE 'E'.

    EXIT.

  ENDIF.



  CLEAR : gs_002, gs_003, gt_002, gt_003.



  SELECT

    A~EBELN,

    A~BUKRS,

    A~EKGRP,

    A~EKORG,

    A~LIFNR,

    A~BEDAT,

    A~WAERS

  FROM zpdt19_004 AS A

  INNER JOIN zpdt19_005 AS B

    ON A~EBELN = B~EBELN "PO##

 WHERE A~LIFNR = @p_lifnr "#####

   AND A~EBELN = @p_ebeln

   AND A~BUKRS = @p_bukrs

  INTO CORRESPONDING FIELDS OF TABLE @gt_002.



  SELECT

    B~EBELN,

    B~EBELP,

    B~ZMATNR,

    B~ZMATNAME,

    B~MENGE,

    B~MEINS,

    B~STPRS,

    B~PRDAT,

    B~ZWERKS,

    B~ZLGORT

  FROM zpdt19_005 AS B

  INNER JOIN zpdt19_004 AS A

    ON A~EBELN = B~EBELN

 WHERE A~LIFNR = @p_lifnr

   AND A~EBELN = @p_ebeln

   AND A~BUKRS = @p_bukrs

  INTO CORRESPONDING FIELDS OF TABLE @gt_003.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ADD_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM add_data.



  DATA lv_last_ebelp TYPE ebelp.

  lv_last_ebelp = 0.



  " ALV #### ## ##

  IF gc_grid1 IS BOUND.

    CALL METHOD gc_grid1->check_changed_data.

  ENDIF.



  " ## ####### ## # EBELP ##

  LOOP AT gt_001 INTO gs_001.

    IF gs_001-ebelp > lv_last_ebelp.

      lv_last_ebelp = gs_001-ebelp.

    ENDIF.

  ENDLOOP.



  " ## ## ##

  IF lv_last_ebelp IS INITIAL.

    lv_last_ebelp = 10.

  ELSE.

    lv_last_ebelp = lv_last_ebelp + 10.

  ENDIF.



  " ## ## ##

  CLEAR gs_001.

  gs_001-ebelp = lv_last_ebelp.

  gs_001-waers = gv_waers.

  gs_001-zmwskz = gv_zmwskz.

  APPEND gs_001 TO gt_001.



  " ALV ## ##

  CALL METHOD gc_grid1->refresh_table_display.



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

  CALL METHOD GC_GRID2->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

        IS_VARIANT = GS_VARIANT

        I_SAVE = C_A

        IS_LAYOUT = GS_LAYOUT

    CHANGING

        IT_OUTTAB = GT_002

        IT_FIELDCATALOG = GT_FIELDCAT2

        IT_SORT = GT_SORT.



  CALL METHOD GC_GRID3->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

        IS_VARIANT = GS_VARIANT

        I_SAVE = C_A

        IS_LAYOUT = GS_LAYOUT

    CHANGING

      IT_OUTTAB = GT_003

      IT_FIELDCATALOG = GT_FIELDCAT3

      IT_SORT = GT_SORT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DELETE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  DELETE_DATA

*&---------------------------------------------------------------------*

*       text : ALV## ### ####(EBELN) ##

*---------------------------------------------------------------------*




FORM delete_data.



  DATA: lt_rows TYPE lvc_t_row,

        ls_row  TYPE lvc_s_row.



  " 1) ### ALV Row ####

  CALL METHOD gc_grid1->get_selected_rows

    IMPORTING et_index_rows = lt_rows.



  IF lt_rows IS INITIAL.

    MESSAGE '### ### #####.' TYPE 'I'.

    RETURN.

  ENDIF.



  " 2) ##### #### index ## ###

  SORT lt_rows BY index DESCENDING.



  LOOP AT lt_rows INTO ls_row.

    DELETE gt_001 INDEX ls_row-index.

  ENDLOOP.



  " 3) ALV ##

  CALL METHOD gc_grid1->refresh_table_display.



ENDFORM.





FORM validate_line USING p_row TYPE ty_001

                   CHANGING p_ok TYPE abap_bool.



  p_ok = abap_true.



  "--------------------------------------------------------

  " 1) ### >= ###

  "--------------------------------------------------------

  IF p_row-prdat < p_bedat.

    MESSAGE '#### ##### ### #### ###.' TYPE 'E'.

    p_ok = abap_false.

    RETURN.

  ENDIF.



  IF p_row-menge < 1.

    MESSAGE '### 1 ### #### ###.' TYPE 'E'.

    p_ok = abap_false.

    RETURN.

  ENDIF.



  IF p_row-menge <> trunc( p_row-menge ).

    MESSAGE '### ### #####.' TYPE 'E'.

    p_ok = abap_false.

    RETURN.

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  add_item_line

*&---------------------------------------------------------------------*




FORM add_item_line.



  DATA: lv_ebeln TYPE ebeln,

        lv_max   TYPE ebeln,

        lv_num   TYPE n LENGTH 10,

        lv_ok    TYPE abap_bool,

        ls_003 TYPE zpdt19_003.



  " ALV #### ##

  IF gc_grid1 IS BOUND.

    CALL METHOD gc_grid1->check_changed_data.

  ENDIF.



  "--------------------------------------------------------

  " 1) ### ## ## (### ## ## ##)

  "--------------------------------------------------------

  LOOP AT gt_001 INTO gs_001.

    PERFORM validate_line USING gs_001 CHANGING lv_ok.

    IF lv_ok = abap_false.

      MESSAGE '### ## ##. ## ##.' TYPE 'E'.

      RETURN.

    ENDIF.

  ENDLOOP.



  "--------------------------------------------------------

  " 2) EBELN ## ## # ## 1## #### #

  "--------------------------------------------------------

  SELECT MAX( ebeln ) INTO @lv_max FROM zpdt19_004.



  IF lv_max IS INITIAL.

    lv_num = 1000000000.

  ELSE.

    lv_num = lv_max + 1.

  ENDIF.

  lv_ebeln = |{ lv_num ALPHA = IN }|.



  CLEAR ls_003.

  SELECT SINGLE ekgrp ekorg waers

    INTO (ls_003-ekgrp, ls_003-ekorg, ls_003-waers)

    FROM zpdt19_003

    WHERE lifnr = p_lifnr.

  "--------------------------------------------------------

  " 3) ## ## (# 1#!)

  "--------------------------------------------------------

  CLEAR gs_002.

  gs_002-ebeln = lv_ebeln.

  gs_002-bukrs = p_bukrs.

  gs_002-lifnr = p_lifnr.

  gs_002-bedat = p_bedat.

  gs_002-ekgrp = ls_003-ekgrp.

  gs_002-ekorg = ls_003-ekorg.

  gs_002-waers = ls_003-waers.



  INSERT zpdt19_004 FROM gs_002.

  IF sy-subrc <> 0.

    MESSAGE |## ## ##: SUBRC={ sy-subrc } EBELN={ gs_002-ebeln }| TYPE 'E'.

    RETURN.

  ENDIF.



  "--------------------------------------------------------

  " 4) ### ## N#

  "--------------------------------------------------------

  LOOP AT gt_001 INTO gs_001.



    IF gs_001-ebelp IS INITIAL.

      DATA(lv_max_ebelp) = 0.



      LOOP AT gt_001 INTO DATA(ls_tmp).

        IF ls_tmp-ebelp > lv_max_ebelp.

          lv_max_ebelp = ls_tmp-ebelp.

        ENDIF.

      ENDLOOP.



      gs_001-ebelp = lv_max_ebelp + 10.

    ENDIF.



    CLEAR gs_003.

    MOVE-CORRESPONDING gs_001 TO gs_003.

    gs_003-ebeln = lv_ebeln.   "## ## ##



    INSERT zpdt19_005 FROM gs_003.

    IF sy-subrc <> 0.

      MESSAGE |### ## ## (# { sy-tabix }) EBELN={ gs_003-ebeln } EBELP={ gs_003-ebelp } SUBRC={ sy-subrc }| TYPE 'E'.

      RETURN.

    ENDIF.





  ENDLOOP.



  COMMIT WORK.

  MESSAGE |PO { lv_ebeln } ## ##| TYPE 'S'.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  REGISTER_F4

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM register_f4.

  CLEAR gt_f4.



  APPEND VALUE #( fieldname = 'ZMATNR' register = 'X' ) TO gt_f4.

  CALL METHOD gc_grid1->register_f4_for_fields

    EXPORTING it_f4 = gt_f4.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_HANDLER

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_HANDLER .

  IF gr_handler IS INITIAL.

    CREATE OBJECT gr_handler.

  ENDIF.



  SET HANDLER gr_handler->on_f4 FOR gc_grid1.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  APPLY_F4_VALUE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM apply_f4_value .



  " # ### ##

  IF gv_f4_value IS INITIAL.

    RETURN.

  ENDIF.



  " Row ## ### ##

  IF gv_f4_rowid IS INITIAL.

    RETURN.

  ENDIF.



  " ALV ##### ##

  READ TABLE gt_001 INTO gs_001 INDEX gv_f4_rowid.

  IF sy-subrc = 0.



    CASE gv_f4_field.

      WHEN 'ZLGORT'.

        gs_001-zlgort = gv_f4_value.



      WHEN 'ZMATNR'.

        gs_001-zmatnr = gv_f4_value.

    ENDCASE.



    MODIFY gt_001 FROM gs_001 INDEX gv_f4_rowid.



  ENDIF.



  " ALV ## ##

  CALL METHOD gc_grid1->refresh_table_display.



  " # ###

  CLEAR gv_f4_value.

  CLEAR gv_f4_rowid.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FILL_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM fill_data.



  TYPES: BEGIN OF ty_mat,

           value LIKE zpdt19_005-zmatnr,

           maktx TYPE zmatname19,

           lgort TYPE zlgort19,

           werks TYPE zwerks19,

           stprs TYPE stprs,

           meins TYPE meins,

         END OF ty_mat.



  DATA: lt_mat TYPE TABLE OF ty_mat,

        lt_ret TYPE TABLE OF ddshretval,

        ls_ret TYPE ddshretval,

        ls_mat TYPE ty_mat,

        lv_field TYPE fieldname,

        lv_line  TYPE i.



  " SELECT

  SELECT zmatnr AS value,

         zmatname AS maktx,

         zlgort AS lgort,

         zwerks AS werks,

         stprs AS stprs,

         meins AS meins

    FROM zedt19_200

    INTO TABLE @lt_mat.



  " F4 ## ##

  CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'

    EXPORTING

      retfield   = 'VALUE'

      value_org  = 'S'

    TABLES

      value_tab  = lt_mat

      return_tab = lt_ret.



  " ### ##

  READ TABLE lt_ret INTO ls_ret INDEX 1.

  IF sy-subrc = 0.

    gv_f4_value = ls_ret-fieldval.



    " ### lookup

    READ TABLE lt_mat INTO ls_mat WITH KEY value = gv_f4_value.



    IF sy-subrc = 0.

      READ TABLE gt_001 INTO DATA(ls_row) INDEX gv_f4_rowid.

      IF sy-subrc = 0.

        ls_row-zmatnr = ls_mat-value.

        ls_row-zmatname = ls_mat-maktx.

        ls_row-zlgort = ls_mat-lgort.

        ls_row-zwerks = ls_mat-werks.

        ls_row-stprs = ls_mat-stprs.

        ls_row-meins = ls_mat-meins.



        MODIFY gt_001 FROM ls_row INDEX gv_f4_rowid.

      ENDIF.



      CALL METHOD gc_grid1->refresh_table_display( ).



    ENDIF.

  ENDIF.



ENDFORM.



FORM handle_f4 USING p_field TYPE lvc_fname

                     p_row   TYPE lvc_s_roid

                     p_event TYPE REF TO cl_alv_event_data.



  gv_f4_field = p_field.

  gv_f4_rowid = p_row-row_id.



  CASE gv_f4_field.

    WHEN 'ZMATNR'.

      PERFORM fill_data.

      p_event->m_event_handled = abap_true.

    WHEN OTHERS.

  ENDCASE.



  PERFORM apply_f4_value.



ENDFORM.