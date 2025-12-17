
*&---------------------------------------------------------------------*

*& Include ZMMR25_004_F01

*&---------------------------------------------------------------------*



*&---------------------------------------------------------------------*

*&      Form  SCREEN_INIT

*&---------------------------------------------------------------------*




FORM SCREEN_INIT.

  P_EBELN = '4500000001'.

  P_WERKS = '1000'.

  P_BUDAT = SY-DATUM.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SCREEN_MODIFY

*&---------------------------------------------------------------------*




FORM SCREEN_MODIFY.

  LOOP AT SCREEN.

    IF P_R2 = 'X'.

      IF SCREEN-GROUP1 = 'M1'.

        SCREEN-ACTIVE = 0.

        SCREEN-INVISIBLE = 1.

        MODIFY SCREEN.

      ENDIF.

    ENDIF.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  VALIDATE_INPUT_DATA

*&---------------------------------------------------------------------*




FORM VALIDATE_INPUT_DATA.

  IF P_EBELN IS INITIAL OR P_WERKS IS INITIAL OR P_BUDAT IS INITIAL.

    MESSAGE '## #### ######.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CHECK_PO_EXISTS

*&---------------------------------------------------------------------*




FORM CHECK_PO_EXISTS.

  DATA: LV_EBELN TYPE EBELN.



  CHECK P_EBELN IS NOT INITIAL.



  SELECT SINGLE EBELN

    INTO LV_EBELN

    FROM ZEDT25_ZEKKO

    WHERE EBELN = P_EBELN.



  IF SY-SUBRC <> 0.

    MESSAGE '#### ## #######.' TYPE 'E'.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  VALIDATE_QUERY_INPUT

*&---------------------------------------------------------------------*




FORM VALIDATE_QUERY_INPUT.

  IF P_EBELN IS INITIAL OR P_WERKS IS INITIAL.

    MESSAGE '## #### ######.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SELECT_PO_HEADER_DATA

*&---------------------------------------------------------------------*




FORM SELECT_PO_HEADER_DATA.

  CLEAR GS_HEADER.



  SELECT SINGLE LIFNR BUKRS WAERS

    INTO (GS_HEADER-LIFNR, GS_HEADER-BUKRS, GS_HEADER-WAERS)

    FROM ZEDT25_ZEKKO

    WHERE EBELN = P_EBELN.



  IF SY-SUBRC <> 0.

    MESSAGE '#### ## #######.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  SELECT SINGLE NAME1

    INTO GS_HEADER-NAME1

    FROM ZEDT25_LFA1

    WHERE LIFNR = GS_HEADER-LIFNR.



  SELECT SINGLE ZTERM

    INTO GS_HEADER-ZTERM

    FROM ZEDT25_LFB1

    WHERE LIFNR = GS_HEADER-LIFNR

      AND BUKRS = GS_HEADER-BUKRS.



  " #### ## (#### #####)

  SELECT SINGLE MWSKZ

    INTO GS_HEADER-MWSKZ

    FROM ZEDT25_LFM1

    WHERE LIFNR = GS_HEADER-LIFNR.



  " ##### ### ### V1

  IF GS_HEADER-MWSKZ IS INITIAL.

    GS_HEADER-MWSKZ = 'V1'.

  ENDIF.



  " ## ## (V1, V5# 10%, #### 0%)

  IF GS_HEADER-MWSKZ = 'V1' OR GS_HEADER-MWSKZ = 'V5'.

    GS_HEADER-TAX_RATE = '10.00'.

  ELSE.

    GS_HEADER-TAX_RATE = '0.00'.

  ENDIF.



  IF GS_HEADER-ZTERM IS NOT INITIAL.

    SELECT SINGLE TEXT

      INTO GS_HEADER-ZTEXT

      FROM ZEDT25_ZTERM

      WHERE ZTERM = GS_HEADER-ZTERM.

  ENDIF.



  GS_HEADER-EBELN = P_EBELN.

  GS_HEADER-WERKS = P_WERKS.

  GS_HEADER-BUDAT = P_BUDAT.

  GS_HEADER-BLDAT = P_BUDAT.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SELECT_PO_ITEM_DATA

