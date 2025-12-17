
*&---------------------------------------------------------------------*

*&  Include           ZPRO11_002_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  CONTROL_SCREEN

*&---------------------------------------------------------------------*

*       ## ## ##

*----------------------------------------------------------------------*




FORM CONTROL_SCREEN .

  LOOP AT SCREEN.

    CASE screen-group1.

      WHEN 'M1'. "###

        IF p_rad1 = 'X'. "####

          screen-active = 1.

        ELSE.

          screen-active = 0.

        ENDIF.



      WHEN 'M2'. "######

        IF p_rad2 = 'X'. "####

          screen-active = 1.

        ELSE.

          screen-active = 0.

        ENDIF.



      WHEN 'ALL'. "####, ###

        screen-active = 1. "## ##



    ENDCASE.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  INIT_CONTAINER

*&---------------------------------------------------------------------*

*       ALV #### # ### ##

*----------------------------------------------------------------------*




FORM INIT_CONTAINER .

CREATE OBJECT GO_DOCK

  EXPORTING

    REPID                       = sy-repid

    DYNNR                       = sy-dynnr

    EXTENSION                   = 2000.



CREATE OBJECT GO_GRID

  EXPORTING

    I_PARENT          = go_dock.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_FIELDCAT

*&---------------------------------------------------------------------*

*       #### ###### ##

*----------------------------------------------------------------------*




FORM SET_FIELDCAT .

 CLEAR : gs_fcat, gt_fcat.

 gs_fcat-col_pos = 1.

 gs_fcat-coltext = '##'.

 gs_fcat-fieldname = 'EBELP'.

 APPEND gs_fcat TO gt_fcat.



 CLEAR : gs_fcat.

 gs_fcat-col_pos = 2.

 gs_fcat-coltext = '####'.

 gs_fcat-fieldname = 'ZMATNR'.

 gs_fcat-ref_table = 'ZPRO11_010'.

 gs_fcat-f4availabl = 'X'.   " F4 ###

 gs_fcat-edit = 'X'.

 APPEND gs_fcat TO gt_fcat.



 CLEAR : gs_fcat.

 gs_fcat-col_pos = 3.

 gs_fcat-coltext = '###'.

 gs_fcat-fieldname = 'ZMAKTX'.

 APPEND gs_fcat TO gt_fcat.



 CLEAR : gs_fcat.

 gs_fcat-col_pos = 4.

 gs_fcat-coltext = 'PO##'.

 gs_fcat-fieldname = 'MENGE'.

 gs_fcat-edit = 'X'.

 gs_fcat-decimals = 3.

 APPEND gs_fcat TO gt_fcat.



 CLEAR : gs_fcat.

 gs_fcat-col_pos = 5.

 gs_fcat-coltext = '##'.

 gs_fcat-fieldname = 'STPRS'.

 gs_fcat-decimals = 2.

 APPEND gs_fcat TO gt_fcat.



 CLEAR : gs_fcat.

 gs_fcat-col_pos = 6.

 gs_fcat-coltext = '##'.

 gs_fcat-fieldname = 'MEINS'.

 APPEND gs_fcat TO gt_fcat.



 CLEAR : gs_fcat.

 gs_fcat-col_pos = 7.

 gs_fcat-coltext = '##'.

 gs_fcat-fieldname = 'WAERS'.

 APPEND gs_fcat TO gt_fcat.



 CLEAR : gs_fcat.

 gs_fcat-col_pos = 8.

 gs_fcat-coltext = '####'.

 gs_fcat-fieldname = 'MWSKZ'.

 APPEND gs_fcat TO gt_fcat.



 CLEAR : gs_fcat.

 gs_fcat-col_pos = 9.

 gs_fcat-coltext = '###'.

 gs_fcat-fieldname = 'PRDAT'.

 gs_fcat-edit = 'X'.

 APPEND gs_fcat TO gt_fcat.



 CLEAR : gs_fcat.

 gs_fcat-col_pos = 10.

 gs_fcat-coltext = '###'.

 gs_fcat-fieldname = 'ZWERKS'.

 APPEND gs_fcat TO gt_fcat.



 CLEAR : gs_fcat.

 gs_fcat-col_pos = 11.

 gs_fcat-coltext = '####'.

 gs_fcat-fieldname = 'ZLGORT'.

 APPEND gs_fcat TO gt_fcat.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_VARIANT

