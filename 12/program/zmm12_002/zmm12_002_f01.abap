
*&---------------------------------------------------------------------*

*&  Include           ZMM12_002_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_SCREEN

*&---------------------------------------------------------------------*




FORM SET_SCREEN .

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.  " ####, #####, ###

      IF P_RD1 = 'X'.

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ELSEIF SCREEN-GROUP1 = 'M2'.  " #####, ####, PO##

      IF P_RD1 = 'X'.

        SCREEN-ACTIVE = '0'.

      ELSE.

        SCREEN-ACTIVE = '1'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*FORM GET_DATA .

*

*ENDFORM.

*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*






FORM CREATE_OBJECT .



  CREATE OBJECT GC_CUSTOM

    EXPORTING

      CONTAINER_NAME              = 'CON_ITEM'

      .

  IF SY-SUBRC <> 0.

  ENDIF.



CREATE OBJECT GC_GRID_ITEM

  EXPORTING

    I_PARENT          = GC_CUSTOM

    .

IF SY-SUBRC <> 0.

ENDIF.







ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG .

  "--------------------------------------------------------*

  " ### ALV ######

  "--------------------------------------------------------*

  CLEAR : GS_FIELDCAT_ITEM, GT_FIELDCAT_ITEM.

  GS_FIELDCAT_ITEM-COL_POS   = 1.

  GS_FIELDCAT_ITEM-FIELDNAME = 'EBELP'.

  GS_FIELDCAT_ITEM-SCRTEXT_M = '##'.

  GS_FIELDCAT_ITEM-KEY       = 'X'.

  APPEND GS_FIELDCAT_ITEM TO GT_FIELDCAT_ITEM.



  CLEAR GS_FIELDCAT_ITEM.

  GS_FIELDCAT_ITEM-COL_POS   = 2.

  GS_FIELDCAT_ITEM-FIELDNAME = 'MATNR'.

  GS_FIELDCAT_ITEM-SCRTEXT_M = '####'.

  GS_FIELDCAT_ITEM-EDIT = 'X'.

  GS_FIELDCAT_ITEM-KEY = 'X'.

  GS_FIELDCAT_ITEM-OUTPUTLEN = 15.

  APPEND GS_FIELDCAT_ITEM TO GT_FIELDCAT_ITEM.



  CLEAR GS_FIELDCAT_ITEM.

  GS_FIELDCAT_ITEM-COL_POS   = 3.

  GS_FIELDCAT_ITEM-FIELDNAME = 'MATNAME'.

  GS_FIELDCAT_ITEM-SCRTEXT_M = '###'.

  GS_FIELDCAT_ITEM-OUTPUTLEN = 12.

  APPEND GS_FIELDCAT_ITEM TO GT_FIELDCAT_ITEM.



  CLEAR GS_FIELDCAT_ITEM.

  GS_FIELDCAT_ITEM-COL_POS   = 4.

  GS_FIELDCAT_ITEM-FIELDNAME = 'MENGE'.

  GS_FIELDCAT_ITEM-COLTEXT = 'PO##'.

  GS_FIELDCAT_ITEM-QFIELDNAME = 'MEINS'.

  GS_FIELDCAT_ITEM-EDIT = 'X'.

  APPEND GS_FIELDCAT_ITEM TO GT_FIELDCAT_ITEM.



  CLEAR GS_FIELDCAT_ITEM.

  GS_FIELDCAT_ITEM-COL_POS   = 5.

  GS_FIELDCAT_ITEM-FIELDNAME = 'STPRS'.

  GS_FIELDCAT_ITEM-SCRTEXT_M = '##'.




