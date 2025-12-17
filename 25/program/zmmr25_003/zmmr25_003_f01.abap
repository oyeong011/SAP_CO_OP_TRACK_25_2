
*&---------------------------------------------------------------------*

*&  Include           ZMMR25_003_F01

*&---------------------------------------------------------------------*



*&---------------------------------------------------------------------*

*&      Form  SCREEN_INIT

*&---------------------------------------------------------------------*




FORM SCREEN_INIT .

  P_DATE = SY-DATUM.



  " #### ###

  P_EBELN = '4500000001'.

  P_WERKS = '1000'.



  " #### ###

  P_EBELN2 = '4500000001'.

  P_WERKS2 = '1000'.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SCREEN_MODIFY

*&---------------------------------------------------------------------*




FORM SCREEN_MODIFY .

  LOOP AT SCREEN.

    " 1. #### ### (RB_CR)

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



    " 2. #### ### (RB_DSP)

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

*&      Form  VALIDATE_INPUT_DATA

*&---------------------------------------------------------------------*




FORM VALIDATE_INPUT_DATA .

  DATA : LV_EBELN LIKE ZEDT25_ZEKKO-EBELN,

         LV_WERKS LIKE ZEDT25_ZEKPO-WERKS.



  IF P_EBELN IS INITIAL OR P_WERKS IS INITIAL OR P_DATE IS INITIAL.

    CALL FUNCTION 'POPUP_TO_INFORM'

      EXPORTING

        TITEL = '## ##'

        TXT1  = '## #### ## ######.'

        TXT2  = '####, ###, ###### #####.'.

    STOP.

  ENDIF.



  " 1. ##### ##### ##

  SELECT SINGLE EBELN FROM ZEDT25_ZEKKO

    INTO LV_EBELN

    WHERE EBELN = P_EBELN.



  IF SY-SUBRC <> 0.

    CALL FUNCTION 'POPUP_TO_INFORM'

      EXPORTING

        TITEL = '### ##'

        TXT1  = '### ##### #### #### ####.'

        TXT2  = '#### ### ######.'.

    STOP.

  ENDIF.



  " 2. ### ##

  SELECT SINGLE WERKS FROM ZEDT25_ZEKPO

    INTO LV_WERKS

    WHERE EBELN = P_EBELN

      AND WERKS = P_WERKS.



  IF SY-SUBRC <> 0.

    CALL FUNCTION 'POPUP_TO_INFORM'

      EXPORTING

        TITEL = '### ##'

        TXT1  = '## ##### ### ####'

        TXT2  = '#### ####.'.

    STOP.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SELECT_PURCHASE_ORDER_DATA

*&---------------------------------------------------------------------*




FORM SELECT_PURCHASE_ORDER_DATA .

  " 1. #### ## ##

  SELECT SINGLE * FROM ZEDT25_ZEKKO

    INTO CORRESPONDING FIELDS OF GS_PO_HEADER

    WHERE EBELN = P_EBELN.



  " 2. #### ### ##

  SELECT * FROM ZEDT25_ZEKPO

    INTO CORRESPONDING FIELDS OF TABLE GT_PO_ITEM

    WHERE EBELN = P_EBELN

      AND WERKS = P_WERKS.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CALCULATE_OPEN_QUANTITY

*&---------------------------------------------------------------------*




