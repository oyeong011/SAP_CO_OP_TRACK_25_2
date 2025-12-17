
*&---------------------------------------------------------------------*

*&  Include           ZWORK09_002_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*




FORM GET_DATA .

   SELECT *

   FROM ZTCURR09

   INTO CORRESPONDING FIELDS OF TABLE GT_CURR_ALV

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

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'FCURR'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'TCURR'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'GDATU'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'UKURS'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-JUST        = 'L'.   "####

  GS_FIELDCAT-OUTPUTLEN = 15.

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

  GS_FIELDCAT-FIELDNAME = 'ERNAME'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ERDATE'.

  GS_FIELDCAT-COLTEXT = '###'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*




FORM ALV_LAYOUT .

  CLEAR : GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*




FORM CALL_ALV .

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_LAYOUT                     = GS_LAYOUT

    CHANGING

      IT_OUTTAB                     = GT_CURR_ALV

      IT_FIELDCATALOG               = GT_FIELDCAT.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  DOWNLOAD_PDF (OLE ##)

*&---------------------------------------------------------------------*




FORM DOWNLOAD_PDF .



  " 1. ##### PDF ## #### ####

  PERFORM GET_DIRECTORY.

  IF GV_PDF_DIR IS INITIAL.

    MESSAGE 'PDF ##### #### #####. ## #### ### ######.' TYPE 'I'.

    EXIT.

  ENDIF.



  " 2. ### ## ####

  PERFORM DOWNLOAD_EXCEL_TEMPLATE.



  " 3. ## ### ## (OLE)

  PERFORM OPEN_EXCEL_TEMPLATE.



  " 4. ALV #### ### ###

  PERFORM FILL_EXCEL_LINE.



  " 4-1. ### PDF# ##

  PERFORM SAVE_AS_PDF.



  " 5. ## ## ## ##

  PERFORM DELETE_TEMPLATE.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_DIRECTORY

*&---------------------------------------------------------------------*




FORM GET_DIRECTORY .



  "##### ##### # ## #### (#### ####)

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>GET_TEMP_DIRECTORY

    CHANGING

      TEMP_DIR = GV_EXCEL_DIR.



  "#### ## PDF# ### ## ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>DIRECTORY_BROWSE

    EXPORTING

      WINDOW_TITLE = 'PDF ## ## ##'

    CHANGING

      SELECTED_FOLDER = GV_PDF_DIR.



  "##### ## ## ## ###

  IF GV_EXCEL_DIR IS NOT INITIAL.

    CONCATENATE GV_EXCEL_DIR '\Z_CURR_EXCEL_TEMPLATE.xlsx'

       INTO GV_TEMPLATE_FULL_PATH.

  ENDIF.



   "#### ### ### #### PDF ### #####

   IF GV_PDF_DIR IS NOT INITIAL.

     CONCATENATE GV_PDF_DIR '\##_' SY-DATUM '.pdf'

        INTO GV_PDF_FULL_PATH.

   ENDIF.



   "RLGRAP-FILENAME# ###

   GV_TEMPLATE_RLGRAP = GV_TEMPLATE_FULL_PATH.

   GV_PDF_RLGRAP = GV_PDF_FULL_PATH.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  DOWNLOAD_EXCEL_TEMPLATE

*&---------------------------------------------------------------------*




FORM DOWNLOAD_EXCEL_TEMPLATE .

  "SMW0# #### #

  DATA : LS_WWWDATA TYPE WWWDATA,

         LS_WWWKEY TYPE WWWDATATAB.



  "DOWNLOAD_WEB_OBJECT ##

  DATA : LV_RC TYPE SY-SUBRC.



  "## ##### ### ##

  CALL FUNCTION 'WS_FILE_DELETE'

    EXPORTING

      FILE = GV_TEMPLATE_RLGRAP.



  "WWWDATA## SMW0 #### # ## ####

  SELECT SINGLE RELID

                OBJID

  FROM WWWDATA

  INTO LS_WWWDATA

  WHERE OBJID = 'Z_CURR_EXCEL_TEMPLATE'.



  IF SY-SUBRC <> 0.

    MESSAGE 'SMW0 ##### ## # ####.' TYPE 'E'.

  ENDIF.



  "DOWNLOAD_WEB_OBJECT# ## ## ####

  CLEAR : LS_WWWKEY.

  LS_WWWKEY-RELID = LS_WWWDATA-RELID.

  LS_WWWKEY-OBJID = LS_WWWDATA-OBJID.



  "SMW0(# #####)# ### ###, SAP #### ##PC# ### #### ##

  CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'

    EXPORTING

      KEY = LS_WWWKEY

      DESTINATION = GV_TEMPLATE_RLGRAP

    IMPORTING

      RC = LV_RC.



  IF LV_RC NE 0.

    MESSAGE '## ### #### # ### ######' TYPE 'E'.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  OPEN_EXCEL_TEMPLATE

*&---------------------------------------------------------------------*




FORM OPEN_EXCEL_TEMPLATE .

  "Excel.Workbooks #### ## OLE ##

  DATA : LO_WORKBOOKS TYPE OLE2_OBJECT.



  "Excel.Application ##

  CREATE OBJECT GO_EXCEL 'EXCEL.APPLICATION'.



  "Workbooks ### ##

  CALL METHOD OF GO_EXCEL 'WORKBOOKS' = LO_WORKBOOKS.



  "### ## ##

  CALL METHOD OF LO_WORKBOOKS 'OPEN'

    EXPORTING

      #1 = GV_TEMPLATE_RLGRAP.



  "#### ##

  CALL METHOD OF GO_EXCEL 'ACTIVESHEET' = GO_SHEET.



  FREE LO_WORKBOOKS.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  FILL_EXCEL_LINE

*&---------------------------------------------------------------------*




FORM FILL_EXCEL_LINE .

  DATA : LV_ROW TYPE I.



  LV_ROW = 2. "### ### (1## ##)



  LOOP AT GT_CURR_ALV INTO GS_CURR_ALV.

    PERFORM SET_CELL USING LV_ROW 1 GS_CURR_ALV-KURST. "####

    PERFORM SET_CELL USING LV_ROW 2 GS_CURR_ALV-FCURR.  "####

    PERFORM SET_CELL USING LV_ROW 3 GS_CURR_ALV-TCURR.  "####

    PERFORM SET_CELL USING LV_ROW 4 GS_CURR_ALV-GDATU.  "####

    PERFORM SET_CELL USING LV_ROW 5 GS_CURR_ALV-UKURS.  "##

    PERFORM SET_CELL USING LV_ROW 6 GS_CURR_ALV-FFACT.  "########

    PERFORM SET_CELL USING LV_ROW 7 GS_CURR_ALV-TFACT.  "########

    PERFORM SET_CELL USING LV_ROW 8 GS_CURR_ALV-ERNAME. "###

    PERFORM SET_CELL USING LV_ROW 9 GS_CURR_ALV-ERDATE. "###



    LV_ROW = LV_ROW + 1.

  ENDLOOP.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SET_CELL

*&---------------------------------------------------------------------*




FORM SET_CELL  USING    P_ROW

                        P_COL

                        P_VALUE.



  DATA : LO_CELL TYPE OLE2_OBJECT.



  "## ## Sheet# row# col ##

  CALL METHOD OF GO_SHEET 'CELLS' = LO_CELL

    EXPORTING

      #1 = P_ROW

      #2 = P_COL.



  "## ## # ##

  SET PROPERTY OF LO_CELL 'VALUE' = P_VALUE.



  FREE LO_CELL.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SAVE_AS_PDF

*&---------------------------------------------------------------------*




FORM SAVE_AS_PDF .

  "### ###### PDF# #### ##

  DATA : LO_ACTIVE_WB TYPE OLE2_OBJECT.



  "## ### ##

  CALL METHOD OF GO_EXCEL 'ACTIVEWORKBOOK' = LO_ACTIVE_WB.



  "PDF# ##

  CALL METHOD OF LO_ACTIVE_WB 'ExportAsFixedFormat'

    EXPORTING

      #1 = 0                 "0 -> PDF

      #2 = GV_PDF_FULL_PATH. "PDF ####



  IF SY-SUBRC = 0.

    MESSAGE |PDF ## ##### ###### { GV_PDF_FULL_PATH }| TYPE 'I'.

  ENDIF.



  "### ##

  CALL METHOD OF LO_ACTIVE_WB 'CLOSE'

    EXPORTING

      #1 = 0.             "### ##



  FREE LO_ACTIVE_WB.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  DELETE_TEMPLATE

*&---------------------------------------------------------------------*




FORM DELETE_TEMPLATE .

  DATA : LV_RC TYPE I.



  "## ###### ##

  CALL METHOD OF GO_EXCEL 'QUIT'.

  FREE GO_SHEET.

  FREE GO_EXCEL.



  "##### ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_DELETE

    EXPORTING

      FILENAME = GV_TEMPLATE_FULL_PATH

    CHANGING

      RC = LV_RC.



  IF LV_RC NE 0.

    MESSAGE '## ### ### ######' TYPE 'I'.

  ENDIF.

ENDFORM.