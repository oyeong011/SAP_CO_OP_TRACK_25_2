
*&---------------------------------------------------------------------*

*&  Include           ZWORK18_001_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*




FORM CREATE_OBJECT .

  CREATE OBJECT GC_DOCKING

    EXPORTING

      REPID     = SY-REPID

      DYNNR     = SY-DYNNR

      EXTENSION = 1800.



  CREATE OBJECT GC_GRID

    EXPORTING

      I_PARENT = GC_DOCKING.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*




FORM ALV_LAYOUT .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

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

  GS_FIELDCAT-FIELDNAME = 'UKURS_RAW'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-EDIT = ABAP_TRUE.

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

*&      Form  READ_XLSX_USING_FDT

*&---------------------------------------------------------------------*




FORM READ_XLSX_USING_ALSM USING IV_FILE TYPE RLGRAP-FILENAME.



  DATA LT_ALSM TYPE STANDARD TABLE OF ALSMEX_TABLINE.

  DATA LV_GDATU_INV TYPE ZTCURR18-GDATU.



  REFRESH GT_CURR.



  " EXCEL ####

  CALL FUNCTION 'ALSM_EXCEL_TO_INTERNAL_TABLE'

    EXPORTING

      FILENAME    = IV_FILE

      I_BEGIN_COL = 1

      I_BEGIN_ROW = 2

      I_END_COL   = 7

      I_END_ROW   = 9999

    TABLES

      INTERN      = LT_ALSM

    EXCEPTIONS

      OTHERS      = 1.

  IF SY-SUBRC <> 0.

    MESSAGE '## ## ##' TYPE 'E'.

  ENDIF.



  SORT LT_ALSM BY ROW COL.



  LOOP AT LT_ALSM ASSIGNING FIELD-SYMBOL(<L>).



    AT NEW ROW.

      CLEAR GS_CURR.

      GS_CURR-KURST = 'M'.

    ENDAT.



    CASE <L>-COL.

      WHEN 2. GS_CURR-FCURR = <L>-VALUE.

      WHEN 3. GS_CURR-TCURR = <L>-VALUE.

      WHEN 5. GS_CURR-UKURS_RAW = <L>-VALUE.

      WHEN 6. GS_CURR-FFACT = <L>-VALUE.

      WHEN 7. GS_CURR-TFACT = <L>-VALUE.

    ENDCASE.



    AT END OF ROW.

      " GDATU_INV ##

      CALL FUNCTION 'CONVERSION_EXIT_INVDT_INPUT'

        EXPORTING

          INPUT  = P_DATE

        IMPORTING

          OUTPUT = LV_GDATU_INV.

      GS_CURR-GDATU = LV_GDATU_INV.

      " JPY, VND# # 100 : 1 ##

      IF GS_CURR-FCURR = 'JPY' OR GS_CURR-FCURR = 'VND'.

        GS_CURR-FFACT = 100.

        GS_CURR-TFACT = 1.

      ELSE.

        IF GS_CURR-FFACT IS INITIAL. GS_CURR-FFACT = 1. ENDIF.

        IF GS_CURR-TFACT IS INITIAL. GS_CURR-TFACT = 1. ENDIF.

      ENDIF.



      " ALV ## ## ##

      GS_CURR-ERNAM = SY-UNAME.

      GS_CURR-ERDAT = SY-DATUM.



      " STRUCTURE# TABLE# ##

      APPEND GS_CURR TO GT_CURR.

    ENDAT.



  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  F4_FILE

*&---------------------------------------------------------------------*




FORM F4_FILE .

  DATA : LT_FILE TYPE FILETABLE, LV_RC TYPE I, LS_FILE TYPE FILE_TABLE.

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_OPEN_DIALOG

    EXPORTING

      FILE_FILTER = 'EXCEL (*.XLSX)|*.XLSX|EXCEL (*.XLS) |*.XLS'

    CHANGING

      FILE_TABLE  = LT_FILE

      RC          = LV_RC.

  IF LV_RC > 0.

    READ TABLE LT_FILE INDEX 1 INTO LS_FILE.

    IF SY-SUBRC = 0.

      P_FILE = LS_FILE-FILENAME.

    ENDIF.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FUNCTION_KEY

*&---------------------------------------------------------------------*




FORM FUNCTION_KEY .

  CASE SSCRFIELDS-UCOMM.

    WHEN 'ONLI'.

      EXIT.

    WHEN 'FC01'. " function key 1 ###

      PERFORM DOWNLOAD_TEMPLATE.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DOWNLOAD_TEMPLATE

*&---------------------------------------------------------------------*




FORM DOWNLOAD_TEMPLATE.



  DATA: LS_KEY         TYPE WWWDATATAB,

        LV_DESTINATION TYPE RLGRAP-FILENAME,

        LV_RC          TYPE SY-SUBRC.



  DATA: LV_FILENAME TYPE STRING,

        LV_PATH     TYPE STRING,

        LV_FULLPATH TYPE STRING.



  " 1) SMW0 ## ##

  SELECT SINGLE *

    FROM WWWDATA

    INTO CORRESPONDING FIELDS OF LS_KEY

    WHERE OBJID = 'ZWORK18_RATE_TMPL'

      AND SRTF2 = 0.



  IF SY-SUBRC <> 0 OR LS_KEY IS INITIAL.

    MESSAGE '### ##(ZWORK18_RATE_TMPL)# ## # ####.' TYPE 'E'.

    RETURN.

  ENDIF.



  " 2) ### PC ## ## ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_SAVE_DIALOG

    EXPORTING

      DEFAULT_FILE_NAME = 'rate_template.xlsx'

    CHANGING

      FILENAME          = LV_FILENAME

      PATH              = LV_PATH

      FULLPATH          = LV_FULLPATH.



  IF LV_FULLPATH IS INITIAL.

    MESSAGE '##### #######.' TYPE 'S'.

    RETURN.

  ENDIF.



  " 3) SMW0 ### PC# ####

  LV_DESTINATION = LV_FULLPATH.



  CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'

    EXPORTING

      KEY         = LS_KEY

      DESTINATION = LV_DESTINATION

    IMPORTING

      RC          = LV_RC.



  IF LV_RC <> 0.

    MESSAGE '### #### # ### ######.' TYPE 'E'.

  ELSE.

    MESSAGE '## #### #######.' TYPE 'S'.

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

