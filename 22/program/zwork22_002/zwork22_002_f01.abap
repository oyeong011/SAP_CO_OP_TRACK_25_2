
*&---------------------------------------------------------------------*

*&  Include           ZWORK22_002_F01

*&---------------------------------------------------------------------*

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




    CONTAINER_NAME              = 'CON1'




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




FORM FIELD_CATALOG .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-FIELDNAME = 'KURST'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-FIELDNAME = 'FCURR'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-FIELDNAME = 'TCURR'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 4.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-FIELDNAME = 'GDATU'.

  GS_FIELDCAT-REF_TABLE = 'ZTCURR22'.

  GS_FIELDCAT-REF_FIELD = 'GDATU'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-FIELDNAME = 'UKURS'.

  "GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 12.

  GS_FIELDCAT-DECIMALS = 5.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-COLTEXT = '########'.

  GS_FIELDCAT-FIELDNAME = 'FFACT'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-COLTEXT = '########'.

  GS_FIELDCAT-FIELDNAME = 'TFACT'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-COLTEXT = '###'.

  GS_FIELDCAT-FIELDNAME = 'CRNAME'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-COLTEXT = '###'.

  GS_FIELDCAT-FIELDNAME = 'CRDATE'.

  GS_FIELDCAT-OUTPUTLEN = 12.

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

    IT_OUTTAB                     = GT_CURR_DIS

    IT_FIELDCATALOG               = GT_FIELDCAT




* IT_SORT                       = GT_SORT

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

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA.

  CLEAR GT_CURR_DIS.



  DATA: lv_ext TYPE c LENGTH 10,

      lv_int TYPE ztcurr22-gdatu.



WRITE p_date TO lv_ext.



CALL FUNCTION 'CONVERSION_EXIT_INVDT_INPUT'

  EXPORTING

    input  = lv_ext

  IMPORTING

    output = lv_int.



SELECT *

  FROM ztcurr22

  INTO CORRESPONDING FIELDS OF TABLE @gt_curr_dis

  WHERE gdatu = @lv_int.





"  SELECT

"    KURST,

"    FCURR,

"    TCURR,

"    GDATU,

"    UKURS,

"    FFACT,

"    TFACT,

"    CRNAME,

"    CRDATE

"    FROM ZTCURR22

"    INTO TABLE @GT_CURR_DIS

"    WHERE GDATU = @P_DATE.

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

      IS_STABLE = LS_STABLE.

ENDFORM.




*---------------------------------------------------------------------*

*      Form DEBUG_LOG

*---------------------------------------------------------------------*




"FORM debug_log USING iv_msg TYPE string.

"  MESSAGE iv_msg TYPE 'I'.

"ENDFORM.




*---------------------------------------------------------------------*

*      Form  GET_TEMP_DIRECTORY

*---------------------------------------------------------------------*




FORM GET_TEMP_DIRECTORY.

  "### ## ## ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>GET_TEMP_DIRECTORY

    CHANGING TEMP_DIR = GV_TEMP_DIR.



  IF GV_TEMP_DIR IS INITIAL.

    GV_TEMP_DIR = 'C:\TEMP'.

  ENDIF.

  "excel ## ###

  CONCATENATE GV_TEMP_DIR '\Z_CURR_EXCEL22.XLSX' INTO GV_EXCEL_PATH.

  GV_TEMPLATE_RL = GV_EXCEL_PATH.

  "pdf ## ## ## ## ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>DIRECTORY_BROWSE

    CHANGING SELECTED_FOLDER = GV_PDF_PATH.



  IF GV_PDF_PATH IS INITIAL.

    MESSAGE 'PDF ## ### #####.' TYPE 'I'.

    EXIT.

  ENDIF.



  CONCATENATE GV_PDF_PATH '\CURRENCY.PDF' INTO GV_PDF_PATH.

  GV_PDF_PATH_RL = GV_PDF_PATH.

ENDFORM.




*---------------------------------------------------------------------*

*      Form  BROWSE_DIRECTORY

*---------------------------------------------------------------------*




FORM BROWSE_DIRECTORY CHANGING CV_DIR TYPE STRING.



  CALL METHOD CL_GUI_FRONTEND_SERVICES=>DIRECTORY_BROWSE

    CHANGING

      SELECTED_FOLDER = CV_DIR

    EXCEPTIONS

      OTHERS = 1.



ENDFORM.




*---------------------------------------------------------------------*

*      Form DOWNLOAD_TEMPLATE

*---------------------------------------------------------------------*




