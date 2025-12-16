
*&---------------------------------------------------------------------*

*&  Include           ZMM22_003_F01

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

    "## ## ### #### ### ##

  IF GR_RAD = 'X'.

    P_DATE = SY-DATUM.   "## ## ## ##

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  VALID_INPUT

*&---------------------------------------------------------------------*

* ### ## (##### #### ##### ##)

*---------------------------------------------------------------------*




FORM VALID_INPUT .



  DATA: LV_CHECK_EBELN TYPE ZEKPO_22-EBELN.



  IF SY-UCOMM = 'UC1'.

    EXIT.

  ENDIF.



  " 1. [## ##] ### # ##

  IF GR_RAD = 'X'.



    " ### ##

    IF P_EBELN IS INITIAL.

      MESSAGE '##### ## #####.' TYPE 'E'.

    ENDIF.

    IF P_WERKS IS INITIAL.

      MESSAGE '#### ## #####.' TYPE 'E'.

    ENDIF.

    IF P_DATE IS INITIAL.

      MESSAGE '## #### ## #####.' TYPE 'E'.

    ENDIF.



    " [##] ####(ZEKPO_22)# ## #### ##### ##

    SELECT SINGLE EBELN

      INTO LV_CHECK_EBELN

      FROM ZEKPO_22

      WHERE EBELN = P_EBELN

        AND WERKS = P_WERKS.



    IF SY-SUBRC <> 0.

      " #### ### ## ### (## ## ##)

      MESSAGE '## ####### #### #### #### ####.' TYPE 'E'.

    ENDIF.



  ENDIF.



  " 2. [## ##] ### # ##

  IF GS_RAD = 'X'.



    " ### ##

    IF P_EBELN2 IS INITIAL.

      MESSAGE '##### ## #####.' TYPE 'E'.

    ENDIF.

    IF P_WERKS2 IS INITIAL.

      MESSAGE '#### ## #####.' TYPE 'E'.

    ENDIF.



    " ## ##(####)# ##### ## ##

    " (## ### ## ### # #### #)

    SELECT SINGLE B~EBELN

      INTO LV_CHECK_EBELN

      FROM ZMKPF_22 AS A

      INNER JOIN ZMSEG_22 AS B

        ON A~MBLNR = B~MBLNR

       AND A~MJAHR = B~MJAHR

      WHERE B~EBELN = P_EBELN2

        AND B~ZWERKS = P_WERKS2.



    IF SY-SUBRC <> 0.

      MESSAGE '### #### ## ### #### ####.' TYPE 'E'.

    ENDIF.



  ENDIF.



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



    "#### ##

    IF GR_RAD = 'X'.

      IF SCREEN-GROUP1 = 'GR'.

        SCREEN-ACTIVE    = 1.

        SCREEN-INVISIBLE = 0.

        SCREEN-INPUT     = 1.

      ELSEIF SCREEN-GROUP1 = 'GS'.

        SCREEN-ACTIVE    = 0.

        SCREEN-INVISIBLE = 1.

        SCREEN-INPUT     = 0.

      ENDIF.

    ENDIF.



    "#### ##

    IF GS_RAD = 'X'.

      IF SCREEN-GROUP1 = 'GR'.

        SCREEN-ACTIVE    = 0.

        SCREEN-INVISIBLE = 1.

        SCREEN-INPUT     = 0.

      ELSEIF SCREEN-GROUP1 = 'GS'.

        SCREEN-ACTIVE    = 1.

        SCREEN-INVISIBLE = 0.

        SCREEN-INPUT     = 1.

      ENDIF.

    ENDIF.



    MODIFY SCREEN.

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

      CONTAINER_NAME = 'CON1'.



  CREATE OBJECT GC_GRID

    EXPORTING

      I_PARENT = GC_CUSTOM.

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

  GS_FIELDCAT-COL_POS   = 1.

  GS_FIELDCAT-FIELDNAME = 'MARK'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-CHECKBOX  = 'X'.

  GS_FIELDCAT-EDIT      = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 2.

  GS_FIELDCAT-FIELDNAME = 'EBELN'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-KEY       = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 3.

  GS_FIELDCAT-FIELDNAME = 'EBELP'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-KEY       = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 4.

  GS_FIELDCAT-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 5.

  GS_FIELDCAT-FIELDNAME = 'BEDAT'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 6.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-NO_ZERO   = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 7.

  GS_FIELDCAT-FIELDNAME = 'MAKTX'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-OUTPUTLEN = 20.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 8.

  GS_FIELDCAT-FIELDNAME  = 'MENGE'.

  GS_FIELDCAT-COLTEXT    = 'PO##'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 9.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-COLTEXT   = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 10.

  GS_FIELDCAT-FIELDNAME  = 'STPRS'.

  GS_FIELDCAT-COLTEXT    = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 11.

  GS_FIELDCAT-FIELDNAME  = 'WEMNG'.

  GS_FIELDCAT-COLTEXT    = '#####'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 12.

  GS_FIELDCAT-FIELDNAME  = 'REMNG'.

  GS_FIELDCAT-COLTEXT    = '####'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 13.

  GS_FIELDCAT-FIELDNAME  = 'ERFMG'.

  GS_FIELDCAT-COLTEXT    = '####'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.

  GS_FIELDCAT-EDIT       = 'X'.

  GS_FIELDCAT-NO_ZERO     = 'X'.

  GS_FIELDCAT-REF_TABLE  = 'EKPO'.

  GS_FIELDCAT-REF_FIELD  = 'MENGE'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 14.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-COLTEXT   = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 15.

  GS_FIELDCAT-FIELDNAME = 'PRDAT'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 16.

  GS_FIELDCAT-FIELDNAME = 'WERKS'.

  GS_FIELDCAT-COLTEXT   = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 17.

  GS_FIELDCAT-FIELDNAME = 'LGORT'.

  GS_FIELDCAT-COLTEXT   = '####'.

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

  GS_LAYOUT-CWIDTH_OPT = 'X'.

  GS_LAYOUT-SEL_MODE   = 'A'.

  "GS_LAYOUT-BOX_FNAME  = 'SEL'.



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

      IS_LAYOUT       = GS_LAYOUT

    CHANGING

      IT_OUTTAB       = GT_ITEM

      IT_FIELDCATALOG = GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_PO_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_PO_DATA.



  DATA: LS_ITEM  LIKE GS_ITEM,

        LS_WEMNG TYPE TY_WEMNG,

        LV_IDX   TYPE SY-TABIX.



  CLEAR GT_ITEM.

  REFRESH LT_WEMNG.



  " 1. #### ## + ### ##

  SELECT H~EBELN

         I~EBELP

         H~LIFNR

         H~BEDAT

         H~WAERS

         I~MATNR

         I~MAKTX

         I~MENGE

         I~MEINS

         I~STPRS

         I~PRDAT

         I~WERKS

         I~LGORT

    INTO CORRESPONDING FIELDS OF TABLE GT_ITEM

    FROM ZEKKO_22 AS H

    INNER JOIN ZEKPO_22 AS I

      ON H~EBELN = I~EBELN

    WHERE H~EBELN = P_EBELN

      AND I~WERKS = P_WERKS.



  IF GT_ITEM IS INITIAL.

    MESSAGE '## ##### #### ####.' TYPE 'E'.

    RETURN.

  ENDIF.



