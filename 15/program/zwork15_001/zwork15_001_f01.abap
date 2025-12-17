
*&---------------------------------------------------------------------*

*&  Include           ZWORK15_001_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_BUTTON

*&---------------------------------------------------------------------*

*       selection screen ### #### ##

*----------------------------------------------------------------------*




FORM SET_BUTTON .

  SSCRFIELDS-FUNCTXT_01 = 'DOWNLOAD EXCEL TEMPLATE'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SCREEN_CONTROL

*&---------------------------------------------------------------------*

*       #### M## ## / #### ######

*----------------------------------------------------------------------*




FORM SCREEN_CONTROL .

  LOOP AT SCREEN.

    IF SCREEN-NAME = 'P_KURST'.

      SCREEN-INPUT = '0'.

      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.



  P_DATE = SY-DATUM.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_EXCEL

*&---------------------------------------------------------------------*

*       ### ## ## P_EXCEL# ####

*----------------------------------------------------------------------*




FORM SET_EXCEL .

  CALL FUNCTION 'F4_FILENAME'

    IMPORTING

      FILE_NAME = P_EXCEL.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DOWNLOAD_TEMP

*&---------------------------------------------------------------------*

*       ### ##### # #### ### # PC# #### PERFORM

*----------------------------------------------------------------------*




FORM DOWNLOAD_TEMP .

  DATA : LV_OBJECT_NAME TYPE STRING VALUE 'ZEXCEL_TEMP_001', "SMW0 ### ##

        LV_FILE TYPE STRING,

        LV_PATH TYPE STRING,

        LV_FULLPATH TYPE STRING,

        LV_FILENAME TYPE STRING VALUE 'CURR_TEMP.XLSX',

        LV_RC TYPE SY-SUBRC,

        LV_DEST TYPE LOCALFILE.



  DATA : LS_KEY TYPE WWWDATATAB.



  "1. ### KEY ####

  SELECT SINGLE * INTO CORRESPONDING FIELDS OF LS_KEY

    FROM WWWDATA

    WHERE OBJID = LV_OBJECT_NAME.



  IF SY-SUBRC <> 0.

    MESSAGE 'SMW0# ### ### ### #### ####' TYPE 'E'.

    EXIT.

  ENDIF.



  "2. ## ## ## # ## ## ## ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_SAVE_DIALOG

     EXPORTING

        WINDOW_TITLE       = '## ### ## ## ##' "######## ##

        DEFAULT_EXTENSION  = 'xlsx' "#####

        DEFAULT_FILE_NAME  = LV_FILENAME "### ## ## ##

      CHANGING

        FILENAME       = LV_FILE "###

        PATH           = LV_PATH "####

        FULLPATH       = LV_FULLPATH "## ## ### ###

      EXCEPTIONS

        CNTL_ERROR          = 1

        ERROR_NO_GUI        = 2

        OTHERS              = 3.



    IF SY-SUBRC > 0 OR LV_FULLPATH IS INITIAL.

      MESSAGE '## ### #######.' TYPE 'I'.

      EXIT.

    ENDIF.



    "3. SMW0 ## ####

  LV_DEST = LV_FULLPATH.



  CALL FUNCTION 'DOWNLOAD_WEB_OBJECT' "call function# ### ## #### #

      EXPORTING

        KEY = LS_KEY

        DESTINATION = LV_DEST

      IMPORTING

        RC   = LV_RC.



    IF SY-SUBRC = 0.

      MESSAGE '## ### ##### #######.' TYPE 'S'.

    ELSE.

      MESSAGE '## ### #### # ## ##.' TYPE 'E'.

    ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  EXCEL_TO_ITAB

*&---------------------------------------------------------------------*

*       #### ### ##### GT_RAW# ####

*----------------------------------------------------------------------*




FORM EXCEL_TO_ITAB .



  "###### ### #### #### ##

  "ALSMEX_TABLINE ### ####### ### ## ###### #

  CALL FUNCTION 'ALSM_EXCEL_TO_INTERNAL_TABLE'

    EXPORTING

      FILENAME                      = P_EXCEL "#### ### ####

      I_BEGIN_COL                   = 1

      I_BEGIN_ROW                   = 2

      I_END_COL                     = 7

      I_END_ROW                     = 100

    TABLES

      INTERN                        = GT_RAW



            .

  IF SY-SUBRC <> 0.

    MESSAGE '##### #### # ####' TYPE 'E'.

    EXIT.

  ENDIF.





  "## ### ### ##

  CLEAR : GT_ZTCURR.



  LOOP AT GT_RAW INTO GS_RAW.

    CASE GS_RAW-COL.

      WHEN 1.

        GS_ZTCURR-KURST = GS_RAW-VALUE.

      WHEN 2.

        GS_ZTCURR-FCURR = GS_RAW-VALUE.

      WHEN 3.

        GS_ZTCURR-TCURR = GS_RAW-VALUE.

      WHEN 4.

        GS_ZTCURR-GDATU = GS_RAW-VALUE.

      WHEN 5.

        GS_ZTCURR-UKURS = GS_RAW-VALUE.

      WHEN 6.

        GS_ZTCURR-FFACT = GS_RAW-VALUE.

      WHEN 7.

        GS_ZTCURR-TFACT = GS_RAW-VALUE.

        APPEND GS_ZTCURR TO GT_ZTCURR.

        CLEAR : GS_ZTCURR. "## #### ## ###

    ENDCASE.



  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*

*       alv### #### ##

*----------------------------------------------------------------------*




