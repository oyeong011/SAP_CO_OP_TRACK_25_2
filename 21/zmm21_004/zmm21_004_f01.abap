
*&---------------------------------------------------------------------*

*&  Include           ZMM21_004_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*






"============================================================

" ## ## ## ## ## ### ##

"============================================================

FORM GET_DATA .



  "## ## ### ## ## (## ###)

  SELECT * INTO TABLE GT_RSEG

  FROM ZRSEG21.

  "## ## ## ##

  SELECT * INTO TABLE GT_MSEG

  FROM ZMSEG21.

  DATA : LV_BUZEI TYPE C LENGTH 6 VALUE '10'.



  "### PO + ### ## ## ## LOOP

  LOOP AT GT_MSEG INTO GS_MSEG

     WHERE ebeln = p_ebeln

     AND werks = p_werks.



  CLEAR gs_inv.

  "## ##

  gs_inv-lifnr = gs_mseg-lifnr. "###

  gs_inv-ebeln = gs_mseg-ebeln. "######

  gs_inv-ebelp = gs_mseg-zeile. "######

  gs_inv-matnr = gs_mseg-matnr. "####

  gs_inv-menge = gs_mseg-menge. "##

  gs_inv-meins = gs_mseg-meins. "##



  "#### / ## (#### ##)

  SELECT SINGLE mwskz waers

    INTO ( gs_inv-mwskz, gs_inv-waers )

    FROM ZLFM1_21

    WHERE lifnr = gs_mseg-lifnr.



  "####

  gs_inv-dmbtr = gs_mseg-dmbtr.



  "#### / ## ####

  gs_inv-bukrs = gs_mseg-bukrs.

  gs_inv-buzei = lv_buzei.

  lv_buzei = lv_buzei + 10.



  "### ##(## ## ##)

  CASE gs_inv-mwskz.

    WHEN 'V1'.

      gs_inv-mwsts = gs_inv-dmbtr * '0.1'.

    WHEN 'V5'.

      gs_inv-mwsts = gs_inv-dmbtr * '0.1'.

    WHEN OTHERS.

      gs_inv-mwsts = 0.

  ENDCASE.



  "# ##

  gs_inv-costs = gs_inv-dmbtr + gs_inv-mwsts.





  "## ## ## ### ## ###

  READ TABLE GT_RSEG INTO GS_RSEG

  WITH KEY ebeln = GS_INV-ebeln

           ebelp = GS_INV-ebelp

           buzei = GS_INV-buzei.



  IF sy-subrc = 0.

    gs_inv-sgtxt = |{ gs_inv-ebeln } '######'|.

  ELSE.

    gs_inv-sgtxt = |{ gs_inv-ebeln } '######'|.

  ENDIF.



  APPEND gs_inv TO gt_inv.



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






"============================================================

" ## ## ### ### ##

"============================================================

FORM SET_INIT .

  P_DATE = SY-DATUM.

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

" Selection Screen ## ## (## ## ##)

"============================================================

FORM SET_SCREEN .

LOOP AT SCREEN.

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

*&      Form  GET_SEARCH_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*








"============================================================

" ## ## ##

"============================================================

FORM GET_SEARCH_DATA .

  SELECT * FROM ZRSEG21 INTO CORRESPONDING FIELDS OF TABLE GT_CHECK

     WHERE ebeln = p_ebeln

     AND werks = p_werks.

ENDFORM.








*---------------------------------------------------------------------*



*&---------------------------------------------------------------------*

*&      Form  CHECK_EBELN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*








"============================================================

" #### + ### ### ##

"============================================================

FORM CHECK_EBELN .



    IF P_DATE IS INITIAL.

    EXIT.

  ENDIF.



  DATA LV_COUNT TYPE i.

  SELECT COUNT(*)

    INTO LV_COUNT

    FROM ZEKPO21

    WHERE ebeln = p_ebeln

    AND   werks = p_werks

    .



  IF LV_COUNT = 0.

    MESSAGE '#### #### ####.' TYPE 'E'.

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






"============================================================

" Docking Container + ALV Grid ##

"============================================================

FORM CREATE_OBJECT .

  CREATE OBJECT GC_DOCKING

  EXPORTING




*    PARENT                      =




    REPID                       = SY-REPID

    DYNNR                       = SY-DYNNR




*    SIDE                        = DOCK_AT_LEFT




    EXTENSION                   = 2000




*    STYLE                       =

*    LIFETIME                    = LIFETIME_DEFAULT

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

*    OTHERS                      = 6




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




"============================================================

" ## ## ALV Field Catalog

"============================================================

FORM FIELDCAT .

 CLEAR : gs_fieldcat, gt_fieldcat.

  gs_fieldcat-col_pos = 1.

  gs_fieldcat-coltext = '##'.

  gs_fieldcat-fieldname = 'ZCHECK'.

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



  "#### / ## / ## / ## / #### / ### / ###

  "# ## ## ## ###

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




