
*&---------------------------------------------------------------------*

*&  INCLUDE           ZMMR01_002_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      FORM  INITIALIZATION

*&---------------------------------------------------------------------*

*       TEXT

*----------------------------------------------------------------------*

*  -->  P1        TEXT

*  <--  P2        TEXT

*----------------------------------------------------------------------*




FORM INITIALIZATION .

  P_LIFNR = 1000000000.

  P_BUKRS = 1000.

  P_BEDAT = SY-DATUM.

  P_EBELN = 4500000001.



ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  SELECTION_SCREEN_OUTPUT

*&---------------------------------------------------------------------*

*       TEXT

*----------------------------------------------------------------------*

*  -->  P1        TEXT

*  <--  P2        TEXT

*----------------------------------------------------------------------*




FORM SELECTION_SCREEN_OUTPUT .

  LOOP AT SCREEN.



    IF SCREEN-GROUP1 = 'M1'.  "###

      IF P_R1 = 'X'.          "##

        SCREEN-ACTIVE = '1'.

      ELSEIF P_R2 = 'X'.      "##

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.



    IF SCREEN-GROUP1 = 'M2'.  "#####

      IF P_R1 = 'X'.          "##

        SCREEN-ACTIVE = '0'.

      ELSEIF P_R2 = 'X'.      "##

        SCREEN-ACTIVE = '1'.

      ENDIF.

    ENDIF.



    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  CHECK_MANDATORY

*&---------------------------------------------------------------------*

*       TEXT

*----------------------------------------------------------------------*

*  -->  P1        TEXT

*  <--  P2        TEXT

*----------------------------------------------------------------------*




FORM CHECK_MANDATORY .

  IF P_R1 = 'X'.



     IF P_LIFNR IS INITIAL.

       MESSAGE S008 WITH TEXT-M01 DISPLAY LIKE C_E.

       LEAVE LIST-PROCESSING.

     ENDIF.



     IF P_BUKRS IS INITIAL.

       MESSAGE S008 WITH TEXT-M02 DISPLAY LIKE C_E.

       LEAVE LIST-PROCESSING.

     ENDIF.



     IF P_BEDAT IS INITIAL.

       MESSAGE S008 WITH TEXT-M03 DISPLAY LIKE C_E.

       LEAVE LIST-PROCESSING.

     ENDIF.



   ELSEIF P_R2 = 'X'.



     IF P_LIFNR IS INITIAL.

       MESSAGE S008 WITH TEXT-M01 DISPLAY LIKE C_E.

       LEAVE LIST-PROCESSING.

     ENDIF.



     IF P_BUKRS IS INITIAL.

       MESSAGE S008 WITH TEXT-M02 DISPLAY LIKE C_E.

       LEAVE LIST-PROCESSING.

     ENDIF.



     IF P_EBELN IS INITIAL.

       MESSAGE S008 WITH TEXT-M04 DISPLAY LIKE C_E.

       LEAVE LIST-PROCESSING.

     ENDIF.



   ELSE.

     LEAVE LIST-PROCESSING.

   ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  CHECK_SELECTION_DATA

*&---------------------------------------------------------------------*

*       TEXT

*----------------------------------------------------------------------*

*  -->  P1        TEXT

*  <--  P2        TEXT

*----------------------------------------------------------------------*




FORM CHECK_SELECTION_DATA .

  IF P_R1 = 'X'.

    GV_MODE = 'CREATE'.

  ELSEIF P_R2 = 'X'.

    GV_MODE = 'DISPLAY'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  INIT_DATA

*&---------------------------------------------------------------------*

*       TEXT

*----------------------------------------------------------------------*

*  -->  P1        TEXT

*  <--  P2        TEXT

*----------------------------------------------------------------------*




FORM INIT_DATA .

  " LFA1 (## ###)

  GS_HEADER_100-LIFNR     = GS_LFA1-LIFNR.

  GS_HEADER_100-LIFNR_TX  = GS_LFA1-NAME1.

  GS_HEADER_100-LAND1     = GS_LFA1-LAND1.



  " LFB1 (#### ###)

  GS_HEADER_100-PUR_LOEVM = GS_LFB1-LOEVM.



  " LFM1 (#### ###)

  GS_HEADER_100-WAERS     = GS_LFM1-WAERS.

  GS_HEADER_100-PUR_WAERS = GS_LFM1-WAERS.

  GS_HEADER_100-PUR_MWSKZ = GS_LFM1-MWSKZ.

  GS_HEADER_100-EKORG     = GS_LFM1-EKORG.

  GS_HEADER_100-EKGRP     = GS_LFM1-EKGRP.



  GS_HEADER_100-BUKRS     = P_BUKRS.

  GS_HEADER_100-BEDAT     = P_BEDAT.



  MOVE-CORRESPONDING GS_HEADER_100 TO GS_EKKO.



ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  CALL_SCREEN