*  GS_FIELDCAT_ITEM-CFIELDNAME = 'WAERS'.




  GS_FIELDCAT_ITEM-NO_ZERO = 'X'.

  GS_FIELDCAT_ITEM-DECIMALS = '2'.

  GS_FIELDCAT_ITEM-EDIT = 'X'.

  APPEND GS_FIELDCAT_ITEM TO GT_FIELDCAT_ITEM.



  CLEAR GS_FIELDCAT_ITEM.

  GS_FIELDCAT_ITEM-COL_POS   = 6.

  GS_FIELDCAT_ITEM-FIELDNAME = 'MEINS'.

  GS_FIELDCAT_ITEM-COLTEXT   = '##'.

  GS_FIELDCAT_ITEM-EDIT = 'X'.

  APPEND GS_FIELDCAT_ITEM TO GT_FIELDCAT_ITEM.



  CLEAR GS_FIELDCAT_ITEM.

  GS_FIELDCAT_ITEM-COL_POS   = 7.

  GS_FIELDCAT_ITEM-FIELDNAME = 'WAERS'.

  GS_FIELDCAT_ITEM-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT_ITEM TO GT_FIELDCAT_ITEM.



  CLEAR GS_FIELDCAT_ITEM.

  GS_FIELDCAT_ITEM-COL_POS   = 9.

  GS_FIELDCAT_ITEM-FIELDNAME = 'MWSKZ'.

  GS_FIELDCAT_ITEM-SCRTEXT_M = '####'.

  GS_FIELDCAT_ITEM-EDIT = 'X'.

  GS_FIELDCAT_ITEM-OUTPUTLEN = 6.

  APPEND GS_FIELDCAT_ITEM TO GT_FIELDCAT_ITEM.



  CLEAR GS_FIELDCAT_ITEM.

  GS_FIELDCAT_ITEM-COL_POS   = 10.

  GS_FIELDCAT_ITEM-FIELDNAME = 'PRDAT'.

  GS_FIELDCAT_ITEM-SCRTEXT_M = '###'.

  GS_FIELDCAT_ITEM-EDIT = 'X'.

  APPEND GS_FIELDCAT_ITEM TO GT_FIELDCAT_ITEM.



  CLEAR GS_FIELDCAT_ITEM.

  GS_FIELDCAT_ITEM-COL_POS   = 11.

  GS_FIELDCAT_ITEM-FIELDNAME = 'WERKS'.

  GS_FIELDCAT_ITEM-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT_ITEM TO GT_FIELDCAT_ITEM.



  CLEAR GS_FIELDCAT_ITEM.

  GS_FIELDCAT_ITEM-COL_POS   = 12.

  GS_FIELDCAT_ITEM-FIELDNAME = 'LGORT'.

  GS_FIELDCAT_ITEM-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT_ITEM TO GT_FIELDCAT_ITEM.





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

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY .



  CALL METHOD GC_GRID_ITEM->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IT_TOOLBAR_EXCLUDING          = GT_EXCLUDE




*      IS_LAYOUT                     = GS_LAYOUT




    CHANGING

      IT_OUTTAB                     = GT_EKPO

      IT_FIELDCATALOG               = GT_FIELDCAT_ITEM

          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*




FORM CLASS_EVENT .

   " ### ### ## ##

  CREATE OBJECT GO_EVENT.

  SET HANDLER GO_EVENT->HANDLE_TOOLBAR FOR GC_GRID_ITEM.

  SET HANDLER GO_EVENT->HANDLE_USER_COMMAND FOR GC_GRID_ITEM.

  CALL METHOD GC_GRID_ITEM->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED




*    EXCEPTIONS

*      ERROR      = 1

*      others     = 2




          .

  IF SY-SUBRC <> 0.

  ENDIF.

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID_ITEM.

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED_FINISHED FOR GC_GRID_ITEM.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  INITIALIZATION

*&---------------------------------------------------------------------*




FORM INITIALIZATION .

  P_BEDAT = SY-DATUM.

  GS_EXCLUDE = CL_GUI_ALV_GRID=>MC_FC_LOC_INSERT_ROW.

  APPEND GS_EXCLUDE TO GT_EXCLUDE.



  GS_EXCLUDE = CL_GUI_ALV_GRID=>MC_FC_LOC_DELETE_ROW.

  APPEND GS_EXCLUDE TO GT_EXCLUDE.



  GS_EXCLUDE = CL_GUI_ALV_GRID=>MC_FC_LOC_APPEND_ROW.

  APPEND GS_EXCLUDE TO GT_EXCLUDE.



  GS_EXCLUDE = CL_GUI_ALV_GRID=>MC_FC_LOC_COPY_ROW.

  APPEND GS_EXCLUDE TO GT_EXCLUDE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DATA_CHANGED

*&---------------------------------------------------------------------*




