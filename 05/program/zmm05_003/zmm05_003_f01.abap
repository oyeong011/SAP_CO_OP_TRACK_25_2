
*&---------------------------------------------------------------------*

*&  Include           ZMM05_003_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SCREEN_INIT

*&---------------------------------------------------------------------*




FORM SCREEN_INIT .

  P_DATE = SY-DATUM.

  P_EBELN = 4500000001.

  P_EBELN2 = 4500000001.

  P_WERKS = 1000.

  P_WERKS2 = 1000.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SCREEN_MODIFY

*&---------------------------------------------------------------------*




FORM SCREEN_MODIFY .

  LOOP AT SCREEN.

    "1. ## ## (RB_CR)

    IF RB_CR = 'X'.

      IF SCREEN-GROUP1 = 'DSP'.

        SCREEN-ACTIVE = 0.

        MODIFY SCREEN.

      ENDIF.

      IF SCREEN-GROUP1 = 'CR1'.

        SCREEN-ACTIVE = 1.

        MODIFY SCREEN.

      ENDIF.

    ENDIF.

    "2. ## ## (RB_DSP)

    IF RB_DSP = 'X'.

      IF SCREEN-GROUP1 = 'CR1'.

        SCREEN-ACTIVE = 0.

        MODIFY SCREEN.

      ENDIF.

      IF SCREEN-GROUP1 = 'DSP'.

        SCREEN-ACTIVE = 1.

        MODIFY SCREEN.

      ENDIF.

    ENDIF.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  VALID_PO_INPUT

*&---------------------------------------------------------------------*




FORM VALID_PO_INPUT .

  DATA : LV_EBELN LIKE ZEKKO_05-EBELN,

         LV_WERKS LIKE ZEKPO_05-WERKS,

         LV_BEDAT LIKE ZEKKO_05-BEDAT.



  IF P_EBELN IS INITIAL OR P_WERKS IS INITIAL OR P_DATE IS INITIAL.

    MESSAGE '## ## ######' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  " 1. #### ## ## ## (+ ### ####)

  SELECT SINGLE EBELN BEDAT

    INTO (LV_EBELN, LV_BEDAT)

    FROM ZEKKO_05

    WHERE EBELN = P_EBELN.



  IF SY-SUBRC <> 0.

    MESSAGE '#### ## #######' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  IF P_DATE < LV_BEDAT.

    MESSAGE '#### #### ##### ### # ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  " 2. ### ##

  SELECT SINGLE WERKS FROM ZEKPO_05

    INTO LV_WERKS

    WHERE EBELN = P_EBELN

      AND WERKS = P_WERKS.



  IF SY-SUBRC <> 0.

    MESSAGE '## PO# #### ## ######.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_PO_ITEMS

*&---------------------------------------------------------------------*




FORM GET_PO_ITEMS .

  "1. #### ##

  SELECT SINGLE * FROM ZEKKO_05

    INTO CORRESPONDING FIELDS OF GS_PO_HEADER

    WHERE EBELN = P_EBELN.



  "2. #### ###

  SELECT * FROM ZEKPO_05

    INTO CORRESPONDING FIELDS OF TABLE GT_PO_ITEM

    WHERE EBELN = P_EBELN

      AND WERKS = P_WERKS.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  MODIFY_PO_ITEMS

*&---------------------------------------------------------------------*




