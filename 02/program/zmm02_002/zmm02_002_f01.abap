
*&---------------------------------------------------------------------*

*&  Include           ZMM02_002_F01

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

    IF SCREEN-GROUP1 = 'M2'. "### # ##

      IF P_CRE = 'X'.

        SCREEN-ACTIVE = '0'.

      ELSEIF P_VIEW = 'X'.

        SCREEN-ACTIVE = '1'.

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




FORM VALIDATE_INPUT . "SELECTION SCREEN## ##### ##

  IF P_CRE = 'X'.

    IF P_LIFNRC IS INITIAL OR P_BUKRS IS INITIAL OR P_BEDAT IS INITIAL.

      MESSAGE E000.

      EXIT.

    ENDIF.

  ELSEIF P_VIEW = 'X'.

    IF P_LIFNRV IS INITIAL OR P_BUKRS IS INITIAL OR P_EBELN IS INITIAL.

      MESSAGE E000.

      EXIT.

    ENDIF.

  ENDIF.

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

  CREATE OBJECT GC_CUSTOM

    EXPORTING




*      PARENT                      =




      CONTAINER_NAME              = 'CON1'




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

*&      Form  FIELD_CATALOG_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG_200 .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'EBELP'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'MAKTX'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-COLTEXT = 'PO##'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.

  GS_FIELDCAT-REF_TABLE  = 'EKPO'.

  GS_FIELDCAT-REF_FIELD  = 'MENGE'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'PRDAT'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'WERKS'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'LGORT'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'STPRS'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



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

  GS_FIELDCAT-FIELDNAME = 'EBELP'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'MAKTX'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-COLTEXT = 'PO##'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-REF_TABLE  = 'EKPO'.

  GS_FIELDCAT-REF_FIELD  = 'MENGE'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'BPRME'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'MWSKZ'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'PRDAT'.

  GS_FIELDCAT-COLTEXT = '###'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'WERKS'.

  GS_FIELDCAT-COLTEXT = '###'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-REF_TABLE = 'ZMARA_02'.

  GS_FIELDCAT-REF_FIELD = 'ZWERKS'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'LGORT'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-REF_TABLE = 'ZMARA_02'.

  GS_FIELDCAT-REF_FIELD = 'ZLGORT'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'STPRS'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  GS_FIELDCAT-EDIT = 'X'.

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



  GS_LAYOUT-SEL_MODE   = 'A'. "## ##

  GS_LAYOUT-ZEBRA      = 'X'. "### ##

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

*&      Form  CALL_ALV_100

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GT_FIELDCAT1  text

*----------------------------------------------------------------------*




FORM CALL_ALV_100.

  DATA: LT_EXCLUDE TYPE UI_FUNCTIONS.

  APPEND CL_GUI_ALV_GRID=>MC_FC_LOC_INSERT_ROW TO LT_EXCLUDE. "# ## ## ##

  APPEND CL_GUI_ALV_GRID=>MC_FC_LOC_DELETE_ROW TO LT_EXCLUDE. "# ## ## ##

  APPEND CL_GUI_ALV_GRID=>MC_FC_LOC_COPY_ROW TO LT_EXCLUDE. "# ## ## ##

  APPEND CL_GUI_ALV_GRID=>MC_FC_LOC_APPEND_ROW TO LT_EXCLUDE. "### # ## ## ##

  APPEND CL_GUI_ALV_GRID=>MC_FC_LOC_CUT TO LT_EXCLUDE. "#### ## ##

  APPEND CL_GUI_ALV_GRID=>MC_FC_LOC_COPY TO LT_EXCLUDE. "## ## ##

  APPEND CL_GUI_ALV_GRID=>MC_FC_LOC_PASTE TO LT_EXCLUDE. "#### ## ##

  APPEND CL_GUI_ALV_GRID=>MC_FC_LOC_UNDO TO LT_EXCLUDE. "## ## ## ##



  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

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




      IT_TOOLBAR_EXCLUDING          = LT_EXCLUDE "### ## ##




