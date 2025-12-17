
*&---------------------------------------------------------------------*

*&  Include           ZWORK10_2_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       EXCEL DATA ####

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .

  RANGES LR_GDATU FOR ZTCURR10-GDATU.

  LR_GDATU-SIGN = 'I'.

  LR_GDATU-OPTION = 'EQ'.

  LR_GDATU-LOW = P_DATE.

  APPEND LR_GDATU.



  SELECT * FROM ZTCURR10 INTO TABLE GT_EXCEL_DATA WHERE GDATU IN LR_GDATU.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJ

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJ .

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

*&      Form  FCAT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FCAT .

  CLEAR GT_FCAT.

  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = '10'.

  GS_FCAT-FIELDNAME = 'KURST'.

  GS_FCAT-COLTEXT = '####'.

  APPEND GS_FCAT TO GT_FCAT.



  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = '11'.

  GS_FCAT-FIELDNAME = 'FCURR'.

  GS_FCAT-COLTEXT = '####'.

  APPEND GS_FCAT TO GT_FCAT.



  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = '12'.

  GS_FCAT-FIELDNAME = 'TCURR'.

  GS_FCAT-COLTEXT = '####'.

  APPEND GS_FCAT TO GT_FCAT.



  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = '13'.

  GS_FCAT-FIELDNAME = 'GDATU'.

  GS_FCAT-COLTEXT = '####'.

  GS_FCAT-REF_TABLE = 'ZTCURR10'.

  GS_FCAT-REF_FIELD = 'GDATU'.

  GS_FCAT-OUTPUTLEN = 10.

  APPEND GS_FCAT TO GT_FCAT.



  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = '14'.

  GS_FCAT-FIELDNAME = 'UKURS'.

  GS_FCAT-COLTEXT = '##'.

  APPEND GS_FCAT TO GT_FCAT.



  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = '15'.

  GS_FCAT-FIELDNAME = 'FFACT'.

  GS_FCAT-COLTEXT = '########'.

  APPEND GS_FCAT TO GT_FCAT.



  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = '16'.

  GS_FCAT-FIELDNAME = 'TFACT'.

  GS_FCAT-COLTEXT = '########'.

  APPEND GS_FCAT TO GT_FCAT.



  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = '17'.

  GS_FCAT-FIELDNAME = 'ERNAM'.

  GS_FCAT-COLTEXT = '###'.

  APPEND GS_FCAT TO GT_FCAT.



  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = '18'.

  GS_FCAT-FIELDNAME = 'ERDAT'.

  GS_FCAT-COLTEXT = '###'.

  GS_FCAT-OUTPUTLEN = 10.

  APPEND GS_FCAT TO GT_FCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SORT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SORT .

  CLEAR GT_SORT.

  CLEAR GS_SORT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  LAYO

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM LAYO .

  CLEAR GS_LAYO.

  GS_LAYO-ZEBRA = 'X'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DISPLAY .

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY




*    EXPORTING

*      I_BUFFER_ACTIVE               =

*      I_BYPASSING_BUFFER            =

*      I_CONSISTENCY_CHECK           =

*      I_STRUCTURE_NAME              =

*      IS_VARIANT                    =

*      I_SAVE                        =

*      I_DEFAULT                     = 'X'

*      IS_LAYOUT                     = GS_LAYO

*      IS_PRINT                      =

*      IT_SPECIAL_GROUPS             =

*      IT_TOOLBAR_EXCLUDING          =

*      IT_HYPERLINK                  =

*      IT_ALV_GRAPHICS               =

*      IT_EXCEPT_QINFO               =

*      IR_SALV_ADAPTER               =




    CHANGING

      IT_OUTTAB       = GT_EXCEL_DATA

      IT_FIELDCATALOG = GT_FCAT




*     IT_SORT         = GT_SORT

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

*&      Form  REFRESH

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




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

*&      Form  GDATU_SH

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1       text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GDATU_SH .

  CLEAR: GS_FIELD_TAB, GT_FIELD_TAB, GT_GDATU, GT_VALUE_TAB.

  GS_FIELD_TAB-FIELDNAME = 'GDATU'.

  GS_FIELD_TAB-TABNAME = 'ZTCURR10'.

  GS_FIELD_TAB-INTTYPE = 'GDATU_INV'.

  GS_FIELD_TAB-INTLEN = 8.

  APPEND GS_FIELD_TAB TO GT_FIELD_TAB.

  SELECT DISTINCT GDATU

    FROM ZTCURR10

    INTO TABLE GT_GDATU.

  CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'

    EXPORTING




*     DDIC_STRUCTURE  = ' '




      RETFIELD        = 'GDATU'




*     PVALKEY         = ' '




      DYNPPROG        = SY-REPID

      DYNPNR          = SY-DYNNR

      DYNPROFIELD     = 'P_DATE'




*     STEPL           = 0

*     WINDOW_TITLE    =

*     VALUE           = ' '




      VALUE_ORG       = 'S'




