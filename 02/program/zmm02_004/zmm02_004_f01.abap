
*&---------------------------------------------------------------------*

*&  Include           ZMM02_004_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_INIT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_INIT .



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_SCREEN .

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'. "### # ##

      IF P_CRE = 'X'.

        SCREEN-ACTIVE = '1'.

      ELSEIF P_VIEW = 'X'.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  VALIDATE_INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM VALIDATE_INPUT .

  IF P_CRE = 'X'.

    IF P_EBELN IS INITIAL OR P_WERKS IS INITIAL OR P_BUDAT IS INITIAL.

      MESSAGE E000.

      EXIT.

    ENDIF.

  ELSEIF P_VIEW = 'X'.

    IF P_EBELN IS INITIAL OR P_WERKS IS INITIAL.

      MESSAGE E000.

      EXIT.

    ENDIF.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_PO

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_PO .

  DATA: LV_SUM_S   TYPE ZRSEG_02-MENGE, "##(S) ##

        LV_SUM_H   TYPE ZRSEG_02-MENGE, "##(H) ##

        LV_NET_QTY TYPE ZRSEG_02-MENGE, "## ## ## (S - H)

        LV_OPEN_QTY TYPE ZRSEG_02-MENGE. "## ##



  CLEAR: GT_PO.



  "## ##

  SELECT SINGLE * INTO GS_EKKO FROM ZEKKO_02 WHERE EBELN = P_EBELN.

  IF SY-SUBRC <> 0.

    MESSAGE '#### ## #### #####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  "### ##

  SELECT * INTO TABLE GT_EKPO FROM ZEKPO_02 WHERE EBELN = P_EBELN AND WERKS = P_WERKS.

  IF SY-SUBRC <> 0.

    MESSAGE '## #### #### ### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  LOOP AT GT_EKPO INTO GS_EKPO.

    CLEAR GS_PO.

    CLEAR: LV_SUM_S, LV_SUM_H, LV_NET_QTY.



    "##(S)## ## ## ##

    SELECT SUM( MENGE )

      INTO LV_SUM_S

      FROM ZRSEG_02

     WHERE EBELN = GS_EKPO-EBELN

       AND EBELP = GS_EKPO-EBELP

       AND SHKZG = 'S'. "##(Invoice)



    "##(H)# ## ## ##

    SELECT SUM( MENGE )

      INTO LV_SUM_H

      FROM ZRSEG_02

     WHERE EBELN = GS_EKPO-EBELN

       AND EBELP = GS_EKPO-EBELP

       AND SHKZG = 'H'. "##(Cancel)



    "## ## ## = (#### - ####)

    LV_NET_QTY = LV_SUM_S - LV_SUM_H.



    GS_PO-MENGE_TOT = GS_EKPO-MENGE.



    "## ## = PO## - ## ## ##

    LV_OPEN_QTY = GS_EKPO-MENGE - LV_NET_QTY.



    GS_PO-MENGE_OPEN = LV_OPEN_QTY.



    "## ### 0 #### ## (## # ## ### ### #)

    IF LV_OPEN_QTY <= 0.

      CONTINUE.

    ENDIF.



    MOVE-CORRESPONDING GS_EKPO TO GS_PO.

    MOVE-CORRESPONDING GS_EKKO TO GS_PO.



    GS_PO-BSTME = GS_EKPO-MEINS.

    GS_PO-MENGE = LV_OPEN_QTY. "## ### ##### ##

    GS_PO-WRBTR = GS_PO-MENGE * GS_PO-STPRS. "## = ## ## * ##



    "#### # ## ##

    SELECT SINGLE * INTO GS_LFM1 FROM ZLFM1_02 WHERE LIFNR = GS_EKKO-LIFNR.

    GS_PO-MWSKZ = GS_LFM1-MWSKZ.

    IF SY-SUBRC <> 0. GS_PO-MWSKZ = 'V1'. ENDIF.

    PERFORM CALCULATE_TAX USING GS_PO. "## ##



    GS_PO-SGTXT = GS_PO-MAKTX.

    APPEND GS_PO TO GT_PO.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM REFRESH USING PC_GRID TYPE REF TO CL_GUI_ALV_GRID.

  DATA : LS_STABLE TYPE LVC_S_STBL. "ALV #### ##### # ### ### ## ### ## ### ##(##)



  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD PC_GRID->REFRESH_TABLE_DISPLAY

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

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CALL_ALV USING PC_GRID TYPE REF TO CL_GUI_ALV_GRID CHANGING PT_FIELDCAT TYPE LVC_T_FCAT GT_OUTPUT TYPE STANDARD TABLE.

  DATA: LT_EXCLUDE TYPE UI_FUNCTIONS.

  APPEND CL_GUI_ALV_GRID=>MC_FC_LOC_INSERT_ROW TO LT_EXCLUDE. "# ## ## ##

  APPEND CL_GUI_ALV_GRID=>MC_FC_LOC_DELETE_ROW TO LT_EXCLUDE. "# ## ## ##

  APPEND CL_GUI_ALV_GRID=>MC_FC_LOC_COPY_ROW TO LT_EXCLUDE. "# ## ## ##

  APPEND CL_GUI_ALV_GRID=>MC_FC_LOC_APPEND_ROW TO LT_EXCLUDE. "### # ## ## ##

  APPEND CL_GUI_ALV_GRID=>MC_FC_LOC_CUT TO LT_EXCLUDE. "#### ## ##

  APPEND CL_GUI_ALV_GRID=>MC_FC_LOC_COPY TO LT_EXCLUDE. "## ## ##

  APPEND CL_GUI_ALV_GRID=>MC_FC_LOC_PASTE TO LT_EXCLUDE. "#### ## ##

  APPEND CL_GUI_ALV_GRID=>MC_FC_LOC_UNDO TO LT_EXCLUDE. "## ## ## ##



  CALL METHOD PC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*      I_BUFFER_ACTIVE               =

