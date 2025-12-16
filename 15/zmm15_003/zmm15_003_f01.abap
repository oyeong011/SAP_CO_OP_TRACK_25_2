
*&---------------------------------------------------------------------*

*&  Include           ZMM15_003_F01

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

    IF P_EBELN = '' OR P_WERKS = '' OR P_BUDAT = ''.

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

*&      Form  GET_PO

*&---------------------------------------------------------------------*




FORM GET_PO .

  "EKKO, EKPO#### ### ####

   SELECT *

     INTO CORRESPONDING FIELDS OF TABLE GT_ALV

     FROM ZEKKO_15 AS A

     INNER JOIN ZEKPO_15 AS B

     ON A~EBELN = B~EBELN

     WHERE A~EBELN = P_EBELN

     AND B~WERKS = P_WERKS

     AND B~ELIKZ NE 'X'. "###### ## ### ###

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

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.



  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'CHECK'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-CHECKBOX = 'X'. "##### ## ##

  GS_FIELDCAT-EDIT = 'X'. " #### ### # ## ## ##



  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'EBELN'.

  GS_FIELDCAT-COLTEXT = '######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'EBELP'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.





  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'BEDAT'.

  GS_FIELDCAT-COLTEXT = '#####'. "#### ###

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'MAKTX'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-COLTEXT = 'PO##'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'. "#### ##

  GS_FIELDCAT-REF_TABLE = 'ZEKPO_15'.

  GS_FIELDCAT-REF_FIELD = 'MENGE'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'WEMNG'.

  GS_FIELDCAT-COLTEXT = '#####'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'. "#### ##

  GS_FIELDCAT-REF_TABLE = 'ZEKPO_15'.

  GS_FIELDCAT-REF_FIELD = 'WEMNG'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'MENGE_C'.

  GS_FIELDCAT-COLTEXT = '## ## ##'.

  GS_FIELDCAT-EDIT = 'X'. "####

  GS_FIELDCAT-QFIELDNAME = 'MEINS'. "#### ##

  GS_FIELDCAT-REF_TABLE = 'ZEKPO_15'.

  GS_FIELDCAT-REF_FIELD = 'MENGE'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'STPRS'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'. "#### ##

  GS_FIELDCAT-REF_TABLE = 'ZEKPO_15'.

  GS_FIELDCAT-REF_FIELD = 'STPRS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'PRDAT'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'WERKS'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 15.

  GS_FIELDCAT-FIELDNAME = 'LGORT'.

  GS_FIELDCAT-COLTEXT = '####'.

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

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY .

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      I_SAVE                        = 'A'

      IS_LAYOUT                     = GS_LAYOUT

    CHANGING

      IT_OUTTAB                     = GT_ALV

      IT_FIELDCATALOG               = GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*




FORM REFRESH .

  DATA : LS_STABLE TYPE LVC_S_STBL.



  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE      = LS_STABLE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DATA_CHANGED

*&---------------------------------------------------------------------*




FORM ALV_HANDLER_DATA_CHANGED  USING    P_ER_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                        P_E_ONF4

                                        P_E_ONF4_BEFORE

                                        P_E_ONF4_AFTER

                                        P_E_UCOMM.



  DATA : LS_MOD_CELL TYPE LVC_S_MODI,

         LS_ALV LIKE LINE OF GT_ALV.

  DATA : LV_OPEN_QTY TYPE EKPO-MENGE,  "##

         LV_NEW_VAL TYPE EKPO-MENGE.   "#### ### #





  LOOP AT P_ER_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MOD_CELL.



    "### ### #### ####

    IF LS_MOD_CELL-FIELDNAME = 'MENGE_C'.



      "### ## #### ###

      READ TABLE GT_ALV INTO LS_ALV INDEX LS_MOD_CELL-ROW_ID.

      IF SY-SUBRC = 0.



        "## ## (#### - #####)

        LV_OPEN_QTY = LS_ALV-MENGE - LS_ALV-WEMNG.



        "#### ### #

        LV_NEW_VAL = LS_MOD_CELL-VALUE.



        "### ####

        "1) 0## ### ##

        IF LV_NEW_VAL <= 0.

          CALL METHOD P_ER_DATA_CHANGED->ADD_PROTOCOL_ENTRY

            EXPORTING

              I_MSGID = '00'

              I_MSGTY = 'E'

              I_MSGNO = '001'

              I_MSGV1 = '### 0## ## ###.'

              I_FIELDNAME = LS_MOD_CELL-FIELDNAME

              I_ROW_ID = LS_MOD_CELL-ROW_ID.

        ENDIF.



        "2) ## ### ##

        IF LV_NEW_VAL > LV_OPEN_QTY.

          CALL METHOD P_ER_DATA_CHANGED->ADD_PROTOCOL_ENTRY

            EXPORTING

              I_MSGID = '00'

              I_MSGTY = 'E'

              I_MSGNO = '001'

              I_MSGV1 = '## ### ######'

              I_MSGV2 = '(#### #### : '

              I_MSGV3 = LV_OPEN_QTY

              I_MSGV4 = ')'

              I_FIELDNAME = LS_MOD_CELL-FIELDNAME

              I_ROW_ID = LS_MOD_CELL-ROW_ID.

        ENDIF.

      ENDIF.

    ENDIF.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_GR

