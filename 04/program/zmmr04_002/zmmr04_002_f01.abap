
*&---------------------------------------------------------------------*

*&  Include           ZMMR04_002_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_SCREEN

*&---------------------------------------------------------------------*




FORM SET_SCREEN .

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.      " ###

      IF P_RD1 = 'X'.

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ELSEIF SCREEN-GROUP1 = 'M2'.  " PO##

      IF P_RD1 = 'X'.

        SCREEN-ACTIVE = '0'.

      ELSE.

        SCREEN-ACTIVE = '1'.

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

  IF P_LIFNR IS INITIAL OR P_BUKRS IS INITIAL

    OR ( P_RD1 = 'X' AND P_BEDAT IS INITIAL )

    OR ( P_RD2 = 'X' AND P_EBELN IS INITIAL ).

    MESSAGE I000.

    STOP.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_VENDOR_EXIST

*&---------------------------------------------------------------------*




FORM CHECK_VENDOR_EXIST .

  DATA LS_ZLFA1 TYPE ZLFA1_04.



  SELECT SINGLE * FROM ZLFA1_04

    INTO CORRESPONDING FIELDS OF LS_ZLFA1

    WHERE LIFNR = P_LIFNR.



  IF SY-SUBRC <> 0.

    MESSAGE I004.

    STOP.

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

  GS_FIELDCAT-FIELDNAME = 'EBELP'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZMATNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZMATNAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-OUTPUTLEN = '16'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-SCRTEXT_M = 'PO##'.

  GS_FIELDCAT-EDIT = 'X'.




*  GS_FIELDCAT-NO_ZERO = 'X'.




  GS_FIELDCAT-DECIMALS = '3'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'STPRS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-EDIT = 'X'.




*  GS_FIELDCAT-NO_ZERO = 'X'.




  GS_FIELDCAT-DECIMALS = '2'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZMWSKZ'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'PRDAT'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-OUTPUTLEN = '11'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZWERKS'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZLGORT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*




FORM ALV_LAYOUT .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-SEL_MODE = 'D'. " ###, ### # ### ##



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

*&      Form  ALV_HANDLER_DATA_CHANGED

*&---------------------------------------------------------------------*




FORM ALV_HANDLER_DATA_CHANGED  USING    P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                        P_ONF4

                                        P_ONF4_BEFORE

                                        P_ONF4_AFTER

                                        P_UCOMM.

  DATA LS_CANCEL.

  DATA LS_MODI TYPE LVC_S_MODI.

  DATA LS_MODI2 TYPE LVC_S_MODI.

  DATA LS_ZEDT04_200 TYPE ZEDT04_200.

  DATA LV_ZMATNR LIKE GS_PO-ZMATNR.

  DATA lv_rowcount TYPE i.



  DESCRIBE TABLE GT_PO LINES lv_rowcount. " ## ALV ### ##



  LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.

    " ## # ## : ## row # ## row ## ### ## ##

    IF LS_MODI-ROW_ID > lv_rowcount.

      CONTINUE.

    ENDIF.



    CASE LS_MODI-FIELDNAME.

      WHEN 'ZMATNR'.

        " #### : ###### ## ## #### #####

        SELECT SINGLE * FROM ZEDT04_200

          INTO CORRESPONDING FIELDS OF LS_ZEDT04_200

          WHERE ZMATNR = LS_MODI-VALUE.



        IF SY-SUBRC <> 0.

          MESSAGE I005.

          LS_CANCEL = 'X'.

        ENDIF.

      WHEN 'PRDAT'.

        " ### : ##### ### ### #### ##

        IF LS_MODI-VALUE < P_BEDAT.

          MESSAGE I006.

          LS_CANCEL = 'X'.

        ENDIF.

      WHEN 'ZWERKS' OR 'ZLGORT'.

        " ###, #### : ## ### ## ##### ### ##

        READ TABLE P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI2  " ##### ## #### ### ##

           WITH KEY row_id    = LS_MODI-ROW_ID

                    fieldname = 'ZMATNR'.



        IF sy-subrc = 0.

          LV_ZMATNR = LS_MODI2-value.  " ## ##### #

        ELSE.

          " ## ## ## ## ALV ### ##

          CLEAR GS_PO.

          READ TABLE GT_PO INTO GS_PO INDEX LS_MODI-ROW_ID.

          LV_ZMATNR = GS_PO-ZMATNR.

        ENDIF.



        IF LV_ZMATNR IS INITIAL.  " #### ### ## ##

          MESSAGE '##### ## #####.' TYPE 'I'.

          LS_CANCEL = 'X'.

        ELSE. " ###### ### ## # ##

          SELECT SINGLE * FROM ZEDT04_200

            INTO CORRESPONDING FIELDS OF LS_ZEDT04_200

            WHERE ZMATNR = GS_PO-ZMATNR.



          IF ( LS_MODI-FIELDNAME = 'ZWERKS' AND LS_ZEDT04_200-ZWERKS <> LS_MODI-VALUE )

            OR ( LS_MODI-FIELDNAME = 'ZLGORT' AND LS_ZEDT04_200-ZLGORT <> LS_MODI-VALUE ).

            MESSAGE I007.

            LS_CANCEL = 'X'.

          ENDIF.

        ENDIF.

    ENDCASE.



    " ## ### # # ###

    IF LS_CANCEL = 'X'.

      CALL METHOD P_DATA_CHANGED->MODIFY_CELL  " # # ###

              EXPORTING

                I_ROW_ID    = LS_MODI-ROW_ID

                I_FIELDNAME = LS_MODI-FIELDNAME

                I_VALUE     = ''.

      LS_CANCEL = ''.

    ENDIF.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DATA_CHANGED_FINISHED