"============================================================

" ALV Variant ##

"============================================================

FORM ALV_LAYOUT .

 CLEAR : gs_variant.

  gs_variant-report = sy-repid.

  gs_variant-username = sy-uname.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




"============================================================

" ## ## ALV ##

"============================================================

FORM ALV_DISPLAY .

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

      IT_OUTTAB                     = GT_INV

      IT_FIELDCATALOG               = GT_FIELDCAT

      IT_SORT                       = GT_SORT




*      IT_FILTER                     =

*    EXCEPTIONS

*      INVALID_PARAMETER_COMBINATION = 1

*      PROGRAM_ERROR                 = 2

*      TOO_MANY_LINES                = 3

*      OTHERS                        = 4




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




"============================================================

" ALV Refresh (###/## ##)

"============================================================

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




*&---------------------------------------------------------------------*

*&      Form  CALCULATE_TAX

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_INV  text

*----------------------------------------------------------------------*




FORM CALCULATE_TAX  USING    PS_INV LIKE GS_INV.



  CASE PS_INV-MWSTS.

    WHEN 'V1' OR 'V5' OR 'V4'.

      PS_INV-MWSTS = PS_INV-DMBTR * '0.1'.

    WHEN OTHERS.

      PS_INV-MWSTS = 0.

  ENDCASE.



  PS_INV-costs = PS_INV-DMBTR + PS_INV-MWSTS.

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

      IT_OUTTAB                     = gt_check

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

*&      Form  FIELDCAT_SEARCH

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELDCAT_SEARCH .

CLEAR : GS_FIELDCAT , GT_FIELDCAT.



  gs_fieldcat-col_pos = 1.

  gs_fieldcat-coltext = '##'.

  gs_fieldcat-fieldname = 'ZCHECK'.

  gs_fieldcat-checkbox = 'X'.

  gs_fieldcat-edit = 'X'.

  gs_fieldcat-outputlen = 5.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'BELNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'EBELN'.

  GS_FIELDCAT-SCRTEXT_M = '######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'GJAHR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.





  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'BUZEI'.

  GS_FIELDCAT-SCRTEXT_M = '######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'MWSKZ'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'SGTXT'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'EBELP'.

  GS_FIELDCAT-SCRTEXT_M = '########'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



    CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.





   CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'WERKS'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



   CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'sHKZG'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

   CLEAR : GS_FIELDCAT.



  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'MWSKZ'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



   CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



ENDFORM.






*---------------------------------------------------------------------*

*&      Form  CREATE_SONGJANG

*---------------------------------------------------------------------*






"============================================================

" ## ## ## (## ## ##)

"============================================================

FORM CREATE_SONGJANG .