" ##### ## (101# ###, 102# ##)

  SELECT EBELN AS EBELN,

         ZEILE AS EBELP,

         SUM( CASE WHEN SHKZG = 'S' THEN MENGE       " ##(S): ## (+)

                   WHEN SHKZG = 'H' THEN MENGE * -1  " ##(H): ## (-)

                   ELSE 0 END ) AS WEMNG

    INTO CORRESPONDING FIELDS OF TABLE @LT_WEMNG

    FROM ZMSEG_22

    WHERE EBELN = @P_EBELN

      AND ZWERKS = @P_WERKS

    GROUP BY EBELN, ZEILE.



  " 3. ## ## (Loop)

  LOOP AT GT_ITEM INTO LS_ITEM.

    LV_IDX = SY-TABIX.



    " (1) ##### ##

    CLEAR LS_WEMNG.

    READ TABLE LT_WEMNG INTO LS_WEMNG

      WITH KEY EBELN = LS_ITEM-EBELN

               EBELP = LS_ITEM-EBELP.



    IF SY-SUBRC = 0.

      LS_ITEM-WEMNG = LS_WEMNG-WEMNG. " ### ### # #

    ELSE.

      LS_ITEM-WEMNG = 0.              " ### ### 0 (##)

    ENDIF.



" ### ### ##### 0## ## ##

    IF LS_ITEM-WEMNG < 0.

      LS_ITEM-WEMNG = 0.

    ENDIF.



    " (2) #### ##: PO## - #####

    LS_ITEM-REMNG = LS_ITEM-MENGE - LS_ITEM-WEMNG.



    " ##### ### 0## ##

    IF LS_ITEM-REMNG < 0.

      LS_ITEM-REMNG = 0.

    ENDIF.



    " (3) ####(###): ### ##### ####, #### ##

    " ## ##### ### ## ## ####.

    " LS_ITEM-ERFMG = LS_ITEM-REMNG.

    CLEAR LS_ITEM-ERFMG. " #### ##



    " ### ###(### #### #)# #### ##

    MODIFY GT_ITEM FROM LS_ITEM INDEX LV_IDX.



  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_DATA

