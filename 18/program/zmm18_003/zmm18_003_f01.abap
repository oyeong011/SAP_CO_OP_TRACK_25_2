
*&---------------------------------------------------------------------*

*&  Include           ZMM18_003_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  INITIALIZATION

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM INITIALIZATION .

  P_BUDAT = SY-DATUM.

  P_EBELN = 4500000001.

  P_WERKS = 1000.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  SET_SCREEN_OUTPUT

*&---------------------------------------------------------------------*

*       TEXT

*----------------------------------------------------------------------*

*  -->  P1        TEXT

*  <--  P2        TEXT

*----------------------------------------------------------------------*




FORM SET_SCREEN_OUTPUT .

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.  "###

      IF P_R1 = 'X'.          "##

        SCREEN-ACTIVE = '1'.

      ELSEIF P_R2 = 'X'.      "##

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.



    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_SCREEN_INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_SCREEN_INPUT .



  IF P_EBELN IS INITIAL.

    SET CURSOR FIELD 'P_EBELN'.

    MESSAGE '##### ## ## #####.'TYPE 'E'.

  ELSE.

    SELECT SINGLE EBELN FROM ZEKKO_18 INTO @DATA(LV_EBELN)

      WHERE EBELN = @P_EBELN.

    IF SY-SUBRC <> 0.

      SET CURSOR FIELD 'P_EBELN'.

      MESSAGE '#### ## #### #####.' TYPE 'E'.

    ENDIF.

  ENDIF.



  IF P_WERKS IS INITIAL.

    SET CURSOR FIELD 'P_WERKS'.

    MESSAGE '#### ## ## #####.' TYPE 'E'.

  ELSE.

    SELECT SINGLE WERKS FROM ZEKPO_18 INTO @DATA(LV_WERKS)

      WHERE WERKS = @P_WERKS.

    IF SY-SUBRC <> 0.

      SET CURSOR FIELD 'P_WERKS'.

      MESSAGE '#### ## ######.' TYPE 'E'.

    ENDIF.

  ENDIF.



  IF P_R1 = 'X'.

    IF P_BUDAT IS INITIAL.

      MESSAGE '###### ## ## #####.' TYPE 'E'.

      LEAVE LIST-PROCESSING.

    ENDIF.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&  Include           ZMM18_003_F01

*&---------------------------------------------------------------------*



*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT_0100

*&---------------------------------------------------------------------*




FORM CREATE_OBJECT_0100 .



  IF GO_CONT_100 IS INITIAL.

    CREATE OBJECT GO_CONT_100

      EXPORTING

        CONTAINER_NAME = GC_CONT1.

  ENDIF.



  IF GO_GRID_100 IS INITIAL.

    CREATE OBJECT GO_GRID_100

      EXPORTING

        I_PARENT = GO_CONT_100.

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT_0200

*&---------------------------------------------------------------------*




