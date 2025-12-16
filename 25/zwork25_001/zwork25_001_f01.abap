
*&---------------------------------------------------------------------*

*&  Include           ZWORK25_001_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_INIT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_INIT .

  SSCRFIELDS-FUNCTXT_01 = '### ####'.  " FUNCTION KEY 1 ###

  P_KURST = 'M'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_SCREEN_OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_SCREEN_OUTPUT .

  LOOP AT SCREEN.

    IF SCREEN-NAME = 'P_KURST'.

      SCREEN-INPUT = '0'.    " ## ##

      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONVERT_DATE_TO_GDATU

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CONVERT_DATE_TO_GDATU .

  DATA: LV_DATE_CHAR TYPE CHAR8.



  LV_DATE_CHAR = P_DATE.         " DATS ####(YYYYMMDD)

  GV_GDATU     = 99999999 - LV_DATE_CHAR.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  UPLOAD_EXCEL

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM UPLOAD_EXCEL .

  REFRESH GT_EXCEL.

  REFRESH GT_DATA.

  CLEAR   GS_DATA.



  CALL FUNCTION 'ALSM_EXCEL_TO_INTERNAL_TABLE'

    EXPORTING

      FILENAME                = P_FILE

      I_BEGIN_COL             = 1

      I_BEGIN_ROW             = 2    " ## ##

      I_END_COL               = 7

      I_END_ROW               = 1000

    TABLES

      INTERN                  = GT_EXCEL

    EXCEPTIONS

      INCONSISTENT_PARAMETERS = 1

      UPLOAD_OLE              = 2

      OTHERS                  = 3.



  IF SY-SUBRC <> 0.

    MESSAGE 'EXCEL UPLOAD FAILED' TYPE 'E'.

  ENDIF.



  LOOP AT GT_EXCEL INTO GS_EXCEL.

    CASE GS_EXCEL-COL.

      WHEN 1. GS_DATA-KURST = GS_EXCEL-VALUE.  " ### 'M'## ###

      WHEN 2. GS_DATA-FCURR = GS_EXCEL-VALUE.

      WHEN 3. GS_DATA-TCURR = GS_EXCEL-VALUE.

      WHEN 4. " ## ## ### ##, ## ## ## ##

      WHEN 5. GS_DATA-UKURS = GS_EXCEL-VALUE.

      WHEN 6. GS_DATA-FFACT = GS_EXCEL-VALUE.

      WHEN 7. GS_DATA-TFACT = GS_EXCEL-VALUE.

    ENDCASE.



    AT END OF ROW.

      GS_DATA-MANDT = SY-MANDT.

      GS_DATA-KURST = 'M'.          " #### ## 'M'

      GS_DATA-GDATU = GV_GDATU.     " ####(###)

      GS_DATA-GDATU_DISP = P_DATE.  " ####

      GS_DATA-UNAME = SY-UNAME.     " ###

      GS_DATA-DATUM = SY-DATUM.     " ###



      " JPY, VND  100:1 ## ##

      IF GS_DATA-FCURR = 'JPY' OR GS_DATA-FCURR = 'VND'.

        GS_DATA-FFACT = 100.

        GS_DATA-TFACT = 1.

      ENDIF.



      APPEND GS_DATA TO GT_DATA.

      CLEAR GS_DATA.

    ENDAT.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  BUILD_FIELDCAT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM BUILD_FIELDCAT .

  DATA: LS_FIELDCAT TYPE LVC_S_FCAT.



  CLEAR GT_FIELDCAT.



  CLEAR LS_FIELDCAT.

  LS_FIELDCAT-COL_POS   = 1.

  LS_FIELDCAT-FIELDNAME = 'KURST'.

  LS_FIELDCAT-SCRTEXT_M = '####'.

  LS_FIELDCAT-EDIT      = ''.

  APPEND LS_FIELDCAT TO GT_FIELDCAT.



  CLEAR LS_FIELDCAT.

  LS_FIELDCAT-COL_POS   = 2.

  LS_FIELDCAT-FIELDNAME = 'FCURR'.

  LS_FIELDCAT-SCRTEXT_M = '####'.

  LS_FIELDCAT-EDIT      = ''.

  APPEND LS_FIELDCAT TO GT_FIELDCAT.



  CLEAR LS_FIELDCAT.

  LS_FIELDCAT-COL_POS   = 3.

  LS_FIELDCAT-FIELDNAME = 'TCURR'.

  LS_FIELDCAT-SCRTEXT_M = '####'.

  LS_FIELDCAT-EDIT      = ''.

  APPEND LS_FIELDCAT TO GT_FIELDCAT.





  CLEAR LS_FIELDCAT.

  LS_FIELDCAT-COL_POS   = 4.

  LS_FIELDCAT-FIELDNAME = 'GDATU_DISP'.

  LS_FIELDCAT-SCRTEXT_M = '## ## ###'.

  LS_FIELDCAT-EDIT      = ''.

  APPEND LS_FIELDCAT TO GT_FIELDCAT.



  CLEAR LS_FIELDCAT.

  LS_FIELDCAT-COL_POS   = 5.

  LS_FIELDCAT-FIELDNAME = 'UKURS'.

  LS_FIELDCAT-SCRTEXT_M = '##'.

  LS_FIELDCAT-EDIT      = 'X'.

  LS_FIELDCAT-DECIMALS  = 5.

  APPEND LS_FIELDCAT TO GT_FIELDCAT.



  CLEAR LS_FIELDCAT.

  LS_FIELDCAT-COL_POS   = 6.

  LS_FIELDCAT-FIELDNAME = 'FFACT'.

  LS_FIELDCAT-SCRTEXT_M = '######'.

  LS_FIELDCAT-EDIT      = ''.

  APPEND LS_FIELDCAT TO GT_FIELDCAT.



  CLEAR LS_FIELDCAT.

  LS_FIELDCAT-COL_POS   = 7.

  LS_FIELDCAT-FIELDNAME = 'TFACT'.

  LS_FIELDCAT-SCRTEXT_M = '######'.

  LS_FIELDCAT-EDIT      = ''.

  APPEND LS_FIELDCAT TO GT_FIELDCAT.



  CLEAR LS_FIELDCAT.

  LS_FIELDCAT-COL_POS   = 8.

  LS_FIELDCAT-FIELDNAME = 'UNAME'.

  LS_FIELDCAT-SCRTEXT_M = '###'.

  LS_FIELDCAT-EDIT      = ''.

  APPEND LS_FIELDCAT TO GT_FIELDCAT.



  CLEAR LS_FIELDCAT.

  LS_FIELDCAT-COL_POS   = 9.

  LS_FIELDCAT-FIELDNAME = 'DATUM'.

  LS_FIELDCAT-SCRTEXT_M = '###'.

  LS_FIELDCAT-EDIT      = ''.

  APPEND LS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  DISPLAY_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DISPLAY_ALV .

   IF GO_DOCKING IS INITIAL.



    " ## #### ##

    CREATE OBJECT GO_DOCKING

      EXPORTING

        REPID                       = SY-REPID

        DYNNR                       = '0100'

        SIDE                        = CL_GUI_DOCKING_CONTAINER=>DOCK_AT_TOP

        EXTENSION                   = 400

      EXCEPTIONS

        CNTL_ERROR                  = 1

        CNTL_SYSTEM_ERROR           = 2

        CREATE_ERROR                = 3

        LIFETIME_ERROR              = 4

        LIFETIME_DYNPRO_DYNPRO_LINK = 5

        OTHERS                      = 6.



    IF SY-SUBRC <> 0.

      MESSAGE '## #### ## ##' TYPE 'E'.

    ENDIF.



    " ALV GRID ##

    CREATE OBJECT GO_ALV

      EXPORTING

        I_PARENT          = GO_DOCKING

      EXCEPTIONS

        ERROR_CNTL_CREATE = 1

        ERROR_CNTL_INIT   = 2

        ERROR_CNTL_LINK   = 3

        ERROR_DP_CREATE   = 4

        OTHERS            = 5.



    IF SY-SUBRC <> 0.

      MESSAGE 'ALV GRID ## ##' TYPE 'E'.

    ENDIF.



    " ### #### ## ##

    CREATE OBJECT GO_EVENT_HANDLER.

    SET HANDLER GO_EVENT_HANDLER->HANDLE_TOOLBAR      FOR GO_ALV.

    SET HANDLER GO_EVENT_HANDLER->HANDLE_USER_COMMAND FOR GO_ALV.

    SET HANDLER GO_EVENT_HANDLER->HANDLE_DATA_CHANGED FOR GO_ALV.



    CLEAR GS_LAYOUT.

    GS_LAYOUT-GRID_TITLE = '## ###'.