*&---------------------------------------------------------------------*

* ### ## ## ## (##/### ## # ## ##)

*---------------------------------------------------------------------*




FORM SAVE_DATA.



  DATA: LV_MAX_MBLNR TYPE ZMKPF_22-MBLNR,

        LV_NEW_MBLNR TYPE ZMKPF_22-MBLNR.



  DATA: LS_ZMKPF TYPE ZMKPF_22,

        LS_ZMSEG TYPE ZMSEG_22,

        LT_ZMSEG TYPE TABLE OF ZMSEG_22.



  DATA: LV_MSG TYPE STRING.



  " 1. ## ##

  LOOP AT GT_ITEM TRANSPORTING NO FIELDS WHERE MARK = 'X'.

  ENDLOOP.

  IF SY-SUBRC <> 0.

    MESSAGE '### ### ##(##)####.' TYPE 'W'.

    RETURN.

  ENDIF.



  " 2. ## ##

  SELECT SINGLE MAX( MBLNR ) FROM ZMKPF_22 INTO LV_MAX_MBLNR.



  IF LV_MAX_MBLNR IS INITIAL.

    LV_NEW_MBLNR = '5000000000'.

  ELSE.

    LV_NEW_MBLNR = LV_MAX_MBLNR + 1.

  ENDIF.



  " 3. ## ### (ZMKPF_22)

  CLEAR LS_ZMKPF.

  LS_ZMKPF-MANDT = SY-MANDT.

  LS_ZMKPF-MBLNR = LV_NEW_MBLNR.

  LS_ZMKPF-MJAHR = GS_HEADER-MJAHR.

  LS_ZMKPF-BLART = GS_HEADER-BLART.

  LS_ZMKPF-BLDAT = GS_HEADER-BLDAT.

  LS_ZMKPF-BUDAT = GS_HEADER-BUDAT.



  " 4. ### ### (ZMSEG_22)

  CLEAR: LT_ZMSEG. " LV_ZEILE ### ###



  LOOP AT GT_ITEM INTO GS_ITEM WHERE MARK = 'X'.

    " ADD 1 TO LV_ZEILE. " <-- 1# ##### ## ##



    CLEAR LS_ZMSEG.

    LS_ZMSEG-MANDT = SY-MANDT.

    LS_ZMSEG-MBLNR = LV_NEW_MBLNR.

    LS_ZMSEG-MJAHR = GS_HEADER-MJAHR.



    " [##] ## ## ## PO ####(10, 20..)# ### ##

    LS_ZMSEG-ZEILE = GS_ITEM-EBELP.



    " --- ## ---

    LS_ZMSEG-MATNR = GS_ITEM-MATNR.

    LS_ZMSEG-LIFNR = GS_ITEM-LIFNR.

    LS_ZMSEG-WAERS = GS_ITEM-WAERS.

    LS_ZMSEG-MENGE = GS_ITEM-ERFMG.

    LS_ZMSEG-MEINS = GS_ITEM-MEINS.



    LS_ZMSEG-ZWERKS = GS_ITEM-WERKS.

    LS_ZMSEG-ZLGOPT = GS_ITEM-LGORT.

    LS_ZMSEG-EBELN = GS_ITEM-EBELN.



    LS_ZMSEG-BUKRS = '1100'.



    "LS_ZMSEG-GJAHR = GS_HEADER-MJAHR.

    CLEAR LS_ZMSEG-GJAHR.



    LS_ZMSEG-BWART = '101'. " ####: ##

    LS_ZMSEG-SHKZG = 'S'.

    LS_ZMSEG-DMBTR = GS_ITEM-ERFMG * GS_ITEM-STPRS."## ## : ##*##

    "CLEAR LS_ZMSEG-DMBTR.



    APPEND LS_ZMSEG TO LT_ZMSEG.

  ENDLOOP.



  " 5. DB ##

  INSERT ZMKPF_22 FROM LS_ZMKPF.

  IF SY-SUBRC <> 0.

    ROLLBACK WORK.

    MESSAGE '## ## ##' TYPE 'E'.

    RETURN.

  ENDIF.



  INSERT ZMSEG_22 FROM TABLE LT_ZMSEG.

  IF SY-SUBRC <> 0.

    ROLLBACK WORK.

    MESSAGE '### ## ##' TYPE 'E'.

    RETURN.

  ENDIF.



  COMMIT WORK AND WAIT.



  " 6. ## ## # ###

  GS_HEADER-MBLNR = LV_NEW_MBLNR.



  CONCATENATE '##### #######: ' LV_NEW_MBLNR INTO LV_MSG.

  MESSAGE LV_MSG TYPE 'I'.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CANCEL_GOODS_RECEIPT

