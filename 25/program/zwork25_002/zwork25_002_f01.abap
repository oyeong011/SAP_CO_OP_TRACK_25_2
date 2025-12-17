
*&---------------------------------------------------------------------*

*&  Include           ZWORK25_002_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  CHECK_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_DATA.

  IF P_DATE IS INITIAL.

    MESSAGE '## ### #####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

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



  DATA: LT_TEMP       TYPE TABLE OF TY_DATA,

        LV_GDATU_NUM  TYPE I,

        LV_NORMAL_NUM TYPE I,

        LV_NORMAL_STR TYPE CHAR8,

        LV_ANSWER     TYPE C.



  CLEAR GT_DATA. REFRESH GT_DATA.

  GV_DATE_SEARCH = P_DATE.



  " ### ## ### ##

  SELECT MANDT KURST FCURR TCURR GDATU UKURS FFACT TFACT ERNAM ERDAT

    FROM ZTCURR25

    INTO TABLE LT_TEMP

    WHERE GDATU = GV_DATE_SEARCH.



  IF SY-SUBRC <> 0 OR LT_TEMP IS INITIAL.

    CALL FUNCTION 'POPUP_TO_CONFIRM'

      EXPORTING

        TITLEBAR              = '### ##'

        TEXT_QUESTION         = '## ### ## ### #### ####.'

        TEXT_BUTTON_1         = '##'

        ICON_BUTTON_1         = 'ICON_OKAY'

        TEXT_BUTTON_2         = '## ##'

        DEFAULT_BUTTON        = '1'

        DISPLAY_CANCEL_BUTTON = ''

      IMPORTING

        ANSWER                = LV_ANSWER.

    LEAVE LIST-PROCESSING.

  ENDIF.



  LOOP AT LT_TEMP INTO DATA(LS_TEMP).



    " ## #### ## ##### ##

    READ TABLE GT_DATA TRANSPORTING NO FIELDS

      WITH KEY KURST = LS_TEMP-KURST

               FCURR = LS_TEMP-FCURR

               TCURR = LS_TEMP-TCURR.



    IF SY-SUBRC = 0.

      CONTINUE.   " #### ####

    ENDIF.



    " ### ## ###

    CLEAR GS_DATA.

    MOVE-CORRESPONDING LS_TEMP TO GS_DATA.   " ### ERNAM, ERDAT ###



    " GDATU # ## ## ##

    LV_GDATU_NUM  = GS_DATA-GDATU.

    LV_NORMAL_NUM = 99999999 - LV_GDATU_NUM.

    LV_NORMAL_STR = |{ LV_NORMAL_NUM WIDTH = 8 PAD = '0' }|.

    GS_DATA-VALID_FROM = LV_NORMAL_STR.



    APPEND GS_DATA TO GT_DATA.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_ALV_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_ALV_OBJECT .

  IF GO_CONTAINER IS INITIAL.

    CREATE OBJECT GO_CONTAINER

      EXPORTING

        CONTAINER_NAME = 'CNT_ALV'.



    CREATE OBJECT GO_GRID

      EXPORTING

        I_PARENT = GO_CONTAINER.



    GV_ALV_CREATED = 'X'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_ALV_LAYOUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_ALV_LAYOUT .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA  = 'X'. "### ##

  GS_LAYOUT-CWIDTH_OPT = 'X'. "## ## ## ###

  GS_LAYOUT-SEL_MODE = 'A'. "# ## ##



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_ALV_FIELDCAT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_ALV_FIELDCAT.



  REFRESH GT_FCAT.



  " 1. ####

  CLEAR GS_FCAT.

  GS_FCAT-FIELDNAME = 'KURST'.

  GS_FCAT-COLTEXT   = '####'.

  GS_FCAT-JUST      = 'C'.        " ### ##

  GS_FCAT-OUTPUTLEN = 10.

  GS_FCAT-COL_POS   = 1.

  APPEND GS_FCAT TO GT_FCAT.



  " 2. ####

  CLEAR GS_FCAT.

  GS_FCAT-FIELDNAME = 'FCURR'.

  GS_FCAT-COLTEXT   = '####'.

  GS_FCAT-JUST      = 'C'.

  GS_FCAT-OUTPUTLEN = 10.

  GS_FCAT-COL_POS   = 2.

  APPEND GS_FCAT TO GT_FCAT.



  " 3. ####

  CLEAR GS_FCAT.

  GS_FCAT-FIELDNAME = 'TCURR'.

  GS_FCAT-COLTEXT   = '####'.

  GS_FCAT-JUST      = 'C'.

  GS_FCAT-OUTPUTLEN = 10.

  GS_FCAT-COL_POS   = 3.

  APPEND GS_FCAT TO GT_FCAT.



  " 4. #### (GDATU # ### ## ##)

  CLEAR GS_FCAT.

  GS_FCAT-FIELDNAME = 'VALID_FROM'.

  GS_FCAT-COLTEXT   = '####'.

  GS_FCAT-JUST      = 'C'.

  GS_FCAT-OUTPUTLEN = 12.

  GS_FCAT-EDIT_MASK = '____.__.__'.   " YYYY.MM.DD ## ## ##

  GS_FCAT-COL_POS   = 4.

  APPEND GS_FCAT TO GT_FCAT.



  " 5. ##

  CLEAR GS_FCAT.

  GS_FCAT-FIELDNAME = 'UKURS'.

  GS_FCAT-COLTEXT   = '##'.

  GS_FCAT-JUST      = 'R'.        " ### ##

  GS_FCAT-OUTPUTLEN = 18.

  GS_FCAT-DECIMALS_O = 6.       " ### 6####

  GS_FCAT-COL_POS   = 5.

  APPEND GS_FCAT TO GT_FCAT.



  " 6. ########

  CLEAR GS_FCAT.

  GS_FCAT-FIELDNAME = 'FFACT'.

  GS_FCAT-COLTEXT   = '########'.

  GS_FCAT-JUST      = 'R'.

  GS_FCAT-OUTPUTLEN = 12.

  GS_FCAT-COL_POS   = 6.

  APPEND GS_FCAT TO GT_FCAT.



  " 7. ######## (To Factor)

  CLEAR GS_FCAT.

  GS_FCAT-FIELDNAME = 'TFACT'.

  GS_FCAT-COLTEXT   = '########'.

  GS_FCAT-JUST      = 'R'.

  GS_FCAT-OUTPUTLEN = 12.

  GS_FCAT-COL_POS   = 7.

  APPEND GS_FCAT TO GT_FCAT.



  " 8. ###

  CLEAR GS_FCAT.

  GS_FCAT-FIELDNAME = 'ERNAM'.

  GS_FCAT-COLTEXT   = '###'.

  GS_FCAT-JUST      = 'C'.

  GS_FCAT-OUTPUTLEN = 12.

  GS_FCAT-COL_POS   = 8.

  APPEND GS_FCAT TO GT_FCAT.



  " 9. ###

  CLEAR GS_FCAT.

  GS_FCAT-FIELDNAME = 'ERDAT'.

  GS_FCAT-COLTEXT   = '###'.

  GS_FCAT-JUST      = 'C'.

  GS_FCAT-OUTPUTLEN = 12.

  GS_FCAT-EDIT_MASK = '____.__.__'.   " YYYY.MM.DD ##

  GS_FCAT-COL_POS   = 9.

  APPEND GS_FCAT TO GT_FCAT.



  CLEAR GS_FCAT.

  GS_FCAT-FIELDNAME = 'GDATU'.

  GS_FCAT-TECH      = 'X'.    " ### ## # #

  APPEND GS_FCAT TO GT_FCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DISPLAY_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DISPLAY_ALV.

  " ALV ### ### ##

  IF GO_CONTAINER IS INITIAL.

    PERFORM CREATE_ALV_OBJECT.

  ENDIF.



  IF GO_GRID IS INITIAL.

    RETURN.

  ENDIF.



  " ## ##### ##### ##

  IF LINES( GT_FCAT ) = 0.

    PERFORM SET_ALV_FIELDCAT.

  ENDIF.



  " ##### #### #### ##

  IF GS_LAYOUT IS INITIAL.

    PERFORM SET_ALV_LAYOUT.

  ENDIF.



  " ### ##

  CALL METHOD GO_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_LAYOUT       = GS_LAYOUT

    CHANGING

      IT_OUTTAB       = GT_DATA

      IT_FIELDCATALOG = GT_FCAT.



  CLEAR GV_ALV_CREATED.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DOWNLOAD_PDF_OLE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DOWNLOAD_PDF_OLE.



  DATA: LV_PATH        TYPE STRING,

        LV_OUTPUT_DIR  TYPE STRING,

        LV_FULLPATH    TYPE STRING,

        LV_PDF_PATH    TYPE STRING,

        LV_FILENAME    TYPE STRING,

        LV_DEFNAME     TYPE STRING,

        LV_RANGE_STR   TYPE STRING,

        LV_ROW_STR     TYPE STRING,

        LV_DATE_NAME   TYPE CHAR8,

        LV_DATE_DISP   TYPE CHAR10,

        LV_SEPARATOR   TYPE CHAR1,

        LV_FILE_EXISTS TYPE C,

        LV_ACTION      TYPE I,

        LV_ROW         TYPE I,

        LV_RC          TYPE I,

        LV_DEST        TYPE RLGRAP-FILENAME,

        LV_MSG         TYPE STRING,

        LS_KEY         TYPE WWWDATATAB.



  IF GT_DATA IS INITIAL.

    MESSAGE '### #### ####.' TYPE 'S' DISPLAY LIKE 'W'.

    EXIT.

  ENDIF.



  " ### #### ## (GET_TEMP_DIRECTORY + C:\Temp ##)

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>GET_TEMP_DIRECTORY

    CHANGING

      TEMP_DIR = LV_PATH

    EXCEPTIONS

      OTHERS   = 1.



  IF LV_PATH IS INITIAL.

    LV_PATH = 'C:\Temp'.

  ENDIF.



  CALL METHOD CL_GUI_FRONTEND_SERVICES=>GET_FILE_SEPARATOR

    CHANGING

      FILE_SEPARATOR = LV_SEPARATOR.



  CONCATENATE LV_PATH LV_SEPARATOR 'EXCEL_TEMPLATE.XLSX'

         INTO LV_FULLPATH.

  LV_DEST = LV_FULLPATH.



  " ### ## # SMW0 ### ####

  CALL FUNCTION 'WS_FILE_DELETE'

    EXPORTING

      FILE   = LV_DEST

    IMPORTING

      RETURN = LV_RC

    EXCEPTIONS

      OTHERS = 1.



  CLEAR LS_KEY.

  SELECT SINGLE *

    INTO CORRESPONDING FIELDS OF LS_KEY

    FROM WWWDATA

    WHERE OBJID = 'ZWORK25_TEMPLATE'

      AND RELID = 'MI'.



  IF SY-SUBRC <> 0.

    MESSAGE 'SMW0# ###(ZWORK25_TEMPLATE)# ####.' TYPE 'S'

                                             DISPLAY LIKE 'E'.

    EXIT.

  ENDIF.



  CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'

    EXPORTING

      KEY         = LS_KEY

      DESTINATION = LV_DEST.



  " ## ### ## (OLE)

  CREATE OBJECT GO_EXCEL 'EXCEL.APPLICATION'.

  SET PROPERTY OF GO_EXCEL 'VISIBLE' = 0.



  CALL METHOD OF GO_EXCEL 'WORKBOOKS' = GO_WORKBOOK.

  CALL METHOD OF GO_WORKBOOK 'OPEN' EXPORTING #1 = LV_FULLPATH.

  CALL METHOD OF GO_EXCEL 'WORKSHEETS' = GO_SHEET EXPORTING #1 = 1.

  CALL METHOD OF GO_SHEET 'ACTIVATE'.



  " ### ### ### (FILL_CELL ##)

  LV_ROW = 2.



    LOOP AT GT_DATA INTO GS_DATA.

    PERFORM FILL_CELL USING LV_ROW 1 GS_DATA-KURST.

    PERFORM FILL_CELL USING LV_ROW 2 GS_DATA-FCURR.

    PERFORM FILL_CELL USING LV_ROW 3 GS_DATA-TCURR.



    CLEAR LV_DATE_DISP.

    WRITE GS_DATA-VALID_FROM TO LV_DATE_DISP.

    PERFORM FILL_CELL USING LV_ROW 4 LV_DATE_DISP.



    PERFORM FILL_CELL USING LV_ROW 5 GS_DATA-UKURS.

    PERFORM FILL_CELL USING LV_ROW 6 GS_DATA-FFACT.

    PERFORM FILL_CELL USING LV_ROW 7 GS_DATA-TFACT.



    PERFORM FILL_CELL USING LV_ROW 8 GS_DATA-ERNAM.          " ###

    CLEAR LV_DATE_DISP.

    WRITE GS_DATA-ERDAT TO LV_DATE_DISP.

    PERFORM FILL_CELL USING LV_ROW 9 LV_DATE_DISP.           " ###



    LV_ROW = LV_ROW + 1.

  ENDLOOP.



  CALL METHOD OF GO_SHEET 'COLUMNS' = GO_RANGE.

  CALL METHOD OF GO_RANGE 'AUTOFIT'.



  LV_ROW = LV_ROW - 1.

  LV_ROW_STR = LV_ROW.

  CONCATENATE 'A1:I' LV_ROW_STR INTO LV_RANGE_STR.



  CALL METHOD OF GO_SHEET 'RANGE' = GO_RANGE EXPORTING #1 = LV_RANGE_STR.

  CALL METHOD OF GO_RANGE 'BORDERS' = GO_BORDER.

  SET PROPERTY OF GO_BORDER 'LINESTYLE' = 1.



  " PDF ## #### ## (DIRECTORY_BROWSE)

  LV_OUTPUT_DIR = LV_PATH.



  CALL METHOD CL_GUI_FRONTEND_SERVICES=>DIRECTORY_BROWSE

    CHANGING

      SELECTED_FOLDER = LV_OUTPUT_DIR

    EXCEPTIONS

      OTHERS          = 1.



  IF LV_OUTPUT_DIR IS INITIAL.

    CALL METHOD OF GO_WORKBOOK 'CLOSE' EXPORTING #1 = 0.

    CALL METHOD OF GO_EXCEL    'QUIT'.

    FREE OBJECT: GO_BORDER, GO_RANGE, GO_CELL,

                 GO_SHEET, GO_WORKBOOK, GO_EXCEL.



    MESSAGE 'PDF ## ## ### #######.' TYPE 'S'

                                                  DISPLAY LIKE 'E'.

    EXIT.

  ENDIF.



  LV_FILENAME = 'EXCHANGERATE.PDF'.

  CONCATENATE LV_OUTPUT_DIR LV_SEPARATOR LV_FILENAME INTO LV_PDF_PATH.



  " ## PDF ## ## ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_DELETE

    EXPORTING

      FILENAME = LV_PDF_PATH

    CHANGING

      RC       = LV_RC

    EXCEPTIONS

      OTHERS   = 1.



  WAIT UP TO '1' SECONDS.



  " PDF# ## (EXPORTASFIXEDFORMAT)

  CALL METHOD OF GO_SHEET 'EXPORTASFIXEDFORMAT'

    EXPORTING #1 = 0

              #2 = LV_PDF_PATH.



  " ## ##

  TRY.

    CALL METHOD OF GO_WORKBOOK 'CLOSE' EXPORTING #1 = 0.

  CATCH CX_ROOT.

  ENDTRY.



  TRY.

    SET PROPERTY OF GO_EXCEL 'DISPLAYALERTS' = 0.

    CALL METHOD OF GO_EXCEL 'QUIT'.

  CATCH CX_ROOT.

  ENDTRY.



  WAIT UP TO '2' SECONDS.



  TRY.

    FREE OBJECT: GO_BORDER.

    FREE OBJECT: GO_RANGE.

    FREE OBJECT: GO_CELL.

    FREE OBJECT: GO_SHEET.

    FREE OBJECT: GO_WORKBOOK.

    FREE OBJECT: GO_EXCEL.

  CATCH CX_ROOT.

  ENDTRY.



  " ## ## ## (##)

  " PERFORM KILL_EXCEL_PROCESS.



  WAIT UP TO '3' SECONDS.



  " ### ## ## (### ##)

  PERFORM DELETE_TEMPLATE_FILE USING LV_FULLPATH.



  " ## ## ###

  CONCATENATE 'PDF# ' LV_PDF_PATH ' # #######.' INTO LV_MSG.

  MESSAGE LV_MSG TYPE 'S'.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  DELETE_TEMPLATE_FILE

