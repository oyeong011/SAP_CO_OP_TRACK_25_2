
*&---------------------------------------------------------------------*

*&  Include           ZWORK09_001_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  CONTROL_SCREEN

*&---------------------------------------------------------------------*




FORM CONTROL_SCREEN.

  "#### ## # : ##### 'M' ## + ####

  LOOP AT SCREEN.

    IF SCREEN-NAME = 'P_KURST'.

      SCREEN-INPUT = 0.

    ENDIF.



    MODIFY SCREEN.

  ENDLOOP.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  MAKE_BUTTON

*&---------------------------------------------------------------------*




FORM MAKE_BUTTON .

  "##### ### #### ##

  DATA : LS_DYNTXT TYPE SMP_DYNTXT.      "### ### ###



  LS_DYNTXT-ICON_ID =  ICON_SAVE_AS_TEMPLATE. "### ##

  LS_DYNTXT-ICON_TEXT = '### ####'.        "### ###

  LS_DYNTXT-QUICKINFO = '### ####'.        "### ### ### ### ###



  SSCRFIELDS-FUNCTXT_01 = LS_DYNTXT.





ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  DOWNLOAD_TEMPLATE

*&---------------------------------------------------------------------*




FORM DOWNLOAD_TEMPLATE .

 " ## ##, ### ####

  DATA : LV_FNAME TYPE STRING,           "#### ### ###

         LV_PATH TYPE STRING,            "## ##

         LV_FULL TYPE STRING,            "## ##

         LV_DEST TYPE LOCALFILE,         "DOWNLOAD_WEB_OBJECT# #### ##

         LV_EXT TYPE STRING VALUE 'csv'. "## ###



  " ### PC# ### ###/## ####

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_SAVE_DIALOG

    EXPORTING

      WINDOW_TITLE          = '## ### ##'              "### ##

      DEFAULT_EXTENSION     = LV_EXT                      "## ## ###

      DEFAULT_FILE_NAME     = C_TPLNAME                   "## ###

      FILE_FILTER           =  'CSV Files (*.CSV)|*.CSV|' "csv ###

    CHANGING

      FILENAME              = LV_FNAME       "###

      PATH                  = LV_PATH        "#### ##

      FULLPATH              = LV_FULL.       "## ##



  "#### ### ##### ##### #

  IF SY-SUBRC <> 0 OR LV_FULL IS INITIAL.

    MESSAGE E001.

    RETURN.

  ENDIF.



  "SAP ## ###(SMW0)## ### ## ##

  CLEAR GS_WWWKEY.

  SELECT SINGLE *

    FROM WWWDATA

    INTO CORRESPONDING FIELDS OF @GS_WWWKEY

    WHERE OBJID = @C_OBJID.



  IF SY-SUBRC <> 0.

    MESSAGE E002.

    RETURN.

  ENDIF.



  "### ##### #### ## ### ### PC# ####

  LV_DEST = LV_FULL.

  CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'

    EXPORTING

      KEY  =  GS_WWWKEY          "### ### ## ##

      DESTINATION = LV_DEST.     "### PC ## ##



  IF SY-SUBRC = 0.

    MESSAGE I003.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  READ_DATA

*    - CSV### ##, GT_CURR ####### ##

*&---------------------------------------------------------------------*




