
*&---------------------------------------------------------------------*

*&  Include           ZWORK14_001_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  F4_FILENAME

*&---------------------------------------------------------------------*

*       ## ###(F4)# #### ## ## ### #### ##

*----------------------------------------------------------------------*




FORM F4_FILENAME CHANGING CV_FILE.



  DATA : LT_FILE_TABLE TYPE FILETABLE,

         LV_RC TYPE I.



  " ## ## ## ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_OPEN_DIALOG

    EXPORTING

      WINDOW_TITLE            = '## ##'

      DEFAULT_EXTENSION       = 'XSLX'

    CHANGING

      FILE_TABLE              = LT_FILE_TABLE

      RC                      = LV_RC

    EXCEPTIONS

      FILE_OPEN_DIALOG_FAILED = 1

      CNTL_ERROR              = 2

      others                  = 3.



  " #### ### #### ### ### ## ## ##

  IF LV_RC > 0.

    READ TABLE LT_FILE_TABLE INTO CV_FILE INDEX 1.

  ENDIF.



  IF SY-SUBRC <> 0.

    MESSAGE '## #### # # ####.' TYPE 'S' DISPLAY LIKE 'E'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DOWNLOAD_TEMPLATE

*&---------------------------------------------------------------------*

*       ##### ## #### #### ###### #

*----------------------------------------------------------------------*




FORM DOWNLOAD_TEMPLATE .



  DATA : LT_HEADER TYPE TABLE OF STRING,

         LV_FILENAME TYPE STRING,

         LV_PATH TYPE STRING,

         LV_FULLPATH TYPE STRING.



  " ## ### ##

  APPEND '####,####,####,####,##,########,########' TO LT_HEADER.

  " ## ### ##

  APPEND 'M,USD,KRW,20250401,1470.6,1,1' TO LT_HEADER.

  APPEND 'M,JPY,KRW,20250401,980.11,100,1' TO LT_HEADER.

  APPEND 'M,EUR,KRW,20250401,1590.9,1,1' TO LT_HEADER.

  APPEND 'M,CAD,KRW,20250401,1021.89,1,1' TO LT_HEADER.

  APPEND 'M,CNY,KRW,20250401,202.68,1,1' TO LT_HEADER.

  APPEND 'M,VND,KRW,20250401,5.75,100,1' TO LT_HEADER.

  APPEND 'M,HKD,KRW,20250401,189.03,1,1' TO LT_HEADER.

  APPEND 'M,AUD,KRW,20250401,918.24,1,1' TO LT_HEADER.



  " ## ## ## ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_SAVE_DIALOG

    EXPORTING

      DEFAULT_FILE_NAME         = 'Template.csv'

    CHANGING

      FILENAME                  = LV_FILENAME

      PATH                      = LV_PATH

      FULLPATH                  = LV_FULLPATH

    EXCEPTIONS

      others                    = 1.



  " #### ##### ## ## # ##

  IF SY-SUBRC <> 0 OR LV_FULLPATH IS INITIAL.

    RETURN.

  ENDIF.



  " ## ## ####

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>GUI_DOWNLOAD

      EXPORTING

        FILENAME                  = LV_FULLPATH

        CODEPAGE                  = '4110'  " ## ## ##

        WRITE_BOM                 = 'X'     " ## ###

      CHANGING

        DATA_TAB                  = LT_HEADER

      EXCEPTIONS

        others                    = 1.



  IF SY-SUBRC <> 0.

    MESSAGE '##### #######.' TYPE 'E'.

  ELSE.

    MESSAGE '#### ##### #### #####.' TYPE 'S'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  UPLOAD_EXCEL

*&---------------------------------------------------------------------*

*       ### ## ### ## ## #### ##

*----------------------------------------------------------------------*




FORM UPLOAD_EXCEL .



  DATA : LT_RAW TYPE TRUXS_T_TEXT_DATA.



  " ## -> ### ### ## ## ##

  CALL FUNCTION 'TEXT_CONVERT_XLS_TO_SAP'

    EXPORTING

      I_LINE_HEADER              = 'X'

      I_TAB_RAW_DATA             = LT_RAW

      I_FILENAME                 = P_FILE

    TABLES

      I_TAB_CONVERTED_DATA       = GT_EXCEL

   EXCEPTIONS

     CONVERSION_FAILED          = 1

     OTHERS                     = 2

            .

  IF SY-SUBRC <> 0.

    MESSAGE '## ### ##' TYPE 'E'.

  ENDIF.



  " #### ## ## ##

  IF GT_EXCEL IS INITIAL.

    MESSAGE '#### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*

*       #### #### ##### ## ##

*----------------------------------------------------------------------*




FORM MODIFY_DATA .

  CLEAR GT_OUT.



  LOOP AT GT_EXCEL INTO GS_EXCEL.

    CLEAR GS_OUT.



    " ### ##

    GS_OUT-FCURR = GS_EXCEL-FCURR.

    GS_OUT-TCURR = GS_EXCEL-TCURR.

    GS_OUT-UKURS = GS_EXCEL-UKURS.



    " #### M ##, ###### ## ### ##

    GS_OUT-KURST = 'M'.

    GS_OUT-GDATU = P_DATE.



    " JPY, VND# ### 100## ##

    CASE GS_OUT-FCURR.

      WHEN 'JPY' OR 'VND'.

        GS_OUT-FFACT = 100.

      WHEN OTHERS.

        GS_OUT-FFACT = 1.

    ENDCASE.

    GS_OUT-TFACT = 1.



    " ### ## ###, ###

    GS_OUT-UNAME = SY-UNAME.

    GS_OUT-DATUM = SY-DATUM.



    APPEND GS_OUT TO GT_OUT.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_DATA