*     MULTIPLE_CHOICE = ' '

*     DISPLAY         = ' '

*     CALLBACK_PROGRAM       = ' '

*     CALLBACK_FORM   = ' '

*     CALLBACK_METHOD =

*     MARK_TAB        =

* IMPORTING

*     USER_RESET      =




    TABLES

      VALUE_TAB       = GT_GDATU




*     FIELD_TAB       = GT_FIELD_TAB




      RETURN_TAB      = GT_VALUE_TAB




*     DYNPFLD_MAPPING =




    EXCEPTIONS

      PARAMETER_ERROR = 1

      NO_VALUES_FOUND = 2

      OTHERS          = 3.



  IF SY-SUBRC <> 0.




* Implement suitable error handling here




  ELSE.

    READ TABLE GT_VALUE_TAB INDEX 1 INTO GS_VALUE_TAB.

    IF SY-SUBRC = 0.

      " ## conversion

      GV_GDATU_CONV =

      GS_VALUE_TAB-FIELDVAL(4) &&

      GS_VALUE_TAB-FIELDVAL+5(2) &&

      GS_VALUE_TAB-FIELDVAL+8(2).

      P_DATE = GV_GDATU_CONV.

    ENDIF.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DOWNLOAD_PDF

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DOWNLOAD_PDF .   " PDF #### ##, ssu-20 ###.

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

      TEMP_DIR = GV_TEMP_DIR




*    EXCEPTIONS

*     CNTL_ERROR           = 1

*     ERROR_NO_GUI         = 2

*     NOT_SUPPORTED_BY_GUI = 3

*     others   = 4




    .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>DIRECTORY_BROWSE    " PDF### ### ## ### ###




*    EXPORTING

*      WINDOW_TITLE         =

*      INITIAL_FOLDER       =




    CHANGING

      SELECTED_FOLDER = GV_OUTPUT_PATH




*    EXCEPTIONS

*     CNTL_ERROR      = 1

*     ERROR_NO_GUI    = 2

*     NOT_SUPPORTED_BY_GUI = 3

*     others          = 4




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

        LV_FILE    TYPE RLGRAP-FILENAME.

  MOVE GV_TEMP_DIR TO LV_FILE.   " ## ### ## ###

  CALL FUNCTION 'WS_FILE_DELETE'    " TEMP ## ##

    EXPORTING

      FILE = LV_FILE




*   IMPORTING

*     RETURN        =




    .

  SELECT SINGLE * FROM WWWDATA INTO CORRESPONDING FIELDS OF LS_WWWDATA    " ### ID# ## ###

    WHERE OBJID = C_TEMPLATE_ID "'ZED20_EXCEL_TEMPLATE'

    AND RELID = 'MI'.



  CONCATENATE GV_TEMP_DIR '\TEMPLATE.xls' INTO GV_TEMPLATE_PATH.    " TEMP### ### ##### ##





  CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'   " ### ####

    EXPORTING

      KEY         = LS_WWWDATA

      DESTINATION = GV_TEMPLATE_PATH




*   IMPORTING

*     RC          =

*   CHANGING

*     TEMP        =




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

  CREATE OBJECT EXCEL 'EXCEL.APPLICATION'. " ## ###### ## ##



  CALL METHOD OF EXCEL 'WORKBOOKS' = WORKBOOK. " ### ## ##

  CALL METHOD OF WORKBOOK 'OPEN'   " ## ##

    EXPORTING

      #1 = GV_TEMPLATE_PATH.



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

  DATA: LV_DAT TYPE D.

  GET PROPERTY OF EXCEL 'ActiveSheet' = WORKBOOK.   " GV_EXCEL_WORKBOOK# ## ###



  PERFORM SET_PAGE.



  SET PROPERTY OF EXCEL 'Name' = 'TEMPLATE'.    " #### TEMPLATE

  PERFORM CLIPBOARD_EXPORT.   " ### ### ##

  CALL METHOD OF WORKBOOK 'CELLS' = W_CELL1    " ### # ##

    EXPORTING

      #1 = 2

      #2 = 1.

  CALL METHOD OF W_CELL1 'SELECT'. " ### # ##

  CALL METHOD OF WORKBOOK 'PASTE'. " ### ####






*  PERFORM SET_VALUE USING GV_EXCEL_WORKBOOK.    " # ##### ## # ####






  CONVERT INVERTED-DATE P_DATE INTO DATE LV_DAT.



  CONCATENATE GV_OUTPUT_PATH '\' LV_DAT '####.pdf' INTO GV_OUTPUT_PATH.   " ##.PDF### ### ##

  CALL METHOD OF WORKBOOK 'ExportAsFixedFormat'    " PDF# ##

    EXPORTING

      #1 = 0

      #2 = GV_OUTPUT_PATH.

  IF SY-SUBRC = 0.




