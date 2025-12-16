
*&---------------------------------------------------------------------*

*&  Include           ZWORK16_002_F01

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






*  DATA : BEGIN OF GS_EXCHANGE_RATE.

*    INCLUDE TYPE ZTCURR16.

*DATA : END OF GS_EXCHANGE_RATE.

*DATA : GT_EXCHANGE_RATE LIKE TABLE OF GS_EXCHANGE_RATE.



*DATA : BEGIN OF GS_EXCHANGE_RATE_ALV,

*         KURST    LIKE ZTCURR16-KURST, " ## ##

*         FCURR    LIKE ZTCURR16-FCURR, " ## ##

*         TCURR    LIKE ZTCURR16-TCURR, " ## ##

*         GDATU    LIKE ZTCURR16-GDATU, " ## ## ###

*         UKURS    LIKE ZTCURR16-UKURS, " ##

*         UKURS_DF TYPE DECFLOAT16,       " ALV ### DECFLOAT

*         FFACT    LIKE ZTCURR16-FFACT, " ## ## ### ##

*         TFACT    LIKE ZTCURR16-TFACT, " ## ## ### ##

*         SYUNAME  TYPE SY-UNAME,  " ###

*         SYDATUM  TYPE SY-DATUM,  " ###

*       END OF GS_EXCHANGE_RATE_ALV.

*DATA : GT_EXCHANGE_RATE_ALV LIKE TABLE OF GS_EXCHANGE_RATE_ALV.






  CLEAR GS_EXCHANGE_RATE.

  CLEAR GT_EXCHANGE_RATE.



  SELECT * FROM ZTCURR16 INTO TABLE GT_EXCHANGE_RATE

    WHERE GDATU = P_DATE.



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



  CLEAR GS_EXCHANGE_RATE_ALV.

  CLEAR GT_EXCHANGE_RATE_ALV.

  CLEAR GS_EXCHANGE_RATE.



  IF GT_EXCHANGE_RATE IS INITIAL.

    MESSAGE I001.

    STOP.

  ENDIF.



" GDATU# 99999999## ## ## # ##### ##

  LOOP AT GT_EXCHANGE_RATE INTO GS_EXCHANGE_RATE.

    MOVE-CORRESPONDING GS_EXCHANGE_RATE TO GS_EXCHANGE_RATE_ALV.



    GS_EXCHANGE_RATE_ALV-GDATU = 99999999 - GS_EXCHANGE_RATE-GDATU.

    GS_EXCHANGE_RATE_ALV-SYUNAME = GS_EXCHANGE_RATE-ERNAM.

    GS_EXCHANGE_RATE_ALV-SYDATUM = GS_EXCHANGE_RATE-ERDAT.



    APPEND GS_EXCHANGE_RATE_ALV TO GT_EXCHANGE_RATE_ALV.

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





" ALV ### ## ## ##

  CREATE OBJECT GC_CUSTOM

    EXPORTING




*     PARENT         =




      CONTAINER_NAME = 'CON1'




*     STYLE          =

*     LIFETIME       = lifetime_default

*     REPID          =

*     DYNNR          =

*     NO_AUTODEF_PROGID_DYNNR     =

*    EXCEPTIONS

*     CNTL_ERROR     = 1

*     CNTL_SYSTEM_ERROR           = 2

*     CREATE_ERROR   = 3

*     LIFETIME_ERROR = 4

*     LIFETIME_DYNPRO_DYNPRO_LINK = 5

*     OTHERS         = 6




    .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



  CREATE OBJECT GC_GRID

    EXPORTING




*     I_SHELLSTYLE      = 0

*     I_LIFETIME        =




      I_PARENT = GC_CUSTOM




*     I_APPL_EVENTS     = space

*     I_PARENTDBG       =

*     I_APPLOGPARENT    =

*     I_GRAPHICSPARENT  =

*     I_NAME   =

*     I_FCAT_COMPLETE   = SPACE

