
*&---------------------------------------------------------------------*

*&  Include           ZMMR13_002_F01

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

  GS_EXCLUDE = CL_GUI_ALV_GRID=>MC_FC_LOC_INSERT_ROW. "ALV ## ##"

  APPEND GS_EXCLUDE TO GT_EXCLUDE.



  GS_EXCLUDE = CL_GUI_ALV_GRID=>MC_FC_LOC_DELETE_ROW.

  APPEND GS_EXCLUDE TO GT_EXCLUDE.



  GS_EXCLUDE = CL_GUI_ALV_GRID=>MC_FC_LOC_APPEND_ROW.

  APPEND GS_EXCLUDE TO GT_EXCLUDE.



  GS_EXCLUDE = CL_GUI_ALV_GRID=>MC_FC_LOC_COPY_ROW.

  APPEND GS_EXCLUDE TO GT_EXCLUDE.



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

FORM CREATE_OBJECT.

CREATE OBJECT GC_CUSTOM

  EXPORTING




*    PARENT                      =




    CONTAINER_NAME              = 'CON01'




*    STYLE                       =

*    LIFETIME                    = lifetime_default

*    REPID                       =

*    DYNNR                       =

*    NO_AUTODEF_PROGID_DYNNR     =

*  EXCEPTIONS

*    CNTL_ERROR                  = 1

*    CNTL_SYSTEM_ERROR           = 2

*    CREATE_ERROR                = 3

*    LIFETIME_ERROR              = 4

*    LIFETIME_DYNPRO_DYNPRO_LINK = 5

*    others                      = 6




    .

IF SY-SUBRC <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




ENDIF.

CREATE OBJECT GC_GRID

  EXPORTING




*    I_SHELLSTYLE      = 0

*    I_LIFETIME        =




    I_PARENT          = GC_CUSTOM




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

IF SY-SUBRC <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




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

  GS_FIELDCAT-FIELDNAME = 'EBELP'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-KEY       = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 2.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 15.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 3.

  GS_FIELDCAT-FIELDNAME = 'MATNAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-OUTPUTLEN = 12.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 4.

  GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-COLTEXT = 'PO##'.

  GS_FIELDCAT-REF_TABLE = 'EBAN'.

  GS_FIELDCAT-REF_FIELD = 'MENGE'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 5.

  GS_FIELDCAT-FIELDNAME = 'STPRS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 6.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 7.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 9.

  GS_FIELDCAT-FIELDNAME = 'MWSKZ'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-EDIT = 'X'.




*  GS_FIELDCAT-REF_TABLE = 'ZEKPO_13'.

*  GS_FIELDCAT-REF_FIELD = 'MWSKZ'.




  GS_FIELDCAT-OUTPUTLEN = 6.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 10.

  GS_FIELDCAT-FIELDNAME = 'PRDAT'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 11.

  GS_FIELDCAT-FIELDNAME = 'WERKS'.

  GS_FIELDCAT-SCRTEXT_M = '###'..

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 12.

  GS_FIELDCAT-FIELDNAME = 'LGORT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

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

  GS_LAYOUT-ZEBRA = 'X'.

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

  SET HANDLER GO_EVENT->HANDLE_TOOLBAR FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLE_USER_COMMAND FOR GC_GRID.

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

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED_FINISHED FOR GC_GRID.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_TOOLBAR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_OBJECT  text

*      -->P_E_INTERACTIVE  text

*----------------------------------------------------------------------*




