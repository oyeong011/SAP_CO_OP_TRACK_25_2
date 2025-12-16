
*&---------------------------------------------------------------------*

*&  Include           ZWORK18_002_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*




FORM CREATE_OBJECT .

  CREATE OBJECT GC_CUSTOM

    EXPORTING




*     PARENT         =




      CONTAINER_NAME = 'CUSTOM'




*     STYLE          =

*     LIFETIME       = lifetime_default

*     REPID          =

*     DYNNR          =

*     NO_AUTODEF_PROGID_DYNNR     =

*  EXCEPTIONS

*     CNTL_ERROR     = 1

*     CNTL_SYSTEM_ERROR           = 2

*     CREATE_ERROR   = 3

*     LIFETIME_ERROR = 4

*     LIFETIME_DYNPRO_DYNPRO_LINK = 5

*     OTHERS         = 6




    .

  IF SY-SUBRC <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




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




FORM FIELD_CATALOG .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 0.

  GS_FIELDCAT-FIELDNAME = 'KURST'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'FCURR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'TCURR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'GDATU'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-REF_TABLE = 'ZTCURR18'.

  GS_FIELDCAT-REF_FIELD = 'GDATU'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'UKURS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-OUTPUTLEN = 20.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'FFACT'.

  GS_FIELDCAT-SCRTEXT_M = '########'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'TFACT'.

  GS_FIELDCAT-SCRTEXT_M = '########'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ERNAM'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ERDAT'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*




FORM ALV_LAYOUT .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*




FORM ALV_SORT .

  CLEAR GS_SORT.

  CLEAR GT_SORT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY .

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*     I_BUFFER_ACTIVE =

*     I_BYPASSING_BUFFER            =

*     I_CONSISTENCY_CHECK           =

*     I_STRUCTURE_NAME              =

*     IS_VARIANT      = GS_VARIANT




      I_SAVE          = 'A'




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

      IT_OUTTAB       = GT_CURR

      IT_FIELDCATALOG = GT_FIELDCAT




*     IT_SORT         = GT_SORT

*     IT_FILTER       =

*  EXCEPTIONS

*     INVALID_PARAMETER_COMBINATION = 1

*     PROGRAM_ERROR   = 2

*     TOO_MANY_LINES  = 3

*     OTHERS          = 4




    .

  IF SY-SUBRC <> 0.




* Implement suitable error handling here




  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*




FORM REFRESH .

  DATA: LS_STABLE TYPE LVC_S_STBL.



  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE = LS_STABLE




*     I_SOFT_REFRESH =

*    EXCEPTIONS

*     FINISHED  = 1

*     OTHERS    = 2




    .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*




FORM GET_DATA .



  CLEAR GT_CURR.

  REFRESH GT_CURR.



  DATA: LV_GDATU_INV TYPE ZTCURR18-GDATU.



  CALL FUNCTION 'CONVERSION_EXIT_INVDT_INPUT'

    EXPORTING

      INPUT  = P_DATE

    IMPORTING

      OUTPUT = LV_GDATU_INV.



  SELECT *

    FROM ZTCURR18

    INTO CORRESPONDING FIELDS OF TABLE GT_CURR

    WHERE GDATU = LV_GDATU_INV.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_PDF

*&---------------------------------------------------------------------*