*&---------------------------------------------------------------------*

*       TEXT

*----------------------------------------------------------------------*

*  -->  P1        TEXT

*  <--  P2        TEXT

*----------------------------------------------------------------------*




FORM CALL_SCREEN .

  CALL SCREEN 100.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       TEXT

*----------------------------------------------------------------------*

*  -->  P1        TEXT

*  <--  P2        TEXT

*----------------------------------------------------------------------*




FORM CREATE_OBJECT .

  CREATE OBJECT GC_CUSTOM

    EXPORTING




*      PARENT                      =




      CONTAINER_NAME              = 'CON1'




*      STYLE                       =

*      LIFETIME                    = LIFETIME_DEFAULT

*      REPID                       =

*      DYNNR                       =

*      NO_AUTODEF_PROGID_DYNNR     =

*    EXCEPTIONS

*      CNTL_ERROR                  = 1

*      CNTL_SYSTEM_ERROR           = 2

*      CREATE_ERROR                = 3

*      LIFETIME_ERROR              = 4

*      LIFETIME_DYNPRO_DYNPRO_LINK = 5

*      OTHERS                      = 6




      .

  CREATE OBJECT GC_GRID

    EXPORTING




*      I_SHELLSTYLE      = 0

*      I_LIFETIME        =




      I_PARENT          = GC_CUSTOM.




*      I_APPL_EVENTS     = SPACE

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

*      OTHERS            = 5




      .

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  FIELD_CATALOG

*&---------------------------------------------------------------------*

*       TEXT

*----------------------------------------------------------------------*

*  -->  P1        TEXT

*  <--  P2        TEXT

*----------------------------------------------------------------------*




FORM FIELD_CATALOG.

  CLEAR : GS_FIELDCAT,GT_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 1.

  GS_FIELDCAT-FIELDNAME = 'EBELP'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-KEY       = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 2.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-REF_TABLE = 'ZEKPO01'.

  GS_FIELDCAT-REF_FIELD = 'MATNR'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-KEY       = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 20.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 3.

  GS_FIELDCAT-FIELDNAME = 'MAKTX'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-OUTPUTLEN = 16.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 4.

  GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-REF_TABLE = 'EBAN'.

  GS_FIELDCAT-REF_FIELD = 'MENGE'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 5.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 6.

  GS_FIELDCAT-FIELDNAME = 'NETPR'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  GS_FIELDCAT-REF_TABLE = 'ZEKPO01'.

  GS_FIELDCAT-REF_FIELD = 'NETPR'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 7.

  GS_FIELDCAT-FIELDNAME = 'NETWR'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 8.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 9.

  GS_FIELDCAT-FIELDNAME = 'MWSKZ'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-REF_TABLE = 'ZEKPO01'.

  GS_FIELDCAT-REF_FIELD = 'MWSKZ'.

  GS_FIELDCAT-OUTPUTLEN = 8.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 10.

  GS_FIELDCAT-FIELDNAME = 'WERKS'.

  GS_FIELDCAT-COLTEXT = '###'.

  GS_FIELDCAT-REF_TABLE = 'ZEKPO01'.

  GS_FIELDCAT-REF_FIELD = 'WERKS'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 11.

  GS_FIELDCAT-FIELDNAME = 'LGORT'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-REF_TABLE = 'ZEKPO01'.

  GS_FIELDCAT-REF_FIELD = 'LGORT'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 12.

  GS_FIELDCAT-FIELDNAME = 'PRDAT'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-REF_TABLE = 'ZEKPO01'.

  GS_FIELDCAT-REF_FIELD = 'PRDAT'.

  GS_FIELDCAT-OUTPUTLEN = 12.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  FIELD_CATALOG_DISP

*&---------------------------------------------------------------------*

*       TEXT

*----------------------------------------------------------------------*

*  -->  P1        TEXT

*  <--  P2        TEXT

*----------------------------------------------------------------------*




