
*&---------------------------------------------------------------------*

*&  Include           ZWORK04_002_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_INIT

*&---------------------------------------------------------------------*




FORM SET_INIT .

  P_DATE = SY-DATUM.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SELECT_DATA

*&---------------------------------------------------------------------*




FORM SELECT_DATA .

  SELECT * FROM ZTCURR04

    INTO CORRESPONDING FIELDS OF TABLE GT_ZTCURR04

    WHERE GDATU = P_DATE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*




FORM CREATE_OBJECT .

  CREATE OBJECT GC_CUSTOM

    EXPORTING

      CONTAINER_NAME              = 'CON1'.



  CREATE OBJECT GC_GRID

    EXPORTING

      I_PARENT          = GC_CUSTOM.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*




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

  GS_FIELDCAT-OUTPUTLEN = '15'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-DECIMALS = '5'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'FFACT'.

  GS_FIELDCAT-COLTEXT = '########'.

  GS_FIELDCAT-OUTPUTLEN = '15'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'TFACT'.

  GS_FIELDCAT-COLTEXT = '########'.

  GS_FIELDCAT-OUTPUTLEN = '15'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'CRNAME'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'CRDATE'.

  GS_FIELDCAT-COLTEXT = '###'.

  GS_FIELDCAT-OUTPUTLEN = '15'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*




FORM ALV_LAYOUT .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.          " ## ## # ### ##



  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY .

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_LAYOUT                     = GS_LAYOUT

      IS_VARIANT                    = GS_VARIANT

      I_SAVE                        = 'A'

    CHANGING

      IT_OUTTAB                     = GT_ZTCURR04

      IT_FIELDCATALOG               = GT_FIELDCAT

      .

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_AS_PDF

*&---------------------------------------------------------------------*




FORM SAVE_AS_PDF .

  DATA LV_TEMP_FILE TYPE RLGRAP-FILENAME. " ## ## ##

  DATA LV_SELECTED_DIR TYPE STRING.       " PDF ## ##

  DATA LV_FILE_PATH TYPE STRING.          " PDF ## ##(##### x)



  DATA LV_APPLICATION TYPE OLE2_OBJECT.

  DATA LV_WORKBOOKS TYPE OLE2_OBJECT.

  DATA LV_WORKBOOK TYPE OLE2_OBJECT.

  DATA LV_WORKSHEET TYPE OLE2_OBJECT.



  DATA LV_RC TYPE SY-SUBRC.



  " 1. ## ##, PDF ## ## ##

  PERFORM SET_PATH CHANGING   LV_TEMP_FILE

                              LV_SELECTED_DIR

                              LV_FILE_PATH.



  IF LV_SELECTED_DIR IS INITIAL.  " ##

    EXIT.

  ENDIF.



  " 2. DOWNLOAD_TEMPLATE

  PERFORM DOWNLOAD_TEMPLATE USING LV_TEMP_FILE.



  " 3. OPEN_EXCEL_TEMPLATE

  PERFORM OPEN_EXCEL_TEMPLATE USING LV_APPLICATION

                                    LV_WORKBOOKS

                                    LV_WORKBOOK

                                    LV_WORKSHEET

                                    LV_TEMP_FILE.

  PERFORM SET_PAGE USING LV_WORKSHEET.



  " 4. FILL_EXCEL_LINE

  PERFORM FILL_EXCEL_LINE USING LV_WORKSHEET.



  " PDF# ####

  CALL METHOD OF LV_WORKBOOK 'ExportAsfixedFormat'

    EXPORTING

      #1 = 0  " ## ## PDF

      #2 = LV_FILE_PATH.



  " ## ##

  CALL METHOD OF LV_WORKBOOK 'CLOSE'

    EXPORTING #1 = 0. " #### ##

  CALL METHOD OF LV_APPLICATION 'QUIT'.

  FREE: LV_WORKSHEET, LV_WORKBOOK, LV_WORKBOOKS,LV_APPLICATION.



  " 5. #### ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_DELETE

    EXPORTING

      FILENAME             = CONV STRING( LV_TEMP_FILE )

    CHANGING

      RC                   = LV_RC.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_PATH

*&---------------------------------------------------------------------*




FORM SET_PATH  CHANGING  P_TEMP_FILE

                         P_SELECTED_DIR

                         P_FILE_PATH.

  DATA LV_TEMP_DIR TYPE STRING. " ## ##

  DATA LV_SEPARATOR.



  "## ### ####

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>GET_FILE_SEPARATOR

    CHANGING

      FILE_SEPARATOR       = LV_SEPARATOR.



  " #### ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>GET_TEMP_DIRECTORY

    CHANGING

      TEMP_DIR             = LV_TEMP_DIR.



  " PDF #### ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>DIRECTORY_BROWSE

    EXPORTING

      WINDOW_TITLE         = '## ## ##'

    CHANGING

      SELECTED_FOLDER      = P_SELECTED_DIR.



  CONCATENATE LV_TEMP_DIR     LV_SEPARATOR 'TEMP.XLSX'  INTO P_TEMP_FILE.  " #### ##

  CONCATENATE P_SELECTED_DIR  LV_SEPARATOR '##' P_DATE  INTO P_FILE_PATH.  " PDF## ##

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DOWNLOAD_TEMPLATE