*      IT_HYPERLINK                  =

*      IT_ALV_GRAPHICS               =

*      IT_EXCEPT_QINFO               =

*      IR_SALV_ADAPTER               =




    CHANGING

      IT_OUTTAB                     = GT_PO

      IT_FIELDCATALOG               = GT_FIELDCAT

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

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_LFM1 .

  SELECT SINGLE *

    FROM ZLFM1_02 "######

    INTO GS_LFM1

    WHERE LIFNR = P_LIFNRC. "### ##

  IF GS_LFM1 IS INITIAL.

    MESSAGE '#### ## ######.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

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




FORM REFRESH .

  DATA : LS_STABLE TYPE LVC_S_STBL. "ALV #### ##### # ### ### ## ### ## ### ##(##)



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

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CLASS_EVENT .

  "Register_edit : screen# ITAB ###

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



  CREATE OBJECT GO_EVENT.

  SET HANDLER GO_EVENT->HANDLE_TOOLBAR FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLE_USER_COMMAND FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLE_DATA_CHANGED FOR GC_GRID.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLE_TOOLBAR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_HANDLE_TOOLBAR USING E_OBJECT TYPE REF TO CL_ALV_EVENT_TOOLBAR_SET

                              E_INTERACTIVE.



  IF P_CRE = 'X'. "### ## ## ##

    DATA: LS_TOOLBAR TYPE STB_BUTTON.

    LS_TOOLBAR-BUTN_TYPE = 3.

    APPEND LS_TOOLBAR TO E_OBJECT->MT_TOOLBAR.



    CLEAR: LS_TOOLBAR.

    LS_TOOLBAR-FUNCTION = 'ADD_ROW'.

    LS_TOOLBAR-ICON = ICON_INSERT_ROW.

    LS_TOOLBAR-TEXT = '####+'.

    LS_TOOLBAR-QUICKINFO = '## #####.'.

    LS_TOOLBAR-BUTN_TYPE = 0.

    APPEND LS_TOOLBAR TO E_OBJECT->MT_TOOLBAR.



    CLEAR: LS_TOOLBAR.

    LS_TOOLBAR-FUNCTION = 'DEL_ROW'.

    LS_TOOLBAR-ICON = ICON_DELETE_ROW.

    LS_TOOLBAR-TEXT = '####-'.

    LS_TOOLBAR-BUTN_TYPE = 0.

    APPEND LS_TOOLBAR TO E_OBJECT->MT_TOOLBAR.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLE_USER_COMMAND

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_HANDLE_USER_COMMAND USING E_UCOMM TYPE SY-UCOMM.



  DATA: LT_ROWS TYPE LVC_T_ROW, "### # #### ## ###

        LS_ROW TYPE LVC_S_ROW, "## # ### ###

        LS_COL TYPE LVC_S_COL, "## ## ## ###

        LV_LINES TYPE I. "### ### # ## ### ##

  FIELD-SYMBOLS: <FS_PO> LIKE LINE OF GT_PO. "GT_PO ### #### ## ### ## ##



  CASE E_UCOMM.

    WHEN 'ADD_ROW'. "#### ## ###

      CLEAR: GS_PO.

      DESCRIBE TABLE GT_PO LINES LV_LINES. "GT_PO# # # ## #### LV_LINES# ##



      GS_PO-EBELP = ( LV_LINES + 1 ) * 10.

      GS_PO-WAERS = GS_LFM1-WAERS.

      APPEND GS_PO TO GT_PO.

      PERFORM REFRESH.

      DESCRIBE TABLE GT_PO LINES LV_LINES. "## # ## ## ##

      LS_ROW-INDEX     = LV_LINES. "### ## #### LS_ROW #### ##

      LS_COL-FIELDNAME = 'MATNR'. "MATNR ### ## ##

      CALL METHOD GC_GRID->SET_CURRENT_CELL_VIA_ID "## ## ###

        EXPORTING

          IS_ROW_ID    = LS_ROW

          IS_COLUMN_ID = LS_COL.



    WHEN 'DEL_ROW'.

      CALL METHOD GC_GRID->GET_SELECTED_ROWS "ALV #### ## #### ### ## ### ###

        IMPORTING

          ET_INDEX_ROWS = LT_ROWS.

      IF LT_ROWS IS INITIAL. "### ## ## ##

        MESSAGE '### ### #####.' TYPE 'S' DISPLAY LIKE 'E'.

        EXIT.

      ENDIF.



      SORT LT_ROWS BY INDEX DESCENDING. "# #### ###### ##



      LOOP AT LT_ROWS INTO LS_ROW.

        DELETE GT_PO INDEX LS_ROW-INDEX.

      ENDLOOP.



      LOOP AT GT_PO ASSIGNING <FS_PO>.

        <FS_PO>-EBELP = SY-TABIX * 10. "## # ###

      ENDLOOP.



      PERFORM REFRESH.

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