FORM FIELD_CATALOG_DISP.

  CLEAR : GS_FIELDCAT,GT_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 1.

  GS_FIELDCAT-FIELDNAME = 'EBELP'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-KEY       = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 2.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-KEY       = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 20.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 3.

  GS_FIELDCAT-FIELDNAME = 'MAKTX'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-OUTPUTLEN = 16.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 4.

  GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-REF_TABLE = 'EBAN'.

  GS_FIELDCAT-REF_FIELD = 'MENGE'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 5.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-COLTEXT   = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 6.

  GS_FIELDCAT-FIELDNAME = 'NETPR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 7.

  GS_FIELDCAT-FIELDNAME = 'NETWR'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 8.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 9.

  GS_FIELDCAT-FIELDNAME = 'MWSKZ'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-REF_TABLE = 'ZEKPO01'.

  GS_FIELDCAT-REF_FIELD = 'MWSKZ'.

  GS_FIELDCAT-OUTPUTLEN = 8.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 10.

  GS_FIELDCAT-FIELDNAME = 'WERKS'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 11.

  GS_FIELDCAT-FIELDNAME = 'LGORT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 12.

  GS_FIELDCAT-FIELDNAME = 'PRDAT'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-REF_TABLE = 'ZEKPO01'.

  GS_FIELDCAT-REF_FIELD = 'PRDAT'.

  GS_FIELDCAT-OUTPUTLEN = 12.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  ALV_LAYOUT

*&---------------------------------------------------------------------*

*       TEXT

*----------------------------------------------------------------------*

*  -->  P1        TEXT

*  <--  P2        TEXT

*----------------------------------------------------------------------*




FORM ALV_LAYOUT .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'. " ### ## ###



  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  ALV_SORT

*&---------------------------------------------------------------------*

*       TEXT

*----------------------------------------------------------------------*

*  -->  P1        TEXT

*  <--  P2        TEXT

*----------------------------------------------------------------------*




FORM ALV_SORT .



ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       TEXT

*----------------------------------------------------------------------*

*      -->P_TABLE  TEXT

*----------------------------------------------------------------------*




FORM ALV_DISPLAY  USING    PT_TABLE TYPE STANDARD TABLE.



  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT      = GS_VARIANT

      I_SAVE          = 'A'

      IS_LAYOUT       = GS_LAYOUT

      IT_TOOLBAR_EXCLUDING = GT_EXCLUDE

    CHANGING

      IT_OUTTAB       = PT_TABLE

      IT_FIELDCATALOG = GT_FIELDCAT

      IT_SORT         = GT_SORT.





  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.





ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  GET_DATA

*&---------------------------------------------------------------------*




FORM GET_DATA .

  DATA: LT_EKKO TYPE STANDARD TABLE OF ZEKKO01,

        LS_EKKO TYPE ZEKKO01,

        LT_EKPO TYPE STANDARD TABLE OF ZEKPO01,

        LS_EKPO TYPE ZEKPO01.



  CLEAR : GT_DISP_100, GS_DISP_100.



  "---------------------------------------------------------------

  " 1. #### ##(ZEKKO01) ##

  "---------------------------------------------------------------

  SELECT SINGLE *

    INTO LS_EKKO

    FROM ZEKKO01

   WHERE EBELN = P_EBELN

    AND  LIFNR = P_LIFNR.



  IF SY-SUBRC <> 0.

    MESSAGE |#### { P_EBELN } # #### ####.| TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  " ## ## # ## ## GS_DISP_100 # ##

  GS_HEADER_100-EBELN = LS_EKKO-EBELN.

  GS_HEADER_100-BUKRS = LS_EKKO-BUKRS.

  GS_HEADER_100-EKORG = LS_EKKO-EKORG.

  GS_HEADER_100-EKGRP = LS_EKKO-EKGRP.

  GS_HEADER_100-BEDAT = LS_EKKO-BEDAT.

  GS_HEADER_100-WAERS = LS_EKKO-WAERS.

  GS_HEADER_100-INCO1 = LS_EKKO-INCO1.

  GS_HEADER_100-INCO2 = LS_EKKO-INCO2.



  "---------------------------------------------------------------

  " 2. ###(LFA1/LFB1/LFM1) ## ## (## CHECK_VENDER_DATA# GS_LFA1, GS_LFB1, GS_LFM1 ###)

  "---------------------------------------------------------------

  GS_HEADER_100-LIFNR     = GS_LFA1-LIFNR.

  GS_HEADER_100-LIFNR_TX  = GS_LFA1-NAME1.

  GS_HEADER_100-LAND1     = GS_LFA1-LAND1.



  GS_HEADER_100-PUR_WAERS = GS_LFM1-WAERS.

  GS_HEADER_100-PUR_MWSKZ = GS_LFM1-MWSKZ.

  GS_HEADER_100-PUR_LOEVM = GS_LFB1-LOEVM.



  "---------------------------------------------------------------

  " 3. #### ##(ZEKPO01) ##

  "---------------------------------------------------------------

  SELECT *

    INTO TABLE LT_EKPO

    FROM ZEKPO01

   WHERE EBELN = P_EBELN

   ORDER BY EBELP.



  LOOP AT LT_EKPO INTO LS_EKPO.



    CLEAR GS_DISP_100.



    "---- ## ### ##### ##

    GS_DISP_100-EBELN = LS_EKKO-EBELN.

    GS_DISP_100-BUKRS = LS_EKKO-BUKRS.

    GS_DISP_100-EKORG = LS_EKKO-EKORG.

    GS_DISP_100-EKGRP = LS_EKKO-EKGRP.

    GS_DISP_100-BEDAT = LS_EKKO-BEDAT.

    GS_DISP_100-WAERS = LS_EKKO-WAERS.

    GS_DISP_100-INCO1 = LS_EKKO-INCO1.

    GS_DISP_100-INCO2 = LS_EKKO-INCO2.



    "---- ### ##

    GS_DISP_100-LIFNR     = GS_LFA1-LIFNR.

    GS_DISP_100-LIFNR_TX  = GS_LFA1-NAME1.

    GS_DISP_100-LAND1     = GS_LFA1-LAND1.

    GS_DISP_100-PUR_WAERS = GS_LFM1-WAERS.

    GS_DISP_100-PUR_MWSKZ = GS_LFM1-MWSKZ.



    "---- ## ## ##

    GS_DISP_100-EBELP = LS_EKPO-EBELP.

    GS_DISP_100-MATNR = LS_EKPO-MATNR.

    GS_DISP_100-MAKTX = LS_EKPO-MAKTX.

    GS_DISP_100-MATKL = LS_EKPO-MATKL.

    GS_DISP_100-MENGE = LS_EKPO-MENGE.

    GS_DISP_100-MEINS = LS_EKPO-MEINS.

    GS_DISP_100-BPRME = LS_EKPO-BPRME.

    GS_DISP_100-NETPR = LS_EKPO-NETPR.

    GS_DISP_100-NETWR = LS_EKPO-NETWR.

    GS_DISP_100-MWSKZ = LS_EKPO-MWSKZ.

    GS_DISP_100-WERKS = LS_EKPO-WERKS.

    GS_DISP_100-LGORT = LS_EKPO-LGORT.

    GS_DISP_100-PRDAT = LS_EKPO-PRDAT.



    " ## ###(#### / #####)

    SELECT SINGLE NAME1 INTO GS_DISP_100-WERKS_NAME

      FROM T001W

     WHERE WERKS = LS_EKPO-WERKS.



    SELECT SINGLE LGOBE INTO GS_DISP_100-LGORT_NAME

      FROM T001L

     WHERE LGORT = LS_EKPO-LGORT

       AND WERKS = LS_EKPO-WERKS.



    "---- ## ## ### STATUS

    GS_DISP_100-STATUS = 'O'.



    APPEND GS_DISP_100 TO GT_DISP_100.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  CHECK_VENDER_DATA