FORM MODIFY_PO_ITEMS .

  DATA : LV_GR_SUM TYPE ZMSEG_05-MENGE,

         LV_CANCEL_SUM TYPE ZMSEG_05-MENGE.

  REFRESH GT_ITEM.

  CLEAR GS_ITEM.

  LOOP AT GT_PO_ITEM INTO GS_PO_ITEM.

    CLEAR: LV_GR_SUM, LV_CANCEL_SUM.



    " ## ## ### (101#)

    SELECT SUM( MENGE ) INTO LV_GR_SUM

      FROM ZMSEG_05

      WHERE EBELN  = GS_PO_ITEM-EBELN

        AND MATNR  = GS_PO_ITEM-MATNR

        AND ZWERKS = GS_PO_ITEM-WERKS

        AND BWART  = '101'.



    IF SY-SUBRC <> 0 OR LV_GR_SUM IS INITIAL.

      LV_GR_SUM = 0.

    ENDIF.



    " ## ## ## ##!

    GS_PO_ITEM-WEMNG = LV_GR_SUM.  " ## # ## ## 101#



    " 2. ### ### ## ## #### ##

    IF GS_PO_ITEM-WEMNG < GS_PO_ITEM-MENGE.

      " --- ## ---

      GS_ITEM-EBELN = GS_PO_ITEM-EBELN.

      GS_ITEM-EBELP = GS_PO_ITEM-EBELP.

      GS_ITEM-LIFNR = GS_PO_HEADER-LIFNR.

      GS_ITEM-BEDAT = GS_PO_HEADER-BEDAT.

      GS_ITEM-MATNR = GS_PO_ITEM-MATNR.

      GS_ITEM-MAKTX = GS_PO_ITEM-MAKTX.

      GS_ITEM-MENGE = GS_PO_ITEM-MENGE.

      GS_ITEM-MEINS = GS_PO_ITEM-MEINS.

      GS_ITEM-STPRS = GS_PO_ITEM-STPRS.

      GS_ITEM-WAERS = GS_PO_HEADER-WAERS.

      GS_ITEM-PRDAT = GS_PO_ITEM-PRDAT.

      GS_ITEM-WERKS = GS_PO_ITEM-WERKS.

      GS_ITEM-LGORT = GS_PO_ITEM-LGORT.



      " --- ## ## ---

      GS_ITEM-WEMNG    = GS_PO_ITEM-WEMNG.

      GS_ITEM-OPEN_QTY = GS_PO_ITEM-MENGE - GS_PO_ITEM-WEMNG.

      GS_ITEM-GR_QTY   = 0.



      APPEND GS_ITEM TO GT_ITEM.

      CLEAR GS_ITEM.

    ENDIF.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  MAKE_FIELDCATALOG_101

*&---------------------------------------------------------------------*




FORM MAKE_FIELDCATALOG_101 .

  CLEAR : GS_FC, GT_FC.



  " 1. CHECK (## ##)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 1.

  GS_FC-FIELDNAME = 'CHECK'.

  GS_FC-COLTEXT   = '##'.

  GS_FC-CHECKBOX  = 'X'.

  GS_FC-EDIT      = 'X'.

  APPEND GS_FC TO GT_FC.



  " 2. EBELN (######)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 2.

  GS_FC-FIELDNAME = 'EBELN'.

  GS_FC-COLTEXT   = '######'.

  APPEND GS_FC TO GT_FC.



  " 3. EBELP (##)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 3.

  GS_FC-FIELDNAME = 'EBELP'.

  GS_FC-COLTEXT   = '##'.

  APPEND GS_FC TO GT_FC.



  " 4. LIFNR (###)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 4.

  GS_FC-FIELDNAME = 'LIFNR'.

  GS_FC-COLTEXT   = '###'.

  APPEND GS_FC TO GT_FC.



  " 5. BEDAT (###)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 5.

  GS_FC-FIELDNAME = 'BEDAT'.

  GS_FC-COLTEXT   = '###'.

  APPEND GS_FC TO GT_FC.



  " 6. MATNR (####)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 6.

  GS_FC-FIELDNAME = 'MATNR'.

  GS_FC-COLTEXT   = '####'.

  APPEND GS_FC TO GT_FC.



  " 7. MAKTX (###)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 7.

  GS_FC-FIELDNAME = 'MAKTX'.

  GS_FC-COLTEXT   = '###'.

  APPEND GS_FC TO GT_FC.



  " 8. MENGE (## ##)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 8.

  GS_FC-FIELDNAME = 'MENGE'.

  GS_FC-COLTEXT   = '####'.

  GS_FC-QFIELDNAME = 'MEINS'.

  GS_FC-REF_TABLE = 'ZEKPO_05'.

  GS_FC-REF_FIELD = 'MENGE'.

  APPEND GS_FC TO GT_FC.



  " 9. WEMNG (#####)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 9.

  GS_FC-FIELDNAME = 'WEMNG'.

  GS_FC-COLTEXT   = '#####'.

  GS_FC-QFIELDNAME = 'MEINS'.

  GS_FC-REF_TABLE = 'ZEKPO_05'.

  GS_FC-REF_FIELD = 'MENGE'.

  APPEND GS_FC TO GT_FC.



  " 10. OPEN_QTY (### ##)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 10.

  GS_FC-FIELDNAME = 'OPEN_QTY'.

  GS_FC-COLTEXT   = '###(##)'.

  GS_FC-QFIELDNAME = 'MEINS'.

  GS_FC-REF_TABLE = 'ZEKPO_05'.

  GS_FC-REF_FIELD = 'MENGE'.

  GS_FC-EMPHASIZE = 'C500'.

  APPEND GS_FC TO GT_FC.



  " 11. GR_QTY (## ## ##)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 11.

  GS_FC-FIELDNAME = 'GR_QTY'.

  GS_FC-COLTEXT   = '## ##(##)'.

  GS_FC-QFIELDNAME = 'MEINS'.

  GS_FC-REF_TABLE = 'ZEKPO_05'.

  GS_FC-REF_FIELD = 'MENGE'.

  GS_FC-EDIT      = 'X'.

  GS_FC-EMPHASIZE = 'C300'.

  APPEND GS_FC TO GT_FC.



  " 12. MEINS (##)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 12.

  GS_FC-FIELDNAME = 'MEINS'.

  GS_FC-COLTEXT   = '##'.

  APPEND GS_FC TO GT_FC.



  " 13. STPRS (##)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 13.

  GS_FC-FIELDNAME = 'STPRS'.

  GS_FC-COLTEXT   = '##'.