*      I_BYPASSING_BUFFER            =

*      I_CONSISTENCY_CHECK           =

*      I_STRUCTURE_NAME              =

*      IS_VARIANT                    =

*      I_SAVE                        =

*      I_DEFAULT                     = 'X'




      IS_LAYOUT                     = GS_LAYOUT




*      IS_PRINT                      =

*      IT_SPECIAL_GROUPS             =




      IT_TOOLBAR_EXCLUDING          = LT_EXCLUDE




*      IT_HYPERLINK                  =

*      IT_ALV_GRAPHICS               =

*      IT_EXCEPT_QINFO               =

*      IR_SALV_ADAPTER               =




    CHANGING

      IT_OUTTAB                     = GT_OUTPUT

      IT_FIELDCATALOG               = PT_FIELDCAT

      IT_SORT                       = GT_SORT




*      IT_FILTER                     =

*    EXCEPTIONS

*      INVALID_PARAMETER_COMBINATION = 1

*      PROGRAM_ERROR                 = 2

*      TOO_MANY_LINES                = 3

*      others                        = 4




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.

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

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT .

  CLEAR: GS_LAYOUT.

  GS_LAYOUT-ZEBRA      = 'X'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_100

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG_100 .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCHECK'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-CHECKBOX = 'X'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'BUKRS'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'EBELN'.

  GS_FIELDCAT-COLTEXT = '######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'MAKTX'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'MENGE_TOT'.

  GS_FIELDCAT-COLTEXT   = '# ##'.

  GS_FIELDCAT-REF_TABLE = 'ZEKPO_02'.

  GS_FIELDCAT-REF_FIELD = 'MENGE'.

  GS_FIELDCAT-QFIELDNAME = 'BSTME'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'MENGE_OPEN'.

  GS_FIELDCAT-COLTEXT   = '## ##'.

  GS_FIELDCAT-REF_TABLE = 'ZEKPO_02'.

  GS_FIELDCAT-REF_FIELD = 'MENGE'.

  GS_FIELDCAT-QFIELDNAME = 'BSTME'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-COLTEXT   = '## ##'.

  GS_FIELDCAT-EDIT      = 'X'.

  GS_FIELDCAT-REF_TABLE = 'ZEKPO_02'.

  GS_FIELDCAT-REF_FIELD = 'MENGE'.

  GS_FIELDCAT-QFIELDNAME = 'BSTME'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'BSTME'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'WRBTR'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-REF_TABLE = 'ZRSEG_02'.

  GS_FIELDCAT-REF_FIELD = 'WRBTR'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'WMWST'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  GS_FIELDCAT-REF_TABLE = 'ZRSEG_02'.

  GS_FIELDCAT-REF_FIELD = 'WRBTR'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'DMBTR'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  GS_FIELDCAT-REF_TABLE = 'ZRSEG_02'.

  GS_FIELDCAT-REF_FIELD = 'WRBTR'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'MWSKZ'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT02_MWSKZ'.

  GS_FIELDCAT-REF_FIELD = 'MWSKZ'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 15.

  GS_FIELDCAT-FIELDNAME = 'SGTXT'.

  GS_FIELDCAT-COLTEXT = '###'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-OUTPUTLEN = '20'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 16.

  GS_FIELDCAT-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_300

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG_300 .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCHECK'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-CHECKBOX = 'X'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'BELNR'.

  GS_FIELDCAT-COLTEXT = '######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'GJAHR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'BUZEI'.

  GS_FIELDCAT-COLTEXT = '#####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'BUKRS'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'EBELN'.

  GS_FIELDCAT-COLTEXT = '######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-QFIELDNAME = 'BSTME'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'BSTME'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'WRBTR'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'WMWST'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'DMBTR'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'MWSKZ'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 15.

  GS_FIELDCAT-FIELDNAME = 'SGTXT'.

  GS_FIELDCAT-COLTEXT = '###'.

  GS_FIELDCAT-OUTPUTLEN = '20'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 16.

  GS_FIELDCAT-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 17.

  GS_FIELDCAT-FIELDNAME = 'ZCANC'.

  GS_FIELDCAT-COLTEXT = '#######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 18.

  GS_FIELDCAT-FIELDNAME = 'ZCANDOC'.

  GS_FIELDCAT-COLTEXT = '######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT USING P_CON_NAME TYPE C

                   CHANGING GC_CUSTOM TYPE REF TO CL_GUI_CUSTOM_CONTAINER

                            GC_GRID TYPE REF TO CL_GUI_ALV_GRID.

  CREATE OBJECT GC_CUSTOM

    EXPORTING




