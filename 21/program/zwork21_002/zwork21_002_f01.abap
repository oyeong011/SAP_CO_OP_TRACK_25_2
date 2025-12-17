
*&---------------------------------------------------------------------*

*&  Include           ZWORK21_002_F01

*&---------------------------------------------------------------------*




FORM SET_SCREEN.

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

  IF P_DATE IS INITIAL.

    MESSAGE I001.

    EXIT.

  ENDIF.



 SELECT * FROM ZTCURR21

   INTO CORRESPONDING FIELDS OF TABLE GT_TCURR

   WHERE GDATU = P_DATE.





  ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SET_INITIAL.

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*






FORM SET_INITIAL.

  ENDFORM.



FORM CREATE_OBJECT.

  CREATE OBJECT GC_CUSTOM

    EXPORTING




*      PARENT                      =




      CONTAINER_NAME               = 'CON1'.




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

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DATA .

  "INTERNAL TABLE# ## ##### ###### ## EX)###, ###, KURST

  LOOP AT GT_TCURR INTO GS_TCURR.

    GS_TCURR-GDATU = P_DATE.

    GS_TCURR-KURST = 'M'.

    GS_TCURR-MODIFER = SY-UNAME.

    GS_TCURR-EDATE = SY-DATUM.

    MODIFY GT_TCURR FROM GS_TCURR.

  ENDLOOP.

ENDFORM.

FORM FIELD_CAT.

  "GS_FIELDCAT & GT_FIELDCAT ###

  CLEAR : GS_FIELDCAT.

  CLEAR : GT_FIELDCAT.



  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'KURST'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'FCURR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'TCURR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'GDATU'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'UKURS'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-OUTPUTLEN = 15.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'FFACT'.

  GS_FIELDCAT-COLTEXT = '########'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'TFACT'.

  GS_FIELDCAT-COLTEXT = '########'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-OUTPUTLEN = 15.

  GS_FIELDCAT-FIELDNAME = 'MODIFER'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'EDATE'.

  GS_FIELDCAT-COLTEXT = '###'.

  GS_FIELDCAT-OUTPUTLEN = 15.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.

























FORM ALV_LAYOUT.















ENDFORM.



FORM ALV_SORT.



ENDFORM.





FORM CALL_ALV.

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY




*    EXPORTING

*      I_BUFFER_ACTIVE               =

*      I_BYPASSING_BUFFER            =

*      I_CONSISTENCY_CHECK           =

*      I_STRUCTURE_NAME              =

*       IS_VARIANT                    = GS_VARIANT

*       I_SAVE                        = 'A'

*      I_DEFAULT                     = 'X'

*       IS_LAYOUT                     = GS_LAYOUT

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

*&      Form  SET_FUNCTION_KEY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SAVE_DATA

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SAVE_DATA

*&---------------------------------------------------------------------*




