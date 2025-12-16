
*&---------------------------------------------------------------------*

*& Include          ZMM10_IV_MGT_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*& Form CHECK_INPUT_DATA

*&---------------------------------------------------------------------*

*  ### ### ##

*----------------------------------------------------------------------*




FORM CHECK_INPUT_DATA.

  DATA: LS_EKKO TYPE ZEDT10_EKKO.



  " 1. #### ## ### ##

  " ZEDT10_EKKO ##### ## PO# ## ##### ## [4]

  IF S_EBELN[] IS NOT INITIAL.

    SELECT SINGLE EBELN

      INTO LS_EKKO-EBELN

      FROM ZEDT10_EKKO

      WHERE EBELN IN S_EBELN.



    IF SY-SUBRC <> 0.

      " ## ##### #### ####.

      MESSAGE '### #### ### #### ####.' TYPE 'E'.

    ENDIF.

  ENDIF.



  " 2. ##### ## (## ## ## # - ## # ##)

  IF P_BUDAT > SY-DATUM.

    MESSAGE '## #### ## ### # ####.' TYPE 'W'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*& Form GET_DATA

*&---------------------------------------------------------------------*




FORM GET_DATA.

  DATA: LV_IV_QTY     TYPE ZEDT10_EKBE-MENGE,

        LV_CANCEL_QTY TYPE ZEDT10_EKBE-MENGE,

        LV_TAX_RATE   TYPE ZEDT10_MWSKZ-KBETR. " ## ##



  CLEAR: GT_DATA.



  " =========================================================

  " CASE 1: [## ## ##] - ##### # ##

  " =========================================================

  IF R_CREA = 'X'.

    " 1. PO ### ##

    SELECT A~EBELN A~EBELP A~MATNR A~MAKTX A~WERKS A~LGORT

           A~MENGE A~MEINS A~NETPR

           B~BUKRS B~LIFNR B~WAERS

           C~MWSKZ

      INTO CORRESPONDING FIELDS OF TABLE GT_DATA

      FROM ZEDT10_EKPO AS A

      INNER JOIN ZEDT10_EKKO AS B ON A~EBELN = B~EBELN

      LEFT OUTER JOIN ZEDT10_LFM1 AS C

        ON B~LIFNR = C~LIFNR AND B~EKORG = C~EKORG

      WHERE A~EBELN IN S_EBELN.



    " 2. ### ## (## ## # ## #####)

    LOOP AT GT_DATA INTO GS_DATA.

      " (1) ### ## ## (EKBE)

      CLEAR: LV_IV_QTY, LV_CANCEL_QTY.

      SELECT SUM( MENGE ) INTO LV_IV_QTY FROM ZEDT10_EKBE

       WHERE EBELN = GS_DATA-EBELN AND EBELP = GS_DATA-EBELP

         AND VGABE = '2' AND SHKZG = 'S'.



      SELECT SUM( MENGE ) INTO LV_CANCEL_QTY FROM ZEDT10_EKBE

       WHERE EBELN = GS_DATA-EBELN AND EBELP = GS_DATA-EBELP

         AND VGABE = '2' AND SHKZG = 'H'.



      " ## ## = PO## - (## - ##)

      GS_DATA-MENGE = GS_DATA-MENGE - ( LV_IV_QTY - LV_CANCEL_QTY ).



      " ## ### ### #### ## (#### ###)

      IF GS_DATA-MENGE <= 0.

        DELETE GT_DATA.

        CONTINUE.

      ENDIF.



      " (2) #### # ## ##

      IF GS_DATA-MWSKZ IS INITIAL. GS_DATA-MWSKZ = 'V1'. ENDIF.



      CLEAR LV_TAX_RATE.

      SELECT SINGLE KBETR INTO LV_TAX_RATE FROM ZEDT10_MWSKZ

       WHERE MWSKZ = GS_DATA-MWSKZ.



      " (3) [##] ## ##### (## ##)

      " #### = ## ## * PO ##

      GS_DATA-WRBTR = GS_DATA-MENGE * GS_DATA-NETPR.

      " ## = #### * ##

      GS_DATA-MWSTS = GS_DATA-WRBTR * ( LV_TAX_RATE / 100 ).

      " ### = #### + ##

      GS_DATA-DMBTR = GS_DATA-WRBTR + GS_DATA-MWSTS.



      GS_DATA-ICON  = ICON_CREATE.

      MODIFY GT_DATA FROM GS_DATA.

    ENDLOOP.



    " =========================================================

    " CASE 2: [## ## ##] - ### # ### ##

    " =========================================================

  ELSEIF R_DISP = 'X'.

    " 1. ### ## ###(RSEG + RBKP) ##

    SELECT A~BELNR A~GJAHR A~BUZEI

           A~EBELN A~EBELP A~MATNR A~WERKS

           A~MENGE A~MEINS A~WRBTR A~MWSKZ A~SHKZG

                 A~MWSTS          " [##] ## (##### ## ##)

           A~DMBTR          " [##] ### (##### ## ##)

           B~BUKRS B~LIFNR B~WAERS B~BUDAT B~SGTXT

      INTO CORRESPONDING FIELDS OF TABLE GT_DATA

      FROM ZEDT10_RSEG AS A

      INNER JOIN ZEDT10_RBKP AS B

        ON A~BELNR = B~BELNR AND A~GJAHR = B~GJAHR

      WHERE A~EBELN IN S_EBELN

        AND B~BUDAT = P_BUDAT. " ## ##



    " 2. ## ### ## ## (### WRBTR ##)

    LOOP AT GT_DATA INTO GS_DATA.

      " ##(##)# ## ## #### ## (####)

      IF GS_DATA-SHKZG = 'H'.

        GS_DATA-WRBTR = GS_DATA-WRBTR * -1.

        GS_DATA-MWSTS = GS_DATA-MWSTS * -1.

        GS_DATA-DMBTR = GS_DATA-DMBTR * -1.

      ENDIF.



      GS_DATA-ICON  = ICON_CHECKED.

      MODIFY GT_DATA FROM GS_DATA.

    ENDLOOP.

  ENDIF.



  IF GT_DATA IS INITIAL.

    MESSAGE '#### ####.' TYPE 'S'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*& Form SET_FCAT