*    MESSAGE '### #######.' TYPE 'I'.




  ELSE.

    MESSAGE '### ######.' TYPE 'I'.

  ENDIF.

  SET PROPERTY OF EXCEL 'DisplayAlerts' = 0.   " ########? X



  FREE OBJECT: W_CELL1.   " ### ##

  CALL METHOD OF EXCEL 'Quit'. " ## ##



  FREE OBJECT: WORKBOOK, EXCEL.   " ### ##

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

      DATA = GT_CLIPBOARD

    CHANGING

      RC   = LV_RC




*    EXCEPTIONS

*     CNTL_ERROR           = 1

*     ERROR_NO_GUI         = 2

*     NOT_SUPPORTED_BY_GUI = 3

*     NO_AUTHORITY         = 4

*     others               = 5




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

  DATA: LV_RC       TYPE I,

        LV_FILENAME TYPE STRING.

  MOVE GV_TEMPLATE_PATH TO LV_FILENAME.

  WAIT UP TO 1 SECONDS.   " ### ##### ###

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_DELETE   " TEMP## ##

    EXPORTING

      FILENAME = LV_FILENAME

    CHANGING

      RC       = LV_RC




*    EXCEPTIONS

*     FILE_DELETE_FAILED   = 1

*     CNTL_ERROR           = 2

*     ERROR_NO_GUI         = 3

*     FILE_NOT_FOUND       = 4

*     ACCESS_DENIED        = 5

*     UNKNOWN_ERROR        = 6

*     NOT_SUPPORTED_BY_GUI = 7

*     WRONG_PARAMETER      = 8

*     others   = 9




    .

  IF SY-SUBRC = 0.

    CALL FUNCTION 'POPUP_TO_DISPLAY_TEXT'

      EXPORTING

        TITEL        = '## ##'

        TEXTLINE1    = '### #######.'

        TEXTLINE2    = |## ##: { GV_OUTPUT_PATH }|

        START_COLUMN = 25

        START_ROW    = 6.



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

  DATA: LV_CLIPBOARD TYPE LINE OF T_DATA, "TYPE STRING,

        LV_GDATU     TYPE D,

        LV_UKURS     TYPE STRING,

        LV_FFACT     TYPE STRING,

        LV_TFACT     TYPE STRING,

        LV_TAB       TYPE C VALUE CL_ABAP_CHAR_UTILITIES=>HORIZONTAL_TAB.

  LOOP AT GT_EXCEL_DATA INTO GS_EXCEL_DATA.   " ### ##### TAB## #### ### #####

    MOVE GS_EXCEL_DATA-UKURS TO LV_UKURS.

    MOVE GS_EXCEL_DATA-FFACT TO LV_FFACT.

    MOVE GS_EXCEL_DATA-TFACT TO LV_TFACT.

    CONVERT INVERTED-DATE GS_EXCEL_DATA-GDATU INTO DATE LV_GDATU.



    CONCATENATE GS_EXCEL_DATA-KURST

                GS_EXCEL_DATA-FCURR

                GS_EXCEL_DATA-TCURR

                LV_GDATU

                LV_UKURS

                LV_FFACT

                LV_TFACT

                GS_EXCEL_DATA-ERNAM

                GS_EXCEL_DATA-ERDAT

                INTO LV_CLIPBOARD

                SEPARATED BY LV_TAB.

    APPEND LV_CLIPBOARD TO GT_CLIPBOARD.

  ENDLOOP.

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



  GET PROPERTY OF WORKBOOK 'PageSetup' = LV_PAGE_SETUP.

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



  LOOP AT GT_EXCEL_DATA INTO GS_EXCEL_DATA.   " GT_ZTCURR20# ### ## # ##### ## ####

    LV_ROW = SY-TABIX + 1.

    PERFORM SET_CELL USING P_EXCEL_WORKBOOK LV_ROW 1 GS_EXCEL_DATA-KURST.

    PERFORM SET_CELL USING P_EXCEL_WORKBOOK LV_ROW 2 GS_EXCEL_DATA-FCURR.

    PERFORM SET_CELL USING P_EXCEL_WORKBOOK LV_ROW 3 GS_EXCEL_DATA-TCURR.

    PERFORM SET_CELL USING P_EXCEL_WORKBOOK LV_ROW 4 GS_EXCEL_DATA-GDATU.

    PERFORM SET_CELL USING P_EXCEL_WORKBOOK LV_ROW 5 GS_EXCEL_DATA-UKURS.

    PERFORM SET_CELL USING P_EXCEL_WORKBOOK LV_ROW 6 GS_EXCEL_DATA-FFACT.

    PERFORM SET_CELL USING P_EXCEL_WORKBOOK LV_ROW 7 GS_EXCEL_DATA-TFACT.

    PERFORM SET_CELL USING P_EXCEL_WORKBOOK LV_ROW 8 GS_EXCEL_DATA-ERNAM.

    PERFORM SET_CELL USING P_EXCEL_WORKBOOK LV_ROW 9 GS_EXCEL_DATA-ERDAT.

    CLEAR: GS_EXCEL_DATA.

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