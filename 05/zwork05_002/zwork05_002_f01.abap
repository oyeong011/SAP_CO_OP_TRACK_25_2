
*&---------------------------------------------------------------------*

*&  Include           ZWORK05_002_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*




form GET_DATA .

  SELECT * FROM ZTCURR05 INTO TABLE GT_200

    WHERE GDATU = P_DATE.



  IF GT_200 IS INITIAL.

    MESSAGE I001.

    STOP.

  ENDIF.






*  LOOP AT GT_200 INTO GS_200.

*    GS_200-ERNAM = SY-UNAME.

*    GS_200-ERDAT = SY-DATUM.

*    MODIFY GT_200 FROM GS_200.

*  ENDLOOP.




endform.




*&---------------------------------------------------------------------*

*&      Form  CHECK_DATA

*&---------------------------------------------------------------------*




form CHECK_DATA .

  IF P_DATE IS INITIAL.

    MESSAGE I000.

    STOP.

  ENDIF.

endform.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*




form CREATE_OBJECT .

  create object GO_CONTAINER

    exporting

      CONTAINER_NAME              = 'AREA'

    exceptions

      CNTL_ERROR                  = 1

      CNTL_SYSTEM_ERROR           = 2

      CREATE_ERROR                = 3

      LIFETIME_ERROR              = 4

      LIFETIME_DYNPRO_DYNPRO_LINK = 5.



  if SY-SUBRC <> 0.

    MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

               WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.

    EXIT.

  endif.



  create object GO_ALV_GRID

    exporting

      I_PARENT          = GO_CONTAINER.



  CREATE OBJECT go_event_handler.



  SET HANDLER go_event_handler->handle_toolbar FOR go_alv_grid.

  SET HANDLER go_event_handler->handle_user_command FOR go_alv_grid.



endform.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*




form FIELD_CATALOG .



  REFRESH GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'KURST'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  GS_FIELDCAT-COL_POS = 1.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'FCURR'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  GS_FIELDCAT-COL_POS = 2.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'TCURR'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  GS_FIELDCAT-COL_POS = 3.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'GDATU'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  GS_FIELDCAT-COL_POS = 4.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'UKURS'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-OUTPUTLEN = 15.

  GS_FIELDCAT-COL_POS = 5.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'FFACT'.

  GS_FIELDCAT-COLTEXT = '########'.

  GS_FIELDCAT-OUTPUTLEN = 18.

  GS_FIELDCAT-COL_POS = 6.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'TFACT'.

  GS_FIELDCAT-COLTEXT = '########'.

  GS_FIELDCAT-OUTPUTLEN = 18.

  GS_FIELDCAT-COL_POS = 7.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'ERNAM'.

  GS_FIELDCAT-COLTEXT = '###'.

  GS_FIELDCAT-OUTPUTLEN = 12.

  GS_FIELDCAT-COL_POS = 8.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'ERDAT'.

  GS_FIELDCAT-COLTEXT = '###'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  GS_FIELDCAT-COL_POS = 9.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



endform.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*




form ALV_LAYOUT .



  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-CWIDTH_OPT = 'X'.

  GS_LAYOUT-SEL_MODE = 'A'.

  GS_LAYOUT-GRID_TITLE = '## ## ##'.

  GS_LAYOUT-NO_ROWMARK = ''.



endform.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*




form CALL_ALV .

  call method GO_ALV_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    exporting

      IS_LAYOUT                     = GS_LAYOUT

    changing

      IT_OUTTAB                     = GT_200

      IT_FIELDCATALOG               = GT_FIELDCAT

    exceptions

      INVALID_PARAMETER_COMBINATION = 1

      PROGRAM_ERROR                 = 2

      TOO_MANY_LINES                = 3

      OTHERS                        = 4.



  if SY-SUBRC <> 0.

    MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

               WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.

  endif.



endform.




*&---------------------------------------------------------------------*

*&      Form  PDF_DOWNLOAD

*&---------------------------------------------------------------------*




form PDF_DOWNLOAD .

  " ## ### ### ##

  IF GT_200 IS INITIAL.

    MESSAGE '### #### ####.' TYPE 'I'.

    RETURN.

  ENDIF.



  " 1. ## ## ##

  PERFORM GET_TEMP_DIRECTORY.



  " 2. ### ####

  PERFORM DOWNLOAD_TEMPLATE.



  " 3. Excel ### ##

  PERFORM OPEN_EXCEL_TEMPLATE.



  " 4. ### ##

  PERFORM FILL_EXCEL_LINE.



  " 5. PDF# ##

  PERFORM SAVE_AS_PDF.



  " 6. Excel ##

  PERFORM CLOSE_EXCEL.



  " 7. ## ## ##

  PERFORM DELETE_FILE.



