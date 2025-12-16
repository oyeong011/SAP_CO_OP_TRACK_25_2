
"============================================================

" #### ### ##

"============================================================

FORM GET_DATA .

  SELECT *

    INTO TABLE GT_EKPOC

    FROM ZEKPO21

    WHERE EBELN = P_EBELN.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODI_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




"============================================================

" ### ## ## (## ###  ###)

"============================================================

FORM MODI_DATA .



ENDFORM.

"============================================================

" Docking Container + ALV Grid ## ##

"============================================================

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

*&      Form  SET_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




"============================================================

" Selection Screen ## ## ##

"============================================================

FORM SET_SCREEN .

LOOP AT SCREEN.

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

"============================================================

" ### ALV ## (## #### ###)

"============================================================




*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY_SEARCH.

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*      I_BUFFER_ACTIVE               =

*      I_BYPASSING_BUFFER            =

*      I_CONSISTENCY_CHECK           =

*      I_STRUCTURE_NAME              =




      IS_VARIANT                    = GS_VARIANT

      I_SAVE                        = 'A'




*      I_DEFAULT                     = 'X'




      IS_LAYOUT                     = GS_LAYOUT




*      IS_PRINT                      =

*      IT_SPECIAL_GROUPS             =

*      IT_TOOLBAR_EXCLUDING          =

*      IT_HYPERLINK                  =

*      IT_ALV_GRAPHICS               =

*      IT_EXCEPT_QINFO               =

*      IR_SALV_ADAPTER               =




    CHANGING

      IT_OUTTAB                     = GT_EKPOC

      IT_FIELDCATALOG               = GT_FIELDCAT

      IT_SORT                       = GT_SORT




*      IT_FILTER                     =

*    EXCEPTIONS

*      INVALID_PARAMETER_COMBINATION = 1

*      PROGRAM_ERROR                 = 2

*      TOO_MANY_LINES                = 3

*      others                        = 4




          .

ENDFORM.

"============================================================

" ALV Variant ##

"============================================================




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*






FORM ALV_LAYOUT .

  CLEAR : GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

ENDFORM.



"============================================================

" ## ALV Field Catalog ##

"============================================================




*&---------------------------------------------------------------------*

*&      Form  FIELDCAT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELDCAT_SEARCH.

 CLEAR : GS_FIELDCAT, GT_FIELDCAT.

 GS_FIELDCAT-COL_POS = 1.

 GS_FIELDCAT-COLTEXT = '######'.

 GS_FIELDCAT-FIELDNAME = 'EBELN'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 2.

 GS_FIELDCAT-COLTEXT = '##'.

 GS_FIELDCAT-FIELDNAME = 'EBELP'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 3.

 GS_FIELDCAT-COLTEXT = '####'.

 GS_FIELDCAT-FIELDNAME = 'MATNR'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 4.

 GS_FIELDCAT-COLTEXT = '###'.

 GS_FIELDCAT-FIELDNAME = 'MAKTX'.

 GS_FIELDCAT-EDIT = 'X'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 5.

 GS_FIELDCAT-COLTEXT = '##'.

 GS_FIELDCAT-FIELDNAME = 'MENGE'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 6.

 GS_FIELDCAT-COLTEXT = '##'.

 GS_FIELDCAT-FIELDNAME = 'MEINS'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 7.

 GS_FIELDCAT-COLTEXT = '##'.

 GS_FIELDCAT-FIELDNAME = 'BPRME'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 8.

 GS_FIELDCAT-COLTEXT = '###'.

 GS_FIELDCAT-FIELDNAME = 'PRDAT'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 9.

 GS_FIELDCAT-COLTEXT = '###'.

 GS_FIELDCAT-FIELDNAME = 'WERKS'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 10.

 GS_FIELDCAT-COLTEXT = '####'.

 GS_FIELDCAT-FIELDNAME = 'LGORT'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.

"============================================================

" ALV ## Refresh (##/### ##)

"============================================================




*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM REFRESH .

  DATA : LS_STABLE TYPE LVC_S_STBL.



  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE      = LS_STABLE




*      I_SOFT_REFRESH =

*    EXCEPTIONS

*      FINISHED       = 1

*      OTHERS         = 2




          .

ENDFORM.

"============================================================

" #### ### ##

"============================================================




*&---------------------------------------------------------------------*

*&      Form  ADD_PRODUCT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ADD_PRODUCT .

  DATA(ls_keep) = gs_product-ebelp.  " ebelp ## ##

  CLEAR gs_product.                  " ## ###

  gs_product-ebelp = ls_keep.        " ebelp ##



  IF gs_product-ebelp IS INITIAL.

    gs_product-ebelp = 10.

  ELSE.

    gs_product-ebelp = gs_product-ebelp + 10.

  ENDIF.



  SELECT SINGLE waers mwskz FROM ZLFM1_21

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