*&---------------------------------------------------------------------*




FORM SELECT_PO_ITEM_DATA.

  DATA: LT_PROCESSED TYPE TABLE OF ZEDT25_ZRSEG,

        LS_PROCESSED TYPE ZEDT25_ZRSEG.



  CLEAR GT_PROCESS.



  SELECT A~EBELP A~MATNR A~MAKTX A~WERKS A~LGORT

         A~MENGE A~MEINS A~STPRS

         B~LIFNR B~BUKRS B~WAERS B~EBELN

    INTO CORRESPONDING FIELDS OF TABLE GT_PROCESS

    FROM ZEDT25_ZEKPO AS A

    INNER JOIN ZEDT25_ZEKKO AS B

      ON A~EBELN = B~EBELN

    WHERE A~EBELN = P_EBELN

      AND A~WERKS = P_WERKS.



  IF SY-SUBRC <> 0.

    MESSAGE '## ##### ## #### ####.' TYPE 'S' DISPLAY LIKE 'W'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  SELECT EBELN EBELP

    INTO CORRESPONDING FIELDS OF TABLE LT_PROCESSED

    FROM ZEDT25_ZRSEG

    WHERE EBELN = P_EBELN.



  IF LT_PROCESSED[] IS NOT INITIAL.

    LOOP AT LT_PROCESSED INTO LS_PROCESSED.

      DELETE GT_PROCESS WHERE EBELN = LS_PROCESSED-EBELN

                          AND EBELP = LS_PROCESSED-EBELP.

    ENDLOOP.

  ENDIF.



  IF GT_PROCESS[] IS INITIAL.

    MESSAGE '## ### PO #### ####.' TYPE 'S' DISPLAY LIKE 'W'.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CALCULATE_INVOICE_AMOUNT

*&---------------------------------------------------------------------*




FORM CALCULATE_INVOICE_AMOUNT.

  DATA: LV_TAX_RATE TYPE P DECIMALS 2.



  LOOP AT GT_PROCESS INTO GS_PROCESS.

    GS_PROCESS-BUZEI = SY-TABIX.

    GS_PROCESS-WRBTR = GS_PROCESS-MENGE * GS_PROCESS-STPRS.



    " #### ## (#### ####)

    IF GS_PROCESS-MWSKZ IS INITIAL.

      GS_PROCESS-MWSKZ = GS_HEADER-MWSKZ.

    ENDIF.



    " ## ## # ## ## (V1, V5# 10%, #### 0%)

    IF GS_PROCESS-MWSKZ = 'V1' OR GS_PROCESS-MWSKZ = 'V5'.

      LV_TAX_RATE = '10.00'.

    ELSE.

      LV_TAX_RATE = '0.00'.

    ENDIF.



    GS_PROCESS-WMWST = GS_PROCESS-WRBTR * ( LV_TAX_RATE / 100 ).



    GS_PROCESS-TOTAL = GS_PROCESS-WRBTR + GS_PROCESS-WMWST.

    CONCATENATE GS_PROCESS-EBELN '####' INTO GS_PROCESS-SGTXT.



    MODIFY GT_PROCESS FROM GS_PROCESS INDEX SY-TABIX.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SELECT_INVOICE_HEADER

*&---------------------------------------------------------------------*




FORM SELECT_INVOICE_HEADER.

  CLEAR GS_HEADER.



  GS_HEADER-EBELN = P_EBELN.

  GS_HEADER-WERKS = P_WERKS.



  SELECT SINGLE A~LIFNR A~BUKRS A~WAERS A~BUDAT

    INTO (GS_HEADER-LIFNR, GS_HEADER-BUKRS, GS_HEADER-WAERS, GS_HEADER-BUDAT)

    FROM ZEDT25_ZRBKP AS A

    WHERE A~EBELN = P_EBELN.



  IF SY-SUBRC = 0.

    SELECT SINGLE NAME1

      INTO GS_HEADER-NAME1

      FROM ZEDT25_LFA1

      WHERE LIFNR = GS_HEADER-LIFNR.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SELECT_INVOICE_ITEMS