*&---------------------------------------------------------------------*

*       TEXT

*----------------------------------------------------------------------*

*  -->  P1        TEXT

*  <--  P2        TEXT

*----------------------------------------------------------------------*




FORM CHECK_VENDER_DATA .



  SELECT SINGLE *

    INTO GS_LFA1

    FROM ZLFA1_01

   WHERE LIFNR = P_LIFNR.



  IF SY-SUBRC <> 0.

    MESSAGE '#### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  SELECT SINGLE *

    INTO GS_LFB1

    FROM ZLFB1_01

   WHERE LIFNR = P_LIFNR

     AND BUKRS = P_BUKRS.



  IF SY-SUBRC <> 0.

    MESSAGE '## #### ## ##### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  SELECT SINGLE *

    INTO GS_LFM1

    FROM ZLFM1_01

   WHERE LIFNR = P_LIFNR.



  IF SY-SUBRC <> 0.

    MESSAGE '## #### ## ##### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.





ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  CLASS_EVENT

*&---------------------------------------------------------------------*

*       TEXT

*----------------------------------------------------------------------*




FORM CLASS_EVENT .

  IF GV_MODE = 'CREATE'.

    CREATE OBJECT GO_EVENT.

    SET HANDLER GO_EVENT->HANDLER_TOOLBAR FOR GC_GRID.

    SET HANDLER GO_EVENT->HANDLER_USER_COMMAND FOR GC_GRID.

    SET HANDLER GO_EVENT->HANDLER_HOTSPOT_CLICK FOR GC_GRID.

    SET HANDLER GO_EVENT->HANDLER_DOUBLE_CLICK FOR GC_GRID.



      CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

      EXPORTING

        I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED




*      EXCEPTIONS

*        ERROR      = 1

*        OTHERS     = 2




    .

    SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID.

    SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED_FINISHED FOR GC_GRID.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  ALV_HANDLER_TOOLBAR

*&---------------------------------------------------------------------*