*&---------------------------------------------------------------------*




FORM SET_FCAT.

  DATA: LS_FCAT TYPE LVC_S_FCAT.



  CLEAR: GT_FCAT.



  " 1. #### (L_CHECK)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'L_CHECK'.

  LS_FCAT-COLTEXT   = '##'.

  LS_FCAT-CHECKBOX  = 'X'.

  LS_FCAT-EDIT      = 'X'.

  LS_FCAT-COL_POS   = 1.

  LS_FCAT-OUTPUTLEN = 5.

  APPEND LS_FCAT TO GT_FCAT.



  " 2. ## ### (ICON)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'ICON'.

  LS_FCAT-COLTEXT   = '##'.

  LS_FCAT-COL_POS   = 2.

  LS_FCAT-OUTPUTLEN = 4.

  LS_FCAT-ICON      = 'X'. " ##### ##

  APPEND LS_FCAT TO GT_FCAT.



  " 3. #### ## (EBELN)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'EBELN'.

  LS_FCAT-COLTEXT   = '####'.

  LS_FCAT-KEY       = 'X'. " ## ##

  LS_FCAT-COL_POS   = 3.

  LS_FCAT-OUTPUTLEN = 10.

  APPEND LS_FCAT TO GT_FCAT.



  " 4. ## ## (EBELP)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'EBELP'.

  LS_FCAT-COLTEXT   = '##'.

  LS_FCAT-KEY       = 'X'.

  LS_FCAT-COL_POS   = 4.

  LS_FCAT-OUTPUTLEN = 5.

  APPEND LS_FCAT TO GT_FCAT.



  " 5. #### (WRBTR) - ##: #### ##

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'WRBTR'.

  LS_FCAT-COLTEXT   = '####'.

  LS_FCAT-CFIELDNAME = 'WAERS'. " [##] ## ## ##

  LS_FCAT-COL_POS   = 10.

  LS_FCAT-OUTPUTLEN = 13.

  APPEND LS_FCAT TO GT_FCAT.



  " 6. #### (MWSKZ) - ##: ## ##

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'MWSKZ'.

  LS_FCAT-COLTEXT   = '####'.

  IF R_CREA = 'X'.

    LS_FCAT-EDIT      = 'X'.        " [## ##] ### ###

  ELSE.

    LS_FCAT-EDIT = ''.

  ENDIF.

  LS_FCAT-F4AVAILABL = 'X'.        " F4 ### ### (###)

  LS_FCAT-COL_POS   = 11.

  LS_FCAT-OUTPUTLEN = 4.

  LS_FCAT-JUST      = 'C'.

  APPEND LS_FCAT TO GT_FCAT.



  " 7. ## (MWSTS) - ##: #### ##

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'MWSTS'.

  LS_FCAT-COLTEXT   = '##'.

  LS_FCAT-CFIELDNAME = 'WAERS'. " [##]

  LS_FCAT-COL_POS   = 12.

  LS_FCAT-OUTPUTLEN = 13.

  APPEND LS_FCAT TO GT_FCAT.



  " 8. ### (DMBTR) - ##: #### ##

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'DMBTR'.

  LS_FCAT-COLTEXT   = '###'.

  LS_FCAT-CFIELDNAME = 'WAERS'. " [##]

  LS_FCAT-EMPHASIZE = 'C500'.   " ## ## (##)

  LS_FCAT-COL_POS   = 13.

  LS_FCAT-OUTPUTLEN = 13.

  APPEND LS_FCAT TO GT_FCAT.



  " 9. ## (WAERS)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'WAERS'.

  LS_FCAT-COLTEXT   = '##'.

  LS_FCAT-COL_POS   = 14.

  LS_FCAT-OUTPUTLEN = 5.

  APPEND LS_FCAT TO GT_FCAT.



  " 10. ## ## (MATNR)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'MATNR'.

  LS_FCAT-COLTEXT   = '####'.

  LS_FCAT-COL_POS   = 20.

  LS_FCAT-OUTPUTLEN = 18.

  APPEND LS_FCAT TO GT_FCAT.



  " 11. ## ## (MAKTX)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'MAKTX'.

  LS_FCAT-COLTEXT   = '####'.

  LS_FCAT-COL_POS   = 21.

  LS_FCAT-OUTPUTLEN = 20.

  APPEND LS_FCAT TO GT_FCAT.



  " 12. ## (MENGE) - ##: #### ##

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'MENGE'.

  LS_FCAT-COLTEXT   = '##'.

  LS_FCAT-QFIELDNAME = 'MEINS'. " [##] ## ##

  LS_FCAT-COL_POS   = 22.

  LS_FCAT-OUTPUTLEN = 10.

  APPEND LS_FCAT TO GT_FCAT.



  " 13. ## (MEINS)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'MEINS'.

  LS_FCAT-COLTEXT   = '##'.

  LS_FCAT-COL_POS   = 23.

  LS_FCAT-OUTPUTLEN = 4.

  APPEND LS_FCAT TO GT_FCAT.



  " 14. ## (NETPR)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'NETPR'.

  LS_FCAT-COLTEXT   = 'PO##'.

  LS_FCAT-CFIELDNAME = 'WAERS'. " [##]

  LS_FCAT-COL_POS   = 24.

  LS_FCAT-OUTPUTLEN = 11.

  APPEND LS_FCAT TO GT_FCAT.



  " 15. ### (WERKS)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'WERKS'.

  LS_FCAT-COLTEXT   = '###'.

  LS_FCAT-COL_POS   = 25.

  LS_FCAT-OUTPUTLEN = 6.

  APPEND LS_FCAT TO GT_FCAT.



  " 16. ### (LIFNR)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'LIFNR'.

  LS_FCAT-COLTEXT   = '###'.

  LS_FCAT-COL_POS   = 26.

  LS_FCAT-OUTPUTLEN = 10.

  APPEND LS_FCAT TO GT_FCAT.



  " 17. ### (MESSAGE)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'MESSAGE'.

  LS_FCAT-COLTEXT   = '####'.

  LS_FCAT-COL_POS   = 30.

  LS_FCAT-OUTPUTLEN = 40.

  APPEND LS_FCAT TO GT_FCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*& Form SET_LAYOUT