FORM CREATE_OBJECT_0200 .



  "##: #### ###

  IF GO_CONT_200_L IS INITIAL.

    CREATE OBJECT GO_CONT_200_L

      EXPORTING

        CONTAINER_NAME = GC_CONT2.

  ENDIF.



  IF GO_GRID_200_L IS INITIAL.

    CREATE OBJECT GO_GRID_200_L

      EXPORTING

        I_PARENT = GO_CONT_200_L.

  ENDIF.



  "##: ### ###

  IF GO_CONT_200_I IS INITIAL.

    CREATE OBJECT GO_CONT_200_I

      EXPORTING

        CONTAINER_NAME = GC_CONT3.

  ENDIF.



  IF GO_GRID_200_I IS INITIAL.

    CREATE OBJECT GO_GRID_200_I

      EXPORTING

        I_PARENT = GO_CONT_200_I.

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_0100

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG_0100 .



  DATA: LS_FCAT TYPE LVC_S_FCAT.



  CLEAR GT_FIELDCAT_100.



  "1) ####

  CLEAR LS_FCAT.

  LS_FCAT-COL_POS   = 1.

  LS_FCAT-FIELDNAME = 'L_CHECK'.

  LS_FCAT-SCRTEXT_M = '##'.

  LS_FCAT-CHECKBOX  = 'X'.

  LS_FCAT-EDIT      = 'X'.

  LS_FCAT-OUTPUTLEN = 4.

  APPEND LS_FCAT TO GT_FIELDCAT_100.



  "2) PO

  CLEAR LS_FCAT.

  LS_FCAT-COL_POS   = 2.

  LS_FCAT-FIELDNAME = 'EBELN'.

  LS_FCAT-SCRTEXT_M = 'PO'.

  LS_FCAT-OUTPUTLEN = 12.

  APPEND LS_FCAT TO GT_FIELDCAT_100.



  "3) PO ##

  CLEAR LS_FCAT.

  LS_FCAT-COL_POS   = 3.

  LS_FCAT-FIELDNAME = 'EBELP'.

  LS_FCAT-SCRTEXT_M = '##'.

  LS_FCAT-OUTPUTLEN = 5.

  APPEND LS_FCAT TO GT_FIELDCAT_100.



  "4) ###

  CLEAR LS_FCAT.

  LS_FCAT-COL_POS   = 4.

  LS_FCAT-FIELDNAME = 'LIFNR'.

  LS_FCAT-SCRTEXT_M = '###'.

  LS_FCAT-OUTPUTLEN = 10.

  APPEND LS_FCAT TO GT_FIELDCAT_100.



  "5) ###

  CLEAR LS_FCAT.

  LS_FCAT-COL_POS   = 5.

  LS_FCAT-FIELDNAME = 'BEDAT'.

  LS_FCAT-SCRTEXT_M = '###'.

  LS_FCAT-OUTPUTLEN = 10.

  APPEND LS_FCAT TO GT_FIELDCAT_100.



  "6) ####

  CLEAR LS_FCAT.

  LS_FCAT-COL_POS   = 6.

  LS_FCAT-FIELDNAME = 'MATNR'.

  LS_FCAT-SCRTEXT_M = '##'.

  LS_FCAT-OUTPUTLEN = 12.

  APPEND LS_FCAT TO GT_FIELDCAT_100.



  "7) ###

  CLEAR LS_FCAT.

  LS_FCAT-COL_POS   = 7.

  LS_FCAT-FIELDNAME = 'MAKTX'.

  LS_FCAT-SCRTEXT_M = '###'.

  LS_FCAT-OUTPUTLEN = 20.

  APPEND LS_FCAT TO GT_FIELDCAT_100.



  "8) PO##

  CLEAR LS_FCAT.

  LS_FCAT-COL_POS   = 17.

  LS_FCAT-FIELDNAME = 'MENGE'.

  LS_FCAT-SCRTEXT_M = 'PO##'.

  LS_FCAT-OUTPUTLEN = 10.

  APPEND LS_FCAT TO GT_FIELDCAT_100.



  "9) ##

  CLEAR LS_FCAT.

  LS_FCAT-COL_POS   = 9.

  LS_FCAT-FIELDNAME = 'MEINS'.

  LS_FCAT-SCRTEXT_M = '##'.

  LS_FCAT-OUTPUTLEN = 5.

  APPEND LS_FCAT TO GT_FIELDCAT_100.



  "10) ##(BPRME)

  CLEAR LS_FCAT.

  LS_FCAT-COL_POS   = 10.

  LS_FCAT-FIELDNAME = 'BPRME'.

  LS_FCAT-SCRTEXT_M = '##'.

  LS_FCAT-OUTPUTLEN = 10.

  APPEND LS_FCAT TO GT_FIELDCAT_100.



  "11) ##

  CLEAR LS_FCAT.

  LS_FCAT-COL_POS   = 11.

  LS_FCAT-FIELDNAME = 'WAERS'.

  LS_FCAT-SCRTEXT_M = '##'.

  LS_FCAT-OUTPUTLEN = 5.

  APPEND LS_FCAT TO GT_FIELDCAT_100.



  "12) ###

  CLEAR LS_FCAT.

  LS_FCAT-COL_POS   = 12.

  LS_FCAT-FIELDNAME = 'PRDAT'.

  LS_FCAT-SCRTEXT_M = '###'.

  LS_FCAT-OUTPUTLEN = 10.

  APPEND LS_FCAT TO GT_FIELDCAT_100.



  "13) ###

  CLEAR LS_FCAT.

  LS_FCAT-COL_POS   = 13.

  LS_FCAT-FIELDNAME = 'WERKS'.

  LS_FCAT-SCRTEXT_M = '###'.

  LS_FCAT-OUTPUTLEN = 6.

  APPEND LS_FCAT TO GT_FIELDCAT_100.



  "14) ####

  CLEAR LS_FCAT.

  LS_FCAT-COL_POS   = 14.

  LS_FCAT-FIELDNAME = 'LGORT'.

  LS_FCAT-SCRTEXT_M = '####'.

  LS_FCAT-OUTPUTLEN = 6.

  APPEND LS_FCAT TO GT_FIELDCAT_100.



  "15) ####

  CLEAR LS_FCAT.

  LS_FCAT-COL_POS   = 15.

  LS_FCAT-FIELDNAME = 'GR_DONE'.

  LS_FCAT-SCRTEXT_M = '####'.

  LS_FCAT-OUTPUTLEN = 10.

  APPEND LS_FCAT TO GT_FIELDCAT_100.



  "16) ##

  CLEAR LS_FCAT.

  LS_FCAT-COL_POS   = 16.

  LS_FCAT-FIELDNAME = 'GR_REM'.

  LS_FCAT-SCRTEXT_M = '##'.

  LS_FCAT-OUTPUTLEN = 10.

  APPEND LS_FCAT TO GT_FIELDCAT_100.



  "17) ####(##)

  CLEAR LS_FCAT.

  LS_FCAT-COL_POS   = 18.

  LS_FCAT-FIELDNAME = 'GR_NOW'.

  LS_FCAT-SCRTEXT_M = '####'.

  LS_FCAT-EDIT      = 'X'.

  LS_FCAT-OUTPUTLEN = 10.

  APPEND LS_FCAT TO GT_FIELDCAT_100.



ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_0200_L

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG_0200_L .



  DATA: LS_FCAT TYPE LVC_S_FCAT.



  CLEAR GT_FIELDCAT_200_L.



  CLEAR LS_FCAT.

  LS_FCAT-COL_POS   = 1.

  LS_FCAT-FIELDNAME = 'DISP_TEXT'.

  LS_FCAT-SCRTEXT_M = '####'.

  LS_FCAT-OUTPUTLEN = 60.

  APPEND LS_FCAT TO GT_FIELDCAT_200_L.



ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_0200_I

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG_0200_I .



  DATA: LS_FCAT TYPE LVC_S_FCAT.



  CLEAR GT_FIELDCAT_200_I.



  CLEAR LS_FCAT.

  LS_FCAT-COL_POS   = 1.

  LS_FCAT-FIELDNAME = 'LV_CHECK'.

  LS_FCAT-SCRTEXT_M = '##'.

  LS_FCAT-CHECKBOX  = 'X'.

  LS_FCAT-EDIT      = 'X'.

  LS_FCAT-OUTPUTLEN = 4.

  APPEND LS_FCAT TO GT_FIELDCAT_200_I.



  CLEAR LS_FCAT.

  LS_FCAT-COL_POS   = 2.

  LS_FCAT-FIELDNAME = 'MBLNR'.

  LS_FCAT-SCRTEXT_M = '##'.

  LS_FCAT-OUTPUTLEN = 12.

  APPEND LS_FCAT TO GT_FIELDCAT_200_I.



  CLEAR LS_FCAT.

  LS_FCAT-COL_POS   = 3.

  LS_FCAT-FIELDNAME = 'ZEILE'.

  LS_FCAT-SCRTEXT_M = '##'.

  LS_FCAT-OUTPUTLEN = 5.

  APPEND LS_FCAT TO GT_FIELDCAT_200_I.



  CLEAR LS_FCAT.

  LS_FCAT-COL_POS   = 4.

  LS_FCAT-FIELDNAME = 'EBELN'.

  LS_FCAT-SCRTEXT_M = 'PO'.

  LS_FCAT-OUTPUTLEN = 12.

  APPEND LS_FCAT TO GT_FIELDCAT_200_I.



  CLEAR LS_FCAT.

  LS_FCAT-COL_POS   = 5.

  LS_FCAT-FIELDNAME = 'EBELP'.

  LS_FCAT-SCRTEXT_M = '##'.

  LS_FCAT-OUTPUTLEN = 5.

  APPEND LS_FCAT TO GT_FIELDCAT_200_I.



  CLEAR LS_FCAT.

  LS_FCAT-COL_POS   = 6.

  LS_FCAT-FIELDNAME = 'LIFNR'.

  LS_FCAT-SCRTEXT_M = '###'.

  LS_FCAT-OUTPUTLEN = 10.

  APPEND LS_FCAT TO GT_FIELDCAT_200_I.



  CLEAR LS_FCAT.

  LS_FCAT-COL_POS   = 7.

  LS_FCAT-FIELDNAME = 'MATNR'.

  LS_FCAT-SCRTEXT_M = '##'.

  LS_FCAT-OUTPUTLEN = 12.

  APPEND LS_FCAT TO GT_FIELDCAT_200_I.



  CLEAR LS_FCAT.

  LS_FCAT-COL_POS   = 8.

  LS_FCAT-FIELDNAME = 'MAKTX'.

  LS_FCAT-SCRTEXT_M = '###'.

  LS_FCAT-OUTPUTLEN = 20.

  APPEND LS_FCAT TO GT_FIELDCAT_200_I.



  CLEAR LS_FCAT.

  LS_FCAT-COL_POS   = 9.

  LS_FCAT-FIELDNAME = 'MENGE'.

  LS_FCAT-SCRTEXT_M = '##'.

  LS_FCAT-OUTPUTLEN = 10.

  APPEND LS_FCAT TO GT_FIELDCAT_200_I.



  CLEAR LS_FCAT.

  LS_FCAT-COL_POS   = 10.

  LS_FCAT-FIELDNAME = 'MEINS'.

  LS_FCAT-SCRTEXT_M = '##'.

  LS_FCAT-OUTPUTLEN = 5.

  APPEND LS_FCAT TO GT_FIELDCAT_200_I.



  CLEAR LS_FCAT.

  LS_FCAT-COL_POS   = 11.

  LS_FCAT-FIELDNAME = 'WERKS'.

  LS_FCAT-SCRTEXT_M = '###'.

  LS_FCAT-OUTPUTLEN = 6.

  APPEND LS_FCAT TO GT_FIELDCAT_200_I.



  CLEAR LS_FCAT.

  LS_FCAT-COL_POS   = 12.

  LS_FCAT-FIELDNAME = 'LGORT'.

  LS_FCAT-SCRTEXT_M = '####'.

  LS_FCAT-OUTPUTLEN = 6.

  APPEND LS_FCAT TO GT_FIELDCAT_200_I.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*