"============================================================

" ### ### ##

"============================================================

FORM DELETE_PRODUCT .

  DATA lt_rows TYPE lvc_t_row.

  DATA ls_row TYPE lvc_s_row.

   "## # ####

  CALL METHOD gc_grid->get_selected_rows

    IMPORTING

      et_index_rows = lt_rows.



  IF lt_rows IS INITIAL.

    MESSAGE '### ## #####.' TYPE 'I'.

    RETURN.

  ENDIF.



  " SORTING

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




"============================================================

" #### ## (Header + Item)

"============================================================

FORM CREATE_PRODUCT .



  DATA : LV_EBELN TYPE ZEKKO21-EBELN.





  PERFORM CALCULATE_ORDER CHANGING LV_EBELN.





  "-------------------------

  " Header (ZEKKO)

  "-------------------------

  CLEAR GS_EKKOC.

  GS_EKKOC-EBELN = LV_EBELN.

  GS_EKKOC-BEDAT = P_BEDAT.



  SELECT SINGLE LIFNR EKGRP EKORG WAERS

    FROM ZLFM1_21

    INTO CORRESPONDING FIELDS OF GS_EKKOC

    WHERE LIFNR = P_LIFNR.



  SELECT SINGLE BUKRS

    FROM ZLFB1_21

    INTO CORRESPONDING FIELDS OF GS_EKKOC

    WHERE BUKRS = P_BUKRS.





  APPEND GS_EKKOC TO GT_EKKOC.

  "-------------------------

  " Item (ZEKPO)

  "-------------------------

  LOOP AT GT_PRODUCT INTO GS_PRODUCT.



    CLEAR GS_EKPOC.

    CLEAR GS_EKKOC.





    GS_EKPOC-EBELN = LV_EBELN.



    GS_EKPOC-EBELP = GS_PRODUCT-EBELP.

    GS_EKPOC-MATNR = GS_PRODUCT-ZMATNR.

    GS_EKPOC-MAKTX = GS_PRODUCT-ZMAKTX.

    GS_EKPOC-MENGE = GS_PRODUCT-MENGE.

    GS_EKPOC-BPRME = GS_PRODUCT-STPRS.

    GS_EKPOC-MEINS = GS_PRODUCT-MEINS.

    GS_EKPOC-PRDAT = GS_PRODUCT-PRDAT.

    GS_EKPOC-WERKS = GS_PRODUCT-ZWERKS.

    GS_EKPOC-LGORT = GS_PRODUCT-ZLGORT.





    GS_EKKOC-WAERS = GS_EKKOC-WAERS.



    APPEND GS_EKPOC TO GT_EKPOC.



  ENDLOOP.





   "DB# ## ##

  INSERT ZEKKO21 FROM TABLE GT_EKKOC.

  INSERT ZEKPO21 FROM TABLE GT_EKPOC.



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

 " ALV F4 ### ###

  SET HANDLER go_event->on_f4 FOR gc_grid.





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

"============================================================

" #### ## ##

"============================================================




*&---------------------------------------------------------------------*

*&      Form  CALCULATE_ORDER

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CALCULATE_ORDER CHANGING PV_EBELN TYPE ZEKKO21-EBELN.



  DATA lv_max TYPE ZEKKO21-ebeln.



  SELECT MAX( ebeln ) INTO lv_max FROM ZEKKO21.



  IF lv_max IS INITIAL.

    pv_ebeln = '0000000001'.

  ELSE.

    pv_ebeln = lv_max + 1.

    pv_ebeln = |{ pv_ebeln ALPHA = IN }|.

  ENDIF.





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  VERIFY_INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM VERIFY_INPUT .



  DATA : LV_COUNT TYPE I.



  IF P_BEDAT IS INITIAL.

    EXIT.

  ENDIF.



  SELECT COUNT(*)

    INTO LV_COUNT

    FROM ZLFB1_21

    WHERE BUKRS = P_BUKRS

      AND LIFNR = P_LIFNR.



  IF LV_COUNT = 0.

    MESSAGE '### ## #### #### ####.' TYPE 'E'.

    EXIT.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  VERIFY_SEARCH

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*








"============================================================

" ### ## (###)

"============================================================

