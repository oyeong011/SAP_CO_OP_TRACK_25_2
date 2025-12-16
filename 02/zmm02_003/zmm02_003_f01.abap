
*&---------------------------------------------------------------------*

*&  Include           ZMM02_003_F01

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

*&      Form  GET_EKKO_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_EKKO_DATA .



  DATA: LV_GR_QTY TYPE ZEKPO_02-MENGE.

  CLEAR: GS_MSEG, GT_MSEG.



  SELECT SINGLE * "#### ## ##

    FROM ZEKKO_02

    INTO GS_EKKO

    WHERE EBELN = P_EBELN. "######

  IF GS_EKKO IS INITIAL.

    MESSAGE '#### ## #######.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  SELECT B~EBELN "######

         B~EBELP "##

         A~LIFNR "###

         A~BEDAT "###

         B~MATNR "####

         B~MAKTX "###

         B~MENGE "##

         B~MEINS "##

         B~STPRS "##

         A~WAERS "##

         B~PRDAT "###

         B~WERKS "###

         B~LGORT "####

    INTO CORRESPONDING FIELDS OF TABLE GT_PO

    FROM ZEKKO_02 AS A "#### ###

    INNER JOIN ZEKPO_02 AS B ON A~EBELN = B~EBELN

    WHERE A~EBELN = P_EBELN AND B~WERKS = P_WERKS.



  IF GT_PO IS INITIAL.

    MESSAGE E001.

    EXIT.

  ENDIF.



  SELECT * "### ## ##

    INTO CORRESPONDING FIELDS OF TABLE GT_MSEG

    FROM ZMSEG_02

    FOR ALL ENTRIES IN GT_PO

    WHERE EBELN = GT_PO-EBELN

      AND EBELP = GT_PO-EBELP.



  LOOP AT GT_PO INTO GS_PO.

    GS_PO-BSTMG = GS_PO-MENGE.

    CLEAR: LV_GR_QTY.



    LOOP AT GT_MSEG INTO GS_MSEG WHERE EBELN = GS_PO-EBELN

                                   AND EBELP = GS_PO-EBELP.



      CASE GS_MSEG-BWART. "####

        WHEN '101'. "### ### ## ##

          LV_GR_QTY = LV_GR_QTY + GS_MSEG-MENGE.

        WHEN '102'. "### ### ## ##

          LV_GR_QTY = LV_GR_QTY - GS_MSEG-MENGE.

      ENDCASE.



    ENDLOOP.



    "## ## ## (PO## - (## - ##))

    "## ## (#### - #####)

    GS_PO-OPEN_QTY = GS_PO-BSTMG - LV_GR_QTY.

    GS_PO-MENGE = GS_PO-OPEN_QTY.



    MODIFY GT_PO FROM GS_PO.

  ENDLOOP.



  DELETE GT_PO WHERE MENGE <= 0. "### ### ##### ## ##



  "### # ## #### ### ## ##

  IF GT_PO IS INITIAL.

    MESSAGE '## ## ### ### #######.' TYPE 'S' DISPLAY LIKE 'E'.

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

  GS_FIELDCAT-FIELDNAME = 'EBELN'.

  GS_FIELDCAT-COLTEXT = '######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'EBELP'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'BEDAT'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'MAKTX'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'BSTMG'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'OPEN_QTY'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-EDIT      = 'X'.

  GS_FIELDCAT-REF_TABLE = 'ZEKPO_02'.

  GS_FIELDCAT-REF_FIELD = 'MENGE'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'STPRS'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-REF_TABLE = 'ZEKPO_02'.

  GS_FIELDCAT-REF_FIELD = 'STPRS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'PRDAT'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 15.

  GS_FIELDCAT-FIELDNAME = 'WERKS'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 16.

  GS_FIELDCAT-FIELDNAME = 'LGORT'.

  GS_FIELDCAT-COLTEXT = '####'.

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

  CLEAR: GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-SEL_MODE = 'A'.

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

  SET HANDLER GO_EVENT->HANDLE_DATA_CHANGED FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLE_TOOLBAR FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLE_USER_COMMAND FOR GC_GRID.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV_100

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CALL_ALV.

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




      IT_TOOLBAR_EXCLUDING          = LT_EXCLUDE




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

