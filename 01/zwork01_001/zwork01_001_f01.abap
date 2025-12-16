
*&---------------------------------------------------------------------*

*&  Include           ZWORK01_001_F01

*&---------------------------------------------------------------------*



*&---------------------------------------------------------------------*

*&      Form  MAIN

*&---------------------------------------------------------------------*

*       ### ## ##### ## # ## #### ##

*----------------------------------------------------------------------*




FORM MAIN .

  IF P_DATE IS INITIAL.

    MESSAGE '##### ######.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  IF P_FILE IS INITIAL.

    MESSAGE '## ### #####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  PERFORM UPLOAD_EXCEL.

  PERFORM CONVERT_DATA.

  CALL SCREEN 100.

ENDFORM.




*---------------------------------------------------------------------*

*&      Form DOWNLOAD_TEMPLATE

*---------------------------------------------------------------------*




"

FORM DOWNLOAD_TEMPLATE USING I_OBJID I_TITLE I_FNAME.



  DATA:

    LS_KEY    TYPE WWWDATATAB,

    LV_TITLE  TYPE STRING,

    LV_EXT    TYPE STRING,

    LV_FNAME  TYPE STRING,

    LV_FILE   TYPE STRING,

    LV_PATH   TYPE STRING,

    LV_FUPATH TYPE STRING,

    LV_DEST   TYPE LOCALFILE.



  SELECT SINGLE *

    FROM WWWDATA

    INTO CORRESPONDING FIELDS OF @LS_KEY

    WHERE OBJID = @I_OBJID.



  IF SY-SUBRC = 0.

    LV_TITLE = I_TITLE.

    LV_EXT   = 'XLSX'.

    LV_FNAME = I_FNAME.



    CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_SAVE_DIALOG

      EXPORTING

        WINDOW_TITLE      = LV_TITLE

        DEFAULT_EXTENSION = LV_EXT

        DEFAULT_FILE_NAME = LV_FNAME

      CHANGING

        FILENAME          = LV_FILE

        PATH              = LV_PATH

        FULLPATH          = LV_FUPATH.



    IF LV_FUPATH IS NOT INITIAL.

      LV_DEST = LV_FUPATH.



      CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'

        EXPORTING

          KEY         = LS_KEY

          DESTINATION = LV_DEST.



      MESSAGE '## #### #########.' TYPE 'S'.

    ENDIF.

  ELSE.

    MESSAGE '## ### #### ####.' TYPE 'E'.

  ENDIF.



ENDFORM.




*---------------------------------------------------------------------*

*&      Form GET_FILENAME

*---------------------------------------------------------------------*




FORM GET_FILENAME.

  DATA: LT_FILETAB TYPE FILETABLE,

        LV_RC      TYPE I,

        LS_FILE    TYPE FILE_TABLE.



  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_OPEN_DIALOG

    CHANGING

      FILE_TABLE = LT_FILETAB

      RC         = LV_RC

    EXCEPTIONS

      OTHERS     = 1.



  IF SY-SUBRC = 0 AND LV_RC > 0.

    READ TABLE LT_FILETAB INTO LS_FILE INDEX 1.

    P_FILE = LS_FILE-FILENAME.

  ENDIF.

ENDFORM.




*---------------------------------------------------------------------*

*&      Form UPLOAD_EXCEL

*---------------------------------------------------------------------*




" ### ##### GT_EXCEL# ##

FORM UPLOAD_EXCEL.

  CALL FUNCTION 'ALSM_EXCEL_TO_INTERNAL_TABLE'

    EXPORTING

      FILENAME    = P_FILE

      I_BEGIN_COL = 1

      I_BEGIN_ROW = 2

      I_END_COL   = 7

      I_END_ROW   = 9999

    TABLES

      INTERN      = GT_EXCEL

    EXCEPTIONS

      OTHERS      = 1.



  IF SY-SUBRC <> 0.

    MESSAGE '## ### ##' TYPE 'E'.

  ENDIF.

ENDFORM.




*---------------------------------------------------------------------*

*      Form CONVERT_DATA

*---------------------------------------------------------------------*




"## GT_EXCEL ##### ## ### CURR# ##

