
*&---------------------------------------------------------------------*

*&  Include           ZWORK02_002_F01

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

*&      Form  SET_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_SCREEN .



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

  IF P_DATE IS INITIAL. "## ##### ## ### ##

    MESSAGE I000.

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



  CREATE OBJECT GC_CUSTOM

    EXPORTING




*      PARENT                      =




      CONTAINER_NAME              = 'CON1'




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

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .

  SELECT MANDT "#####

         KURST "## ##

         FCURR "## ##

         TCURR "####

         GDATU "## ## ###

         UKURS "##

         FFACT "## ## ### ##

         TFACT "## ## ### ##

         AENAME "###

         AEDATE "###

    FROM ZTCURR02

    INTO TABLE GT_TCURR

    WHERE GDATU = P_DATE. "#### ## #### ##

  IF GT_TCURR IS INITIAL. "### #### ## # ## ### ##

    MESSAGE E001.

    RETURN.

  ENDIF.

  LOOP AT GT_TCURR INTO GS_TCURR.

    CASE: GS_TCURR-FCURR.

      WHEN 'USD'.

        GS_TCURR-SORT_KEY = '1'.

      WHEN 'JPY'.

        GS_TCURR-SORT_KEY = '2'.

      WHEN 'EUR'.

        GS_TCURR-SORT_KEY = '3'.

      WHEN 'CAD'.

        GS_TCURR-SORT_KEY = '4'.

      WHEN 'CNY'.

        GS_TCURR-SORT_KEY = '5'.

      WHEN 'VND'.

        GS_TCURR-SORT_KEY = '6'.

      WHEN 'HKD'.

        GS_TCURR-SORT_KEY = '7'.

      WHEN 'AUD'.

        GS_TCURR-SORT_KEY = '8'.

    ENDCASE.

    MODIFY GT_TCURR FROM GS_TCURR.

  ENDLOOP.

  SORT GT_TCURR BY SORT_KEY.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DOWNLOAD_TEMPLATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DOWNLOAD_TEMPLATE .



  "SMW0 ## # ###

  DATA: LS_KEY TYPE WWWDATATAB,

        LV_RC TYPE I.



  "## ### ####

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>GET_FILE_SEPARATOR

    CHANGING

      FILE_SEPARATOR       = GV_SEPARATOR




*    EXCEPTIONS

*      NOT_SUPPORTED_BY_GUI = 1

*      ERROR_NO_GUI         = 2

*      CNTL_ERROR           = 3

*      others               = 4




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.



  "## ### ## ## ##

  CONCATENATE GV_TEMP_DIR GV_SEPARATOR GV_TEMP_NAME INTO GV_TEMP_PATH.



  CLEAR: LS_KEY.

  LS_KEY-OBJID = GV_OBJ_NAME. "SMW0# ### ## ID

  LS_KEY-RELID = 'MI'.



  "## ### ##

  CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'

    EXPORTING

      KEY               = LS_KEY "# ##

     DESTINATION       = GV_TEMP_PATH "## ##

   IMPORTING

     RC                = LV_RC "## ##




*   CHANGING

*     TEMP              =




            .

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_TEMP_PATH

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_PATH .

  DATA: LV_RETURN TYPE I.

  "## #### ## ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>GET_TEMP_DIRECTORY

    CHANGING

      TEMP_DIR             = GV_TEMP_DIR




*    EXCEPTIONS

*      CNTL_ERROR           = 1

*      ERROR_NO_GUI         = 2

*      NOT_SUPPORTED_BY_GUI = 3

*      others               = 4




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.



  "PDF ## ## ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>DIRECTORY_BROWSE

    EXPORTING

      WINDOW_TITLE         = 'PDF# ### ### #####.'




*      INITIAL_FOLDER       =




    CHANGING

      SELECTED_FOLDER      = GV_FOLDER_PATH




*    EXCEPTIONS

*      CNTL_ERROR           = 1

*      ERROR_NO_GUI         = 2

*      NOT_SUPPORTED_BY_GUI = 3

