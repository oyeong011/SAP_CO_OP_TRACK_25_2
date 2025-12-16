
*&---------------------------------------------------------------------*

*&  Include           ZPRO07_004_F01

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

  p_indat = sy-datum.

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



  IF p_indat IS INITIAL.

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

"GT_INVOICE #### A# #### ## B# ### C# #### ##

  SELECT * INTO TABLE gt_009

  FROM zpro07_009.



  SELECT * INTO TABLE gt_007

  FROM zpro07_007.



  DATA : lv_buzei TYPE c LENGTH 6 VALUE '10'.

  DATA : lv_flag TYPE c VALUE 'X'.



  LOOP AT gt_007 INTO gs_007

     WHERE ebeln = p_ebeln

     AND werks = p_werks.



  CLEAR gs_invoice.



  gs_invoice-lifnr = gs_007-lifnr. "###

  gs_invoice-ebeln = gs_007-ebeln. "######

  gs_invoice-ebelp = gs_007-zeile. "######

  gs_invoice-matnr = gs_007-matnr. "####

  gs_invoice-menge = gs_007-menge. "##

  gs_invoice-meins = gs_007-meins. "##



  "####, ##

  SELECT SINGLE mwskz waers

    INTO ( gs_invoice-mwskz, gs_invoice-waers )

    FROM zpro07_003

    WHERE lifnr = gs_007-lifnr.



  "####

  gs_invoice-dmbtr = gs_007-dmbtr.



  "####

  gs_invoice-bukrs = gs_007-bukrs.



  "####

  gs_invoice-buzei = lv_buzei.

  lv_buzei = lv_buzei + 10.



  "### ##

  CASE gs_invoice-mwskz.

    WHEN 'V1'.

      gs_invoice-mwsts = gs_invoice-dmbtr * '0.1'.

    WHEN 'V5'.

      gs_invoice-mwsts = gs_invoice-dmbtr * '0.1'.

    WHEN OTHERS.

      gs_invoice-mwsts = 0.

  ENDCASE.



  "##

  gs_invoice-costs = gs_invoice-dmbtr + gs_invoice-mwsts.



  "###

  READ TABLE gt_009 INTO gs_009

  WITH KEY ebeln = gs_invoice-ebeln

           ebelp = gs_invoice-ebelp

           buzei = gs_invoice-buzei.





  IF sy-subrc = 0.

    gs_invoice-sgtxt = |{ gs_invoice-ebeln } O|.

  ELSE.

    gs_invoice-sgtxt = |{ gs_invoice-ebeln } X|.

  ENDIF.



  APPEND gs_invoice TO gt_invoice.



ENDLOOP.



ENDFORM.




*FORM get_data .

*

*  DATA: lv_cnt TYPE i.

*

*  "## ###

*  SELECT * INTO TABLE gt_009

*    FROM zpro07_009.

*

*  "## ###

*  SELECT * INTO TABLE gt_007

*    FROM zpro07_007.

*

*  LOOP AT gt_007 INTO gs_007

*       WHERE ebeln = p_ebeln

*         AND werks = p_werks.

*

*    CLEAR gs_invoice.

*

*    gs_invoice-lifnr = gs_007-lifnr.

*    gs_invoice-ebeln = gs_007-ebeln.

*    gs_invoice-ebelp = gs_007-zeile.

*    gs_invoice-matnr = gs_007-matnr.

*    gs_invoice-menge = gs_007-menge.

*    gs_invoice-meins = gs_007-meins.

*    gs_invoice-dmbtr = gs_007-dmbtr.

*    gs_invoice-bukrs = gs_007-bukrs.

*

*    "#### / ##

*    SELECT SINGLE mwskz waers

*      INTO ( gs_invoice-mwskz, gs_invoice-waers )

*      FROM zpro07_003

*      WHERE lifnr = gs_007-lifnr.

*

*    "###

*    CASE gs_invoice-mwskz.

*      WHEN 'V1' OR 'V5'.

*        gs_invoice-mwsts = gs_invoice-dmbtr * '0.1'.

*      WHEN OTHERS.

*        gs_invoice-mwsts = 0.

*    ENDCASE.

*

*    gs_invoice-costs = gs_invoice-dmbtr + gs_invoice-mwsts.

*

*    "---------------------------------------

*    " ## ## ## ## (## ##)

*    "---------------------------------------

*    SELECT COUNT(*)

*      INTO lv_cnt

*      FROM zpro07_009

*      WHERE ebeln = gs_invoice-ebeln

*        AND ebelp = gs_invoice-ebelp.

*

*    IF lv_cnt > 0.

*      gs_invoice-sgtxt = |{ gs_invoice-ebeln } O|.

*    ELSE.