*&---------------------------------------------------------------------*




FORM SET_LAYOUT.

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA      = 'X'.

  GS_LAYOUT-CWIDTH_OPT = 'X'.

  GS_LAYOUT-SEL_MODE   = 'D'.



  IF R_CREA = 'X'.

    GS_LAYOUT-GRID_TITLE = '## ## (## ##)'.

  ELSE.

    GS_LAYOUT-GRID_TITLE = '## ##'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*& Form SAVE_DATA

*&---------------------------------------------------------------------*




FORM SAVE_DATA.

  DATA: LV_ANSWER  TYPE C,

        LV_BELNR   TYPE ZEDT10_RBKP-BELNR,

        LV_NET_SUM TYPE ZEDT10_RBKP-DMBTR,  " #### ##

        LV_TAX_SUM TYPE ZEDT10_RBKP-WMWST,  " ## ##

        LV_TOT_SUM TYPE ZEDT10_RBKP-DMBTR.  " # ##



  DATA: LS_RBKP    TYPE ZEDT10_RBKP,

        LS_RSEG    TYPE ZEDT10_RSEG,

        LS_BSIK    TYPE ZEDT10_BSIK,

        LS_EKBE    TYPE ZEDT10_EKBE,

        LV_TAX_AMT TYPE ZEDT10_RSEG-WRBTR.



  DATA: LV_CRTIME TYPE SY-UZEIT. " ## ## ## ##



  " [##] ## ### ## ## ##

  DATA: LV_KBETR TYPE ZEDT10_MWSKZ-KBETR. " #### ## ## ##



  " 1. ALV ## ### ##

  IF GO_ALV IS BOUND.

    GO_ALV->CHECK_CHANGED_DATA( ).

  ENDIF.



  " 2. ### ## (### ## ## ##)

  READ TABLE GT_DATA WITH KEY L_CHECK = 'X' TRANSPORTING NO FIELDS.

  IF SY-SUBRC <> 0.

    MESSAGE '### ### #####.' TYPE 'S' DISPLAY LIKE 'E'.

    RETURN.

  ENDIF.



  " 3. ## ## ##

  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      TITLEBAR      = '## ##'

      TEXT_QUESTION = '### ### ## ### ########?'

      ICON_BUTTON_1 = 'ICON_OKAY'

      ICON_BUTTON_2 = 'ICON_CANCEL'

    IMPORTING

      ANSWER        = LV_ANSWER.

  IF LV_ANSWER <> '1'. RETURN. ENDIF.



  " 4. ## ## ## (Object: ZMBELN10 ##)

  " 5000000000 ~

  CALL FUNCTION 'NUMBER_GET_NEXT'

    EXPORTING

      NR_RANGE_NR = '50'        " ## ## ## (## ## ##)

      OBJECT      = 'ZMBELN10'  " ## ####

    IMPORTING

      NUMBER      = LV_BELNR

    EXCEPTIONS

      OTHERS      = 1.



  IF SY-SUBRC <> 0.

    MESSAGE '## ## ## #####.' TYPE 'E'.

    EXIT.

  ENDIF.



  " 5. ### ## # ### ##

  CLEAR: LT_RBKP, LT_RSEG, LT_BSIK, LT_EKBE.

  CLEAR: LV_NET_SUM, LV_TAX_SUM.



  LV_CRTIME = SY-UZEIT.



  " (1) ###(RSEG, EKBE) ## # ## ##

  LOOP AT GT_DATA INTO GS_DATA WHERE L_CHECK = 'X'.



    " ### ##

    IF GS_DATA-WRBTR <= 0.

      MESSAGE '##### 0## ## ###.' TYPE 'E'.

    ENDIF.



    " ========================================================

    " [##] ####(Tax Rate) ## # ## ##

    " ========================================================

    CLEAR: LV_KBETR.



    " 1. DB ##### ## ####(MWSKZ)# ##(KBETR) ##

    SELECT SINGLE KBETR

      INTO LV_KBETR

      FROM ZEDT10_MWSKZ

     WHERE MWSKZ = GS_DATA-MWSKZ

       AND SPRAS = SY-LANGU. " ## ## ### ## (## ##)



    " 2. #### ### ## ## # 0%# ##

    IF SY-SUBRC <> 0.

      LV_KBETR = 0.

    ENDIF.