FORM CALCULATE_OPEN_QUANTITY .

  DATA : LV_RECEIPT_SUM TYPE ZEDT25_ZMSEG-MENGE.



  CLEAR GS_DISPLAY.



  " #### #### ## ## ##

  IF GT_PO_ITEM IS INITIAL.

    CALL FUNCTION 'POPUP_TO_INFORM'

      EXPORTING

        TITEL = '### ##'

        TXT1  = '## ##### #### ##'

        TXT2  = '#### #### ####.'.

    STOP.

  ENDIF.



  LOOP AT GT_PO_ITEM INTO GS_PO_ITEM.



    CLEAR: LV_RECEIPT_SUM.



    " ## ### ## ## ## (#### 101#)

    SELECT SUM( MENGE ) INTO LV_RECEIPT_SUM

      FROM ZEDT25_ZMSEG

      WHERE EBELN = GS_PO_ITEM-EBELN

        AND ZEILE = GS_PO_ITEM-EBELP

        AND BWART = '101'.



    " ## ## ## ##

    GS_PO_ITEM-WEMNG = LV_RECEIPT_SUM.



    " ### ### #### ### ### ##

    IF GS_PO_ITEM-WEMNG < GS_PO_ITEM-MENGE.



      " ## ## ##

      GS_DISPLAY-EBELN = GS_PO_ITEM-EBELN.

      GS_DISPLAY-EBELP = GS_PO_ITEM-EBELP.

      GS_DISPLAY-LIFNR = GS_PO_HEADER-LIFNR.

      GS_DISPLAY-BEDAT = GS_PO_HEADER-BEDAT.

      GS_DISPLAY-MATNR = GS_PO_ITEM-MATNR.

      GS_DISPLAY-MAKTX = GS_PO_ITEM-MAKTX.

      GS_DISPLAY-MENGE = GS_PO_ITEM-MENGE.

      GS_DISPLAY-MEINS = GS_PO_ITEM-MEINS.

      GS_DISPLAY-STPRS = GS_PO_ITEM-STPRS.

      GS_DISPLAY-WAERS = GS_PO_HEADER-WAERS.

      GS_DISPLAY-PRDAT = GS_PO_ITEM-PRDAT.

      GS_DISPLAY-WERKS = GS_PO_ITEM-WERKS.

      GS_DISPLAY-LGORT = GS_PO_ITEM-LGORT.



      " ## ## ## ##

      GS_DISPLAY-WEMNG    = GS_PO_ITEM-WEMNG.

      GS_DISPLAY-OPEN_QTY = GS_PO_ITEM-MENGE - GS_PO_ITEM-WEMNG.

      GS_DISPLAY-GR_QTY   = 0.



      APPEND GS_DISPLAY TO GT_DISPLAY.

      CLEAR GS_DISPLAY.

    ENDIF.



  ENDLOOP.



  " ## ### #### ## ## (## ## ##)

  IF GT_DISPLAY IS INITIAL.

    CALL FUNCTION 'POPUP_TO_INFORM'

      EXPORTING

        TITEL = '## ##'

        TXT1  = '## ##### ## ####'

        TXT2  = '## ## #######.'.

    STOP.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  BUILD_FCAT_CREATION

*&---------------------------------------------------------------------*