*&---------------------------------------------------------------------*

*       #### ## ##

*----------------------------------------------------------------------*




FORM SET_VARIANT .

  CLEAR : gs_variant.

  gs_variant-report = sy-repid.

  gs_variant-username = sy-uname.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_SORT

*&---------------------------------------------------------------------*

*       ## ##

*----------------------------------------------------------------------*




FORM SET_SORT .



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_EVENT_HANDLER

*&---------------------------------------------------------------------*

*       ### ### ##

*----------------------------------------------------------------------*




FORM SET_EVENT_HANDLER .

  CREATE OBJECT go_handler.

 " ALV F4 ### ### ##

  SET HANDLER go_handler->handle_f4 FOR go_grid.



 " F4 ## ## (ALV## F4# # ##)

  DATA: lt_f4 TYPE lvc_t_f4,

        ls_f4 TYPE lvc_s_f4.



  CLEAR ls_f4.

  ls_f4-fieldname  = 'ZMATNR'.  " ALV## F4# #### ##

  ls_f4-register   = 'X'.

  ls_f4-chngeafter = 'X'.

  APPEND ls_f4 TO lt_f4.



  CALL METHOD go_grid->register_f4_for_fields

    EXPORTING it_f4 = lt_f4.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DISPLAY_ALV

*&---------------------------------------------------------------------*

*       ALV ## ##

*----------------------------------------------------------------------*




FORM DISPLAY_ALV .

  CALL METHOD GO_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT                    = gs_variant

      I_SAVE                        = 'A'

      IS_LAYOUT                     = gs_layo

    CHANGING

      IT_OUTTAB                     = gt_item

      IT_FIELDCATALOG               = gt_fcat

      IT_SORT                       = gt_sort.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH_ALV

*&---------------------------------------------------------------------*

*       ALV ## ##

*----------------------------------------------------------------------*




FORM REFRESH_ALV .

  DATA : ls_stable TYPE lvc_s_stbl.



  ls_stable-row = 'X'.

  ls_stable-col = 'X'.



  CALL METHOD GO_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE      = ls_stable.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ADD_ROW

*&---------------------------------------------------------------------*

*       ## # ##

*----------------------------------------------------------------------*




FORM ADD_ROW .



  DATA(lv_keep) = gs_item-ebelp.  " ebelp ## ##

  CLEAR gs_item.                  " ## ###

  gs_item-ebelp = lv_keep.        " ebelp ##



  IF gs_item-ebelp IS INITIAL.

    gs_item-ebelp = 10.

  ELSE.

    gs_item-ebelp = gs_item-ebelp + 10.

  ENDIF.



  "######### ### ### ## ### ## ## ##.

  SELECT SINGLE waers mwskz FROM zpro11_003

  INTO CORRESPONDING FIELDS OF gs_item

  WHERE lifnr = p_lifnr.



  APPEND gs_item TO gt_item.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DELETE_ROW

*&---------------------------------------------------------------------*

*       ## # ##

*----------------------------------------------------------------------*




FORM DELETE_ROW .

  DATA lt_rows TYPE lvc_t_row.

  DATA ls_row TYPE lvc_s_row.



  CALL METHOD go_grid->get_selected_rows

    IMPORTING

      et_index_rows = lt_rows.



  IF lt_rows IS INITIAL.

    MESSAGE '### ## #####.' TYPE 'I'.

    RETURN.

  ENDIF.



  " ## ## (### ## ##)

  SORT lt_rows DESCENDING BY index.



  LOOP AT lt_rows INTO ls_row.

    DELETE gt_item INDEX ls_row-index.

  ENDLOOP.



  CALL METHOD go_grid->refresh_table_display.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_ORDER

*&---------------------------------------------------------------------*

*       #### ##