*      PARENT                      =




      CONTAINER_NAME              = P_CON_NAME




*      STYLE                       =

*      LIFETIME                    = lifetime_default

*      REPID                       =

*      DYNNR                       =

*      NO_AUTODEF_PROGID_DYNNR     =

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



  CREATE OBJECT GC_GRID

    EXPORTING




*      I_SHELLSTYLE      = 0

*      I_LIFETIME        =




      I_PARENT          = GC_CUSTOM




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

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CLASS_EVENT CHANGING PC_GRID TYPE REF TO CL_GUI_ALV_GRID

                          PO_EVENT TYPE REF TO EVENT.

  "Register_edit : screen# ITAB ###

  CALL METHOD PC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED




*    EXCEPTIONS

*      ERROR      = 1

*      others     = 2




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.



  CREATE OBJECT PO_EVENT.

  SET HANDLER PO_EVENT->HANDLE_DATA_CHANGED FOR PC_GRID.

  SET HANDLER PO_EVENT->HANDLE_TOOLBAR FOR PC_GRID.

  SET HANDLER PO_EVENT->HANDLE_USER_COMMAND FOR PC_GRID.

  SET HANDLER PO_EVENT->HANDLE_DOUBLE_CLICK FOR PC_GRID.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLE_TOOLBAR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_OBJECT  text

*      -->P_E_INTERACTIVE  text

*----------------------------------------------------------------------*




FORM ALV_HANDLE_TOOLBAR  USING    E_OBJECT TYPE REF TO CL_ALV_EVENT_TOOLBAR_SET

                                  E_INTERACTIVE.

  IF P_VIEW = 'X'. "### ## ## ##

    DATA: LS_TOOLBAR TYPE STB_BUTTON.

    LS_TOOLBAR-BUTN_TYPE = 3.

    APPEND LS_TOOLBAR TO E_OBJECT->MT_TOOLBAR.



    CLEAR: LS_TOOLBAR.

    LS_TOOLBAR-FUNCTION = 'CANC_POST'.

    LS_TOOLBAR-ICON = ICON_DELETE_ROW.

    LS_TOOLBAR-TEXT = '####'.

    LS_TOOLBAR-BUTN_TYPE = 0.

    APPEND LS_TOOLBAR TO E_OBJECT->MT_TOOLBAR.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLE_USER_COMMAND

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_UCOMM  text

*----------------------------------------------------------------------*




