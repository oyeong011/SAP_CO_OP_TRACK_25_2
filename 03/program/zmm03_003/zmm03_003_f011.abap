
*&---------------------------------------------------------------------*

*&  Include           ZMM03_003_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLE_DATA_CHANGED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_ER_DATA_CHANGED  text

*----------------------------------------------------------------------*




FORM ALV_HANDLE_DATA_CHANGED  USING    P_ER_DATA_CHANGED.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SELECTION_SCREEN_OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SELECTION_SCREEN_OUTPUT .

  LOOP AT SCREEN.

    IF P_R2 = 'X' AND SCREEN-GROUP1 = 'M1'.

      SCREEN-ACTIVE = '0'.

      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SELECTION_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SELECTION_SCREEN .

  IF SSCRFIELDS-UCOMM = 'ONLI' AND P_R1 = 'X'.

    "1. ### ##

    IF P_EBELN IS INITIAL.

      MESSAGE '##### #####.' TYPE 'E'.

    ELSEIF P_WERK IS INITIAL.

      MESSAGE '#### #####.' TYPE 'E'.

    ELSEIF P_BUDAT IS INITIAL.

      MESSAGE '###### #####.' TYPE 'E'.

    ENDIF.



    "2. PO## ### ##

    DATA : LV_EBELN TYPE ZEDT03_EKKO-EBELN.

    SELECT SINGLE EBELN FROM ZEDT03_EKKO

                        WHERE EBELN = @P_EBELN

                        INTO @LV_EBELN.

    IF SY-SUBRC <> 0.

      MESSAGE '#### ## #######.' TYPE 'E'.

    ENDIF.



  ELSEIF SSCRFIELDS-UCOMM = 'ONLI' AND P_R2 = 'X'.

    "1. ### ##

    IF P_EBELN IS INITIAL.

      MESSAGE '##### #####.' TYPE 'E'.

    ELSEIF P_WERK IS INITIAL.

      MESSAGE '#### #####.' TYPE 'E'.

    ENDIF.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA_CRE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA_CRE .

  "## #####, PO(## ##) ### #### ### ###.



  "## ### ## ## ## ##

  DATA: LV_GR_QTY TYPE ZEDT03_MSEG-MENGE, "### ## (## ### #)

        LV_OPEN_QTY TYPE ZEDT03_EKPO-MENGE. "## ## ## (## #)



  "## ### ###

  REFRESH GT_DATA.



  "1. #### ##(EKKO)+###(EKPO)# ####

  "##: ### PO##, ### ###

  SELECT A~EBELN A~LIFNR A~BEDAT A~WAERS

         B~EBELP B~MATNR B~MAKTX B~MENGE B~MEINS B~BPRME B~PRDAT B~WERK AS WERKS B~LGORT

    INTO CORRESPONDING FIELDS OF TABLE GT_DATA

    FROM ZEDT03_EKKO AS A

    INNER JOIN ZEDT03_EKPO AS B

    ON A~EBELN = B~EBELN

    WHERE A~EBELN = P_EBELN

      AND B~WERK  = P_WERK.



  "#### ### ##

  IF GT_DATA[] IS INITIAL.

    RETURN.

  ENDIF.



  "2. ## ## ## : GT_DATA# LOOP##

  LOOP AT GT_DATA INTO GS_DATA.



    CLEAR: LV_GR_QTY, LV_OPEN_QTY. "### ##, ## ## ##



    "[1]## ### ## #####(MSEG)## ## ## ###

    "#, LOEKZ(#####)# ##('X')# ## #### ##

    SELECT SUM( MENGE )

      INTO LV_GR_QTY "### ##

      FROM ZEDT03_MSEG

     WHERE EBELN = GS_DATA-EBELN "######

       AND EBELP = GS_DATA-EBELP "####

       AND LOEKZ <> 'X'. "LOEKZ# 'X'# ## ## ### ## ##



    "[2]## = ##(PO)## - #####

    LV_OPEN_QTY = GS_DATA-MENGE - LV_GR_QTY.



    "[3]### 0## # #### ###.

    IF LV_OPEN_QTY > 0.

      GS_DATA-GMENGE = LV_OPEN_QTY. " ### '### ##' ### ### ##### #



      MODIFY GT_DATA FROM GS_DATA.

    ELSE.

      "## ## ### #, #### ##

      DELETE GT_DATA INDEX SY-TABIX.

    ENDIF.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA_DIS

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA_DIS .

  "## ### ##

  REFRESH GT_DATA.



  "1. ## ##(MKPF)+## ###(MSEG) ##

  "### ## ##### ## (### # ## #### ### ALV## ### #)

  SELECT A~MBLNR A~MJAHR A~BUDAT AS BEDAT "MKPF# #### #### BEDAT ### ##

         B~EBELN B~EBELP B~MATNR B~MENGE AS GMENGE B~MEINS B~WERKS B~LGORT B~LOEKZ

    INTO CORRESPONDING FIELDS OF TABLE GT_DATA

    FROM ZEDT03_MKPF AS A

    INNER JOIN ZEDT03_MSEG AS B

      ON A~MBLNR = B~MBLNR

     AND A~MJAHR = B~MJAHR

   WHERE B~EBELN = P_EBELN

     AND B~WERKS = P_WERK.



  "#### ### ##

  IF GT_DATA[] IS INITIAL.

    RETURN.

  ENDIF.



  "2. ## ## ####, ### # ##

  LOOP AT GT_DATA INTO GS_DATA.

    "#### ## ## #### (###, ##)

    SELECT SINGLE LIFNR WAERS

      INTO (GS_DATA-LIFNR, GS_DATA-WAERS)

      FROM ZEDT03_EKKO

     WHERE EBELN = GS_DATA-EBELN.



    "#### ### ## #### (###, ##, ###)

    SELECT SINGLE MAKTX BPRME PRDAT

      INTO (GS_DATA-MAKTX, GS_DATA-BPRME, GS_DATA-PRDAT)

      FROM ZEDT03_EKPO

     WHERE EBELN = GS_DATA-EBELN

       AND EBELP = GS_DATA-EBELP.



    "### ## ### ##(###)### ##

    IF GS_DATA-LOEKZ = 'X'.

      CONCATENATE GS_DATA-MAKTX '(###)' INTO GS_DATA-MAKTX SEPARATED BY SPACE. "#### ### ##

    ENDIF.



    MODIFY GT_DATA FROM GS_DATA.

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