FORM ALV_LAYOUT_0100 .

  CLEAR GS_LAYOUT_100.

  GS_LAYOUT_100-ZEBRA = 'X'.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY_0100

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY_0100 .

  CALL METHOD GO_GRID_100->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      I_SAVE          = 'A'

      IS_LAYOUT       = GS_LAYOUT_100

    CHANGING

      IT_OUTTAB       = GT_ITEM

      IT_FIELDCATALOG = GT_FIELDCAT_100.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY_0200_L

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY_0200_L .

  CALL METHOD GO_GRID_200_L->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      I_SAVE          = 'A'

      IS_LAYOUT       = GS_LAYOUT_200_L

    CHANGING

      IT_OUTTAB       = GT_GOODS_ALV

      IT_FIELDCATALOG = GT_FIELDCAT_200_L.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY_0200_I

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY_0200_I .

  CALL METHOD GO_GRID_200_I->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      I_SAVE          = 'A'

      IS_LAYOUT       = GS_LAYOUT_200_I

    CHANGING

      IT_OUTTAB       = GT_ITEM_ALV

      IT_FIELDCATALOG = GT_FIELDCAT_200_I.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH_GRID

*&---------------------------------------------------------------------*




FORM REFRESH_GRID USING PO_GRID TYPE REF TO CL_GUI_ALV_GRID.

  DATA: LS_STABLE TYPE LVC_S_STBL.



  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD PO_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE = LS_STABLE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT_0100

