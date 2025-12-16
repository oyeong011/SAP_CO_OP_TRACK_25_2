
*&---------------------------------------------------------------------*

*&  Include           ZMM21_003_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_DATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




"============================================================

" ## ### ## (## ##)

"============================================================

FORM SET_DATE .

  P_STDAT = SY-DATUM.

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

" Selection Screen ## ##

"============================================================

FORM SET_SCREEN .

  LOOP AT SCREEN.

    CASE SCREEN-GROUP1.

      "####

      WHEN 'M1'.

        IF P_RAD1 = 'X'.

          "###

          SCREEN-ACTIVE = 1.

          ELSE.

          "##### ## # ####

          SCREEN-ACTIVE = 0.

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




"============================================================

" #### ## ## ## ## ##

"============================================================

FORM GET_DATA .

  "#### Header + Item ##

  SELECT a~ebeln a~lifnr a~bedat a~waers a~bukrs

         b~ebelp b~matnr b~maktx b~menge b~meins b~bprme b~prdat b~werks b~lgort

    INTO CORRESPONDING FIELDS OF TABLE gt_store

    FROM ZEKKO21 AS a

    INNER JOIN ZEKPO21 AS b

    ON a~ebeln = b~ebeln

    WHERE b~werks = p_werks

    AND a~ebeln = p_ebeln.

  "## ### ## ###

  DATA: EXT_21 TYPE TABLE OF ZMSEG21.

 "#### #### ## ## ##

  LOOP AT gt_store ASSIGNING FIELD-SYMBOL(<FS_GT>).



    "## PO/### ## ## ## ##

    SELECT *

      INTO TABLE EXT_21

      FROM ZMSEG21

      WHERE ebeln = <FS_GT>-ebeln

        AND zeile = <FS_GT>-ebelp.



    "## ### #### ##

    LOOP AT EXT_21 INTO GS_MSEG.

      <FS_GT>-menge = <FS_GT>-menge - GS_MSEG-menge.

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




"============================================================

" Docking Container + ALV Grid ##

"============================================================

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



"============================================================

" ## ## ALV Field Catalog ##

"============================================================




*&---------------------------------------------------------------------*

*&      Form  FIELDCAT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELDCAT .

 CLEAR : GS_FIELDCAT, GT_FIELDCAT.

 GS_FIELDCAT-COL_POS = 1.

 GS_FIELDCAT-COLTEXT = '##'.

 GS_FIELDCAT-FIELDNAME = 'CHECK'.

 GS_FIELDCAT-CHECKBOX = 'X'.

 GS_FIELDCAT-EDIT = 'X'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 2.

 GS_FIELDCAT-COLTEXT = '####'.

 GS_FIELDCAT-FIELDNAME = 'EBELN'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 3.

 GS_FIELDCAT-COLTEXT = '##'.

 GS_FIELDCAT-FIELDNAME = 'EBELP'.

 GS_FIELDCAT-OUTPUTLEN = 5.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 4.

 GS_FIELDCAT-COLTEXT = '#####'.

 GS_FIELDCAT-FIELDNAME = 'LIFNR'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 5.

 GS_FIELDCAT-COLTEXT = '###'.

 GS_FIELDCAT-FIELDNAME = 'BEDAT'.

 GS_FIELDCAT-OUTPUTLEN = 10.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 6.

 GS_FIELDCAT-COLTEXT = '####'.

 GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-OUTPUTLEN = 7.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 7.

 GS_FIELDCAT-COLTEXT = '###'.

 GS_FIELDCAT-FIELDNAME = 'MAKTX'.

  GS_FIELDCAT-OUTPUTLEN = 7.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 8.

 GS_FIELDCAT-COLTEXT = '##'.

 GS_FIELDCAT-FIELDNAME = 'MENGE'.

 GS_FIELDCAT-DECIMALS = 3.

 GS_FIELDCAT-EDIT = 'X'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 9.

 GS_FIELDCAT-COLTEXT = '##'.

 GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-OUTPUTLEN = 5.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 10.

 GS_FIELDCAT-COLTEXT = '##'.

 GS_FIELDCAT-FIELDNAME = 'BPRME'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 11.

 GS_FIELDCAT-COLTEXT = '##'.

 GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-OUTPUTLEN = 7.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 12.

 GS_FIELDCAT-COLTEXT = '###'.

 GS_FIELDCAT-FIELDNAME = 'PRDAT'.

  GS_FIELDCAT-OUTPUTLEN = 10.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 13.

 GS_FIELDCAT-COLTEXT = '###'.

 GS_FIELDCAT-FIELDNAME = 'WERKS'.

  GS_FIELDCAT-OUTPUTLEN = 7.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 14.

 GS_FIELDCAT-COLTEXT = '####'.

 GS_FIELDCAT-FIELDNAME = 'LGORT'.

  GS_FIELDCAT-OUTPUTLEN = 7.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.

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

 CLEAR : GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

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

      IT_OUTTAB                     = GT_STORE

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

