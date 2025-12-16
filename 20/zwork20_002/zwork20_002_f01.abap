
*&---------------------------------------------------------------------*

*&  Include           ZWORK20_002_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT .    " ## ##

  CREATE OBJECT GC_CUSTOM   " ### #### ## ##

    EXPORTING




*      PARENT                      =




      CONTAINER_NAME              = 'CUSTOM1'




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

  CREATE OBJECT GC_GRID   " ALV## ##

    EXPORTING




*      I_SHELLSTYLE      = 0

*      I_LIFETIME        =




      I_PARENT          = GC_CUSTOM




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

  CLEAR: GS_FIELDCAT, GT_FIELDCAT.

 GS_FIELDCAT-COL_POS = 1.

 GS_FIELDCAT-FIELDNAME = 'KURST'.

 GS_FIELDCAT-SCRTEXT_M = '####'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 2.

 GS_FIELDCAT-FIELDNAME = 'FCURR'.

 GS_FIELDCAT-SCRTEXT_M = '####'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 3.

 GS_FIELDCAT-FIELDNAME = 'TCURR'.

 GS_FIELDCAT-SCRTEXT_M = '####'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 4.

 GS_FIELDCAT-FIELDNAME = 'GDATU'.

 GS_FIELDCAT-SCRTEXT_M = '####'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 5.

 GS_FIELDCAT-FIELDNAME = 'ZUKURS'.    " ### ## #### ## ##### ### ### ##

 GS_FIELDCAT-SCRTEXT_M = '##'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 6.

 GS_FIELDCAT-FIELDNAME = 'FFACT'.

 GS_FIELDCAT-SCRTEXT_M = '########'.

 GS_FIELDCAT-OUTPUTLEN = 12.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 7.

 GS_FIELDCAT-FIELDNAME = 'TFACT'.

 GS_FIELDCAT-SCRTEXT_M = '########'.

 GS_FIELDCAT-OUTPUTLEN = 12.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 8.

 GS_FIELDCAT-FIELDNAME = 'ZUNAME'.

 GS_FIELDCAT-SCRTEXT_M = '###'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 9.

 GS_FIELDCAT-FIELDNAME = 'ZDATE'.

 GS_FIELDCAT-SCRTEXT_M = '###'.

 GS_FIELDCAT-OUTPUTLEN = 12.

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




FORM ALV_SORT .



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

  CLEAR: GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.



  CLEAR: GS_VARIANT.

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




FORM CALL_ALV .   " ALV ##

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

      IT_OUTTAB                     = GT_EXCHANGE

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

*&      Form  SET_DEFAULT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_DEFAULT .    " ### #### ##

  P_DATE = SY-DATUM.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .   " #### ### ### ### ##

  SELECT

    *

    FROM ZTCURR20

    INTO CORRESPONDING FIELDS OF TABLE GT_ZTCURR20

    WHERE GDATU = P_DATE.

  PERFORM CHECK_INPUT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DATA .    " #### ## ### ## ##

  LOOP AT GT_ZTCURR20 INTO GS_ZTCURR20.

    CLEAR: GS_EXCHANGE.

    MOVE-CORRESPONDING GS_ZTCURR20 TO GS_EXCHANGE.

    GS_EXCHANGE-ZUNAME = SY-UNAME.

    GS_EXCHANGE-ZDATE = SY-DATUM.

    MOVE GS_ZTCURR20-UKURS TO GS_EXCHANGE-ZUKURS.

    APPEND GS_EXCHANGE TO GT_EXCHANGE.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLE_USERCMD

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_UCOMM  text

*----------------------------------------------------------------------*




FORM ALV_HANDLE_USERCMD  USING    P_UCOMM.    " ##### ###

  CASE P_UCOMM.

    WHEN 'DOWNLOAD'.    " #### ## ###

      PERFORM DOWNLOAD_PDF.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLE_TOOLBAR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_OBJECT  text

*      -->P_E_INTERACTIVE  text

*----------------------------------------------------------------------*