FORM ALV_HANDLE_DATA_CHANGED  USING    P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                       P_ONF4

                                       P_ONF4_BEFORE

                                       P_ONF4_AFTER

                                       P_UCOMM.

  DATA: LS_MODI TYPE LVC_S_MODI,

        LV_MATNR TYPE ZMATNR02, "####

        LV_WERKS TYPE ZWERKS02, "###

        LV_MENGE_IN  TYPE P DECIMALS 3, "### ##

        LV_MEINS_CHK TYPE MEINS,        "### ##

        LV_MOD       TYPE P DECIMALS 3. "###

  CLEAR: LS_MODI.

  LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.

    "### ##

    CASE LS_MODI-FIELDNAME.

      WHEN 'MATNR'. "##### #### #

          CLEAR: GS_MARA.

          SELECT SINGLE *

            INTO GS_MARA "#####

            FROM ZMARA_02

            WHERE ZMATNR = LS_MODI-VALUE. "##### ###### ## ##### ##

        IF SY-SUBRC = 0.

          CALL METHOD P_DATA_CHANGED->MODIFY_CELL "### ####

            EXPORTING

              I_ROW_ID    = LS_MODI-ROW_ID

              I_FIELDNAME = 'MAKTX' "###

              I_VALUE     = GS_MARA-ZMATNAME.



          CALL METHOD P_DATA_CHANGED->MODIFY_CELL "## ####

            EXPORTING

              I_ROW_ID    = LS_MODI-ROW_ID

              I_FIELDNAME = 'BPRME'

              I_VALUE     = GS_MARA-MEINS.



          CALL METHOD P_DATA_CHANGED->MODIFY_CELL "#### ####

            EXPORTING

              I_ROW_ID    = LS_MODI-ROW_ID

              I_FIELDNAME = 'MEINS'

              I_VALUE     = GS_MARA-MEINS.

          IF GS_MARA-MEINS = 'EA'.



            "### #### ## ### ###

            CALL METHOD P_DATA_CHANGED->GET_CELL_VALUE

              EXPORTING

                I_ROW_ID    = LS_MODI-ROW_ID

                I_FIELDNAME = 'MENGE'

              IMPORTING

                E_VALUE     = LV_MENGE_IN.



            "### ##(0# ###), ##### ##

            IF LV_MENGE_IN IS NOT INITIAL.

               LV_MOD = LV_MENGE_IN MOD 1.



               IF LV_MOD <> 0.

                 CALL METHOD P_DATA_CHANGED->ADD_PROTOCOL_ENTRY

                   EXPORTING

                     I_MSGID     = '00'

                     I_MSGTY     = 'E'

                     I_MSGNO     = '001'

                     I_MSGV1     = '### ##(EA)# ### ### #####.'

                     I_FIELDNAME = 'MENGE'       " ## ### ## ### ##

                     I_ROW_ID    = LS_MODI-ROW_ID.

               ENDIF.

            ENDIF.

          ENDIF.

        ELSE.

          CALL METHOD P_DATA_CHANGED->ADD_PROTOCOL_ENTRY

            EXPORTING

              I_MSGID     = '00'

              I_MSGTY     = 'E'

              I_MSGNO     = '001'

              I_MSGV1     = '#### ## #####'

              I_FIELDNAME = LS_MODI-FIELDNAME

              I_ROW_ID    = LS_MODI-ROW_ID.

        ENDIF.

      WHEN 'PRDAT'. "### ###

        IF P_BEDAT > LS_MODI-VALUE. "###>#### #

          CALL METHOD P_DATA_CHANGED->ADD_PROTOCOL_ENTRY

            EXPORTING

              I_MSGID     = '00'

              I_MSGTY     = 'E'

              I_MSGNO     = '001'

              I_MSGV1     = '#### ##### ## # ####.'

              I_FIELDNAME = LS_MODI-FIELDNAME

              I_ROW_ID    = LS_MODI-ROW_ID.

        ENDIF.

      WHEN 'WERKS'. "### ###

        CALL METHOD P_DATA_CHANGED->GET_CELL_VALUE

          EXPORTING

            I_ROW_ID    = LS_MODI-ROW_ID




