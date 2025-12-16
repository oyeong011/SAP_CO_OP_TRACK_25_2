
*&---------------------------------------------------------------------*

*&  Include           ZPRO07_002_F01

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

      WHEN 'M1'. "#####

        IF p_rad1 = 'X'. "####

          screen-active = 1.

        ELSE.

          screen-active = 0.

        ENDIF.



      WHEN 'M2'. "#####

        IF p_rad2 = 'X'. "####

          screen-active = 1.

        ELSE.

          screen-active = 0.

        ENDIF.



      WHEN 'ALL'. "####

        screen-active = 1. "## ##



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

CREATE OBJECT GC_DOCKING

  EXPORTING




*    PARENT                      =




    REPID                       = sy-repid

    DYNNR                       = sy-dynnr




*    SIDE                        = DOCK_AT_LEFT




    EXTENSION                   = 2000




*    STYLE                       =

*    LIFETIME                    = lifetime_default

*    CAPTION                     =

*    METRIC                      = 0

*    RATIO                       =

*    NO_AUTODEF_PROGID_DYNNR     =

*    NAME                        =

*  EXCEPTIONS

*    CNTL_ERROR                  = 1

*    CNTL_SYSTEM_ERROR           = 2

*    CREATE_ERROR                = 3

*    LIFETIME_ERROR              = 4

*    LIFETIME_DYNPRO_DYNPRO_LINK = 5

*    others                      = 6




    .



CREATE OBJECT GC_GRID

  EXPORTING




*    I_SHELLSTYLE      = 0

*    I_LIFETIME        =




    I_PARENT          = gc_docking




*    I_APPL_EVENTS     = space

*    I_PARENTDBG       =

*    I_APPLOGPARENT    =

*    I_GRAPHICSPARENT  =

*    I_NAME            =

*    I_FCAT_COMPLETE   = SPACE

*  EXCEPTIONS

*    ERROR_CNTL_CREATE = 1

*    ERROR_CNTL_INIT   = 2

*    ERROR_CNTL_LINK   = 3

*    ERROR_DP_CREATE   = 4

*    others            = 5




    .



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELDCAT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELDCAT .

 CLEAR : gs_fieldcat, gt_fieldcat.

 gs_fieldcat-col_pos = 1.

 gs_fieldcat-coltext = '##'.

 gs_fieldcat-fieldname = 'EBELP'.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 2.

 gs_fieldcat-coltext = '####'.

 gs_fieldcat-fieldname = 'ZMATNR'.

 gs_fieldcat-ref_table = 'ZEDT07_200'.

 gs_fieldcat-f4availabl = 'X'.   " F4 ###

 gs_fieldcat-edit = 'X'.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 3.

 gs_fieldcat-coltext = '###'.

 gs_fieldcat-fieldname = 'ZMAKTX'.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 4.

 gs_fieldcat-coltext = 'PO##'.

 gs_fieldcat-fieldname = 'MENGE'.

 gs_fieldcat-edit = 'X'.

 gs_fieldcat-decimals = 3.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 5.

 gs_fieldcat-coltext = '##'.

 gs_fieldcat-fieldname = 'STPRS'.

 gs_fieldcat-decimals = 2.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 6.

 gs_fieldcat-coltext = '##'.

 gs_fieldcat-fieldname = 'MEINS'.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 7.

 gs_fieldcat-coltext = '##'.

 gs_fieldcat-fieldname = 'WAERS'.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 8.

 gs_fieldcat-coltext = '####'.

 gs_fieldcat-fieldname = 'MWSKZ'.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 9.

 gs_fieldcat-coltext = '###'.

 gs_fieldcat-fieldname = 'PRDAT'.

 gs_fieldcat-edit = 'X'.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 10.

 gs_fieldcat-coltext = '###'.

 gs_fieldcat-fieldname = 'ZWERKS'.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 11.

 gs_fieldcat-coltext = '####'.

 gs_fieldcat-fieldname = 'ZLGORT'.

 APPEND gs_fieldcat TO gt_fieldcat.

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

  CLEAR : gs_variant.

  gs_variant-report = sy-repid.

  gs_variant-username = sy-uname.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_SORT .



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CLASS_EVENT .

  CREATE OBJECT go_event.

 " ALV F4 ### ### ##

  SET HANDLER go_event->on_f4 FOR gc_grid.



 " F4 ## ## (ALV## F4# # ##)

  DATA: lt_f4 TYPE lvc_t_f4,

        ls_f4 TYPE lvc_s_f4.



  CLEAR ls_f4.

  ls_f4-fieldname  = 'ZMATNR'.  " ALV## F4# #### ##

  ls_f4-register   = 'X'.

  ls_f4-chngeafter = 'X'.

  APPEND ls_f4 TO lt_f4.



  CALL METHOD gc_grid->register_f4_for_fields

    EXPORTING it_f4 = lt_f4.

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

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*      I_BUFFER_ACTIVE               =

