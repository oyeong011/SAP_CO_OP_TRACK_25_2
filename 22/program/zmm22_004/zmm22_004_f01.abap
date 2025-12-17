
*&---------------------------------------------------------------------*

*&  Include           ZMM22_004_F01

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

"  P_EBELN = '4500000004'.

"  P_WERKS = '1000'.

P_DATE = SY-DATUM.

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

LOOP AT SCREEN.

    " 1. ## ##(P_R1) ### # -> ###(S) ## ##

    IF P_R1 = 'X'.

      IF SCREEN-GROUP1 = 'S'.

        SCREEN-ACTIVE = '0'.

      ENDIF.



    " 2. ## ##(P_R2) ### # -> ###(C) ## ##

    ELSE.

      IF SCREEN-GROUP1 = 'C'.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.



    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  VALID_INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM VALID_INPUT .



  " 0. ## ##(F8/ONLI)# ## ### ### #### ## ##

  CHECK SY-UCOMM = 'ONLI'.



  " [CASE 1] ## ## ## (P_R1) ## #

  IF P_R1 = 'X'.

    " 1-1. ## ### ##

    IF P_EBELN IS INITIAL.

      MESSAGE '#### ### #####.' TYPE 'E'.

    ENDIF.



    IF P_WERKS IS INITIAL.

      MESSAGE '#### #####.' TYPE 'E'.

    ENDIF.



    IF P_DATE IS INITIAL.

      MESSAGE '###### #####.' TYPE 'E'.

    ENDIF.



    " 1-2. ####(PO) ### ## (EKKO ### ##)

    DATA: LV_DUMMY TYPE C.



    SELECT SINGLE 'X'

    INTO @LV_DUMMY

    FROM ZEKKO_22

    WHERE EBELN = @P_EBELN.



    IF SY-SUBRC <> 0.

      MESSAGE '#### ## #### #####.' TYPE 'E'.

    ENDIF.



  " [CASE 2] ## ## ## (P_R2) ## #

  ELSEIF P_R2 = 'X'.

    " 2-1. ## # ## ### ## (####, ###)

    IF P_EBELN2 IS INITIAL. " (### ### P_EBELN2 ##)

      MESSAGE '### #### ### #####.' TYPE 'E'.

    ENDIF.



    IF P_WERKS2 IS INITIAL. " (### ### P_WERKS2 ##)

      MESSAGE '### #### #####.' TYPE 'E'.

    ENDIF.



  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_PO_DATA

*&---------------------------------------------------------------------*




FORM GET_PO_DATA.



  " 1. ## ### ###

  REFRESH GT_ITEM.



  " 2. ####(PO) ### ##

  SELECT A~EBELN,

         B~EBELP,

         B~MATNR,

         B~MAKTX AS TXZ01,

         B~WERKS,

         B~MENGE, " <--- ## PO# ## ## (#: 10#)

         B~MEINS,

         B~STPRS,

         B~MWSKZ,

         A~WAERS,

         A~LIFNR

    FROM ZEKKO_22 AS A

    INNER JOIN ZEKPO_22 AS B ON A~EBELN = B~EBELN

    INTO CORRESPONDING FIELDS OF TABLE @GT_ITEM

    WHERE A~EBELN = @P_EBELN

      AND B~WERKS = @P_WERKS.



  " 3. ### ### (## ## ## & ## ##)

  DATA: LV_IV_QTY TYPE ZRSEG_22-MENGE. " ## ## ### ##



  IF GT_ITEM[] IS NOT INITIAL.



    " ### ### '## ##'# ##

    LOOP AT GT_ITEM INTO GS_ITEM.



      " (1) # ### ## ## ###(DB# ###) ## ## ###

      CLEAR LV_IV_QTY.

      SELECT SUM( MENGE )

        INTO LV_IV_QTY

        FROM ZRSEG_22

        WHERE EBELN = GS_ITEM-EBELN

          AND EBELP = GS_ITEM-EBELP

          AND LOEKZ <> 'X' " ### ## #### ##!

          AND SHKZG = 'S'."###



      " (2) ### ### ## = PO## - ### ##

      GS_ITEM-MENGE = GS_ITEM-MENGE - LV_IV_QTY.



      " (3) ## ### 0 #### ##### ## (## # ###)

      IF GS_ITEM-MENGE <= 0.

        DELETE GT_ITEM INDEX SY-TABIX.

        CONTINUE. " ## ###

      ENDIF.



      " (4) ## ### (## ## * ##)

      GS_ITEM-WRBTR = GS_ITEM-MENGE * GS_ITEM-STPRS.



      " (5) ## ## (## ##)

      " GS_ITEM-WMWST = ... (### ## ##)

      GS_ITEM-DMBTR = GS_ITEM-WRBTR + GS_ITEM-WMWST.



      " ### ##

      GS_ITEM-CHECK = ''.

      GS_ITEM-BUZEI = SY-TABIX.



      MODIFY GT_ITEM FROM GS_ITEM.

    ENDLOOP.

  ENDIF.



  " ### # #### ##### ##

  IF GT_ITEM[] IS INITIAL.

    MESSAGE '### # ## #### ### ####. (## ###)' TYPE 'I'.

  ELSE.

    MESSAGE '#### ## ### ######.' TYPE 'S'.

  ENDIF.




*REFRESH GT_ITEM.

*

*  " 1. PO ## ## (### ##)

*  SELECT A~EBELN, B~EBELP, B~MATNR, B~MAKTX AS TXZ01,

*         B~WERKS, B~MENGE, B~MEINS, B~STPRS, B~MWSKZ, A~WAERS, A~LIFNR

*    FROM ZEKKO_22 AS A

*    INNER JOIN ZEKPO_22 AS B ON A~EBELN = B~EBELN

*    INTO CORRESPONDING FIELDS OF TABLE @GT_ITEM

*    WHERE A~EBELN = @P_EBELN

*      AND B~WERKS = @P_WERKS.

*

*  " 2. ### ## ## (# ## ##: S# ### H# ##)

*  DATA: LV_IV_QTY TYPE ZRSEG_22-MENGE.

*

*  IF GT_ITEM[] IS NOT INITIAL.

*    LOOP AT GT_ITEM INTO GS_ITEM.

*

*      CLEAR LV_IV_QTY.

*

*      " [### ##]

*      " ##(S)## (+), ##(H)## (-)# ##

*      SELECT SUM( CASE WHEN SHKZG = 'H' THEN MENGE * -1

*                       ELSE MENGE END )

*        INTO @LV_IV_QTY

*        FROM ZRSEG_22

*        WHERE EBELN = @GS_ITEM-EBELN

*          AND EBELP = @GS_ITEM-EBELP.

*          " LOEKZ ### ### (### ## X# # ####)

*

*      " 3. ## ## = PO## - #####