*      others               = 4




          .

  IF SY-SUBRC <> 0 OR GV_FOLDER_PATH IS INITIAL.

    MESSAGE '## ### #######.' TYPE 'I'.

    GV_CANCEL_FLAG = 'X'.

  ELSE.

    GV_CANCEL_FLAG = ''.

  ENDIF.



  CONCATENATE GV_FOLDER_PATH GV_SEPARATOR GV_FILENAME INTO GV_FILE_PATH. "PDF ## ## ##



  "PDF ## ## ### ### ### ### ## ##

  CALL FUNCTION 'WS_FILE_DELETE'

    EXPORTING

      FILE          = GV_FILE_PATH

   IMPORTING

     RETURN        = LV_RETURN

            .



  "0: ## ##, 1: ### ## ##

  IF LV_RETURN <> '0' AND LV_RETURN <> '1'.

    MESSAGE '#### ## # ### ######.' TYPE 'E'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  INIT_EXCEL_OLE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM INIT_EXCEL_OLE .

  DATA: LO_WORKBOOKS TYPE OLE2_OBJECT. "### ## ## ##(Workbooks) ### ## ##



  "OLE# ### 'Excel.Application' ## ## (## #### ##)

  CREATE OBJECT GO_EXCEL 'Excel.Application'.

  IF SY-SUBRC <> 0.

    MESSAGE '### PC## ### ### # ####.' TYPE 'E'.

    LEAVE PROGRAM.

  ENDIF.



  "## ## ### ## (0 = ##, 1 = ##)

  SET PROPERTY OF GO_EXCEL 'Visible' = 1.

  IF SY-SUBRC <> 0.

    MESSAGE '## ### ### # ####.' TYPE 'W'.

  ENDIF.



  "## ####(GO_EXCEL)# 'Workbooks' ##(##) ####

  CALL METHOD OF GO_EXCEL 'Workbooks' = LO_WORKBOOKS.

  IF SY-SUBRC <> 0.

    MESSAGE '## Workbook ### ### # ####.' TYPE 'E'.

    PERFORM CLEANUP_EXCEL_OLE. " ## # ###

    LEAVE PROGRAM.

  ENDIF.



  "Workbooks ### 'Open' #### #### ### ## ##

  CALL METHOD OF LO_WORKBOOKS 'Open' = GO_WORKBOOK

    EXPORTING

      #1 = GV_TEMP_PATH. " # ## ##

  IF SY-SUBRC <> 0.

    MESSAGE '## ### ### # # ####.' TYPE 'E'.

    PERFORM CLEANUP_EXCEL_OLE.

    LEAVE PROGRAM.

  ENDIF.



  "## # #### '## ##(ActiveSheet)' ####

  CALL METHOD OF GO_WORKBOOK 'ActiveSheet' = GO_WORKSHEET.

  IF SY-SUBRC <> 0.

    MESSAGE '## ##### ### # ####.' TYPE 'E'.

    PERFORM CLEANUP_EXCEL_OLE.

    LEAVE PROGRAM.

  ENDIF.



  "'Workbooks' ## ### ##

  FREE OBJECT LO_WORKBOOKS.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FILL_EXCEL_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FILL_EXCEL_DATA .

  DATA: LV_ROW TYPE I. "### #### # ## #(Row) ## ##



  " #### 2### ### ### ##

  LV_ROW = 2.



  LOOP AT GT_TCURR INTO GS_TCURR.



    PERFORM SET_CELL_VALUE USING LV_ROW 1 GS_TCURR-KURST.

    PERFORM SET_CELL_VALUE USING LV_ROW 2 GS_TCURR-FCURR.

    PERFORM SET_CELL_VALUE USING LV_ROW 3 GS_TCURR-TCURR.

    PERFORM SET_CELL_VALUE USING LV_ROW 4 GS_TCURR-GDATU.

    PERFORM SET_CELL_VALUE USING LV_ROW 5 GS_TCURR-UKURS.

    PERFORM SET_CELL_VALUE USING LV_ROW 6 GS_TCURR-FFACT.

    PERFORM SET_CELL_VALUE USING LV_ROW 7 GS_TCURR-TFACT.

    PERFORM SET_CELL_VALUE USING LV_ROW 8 GS_TCURR-AENAME.

    PERFORM SET_CELL_VALUE USING LV_ROW 9 GS_TCURR-AEDATE.



    ADD 1 TO LV_ROW.



  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  EXPORT_PDF

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM EXPORT_PDF .



  "## ###(GO_WORKBOOK)# PDF ## ### ##

  CALL METHOD OF GO_WORKBOOK 'ExportAsFixedFormat'

    EXPORTING

      #1 = 0                  " Type (0 = xlTypePDF)

      #2 = GV_FILE_PATH.       " Filename (### PDF ## ##)



  IF SY-SUBRC <> 0.

    MESSAGE 'PDF ### ######. (## OLE ##)' TYPE 'E'.

  ELSE.

    MESSAGE 'PDF ### ##### #######.' TYPE 'S'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CLEANUP_EXCEL_OLE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CLEANUP_EXCEL_OLE .

  "OLE ### ### ##(## -> ### -> ##)## ##

  "#### #### ##

  IF GO_WORKSHEET IS NOT INITIAL.

    FREE OBJECT GO_WORKSHEET.

  ENDIF.



  "###(### ##) ##

  IF GO_WORKBOOK IS NOT INITIAL.

    CALL METHOD OF GO_WORKBOOK 'Close'

      EXPORTING

        #1 = 0. " 0 = ## ## ## ##

    FREE OBJECT GO_WORKBOOK.

  ENDIF.



  "## ####(Application) ##

  IF GO_EXCEL IS NOT INITIAL.

    CALL METHOD OF GO_EXCEL 'Quit'.

    FREE OBJECT GO_EXCEL.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DELETE_TEMPLATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DELETE_TEMPLATE .

  DATA: LV_RC TYPE SY-SUBRC,

        LV_TEMP_PATH TYPE STRING.



  LV_TEMP_PATH = GV_TEMP_PATH.



  "## ### ##

  IF GV_TEMP_PATH IS NOT INITIAL.

    CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_DELETE

    EXPORTING

      FILENAME             = LV_TEMP_PATH

    CHANGING

      RC                   = LV_RC




