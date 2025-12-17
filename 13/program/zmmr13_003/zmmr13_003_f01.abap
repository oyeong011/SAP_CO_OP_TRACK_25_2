
*&---------------------------------------------------------------------*

*&  Include           ZMMR13_003_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  INITIALIZATION

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM INITIALIZATION.

  P3 = SY-DATUM.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SCREEN_CHANGE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SCREEN_CHANGE.

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.

      IF P_R1 = 'X'.

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ELSEIF SCREEN-GROUP1 = 'M2'.

      IF P_R2 = 'X'.

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_MANDATORY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_MANDATORY.

  DATA : LV_EBELN TYPE EBELN,

         LV_WERKS TYPE WERKS.

  IF P_R1 = 'X'.

    IF P1 IS INITIAL OR P2 IS INITIAL OR P3 IS INITIAL.

      MESSAGE S000 DISPLAY LIKE 'E'.

      LEAVE LIST-PROCESSING.

    ENDIF.

  ELSEIF P_R2 = 'X'.

    IF P1 IS INITIAL OR P2 IS INITIAL.

      MESSAGE S000 DISPLAY LIKE 'E'.

      LEAVE LIST-PROCESSING.

    ENDIF.

  ENDIF.

  SELECT SINGLE EBELN FROM ZEKKO_13 "PO ######## ##"

    INTO LV_EBELN

    WHERE EBELN = P1.

  IF SY-SUBRC <> 0.

    MESSAGE '#### ## #######' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  SELECT SINGLE WERKS FROM ZEKPO_13 "### ######### ##"

    INTO LV_WERKS

    WHERE EBELN = P1

      AND WERKS = P2.



  IF SY-SUBRC <> 0.

    MESSAGE '#### ## ######.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  INIT_DATA_0100

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM INIT_DATA_0100.



  PERFORM GET_HEADER.



  SELECT SINGLE * FROM ZEKKO_13

    INTO CORRESPONDING FIELDS OF GS_EKKO  "### ##### ##"

    WHERE EBELN = P1.       "PO##"



  SELECT * FROM ZEKPO_13

    INTO CORRESPONDING FIELDS OF TABLE GT_EKPO "### #### # ##"

    WHERE EBELN = P1        "PO##"

    AND WERKS = P2.        "###"



  CLEAR GT_ITEM.

  LOOP AT GT_EKPO INTO GS_EKPO.

    MOVE-CORRESPONDING GS_EKPO TO GS_ITEM.

    MOVE-CORRESPONDING GS_EKKO TO GS_ITEM.



    GS_ITEM-WEMNG = GS_EKPO-WEMNG.    "## ## ##"

    GS_ITEM-REMNG = GS_EKPO-MENGE - GS_EKPO-WEMNG.



    IF GS_ITEM-REMNG < 0.        "####: ##### ### 0## ##"

      GS_ITEM-REMNG = 0.

    ENDIF.



    GS_ITEM-ERFMG = GS_ITEM-REMNG. "### ##: ### ### ##(ERFMG)# ##### ##### ###"



    IF GS_ITEM-REMNG > 0.

      APPEND GS_ITEM TO GT_ITEM.

    ENDIF.

  ENDLOOP.

ENDFORM.

FORM CREATE_OBJECT.

  CREATE OBJECT GC_CUSTOM

    EXPORTING




*      PARENT                      =




      CONTAINER_NAME              = 'CON01'




*      STYLE                       =

*      LIFETIME                    = lifetime_default

*      REPID                       =

*      DYNNR                       =

*      NO_AUTODEF_PROGID_DYNNR     =

*    EXCEPTIONS

*      CNTL_ERROR                  = 1

*      CNTL_SYSTEM_ERROR           = 2

*      CREATE_ERROR                = 3

*      LIFETIME_ERROR              = 4

*      LIFETIME_DYNPRO_DYNPRO_LINK = 5

*      others                      = 6




      .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.

  CREATE OBJECT GC_GRID

    EXPORTING




*      I_SHELLSTYLE      = 0

*      I_LIFETIME        =




      I_PARENT          = GC_CUSTOM




*      I_APPL_EVENTS     = space

*      I_PARENTDBG       =

*      I_APPLOGPARENT    =

*      I_GRAPHICSPARENT  =

*      I_NAME            =

*      I_FCAT_COMPLETE   = SPACE

*    EXCEPTIONS

*      ERROR_CNTL_CREATE = 1

