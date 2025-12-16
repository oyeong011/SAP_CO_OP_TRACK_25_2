
*&---------------------------------------------------------------------*

*&  Include           ZMMR13_001_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SCREEN_CHANGE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SCREEN_CHANGE .

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.

      IF P_R1 = 'X'.

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ELSEIF SCREEN-GROUP1 = 'M2'.

      IF P_R2 = 'X'.

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_MANDATORY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_MANDATORY.

  IF P_R1 = 'X'.

    IF P1 IS INITIAL OR P2 IS INITIAL.

      MESSAGE S000 DISPLAY LIKE 'E'.

      LEAVE LIST-PROCESSING.

    ENDIF.

    GV_BUKRS = P1.

    GV_KTOKK = P2.

    PERFORM GET_LINFR CHANGING GV_LIFNR.

  ELSEIF P_R2 = 'X'.

    IF P1 IS INITIAL OR P3 IS INITIAL.

      MESSAGE S000 DISPLAY LIKE 'E'.

      LEAVE LIST-PROCESSING.

    ENDIF.

    GV_LIFNR = P3.

    GV_BUKRS = P1.

  ENDIF.

ENDFORM.




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

     TITLEBAR                    = '### ##'




*     DIAGNOSE_OBJECT             = ' '




      TEXT_QUESTION               = '#### ########?'

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

  IF LV_YESNO = '2'.

    MESSAGE '#######' TYPE 'S'.

    STOP.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  INIT_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM INIT_DATA.

    SELECT * FROM ZLFA1_13 AS A

    INNER JOIN ZLFB1_13 AS B ON A~LIFNR = B~LIFNR

    INNER JOIN ZLFM1_13 AS C ON A~LIFNR = C~LIFNR

    INTO CORRESPONDING FIELDS OF TABLE GT_ORDER

    WHERE A~LIFNR = P3    "#####"

    AND B~BUKRS = P1.     "####

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

  GS_FIELDCAT-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT-SCRTEXT_M = '#####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'NAME1'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'LAND1'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'KTOKK'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  DATA : LV_COL_POS TYPE I VALUE 5. "## ## ## ##"



  IF GS_ORDER-KTOKK = '3000'.

    GS_FIELDCAT-COL_POS = 5.

    GS_FIELDCAT-FIELDNAME = 'STCD1'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

    LV_COL_POS = LV_COL_POS + 1.

  ELSEIF GS_ORDER-KTOKK = '2000'. "2000# ## ## X"

  ELSE.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 5.

    GS_FIELDCAT-FIELDNAME = 'STCD2'.

    GS_FIELDCAT-SCRTEXT_M = '#####'.

    GS_FIELDCAT-EDIT = 'X'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

    LV_COL_POS = LV_COL_POS + 1.

  ENDIF.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = LV_COL_POS.

  GS_FIELDCAT-FIELDNAME = 'STRAS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  LV_COL_POS = LV_COL_POS + 1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = LV_COL_POS.

  GS_FIELDCAT-FIELDNAME = 'BUKRS'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  LV_COL_POS = LV_COL_POS + 1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = LV_COL_POS.

  GS_FIELDCAT-FIELDNAME = 'AKONT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  LV_COL_POS = LV_COL_POS + 1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = LV_COL_POS.

  GS_FIELDCAT-FIELDNAME = 'ZTERM'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  LV_COL_POS = LV_COL_POS + 1.



  GS_FIELDCAT-COL_POS = LV_COL_POS.

  GS_FIELDCAT-FIELDNAME = 'EKORG'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  LV_COL_POS = LV_COL_POS + 1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = LV_COL_POS.

  GS_FIELDCAT-FIELDNAME = 'EKGRP'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  LV_COL_POS = LV_COL_POS + 1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = LV_COL_POS.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-SCRTEXT_M = '######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  LV_COL_POS = LV_COL_POS + 1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = LV_COL_POS.

  GS_FIELDCAT-FIELDNAME = 'MWSKZ'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

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

  GS_LAYOUT-NO_TOOLBAR = 'X'.

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

    IF LS_MODI-FIELDNAME = 'STCD2'.

      READ TABLE GT_ORDER INTO GS_ORDER INDEX LS_MODI-ROW_ID.

      IF SY-SUBRC <> 0.

        CONTINUE.

      ENDIF.

      IF LS_MODI-VALUE IS INITIAL.

        MESSAGE '### ### ## #####.' TYPE 'E'.

      ENDIF.

      GS_ORDER-STCD2 = LS_MODI-VALUE.

      MODIFY GT_ORDER FROM GS_ORDER INDEX LS_MODI-ROW_ID.       "################"

      CLEAR GS_ORDER.

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

    IF LS_MODI-FIELDNAME = 'STCD2'.

      READ TABLE GT_ORDER INTO GS_ORDER INDEX LS_MODI-ROW_ID.

      MOVE-CORRESPONDING GS_ORDER TO GS_LFA1.

    ENDIF.

  ENDLOOP.

  PERFORM REFRESH.

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

    IT_OUTTAB                     = GT_ORDER

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

