
*&---------------------------------------------------------------------*

*&  Include           ZWORK08_001_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_DEFAULTS

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_DEFAULTS . " ## ### ### ## # ## ## ### ##



  " ### ## ### ##

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'FIX'.

      SCREEN-INPUT = '0'. " ## ##### ##

      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.



"  DATA LV_FIRST TYPE D.

"  DATA LV_LAST TYPE D.

"  LV_FIRST = SY-DATUM.

"  LV_FIRST+6(2) = '01'.



  " ### ##

"  S_ZGDATU-SIGN = 'I'.

"  S_ZGDATU-OPTION = 'BT'.

"  S_ZGDATU-LOW = LV_FIRST.

"  S_ZGDATU-SIGN = 'I'.

"  S_ZGDATU-OPTION = 'BT'.

"  S_ZGDATU-LOW = LV_FIRST.



  " ## #### ## ## ### ### ##

"  CALL FUNCTION 'LAST_DAY_OF_MONTHS'

"    EXPORTING DAY_IN = LV_FIRST

"    IMPORTING LAST_DAY_OF_MONTH = LV_LAST.



  " #### ###

"  S_ZGDATU-HIGH = LV_LAST.

  " #### ###

"  S_ZGDATU-HIGH = LV_LAST.



  " ### ## ### ##

"  APPEND S_ZGDATU.

"  APPEND S_ZGDATU.



"  S_ZGDATU-LOW    = SY-DATUM.

"  S_ZGDATU-OPTION = 'EQ'.

"  S_ZGDATU-SIGN   = 'I'.

"  APPEND S_ZGDATU.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  START_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM START_SCREEN . " ## #### ### ##### ##



  " ## #### ##

  IF P_FILE IS INITIAL OR P_ZGDATU IS INITIAL.

    MESSAGE '##### #### ## #####.' TYPE 'E'.

  ENDIF.



  PERFORM UPLOAD_EXCEL. " ## ## ###

  PERFORM GET_DATA. " ######## ## ### ##

  PERFORM MODIFY_DATA. " #### ### ##



  " ### #### ### ##

  IF GT_ZTCURR08_ALV IS INITIAL.

    MESSAGE '### #### ####.' TYPE 'I'.

  ELSE. " #### ### ALV ### ##

    PERFORM DISPLAY_ALV.

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

                                   P_E_INTERACTIVE. " ALV ## #### ##



  DATA: LS_TOOLBAR TYPE STB_BUTTON.



  " ### ## ## ##

  CLEAR LS_TOOLBAR.

  LS_TOOLBAR-FUNCTION = 'ZDBS'.

  " LS_TOOLBAR-ICON = ICON_SAVE.

  LS_TOOLBAR-QUICKINFO = 'DB# ##'.

  LS_TOOLBAR-TEXT = '##'.

  APPEND LS_TOOLBAR TO P_E_OBJECT->MT_TOOLBAR.



  " ### ## ## ##

  CLEAR LS_TOOLBAR.

  LS_TOOLBAR-FUNCTION = 'EXCELTMPL'.

  LS_TOOLBAR-QUICKINFO = '## ### ####'.

  LS_TOOLBAR-TEXT = '###'.

  APPEND LS_TOOLBAR TO P_E_OBJECT->MT_TOOLBAR.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_USER_COMMAND

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_UCOMM  text

*----------------------------------------------------------------------*