*      GS_ITEM-MENGE = GS_ITEM-MENGE - LV_IV_QTY.

*

*      " 4. ## # ### ##

*      IF GS_ITEM-MENGE <= 0.

*        DELETE GT_ITEM INDEX SY-TABIX.

*        CONTINUE.

*      ENDIF.

*

*      " 5. ## ## # ###

*      GS_ITEM-WRBTR = GS_ITEM-MENGE * GS_ITEM-STPRS.

*      GS_ITEM-DMBTR = GS_ITEM-WRBTR + GS_ITEM-WMWST.

*      GS_ITEM-SHKZG = 'S'. " ### ## ### S

*      GS_ITEM-CHECK = ''.

*      GS_ITEM-BUZEI = SY-TABIX.

*

*      MODIFY GT_ITEM FROM GS_ITEM.

*    ENDLOOP.

*  ENDIF.

*

*  " ### ## (### ##)

*  IF GT_ITEM[] IS INITIAL.

*    MESSAGE '### # ## #### ### ####.' TYPE 'I'.

*  ELSE.

*    MESSAGE '#### ## ### ######.' TYPE 'S'.

*  ENDIF.




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

  " 1. ## (## ##)

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 1.

  GS_FIELDCAT-FIELDNAME = 'CHECK'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-CHECKBOX  = 'X'.

  GS_FIELDCAT-EDIT      = 'X'. " ## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 2. ## (## ## ##)

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 2.

  GS_FIELDCAT-FIELDNAME = 'BUZEI'.

  GS_FIELDCAT-COLTEXT   = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 3. ## (## ##, ## ##)

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 3.

  GS_FIELDCAT-FIELDNAME  = 'STPRS'.

  GS_FIELDCAT-COLTEXT    = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'. " ## ## ##

  GS_FIELDCAT-EDIT       = 'X'.     " ## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 4. ###

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 4.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-COLTEXT   = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 5. ## (## ##, ## ##)

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 5.

  GS_FIELDCAT-FIELDNAME  = 'MENGE'.

  GS_FIELDCAT-COLTEXT    = '##'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'. " ## ## ##

  GS_FIELDCAT-EDIT       = 'X'.     " ## ##

  GS_FIELDCAT-REF_TABLE  = 'ZRSEG_22'.

  GS_FIELDCAT-REF_FIELD  = 'MENGE'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 6. ##

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 6.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-COLTEXT   = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 7. #### (## ##)

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 7.

  GS_FIELDCAT-FIELDNAME  = 'WRBTR'.

  GS_FIELDCAT-COLTEXT    = '####'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 8. #### ##

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 8.

  GS_FIELDCAT-FIELDNAME = 'EBELN'.

  GS_FIELDCAT-COLTEXT   = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 9. #### ##

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 9.

  GS_FIELDCAT-FIELDNAME = 'EBELP'.

  GS_FIELDCAT-COLTEXT   = 'PO##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 10. ####

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 10.

  GS_FIELDCAT-FIELDNAME = 'MWSKZ'.

  GS_FIELDCAT-COLTEXT   = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 11. ## (## ##)

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 11.

  GS_FIELDCAT-FIELDNAME  = 'WMWST'.

  GS_FIELDCAT-COLTEXT    = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 12. ####

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 12.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-NO_ZERO   = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 13. ####

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 13.

  GS_FIELDCAT-FIELDNAME = 'TXZ01'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-OUTPUTLEN = 20.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 14. ###

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 14.

  GS_FIELDCAT-FIELDNAME = 'WERKS'.

  GS_FIELDCAT-COLTEXT   = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 15. ## (###+##, ## ##)

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 15.

  GS_FIELDCAT-FIELDNAME  = 'DMBTR'.

  GS_FIELDCAT-COLTEXT    = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 16.

  GS_FIELDCAT-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT-COLTEXT   = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 16. ### (## ##)

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 16.

  GS_FIELDCAT-FIELDNAME = 'SGTXT'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-EDIT      = 'X'. " ## ##

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

*&      Form  SAVE_DATA

*&---------------------------------------------------------------------*




FORM SAVE_DATA.

  DATA: LS_RBKP TYPE ZRBKP_22,      " ## ###

        LT_RSEG TYPE TABLE OF ZRSEG_22,

        LS_RSEG TYPE ZRSEG_22.



  DATA: LV_MAX_BELNR TYPE ZRBKP_22-BELNR,

        LV_NEW_BELNR TYPE ZRBKP_22-BELNR.



  " 1. ## ## ##

  READ TABLE GT_ITEM WITH KEY CHECK = 'X' TRANSPORTING NO FIELDS.

  IF SY-SUBRC <> 0.

    MESSAGE '### ### ### ## ## #####.' TYPE 'S' DISPLAY LIKE 'E'.

    EXIT.

  ENDIF.



  " 2. ## ##

  SELECT MAX( BELNR ) FROM ZRBKP_22 INTO LV_MAX_BELNR.

  IF LV_MAX_BELNR IS INITIAL.

    LV_NEW_BELNR = '5000000000'.

  ELSE.

    LV_NEW_BELNR = LV_MAX_BELNR + 1.

  ENDIF.



  " 3. [##] ### ##

  " (1) ## ### (###, ###, ##, ##, #### #) ##

  MOVE-CORRESPONDING ZRBKP_22 TO LS_RBKP.



  " (2) ## ## ##

  LS_RBKP-BELNR  = LV_NEW_BELNR. " ##

  LS_RBKP-GJAHR  = SY-DATUM(4).  " ##

  LS_RBKP-RBSTAT = '5'.          " ## (###)



  " 1) ## ## (BLART) - ##(RE) ##

  LS_RBKP-BLART = 'RE'.



  " 2) PO ## & ### (EBELN, WERKS) - Selection Screen ## ##

  " (#### P_EBELN, P_WERKS# ### #####)

  LS_RBKP-EBELN = P_EBELN.

  LS_RBKP-WERKS = P_WERKS.



  " 3) ####(BUKRS), ###(LIFNR), ##(WAERS) - PO #### ##

  SELECT SINGLE BUKRS, LIFNR, WAERS

    INTO (@LS_RBKP-BUKRS, @LS_RBKP-LIFNR, @LS_RBKP-WAERS)

    FROM ZEKKO_22

    WHERE EBELN = @P_EBELN.



  " (## #### ### ###### #### ### ##)

  IF LS_RBKP-WAERS IS INITIAL.

    LS_RBKP-WAERS = 'KRW'. " ###

  ENDIF.

  " -----------------------------------------------------------





  " 4. [###] ### ##

  LOOP AT GT_ITEM INTO GS_ITEM WHERE CHECK = 'X'.

    CLEAR LS_RSEG.

    MOVE-CORRESPONDING GS_ITEM TO LS_RSEG.



    " ## ## ###

    LS_RSEG-BELNR = LV_NEW_BELNR.

    LS_RSEG-GJAHR = LS_RBKP-GJAHR.



    " ##/##/### #

    LS_RSEG-STPRS = GS_ITEM-STPRS.

    LS_RSEG-BSTME = GS_ITEM-MEINS. " ##

    LS_RSEG-SHKZG = 'S'.           " ##(S)