endform.




*&---------------------------------------------------------------------*

*&      Form  GET_TEMP_DIRECTORY

*&---------------------------------------------------------------------*




form GET_TEMP_DIRECTORY .

  " ### ## ## ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>GET_TEMP_DIRECTORY

    CHANGING

      TEMP_DIR = GV_DIRECTORY

    EXCEPTIONS

      OTHERS = 1.



  IF GV_DIRECTORY IS INITIAL.

    GV_DIRECTORY = 'C:\TEMP'.

  ENDIF.



  " Excel ### ## ##

  CONCATENATE GV_DIRECTORY '\excel_template.xlsx' INTO GV_TEMPLATE_PATH.



endform.




*&---------------------------------------------------------------------*

*&      Form  DIRECTORY_BROWSE

*&---------------------------------------------------------------------*




form DIRECTORY_BROWSE .

  DATA: LV_PDF_DIRECTORY TYPE STRING.



  " PDF ## ## ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>DIRECTORY_BROWSE

    CHANGING

      SELECTED_FOLDER = LV_PDF_DIRECTORY

    EXCEPTIONS

      OTHERS = 1.



  IF LV_PDF_DIRECTORY IS INITIAL.

    MESSAGE 'PDF ## ### #####.' TYPE 'I'.

    STOP.

  ENDIF.



  " PDF ### ##

  DATA: LV_DATE_STR(8) TYPE C.

  WRITE P_DATE TO LV_DATE_STR.

  CONDENSE LV_DATE_STR NO-GAPS.

  CONCATENATE LV_PDF_DIRECTORY '\EXCHANGERATE_' LV_DATE_STR '.pdf'

    INTO GV_PDF_PATH.



endform.




*&---------------------------------------------------------------------*

*&      Form  DOWNLOAD_TEMPLATE

*&---------------------------------------------------------------------*




form DOWNLOAD_TEMPLATE .

  DATA: LS_WWWDATA TYPE WWWDATA,

        LS_KEY     TYPE WWWDATATAB,

        LV_RC      TYPE I,

        LV_FILE    TYPE RLGRAP-FILENAME.



  " STRING# CHAR #### ##

  LV_FILE = GV_TEMPLATE_PATH.



  " ## ## ##

  CALL FUNCTION 'WS_FILE_DELETE'

    EXPORTING

      FILE       = LV_FILE

    EXCEPTIONS

      OTHERS     = 1.



  " SMW0## ### ##

  SELECT SINGLE * FROM WWWDATA INTO LS_WWWDATA

    WHERE OBJID = 'ZEXCHANGE_TEMPLATE'.



  IF SY-SUBRC <> 0.

    MESSAGE '#### ## # ####.' TYPE 'E'.

    RETURN.

  ENDIF.



  " #### KEY ##

  LS_KEY-RELID = LS_WWWDATA-RELID.

  LS_KEY-OBJID = LS_WWWDATA-OBJID.



  " PC# ##

  CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'

    EXPORTING

      KEY         = LS_KEY

      DESTINATION = LV_FILE

    IMPORTING

      RC          = LV_RC

    EXCEPTIONS

      OTHERS      = 1.



  IF LV_RC <> 0 OR SY-SUBRC <> 0.

    MESSAGE '### #### ##' TYPE 'E'.

    CLEAR GV_TEMPLATE_PATH.

  ENDIF.



endform.




*&---------------------------------------------------------------------*

*&      Form  OPEN_EXCEL_TEMPLATE

*&---------------------------------------------------------------------*




