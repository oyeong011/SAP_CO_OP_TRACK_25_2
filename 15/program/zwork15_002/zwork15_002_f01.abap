
*&---------------------------------------------------------------------*

*&  Include           ZWORK15_002_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .

  SELECT *

    FROM ZTCURR015

    INTO CORRESPONDING FIELDS OF TABLE GT_ZTCURR

    WHERE GDATU = P_DATE.

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

CLEAR : GS_FIELDCAT, GT_FIELDCAT.



  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'KURST'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'FCURR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'TCURR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'GDATU'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'UKURS'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'FFACT'.

  GS_FIELDCAT-COLTEXT = '########'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'TFACT'.

  GS_FIELDCAT-COLTEXT = '########'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'CRNAME'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'CRDATE'.

  GS_FIELDCAT-COLTEXT = '###'.

  GS_FIELDCAT-OUTPUTLEN = 10.

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



  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

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

      IS_VARIANT                    = GS_VARIANT

      I_SAVE                        = 'A'

      IS_LAYOUT                     = GS_LAYOUT

    CHANGING

      IT_OUTTAB                     = GT_ZTCURR

      IT_FIELDCATALOG               = GT_FIELDCAT

      .

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_PDF

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SAVE_PDF .



  "1) #### ##

  PERFORM GET_DIRECTORY.



  "2) ### ####

  PERFORM DOWNLOAD_TEMPLATE.



  "3) ### ##

  PERFORM OPEN_EXCEL_TEMPLATE.



  "4) ALV### ### ###

  PERFORM FILL_EXCEL_LINE.



  "5) ### pdf# ##

  PERFORM EXCEL_TO_PDF.



  "6) ## ## # ##

  PERFORM DELETE_FILE.







ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DIRECTORY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DIRECTORY .

  "## ## #####

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>DIRECTORY_BROWSE

    EXPORTING

      WINDOW_TITLE = 'PDF## ### #####'

      INITIAL_FOLDER = 'C:\'

    CHANGING

      SELECTED_FOLDER = GV_DIR

    EXCEPTIONS

     OTHERS               = 0 .



  IF SY-SUBRC <> 0 OR GV_DIR IS INITIAL.

    MESSAGE '## ### #######.' TYPE 'I'.

    EXIT.

  ENDIF.



  "OS# ## ###

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>GET_FILE_SEPARATOR

    CHANGING

      FILE_SEPARATOR = GV_SEP.



  "## #### ##

  CONCATENATE GV_DIR GV_SEP 'alv_pdf_temp.xlsx' INTO GV_XLS_FILE.



  "## pdf##

  CONCATENATE GV_DIR GV_SEP 'alv_output.pdf' INTO GV_PDF_FILE.



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



  DATA : LV_OBJID TYPE WWWDATATAB-OBJID VALUE 'ZEXCEL_TEMP_002',

        LS_WWW TYPE WWWDATATAB.



  DATA : LV_FILENAME TYPE RLGRAP-FILENAME.



  LV_FILENAME = GV_XLS_FILE.



  "## ## ##

  CALL FUNCTION 'WS_FILE_DELETE'

    EXPORTING

      FILE = LV_FILENAME.



  "### ## ##

  SELECT SINGLE *

    INTO CORRESPONDING FIELDS OF LS_WWW

    FROM WWWDATA

    WHERE OBJID = LV_OBJID.



  IF SY-SUBRC <> 0.

    MESSAGE '## ### ###' TYPE 'E'.

  ENDIF.



  "#### ###### ####

  CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'

    EXPORTING

      KEY = LS_WWW

      DESTINATION = LV_FILENAME

    EXCEPTIONS

      OTHERS = 1.



  IF SY-SUBRC <> 0.

    MESSAGE '## ### #### ##' TYPE 'E'.

  ENDIF.



  "

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  OPEN_EXCEL_TEMPLATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM OPEN_EXCEL_TEMPLATE .

  "EXCEL.APPLICATON ##

  CREATE OBJECT GO_EXCEL 'EXCEL.APPLICATION'.

  IF SY-SUBRC <> 0.

    MESSAGE '## OLE ## ##' TYPE 'E'.

  ENDIF.



  "## #### ## ###

  SET PROPERTY OF GO_EXCEL 'VISIBLE' = 0.



  "WORKBOOKS ### ##

  CALL METHOD OF GO_EXCEL 'WORKBOOKS' = GO_WORKBOOKS.



  "### ## ##

  CALL METHOD OF GO_WORKBOOKS 'OPEN' = GO_WORKBOOK

    EXPORTING

      #1 = GV_XLS_FILE.



  "### ## ##

  CALL METHOD OF GO_WORKBOOK 'WORKSHEETS' = GO_SHEET

    EXPORTING

     #1 = 1.



  CALL METHOD OF GO_SHEET 'ACTIVATE'.

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

  DATA : LV_ROW TYPE I VALUE 2. "###



  LOOP AT GT_ZTCURR ASSIGNING FIELD-SYMBOL(<FS_ALV>).



    CALL METHOD OF GO_SHEET 'CELLS' = GO_CELL

      EXPORTING

       #1 = LV_ROW

       #2 = 1.

    SET PROPERTY OF GO_CELL 'VALUE' = <FS_ALV>-KURST.



    CALL METHOD OF GO_SHEET 'CELLS' = GO_CELL

      EXPORTING

       #1 = LV_ROW

       #2 = 2.

    SET PROPERTY OF GO_CELL 'VALUE' = <FS_ALV>-FCURR.



    CALL METHOD OF GO_SHEET 'CELLS' = GO_CELL

      EXPORTING

       #1 = LV_ROW

       #2 = 3.

    SET PROPERTY OF GO_CELL 'VALUE' = <FS_ALV>-TCURR.



    CALL METHOD OF GO_SHEET 'CELLS' = GO_CELL

      EXPORTING

       #1 = LV_ROW

       #2 = 4.

    SET PROPERTY OF GO_CELL 'VALUE' = <FS_ALV>-GDATU.



    CALL METHOD OF GO_SHEET 'CELLS' = GO_CELL

      EXPORTING

       #1 = LV_ROW

       #2 = 5.

    SET PROPERTY OF GO_CELL 'VALUE' = <FS_ALV>-UKURS.



    CALL METHOD OF GO_SHEET 'CELLS' = GO_CELL

      EXPORTING

       #1 = LV_ROW

       #2 = 6.

    SET PROPERTY OF GO_CELL 'VALUE' = <FS_ALV>-FFACT.



    CALL METHOD OF GO_SHEET 'CELLS' = GO_CELL

      EXPORTING

       #1 = LV_ROW

       #2 = 7.

    SET PROPERTY OF GO_CELL 'VALUE' = <FS_ALV>-TFACT.



    CALL METHOD OF GO_SHEET 'CELLS' = GO_CELL

      EXPORTING

       #1 = LV_ROW

       #2 = 8.

    SET PROPERTY OF GO_CELL 'VALUE' = <FS_ALV>-CRNAME.



    CALL METHOD OF GO_SHEET 'CELLS' = GO_CELL

      EXPORTING

       #1 = LV_ROW

       #2 = 9.

    SET PROPERTY OF GO_CELL 'VALUE' = <FS_ALV>-CRDATE.



    LV_ROW = LV_ROW + 1.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  EXCEL_TO_PDF

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM EXCEL_TO_PDF .

  DATA : LV_TYPE TYPE I VALUE 0. "0=PDF, 1=XPS(## # ##)



  CALL METHOD OF GO_WORKBOOK 'EXPORTASFIXEDFORMAT'

    EXPORTING

      #1 = LV_TYPE

      #2 = GV_PDF_FILE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DELETE_FILE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DELETE_FILE .

  DATA : LV_RC TYPE I.



  "### ## # ## ##

  CALL METHOD OF GO_WORKBOOK 'CLOSE'

    EXPORTING

      #1 = 0.



  "## ##

  CALL METHOD OF GO_EXCEL 'QUIT'.



  "OLE #### ##

  FREE : GO_CELL, GO_SHEET, GO_WORKBOOK, GO_WORKBOOKS, GO_EXCEL.



  "## ## ## ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_DELETE

    EXPORTING

      FILENAME = GV_XLS_FILE

    CHANGING

      RC = LV_RC

    EXCEPTIONS

      OTHERS = 0.

ENDFORM.