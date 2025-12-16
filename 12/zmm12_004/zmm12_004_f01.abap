
*&---------------------------------------------------------------------*

*&  Include           ZMM12_004_F01

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

  P_DATE = SY-DATUM.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_SCREEN

*&---------------------------------------------------------------------*




FORM SET_SCREEN .

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.      " ######

      IF P_RD1 = 'X'.

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_MANDATORY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_MANDATORY .

  IF P_EBELN IS INITIAL OR P_WERKS IS INITIAL

    OR ( P_RD1 = 'X' AND P_DATE IS INITIAL ).

    MESSAGE I000.

    STOP.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  EXIST_PO

*&---------------------------------------------------------------------*




FORM EXIST_PO .

  DATA: LS_ZEKKO TYPE ZEKKO_12.

  SELECT SINGLE * FROM ZEKKO_12

    INTO CORRESPONDING FIELDS OF LS_ZEKKO        " #### ##

    WHERE EBELN = P_EBELN.                           "PO##

  IF SY-SUBRC <> 0.

    MESSAGE I001.

    STOP.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_PO_DATA

*&---------------------------------------------------------------------*




FORM GET_PO_DATA .

   "## 10%

  CONSTANTS: C_VAT10 TYPE P DECIMALS 2 VALUE '0.10'.



  "##### ####(BUZEI) ##

  DATA: LT_INV_BUZEI TYPE SORTED TABLE OF ZRSEG_12-BUZEI

                    WITH UNIQUE KEY TABLE_LINE.



  "### EBELP Range

  DATA: LR_DEL_EBELP TYPE RANGE OF ZEKPO_12-EBELP,

        LS_DEL       LIKE LINE OF LR_DEL_EBELP.



   "# ####(### ##) ### ####

  DATA: LV_MWSKZ TYPE ZLFM1_12-MWSKZ.





  CLEAR: GT_PO.

  REFRESH: GT_PO, LT_INV_BUZEI, LR_DEL_EBELP.



  "1) #### ## (PO Item + Header)

  SELECT *

    INTO CORRESPONDING FIELDS OF TABLE GT_PO

    FROM ZEKPO_12 AS A

      LEFT OUTER JOIN ZEKKO_12 AS B

        ON A~EBELN = B~EBELN

    WHERE A~EBELN = P_EBELN

      AND A~WERKS = P_WERKS.





    "# #### #### ##

  READ TABLE GT_PO INTO GS_PO INDEX 1.

  IF SY-SUBRC = 0.

    SELECT SINGLE MWSKZ

      INTO LV_MWSKZ

      FROM ZLFM1_12

      WHERE LIFNR = GS_PO-LIFNR.

  ENDIF.







  "2) ## ##### ## ### ####(BUZEI) # ## ##

  SELECT BUZEI

    INTO TABLE LT_INV_BUZEI

    FROM ZRSEG_12

    WHERE EBELN = P_EBELN.



  "3) ###: ##### # ##, #### ## ##

  LOOP AT GT_PO INTO GS_PO.



    "##### ## ### ## ## ##

    READ TABLE LT_INV_BUZEI WITH KEY TABLE_LINE = GS_PO-EBELP TRANSPORTING NO FIELDS.

    IF SY-SUBRC = 0.

      CLEAR LS_DEL.

      LS_DEL-SIGN   = 'I'.

      LS_DEL-OPTION = 'EQ'.

      LS_DEL-LOW    = GS_PO-EBELP.

      APPEND LS_DEL TO LR_DEL_EBELP.

      CONTINUE.

    ENDIF.



    "# #### GT_PO# ##

    IF GS_PO-MWSKZ IS INITIAL.

      GS_PO-MWSKZ = LV_MWSKZ.

    ENDIF.



    "###, ##, ## ##

    GS_PO-NETAM = GS_PO-STPRS * GS_PO-MENGE.  "### = ## * ##



    CASE GS_PO-MWSKZ.

      WHEN 'V1' OR 'V4' OR 'V5'.

        GS_PO-MWSTS = GS_PO-NETAM * C_VAT10.  "##

      WHEN 'V2' OR 'V3'.

        GS_PO-MWSTS = 0.

      WHEN OTHERS.

        CLEAR GS_PO-MWSTS.

    ENDCASE.



    GS_PO-GROSS = GS_PO-NETAM + GS_PO-MWSTS. "###



    MODIFY GT_PO FROM GS_PO TRANSPORTING  mwskz NETAM MWSTS GROSS

      WHERE EBELN = GS_PO-EBELN

        AND EBELP = GS_PO-EBELP.



    CLEAR GS_PO.

  ENDLOOP.



  "4) ##### ## ##

  IF LR_DEL_EBELP IS NOT INITIAL.

    DELETE GT_PO WHERE EBELP IN LR_DEL_EBELP.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*