*&---------------------------------------------------------------------*




FORM CLASS_EVENT_0100 .



  "## ### ##(#### ## ##)

  CALL METHOD GO_GRID_100->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.



  CALL METHOD GO_GRID_100->SET_READY_FOR_INPUT

    EXPORTING

      I_READY_FOR_INPUT = 1.



  IF GO_EVENT_100 IS INITIAL.

    CREATE OBJECT GO_EVENT_100.

  ENDIF.



  SET HANDLER GO_EVENT_100->HANDLER_DATA_CHANGED FOR GO_GRID_100.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT_0200

*&---------------------------------------------------------------------*




FORM CLASS_EVENT_0200 .



  IF GO_EVENT_200_L IS INITIAL.

    CREATE OBJECT GO_EVENT_200_L.

  ENDIF.

  SET HANDLER GO_EVENT_200_L->HANDLER_DOUBLE_CLICK FOR GO_GRID_200_L.



  GO_GRID_200_I->REGISTER_EDIT_EVENT(

    EXPORTING I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED ).



  GO_GRID_200_I->SET_READY_FOR_INPUT( EXPORTING I_READY_FOR_INPUT = 1 ).



  IF GO_EVENT_200_I IS INITIAL.

    CREATE OBJECT GO_EVENT_200_I.

  ENDIF.

  SET HANDLER GO_EVENT_200_I->HANDLER_DATA_CHANGED FOR GO_GRID_200_I.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_PO_ITEMS