FORM ALV_HANDLER_TOOLBAR USING P_OBJECT TYPE REF TO CL_ALV_EVENT_TOOLBAR_SET

                               P_INTERACTIVE.



    DATA : LS_TOOLBAR TYPE STB_BUTTON.



    CLEAR LS_TOOLBAR.

    LS_TOOLBAR-FUNCTION  = 'ADD_ROW'.

    LS_TOOLBAR-ICON      = ICON_INSERT_ROW.

    LS_TOOLBAR-BUTN_TYPE = 0.

    LS_TOOLBAR-TEXT      = '####'.

    LS_TOOLBAR-QUICKINFO = '# ## #####'.

    APPEND LS_TOOLBAR TO P_OBJECT->MT_TOOLBAR.



    CLEAR LS_TOOLBAR.

    LS_TOOLBAR-FUNCTION  = 'DEL_ROW'.

    LS_TOOLBAR-ICON      = ICON_DELETE_ROW.

    LS_TOOLBAR-BUTN_TYPE = 0.

    LS_TOOLBAR-TEXT      = '####'.

    LS_TOOLBAR-QUICKINFO = '# ## #####'.

    APPEND LS_TOOLBAR TO P_OBJECT->MT_TOOLBAR.



    CLEAR LS_TOOLBAR.

    LS_TOOLBAR-FUNCTION  = 'CREATE_PO'.

    LS_TOOLBAR-ICON      = ICON_GENERATE.

    LS_TOOLBAR-BUTN_TYPE = 0.

    LS_TOOLBAR-TEXT      = 'PO##'.

    APPEND LS_TOOLBAR TO P_OBJECT->MT_TOOLBAR.



ENDFORM.

FORM ALV_HANDLER_USER_COMMAND USING P_UCOMM.

  CASE P_UCOMM.

    WHEN 'ADD_ROW'.

      PERFORM ADD_ROW.



    WHEN 'DEL_ROW'.

      PERFORM DEL_ROW.



    WHEN 'CREATE_PO'.

      PERFORM SAVE_PO_DATA.

   ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DATA_CHANGED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_ER_DATA_CHANGED  text

*      -->P_E_ONF4  text

*      -->P_E_ONF4_BEFORE  text

*      -->P_E_ONF4_AFTER  text

*      -->P_E_UCOMM  text

*----------------------------------------------------------------------*




FORM ALV_HANDLER_DATA_CHANGED  USING P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                     P_ONF4

                                     P_ONF4_BEFORE

                                     P_ONF4_AFTER

                                     P_UCOMM.

  DATA : LS_MODI TYPE LVC_S_MODI.

  DATA : LS_MARA TYPE ZMARA_13.

  DATA : LV_MATNR TYPE MATNR.



  CLEAR : LS_MODI, LS_MARA, LV_MATNR.



  LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.

    IF LS_MODI-FIELDNAME = 'MATNR'.                   "####"

      LV_MATNR = LS_MODI-VALUE.

      SHIFT LV_MATNR LEFT DELETING LEADING '0'.       "LEADING 0 ##"

      SELECT SINGLE * FROM ZMARA_13

        INTO CORRESPONDING FIELDS OF LS_MARA

        WHERE MATNR = LV_MATNR.



      IF LS_MARA IS INITIAL. "### ##### ## ## ### ###"

        MESSAGE '### ##### ######' TYPE 'S' DISPLAY LIKE 'E'.

        CALL METHOD P_DATA_CHANGED->MODIFY_CELL

          EXPORTING

            I_ROW_ID    = LS_MODI-ROW_ID




*            I_TABIX     =




            I_FIELDNAME = 'MATNR'

            I_VALUE     = ''.

            .

        CONTINUE.

      ENDIF.

      READ TABLE GT_EKPO INTO GS_EKPO INDEX LS_MODI-ROW_ID.

      IF SY-SUBRC = 0.

        MOVE-CORRESPONDING LS_MARA TO GS_EKPO.

        GS_EKPO-PRDAT = GS_EKKO-BEDAT.

        MODIFY GT_EKPO FROM GS_EKPO INDEX LS_MODI-ROW_ID.

        CLEAR GS_EKPO.

      ENDIF.

    ENDIF.

  ENDLOOP.

  PERFORM REFRESH.                                     "######"

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DATA_CHANGED_FINISHED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_MODIFIED  text

*      -->P_ET_GOOD_CELLS  text

*----------------------------------------------------------------------*




