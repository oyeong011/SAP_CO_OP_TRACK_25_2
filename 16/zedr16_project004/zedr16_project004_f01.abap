
*&---------------------------------------------------------------------*

*&  Include           ZEDR16_PROJECT004_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  CHECK_INPUT_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_INPUT_DATA .



  " ## #### ### ## ## (### ### ### ##)

  DATA: LV_CHECK_EBELN TYPE ZEDT16_EKKO-EBELN.

  DATA: LV_CHECK_WERKS TYPE ZEDT16_EKPO-WERKS.



  " 0. P_DATE(##) ## ##

  IF P_DATE IS INITIAL.

    MESSAGE '###(##)# ######.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  " 1. P_EBELN1(####) ## ##

  IF P_EBELN1 IS INITIAL.

    MESSAGE '#### ### ######.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  " 2. ZEDT16_EKKO ## ## ##

  CLEAR LV_CHECK_EBELN.

  SELECT SINGLE EBELN

    INTO LV_CHECK_EBELN

    FROM ZEDT16_EKKO

    WHERE EBELN = P_EBELN1.



  IF SY-SUBRC <> 0.

    MESSAGE '#### ## #### #####.' TYPE 'I'.

    STOP.

  ENDIF.



  " 3. P_WERKS1(###) ## ## ## ##

  IF P_WERKS1 IS NOT INITIAL.

    CLEAR LV_CHECK_WERKS.



    SELECT SINGLE WERKS

      INTO LV_CHECK_WERKS

      FROM ZEDT16_EKPO

      WHERE EBELN = P_EBELN1

        AND WERKS = P_WERKS1.



    IF SY-SUBRC <> 0.

      MESSAGE '## ##### #### ## ######.' TYPE 'I'.

      STOP.

    ENDIF.

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




