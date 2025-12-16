
*&---------------------------------------------------------------------*

*&  Include           ZMMR04_003_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_INIT

*&---------------------------------------------------------------------*




FORM SET_INIT .

  P_RGDAT = SY-DATUM.

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

    OR ( P_RD1 = 'X' AND P_RGDAT IS INITIAL ).

    MESSAGE I000.

    STOP.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_PO_EXIST

*&---------------------------------------------------------------------*




FORM CHECK_PO_EXIST .

  DATA LS_ZEKKO TYPE ZEKKO04.



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



  SELECT *

    INTO CORRESPONDING FIELDS OF TABLE GT_PO

    FROM ZEKPO04 AS A

      LEFT OUTER JOIN ZEKKO04 AS B

      ON A~EBELN = B~EBELN

    WHERE A~EBELN = P_EBELN

      AND ZWERKS = P_ZWERKS.



  LOOP AT GT_PO INTO GS_PO.

    " ##### ## ##

    SELECT SUM( MENGE ) FROM ZMSEG04

      INTO LV_MENGE

      WHERE EBELN = P_EBELN   " ######

      AND ZEILE = GS_PO-EBELP. " ##



    IF SY-SUBRC = 0.

      LV_MENGE = GS_PO-MENGE - LV_MENGE.  " ## ##

      IF LV_MENGE = 0.  " ## ## 0## ## ##

        DELETE TABLE GT_PO FROM GS_PO.

        CONTINUE.

      ELSE.             " ## ## 0 ### ## ##

        GS_PO-MENGE = LV_MENGE.

      ENDIF.

    ENDIF.



    MODIFY GT_PO FROM GS_PO TRANSPORTING MENGE

      WHERE EBELN = GS_PO-EBELN AND EBELP = GS_PO-EBELP.



    CLEAR GS_PO.

  ENDLOOP.

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

  GS_FIELDCAT-FIELDNAME = 'BEDAT'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-OUTPUTLEN = '11'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZMATNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZMATNAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.

  GS_FIELDCAT-DECIMALS = '3'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'STPRS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  GS_FIELDCAT-DECIMALS = '2'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



    CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'PRDAT'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-OUTPUTLEN = '11'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'ZWERKS'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'ZLGORT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

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

  DATA LS_ZMKPF04 TYPE ZMKPF04.

  DATA LS_ZMSEG04 TYPE ZMSEG04.



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

        NR_RANGE_NR                   = '3'

        OBJECT                        = 'ZSSU04'

      IMPORTING

        NUMBER                        = LS_ZMKPF04-MBLNR.



  LS_ZMKPF04-MJAHR = P_RGDAT(4).  " ####

  LS_ZMKPF04-BLART = 'WE'.        " ####

  LS_ZMKPF04-BLDAT = P_RGDAT.     " ### (= ### = ###### ###)

  LS_ZMKPF04-BUDAT = P_RGDAT.     " ###



  INSERT INTO ZMKPF04 VALUES LS_ZMKPF04.



  " 2. #### ##### ##

  CLEAR : GS_PO, LS_ZMSEG04.

  LOOP AT GT_PO INTO GS_PO.

    IF GS_PO-L_CHECK = 'X'.

      LS_ZMSEG04-MBLNR = LS_ZMKPF04-MBLNR.  " ######

      LS_ZMSEG04-MJAHR = LS_ZMKPF04-MJAHR.  " ####

      LS_ZMSEG04-GJAHR = LS_ZMKPF04-MJAHR.  " ##### ## ##



      MOVE-CORRESPONDING GS_PO TO LS_ZMSEG04.



      LS_ZMSEG04-ZEILE = GS_PO-EBELP. " ##### = ####(0-PADDING #### ### ###)

      LS_ZMSEG04-SHKZG = 'S'.         " #### ####(##### ### ##)

      LS_ZMSEG04-DMBTR = GS_PO-STPRS * GS_PO-MENGE. " ## = ## * ## ( ### ### ### #### ##)

      " ## ### ##. ## #### #### # ## ##.



      SELECT SINGLE BUKRS FROM ZEKKO04  " ##### #### ## ##### ##

        INTO LS_ZMSEG04-BUKRS

        WHERE EBELN = GS_PO-EBELN.



      INSERT INTO ZMSEG04 VALUES LS_ZMSEG04.



      CLEAR : GS_PO, LS_ZMSEG04.

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

*&      Form  SELECT_RG_DATA

*&---------------------------------------------------------------------*




FORM SELECT_RG_DATA .

  SELECT *

    INTO CORRESPONDING FIELDS OF TABLE GT_RG

    FROM ZMSEG04

    WHERE EBELN = P_EBELN

      AND ZWERKS = P_ZWERKS.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_0200

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG_0200 .

CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'L_CHECK'.

  GS_FIELDCAT-SCRTEXT_M = ''.

  GS_FIELDCAT-CHECKBOX = 'X'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'MBLNR'.

  GS_FIELDCAT-SCRTEXT_M = '######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZEILE'.

  GS_FIELDCAT-SCRTEXT_M = '#####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZMATNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZLGORT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT-SCRTEXT_M = '#####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.

  GS_FIELDCAT-DECIMALS = '3'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'DMBTR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  GS_FIELDCAT-DECIMALS = '2'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'MJAHR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DELETE_DATA

*&---------------------------------------------------------------------*




FORM DELETE_DATA .

  DATA LS_FLAG.

  DATA LS_ZMSEG04 TYPE ZMSEG04.



  " 0. ##### ### ### ##

  LOOP AT GT_RG INTO GS_RG.

    IF GS_RG-L_CHECK = 'X'.

      LS_FLAG = 'X'.

      EXIT.

    ENDIF.

  ENDLOOP.



  IF LS_FLAG <> 'X'.

    MESSAGE '##### #### ####.' TYPE 'I'.

    RETURN.   " FORM ###

  ENDIF.



  " 1. #### ##### ##

  CLEAR : GS_RG.

  LOOP AT GT_RG INTO GS_RG.

    IF GS_RG-L_CHECK = 'X'.

      DELETE ZMSEG04 FROM GS_RG.

      " 2. ##### ### ### ### ##

      SELECT SINGLE * FROM ZMSEG04

        INTO CORRESPONDING FIELDS OF LS_ZMSEG04

        WHERE MBLNR = GS_RG-MBLNR.

      IF SY-SUBRC <> 0.

        DELETE ZMKPF04 FROM GS_RG.

      ENDIF.

    ENDIF.

    CLEAR : GS_RG.

  ENDLOOP.



  MESSAGE '####' TYPE 'I'.

  LEAVE TO SCREEN 0.  " ## ####

ENDFORM.