FORM DOWNLOAD_TEMPLATE CHANGING CV_PATH TYPE STRING.



  DATA LS_WWWDATA TYPE WWWDATA.

  DATA LS_KEY     TYPE WWWDATATAB.

  DATA LV_RC      TYPE I.

  "## ### ## ## ##

  CV_PATH = GV_EXCEL_PATH.

  "## ## ### ##

  CALL FUNCTION 'WS_FILE_DELETE'

    EXPORTING FILE = GV_TEMPLATE_RL

    EXCEPTIONS OTHERS = 1.

  "SMW0 ### ##

  SELECT SINGLE * INTO LS_WWWDATA

    FROM WWWDATA

    WHERE OBJID = 'Z_CURR_EXCEL22'.



  IF SY-SUBRC <> 0.

    MESSAGE '#### ## # ####.' TYPE 'E'.

    EXIT.

  ENDIF.

  "#### KEY ##

  LS_KEY-RELID = LS_WWWDATA-RELID.

  LS_KEY-OBJID = LS_WWWDATA-OBJID.

  "PC ## ##

  CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'

    EXPORTING

      KEY         = LS_KEY

      DESTINATION = GV_TEMPLATE_RL

    IMPORTING

      RC          = LV_RC

    EXCEPTIONS

      OTHERS      = 1.



  IF LV_RC <> 0 OR SY-SUBRC <> 0.

    MESSAGE '### #### ##' TYPE 'E'.

    EXIT.

  ENDIF.

ENDFORM.




*---------------------------------------------------------------------*

*      Form OPEN_EXCEL_TEMPLATE

*---------------------------------------------------------------------*




FORM OPEN_EXCEL_TEMPLATE

  USING IV_PATH TYPE STRING

  CHANGING CO_EXCEL TYPE OLE2_OBJECT

           CO_WORKBOOK TYPE OLE2_OBJECT

           CO_SHEET TYPE OLE2_OBJECT.



  DATA LO_BOOKS  TYPE OLE2_OBJECT.

  DATA LO_SHEETS TYPE OLE2_OBJECT.

  "EXCEL ##(## ##X)

  CREATE OBJECT CO_EXCEL 'EXCEL.APPLICATION'.

  SET PROPERTY OF CO_EXCEL 'VISIBLE'       = 0.

  SET PROPERTY OF CO_EXCEL 'DISPLAYALERTS' = 0.

  "## ## ##

  CALL METHOD OF CO_EXCEL 'WORKBOOKS' = LO_BOOKS.



  CALL METHOD OF LO_BOOKS 'OPEN' = CO_WORKBOOK

    EXPORTING #1 = IV_PATH.



  IF SY-SUBRC <> 0 OR CO_WORKBOOK IS INITIAL.

    MESSAGE '## ## ##' TYPE 'E'.

  ENDIF.

  "# ## sheet ####

  CALL METHOD OF CO_WORKBOOK 'SHEETS' = LO_SHEETS.



  CALL METHOD OF LO_SHEETS 'ITEM' = CO_SHEET

    EXPORTING #1 = 1.

ENDFORM.




*---------------------------------------------------------------------*

*      Form  FILL_EXCEL_LINE

*---------------------------------------------------------------------*




FORM FILL_EXCEL_LINE USING IO_SHEET TYPE OLE2_OBJECT.



  DATA LO_CELLS     TYPE OLE2_OBJECT.

  DATA LO_CELL      TYPE OLE2_OBJECT.

  DATA LV_ROW       TYPE I VALUE 2.

  DATA LS           LIKE LINE OF GT_CURR_DIS.

  DATA LV_DATE      TYPE STRING.

  DATA LV_GDATU_C   TYPE C LENGTH 10.



  GET PROPERTY OF IO_SHEET 'CELLS' = LO_CELLS.



  LOOP AT GT_CURR_DIS INTO LS.



    CLEAR LV_DATE.

    "### YYYY-MM-DD ## #### ##

    IF LS-GDATU IS NOT INITIAL.

      WRITE LS-GDATU TO LV_GDATU_C.

      REPLACE ALL OCCURRENCES OF '.' IN LV_GDATU_C WITH '-'.

      LV_DATE = LV_GDATU_C.

    ELSE.

      LV_DATE = ''.

    ENDIF.

    "# # ### ### ##

    PERFORM SET_CELL USING LO_CELLS LV_ROW 1 LS-KURST.

    PERFORM SET_CELL USING LO_CELLS LV_ROW 2 LS-FCURR.

    PERFORM SET_CELL USING LO_CELLS LV_ROW 3 LS-TCURR.

    PERFORM SET_CELL USING LO_CELLS LV_ROW 4 LV_DATE.

    PERFORM SET_CELL USING LO_CELLS LV_ROW 5 LS-UKURS.

    PERFORM SET_CELL USING LO_CELLS LV_ROW 6 LS-FFACT.

    PERFORM SET_CELL USING LO_CELLS LV_ROW 7 LS-TFACT.

    PERFORM SET_CELL USING LO_CELLS LV_ROW 8 LS-CRNAME.

    PERFORM SET_CELL USING LO_CELLS LV_ROW 9 LS-CRDATE.



    LV_ROW = LV_ROW + 1.



  ENDLOOP.