*&      Form  GET_DATA2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




"============================================================

" ## ## ##

"===========================================================

FORM GET_DATA2 .

  SELECT * FROM ZMSEG21 INTO CORRESPONDING FIELDS OF TABLE GT_CHECK

    WHERE EBELN = P_EBELN

    AND WERKS = P_WERKS.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  EBELN_CHECK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




"============================================================

" #### + ### ### ##

"============================================================

FORM EBELN_CHECK .



  DATA  LV_COUNT TYPE I.



   IF P_STDAT IS INITIAL.

    EXIT.

  ENDIF.

  SELECT COUNT(*)

    INTO LV_COUNT

    FROM ZEKPO21

    WHERE EBELN = P_EBELN

    AND   WERKS = P_WERKS.





  IF LV_COUNT = 0.

    MESSAGE 'NO DATA AVAILABLE.' TYPE 'E'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_IPGO

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




"============================================================

" ## ## ## (Header + Item)

"============================================================

FORM CREATE_IPGO .

IF GC_GRID IS BOUND.

    CALL METHOD GC_GRID->CHECK_CHANGED_DATA.

  ENDIF.





  DATA : LV_MBLNR TYPE ZMKPF21-MBLNR.

  DATA : LV_TEMP TYPE C VALUE 1.

  "## ### # ## ## ##

  LOOP AT GT_STORE INTO GS_STORE.

    IF GS_STORE-CHECK = 'X'.

      IF GS_STORE-MENGE = 0.

        MESSAGE '## ### ### ####' TYPE 'E'.

      ENDIF.

      "#### ## 1# ##

      IF LV_TEMP = 1.

        PERFORM AUTO_CALCULATE_DOCUMENT CHANGING LV_MBLNR.

      "## ### ## ### ##

        LV_TEMP = 2.

      ENDIF.

    ENDIF.

  ENDLOOP.





  IF LV_TEMP = 2.

    "==============================

    " Header (ZMKPF)

    "==============================

    GS_MKPF-MBLNR = LV_MBLNR. "####

    GS_MKPF-BLDAT = P_STDAT. "###

    GS_MKPF-BUDAT = P_STDAT. "###

    GS_MKPF-MJAHR = P_STDAT(4). "####

    GS_MKPF-BLART = 'WE'. "####



    APPEND GS_MKPF TO GT_MKPF.



    "==============================

    " Item (ZMSEG)

    "==============================

    LOOP AT GT_STORE INTO GS_STORE.

    "## ## ### ## ## ### ####.



    CLEAR : GS_MSEG.





    DATA : LV_BELNR TYPE c VALUE '0000000001'.





    DATA : LV_MENGE TYPE MENGE_D.





    DATA : LV_EBELN TYPE EBELN,

           LV_EBELP TYPE EBELP.



    IF GS_STORE-CHECK = 'X'.



      LV_EBELN = GS_STORE-EBELN.

      LV_EBELP = GS_STORE-EBELP.





      GS_MSEG-MBLNR = LV_MBLNR. "####

      GS_MSEG-MJAHR = P_STDAT(4). "####

      GS_MSEG-ZEILE = GS_STORE-EBELP. "##### (##### ##)

      GS_MSEG-MATNR = GS_STORE-MATNR. "####

      GS_MSEG-WERKS = GS_STORE-WERKS. "###

      GS_MSEG-LGORT = GS_STORE-LGORT. "####

      GS_MSEG-LIFNR = GS_STORE-LIFNR. "#####

      GS_MSEG-WAERS = GS_STORE-WAERS. "##

      GS_MSEG-MENGE = GS_STORE-MENGE. "##

      LV_MENGE = GS_MSEG-MENGE.



      GS_MSEG-MEINS = GS_STORE-MEINS. "##

      GS_MSEG-EBELN = GS_STORE-EBELN. "######

      GS_MSEG-BUKRS = GS_STORE-BUKRS. "####

      GS_MSEG-GJAHR = SY-DATUM(4). "####

      GS_MSEG-BELNR = LV_BELNR. "####



      LV_BELNR = LV_BELNR + 1.

      GS_MSEG-SHKZG = 'S'.







      GS_MSEG-DMBTR = GS_STORE-MENGE * GS_STORE-BPRME. "##



      APPEND GS_MSEG TO GT_MSEG.

        "## # ## ##

      PERFORM MODIFY_PRODUCT USING LV_EBELN LV_EBELP LV_MENGE.



      CLEAR : GS_STORE.



    ENDIF.

    ENDLOOP.



    "DB ##

    INSERT ZMKPF21 FROM TABLE GT_MKPF.

    INSERT ZMSEG21 FROM TABLE GT_MSEG.

  ELSE.

    MESSAGE '#### ### ####' TYPE 'I'.

  ENDIF.