form OPEN_EXCEL_TEMPLATE.

  DATA: LO_BOOKS  TYPE OLE2_OBJECT,

        LO_SHEETS TYPE OLE2_OBJECT.



  " Excel ###### ##

  CREATE OBJECT GO_EXCEL 'Excel.Application'.



  IF GO_EXCEL IS INITIAL.

    MESSAGE 'Excel ## ## ##' TYPE 'E'.

    RETURN.

  ENDIF.



  " Excel ## ##

  SET PROPERTY OF GO_EXCEL 'Visible' = 0.

  SET PROPERTY OF GO_EXCEL 'DisplayAlerts' = 0.

  " Workbooks ### ####

  CALL METHOD OF GO_EXCEL 'Workbooks' = LO_BOOKS.



  " ### ## ##

  IF GV_TEMPLATE_PATH IS NOT INITIAL.

    CALL METHOD OF LO_BOOKS 'Open' = GO_WORKBOOK

      EXPORTING #1 = GV_TEMPLATE_PATH.

  ELSE.

    " #### ## ## # ### ##

    CALL METHOD OF LO_BOOKS 'Add' = GO_WORKBOOK.

  ENDIF.



  IF GO_WORKBOOK IS INITIAL.

    MESSAGE 'Workbook ## ##' TYPE 'E'.

    CALL METHOD OF GO_EXCEL 'Quit'.

    FREE OBJECT GO_EXCEL.

    RETURN.

  ENDIF.



  " # ## #### ####

  CALL METHOD OF GO_WORKBOOK 'Sheets' = LO_SHEETS.

  CALL METHOD OF LO_SHEETS 'Item' = GO_WORKSHEET

    EXPORTING #1 = 1.



  " ## ## ##

  FREE OBJECT: LO_BOOKS, LO_SHEETS.



endform.




*&---------------------------------------------------------------------*

*&      Form  FILL_EXCEL_LINE

*&---------------------------------------------------------------------*




form FILL_EXCEL_LINE.

  DATA: LV_ROW           TYPE I VALUE 1,

        LV_DATE_GDATU(10) TYPE C,

        LV_DATE_ERDAT(10) TYPE C,

        LV_GDATU_OUT      TYPE C LENGTH 10,

        LV_GDATU_CLEAN(8) TYPE C,

        LV_ERDAT_STR(8)   TYPE C,

        LO_COLUMNS        TYPE OLE2_OBJECT,

        LO_RANGE          TYPE OLE2_OBJECT.



  " Cells ## ####

  GET PROPERTY OF GO_WORKSHEET 'Cells' = GO_CELLS.



  " ## ##

  PERFORM SET_EXCEL_CELL USING LV_ROW 1 '####'.

  PERFORM SET_EXCEL_CELL USING LV_ROW 2 '####'.

  PERFORM SET_EXCEL_CELL USING LV_ROW 3 '####'.

  PERFORM SET_EXCEL_CELL USING LV_ROW 4 '####'.

  PERFORM SET_EXCEL_CELL USING LV_ROW 5 '##'.

  PERFORM SET_EXCEL_CELL USING LV_ROW 6 '########'.

  PERFORM SET_EXCEL_CELL USING LV_ROW 7 '########'.

  PERFORM SET_EXCEL_CELL USING LV_ROW 8 '###'.

  PERFORM SET_EXCEL_CELL USING LV_ROW 9 '###'.



  " ### ##

  LV_ROW = 2.

  LOOP AT GT_200 INTO GS_200.

    " ERDAT ## ##

    CLEAR LV_DATE_ERDAT.

    IF GS_200-ERDAT IS NOT INITIAL.

      LV_ERDAT_STR = GS_200-ERDAT.

      CONCATENATE LV_ERDAT_STR+0(4) '-'

                  LV_ERDAT_STR+4(2) '-'

                  LV_ERDAT_STR+6(2)

             INTO LV_DATE_ERDAT.

    ENDIF.



    PERFORM SET_EXCEL_CELL USING LV_ROW 1 GS_200-KURST.

    PERFORM SET_EXCEL_CELL USING LV_ROW 2 GS_200-FCURR.

    PERFORM SET_EXCEL_CELL USING LV_ROW 3 GS_200-TCURR.

    PERFORM SET_EXCEL_CELL USING LV_ROW 4 GS_200-GDATU.

    PERFORM SET_EXCEL_CELL USING LV_ROW 5 GS_200-UKURS.

    PERFORM SET_EXCEL_CELL USING LV_ROW 6 GS_200-FFACT.

    PERFORM SET_EXCEL_CELL USING LV_ROW 7 GS_200-TFACT.

    PERFORM SET_EXCEL_CELL USING LV_ROW 8 GS_200-ERNAM.

    PERFORM SET_EXCEL_CELL USING LV_ROW 9 LV_DATE_ERDAT.



    LV_ROW = LV_ROW + 1.

  ENDLOOP.



  " ## ## ## ##

  CALL METHOD OF GO_WORKSHEET 'UsedRange' = LO_RANGE.

  CALL METHOD OF LO_RANGE 'Columns' = LO_COLUMNS.

  CALL METHOD OF LO_COLUMNS 'AutoFit'.



  " ## ##

  FREE OBJECT: LO_COLUMNS, LO_RANGE.