*&      Form  SET_SCREEN

*&---------------------------------------------------------------------*




FORM SET_SCREEN .

  LOOP AT SCREEN.

    "KURST PARAMETER ### ### ##

    IF SCREEN-GROUP1 = 'M1'.

      SCREEN-INPUT = '0'.

      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  UCOMM_SAVE

*&---------------------------------------------------------------------*




FORM UCOMM_SAVE.

  DATA : LV_ANSWER TYPE C.

  PERFORM POPUP_TO_CONFIRM CHANGING LV_ANSWER.

  IF LV_ANSWER EQ '1'.

    PERFORM SAVE_TO_DB.

  ELSE.

    MESSAGE '### #######.' TYPE 'S'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  POPUP_TO_CONFIRM

*&---------------------------------------------------------------------*




FORM POPUP_TO_CONFIRM  CHANGING LV_ANSWER.

  CLEAR LV_ANSWER.

  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      TITLEBAR              = '####'

      TEXT_QUESTION         = '##### ########?'

      TEXT_BUTTON_1         = 'Yes'

      TEXT_BUTTON_2         = 'No'

      DEFAULT_BUTTON        = '1'

      DISPLAY_CANCEL_BUTTON = ' '

    IMPORTING

      ANSWER                = LV_ANSWER.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_TO_DB

*&---------------------------------------------------------------------*




FORM SAVE_TO_DB .



  DATA : LS_CURR_DB    TYPE ZTCURR18,

         LT_CURR_DB    TYPE STANDARD TABLE OF ZTCURR18,

         LV_UKURS_STR  TYPE C LENGTH 20,

         LV_UKURS_NUM  TYPE P DECIMALS 5,

         LV_ERROR      TYPE ABAP_BOOL VALUE ABAP_FALSE,   "# ## ###

         LV_NUM_BEFORE TYPE C LENGTH 20,

         LV_NUM_AFTER  TYPE C LENGTH 20.





  CALL METHOD GC_GRID->CHECK_CHANGED_DATA( ).

  " ## DB ##

  LOOP AT GT_CURR INTO GS_CURR.



    CLEAR LS_CURR_DB.

    MOVE-CORRESPONDING GS_CURR TO LS_CURR_DB.



    LV_UKURS_STR = GS_CURR-UKURS_RAW.

    " 0) ####

    CONDENSE LV_UKURS_STR NO-GAPS.



    " 1) # ### ##

    IF LV_UKURS_STR IS INITIAL.

      LV_ERROR = ABAP_TRUE.

      MESSAGE '### #### ###.' TYPE 'E'.

      EXIT.

    ENDIF.



    " 2) ##/### #### ##

    DATA(LV_TMP) = LV_UKURS_STR.

    REPLACE ALL OCCURRENCES OF '.' IN LV_TMP WITH ''.

    REPLACE ALL OCCURRENCES OF '-' IN LV_TMP WITH ''.



    " 3) lv_tmp ## ### ## ### ##

    IF LV_TMP CA 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!@#$%^&*()_=+[]{};:''"<>?/\|' .

      LV_ERROR = ABAP_TRUE.

      MESSAGE |#### ### ###(.)# ### # ####. (###: { LV_UKURS_STR })| TYPE 'E'.

      EXIT.

    ENDIF.



    " 4) ## ##

    IF LV_UKURS_STR CS '.'.

      SPLIT LV_UKURS_STR AT '.' INTO LV_NUM_BEFORE LV_NUM_AFTER.

      IF STRLEN( LV_NUM_AFTER ) > 6.

        LV_ERROR = ABAP_TRUE.

        MESSAGE |### ## #### ## 5#### #####. (###: { LV_UKURS_STR })| TYPE 'E'.

        EXIT.

      ELSEIF STRLEN( LV_NUM_BEFORE ) > 5.

        LV_ERROR = ABAP_TRUE.

        MESSAGE |### ## #### ## 4#### #####. (###: { LV_UKURS_STR })| TYPE 'E'.

        EXIT.

      ENDIF.

    ENDIF.



    LS_CURR_DB-UKURS = LV_UKURS_STR.



    APPEND LS_CURR_DB TO LT_CURR_DB.

  ENDLOOP.



  " 5) ERROR ### ## ##

  IF LV_ERROR = ABAP_TRUE.

    MESSAGE '## ### ######.' TYPE 'E'.

  ENDIF.



  MODIFY ZTCURR18 FROM TABLE LT_CURR_DB.



  IF SY-SUBRC = 0.

    COMMIT WORK.

    MESSAGE '##### #######.' TYPE 'S'.

    PERFORM REFRESH.

  ELSE.

    ROLLBACK WORK.

    MESSAGE 'DB ### ######.' TYPE 'E'.

  ENDIF.



ENDFORM.