FORM GET_DATA .



  " 1. ## ## ###

  CLEAR : GS_PO_HEADER, GS_PO_ITEM, GS_ALV, GS_INVOICE_HEADER.

  REFRESH : GT_PO_ITEM, GT_ALV, GT_INVOICE_HEADER.



  " -------------------------------------------------------------

  " 2. #### ## ## (ZEDT16_EKKO -> GS_PO_HEADER)

  " -------------------------------------------------------------

  SELECT SINGLE *

    INTO GS_PO_HEADER

    FROM ZEDT16_EKKO

    WHERE EBELN = P_EBELN1.



  IF SY-SUBRC <> 0.

    MESSAGE '## #### ### ## # ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  " =============================================================

  " [##] ### ###(LFM1)## #### ## #

  " =============================================================

  " ##: ###(LIFNR) + ####(EKORG)

  SELECT SINGLE MWSKZ

    INTO GS_INVOICE_HEADER-MWSKZ

    FROM ZEDT16_LFM1

    WHERE LIFNR = GS_PO_HEADER-LIFNR

      AND EKORG = GS_PO_HEADER-EKORG.



  SELECT SINGLE ZTERM

    INTO GS_INVOICE_HEADER-ZTERM

    FROM ZEDT16_LFB1

    WHERE LIFNR = GS_PO_HEADER-LIFNR

    AND BUKRS = GS_PO_HEADER-BUKRS.





  " =============================================================

  " [##] ## ##(GS_INVOICE_HEADER) ##

  " =============================================================

  " (1) PO ## ## ## (EBELN, BUKRS, LIFNR, BEDAT #)

  MOVE-CORRESPONDING GS_PO_HEADER TO GS_INVOICE_HEADER.



  " (2) ### ### ## (###, ###)

  GS_INVOICE_HEADER-BLDAT = P_DATE.    " ## ###

  GS_INVOICE_HEADER-WERKS = P_WERKS1.  " ###



  " (3) ### ##(NAME1) ## (ZEDT16_LFA1)

  SELECT SINGLE NAME1

    INTO GS_INVOICE_HEADER-NAME1

    FROM ZEDT16_LFA1

    WHERE LIFNR = GS_PO_HEADER-LIFNR.



  " (4) #### ## (## ###)

  APPEND GS_INVOICE_HEADER TO GT_INVOICE_HEADER.

  " =============================================================





  " -------------------------------------------------------------

  " 3. #### ### ## (ZEDT16_EKPO -> GT_PO_ITEM)

  " -------------------------------------------------------------

  IF P_WERKS1 IS NOT INITIAL.

    SELECT *

      INTO TABLE GT_PO_ITEM

      FROM ZEDT16_EKPO

      WHERE EBELN = P_EBELN1

        AND WERKS = P_WERKS1.

  ELSE.

    SELECT *

      INTO TABLE GT_PO_ITEM

      FROM ZEDT16_EKPO

      WHERE EBELN = P_EBELN1.

  ENDIF.



  IF GT_PO_ITEM[] IS INITIAL.

    MESSAGE '### ## #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  " -------------------------------------------------------------

  " 4. ALV ###(GT_ALV) ##

  " -------------------------------------------------------------

  LOOP AT GT_PO_ITEM INTO GS_PO_ITEM.

    CLEAR GS_ALV.



    " [# ##]

    GS_ALV-EBELN = GS_PO_ITEM-EBELN.

    GS_ALV-EBELP = GS_PO_ITEM-EBELP.

    GS_ALV-WERKS = GS_PO_ITEM-WERKS.



    " [## ##]

    GS_ALV-MATNR = GS_PO_ITEM-MATNR.

    GS_ALV-MAKTX = GS_PO_ITEM-MAKTX.

    GS_ALV-LGORT = GS_PO_ITEM-LGORT.



    " [## ##]

    GS_ALV-MENGE = GS_PO_ITEM-MENGE. " PO # ##

    GS_ALV-MEINS = GS_PO_ITEM-MEINS. " ##



    " [## # ##]

    GS_ALV-BPRME = GS_PO_ITEM-BPRME.

    GS_ALV-WAERS = GS_PO_HEADER-WAERS.



    GS_ALV-MWSKZ = GS_INVOICE_HEADER-MWSKZ.



    " [##]

    GS_ALV-SHKZG = 'S'.



    APPEND GS_ALV TO GT_ALV.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DATA .



  DATA: LV_S_QTY    TYPE ZEDT16_RSEG-MENGE, " [##] ##(S)

        LV_H_QTY    TYPE ZEDT16_RSEG-MENGE, " [##] ##(H)

        LV_GR_S_QTY TYPE ZEDT16_MSEG-MENGE, " [##] ##(S)

        LV_GR_H_QTY TYPE ZEDT16_MSEG-MENGE, " [##] ##(H)

        LV_GR_TOTAL TYPE ZEDT16_MSEG-MENGE, " [##] ## ###

        LV_TAX_RATE TYPE P DECIMALS 2.      " ##



  " ## ### (####)

  DATA: LV_INVOICE_DATE TYPE BUDAT.

  LV_INVOICE_DATE = P_DATE.



  LOOP AT GT_ALV INTO GS_ALV.



    CLEAR: LV_S_QTY, LV_H_QTY, LV_GR_S_QTY, LV_GR_H_QTY, LV_GR_TOTAL, LV_TAX_RATE.



    " =========================================================

    " 1. ### ##(WEMNG) ## (## ##)

    " =========================================================

    " (1) ## ##(S)

    SELECT SUM( MENGE ) INTO LV_S_QTY

      FROM ZEDT16_RSEG

      WHERE EBELN = GS_ALV-EBELN

        AND EBELP = GS_ALV-EBELP

        AND SHKZG = 'S'.



    " (2) ## ##(H)

    SELECT SUM( MENGE ) INTO LV_H_QTY

      FROM ZEDT16_RSEG

      WHERE EBELN = GS_ALV-EBELN

        AND EBELP = GS_ALV-EBELP

        AND SHKZG = 'H'.



    " (3) ## ### ##

    GS_ALV-WEMNG = LV_S_QTY - LV_H_QTY.





    " =========================================================

    " 2. ## ##(MENGE) ## # #### ## ## #

    "    (WEBRE ## # # -> ## ## ### ## ##, ### PO ##)

    " =========================================================



    " A-1. ##(S) ## (##: ### <= ###)

    SELECT SUM( MENGE ) INTO LV_GR_TOTAL

      FROM ZEDT16_MSEG

      WHERE EBELN = GS_ALV-EBELN

        AND MATNR = GS_ALV-MATNR

        AND WERKS = GS_ALV-WERKS

        AND LGORT = GS_ALV-LGORT.




