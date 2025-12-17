
*&---------------------------------------------------------------------*

*&  Include           ZMM05_004_F01

*&---------------------------------------------------------------------*








form SET_INIT .

  P_DATE = SY-DATUM.

  P_EBELN = '4500000001'.

  P_WERKS = '1000'.

endform.



FORM VALID_INPUT .

  DATA: LV_DUMMY TYPE C.



  SELECT SINGLE 'X'

    INTO @LV_DUMMY

    FROM ZEKKO_05

    WHERE EBELN = @P_EBELN.



  IF SY-SUBRC <> 0.

    " DB# ## #### ## ##

    MESSAGE '#### ## #### #####.' TYPE 'E'.

  ENDIF.



  CLEAR: LV_DUMMY.

  SELECT SINGLE 'X'

    INTO @LV_DUMMY

    FROM ZEKPO_05

    WHERE EBELN = @P_EBELN

      AND WERKS = @P_WERKS.



  IF SY-SUBRC <> 0.

    MESSAGE '## #### #### #### ### ####.' TYPE 'E'.

  ENDIF.

  IF P_EBELN IS INITIAL.

    MESSAGE '#### ### ######.' TYPE 'E'.

  ENDIF.

  IF P_WERKS IS INITIAL.

    MESSAGE '#### ######.' TYPE 'E'.

  ENDIF.

  IF P_R1 = 'X'.

    IF P_DATE IS INITIAL.

      MESSAGE '## #### ######.' TYPE 'E'.

    ENDIF.

  ENDIF.



ENDFORM.



form SET_SCREEN .

  LOOP AT SCREEN.

    SCREEN-REQUIRED = 2.

    IF P_R2 = 'X'.

      IF SCREEN-GROUP1 = 'M1'.

        SCREEN-ACTIVE = 0.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

endform.





FORM GET_PO_HEADER.



  DATA: LV_LIFNR TYPE ZEKKO_05-LIFNR.



  " ## ### ## ### ### ## ## (#### ### #)

  IF GV_SAVED_ZAMOUNT IS NOT INITIAL.

    " ## ## # ##

  ELSEIF GS_AMOUNT_HEADER-ZAMOUNT IS NOT INITIAL.

    " ## ### ### ## ### # ##

    GV_SAVED_ZAMOUNT = GS_AMOUNT_HEADER-ZAMOUNT.

  ENDIF.



  " [##] ZAMOUNT# #### #### ###

  CLEAR: GS_COMMON_HEADER.



  " GS_AMOUNT_HEADER# #### ## ### (ZAMOUNT ##)

  " ZAMOUNT# ### ###### ##

  CLEAR: GS_AMOUNT_HEADER-LIFNR,

         GS_AMOUNT_HEADER-NAME1,

         GS_AMOUNT_HEADER-WAERS,

         GS_AMOUNT_HEADER-MWSKZ,

         GS_AMOUNT_HEADER-ZMEMO,

         GS_AMOUNT_HEADER-ZBALANCE,

         GS_AMOUNT_HEADER-ICON.

  " GS_AMOUNT_HEADER-ZAMOUNT# ##### ##!



  "--------------------------------------------------

  " 1. PO ## (#### / #### / ### / ### / ##)

  "--------------------------------------------------

  SELECT SINGLE

         BUKRS

         EKGRP

         BEDAT

         LIFNR

         WAERS

    INTO (

         GS_COMMON_HEADER-BUKRS,

         GS_COMMON_HEADER-EKGRP,

         GS_COMMON_HEADER-BEDAT,

         LV_LIFNR,

         GS_AMOUNT_HEADER-WAERS

    )

    FROM ZEKKO_05

    WHERE EBELN = P_EBELN.



  IF SY-SUBRC <> 0.

    MESSAGE '#### ### ## # ####.' TYPE 'E'.

  ENDIF.



  GS_COMMON_HEADER-LIFNR = LV_LIFNR.

  GS_COMMON_HEADER-BLDAT = P_DATE.



  "--------------------------------------------------

  " 2. ####

  "--------------------------------------------------

  SELECT SINGLE ZTERM

    INTO GS_COMMON_HEADER-ZTERM

    FROM ZLFB1_05

    WHERE LIFNR = LV_LIFNR

      AND BUKRS = GS_COMMON_HEADER-BUKRS.



  "--------------------------------------------------

  " 3. ####

  "--------------------------------------------------

  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

    EXPORTING

      INPUT  = LV_LIFNR

    IMPORTING

      OUTPUT = LV_LIFNR.



  SELECT SINGLE NAME1

    INTO GS_COMMON_HEADER-NAME1

    FROM ZLFA1_05

    WHERE LIFNR = LV_LIFNR.



  "--------------------------------------------------

  " 4. ## ## ## ##

  "--------------------------------------------------

  GS_AMOUNT_HEADER-LIFNR = GS_COMMON_HEADER-LIFNR.

  GS_AMOUNT_HEADER-NAME1 = GS_COMMON_HEADER-NAME1.



  "--------------------------------------------------

  " 5. #### (#### ##)

  "--------------------------------------------------

  SELECT SINGLE MWSKZ

    INTO GS_AMOUNT_HEADER-MWSKZ

    FROM ZLFM1_05

    WHERE LIFNR = GS_COMMON_HEADER-LIFNR.





  "--------------------------------------------------

  " 6. ## ##

  "--------------------------------------------------

  CASE GS_AMOUNT_HEADER-MWSKZ.

    WHEN 'V1'. GS_AMOUNT_HEADER-ZMEMO = '## 10%'.

    WHEN 'V2'. GS_AMOUNT_HEADER-ZMEMO = '####0%'.

    WHEN 'V3'. GS_AMOUNT_HEADER-ZMEMO = '####0%	'.

    WHEN 'V4'. GS_AMOUNT_HEADER-ZMEMO = '#####'.

    WHEN 'V5'. GS_AMOUNT_HEADER-ZMEMO = '######'.

  ENDCASE.



  " [##] ## ### ### ## ##

  IF GV_SAVED_ZAMOUNT IS NOT INITIAL.

    GS_AMOUNT_HEADER-ZAMOUNT = GV_SAVED_ZAMOUNT.

  ENDIF.



ENDFORM.