*  GS_FC-REF_TABLE = 'ZEKPO_05'.

*  GS_FC-REF_FIELD = 'STPRS'.

*  GS_FC-CFIELDNAME = 'WAERS'.

*  GS_FC-NO_CONVEXT = 'X'.




  APPEND GS_FC TO GT_FC.



  " 14. WAERS (##)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 14.

  GS_FC-FIELDNAME = 'WAERS'.

  GS_FC-COLTEXT   = '##'.

  APPEND GS_FC TO GT_FC.



  " 15. PRDAT (###)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 15.

  GS_FC-FIELDNAME = 'PRDAT'.

  GS_FC-COLTEXT   = '###'.

  APPEND GS_FC TO GT_FC.



  " 16. WERKS (###)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 16.

  GS_FC-FIELDNAME = 'WERKS'.

  GS_FC-COLTEXT   = '###'.

  APPEND GS_FC TO GT_FC.



  " 17. LGORT (####)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 17.

  GS_FC-FIELDNAME = 'LGORT'.

  GS_FC-COLTEXT   = '####'.

  APPEND GS_FC TO GT_FC.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  FILL_HEADER

*&---------------------------------------------------------------------*




FORM FILL_HEADER .

  " 1. #### ## ##

  PERFORM GET_NEXT_MBLNR CHANGING GS_MKPF-MBLNR.



  " 2. ## ## ##

  GS_MKPF-BLART = 'WE'.                " #### (##)

  GS_MKPF-BLDAT = GS_PO_HEADER-BEDAT.  " ###

  GS_MKPF-BUDAT = P_DATE.              " ###

  GS_MKPF-MJAHR = P_DATE(4).           " ####



  " ## ###

  GS_MKPF-EBELN = P_EBELN.

  GS_MKPF-WERKS = P_WERKS.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_NEXT_MBLNR

*&---------------------------------------------------------------------*




FORM GET_NEXT_MBLNR  CHANGING P_MBLNR.

  DATA : LV_MAX LIKE ZMKPF_05-MBLNR.



  SELECT MAX( MBLNR ) INTO LV_MAX FROM ZMKPF_05.

  IF LV_MAX IS NOT INITIAL.

    P_MBLNR = LV_MAX + 1.

  ELSE.

    P_MBLNR = '5000000000'.

  ENDIF.

ENDFORM.



