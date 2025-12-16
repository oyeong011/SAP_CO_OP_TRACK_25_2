
*&---------------------------------------------------------------------*

*&  Include           ZWORK03_001_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  F4_FILE_OPEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM F4_FILE_OPEN .

  DATA : LT_FILE TYPE FILETABLE, "#### ### ## ### ## ###

         LV_RC TYPE I, "### ## ### #### ##

         LV_FILTER TYPE STRING, "## ## ### (### ## # ##)

         LS_FILE TYPE FILE_TABLE. "LT_FILE# # # (## ##)



  LV_FILTER = 'Excel (*.xlsx;*.xls)|*.xlsx;*.xls|All files (*.*)|*.*'.

              "        ###        | ### ##    |    ###       |### ##

              "###: ##### #### ###

              "### ## : ### ### ## ### ## *###### ####

              "*.*# ## ### ##### #

              "### ### ## ## ##, ### ### ## ## ###

              "#### ## ### # # ### ### # ##.



     CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_OPEN_DIALOG

       EXPORTING

         WINDOW_TITLE            = '## ### #####.' "##### ## ##

         DEFAULT_EXTENSION       = 'xlsx' "## ###




*         DEFAULT_FILENAME        =




         FILE_FILTER             = LV_FILTER "##




*         WITH_ENCODING           =

*         INITIAL_DIRECTORY       =




         MULTISELECTION          = ABAP_FALSE "ABAP_FALSE : ### ## ##

       CHANGING

         FILE_TABLE              = LT_FILE "### ## ### ## ## ###

         RC                      = LV_RC. "## ### ## ##

       IF LV_RC > 0 AND LT_FILE IS NOT INITIAL. "### ## 1# ## #### #### ####

         READ TABLE LT_FILE INDEX 1 INTO LS_FILE. "### ### ##

         IF SY-SUBRC = 0.

           P_FILE = LS_FILE-FILENAME.

         ENDIF.

       ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DOWNLOAD_TEMPLETE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DOWNLOAD_TEMPLETE .

  "### ##~ MIME#? : SAP ### #### #### #### #### ### ### ##.

  DATA : LT_QUERY_STRING TYPE STANDARD TABLE OF W3QUERY, "## ####

         LT_HTML TYPE STANDARD TABLE OF W3HTML,

         LT_MIME TYPE STANDARD TABLE OF W3MIME, "#### ###(## ## ##) ## ## ###

         LV_RET_CODE TYPE W3PARAM-RET_CODE, "## ## # ## ##

         LV_CONT_TYPE TYPE W3PARAM-CONT_TYPE, "MIME ##

         LV_CONT_LEN TYPE W3PARAM-CONT_LEN, "### ## ##

         LV_FILENAME TYPE STRING, "## ###

         LV_PATH TYPE STRING, "#### ##

         LV_FULLPATH TYPE STRING. "## ##



  "1. OBJECT_ID #### ##

  APPEND VALUE #( NAME = '_OBJECT_ID'

                  VALUE = 'ZWORK03_TEMPLATE' ) TO LT_QUERY_STRING. "## #### #### ## ##



  "2. MIME ###### ### ##

  CALL FUNCTION 'WWW_GET_MIME_OBJECT' "MIME #### #### ## ##

    TABLES

      QUERY_STRING              = LT_QUERY_STRING "## ### ##, # ID# ## ##### ####.

      HTML                      = LT_HTML " HTML# ## HTML ### ####.

      MIME                      = LT_MIME "## #### ###(## ###)# # #### ## ### ####.

    CHANGING

      RETURN_CODE               = LV_RET_CODE

      CONTENT_TYPE              = LV_CONT_TYPE "### MIME ##

      CONTENT_LENGTH            = LV_CONT_LEN  "### ## ## ##

    EXCEPTIONS

     OBJECT_NOT_FOUND          = 1

     PARAMETER_NOT_FOUND       = 2

     OTHERS                    = 3

            .

  IF SY-SUBRC <> 0 OR LT_MIME IS INITIAL.

    MESSAGE '#### ## # ####.' TYPE 'E'.

    RETURN.

  ENDIF.



  "3. ### ## ## ##

  LV_FILENAME = 'Template.xlsx'.



  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_SAVE_DIALOG

    EXPORTING

      WINDOW_TITLE              = '## ### ##' "##### # ##

      DEFAULT_EXTENSION         = 'xlsx'        "## ###

      DEFAULT_FILE_NAME         = LV_FILENAME   "## ###




*      WITH_ENCODING             =




      FILE_FILTER               = 'Excel (*.xlsx)|*.xlsx' "## ## ##




*      INITIAL_DIRECTORY         =

*      PROMPT_ON_OVERWRITE       = 'X'




    CHANGING

      FILENAME                  = LV_FILENAME "#### ### ## ##

      PATH                      = LV_PATH     "### ## ##

      FULLPATH                  = LV_FULLPATH " ## ##




*      USER_ACTION               =

*      FILE_ENCODING             =

*    EXCEPTIONS

*      CNTL_ERROR                = 1

*      ERROR_NO_GUI              = 2

*      NOT_SUPPORTED_BY_GUI      = 3