FORM GET_PO_DATA.



  PERFORM GET_PO_HEADER.





  CLEAR: GT_ITEM, GT_ITEM_GR, GT_ITEM_PO, GT_PO_BASE,

         GT_GR_SUM, GT_IV_GR, GT_IV_PO.



  SELECT

    A~EBELN A~EBELP A~MATNR

    A~MAKTX AS TXZ01

    A~WERKS A~LGORT

    A~MEINS A~STPRS

    A~MENGE AS POMENGE

    B~WAERS

  INTO CORRESPONDING FIELDS OF TABLE GT_PO_BASE

  FROM ZEKPO_05 AS A

  INNER JOIN ZEKKO_05 AS B

    ON A~EBELN = B~EBELN

  WHERE A~EBELN = P_EBELN

    AND A~WERKS = P_WERKS.



  IF GT_PO_BASE IS INITIAL.

    MESSAGE 'PO ### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    RETURN.

  ENDIF.



  SELECT

    EBELN MATNR

    SUM( MENGE ) AS GR_QTY

  INTO CORRESPONDING FIELDS OF TABLE GT_GR_SUM

  FROM ZMSEG_05

  WHERE EBELN = P_EBELN

    AND BWART = '101'

  GROUP BY EBELN MATNR.



  " 3-1. ## ## ##

  SELECT

    EBELN EBELP

    SUM( MENGE ) AS QTY

  INTO CORRESPONDING FIELDS OF TABLE GT_IV_GR

  FROM ZRSEG_05

  WHERE EBELN = P_EBELN

    AND MBLNR IS NOT NULL

  GROUP BY EBELN EBELP.



  " 3-2. ### ##

  SELECT

    EBELN EBELP

    SUM( MENGE ) AS QTY

  INTO CORRESPONDING FIELDS OF TABLE GT_IV_PO

  FROM ZRSEG_05

  WHERE EBELN = P_EBELN

    AND MBLNR IS NULL

  GROUP BY EBELN EBELP.



  LOOP AT GT_PO_BASE INTO GS_PO_BASE.



    " ## ## (MATNR ##)

    READ TABLE GT_GR_SUM INTO GS_GR_SUM

      WITH KEY EBELN = GS_PO_BASE-EBELN

               MATNR = GS_PO_BASE-MATNR.

    IF SY-SUBRC = 0.

      GS_PO_BASE-GR_QTY = GS_GR_SUM-GR_QTY.

    ELSE.

      GS_PO_BASE-GR_QTY = 0.

    ENDIF.



    " #### ##

    READ TABLE GT_IV_GR INTO GS_IV_SUM

      WITH KEY EBELN = GS_PO_BASE-EBELN

               EBELP = GS_PO_BASE-EBELP.

    IF SY-SUBRC = 0.

      GS_PO_BASE-IV_GR_QTY = GS_IV_SUM-QTY.

    ELSE.

      GS_PO_BASE-IV_GR_QTY = 0.

    ENDIF.



    " ### ##

    READ TABLE GT_IV_PO INTO GS_IV_SUM

      WITH KEY EBELN = GS_PO_BASE-EBELN

               EBELP = GS_PO_BASE-EBELP.

    IF SY-SUBRC = 0.

      GS_PO_BASE-IV_PO_QTY = GS_IV_SUM-QTY.

    ELSE.

      GS_PO_BASE-IV_PO_QTY = 0.

    ENDIF.



    MODIFY GT_PO_BASE FROM GS_PO_BASE.

  ENDLOOP.



  PERFORM GET_INVOICE_HISTORY.



  LOOP AT GT_PO_BASE INTO GS_PO_BASE.



    IF GS_PO_BASE-GR_QTY - GS_PO_BASE-IV_GR_QTY <= 0.

      CONTINUE.

    ENDIF.





    CLEAR GS_ITEM.

    MOVE-CORRESPONDING GS_PO_BASE TO GS_ITEM.



    GS_ITEM-MENGE   = GS_PO_BASE-GR_QTY - GS_PO_BASE-IV_GR_QTY.

    GS_ITEM-REMENGE = GS_ITEM-MENGE.

    GS_ITEM-LGORT = GS_PO_BASE-LGORT.

    GS_ITEM-TXZ01 = GS_PO_BASE-TXZ01.

    GS_ITEM-LIFNR = GS_COMMON_HEADER-LIFNR.

    GS_ITEM-MWSKZ = GS_AMOUNT_HEADER-MWSKZ.



    CLEAR GS_INV_HISTORY.

    READ TABLE GT_INV_HISTORY INTO GS_INV_HISTORY

      WITH KEY EBELN = GS_ITEM-EBELN

               EBELP = GS_ITEM-EBELP.

    IF SY-SUBRC = 0.

      GS_ITEM-IV_MENGE = GS_INV_HISTORY-MENGE.

      GS_ITEM-IV_BELNR = GS_INV_HISTORY-BELNR.

    ENDIF.



    PERFORM CALCULATE_AMOUNT CHANGING GS_ITEM.

    APPEND GS_ITEM TO GT_ITEM_GR.

  ENDLOOP.



  LOOP AT GT_PO_BASE INTO GS_PO_BASE.



     IF GS_PO_BASE-POMENGE

      - GS_PO_BASE-GR_QTY

      - GS_PO_BASE-IV_PO_QTY <= 0.

       CONTINUE.

     ENDIF.





    CLEAR GS_ITEM.

    CLEAR GS_ITEM.

    MOVE-CORRESPONDING GS_PO_BASE TO GS_ITEM.



    GS_ITEM-MENGE =

      GS_PO_BASE-POMENGE

    - GS_PO_BASE-GR_QTY

    - GS_PO_BASE-IV_PO_QTY.



    GS_ITEM-REMENGE = GS_ITEM-MENGE.

    GS_ITEM-LGORT = GS_PO_BASE-LGORT.

    GS_ITEM-TXZ01 = GS_PO_BASE-TXZ01.

    GS_ITEM-LIFNR = GS_COMMON_HEADER-LIFNR.

    GS_ITEM-MWSKZ = GS_AMOUNT_HEADER-MWSKZ.  " #### ##



    CLEAR GS_INV_HISTORY.

    READ TABLE GT_INV_HISTORY INTO GS_INV_HISTORY

      WITH KEY EBELN = GS_ITEM-EBELN

               EBELP = GS_ITEM-EBELP.

    IF SY-SUBRC = 0.

      GS_ITEM-IV_MENGE = GS_INV_HISTORY-MENGE.

      GS_ITEM-IV_BELNR = GS_INV_HISTORY-BELNR.

    ENDIF.



    PERFORM CALCULATE_AMOUNT CHANGING GS_ITEM.

    APPEND GS_ITEM TO GT_ITEM_PO.

  ENDLOOP.



  " ### ## ## ### ##

  CLEAR: GV_GR_EXIST, GV_PO_EXIST.



  IF GT_ITEM_GR IS NOT INITIAL.

    GV_GR_EXIST = 'X'.

  ENDIF.



  IF GT_ITEM_PO IS NOT INITIAL.

    GV_PO_EXIST = 'X'.

  ENDIF.



  " #### ### ##

  IF GV_GR_EXIST = 'X' AND GV_PO_EXIST = 'X'.

    " # # ## -> #### ## ##

    IF GV_SEL_TYPE IS INITIAL.

      GV_SEL_TYPE = 'GR'.

    ENDIF.

    IF GV_SEL_TYPE = 'GR'.

      GT_ITEM = GT_ITEM_GR.

    ELSEIF GV_SEL_TYPE = 'PO'.

      GT_ITEM = GT_ITEM_PO.

    ENDIF.

  ELSEIF GV_GR_EXIST = 'X'.

    " ### ##

    GV_SEL_TYPE = 'GR'.

    GT_ITEM = GT_ITEM_GR.

  ELSEIF GV_PO_EXIST = 'X'.

    " PO# ##

    GV_SEL_TYPE = 'PO'.

    GT_ITEM = GT_ITEM_PO.

  ELSE.

    " # # ##

    CLEAR GV_SEL_TYPE.

    CLEAR GT_ITEM.

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_INVOICE_HISTORY

*&---------------------------------------------------------------------*

*       ##### ### ## ##

*----------------------------------------------------------------------*




FORM GET_INVOICE_HISTORY.

  CLEAR: GT_INV_HISTORY.



  " ## PO# ### ## ##

  SELECT A~BELNR   " ####

         A~GJAHR   " ####

         A~BLDAT   " ###

         B~EBELN   " PO##

         B~EBELP   " PO##

         B~MENGE   " ##

         B~WRBTR   " ####

         B~WMWST   " ##

    INTO CORRESPONDING FIELDS OF TABLE GT_INV_HISTORY

    FROM ZRBKP_05 AS A

    INNER JOIN ZRSEG_05 AS B

      ON A~BELNR = B~BELNR

     AND A~GJAHR = B~GJAHR

    WHERE B~EBELN = P_EBELN

      AND A~BUKRS = GS_COMMON_HEADER-BUKRS.



  " ## ##

  LOOP AT GT_INV_HISTORY INTO GS_INV_HISTORY.

    GS_INV_HISTORY-DMBTR = GS_INV_HISTORY-WRBTR + GS_INV_HISTORY-WMWST.

    MODIFY GT_INV_HISTORY FROM GS_INV_HISTORY.

  ENDLOOP.



ENDFORM.







FORM GET_INVOICE_DATA.



  REFRESH GT_ITEM.



  " 1. DB ## (## + ### ##)

  "    ### #(### ## ##)# #### ##

  SELECT A~BELNR   " ####

         A~GJAHR   " ####

         B~BUZEI   " #####

         B~EBELN   " PO##

         B~EBELP   " PO##

         B~MATNR   " ##

         B~WERKS   " ###

         B~MENGE   " ##

         B~WRBTR   " ####

         A~WAERS   " ## (####)

         B~WMWST   " ##

         A~LIFNR   " ### (####)

         B~MWSKZ   " ####

    INTO CORRESPONDING FIELDS OF TABLE GT_ITEM

    FROM ZRBKP_05 AS A

    INNER JOIN ZRSEG_05 AS B

      ON A~BELNR = B~BELNR

     AND A~GJAHR = B~GJAHR

    WHERE A~BUKRS = B~BUKRS.



  " 2. ### ###

  LOOP AT GT_ITEM INTO GS_ITEM.

    " ### ##

    GS_ITEM-DMBTR = GS_ITEM-WRBTR + GS_ITEM-WMWST.



    " ### #### (##)

    SELECT SINGLE MAKTX INTO GS_ITEM-TXZ01

      FROM ZEKPO_05

      WHERE MATNR = GS_ITEM-MATNR

        AND EBELN = GS_ITEM-EBELN. "PO### #### ## ###



    MODIFY GT_ITEM FROM GS_ITEM.

  ENDLOOP.



  IF GT_ITEM IS INITIAL.

    MESSAGE '### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

  ENDIF.



ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  HANDLE_DATA_CHANGED_LOGIC

*&---------------------------------------------------------------------*