FORM GET_PDF .



  DATA : LV_PATH      TYPE STRING,

         LV_FNAME_XLS TYPE STRING,

         LV_FNAME_PDF TYPE STRING,

         LV_RC_DEL    TYPE I.



  TRY.

      " 1. ## temp #### ####

      CALL METHOD CL_GUI_FRONTEND_SERVICES=>GET_TEMP_DIRECTORY

        CHANGING

          TEMP_DIR = GV_TEMP_DIR

        EXCEPTIONS

          OTHERS   = 1.



      " 2. ##### ## #### ## ##

      CALL METHOD CL_GUI_FRONTEND_SERVICES=>DIRECTORY_BROWSE

        CHANGING

          SELECTED_FOLDER = LV_PATH

        EXCEPTIONS

          OTHERS          = 1.



      IF LV_PATH IS INITIAL.

        MESSAGE '## ### #### #####.' TYPE 'I'.

        RETURN.

      ENDIF.



      CONCATENATE LV_PATH '/curr_list.xlsx' INTO GV_XLS_PATH.

      CONCATENATE LV_PATH '/curr_list.pdf'  INTO GV_PDF_PATH.





      GV_TEMPLATE_RL = GV_XLS_PATH.

      GV_PDF_PATH_RL = GV_PDF_PATH.



      " 3-1. ### ### ### ## ### ## ##

      PERFORM DELETE_FILE USING GV_XLS_PATH.



      " 3-2. ### ####

      PERFORM DOWNLOAD_TEMPLATE USING GV_TEMPLATE_RL.



      " 4. EXCEL ### ##

      PERFORM OPEN_EXCEL_TEMPLATE USING GV_TEMPLATE_RL.



      " 5. ### ##

      PERFORM FILL_EXCEL_LINE.



      " 6. PDF# ##

      PERFORM SAVE_EXCEL_AS_PDF USING GV_PDF_PATH_RL.



    CATCH CX_ROOT INTO DATA(LX).

      MESSAGE LX->GET_TEXT( ) TYPE 'E'.

  ENDTRY.

  " 7. EXCEL ##

  PERFORM CLOSE_EXCEL.



  " 8. ### XLS ##

  PERFORM DELETE_FILE USING GV_XLS_PATH.



  MESSAGE |PDF# { GV_PDF_PATH } # #######.| TYPE 'S'.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  OPEN_EXCEL_TEMPLATE

*&---------------------------------------------------------------------*




FORM OPEN_EXCEL_TEMPLATE USING PV_XLS TYPE RLGRAP-FILENAME.



  CREATE OBJECT GO_EXCEL 'EXCEL.APPLICATION'.

  SET PROPERTY OF GO_EXCEL 'Visible' = 0.



  " Workbooks ####

  CALL METHOD OF GO_EXCEL 'Workbooks' = GO_WORKBOOKS.



  " XLSX ##

  CALL METHOD OF GO_WORKBOOKS 'Open' = GO_WORKBOOK

    EXPORTING

      #1 = PV_XLS

      #2 = 0.      "ReadOnly = False (##)



  " Worksheets ### ####

  CALL METHOD OF GO_WORKBOOK 'Worksheets' = GO_SHEETS.



  " # ## ##: Item(1)

  CALL METHOD OF GO_SHEETS 'Item' = GO_SHEET

    EXPORTING

      #1 = 1.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FILL_EXCEL_LINE

*&---------------------------------------------------------------------*




FORM FILL_EXCEL_LINE .



  DATA: LV_ROW        TYPE I VALUE 2,

        LV_GDATU_CHAR TYPE C LENGTH 10. "### ## ##



  LOOP AT GT_CURR INTO GS_CURR.



    " #### ##

    CLEAR LV_GDATU_CHAR.

    CALL FUNCTION 'CONVERSION_EXIT_INVDT_OUTPUT'

      EXPORTING

        INPUT  = GS_CURR-GDATU

      IMPORTING

        OUTPUT = LV_GDATU_CHAR.



    " 1#: ####

    CALL METHOD OF GO_SHEET 'Cells' = GO_RANGE

      EXPORTING

        #1 = LV_ROW

        #2 = 1.

    SET PROPERTY OF GO_RANGE 'Value' = GS_CURR-KURST.



    " 2#: ####

    CALL METHOD OF GO_SHEET 'Cells' = GO_RANGE

      EXPORTING

        #1 = LV_ROW

        #2 = 2.

    SET PROPERTY OF GO_RANGE 'Value' = GS_CURR-FCURR.



    " 3#: ####

    CALL METHOD OF GO_SHEET 'Cells' = GO_RANGE

      EXPORTING

        #1 = LV_ROW

        #2 = 3.

    SET PROPERTY OF GO_RANGE 'Value' = GS_CURR-TCURR.



    " 4#: ####

    CALL METHOD OF GO_SHEET 'Cells' = GO_RANGE

      EXPORTING

        #1 = LV_ROW

        #2 = 4.

    SET PROPERTY OF GO_RANGE 'Value' = LV_GDATU_CHAR.



    " 5#: ##

    CALL METHOD OF GO_SHEET 'Cells' = GO_RANGE

      EXPORTING

        #1 = LV_ROW

        #2 = 5.

    SET PROPERTY OF GO_RANGE 'Value' = GS_CURR-UKURS.



    " 6#: ########

    CALL METHOD OF GO_SHEET 'Cells' = GO_RANGE

      EXPORTING

        #1 = LV_ROW

        #2 = 6.

    SET PROPERTY OF GO_RANGE 'Value' = GS_CURR-FFACT.



    " 7#: ########

    CALL METHOD OF GO_SHEET 'Cells' = GO_RANGE

      EXPORTING

        #1 = LV_ROW

        #2 = 7.

    SET PROPERTY OF GO_RANGE 'Value' = GS_CURR-TFACT.



    " 8#: ###

    CALL METHOD OF GO_SHEET 'Cells' = GO_RANGE

      EXPORTING

        #1 = LV_ROW

        #2 = 8.

    SET PROPERTY OF GO_RANGE 'Value' = GS_CURR-ERNAM.



    " 9#: ###

    CALL METHOD OF GO_SHEET 'Cells' = GO_RANGE

      EXPORTING

        #1 = LV_ROW

        #2 = 9.

    SET PROPERTY OF GO_RANGE 'Value' = GS_CURR-ERDAT.



    LV_ROW = LV_ROW + 1.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_EXCEL_AS_PDF