*----------------------------------------------------------------------*




FORM SAVE_ORDER CHANGING cv_ebeln TYPE zpro11_004-ebeln.



  PERFORM calc_order_number CHANGING cv_ebeln.



  " HEADER ##

  CLEAR gs_header.

  gs_header-ebeln = cv_ebeln.

  gs_header-bedat = p_bedat.



  SELECT SINGLE lifnr ekgrp ekorg waers FROM zpro11_003

  INTO CORRESPONDING FIELDS OF gs_header

  WHERE lifnr = p_lifnr.



  SELECT SINGLE bukrs FROM zpro11_002

  INTO CORRESPONDING FIELDS OF gs_header

  WHERE bukrs = p_bukrs.



  APPEND gs_header TO gt_header.



  " ITEM ##

  LOOP AT gt_item INTO gs_item.

    CLEAR gs_detail.

    gs_detail-ebeln = cv_ebeln.

    gs_detail-ebelp = gs_item-ebelp.

    gs_detail-matnr = gs_item-zmatnr.

    gs_detail-maktx = gs_item-zmaktx.

    gs_detail-menge = gs_item-menge.

    gs_detail-bprme = gs_item-stprs.

    gs_detail-meins = gs_item-meins.

    gs_header-waers = gs_item-waers.

    gs_detail-prdat = gs_item-prdat.

    gs_detail-werks = gs_item-zwerks.

    gs_detail-lgort = gs_item-zlgort.

    APPEND gs_detail TO gt_detail.

  ENDLOOP.



  INSERT zpro11_004 FROM TABLE gt_header.

  INSERT zpro11_005 FROM TABLE gt_detail.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALC_ORDER_NUMBER

*&---------------------------------------------------------------------*

*       #### ## ## ##

*----------------------------------------------------------------------*




FORM calc_order_number CHANGING pv_ebeln TYPE zpro11_004-ebeln.



  DATA lv_max TYPE zpro11_004-ebeln.



  SELECT MAX( ebeln ) INTO lv_max FROM zpro11_004.



  IF lv_max IS INITIAL.

    pv_ebeln = '0000000001'.

  ELSE.

    pv_ebeln = lv_max + 1.

    pv_ebeln = |{ pv_ebeln ALPHA = IN }|.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_BUKRS

*&---------------------------------------------------------------------*

*       #### + ### ##

*----------------------------------------------------------------------*




FORM CHECK_BUKRS .

  "#### ## ##### ### ## ###### ### ####.

  "### ### ## ## #### ####.



  DATA lv_cnt TYPE i.



  "#### + ### ### ## ##### ##

  SELECT COUNT(*)

    INTO lv_cnt

    FROM zpro11_002

    WHERE bukrs = p_bukrs

      AND lifnr = p_lifnr.



  IF lv_cnt = 0.

    MESSAGE '## ##### ### ### #### ####.' TYPE 'I'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  PROCESS_ALV_F4

*&---------------------------------------------------------------------*

*       ALV F4 ### ##

*----------------------------------------------------------------------*