FORM HANDLE_DATA_CHANGED_LOGIC USING P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL.

  DATA: LS_MODI TYPE LVC_S_MODI.

  DATA: LV_STPRS TYPE ZEKPO_05-STPRS,

        LV_MENGE TYPE ZRSEG_05-MENGE,

        LV_WRBTR TYPE ZRSEG_05-WRBTR.



  LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.



    " ## ### ## #### #####.

    READ TABLE GT_ITEM INTO GS_ITEM INDEX LS_MODI-ROW_ID.

    IF SY-SUBRC <> 0.

      CONTINUE.

    ENDIF.



    CASE LS_MODI-FIELDNAME.



      " -----------------------------------------------------

      " Case A. ##(MENGE) ## ##(STPRS)# #### #

      " -> ####(WRBTR)# ## ####. (###)

      " -----------------------------------------------------

      WHEN 'MENGE' OR 'STPRS'.



        " ### ## GS_ITEM# ## ##

        IF LS_MODI-FIELDNAME = 'MENGE'.

          GS_ITEM-MENGE = LS_MODI-VALUE.



          " #### ## ##

          IF GS_ITEM-MENGE > GS_ITEM-REMENGE.

            DATA: LV_MSG_V1 TYPE STRING,

                  LV_MSG_V2 TYPE STRING.

            LV_MSG_V1 = |## ##: { GS_ITEM-MENGE }|.

            LV_MSG_V2 = |####: { GS_ITEM-REMENGE }|.



            CALL METHOD P_DATA_CHANGED->ADD_PROTOCOL_ENTRY

              EXPORTING

                I_MSGID     = '00'

                I_MSGNO     = '001'

                I_MSGTY     = 'E'

                I_MSGV1     = LV_MSG_V1

                I_MSGV2     = LV_MSG_V2

                I_MSGV3     = '##### ### # ####.'

                I_FIELDNAME = LS_MODI-FIELDNAME

                I_ROW_ID    = LS_MODI-ROW_ID.

            CONTINUE.

          ENDIF.

        ELSE.

          GS_ITEM-STPRS = LS_MODI-VALUE.

        ENDIF.



        " [##] #### = ## * ##

        GS_ITEM-WRBTR = GS_ITEM-MENGE * GS_ITEM-STPRS.

        GS_ITEM-MWSKZ = GS_AMOUNT_HEADER-MWSKZ.



        " ##/## ###

        PERFORM CALCULATE_AMOUNT CHANGING GS_ITEM.



      " -----------------------------------------------------

      " Case B. ####(WRBTR)# ## #### #

      " -> ##(STPRS)# ####. (###)

      " -----------------------------------------------------

      WHEN 'WRBTR'.

        GS_ITEM-WRBTR = LS_MODI-VALUE. " ### ## ##



        " [## ##] ### 0## ## # ##!

        IF GS_ITEM-MENGE IS NOT INITIAL AND GS_ITEM-MENGE <> 0.

          " [##] ## = #### / ##

          GS_ITEM-STPRS = GS_ITEM-WRBTR / GS_ITEM-MENGE.

        ELSE.

          " ### 0## ### #####? ### ## ##(0) ## ### ## ##

          GS_ITEM-STPRS = 0.

        ENDIF.



        " ##/## ### (### WRBTR ##)

        PERFORM CALCULATE_AMOUNT CHANGING GS_ITEM.



      WHEN 'CHECK'.

        GS_ITEM-CHECK = LS_MODI-VALUE.



    ENDCASE.



    " [##] ### #### ### #### ##

    MODIFY GT_ITEM FROM GS_ITEM INDEX LS_MODI-ROW_ID.



  ENDLOOP.



  " [##] ## ###(GT_ITEM_GR ## GT_ITEM_PO)## #### ##

  PERFORM SYNC_ITEM_TO_SOURCE.



  " [## ##] ## # ### ## ##

  PERFORM CALCULATE_TOTAL_BALANCE.



  " ALV ### ### #(## ### ##/##) ##

  PERFORM REFRESH_ALV.



ENDFORM.






















*&---------------------------------------------------------------------*

*&      Form  SYNC_ITEM_TO_SOURCE

*&---------------------------------------------------------------------*

* GT_ITEM# ##### ## ###(GT_ITEM_GR ## GT_ITEM_PO)# ##

*----------------------------------------------------------------------*




FORM SYNC_ITEM_TO_SOURCE.

  DATA: LS_ITEM_SOURCE LIKE GS_ITEM.



  " ## ### ### ## ## ### ##

  IF GV_SEL_TYPE = 'GR' AND GT_ITEM_GR IS NOT INITIAL.

    " GT_ITEM# ## ##### GT_ITEM_GR# ##

    LOOP AT GT_ITEM INTO GS_ITEM.

      READ TABLE GT_ITEM_GR INTO LS_ITEM_SOURCE

        WITH KEY EBELN = GS_ITEM-EBELN

                 EBELP = GS_ITEM-EBELP.

      IF SY-SUBRC = 0.

        " ## ### #### ##

        LS_ITEM_SOURCE-MENGE = GS_ITEM-MENGE.

        LS_ITEM_SOURCE-MWSKZ = GS_ITEM-MWSKZ.

        LS_ITEM_SOURCE-STPRS = GS_ITEM-STPRS.

        LS_ITEM_SOURCE-WRBTR = GS_ITEM-WRBTR.

        LS_ITEM_SOURCE-WMWST = GS_ITEM-WMWST.

        LS_ITEM_SOURCE-DMBTR = GS_ITEM-DMBTR.

        LS_ITEM_SOURCE-CHECK = GS_ITEM-CHECK.



        " [##] INDEX SY-TABIX ## (READ TABLE# ## ### ####)

        MODIFY GT_ITEM_GR FROM LS_ITEM_SOURCE INDEX SY-TABIX.

      ENDIF.

    ENDLOOP.



  ELSEIF GV_SEL_TYPE = 'PO' AND GT_ITEM_PO IS NOT INITIAL.

    " GT_ITEM# ## ##### GT_ITEM_PO# ##

    LOOP AT GT_ITEM INTO GS_ITEM.

      READ TABLE GT_ITEM_PO INTO LS_ITEM_SOURCE

        WITH KEY EBELN = GS_ITEM-EBELN

                 EBELP = GS_ITEM-EBELP.

      IF SY-SUBRC = 0.

        " ## ### #### ##

        LS_ITEM_SOURCE-MWSKZ = GS_ITEM-MWSKZ.

        LS_ITEM_SOURCE-MENGE = GS_ITEM-MENGE.

        LS_ITEM_SOURCE-STPRS = GS_ITEM-STPRS.

        LS_ITEM_SOURCE-WRBTR = GS_ITEM-WRBTR.

        LS_ITEM_SOURCE-WMWST = GS_ITEM-WMWST.

        LS_ITEM_SOURCE-DMBTR = GS_ITEM-DMBTR.

        LS_ITEM_SOURCE-CHECK = GS_ITEM-CHECK.



        MODIFY GT_ITEM_PO FROM LS_ITEM_SOURCE INDEX SY-TABIX.

      ENDIF.

    ENDLOOP.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CALCULATE_AMOUNT

*&---------------------------------------------------------------------*

*FORM CALCULATE_AMOUNT USING PS_ITEM LIKE GS_ITEM.




FORM CALCULATE_AMOUNT CHANGING PS_ITEM LIKE GS_ITEM.

  DATA: LV_TAX_RATE TYPE P DECIMALS 2.



  " 1. #### = ## * ##

  PS_ITEM-WRBTR = PS_ITEM-MENGE * PS_ITEM-STPRS.



  IF PS_ITEM-MWSKZ IS INITIAL.

    PS_ITEM-MWSKZ = GS_AMOUNT_HEADER-MWSKZ.

  ENDIF.



  CASE PS_ITEM-MWSKZ.

    WHEN 'V1'. LV_TAX_RATE = '0.10'.

    WHEN 'V4'. LV_TAX_RATE = '0.10'.

    WHEN 'V5'. LV_TAX_RATE = '0.10'.

    WHEN 'V2'. LV_TAX_RATE = '0.00'.

    WHEN 'V3'. LV_TAX_RATE = '0.00'.

    WHEN OTHERS. LV_TAX_RATE = '0.00'.

  ENDCASE.



  PS_ITEM-WMWST = PS_ITEM-WRBTR * LV_TAX_RATE.



  " 3. ## ##

  PS_ITEM-DMBTR = PS_ITEM-WRBTR + PS_ITEM-WMWST.

ENDFORM.







