
*&---------------------------------------------------------------------*

*&  Include           ZWORK02_001_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_INIT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_INIT .



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



  "ALSM ## ### ### ##

  DATA: LT_TEMP_EXCEL TYPE TABLE OF ALSMEX_TABLINE,

        LS_TEMP_EXCEL LIKE LINE OF LT_TEMP_EXCEL.



  CALL FUNCTION 'ALSM_EXCEL_TO_INTERNAL_TABLE'

    EXPORTING

      FILENAME            = P_FILE

      I_BEGIN_COL         = 1       " ## 1## ### (A#)

      I_BEGIN_ROW         = 2       " ## 2## ### (## ##)

      I_END_COL           = 7       " ## 7## ### (G#)

      I_END_ROW           = 65000   " ## 65000###

    TABLES

      INTERN              = LT_TEMP_EXCEL  "## ### ##

    EXCEPTIONS

      INCONSISTENT_PARAMETERS = 1

      UPLOAD_OLE          = 2

      OTHERS              = 3.



  IF SY-SUBRC <> 0.

    MESSAGE '## #### ###### (ALSM).' TYPE 'E'.

    RETURN.

  ENDIF.



  SORT LT_TEMP_EXCEL BY ROW.



  LOOP AT LT_TEMP_EXCEL INTO LS_TEMP_EXCEL.



    AT NEW ROW.

      CLEAR GS_TCURR.

      GS_TCURR-MANDT = SY-MANDT.

    ENDAT.



    " # ##(COL) ### ## ### ## #####.

    CASE LS_TEMP_EXCEL-COL.

      WHEN 1. "1## #-> KURST

        GS_TCURR-KURST = LS_TEMP_EXCEL-VALUE.

      WHEN 2. "2## # -> FCURR

        GS_TCURR-FCURR = LS_TEMP_EXCEL-VALUE.

      WHEN 3. "3## # -> TCURR

        GS_TCURR-TCURR = LS_TEMP_EXCEL-VALUE.

      WHEN 4. "4## # -> GDATU

        GS_TCURR-GDATU = LS_TEMP_EXCEL-VALUE.

      WHEN 5. "5## # -> UKURS

        GS_TCURR-UKURS = LS_TEMP_EXCEL-VALUE.

      WHEN 6. "6## # -> FFACT

        GS_TCURR-FFACT = LS_TEMP_EXCEL-VALUE.

      WHEN 7. "7## # -> TFACT

        GS_TCURR-TFACT = LS_TEMP_EXCEL-VALUE.

    ENDCASE.



    AT END OF ROW.

      APPEND GS_TCURR TO GT_TCURR.

    ENDAT.

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



  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'KURST'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'FCURR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'TCURR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'GDATU'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'UKURS'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-DECIMALS = '5'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'FFACT'.

  GS_FIELDCAT-COLTEXT = '########'.

  GS_FIELDCAT-OUTPUTLEN = '20'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'TFACT'.

  GS_FIELDCAT-COLTEXT = '########'.

  GS_FIELDCAT-OUTPUTLEN = '20'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'AENAME'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'AEDATE'.

  GS_FIELDCAT-COLTEXT = '###'.

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



  CLEAR: GS_VARIANT.

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

      IT_OUTTAB                     = GT_TCURR

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

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CLASS_EVENT .



  "Register_edit : screen# ITAB ###

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

  CREATE OBJECT GO_EVENT.

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID.



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

*      others         = 2




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




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



  SET PF-STATUS 'ZSTATUS02'. "GUI ## ##

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.

      SCREEN-INPUT = '0'. "#### M# ### # ### ## ####

      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  VALIDATE_INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM VALIDATE_INPUT .

  IF P_DATE IS INITIAL OR P_FILE IS INITIAL. "### #### #### ##

    MESSAGE E000.

    EXIT.

  ENDIF.



  DATA: LV_FILE TYPE DBMSGORA-FILENAME, "###

        LV_EXTENSION TYPE SDBAD-FUNCT. "###

  LV_FILE = P_FILE.



  CALL FUNCTION 'SPLIT_FILENAME'

    EXPORTING

      LONG_FILENAME        = LV_FILE

   IMPORTING




