
*&---------------------------------------------------------------------*

*&  Include           ZWORK03_001_F01

*&---------------------------------------------------------------------*



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




FORM GET_DATA USING P_DATE TYPE ZTCURR03-GDATU.

  CLEAR GT_CURR.



  DATA: LS_CURR LIKE LINE OF GT_CURR.



  SELECT * FROM ZTCURR03

           INTO CORRESPONDING FIELDS OF TABLE GT_CURR

           WHERE GDATU = P_DATE.





  LOOP AT GT_CURR INTO LS_CURR.

    LS_CURR-GDATU = P_DATE.

    MODIFY GT_CURR FROM LS_CURR.

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

CREATE OBJECT GC_CUSTOM

  EXPORTING




*    PARENT                      =




    CONTAINER_NAME              = 'CUN1'




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

  GS_FIELDCAT-EDIT = 'X'.

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



    "UKURS# #

    IF LS_MODI-FIELDNAME <> 'UKURS'.

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




*&---------------------------------------------------------------------*

*&      Form  MAKE_PDF

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MAKE_PDF .

  "1. #### ##

  PERFORM GET_DIRECTORY CHANGING GV_DIR.

  IF GV_DIR IS INITIAL.

    MESSAGE '#### ### #######.' TYPE 'S'.

  ENDIF.



  "##, PDF ### ##

  GV_XLSX = GV_DIR && '\EXCAHANGE_TEMPLATE.xlsx'.

  GV_PDF = GV_DIR && '\EXCAHANGE_TEMPLATE' && P_DATE && '.pdf'.



  "2. ### ####

  PERFORM DOWNLOAD_TEMPLATE USING GV_XLSX.



  "3. ## ### ##

  PERFORM OPEN_EXEL_TEMPLATE USING GV_XLSX.



  "4. ALV #### ### ###

  PERFORM FILL_EXCEL_LINE.



  "5. ### PDF# ##

  PERFORM SAVE_PDF USING GV_PDF.



  "6. ## ##

  PERFORM CLOSE_EXCEL.



  "7. ### ## ##

  PERFORM DELETE_FILE USING GV_XLSX.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DIRECTORY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      <--P_GV_DIR  text

*----------------------------------------------------------------------*




FORM GET_DIRECTORY  CHANGING P_DIR.

  DATA: LV_TEMP TYPE STRING,

        LV_SELECT TYPE STRING.



  "1. TEMP #### #### : SAP# #### ## ### OS ## ### ##.

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>GET_TEMP_DIRECTORY

    CHANGING

      TEMP_DIR             = LV_TEMP




*    EXCEPTIONS

*      CNTL_ERROR           = 1

*      ERROR_NO_GUI         = 2

*      NOT_SUPPORTED_BY_GUI = 3

*      others               = 4




          .



  "2. ### ### ## ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>DIRECTORY_BROWSE




*    EXPORTING

*      WINDOW_TITLE         =

*      INITIAL_FOLDER       =




    CHANGING

      SELECTED_FOLDER      = LV_SELECT




*    EXCEPTIONS

*      CNTL_ERROR           = 1

*      ERROR_NO_GUI         = 2

*      NOT_SUPPORTED_BY_GUI = 3

*      others               = 4




          .

  IF LV_SELECT IS INITIAL.

    P_DIR = LV_TEMP.

  ELSE.

    P_DIR = LV_SELECT.

  ENDIF.





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DOWNLOAD_TEMPLATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GV_XLSX  text

*----------------------------------------------------------------------*




FORM DOWNLOAD_TEMPLATE  USING    P_FULLPATH TYPE STRING.

  DATA : LS_WWW TYPE WWWDATATAB,

         LV_OBJID TYPE WWWDATA-OBJID VALUE 'ZWORK03_TEMPLATE',

         LV_FILE TYPE RLGRAP-FILENAME.





  "1. ## ## ##

  LV_FILE = P_FULLPATH. "STRING# CHAR# ##



  CALL FUNCTION 'WS_FILE_DELETE' "## ## ### PC# ### ##

    EXPORTING

      FILE          = LV_FILE

    EXCEPTIONS

      OTHERS = 1.




*   IMPORTING

*     RETURN        =




            .



  "2. ### ## ##

  SELECT SINGLE * FROM WWWDATA

                  INTO CORRESPONDING FIELDS OF LS_WWW

                  WHERE OBJID = LV_OBJID

                  AND RELID = 'MI'. "MIME ## ## ### OBJID# LV_OBJID# ### ###



  IF SY-SUBRC <> 0.

    MESSAGE '#### ## # ####.' TYPE 'E'.

    EXIT.

  ENDIF.



  "3. ### ####

  CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'

    EXPORTING

      KEY               = LS_WWW

     DESTINATION       = LV_FILE




*   IMPORTING

*     RC                =

*   CHANGING

*     TEMP              =




    EXCEPTIONS

      OTHERS = 1.



   IF SY-SUBRC <> 0.

    MESSAGE '#### ##' TYPE 'E'.

    EXIT.

  ENDIF.

            .



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  OPEN_EXEL_TEMPLATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GV_XLSX  text

*----------------------------------------------------------------------*