*    " -------------------------------------------------------------

*    " [##] ###(LIFNR) ## (DB #### ### ### ###)

*    " -------------------------------------------------------------

*    " ## 1: ALV #### ## # ## (GET_PO_DATA## #####)

*    LS_RSEG-LIFNR = GS_ITEM-LIFNR.

*

*    " ## 2: ## GS_ITEM# ## ##### ## ## ## (####)

*    IF LS_RSEG-LIFNR IS INITIAL.

*       LS_RSEG-LIFNR = LS_RBKP-LIFNR.

*    ENDIF.

*    " -------------------------------------------------------------






    APPEND LS_RSEG TO LT_RSEG.

  ENDLOOP.



  " 5. ##

  INSERT ZRBKP_22 FROM LS_RBKP.

  INSERT ZRSEG_22 FROM TABLE LT_RSEG.



  IF SY-SUBRC = 0.

    COMMIT WORK AND WAIT.

    "MESSAGE S000(ZMM) WITH '### #######. ####:' LV_NEW_BELNR.

    DATA: LV_MSG TYPE STRING.

    CONCATENATE '### #######. ####: ' LV_NEW_BELNR INTO LV_MSG.



    MESSAGE LV_MSG TYPE 'I'.



  ELSE.

    ROLLBACK WORK.

    MESSAGE '## # ### ######.' TYPE 'I'.

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

" 1. ### ### ## ## (TOP# ### GO_EVENT ## ##)

  IF GO_EVENT IS INITIAL.

    CREATE OBJECT GO_EVENT.

  ENDIF.



  " 2. #### ALV Grid(GC_GRID) ##

  "    (#### ### # HANDLE_DATA_CHANGED #### ##### #)

  SET HANDLER GO_EVENT->HANDLE_DATA_CHANGED FOR GC_GRID.



  " 3. [##] ##(Enter)# ## # ## #### ##### ##

  "    (# ### ### ## ### ### ## ## ### # ###)

  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH_CELL

*&---------------------------------------------------------------------*




FORM REFRESH_CELL USING P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                        P_ROW_ID TYPE I P_FIELD TYPE C P_VALUE TYPE ANY.

  CALL METHOD P_DATA_CHANGED->MODIFY_CELL

    EXPORTING I_ROW_ID = P_ROW_ID I_FIELDNAME = P_FIELD I_VALUE = P_VALUE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DATA_CHANGED_LOGIC

*&---------------------------------------------------------------------*

* CLS## ##: ## ## # ## ## ##

*----------------------------------------------------------------------*




FORM DATA_CHANGED_LOGIC USING P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL.

  DATA: LS_MOD_CELL TYPE LVC_S_MODI.



  LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MOD_CELL.

    IF LS_MOD_CELL-FIELDNAME = 'MENGE'.

      READ TABLE GT_ITEM INTO GS_ITEM INDEX LS_MOD_CELL-ROW_ID.

      IF SY-SUBRC = 0.

        " 1. ### ## ##

        CALL METHOD P_DATA_CHANGED->GET_CELL_VALUE

          EXPORTING I_ROW_ID = LS_MOD_CELL-ROW_ID I_FIELDNAME = 'MENGE'

          IMPORTING E_VALUE  = GS_ITEM-MENGE.



        " 2. ## ## ## ##

        PERFORM CALC_AMOUNT CHANGING GS_ITEM.



        " 3. ### ### ##

        MODIFY GT_ITEM FROM GS_ITEM INDEX LS_MOD_CELL-ROW_ID.



        " 4. ## ## (## ## ###)

        PERFORM REFRESH_CELL USING P_DATA_CHANGED LS_MOD_CELL-ROW_ID 'WRBTR' GS_ITEM-WRBTR.

        PERFORM REFRESH_CELL USING P_DATA_CHANGED LS_MOD_CELL-ROW_ID 'WMWST' GS_ITEM-WMWST.

        PERFORM REFRESH_CELL USING P_DATA_CHANGED LS_MOD_CELL-ROW_ID 'DMBTR' GS_ITEM-DMBTR.

      ENDIF.

    ENDIF.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALC_AMOUNT

*&---------------------------------------------------------------------*