*&---------------------------------------------------------------------*




FORM SELECT_INVOICE_ITEMS.

  CLEAR GT_INQUIRY.



  SELECT A~BELNR A~GJAHR A~BUZEI

         A~EBELN A~EBELP A~MATNR A~TXZ01

         A~WERKS A~LGORT A~MENGE A~MEINS

         A~WRBTR A~MWSKZ A~WMWST A~WAERS

         A~SGTXT

    INTO CORRESPONDING FIELDS OF TABLE GT_INQUIRY

    FROM ZEDT25_ZRSEG AS A

    WHERE A~EBELN = P_EBELN

      AND A~WERKS = P_WERKS.



  IF SY-SUBRC <> 0.

    MESSAGE '### ## #### ####.' TYPE 'S' DISPLAY LIKE 'W'.

    LEAVE LIST-PROCESSING.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CALCULATE_TOTAL_AMOUNT

*&---------------------------------------------------------------------*




FORM CALCULATE_TOTAL_AMOUNT.

  LOOP AT GT_INQUIRY INTO GS_INQUIRY.

    GS_INQUIRY-TOTAL = GS_INQUIRY-WRBTR + GS_INQUIRY-WMWST.

    MODIFY GT_INQUIRY FROM GS_INQUIRY INDEX SY-TABIX.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  PROCESS_INVOICE_SAVE

*&---------------------------------------------------------------------*