*      I_BYPASSING_BUFFER            =

*      I_CONSISTENCY_CHECK           =

*      I_STRUCTURE_NAME              =




      IS_VARIANT                    = gs_variant

      I_SAVE                        = 'A'




*      I_DEFAULT                     = 'X'




      IS_LAYOUT                     = gs_layout




*      IS_PRINT                      =

*      IT_SPECIAL_GROUPS             =

*      IT_TOOLBAR_EXCLUDING          =

*      IT_HYPERLINK                  =

*      IT_ALV_GRAPHICS               =

*      IT_EXCEPT_QINFO               =

*      IR_SALV_ADAPTER               =




    CHANGING

      IT_OUTTAB                     = gt_product

      IT_FIELDCATALOG               = gt_fieldcat

      IT_SORT                       = gt_sort




*      IT_FILTER                     =

*    EXCEPTIONS

*      INVALID_PARAMETER_COMBINATION = 1

*      PROGRAM_ERROR                 = 2

*      TOO_MANY_LINES                = 3

*      others                        = 4




          .

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM REFRESH .

  DATA : ls_stable TYPE lvc_s_stbl.



  ls_stable-row = 'X'.

  ls_stable-col = 'X'.



  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE      = ls_stable




*      I_SOFT_REFRESH =

*    EXCEPTIONS

*      FINISHED       = 1

*      others         = 2




          .

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  PLUS_PRODUCT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM PLUS_PRODUCT .



  DATA(ls_keep) = gs_product-ebelp.  " ebelp ## ##

  CLEAR gs_product.                  " ## ###

  gs_product-ebelp = ls_keep.        " ebelp ##



  IF gs_product-ebelp IS INITIAL.

    gs_product-ebelp = 10.

  ELSE.

    gs_product-ebelp = gs_product-ebelp + 10.

  ENDIF.



  "######### ### ### ## ### ## ## ##.

  SELECT SINGLE waers mwskz FROM zpro07_003

  INTO CORRESPONDING FIELDS OF gs_product

  WHERE lifnr = p_lifnr.







  APPEND gs_product TO gt_product.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MINUS_PRODUCT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MINUS_PRODUCT .

  DATA lt_rows TYPE lvc_t_row.

  DATA ls_row TYPE lvc_s_row.



  CALL METHOD gc_grid->get_selected_rows

    IMPORTING

      et_index_rows = lt_rows.



  IF lt_rows IS INITIAL.

    MESSAGE '### ## #####.' TYPE 'I'.

    RETURN.

  ENDIF.



  " ## ## (### ## ##)

  SORT lt_rows DESCENDING BY index.



  LOOP AT lt_rows INTO ls_row.

    DELETE gt_product INDEX ls_row-index.

  ENDLOOP.



  CALL METHOD gc_grid->refresh_table_display.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_PRODUCT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_PRODUCT .

  DATA lv_ebeln TYPE zpro07_004-ebeln.



  PERFORM auto_calculate_buyorder CHANGING lv_ebeln.



  " HEADER ##  LOOP #!!!

  CLEAR gs_004.

  gs_004-ebeln = lv_ebeln.

  gs_004-bedat = p_bedat.



  SELECT SINGLE lifnr ekgrp ekorg waers FROM zpro07_003

  INTO CORRESPONDING FIELDS OF gs_004

  WHERE lifnr = p_lifnr.



  SELECT SINGLE bukrs FROM zpro07_002

  INTO CORRESPONDING FIELDS OF gs_004

  WHERE bukrs = p_bukrs.



  APPEND gs_004 TO gt_004.



  " ITEM ##  LOOP #

  LOOP AT gt_product INTO gs_product.



    CLEAR gs_005.



    " EBELN # LOOP ### ## #### #!!!

    gs_005-ebeln = lv_ebeln.



    " gs_product # gs_004/gs_005 # ##



    "gs_004




