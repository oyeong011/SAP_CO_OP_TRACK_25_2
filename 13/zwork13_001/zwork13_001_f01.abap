
*&---------------------------------------------------------------------*

*&  Include           ZWORK13_001_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  XLSX_HANDLING

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM XLSX_HANDLING.

  IF P_DATE IS INITIAL.

    MESSAGE I000.

    RETURN.

  ENDIF.

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_OPEN_DIALOG  "### ###### ## ## ## ##"

    EXPORTING

      WINDOW_TITLE            = '## ## ##'

      DEFAULT_FILENAME        = '*.xlsx'

    CHANGING

      FILE_TABLE              = LV_FILE_TABLE

      RC                      = LV_RC.

    IF LV_RC > 0.           "# ### ## ### ##### ## #### ##"

      READ TABLE LV_FILE_TABLE INTO LV_FILE_NAME INDEX 1.

      IF SY-SUBRC = 0.

        P_FNAME = LV_FILE_NAME.  "## ## ### PARAMETER# ###"

      ENDIF.

    ENDIF.

  CALL FUNCTION 'ALSM_EXCEL_TO_INTERNAL_TABLE'

    EXPORTING

      FILENAME    = P_FNAME

      I_BEGIN_COL = 1

      I_BEGIN_ROW = 2

      I_END_COL   = 7

      I_END_ROW   = 9999

    TABLES

      INTERN      = GT_MAP_EXCEL

    EXCEPTIONS

      OTHERS      = 1.

  LOOP AT GT_MAP_EXCEL ASSIGNING <FS_EXCEL_LINE>.

    GS_FINAL-CRNAME = SY-UNAME.

    GS_FINAL-CRDATE = SY-DATUM.

    CASE <FS_EXCEL_LINE>-COL.

    WHEN 1.  "A# ###"

      GS_FINAL-KURST = 'M'.      "## ### ### M"

    WHEN 2.  "B# ###"

      GS_FINAL-FCURR = <FS_EXCEL_LINE>-VALUE.

    WHEN 3.  "C# ###"

      GS_FINAL-TCURR = <FS_EXCEL_LINE>-VALUE.

    WHEN 4.  "D# ###"

      GS_FINAL-GDATU = P_DATE.   "##### ##### ## #### ##"

    WHEN 5.  "E# ###"

      GS_FINAL-UKURS = <FS_EXCEL_LINE>-VALUE.

    WHEN 6.  "F# ###"

      GS_FINAL-FFACT = <FS_EXCEL_LINE>-VALUE.

    WHEN 7.  "G# ###"

      GS_FINAL-TFACT = <FS_EXCEL_LINE>-VALUE.

      IF GS_FINAL-FCURR = 'JPY' OR GS_FINAL-FCURR = 'VND'.

        GS_FINAL-FFACT = 100.   "## ## ## ## = 100

        GS_FINAL-TFACT = 1.     "## ## ## ## = 1

      ENDIF.

      APPEND GS_FINAL TO GT_FINAL.              "G### #### # # ### ## APPEND"

      CLEAR GS_FINAL.

    ENDCASE.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MAKE_BUTTON

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MAKE_BUTTON.

  I_FUNCTXT-ICON_ID = ICON_EXPORT.

  I_FUNCTXT-ICON_TEXT = '## ### ####'. "###"

  I_FUNCTXT-QUICKINFO = '## ### ####'. "### #### ### ###"

  SSCRFIELDS-FUNCTXT_01 = I_FUNCTXT.

ENDFORM.

FORM BUTTON_COMMAND .

  CASE SY-UCOMM. "## ## ## OK_CODE"

    WHEN 'FC01'. "1# ####"

      PERFORM DOWNLOAD_TEMPLATE.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DOWNLOAD_TEMPLATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DOWNLOAD_TEMPLATE.



  "1. WWWDATA ##### ### ## # ## ##

  SELECT SINGLE *

    FROM WWWDATA

    INTO CORRESPONDING FIELDS OF @LS_KEY

    WHERE OBJID = @LC_OBJID.



  IF SY-SUBRC = 0.

    CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_SAVE_DIALOG "##### ## ## ## ## ##"

      EXPORTING




*        WINDOW_TITLE      = LC_WIN_TITL      "## #### ##"




        DEFAULT_EXTENSION = 'xlsx'            "##### ### ## ###"

        DEFAULT_FILE_NAME = LC_DEF_FNAME      "### ## ### ##

      CHANGING

        FILENAME          = LV_FILE

        PATH              = LV_PATH

        FULLPATH          = LV_FUPATH.



    IF LV_FUPATH IS NOT INITIAL.              "#### #### ## ### #### ##"

      LV_DEST = LV_FUPATH.



      " 3. # ####(### #### ###) ####

      CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'

        EXPORTING

          KEY         = LS_KEY

          DESTINATION = LV_DEST.



      MESSAGE '## #### #########.' TYPE 'S'.

    ENDIF.

  ELSE.

    MESSAGE '## ##(ZTCURR_EXCEL)# WWWDATA# #### ####.' TYPE 'E'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SCREEN_HADLING

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SCREEN_HADLING .

  LOOP AT SCREEN.

  IF SCREEN-GROUP1 = 'M'.

   SCREEN-INPUT = '0'. "## ### ## #### ##, M## ###### ##### ##"

   MODIFY SCREEN.

  ENDIF.

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