FORM CALCULATE_TOTAL_BALANCE.

  DATA: LV_TOTAL_ITEM_AMT TYPE BSIK-DMBTR.



  " [### ###]

  DATA: LT_DYNP_READ TYPE TABLE OF DYNPREAD,

        LS_DYNP_READ TYPE DYNPREAD.

  DATA: LV_ZAMOUNT_CHAR(20) TYPE C.



  " [### ###] ### ##

  DATA: LT_DYNP_UPDATE TYPE TABLE OF DYNPREAD,

        LS_DYNP_UPDATE TYPE DYNPREAD.



  " -------------------------------------------------------

  " 1. ## ##(ZAMOUNT) ## # ## ## (## ## ##)

  " -------------------------------------------------------

  CLEAR: LT_DYNP_READ, LS_DYNP_READ.

  LS_DYNP_READ-FIELDNAME = 'GS_AMOUNT_HEADER-ZAMOUNT'.

  APPEND LS_DYNP_READ TO LT_DYNP_READ.



  CALL FUNCTION 'DYNP_VALUES_READ'

    EXPORTING

      DYNAME               = SY-REPID

      DYNUMB               = SY-DYNNR

    TABLES

      DYNPFIELDS           = LT_DYNP_READ

    EXCEPTIONS

      OTHERS               = 1.



  IF SY-SUBRC = 0.

    READ TABLE LT_DYNP_READ INTO LS_DYNP_READ INDEX 1.

    IF LS_DYNP_READ-FIELDVALUE IS NOT INITIAL.

      LV_ZAMOUNT_CHAR = LS_DYNP_READ-FIELDVALUE.

      REPLACE ALL OCCURRENCES OF ',' IN LV_ZAMOUNT_CHAR WITH ''.

      GS_AMOUNT_HEADER-ZAMOUNT = LV_ZAMOUNT_CHAR.

      GV_SAVED_ZAMOUNT = GS_AMOUNT_HEADER-ZAMOUNT.

    ENDIF.

  ENDIF.



  " -------------------------------------------------------

  " 2. ## ## (## ## ##)

  " -------------------------------------------------------

  CLEAR LV_TOTAL_ITEM_AMT.

  LOOP AT GT_ITEM INTO GS_ITEM WHERE CHECK = 'X'.

    LV_TOTAL_ITEM_AMT = LV_TOTAL_ITEM_AMT + GS_ITEM-DMBTR.

  ENDLOOP.



  IF GS_AMOUNT_HEADER-ZAMOUNT IS INITIAL.

    GS_AMOUNT_HEADER-ZBALANCE = 0 - LV_TOTAL_ITEM_AMT.

  ELSE.

    GS_AMOUNT_HEADER-ZBALANCE = GS_AMOUNT_HEADER-ZAMOUNT - LV_TOTAL_ITEM_AMT.

  ENDIF.



  IF GS_AMOUNT_HEADER-ZAMOUNT IS INITIAL AND LV_TOTAL_ITEM_AMT IS INITIAL.

     GS_AMOUNT_HEADER-ICON = C_YELLOW.

  ELSEIF GS_AMOUNT_HEADER-ZBALANCE = 0.

     GS_AMOUNT_HEADER-ICON = C_GREEN.

  ELSE.

     GS_AMOUNT_HEADER-ICON = C_RED.

  ENDIF.



  " -------------------------------------------------------

  " [## ##] 3. ### ### ### ## ## (DYNP_VALUES_UPDATE)

  " -------------------------------------------------------

  CLEAR: LT_DYNP_UPDATE, LS_DYNP_UPDATE.



  " (1) ## (ZBALANCE) ####

  LS_DYNP_UPDATE-FIELDNAME = 'GS_AMOUNT_HEADER-ZBALANCE'.



  " ## ### ## ##(### ##)# ### ## # #### #

  WRITE GS_AMOUNT_HEADER-ZBALANCE TO LS_DYNP_UPDATE-FIELDVALUE

                                  CURRENCY GS_AMOUNT_HEADER-WAERS.

  " ## ### ### ### ## (####)

  CONDENSE LS_DYNP_UPDATE-FIELDVALUE NO-GAPS.

  APPEND LS_DYNP_UPDATE TO LT_DYNP_UPDATE.



  " (2) ### (ICON) ####

  CLEAR LS_DYNP_UPDATE.

  LS_DYNP_UPDATE-FIELDNAME = 'GS_AMOUNT_HEADER-ICON'.

  LS_DYNP_UPDATE-FIELDVALUE = GS_AMOUNT_HEADER-ICON.

  APPEND LS_DYNP_UPDATE TO LT_DYNP_UPDATE.



  " (3) ## ## #### ##

  CALL FUNCTION 'DYNP_VALUES_UPDATE'

    EXPORTING

      DYNAME               = SY-REPID

      DYNUMB               = SY-DYNNR

    TABLES

      DYNPFIELDS           = LT_DYNP_UPDATE

    EXCEPTIONS

      OTHERS               = 1.



  " 4. OK ## ### (PAI# ## ## ## - ##)

  CALL METHOD CL_GUI_CFW=>SET_NEW_OK_CODE

    EXPORTING NEW_CODE = 'DUMMY'.

  CALL METHOD CL_GUI_CFW=>FLUSH.

ENDFORM.




*FORM CALCULATE_TOTAL_BALANCE.

*  DATA: LV_TOTAL_ITEM_AMT TYPE BSIK-DMBTR.

*  DATA: LT_DYNP TYPE TABLE OF DYNPREAD,

*        LS_DYNP TYPE DYNPREAD.

*  DATA: LV_ZAMOUNT_CHAR(20) TYPE C.

*

*  CLEAR: LT_DYNP, LS_DYNP.

*  LS_DYNP-FIELDNAME = 'GS_AMOUNT_HEADER-ZAMOUNT'. "## ###

*  APPEND LS_DYNP TO LT_DYNP.

*

*  CALL FUNCTION 'DYNP_VALUES_READ'

*    EXPORTING

*      DYNAME               = SY-REPID

*      DYNUMB               = SY-DYNNR

*    TABLES

*      DYNPFIELDS           = LT_DYNP

*    EXCEPTIONS

*      INVALID_ABAPWORKAREA = 1

*      INVALID_DYNPROFIELD  = 2

*      INVALID_DYNPRONAME   = 3

*      INVALID_DYNPRONUMMER = 4

*      INVALID_REQUEST      = 5

*      NO_FIELDDESCRIPTION  = 6

*      INVALID_PARAMETER    = 7

*      UNDEFIND_ERROR       = 8

*      DOUBLE_CONVERSION    = 9

*      STEPL_NOT_FOUND      = 10

*      OTHERS               = 11.

*

*  IF SY-SUBRC = 0.

*    READ TABLE LT_DYNP INTO LS_DYNP INDEX 1.

*    IF LS_DYNP-FIELDVALUE IS NOT INITIAL.

*       ### #(###)# ## ## (### ## ## #)

*      LV_ZAMOUNT_CHAR = LS_DYNP-FIELDVALUE.

*

*       ### ### ## (## ## ## ## ##)

*      REPLACE ALL OCCURRENCES OF ',' IN LV_ZAMOUNT_CHAR WITH ''.

*

*       #### ### ##

*      GS_AMOUNT_HEADER-ZAMOUNT = LV_ZAMOUNT_CHAR.

*

*       ## ## #### ##

*      GV_SAVED_ZAMOUNT = GS_AMOUNT_HEADER-ZAMOUNT.

*    ENDIF.

*  ENDIF.

*

*  CLEAR LV_TOTAL_ITEM_AMT.

*  LOOP AT GT_ITEM INTO GS_ITEM WHERE CHECK = 'X'.

*    LV_TOTAL_ITEM_AMT = LV_TOTAL_ITEM_AMT + GS_ITEM-DMBTR.

*  ENDLOOP.

*

*  IF GS_AMOUNT_HEADER-ZAMOUNT IS INITIAL.

*    GS_AMOUNT_HEADER-ZBALANCE = 0 - LV_TOTAL_ITEM_AMT.

*  ELSE.

*    GS_AMOUNT_HEADER-ZBALANCE = GS_AMOUNT_HEADER-ZAMOUNT - LV_TOTAL_ITEM_AMT.

*  ENDIF.

*

*  IF GS_AMOUNT_HEADER-ZAMOUNT IS INITIAL AND LV_TOTAL_ITEM_AMT IS INITIAL.

*     GS_AMOUNT_HEADER-ICON = C_YELLOW. " # # 0## ##

*

*  ELSEIF GS_AMOUNT_HEADER-ZBALANCE = 0.

*     GS_AMOUNT_HEADER-ICON = C_GREEN.

*

*  ELSE.

*     GS_AMOUNT_HEADER-ICON = C_RED.

*  ENDIF.

*

*   4. ## ##

*  CALL METHOD CL_GUI_CFW=>SET_NEW_OK_CODE

*    EXPORTING NEW_CODE = 'DUMMY'.

*ENDFORM.



*&---------------------------------------------------------------------*

*&      Form  SET_FIELDCAT

*&---------------------------------------------------------------------*




FORM SET_FIELDCAT .

  DATA: LS_FCAT TYPE LVC_S_FCAT.



  CLEAR: GT_FIELDCAT.



  " 1. #### (CHECK)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'CHECK'.

  LS_FCAT-COLTEXT   = '##'.

  LS_FCAT-CHECKBOX  = 'X'.    " #### ##

  LS_FCAT-EDIT      = 'X'.    " ## ##

  APPEND LS_FCAT TO GT_FIELDCAT.



  " 2. PO ## (EBELN)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'EBELN'.

  LS_FCAT-COLTEXT   = '####'.

  APPEND LS_FCAT TO GT_FIELDCAT.



  " 3. PO ## (EBELP)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'EBELP'.

  LS_FCAT-COLTEXT   = '##'.

  APPEND LS_FCAT TO GT_FIELDCAT.



  " 4. ### (TXZ01)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'TXZ01'.

  LS_FCAT-COLTEXT   = '####'.

  LS_FCAT-OUTPUTLEN = 20.

  APPEND LS_FCAT TO GT_FIELDCAT.



  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'POMENGE'.

  LS_FCAT-COLTEXT   = '####'.

  LS_FCAT-QFIELDNAME = 'MEINS'. " ## ## ##

  LS_FCAT-NO_CONVEXT = 'X'.

  APPEND LS_FCAT TO GT_FIELDCAT.



  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'IV_BELNR'.

  LS_FCAT-COLTEXT   = '#####'.

  LS_FCAT-EMPHASIZE  = 'C700'.  " ## ## (### ##)

  APPEND LS_FCAT TO GT_FIELDCAT.



  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'IV_MENGE'.

  LS_FCAT-COLTEXT   = '#####'.

  LS_FCAT-QFIELDNAME = 'MEINS'.

  LS_FCAT-EMPHASIZE  = 'C700'.  " ## ## (### ##)

  LS_FCAT-NO_CONVEXT = 'X'.

  APPEND LS_FCAT TO GT_FIELDCAT.



  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'REMENGE'.

  LS_FCAT-COLTEXT   = '####'.

  LS_FCAT-QFIELDNAME = 'MEINS'.

  LS_FCAT-EMPHASIZE  = 'C500'.  " ## ## (### ##)

  LS_FCAT-NO_CONVEXT = 'X'.

  APPEND LS_FCAT TO GT_FIELDCAT.



  " 7. [##] ## ## (MENGE) - ###

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'MENGE'.

  LS_FCAT-COLTEXT   = '####'.

  LS_FCAT-QFIELDNAME = 'MEINS'.

  LS_FCAT-EDIT       = 'X'.

  LS_FCAT-NO_CONVEXT = 'X'.

  LS_FCAT-DATATYPE   = 'QUAN'.

  LS_FCAT-DECIMALS   = '3'.

  LS_FCAT-INTLEN     = '13'.

  APPEND LS_FCAT TO GT_FIELDCAT.



  " 8. ## (MEINS)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'MEINS'.

  LS_FCAT-COLTEXT   = '##'.

  APPEND LS_FCAT TO GT_FIELDCAT.



  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'WAERS'.

  LS_FCAT-COLTEXT   = '##'.

  APPEND LS_FCAT TO GT_FIELDCAT.



  " 9. ## (STPRS)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME  = 'STPRS'.

  LS_FCAT-COLTEXT    = '##'.

  LS_FCAT-REF_TABLE  = 'ZEKPO_05'.

  LS_FCAT-REF_FIELD  = 'STPRS'.

  LS_FCAT-EDIT       = 'X'.       " ## ##

  LS_FCAT-DATATYPE   = 'CURR'.    " ## ## ##

  APPEND LS_FCAT TO GT_FIELDCAT.



  " 10. #### (WRBTR) - ####

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME  = 'WRBTR'.

  LS_FCAT-COLTEXT    = '####'.

  LS_FCAT-CFIELDNAME = 'WAERS'.

  LS_FCAT-REF_TABLE  = 'ZRSEG_05'.

  LS_FCAT-REF_FIELD  = 'WRBTR'.

  APPEND LS_FCAT TO GT_FIELDCAT.



  " 11. ## (WMWST) - ####

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'WMWST'.

  LS_FCAT-COLTEXT   = '##'.

  LS_FCAT-CFIELDNAME = 'WAERS'.

  APPEND LS_FCAT TO GT_FIELDCAT.



  " 12. ## (DMBTR) - ####

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'DMBTR'.

  LS_FCAT-COLTEXT   = '####'.