*&---------------------------------------------------------------------*




FORM GET_PO_ITEMS .



  DATA: LT_PO     TYPE TABLE OF ZEKPO_18,

        LS_PO     TYPE ZEKPO_18,

        LS_EKKO   TYPE ZEKKO_18,

        LV_SUM_GR TYPE MENGE_D.



  CLEAR: GT_ITEM, GS_ITEM.



  "1) PO ##(###/####)

  CLEAR LS_EKKO.

  SELECT SINGLE * FROM ZEKKO_18 INTO LS_EKKO

    WHERE EBELN = P_EBELN.

  IF SY-SUBRC <> 0.

    MESSAGE '#### ## PO###.' TYPE 'E'.

  ENDIF.

  GF_BLDAT = LS_EKKO-BEDAT.   "### = PO ###

  GF_BUDAT = SY-DATUM.        "### = ##

  GF_MJAHR = GF_BUDAT+0(4).   "#### = ### ##

  GF_BLART = 'WE'.



  "2) PO ###

  CLEAR LT_PO.

  SELECT * FROM ZEKPO_18 INTO TABLE LT_PO

    WHERE EBELN = P_EBELN

      AND WERKS = P_WERKS.



  IF LT_PO IS INITIAL.

    MESSAGE '### ## PO #### ####.' TYPE 'I'.

    EXIT.

  ENDIF.



  "3) ## ITAB(GT_ITEM) ## + ####/## ##

  LOOP AT LT_PO INTO LS_PO.



    CLEAR GS_ITEM.



    GS_ITEM-EBELN    = LS_PO-EBELN.

    GS_ITEM-EBELP    = LS_PO-EBELP.

    GS_ITEM-MATNR    = LS_PO-MATNR.

    GS_ITEM-MENGE    = LS_PO-MENGE.

    GS_ITEM-MEINS    = LS_PO-MEINS.

    GS_ITEM-PRDAT    = LS_PO-PRDAT.

    GS_ITEM-WERKS    = LS_PO-WERKS.

    GS_ITEM-LGORT    = LS_PO-LGORT.



    GS_ITEM-LIFNR    = LS_EKKO-LIFNR.

    GS_ITEM-BEDAT    = LS_EKKO-BEDAT.



    "###

    PERFORM GET_MATNAME USING    GS_ITEM-MATNR

                       CHANGING GS_ITEM-MAKTX.



    "####

    CLEAR LV_SUM_GR.



    SELECT SUM( MENGE )

      INTO LV_SUM_GR

      FROM ZMSEG_18

     WHERE EBELN = GS_ITEM-EBELN

       AND EBELP = GS_ITEM-EBELP.



    IF LV_SUM_GR IS INITIAL.

      LV_SUM_GR = 0.

    ENDIF.



    GS_ITEM-GR_DONE = LV_SUM_GR.

    GS_ITEM-GR_REM  = GS_ITEM-MENGE - GS_ITEM-GR_DONE.



    IF GS_ITEM-GR_REM < 0.

      GS_ITEM-GR_REM = 0.

    ENDIF.



    "###

    GS_ITEM-GR_NOW = 0.



    APPEND GS_ITEM TO GT_ITEM.

  ENDLOOP.



ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  GET_MATNAME

*&---------------------------------------------------------------------*




FORM GET_MATNAME USING    PV_MATNR TYPE ZEKPO_18-MATNR

                 CHANGING PV_NAME  TYPE ZMARA_18-MAKTX.



  CLEAR PV_NAME.

  IF PV_MATNR IS INITIAL.

    EXIT.

  ENDIF.



  SELECT SINGLE MAKTX FROM ZMARA_18 INTO PV_NAME

    WHERE MATNR = PV_MATNR.



  IF SY-SUBRC <> 0.

    CLEAR PV_NAME.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  POST_GR_0100

*&---------------------------------------------------------------------*