FORM CONVERT_DATA.

  LOOP AT GT_EXCEL INTO GS_EXCEL.

    CASE GS_EXCEL-COL.

      WHEN 1. GS_CURR-KURST = GS_EXCEL-VALUE.       "####

      WHEN 2. GS_CURR-FCURR = GS_EXCEL-VALUE.       "####

      WHEN 3. GS_CURR-TCURR = GS_EXCEL-VALUE.       "####

      WHEN 4. GS_CURR-GDATU = P_DATE.               "####

      WHEN 5. GS_CURR-UKURS = GS_EXCEL-VALUE.       "##

      WHEN 6. GS_CURR-FFACT = GS_EXCEL-VALUE.       "########

      WHEN 7.

        GS_CURR-TFACT = GS_EXCEL-VALUE.             "########

        GS_CURR-CRNAME = SY-UNAME.

        GS_CURR-CRDATE = SY-DATUM.

        GS_CURR-CRZEIT = SY-UZEIT.

        APPEND GS_CURR TO GT_CURR.

        CLEAR GS_CURR.

    ENDCASE.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG .



  CLEAR : GS_FIELDCAT,GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'KURST'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'FCURR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'TCURR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'GDATU'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'UKURS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-JUST = 'L'.

  GS_FIELDCAT-OUTPUTLEN = 15.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-DECIMALS = 5.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'FFACT'.

  GS_FIELDCAT-SCRTEXT_M = '########'.

  GS_FIELDCAT-OUTPUTLEN = 13.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'TFACT'.

  GS_FIELDCAT-SCRTEXT_M = '########'.

  GS_FIELDCAT-OUTPUTLEN = 13.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'CRNAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'CRDATE'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  INIT_DATA

*&---------------------------------------------------------------------*




FORM INIT_DATA .

  G_FKEY-ICON_ID     = ICON_XLS.

  G_FKEY-ICON_TEXT   = '### ####'.

  G_FKEY-TEXT        = '### ####'.

  SSCRFIELDS-FUNCTXT_01 = G_FKEY.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ORDER_CREATE_OBJECT

*&---------------------------------------------------------------------




" ## #### ####

FORM CREATE_OBJECT .

  CREATE OBJECT GC_DOCKING

    EXPORTING




*      PARENT                      =




      REPID                       = SY-REPID

      DYNNR                       = SY-DYNNR




*      SIDE                        = DOCK_AT_LEFT




      EXTENSION                   = GV_GRID_SIZE




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

  CREATE OBJECT GC_GRID

    EXPORTING




*      I_SHELLSTYLE      = 0

*      I_LIFETIME        =




      I_PARENT          = GC_DOCKING




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



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ORDER_ALV_LAYOUT

*&---------------------------------------------------------------------*




" LAYOUT# #### ####

FORM ALV_LAYOUT .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'. " ### ## ###

  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ORDER_ALV_SORT

*&---------------------------------------------------------------------*




" SORT# #### #### SORT# ## #### ###

FORM ALV_SORT .



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form ALV_DISPLAY

*&---------------------------------------------------------------------*




" ALV# #### #### PT_TABLE# ### #### ###

FORM ALV_DISPLAY USING PT_TABLE TYPE STANDARD TABLE.

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




      IT_TOOLBAR_EXCLUDING = GT_EXCLUDE




*      IT_HYPERLINK                  =

*      IT_ALV_GRAPHICS               =

*      IT_EXCEPT_QINFO               =

*      IR_SALV_ADAPTER               =




    CHANGING

      IT_OUTTAB                     = PT_TABLE

      IT_FIELDCATALOG               = GT_FIELDCAT

      IT_SORT                       = GT_SORT




*      IT_FILTER                     =

*    EXCEPTIONS

*      INVALID_PARAMETER_COMBINATION = 1

*      PROGRAM_ERROR                 = 2

*      TOO_MANY_LINES                = 3

*      others                        = 4




          .

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_SCREEN

*&---------------------------------------------------------------------*




"### #### ## ## # ##