FORM ALV_HANDLER_TOOLBAR  USING    P_OBJECT TYPE REF TO CL_ALV_EVENT_TOOLBAR_SET

                                   P_INTERACTIVE.

  DATA : LS_TOOLBAR TYPE STB_BUTTON.



  LS_TOOLBAR-FUNCTION = 'INSR'.

  LS_TOOLBAR-ICON = ICON_INSERT_ROW.

  LS_TOOLBAR-QUICKINFO = '####+'.

  LS_TOOLBAR-TEXT      = '####+'.



  APPEND LS_TOOLBAR TO P_OBJECT->MT_TOOLBAR.



  LS_TOOLBAR-FUNCTION = 'DELE'.

  LS_TOOLBAR-ICON = ICON_DELETE_ROW.

  LS_TOOLBAR-QUICKINFO = '####-'.

  LS_TOOLBAR-TEXT      = '####-'.



  APPEND LS_TOOLBAR TO P_OBJECT->MT_TOOLBAR.



  LS_TOOLBAR-FUNCTION = 'SAVE'.

  LS_TOOLBAR-ICON = ICON_CREATE.

  LS_TOOLBAR-QUICKINFO = 'PO##'.

  LS_TOOLBAR-TEXT      = 'PO##'.

  APPEND LS_TOOLBAR TO P_OBJECT->MT_TOOLBAR.



ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  ALV_HANDLER_USER_COMMAND

*&---------------------------------------------------------------------*




FORM ALV_HANDLER_USER_COMMAND  USING    P_UCOMM.

   CASE P_UCOMM.

     WHEN 'INSR'.

       PERFORM INSR_DATA.

     WHEN 'DELE'.

       PERFORM DELE_DATA.

     WHEN 'SAVE'.

       PERFORM SAVE_DATA.

   ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  ALV_HANDLER_DATA_CHANGED

*&---------------------------------------------------------------------*




FORM ALV_HANDLER_DATA_CHANGED  USING    P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                        P_ONF4

                                        P_ONF4_BEFORE

                                        P_ONF4_AFTER

                                        P_UCOMM.

  DATA : LS_MODI TYPE LVC_S_MODI.

  DATA : LS_MAT  TYPE ZMAT01.   "ZMAT01 ###

  DATA : LV_MATNR TYPE MATNR.



  LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.



    IF LS_MODI-FIELDNAME = 'MATNR'.



      LV_MATNR = LS_MODI-VALUE.  " #### ### ####



      "1. ### ##### ##

      SELECT SINGLE * FROM ZMAT01

        INTO LS_MAT

        WHERE MATNR = LV_MATNR.



      IF SY-SUBRC <> 0.



        LV_ERROR_FLAG = 1.

        "#### ###

        CALL METHOD P_DATA_CHANGED->MODIFY_CELL

          EXPORTING

            I_ROW_ID    = LS_MODI-ROW_ID

            I_FIELDNAME = 'MATNR'

            I_VALUE     = ''.



        CONTINUE.

      ENDIF.



      "2. #### ## ### ### ##

      READ TABLE GT_DISP_100 INTO GS_DISP_100 INDEX LS_MODI-ROW_ID.



      IF SY-SUBRC = 0.

        GS_DISP_100-MAKTX = LS_MAT-MAKTX.  "####

        GS_DISP_100-MATKL = LS_MAT-MATKL.  "####

        GS_DISP_100-MEINS = LS_MAT-MEINS.  "##

        GS_DISP_100-WERKS = LS_MAT-WERKS.  "###

        GS_DISP_100-LGORT = LS_MAT-LGORT.  "####

        GS_DISP_100-WAERS = GS_LFM1-WAERS.

        IF LS_MAT-VPRSV = 'S'.

          GS_DISP_100-NETPR = LS_MAT-STPRS.

        ELSEIF LS_MAT-VPRSV = 'V'.

          GS_DISP_100-NETPR = LS_MAT-VERPR.

        ENDIF.

        MODIFY GT_DISP_100 FROM GS_DISP_100 INDEX LS_MODI-ROW_ID.

      ENDIF.

    ENDIF.



    IF LS_MODI-FIELDNAME = 'MENGE'.



      READ TABLE GT_DISP_100 INTO GS_DISP_100 INDEX LS_MODI-ROW_ID.



      IF SY-SUBRC = 0.



        " 1) #### ### ## ##

        GS_DISP_100-MENGE = LS_MODI-VALUE.



        " 2) ### ## ##

        GS_DISP_100-NETWR = GS_DISP_100-NETPR * GS_DISP_100-MENGE.



        " 3) ##### ####

        MODIFY GT_DISP_100 FROM GS_DISP_100 INDEX LS_MODI-ROW_ID.



        " 4) ALV ## ## (##)

        CALL METHOD P_DATA_CHANGED->MODIFY_CELL

          EXPORTING

            I_ROW_ID    = LS_MODI-ROW_ID

            I_FIELDNAME = 'NETWR'

            I_VALUE     = GS_DISP_100-NETWR.



      ENDIF.



    ENDIF.



  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  ALV_DATA_CHANGED_FINISHED

