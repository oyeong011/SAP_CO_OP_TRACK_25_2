
*&---------------------------------------------------------------------*

*&  Include           ZMM15_004_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SCREEN_CONTROL

*&---------------------------------------------------------------------*




FORM SCREEN_CONTROL .

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.

      IF P_R1 = 'X'.

        SCREEN-ACTIVE = '1'.

      ELSEIF P_R2 = 'X'.

        SCREEN-ACTIVE = '0'.

      ENDIF.

      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_INPUT

*&---------------------------------------------------------------------*




FORM CHECK_INPUT .

  IF P_R1 = 'X'.

    IF P_EBELN = '' OR P_WERKS = '' OR P_BLDAT = ''.

      MESSAGE '## ## ## #####' TYPE 'E'.

    ENDIF.

  ELSEIF P_R2 = 'X'.

    IF P_EBELN = '' OR P_WERKS = ''.

      MESSAGE '## ## ## #####' TYPE 'E'.

    ENDIF.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_EBELN

*&---------------------------------------------------------------------*

*       ###### ###

*----------------------------------------------------------------------*




FORM CHECK_EBELN .

  DATA : LV_EBELN TYPE EBELN.

  CHECK P_EBELN IS NOT INITIAL.



  SELECT SINGLE EBELN

    FROM ZEKKO_15

    INTO LV_EBELN

    WHERE EBELN = P_EBELN.



  IF SY-SUBRC <> 0.

    MESSAGE '#### ## #######' TYPE 'E'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*




FORM GET_DATA .

  PERFORM GET_HEADER.

  PERFORM GET_ITEM.



  PERFORM CALCULATE_DUE_DATE.



  "####

   G_WMWST1 = 0. "##

   G_BALANCE = 0. "##



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_HEADER

*&---------------------------------------------------------------------*




FORM GET_HEADER .



  "###, ####, ###### ####

  SELECT SINGLE BUKRS LIFNR WAERS

    FROM ZEKKO_15

    INTO ( GV_BUKRS, GV_LIFNR, G_WAERS )

    WHERE EBELN = P_EBELN.



  "#### ####

  SELECT SINGLE MWSKZ

    FROM ZLFM1_15

    INTO G_MWSKZ

    WHERE LIFNR = GV_LIFNR.



   "#### ####

   SELECT SINGLE ZTERM

     FROM ZLFB1_15

     INTO G_ZTERM

     WHERE LIFNR = GV_LIFNR.



   G_BLDAT = P_BLDAT. "### (#####)

   G_BUDAT = SY-DATUM. "###

   G_WAERS2 = G_WAERS. "###



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_ITEM

*&---------------------------------------------------------------------*