FORM CREATE_OBJECT .

  CREATE OBJECT GC_DOCKING

    EXPORTING

      REPID                       = SY-REPID  " #### ID

      DYNNR                       = SY-DYNNR  " ### ##

      EXTENSION                   = 2000.     " ## ##



  CREATE OBJECT GC_GRID

    EXPORTING

      I_PARENT          = GC_DOCKING.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_0100

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG_0100 .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'L_CHECK'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-CHECKBOX = 'X'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'EBELN'.

  GS_FIELDCAT-SCRTEXT_M = '######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'EBELP'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'MATNAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-SCRTEXT_M = '##'.




*  GS_FIELDCAT-EDIT = 'X'.




  GS_FIELDCAT-QFIELDNAME = 'MEINS'.

  GS_FIELDCAT-DECIMALS = '3'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'STPRS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  GS_FIELDCAT-DECIMALS = '2'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'MWSKZ'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'NETAM'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  GS_FIELDCAT-DECIMALS = '2'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'MWSTS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  GS_FIELDCAT-DECIMALS = '2'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'GROSS'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  GS_FIELDCAT-DECIMALS = '2'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*




FORM ALV_LAYOUT .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.



  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*




FORM CLASS_EVENT .

  " DATA_CHANGED ## ## ##

  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.



  CREATE OBJECT GO_EVENT.



  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED_FINISHED FOR GC_GRID.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY  USING    P_GT_PO.

  DATA: LT_EXCLUDE TYPE UI_FUNCTIONS.



  CLEAR LT_EXCLUDE.

  APPEND CL_GUI_ALV_GRID=>MC_FC_EXCL_ALL  TO LT_EXCLUDE. " ## ## ##



  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT                    = GS_VARIANT

      IS_LAYOUT                     = GS_LAYOUT

      I_SAVE                        = 'A'         " ALV#### #### ##### ## ##

      it_toolbar_excluding          = LT_EXCLUDE  " ### ## ## ###

    CHANGING

      IT_OUTTAB                     = P_GT_PO

      IT_FIELDCATALOG               = GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*




FORM REFRESH .

  DATA LS_STABLE TYPE LVC_S_STBL.



  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE      = LS_STABLE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_0200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG_0200 .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'L_CHECK'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-CHECKBOX = 'X'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'BELNR'.

  GS_FIELDCAT-SCRTEXT_M = '######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'GJAHR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'BUZEI'.

  GS_FIELDCAT-SCRTEXT_M = '#####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'MATNAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.

  GS_FIELDCAT-DECIMALS = '3'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'STPRS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  GS_FIELDCAT-DECIMALS = '2'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'MWSKZ'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'NETAM'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  GS_FIELDCAT-DECIMALS = '2'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'MWSTS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  GS_FIELDCAT-DECIMALS = '2'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'GROSS'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  GS_FIELDCAT-DECIMALS = '2'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_INVOICE_DATA

*&---------------------------------------------------------------------*




FORM GET_INVOICE_DATA .

     "## ### ##

  CLEAR   GT_INVOICE.

  REFRESH GT_INVOICE.



  SELECT *

    INTO CORRESPONDING FIELDS OF TABLE GT_INVOICE

    FROM ZRSEG_12

    WHERE EBELN = P_EBELN

      AND WERKS = P_WERKS.     "## ZWERKS# ### ZWERKS = P_ZWERKS #



  LOOP AT GT_INVOICE ASSIGNING FIELD-SYMBOL(<FS_T>).



    "#### ###

    CLEAR <FS_T>-L_CHECK.



    "### (BUZEI = EBELP ##)

    CLEAR <FS_T>-MATNAME.

    SELECT SINGLE MATNAME

      INTO <FS_T>-MATNAME

      FROM ZEKPO_12

      WHERE EBELN = <FS_T>-EBELN

        AND EBELP = <FS_T>-BUZEI.



    "##

    CLEAR <FS_T>-WAERS.

    SELECT SINGLE WAERS

      INTO <FS_T>-WAERS

      FROM ZRBKP_12

      WHERE BELNR = <FS_T>-BELNR.



  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DATA_CHANGED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_ER_DATA_CHANGED  text

