
*&---------------------------------------------------------------------*

*&  Include           ZWORK16_001_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  F4_FILE_PATH

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM F4_FILE_PATH .



  " ## ### ##

  CALL FUNCTION 'F4_FILENAME'

    IMPORTING

      FILE_NAME = P_FILE.



  " ## ## ## ##

  IF P_FILE IS INITIAL.

    MESSAGE '### #### #####.' TYPE 'I'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  READ_EXCEL_FILE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_P_FILE  text

*----------------------------------------------------------------------*




FORM READ_EXCEL_FILE  USING    PV_FILE TYPE RLGRAP-FILENAME.



  DATA: LT_EXCEL_RAW TYPE TABLE OF ALSMEX_TABLINE,

        LS_EXCEL_RAW TYPE ALSMEX_TABLINE.



  CLEAR GT_INPUT_EXCEL.



  " ## ## ##

  CALL FUNCTION 'ALSM_EXCEL_TO_INTERNAL_TABLE'

    EXPORTING

      FILENAME                = PV_FILE

      I_BEGIN_COL             = 1

      I_BEGIN_ROW             = 2

      I_END_COL               = 7

      I_END_ROW               = 65536

    TABLES

      INTERN                  = LT_EXCEL_RAW

    EXCEPTIONS

      INCONSISTENT_PARAMETERS = 1

      UPLOAD_OLE              = 2

      OTHERS                  = 3.



  IF SY-SUBRC <> 0.

    MESSAGE '## ## ## ## (ALSM_EXCEL_TO_INTERNAL_TABLE)' TYPE 'E'.

  ENDIF.



  IF LT_EXCEL_RAW IS INITIAL.

    MESSAGE '## ### #### ####.' TYPE 'W'.

    EXIT.

  ENDIF.



  " ## #### ### ## ##

  LOOP AT LT_EXCEL_RAW INTO LS_EXCEL_RAW.

    CASE LS_EXCEL_RAW-COL.

      WHEN 1. GS_INPUT_EXCEL-KURST = LS_EXCEL_RAW-VALUE.

      WHEN 2. GS_INPUT_EXCEL-FCURR = LS_EXCEL_RAW-VALUE.

      WHEN 3. GS_INPUT_EXCEL-TCURR = LS_EXCEL_RAW-VALUE.

      WHEN 4. GS_INPUT_EXCEL-GDATU = LS_EXCEL_RAW-VALUE.

      WHEN 5.

        GS_INPUT_EXCEL-UKURS = LS_EXCEL_RAW-VALUE.

        GS_INPUT_EXCEL-UKURS_DF = LS_EXCEL_RAW-VALUE.

      WHEN 6. GS_INPUT_EXCEL-FFACT = LS_EXCEL_RAW-VALUE.

      WHEN 7. GS_INPUT_EXCEL-TFACT = LS_EXCEL_RAW-VALUE.

    ENDCASE.



    AT END OF ROW.

      APPEND GS_INPUT_EXCEL TO GT_INPUT_EXCEL.

      CLEAR GS_INPUT_EXCEL.

    ENDAT.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_TEMPLATE_DOWNLOAD_BTN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_TEMPLATE_DOWNLOAD_BTN .



  CONCATENATE ICON_IMPORT '##### ####'

          INTO SSCRFIELDS-FUNCTXT_01

          SEPARATED BY SPACE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DOWNLOAD_EXCEL_TEMPLATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DOWNLOAD_EXCEL_TEMPLATE .



  DATA: LT_CSV    TYPE STANDARD TABLE OF STRING,

        LV_HEADER TYPE STRING,

        LV_FNAME  TYPE STRING,

        LV_PATH   TYPE STRING,

        LV_FULL   TYPE STRING,

        LV_ACTION TYPE I,

        LV_LINE   TYPE STRING..



  " 1) ## ##

  LV_HEADER = '####,####,####,####,##,########,########'.

  APPEND LV_HEADER TO LT_CSV.



  " 2) ### ##

  APPEND 'M,USD,KRW,20250401,1470.6,1,1'         TO LT_CSV.

  APPEND 'M,JPY,KRW,20250401,980.11,100,1'       TO LT_CSV.

  APPEND 'M,EUR,KRW,20250401,1590.9,1,1'         TO LT_CSV.

  APPEND 'M,CAD,KRW,20250401,1021.89,1,1'        TO LT_CSV.

  APPEND 'M,CNY,KRW,20250401,202.68,1,1'         TO LT_CSV.

  APPEND 'M,VND,KRW,20250401,5.75,100,1'         TO LT_CSV.

  APPEND 'M,HKD,KRW,20250401,189.03,1,1'         TO LT_CSV.

  APPEND 'M,AUD,KRW,20250401,918.24,1,1'         TO LT_CSV.



  " 3) ## ## #####

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_SAVE_DIALOG

    EXPORTING

      DEFAULT_EXTENSION = 'csv'

      DEFAULT_FILE_NAME = '#####.csv'

    CHANGING

      FILENAME          = LV_FNAME

      PATH              = LV_PATH

      FULLPATH          = LV_FULL

      USER_ACTION       = LV_ACTION

    EXCEPTIONS

      OTHERS            = 1.



  IF SY-SUBRC <> 0 OR LV_ACTION <> CL_GUI_FRONTEND_SERVICES=>ACTION_OK.

    RETURN.

  ENDIF.



  " 4) CSV ####

  CALL FUNCTION 'GUI_DOWNLOAD'

    EXPORTING

      FILENAME = LV_FULL

      FILETYPE = 'ASC'

    TABLES

      DATA_TAB = LT_CSV

    EXCEPTIONS

      OTHERS   = 5.



  IF SY-SUBRC = 0.

    MESSAGE '## #### PC# #######.' TYPE 'S'.

  ELSE.

    MESSAGE '## ### #### # ### ######.' TYPE 'E'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_EXCHANGE_RATE_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_EXCHANGE_RATE_ALV .



  " ### ALV ### APPEND



  CLEAR GS_INPUT_EXCEL.

  CLEAR GS_EXCHANGE_RATE_ALV.



  LOOP AT GT_INPUT_EXCEL INTO GS_INPUT_EXCEL.

    CLEAR GS_EXCHANGE_RATE_ALV.



    GS_EXCHANGE_RATE_ALV-KURST = P_KURST.

    GS_EXCHANGE_RATE_ALV-FCURR = GS_INPUT_EXCEL-FCURR.

    GS_EXCHANGE_RATE_ALV-TCURR = GS_INPUT_EXCEL-TCURR.

    GS_EXCHANGE_RATE_ALV-GDATU = 99999999 - P_DATE.

    GS_EXCHANGE_RATE_ALV-UKURS = GS_INPUT_EXCEL-UKURS.

    GS_EXCHANGE_RATE_ALV-UKURS_DF = GS_INPUT_EXCEL-UKURS_DF.

    IF GS_EXCHANGE_RATE_ALV-FCURR = 'JPY' OR GS_EXCHANGE_RATE_ALV-FCURR = 'VND'.

      GS_EXCHANGE_RATE_ALV-FFACT = 100.

      GS_EXCHANGE_RATE_ALV-TFACT = 1.

    ELSE.

      GS_EXCHANGE_RATE_ALV-FFACT = GS_INPUT_EXCEL-FFACT.

      GS_EXCHANGE_RATE_ALV-TFACT = GS_INPUT_EXCEL-TFACT.

    ENDIF.

    GS_EXCHANGE_RATE_ALV-SYUNAME = SY-UNAME.

    GS_EXCHANGE_RATE_ALV-SYDATUM = SY-DATUM.



    APPEND GS_EXCHANGE_RATE_ALV TO GT_EXCHANGE_RATE_ALV.



    CLEAR GS_INPUT_EXCEL.

    CLEAR GS_EXCHANGE_RATE_ALV.



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



  "DOCKING CONTAINER, GC_GRID ## ##



  CREATE OBJECT GC_DOCKING

    EXPORTING

      REPID     = SY-REPID

      DYNNR     = SY-DYNNR

      EXTENSION = 2000.



  CREATE OBJECT GC_GRID

    EXPORTING

      I_PARENT = GC_DOCKING.



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



  "## #### ##



  CLEAR GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 1.

  GS_FIELDCAT-FIELDNAME = 'KURST'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 2.

  GS_FIELDCAT-FIELDNAME = 'FCURR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 3.

  GS_FIELDCAT-FIELDNAME = 'TCURR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 4.

  GS_FIELDCAT-FIELDNAME = 'GDATU'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 5.

  GS_FIELDCAT-FIELDNAME = 'UKURS_DF'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-EDIT      = 'X'.

  GS_FIELDCAT-OUTPUTLEN = '15'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 6.

  GS_FIELDCAT-FIELDNAME = 'FFACT'.

  GS_FIELDCAT-SCRTEXT_M = '########'.

  GS_FIELDCAT-OUTPUTLEN = '15'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 7.

  GS_FIELDCAT-FIELDNAME = 'TFACT'.

  GS_FIELDCAT-SCRTEXT_M = '########'.

  GS_FIELDCAT-OUTPUTLEN = '15'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 8.

  GS_FIELDCAT-FIELDNAME = 'SYUNAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 9.

  GS_FIELDCAT-FIELDNAME = 'SYDATUM'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



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



  "LAYOUT ##



  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.



  CLEAR GS_VARIANT.

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



  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT      = GS_VARIANT

      I_SAVE          = 'A'

      IS_LAYOUT       = GS_LAYOUT

    CHANGING

      IT_OUTTAB       = GT_EXCHANGE_RATE_ALV

      IT_FIELDCATALOG = GT_FIELDCAT