*&---------------------------------------------------------------------*

*       TEXT

*----------------------------------------------------------------------*




FORM ALV_DATA_CHANGED_FINISHED  USING    P_MODIFIED

                                         PT_GOOD_CELLS TYPE LVC_T_MODI.

  PERFORM REFRESH.

  IF LV_ERROR_FLAG = 1.

    MESSAGE '#### ####' TYPE 'S' DISPLAY LIKE 'E'.

    LV_ERROR_FLAG = 0.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  REFRESH

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

*      OTHERS         = 2




          .

  IF SY-SUBRC <> 0.




*   IMPLEMENT SUITABLE ERROR HANDLING HERE




  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  INSR_DATA

*&---------------------------------------------------------------------*




FORM INSR_DATA .

  DATA:  LV_MAX  TYPE I.

  DATA:  LS_NEW  TYPE TY_100.   "### ## ###



  "1. ## ITEM(EBELP) # ### ##

  CLEAR LV_MAX.

  LOOP AT GT_DISP_100 INTO GS_DISP_100.

    IF GS_DISP_100-EBELP > LV_MAX.

      LV_MAX = GS_DISP_100-EBELP.

    ENDIF.

  ENDLOOP.



  "2. # ## ##

  CLEAR LS_NEW.

  LS_NEW-EBELP = LV_MAX + 10.



  "3. ## #### ##

  APPEND LS_NEW TO GT_DISP_100.

  "4. ALV REFRESH

  PERFORM REFRESH.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  DELE_DATA

*&---------------------------------------------------------------------*




FORM DELE_DATA .

  DATA: LV_ROW TYPE LVC_S_ROID-ROW_ID,    "## ##

        LS_ROW TYPE LVC_S_ROW,            "# ##

        LV_IDX TYPE SY-TABIX.             "##### INDEX



  "1. ALV## ## ## ## ####

  CALL METHOD GC_GRID->GET_CURRENT_CELL

    IMPORTING

      ES_ROW_ID = LS_ROW.



  LV_ROW = LS_ROW-INDEX.



  "## ### ### INDEX## ###

  IF LV_ROW IS INITIAL OR LV_ROW > LINES( GT_DISP_100 ).

    MESSAGE '### ## ## #####.' TYPE 'I'.

    RETURN.

  ENDIF.



  "2. ## ##### ## # ##

  DELETE GT_DISP_100 INDEX LV_ROW.



  "3. ALV REFRESH

  PERFORM REFRESH.



  "## ### ## ##

  CALL METHOD GC_GRID->SET_CURRENT_CELL_VIA_ID

    EXPORTING

      IS_ROW_ID    = VALUE LVC_S_ROW( INDEX = LV_ROW - 1 )

      IS_COLUMN_ID = VALUE LVC_S_COL( FIELDNAME = 'EBELP' ).

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  SAVE_DATA

*&---------------------------------------------------------------------*

*       TEXT

*----------------------------------------------------------------------*