FORM VERIFY_SEARCH .



  DATA : LV_VERIFY TYPE i.





  SELECT COUNT(*)

    INTO LV_VERIFY

    FROM  ZEKKO21

    WHERE BUKRS = P_BUKRS

      AND LIFNR = P_LIFNR

      AND EBELN = P_EBELN.





  IF LV_VERIFY = 0.



  ENDIF.



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

CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

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

 gs_fieldcat-ref_table = 'ZEDT21_200'.

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

*&      Form  ALV_ON_F4

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_FIELDNAME  text

*      -->P_ES_ROW_NO_ROW_ID  text

*      -->P_ER_EVENT_DATA  text

*      -->P_ET_BAD_CELLS  text

*      -->P_E_DISPLAY  text

*----------------------------------------------------------------------*




FORM ALV_ON_F4  USING    P_E_FIELDNAME

                         P_ES_ROW_NO_ROW_ID

                         P_EVENT_DATA TYPE REF TO CL_ALV_EVENT_DATA

                         P_ET_BAD_CELLS

                         P_E_DISPLAY.

  FIELD-SYMBOLS: <fs>   LIKE gs_product,

                 <itab> TYPE lvc_t_modi.



  "=========================================================

  " F4 ### ## ## (No input help is available ##)

  "=========================================================

  IF p_event_data IS BOUND.

    p_event_data->m_event_handled = 'X'.

  ENDIF.



  " ## # ##

  READ TABLE gt_product ASSIGNING <fs> INDEX P_ES_ROW_NO_ROW_ID.

  IF sy-subrc <> 0 OR <fs> IS NOT ASSIGNED.

    RETURN.

  ENDIF.



  CASE P_E_FIELDNAME.



    WHEN 'ZMATNR'.



      "=========================================================

      " F4 ### ### ## ##

      "=========================================================

      TYPES: BEGIN OF ty_f4,

               zmatnr   TYPE zedt21_200-zmatnr, "####

               zmatname TYPE zedt21_200-zmatname, "###

               stprs TYPE zedt21_200-stprs, "##

               meins TYPE zedt21_200-meins, "##

               zwerks   TYPE zedt21_200-zwerks, "###

               zlgort   TYPE zedt21_200-zlgort, "####

             END OF ty_f4.



      DATA: lt_f4 TYPE TABLE OF ty_f4.



      "=========================================================

      " DB## ### ##

      "=========================================================

      SELECT zmatnr zmatname stprs meins zwerks zlgort

        FROM zedt21_200

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

                       row_id    = P_ES_ROW_NO_ROW_ID

                       fieldname = 'ZMATNR'

                       value     = ls_sel-zmatnr ).

        APPEND ls1 TO <itab>.



        " 2) ZMATNAME

        DATA(ls2) = VALUE lvc_s_modi(

                       row_id    = P_ES_ROW_NO_ROW_ID

                       fieldname = 'ZMAKTX'

                       value     = ls_sel-zmatname ).

        APPEND ls2 TO <itab>.



        " 3) STPRS

        DATA(ls3) = VALUE lvc_s_modi(

                       row_id    = P_ES_ROW_NO_ROW_ID

                       fieldname = 'STPRS'

                       value     = ls_sel-stprs ).

        APPEND ls3 TO <itab>.



        " 4) MEINS

        DATA(ls4) = VALUE lvc_s_modi(

                       row_id    = P_ES_ROW_NO_ROW_ID

                       fieldname = 'MEINS'

                       value     = ls_sel-meins ).

        APPEND ls4 TO <itab>.





        " 5) ZWERKS

        DATA(ls5) = VALUE lvc_s_modi(

                       row_id    = P_ES_ROW_NO_ROW_ID

                       fieldname = 'ZWERKS'

                       value     = ls_sel-zwerks ).

        APPEND ls5 TO <itab>.



        " 6) ZLGORT

        DATA(ls6) = VALUE lvc_s_modi(

                       row_id    = P_ES_ROW_NO_ROW_ID

                       fieldname = 'ZLGORT'

                       value     = ls_sel-zlgort ).

        APPEND ls6 TO <itab>.



      ENDIF.



      " ALV ## ##

      gc_grid->refresh_table_display( ).



  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  VERIFY_INPUTD

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM VERIFY_INPUTD .

  LOOP AT GT_PRODUCT INTO GS_PRODUCT.



    "### ## X

    IF GS_PRODUCT-PRDAT IS INITIAL.

      MESSAGE '#### ######.' TYPE 'E'.

    ENDIF.



    "#### ##### ## # #

    IF GS_PRODUCT-PRDAT < P_BEDAT.

      MESSAGE '#### ##### ### #### ###.' TYPE 'E'.

    ENDIF.



  ENDLOOP.

ENDFORM.