endform.




*&---------------------------------------------------------------------*

*&      Form  SET_EXCEL_CELL

*&---------------------------------------------------------------------*




form SET_EXCEL_CELL using P_ROW     TYPE I

                          P_COL     TYPE I

                          P_VALUE   TYPE ANY.

  DATA: LO_CELL TYPE OLE2_OBJECT.



  CALL METHOD OF GO_CELLS 'Item' = LO_CELL

    EXPORTING

      #1 = P_ROW

      #2 = P_COL.



  SET PROPERTY OF LO_CELL 'Value' = P_VALUE.



  FREE OBJECT LO_CELL.

endform.




*&---------------------------------------------------------------------*

*&      Form  SAVE_AS_PDF

*&---------------------------------------------------------------------*




form SAVE_AS_PDF.

  DATA: LV_SUBRC TYPE SY-SUBRC.



  " PDF ## ## ##

  PERFORM DIRECTORY_BROWSE.



  " PDF# ##

  CALL METHOD OF GO_WORKBOOK 'ExportAsFixedFormat'

    EXPORTING

      #1 = 0                    " xlTypePDF = 0

      #2 = GV_PDF_PATH          " Filename

      #3 = 0.                   " Quality: xlQualityStandard = 0



  LV_SUBRC = SY-SUBRC.



  IF LV_SUBRC = 0.

    CALL FUNCTION 'POPUP_TO_INFORM'

      EXPORTING

        TITEL = 'PDF ## ##'

        TXT1  = 'PDF ### #######.'

        TXT2  = GV_PDF_PATH.

  ELSE.

    MESSAGE 'PDF ## ##' TYPE 'E'.

  ENDIF.



endform.




*&---------------------------------------------------------------------*

*&      Form  CLOSE_EXCEL

*&---------------------------------------------------------------------*




form CLOSE_EXCEL.



  " Cells ## ##

  IF GO_CELLS IS NOT INITIAL.

    FREE OBJECT GO_CELLS.

  ENDIF.



  " Worksheet ## ##

  IF GO_WORKSHEET IS NOT INITIAL.

    FREE OBJECT GO_WORKSHEET.

  ENDIF.



  " Workbook ## (#### ##)

  IF GO_WORKBOOK IS NOT INITIAL.

    CALL METHOD OF GO_WORKBOOK 'Close'

      EXPORTING #1 = 0.

    FREE OBJECT GO_WORKBOOK.

  ENDIF.



  " Excel ##

  IF GO_EXCEL IS NOT INITIAL.

    CALL METHOD OF GO_EXCEL 'Quit'.

    FREE OBJECT GO_EXCEL.

  ENDIF.



endform.




*&---------------------------------------------------------------------*

*&      Form  DELETE_FILE

*&---------------------------------------------------------------------*




form DELETE_FILE.

  DATA: LV_RC     TYPE I,

        LV_EXIST  TYPE ABAP_BOOL.



  IF GV_TEMPLATE_PATH IS INITIAL.

    RETURN.

  ENDIF.



  " ## ## ## ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_EXIST

    EXPORTING

      FILE             = GV_TEMPLATE_PATH

    RECEIVING

      RESULT           = LV_EXIST

    EXCEPTIONS

      OTHERS           = 1.



  IF LV_EXIST = ABAP_TRUE.

    " ## ##

    CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_DELETE

      EXPORTING

        FILENAME             = GV_TEMPLATE_PATH

      CHANGING

        RC                   = LV_RC

      EXCEPTIONS

        FILE_DELETE_FAILED   = 1

        CNTL_ERROR          = 2

        ERROR_NO_GUI        = 3

        FILE_NOT_FOUND      = 4

        ACCESS_DENIED       = 5

        UNKNOWN_ERROR       = 6

        NOT_SUPPORTED_BY_GUI = 7

        WRONG_PARAMETER     = 8

        OTHERS              = 9.



    IF SY-SUBRC = 0.

      MESSAGE '## ### #######.' TYPE 'S'.

    ENDIF.

  ENDIF.



endform.