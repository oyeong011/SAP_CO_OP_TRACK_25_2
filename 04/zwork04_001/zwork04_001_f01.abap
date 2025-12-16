
*&---------------------------------------------------------------------*

*&  Include           ZWORK04_001_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_INIT

*&---------------------------------------------------------------------*




FORM SET_INIT .

  P_DATE = SY-DATUM. " #### ##### ## ##



  SSCRFIELDS-FUNCTXT_01 = '##### ####'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_SCR_OUTPUT

*&---------------------------------------------------------------------*




FORM SET_SCR_OUTPUT .

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.

      SCREEN-INPUT = '0'. " ## ### ## ##

    ENDIF.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  EXCEL_TEMPLATE_DOWNLOAD

*&---------------------------------------------------------------------*




FORM EXCEL_TEMPLATE_DOWNLOAD .

  DATA LS_KEY TYPE WWWDATATAB.

  DATA : LV_FILE TYPE STRING,

         LV_PATH TYPE STRING,

         LV_FULLPATH TYPE STRING.

  DATA LV_DEST TYPE RLGRAP-FILENAME.



  " ### ## #### (SMW0# ##### #)

  SELECT SINGLE * INTO CORRESPONDING FIELDS OF LS_KEY

    FROM WWWDATA

    WHERE OBJID = 'ZWORK001_EXCEL_TEMPLATE'.



  " #### ## ### ###

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_SAVE_DIALOG

    EXPORTING

      WINDOW_TITLE              = '### ##'

      DEFAULT_EXTENSION         = 'XLSX'

      DEFAULT_FILE_NAME         = '## ###'

    CHANGING

      FILENAME                  = LV_FILE

      PATH                      = LV_PATH

      FULLPATH                  = LV_FULLPATH.



  LV_DEST = LV_FULLPATH.  " ####



  CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'

    EXPORTING

      KEY               = LS_KEY

      DESTINATION       = LV_DEST.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_SCR_ON_VALUE_REQUEST

*&---------------------------------------------------------------------*




FORM SET_SCR_ON_VALUE_REQUEST .

  " F4 #### ## ## ##

  CALL FUNCTION 'F4_FILENAME'

    IMPORTING

      FILE_NAME = P_FILE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_MANDATORY

*&---------------------------------------------------------------------*




FORM CHECK_MANDATORY .

  " ####, #### ##### ##

  IF P_DATE IS INITIAL OR P_FILE IS INITIAL.

    MESSAGE I000.

    STOP.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_EXCEL_DATA

*&---------------------------------------------------------------------*




FORM GET_EXCEL_DATA .

  " ## RAW ### ##

  CALL FUNCTION 'ALSM_EXCEL_TO_INTERNAL_TABLE'

    EXPORTING

      FILENAME                      = P_FILE

      I_BEGIN_COL                   = 1

      I_BEGIN_ROW                   = 2

      I_END_COL                     = 7

      I_END_ROW                     = 1000

    TABLES

      INTERN                        = GT_RAW.



  " ## RAW #### ZTCURR04 ### ##

  CLEAR : GS_ZTCURR04, GT_ZTCURR04.

  LOOP AT GT_RAW INTO GS_RAW.

    CASE GS_RAW-COL.

      WHEN 1.

        GS_ZTCURR04-KURST = 'M'.

      WHEN 2.

        GS_ZTCURR04-FCURR = GS_RAW-VALUE.

      WHEN 3.

        GS_ZTCURR04-TCURR = GS_RAW-VALUE.

      WHEN 4.

        GS_ZTCURR04-GDATU = P_DATE.

      WHEN 5.

        GS_ZTCURR04-UKURS = GS_RAW-VALUE.

      WHEN 6.

        GS_ZTCURR04-FFACT = GS_RAW-VALUE.

      WHEN 7. " ### ##

        GS_ZTCURR04-TFACT = GS_RAW-VALUE.

        GS_ZTCURR04-CRNAME = SY-UNAME. " ###

        GS_ZTCURR04-CRDATE = SY-DATUM. " ###

        APPEND GS_ZTCURR04 TO GT_ZTCURR04.

        CLEAR GS_ZTCURR04.

    ENDCASE.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*




FORM CREATE_OBJECT .

  CREATE OBJECT GC_DOCKING

    EXPORTING

      REPID                       = SY-REPID  " #### ID

      DYNNR                       = SY-DYNNR  " ### ##

      EXTENSION                   = 2000.     " ## ##



  CREATE OBJECT GC_GRID

    EXPORTING

      I_PARENT          = GC_DOCKING.

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



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'FCURR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'TCURR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'GDATU'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'UKURS'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-OUTPUTLEN = '15'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-DECIMALS = '5'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'FFACT'.

  GS_FIELDCAT-COLTEXT = '########'.

  GS_FIELDCAT-OUTPUTLEN = '15'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'TFACT'.

  GS_FIELDCAT-COLTEXT = '########'.

  GS_FIELDCAT-OUTPUTLEN = '15'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'CRNAME'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'CRDATE'.

  GS_FIELDCAT-COLTEXT = '###'.

  GS_FIELDCAT-OUTPUTLEN = '15'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*




FORM ALV_LAYOUT .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.          " ## ## # ### ##



  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY .

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_LAYOUT                     = GS_LAYOUT

      IS_VARIANT                    = GS_VARIANT

      I_SAVE                        = 'A'

    CHANGING

      IT_OUTTAB                     = GT_ZTCURR04

      IT_FIELDCATALOG               = GT_FIELDCAT

      .

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*




FORM REFRESH .

  DATA LS_STABLE TYPE LVC_S_STBL.



  " #### USERCOMMAND ## ### # CURSOR## ###

  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE      = LS_STABLE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DATA_CHANGED_FINISHED

*&---------------------------------------------------------------------*




FORM ALV_DATA_CHANGED_FINISHED  USING    P_MODIFIED

                                         PT_GOOD_CELLS TYPE LVC_T_MODI.

  PERFORM REFRESH.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*




FORM CLASS_EVENT .

  " DATA_CHANGED ## ## ##

  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.



  CREATE OBJECT GO_EVENT.



  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED_FINISHED FOR GC_GRID.

ENDFORM.