FORM ALV_HANDLE_TOOLBAR  USING    P_OBJECT TYPE REF TO CL_ALV_EVENT_TOOLBAR_SET   " TOOLBAR ##

                                  P_INTERACTIVE.

  DATA: LS_TOOLBAR TYPE STB_BUTTON.



  LS_TOOLBAR-FUNCTION = 'DOWNLOAD'.

  LS_TOOLBAR-ICON = ICON_SYSTEM_SAVE.

  LS_TOOLBAR-QUICKINFO = 'PDF# ####'.

  LS_TOOLBAR-TEXT = 'PDF'.



  APPEND LS_TOOLBAR TO P_OBJECT->MT_TOOLBAR.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DOWNLOAD_PDF

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DOWNLOAD_PDF .   " PDF #### ##

  PERFORM GET_DIRECTORY.

  PERFORM DOWNLOAD_TEMPLATE.

  PERFORM OPEN_EXCEL_TEMPLATE.

  PERFORM FILL_EXCEL_LINE.

  PERFORM DELETE_FILE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DIRECTORY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DIRECTORY .    " ### ####

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>GET_TEMP_DIRECTORY    " #### ### ## ## ### ### ## ## ###

    CHANGING

      TEMP_DIR             = GV_TEMP_DT




*    EXCEPTIONS

*      CNTL_ERROR           = 1

*      ERROR_NO_GUI         = 2

*      NOT_SUPPORTED_BY_GUI = 3

*      others               = 4




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>DIRECTORY_BROWSE    " PDF### ### ## ### ###




*    EXPORTING

*      WINDOW_TITLE         =

*      INITIAL_FOLDER       =




    CHANGING

      SELECTED_FOLDER      = GV_FILE_DT




*    EXCEPTIONS

*      CNTL_ERROR           = 1

*      ERROR_NO_GUI         = 2

*      NOT_SUPPORTED_BY_GUI = 3

*      others               = 4




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DOWNLOAD_TEMPLATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DOWNLOAD_TEMPLATE .    " ### ####

  DATA: LS_WWWDATA TYPE WWWDATATAB,

        LV_FILE TYPE RLGRAP-FILENAME.

  MOVE GV_TEMP_DT TO LV_FILE.   " ## ### ## ###

  CALL FUNCTION 'WS_FILE_DELETE'    " TEMP ## ##

    EXPORTING

      FILE          = LV_FILE




*   IMPORTING

*     RETURN        =




            .

  SELECT SINGLE * FROM WWWDATA INTO CORRESPONDING FIELDS OF LS_WWWDATA    " ### ID# ## ###

    WHERE OBJID = 'ZWORK002_EXCEL_TEMPLATE'"'ZED20_EXCEL_TEMPLATE'

    AND RELID = 'MI'.



  CONCATENATE GV_TEMP_DT '\TEMPLATE.xls' INTO GV_FILE.    " TEMP### ### ##### ##





  CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'   " ### ####

    EXPORTING

      KEY               = LS_WWWDATA

      DESTINATION       = GV_FILE




*   IMPORTING

*     RC                =

*   CHANGING

*     TEMP              =




            .

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  OPEN_EXCEL_TEMPLATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM OPEN_EXCEL_TEMPLATE .    " ## ### ##

  CREATE OBJECT GV_EXCEL_APP 'EXCEL.APPLICATION'.   " ## ###### ## ##



  CALL METHOD OF GV_EXCEL_APP 'WORKBOOKS' = GV_EXCEL_WORKBOOK.    " ### ## ##

  CALL METHOD OF GV_EXCEL_WORKBOOK 'OPEN'   " ## ##

    EXPORTING

      #1 = GV_FILE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FILL_EXCEL_LINE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FILL_EXCEL_LINE .    " ### ### ##

  DATA: W_CELL1 TYPE OLE2_OBJECT.

  GET PROPERTY OF GV_EXCEL_APP 'ActiveSheet' = GV_EXCEL_WORKBOOK.   " GV_EXCEL_WORKBOOK# ## ###



  PERFORM SET_PAGE.



  SET PROPERTY OF GV_EXCEL_WORKBOOK 'Name' = 'TEMPLATE'.    " #### TEMPLATE

  PERFORM CLIPBOARD_EXPORT.   " ### ### ##

  CALL METHOD OF GV_EXCEL_WORKBOOK 'CELLS' = W_CELL1    " ### # ##

    EXPORTING

      #1 = 2

      #2 = 1.

  CALL METHOD OF W_CELL1 'SELECT'.    " ### # ##

  CALL METHOD OF GV_EXCEL_WORKBOOK 'PASTE'.   " ### ####