*    EXCEPTIONS

*     ERROR_CNTL_CREATE = 1

*     ERROR_CNTL_INIT   = 2

*     ERROR_CNTL_LINK   = 3

*     ERROR_DP_CREATE   = 4

*     OTHERS   = 5




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



" ALV FIELD CATALOG ##

  CLEAR GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 1.

  GS_FIELDCAT-FIELDNAME = 'KURST'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 2.

  GS_FIELDCAT-FIELDNAME = 'FCURR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 3.

  GS_FIELDCAT-FIELDNAME = 'TCURR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 4.

  GS_FIELDCAT-FIELDNAME = 'GDATU'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 5.

  GS_FIELDCAT-FIELDNAME = 'UKURS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-OUTPUTLEN = '15'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 6.

  GS_FIELDCAT-FIELDNAME = 'FFACT'.

  GS_FIELDCAT-SCRTEXT_M = '########'.

  GS_FIELDCAT-OUTPUTLEN = '15'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 7.

  GS_FIELDCAT-FIELDNAME = 'TFACT'.

  GS_FIELDCAT-SCRTEXT_M = '########'.

  GS_FIELDCAT-OUTPUTLEN = '15'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 8.

  GS_FIELDCAT-FIELDNAME = 'SYUNAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 9.

  GS_FIELDCAT-FIELDNAME = 'SYDATUM'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

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



" ALV LAYOUT ##

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.



  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.



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



" ALV ## ###

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*     I_BUFFER_ACTIVE =

*     I_BYPASSING_BUFFER            =

*     I_CONSISTENCY_CHECK           =

*     I_STRUCTURE_NAME              =




      IS_VARIANT      = GS_VARIANT




*     I_SAVE          =

*     I_DEFAULT       = 'X'




      IS_LAYOUT       = GS_LAYOUT




*     IS_PRINT        =

*     IT_SPECIAL_GROUPS             =

*     IT_TOOLBAR_EXCLUDING          =

*     IT_HYPERLINK    =

*     IT_ALV_GRAPHICS =

*     IT_EXCEPT_QINFO =

*     IR_SALV_ADAPTER =




    CHANGING

      IT_OUTTAB       = GT_EXCHANGE_RATE_ALV

      IT_FIELDCATALOG = GT_FIELDCAT




*     IT_SORT         =

*     IT_FILTER       =

*    EXCEPTIONS

*     INVALID_PARAMETER_COMBINATION = 1

*     PROGRAM_ERROR   = 2

*     TOO_MANY_LINES  = 3

*     OTHERS          = 4




    .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  PDF_DOWNLOAD

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM PDF_DOWNLOAD .






*1.######

*CL_GUI_FRONTEND_SERVICES=>GET_TEMP_DIRECTORY

*CL_GUI_FRONTEND_SERVICES=>DIRECTORY_BROWSE

*

*2.DOWNLOAD_TEMPLATE

*1)CALL FUNCTION 'WS_FILE_DELETE'

*2)SELECT FROM WWWDATA

*3)CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'

*

*3.OPEN_EXCEL_TEMPLATE