*&---------------------------------------------------------------------*

*       ### #### DB# ##

*----------------------------------------------------------------------*




FORM SAVE_DATA .



  DATA : LV_ANSWER TYPE CHAR1.

  DATA : LT_SAVE TYPE TABLE OF ZTCURR14.



  " ### #### ### ##

  IF GT_OUT IS INITIAL.

    MESSAGE '### #### ####.' TYPE 'S' DISPLAY LIKE 'W'.

    RETURN.

  ENDIF.



  CALL METHOD GO_GRID->CHECK_CHANGED_DATA.



  " ## ## ## ##

  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

     TITLEBAR                    = '## ##'

     TEXT_QUESTION               = '##### ## ########?'

     TEXT_BUTTON_1               = 'YES'

     TEXT_BUTTON_2               = 'NO'

   IMPORTING

     ANSWER                      = LV_ANSWER.



  IF LV_ANSWER = '1'.  " YES ##

    LT_SAVE = GT_OUT.



    MODIFY ZTCURR14 FROM TABLE LT_SAVE.



    IF SY-SUBRC = 0.

      MESSAGE '#######.' TYPE 'I'.

    ELSE.

      MESSAGE '### ######.' TYPE 'E'.

    ENDIF.

  ELSEIF LV_ANSWER = '2'.  " NO ##

    MESSAGE '#######.' TYPE 'I'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       Docking Container # ALV Grid ## ##

*----------------------------------------------------------------------*




FORM CREATE_OBJECT .



  CREATE OBJECT GO_DOCKING

      EXPORTING

        REPID                       = SY-REPID

        DYNNR                       = SY-DYNNR

        SIDE                        = CL_GUI_DOCKING_CONTAINER=>DOCK_AT_BOTTOM

        EXTENSION                   = 1000.

  IF SY-SUBRC <> 0.

    MESSAGE '#### ## ##' TYPE 'E'.

  ENDIF.



  CREATE OBJECT GO_GRID

    EXPORTING

      I_PARENT = GO_DOCKING.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*

*       ALV ## #### ## ##

*----------------------------------------------------------------------*




FORM FIELD_CATALOG .



  CLEAR : GT_FCAT, GS_FCAT.



  PERFORM SET_FCAT USING :

      'KURST' '####' '' 10 '' CHANGING GT_FCAT,

      'FCURR' '####' '' 10 '' CHANGING GT_FCAT,

      'TCURR' '####' '' 10 '' CHANGING GT_FCAT,

      'GDATU' '####' '' 10 '' CHANGING GT_FCAT,




*      'UKURS' '##' 'X' 15 CHANGING GT_FCAT,




      'UKURS' '##' 'X' 15 'CURR' CHANGING GT_FCAT,

      'FFACT' '########' '' 14 '' CHANGING GT_FCAT,

      'TFACT' '########' '' 14 '' CHANGING GT_FCAT,

      'UNAME' '###' '' 12 '' CHANGING GT_FCAT,

      'DATUM' '###' '' 12 '' CHANGING GT_FCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

*       ALV #### ##

*----------------------------------------------------------------------*




FORM ALV_LAYOUT .



  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*

*       ### ## ## ##

*----------------------------------------------------------------------*




FORM ALV_SORT .

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_METHOD

*&---------------------------------------------------------------------*

*       ALV ## # ### ##

*----------------------------------------------------------------------*




FORM CALL_METHOD .



  CALL METHOD GO_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.



  CALL METHOD GO_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_LAYOUT       = GS_LAYOUT

    CHANGING

      IT_OUTTAB       = GT_OUT

      IT_FIELDCATALOG = GT_FCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH_ALV

*&---------------------------------------------------------------------*

*       ALV ### ####

*----------------------------------------------------------------------*




FORM REFRESH_ALV .



  DATA: LS_STABLE TYPE LVC_S_STBL.



  " ## ### ## # ## ## ##

  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GO_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE = LS_STABLE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_FCAT

*&---------------------------------------------------------------------*

*       ## #### ## ## ##

*----------------------------------------------------------------------*




FORM SET_FCAT  USING PV_FLD PV_TXT PV_EDIT PV_LEN PV_CFIELD

               CHANGING CT_FCAT TYPE LVC_T_FCAT.



  DATA : LS_FCAT TYPE LVC_S_FCAT.



  LS_FCAT-FIELDNAME = PV_FLD.

  LS_FCAT-COLTEXT = PV_TXT.

  LS_FCAT-EDIT = PV_EDIT.

  LS_FCAT-JUST = 'R'.

  LS_FCAT-OUTPUTLEN = PV_LEN.

  IF PV_CFIELD IS NOT INITIAL.

    LS_FCAT-DECIMALS = 5.

  ENDIF.



  APPEND LS_FCAT TO CT_FCAT.



ENDFORM.