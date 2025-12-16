
*&---------------------------------------------------------------------*

*&  Include           ZWORK08_002_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_DEFAULTS

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_DEFAULTS .



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  START_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM START_SCREEN . " ## ## ## # #### ## ##



  " ## ## ##

  IF P_ZAEDAT IS INITIAL.

    MESSAGE '##### ######' TYPE 'E'.

  ENDIF.



  " ### ## # ##

  PERFORM GET_DATA.

  PERFORM MODIFY_DATA.



  " ## ##

  IF GT_ZTCURR08_ALV IS INITIAL.

    MESSAGE '### #### ####.' TYPE 'I'.

  ELSE.

    " 100## ALV ### ###

    PERFORM DISPLAY_ALV.

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




FORM GET_DATA . " DB## ## ### ##

  REFRESH GT_ZTCURR08. " ## ## ## ###






*  SELECT A~KURST

*         A~FCURR

*         A~TCURR

*         A~GDATU

*         A~UKURS

*         A~FFACT

*         A~TFACT

*    FROM ZTCURR08 AS A

*    INTO TABLE GT_ZTCURR08

*    WHERE AEDAT = P_ZAEDAT.






  SELECT A~KURST

         A~FCURR

         A~TCURR

         A~GDATU

         A~UKURS

         A~FFACT

         A~TFACT

         A~AENAM AS ZAENAM

         A~AEDAT AS ZAEDAT

    INTO TABLE GT_ZTCURR08

    FROM ZTCURR08 AS A

    WHERE AEDAT = P_ZAEDAT. " ### ###



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DATA . " ###/### ALV# ### ## ##



  REFRESH GT_ZTCURR08_ALV.



  LOOP AT GT_ZTCURR08 INTO GS_ZTCURR08.

    CLEAR GS_ZTCURR08_ALV.



    " ## ## ## (##/## ## ##)

    MOVE-CORRESPONDING GS_ZTCURR08 TO GS_ZTCURR08_ALV.



    APPEND GS_ZTCURR08_ALV TO GT_ZTCURR08_ALV.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DISPLAY_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DISPLAY_ALV . " ALV ### ##

  CALL SCREEN 100.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT . " ALV ####/### ## ## # ### ##



  " ### ####: ### 0100# 'CON1' ### ### ### ##

  CREATE OBJECT GC_CUSTOM

    EXPORTING




*      PARENT                      =




      CONTAINER_NAME              = 'CON1'




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



  " ALV GRID ##

  CREATE OBJECT GC_GRID

    EXPORTING




*      I_SHELLSTYLE      = 0

*      I_LIFETIME        =




      I_PARENT          = GC_CUSTOM. " ## #### ##




*      I_APPL_EVENTS     = space

*      I_PARENTDBG       =

*      I_APPLOGPARENT    =

*      I_GRAPHICSPARENT  =

*      I_NAME            =

*      I_FCAT_COMPLETE   = SPACE

*    EXCEPTIONS

*      ERROR_CNTL_CREATE = 1

*      ERROR_CNTL_INIT   = 2

*      ERROR_CNTL_LINK   = 3

*      ERROR_DP_CREATE   = 4

*      others            = 5




      .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



  " ### ### ## ## # ###

  CREATE OBJECT GO_EVENT_HANDLER.

  SET HANDLER GO_EVENT_HANDLER->HANDLER_TOOLBAR FOR GC_GRID. " ## ###

  SET HANDLER GO_EVENT_HANDLER->HANDLER_USER_COMMAND FOR GC_GRID. " ### ## ###

  SET HANDLER GO_EVENT_HANDLER->HANDLER_DATA_CHANGED FOR GC_GRID. " ### ## ###



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_0100

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG_0100 . " ALV ## #### ##



  " ####

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-FIELDNAME = 'ZKURST'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " ####

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-FIELDNAME = 'ZFCURR'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " ####

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-FIELDNAME = 'ZTCURR'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " ####

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-FIELDNAME = 'ZGDATU'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " ##

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-FIELDNAME = 'ZUKURS'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 12.

  GS_FIELDCAT-DECIMALS = 5.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " ########

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-COLTEXT = '########'.

  GS_FIELDCAT-FIELDNAME = 'ZFFACT'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " ########

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-COLTEXT = '########'.

  GS_FIELDCAT-FIELDNAME = 'ZTFACT'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " ###

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-COLTEXT = '###'.

  GS_FIELDCAT-FIELDNAME = 'ZAENAM'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " ###

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-COLTEXT = '###'.

  GS_FIELDCAT-FIELDNAME = 'ZAEDAT'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_SORT . " ## ## ##



  " #### ####

  CLEAR: GS_SORT, GT_SORT.

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZKURST'.

  GS_SORT-UP = 'X'.

  APPEND GS_SORT TO GT_SORT.



  " #### ####

  CLEAR: GS_SORT.

  GS_SORT-SPOS = 2.

  GS_SORT-FIELDNAME = 'ZFCURR'.

  GS_SORT-UP = 'X'.

  APPEND GS_SORT TO GT_SORT.



  " #### ####

  CLEAR: GS_SORT.

  GS_SORT-SPOS = 3.

  GS_SORT-FIELDNAME = 'ZTCURR'.

  GS_SORT-UP = 'X'.

  APPEND GS_SORT TO GT_SORT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  LAYOUT_SET

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM LAYOUT_SET . " #### ##



  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'. " ### ##



  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID. " ## REPID

  GS_VARIANT-USERNAME = SY-UNAME. " ## ### ID



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GT_ZTCURR08_ALV[]  text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY  USING PT_TABLE TYPE STANDARD TABLE. " ALV# ## #### / ## / VARIANT ##



  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*      I_BUFFER_ACTIVE               =