FORM BUILD_FCAT_CREATION .

  CLEAR : GS_FC, GT_FC.



  " 1. CHECK (## ##)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 1.

  GS_FC-FIELDNAME = 'CHECK'.

  GS_FC-COLTEXT   = '##'.

  GS_FC-CHECKBOX  = 'X'.

  GS_FC-EDIT      = 'X'.

  GS_FC-OUTPUTLEN = 4.

  APPEND GS_FC TO GT_FC.



  " 2. EBELN (####)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 2.

  GS_FC-FIELDNAME = 'EBELN'.

  GS_FC-COLTEXT   = '####'.

  GS_FC-OUTPUTLEN = 8.

  APPEND GS_FC TO GT_FC.



  " 3. EBELP (##)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 3.

  GS_FC-FIELDNAME = 'EBELP'.

  GS_FC-COLTEXT   = '##'.

  GS_FC-OUTPUTLEN = 5.

  APPEND GS_FC TO GT_FC.



  " 4. LIFNR (####)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 4.

  GS_FC-FIELDNAME = 'LIFNR'.

  GS_FC-COLTEXT   = '####'.

  GS_FC-OUTPUTLEN = 10.

  APPEND GS_FC TO GT_FC.



  " 5. BEDAT (####)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 5.

  GS_FC-FIELDNAME = 'BEDAT'.

  GS_FC-COLTEXT   = '####'.

  GS_FC-OUTPUTLEN = 10.

  APPEND GS_FC TO GT_FC.



  " 6. MATNR (####)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 6.

  GS_FC-FIELDNAME = 'MATNR'.

  GS_FC-COLTEXT   = '####'.

  GS_FC-OUTPUTLEN = 12.

  APPEND GS_FC TO GT_FC.



  " 7. MAKTX (###)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 7.

  GS_FC-FIELDNAME = 'MAKTX'.

  GS_FC-COLTEXT   = '###'.

  GS_FC-OUTPUTLEN = 15.

  APPEND GS_FC TO GT_FC.



  " 8. MENGE (## ##)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 8.

  GS_FC-FIELDNAME = 'MENGE'.

  GS_FC-COLTEXT   = '####'.

  GS_FC-QFIELDNAME = 'MEINS'.

  GS_FC-REF_TABLE = 'ZEDT25_ZEKPO'.

  GS_FC-REF_FIELD = 'MENGE'.

  GS_FC-OUTPUTLEN = 8.

  APPEND GS_FC TO GT_FC.



  " 9. WEMNG (####)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 9.

  GS_FC-FIELDNAME = 'WEMNG'.

  GS_FC-COLTEXT   = '####'.

  GS_FC-QFIELDNAME = 'MEINS'.

  GS_FC-REF_TABLE = 'ZEDT25_ZEKPO'.

  GS_FC-REF_FIELD = 'MENGE'.

  GS_FC-OUTPUTLEN = 10.

  APPEND GS_FC TO GT_FC.



  " 10. OPEN_QTY (### ##)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 10.

  GS_FC-FIELDNAME = 'OPEN_QTY'.

  GS_FC-COLTEXT   = '#####'.

  GS_FC-QFIELDNAME = 'MEINS'.

  GS_FC-REF_TABLE = 'ZEDT25_ZEKPO'.

  GS_FC-REF_FIELD = 'MENGE'.

  GS_FC-EMPHASIZE = 'C500'.

  GS_FC-OUTPUTLEN = 10.

  APPEND GS_FC TO GT_FC.



  " 11. GR_QTY (## ## ##) - #### ## ##!

  CLEAR GS_FC.

  GS_FC-COL_POS   = 11.

  GS_FC-FIELDNAME = 'GR_QTY'.

  GS_FC-COLTEXT   = '######'.

  GS_FC-QFIELDNAME = 'MEINS'.

  GS_FC-REF_TABLE = 'ZEDT25_ZEKPO'.

  GS_FC-REF_FIELD = 'MENGE'.

  GS_FC-EDIT      = 'X'.

  GS_FC-EMPHASIZE = 'C300'.

  GS_FC-OUTPUTLEN = 10.

  APPEND GS_FC TO GT_FC.



  " 12. MEINS (##)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 12.

  GS_FC-FIELDNAME = 'MEINS'.

  GS_FC-COLTEXT   = '##'.

  GS_FC-OUTPUTLEN = 3.

  APPEND GS_FC TO GT_FC.



  " 13. STPRS (##)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 13.

  GS_FC-FIELDNAME = 'STPRS'.

  GS_FC-COLTEXT   = '##'.

  GS_FC-CFIELDNAME = 'WAERS'.

  GS_FC-OUTPUTLEN = 13.

  APPEND GS_FC TO GT_FC.



  " 14. WAERS (##)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 14.

  GS_FC-FIELDNAME = 'WAERS'.

  GS_FC-COLTEXT   = '##'.

  GS_FC-OUTPUTLEN = 3.

  APPEND GS_FC TO GT_FC.



  " 15. PRDAT (###)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 15.

  GS_FC-FIELDNAME = 'PRDAT'.

  GS_FC-COLTEXT   = '###'.

  GS_FC-OUTPUTLEN = 10.

  APPEND GS_FC TO GT_FC.



  " 16. WERKS (###)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 16.

  GS_FC-FIELDNAME = 'WERKS'.

  GS_FC-COLTEXT   = '###'.

  GS_FC-OUTPUTLEN = 4.

  APPEND GS_FC TO GT_FC.



  " 17. LGORT (####)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 17.

  GS_FC-FIELDNAME = 'LGORT'.

  GS_FC-COLTEXT   = '####'.

  GS_FC-OUTPUTLEN = 4.

  APPEND GS_FC TO GT_FC.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SET_DOCUMENT_HEADER

*&---------------------------------------------------------------------*




FORM SET_DOCUMENT_HEADER .



  " 1. ## #### ## ##

  PERFORM GENERATE_DOCUMENT_NUMBER CHANGING GS_MKPF-MBLNR.



  " 2. ## ## ###

  GS_MKPF-BLART = 'WE'.                  " #### (##)

  GS_MKPF-BLDAT = GS_PO_HEADER-BEDAT.   " #### (PO# ####)

  GS_MKPF-BUDAT = P_DATE.                " #### (#### ### ##)



  " #####(P_DATE)# # 4##(##)# ##### ##

  GS_MKPF-MJAHR = P_DATE(4).



  " ## ## ##

  GS_MKPF-EBELN = P_EBELN.

  GS_MKPF-WERKS = P_WERKS.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GENERATE_DOCUMENT_NUMBER

