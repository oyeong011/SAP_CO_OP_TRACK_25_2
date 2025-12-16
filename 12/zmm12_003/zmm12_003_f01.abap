
*&---------------------------------------------------------------------*

*&  Include           ZMM12_003_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_SCREEN

*&---------------------------------------------------------------------*




FORM SET_SCREEN .

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.

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

*&      Form  INITIALIZATION

*&---------------------------------------------------------------------*




FORM INITIALIZATION .

  P3 = SY-DATUM.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_MANDATORY

*&---------------------------------------------------------------------*




FORM CHECK_MANDATORY .

  IF P1 IS INITIAL OR P2 IS INITIAL

    OR ( P_RD1 = 'X' AND P3 IS INITIAL ).

    MESSAGE I000.

    STOP.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA1

*&---------------------------------------------------------------------*






FORM GET_PO_DATA .




*  "#### ##MKPF

*  DATA: LV_MKPF_MBLNR  TYPE ZMKPF_12-MBLNR.

*  DATA LV_MENGE TYPE ZMSEG_12-MENGE.

*  "===================================================

*  " ######(MBLNR) ##++ MKPF ##

*  "===================================================

*  CALL FUNCTION 'NUMBER_GET_NEXT'   " #### ## ####

*      EXPORTING

*        NR_RANGE_NR                   = '01'

*        OBJECT                        = 'ZADOCU2'

*      IMPORTING

*        NUMBER                        = LV_MKPF_MBLNR.

*  GS_MKPF-MBLNR = LV_MKPF_MBLNR.

*  GS_MKPF-BUDAT = P3.

*  GS_MKPF-MJAHR = GS_MKPF-BUDAT+0(4).

*  SELECT SINGLE BEDAT

*  FROM ZEKKO_12

*  INTO GS_MKPF-BLDAT

*  WHERE EBELN = P1.

*  GS_MKPF-BLART = 'WE'.






"   PERFORM EXIST_PO## ##.




*  SELECT SINGLE * FROM ZEKKO_12

*    INTO CORRESPONDING FIELDS OF GS_EKKO        " #### ##

*    WHERE EBELN = P1.                           "PO##






  DATA LV_MENGE TYPE ZMSEG_12-MENGE.

  DATA LV_REMNG TYPE ZMSEG_12-MENGE.



  SELECT *

    FROM ZEKPO_12

    INTO CORRESPONDING FIELDS OF TABLE GT_EKPO

    WHERE EBELN = P1

      AND WERKS = P2.



  CLEAR GT_PO.



  LOOP AT GT_EKPO INTO GS_EKPO.



    CLEAR: GS_PO, LV_MENGE, LV_REMNG.



    MOVE-CORRESPONDING GS_EKPO TO GS_PO.

    MOVE-CORRESPONDING GS_EKKO TO GS_PO.



    "##### ## ##(##)

    SELECT SUM( MENGE )

      FROM ZMSEG_12

      INTO LV_MENGE

      WHERE EBELN = P1

        AND ZEILE = GS_PO-EBELP.



    "#### = #### - ######

    LV_REMNG = GS_PO-MENGE - LV_MENGE.



    "#### 0## ## ##(####)

    IF LV_REMNG <= 0.

      CONTINUE.

    ENDIF.



    "###### ## ##

    GS_PO-MENGE = LV_REMNG.



    "## ## #### ##

    APPEND GS_PO TO GT_PO.



  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  EXIST_PO

*&---------------------------------------------------------------------*




FORM EXIST_PO .

  SELECT SINGLE * FROM ZEKKO_12

    INTO CORRESPONDING FIELDS OF GS_EKKO        " #### ##

    WHERE EBELN = P1.                           "PO##

  IF SY-SUBRC <> 0.

    MESSAGE I001.

    STOP.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*






FORM CREATE_OBJECT .

  CREATE OBJECT GC_DOCKING

    EXPORTING

      REPID                       = SY-REPID

      DYNNR                       = SY-DYNNR

      EXTENSION                   = 2000.



  CREATE OBJECT GC_GRID

    EXPORTING

      I_PARENT          = GC_DOCKING.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG1

*&---------------------------------------------------------------------*






FORM FIELD_CATALOG1 .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'CHECK'.

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

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'MATNAME'.

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

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'WERKS'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'LGORT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

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

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CLASS_EVENT .

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




FORM ALV_DISPLAY .

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_LAYOUT                     = GS_LAYOUT

    CHANGING

      IT_OUTTAB                     = GT_PO

      IT_FIELDCATALOG               = GT_FIELDCAT

          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.

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

*&      Form  SAVE_DATA

*&---------------------------------------------------------------------*