*            I_TABIX     =




            I_FIELDNAME = 'MATNR'

          IMPORTING

            E_VALUE     = LV_MATNR

            .

        IF LV_MATNR IS NOT INITIAL. "###### ##### ## ##->##### VALID_PO#### ##

          SELECT SINGLE *

              INTO GS_MARA

              FROM ZMARA_02 "#####

              WHERE ZMATNR = LV_MATNR AND ZWERKS = LS_MODI-VALUE. "##### ## ## #### ## ##### ##

          IF GS_MARA-ZWERKS <> LS_MODI-VALUE. "### ## ##

            CALL METHOD P_DATA_CHANGED->ADD_PROTOCOL_ENTRY

              EXPORTING

                I_MSGID     = '00'

                I_MSGTY     = 'E'

                I_MSGNO     = '001'

                I_MSGV1     = '#### ## ### ## ####.'

                I_FIELDNAME = LS_MODI-FIELDNAME

                I_ROW_ID    = LS_MODI-ROW_ID.

          ENDIF.

        ENDIF.

      WHEN 'LGORT'. "#### ###

        CALL METHOD P_DATA_CHANGED->GET_CELL_VALUE

          EXPORTING

            I_ROW_ID    = LS_MODI-ROW_ID




*            I_TABIX     =




            I_FIELDNAME = 'MATNR' "####

          IMPORTING

            E_VALUE     = LV_MATNR

            .

        CALL METHOD P_DATA_CHANGED->GET_CELL_VALUE

          EXPORTING

            I_ROW_ID    = LS_MODI-ROW_ID




