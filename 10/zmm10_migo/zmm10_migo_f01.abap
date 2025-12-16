
*&---------------------------------------------------------------------*

*&  Include           ZMM10_MIGO_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*& Form GET_DATA

*&---------------------------------------------------------------------*

*  ##: ## ##(##/##)# ## #### #### ###

*----------------------------------------------------------------------*




FORM GET_DATA .



  DATA: LV_GR_QTY TYPE ZEDT10_MSEG-MENGE. " ### ## ###



  " ## ### ###

  REFRESH GT_ITEM.



  "====================================================================

  " CASE 1: ## ## ## (#### ##)

  "====================================================================

  IF R_CREA = 'X'.



    " 1. ## #### ##

    IF P_EBELN IS INITIAL.

      MESSAGE '#### ### #####.' TYPE 'S' DISPLAY LIKE 'E'.

      EXIT.

    ENDIF.



    " 2. ####(PO) ### ##

    "    ##(EKKO)# ###(EKPO)# #### ### ## ####

    SELECT P~EBELN P~EBELP P~MATNR P~MAKTX

       P~MENGE  " <-- PO ## ##

       P~MEINS P~NETPR P~WERKS P~LGORT P~PRDAT

       K~LIFNR K~BEDAT K~WAERS

  INTO CORRESPONDING FIELDS OF TABLE GT_ITEM

  FROM ZEDT10_EKPO AS P

  INNER JOIN ZEDT10_EKKO AS K

     ON P~EBELN = K~EBELN

  WHERE P~EBELN = P_EBELN

    AND P~WERKS = P_WERKS.



    IF GT_ITEM IS INITIAL.

      MESSAGE '### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

      EXIT.

    ENDIF.



    " 2. ## ## ## (## ## ### ##)

    LOOP AT GT_ITEM INTO GS_ITEM.



      " 2-1. ### ## ## (#### ##)

      PERFORM GET_GR_QTY USING    GS_ITEM-EBELN GS_ITEM-EBELP

                         CHANGING GS_ITEM-DONE_QTY.



      " 2-2. ## ## (PO## - #####) [1]

      GS_ITEM-OPEN_QTY = GS_ITEM-MENGE - GS_ITEM-DONE_QTY.



      " 2-3. ## ## ## ### = ##

      GS_ITEM-GR_QTY = GS_ITEM-OPEN_QTY.



      " 2-4. ### ### #### ## (####) [3]

      IF GS_ITEM-OPEN_QTY <= 0.

        DELETE GT_ITEM.

        CONTINUE.

      ENDIF.



      GS_ITEM-ICON = ICON_LED_YELLOW.

      GS_ITEM-MESSAGE = '## ##'.

      MODIFY GT_ITEM FROM GS_ITEM.

    ENDLOOP.



    IF GT_ITEM IS INITIAL.

      MESSAGE '## ### ### #######.' TYPE 'S'.

    ENDIF.



    "====================================================================

    " CASE 2: ## ## ## (#### ##)

    "====================================================================

  ELSEIF R_DISP = 'X'.



    " 1. ## #### ##




*    IF P_MBLNR IS INITIAL.

*      MESSAGE '## ## ### #####.' TYPE 'S' DISPLAY LIKE 'E'.

*      EXIT.

*    ENDIF.






    " 2. ####(MKPF+MSEG) ### ##

    "    [##] ## ### ## B~ZEILE(##) ## ## ##

    SELECT A~MBLNR A~MJAHR A~BUDAT AS BEDAT " ### #### BEDAT ### ##

           A~USNAM A~BLART

           B~ZEILE  " <-- [##] ##(DELETE) # Key# ##

           B~MATNR B~MENGE B~MEINS B~DMBTR AS NETPR B~WAERS

           B~WERKS B~LGORT B~LIFNR B~EBELN B~EBELP

      INTO CORRESPONDING FIELDS OF TABLE GT_ITEM

      FROM ZEDT10_MKPF AS A

      INNER JOIN ZEDT10_MSEG AS B

        ON A~MBLNR = B~MBLNR

       AND A~MJAHR = B~MJAHR

      INNER JOIN ZEDT10_EKPO AS P

        ON B~EBELN = P~EBELN

        WHERE P~EBELN = P_EBELN

    AND P~WERKS = P_WERKS

      AND B~BWART = '101'.

    .




*      WHERE A~MBLNR = P_MBLNR

*        AND A~MJAHR = P_MJAHR.






    IF GT_ITEM IS INITIAL.

      MESSAGE '### ## ### ####.' TYPE 'S' DISPLAY LIKE 'E'.

      EXIT.

    ENDIF.



    " 3. ### ## (### ## # ### ##)

    LOOP AT GT_ITEM INTO GS_ITEM.



      " 3-1. ###(MAKTX) ####

      "      MSEG## #### #### PO ##### ## ##### ##

      SELECT SINGLE MAKTX INTO GS_ITEM-MAKTX

        FROM ZEDT10_EKPO

        WHERE MATNR = GS_ITEM-MATNR

          AND EBELN = GS_ITEM-EBELN

          AND EBELP = GS_ITEM-EBELP.



      " PO #### ### ## ###(ZMARA10)## ### (####)

      IF SY-SUBRC <> 0.

        SELECT SINGLE MATKTX INTO GS_ITEM-MAKTX

          FROM ZMARA10

          WHERE MATNR = GS_ITEM-MATNR.

      ENDIF.



      " 3-2. ## ## (## ##### ## ### ##)

      GS_ITEM-ICON    = ICON_CHECKED.

      GS_ITEM-MESSAGE = '## ##'.



      MODIFY GT_ITEM FROM GS_ITEM.

    ENDLOOP.



  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*& Form SET_FCAT