*&---------------------------------------------------------------------*




FORM GENERATE_DOCUMENT_NUMBER  CHANGING P_DOCUMENT_NO.

  DATA : LV_MAX_NUMBER LIKE ZEDT25_ZMKPF-MBLNR.



  " ZMKPF ##### ## # #### ##

  SELECT MAX( MBLNR ) INTO LV_MAX_NUMBER FROM ZEDT25_ZMKPF.



  IF LV_MAX_NUMBER IS NOT INITIAL.

    P_DOCUMENT_NO = LV_MAX_NUMBER + 1.

  ELSE.

    P_DOCUMENT_NO = '5000000000'. "###

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  REGISTER_ALV_EVENTS

*&---------------------------------------------------------------------*




FORM REGISTER_ALV_EVENTS.

  " 1. ### ### ## ##

  IF GO_EVENT IS INITIAL.

    CREATE OBJECT GO_EVENT.

  ENDIF.



  " 2. 100# ## ALV ### ##

  IF GC_GRID IS BOUND.

    CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

      EXPORTING

        I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.



    SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID.

    SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED_FINISHED FOR GC_GRID.

  ENDIF.



  " 3. 200# ## ALV ### ##

  IF GC_GRID_201 IS BOUND.

    SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID_201.

  ENDIF.



ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  HANDLE_DATA_CHANGE_EVENT

*&---------------------------------------------------------------------*




FORM HANDLE_DATA_CHANGE_EVENT  USING P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                     P_ONF4

                                     P_ONF4_BEFORE

                                     P_ONF4_AFTER

                                     P_UCOMM.

  DATA : LS_MODIFIED TYPE LVC_S_MODI.



  LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODIFIED.

    READ TABLE GT_DISPLAY INTO GS_DISPLAY INDEX LS_MODIFIED-ROW_ID.



    " 1. #### ###

    IF LS_MODIFIED-FIELDNAME = 'CHECK'.

      IF LS_MODIFIED-VALUE = 'X'.

        GS_DISPLAY-BWART = '101'. "##

      ELSE.

        CLEAR GS_DISPLAY-BWART.

      ENDIF.

      MODIFY GT_DISPLAY FROM GS_DISPLAY INDEX LS_MODIFIED-ROW_ID.

    ENDIF.



    " 2. ## ## ## ###

    IF LS_MODIFIED-FIELDNAME = 'GR_QTY'.

      GS_DISPLAY-GR_QTY = LS_MODIFIED-VALUE.



      " ### #### ### ## ###

      IF GS_DISPLAY-GR_QTY > GS_DISPLAY-OPEN_QTY.

        CALL FUNCTION 'POPUP_TO_INFORM'

          EXPORTING

            TITEL = '## ##'

            TXT1  = '### ## ###'

            TXT2  = '### ### ######.'.



        GS_DISPLAY-GR_QTY = GS_DISPLAY-OPEN_QTY.



        P_DATA_CHANGED->MODIFY_CELL(

          EXPORTING I_ROW_ID = LS_MODIFIED-ROW_ID

                    I_FIELDNAME = 'GR_QTY'

                    I_VALUE = GS_DISPLAY-GR_QTY ).

      ENDIF.

      MODIFY GT_DISPLAY FROM GS_DISPLAY INDEX LS_MODIFIED-ROW_ID.

    ENDIF.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  DATA_CHANGE_COMPLETE

*&---------------------------------------------------------------------*




FORM DATA_CHANGE_COMPLETE USING P_MODIFIED

                                     P_GOOD_CELLS TYPE LVC_T_MODI.

  " ### ## ## # ## ##

  PERFORM REFRESH_GRID_DISPLAY.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  REFRESH_GRID_DISPLAY

*&---------------------------------------------------------------------*




FORM REFRESH_GRID_DISPLAY.

  DATA : LS_STABLE TYPE LVC_S_STBL.

  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  IF GC_GRID IS BOUND.

    CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

      EXPORTING IS_STABLE = LS_STABLE.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SAVE_GOODS_RECEIPT

*&---------------------------------------------------------------------*