*&---------------------------------------------------------------------*




FORM DELETE_TEMPLATE_FILE USING P_FILEPATH TYPE STRING.

  DATA: LV_RC TYPE I,

        LV_RETRY TYPE I.



  " ## ## ### (## 10#)

  DO 10 TIMES.

    LV_RETRY = SY-INDEX.



    CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_DELETE

      EXPORTING

        FILENAME = P_FILEPATH

      CHANGING

        RC       = LV_RC

      EXCEPTIONS

        ACCESS_DENIED        = 1

        FILE_DELETE_FAILED   = 2

        CNTL_ERROR           = 3

        ERROR_NO_GUI         = 4

        NOT_SUPPORTED_BY_GUI = 5

        OTHERS               = 6.



    IF LV_RC = 0.

      EXIT.

    ENDIF.



    IF LV_RETRY < 10.

      WAIT UP TO '1' SECONDS.

    ENDIF.

  ENDDO.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  FILL_CELL

*&---------------------------------------------------------------------*




FORM FILL_CELL USING P_ROW P_COL P_VAL.



  CALL METHOD OF GO_SHEET 'CELLS' = GO_CELL

    EXPORTING #1 = P_ROW

              #2 = P_COL.



  SET PROPERTY OF GO_CELL 'VALUE' = P_VAL.



  FREE OBJECT GO_CELL.



ENDFORM.