FORM SET_SCREEN .

  IF SSCRFIELDS-UCOMM = 'FC01'.

     PERFORM DOWNLOAD_TEMPLATE USING

           'ZEXCEL_TEMPLATE_CURR'

           '## ### ####'

           '######_###.XLSX'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM CLASS_EVENT .

  CREATE OBJECT GO_EVENT.

  SET HANDLER GO_EVENT->HANDLER_TOOLBAR FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLER_USER_COMMAND FOR GC_GRID.

  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED

  .

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED_FINISHED FOR GC_GRID.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_TOOLBAR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM ALV_HANDLER_TOOLBAR  USING    P_OBJECT TYPE REF TO CL_ALV_EVENT_TOOLBAR_SET

                                   P_INTERACTIVE.

  DATA : LS_TOOLBAR TYPE STB_BUTTON.



  LS_TOOLBAR-FUNCTION = 'SAVE'.

  LS_TOOLBAR-ICON = ICON_CHANGE. "se16N## icon #### #### ##

  LS_TOOLBAR-QUICKINFO = '##'.

  LS_TOOLBAR-TEXT      = '##'.



  APPEND LS_TOOLBAR TO P_OBJECT->MT_TOOLBAR.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DATA_CHANGED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM ALV_HANDLER_DATA_CHANGED  USING    P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                        P_ONF4

                                        P_ONF4_BEFORE

                                        P_ONF4_AFTER

                                        P_UCOMM.

  DATA : LS_MODI TYPE LVC_S_MODI.

  DATA : LV_LEN(02).



  CLEAR : LS_MODI, LV_LEN.



  LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.

    IF LS_MODI-FIELDNAME = 'UKURS'.

      READ TABLE GT_CURR INTO GS_CURR INDEX LS_MODI-ROW_ID.

      IF LS_MODI-VALUE IS INITIAL.

        "#####

      ENDIF.

      MODIFY GT_CURR FROM GS_CURR INDEX LS_MODI-ROW_ID.

      CLEAR GS_CURR.

    ENDIF.

  ENDLOOP.

  PERFORM REFRESH.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DATA_CHANGED_FINISHED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM ALV_DATA_CHANGED_FINISHED  USING    P_MODIFIED

                                         PT_GOOD_CELLS TYPE LVC_T_MODI.



  DATA : LS_MODI TYPE LVC_S_MODI.



  CLEAR : LS_MODI.



  LOOP AT PT_GOOD_CELLS INTO LS_MODI.

    IF LS_MODI-FIELDNAME = 'UKURS'.

      READ TABLE GT_CURR INTO GS_CURR INDEX LS_MODI-ROW_ID.



      CLEAR GS_CURR.

    ENDIF.

  ENDLOOP.

  PERFORM REFRESH.

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




*      I_SOFT_REFRESH =

*    EXCEPTIONS

*      FINISHED       = 1

*      others         = 2




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_USER_COMMAND

*&---------------------------------------------------------------------*




FORM ALV_HANDLER_USER_COMMAND  USING    P_UCOMM.

   CASE P_UCOMM.

     WHEN 'SAVE'.

       PERFORM MESSAGE_SAVE.

   ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  INSERT_DATA

*&---------------------------------------------------------------------*




FORM INSERT_DATA .

  LOOP AT GT_CURR INTO GS_CURR.

    MOVE-CORRESPONDING GS_CURR TO GS_CURR_SAVE.

    APPEND GS_CURR_SAVE TO GT_CURR_SAVE.

    WRITE : / GS_CURR_SAVE-GDATU.

  ENDLOOP.

  MODIFY ZTCURR01 FROM TABLE GT_CURR_SAVE.

  COMMIT WORK.

  MESSAGE '#######.' TYPE 'S'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MESSAGE_SAVE

*&---------------------------------------------------------------------*




FORM MESSAGE_SAVE .

  DATA LV_ANSWER TYPE C.



  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      TITLEBAR              = '##'

      TEXT_QUESTION         = '########?'

      TEXT_BUTTON_1         = 'YES'

      TEXT_BUTTON_2         = 'NO'

      DISPLAY_CANCEL_BUTTON = ' '

    IMPORTING

      ANSWER                = LV_ANSWER.



  IF LV_ANSWER = '1'.

    " YES ### #

    PERFORM INSERT_DATA.

    MESSAGE '#######.' TYPE 'S'.



  ELSEIF LV_ANSWER = '2'.

    " NO ### #

    MESSAGE '#######.' TYPE 'S'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  EXCLUDE_TOOLBAR_100

*&---------------------------------------------------------------------*




" #### ## ##

FORM EXCLUDE_TOOLBAR_100 .

  GS_EXCLUDE = CL_GUI_ALV_GRID=>MC_FC_LOC_INSERT_ROW.

  APPEND GS_EXCLUDE TO GT_EXCLUDE.



  GS_EXCLUDE = CL_GUI_ALV_GRID=>MC_FC_LOC_DELETE_ROW.

  APPEND GS_EXCLUDE TO GT_EXCLUDE.



  GS_EXCLUDE = CL_GUI_ALV_GRID=>MC_FC_LOC_APPEND_ROW.

  APPEND GS_EXCLUDE TO GT_EXCLUDE.

ENDFORM.