FORM ALV_HANDLER_DATA_CHANGED  USING    P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                        P_ONF4

                                        P_ONF4_BEFORE

                                        P_ONF4_AFTER

                                        P_UCOMM.

  DATA: LS_MODI  TYPE LVC_S_MODI,

        LS_MARA  TYPE ZMARA_12,

        LV_MATNR TYPE MATNR,

        LV_PRDAT TYPE PRDAT.



  LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.



    IF LS_MODI-VALUE IS INITIAL.

      CONTINUE.

    ENDIF.



    CASE LS_MODI-FIELDNAME.



      "========================================

      " MATNR: ## ### + #### ####

      "========================================

      WHEN 'MATNR'.



        LV_MATNR = LS_MODI-VALUE.

        SHIFT LV_MATNR LEFT DELETING LEADING '0'.



        CLEAR LS_MARA.

        SELECT SINGLE *

          FROM ZMARA_12

          INTO CORRESPONDING FIELDS OF LS_MARA

          WHERE ZMATNR = LV_MATNR.



        IF LS_MARA IS INITIAL.

          MESSAGE '### ##### ####.' TYPE 'S' DISPLAY LIKE 'E'.



          CALL METHOD P_DATA_CHANGED->MODIFY_CELL

            EXPORTING

              I_ROW_ID    = LS_MODI-ROW_ID

              I_FIELDNAME = 'MATNR'

              I_VALUE     = ''.

          CONTINUE.

        ENDIF.



        READ TABLE GT_EKPO INTO GS_EKPO INDEX LS_MODI-ROW_ID.

        IF SY-SUBRC = 0.

          "### MATNR ##

          GS_EKPO-MATNR = LV_MATNR.



          "### # ###

          GS_EKPO-MATNAME = LS_MARA-MATNAME.

          GS_EKPO-MENGE   = LS_MARA-MENGE.

          GS_EKPO-STPRS   = LS_MARA-STPRS.



          GS_EKPO-MEINS   = LS_MARA-MEINS.

          GS_EKPO-WAERS   = LS_MARA-WAERS.

          GS_EKPO-WERKS   = LS_MARA-WERKS.

          GS_EKPO-LGORT   = LS_MARA-LGORT.

          gs_ekpo-mwskz   = gv_mwskz.



          MODIFY GT_EKPO FROM GS_EKPO INDEX LS_MODI-ROW_ID.

        ENDIF.



      "========================================

      " PRDAT: ### ## + PRDAT# ##

      "========================================

      WHEN 'PRDAT'.



        LV_PRDAT = LS_MODI-VALUE.



        IF LV_PRDAT < GS_EKKO-BEDAT.

          MESSAGE '#### ##### ### ### #### ##.' TYPE 'S' DISPLAY LIKE 'E'.



          CALL METHOD P_DATA_CHANGED->MODIFY_CELL

            EXPORTING

              I_ROW_ID    = LS_MODI-ROW_ID

              I_FIELDNAME = 'PRDAT'

              I_VALUE     = ''.

          CONTINUE.

        ENDIF.



        READ TABLE GT_EKPO INTO GS_EKPO INDEX LS_MODI-ROW_ID.

        IF SY-SUBRC = 0.

          GS_EKPO-PRDAT = LV_PRDAT.

          MODIFY GT_EKPO FROM GS_EKPO INDEX LS_MODI-ROW_ID.

        ENDIF.



      "========================================

      " (#### ## ### ## WHEN##)

      "========================================




*     WHEN 'WERKS'.

*     WHEN 'LGORT'.

*     ...






    ENDCASE.



  ENDLOOP.



  PERFORM REFRESH.





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DATA_CHANGED_FINISHED

*&---------------------------------------------------------------------*




FORM ALV_DATA_CHANGED_FINISHED  USING    P_MODIFIED

                                         PT_GOOD_CELLS TYPE LVC_T_MODI.

  DATA: LS_MODI TYPE LVC_S_MODI.



  CLEAR: LS_MODI.



  LOOP AT PT_GOOD_CELLS INTO LS_MODI.

      READ TABLE GT_EKPO INTO GS_EKPO INDEX LS_MODI-ROW_ID.



      CLEAR GS_EKPO.

  ENDLOOP.



  PERFORM REFRESH.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_TOOLBAR