*  LS_FCAT-CFIELDNAME = 'WAERS'.




  LS_FCAT-EMPHASIZE  = 'C300'. " ## ## (### ##)

  APPEND LS_FCAT TO GT_FIELDCAT.



ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  SET_ALV_LAYOUT

*&---------------------------------------------------------------------*




FORM SET_ALV_LAYOUT .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA      = 'X'.       " ### ##

  GS_LAYOUT-CWIDTH_OPT = 'X'.       " ## ## ## ###

  GS_LAYOUT-SEL_MODE   = 'D'.       " # ## ## ##

  GS_LAYOUT-NO_TOOLBAR = 'X'.       " ## ##

  GS_LAYOUT-GRID_TITLE = '## ## ##'.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  DISPLAY_ALV

*&---------------------------------------------------------------------*




FORM DISPLAY_ALV .



  " 1. #### ## (## ##)

  IF GC_CUSTOM IS INITIAL.

    CREATE OBJECT GC_CUSTOM

      EXPORTING

        CONTAINER_NAME = 'CUSTOM1'. " ### 100## ### ## ##



    CREATE OBJECT GC_GRID

      EXPORTING

        I_PARENT = GC_CUSTOM.



    " 1) ### ## ## ##

    CREATE OBJECT GO_EVENT.



    " 2) #### ### ### ##

    SET HANDLER GO_EVENT->HANDLE_DATA_CHANGED FOR GC_GRID.



    " 3) ### ## # ##(Enter) ### ### #### ##

    CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

      EXPORTING

        I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.

    CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

      EXPORTING

        I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_ENTER.

    " -----------------------------------------------------------



    " ## #### # #### ##

    PERFORM SET_FIELDCAT.

    PERFORM SET_ALV_LAYOUT.



    " ALV ##

    CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

      EXPORTING

        IS_LAYOUT       = GS_LAYOUT

      CHANGING

        IT_OUTTAB       = GT_ITEM      " ### ###

        IT_FIELDCATALOG = GT_FIELDCAT. " ## ##



  ELSE.

    " ## #### ### #### ####

    PERFORM REFRESH_ALV.

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  REFRESH_ALV

*&---------------------------------------------------------------------*




FORM REFRESH_ALV.

  DATA: LS_STABLE TYPE LVC_S_STBL.



  " [##] #### #### ##

  IF GC_GRID IS INITIAL.

    RETURN.

  ENDIF.



  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE = LS_STABLE.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SAVE_DATA

*&---------------------------------------------------------------------*




