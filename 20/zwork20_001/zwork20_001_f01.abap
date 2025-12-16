
*&---------------------------------------------------------------------*

*&  Include           ZWORK20_001_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_DEFAULT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_DEFAULT .    " SELECTION-SCREEN #### ##

  P_TYPE = 'M'.

  S_DATE-LOW = SY-DATUM.

  APPEND S_DATE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SELECTION_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SELECTION_SCREEN .   " SELECTION-SCREEN ##

  LOOP AT SCREEN.

    IF SCREEN-NAME = 'P_TYPE'.    " P_TYPE# ## #### ##

      SCREEN-INPUT = '0'.

    ENDIF.

    MODIFY SCREEN.

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




FORM CREATE_OBJECT .    " ## ##

CREATE OBJECT GC_DOCKING    " DOCKING CONTAINER ##

  EXPORTING




*    PARENT                      =




    REPID                       = SY-REPID

    DYNNR                       = SY-DYNNR




*    SIDE                        = DOCK_AT_LEFT




    EXTENSION                   = 2000




*    STYLE                       =

*    LIFETIME                    = lifetime_default

*    CAPTION                     =

*    METRIC                      = 0

*    RATIO                       =

*    NO_AUTODEF_PROGID_DYNNR     =

*    NAME                        =

*  EXCEPTIONS

*    CNTL_ERROR                  = 1

*    CNTL_SYSTEM_ERROR           = 2

*    CREATE_ERROR                = 3

*    LIFETIME_ERROR              = 4

*    LIFETIME_DYNPRO_DYNPRO_LINK = 5

*    others                      = 6




    .

IF SY-SUBRC <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




ENDIF.

CREATE OBJECT GC_GRID   " ALV GRID ##

  EXPORTING




*    I_SHELLSTYLE      = 0

*    I_LIFETIME        =




    I_PARENT          = GC_DOCKING




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

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG .    " ## #### ##

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

 GS_FIELDCAT-EDIT = 'X'.    " ## ##### ###

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

 GS_FIELDCAT-FIELDNAME = 'UNAME'.

 GS_FIELDCAT-SCRTEXT_M = '###'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 9.

 GS_FIELDCAT-FIELDNAME = 'CRDATE'.

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




FORM CALL_ALV .

CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY    " ALV ##

  EXPORTING




*    I_BUFFER_ACTIVE               =

*    I_BYPASSING_BUFFER            =

*    I_CONSISTENCY_CHECK           =

*    I_STRUCTURE_NAME              =




    IS_VARIANT                    = GS_VARIANT

    I_SAVE                        = 'A'




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

    IT_OUTTAB                     = GT_EXCHANGE

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

*&      Form  EXCEL_DOWN_METHOD

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM EXCEL_DOWN_METHOD .    " ### ##

  DATA: L_FILENAME   TYPE STRING,   " ###

        L_PATH       TYPE STRING,   " ##

        L_FULLPATH   TYPE STRING,   " ###

        LV_NAME      TYPE RLGRAP-FILENAME,    "

        L_FILELENGTH TYPE I.    " ####

  PERFORM SET_TEMPLATE.   " ### ### ##

  PERFORM FILE_SAVE_DIALOG USING 'TEMPLATE.xls'   " ### ####

                           CHANGING L_FILENAME

                                    L_PATH

                                    L_FULLPATH.

  PERFORM GUI_DOWNLOAD USING L_FULLPATH   " ##### ##

                             L_FILELENGTH

                             GT_TEMPLATE.

  IF SY-SUBRC = 0.

    MESSAGE '####' TYPE 'I'.

  ELSE.

    MESSAGE '####' TYPE 'I'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  PRESS_F4

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM PRESS_F4 .   " ## ## ##

  DATA: LT_FILE TYPE FILETABLE,

        LS_FILE LIKE FILE_INFO,

        LV_RC TYPE I.

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_OPEN_DIALOG    " ### ####

    EXPORTING

      WINDOW_TITLE            = '### #####'




*      DEFAULT_EXTENSION       =

*      DEFAULT_FILENAME        =

*      FILE_FILTER             =

*      WITH_ENCODING           =

*      INITIAL_DIRECTORY       =




      MULTISELECTION          = ABAP_FALSE

    CHANGING

      FILE_TABLE              = LT_FILE

      RC                      = LV_RC




*      USER_ACTION             =

*      FILE_ENCODING           =

*    EXCEPTIONS

*      FILE_OPEN_DIALOG_FAILED = 1

*      CNTL_ERROR              = 2

*      ERROR_NO_GUI            = 3

*      NOT_SUPPORTED_BY_GUI    = 4