*        AND SHKZG = 'S'.



*    " A-2. ##(H) ## (##: ### <= ###)

*    SELECT SUM( MENGE ) INTO LV_GR_H_QTY

*      FROM ZEDT16_MSEG

*      WHERE EBELN = GS_ALV-EBELN

*        AND MATNR = GS_ALV-MATNR

*        AND WERKS = GS_ALV-WERKS

*        AND LGORT = GS_ALV-LGORT

*        AND SHKZG = 'H'.






    " A-3. ## ## ## ##




*    LV_GR_TOTAL = LV_GR_S_QTY - LV_GR_H_QTY.






    " # ## ## ## #

    IF LV_GR_TOTAL > 0.

      " [CASE A] ### ### ### -> ## ### #### ##

      GS_ALV-MENGE = LV_GR_TOTAL.

    ELSE.

      " [CASE B] ### ### ##(0) -> PO ## ### ##

      " (GET_DATA## ## PO #### #### #### #### # ## #)

    ENDIF.





    " =========================================================

    " 3. ##(OPEN_QTY) ##

    " =========================================================

    " ### ### MENGE(PO## ## ####) - ### ##

    GS_ALV-OPEN_QTY = GS_ALV-MENGE - GS_ALV-WEMNG.



    " ### ### #### ##

    IF GS_ALV-OPEN_QTY <= 0.

      DELETE GT_ALV.

      CONTINUE.

    ENDIF.



    " ## ## ## ###

    GS_ALV-ERFMG = GS_ALV-OPEN_QTY.





    " =========================================================

    " 4. ## # ## ## (## ##)

    " =========================================================

    GS_ALV-WRBTR = GS_ALV-ERFMG * GS_ALV-BPRME.



    CASE GS_ALV-MWSKZ.

      WHEN 'V1' OR 'V4' OR 'V5'. LV_TAX_RATE = '0.10'.

      WHEN 'V2' OR 'V3'.         LV_TAX_RATE = '0.00'.

      WHEN OTHERS.               LV_TAX_RATE = '0.00'.

    ENDCASE.



    GS_ALV-WMWST = GS_ALV-WRBTR * LV_TAX_RATE.

    GS_ALV-DMBTR = GS_ALV-WRBTR + GS_ALV-WMWST.



    " =========================================================

    " 5. [##] ##(SGTXT) ## ## (PO## + ####)

    " =========================================================

    " ## ##: "4500001234 ####"

    CONCATENATE GS_ALV-EBELN '+ ####'

           INTO GS_ALV-SGTXT

           SEPARATED BY SPACE.



    MODIFY GT_ALV FROM GS_ALV.



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



  CREATE OBJECT GC_CUSTOM

    EXPORTING




*     PARENT         =




      CONTAINER_NAME = 'CON1'




*     STYLE          =

*     LIFETIME       = lifetime_default

*     REPID          =

*     DYNNR          =

*     NO_AUTODEF_PROGID_DYNNR     =

*    EXCEPTIONS

*     CNTL_ERROR     = 1

*     CNTL_SYSTEM_ERROR           = 2

*     CREATE_ERROR   = 3

*     LIFETIME_ERROR = 4

*     LIFETIME_DYNPRO_DYNPRO_LINK = 5

*     OTHERS         = 6




    .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



  CREATE OBJECT GC_GRID

    EXPORTING




*     I_SHELLSTYLE      = 0

*     I_LIFETIME        =




      I_PARENT = GC_CUSTOM




*     I_APPL_EVENTS     = space

*     I_PARENTDBG       =

*     I_APPLOGPARENT    =

*     I_GRAPHICSPARENT  =

*     I_NAME   =

*     I_FCAT_COMPLETE   = SPACE

*    EXCEPTIONS

*     ERROR_CNTL_CREATE = 1

*     ERROR_CNTL_INIT   = 2

*     ERROR_CNTL_LINK   = 3