FORM ALV_HANDLER_USER_COMMAND  USING    P_E_UCOMM. " ALV ### ### ## ## #### ##



  " ### ## ## ### ## ##

  CASE P_E_UCOMM.

    WHEN 'ZDBS'. " ## ## ## #

      PERFORM SAVE_DATA_TO_DB.

    WHEN 'EXCELTMPL'. " ### ## ## #

      PERFORM DOWNLOAD_TEMPLATE.

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

                                        P_E_UCOMM. " ALV ## #### ##### # #### ### ##



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA . " ## ## ### DB## ##

  REFRESH GT_ZTCURR08.



  SELECT A~KURST

         A~FCURR

         A~TCURR

         A~GDATU

         A~UKURS

         A~FFACT

         A~TFACT

    FROM ZTCURR08 AS A

    INTO TABLE GT_ZTCURR08

    WHERE GDATU = P_ZGDATU

      AND KURST = P_KURST.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DATA . " ALV #### ## # ##

  REFRESH GT_ZTCURR08_ALV.



  " #### ## #### # ## ###.

  LOOP AT GT_EXCEL_DATA INTO GS_ZTCURR08_ALV.



    GS_ZTCURR08_ALV-ZGDATU = P_ZGDATU.

    " ### ##

    GS_ZTCURR08_ALV-ZENAME = SY-UNAME.

    " ### ##

    GS_ZTCURR08_ALV-ZAEDAT = SY-DATUM.



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




FORM DISPLAY_ALV . " ALV GRID# ### #### ##

  CALL SCREEN 100.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  F4_FOR_FILE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM F4_FOR_FILE . " F4 HELP ##

  CALL FUNCTION 'KD_GET_FILENAME_ON_F4' " ## ## ##### #### ## ##

    CHANGING

      FILE_NAME = P_FILE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  UPLOAD_EXCEL

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM UPLOAD_EXCEL . " #### ### ## ### ## #### ###

  REFRESH: GT_EXCEL_DATA, GT_RAW_DATA.



  " ## ### ## #### #### ## ##

  CALL FUNCTION 'TEXT_CONVERT_XLS_TO_SAP'

    EXPORTING

      I_FILENAME = P_FILE " ## ##

      I_FIELD_SEPERATOR = 'X' " ### ### ##

      "I_LINE_HEADER = 'X'

      I_TAB_RAW_DATA = GT_RAW_DATA

    TABLES

      I_TAB_CONVERTED_DATA = GT_EXCEL_DATA " ### #### ## ###

    EXCEPTIONS

      CONVERSION_FAILED = 1

      OTHERS = 2.



  " ### ## # ## ### ##

  IF SY-SUBRC <> 0.

    MESSAGE '## ### ### ######.' TYPE 'E'.

    EXIT.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_DATA_TO_DB

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SAVE_DATA_TO_DB . " ALV GRID #### DB #### ##

  DATA: LT_SAVE TYPE TABLE OF ZTCURR08, " ## ## ## ###

        LS_SAVE TYPE ZTCURR08,

        LV_ANSWER TYPE C,

        LV_CNT TYPE I.



  " ALV GRID# ### ### ### ##

  IF GC_GRID IS BOUND.

    CALL METHOD GC_GRID->CHECK_CHANGED_DATA.

  ENDIF.



  REFRESH LT_SAVE.



  " ALV #### #### DB ### ### ##

  LOOP AT GT_ZTCURR08_ALV INTO GS_ZTCURR08_ALV.

    CLEAR LS_SAVE.



    LS_SAVE-KURST = GS_ZTCURR08_ALV-ZKURST.

    LS_SAVE-FCURR = GS_ZTCURR08_ALV-ZFCURR.

    LS_SAVE-TCURR = GS_ZTCURR08_ALV-ZTCURR.

    LS_SAVE-GDATU = GS_ZTCURR08_ALV-ZGDATU.

    LS_SAVE-UKURS = GS_ZTCURR08_ALV-ZUKURS.

    LS_SAVE-FFACT = GS_ZTCURR08_ALV-ZFFACT.

    LS_SAVE-TFACT = GS_ZTCURR08_ALV-ZTFACT.

    LS_SAVE-AENAM = GS_ZTCURR08_ALV-ZENAME.

    LS_SAVE-AEDAT = GS_ZTCURR08_ALV-ZAEDAT.



    APPEND LS_SAVE TO LT_SAVE.

  ENDLOOP.



  " ### #### ## ##

  IF LT_SAVE IS INITIAL.

    MESSAGE '### #### ####.' TYPE 'I'.

    EXIT.

  ENDIF.



  " #### ## # ##

  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      TEXT_QUESTION = 'ALV #### ## ### ########?'

      TEXT_BUTTON_1 = '#'

      TEXT_BUTTON_2 = '###'

      DEFAULT_BUTTON = '1'

    IMPORTING

      ANSWER        = LV_ANSWER.



  IF LV_ANSWER <> '1'.

    MESSAGE '### #######.' TYPE 'I'.

    EXIT.

  ENDIF.



  " ### ## ### ##

  " DELETE FROM ZTCURR08 WHERE GDATU = P_ZGDATU AND KURST = P_KURST.



  " LT_SAVE #### ##

  MODIFY ZTCURR08 FROM TABLE LT_SAVE.

  LV_CNT = SY-DBCNT.



  " ## ## ## ##

  IF SY-SUBRC = 0 AND LV_CNT > 0.

    COMMIT WORK.

    MESSAGE '#### ##### #######.' TYPE 'S'.

  ELSE.

    ROLLBACK WORK.

    MESSAGE '### ### ######.' TYPE 'E'.

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




