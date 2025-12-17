
*&---------------------------------------------------------------------*

*&  Include           ZMM14_004_F01

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

        'BUZEI' '####' '' 10 '' CHANGING GT_FCAT,

        'WRBTR' '##' '' 10 'C' CHANGING GT_FCAT,

        'WAERS' '##' '' 10 '' CHANGING GT_FCAT,

        'WMWST' '##' '' 10 'C' CHANGING GT_FCAT,

        'MENGE' '##' '' 10 'Q' CHANGING GT_FCAT,

        'MEINS' '##' '' 10 '' CHANGING GT_FCAT,

        'STPRS' '##' '' 10 'C' CHANGING GT_FCAT,

        'MWSKZ' '####' '' 10 '' CHANGING GT_FCAT,

        'ZTERM' '####' '' 10 '' CHANGING GT_FCAT,

        'EBELP' '######' '' 10 '' CHANGING GT_FCAT,

        'MATNR' '####' '' 10 '' CHANGING GT_FCAT,

        'MAKTX' '###' '' 10 '' CHANGING GT_FCAT,

        'SGTXT' '####' 'X' 10 '' CHANGING GT_FCAT.



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

  LS_FCAT-REF_TABLE = 'ZRSEG_14'.



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



  GS_100-EBELN = P_EBELN.  "####

  GS_100-WERKS = P_WERKS.  "###

  GS_100-BLDAT = P_BUDAT.  "###(####)

  GS_100-BUDAT = P_BUDAT.  "###



  SELECT SINGLE A~NAME1 C~ZTERM   "####

    INTO CORRESPONDING FIELDS OF GS_100

    FROM ZLFA1_14 AS A

    JOIN ZEKKO_14 AS B ON A~LIFNR = B~LIFNR

    JOIN ZLFB1_14 AS C ON B~LIFNR = C~LIFNR

    WHERE B~EBELN = P_EBELN.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_ITEM_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM GET_ITEM_DATA .



  DATA: LT_DONE TYPE TABLE OF ZRSEG_14,

        LS_DONE TYPE ZRSEG_14.



  CLEAR GT_CREATE.



  SELECT * INTO CORRESPONDING FIELDS OF TABLE GT_CREATE

    FROM ZEKPO_14 AS A

    JOIN ZEKKO_14 AS B ON A~EBELN = B~EBELN

    WHERE A~EBELN = P_EBELN

      AND A~WERKS = P_WERKS.



  IF SY-SUBRC <> 0.

    MESSAGE '### PO #### ####.' TYPE 'S' DISPLAY LIKE 'W'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  "## #### # ####### ##

  SELECT EBELN EBELP

    INTO CORRESPONDING FIELDS OF TABLE LT_DONE

    FROM ZRSEG_14

    WHERE EBELN = P_EBELN.



  IF LT_DONE[] IS NOT INITIAL.

    LOOP AT LT_DONE INTO LS_DONE.

      DELETE GT_CREATE WHERE EBELN = LS_DONE-EBELN

                         AND EBELP = LS_DONE-EBELP.

    ENDLOOP.

  ENDIF.



  LOOP AT GT_CREATE INTO GS_CREATE.

    GS_CREATE-BUZEI = SY-TABIX.  "## ##

    GS_CREATE-WRBTR = GS_CREATE-MENGE * GS_CREATE-STPRS.  "## ##

    GS_CREATE-ZTERM = GS_100-ZTERM.  "####



    CASE GS_CREATE-MWSKZ.

      WHEN 'V1' OR 'V5'.  "####(10%) OR ######(10%)

        GS_CREATE-WMWST = GS_CREATE-WRBTR * '0.1'.

      WHEN OTHERS.      "V2(##), V3(##), V4(###)# 0#

        GS_CREATE-WMWST = 0.

    ENDCASE.



    MODIFY GT_CREATE FROM GS_CREATE INDEX SY-TABIX.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALCULATE_AMOUNT

*&---------------------------------------------------------------------*

* ### ### ### ### #### ### ##

*----------------------------------------------------------------------*