FORM PROCESS_INVOICE_SAVE.

  DATA: LS_RBKP   TYPE ZEDT25_ZRBKP,

        LT_RSEG   TYPE TABLE OF ZEDT25_ZRSEG,

        LS_RSEG   TYPE ZEDT25_ZRSEG,

        LV_BELNR  TYPE ZEDT25_ZRBKP-BELNR,

        LV_GJAHR  TYPE ZEDT25_ZRBKP-GJAHR,

        LV_NETWR  TYPE ZEDT25_ZRBKP-RMWWR,

        LV_WMWST  TYPE ZEDT25_ZRBKP-WMWST,

        LV_COUNT  TYPE I,

        LV_BUZEI  TYPE ZEDT25_ZRSEG-BUZEI.



  CALL METHOD GO_GRID_100->CHECK_CHANGED_DATA.



  CLEAR LV_COUNT.

  LOOP AT GT_PROCESS INTO GS_PROCESS WHERE ZCHECK = 'X'.

    LV_COUNT = LV_COUNT + 1.

  ENDLOOP.



  IF LV_COUNT = 0.

    MESSAGE '### ### ######.' TYPE 'S' DISPLAY LIKE 'W'.

    RETURN.

  ENDIF.



  LV_GJAHR = P_BUDAT(4).

  SELECT MAX( BELNR ) INTO LV_BELNR

    FROM ZEDT25_ZRBKP

    WHERE GJAHR = LV_GJAHR.



  IF LV_BELNR IS INITIAL.

    LV_BELNR = '5000000000'.

  ELSE.

    LV_BELNR = LV_BELNR + 1.

  ENDIF.



  LS_RBKP-MANDT = SY-MANDT.

  LS_RBKP-BELNR = LV_BELNR.

  LS_RBKP-GJAHR = LV_GJAHR.

  LS_RBKP-BLART = 'RE'.

  LS_RBKP-BLDAT = P_BUDAT.

  LS_RBKP-BUDAT = P_BUDAT.

  LS_RBKP-BUKRS = GS_HEADER-BUKRS.

  LS_RBKP-LIFNR = GS_HEADER-LIFNR.

  LS_RBKP-WAERS = GS_HEADER-WAERS.

  LS_RBKP-ZTERM = GS_HEADER-ZTERM.

  LS_RBKP-EBELN = P_EBELN.

  LS_RBKP-WERKS = P_WERKS.



  CLEAR: LV_NETWR, LV_WMWST, LV_BUZEI.

  LOOP AT GT_PROCESS INTO GS_PROCESS WHERE ZCHECK = 'X'.

    LV_BUZEI = LV_BUZEI + 1.



    CLEAR LS_RSEG.

    LS_RSEG-MANDT = SY-MANDT.

    LS_RSEG-BELNR = LV_BELNR.

    LS_RSEG-GJAHR = LV_GJAHR.

    LS_RSEG-BUZEI = LV_BUZEI.

    LS_RSEG-EBELN = GS_PROCESS-EBELN.

    LS_RSEG-EBELP = GS_PROCESS-EBELP.

    LS_RSEG-MATNR = GS_PROCESS-MATNR.

    LS_RSEG-TXZ01 = GS_PROCESS-MAKTX.

    LS_RSEG-BUKRS = GS_PROCESS-BUKRS.

    LS_RSEG-WERKS = GS_PROCESS-WERKS.

    LS_RSEG-LGORT = GS_PROCESS-LGORT.

    LS_RSEG-SHKZG = 'S'.

    LS_RSEG-MENGE = GS_PROCESS-MENGE.

    LS_RSEG-MEINS = GS_PROCESS-MEINS.

    LS_RSEG-BSTME = GS_PROCESS-MEINS.

    LS_RSEG-BPMNG = GS_PROCESS-MENGE.

    LS_RSEG-WRBTR = GS_PROCESS-WRBTR.

    LS_RSEG-MWSKZ = GS_PROCESS-MWSKZ.

    LS_RSEG-WMWST = GS_PROCESS-WMWST.

    LS_RSEG-WAERS = GS_PROCESS-WAERS.

    LS_RSEG-SGTXT = GS_PROCESS-SGTXT.



    APPEND LS_RSEG TO LT_RSEG.



    LV_NETWR = LV_NETWR + GS_PROCESS-WRBTR.

    LV_WMWST = LV_WMWST + GS_PROCESS-WMWST.



    IF LS_RBKP-MWSKZ IS INITIAL.

      LS_RBKP-MWSKZ = GS_PROCESS-MWSKZ.

    ENDIF.

  ENDLOOP.



  LS_RBKP-WMWST = LV_WMWST.

  LS_RBKP-RMWWR = LV_NETWR + LV_WMWST.

  LS_RBKP-XMWST = 'X'.



  CONCATENATE P_EBELN '####' INTO LS_RBKP-BKTXT.



  INSERT ZEDT25_ZRBKP FROM LS_RBKP.

  IF SY-SUBRC <> 0.

    ROLLBACK WORK.

    MESSAGE '## ## # ### ######.' TYPE 'E'.

    RETURN.

  ENDIF.



  INSERT ZEDT25_ZRSEG FROM TABLE LT_RSEG.

  IF SY-SUBRC <> 0.

    ROLLBACK WORK.

    MESSAGE '### ## # ### ######.' TYPE 'E'.

    RETURN.

  ENDIF.



  COMMIT WORK AND WAIT.



  MESSAGE |## ## { LV_BELNR }# #######.| TYPE 'S'.



  DELETE GT_PROCESS WHERE ZCHECK = 'X'.

  PERFORM REFRESH_ALV_100.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  PROCESS_INVOICE_CANCEL

*&---------------------------------------------------------------------*




