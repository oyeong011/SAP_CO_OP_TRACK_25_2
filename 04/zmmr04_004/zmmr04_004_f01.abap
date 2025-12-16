
*&---------------------------------------------------------------------*

*&  Include           ZMMR04_004_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_INIT

*&---------------------------------------------------------------------*




FORM SET_INIT .

  P_IRDAT = SY-DATUM.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_SCREEN

*&---------------------------------------------------------------------*




FORM SET_SCREEN .

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.      " #####

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




FORM CHECK_MANDATORY .

  " ## ## ## # ### ## ##

  IF P_EBELN IS INITIAL OR P_ZWERKS IS INITIAL

    OR ( P_RD1 = 'X' AND P_IRDAT IS INITIAL ).

    MESSAGE I000.

    STOP.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_PO_EXIST

*&---------------------------------------------------------------------*




FORM CHECK_PO_EXIST .

  DATA LS_ZEKKO TYPE ZEKKO04.



  " ## #### ###### ##

  SELECT SINGLE * FROM ZEKKO04

    INTO CORRESPONDING FIELDS OF LS_ZEKKO

    WHERE EBELN = P_EBELN.



  IF SY-SUBRC <> 0.

    MESSAGE I008.

    STOP.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SELECT_PO_DATA

*&---------------------------------------------------------------------*




FORM SELECT_PO_DATA .

  DATA LV_MENGE TYPE ZMSEG04-MENGE.



  " #### ##

  SELECT *

    INTO CORRESPONDING FIELDS OF TABLE GT_PO

    FROM ZEKPO04 AS A

      LEFT OUTER JOIN ZEKKO04 AS B

      ON A~EBELN = B~EBELN

    WHERE A~EBELN = P_EBELN

      AND ZWERKS = P_ZWERKS.



  LOOP AT GT_PO INTO GS_PO.

    " ##### ## ##

    SELECT SINGLE MENGE FROM ZRSEG04

      INTO LV_MENGE

      WHERE EBELN = P_EBELN     " ######

      AND BUZEI = GS_PO-EBELP.  " ##



    " ##### ## ### ## ##

    IF SY-SUBRC = 0.

      DELETE TABLE GT_PO FROM GS_PO.

      CONTINUE.

    ENDIF.



    " ###, ##, ## ##

    GS_PO-ZNETAM = GS_PO-STPRS * GS_PO-MENGE. " ### = ## * ##

    CASE GS_PO-ZMWSKZ.

      WHEN 'V1' OR 'V4' OR 'V5'.

        GS_PO-MWSTS = GS_PO-ZNETAM * '0.1'.   " ##

      WHEN 'V2' OR 'V3'.

        GS_PO-MWSTS = 0.

    ENDCASE.

    GS_PO-ZGROSS = GS_PO-ZNETAM + GS_PO-MWSTS.  " ###



    MODIFY GT_PO FROM GS_PO TRANSPORTING ZMWSKZ ZNETAM MWSTS ZGROSS

      WHERE EBELN = GS_PO-EBELN AND EBELP = GS_PO-EBELP.

    CLEAR GS_PO.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DATA_CHANGED

*&---------------------------------------------------------------------*




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




FORM ALV_DATA_CHANGED_FINISHED  USING    P_E_MODIFIED

                                         P_ET_GOOD_CELLS.

  PERFORM REFRESH.

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

  GS_FIELDCAT-FIELDNAME = 'ZMATNAME'.

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

  GS_FIELDCAT-FIELDNAME = 'ZMWSKZ'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZNETAM'.

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

  GS_FIELDCAT-FIELDNAME = 'ZGROSS'.

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

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY USING P_GT_VENDOR.

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

      IT_OUTTAB                     = P_GT_VENDOR

      IT_FIELDCATALOG               = GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*




FORM REFRESH .

  DATA LS_STABLE TYPE LVC_S_STBL.



  " #### USERCOMMAND ## ### # CURSOR## ###

  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE      = LS_STABLE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_DATA

*&---------------------------------------------------------------------*