*      others                  = 5




          .

  IF SY-SUBRC = 0.

    READ TABLE LT_FILE INTO LS_FILE INDEX 1.    " ### ##### # ## ### ### P_FNAME# ##

    P_FNAME = LS_FILE-FILENAME.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  PRESS_FUNCTION_KEY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM PRESS_FUNCTION_KEY .   " FUNCTION_KEY# ##### ##

 CASE SY-UCOMM.

    WHEN 'FC01'.    " #### #### ### ### #

      PERFORM EXCEL_DOWN_METHOD.

    ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FILE_SAVE_DIALOG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_0261   text

*      <--P_L_FILENAME  text

*      <--P_L_PATH  text

*      <--P_L_FULLPATH  text

*----------------------------------------------------------------------*




FORM FILE_SAVE_DIALOG  USING    P_VALUE   " ### ### ### ##

                       CHANGING P_FILENAME

                                P_PATH

                                P_FULLPATH.

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_SAVE_DIALOG

    EXPORTING




*      WINDOW_TITLE              =




      DEFAULT_EXTENSION         = 'XLS'

      DEFAULT_FILE_NAME         = P_VALUE




*      WITH_ENCODING             =

*      FILE_FILTER               =

*      INITIAL_DIRECTORY         =

*      PROMPT_ON_OVERWRITE       = 'X'




    CHANGING

      FILENAME                  = P_FILENAME

      PATH                      = P_PATH

      FULLPATH                  = P_FULLPATH




*      USER_ACTION               =

*      FILE_ENCODING             =

*    EXCEPTIONS

*      CNTL_ERROR                = 1

*      ERROR_NO_GUI              = 2

*      NOT_SUPPORTED_BY_GUI      = 3

*      INVALID_DEFAULT_FILE_NAME = 4

*      others                    = 5




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GUI_DOWNLOAD

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_L_FULLPATH  text

*      -->P_L_FILELENGTH  text

*      -->P_LT_FORMAT  text

*----------------------------------------------------------------------*




FORM GUI_DOWNLOAD  USING    P_FULLPATH    " ##### ####

                            P_FILELENGTH

                            P_FORMAT.

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>GUI_DOWNLOAD

    EXPORTING




*      BIN_FILESIZE              =




      FILENAME                  = P_FULLPATH

      FILETYPE                  = 'ASC'




*      APPEND                    = SPACE




      WRITE_FIELD_SEPARATOR     = 'X'




*      HEADER                    = '00'

*      TRUNC_TRAILING_BLANKS     = SPACE

*      WRITE_LF                  = 'X'

*      COL_SELECT                = SPACE

*      COL_SELECT_MASK           = SPACE

*      DAT_MODE                  = SPACE

*      CONFIRM_OVERWRITE         = SPACE

*      NO_AUTH_CHECK             = SPACE

*      CODEPAGE                  = SPACE

*      IGNORE_CERR               = ABAP_TRUE

*      REPLACEMENT               = '#'

*      WRITE_BOM                 = SPACE

*      TRUNC_TRAILING_BLANKS_EOL = 'X'

*      WK1_N_FORMAT              = SPACE

*      WK1_N_SIZE                = SPACE

*      WK1_T_FORMAT              = SPACE

*      WK1_T_SIZE                = SPACE

*      SHOW_TRANSFER_STATUS      = 'X'

*      FIELDNAMES                =

*      WRITE_LF_AFTER_LAST_LINE  = 'X'

*      VIRUS_SCAN_PROFILE        = '/SCET/GUI_DOWNLOAD'




    IMPORTING

      FILELENGTH                = P_FILELENGTH

    CHANGING

      DATA_TAB                  = P_FORMAT




*    EXCEPTIONS

*      FILE_WRITE_ERROR          = 1

*      NO_BATCH                  = 2

*      GUI_REFUSE_FILETRANSFER   = 3

*      INVALID_TYPE              = 4

*      NO_AUTHORITY              = 5

*      UNKNOWN_ERROR             = 6

*      HEADER_NOT_ALLOWED        = 7

*      SEPARATOR_NOT_ALLOWED     = 8

*      FILESIZE_NOT_ALLOWED      = 9

*      HEADER_TOO_LONG           = 10

*      DP_ERROR_CREATE           = 11

*      DP_ERROR_SEND             = 12

*      DP_ERROR_WRITE            = 13

*      UNKNOWN_DP_ERROR          = 14

*      ACCESS_DENIED             = 15

*      DP_OUT_OF_MEMORY          = 16

*      DISK_FULL                 = 17

*      DP_TIMEOUT                = 18

*      FILE_NOT_FOUND            = 19

*      DATAPROVIDER_EXCEPTION    = 20