FORM ALV_DATA_CHANGED_FINISHED USING P_MODIFIED

                                     PT_GOOD_CELLS TYPE LVC_T_MODI.

  DATA : LS_MODI TYPE LVC_S_MODI.



  CLEAR : LS_MODI.



  LOOP AT PT_GOOD_CELLS INTO LS_MODI.




*    IF LS_MODI-FIELDNAME = 'ZTEL'.

*      READ TABLE GT_STUDENT INTO GS_STUDENT INDEX LS_MODI-ROW_ID.

*

*      IF GS_STUDENT-ICON NE ICON_LED_GREEN.

*        DELETE TABLE GT_STUDENT FROM GS_STUDENT.

*      ENDIF.

*      CLEAR GS_STUDENT.

*    ENDIF.




  ENDLOOP.

  PERFORM REFRESH.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




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

*      IS_LAYOUT                     =

*      IS_PRINT                      =

*      IT_SPECIAL_GROUPS             =




      IT_TOOLBAR_EXCLUDING          = GT_EXCLUDE




*      IT_HYPERLINK                  =

*      IT_ALV_GRAPHICS               =

*      IT_EXCEPT_QINFO               =

*      IR_SALV_ADAPTER               =




    CHANGING

      IT_OUTTAB                     = GT_EKPO

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



  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

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

*&      Form  CHECK_MANDATORY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_MANDATORY.



  CLEAR : GS_LFA1.

  SELECT SINGLE * FROM ZLFA1_13

    INTO CORRESPONDING FIELDS OF GS_LFA1  "SCREEN ## ###### ##"

    WHERE LIFNR = P2 OR LIFNR = P4.



  IF GS_LFA1 IS INITIAL OR SY-SUBRC <> 0.

    MESSAGE '#### ###### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  GS_EKKO-BUKRS = P1.     "####"

  IF P_R1 = 'X'.

    GS_EKKO-LIFNR = P2.   "###(=#####)"

    GS_EKKO-BEDAT = P3.   "###"

  ELSEIF P_R2 = 'X'.

    GS_EKKO-LIFNR = P4.   "###(=#####)"

    GS_EKKO-EBELN = P5.   "PO ##"

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

  SELECT SINGLE * FROM ZLFA1_13 AS A  "## ## ### ## ### 1#1 #####"

  INNER JOIN ZLFB1_13 AS B ON A~LIFNR = B~LIFNR

  INNER JOIN ZLFM1_13 AS C ON A~LIFNR = C~LIFNR

  INTO CORRESPONDING FIELDS OF GS_EKKO

  WHERE A~LIFNR = GS_EKKO-LIFNR    "#####"

  AND B~BUKRS = GS_EKKO-BUKRS.     "####"

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ADD_ROW

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ADD_ROW.

  DATA : LV_LINE TYPE I,

         LS_EKPO LIKE GS_EKPO.



  CLEAR LV_LINE.

  LOOP AT GT_EKPO INTO GS_EKPO.

    IF GS_EKPO-EBELP > LV_LINE.

      LV_LINE = GS_EKPO-EBELP.

    ENDIF.

  ENDLOOP. "### #### #### # #"



  CLEAR : LS_EKPO.

  LS_EKPO-EBELP = LV_LINE + 10.



  APPEND LS_EKPO TO GT_EKPO.



  PERFORM REFRESH.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DEL_ROW

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DEL_ROW.

  DATA: LS_ROW TYPE LVC_S_ROW,            "# ##"

        LV_ROW TYPE LVC_S_ROID-ROW_ID,    "## ##"

        LV_IDX TYPE SY-TABIX.             "##### INDEX



  CALL METHOD GC_GRID->GET_CURRENT_CELL   "## ## ## ####"

    IMPORTING




*      E_ROW     =

*      E_VALUE   =

*      E_COL     =




      ES_ROW_ID = LS_ROW




*      ES_COL_ID =