*      I_BYPASSING_BUFFER            =

*      I_CONSISTENCY_CHECK           =

*      I_STRUCTURE_NAME              =




      IS_VARIANT                    = GS_VARIANT

      I_SAVE                        = 'A'




*      I_DEFAULT                     = 'X'




      IS_LAYOUT                     = GS_LAYOUT




*      IS_PRINT                      =

*      IT_SPECIAL_GROUPS             =

*      IT_TOOLBAR_EXCLUDING          =

*      IT_HYPERLINK                  =

*      IT_ALV_GRAPHICS               =

*      IT_EXCEPT_QINFO               =

*      IR_SALV_ADAPTER               =




    CHANGING

      IT_OUTTAB                     = PT_TABLE

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

*&      Form  ALV_HANDLER_TOOLBAR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_OBJECT  text

*      -->P_E_INTERACTIVE  text

*----------------------------------------------------------------------*




FORM ALV_HANDLER_TOOLBAR  USING    P_E_OBJECT TYPE REF TO CL_ALV_EVENT_TOOLBAR_SET

                                   P_E_INTERACTIVE. " ## ######



  DATA: LS_TOOLBAR TYPE STB_BUTTON.



  CLEAR LS_TOOLBAR.

  LS_TOOLBAR-FUNCTION = 'SAVEPDF'. " UCOMM

  LS_TOOLBAR-QUICKINFO = 'PDF ####'.

  LS_TOOLBAR-TEXT = 'PDF ####'. " ## ###

  APPEND LS_TOOLBAR TO P_E_OBJECT->MT_TOOLBAR.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_USER_COMMAND

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_UCOMM  text

*----------------------------------------------------------------------*




FORM ALV_HANDLER_USER_COMMAND  USING    P_E_UCOMM. " ### ### ##



  CASE P_E_UCOMM.

    WHEN 'SAVEPDF'.

      PERFORM SAVE_PDF.

    WHEN OTHERS.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DATA_CHANGED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_ER_DATA_CHANGED  text

*      -->P_E_ONF4  text

*      -->P_E_ONF4_BEFORE  text

*      -->P_E_ONF4_AFTER  text

*      -->P_E_UCOMM  text

*----------------------------------------------------------------------*