FORM POST_GR_0100 .



  DATA: LV_HAS_SEL   TYPE C,

        LV_MBLNR_NEW TYPE ZMKPF_18-MBLNR,

        LV_ZEILE     TYPE ZMSEG_18-ZEILE.



  "ALV## ### ##

  IF GO_GRID_100 IS NOT INITIAL.

    CALL METHOD GO_GRID_100->CHECK_CHANGED_DATA.

  ENDIF.



  "## ##

  CLEAR LV_HAS_SEL.

  LOOP AT GT_ITEM INTO GS_ITEM WHERE L_CHECK = 'X'.

    LV_HAS_SEL = 'X'.

    EXIT.

  ENDLOOP.



  IF LV_HAS_SEL IS INITIAL.

    MESSAGE '### ### #####.' TYPE 'I'.

    EXIT.

  ENDIF.



  "#### ##

  PERFORM GET_NEXT_MBLNR CHANGING LV_MBLNR_NEW.



  "## ## (0100 #### ##)

  CLEAR GS_MKPF.

  GS_MKPF-MBLNR = LV_MBLNR_NEW.

  GS_MKPF-MJAHR = GF_MJAHR.

  GS_MKPF-BLART = GF_BLART.

  GS_MKPF-BLDAT = GF_BLDAT.

  GS_MKPF-BUDAT = GF_BUDAT.



  "# #### ###/### ## ### #### ##



  INSERT ZMKPF_18 FROM GS_MKPF.

  IF SY-SUBRC <> 0.

    MESSAGE '## ## ## ##' TYPE 'E'.

  ENDIF.



  "### ##

  CLEAR LV_ZEILE.

  LV_ZEILE = 0.



  LOOP AT GT_ITEM INTO GS_ITEM WHERE L_CHECK = 'X'.



    "## ##

    IF GS_ITEM-GR_NOW <= 0.

      MESSAGE '#### ### 0## ## ###.' TYPE 'E'.

    ENDIF.



    IF GS_ITEM-GR_NOW > GS_ITEM-GR_REM.

      MESSAGE |##({ GS_ITEM-GR_REM })# ### # ####.| TYPE 'E'.

    ENDIF.

  ENDLOOP.



  PERFORM GET_NEXT_MBLNR CHANGING LV_MBLNR_NEW.



  CLEAR GS_MKPF.

  GS_MKPF-MBLNR = LV_MBLNR_NEW.

  GS_MKPF-MJAHR = GF_MJAHR.

  GS_MKPF-BLART = GF_BLART.

  GS_MKPF-BLDAT = GF_BLDAT.

  GS_MKPF-BUDAT = GF_BUDAT.



  INSERT ZMKPF_18 FROM GS_MKPF.

  IF SY-SUBRC <> 0.

    MESSAGE '## ## ## ##' TYPE 'E'.

  ENDIF.



  LV_ZEILE = 0.

  LOOP AT GT_ITEM INTO GS_ITEM WHERE L_CHECK = 'X'.

    LV_ZEILE = LV_ZEILE + 1.



    CLEAR GS_MSEG.

    GS_MSEG-MBLNR = LV_MBLNR_NEW.

    GS_MSEG-ZEILE = LV_ZEILE.

    GS_MSEG-EBELN = GS_ITEM-EBELN.

    GS_MSEG-EBELP = GS_ITEM-EBELP.

    GS_MSEG-MATNR = GS_ITEM-MATNR.

    GS_MSEG-MENGE = GS_ITEM-GR_NOW.

    GS_MSEG-MEINS = GS_ITEM-MEINS.

    GS_MSEG-WERKS = GS_ITEM-WERKS.

    GS_MSEG-LGORT = GS_ITEM-LGORT.

    GS_MSEG-LIFNR = GS_ITEM-LIFNR.



    INSERT ZMSEG_18 FROM GS_MSEG.

    IF SY-SUBRC <> 0.

      MESSAGE '## ### ## ##' TYPE 'E'.

    ENDIF.

  ENDLOOP.



  COMMIT WORK.



  MESSAGE |#### { LV_MBLNR_NEW } ## ##| TYPE 'S'.



  "## # 0100 ## ##(## ###)

  PERFORM GET_PO_ITEMS.

  PERFORM REFRESH_GRID USING GO_GRID_100.



ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  GET_NEXT_MBLNR

*&---------------------------------------------------------------------*




FORM GET_NEXT_MBLNR CHANGING PV_MBLNR TYPE ZMKPF_18-MBLNR.



  DATA: LV_MAX TYPE ZMKPF_18-MBLNR.



  CLEAR LV_MAX.

  SELECT MAX( MBLNR ) FROM ZMKPF_18 INTO LV_MAX.



  IF LV_MAX IS INITIAL.

    PV_MBLNR = '5000000001'.

  ELSE.

    PV_MBLNR = LV_MAX + 1.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  BUILD_GOODS_LIST_0200

*&---------------------------------------------------------------------*