*&---------------------------------------------------------------------*




FORM ALV_HANDLER_TOOLBAR  USING    P_OBJECT TYPE REF TO CL_ALV_EVENT_TOOLBAR_SET

                                   P_INTERACTIVE.

    DATA : LS_TOOLBAR TYPE STB_BUTTON.



    " #### ##

    CLEAR LS_TOOLBAR.

    LS_TOOLBAR-FUNCTION  = 'ADD_ROW'.

    LS_TOOLBAR-ICON      = ICON_INSERT_ROW.

    LS_TOOLBAR-BUTN_TYPE = 0. "BUTTON NORMAL

    LS_TOOLBAR-TEXT      = '####+'.

    LS_TOOLBAR-QUICKINFO = '# # ##'.

    APPEND LS_TOOLBAR TO P_OBJECT->MT_TOOLBAR.



    " ###

    CLEAR LS_TOOLBAR.

    LS_TOOLBAR-BUTN_TYPE = 3. "separator

    APPEND LS_TOOLBAR TO P_OBJECT->MT_TOOLBAR.



    CLEAR LS_TOOLBAR.

    LS_TOOLBAR-FUNCTION  = 'DEL_ROW'.

    LS_TOOLBAR-ICON      = ICON_DELETE_ROW.

    LS_TOOLBAR-BUTN_TYPE = 0. "BUTTON NORMAL

    LS_TOOLBAR-TEXT      = '####-'.

    LS_TOOLBAR-QUICKINFO = '# # ##'.

    APPEND LS_TOOLBAR TO P_OBJECT->MT_TOOLBAR.



    CLEAR LS_TOOLBAR.

    LS_TOOLBAR-FUNCTION  = 'CREATE_PO'.

    LS_TOOLBAR-ICON      = ICON_GENERATE.

    LS_TOOLBAR-BUTN_TYPE = 0. "BUTTON NORMAL

    LS_TOOLBAR-TEXT      = '## #### PO##'.

    APPEND LS_TOOLBAR TO P_OBJECT->MT_TOOLBAR.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_USER_COMMAND

*&---------------------------------------------------------------------*




FORM ALV_HANDLER_USER_COMMAND  USING    P_UCOMM.

  CASE P_UCOMM.

    WHEN 'ADD_ROW'.

      PERFORM ADD_ROW.

    WHEN 'DEL_ROW'.

      PERFORM DEL_ROW.

    WHEN 'CREATE_PO'.

      PERFORM CREATE_PO.

   ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*




FORM REFRESH .

  DATA: LS_STABLE TYPE LVC_S_STBL. "####.




*   ####USERCOMMAND ######

*    CURSOR#####




  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GC_GRID_ITEM->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE      = LS_STABLE

          .

  IF SY-SUBRC <> 0.



  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ADD_ROW

*&---------------------------------------------------------------------*




FORM ADD_ROW .

  DATA: LS_EKPO      LIKE LINE OF GT_ekpo,

        LV_MAX_EBELP TYPE ZEKPO_12-EBELP,

        LV_EBELP_NUM TYPE I.



  CLEAR: LS_EKPO, LV_MAX_EBELP, LV_EBELP_NUM.



  "--------------------------------------------------

  " 1. ## GT_EKPO ## ## # ####(EBELP) ##

  "--------------------------------------------------

  LOOP AT GT_ekpo INTO GS_ekpo.

    IF GS_ekpo-EBELP > LV_MAX_EBELP.

      LV_MAX_EBELP = GS_ekpo-EBELP.

    ENDIF.

  ENDLOOP.



  "--------------------------------------------------

  " 2. ## #### ## (10, 20, 30, ...)

  "--------------------------------------------------

  IF LV_MAX_EBELP IS INITIAL.

    LV_EBELP_NUM = 10.

  ELSE.

    LV_EBELP_NUM = LV_MAX_EBELP.

    LV_EBELP_NUM = LV_EBELP_NUM + 10.

  ENDIF.



  LS_EKPO-EBELP = LV_EBELP_NUM.



  "--------------------------------------------------

  " 3. ###### # # ##

  "--------------------------------------------------

  APPEND LS_EKPO TO GT_ekpo.



  "--------------------------------------------------

  " 4. ALV ## ### (##/### ##)

  "--------------------------------------------------

  PERFORM REFRESH.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DEL_ROW