*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLE_DATA_CHANGED

*&---------------------------------------------------------------------*




FORM ALV_HANDLE_DATA_CHANGED USING P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                   P_ONF4

                                   P_ONF4_BEFORE

                                   P_ONF4_AFTER

                                   P_UCOMM.



  DATA: LS_MODI  TYPE LVC_S_MODI,

        LV_MENGE TYPE ZEKPO_02-MENGE, "# ### ## ### ##

        LV_MOD TYPE P DECIMALS 3. "### ### ##



  LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.



    CASE LS_MODI-FIELDNAME.

      WHEN 'MENGE'. "##### #### #



        "## ## ## #### ### (## OPEN_QTY ###)

        READ TABLE GT_PO INTO GS_PO INDEX LS_MODI-ROW_ID.



        IF SY-SUBRC = 0.

          LV_MENGE = LS_MODI-VALUE. "#### ### ## ##### ##



          IF GS_PO-MEINS = 'EA'.  "### EA# ### ## (KG, L ## ##)

            LV_MOD = LV_MENGE MOD 1.



            IF LV_MOD <> 0. "#### ### # #### ##### #

              CALL METHOD P_DATA_CHANGED->ADD_PROTOCOL_ENTRY

                EXPORTING

                  I_MSGID     = '00'

                  I_MSGTY     = 'E'

                  I_MSGNO     = '001'

                  I_MSGV1     = 'EA ### #### ### # ####.'

                  I_FIELDNAME = LS_MODI-FIELDNAME

                  I_ROW_ID    = LS_MODI-ROW_ID.

              CONTINUE.

            ENDIF.

          ENDIF.



          "### ##: #### #### # ##

          IF LV_MENGE > GS_PO-OPEN_QTY.



            "## ### ##

            CALL METHOD P_DATA_CHANGED->ADD_PROTOCOL_ENTRY

              EXPORTING

                I_MSGID     = '00'         "### ###

                I_MSGTY     = 'E'          "## ##

                I_MSGNO     = '001'

                I_MSGV1     = '## ### ### ### # ####.'

                I_FIELDNAME = LS_MODI-FIELDNAME

                I_ROW_ID    = LS_MODI-ROW_ID.



          ELSEIF LV_MENGE <= 0.

             CALL METHOD P_DATA_CHANGED->ADD_PROTOCOL_ENTRY

              EXPORTING

                I_MSGID     = '00'

                I_MSGTY     = 'E'

                I_MSGNO     = '001'

                I_MSGV1     = '### 0## ## ###.'

                I_FIELDNAME = LS_MODI-FIELDNAME

                I_ROW_ID    = LS_MODI-ROW_ID.

          ENDIF.

        ENDIF.



    ENDCASE.

  ENDLOOP.



  "## ### ## # OK ## ##

  CALL METHOD CL_GUI_CFW=>SET_NEW_OK_CODE

    EXPORTING

      NEW_CODE = 'OK'.



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

  CLEAR: GS_MKPF, GT_MKPF, GT_MSEG, GS_MSEG.

  CALL FUNCTION 'NUMBER_GET_NEXT' "####

    EXPORTING

      NR_RANGE_NR                   = '01'

      OBJECT                        = 'ZMBLNR02'




*     QUANTITY                      = '1'

*     SUBOBJECT                     = ' '

*     TOYEAR                        = '0000'