FORM SAVE_GOODS_RECEIPT .

  DATA : LS_HEADER_DB LIKE ZEDT25_ZMKPF.

  DATA : LV_SELECTED_COUNT TYPE I.



  " 0. ### ### ## ##

  CLEAR LV_SELECTED_COUNT.

  LOOP AT GT_DISPLAY INTO GS_DISPLAY WHERE CHECK = 'X'.

    ADD 1 TO LV_SELECTED_COUNT.

  ENDLOOP.



  IF LV_SELECTED_COUNT = 0.

    CALL FUNCTION 'POPUP_TO_INFORM'

      EXPORTING

        TITEL = '## ##'

        TXT1  = '## ### #### ######.'

        TXT2  = '##### ## # #####.'.

    RETURN.

  ENDIF.



  " 1. ## ## ## ## (ZMKPF)

  MOVE-CORRESPONDING GS_MKPF TO LS_HEADER_DB.



  INSERT ZEDT25_ZMKPF FROM LS_HEADER_DB.

  IF SY-SUBRC <> 0.

    CALL FUNCTION 'POPUP_TO_INFORM'

      EXPORTING

        TITEL = '## ##'

        TXT1  = '## ## ## ## # ### ######.'

        TXT2  = '### ##### #####.'.

    RETURN.

  ENDIF.



  " 2. ## ## ### ## (ZMSEG)

  DATA : LS_DETAIL_DB LIKE ZEDT25_ZMSEG,

         LV_LINE_NUM  TYPE N LENGTH 4.



  LV_LINE_NUM = 0.



  LOOP AT GT_DISPLAY INTO GS_DISPLAY.

    IF GS_DISPLAY-CHECK <> 'X'.

      CONTINUE.

    ENDIF.



    CLEAR LS_DETAIL_DB.



    " ##(##) ##

    ADD 1 TO LV_LINE_NUM.

    LS_DETAIL_DB-ZEILE = LV_LINE_NUM.



    " #/# # ## ##

    LS_DETAIL_DB-SHKZG = 'S'.

    LS_DETAIL_DB-DMBTR = GS_DISPLAY-GR_QTY * GS_DISPLAY-STPRS.



    " ## # ### ##

    LS_DETAIL_DB-MBLNR  = GS_MKPF-MBLNR.

    LS_DETAIL_DB-MJAHR  = GS_MKPF-MJAHR.

    LS_DETAIL_DB-BWART  = '101'.

    LS_DETAIL_DB-MATNR  = GS_DISPLAY-MATNR.

    LS_DETAIL_DB-ZWERKS = GS_DISPLAY-WERKS.

    LS_DETAIL_DB-ZLGORT = GS_DISPLAY-LGORT.

    LS_DETAIL_DB-LIFNR  = GS_DISPLAY-LIFNR.

    LS_DETAIL_DB-WAERS  = GS_DISPLAY-WAERS.

    LS_DETAIL_DB-MENGE  = GS_DISPLAY-GR_QTY.

    LS_DETAIL_DB-MEINS  = GS_DISPLAY-MEINS.

    LS_DETAIL_DB-EBELN  = GS_DISPLAY-EBELN.

    LS_DETAIL_DB-BUKRS  = GS_PO_HEADER-BUKRS.



    INSERT ZEDT25_ZMSEG FROM LS_DETAIL_DB.



    IF SY-SUBRC <> 0.

      ROLLBACK WORK.

      CALL FUNCTION 'POPUP_TO_INFORM'

        EXPORTING

          TITEL = '## ##'

          TXT1  = '## ## ### ## # ### ######.'

          TXT2  = '## ##### #######.'.

      RETURN.

    ENDIF.

  ENDLOOP.



  " 3. ## ##

  COMMIT WORK AND WAIT.



  " 4. ## ## ###

  CALL FUNCTION 'POPUP_TO_INFORM'

    EXPORTING

      TITEL = '## ##'

      TXT1  = '## ### ##### #######.'

      TXT2  = '## ### #######.'.



ENDFORM.




*&---------------------------------------------------------------------*

*&  Include           ZMMR25_003_F02

*&---------------------------------------------------------------------*



*&---------------------------------------------------------------------*

*&      Form  VALIDATE_DISPLAY_INPUT

*&---------------------------------------------------------------------*




FORM VALIDATE_DISPLAY_INPUT .

  IF P_EBELN2 IS INITIAL OR P_WERKS2 IS INITIAL.

    CALL FUNCTION 'POPUP_TO_INFORM'

      EXPORTING

        TITEL = '## ##'

        TXT1  = '##### #### ######.'

        TXT2  = '# ## ## ## ######.'.

    STOP.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SELECT_RECEIPT_DATA