FORM process_alv_f4 USING p_fieldname

                     p_row_no

                     p_event_data TYPE REF TO cl_alv_event_data

                     p_bad_cells

                     p_display.



  FIELD-SYMBOLS: <fs>   LIKE gs_item,

                 <itab> TYPE lvc_t_modi.



  "=========================================================

  " F4 ### ## ## (No input help is available ##)

  "=========================================================

  IF p_event_data IS BOUND.

    p_event_data->m_event_handled = 'X'.

  ENDIF.



  " ## # ##

  READ TABLE gt_item ASSIGNING <fs> INDEX p_row_no.

  IF sy-subrc <> 0 OR <fs> IS NOT ASSIGNED.

    RETURN.

  ENDIF.



  CASE p_fieldname.



    WHEN 'ZMATNR'.



      "=========================================================

      " F4 ### ### ## ##

      "=========================================================

      TYPES: BEGIN OF ty_f4,

               zmatnr   TYPE zpro11_010-zmatnr,    "####

               zmatname TYPE zpro11_010-zmatname,  "###

               stprs    TYPE zpro11_010-stprs,     "##

               meins    TYPE zpro11_010-meins,     "##

               zwerks   TYPE zpro11_010-zwerks,    "###

               zlgort   TYPE zpro11_010-zlgort,    "####

             END OF ty_f4.



      DATA: lt_f4 TYPE TABLE OF ty_f4.



      "=========================================================

      " DB## ### ##

      "=========================================================

      SELECT zmatnr zmatname stprs meins zwerks zlgort

        FROM zpro11_010

        INTO TABLE lt_f4.



      "=========================================================

      " F4 ## ##

      "=========================================================

      DATA lt_return TYPE TABLE OF ddshretval.



      CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'

        EXPORTING

          retfield    = 'ZMATNR'   " #### ALV# ### #

          value_org   = 'S'

          dynpprog    = sy-repid

          dynpnr      = sy-dynnr

        TABLES

          value_tab   = lt_f4      " #### ## ### ###

          return_tab  = lt_return

        EXCEPTIONS

          OTHERS      = 1.



      "=========================================================

      " ### ### ##

      "=========================================================

      IF sy-subrc <> 0 OR lt_return IS INITIAL.

        RETURN.

      ENDIF.



      "=========================================================

      " ### # ALV# ##

      "=========================================================

      ASSIGN p_event_data->m_data->* TO <itab>.



      " ### #### ##

      DATA(lv_sel_matnr) = lt_return[ 1 ]-fieldval.



      " ### ## ## ##

      DATA(ls_sel) = VALUE ty_f4( ).

      READ TABLE lt_f4 INTO ls_sel WITH KEY zmatnr = lv_sel_matnr.



      IF sy-subrc = 0.



        " 1) ZMATNR

        DATA(ls1) = VALUE lvc_s_modi(

                       row_id    = p_row_no

                       fieldname = 'ZMATNR'

                       value     = ls_sel-zmatnr ).

        APPEND ls1 TO <itab>.



        " 2) ZMATNAME

        DATA(ls2) = VALUE lvc_s_modi(

                       row_id    = p_row_no

                       fieldname = 'ZMAKTX'

                       value     = ls_sel-zmatname ).

        APPEND ls2 TO <itab>.



        " 3) STPRS

        DATA(ls3) = VALUE lvc_s_modi(

                       row_id    = p_row_no

                       fieldname = 'STPRS'

                       value     = ls_sel-stprs ).

        APPEND ls3 TO <itab>.



        " 4) MEINS

        DATA(ls4) = VALUE lvc_s_modi(

                       row_id    = p_row_no

                       fieldname = 'MEINS'

                       value     = ls_sel-meins ).

        APPEND ls4 TO <itab>.





        " 5) ZWERKS

        DATA(ls5) = VALUE lvc_s_modi(

                       row_id    = p_row_no

                       fieldname = 'ZWERKS'

                       value     = ls_sel-zwerks ).

        APPEND ls5 TO <itab>.



        " 6) ZLGORT

        DATA(ls6) = VALUE lvc_s_modi(

                       row_id    = p_row_no

                       fieldname = 'ZLGORT'

                       value     = ls_sel-zlgort ).

        APPEND ls6 TO <itab>.



      ENDIF.



      " ALV ## ##

      go_grid->refresh_table_display( ).



  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_BEDAT

*&---------------------------------------------------------------------*

*       ### ##

*----------------------------------------------------------------------*




FORM CHECK_BEDAT .

  IF p_bedat IS INITIAL.

    MESSAGE '#### ######!' TYPE 'I'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_PRDAT

*&---------------------------------------------------------------------*

*       ### ##

*----------------------------------------------------------------------*




FORM CHECK_PRDAT .

  LOOP AT gt_item INTO gs_item.



    "### ### #

    IF gs_item-prdat IS INITIAL.

      MESSAGE '#### ######.' TYPE 'E'.

    ENDIF.



    "### < ### -> ##

    IF gs_item-prdat < p_bedat.

      MESSAGE '#### ##### ### #### ###.' TYPE 'E'.

    ENDIF.



  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_EBELN