FORM SAVE_DATA.

  DATA: LV_ANSWER TYPE C.



  " 1. [## ##] #### ## ##

  DATA: LS_ZRBKP TYPE ZRBKP_05,

        LS_ZRSEG TYPE ZRSEG_05,

        LS_ZBKPF TYPE ZBKPF_05,

        LS_ZBSEG TYPE ZBSEG_05,

        LS_ZBSIK TYPE ZBSIK_05.



  " 2. [## ##] ## ### # ## ###

  DATA: LV_MM_BELNR TYPE ZRBKP_05-BELNR, " ## ## ##

        LV_FI_BELNR TYPE ZBKPF_05-BELNR, " ## ## ##

        LV_BUZEI    TYPE ZBSEG_05-BUZEI, " ### ##

        LV_ZFBDT    TYPE ZBSIK_05-ZFBDT. " ## ###



  " 3. [## ##] ### Insert# Internal Table

  DATA: LT_ZRSEG TYPE TABLE OF ZRSEG_05,

        LT_ZBSEG TYPE TABLE OF ZBSEG_05.

  DATA: LV_DATE TYPE SY-DATUM.

  DATA: LV_TOTAL_MWSTS TYPE ZRBKP_05-WMWST.



  " ===========================================================

  " 1. ### ##

  " ===========================================================

  IF GS_AMOUNT_HEADER-ICON <> C_GREEN.

    MESSAGE '### #### ####. ### ######.' TYPE 'E'.

    EXIT.

  ENDIF.



  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      TITLEBAR      = '## ##'

      TEXT_QUESTION = '## # ## ### ########?'

    IMPORTING

      ANSWER        = LV_ANSWER.



  IF LV_ANSWER <> '1'.

    MESSAGE '#######.' TYPE 'S'.

    EXIT.

  ENDIF.



  " ===========================================================

  " 2. ## ## ## (MAX + 1 ##)

  " ===========================================================

  " 2-1. ## ## ## (5200... ##) - ### ## ##

  SELECT MAX( BELNR ) INTO LV_MM_BELNR FROM ZRBKP_05.

  IF LV_MM_BELNR IS INITIAL.

    LV_MM_BELNR = '5000000000'.

  ELSE.

    LV_MM_BELNR = LV_MM_BELNR + 1.

  ENDIF.



  " 2-2. ## ## ## (RE ### # 5000000000## ##) - ### ##

  SELECT MAX( BELNR ) INTO LV_FI_BELNR

    FROM ZBKPF_05

    WHERE BLART = 'RE'.

  IF LV_FI_BELNR IS INITIAL.

    LV_FI_BELNR = '5000000000'.

  ELSE.

    LV_FI_BELNR = LV_FI_BELNR + 1.

  ENDIF.



  " 2-3. #####(ZFBDT) ##: ###### # ## - ### ##

  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING

      DAY_IN            = P_DATE

    IMPORTING

      LAST_DAY_OF_MONTH = LV_ZFBDT

    EXCEPTIONS

      DAY_IN_NO_DATE    = 1

      OTHERS            = 2.

  IF SY-SUBRC <> 0.

    LV_ZFBDT = P_DATE. " ## ### #####

  ENDIF.



  " ===========================================================

  " 3. ### ## - ##(MM) ##

  " ===========================================================



  CLEAR LS_ZRBKP.



  " 1) ## ## ## ### (## ## ##)

  CLEAR LV_TOTAL_MWSTS.

  LOOP AT GT_ITEM INTO GS_ITEM WHERE CHECK = 'X'.

    LV_TOTAL_MWSTS = LV_TOTAL_MWSTS + GS_ITEM-WMWST.

  ENDLOOP.



  CLEAR LS_ZRBKP.

  LS_ZRBKP-BELNR = LV_MM_BELNR.

  LS_ZRBKP-GJAHR = P_DATE(4).

  LS_ZRBKP-BLART = 'RE'.

  LS_ZRBKP-BLDAT = P_DATE.

  LS_ZRBKP-BUDAT = P_DATE.

  LS_ZRBKP-BUKRS = GS_COMMON_HEADER-BUKRS." ####

  LS_ZRBKP-LIFNR = GS_COMMON_HEADER-LIFNR." ###

  LS_ZRBKP-WAERS = GS_AMOUNT_HEADER-WAERS." ##

  LS_ZRBKP-RMWWR = GS_AMOUNT_HEADER-ZAMOUNT. " ###





  LS_ZRBKP-ZTERM = GS_COMMON_HEADER-ZTERM. " ZLFB1_05## ### #

  LS_ZRBKP-BKTXT = '## ##'.            " ## (## ##)

  LS_ZRBKP-XMWST = 'X'.                    " #### ##

  LS_ZRBKP-MWSKZ = GS_AMOUNT_HEADER-MWSKZ. " ## ####

  LS_ZRBKP-WMWST = LV_TOTAL_MWSTS.

  LS_ZRBKP-EBELN  = P_EBELN.

  LS_ZRBKP-WERKS  = P_WERKS.

  LS_ZRBKP-STBLG  = ''.        " ## ##(##)

  LS_ZRBKP-RBSTAT = '1'.       " ##(#: ##/##)



  " [ZRSEG_05 : ## ###]

  REFRESH LT_ZRSEG.

  LV_BUZEI = 0.



  LOOP AT GT_ITEM INTO GS_ITEM WHERE CHECK = 'X'.

    LV_BUZEI = LV_BUZEI + 1.

    CLEAR LS_ZRSEG.



    MOVE-CORRESPONDING GS_ITEM TO LS_ZRSEG.



    LS_ZRSEG-BELNR = LV_MM_BELNR.

    LS_ZRSEG-GJAHR = P_DATE(4).

    LS_ZRSEG-BUZEI = LV_BUZEI.

    LS_ZRSEG-BUKRS = GS_COMMON_HEADER-BUKRS.



    " === [##/##] MOVE ### LS_ZRSEG# ## ### DB# ### ===



    LS_ZRSEG-MWSKZ = GS_AMOUNT_HEADER-MWSKZ.



    " ##(BSTME)

    IF LS_ZRSEG-BSTME IS INITIAL.

      LS_ZRSEG-BSTME = GS_ITEM-MEINS.

    ENDIF.



    " ###(SGTXT)

    IF LS_ZRSEG-SGTXT IS INITIAL.

      LS_ZRSEG-SGTXT = GS_ITEM-SGTXT.

      IF LS_ZRSEG-SGTXT IS INITIAL.

        LS_ZRSEG-SGTXT = '## ##'.

      ENDIF.

    ENDIF.



    " ## ## #### ##

    IF LS_ZRSEG-WAERS IS INITIAL.

      LS_ZRSEG-WAERS = GS_AMOUNT_HEADER-WAERS.

    ENDIF.



    LS_ZRSEG-SHKZG = 'S'.



    APPEND LS_ZRSEG TO LT_ZRSEG.

  ENDLOOP.



  " ===========================================================

  " 4. ### ## - ##(FI) ## (Simulate)

  " ===========================================================

  CLEAR LS_ZBKPF.

  LS_ZBKPF-BELNR = LV_FI_BELNR.

  LS_ZBKPF-GJAHR = P_DATE(4).

  LS_ZBKPF-BLART = 'RE'.

  LS_ZBKPF-BUDAT = P_DATE.

  LS_ZBKPF-BLDAT = P_DATE.

  LS_ZBKPF-BUKRS = GS_COMMON_HEADER-BUKRS.

  LS_ZBKPF-WAERS = GS_AMOUNT_HEADER-WAERS.

  LS_ZBKPF-AWKEY = LV_MM_BELNR.



  CLEAR LS_ZBSIK.

  LS_ZBSIK-BUKRS = GS_COMMON_HEADER-BUKRS.

  LS_ZBSIK-LIFNR = GS_COMMON_HEADER-LIFNR.

  LS_ZBSIK-GJAHR = P_DATE(4).

  LS_ZBSIK-BELNR = LV_FI_BELNR.

  LS_ZBSIK-BUDAT = P_DATE.

  LS_ZBSIK-BLDAT = P_DATE.

  LS_ZBSIK-WAERS = GS_AMOUNT_HEADER-WAERS.

  LS_ZBSIK-BLART = 'RE'.

  LS_ZBSIK-SHKZG = 'H'.                   " ##(Credit)

  LS_ZBSIK-GSBER = ' '.                   " #### (### ##)

  LS_ZBSIK-MWSKZ = GS_AMOUNT_HEADER-MWSKZ.

  LS_ZBSIK-DMBTR = GS_AMOUNT_HEADER-ZAMOUNT. " # ###

  LS_ZBSIK-MWSTS = GS_AMOUNT_HEADER-ZAMOUNT - ( GS_AMOUNT_HEADER-ZAMOUNT / ( 1 + ( GV_TAX_RATE ) ) ).

  " # ### ## ALV ## ### ### ###. ## #### ##

  DATA: LV_TOTAL_TAX TYPE BSIK-MWSTS.

  LOOP AT GT_ITEM INTO GS_ITEM WHERE CHECK = 'X'.

      LV_TOTAL_TAX = LV_TOTAL_TAX + GS_ITEM-WMWST.

  ENDLOOP.

  LS_ZBSIK-MWSTS = LV_TOTAL_TAX.          " [####] ## ##

  LS_ZBSIK-SGTXT = GS_AMOUNT_HEADER-ZMEMO." ##

  LS_ZBSIK-ZFBDT = LV_ZFBDT.              " [####] #####



  " [ZBSEG_05 : ## ### ##]

  REFRESH LT_ZBSEG.



  " (1) ## ## (####) - ZBSIK ### ##

  CLEAR LS_ZBSEG.

  LS_ZBSEG-BELNR = LV_FI_BELNR.

  LS_ZBSEG-GJAHR = P_DATE(4).

  LS_ZBSEG-BUZEI = '001'.

  LS_ZBSEG-BUKRS = GS_COMMON_HEADER-BUKRS.

  LS_ZBSEG-SHKZG = 'H'.                   " ##

  LS_ZBSEG-DMBTR = GS_AMOUNT_HEADER-ZAMOUNT.

  LS_ZBSEG-HKONT = GS_COMMON_HEADER-LIFNR." [####] G/L## ## ######(##)

  APPEND LS_ZBSEG TO LT_ZBSEG.



  " (2) ## ## (## ##)

  LV_BUZEI = 1.

  LOOP AT GT_ITEM INTO GS_ITEM WHERE CHECK = 'X'.

    LV_BUZEI = LV_BUZEI + 1.

    CLEAR LS_ZBSEG.



    LS_ZBSEG-BELNR = LV_FI_BELNR.

    LS_ZBSEG-GJAHR = P_DATE(4).

    LS_ZBSEG-BUZEI = LV_BUZEI.

    LS_ZBSEG-BUKRS = GS_COMMON_HEADER-BUKRS.

    LS_ZBSEG-SHKZG = 'S'.                 " ##

    LS_ZBSEG-DMBTR = GS_ITEM-WRBTR.       " ####

    LS_ZBSEG-HKONT = '400000'.

    LS_ZBSEG-MATNR = GS_ITEM-MATNR.

    LS_ZBSEG-WERKS = GS_ITEM-WERKS.

    LS_ZBSEG-EBELN = GS_ITEM-EBELN.

    LS_ZBSEG-EBELP = GS_ITEM-EBELP.

    LS_ZBSEG-MWSKZ = GS_ITEM-MWSKZ.

    APPEND LS_ZBSEG TO LT_ZBSEG.



    " (3) ## ## (##)

    IF GS_ITEM-WMWST > 0.

      LV_BUZEI = LV_BUZEI + 1.

      CLEAR LS_ZBSEG.

      LS_ZBSEG-BELNR = LV_FI_BELNR.

      LS_ZBSEG-GJAHR = P_DATE(4).

      LS_ZBSEG-BUZEI = LV_BUZEI.

      LS_ZBSEG-BUKRS = GS_COMMON_HEADER-BUKRS.

      LS_ZBSEG-SHKZG = 'S'.               " ##

      LS_ZBSEG-DMBTR = GS_ITEM-WMWST.     " ##

      LS_ZBSEG-HKONT = '100000'.

      LS_ZBSEG-MWSKZ = GS_ITEM-MWSKZ.

      APPEND LS_ZBSEG TO LT_ZBSEG.

    ENDIF.

  ENDLOOP.



  " ===========================================================

  " 5. DB ## (INSERT)

  " ===========================================================

  INSERT ZRBKP_05 FROM LS_ZRBKP.

  INSERT ZRSEG_05 FROM TABLE LT_ZRSEG.

  INSERT ZBKPF_05 FROM LS_ZBKPF.

  INSERT ZBSIK_05 FROM LS_ZBSIK.

  INSERT ZBSEG_05 FROM TABLE LT_ZBSEG.



  IF SY-SUBRC = 0.

    COMMIT WORK AND WAIT.

    MESSAGE S003 WITH '##' LV_MM_BELNR '####' LV_FI_BELNR.

    LEAVE TO SCREEN 0.

  ELSE.

    ROLLBACK WORK.

    MESSAGE '## # ### ######.' TYPE 'E'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DISPLAY_ALV_200

*&---------------------------------------------------------------------*