*&---------------------------------------------------------------------*

* ####(102)# ### ## ## (### ## + ## ### ##)

*---------------------------------------------------------------------*




FORM CANCEL_GOODS_RECEIPT .



  DATA: LV_MAX_MBLNR TYPE ZMKPF_22-MBLNR,

        LV_NEW_MBLNR TYPE ZMKPF_22-MBLNR.



  DATA: LS_ZMKPF_NEW TYPE ZMKPF_22,          " ### ##

        LS_ZMSEG_NEW TYPE ZMSEG_22,          " ### ###

        LT_ZMSEG_NEW TYPE TABLE OF ZMSEG_22.



  DATA: LS_LIST      LIKE LINE OF GT_LIST_200,

        LV_COUNT     TYPE I.



  " 1. ## ##

  LOOP AT GT_LIST_200 INTO LS_LIST WHERE MARK = 'X'.

    ADD 1 TO LV_COUNT.

    " ## ### #(102)## ##

    IF LS_LIST-BWART = '102'.

      MESSAGE '## ### ### #### ####.' TYPE 'W'.

      RETURN.

    ENDIF.

  ENDLOOP.



  IF LV_COUNT = 0.

    MESSAGE '### ### #####.' TYPE 'W'.

    RETURN.

  ENDIF.



  " 2. ## ##

  DATA: LV_ANSWER TYPE C.

  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      TITLEBAR      = '## ##'

      TEXT_QUESTION = '### ### ## ##(##) ######?'

    IMPORTING

      ANSWER        = LV_ANSWER.

  IF LV_ANSWER <> '1'. RETURN. ENDIF.



  " 3. # #### ##

  SELECT SINGLE MAX( MBLNR ) FROM ZMKPF_22 INTO LV_MAX_MBLNR.

  IF LV_MAX_MBLNR IS INITIAL.

    LV_NEW_MBLNR = '5000000000'.

  ELSE.

    LV_NEW_MBLNR = LV_MAX_MBLNR + 1.

  ENDIF.



  " 4. ## ## ### ## (###)

  LS_ZMKPF_NEW-MANDT = SY-MANDT.

  LS_ZMKPF_NEW-MBLNR = LV_NEW_MBLNR.

  LS_ZMKPF_NEW-MJAHR = SY-DATUM+0(4).

  LS_ZMKPF_NEW-BLART = 'WA'.

  LS_ZMKPF_NEW-BLDAT = SY-DATUM.

  LS_ZMKPF_NEW-BUDAT = SY-DATUM.



  LOOP AT GT_LIST_200 INTO LS_LIST WHERE MARK = 'X'.

    CLEAR LS_ZMSEG_NEW.

    MOVE-CORRESPONDING LS_LIST TO LS_ZMSEG_NEW.



    " ==============================================================

    " [##] #### ## ## (### ### #### ##)

    " ==============================================================

    LS_ZMSEG_NEW-ZLGOPT = LS_LIST-ZLGORT. " ALV(ZLGORT) -> DB(ZLGOPT)

    LS_ZMSEG_NEW-ZWERKS = LS_LIST-ZWERKS. " #### #### ##

    " ==============================================================



    LS_ZMSEG_NEW-MANDT = SY-MANDT.

    LS_ZMSEG_NEW-MBLNR = LV_NEW_MBLNR.

    LS_ZMSEG_NEW-MJAHR = LS_ZMKPF_NEW-MJAHR.

    LS_ZMSEG_NEW-ZEILE = LS_LIST-ZEILE.



    " [##] ### ##

    LS_ZMSEG_NEW-BWART = '102'.  " ##

    LS_ZMSEG_NEW-SHKZG = 'H'.    " ##



    APPEND LS_ZMSEG_NEW TO LT_ZMSEG_NEW.

  ENDLOOP.



  " 5. DB ##

  INSERT ZMKPF_22 FROM LS_ZMKPF_NEW.

  INSERT ZMSEG_22 FROM TABLE LT_ZMSEG_NEW.



  IF SY-SUBRC = 0.

    COMMIT WORK AND WAIT.



    DATA: LV_MSG_CANCEL TYPE STRING.

    CONCATENATE '## ## ### #######: ' LV_NEW_MBLNR INTO LV_MSG_CANCEL.

    MESSAGE LV_MSG_CANCEL TYPE 'I'.



    " 6. [##] ## ## (### # # ### ###)

    " ## ## ## ##### ## ####, #### 102### ### 101## ### # ###,

    " ### '## ##### ##### ##'# #### GT_LIST_200## #######.



    DELETE GT_LIST_200 WHERE MARK = 'X'. " ## #### ## ##



    CALL METHOD GC_GRID_BOTTOM->REFRESH_TABLE_DISPLAY.



  ELSE.

    ROLLBACK WORK.

    MESSAGE '## # ### ######.' TYPE 'E'.

  ENDIF.






