
*&---------------------------------------------------------------------*

*&  Include           ZEDR16_PROJECT004_F02

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  CHECK_INPUT_DATA_DIS

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_INPUT_DATA_DIS .






* PARAMETERS : P_EBELN2 TYPE ZEDT16_EKKO-EBELN MODIF ID MD2,

* P_WERKS2 TYPE ZEDT16_EKPO-WERKS MODIF ID MD2.






  " ## #### ## ## (BELNR, GJAHR)

  DATA : LV_BELNR TYPE ZEDT16_RSEG-BELNR,

         LV_GJAHR TYPE ZEDT16_RSEG-GJAHR.



  " 1. #### ##(P_EBELN2) ## ##

  IF P_EBELN2 IS INITIAL.

    MESSAGE '### #### ### ######.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  " 2. ###(P_WERKS2) ## ##

  IF P_WERKS2 IS INITIAL.

    MESSAGE '### #### ######.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  " 3. ZEDT16_RSEG (## ###) ### ## ## ##

  "    ##: ####(EBELN) + ###(WERKS)

  CLEAR: LV_BELNR, LV_GJAHR.



  SELECT SINGLE BELNR GJAHR

    INTO (LV_BELNR, LV_GJAHR)

    FROM ZEDT16_RSEG

    WHERE EBELN = P_EBELN2

      AND WERKS = P_WERKS2.



  IF SY-SUBRC <> 0.

    MESSAGE '### ## ## ##(RSEG)# #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  " 4. ##(RBKP) ### ## (## ##)

  "    ### ## ####(BELNR)# ##(GJAHR)# ### ## ### ##

  SELECT SINGLE BELNR

    INTO LV_BELNR

    FROM ZEDT16_RBKP

    WHERE BELNR = LV_BELNR

      AND GJAHR = LV_GJAHR.



  IF SY-SUBRC <> 0.

    MESSAGE '## ## ##(RBKP) ### ## # ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA_DIS

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA_DIS .






*  DATA: BEGIN OF GS_INVOICE_HEADER,

*          EBELN TYPE ZEDT16_EKKO-EBELN, " ######

*          BUKRS TYPE ZEDT16_EKKO-BUKRS, " ####

*          EKGRP TYPE ZEDT16_EKKO-EKGRP, " ####

*          EKORG TYPE ZEDT16_EKKO-EKORG, " ####

*          LIFNR TYPE ZEDT16_EKKO-LIFNR, " ###

*          NAME1 TYPE ZEDT16_LFA1-NAME1, " #####

*          BEDAT TYPE ZEDT16_EKKO-BEDAT, " PO ###

*          BLDAT TYPE ZEDT16_RBKP-BLDAT, " ## ###

*          WERKS TYPE ZEDT16_RBKP-WERKS, " ###

*        END OF GS_INVOICE_HEADER.

*  DATA : GT_INVOICE_HEADER LIKE TABLE OF GS_INVOICE_HEADER.

*

*  DATA: BEGIN OF GS_ALV_DIS,

*          " [## ##]

*          L_CHECK TYPE C LENGTH 4,          " #### (## ### #)

*

*          " [Key Fields - ## ## # ##]

*          BELNR   TYPE ZEDT16_RBKP-BELNR,   " ###### (##/### ##)

*          GJAHR   TYPE ZEDT16_RBKP-GJAHR,   " #### (##/### ##)

*          BUZEI   TYPE ZEDT16_RSEG-BUZEI,   " ###### (###)

*

*          " [## ## ## (RBKP)] - PO##(GS_INVOICE_HEADER) ##

*          BLART   TYPE ZEDT16_RBKP-BLART,   " #### (RE, KG #)

*          BLDAT   TYPE ZEDT16_RBKP-BLDAT,   " ###

*          BUDAT   TYPE ZEDT16_RBKP-BUDAT,   " ###

*          RBSTAT  TYPE ZEDT16_RBKP-RBSTAT,  " #### (5:### #)

*          ZTERM   TYPE ZEDT16_RBKP-ZTERM,   " ####

*          BKTXT   TYPE ZEDT16_RBKP-BKTXT,   " ## ###