FORM ALV_HANDLER_DATA_CHANGED  USING    P_ER_DATA_CHANGED

                                        P_E_ONF4

                                        P_E_ONF4_BEFORE

                                        P_E_ONF4_AFTER

                                        P_E_UCOMM.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_PDF

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SAVE_PDF . " ALV# ### #### PDF ### #### ##



  DATA: LV_ROW TYPE I,

        LS_ALV LIKE GS_ZTCURR08_ALV,

        LV_PDF_FULLPATH TYPE STRING,

        LV_XLSX_FULLPATH TYPE STRING.



  " ALV #### ## ## #### ### ##

  IF GC_GRID IS BOUND.

    CALL METHOD GC_GRID->CHECK_CHANGED_DATA.

  ENDIF.



  " #### ## ## ##

  IF GT_ZTCURR08_ALV IS INITIAL.

    MESSAGE 'PDF# ### #### ####.' TYPE 'I'.

    EXIT.

  ENDIF.



  " ##### ### ## ### ####

  PERFORM GET_DIRECTORY.

  IF GV_PDF_DIR IS INITIAL.

    MESSAGE 'PDF ### #######.' TYPE 'I'.

    EXIT.

  ENDIF.



  " ## ## ##

  " ## #### ## ### ##

  CONCATENATE GV_TEMP_DIR '\#####.xlsx' INTO GV_TEMPLATE_FULLPATH. " LV_XLSX_FULLPATH.

  " ## PDF ### #### ### ### ##

  CONCATENATE GV_PDF_DIR '\#####.pdf' INTO GV_PDF_FULLPATH.



  " SMW0# ### ## ### ####

   PERFORM DOWNLOAD_TEMPLATE.



  " ##### ## ### ### OLE# ##

  PERFORM OPEN_EXCEL_TEMPLATE.



  " ## ## ### ALV #### # ## ##

  PERFORM FILE_EXCEL_LINE.



  " ### PDF# #### ## ##

  CALL METHOD OF GO_WORKBOOK 'ExportAsFixedFormat'

    EXPORTING

      #1 = 0  " TYPE = 0 # PDF

      #2 = GV_PDF_FULLPATH.



  " ## ### ##

  IF SY-SUBRC <> 0.

    MESSAGE 'Excel PDF ## # ### ######.' TYPE 'E'.

  ELSE.

    MESSAGE |PDF# { GV_PDF_FULLPATH } # #######.| TYPE 'S'.

  ENDIF.



  " ## #### ## # ### ##

  CALL METHOD OF GO_WORKBOOK 'Close'.

  CALL METHOD OF GO_EXCEL 'Quit'.



  FREE OBJECT GO_WORKSHEET.

  FREE OBJECT GO_WORKBOOK.

  FREE OBJECT GO_WORKBOOKS.

  FREE OBJECT GO_EXCEL.

  FREE OBJECT GO_RANGE.



  " ## ### ## ##

  PERFORM DELETE_FILE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_CELL

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_1      text

*      -->P_9      text

*      -->P_0613   text

*----------------------------------------------------------------------*




FORM SET_CELL  USING    P_ROW TYPE I " # ##

                        P_COL TYPE I " # ##

                        P_VALUE TYPE ANY. " ## ### ### ### ## #### OLE ## ## ##

  DATA: LV_VALUE TYPE STRING. " OLE ### ## ## ## ### ##



  LV_VALUE = P_VALUE. " ## ## ## #### ##



  " ## #### ## # ### ##

  CALL METHOD OF GO_WORKSHEET 'Cells' = GO_RANGE

    EXPORTING

      #1 = P_ROW " # ## ####: # ##

      #2 = P_COL. " # ## ####: # ##



  " ### ## ## ## ##

  SET PROPERTY OF GO_RANGE 'Value' = LV_VALUE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DIRECTORY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DIRECTORY . " ## ## ### ##



  " ## ## ## ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>GET_TEMP_DIRECTORY

    CHANGING

      TEMP_DIR = GV_TEMP_DIR " ### ### ## ##

    EXCEPTIONS

      OTHERS = 1.



  " ## ### ### ##

  CALL METHOD CL_GUI_CFW=>FLUSH.



  " ## ##

  IF SY-SUBRC <> 0 OR GV_TEMP_DIR IS INITIAL.

    MESSAGE '## #### ## # ### ######.' TYPE 'E'.

    EXIT.

  ENDIF.



  " #### PDF# ### ### ## ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>DIRECTORY_BROWSE

    CHANGING

      SELECTED_FOLDER = GV_PDF_DIR

    EXCEPTIONS

      OTHERS = 1.



  " ## ##

  IF SY-SUBRC <> 0.

    CLEAR GV_PDF_DIR.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DOWNLOAD_TEMPLATE

*&---------------------------------------------------------------------*

*----------------------------------------------------------------------*