*     PURE_FILENAME        =




     PURE_EXTENSION       = LV_EXTENSION

            .



  IF LV_EXTENSION <> 'xlsx' AND LV_EXTENSION <> 'xls'.

    MESSAGE '## ### ### #####.' TYPE 'E'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  EXCEL_TEMPLATE_DOWNLOAD

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM EXCEL_TEMPLATE_DOWNLOAD .



  DATA: LV_FOLDER_PATH TYPE STRING, "#### ### ## ##

        LV_FILE_PATH TYPE RLGRAP-FILENAME, "## ### ## ## ##

        LV_SEPARATOR TYPE C LENGTH 1, "## ## ###

        LV_FILENAME TYPE STRING VALUE 'template.xlsx', "### ###

        LV_OBJ_NAME TYPE W3OBJID VALUE 'Z_EXCEL_TEMPLATE', "SMW0# ### ## ##

        LS_KEY TYPE WWWDATATAB, "# ## # ###

        LV_RC TYPE I. "####



  "##### ### ### ##### #

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>DIRECTORY_BROWSE

    EXPORTING

      WINDOW_TITLE         = '#### ### ### #####.'




*      INITIAL_FOLDER       =




    CHANGING

      SELECTED_FOLDER      = LV_FOLDER_PATH




*    EXCEPTIONS

*      CNTL_ERROR           = 1

*      ERROR_NO_GUI         = 2

*      NOT_SUPPORTED_BY_GUI = 3

*      others               = 4




          .

  IF SY-SUBRC <> 0 OR LV_FOLDER_PATH IS INITIAL.

    MESSAGE '## ### #######.' TYPE 'I'.

    RETURN.

  ENDIF.



  "## ## ### ###

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>GET_FILE_SEPARATOR

    CHANGING

      FILE_SEPARATOR       = LV_SEPARATOR




*    EXCEPTIONS

*      NOT_SUPPORTED_BY_GUI = 1

*      ERROR_NO_GUI         = 2

*      CNTL_ERROR           = 3

*      others               = 4




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.



  "## ## ## ##

  CONCATENATE LV_FOLDER_PATH LV_SEPARATOR LV_FILENAME INTO LV_FILE_PATH.



  CLEAR: LS_KEY.

  LS_KEY-OBJID = LV_OBJ_NAME. "SMW0 ## ID

  LS_KEY-RELID = 'MI'. "MIME OBJECT



  "# ## #### ## ##

  CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'

    EXPORTING

      KEY               = LS_KEY

     DESTINATION       = LV_FILE_PATH

   IMPORTING

     RC                = LV_RC




*   CHANGING

*     TEMP              =




            .



  IF SY-SUBRC = 0 AND LV_RC = 0.

    MESSAGE '### #######.' TYPE 'I'.

  ELSE.

    MESSAGE '## ## # ### ######.' TYPE 'E'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DATA .



  LOOP AT GT_TCURR INTO GS_TCURR.

    GS_TCURR-KURST = 'M'. "#### M## ##

    GS_TCURR-GDATU = P_DATE. "##### ##

    GS_TCURR-AENAME = SY-UNAME. "###

    GS_TCURR-AEDATE = SY-DATUM. "###

    MODIFY GT_TCURR FROM GS_TCURR.



  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DATA_CHANGED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_DATA_CHANGED  text

*      -->P_ONF4  text

*      -->P_ONF4_BEFORE  text

*      -->P_ONF4_AFTER  text

*      -->P_UCOMM  text

*----------------------------------------------------------------------*




FORM ALV_HANDLER_DATA_CHANGED  USING    P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                        P_ONF4

                                        P_ONF4_BEFORE

                                        P_ONF4_AFTER

                                        P_UCOMM.

  DATA: LS_MODI TYPE LVC_S_MODI. "### # ## ###



  LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.



    READ TABLE GT_TCURR INTO GS_TCURR INDEX LS_MODI-ROW_ID.

    IF SY-SUBRC <> 0.

      CONTINUE.

    ENDIF.



    GS_TCURR-UKURS = LS_MODI-VALUE.



    "### ### ##

    MODIFY GT_TCURR FROM GS_TCURR INDEX LS_MODI-ROW_ID.



  ENDLOOP.

ENDFORM.