*&---------------------------------------------------------------------*




FORM SELECT_RECEIPT_DATA .

  CLEAR : GS_MKPF, GS_MSEG, GT_MSEG.

  CLEAR : GS_PO_HEADER.



  " 1. PO ## ## #### (## ###)

  SELECT SINGLE * FROM ZEDT25_ZEKKO

    INTO CORRESPONDING FIELDS OF GS_PO_HEADER

    WHERE EBELN = P_EBELN2.



  " ### ## ## ##

  GS_PO_HEADER-WERKS = P_WERKS2.



  " 2. PO# ## ## ## ### ## (## ## ##, ## # ##)

  SELECT * FROM ZEDT25_ZMSEG

    INTO CORRESPONDING FIELDS OF TABLE GT_MSEG

    WHERE EBELN = P_EBELN2

      AND ZWERKS = P_WERKS2

      AND BWART = '101'.



  " 3. # #### ## ## ## ## (###, ####, ## #)

  DATA : LS_PO_ITEM TYPE ZEDT25_ZEKPO,

         LS_MKPF_LOC TYPE ZEDT25_ZMKPF.



  LOOP AT GT_MSEG INTO GS_MSEG.



    " A. ####(BLDAT), ####(BUDAT), ####(BLART) #### (## ##### ##)

    SELECT SINGLE * FROM ZEDT25_ZMKPF INTO LS_MKPF_LOC

      WHERE MBLNR = GS_MSEG-MBLNR.

    IF SY-SUBRC = 0.

      GS_MSEG-BLDAT = LS_MKPF_LOC-BLDAT.

      GS_MSEG-BUDAT = LS_MKPF_LOC-BUDAT.

      GS_MSEG-BLART = LS_MKPF_LOC-BLART.

    ENDIF.



    " B. ###(MAKTX), PO##(PO_MENGE), ##(EBELP) ####

    SELECT SINGLE * FROM ZEDT25_ZEKPO INTO LS_PO_ITEM

      WHERE EBELN = GS_MSEG-EBELN

        AND MATNR = GS_MSEG-MATNR

        AND WERKS = GS_MSEG-ZWERKS.



    IF SY-SUBRC = 0.

      GS_MSEG-MAKTX    = LS_PO_ITEM-MAKTX.

      GS_MSEG-PO_MENGE = LS_PO_ITEM-MENGE.

      GS_MSEG-EBELP    = LS_PO_ITEM-EBELP.

    ENDIF.



    " C. ## ### (##/##)

    IF GS_MSEG-BWART = '102'.

      GS_MSEG-STATUS_TXT = '##'.

    ELSE.

      GS_MSEG-STATUS_TXT = '##'.

    ENDIF.



    MODIFY GT_MSEG FROM GS_MSEG.

  ENDLOOP.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  PREPARE_DISPLAY_DATA

*&---------------------------------------------------------------------*




FORM PREPARE_DISPLAY_DATA .

  " ## ## ### ##

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CANCEL_GOODS_RECEIPT

*&---------------------------------------------------------------------*