*      INVALID_DEFAULT_FILE_NAME = 4

*      others                    = 5




          .

  IF LV_FULLPATH IS INITIAL.

    MESSAGE '### #######.' TYPE 'S'.

    RETURN.

  ENDIF.



  "4. ### #### ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>GUI_DOWNLOAD "SAP #### ### PC# #### # ## ###

    EXPORTING

      BIN_FILESIZE              = LV_CONT_LEN

      FILENAME                  = LV_FULLPATH

      FILETYPE                  = 'BIN'       "#### ### ### ###### ##




*      APPEND                    = SPACE

*      WRITE_FIELD_SEPARATOR     = SPACE

*      HEADER                    = '00'

*      TRUNC_TRAILING_BLANKS     = SPACE

*      WRITE_LF                  = 'X'

*      COL_SELECT                = SPACE

*      COL_SELECT_MASK           = SPACE

*      DAT_MODE                  = SPACE

*      CONFIRM_OVERWRITE         = SPACE

*      NO_AUTH_CHECK             = SPACE

*      CODEPAGE                  = SPACE

*      IGNORE_CERR               = ABAP_TRUE

*      REPLACEMENT               = '#'

*      WRITE_BOM                 = SPACE

*      TRUNC_TRAILING_BLANKS_EOL = 'X'

*      WK1_N_FORMAT              = SPACE

*      WK1_N_SIZE                = SPACE

*      WK1_T_FORMAT              = SPACE

*      WK1_T_SIZE                = SPACE

*      SHOW_TRANSFER_STATUS      = 'X'

*      FIELDNAMES                =

*      WRITE_LF_AFTER_LAST_LINE  = 'X'

*      VIRUS_SCAN_PROFILE        = '/SCET/GUI_DOWNLOAD'

*    IMPORTING

*      FILELENGTH                =




    CHANGING

      DATA_TAB                  = LT_MIME    "## #### #### #### ## ###




*    EXCEPTIONS

*      FILE_WRITE_ERROR          = 1

*      NO_BATCH                  = 2

*      GUI_REFUSE_FILETRANSFER   = 3

*      INVALID_TYPE              = 4

*      NO_AUTHORITY              = 5

*      UNKNOWN_ERROR             = 6

*      HEADER_NOT_ALLOWED        = 7

*      SEPARATOR_NOT_ALLOWED     = 8

*      FILESIZE_NOT_ALLOWED      = 9

*      HEADER_TOO_LONG           = 10

*      DP_ERROR_CREATE           = 11

*      DP_ERROR_SEND             = 12

*      DP_ERROR_WRITE            = 13

*      UNKNOWN_DP_ERROR          = 14

*      ACCESS_DENIED             = 15

*      DP_OUT_OF_MEMORY          = 16

*      DISK_FULL                 = 17

*      DP_TIMEOUT                = 18

*      FILE_NOT_FOUND            = 19

*      DATAPROVIDER_EXCEPTION    = 20

*      CONTROL_FLUSH_ERROR       = 21

*      NOT_SUPPORTED_BY_GUI      = 22

*      ERROR_NO_GUI              = 23

*      others                    = 24




          .

  MESSAGE |#### #######: { LV_FULLPATH }| TYPE 'S'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA USING P_ZDATE TYPE ZTCURR03-GDATU.

  DATA : LT_EXCEL TYPE STANDARD TABLE OF ALSMEX_TABLINE,

         LS_EXCEL TYPE ALSMEX_TABLINE,

         LV_CURR_ROW TYPE I. "## ## ## ### #(ROW)



  CLEAR : GT_CURR.



  "1. ## ### LT_EXCEL #### ##

  CALL FUNCTION 'ALSM_EXCEL_TO_INTERNAL_TABLE'

    EXPORTING

      FILENAME                      = P_FILE

      I_BEGIN_COL                   = 1

      I_BEGIN_ROW                   = 2

      I_END_COL                     = 7

      I_END_ROW                     = 9998 "### ## (####)

    TABLES

      INTERN                        = LT_EXCEL

   EXCEPTIONS

     INCONSISTENT_PARAMETERS       = 1

     UPLOAD_OLE                    = 2

     OTHERS                        = 3

            .

  IF SY-SUBRC <> 0 OR LT_EXCEL IS INITIAL.

    MESSAGE '## ### #### #####.' TYPE 'E'.

    EXIT.

  ENDIF.



  "2. LT_EXCEL #### GT_CURR# # ### ##

  CLEAR : GS_CURR.

  LV_CURR_ROW = 0.



  LOOP AT LT_EXCEL INTO LS_EXCEL.



    "## ### ## ## GT_CURR# ###. -> ### AT #### ### # ## #

    IF LV_CURR_ROW = 0. "### ## #

      LV_CURR_ROW = LS_EXCEL-ROW.

      CLEAR : GS_CURR.

      GS_CURR-GDATU = P_ZDATE. "#### = ####

    ELSEIF LS_EXCEL-ROW <> LV_CURR_ROW.

      GS_CURR-ERNAM = SY-UNAME.

      GS_CURR-ERDAT = SY-DATUM.



      APPEND GS_CURR TO GT_CURR.

      CLEAR : GS_CURR.

      LV_CURR_ROW = LS_EXCEL-ROW. "#### = ####

      GS_CURR-GDATU = P_ZDATE.

    ENDIF.



    CASE LS_EXCEL-COL.

      WHEN 1.

        GS_CURR-KURST = LS_EXCEL-VALUE.

      WHEN 2.

        GS_CURR-FCURR = LS_EXCEL-VALUE.

      WHEN 3.

        GS_CURR-TCURR = LS_EXCEL-VALUE.

      WHEN 4.

        "##### ### #

      WHEN 5.

        GS_CURR-UKURS = LS_EXCEL-VALUE.

      WHEN 6.

        GS_CURR-FFACT = LS_EXCEL-VALUE.

      WHEN 7.

        GS_CURR-TFACT = LS_EXCEL-VALUE.

     ENDCASE.



  ENDLOOP.



  IF LV_CURR_ROW <> 0.

      GS_CURR-ERNAM = SY-UNAME.

      GS_CURR-ERDAT = SY-DATUM.

    APPEND GS_CURR TO GT_CURR.

  ENDIF.



  IF GT_CURR IS INITIAL.

    MESSAGE '#### #### #### #####.' TYPE 'S'.

    EXIT.

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