FORM GET_ITEM .

  DATA : LS_EKPO TYPE ZEKPO_15,

        LT_EKPO LIKE TABLE OF LS_EKPO.

  DATA  : LV_PO_MENGE TYPE MENGE_D,

        LV_IV_MENGE TYPE MENGE_D.



  CLEAR : GT_ALV_100, GS_ALV_100.



  "EKPO## SELECT

  SELECT *

    FROM ZEKPO_15

    INTO CORRESPONDING FIELDS OF TABLE LT_EKPO

    WHERE EBELN = P_EBELN

    AND WERKS = P_WERKS.





  LOOP AT LT_EKPO INTO LS_EKPO.

    CLEAR : GS_ALV_100, LV_PO_MENGE, LV_IV_MENGE.



    "PO ##

    LV_PO_MENGE = LS_EKPO-MENGE.



    "## ## ### ##

    SELECT SUM( MENGE )

    FROM ZRSEG_15

    INTO LV_IV_MENGE

    WHERE EBELN = LS_EKPO-EBELN

    AND   EBELP = LS_EKPO-EBELP

    AND   MATNR = LS_EKPO-MATNR.



    IF LV_IV_MENGE IS INITIAL.

      LV_IV_MENGE = 0.

    ENDIF.



    GS_ALV_100-MENGE = LV_PO_MENGE - LV_IV_MENGE.



    "#### ### CONTINUE

    IF GS_ALV_100-MENGE <= 0.

      CONTINUE.

    ENDIF.



    GS_ALV_100-CHECK = ''.

    GS_ALV_100-BUZEI = SY-TABIX * 1.

    GS_ALV_100-NETPR = LS_EKPO-STPRS.

    GS_ALV_100-MENGE = LS_EKPO-MENGE.

    GS_ALV_100-MEINS = LS_EKPO-MEINS.

    GS_ALV_100-EBELN = LS_EKPO-EBELN.

    GS_ALV_100-EBELP = LS_EKPO-EBELP.

    GS_ALV_100-MATNR = LS_EKPO-MATNR.

    GS_ALV_100-ZMATNAME = LS_EKPO-MAKTX.

    GS_ALV_100-WERKS = LS_EKPO-WERKS.

    GS_ALV_100-MWSKZ_S = G_MWSKZ.

    GS_ALV_100-WAERS = G_WAERS.



    GS_ALV_100-WRBTR = GS_ALV_100-NETPR * GS_ALV_100-MENGE. "#### (## * ####)



    DATA : LV_RATE TYPE P DECIMALS 2.



    CASE G_MWSKZ.

      WHEN 'V1'. LV_RATE = C_V1.

      WHEN 'V2'. LV_RATE = C_V2.

      WHEN 'V3'. LV_RATE = C_V3.

      WHEN 'V4'. LV_RATE = C_V4.

      WHEN 'V5'. LV_RATE = C_V5.

    ENDCASE.



    GS_ALV_100-WMWST = GS_ALV_100-WRBTR * LV_RATE. "##

    GS_ALV_100-DMBTR = GS_ALV_100-WRBTR + GS_ALV_100-WMWST. "## (###+##)







    APPEND GS_ALV_100 TO GT_ALV_100.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*




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




FORM FIELD_CATALOG .

CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'CHECK'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-CHECKBOX = 'X'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'BUZEI'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'NETPR'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.

  GS_FIELDCAT-DATATYPE = 'INT'.

  GS_FIELDCAT-OUTPUTLEN = '15'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'WRBTR'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'EBELN'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'EBELP'.

  GS_FIELDCAT-COLTEXT = '##'. "#### ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'MWSKZ_S'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'WMWST'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'ZMATNAME'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'WERKS'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 15.

  GS_FIELDCAT-FIELDNAME = 'DMBTR'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 16.

  GS_FIELDCAT-FIELDNAME = 'SGTXT'.

  GS_FIELDCAT-COLTEXT = '###'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*




FORM ALV_LAYOUT .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-NO_TOOLBAR = 'X'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*




FORM CLASS_EVENT .

  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED

      .



  CREATE OBJECT GO_EVENT.



  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DISPLAY_ALV

*&---------------------------------------------------------------------*




FORM DISPLAY_ALV .

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_LAYOUT                     = GS_LAYOUT

    CHANGING

      IT_OUTTAB                     = GT_ALV_100

      IT_FIELDCATALOG               = GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DATA_CHANGED

*&---------------------------------------------------------------------*

*       ### ## ## ##

*----------------------------------------------------------------------*

*      -->P_ER_DATA_CHANGED  text

*      -->P_E_ONF4  text

*      -->P_E_ONF4_BEFORE  text

*      -->P_E_ONF4_AFTER  text

*      -->P_E_UCOMM  text

*----------------------------------------------------------------------*




FORM ALV_HANDLER_DATA_CHANGED  USING    P_ER_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                        P_E_ONF4

                                        P_E_ONF4_BEFORE

                                        P_E_ONF4_AFTER

                                        P_E_UCOMM.



  DATA: LS_MODI TYPE LVC_S_MODI.



  LOOP AT P_ER_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.

    LS_MODI-FIELDNAME = 'CHECK'.

      READ TABLE GT_ALV_100 INTO GS_ALV_100 INDEX LS_MODI-ROW_ID.

      IF SY-SUBRC = 0.

        GS_ALV_100-CHECK = LS_MODI-VALUE.

        MODIFY GT_ALV_100 FROM GS_ALV_100 INDEX LS_MODI-ROW_ID.

      ENDIF.

  ENDLOOP.



  PERFORM CALCULATE_TOTAL_HEADER.



  "### ## ## ## ### ## PBO ## ##

  CALL METHOD CL_GUI_CFW=>SET_NEW_OK_CODE

    EXPORTING

      NEW_CODE = 'REFRESH'. " PAI## ## ## # ## Dummy Code





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALCULATE_TOTAL_HEADER