*&---------------------------------------------------------------------*




FORM DEL_ROW .





  DATA: LS_ROID TYPE LVC_S_ROW,          "ROW ID (###)"

        LV_ROW  TYPE LVC_S_ROID-ROW_ID.



  "#### # ##

  CALL METHOD GC_GRID_ITEM->CHECK_CHANGED_DATA.



  "## ## ## ####

  CALL METHOD GC_GRID_ITEM->GET_CURRENT_CELL

    IMPORTING

      ES_ROW_ID = LS_ROID.



  LV_ROW = LS_ROID-INDEX.



  IF LV_ROW IS INITIAL OR LV_ROW = 0 OR LV_ROW > LINES( GT_EKPO ).

    MESSAGE '### ## ######.' TYPE 'S' DISPLAY LIKE 'E'.

    RETURN.

  ENDIF.



  DELETE GT_EKPO INDEX LV_ROW.



  PERFORM REFRESH.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_PO

*&---------------------------------------------------------------------*




FORM CREATE_PO .

  DATA: LV_EBELN  TYPE ZEKKO_12-EBELN,

        LV_MAX_EBELN TYPE ZEKKO_12-EBELN,

        LS_EKKO TYPE ZEKKO_12,

        LS_EKPO TYPE ZEKPO_12.



  "===================================================

  " 1. ######(EBELN) ##

  "===================================================

  CALL FUNCTION 'NUMBER_GET_NEXT'   " PO## ## ####

      EXPORTING

        NR_RANGE_NR                   = '01'

        OBJECT                        = 'ZADOCU1'

      IMPORTING

        NUMBER                        = LV_EBELN.

  "===================================================

  " 2. ## ##

  "===================================================

  CLEAR LS_EKKO.



  LS_EKKO-EBELN = LV_EBELN.

  LS_EKKO-BUKRS = GS_EKKO-BUKRS. "####

  LS_EKKO-EKGRP = GS_EKKO-EKGRP.

  LS_EKKO-EKORG = GS_EKKO-EKORG.

  LS_EKKO-LIFNR = GS_EKKO-LIFNR.

  LS_EKKO-WAERS = GS_EKKO-WAERS.

  LS_EKKO-BEDAT = SY-DATUM.



  INSERT ZEKKO_12 FROM LS_EKKO.

  IF SY-SUBRC <> 0.

    MESSAGE '## ## ##' TYPE 'E'.

  ENDIF.



  "===================================================

  " 3. ### ##

  "===================================================

  LOOP AT GT_EKPO INTO GS_EKPO.



    CLEAR LS_EKPO.



    LS_EKPO-EBELN  = LV_EBELN.

    LS_EKPO-EBELP  = GS_EKPO-EBELP.

    LS_EKPO-MATNR  = GS_EKPO-MATNR.

    LS_EKPO-MATNAME  = GS_EKPO-MATNAME.

    LS_EKPO-MENGE  = GS_EKPO-MENGE.

    LS_EKPO-MEINS  = GS_EKPO-MEINS.

    LS_EKPO-STPRS  = GS_EKPO-STPRS.

    LS_EKPO-PRDAT  = GS_EKPO-PRDAT.

    LS_EKPO-WERKS  = GS_EKPO-WERKS.

    LS_EKPO-LGORT  = GS_EKPO-LGORT.



    INSERT ZEKPO_12 FROM LS_EKPO.



    IF SY-SUBRC <> 0.

      MESSAGE |### { GS_EKPO-EBELP } ## ##| TYPE 'E'.

    ENDIF.



  ENDLOOP.



  "===================================================

  " 4. ## ###

  "===================================================

  MESSAGE |PO { LV_EBELN } ## ##| TYPE 'S'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT2 .

CREATE OBJECT GC_DOCKING

  EXPORTING




*    PARENT                      =




    REPID                       = SY-REPID "DOCKING CONTAINER#### ###, ####ID&#######.

    DYNNR                       = SY-DYNNR