*      ERROR_CNTL_INIT   = 2

*      ERROR_CNTL_LINK   = 3

*      ERROR_DP_CREATE   = 4

*      others            = 5




      .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




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




FORM FIELD_CATALOG.



  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 1.

  GS_FIELDCAT-FIELDNAME = 'MARK'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-CHECKBOX  = 'X'.

  GS_FIELDCAT-EDIT      = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 2.

  GS_FIELDCAT-FIELDNAME = 'EBELN'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-KEY       = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 3.

  GS_FIELDCAT-FIELDNAME = 'EBELP'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-KEY       = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 4.

  GS_FIELDCAT-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 5.

  GS_FIELDCAT-FIELDNAME = 'BEDAT'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 6.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-NO_ZERO   = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 7.

  GS_FIELDCAT-FIELDNAME = 'MATNAME'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-OUTPUTLEN = 20.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 8.

  GS_FIELDCAT-FIELDNAME  = 'MENGE'.

  GS_FIELDCAT-COLTEXT    = 'PO##'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 9.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-COLTEXT   = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 10.

  GS_FIELDCAT-FIELDNAME  = 'STPRS'.

  GS_FIELDCAT-COLTEXT    = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 11.

  GS_FIELDCAT-FIELDNAME  = 'WEMNG'.

  GS_FIELDCAT-COLTEXT    = '#####'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 12.

  GS_FIELDCAT-FIELDNAME  = 'REMNG'.

  GS_FIELDCAT-COLTEXT    = '####'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 13.

  GS_FIELDCAT-FIELDNAME  = 'ERFMG'.

  GS_FIELDCAT-COLTEXT    = '####(##)'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.

  GS_FIELDCAT-EDIT       = 'X'.

  GS_FIELDCAT-REF_TABLE  = 'MSEG'.

  GS_FIELDCAT-REF_FIELD  = 'ERFMG'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 14.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-COLTEXT   = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 15.

  GS_FIELDCAT-FIELDNAME = 'PRDAT'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 16.

  GS_FIELDCAT-FIELDNAME = 'WERKS'.

  GS_FIELDCAT-COLTEXT   = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 17.

  GS_FIELDCAT-FIELDNAME = 'LGORT'.

  GS_FIELDCAT-COLTEXT   = '####'.

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




FORM ALV_LAYOUT.

  CLEAR GS_LAYOUT.




*  GS_LAYOUT-ZEBRA = 'X'.




  GS_LAYOUT-NO_TOOLBAR = 'X'.

  CLEAR GS_VARIANT.

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




FORM ALV_SORT.



ENDFORM.

FORM ALV_DISPLAY.

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*      I_BUFFER_ACTIVE               =

*      I_BYPASSING_BUFFER            =

*      I_CONSISTENCY_CHECK           =

*      I_STRUCTURE_NAME              =

*      IS_VARIANT                    =

*      I_SAVE                        =

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

      IT_OUTTAB                     = GT_ITEM

      IT_FIELDCATALOG               = GT_FIELDCAT

      IT_SORT                       = GT_SORT




*      IT_FILTER                     =

*    EXCEPTIONS

*      INVALID_PARAMETER_COMBINATION = 1

*      PROGRAM_ERROR                 = 2

*      TOO_MANY_LINES                = 3

*      others                        = 4




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM REFRESH.

  DATA : LS_STABLE TYPE LVC_S_STBL.



  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'. "#### USERCOMMAND ###### CURSOR#####"



  CALL METHOD GC_GRID2->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE      = LS_STABLE




*      I_SOFT_REFRESH =

*    EXCEPTIONS

*      FINISHED       = 1

*      others         = 2




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_HEADER

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_HEADER.

  GS_MKPF-BUDAT = P3.                   "## ###"

  GS_MKPF-MJAHR = GS_MKPF-BUDAT+0(4).

  SELECT SINGLE BEDAT

  FROM ZEKKO_13

  INTO GS_MKPF-BLDAT

  WHERE EBELN = P1.

  GS_MKPF-BLART = 'WE'.

  PERFORM GET_NEXT_MBLNR CHANGING GS_MKPF-MBLNR.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_NEXT_MBLNR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      <--P_LV_MBLNR  text

*----------------------------------------------------------------------*