*      PARENT                      =




      REPID                       = SY-REPID "#### ID

      DYNNR                       = '100' "### ##




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




*    ZKURST LIKE ZTCURR03-KURST, "####

*    ZFCURR LIKE ZTCURR03-FCURR, "####

*    ZTCURR LIKE ZTCURR03-TCURR, "####

*    ZGDATU LIKE ZTCURR03-GDATU, "#### ###

*    ZUKURS LIKE ZTCURR03-UKURS, "##

*    ZFFACT LIKE ZTCURR03-FFACT, "#### ### ##

*    ZTFACT LIKE ZTCURR03-TFACT, "#### ### ##






  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'KURST'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'FCURR'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-KEY = 'X'.

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

  GS_FIELDCAT-REF_TABLE = 'ZTCURR03'.

  GS_FIELDCAT-REF_FIELD = 'GDATU'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'UKURS'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  GS_FIELDCAT-DECIMALS = 5.

  GS_FIELDCAT-EDIT = 'X'..

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'FFACT'.

  GS_FIELDCAT-COLTEXT = '########'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'TFACT'.

  GS_FIELDCAT-COLTEXT = '########'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ERNAM'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ERDAT'.

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

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

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

      IT_OUTTAB                     = GT_CURR

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

*&      Form  ALV_DATA_CHANGED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_ER_DATA_CHANGED  text

*----------------------------------------------------------------------*




FORM ALV_DATA_CHANGED  USING    P_ER_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL.

  DATA : LS_MODI TYPE LVC_S_MODI, "### ## ##

         LS_CURR LIKE GS_CURR.    "GT_CURR# WORK AREA



  LOOP AT P_ER_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.



    "ZUKURS# #

    IF LS_MODI-FIELDNAME <> 'ZUKURS'.

      CONTINUE.

    ENDIF.



    "## ## ## #### GT_CURR## ####.

    READ TABLE GT_CURR INTO LS_CURR INDEX LS_MODI-ROW_ID.

    IF SY-SUBRC <> 0.

      CONTINUE.

    ENDIF.



    "1. ## # ##

    LS_CURR-UKURS = LS_MODI-VALUE.



    "2. JPY, VND# ## 100 : 1 ##

    IF LS_CURR-FCURR = 'JPY' OR LS_CURR-FCURR = 'VND'.

      LS_CURR-FFACT = 100.

      LS_CURR-TFACT = 1.

    ENDIF.



    "3. ### # GT_CURR# ##

    MODIFY GT_CURR FROM LS_CURR INDEX LS_MODI-ROW_ID.

    CLEAR  LS_CURR.

  ENDLOOP.



  PERFORM REFRESH.

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

  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.




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

*&      Form  SAVE_CURR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SAVE_CURR .

  DATA : LV_ANS TYPE C,

         LS_DB TYPE ZTCURR03.



  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      TITLEBAR = '## ##'

      TEXT_QUESTION = '##### ########?'

      TEXT_BUTTON_1 = 'YES'

      TEXT_BUTTON_2 = 'NO'

      DEFAULT_BUTTON = '1'

      DISPLAY_CANCEL_BUTTON = ' '

    IMPORTING

      ANSWER = LV_ANS.



  IF LV_ANS <> '1'.

    MESSAGE '### #######.' TYPE 'S'.

    RETURN.

  ENDIF.



  LOOP AT GT_CURR INTO GS_CURR.

    CLEAR LS_DB.

    MOVE-CORRESPONDING GS_CURR TO LS_DB.



    MODIFY ZTCURR03 FROM LS_DB.



    IF SY-SUBRC = 0.

      COMMIT WORK.

      MESSAGE '## ### #######.' TYPE 'S'.

    ELSE.

      ROLLBACK WORK.

      MESSAGE '## # ### ######.' TYPE 'E'.

    ENDIF.

  ENDLOOP.

ENDFORM.