ENDFORM.

"============================================================

" ## ## ## ##

"============================================================




*&---------------------------------------------------------------------*

*&      Form  AUTO_CALCULATE_DOCUMENT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM AUTO_CALCULATE_DOCUMENT CHANGING PV_MBLNR TYPE ZMKPF21-MBLNR.



   DATA : lv_max TYPE zmkpf21-mblnr.



  SELECT MAX( mblnr ) INTO lv_max FROM zmkpf21.



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

*      -->P_LV_EBELN  text

*      -->P_LV_EBELP  text

*      -->P_LV_MENGE  text

*----------------------------------------------------------------------*




"============================================================

" ## # #### ## ##

"============================================================

FORM MODIFY_PRODUCT  USING    LV_EBELN

                              LV_EBELP

                              LV_MENGE.



  SELECT SINGLE *

    INTO GS_EKPO

    FROM ZEKPO21

    WHERE ebeln = LV_ebeln

      AND ebelp = LV_ebelp.



  LOOP AT gt_store INTO gs_store.

    IF gs_store-ebeln = LV_ebeln AND gs_store-ebelp = LV_ebelp.





      gs_store-menge = GS_EKPO-MENGE - LV_menge.



      IF gs_store-menge < 0.

        MESSAGE '### ## ######' TYPE 'E'.

      ELSE.

        MODIFY gt_store FROM gs_store INDEX sy-tabix.

        MESSAGE '#######' TYPE 'S'.

      ENDIF.



    ENDIF.

  ENDLOOP.





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

      IT_OUTTAB                     = GT_CHECK

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




*&---------------------------------------------------------------------*

