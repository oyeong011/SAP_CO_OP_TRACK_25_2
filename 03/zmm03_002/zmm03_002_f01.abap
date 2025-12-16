
*&---------------------------------------------------------------------*

*&  Include           ZMM03_002_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SELECTION-SCREEN_OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SELECTION-SCREEN_OUTPUT .

  LOOP AT SCREEN.

    IF P_CRE = 'X'.

      IF SCREEN-GROUP1 = 'DIS'.

        SCREEN-ACTIVE = '0'.

      ENDIF.

      IF SCREEN-GROUP1 = 'CRE'.

        SCREEN-REQUIRED = '2'.

      ENDIF.

    ELSE.

      IF SCREEN-GROUP1 = 'CRE'.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.



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

  "### ## SELECT

  SELECT  A~EBELN,     "PO ##

          A~BUKRS,   "####

          A~LIFNR,   "###

          A~BEDAT,   "###

          A~WAERS,   "## (#### ###)

          B~EBELP,   "## ##

          B~MATNR,   "## ##

          B~MAKTX,   "### (PO ## ### ##)

          B~MENGE,   "##

          B~MEINS,   "##

          B~BPRME,   "##

          B~PRDAT,   "###

          B~WERK,   "###

          B~LGORT,   "####

          C~MWSKZ    "#### (#### ##### ###)

    FROM ZEDT03_EKKO AS A "#### ##

    JOIN ZEDT03_EKPO AS B "#### ###

      ON A~EBELN = B~EBELN

    LEFT OUTER JOIN ZEDT03_LFM1 AS C "#### #### ### PO# ### #

      ON A~LIFNR = C~LIFNR

    WHERE A~LIFNR IN @S_LIFNR

      AND A~BUKRS IN @S_BUKRS

      AND A~EBELN IN @S_EBELN

    INTO CORRESPONDING FIELDS OF TABLE @GT_DATA.



  "#### ## ##

  IF SY-SUBRC <> 0.

    MESSAGE '### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING. "###(SELECTION SCREEN)# ####

  ENDIF.



  "###

  LOOP AT GT_DATA INTO GS_DATA.

    GS_DATA-ICON = ICON_LED_GREEN.

    GS_DATA-STATUS = GC_S.



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