* [##] ## ### ## (###, ##, ##)

*----------------------------------------------------------------------*




FORM CALC_AMOUNT CHANGING PS_ITEM LIKE GS_ITEM.

  " 1. #### = ## * ##

  PS_ITEM-WRBTR = PS_ITEM-MENGE * PS_ITEM-STPRS.



  " 2. ## ##

  CASE PS_ITEM-MWSKZ.

    WHEN 'V1' OR 'V4' OR 'V5'. " 10%

      PS_ITEM-WMWST = PS_ITEM-WRBTR * '0.1'.

    WHEN OTHERS. " 0% (V2, V3 #)

      PS_ITEM-WMWST = 0.

  ENDCASE.



  " 3. ## = ### + ##

  PS_ITEM-DMBTR = PS_ITEM-WRBTR + PS_ITEM-WMWST.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  APPLY_HEADER_TAX

*&---------------------------------------------------------------------*

* [PAI ##] ## ##### ## #### ##

*----------------------------------------------------------------------*




FORM APPLY_HEADER_TAX.

  " 1. ### ##

  CASE ZRBKP_22-MWSKZ.

    WHEN 'V1' OR 'V2' OR 'V3' OR 'V4' OR 'V5'.

    WHEN OTHERS.

      MESSAGE '### #######. (V1~V5)' TYPE 'S' DISPLAY LIKE 'E'.

      EXIT.

  ENDCASE.



  IF GT_ITEM[] IS INITIAL. EXIT. ENDIF.



  " 2. ## ##

  LOOP AT GT_ITEM INTO GS_ITEM.

    GS_ITEM-MWSKZ = ZRBKP_22-MWSKZ. " ## # ##

    PERFORM CALC_AMOUNT CHANGING GS_ITEM. " ###

    MODIFY GT_ITEM FROM GS_ITEM.

  ENDLOOP.



  " 3. ALV ## ####

  IF GC_GRID IS NOT INITIAL.

    CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALCULATE_BALANCE

*&---------------------------------------------------------------------*




FORM CALCULATE_BALANCE.

  DATA : LV_SUM_ALL_ITEMS TYPE ZRBKP_22-RMWWR, " [##] ## ##

         LV_SUM_ALL_TAX   TYPE ZRBKP_22-WMWST, " [##] ## ##

         LV_SUM_CHK_ITEMS TYPE ZRBKP_22-RMWWR, " [##] ## ##

         LV_SUM_CHK_TAX   TYPE ZRBKP_22-WMWST, " [##] ## ##

         LV_DIFF          TYPE ZRBKP_22-RMWWR, " ## ##

         LV_CNT           TYPE I.              " ### ##



  "## #(0120)# ## ### ### 0## #### ##

  IF GV_SUB_DYNNR = '0120'.

    BALANCE = 0.

    " ICON = ''. " (## # ### ##)

    EXIT. " # ## #### ## ##

  ENDIF.



  CLEAR: LV_SUM_ALL_ITEMS, LV_SUM_ALL_TAX,

         LV_SUM_CHK_ITEMS, LV_SUM_CHK_TAX,

         BALANCE, ICON, LV_CNT.



  " 1. ## #### ##

  IF GC_GRID IS NOT INITIAL.

    CALL METHOD GC_GRID->CHECK_CHANGED_DATA.

  ENDIF.



  " 1. ## #### ##

  IF GC_GRID IS NOT INITIAL.

    CALL METHOD GC_GRID->CHECK_CHANGED_DATA.

  ENDIF.



  " 2. ## ## (### ## # ##/## ## ## ##)

  LOOP AT GT_ITEM INTO GS_ITEM.



    " (1) ## #### ## ## (#### V1 ## ## # ##)

    IF ZRBKP_22-MWSKZ IS NOT INITIAL.

       GS_ITEM-MWSKZ = ZRBKP_22-MWSKZ.

    ENDIF.



    " (2) ### (##, ##)

    PERFORM CALC_AMOUNT CHANGING GS_ITEM.



    " (3) [## ##] ### ## (#####)

    ADD GS_ITEM-DMBTR TO LV_SUM_ALL_ITEMS.

    ADD GS_ITEM-WMWST TO LV_SUM_ALL_TAX.



    " (4) [## ##] ### ## ##

    IF GS_ITEM-CHECK = 'X'.

      ADD 1 TO LV_CNT. " ## ## ##

      ADD GS_ITEM-DMBTR TO LV_SUM_CHK_ITEMS.

      ADD GS_ITEM-WMWST TO LV_SUM_CHK_TAX.

    ENDIF.



    MODIFY GT_ITEM FROM GS_ITEM.

  ENDLOOP.



  " 3. ## ## (ALV# ### ## ####)

  IF GC_GRID IS NOT INITIAL.

    CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY.

  ENDIF.



  " 4. [## ##] ### ### # ##

  "    ### # ### -> ## ## ##

  "    ### # ### -> ## ## ## (## #### #####!)

  DATA: LV_FINAL_TAX   TYPE ZRBKP_22-WMWST,

        LV_FINAL_TOTAL TYPE ZRBKP_22-RMWWR.



  IF LV_CNT > 0.

    LV_FINAL_TAX   = LV_SUM_CHK_TAX.

    LV_FINAL_TOTAL = LV_SUM_CHK_ITEMS.

  ELSE.

    LV_FINAL_TAX   = LV_SUM_ALL_TAX.

    LV_FINAL_TOTAL = LV_SUM_ALL_ITEMS.

  ENDIF.



  " 5. ## ## # ## ##

  ZRBKP_22-WMWST = LV_FINAL_TAX.

  LV_DIFF = ZRBKP_22-RMWWR - LV_FINAL_TOTAL.



  " 6. ### ##

  IF GV_CALC_FLAG IS INITIAL.

    " ####: #### # ###

    ICON           = '@0A@'.

    BALANCE        = 0.

    ZRBKP_22-WMWST = 0.

  ELSE.

    " ####: # ##

    BALANCE = LV_DIFF.



    IF BALANCE = 0 AND ZRBKP_22-RMWWR <> 0.

      ICON = '@08@'.

    ELSE.

      ICON = '@0A@'.

    ENDIF.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALC_DUEDATE

*&---------------------------------------------------------------------*




FORM CALC_DUEDATE.

  DATA: LV_BASE_DATE TYPE DATS.



  " ###(###)# ### ## ##

  IF ZRBKP_22-BLDAT IS INITIAL.

    EXIT.

  ENDIF.

  LV_BASE_DATE = ZRBKP_22-BLDAT.



  CASE ZRBKP_22-ZTERM.

    " --- ## ## (YYYYMM + ##) ---

    WHEN 'M001'. " ## 10#

      CONCATENATE LV_BASE_DATE(6) '10' INTO ZRBKP_22-ZFBDT.

    WHEN 'M002'. " ## 25#

      CONCATENATE LV_BASE_DATE(6) '25' INTO ZRBKP_22-ZFBDT.



    " --- ## ## (# # ##) ---

    WHEN 'M003'. " ## 10#

      CALL FUNCTION 'RP_CALC_DATE_IN_INTERVAL'

        EXPORTING DATE = LV_BASE_DATE DAYS = 0 MONTHS = 1 SIGNUM = '+' YEARS = 0

        IMPORTING CALC_DATE = LV_BASE_DATE.

      CONCATENATE LV_BASE_DATE(6) '10' INTO ZRBKP_22-ZFBDT.



    WHEN 'M004'. " ## 25#

      CALL FUNCTION 'RP_CALC_DATE_IN_INTERVAL'

        EXPORTING DATE = LV_BASE_DATE DAYS = 0 MONTHS = 1 SIGNUM = '+' YEARS = 0

        IMPORTING CALC_DATE = LV_BASE_DATE.

      CONCATENATE LV_BASE_DATE(6) '25' INTO ZRBKP_22-ZFBDT.



    " --- ### ## (# # ##) ---

    WHEN 'M005'.

       CALL FUNCTION 'RP_CALC_DATE_IN_INTERVAL'

        EXPORTING DATE = LV_BASE_DATE DAYS = 0 MONTHS = 2 SIGNUM = '+' YEARS = 0

        IMPORTING CALC_DATE = LV_BASE_DATE.

       CONCATENATE LV_BASE_DATE(6) '10' INTO ZRBKP_22-ZFBDT.

    WHEN 'M006'.

       CALL FUNCTION 'RP_CALC_DATE_IN_INTERVAL'

        EXPORTING DATE = LV_BASE_DATE DAYS = 0 MONTHS = 2 SIGNUM = '+' YEARS = 0

        IMPORTING CALC_DATE = LV_BASE_DATE.

       CONCATENATE LV_BASE_DATE(6) '25' INTO ZRBKP_22-ZFBDT.



    " --- ## ### ---

    WHEN 'P010'. ZRBKP_22-ZFBDT = LV_BASE_DATE + 10.

    WHEN 'P015'. ZRBKP_22-ZFBDT = LV_BASE_DATE + 15.

    WHEN 'P020'. ZRBKP_22-ZFBDT = LV_BASE_DATE + 20.

    WHEN 'P030'. ZRBKP_22-ZFBDT = LV_BASE_DATE + 30.

    WHEN 'P060'. ZRBKP_22-ZFBDT = LV_BASE_DATE + 60.

    WHEN 'P090'. ZRBKP_22-ZFBDT = LV_BASE_DATE + 90.



  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_BASIC_DATA

*&---------------------------------------------------------------------*

* [######] ###(##, ##)# ## ## ### ##

*----------------------------------------------------------------------*




FORM CHECK_BASIC_DATA CHANGING pv_result TYPE c.



  pv_result = 'E'. " ### ##



  " 1. ### ## (##, ###)

  IF ZRBKP_22-BLDAT IS INITIAL.

    MESSAGE '###### #####.' TYPE 'S' DISPLAY LIKE 'E'. EXIT.

  ENDIF.



  IF ZRBKP_22-RMWWR IS INITIAL.

    MESSAGE '### #####.' TYPE 'S' DISPLAY LIKE 'E'. EXIT.

  ENDIF.



  " 2. ## ## (## ##)

  PERFORM CALCULATE_BALANCE.

  IF BALANCE <> 0.

    MESSAGE '### ### #### ####.' TYPE 'S' DISPLAY LIKE 'E'. EXIT.

  ENDIF.



  " ##

  pv_result = 'S'.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_STRICT_DATA

*&---------------------------------------------------------------------*

* [###] #### ##, ####, #### ### ##

*----------------------------------------------------------------------*




FORM CHECK_STRICT_DATA CHANGING pv_result TYPE c.



  pv_result = 'E'.



  " 1. [####] ### ## ## ##

  READ TABLE GT_ITEM WITH KEY CHECK = 'X' TRANSPORTING NO FIELDS.

  IF SY-SUBRC <> 0.

    MESSAGE '### ### ### ## ## #####.' TYPE 'S' DISPLAY LIKE 'E'. EXIT.

  ENDIF.



  " 2. [####] ### ##

  CASE ZRBKP_22-MWSKZ.

    WHEN 'V1' OR 'V2' OR 'V3' OR 'V4' OR 'V5'.

      " ##

    WHEN OTHERS.

      MESSAGE '#### ## #######. (V1~V5)' TYPE 'S' DISPLAY LIKE 'E'. EXIT.

  ENDCASE.



  " 3. [####] ### ##

  CASE ZRBKP_22-ZTERM.

    WHEN 'M001' OR 'M002' OR 'M003' OR 'M004' OR 'M005' OR 'M006'

      OR 'P010' OR 'P015' OR 'P020' OR 'P030' OR 'P060' OR 'P090'.

      " ##

    WHEN OTHERS.

      MESSAGE '#### ## #######.' TYPE 'S' DISPLAY LIKE 'E'. EXIT.

  ENDCASE.



  " ##

  pv_result = 'S'.



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

" (1) ## #### ##

  CREATE OBJECT GC_DOCKING_200

    EXPORTING

      SIDE      = CL_GUI_DOCKING_CONTAINER=>DOCK_AT_BOTTOM

      EXTENSION = 2000.

      "RATIO     = 40.



  " (2) ### ##

  CREATE OBJECT GC_GRID_200

    EXPORTING

      I_PARENT = GC_DOCKING_200.

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

CLEAR : GS_FIELDCAT, GT_FIELDCAT.



  " 1. ## (####) - #### #### ## ## ## ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 1.

  GS_FIELDCAT-FIELDNAME  = 'CHECK'.

  GS_FIELDCAT-COLTEXT    = '##'.

  GS_FIELDCAT-CHECKBOX   = 'X'.

  GS_FIELDCAT-EDIT       = 'X'. " ##### ## #### #

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 2. ######

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 2.

  GS_FIELDCAT-FIELDNAME  = 'BELNR'.

  GS_FIELDCAT-COLTEXT    = '######'.

  GS_FIELDCAT-KEY        = 'X'. " # ### ## (## ##)

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 3. ####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 3.

  GS_FIELDCAT-FIELDNAME  = 'GJAHR'.

  GS_FIELDCAT-COLTEXT    = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 4. ######

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 4.

  GS_FIELDCAT-FIELDNAME  = 'BUZEI'.

  GS_FIELDCAT-COLTEXT    = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 5. ######

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 5.

  GS_FIELDCAT-FIELDNAME  = 'EBELN'.

  GS_FIELDCAT-COLTEXT    = '######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 6. ####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 6.

  GS_FIELDCAT-FIELDNAME  = 'MATNR'.

  GS_FIELDCAT-COLTEXT    = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 7. ###

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 7.

  GS_FIELDCAT-FIELDNAME  = 'TXZ01'.

  GS_FIELDCAT-COLTEXT    = '###'.

  GS_FIELDCAT-OUTPUTLEN  = 20.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 8. ####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 8.

  GS_FIELDCAT-FIELDNAME  = 'MENGE'.

  GS_FIELDCAT-COLTEXT    = '####'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'. " ## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 9. ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 9.

  GS_FIELDCAT-FIELDNAME  = 'MEINS'.

  GS_FIELDCAT-COLTEXT    = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 10. ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 10.

  GS_FIELDCAT-FIELDNAME  = 'STPRS'.

  GS_FIELDCAT-COLTEXT    = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'. " ## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 11. ####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 11.

  GS_FIELDCAT-FIELDNAME  = 'WRBTR'.

  GS_FIELDCAT-COLTEXT    = '####'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 12. ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 12.

  GS_FIELDCAT-FIELDNAME  = 'WMWST'.

  GS_FIELDCAT-COLTEXT    = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 13. ## (### + ##)

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 13.

  GS_FIELDCAT-FIELDNAME  = 'DMBTR'.

  GS_FIELDCAT-COLTEXT    = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 14. ###

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 14.

  GS_FIELDCAT-FIELDNAME  = 'SGTXT'.

  GS_FIELDCAT-COLTEXT    = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 15. ###

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 15.

  GS_FIELDCAT-FIELDNAME  = 'WAERS'.

  GS_FIELDCAT-COLTEXT    = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 16.

  GS_FIELDCAT-FIELDNAME  = 'LIFNR'.

  GS_FIELDCAT-COLTEXT    = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 16. #/## ###




*  CLEAR GS_FIELDCAT.

*  GS_FIELDCAT-COL_POS    = 16.

*  GS_FIELDCAT-FIELDNAME  = 'SHKZG'.

*  GS_FIELDCAT-COLTEXT    = '#/##'.

*  APPEND GS_FIELDCAT TO GT_FIELDCAT.




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

  GS_LAYOUT-CWIDTH_OPT = 'X'.

  GS_LAYOUT-SEL_MODE   = 'A'.

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

CALL METHOD GC_GRID_200->SET_TABLE_FOR_FIRST_DISPLAY

      EXPORTING

        IS_LAYOUT       = GS_LAYOUT

      CHANGING

        IT_OUTTAB       = GT_ITEM

        IT_FIELDCATALOG = GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH_ALV_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM REFRESH_ALV_200 .

DATA: LS_STABLE TYPE LVC_S_STBL.

  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GC_GRID_200->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE = LS_STABLE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CANCLE_LINE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CANCEL_LINE .

  DATA: LV_CNT TYPE I.

  DATA: LS_ITEM_CHECK LIKE LINE OF GT_ITEM.



  " 1. ## #### ##

  IF GC_GRID_200 IS NOT INITIAL.

    CALL METHOD GC_GRID_200->CHECK_CHANGED_DATA.

  ENDIF.



  " 2. ## ## ### ##

  LOOP AT GT_ITEM INTO LS_ITEM_CHECK WHERE CHECK = 'X'.

    ADD 1 TO LV_CNT.

    " ## ## ##(H)# ## # ### ## ##

    IF LS_ITEM_CHECK-SHKZG = 'H'.

      MESSAGE '## ## ###(##) ### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

      RETURN.

    ENDIF.

  ENDLOOP.



  IF LV_CNT = 0.

    MESSAGE '### ### #####.' TYPE 'S' DISPLAY LIKE 'E'.

    EXIT.

  ENDIF.



  " 3. ## ##

  DATA: LV_ANSWER TYPE C.

  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      TITLEBAR      = '## ##'

      TEXT_QUESTION = '### ### ## ########?'

    IMPORTING

      ANSWER        = LV_ANSWER.



  IF LV_ANSWER <> '1'. RETURN. ENDIF.



  " -----------------------------------------------------------

  " [##] # #### ##

  " -----------------------------------------------------------

  DATA: LV_MAX_BELNR TYPE ZRBKP_22-BELNR,

        LV_NEW_BELNR TYPE ZRBKP_22-BELNR.



  SELECT SINGLE MAX( BELNR ) FROM ZRBKP_22 INTO LV_MAX_BELNR.

  IF LV_MAX_BELNR IS INITIAL.

    LV_NEW_BELNR = '5000000000'.

  ELSE.

    LV_NEW_BELNR = LV_MAX_BELNR + 1.

  ENDIF.



  " -----------------------------------------------------------

  " [1##] # ##(#####) ### ##

  " -----------------------------------------------------------

  DATA: LS_RBKP_NEW TYPE ZRBKP_22,

        LS_RSEG_NEW TYPE ZRSEG_22,

        LT_RSEG_NEW TYPE TABLE OF ZRSEG_22.



  " ### # ## #### ## ## ### ###

  READ TABLE GT_ITEM INTO GS_ITEM WITH KEY CHECK = 'X'.



  SELECT SINGLE * FROM ZRBKP_22 INTO LS_RBKP_NEW

    WHERE BELNR = GS_ITEM-BELNR

      AND GJAHR = GS_ITEM-GJAHR.



  " # ## ## ##

  LS_RBKP_NEW-BELNR  = LV_NEW_BELNR.  " # ##

  LS_RBKP_NEW-GJAHR  = SY-DATUM(4).   " ##

  LS_RBKP_NEW-BLDAT  = SY-DATUM.      " ##

  LS_RBKP_NEW-BUDAT  = SY-DATUM.      " ##

  LS_RBKP_NEW-BLART  = ''.          " ####: ## ##(##)

  LS_RBKP_NEW-RBSTAT = '5'.           " ##: ###

  LS_RBKP_NEW-STBLG  = GS_ITEM-BELNR. " ## ## ##

  LS_RBKP_NEW-STJAH  = GS_ITEM-GJAHR. " ## ## ##

  LS_RBKP_NEW-RMWWR  = 0.             " (## #### ##)

  LS_RBKP_NEW-WMWST  = 0.             " (## #### ##)



  " -----------------------------------------------------------

  " [2##] ### ## ## (# ## ## + ## ##)

  " -----------------------------------------------------------

  LOOP AT GT_ITEM INTO GS_ITEM WHERE CHECK = 'X'.



    " (A) # ### ## (INSERT#) -> ##(H)

    CLEAR LS_RSEG_NEW.

    MOVE-CORRESPONDING GS_ITEM TO LS_RSEG_NEW.



    LS_RSEG_NEW-BELNR = LV_NEW_BELNR.       " # ##

    LS_RSEG_NEW-GJAHR = LS_RBKP_NEW-GJAHR.  " # ##

    LS_RSEG_NEW-SHKZG = 'H'.                " # ## (Credit)

    LS_RSEG_NEW-LOEKZ = ''.                 " # # ### ## ##(##)

    LS_RSEG_NEW-SGTXT = '## ##'.        " ###



    " ## ## (###)

    LS_RBKP_NEW-RMWWR = LS_RBKP_NEW-RMWWR + GS_ITEM-DMBTR.

    LS_RBKP_NEW-WMWST = LS_RBKP_NEW-WMWST + GS_ITEM-WMWST.



    APPEND LS_RSEG_NEW TO LT_RSEG_NEW.



    " (B) ## ### ## (UPDATE#) -> ####(X)

    "     # ### SHKZG(S)# #### ## LOEKZ# X# ##

    UPDATE ZRSEG_22

       SET LOEKZ = 'X'

     WHERE BELNR = GS_ITEM-BELNR

       AND GJAHR = GS_ITEM-GJAHR

       AND BUZEI = GS_ITEM-BUZEI.



    IF SY-SUBRC <> 0.

      ROLLBACK WORK.

      MESSAGE '## ### #### ##. # ## #####.' TYPE 'E'.

      RETURN.

    ENDIF.



  ENDLOOP.



  " -----------------------------------------------------------

  " [3##] DB ## # ##

  " -----------------------------------------------------------

  " 1) # ## ##

  INSERT ZRBKP_22 FROM LS_RBKP_NEW.

  INSERT ZRSEG_22 FROM TABLE LT_RSEG_NEW.



  IF SY-SUBRC = 0.

    " 2) ## ### '### ####' ##

    UPDATE ZRBKP_22

       SET STBLG = LV_NEW_BELNR

           STJAH = SY-DATUM(4)

     WHERE BELNR = GS_ITEM-BELNR

       AND GJAHR = GS_ITEM-GJAHR.



    " 3) ## ##

    COMMIT WORK AND WAIT.



    "MESSAGE '## ##(KG)# #######. ### ## #######.' TYPE 'S'.

    MESSAGE '#######.' TYPE 'S'.



    " 4) ## ## (### # ##### ##)

    PERFORM REFRESH_ITEMS.

    CALL METHOD GC_GRID_200->REFRESH_TABLE_DISPLAY.



  ELSE.

    ROLLBACK WORK.

    MESSAGE 'DB ## # ### ######.' TYPE 'E'.

  ENDIF.






*DATA: LV_CNT       TYPE I,

*        LV_MAX_BUZEI TYPE ZRSEG_22-BUZEI.

*

*  DATA: LS_RSEG_NEW  TYPE ZRSEG_22. " ## ### ## ##

*

*  " 1. #### ##

*  IF GC_GRID_200 IS NOT INITIAL.

*    CALL METHOD GC_GRID_200->CHECK_CHANGED_DATA.

*  ENDIF.

*

*  " 2. ## ##

*  LOOP AT GT_ITEM TRANSPORTING NO FIELDS WHERE CHECK = 'X'.

*    ADD 1 TO LV_CNT.

*  ENDLOOP.

*

*  IF LV_CNT = 0.

*    MESSAGE '### ### #####.' TYPE 'S' DISPLAY LIKE 'E'.

*    EXIT.

*  ENDIF.

*

*  " 3. ## ##

*  DATA: LV_ANSWER TYPE C.

*  CALL FUNCTION 'POPUP_TO_CONFIRM'

*    EXPORTING

*      TITLEBAR      = '### ##'

*      TEXT_QUESTION = '### ### ## ###(##) ### ########?'

*    IMPORTING

*      ANSWER        = LV_ANSWER.

*  IF LV_ANSWER <> '1'. RETURN. ENDIF.

*

*  CLEAR LV_CNT.

*

*  " 4. ### ## ##

*  LOOP AT GT_ITEM INTO GS_ITEM WHERE CHECK = 'X'.

*

*    " (1) ### ##: ## 'H'(####)# # # ## ##

*    IF GS_ITEM-SHKZG = 'H'.

*      MESSAGE '## ###(##) ### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

*      CONTINUE.

*    ENDIF.

*

*    " (2) ## ### ## ### ####(BUZEI) ##

*    "     (# ### #### ### ### ## #)

*    SELECT SINGLE MAX( BUZEI )

*      INTO LV_MAX_BUZEI

*      FROM ZRSEG_22

*      WHERE BELNR = GS_ITEM-BELNR

*        AND GJAHR = GS_ITEM-GJAHR.

*

*    " (3) # ### ### ## (INSERT#)

*    CLEAR LS_RSEG_NEW.

*    MOVE-CORRESPONDING GS_ITEM TO LS_RSEG_NEW.

*

*    LS_RSEG_NEW-BUZEI = LV_MAX_BUZEI + 1. " ## ## (1 -> 2)

*    LS_RSEG_NEW-SHKZG = 'H'.              " # ##: ##(H)## ##

*    LS_RSEG_NEW-LOEKZ = ''.               " ## ##

*    LS_RSEG_NEW-SGTXT = '##(###)'.   " ##

*

*    " (4) DB# # ## ## (INSERT)

*    INSERT ZRSEG_22 FROM LS_RSEG_NEW.

*

*    IF SY-SUBRC = 0.

*      ADD 1 TO LV_CNT.

*

*      " (5) ## ## ## (## ### ##)

*      "     ##(S) 10000# + ##(H) 10000# -> ### 0## ### #

*      UPDATE ZRBKP_22

*         SET RMWWR = RMWWR - LS_RSEG_NEW-WRBTR

*             WMWST = WMWST - LS_RSEG_NEW-WMWST

*       WHERE BELNR = GS_ITEM-BELNR

*         AND GJAHR = GS_ITEM-GJAHR.

*    ENDIF.

*  ENDLOOP.

*

*  " 5. ## ##

*  IF LV_CNT > 0.

*    COMMIT WORK AND WAIT.

*    MESSAGE '### ### #######. (S + H = 0)' TYPE 'S'.

*

*    " ## ##

*    PERFORM GET_INVOICE_DATA.

*    CALL METHOD GC_GRID_200->REFRESH_TABLE_DISPLAY.

*  ELSE.

*    ROLLBACK WORK.

*    MESSAGE '## # ### ######.' TYPE 'E'.

*  ENDIF.




ENDFORM.




*&---------------------------------------------------------------------*

*& Form SELECT_INVOICE_LIST (## ## ##)

*&---------------------------------------------------------------------*




FORM SELECT_INVOICE_LIST.

CLEAR: GT_DOC_LIST.



  " [##]

  " 1. ##(RE) ### ##

  " 2. LOEKZ ## ## -> ## #### ###### ## #### ### (### ##)

  SELECT DISTINCT A~BELNR A~GJAHR A~BUDAT A~LIFNR A~RMWWR A~WAERS

    INTO CORRESPONDING FIELDS OF TABLE GT_DOC_LIST

    FROM ZRBKP_22 AS A

    INNER JOIN ZRSEG_22 AS B

       ON A~BELNR = B~BELNR

      AND A~GJAHR = B~GJAHR

    WHERE B~EBELN = P_EBELN2

      AND B~WERKS = P_WERKS2

      AND A~RBSTAT = '5'    " ### ##

      AND A~BLART  = 'RE'   " ##(RE)# ##

    ORDER BY A~BUDAT DESCENDING A~BELNR DESCENDING. " <--- [##] ##(,) ###!



  " #### ### # ## # ## ## ##

  IF GT_DOC_LIST IS NOT INITIAL.

    PERFORM GET_DETAIL_DATA USING 1.

  ELSE.

    CLEAR: GS_RBKP, GT_ITEM.

    IF GC_GRID_200 IS NOT INITIAL.

        CALL METHOD GC_GRID_200->REFRESH_TABLE_DISPLAY.

    ENDIF.

    MESSAGE '### ## ### ####.' TYPE 'S'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*& Form GET_DETAIL_DATA (## ##: ##+###)

*&---------------------------------------------------------------------*




FORM GET_DETAIL_DATA USING P_INDEX.



DATA: LS_DOC LIKE LINE OF GT_DOC_LIST.



  READ TABLE GT_DOC_LIST INTO LS_DOC INDEX P_INDEX.

  CHECK SY-SUBRC = 0.



  " 1. ## ## ###

  CLEAR GS_RBKP.

  SELECT SINGLE * INTO CORRESPONDING FIELDS OF GS_RBKP

    FROM ZRBKP_22

    WHERE BELNR = LS_DOC-BELNR

      AND GJAHR = LS_DOC-GJAHR.



  " 2. ### ## ### (### # ##)

  REFRESH GT_ITEM.



  SELECT A~BELNR A~GJAHR A~BUZEI A~EBELN A~EBELP

         A~MATNR A~TXZ01 A~WERKS A~WRBTR A~MENGE

         A~BSTME AS MEINS A~MWSKZ A~WMWST A~SHKZG A~LOEKZ A~STPRS

         A~SGTXT

         B~WAERS B~LIFNR

    INTO CORRESPONDING FIELDS OF TABLE GT_ITEM

    FROM ZRSEG_22 AS A

    INNER JOIN ZRBKP_22 AS B

       ON A~BELNR = B~BELNR

      AND A~GJAHR = B~GJAHR

    WHERE A~BELNR = LS_DOC-BELNR

      AND A~GJAHR = LS_DOC-GJAHR.

     " AND A~LOEKZ <> 'X'.  " # ###(X) ### ## ALV## # ##



  " ## ## (### + ##)

  LOOP AT GT_ITEM INTO GS_ITEM.

    GS_ITEM-DMBTR = GS_ITEM-WRBTR + GS_ITEM-WMWST.

    MODIFY GT_ITEM FROM GS_ITEM.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*& Form SET_ALV_200 (## 2# ## # ##)

*&---------------------------------------------------------------------*




FORM SET_ALV_200.



  " 1. [##] ## ALV ##

  IF GC_DOCK_LEFT IS INITIAL.

    CREATE OBJECT GC_DOCK_LEFT

      EXPORTING

        SIDE      = CL_GUI_DOCKING_CONTAINER=>DOCK_AT_LEFT

        EXTENSION = 190. " ## 190



    CREATE OBJECT GC_GRID_LEFT

      EXPORTING I_PARENT = GC_DOCK_LEFT.



    " ### ### ##

    IF GO_EVENT IS INITIAL.

      CREATE OBJECT GO_EVENT.

    ENDIF.

    SET HANDLER GO_EVENT->HANDLE_DOUBLE_CLICK FOR GC_GRID_LEFT.



    " ## ## #### ##

    PERFORM BUILD_FCAT_LEFT.



    DATA: LS_LAY_L TYPE LVC_S_LAYO.

    LS_LAY_L-CWIDTH_OPT = 'X'.

    LS_LAY_L-SEL_MODE   = 'A'.

    LS_LAY_L-NO_TOOLBAR = 'X'. " ## ##



    CALL METHOD GC_GRID_LEFT->SET_TABLE_FOR_FIRST_DISPLAY

      EXPORTING IS_LAYOUT       = LS_LAY_L

      CHANGING  IT_OUTTAB       = GT_DOC_LIST

                IT_FIELDCATALOG = GT_FIELDCAT.

  ELSE.

    CALL METHOD GC_GRID_LEFT->REFRESH_TABLE_DISPLAY.

  ENDIF.



  " 2. [##] ## ALV ## (## ## GC_DOCKING_200 ##)

  IF GC_DOCKING_200 IS INITIAL.

    CREATE OBJECT GC_DOCKING_200

      EXPORTING

        SIDE      = CL_GUI_DOCKING_CONTAINER=>DOCK_AT_BOTTOM

        EXTENSION = 200. " ## 200



    CREATE OBJECT GC_GRID_200

      EXPORTING I_PARENT = GC_DOCKING_200.



    PERFORM FIELD_CATALOG_200.

    PERFORM ALV_LAYOUT_200.



    CALL METHOD GC_GRID_200->SET_TABLE_FOR_FIRST_DISPLAY

      EXPORTING IS_LAYOUT       = GS_LAYOUT

      CHANGING  IT_OUTTAB       = GT_ITEM

                IT_FIELDCATALOG = GT_FIELDCAT.

  ELSE.

    " ### ####

    DATA: LS_STABLE TYPE LVC_S_STBL.

    LS_STABLE-ROW = 'X'.

    LS_STABLE-COL = 'X'.

    CALL METHOD GC_GRID_200->REFRESH_TABLE_DISPLAY

      EXPORTING IS_STABLE = LS_STABLE.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*& Form BUILD_FCAT_LEFT

*&---------------------------------------------------------------------*




FORM BUILD_FCAT_LEFT.

  CLEAR: GT_FIELDCAT, GS_FIELDCAT.



  GS_FIELDCAT-FIELDNAME = 'BELNR'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-KEY       = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'BUDAT'.

  GS_FIELDCAT-COLTEXT   = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*& Form REFRESH_ITEMS (## ### ##)

*&---------------------------------------------------------------------*




FORM REFRESH_ITEMS.

" ## ## ## ##(GS_RBKP) ## ###

  REFRESH GT_ITEM.



  SELECT A~BELNR A~GJAHR A~BUZEI A~EBELN A~EBELP

         A~MATNR A~TXZ01 A~WERKS A~WRBTR A~MENGE

         A~BSTME AS MEINS A~MWSKZ A~WMWST A~SHKZG A~LOEKZ A~STPRS

         A~SGTXT

         B~WAERS B~LIFNR

    INTO CORRESPONDING FIELDS OF TABLE GT_ITEM

    FROM ZRSEG_22 AS A

    INNER JOIN ZRBKP_22 AS B

       ON A~BELNR = B~BELNR

      AND A~GJAHR = B~GJAHR

    WHERE A~BELNR = GS_RBKP-BELNR

      AND A~GJAHR = GS_RBKP-GJAHR

      AND A~LOEKZ <> 'X'.  " # ## ### ## ### -> ###



  " ## ###

  LOOP AT GT_ITEM INTO GS_ITEM.

    GS_ITEM-DMBTR = GS_ITEM-WRBTR + GS_ITEM-WMWST.

    MODIFY GT_ITEM FROM GS_ITEM.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_INVOICE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*

*FORM GET_INVOICE_DATA .

*REFRESH GT_ITEM.

*

*  " [##] LOEKZ ## ## -> S# H ## ##

*  SELECT A~BELNR, A~GJAHR, A~BUZEI, A~EBELN, A~EBELP,

*         A~MATNR, A~TXZ01, A~WERKS, A~WRBTR, A~MENGE,

*         A~BSTME AS MEINS, A~MWSKZ, A~WMWST, B~WAERS,

*         A~SHKZG, A~LOEKZ, A~STPRS, A~SGTXT, B~LIFNR

*    INTO CORRESPONDING FIELDS OF TABLE @GT_ITEM

*    FROM ZRSEG_22 AS A

*    INNER JOIN ZRBKP_22 AS B

*       ON A~BELNR = B~BELNR

*      AND A~GJAHR = B~GJAHR

*    WHERE A~EBELN = @P_EBELN2

*      AND A~WERKS = @P_WERKS2.

*      " AND A~LOEKZ <> 'X'. <--- # ### ###! (H# ### ###)

*

*  " ## ##

*  IF GT_ITEM[] IS NOT INITIAL.

*    LOOP AT GT_ITEM INTO GS_ITEM.

*      " H(##)# ## ##### #### ## (### ## ### ###)

*      GS_ITEM-DMBTR = GS_ITEM-WRBTR + GS_ITEM-WMWST.

*      MODIFY GT_ITEM FROM GS_ITEM.

*    ENDLOOP.

*  ENDIF.

*ENDFORM.