FORM DOWNLOAD_TEMPLATE . " ## #### ####



  DATA: LV_FILENAME TYPE STRING,

      LV_PATH     TYPE STRING,

      LV_FULLPATH TYPE STRING.



  " ## ## ### ## ##### ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_SAVE_DIALOG

    EXPORTING

      WINDOW_TITLE      = '## ##'

      DEFAULT_EXTENSION = 'csv'

      DEFAULT_FILE_NAME = '#####.csv'

    CHANGING

      FILENAME          = LV_FILENAME

      PATH              = LV_PATH

      FULLPATH          = LV_FULLPATH

    EXCEPTIONS

      OTHERS            = 1.



  " #### ### ### ##

  IF LV_FULLPATH IS INITIAL.

    MESSAGE '##### #######.' TYPE 'I'.

    RETURN.

  ENDIF.



  " ## ALV# ### #### ### ### CSV### ####

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>GUI_DOWNLOAD

    EXPORTING

      FILENAME                = LV_FULLPATH

      FILETYPE                = 'ASC'

      WRITE_FIELD_SEPARATOR   = 'X'

    CHANGING

      DATA_TAB                = GT_ZTCURR08_ALV

    EXCEPTIONS

      OTHERS                  = 1.



  IF SY-SUBRC = 0.

    MESSAGE '## ### #########.' TYPE 'S'.

  ELSE.

    MESSAGE '#### # ## ##' TYPE 'E'.

  ENDIF.








*  DATA: LT_DATA TYPE STANDARD TABLE OF STRING,

*        LV_LINE TYPE STRING,

*        LV_FILE TYPE STRING.

*

*  IF P_FILE IS NOT INITIAL.

*    LV_FILE = 'C:\TEMP\#####.xlsx'.

*  ELSE.

*    EXIT.

*  ENDIF.

*

*  LV_LINE = '####\t####\t####\t####\t##\t########\t########'.

*  APPEND LV_LINE TO LT_DATA.

*

*  LV_LINE = 'M\tUSD\tKRW\t20250401\t1470.6\t1\t1'.      APPEND LV_LINE TO LT_DATA.

*  LV_LINE = 'M\tJPY\tKRW\t20250401\t980.11\t100\t1'.    APPEND LV_LINE TO LT_DATA.

*  LV_LINE = 'M\tEUR\tKRW\t20250401\t1590.9\t1\t1'.      APPEND LV_LINE TO LT_DATA.

*  LV_LINE = 'M\tCAD\tKRW\t20250401\t1021.89\t1\t1'.     APPEND LV_LINE TO LT_DATA.

*  LV_LINE = 'M\tCNY\tKRW\t20250401\t202.68\t1\t1'.      APPEND LV_LINE TO LT_DATA.

*

*  CALL METHOD CL_GUI_FRONTEND_SERVICES=>GUI_DOWNLOAD