DATA: LV_EDIT TYPE C.



  " 1. ###

  CLEAR: GS_FIELDCAT, GT_FIELDCAT.



  " 2.## ##(C)## ## ##(X), ## ##(D)## ## ##(Space)

  IF GV_MODE = GC_MODE_C.

    LV_EDIT = GC_X.

  ELSE.

    CLEAR LV_EDIT.

  ENDIF.



  " [1] ## (## ##### ### ## ##)

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 1.

  GS_FIELDCAT-FIELDNAME = 'EBELP'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-KEY       = 'X'.

  GS_FIELDCAT-JUST      = 'C'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT03_EKPO'. " ## ###

  GS_FIELDCAT-REF_FIELD = 'EBELP'.       " ## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " [2] #### (## ## -> ### ## ##)

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 2.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-EDIT      = LV_EDIT.       " ## ### # ## ##

  GS_FIELDCAT-REF_TABLE = 'ZEDT03_200'.  " ##### ### ##

  GS_FIELDCAT-REF_FIELD = 'ZMATNR'.      " F4 #### ## ##

  GS_FIELDCAT-JUST      = 'C'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " [3] ### (#### ## # ## ## -> ## ##)

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 3.

  GS_FIELDCAT-FIELDNAME = 'MAKTX'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT03_200'.

  GS_FIELDCAT-REF_FIELD = 'ZMATNAME'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " [4] PO ## (## ##)

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 4.

  GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-COLTEXT   = 'PO##'.

  GS_FIELDCAT-EDIT      = LV_EDIT.       "## ### # ## ##



  GS_FIELDCAT-REF_TABLE  = ''.      "## ### ##

  GS_FIELDCAT-REF_FIELD  = ''.      "## ## ##

  GS_FIELDCAT-QFIELDNAME = ''.      "## ## ## ##



  GS_FIELDCAT-DATATYPE   = 'DEC'.   "### ##: ## ##

  GS_FIELDCAT-INTLEN     = 13.      "## (MENGE_D ### ##)

  GS_FIELDCAT-OUTPUTLEN  = 13.      "## ## ##

  GS_FIELDCAT-DECIMALS   = 0.       "### 0##



  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " [5] ## (## ##)

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 5.

  GS_FIELDCAT-FIELDNAME  = 'BPRME'.

  GS_FIELDCAT-COLTEXT    = '##'.

  GS_FIELDCAT-EDIT       = LV_EDIT.



  GS_FIELDCAT-CFIELDNAME = 'WAERS'.  "## ### ##

  GS_FIELDCAT-REF_TABLE  = 'ZEDT03_EKPO'.

  GS_FIELDCAT-REF_FIELD  = 'BPRME'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.



  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " [6] ## (## ## -> ## ##)

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 6.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT03_EKPO'.

  GS_FIELDCAT-REF_FIELD = 'MEINS'.

  GS_FIELDCAT-JUST      = 'C'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " [7] ## (## ## -> ## ##)

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 7.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT03_200'.

  GS_FIELDCAT-REF_FIELD = 'WAERS'.

  GS_FIELDCAT-JUST      = 'C'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " [8] ####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 8.

  GS_FIELDCAT-FIELDNAME = 'MWSKZ'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-EDIT      = LV_EDIT.       " ## ### # ## ##

  GS_FIELDCAT-REF_TABLE = 'ZEDT03_LFM1'. " F4# ## ###

  GS_FIELDCAT-REF_FIELD = 'MWSKZ'.

  GS_FIELDCAT-JUST      = 'C'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " [9] ### (## ## -> ### ## ##)

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 9.

  GS_FIELDCAT-FIELDNAME = 'PRDAT'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-EDIT      = LV_EDIT.       " ## ### # ## ##

  GS_FIELDCAT-REF_TABLE = 'ZEDT03_EKPO'.

  GS_FIELDCAT-REF_FIELD = 'PRDAT'.

  GS_FIELDCAT-JUST      = 'C'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " [10] ### (## ## -> ##### ## ##)

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 10.

  GS_FIELDCAT-FIELDNAME = 'WERK'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-EDIT      = LV_EDIT.       " ## ### # ## ##

  GS_FIELDCAT-REF_TABLE = 'ZEDT03_EKPO'.

  GS_FIELDCAT-REF_FIELD = 'WERK'.

  GS_FIELDCAT-JUST      = 'C'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " [11] #### (## ## -> ##### ## ##)

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 11.

  GS_FIELDCAT-FIELDNAME = 'LGORT'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-EDIT      = LV_EDIT.       " ## ### # ## ##

  GS_FIELDCAT-REF_TABLE = 'ZEDT03_EKPO'.

  GS_FIELDCAT-REF_FIELD = 'LGORT'.

  GS_FIELDCAT-JUST      = 'C'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.






*   [12] ## ###

*  CLEAR GS_FIELDCAT.

*  GS_FIELDCAT-COL_POS   = 0.  " # ## ##

*  GS_FIELDCAT-FIELDNAME = 'ICON'.

*  GS_FIELDCAT-COLTEXT   = '##'.

*  GS_FIELDCAT-JUST      = 'C'.

*  GS_FIELDCAT-OUTPUTLEN = 4.

*  APPEND GS_FIELDCAT TO GT_FIELDCAT.




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

  GS_LAYOUT-SEL_MODE   = 'D'.       "# ## ## ##

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

  CLEAR : GS_SORT, GT_SORT.



  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'EBELP'.

  GS_SORT-UP = 'X'.

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

  "1. ### ### ## ##

  IF GO_EVENT IS INITIAL.

    CREATE OBJECT GO_EVENT.

  ENDIF.



  "2. ### #### ALV ### ##

  SET HANDLER GO_EVENT->HANDLE_DATA_CHANGED FOR GC_GRID.



  " 3. #### ## # ### ## #### ## ##### ##(## ### #### ## ## #### #### ###)

  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_ENTER.



  " 4. #### #### ## ### ##### ##

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

CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

  EXPORTING




*    I_BUFFER_ACTIVE               =

*    I_BYPASSING_BUFFER            =

*    I_CONSISTENCY_CHECK           =

*    I_STRUCTURE_NAME              =

*    IS_VARIANT                    =

*    I_SAVE                        =

*    I_DEFAULT                     = 'X'




    IS_LAYOUT                     = GS_LAYOUT




*    IS_PRINT                      =

*    IT_SPECIAL_GROUPS             =

*    IT_TOOLBAR_EXCLUDING          =

*    IT_HYPERLINK                  =

*    IT_ALV_GRAPHICS               =

*    IT_EXCEPT_QINFO               =

*    IR_SALV_ADAPTER               =




  CHANGING

    IT_OUTTAB                     = GT_DATA

    IT_FIELDCATALOG               = GT_FIELDCAT

    IT_SORT                       = GT_SORT