*    " 3. ##(MWSTS) ##

*    " ##: #### * ( ## / 100 )

*    " ##: 1000 * ( 10.00 / 100 ) = 100

*    GS_DATA-MWSTS = GS_DATA-NETPR * GS_DATA-MENGE * ( LV_KBETR / 100 ).

*    " # GS_DATA ### #### ## GS_DATA-WRBTR ##

*

*    " 4. ###(DMBTR) ##

*    GS_DATA-DMBTR = ( GS_DATA-NETPR * GS_DATA-MENGE ) + GS_DATA-MWSTS.






    " ========================================================



    " ## ## (## # BSIK#)

    ADD GS_DATA-WRBTR TO LV_NET_SUM.

    ADD LV_TAX_AMT    TO LV_TAX_SUM.



    " [RSEG] ## ###

    CLEAR LS_RSEG.

    LS_RSEG-MANDT = SY-MANDT.

    LS_RSEG-BELNR = LV_BELNR.       " ### ##

    LS_RSEG-GJAHR = P_BUDAT(4).     " ####

    LS_RSEG-BUZEI = GS_DATA-EBELP.  " #### (PO## ##)

    LS_RSEG-EBELN = GS_DATA-EBELN.

    LS_RSEG-EBELP = GS_DATA-EBELP.

    LS_RSEG-MATNR = GS_DATA-MATNR.

    LS_RSEG-WERKS = GS_DATA-WERKS.

    LS_RSEG-MENGE = GS_DATA-MENGE.

    LS_RSEG-MEINS = GS_DATA-MEINS.

    LS_RSEG-WAERS = GS_DATA-WAERS.

    LS_RSEG-WRBTR = GS_DATA-WRBTR.  " ####

    LS_RSEG-MWSKZ = GS_DATA-MWSKZ.

    LS_RSEG-SHKZG = C_SHKZG_S.      " S (##)



    " === [##] ZEDS10_002 ## ## ## (RSEG) ===

    LS_RSEG-CRNAME = SY-UNAME.    " ###

    LS_RSEG-CRDATE = SY-DATUM.    " ###

    LS_RSEG-CRZEIT  = LV_CRTIME.   " ####



    " === [### ##] ===

    LS_RSEG-MWSTS = GS_DATA-MWSTS. " ## (##!)

    LS_RSEG-DMBTR = GS_DATA-DMBTR. " ### (##!)

    APPEND LS_RSEG TO LT_RSEG.



    " [EKBE] PO ## ####

    CLEAR LS_EKBE.

    LS_EKBE-MANDT = SY-MANDT.

    LS_EKBE-EBELN = GS_DATA-EBELN.

    LS_EKBE-EBELP = GS_DATA-EBELP.

    LS_EKBE-ZEKKN = '01'.

    LS_EKBE-VGABE = C_VGABE_IV.     " '2' (##)

    LS_EKBE-GJAHR = P_BUDAT(4).

    LS_EKBE-BELNR = LV_BELNR.

    LS_EKBE-BUZEI = GS_DATA-EBELP.

    LS_EKBE-BEWTP = 'Q'.            " ## ##

    LS_EKBE-MENGE = GS_DATA-MENGE.  " ##

    LS_EKBE-MEINS = GS_DATA-MEINS.  " <--- [###] ## ##

    LS_EKBE-DMBTR = GS_DATA-WRBTR.  " ##

    LS_EKBE-WAERS = GS_DATA-WAERS.

    LS_EKBE-SHKZG = C_SHKZG_S..

    APPEND LS_EKBE TO LT_EKBE.



  ENDLOOP.



  " (2) ##(RBKP) ##

  CLEAR LS_RBKP.

  LV_TOT_SUM = LV_NET_SUM + LV_TAX_SUM. " # ##



  LS_RBKP-MANDT = SY-MANDT.

  LS_RBKP-BELNR = LV_BELNR.

  LS_RBKP-GJAHR = P_BUDAT(4).

  LS_RBKP-BLART = C_DOC_RE.   " 'RE'

  LS_RBKP-BLDAT = SY-DATUM.   " ###

  LS_RBKP-BUDAT = P_BUDAT.    " ###

  LS_RBKP-LIFNR = GS_DATA-LIFNR. " (### ### ## ##)

  LS_RBKP-WAERS = GS_DATA-WAERS.

  LS_RBKP-DMBTR = LV_TOT_SUM. " # ## (###+##)

  LS_RBKP-WMWST = LV_TAX_SUM. " ## ##

  LS_RBKP-BUKRS = GS_DATA-BUKRS.

  LS_RBKP-SGTXT = GS_DATA-SGTXT.



  " === [##] ZEDS10_002 ## ## ## (RBKP) ===

  LS_RBKP-CRNAME = SY-UNAME.

  LS_RBKP-CRDATE = SY-DATUM.

  LS_RBKP-CRZEIT = LV_CRTIME.

  APPEND LS_RBKP TO LT_RBKP.



  " (3) ##(BSIK) ## (Source 4 ##)

  " ### ## ##### 1## Line## ## ##

  CLEAR LS_BSIK.

  LS_BSIK-MANDT = SY-MANDT.

  LS_BSIK-BUKRS = GS_DATA-BUKRS.

  LS_BSIK-LIFNR = GS_DATA-LIFNR.

  LS_BSIK-BELNR = LV_BELNR.

  LS_BSIK-GJAHR = P_BUDAT(4).

  LS_BSIK-BUZEI = '001'.

  LS_BSIK-BLDAT = SY-DATUM.

  LS_BSIK-BUDAT = P_BUDAT.

  LS_BSIK-WAERS = GS_DATA-WAERS.

  LS_BSIK-BLART = C_DOC_RE.

  LS_BSIK-SHKZG = C_SHKZG_H.    " H (## - ## ##)

  LS_BSIK-DMBTR = LV_TOT_SUM.   " # ## ##

  LS_BSIK-MWSTS = LV_TAX_SUM.   " ##

  LS_BSIK-MWSKZ = GS_DATA-MWSKZ.

  LS_BSIK-SGTXT = GS_DATA-SGTXT.

  " === [##] ZEDS10_002 ## ## ## (BSIK) ===

  LS_BSIK-CRNAME = SY-UNAME.

  LS_BSIK-CRDATE = SY-DATUM.

  LS_BSIK-CRZEIT = LV_CRTIME.



  " ZFBDT (#####) ##: #### ###

  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING

      DAY_IN            = P_BUDAT

    IMPORTING

      LAST_DAY_OF_MONTH = LS_BSIK-ZFBDT.



  APPEND LS_BSIK TO LT_BSIK.



  " 6. DB ## (INSERT)

  INSERT ZEDT10_RBKP FROM TABLE LT_RBKP.

  INSERT ZEDT10_RSEG FROM TABLE LT_RSEG.

  INSERT ZEDT10_BSIK FROM TABLE LT_BSIK.

  INSERT ZEDT10_EKBE FROM TABLE LT_EKBE.



  IF SY-SUBRC = 0.

    COMMIT WORK AND WAIT.

    MESSAGE |## { LV_BELNR } ## #######.| TYPE 'S'.



    " ## ### ## ###

    PERFORM GET_DATA.

    PERFORM REFRESH_ALV.

  ELSE.

    ROLLBACK WORK.

    MESSAGE '### ## # ### ######.' TYPE 'E'.

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*& Form REFRESH_ALV