*     ERROR_DP_CREATE   = 4

*     OTHERS   = 5




    .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




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




FORM FIELD_CATALOG .



  CLEAR : GS_FIELDCAT, GT_FIELDCAT.



  " 1. L_CHECK : #### (## ##)

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 1.

  GS_FIELDCAT-FIELDNAME = 'L_CHECK'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-CHECKBOX  = 'X'.

  GS_FIELDCAT-EDIT      = 'X'.       " # ## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 2. EBELN : ######

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 2.

  GS_FIELDCAT-FIELDNAME = 'EBELN'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_EKPO'.

  GS_FIELDCAT-REF_FIELD = 'EBELN'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 3. EBELP : ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 3.

  GS_FIELDCAT-FIELDNAME = 'EBELP'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_EKPO'.

  GS_FIELDCAT-REF_FIELD = 'EBELP'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 4. WERKS : ###

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 4.

  GS_FIELDCAT-FIELDNAME = 'WERKS'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_EKPO'.

  GS_FIELDCAT-REF_FIELD = 'WERKS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 5. MATNR : ####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 5.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_EKPO'.

  GS_FIELDCAT-REF_FIELD = 'MATNR'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 6. MAKTX : ###

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 6.

  GS_FIELDCAT-FIELDNAME = 'MAKTX'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_EKPO'.

  GS_FIELDCAT-REF_FIELD = 'MAKTX'.

  GS_FIELDCAT-OUTPUTLEN = 20.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " ------------------------------------------------------------------

  " [## ##] - MEINS(##) ## ##

  " ------------------------------------------------------------------



  " 7. MENGE : # PO ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 7.

  GS_FIELDCAT-FIELDNAME  = 'MENGE'.

  GS_FIELDCAT-COLTEXT    = '####'.

  GS_FIELDCAT-REF_TABLE  = 'ZEDT16_EKPO'.

  GS_FIELDCAT-REF_FIELD  = 'MENGE'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.      " ## ## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 8. WEMNG : ### ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 8.

  GS_FIELDCAT-FIELDNAME  = 'WEMNG'.

  GS_FIELDCAT-COLTEXT    = '#####'.

  GS_FIELDCAT-REF_TABLE  = 'ZEDT16_EKPO'.

  GS_FIELDCAT-REF_FIELD  = 'MENGE'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 9. OPEN_QTY : ## ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 9.

  GS_FIELDCAT-FIELDNAME  = 'OPEN_QTY'.

  GS_FIELDCAT-COLTEXT    = '####'.

  GS_FIELDCAT-REF_TABLE  = 'ZEDT16_EKPO'.

  GS_FIELDCAT-REF_FIELD  = 'MENGE'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.

  GS_FIELDCAT-EMPHASIZE  = 'C300'.       " ### ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 10. ERFMG : ## ## ## (# ## ##)

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 10.

  GS_FIELDCAT-FIELDNAME  = 'ERFMG'.

  GS_FIELDCAT-COLTEXT    = '######'.

  GS_FIELDCAT-REF_TABLE  = 'ZEDT16_EKPO'.

  GS_FIELDCAT-REF_FIELD  = 'MENGE'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.

  GS_FIELDCAT-EDIT       = 'X'.          " # ## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 11. MEINS : ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 11.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_EKPO'.

  GS_FIELDCAT-REF_FIELD = 'MEINS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " ------------------------------------------------------------------

  " [## ##] - WAERS(##) ## ##

  " ------------------------------------------------------------------



  " 12. BPRME : ## (GS_ALV## NETPR ## ## #)

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 12.

  GS_FIELDCAT-FIELDNAME  = 'BPRME'.

  GS_FIELDCAT-COLTEXT    = '##'.

  GS_FIELDCAT-REF_TABLE  = 'ZEDT16_EKPO'.

  GS_FIELDCAT-REF_FIELD  = 'NETPR'.      " ## ## ##

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.      " ## ## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 13. WAERS : ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 13.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_EKKO'.

  GS_FIELDCAT-REF_FIELD = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 14. WRBTR : ####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 14.

  GS_FIELDCAT-FIELDNAME  = 'WRBTR'.

  GS_FIELDCAT-COLTEXT    = '####'.

  GS_FIELDCAT-REF_TABLE  = 'ZEDT16_RSEG'.

  GS_FIELDCAT-REF_FIELD  = 'WRBTR'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 15. MWSKZ : ####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 15.

  GS_FIELDCAT-FIELDNAME = 'MWSKZ'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_RSEG'.

  GS_FIELDCAT-REF_FIELD = 'MWSKZ'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 16. WMWST : ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 16.

  GS_FIELDCAT-FIELDNAME  = 'WMWST'.

  GS_FIELDCAT-COLTEXT    = '##'.

  GS_FIELDCAT-REF_TABLE  = 'ZEDT16_RSEG'.

  GS_FIELDCAT-REF_FIELD  = 'WMWST'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 17. DMBTR : ####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 17.

  GS_FIELDCAT-FIELDNAME  = 'DMBTR'.

  GS_FIELDCAT-COLTEXT    = '####'.

  GS_FIELDCAT-REF_TABLE  = 'BSIK'.

  GS_FIELDCAT-REF_FIELD  = 'DMBTR'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  GS_FIELDCAT-EMPHASIZE  = 'C710'.       " ## ## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 18. SGTXT : ## (# ## ##)

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 18.

  GS_FIELDCAT-FIELDNAME = 'SGTXT'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_RSEG'.

  GS_FIELDCAT-REF_FIELD = 'SGTXT'.

  GS_FIELDCAT-EDIT      = 'X'.           " # ## ##

  GS_FIELDCAT-OUTPUTLEN = 30.

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

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CLASS_EVENT .



  " 1. ### ### ## (## ## ###)

  CREATE OBJECT GO_EVENT_RECEIVER.

  SET HANDLER GO_EVENT_RECEIVER->HANDLE_DATA_CHANGED FOR GC_GRID.



  " 2. ## ## # #### ##### ## (## ## #)

  "    ## # ## ## ## ##### ##### #### ##

  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_ENTER. " ## # ### ##



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CALL_ALV .



  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT      = GS_VARIANT

      I_SAVE          = 'A'

      IS_LAYOUT       = GS_LAYOUT

    CHANGING

      IT_OUTTAB       = GT_ALV

      IT_FIELDCATALOG = GT_FIELDCAT