*&---------------------------------------------------------------------*




FORM SAVE_GR .

  DATA : LV_CNT TYPE I.

  DATA : LV_MBLNR TYPE ZMSEG_15-MBLNR, "######

         LV_ZEILE TYPE ZMSEG_15-ZEILE. "### ##



  "DB ### ## ## ##

  DATA : LS_ZMKPF TYPE ZMKPF_15,

         LT_ZMSEG TYPE TABLE OF ZMSEG_15,

         LS_ZMSEG TYPE ZMSEG_15.



  "EKPO #### ##

  DATA : LT_EKPO_UPD TYPE TABLE OF ZEKPO_15,

         LS_EKPO_UPD TYPE ZEKPO_15.



  "##### #### ##

  DATA : LS_ZMAT TYPE ZMAT_15.





"1. #### ###

  "### ##### ### #### ###

  CALL METHOD GC_GRID->CHECK_CHANGED_DATA.



  "### ### ### ###

  LOOP AT GT_ALV INTO GS_ALV WHERE CHECK = 'X'.

    "###

    ADD 1 TO LV_CNT.

  ENDLOOP.



  "## ### 0## ## ##

  IF LV_CNT = 0.

    MESSAGE '### #### #### ####, ### 0###.' TYPE 'S' DISPLAY LIKE 'E'.

    EXIT.

  ENDIF.





"2. ######(MBLNR) ##

  PERFORM CREATE_MBLNR CHANGING LV_MBLNR.





"3. ## ### (ZMKPF_15)

  LS_ZMKPF-MBLNR = LV_MBLNR. "######

  LS_ZMKPF-MJAHR = GV_MJAHR. "####

  LS_ZMKPF-BLART = GV_BLART. "####

  LS_ZMKPF-BLDAT = GV_BLDAT. "###

  LS_ZMKPF-BUDAT = GV_BUDAT. "###



"4. ### ### ##

  CLEAR : LV_ZEILE.



  LOOP AT GT_ALV INTO GS_ALV WHERE CHECK = 'X'.

    ADD 1 TO LV_ZEILE. "### ## ##.



    CLEAR : LS_ZMSEG.

    LS_ZMSEG-MBLNR = LV_MBLNR. "######

    LS_ZMSEG-MJAHR = LS_ZMKPF-MJAHR. "####

    LS_ZMSEG-ZEILE = LV_ZEILE. "#####



    LS_ZMSEG-MATNR = GS_ALV-MATNR. "####

    LS_ZMSEG-WERKS = GS_ALV-WERKS. "###

    LS_ZMSEG-LGORT = GS_ALV-LGORT. "####

    LS_ZMSEG-LIFNR = GS_ALV-LIFNR. "#####

    LS_ZMSEG-WAERS = GS_ALV-WAERS. "###

    LS_ZMSEG-MENGE = GS_ALV-MENGE_C. "######

    LS_ZMSEG-MEINS = GS_ALV-MEINS. "##

    LS_ZMSEG-EBELN = GS_ALV-EBELN. "######

    LS_ZMSEG-BUKRS = GS_ALV-BUKRS. "####



    LS_ZMSEG-GJAHR = LS_ZMKPF-MJAHR. "####

    LS_ZMSEG-BELNR = LV_MBLNR. "####

    LS_ZMSEG-SHKZG = 'S'. "###(## s# ####)



    LS_ZMSEG-DMBTR = GS_ALV-MENGE_C * GS_ALV-STPRS. "##

    LS_ZMSEG-BWART = '101'. "####



    APPEND LS_ZMSEG TO LT_ZMSEG.