*




  DATA: lv_belnr      TYPE zrbkp21-belnr,

        lv_temp       TYPE c VALUE '1',

        lv_buzei      TYPE zrseg21-buzei,

        lv_dup_found  TYPE abap_bool VALUE abap_false,

        lv_new_found  TYPE abap_bool VALUE abap_false,

        lv_cnt        TYPE i.



  CLEAR: gt_rbkp, gt_rseg.



  "ALV #### ##

  IF gc_grid IS BOUND.

    CALL METHOD gc_grid->check_changed_data.

  ENDIF.



  "==================================================

  " 2. ## ## ## ## ## ## + ##

  "    (DB ## ## ##)

  "==================================================

  LOOP AT gt_inv INTO gs_inv WHERE zcheck = 'X'.



    SELECT COUNT(*)

      INTO lv_cnt

      FROM zrseg21

      WHERE ebeln = gs_inv-ebeln

        AND ebelp = gs_inv-ebelp

        AND werks = p_werks.



    IF lv_cnt > 0.

      lv_dup_found = abap_true.   "## ##

      CONTINUE.

    ENDIF.



    " ## ## ##

    lv_new_found = abap_true.



    IF lv_temp = '1'.

      PERFORM auto_calculate_belnr CHANGING lv_belnr.

      lv_temp = '2'.

    ENDIF.



  ENDLOOP.



  " ## ### ### ## ##

  IF lv_new_found = abap_false.

    MESSAGE '### ### ## ## ## #######.' TYPE 'I'.

    RETURN.

  ENDIF.



  " ## ### #### #### ## ###

  IF lv_dup_found = abap_true.

    MESSAGE '## ## ### ### #### ## ### #####.'

      TYPE 'S'.

  ENDIF.



  "==================================================

  " 3. ## ## ## (ZRBKP21)

  "==================================================

  CLEAR gs_rbkp.

  gs_rbkp-belnr = lv_belnr.

  gs_rbkp-bldat = p_date.

  gs_rbkp-budat = p_date.

  gs_rbkp-gjahr = p_date(4).

  gs_rbkp-blart = 'RE'.



  APPEND gs_rbkp TO gt_rbkp.



  "==================================================

  " 4. ## ### ## (ZRSEG21)

  "==================================================

  lv_buzei = 10.



  LOOP AT gt_inv INTO gs_inv WHERE zcheck = 'X'.



    " DB ## ## ###

    SELECT COUNT(*)

      INTO lv_cnt

      FROM zrseg21

      WHERE ebeln = gs_inv-ebeln

        AND ebelp = gs_inv-ebelp

        AND werks = p_werks.



    IF lv_cnt > 0.

      CONTINUE.

    ENDIF.



    CLEAR gs_rseg.



    gs_rseg-belnr = lv_belnr.

    gs_rseg-gjahr = p_date(4).

    gs_rseg-buzei = lv_buzei.



    gs_rseg-ebeln = gs_inv-ebeln.

    gs_rseg-ebelp = gs_inv-ebelp.

    gs_rseg-matnr = gs_inv-matnr.

    gs_rseg-bukrs = gs_inv-bukrs.

    gs_rseg-werks = p_werks.



    gs_rseg-dmbtr = gs_inv-dmbtr.     "####

    gs_rseg-wmwst = gs_inv-mwsts.     "##

    gs_rseg-wrbtr = gs_inv-costs.     "##

    gs_rseg-menge = gs_inv-menge.     "##

    gs_rseg-mwskz = gs_inv-mwskz.     "####

    gs_rseg-bstme = gs_inv-meins.

    gs_rseg-meins = gs_inv-meins.

    gs_rseg-shkzg = 'S'.

    gs_rseg-sgtxt = |PO { gs_inv-ebeln }/{ gs_inv-ebelp } INVOICE|.



    APPEND gs_rseg TO gt_rseg.

    lv_buzei = lv_buzei + 10.



  ENDLOOP.



  "==================================================

  " 5. DB ##

  "==================================================

  INSERT zrbkp21 FROM TABLE gt_rbkp.

  IF sy-subrc <> 0.

    ROLLBACK WORK.

    MESSAGE '## ## ## ##' TYPE 'E'.

    RETURN.

  ENDIF.



  INSERT zrseg21 FROM TABLE gt_rseg.

  IF sy-subrc <> 0.

    ROLLBACK WORK.

    MESSAGE '## ### ## ##' TYPE 'E'.

    RETURN.

  ENDIF.



  COMMIT WORK.



  PERFORM refresh.

  MESSAGE '## ### #######.' TYPE 'S'.



ENDFORM.




*



*&---------------------------------------------------------------------*

*&      Form  AUTO_CALCULATE_BELNR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      <--P_LV_BELNR  text

*----------------------------------------------------------------------*




FORM AUTO_CALCULATE_BELNR  CHANGING P_BELNR TYPE zrbkp21-belnr.

  DATA : lv_max TYPE zrbkp21-belnr.



  SELECT MAX( belnr ) INTO lv_max FROM zrbkp21.



  IF lv_max IS INITIAL.

    p_belnr = '5000000000'.

  ELSE.

    p_belnr = lv_max + 1.

    p_belnr = |{ p_belnr ALPHA = IN }|.

  ENDIF.

ENDFORM.










*&---------------------------------------------------------------------*

*&      Form  CANCEL_INV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*

*  ### ## ## ## ## ##

*  - ## ###(ZRSEG21) ##

*  - ## ### #### # ## ###

*    # ## ##(ZRBKP21) ##




FORM CANCEL_INV .

  IF gc_grid IS BOUND.

    CALL METHOD gc_grid->check_changed_data.

  ENDIF.



  DATA: lt_delete TYPE TABLE OF zrseg21,

        ls_delete TYPE zrseg21.



  FIELD-SYMBOLS: <ls_row> LIKE gs_check.





  LOOP AT gt_check ASSIGNING <ls_row> WHERE zcheck = 'X'.

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





  LOOP AT lt_delete INTO ls_delete.

    DELETE FROM zrseg21

      WHERE belnr = @ls_delete-belnr

        AND gjahr = @ls_delete-gjahr

        AND buzei = @ls_delete-buzei.

  ENDLOOP.





  DATA lv_cnt TYPE i.



  LOOP AT lt_delete INTO ls_delete.



    SELECT COUNT(*) INTO @lv_cnt

      FROM zrseg21

      WHERE belnr = @ls_delete-belnr

        AND gjahr = @ls_delete-gjahr.



    IF lv_cnt = 0.

      DELETE FROM zrbkp21

        WHERE belnr = @ls_delete-belnr

          AND gjahr = @ls_delete-gjahr.

    ENDIF.



  ENDLOOP.



  COMMIT WORK.





  PERFORM get_search_data.

  PERFORM refresh.



  MESSAGE '## ## #####' TYPE 'S'.

ENDFORM.