*      CONTROL_FLUSH_ERROR       = 21

*      NOT_SUPPORTED_BY_GUI      = 22

*      ERROR_NO_GUI              = 23

*      others                    = 24




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_TEMPLATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_TEMPLATE .   " #### #### ####

  APPEND GS_TEMPLATE TO GT_TEMPLATE.

  CLEAR GS_TEMPLATE.

  GS_TEMPLATE-KURST = 'M'.

  GS_TEMPLATE-FCURR = 'USD'.

  GS_TEMPLATE-TCURR = 'KRW'.

  GS_TEMPLATE-GDATU = '20250401'.

  GS_TEMPLATE-UKURS = '1470.6'.

  GS_TEMPLATE-FFACT = '1'.

  GS_TEMPLATE-TFACT = '1'.

  APPEND GS_TEMPLATE TO GT_TEMPLATE.



  GS_TEMPLATE-FCURR = 'JPY'.

  GS_TEMPLATE-UKURS = '980.11'.

  GS_TEMPLATE-FFACT = '100'.

  GS_TEMPLATE-TFACT = '1'.

  APPEND GS_TEMPLATE TO GT_TEMPLATE.



  GS_TEMPLATE-FCURR = 'EUR'.

  GS_TEMPLATE-UKURS = '1590.9'.

  GS_TEMPLATE-FFACT = '1'.

  GS_TEMPLATE-TFACT = '1'.

  APPEND GS_TEMPLATE TO GT_TEMPLATE.



  GS_TEMPLATE-FCURR = 'CAD'.

  GS_TEMPLATE-UKURS = '1021.89'.

  GS_TEMPLATE-FFACT = '1'.

  GS_TEMPLATE-TFACT = '1'.

  APPEND GS_TEMPLATE TO GT_TEMPLATE.



  GS_TEMPLATE-FCURR = 'CNY'.

  GS_TEMPLATE-UKURS = '202.68'.

  GS_TEMPLATE-FFACT = '1'.

  GS_TEMPLATE-TFACT = '1'.

  APPEND GS_TEMPLATE TO GT_TEMPLATE.



  GS_TEMPLATE-FCURR = 'VND'.

  GS_TEMPLATE-UKURS = '5.75'.

  GS_TEMPLATE-FFACT = '100'.

  GS_TEMPLATE-TFACT = '1'.

  APPEND GS_TEMPLATE TO GT_TEMPLATE.



  GS_TEMPLATE-FCURR = 'HKD'.

  GS_TEMPLATE-UKURS = '189.03'.

  GS_TEMPLATE-FFACT = '1'.

  GS_TEMPLATE-TFACT = '1'.

  APPEND GS_TEMPLATE TO GT_TEMPLATE.



  GS_TEMPLATE-FCURR = 'AUD'.

  GS_TEMPLATE-UKURS = '918.24'.

  GS_TEMPLATE-FFACT = '1'.

  GS_TEMPLATE-TFACT = '1'.

  APPEND GS_TEMPLATE TO GT_TEMPLATE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_EXCEL_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_EXCEL_DATA .   " ##### #### ###

CALL FUNCTION 'ALSM_EXCEL_TO_INTERNAL_TABLE'

  EXPORTING

    FILENAME                      = P_FNAME

    I_BEGIN_COL                   = 1

    I_BEGIN_ROW                   = 2

    I_END_COL                     = 7

    I_END_ROW                     = 9

  TABLES

    INTERN                        = GT_EXCEL_RAW    " GT_EXCEL_RAW# ### ##

 EXCEPTIONS




*   INCONSISTENT_PARAMETERS       = 1




   UPLOAD_OLE                    = 2




*   OTHERS                        = 3




          .

IF SY-SUBRC <> 0.

  CASE SY-SUBRC.

    WHEN 2.   " ### ## ## ##

      MESSAGE '### #####.' TYPE 'I'.

      EXIT.

  ENDCASE.