*    gs_004-bukrs = gs_product-bukrs.

*    gs_004-ekgrp = gs_product-ekorg.

*    gs_004-lifnr = gs_product-lifnr.

*    gs_004-bedat = gs_product-bedat.

*    gs_004-waers = gs_product-waers.






    "gs_005

    gs_005-ebelp = gs_product-ebelp.

    gs_005-matnr = gs_product-zmatnr.

    gs_005-maktx = gs_product-zmaktx.

    gs_005-menge = gs_product-menge.

    gs_005-bprme = gs_product-stprs.

    gs_005-meins = gs_product-meins.

    gs_004-waers = gs_product-waers.

    gs_005-prdat = gs_product-prdat.

    gs_005-werks = gs_product-zwerks.

    gs_005-lgort = gs_product-zlgort.



    APPEND gs_005 TO gt_005.



  ENDLOOP.



  INSERT zpro07_004 FROM TABLE gt_004.

  INSERT zpro07_005 FROM TABLE gt_005.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  AUTO_CALCULATE_BUYORDER

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM auto_calculate_buyorder CHANGING pv_ebeln TYPE zpro07_004-ebeln.



  DATA lv_max TYPE zpro07_004-ebeln.



  SELECT MAX( ebeln ) INTO lv_max FROM zpro07_004.



  IF lv_max IS INITIAL.

    pv_ebeln = '0000000001'.

  ELSE.

    pv_ebeln = lv_max + 1.

    pv_ebeln = |{ pv_ebeln ALPHA = IN }|.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  VERIFY_BURKS

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM VERIFY_BURKS .

  "#### ## ##### ### ## ###### ### ####.

  "### ### ## ## #### ####.



  DATA lv_cnt TYPE i.



  IF p_bedat IS INITIAL.

    EXIT.

  ENDIF.



  "#### + ### ### ## ##### ##

  SELECT COUNT(*)

    INTO lv_cnt

    FROM zpro07_002

    WHERE bukrs = p_bukrs

      AND lifnr = p_lifnr.



  IF lv_cnt = 0.

    MESSAGE '## ##### ### ### #### ####.' TYPE 'E'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REGISTER_F4_FIELDS

*&---------------------------------------------------------------------*




FORM REGISTER_F4_FIELDS .

  DATA: lt_f4 TYPE lvc_t_f4,

        ls_f4 TYPE lvc_s_f4.



  CLEAR ls_f4.

  ls_f4-fieldname  = 'ZMATNR'.  " ALV ###

  ls_f4-register   = 'X'.

  ls_f4-chngeafter = 'X'.

  APPEND ls_f4 TO lt_f4.



  CALL METHOD gc_grid->register_f4_for_fields

    EXPORTING

      it_f4 = lt_f4.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_ON_F4

*&---------------------------------------------------------------------*




