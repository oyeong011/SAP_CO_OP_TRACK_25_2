
*&---------------------------------------------------------------------*

*&  Include           ZWORK14_002_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  DOWNLOAD_PDF

*&---------------------------------------------------------------------*

*       pdf ####

*----------------------------------------------------------------------*




FORM DOWNLOAD_PDF .



  DATA: LO_BOOKS TYPE OLE2_OBJECT. "## ### ##

  DATA: LO_CELL TYPE OLE2_OBJECT.  "## # ##



  DATA: LV_TEMP_DIR TYPE STRING,   "## ## ##

        LV_TEMP_FILE TYPE STRING,  "## ## ## ##

        LV_SELECTED_DIR TYPE STRING,  "#### ### ## ##

        LV_PDF_FILE TYPE STRING.   "## ## PDF ## ##



  DATA: LS_WWWDATA TYPE WWWDATATAB,  "SMW0 #### ##

        LV_FILENAME TYPE RLGRAP-FILENAME,  "#### ### ##

        LV_RC TYPE I.  " ## ##



  DATA: LO_RANGE TYPE OLE2_OBJECT,     "## ##

        LO_BORDERS TYPE OLE2_OBJECT,   "### ##

        LO_COL TYPE OLE2_OBJECT,       "## ##

        LO_PAGESETUP TYPE OLE2_OBJECT. "### ##



  DATA: LV_ROW TYPE I.  "## # ###



  IF GT_OUT IS INITIAL.  "### ##

    MESSAGE '### #### ####.' TYPE 'S' DISPLAY LIKE 'W'.

    RETURN.

  ENDIF.



  "1.#### ## - ## ## ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>GET_TEMP_DIRECTORY

    CHANGING TEMP_DIR = LV_TEMP_DIR

    EXCEPTIONS OTHERS = 1.

  CL_GUI_CFW=>FLUSH( ).



  IF LV_TEMP_DIR IS INITIAL.

    MESSAGE '## #### ##' TYPE 'E'.

    RETURN.

  ENDIF.



  "#### #### ##

  CONCATENATE LV_TEMP_DIR '\Template.xlsx' INTO LV_TEMP_FILE.



  "## ## ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>DIRECTORY_BROWSE

    EXPORTING WINDOW_TITLE = 'PDF ## ## ##'

    CHANGING SELECTED_FOLDER = LV_SELECTED_DIR

    EXCEPTIONS OTHERS = 1.



  IF LV_SELECTED_DIR IS INITIAL.

    MESSAGE '#######.' TYPE 'S'.

    RETURN.

  ENDIF.



  "## pdf ## ## ##

  CONCATENATE LV_SELECTED_DIR '\Result.pdf' INTO LV_PDF_FILE.



  "2.DOWNLOAD_TEMPLATE

  LV_FILENAME = LV_TEMP_FILE.  "#### #### ##

  CALL FUNCTION 'WS_FILE_DELETE'

    EXPORTING FILE = LV_FILENAME

    EXCEPTIONS OTHERS = 1.



  "SMW0 ## ####

  SELECT SINGLE * INTO CORRESPONDING FIELDS OF LS_WWWDATA

    FROM WWWDATA WHERE OBJID = 'ZWORK14_TEMPLATE'.



  IF SY-SUBRC <> 0.

    MESSAGE 'SMW0 ##(ZWORK14_FORM)# ## # ####.' TYPE 'E'.

    RETURN.

  ENDIF.



  "# ##### pc# ## ### ####

  LV_FILENAME = LV_TEMP_FILE.

  CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'

    EXPORTING KEY = LS_WWWDATA DESTINATION = LV_FILENAME

    EXCEPTIONS OTHERS = 1.



  IF SY-SUBRC <> 0.

    MESSAGE '### #### ##' TYPE 'E'.

    RETURN.

  ENDIF.



  "3.OPEN_EXCEL_TEMPLATE

  CREATE OBJECT GO_APPLICATION 'EXCEL.APPLICATION'.  "## ##



  IF SY-SUBRC <> 0 OR GO_APPLICATION IS INITIAL.

    MESSAGE '## ##### ### # ####.' TYPE 'E'.

    RETURN.

  ENDIF.



  "## ### ## & ## ## ###

  SET PROPERTY OF GO_APPLICATION 'DISPLAYALERTS' = 0.

  SET PROPERTY OF GO_APPLICATION 'VISIBLE' = 1.

  CALL METHOD OF GO_APPLICATION 'WORKBOOKS' = LO_BOOKS.

  CALL METHOD OF LO_BOOKS 'OPEN' = GO_WBOOK  "### ## ##

    EXPORTING #1 = LV_TEMP_FILE.



  IF SY-SUBRC <> 0 OR GO_WBOOK IS INITIAL.

    MESSAGE '## ### # # ####.' TYPE 'E'.

    CALL METHOD OF GO_APPLICATION 'QUIT'.

    FREE OBJECT: GO_APPLICATION, LO_BOOKS.

    RETURN.

  ENDIF.



  "## ## ####

  CALL METHOD OF GO_APPLICATION 'ACTIVESHEET' = GO_SHEET.



  IF SY-SUBRC <> 0 OR GO_SHEET IS INITIAL.

    MESSAGE '## ### ## # ####.' TYPE 'E'.

    CALL METHOD OF GO_WBOOK 'CLOSE' EXPORTING #1 = 0.

    CALL METHOD OF GO_APPLICATION 'QUIT'.

    FREE OBJECT: GO_WBOOK, LO_BOOKS, GO_APPLICATION.

    RETURN.

  ENDIF.



  "4.FILL_EXCEL_LINE

  LV_ROW = 2.

  LOOP AT GT_OUT INTO GS_OUT.  "### ###

    "1# : ####

    CALL METHOD OF GO_SHEET 'CELLS' = LO_CELL EXPORTING #1 = LV_ROW #2 = 1.

    SET PROPERTY OF LO_CELL 'VALUE' = GS_OUT-KURST.

    FREE OBJECT LO_CELL.

    "2# : ####

    CALL METHOD OF GO_SHEET 'CELLS' = LO_CELL EXPORTING #1 = LV_ROW #2 = 2.

    SET PROPERTY OF LO_CELL 'VALUE' = GS_OUT-FCURR.

    FREE OBJECT LO_CELL.

    "3# : ####

    CALL METHOD OF GO_SHEET 'CELLS' = LO_CELL EXPORTING #1 = LV_ROW #2 = 3.

    SET PROPERTY OF LO_CELL 'VALUE' = GS_OUT-TCURR.

    FREE OBJECT LO_CELL.

    "4# : ####

    CALL METHOD OF GO_SHEET 'CELLS' = LO_CELL EXPORTING #1 = LV_ROW #2 = 4.

    SET PROPERTY OF LO_CELL 'VALUE' = GS_OUT-GDATU.

    FREE OBJECT LO_CELL.

    "5# : ##

    CALL METHOD OF GO_SHEET 'CELLS' = LO_CELL EXPORTING #1 = LV_ROW #2 = 5.

    SET PROPERTY OF LO_CELL 'VALUE' = GS_OUT-UKURS.

    FREE OBJECT LO_CELL.

    "6# : ######

    CALL METHOD OF GO_SHEET 'CELLS' = LO_CELL EXPORTING #1 = LV_ROW #2 = 6.

    SET PROPERTY OF LO_CELL 'VALUE' = GS_OUT-FFACT.

    FREE OBJECT LO_CELL.

    "7# : ######

    CALL METHOD OF GO_SHEET 'CELLS' = LO_CELL EXPORTING #1 = LV_ROW #2 = 7.

    SET PROPERTY OF LO_CELL 'VALUE' = GS_OUT-TFACT.

    FREE OBJECT LO_CELL.

    "8# : ###

    CALL METHOD OF GO_SHEET 'CELLS' = LO_CELL EXPORTING #1 = LV_ROW #2 = 8.

    SET PROPERTY OF LO_CELL 'VALUE' = GS_OUT-UNAME.

    FREE OBJECT LO_CELL.

    "9# : ###

    CALL METHOD OF GO_SHEET 'CELLS' = LO_CELL EXPORTING #1 = LV_ROW #2 = 9.

    SET PROPERTY OF LO_CELL 'VALUE' = GS_OUT-DATUM.

    FREE OBJECT LO_CELL.



    LV_ROW = LV_ROW + 1.

  ENDLOOP.



  "6, 7, 8## ## ## ###

  CALL METHOD OF GO_SHEET 'COLUMNS' = LO_COL EXPORTING #1 = 6.

  SET PROPERTY OF LO_COL 'COLUMNWIDTH' = 15.

  FREE OBJECT LO_COL.

  CALL METHOD OF GO_SHEET 'COLUMNS' = LO_COL EXPORTING #1 = 7.

  SET PROPERTY OF LO_COL 'COLUMNWIDTH' = 15.

  FREE OBJECT LO_COL.

  CALL METHOD OF GO_SHEET 'COLUMNS' = LO_COL EXPORTING #1 = 9.

  SET PROPERTY OF LO_COL 'COLUMNWIDTH' = 10.

  FREE OBJECT LO_COL.



  CALL METHOD OF GO_SHEET 'USEDRANGE' = LO_RANGE.  "#### ## ## ##

  CALL METHOD OF LO_RANGE 'BORDERS' = LO_BORDERS.  "### ### ##

  SET PROPERTY OF LO_BORDERS 'LINESTYLE' = 1.

  SET PROPERTY OF LO_BORDERS 'WEIGHT' = 2.

  FREE OBJECT: LO_BORDERS, LO_RANGE.



  CALL METHOD OF GO_SHEET 'PAGESETUP' = LO_PAGESETUP.  "#### ## ##

  SET PROPERTY OF LO_PAGESETUP 'ORIENTATION' = 2.

  SET PROPERTY OF LO_PAGESETUP 'FITTOPAGESWIDE' = 1.

  FREE OBJECT LO_PAGESETUP.



  CALL METHOD OF GO_SHEET 'EXPORTASFIXEDFORMAT'  "PDF ##

    EXPORTING #1 = 0 #2 = LV_PDF_FILE.



  IF SY-SUBRC = 0.

    MESSAGE 'PDF ### #######.' TYPE 'S'.

  ELSE.

    MESSAGE 'PDF ## ## (## ##)' TYPE 'E'.

  ENDIF.



  CALL METHOD OF GO_WBOOK 'CLOSE' EXPORTING #1 = 0.  "## ## # #### ##

  CALL METHOD OF GO_APPLICATION 'QUIT'.

  FREE OBJECT: LO_CELL, GO_SHEET, GO_WBOOK, GO_APPLICATION.



  "5.DELETE_FILE

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_DELETE  "## ### ## ##

    EXPORTING FILENAME = LV_TEMP_FILE

    CHANGING RC = LV_RC.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       ### ##