FORM DOWNLOAD_PDF .

  DATA: LV_TEMP_DIR    TYPE STRING,

        LV_SAVE_DIR    TYPE STRING,

        LV_XLSX_PATH   TYPE STRING,

        LV_PDF_PATH    TYPE STRING,

        LV_DELETE_PATH TYPE RLGRAP-FILENAME,

        LV_RC          TYPE SY-SUBRC.



  DATA: LS_WWWDATA TYPE WWWDATATAB.



  "===========================================

  " 1. TEMP #### + ### ## ##

  "===========================================

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>GET_TEMP_DIRECTORY

    CHANGING TEMP_DIR = LV_TEMP_DIR.



  CALL METHOD CL_GUI_FRONTEND_SERVICES=>DIRECTORY_BROWSE

    CHANGING SELECTED_FOLDER = LV_SAVE_DIR.



  LV_XLSX_PATH   = LV_SAVE_DIR && '\#####.XLSX'.

  LV_PDF_PATH    = LV_SAVE_DIR && '\#####.PDF'.

  LV_DELETE_PATH = LV_XLSX_PATH.



  CALL FUNCTION 'WS_FILE_DELETE'

    EXPORTING FILE = LV_DELETE_PATH.



  "===========================================

  " 2. SMW0 ###

  "===========================================

  SELECT SINGLE *

    INTO CORRESPONDING FIELDS OF LS_WWWDATA

    FROM WWWDATA

    WHERE OBJID = 'ZWORK21_002_TEMPLATE'.



  IF SY-SUBRC <> 0.

    MESSAGE 'SMW0 #### ## # ####.' TYPE 'E'.

    RETURN.

  ENDIF.



  CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'

    EXPORTING

      KEY         = LS_WWWDATA

      DESTINATION = LV_DELETE_PATH

    IMPORTING

      RC          = LV_RC.



  IF LV_RC <> 0.

    MESSAGE '### #### ##' TYPE 'E'.

    RETURN.

  ENDIF.



  "===========================================

  " 3. EXCEL OLE

  "===========================================

  DATA: EXCEL       TYPE OLE2_OBJECT,

        WORKBOOKS   TYPE OLE2_OBJECT,

        WORKBOOK    TYPE OLE2_OBJECT,

        WORKSHEETS  TYPE OLE2_OBJECT,

        WORKSHEET   TYPE OLE2_OBJECT,

        PAGE_SETUP  TYPE OLE2_OBJECT.



  CREATE OBJECT EXCEL 'EXCEL.APPLICATION'.

  SET PROPERTY OF EXCEL 'VISIBLE' = 0.



  CALL METHOD OF EXCEL 'WORKBOOKS' = WORKBOOKS.

  CALL METHOD OF WORKBOOKS 'OPEN' = WORKBOOK EXPORTING #1 = LV_XLSX_PATH.



  CALL METHOD OF WORKBOOK 'WORKSHEETS' = WORKSHEETS.

  CALL METHOD OF WORKSHEETS 'ITEM' = WORKSHEET EXPORTING #1 = 1.



  GET PROPERTY OF WORKSHEET 'PAGESETUP' = PAGE_SETUP.

  SET PROPERTY OF PAGE_SETUP 'ORIENTATION' = 2. " LANDSCAPE



  "===========================================

  " 4. ## ##

  "===========================================

  PERFORM SET_HEADER USING WORKSHEET.



  "===========================================

  " 5. ### ##

  "===========================================

  DATA: LS_ALV LIKE GS_TCURR,

        LV_ROW TYPE I VALUE 2.



  LOOP AT GT_TCURR INTO LS_ALV.

    PERFORM SET_CELL USING WORKSHEET LV_ROW 1 LS_ALV-KURST.

    PERFORM SET_CELL USING WORKSHEET LV_ROW 2 LS_ALV-FCURR.

    PERFORM SET_CELL USING WORKSHEET LV_ROW 3 LS_ALV-TCURR.

    PERFORM SET_CELL USING WORKSHEET LV_ROW 4 LS_ALV-GDATU.

    PERFORM SET_CELL USING WORKSHEET LV_ROW 5 LS_ALV-UKURS.

    PERFORM SET_CELL USING WORKSHEET LV_ROW 6 LS_ALV-FFACT.

    PERFORM SET_CELL USING WORKSHEET LV_ROW 7 LS_ALV-TFACT.

    PERFORM SET_CELL USING WORKSHEET LV_ROW 8 LS_ALV-MODIFER.

    PERFORM SET_CELL USING WORKSHEET LV_ROW 9 LS_ALV-EDATE.

    LV_ROW = LV_ROW + 1.

  ENDLOOP.



  "===========================================

  " 6. AUTOFIT

  "===========================================

  DATA: USEDRANGE TYPE OLE2_OBJECT,

        LO_COLUMNS TYPE OLE2_OBJECT.



  GET PROPERTY OF WORKSHEET 'USEDRANGE' = USEDRANGE.

  GET PROPERTY OF USEDRANGE 'COLUMNS'  = LO_COLUMNS.

  CALL METHOD OF LO_COLUMNS 'AUTOFIT'.



  FREE OBJECT USEDRANGE.

  FREE OBJECT LO_COLUMNS.



  "===========================================

  " 7. ### (WHILE # ##)

  "===========================================

  PERFORM DRAW_BORDER USING WORKSHEET LV_ROW.



  "===========================================

  " 8. SAVE & EXPORT PDF

  "===========================================

  CALL METHOD OF WORKBOOK 'SAVE'.



  CALL METHOD OF WORKBOOK 'EXPORTASFIXEDFORMAT'

    EXPORTING

      #1 = 0

      #2 = LV_PDF_PATH.



  CALL METHOD OF WORKBOOK 'CLOSE'.

  CALL METHOD OF EXCEL    'QUIT'.



  FREE OBJECT WORKBOOK.

  FREE OBJECT EXCEL.



  "===========================================

  " 9. ## XLS ##

  "===========================================

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_DELETE

    EXPORTING FILENAME = LV_XLSX_PATH

    CHANGING RC       = LV_RC.



  IF SY-SUBRC <> 0.

    MESSAGE |## ## ## ##(SUBRC={ SY-SUBRC })| TYPE 'I'.

  ELSE.

    MESSAGE |PDF ## ##: { LV_PDF_PATH }| TYPE 'S'.

  ENDIF.