*  PERFORM SET_VALUE USING GV_EXCEL_WORKBOOK.    " # ##### ## # ####






  CONCATENATE GV_FILE_DT '\' P_DATE '####.pdf' INTO GV_FILE_DT.   " ##.PDF### ### ##

  CALL METHOD OF GV_EXCEL_WORKBOOK 'ExportAsFixedFormat'    " PDF# ##

    EXPORTING

      #1 = 0

      #2 = GV_FILE_DT.

  IF SY-SUBRC = 0.




*    MESSAGE '### #######.' TYPE 'I'.




  ELSE.

    MESSAGE '### ######.' TYPE 'I'.

  ENDIF.

  SET PROPERTY OF GV_EXCEL_APP 'DisplayAlerts' = 0.   " ########? X



  FREE OBJECT: W_CELL1.   " ### ##

  CALL METHOD OF GV_EXCEL_APP 'Quit'.   " ## ##



  FREE OBJECT: GV_EXCEL_WORKBOOK, GV_EXCEL_APP.   " ### ##

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CLIPBOARD_EXPORT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CLIPBOARD_EXPORT .   " ##### ##

  DATA: LV_RC TYPE I.

  PERFORM MODIFY_EXCHANGE.    " ## ### ##



  CALL METHOD CL_GUI_FRONTEND_SERVICES=>CLIPBOARD_EXPORT    " ### #### ##### ##




*    EXPORTING

*      NO_AUTH_CHECK        = SPACE




    IMPORTING

      DATA                 = GT_CLIPBOARD

    CHANGING

      RC                   = LV_RC




*    EXCEPTIONS

*      CNTL_ERROR           = 1

*      ERROR_NO_GUI         = 2

*      NOT_SUPPORTED_BY_GUI = 3

*      NO_AUTHORITY         = 4

*      others               = 5




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DELETE_FILE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DELETE_FILE .    " TEMP# #### ##

  DATA: LV_RC TYPE I,

        LV_FILENAME TYPE STRING.

  MOVE GV_FILE TO LV_FILENAME.

  WAIT UP TO 1 SECONDS.   " ### ##### ###

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_DELETE   " TEMP## ##

    EXPORTING

      FILENAME             = LV_FILENAME

    CHANGING

      RC                   = LV_RC




*    EXCEPTIONS

*      FILE_DELETE_FAILED   = 1

*      CNTL_ERROR           = 2

*      ERROR_NO_GUI         = 3

*      FILE_NOT_FOUND       = 4

*      ACCESS_DENIED        = 5

*      UNKNOWN_ERROR        = 6

*      NOT_SUPPORTED_BY_GUI = 7

*      WRONG_PARAMETER      = 8

*      others               = 9




          .

  IF SY-SUBRC = 0.

    MESSAGE '### #######.' TYPE 'I'.

    EXIT.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_EXCHANGE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      <--P_LT_CLIPBOARD  text

*----------------------------------------------------------------------*