FORM PROCESS_INVOICE_CANCEL.

  DATA: LV_COUNT      TYPE I,

        LV_ANSWER     TYPE C,

        LV_BELNR      TYPE ZEDT25_ZRSEG-BELNR,

        LV_GJAHR      TYPE ZEDT25_ZRSEG-GJAHR,

        LV_REMAINING  TYPE I,

        LV_NEW_WMWST  TYPE ZEDT25_ZRBKP-WMWST,

        LV_NEW_RMWWR  TYPE ZEDT25_ZRBKP-RMWWR.



  CALL METHOD GO_GRID_200->CHECK_CHANGED_DATA.



  CLEAR LV_COUNT.

  LOOP AT GT_INQUIRY INTO GS_INQUIRY WHERE ZCHECK = 'X'.

    LV_COUNT = LV_COUNT + 1.

  ENDLOOP.



  IF LV_COUNT = 0.

    MESSAGE '### ### ######.' TYPE 'S' DISPLAY LIKE 'W'.

    RETURN.

  ENDIF.



  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      TITLEBAR              = '## ##'

      TEXT_QUESTION         = '### ## ### ########?'

      TEXT_BUTTON_1         = '#'

      TEXT_BUTTON_2         = '###'

      DISPLAY_CANCEL_BUTTON = ''

    IMPORTING

      ANSWER                = LV_ANSWER.



  IF LV_ANSWER <> '1'.

    RETURN.

  ENDIF.



  LOOP AT GT_INQUIRY INTO GS_INQUIRY WHERE ZCHECK = 'X'.

    LV_BELNR = GS_INQUIRY-BELNR.

    LV_GJAHR = GS_INQUIRY-GJAHR.



    DELETE FROM ZEDT25_ZRSEG

      WHERE BELNR = GS_INQUIRY-BELNR

        AND GJAHR = GS_INQUIRY-GJAHR

        AND BUZEI = GS_INQUIRY-BUZEI.



    IF SY-SUBRC = 0.

      SELECT COUNT(*) INTO LV_REMAINING

        FROM ZEDT25_ZRSEG

        WHERE BELNR = LV_BELNR

          AND GJAHR = LV_GJAHR.



      IF LV_REMAINING = 0.

        DELETE FROM ZEDT25_ZRBKP

          WHERE BELNR = LV_BELNR

            AND GJAHR = LV_GJAHR.

      ELSE.

        CLEAR: LV_NEW_WMWST, LV_NEW_RMWWR.



        SELECT SUM( WRBTR ) SUM( WMWST )

          INTO (LV_NEW_RMWWR, LV_NEW_WMWST)

          FROM ZEDT25_ZRSEG

          WHERE BELNR = LV_BELNR

            AND GJAHR = LV_GJAHR.



        LV_NEW_RMWWR = LV_NEW_RMWWR + LV_NEW_WMWST.



        UPDATE ZEDT25_ZRBKP

          SET WMWST = LV_NEW_WMWST

              RMWWR = LV_NEW_RMWWR

          WHERE BELNR = LV_BELNR

            AND GJAHR = LV_GJAHR.

      ENDIF.

    ENDIF.

  ENDLOOP.



  IF SY-SUBRC = 0.

    COMMIT WORK AND WAIT.

    MESSAGE '### ## ### #######.' TYPE 'S'.



    DELETE GT_INQUIRY WHERE ZCHECK = 'X'.

    PERFORM REFRESH_ALV_200.

  ELSE.

    ROLLBACK WORK.

    MESSAGE '## ## # ### ######.' TYPE 'E'.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  BUILD_FIELD_CATALOG_100

*&---------------------------------------------------------------------*