*&---------------------------------------------------------------------*




FORM REFRESH_ALV.

  DATA: LS_STABLE TYPE LVC_S_STBL.

  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  IF GO_ALV IS BOUND.

    GO_ALV->REFRESH_TABLE_DISPLAY( IS_STABLE = LS_STABLE ).

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*& Form CANCEL_DATA

*&---------------------------------------------------------------------*




FORM CANCEL_DATA.

  DATA: LV_ANSWER TYPE C,

        LV_CNT    TYPE I.



  " 1. ### ## ##

  READ TABLE GT_DATA WITH KEY L_CHECK = 'X' TRANSPORTING NO FIELDS.

  IF SY-SUBRC <> 0.

    MESSAGE '### ### #####.' TYPE 'S' DISPLAY LIKE 'E'.

    RETURN.

  ENDIF.



  " 2. ### ## ##

  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      TITLEBAR      = '## ## ##'

      TEXT_QUESTION = '### ## #### #### ########?'

      TEXT_BUTTON_1 = '#'

      TEXT_BUTTON_2 = '###'

    IMPORTING

      ANSWER        = LV_ANSWER.



  IF LV_ANSWER <> '1'.

    MESSAGE '#######.' TYPE 'S'.

    RETURN.

  ENDIF.



  " 3. ## ## ##

  LOOP AT GT_DATA INTO GS_DATA WHERE L_CHECK = 'X'.



    " (1) ## ##(RBKP) ##

    DELETE FROM ZEDT10_RBKP

     WHERE BELNR = GS_DATA-BELNR

       AND GJAHR = GS_DATA-GJAHR.



    " (2) ## ###(RSEG) ##

    DELETE FROM ZEDT10_RSEG

     WHERE BELNR = GS_DATA-BELNR

       AND GJAHR = GS_DATA-GJAHR.



    " (3) ##/##(BSIK) ##

    DELETE FROM ZEDT10_BSIK

     WHERE BELNR = GS_DATA-BELNR

       AND GJAHR = GS_DATA-GJAHR.



    " (4) [##] #### ##(EKBE) ##

    " # ### #### GET_DATA #### '## ##'# ## #### ###

    DELETE FROM ZEDT10_EKBE

     WHERE BELNR = GS_DATA-BELNR

       AND GJAHR = GS_DATA-GJAHR

       AND VGABE = '2'. " ## ### ##



    LV_CNT = LV_CNT + 1.



  ENDLOOP.



  IF SY-SUBRC = 0.

    COMMIT WORK AND WAIT.

    MESSAGE '### ##### ##(##)#####.' TYPE 'S'.



    " 4. ## ## (### ### # ### ## ##)

    PERFORM GET_DATA.

    IF GO_ALV IS BOUND.

      PERFORM REFRESH_ALV.

    ENDIF.

  ELSE.

    ROLLBACK WORK.

    MESSAGE '## ## # ### ######.' TYPE 'E'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REGI_EVENT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM REGI_EVENT .

  " ### ### ##

  SET HANDLER GO_HANDLER->HANDLE_USER_COMMAND FOR GO_ALV.

  SET HANDLER GO_HANDLER->HANDLE_TOOLBAR FOR GO_ALV.



  " [##] ## ### ## (#### ## # ### ## ## ##)

  GO_ALV->REGISTER_EDIT_EVENT(

    EXPORTING I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED ).



  " [##] DATA_CHANGED ### ### ##

  SET HANDLER GO_HANDLER->HANDLE_DATA_CHANGED FOR GO_ALV.



  " [##] ## # ## # ### ## ## (##)

  CALL METHOD GO_ALV->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_ENTER.

  " MC_EVT_MODIFIED : ### ## # ##

  " MC_EVT_ENTER    : ## # ## # ## (##)



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJ

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJ .

  CREATE OBJECT GO_CONTAINER

    EXPORTING

      CONTAINER_NAME = 'CC_ALV'.



  CREATE OBJECT GO_ALV

    EXPORTING

      I_PARENT = GO_CONTAINER.

  CREATE OBJECT GO_HANDLER.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DISPLAY .

  CALL METHOD GO_ALV->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_LAYOUT       = GS_LAYOUT

    CHANGING

      IT_OUTTAB       = GT_DATA

      IT_FIELDCATALOG = GT_FCAT.

ENDFORM.