FORM GET_NEXT_MBLNR  CHANGING P_MBLNR.

  DATA : LV_MAX TYPE MBLNR.

  SELECT MAX( MBLNR ) INTO LV_MAX FROM ZMKPF_13.

  IF LV_MAX <> 0.

    P_MBLNR = LV_MAX + 1.

  ELSE.

    P_MBLNR = '5000000000'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_DOCUMENT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_DOCUMENT.



  CALL METHOD GC_GRID->CHECK_CHANGED_DATA.



  READ TABLE GT_ITEM TRANSPORTING NO FIELDS

                   WITH KEY MARK = 'X'.   "## ##"

  CLEAR GS_MSEG.

  GS_MSEG-ZEILE = 0.



  LOOP AT GT_ITEM INTO GS_ITEM WHERE MARK = 'X'.

    GS_MSEG-ZEILE = GS_MSEG-ZEILE + 1.

    GS_MSEG-MBLNR = GS_MKPF-MBLNR.  "######"

    GS_MSEG-MJAHR = GS_MKPF-MJAHR.  "####"

    GS_MSEG-EBELP = GS_ITEM-EBELP.  "## ##"

    GS_MSEG-MATNR = GS_ITEM-MATNR.  "####"

    GS_MSEG-WERKS = GS_ITEM-WERKS.  "###"

    GS_MSEG-LGORT = GS_ITEM-LGORT.  "####"

    GS_MSEG-LIFNR = GS_ITEM-LIFNR.  "###"

    GS_MSEG-WAERS = GS_ITEM-WAERS.  "##"

    GS_MSEG-MENGE = GS_ITEM-ERFMG.  "## ## ##"

    GS_MSEG-MEINS = GS_ITEM-MEINS.  "##"

    GS_MSEG-EBELN = GS_ITEM-EBELN.  "######"

    GS_MSEG-BUKRS = GS_ITEM-BUKRS. "####"

    GS_MSEG-BWART = 101.

    GS_MSEG-SHKZG = 'S'. " ##(S) = ## ##"

    GS_MSEG-DMBTR = GS_ITEM-ERFMG * GS_ITEM-STPRS. "## ## (## * ##) -> ## ## ###"




*    GS_MSEG-GJAHR = "####"

*    GS_MSEG-BELNR = "####"




    APPEND GS_MSEG TO GT_MSEG.

    "DB ### ## ## #### ###

  ENDLOOP.

    INSERT ZMKPF_13 FROM GS_MKPF.

    IF SY-SUBRC <> 0.

      ROLLBACK WORK.

      MESSAGE 'ZMKPF_13 INSERT ##' TYPE 'S' DISPLAY LIKE 'I'.

    ENDIF.

    INSERT ZMSEG_13 FROM TABLE GT_MSEG.

    IF SY-SUBRC <> 0.

      ROLLBACK WORK.

      MESSAGE '#### ## ## ##' TYPE 'E'.

      EXIT.

    ENDIF.

  DATA : LV_MATNR TYPE MATNR.

  LOOP AT GT_ITEM INTO GS_ITEM WHERE MARK = 'X'.

    UPDATE ZEKPO_13 "#### ####"

       SET WEMNG = WEMNG + GS_ITEM-ERFMG  "## ### + ## ###"

     WHERE EBELN = GS_ITEM-EBELN

       AND EBELP = GS_ITEM-EBELP.

    LV_MATNR = GS_ITEM-MATNR.

    SHIFT LV_MATNR LEFT DELETING LEADING '0'.

    UPDATE ZMARA_13

       SET MENGE = MENGE + GS_ITEM-ERFMG

     WHERE MATNR = LV_MATNR

       AND WERKS = GS_ITEM-WERKS.   "##### ## ## ##"

  ENDLOOP.

  COMMIT WORK AND WAIT.

  MESSAGE '## ## ' && GS_MKPF-MBLNR && ' ## #######.' TYPE 'S'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CLASS_EVENT.

  CREATE OBJECT GO_EVENT.

  SET HANDLER GO_EVENT->HANDLE_HOTSPOT_CLICK FOR GC_GRID.

  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED




*    EXCEPTIONS

*      ERROR      = 1

*      others     = 2




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.

ENDFORM.