FORM ALV_HANDLE_USER_COMMAND USING E_UCOMM TYPE SY-UCOMM.

  DATA: LT_SELECTED_ROWS LIKE GT_PO,

        LS_SELECTED_ROW  LIKE LINE OF GT_PO.



  " DB ##### ##

  DATA: LS_NEW_RBKP TYPE ZRBKP_02,

        LS_OLD_RBKP TYPE ZRBKP_02,

        LT_NEW_RSEG TYPE TABLE OF ZRSEG_02,

        LS_NEW_RSEG TYPE ZRSEG_02,

        LT_OLD_RSEG TYPE TABLE OF ZRSEG_02,

        LS_OLD_RSEG TYPE ZRSEG_02.



  DATA: LV_NEW_BELNR TYPE ZRBKP_02-BELNR,

        LV_CANC      TYPE C,

        LV_COUNT     TYPE I. " DB #### ##



  CASE E_UCOMM.

    WHEN 'CANC_POST'.

      LV_CANC = 0.



      IF SY-DYNNR = '0200'.

        CALL METHOD GC_GRID->CHECK_CHANGED_DATA.



        "### ##

        LOOP AT GT_RBKP INTO GS_RBKP WHERE ZCHECK = 'X'.



          "## ### ### ### ###### ## (STBLG ## ##)

          IF GS_RBKP-STBLG IS NOT INITIAL.

            MESSAGE '## ### ## #### #######.' TYPE 'S' DISPLAY LIKE 'E'.

            RETURN.

          ENDIF.



          "## ## ### ###, ## # ### ### #### ##

          "ZCANC = 'X' : ## # #### ### ## ## (## ### ##)

          "ZCANDOC = 'X': # ## ### ## ### (## ### # ## ##)

          CLEAR LV_COUNT.

          SELECT COUNT(*) INTO LV_COUNT

            FROM ZRSEG_02

           WHERE BELNR = GS_RBKP-BELNR

             AND GJAHR = GS_RBKP-GJAHR

             AND ( ZCANC = 'X' OR ZCANDOC = 'X' ).



          IF LV_COUNT > 0.

             MESSAGE '## ## ### #####, ## ### ### # ####.' TYPE 'S' DISPLAY LIKE 'E'.

             RETURN.

          ENDIF.



        ENDLOOP.



        "## ##

        LOOP AT GT_RBKP INTO GS_RBKP WHERE ZCHECK = 'X'.



          "## ##

          CALL FUNCTION 'NUMBER_GET_NEXT'

            EXPORTING

              NR_RANGE_NR = '01'

              OBJECT      = 'ZBELNR02'

            IMPORTING

              NUMBER      = LV_NEW_BELNR.



          "## ## ## ##

          MOVE-CORRESPONDING GS_RBKP TO LS_NEW_RBKP.

          LS_NEW_RBKP-BELNR = LV_NEW_BELNR.

          LS_NEW_RBKP-GJAHR = SY-DATUM(4).

          LS_NEW_RBKP-BUDAT = SY-DATUM.

          LS_NEW_RBKP-XRECH = ' '.

          LS_NEW_RBKP-STBLG = GS_RBKP-BELNR. "## ## ### ## ## ##

          LS_NEW_RBKP-XBLNR = GS_RBKP-BELNR.



          "## ### ##

          REFRESH: LT_OLD_RSEG, LT_NEW_RSEG.

          SELECT * FROM ZRSEG_02 INTO TABLE LT_OLD_RSEG

           WHERE BELNR = GS_RBKP-BELNR AND GJAHR = GS_RBKP-GJAHR.



          LOOP AT LT_OLD_RSEG INTO LS_OLD_RSEG.

            MOVE-CORRESPONDING LS_OLD_RSEG TO LS_NEW_RSEG.

            LS_NEW_RSEG-BELNR = LV_NEW_BELNR.

            LS_NEW_RSEG-GJAHR = SY-DATUM(4).



            "## ## ##### ZCANDOC 'X' ##

            LS_NEW_RSEG-ZCANDOC = 'X'.

            LS_NEW_RSEG-ZCANC   = ' '. " ## ### ## ## # #### ###



            IF LS_OLD_RSEG-SHKZG = 'S'. LS_NEW_RSEG-SHKZG = 'H'.

            ELSE.                       LS_NEW_RSEG-SHKZG = 'S'.

            ENDIF.

            APPEND LS_NEW_RSEG TO LT_NEW_RSEG.

          ENDLOOP.



          "DB ## (# ##)

          INSERT ZRBKP_02 FROM LS_NEW_RBKP.

          INSERT ZRSEG_02 FROM TABLE LT_NEW_RSEG.



          "## ### #### (### ##)

          UPDATE ZRSEG_02 SET ZCANC = 'X'

            WHERE BELNR = GS_RBKP-BELNR

              AND GJAHR = GS_RBKP-GJAHR.



          " ## ## #### (### ##)

          UPDATE ZRBKP_02 SET STBLG = LV_NEW_BELNR

            WHERE BELNR = GS_RBKP-BELNR

              AND GJAHR = GS_RBKP-GJAHR.



        ENDLOOP.



        IF SY-SUBRC = 0.

          COMMIT WORK AND WAIT.

          MESSAGE '## ### #######.' TYPE 'S'.

          PERFORM GET_RSEG.

          PERFORM GET_RBKP.

          PERFORM REFRESH USING GC_GRID.

        ELSE.

          MESSAGE '### ### ####.' TYPE 'S'.

        ENDIF.



      ELSEIF SY-DYNNR = '0300'.

        CALL METHOD GC_GRID300->CHECK_CHANGED_DATA.



        "### ## ### ##

        LOOP AT GT_PO_300 INTO GS_PO WHERE ZCHECK = 'X'.

          "### ###(ZCANC='X')# ## ## ##

          IF GS_PO-ZCANC = 'X'.

            MESSAGE '## ## ### ### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

            RETURN.

          ENDIF.



          IF GS_PO-ZCANDOC = 'X'.

            MESSAGE '## ### ### # ####.' TYPE 'S' DISPLAY LIKE 'E'.

            RETURN.

          ENDIF.



          APPEND GS_PO TO LT_SELECTED_ROWS.

        ENDLOOP.



        IF LT_SELECTED_ROWS IS INITIAL.

          MESSAGE '### ### ####.' TYPE 'S' DISPLAY LIKE 'W'.

          RETURN.

        ENDIF.



        SORT LT_SELECTED_ROWS BY BELNR GJAHR BUZEI.



        "## ##

        LOOP AT LT_SELECTED_ROWS INTO LS_SELECTED_ROW.



          "## ## ## (BELNR ## ###)

          ON CHANGE OF LS_SELECTED_ROW-BELNR.

             CLEAR: LS_NEW_RBKP, LS_OLD_RBKP, LV_NEW_BELNR.

             REFRESH: LT_NEW_RSEG.



             SELECT SINGLE * FROM ZRBKP_02 INTO LS_OLD_RBKP

               WHERE BELNR = LS_SELECTED_ROW-BELNR

                 AND GJAHR = LS_SELECTED_ROW-GJAHR.



             CALL FUNCTION 'NUMBER_GET_NEXT'

               EXPORTING NR_RANGE_NR = '01' OBJECT = 'ZBELNR02'

               IMPORTING NUMBER = LV_NEW_BELNR.



             MOVE-CORRESPONDING LS_OLD_RBKP TO LS_NEW_RBKP.

             LS_NEW_RBKP-BELNR = LV_NEW_BELNR.

             LS_NEW_RBKP-GJAHR = SY-DATUM(4).

             LS_NEW_RBKP-BUDAT = SY-DATUM.

             LS_NEW_RBKP-XRECH = ' '.

             LS_NEW_RBKP-XBLNR = LS_OLD_RBKP-BELNR.



          ENDON.



          "### ## ##

          CLEAR: LS_NEW_RSEG, LS_OLD_RSEG.

          SELECT SINGLE * FROM ZRSEG_02 INTO LS_OLD_RSEG

            WHERE BELNR = LS_SELECTED_ROW-BELNR

              AND BUZEI = LS_SELECTED_ROW-BUZEI.



          IF SY-SUBRC = 0.

             "## ### ##

             MOVE-CORRESPONDING LS_OLD_RSEG TO LS_NEW_RSEG.

             LS_NEW_RSEG-BELNR = LV_NEW_BELNR.

             LS_NEW_RSEG-GJAHR = SY-DATUM(4).



             "## ## ##### ZCANDOC 'X' ##

             LS_NEW_RSEG-ZCANDOC = 'X'.

             LS_NEW_RSEG-ZCANC   = ' '.



             IF LS_OLD_RSEG-SHKZG = 'S'. LS_NEW_RSEG-SHKZG = 'H'.

             ELSE.                       LS_NEW_RSEG-SHKZG = 'S'.

             ENDIF.

             APPEND LS_NEW_RSEG TO LT_NEW_RSEG.



             "## ### DB ####: ## ##(X)

             UPDATE ZRSEG_02 SET ZCANC = 'X'

               WHERE BELNR = LS_SELECTED_ROW-BELNR

                 AND BUZEI = LS_SELECTED_ROW-BUZEI.



             "## ## ### ## ### ### # ##

             LS_SELECTED_ROW-ZCANC = 'X'.

             MODIFY GT_PO_300 FROM LS_SELECTED_ROW

               TRANSPORTING ZCANC

               WHERE BELNR = LS_SELECTED_ROW-BELNR

                 AND BUZEI = LS_SELECTED_ROW-BUZEI.

          ENDIF.



          "## ## (## ###)

          DATA: LV_TABIX LIKE SY-TABIX.

          LV_TABIX = SY-TABIX + 1.

          READ TABLE LT_SELECTED_ROWS INTO DATA(LS_NEXT_ROW) INDEX LV_TABIX.



          IF SY-SUBRC <> 0 OR LS_NEXT_ROW-BELNR <> LS_SELECTED_ROW-BELNR.

             INSERT ZRBKP_02 FROM LS_NEW_RBKP.

             INSERT ZRSEG_02 FROM TABLE LT_NEW_RSEG.

             COMMIT WORK AND WAIT.

          ENDIF.



        ENDLOOP.



        "## ##

        PERFORM GET_RSEG.

        PERFORM GET_RBKP.

        PERFORM REFRESH USING GC_GRID.

        PERFORM REFRESH USING GC_GRID300.



        MESSAGE '## ## ### #######.' TYPE 'S'.



      ENDIF.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLE_DATA_CHANGED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_ER_DATA_CHANGED  text