*

*          " [## ### ## (RSEG)] - PO ## ##

*          EBELN   TYPE ZEDT16_RSEG-EBELN,   " ######

*          EBELP   TYPE ZEDT16_RSEG-EBELP,   " ######

*          MATNR   TYPE ZEDT16_RSEG-MATNR,   " ####

*          TXZ01   TYPE ZEDT16_RSEG-TXZ01,   " ###

*          WERKS   TYPE ZEDT16_RSEG-WERKS,   " ###

*          LGORT   TYPE ZEDT16_RSEG-LGORT,   " ####

*

*          " [## # ##]

*          MENGE   TYPE ZEDT16_RSEG-MENGE,   " ##

*          MEINS   TYPE ZEDT16_RSEG-MEINS,   " ##

*          WAERS   TYPE ZEDT16_RBKP-WAERS,   " ## (##/### ##)

*          WRBTR   TYPE ZEDT16_RSEG-WRBTR,   " #### (Item Net Value)

*          WMWST   TYPE ZEDT16_RSEG-WMWST,   " ## (Item Tax)

*          MWSKZ   TYPE ZEDT16_RSEG-MWSKZ,   " ####

*

*          " [## ## ##] - ALV## #### ##

*          DMBTR   TYPE ZEDT16_RSEG-WRBTR,   " #### (### + ##)

*

*          " [## ##]

*          SHKZG   TYPE ZEDT16_RSEG-SHKZG,   " ##### (S/H)

*          SGTXT   TYPE ZEDT16_RSEG-SGTXT,   " ### ###

*

*

*        END OF GS_ALV_DIS.

*

*  DATA: GT_ALV_DIS LIKE TABLE OF GS_ALV_DIS.

*

*  " ## ##

**DATA: BEGIN OF GS_RBKP,

**        BELNR  TYPE ZEDT16_RBKP-BELNR,       " ###### *

**        GJAHR  TYPE ZEDT16_RBKP-GJAHR,       " #### *

**        BLART  TYPE ZEDT16_RBKP-BLART,       " ####

**        BLDAT  TYPE ZEDT16_RBKP-BLDAT,       " ###

**        BUDAT  TYPE ZEDT16_RBKP-BUDAT,       " ###

**        BUKRS  TYPE ZEDT16_RBKP-BUKRS,       " #### *

**        LIFNR  TYPE ZEDT16_RBKP-LIFNR,       " ### *

**        WAERS  TYPE ZEDT16_RBKP-WAERS,       " ##

**        ZTERM  TYPE ZEDT16_RBKP-ZTERM,       " ####

**        BKTXT  TYPE ZEDT16_RBKP-BKTXT,       " #####

**        XMWST  TYPE ZEDT16_RBKP-XMWST,       " ######

**        RMWWR  TYPE ZEDT16_RBKP-RMWWR,       " #####

**        WMWST  TYPE ZEDT16_RBKP-WMWST,       " ##

**        RBSTAT TYPE ZEDT16_RBKP-RBSTAT,      " ####

**        EBELN  TYPE ZEDT16_RBKP-EBELN,       " ######

**        WERKS  TYPE ZEDT16_RBKP-WERKS,       " ###

**      END OF GS_RBKP.

**DATA: GT_RBKP LIKE TABLE OF GS_RBKP.

*  DATA: GS_RBKP TYPE ZEDT16_RBKP.

*

*  DATA: GT_RBKP LIKE TABLE OF GS_RBKP.

*

*  " ## ###

**DATA: BEGIN OF GS_RSEG,

**        L_CHECK TYPE C LENGTH 4,             " ## ####

**        BELNR   TYPE ZEDT16_RSEG-BELNR,       " ###### *

**        GJAHR   TYPE ZEDT16_RSEG-GJAHR,       " #### *

**        BUZEI   TYPE ZEDT16_RSEG-BUZEI,       " ###### *

**        EBELN   TYPE ZEDT16_RSEG-EBELN,       " ######

**        EBELP   TYPE ZEDT16_RSEG-EBELP,       " ######

**        MATNR   TYPE ZEDT16_RSEG-MATNR,       " ####