*EXCEL  TYPE OLE2_OBJECT (### : OLE2)

*CALL METHOD OF

* EXCEL

*CALL METHOD OF

* WORKBOOK

*

*4. FILL_EXCEL_LINE

*

*5. DELETE  FILE

*CL_GUI_FRONTEND_SERVICES=>FILE_DELETE






  DATA: LV_TEMP_DIR      TYPE STRING,

        LV_OUTPUT_DIR    TYPE STRING,

        LV_TEMP_FILEPATH TYPE STRING,

        LV_PDF_FILEPATH  TYPE STRING,

        LV_RC            TYPE I.



  " ## #### ##

  DATA: LV_TEMP_FILEPATH_C TYPE RLGRAP-FILENAME.



  DATA: LS_WWWDATA TYPE WWWDATA,

        LS_KEY     TYPE WWWDATATAB.



  " OLE ## ##

  DATA: HO_EXCEL     TYPE OLE2_OBJECT,

        HO_WORKBOOKS TYPE OLE2_OBJECT,

        HO_WORKBOOK  TYPE OLE2_OBJECT,

        HO_SHEET     TYPE OLE2_OBJECT,

        HO_CELL      TYPE OLE2_OBJECT.



  " ### # ## OLE ##

  DATA: HO_RANGE      TYPE OLE2_OBJECT,

        HO_BORDERS    TYPE OLE2_OBJECT,

        HO_COLUMNS    TYPE OLE2_OBJECT,

        HO_CELL_START TYPE OLE2_OBJECT,

        HO_CELL_END   TYPE OLE2_OBJECT.





  " 1. #### ## # ## ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>GET_TEMP_DIRECTORY

    CHANGING

      TEMP_DIR = LV_TEMP_DIR

    EXCEPTIONS

      OTHERS   = 4.

  IF SY-SUBRC <> 0. MESSAGE 'Temp directory error' TYPE 'E'. ENDIF.

  CALL METHOD CL_GUI_CFW=>FLUSH.



  CONCATENATE LV_TEMP_DIR '\temp_template.xlsx' INTO LV_TEMP_FILEPATH.

  LV_TEMP_FILEPATH_C = LV_TEMP_FILEPATH.



  CALL METHOD CL_GUI_FRONTEND_SERVICES=>DIRECTORY_BROWSE

    EXPORTING

      WINDOW_TITLE    = 'PDF ## ### #####'

    CHANGING

      SELECTED_FOLDER = LV_OUTPUT_DIR

    EXCEPTIONS

      OTHERS          = 4.

  IF SY-SUBRC <> 0 OR LV_OUTPUT_DIR IS INITIAL.

    MESSAGE '### #### #####.' TYPE 'S' DISPLAY LIKE 'W'. EXIT.

  ENDIF.



  CONCATENATE LV_OUTPUT_DIR '\Exchange_Rate_' SY-DATUM '.pdf' INTO LV_PDF_FILEPATH.





  " 2. ### #### (SMW0)

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_DELETE

    EXPORTING

      FILENAME = LV_TEMP_FILEPATH

    CHANGING

      RC       = LV_RC

    EXCEPTIONS

      OTHERS   = 9.



  LS_KEY-RELID = 'MI'.

  LS_KEY-OBJID = 'ZEXCEL16_TEMP_01'.



  SELECT SINGLE * FROM WWWDATA INTO LS_WWWDATA

    WHERE RELID = LS_KEY-RELID AND OBJID = LS_KEY-OBJID.



  CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'

    EXPORTING

      KEY         = LS_KEY

      DESTINATION = LV_TEMP_FILEPATH_C

    EXCEPTIONS

      OTHERS      = 1.





  " 3. ## ##

  CREATE OBJECT HO_EXCEL 'EXCEL.APPLICATION'.

  SET PROPERTY OF HO_EXCEL 'Visible' = 0.

  SET PROPERTY OF HO_EXCEL 'DisplayAlerts' = 0.



  CALL METHOD OF HO_EXCEL 'Workbooks' = HO_WORKBOOKS.

  CALL METHOD OF HO_WORKBOOKS 'Open' = HO_WORKBOOK EXPORTING #1 = LV_TEMP_FILEPATH.

  CALL METHOD OF HO_EXCEL 'Worksheets' = HO_SHEET EXPORTING #1 = 1.

  CALL METHOD OF HO_SHEET 'Activate'.





  " 4. ### ###

  DATA: LV_ROW TYPE I VALUE 2.



  LOOP AT GT_EXCHANGE_RATE_ALV INTO GS_EXCHANGE_RATE_ALV.

    PERFORM FILL_CELL USING HO_EXCEL LV_ROW 1 GS_EXCHANGE_RATE_ALV-KURST.

    PERFORM FILL_CELL USING HO_EXCEL LV_ROW 2 GS_EXCHANGE_RATE_ALV-FCURR.

    PERFORM FILL_CELL USING HO_EXCEL LV_ROW 3 GS_EXCHANGE_RATE_ALV-TCURR.

    PERFORM FILL_CELL USING HO_EXCEL LV_ROW 4 GS_EXCHANGE_RATE_ALV-GDATU.

    PERFORM FILL_CELL USING HO_EXCEL LV_ROW 5 GS_EXCHANGE_RATE_ALV-UKURS.

    PERFORM FILL_CELL USING HO_EXCEL LV_ROW 6 GS_EXCHANGE_RATE_ALV-FFACT.

    PERFORM FILL_CELL USING HO_EXCEL LV_ROW 7 GS_EXCHANGE_RATE_ALV-TFACT.

    PERFORM FILL_CELL USING HO_EXCEL LV_ROW 8 GS_EXCHANGE_RATE_ALV-SYUNAME.

    PERFORM FILL_CELL USING HO_EXCEL LV_ROW 9 GS_EXCHANGE_RATE_ALV-SYDATUM.

    ADD 1 TO LV_ROW.

  ENDLOOP.





  " ### ### & ## ## ##

  DATA: LV_LAST_ROW TYPE I.

  LV_LAST_ROW = LV_ROW - 1. " #### ### ### # ##



  IF LV_LAST_ROW >= 1.

    " (1) ## ##: A1(1,1) ## ######(lv_last_row, 9) ##

    CALL METHOD OF HO_SHEET 'Cells' = HO_CELL_START EXPORTING #1 = 1 #2 = 1.

    CALL METHOD OF HO_SHEET 'Cells' = HO_CELL_END EXPORTING #1 = LV_LAST_ROW #2 = 9.



    CALL METHOD OF HO_SHEET 'Range' = HO_RANGE

      EXPORTING #1 = HO_CELL_START #2 = HO_CELL_END.



    " (2) ### ## ### (LineStyle = 1 : ##)

    GET PROPERTY OF HO_RANGE 'Borders' = HO_BORDERS.

    SET PROPERTY OF HO_BORDERS 'LineStyle' = 1.



    " (3) ## ## ## (AutoFit) -> ## # ### #

    GET PROPERTY OF HO_SHEET 'Columns' = HO_COLUMNS.

    CALL METHOD OF HO_COLUMNS 'AutoFit'.



    FREE OBJECT: HO_BORDERS, HO_RANGE, HO_CELL_START, HO_CELL_END, HO_COLUMNS.

  ENDIF.

  " -------------------------------------------------------





  " 5. PDF ## # ##

  CALL METHOD OF HO_WORKBOOK 'ExportAsFixedFormat'

    EXPORTING

      #1 = 0

      #2 = LV_PDF_FILEPATH.



  CALL METHOD OF HO_WORKBOOK 'Close' EXPORTING #1 = 0.

  CALL METHOD OF HO_EXCEL 'Quit'.



  FREE OBJECT: HO_SHEET, HO_WORKBOOK, HO_WORKBOOKS, HO_EXCEL.



  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_DELETE

    EXPORTING

      FILENAME = LV_TEMP_FILEPATH

    CHANGING

      RC       = LV_RC.



  MESSAGE 'PDF ##### #######.' TYPE 'S'.



ENDFORM.



FORM FILL_CELL USING PO_EXCEL TYPE OLE2_OBJECT

                     PV_ROW   TYPE I

                     PV_COL   TYPE I

                     PV_VAL   TYPE ANY.

  DATA: LO_CELL TYPE OLE2_OBJECT.

  CALL METHOD OF PO_EXCEL 'Cells' = LO_CELL EXPORTING #1 = PV_ROW #2 = PV_COL.

  SET PROPERTY OF LO_CELL 'Value' = PV_VAL.

  FREE OBJECT LO_CELL.

ENDFORM.