*      ES_ROW_NO =




      .

  LV_ROW = LS_ROW-INDEX.



  IF LV_ROW IS INITIAL OR LV_ROW > LINES( GT_EKPO ).

    MESSAGE '### ## ######.' TYPE 'I'.

    RETURN.

  ENDIF.



  DELETE GT_EKPO INDEX LV_ROW.



  PERFORM REFRESH.



  CALL METHOD GC_GRID->SET_CURRENT_CELL_VIA_ID "## # ## ## ##"

    EXPORTING

      IS_ROW_ID    = VALUE LVC_S_ROW( INDEX = LV_ROW - 1 )

      IS_COLUMN_ID = VALUE LVC_S_COL( FIELDNAME = 'EBELP' ).

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_PO_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SAVE_PO_DATA.

  DATA : LV_OK TYPE C.

  DATA : LV_MAX_EBELN TYPE EBELN.

  DATA : LS_EKPO TYPE ZEKPO_13,

         LT_EKPO LIKE TABLE OF LS_EKPO.



  IF GT_EKPO IS INITIAL.

    MESSAGE '### ### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    RETURN.

  ENDIF.



  CALL METHOD GC_GRID->CHECK_CHANGED_DATA.  "## ## # ## ## ##"



  PERFORM CHECK_DATA CHANGING LV_OK.



  IF LV_OK = ABAP_FALSE.

    MESSAGE '### ### ## ### #####.' TYPE 'S' DISPLAY LIKE 'E'.

    RETURN.

  ENDIF.



  SELECT MAX( EBELN ) INTO LV_MAX_EBELN  "###### ## ##"

    FROM ZEKPO_13.

  IF LV_MAX_EBELN IS INITIAL.

    LV_MAX_EBELN = '4500000001'. "#### ### ### 1### ##"

  ELSE.

    LV_MAX_EBELN = LV_MAX_EBELN + 1. "### ## + 1

  ENDIF.

  GS_EKKO-EBELN = LV_MAX_EBELN.



  LOOP AT GT_EKPO INTO GS_EKPO.

    CLEAR LS_EKPO.

    MOVE-CORRESPONDING GS_EKPO TO LS_EKPO.



    LS_EKPO-MANDT = SY-MANDT.

    LS_EKPO-EBELN = LV_MAX_EBELN.

    APPEND LS_EKPO TO LT_EKPO.

  ENDLOOP.



  INSERT ZEKKO_13 FROM GS_EKKO.       "## ##"

  IF SY-SUBRC <> 0.

    ROLLBACK WORK.

    MESSAGE '## ### ## ##' TYPE 'S' DISPLAY LIKE 'E'.

    RETURN.

  ENDIF.



  INSERT ZEKPO_13 FROM TABLE LT_EKPO. "#####"

  IF SY-SUBRC <> 0.

    ROLLBACK WORK.

    MESSAGE '## ### ## ##' TYPE 'S' DISPLAY LIKE 'E'.

    RETURN.

  ENDIF.



  COMMIT WORK.

  MESSAGE |## PO#(#)## { LV_MAX_EBELN } ## ######| TYPE 'S'.

  LEAVE TO SCREEN 0.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      <--P_LV_OK  text

*----------------------------------------------------------------------*