**        TXZ01   TYPE ZEDT16_RSEG-TXZ01,       " ###

**        WERKS   TYPE ZEDT16_RSEG-WERKS,       " ###

**        LGORT   TYPE ZEDT16_RSEG-LGORT,       " ####

**        MENGE   TYPE ZEDT16_RSEG-MENGE,       " ##

**        MEINS   TYPE ZEDT16_RSEG-MEINS,       " ####

**        WAERS   TYPE ZEDT16_RSEG-WAERS,       " ##

**        WRBTR   TYPE ZEDT16_RSEG-WRBTR,       " ####

**        MWSKZ   TYPE ZEDT16_RSEG-MWSKZ,       " ####

**        WMWST   TYPE ZEDT16_RSEG-WMWST,       " ##

**        SHKZG   TYPE ZEDT16_RSEG-SHKZG,       " #####

**        SGTXT   TYPE ZEDT16_RSEG-SGTXT,       " ######

**      END OF GS_RSEG.

**DATA: GT_RSEG LIKE TABLE OF GS_RSEG.

*  DATA: GS_RSEG TYPE ZEDT16_RSEG.

*

*  DATA: GT_RSEG LIKE TABLE OF GS_RSEG.






  " 1. ## # ### ###

  REFRESH : GT_ALV_DIS, GT_RSEG.

  CLEAR   : GS_ALV_DIS, GS_RSEG, GS_RBKP.



  " 2. ## ###(RSEG) ##

  "    ##: #### + ### + ##### ## #(LOEKZ = space) + ##(S)#

  SELECT *

    INTO TABLE GT_RSEG

    FROM ZEDT16_RSEG

    WHERE EBELN = P_EBELN2

      AND WERKS = P_WERKS2

      AND SHKZG = 'S'        " ## ##(S)# ## (H# ## ### ##)

      AND LOEKZ = ' '.       " # ##(##) ### ## ## ##



  " #### ### ##

  IF SY-SUBRC <> 0.

    MESSAGE '## ##### ## ### ## ### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  " 3. ### ## (Item + Header -> ALV)

  LOOP AT GT_RSEG INTO GS_RSEG.



    " (## ## # ## ### ### ##)

    CLEAR GS_ALV_DIS.

    CLEAR GS_RBKP.



    SELECT SINGLE *

      INTO GS_RBKP

      FROM ZEDT16_RBKP

      WHERE BELNR = GS_RSEG-BELNR

        AND GJAHR = GS_RSEG-GJAHR.



    MOVE-CORRESPONDING GS_RSEG TO GS_ALV_DIS.



    " ## ## ##

    GS_ALV_DIS-BLART  = GS_RBKP-BLART.

    GS_ALV_DIS-BLDAT  = GS_RBKP-BLDAT.

    GS_ALV_DIS-BUDAT  = GS_RBKP-BUDAT.

    GS_ALV_DIS-RBSTAT = GS_RBKP-RBSTAT.

    GS_ALV_DIS-ZTERM  = GS_RBKP-ZTERM.

    GS_ALV_DIS-BKTXT  = GS_RBKP-BKTXT.

    GS_ALV_DIS-WAERS  = GS_RBKP-WAERS.

    GS_ALV_DIS-BUKRS  = GS_RBKP-BUKRS.

    GS_ALV_DIS-LIFNR  = GS_RBKP-LIFNR.



    " ## ##

    GS_ALV_DIS-DMBTR = GS_RSEG-WRBTR + GS_RSEG-WMWST.



    APPEND GS_ALV_DIS TO GT_ALV_DIS.



  ENDLOOP.



  " 4. ##

  SORT GT_ALV_DIS BY BELNR GJAHR BUZEI.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT_200 .



  CREATE OBJECT GC_DOCKING

    EXPORTING

      REPID     = SY-REPID

      DYNNR     = '0200'

      SIDE      = CL_GUI_DOCKING_CONTAINER=>DOCK_AT_LEFT

      EXTENSION = 3000. " ## #### ### ## ##



  " 2. ### ## (### ## ####)

  CREATE OBJECT GC_GRID_200

    EXPORTING

      I_PARENT = GC_DOCKING.



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



  DATA : LV_POS TYPE I.



  CLEAR : GS_FIELDCAT, GT_FIELDCAT, LV_POS.



  " -------------------------------------------------------------

  " 1. ####

  " -------------------------------------------------------------

  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = LV_POS.

  GS_FIELDCAT-FIELDNAME = 'L_CHECK'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-CHECKBOX  = 'X'.

  GS_FIELDCAT-EDIT      = 'X'.        " ## ## (## ###)

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " -------------------------------------------------------------

  " 2. Key Fields (####, ##, ##)

  " -------------------------------------------------------------

  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = LV_POS.

  GS_FIELDCAT-FIELDNAME = 'BELNR'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_RBKP'.

  GS_FIELDCAT-REF_FIELD = 'BELNR'.

  GS_FIELDCAT-EMPHASIZE = 'C500'.     " ## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = LV_POS.

  GS_FIELDCAT-FIELDNAME = 'GJAHR'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_RBKP'.

  GS_FIELDCAT-REF_FIELD = 'GJAHR'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = LV_POS.

  GS_FIELDCAT-FIELDNAME = 'BUZEI'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_RSEG'.

  GS_FIELDCAT-REF_FIELD = 'BUZEI'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " -------------------------------------------------------------

  " 3. ## ## (####, ###, ###, ##)

  " -------------------------------------------------------------

  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = LV_POS.

  GS_FIELDCAT-FIELDNAME = 'BLART'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_RBKP'.

  GS_FIELDCAT-REF_FIELD = 'BLART'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = LV_POS.

  GS_FIELDCAT-FIELDNAME = 'BLDAT'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_RBKP'.

  GS_FIELDCAT-REF_FIELD = 'BLDAT'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = LV_POS.

  GS_FIELDCAT-FIELDNAME = 'BUDAT'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_RBKP'.

  GS_FIELDCAT-REF_FIELD = 'BUDAT'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = LV_POS.

  GS_FIELDCAT-FIELDNAME = 'RBSTAT'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_RBKP'.

  GS_FIELDCAT-REF_FIELD = 'RBSTAT'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " -------------------------------------------------------------

  " 4. PO # ## ##

  " -------------------------------------------------------------

  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = LV_POS.

  GS_FIELDCAT-FIELDNAME = 'EBELN'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_RSEG'.

  GS_FIELDCAT-REF_FIELD = 'EBELN'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = LV_POS.

  GS_FIELDCAT-FIELDNAME = 'EBELP'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_RSEG'.

  GS_FIELDCAT-REF_FIELD = 'EBELP'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = LV_POS.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_RSEG'.

  GS_FIELDCAT-REF_FIELD = 'MATNR'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = LV_POS.

  GS_FIELDCAT-FIELDNAME = 'TXZ01'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_RSEG'.

  GS_FIELDCAT-REF_FIELD = 'TXZ01'.

  GS_FIELDCAT-OUTPUTLEN = 20.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " -------------------------------------------------------------

  " 5. ## # ## ##

  " -------------------------------------------------------------

  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = LV_POS.

  GS_FIELDCAT-FIELDNAME  = 'MENGE'.

  GS_FIELDCAT-COLTEXT    = '##'.

  GS_FIELDCAT-REF_TABLE  = 'ZEDT16_RSEG'.

  GS_FIELDCAT-REF_FIELD  = 'MENGE'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.      " ## ##

  GS_FIELDCAT-EMPHASIZE  = 'C300'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = LV_POS.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_RSEG'.

  GS_FIELDCAT-REF_FIELD = 'MEINS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = LV_POS.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_RBKP'.

  GS_FIELDCAT-REF_FIELD = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = LV_POS.

  GS_FIELDCAT-FIELDNAME  = 'WRBTR'.

  GS_FIELDCAT-COLTEXT    = '####'.

  GS_FIELDCAT-REF_TABLE  = 'ZEDT16_RSEG'.

  GS_FIELDCAT-REF_FIELD  = 'WRBTR'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.      " ## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = LV_POS.

  GS_FIELDCAT-FIELDNAME  = 'WMWST'.

  GS_FIELDCAT-COLTEXT    = '##'.

  GS_FIELDCAT-REF_TABLE  = 'ZEDT16_RSEG'.

  GS_FIELDCAT-REF_FIELD  = 'WMWST'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = LV_POS.

  GS_FIELDCAT-FIELDNAME  = 'DMBTR'.

  GS_FIELDCAT-COLTEXT    = '####'.

  GS_FIELDCAT-REF_TABLE  = 'ZEDT16_RSEG'.

  GS_FIELDCAT-REF_FIELD  = 'WRBTR'.      " ## ### WRBTR ##

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  GS_FIELDCAT-EMPHASIZE  = 'C700'.       " ## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " -------------------------------------------------------------

  " 6. ## ##

  " -------------------------------------------------------------

  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = LV_POS.

  GS_FIELDCAT-FIELDNAME = 'BUKRS'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_RBKP'.

  GS_FIELDCAT-REF_FIELD = 'BUKRS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = LV_POS.

  GS_FIELDCAT-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_RBKP'.

  GS_FIELDCAT-REF_FIELD = 'LIFNR'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = LV_POS.

  GS_FIELDCAT-FIELDNAME = 'MWSKZ'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_RSEG'.

  GS_FIELDCAT-REF_FIELD = 'MWSKZ'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = LV_POS.

  GS_FIELDCAT-FIELDNAME = 'SHKZG'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_RSEG'.

  GS_FIELDCAT-REF_FIELD = 'SHKZG'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = LV_POS.

  GS_FIELDCAT-FIELDNAME = 'SGTXT'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_RSEG'.

  GS_FIELDCAT-REF_FIELD = 'SGTXT'.

  GS_FIELDCAT-OUTPUTLEN = 30.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT_200 .



  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-SEL_MODE   = 'D'.



  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.



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



  CALL METHOD GC_GRID_200->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_LAYOUT       = GS_LAYOUT

    CHANGING

      IT_OUTTAB       = GT_ALV_DIS

      IT_FIELDCATALOG = GT_FIELDCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM REFRESH_200 .



  DATA : LS_STABLE TYPE LVC_S_STBL.



  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GC_GRID_200->REFRESH_TABLE_DISPLAY

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

