
*&---------------------------------------------------------------------*

*&  Include           ZMM14_003_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SCREEN_OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM SCREEN_OUTPUT .



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

*&      Form  CREATE_OBJECT_100

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT_100 .



  CREATE OBJECT GO_CUSTOM_100

    EXPORTING

      CONTAINER_NAME = 'CC_ALV_100'.



  CREATE OBJECT GO_GRID_100

    EXPORTING

      I_PARENT = GO_CUSTOM_100.



  CREATE OBJECT GO_EVENT_100.

  SET HANDLER GO_EVENT_100->HANDLE_DATA_CHANGED FOR GO_GRID_100.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_100

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG_100 .



  CLEAR : GT_FCAT, GS_FCAT.



  PERFORM FILL_FCAT USING :

        'ZCHECK' '##' 'X' 5 'CH' CHANGING GT_FCAT,

        'EBELN' '######' '' 10 '' CHANGING GT_FCAT,

        'EBELP' '##' '' 10 '' CHANGING GT_FCAT,

        'LIFNR' '#####' '' 10 '' CHANGING GT_FCAT,

        'BEDAT' '###' '' 10 'D' CHANGING GT_FCAT,

        'MATNR' '####' '' 10 '' CHANGING GT_FCAT,

        'MAKTX' '###' '' 10 '' CHANGING GT_FCAT,

        'MENGE' 'PO##' '' 10 'Q' CHANGING GT_FCAT,

        'OPEN_MENGE' 'PO##' '' 10 'Q' CHANGING GT_FCAT,

        'GR_MENGE' '####' 'X' 10 'Q' CHANGING GT_FCAT,

        'MEINS' '##' '' 10 '' CHANGING GT_FCAT,

        'STPRS' '##' '' 10 'C' CHANGING GT_FCAT,

        'WAERS' '##' '' 10 '' CHANGING GT_FCAT,

        'PRDAT' '###' '' 10 '' CHANGING GT_FCAT,

        'WERKS' '###' '' 10 '' CHANGING GT_FCAT,

        'LGORT' '####' '' 10 '' CHANGING GT_FCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FILL_FCAT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM FILL_FCAT USING PV_FIELD PV_TXT PV_EDIT PV_LEN PV_XFIELD

               CHANGING CT_FCAT TYPE LVC_T_FCAT.



  DATA : LS_FCAT TYPE LVC_S_FCAT.



  LS_FCAT-FIELDNAME = PV_FIELD.

  LS_FCAT-COLTEXT = PV_TXT.

  LS_FCAT-EDIT = PV_EDIT.

  LS_FCAT-OUTPUTLEN = PV_LEN.

  LS_FCAT-JUST = 'R'.

  LS_FCAT-REF_TABLE = 'ZEKPO_14'.



  IF PV_FIELD = 'GR_MENGE' OR PV_FIELD = 'OPEN_MENGE'.

    LS_FCAT-REF_FIELD = 'MENGE'.

  ENDIF.



  IF PV_XFIELD = 'CH'.

    CLEAR LS_FCAT-REF_TABLE.

    LS_FCAT-CHECKBOX = 'X'.

  ELSEIF PV_XFIELD = 'Q'.

    LS_FCAT-QFIELDNAME = 'MEINS'.

  ELSEIF PV_XFIELD = 'C'.

    LS_FCAT-CFIELDNAME = 'WAERS'.

  ELSEIF PV_XFIELD = 'D'.

    LS_FCAT-REF_TABLE = 'ZEKKO_14'.

  ENDIF.



  APPEND LS_FCAT TO CT_FCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_HEADER_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM GET_HEADER_DATA .



  GS_100-GJAHR = P_BUDAT+0(4).  "####

  GS_100-BUDAT = P_BUDAT.  "###

  GS_100-BLDAT = P_BUDAT.  "###

  GS_100-BLART = 'WE'.  "####



  "#### & ###

  SELECT SINGLE A~NAME1

    INTO CORRESPONDING FIELDS OF GS_100

    FROM ZLFA1_14 AS A

    JOIN ZEKKO_14 AS B ON A~LIFNR = B~LIFNR

    WHERE B~EBELN = P_EBELN.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_ITEM_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM GET_ITEM_DATA .



  CLEAR GT_CREATE.



  SELECT * INTO CORRESPONDING FIELDS OF TABLE GT_CREATE

    FROM ZEKPO_14 AS A

    JOIN ZEKKO_14 AS B ON A~EBELN = B~EBELN

    WHERE A~EBELN = P_EBELN

      AND A~WERKS = P_WERKS.



  IF SY-SUBRC <> 0.

    MESSAGE '#### ### ####.' TYPE 'S' DISPLAY LIKE 'W'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  DATA: LV_PREV_GR TYPE ZEKPO_14-MENGE. "### ## (## = PO## - ####)



  LOOP AT GT_CREATE INTO GS_CREATE.

    CLEAR LV_PREV_GR.



    "## ## ## ## (## PO# ## ## ### ##)

    SELECT SUM( MENGE ) INTO LV_PREV_GR

      FROM ZMSEG_14

      WHERE EBELN = GS_CREATE-EBELN

        AND ZEILE = GS_CREATE-EBELP.