FORM SAVE_DATA .

    DATA: LV_FLAG TYPE C.



  CLEAR LV_FLAG.



  "0. ##### ### ### ##

  LOOP AT GT_PO INTO GS_PO.

    IF GS_PO-CHECK = 'X'.

      LV_FLAG = 'X'.

      EXIT.

    ENDIF.

  ENDLOOP.



  IF LV_FLAG <> 'X'.

    MESSAGE '##### #### ####.' TYPE 'I'.

    RETURN.

  ENDIF.



  "1. ###### ## (ZMKPF_12)

  CLEAR GS_MKPF.



  CALL FUNCTION 'NUMBER_GET_NEXT'

    EXPORTING

      NR_RANGE_NR = '01'

      OBJECT    = 'ZADOCU2'

    IMPORTING

      NUMBER    = GS_MKPF-MBLNR.



  GS_MKPF-MJAHR = P3(4).

  GS_MKPF-BLART = 'WE'.

  GS_MKPF-BUDAT = P3.

  GS_MKPF-BLDAT = P3.



  INSERT INTO ZMKPF_12 VALUES GS_MKPF.

  IF SY-SUBRC <> 0.

    MESSAGE '## ## ##' TYPE 'I'.

    RETURN.

  ENDIF.



  "2. ####### ## (ZMSEG_12)

  LOOP AT GT_PO INTO GS_PO.

    IF GS_PO-CHECK <> 'X'.

      CONTINUE.

    ENDIF.



    CLEAR GS_MSEG.



    GS_MSEG-MBLNR = GS_MKPF-MBLNR.

    GS_MSEG-MJAHR = GS_MKPF-MJAHR.

    GS_MSEG-GJAHR = GS_MKPF-MJAHR.



    MOVE-CORRESPONDING GS_PO TO GS_MSEG.



    GS_MSEG-ZEILE = GS_PO-EBELP.

    GS_MSEG-SHKZG = 'S'.



    IF GS_MSEG-BUKRS IS INITIAL.

      SELECT SINGLE BUKRS

        FROM ZEKKO_12

        INTO GS_MSEG-BUKRS

        WHERE EBELN = GS_PO-EBELN.

    ENDIF.



    GS_MSEG-DMBTR = GS_PO-STPRS * GS_PO-MENGE.



    INSERT INTO ZMSEG_12 VALUES GS_MSEG.

    IF SY-SUBRC <> 0.

      ROLLBACK WORK.

      MESSAGE '####' TYPE 'I'.

      RETURN.

    ENDIF.

  ENDLOOP.



  COMMIT WORK AND WAIT.

  MESSAGE '####' TYPE 'I'.



  LEAVE TO SCREEN 0.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_MSEG_DATA

*&---------------------------------------------------------------------*




FORM GET_MSEG_DATA .

  SELECT *

    INTO CORRESPONDING FIELDS OF TABLE GT_MG

    FROM ZMSEG_12

    WHERE EBELN = P1

      AND WERKS = P2.



  IF GT_MG[] IS INITIAL.

    MESSAGE I001.

    EXIT.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DELETE_DATA

*&---------------------------------------------------------------------*