FORM OPEN_EXEL_TEMPLATE  USING    P_FULLPATH.

  CREATE OBJECT GO_EXCEL 'EXCEL.APPLICATION'.

  IF SY-SUBRC <> 0.

    MESSAGE '## ## ##' TYPE 'E'.

    RETURN.

  ENDIF.



  SET PROPERTY OF GO_EXCEL 'VISIBLE' = 0. "## ## ##### ### ### ## ##



  CALL METHOD OF GO_EXCEL 'WORKBOOKS' = GO_WORDBOOKS.

  CALL METHOD OF GO_WORDBOOKS 'OPEN' = GO_WORDBOOK

    EXPORTING

      #1 = P_FULLPATH.



  CALL METHOD OF GO_WORDBOOK 'WORKSHEETS' = GO_SHEET

    EXPORTING

      #1 = 1.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FILL_EXCEL_LINE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FILL_EXCEL_LINE .

  DATA : LV_ROW TYPE I VALUE 2,

         LV_COL TYPE I,

         LS_CURR LIKE LINE OF GT_CURR,

         LO_CELL TYPE OLE2_OBJECT.



  LOOP AT GT_CURR INTO LS_CURR.

    "1. ####

    LV_COL = 1.

    CALL METHOD OF GO_SHEET 'Cells' = LO_CELL

      EXPORTING #1 = LV_ROW #2 = LV_COL.

    CALL METHOD OF LO_CELL 'Value' = LS_CURR-KURST.



    "2. ####

    LV_COL = 2.

    CALL METHOD OF GO_SHEET 'Cells' = LO_CELL

      EXPORTING #1 = LV_ROW #2 = LV_COL.

    CALL METHOD OF LO_CELL 'Value' = LS_CURR-FCURR.



    "3. ####

    LV_COL = 3.

    CALL METHOD OF GO_SHEET 'Cells' = LO_CELL

      EXPORTING #1 = LV_ROW #2 = LV_COL.

    CALL METHOD OF LO_CELL 'Value' = LS_CURR-TCURR.



    "4. ####

    LV_COL = 4.

    CALL METHOD OF GO_SHEET 'Cells' = LO_CELL

      EXPORTING #1 = LV_ROW #2 = LV_COL.

    CALL METHOD OF LO_CELL 'Value' = LS_CURR-GDATU.



    "5. ##

    LV_COL = 5.

    CALL METHOD OF GO_SHEET 'Cells' = LO_CELL

      EXPORTING #1 = LV_ROW #2 = LV_COL.

    CALL METHOD OF LO_CELL 'Value' = LS_CURR-UKURS.





    "6. ########

    LV_COL = 6.

    CALL METHOD OF GO_SHEET 'Cells' = LO_CELL

      EXPORTING #1 = LV_ROW #2 = LV_COL.

    CALL METHOD OF LO_CELL 'Value' = LS_CURR-FFACT.



    "7. ########

    LV_COL = 7.

    CALL METHOD OF GO_SHEET 'Cells' = LO_CELL

      EXPORTING #1 = LV_ROW #2 = LV_COL.

    CALL METHOD OF LO_CELL 'Value' = LS_CURR-TFACT.



    LV_ROW = LV_ROW + 1.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_PDF

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GV_PDF  text

*----------------------------------------------------------------------*




FORM SAVE_PDF  USING    P_PDF.

    CALL METHOD OF GO_WORDBOOK 'EXPORTASFIXEDFORMAT'

      EXPORTING

        #1 = 0

        #2 = P_PDF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CLOSE_EXCEL

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CLOSE_EXCEL .

  "1. ### ##

  IF GO_WORDBOOK-HANDLE IS NOT INITIAL.

    CALL METHOD OF GO_WORDBOOK 'CLOSE'

      EXPORTING

        #1 = 0. "## # #

    FREE OBJECT GO_WORDBOOK.

    CLEAR GO_WORDBOOK.

  ENDIF.

  "2. ## ###### ##

  IF GO_EXCEL-HANDLE IS NOT INITIAL.

    CALL METHOD OF GO_EXCEL 'QUIT'

      EXPORTING

        #1 = 0. "## # #

    FREE OBJECT GO_EXCEL.

    CLEAR GO_EXCEL.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DELETE_FILE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GV_XLSX  text

*----------------------------------------------------------------------*




FORM DELETE_FILE  USING    P_FULLPATH.

  DATA LV_RC TYPE I.



  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_DELETE

    EXPORTING

      FILENAME             = P_FULLPATH

    CHANGING

      RC                   = LV_RC

    EXCEPTIONS




*      FILE_DELETE_FAILED   = 1

*      CNTL_ERROR           = 2

*      ERROR_NO_GUI         = 3

*      FILE_NOT_FOUND       = 4

*      ACCESS_DENIED        = 5

*      UNKNOWN_ERROR        = 6

*      NOT_SUPPORTED_BY_GUI = 7

*      WRONG_PARAMETER      = 8




      others               = 1

          .

  IF SY-SUBRC = 0 AND LV_RC = 0.

  ELSE.

    MESSAGE |## ## ## (SY-SUBRC={ SY-SUBRC } RC={ LV_RC })| TYPE 'E'.

  ENDIF.





ENDFORM.