*&---------------------------------------------------------------------*

*& ALV ## #### ##

*& - ####: ## ## ##

*& - ####(GR_QTY): ## ##(R_CREA)# ## ## ##

*&---------------------------------------------------------------------*




FORM SET_FCAT .



  DATA: LS_FCAT TYPE LVC_S_FCAT.

  REFRESH GT_FCAT. " ## #### ###



  " 1. #### (L_CHECK) - [##: ## #### ## ## #### #]

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'L_CHECK'.

  LS_FCAT-COLTEXT   = '##'.

  LS_FCAT-CHECKBOX  = 'X'.    " ##### ##

  LS_FCAT-EDIT      = 'X'.    " # ## ## ## (## ### #### ###)

  LS_FCAT-COL_POS   = 1.

  LS_FCAT-OUTPUTLEN = 5.

  LS_FCAT-JUST      = 'C'.

  APPEND LS_FCAT TO GT_FCAT.



  " 2. ## ### (ICON)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'ICON'.

  LS_FCAT-COLTEXT   = '##'.

  LS_FCAT-ICON      = 'X'.    " ##### ##

  LS_FCAT-COL_POS   = 2.

  LS_FCAT-OUTPUTLEN = 4.

  LS_FCAT-JUST      = 'C'.

  APPEND LS_FCAT TO GT_FCAT.



  " 3. #### ## (EBELN)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'EBELN'.

  LS_FCAT-COLTEXT   = '####'.

  LS_FCAT-REF_TABLE = 'ZEDT10_EKPO'.

  LS_FCAT-REF_FIELD = 'EBELN'.

  LS_FCAT-KEY       = 'X'.    " # ## ## (## ## ##)

  LS_FCAT-COL_POS   = 3.

  LS_FCAT-OUTPUTLEN = 10.

  APPEND LS_FCAT TO GT_FCAT.



  " 4. ## ## (EBELP)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'EBELP'.

  LS_FCAT-COLTEXT   = '##'.

  LS_FCAT-REF_TABLE = 'ZEDT10_EKPO'.

  LS_FCAT-REF_FIELD = 'EBELP'.

  LS_FCAT-KEY       = 'X'.

  LS_FCAT-COL_POS   = 4.

  LS_FCAT-OUTPUTLEN = 5.

  APPEND LS_FCAT TO GT_FCAT.



  " 5. ## ## (MATNR)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'MATNR'.

  LS_FCAT-COLTEXT   = '####'.

  LS_FCAT-REF_TABLE = 'ZEDT10_EKPO'.

  LS_FCAT-REF_FIELD = 'MATNR'.

  LS_FCAT-COL_POS   = 5.

  LS_FCAT-OUTPUTLEN = 18.

  APPEND LS_FCAT TO GT_FCAT.



  " 6. ## ## (MAKTX)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'MAKTX'.

  LS_FCAT-COLTEXT   = '####'.

  LS_FCAT-REF_TABLE = 'ZEDT10_EKPO'.

  LS_FCAT-REF_FIELD = 'MAKTX'.

  LS_FCAT-COL_POS   = 6.

  LS_FCAT-OUTPUTLEN = 20.

  APPEND LS_FCAT TO GT_FCAT.



  " 7. ## (MEINS) - ## #### ## ##

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'MEINS'.

  LS_FCAT-COLTEXT   = '##'.

  LS_FCAT-REF_TABLE = 'ZEDT10_EKPO'.

  LS_FCAT-REF_FIELD = 'MEINS'.

  LS_FCAT-COL_POS   = 7.

  LS_FCAT-OUTPUTLEN = 3.

  APPEND LS_FCAT TO GT_FCAT.



  " 8. PO ## (MENGE) - ### ## ##

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'MENGE'.

  LS_FCAT-COLTEXT   = 'PO##'.

  LS_FCAT-REF_TABLE = 'ZEDT10_EKPO'.

  LS_FCAT-REF_FIELD = 'MENGE'.

  LS_FCAT-QFIELDNAME = 'MEINS'. " ## ##

  LS_FCAT-COL_POS   = 8.

  APPEND LS_FCAT TO GT_FCAT.



  " 9. ### ## (DONE_QTY) - ### ## ##

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'DONE_QTY'.

  LS_FCAT-COLTEXT   = '####'.

  LS_FCAT-QFIELDNAME = 'MEINS'.

  LS_FCAT-COL_POS   = 9.

  APPEND LS_FCAT TO GT_FCAT.



  " 10. ## (OPEN_QTY) - ### ## ##

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'OPEN_QTY'.

  LS_FCAT-COLTEXT   = '##'.

  LS_FCAT-QFIELDNAME = 'MEINS'.

  LS_FCAT-EMPHASIZE = 'C500'.   " ## ## ## (###)

  LS_FCAT-COL_POS   = 10.

  APPEND LS_FCAT TO GT_FCAT.



  " ===================================================================

  " [## ##] 11. ## ## (GR_QTY) - ## ## ##

  " ===================================================================

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'GR_QTY'.

  LS_FCAT-COLTEXT   = '####(##)'.

  LS_FCAT-REF_TABLE = 'MSEG'.   " ## ### ##

  LS_FCAT-REF_FIELD = 'MENGE'.

  LS_FCAT-QFIELDNAME = 'MEINS'. " ## ##

  LS_FCAT-COL_POS   = 11.



  " ##: ## ##(R_CREA)# ## ## ##, ## ### ## ##

  IF R_CREA = 'X'.

    LS_FCAT-EDIT      = 'X'.    " ## ##

    LS_FCAT-EMPHASIZE = 'C300'. " ### (## ## ## ##)

  ELSE.

    LS_FCAT-EDIT      = ' '.    " ## ## (## ##)

    LS_FCAT-EMPHASIZE = 'C700'. " ## ## (## ## ###)

    " -> ## ##### ### ### # ## ## ### #### #

  ENDIF.



  APPEND LS_FCAT TO GT_FCAT.

  " ===================================================================



  " 12. ## (NETPR)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'NETPR'.

  LS_FCAT-COLTEXT   = '##'.

  LS_FCAT-REF_TABLE = 'ZEDT10_EKPO'.

  LS_FCAT-REF_FIELD = 'NETPR'.

  LS_FCAT-CFIELDNAME = 'WAERS'. " ## ## ##

  LS_FCAT-COL_POS   = 12.

  LS_FCAT-OUTPUTLEN = 11.

  APPEND LS_FCAT TO GT_FCAT.



  " 13. ## (WAERS)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'WAERS'.

  LS_FCAT-COLTEXT   = '##'.

  LS_FCAT-REF_TABLE = 'ZEDT10_EKKO'.

  LS_FCAT-REF_FIELD = 'WAERS'.

  LS_FCAT-COL_POS   = 13.

  LS_FCAT-OUTPUTLEN = 5.

  APPEND LS_FCAT TO GT_FCAT.



  " 14. ### (WERKS)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'WERKS'.

  LS_FCAT-COLTEXT   = '###'.

  LS_FCAT-REF_TABLE = 'ZEDT10_EKPO'.

  LS_FCAT-REF_FIELD = 'WERKS'.

  LS_FCAT-COL_POS   = 14.

  LS_FCAT-OUTPUTLEN = 4.

  APPEND LS_FCAT TO GT_FCAT.



  " 15. #### (LGORT)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'LGORT'.

  LS_FCAT-COLTEXT   = '####'.

  LS_FCAT-REF_TABLE = 'ZEDT10_EKPO'.

  LS_FCAT-REF_FIELD = 'LGORT'.

  LS_FCAT-COL_POS   = 15.

  LS_FCAT-OUTPUTLEN = 4.

  APPEND LS_FCAT TO GT_FCAT.



  " 16. ## ## ### (MESSAGE)

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'MESSAGE'.

  LS_FCAT-COLTEXT   = '####'.

  LS_FCAT-COL_POS   = 20.       " # ## ##

  LS_FCAT-OUTPUTLEN = 50.

  APPEND LS_FCAT TO GT_FCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*& Form SET_LAYOUT