*&---------------------------------------------------------------------*




FORM SAVE_EXCEL_AS_PDF USING PV_PDF TYPE RLGRAP-FILENAME.



  IF GO_WORKBOOK-HANDLE IS INITIAL.

    MESSAGE 'Workbook # #### ####.' TYPE 'E'.

  ENDIF.



  CALL METHOD OF GO_WORKBOOK 'ExportAsFixedFormat'

    EXPORTING

      #1 = 0

      #2 = PV_PDF

      #3 = 0.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CLOSE_EXCEL

*&---------------------------------------------------------------------*




FORM CLOSE_EXCEL .



  IF GO_WORKBOOK-HANDLE IS NOT INITIAL.

    CALL METHOD OF GO_WORKBOOK 'Close'

      EXPORTING

        #1 = 0.

  ENDIF.



  IF GO_EXCEL-HANDLE IS NOT INITIAL.

    CALL METHOD OF GO_EXCEL 'Quit'.

  ENDIF.



  FREE: GO_RANGE, GO_SHEET, GO_SHEETS,

        GO_WORKBOOK, GO_WORKBOOKS, GO_EXCEL.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DOWNLOAD_TEMPLATE

*&---------------------------------------------------------------------*




FORM DOWNLOAD_TEMPLATE USING PV_XLS TYPE RLGRAP-FILENAME.



  DATA: LS_WWWDATA TYPE WWWDATATAB,

        LV_RC      TYPE SY-SUBRC.



  CLEAR LS_WWWDATA.



  " SE80 MIME# ## OBJID ##

  SELECT SINGLE RELID OBJID

    INTO CORRESPONDING FIELDS OF LS_WWWDATA

    FROM WWWDATA

   WHERE SRTF2 = 0

     AND RELID = 'MI'

     AND OBJID = 'ZWORK18_RATE_HEADER_TMPL'.



  IF SY-SUBRC <> 0.

    MESSAGE '## ###(ZWORK18_RATE_HEADER_TMPL)# ## # ####.' TYPE 'E'.

  ENDIF.



  CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'

    EXPORTING

      KEY         = LS_WWWDATA

      DESTINATION = PV_XLS

    IMPORTING

      RC          = LV_RC.



  IF LV_RC <> 0.

    MESSAGE '## ### #### ##.' TYPE 'E'.

  ENDIF.



ENDFORM.




*--------------------------------------------------------------------*

*      FORM delete_file

*--------------------------------------------------------------------*




FORM DELETE_FILE USING IV_FILE TYPE STRING.



  DATA: LV_EXIST TYPE ABAP_BOOL,

        LV_RC    TYPE I.

  "## ## ## ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_EXIST

    EXPORTING

      FILE   = IV_FILE

    RECEIVING

      RESULT = LV_EXIST

    EXCEPTIONS

      OTHERS = 1.

  "## ## ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_DELETE

    EXPORTING

      FILENAME = IV_FILE

    CHANGING

      RC       = LV_RC

    EXCEPTIONS

      OTHERS   = 1.

ENDFORM.