FORM CREATE_OBJECT.

  CREATE OBJECT GC_DOCKING

    EXPORTING




*      PARENT                      =




      REPID                       = SY-REPID

      DYNNR                       = SY-DYNNR




*      SIDE                        = DOCK_AT_LEFT




      EXTENSION                   = 2000




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

CREATE OBJECT GC_GRID

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




FORM FIELD_CATALOG.

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

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

  GS_FIELDCAT-SCRTEXT_M = '## ## ###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'UKURS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-JUST = 'L'.

  GS_FIELDCAT-OUTPUTLEN = 14.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-DECIMALS = 5.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'FFACT'.

  GS_FIELDCAT-SCRTEXT_M = '########'.

  GS_FIELDCAT-OUTPUTLEN = 12.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'TFACT'.

  GS_FIELDCAT-SCRTEXT_M = '########'.

  GS_FIELDCAT-OUTPUTLEN = 12.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'CRNAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



   CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'CRDATE'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-OUTPUTLEN = 10.

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

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

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

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CLASS_EVENT.

  CREATE OBJECT GO_EVENT.

  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED




*    EXCEPTIONS

*      ERROR      = 1

*      others     = 2




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED_FINISHED FOR GC_GRID.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY .

CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

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

    IT_OUTTAB                     = GT_FINAL

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

*&      Form  REFRESH

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM REFRESH.

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




FORM ALV_HANDLER_DATA_CHANGED  USING P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                     P_ONF4

                                     P_ONF4_BEFORE

                                     P_ONF4_AFTER

                                     P_UCOMM.

  DATA : LS_MODI TYPE LVC_S_MODI.



  CLEAR : LS_MODI.



  LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.

    IF LS_MODI-FIELDNAME = 'UKURS'.                    "## ####"

      READ TABLE GT_FINAL INTO GS_FINAL INDEX LS_MODI-ROW_ID.

      IF SY-SUBRC <> 0.

        CONTINUE.

      ENDIF.

      IF LS_MODI-VALUE IS INITIAL.

        MESSAGE '### ## #####.' TYPE 'E'.

      ENDIF.

      GS_FINAL-UKURS = LS_MODI-VALUE.

      MODIFY GT_FINAL FROM GS_FINAL INDEX LS_MODI-ROW_ID.       "################"

      CLEAR GS_FINAL.

    ENDIF.

  ENDLOOP.

  PERFORM REFRESH.                                      "######"

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DATA_CHANGED_FINISHED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_MODIFIED  text

*      -->P_ET_GOOD_CELLS  text

*----------------------------------------------------------------------*




FORM ALV_DATA_CHANGED_FINISHED USING P_MODIFIED

                                     PT_GOOD_CELLS TYPE LVC_T_MODI.

  DATA : LS_MODI TYPE LVC_S_MODI.



  CLEAR : LS_MODI.



  LOOP AT PT_GOOD_CELLS INTO LS_MODI.

    IF LS_MODI-FIELDNAME = 'UKURS'.

      READ TABLE GT_FINAL INTO GS_FINAL INDEX LS_MODI-ROW_ID.

      CLEAR GS_FINAL.

    ENDIF.

  ENDLOOP.

  PERFORM REFRESH.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  BUTTON_COMMAND

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  POPUP_MESSAGE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM POPUP_MESSAGE.

  DATA : LV_YESNO TYPE C.

  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

     TITLEBAR                    = '## ##'




*     DIAGNOSE_OBJECT             = ' '




      TEXT_QUESTION               = '##### ## ########?'

     TEXT_BUTTON_1               = 'YES'




*     ICON_BUTTON_1               = ' '




     TEXT_BUTTON_2               = 'NO'




*     ICON_BUTTON_2               = ' '

*     DEFAULT_BUTTON              = '1'




     DISPLAY_CANCEL_BUTTON       = ' '  "#### ##"




*     USERDEFINED_F1_HELP         = ' '

*     START_COLUMN                = 25

*     START_ROW                   = 6

*     POPUP_TYPE                  =

*     IV_QUICKINFO_BUTTON_1       = ' '

*     IV_QUICKINFO_BUTTON_2       = ' '




   IMPORTING

     ANSWER                      = LV_YESNO




*   TABLES

*     PARAMETER                   =

*   EXCEPTIONS

*     TEXT_NOT_FOUND              = 1

*     OTHERS                      = 2




            .

  IF LV_YESNO = '1'.

    MODIFY ZTCURR13 FROM TABLE GT_FINAL.

    MESSAGE '#######' TYPE 'S'.

  ELSEIF LV_YESNO = '2'.

    MESSAGE '#######' TYPE 'S'.

  ENDIF.

ENDFORM.