*&---------------------------------------------------------------------*




FORM SET_LAYOUT .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA      = 'X'.

  GS_LAYOUT-CWIDTH_OPT = 'X'.

  GS_LAYOUT-SEL_MODE   = 'D'.



  IF R_CREA = 'X'.

    GS_LAYOUT-GRID_TITLE = '## ## ##'.

  ELSE.

    GS_LAYOUT-GRID_TITLE = '## ## ##'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*& Form DISPLAY_ALV

*&---------------------------------------------------------------------*




FORM DISPLAY_ALV .

  IF GO_CONTAINER IS INITIAL.

    CREATE OBJECT GO_CONTAINER

      EXPORTING

        CONTAINER_NAME = 'CC_ALV'.



    CREATE OBJECT GO_ALV

      EXPORTING

        I_PARENT = GO_CONTAINER.



    PERFORM SET_LAYOUT.

    PERFORM SET_FCAT.



    CALL METHOD GO_ALV->SET_TABLE_FOR_FIRST_DISPLAY

      EXPORTING

        IS_LAYOUT       = GS_LAYOUT

      CHANGING

        IT_OUTTAB       = GT_ITEM

        IT_FIELDCATALOG = GT_FCAT.

  ELSE.

    PERFORM REFRESH_ALV.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*& Form REFRESH_ALV

*&---------------------------------------------------------------------*




FORM REFRESH_ALV .

  DATA: LS_STABLE TYPE LVC_S_STBL.

  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  IF GO_ALV IS BOUND.

    CALL METHOD GO_ALV->REFRESH_TABLE_DISPLAY

      EXPORTING

        IS_STABLE = LS_STABLE.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*& Form SAVE_DATA

*&---------------------------------------------------------------------*