*   GS_LAYOUT-EDIT       = 'X'.






    " # ##

    CALL METHOD GO_ALV->SET_TABLE_FOR_FIRST_DISPLAY

      EXPORTING

        IS_LAYOUT       = GS_LAYOUT

      CHANGING

        IT_OUTTAB       = GT_DATA

        IT_FIELDCATALOG = GT_FIELDCAT.



    CALL METHOD GO_ALV->REGISTER_EDIT_EVENT

      EXPORTING

        I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.



  ELSE.



    CALL METHOD GO_ALV->REFRESH_TABLE_DISPLAY.



  ENDIF.





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  F4_FILE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM F4_FILE .

  CALL FUNCTION 'F4_FILENAME'

    IMPORTING

      FILE_NAME = P_FILE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  HANDLE_FUNCTION_KEY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM HANDLE_FUNCTION_KEY .

   CASE SSCRFIELDS-UCOMM.

    WHEN GC_UCOMM_FKEY1.       " FUNCTION KEY 1

      PERFORM DOWNLOAD_TEMPLATE.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_SELECTION

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_SELECTION .

  " ### ## ##

  IF SSCRFIELDS-UCOMM = 'ONLI'.



    "#### ## ##

    IF P_DATE IS INITIAL.

      MESSAGE '##### ######' TYPE 'I'.

      LEAVE SCREEN.

    ENDIF.



    " #### ## ##

    IF P_FILE IS INITIAL.

      MESSAGE '##### ######' TYPE 'I'.

      LEAVE SCREEN.

    ENDIF.



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