FORM READ_DATA  USING    P_P_FILE.

  DATA : LT_RAW TYPE TRUXS_T_TEXT_DATA.

  DATA : LV_FILENAME TYPE STRING.



  "SPLIT ## (### ## ### ####)

  DATA : LV_UKURS TYPE STRING,

         LV_FFACT TYPE STRING,

         LV_TFACT TYPE STRING.



  "GUI_UPLOAD# FILENAME ### STRING## ##

  LV_FILENAME = CONV STRING( P_P_FILE ).



  "1. GUI_UPLOAD : csv### raw###(lt_raw)# ##

  CALL FUNCTION 'GUI_UPLOAD'

    EXPORTING

      FILENAME = LV_FILENAME

      FILETYPE = 'ASC'

      READ_BY_LINE = 'X'

    TABLES

      DATA_TAB = LT_RAW.



  IF SY-SUBRC <>  0 OR LT_RAW IS INITIAL.

    MESSAGE E019. "## ### ######.

    STOP.

  ENDIF.





  "GT_RATE #### #, lt_raw# ### ## ## ##

  DATA : LV_LINE TYPE STRING.



  LOOP AT LT_RAW INTO LV_LINE FROM 2. "1## ### ##

     "## ## ## (## ## ## ## ##)

     CONDENSE LV_LINE NO-GAPS.



     "#### ###

     IF LV_LINE IS INITIAL.

       CONTINUE.

     ENDIF.



     "SPLIT# # ## ### ######### # ##

     CLEAR : GS_CURR.

     SPLIT LV_LINE AT ','

       INTO GS_CURR-KURST "####

            GS_CURR-FCURR "####

            GS_CURR-TCURR "####

            GS_CURR-GDATU "#######

            LV_UKURS      "##

            LV_FFACT      "########

            LV_TFACT.     "########

      GS_CURR-UKURS = LV_UKURS.

      GS_CURR-FFACT = LV_FFACT.

      GS_CURR-TFACT = LV_TFACT.



      "### ##, ##### ### ####

      GS_CURR-ERNAME = SY-UNAME.

      GS_CURR-ERDATE = SY-DATUM.



     APPEND GS_CURR TO GT_CURR.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA (## ### ######)

*        - KURST : ### 'M'

*        - GDATU : ##### ##

*        - JPY/VND : FFACT=100, TFACT=1, ### ###

*&---------------------------------------------------------------------*




FORM MODIFY_DATA .

  CLEAR : GS_CURR.



  LOOP AT GT_CURR INTO GS_CURR.

    MOVE-CORRESPONDING GS_CURR TO GS_CURR_ALV.



    IF GS_CURR-KURST <> 'M'.

      GS_CURR_ALV-KURST = 'M'. "##### ### 'M'## ##

    ENDIF.



    "###### ###### ##

    GS_CURR_ALV-GDATU = P_GDATU.



    "JPY/VND : FFACT=100, TFACT=1, ### ###

    IF GS_CURR-FCURR = 'JPY' OR GS_CURR-FCURR = 'VND'.

      GS_CURR_ALV-FFACT = 100.

      GS_CURR_ALV-TFACT = 1.

    ENDIF.



    APPEND GS_CURR_ALV TO GT_CURR_ALV.

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

      EXTENSION                   = 2000.



  CREATE OBJECT GC_GRID

    EXPORTING

      I_PARENT          = GC_DOCKING.





ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*




FORM CALL_ALV .

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT                    = GS_VARIANT

      I_SAVE                        = 'A'

      IS_LAYOUT                     = GS_LAYOUT

    CHANGING

      IT_OUTTAB                     = GT_CURR_ALV

      IT_FIELDCATALOG               = GT_FIELDCAT

      IT_SORT                       = GT_SORT.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'KURST'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'FCURR'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'TCURR'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'GDATU'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'UKURS'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-JUST        = 'L'.   "####

  GS_FIELDCAT-OUTPUTLEN = 15.

  GS_FIELDCAT-EDIT = 'X'.          "#### ##

  GS_FIELDCAT-DECIMALS = 5.        "#### #####

 "GS_FIELDCAT-DECIMALS_O = 2.      "ALV ## #####

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'FFACT'.

  GS_FIELDCAT-COLTEXT = '########'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'TFACT'.

  GS_FIELDCAT-COLTEXT = '########'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ERNAME'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ERDATE'.

  GS_FIELDCAT-COLTEXT = '###'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*




FORM ALV_LAYOUT .

  CLEAR : GS_LAYOUT, GS_VARIANT.



  GS_LAYOUT-ZEBRA = 'X'.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

ENDFORM.










*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*




FORM CLASS_EVENT .

  CREATE OBJECT GO_EVENT.



  "### ### - # ## ### ### #### ####, data_changed ### ###### alv# ##

  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.



  "### ### ##

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SAVE_DATA

*&---------------------------------------------------------------------*




FORM SAVE_DATA .

  DATA : LV_ANSWER TYPE C.           "### ####

  DATA : LS_ZTCURR09 TYPE ZTCURR09.  "### ### ##



  "### ###

  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      TITLEBAR = '##'

      TEXT_QUESTION = '##### ## ########?'

      TEXT_BUTTON_1      = '#(YES)'

      ICON_BUTTON_1      = 'ICON_SYSTEM_OK'

      TEXT_BUTTON_2      = '###(NO)'

      ICON_BUTTON_2      = 'ICON_SYSTEM_CANCEL'

      DISPLAY_CANCEL_BUTTON = ' '                  "##### #### ###

    IMPORTING

      ANSWER = LV_ANSWER.



    "#### ### ## ### ###

    IF LV_ANSWER <> 1.

      MESSAGE I007.

      RETURN.            "## SKIP

    ENDIF.



    "###

    CLEAR : LS_ZTCURR09.



    LOOP AT GT_CURR_ALV INTO GS_CURR_ALV.

      MOVE-CORRESPONDING GS_CURR_ALV TO LS_ZTCURR09.



      MODIFY ZTCURR09 FROM LS_ZTCURR09.

    ENDLOOP.



    "## ###

    MESSAGE S010.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DATA_CHANGED

*&---------------------------------------------------------------------*




FORM ALV_HANDLER_DATA_CHANGED  USING    P_ER_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                        P_E_ONF4

                                        P_E_ONF4_BEFORE

                                        P_E_ONF4_AFTER

                                        P_E_UCOMM.



  "##### ## (### ## ## ## - 5##)

  "#### ALV# ## #### ### ###, ### ####(MT_MOD_CELLS)# ####, # ## ##

  DATA : LS_MODI TYPE LVC_S_MODI.

  DATA : LV_LEN TYPE DFIES-DECIMALS.

  DATA : LV_TXT TYPE STRING.



  LOOP AT P_ER_DATA_CHANGED->MT_MOD_CELLS INTO LS_MODI.

    CLEAR : GS_CURR_ALV.



    "## ## ### ####

    IF LS_MODI-FIELDNAME <> 'UKURS'.

      CONTINUE.

    ENDIF.



    "## ### ### # ##

    PERFORM VERIFY_DATA USING LS_MODI-VALUE

                        CHANGING LV_TXT LV_LEN.





    "### # #### ###### ##

    READ TABLE GT_CURR_ALV INTO GS_CURR_ALV INDEX LS_MODI-ROW_ID.

    GS_CURR_ALV-UKURS = LV_TXT.

    MODIFY GT_CURR_ALV FROM GS_CURR_ALV INDEX LS_MODI-ROW_ID.

    CLEAR : GS_CURR_ALV.

  ENDLOOP.



  "## ####

  PERFORM REFRESH.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*




FORM REFRESH .

  DATA : LS_STABLE TYPE LVC_S_STBL.



  "### ## ## ##

  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE      = LS_STABLE.

ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  VERIFY_DATA

*&---------------------------------------------------------------------*




FORM VERIFY_DATA  USING    P_LS_MODI_VALUE

                  CHANGING P_LV_TXT

                           P_LV_LEN.



   "### ###

   P_LV_TXT = P_LS_MODI_VALUE.

   CONDENSE P_LV_TXT NO-GAPS.

   REPLACE ALL OCCURRENCES OF ',' IN P_LV_TXT WITH ''.  "### ##



   "### ### ##

   CALL FUNCTION 'SWA_DETERMINE_DECIMALS'

     EXPORTING

       EXPRESSION = CONV SWAEXPDEF-EXPR( P_LV_TXT )

     IMPORTING

       DECIMALS = P_LV_LEN.



   "### ## ## ### ## 5####. ### ##

   IF P_LV_LEN > 5.

     MESSAGE '### ## ## ### ## 5####' TYPE 'I'.

   ENDIF.





ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*




FORM ALV_SORT .

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'GDATU'. "## #####

  GS_SORT-UP = 'X'.            "####



  APPEND GS_SORT TO GT_SORT.

ENDFORM.