*      gs_invoice-sgtxt = |{ gs_invoice-ebeln } X|.

*    ENDIF.

*

*    APPEND gs_invoice TO gt_invoice.

*

*  ENDLOOP.

*

*ENDFORM.

*&---------------------------------------------------------------------*

*&      Form  GET_SEARCH_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_SEARCH_DATA .

  SELECT * FROM zpro07_009 INTO CORRESPONDING FIELDS OF TABLE gt_field_009

     WHERE ebeln = p_ebeln

     AND werks = p_werks.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_INVOICE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_INVOICE .

  CLEAR : gt_009. "get_data## ## gt_009# ### ###.



  IF gc_grid IS BOUND.

    CALL METHOD gc_grid->check_changed_data.

  ENDIF.



  "zpro07_008## ## ## ## ### ##

  DATA : lv_belnr TYPE zpro07_008-belnr.

  DATA : lv_temp TYPE c VALUE 1.



  LOOP AT gt_invoice INTO gs_invoice.

    "## ## ### ## ## ### ####.



    DATA : lv_flag TYPE c LENGTH 1.

    lv_flag = gs_invoice-sgtxt+11(1).



    IF gs_invoice-check = 'X'.

      IF lv_flag = 'X'.

        IF lv_temp = 1. "## ### 1### (#####) ## ##

          PERFORM auto_calculate_belnr CHANGING lv_belnr.

          lv_temp = 2.

        ENDIF.

      ELSE.

        MESSAGE '## ## ## # #####.' TYPE 'E'.

      ENDIF.

    ENDIF.



  ENDLOOP.



  "## ### ## ##, #### ##

  IF lv_temp = 2.

    "##

    gs_008-belnr = lv_belnr. "######

    gs_008-bldat = p_indat. "###

    gs_008-budat = p_indat. "###

    gs_008-gjahr = p_indat(4). "####

    gs_008-blart = 'RE'. "####



    APPEND gs_008 TO gt_008.



    DATA : lv_max TYPE c LENGTH 6 VALUE '10'.

    "###

    LOOP AT gt_invoice INTO gs_invoice.

      "## ## ### ## ## ### ##.



      CLEAR : gs_009.



      IF gs_invoice-check = 'X'.

        "##(##) ### ### ### ##

        gs_009-belnr = lv_belnr. "####

        gs_009-gjahr = p_indat(4). "####



        gs_009-buzei = lv_max. "## ## ##

        lv_max = lv_max + 10.

        gs_009-ebeln = gs_invoice-ebeln. "######

        gs_009-ebelp = gs_invoice-ebelp. "#### ####

        gs_009-matnr = gs_invoice-matnr. "####

        gs_009-bukrs = gs_invoice-bukrs. "####

        gs_009-menge = gs_invoice-menge. "##

        gs_009-werks = p_werks. "###

        gs_009-wrbtr = gs_invoice-costs. "## = ## + ###

        gs_009-shkzg = 'S'. "###

        gs_009-mwskz = gs_invoice-mwskz. "####

        gs_009-bstme = gs_invoice-meins. "#### ##

        "bprme ##### ## #### ## ## ### ##..

        gs_009-meins = gs_invoice-meins. "##### ## ## #.



        APPEND gs_009 TO gt_009.



        CLEAR : gs_invoice.

      ENDIF.

    ENDLOOP.



    INSERT zpro07_008 FROM TABLE gt_008. "##

    INSERT zpro07_009 FROM TABLE gt_009.



    MESSAGE '##### #######!' TYPE 'S'.

  ELSE.

    MESSAGE '#### ### ####' TYPE 'I'.

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

  gs_fieldcat-outputlen = 5.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 2.

  gs_fieldcat-coltext = '####'.

  gs_fieldcat-fieldname = 'BUKRS'.

  gs_fieldcat-outputlen = 7.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 3.

  gs_fieldcat-coltext = '####'.

  gs_fieldcat-fieldname = 'DMBTR'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 4.

  gs_fieldcat-coltext = '##'.

  gs_fieldcat-fieldname = 'MWSTS'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 5.

  gs_fieldcat-coltext = '##'.

  gs_fieldcat-fieldname = 'COSTS'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 6.

  gs_fieldcat-coltext = '##'.

  gs_fieldcat-fieldname = 'WAERS'.

  gs_fieldcat-outputlen = 5.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 7.

  gs_fieldcat-coltext = '####'.

  gs_fieldcat-fieldname = 'MWSKZ'.

  gs_fieldcat-outputlen = 7.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 8.

  gs_fieldcat-coltext = '###'.

  gs_fieldcat-fieldname = 'SGTXT'.

  gs_fieldcat-outputlen = 13.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 9.

  gs_fieldcat-coltext = '###'.

  gs_fieldcat-fieldname = 'LIFNR'.

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

      IT_OUTTAB                     = gt_invoice

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