FORM ALV_HANDLE_HOTSPOT_CLICK  USING P_ROW_ID TYPE LVC_S_ROW

                                     P_COLUMN_ID TYPE LVC_S_COL

                                     P_ROW_NO TYPE LVC_S_ROID.

  DATA: LS_MKPF LIKE GS_MKPF.

  READ TABLE GT_MKPF INTO LS_MKPF INDEX P_ROW_ID-INDEX. "#### ### ## #### ##(MBLNR)# ##"

  IF SY-SUBRC = 0.

    LOOP AT GT_MSEG INTO GS_MSEG

         WHERE MBLNR = LS_MKPF-MBLNR

           AND MJAHR = LS_MKPF-MJAHR.

      READ TABLE GT_MSEG_DISPLAY TRANSPORTING NO FIELDS

                                 WITH KEY MBLNR = GS_MSEG-MBLNR

                                          MJAHR = GS_MSEG-MJAHR

                                          ZEILE = GS_MSEG-ZEILE. " ###### ### ##"

      IF SY-SUBRC <> 0.                   "## ## ## (SUBRC# 0# ### ### #)"

        MOVE-CORRESPONDING GS_MSEG TO GS_MSEG_DISPLAY.

        GS_MSEG_DISPLAY-MARK = ' '.

        APPEND GS_MSEG_DISPLAY TO GT_MSEG_DISPLAY.

      ENDIF.

    ENDLOOP.

    CALL METHOD GC_GRID2->REFRESH_TABLE_DISPLAY.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  INIT_DATA_0200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM INIT_DATA_0200.

  CLEAR : GT_MKPF, GT_MSEG, GT_MSEG_DISPLAY.

  SELECT * FROM ZMSEG_13  "## ### ### ##"

    INTO TABLE GT_MSEG

    WHERE EBELN = P1

    AND WERKS = P2.



  IF GT_MSEG IS INITIAL.

    MESSAGE '### ### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  SELECT * FROM ZMKPF_13    "## ## ### ##"

    INTO TABLE GT_MKPF

    FOR ALL ENTRIES IN GT_MSEG

      WHERE MBLNR = GT_MSEG-MBLNR  "## #### ## ####(MBLNR)# #### ##(ZMKPF)# ##.

      AND MJAHR = GT_MSEG-MJAHR.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT2.

  CREATE OBJECT GC_DOCKING

    EXPORTING




*      PARENT                      =




      REPID                       = SY-REPID

      DYNNR                       = SY-DYNNR




*      SIDE                        = DOCK_AT_LEFT




      EXTENSION                   = 2000




*      STYLE                       =

*      LIFETIME                    = lifetime_default

*      CAPTION                     =

*      METRIC                      = 0

*      RATIO                       =

*      NO_AUTODEF_PROGID_DYNNR     =

*      NAME                        =

*    EXCEPTIONS

*      CNTL_ERROR                  = 1

*      CNTL_SYSTEM_ERROR           = 2

*      CREATE_ERROR                = 3

*      LIFETIME_ERROR              = 4

*      LIFETIME_DYNPRO_DYNPRO_LINK = 5

*      others                      = 6




      .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.

  CREATE OBJECT GC_SPLITTER

    EXPORTING




*      LINK_DYNNR        =

*      LINK_REPID        =

*      SHELLSTYLE        =

*      LEFT              =

*      TOP               =

*      WIDTH             =

*      HEIGHT            =

*      METRIC            = cntl_metric_dynpro

*      ALIGN             = 15




      PARENT            = GC_DOCKING

      ROWS              = 2

      COLUMNS           = 1




*      NO_AUTODEF_PROGID_DYNNR =

*      NAME              =

*    EXCEPTIONS

*      CNTL_ERROR        = 1

*      CNTL_SYSTEM_ERROR = 2

*      others            = 3




      .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.

  CALL METHOD GC_SPLITTER->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER1.

  CALL METHOD GC_SPLITTER->GET_CONTAINER

    EXPORTING

      ROW       = 2

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER2.

  CALL METHOD GC_SPLITTER->SET_ROW_HEIGHT

      EXPORTING

        ID     = 1    " 1# # (##)

        HEIGHT = 20.  " ## 30%

  CREATE OBJECT GC_GRID

    EXPORTING




*      I_SHELLSTYLE      = 0

*      I_LIFETIME        =




      I_PARENT          = GC_CONTAINER1




*      I_APPL_EVENTS     = space

*      I_PARENTDBG       =

*      I_APPLOGPARENT    =

*      I_GRAPHICSPARENT  =

*      I_NAME            =

*      I_FCAT_COMPLETE   = SPACE

*    EXCEPTIONS

*      ERROR_CNTL_CREATE = 1

*      ERROR_CNTL_INIT   = 2

*      ERROR_CNTL_LINK   = 3

*      ERROR_DP_CREATE   = 4