FORM CANCEL_GOODS_RECEIPT .

  DATA : LS_ROW TYPE LVC_S_ROW.

  DATA : LV_CHECKED_COUNT TYPE I.

  DATA : LV_ANSWER TYPE C.



  " #### ### ###### ##

  IF GC_GRID_201 IS BOUND.

    CALL METHOD GC_GRID_201->CHECK_CHANGED_DATA.

  ENDIF.



  " 1. ### ## ## ##

  CLEAR LV_CHECKED_COUNT.

  LOOP AT GT_MSEG INTO GS_MSEG WHERE CHECK = 'X'.

    ADD 1 TO LV_CHECKED_COUNT.

  ENDLOOP.



  " #### ### ### ### ##

  IF LV_CHECKED_COUNT = 0.

    CALL FUNCTION 'POPUP_TO_INFORM'

      EXPORTING

        TITEL = '## ##'

        TXT1  = '## ### #### ######.'

        TXT2  = '##### ## # ## ### ####.'.

    RETURN.

  ENDIF.



  " 2. ## ##

  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      TITLEBAR      = '## ## ##'

      TEXT_QUESTION = '### #### ## ########?'

      TEXT_BUTTON_1 = '#'

      TEXT_BUTTON_2 = '###'

    IMPORTING

      ANSWER        = LV_ANSWER.



  IF LV_ANSWER <> '1'.

    RETURN.

  ENDIF.



  " 3. ## ## (#### ##)

  DATA : LV_SUCCESS_FLAG TYPE C.



  LOOP AT GT_MSEG INTO GS_MSEG WHERE CHECK = 'X'.



    " ## ### ## ####

    IF GS_MSEG-BWART = '102'.

      CONTINUE.

    ENDIF.



    " DB ####: ####(BWART)# 102# ##

    UPDATE ZEDT25_ZMSEG

      SET BWART = '102'

      WHERE MBLNR = GS_MSEG-MBLNR

        AND MJAHR = GS_MSEG-MJAHR

        AND ZEILE = GS_MSEG-ZEILE.



    IF SY-SUBRC = 0.

       " ## #### ##

       GS_MSEG-BWART = '102'.

       GS_MSEG-STATUS_TXT = '##'.

       GS_MSEG-CHECK = ''.

       MODIFY GT_MSEG FROM GS_MSEG.

       LV_SUCCESS_FLAG = 'X'.

    ENDIF.

  ENDLOOP.



  " 4. ## ## # ## ##

  IF LV_SUCCESS_FLAG = 'X'.

    COMMIT WORK.



    CALL FUNCTION 'POPUP_TO_INFORM'

      EXPORTING

        TITEL = '## ##'

        TXT1  = '### #### ## #######.'

        TXT2  = '## ### #######.'.



    PERFORM REFRESH_DETAIL_GRID.

  ELSE.

    CALL FUNCTION 'POPUP_TO_INFORM'

      EXPORTING

        TITEL = '## ##'

        TXT1  = '## ### #### ###'

        TXT2  = '## # ### ######.'.

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  BUILD_FCAT_DISPLAY

*&---------------------------------------------------------------------*




FORM BUILD_FCAT_DISPLAY .

  CLEAR : GS_FC, GT_FC.



  " 1. ## (####)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 1.

  GS_FC-FIELDNAME = 'CHECK'.

  GS_FC-COLTEXT   = '##'.

  GS_FC-CHECKBOX  = 'X'.

  GS_FC-EDIT      = 'X'.

  APPEND GS_FC TO GT_FC.



  " 2. ######

  CLEAR GS_FC.

  GS_FC-COL_POS   = 2.

  GS_FC-FIELDNAME = 'MBLNR'.

  GS_FC-COLTEXT   = '######'.

  GS_FC-OUTPUTLEN = 12.

  APPEND GS_FC TO GT_FC.



  " 3. ####

  CLEAR GS_FC.

  GS_FC-COL_POS   = 3.

  GS_FC-FIELDNAME = 'MJAHR'.

  GS_FC-COLTEXT   = '####'.

  GS_FC-OUTPUTLEN = 4.

  APPEND GS_FC TO GT_FC.



  " 4. ####

  CLEAR GS_FC.

  GS_FC-COL_POS   = 4.

  GS_FC-FIELDNAME = 'BLART'.

  GS_FC-COLTEXT   = '####'.

  GS_FC-OUTPUTLEN = 4.

  APPEND GS_FC TO GT_FC.






*  " 5. ####

*  CLEAR GS_FC.

*  GS_FC-COL_POS   = 5.

*  GS_FC-FIELDNAME = 'BLDAT'.

*  GS_FC-COLTEXT   = '####'.

*  GS_FC-EMPHASIZE = 'C500'.

*  GS_FC-OUTPUTLEN = 10.

