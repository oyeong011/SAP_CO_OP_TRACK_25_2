
*&---------------------------------------------------------------------*

*&  Include           ZWORK06_002_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       ## ### ##

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .

  " ### ## ### ## ## ### ##

  SELECT * FROM ZTCURR06

    INTO CORRESPONDING FIELDS OF TABLE GT_ZTCURR06

    WHERE GDATU = P_DATE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*

*       ALV ### ##### ##

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DATA .



  " ## DB -> ## AVL ##

  CLEAR : GS_ZTCURR06, GS_ZTCURR06_ALV.

  LOOP AT GT_ZTCURR06 INTO GS_ZTCURR06.



    MOVE-CORRESPONDING GS_ZTCURR06 TO GS_ZTCURR06_ALV.



    APPEND GS_ZTCURR06_ALV TO GT_ZTCURR06_ALV.

    CLEAR : GS_ZTCURR06_ALV.

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



  " ## CUSTOM #### ##

  CREATE OBJECT GC_CUSTOM

    EXPORTING

      CONTAINER_NAME              = 'CON1'.

  IF SY-SUBRC <> 0.

    MESSAGE '## ### #######.' TYPE 'I'.

    EXIT.

  ENDIF.



  " AVL GRID ## ##

  CREATE OBJECT GC_GRID

    EXPORTING

      I_PARENT          = GC_CUSTOM.

  IF SY-SUBRC <> 0.

    MESSAGE '## ### #######.' TYPE 'I'.

    EXIT.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_FIELDCAT

*&---------------------------------------------------------------------*

*       ALV ## ##

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_FIELDCAT .



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

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'UKURS'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-OUTPUTLEN = 12.

  GS_FIELDCAT-DECIMALS = 5.




*  GS_FIELDCAT-CFIELDNAME = 'FCURR'.




  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'FFACT'.

  GS_FIELDCAT-COLTEXT = '########'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'TFACT'.

  GS_FIELDCAT-COLTEXT = '########'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'AENAM'.

  GS_FIELDCAT-COLTEXT = '###'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'AEDAT'.

  GS_FIELDCAT-COLTEXT = '###'.

  GS_FIELDCAT-OUTPUTLEN = 12.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

*       ALV LAYOUT ## ()

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT .



  CLEAR : GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.          " ### ##



  CLEAR : GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME. " ### ALV VARIANT ## ## ##.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*

*       ALV ## ##.

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_SORT .



  " ## 1 : ## ##

  CLEAR : GS_SORT, GT_SORT.

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'KURST'.

  GS_SORT-UP = 'X'.

  APPEND GS_SORT TO GT_SORT.



  " ## 2 : ####

  CLEAR : GS_SORT.

  GS_SORT-SPOS = 2.

  GS_SORT-FIELDNAME = 'FCURR'.

  GS_SORT-UP = 'X'.

  APPEND GS_SORT TO GT_SORT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       ALV ##

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY .

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

    IT_OUTTAB                     = GT_ZTCURR06_ALV

    IT_FIELDCATALOG               = GT_FIELDCAT

    IT_SORT                       = GT_SORT




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

*&      Form  DOWNLOAD_TO_PDF

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM  DOWNLOAD_TO_PDF .

  " ## #### # ## ##

  DATA : LV_FOLDER         TYPE STRING,       " ### ##

         LV_FULLPATH       TYPE STRING,       " ## + ###

         LV_PDF_FULLPATH   TYPE STRING,       " ## + ### (PDF)  ##

         LV_XLSX_FULLPATH  TYPE STRING,       " ## + ### (XLSX) ##

         LS_WWWDATA        TYPE WWWDATATAB,   " SMW0 #### #

         LV_RC             TYPE I.




*----------------------------------------------------------------------*

*    1. #### ##.

*----------------------------------------------------------------------*




  " 1. #### ## : #### ## #### ##.

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>DIRECTORY_BROWSE

    CHANGING

      SELECTED_FOLDER      = LV_FOLDER.



  " #### ## ##.

  IF SY-SUBRC <> 0 OR LV_FOLDER IS INITIAL.

    MESSAGE '# ## #####, ## ######.' TYPE 'E'.

    RETURN.

  ENDIF.






*----------------------------------------------------------------------*

*   2. #### ###  ##

*----------------------------------------------------------------------*




  " 2. ### #### : SAP ### ## ### ###.

  DATA : LV_XLSX_FILE TYPE RLGRAP-FILENAME,

         LV_PDF_FILE TYPE RLGRAP-FILENAME.



  CONCATENATE LV_FOLDER '\#####.xlsx' INTO LV_XLSX_FULLPATH.

  CONCATENATE LV_FOLDER '\#####.pdf' INTO LV_PDF_FULLPATH.



  LV_XLSX_FILE = LV_XLSX_FULLPATH.



  " 2-1) ## #### ## ##

  CALL FUNCTION 'WS_FILE_DELETE'

    EXPORTING

      FILE          = LV_XLSX_FILE.



  " 2-2) WWWDATA## ### ## ## (SMW0## ### OBJID ##)

  CLEAR : LS_WWWDATA.

  SELECT SINGLE * INTO CORRESPONDING FIELDS OF LS_WWWDATA

    FROM WWWDATA

   WHERE OBJID = 'ZWORK06_002_EXCEL_TEMPLATE'.



  IF SY-SUBRC <> 0.

    MESSAGE '#### ## # #### (SMW0 ## ##)' TYPE 'E'.

  ENDIF.



  " 3) ## PC# ### #### ## ##.

    CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'

      EXPORTING

        KEY               = LS_WWWDATA

        DESTINATION       = LV_XLSX_FILE

     IMPORTING

        RC                = LV_RC.



  IF LV_RC  <> 0.

    MESSAGE '### #### ##' TYPE 'E'.

  ENDIF.