FORM SAVE_DATA .

  DATA: LS_TEMP_QT TYPE N.

  DATA: LS_MKPF TYPE ZEDT10_MKPF,

        LS_MSEG TYPE ZEDT10_MSEG,

        LT_MSEG TYPE TABLE OF ZEDT10_MSEG.



  DATA: LS_T003  TYPE ZEDT10_T003,      " #### ## ###

        LV_RC    TYPE INRI-NRRANGENR,   " #### ##

        LV_MSG   TYPE STRING,

        LV_MBLNR TYPE ZEDT10_MKPF-MBLNR, " ######

        LV_ZEILE TYPE ZEDT10_MSEG-ZEILE. " ####

  " [##] #### ## ### ##

  DATA: LS_EKBE TYPE ZEDT10_EKBE,

        LT_EKBE TYPE TABLE OF ZEDT10_EKBE.



  FIELD-SYMBOLS: <FS_ITEM> LIKE LINE OF GT_ITEM.



  " 1. ### ## ##

  READ TABLE GT_ITEM WITH KEY L_CHECK = 'X' TRANSPORTING NO FIELDS.

  IF SY-SUBRC <> 0.

    MESSAGE '### ### #####.' TYPE 'S' DISPLAY LIKE 'E'.

    EXIT.

  ENDIF.



  " 2. ## ## ## ## (Step 1 ## ##)

  " C_DOC_WE# TOP# ### ## 'WE' ###.

  SELECT SINGLE * INTO LS_T003

    FROM ZEDT10_T003

   WHERE BLART = C_DOC_WE.



  IF SY-SUBRC <> 0.

    MESSAGE '## ##(WE)# ## ## ## ##(ZEDT10_T003)# ####.' TYPE 'E'.

    EXIT.

  ENDIF.



  LV_RC = LS_T003-NUMKR. " #### '50'# #### # [3]



  " 2. NUMBER_GET_NEXT ### #### #### ## (SAP Standard)

  " ### ZMBELN01# ## ## ###### [4].

  CALL FUNCTION 'NUMBER_GET_NEXT'

    EXPORTING

      NR_RANGE_NR             = LV_RC      " ## ## ## (50)

      OBJECT                  = 'ZMBELN10' " ## ## ###

      QUANTITY                = '1'        " 1# ##

    IMPORTING

      NUMBER                  = LV_MBLNR   " ### ## ## (#: 5000000001)

    EXCEPTIONS

      INTERVAL_NOT_FOUND      = 1

      NUMBER_RANGE_NOT_INTERN = 2

      OBJECT_NOT_FOUND        = 3

      QUANTITY_IS_0           = 4

      QUANTITY_IS_NOT_1       = 5

      INTERVAL_OVERFLOW       = 6

      BUFFER_OVERFLOW         = 7

      OTHERS                  = 8.



  IF SY-SUBRC <> 0.

    " ## ## # ## ## ### ##

    CASE SY-SUBRC.

      WHEN 1. LV_MSG = '## ## ##(Interval)# ## # ####.'.

      WHEN 3. LV_MSG = '## ## ##(Object)# ## # ####.'.

      WHEN 6. LV_MSG = '## ### # #### (Overflow).'.

      WHEN OTHERS. LV_MSG = '## ## # # # ## ### ######.'.

    ENDCASE.

    MESSAGE LV_MSG TYPE 'E'.

    EXIT.

  ENDIF.



  " 3. ## ### ## (ZEDT10_MKPF)

  READ TABLE GT_ITEM INTO GS_ITEM WITH KEY L_CHECK = 'X'.



  LS_MKPF-MBLNR = LV_MBLNR.

  LS_MKPF-MJAHR = P_BUDAT(4).    " #### (### ##)

  LS_MKPF-BLART = 'WE'.          " #### (##)

  LS_MKPF-BLDAT = GS_ITEM-BEDAT. " ### (PO## ##)

  LS_MKPF-BUDAT = P_BUDAT.       " ### (## ###)

  LS_MKPF-USNAM = SY-UNAME.

  LS_MKPF-XBLNR = 'PO Reference'.





  " 4. ### ### ## # ## ## ## (ZEDT10_MSEG)

  CLEAR: LV_ZEILE.



  LOOP AT GT_ITEM INTO GS_ITEM WHERE L_CHECK = 'X'.

    " ### ##

    IF GS_ITEM-GR_QTY <= 0.

      MESSAGE '## ### 0## ## ###.' TYPE 'S' DISPLAY LIKE 'E'.

      EXIT.

    ENDIF.

    IF GS_ITEM-OPEN_QTY < GS_ITEM-GR_QTY.

      MESSAGE '## ### #### ### ###.' TYPE 'S' DISPLAY LIKE 'E'.

    ENDIF.



    ADD 1 TO LV_ZEILE.

    CLEAR LS_MSEG.



    " (1) ## # # ## ##

    LS_MSEG-MANDT = SY-MANDT.

    LS_MSEG-MBLNR = LV_MBLNR.

    LS_MSEG-MJAHR = P_BUDAT(4).

    LS_MSEG-ZEILE = LV_ZEILE.

    LS_MSEG-BWART = '101'.         " #### (##)

    LS_MSEG-MATNR = GS_ITEM-MATNR.

    LS_MSEG-WERKS = GS_ITEM-WERKS.

    LS_MSEG-LGORT = GS_ITEM-LGORT.

    LS_MSEG-LIFNR = GS_ITEM-LIFNR.

    LS_MSEG-EBELN = GS_ITEM-EBELN.

    LS_MSEG-EBELP = GS_ITEM-EBELP.



    " (2) ## # ##

    LS_MSEG-MENGE = GS_ITEM-GR_QTY. " #### ### ## ##

    LS_MSEG-MEINS = GS_ITEM-MEINS.



    " (3) [Step 3 ##] ## ### ##

    LS_MSEG-SHKZG = 'S'.            " #/##: S (##/Debit) - ## ##

    LS_MSEG-WAERS = GS_ITEM-WAERS.  " ## # (##)

    LS_MSEG-DMBTR = GS_ITEM-GR_QTY * GS_ITEM-NETPR. " ## ## (## * ##)



    " (4) ## ## ## #####

    " #### FI ### #####, #### #### ## ## ## ##

    " #: 5000000001 -> 8200000001

    CONCATENATE '82' LV_MBLNR+2(8) INTO LS_MSEG-BELNR.

    LS_MSEG-GJAHR = P_BUDAT(4).



    APPEND LS_MSEG TO LT_MSEG.



    " -------------------------------------------------------------

    " [##] ZEDT10_EKBE (#### ##) ### ##

    " ## ##: [1][2]

    " -------------------------------------------------------------

    CLEAR LS_EKBE.

    LS_EKBE-MANDT = SY-MANDT.

    LS_EKBE-EBELN = GS_ITEM-EBELN.       " #### ##

    LS_EKBE-EBELP = GS_ITEM-EBELP.       " ## ##

    LS_EKBE-ZEKKN = '01'.                " ## ## (Default '01') [1]

    LS_EKBE-VGABE = '1'.                 " ## ##: 1 (Goods Receipt) [2]

    LS_EKBE-GJAHR = P_BUDAT(4).          " #### (### ##)

    LS_EKBE-BELNR = LV_MBLNR.            " #### ## (## ##)

    LS_EKBE-BUZEI = LV_ZEILE.            " #### ## (## ##)



    LS_EKBE-BEWTP = 'E'.                 " ##: E (Goods Receipt) [2]

    LS_EKBE-BWART = '101'.               " ## ##: 101 [2]

    LS_EKBE-SHKZG = 'S'.                 " ###: S (Debit) [2]



    LS_EKBE-MENGE = GS_ITEM-GR_QTY.              " ## ##

    LS_EKBE-MEINS = GS_ITEM-MEINS.               " ## ##

    LS_EKBE-DMBTR = GS_ITEM-GR_QTY * GS_ITEM-NETPR. " ## ## (## * ##)

    LS_EKBE-WAERS = GS_ITEM-WAERS.               " ## #



    APPEND LS_EKBE TO LT_EKBE.

    " -------------------------------------------------------------



  ENDLOOP.



  " 5. DB ## (Transaction)

  INSERT ZEDT10_MKPF FROM LS_MKPF.

  IF SY-SUBRC <> 0.

    ROLLBACK WORK.

    MESSAGE '## ## ##' TYPE 'E'.

    EXIT.

  ENDIF.



  INSERT ZEDT10_MSEG FROM TABLE LT_MSEG.

  IF SY-SUBRC <> 0.

    ROLLBACK WORK.

    MESSAGE '### ## ##' TYPE 'E'.

    EXIT.

  ENDIF.



  " [##] #### ## ##

  INSERT ZEDT10_EKBE FROM TABLE LT_EKBE.

  IF SY-SUBRC <> 0.

    ROLLBACK WORK.

    MESSAGE '####(EKBE) ## ##' TYPE 'E'.

    EXIT.

  ENDIF.



  COMMIT WORK AND WAIT.



  " 6. ## ## # ## ##

  MESSAGE |## ## { LV_MBLNR }## #######.| TYPE 'I'.



  " ### ## #### ##### ## ##

  IF R_CREA = 'X'.

    PERFORM GET_DATA. " ## ### ## ### (Step 2## ### ## ##)

    PERFORM REFRESH_ALV.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*& Form REGI_EVENT