*&---------------------------------------------------------------------*

*       ###### ##

*----------------------------------------------------------------------*




FORM CHECK_EBELN .

  "#### ## ####, ###### ### ## PO### ### ####.

  "### ### ## ## #### ####.



  DATA lv_cnt TYPE i.



  "#### + ### ### ## ##### ##

  SELECT COUNT(*)

    INTO lv_cnt

    FROM zpro11_004

    WHERE bukrs = p_bukrs

      AND lifnr = p_lifnr

      AND ebeln = p_ebeln.





  IF lv_cnt = 0.

    MESSAGE '## ####, ###### PO## ### #### ####.' TYPE 'I'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SELECT_DATA

*&---------------------------------------------------------------------*

*       #### ## ##

*----------------------------------------------------------------------*




FORM SELECT_DATA .

  SELECT *

    INTO TABLE gt_detail

    FROM zpro11_005

    WHERE ebeln = p_ebeln.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_FIELDCAT_DISP

*&---------------------------------------------------------------------*

*       #### ###### ##

*----------------------------------------------------------------------*




FORM SET_FIELDCAT_DISP .

  CLEAR : gs_fcat, gt_fcat.

 gs_fcat-col_pos = 1.

 gs_fcat-coltext = '######'.

 gs_fcat-fieldname = 'EBELN'.

 APPEND gs_fcat TO gt_fcat.



 CLEAR : gs_fcat.

 gs_fcat-col_pos = 2.

 gs_fcat-coltext = '##'.

 gs_fcat-fieldname = 'EBELP'.

 APPEND gs_fcat TO gt_fcat.



 CLEAR : gs_fcat.

 gs_fcat-col_pos = 3.

 gs_fcat-coltext = '####'.

 gs_fcat-fieldname = 'MATNR'.

 APPEND gs_fcat TO gt_fcat.



 CLEAR : gs_fcat.

 gs_fcat-col_pos = 4.

 gs_fcat-coltext = '###'.

 gs_fcat-fieldname = 'MAKTX'.

 gs_fcat-edit = 'X'.

 APPEND gs_fcat TO gt_fcat.



 CLEAR : gs_fcat.

 gs_fcat-col_pos = 5.

 gs_fcat-coltext = '##'.

 gs_fcat-fieldname = 'MENGE'.

 APPEND gs_fcat TO gt_fcat.



 CLEAR : gs_fcat.

 gs_fcat-col_pos = 6.

 gs_fcat-coltext = '##'.

 gs_fcat-fieldname = 'MEINS'.

 APPEND gs_fcat TO gt_fcat.



 CLEAR : gs_fcat.

 gs_fcat-col_pos = 7.

 gs_fcat-coltext = '##'.

 gs_fcat-fieldname = 'BPRME'.

 APPEND gs_fcat TO gt_fcat.



 CLEAR : gs_fcat.

 gs_fcat-col_pos = 8.

 gs_fcat-coltext = '###'.

 gs_fcat-fieldname = 'PRDAT'.

 APPEND gs_fcat TO gt_fcat.



 CLEAR : gs_fcat.

 gs_fcat-col_pos = 9.

 gs_fcat-coltext = '###'.

 gs_fcat-fieldname = 'WERKS'.

 APPEND gs_fcat TO gt_fcat.



 CLEAR : gs_fcat.

 gs_fcat-col_pos = 10.

 gs_fcat-coltext = '####'.

 gs_fcat-fieldname = 'LGORT'.

 APPEND gs_fcat TO gt_fcat.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DISPLAY_ALV_DISP

*&---------------------------------------------------------------------*

*       #### ALV ##

*----------------------------------------------------------------------*




FORM DISPLAY_ALV_DISP .

  CALL METHOD GO_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT                    = gs_variant

      I_SAVE                        = 'A'

      IS_LAYOUT                     = gs_layo

    CHANGING

      IT_OUTTAB                     = gt_detail

      IT_FIELDCATALOG               = gt_fcat

      IT_SORT                       = gt_sort.

ENDFORM.