FORM BUILD_GOODS_LIST_0200 .



  DATA: LT_MKPF TYPE TABLE OF ZMKPF_18,

        LS_MKPF TYPE ZMKPF_18.



  CLEAR: GT_GOODS_LIST, GT_GOODS_ALV.



  "## ### #### #### (### WHERE ## ## ##)

  SELECT * FROM ZMKPF_18 INTO TABLE LT_MKPF

    ORDER BY BUDAT DESCENDING MBLNR DESCENDING.



  LOOP AT LT_MKPF INTO LS_MKPF.

    CLEAR GS_GOODS_LIST.

    GS_GOODS_LIST-MBLNR = LS_MKPF-MBLNR.

    GS_GOODS_LIST-BUDAT = LS_MKPF-BUDAT.

    APPEND GS_GOODS_LIST TO GT_GOODS_LIST.



    CLEAR GS_GOODS_ALV.

    "####(# ##)

    CONCATENATE LS_MKPF-MBLNR ' / ' LS_MKPF-BUDAT INTO GS_GOODS_ALV-DISP_TEXT.

    APPEND GS_GOODS_ALV TO GT_GOODS_ALV.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DOUBLE_CLICK

*&---------------------------------------------------------------------*




FORM ALV_HANDLER_DOUBLE_CLICK USING P_E_ROW TYPE LVC_S_ROW

                                    P_E_COL TYPE LVC_S_COL

                                    P_ES_ROW TYPE LVC_S_ROID.



  DATA: LV_INDEX TYPE I.



  LV_INDEX = P_E_ROW-INDEX.

  IF LV_INDEX IS INITIAL.

    EXIT.

  ENDIF.



  "## ##### ### #### ##

  READ TABLE GT_GOODS_LIST INTO GS_GOODS_LIST INDEX LV_INDEX.

  IF SY-SUBRC <> 0.

    EXIT.

  ENDIF.



  PERFORM GET_GOODS_DETAIL_0200 USING GS_GOODS_LIST-MBLNR.



ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  GET_GOODS_DETAIL_0200

*&---------------------------------------------------------------------*




FORM GET_GOODS_DETAIL_0200 USING PV_MBLNR TYPE ZMKPF_18-MBLNR.



  DATA: LS_MKPF TYPE ZMKPF_18,

        LT_MSEG TYPE TABLE OF ZMSEG_18,

        LS_MSEG TYPE ZMSEG_18,

        LV_NAME TYPE ZMARA_18-MAKTX.



  "##

  CLEAR LS_MKPF.

  SELECT SINGLE * FROM ZMKPF_18 INTO LS_MKPF

    WHERE MBLNR = PV_MBLNR.



  IF SY-SUBRC <> 0.

    MESSAGE '### ## # ####.' TYPE 'I'.

    EXIT.

  ENDIF.



  "###200 ## ### ##(### ## GF_*_200# ###)

  GF_MBLNR_200 = LS_MKPF-MBLNR.

  GF_BLART_200 = LS_MKPF-BLART.

  GF_BLDAT_200 = LS_MKPF-BLDAT.

  GF_BUDAT_200 = LS_MKPF-BUDAT.



  "###

  CLEAR: GT_ITEM_ALV.

  SELECT * FROM ZMSEG_18 INTO TABLE LT_MSEG

    WHERE MBLNR = PV_MBLNR

    ORDER BY ZEILE ASCENDING.



  LOOP AT LT_MSEG INTO LS_MSEG.

    CLEAR GS_ITEM_ALV.



    GS_ITEM_ALV-ZEILE = LS_MSEG-ZEILE.

    GS_ITEM_ALV-MATNR = LS_MSEG-MATNR.

    GS_ITEM_ALV-MENGE = LS_MSEG-MENGE.

    GS_ITEM_ALV-MEINS = LS_MSEG-MEINS.

    GS_ITEM_ALV-WERKS = LS_MSEG-WERKS.

    GS_ITEM_ALV-LGORT = LS_MSEG-LGORT.

    GS_ITEM_ALV-LIFNR = LS_MSEG-LIFNR.



    "### ###

    CLEAR LV_NAME.

    PERFORM GET_MATNAME USING    LS_MSEG-MATNR

                       CHANGING LV_NAME.

    GS_ITEM_ALV-MAKTX = LV_NAME.



    APPEND GS_ITEM_ALV TO GT_ITEM_ALV.

  ENDLOOP.



  "ALV ##

  IF GO_GRID_200_I IS NOT INITIAL.

    PERFORM REFRESH_GRID USING GO_GRID_200_I.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_SCREEN_0100

*&---------------------------------------------------------------------*