*----------------------------------------------------------------------*




FORM GET_DATA .



  CLEAR GT_OUT.

  SELECT * FROM ZTCURR14

    INTO CORRESPONDING FIELDS OF TABLE GT_OUT

    WHERE GDATU = P_DATE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       Custom Container # ALV Grid ## ##

*----------------------------------------------------------------------*




FORM CREATE_OBJECT .



  CREATE OBJECT GO_CUSTOM

    EXPORTING

      CONTAINER_NAME = 'CON1'.



  CREATE OBJECT GO_GRID

    EXPORTING

      I_PARENT = GO_CUSTOM.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*

*       ALV ## #### ## ##

*----------------------------------------------------------------------*




FORM FIELD_CATALOG .



  CLEAR : GT_FCAT.

  PERFORM SET_FCAT USING :

    'KURST' '####' '' 10 CHANGING GT_FCAT,

    'FCURR' '####' '' 10 CHANGING GT_FCAT,

    'TCURR' '####' '' 10 CHANGING GT_FCAT,

    'GDATU' '####' '' 12 CHANGING GT_FCAT,

    'UKURS' '##'     '' 15 CHANGING GT_FCAT,

    'FFACT' '########' '' 14 CHANGING GT_FCAT,

    'TFACT' '########' '' 14 CHANGING GT_FCAT,

    'UNAME' '###'   '' 12 CHANGING GT_FCAT,

    'DATUM' '###'   '' 12 CHANGING GT_FCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