FORM MODIFY_EXCHANGE.   " ## ### ##

  DATA: LV_CLIPBOARD TYPE LINE OF T_DATA,"TYPE STRING,

        LV_UKURS TYPE STRING,

        LV_FFACT TYPE STRING,

        LV_TFACT TYPE STRING,

        LV_TAB       TYPE C VALUE CL_ABAP_CHAR_UTILITIES=>HORIZONTAL_TAB.

  LOOP AT GT_EXCHANGE INTO GS_EXCHANGE.   " ### ##### TAB## #### ### #####

    MOVE GS_EXCHANGE-ZUKURS TO LV_UKURS.

    MOVE GS_EXCHANGE-FFACT TO LV_FFACT.

    MOVE GS_EXCHANGE-TFACT TO LV_TFACT.

    CONCATENATE GS_EXCHANGE-KURST

                GS_EXCHANGE-FCURR

                GS_EXCHANGE-TCURR

                GS_EXCHANGE-GDATU

                LV_UKURS"GS_EXCHANGE-ZUKURS

                LV_FFACT"GS_EXCHANGE-FFACT

                LV_TFACT"GS_EXCHANGE-TFACT

                GS_EXCHANGE-ZUNAME

                GS_EXCHANGE-ZDATE

                INTO LV_CLIPBOARD

                SEPARATED BY LV_TAB.

    APPEND LV_CLIPBOARD TO GT_CLIPBOARD.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CLASS_EVENT .    " ### ## # ### ##

  CREATE OBJECT GO_EVENT.

  SET HANDLER GO_EVENT->HANDLE_TOOLBAR FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLE_USER_COMMAND FOR GC_GRID.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_INPUT .

  IF SY-SUBRC <> 0.

    MESSAGE '### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_PAGE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_PAGE .   " #### ## #### ######.

  DATA: LV_PAGE_SETUP TYPE OLE2_OBJECT.



  GET PROPERTY OF GV_EXCEL_WORKBOOK 'PageSetup' = LV_PAGE_SETUP.

  IF SY-SUBRC <> 0.

    MESSAGE 'PageSetup ### ### # ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  "## ## ### ##

  SET PROPERTY OF LV_PAGE_SETUP 'Orientation' = 2.



  "##/## ##(Zoom) ##

  SET PROPERTY OF LV_PAGE_SETUP 'Zoom' = 0.



  "## 1#### ##

  SET PROPERTY OF LV_PAGE_SETUP 'FitToPagesWide' = 1.



  "## ## ##

  SET PROPERTY OF LV_PAGE_SETUP 'FitToPagesTall' = 0.



  FREE OBJECT LV_PAGE_SETUP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_VALUE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GV_EXCEL_WORKBOOK  text

*----------------------------------------------------------------------*




FORM SET_VALUE  USING    P_EXCEL_WORKBOOK.

  DATA: LV_ROW TYPE I.



  LOOP AT GT_EXCHANGE INTO GS_EXCHANGE.   " GT_ZTCURR20# ### ## # ##### ## ####

    LV_ROW = SY-TABIX + 1.

    PERFORM SET_CELL USING P_EXCEL_WORKBOOK LV_ROW 1 GS_EXCHANGE-KURST.

    PERFORM SET_CELL USING P_EXCEL_WORKBOOK LV_ROW 2 GS_EXCHANGE-FCURR.

    PERFORM SET_CELL USING P_EXCEL_WORKBOOK LV_ROW 3 GS_EXCHANGE-TCURR.

    PERFORM SET_CELL USING P_EXCEL_WORKBOOK LV_ROW 4 GS_EXCHANGE-GDATU.

    PERFORM SET_CELL USING P_EXCEL_WORKBOOK LV_ROW 5 GS_EXCHANGE-ZUKURS.

    PERFORM SET_CELL USING P_EXCEL_WORKBOOK LV_ROW 6 GS_EXCHANGE-FFACT.

    PERFORM SET_CELL USING P_EXCEL_WORKBOOK LV_ROW 7 GS_EXCHANGE-TFACT.

    PERFORM SET_CELL USING P_EXCEL_WORKBOOK LV_ROW 8 GS_EXCHANGE-ZUNAME.

    PERFORM SET_CELL USING P_EXCEL_WORKBOOK LV_ROW 9 GS_EXCHANGE-ZDATE.

    CLEAR: GS_ZTCURR20.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_CELL

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_P_EXCEL_WORKBOOK  text

*      -->P_LV_LOW  text

*      -->P_1      text

*      -->P_GS_ZTCURR20_KURST  text

*----------------------------------------------------------------------*




FORM SET_CELL  USING    P_EXCEL_WORKBOOK

                        P_ROW

                        P_COL

                        P_VALUE.

  DATA LV_CELL TYPE OLE2_OBJECT.

  CALL METHOD OF P_EXCEL_WORKBOOK 'CELLS' = LV_CELL

    EXPORTING

      #1 = P_ROW

      #2 = P_COL.

  SET PROPERTY OF LV_CELL 'VALUE' = P_VALUE.

  FREE LV_CELL.

ENDFORM.