*  APPEND GS_FC TO GT_FC.






  " 6. ###

  CLEAR GS_FC.

  GS_FC-COL_POS   = 6.

  GS_FC-FIELDNAME = 'BUDAT'.

  GS_FC-COLTEXT   = '###'.

  GS_FC-EMPHASIZE = 'C500'.

  GS_FC-OUTPUTLEN = 10.

  APPEND GS_FC TO GT_FC.



  " 7. ##

  CLEAR GS_FC.

  GS_FC-COL_POS   = 7.

  GS_FC-FIELDNAME = 'ZEILE'.

  GS_FC-COLTEXT   = '##'.

  GS_FC-OUTPUTLEN = 4.

  APPEND GS_FC TO GT_FC.



  " 8. ####

  CLEAR GS_FC.

  GS_FC-COL_POS   = 8.

  GS_FC-FIELDNAME = 'MATNR'.

  GS_FC-COLTEXT   = '####'.

  GS_FC-OUTPUTLEN = 12.

  APPEND GS_FC TO GT_FC.



  " 9. ###

  CLEAR GS_FC.

  GS_FC-COL_POS   = 9.

  GS_FC-FIELDNAME = 'MAKTX'.

  GS_FC-COLTEXT   = '###'.

  GS_FC-OUTPUTLEN = 15.

  APPEND GS_FC TO GT_FC.



  " 10. ###

  CLEAR GS_FC.

  GS_FC-COL_POS   = 10.

  GS_FC-FIELDNAME = 'LIFNR'.

  GS_FC-COLTEXT   = '###'.

  GS_FC-OUTPUTLEN = 10.

  APPEND GS_FC TO GT_FC.



  " 11. ###

  CLEAR GS_FC.

  GS_FC-COL_POS   = 11.

  GS_FC-FIELDNAME = 'ZWERKS'.

  GS_FC-COLTEXT   = '###'.

  GS_FC-OUTPUTLEN = 4.

  APPEND GS_FC TO GT_FC.



  " 12. ####

  CLEAR GS_FC.

  GS_FC-COL_POS   = 12.

  GS_FC-FIELDNAME = 'ZLGORT'.

  GS_FC-COLTEXT   = '####'.

  GS_FC-OUTPUTLEN = 4.

  APPEND GS_FC TO GT_FC.



  " 13. ######

  CLEAR GS_FC.

  GS_FC-COL_POS   = 13.

  GS_FC-FIELDNAME = 'EBELN'.

  GS_FC-COLTEXT   = '######'.

  GS_FC-OUTPUTLEN = 8.

  APPEND GS_FC TO GT_FC.



  " 14. PO##

  CLEAR GS_FC.

  GS_FC-COL_POS   = 14.

  GS_FC-FIELDNAME = 'EBELP'.

  GS_FC-COLTEXT   = 'PO##'.

  GS_FC-OUTPUTLEN = 5.

  APPEND GS_FC TO GT_FC.



  " 15. PO##

  CLEAR GS_FC.

  GS_FC-COL_POS   = 15.

  GS_FC-FIELDNAME = 'PO_MENGE'.

  GS_FC-COLTEXT   = 'PO##'.

  GS_FC-QFIELDNAME = 'MEINS'.

  GS_FC-REF_TABLE  = 'ZEDT25_ZEKPO'.

  GS_FC-REF_FIELD  = 'MENGE'.

  GS_FC-OUTPUTLEN = 8.

  APPEND GS_FC TO GT_FC.



  " 16. ##

  CLEAR GS_FC.

  GS_FC-COL_POS   = 16.

  GS_FC-FIELDNAME = 'MENGE'.

  GS_FC-COLTEXT   = '##'.

  GS_FC-QFIELDNAME = 'MEINS'.

  GS_FC-REF_TABLE  = 'ZEDT25_ZEKPO'.

  GS_FC-REF_FIELD  = 'MENGE'.

  GS_FC-OUTPUTLEN = 10.

  APPEND GS_FC TO GT_FC.



  " 17. ##

  CLEAR GS_FC.

  GS_FC-COL_POS   = 17.

  GS_FC-FIELDNAME = 'MEINS'.

  GS_FC-COLTEXT   = '##'.

  GS_FC-OUTPUTLEN = 3.

  APPEND GS_FC TO GT_FC.



  " 18. ##

  CLEAR GS_FC.

  GS_FC-COL_POS   = 18.

  GS_FC-FIELDNAME = 'WAERS'.

  GS_FC-COLTEXT   = '##'.

  GS_FC-OUTPUTLEN = 3.

  APPEND GS_FC TO GT_FC.



  " 19. ##

  CLEAR GS_FC.

  GS_FC-COL_POS   = 19.

  GS_FC-FIELDNAME = 'STATUS_TXT'.

  GS_FC-COLTEXT   = '##'.

  GS_FC-OUTPUTLEN = 6.

  APPEND GS_FC TO GT_FC.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  REFRESH_DETAIL_GRID

*&---------------------------------------------------------------------*




FORM REFRESH_DETAIL_GRID .

  DATA : LS_STABLE TYPE LVC_S_STBL.

  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GC_GRID_201->REFRESH_TABLE_DISPLAY

    EXPORTING IS_STABLE = LS_STABLE.

ENDFORM.