FORM DOWNLOAD_TEMPLATE . " SMW0# ### #### ### PC# ####



  DATA: LS_WWWDATA TYPE WWWDATATAB,

        LV_RC      TYPE I,

        LV_FILE    TYPE RLGRAP-FILENAME.





  " S

  LV_FILE = GV_TEMPLATE_FULLPATH.



  " ## ## ### ### ##

  IF LV_FILE IS NOT INITIAL.

    CALL FUNCTION 'WS_FILE_DELETE'

      EXPORTING

        FILE = LV_FILE

      EXCEPTIONS

        OTHERS = 1.

  ENDIF.



  " WWWDATA## ### ## ##

  CLEAR LS_WWWDATA.

  SELECT SINGLE * INTO CORRESPONDING FIELDS OF LS_WWWDATA

    FROM WWWDATA

    WHERE OBJID = 'ZWORK08_EXCEL_TEMPLATE'.



  IF SY-SUBRC <> 0.

    MESSAGE 'WWWDATA## ## ###(ZWORK08_EXCEL_TEMPLATE)# ## # ####.' TYPE 'E'.

    EXIT.

  ENDIF.



  " ## #### ##

  CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'

    EXPORTING

      KEY         = LS_WWWDATA

      DESTINATION = LV_FILE

    IMPORTING

      RC          = LV_RC.



  IF LV_RC <> 0.

    MESSAGE '## ### #### # ### ######.' TYPE 'E'.

    EXIT.

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  OPEN_EXCEL_TEMPLATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM OPEN_EXCEL_TEMPLATE .



  " ## ###### ## ##

  CREATE OBJECT GO_EXCEL 'EXCEL.APPLICATION'.



  IF SY-SUBRC <> 0.

    MESSAGE 'EXCEL OLE ## # ### ######.' TYPE 'E'.

    EXIT.

  ENDIF.



  " ## ## ### ### ## ##

  SET PROPERTY OF GO_EXCEL 'Visible' = 0.



  " ### ### ####

  CALL METHOD OF GO_EXCEL 'Workbooks' = GO_WORKBOOKS.



  " ### ## ##

  CALL METHOD OF GO_WORKBOOKS 'Open' = GO_WORKBOOK

    EXPORTING

      #1 = GV_TEMPLATE_FULLPATH.



  " ## ## ####

  CALL METHOD OF GO_EXCEL 'ActiveSheet' = GO_WORKSHEET.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FILE_EXCEL_LINE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FILE_EXCEL_LINE . " ## ### ### #### ##



  DATA: LV_ROW TYPE I,

        LS_ALV LIKE GS_ZTCURR08_ALV.



  " 1#: ## ##

  PERFORM SET_CELL USING 1 1 '####'.

  PERFORM SET_CELL USING 1 2 '####'.

  PERFORM SET_CELL USING 1 3 '####'.

  PERFORM SET_CELL USING 1 4 '####'.

  PERFORM SET_CELL USING 1 5 '##'.

  PERFORM SET_CELL USING 1 6 '########'.

  PERFORM SET_CELL USING 1 7 '########'.

  PERFORM SET_CELL USING 1 8 '###'.

  PERFORM SET_CELL USING 1 9 '###'.



  " #### 2### ##

  LV_ROW = 2.



  " ### #### ## ## ### ##

  LOOP AT GT_ZTCURR08_ALV INTO LS_ALV.



    PERFORM SET_CELL USING LV_ROW 1 LS_ALV-ZKURST.

    PERFORM SET_CELL USING LV_ROW 2 LS_ALV-ZFCURR.

    PERFORM SET_CELL USING LV_ROW 3 LS_ALV-ZTCURR.

    PERFORM SET_CELL USING LV_ROW 4 LS_ALV-ZGDATU.

    PERFORM SET_CELL USING LV_ROW 5 LS_ALV-ZUKURS.

    PERFORM SET_CELL USING LV_ROW 6 LS_ALV-ZFFACT.

    PERFORM SET_CELL USING LV_ROW 7 LS_ALV-ZTFACT.

    PERFORM SET_CELL USING LV_ROW 8 LS_ALV-ZAENAM.

    PERFORM SET_CELL USING LV_ROW 9 LS_ALV-ZAEDAT.



    " ## ### ##

    LV_ROW = LV_ROW + 1.



  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DELETE_FILE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DELETE_FILE . " ## ## # ## ## ## ##



  DATA: LV_RC TYPE I.



  " ### ## ### ##### ##

  IF GV_TEMPLATE_FULLPATH IS INITIAL.

    EXIT.

  ENDIF.



  " ### PC# ## ## ### ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_DELETE

    EXPORTING

      FILENAME = GV_TEMPLATE_FULLPATH

    CHANGING

      RC = LV_RC

    EXCEPTIONS

      FILE_DELETE_FAILED = 1

      CNTL_ERROR = 2

      ERROR_NO_GUI = 3

      NOT_SUPPORTED_BY_GUI = 4

      OTHERS = 5.



  IF SY-SUBRC <> 0.

    MESSAGE '## ## ## # ### ######.' TYPE 'I'.

  ENDIF.



ENDFORM.