FORM SET_LAYOUT .

  CLEAR GS_LAYOUT.



  " [##] ## ###

  GS_LAYOUT-NO_TOOLBAR = 'X'.



  GS_LAYOUT-CWIDTH_OPT = 'X'.  " # ## ## ###

  GS_LAYOUT-ZEBRA      = 'X'.  " #### ### ## ## ##

  GS_LAYOUT-SEL_MODE   = 'D'.  " # ## ## ## (### 'A', 'B', 'C' ### ##)



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*




FORM CLASS_EVENT.

  " 1. ### ### ## ##

  IF GO_EVENT IS INITIAL.

    CREATE OBJECT GO_EVENT.

  ENDIF.



  " 2. 100# ## ALV ### ##

  IF GC_GRID IS BOUND.

    CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

      EXPORTING

        I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_ENTER.



    SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID.

    SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED_FINISHED FOR GC_GRID.

  ENDIF.



  " 3. 200# ## ALV ### ##

  IF GC_GRID_201 IS BOUND.

    SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID_201.

  ENDIF.



  " 4. 200# ## ## ### ##

  IF GO_TREE IS BOUND.

    SET HANDLER GO_EVENT->HANDLE_NODE_DOUBLE_CLICK FOR GO_TREE.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DATA_CHANGED

*&---------------------------------------------------------------------*




FORM ALV_HANDLER_DATA_CHANGED  USING P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                     P_ONF4

                                     P_ONF4_BEFORE

                                     P_ONF4_AFTER

                                     P_UCOMM.

  DATA : LS_MODI TYPE LVC_S_MODI.



  LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.

    READ TABLE GT_ITEM INTO GS_ITEM INDEX LS_MODI-ROW_ID.



    "1. #### ##

    IF LS_MODI-FIELDNAME = 'CHECK'.

      IF LS_MODI-VALUE = 'X'.

        GS_ITEM-BWART = '101'. "##

      ELSE.

        CLEAR GS_ITEM-BWART.

      ENDIF.

      MODIFY GT_ITEM FROM GS_ITEM INDEX LS_MODI-ROW_ID.

    ENDIF.



    "2. ## ## ## ##

    IF LS_MODI-FIELDNAME = 'GR_QTY'.

      GS_ITEM-GR_QTY = LS_MODI-VALUE.



      " ## ##

      IF GS_ITEM-GR_QTY < 0.

        MESSAGE '## ### ### # ####' TYPE 'I'.

        GS_ITEM-GR_QTY = 0.

        P_DATA_CHANGED->MODIFY_CELL(

          EXPORTING I_ROW_ID = LS_MODI-ROW_ID

                    I_FIELDNAME = 'GR_QTY'

                    I_VALUE = GS_ITEM-GR_QTY ).

      ENDIF.



      " ## ## ##

      IF GS_ITEM-GR_QTY > GS_ITEM-OPEN_QTY.

        MESSAGE '## ## ### ######' TYPE 'I'.

        GS_ITEM-GR_QTY = GS_ITEM-OPEN_QTY.

        P_DATA_CHANGED->MODIFY_CELL(

          EXPORTING I_ROW_ID = LS_MODI-ROW_ID

                    I_FIELDNAME = 'GR_QTY'

                    I_VALUE = GS_ITEM-GR_QTY ).

      ENDIF.



      MODIFY GT_ITEM FROM GS_ITEM INDEX LS_MODI-ROW_ID.

    ENDIF.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_DATA_CHANGED_FINISHED

*&---------------------------------------------------------------------*




FORM ALV_DATA_CHANGED_FINISHED USING P_MODIFIED

                                     P_GOOD_CELLS TYPE LVC_T_MODI.

  PERFORM REFRESH.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*




FORM REFRESH.

  DATA : LS_STABLE TYPE LVC_S_STBL.

  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  IF GC_GRID IS BOUND.

    CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

      EXPORTING IS_STABLE = LS_STABLE.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  BTN_CREATE

*&---------------------------------------------------------------------*