*DATA: LV_MAX_MBLNR TYPE ZMKPF_22-MBLNR,

*        LV_NEW_MBLNR TYPE ZMKPF_22-MBLNR.

*

*  DATA: LS_ZMKPF_NEW TYPE ZMKPF_22,          " ### ##

*        LS_ZMSEG_NEW TYPE ZMSEG_22,          " ### ###

*        LT_ZMSEG_NEW TYPE TABLE OF ZMSEG_22.

*

*  DATA: LS_LIST      LIKE LINE OF GT_LIST_200,

*        LV_COUNT     TYPE I.

*

*  " 1. ## #### ##

*  IF GC_GRID_BOTTOM IS NOT INITIAL.

*    CALL METHOD GC_GRID_BOTTOM->CHECK_CHANGED_DATA.

*  ENDIF.

*

*  " 2. ## ## ## # ### ##

*  LOOP AT GT_LIST_200 INTO LS_LIST WHERE MARK = 'X'.

*    ADD 1 TO LV_COUNT.

*

*    " [##] ## 102#(## ##)# ## ## ##

*    IF LS_LIST-BWART = '102'.

*      MESSAGE '## ### ### #### ####.' TYPE 'W'.

*      RETURN.

*    ENDIF.

*  ENDLOOP.

*

*  IF LV_COUNT = 0.

*    MESSAGE '### ### #####.' TYPE 'W'.

*    RETURN.

*  ENDIF.

*

*  " 3. ## ##

*  DATA: LV_ANSWER TYPE C.

*  CALL FUNCTION 'POPUP_TO_CONFIRM'

*    EXPORTING

*      TITLEBAR      = '## ##'

*      TEXT_QUESTION = '### ### ## ##(102) ### ########?'

*    IMPORTING

*      ANSWER        = LV_ANSWER.

*  IF LV_ANSWER <> '1'. RETURN. ENDIF.

*

*  " 4. # #### ##

*  SELECT SINGLE MAX( MBLNR ) FROM ZMKPF_22 INTO LV_MAX_MBLNR.

*  IF LV_MAX_MBLNR IS INITIAL.

*    LV_NEW_MBLNR = '5000000000'.

*  ELSE.

*    LV_NEW_MBLNR = LV_MAX_MBLNR + 1.

*  ENDIF.

*

*  " 5. ## ## ### ##

*  " (1) ## (ZMKPF)

*  LS_ZMKPF_NEW-MANDT = SY-MANDT.

*  LS_ZMKPF_NEW-MBLNR = LV_NEW_MBLNR.