*    EXPORTING

*      FILENAME = LV_FILE

*      FILETYPE = 'ASC'

*    CHANGING

*      DATA_TAB = LT_DATA

*    EXCEPTIONS

*      OTHERS   = 1.

*

*  IF SY-SUBRC = 0.

*    MESSAGE |#### { LV_FILE } # #######.| TYPE 'S'.

*  ELSE.

*    MESSAGE '### #### # ### ######.' TYPE 'E'.

*  ENDIF.






ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT . " ### 100 ## -> ALV GRID# #### ## ## # #### ##



  " ALV# ## #### ##

  CREATE OBJECT GC_DOCKING

    EXPORTING




*      PARENT                      =




      REPID                       = SY-REPID " ## #### ID

      DYNNR                       = SY-DYNNR " ## ### ##




*      SIDE                        = DOCK_AT_LEFT




      EXTENSION                   = 2000 " #### ##




*      STYLE                       =

*      LIFETIME                    = lifetime_default

*      CAPTION                     =

*      METRIC                      = 0

*      RATIO                       =

*      NO_AUTODEF_PROGID_DYNNR     =

*      NAME                        =

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



  " ALV GRID ### #### ##### ##

  CREATE OBJECT GC_GRID

    EXPORTING




*      I_SHELLSTYLE      = 0

*      I_LIFETIME        =




      I_PARENT          = GC_DOCKING " ## #### ##




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



  " ### ### ### ##

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




FORM FIELD_CATALOG_0100 . " ### 100# ALV# ### ## ### ####.



  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-FIELDNAME = 'ZKURST'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-FIELDNAME = 'ZFCURR'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-FIELDNAME = 'ZTCURR'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-FIELDNAME = 'ZGDATU'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-FIELDNAME = 'ZUKURS'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 12.

  GS_FIELDCAT-DECIMALS = 5.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-COLTEXT = '########'.

  GS_FIELDCAT-FIELDNAME = 'ZFFACT'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-COLTEXT = '########'.

  GS_FIELDCAT-FIELDNAME = 'ZTFACT'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-COLTEXT = '###'.

  GS_FIELDCAT-FIELDNAME = 'ZENAME'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



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




FORM ALV_SORT . " ALV# ## ## ### ##



  CLEAR: GS_SORT, GT_SORT.

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZKURST'.

  GS_SORT-UP = 'X'.

  APPEND GS_SORT TO GT_SORT.



  CLEAR: GS_SORT.

  GS_SORT-SPOS = 2.

  GS_SORT-FIELDNAME = 'ZFCURR'.

  GS_SORT-UP = 'X'.

  APPEND GS_SORT TO GT_SORT.



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




FORM LAYOUT_SET . " ALV #### #### # VARIANTS ### ##



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

*      -->P_GT_0100[]  text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY USING PT_TABLE TYPE STANDARD TABLE. " ALV ### ### #### ### #### ### ##



  " ALV ## ## ### ##

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*      I_BUFFER_ACTIVE               =

*      I_BYPASSING_BUFFER            =

*      I_CONSISTENCY_CHECK           =

*      I_STRUCTURE_NAME              =

*




      IS_VARIANT                    = GS_VARIANT " VARIANT ##

      I_SAVE                        = 'A' " VARIANT ## ##




*      I_DEFAULT                     = 'X'




      IS_LAYOUT                     = GS_LAYOUT " #### ##




*      IS_PRINT                      =

*      IT_SPECIAL_GROUPS             =

*      IT_TOOLBAR_EXCLUDING          =

*      IT_HYPERLINK                  =

*      IT_ALV_GRAPHICS               =

*      IT_EXCEPT_QINFO               =

*      IR_SALV_ADAPTER               =




    CHANGING

      IT_OUTTAB                     = PT_TABLE " ## ### ###

      IT_FIELDCATALOG               = GT_FIELDCAT " ## ####

      IT_SORT                       = GT_SORT " ## ##




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