*     IT_SORT         = GT_SORT




    .



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CLASS_EVENT .



  " EVENT ##



  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED




*  EXCEPTIONS

*     ERROR      = 1

*     OTHERS     = 2




    .

  IF SY-SUBRC <> 0.




* Implement suitable error handling here




  ENDIF.



  CREATE OBJECT GO_EVENT.



  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID.






*  CALL METHOD GC_GRID->SET_READY_FOR_INPUT

*    EXPORTING

*      I_READY_FOR_INPUT = 1.






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



  " REFRESH ## ## ###



  DATA : LS_STABLE TYPE LVC_S_STBL.



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




FORM ALV_HANDLER_DATA_CHANGED  USING    P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL.



  DATA : LS_MODI TYPE LVC_S_MODI.



  LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.

    IF LS_MODI-FIELDNAME = 'UKURS_DF'.

      READ TABLE GT_EXCHANGE_RATE_ALV INTO GS_EXCHANGE_RATE_ALV INDEX LS_MODI-ROW_ID.



      GS_EXCHANGE_RATE_ALV-UKURS = LS_MODI-VALUE.

      GS_EXCHANGE_RATE_ALV-SYUNAME = SY-UNAME.

      GS_EXCHANGE_RATE_ALV-SYDATUM = SY-DATUM.



      MODIFY GT_EXCHANGE_RATE_ALV FROM GS_EXCHANGE_RATE_ALV INDEX LS_MODI-ROW_ID.

      CLEAR GS_EXCHANGE_RATE_ALV.

    ENDIF.

  ENDLOOP.



  PERFORM REFRESH.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_EXCHANGE_RATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SAVE_EXCHANGE_RATE .



  " #### # ### ##



  DATA : LV_ANSWER TYPE C.



  IF GT_EXCHANGE_RATE_ALV IS INITIAL.

    MESSAGE '### ##' TYPE 'I'.

    EXIT.

  ENDIF.



  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      TITLEBAR              = '## ##'

      TEXT_QUESTION         = '##### ## ########?'

      TEXT_BUTTON_1         = '#'

      TEXT_BUTTON_2         = '###'

      DEFAULT_BUTTON        = '1'

      DISPLAY_CANCEL_BUTTON = ' '

    IMPORTING

      ANSWER                = LV_ANSWER.



  CASE LV_ANSWER.

    WHEN '1'.

      PERFORM MODIFY_EXCHANGE_RATE.

      MESSAGE '#######.' TYPE 'I'.

    WHEN '2'.

      MESSAGE '#######.' TYPE 'I'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_EXCHANGE_RATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_EXCHANGE_RATE .



  " ### ### ZTCURR16# MODIFY



  CLEAR GT_EXCHANGE_RATE.

  CLEAR GS_EXCHANGE_RATE.



  LOOP AT GT_EXCHANGE_RATE_ALV INTO GS_EXCHANGE_RATE_ALV.

    MOVE-CORRESPONDING GS_EXCHANGE_RATE_ALV TO GS_EXCHANGE_RATE.

    GS_EXCHANGE_RATE-GDATU = 99999999 - GS_EXCHANGE_RATE_ALV-GDATU.

    GS_EXCHANGE_RATE-ERNAM = GS_EXCHANGE_RATE_ALV-SYUNAME.

    GS_EXCHANGE_RATE-ERDAT = GS_EXCHANGE_RATE_ALV-SYDATUM.

    APPEND GS_EXCHANGE_RATE TO GT_EXCHANGE_RATE.

  ENDLOOP.



  MODIFY ZTCURR16 FROM TABLE GT_EXCHANGE_RATE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  INIT_SELECTION

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM INIT_SELECTION .

  IF P_DATE IS INITIAL.

    MESSAGE '##### #####' TYPE 'I'.

    LEAVE SCREEN.

  ENDIF.



  " #### ## ##

  IF P_FILE IS INITIAL.

    MESSAGE '##### #####' TYPE 'I'.

    LEAVE SCREEN.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIX_KURST

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIX_KURST .

  LOOP AT SCREEN.

    IF SCREEN-NAME = 'P_KURST'.

      SCREEN-INPUT = '0'.

      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.

ENDFORM.