*&---------------------------------------------------------------------*

*       ## ##, ## ##

*----------------------------------------------------------------------*




FORM CALCULATE_TOTAL_HEADER .

  DATA: LV_TOTAL_TAX TYPE ZRBKP_15-WMWST1,

        LV_TOTAL_GROSS TYPE ZRBKP_15-RMWWR.



  CLEAR: LV_TOTAL_TAX, LV_TOTAL_GROSS.



  " ### #### ### ##

  LOOP AT GT_ALV_100 INTO GS_ALV_100 WHERE CHECK = 'X'.

    LV_TOTAL_TAX   = LV_TOTAL_TAX + GS_ALV_100-WMWST.

    LV_TOTAL_GROSS = LV_TOTAL_GROSS + GS_ALV_100-DMBTR.

  ENDLOOP.



  " ## ##(##)# ##

  G_WMWST1 = LV_TOTAL_TAX.   " ## ##

  G_RMWWR  = LV_TOTAL_GROSS. " ## ##



  " ## = ###(G_WRBTR) - ### ###, ### ####### 0

  G_BALANCE = 0.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_INVOICE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_INVOICE .

  DATA: LS_RBKP TYPE ZRBKP_15,

        LS_RSEG TYPE ZRSEG_15.

  DATA: LV_CHECK_CNT TYPE I.

  DATA : LV_BUZEI TYPE ZRSEG_15-BUZEI.



  "## # ## ## # ##

  PERFORM CALCULATE_TOTAL_HEADER.



  " ### ## ### ##

  LOOP AT GT_ALV_100 TRANSPORTING NO FIELDS WHERE CHECK = 'X'.

    LV_CHECK_CNT = LV_CHECK_CNT + 1.

  ENDLOOP.



  IF LV_CHECK_CNT = 0.

    MESSAGE '### #### #####.' TYPE 'I' DISPLAY LIKE 'E'.

    EXIT.

  ENDIF.



  "######(BELNR) ##

  SELECT SINGLE MAX( BELNR ) FROM ZRBKP_15 INTO GV_BELNR.

  IF GV_BELNR IS INITIAL.

    GV_BELNR = '5100000000'. "### ##

  ELSE.

    GV_BELNR = GV_BELNR + 1.

  ENDIF.



  "##

    LS_RBKP-MANDT = SY-MANDT.

    LS_RBKP-BELNR = GV_BELNR. "## ###

    LS_RBKP-GJAHR = G_BUDAT+0(4). "#### - #### ##

    LS_RBKP-BLART = 'RE'.     "#### RE

    LS_RBKP-BLDAT = G_BLDAT.

    LS_RBKP-BUDAT = G_BUDAT.

    LS_RBKP-BUKRS  = GV_BUKRS. " #### (GET_HEADER## ### #)

    LS_RBKP-LIFNR  = GV_LIFNR. " #### (GET_HEADER## ### #)

    LS_RBKP-WAERS = G_WAERS.

    LS_RBKP-RMWWR = G_RMWWR. "#####

    LS_RBKP-WMWST1 = G_WMWST1. "## ##

    LS_RBKP-MWSKZ = G_MWSKZ. "####

    LS_RBKP-ZTERM = G_ZTERM. "#### #