FORM SAVE_DATA .

  DATA LS_FLAG.

  DATA LS_ZRBKP04 TYPE ZRBKP04.

  DATA LS_ZRSEG04 TYPE ZRSEG04.



  " 0. ##### ### ### ##

  LOOP AT GT_PO INTO GS_PO.

    IF GS_PO-L_CHECK = 'X'.

      LS_FLAG = 'X'.

      EXIT.

    ENDIF.

  ENDLOOP.



  IF LS_FLAG <> 'X'.

    MESSAGE '##### #### ####.' TYPE 'I'.

    RETURN.   " FORM ###

  ENDIF.



  " 1. #### ## ##

  CALL FUNCTION 'NUMBER_GET_NEXT'   " ###### ## ####

    EXPORTING

      NR_RANGE_NR                   = '4'

      OBJECT                        = 'ZSSU04'

    IMPORTING

      NUMBER                        = LS_ZRBKP04-BELNR.



  LS_ZRBKP04-GJAHR = P_IRDAT(4).  " ####

  LS_ZRBKP04-BLDAT = P_IRDAT.     " ###

  LS_ZRBKP04-BUDAT = P_IRDAT.     " ###

  SELECT SINGLE * FROM ZEKKO04    " ####, ###, ##

    INTO CORRESPONDING FIELDS OF LS_ZRBKP04

    WHERE EBELN = P_EBELN.



  INSERT INTO ZRBKP04 VALUES LS_ZRBKP04.



  " 2. #### ##### ##

  CLEAR : GS_PO, LS_ZRSEG04.

  LOOP AT GT_PO INTO GS_PO.

    IF GS_PO-L_CHECK = 'X'.

      MOVE-CORRESPONDING GS_PO TO LS_ZRSEG04.

      LS_ZRSEG04-BELNR = LS_ZRBKP04-BELNR.  " ######

      LS_ZRSEG04-GJAHR = LS_ZRBKP04-GJAHR.  " ####

      LS_ZRSEG04-BUZEI = GS_PO-EBELP.       " ####



      SELECT SINGLE ZWERKS ZMATNR FROM ZEKPO04

        INTO ( LS_ZRSEG04-ZWERKS, LS_ZRSEG04-ZMATNR )

        WHERE EBELN = P_EBELN

        AND EBELP = GS_PO-EBELP.



      INSERT INTO ZRSEG04 VALUES LS_ZRSEG04.



      CLEAR : GS_PO, LS_ZRSEG04.

    ENDIF.

  ENDLOOP.



  IF SY-SUBRC = 0.

    MESSAGE '####' TYPE 'I'.

  ELSE.

    MESSAGE '####' TYPE 'I'.

  ENDIF.



  " ## ####

  LEAVE TO SCREEN 0.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SELECT_INVOICE

*&---------------------------------------------------------------------*




FORM SELECT_INVOICE .

  DATA LV_WAERS TYPE ZEKKO04-WAERS.       " ##



  SELECT *

    INTO CORRESPONDING FIELDS OF TABLE GT_INVOICE

    FROM ZRSEG04

    WHERE EBELN = P_EBELN

    AND ZWERKS = P_ZWERKS.



  CLEAR GS_INVOICE.

  LOOP AT GT_INVOICE ASSIGNING FIELD-SYMBOL(<FS_T>).

    " ###

    SELECT SINGLE ZMATNAME FROM ZEKPO04

      INTO <FS_T>-ZMATNAME

      WHERE EBELN = <FS_T>-EBELN

      AND EBELP = <FS_T>-BUZEI.



    " ##

    SELECT SINGLE WAERS FROM ZRBKP04

      INTO <FS_T>-WAERS

      WHERE BELNR = <FS_T>-BELNR.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DELETE_DATA

*&---------------------------------------------------------------------*




FORM DELETE_DATA .

  DATA LS_FLAG.

  DATA LS_ZRSEG04 TYPE ZRSEG04.



  " 0. ##### ### ### ##

  LOOP AT GT_INVOICE INTO GS_INVOICE.

    IF GS_INVOICE-L_CHECK = 'X'.

      LS_FLAG = 'X'.

      EXIT.

    ENDIF.

  ENDLOOP.



  IF LS_FLAG <> 'X'.

    MESSAGE '##### #### ####.' TYPE 'I'.

    RETURN.   " FORM ###

  ENDIF.



    " 1. #### ##### ##

  CLEAR : GS_INVOICE.

  LOOP AT GT_INVOICE INTO GS_INVOICE.

    IF GS_INVOICE-L_CHECK = 'X'.

      DELETE ZRSEG04 FROM GS_INVOICE.

      " 2. ##### ### ### ### ##

      SELECT SINGLE * FROM ZRSEG04

        INTO CORRESPONDING FIELDS OF LS_ZRSEG04

        WHERE BELNR = GS_INVOICE-BELNR.

      IF SY-SUBRC <> 0.

        DELETE ZRBKP04 FROM GS_INVOICE.

      ENDIF.

    ENDIF.

    CLEAR : GS_INVOICE.

  ENDLOOP.



  MESSAGE '####' TYPE 'I'.

  LEAVE TO SCREEN 0.  " ## ####

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_0200

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG_0200 .

CLEAR : GS_FIELDCAT, GT_FIELDCAT.

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

  GS_FIELDCAT-FIELDNAME = 'ZMATNAME'.

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

  GS_FIELDCAT-FIELDNAME = 'ZMWSKZ'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZNETAM'.

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

  GS_FIELDCAT-FIELDNAME = 'ZGROSS'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  GS_FIELDCAT-DECIMALS = '2'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.