
*&---------------------------------------------------------------------*

*&  Include           ZPRO07_003_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_DATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_DATE .

  p_stdat = sy-datum.

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

      WHEN 'M1'. "#####

        IF p_rad1 = 'X'.

          screen-active = 1.

        ELSE.

          screen-active = 0.

        ENDIF.

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




FORM GET_DATA .



  "GT_STORE ####

  SELECT a~ebeln a~lifnr a~bedat a~waers a~bukrs

         b~ebelp b~matnr b~maktx b~menge b~meins b~bprme b~prdat b~werks b~lgort

    INTO CORRESPONDING FIELDS OF TABLE gt_store

    FROM zpro07_004 AS a

    INNER JOIN zpro07_005 AS b

    ON a~ebeln = b~ebeln

    WHERE b~werks = p_werks

    AND a~ebeln = p_ebeln.



  DATA: lt_007 TYPE TABLE OF zpro07_007.



  LOOP AT gt_store ASSIGNING FIELD-SYMBOL(<ls_gt>).



    " zpro07_007## ## EBELN+EBELP# ## # ####

    SELECT *

      INTO TABLE lt_007

      FROM zpro07_007

      WHERE ebeln = <ls_gt>-ebeln

        AND zeile = <ls_gt>-ebelp.



    " # ### ## ##

    LOOP AT lt_007 INTO gs_007.

      <ls_gt>-menge = <ls_gt>-menge - gs_007-menge.

    ENDLOOP.



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

 gs_fieldcat-fieldname = 'CHECK'.

 gs_fieldcat-checkbox = 'X'.

 gs_fieldcat-edit = 'X'.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 2.

 gs_fieldcat-coltext = '####'.

 gs_fieldcat-fieldname = 'EBELN'.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 3.

 gs_fieldcat-coltext = '##'.

 gs_fieldcat-fieldname = 'EBELP'.

 gs_fieldcat-outputlen = 5.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 4.

 gs_fieldcat-coltext = '#####'.

 gs_fieldcat-fieldname = 'LIFNR'.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 5.

 gs_fieldcat-coltext = '###'.

 gs_fieldcat-fieldname = 'BEDAT'.

 gs_fieldcat-outputlen = 10.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 6.

 gs_fieldcat-coltext = '####'.

 gs_fieldcat-fieldname = 'MATNR'.

  gs_fieldcat-outputlen = 7.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 7.

 gs_fieldcat-coltext = '###'.

 gs_fieldcat-fieldname = 'MAKTX'.

  gs_fieldcat-outputlen = 7.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 8.

 gs_fieldcat-coltext = '##'.

 gs_fieldcat-fieldname = 'MENGE'.

 gs_fieldcat-decimals = 3.

 gs_fieldcat-edit = 'X'.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 9.

 gs_fieldcat-coltext = '##'.

 gs_fieldcat-fieldname = 'MEINS'.

  gs_fieldcat-outputlen = 5.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 10.

 gs_fieldcat-coltext = '##'.

 gs_fieldcat-fieldname = 'BPRME'.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 11.

 gs_fieldcat-coltext = '##'.

 gs_fieldcat-fieldname = 'WAERS'.

  gs_fieldcat-outputlen = 7.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 12.

 gs_fieldcat-coltext = '###'.

 gs_fieldcat-fieldname = 'PRDAT'.

  gs_fieldcat-outputlen = 10.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 13.

 gs_fieldcat-coltext = '###'.

 gs_fieldcat-fieldname = 'WERKS'.

  gs_fieldcat-outputlen = 7.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 14.

 gs_fieldcat-coltext = '####'.

 gs_fieldcat-fieldname = 'LGORT'.

  gs_fieldcat-outputlen = 7.

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

      IT_OUTTAB                     = gt_store

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