*----------------------------------------------------------------------*

*   3. ## ### ##.

*----------------------------------------------------------------------*




  "  Excel OLE ## ##

  DATA : LV_APPLICATION TYPE OLE2_OBJECT,

         LV_WORKBOOKS    TYPE OLE2_OBJECT,

         LV_WORKBOOK    TYPE OLE2_OBJECT,

         LV_SHEET        TYPE OLE2_OBJECT,

         LV_CELL        TYPE OLE2_OBJECT.



  " Excel OLE ## ##: Excel ##### ####### ##

  CREATE OBJECT LV_APPLICATION 'Excel.Application'.

  SET PROPERTY OF LV_APPLICATION 'VISIBLE' = 0.     " ## ### ###.



  " Excel Application # Workbooks ### ####

  CALL METHOD OF LV_APPLICATION 'WORKBOOKS' = LV_WORKBOOKS.

  " ### ### ## ##(XLSX ###)# ## WorkBook ## ##

  CALL METHOD OF LV_WORKBOOKS 'OPEN' = LV_WORKBOOK

    EXPORTING

      #1 = LV_XLSX_FULLPATH.



  " ## #### Sheet ####

  CALL METHOD OF LV_APPLICATION 'ActiveSheet' = LV_SHEET.






*----------------------------------------------------------------------*

*   4. ## ### ### ##

*----------------------------------------------------------------------*




  " EXCEL# ### ##

  DATA : LV_ROW TYPE I VALUE 2. " (2###)



  " #(row,col)# # ##

  CLEAR GS_ZTCURR06.

  LOOP AT GT_ZTCURR06 INTO GS_ZTCURR06.

    CALL METHOD OF LV_SHEET 'Cells' = LV_CELL

      EXPORTING

        #1 = LV_ROW  " ROW

        #2 = 1. " COL

    SET PROPERTY OF LV_CELL 'VALUE' = GS_ZTCURR06-KURST.



    CALL METHOD OF LV_SHEET 'Cells' = LV_CELL

      EXPORTING

        #1 = LV_ROW  " ROW

        #2 = 2. " COL

    SET PROPERTY OF LV_CELL 'VALUE' = GS_ZTCURR06-FCURR.



    CALL METHOD OF LV_SHEET 'Cells' = LV_CELL

      EXPORTING

        #1 = LV_ROW  " ROW

        #2 = 3. " COL

    SET PROPERTY OF LV_CELL 'VALUE' = GS_ZTCURR06-TCURR.



    CALL METHOD OF LV_SHEET 'Cells' = LV_CELL

      EXPORTING

        #1 = LV_ROW  " ROW

        #2 = 4. " COL

    SET PROPERTY OF LV_CELL 'VALUE' = GS_ZTCURR06-GDATU.



    CALL METHOD OF LV_SHEET 'Cells' = LV_CELL

      EXPORTING

        #1 = LV_ROW  " ROW

        #2 = 5. " COL

    SET PROPERTY OF LV_CELL 'VALUE' = GS_ZTCURR06-UKURS.



    CALL METHOD OF LV_SHEET 'Cells' = LV_CELL

      EXPORTING

        #1 = LV_ROW  " ROW

        #2 = 6. " COL

    SET PROPERTY OF LV_CELL 'VALUE' = GS_ZTCURR06-FFACT.



    CALL METHOD OF LV_SHEET 'Cells' = LV_CELL

      EXPORTING

        #1 = LV_ROW  " ROW

        #2 = 7. " COL

    SET PROPERTY OF LV_CELL 'VALUE' = GS_ZTCURR06-TFACT.



    CALL METHOD OF LV_SHEET 'Cells' = LV_CELL

      EXPORTING

        #1 = LV_ROW  " ROW

        #2 = 8. " COL

    SET PROPERTY OF LV_CELL 'VALUE' = GS_ZTCURR06-AENAM.



    CALL METHOD OF LV_SHEET 'Cells' = LV_CELL

      EXPORTING

        #1 = LV_ROW  " ROW

        #2 = 9. " COL

    SET PROPERTY OF LV_CELL 'VALUE' = GS_ZTCURR06-AEDAT.



    CLEAR : GS_ZTCURR06.

    LV_ROW = LV_ROW + 1.

  ENDLOOP.






*----------------------------------------------------------------------*

*   5. ## ### PDF# ####.

*----------------------------------------------------------------------*




  " EXCEL -> PDF ##

  CALL METHOD OF LV_WORKBOOK 'ExportAsFixedFormat'

    EXPORTING

      #1 = 0              " 0 = xlTypePDF

      #2 = LV_PDF_FULLPATH.






*----------------------------------------------------------------------*

*   6. ## ### ##

*----------------------------------------------------------------------*




  " Excel ##

  CALL METHOD OF LV_WORKBOOK 'Save'.

  CALL METHOD OF LV_WORKBOOK 'Close'.

  CALL METHOD OF LV_APPLICATION 'Quit'.



  FREE : LV_SHEET,

         LV_WORKBOOK,

         LV_WORKBOOKS,

         LV_APPLICATION.



  " ## XLSX ##

  WAIT UP TO 2 SECONDS. " ## ##### ## ### ###.

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_DELETE

    EXPORTING

      FILENAME             = LV_XLSX_FULLPATH

    CHANGING

      RC                   = LV_RC.



  IF SY-SUBRC <> 0.

    MESSAGE '### ## ##' TYPE 'E'.

  ENDIF.



ENDFORM.