ENDFORM.





"=========================================================

" CELLS

"=========================================================

FORM SET_CELL USING P_SHEET P_ROW P_COL P_VALUE.

  DATA CELL TYPE OLE2_OBJECT.

  CALL METHOD OF P_SHEET 'CELLS' = CELL EXPORTING #1 = P_ROW #2 = P_COL.

  SET PROPERTY OF CELL 'VALUE' = P_VALUE.

ENDFORM.





"=========================================================

" HEADER

"=========================================================

FORM SET_HEADER USING P_SHEET.

  PERFORM SET_CELL USING P_SHEET 1 1 '####'.

  PERFORM SET_CELL USING P_SHEET 1 2 '####'.

  PERFORM SET_CELL USING P_SHEET 1 3 '####'.

  PERFORM SET_CELL USING P_SHEET 1 4 '####'.

  PERFORM SET_CELL USING P_SHEET 1 5 '##'.

  PERFORM SET_CELL USING P_SHEET 1 6 '########'.

  PERFORM SET_CELL USING P_SHEET 1 7 '########'.

  PERFORM SET_CELL USING P_SHEET 1 8 '###'.

  PERFORM SET_CELL USING P_SHEET 1 9 '###'.

ENDFORM.





"=========================================================

" BORDER (WHILE ## ##)

"=========================================================

FORM DRAW_BORDER USING P_SHEET P_LAST_ROW.



  DATA: RANGE    TYPE OLE2_OBJECT,

        BORDERS  TYPE OLE2_OBJECT,

        INTERIOR TYPE OLE2_OBJECT,

        LV_IDX   TYPE I,

        LV_ROW   TYPE I.



  "----- HEADER BORDER -----

  CALL METHOD OF P_SHEET 'RANGE' = RANGE EXPORTING #1 = 'A1' #2 = 'I1'.



  GET PROPERTY OF RANGE 'INTERIOR' = INTERIOR.

  SET PROPERTY OF INTERIOR 'COLORINDEX' = -4142. " NO FILL



  DO 5 TIMES.

    LV_IDX = SY-INDEX + 6. " 7~11

    CALL METHOD OF RANGE 'BORDERS' = BORDERS EXPORTING #1 = LV_IDX.

    SET PROPERTY OF BORDERS 'LINESTYLE' = 1.

  ENDDO.



  "----- DATA BORDER -----

  LV_ROW = 2.



  WHILE LV_ROW < P_LAST_ROW.



    DATA(START_C) = |A{ LV_ROW }|.

    DATA(END_C)   = |I{ LV_ROW }|.



    CALL METHOD OF P_SHEET 'RANGE' = RANGE EXPORTING #1 = START_C #2 = END_C.



    DO 5 TIMES.

      LV_IDX = SY-INDEX + 6.

      CALL METHOD OF RANGE 'BORDERS' = BORDERS EXPORTING #1 = LV_IDX.

      SET PROPERTY OF BORDERS 'LINESTYLE' = 1.

    ENDDO.



    LV_ROW = LV_ROW + 1.



  ENDWHILE.



ENDFORM.