*      -->P_E_ONF4  text

*      -->P_E_ONF4_BEFORE  text

*      -->P_E_ONF4_AFTER  text

*      -->P_E_UCOMM  text

*----------------------------------------------------------------------*




FORM ALV_HANDLE_DATA_CHANGED USING P_ER_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                   P_E_ONF4

                                   P_E_ONF4_BEFORE

                                   P_E_ONF4_AFTER

                                   P_E_UCOMM.



  DATA: LS_MOD_CELL TYPE LVC_S_MODI,

        LV_MENGE    TYPE ZRSEG_02-MENGE, "##

        LV_STPRS    TYPE ZEKPO_02-STPRS, "##

        LV_WRBTR    TYPE ZRSEG_02-WRBTR, "####

        LV_WMWST    TYPE ZRSEG_02-WMWST, "##

        LV_DMBTR    TYPE ZRSEG_02-WRBTR, "##

        LV_MWSKZ    TYPE ZRSEG_02-MWSKZ, "####

        LV_MOD      TYPE P DECIMALS 3.   "### ###



  LOOP AT P_ER_DATA_CHANGED->MT_MOD_CELLS INTO LS_MOD_CELL.



    "### ##: ##, ####, ####

    IF LS_MOD_CELL-FIELDNAME = 'MENGE' OR

       LS_MOD_CELL-FIELDNAME = 'MWSKZ' OR

       LS_MOD_CELL-FIELDNAME = 'WRBTR'.



      "## ### ## (###)

      READ TABLE GT_PO INTO GS_PO INDEX LS_MOD_CELL-ROW_ID.

      CHECK SY-SUBRC = 0.



      "## ### (## ### ##)

      LV_MENGE = GS_PO-MENGE.

      LV_MWSKZ = GS_PO-MWSKZ.

      LV_WRBTR = GS_PO-WRBTR.

      LV_STPRS = GS_PO-STPRS.



      IF LS_MOD_CELL-FIELDNAME = 'MENGE'.

        CALL METHOD P_ER_DATA_CHANGED->GET_CELL_VALUE

          EXPORTING I_ROW_ID = LS_MOD_CELL-ROW_ID I_FIELDNAME = 'MENGE'

          IMPORTING E_VALUE  = LV_MENGE.



      ELSEIF LS_MOD_CELL-FIELDNAME = 'MWSKZ'.

        CALL METHOD P_ER_DATA_CHANGED->GET_CELL_VALUE

          EXPORTING I_ROW_ID = LS_MOD_CELL-ROW_ID I_FIELDNAME = 'MWSKZ'

          IMPORTING E_VALUE  = LV_MWSKZ.



      ELSEIF LS_MOD_CELL-FIELDNAME = 'WRBTR'.

        CALL METHOD P_ER_DATA_CHANGED->GET_CELL_VALUE

          EXPORTING I_ROW_ID = LS_MOD_CELL-ROW_ID I_FIELDNAME = 'WRBTR'

          IMPORTING E_VALUE  = LV_WRBTR.

      ENDIF.



      IF LS_MOD_CELL-FIELDNAME = 'MENGE'.



        "EA ## ### ##

        IF GS_PO-BSTME = 'EA'.

          LV_MOD = LV_MENGE MOD 1.

          IF LV_MOD <> 0.

            CALL METHOD P_ER_DATA_CHANGED->ADD_PROTOCOL_ENTRY

              EXPORTING

                I_MSGID     = 'ZMM'

                I_MSGTY     = 'E'

                I_MSGNO     = '000'

                I_MSGV1     = 'EA ### #### ### # ####.'

                I_FIELDNAME = 'MENGE'

                I_ROW_ID    = LS_MOD_CELL-ROW_ID.

            CONTINUE.

          ENDIF.

        ENDIF.



        "#### ##

        IF GS_PO-MENGE_OPEN > 0 AND LV_MENGE > GS_PO-MENGE_OPEN.

           CALL METHOD P_ER_DATA_CHANGED->ADD_PROTOCOL_ENTRY

             EXPORTING

               I_MSGID     = 'ZMM'

               I_MSGTY     = 'E'

               I_MSGNO     = '001'

               I_MSGV1     = '## ### ### # ####.'

               I_FIELDNAME = 'MENGE'

               I_ROW_ID    = LS_MOD_CELL-ROW_ID.

           CONTINUE.

        ENDIF.



        "## * ## = #### ##

        LV_WRBTR = LV_MENGE * LV_STPRS.



        "### #### ## ##

        CALL METHOD P_ER_DATA_CHANGED->MODIFY_CELL

          EXPORTING I_ROW_ID = LS_MOD_CELL-ROW_ID I_FIELDNAME = 'WRBTR' I_VALUE = LV_WRBTR.



      ENDIF.



      "### ### #### ### ### ##

      IF LV_MWSKZ = 'V1' OR LV_MWSKZ = 'V5' OR LV_MWSKZ = 'V4'.

         LV_WMWST = LV_WRBTR * '0.1'.

      ELSE.

         LV_WMWST = 0.

      ENDIF.



      LV_DMBTR = LV_WRBTR + LV_WMWST.



      "## ##

      CALL METHOD P_ER_DATA_CHANGED->MODIFY_CELL

        EXPORTING I_ROW_ID = LS_MOD_CELL-ROW_ID I_FIELDNAME = 'WMWST' I_VALUE = LV_WMWST.



      CALL METHOD P_ER_DATA_CHANGED->MODIFY_CELL

        EXPORTING I_ROW_ID = LS_MOD_CELL-ROW_ID I_FIELDNAME = 'DMBTR' I_VALUE = LV_DMBTR.



      "DB ###(GT_PO) ##

      GS_PO-MENGE = LV_MENGE.

      GS_PO-MWSKZ = LV_MWSKZ.

      GS_PO-WRBTR = LV_WRBTR.

      GS_PO-WMWST = LV_WMWST.

      GS_PO-DMBTR = LV_DMBTR.



      MODIFY GT_PO FROM GS_PO INDEX LS_MOD_CELL-ROW_ID.



    ENDIF.

  ENDLOOP.

  CALL METHOD CL_GUI_CFW=>SET_NEW_OK_CODE

    EXPORTING

      NEW_CODE = 'ENTER'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  POST_PO

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM POST_PO .

  DATA: LV_BUZEI TYPE NUMC4,

        LV_TOTAL TYPE ZRSEG_02-WRBTR.



  CLEAR: GS_RBKP, GT_RBKP, GT_RSEG, GS_RSEG.

  CALL FUNCTION 'NUMBER_GET_NEXT'

    EXPORTING

      NR_RANGE_NR                   = '01'

      OBJECT                        = 'ZBELNR02'