FORM SAVE_DATA .

  DATA: LV_OK     TYPE ABAP_BOOL,

        LV_EBELN  TYPE ZEKKO01-EBELN.



  "---------------------------------------------------------------

  " 0. ## ## ## ##

  "---------------------------------------------------------------

  IF GT_DISP_100 IS INITIAL.

    MESSAGE '### ### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    RETURN.

  ENDIF.



  "---------------------------------------------------------------

  " 1. ## # ## VALIDATION

  "---------------------------------------------------------------

  PERFORM CHECK_VALIDATION_DATA CHANGING LV_OK.



  IF LV_OK = ABAP_FALSE.

    RETURN.

  ENDIF.



  "---------------------------------------------------------------

  " 2. ##

  "---------------------------------------------------------------

  CALL FUNCTION 'NUMBER_GET_NEXT'

    EXPORTING

      OBJECT       = 'ZPO_NUM01'

      NR_RANGE_NR  = '01'

    IMPORTING

      NUMBER       = LV_EBELN

    EXCEPTIONS

      OTHERS       = 1.



  IF SY-SUBRC <> 0.

    MESSAGE '#### ##(ZPO_NUM01)' TYPE 'S' DISPLAY LIKE 'E'.

    RETURN.

  ENDIF.



  CLEAR : GS_EKKO , GT_EKPO.

  "---------------------------------------------------------------

  " ## ##

  "---------------------------------------------------------------

  " EBELN ##

  GS_EKKO-EBELN   = LV_EBELN.

  GS_EKKO-BUKRS   = GS_HEADER_100-BUKRS.

  GS_EKKO-EKGRP   = GS_HEADER_100-EKGRP.

  GS_EKKO-EKORG   = GS_HEADER_100-EKORG.

  GS_EKKO-LIFNR   = GS_HEADER_100-LIFNR.

  GS_EKKO-BEDAT   = GS_HEADER_100-BEDAT.

  GS_EKKO-WAERS   = GS_HEADER_100-WAERS.

  GS_EKKO-INCO1   = GS_HEADER_100-INCO1.

  GS_EKKO-INCO2   = GS_HEADER_100-INCO2.

  GS_EKKO-CRNAME  = SY-UNAME.

  GS_EKKO-CRDATE  = SY-DATUM.

  GS_EKKO-CRZEIT  = SY-UZEIT.







  "---------------------------------------------------------------

  "  ## ##

  "---------------------------------------------------------------

  LOOP AT GT_DISP_100 INTO GS_DISP_100.

    CLEAR :GS_EKPO.

    IF GS_DISP_100-STATUS = 'O'.

      CONTINUE.

    ENDIF.



    GS_EKPO-EBELN = LV_EBELN.

    GS_EKPO-EBELP = GS_DISP_100-EBELP.

    GS_EKPO-MATNR = GS_DISP_100-MATNR.

    GS_EKPO-MAKTX = GS_DISP_100-MAKTX.

    GS_EKPO-MATKL = GS_DISP_100-MATKL.

    GS_EKPO-MENGE = GS_DISP_100-MENGE.

    GS_EKPO-MEINS = GS_DISP_100-MEINS.

    GS_EKPO-BPRME = GS_DISP_100-BPRME.

    GS_EKPO-PRDAT = GS_DISP_100-PRDAT.

    GS_EKPO-WERKS = GS_DISP_100-WERKS.

    GS_EKPO-LGORT = GS_DISP_100-LGORT.

    GS_EKPO-MWSKZ = GS_DISP_100-MWSKZ.

    GS_EKPO-NETPR = GS_DISP_100-NETPR.

    GS_EKPO-NETWR = GS_DISP_100-NETWR.



    APPEND GS_EKPO TO GT_EKPO.



    IF GS_EKPO-NETWR IS INITIAL.

      GS_EKPO-NETWR = GS_EKPO-MENGE * GS_EKPO-NETPR.

    ENDIF.

  ENDLOOP.

  INSERT ZEKKO01 FROM GS_EKKO.

  INSERT ZEKPO01 FROM TABLE GT_EKPO.



  MESSAGE |#### { LV_EBELN } ## ##| TYPE 'S'.

  LEAVE TO SCREEN 0.



ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  EXCLUDE_TOOLBAR_100

*&---------------------------------------------------------------------*




FORM EXCLUDE_TOOLBAR_100 .

  GS_EXCLUDE = CL_GUI_ALV_GRID=>MC_FC_LOC_INSERT_ROW.

  APPEND GS_EXCLUDE TO GT_EXCLUDE.



  GS_EXCLUDE = CL_GUI_ALV_GRID=>MC_FC_LOC_DELETE_ROW.

  APPEND GS_EXCLUDE TO GT_EXCLUDE.



  GS_EXCLUDE = CL_GUI_ALV_GRID=>MC_FC_LOC_APPEND_ROW.

  APPEND GS_EXCLUDE TO GT_EXCLUDE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  SET_MODE_DATA

*&---------------------------------------------------------------------*




FORM SET_MODE_DATA .

  IF GV_MODE = 'CREATE'.

    PERFORM INIT_DATA.     " ## ##

  ELSEIF GV_MODE = 'DISPLAY'.

    PERFORM GET_DATA.      " ## ##

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  CHECK_VALIDATION_DATA

*&---------------------------------------------------------------------*

*       TEXT

*----------------------------------------------------------------------*

*  -->  P1        TEXT

*  <--  P2        TEXT

*----------------------------------------------------------------------*