*      others            = 5




      .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.

  CREATE OBJECT GC_GRID2

    EXPORTING




*      I_SHELLSTYLE      = 0

*      I_LIFETIME        =




      I_PARENT          = GC_CONTAINER2




*      I_APPL_EVENTS     = space

*      I_PARENTDBG       =

*      I_APPLOGPARENT    =

*      I_GRAPHICSPARENT  =

*      I_NAME            =

*      I_FCAT_COMPLETE   = SPACE

*    EXCEPTIONS

*      ERROR_CNTL_CREATE = 1

*      ERROR_CNTL_INIT   = 2

*      ERROR_CNTL_LINK   = 3

*      ERROR_DP_CREATE   = 4

*      others            = 5




      .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.

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

  PERFORM CONTAINER1_FILED.

  PERFORM CONTAINER2_FILED.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER1_FILED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CONTAINER1_FILED.

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 1.

  GS_FIELDCAT-FIELDNAME = 'MBLNR'.

  GS_FIELDCAT-COLTEXT   = '######'.

  GS_FIELDCAT-KEY       = 'X'.

  GS_FIELDCAT-HOTSPOT    = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 2.

  GS_FIELDCAT-FIELDNAME = 'MJAHR'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-KEY       = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 3.

  GS_FIELDCAT-FIELDNAME = 'BLART'.

  GS_FIELDCAT-COLTEXT   = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 4.

  GS_FIELDCAT-FIELDNAME = 'BLDAT'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 5.

  GS_FIELDCAT-FIELDNAME = 'BUDAT'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER2_FILED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CONTAINER2_FILED.

  CLEAR : GS_FIELDCAT, GT_FIELDCAT2.

  GS_FIELDCAT-COL_POS   = 1.

  GS_FIELDCAT-FIELDNAME = 'MARK'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-CHECKBOX  = 'X'.

  GS_FIELDCAT-EDIT      = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 2.

  GS_FIELDCAT-FIELDNAME = 'MBLNR'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-KEY       = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 3.

  GS_FIELDCAT-FIELDNAME = 'ZEILE'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-KEY       = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 4.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 4.

  GS_FIELDCAT-FIELDNAME = 'BWART'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-OUTPUTLEN = 7.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 5.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-NO_ZERO   = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 18.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 6.

  GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.

  GS_FIELDCAT-OUTPUTLEN = 13.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 7.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-OUTPUTLEN = 3.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 8.

  GS_FIELDCAT-FIELDNAME = 'DMBTR'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  GS_FIELDCAT-OUTPUTLEN = 15.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 9.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-OUTPUTLEN = 5.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 10.

  GS_FIELDCAT-FIELDNAME = 'SHKZG'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-OUTPUTLEN = 5.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 11.

  GS_FIELDCAT-FIELDNAME = 'EBELN'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 12.

  GS_FIELDCAT-FIELDNAME = 'WERKS'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-OUTPUTLEN = 5.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 13.

  GS_FIELDCAT-FIELDNAME = 'LGORT'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-OUTPUTLEN = 7.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.

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

      IT_OUTTAB                     = GT_MKPF

      IT_FIELDCATALOG               = GT_FIELDCAT

      IT_SORT                       = GT_SORT




*      IT_FILTER                     =

*    EXCEPTIONS

*      INVALID_PARAMETER_COMBINATION = 1

*      PROGRAM_ERROR                 = 2

*      TOO_MANY_LINES                = 3

*      others                        = 4




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.

  CALL METHOD GC_GRID2->SET_TABLE_FOR_FIRST_DISPLAY

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

      IT_OUTTAB                     = GT_MSEG_DISPLAY

      IT_FIELDCATALOG               = GT_FIELDCAT2

      IT_SORT                       = GT_SORT




*      IT_FILTER                     =

*    EXCEPTIONS

*      INVALID_PARAMETER_COMBINATION = 1

*      PROGRAM_ERROR                 = 2

*      TOO_MANY_LINES                = 3