FORM MODIFY_SCREEN_0100.



  LOOP AT SCREEN.



    "#: ####### ##### ## ##

    IF SCREEN-NAME = 'GF_MBLNR'.

      SCREEN-INPUT = 0.

    ENDIF.



    "#: ##### ### ## ## ##### ##

    IF SCREEN-NAME = 'GF_MJAHR'.

      SCREEN-INPUT = 0.

    ENDIF.



    "#: ##### ##### ##

    IF SCREEN-NAME = 'GF_BLART'.

      SCREEN-INPUT = 0.

    ENDIF.



    MODIFY SCREEN.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT_0200

*&---------------------------------------------------------------------*




FORM ALV_LAYOUT_0200 .

  CLEAR GS_LAYOUT_200_L.

  GS_LAYOUT_200_L-ZEBRA = 'X'.



  CLEAR GS_LAYOUT_200_I.

  GS_LAYOUT_200_I-ZEBRA = 'X'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CANCEL_GR_0200

*&---------------------------------------------------------------------*




FORM CANCEL_GR_0200 .



  DATA: LV_MBLNR TYPE ZMKPF_18-MBLNR.



  LV_MBLNR = GF_MBLNR_200.

  IF LV_MBLNR IS INITIAL.

    MESSAGE '### ### #####.' TYPE 'I'.

    EXIT.

  ENDIF.



  LOOP AT GT_ITEM_ALV INTO GS_ITEM_ALV WHERE LV_CHECK = 'X'.

    DELETE FROM ZMSEG_18

     WHERE MBLNR = LV_MBLNR

       AND ZEILE = GS_ITEM_ALV-ZEILE.

  ENDLOOP.



  "### # #### ### ### ## (##)

  SELECT COUNT(*) FROM ZMSEG_18 WHERE MBLNR = LV_MBLNR.

  IF SY-DBCNT = 0.

    DELETE FROM ZMKPF_18 WHERE MBLNR = LV_MBLNR.

  ENDIF.



  COMMIT WORK.



  "## ##

  PERFORM BUILD_GOODS_LIST_0200.

  CLEAR GT_ITEM_ALV.

  PERFORM REFRESH_GRID USING GO_GRID_200_L.

  PERFORM REFRESH_GRID USING GO_GRID_200_I.



  "0100# ## ### ### (#### ## ##)

  PERFORM GET_PO_ITEMS.

  IF GO_GRID_100 IS NOT INITIAL.

    PERFORM REFRESH_GRID USING GO_GRID_100.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DATA_CHANGED

*&---------------------------------------------------------------------*




FORM ALV_HANDLER_DATA_CHANGED USING    PR_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                      P_ONF4          TYPE CHAR01

                                      P_ONF4_BEFORE   TYPE CHAR01

                                      P_ONF4_AFTER    TYPE CHAR01

                                      P_UCOMM         TYPE SYUCOMM.



  DATA: LS_MOD TYPE LVC_S_MODI.



  "### ## ### GR_NOW# ##

  LOOP AT PR_DATA_CHANGED->MT_MOD_CELLS INTO LS_MOD.



    IF LS_MOD-FIELDNAME = 'GR_NOW'.



      READ TABLE GT_ITEM INTO GS_ITEM INDEX LS_MOD-ROW_ID.

      IF SY-SUBRC <> 0.

        CONTINUE.

      ENDIF.



      "##->## ##(##)

      GS_ITEM-GR_NOW = LS_MOD-VALUE.



      "##1: 0## ## #

      IF GS_ITEM-GR_NOW <= 0.

        CALL METHOD PR_DATA_CHANGED->ADD_PROTOCOL_ENTRY

          EXPORTING

            I_MSGID     = '00'

            I_MSGNO     = '001'

            I_MSGTY     = 'E'

            I_MSGV1     = '##### 0## ## ###.'

            I_FIELDNAME = 'GR_NOW'

            I_ROW_ID    = LS_MOD-ROW_ID.

        CONTINUE.

      ENDIF.



      "##2: ## ## ##

      IF GS_ITEM-GR_NOW > GS_ITEM-GR_REM.

        CALL METHOD PR_DATA_CHANGED->ADD_PROTOCOL_ENTRY

          EXPORTING

            I_MSGID     = '00'

            I_MSGNO     = '001'

            I_MSGTY     = 'E'

            I_MSGV1     = '### ### # ####.'

            I_FIELDNAME = 'GR_NOW'

            I_ROW_ID    = LS_MOD-ROW_ID.

        CONTINUE.

      ENDIF.



      "## #### ITAB# ##

      MODIFY GT_ITEM FROM GS_ITEM INDEX LS_MOD-ROW_ID.



    ENDIF.

  ENDLOOP.



ENDFORM.