*&      Form  AUTO_CALCULATE_BELNR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      <--P_LV_BELNR  text

*----------------------------------------------------------------------*




FORM AUTO_CALCULATE_BELNR  CHANGING PV_BELNR TYPE zpro07_008-belnr.

  DATA : lv_max TYPE zpro07_008-belnr.



  SELECT MAX( belnr ) INTO lv_max FROM zpro07_008.



  IF lv_max IS INITIAL.

    pv_belnr = '5000000000'.

  ELSE.

    pv_belnr = lv_max + 1.

    pv_belnr = |{ pv_belnr ALPHA = IN }|.

  ENDIF.

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

 gs_fieldcat-fieldname = 'BELNR'.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 3.

 gs_fieldcat-coltext = '####'.

 gs_fieldcat-fieldname = 'GJAHR'.

 gs_fieldcat-outputlen = 6.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 4.

 gs_fieldcat-coltext = '######'.

 gs_fieldcat-fieldname = 'BUZEI'.

 gs_fieldcat-outputlen = 10.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 5.

 gs_fieldcat-coltext = '######'.

 gs_fieldcat-fieldname = 'EBELN'.

 gs_fieldcat-outputlen = 12.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 6.

 gs_fieldcat-coltext = '########'.

 gs_fieldcat-fieldname = 'EBELP'.

 gs_fieldcat-outputlen = 12.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 7.

 gs_fieldcat-coltext = '####'.

 gs_fieldcat-fieldname = 'MATNR'.

 gs_fieldcat-outputlen = 7.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 8.

 gs_fieldcat-coltext = '####'.

 gs_fieldcat-fieldname = 'BUKRS'.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 9.

 gs_fieldcat-coltext = '###'.

 gs_fieldcat-fieldname = 'WERKS'.

 gs_fieldcat-outputlen = 6.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 10.

 gs_fieldcat-coltext = '##'.

 gs_fieldcat-fieldname = 'WRBTR'.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 11.

 gs_fieldcat-coltext = '###'.

 gs_fieldcat-fieldname = 'SHKZG'.

 gs_fieldcat-outputlen = 6.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 12.

 gs_fieldcat-coltext = '####'.

 gs_fieldcat-fieldname = 'MWSKZ'.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 13.

 gs_fieldcat-coltext = '##'.

 gs_fieldcat-fieldname = 'MENGE'.

  gs_fieldcat-outputlen = 7.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 15.

 gs_fieldcat-coltext = '##'.

 gs_fieldcat-fieldname = 'BSTME'.

  gs_fieldcat-outputlen = 6.

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

      IT_OUTTAB                     = gt_field_009

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

*&      Form  CANCEL_INVOICE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CANCEL_INVOICE .

  IF gc_grid IS BOUND.

    CALL METHOD gc_grid->check_changed_data.

  ENDIF.



  DATA: lt_delete TYPE TABLE OF zpro07_009,

        ls_delete TYPE zpro07_009.



  FIELD-SYMBOLS: <ls_row> LIKE gs_field_009.



  "### ## ##

  LOOP AT gt_field_009 ASSIGNING <ls_row> WHERE check = 'X'.

    CLEAR ls_delete.

    ls_delete-belnr = <ls_row>-belnr.

    ls_delete-gjahr = <ls_row>-gjahr.

    ls_delete-buzei = <ls_row>-buzei.

    APPEND ls_delete TO lt_delete.

  ENDLOOP.



  IF lt_delete IS INITIAL.

    MESSAGE '### ## ####.' TYPE 'I'.

    RETURN.

  ENDIF.



  "===== ### ## =====

  LOOP AT lt_delete INTO ls_delete.

    DELETE FROM zpro07_009

      WHERE belnr = @ls_delete-belnr

        AND gjahr = @ls_delete-gjahr

        AND buzei = @ls_delete-buzei.

  ENDLOOP.



  "===== ## ## =====

  DATA lv_cnt TYPE i.



  LOOP AT lt_delete INTO ls_delete.



    SELECT COUNT(*) INTO @lv_cnt

      FROM zpro07_009

      WHERE belnr = @ls_delete-belnr

        AND gjahr = @ls_delete-gjahr.



    IF lv_cnt = 0.

      DELETE FROM zpro07_008

        WHERE belnr = @ls_delete-belnr

          AND gjahr = @ls_delete-gjahr.

    ENDIF.



  ENDLOOP.



  COMMIT WORK.



  "===== ALV ### ## ## =====

  PERFORM get_search_data.

  PERFORM refresh.



  MESSAGE '## ## #####' TYPE 'S'.

ENDFORM.