FORM DOWNLOAD_TEMPLATE .

   DATA: LS_KEY   TYPE WWWDATATAB,

        LV_FILE  TYPE STRING,

        LV_PATH  TYPE STRING,

        LV_FULL  TYPE STRING,

        LV_DEST  TYPE LOCALFILE.



  " ### # ##

  SELECT SINGLE *

    FROM WWWDATA

    INTO CORRESPONDING FIELDS OF LS_KEY

    WHERE OBJID = GC_TMPL_OBJID.



  IF SY-SUBRC <> 0.

    MESSAGE '## #### #### ####.' TYPE 'E'.

    RETURN.

  ENDIF.



  " ## ##, ### ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_SAVE_DIALOG

    EXPORTING

      WINDOW_TITLE      = '## ### ####'

      DEFAULT_EXTENSION = 'XLSX'

      DEFAULT_FILE_NAME = 'template.xlsx'

    CHANGING

      FILENAME          = LV_FILE

      PATH              = LV_PATH

      FULLPATH          = LV_FULL.



  IF LV_FULL IS INITIAL.

    RETURN.                      " #### ##

  ENDIF.



  LV_DEST = LV_FULL.



  "### ### #### PC# ####

  CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'

    EXPORTING

      KEY         = LS_KEY

      DESTINATION = LV_DEST.



  IF SY-SUBRC = 0.

    MESSAGE '## #### #########.' TYPE 'S'.

  ELSE.

    MESSAGE '### #### # ### ######.' TYPE 'E'.

  ENDIF.





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SAVE_DATA .

  DATA: LS_ZTCURR25 TYPE ZTCURR25,

        LV_ANSWER   TYPE C,

        LV_COUNT    TYPE I.



  IF GT_DATA[] IS INITIAL.

    MESSAGE '### #### ####.' TYPE 'I'.

    RETURN.

  ENDIF.



  " 1. ## ## ##

  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      TITLEBAR              = '## ##'

      TEXT_QUESTION         = '##### ########?'

      TEXT_BUTTON_1         = '#'

      TEXT_BUTTON_2         = '###'

      DEFAULT_BUTTON        = '1'

      DISPLAY_CANCEL_BUTTON = ''

    IMPORTING

      ANSWER                = LV_ANSWER.



  IF LV_ANSWER <> '1'.

    MESSAGE '#######.' TYPE 'S'.

    RETURN.

  ENDIF.



  " 2. DB ## ##

  CLEAR LV_COUNT.



  LOOP AT GT_DATA INTO GS_DATA.

    CLEAR LS_ZTCURR25.



    MOVE-CORRESPONDING GS_DATA TO LS_ZTCURR25.



    " ######(UNAME/DATUM) -> DB###(ERNAM/ERDAT)

    LS_ZTCURR25-ERNAM = GS_DATA-UNAME.  " ### (SY-UNAME #)

    LS_ZTCURR25-ERDAT = GS_DATA-DATUM.  " ### (SY-DATUM #)



    MODIFY ZTCURR25 FROM LS_ZTCURR25.



    IF SY-SUBRC = 0.

      ADD 1 TO LV_COUNT.

    ENDIF.

  ENDLOOP.



  " 3. ## ##

  IF LV_COUNT > 0.

    COMMIT WORK AND WAIT. " DB ### #### ##

    MESSAGE '##### ##### #######.' TYPE 'S'.

  ELSE.

    ROLLBACK WORK.

    MESSAGE '### ######.' TYPE 'E'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SAVE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_SAVE .

  DATA: LV_VALID TYPE C.



  " ##### ######(GT_DATA)# ##

  IF GO_ALV IS BOUND.

    CALL METHOD GO_ALV->CHECK_CHANGED_DATA

      IMPORTING

        E_VALID = LV_VALID.

  ENDIF.



  " #### ## # ## ## ##

  PERFORM SAVE_DATA.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DATA_CHANGED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_ER_DATA_CHANGED  text

*----------------------------------------------------------------------*




FORM ALV_DATA_CHANGED USING PR_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL.

  DATA: LS_MOD  TYPE LVC_S_MODI,

        LS_DATA TYPE TY_DATA.



  FIELD-SYMBOLS: <F> TYPE ANY.



  " ### ##### ### #### ##

  LOOP AT PR_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MOD.



    READ TABLE GT_DATA INTO LS_DATA INDEX LS_MOD-ROW_ID.

    IF SY-SUBRC = 0.



      " ### ## ##

      ASSIGN COMPONENT LS_MOD-FIELDNAME OF STRUCTURE LS_DATA TO <F>.



      IF SY-SUBRC = 0.

        " # ##

        <F> = LS_MOD-VALUE.



        MODIFY GT_DATA FROM LS_DATA INDEX LS_MOD-ROW_ID.

      ENDIF.

    ENDIF.

  ENDLOOP.

ENDFORM.