*       AND SHKZG = 'S'. "S:## (H:## # ## ## ## ##)






    "PO## = PO## - ## ####

    GS_CREATE-OPEN_MENGE = GS_CREATE-MENGE - LV_PREV_GR.

    "### ### ##(#### ## ##)

    GS_CREATE-GR_MENGE = GS_CREATE-OPEN_MENGE.



    MODIFY GT_CREATE FROM GS_CREATE.

  ENDLOOP.



  DELETE GT_CREATE WHERE OPEN_MENGE <= 0.



  IF GT_CREATE IS INITIAL.

    MESSAGE '### ### ####.' TYPE 'S' DISPLAY LIKE 'E'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM SAVE_DATA .



  DATA: LT_MKPF TYPE TABLE OF ZMKPF_14,

        LS_MKPF TYPE ZMKPF_14,

        LT_MSEG TYPE TABLE OF ZMSEG_14,

        LS_MSEG TYPE ZMSEG_14.



  DATA: LV_MBLNR TYPE ZMKPF_14-MBLNR,

        LV_PREV_GR TYPE ZMSEG_14-MENGE.



  "#### ### ## ### ## #### ##

  CALL METHOD GO_GRID_100->CHECK_CHANGED_DATA.

  "### ## ##

  LOOP AT GT_CREATE INTO GS_CREATE WHERE ZCHECK = 'X'.

    EXIT.

  ENDLOOP.



  IF SY-SUBRC <> 0.

    MESSAGE '## ### ######.' TYPE 'S' DISPLAY LIKE 'W'.

    EXIT.

  ENDIF.



  "######(MBLNR) ##

  SELECT MAX( MBLNR ) INTO LV_MBLNR FROM ZMKPF_14 WHERE MJAHR = GS_100-GJAHR.

  IF LV_MBLNR IS INITIAL.

    LV_MBLNR = '5000000000'. "### ##

  ELSE.

    LV_MBLNR = LV_MBLNR + 1.

  ENDIF.



  "## ### ##

  LS_MKPF-MBLNR = LV_MBLNR.         "######

  LS_MKPF-MJAHR = GS_100-GJAHR.     "####

  LS_MKPF-BLART = GS_100-BLART.     "####

  LS_MKPF-BLDAT = GS_100-BLDAT.     "###

  LS_MKPF-BUDAT = GS_100-BUDAT.     "###

  LS_MKPF-EBELN = GS_CREATE-EBELN.  "######

  LS_MKPF-WERKS = GS_CREATE-WERKS.  "###

  APPEND LS_MKPF TO LT_MKPF.



  "## ### ##

  LOOP AT GT_CREATE INTO GS_CREATE WHERE ZCHECK = 'X'.

    " ##### 0### ### ##

    IF GS_CREATE-GR_MENGE <= 0.

      MESSAGE '## ### ####.' TYPE 'S' DISPLAY LIKE 'W'.

      CONTINUE.

    ENDIF.



    CLEAR LS_MSEG.

    CLEAR LV_PREV_GR.  "### ##



    SELECT SUM( MENGE ) INTO LV_PREV_GR

      FROM ZMSEG_14

      WHERE EBELN = GS_CREATE-EBELN

        AND ZEILE = GS_CREATE-EBELP.



    "## ## ### #### ## ## ##

    GS_CREATE-OPEN_MENGE = GS_CREATE-MENGE - ( LV_PREV_GR + GS_CREATE-GR_MENGE ).

    IF GS_CREATE-OPEN_MENGE < 0.

      MESSAGE '## ### ### #######.' TYPE 'S' DISPLAY LIKE 'W'.

      CONTINUE.

    ENDIF.



    MODIFY GT_CREATE FROM GS_CREATE.



    LS_MSEG-MBLNR = LV_MBLNR.

    LS_MSEG-MJAHR = GS_100-GJAHR.

    LS_MSEG-ZEILE = GS_CREATE-EBELP.

    LS_MSEG-MATNR = GS_CREATE-MATNR.

    LS_MSEG-WERKS = GS_CREATE-WERKS.

    LS_MSEG-LGORT = GS_CREATE-LGORT.

    LS_MSEG-LIFNR = GS_CREATE-LIFNR.

    LS_MSEG-WAERS = GS_CREATE-WAERS.

    LS_MSEG-MENGE = GS_CREATE-GR_MENGE.

    LS_MSEG-MEINS = GS_CREATE-MEINS.

    LS_MSEG-EBELN = GS_CREATE-EBELN.