FORM DISPLAY_ALV_200.

  " 1. #### ## (## ##)

  IF GC_DOCKING_200 IS INITIAL.

    CREATE OBJECT GC_DOCKING_200

      EXPORTING

        SIDE      = CL_GUI_DOCKING_CONTAINER=>DOCK_AT_BOTTOM

        EXTENSION = 2000. " ## ## ##



    CREATE OBJECT GC_GRID_200

      EXPORTING

        I_PARENT = GC_DOCKING_200.



    " 2. ## #### ## (## ##)

    PERFORM SET_FIELDCAT_200.



    " 3. #### ##

    PERFORM SET_ALV_LAYOUT.



    " 4. ALV ##

    CALL METHOD GC_GRID_200->SET_TABLE_FOR_FIRST_DISPLAY

      EXPORTING

        IS_LAYOUT       = GS_LAYOUT

      CHANGING

        IT_OUTTAB       = GT_ITEM      " GET_INVOICE_DATA## ## ###

        IT_FIELDCATALOG = GT_FIELDCAT.



  ELSE.

    " ## ### ### ####

    PERFORM REFRESH_ALV_200.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  REFRESH_ALV_200

*&---------------------------------------------------------------------*




FORM REFRESH_ALV_200.

  DATA: LS_STABLE TYPE LVC_S_STBL.

  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GC_GRID_200->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE = LS_STABLE.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SET_FIELDCAT_200

*&---------------------------------------------------------------------*




FORM SET_FIELDCAT_200.

  DATA: LS_FCAT TYPE LVC_S_FCAT.

  CLEAR GT_FIELDCAT.



  " 1. ## #### (#### ## ##)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'CHECK'.

  LS_FCAT-COLTEXT   = '##'.

  LS_FCAT-CHECKBOX  = 'X'.

  LS_FCAT-EDIT      = 'X'.    " ## ### #### ### ## ##

  APPEND LS_FCAT TO GT_FIELDCAT.



  " 2. #### (BELNR) - ## ##

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'BELNR'.

  LS_FCAT-COLTEXT   = '####'.

  LS_FCAT-EMPHASIZE = 'C100'. " ## ### ##

  LS_FCAT-KEY       = 'X'.    " ## ### # ##

  LS_FCAT-OUTPUTLEN = 10.

  APPEND LS_FCAT TO GT_FIELDCAT.



  " 3. #### (GJAHR)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'GJAHR'.

  LS_FCAT-COLTEXT   = '##'.

  LS_FCAT-OUTPUTLEN = 4.

  APPEND LS_FCAT TO GT_FIELDCAT.



  " 4. #### ## (EBELN)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'EBELN'.

  LS_FCAT-COLTEXT   = '####'.

  LS_FCAT-EMPHASIZE = 'C700'. " ## ### (## ###)

  APPEND LS_FCAT TO GT_FIELDCAT.



  " 5. PO ## (EBELP)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'EBELP'.

  LS_FCAT-COLTEXT   = '##'.

  APPEND LS_FCAT TO GT_FIELDCAT.



  " 6. #### (MATNR)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'MATNR'.

  LS_FCAT-COLTEXT   = '####'.

  APPEND LS_FCAT TO GT_FIELDCAT.



  " 7. #### (TXZ01)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'TXZ01'.

  LS_FCAT-COLTEXT   = '####'.

  LS_FCAT-OUTPUTLEN = 20.

  APPEND LS_FCAT TO GT_FIELDCAT.



  " 8. ### (WERKS)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'WERKS'.

  LS_FCAT-COLTEXT   = '###'.

  APPEND LS_FCAT TO GT_FIELDCAT.



  " 9. ## ## (MENGE) - ## ##

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'MENGE'.

  LS_FCAT-COLTEXT   = '####'.

  LS_FCAT-QFIELDNAME = 'MEINS'. " ## ## ## (##)

  LS_FCAT-DATATYPE   = 'QUAN'.  " ## ## ##

  APPEND LS_FCAT TO GT_FIELDCAT.



  " 10. ## (MEINS)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'MEINS'.

  LS_FCAT-COLTEXT   = '##'.

  APPEND LS_FCAT TO GT_FIELDCAT.



  " 11. ## (WAERS)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'WAERS'.

  LS_FCAT-COLTEXT   = '##'.

  APPEND LS_FCAT TO GT_FIELDCAT.



  " 12. #### (WRBTR) - ## ##

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME  = 'WRBTR'.

  LS_FCAT-COLTEXT    = '####'.

  LS_FCAT-CFIELDNAME = 'WAERS'. " ## ## ## (##)

  LS_FCAT-DATATYPE   = 'CURR'.  " ## ## ##

  APPEND LS_FCAT TO GT_FIELDCAT.



  " 13. ## (WMWST) - ## ##

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME  = 'WMWST'.

  LS_FCAT-COLTEXT    = '##'.

  LS_FCAT-CFIELDNAME = 'WAERS'.

  LS_FCAT-DATATYPE   = 'CURR'.

  APPEND LS_FCAT TO GT_FIELDCAT.



  " 14. #### (DMBTR) - ## ## # ##

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME  = 'DMBTR'.

  LS_FCAT-COLTEXT    = '####'.

  LS_FCAT-CFIELDNAME = 'WAERS'.

  LS_FCAT-DATATYPE   = 'CURR'.

  LS_FCAT-EMPHASIZE  = 'C300'. " ### ## (## ###)

  APPEND LS_FCAT TO GT_FIELDCAT.



  " 15. #### (MWSKZ)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'MWSKZ'.

  LS_FCAT-COLTEXT   = '####'.

  APPEND LS_FCAT TO GT_FIELDCAT.



  " 16. ### (LIFNR)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'LIFNR'.

  LS_FCAT-COLTEXT   = '###'.

  APPEND LS_FCAT TO GT_FIELDCAT.



ENDFORM.










*&---------------------------------------------------------------------*

*&      Form  DELETE_INVOICE_DATA

*&---------------------------------------------------------------------*




FORM DELETE_INVOICE_DATA.

  DATA: LV_ANSWER TYPE C,

        LV_COUNT  TYPE I.



  CALL METHOD GC_GRID_200->CHECK_CHANGED_DATA.



  " 1. ### ## ##

  LOOP AT GT_ITEM TRANSPORTING NO FIELDS WHERE CHECK = 'X'.

    LV_COUNT = LV_COUNT + 1.

  ENDLOOP.



  IF LV_COUNT = 0.

    MESSAGE '### ### ######.' TYPE 'S' DISPLAY LIKE 'E'.

    EXIT.

  ENDIF.



  " 2. ## ##

  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      TITLEBAR      = '## ##'

      TEXT_QUESTION = '### ### ##(##)######? ### #### ### # ####.'

    IMPORTING

      ANSWER        = LV_ANSWER.



  IF LV_ANSWER <> '1'.

    EXIT.

  ENDIF.



  " 3. ## ## (#### ## ##)

  DATA: LT_DEL_BELNR TYPE TABLE OF ZRBKP_05-BELNR, " ### #### ##

        LV_BELNR     TYPE ZRBKP_05-BELNR.



  " ### ## ## ## (## ## ## # SORT/DELETE ADJACENT)

  LOOP AT GT_ITEM INTO GS_ITEM WHERE CHECK = 'X'.

    COLLECT GS_ITEM-BELNR INTO LT_DEL_BELNR.

  ENDLOOP.



  " 4. DB ## ##

  LOOP AT LT_DEL_BELNR INTO LV_BELNR.

    " [MM ### ##]

    DELETE FROM ZRBKP_05 WHERE BELNR = LV_BELNR. " ##

    DELETE FROM ZRSEG_05 WHERE BELNR = LV_BELNR. " ###



    " [FI ### ## - #### AWKEY# ###, ## ### FI### ##]

    " * ##: SAVE_DATA## ZBKPF-AWKEY# MM####(LV_BELNR)# ###### ## ### ####.



    " (1) ### ## ## ## ##

    DATA: LV_FI_BELNR TYPE ZBKPF_05-BELNR.

    SELECT SINGLE BELNR INTO LV_FI_BELNR

      FROM ZBKPF_05

      WHERE AWKEY = LV_BELNR. " ### = ####



    IF SY-SUBRC = 0.

      " (2) ## ## ### ##

      DELETE FROM ZBKPF_05 WHERE BELNR = LV_FI_BELNR.

      DELETE FROM ZBSEG_05 WHERE BELNR = LV_FI_BELNR.

      DELETE FROM ZBSIK_05 WHERE BELNR = LV_FI_BELNR.

    ENDIF.

  ENDLOOP.



  " 5. ## ##

  IF SY-SUBRC = 0.

    COMMIT WORK AND WAIT.

    MESSAGE '### ### ##### ##(##)#####.' TYPE 'S'.



    " 6. ## #### (### ## ####)

    PERFORM GET_INVOICE_DATA.

    PERFORM REFRESH_ALV_200.

  ELSE.

    ROLLBACK WORK.

    MESSAGE '## # ### ######.' TYPE 'E'.

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SIMULATE_POSTING

*&---------------------------------------------------------------------*