"5. EKPO #### ##

    "key# ####

    SELECT SINGLE * FROM ZEKPO_15 INTO LS_EKPO_UPD

    WHERE EBELN = GS_ALV-EBELN

    AND EBELP = GS_ALV-EBELP.



    IF SY-SUBRC = 0.

      LS_EKPO_UPD-WEMNG = LS_EKPO_UPD-WEMNG + GS_ALV-MENGE_C.



      "#### ### ##

      IF LS_EKPO_UPD-WEMNG >= LS_EKPO_UPD-MENGE.

        LS_EKPO_UPD-ELIKZ = 'X'.

      ENDIF.



      APPEND LS_EKPO_UPD TO LT_EKPO_UPD.

    ENDIF.



    "+ ##### #### ##

    SELECT SINGLE * FROM ZMAT_15 INTO LS_ZMAT

      WHERE ZMATNR = GS_ALV-MATNR

      AND ZWERKS = GS_ALV-WERKS

      AND ZLGORT = GS_ALV-LGORT.



    IF SY-SUBRC = 0.

      LS_ZMAT-MENGE = LS_ZMAT-MENGE + GS_ALV-MENGE_C.



      MODIFY ZMAT_15 FROM LS_ZMAT.



      IF SY-SUBRC <> 0.

        ROLLBACK WORK.

        MESSAGE '##### #### # ## ##' TYPE 'E'.

        EXIT.

      ENDIF.

    ELSE. "#### ## ## #####"

      ROLLBACK WORK.

      MESSAGE '#### ## ##### #####.' TYPE 'E'.

      EXIT.

    ENDIF.

  ENDLOOP.







"6. DB## ##

  "## ##

  INSERT ZMKPF_15 FROM LS_ZMKPF.

  IF SY-SUBRC <> 0.

    ROLLBACK WORK.

    MESSAGE '## ## # ## ##' TYPE 'E'.

    EXIT.

  ENDIF.



  "### ##

  INSERT ZMSEG_15 FROM TABLE LT_ZMSEG.

  IF SY-SUBRC <> 0.

    ROLLBACK WORK.

    MESSAGE '### ## # ## ##' TYPE 'E'.

    EXIT.

  ENDIF.



  IF LT_EKPO_UPD IS NOT INITIAL.

    UPDATE ZEKPO_15 FROM TABLE LT_EKPO_UPD. "KEY # #### ## ####

    IF SY-SUBRC <> 0.

      ROLLBACK WORK.

      MESSAGE '#### #### # ## ##' TYPE 'E'.

      EXIT.

    ENDIF.

  ENDIF.



"7. ####

  COMMIT WORK AND WAIT.

  MESSAGE |#### #######. { LV_MBLNR }## #######| TYPE 'S'.



"8. PO#### ## #### (#### 'X'## ## ###)

  PERFORM GET_PO.

  PERFORM REFRESH.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_MBLNR

*&---------------------------------------------------------------------*

*       #### ## (snro X)

*----------------------------------------------------------------------*

*      <--P_LV_MBLNR  text

*----------------------------------------------------------------------*




FORM CREATE_MBLNR  CHANGING P_LV_MBLNR.

"######(MBLNR) ##

  SELECT SINGLE MAX( MBLNR ) FROM ZMKPF_15 INTO P_LV_MBLNR.

  IF P_LV_MBLNR IS INITIAL.

    P_LV_MBLNR = '5000000000'. "### ##

  ELSE.

    P_LV_MBLNR = P_LV_MBLNR + 1.

  ENDIF.

ENDFORM.