*  LS_ZMKPF_NEW-MJAHR = SY-DATUM(4). " ## ##

*  LS_ZMKPF_NEW-BLART = 'WA'.        " ## ##

*  LS_ZMKPF_NEW-BLDAT = SY-DATUM.    " ### (##)

*  LS_ZMKPF_NEW-BUDAT = SY-DATUM.    " ### (##)

*

*  " (2) ### (ZMSEG) - ## ## ##

*  LOOP AT GT_LIST_200 INTO LS_LIST WHERE MARK = 'X'.

*    CLEAR LS_ZMSEG_NEW.

*    MOVE-CORRESPONDING LS_LIST TO LS_ZMSEG_NEW.

*

*    " --- [##] # # # ### ## ---

*    LS_ZMSEG_NEW-MANDT  = SY-MANDT.

*    LS_ZMSEG_NEW-MBLNR  = LV_NEW_MBLNR.       " # ####

*    LS_ZMSEG_NEW-MJAHR  = LS_ZMKPF_NEW-MJAHR. " # ##

*    LS_ZMSEG_NEW-ZEILE  = LS_LIST-ZEILE.      " ## ## ##

*

*    " --- [##] ## ## (### ## ##) ---

*    LS_ZMSEG_NEW-ZLGOPT = LS_LIST-ZLGORT.     " ####

*    LS_ZMSEG_NEW-ZWERKS = LS_LIST-ZWERKS.     " ###

*

*    " --- [##] ### ## (102, H) ---

*    LS_ZMSEG_NEW-BWART  = '102'.  " ####: ##

*    LS_ZMSEG_NEW-SHKZG  = 'H'.    " ###: ##

*

*    APPEND LS_ZMSEG_NEW TO LT_ZMSEG_NEW.

*  ENDLOOP.

*

*  " 6. DB ## (INSERT)

*  INSERT ZMKPF_22 FROM LS_ZMKPF_NEW.

*  INSERT ZMSEG_22 FROM TABLE LT_ZMSEG_NEW.

*

*  IF SY-SUBRC = 0.

*    COMMIT WORK AND WAIT.

*

*    DATA: LV_MSG_CANCEL TYPE STRING.

*    CONCATENATE '## ## ### #######: ' LV_NEW_MBLNR INTO LV_MSG_CANCEL.

*    MESSAGE LV_MSG_CANCEL TYPE 'I'.

*

*    " 7. ## ## (##### ##)

*    "    ## ### ## ## #### #### ## ## ##

*    DELETE GT_LIST_200 WHERE MARK = 'X'.

*

*    CALL METHOD GC_GRID_BOTTOM->REFRESH_TABLE_DISPLAY.

*

*  ELSE.

*    ROLLBACK WORK.

*    MESSAGE '## # ### ######.' TYPE 'E'.

*  ENDIF.






ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SELECT_DATA_GS

*&---------------------------------------------------------------------*

* 1. ## ## (## ## ####) - ####/### ##

*---------------------------------------------------------------------*




FORM SELECT_DATA_GS .



  CLEAR: GT_DOC_LIST, GT_LIST_200, GS_HEADER.



  " [##] ###(BLDAT) -> ###(BUDAT)# ##

  " ### PO(P_EBELN2)# ###(P_WERKS2)# ### ## ### ##

  SELECT DISTINCT A~MBLNR A~MJAHR A~BUDAT

    INTO CORRESPONDING FIELDS OF TABLE GT_DOC_LIST

    FROM ZMKPF_22 AS A

    INNER JOIN ZMSEG_22 AS B

      ON A~MBLNR = B~MBLNR

     AND A~MJAHR = B~MJAHR

    WHERE B~EBELN  = P_EBELN2

      AND B~ZWERKS = P_WERKS2

      AND B~BWART  = '101'

      "AND B~LOEKZ  <> 'X'

    ORDER BY A~MBLNR DESCENDING.



  " [##] ### ### ### ###

  " ##: 5000000000 (20251202)

  LOOP AT GT_DOC_LIST INTO GS_DOC_LIST.

    CONCATENATE GS_DOC_LIST-MBLNR ' (' GS_DOC_LIST-BUDAT ')'

           INTO GS_DOC_LIST-LIST_TEXT.

    MODIFY GT_DOC_LIST FROM GS_DOC_LIST.

  ENDLOOP.



  " #### ### # ## ### #### ## ##

  IF GT_DOC_LIST IS NOT INITIAL.

    PERFORM GET_DETAIL_DATA USING 1.

  ELSE.

    " #### ### ## ## # ###

    CLEAR GS_HEADER.

    MESSAGE '### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DETAIL_DATA