*      others                        = 4




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CANCLE_DOCUMENT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CANCEL_DOCUMENT.

  DATA : LV_MATNR TYPE MATNR.

  DATA : LV_CNT TYPE I.

  DATA : LV_ZEILE TYPE N LENGTH 4.



  CLEAR : GS_MSEG, GT_MSEG.



  GS_MKPF-BUDAT = SY-DATUM.               "## ###"

  GS_MKPF-MJAHR = GS_MKPF-BUDAT+0(4).

  GS_MKPF-BLDAT = GS_MKPF-BUDAT.

  GS_MKPF-BLART = 'WE'.

  PERFORM GET_NEXT_MBLNR CHANGING GS_MKPF-MBLNR. "## ## ## ##"



  CALL METHOD GC_GRID2->CHECK_CHANGED_DATA.



  READ TABLE GT_MSEG_DISPLAY TRANSPORTING NO FIELDS WITH KEY MARK = 'X'.

  IF SY-SUBRC <> 0.

    MESSAGE '### ### #####.' TYPE 'S' DISPLAY LIKE 'W'. "### ### ### ## (### ## ###)"

    RETURN.

  ENDIF.



  LV_ZEILE = 0.

  LOOP AT GT_MSEG_DISPLAY INTO GS_MSEG_DISPLAY WHERE MARK = 'X'.

    SELECT COUNT( * ) INTO LV_CNT

      FROM ZMSEG_13

     WHERE SJAHR = GS_MSEG_DISPLAY-MJAHR  " ## ## = ## ##

       AND SMBLN = GS_MSEG_DISPLAY-MBLNR  " ## ## = ## ##

       AND SMBLP = GS_MSEG_DISPLAY-ZEILE  " ## ## = ## ##

       AND BWART = '102'.         " ## ##

    IF LV_CNT > 0.

      MESSAGE '## ## ### #####.' TYPE 'S' DISPLAY LIKE 'E'.

      RETURN.

    ENDIF.



    IF GS_MSEG_DISPLAY-BWART = '102'.

      MESSAGE '## ### ## #### ####.' TYPE 'S' DISPLAY LIKE 'E'. "## ### ### ## ##### 102# ## ##"

      RETURN.

    ENDIF.



    LV_ZEILE = LV_ZEILE + 1.

    MOVE-CORRESPONDING GS_MSEG_DISPLAY TO GS_MSEG. "## ## ##"



    GS_MSEG-MBLNR = GS_MKPF-MBLNR. "### ####"

    GS_MSEG-MJAHR = GS_MKPF-MJAHR. "## ##"

    GS_MSEG-ZEILE = LV_ZEILE.      "### ##"

    GS_MSEG-BWART = '102'.         " 101 -> 102 (##)

    GS_MSEG-SHKZG = 'H'.           " S(##) -> H(##)

    GS_MSEG-SJAHR = GS_MSEG-MJAHR.         "## ### ### ##"

    GS_MSEG-SMBLN = GS_MSEG_DISPLAY-MBLNR. "## ## ### ### ##"

    GS_MSEG-SMBLP = GS_MSEG_DISPLAY-ZEILE. "## ## ### ### ##"



    APPEND GS_MSEG TO GT_MSEG.

  ENDLOOP.



  INSERT ZMKPF_13 FROM GS_MKPF. "#### ## ## ##"

  IF SY-SUBRC <> 0.

    ROLLBACK WORK.

    MESSAGE '## ## ## ## ##' TYPE 'E'. EXIT.

  ENDIF.



  INSERT ZMSEG_13 FROM TABLE GT_MSEG. "#### ## ### ##"

  IF SY-SUBRC <> 0.

    ROLLBACK WORK.

    MESSAGE '## ## ## ## ##' TYPE 'E'. EXIT.

  ENDIF.



  LOOP AT GT_MSEG_DISPLAY INTO GS_MSEG_DISPLAY WHERE MARK = 'X'.



    UPDATE ZEKPO_13                         "####(PO) ### ## ##"

       SET WEMNG = WEMNG - GS_MSEG_DISPLAY-MENGE    "+ # ### -

     WHERE EBELN = GS_MSEG_DISPLAY-EBELN    "## ###??"

       AND EBELP = GS_MSEG_DISPLAY-EBELP.

    "#####(##) ## ##"

    LV_MATNR = GS_MSEG_DISPLAY-MATNR.

    SHIFT LV_MATNR LEFT DELETING LEADING '0'.



    UPDATE ZMARA_13

       SET MENGE = MENGE - GS_MSEG_DISPLAY-MENGE  "+ # ### -"

     WHERE MATNR = LV_MATNR               "## ##"

       AND WERKS = GS_MSEG_DISPLAY-WERKS.

  ENDLOOP.



  COMMIT WORK AND WAIT.

  MESSAGE '## ## ## ' && GS_MKPF-MBLNR && ' ## #######.' TYPE 'S'.

ENDFORM.