*      -->P_E_ONF4  text

*      -->P_E_ONF4_BEFORE  text

*      -->P_E_ONF4_AFTER  text

*      -->P_E_UCOMM  text

*----------------------------------------------------------------------*




FORM ALV_HANDLER_DATA_CHANGED  USING    P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                        P_ONF4

                                        P_ONF4_BEFORE

                                        P_ONF4_AFTER

                                        P_UCOMM.

  DATA LS_MODI TYPE LVC_S_MODI.



  CLEAR GS_PO.

  LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.

    CASE LS_MODI-FIELDNAME.

      WHEN 'MENGE'. " ##

        READ TABLE GT_PO INTO GS_PO INDEX LS_MODI-ROW_ID.

        IF LS_MODI-VALUE > GS_PO-MENGE   " ### ## #### ## ##

          OR LS_MODI-VALUE < 0.

          MESSAGE '### ### ######.' TYPE 'I'.

          CALL METHOD P_DATA_CHANGED->MODIFY_CELL  " # # ##

              EXPORTING

                I_ROW_ID    = LS_MODI-ROW_ID

                I_FIELDNAME = LS_MODI-FIELDNAME

                I_VALUE     = GS_PO-MENGE.

        ENDIF.

    ENDCASE.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DATA_CHANGED_FINISHED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_MODIFIED  text

*      -->P_ET_GOOD_CELLS  text

*----------------------------------------------------------------------*




FORM ALV_DATA_CHANGED_FINISHED  USING    P_E_MODIFIED

                                         P_ET_GOOD_CELLS.

PERFORM REFRESH.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_DATA

*&---------------------------------------------------------------------*




FORM SAVE_DATA .

  DATA: LV_FLAG TYPE C,

        LV_FAIL TYPE C,

        LV_CNT  TYPE I.



  DATA: LS_ZRBKP TYPE ZRBKP_12,

        LS_ZRSEG TYPE ZRSEG_12.



  "0) ##### ### ### ##

  CLEAR LV_FLAG.

  LOOP AT GT_PO INTO GS_PO.

    SELECT SINGLE MATNR MWSKZ

      INTO (LS_ZRSEG-MATNR, LS_ZRSEG-MWSKZ)

      FROM ZEKPO_12

      WHERE EBELN = P_EBELN

        AND EBELP = GS_PO-EBELP.



    "### ###(= ## ### ##, ### ###)

    IF LS_ZRSEG-MWSTS IS INITIAL.

      CASE LS_ZRSEG-MWSKZ.

        WHEN 'V1' OR 'V4' OR 'V5'.

          LS_ZRSEG-MWSTS = LS_ZRSEG-NETAM * '0.1'.

        WHEN 'V2' OR 'V3'.

          LS_ZRSEG-MWSTS = 0.

        WHEN OTHERS.

          LS_ZRSEG-MWSTS = 0.

      ENDCASE.

    ENDIF.



    IF GS_PO-L_CHECK = 'X'.

      LV_FLAG = 'X'.

      EXIT.

    ENDIF.

  ENDLOOP.



  IF LV_FLAG <> 'X'.

    MESSAGE '##### #### ####.' TYPE 'I'.

    RETURN.

  ENDIF.



  "1) #### ## ## (##)

  CLEAR LS_ZRBKP.



  CALL FUNCTION 'NUMBER_GET_NEXT'

    EXPORTING

      NR_RANGE_NR = '01'          "# # #### ## ##

      OBJECT      = 'ZADOCU3'      "# # #### ## ##

    IMPORTING

      NUMBER      = LS_ZRBKP-BELNR

    EXCEPTIONS

      OTHERS      = 1.



  IF SY-SUBRC <> 0 OR LS_ZRBKP-BELNR IS INITIAL.

    MESSAGE '#### ## ##' TYPE 'I'.

    RETURN.

  ENDIF.



  "##/## (## #### ### ### ### #)

  LS_ZRBKP-GJAHR = SY-DATUM(4).

  LS_ZRBKP-BLDAT = SY-DATUM.

  LS_ZRBKP-BUDAT = SY-DATUM.



  "####/###/### PO####

  SELECT SINGLE BUKRS LIFNR WAERS

    INTO (LS_ZRBKP-BUKRS, LS_ZRBKP-LIFNR, LS_ZRBKP-WAERS)

    FROM ZEKKO_12

    WHERE EBELN = P_EBELN.



  IF SY-SUBRC <> 0.

    MESSAGE '#### ### ## # ####.' TYPE 'I'.

    RETURN.

  ENDIF.



  INSERT ZRBKP_12 FROM LS_ZRBKP.

  IF SY-SUBRC <> 0.

    MESSAGE '## ## ## ##' TYPE 'I'.

    ROLLBACK WORK.

    RETURN.

  ENDIF.



  "2) #### ##### ## (### ##)

  CLEAR: LV_FAIL, LV_CNT.



  LOOP AT GT_PO INTO GS_PO.

    IF GS_PO-L_CHECK <> 'X'.

      CONTINUE.

    ENDIF.



    CLEAR LS_ZRSEG.



    "GT_PO## ### # ## ##(EBELN, MENGE, MWSKZ, NETAM, MWSTS, GROSS #)

    MOVE-CORRESPONDING GS_PO TO LS_ZRSEG.



    LS_ZRSEG-BELNR = LS_ZRBKP-BELNR.

    LS_ZRSEG-GJAHR = LS_ZRBKP-GJAHR.

    LS_ZRSEG-BUZEI = GS_PO-EBELP.   "BUZEI = EBELP ##

    LS_ZRSEG-EBELN = P_EBELN.

    LS_ZRSEG-WERKS = P_WERKS.       "

    LS_ZRSEG-MWSKZ = GS_PO-MWSKZ.

    LS_ZRSEG-MWSTS = GS_PO-MWSTS.

    "#### #### ### ##(#### ### ## ## ##)