*&---------------------------------------------------------------------*

* 2. ## ## (### ## ## + ## ###)

*---------------------------------------------------------------------*




FORM GET_DETAIL_DATA USING P_INDEX.



  DATA: LS_DOC LIKE LINE OF GT_DOC_LIST.

  READ TABLE GT_DOC_LIST INTO LS_DOC INDEX P_INDEX.

  CHECK SY-SUBRC = 0.



  " (1) ## ###

  SELECT SINGLE * INTO CORRESPONDING FIELDS OF GS_HEADER

    FROM ZMKPF_22

    WHERE MBLNR = LS_DOC-MBLNR

      AND MJAHR = LS_DOC-MJAHR.



  " (2) ### ### ###

  CLEAR GT_LIST_200.

  SELECT A~MBLNR A~ZEILE A~LIFNR A~MATNR A~MENGE A~MEINS

         A~DMBTR A~WAERS A~ZWERKS A~ZLGOPT AS ZLGORT A~BWART

         A~EBELN A~ZEILE AS EBELP

         A~MJAHR B~BUDAT

    INTO CORRESPONDING FIELDS OF TABLE GT_LIST_200

    FROM ZMSEG_22 AS A

    INNER JOIN ZMKPF_22 AS B

      ON A~MBLNR = B~MBLNR

     AND A~MJAHR = B~MJAHR

    WHERE A~MBLNR = LS_DOC-MBLNR

      AND A~MJAHR = LS_DOC-MJAHR.



  " [##] ###(MAKTX) # ####(BUKRS) ###

  LOOP AT GT_LIST_200 INTO GS_LIST_200.



    " ### #### (PO ### ### ##)

    SELECT SINGLE MAKTX

      INTO GS_LIST_200-MAKTX

      FROM ZEKPO_22

      WHERE EBELN = GS_LIST_200-EBELN

        AND MATNR = GS_LIST_200-MATNR.



    " #### ### (### 1100 ## PO#### ##)

    GS_LIST_200-BUKRS = '1100'.



    MODIFY GT_LIST_200 FROM GS_LIST_200.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_ALV_200

*&---------------------------------------------------------------------*




FORM SET_ALV_200 .



  " 1. [##] ## ALV

  IF GC_DOCK_LEFT IS INITIAL.

    CREATE OBJECT GC_DOCK_LEFT

      EXPORTING

        REPID     = SY-REPID

        DYNNR     = '0200'

        SIDE      = CL_GUI_DOCKING_CONTAINER=>DOCK_AT_LEFT

        EXTENSION = 180.



    CREATE OBJECT GC_GRID_LEFT

      EXPORTING I_PARENT = GC_DOCK_LEFT.



    " [##] ### ### ##

    CREATE OBJECT GO_EVENT. " (### TOP## LCL_EVENT_HANDLER# ##)

    SET HANDLER GO_EVENT->HANDLE_DOUBLE_CLICK FOR GC_GRID_LEFT.



    " ### ## ####

    PERFORM BUILD_FCAT_LEFT.



    DATA: LS_LAY_L TYPE LVC_S_LAYO.

    LS_LAY_L-SEL_MODE = 'A'.

    LS_LAY_L-CWIDTH_OPT = 'X'.

    LS_LAY_L-NO_TOOLBAR = 'X'.



    CALL METHOD GC_GRID_LEFT->SET_TABLE_FOR_FIRST_DISPLAY

      EXPORTING IS_LAYOUT       = LS_LAY_L

      CHANGING  IT_OUTTAB       = GT_DOC_LIST

                IT_FIELDCATALOG = GT_FIELDCAT.

  ELSE.

    CALL METHOD GC_GRID_LEFT->REFRESH_TABLE_DISPLAY.

  ENDIF.



  " 2. [##] ## ALV (## ## ##)

  IF GC_DOCK_BOTTOM IS INITIAL.

    CREATE OBJECT GC_DOCK_BOTTOM

      EXPORTING

        REPID     = SY-REPID

        DYNNR     = '0200'

        SIDE      = CL_GUI_DOCKING_CONTAINER=>DOCK_AT_BOTTOM

        EXTENSION = 250.



    CREATE OBJECT GC_GRID_BOTTOM

      EXPORTING I_PARENT = GC_DOCK_BOTTOM.



    PERFORM BUILD_FCAT_BOTTOM.



    CLEAR GS_LAYOUT.

    GS_LAYOUT-CWIDTH_OPT = 'X'.

    GS_LAYOUT-SEL_MODE   = 'A'.



    CALL METHOD GC_GRID_BOTTOM->SET_TABLE_FOR_FIRST_DISPLAY

      EXPORTING IS_LAYOUT       = GS_LAYOUT

      CHANGING  IT_OUTTAB       = GT_LIST_200

                IT_FIELDCATALOG = GT_FIELDCAT.

  ELSE.

    CALL METHOD GC_GRID_BOTTOM->REFRESH_TABLE_DISPLAY.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  BUILD_FCAT_BOTTOM