FORM MODIFY_DATA .

  LOOP AT GT_ZTCURR INTO GS_ZTCURR.

    MOVE-CORRESPONDING GS_ZTCURR TO GS_ZTCURR_OUT.



    "#### M, #### -####, #### ### ##

    GS_ZTCURR_OUT-KURST = 'M'.

    GS_ZTCURR_OUT-GDATU = P_DATE.

    GS_ZTCURR_OUT-CRNAME = SY-UNAME.

    GS_ZTCURR_OUT-CRDATE = SY-DATUM.



    "JPY, VND# ######## 100

    IF GS_ZTCURR-FCURR EQ 'JPY' OR GS_ZTCURR-FCURR EQ 'VND'.

      GS_ZTCURR_OUT-FFACT = 100.

    ENDIF.



    APPEND GS_ZTCURR_OUT TO GT_ZTCURR_OUT.

    CLEAR : GS_ZTCURR_OUT.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*




FORM CREATE_OBJECT .

  CREATE OBJECT GC_DOCKING

    EXPORTING

      REPID                       = SY-REPID

      DYNNR                       = SY-DYNNR

      EXTENSION                   = 2000

      .



  CREATE OBJECT GC_GRID

    EXPORTING

      I_PARENT          = GC_DOCKING

      .



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.



  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'KURST'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'FCURR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'TCURR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'GDATU'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'UKURS'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-EDIT = 'X'. "####.

  GS_FIELDCAT-OUTPUTLEN = 11.

  GS_FIELDCAT-REF_TABLE = 'TCURR'.

  GS_FIELDCAT-REF_FIELD = 'UKURS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'FFACT'.

  GS_FIELDCAT-COLTEXT = '########'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'TFACT'.

  GS_FIELDCAT-COLTEXT = '########'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'CRNAME'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'CRDATE'.

  GS_FIELDCAT-COLTEXT = '###'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*




FORM ALV_LAYOUT .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.



  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*

*        Handler_data_changed# ## ##

*----------------------------------------------------------------------*




FORM CLASS_EVENT .

 "SCREEN# ITAB### / ### #### ##

  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED

      .

  CREATE OBJECT GO_EVENT.



  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY .

CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

  EXPORTING

    IS_VARIANT                    = GS_VARIANT

    I_SAVE                        = 'A'

    IS_LAYOUT                     = GS_LAYOUT

  CHANGING

    IT_OUTTAB                     = GT_ZTCURR_OUT

    IT_FIELDCATALOG               = GT_FIELDCAT

    .

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*




FORM REFRESH .

  DATA : LS_STABLE TYPE LVC_S_STBL.



  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE      = LS_STABLE

      .



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DATA_CHANGED

*&---------------------------------------------------------------------*

*       ### ### ## perform

*----------------------------------------------------------------------*

*      -->P_DATA_CHANGED  text

*      -->P_ONF4  text

*      -->P_ONF4_BEFORE  text

*      -->P_ONF4_AFTER  text

*      -->P_UCOMM  text

*----------------------------------------------------------------------*




FORM ALV_HANDLER_DATA_CHANGED  USING    P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                        P_ONF4

                                        P_ONF4_BEFORE

                                        P_ONF4_AFTER

                                        P_UCOMM.

"##### ### ##

DATA : LS_MODI TYPE LVC_S_MODI. "### ## ## ## ##

DATA : LV_DEC TYPE P DECIMALS 5 LENGTH 9. "#### ##



LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.

  IF LS_MODI-FIELDNAME = 'UKURS'.

    READ TABLE GT_ZTCURR_OUT INTO GS_ZTCURR_OUT INDEX LS_MODI-ROW_ID.



    "####

    REPLACE ALL OCCURRENCES OF ',' IN LS_MODI-VALUE WITH ''.



    LV_DEC = LS_MODI-VALUE. "###

    GS_ZTCURR_OUT-UKURS = LV_DEC.



    MODIFY GT_ZTCURR_OUT FROM GS_ZTCURR_OUT INDEX LS_MODI-ROW_ID.

    CLEAR GS_ZTCURR_OUT.

  ENDIF.

ENDLOOP.



PERFORM REFRESH.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DATA_CHANGED_FINISHED

*&---------------------------------------------------------------------*

*       (##x/### ###)

*----------------------------------------------------------------------*




FORM ALV_DATA_CHANGED_FINISHED  USING    P_MODIFIED

                                         P_GOOD_CELLS TYPE LVC_T_MODI.



PERFORM REFRESH.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_CURR

*&---------------------------------------------------------------------*

*       #### ## ## ##

*----------------------------------------------------------------------*




FORM SAVE_CURR .

  DATA : LV_ANSWER TYPE C.

  CALL FUNCTION 'POPUP_TO_CONFIRM'

        EXPORTING

          TEXT_QUESTION               = '##### ## ########?'

         TEXT_BUTTON_1               = 'YES'

         ICON_BUTTON_1               = '##'

         TEXT_BUTTON_2               = 'NO'

         ICON_BUTTON_2               = '##'

         DISPLAY_CANCEL_BUTTON       = 'X'

       IMPORTING

         ANSWER                      = LV_ANSWER.



      IF LV_ANSWER = '1'.

        PERFORM MODIFY_DB.

      ELSE.

        MESSAGE '#######' TYPE 'I'.

      ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DB

*&---------------------------------------------------------------------*

*       DB# ##

*----------------------------------------------------------------------*




FORM MODIFY_DB .

  CLEAR : GS_SAVE, GT_SAVE.

  LOOP AT GT_ZTCURR_OUT INTO GS_ZTCURR_OUT.

    MOVE-CORRESPONDING GS_ZTCURR_OUT TO GS_SAVE.

    APPEND GS_SAVE TO GT_SAVE.

  ENDLOOP.



  MODIFY ZTCURR015 FROM TABLE GT_SAVE.

ENDFORM.