*     IT_SORT         = GT_SORT




    .



  CALL METHOD GC_GRID->SET_READY_FOR_INPUT

    EXPORTING

      I_READY_FOR_INPUT = 1.



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



  DATA : LS_STABLE TYPE LVC_S_STBL.



  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE = LS_STABLE




*     I_SOFT_REFRESH =

*    EXCEPTIONS

*     FINISHED  = 1

*     OTHERS    = 2




    .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_ALV_DATA_CHANGED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_ER_DATA_CHANGED  text

*----------------------------------------------------------------------*




FORM CHECK_ALV_DATA_CHANGED USING P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL.



  DATA : LS_MOD_CELL TYPE LVC_S_MODI,

         LS_ALV      LIKE LINE OF GT_ALV.



  " ### ## ## ## ##

  DATA : LV_NEW_QTY  TYPE ZEDT16_EKPO-MENGE, " ### ##

         LV_TAX_RATE TYPE P DECIMALS 2,      " ##

         LV_WRBTR    TYPE ZEDT16_RSEG-WRBTR, " ####

         LV_WMWST    TYPE ZEDT16_RSEG-WMWST, " ##

         LV_DMBTR    TYPE BSIK-DMBTR.        " ###



  LOOP AT P_DATA_CHANGED->MT_MOD_CELLS INTO LS_MOD_CELL.



    CASE LS_MOD_CELL-FIELDNAME.

      WHEN 'ERFMG'. " ###### ## #



        " 1. ## ### ## (##, #### # #### ##)

        READ TABLE GT_ALV INTO LS_ALV INDEX LS_MOD_CELL-ROW_ID.



        IF SY-SUBRC = 0.



          " #### ### ## ## ### ##

          LV_NEW_QTY = LS_MOD_CELL-VALUE.



          " -------------------------------------------------------

          " [### ## 1] ## ## ##

          " -------------------------------------------------------

          IF LV_NEW_QTY > LS_ALV-OPEN_QTY.

            MESSAGE '## ### ### #### #### ## #####.' TYPE 'I' DISPLAY LIKE 'W'.



            " ## #### ## ##

            LV_NEW_QTY = LS_ALV-OPEN_QTY.



            CALL METHOD P_DATA_CHANGED->MODIFY_CELL

              EXPORTING

                I_ROW_ID    = LS_MOD_CELL-ROW_ID

                I_FIELDNAME = LS_MOD_CELL-FIELDNAME

                I_VALUE     = LV_NEW_QTY.

          ENDIF.



          " -------------------------------------------------------

          " [### ## 2] ## ## ##

          " -------------------------------------------------------

          IF LV_NEW_QTY < 0.

            MESSAGE '### 0## ## # ####.' TYPE 'I' DISPLAY LIKE 'E'.



            " ## 0## ## ##

            LV_NEW_QTY = 0.



            CALL METHOD P_DATA_CHANGED->MODIFY_CELL

              EXPORTING

                I_ROW_ID    = LS_MOD_CELL-ROW_ID

                I_FIELDNAME = LS_MOD_CELL-FIELDNAME

                I_VALUE     = LV_NEW_QTY.

          ENDIF.





          " =======================================================

          " [##] 3. ## ### ## (MODIFY_DATA# ##)

          " =======================================================



          " (1) #### (WRBTR) = ## * ##

          LV_WRBTR = LV_NEW_QTY * LS_ALV-BPRME.



          " (2) ## ##

          CLEAR LV_TAX_RATE.

          CASE LS_ALV-MWSKZ.

            WHEN 'V1' OR 'V4' OR 'V5'. LV_TAX_RATE = '0.10'.

            WHEN 'V2' OR 'V3'.         LV_TAX_RATE = '0.00'.

            WHEN OTHERS.               LV_TAX_RATE = '0.00'.

          ENDCASE.



          " (3) ## (WMWST) # ### (DMBTR) ##

          LV_WMWST = LV_WRBTR * LV_TAX_RATE.

          LV_DMBTR = LV_WRBTR + LV_WMWST.





          " =======================================================

          " [##] 4. ##(ALV) # ### ### ####

          " =======================================================



          " (1) ### ## #### ## #### (MODIFY_CELL)

          "     -> ## ### ## ## # ## #### ####.



          CALL METHOD P_DATA_CHANGED->MODIFY_CELL

            EXPORTING

              I_ROW_ID    = LS_MOD_CELL-ROW_ID

              I_FIELDNAME = 'WRBTR'

              I_VALUE     = LV_WRBTR.



          CALL METHOD P_DATA_CHANGED->MODIFY_CELL

            EXPORTING

              I_ROW_ID    = LS_MOD_CELL-ROW_ID

              I_FIELDNAME = 'WMWST'

              I_VALUE     = LV_WMWST.



          CALL METHOD P_DATA_CHANGED->MODIFY_CELL

            EXPORTING

              I_ROW_ID    = LS_MOD_CELL-ROW_ID

              I_FIELDNAME = 'DMBTR'

              I_VALUE     = LV_DMBTR.



          " (2) ### ###(GT_ALV)## ## # ##

          "     -> ## ### ### SAVE_BUTTON ### # ### ### #####.

          LS_ALV-ERFMG = LV_NEW_QTY. " (### ## ## ## ##)

          LS_ALV-WRBTR = LV_WRBTR.

          LS_ALV-WMWST = LV_WMWST.

          LS_ALV-DMBTR = LV_DMBTR.



          MODIFY GT_ALV FROM LS_ALV INDEX LS_MOD_CELL-ROW_ID.



        ENDIF.



    ENDCASE.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_INIT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_INIT .



  P_DATE = SY-DATUM.

  P_EBELN1 = '4500000001'.

  P_WERKS1 = '1000'.



  P_EBELN2 = '4500000001'.

  P_WERKS2 = '1000'.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_BUTTON

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SAVE_BUTTON .



  DATA : LV_MAX_BELNR TYPE ZEDT16_RBKP-BELNR, " ## # ####

         LV_NEW_BELNR TYPE ZEDT16_RBKP-BELNR, " ## ### ##

         LV_BUZEI     TYPE ZEDT16_RSEG-BUZEI, " ### ## ###

         LV_FLAG      TYPE C,                 " ### ## ## ##

         LV_ANSWER    TYPE C.                 " ## ##



  " ## ## ### ##

  DATA : LV_SUM_WRBTR TYPE ZEDT16_RBKP-RMWWR, " #### ##

         LV_SUM_WMWST TYPE ZEDT16_RBKP-WMWST. " ## ##



  " ## ## ## (#### ##)

  DATA : LV_GJAHR       TYPE GJAHR.             " ####



  " ALV #### ## (####, ## ## #)

  CALL METHOD GC_GRID->CHECK_CHANGED_DATA.





  " -----------------------------------------------------------

  " 1. ### ## (### ### ##)

  " -----------------------------------------------------------

  CLEAR : LV_FLAG.



  LOOP AT GT_ALV INTO GS_ALV WHERE L_CHECK = 'X'.

    LV_FLAG = 'X'.



    " (1) ## ### 0 #### ##

    IF GS_ALV-ERFMG <= 0.

      MESSAGE '## ### 0## ## ###.' TYPE 'S' DISPLAY LIKE 'E'.

      RETURN.

    ENDIF.



    " (2) ## ### ### ##### ##

    IF GS_ALV-ERFMG > GS_ALV-OPEN_QTY.

      MESSAGE '## ### ### ######.' TYPE 'S' DISPLAY LIKE 'E'.

      RETURN.

    ENDIF.

  ENDLOOP.



  " ### ### ### ### ##

  IF LV_FLAG IS INITIAL.

    MESSAGE '### ### ##(##)####.' TYPE 'S' DISPLAY LIKE 'W'.

    RETURN.

  ENDIF.





  " -----------------------------------------------------------

  " 2. ## ## ## (POPUP_TO_CONFIRM)

  " -----------------------------------------------------------

  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      TITLEBAR              = '## ## ##'

      TEXT_QUESTION         = '### #### ## ### ######?'

      TEXT_BUTTON_1         = '#'

      ICON_BUTTON_1         = 'ICON_OKAY'

      TEXT_BUTTON_2         = '###'

      ICON_BUTTON_2         = 'ICON_CANCEL'

      DISPLAY_CANCEL_BUTTON = ' '

      POPUP_TYPE            = 'ICON_MESSAGE_QUESTION'

    IMPORTING

      ANSWER                = LV_ANSWER.



  IF LV_ANSWER <> '1'.

    MESSAGE '### #######.' TYPE 'S'.

    RETURN.

  ENDIF.





  " -----------------------------------------------------------

  " 3. ## ####(BELNR) ##

  " -----------------------------------------------------------



  " # [#### ##] ##### P_DATE# # 4## ##

  LV_GJAHR = P_DATE(4).



  SELECT SINGLE MAX( BELNR )

    INTO LV_MAX_BELNR

    FROM ZEDT16_RBKP

    WHERE GJAHR = LV_GJAHR. " ## ##(P_DATE ##)# ###



  IF LV_MAX_BELNR IS INITIAL.

    LV_NEW_BELNR = '5000000000'.

  ELSE.

    LV_NEW_BELNR = LV_MAX_BELNR + 1.

  ENDIF.





  " -----------------------------------------------------------

  " 4. ### ## # DB ## (RBKP, RSEG)

  " -----------------------------------------------------------



  " ###

  CLEAR : GS_RBKP, LV_BUZEI, LV_SUM_WRBTR, LV_SUM_WMWST.

  REFRESH : GT_RSEG.



  " (A) ### ### ## (GT_RSEG) & ## ## ##

  LOOP AT GT_ALV INTO GS_ALV WHERE L_CHECK = 'X'.



    CLEAR GS_RSEG.

    LV_BUZEI = LV_BUZEI + 1.



    " [Key Fields]

    GS_RSEG-BELNR = LV_NEW_BELNR. " ### ##

    GS_RSEG-GJAHR = LV_GJAHR.     " # P_DATE ## ##

    GS_RSEG-BUZEI = LV_BUZEI.     " ## (1, 2, 3...)



    " [PO References]

    GS_RSEG-EBELN = GS_ALV-EBELN.

    GS_RSEG-EBELP = GS_ALV-EBELP.



    " [Material Info]

    GS_RSEG-MATNR = GS_ALV-MATNR.

    GS_RSEG-TXZ01 = GS_ALV-MAKTX.

    GS_RSEG-WERKS = GS_ALV-WERKS.

    GS_RSEG-LGORT = GS_ALV-LGORT.



    " [Quantity & Amounts]

    GS_RSEG-MENGE = GS_ALV-ERFMG. " # ### ## ##

    GS_RSEG-MEINS = GS_ALV-MEINS.

    GS_RSEG-BSTME = GS_ALV-MEINS.

    GS_RSEG-WAERS = GS_ALV-WAERS.

    GS_RSEG-WRBTR = GS_ALV-WRBTR. " ####

    GS_RSEG-MWSKZ = GS_ALV-MWSKZ.

    GS_RSEG-WMWST = GS_ALV-WMWST. " ##



    GS_RSEG-SHKZG = 'S'.          " ## (##)

    GS_RSEG-SGTXT = GS_ALV-SGTXT. " ##



    APPEND GS_RSEG TO GT_RSEG.



    " [## ## ##]

    LV_SUM_WRBTR = LV_SUM_WRBTR + GS_ALV-WRBTR.

    LV_SUM_WMWST = LV_SUM_WMWST + GS_ALV-WMWST.



  ENDLOOP.





  " (B) ## ### ## (GS_RBKP)

  "     - Loop ### # ## ##



  GS_RBKP-BELNR = LV_NEW_BELNR.

  GS_RBKP-GJAHR = LV_GJAHR.              " # P_DATE ## ##

  GS_RBKP-BLART = 'RE'.                  " #### (##)

  GS_RBKP-BLDAT = GS_INVOICE_HEADER-BLDAT. " ### (P_DATE# ##)

  GS_RBKP-BUDAT = P_DATE.                " # ### (####: P_DATE ##)

  GS_RBKP-BUKRS = GS_INVOICE_HEADER-BUKRS.

  GS_RBKP-WERKS = P_WERKS1.

  GS_RBKP-LIFNR = GS_INVOICE_HEADER-LIFNR.

  GS_RBKP-WAERS = GS_ALV-WAERS.

  GS_RBKP-EBELN = GS_INVOICE_HEADER-EBELN.



  " [## ##] - ### ### # ##

  GS_RBKP-RMWWR = LV_SUM_WRBTR + LV_SUM_WMWST. " ### (### + ##)

  GS_RBKP-WMWST = LV_SUM_WMWST.                " ## ##

  GS_RBKP-XMWST = 'X'.                         " ## ## #

  GS_RBKP-MWSKZ = GS_INVOICE_HEADER-MWSKZ.



  GS_RBKP-RBSTAT = '5'.                  " ## (5: ###)

  GS_RBKP-ZTERM  = GS_INVOICE_HEADER-ZTERM.               " ####





  " (C) DB ## ##

  INSERT ZEDT16_RBKP FROM GS_RBKP.

  IF SY-SUBRC <> 0.

    ROLLBACK WORK.

    MESSAGE '## ###(RBKP) ## ##' TYPE 'E'.

    RETURN.

  ENDIF.



  INSERT ZEDT16_RSEG FROM TABLE GT_RSEG.

  IF SY-SUBRC <> 0.

    ROLLBACK WORK.

    MESSAGE '## ###(RSEG) ## ##' TYPE 'E'.

    RETURN.

  ENDIF.





  " (D) ## ##

  COMMIT WORK AND WAIT.



  MESSAGE '## ### ##### #######. (##: ' && LV_NEW_BELNR && ')' TYPE 'S'.





  " -----------------------------------------------------------

  " [## # ##]

  " -----------------------------------------------------------

  " 1. ## #### ## ### # ### # ##

  PERFORM GET_DATA.

  PERFORM MODIFY_DATA.



  " 2. ## ####

  PERFORM REFRESH.



ENDFORM.