*    LS_RBKP-BKTXT = G_BKTXT. "## ## ###




    LS_RBKP-STBLG = ''. "####### (###### ##)

    LS_RBKP-STJAH = ''. "##### ####

    LS_RBKP-RBSTAT = 5. "## ###

    LS_RBKP-ZFBDT = G_ZFBDT. "###



    INSERT INTO ZRBKP_15 VALUES LS_RBKP.



    IF SY-SUBRC <> 0.

    ROLLBACK WORK.

    MESSAGE '## ## # ### ######.' TYPE 'E'.

    EXIT.

  ENDIF.







    "###

    LOOP AT GT_ALV_100 INTO GS_ALV_100 WHERE CHECK = 'X'.

      CLEAR LS_RSEG.

      ADD 1 TO LV_BUZEI. "### ## ##



      LS_RSEG-MANDT = SY-MANDT.

      LS_RSEG-BELNR = GV_BELNR.

      LS_RSEG-GJAHR = G_BUDAT+0(4).

      LS_RSEG-BUZEI = LV_BUZEI.

      LS_RSEG-EBELN = P_EBELN.

      LS_RSEG-EBELP = GS_ALV_100-EBELP. "PO ####

      LS_RSEG-MATNR = GS_ALV_100-MATNR.

      LS_RSEG-WERKS = GS_ALV_100-WERKS.

      LS_RSEG-WRBTR = GS_ALV_100-WRBTR. "####




*      GS_RSEG-SHKZG = 'H'.  "### ##




      LS_RSEG-MENGE = GS_ALV_100-MENGE.

      LS_RSEG-MEINS = GS_ALV_100-MEINS.

      LS_RSEG-BPRME = GS_ALV_100-MEINS. "###### (######)

      LS_RSEG-NETPR = GS_ALV_100-NETPR. "##

      LS_RSEG-SGTXT = GS_ALV_100-SGTXT.

      LS_RSEG-DMBTR = GS_ALV_100-DMBTR. "##



      INSERT INTO ZRSEG_15 VALUES LS_RSEG.



      IF SY-SUBRC <> 0.

        ROLLBACK WORK.

        MESSAGE '### ## # ### ######.' TYPE 'E'.

        EXIT.

      ENDIF.

    ENDLOOP.





    "####

    COMMIT WORK AND WAIT.

    MESSAGE |#### #######. { GV_BELNR }## #######| TYPE 'S'.



    LEAVE TO SCREEN 0.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALCULATE_DUE_DATE

*&---------------------------------------------------------------------*

*       ### ##

*----------------------------------------------------------------------*




FORM CALCULATE_DUE_DATE .

  DATA : LV_BASE TYPE D,

         LV_YEAR TYPE N LENGTH 4,

         LV_MONTH TYPE N LENGTH 2,

         LV_DAY TYPE N LENGTH 2,

         LV_MONTH_ADD TYPE I.



  LV_BASE = G_BUDAT.

  LV_YEAR = LV_BASE+0(4).

  LV_MONTH = LV_BASE+4(2).

  LV_DAY = LV_BASE+6(2).



  CASE G_ZTERM.

    WHEN 'M001'. LV_MONTH_ADD = 0. LV_DAY = '10'.

    WHEN 'M002'. LV_MONTH_ADD = 0. LV_DAY = '25'.

    WHEN 'M003'. LV_MONTH_ADD = 1. LV_DAY = '10'.

    WHEN 'M004'. LV_MONTH_ADD = 1. LV_DAY = '25'.

    WHEN 'M005'. LV_MONTH_ADD = 2. LV_DAY = '10'.

    WHEN 'M006'. LV_MONTH_ADD = 2. LV_DAY = '25'.

    WHEN 'P010'. G_ZFBDT = LV_BASE + 10. RETURN.

    WHEN 'P015'. G_ZFBDT = LV_BASE + 15. RETURN.

    WHEN 'P020'. G_ZFBDT = LV_BASE + 20. RETURN.

    WHEN 'P030'. G_ZFBDT = LV_BASE + 30. RETURN.

    WHEN 'P060'. G_ZFBDT = LV_BASE + 60. RETURN.

    WHEN 'P090'. G_ZFBDT = LV_BASE + 90. RETURN.

  ENDCASE.



  LV_MONTH = LV_MONTH + LV_MONTH_ADD.

  IF LV_MONTH > 12.

    LV_MONTH = LV_MONTH - 12.

    LV_YEAR = LV_YEAR + 1.

  ENDIF.



  CONCATENATE LV_YEAR LV_MONTH LV_DAY INTO G_ZFBDT.

ENDFORM.