*     IGNORE_BUFFER                 = ' '




   IMPORTING

     NUMBER                        = GS_MKPF-MBLNR




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



  GS_MKPF-MJAHR = P_BUDAT(4). "####

  GS_MKPF-BLART = 'WE'. "####

  GS_MKPF-BLDAT = G_BLDAT. "###

  GS_MKPF-BUDAT = G_BUDAT. "###

  APPEND GS_MKPF TO GT_MKPF.



  GV_ZEILE = '0001'.

  LOOP AT GT_PO INTO GS_PO.

    CLEAR: GS_MSEG.

    IF GS_PO-ZCHECK = 'X'.

      GS_MSEG-MBLNR = GS_MKPF-MBLNR. "######

      GS_MSEG-MJAHR = GS_MKPF-MJAHR. "####

      GS_MSEG-MATNR = GS_PO-MATNR. "###

      GS_MSEG-WERKS = GS_PO-WERKS. "###

      GS_MSEG-LGORT = GS_PO-LGORT. "####

      GS_MSEG-LIFNR = GS_PO-LIFNR. "###

      GS_MSEG-WAERS = GS_PO-WAERS. "##

      GS_MSEG-MENGE = GS_PO-MENGE. "##

      GS_MSEG-MEINS = GS_PO-MEINS. "####

      GS_MSEG-EBELN = GS_PO-EBELN. "######

      GS_MSEG-ZEILE = GV_ZEILE. "#####

      GS_MSEG-EBELP = GS_PO-EBELP. "##

      GS_MSEG-BWART = '101'. "####

      GS_MSEG-BUKRS = GS_EKKO-BUKRS. "####

      GS_MSEG-GJAHR = GS_MKPF-MJAHR. "####

      GS_MSEG-DMBTR = GS_PO-STPRS * GS_PO-MENGE. "##

      GS_MSEG-SHKZG = 'S'. "##(## ##)

      APPEND GS_MSEG TO GT_MSEG.

      GV_ZEILE = GV_ZEILE + 1.

    ENDIF.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_MSEG_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_MSEG_DATA .



  CLEAR: GS_PO, GT_PO.

  SELECT A~MBLNR "######

       A~MJAHR "####

       A~ZEILE "#####

       A~EBELN "#### ##

       A~EBELP "##

       A~MATNR "##

       A~MENGE "## ##

       A~WERKS "###

       B~BUDAT "###

       B~BLART "####

       B~BLDAT "###

       A~LGORT "####

       A~MEINS "##

       A~DMBTR "##

       A~BWART "####

       A~WAERS "##

       A~LIFNR "###

  INTO CORRESPONDING FIELDS OF TABLE GT_PO

  FROM ZMSEG_02 AS A "### ### ##

  INNER JOIN ZMKPF_02 AS B "## ### ##

     ON A~MBLNR = B~MBLNR "##### ##

    AND A~MJAHR = B~MJAHR "### ##

  WHERE A~EBELN = P_EBELN "#### ### ####

    AND A~WERKS = P_WERKS "#### ### ###

    AND A~BWART = '101'

    AND NOT EXISTS ( SELECT *

                         FROM ZMSEG_02

                        WHERE SMBLN = A~MBLNR

                          AND SMBLP = A~ZEILE

                          AND BWART = '102' ).

  IF GT_PO IS INITIAL.

    MESSAGE '### ##### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

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

  GS_FIELDCAT-FIELDNAME = 'ZCHECK'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-CHECKBOX = 'X'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-OUTPUTLEN = '4'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'MBLNR'.

  GS_FIELDCAT-COLTEXT = '######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'MJAHR'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-OUTPUTLEN = '7'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'BLART'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-OUTPUTLEN = '7'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'BLDAT'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'BUDAT'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZEILE'.

  GS_FIELDCAT-COLTEXT = '#####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'DMBTR'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-OUTPUTLEN = '4'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 16.

  GS_FIELDCAT-FIELDNAME = 'WERKS'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 17.

  GS_FIELDCAT-FIELDNAME = 'LGORT'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 18.

  GS_FIELDCAT-FIELDNAME = 'BWART'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-OUTPUTLEN = '8'.

  GS_FIELDCAT-JUST      = 'C'. " ### ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 19.

  GS_FIELDCAT-FIELDNAME = 'EBELN'.

  GS_FIELDCAT-COLTEXT   = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 20.

  GS_FIELDCAT-FIELDNAME = 'EBELP'.

  GS_FIELDCAT-COLTEXT   = 'PO##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



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



  DATA: LS_STABLE TYPE LVC_S_STBL.

  DATA: LV_VALID  TYPE C. "## ### ##

  DATA: LV_ZEILE TYPE ZMSEG_02-ZEILE.

  DATA: LV_MBLNR TYPE ZMSEG_02-MBLNR.



  CASE E_UCOMM.

    WHEN 'CANC_POST'.



      "### #### ### ### ### ###(GT_PO)# ##

      CALL METHOD GC_GRID->CHECK_CHANGED_DATA

        IMPORTING

          E_VALID = LV_VALID.



      "### ### ### ##

      READ TABLE GT_PO TRANSPORTING NO FIELDS WITH KEY ZCHECK = 'X'.

      IF SY-SUBRC <> 0.

        MESSAGE '### ### ##(##)###.' TYPE 'S' DISPLAY LIKE 'E'.

        EXIT.

      ENDIF.



      CLEAR: GS_MKPF, GT_MSEG, LV_ZEILE.



      "### #(ZCHECK = 'X')# ### ### ##

      LOOP AT GT_PO INTO GS_PO WHERE ZCHECK = 'X'.



        "## ## ##(102)# ## ##

        IF GS_PO-BWART = '102'.

          MESSAGE '## ### ### ### # ####.' TYPE 'S' DISPLAY LIKE 'E'.

          EXIT.

        ENDIF.



        "## DB# ## ### ### ##

        CLEAR LV_MBLNR.

        SELECT SINGLE MBLNR

          INTO LV_MBLNR

          FROM ZMSEG_02

          WHERE SMBLN = GS_PO-MBLNR

            AND SMBLP = GS_PO-ZEILE

            AND BWART = '102'.



        IF SY-SUBRC = 0.

          MESSAGE '## ## ### ### ## #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

          EXIT.

        ENDIF.



        "### ### ###

        CLEAR GS_MSEG.

        MOVE-CORRESPONDING GS_PO TO GS_MSEG.

        ADD 1 TO LV_ZEILE.

        GS_MSEG-ZEILE = LV_ZEILE.

        GS_MSEG-BWART = '102'. "#### 102 (##)

        GS_MSEG-SMBLN = GS_PO-MBLNR. "## #### ##

        GS_MSEG-SJAHR = GS_PO-MJAHR. "## ## ##

        GS_MSEG-SMBLP = GS_PO-ZEILE. "

        GS_MSEG-SHKZG = 'H'.



        APPEND GS_MSEG TO GT_MSEG.

      ENDLOOP.



      "### #### ## #### ## ## ##

      IF GT_MSEG IS INITIAL.

         EXIT.

      ENDIF.



      "DB ## # ## ##

      IF GT_MSEG IS NOT INITIAL.

        CALL FUNCTION 'NUMBER_GET_NEXT' "####

          EXPORTING

            NR_RANGE_NR             = '01'

            OBJECT                  = 'ZMBLNR02'

          IMPORTING

            NUMBER                  = GS_MKPF-MBLNR

          EXCEPTIONS

            OTHERS                  = 1.



        GS_MKPF-MJAHR = SY-DATUM(4).

        GS_MKPF-BLDAT = SY-DATUM.

        GS_MKPF-BUDAT = SY-DATUM.

        GS_MKPF-BLART = 'WE'.



        "### #### ### ## ## ####

        LOOP AT GT_MSEG INTO GS_MSEG.

          GS_MSEG-MBLNR = GS_MKPF-MBLNR. "######

          GS_MSEG-MJAHR = GS_MKPF-MJAHR. "####

          MODIFY GT_MSEG FROM GS_MSEG.

        ENDLOOP.



        INSERT ZMKPF_02 FROM GS_MKPF.

        INSERT ZMSEG_02 FROM TABLE GT_MSEG.



        IF SY-SUBRC = 0.

          COMMIT WORK.



          "### # ####

          LOOP AT GT_MSEG INTO GS_MSEG.

            DELETE GT_PO WHERE MBLNR = GS_MSEG-SMBLN

                           AND ZEILE = GS_MSEG-SMBLP.

          ENDLOOP.



          PERFORM REFRESH.



          MESSAGE '### ### ## #######.' TYPE 'S'.



        ELSE.

          ROLLBACK WORK.

          MESSAGE '## # ### ######.' TYPE 'E'.

        ENDIF.

      ENDIF.



  ENDCASE.

ENDFORM.