FORM BUILD_FIELD_CATALOG_100.

  CLEAR: GT_FCAT, GS_FCAT.



  PERFORM ADD_CATALOG_FIELD USING 'ZCHECK' '##'     'X'  5  'CH' '' ''.

  PERFORM ADD_CATALOG_FIELD USING 'EBELP'  'PO###' ''   8  ''   '' ''.

  PERFORM ADD_CATALOG_FIELD USING 'MATNR'  '##'     ''   20 ''   '' ''.

  PERFORM ADD_CATALOG_FIELD USING 'MAKTX'  '###'   ''   45 ''   '' ''.

  PERFORM ADD_CATALOG_FIELD USING 'WERKS'  '###'   ''   10 ''   '' ''.

  PERFORM ADD_CATALOG_FIELD USING 'LGORT'  '####' ''   10 ''   '' ''.

  PERFORM ADD_CATALOG_FIELD USING 'MENGE'  '##'     ''   15 'Q'  'MEINS' ''.

  PERFORM ADD_CATALOG_FIELD USING 'MEINS'  '##'     ''   6  ''   '' ''.

  PERFORM ADD_CATALOG_FIELD USING 'STPRS'  '##'     ''   20 'C'  '' 'WAERS'.

  PERFORM ADD_CATALOG_FIELD USING 'WRBTR'  '####' ''   20 'C'  '' 'WAERS'.

  PERFORM ADD_CATALOG_FIELD USING 'MWSKZ'  '####' 'X'  6  ''   '' ''.

  PERFORM ADD_CATALOG_FIELD USING 'WMWST'  '##'     ''   20 'C'  '' 'WAERS'.

  PERFORM ADD_CATALOG_FIELD USING 'WAERS'  '##'     ''   6  ''   '' ''.

  PERFORM ADD_CATALOG_FIELD USING 'TOTAL'  '###'   ''   20 'C'  '' 'WAERS'.

  PERFORM ADD_CATALOG_FIELD USING 'SGTXT'  '###'   'X'  50 ''   '' ''.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  BUILD_FIELD_CATALOG_200

*&---------------------------------------------------------------------*




FORM BUILD_FIELD_CATALOG_200.

  CLEAR: GT_FCAT, GS_FCAT.



  PERFORM ADD_CATALOG_FIELD USING 'ZCHECK' '##'     'X'  5  'CH' '' ''.

  PERFORM ADD_CATALOG_FIELD USING 'BELNR'  '####' ''   16 ''   '' ''.

  PERFORM ADD_CATALOG_FIELD USING 'GJAHR'  '####' ''   8  ''   '' ''.

  PERFORM ADD_CATALOG_FIELD USING 'BUZEI'  '##'     ''   8  ''   '' ''.

  PERFORM ADD_CATALOG_FIELD USING 'EBELN'  'PO##'   ''   16 ''   '' ''.

  PERFORM ADD_CATALOG_FIELD USING 'EBELP'  'PO###' ''   8  ''   '' ''.

  PERFORM ADD_CATALOG_FIELD USING 'MATNR'  '##'     ''   20 ''   '' ''.

  PERFORM ADD_CATALOG_FIELD USING 'TXZ01'  '###'   ''   45 ''   '' ''.

  PERFORM ADD_CATALOG_FIELD USING 'MENGE'  '##'     ''   15 'Q'  'MEINS' ''.

  PERFORM ADD_CATALOG_FIELD USING 'MEINS'  '##'     ''   6  ''   '' ''.

  PERFORM ADD_CATALOG_FIELD USING 'WRBTR'  '####' ''   20 'C'  '' 'WAERS'.

  PERFORM ADD_CATALOG_FIELD USING 'MWSKZ'  '####' ''   6  ''   '' ''.

  PERFORM ADD_CATALOG_FIELD USING 'WMWST'  '##'     ''   20 'C'  '' 'WAERS'.

  PERFORM ADD_CATALOG_FIELD USING 'WAERS'  '##'     ''   6  ''   '' ''.

  PERFORM ADD_CATALOG_FIELD USING 'TOTAL'  '###'   ''   20 'C'  '' 'WAERS'.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ADD_CATALOG_FIELD

*&---------------------------------------------------------------------*