*&      Form  VERIFY_EBELN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM VERIFY_EBELN .

  "#### ## ###, ##### ### ## PO### ### ####.

  "### ### ## ## #### ####.



  DATA lv_cnt TYPE i.



  IF p_stdat IS INITIAL.

    EXIT.

  ENDIF.



  "#### + ### ### ## ##### ##

  SELECT COUNT(*)

    INTO lv_cnt

    FROM zpro07_005

    WHERE ebeln = p_ebeln

    AND   werks = p_werks

    .





  IF lv_cnt = 0.

    MESSAGE '## ##### ### ### #### ####.' TYPE 'E'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_SEARCH_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_SEARCH_DATA .

  SELECT * FROM zpro07_007 INTO CORRESPONDING FIELDS OF TABLE gt_field_007

     WHERE ebeln = p_ebeln

     AND werks = p_werks.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_STORE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_STORE .

  IF gc_grid IS BOUND.

    CALL METHOD gc_grid->check_changed_data.

  ENDIF.



  "zpro07_006## #### ## ## ### ##

  DATA : lv_mblnr TYPE zpro07_006-mblnr.

  DATA : lv_temp TYPE c VALUE 1.



  LOOP AT gt_store INTO gs_store.

    "## ## ### ## ## ### ####.

    IF gs_store-check = 'X'.

      IF gs_store-menge = 0.

        MESSAGE '## ### ### ####' TYPE 'E'.

      ENDIF.



      IF lv_temp = 1. "## ### 1### (#####) ## ##

        PERFORM auto_calculate_mblnr CHANGING lv_mblnr.

        lv_temp = 2.

      ENDIF.

    ENDIF.

  ENDLOOP.



  "### ### ### ## ##, #### ##

  IF lv_temp = 2.

    "## ##

    gs_006-mblnr = lv_mblnr. "####

    gs_006-bldat = p_stdat. "###

    gs_006-budat = p_stdat. "###

    gs_006-mjahr = p_stdat(4). "####

    gs_006-blart = 'WE'. "####



    APPEND gs_006 TO gt_006.



    "### ##

    LOOP AT gt_store INTO gs_store.

    "## ## ### ## ## ### ####.



    CLEAR : gs_007.



    "#### ##

    DATA : lv_belnr TYPE c VALUE 0000000001.



    "## ## ##

    DATA : lv_menge TYPE menge_d.



    "## ####, ## ##

    DATA : lv_ebeln TYPE ebeln,

           lv_ebelp TYPE ebelp.



    IF gs_store-check = 'X'.

      "## ## # ##

      lv_ebeln = gs_store-ebeln.

      lv_ebelp = gs_store-ebelp.



      "## ## ### #### ### lv_mblnr# ####.

      gs_007-mblnr = lv_mblnr. "####

      gs_007-mjahr = p_stdat(4). "####

      gs_007-zeile = gs_store-ebelp. "##### (##### ##)

      gs_007-matnr = gs_store-matnr. "####

      gs_007-werks = gs_store-werks. "###

      gs_007-lgort = gs_store-lgort. "####

      gs_007-lifnr = gs_store-lifnr. "#####

      gs_007-waers = gs_store-waers. "##

      gs_007-menge = gs_store-menge. "##

      lv_menge = gs_007-menge.



      gs_007-meins = gs_store-meins. "##

      gs_007-ebeln = gs_store-ebeln. "######

      gs_007-bukrs = gs_store-bukrs. "####

      gs_007-gjahr = sy-datum(4). "####

      gs_007-belnr = lv_belnr. "####

      "##### +1#

      lv_belnr = lv_belnr + 1.

      gs_007-shkzg = 'S'. "###

      gs_007-dmbtr = gs_store-menge * gs_store-bprme. "##



      APPEND gs_007 TO gt_007.



      PERFORM modify_product USING lv_ebeln lv_ebelp lv_menge.



      CLEAR : gs_store.



    ENDIF.

    ENDLOOP.





    INSERT zpro07_006 FROM TABLE gt_006. "##

    INSERT zpro07_007 FROM TABLE gt_007.

  ELSE.

    MESSAGE '#### ### ####' TYPE 'I'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  AUTO_CALCULATE_MBLNR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      <--P_LV_MBLNR  text

*----------------------------------------------------------------------*