*&---------------------------------------------------------------------*




FORM REGI_EVENT .



  IF GO_EVENT_HANDLER IS INITIAL.

    CREATE OBJECT GO_EVENT_HANDLER.

  ENDIF.



  SET HANDLER GO_EVENT_HANDLER->HANDLE_TOOLBAR      FOR GO_ALV.

  SET HANDLER GO_EVENT_HANDLER->HANDLE_USER_COMMAND FOR GO_ALV.



  " [##] ### ## ### ## (#### ## # ## ##)

  CALL METHOD GO_ALV->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED. " # ## ## ##



  " ## ## # # ##### ## ## ## (# # ## ##, # ## ##)

  "   I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_ENTER.



  CALL METHOD GO_ALV->SET_TOOLBAR_INTERACTIVE.



ENDFORM.




*&---------------------------------------------------------------------*

*& Form HANDLE_USER_COMMAND

*&---------------------------------------------------------------------*




FORM HANDLE_USER_COMMAND USING P_UCOMM TYPE SY-UCOMM.



  DATA: LV_ANSWER TYPE C.



  CASE P_UCOMM.

    WHEN 'POST_GR'.

      " [##] 1. ### ####(#### #)# ### ###(GT_ITEM)# ##

      " # #### ### ### #### ### ITAB## # ### ######.

      IF GO_ALV IS BOUND.

        CALL METHOD GO_ALV->CHECK_CHANGED_DATA.

      ENDIF.



      " 2. ### ### ### ## (## ##)

      READ TABLE GT_ITEM WITH KEY L_CHECK = 'X' TRANSPORTING NO FIELDS.

      IF SY-SUBRC <> 0.

        MESSAGE '### ### #####(####).' TYPE 'S' DISPLAY LIKE 'E'.

        RETURN.

      ENDIF.



      " 3. #### ## ##

      CALL FUNCTION 'POPUP_TO_CONFIRM'

        EXPORTING

          TITLEBAR      = '## ##'

          TEXT_QUESTION = '### ### ##(##) ######?'

          TEXT_BUTTON_1 = '#'

          ICON_BUTTON_1 = 'ICON_OKAY'

          TEXT_BUTTON_2 = '###'

          ICON_BUTTON_2 = 'ICON_CANCEL'

        IMPORTING

          ANSWER        = LV_ANSWER.



      " 4. #### '#'# ### ## ##

      IF LV_ANSWER = '1'.

        PERFORM SAVE_DATA.

      ENDIF.



  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*& Form HANDLE_POST_GR

