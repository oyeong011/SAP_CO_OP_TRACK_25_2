
*&---------------------------------------------------------------------*

*&  Include           ZWORK21_001_F01

*&---------------------------------------------------------------------*






FORM SET_SCREEN .

    LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.

      SCREEN-INPUT = SPACE. "M# ## #### ##

      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .

  "EXCEL ## #### FUNCTION #### --> INTERNAL TABLE# ##

 CALL FUNCTION 'ALSM_EXCEL_TO_INTERNAL_TABLE'

    EXPORTING

      FILENAME        = P_FILE

      I_BEGIN_COL     = 1

      I_BEGIN_ROW     = 2

      I_END_COL       = 7

      I_END_ROW       = 10

    TABLES

      INTERN          = T_RAW_EXCEL

    EXCEPTIONS

      INCONSISTENT_PARAMETERS = 1

      UPLOAD_OLE              = 2

      OTHERS                  = 3.

 "## ## ###

 CLEAR GT_TCURR.



  FIELD-SYMBOLS: <FS> TYPE ANY.

  "EXCEL## ROW ### ## GS_TCURR### #### ##

  DATA: LV_INDEX TYPE I,

      LV_VALUE TYPE STRING.



"EXCEL## ROW ### ## GS_TCURR ### #### ##

LOOP AT T_RAW_EXCEL INTO S_RAW_EXCEL.



  LV_INDEX = S_RAW_EXCEL-COL.

  LV_VALUE = S_RAW_EXCEL-VALUE.



  "##### ## ### ## ##

  ASSIGN COMPONENT LV_INDEX OF STRUCTURE GS_TCURR TO <FS>.

  IF SY-SUBRC = 0.

    <FS> = LV_VALUE.

  ENDIF.



  "ROW# ### --> GT_TCURR# APPEND

  AT END OF ROW.

    APPEND GS_TCURR TO GT_TCURR.

    CLEAR GS_TCURR.

  ENDAT.



ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODI_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DATA .

  "INTERNAL TABLE# ## ##### ###### ## EX)###, ###, KURST

  LOOP AT GT_TCURR INTO GS_TCURR.

    GS_TCURR-GDATU = P_DATE.

    GS_TCURR-KURST = 'M'.

    GS_TCURR-MODIFER = SY-UNAME.

    GS_TCURR-EDATE = SY-DATUM.

    MODIFY GT_TCURR FROM GS_TCURR.

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

  "DOCKING CONTAINER ##

CREATE OBJECT GC_DOCKING

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

*    OTHERS                      = 6




    .

"ALV_GRID ## ##

CREATE OBJECT GC_GRID

  EXPORTING




*    I_SHELLSTYLE      = 0

*    I_LIFETIME        =




    I_PARENT          = GC_DOCKING




*    I_APPL_EVENTS     = SPACE

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



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELDCAT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*






"ALV ### ## FIELD CATALOG ##

FORM FIELDCAT .

 CLEAR : GS_FIELDCAT, GT_FIELDCAT.

 GS_FIELDCAT-COL_POS = 1.

 GS_FIELDCAT-COLTEXT = '####'.

 GS_FIELDCAT-FIELDNAME = 'KURST'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 2.

 GS_FIELDCAT-COLTEXT = '####'.

 GS_FIELDCAT-FIELDNAME = 'FCURR'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 3.

 GS_FIELDCAT-COLTEXT = '####'.

 GS_FIELDCAT-FIELDNAME = 'TCURR'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 4.

 GS_FIELDCAT-COLTEXT = '####'.

 GS_FIELDCAT-FIELDNAME = 'GDATU'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 5.

 GS_FIELDCAT-COLTEXT = '##'.

 GS_FIELDCAT-DECIMALS = 5.

 GS_FIELDCAT-FIELDNAME = 'UKURS'.

 GS_FIELDCAT-OUTPUTLEN = 15. "### ## ### ##

 GS_FIELDCAT-EDIT = 'X'.  "### EDIT# ##### ### EDIT ##

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 6.

 GS_FIELDCAT-COLTEXT = '########'.

 GS_FIELDCAT-FIELDNAME = 'FFACT'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 7.

 GS_FIELDCAT-COLTEXT = '########'.

 GS_FIELDCAT-FIELDNAME = 'TFACT'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 8.

 GS_FIELDCAT-COLTEXT = '###'.

 GS_FIELDCAT-FIELDNAME = 'MODIFER'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR : GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 9.

 GS_FIELDCAT-COLTEXT = '###'.

 GS_FIELDCAT-FIELDNAME = 'EDATE'.

 GS_FIELDCAT-OUTPUTLEN = 15. "## # #### ## ## OUTPUTLEN### ## ##

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

  "ALV_VARIANT ## # ##

  CLEAR : GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

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

    IT_OUTTAB                     = GT_TCURR

    IT_FIELDCATALOG               = GT_FIELDCAT

    IT_SORT                       = GT_SORT