*       ALV #### ##

*----------------------------------------------------------------------*




FORM ALV_LAYOUT .



  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_METHOD

*&---------------------------------------------------------------------*

*       ALV ## # ### ##

*----------------------------------------------------------------------*




FORM CALL_METHOD .



  CALL METHOD GO_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_LAYOUT = GS_LAYOUT

    CHANGING

      IT_OUTTAB = GT_OUT

      IT_FIELDCATALOG = GT_FCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH_ALV

*&---------------------------------------------------------------------*

*       ALV ### REFRESH

*----------------------------------------------------------------------*




FORM REFRESH_ALV .



  DATA: LS_STABLE TYPE LVC_S_STBL.



  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GO_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE = LS_STABLE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_FCAT

*&---------------------------------------------------------------------*

*       ## #### #### ##

*----------------------------------------------------------------------*




FORM SET_FCAT USING PV_FLD PV_TXT PV_EDIT PV_LEN

              CHANGING CT_FCAT TYPE LVC_T_FCAT.



  DATA : LS_FCAT TYPE LVC_S_FCAT.



  LS_FCAT-FIELDNAME = PV_FLD.

  LS_FCAT-COLTEXT = PV_TXT.

  LS_FCAT-EDIT = PV_EDIT.

  LS_FCAT-OUTPUTLEN = PV_LEN.

  LS_FCAT-JUST      = 'R'.



  APPEND LS_FCAT TO CT_FCAT.



ENDFORM.