*            I_TABIX     =




            I_FIELDNAME = 'WERKS' "###

          IMPORTING

            E_VALUE     = LV_WERKS.

            .

        IF LV_MATNR IS NOT INITIAL AND LV_WERKS IS NOT INITIAL. "####, ### ## #### ### ##->## ### VALID_PO #### ##

          SELECT SINGLE *

              INTO GS_MARA

              FROM ZMARA_02 "#####

              WHERE ZMATNR = LV_MATNR AND ZWERKS = LV_WERKS AND ZLGORT = LS_MODI-VALUE. "####, ###, #### ##

          IF GS_MARA-ZLGORT <> LS_MODI-VALUE. "### ## ##

            CALL METHOD P_DATA_CHANGED->ADD_PROTOCOL_ENTRY

              EXPORTING

                I_MSGID     = '00'

                I_MSGTY     = 'E'

                I_MSGNO     = '001'

                I_MSGV1     = '##### ## ### ## ####.'

                I_FIELDNAME = LS_MODI-FIELDNAME

                I_ROW_ID    = LS_MODI-ROW_ID.

          ENDIF.

        ENDIF.

      WHEN 'MENGE'.

        LV_MENGE_IN = LS_MODI-VALUE.



        "## ### ##(MEINS)# ####

        CALL METHOD P_DATA_CHANGED->GET_CELL_VALUE

          EXPORTING

            I_ROW_ID    = LS_MODI-ROW_ID

            I_FIELDNAME = 'MEINS'

          IMPORTING

            E_VALUE     = LV_MEINS_CHK.



        "### ## 'EA'# ##### ##

        IF LV_MEINS_CHK = 'EA'.

           LV_MOD = LV_MENGE_IN MOD 1.

           IF LV_MOD <> 0.

             CALL METHOD P_DATA_CHANGED->ADD_PROTOCOL_ENTRY

               EXPORTING

                 I_MSGID     = '00'

                 I_MSGTY     = 'E'

                 I_MSGNO     = '001'

                 I_MSGV1     = 'EA ### #### ### # ####.'

                 I_FIELDNAME = 'MENGE'

                 I_ROW_ID    = LS_MODI-ROW_ID.

             " #### # ## ##

             CONTINUE.

           ENDIF.

        ENDIF.

    ENDCASE.

  ENDLOOP.



  CALL METHOD CL_GUI_CFW=>SET_NEW_OK_CODE

    EXPORTING

      NEW_CODE = 'OK'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  APPEND_EKKO

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM APPEND_EKKO .



  CLEAR: GS_EKKO, GT_EKKO.

  CALL FUNCTION 'NUMBER_GET_NEXT' "SNRO# ## ##

    EXPORTING

      NR_RANGE_NR                   = '01'

      OBJECT                        = 'ZEBELN02'




*     QUANTITY                      = '1'

*     SUBOBJECT                     = ' '

*     TOYEAR                        = '0000'

*     IGNORE_BUFFER                 = ' '




   IMPORTING

     NUMBER                        = GS_EKKO-EBELN "######




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