*    SIDE                        = DOCK_AT_LEFT




    EXTENSION                   = 2000  "#### # ######.




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

*    others                      = 6




    .

IF SY-SUBRC <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




ENDIF.



CREATE OBJECT GC_GRID

  EXPORTING




*    I_SHELLSTYLE      = 0

*    I_LIFETIME        =




    I_PARENT          = GC_DOCKING  "CONTAINER# GRID ###




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

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*




FORM ALV_SORT .



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY2

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY2 .

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

  EXPORTING




*    I_BUFFER_ACTIVE               =

*    I_BYPASSING_BUFFER            =

*    I_CONSISTENCY_CHECK           =

*    I_STRUCTURE_NAME              =




    IS_VARIANT                    = GS_VARIANT

    I_SAVE                        = 'A' "A# #### ALV##### #### #########.




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

    IT_OUTTAB                     = GT_DISPLAY

    IT_FIELDCATALOG               = GT_FIELDCAT_DISP

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

*&      Form  GET_DATA1

*&---------------------------------------------------------------------*




FORM GET_DATA1 .



  SELECT SINGLE * FROM ZLFA1_12 AS A

  INNER JOIN ZLFB1_12 AS B ON A~LIFNR = B~LIFNR

  INNER JOIN ZLFM1_12 AS C ON A~LIFNR = C~LIFNR

  INTO CORRESPONDING FIELDS OF GS_EKKO

  WHERE A~LIFNR = GS_EKKO-LIFNR    "#####

  AND B~BUKRS = GS_EKKO-BUKRS.     "####



  IF SY-SUBRC <> 0.

    MESSAGE '### / #### / #### ### #### ####.' TYPE 'E'.

  ENDIF.



  "2) # ####(LFM1: ###+####) ## ####

  CLEAR gv_mwskz.

  SELECT SINGLE mwskz

    INTO @gv_mwskz

    FROM zlfm1_12

    WHERE lifnr = @gs_ekko-lifnr

      AND ekorg = @gs_ekko-ekorg.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA2

*&---------------------------------------------------------------------*




FORM GET_DATA2 .

" 1. ## ## (###/##/PO ### ##)

SELECT SINGLE * FROM ZEKKO_12

    INTO CORRESPONDING FIELDS OF GS_EKKO

    WHERE LIFNR = P_LIFNR2       "#####

      AND BUKRS = P_BUKRS        "####

      AND EBELN = P_EBELN.       "PO##

" 2. ### ##

  SELECT * FROM ZEKPO_12

    INTO CORRESPONDING FIELDS OF TABLE GT_EKPO

    WHERE EBELN = P_EBELN.       "PO##

  LOOP AT GT_EKPO INTO GS_EKPO.

    CLEAR GS_DISPLAY.

    MOVE-CORRESPONDING GS_EKKO TO GS_DISPLAY.

    MOVE-CORRESPONDING GS_EKPO TO GS_DISPLAY.

    GS_DISPLAY-WAERS = GS_EKKO-WAERS. "### ## ##

    APPEND GS_DISPLAY TO GT_DISPLAY.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_MANDATORY

*&---------------------------------------------------------------------*