ENDFORM.




*---------------------------------------------------------------------*

*      Form  SET_CELL

*---------------------------------------------------------------------*




FORM SET_CELL USING IO_CELLS TYPE OLE2_OBJECT

                     IV_ROW   TYPE I

                     IV_COL   TYPE I

                     IV_VAL   TYPE ANY.



  DATA LO_CELL TYPE OLE2_OBJECT.



  CALL METHOD OF IO_CELLS 'ITEM' = LO_CELL

    EXPORTING

      #1 = IV_ROW

      #2 = IV_COL.



  SET PROPERTY OF LO_CELL 'VALUE' = IV_VAL.



  FREE OBJECT LO_CELL.

ENDFORM.




*---------------------------------------------------------------------*

*      Form  SAVE_AS_PDF

*---------------------------------------------------------------------*




FORM SAVE_AS_PDF USING IO_WORKBOOK TYPE OLE2_OBJECT.



  DATA LV_SUBRC   TYPE SY-SUBRC.

  DATA LV_SUBRC_C TYPE C LENGTH 10.



  CALL METHOD OF IO_WORKBOOK 'EXPORTASFIXEDFORMAT'

    EXPORTING

      #1 = 0

      #2 = GV_PDF_PATH

      #3 = 0.



  LV_SUBRC   = SY-SUBRC.

  LV_SUBRC_C = LV_SUBRC.



  IF LV_SUBRC <> 0.

    MESSAGE |PDF ## ## - SUBRC={ LV_SUBRC_C }| TYPE 'E'.

  ELSE.

    CALL FUNCTION 'POPUP_TO_INFORM'

      EXPORTING

        TITEL = 'PDF ## ##'

        TXT1  = 'PDF ### #######.'

        TXT2  = GV_PDF_PATH.

  ENDIF.

ENDFORM.




*---------------------------------------------------------------------*

*      Form  CLOSE_EXCEL

*---------------------------------------------------------------------*




FORM CLOSE_EXCEL USING IO_EXCEL TYPE OLE2_OBJECT

                       IO_WORKBOOK TYPE OLE2_OBJECT.



  CALL METHOD OF IO_WORKBOOK 'CLOSE'

    EXPORTING #1 = 0.



  CALL METHOD OF IO_EXCEL 'QUIT'.



  FREE OBJECT IO_WORKBOOK.

  FREE OBJECT IO_EXCEL.

ENDFORM.




*--------------------------------------------------------------------*

*      FORM delete_file

*--------------------------------------------------------------------*




FORM DELETE_FILE USING IV_FILE TYPE STRING.



  DATA LV_EXIST TYPE ABAP_BOOL.

  DATA LV_RC    TYPE I.

  "## ## ## ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_EXIST

    EXPORTING FILE = IV_FILE

    RECEIVING RESULT = LV_EXIST

    EXCEPTIONS OTHERS = 1.

  "## ## ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_DELETE

    EXPORTING FILENAME = IV_FILE

    CHANGING  RC       = LV_RC

    EXCEPTIONS OTHERS  = 1.

ENDFORM.




*------------------------------------------------------------*

*      Form  EXPORT_TO_PDF

*---------------------------------------------------------------------*




FORM EXPORT_TO_PDF.



  DATA LO_EXCEL    TYPE OLE2_OBJECT.

  DATA LO_WORKBOOK TYPE OLE2_OBJECT.

  DATA LO_SHEET    TYPE OLE2_OBJECT.

  "## ### ### ##

  IF GT_CURR_DIS IS INITIAL.

    MESSAGE '### ##' TYPE 'I'.

    RETURN.

  ENDIF.

  "1. ## ## ##

  PERFORM GET_TEMP_DIRECTORY.

  "2. Template ## ##

  PERFORM DOWNLOAD_TEMPLATE CHANGING GV_TEMPLATE_PATH.

  "3. excel ### open

  PERFORM OPEN_EXCEL_TEMPLATE USING GV_TEMPLATE_PATH

         CHANGING LO_EXCEL LO_WORKBOOK LO_SHEET.

  "4. ### ##

  PERFORM FILL_EXCEL_LINE USING LO_SHEET.

  "5. pdf ##

  PERFORM SAVE_AS_PDF USING LO_WORKBOOK.

  "6. excle ##

  PERFORM CLOSE_EXCEL USING LO_EXCEL LO_WORKBOOK.

  "7. ## ### ## ##

  PERFORM DELETE_FILE USING GV_TEMPLATE_PATH.

ENDFORM.