*&---------------------------------------------------------------------*

*  ##: ### '##(Post)' ## ## # #### ##

*----------------------------------------------------------------------*




FORM HANDLE_POST_GR .



  DATA: LV_ANSWER TYPE C.



  " 1. [##] ALV ### ####(####)# ### #### ##

  "    # ### ### #### #### GT_ITEM-L_CHECK# #### ###.

  IF GO_ALV IS BOUND.

    CALL METHOD GO_ALV->CHECK_CHANGED_DATA.

  ENDIF.



  " 2. ### ##: ### ### ### ##

  READ TABLE GT_ITEM WITH KEY L_CHECK = 'X' TRANSPORTING NO FIELDS.

  IF SY-SUBRC <> 0.

    MESSAGE '### ### #####.' TYPE 'S' DISPLAY LIKE 'E'.

    RETURN. " ## ##

  ENDIF.



  " 3. ### ## ## (##)

  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      TITLEBAR              = '## ##'

      TEXT_QUESTION         = '### ### ## ## ### ########?'

      TEXT_BUTTON_1         = '#(Yes)'

      ICON_BUTTON_1         = 'ICON_OKAY'

      TEXT_BUTTON_2         = '###(No)'

      ICON_BUTTON_2         = 'ICON_CANCEL'

      DISPLAY_CANCEL_BUTTON = '' " ## ## ##

    IMPORTING

      ANSWER                = LV_ANSWER

    EXCEPTIONS

      TEXT_NOT_FOUND        = 1

      OTHERS                = 2.



  " 4. #### '#(1)'# ### #### ## ## ##

  IF LV_ANSWER = '1'.

    PERFORM SAVE_DATA.

  ELSE.

    MESSAGE '#######.' TYPE 'S'.

  ENDIF.



ENDFORM.




**&---------------------------------------------------------------------*

**& Form CANCEL_DATA

**&----------------------------------------------------------------------

**& text ##

**&---------------------------------------------------------------------*

*FORM CANCEL_DATA .

*  DATA: LV_ANSWER TYPE C.

*  DATA: LV_COUNT TYPE I.

*

*  " 1. ## ##

*  READ TABLE GT_ITEM WITH KEY L_CHECK = 'X' TRANSPORTING NO FIELDS.

*  IF SY-SUBRC <> 0.

*    MESSAGE '### ### #####.' TYPE 'S' DISPLAY LIKE 'E'.

*    EXIT.

*  ENDIF.

*

*  " 2. ## ##

*  CALL FUNCTION 'POPUP_TO_CONFIRM'

*    EXPORTING

*      TITLEBAR      = '## ##'

*      TEXT_QUESTION = '### ### ### ##(##)######?'

*      TEXT_BUTTON_1 = '#'

*      ICON_BUTTON_1 = 'ICON_OKAY'

*      TEXT_BUTTON_2 = '###'

*      ICON_BUTTON_2 = 'ICON_CANCEL'

*    IMPORTING

*      ANSWER        = LV_ANSWER.

*

*  IF LV_ANSWER <> '1'.

*    EXIT.

*  ENDIF.

*

*  " 3. DB ## (ZEILE ##)

*  LOOP AT GT_ITEM INTO GS_ITEM WHERE L_CHECK = 'X'.

*

*    " [##] ### Key(MBLNR, MJAHR, ZEILE)# ##

*    DELETE FROM ZEDT10_MSEG

*      WHERE MBLNR = P_MBLNR       " ### ## ## (####)

*        AND MJAHR = P_MJAHR       " ### ## ## (##)

*        AND ZEILE = GS_ITEM-ZEILE. " [##] #### ##

*

*    IF SY-SUBRC = 0.

*      GS_ITEM-ICON    = ICON_DELETE.

*      GS_ITEM-MESSAGE = '## ##'.

*    ELSE.

*      GS_ITEM-ICON    = ICON_RED_LIGHT.