*      PARENT                      =




      REPID                       = SY-REPID "#### ID

      DYNNR                       = SY-DYNNR "### ##"




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



  CREATE OBJECT GC_GRID

    EXPORTING




*      I_SHELLSTYLE      = 0

*      I_LIFETIME        =




      I_PARENT          = GC_DOCKING




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




FORM FIELD_CATALOG .

  CLEAR: GT_FIELDCAT, GS_FIELDCAT.



  "1. ## (####)

  IF P_R1 = 'X'. "## ## ### ## ##

    GS_FIELDCAT-FIELDNAME = 'L_CHECK'.

    GS_FIELDCAT-COLTEXT   = '##'.

    GS_FIELDCAT-CHECKBOX  = 'X'.        "####

    GS_FIELDCAT-EDIT      = 'X'.        "## ##

    GS_FIELDCAT-OUTPUTLEN = 5.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

  ENDIF.



  "1. ######

  IF P_R2 = 'X'. "## ## ### ## ##

   GS_FIELDCAT-FIELDNAME = 'MBLNR'.

   GS_FIELDCAT-COLTEXT   = '######'.

   GS_FIELDCAT-OUTPUTLEN = 10.

   APPEND GS_FIELDCAT TO GT_FIELDCAT.

  ENDIF.



  "2. ######

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'EBELN'.

  GS_FIELDCAT-COLTEXT   = '######'.

  GS_FIELDCAT-KEY       = 'X'.        "# ##

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  "3. ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'EBELP'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-KEY       = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 7.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  "4. ###

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  "5. ###

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'BEDAT'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  "6. ####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-OUTPUTLEN = 12.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  "7. ###

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'MAKTX'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-OUTPUTLEN = 20.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  "8. ## (## ##)

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'GMENGE'.   "### ##

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.   " ## ## ##

  GS_FIELDCAT-OUTPUTLEN = 10.



  "## ### ## ## ##

  IF P_R1 = 'X'. "## ##

    GS_FIELDCAT-EDIT = 'X'.

  ELSE.

    GS_FIELDCAT-EDIT = ''.

  ENDIF.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  "9. ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-OUTPUTLEN = 4.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  "10. ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'BPRME'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.   " ## ## ##

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  "11. ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-OUTPUTLEN = 5.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  "12. ###

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'PRDAT'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  "13. ###

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'WERKS'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-OUTPUTLEN = 8.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  "14. ####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'LGORT'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-OUTPUTLEN = 8.

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

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA      = 'X'.       "####

  GS_LAYOUT-CWIDTH_OPT = 'X'.       "# ## ## ###

  GS_LAYOUT-SEL_MODE   = 'A'.       "# ## ## ##

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

  CLEAR: GS_SORT, GT_SORT.



  "1# ##: ###### ####

  CLEAR GS_SORT.

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'EBELN'.

  GS_SORT-UP        = 'X'.

  APPEND GS_SORT TO GT_SORT.



  "2# ##: #### ####

  CLEAR GS_SORT.

  GS_SORT-SPOS = 2.

  GS_SORT-FIELDNAME = 'EBELP'.

  GS_SORT-UP        = 'X'.

  APPEND GS_SORT TO GT_SORT.

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

  "### ### ## ##

  IF GO_EVENT IS INITIAL.

    CREATE OBJECT GO_EVENT.

  ENDIF.



  "1. ### ## #### #### ##

  SET HANDLER GO_EVENT->HANDLE_DATA_CHANGED FOR GC_GRID.



  "2. #### #### ###### #### ##### ## (MC_EVT_MODIFIED)

  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.

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

      IT_OUTTAB                     = GT_DATA

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