FORM SIMULATE_POSTING.

  " 1. ##### ### ### ##

  TYPES: BEGIN OF TY_SIM,

           SHKZG TYPE ZBSEG_05-SHKZG, " #/## ## (S:##, H:##)

           HKONT TYPE ZBSEG_05-HKONT, " G/L ## (## ####)

           SGTXT TYPE C LENGTH 50,    " ## (## ##)

           DMBTR TYPE ZBSEG_05-DMBTR, " ##

           WAERS TYPE ZBKPF_05-WAERS, " ##

           MATNR TYPE ZBSEG_05-MATNR, " #### (###)

           EBELN TYPE ZBSEG_05-EBELN, " #### (###)

         END OF TY_SIM.



  " ## ### (## ## vs ## ## ##)

  DATA: LV_TITLE TYPE LVC_TITLE.

  DATA: LV_BALANCE TYPE ZBSEG_05-DMBTR.

  DATA: LT_SIM TYPE TABLE OF TY_SIM,

        LS_SIM TYPE TY_SIM.



  DATA: LV_TOTAL_S TYPE ZBSEG_05-DMBTR, " ##(S) ##

        LV_TOTAL_H TYPE ZBSEG_05-DMBTR. " ##(H) ##

  CLEAR LS_SIM.

  LS_SIM-SHKZG = 'H'.                      " ##

  LS_SIM-HKONT = GS_COMMON_HEADER-LIFNR.   " ### ## (#: 1000)

  LS_SIM-SGTXT = |###: { GS_COMMON_HEADER-NAME1 }|.

  LS_SIM-DMBTR = GS_AMOUNT_HEADER-ZAMOUNT. " # ## ##

  LS_SIM-WAERS = GS_AMOUNT_HEADER-WAERS.

  APPEND LS_SIM TO LT_SIM.



  LV_TOTAL_H = LS_SIM-DMBTR. " ## ## ##



  " (2) ##(Debit, S) ## ##: ## ## (GR/IR)

  LOOP AT GT_ITEM INTO GS_ITEM WHERE CHECK = 'X'.

    CLEAR LS_SIM.

    LS_SIM-SHKZG = 'S'.                    " ##

    LS_SIM-HKONT = '1121501'.

    LS_SIM-SGTXT = |##: { GS_ITEM-TXZ01 }|.

    LS_SIM-DMBTR = GS_ITEM-WRBTR.          " #### (##)

    LS_SIM-WAERS = GS_ITEM-WAERS.

    LS_SIM-MATNR = GS_ITEM-MATNR.

    LS_SIM-EBELN = GS_ITEM-EBELN.

    APPEND LS_SIM TO LT_SIM.



    LV_TOTAL_S = LV_TOTAL_S + LS_SIM-DMBTR. " ## ## ##



    " (3) ##(Debit, S) ## ##: ### (### ## ###)

    IF GS_ITEM-WMWST > 0.

      CLEAR LS_SIM.

      LS_SIM-SHKZG = 'S'.                  " ##

      LS_SIM-HKONT = '1114301'.

      LS_SIM-SGTXT = |#### ({ GS_ITEM-MWSKZ })|.

      LS_SIM-DMBTR = GS_ITEM-WMWST.        " ##

      LS_SIM-WAERS = GS_ITEM-WAERS.

      LS_SIM-MATNR = GS_ITEM-MATNR.

      APPEND LS_SIM TO LT_SIM.



      LV_TOTAL_S = LV_TOTAL_S + LS_SIM-DMBTR. " ## ## ##

    ENDIF.

  ENDLOOP.



  " =======================================================

  " 4. ## ALV ## (##### ## ##)

  " =======================================================

  DATA: LT_FCAT TYPE SLIS_T_FIELDCAT_ALV,

        LS_FCAT TYPE SLIS_FIELDCAT_ALV.



  " ## #### ## (## ### ##)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'SHKZG'. LS_FCAT-SELTEXT_M = '#/#'.   LS_FCAT-JUST = 'C'. APPEND LS_FCAT TO LT_FCAT.

  LS_FCAT-FIELDNAME = 'HKONT'. LS_FCAT-SELTEXT_M = '##/#'. LS_FCAT-JUST = 'C'. APPEND LS_FCAT TO LT_FCAT.

  LS_FCAT-FIELDNAME = 'SGTXT'. LS_FCAT-SELTEXT_M = '##'.     LS_FCAT-OUTPUTLEN = 30. APPEND LS_FCAT TO LT_FCAT.

  LS_FCAT-FIELDNAME = 'MATNR'. LS_FCAT-SELTEXT_M = '##'.     APPEND LS_FCAT TO LT_FCAT.

  LS_FCAT-FIELDNAME = 'EBELN'. LS_FCAT-SELTEXT_M = '####'.  APPEND LS_FCAT TO LT_FCAT.

  LS_FCAT-FIELDNAME = 'WAERS'. LS_FCAT-SELTEXT_M = '##'.     APPEND LS_FCAT TO LT_FCAT.





  LV_BALANCE = LV_TOTAL_S - LV_TOTAL_H.



  LV_TITLE = |##### [ ##: { LV_TOTAL_S } / ##: { LV_TOTAL_H } / ##: { LV_BALANCE } ]|.



  " ## ## (Function ##)

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      I_CALLBACK_PROGRAM    = SY-REPID

      IT_FIELDCAT           = LT_FCAT

      I_GRID_TITLE          = LV_TITLE

      I_SCREEN_START_COLUMN = 5   " ## ## ##(#)

      I_SCREEN_START_LINE   = 5   " ## ## ##(#)

      I_SCREEN_END_COLUMN   = 200 " ## # ##(#)

      I_SCREEN_END_LINE     = 20  " ## # ##(#)

    TABLES

      T_OUTTAB              = LT_SIM

    EXCEPTIONS

      PROGRAM_ERROR         = 1

      OTHERS                = 2.



ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  UPDATE_TAX_CHANGE

*&---------------------------------------------------------------------*

* ## #### ## # ### ## ## # ###

*----------------------------------------------------------------------*




FORM UPDATE_TAX_CHANGE.



  " 1. ##### ## ##(ZMEMO) ### ## (GET_PO_HEADER ### ####)

  CASE GS_AMOUNT_HEADER-MWSKZ.

    WHEN 'V1'. GS_AMOUNT_HEADER-ZMEMO = '## 10%'.

    WHEN 'V2'. GS_AMOUNT_HEADER-ZMEMO = '####0%'.

    WHEN 'V3'. GS_AMOUNT_HEADER-ZMEMO = '####0%  '.

    WHEN 'V4'. GS_AMOUNT_HEADER-ZMEMO = '#####'.

    WHEN 'V5'. GS_AMOUNT_HEADER-ZMEMO = '######'.

    WHEN OTHERS. CLEAR GS_AMOUNT_HEADER-ZMEMO.

  ENDCASE.



  " 2. ALV ### ## ### #### ## # ###

  DATA: LV_CHANGED TYPE C.



  LOOP AT GT_ITEM INTO GS_ITEM.

    " ## #### ##### ### ### ####

    IF GS_ITEM-MWSKZ <> GS_AMOUNT_HEADER-MWSKZ.

      GS_ITEM-MWSKZ = GS_AMOUNT_HEADER-MWSKZ.



      " ## ### (#### * ##)

      PERFORM CALCULATE_AMOUNT CHANGING GS_ITEM.



      MODIFY GT_ITEM FROM GS_ITEM.

      LV_CHANGED = 'X'.

    ENDIF.

  ENDLOOP.



  " 3. ##### ### ## ### ### # ALV ##

  IF LV_CHANGED = 'X'.

    PERFORM SYNC_ITEM_TO_SOURCE. " ##(GR/PO) ##### ##

    PERFORM REFRESH_ALV.         " ## ##

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  APPLY_TAX_CHANGE

*&---------------------------------------------------------------------*

* ## ####(MWSKZ)# ### ### #### ## ###

*----------------------------------------------------------------------*




FORM APPLY_TAX_CHANGE.



  DATA: LV_CHANGED TYPE C.



  " 1. ## ##### ## ###(ZMEMO) ## (## ###)

  CASE GS_AMOUNT_HEADER-MWSKZ.

    WHEN 'V1'. GS_AMOUNT_HEADER-ZMEMO = '## 10%'.

    WHEN 'V2'. GS_AMOUNT_HEADER-ZMEMO = '####0%'.

    WHEN 'V3'. GS_AMOUNT_HEADER-ZMEMO = '####0%  '.

    WHEN 'V4'. GS_AMOUNT_HEADER-ZMEMO = '#####'.

    WHEN 'V5'. GS_AMOUNT_HEADER-ZMEMO = '######'.

    WHEN OTHERS. CLEAR GS_AMOUNT_HEADER-ZMEMO.

  ENDCASE.



  " 2. [##] GT_ITEM ## ### ## #### ##

  LOOP AT GT_ITEM INTO GS_ITEM.



    " ## #### ##### ### ### ## ##

    IF GS_ITEM-MWSKZ <> GS_AMOUNT_HEADER-MWSKZ.



      " (1) ### ##### ## ### ####

      GS_ITEM-MWSKZ = GS_AMOUNT_HEADER-MWSKZ.



      " (2) ## #### #### ##(WMWST) # ##(DMBTR) ###

      "     * ### #### CALCULATE_AMOUNT ## ######.

      PERFORM CALCULATE_AMOUNT CHANGING GS_ITEM.



      " (3) ### ### ### #### ##

      MODIFY GT_ITEM FROM GS_ITEM.



      LV_CHANGED = 'X'.

    ENDIF.



  ENDLOOP.



  " 3. ### ### ### ## ### ### # ## ##

  IF LV_CHANGED = 'X'.

    " GT_ITEM# ## ### GT_ITEM_GR ## GT_ITEM_PO## ##

    PERFORM SYNC_ITEM_TO_SOURCE.



    " ALV ## #### (### ##/## ## ##)

    PERFORM REFRESH_ALV.

  ENDIF.



ENDFORM.