FORM CHECK_MANDATORY .

  "-----------------------------

  " 1. ### ##

  "-----------------------------

  IF P_RD1 = 'X'.        "## ##

    IF P_BUKRS IS INITIAL OR P_LIFNR1 IS INITIAL OR P_BEDAT IS INITIAL.

      MESSAGE '####, ###, #### #####.' TYPE 'E'.

    ENDIF.

  ELSEIF P_RD2 = 'X'.    "## ##

    IF P_BUKRS IS INITIAL OR P_LIFNR2 IS INITIAL OR P_EBELN IS INITIAL.

      MESSAGE '####, ###, PO### #####.' TYPE 'E'.

    ENDIF.

  ENDIF.



  "-----------------------------

  " 2. ### ## ## ##

  "   (### ## ## #### ##)

  "-----------------------------

  CLEAR GS_LFA1.



  IF P_RD1 = 'X'.

    SELECT SINGLE *

      FROM ZLFA1_12

      INTO CORRESPONDING FIELDS OF GS_LFA1

      WHERE LIFNR = P_LIFNR1.

  ELSEIF P_RD2 = 'X'.

    SELECT SINGLE *

      FROM ZLFA1_12

      INTO CORRESPONDING FIELDS OF GS_LFA1

      WHERE LIFNR = P_LIFNR2.

  ENDIF.



  IF SY-SUBRC <> 0.

    MESSAGE '#### ###### ####.' TYPE 'E'.

  ENDIF.



  "-----------------------------

  " 3. GS_EKKO ## ##

  "-----------------------------

  GS_EKKO-BUKRS = P_BUKRS.



  IF P_RD1 = 'X'.

    GS_EKKO-LIFNR = P_LIFNR1.

    GS_EKKO-BEDAT = P_BEDAT.

  ELSEIF P_RD2 = 'X'.

    GS_EKKO-LIFNR = P_LIFNR2.

    GS_EKKO-EBELN = P_EBELN.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG2

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG2 .

   CLEAR GT_FIELDCAT_DISP.



  " EBELN - ######

  CLEAR GS_FIELDCAT_DISP.

  GS_FIELDCAT_DISP-FIELDNAME = 'EBELN'.

  GS_FIELDCAT_DISP-SCRTEXT_M = '######'.

  GS_FIELDCAT_DISP-COL_POS   = 1.

  GS_FIELDCAT_DISP-OUTPUTLEN = 10.

  GS_FIELDCAT_DISP-KEY       = 'X'.

  APPEND GS_FIELDCAT_DISP TO GT_FIELDCAT_DISP.



  " BUKRS - ####

  CLEAR GS_FIELDCAT_DISP.

  GS_FIELDCAT_DISP-FIELDNAME = 'BUKRS'.

  GS_FIELDCAT_DISP-SCRTEXT_M = '####'.

  GS_FIELDCAT_DISP-COL_POS   = 2.

  GS_FIELDCAT_DISP-OUTPUTLEN = 4.

  APPEND GS_FIELDCAT_DISP TO GT_FIELDCAT_DISP.



  " EKGRP - ####

  CLEAR GS_FIELDCAT_DISP.

  GS_FIELDCAT_DISP-FIELDNAME = 'EKGRP'.

  GS_FIELDCAT_DISP-SCRTEXT_M = '####'.

  GS_FIELDCAT_DISP-COL_POS   = 3.

  GS_FIELDCAT_DISP-OUTPUTLEN = 3.

  APPEND GS_FIELDCAT_DISP TO GT_FIELDCAT_DISP.



  " EKORG - ####

  CLEAR GS_FIELDCAT_DISP.

  GS_FIELDCAT_DISP-FIELDNAME = 'EKORG'.

  GS_FIELDCAT_DISP-SCRTEXT_M = '####'.

  GS_FIELDCAT_DISP-COL_POS   = 4.

  GS_FIELDCAT_DISP-OUTPUTLEN = 4.

  APPEND GS_FIELDCAT_DISP TO GT_FIELDCAT_DISP.



  " LIFNR - ###

  CLEAR GS_FIELDCAT_DISP.

  GS_FIELDCAT_DISP-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT_DISP-SCRTEXT_M = '###'.

  GS_FIELDCAT_DISP-COL_POS   = 5.

  GS_FIELDCAT_DISP-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT_DISP TO GT_FIELDCAT_DISP.



  " BEDAT - ###

  CLEAR GS_FIELDCAT_DISP.

  GS_FIELDCAT_DISP-FIELDNAME = 'BEDAT'.

  GS_FIELDCAT_DISP-SCRTEXT_M = '###'.

  GS_FIELDCAT_DISP-COL_POS   = 6.

  GS_FIELDCAT_DISP-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT_DISP TO GT_FIELDCAT_DISP.



  " WAERS - ##

  CLEAR GS_FIELDCAT_DISP.

  GS_FIELDCAT_DISP-FIELDNAME = 'WAERS'.

  GS_FIELDCAT_DISP-SCRTEXT_M = '##'.

  GS_FIELDCAT_DISP-COL_POS   = 7.

  GS_FIELDCAT_DISP-OUTPUTLEN = 5.

  APPEND GS_FIELDCAT_DISP TO GT_FIELDCAT_DISP.



  " EBELP - ####

  CLEAR GS_FIELDCAT_DISP.

  GS_FIELDCAT_DISP-FIELDNAME = 'EBELP'.

  GS_FIELDCAT_DISP-SCRTEXT_M = '##'.

  GS_FIELDCAT_DISP-COL_POS   = 8.

  GS_FIELDCAT_DISP-OUTPUTLEN = 5.

  APPEND GS_FIELDCAT_DISP TO GT_FIELDCAT_DISP.



  " MATNR - ####

  CLEAR GS_FIELDCAT_DISP.

  GS_FIELDCAT_DISP-FIELDNAME = 'MATNR'.

  GS_FIELDCAT_DISP-SCRTEXT_M = '####'.

  GS_FIELDCAT_DISP-COL_POS   = 9.

  GS_FIELDCAT_DISP-OUTPUTLEN = 18.

  APPEND GS_FIELDCAT_DISP TO GT_FIELDCAT_DISP.



  " MATNAME - ###

  CLEAR GS_FIELDCAT_DISP.

  GS_FIELDCAT_DISP-FIELDNAME = 'MATNAME'.

  GS_FIELDCAT_DISP-SCRTEXT_M = '###'.

  GS_FIELDCAT_DISP-COL_POS   = 10.

  GS_FIELDCAT_DISP-OUTPUTLEN = 20.

  APPEND GS_FIELDCAT_DISP TO GT_FIELDCAT_DISP.



  " MENGE - ##

  CLEAR GS_FIELDCAT_DISP.

  GS_FIELDCAT_DISP-FIELDNAME = 'MENGE'.

  GS_FIELDCAT_DISP-SCRTEXT_M = '##'.

  GS_FIELDCAT_DISP-COL_POS   = 11.

  GS_FIELDCAT_DISP-OUTPUTLEN = 13.

  APPEND GS_FIELDCAT_DISP TO GT_FIELDCAT_DISP.



  " MEINS - ##

  CLEAR GS_FIELDCAT_DISP.

  GS_FIELDCAT_DISP-FIELDNAME = 'MEINS'.

  GS_FIELDCAT_DISP-SCRTEXT_M = '##'.

  GS_FIELDCAT_DISP-COL_POS   = 12.

  GS_FIELDCAT_DISP-OUTPUTLEN = 3.

  APPEND GS_FIELDCAT_DISP TO GT_FIELDCAT_DISP.



  " BPRME - ##

  CLEAR GS_FIELDCAT_DISP.

  GS_FIELDCAT_DISP-FIELDNAME = 'STPRS'.

  GS_FIELDCAT_DISP-SCRTEXT_M = '##'.

  GS_FIELDCAT_DISP-COL_POS   = 13.

  GS_FIELDCAT_DISP-OUTPUTLEN = 13.

  APPEND GS_FIELDCAT_DISP TO GT_FIELDCAT_DISP.



  " PRDAT - ###

  CLEAR GS_FIELDCAT_DISP.

  GS_FIELDCAT_DISP-FIELDNAME = 'PRDAT'.

  GS_FIELDCAT_DISP-SCRTEXT_M = '###'.

  GS_FIELDCAT_DISP-COL_POS   = 14.

  GS_FIELDCAT_DISP-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT_DISP TO GT_FIELDCAT_DISP.



  " WERKS - ###

  CLEAR GS_FIELDCAT_DISP.

  GS_FIELDCAT_DISP-FIELDNAME = 'WERKS'.

  GS_FIELDCAT_DISP-SCRTEXT_M = '###'.

  GS_FIELDCAT_DISP-COL_POS   = 15.

  GS_FIELDCAT_DISP-OUTPUTLEN = 4.

  APPEND GS_FIELDCAT_DISP TO GT_FIELDCAT_DISP.



  " LGORT - ####

  CLEAR GS_FIELDCAT_DISP.

  GS_FIELDCAT_DISP-FIELDNAME = 'LGORT'.

  GS_FIELDCAT_DISP-SCRTEXT_M = '####'.

  GS_FIELDCAT_DISP-COL_POS   = 16.

  GS_FIELDCAT_DISP-OUTPUTLEN = 4.

  APPEND GS_FIELDCAT_DISP TO GT_FIELDCAT_DISP.

ENDFORM.