FORM REFRESH .

  DATA: LS_STABLE TYPE LVC_S_STBL.

  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

      EXPORTING

        IS_STABLE = LS_STABLE. " ### ## ##

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SAVE_DATA .

  DATA: LS_MKPF TYPE ZEDT03_MKPF, "##### ##

        LT_MSEG TYPE TABLE OF ZEDT03_MSEG,

        LS_MSEG TYPE ZEDT03_MSEG. "##### ###



  DATA: LV_MAX_MBLNR TYPE ZEDT03_MKPF-MBLNR, "### ####

        LV_NEW_MBLNR TYPE ZEDT03_MKPF-MBLNR, "## # ####

        LV_COUNT     TYPE I,                "### ##

        LV_ITEM_CNT  TYPE N LENGTH 4. "### ## ### ##.



  "1. ALV #### ### ### GT_DATA# ##

  CALL METHOD GC_GRID->CHECK_CHANGED_DATA.



  "2. ### ##

  LOOP AT GT_DATA INTO GS_DATA WHERE L_CHECK = 'X'. "### ### ##, ## ##

    IF GS_DATA-GMENGE <= 0.

      MESSAGE '## ### 0## ## ###.' TYPE 'S' DISPLAY LIKE 'E'.

      RETURN.

    ENDIF.

    ADD 1 TO LV_COUNT.

  ENDLOOP.



  IF LV_COUNT = 0.

    MESSAGE '### ######.' TYPE 'S' DISPLAY LIKE 'E'.

    RETURN.

  ENDIF.



  "3. ###### ##

  SELECT MAX( MBLNR ) INTO LV_MAX_MBLNR FROM ZEDT03_MKPF. "### ## ######



  IF LV_MAX_MBLNR IS INITIAL.

    LV_NEW_MBLNR = '5000000000'. "#### ### 5000000000# ##

  ELSE.

    LV_NEW_MBLNR = LV_MAX_MBLNR + 1. "## # ####

  ENDIF.



  "4. DB ## ### ##



  "## ### (MKPF)

  LS_MKPF-MBLNR = LV_NEW_MBLNR. "## # ####

  LS_MKPF-MJAHR = P_BUDAT(4).  "#### ##

  LS_MKPF-BLART = 'WE'.          "####

  LS_MKPF-BLDAT = P_BUDAT.      "###

  LS_MKPF-BUDAT = P_BUDAT.       "###



  "### ### (MSEG)

  LOOP AT GT_DATA INTO GS_DATA WHERE L_CHECK = 'X'.



    ADD 1 TO LV_ITEM_CNT. "### ## ##### ##



    CLEAR LS_MSEG.

    LS_MSEG-MBLNR = LV_NEW_MBLNR.   "### ####

    LS_MSEG-MJAHR = P_BUDAT(4).

    LS_MSEG-ZEILE = LV_ITEM_CNT.       "##### (1, 2, 3, ...)

    LS_MSEG-EBELN = GS_DATA-EBELN.

    LS_MSEG-EBELP = GS_DATA-EBELP.

    LS_MSEG-MATNR = GS_DATA-MATNR.

    LS_MSEG-WERKS = GS_DATA-WERKS.

    LS_MSEG-LGORT = GS_DATA-LGORT.

    LS_MSEG-LIFNR = GS_DATA-LIFNR.

    LS_MSEG-WAERS = GS_DATA-WAERS.

    LS_MSEG-MENGE = GS_DATA-GMENGE. "### ## ##

    LS_MSEG-MEINS = GS_DATA-MEINS.

    LS_MSEG-LOEKZ = ''.



    APPEND LS_MSEG TO LT_MSEG.

  ENDLOOP.



  "5. ## DB ##

  INSERT ZEDT03_MKPF FROM LS_MKPF. "INSERT# ##### ## ##

  IF SY-SUBRC <> 0.

    ROLLBACK WORK.

    MESSAGE '## ## ##' TYPE 'E'.

    RETURN.

  ENDIF.



  INSERT ZEDT03_MSEG FROM TABLE LT_MSEG. "INSERT# ##### ### ##

  IF SY-SUBRC <> 0.

    ROLLBACK WORK.

    MESSAGE '### ## ##' TYPE 'E'.

    RETURN.

  ENDIF.



  "6. #### #

  COMMIT WORK AND WAIT.

  MESSAGE '## ### #######.' TYPE 'S'.



  "7. ## ##

  PERFORM GET_DATA_CRE. "### ## ### ##### ### ###

  PERFORM REFRESH.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CANCEL_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CANCEL_DATA .



  DATA: LT_ROWS TYPE LVC_T_ROW,  "### # #### ## ###

        LS_ROW  TYPE LVC_S_ROW.



  "1. ## ####, ALV## ## #### ## # # ## # ####

  CALL METHOD GC_GRID->GET_SELECTED_ROWS

    IMPORTING

      ET_INDEX_ROWS = LT_ROWS.



  "### ## ### ##

  IF LT_ROWS[] IS INITIAL.

    MESSAGE '### ### ######.' TYPE 'S' DISPLAY LIKE 'E'.

    RETURN.

  ENDIF.



  "2. ### ##

  LOOP AT LT_ROWS INTO LS_ROW. "## ####

    "# ### ### ##

    READ TABLE GT_DATA INTO GS_DATA INDEX LS_ROW-INDEX.



    IF SY-SUBRC = 0.

      IF GS_DATA-LOEKZ = 'X'. " ## ### ### ##

        MESSAGE '## ### ## #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

        RETURN.

      ENDIF.

    ENDIF.

  ENDLOOP.





  "3. ## ## (UPDATE)

  LOOP AT LT_ROWS INTO LS_ROW. "## ####



    "# ### ### ##

    READ TABLE GT_DATA INTO GS_DATA INDEX LS_ROW-INDEX.



    IF SY-SUBRC = 0.

      UPDATE ZEDT03_MSEG

         SET LOEKZ = 'X' " DB ####, ##### ##

       WHERE MBLNR = GS_DATA-MBLNR "######

         AND MJAHR = GS_DATA-MJAHR "####

         AND EBELN = GS_DATA-EBELN "######

         AND EBELP = GS_DATA-EBELP."####



      IF SY-SUBRC <> 0.

        ROLLBACK WORK.

        MESSAGE '## ## # ### ######.' TYPE 'E'.

        RETURN.

      ENDIF.

    ENDIF.

  ENDLOOP.



  "4. ## ##

  COMMIT WORK AND WAIT.

  MESSAGE '## ### #######.' TYPE 'S'.



  "5. ## ##

  PERFORM GET_DATA_DIS."### # ##

  PERFORM REFRESH.

ENDFORM.