*&---------------------------------------------------------------------*




FORM DOWNLOAD_TEMPLATE  USING    P_TEMP_FILE.

  DATA LS_KEY TYPE WWWDATATAB.



  " ## ## ### ## ### ##

  CALL FUNCTION 'WS_FILE_DELETE'

    EXPORTING

      FILE          = P_TEMP_FILE.



  SELECT SINGLE * INTO CORRESPONDING FIELDS OF LS_KEY

    FROM WWWDATA

    WHERE OBJID = 'ZWORK002_EXCEL_TEMPLATE'.



  " ### ####

  CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'

    EXPORTING

      KEY               = LS_KEY

      DESTINATION       = P_TEMP_FILE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  OPEN_EXCEL_TEMPLATE

*&---------------------------------------------------------------------*




FORM OPEN_EXCEL_TEMPLATE  USING    P_APPLICATION

                                   P_WORKBOOKS

                                   P_WORKBOOK

                                   P_WORKSHEET

                                   P_TEMP_FILE.

  CREATE OBJECT P_APPLICATION 'EXCEL.APPLICATION'.

  CALL METHOD OF P_APPLICATION 'WORKBOOKS' = P_WORKBOOKS.

  CALL METHOD OF P_WORKBOOKS 'OPEN' = P_WORKBOOK

    EXPORTING

      #1 = P_TEMP_FILE.

  GET PROPERTY OF P_APPLICATION 'ACTIVESHEET' = P_WORKSHEET.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_PAGE

*&---------------------------------------------------------------------*




FORM SET_PAGE USING P_WORKSHEET.

  DATA: LV_PAGE_SETUP TYPE OLE2_OBJECT.



  GET PROPERTY OF P_WORKSHEET 'PageSetup' = LV_PAGE_SETUP.

  IF SY-SUBRC <> 0.

    MESSAGE 'PageSetup ### ### # ####.' TYPE 'W'.

    RETURN.

  ENDIF.



  "## ## ### ##

  SET PROPERTY OF LV_PAGE_SETUP 'Orientation' = 2.



  "##/## ##(Zoom) ##

  SET PROPERTY OF LV_PAGE_SETUP 'Zoom' = 0.



  "## 1#### ##

  SET PROPERTY OF LV_PAGE_SETUP 'FitToPagesWide' = 1.



  "## ## ##

  SET PROPERTY OF LV_PAGE_SETUP 'FitToPagesTall' = 0.



  FREE OBJECT LV_PAGE_SETUP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FILL_EXCEL_LINE

*&---------------------------------------------------------------------*




FORM FILL_EXCEL_LINE  USING    P_WORKSHEET.

  DATA LV_ROW TYPE I.



  LOOP AT GT_ZTCURR04 INTO GS_ZTCURR04.

    LV_ROW = SY-TABIX + 1.

    PERFORM SET_VALUE_TO_CELL USING P_WORKSHEET LV_ROW

                                    1 GS_ZTCURR04-KURST.

    PERFORM SET_VALUE_TO_CELL USING P_WORKSHEET LV_ROW

                                    2 GS_ZTCURR04-FCURR.

    PERFORM SET_VALUE_TO_CELL USING P_WORKSHEET LV_ROW

                                    3 GS_ZTCURR04-TCURR.

    PERFORM SET_VALUE_TO_CELL USING P_WORKSHEET LV_ROW

                                    4 GS_ZTCURR04-GDATU.

    PERFORM SET_VALUE_TO_CELL USING P_WORKSHEET LV_ROW

                                    5 GS_ZTCURR04-UKURS.

    PERFORM SET_VALUE_TO_CELL USING P_WORKSHEET LV_ROW

                                    6 GS_ZTCURR04-FFACT.

    PERFORM SET_VALUE_TO_CELL USING P_WORKSHEET LV_ROW

                                    7 GS_ZTCURR04-TFACT.

    PERFORM SET_VALUE_TO_CELL USING P_WORKSHEET LV_ROW

                                    8 GS_ZTCURR04-CRNAME.

    PERFORM SET_VALUE_TO_CELL USING P_WORKSHEET LV_ROW

                                    9 GS_ZTCURR04-CRDATE.

    CLEAR GS_ZTCURR04.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_VALUE_TO_CELL

*&---------------------------------------------------------------------*




FORM SET_VALUE_TO_CELL  USING    P_WORKSHEET

                                 P_ROW

                                 P_COL

                                 P_VALUE.

  DATA LV_CELL TYPE OLE2_OBJECT.

  CALL METHOD OF P_WORKSHEET 'CELLS' = LV_CELL

    EXPORTING

      #1 = P_ROW

      #2 = P_COL.

  SET PROPERTY OF LV_CELL 'VALUE' = P_VALUE.

  FREE LV_CELL.

ENDFORM.