* Implement suitable error handling here




ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_EXCEL_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_EXCEL_DATA .    " ##### ## #### ALV# ### #### ##

  GS_EXCHANGE-UNAME = SY-UNAME.    " ###

  GS_EXCHANGE-CRDATE = SY-DATUM.   " ###

  LOOP AT GT_EXCEL_RAW INTO GS_EXCEL_RAW.

    CASE GS_EXCEL_RAW-COL.

      WHEN 1.   " ####

        GS_EXCHANGE-KURST = GS_EXCEL_RAW-VALUE.

      WHEN 2.   " ####

        GS_EXCHANGE-FCURR = GS_EXCEL_RAW-VALUE.

      WHEN 3.   " ####

        GS_EXCHANGE-TCURR = GS_EXCEL_RAW-VALUE.

      WHEN 4.   " ####

        GS_EXCHANGE-GDATU = S_DATE-LOW.

      WHEN 5.   " ##

        GS_EXCHANGE-UKURS = GS_EXCEL_RAW-VALUE.

        MOVE GS_EXCHANGE-UKURS TO GS_EXCHANGE-ZUKURS.   " ### ### #### 0 ##### ###

      WHEN 6.   " ########

        GS_EXCHANGE-FFACT = GS_EXCEL_RAW-VALUE.

      WHEN 7.   " ########

        GS_EXCHANGE-TFACT = GS_EXCEL_RAW-VALUE.

        " # RECORD# ### ## ### #### ### #### # ## ### APPEND

        APPEND GS_EXCHANGE TO GT_EXCHANGE.

    ENDCASE.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_POPUP

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CALL_POPUP .   " ### ##

  CALL FUNCTION 'POPUP_TO_CONFIRM'

      EXPORTING

        TITLEBAR              = '## ##'

        TEXT_QUESTION         = '##### ## ########?'

        TEXT_BUTTON_1         = 'YES'  " '1'# ##

        ICON_BUTTON_1         = 'ICON_OKAY'

        TEXT_BUTTON_2         = 'NO' " '2'# ##

        ICON_BUTTON_2         = 'ICON_CANCEL'

        DISPLAY_CANCEL_BUTTON = SPACE  " '##' ### ##

      IMPORTING

        ANSWER                = GV_ANSWER




*      EXCEPTIONS

*        OTHERS                = 1.




              .

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  UPDATE_EXCHANGE_RATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM UPDATE_EXCHANGE_RATE .   " ###### ## ####




*  LOOP AT GT_EXCHANGE INTO GS_EXCHANGE.

*    CHECK GS_EXCHANGE-GDATU = S_DATE-LOW.   " ##### ### ####### ##

*    MOVE-CORRESPONDING GS_EXCHANGE TO GS_ZTCURR20.    " ### ##

*    MOVE GS_EXCHANGE-ZUKURS TO GS_ZTCURR20-UKURS.   " ### ### ## ##

*    APPEND GS_ZTCURR20 TO GT_ZTCURR20.    " ## ## ### ## GT_ZTCURR20# ##

*  ENDLOOP.




  MOVE-CORRESPONDING GT_EXCHANGE[] TO GT_ZTCURR20[].

  MODIFY ZTCURR20 FROM TABLE GT_ZTCURR20.   " ### #### ## DB ## ## ##

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM REFRESH .    " ALV #### ### ##### ## ## ### REFRESH ##

  DATA: LS_STABLE TYPE LVC_S_STBL.

  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.

  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE = LS_STABLE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLE_DATA_CHANGED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_ER_DATA_CHANGED  text

*      -->P_E_ONF4  text

*      -->P_E_ONF4_BEFORE  text

*      -->P_E_ONF4_AFTER  text

*      -->P_E_UCOMM  text

*----------------------------------------------------------------------*




FORM ALV_HANDLE_DATA_CHANGED  USING    P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL    " ALV## ### ### ###### ## ##

                                       P_ONF4

                                       P_ONF4_BEFORE

                                       P_ONF4_AFTER

                                       P_UCOMM.

  DATA: LS_MODI TYPE LVC_S_MODI.

  LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.

    IF LS_MODI-FIELDNAME = 'ZUKURS'.    " #### ## # ZUKURS# ##

      READ TABLE GT_EXCHANGE INTO GS_EXCHANGE INDEX LS_MODI-ROW_ID.

      GS_EXCHANGE-GDATU = S_DATE-LOW.   " ##### ##### ##

      MODIFY GT_EXCHANGE FROM GS_EXCHANGE INDEX LS_MODI-ROW_ID.   " #### GT_EXCHANGE# ##

      CLEAR: GS_EXCHANGE.

    ENDIF.

  ENDLOOP.

  PERFORM REFRESH.    " ALV## ####

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CLASS_EVENT .    " ### ### ## ##

  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT    " #### ### ## ##### ## ##

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED




*    EXCEPTIONS

*      ERROR      = 1

*      others     = 2




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.



  CREATE OBJECT GO_EVENT.   " ### ## ##

  SET HANDLER GO_EVENT->HANDLE_DATA_CHANGED FOR GC_GRID.    " ### ### ##

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_INPUT .    " ### ##

  IF P_FNAME = ''.

    MESSAGE '#### ######.' TYPE 'E'.

  ENDIF.

  IF S_DATE IS INITIAL.

    MESSAGE '##### ######.' TYPE 'E'.

  ENDIF.

ENDFORM.