*      GS_ITEM-MESSAGE = '## ## (## ###### # ###)'.

*      ROLLBACK WORK.

*    ENDIF.

*

*    MODIFY GT_ITEM FROM GS_ITEM.

*  ENDLOOP.

*

*  " 4. ## ## (## #### ### ### ##)

*  SELECT COUNT( * ) INTO LV_COUNT

*    FROM ZEDT10_MSEG

*    WHERE MBLNR = P_MBLNR

*      AND MJAHR = P_MJAHR.

*

*  IF LV_COUNT = 0.

*    DELETE FROM ZEDT10_MKPF

*      WHERE MBLNR = P_MBLNR

*        AND MJAHR = P_MJAHR.

*  ENDIF.

*

*  " 5. ## # ## ##

*  COMMIT WORK AND WAIT.

*

*  MESSAGE '## #######.' TYPE 'S'.

*

**  " ### #### #### ## ## ##

**  PERFORM GET_DATA.

*  PERFORM REFRESH_ALV.

*ENDFORM.

*

*&---------------------------------------------------------------------*

*& Form CANCEL_DATA

*&---------------------------------------------------------------------*




FORM CANCEL_DATA .

  DATA: LV_ANSWER    TYPE C,

        LV_NEW_MBLNR TYPE ZEDT10_MKPF-MBLNR, " ### # ####

        LS_MKPF      TYPE ZEDT10_MKPF,

        LS_MSEG      TYPE ZEDT10_MSEG,

        LT_MSEG      TYPE TABLE OF ZEDT10_MSEG,

        LV_ZEILE     TYPE ZEDT10_MSEG-ZEILE,

        LS_T003      TYPE ZEDT10_T003,

        LV_RC        TYPE INRI-NRRANGENR.



  " [##] PO ##

  DATA: LS_EKBE TYPE ZEDT10_EKBE,

        LT_EKBE TYPE TABLE OF ZEDT10_EKBE.



  " [##] ## ## ###(101) ###

  DATA: LS_ORG_MSEG TYPE ZEDT10_MSEG,

        LV_EXIST    TYPE ZEDT10_MSEG-MBLNR.



  " 1. #### ### ### ### ##

  READ TABLE GT_ITEM WITH KEY L_CHECK = 'X' TRANSPORTING NO FIELDS.

  IF SY-SUBRC <> 0.

    MESSAGE '### ### #####.' TYPE 'S' DISPLAY LIKE 'E'.

    EXIT.

  ENDIF.



  " 2. ### ## ##

  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      TITLEBAR      = '## ##'

      TEXT_QUESTION = '### ### ## ## ##(##)# ########?'

      TEXT_BUTTON_1 = '#(Yes)'

      ICON_BUTTON_1 = 'ICON_OKAY'

      TEXT_BUTTON_2 = '###(No)'

      ICON_BUTTON_2 = 'ICON_CANCEL'

    IMPORTING

      ANSWER        = LV_ANSWER.



  IF LV_ANSWER <> '1'.

    MESSAGE '#######.' TYPE 'S'.

    EXIT.

  ENDIF.



  " 3. [##] ## #### ## (Step 1# ### ## ###)

  " ## ### ### ## ##### ### ## ## ###.

  SELECT SINGLE * INTO LS_T003 FROM ZEDT10_T003 WHERE BLART = 'WE'.

  LV_RC = LS_T003-NUMKR.



  CALL FUNCTION 'NUMBER_GET_NEXT'

    EXPORTING

      NR_RANGE_NR = LV_RC

      OBJECT      = 'ZMBELN10'

    IMPORTING

      NUMBER      = LV_NEW_MBLNR. " #: 5000000002



  " 4. ## ### ## (ZEDT10_MKPF)

  CLEAR LS_MKPF.

  LS_MKPF-MBLNR = LV_NEW_MBLNR.    " # ##

  LS_MKPF-MJAHR = SY-DATUM(4).     " ## ##

  LS_MKPF-BLART = 'WE'.            " ## ##

  LS_MKPF-BLDAT = SY-DATUM.        " ###

  LS_MKPF-BUDAT = SY-DATUM.        " ###

  LS_MKPF-USNAM = SY-UNAME.

  LS_MKPF-XBLNR = 'Cancellation'.  " ##: ###



  " 5. ### ### ## (ZEDT10_MSEG) - ### ## ##

  LV_ZEILE = 0.



  LOOP AT GT_ITEM INTO GS_ITEM WHERE L_CHECK = 'X'.

    ADD 1 TO LV_ZEILE.

    CLEAR LS_MSEG.



    " (1) ## # ##

    LS_MSEG-MANDT = SY-MANDT.

    LS_MSEG-MBLNR = LV_NEW_MBLNR.  " # ##

    LS_MSEG-MJAHR = SY-DATUM(4).

    LS_MSEG-ZEILE = LV_ZEILE.



    " (2) [##] ### ##

    LS_MSEG-BWART = '102'.         " ####: 101(##) -> 102(##)

    LS_MSEG-SHKZG = 'H'.           " ###: S(##) -> H(##)



    " (3) ### ## (##, ## ## ### ####)

    LS_MSEG-MATNR = GS_ITEM-MATNR.

    LS_MSEG-WERKS = GS_ITEM-WERKS.

    LS_MSEG-LGORT = GS_ITEM-LGORT.

    LS_MSEG-LIFNR = GS_ITEM-LIFNR.

    LS_MSEG-MENGE = GS_ITEM-MENGE. " ### ## (## ## ##)

    LS_MSEG-MEINS = GS_ITEM-MEINS.

    LS_MSEG-DMBTR = GS_ITEM-NETPR * GS_ITEM-MENGE. " ##

    LS_MSEG-WAERS = GS_ITEM-WAERS.

    LS_MSEG-EBELN = GS_ITEM-EBELN.

    LS_MSEG-EBELP = GS_ITEM-EBELP.



    " (4) ## ## ## (#### ### ### ## ##)

    " LS_MSEG-STBLG = P_MBLNR. " ## ## ## (## ## # ## ##)

    " LS_MSEG-STJAH = P_MJAHR. " ## ## ## (## ## # ## ##)



    APPEND LS_MSEG TO LT_MSEG.



    " -------------------------------------------------------------

    " [##] ZEDT10_EKBE (#### ##) ## ### ##

    " ## ##: [1][3]

    " -------------------------------------------------------------

    CLEAR LS_EKBE.

    LS_EKBE-MANDT = SY-MANDT.

    LS_EKBE-EBELN = GS_ITEM-EBELN.

    LS_EKBE-EBELP = GS_ITEM-EBELP.

    LS_EKBE-ZEKKN = '01'.                " ## ##

    LS_EKBE-VGABE = '1'.                 " ## ##: 1 (## ##### ##) [3]

    LS_EKBE-GJAHR = SY-DATUM(4).         " #### (### ##)

    LS_EKBE-BELNR = LV_NEW_MBLNR.        " ## ## ## (## ### ##)

    LS_EKBE-BUZEI = LV_ZEILE.            " ## ## ##



    LS_EKBE-BEWTP = 'E'.                 " ##: E [3]

    LS_EKBE-BWART = '102'.               " ## ##: 102 (##) [3]

    LS_EKBE-SHKZG = 'H'.                 " ###: H (Credit) [3]



    LS_EKBE-MENGE = GS_ITEM-MENGE.       " ## ## (## ## ##)

    LS_EKBE-MEINS = GS_ITEM-MEINS.

    LS_EKBE-DMBTR = GS_ITEM-NETPR * GS_ITEM-MENGE. " ## ##

    LS_EKBE-WAERS = GS_ITEM-WAERS.



    APPEND LS_EKBE TO LT_EKBE.

    " -------------------------------------------------------------



    " ## ### ## (### ##)

    GS_ITEM-ICON = ICON_DELETE.

    GS_ITEM-MESSAGE = '## ##(102) ##'.

    MODIFY GT_ITEM FROM GS_ITEM.

  ENDLOOP.



  " 6. DB ## (INSERT)

  INSERT ZEDT10_MKPF FROM LS_MKPF.

  IF SY-SUBRC <> 0.

    ROLLBACK WORK.

    MESSAGE '## ## ## ## ##' TYPE 'E'.

    EXIT.

  ENDIF.



  INSERT ZEDT10_MSEG FROM TABLE LT_MSEG.

  IF SY-SUBRC <> 0.

    ROLLBACK WORK.

    MESSAGE '## ## ### ## ##' TYPE 'E'.

    EXIT.

  ENDIF.



  " [##] #### ## ##

  INSERT ZEDT10_EKBE FROM TABLE LT_EKBE.

  IF SY-SUBRC <> 0.

    ROLLBACK WORK.

    MESSAGE '## ##(EKBE) ## ##' TYPE 'E'.

    EXIT.

  ENDIF.



  COMMIT WORK AND WAIT.

  MESSAGE '## ## ### #######.' TYPE 'S'.



  " 7. ## ##

  PERFORM REFRESH_ALV.