FORM BTN_CREATE .

  DATA : LS_MKPF LIKE ZMKPF_05.

  DATA : LS_MSEG   LIKE ZMSEG_05,

         LV_ZEILE  TYPE N LENGTH 4.

  DATA : LV_CHECKED_CNT TYPE I,

         LV_SAVED_CNT TYPE I.



  IF GC_GRID IS BOUND.

    CALL METHOD GC_GRID->CHECK_CHANGED_DATA.

  ENDIF.

  " ========================================

  " Step 1: ### ## ## ##

  " ========================================

  CLEAR LV_CHECKED_CNT.

  LOOP AT GT_ITEM INTO GS_ITEM WHERE CHECK = 'X'.

    ADD 1 TO LV_CHECKED_CNT.

  ENDLOOP.



  IF LV_CHECKED_CNT = 0.

    MESSAGE '### ### ######' TYPE 'E'.

    EXIT.

  ENDIF.



  " ========================================

  " Step 2: ## ##

  " ========================================

  LOOP AT GT_ITEM INTO GS_ITEM WHERE CHECK = 'X'.

    IF GS_ITEM-GR_QTY IS INITIAL OR GS_ITEM-GR_QTY <= 0.

      MESSAGE '## ### ###### (##: ' && GS_ITEM-EBELP && ')' TYPE 'E'.

      EXIT.

    ENDIF.



    IF GS_ITEM-GR_QTY > GS_ITEM-OPEN_QTY.

      MESSAGE '## ### ### ### ###### (##: ' && GS_ITEM-EBELP && ')' TYPE 'E'.

      EXIT.

    ENDIF.

  ENDLOOP.



  " ========================================

  " Step 3: ## ##

  " ========================================

  MOVE-CORRESPONDING GS_MKPF TO LS_MKPF.

  INSERT ZMKPF_05 FROM LS_MKPF.

  IF SY-SUBRC <> 0.

    MESSAGE '## ## ## (ZMKPF_05)' TYPE 'E'.

    EXIT.

  ENDIF.



  " ========================================

  " Step 4: ### ##

  " ========================================

  LV_ZEILE = 0.

  LV_SAVED_CNT = 0.



  LOOP AT GT_ITEM INTO GS_ITEM WHERE CHECK = 'X'.

    CLEAR LS_MSEG.



    " #### ##

    ADD 1 TO LV_ZEILE.

    LS_MSEG-ZEILE = LV_ZEILE.



    " #/## # ##

    LS_MSEG-SHKZG = 'S'.

    LS_MSEG-DMBTR = GS_ITEM-GR_QTY * GS_ITEM-STPRS.



    " ## ##

    LS_MSEG-MBLNR  = GS_MKPF-MBLNR.

    LS_MSEG-MJAHR  = GS_MKPF-MJAHR.

    LS_MSEG-BWART  = '101'.

    LS_MSEG-MATNR  = GS_ITEM-MATNR.

    LS_MSEG-ZWERKS = GS_ITEM-WERKS.

    LS_MSEG-ZLGORT = GS_ITEM-LGORT.

    LS_MSEG-LIFNR  = GS_ITEM-LIFNR.

    LS_MSEG-WAERS  = GS_ITEM-WAERS.

    LS_MSEG-MENGE  = GS_ITEM-GR_QTY.

    LS_MSEG-MEINS  = GS_ITEM-MEINS.

    LS_MSEG-EBELN  = GS_ITEM-EBELN.

    LS_MSEG-BUKRS  = GS_PO_HEADER-BUKRS.



    INSERT ZMSEG_05 FROM LS_MSEG.

    IF SY-SUBRC = 0.

      ADD 1 TO LV_SAVED_CNT.

    ELSE.

      ROLLBACK WORK.

      MESSAGE '### ## ## (ZMSEG_05, ##: ' && GS_ITEM-EBELP && ')' TYPE 'E'.

      RETURN.

    ENDIF.

  ENDLOOP.



  " ========================================

  " Step 5: ## ## # ###

  " ========================================

  IF LV_SAVED_CNT > 0.

    COMMIT WORK AND WAIT.

    MESSAGE '## ## ' && GS_MKPF-MBLNR && ' ## #######. (###: ' && LV_SAVED_CNT && '#)' TYPE 'S'.

  ELSE.

    ROLLBACK WORK.

    MESSAGE '### #### ####' TYPE 'E'.

  ENDIF.

ENDFORM.