*&---------------------------------------------------------------------*




FORM ALV_DATA_CHANGED_FINISHED  USING    P_MODIFIED

                                         PT_GOOD_CELLS TYPE LVC_T_MODI.

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

*&      Form  ADD_ROW

*&---------------------------------------------------------------------*




FORM ADD_ROW .

  DATA LV_LINE TYPE I.



  CLEAR GS_PO.                        " # # ##

  DESCRIBE TABLE GT_PO LINES LV_LINE. " ####### #### ## ## # ##

  GS_PO-EBELP = ( LV_LINE + 1 ) * 10. " ## # ##

  APPEND GS_PO TO GT_PO.              " # ##



  PERFORM REFRESH.  " ####

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DELETE_ROW

*&---------------------------------------------------------------------*




FORM DELETE_ROW .

  DATA : LS_INDEX_ROWS TYPE LVC_S_ROW,

         LT_INDEX_ROWS TYPE LVC_T_ROW.



  " ### # ### ##

  CALL METHOD GC_GRID->GET_SELECTED_ROWS

    IMPORTING

      ET_INDEX_ROWS = LT_INDEX_ROWS.



  " ### ## MARK ##

  LOOP AT LT_INDEX_ROWS INTO LS_INDEX_ROWS.

    CLEAR GS_PO.

    READ TABLE GT_PO INTO GS_PO INDEX LS_INDEX_ROWS-INDEX.

    IF SY-SUBRC = 0.

      GS_PO-MARK = 'X'.

      MODIFY GT_PO FROM GS_PO INDEX LS_INDEX_ROWS-INDEX TRANSPORTING MARK.

    ENDIF.

  ENDLOOP.



  " MARK ### # ##

  DELETE GT_PO WHERE MARK = 'X'.



  " ## ## ###

  LOOP AT GT_PO INTO GS_PO.

    GS_PO-EBELP = SY-TABIX * 10.

    MODIFY GT_PO FROM GS_PO INDEX SY-TABIX TRANSPORTING EBELP.

  ENDLOOP.



  " ####

  PERFORM REFRESH.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_DATA

*&---------------------------------------------------------------------*




FORM SAVE_DATA .

  DATA LS_ZEKKO04 TYPE ZEKKO04.

  DATA LS_ZEKPO04 TYPE ZEKPO04.



  " 1. #### ## ##

  CALL FUNCTION 'NUMBER_GET_NEXT'   " PO## ## ####

      EXPORTING

        NR_RANGE_NR                   = '2'

        OBJECT                        = 'ZSSU04'

      IMPORTING

        NUMBER                        = LS_ZEKKO04-EBELN.



  LS_ZEKKO04-BUKRS = P_BUKRS. " ####

  LS_ZEKKO04-LIFNR = P_LIFNR. " ###

  LS_ZEKKO04-BEDAT = P_BEDAT. " ###

  SELECT SINGLE EKGRP EKORG WAERS FROM ZLFM1_04 " ####, ####, ##

    INTO ( LS_ZEKKO04-EKGRP, LS_ZEKKO04-EKORG , LS_ZEKKO04-WAERS )

    WHERE LIFNR = P_LIFNR.



  INSERT INTO ZEKKO04 VALUES LS_ZEKKO04.



  " 2. #### ##### ##

  CLEAR : GS_PO, LS_ZEKPO04.

  LOOP AT GT_PO INTO GS_PO.

    LS_ZEKPO04-EBELN = LS_ZEKKO04-EBELN.

    MOVE-CORRESPONDING GS_PO TO LS_ZEKPO04.



    INSERT INTO ZEKPO04 VALUES LS_ZEKPO04.



    CLEAR : GS_PO, LS_ZEKPO04.

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

*&      Form  SELECT_DATA

*&---------------------------------------------------------------------*




FORM SELECT_DATA .

  CLEAR : GT_PO.



  SELECT

    A~EBELP,       " ##

    A~ZMATNR,      " ####

    A~ZMATNAME,    " ###

    A~MENGE,       " PO##

    A~STPRS,       " ##

    A~MEINS,       " ##S

    B~WAERS,       " ##

    A~ZMWSKZ,      " ####

    A~PRDAT,       " ###

    A~ZWERKS,      " ###

    A~ZLGORT      " ####

  FROM ZEKPO04 AS A

    LEFT OUTER JOIN ZEKKO04 AS B

      ON A~EBELN = B~EBELN

  INTO CORRESPONDING FIELDS OF TABLE @GT_PO

  WHERE B~LIFNR = @P_LIFNR

    AND B~BUKRS = @P_BUKRS

    AND A~EBELN = @P_EBELN.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_INIT

*&---------------------------------------------------------------------*




FORM SET_INIT .

  P_BEDAT = SY-DATUM.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_0200

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG_0200 .

CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'EBELP'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZMATNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZMATNAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-OUTPUTLEN = '16'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-SCRTEXT_M = 'PO##'.




*  GS_FIELDCAT-NO_ZERO = 'X'.




  GS_FIELDCAT-DECIMALS = '3'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'STPRS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.




*  GS_FIELDCAT-NO_ZERO = 'X'.




  GS_FIELDCAT-DECIMALS = '2'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZMWSKZ'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'PRDAT'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-OUTPUTLEN = '11'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZWERKS'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZLGORT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.