*   SELECT SINGLE MATNR

*     INTO LS_ZRSEG-MATNR

*     FROM ZEKPO_12

*     WHERE EBELN = P_EBELN

*       AND EBELP = GS_PO-EBELP.






    INSERT ZRSEG_12 FROM LS_ZRSEG.

    IF SY-SUBRC <> 0.

      LV_FAIL = 'X'.

    ELSE.

      LV_CNT = LV_CNT + 1.

    ENDIF.



  ENDLOOP.



  "3) ##/## ##

  IF LV_FAIL = 'X' OR LV_CNT = 0.

    ROLLBACK WORK.

    MESSAGE '####' TYPE 'I'.

    RETURN.

  ENDIF.



  COMMIT WORK AND WAIT.

  MESSAGE '####' TYPE 'I'.

  " ## ####

  LEAVE TO SCREEN 0.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DELETE_DATA

*&---------------------------------------------------------------------*




FORM DELETE_DATA .

  DATA: LV_FLAG    TYPE C,

        LS_ZRSEG12 TYPE ZRSEG_12.



  "0) ### ### ### ##

  CLEAR LV_FLAG.

  LOOP AT GT_INVOICE INTO GS_INVOICE.

    IF GS_INVOICE-L_CHECK = 'X'.

      LV_FLAG = 'X'.

      EXIT.

    ENDIF.

  ENDLOOP.



  IF LV_FLAG <> 'X'.

    MESSAGE '##### #### ####.' TYPE 'I'.

    RETURN.

  ENDIF.



  "1) ### ## ## + ## ## ### ### ##

  CLEAR GS_INVOICE.

  LOOP AT GT_INVOICE INTO GS_INVOICE.



    IF GS_INVOICE-L_CHECK = 'X'.



      "## ## (### GS_INVOICE# ##### #: BELNR/GJAHR/BUZEI #)

      DELETE ZRSEG_12 FROM GS_INVOICE.



      "## BELNR# ###### # ##### ##

      CLEAR LS_ZRSEG12.

      SELECT SINGLE *

        FROM ZRSEG_12

        INTO CORRESPONDING FIELDS OF LS_ZRSEG12

        WHERE BELNR = GS_INVOICE-BELNR

          AND GJAHR = GS_INVOICE-GJAHR.



      IF SY-SUBRC <> 0.

        "## 0## ## ##

        DELETE ZRBKP_12 FROM GS_INVOICE.

      ENDIF.



    ENDIF.



    CLEAR GS_INVOICE.

  ENDLOOP.



  COMMIT WORK AND WAIT.

  MESSAGE '####' TYPE 'I'.

  LEAVE TO SCREEN 0.

ENDFORM.