
"""ZWORK11_002_F01_PDF

FORM SAVE_DATA .

  DATA : LV_DIR_PATH TYPE STRING,

         LV_PDF_FILENAME TYPE STRING VALUE '\######.pdf',

         LV_EXCEL_FILENAME TYPE STRING VALUE '\######.xlsx',

         LV_PDF_FULLPATH TYPE STRING,

         LV_EXCEL_FULLPATH TYPE STRING,

         LV_PDF_RLGRAP TYPE RLGRAP-FILENAME,

         LV_EXCEL_RLGRAP TYPE RLGRAP-FILENAME.



  "1. ## #### ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>GET_TEMP_DIRECTORY

    CHANGING

      TEMP_DIR = LV_DIR_PATH.



  "1-1. #### PATH ####

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>DIRECTORY_BROWSE

    CHANGING

      SELECTED_FOLDER = LV_DIR_PATH.



  "1-2. ### ## ## PATH ##

  CONCATENATE LV_DIR_PATH LV_PDF_FILENAME INTO LV_PDF_FULLPATH.

  CONCATENATE LV_DIR_PATH LV_EXCEL_FILENAME INTO LV_EXCEL_FULLPATH.

  LV_PDF_RLGRAP = LV_PDF_FULLPATH.

  LV_EXCEL_RLGRAP = LV_EXCEL_FULLPATH.



  "2. #### TEMPLATE

  DATA : LS_WWWDATA TYPE WWWDATATAB.



  "2-1. ### ## ### ### ### ##

  CALL FUNCTION 'WS_FILE_DELETE'

    EXPORTING

      FILE = LV_PDF_RLGRAP.



  IF SY-SUBRC <> 0.

    MESSAGE '### ## ##' TYPE 'I'.

  ENDIF.



  "2-2. SAP # ###### ### ### ##### ##

  SELECT SINGLE * FROM WWWDATA

    INTO CORRESPONDING FIELDS OF LS_WWWDATA

    WHERE OBJID = 'ZCURR24_TEMPLATE'.



  "2-2-1. ####

  IF SY-SUBRC <> 0.

    MESSAGE '# ####### #### ## # ####.' TYPE 'E'.

  ENDIF.



  "2-3. SAP # ####### ## ### ## PC# ####

  CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'

    EXPORTING

      KEY = LS_WWWDATA

      DESTINATION = LV_EXCEL_RLGRAP.



  IF SY-SUBRC = 0.

    MESSAGE |### ### { LV_EXCEL_RLGRAP } # #########.| TYPE 'S'.

  ELSE.

    MESSAGE '### ### #### ## #####' TYPE 'I'.

  ENDIF.



  "3. OPEN_EXCEL_EMPLATE

  "3-1. EXCEL OLE ## ##

  DATA : EXCEL TYPE OLE2_OBJECT,

         WORKBOOKS TYPE OLE2_OBJECT,

         WORKBOOK TYPE OLE2_OBJECT,

         WORKSHEET TYPE OLE2_OBJECT,

         SHEETS TYPE OLE2_OBJECT,

         CELL TYPE OLE2_OBJECT,

         LV_RC TYPE I.



  CREATE OBJECT EXCEL 'EXCEL.APPLICATION'.



  CALL METHOD OF EXCEL 'WORKBOOKS' = WORKBOOKS.

  CALL METHOD OF WORKBOOKS 'Open' = WORKBOOK

    EXPORTING

      #1 = LV_EXCEL_RLGRAP.



  IF SY-SUBRC <> 0.

    MESSAGE |## ##(LV_EXCEL_PATH)# OLE# ## # ######. SMW0# ### ### ###### #####.|

            TYPE 'S' DISPLAY LIKE 'E'.

    STOP.

  ENDIF.



  GET PROPERTY OF EXCEL 'ACTIVESHEET' = WORKSHEET.





  "4. FILL_EXCEL_LINE

  DATA : LT_ALV LIKE TABLE OF GS_OUTPUT,

         LS_ALV LIKE GS_OUTPUT,

         LV_ROW TYPE I VALUE 2.



  "## ##

  CALL METHOD OF worksheet 'Cells' = cell EXPORTING #1 = 1 #2 = 1.

  SET PROPERTY OF cell 'Value' = '####'.

  CALL METHOD OF worksheet 'Cells' = cell EXPORTING #1 = 1 #2 = 2.

  SET PROPERTY OF cell 'Value' = '####'.

  CALL METHOD OF worksheet 'Cells' = cell EXPORTING #1 = 1 #2 = 3.

  SET PROPERTY OF cell 'Value' = '####'.

  CALL METHOD OF worksheet 'Cells' = cell EXPORTING #1 = 1 #2 = 4.

  SET PROPERTY OF cell 'Value' = '####'.

  CALL METHOD OF worksheet 'Cells' = cell EXPORTING #1 = 1 #2 = 5.

  SET PROPERTY OF cell 'Value' = '##'.

  CALL METHOD OF worksheet 'Cells' = cell EXPORTING #1 = 1 #2 = 6.

  SET PROPERTY OF cell 'Value' = '########'.

  CALL METHOD OF worksheet 'Cells' = cell EXPORTING #1 = 1 #2 = 7.

  SET PROPERTY OF cell 'Value' = '########'.

  CALL METHOD OF worksheet 'Cells' = cell EXPORTING #1 = 1 #2 = 8.

  SET PROPERTY OF cell 'Value' = '###'.

  CALL METHOD OF worksheet 'Cells' = cell EXPORTING #1 = 1 #2 = 9.

  SET PROPERTY OF cell 'Value' = '###'.







  "NOT EMPTY

  LOOP AT GT_OUTPUT INTO LS_ALV.

    " EXCEL 1# ## ##

    CALL METHOD OF WORKSHEET 'Cells' = CELL

      EXPORTING

        #1 = LV_ROW

        #2 = 1.



    SET PROPERTY OF CELL 'Value' = LS_ALV-KURST.



    " EXCEL 2# ## ##

   CALL METHOD OF WORKSHEET 'Cells' = CELL

      EXPORTING

        #1 = LV_ROW

        #2 = 2.



    SET PROPERTY OF CELL 'Value' = LS_ALV-FCURR.



    " EXCEL 3# ## ##

    CALL METHOD OF WORKSHEET 'Cells' = CELL

      EXPORTING

        #1 = LV_ROW

        #2 = 3.



    SET PROPERTY OF CELL 'Value' = LS_ALV-TCURR.



    " EXCEL 4# ## ##

    CALL METHOD OF WORKSHEET 'Cells' = CELL

      EXPORTING

        #1 = LV_ROW

        #2 = 4.



    SET PROPERTY OF CELL 'Value' = LS_ALV-GDATU.



    " EXCEL 5# ##

    CALL METHOD OF WORKSHEET 'Cells' = CELL

      EXPORTING

        #1 = LV_ROW

        #2 = 5.



    SET PROPERTY OF CELL 'Value' = LS_ALV-UKURS.



    " EXCEL 6# ########

    CALL METHOD OF WORKSHEET 'Cells' = CELL

      EXPORTING

        #1 = LV_ROW

        #2 = 6.



    SET PROPERTY OF CELL 'Value' = LS_ALV-FFACT.



    " EXCEL 7# ########

    CALL METHOD OF WORKSHEET 'Cells' = CELL

      EXPORTING

        #1 = LV_ROW

        #2 = 7.



    SET PROPERTY OF CELL 'Value' = LS_ALV-TFACT.



    " EXCEL 8# ###

    CALL METHOD OF WORKSHEET 'Cells' = CELL

      EXPORTING

        #1 = LV_ROW

        #2 = 8.



    SET PROPERTY OF CELL 'Value' = LS_ALV-WRITER.



    " EXCEL 9# ###

    CALL METHOD OF WORKSHEET 'Cells' = CELL

      EXPORTING

        #1 = LV_ROW

        #2 = 9.



    SET PROPERTY OF CELL 'Value' = LS_ALV-EDATE.



    LV_ROW = LV_ROW + 1.

  ENDLOOP.



  "Draw borders

  DATA : RANGE TYPE OLE2_OBJECT,

         BORDERS TYPE OLE2_OBJECT,

         INTERIOR TYPE OLE2_OBJECT,

         LV_BORDER_ROW TYPE I.





  "DRAW HEADER BORDER

  CALL METHOD OF WORKSHEET 'RANGE' = RANGE

    EXPORTING

      #1 = 'A1'

      #2 = 'I1'.



  "delete header highlight

  GET PROPERTY OF RANGE 'Interior' = INTERIOR.

  SET PROPERTY OF INTERIOR 'ColorIndex' = -4142.  " xlNone (### ##)



  "draw header border

  CALL METHOD OF RANGE 'BORDERS' = BORDERS EXPORTING #1 = 7.

  SET PROPERTY OF BORDERS 'LINESTYLE' = 1.

  CALL METHOD OF RANGE 'BORDERS' = BORDERS EXPORTING #1 = 8.

  SET PROPERTY OF BORDERS 'LINESTYLE' = 1.

  CALL METHOD OF RANGE 'BORDERS' = BORDERS EXPORTING #1 = 9.

  SET PROPERTY OF BORDERS 'LINESTYLE' = 1.

  CALL METHOD OF RANGE 'BORDERS' = BORDERS EXPORTING #1 = 10.

  SET PROPERTY OF BORDERS 'LINESTYLE' = 1.

  CALL METHOD OF RANGE 'BORDERS' = BORDERS EXPORTING #1 = 11.

  SET PROPERTY OF BORDERS 'LINESTYLE' = 1.



  "DRAW DATA BORDER

    "### ### (2###)

  LV_BORDER_ROW = 2.

  LOOP AT GT_OUTPUT INTO LS_ALV.

    DATA(LV_START_CELL) = |A{ LV_BORDER_ROW }|.

    DATA(LV_END_CELL) = |I{ LV_BORDER_ROW }|.



    CALL METHOD OF WORKSHEET 'RANGE' = RANGE

      EXPORTING

        #1 = LV_START_CELL

        #2 = LV_END_CELL.



    " ## ###

    CALL METHOD OF RANGE 'BORDERS' = BORDERS

      EXPORTING #1 = 7.

    SET PROPERTY OF BORDERS 'LINESTYLE' = 1.



    " ### ###

    CALL METHOD OF RANGE 'BORDERS' = BORDERS

      EXPORTING #1 = 8.

    SET PROPERTY OF BORDERS 'LINESTYLE' = 1.



    " ## ###

    CALL METHOD OF RANGE 'BORDERS' = BORDERS

      EXPORTING #1 = 9.

    SET PROPERTY OF BORDERS 'LINESTYLE' = 1.



    " ### ###

    CALL METHOD OF RANGE 'BORDERS' = BORDERS

      EXPORTING #1 = 10.

    SET PROPERTY OF BORDERS 'LINESTYLE' = 1.



    " ### ## ### (# ##)

    CALL METHOD OF RANGE 'BORDERS' = BORDERS

      EXPORTING #1 = 11.

    SET PROPERTY OF BORDERS 'LINESTYLE' = 1.



    LV_BORDER_ROW = LV_BORDER_ROW + 1.

  ENDLOOP.



  "Set the zoom

  DATA : PAGE_SETTING TYPE OLE2_OBJECT.

  GET PROPERTY OF WORKSHEET 'PAGESETUP' = PAGE_SETTING.

  SET PROPERTY OF PAGE_SETTING 'ZOOM' = ABAP_FALSE.



 CALL METHOD OF WORKBOOK 'SAVE'.



  "5. PDF# #### (## ##)

  CALL METHOD OF WORKBOOK 'ExportAsFixedFormat'

    EXPORTING

      #1 = 0        "Type (xlTypePDF)

      #2 = LV_PDF_RLGRAP. "Filename (PDF ##)





  "6. ## # ##

  CALL METHOD OF WORKBOOK 'CLOSE'.

  CALL METHOD OF EXCEL 'QUIT'.

  FREE OBJECT WORKBOOK.

  FREE OBJECT EXCEL.



  "7. DELETE FILE ## ## ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_DELETE

    EXPORTING

      FILENAME = LV_EXCEL_FULLPATH

    CHANGING

      RC = LV_RC

    EXCEPTIONS

       FILE_DELETE_FAILED   = 1

       CNTL_ERROR           = 2

       ERROR_NO_GUI         = 3

       FILE_NOT_FOUND       = 4

       ACCESS_DENIED        = 5

       UNKNOWN_ERROR        = 6

       NOT_SUPPORTED_BY_GUI = 7

       WRONG_PARAMETER      = 8

       others               = 9.



  IF SY-SUBRC <> 0.

    MESSAGE |PDF ## ## ## ## : { SY-SUBRC }| TYPE 'I'.

  ENDIF.



  MESSAGE |PDF ### #######:| TYPE 'S'.

ENDFORM.