*     QUANTITY                      = '1'

*     SUBOBJECT                     = ' '

*     TOYEAR                        = '0000'

*     IGNORE_BUFFER                 = ' '




   IMPORTING

     NUMBER                        = GS_RBKP-BELNR




*     QUANTITY                      =

*     RETURNCODE                    =

*   EXCEPTIONS

*     INTERVAL_NOT_FOUND            = 1

*     NUMBER_RANGE_NOT_INTERN       = 2

*     OBJECT_NOT_FOUND              = 3

*     QUANTITY_IS_0                 = 4

*     QUANTITY_IS_NOT_1             = 5

*     INTERVAL_OVERFLOW             = 6

*     BUFFER_OVERFLOW               = 7

*     OTHERS                        = 8




            .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.



  READ TABLE GT_PO INTO GS_PO INDEX 1.



  GS_RBKP-GJAHR = SY-DATUM(04). "####

  GS_RBKP-BUKRS = GS_PO-BUKRS. "####

  GS_RBKP-LIFNR = GS_PO-LIFNR. "####

  GS_RBKP-WAERS = GS_PO-WAERS. "##

  GS_RBKP-BLDAT = SY-DATUM. "###

  GS_RBKP-BUDAT = SY-DATUM. "###

  IF G_BKTXT IS NOT INITIAL.

    GS_RBKP-BKTXT = G_BKTXT.

  ELSE.

    GS_RBKP-BKTXT = '#### ####'. "## ###

  ENDIF.

  GS_RBKP-XRECH = 'X'.

  GS_RBKP-SECCO = 1000.

  GS_RBKP-BUPLA = 1000.

  GS_RBKP-MWSKZ1 = G_MWSKZ.

  GS_RBKP-WMWST1 = GV_WMWST.



  CLEAR: LV_BUZEI, LV_TOTAL. "### ###



  LOOP AT GT_PO INTO GS_PO WHERE ZCHECK = 'X'.

    CLEAR: GS_RSEG.



    LV_BUZEI = LV_BUZEI + 1.



    MOVE-CORRESPONDING GS_PO TO GS_RSEG.

    GS_RSEG-BELNR = GS_RBKP-BELNR.

    GS_RSEG-GJAHR = SY-DATUM(04). "####

    GS_RSEG-BUZEI = LV_BUZEI.

    GS_RSEG-SHKZG = 'S'.

    GS_RSEG-ZCANC = ' '.

    APPEND GS_RSEG TO GT_RSEG.



    LV_TOTAL = LV_TOTAL + GS_PO-DMBTR.

  ENDLOOP.

  GS_RBKP-RMWWR = LV_TOTAL.

  APPEND GS_RBKP TO GT_RBKP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_MSEG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_RSEG .



  CLEAR: GT_PO, GS_PO.

  SELECT A~BELNR "####

         A~BUZEI "####

         A~EBELN "######

         A~EBELP "######

         A~MATNR "####

         A~WERKS "###

         A~WRBTR "####

         A~WMWST "##

         A~MWSKZ "####

         B~BUKRS "####

         B~LIFNR "####

         B~WAERS "##

         B~BKTXT "#####

         A~SGTXT "######

         A~GJAHR "####

         A~MENGE "##

         A~BSTME "####

         A~ZCANC "####

         A~ZCANDOC "######

         B~MWSKZ1

         B~XRECH

         B~XBLNR

         B~WMWST1

    INTO CORRESPONDING FIELDS OF TABLE GT_PO

    FROM ZRSEG_02 AS A

    INNER JOIN ZRBKP_02 AS B

       ON A~BELNR = B~BELNR

      AND A~GJAHR = B~GJAHR

   WHERE A~EBELN = P_EBELN

     AND A~WERKS = P_WERKS.



  IF SY-SUBRC <> 0.

    MESSAGE '### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ELSE.



    LOOP AT GT_PO INTO GS_PO.

      GS_PO-DMBTR = GS_PO-WRBTR + GS_PO-WMWST.

      GS_PO-ZLIGHT = '@08@'.

      IF GS_PO-ZCANC = 'X'.

        GS_PO-ZLIGHT = '@0A@'.

      ENDIF.

      MODIFY GT_PO FROM GS_PO.

    ENDLOOP.



    MESSAGE '## ##' TYPE 'S'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALCULATE_TAX