FORM CALCULATE_AMOUNT .



  DATA: LV_NETWR TYPE ZRBKP_14-RMWWR. " # #### ## ####



  " 1. ALV #### ####(#### #)# ### #### ##

  CALL METHOD GO_GRID_100->CHECK_CHANGED_DATA.

  " 2. ## ## ###

  CLEAR: GS_HEADER, LV_NETWR.

  " 3. ### ### ## ## ## ##

  LOOP AT GT_CREATE INTO GS_CREATE WHERE ZCHECK = 'X'.

    LV_NETWR        = LV_NETWR        + GS_CREATE-WRBTR. " #### ##

    GS_HEADER-WMWST = GS_HEADER-WMWST + GS_CREATE-WMWST. " ## ##

  ENDLOOP.

  " 4. ##(RMWWR) = #### ## + ## ##

  GS_HEADER-RMWWR = LV_NETWR + GS_HEADER-WMWST.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM SAVE_DATA .



  DATA: LT_RBKP TYPE TABLE OF ZRBKP_14,

        LS_RBKP TYPE ZRBKP_14,

        LT_RSEG TYPE TABLE OF ZRSEG_14,

        LS_RSEG TYPE ZRSEG_14.



  DATA: LV_BELNR TYPE ZRBKP_14-BELNR,

        LV_NETWR TYPE ZRBKP_14-RMWWR,  "# #### ## ##

        LV_WMWST TYPE ZRBKP_14-WMWST,  "## ## ##

        LV_TOTAL TYPE ZRBKP_14-RMWWR.



  "#### ### ## ### ## #### ##

  CALL METHOD GO_GRID_100->CHECK_CHANGED_DATA.

  "### ## ##

  LOOP AT GT_CREATE INTO GS_CREATE WHERE ZCHECK = 'X'.

    EXIT.

  ENDLOOP.



  IF SY-SUBRC <> 0.

    MESSAGE '### ### ####.' TYPE 'S' DISPLAY LIKE 'W'.

    EXIT.

  ENDIF.



  CLEAR: LV_NETWR, LV_WMWST, LV_TOTAL.

  LOOP AT GT_CREATE INTO GS_CREATE WHERE ZCHECK = 'X'.

    LV_NETWR = LV_NETWR + GS_CREATE-WRBTR.  "#### ##

    LV_WMWST = LV_WMWST + GS_CREATE-WMWST.  "## ##

    IF LS_RBKP-MWSKZ IS INITIAL.

      LS_RBKP-MWSKZ = GS_CREATE-MWSKZ.

    ENDIF.

  ENDLOOP.



  LV_TOTAL = LV_NETWR + LV_WMWST.

  IF GS_HEADER-RMWWR IS INITIAL.

    MESSAGE '### # ### ######.' TYPE 'S' DISPLAY LIKE 'W'.

    EXIT.

  ENDIF.

  IF GS_HEADER-RMWWR <> LV_TOTAL.

    MESSAGE '# ### ### ### #### ####.' TYPE 'S' DISPLAY LIKE 'W'.

    EXIT.

  ENDIF.



  SELECT MAX( BELNR ) INTO LV_BELNR

    FROM ZRBKP_14 WHERE GJAHR = GS_100-BUDAT(4).



  "###### ##

  IF LV_BELNR IS INITIAL.

    LV_BELNR = '5000000000'.  "### ##

  ELSE.

    LV_BELNR = LV_BELNR + 1.

  ENDIF.



  SELECT SINGLE BUKRS LIFNR WAERS

    INTO (LS_RBKP-BUKRS, LS_RBKP-LIFNR, LS_RBKP-WAERS)

    FROM ZEKKO_14

    WHERE EBELN = P_EBELN.



  "## ### ## (ZRBKP_14)

  LS_RBKP-BELNR = LV_BELNR.             "######

  LS_RBKP-GJAHR = GS_100-BUDAT(4).      "##

  LS_RBKP-BLART = 'RE'.                 "## ##

  LS_RBKP-BLDAT = GS_100-BLDAT.         "###

  LS_RBKP-BUDAT = GS_100-BUDAT.         "###

  LS_RBKP-ZTERM = GS_100-ZTERM.         "####

  LS_RBKP-RMWWR = GS_HEADER-RMWWR.      "##

  LS_RBKP-WMWST = GS_HEADER-WMWST.      "# ##




*  LS_RBKP-XMWST =

*  LS_RBKP-STBLG =

*  LS_RBKP-STJAH =

*  LS_RBKP-RBSTAT =




  LS_RBKP-BKTXT = GS_100-BKTXT.         "## ##

  LS_RBKP-EBELN = P_EBELN.              "######

  LS_RBKP-WERKS = P_WERKS.              "###



  "### ### ## (ZRSEG_14)

  LOOP AT GT_CREATE INTO GS_CREATE WHERE ZCHECK = 'X'.

    CLEAR LS_RSEG.



    MOVE-CORRESPONDING GS_CREATE TO LS_RSEG.

    LS_RSEG-BELNR = LV_BELNR.           "#### ##

    LS_RSEG-GJAHR = GS_100-BUDAT(4).    "####

    LS_RSEG-MAKTX = GS_CREATE-MAKTX.    "###

    LS_RSEG-BSTME = GS_CREATE-MEINS.    "######



    APPEND LS_RSEG TO LT_RSEG.

  ENDLOOP.



  INSERT ZRBKP_14 FROM LS_RBKP.

  INSERT ZRSEG_14 FROM TABLE LT_RSEG.



  IF SY-SUBRC EQ 0.

    COMMIT WORK AND WAIT.

    MESSAGE |## ## { LV_BELNR }# #######.| TYPE 'S'.



    DELETE GT_CREATE WHERE ZCHECK = 'X'.

    PERFORM REFRESH_ALV_100.

  ELSE.

    ROLLBACK WORK.

    MESSAGE '## # ### ######.' TYPE 'E'.

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