FORM AUTO_CALCULATE_MBLNR  CHANGING PV_MBLNR TYPE zpro07_006-mblnr.

  DATA : lv_max TYPE zpro07_006-mblnr.



  SELECT MAX( mblnr ) INTO lv_max FROM zpro07_006.



  IF lv_max IS INITIAL.

    pv_mblnr = '5000000000'.

  ELSE.

    pv_mblnr = lv_max + 1.

    pv_mblnr = |{ pv_mblnr ALPHA = IN }|.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_PRODUCT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_PRODUCT USING p_ebeln p_ebelp p_menge.

  "## ### # ## #### #####.

  "## ### ##### #### ebeln, ebelp #### menge## ####.



  SELECT SINGLE *

    INTO gs_005

    FROM zpro07_005

    WHERE ebeln = p_ebeln

      AND ebelp = p_ebelp.



  LOOP AT gt_store INTO gs_store.

    IF gs_store-ebeln = p_ebeln AND gs_store-ebelp = p_ebelp.



      "## ## ##

      gs_store-menge = gs_005-menge - p_menge.



      IF gs_store-menge < 0.

        MESSAGE '### ###### # #######' TYPE 'E'.

      ELSE.

        MODIFY gt_store FROM gs_store INDEX sy-tabix.

        MESSAGE '##### #######!' TYPE 'S'.

      ENDIF.



    ENDIF.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELDCAT_SEARCH

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELDCAT_SEARCH .

 CLEAR : gs_fieldcat, gt_fieldcat.

 gs_fieldcat-col_pos = 1.

 gs_fieldcat-coltext = '##'.

 gs_fieldcat-fieldname = 'CHECK'.

 gs_fieldcat-edit = 'X'.

 gs_fieldcat-checkbox = 'X'.

 gs_fieldcat-outputlen = 5.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 2.

 gs_fieldcat-coltext = '####'.

 gs_fieldcat-fieldname = 'MBLNR'.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 3.

 gs_fieldcat-coltext = '####'.

 gs_fieldcat-fieldname = 'MJAHR'.

 gs_fieldcat-outputlen = 6.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 4.

 gs_fieldcat-coltext = '#####'.

 gs_fieldcat-fieldname = 'ZEILE'.

 gs_fieldcat-outputlen = 8.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 5.

 gs_fieldcat-coltext = '####'.

 gs_fieldcat-fieldname = 'MATNR'.

 gs_fieldcat-outputlen = 6.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 6.

 gs_fieldcat-coltext = '###'.

 gs_fieldcat-fieldname = 'WERKS'.

  gs_fieldcat-outputlen = 6.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 7.

 gs_fieldcat-coltext = '####'.

 gs_fieldcat-fieldname = 'LGORT'.

 gs_fieldcat-outputlen = 7.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 8.

 gs_fieldcat-coltext = '#####'.

 gs_fieldcat-fieldname = 'LIFNR'.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 9.

 gs_fieldcat-coltext = '###'.

 gs_fieldcat-fieldname = 'WAERS'.

 gs_fieldcat-outputlen = 6.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 10.

 gs_fieldcat-coltext = '##'.

 gs_fieldcat-fieldname = 'MENGE'.

  gs_fieldcat-outputlen = 7.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 11.

 gs_fieldcat-coltext = '##'.

 gs_fieldcat-fieldname = 'MEINS'.

  gs_fieldcat-outputlen = 5.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 12.

 gs_fieldcat-coltext = '######'.

 gs_fieldcat-fieldname = 'EBELN'.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 13.

 gs_fieldcat-coltext = '####'.

 gs_fieldcat-fieldname = 'BUKRS'.

  gs_fieldcat-outputlen = 7.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 14.

 gs_fieldcat-coltext = '####'.

 gs_fieldcat-fieldname = 'GJAHR'.

  gs_fieldcat-outputlen = 7.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 15.

 gs_fieldcat-coltext = '####'.

 gs_fieldcat-fieldname = 'BELNR'.

  gs_fieldcat-outputlen = 6.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 16.

 gs_fieldcat-coltext = '###'.

 gs_fieldcat-fieldname = 'SHKZG'.

  gs_fieldcat-outputlen = 6.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 17.

 gs_fieldcat-coltext = '##'.

 gs_fieldcat-fieldname = 'DMBTR'.

 APPEND gs_fieldcat TO gt_fieldcat.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY_SEARCH

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY_SEARCH .

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

      IT_OUTTAB                     = gt_field_007

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

*&      Form  CANCEL_STORE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM cancel_store .



  IF gc_grid IS BOUND.

    CALL METHOD gc_grid->check_changed_data.

  ENDIF.



  DATA: lt_delete TYPE TABLE OF zpro07_007,

        ls_delete TYPE zpro07_007.



  FIELD-SYMBOLS: <ls_row> LIKE gs_field_007.



  "### ## ##

  LOOP AT gt_field_007 ASSIGNING <ls_row> WHERE check = 'X'.

    CLEAR ls_delete.

    ls_delete-mblnr = <ls_row>-mblnr.

    ls_delete-mjahr = <ls_row>-mjahr.

    ls_delete-zeile = <ls_row>-zeile.

    APPEND ls_delete TO lt_delete.

  ENDLOOP.



  IF lt_delete IS INITIAL.

    MESSAGE '### ## ####.' TYPE 'I'.

    RETURN.

  ENDIF.



  "===== ### ## =====

  LOOP AT lt_delete INTO ls_delete.

    DELETE FROM zpro07_007

      WHERE mblnr = @ls_delete-mblnr

        AND mjahr = @ls_delete-mjahr

        AND zeile = @ls_delete-zeile.

  ENDLOOP.



  "===== ## ## =====

  DATA lv_cnt TYPE i.



  LOOP AT lt_delete INTO ls_delete.



    SELECT COUNT(*) INTO @lv_cnt

      FROM zpro07_007

      WHERE mblnr = @ls_delete-mblnr

        AND mjahr = @ls_delete-mjahr.



    IF lv_cnt = 0.

      DELETE FROM zpro07_006

        WHERE mblnr = @ls_delete-mblnr

          AND mjahr = @ls_delete-mjahr.

    ENDIF.



  ENDLOOP.



  COMMIT WORK.



  "===== ALV ### ## ## =====

  PERFORM get_search_data.

  PERFORM refresh.



  MESSAGE '## ## #####' TYPE 'S'.



  "### ## ### ## #### ####

  "## #### ### zpro07_007## ###

  "### #### zpro07_007## #### ####### ###

  "##### ###

  "### ### # ### ## ## ### ### #

ENDFORM.