FORM DELETE_DATA .

  DATA: LV_FLAG	TYPE C,

        LV_CNT  TYPE I.



  "### ### ## ###

  DATA: LT_SEL  LIKE TABLE OF GS_MG,

        LS_SEL  LIKE GS_MG.



  "###(MBLNR+MJAHR) ## ### (## ###)

  TYPES: BEGIN OF TY_HDRKEY,

        MBLNR TYPE ZMKPF_12-MBLNR,

        MJAHR TYPE ZMKPF_12-MJAHR,

        CNT TYPE I,

        END OF TY_HDRKEY.



  DATA: LT_HDRKEY TYPE TABLE OF TY_HDRKEY,

      LS_HDRKEY TYPE TY_HDRKEY.



  CLEAR: LV_FLAG, LT_SEL, LT_HDRKEY.



  "--------------------------------------------------

  " 0) ### #### #### ## + ### ##

  "--------------------------------------------------

  LOOP AT GT_MG INTO GS_MG.

    IF GS_MG-CHECK = 'X'.

      APPEND GS_MG TO LT_SEL.



      CLEAR LS_HDRKEY.

      LS_HDRKEY-MBLNR = GS_MG-MBLNR.

      LS_HDRKEY-MJAHR = GS_MG-MJAHR.

      LS_HDRKEY-CNT = 1.

      COLLECT LS_HDRKEY INTO LT_HDRKEY.



      LV_FLAG = 'X'.

    ENDIF.

  ENDLOOP.



  IF LV_FLAG <> 'X'.

    MESSAGE '##### #### ####.' TYPE 'I'.

    RETURN.

  ENDIF.



  "--------------------------------------------------

  " 1) ### ###### ##

  "    (##### ## MBLNR+MJAHR+ZEILE ## ##)

  "--------------------------------------------------

  LOOP AT LT_SEL INTO LS_SEL.



    DELETE FROM ZMSEG_12

      WHERE MBLNR = LS_SEL-MBLNR

        AND MJAHR = LS_SEL-MJAHR

        AND ZEILE = LS_SEL-ZEILE.



    IF SY-SUBRC <> 0.

      ROLLBACK WORK.

      MESSAGE '####(## ##)' TYPE 'I'.

      RETURN.

    ENDIF.



  ENDLOOP.



  "--------------------------------------------------

  " 2) ###(MBLNR+MJAHR)# ### #### ## # ### ## ##

  "--------------------------------------------------

  LOOP AT LT_HDRKEY INTO LS_HDRKEY.



    CLEAR LV_CNT.



    SELECT COUNT( * )

      INTO LV_CNT

      FROM ZMSEG_12

      WHERE MBLNR = LS_HDRKEY-MBLNR

        AND MJAHR = LS_HDRKEY-MJAHR.



    IF LV_CNT = 0.

      DELETE FROM ZMKPF_12

        WHERE MBLNR = LS_HDRKEY-MBLNR

          AND MJAHR = LS_HDRKEY-MJAHR.



      IF SY-SUBRC <> 0.

        ROLLBACK WORK.

        MESSAGE '####(## ##)' TYPE 'I'.

        RETURN.

      ENDIF.

    ENDIF.



  ENDLOOP.



  COMMIT WORK AND WAIT.



  MESSAGE '####' TYPE 'I'.

  LEAVE TO SCREEN 0.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG2 .

  CLEAR : GS_FIELDCAT2, GT_FIELDCAT2.

  GS_FIELDCAT2-COL_POS = 1.

  GS_FIELDCAT2-FIELDNAME = 'CHECK'.

  GS_FIELDCAT2-SCRTEXT_M = ''.

  GS_FIELDCAT2-CHECKBOX = 'X'.

  GS_FIELDCAT2-EDIT = 'X'.

  APPEND GS_FIELDCAT2 TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT2.

  GS_FIELDCAT2-COL_POS = 2.

  GS_FIELDCAT2-FIELDNAME = 'MBLNR'.

  GS_FIELDCAT2-SCRTEXT_M = '######'.

  APPEND GS_FIELDCAT2 TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT2.

  GS_FIELDCAT2-COL_POS = 3.

  GS_FIELDCAT2-FIELDNAME = 'ZEILE'.

  GS_FIELDCAT2-SCRTEXT_M = '#####'.

  APPEND GS_FIELDCAT2 TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT2.

  GS_FIELDCAT2-COL_POS = 4.

  GS_FIELDCAT2-FIELDNAME = 'MATNR'.

  GS_FIELDCAT2-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT2 TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT2.

  GS_FIELDCAT2-COL_POS = 5.

  GS_FIELDCAT2-FIELDNAME = 'LGORT'.

  GS_FIELDCAT2-SCRTEXT_M = '####'.



  CLEAR : GS_FIELDCAT2.

  GS_FIELDCAT2-COL_POS = 6.

  GS_FIELDCAT2-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT2-SCRTEXT_M = '#####'.

  APPEND GS_FIELDCAT2 TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT2.

  GS_FIELDCAT2-COL_POS = 7.

  GS_FIELDCAT2-FIELDNAME = 'MENGE'.

  GS_FIELDCAT2-SCRTEXT_M = '##'.

  GS_FIELDCAT2-QFIELDNAME = 'MEINS'.

  GS_FIELDCAT2-DECIMALS = '3'.

  APPEND GS_FIELDCAT2 TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT2.

  GS_FIELDCAT2-COL_POS = 8.

  GS_FIELDCAT2-FIELDNAME = 'MEINS'.

  GS_FIELDCAT2-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT2 TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT2.

  GS_FIELDCAT2-COL_POS = 9.

  GS_FIELDCAT2-FIELDNAME = 'DMBTR'.

  GS_FIELDCAT2-SCRTEXT_M = '##'.

  GS_FIELDCAT2-CFIELDNAME = 'WAERS'.

  GS_FIELDCAT2-DECIMALS = '2'.

  APPEND GS_FIELDCAT2 TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT2.

  GS_FIELDCAT2-COL_POS = 10.

  GS_FIELDCAT2-FIELDNAME = 'WAERS'.

  GS_FIELDCAT2-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT2 TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT2.

  GS_FIELDCAT2-COL_POS = 11.

  GS_FIELDCAT2-FIELDNAME = 'MJAHR'.

  GS_FIELDCAT2-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT2 TO GT_FIELDCAT2.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY2

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY2 .

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_LAYOUT                     = GS_LAYOUT

    CHANGING

      IT_OUTTAB                     = GT_MG

      IT_FIELDCATALOG               = GT_FIELDCAT2

          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.

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