*    LS_MSEG-EBELP = GS_CREATE-EBELP.




    LS_MSEG-BUKRS = GS_CREATE-BUKRS.

    LS_MSEG-GJAHR = GS_100-GJAHR.




*    LS_MSEG-BELNR = '1'.

*    LS_MSEG-SHKZG = 'S'.

*    LS_MSEG-DMBTR = GS_CREATE-GR_MENGE * GS_CREATE-STPRS. " ##(STPRS) ##

*    LS_MSEG-BWART = '101'.






    APPEND LS_MSEG TO LT_MSEG.

  ENDLOOP.



  IF LT_MSEG IS NOT INITIAL.

    INSERT ZMKPF_14 FROM TABLE LT_MKPF.

    INSERT ZMSEG_14 FROM TABLE LT_MSEG.



    IF SY-SUBRC = 0.

      COMMIT WORK.

      MESSAGE '##### #######. ####:' && LV_MBLNR TYPE 'S'.

      "### ## #### ##




*      LOOP AT GT_CREATE ASSIGNING FIELD-SYMBOL(<FS_CREATE>).

*        <FS_CREATE>-GR_MENGE = 0.

*      ENDLOOP.




      DELETE GT_CREATE WHERE OPEN_MENGE <= 0.

      PERFORM REFRESH_ALV_100.



    ELSE.

      ROLLBACK WORK.

      MESSAGE '### ######.' TYPE 'E'.

    ENDIF.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT_100

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT_100 .



  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-NO_TOOLBAR = 'X'.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_METHOD_100

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM CALL_METHOD_100 .



  CALL METHOD GO_GRID_100->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.



  CALL METHOD GO_GRID_100->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_LAYOUT       = GS_LAYOUT

    CHANGING

      IT_OUTTAB       = GT_CREATE

      IT_FIELDCATALOG = GT_FCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH_ALV_100

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM REFRESH_ALV_100 .



  DATA: LS_STABLE TYPE LVC_S_STBL.

  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GO_GRID_100->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE = LS_STABLE.



ENDFORM.