*&      Form  CHECK_INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_INPUT.

  IF GV_NAME1 IS INITIAL.

    MESSAGE '##### ######.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE TO SCREEN 100.

  ELSEIF GV_LAND1 IS INITIAL.

    MESSAGE '#### ######.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE TO SCREEN 100.

  ELSEIF GV_KTOKK IS INITIAL.

    MESSAGE '#####(####)# ######' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE TO SCREEN 100.

  ELSEIF GV_STCD1 IS INITIAL AND GV_KTOKK = '3000'.    "## ### ## ## ##, 3000## ## ##"

    MESSAGE '##### ######' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE TO SCREEN 100.

  ELSEIF GV_STCD2 IS INITIAL AND GV_KTOKK <> '2000'.    "## ### ## ## ##, 2000## ## ### OK"

    MESSAGE '###### ######' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE TO SCREEN 100.

  ELSEIF GV_STRAS IS INITIAL.

    MESSAGE '### ######' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE TO SCREEN 100.

  ELSEIF GV_BUKRS IS INITIAL.

    MESSAGE '##### ######' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE TO SCREEN 100.

  ELSEIF GV_AKONT IS INITIAL.

    MESSAGE '##### ######' TYPE 'S' DISPLAY LIKE 'E'. "SERCH HELP"

    LEAVE TO SCREEN 100.

  ELSEIF GV_ZTERM IS INITIAL.

    MESSAGE '##### ######' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE TO SCREEN 100.

  ELSEIF GV_EKORG IS INITIAL.

    MESSAGE '##### ######' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE TO SCREEN 100.

  ELSEIF GV_EKGRP IS INITIAL.

    MESSAGE '##### ######' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE TO SCREEN 100.

  ELSEIF GV_WAERS IS INITIAL.

    MESSAGE '####### ######' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE TO SCREEN 100.

  ELSEIF GV_MWSKZ IS INITIAL.

    MESSAGE '##### ######' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE TO SCREEN 100.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  INSERT_TABLE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM INSERT_TABLE.

  CLEAR : GS_LFA1, GS_LFB1, GS_LFM1.

                                  "GS_LFA1"

  GS_LFA1-LIFNR = GV_LIFNR.       "#####"

  GS_LFA1-NAME1 = GV_NAME1.       "####"

  GS_LFA1-LAND1 = GV_LAND1.       "###"

  GS_LFA1-KTOKK = GV_KTOKK.       "#####, ####"

  GS_LFA1-STCD1 = GV_STCD1.       "####"

  GS_LFA1-STCD2 = GV_STCD2.       "#####"

  GS_LFA1-STRAS = GV_STRAS.       "##"



                                  "GS_LFB1"

  GS_LFB1-LIFNR = GV_LIFNR.       "#####"

  GS_LFB1-BUKRS = GV_BUKRS.       "####"

  GS_LFB1-LOEVM = ' '.            "#####, #####"

  GS_LFB1-AKONT = GV_AKONT.       "####"

  GS_LFB1-ZTERM = GV_ZTERM.

                                  "GS_LFM1"

  GS_LFM1-LIFNR = GV_LIFNR.       "#####"

  GS_LFM1-EKORG = GV_EKORG.       "####"

  GS_LFM1-LOEVM = ' '.            "#####, #####"

  GS_LFM1-EKGRP = GV_EKGRP.       "####"

  GS_LFM1-WAERS = GV_WAERS.       "######"

  GS_LFM1-MWSKZ = GV_MWSKZ.       "####"



  INSERT ZLFA1_13 FROM GS_LFA1.

  INSERT ZLFB1_13 FROM GS_LFB1.

  INSERT ZLFM1_13 FROM GS_LFM1.

  IF SY-SUBRC <> 0.

    MESSAGE '### ## ##' TYPE 'E'.

    ROLLBACK WORK.

  ELSEIF SY-SUBRC = 0.

    MESSAGE '### ## ##' TYPE 'S'.

    LEAVE TO SCREEN 0.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_LINFR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      <--P_GV_LIFNR  text

*----------------------------------------------------------------------*




FORM GET_LINFR CHANGING P_LIFNR.

  DATA LV_LINFR TYPE N LENGTH 10.



  CALL FUNCTION 'NUMBER_GET_NEXT'

    EXPORTING

      NR_RANGE_NR = '01'

      OBJECT      = 'ZVENDER'  "1000000000 ~ 9999999999"

    IMPORTING

      NUMBER      = LV_LINFR.

  IF SY-SUBRC <> 0.

    MESSAGE '## ## ## ##' TYPE 'E'.

  ENDIF.

  P_LIFNR = LV_LINFR.

ENDFORM.