FORM CHECK_VALIDATION_DATA CHANGING VALUE(RV_OK) TYPE ABAP_BOOL.



  RV_OK = ABAP_TRUE.

  LOOP AT GT_DISP_100 INTO GS_DISP_100.

    " #### ##

    IF GS_DISP_100-MATNR IS INITIAL.

      MESSAGE |## { GS_DISP_100-EBELP } : ##### #####| TYPE 'S' DISPLAY LIKE 'E'.

      RV_OK = ABAP_FALSE.

    ENDIF.



    CHECK RV_OK = ABAP_TRUE.

    SELECT SINGLE * FROM ZMAT01

      INTO GS_ZMAT

      WHERE MATNR = GS_DISP_100-MATNR.



    IF SY-SUBRC <> 0.

      MESSAGE |## { GS_DISP_100-EBELP } : ##### ###### #### ####| TYPE 'S' DISPLAY LIKE 'E'.

       RV_OK = ABAP_FALSE.

    ENDIF.



    " ## ##

    CHECK RV_OK = ABAP_TRUE.

    IF GS_DISP_100-MENGE IS INITIAL OR GS_DISP_100-MENGE <= 0.

      MESSAGE |## { GS_DISP_100-EBELP } : ### 0## ## ###| TYPE 'S' DISPLAY LIKE 'E'.

      RV_OK = ABAP_FALSE.

    ENDIF.



    " ## ##

    CHECK RV_OK = ABAP_TRUE.

    IF GS_DISP_100-MEINS IS INITIAL.

      MESSAGE |## { GS_DISP_100-EBELP } : ### ####| TYPE 'S' DISPLAY LIKE 'E'.

      RV_OK = ABAP_FALSE.

    ENDIF.



    " ### ##

    CHECK RV_OK = ABAP_TRUE.

    IF GS_DISP_100-WERKS IS INITIAL.

      MESSAGE |## { GS_DISP_100-EBELP } : #### #####| TYPE 'S' DISPLAY LIKE 'E'.

      RV_OK = ABAP_FALSE.

    ENDIF.



    " #### ##

    CHECK RV_OK = ABAP_TRUE.

    IF GS_DISP_100-LGORT IS INITIAL.

      MESSAGE |## { GS_DISP_100-EBELP } : ##### #####| TYPE 'S' DISPLAY LIKE 'E'.

      RV_OK = ABAP_FALSE.

    ENDIF.



    " ##(NETPR) ##

    CHECK RV_OK = ABAP_TRUE.

    IF GS_DISP_100-NETPR IS INITIAL OR GS_DISP_100-NETPR <= 0.

      MESSAGE |## { GS_DISP_100-EBELP } : ### #### ####| TYPE 'S' DISPLAY LIKE 'E'.

      RV_OK = ABAP_FALSE.

    ENDIF.

    " ## ## ##

    CHECK RV_OK = ABAP_TRUE.

    IF GS_DISP_100-MWSKZ IS INITIAL.

      MESSAGE |## { GS_DISP_100-EBELP } : ##### #####| TYPE 'S' DISPLAY LIKE 'E'.

      RV_OK = ABAP_FALSE.

    ENDIF.



    " ### ##

    CHECK RV_OK = ABAP_TRUE.

    IF GS_DISP_100-PRDAT IS INITIAL.

      MESSAGE |## { GS_DISP_100-EBELP } : #### #####| TYPE 'S' DISPLAY LIKE 'E'.

      RV_OK = ABAP_FALSE.

    ENDIF.



    CHECK RV_OK = ABAP_TRUE.

    IF GS_DISP_100-PRDAT < P_BEDAT.

     MESSAGE |## { GS_DISP_100-EBELP } : #### #### ### ## #### ### | TYPE 'S' DISPLAY LIKE 'E'.

     RV_OK = ABAP_FALSE.

    ENDIF.

    " ### ##

    CHECK RV_OK = ABAP_TRUE.

    SELECT SINGLE WERKS

      FROM ZMAT01

      INTO GS_ZMAT

      WHERE MATNR = GS_DISP_100-MATNR

      AND WERKS = GS_DISP_100-WERKS.



    IF SY-SUBRC <> 0.

      MESSAGE |## { GS_DISP_100-EBELP } : ## { GS_DISP_100-MATNR } # ### { GS_DISP_100-WERKS } # #### ####|

              TYPE 'S' DISPLAY LIKE 'E'.

      RV_OK = ABAP_FALSE.

    ENDIF.



    CHECK RV_OK = ABAP_TRUE.

    SELECT SINGLE LGORT

      FROM ZMAT01

      INTO GS_ZMAT

      WHERE MATNR = GS_DISP_100-MATNR

      AND WERKS = GS_DISP_100-WERKS

      AND LGORT = GS_DISP_100-LGORT.



    IF SY-SUBRC <> 0.

      MESSAGE |## { GS_DISP_100-EBELP } : ## { GS_DISP_100-MATNR } # ### { GS_DISP_100-WERKS } # #### { GS_DISP_100-LGORT } # #### ####|

              TYPE 'S' DISPLAY LIKE 'E'.

      RV_OK = ABAP_FALSE.

    ENDIF.



    " ### ###

    IF GS_DISP_100-NETWR IS INITIAL.

      GS_DISP_100-NETWR = GS_DISP_100-MENGE * GS_DISP_100-NETPR.

    ENDIF.



    " ## ## (## ### ##)

    IF GS_DISP_100-WAERS IS INITIAL.

      GS_DISP_100-WAERS = GS_EKKO-WAERS.

    ENDIF.

  ENDLOOP.

ENDFORM.