*&      Form  REMOVE_BUTTON

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM REMOVE_BUTTON .



  " -----------------------------------------------------------

  " ## ##

  " -----------------------------------------------------------

  DATA : LV_MAX_BELNR TYPE ZEDT16_RBKP-BELNR, " ## # ####

         LV_NEW_BELNR TYPE ZEDT16_RBKP-BELNR, " ## ### ##

         LV_GJAHR     TYPE GJAHR,             " #### (#####)

         LV_BUZEI     TYPE ZEDT16_RSEG-BUZEI, " ### ##

         LV_FLAG      TYPE C,                 " ## ## ###

         LV_ANSWER    TYPE C.                 " ## ##



  " ## ### ##

  DATA : LV_SUM_WRBTR TYPE ZEDT16_RBKP-RMWWR,

         LV_SUM_WMWST TYPE ZEDT16_RBKP-WMWST.



  " ## ## ###

  DATA: LS_FIRST_LINE LIKE GS_ALV_DIS.



  " ALV #### ## (## ### ### ## ##)

  IF GC_GRID_200 IS NOT INITIAL.

    CALL METHOD GC_GRID_200->CHECK_CHANGED_DATA.

  ENDIF.





  " -----------------------------------------------------------

  " 1. ### ## (### ## ##)

  " -----------------------------------------------------------

  CLEAR : LV_FLAG.

  LOOP AT GT_ALV_DIS INTO GS_ALV_DIS WHERE L_CHECK = 'X'.

    LV_FLAG = 'X'.

    EXIT. " #### ### ##

  ENDLOOP.



  IF LV_FLAG IS INITIAL.

    MESSAGE '### ### ######.' TYPE 'S' DISPLAY LIKE 'W'.

    RETURN.

  ENDIF.





  " -----------------------------------------------------------

  " 2. ## ## ##

  " -----------------------------------------------------------

  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      TITLEBAR              = '## ## ##'

      TEXT_QUESTION         = '### ## ### ## ######?'

      TEXT_BUTTON_1         = '#'

      ICON_BUTTON_1         = 'ICON_OKAY'

      TEXT_BUTTON_2         = '###'

      ICON_BUTTON_2         = 'ICON_CANCEL'

      DISPLAY_CANCEL_BUTTON = ' '

      POPUP_TYPE            = 'ICON_MESSAGE_QUESTION'

    IMPORTING

      ANSWER                = LV_ANSWER.



  IF LV_ANSWER <> '1'.

    MESSAGE '## ### #######.' TYPE 'S'.

    RETURN.

  ENDIF.





  " -----------------------------------------------------------

  " 3. ## ####(BELNR) ## (###)

  " -----------------------------------------------------------

  " ## ### ## ##(SY-DATUM) #### ### ####.

  LV_GJAHR = SY-DATUM(4).



  SELECT SINGLE MAX( BELNR )

    INTO LV_MAX_BELNR

    FROM ZEDT16_RBKP

    WHERE GJAHR = LV_GJAHR.



  IF LV_MAX_BELNR IS INITIAL.

    LV_NEW_BELNR = '5000000000'. " ## ## ###

  ELSE.

    LV_NEW_BELNR = LV_MAX_BELNR + 1.

  ENDIF.





  " -----------------------------------------------------------

  " 4. ### ## (## #### & ## ### ##)

  " -----------------------------------------------------------

  REFRESH GT_RSEG.     " ## ### ### ### ###

  CLEAR : LV_BUZEI, LV_SUM_WRBTR, LV_SUM_WMWST, LS_FIRST_LINE.



  LOOP AT GT_ALV_DIS INTO GS_ALV_DIS WHERE L_CHECK = 'X'.



    " ## ### ## ## (# ## ## ##: ####, ###, ## #)

    IF LS_FIRST_LINE IS INITIAL.

      LS_FIRST_LINE = GS_ALV_DIS.

    ENDIF.



    " =======================================================

    " (A) ## ### ####

    " =======================================================



    " 1. [###] ## ### ## ## (LOEKZ = X)

    UPDATE ZEDT16_RSEG

       SET LOEKZ = 'X'

     WHERE BELNR = GS_ALV_DIS-BELNR

       AND GJAHR = GS_ALV_DIS-GJAHR

       AND BUZEI = GS_ALV_DIS-BUZEI.



    IF SY-SUBRC <> 0.

      ROLLBACK WORK.

      MESSAGE '## ### ## ##(LOEKZ) ##. ### #####.' TYPE 'E'.

      RETURN.

    ENDIF.



    " 2. [##] ## ### '### ####(STBLG)' ## # ## ##

    "    (##: "# ## ### LV_NEW_BELNR ### ## #######" ## ##)

    UPDATE ZEDT16_RBKP

       SET STBLG = LV_NEW_BELNR  " ## ## ## ## ##

           STJAH = LV_GJAHR      " ## ##

     WHERE BELNR = GS_ALV_DIS-BELNR

       AND GJAHR = GS_ALV_DIS-GJAHR.



    " (##: ## ### ## #### ### # ## ####### ####)

    IF SY-SUBRC <> 0.

      ROLLBACK WORK.

      MESSAGE '## ## ### ##(STBLG) ##. ### #####.' TYPE 'E'.

      RETURN.

    ENDIF.





    " =======================================================

    " (B) ## ## ### ## (ZEDT16_RSEG)

    " =======================================================

    CLEAR GS_RSEG.

    LV_BUZEI = LV_BUZEI + 1.



    " [Key Fields]

    GS_RSEG-BELNR = LV_NEW_BELNR.   " ## # ##

    GS_RSEG-GJAHR = LV_GJAHR.       " ## ##

    GS_RSEG-BUZEI = LV_BUZEI.       " 1, 2, 3...



    " [## ##] (## ### ### ##)

    GS_RSEG-EBELN = GS_ALV_DIS-EBELN.

    GS_RSEG-EBELP = GS_ALV_DIS-EBELP.

    GS_RSEG-MATNR = GS_ALV_DIS-MATNR.

    GS_RSEG-TXZ01 = GS_ALV_DIS-TXZ01.

    GS_RSEG-WERKS = GS_ALV_DIS-WERKS.

    GS_RSEG-LGORT = GS_ALV_DIS-LGORT.

    GS_RSEG-MENGE = GS_ALV_DIS-MENGE.

    GS_RSEG-MEINS = GS_ALV_DIS-MEINS.

    GS_RSEG-WAERS = GS_ALV_DIS-WAERS.

    GS_RSEG-WRBTR = GS_ALV_DIS-WRBTR.

    GS_RSEG-WMWST = GS_ALV_DIS-WMWST.

    GS_RSEG-MWSKZ = GS_ALV_DIS-MWSKZ.



    " # [##] ### ##: 'H' (##/##)

    GS_RSEG-SHKZG = 'H'.



    " # [##] ## #### ## ### ### # #### LOEKZ ###

    GS_RSEG-LOEKZ = ' '.



    " ##: ## ## ##

    CONCATENATE '##:' GS_ALV_DIS-BELNR INTO GS_RSEG-SGTXT SEPARATED BY SPACE.



    " #### ##

    APPEND GS_RSEG TO GT_RSEG.



    " [## ## ##]

    LV_SUM_WRBTR = LV_SUM_WRBTR + GS_ALV_DIS-WRBTR.

    LV_SUM_WMWST = LV_SUM_WMWST + GS_ALV_DIS-WMWST.



  ENDLOOP.





  " -----------------------------------------------------------

  " 5. ## ## ## (ZEDT16_RBKP)

  " -----------------------------------------------------------

  CLEAR GS_RBKP.



  GS_RBKP-BELNR = LV_NEW_BELNR.

  GS_RBKP-GJAHR = LV_GJAHR.

  GS_RBKP-BLART = 'RE'.         " ####

  GS_RBKP-BLDAT = SY-DATUM.     " ### (##)

  GS_RBKP-BUDAT = SY-DATUM.     " ### (##)

  GS_RBKP-RBSTAT = '5'.         " ###



  " [## ##]

  GS_RBKP-RMWWR = LV_SUM_WRBTR + LV_SUM_WMWST. " ###

  GS_RBKP-WMWST = LV_SUM_WMWST.                " ##

  GS_RBKP-WAERS = LS_FIRST_LINE-WAERS.         " ## (ALV ## ##)

  GS_RBKP-XMWST = 'X'.



  " [## ##] - ALV## ### # ##

  GS_RBKP-BUKRS = LS_FIRST_LINE-BUKRS.  " ####

  GS_RBKP-LIFNR = LS_FIRST_LINE-LIFNR.  " ###

  GS_RBKP-BKTXT = '## ## ##'.



  " [##] ## ### STBLG/STJAH# #####.

  " (### # ## ### # ### # #### ####)

  GS_RBKP-STBLG = ' '.

  GS_RBKP-STJAH = '0000'.





  " -----------------------------------------------------------

  " 6. DB ## (INSERT)

  " -----------------------------------------------------------



  " (1) ## ## ##

  INSERT ZEDT16_RBKP FROM GS_RBKP.

  IF SY-SUBRC <> 0.

    ROLLBACK WORK.

    MESSAGE '## ## ## ## ##' TYPE 'E'.

    RETURN.

  ENDIF.



  " (2) ## ### ##

  INSERT ZEDT16_RSEG FROM TABLE GT_RSEG.

  IF SY-SUBRC <> 0.

    ROLLBACK WORK.

    MESSAGE '## ## ### ## ##' TYPE 'E'.

    RETURN.

  ENDIF.





  " -----------------------------------------------------------

  " 7. ## ## (COMMIT & ## ##)

  " -----------------------------------------------------------

  COMMIT WORK AND WAIT.



  MESSAGE '## ## ### #######.' TYPE 'S'.



  " # ## ### ###(GT_ALV_DIS)## ### ### ## ##

  "    (DB ### GET_DATA_DIS ## ### ##)

  DELETE GT_ALV_DIS WHERE L_CHECK = 'X'.



  " ALV ####

  PERFORM REFRESH_200.



ENDFORM.