*    EXCEPTIONS

*      FILE_DELETE_FAILED   = 1

*      CNTL_ERROR           = 2

*      ERROR_NO_GUI         = 3

*      FILE_NOT_FOUND       = 4

*      ACCESS_DENIED        = 5

*      UNKNOWN_ERROR        = 6

*      NOT_SUPPORTED_BY_GUI = 7

*      WRONG_PARAMETER      = 8

*      others               = 9




          .

    IF SY-SUBRC <> 0.




*     Implement suitable error handling here




    ENDIF.

    RETURN. " ### ## ### ### ##

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_CELL_VALUE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_ROW  text

*      -->P_COL      text

*      -->P_VALUE  text

*----------------------------------------------------------------------*




FORM SET_CELL_VALUE  USING P_ROW   TYPE I "#

                           P_COL   TYPE I "#

                           P_VALUE TYPE ANY. "#

  DATA: LO_CELL TYPE OLE2_OBJECT.



  "###### (#, #)# #### # ## ####

  CALL METHOD OF GO_WORKSHEET 'Cells' = LO_CELL

    EXPORTING

      #1 = p_row  " #

      #2 = p_col. " #



  " ## # ### Value ### # ##

  SET PROPERTY OF LO_CELL 'Value' = P_VALUE.



  "## ##

  FREE OBJECT LO_CELL.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_PAGE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_PAGE .



  "### ## ## ##

  DATA: LO_PAGE_SETUP TYPE OLE2_OBJECT,

      LO_COLUMNS TYPE OLE2_OBJECT.



  "## # ## ####

  CALL METHOD OF GO_WORKSHEET 'Columns' = LO_COLUMNS.

  IF SY-SUBRC = 0.

    "## # ## ## ##

    CALL METHOD OF LO_COLUMNS 'AutoFit'.

    FREE OBJECT LO_COLUMNS.

  ENDIF.



  " 3.PageSetup ##(##) ####

  GET PROPERTY OF GO_WORKSHEET 'PageSetup' = LO_PAGE_SETUP.

  IF SY-SUBRC <> 0.

    MESSAGE 'PageSetup ### ### # ####.' TYPE 'W'.

    RETURN.

  ENDIF.



  "## ### ### ##

  SET PROPERTY OF LO_PAGE_SETUP 'Orientation' = 2.



  "##/## ##(Zoom) ## (False = 0)

  SET PROPERTY OF LO_PAGE_SETUP 'Zoom' = 0.



  "### 1#### ##

  SET PROPERTY OF LO_PAGE_SETUP 'FitToPagesWide' = 1.



  "### ## X(False = 0)

  SET PROPERTY OF LO_PAGE_SETUP 'FitToPagesTall' = 0.



  "## ##

  FREE OBJECT LO_PAGE_SETUP.

ENDFORM.