FORM ADD_CATALOG_FIELD USING P_FIELD    TYPE ANY

                             P_TEXT     TYPE ANY

                             P_EDIT     TYPE ANY

                             P_LEN      TYPE ANY

                             P_XFIELD   TYPE ANY

                             P_QFIELD   TYPE ANY

                             P_CFIELD   TYPE ANY.



  CLEAR GS_FCAT.

  GS_FCAT-FIELDNAME = P_FIELD.

  GS_FCAT-COLTEXT   = P_TEXT.

  GS_FCAT-SCRTEXT_L = P_TEXT.

  GS_FCAT-SCRTEXT_M = P_TEXT.

  GS_FCAT-SCRTEXT_S = P_TEXT.

  GS_FCAT-EDIT      = P_EDIT.

  GS_FCAT-OUTPUTLEN = P_LEN.

  GS_FCAT-JUST      = 'R'.



  CASE P_XFIELD.

    WHEN 'CH'.

      GS_FCAT-CHECKBOX = 'X'.

      CLEAR GS_FCAT-JUST.

    WHEN 'Q'.

      GS_FCAT-QFIELDNAME = P_QFIELD.

    WHEN 'C'.

      GS_FCAT-CFIELDNAME = P_CFIELD.

  ENDCASE.



  APPEND GS_FCAT TO GT_FCAT.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SETUP_ALV_LAYOUT

*&---------------------------------------------------------------------*




FORM SETUP_ALV_LAYOUT.

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA      = 'X'.

  GS_LAYOUT-CWIDTH_OPT = 'X'.

  GS_LAYOUT-SEL_MODE   = 'A'.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CREATE_ALV_CONTAINER_100

*&---------------------------------------------------------------------*




FORM CREATE_ALV_CONTAINER_100.

  IF GO_CONTAINER_100 IS NOT BOUND.

    CREATE OBJECT GO_CONTAINER_100

      EXPORTING

        CONTAINER_NAME = 'CC_ALV_100'.



    CREATE OBJECT GO_GRID_100

      EXPORTING

        I_PARENT = GO_CONTAINER_100.



    CREATE OBJECT GO_EVENT_100.

    SET HANDLER GO_EVENT_100->HANDLE_DATA_CHANGED FOR GO_GRID_100.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CREATE_ALV_CONTAINER_200

*&---------------------------------------------------------------------*




FORM CREATE_ALV_CONTAINER_200.

  IF GO_CONTAINER_200 IS NOT BOUND.

    CREATE OBJECT GO_CONTAINER_200

      EXPORTING

        CONTAINER_NAME = 'CC_ALV_200'.



    CREATE OBJECT GO_GRID_200

      EXPORTING

        I_PARENT = GO_CONTAINER_200.



    CREATE OBJECT GO_EVENT_200.

    SET HANDLER GO_EVENT_200->HANDLE_DATA_CHANGED FOR GO_GRID_200.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  DISPLAY_ALV_GRID_100

*&---------------------------------------------------------------------*




FORM DISPLAY_ALV_GRID_100.

  CALL METHOD GO_GRID_100->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.



  CALL METHOD GO_GRID_100->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_LAYOUT       = GS_LAYOUT

    CHANGING

      IT_OUTTAB       = GT_PROCESS

      IT_FIELDCATALOG = GT_FCAT.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  DISPLAY_ALV_GRID_200

*&---------------------------------------------------------------------*




FORM DISPLAY_ALV_GRID_200.

  CALL METHOD GO_GRID_200->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.



  CALL METHOD GO_GRID_200->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_LAYOUT       = GS_LAYOUT

    CHANGING

      IT_OUTTAB       = GT_INQUIRY

      IT_FIELDCATALOG = GT_FCAT.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  REFRESH_ALV_100

*&---------------------------------------------------------------------*




FORM REFRESH_ALV_100.

  DATA: LS_STABLE TYPE LVC_S_STBL.

  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GO_GRID_100->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE = LS_STABLE.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  REFRESH_ALV_200

*&---------------------------------------------------------------------*




FORM REFRESH_ALV_200.

  DATA: LS_STABLE TYPE LVC_S_STBL.

  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GO_GRID_200->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE = LS_STABLE.

ENDFORM.