*&      Form  FIELDCAT_SEARCH

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELDCAT_SEARCH .

 CLEAR : GS_FIELDCAT, GT_FIELDCAT.

 GS_FIELDCAT-COL_POS = 1.

 GS_FIELDCAT-COLTEXT = '##'.

 GS_FIELDCAT-FIELDNAME = 'CHECK'.

 GS_FIELDCAT-EDIT = 'X'.

 GS_FIELDCAT-CHECKBOX = 'X'.

 GS_FIELDCAT-OUTPUTLEN = 5.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 2.

 GS_FIELDCAT-COLTEXT = '####'.

 GS_FIELDCAT-FIELDNAME = 'MBLNR'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 3.

 GS_FIELDCAT-COLTEXT = '####'.

 GS_FIELDCAT-FIELDNAME = 'MJAHR'.

 GS_FIELDCAT-OUTPUTLEN = 6.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 4.

 GS_FIELDCAT-COLTEXT = '#####'.

 GS_FIELDCAT-FIELDNAME = 'ZEILE'.

 GS_FIELDCAT-OUTPUTLEN = 8.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 5.

 GS_FIELDCAT-COLTEXT = '####'.

 GS_FIELDCAT-FIELDNAME = 'MATNR'.

 GS_FIELDCAT-OUTPUTLEN = 6.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 6.

 GS_FIELDCAT-COLTEXT = '###'.

 GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-OUTPUTLEN = 6.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 7.

 GS_FIELDCAT-COLTEXT = '####'.

 GS_FIELDCAT-FIELDNAME = 'LGORT'.

 GS_FIELDCAT-OUTPUTLEN = 7.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 8.

 GS_FIELDCAT-COLTEXT = '#####'.

 GS_FIELDCAT-FIELDNAME = 'LIFNR'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 9.

 GS_FIELDCAT-COLTEXT = '###'.

 GS_FIELDCAT-FIELDNAME = 'WAERS'.

 GS_FIELDCAT-OUTPUTLEN = 6.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 10.

 GS_FIELDCAT-COLTEXT = '##'.

 GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-OUTPUTLEN = 7.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 11.

 GS_FIELDCAT-COLTEXT = '##'.

 GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-OUTPUTLEN = 5.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 12.

 GS_FIELDCAT-COLTEXT = '######'.

 GS_FIELDCAT-FIELDNAME = 'EBELN'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 13.

 GS_FIELDCAT-COLTEXT = '####'.

 GS_FIELDCAT-FIELDNAME = 'BUKRS'.

  GS_FIELDCAT-OUTPUTLEN = 7.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 14.

 GS_FIELDCAT-COLTEXT = '####'.

 GS_FIELDCAT-FIELDNAME = 'GJAHR'.

  GS_FIELDCAT-OUTPUTLEN = 7.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 15.

 GS_FIELDCAT-COLTEXT = '####'.

 GS_FIELDCAT-FIELDNAME = 'BELNR'.

  GS_FIELDCAT-OUTPUTLEN = 6.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 16.

 GS_FIELDCAT-COLTEXT = '###'.

 GS_FIELDCAT-FIELDNAME = 'SHKZG'.

  GS_FIELDCAT-OUTPUTLEN = 6.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 17.

 GS_FIELDCAT-COLTEXT = '##'.

 GS_FIELDCAT-FIELDNAME = 'DMBTR'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CANCEL_IPGO

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




"============================================================

" ## ## ##

"============================================================

FORM CANCEL_IPGO .

IF GC_GRID IS BOUND.

    CALL METHOD GC_GRID->CHECK_CHANGED_DATA.

  ENDIF.



  DATA: LT_DELETE TYPE TABLE OF ZMSEG21,

        LS_DELETE TYPE ZMSEG21.



  FIELD-SYMBOLS: <LS_ROW> LIKE GS_CHECK.



    "### ## ### ##

  LOOP AT GT_CHECK ASSIGNING <LS_ROW> WHERE CHECK = 'X'.

    CLEAR LS_DELETE.

    LS_DELETE-MBLNR = <LS_ROW>-MBLNR.

    LS_DELETE-MJAHR = <LS_ROW>-MJAHR.

    LS_DELETE-ZEILE = <LS_ROW>-ZEILE.

    APPEND LS_DELETE TO LT_DELETE.

  ENDLOOP.



  IF LT_DELETE IS INITIAL.

    MESSAGE '### ## ####.' TYPE 'I'.

    RETURN.

  ENDIF.





  LOOP AT LT_DELETE INTO LS_DELETE.

    DELETE FROM ZMSEG21

      WHERE MBLNR = @LS_DELETE-MBLNR

        AND MJAHR = @LS_DELETE-MJAHR

        AND ZEILE = @LS_DELETE-ZEILE.

  ENDLOOP.



  "Header ##

  DATA LV_CNT TYPE I.



  LOOP AT LT_DELETE INTO LS_DELETE.



    SELECT COUNT(*) INTO @LV_CNT

      FROM ZMSEG21

      WHERE MBLNR = @LS_DELETE-MBLNR

        AND MJAHR = @LS_DELETE-MJAHR.



    IF LV_CNT = 0.

      DELETE FROM ZMKPF21

        WHERE MBLNR = @LS_DELETE-MBLNR

          AND MJAHR = @LS_DELETE-MJAHR.

    ENDIF.



  ENDLOOP.



  COMMIT WORK.





  PERFORM GET_DATA2.

  PERFORM REFRESH.



  MESSAGE '## #####.' TYPE 'S'.

ENDFORM.