*    IT_FILTER                     =

*  EXCEPTIONS

*    INVALID_PARAMETER_COMBINATION = 1

*    PROGRAM_ERROR                 = 2

*    TOO_MANY_LINES                = 3

*    others                        = 4




        .

IF SY-SUBRC <> 0.




* Implement suitable error handling here




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

*&      Form  ALV_HANDLE_DATA_CHANGED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_ER_DATA_CHANGED  text

*----------------------------------------------------------------------*




FORM ALV_HANDLE_DATA_CHANGED  USING    PR_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL.

  DATA: LS_MOD_CELL TYPE LVC_S_MODI,

          LV_MATNR    TYPE ZEDT03_200-ZMATNR,

          LS_ZMAT     TYPE ZEDT03_200.

  FIELD-SYMBOLS: <LS_DATA> TYPE TY_DATA.



  "### ### ### ## ### ##

  LOOP AT PR_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MOD_CELL.



    CASE LS_MOD_CELL-FIELDNAME.

      "1. ####(MATNR)# ##### #

      WHEN 'MATNR'.

        "#### ### #### # ####

        CALL METHOD PR_DATA_CHANGED->GET_CELL_VALUE

          EXPORTING

            I_ROW_ID    = LS_MOD_CELL-ROW_ID

            I_FIELDNAME = 'MATNR'

          IMPORTING

            E_VALUE     = LV_MATNR.



        "##### ##

        SELECT SINGLE * INTO LS_ZMAT

          FROM ZEDT03_200

         WHERE ZMATNR = LV_MATNR.



        " [## ## ##] GT_DATA# ## ## ## ### ##### ##

        " ---------------------------------------------------------------------

        READ TABLE GT_DATA ASSIGNING <LS_DATA> INDEX LS_MOD_CELL-ROW_ID.



        IF SY-SUBRC = 0.

          "### #### ###, ##, ##, ## ## ##

          "MODIFY_CELL #### ## ### ## ###



          CALL METHOD PR_DATA_CHANGED->MODIFY_CELL

            EXPORTING I_ROW_ID = LS_MOD_CELL-ROW_ID I_FIELDNAME = 'MAKTX' I_VALUE = LS_ZMAT-ZMATNAME.



          CALL METHOD PR_DATA_CHANGED->MODIFY_CELL

            EXPORTING I_ROW_ID = LS_MOD_CELL-ROW_ID I_FIELDNAME = 'BPRME' I_VALUE = LS_ZMAT-STPRS.



          CALL METHOD PR_DATA_CHANGED->MODIFY_CELL

            EXPORTING I_ROW_ID = LS_MOD_CELL-ROW_ID I_FIELDNAME = 'MEINS' I_VALUE = LS_ZMAT-MEINS.



          CALL METHOD PR_DATA_CHANGED->MODIFY_CELL

            EXPORTING I_ROW_ID = LS_MOD_CELL-ROW_ID I_FIELDNAME = 'WAERS' I_VALUE = LS_ZMAT-WAERS.



          "#### ##### ##

          CALL METHOD PR_DATA_CHANGED->MODIFY_CELL

            EXPORTING I_ROW_ID = LS_MOD_CELL-ROW_ID I_FIELDNAME = 'ICON' I_VALUE = ICON_LED_GREEN.



          "### ###(GT_DATA)## # ##

          IF <LS_DATA> IS ASSIGNED.

            <LS_DATA>-MAKTX = LS_ZMAT-ZMATNAME.

            <LS_DATA>-BPRME = LS_ZMAT-STPRS.

            <LS_DATA>-MEINS = LS_ZMAT-MEINS.

            <LS_DATA>-WAERS = LS_ZMAT-WAERS.

            <LS_DATA>-ICON  = ICON_LED_GREEN.

          ENDIF.



        ELSE.



         " ### ### ## ### ##

         CALL METHOD PR_DATA_CHANGED->ADD_PROTOCOL_ENTRY

            EXPORTING

              I_MSGID     = '00'

              I_MSGNO     = '001'

              I_MSGTY     = 'E'

              I_MSGV1     = '#### ## #####.'

              I_FIELDNAME = 'MATNR'

              I_ROW_ID    = LS_MOD_CELL-ROW_ID.



          "#### ##### ##

          CALL METHOD PR_DATA_CHANGED->MODIFY_CELL

            EXPORTING I_ROW_ID = LS_MOD_CELL-ROW_ID I_FIELDNAME = 'ICON' I_VALUE = ICON_LED_RED.



          "### ##### ### ##

          IF <LS_DATA> IS ASSIGNED.

            <LS_DATA>-ICON = ICON_LED_RED.

          ENDIF.

        ENDIF.



    ENDCASE.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ADD_ITEM

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ADD_ITEM .

  DATA: LS_NEW TYPE TY_DATA.

  DATA: LV_MWSKZ TYPE ZEDT03_LFM1-MWSKZ. "#### ## ##



  "## ## ## ##

  DATA(LV_LINES) = LINES( GT_DATA ). " ## # ### #



  IF LV_LINES = 0.

    "#### ### ### 10### ##

    LS_NEW-EBELP = 10.

  ELSE.

    "#### ### # ### ## ### + 10

    READ TABLE GT_DATA INTO DATA(LS_LAST) INDEX LV_LINES.

    LS_NEW-EBELP = LS_LAST-EBELP + 10.

  ENDIF.



  "### ### ###(P_LIFNR)# #### ## #### ####

  IF P_LIFNR IS NOT INITIAL.

    SELECT SINGLE MWSKZ

      FROM ZEDT03_LFM1

      INTO LV_MWSKZ

     WHERE LIFNR = P_LIFNR.

  ENDIF.



  "### ##

  LS_NEW-ICON = ICON_LED_YELLOW. " '## #' ## ## (###)

  LS_NEW-STATUS = 'W'.           " Waiting

  LS_NEW-MWSKZ = LV_MWSKZ.



  "#### ## # ## ##

  APPEND LS_NEW TO GT_DATA.

  PERFORM REFRESH.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DELETE_ITEM

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DELETE_ITEM .

  DATA: LT_INDEX TYPE LVC_T_ROW, " ### # ### ## ###

        LS_INDEX TYPE LVC_S_ROW.



  "ALV## ### # ####

  CALL METHOD GC_GRID->GET_SELECTED_ROWS

    IMPORTING

      ET_INDEX_ROWS = LT_INDEX.



  "## # ### ##

  IF LT_INDEX IS INITIAL.

    MESSAGE '### ### #####.' TYPE 'S' DISPLAY LIKE 'E'.

    EXIT.

  ENDIF.



  "### #### ##

  SORT LT_INDEX BY INDEX DESCENDING.



  "## ##

  LOOP AT LT_INDEX INTO LS_INDEX.

    DELETE GT_DATA INDEX LS_INDEX-INDEX.

  ENDLOOP.



  "## ## # ###

  PERFORM REFRESH.

  MESSAGE '### ### #######.' TYPE 'S'.



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

  DATA: LS_EKKO TYPE ZEDT03_EKKO,        " DB ### ## ###

        LT_EKPO TYPE TABLE OF ZEDT03_EKPO, " DB ### ### ###

        LS_EKPO TYPE ZEDT03_EKPO.        " DB ### ### ###



  DATA: LV_ERROR     TYPE C,             " ## ###

        LV_MAX_EBELN TYPE ZEDT03_EKKO-EBELN,

        LV_NEW_EBELN TYPE ZEDT03_EKKO-EBELN.



  "0. ### ## ## ##

  IF GT_DATA IS INITIAL.

    MESSAGE '### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    EXIT.

  ENDIF.



  "1. ### ### ##

  CLEAR LV_ERROR.



  LOOP AT GT_DATA INTO GS_DATA.

    "(1) ### ##

    IF GS_DATA-MATNR IS INITIAL.

      MESSAGE '##### #####.' TYPE 'S' DISPLAY LIKE 'E'.

      LV_ERROR = 'X'. "## ## ##

      EXIT.           "## ## ##

    ENDIF.



    "(2) ### ##: ###(P_BEDAT)## ### ### #

    IF GS_DATA-PRDAT < P_BEDAT.

      MESSAGE '#### ##### ## # ####.' TYPE 'S' DISPLAY LIKE 'E'.

      LV_ERROR = 'X'. "## ## ##

      EXIT.

    ENDIF.



    "(3) ###/#### ### ## (##### ZEDT03_200 ##)

    "## ### ### #### ##### ### ##### ##

    SELECT SINGLE 'X'

      FROM ZEDT03_200

      INTO @DATA(LV_EXISTS)

     WHERE ZMATNR = @GS_DATA-MATNR "#### ###

       AND WERKS  = @GS_DATA-WERK "# ### # #### ###

       AND LGORT  = @GS_DATA-LGORT. "# ### # ##### ###



    IF SY-SUBRC <> 0.

      MESSAGE '## ### #### ###/##### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

      LV_ERROR = 'X'. "## ## ##

      EXIT.

    ENDIF.



  ENDLOOP.



  " ### #### #### ### ##

  IF LV_ERROR = 'X'.

    MESSAGE '## ### ## ### #####.' TYPE 'S' DISPLAY LIKE 'E'.

    EXIT. " ## #### #### ## FORM ##

  ENDIF.





  "2. PO ## ## ##

  "## ## # ### ###

  SELECT SINGLE MAX( EBELN )

    FROM ZEDT03_EKKO

    INTO @LV_MAX_EBELN.



  LV_NEW_EBELN = LV_MAX_EBELN + 1.



  "## #### ### ### 1# #### ### ## (#: 1000000001)

  IF LV_NEW_EBELN = 1.

    LV_NEW_EBELN = '1000000001'.

  ENDIF.



  "3. DB ## ### ##



  "## ### : SELECTION SCREEN #

  LS_EKKO-EBELN = LV_NEW_EBELN. " ### ##

  LS_EKKO-BUKRS = P_BUKRS.      " ####

  LS_EKKO-LIFNR = P_LIFNR.      " ###

  LS_EKKO-BEDAT = P_BEDAT.      " ###



  "## (WAERS) : ### ### ## ### ## ### ##

  READ TABLE GT_DATA INTO DATA(LS_FIRST_ITEM) INDEX 1.

  IF SY-SUBRC = 0.

    LS_EKKO-WAERS = LS_FIRST_ITEM-WAERS.

  ENDIF.



  "####, ##### #### ###(LFM1)## ####

  SELECT SINGLE EKORG, EKGRP FROM ZEDT03_LFM1

                             INTO (@LS_EKKO-EKORG, @LS_EKKO-EKGRP)

                             WHERE LIFNR = @P_LIFNR.



  "### ### : ALV GRID #

  LOOP AT GT_DATA INTO GS_DATA.

    CLEAR LS_EKPO.

    MOVE-CORRESPONDING GS_DATA TO LS_EKPO.

    LS_EKPO-EBELN = LV_NEW_EBELN. " ### PO ## ##



    APPEND LS_EKPO TO LT_EKPO.

  ENDLOOP.



  "4. DB INSERT ##

  INSERT ZEDT03_EKKO FROM LS_EKKO.         "## ##

  INSERT ZEDT03_EKPO FROM TABLE LT_EKPO.   "### ## ##



  IF SY-SUBRC = 0.

    COMMIT WORK. " DB ## ##



    " ## ### (PO## ####)

    DATA: LV_MSG_TEXT TYPE STRING.

    LV_MSG_TEXT = |##### #######. ##: { LV_NEW_EBELN }|.  "### ### ##

    MESSAGE LV_MSG_TEXT TYPE 'S'.  "E### ##



    " ## # ## ###: #### ### # #### ###

    CLEAR GT_DATA.

    PERFORM REFRESH.

  ELSE.

    ROLLBACK WORK. " ## # ####

    MESSAGE '## # ### ######.' TYPE 'E'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SELECTION_SCREEN_CHECK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SELECTION_SCREEN_CHECK .

  "####(ONLI) + #### # # ##

  IF SSCRFIELDS-UCOMM = 'ONLI' AND P_CRE = 'X'.

    "1. ### ##

    IF P_BUKRS IS INITIAL.

      MESSAGE '##### #####.' TYPE 'E'.

    ELSEIF P_LIFNR IS INITIAL.

      MESSAGE '#### #####.' TYPE 'E'.

    ELSEIF P_BEDAT IS INITIAL.

      MESSAGE '#### #####.' TYPE 'E'.

    ENDIF.



    "2. ### ### ### ##(## #### #######, ZEDT03_LFM1)

    DATA : LV_LOEVM TYPE ZEDT03_LFM1-LOEVM.

    SELECT SINGLE LOEVM FROM ZEDT03_LFM1

                      WHERE LIFNR = @P_LIFNR

                      INTO @LV_LOEVM.

    IF SY-SUBRC <> 0.

      "1) #### ## ## ##

      MESSAGE '#### ## ######.' TYPE 'E'.

    ELSEIF LV_LOEVM = 'X'.

      "2) #### ### ### # ##

      MESSAGE '### ######. ### # ####.' TYPE 'E'.

    ENDIF.



    "3. GV_MODE ##### ## ## ## ##

    GV_MODE = GC_MODE_C. "##

  "####(ONLI) + #### # #

  ELSEIF SSCRFIELDS-UCOMM = 'ONLI' AND P_DIS = 'X'.

    GV_MODE = GC_MODE_D. "##

  ENDIF.



ENDFORM.