*&---------------------------------------------------------------------*

* text

*----------------------------------------------------------------------*

*

*----------------------------------------------------------------------*




FORM CALCULATE_TAX CHANGING PS_PO LIKE GS_PO.



  "## ##

  CASE PS_PO-MWSKZ.

    WHEN 'V1' OR 'V5' OR 'V4'.

      PS_PO-WMWST = PS_PO-WRBTR * '0.1'.

    WHEN OTHERS.

      PS_PO-WMWST = 0.

  ENDCASE.



  "##(DMBTR) ##

  PS_PO-DMBTR = PS_PO-WRBTR + PS_PO-WMWST.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLE_DOUBLE_CLICK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_ROW  text

*      -->P_E_COLUMN  text

*      -->P_ES_ROW_NO  text

*----------------------------------------------------------------------*




FORM ALV_HANDLE_DOUBLE_CLICK  USING    P_ROW TYPE LVC_S_ROW

                                       P_COLUMN TYPE LVC_S_COL "###, # ####

                                       P_ROW_NO TYPE LVC_S_ROID." ## ###, # ####

  IF SY-DYNNR = '0200'.

  "#### ## ### #(Row)# #### ###

    READ TABLE GT_RBKP INTO GS_RBKP INDEX P_ROW-INDEX.



    IF SY-SUBRC = 0.

      GV_BELNR = GS_RBKP-BELNR.

      GV_GJAHR = GS_RBKP-GJAHR.



      "### ## ##

      CALL SCREEN 0300.



      PERFORM REFRESH USING GC_GRID.

    ENDIF.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG_200 .

  CLEAR : GS_FIELDCAT.

  REFRESH: GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCHECK'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-CHECKBOX = 'X'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'BELNR'.

  GS_FIELDCAT-COLTEXT = '######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'GJAHR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'BLDAT'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'BUDAT'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'BUKRS'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'RMWWR'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'BKTXT'.

  GS_FIELDCAT-COLTEXT = '###'.

  GS_FIELDCAT-OUTPUTLEN = '20'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'XBLNR'.

  GS_FIELDCAT-COLTEXT = '######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'XRECH'.

  GS_FIELDCAT-COLTEXT = '######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'WMWST1'.

  GS_FIELDCAT-COLTEXT = '# ##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'MWSKZ1'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_RBKP

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_RBKP .

  DATA: LT_PO_TEMP LIKE GT_PO.



  REFRESH GT_RBKP.



  "GT_RSEG ## GT_PO# #### ## ##

  IF GT_PO[] IS INITIAL.

    EXIT.

  ENDIF.



  "## #### ## ##(## #) ##

  LT_PO_TEMP[] = GT_PO[].

  SORT LT_PO_TEMP BY BELNR.

  DELETE ADJACENT DUPLICATES FROM LT_PO_TEMP COMPARING BELNR.



  "DB## ## ### ##

  SELECT *

    INTO CORRESPONDING FIELDS OF TABLE GT_RBKP

    FROM ZRBKP_02

    FOR ALL ENTRIES IN LT_PO_TEMP

   WHERE BELNR = LT_PO_TEMP-BELNR.



  SORT GT_RBKP BY BELNR DESCENDING.



  IF SY-SUBRC <> 0.

    MESSAGE '### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  LOOP AT GT_RBKP INTO GS_RBKP.



    GS_RBKP-ZLIGHT = '@08@'.



    IF GS_RBKP-STBLG IS NOT INITIAL.

       GS_RBKP-ZLIGHT = '@0A@'.



    ELSE.

       "DB## ## ### ### # ###(ZCANC='X') ## ### ##

       DATA: LV_DUMMY TYPE ZRSEG_02-BELNR.



       SELECT SINGLE BELNR INTO LV_DUMMY

         FROM ZRSEG_02

        WHERE BELNR = GS_RBKP-BELNR

          AND GJAHR = GS_RBKP-GJAHR

          AND ZCANC = 'X'.



       "### ### #### #### ###

       IF SY-SUBRC = 0.

         GS_RBKP-ZLIGHT = '@09@'.

       ENDIF.

    ENDIF.



    MODIFY GT_RBKP FROM GS_RBKP.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CAL_ALL_TAX

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CAL_ALL_TAX CHANGING P_WMWST .



  CLEAR: P_WMWST. "## ## ###



  LOOP AT GT_PO INTO GS_PO WHERE ZCHECK = 'X'. "### ## ##

    P_WMWST = P_WMWST + GS_PO-WMWST.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CAL_SUM

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CAL_SUM .

  CLEAR: G_SUM.

  LOOP AT GT_PO INTO GS_PO WHERE ZCHECK = 'X'.

    G_SUM = G_SUM + GS_PO-DMBTR.

  ENDLOOP.



  G_BALANCE = G_RMWWR - G_SUM.



  IF G_BALANCE = 0.

    G_LIGHT = ICON_LED_GREEN. "### (### ##: @08@)

  ELSE.

    G_LIGHT = ICON_LED_RED.   "### (### ##: @0A@)

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SIMULATION

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SIMULATION .

  CLEAR: GV_WMWST. "### ## ##

  IF G_BLDAT > G_BUDAT.

    GV_SIMUL = 1.

    MESSAGE '#### ##### #####. ### #####.' TYPE 'I' DISPLAY LIKE 'E'.

    EXIT.

  ENDIF.

  PERFORM CAL_ALL_TAX CHANGING GV_WMWST.

  IF G_CALTAX IS INITIAL.

    IF G_WMWST <> GV_WMWST. "## ### ### ## ## ##

      GV_SIMUL = 1.

      MESSAGE '### ### ### ### #### ####.' TYPE 'I' DISPLAY LIKE 'E'.

      EXIT.

    ENDIF.

  ENDIF.



  IF G_BALANCE <> 0.

    GV_SIMUL = 1.

    MESSAGE '### 0# ####. ### #####.' TYPE 'I' DISPLAY LIKE 'E'.

    EXIT.

  ELSE.

    GV_SIMUL = 0.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_GT_PO_300

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_GT_PO_300 .

  IF GV_BELNR IS NOT INITIAL.

    "## ## ##(GT_PO)# #### ## ##

    GT_PO_300[] = GT_PO[].



    "###(GT_PO_300)## ## ## # ##

    DELETE GT_PO_300 WHERE BELNR <> GV_BELNR

                        OR GJAHR <> GV_GJAHR.



    "## #### ### ## ## ##

    LOOP AT GT_PO_300 INTO GS_PO.

      GS_PO-DMBTR = GS_PO-WRBTR + GS_PO-WMWST.

      MODIFY GT_PO_300 FROM GS_PO.

    ENDLOOP.



  ENDIF.

ENDFORM.