* Implement suitable error handling here




  ENDIF.



  GS_EKKO-BUKRS = P_BUKRS. "####

  GS_EKKO-EKGRP = GS_LFM1-EKGRP. "####

  GS_EKKO-EKORG = GS_LFM1-EKORG. "####

  GS_EKKO-LIFNR = P_LIFNRC. "#####

  GS_EKKO-BEDAT = P_BEDAT. "###

  GS_EKKO-WAERS = GS_LFM1-WAERS. "##



  APPEND GS_EKKO TO GT_EKKO.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  APPEND_EKPO

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM APPEND_EKPO .

  CLEAR: GT_EKPO.

  LOOP AT GT_PO INTO GS_PO.

    CLEAR: GS_EKPO.

    GS_EKPO-EBELN = GS_EKKO-EBELN. "######

    GS_EKPO-EBELP = GS_PO-EBELP. "##

    GS_EKPO-MATNR = GS_PO-MATNR. "####

    GS_EKPO-MAKTX = GS_PO-MAKTX. "###

    GS_EKPO-MENGE = GS_PO-MENGE. "##

    GS_EKPO-MEINS = GS_PO-MEINS. "####

    GS_EKPO-BPRME = GS_PO-BPRME. "##

    GS_EKPO-PRDAT = GS_PO-PRDAT. "###

    GS_EKPO-WERKS = GS_PO-WERKS. "###

    GS_EKPO-LGORT = GS_PO-LGORT. "####

    GS_EKPO-STPRS = GS_PO-STPRS. "##

    APPEND GS_EKPO TO GT_EKPO.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  VALID_PO

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM VALID_PO CHANGING PV_ERROR TYPE C.

  DATA: LV_DUMMY TYPE C. "## ## ### ### ##

  LOOP AT GT_PO INTO GS_PO.

    IF GS_PO-MATNR IS INITIAL "####

       OR GS_PO-MAKTX IS INITIAL "###

       OR GS_PO-MENGE IS INITIAL "##

       OR GS_PO-MEINS IS INITIAL "####

       OR GS_PO-BPRME IS INITIAL "##

       OR GS_PO-PRDAT IS INITIAL "###

       OR GS_PO-WERKS IS INITIAL "###

       OR GS_PO-LGORT IS INITIAL "####

       OR GS_PO-STPRS IS INITIAL. "##

      MESSAGE '## #### #####.' TYPE 'S' DISPLAY LIKE 'E'.

      PERFORM SET_CURSOR_ON_ERROR USING SY-TABIX 'MATNR'.

      PV_ERROR = 'X'.

      EXIT.

    ENDIF.



    "### ##

    SELECT SINGLE ZMATNR

      INTO LV_DUMMY

      FROM ZMARA_02

      WHERE ZMATNR = GS_PO-MATNR

        AND ZWERKS = GS_PO-WERKS.

    IF SY-SUBRC <> 0.

      MESSAGE '## ##### #### ## #####.' TYPE 'S' DISPLAY LIKE 'E'.

      PERFORM SET_CURSOR_ON_ERROR USING SY-TABIX 'WERKS'. "#### ## ##

      PV_ERROR = 'X'.

      EXIT.

    ENDIF.



    "#### ##

    SELECT SINGLE ZMATNR

      INTO LV_DUMMY

      FROM ZMARA_02

      WHERE ZMATNR = GS_PO-MATNR

        AND ZWERKS = GS_PO-WERKS

        AND ZLGORT = GS_PO-LGORT.

    IF SY-SUBRC <> 0.

      MESSAGE '## #### ##### ## ### ####.' TYPE 'S' DISPLAY LIKE 'E'.

      PERFORM SET_CURSOR_ON_ERROR USING SY-TABIX 'LGORT'. "##### ## ##

      PV_ERROR = 'X'.

      EXIT.

    ENDIF.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_EKPO

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_EKPO. "### ##



  DATA: LT_DB_EKPO TYPE TABLE OF ZEKPO_02,

        LS_DB_EKPO TYPE ZEKPO_02.



  CLEAR: GS_EKKO, GT_EKKO, GT_PO. " GT_EKPO ## GT_PO# ###



  "## ## (## ##)

  SELECT SINGLE *

    INTO GS_EKKO

    FROM ZEKKO_02

    WHERE EBELN = P_EBELN AND LIFNR = P_LIFNRV.



  IF GS_EKKO IS INITIAL.

    MESSAGE '#### ## #######.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  "## DB ## (## DB ### ### ##)

  SELECT *

    INTO TABLE LT_DB_EKPO

    FROM ZEKPO_02

    WHERE EBELN = P_EBELN.



  "DB ### -> ### ###(GT_PO)# ## + ## # ##

  LOOP AT LT_DB_EKPO INTO LS_DB_EKPO.

    CLEAR GS_PO.



    "### ## ## # ## (EBELP, MATNR, MENGE, STPRS #)

    MOVE-CORRESPONDING LS_DB_EKPO TO GS_PO.



    "## ### ## ## # ## ##!

    GS_PO-WAERS = GS_EKKO-WAERS.



    "GT_PO# ##

    APPEND GS_PO TO GT_PO.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_CURSOR_ON_ERROR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_SY_TABIX  text

*      -->P_1247   text

*----------------------------------------------------------------------*




FORM SET_CURSOR_ON_ERROR  USING P_INDEX P_FIELD. "## ##

  DATA: LS_ROW TYPE LVC_S_ROW,

        LS_COL TYPE LVC_S_COL.



  LS_ROW-INDEX     = P_INDEX.

  LS_COL-FIELDNAME = P_FIELD.



  CALL METHOD GC_GRID->SET_CURRENT_CELL_VIA_ID

    EXPORTING

      IS_ROW_ID    = LS_ROW

      IS_COLUMN_ID = LS_COL.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CALL_ALV_200 .

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

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

*      IT_TOOLBAR_EXCLUDING          = LT_EXCLUDE

*      IT_HYPERLINK                  =

*      IT_ALV_GRAPHICS               =

*      IT_EXCEPT_QINFO               =

*      IR_SALV_ADAPTER               =




    CHANGING

      IT_OUTTAB                     = GT_PO

      IT_FIELDCATALOG               = GT_FIELDCAT

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