*&---------------------------------------------------------------------*

* ## ALV (## ##) ## #### ##

*---------------------------------------------------------------------*




FORM BUILD_FCAT_BOTTOM .

  CLEAR: GT_FIELDCAT, GS_FIELDCAT.



  DEFINE _ADD_B.

    CLEAR GS_FIELDCAT.

    GS_FIELDCAT-FIELDNAME = &1.

    GS_FIELDCAT-COLTEXT   = &2.

    GS_FIELDCAT-OUTPUTLEN = &3.

    GS_FIELDCAT-REF_TABLE = &4.

    GS_FIELDCAT-REF_FIELD = &5.



    IF &1 = 'MARK'.

      GS_FIELDCAT-CHECKBOX = 'X'.

      GS_FIELDCAT-EDIT     = 'X'.

    ENDIF.



    IF &1 = 'MENGE'. GS_FIELDCAT-QFIELDNAME = 'MEINS'. ENDIF.

    IF &1 = 'DMBTR'. GS_FIELDCAT-CFIELDNAME = 'WAERS'. ENDIF.



    APPEND GS_FIELDCAT TO GT_FIELDCAT.

  END-OF-DEFINITION.



  " #### #### ## ##

  _ADD_B 'MARK'    '##'        5    ''          ''.

  _ADD_B 'MBLNR'   '######'  10   'ZMKPF_22'  'MBLNR'.

  _ADD_B 'ZEILE'   '##'        5    'ZMSEG_22'  'ZEILE'.

  _ADD_B 'LIFNR'   '###'       10   'ZMSEG_22'  'LIFNR'.

  _ADD_B 'MATNR'   '####'     10   'ZMSEG_22'  'MATNR'.

  _ADD_B 'MAKTX'   '###'       20   'ZEKPO_22'  'MAKTX'.

  _ADD_B 'MENGE'   '##'        13   'ZMSEG_22'  'MENGE'.

  _ADD_B 'MEINS'   '##'        3    'ZMSEG_22'  'MEINS'.

  _ADD_B 'DMBTR'   '##'        15   'ZMSEG_22'  'DMBTR'.

  _ADD_B 'WAERS'   '##'        5    'ZMSEG_22'  'WAERS'.

  _ADD_B 'ZWERKS'  '###'       5    'ZMSEG_22'  'ZWERKS'.

  _ADD_B 'ZLGORT'  '####'     5    'ZMSEG_22'  'ZLGOPT'.

  _ADD_B 'BWART'   '####'     5    'ZMSEG_22'  'BWART'.

  _ADD_B 'EBELN'   '####'     10   'ZMSEG_22'  'EBELN'.

  _ADD_B 'EBELP'   'PO##'      5    'ZMSEG_22'  'ZEILE'.

  _ADD_B 'BUKRS'   '####'     5    ''          ''.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  BUILD_FCAT_LEFT

*&---------------------------------------------------------------------*

* ## ###(#### ##) ## #### ##

*---------------------------------------------------------------------*




FORM BUILD_FCAT_LEFT .



  CLEAR: GT_FIELDCAT, GS_FIELDCAT.



  " 1. ###### (MBLNR)

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'MBLNR'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-KEY       = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 12.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 2. ### (BLDAT)

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'BUDAT'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-OUTPUTLEN = 12.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



ENDFORM.