ENDFORM.




*&---------------------------------------------------------------------*

*& Form GET_GR_QTY

*&---------------------------------------------------------------------*

*  ##: PO ### ### ##(101 - 102) ## [2]

*----------------------------------------------------------------------*




FORM GET_GR_QTY USING P_EBELN P_EBELP

                CHANGING P_DONE_QTY.



  DATA: LV_GR101 TYPE ZEDT10_MSEG-MENGE,

        LV_GR102 TYPE ZEDT10_MSEG-MENGE.



  " 1. ##(101) ##

  SELECT SUM( MENGE ) INTO LV_GR101

    FROM ZEDT10_MSEG

    WHERE EBELN = P_EBELN

      AND EBELP = P_EBELP

      AND BWART = '101'

    AND SHKZG = 'S'.



  IF LV_GR101 IS INITIAL.

    LV_GR101 = 0.

  ENDIF.



  " 2. ##(102) ##

  SELECT SUM( MENGE ) INTO LV_GR102

    FROM ZEDT10_MSEG

    WHERE EBELN = P_EBELN

      AND EBELP = P_EBELP

      AND BWART = '102'

         AND SHKZG = 'H'.



  IF LV_GR102 IS INITIAL.

    LV_GR102 = 0.

  ENDIF.



  " 3. ## #### = ## - ##

  P_DONE_QTY = LV_GR101 - LV_GR102.



ENDFORM.