*    IT_FILTER                     =

*  EXCEPTIONS

*    INVALID_PARAMETER_COMBINATION = 1

*    PROGRAM_ERROR                 = 2

*    TOO_MANY_LINES                = 3

*    OTHERS                        = 4




        .

IF SY-SUBRC <> 0.




* IMPLEMENT SUITABLE ERROR HANDLING HERE




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




FORM DOWNLOAD_TEMPLATE.

  DATA : LV_RC TYPE SY-SUBRC.



  " SMW0## #### ##

  SELECT SINGLE *

    INTO CORRESPONDING FIELDS OF GS_KEY FROM WWWDATA

    WHERE OBJID = 'ZTEMPLATE21'.



  IF SY-SUBRC <> 0.

    MESSAGE 'NO TEMPLATE.' TYPE 'E'.

    EXIT.

  ENDIF.



  "#### ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_SAVE_DIALOG(

    EXPORTING

      WINDOW_TITLE = '### ##'

      DEFAULT_EXTENSION = 'CL_GUI_FRONTEND_SERVICES=>FILETYPE_EXCEL' "#####

      DEFAULT_FILE_NAME = '##_###'

      FILE_FILTER = CL_GUI_FRONTEND_SERVICES=>FILETYPE_EXCEL

    CHANGING

      FILENAME = GV_FILE

      PATH = GV_PATH

      FULLPATH = GV_FULLPATH

    ).

  IF SY-SUBRC <> 0.

    MESSAGE ID SY-MSGID TYPE 'S' NUMBER SY-MSGNO

    WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4

        DISPLAY LIKE 'E'.

    ENDIF.

  GV_DEST = GV_FULLPATH.



  "## ####

  CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'

    EXPORTING

      KEY               = GS_KEY

      DESTINATION       = GV_DEST

    IMPORTING

      RC                = LV_RC.



  IF SY-SUBRC = 0.

    MESSAGE '### #### ##' TYPE 'S'.

  ENDIF.

ENDFORM.




**&---------------------------------------------------------------------*

**&      Form  SET_FUNCTION_KEY

**&---------------------------------------------------------------------*

**       text

**----------------------------------------------------------------------*

**  -->  p1        text

**  <--  p2        text

**----------------------------------------------------------------------*






 FORM SET_FUNCTION_KEY.

"SELECTION-SCREEN ## ## ## ICON ### ### ## FORM

  G_FUNCTION_KEY-ICON_ID   = ICON_EXPORT.

  G_FUNCTION_KEY-ICON_TEXT = '### ####'.

  G_FUNCTION_KEY-TEXT      = '### ####'.

  SSCRFIELDS-FUNCTXT_01    = G_FUNCTION_KEY.

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

"ALV_GRID ## ##



LS_STABLE-ROW = 'X'.

LS_STABLE-COL = 'X'.



  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE      = LS_STABLE.



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

  "ALV_EVENT_HANDLER ##

  CREATE OBJECT GO_EVENT.

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID.



  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED     .

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DATA_MODIFIED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_ER_DATA_CHANGED  text

*      -->P_E_ONF4  text

*      -->P_E_ONF4_BEFORE  text

*      -->P_E_ONF4_AFTER  text

*      -->P_E_UCOMM  text

*----------------------------------------------------------------------*






FORM ALV_HANDLER_DATA_MODIFIED USING    P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                        P_ONF4

                                        P_ONF4_BEFORE

                                        P_ONF4_AFTER

                                        P_UCOMM.



DATA : LS_MODI TYPE LVC_S_MODI.

CLEAR : LS_MODI.

"ALV_# ## # GT_TCURR ## ### ##

LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.

  "UKURS# ### #### ##

  IF LS_MODI-FIELDNAME = 'UKURS'.

     READ TABLE GT_TCURR INTO GS_TCURR INDEX LS_MODI-ROW_ID.

     MODIFY GT_TCURR FROM GS_TCURR INDEX LS_MODI-ROW_ID.

     CLEAR GS_TCURR.

 ENDIF.

ENDLOOP.



  PERFORM REFRESH.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SAVE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




"##### ## # ### ZTCURR21 #### ##.

FORM SAVE_DATA.

CLEAR : GT_SAVE.

CLEAR : GS_SAVE.



LOOP AT GT_TCURR INTO GS_TCURR.

 MOVE-CORRESPONDING GS_TCURR TO GS_SAVE.

 APPEND GS_SAVE TO GT_SAVE.

ENDLOOP.



MODIFY ZTCURR21 FROM TABLE GT_SAVE.



ENDFORM.