FORM CHECK_DATA CHANGING P_OK.

  DATA : LV_CNT TYPE I.

  DATA : LV_MATNR TYPE MATNR.



  P_OK = ABAP_TRUE.

  LOOP AT GT_EKPO INTO GS_EKPO.

    IF GS_EKPO-PRDAT < SY-DATUM.

      MESSAGE '#### ### # ####.' TYPE 'S' DISPLAY LIKE 'E'.

      P_OK = ABAP_FALSE.

      EXIT.

    ENDIF.

    LV_MATNR = GS_EKPO-MATNR.

    SHIFT LV_MATNR LEFT DELETING LEADING '0'.       "LEADING 0 ##"

    SELECT COUNT( * ) INTO LV_CNT

      FROM ZMARA_13

     WHERE MATNR = LV_MATNR

       AND WERKS = GS_EKPO-WERKS

       AND LGORT = GS_EKPO-LGORT.

    IF LV_CNT = 0.

      MESSAGE '## ### ### ###/##### #### #####.' TYPE 'S' DISPLAY LIKE 'E'.

      P_OK = ABAP_FALSE.

      EXIT.

    ENDIF.

  ENDLOOP.

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

  SELECT SINGLE * FROM ZEKKO_13

    INTO CORRESPONDING FIELDS OF GS_EKKO  "### ##### ##"

    WHERE LIFNR = P4        "#####"

      AND BUKRS = P1        "####"

      AND EBELN = P5.       "PO##"



  SELECT * FROM ZEKPO_13

    INTO CORRESPONDING FIELDS OF TABLE GT_EKPO "### #### # ##"

    WHERE EBELN = P5.       "PO##"

  LOOP AT GT_EKPO INTO GS_EKPO.

    CLEAR GS_DISPLAY.

    MOVE-CORRESPONDING GS_EKKO TO GS_DISPLAY.

    MOVE-CORRESPONDING GS_EKPO TO GS_DISPLAY.

    GS_DISPLAY-WAERS = GS_EKKO-WAERS.   "GT_EKPO# WAERS# ### ### ##### ### ### ###"

    APPEND GS_DISPLAY TO GT_DISPLAY.

  ENDLOOP.

  IF GT_DISPLAY IS INITIAL.

    MESSAGE '#### ####### ####' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT2 .

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

CREATE OBJECT GC_GRID

  EXPORTING




*    I_SHELLSTYLE      = 0

*    I_LIFETIME        =




    I_PARENT          = GC_DOCKING




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

IF SY-SUBRC <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




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




FORM FIELD_CATALOG2.



  REFRESH GT_FIELDCAT.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 1.

  GS_FIELDCAT-FIELDNAME = 'EBELN'.

  GS_FIELDCAT-SCRTEXT_M = '######'.

  GS_FIELDCAT-KEY       = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 2.

  GS_FIELDCAT-FIELDNAME = 'BUKRS'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = 4.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 3.

  GS_FIELDCAT-FIELDNAME = 'EKORG'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = 4.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 4.

  GS_FIELDCAT-FIELDNAME = 'EKGRP'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = 4.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 5.

  GS_FIELDCAT-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT-SCRTEXT_M = '#####'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 6.

  GS_FIELDCAT-FIELDNAME = 'BEDAT'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 7.

  GS_FIELDCAT-FIELDNAME = 'PRDAT'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 8.

  GS_FIELDCAT-FIELDNAME = 'EBELP'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-KEY       = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 5.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 9.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = 18.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 10.

  GS_FIELDCAT-FIELDNAME = 'MATNAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-OUTPUTLEN = 20.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 11.

  GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-SCRTEXT_M = 'PO##'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'. "## ## ##

  GS_FIELDCAT-OUTPUTLEN = 13.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 12.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-OUTPUTLEN = 3.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 13.

  GS_FIELDCAT-FIELDNAME = 'STPRS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'. "## ## ##

  GS_FIELDCAT-OUTPUTLEN = 15.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 14.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-OUTPUTLEN = 5.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 15.

  GS_FIELDCAT-FIELDNAME = 'WERKS'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-OUTPUTLEN = 4.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 16.

  GS_FIELDCAT-FIELDNAME = 'LGORT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = 4.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY2.

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY




*    EXPORTING

*      I_BUFFER_ACTIVE               =

*      I_BYPASSING_BUFFER            =

*      I_CONSISTENCY_CHECK           =

*      I_STRUCTURE_NAME              =

*      IS_VARIANT                    =

*      I_SAVE                        =

*      I_DEFAULT                     = 'X'

*      IS_LAYOUT                     =

*      IS_PRINT                      =

*      IT_SPECIAL_GROUPS             =

*      IT_TOOLBAR_EXCLUDING          =

*      IT_HYPERLINK                  =

*      IT_ALV_GRAPHICS               =

*      IT_EXCEPT_QINFO               =

*      IR_SALV_ADAPTER               =




    CHANGING

      IT_OUTTAB                     = GT_DISPLAY

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