FORM alv_on_f4 USING p_fieldname

                     p_row_no

                     p_event_data TYPE REF TO cl_alv_event_data

                     p_bad_cells

                     p_display.



  FIELD-SYMBOLS: <fs>   LIKE gs_product,

                 <itab> TYPE lvc_t_modi.



  "=========================================================

  " F4 ### ## ## (No input help is available ##)

  "=========================================================

  IF p_event_data IS BOUND.

    p_event_data->m_event_handled = 'X'.

  ENDIF.



  " ## # ##

  READ TABLE gt_product ASSIGNING <fs> INDEX p_row_no.

  IF sy-subrc <> 0 OR <fs> IS NOT ASSIGNED.

    RETURN.

  ENDIF.



  CASE p_fieldname.



    WHEN 'ZMATNR'.



      "=========================================================

      " F4 ### ### ## ##

      "=========================================================

      TYPES: BEGIN OF ty_f4,

               zmatnr   TYPE zedt07_200-zmatnr, "####

               zmatname TYPE zedt07_200-zmatname, "###

               stprs TYPE zedt07_200-stprs, "##

               meins TYPE zedt07_200-meins, "##

               zwerks   TYPE zedt07_200-zwerks, "###

               zlgort   TYPE zedt07_200-zlgort, "####

             END OF ty_f4.



      DATA: lt_f4 TYPE TABLE OF ty_f4.



      "=========================================================

      " DB## ### ##

      "=========================================================

      SELECT zmatnr zmatname stprs meins zwerks zlgort

        FROM zedt07_200

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

      gc_grid->refresh_table_display( ).



  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  VERIFY_BEDAT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM VERIFY_BEDAT .

  IF p_bedat IS INITIAL.

    MESSAGE '#### ######!' TYPE 'I'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  VERIFY_PRDAT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM VERIFY_PRDAT .

  LOOP AT gt_product INTO gs_product.



    "### ### #

    IF gs_product-prdat IS INITIAL.

      MESSAGE '#### ######.' TYPE 'E'.

    ENDIF.



    "### < ### -> ##

    IF gs_product-prdat < p_bedat.

      MESSAGE '#### ##### ### #### ###.' TYPE 'E'.

    ENDIF.



  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  VERIFY_EBELN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM VERIFY_EBELN .

  "#### ## ####, ###### ### ## PO### ### ####.

  "### ### ## ## #### ####.



  DATA lv_cnt TYPE i.



  "#### + ### ### ## ##### ##

  SELECT COUNT(*)

    INTO lv_cnt

    FROM zpro07_004

    WHERE bukrs = p_bukrs

      AND lifnr = p_lifnr

      AND ebeln = p_ebeln.





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .

  SELECT *

    INTO TABLE gt_005

    FROM zpro07_005

    WHERE ebeln = p_ebeln.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELDCAT_CHECK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELDCAT_CHECK .

  CLEAR : gs_fieldcat, gt_fieldcat.

 gs_fieldcat-col_pos = 1.

 gs_fieldcat-coltext = '######'.

 gs_fieldcat-fieldname = 'EBELN'.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 2.

 gs_fieldcat-coltext = '##'.

 gs_fieldcat-fieldname = 'EBELP'.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 3.

 gs_fieldcat-coltext = '####'.

 gs_fieldcat-fieldname = 'MATNR'.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 4.

 gs_fieldcat-coltext = '###'.

 gs_fieldcat-fieldname = 'MAKTX'.

 gs_fieldcat-edit = 'X'.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 5.

 gs_fieldcat-coltext = '##'.

 gs_fieldcat-fieldname = 'MENGE'.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 6.

 gs_fieldcat-coltext = '##'.

 gs_fieldcat-fieldname = 'MEINS'.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 7.

 gs_fieldcat-coltext = '##'.

 gs_fieldcat-fieldname = 'BPRME'.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 8.

 gs_fieldcat-coltext = '###'.

 gs_fieldcat-fieldname = 'PRDAT'.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 9.

 gs_fieldcat-coltext = '###'.

 gs_fieldcat-fieldname = 'WERKS'.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 10.

 gs_fieldcat-coltext = '####'.

 gs_fieldcat-fieldname = 'LGORT'.

 APPEND gs_fieldcat TO gt_fieldcat.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY_CHECK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY_CHECK .

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*      I_BUFFER_ACTIVE               =

*      I_BYPASSING_BUFFER            =

*      I_CONSISTENCY_CHECK           =

*      I_STRUCTURE_NAME              =




      IS_VARIANT                    = gs_variant

      I_SAVE                        = 'A'




*      I_DEFAULT                     = 'X'




      IS_LAYOUT                     = gs_layout




*      IS_PRINT                      =

*      IT_SPECIAL_GROUPS             =

*      IT_TOOLBAR_EXCLUDING          =

*      IT_HYPERLINK                  =

*      IT_ALV_GRAPHICS               =

*      IT_EXCEPT_QINFO               =

*      IR_SALV_ADAPTER               =




    CHANGING

      IT_OUTTAB                     = gt_005

      IT_FIELDCATALOG               = gt_fieldcat

      IT_SORT                       = gt_sort




*      IT_FILTER                     =

*    EXCEPTIONS

*      INVALID_PARAMETER_COMBINATION = 1

*      PROGRAM_ERROR                 = 2

*      TOO_MANY_LINES                = 3

*      others                        = 4




          .

ENDFORM.